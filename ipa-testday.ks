%include spin-kickstarts/custom/qa-test-day.ks

%packages
freeipa-server
freeipa-client
sssd
python-qrcode
python-pyrad
bind
bind-dyndb-ldap
%end

%post
# I'm not quite sure why this doesn't get created on boot,
# but it breaks the installation procedure
cat >>/etc/rc.d/init.d/livesys-late <<EOF
mkdir -p /var/run/user/0
chown root:root /var/run/user/0
chmod 700 /var/run/user/0
EOF

# Setup DNS
cat >/etc/resolv.conf <<EOF
nameserver 8.8.8.8
EOF
chown root:root /etc/resolv.conf
chmod 644 /etc/resolv.conf

# Get our test environment
wget http://npmccallum.fedorapeople.org/freeipa-otp/ipa-testday-env
bash ipa-testday-env install cd
%end
