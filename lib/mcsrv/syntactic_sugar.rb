module MCSRV
  module SyntacticSugar

    def define_accessor(name, value=nil, access_mode=:public)
      attr_accessor name
      self.send access_mode, name
      self.send access_mode, "#{name}="
      original_method = instance_method(:initialize)
      define_method(:initialize) do |*args, &block|
        self.send("#{name}=", value)
        original_method.bind(self).call(*args, &block)
      end
    end

    def define_accessor!(name, value=nil, access_mode=:public)
      self.class.send(:attr_accessor, name)
      self.instance_variable_set("@#{name}", value) if self.instance_variable_get("@#{name}").nil?
      self.class.send(access_mode, name)
      self.class.send(access_mode, "#{name}=")
    end

  end
end
