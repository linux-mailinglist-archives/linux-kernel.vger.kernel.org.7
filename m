Return-Path: <linux-kernel+bounces-747898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1D2B139E7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 13:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A9477A697A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 11:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB38025CC7A;
	Mon, 28 Jul 2025 11:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C2Zntdql"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F88222ACEF;
	Mon, 28 Jul 2025 11:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753702374; cv=none; b=EsndyowMZP9jqTeMeLSf3TL9y71vaSDQS65miC+I6uZC39zf0Bqwa39PiprsajNdaH/2TD6d6AToy37P2mTOy8osDHwSktYExjZXmKMpbn2eX28hDnwjCgUDhnTQRtR2/uE4qO6EjOHkwQsYWPkEtkoz85trTQdsb62ED5toPAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753702374; c=relaxed/simple;
	bh=D2dyKZNjq90EegLiQ1qfdabeoW1wqWXm0DDMxCLs9NI=;
	h=From:To:Cc:Date:Subject:Message-ID:MIME-Version:Content-Type; b=YRcPacwPFRY2NNcISZUMOwakbjAUyzzCruYVmC4LEDgcob1X15Hhgqfa4T2bw/tmXHeH/UCpxopsWUoTdpAMYmX3K29WLMujKsrS2UYt4tIdV7Ua+gLeZUD7QNoCp1eKp23VlUwzuu6G5BIkayGiu/iWcwzf3fa82fLkJ5WNWgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C2Zntdql; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753702373; x=1785238373;
  h=from:to:cc:date:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=D2dyKZNjq90EegLiQ1qfdabeoW1wqWXm0DDMxCLs9NI=;
  b=C2Zntdql+VUd2K+nSkBWOzrnwmZfGIDJGmGjbXVUrAxaaB+K62kom+no
   lOLjlzuksZ1TP/LGb8GhAA4GSGaz+Z9fJMQWdrz14Oratps/GAG+6Nvx8
   J66XURbr1f9EKDWe5hxhF6Uk5AbhqSIQj9kbXFsUl2hHOHEy0B3gUgD+U
   bdqQ/LcxKXAouw78eBpw2LVouCtH9Xpeb6gsVtvZoLfHPk45GHov6Gpay
   Qw/v19YRVoyhRhTLbetOY9oRg+cRepaORniaw2UboqRPvjOQ3VHzUq+NB
   m7SSUFDC71nbSJyRL1blK/XYhw1xL0C9c+LvdKaWqCP+zBthCbvKhC14i
   A==;
X-CSE-ConnectionGUID: +HOWXAQVT82US5eP8tLZvA==
X-CSE-MsgGUID: kdek5iWiSPqSrNP10KPbtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11504"; a="56096732"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="56096732"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 04:32:52 -0700
X-CSE-ConnectionGUID: diHWuHD2RlOsIs3xzBSy4Q==
X-CSE-MsgGUID: bEuHY9ntQRa5fVUd3SIQOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="166868920"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.244])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 04:32:49 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, PDx86 <platform-driver-x86@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andy@kernel.org>
Date: Mon, 28 Jul 2025 14:14:20 +0300
Subject: [GIT PULL] platform-drivers-x86 for v6.17-1
Message-ID: <pdx86-pr-20250728141420-2408727195@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

Here is the main PDx86 PR for v6.17. The changes are mostly contained
within pdx86. Only a minor change to drivers/powercap/intel_rapl_tpmi.c
due to struct renames & move from include to another, and to drm/xe to
correct crashlog related information.

