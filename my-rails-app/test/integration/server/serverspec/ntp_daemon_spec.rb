require 'serverspec'

# Required by serverspec
set :backend, :exec

describe "Ruby on Rails application" do

  it "is listening on port 8000" do
    expect(port(8000)).to be_listening
  end

  it "has a running service of langauge-school" do
    expect(service("language-school")).to be_running
  end

end
