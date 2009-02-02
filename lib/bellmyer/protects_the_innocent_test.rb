module Bellmyer
  module ProtectsTheInnocentTest
    extend Bellmyer::ProtectsTheInnocent
    
    def self.included(base)
      base.extend ClassMethods
    end
    
    module ClassMethods
      def should_protect_the_innocent(fields={})
        
        context "when protecting the innocent" do
          setup do
            self.class.to_s.underscore =~ /^(.*)_test$/
            @klass = eval $1.camelize   
          end
          
          fields.each do |field, type|
            should "change the #{field} field" do
              instance = @klass.new
              instance.protect_only field, type
              old = instance.send(field)
              assert old
              
              instance.protect_the_innocent
              
              assert_not_equal instance.send(field), old
            end
          end
        end
      end
    end
  end
end
