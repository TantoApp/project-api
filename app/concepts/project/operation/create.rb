class Project::Create < Trailblazer::Operation
  class Present < Trailblazer::Operation
    step Model(Project, :new)
    step Contract::Build( constant: Project::Contract::Create )
  end
  
  step Nested( Present )
  step Contract::Validate( key: :project )
  failure :failed!

  step Contract::Persist( )
  step :notify!

  def notify!(options, model:, **)
    options["result.notify"] = Rails.logger.info("New Project #{model.name}.")
  end

  def failed!(options, model:, **)
    Rails.logger.error "Validation Failed" if options["result.contract.default"].try(:errors)
  end
end
