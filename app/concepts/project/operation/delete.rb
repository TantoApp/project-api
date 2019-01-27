#:delete
class Project::Delete < Trailblazer::Operation
  step Model(Project, :find_by)
  step :delete_with_dependents!

  def delete_with_dependents!(options, model:, **)
    ActiveRecord::Base.transaction do
      # insert something like
      test_case_client = ::Tantoapp::Test::Case::V1::Client.new("http://127.0.0.1:3002")
      test_case_client.test_cases.get(project_id: model.id).each do |tc|
        test_case_client.test_cases.delete_by_id(tc.id)
      end
      # Ideally, we won't do this for direct relations,
      # but only for relations outside the bounded context
      # Or let the frontend's light backend orchestrator do the talking.
      model.destroy
    end
  end
end
#:delete end
