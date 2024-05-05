require 'spec_helper'

describe 'bootparamd' do
  let :facts do
    {
      osfamily: 'OpenBSD',
      os: { family: 'OpenBSD' },
    }
  end

  context 'with default parameters' do
    bootparams_content = File.read('spec/fixtures/bootparamd_bootparams.empty')

    it { is_expected.to compile.with_all_deps }  # same as above except it will test all the dependencies
    it { is_expected.to contain_class('bootparamd::config') }
    it { is_expected.to contain_class('bootparamd::sysctl') }
    it { is_expected.to contain_class('bootparamd::service') }
    it {
      is_expected.to contain_file('/etc/bootparams').with(
        owner: 'root',
        group: '0',
        mode: '0644',
      ).with_content(bootparams_content)
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
    bootparams_content = File.read('spec/fixtures/bootparamd_bootparams.multiline')
    let(:params) do
      {
        bootparams: {
          node1: {
            nfsrootserver: '192.168.0.1', nfsrootpath: '/export/root_node1'
          },
          node2: {
            nfsrootserver: '192.168.0.2',
            nfsrootpath: '/export/root_node2',
            nfsswapserver: '192.168.0.3',
            nfsswappath: '/export/swap_node2',
          },
          node3: {
            nfsrootserver: '192.168.0.4',
            nfsrootpath: '/export/root_node3',
            nfsswapserver: '192.168.0.5',
            nfsswappath: '/export/swap_node3',
            nfsdumpserver: '192.168.0.6',
            nfsdumppath: '/export/dump_node3',
          },
          node4: {
            nfsrootserver: '192.168.0.7',
            nfsrootpath: '/export/root_node4',
            nfsdumpserver: '192.168.0.8',
            nfsdumppath: '/export/dump_node4',
          },
        },
        old_sgi_client: true,
        enable_yplookup: true,
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
      is_expected.to contain_file('/etc/bootparams').with(
        owner: 'root',
        group: '0',
        mode: '0644',
      ).with_content(bootparams_content)
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
