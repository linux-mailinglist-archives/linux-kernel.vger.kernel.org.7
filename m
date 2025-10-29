Return-Path: <linux-kernel+bounces-876715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF14C1C72C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78C05625041
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CB533F8BC;
	Wed, 29 Oct 2025 16:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QZ5RsTlc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0013559DC
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 16:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761754907; cv=none; b=k63Ef/g2iJ3VOMnRWkxXPrMz7m413lGIbE2tO7/Cc6ZolI+wN1gd/hhR4B1BXuBP/EOEx85kntFwBJ3DpG2IZRDaBGwVzyHCH7mCC667SRtb52vJs+W3QaqxbB7L15fNq380whpvmDPbxFoA41N95n1IJhjKRgdUsOmTNXha1Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761754907; c=relaxed/simple;
	bh=Nln/vExZdhoWmSheaRf9t+CIQSXQETe4l6BTTs0n3yg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ttgxv9GNgIPU8iRCReqXw23JiI3Cy+uyrNewXVzw7x+D3TvlyqHPKJrPzKK696vvnn//6dQlTEvNyVu+Z8hlYqYPLsJZ9IVaRrjJph/s2TsECpd9hbi4e06T/QcuTPeuQIg3UnQmOofKIi4v776sP6byTA0yf2MaNm/rDaoW+RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QZ5RsTlc; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761754905; x=1793290905;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Nln/vExZdhoWmSheaRf9t+CIQSXQETe4l6BTTs0n3yg=;
  b=QZ5RsTlcRF2D2pBno+DEQF12r1akd/xuixEWPKXm3m2+b/b1Kpk6UWvB
   sd8eYH2W/XmNFcj4tLAa2y2KanCQbPBO9gXVJdh3WVpuub5pf31N6uJF8
   rOLwEnm3IkluPb8AMZPQXgyfylaJuehmtc5Nf6nfb2aJdV0F6fXyhzyZd
   cxCUC+dWYi9hUM1AX9HUSEO3Br68A0Opiv86K6qb65Muo/ZLzirLE0toC
   KKaiInTXH0DMiNe8nOiMxTBnkJRKu/x4tGYYajr2p6tEeqIxG0sqpB7Ey
   07e3rq2sUytC84Kyn4HbHwaRlfVc6rzSU6tJUncG6MwpS4013eoVt2vXW
   A==;
X-CSE-ConnectionGUID: pr6vtM3GQtGEtpYPrQujwg==
X-CSE-MsgGUID: Vg2vQGDNT4u2x589SMvJQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="75331040"
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="75331040"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 09:21:34 -0700
X-CSE-ConnectionGUID: 7yH2ZCWlSg634HSjpn1i7A==
X-CSE-MsgGUID: ZVkpSqT9T7ad42Ldpujz+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="184901396"
Received: from mgerlach-mobl1.amr.corp.intel.com (HELO agluck-desk3.home.arpa) ([10.124.223.146])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 09:21:34 -0700
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
Subject: [PATCH v13 25/32] x86/resctrl: Handle number of RMIDs supported by RDT_RESOURCE_PERF_PKG
Date: Wed, 29 Oct 2025 09:21:08 -0700
Message-ID: <20251029162118.40604-26-tony.luck@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029162118.40604-1-tony.luck@intel.com>
References: <20251029162118.40604-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are now three meanings for "number of RMIDs":

1) The number for legacy features enumerated by CPUID leaf 0xF. This
is the maximum number of distinct values that can be loaded into
MSR_IA32_PQR_ASSOC. Note that systems with Sub-NUMA Cluster mode enabled
will force scaling down the CPUID enumerated value by the number of SNC
nodes per L3-cache.

2) The number of registers in MMIO space for each event. This
is enumerated in the XML files and is the value initialized into
event_group::num_rmids.

3) The number of "hardware counters" (this isn't a strictly accurate
description of how things work, but serves as a useful analogy that
does describe the limitations) feeding to those MMIO registers. This
is enumerated in telemetry_region::num_rmids returned from the call to
intel_pmt_get_regions_by_feature()

Event groups with insufficient "hardware counters" to track all RMIDs
are difficult for users to use, since the system may reassign "hardware
counters" at any time. This means that users cannot reliably collect
two consecutive event counts to compute the rate at which events are
occurring.

