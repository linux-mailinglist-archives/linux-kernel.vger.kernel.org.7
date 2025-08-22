Return-Path: <linux-kernel+bounces-781947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADF5B31917
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1E79685C11
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546042FDC39;
	Fri, 22 Aug 2025 13:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WtbBqVC6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA2A33DF;
	Fri, 22 Aug 2025 13:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755868420; cv=none; b=KMkvf6sL8X0QEZurH9/kwODLnaCPOG4XPjaeNcvfTnqhofT4vQhacY5alO2c75jM5banqhoTfaBJ0ViQUw90L0i8LwTOcHQrYXOMA0Tos0fAAgXmesfCjhgyjfvbVOihoOPKGM+va4SCy0QAsuBC9C4WlpJ3MBGUxJ2UIJGgLiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755868420; c=relaxed/simple;
	bh=to2PW5L9ZA4+ZLuKmCSzsBNNcJnycnTz+AmHT7UpSxw=;
	h=From:To:Cc:Date:Subject:Message-ID:MIME-Version:Content-Type; b=kCAcUhVKEEz+Z8mhl3NjqKESwja53IArhzBoXiAN17WFib7soK4B+s0gLJLTEI9UD4nE8cuBFMsMjcOX2TnuoIjN7Is+yNe+kYoovJbOebNExl1WfWemfi4l4dcCmhGOCxTdus+vWhjXfSSTUqkDK9ZL2+8XfZd88VEy61qywu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WtbBqVC6; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755868419; x=1787404419;
  h=from:to:cc:date:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=to2PW5L9ZA4+ZLuKmCSzsBNNcJnycnTz+AmHT7UpSxw=;
  b=WtbBqVC6oHYGVZ3rUeIBaI8HrscdpbgU5DlNpafUuhP0FDqDjFa93mG7
   YmL20QuO4Jg5PdV/FlLwc0i9e6w4RKQVjbZE8ZIUUy04KMN9rtSDdAL6f
   7cbnkqHeqM1u5tPOGxyMNri33LyuCYYvTZ3oVrLKm5AKWujRx5SOapxu2
   sNwIgptDor13km2ByYYXTuNFIJaiza15D+27G+CaFMhKntaOQ8iGy6uzq
   kt1PzOE4TId8HTZkyVdclJsXsrh4e24j8H48iIJPJJmRRfowGmtIeZOLh
   KPek4f1TjND5wh9M2YjDRYiQBHoP5Qw2W+8UxwJrYzlFAJE5/qguyh+8q
   g==;
X-CSE-ConnectionGUID: yR1obXg+QHmqcMKk7XxHgQ==
X-CSE-MsgGUID: TnjtPrzTTnOxi8QQ4vlwuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="69614533"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="69614533"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 06:13:39 -0700
X-CSE-ConnectionGUID: DieSF0OTSd2huQJBZD+W+g==
X-CSE-MsgGUID: SEM/MNdhS+WBdiXyD8WvhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="168607523"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.115])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 06:13:35 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, PDx86 <platform-driver-x86@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andy@kernel.org>
Date: Fri, 22 Aug 2025 16:11:52 +0300
Subject: [GIT PULL] platform-drivers-x86 for v6.17-2
Message-ID: <pdx86-pr-20250822161152-256141077@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

Here is a platform-drivers-x86 fixes PR for v6.17.

Fixes and New HW Support:

 - amd/hsmp:

   - Ensure sock->metric_tbl_addr is non-NULL

   - Register driver even if hwmon registration fails

 - amd/pmc: Drop SMU F/W match for Cezanne

 - dell-smbios-wmi: Separate "priority" from WMI device ID

 - hp-wmi: mark Victus 16-r1xxx for Victus s fan and thermal profile support

 - intel-uncore-freq: Check write blocked for efficiency latency control

Regards, i.


The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.17-2

for you to fetch changes up to 748f897511446c7578ca5f6d2ff099916bad6e28:

  platform/x86: hp-wmi: mark Victus 16-r1xxx for victus_s fan and thermal profile support (2025-08-12 15:23:09 +0300)

----------------------------------------------------------------
platform-drivers-x86 for v6.17-2

Fixes and New HW Support:

 - amd/hsmp:

   - Ensure sock->metric_tbl_addr is non-NULL

   - Register driver even if hwmon registration fails

 - amd/pmc: Drop SMU F/W match for Cezanne

 - dell-smbios-wmi: Separate "priority" from WMI device ID

 - hp-wmi: mark Victus 16-r1xxx for Victus s fan and thermal profile support

 - intel-uncore-freq: Check write blocked for efficiency latency control

The following is an automated shortlog grouped by driver:

amd/hsmp:
 -  Ensure sock->metric_tbl_addr is non-NULL
 -  Ensure success even if hwmon registration fails

amd: pmc:
 -  Drop SMU F/W match for Cezanne

dell-smbios-wmi:
 -  Stop touching WMI device ID

hp-wmi:
 -  mark Victus 16-r1xxx for victus_s fan and thermal profile support

intel-uncore-freq:
 -  Check write blocked for ELC

----------------------------------------------------------------
Armin Wolf (1):
      platform/x86: dell-smbios-wmi: Stop touching WMI device ID

Edip Hazuri (1):
      platform/x86: hp-wmi: mark Victus 16-r1xxx for victus_s fan and thermal profile support

Mario Limonciello (1):
      platform/x86/amd: pmc: Drop SMU F/W match for Cezanne

Srinivas Pandruvada (1):
      platform/x86/intel-uncore-freq: Check write blocked for ELC

Suma Hegde (2):
      platform/x86/amd/hsmp: Ensure sock->metric_tbl_addr is non-NULL
      platform/x86/amd/hsmp: Ensure success even if hwmon registration fails

 drivers/platform/x86/amd/hsmp/acpi.c               |  2 +-
 drivers/platform/x86/amd/hsmp/hsmp.c               |  5 ++
 drivers/platform/x86/amd/pmc/pmc-quirks.c          | 54 ++++++++++++++--------
 drivers/platform/x86/amd/pmc/pmc.c                 | 13 ------
 drivers/platform/x86/dell/dell-smbios-base.c       | 19 ++++----
 drivers/platform/x86/dell/dell-smbios-smm.c        |  3 +-
 drivers/platform/x86/dell/dell-smbios-wmi.c        |  4 +-
 drivers/platform/x86/dell/dell-smbios.h            |  2 +-
 drivers/platform/x86/hp/hp-wmi.c                   |  4 +-
 .../intel/uncore-frequency/uncore-frequency-tpmi.c |  5 ++
 10 files changed, 59 insertions(+), 52 deletions(-)

