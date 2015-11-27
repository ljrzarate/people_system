# This pattern in controllers is following the guides of Growing Rails Application Book
# this way the controller is as DRY as posible
class PeopleController < ApplicationController
  def index
    load_people
  end

  def show
    load_person
  end

  def new
    build_person
  end

  def create
    build_person
    save_person(perform_email: true) or render :new
  end

  def edit
    load_person
    build_person
  end

  def update
    load_person
    build_person
    save_person or render :edit
  end

  def destroy
    load_person
    @person.destroy
    DeletedPersonEmailJob.perform_later(name: @person.full_name, email: @person.email)
    flash[:notice] = "Person deleted successfuly"
    redirect_to people_path
  end

  private
    # Private: load the 'default' scope in an instace variable
    #
    # Returns the @people intance variable the 'default' scope
    # used on :index action
    def load_people
      @people = people_scope
    end

    # Private: Take care of load a person even if it is new or not
    #
    # Returns the @person intance variable for existing record with the 'default' scope
    # used on :show, :edit, :update, :destroy actions
    def load_person
      @person ||= people_scope.find(params[:id])
    end

    # Private: Take care of build a person even if it is new or not
    #
    # Returns the @person instance variable for existing or new record
    # to use in :new, :create, :edit, :update actions
    def build_person
      @person ||= people_scope.build
      @person.attributes = person_params
    end

    # Private: Take care of saving a person even if it is new or not
    #
    # Returns redirect to the person profile if saved correcty otherwise will show a flash with errors
    # used on :create and :update actions
    def save_person(perform_email: false)
      if @person.save
        flash[:notice] = "Person saved successfuly"
        NewPersonEmailJob.perform_later(@person.id) if perform_email
        redirect_to @person
      else
        flash[:error] = @person.errors.full_messages.to_sentence
        false
      end
    end

    # Private: Returns attributes that can be set through the update and create actions
    #
    # Returns Hash with the Person attributes or empty
    def person_params
      person_params = params[:person]
      person_params ? person_params.permit(:first_name, :last_name, :email, :bio, :gender, :job, :birthdate, :picture) : {}
    end

    # Private: Get the 'default' scope for this controller,
    #          over this scope all the queries will be executed
    #
    # Returns ActiveRecordRelation with the Person entries
    def people_scope
      Person.all.order_by_full_name
    end
end
