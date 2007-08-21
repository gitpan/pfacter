Summary: Collect and display facts about the system.
Name: pfacter.vumc
Version: 1.8
Release: 1
License: GPL
Group: System Environment/Base

Packager: Scott Schneider <scott@loserfish.org>
Vendor: loserfish

Source: http://yum.mc.vanderbilt.edu/src/pfacter.vumc-1.8.tar.gz
BuildRoot: /home/schneis/rpm/tmp/%{name}-buildroot

Requires: perl

%description
Collect and display facts about the current system.

%define _unpackaged_files_terminate_build 0
%define _missing_doc_files_terminate_build 0

%prep
%setup

%build

%install
rm -rf $RPM_BUILD_ROOT
mkdir -p $RPM_BUILD_ROOT
mkdir -p $RPM_BUILD_ROOT/usr/bin
mkdir -p $RPM_BUILD_ROOT/usr/lib/perl5/site_perl/Pfacter
export PLIB=`perl -e 'print @INC[0]'`
install -c -m 755 pfacter $RPM_BUILD_ROOT/usr/bin/pfacter
install -c -m 755 lib/Pfacter.pm $RPM_BUILD_ROOT/usr/lib/perl5/site_perl/Pfacter.pm
install -c -m 755 lib/Pfacter/architecture.pm $RPM_BUILD_ROOT/usr/lib/perl5/site_perl/Pfacter/architecture.pm
install -c -m 755 lib/Pfacter/cfclasses.pm $RPM_BUILD_ROOT/usr/lib/perl5/site_perl/Pfacter/cfclasses.pm
install -c -m 755 lib/Pfacter/cfversion.pm $RPM_BUILD_ROOT/usr/lib/perl5/site_perl/Pfacter/cfversion.pm
install -c -m 755 lib/Pfacter/disk.pm $RPM_BUILD_ROOT/usr/lib/perl5/site_perl/Pfacter/disk.pm
install -c -m 755 lib/Pfacter/domain.pm $RPM_BUILD_ROOT/usr/lib/perl5/site_perl/Pfacter/domain.pm
install -c -m 755 lib/Pfacter/fqdn.pm $RPM_BUILD_ROOT/usr/lib/perl5/site_perl/Pfacter/fqdn.pm
install -c -m 755 lib/Pfacter/hardwaremanufacturer.pm $RPM_BUILD_ROOT/usr/lib/perl5/site_perl/Pfacter/hardwaremanufacturer.pm
install -c -m 755 lib/Pfacter/hardwaremodel.pm $RPM_BUILD_ROOT/usr/lib/perl5/site_perl/Pfacter/hardwaremodel.pm
install -c -m 755 lib/Pfacter/hardwareplatform.pm $RPM_BUILD_ROOT/usr/lib/perl5/site_perl/Pfacter/hardwareplatform.pm
install -c -m 755 lib/Pfacter/hardwareproduct.pm $RPM_BUILD_ROOT/usr/lib/perl5/site_perl/Pfacter/hardwareproduct.pm
install -c -m 755 lib/Pfacter/hostname.pm $RPM_BUILD_ROOT/usr/lib/perl5/site_perl/Pfacter/hostname.pm
install -c -m 755 lib/Pfacter/ipaddress.pm $RPM_BUILD_ROOT/usr/lib/perl5/site_perl/Pfacter/ipaddress.pm
install -c -m 755 lib/Pfacter/kernel.pm $RPM_BUILD_ROOT/usr/lib/perl5/site_perl/Pfacter/kernel.pm
install -c -m 755 lib/Pfacter/kernelrelease.pm $RPM_BUILD_ROOT/usr/lib/perl5/site_perl/Pfacter/kernelrelease.pm
install -c -m 755 lib/Pfacter/kernelversion.pm $RPM_BUILD_ROOT/usr/lib/perl5/site_perl/Pfacter/kernelversion.pm
install -c -m 755 lib/Pfacter/localtime.pm $RPM_BUILD_ROOT/usr/lib/perl5/site_perl/Pfacter/localtime.pm
install -c -m 755 lib/Pfacter/lsbdescription.pm $RPM_BUILD_ROOT/usr/lib/perl5/site_perl/Pfacter/lsbdescription.pm
install -c -m 755 lib/Pfacter/lsbid.pm $RPM_BUILD_ROOT/usr/lib/perl5/site_perl/Pfacter/lsbid.pm
install -c -m 755 lib/Pfacter/lsbrelease.pm $RPM_BUILD_ROOT/usr/lib/perl5/site_perl/Pfacter/lsbrelease.pm
install -c -m 755 lib/Pfacter/macaddress.pm $RPM_BUILD_ROOT/usr/lib/perl5/site_perl/Pfacter/macaddress.pm
install -c -m 755 lib/Pfacter/memory.pm $RPM_BUILD_ROOT/usr/lib/perl5/site_perl/Pfacter/memory.pm
install -c -m 755 lib/Pfacter/memorytotal.pm $RPM_BUILD_ROOT/usr/lib/perl5/site_perl/Pfacter/memorytotal.pm
install -c -m 755 lib/Pfacter/operatingsystem.pm $RPM_BUILD_ROOT/usr/lib/perl5/site_perl/Pfacter/operatingsystem.pm
install -c -m 755 lib/Pfacter/processor.pm $RPM_BUILD_ROOT/usr/lib/perl5/site_perl/Pfacter/processor.pm
install -c -m 755 lib/Pfacter/processorcount.pm $RPM_BUILD_ROOT/usr/lib/perl5/site_perl/Pfacter/processorcount.pm
install -c -m 755 lib/Pfacter/serialnumber.pm $RPM_BUILD_ROOT/usr/lib/perl5/site_perl/Pfacter/serialnumber.pm
install -c -m 755 lib/Pfacter/uniqueid.pm $RPM_BUILD_ROOT/usr/lib/perl5/site_perl/Pfacter/uniqueid.pm

