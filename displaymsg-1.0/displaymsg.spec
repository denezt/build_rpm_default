#
#
#

Name:		displaymsg
Version:	1.0
Release:	1
Summary:	Show Program Name
Group:		Automation-Tools
License:	GPLv2
Url:		https://www.garagebarge.com
Source:		%{name}.tar.gz
BuildRoot:	%{_tmpdir}/%{name}-%{version}-%{build}

%description
A simple demo to build a package - displays the program name.

Authors:
--------
	Richard Jackson

%global debug_package %{nil}
%prep
%setup -q /home/jenkins/%{?name}-%{?version}
%build
make all

%install
make PREFIX=/usr DESTDIR=%{?buildroot} install

%clean
rm -rf %{buildroot}

%files
%defattr(4755,root,root,0755)
/usr/bin/%{name}
