module MCSRV
  module SyntacticSugar

    def define_accessor(name, value=nil, access_mode=:public)
      attr_accessor name
      self.send access_mode, name
      self.send access_mode, "#{name}="
      original_method = instance_method(:initialize)
      define_method(:initialize) do |*args, &block|
        original_method.bind(self).call(*args, &block)
        self.send("#{name}=", value)
      end
    end

    def define_accessor!(name, value=nil, access_mode=:public)
      self.class.send(:attr_accessor, name)
      self.instance_variable_set("@#{name}", value)
    end

  end
end
