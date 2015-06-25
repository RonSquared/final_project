json.array!(@adventures) do |adventure|
  json.extract! adventure, :id, :activity, :date, :duration, :maps, :misc_notes
  json.url adventure_url(adventure, format: :json)
end