Introduce rdt_set_feature_disabled() to mark any under-resourced event groups
(those with telemetry_region::num_rmids < event_group::num_rmids  for any of
the event group's telemetry regions) as unusable.  Note that the rdt_options[]
structure must now be writable at run-time.

Limit an under-resourced event group's number of possible monitor
resource groups to the lowest number of "hardware counters" if the
user explicitly requests to enable it.

Scan all enabled event groups and assign the RDT_RESOURCE_PERF_PKG
resource "num_rmids" value to the smallest of these values as this value
will be used later to compare against the number of RMIDs supported
by other resources to determine how many monitoring resource groups
are supported.

N.B. Change type of rdt_resource::num_rmid to u32 to match type of
event_group::num_rmids so that min(r->num_rmid, e->num_rmids) won't
complain about mixing signed and unsigned types.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 include/linux/resctrl.h                 |  2 +-
 arch/x86/kernel/cpu/resctrl/internal.h  |  2 +
 arch/x86/kernel/cpu/resctrl/core.c      | 18 +++++++-
 arch/x86/kernel/cpu/resctrl/intel_aet.c | 55 +++++++++++++++++++++++++
 fs/resctrl/rdtgroup.c                   |  2 +-
 5 files changed, 76 insertions(+), 3 deletions(-)

diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 34ad0f5f1309..a2bf335052d6 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -292,7 +292,7 @@ enum resctrl_schema_fmt {
  *			events of monitor groups created via mkdir.
  */
 struct resctrl_mon {
-	int			num_rmid;
+	u32			num_rmid;
 	unsigned int		mbm_cfg_mask;
 	int			num_mbm_cntrs;
 	bool			mbm_cntr_assignable;
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index e3710b9f993e..cea76f88422c 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -227,6 +227,8 @@ void resctrl_arch_mbm_cntr_assign_set_one(struct rdt_resource *r);
 
 bool rdt_is_feature_enabled(char *name);
 
+void rdt_set_feature_disabled(char *name);
+
 #ifdef CONFIG_X86_CPU_RESCTRL_INTEL_AET
 bool intel_aet_get_events(void);
 void __exit intel_aet_exit(void);
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 7013911d3575..a8eb197e27db 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -788,7 +788,7 @@ struct rdt_options {
 	bool	force_off, force_on;
 };
 
-static struct rdt_options rdt_options[]  __ro_after_init = {
+static struct rdt_options rdt_options[] = {
 	RDT_OPT(RDT_FLAG_CMT,	    "cmt",	X86_FEATURE_CQM_OCCUP_LLC),
 	RDT_OPT(RDT_FLAG_MBM_TOTAL, "mbmtotal", X86_FEATURE_CQM_MBM_TOTAL),
 	RDT_OPT(RDT_FLAG_MBM_LOCAL, "mbmlocal", X86_FEATURE_CQM_MBM_LOCAL),
@@ -851,6 +851,22 @@ bool rdt_cpu_has(int flag)
 	return ret;
 }
 
+/*
+ * Can be called during feature enumeration if sanity check of
+ * a feature's parameters indicates problems with the feature.
+ */
+void rdt_set_feature_disabled(char *name)
+{
+	struct rdt_options *o;
+
+	for (o = rdt_options; o < &rdt_options[NUM_RDT_OPTIONS]; o++) {
+		if (!strcmp(name, o->name)) {
+			o->force_off = true;
+			return;
+		}
+	}
+}
+
 /*
  * Hardware features that do not have X86_FEATURE_* bits. There is no
  * "hardware does not support this at all" case. Assume that the caller
diff --git a/arch/x86/kernel/cpu/resctrl/intel_aet.c b/arch/x86/kernel/cpu/resctrl/intel_aet.c
index 781ca8ede39e..252a3fd4260c 100644
--- a/arch/x86/kernel/cpu/resctrl/intel_aet.c
+++ b/arch/x86/kernel/cpu/resctrl/intel_aet.c
@@ -25,6 +25,7 @@
 #include <linux/intel_pmt_features.h>
 #include <linux/intel_vsec.h>
 #include <linux/io.h>
+#include <linux/minmax.h>
 #include <linux/overflow.h>
 #include <linux/printk.h>
 #include <linux/rculist.h>
@@ -57,6 +58,7 @@ struct pmt_event {
  * struct event_group - All information about a group of telemetry events.
  * @feature:		Argument to intel_pmt_get_regions_by_feature() to
  *			discover if this event_group is supported.
+ * @name:		Name for this group (used by boot rdt= option)
  * @pfg:		Points to the aggregated telemetry space information
  *			returned by the intel_pmt_get_regions_by_feature()
  *			call to the INTEL_PMT_TELEMETRY driver that contains
@@ -64,6 +66,10 @@ struct pmt_event {
  *			Valid if the system supports the event group.
  *			NULL otherwise.
  * @guid:		Unique number per XML description file.
+ * @num_rmids:		Number of RMIDs supported by this group. May be
+ *			adjusted downwards if enumeration from
+ *			intel_pmt_get_regions_by_feature() indicates fewer
+ *			RMIDs can be tracked simultaneously.
  * @mmio_size:		Number of bytes of MMIO registers for this group.
  * @num_events:		Number of events in this group.
  * @evts:		Array of event descriptors.
@@ -71,10 +77,12 @@ struct pmt_event {
 struct event_group {
 	/* Data fields for additional structures to manage this group. */
 	enum pmt_feature_id		feature;
+	char				*name;
 	struct pmt_feature_group	*pfg;
 
 	/* Remaining fields initialized from XML file. */
 	u32				guid;
+	u32				num_rmids;
 	size_t				mmio_size;
 	unsigned int			num_events;
 	struct pmt_event		evts[] __counted_by(num_events);
@@ -89,7 +97,9 @@ struct event_group {
  */
 static struct event_group energy_0x26696143 = {
 	.feature	= FEATURE_PER_RMID_ENERGY_TELEM,
+	.name		= "energy",
 	.guid		= 0x26696143,
+	.num_rmids	= 576,
 	.mmio_size	= XML_MMIO_SIZE(576, 2, 3),
 	.num_events	= 2,
 	.evts		= {
@@ -104,7 +114,9 @@ static struct event_group energy_0x26696143 = {
  */
 static struct event_group perf_0x26557651 = {
 	.feature	= FEATURE_PER_RMID_PERF_TELEM,
+	.name		= "perf",
 	.guid		= 0x26557651,
+	.num_rmids	= 576,
 	.mmio_size	= XML_MMIO_SIZE(576, 7, 3),
 	.num_events	= 7,
 	.evts		= {
@@ -174,11 +186,54 @@ static bool group_has_usable_regions(struct event_group *e, struct pmt_feature_g
 	return usable_regions;
 }
 
+static bool all_regions_have_sufficient_rmid(struct event_group *e, struct pmt_feature_group
+*p)
+{
+	struct telemetry_region *tr;
+	bool ret = true;
+
+	for (int i = 0; i < p->count; i++) {
+		if (!p->regions[i].addr)
+			continue;
+		tr = &p->regions[i];
+		if (tr->num_rmids < e->num_rmids)
+			ret = false;
+	}
+
+	return ret;
+}
+
 static bool enable_events(struct event_group *e, struct pmt_feature_group *p)
 {
+	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_PERF_PKG].r_resctrl;
+
 	if (!group_has_usable_regions(e, p))
 		return false;
 
+	/* Disable feature if insufficient RMIDs */
+	if (!all_regions_have_sufficient_rmid(e, p))
+		rdt_set_feature_disabled(e->name);
+
+	/* User can override above disable from kernel command line */
+	if (!rdt_is_feature_enabled(e->name))
+		return false;
+
+	for (int i = 0; i < p->count; i++) {
+		if (!p->regions[i].addr)
+			continue;
+		/*
+		 * e->num_rmids only adjusted lower if user (via rdt= kernel
+		 * parameter) forces an event group with insufficient RMID
+		 * to be enabled.
+		 */
+		e->num_rmids = min(e->num_rmids, p->regions[i].num_rmids);
+	}
+
+	if (r->mon.num_rmid)
+		r->mon.num_rmid = min(r->mon.num_rmid, e->num_rmids);
+	else
+		r->mon.num_rmid = e->num_rmids;
+
 	for (int j = 0; j < e->num_events; j++)
 		resctrl_enable_mon_event(e->evts[j].id, true,
 					 e->evts[j].bin_bits, &e->evts[j]);
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 84336b6e1679..b67faf6a5012 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -1135,7 +1135,7 @@ static int rdt_num_rmids_show(struct kernfs_open_file *of,
 {
 	struct rdt_resource *r = rdt_kn_parent_priv(of->kn);
 
-	seq_printf(seq, "%d\n", r->mon.num_rmid);
+	seq_printf(seq, "%u\n", r->mon.num_rmid);
 
 	return 0;
 }
-- 
2.51.0


