require 'spec_helper'

describe AppointmentsController do

  let!(:sam){ create(:staff, :name => 'sam', :payroll_number => 1, :email => 'sam@sam.com') }

  def valid_attributes
    {
      :message => 'remind me',
      :datetime => Date.tomorrow
    }
  end

  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all appointments as @appointments" do
      appointment = sam.appointments.create! valid_attributes
      get :index, {:name => 'sam'}, valid_session
      assigns(:appointments).should eq([appointment])
    end
  end

  describe "GET show" do
    it "assigns the requested appointment as @appointment" do
      appointment = sam.appointments.create! valid_attributes
      get :show, {:name => 'sam', :id => appointment.to_param}, valid_session
      assigns(:appointment).should eq(appointment)
    end
  end

  describe "GET new" do
    it "assigns a new appointment as @appointment" do
      get :new, {:name => 'sam'}, valid_session
      assigns(:appointment).should be_a_new(Appointment)
    end
  end

  describe "GET edit" do
    it "assigns the requested appointment as @appointment" do
      appointment = sam.appointments.create! valid_attributes
      get :edit, {:name => 'sam', :id => appointment.to_param}, valid_session
      assigns(:appointment).should eq(appointment)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Appointment" do
        expect {
          post :create, {:name => 'sam', :appointment => valid_attributes}, valid_session
        }.to change(Appointment, :count).by(1)
      end

      it "assigns a newly created appointment as @appointment" do
        post :create, {:name => 'sam', :appointment => valid_attributes}, valid_session
        assigns(:appointment).should be_a(Appointment)
        assigns(:appointment).should be_persisted
      end

      it "redirects to the created appointment" do
        post :create, {:name => 'sam', :appointment => valid_attributes}, valid_session
        response.should redirect_to(appointment_path('sam', Appointment.last))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved appointment as @appointment" do
        Appointment.any_instance.stub(:save).and_return(false)
        post :create, {:name => 'sam', :appointment => {}}, valid_session
        assigns(:appointment).should be_a_new(Appointment)
      end

      it "re-renders the 'new' template" do
        Appointment.any_instance.stub(:save).and_return(false)
        post :create, {:name => 'sam', :appointment => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested appointment" do
        appointment = sam.appointments.create! valid_attributes
        Appointment.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:name => 'sam', :id => appointment.to_param, :appointment => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested appointment as @appointment" do
        appointment = sam.appointments.create! valid_attributes
        put :update, {:name => 'sam', :id => appointment.to_param, :appointment => valid_attributes}, valid_session
        assigns(:appointment).should eq(appointment)
      end

      it "redirects to the appointment" do
        appointment = sam.appointments.create! valid_attributes
        put :update, {:name => 'sam', :id => appointment.to_param, :appointment => valid_attributes}, valid_session
        response.should redirect_to(appointment_url('sam'))
      end
    end

    describe "with invalid params" do
      it "assigns the appointment as @appointment" do
        appointment = sam.appointments.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Appointment.any_instance.stub(:save).and_return(false)
        put :update, {:name => 'sam', :id => appointment.to_param, :appointment => {}}, valid_session
        assigns(:appointment).should eq(appointment)
      end

      it "re-renders the 'edit' template" do
        appointment = sam.appointments.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Appointment.any_instance.stub(:save).and_return(false)
        put :update, {:name => 'sam', :id => appointment.to_param, :appointment => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested appointment" do
      appointment = sam.appointments.create! valid_attributes
      expect {
        delete :destroy, {:name => 'sam', :id => appointment.to_param}, valid_session
      }.to change(Appointment, :count).by(-1)
    end

    it "redirects to the appointments list" do
      appointment = sam.appointments.create! valid_attributes
      delete :destroy, {:name => 'sam', :id => appointment.to_param}, valid_session
      response.should redirect_to(appointments_url)
    end
  end

end
