require "spec_helper"

describe AppointmentsController do
  describe "routing" do

    it "routes to #index" do
      get("sam/appointments").should route_to("appointments#index", :name => 'sam')
    end

    it "routes to #new" do
      get("sam/appointments/new").should route_to("appointments#new", :name => 'sam')
    end

    it "routes to #show" do
      get("sam/appointments/1").should route_to("appointments#show", :id => "1", :name => 'sam')
    end

    it "routes to #edit" do
      get("sam/appointments/1/edit").should route_to("appointments#edit", :id => "1", :name => 'sam')
    end

    it "routes to #create" do
      post("sam/appointments").should route_to("appointments#create", :name => 'sam')
    end

    it "routes to #update" do
      put("sam/appointments/1").should route_to("appointments#update", :id => "1", :name => 'sam')
    end

    it "routes to #destroy" do
      delete("sam/appointments/1").should route_to("appointments#destroy", :id => "1", :name => 'sam')
    end

  end
end
