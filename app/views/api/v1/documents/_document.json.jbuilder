json.document do
  json.id document.id
  json.name document.name
  json.document_type document.document_type
  json.file_url url_for(document.file)
end