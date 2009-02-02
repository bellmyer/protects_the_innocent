namespace :protect do
  desc "protect all proprietary data."
  task :all => :environment do
    Dir.glob(RAILS_ROOT + '/app/models/*.rb').each { |file| require file }
    models = Object.subclasses_of(ActiveRecord::Base).select{|x| x.instance_methods.include?('protect_the_innocent')}

    models.each do |m|
      print "\nprotecting #{m.count} #{m.to_s.underscore} records"
      m.protect_the_innocent('.')
    end
    
    puts
  end
  
  desc "protect only the comma-separated models in the MODELS environment variable"
  task :only => :environment do
    models = ENV['MODELS'].split(/,/).map{|x| eval(x.camelize)}

    models.each do |m|
      print "\nprotecting #{m.count} #{m.to_s.underscore} records"
      m.protect_the_innocent('.')
    end
    
    puts
  end
  
  desc "protect all protected models except the comma-separated list in the MODELS environment variable"
  task :except => :environment do
    exceptions = ENV['MODELS'].split(/,/).map{|x| eval(x.camelize)}
    Dir.glob(RAILS_ROOT + '/app/models/*.rb').each { |file| require file }
    models = Object.subclasses_of(ActiveRecord::Base).select{|x| x.instance_methods.include?('protect_the_innocent')}.reject{|x| exceptions.include?(x)}

    models.each do |m|
      print "\nprotecting #{m.count} #{m.to_s.underscore} records"
      m.protect_the_innocent('.')
    end
    
    puts
  end
  
#  Sometimes, if data in one table depends on data in another, you may 
#  want to force the order in which models are protected.  You can add      
#  something like this to your own rake library:                            
#  
#  namespace :protect do
#    desc "Running protection in this order: Model1, Model3, Model2"
#    task :sorted => :environment do
#      models = [Model1, Model3, Model2]
#      models.each do |m|
#        print "\nprotecting #{m.count} #{m.to_s_underscore} records"
#        m.protect_the_innocent('.')
#      end
#    end
#  end
end
