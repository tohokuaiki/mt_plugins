package htpasswd_modifier::L10N::ja;
use strict;
use base 'htpasswd_modifier::L10N::en_us';
use vars qw ( %Lexicon );

%Lexicon = (
    'ITOH Takashi' => '伊藤 貴史',
	'This modifier make htpasswd hash(Crypt::Bcrypt / Crypt::PasswdMD5 / Digest::SHA).' => 'htpasswdで使用するパスワードをCrypt::Bcrypt/Crypt::PasswdMD5/Digest::SHAの順ハッシュ化するMovable Type のグローバルモディファイアを追加するプラグインです。',
);

1;


