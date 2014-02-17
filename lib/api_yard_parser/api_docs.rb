module ApiYardParser
  class ApiDocs

    attr_accessor :controller_dirs

    def self.get_all
      @controller_dirs = ["#{Rails.root}/app/controllers"]
      files = []
      @controller_dirs.each do |dir|
        files += Dir["#{dir}/**/*.rb"]
      end
      content = []
      #files = ["#{Rails.root}/app/controllers/clients_controller.rb"] #TEMP!!!!!!!!

      files.each do |file|
        content += [ApiDocs.new(file).contents]
      end
      content
    end

    def initialize(file)
      @file = file
    end

    def contents
      @file_content = File.new(@file).read
      name = @file_content.scan(/class\s(\S+)Controller/ )
      name = (name.count > 0) ? name[0][0] : ""
      controller = ApiControllers.new(name)
      comments.each do |my_method|
        controller.add_route ApiComment.new(my_method) unless my_method =~ /^# -\*- coding: UTF-8 -\*-/ 
      end
      controller

      # [
      #   {
      #     :name => "clients",
      #     :routes => [
      #       {
      #         :description => "Show information about client by :id",
      #         :url => "/clients/:id",
      #         :params => [
      #           {
      #             :name => "id",
      #             :type => "String",
      #             :description => "",
      #           },
      #         ],
      #         :returns => [
      #           '{json { :id => x , :name => "John", :email => "john@teste.com"}'
      #         ],
      #         :example => 'curl -l -X GET "http://api.com.br/clients/1" ',
      #         :notes=>[],
      #       }
      #     ]
      #   }
      # ]
    end

    private

    def comments
      my_methods = []
      same = false
      method = ""
      inside_def = false
      inside_count = 0
      
      @file_content.split("\n").each do |line|
        next if line =~ /# TODO:/

        if line=~/^(\s+#|#\s)(.+|)/ && inside_def == false
          if same==false
            same = true
          end
          method += line + "\n" if same == true
        else
          if same == true
            my_methods.append(method)
            method = ""
            same =false
          end
        end

        if line.scan(/(^\s+def)/).count > 0
          inside_def = true
          inside_count = line.scan(/(^\s+def)/)[0][0].length
        end
        if line.scan(/(^\s+end)/).count > 0 && inside_count == line.scan(/(^\s+end)/)[0][0].length && inside_def ==  true
          inside_def = false
        end

      end
      my_methods
    end



  end
end