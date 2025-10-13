Return-Path: <linux-kernel+bounces-851514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A19EEBD6A3C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 00:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0B04F4F6083
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 22:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E597A30F55B;
	Mon, 13 Oct 2025 22:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OSmYFQdQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A41830E0C2
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 22:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760394860; cv=none; b=cOB/Dh9m0Xqnko85OtH7lTG4oobN/xE/4G0hzMq3kBRjfyLYfBO6be81PMXvlEOhgygHNUS9xt7m2U1VJQWTsHgpMKhPnlRhzuvp4FUw0UFSXLzbgqJ0DciZgkL2tuG6SB1KRQtkzauYu3h91Sbh7FArCem9i6Ezs5JwlQrGlR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760394860; c=relaxed/simple;
	bh=cQHOxmEFBd5hV17Qyq3qLWX9W3oCEGDuYnWtpI7oRTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OJwmAjngIFouDSwl2jcH1kkZo22yDwUomBSRCZGDbz481uP52PpgGj1wDWMAu9lvvaMVxnyzKCBbiwllwSs33h8aiUza3IaoEEx1R8GJR8HRKTBDpZeo58OGUI6+j0QCgf27hgDhW91lyd3XrY+2UyQgjk8ufCTsFGyJmHBJzVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OSmYFQdQ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760394857; x=1791930857;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cQHOxmEFBd5hV17Qyq3qLWX9W3oCEGDuYnWtpI7oRTk=;
  b=OSmYFQdQ7nj99LRX8WKIr/fCAmgnu+L/tl7UXYHMb+A/tFd4iPNG4Twd
   I46T5hoeZNeYi9VZTeAd8+PQvkJTHUWPIeeCUqqHQHljHkrzjFN9WkWOA
   TW5mYx1IVUi+jqImK/M+3hFCbmpiWT2CQeVceD1kEwJAIF7C5TJoGPJHr
   LbM1CFi2+9ThVkSIkZoIhkaxnP6c1dGO2M+lCCGLcXewB95Dtea0ewv9r
   ZRWUyA+jxfJaQw9f+2h1xaGU1mdAyDAwKwkNZY/PUYBeNGQsCq1nqAdKh
   xNM4zmiIHzNj/J29C+sMyIGuV0m9Gl7UhYgxpYrBA9Y9Nk3MN5w8rRHId
   A==;
X-CSE-ConnectionGUID: n/INPVcVTvusLND7bdpPXA==
X-CSE-MsgGUID: frxFE0otS6ust8/OBnItuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="85168924"
X-IronPort-AV: E=Sophos;i="6.19,226,1754982000"; 
   d="scan'208";a="85168924"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 15:34:03 -0700
X-CSE-ConnectionGUID: FNXhi2VMSVSAxhMEVtDi7g==
X-CSE-MsgGUID: JVkrFISxR4amAYKrH4oLgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,226,1754982000"; 
   d="scan'208";a="182145326"
Received: from sramkris-mobl1.amr.corp.intel.com (HELO agluck-desk3.intel.com) ([10.124.222.79])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 15:34:03 -0700
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
Subject: [PATCH v12 24/31] x86/resctrl: Handle number of RMIDs supported by RDT_RESOURCE_PERF_PKG
Date: Mon, 13 Oct 2025 15:33:38 -0700
Message-ID: <20251013223348.103390-25-tony.luck@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013223348.103390-1-tony.luck@intel.com>
References: <20251013223348.103390-1-tony.luck@intel.com>
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

Limit an event group's number of possible monitor resource groups
to the lowest number of "hardware counters" if the user explicitly
requests to enable an under-resourced event group.

Scan all enabled event groups and assign the RDT_RESOURCE_PERF_PKG
resource "num_rmids" value to the smallest of these values as this value
will be used later to compare against the number of RMIDs supported
by other resources to determine how many monitoring resource groups
are supported.

N.B. Change type of rdt_resource::num_rmid to u32 to match type of
event_group::num_rmids so that min(r->num_rmid, e->num_rmids) won't
complain about mixing signed and unsigned types.  Print r->num_rmid as
unsigned value in rdt_num_rmids_show().

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 include/linux/resctrl.h                 |  2 +-
 arch/x86/kernel/cpu/resctrl/internal.h  |  2 +
 arch/x86/kernel/cpu/resctrl/core.c      | 18 +++++++-
 arch/x86/kernel/cpu/resctrl/intel_aet.c | 56 +++++++++++++++++++++++--
 fs/resctrl/rdtgroup.c                   |  2 +-
 5 files changed, 74 insertions(+), 6 deletions(-)

diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 111c8f1dc77e..c7b5e56d25bb 100644
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
index 9d14ebde9d89..cc3479429044 100644
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
index fa6d3456fb7a..03d159afcfe1 100644
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
@@ -55,6 +56,7 @@ struct pmt_event {
 
 /**
  * struct event_group - All information about a group of telemetry events.
+ * @name:		Name for this group (used by boot rdt= option)
  * @pfg:		Points to the aggregated telemetry space information
  *			returned by the intel_pmt_get_regions_by_feature()
  *			call to the INTEL_PMT_TELEMETRY driver that contains
@@ -62,16 +64,22 @@ struct pmt_event {
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
  */
 struct event_group {
 	/* Data fields for additional structures to manage this group. */
+	char				*name;
 	struct pmt_feature_group	*pfg;
 
 	/* Remaining fields initialized from XML file. */
 	u32				guid;
+	u32				num_rmids;
 	size_t				mmio_size;
 	unsigned int			num_events;
 	struct pmt_event		evts[] __counted_by(num_events);
@@ -85,7 +93,9 @@ struct event_group {
  * File: xml/CWF/OOBMSM/RMID-ENERGY/cwf_aggregator.xml
  */
 static struct event_group energy_0x26696143 = {
+	.name		= "energy",
 	.guid		= 0x26696143,
+	.num_rmids	= 576,
 	.mmio_size	= XML_MMIO_SIZE(576, 2, 3),
 	.num_events	= 2,
 	.evts		= {
@@ -99,7 +109,9 @@ static struct event_group energy_0x26696143 = {
  * File: xml/CWF/OOBMSM/RMID-PERF/cwf_aggregator.xml
  */
 static struct event_group perf_0x26557651 = {
+	.name		= "perf",
 	.guid		= 0x26557651,
+	.num_rmids	= 576,
 	.mmio_size	= XML_MMIO_SIZE(576, 7, 3),
 	.num_events	= 7,
 	.evts		= {
@@ -156,21 +168,59 @@ static bool skip_telem_region(struct telemetry_region *tr, struct event_group *e
 	return false;
 }
 
+/* Side effect: Detects unusable regions and marks them as unusable */
+static bool all_regions_have_sufficient_rmid(struct event_group *e, struct pmt_feature_group *p)
+{
+	struct telemetry_region *tr;
+	bool ret = true;
+
+	for (int i = 0; i < p->count; i++) {
+		tr = &p->regions[i];
+		if (skip_telem_region(tr, e)) {
+			mark_telem_region_unusable(tr);
+			continue;
+		}
+
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
 	bool usable_events = false;
 
+	/* Disable feature if insufficient RMIDs */
+	if (!all_regions_have_sufficient_rmid(e, p))
+		rdt_set_feature_disabled(e->name);
+
+	/* User can override above disable from kernel command line */
+	if (!rdt_is_feature_enabled(e->name))
+		return false;
+
 	for (int i = 0; i < p->count; i++) {
-		if (skip_telem_region(&p->regions[i], e)) {
-			mark_telem_region_unusable(&p->regions[i]);
+		if (!p->regions[i].addr)
 			continue;
-		}
+		/*
+		 * e->num_rmids only adjusted lower if user (via rdt= kernel
+		 * parameter) forces an event group with insufficient RMID
+		 * to be enabled.
+		 */
+		e->num_rmids = min(e->num_rmids, p->regions[i].num_rmids);
 		usable_events = true;
 	}
 
 	if (!usable_events)
 		return false;
 
+	if (r->mon.num_rmid)
+		r->mon.num_rmid = min(r->mon.num_rmid, e->num_rmids);
+	else
+		r->mon.num_rmid = e->num_rmids;
+
 	for (int j = 0; j < e->num_events; j++)
 		resctrl_enable_mon_event(e->evts[j].id, true,
 					 e->evts[j].bin_bits, &e->evts[j]);
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 2238a5536f4b..f18cc5b38315 100644
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


