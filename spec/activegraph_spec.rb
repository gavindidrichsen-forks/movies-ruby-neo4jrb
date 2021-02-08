require 'spec_helper'
# require 'sinatra'
require 'neo4j'
require 'neo4j/session_manager'

# neo4j_url = ENV['NEO4J_URL'] || 'http://localhost:7474'

# Neo4j::Core::CypherSession::Adaptors::Base.subscribe_to_query(&method(:puts))

# adaptor_type = neo4j_url.match(/^bolt:/) ? :bolt : :http
# Neo4j::ActiveBase.on_establish_session do
#   Neo4j::SessionManager.open_neo4j_session(adaptor_type, neo4j_url)
# end

# session = Neo4j::ActiveBase.current_session

# The following from here:
# https://neo4jrb.readthedocs.io/en/stable/Setup.html
require 'neo4j/core/cypher_session/adaptors/http'
neo4j_adaptor = Neo4j::Core::CypherSession::Adaptors::HTTP.new('http://neo4j:test@localhost:7474')
Neo4j::ActiveBase.on_establish_session { Neo4j::Core::CypherSession.new(neo4j_adaptor) }

# https://neo4jrb.readthedocs.io/en/8.0.x/UpgradeGuide.html
neo4j_session = Neo4j::Core::CypherSession.new(neo4j_adaptor)
neo4j_session = Neo4j::ActiveBase.current_session

class Person
  include Neo4j::ActiveNode

  property :name

  has_many :out, :friends, type: :FRIEND
end

# ActiveGraph::Base.driver = Neo4j::Driver::GraphDatabase.driver('neo4j::/localhost:7687', Neo4j::Driver.AuthTokens.basic('neo4j','test'), encryption: false)


# media = Media.create(type: :video)
# media.type

describe 'ActiveBase' do
  # let(:movies) { movies = Movie.all }
  it 'returns a session' do
    expect(session.class).to eq(Neo4j::Core::CypherSession)
  end

  it 'bob' do
    # actors = Person.all.to_a # or if we want to be sure, query_as(:p).match("p-[:ACTED_IN]->()").pluck('distinct p')
    # expect(Person.query_as(:p).match("p-[:ACTED_IN]->()").pluck('distinct p')).to eq('bob')
    # pp Movie.inspect
    expect(Person.class).to eq('bob')

  end
end
