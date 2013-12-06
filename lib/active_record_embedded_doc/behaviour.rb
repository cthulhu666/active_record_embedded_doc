module ActiveRecordEmbeddedDoc

  module Behaviour
    extend ActiveSupport::Concern

    module ClassMethods

      def decorate_columns(columns_hash)
        super(columns_hash).tap do |cols|
          @embedded_doc_column_names ||= cols.keys.find_all do |name|
            relations.key?(name)
          end

          @embedded_doc_column_names.each do |name|
            cols[name] = ActiveRecordEmbeddedDoc::Type.new(columns_hash[name])
          end

          cols
        end
      end

      def initialize_attributes(attributes, options = {})
        super(attributes, options)

        relations.each do |key, coder|
          if attributes.key?(key)
            attributes[key] = Attribute.new(self, coder, attributes[key])
          end
        end

        attributes
      end
    end

    def type_cast_attribute_for_write(column, value)
      if column && coder = self.class.relations[column.name]
        Attribute.new(self, coder, value)
      else
        super
      end
    end

    def _field_changed?(attr, old, value)
      if coder = self.class.relations[attr]
        coder.relation.field_changed(old, value)
      else
        super
      end
    end

    def read_attribute_before_type_cast(attr_name)
      if self.class.relations.include?(attr_name)
        super.unserialized_value
      else
        super
      end
    end

    def attributes_before_type_cast
      super.dup.tap do |attributes|
        self.class.relations.each_key do |key|
          if attributes.key?(key)
            attributes[key] = attributes[key].unserialized_value
          end
        end
      end
    end

    def typecasted_attribute_value(name)
      if self.class.relations.include?(name)
        @attributes[name].serialized_value
      else
        super
      end
    end
  end
end