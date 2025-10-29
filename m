Return-Path: <linux-kernel+bounces-876721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCA5C1C1FF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C27D394103C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D42358D04;
	Wed, 29 Oct 2025 16:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U+HD18Uz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB3A357732
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 16:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761754912; cv=none; b=gaNdSzo2pqurum+ez+jELmfWcyMG/keSKSYo9VxHkLWa8kMSYjbTTu7MhvKq0y4A1/j9+CBNEsrKq76QTsc0CjEQthvA2ggPrKOSEbNdtSqoIu/nc2YmTPxeV9gQWnqUxb5mzEwmReLoSzyuuduXcj29n/QbKEChQQDyInms4o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761754912; c=relaxed/simple;
	bh=TXSZS+1oKUYayVOqLtGWahfi8yVl58l4PMoLKKqueZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p/mOn5NQ6BvI1sQ/7/OFDJNWvVSt0rOCGPsxy5dVaGKmm1Feutdgc2WtUJp+qy30QiE7D9WpKGC95EfBDbbaXgByun+nD8GTh7r0K57lWUGKYmWDmX6MISwIrdoYfznR/wYA2w1x12P7/wgFmGn/SB0iYjI5FxdlaiBKRtEE9L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U+HD18Uz; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761754910; x=1793290910;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TXSZS+1oKUYayVOqLtGWahfi8yVl58l4PMoLKKqueZc=;
  b=U+HD18UzXl8R99QfyoPgwYcCaI704xZgxlvkE00EnODXxtTHSxGIVx5b
   3n0NBNtlf5GQEi9rqQ2o4FPDR0OyHdFDgH3uYgLIz4U2ouyM8Awj8Zn1X
   kbimdZeVWgrNZOOI6QUcyo2WOswdFVO9L6PrF030eQoV7xPos6muAmqJZ
   2Puyn5t+Ztd/zX2thDX8b7uw1fGnfXii46/DpwNbNUp8fhwrTzlQAfw9c
   hul2R33lrk0qVOP3TCJ2AP3QdtJkvYuhJT01cHrIyOSqrf/aAKCIRB5lY
   CuL2rSRGp/8WKCVvMzcRwRkXdUuxMS0JzezJIR8R111RKb0qfFqr7xp8z
   w==;
X-CSE-ConnectionGUID: wc7bRz3rSc+jBHD8O82WIA==
X-CSE-MsgGUID: Z2YxJ8LrSX23VrKKiweAQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="75331051"
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="75331051"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 09:21:36 -0700
X-CSE-ConnectionGUID: JBqnw2ulQwem8gcBzObyJg==
X-CSE-MsgGUID: RIalYlFaTOOb2R9wIUZflQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="184901426"
Received: from mgerlach-mobl1.amr.corp.intel.com (HELO agluck-desk3.home.arpa) ([10.124.223.146])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 09:21:36 -0700
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
Subject: [PATCH v13 31/32] x86/resctrl: Add debugfs files to show telemetry aggregator status
Date: Wed, 29 Oct 2025 09:21:14 -0700
Message-ID: <20251029162118.40604-32-tony.luck@intel.com>
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

Each telemetry aggregator provides three status registers at the top
end of MMIO space after all the per-RMID per-event counters:

  data_loss_count: This counts the number of times that this aggregator
  failed to accumulate a counter value supplied by a CPU core.

  data_loss_timestamp: This is a "timestamp" from a free running
  25MHz uncore timer indicating when the most recent data loss occurred.

  last_update_timestamp: Another 25MHz timestamp indicating when the
  most recent counter update was successfully applied.

Create files in /sys/kernel/debug/resctrl/info/PERF_PKG_MON/x86_64/
to display the value of each of these status registers for each aggregator
in each enabled event group. The prefix for each file name describes
the type of aggregator, which package it is located on, and an opaque
instance number to provide a unique file name when there are multiple
aggregators on a package.

The suffix is one of the three strings listed above. An example name is:

	energy_pkg0_agg2_data_loss_count

These files are removed along with all other debugfs entries by the
call to debugfs_remove_recursive() in resctrl_exit().

Signed-off-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/resctrl/internal.h  |  2 +
 arch/x86/kernel/cpu/resctrl/core.c      |  2 +
 arch/x86/kernel/cpu/resctrl/intel_aet.c | 60 +++++++++++++++++++++++++
 3 files changed, 64 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index cea76f88422c..8d4bdae735e4 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -236,6 +236,7 @@ int intel_aet_read_event(int domid, u32 rmid, enum resctrl_event_id evtid,
 			 void *arch_priv, u64 *val);
 void intel_aet_mon_domain_setup(int cpu, int id, struct rdt_resource *r,
 				struct list_head *add_pos);
