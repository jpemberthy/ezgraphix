require 'rubygems'
require 'spec'
require File.join(File.dirname(__FILE__) + '/../lib/ezgraphix/ezgraphix')

include Ezgraphix

describe Graphic do
  it "should have false tests" do
    false.should eql(false)
  end
  
end
