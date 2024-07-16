package RsyncToPublic::ModalWindow;
use strict;

sub hndl_modal_window {
    my $app = shift;
    my $blog_id = $app->param('blog_id');
    my $class = MT->model('blog');
    my $blog = $class->load($blog_id);

    my %param;
    $param{blog_id} = $blog_id;
    $param{blog_name} = $blog->name();
    $param{entry_count} = MT::Entry->count({ blog_id => $blog_id,
                                             status => MT::Entry::RELEASE(),
                                           });

    $app->load_tmpl('modal_window.tmpl', \%param);
}

1;
