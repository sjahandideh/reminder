require 'spec_helper'

describe Appointment do
  let(:sam){ create(:staff, :name => 'sam', :payroll_number => 1, :email => 'sam@sam.com') }

  context "validations" do
    context "datetime" do
      it "saves an appointment with datetime in the future" do
        lambda{ create(:appointment, :staff => sam, :message => 'remind me', :datetime => Date.tomorrow) }.should_not raise_error(ActiveRecord::RecordInvalid)
      end

      it "raises an exception for an appointment with datetime in the past" do
        lambda{ create(:appointment, :staff => sam, :message => 'remind me', :datetime => Date.yesterday) }.should raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context "message" do
      it "saves an appointment with non-blank message" do
        lambda{ create(:appointment, :staff => sam, :message => 'remind me', :datetime => Date.tomorrow) }.should_not raise_error(ActiveRecord::RecordInvalid)
      end

      it "raises an exception for an appointment with blank messge" do
        lambda{ create(:appointment, :staff => sam, :message => '', :datetime => Date.tomorrow) }.should raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  context "old" do
    it "returns all appointments with the date passed" do
      sent = build(:appointment, :staff => sam, :datetime => 1.day.ago, :message => 'remind me')
      sent.should_receive(:datetime_cannot_be_in_the_past).and_return true
      sent.save
      sam.appointments.old.should include(sent)
    end

    it "does not return newer appointments" do
      upcomming = create(:appointment, :staff => sam, :datetime => 1.day.from_now, :message => 'remind me')
      sam.appointments.old.should_not include(upcomming)
    end
  end

  context "staff_name" do
    let(:reminder){ reminder = create(:appointment, :staff => sam, :datetime => 1.day.from_now, :message => 'remind me') }

    it 'returns staff name when valid' do
      reminder.staff_name.should == sam.name
    end

    it 'returns nil when staff invalid' do
      reminder.staff = nil
      reminder.staff_name.should be_nil
    end
  end

  context "date" do
    let(:reminder){ reminder = create(:appointment, :staff => sam, :datetime => 1.day.from_now, :message => 'remind me') }

    it "returns date when datetime is valid" do
      reminder.date.should == Date.tomorrow
    end

    it "returns nil when datetime is invalid" do
      reminder.datetime = nil
      reminder.date.should be_nil
    end
  end

  context "summary" do
    let(:reminder){ reminder = create(:appointment, :staff => sam, :datetime => 1.day.from_now, :message => 'short') }

    it 'returns whole message if it is less than 10 characters' do
      reminder.summary.should == 'short'
    end

    it 'returns shortened message if it is more than 10 characters' do
      reminder.message = 'this is long message'
      reminder.summary.should == 'this is lo...'
    end

    it 'returns empty if it is blank' do
      reminder.message = nil
      reminder.summary.should be_blank
    end
  end
end
