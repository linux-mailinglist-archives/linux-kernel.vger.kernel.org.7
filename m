Return-Path: <linux-kernel+bounces-763398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3ACB21421
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 20:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B583F7B3E39
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 18:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A805F2E62CB;
	Mon, 11 Aug 2025 18:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AJr+UKKA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A722E54BD
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 18:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754936271; cv=none; b=dhcIYPg32bH0WgEsuXlwHKF1wmrS/py0TX0DJfp6Kxs35JEXU7Nnelruo/2XLo4tNlBG6WJ+BKdAOG3g9YXpY1JfOV8pbZNpHdiPlhoWvFEOiy7gdotfD3VgYWkxe4PFPfF5go+3Eg9tw+Df2KhxiyoicTQwoVKK8N1p+vZes2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754936271; c=relaxed/simple;
	bh=sw+euk2AZUSojRcvrV7jLAishCzKBceO1HRJvLkyXvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F3ETa4z+3I3X9nvHdrG6eVsoVOq1p09NF1iVGgjnWhck8W0FNU5p7gTDSd0zrs956HHT1O65dhp9/EHm27NztqhPVj6DK3isVOdrECFANqMQEyCci0IydAGHIoKineU1j0D6RKlyo+DbnPtcl92cY1i2TxVw857oIfxUin3Sgig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AJr+UKKA; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754936269; x=1786472269;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sw+euk2AZUSojRcvrV7jLAishCzKBceO1HRJvLkyXvw=;
  b=AJr+UKKAj+5AVr4HnroKhdIrR72dmCZc+qltdgJy8YZVWsmAtIcRPFZ/
   HKbXpMfvG3hCrNsawkjUpyN8LTAaEFqgg/nxMAMsIJCDRxX9U866G9fAV
   sLvsIgQHqdI5kC70QRo1Ez0CGi7vcgwyj4WSZxEzOgV2Xm7D2vx0QV8lA
   EvHIEAFelX8Do4LBg8uJN+1OiPemvyqF7BXEWHXJutk1OQYd1Z57CC9EB
   pnqL5oHGb92X+9dHI4iUWBBDEfC1NlUrsl29yiGNJsttYX6JE8OKezS+H
   3euSxRkwmplOKe2hctH2nv0iZEDFGw25IMLroWpmLhrnMHSLqr/yiY4K6
   Q==;
X-CSE-ConnectionGUID: FXP517CJTjyVc3/nyFI2Rg==
X-CSE-MsgGUID: mFOg0AoaSR2BIygjcIyIJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="68277523"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="68277523"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 11:17:27 -0700
X-CSE-ConnectionGUID: u+tWpg20QKCVbNa/HSGLXw==
X-CSE-MsgGUID: nEo+oUipT6ieuRz44QGeQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="196825705"
Received: from puneetse-mobl.amr.corp.intel.com (HELO agluck-desk3.home.arpa) ([10.124.221.229])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 11:17:26 -0700
From: Tony Luck <tony.luck@intel.com>
To: Fenghua Yu <fenghuay@nvidia.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Peter Newman <peternewman@google.com>,
	James Morse <james.morse@arm.com>,
	Babu Moger <babu.moger@amd.com>,
	Drew Fustini <dfustini@baylibre.com>,
	Dave Martin <Dave.Martin@arm.com>,
	Anil Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	Chen Yu <yu.c.chen@intel.com>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v8 27/32] fs,x86/resctrl: Compute number of RMIDs as minimum across resources
Date: Mon, 11 Aug 2025 11:17:01 -0700
Message-ID: <20250811181709.6241-28-tony.luck@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250811181709.6241-1-tony.luck@intel.com>
References: <20250811181709.6241-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

resctrl assumes that only the L3 resource supports monitor events, so
it simply takes the rdt_resource::num_rmid from RDT_RESOURCE_L3 as
the number of RMIDs.

The addition of telemetry events in a different resource breaks that
assumption.

Compute the number of available RMIDs as the minimum value across
all mon capable resources (analogous to how the number of CLOSIDs
is computed across alloc capable resources).

Note that mount time enumeration of the telemetry resource means that
this number can be reduced. If this happens, then some memory will
be wasted as the allocations for rdt_l3_mon_domain::states[] will be
larger than needed.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/resctrl/core.c | 15 +++++++++++++--
 fs/resctrl/rdtgroup.c              |  5 +++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 2b011f9efc73..0284da075ea6 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -110,12 +110,23 @@ struct rdt_hw_resource rdt_resources_all[RDT_NUM_RESOURCES] = {
 	},
 };
 
+/**
+ * resctrl_arch_system_num_rmid_idx - Compute number of supported RMIDs
+ *				      (minimum across all mon capable resource)
+ *
+ * Return: Number of supported RMIDs at time of call. Note that mount time
+ * enumeration of resources may reduce the number.
+ */
 u32 resctrl_arch_system_num_rmid_idx(void)
 {
-	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+	u32 num_rmids = U32_MAX;
+	struct rdt_resource *r;
+
+	for_each_mon_capable_rdt_resource(r)
+		num_rmids = min(num_rmids, r->num_rmid);
 
 	/* RMID are independent numbers for x86. num_rmid_idx == num_rmid */
-	return r->num_rmid;
+	return num_rmids == U32_MAX ? 0 : num_rmids;
 }
 
 struct rdt_resource *resctrl_arch_get_resource(enum resctrl_res_level l)
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 55ad99bd77d2..5352480eb55c 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -4116,6 +4116,11 @@ void resctrl_offline_mon_domain(struct rdt_resource *r, struct rdt_domain_hdr *h
  * During boot this may be called before global allocations have been made by
  * resctrl_mon_l3_resource_init().
  *
+ * This routine is called at resctrl init time. The number of supported RMIDs
+ * may be reduced if additional mon capable resources are enumerated at mount
+ * time. This means the rdt_l3_mon_domain::states[] allocations may be larger
+ * than needed.
+ *
  * Returns 0 for success, or -ENOMEM.
  */
 static int domain_setup_l3_mon_state(struct rdt_resource *r, struct rdt_l3_mon_domain *d)
-- 
2.50.1


