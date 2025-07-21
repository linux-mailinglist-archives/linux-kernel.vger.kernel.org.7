Return-Path: <linux-kernel+bounces-739282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27349B0C44F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 14:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4988A1646A0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 12:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85442D3EF3;
	Mon, 21 Jul 2025 12:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TLxnjdxm"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7772942A9B;
	Mon, 21 Jul 2025 12:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753101849; cv=none; b=r7IDvEwXWOICr23qa4UgGOrZZAC+wUlSz8PZBITwlHeAMmMz6Wm3o+Ra93TsYJ9uLwb7DwwBxisdOMdeautdls8yB3zkmaP4GUw/WJY646lGAj7I0YjSEDONp3kmVhhGTeoyJisYzzGony/H0s28TKyUY82J1Y+yNCttTIx//Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753101849; c=relaxed/simple;
	bh=2rqEcY3+vS6y9IkHDgy65e3CbWCUIfoGhGJDb3Byk9I=;
	h=From:To:Cc:Date:Subject:Message-ID:MIME-Version:Content-Type; b=K0bCwVzcETl8Y+/nCvma+0/XlEFJFg9tWunEK2DlsV1XAcPoj4ozRFHvr1Sdp4duuSmd/mNuld4499CoClqXNKO6RbGkrBTxnjMm5X6CLL5P/3JPIO9QOQ3+APmmiougx1uz0+mYhHuvybZNa1Zbzx6va2mCfOk8B46zVr+BHlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TLxnjdxm; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753101848; x=1784637848;
  h=from:to:cc:date:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=2rqEcY3+vS6y9IkHDgy65e3CbWCUIfoGhGJDb3Byk9I=;
  b=TLxnjdxm4TIpIQuuds4RoIibW3/k/XzDQkEUMSYgcEs6Ap/zq6Vd6leE
   vP3jukdx1SMR4y2AtbBytZX8VRAvnOz8zwmmFZKWtMMQVb6Y2frdkneRS
   kCE0CEOoSy/gHxHfeRn9MhB+UmoKdq3uVAfntHMlaFPi30c2apRA8eheN
   wnABfZ5a3ap6HvNtFr7FujOqaEE7RBXkukSfLWrOqa+ULG3VStyihOl80
   jrPou8/pDChMhT5B3NpcqUqDtWw0HhB9KnWIJ7OC+7ADPL0aosIcRkpoJ
   7p9fi1Ll/6382Hc88a6TDmYYjAtnbEHc7JZTiztzcYonJShtqVJn/e7Io
   w==;
X-CSE-ConnectionGUID: TdGSKpMCTLu1xi19boMspA==
X-CSE-MsgGUID: L+BJVMjwQQ6MScKGD3i0Nw==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="54414859"
X-IronPort-AV: E=Sophos;i="6.16,329,1744095600"; 
   d="scan'208";a="54414859"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 05:44:07 -0700
X-CSE-ConnectionGUID: +zHVWkR/Q6uJx4aFuUAQCA==
X-CSE-MsgGUID: iH8XBT6mT+akVTuW5wqG7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,329,1744095600"; 
   d="scan'208";a="158612766"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.225])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 05:44:05 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, PDx86 <platform-driver-x86@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andy@kernel.org>
Date: Mon, 21 Jul 2025 15:38:07 +0300
Subject: [GIT PULL] platform-drivers-x86 for v6.16-4
Message-ID: <pdx86-pr-20250721153807-334719879@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

Here is a platform-drivers-x86 fixes PR for v6.16.

There's one power supply accessor change to support solving pdx86 lock
double take issue (upcoming pdx86 for-next work depends on the same API
so we chose to route it through pdx86 tree).

Fixes and New HW Support

- alienware-wmi-wmax:

  - Add AWCC support for Alienware Area-51m and m15 R5.

  - Fix `dmi_system_id` array termination

- arm64: huawei-gaokun-ec: fix OF node leak

- dell-ddv: Fix taking psy->extensions_sem twice

- dell-lis3lv02d: Add Precision 3551 accelerometer support

- firmware_attributes_class: Fix initialization order

- ideapad-laptop: Retain FnLock and kbd backlight across boots

- lenovo-wmi-hotkey: Avoid triggering error -5 due to missing mute LED

- mellanox: mlxbf-pmc: Validate event names and bool input

- power: supply: Add get/set property direct to allow avoiding taking
                 psy->extensions_sem twice from power supply extensions

Regards, i.


The following changes since commit 4f30f946f27b7f044cf8f3f1f353dee1dcd3517a:

  platform/x86: think-lmi: Fix sysfs group cleanup (2025-07-02 12:01:25 +0300)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.16-4

