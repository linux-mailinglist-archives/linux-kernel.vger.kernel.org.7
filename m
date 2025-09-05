Return-Path: <linux-kernel+bounces-802916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC9CB4585A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD55CA03B85
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 13:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D1B189919;
	Fri,  5 Sep 2025 13:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dw7AHtgK"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49BB35958;
	Fri,  5 Sep 2025 13:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757077288; cv=none; b=e2YBIguuMC/8e85jf+QIoQA37Yg8reMxgmy3+xnIG6guQSXEErZnlU+SXsYFsKRDAyw/N5LTgT1RBhWpxitzJ3tFkmuNOdIFQWfSALz1GolqWyOTFIlKW4CHCWgT6a/8ZmTacOrRzBlgCAncC1+tpavOlikU0FIXyAhYQtpHHDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757077288; c=relaxed/simple;
	bh=Lk6l27CAGGMD3sUNRp/aDuOiTabHjb5g0+QfK/Qcwqc=;
	h=From:To:Cc:Date:Subject:Message-ID:MIME-Version:Content-Type; b=L5ti92Bh3JhNIKGohp7BtCbRAQb3ZLB6TKVFHRItxwBQoeAdwkfnN3eu2NRUEjkYFvQgQg2uoS+NueNK7UhlOvdNa1Svd2CuBa8+jOhvrH/SgK0oMVFXFNW46UggrhLZmlVinaQ7u5hNmCYD6w4lmZChVOy2BIKLf7GHFw7ROOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dw7AHtgK; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757077287; x=1788613287;
  h=from:to:cc:date:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Lk6l27CAGGMD3sUNRp/aDuOiTabHjb5g0+QfK/Qcwqc=;
  b=dw7AHtgKILgu5jMqZSavJgvPT/p71e3C/GondlodPAK99jB3RZyL75Vi
   l5JH3sENoOTVAyWUP0c7TYQC+TqeyZWxlz4NElFy4WivdR5AcLlIhYxet
   fe2ZSn4vY1XQo4+sZeEmz1HW7gMCmIYe5XBCelExK9E6H9ILcg+X0EP6r
   185J5DOSMn1jXenyZ4u2P8aBXBwFK/zckTaCw2ksznddyI4ooneDr35Lt
   4Wv7yQkDN+htstu+takJt45c9pdNhRV22oYLOJNocvTccWc8+P8Z5Egpn
   RZFg/8mYC4PgevXtz57Jgscgb5JRbru1eeZ9zERIb6x2ngnqy0if1GD1y
   A==;
X-CSE-ConnectionGUID: i2KAfMqFTJSpm2Ur49yfVg==
X-CSE-MsgGUID: Wdd1qmCERkqPl6drbF/iHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11543"; a="58639332"
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; 
   d="scan'208";a="58639332"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 06:01:25 -0700
X-CSE-ConnectionGUID: SSqCjUP4SKOdgP21m40tNQ==
X-CSE-MsgGUID: roMetjM5TfaJ+NXnWjFBvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; 
   d="scan'208";a="172510140"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.51])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 06:01:22 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, PDx86 <platform-driver-x86@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andy@kernel.org>
Date: Fri, 05 Sep 2025 15:59:05 +0300
Subject: [GIT PULL] platform-drivers-x86 for v6.17-3
Message-ID: <pdx86-pr-20250905155905-179965085@linux.intel.com>
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

- acer-wmi: Stop using ACPI bitmap for platform profile choices

- amd/hfi: Fix pcct_tbl leak

- amd/pmc: Add TUXEDO IB Pro Gen10 AMD to spurious 8042 quirks

- asus-wmi:

    - Fix registration races

    - Fix ROG button mapping, tablet mode on ASUS ROG Z13

    - Support more keys on ExpertBook B9

- hp-wmi: Add support for Fn+P hotkey

- intel/pmc: Add Bartlett Lake support

- intel/power-domains: Use topology_logical_package_id() for package ID

