Name:    ultra
Version: 1
Release: 1%{?dist}
Summary: Gradually increment play-list tempo.

License: GNU GENERAL PUBLIC LICENSE
Source0: ultra
BuildArch: noarch
Requires: ffmpeg,md5sum,shuf,bc

%description
A utility for improving jogging (physical activity) speed.

%install
mkdir -p %{buildroot}%{_bindir}
install -p -m 755 %{SOURCE0} %{buildroot}%{_bindir}

%files
%{_bindir}/ultra

%changelog
