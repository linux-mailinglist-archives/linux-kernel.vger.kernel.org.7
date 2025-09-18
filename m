Return-Path: <linux-kernel+bounces-822050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A121BB82EE9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 07:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 617B018859AF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 05:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7653C284B20;
	Thu, 18 Sep 2025 05:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V/7VmVC/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5276B27F19F
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 05:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758171849; cv=none; b=hGmCBKKrN1dVbfY7+etxLDIZBLx0F4Wk0a+5Prsjk2LNpzYx68Pap8rDhNzkOL8v3aaddgx5hfvgbZ7pHcQt1Iq/UXoms71cyE+Lzabwi2gAvLkY0vLpNc6LwjUAtL96AmOmXrcKrTEmfZAirgn5kXFFN/kTstpNIqE/AQYWIEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758171849; c=relaxed/simple;
	bh=lHghKH4ULMXAHmF5d8L32yT2BD6X8Hm29QJ7mE4fltI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D/Q+g/sCr07T/6JPj65bXQUIZ5AGMYxhZi7+uP8bam0Ws5hDvddYPrjyVQNaTPzhmd8lAFw14dN9d4S/Ay3njpO7OpYEY+BpLB0CtHWxpLa6jHI6oGQLwung4bu+hq599RBT6NQrwxBS276VY05VEXVMl+Qn2gOVF+xgPYV8si8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V/7VmVC/; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758171848; x=1789707848;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lHghKH4ULMXAHmF5d8L32yT2BD6X8Hm29QJ7mE4fltI=;
  b=V/7VmVC/coR0bjnJlNRtRKTjEFa1IJydSJEdjBDejyTLAFYgrhkUIzFT
   LodYC0KR9U2vSaARg1IbmHs4l5ufg08dyQWDZUq5C8raS2sZWGHWWyC0B
   +lNZwsi38il+2m/iDP+hTqVB1GVpCwfYumZeLPbdEOh2+AIBWZgsEQiXv
   j40MJYvV+lVNPwdo28WhG9YjvHI5G1sNaes1gBT+VzD+/BjuRZ0inVJ/s
   yYHGQQtC2b/Br+bF8X0+Td9R3I+kHBxEChaGAhaGvdi8Wt7Rb4mkeyD6P
   zdBVyC59+ClmPTV9XTBymuQvi9JGw9xa5Ya0Luo25j7Q4DlqZdk5jBF9R
   g==;
X-CSE-ConnectionGUID: OEnr0tNlTYOogic4foSSGQ==
X-CSE-MsgGUID: BjB5foswSmmpi/hSmpsqnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11556"; a="60182266"
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; 
   d="scan'208";a="60182266"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 22:04:08 -0700
X-CSE-ConnectionGUID: +Hia2RwMTrCOgB2D5Evtmw==
X-CSE-MsgGUID: a1SS4fVlQF2+HD8nN1ybbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; 
   d="scan'208";a="175353409"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa006.fm.intel.com with ESMTP; 17 Sep 2025 22:04:07 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] iommu/vt-d: PRS isn't usable if PDS isn't supported
Date: Thu, 18 Sep 2025 13:02:02 +0800
Message-ID: <20250918050204.359508-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250918050204.359508-1-baolu.lu@linux.intel.com>
References: <20250918050204.359508-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The specification, Section 7.10, "Software Steps to Drain Page Requests &
Responses," requires software to submit an Invalidation Wait Descriptor
(inv_wait_dsc) with the Page-request Drain (PD=1) flag set, along with
the Invalidation Wait Completion Status Write flag (SW=1). It then waits
for the Invalidation Wait Descriptor's completion.

However, the PD field in the Invalidation Wait Descriptor is optional, as
stated in Section 6.5.2.9, "Invalidation Wait Descriptor":

"Page-request Drain (PD): Remapping hardware implementations reporting
 Page-request draining as not supported (PDS = 0 in ECAP_REG) treat this
 field as reserved."

This implies that if the IOMMU doesn't support the PDS capability, software
can't drain page requests and group responses as expected.

Do not enable PCI/PRI if the IOMMU doesn't support PDS.

Reported-by: Joel Granados <joel.granados@kernel.org>
Closes: https://lore.kernel.org/r/20250909-jag-pds-v1-1-ad8cba0e494e@kernel.org
Fixes: 66ac4db36f4c ("iommu/vt-d: Add page request draining support")
Cc: stable@vger.kernel.org
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Link: https://lore.kernel.org/r/20250915062946.120196-1-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 9c3ab9d9f69a..92759a8f8330 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3812,7 +3812,7 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 			}
 
 			if (info->ats_supported && ecap_prs(iommu->ecap) &&
-			    pci_pri_supported(pdev))
+			    ecap_pds(iommu->ecap) && pci_pri_supported(pdev))
 				info->pri_supported = 1;
 		}
 	}
-- 
2.43.0


