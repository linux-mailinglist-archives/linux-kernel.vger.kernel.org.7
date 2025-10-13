Return-Path: <linux-kernel+bounces-851503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E0EBD6A0F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 00:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13B923B72D8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 22:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4487930DEC0;
	Mon, 13 Oct 2025 22:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HTXyssxc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FBB3081B2
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 22:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760394853; cv=none; b=QrDnClMyrGDVsOzhnysxE/ijzfljncOCU7py/WUXebqbolKyQgPRDe0qYA+Bf+4Ta/jP6zvX/t3+ens0DqnvmuAFiPlMhlxOOwoIT6HSuoN61VyW00Ez37xSrry9fMzbce8LTYVA6Z7imMAvY/JEga+5XXw5iB1axDctY2qQRTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760394853; c=relaxed/simple;
	bh=g+/wJLhnXhQt2Vk4sUKkosgKOzWi6gYzPGw37S5LG3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=seii89McDKE4ZyQ2MGZSJZXigNiippAzAO9WZ9HqsWtWx5WgTn30ezm71mrfrrSOOAal7PHLZ8xc7q2hXmi/VjsLKFX9pNS4UuQFB+jnh7M/O89zeG8oP+JpL2a+1ucsrY0MBcqeKyL0zxhewJzYZisx4UuhcBEUgY2my8OjCjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HTXyssxc; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760394850; x=1791930850;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g+/wJLhnXhQt2Vk4sUKkosgKOzWi6gYzPGw37S5LG3Q=;
  b=HTXyssxcTP9dDJVcsgcER5xjB279CordPHPaUaobW61l2LNJdrIEEMGg
   hoPjY49419c86CjnjHktuE5fvYVAZ2B16EVdjI0BP6UaLTnASJNqbk+dT
   /ctwlb1MsmKB2CZjyzH1eoGfnS/oKXXILtXyfDrz7VpfITu7PZsBXGu1D
   eE7ciiR258AEdqEGZIFlh0titewW8VdKRcWcHycTsIEHPS4+EXb80FEgg
   XtdD2ZCL13oxIdpHxxp02pIjlDPM+lZnh9MrnEO4A4SxFMtwF2w/zAW9P
   H+wWatjPcGGHB9wxVk5gAZI9G/jTxYMPOwFrjdvWmDf+mc7hjFoOYOVGN
   w==;
X-CSE-ConnectionGUID: EyfvxBLTTOuWT4DwHGd1eA==
X-CSE-MsgGUID: dO/qDZcyR7CSU9RTK2Vojg==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="85168833"
X-IronPort-AV: E=Sophos;i="6.19,226,1754982000"; 
   d="scan'208";a="85168833"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 15:34:01 -0700
X-CSE-ConnectionGUID: 7zzOTDS7SUqVWIbvOLYuXw==
X-CSE-MsgGUID: kWYEjhaqTjOEkaAqHLNwHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,226,1754982000"; 
   d="scan'208";a="182145292"
Received: from sramkris-mobl1.amr.corp.intel.com (HELO agluck-desk3.intel.com) ([10.124.222.79])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 15:34:01 -0700
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
Subject: [PATCH v12 13/31] x86,fs/resctrl: Add and initialize rdt_resource for package scope monitor
Date: Mon, 13 Oct 2025 15:33:27 -0700
Message-ID: <20251013223348.103390-14-tony.luck@intel.com>
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

Add a new PERF_PKG resource and introduce package level scope for
monitoring telemetry events so that CPU hot plug notifiers can build
domains at the package granularity.

Use the physical package ID available via topology_physical_package_id()
to identify the monitoring domains with package level scope. This enables
user space to use:
 /sys/devices/system/cpu/cpuX/topology/physical_package_id
to identify the monitoring domain a CPU is associated with.

Now there is a new monitoring resource, add a WARN to places that
implicitly assume RDT_RESOURCE_L3.

