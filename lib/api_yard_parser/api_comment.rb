module ApiYardParser
  class ApiComment
    attr_reader :url, :type, :params, :returns, :description, :example, :notes

    def initialize(text)
      @text = text
      @params = []
      @returns = []
      @notes = []
      parse
    end

    def parse
      items = @text.split("# @")
      parse_text(items[0])
      items.each do |item|
        res = item.scan(/^(\S+)\s/)
        if res.count > 0
          type = res[0][0]
          send("parse_#{type}",item) if ["url","type","param","return","note"].index(type)
          parse_auto_example if type == "auto-example"
        end
      end
      @type = "GET" if @type.blank?
    end

    def parse_text(text)
      lines = ""
      text.split("\n").each{|line| lines += line.sub(/^\s+#/,"")}
      @description = lines.strip
    end

    def parse_url(text)
      @url = text.split[1]
    end

    def parse_type(text)
      @type = text.split[1]
    end

    def parse_param(text)
      res = text.scan(/^\S+\s+\[(\S+)\]\s+(\S+)(\s+->|\s+)(.+)/)[0]
      if !res.nil?
        @params += [{:type => res[0], :name=>res[1], :description=>res[3] } ]
        return true
      end

      res = text.scan(/^\S+\s+\[(\S+)\]/)[0]
      if !res.nil?
        @params += [{:type => res[0], :name=>" ", :description=>" " } ]
      end
    end

    def parse_return(text)
      lines = ""
      text.split("\n").each{|line| lines += line.sub(/^\s+#/,"") + "\n"}
      res = lines.scan(/^\S+\s+\[(\S+)\]\s+([a-zA-Z\s\d]+)-(.+)\n([\s\{:\S\}]*)/)
      if !res.nil? && !res[0].nil? && res[0][3].strip != ""
        @returns += [{:type => res[0][0], :name=>res[0][1], :description=>res[0][2], :body => res[0][3] } ]
        return
      end

      res = lines.scan(/^\S+\s+\[(\S+)\]\s+([a-zA-Z\s\d]+)-(.+)/)
      if !res.nil? && res.count > 0
        @returns += [{:type => res[0][0], :name=>res[0][1], :description=>res[0][2],:body => nil} ] if !res.nil?
      end
    end

    def parse_note(text)
      lines = ""
      text.split("\n").each{|line| lines += line.sub(/^\s+#/,"") + "\n"}
      res = lines.scan(/(GET|POST|PUT|DELETE).+\n+\s+(http.+)/)[0]
      if !res.nil? 
        @type = res[0]
        @url = res[1]
      end
      @notes += [lines]
    end

    def parse_auto_example
    end

  end
end