for you to fetch changes up to e2967b50b709970547b5cdfa1b42526835327f36:

  MAINTAINERS: Update entries for IFS and SBL drivers (2025-07-21 14:38:19 +0300)

----------------------------------------------------------------
platform-drivers-x86 for v6.16-4

Fixes and New HW Support

- alienware-wmi-wmax:

  - Add AWCC support for Alienware Area-51m and m15 R5.

  - Fix `dmi_system_id` array termination

- arm64: huawei-gaokun-ec: fix OF node leak

- dell-ddv: Fix taking psy->extensions_sem twice

- dell-lis3lv02d: Add Precision 3551 accelerometer support

- firmware_attributes_class: Fix initialization order

- ideapad-laptop: Retain FnLock and kbd backlight across boots

- lenovo-wmi-hotkey: Avoid triggering error -5 due to missing mute LED

- mellanox: mlxbf-pmc: Validate event names and bool input

- power: supply: Add get/set property direct to allow avoiding taking
                 psy->extensions_sem twice from power supply extensions

The following is an automated shortlog grouped by driver:

alieneware-wmi-wmax:
 -  Add AWCC support to more laptops

alienware-wmi-wmax:
 -  Fix `dmi_system_id` array

arm64: huawei-gaokun-ec:
 -  fix OF node leak

dell-ddv:
 -  Fix taking the psy->extensions_sem lock twice

dell-lis3lv02d:
 -  Add Precision 3551

Fix initialization order for firmware_attributes_class:
 - Fix initialization order for firmware_attributes_class

ideapad-laptop:
 -  Fix FnLock not remembered among boots
 -  Fix kbd backlight not remembered among boots

lenovo-wmi-hotkey:
 -  Avoid triggering error -5 due to missing mute LED

MAINTAINERS:
 -  Update entries for IFS and SBL drivers

mlxbf-pmc:
 -  Remove newline char from event name input
 -  Use kstrtobool() to check 0/1 input
 -  Validate event/enable input

power: supply: core:
 -  Add power_supply_get/set_property_direct()

power: supply: test-power:
 -  Test access to extended power supply

----------------------------------------------------------------
Armin Wolf (3):
      power: supply: core: Add power_supply_get/set_property_direct()
      power: supply: test-power: Test access to extended power supply
      platform/x86: dell-ddv: Fix taking the psy->extensions_sem lock twice

Jackie Dong (1):
      lenovo-wmi-hotkey: Avoid triggering error -5 due to missing mute LED

Jan-Niklas Burfeind (1):
      platform/x86: dell-lis3lv02d: Add Precision 3551

Jithu Joseph (1):
      MAINTAINERS: Update entries for IFS and SBL drivers

Johan Hovold (1):
      platform: arm64: huawei-gaokun-ec: fix OF node leak

Kurt Borja (2):
      platform/x86: alienware-wmi-wmax: Fix `dmi_system_id` array
      platform/x86: alieneware-wmi-wmax: Add AWCC support to more laptops

Rong Zhang (2):
      platform/x86: ideapad-laptop: Fix FnLock not remembered among boots
      platform/x86: ideapad-laptop: Fix kbd backlight not remembered among boots

Shravan Kumar Ramani (3):
      platform/mellanox: mlxbf-pmc: Remove newline char from event name input
      platform/mellanox: mlxbf-pmc: Validate event/enable input
      platform/mellanox: mlxbf-pmc: Use kstrtobool() to check 0/1 input

Torsten Hilbrich (1):
      platform/x86: Fix initialization order for firmware_attributes_class

 MAINTAINERS                                        |  6 +-
 drivers/platform/arm64/huawei-gaokun-ec.c          |  2 +
 drivers/platform/mellanox/mlxbf-pmc.c              | 25 ++++---
 drivers/platform/x86/Makefile                      |  3 +-
 drivers/platform/x86/dell/alienware-wmi-wmax.c     | 17 +++++
 drivers/platform/x86/dell/dell-lis3lv02d.c         |  1 +
 drivers/platform/x86/dell/dell-wmi-ddv.c           | 10 ++-
 drivers/platform/x86/ideapad-laptop.c              |  4 +-
 drivers/platform/x86/lenovo-wmi-hotkey-utilities.c | 30 +++++---
 drivers/power/supply/power_supply_core.c           | 82 ++++++++++++++++++----
 drivers/power/supply/test_power.c                  |  4 ++
 include/linux/power_supply.h                       |  8 +++
 12 files changed, 153 insertions(+), 39 deletions(-)

