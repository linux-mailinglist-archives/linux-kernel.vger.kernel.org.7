Return-Path: <linux-kernel+bounces-730532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48384B045E5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 18:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50177165A92
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 16:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDF928EA;
	Mon, 14 Jul 2025 16:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MjyzgVVA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395DE262FD4;
	Mon, 14 Jul 2025 16:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752511611; cv=none; b=bjEQUs3kGFw927M1RLsQ3tNnSNyGkYKU85BF0V3lW862cCmQz9RRIMf46gaNHwTZXNAjnCrRVVIeYaHQoWhSjLbj2MAgR+TE4Pe9dUwR5S2yXE5rVWlhehPE6Wa4kLc5BLrDih+plf1bnARcoYh6+R6gXgdEZWGL9mya7Ai30KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752511611; c=relaxed/simple;
	bh=CZ4g0Gar9M48yZ3aK1dx0+90CzTsdoCR/PgLbozfuBU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Xnkd4A0ckAIM4BUC3i1poNjGrYq1b6elbRnFF3vaqf6W+e/X/aG0OnVXTPV+TKwmjp0rKVyMYw0WoAyr3Mu+5Awjqfi6TEX9zLzbFAnByY4uBEnv1ppTvZoU/AsAM3gS3nfxp1JSBxJuywmzprP3fS8775tyIbc+BUsjsNE0qaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MjyzgVVA; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752511610; x=1784047610;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CZ4g0Gar9M48yZ3aK1dx0+90CzTsdoCR/PgLbozfuBU=;
  b=MjyzgVVAdtr7x/F38wpNqAu+8F4zXQeS5RZYGd1BB66j2YmMi1RppI2A
   2foql3p07fkCnoH4Fsbgkz68XHXbjJ99xDwtoT+cUE/W83GgvUp1e0KPW
   /xg9YQjQHHPYQ+Un1oXirDWybWppo6h1hFEYBsn3QYkRCNZvCFGRwlb2q
   vaifsyOdQH0IRx/F2/j2BKvSQVpBg0QwQwNyU+NgddrY3e0gbaEL/A+6u
   wSTbP70oilZe0nJeHBrgCR7mUVr6xUCQV/rngE4XyejcINUcTbJPZ8EZC
   87Nm+ie/PuMpJzn/xOo6f94+6nqb/arvLsPnhFcHc07nM/r8olMyAqX8Z
   Q==;
X-CSE-ConnectionGUID: ihoPRr1BQtCLoriR6DVfJQ==
X-CSE-MsgGUID: rdohjBxkQeiGSQALwVlhmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="77246297"
X-IronPort-AV: E=Sophos;i="6.16,311,1744095600"; 
   d="scan'208";a="77246297"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 09:46:49 -0700
X-CSE-ConnectionGUID: QA0SCNZUTDqsyaMzUzfR7A==
X-CSE-MsgGUID: WpfMqmwiQHGZaqab8lNOQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,311,1744095600"; 
   d="scan'208";a="161529272"
Received: from jithudellxeon.sc.intel.com ([172.25.103.66])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 09:46:49 -0700
From: Jithu Joseph <jithu.joseph@intel.com>
To: ilpo.jarvinen@linux.intel.com,
	hdegoede@redhat.com
Cc: linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	jithu.joseph@intel.com,
	tony.luck@intel.com,
	ashok.raj.linux@gmail.com
Subject: [PATCH] MAINTAINERS: Update entries for IFS and SBL drivers
Date: Mon, 14 Jul 2025 09:46:43 -0700
Message-Id: <20250714164643.3879784-1-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the MAINTAINERS file to reflect the following changes for two Intel
platform drivers:

- Tony has agreed to take over maintainership of the Intel In-Field Scan
  (IFS) driver, and is now listed as the new maintainer.
- Remove myself as the maintainer for the Slim BootLoader (SBL) firmware
  update driver and mark it as Orphan. To the best of my knowledge, there
  is no one familiar with SBL who can take over this role.

These changes are being made as I will soon be leaving Intel.

Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
---
 MAINTAINERS | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fad6cb025a19..9b90f434101b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12185,9 +12185,8 @@ F:	drivers/dma/idxd/*
 F:	include/uapi/linux/idxd.h
 
 INTEL IN FIELD SCAN (IFS) DEVICE
-M:	Jithu Joseph <jithu.joseph@intel.com>
+M:	Tony Luck <tony.luck@intel.com>
 R:	Ashok Raj <ashok.raj.linux@gmail.com>
-R:	Tony Luck <tony.luck@intel.com>
 S:	Maintained
 F:	drivers/platform/x86/intel/ifs
 F:	include/trace/events/intel_ifs.h
@@ -12527,8 +12526,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi.git
 F:	drivers/net/wireless/intel/iwlwifi/
 
 INTEL WMI SLIM BOOTLOADER (SBL) FIRMWARE UPDATE DRIVER
-M:	Jithu Joseph <jithu.joseph@intel.com>
-S:	Maintained
+S:	Orphan
 W:	https://slimbootloader.github.io/security/firmware-update.html
 F:	drivers/platform/x86/intel/wmi/sbl-fw-update.c
 

base-commit: d7b8f8e20813f0179d8ef519541a3527e7661d3a
-- 
2.34.1


