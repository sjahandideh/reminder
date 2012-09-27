class StaffsController < ApplicationController
  def index
    @staffs = Staff.all
  end

  def show
    @staff = Staff.find(params[:id])
  end

  def new
    @staff = Staff.new
  end

  def edit
    @staff = Staff.find(params[:id])
  end

  def create
    @staff = Staff.new(params[:staff])

    if @staff.save
      redirect_to @staff, notice: 'Staff was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @staff = Staff.find(params[:id])

    if @staff.update_attributes(params[:staff])
      redirect_to @staff, notice: 'Staff was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @staff = Staff.find(params[:id])
    @staff.destroy

    redirect_to staffs_url
  end
end
