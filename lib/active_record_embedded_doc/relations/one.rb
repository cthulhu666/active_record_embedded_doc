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
          else
            obj = klazz.new(value)
            obj.embedded_in = context
            obj
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
      end

    end
  end
end