module ActiveRecordEmbeddedDoc
  class Metadata < Hashie::Mash

    def initialize(*)
      super
      self.klazz = name.to_s.classify.constantize
    end

    def load(data, context)
      relation._load klazz, context, data
    end

    def dump(data)
      relation._dump klazz, data
    end

  end
end