json.kyb_application do
  json.id kyb_application.id
  json.status kyb_application.status&.capitalize
  json.rejection_reason kyb_application.rejection_reason
  json.company_details do
    json.id kyb_application.company.id
    json.legal_name kyb_application.company.legal_name
    json.address kyb_application.company.address
    json.email kyb_application.company.email
    json.phone_number kyb_application.company.phone_number
    json.primary_contact_name kyb_application.company.primary_contact_name
    json.primary_contact_phone_number kyb_application.company.primary_contact_phone_number
    json.created_at kyb_application.company.created_at
    json.updated_at kyb_application.company.updated_at

    json.directors_details do
      json.array! kyb_application.company.directors, partial: 'api/v1/directors/director', as: :director
    end

    json.documents_details do
      json.array! kyb_application.company.documents, partial: 'api/v1/documents/document', as: :document
    end
  end
end
