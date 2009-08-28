require 'bellmyer/protects_the_innocent'
ActiveRecord::Base.send(:include, Bellmyer::ProtectsTheInnocent)
Test::Unit::TestCase.send(:include, Bellmyer::ProtectsTheInnocentTest)
