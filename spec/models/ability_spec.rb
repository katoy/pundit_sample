require 'spec_helper'

describe Ability do
  it { is_expected.to have_many(:roles).through(:roles_abilities) }
end
