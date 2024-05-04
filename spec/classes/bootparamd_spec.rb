require 'spec_helper'

describe 'bootparamd' do
  let :facts do
    {
      osfamily: 'OpenBSD',
      os: { family: 'OpenBSD' },
    }
  end

  context 'with default parameters' do
    let(:params) { { bootparams: { node1: { nfsrootserver: '192.168.1.23', nfsrootpath: '/export/node1' } } } }

    it { is_expected.to compile.with_all_deps }  # same as above except it will test all the dependencies
    it { is_expected.to contain_class('bootparamd::config') }
    it { is_expected.to contain_class('bootparamd::sysctl') }
    it { is_expected.to contain_class('bootparamd::service') }
    it {
      is_expected.to contain_file('/etc/bootparams').with(
          owner: 'root',
          group: '0',
          mode: '0644',
      ).with_content(/^# DO NOT EDIT, THIS FILE IS MANAGED VIA PUPPET.*node1 root=192.168.1.23:\/export\/node1.*$/)
    }
    it { is_expected.not_to contain_sysctl('net.inet.ip.portlast') }
    it {
      is_expected.to contain_service('bootparamd').with(
        ensure: 'running',
        enable: 'true',
        flags: '-s',
      )
    }
  end

  context 'with custom parameters' do
    let(:params) do
      {
        bootparams: { node1: { nfsrootserver: '192.168.1.23', nfsrootpath: '/export/node1' } },
        old_sgi_client: true,
        service_name: 'bula',
        service_ensure: 'stopped',
        service_flags: '-X',
        service_enable: false,
      }
    end

    it { is_expected.to compile.with_all_deps }  # same as above except it will test all the dependencies
    it { is_expected.to contain_class('bootparamd::config') }
    it { is_expected.to contain_class('bootparamd::sysctl') }
    it { is_expected.to contain_class('bootparamd::service') }
    it {
      is_expected.to contain_sysctl('net.inet.ip.portlast').with(
        ensure: 'present',
        value: '32767',
      )
    }
    it {
      is_expected.to contain_service('bula').with(
        'ensure' => 'stopped',
        'enable' => 'false',
        'flags'  => '-X',
      )
    }
  end
end
