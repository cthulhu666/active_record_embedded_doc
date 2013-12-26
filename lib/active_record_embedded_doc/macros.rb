module ActiveRecordEmbeddedDoc
  module Macros

    extend ActiveSupport::Concern

    included do
      class_attribute :relations, instance_accessor: false
      self.relations = Hashie::Mash.new
    end

    module ClassMethods

      def embeds_one(name, opts = {})
        include ActiveRecordEmbeddedDoc::Behaviour
        meta = characterize(name, Relations::One, opts)
        relate(name, meta)
      end

      def embeds_many(name, opts = {})
        include ActiveRecordEmbeddedDoc::Behaviour
        meta = characterize(name, Relations::Many, opts)
        relate(name, meta)
      end

      private

      def characterize(name, relation, options)
        Metadata.new({
                         relation: relation.new(self.class),
                         inverse_class_name: self.name,
                         name: name
                     }.merge(options))
      end

      def relate(name, metadata)
        self.relations = relations.merge(name.to_s => metadata)
      end
    end

  end
end