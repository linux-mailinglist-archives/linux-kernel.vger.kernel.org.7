Return-Path: <linux-kernel+bounces-814814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42857B558F6
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 00:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9648C1D631D3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 22:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A9B3570C2;
	Fri, 12 Sep 2025 22:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NJVfqZhv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1ED283146
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 22:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757715078; cv=none; b=lJ5KUZCm3bV5Ozm6SrKgJBDs+jNI4H2cstaUvKe6yVbhaTZTOP7gmYHWFlk3punaIE+jT4v2A4iQqTfEwY0lpY/ubVz0YfIVtB2mdeO39UrECXW8utyskSM8/0iJHgnVEmBQoM6A1ejVkghKTY18JZgCqvJg2NTnF7KnVciCIAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757715078; c=relaxed/simple;
	bh=t9iHAyxu8Fi6yLKyyET7uVNtK2AboFitByCgxUevL7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e09Vw239mvIH7k+ygh4wx76p/JxR5qbugKgj4vScTqLMFnUyfTj3f7T5iEg0uZdECmAuBAfKQqhFSCPW/ZdFT1uvi1AN9LSAtA6geHxaVi1JKd5H3X0InB8vQ0FEGVMyBIXvu6gsiYgF+Hd4y6tSZZVs4yy4+g+Q7dp43vPXE08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NJVfqZhv; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757715075; x=1789251075;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t9iHAyxu8Fi6yLKyyET7uVNtK2AboFitByCgxUevL7Y=;
  b=NJVfqZhvZjLJSwRbCjmrBhTsth+3Yc9ISql3v7RchkR4IJc+mguL/PvK
   EwE4nbZqZBlHDCJ12nMbmQrYDi1L1mMlScyPCnLKfwrFLUWs7OYQue7EX
   WQLAC36FN5cGGNrJyowaxjaHpMIB3k4cdTJ7vQVRk37+iHdeD+RCmGBDz
   LRrd/7ghEcOZL0PRTrBubxLFOtvC6pxCY0gDOFgmjWahauGNGfajLO0fc
   G3nYpfkvpbJ3gPBGKphZZsPKGk/JALuZnV+O2MWGIRiumjDguyFFYhu5M
   lstZXHXJQT/ps9fBPf8W4ovsAqvBbquzmXKEOYNRNA4qtyhDbfGsRHb/D
   w==;
X-CSE-ConnectionGUID: 7sd7j6DjRDmNMeYujsTJJg==
X-CSE-MsgGUID: Qrr2BeehSZSF8VGt/dZtzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11551"; a="60002771"
X-IronPort-AV: E=Sophos;i="6.18,260,1751266800"; 
   d="scan'208";a="60002771"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 15:11:09 -0700
X-CSE-ConnectionGUID: tkph9J+zTHyxCr3rZrIEpQ==
X-CSE-MsgGUID: j6Y/SmM+RYSBiNUACdEyng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,260,1751266800"; 
   d="scan'208";a="179265195"
Received: from smoehrl-linux.amr.corp.intel.com (HELO agluck-desk3.intel.com) ([10.124.221.49])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 15:11:08 -0700
From: Tony Luck <tony.luck@intel.com>
To: Fenghua Yu <fenghuay@nvidia.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Peter Newman <peternewman@google.com>,
	James Morse <james.morse@arm.com>,
	Babu Moger <babu.moger@amd.com>,
	Drew Fustini <dfustini@baylibre.com>,
	Dave Martin <Dave.Martin@arm.com>,
	Chen Yu <yu.c.chen@intel.com>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v10 17/28] x86/resctrl: Find and enable usable telemetry events
Date: Fri, 12 Sep 2025 15:10:38 -0700
Message-ID: <20250912221053.11349-18-tony.luck@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250912221053.11349-1-tony.luck@intel.com>
References: <20250912221053.11349-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The INTEL_PMT_TELEMETRY driver provides telemetry region structures of the
types requested by resctrl.

Scan these structures to discover which pass sanity checks to derive
a list of valid regions:

1) They have guid known to resctrl.
2) They have a valid package ID.
3) The enumerated size of the MMIO region matches the expected
   value from the XML description file.
4) At least one region passes the above checks.

For each valid region enable all the events in the associated
event_group::evts[].

Pass a pointer to the pmt_event structure of the event within the struct
event_group that resctrl stores in mon_evt::arch_priv. resctrl passes
this pointer back when asking to read the event data which enables the
data to be found in MMIO.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/resctrl/intel_aet.c | 38 +++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/intel_aet.c b/arch/x86/kernel/cpu/resctrl/intel_aet.c
index f9b5f6cd08f8..98ba9ba05ee5 100644
--- a/arch/x86/kernel/cpu/resctrl/intel_aet.c
+++ b/arch/x86/kernel/cpu/resctrl/intel_aet.c
@@ -20,9 +20,11 @@
 #include <linux/intel_pmt_features.h>
 #include <linux/intel_vsec.h>
 #include <linux/overflow.h>
+#include <linux/printk.h>
 #include <linux/resctrl.h>
 #include <linux/resctrl_types.h>
 #include <linux/stddef.h>
+#include <linux/topology.h>
 #include <linux/types.h>
 
 #include "internal.h"
@@ -114,12 +116,44 @@ static struct event_group *known_perf_event_groups[] = {
 	for (_peg = (_grp); _peg < &_grp[ARRAY_SIZE(_grp)]; _peg++)	\
 		if ((*_peg)->pfg)
 
-/* Stub for now */
-static bool enable_events(struct event_group *e, struct pmt_feature_group *p)
+static bool skip_telem_region(struct telemetry_region *tr, struct event_group *e)
 {
+	if (tr->guid != e->guid)
+		return true;
+	if (tr->plat_info.package_id >= topology_max_packages()) {
+		pr_warn("Bad package %u in guid 0x%x\n", tr->plat_info.package_id,
+			tr->guid);
+		return true;
+	}
+	if (tr->size != e->mmio_size) {
+		pr_warn("MMIO space wrong size (%zu bytes) for guid 0x%x. Expected %zu bytes.\n",
+			tr->size, e->guid, e->mmio_size);
+		return true;
+	}
+
 	return false;
 }
 
+static bool enable_events(struct event_group *e, struct pmt_feature_group *p)
+{
+	bool usable_events = false;
+
+	for (int i = 0; i < p->count; i++) {
+		if (skip_telem_region(&p->regions[i], e))
+			continue;
+		usable_events = true;
+	}
+
+	if (!usable_events)
+		return false;
+
+	for (int j = 0; j < e->num_events; j++)
+		resctrl_enable_mon_event(e->evts[j].id, true,
+					 e->evts[j].bin_bits, &e->evts[j]);
+
+	return true;
+}
+
 DEFINE_FREE(intel_pmt_put_feature_group, struct pmt_feature_group *,
 		if (!IS_ERR_OR_NULL(_T))
 			intel_pmt_put_feature_group(_T))
-- 
2.51.0


