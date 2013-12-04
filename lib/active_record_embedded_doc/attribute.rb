module ActiveRecordEmbeddedDoc
  class Attribute < Struct.new(:parent, :coder, :value, :state) # :nodoc:

    def unserialized_value(v = value)
      state == :serialized ? unserialize(v) : coder.load(v, self)
    end

    def serialized_value
      state == :unserialized ? serialize : value
    end

    def unserialize(v)
      self.state = :unserialized
      self.value = coder.load(v, self)
    end

    def serialize
      self.state = :serialized
      self.value = coder.dump(value)
    end

  end
end