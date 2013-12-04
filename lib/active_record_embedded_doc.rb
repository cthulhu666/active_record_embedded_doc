require 'hashie'
require 'active_record'
require 'active_record_embedded_doc/version'
require 'active_record_embedded_doc/relations/one'
require 'active_record_embedded_doc/relations/many'
require 'active_record_embedded_doc/metadata'
require 'active_record_embedded_doc/field'
require 'active_record_embedded_doc/macros'
require 'active_record_embedded_doc/attribute'
require 'active_record_embedded_doc/type'
require 'active_record_embedded_doc/behaviour'
require 'active_record_embedded_doc/embedded_document'

module ActiveRecordEmbeddedDoc
end

ActiveRecord::Base.send :include, ActiveRecordEmbeddedDoc::Macros