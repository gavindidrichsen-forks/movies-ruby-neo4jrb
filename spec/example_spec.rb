require 'spec_helper'
# require 'sinatra'
require 'neo4j'
require 'neo4j/session_manager'

neo4j_url = ENV['NEO4J_URL'] || 'http://localhost:7474'

Neo4j::Core::CypherSession::Adaptors::Base.subscribe_to_query(&method(:puts))

adaptor_type = neo4j_url.match(/^bolt:/) ? :bolt : :http
Neo4j::ActiveBase.on_establish_session do
  Neo4j::SessionManager.open_neo4j_session(adaptor_type, neo4j_url)
end

session = Neo4j::ActiveBase.current_session

class Engagement
  include Neo4j::ActiveRel
  property :roles  # this contains an array of roles
  from_class 'Person'
  to_class 'Movie'
  type :ACTED_IN
end

class Movie
  include Neo4j::ActiveNode
  id_property :title
  property :released
  property :tagline
  has_many :in, :actors, model_class: :Person, rel_class: 'Engagement'
  has_many :in, :directors, model_class: :Person, type: :DIRECTED
end

class Person
  include Neo4j::ActiveNode
  id_property :name
  has_many :out, :acted_in, model_class: :Movie, rel_class: 'Engagement'
  has_many :out, :directed, model_class: :Movie, type: :DIRECTED
end

describe 'ActiveBase' do
  let(:movies) { movies = Movie.all }
  it 'returns a session' do
    expect(session.class).to eq(Neo4j::Core::CypherSession)
  end

  it 'bob' do
    expect(Person.find(name: "Andy")).to eq('bob')
    # actors = Person.all.to_a # or if we want to be sure, query_as(:p).match("p-[:ACTED_IN]->()").pluck('distinct p')
    
    # expect(Person.query_as(:p).match("p-[:ACTED_IN]->()").pluck('distinct p')).to eq('bob')
    # pp Movie.inspect

  end
end
