module ActiveRecordEmbeddedDoc
  class Attribute < Struct.new(:parent, :coder, :value) # :nodoc:

    def unserialized_value(v = value)
      self.value = case v
                     when Hash, Array
                       coder.load(v, self)
                     when nil
                       nil
                     else
                       v.tap { |v| v.embedded_in = self if v.embedded_in.nil? }
                   end
    end

    def serialized_value
      coder.dump(value)
    end

  end
end