Highlights

 - alienware: Add more precise labels to fans

 - amd/hsmp: Improve misleading probe errors (make the legacy driver
             aware when HSMP is supported through the ACPI driver)

 - amd/pmc: Add Lenovo Yoga 6 13ALCL6 to pmc quirk list

 - drm/xe: Correct (D)VSEC information to support PMT crashlog feature

 - fujitsu: Clamp charge threshold instead of returning an error

 - ideapad: Expore change types

 - intel/pmt:

   - Add PMT Discovery driver

   - Add API to retrieve telemetry regions by feature

   - Fix crashlog NULL access

   - Support Battlemage GPU (BMG) crashlog

 - intel/vsec:

   - Add Discovery feature

   - Add feature dependency support using device links

 - lenovo:

   - Move lenovo drivers under drivers/platform/x86/lenovo/

   - Add WMI drivers for Lenovo Gaming series

   - Improve DMI handling

 - oxpec:

   - Add support for OneXPlayer X1 Mini Pro (Strix Point variant)

   - Fix EC registers for G1 AMD

 - samsung-laptop: Expose change types

 - wmi: Fix WMI device naming issue (same GUID corner cases)

 - x86-android-tables: Add ovc-capacity-table to generic battery nodes

 - Miscellaneous cleanups / refactoring / improvements

Regards, i.


The following changes since commit e2967b50b709970547b5cdfa1b42526835327f36:

  MAINTAINERS: Update entries for IFS and SBL drivers (2025-07-21 14:38:19 +0300)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.17-1

for you to fetch changes up to 1798561befd8be1e52feb54f850efcab5a595f43:

  platform/x86: oxpec: Add support for OneXPlayer X1 Mini Pro (Strix Point) (2025-07-22 17:45:37 +0300)

----------------------------------------------------------------
platform-drivers-x86 for v6.17-1

Highlights

 - alienware: Add more precise labels to fans

 - amd/hsmp: Improve misleading probe errors (make the legacy driver
             aware when HSMP is supported through the ACPI driver)

 - amd/pmc: Add Lenovo Yoga 6 13ALCL6 to pmc quirk list

 - drm/xe: Correct (D)VSEC information to support PMT crashlog feature

 - fujitsu: Clamp charge threshold instead of returning an error

 - ideapad: Expore change types

 - intel/pmt:

   - Add PMT Discovery driver

   - Add API to retrieve telemetry regions by feature

   - Fix crashlog NULL access

   - Support Battlemage GPU (BMG) crashlog

 - intel/vsec:

   - Add Discovery feature

   - Add feature dependency support using device links

 - lenovo:

   - Move lenovo drivers under drivers/platform/x86/lenovo/

   - Add WMI drivers for Lenovo Gaming series

   - Improve DMI handling

 - oxpec:

   - Add support for OneXPlayer X1 Mini Pro (Strix Point variant)

   - Fix EC registers for G1 AMD

 - samsung-laptop: Expose change types

 - wmi: Fix WMI device naming issue (same GUID corner cases)

 - x86-android-tables: Add ovc-capacity-table to generic battery nodes

 - Miscellaneous cleanups / refactoring / improvements

The following is an automated shortlog grouped by driver:

Add Lenovo Capability Data 01 WMI Driver:
 - Add Lenovo Capability Data 01 WMI Driver

Add Lenovo Gamezone WMI Driver:
 - Add Lenovo Gamezone WMI Driver

Add Lenovo Other Mode WMI Driver:
 - Add Lenovo Other Mode WMI Driver

Add lenovo-wmi-* driver Documentation:
 - Add lenovo-wmi-* driver Documentation

Add Lenovo WMI Events Driver:
 - Add Lenovo WMI Events Driver

Add lenovo-wmi-helpers:
 - Add lenovo-wmi-helpers

alienware-wmi-wmax:
 -  Add appropriate labels to fans

amd/hsmp:
 -  Enhance the print messages to prevent confusion
 -  Use IS_ENABLED() instead of IS_REACHABLE()

amd: pmc:
 -  Add Lenovo Yoga 6 13ALC6 to pmc quirk list

arm64: lenovo-yoga-c630:
 -  use the auxiliary device creation helper

dell_rbu:
 -  Remove unused struct

dell-uart-backlight:
 -  Use blacklight power constant

docs:
 -  Add ABI documentation for intel_pmt feature directories

Documentation: ABI:
 -  Update WMI device paths in ABI docs

drm/xe:
 -  Correct BMG VSEC header sizing
 -  Correct the rev value for the DVSEC entries

fujitsu:
 -  clamp charge_control_end_threshold values to 50
 -  use unsigned int for kstrtounit

ideapad:
 -  Expose charge_types

