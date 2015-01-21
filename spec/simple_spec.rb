require 'spec_helper'

describe 'simple' do
  subject(:simple){:simple}

  it{is_expected.to eq(:simple)}
end
