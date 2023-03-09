json.extract! vote_result, :id, :id, :legislator_id, :vote_id, :vote_type, :created_at, :updated_at
json.url vote_result_url(vote_result, format: :json)
