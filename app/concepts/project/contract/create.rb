#:contract
require "reform"
require "reform/form/dry"

module Project::Contract
  class Create < Reform::Form
    include Dry

    def self.statuses
      {"0" => "untested", "1" => "passed", "2" => "failed"}
    end

    #:property
    property :name
    property :description
    property :status
    property :active
    #:property end

    #:validation
    validation do
      required(:name).filled
      required(:description).filled
      required(:status).filled.included_in?(Project::Contract::Create.statuses.keys)
    end
    #:validation end
  end
end
#:contract end
