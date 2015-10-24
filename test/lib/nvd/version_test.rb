require_relative '../../test_helper'

describe Nvd do
  it "must be defined" do
    Nvd::VERSION.wont_be_nil
  end
end
