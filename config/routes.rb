# -*- coding: utf-8 -*-
# require mapper class which holds methods for routing
require_relative '../app/lib/ext/action_dispatch/routing/mapper.rb'

# Using Rails.application.routes.draw as we want to
# add to the host application's routes, not the engine's routes

Rails.application.routes.draw do
  id_format_regex = self.class::ID_FORMAT_REGEX
  id_or_schema_format_regex = self.class::ID_OR_SCHEMA_FORMAT_REGEX

  ### Root ###
  # /
  root 'home#index'

  ### MPs ###
  # /mps
  get '/mps', to: 'home#mps'

  ### Find your constituency ###
  # /find-your-constituency
  get '/find-your-constituency', to: 'home#find_your_constituency'

  ### Who should I contact with my issue? ###
  # /who-should-i-contact-with-my-issue
  get '/who-should-i-contact-with-my-issue', to: 'meta#who_should_i_contact_with_my_issue'

  ### Statutory Instruments ###
  # /statutory-instruments
  get '/statutory-instruments', to: 'statutory_instruments#index'

  ## Work Packages ##
  get '/work-packages',                  to: 'work_packages#index', as: :work_packages
  get '/work-packages/:work_package_id', to: 'work_packages#show',  as: :work_package

  ## Procedures ##
  get '/procedures',                to: 'procedures#index', as: :procedures
  get '/procedures/:procedure_id', to: 'procedures#show',  as: :procedure

  ### Articles ###
  get '/articles/:article_id', to: 'articles#show', article_id: id_format_regex, as: :article

  ### Questions ###
  get '/questions/:question_id', to: 'questions#show', question_id: id_format_regex, as: :question

  ### Concepts ###
  get '/concepts',             to: 'concepts#index', as: :concepts
  get '/concepts/:concept_id', to: 'concepts#show',  as: :concept, concept_id: id_format_regex

  ### Collections ###
  get '/collections',                to: 'collections#index', as: :collections
  get '/collections/:collection_id', to: 'collections#show',  as: :collection, collection_id: id_format_regex

  ### Hybrid Bill Petitions ###
  # /petition-a-hybrid-bill
  get  '/petition-a-hybrid-bill',                                         to: 'hybrid_bills#index',       as: :hybrid_bills
  get  '/petition-a-hybrid-bill/:bill_id',                                to: 'hybrid_bills#show',        as: :hybrid_bill
  post '/petition-a-hybrid-bill/:bill_id',                                to: 'hybrid_bills#show'
  get  '/petition-a-hybrid-bill/:bill_id/email-a-petition',               to: 'hybrid_bills#email',       as: :hybrid_bill_email
  post '/petition-a-hybrid-bill/:bill_id/email-a-petition',               to: 'hybrid_bills#choose_type', as: :hybrid_bill_email_type
  get  '/petition-a-hybrid-bill/:bill_id/complete-your-petition-online',  to: 'hybrid_bills#redirect',    as: :hybrid_bill_redirect

  ### Search ###
  # /search
  get '/search',            to: 'search#index',      as: :search
  get '/search/opensearch', to: 'search#opensearch', as: :opensearch_description
  get '/search/redirect',   to: 'search#redirect',   as: :redirect

  ### People ###
  # /people (multiple 'people' scope)
  scope '/people', as: 'people' do
    build_default_routes('people', current: false)
    listable('people#a_to_z', 'people#letters')

    # /people/members
    build_members_routes('people/members', current: true)
  end

  # /people (single 'person' scope)
  scope '/people', as: 'person' do
    # /people/:person_id
    scope '/:person_id' do
      get '/', to: 'people#show', person_id: id_format_regex

      # /people/:person_id/constituencies
      build_root_and_current_routes('people/constituencies', 'constituencies')

      get '/contact-points', to: 'people/contact_points#index'

      # /people/:person_id/houses
      build_root_and_current_routes('people/houses', 'houses')

      # /people/:person_id/parties
      build_root_and_current_routes('people/parties', 'parties')

      # /people/:person_id/committees
      scope '/committees', as: 'committees' do
        get '/', to: 'people/committees#index'

        scope '/memberships', as: 'memberships' do
          # /people/:person_id/committees/memberships
          get '/', to: 'people/committees/memberships#index'

          scope '/current', as: 'current' do
            # /people/:person_id/committees/memberships/current
            get '/', to: 'people/committees/memberships#current'
          end
        end

        # /people/:person_id/committees/chairs
        scope '/chairs', as: 'chairs' do
          get '/', to: 'people/committees/chairs#index'
        end
      end
    end

    # Allow lookups - but ensure they are SECOND in the routes list after /people/:person_id
    lookupable('people#lookup_by_letters')
  end

  ### Parties ###
  # /parties (multiple 'parties' scope)
  scope '/parties', as: 'parties' do
    build_default_routes('parties', postcode: false)
    listable('parties#a_to_z', 'parties#letters')
  end

  # /parties (single 'party' scope)
  scope '/parties', as: 'party' do
    # /parties/:party_id
    scope '/:party_id' do
      get '/', to: 'parties#show', party_id: id_format_regex

      # /parties/:party_id/members
      build_members_routes('parties/members', current: true)
    end

    # Allow lookups - but ensure they are SECOND in the routes list after /parties/:party_id
    lookupable('parties#lookup_by_letters')
  end

  ### Postcodes ###
  # /postcodes (multiple 'postcodes' scope)
  scope '/postcodes', as: 'postcodes' do
    get '/', to: 'postcodes#index'
    post '/lookup', to: 'postcodes#lookup'
  end

  # /postcodes (single 'postcode' scope)
  scope '/postcodes', as: 'postcode' do
    # /postcodes/:postcode
    scope '/:postcode' do
      get '/', to: 'postcodes#show'
    end
  end

  ### Constituencies ###
  # /constituencies (multiple 'constituencies' scope)
  scope '/constituencies', as: 'constituencies' do
    build_default_routes('constituencies', current: false)
    listable('constituencies#a_to_z', 'constituencies#letters')

    # /constituencies/current
    scope '/current', as: 'current' do
      get '/', to: 'constituencies#current'

      listable('constituencies#a_to_z_current', 'constituencies#current_letters')
    end
  end

  # /constituencies (single 'constituency' scope)
  scope '/constituencies', as: 'constituency' do
    # /constituencies/:constituency_id
    scope '/:constituency_id' do
      get '/', to: 'constituencies#show', constituency_id: id_format_regex
      get '/contact-point', to: 'constituencies/contact_points#index'
      get '/map', to: 'constituencies#map'

      # /constituencies/:constituency_id/members
      build_root_and_current_routes('constituencies/members', 'members')
    end

    # Allow lookups - but ensure they are SECOND in the routes list after /constituencies/:constituency_id
    lookupable('constituencies#lookup_by_letters')
  end

  ## Contact Points ##
  # /contact-points  (multiple 'contact_points' scope)
  scope '/contact-points', as: 'contact_points' do
    get '/', to: 'contact_points#index'
  end

  # /contact-points (single 'contact_point' scope)
  scope '/contact-points', as: 'contact_point' do
    # /contact-points/:contact_point_id
    scope '/:contact_point_id' do
      get '/', to: 'contact_points#show', contact_point_id: id_format_regex
    end
  end

  ## Houses ##
  # /houses (multiple 'houses' scope)
  scope '/houses', as: 'houses' do
    build_default_routes('houses', current: false, postcode: false)
  end

  # /houses (single 'house' scope)
  scope '/houses', as: 'house' do
    # /houses/:house_id
    scope '/:house_id' do
      get '/', to: 'houses#show', house_id: id_format_regex

      # /houses/:house_id/committees
      scope '/committees', as: 'committees' do
        get '/', to: 'houses/committees#index'
        listable('houses/committees#a_to_z', 'houses/committees#letters')

        # /houses/:house_id/committees/current
        scope '/current', as: 'current' do
          get '/', to: 'houses/committees#current'
          listable('houses/committees#a_to_z_current', 'houses/committees#current_letters')
        end
      end

      # /houses/:house_id/members
      build_members_routes('houses/members', current: true)

      # /houses/:house_id/parties
      scope '/parties', as: 'parties' do
        get '/', to: 'houses/parties#index'
        get '/current', to: 'houses/parties#current'

        # /houses/:house_id/parties/:party_id
        scope '/:party_id', as: 'party' do
          get '/', to: 'houses/parties#show'

          # /houses/:house_id/parties/:party_id/members
          scope '/members', as: 'members' do
            get '/', to: 'houses/parties/members#index'

            listable('houses/parties/members#a_to_z', 'houses/parties/members#letters')

            # /houses/:house_id/parties/:party_id/members/current
            scope '/current', as: 'current' do
              get '/', to: 'houses/parties/members#current'

              listable('houses/parties/members#a_to_z_current', 'houses/parties/members#current_letters')
            end
          end
        end
      end
    end

    # Allow lookups - but ensure they are SECOND in the routes list after /houses/:house_id
    lookupable('houses#lookup_by_letters')
  end

  ### Parliaments ###
  # /parliaments (multiple 'parliaments' scope)
  scope '/parliaments', as: 'parliaments' do
    build_default_routes('parliaments', postcode: false)
    get '/previous', to: 'parliaments#previous'
    get '/next', to: 'parliaments#next'
  end

  # /parliaments (single 'parliament' scope)
  scope '/parliaments', as: 'parliament' do
    # /parliaments/:parliament_id
    scope '/:parliament_id' do
      get '/', to: 'parliaments#show', parliament_id: id_format_regex

      # /parliaments/:parliament_id/next
      get '/next', to: 'parliaments#next_parliament'

      # /parliaments/:parliament_id/previous
      get '/previous', to: 'parliaments#previous_parliament'

      build_members_routes('parliaments/members', current: false)

      scope '/houses', as: 'houses' do
        # /parliaments/:parliament_id/houses
        get '/', to: 'parliaments/houses#index'
      end

      scope '/houses', as: 'house' do
        scope ':house_id' do
          # /parliaments/:parliament_id/houses/:house_id
          get '/', to: 'parliaments/houses#show', house_id: id_format_regex

          scope '/members', as: 'members' do
            # /parliaments/:parliament_id/houses/:house_id/members
            get '/', to: 'parliaments/houses/members#index'

            listable('parliaments/houses/members#a_to_z', 'parliaments/houses/members#letters')
          end

          scope '/parties', as: 'parties' do
            # /parliaments/:parliament_id/houses/:house_id/parties
            get '/', to: 'parliaments/houses/parties#index'
          end

          scope '/parties', as: 'party' do
            scope ':party_id' do
              # /parliaments/:parliament_id/houses/:house_id/parties/:party_id
              get '/', to: 'parliaments/houses/parties#show', party_id: id_format_regex

              scope '/members', as: 'members' do
                # /parliaments/:parliament_id/houses/:house_id/parties/:party_id/members
                get '/', to: 'parliaments/houses/parties/members#index'

                listable('parliaments/houses/parties/members#a_to_z', 'parliaments/houses/parties/members#letters')
              end
            end
          end
        end
      end

      scope '/parties', as: 'parties' do
        # parliaments/:parliament_id/parties
        get '/', to: 'parliaments/parties#index'
      end

      scope '/parties', as: 'party' do
        scope '/:party_id' do
          # /parliaments/:parliament_id/parties/:party_id
          get '/', to: 'parliaments/parties#show', party_id: id_format_regex

          scope '/members', as: 'members' do
            # /parliaments/:parliament_id/parties/:party_id/members
            get '/', to: 'parliaments/parties/members#index'

            listable('parliaments/parties/members#a_to_z', 'parliaments/parties/members#letters')
          end
        end
      end

      scope '/constituencies', as: 'constituencies' do
        # parliaments/:parliament_id/constituencies
        get '/', to: 'parliaments/constituencies#index'

        listable('parliaments/constituencies#a_to_z', 'parliaments/constituencies#letters')
      end
    end
  end

  ## Resource
  # /resource/
  scope '/resource', as: 'resource' do
    get '/', to: 'resource#index'
    scope '/:resource_id' do
      get '/', to: 'resource#show', resource_id: id_or_schema_format_regex
    end
  end

  ## Meta ##
  # /meta
  scope '/meta', as: 'meta' do
    get '/', to: 'meta#index'
    get '/cookie-policy', to: 'meta#cookie_policy'
  end

  ## Media
  # /media/
  scope '/media', as: 'media' do
    get '/', to: 'media#index'
    scope '/:medium_id', as: 'show' do
      get '/', to: 'media#show', medium_id: id_format_regex
    end
  end

  ## Places
  # /places
  scope '/places', as: 'places' do
    get '/', to: 'places#index'
  end


  ## Places/regions
  # /places/regions
  scope '/places', as: 'places' do
    scope '/regions', as: 'regions' do
      get '/', to: 'places/regions#index'
    end
  end

  ## Places
  scope '/places', as: 'places' do

    # /places/:place_id
    scope '/:place_id', as: 'show' do
      get '/', to: 'places#show'

      # /places/:place_id/constituencies
      scope '/constituencies', as: 'constituencies' do
        get '/', to: 'places/constituencies#index'
        listable('places/constituencies#a_to_z', 'places/constituencies#letters')
      end
    end
  end


  scope '/groups', as: 'group' do
    # /groups/:group_id
    scope '/:group_id' do
      get '/', to: 'groups#show', group_id: id_format_regex

      # /groups/:group_id/memberships
      scope '/memberships', as: 'memberships' do
        get '/', to: 'groups/memberships#index'
        listable('groups/memberships#a_to_z', 'groups/memberships#letters')

        # /groups/:group_id/memberships/current
        scope '/current', as: 'current' do
          get '/', to: 'groups/memberships#current'
        end
      end

      # /groups/:group_id/houses
      scope '/houses', as: 'houses' do
        get '/', to: 'groups/houses#index'
      end

      # /groups/:group_id/positions
      scope '/positions', as: 'positions' do
        get '/', to: 'groups/positions#index'

        scope 'chairs', as: 'chairs' do
          get '/', to: 'groups/positions/chairs#index'

          scope '/current', as: 'current' do
            get '/', to: 'groups/positions/chairs#current'
          end
        end

        scope '/current', as: 'current' do
          get '/', to: 'groups/positions#current'
        end
      end

    end
  end

  ## Groups
  scope '/groups', as: 'groups' do
    # /groups

    get '/', to: 'groups#index'

    listable('groups#a_to_z', 'groups#letters')

    # /groups/government-departments
    scope '/government-organisations', as: 'government_organisations' do
      get '/', to: 'groups/government_organisations#index'
      listable('groups/government_organisations#a_to_z', 'groups/government_organisations#letters')

      scope '/current', as: 'current' do
        get '/', to: 'groups/government_organisations#current'
        listable('groups/government_organisations#a_to_z_current', 'groups/government_organisations#current_letters')
      end
    end

    post '/lookup', to: 'groups#lookup'

    scope '/current', as: 'current' do
      get '/', to: 'groups#current'

      listable('groups#a_to_z_current', 'groups#current_letters')
    end

    lookupable('groups#lookup_by_letters')
  end



  ## Committees ##
  scope '/committees', as: 'committees' do
    # /committees
    get '/', to: 'committees#index'

    lookupable('committees#lookup_by_letters')

    listable('committees#a_to_z', 'committees#letters')

    # /committees/current
    scope '/current', as: 'current' do
      get '/', to: 'committees#current'
      listable('committees#a_to_z_current', 'committees#current_letters')
    end

    # /committees/:committee_id
    scope '/:committee_id', as: 'show' do
      get '/', to: 'committees#show', committee_id: id_format_regex

      # /committees/:committee_id/memberships
      scope '/memberships', as: 'memberships' do
        get '/', to: 'committees/memberships#index'
        listable('committees/memberships#a_to_z', 'committees/memberships#letters')

        # /committees/:committee_id/memberships/current
        scope '/current', as: 'current' do
          get '/', to: 'memberships#current'
        end
      end

      # /committees/:committee_id/chairs
      scope '/chairs', as: 'chairs' do
        get '/', to: 'committees/chairs#index'
      end

      # /committees/:committee_id/sub-committees
      scope '/sub-committees', as: 'sub_committees' do
        get '/', to: 'committees/sub_committees#index'

        scope '/current', as: 'current' do
          get '/', to: 'sub_committees#current'
        end
      end

      # /committees/:committee_id/houses
      scope '/houses', as: 'houses' do
        get '/', to: 'committees/houses#index'
      end

      # /committees/:committee_id/parent
      scope '/parent', as: 'parent' do
        get '/', to: 'committees#parent'
      end
    end
  end
end
