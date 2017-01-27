class Api::BenchmarkRunsApiController < Api::BaseController
  def show
    run = BenchmarkRuns.find(params[:id])

    render(json: Api::BenchmarkRunsSerializer.new(run).to_json)
  end
end