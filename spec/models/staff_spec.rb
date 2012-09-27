require 'spec_helper'

describe Staff do
  context "validations" do
    context "email" do
      it "saves a staff with valid email" do
        lambda{ create(:staff, :name => 'sam', :payroll_number => 1, :email => 'sam@sam.com') }.should_not raise_error(ActiveRecord::RecordInvalid)
      end

      it "raises an exception for a staff with invalid email" do
        lambda{ create(:staff, :name => 'sam', :payroll_number => 1, :email => 'invalid') }.should raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context "name" do
      it "saves a staff with uniq name" do
        lambda{ create(:staff, :name => 'sam', :payroll_number => 1, :email => 'sam@sam.com') }.should_not raise_error(ActiveRecord::RecordInvalid)
      end

      it "raises an exception for a staff without name" do
        lambda{ create(:staff, :name => nil, :payroll_number => 1, :email => 'sam@sam.com') }.should raise_error(ActiveRecord::RecordInvalid)
      end

      it "raises an exception for a staff with duplicate name" do
        create(:staff, :name => 'sam', :payroll_number => 1, :email => 'sam@sam.com')
        lambda{ create(:staff, :name => 'sam', :payroll_number => 1, :email => 'sam@sam.com') }.should raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context "payroll_number" do
      it "saves a staff with numeric payroll nubmer" do
        lambda{ create(:staff, :name => 'sam', :payroll_number => 1, :email => 'sam@sam.com') }.should_not raise_error(ActiveRecord::RecordInvalid)
      end

      it "raises an exception for a staff with non-numeric payroll number" do
        lambda{ create(:staff, :name => nil, :payroll_number => 's', :email => 'sam@sam.com') }.should raise_error(ActiveRecord::RecordInvalid)
      end

      it "raises an exception for a staff with nil payroll number" do
        lambda{ create(:staff, :name => nil, :payroll_number => nil, :email => 'sam@sam.com') }.should raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
