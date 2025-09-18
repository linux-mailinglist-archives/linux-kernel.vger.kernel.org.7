Return-Path: <linux-kernel+bounces-822346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D90B83977
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5817E1C03BD0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 08:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4392F9D82;
	Thu, 18 Sep 2025 08:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IXNY93mR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DFA2FF141;
	Thu, 18 Sep 2025 08:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758185464; cv=none; b=N/6Xwz9COoTMGtKhokG5dQJ2c2bwxd6AaP9MxFX3fYiXMvISfHrRds1bwgu+9E1e3KKmDfh0Af9YEXrbalYPvzIdUCiZYPiIMqbSE03pu2EhHwLu4mo9w7UVxAGTko1Q/TxO72PpV8pY6w+b9Iq6gSPaU0BNwcCUPYIs3cwbbHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758185464; c=relaxed/simple;
	bh=5YOyn+r75EASr5J9B8/mhrg6iM33iRQv6Vi25A5kHg4=;
	h=From:To:Cc:Date:Subject:Message-ID:MIME-Version:Content-Type; b=WQZmlhbDfhbKvTGwCwTWLT+6/QrAZxrvhdzz1LtLIuTLOsQOpgyv4rjVneRnCNMn8WmvUKmIU0rjSzfyIdOZjyb9nqikoUZixOug/Mq8dmxfvUk9obK5pwXYh1POOfnTlBL+1aghmAcWD6bx3iDC7WxIoyco+HkKh2ZQwRWPJlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IXNY93mR; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758185463; x=1789721463;
  h=from:to:cc:date:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=5YOyn+r75EASr5J9B8/mhrg6iM33iRQv6Vi25A5kHg4=;
  b=IXNY93mRf7Lnrtwuo0KUt0Ls7dgyqaTZj3iLwY32H7Kh7PmkYZD8szJD
   DgxhYzFPtjkQRvOI/2F+EGNQ4LOhFhDVMH+AHmy/fYhW3d5E9ocfOsKn/
   E5VYrUWjT/NHJhvmUQg1eXAK2+jNQsUsnXgfQcQ5F2qpAksGUYin6Ljgq
   +r55L0aJ1XXkOUI7t5fERX7Sl980lmXOdd3tW7g0LyipqjuOJCZfnzklI
   Z+fVBDTfmb4z0y+RKN04DVBcYNUo8o1cEgOUTvQ2pG3fol5N8Tg+vUQE/
   fg9sr0KvU6Aj2NHJKAqJbAOMwbnEDamr3xKBT+nMGt+1aWY8mIrMKD1vI
   g==;
X-CSE-ConnectionGUID: k8uuS8cNSC+UAB7F2CcawQ==
X-CSE-MsgGUID: BpLO0pMDQ1+EHSQXBGD3Xg==
X-IronPort-AV: E=McAfee;i="6800,10657,11556"; a="77946924"
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; 
   d="scan'208";a="77946924"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 01:51:02 -0700
X-CSE-ConnectionGUID: iqZZqgiHQaWu17Aii7rvrw==
X-CSE-MsgGUID: eR5RytUtQFm+tc0oP2jrFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; 
   d="scan'208";a="179484659"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.224])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 01:51:00 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, PDx86 <platform-driver-x86@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andy@kernel.org>
Date: Thu, 18 Sep 2025 11:49:18 +0300
Subject: [GIT PULL] platform-drivers-x86 for v6.17-4
Message-ID: <pdx86-pr-20250918114918-1887020842@linux.intel.com>
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

Fixes and New HW Support

- amd/pmc: Add MECHREVO Yilong15Pro to spurious_8042 list

- amd/pmf: Support new ACPI ID AMDI0108

- asus-wmi: Re-add extra keys to ignore_key_wlan quirk

- oxpec: Add support for AOKZOE A1X and OneXPlayer X1Pro EVA-02

Regards, i.


The following changes since commit aa28991fd5dc4c01a40caab2bd9af8c5e06f9899:

  platform/x86/intel: power-domains: Use topology_logical_package_id() for package ID (2025-08-29 16:15:19 +0300)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.17-4

for you to fetch changes up to 225d1ee0f5ba3218d1814d36564fdb5f37b50474:

  platform/x86: asus-wmi: Re-add extra keys to ignore_key_wlan quirk (2025-09-16 11:30:39 +0300)

----------------------------------------------------------------
platform-drivers-x86 for v6.17-4

Fixes and New HW Support

- amd/pmc: Add MECHREVO Yilong15Pro to spurious_8042 list

- amd/pmf: Support new ACPI ID AMDI0108

- asus-wmi: Re-add extra keys to ignore_key_wlan quirk

- oxpec: Add support for AOKZOE A1X and OneXPlayer X1Pro EVA-02

The following is an automated shortlog grouped by driver:

amd/pmc:
 -  Add MECHREVO Yilong15Pro to spurious_8042 list

amd/pmf:
 -  Support new ACPI ID AMDI0108

asus-wmi:
 -  Re-add extra keys to ignore_key_wlan quirk

oxpec:
 -  Add support for AOKZOE A1X
 -  Add support for OneXPlayer X1Pro EVA-02

----------------------------------------------------------------
Antheas Kapenekakis (3):
      platform/x86: oxpec: Add support for OneXPlayer X1Pro EVA-02
      platform/x86: oxpec: Add support for AOKZOE A1X
      platform/x86: asus-wmi: Re-add extra keys to ignore_key_wlan quirk

Shyam Sundar S K (1):
      platform/x86/amd/pmf: Support new ACPI ID AMDI0108

aprilgrimoire (1):
      platform/x86/amd/pmc: Add MECHREVO Yilong15Pro to spurious_8042 list

 drivers/platform/x86/amd/pmc/pmc-quirks.c |  8 ++++++++
 drivers/platform/x86/amd/pmf/core.c       |  1 +
 drivers/platform/x86/asus-nb-wmi.c        |  2 ++
 drivers/platform/x86/oxpec.c              | 14 ++++++++++++++
 4 files changed, 25 insertions(+)

