#using rspec 1.1.11
require 'rubygems'
require 'spec'
require File.join(File.dirname(__FILE__) + '/../lib/ezgraphix/ezgraphix')

include Ezgraphix

describe Graphic do
  
  before do
    @g = Graphic.new
  end
    
  it do
    @g.should be_an_instance_of(Graphic)
  end
  
  it do
    @g.should have(4).defaults
  end
  
end
