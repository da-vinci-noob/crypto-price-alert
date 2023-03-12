if @success
  json.message 'Price Alert Created Successfully'
else
  json.message 'An Error Occurred while saving the Target Price'
end
