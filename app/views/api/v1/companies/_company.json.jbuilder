json.company do
  json.id company.id
  json.legal_name company.legal_name
  json.address company.address
  json.email company.email
  json.phone_number company.phone_number
  json.primary_contact_name company.primary_contact_name
  json.primary_contact_phone_number company.primary_contact_phone_number
  json.created_at company.created_at
  json.updated_at company.updated_at

  json.directors_details do
    json.array! company.directors, partial: 'api/v1/directors/director', as: :director
  end

  json.documents_details do
    json.array! company.documents, partial: 'api/v1/documents/document', as: :document
  end

  json.kyb_application do
    json.id company.kyb_application&.id
    json.status company.kyb_application&.status&.capitalize
    json.rejection_reason company.kyb_application&.rejection_reason
    json.company_id company.kyb_application&.company_id
  end    
end