+void intel_aet_add_debugfs(void);
 #else
 static inline bool intel_aet_get_events(void) { return false; }
 static inline void __exit intel_aet_exit(void) { }
@@ -247,6 +248,7 @@ static inline int intel_aet_read_event(int domid, u32 rmid, enum resctrl_event_i
 
 static inline void intel_aet_mon_domain_setup(int cpu, int id, struct rdt_resource *r,
 					      struct list_head *add_pos) { }
+static inline void intel_aet_add_debugfs(void) { }
 #endif
 
 #endif /* _ASM_X86_RESCTRL_INTERNAL_H */
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 7a9c7e6ad712..e96e5662e863 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -783,6 +783,8 @@ void resctrl_arch_pre_mount(void)
 		domain_add_cpu_mon(cpu, r);
 	mutex_unlock(&domain_list_lock);
 	cpus_read_unlock();
+
+	intel_aet_add_debugfs();
 }
 
 enum {
diff --git a/arch/x86/kernel/cpu/resctrl/intel_aet.c b/arch/x86/kernel/cpu/resctrl/intel_aet.c
index 2f4f8fb317d7..c9f2d8de2c60 100644
--- a/arch/x86/kernel/cpu/resctrl/intel_aet.c
+++ b/arch/x86/kernel/cpu/resctrl/intel_aet.c
@@ -18,8 +18,11 @@
 #include <linux/container_of.h>
 #include <linux/cpu.h>
 #include <linux/cpumask.h>
+#include <linux/debugfs.h>
+#include <linux/dcache.h>
 #include <linux/err.h>
 #include <linux/errno.h>
+#include <linux/fs.h>
 #include <linux/gfp_types.h>
 #include <linux/init.h>
 #include <linux/intel_pmt_features.h>
@@ -33,6 +36,7 @@
 #include <linux/resctrl.h>
 #include <linux/resctrl_types.h>
 #include <linux/slab.h>
+#include <linux/sprintf.h>
 #include <linux/stddef.h>
 #include <linux/topology.h>
 #include <linux/types.h>
@@ -203,6 +207,46 @@ static bool all_regions_have_sufficient_rmid(struct event_group *e, struct pmt_f
 	return ret;
 }
 
+static int status_read(void *priv, u64 *val)
+{
+	void __iomem *info = (void __iomem *)priv;
+
+	*val = readq(info);
+
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(status_fops, status_read, NULL, "%llu\n");
+
+static void make_status_files(struct dentry *dir, struct event_group *e, u8 pkg,
+			      int instance, void *info_end)
+{
+	char name[64];
+
+	sprintf(name, "%s_pkg%u_agg%d_data_loss_count", e->name, pkg, instance);
+	debugfs_create_file(name, 0400, dir, info_end - 24, &status_fops);
+
+	sprintf(name, "%s_pkg%u_agg%d_data_loss_timestamp", e->name, pkg, instance);
+	debugfs_create_file(name, 0400, dir, info_end - 16, &status_fops);
+
+	sprintf(name, "%s_pkg%u_agg%d_last_update_timestamp", e->name, pkg, instance);
+	debugfs_create_file(name, 0400, dir, info_end - 8, &status_fops);
+}
+
+static void create_debug_event_status_files(struct dentry *dir, struct event_group *e)
+{
+	struct pmt_feature_group *p = e->pfg;
+	void *info_end;
+
+	for (int i = 0; i < p->count; i++) {
+		if (!p->regions[i].addr)
+			continue;
+		info_end = (void __force *)p->regions[i].addr + e->mmio_size;
+		make_status_files(dir, e, p->regions[i].plat_info.package_id,
+				  i, info_end);
+	}
+}
+
 static bool enable_events(struct event_group *e, struct pmt_feature_group *p)
 {
 	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_PERF_PKG].r_resctrl;
@@ -355,3 +399,19 @@ void intel_aet_mon_domain_setup(int cpu, int id, struct rdt_resource *r,
 		kfree(d);
 	}
 }
+
+void intel_aet_add_debugfs(void)
+{
+	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_PERF_PKG].r_resctrl;
+	struct event_group **peg;
+	struct dentry *infodir;
+
+	infodir = resctrl_debugfs_mon_info_arch_mkdir(r);
+
+	if (IS_ERR_OR_NULL(infodir))
+		return;
+
+	for_each_event_group(peg)
+		if ((*peg)->pfg)
+			create_debug_event_status_files(infodir, *peg);
+}
-- 
2.51.0


