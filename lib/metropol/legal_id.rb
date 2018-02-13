module Metropol
  module LegalId

    ID_TYPES = {
      national_id: '001',
      passport: '002',
      service_id: '003',
      alien_registration: '004',
      company_id: '005'
    }.freeze

    # Return the Metropol code for a given
    # legal identity type
    def code_for(id_type)
      if valid_id? id_type
        return ID_TYPES[id_type]
      else
        raise(ArgumentError,
              'Invalid id_type. Please use a valid id_type for e.g. :national_id')
      end
    end

    def valid_id?(id_type)
      return ID_TYPES.has_key? id_type
    end

  end
end