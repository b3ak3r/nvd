require_relative '../../test_helper'

describe Nvd::Base do
  subject { Nvd::Base.new("D:\\nvdcve-2.0-2015.xml\\nvdcve-2.0-2015.xml") }

  it "must load xml file" do
    subject.parse()
    true
  end
end
