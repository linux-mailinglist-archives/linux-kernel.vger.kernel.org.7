Return-Path: <linux-kernel+bounces-763388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF261B21414
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 20:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C15EF3E2EA9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 18:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0593C2E5400;
	Mon, 11 Aug 2025 18:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KQML5QfW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627952E2838
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 18:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754936265; cv=none; b=kedzdCzCYug7I/mNJq4McVsGsv2X7FFwAJJVLoAScxVh2R1VAKVLmrI9Tgdl14I7gIJwXiIr+5+p4SxlT26ST6fUyjlnV7QVMoOW3WzKamzIuokHGp9vdVzoZOgEd+dY+kFCp4tphcsUrjNKVbE7MmgUIRCsl1zHtGyMIxnykP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754936265; c=relaxed/simple;
	bh=ISWJubg+Z8gzEXFfg1gd+vXjO/Geh6wfJL0ida/t5SQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q4M7gpuDdCMIvCuAiEv0CRjIx/q2Frjk6fMNcVMBl9uiKMf/q4aKJwQj6hEx9wu+3CqXeGy5JWZqXu0P2Eg2XK8jCsMl++Iq5PxfrGyDvt/G1FsKDGt000WTV2SbV4RZRgFStYYoLCzRP7eJPRafi4Esum9UTv7yhc7kZeXQXdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KQML5QfW; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754936264; x=1786472264;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ISWJubg+Z8gzEXFfg1gd+vXjO/Geh6wfJL0ida/t5SQ=;
  b=KQML5QfW7Qj+fMHyLrgWaZqj+pub+XzcxHer1nNlmZmIa28QpUHc6qrM
   bDHWNVbxL3o/QN4IgCRt5sQNpP4kzixHuZ7EZm1WFMD735wdY2YnoAbgX
   EonY2EyaDyR1cBG3K/BL/bLwQRCJ9VfqO1OqIpEVcfkI3Mwo9dEMHF333
   OQCuIAxhyO4t3EpjNFPZ/nAOs7qjT6sKcKqVKernZS8BV2gMGaxolneZc
   iyNNsoPcGHrCzVZ7yeBvmvLIfhZXI09goHWEDlMbX9/w4vKOhomUKFW/Q
   GNNCdLlXyfGQ4o0bKkL2sXbcPcK8Z+ZDz4Hy1UryXgW5RDXkkM6fWk4bk
   A==;
X-CSE-ConnectionGUID: mgJ9BH0ZRNuvDJRQc0DJeg==
X-CSE-MsgGUID: p8Tef+/CSCKdSuy/YHDH1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="68277456"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="68277456"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 11:17:27 -0700
X-CSE-ConnectionGUID: aHeaqpjtRgK24ypppLxpQQ==
X-CSE-MsgGUID: 6nG6ElQWSgOwsbpXVNCFDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="196825675"
Received: from puneetse-mobl.amr.corp.intel.com (HELO agluck-desk3.home.arpa) ([10.124.221.229])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 11:17:25 -0700
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
Subject: [PATCH v8 19/32] x86/resctrl: Complete telemetry event enumeration
Date: Mon, 11 Aug 2025 11:16:53 -0700
Message-ID: <20250811181709.6241-20-tony.luck@intel.com>
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

Counters for telemetry events are in MMIO space. Each telemetry_region
structure returned in the pmt_feature_group returned from OOBMSM contains
the base MMIO address for the counters.

There may be multiple aggregators per package. Scan all the
telemetry_region structures again and save the number of regions together
with a flex array of the MMIO addresses for each region indexed by
package id.

Completed structure for each event group looks like this:

             +---------------------+---------------------+
pkginfo** -->|pkginfo[package ID 0]|pkginfo[package ID 1]|
             +---------------------+---------------------+
                        |                     |
                        v                     v
                +--------------------+    +--------------------+
                |struct pkg_mmio_info|    |struct pkg_mmio_info|
                +--------------------+    +--------------------+
                |num_regions = M     |    |num_regions = N     |
                |  addrs[0]          |    |  addrs[0]          |
                |  addrs[1]          |    |  addrs[1]          |
                |    ...             |    |    ...             |
                |  addrs[M-1]        |    |  addrs[N-1]        |
                +--------------------+    +--------------------+

Build a list (active_event_groups) of all the event groups that
were successfully enabled. Use it to clean up in intel_aet_exit().

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/resctrl/intel_aet.c | 76 ++++++++++++++++++++++++-
 1 file changed, 75 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/intel_aet.c b/arch/x86/kernel/cpu/resctrl/intel_aet.c
index 09043d36e08c..151e4b56ab36 100644
--- a/arch/x86/kernel/cpu/resctrl/intel_aet.c
+++ b/arch/x86/kernel/cpu/resctrl/intel_aet.c
@@ -19,23 +19,43 @@
 
 #include "internal.h"
 
