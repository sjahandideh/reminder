class AppointmentsController < ApplicationController
  layout 'appointment'
  before_filter :set_current_staff

  def index
    @appointments = @staff.appointments
    @appointments_by_date = @appointments.group_by(&:date)
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
  end

  def show
    @appointment = @staff.appointments.find(params[:id])
  end

  def new
    @appointment = @staff.appointments.new
  end

  def edit
    @appointment = @staff.appointments.find(params[:id])
  end

  def create
    @appointment = @staff.appointments.new(params[:appointment])

    if @appointment.save
      redirect_to appointment_path(@staff_name, @appointment), :flash => { notice: 'Appointment was successfully created.' }
    else
      render action: "new"
    end
  end

  def update
    @appointment = @staff.appointments.find(params[:id])

    if @appointment.update_attributes(params[:appointment])
      redirect_to appointment_path(@staff_name, @appointment), :flash => { notice: 'Appointment was successfully updated.' }
    else
      render action: "edit"
    end
  end

  def destroy
    @appointment = @staff.appointments.find(params[:id])
    @appointment.destroy

    redirect_to appointments_url(@staff_name)
  end

  private

  def set_current_staff
    @staff = Staff.find_by_name params[:name]
    redirect_to root_path, :flash => { :error => "Invalid Staff!" } if @staff.blank?
    @staff_name = params[:name]
  end
end
