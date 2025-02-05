package htpasswd_modifier::Tags;
use strict;
use warnings;


# Modifiers
sub fltr_htpasswd {
    my ($str, $arg, $ctx) = @_;

    # ハッシュ化
    my $password = $str;
    my $hashed_password = "";

    # 優先順位 1: Crypt::Bcrypt
    if (eval { require Crypt::Bcrypt; Crypt::Bcrypt->import(); 1 }) {
        my $bcrypt = Crypt::Bcrypt->new(cost => 12);
        return $bcrypt->hash($password);
    }
    # 優先順位 2: Crypt::PasswdMD5
    elsif (eval { require Crypt::PasswdMD5; Crypt::PasswdMD5->import(); 1 }) {
        return Crypt::PasswdMD5::apache_md5_crypt($password);
    }
    # 優先順位 3: Digest::SHA
    elsif (eval { require Digest::SHA; Digest::SHA->import(qw(sha1_base64)); 1 }) {
        return "{SHA}" . Digest::SHA::sha1_base64($password) . "=";
    }

    # どのモジュールも使えない場合
    return "Error: either Crypt::Bcrypt, Crypt::PasswdMD5 or Digest::SHA is required.";
}

1;