Regards, i.


The following changes since commit 748f897511446c7578ca5f6d2ff099916bad6e28:

  platform/x86: hp-wmi: mark Victus 16-r1xxx for victus_s fan and thermal profile support (2025-08-12 15:23:09 +0300)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.17-3

for you to fetch changes up to aa28991fd5dc4c01a40caab2bd9af8c5e06f9899:

  platform/x86/intel: power-domains: Use topology_logical_package_id() for package ID (2025-08-29 16:15:19 +0300)

----------------------------------------------------------------
platform-drivers-x86 for v6.17-3

Fixes and New HW Support

- acer-wmi: Stop using ACPI bitmap for platform profile choices

- amd/hfi: Fix pcct_tbl leak

- amd/pmc: Add TUXEDO IB Pro Gen10 AMD to spurious 8042 quirks

- asus-wmi:

    - Fix registration races

    - Fix ROG button mapping, tablet mode on ASUS ROG Z13

    - Support more keys on ExpertBook B9

- hp-wmi: Add support for Fn+P hotkey

- intel/pmc: Add Bartlett Lake support

- intel/power-domains: Use topology_logical_package_id() for package ID

The following is an automated shortlog grouped by driver:

acer-wmi:
 -  Stop using ACPI bitmap for platform profile choices

amd: hfi:
 -  Fix pcct_tbl leak in amd_hfi_metadata_parser()

amd/pmc:
 -  Add TUXEDO IB Pro Gen10 AMD to spurious 8042 quirks list

asus-wmi:
 -  Fix racy registrations
 -  Fix ROG button mapping, tablet mode on ASUS ROG Z13
 -  map more keys on ExpertBook B9
 -  Remove extra keys from ignore_key_wlan quirk

hp-wmi:
 -  Add support for Fn+P hotkey

intel/pmc:
 -  Add Bartlett Lake support to intel_pmc_core

intel: power-domains:
 -  Use topology_logical_package_id() for package ID

----------------------------------------------------------------
Antheas Kapenekakis (2):
      platform/x86: asus-wmi: Remove extra keys from ignore_key_wlan quirk
      platform/x86: asus-wmi: Fix ROG button mapping, tablet mode on ASUS ROG Z13

Anton Khirnov (1):
      platform/x86: asus-wmi: map more keys on ExpertBook B9

Armin Wolf (1):
      platform/x86: acer-wmi: Stop using ACPI bitmap for platform profile choices

Christoffer Sandberg (1):
      platform/x86/amd/pmc: Add TUXEDO IB Pro Gen10 AMD to spurious 8042 quirks list

David Arcari (1):
      platform/x86/intel: power-domains: Use topology_logical_package_id() for package ID

Edip Hazuri (1):
      platform/x86: hp-wmi: Add support for Fn+P hotkey

Li Yifan (1):
      platform/x86/intel/pmc: Add Bartlett Lake support to intel_pmc_core

Takashi Iwai (1):
      platform/x86: asus-wmi: Fix racy registrations

Zhen Ni (1):
      platform/x86/amd: hfi: Fix pcct_tbl leak in amd_hfi_metadata_parser()

 drivers/platform/x86/acer-wmi.c                 | 71 +++++--------------------
 drivers/platform/x86/amd/hfi/hfi.c              | 14 +++--
 drivers/platform/x86/amd/pmc/pmc-quirks.c       | 14 +++++
 drivers/platform/x86/asus-nb-wmi.c              | 28 +++++++---
 drivers/platform/x86/asus-wmi.c                 |  9 +++-
 drivers/platform/x86/asus-wmi.h                 |  3 +-
 drivers/platform/x86/hp/hp-wmi.c                |  4 ++
 drivers/platform/x86/intel/pmc/core.c           |  1 +
 drivers/platform/x86/intel/tpmi_power_domains.c |  2 +-
 9 files changed, 74 insertions(+), 72 deletions(-)

