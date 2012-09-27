require 'spec_helper'

describe StaffsController do

  def valid_attributes
    {
      :name => 'sam',
      :payroll_number => 1,
      :email => 'sam@sam.me',
      :phone => '233421'
    }
  end

  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all staffs as @staffs" do
      staff = Staff.create! valid_attributes
      get :index, {}, valid_session
      assigns(:staffs).should eq([staff])
    end
  end

  describe "GET show" do
    it "assigns the requested staff as @staff" do
      staff = Staff.create! valid_attributes
      get :show, {:id => staff.to_param}, valid_session
      assigns(:staff).should eq(staff)
    end
  end

  describe "GET new" do
    it "assigns a new staff as @staff" do
      get :new, {}, valid_session
      assigns(:staff).should be_a_new(Staff)
    end
  end

  describe "GET edit" do
    it "assigns the requested staff as @staff" do
      staff = Staff.create! valid_attributes
      get :edit, {:id => staff.to_param}, valid_session
      assigns(:staff).should eq(staff)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Staff" do
        expect {
          post :create, {:staff => valid_attributes}, valid_session
        }.to change(Staff, :count).by(1)
      end

      it "assigns a newly created staff as @staff" do
        post :create, {:staff => valid_attributes}, valid_session
        assigns(:staff).should be_a(Staff)
        assigns(:staff).should be_persisted
      end

      it "redirects to the created staff" do
        post :create, {:staff => valid_attributes}, valid_session
        response.should redirect_to(Staff.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved staff as @staff" do
        # Trigger the behavior that occurs when invalid params are submitted
        Staff.any_instance.stub(:save).and_return(false)
        post :create, {:staff => {}}, valid_session
        assigns(:staff).should be_a_new(Staff)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Staff.any_instance.stub(:save).and_return(false)
        post :create, {:staff => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested staff" do
        staff = Staff.create! valid_attributes
        # Assuming there are no other staffs in the database, this
        # specifies that the Staff created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Staff.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => staff.to_param, :staff => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested staff as @staff" do
        staff = Staff.create! valid_attributes
        put :update, {:id => staff.to_param, :staff => valid_attributes}, valid_session
        assigns(:staff).should eq(staff)
      end

      it "redirects to the staff" do
        staff = Staff.create! valid_attributes
        put :update, {:id => staff.to_param, :staff => valid_attributes}, valid_session
        response.should redirect_to(staff)
      end
    end

    describe "with invalid params" do
      it "assigns the staff as @staff" do
        staff = Staff.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Staff.any_instance.stub(:save).and_return(false)
        put :update, {:id => staff.to_param, :staff => {}}, valid_session
        assigns(:staff).should eq(staff)
      end

      it "re-renders the 'edit' template" do
        staff = Staff.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Staff.any_instance.stub(:save).and_return(false)
        put :update, {:id => staff.to_param, :staff => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested staff" do
      staff = Staff.create! valid_attributes
      expect {
        delete :destroy, {:id => staff.to_param}, valid_session
      }.to change(Staff, :count).by(-1)
    end

    it "redirects to the staffs list" do
      staff = Staff.create! valid_attributes
      delete :destroy, {:id => staff.to_param}, valid_session
      response.should redirect_to(staffs_url)
    end
  end

end