intel/pmt:
 -  Add PMT Discovery driver
 -  add register access helpers
 -  correct types
 -  decouple sysfs and namespace

intel/pmt/discovery:
 -  fix format string warning
 -  Fix size_t specifiers for 32-bit
 -  Get telemetry attributes

intel/pmt:
 -  fix a crashlog NULL pointer access
 -  fix build dependency for kunit test
 -  KUNIT test for PMT Enhanced Discovery API
 -  mutex clean up
 -  refactor base parameter
 -  re-order trigger logic
 -  support BMG crashlog

intel/pmt/telemetry:
 -  Add API to retrieve telemetry regions by feature

intel/pmt:
 -  use a version struct
 -  use guard(mutex)
 -  white space cleanup

intel_telemetry:
 -  Remove unused telemetry_*_events()
 -  Remove unused telemetry_[gs]et_sampling_period()
 -  Remove unused telemetry_raw_read_events()

intel/tpmi:
 -  Get OOBMSM CPU mapping from TPMI
 -  Relocate platform info to intel_vsec.h

intel/vsec:
 -  Add device links to enforce dependencies
 -  Add new Discovery feature
 -  Add private data for per-device data
 -  Create wrapper to walk PCI config space
 -  Set OOBMSM to CPU mapping
 -  Skip absent features during initialization
 -  Skip driverless features

lenovo:
 -  gamezone needs "other mode"

lenovo-yoga-tab2-pro-1380-fastcharger:
 -  Use devm_pinctrl_register_mappings()

MAINTAINERS:
 -  Add link to documentation of Intel PMT ABI

Move Lenovo files into lenovo subdir:
 - Move Lenovo files into lenovo subdir

oxpec:
 -  Add support for OneXPlayer X1 Mini Pro (Strix Point)
 -  Fix turbo register for G1 AMD

samsung-laptop:
 -  Expose charge_types

silicom:
 -  remove unnecessary GPIO line direction check

thinklmi:
 -  improved DMI handling

thinkpad_acpi:
 -  Handle KCOV __init vs inline mismatches

wmi:
 -  Fix WMI device naming issue

x86-android-tablets:
 -  Add generic_lipo_4v2_battery info
 -  Add ovc-capacity-table info

Merges:
 -  Merge branch 'fixes' into 'for-next'
 -  Merge branch 'fixes' into for-next

----------------------------------------------------------------
Antheas Kapenekakis (2):
      platform/x86: oxpec: Fix turbo register for G1 AMD
      platform/x86: oxpec: Add support for OneXPlayer X1 Mini Pro (Strix Point)

Armin Wolf (2):
      Documentation: ABI: Update WMI device paths in ABI docs
      platform/x86: wmi: Fix WMI device naming issue

Arnd Bergmann (3):
      platform/x86/intel/pmt/discovery: fix format string warning
      platform/x86: lenovo: gamezone needs "other mode"
      platform/x86/intel/pmt: fix build dependency for kunit test

Bartosz Golaszewski (1):
      platform/x86: silicom: remove unnecessary GPIO line direction check

David E. Box (15):
      MAINTAINERS: Add link to documentation of Intel PMT ABI
      platform/x86/intel/vsec: Add private data for per-device data
      platform/x86/intel/vsec: Create wrapper to walk PCI config space
      platform/x86/intel/vsec: Add device links to enforce dependencies
      platform/x86/intel/vsec: Skip absent features during initialization
      platform/x86/intel/vsec: Skip driverless features
      platform/x86/intel/vsec: Add new Discovery feature
      platform/x86/intel/pmt: Add PMT Discovery driver
      docs: Add ABI documentation for intel_pmt feature directories
      platform/x86/intel/tpmi: Relocate platform info to intel_vsec.h
      platform/x86/intel/vsec: Set OOBMSM to CPU mapping
      platform/x86/intel/tpmi: Get OOBMSM CPU mapping from TPMI
      platform/x86/intel/pmt/discovery: Get telemetry attributes
      platform/x86/intel/pmt/telemetry: Add API to retrieve telemetry regions by feature
      platform/x86/intel/pmt: KUNIT test for PMT Enhanced Discovery API

