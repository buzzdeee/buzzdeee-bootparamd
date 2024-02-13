require 'spec_helper'

describe 'bootparamd' do
  let :facts do
    {
      osfamily: 'OpenBSD',
    }
  end

  context 'with default parameters' do
    it { is_expected.to compile.with_all_deps }  # same as above except it will test all the dependencies
    it { is_expected.to contain_class('bootparamd::config') }
    it { is_expected.to contain_class('bootparamd::sysctl') }
    it { is_expected.to contain_class('bootparamd::service') }
  end
end
