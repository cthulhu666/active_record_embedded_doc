module ActiveRecordEmbeddedDoc
  class Metadata < Hashie::Mash

    def initialize(*)
      super
      if class_name?
        self.klazz = class_name.to_s.constantize
      else
        self.klazz = name.to_s.classify.constantize
      end
    end

    def load(data, context)
      relation._load context, data
    end

    def dump(data)
      relation._dump data
    end

  end
end