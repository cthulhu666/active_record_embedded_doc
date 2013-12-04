module ActiveRecordEmbeddedDoc
  class Type # :nodoc:
    attr_reader :column

    def initialize(column)
      @column = column
    end

    def type_cast(value)
      if value.state == :serialized
        value.unserialized_value( column.type_cast(value.value) )
      else
        value.unserialized_value
      end
    end

    def type
      column.type
    end
  end
end