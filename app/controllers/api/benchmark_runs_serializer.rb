class Api::BenchmarkRunsSerializer < Api::BaseSerializer
  attributes :id, :result, :environment, :created_at, :updated_at , :initiator_type, :initiator_id, 
    :benchmark_type_id, :benchmark_result_type_id, :validity

  def created_at
    object.created_at.in_time_zone.iso8601 if object.created_at
  end

  def updated_at
    object.updated_at.in_time_zone.iso8601 if object.created_at
  end
end