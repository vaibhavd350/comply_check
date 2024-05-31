# frozen_string_literal: true

roles = %w[company_owner compliance_officer]

puts 'Seeding required data.'
ActiveRecord::Base.transaction do
  roles.each do |role_name|
    puts "  Creating Role [#{role_name.titleize}]..."

    role = Role.find_or_create_by(name: role_name)
    puts "  Role Created [#{role_name.titleize}]."

    if role[:name] == 'compliance_officer'
      puts "  - Creating User With Role [#{role_name.titleize}]..."

      user = User.find_or_initialize_by(
        name: role_name.titleize,
        email: "#{role.name}#{role.id}@gmail.com"
      )
      user.password = '123456'
      user.password_confirmation = '123456'

      if user.save && user.add_role(role_name) && user.confirm
        puts "  - User Created With Role [#{role_name.titleize}]."
      else
        puts "  - Warning:: While Creating User For Role [#{role_name.titleize}]."
        puts "  - Message:: #{user.errors.full_messages.to_sentence}."
      end
    end
    puts ''
  end
rescue StandardError => e
  puts "  Error:: #{e.message}"
end
puts 'Process completed.'
