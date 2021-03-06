class postfix (
  $ensure                       = 'present',
  $package_version              = 'present',
  $package_name                 = $::postfix::params::package_name,
  $config_directory             = $::postfix::params::config_directory,
  $main_cf_source               = undef,
  $soft_bounce                  = 'no',
  $myorigin                     = '$myhostname',
  $myhostname                   = $::fqdn,
  $mydestination                = '$myorigin',
  $inet_interfaces              = 'all',
  $inet_protocols               = 'ipv4',
  $proxy_interfaces             = undef,
  $mynetworks_style             = 'host',
  $mynetworks                   = undef,
  $relay_domains                = undef,
  $smtpd_banner                 = $::postfix::params::smtpd_banner,
  $disable_vrfy_command         = 'yes',
  $smtpd_helo_required          = 'yes',
  $smtpd_client_restrictions    = undef,
  $smtpd_helo_restrictions      = undef,
  $smtpd_sender_restrictions    = undef,
  $smtpd_recipient_restrictions = undef,
  $smtpd_error_sleep_time       = '1s',
  $smtpd_soft_error_limit       = '10',
  $smtpd_hard_error_limit       = '20',
) inherits postfix::params {

  $main_cf   = "${config_directory}/main.cf"
  $master_cf = "${config_directory}/master.cf"
  $transport = "${config_directory}/transport"

  class { '::postfix::install': }->
  class { '::postfix::config': }->
  class { '::postfix::service': }->
  Class['postfix']

  Postfix::Conf <| |> ~> Class['postfix::service']
  Class['postfix'] -> Postfix::Hash <| |>
}
