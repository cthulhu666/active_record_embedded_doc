module ActiveRecordEmbeddedDoc
  module Relations
    class One

      class << self
        def _load(klazz, context, value)
          if value.nil?
            nil
          elsif value.is_a?(klazz)
            value.embedded_in = context if value.embedded_in.nil?
            value
          elsif value.is_a?(Hash)
            value = unwrap_hash(value, klazz)
            obj = klazz.new(value)
            obj.embedded_in = context
            obj
          else
            # raise exception
          end
        end

        def _dump(klazz, value)
          value.to_json
        end

        def field_changed(old, value)
          unwrap(old) != unwrap(value)
        end

        private

        def unwrap(value)
          value.is_a?(Attribute) ? value.value : value
        end

        def unwrap_hash(hash, klazz)
          root = klazz.model_name.element
          if hash.key?(root)
            hash[root]
          else
            hash
          end
        end
      end

    end
  end
end