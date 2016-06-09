require 'spec_helper'

describe RolesAbility do
  it { is_expected.to belong_to(:role) }
  it { is_expected.to belong_to(:ability) }
end
