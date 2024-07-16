package RsyncToPublic::Tasks;
use strict;

sub do_rsync {
    use Data::Dumper;
    use MT::Util;
    use Time::HiRes;
    my $plugin_data = MT->model('plugindata');
    my $data = $plugin_data->load({
        plugin => 'RsyncToPublic',
        key => 'configuration'
    });
    my $now = MT::Util::format_ts("%Y-%m-%d %H:%M",
                                  MT::Util::epoch2ts(undef, Time::HiRes::time(), 0));
    if ($data){
        my $config_data = $data->data;
        if ($config_data->{rsync_date} && $config_data->{rsync_time}){
            if ($now ge $config_data->{rsync_date} . " " . $config_data->{rsync_time}){
                print $now;
                system($config_data->{rsync_cmd});
                $data->data({rsync_date => '',
                             rsync_time => '',
                             rsync_cmd  => $config_data->{rsync_cmd}
                           });
                $data->save();
                doLog("Exec command. => ".$config_data->{rsync_cmd});
                return 1;
            }
        }
    }
    return 0;
}

sub doLog {
    my ($msg, $class) = @_;
    return unless defined($msg);

    require MT::Log;
    my $log = new MT::Log;
    $log->message($msg);
    $log->level(MT::Log::DEBUG());
    $log->class($class) if $class;
    $log->save or die $log->errstr;
}

1;
