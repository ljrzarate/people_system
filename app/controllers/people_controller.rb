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
    def load_people
      @people = people_scope
    end

    def load_person
      @person ||= people_scope.find(params[:id])
    end

    def build_person
      @person ||= people_scope.build
      @person.attributes = person_params
    end

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

    def person_params
      person_params = params[:person]
      person_params ? person_params.permit(:first_name, :last_name, :email, :bio, :gender, :job, :birthdate, :picture) : {}
    end

    def people_scope
      Person.all.order_by_full_name
    end
end