Derek J. Clark (6):
      platform/x86: Add lenovo-wmi-* driver Documentation
      platform/x86: Add lenovo-wmi-helpers
      platform/x86: Add Lenovo WMI Events Driver
      platform/x86: Add Lenovo Capability Data 01 WMI Driver
      platform/x86: Add Lenovo Gamezone WMI Driver
      platform/x86: Add Lenovo Other Mode WMI Driver

Dr. David Alan Gilbert (3):
      platform/x86: intel_telemetry: Remove unused telemetry_*_events()
      platform/x86: intel_telemetry: Remove unused telemetry_[gs]et_sampling_period()
      platform/x86: intel_telemetry: Remove unused telemetry_raw_read_events()

Hans de Goede (2):
      platform/x86: x86-android-tablets: Add generic_lipo_4v2_battery info
      platform/x86: x86-android-tablets: Add ovc-capacity-table info

Ilpo Järvinen (2):
      Merge branch 'fixes' into for-next
      Merge branch 'fixes' into 'for-next'

Jelle van der Waa (4):
      platform/x86: ideapad: Expose charge_types
      platform/x86: fujitsu: use unsigned int for kstrtounit
      platform/x86: fujitsu: clamp charge_control_end_threshold values to 50
      platform/x86: samsung-laptop: Expose charge_types

Jerome Brunet (1):
      platform: arm64: lenovo-yoga-c630: use the auxiliary device creation helper

Kees Cook (1):
      platform/x86: thinkpad_acpi: Handle KCOV __init vs inline mismatches

Kurt Borja (1):
      platform/x86: alienware-wmi-wmax: Add appropriate labels to fans

Mario Limonciello (1):
      platform/x86/amd: pmc: Add Lenovo Yoga 6 13ALC6 to pmc quirk list

Mark Pearson (2):
      platform/x86: thinklmi: improved DMI handling
      platform/x86: Move Lenovo files into lenovo subdir

Michael J. Ruhl (13):
      platform/x86/intel/pmt: fix a crashlog NULL pointer access
      drm/xe: Correct the rev value for the DVSEC entries
      drm/xe: Correct BMG VSEC header sizing
      platform/x86/intel/pmt: white space cleanup
      platform/x86/intel/pmt: mutex clean up
      platform/x86/intel/pmt: use guard(mutex)
      platform/x86/intel/pmt: re-order trigger logic
      platform/x86/intel/pmt: correct types
      platform/x86/intel/pmt: decouple sysfs and namespace
      platform/x86/intel/pmt: add register access helpers
      platform/x86/intel/pmt: refactor base parameter
      platform/x86/intel/pmt: use a version struct
      platform/x86/intel/pmt: support BMG crashlog

Nathan Chancellor (1):
      platform/x86/intel/pmt/discovery: Fix size_t specifiers for 32-bit

Stuart Hayes (1):
      platform/x86: dell_rbu: Remove unused struct

Suma Hegde (2):
      platform/x86/amd/hsmp: Use IS_ENABLED() instead of IS_REACHABLE()
      platform/x86/amd/hsmp: Enhance the print messages to prevent confusion

Thomas Richard (1):
      platform/x86: lenovo-yoga-tab2-pro-1380-fastcharger: Use devm_pinctrl_register_mappings()

