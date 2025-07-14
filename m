Return-Path: <linux-kernel+bounces-729346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C88DAB03552
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 06:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC4F8177047
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 04:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B821F8AD3;
	Mon, 14 Jul 2025 04:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kvhLvcjo"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99DF1F3B8A
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 04:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752468770; cv=none; b=o3BDl8zmPjiZY5dApkt6Ouspf7ylZYr6q2A9F237rbBldLOTFrP9Bz/r3DsSE3rmUEXMq/N9RFUogOBlvoCdpUGp6ZS1ZhXMIROqNIvYRnJBOoip3yA4ou9FM/AHOPjNvbH1xuzZ3uhPq7yyk4AkCRNnfuA5AkDFyTUVyBQ5UKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752468770; c=relaxed/simple;
	bh=syDR/ggoQRcY2z+FN85gCRMGWAqN9JGTyQdffmweMoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rMUGsrNZMucsLd1lnwyaIGFpoJKfOQHKaEvZQ5aiU1XZrs28VFaPTBHjhfb7TW7p2vWARWOFbFD8DEnydKRv+pbE2fexplXcjqduCrPm15scgPX9tbDL1l80q+MJPZu7ymrWl4T6npPPMVb1spd95wOG1AgooKvdqQ2d84YtB3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kvhLvcjo; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752468768; x=1784004768;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=syDR/ggoQRcY2z+FN85gCRMGWAqN9JGTyQdffmweMoo=;
  b=kvhLvcjo7qFxbq8cC35FRVmG4OdkPyzHCt6jk6HUYspJ45do2Fouj/e6
   NWMjSKnsZrWTz1crU1+xvB+g+2zKiHNUBnXpyDf6/+YtfsKT7F1zpNYLR
   xEgnyw+Jz3blofs9Ab4rl3Wt9ajGIb6Q70d8XaTA6pmqp0X96Gn5rA4gy
   Jxo8HJ++mTz9KIRdjG3tNEjEQf1UCCy9IxdYWwYjTAiDrw883PNUm/q5c
   7EfZx2beamSrNF/UxXvzIntVsyRU2ojdw8QfMv1uXQnvccHQmArcifhlH
   Fp/92MYyPXBD6mSwi76E+1cORcuzqfNndROyFBaZPUOj3tsv+YJXt9jlf
   Q==;
X-CSE-ConnectionGUID: dRrnUApxT1Sm/9cLHOPuUg==
X-CSE-MsgGUID: yAENH/XlTKK4cHKSRprKkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="53765035"
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; 
   d="scan'208";a="53765035"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2025 21:52:47 -0700
X-CSE-ConnectionGUID: EHG8kM0tSCq1tMSgDxKGPA==
X-CSE-MsgGUID: J/LEche7Sp2vi2tu6+bBcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; 
   d="scan'208";a="161166145"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa003.jf.intel.com with ESMTP; 13 Jul 2025 21:52:47 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/11] iommu/vt-d: Remove the CONFIG_X86 wrapping from iommu init hook
Date: Mon, 14 Jul 2025 12:50:18 +0800
Message-ID: <20250714045028.958850-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714045028.958850-1-baolu.lu@linux.intel.com>
References: <20250714045028.958850-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>

iommu init hook is wrapped in CONFI_X86 and is a remnant of dmar.c when
it was a common code in "drivers/pci/dmar.c". This was added in commit
(9d5ce73a64be2 x86: intel-iommu: Convert detect_intel_iommu to use
iommu_init hook)

Now this is built only for x86. This config wrap could be removed.

Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20250616131740.3499289-1-vineeth@bitbyteword.org
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/dmar.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index b61d9ea27aa9..ec975c73cfe6 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -935,14 +935,11 @@ void __init detect_intel_iommu(void)
 		pci_request_acs();
 	}
 
-#ifdef CONFIG_X86
 	if (!ret) {
 		x86_init.iommu.iommu_init = intel_iommu_init;
 		x86_platform.iommu_shutdown = intel_iommu_shutdown;
 	}
 
-#endif
-
 	if (dmar_tbl) {
 		acpi_put_table(dmar_tbl);
 		dmar_tbl = NULL;
-- 
2.43.0


