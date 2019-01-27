#:update
class Project::Update < Trailblazer::Operation
  class Present < Trailblazer::Operation
    step Model(Project, :find_by)
    step Contract::Build( constant: Project::Contract::Update )
  end

  step Nested(Present)
  step Contract::Validate( key: :project )
  step Contract::Persist()
end
#:update end