Update some kerneldoc to point out L3 dependencies.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
 include/linux/resctrl.h            |  2 ++
 fs/resctrl/internal.h              |  6 ++++--
 arch/x86/kernel/cpu/resctrl/core.c | 10 ++++++++++
 fs/resctrl/ctrlmondata.c           |  3 +++
 fs/resctrl/monitor.c               |  3 +++
 fs/resctrl/rdtgroup.c              |  5 ++++-
 6 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 6350064ac8be..ff67224b80c8 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -53,6 +53,7 @@ enum resctrl_res_level {
 	RDT_RESOURCE_L2,
 	RDT_RESOURCE_MBA,
 	RDT_RESOURCE_SMBA,
+	RDT_RESOURCE_PERF_PKG,
 
 	/* Must be the last */
 	RDT_NUM_RESOURCES,
@@ -267,6 +268,7 @@ enum resctrl_scope {
 	RESCTRL_L2_CACHE = 2,
 	RESCTRL_L3_CACHE = 3,
 	RESCTRL_L3_NODE,
+	RESCTRL_PACKAGE,
 };
 
 /**
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index f5189b6771a0..39bdaf45fa2a 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -92,8 +92,8 @@ extern struct mon_evt mon_event_all[QOS_NUM_EVENTS];
  * @list:            Member of the global @mon_data_kn_priv_list list.
  * @rid:             Resource id associated with the event file.
  * @evt:             Event structure associated with the event file.
- * @sum:             Set when event must be summed across multiple
- *                   domains.
+ * @sum:             Set for RDT_RESOURCE_L3 when event must be summed
+ *                   across multiple domains.
  * @domid:           When @sum is zero this is the domain to which
  *                   the event file belongs. When @sum is one this
  *                   is the id of the L3 cache that all domains to be
@@ -255,6 +255,8 @@ struct rdtgroup {
 
 #define RFTYPE_ASSIGN_CONFIG		BIT(11)
 
+#define RFTYPE_RES_PERF_PKG		BIT(11)
+
 #define RFTYPE_CTRL_INFO		(RFTYPE_INFO | RFTYPE_CTRL)
 
 #define RFTYPE_MON_INFO			(RFTYPE_INFO | RFTYPE_MON)
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 5b6af3b48de3..57a328fdde59 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -100,6 +100,14 @@ struct rdt_hw_resource rdt_resources_all[RDT_NUM_RESOURCES] = {
 			.schema_fmt		= RESCTRL_SCHEMA_RANGE,
 		},
 	},
+	[RDT_RESOURCE_PERF_PKG] =
+	{
+		.r_resctrl = {
+			.name			= "PERF_PKG",
+			.mon_scope		= RESCTRL_PACKAGE,
+			.mon_domains		= mon_domain_init(RDT_RESOURCE_PERF_PKG),
+		},
+	},
 };
 
 u32 resctrl_arch_system_num_rmid_idx(void)
@@ -435,6 +443,8 @@ static int get_domain_id_from_scope(int cpu, enum resctrl_scope scope)
 		return get_cpu_cacheinfo_id(cpu, scope);
 	case RESCTRL_L3_NODE:
 		return cpu_to_node(cpu);
+	case RESCTRL_PACKAGE:
+		return topology_physical_package_id(cpu);
 	default:
 		break;
 	}
diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
index ae43e09fa5e5..d681b71e6eca 100644
--- a/fs/resctrl/ctrlmondata.c
+++ b/fs/resctrl/ctrlmondata.c
@@ -712,6 +712,9 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 	if (md->sum) {
 		struct rdt_l3_mon_domain *d;
 
+		if (WARN_ON_ONCE(resid != RDT_RESOURCE_L3))
+			return -EINVAL;
+
 		/*
 		 * This file requires summing across all domains that share
 		 * the L3 cache id that was provided in the "domid" field of the
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index 255d4bad24cb..4c984dc6784e 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -501,6 +501,9 @@ static int __mon_event_count(struct rdtgroup *rdtgrp, struct rmid_read *rr)
 	 * all domains fail for any reason.
 	 */
 	ret = -EINVAL;
+	if (WARN_ON_ONCE(rr->r->rid != RDT_RESOURCE_L3))
+		return ret;
+
 	list_for_each_entry(d, &rr->r->mon_domains, hdr.list) {
 		if (d->ci_id != rr->ci->id)
 			continue;
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index f9bfbdeecf94..c9d2cc1fd8bf 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -2330,6 +2330,8 @@ static unsigned long fflags_from_resource(struct rdt_resource *r)
 	case RDT_RESOURCE_MBA:
 	case RDT_RESOURCE_SMBA:
 		return RFTYPE_RES_MB;
+	case RDT_RESOURCE_PERF_PKG:
+		return RFTYPE_RES_PERF_PKG;
 	}
 
 	return WARN_ON_ONCE(1);
@@ -3028,7 +3030,8 @@ static void rmdir_all_sub(void)
  * @rid:    The resource id for the event file being created.
  * @domid:  The domain id for the event file being created.
  * @mevt:   The type of event file being created.
- * @do_sum: Whether SNC summing monitors are being created.
+ * @do_sum: Whether SNC summing monitors are being created. Only set
+ *	    when @rid == RDT_RESOURCE_L3.
  */
 static struct mon_data *mon_get_kn_priv(enum resctrl_res_level rid, int domid,
 					struct mon_evt *mevt,
-- 
2.51.0