%post

%clean
rm -rf $RPM_BUILD_ROOT

%files
/usr/bin/pfacter
/usr/lib/perl5/site_perl/Pfacter.pm
/usr/lib/perl5/site_perl/Pfacter/architecture.pm
/usr/lib/perl5/site_perl/Pfacter/cfclasses.pm
/usr/lib/perl5/site_perl/Pfacter/cfversion.pm
/usr/lib/perl5/site_perl/Pfacter/disk.pm
/usr/lib/perl5/site_perl/Pfacter/domain.pm
/usr/lib/perl5/site_perl/Pfacter/fqdn.pm
/usr/lib/perl5/site_perl/Pfacter/hardwaremanufacturer.pm
/usr/lib/perl5/site_perl/Pfacter/hardwaremodel.pm
/usr/lib/perl5/site_perl/Pfacter/hardwareplatform.pm
/usr/lib/perl5/site_perl/Pfacter/hardwareproduct.pm
/usr/lib/perl5/site_perl/Pfacter/hostname.pm
/usr/lib/perl5/site_perl/Pfacter/ipaddress.pm
/usr/lib/perl5/site_perl/Pfacter/kernel.pm
/usr/lib/perl5/site_perl/Pfacter/kernelrelease.pm
/usr/lib/perl5/site_perl/Pfacter/kernelversion.pm
/usr/lib/perl5/site_perl/Pfacter/localtime.pm
/usr/lib/perl5/site_perl/Pfacter/lsbdescription.pm
/usr/lib/perl5/site_perl/Pfacter/lsbid.pm
/usr/lib/perl5/site_perl/Pfacter/lsbrelease.pm
/usr/lib/perl5/site_perl/Pfacter/macaddress.pm
/usr/lib/perl5/site_perl/Pfacter/memory.pm
/usr/lib/perl5/site_perl/Pfacter/memorytotal.pm
/usr/lib/perl5/site_perl/Pfacter/operatingsystem.pm
/usr/lib/perl5/site_perl/Pfacter/processor.pm 
/usr/lib/perl5/site_perl/Pfacter/processorcount.pm 
/usr/lib/perl5/site_perl/Pfacter/serialnumber.pm 
/usr/lib/perl5/site_perl/Pfacter/uniqueid.pm

%changelog
* Tue Aug 21 2007 Scott Schneider <scott.schneider@vanderbilt.edu>
- Added hardwaremanufacturer and hardwareproduct facts
* Mon Jun 25 2007 Scott Schneider <scott.schneider@vanderbilt.edu>
- Added memory fact
- Updated AIX processing of processor and serialnumber facts
- Virtual address (e.g. eth0:1) within macaddress
- Parsing uber-dynamic (time/day/month-stamped) and seemingly
  worthless (entropy_*) data from cfclasses fact
- Debugging routine tweaked; additional relayed debugging information
- Multiple server values supported (with timeout)
- Various speed/redundancy code patches
* Tue May 01 2007 Scott Schneider <scott.schneider@vanderbilt.edu>
- Added cfversion and disk facts
- Kernel and application-specific module support
- Virtual address (e.g. eth0:1) within ipaddress
- Net::LDAP no longer required unless writing
* Wed Apr 18 2007 Scott Schneider <scott.schneider@vanderbilt.edu>
- Added cfclasses, localtime and serialnumber facts
* Thu Dec 21 2006 Scott Schneider <scott.schneider@vanderbilt.edu>
- Added lsbdescription, lsbid, lsbrelease, and processor facts
* Mon Nov 06 2006 Scott Schneider <scott.schneider@vanderbilt.edu>
- Added LDAP write support
* Wed Oct 11 2006 Scott Schneider <scott.schneider@vanderbilt.edu>
- Added domain, fqdn, ipaddress, and macaddress fact modules
- Added XML and YAML output support
- Most of the fact modules work under AIX now
* Tue Oct 10 2006 Scott Schneider <scott.schneider@vanderbilt.edu>
- initial spec file created