+/**
+ * struct pkg_mmio_info - MMIO address information for one event group of a package.
+ * @num_regions:	Number of telemetry regions on this package.
+ * @addrs:		Array of MMIO addresses, one per telemetry region on this package.
+ *
+ * Provides convenient access to all MMIO addresses of one event group
+ * for one package. Used when reading event data on a package.
+ */
+struct pkg_mmio_info {
+	unsigned int	num_regions;
+	void __iomem	*addrs[] __counted_by(num_regions);
+};
+
 /**
  * struct event_group - All information about a group of telemetry events.
  * @pfg:		Points to the aggregated telemetry space information
  *			within the OOBMSM driver that contains data for all
  *			telemetry regions.
+ * @list:		Member of active_event_groups.
+ * @pkginfo:		Per-package MMIO addresses of telemetry regions belonging to this group.
  * @guid:		Unique number per XML description file.
  * @mmio_size:		Number of bytes of MMIO registers for this group.
  */
 struct event_group {
 	/* Data fields for additional structures to manage this group. */
 	struct pmt_feature_group	*pfg;
+	struct list_head		list;
+	struct pkg_mmio_info		**pkginfo;
 
 	/* Remaining fields initialized from XML file. */
 	u32				guid;
 	size_t				mmio_size;
 };
 
+/* All successfully enabled event groups */
+static LIST_HEAD(active_event_groups);
+
 #define XML_MMIO_SIZE(num_rmids, num_events, num_extra_status) \
 		      (((num_rmids) * (num_events) + (num_extra_status)) * sizeof(u64))
 
@@ -82,15 +102,32 @@ static bool skip_this_region(struct telemetry_region *tr, struct event_group *e)
 	return false;
 }
 
+static void free_pkg_mmio_info(struct pkg_mmio_info **mmi)
+{
+	int num_pkgs = topology_max_packages();
+
+	if (!mmi)
+		return;
+
+	for (int i = 0; i < num_pkgs; i++)
+		kfree(mmi[i]);
+	kfree(mmi);
+}
+
+DEFINE_FREE(pkg_mmio_info, struct pkg_mmio_info **, free_pkg_mmio_info(_T))
+
 /*
  * Discover events from one pmt_feature_group.
  * 1) Count how many usable telemetry regions per package.
- * 2...) To be continued.
+ * 2) Allocate per-package structures and populate with MMIO
+ *    addresses of the telemetry regions.
  */
 static int discover_events(struct event_group *e, struct pmt_feature_group *p)
 {
+	struct pkg_mmio_info **pkginfo __free(pkg_mmio_info) = NULL;
 	int *pkgcounts __free(kfree) = NULL;
 	struct telemetry_region *tr;
+	struct pkg_mmio_info *mmi;
 	int num_pkgs;
 
 	num_pkgs = topology_max_packages();
@@ -112,6 +149,34 @@ static int discover_events(struct event_group *e, struct pmt_feature_group *p)
 	if (!pkgcounts)
 		return -ENODEV;
 
+	/* Allocate array for per-package struct pkg_mmio_info data */
+	pkginfo = kcalloc(num_pkgs, sizeof(*pkginfo), GFP_KERNEL);
+	if (!pkginfo)
+		return -ENOMEM;
+
+	/*
+	 * Allocate per-package pkg_mmio_info structures and initialize
+	 * count of telemetry_regions in each one.
+	 */
+	for (int i = 0; i < num_pkgs; i++) {
+		pkginfo[i] = kzalloc(struct_size(pkginfo[i], addrs, pkgcounts[i]), GFP_KERNEL);
+		if (!pkginfo[i])
+			return -ENOMEM;
+		pkginfo[i]->num_regions = pkgcounts[i];
+	}
+
+	/* Save MMIO address(es) for each telemetry region in per-package structures */
+	for (int i = 0; i < p->count; i++) {
+		tr = &p->regions[i];
+		if (skip_this_region(tr, e))
+			continue;
+		mmi = pkginfo[tr->plat_info.package_id];
+		mmi->addrs[--pkgcounts[tr->plat_info.package_id]] = tr->addr;
+	}
+	e->pkginfo = no_free_ptr(pkginfo);
+
+	list_add(&e->list, &active_event_groups);
+
 	return 0;
 }
 
@@ -169,4 +234,13 @@ bool intel_aet_get_events(void)
 
 void __exit intel_aet_exit(void)
 {
+	struct event_group *evg, *tmp;
+
+	list_for_each_entry_safe(evg, tmp, &active_event_groups, list) {
+		intel_pmt_put_feature_group(evg->pfg);
+		evg->pfg = NULL;
+		free_pkg_mmio_info(evg->pkginfo);
+		evg->pkginfo = NULL;
+		list_del(&evg->list);
+	}
 }
-- 
2.50.1


