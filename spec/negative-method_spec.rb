require 'lib/negative_method'

class TestClass
  include NegativeMethod
end

describe NegativeMethod do
  it "should raise error if the method is undefined" do
    test = TestClass.new
    lambda { test.hasNotBeenDefined }.should raise_error
  end

  it "should raise error if the positive method is undefined" do
    test = TestClass.new
    lambda { test.not_defined }.should raise_error
  end

  it "should negate method start with 'not_'" do
    test = TestClass.new
    test.should_receive(:valid).and_return(true)
    test.not_valid.should == false
  end

  it "should negate method with '_not_' in the middle of the method name" do
    test = TestClass.new
    test.should_receive(:is_valid).and_return(true)
    test.is_not_valid.should == false
  end

  it "should negate method with '_not' at the end" do
    test = TestClass.new
    test.should_receive(:is).with('valid').and_return(true)
    test.is_not('valid').should == false
  end

  it "should negate method with '_not?' at the end" do
    test = TestClass.new
    test.should_receive(:has?).with('element').and_return(true)
    test.has_not?('element').should == false
  end
end
