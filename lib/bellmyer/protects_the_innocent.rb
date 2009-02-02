require 'faker'

module Bellmyer
  module ProtectsTheInnocent
    def self.included(base)
      base.extend InnocentMethods
    end
    
    module InnocentMethods
      def protects_the_innocent(fields={})
        unless included_modules.include? InstanceMethods
          class_inheritable_accessor :fields
          extend ClassMethods
          include InstanceMethods
        end
        
        self.fields = fields
      end
    end
    
    module ClassMethods
      def protect_the_innocent(pacifier='')
        find(:all).each_with_index do |model_instance, index|
          if (index % 50) == 0
            print pacifier
            STDOUT.flush
          end
          
          model_instance.protect_the_innocent
          model_instance.save_without_validation
        end
      end
      
      protected

      def protect_company;      Faker::Company.name; end
      def protect_catch_phrase; Faker::Company.catch_phrase; end
      def protect_bs;           Faker::Company.bs; end
      
      def protect_name;       Faker::Name.name; end
      def protect_first_name; Faker::Name.first_name; end
      def protect_last_name;  Faker::Name.last_name; end
      
      def protect_username; Faker::Internet.user_name; end
      def protect_email;    Faker::Internet.email; end
      def protect_phone;    Faker::PhoneNumber.phone_number; end
      
      def protect_ip;     "10.#{rand(256)}.#{rand(256)}.#{rand(256)}"; end
      def protect_domain; "#{Faker::Internet.domain_word}.#{Faker::Internet.domain_name}"; end

      def protect_address;      Faker::Address.street_address; end
      def protect_city;         Faker::Address.city; end
      def protect_state;        Faker::Address.us_state; end      
      def protect_state_abbr;   Faker::Address.us_state_abbr; end
      def protect_zip;          Faker::Address.zip_code; end     

      def protect_word;       Faker::Lorem.words(1).first; end
      def protect_words;      Faker::Lorem.words.join(' '); end
      def protect_string;     Faker::Lorem.words.join(' '); end
      def protect_sentence;   Faker::Lorem.sentence; end
      def protect_sentences;  Faker::Lorem.sentences.join('  '); end
      def protect_paragraph;  Faker::Lorem.paragraph; end
      def protect_text;       Faker::Lorem.paragraph; end
      def protect_paragraphs; Faker::Lorem.paragraphs.join("\n\n"); end
      
      def protect_nil;    nil; end

      def protect_number(num)
        return num if num.nil? || num == 0
        new_num = num
        
        # new number cannot equal the old, or we have no way of testing absolutely #
        while new_num == num
          if num > 10 || num < -10
            x = num + (num * rand * 0.5 - 0.25)
            new_num = num.is_a?(Integer) ? Integer(x) : x
          else
            new_num = num * rand(5)
          end
        end
        
        new_num
      end
    end
    
    module InstanceMethods
      def protect_the_innocent
        fields.each do |field, type|
          if type == :number
            self.attributes = {field => self.class.send("protect_#{type}", self.send(field))}
          elsif type.is_a?(Symbol)
            self.attributes = {field => self.class.send("protect_#{type}")}
          elsif type.is_a?(Proc)
            self.attributes = {field=>type.call(self)}
          else
            self.attributes = {field=>type}
          end
        end
      end
    end
  end
end
