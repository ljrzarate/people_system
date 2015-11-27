require 'test_helper'

class PeopleControllerTest < ActionController::TestCase
  def setup
    20.times do
      FactoryGirl.create(:person)
    end
    @person = Person.first
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_includes @response.body, 'List of people in the system'
  end

  test "should assigns @people to see people the system" do
    get :index
    assert_not_nil assigns(:people)
  end

  test "should get show" do
    get :show, {id: @person.id}
    assert_response :success
  end

  test "should render information for a single person" do
    get :show, {id: @person.id}
    assert_includes @response.body, "#{@person.first_name}"
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should render form to add a person" do
    get :new
    assert_template layout: "layouts/application", partial: "_form"
  end

  test "should create a person" do
    assert_difference ('Person.count') do
      post :create, person: FactoryGirl.attributes_for(:person)
    end
    assert_redirected_to person_path(assigns(:person))
    assert_equal 'Person saved successfuly', flash[:notice]
  end

  test "should open a form to edit a person" do
    get :edit, {id: @person.id}
    assert_includes @response.body, "#{@person.first_name}"
  end

  test "should render form partial to edit a person" do

    get :edit, {id: @person.id}
    assert_template layout: "layouts/application", partial: "_form"
  end

  test "should update a person information" do
    put :update, id: @person.id, person: FactoryGirl.attributes_for(:person, first_name: "new_name")
    @person.reload
    assert_equal "new_name", @person.first_name
    assert_redirected_to person_path(assigns(:person))
    assert_equal 'Person saved successfuly', flash[:notice]
  end

  test "should destroy a person" do
    assert_difference('Person.count', -1) do
      delete :destroy, id: @person.id
    end
    assert_redirected_to people_path(assigns(:people))
    assert_equal 'Person deleted successfuly', flash[:notice]
  end

end