Thomas Zimmermann (1):
      platform/x86: dell-uart-backlight: Use blacklight power constant

 .../ABI/obsolete/sysfs-driver-samsung-laptop       |  10 +
 .../ABI/obsolete/sysfs-platform-ideapad-laptop     |   8 +
 .../ABI/testing/sysfs-class-intel_pmt-features     | 134 +++++
 .../ABI/testing/sysfs-driver-samsung-laptop        |  11 -
 .../ABI/testing/sysfs-platform-dell-privacy-wmi    |   8 +-
 .../ABI/testing/sysfs-platform-ideapad-laptop      |   9 -
 .../testing/sysfs-platform-intel-wmi-sbl-fw-update |   2 +-
 .../testing/sysfs-platform-intel-wmi-thunderbolt   |   2 +-
 Documentation/admin-guide/thunderbolt.rst          |   9 +-
 Documentation/wmi/devices/lenovo-wmi-gamezone.rst  | 203 +++++++
 Documentation/wmi/devices/lenovo-wmi-other.rst     | 108 ++++
 MAINTAINERS                                        |  21 +-
 arch/x86/include/asm/intel_telemetry.h             |  37 --
 drivers/gpu/drm/xe/xe_vsec.c                       |  20 +-
 drivers/platform/arm64/lenovo-yoga-c630.c          |  40 +-
 drivers/platform/x86/Kconfig                       | 239 +-------
 drivers/platform/x86/Makefile                      |  13 +-
 drivers/platform/x86/amd/hsmp/acpi.c               |   9 +-
 drivers/platform/x86/amd/hsmp/hsmp.h               |   3 +-
 drivers/platform/x86/amd/hsmp/plat.c               |  28 +-
 drivers/platform/x86/amd/pmc/pmc-quirks.c          |   9 +
 drivers/platform/x86/dell/alienware-wmi-wmax.c     | 100 ++--
 drivers/platform/x86/dell/dell-uart-backlight.c    |   2 +-
 drivers/platform/x86/dell/dell_rbu.c               |  10 +-
 drivers/platform/x86/fujitsu-laptop.c              |   8 +-
 drivers/platform/x86/intel/plr_tpmi.c              |   3 +-
 drivers/platform/x86/intel/pmt/Kconfig             |  28 +
 drivers/platform/x86/intel/pmt/Makefile            |   4 +
 drivers/platform/x86/intel/pmt/class.c             |  50 +-
 drivers/platform/x86/intel/pmt/class.h             |  12 +-
 drivers/platform/x86/intel/pmt/crashlog.c          | 459 +++++++++++---
 drivers/platform/x86/intel/pmt/discovery-kunit.c   | 116 ++++
 drivers/platform/x86/intel/pmt/discovery.c         | 635 ++++++++++++++++++++
 drivers/platform/x86/intel/pmt/features.c          | 205 +++++++
 drivers/platform/x86/intel/pmt/telemetry.c         |  94 ++-
 .../x86/intel/speed_select_if/isst_tpmi_core.c     |   9 +-
 drivers/platform/x86/intel/telemetry/core.c        | 177 ------
 drivers/platform/x86/intel/telemetry/pltdrv.c      | 231 -------
 .../intel/uncore-frequency/uncore-frequency-tpmi.c |   7 +-
 drivers/platform/x86/intel/vsec.c                  | 372 +++++++++++-
 drivers/platform/x86/intel/vsec_tpmi.c             |   8 +-
 drivers/platform/x86/lenovo/Kconfig                | 276 +++++++++
 drivers/platform/x86/lenovo/Makefile               |  28 +
 drivers/platform/x86/{ => lenovo}/ideapad-laptop.c | 110 +++-
 drivers/platform/x86/{ => lenovo}/ideapad-laptop.h |   0
 drivers/platform/x86/{ => lenovo}/think-lmi.c      |  10 +-
 drivers/platform/x86/{ => lenovo}/think-lmi.h      |   0
 drivers/platform/x86/{ => lenovo}/thinkpad_acpi.c  |   6 +-
 .../{lenovo-wmi-camera.c => lenovo/wmi-camera.c}   |   0
 drivers/platform/x86/lenovo/wmi-capdata01.c        | 302 ++++++++++
 drivers/platform/x86/lenovo/wmi-capdata01.h        |  25 +
 drivers/platform/x86/lenovo/wmi-events.c           | 196 ++++++
 drivers/platform/x86/lenovo/wmi-events.h           |  20 +
 drivers/platform/x86/lenovo/wmi-gamezone.c         | 407 +++++++++++++
 drivers/platform/x86/lenovo/wmi-gamezone.h         |  20 +
 drivers/platform/x86/lenovo/wmi-helpers.c          |  74 +++
 drivers/platform/x86/lenovo/wmi-helpers.h          |  20 +
 .../wmi-hotkey-utilities.c}                        |   0
 drivers/platform/x86/lenovo/wmi-other.c            | 665 +++++++++++++++++++++
 drivers/platform/x86/lenovo/wmi-other.h            |  16 +
 .../platform/x86/{lenovo-ymc.c => lenovo/ymc.c}    |   0
 .../yoga-tab2-pro-1380-fastcharger.c}              |  35 +-
 .../x86/{lenovo-yogabook.c => lenovo/yogabook.c}   |   0
 drivers/platform/x86/oxpec.c                       |  44 +-
 drivers/platform/x86/samsung-laptop.c              | 110 ++++
 drivers/platform/x86/silicom-platform.c            |   4 -
 drivers/platform/x86/wmi.c                         |  37 +-
 drivers/platform/x86/x86-android-tablets/asus.c    |  21 +-
 .../x86/x86-android-tablets/shared-psy-info.c      |  76 +++
 .../x86/x86-android-tablets/shared-psy-info.h      |   1 +
 drivers/powercap/intel_rapl_tpmi.c                 |   9 +-
 include/linux/intel_pmt_features.h                 | 157 +++++
 include/linux/intel_tpmi.h                         |  27 +-
 include/linux/intel_vsec.h                         |  98 ++-
 74 files changed, 5187 insertions(+), 1060 deletions(-)
 create mode 100644 Documentation/ABI/obsolete/sysfs-driver-samsung-laptop
 create mode 100644 Documentation/ABI/obsolete/sysfs-platform-ideapad-laptop
 create mode 100644 Documentation/ABI/testing/sysfs-class-intel_pmt-features
 create mode 100644 Documentation/wmi/devices/lenovo-wmi-gamezone.rst
 create mode 100644 Documentation/wmi/devices/lenovo-wmi-other.rst
 create mode 100644 drivers/platform/x86/intel/pmt/discovery-kunit.c
 create mode 100644 drivers/platform/x86/intel/pmt/discovery.c
 create mode 100644 drivers/platform/x86/intel/pmt/features.c
 create mode 100644 drivers/platform/x86/lenovo/Kconfig
 create mode 100644 drivers/platform/x86/lenovo/Makefile
 rename drivers/platform/x86/{ => lenovo}/ideapad-laptop.c (95%)
 rename drivers/platform/x86/{ => lenovo}/ideapad-laptop.h (100%)
 rename drivers/platform/x86/{ => lenovo}/think-lmi.c (99%)
 rename drivers/platform/x86/{ => lenovo}/think-lmi.h (100%)
 rename drivers/platform/x86/{ => lenovo}/thinkpad_acpi.c (99%)
 rename drivers/platform/x86/{lenovo-wmi-camera.c => lenovo/wmi-camera.c} (100%)
 create mode 100644 drivers/platform/x86/lenovo/wmi-capdata01.c
 create mode 100644 drivers/platform/x86/lenovo/wmi-capdata01.h
 create mode 100644 drivers/platform/x86/lenovo/wmi-events.c
 create mode 100644 drivers/platform/x86/lenovo/wmi-events.h
 create mode 100644 drivers/platform/x86/lenovo/wmi-gamezone.c
 create mode 100644 drivers/platform/x86/lenovo/wmi-gamezone.h
 create mode 100644 drivers/platform/x86/lenovo/wmi-helpers.c
 create mode 100644 drivers/platform/x86/lenovo/wmi-helpers.h
 rename drivers/platform/x86/{lenovo-wmi-hotkey-utilities.c => lenovo/wmi-hotkey-utilities.c} (100%)
 create mode 100644 drivers/platform/x86/lenovo/wmi-other.c
 create mode 100644 drivers/platform/x86/lenovo/wmi-other.h
 rename drivers/platform/x86/{lenovo-ymc.c => lenovo/ymc.c} (100%)
 rename drivers/platform/x86/{lenovo-yoga-tab2-pro-1380-fastcharger.c => lenovo/yoga-tab2-pro-1380-fastcharger.c} (92%)
 rename drivers/platform/x86/{lenovo-yogabook.c => lenovo/yogabook.c} (100%)
 create mode 100644 include/linux/intel_pmt_features.h

