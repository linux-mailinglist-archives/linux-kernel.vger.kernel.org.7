Return-Path: <linux-kernel+bounces-851510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B27FBD6A27
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 00:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA63C4F41B0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 22:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E70130E85E;
	Mon, 13 Oct 2025 22:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xgg0Ff+S"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BD130DEB5
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 22:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760394856; cv=none; b=HlQhB8fu9Zntp+aSBQ2vsLevpJIAolCmkNxXu7MS4iMHhUZJgDFCaYYshH78gBDAafu2afpLRGUWD8QtLiA7jRyzzW1WHPqkC0QzDlp91YA5lCEUFqJH+0wNaklXX70EjCAv/M4f7HeVplO7fPi3qdoWDMrpOVewnYNWUyNJ/Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760394856; c=relaxed/simple;
	bh=U2Dl0vc8MUX2Vcy3NzdNoPX7xlT9tHp7cWVqmM9c2Qk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NxrNrhJcVALGHyXkjc2TMhN8uO5xgL/MuOAY3qGOtNRMUmzi7B1FLjpngOSP0OYD+bgw/KBTdRDmmw3L24vBUNeGQVQoh1YjBIs0lJqfdP9eo7YLEGtztuXpHrIjTbmwSMn51N1rI4bx5gL92Zc8hU4rgKWlNTvi7UDtRQM64lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xgg0Ff+S; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760394854; x=1791930854;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U2Dl0vc8MUX2Vcy3NzdNoPX7xlT9tHp7cWVqmM9c2Qk=;
  b=Xgg0Ff+SkOKXlj/T7v6UhodPu4uiyzkF1vI/flapTLszR00qIV/pIEdj
   P370wLheye0qbZO54I57lmaQWBkGE6M0slLNg8CysJ/3rwK/0Jr2HiFkr
   zCRUE9wxfU+1w4sk+gsZo/985VwDpBKJt5uMALqHJoWzG2LrYiofcSaM0
   XRHKlcgH1TPHIu9Txjca1rOHNyZEKIy2RMREOj4vSfkBJRYhk8g39NUEO
   mbdph8Fv+SOJjFMOy9sannd5jP+v776wACVbGRjH+0kXEzh0HgyHaxnOK
   bg6B+orBWlKxTBhPyUQUJUHAZeg+wwolNHNgwBJqPt62oo3WroXrhAffM
   Q==;
X-CSE-ConnectionGUID: iiVGGS4QSmi4xhSBhcMSAA==
X-CSE-MsgGUID: EWAHimtbSCyqcg2XrgNidQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="85168916"
X-IronPort-AV: E=Sophos;i="6.19,226,1754982000"; 
   d="scan'208";a="85168916"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 15:34:03 -0700
X-CSE-ConnectionGUID: p1OkhuhaRxWJMcsgNXznrw==
X-CSE-MsgGUID: fzvk4Lm8T7+T42TxRV6/DQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,226,1754982000"; 
   d="scan'208";a="182145319"
Received: from sramkris-mobl1.amr.corp.intel.com (HELO agluck-desk3.intel.com) ([10.124.222.79])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 15:34:02 -0700
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
Subject: [PATCH v12 22/31] x86,fs/resctrl: Handle domain creation/deletion for RDT_RESOURCE_PERF_PKG
Date: Mon, 13 Oct 2025 15:33:36 -0700
Message-ID: <20251013223348.103390-23-tony.luck@intel.com>
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

The L3 resource has several requirements for domains. There are per-domain
structures that hold the 64-bit values of counters, and elements to keep
track of the overflow and limbo threads.

None of these are needed for the PERF_PKG resource. The hardware counters
are wide enough that they do not wrap around for decades.

Define a new rdt_perf_pkg_mon_domain structure which just consists of the
standard rdt_domain_hdr to keep track of domain id and CPU mask.

Update resctrl_online_mon_domain() for RDT_RESOURCE_PERF_PKG. The only action
needed for this resource is to create and populate domain directories if a
domain is added while resctrl is mounted.

Similarly resctrl_offline_mon_domain() only needs to remove domain
directories.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/resctrl/internal.h  | 13 +++++++++++
 arch/x86/kernel/cpu/resctrl/core.c      | 17 +++++++++++++++
 arch/x86/kernel/cpu/resctrl/intel_aet.c | 29 +++++++++++++++++++++++++
 fs/resctrl/rdtgroup.c                   | 17 ++++++++++-----
 4 files changed, 71 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 97616c81682b..b920f54f8736 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -84,6 +84,14 @@ static inline struct rdt_hw_l3_mon_domain *resctrl_to_arch_mon_dom(struct rdt_l3
 	return container_of(r, struct rdt_hw_l3_mon_domain, d_resctrl);
 }
 
+/**
+ * struct rdt_perf_pkg_mon_domain - CPUs sharing an package scoped resctrl monitor resource
+ * @hdr:	common header for different domain types
+ */
+struct rdt_perf_pkg_mon_domain {
+	struct rdt_domain_hdr	hdr;
+};
+
 /**
  * struct msr_param - set a range of MSRs from a domain
  * @res:       The resource to use
@@ -222,6 +230,8 @@ bool intel_aet_get_events(void);
 void __exit intel_aet_exit(void);
 int intel_aet_read_event(int domid, u32 rmid, enum resctrl_event_id evtid,
 			 void *arch_priv, u64 *val);
+void intel_aet_mon_domain_setup(int cpu, int id, struct rdt_resource *r,
+				struct list_head *add_pos);
 #else
 static inline bool intel_aet_get_events(void) { return false; }
 static inline void __exit intel_aet_exit(void) { }
@@ -230,6 +240,9 @@ static inline int intel_aet_read_event(int domid, u32 rmid, enum resctrl_event_i
 {
 	return -EINVAL;
 }
+
+static inline void intel_aet_mon_domain_setup(int cpu, int id, struct rdt_resource *r,
+					      struct list_head *add_pos) { }
 #endif
 
 #endif /* _ASM_X86_RESCTRL_INTERNAL_H */
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 6584461d4cb3..7d15112c5868 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -575,6 +575,10 @@ static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
 		if (!hdr)
 			l3_mon_domain_setup(cpu, id, r, add_pos);
 		break;
+	case RDT_RESOURCE_PERF_PKG:
+		if (!hdr)
+			intel_aet_mon_domain_setup(cpu, id, r, add_pos);
+		break;
 	default:
 		pr_warn_once("Unknown resource rid=%d\n", r->rid);
 		break;
@@ -674,6 +678,19 @@ static void domain_remove_cpu_mon(int cpu, struct rdt_resource *r)
 		l3_mon_domain_free(hw_dom);
 		break;
 	}
+	case RDT_RESOURCE_PERF_PKG: {
+		struct rdt_perf_pkg_mon_domain *pkgd;
+
+		if (!domain_header_is_valid(hdr, RESCTRL_MON_DOMAIN, RDT_RESOURCE_PERF_PKG))
+			return;
+
+		pkgd = container_of(hdr, struct rdt_perf_pkg_mon_domain, hdr);
+		resctrl_offline_mon_domain(r, hdr);
+		list_del_rcu(&hdr->list);
+		synchronize_rcu();
+		kfree(pkgd);
+		break;
+	}
 	default:
 		pr_warn_once("Unknown resource rid=%d\n", r->rid);
 		break;
diff --git a/arch/x86/kernel/cpu/resctrl/intel_aet.c b/arch/x86/kernel/cpu/resctrl/intel_aet.c
index 003b6426c8bd..fa6d3456fb7a 100644
--- a/arch/x86/kernel/cpu/resctrl/intel_aet.c
+++ b/arch/x86/kernel/cpu/resctrl/intel_aet.c
@@ -17,16 +17,21 @@
 #include <linux/compiler_types.h>
 #include <linux/container_of.h>
 #include <linux/cpu.h>
+#include <linux/cpumask.h>
 #include <linux/err.h>
 #include <linux/errno.h>
+#include <linux/gfp_types.h>
 #include <linux/init.h>
 #include <linux/intel_pmt_features.h>
 #include <linux/intel_vsec.h>
 #include <linux/io.h>
 #include <linux/overflow.h>
 #include <linux/printk.h>
+#include <linux/rculist.h>
+#include <linux/rcupdate.h>
 #include <linux/resctrl.h>
 #include <linux/resctrl_types.h>
+#include <linux/slab.h>
 #include <linux/stddef.h>
 #include <linux/topology.h>
 #include <linux/types.h>
@@ -278,3 +283,27 @@ int intel_aet_read_event(int domid, u32 rmid, enum resctrl_event_id eventid,
 
 	return valid ? 0 : -EINVAL;
 }
+
+void intel_aet_mon_domain_setup(int cpu, int id, struct rdt_resource *r,
+				struct list_head *add_pos)
+{
+	struct rdt_perf_pkg_mon_domain *d;
+	int err;
+
+	d = kzalloc_node(sizeof(*d), GFP_KERNEL, cpu_to_node(cpu));
+	if (!d)
+		return;
+
+	d->hdr.id = id;
+	d->hdr.type = RESCTRL_MON_DOMAIN;
+	d->hdr.rid = RDT_RESOURCE_PERF_PKG;
+	cpumask_set_cpu(cpu, &d->hdr.cpu_mask);
+	list_add_tail_rcu(&d->hdr.list, add_pos);
+
+	err = resctrl_online_mon_domain(r, &d->hdr);
+	if (err) {
+		list_del_rcu(&d->hdr.list);
+		synchronize_rcu();
+		kfree(d);
+	}
+}
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 837279d97db4..2238a5536f4b 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -4251,11 +4251,6 @@ void resctrl_offline_mon_domain(struct rdt_resource *r, struct rdt_domain_hdr *h
 
 	mutex_lock(&rdtgroup_mutex);
 
-	if (!domain_header_is_valid(hdr, RESCTRL_MON_DOMAIN, RDT_RESOURCE_L3))
-		goto out_unlock;
-
-	d = container_of(hdr, struct rdt_l3_mon_domain, hdr);
-
 	/*
 	 * If resctrl is mounted, remove all the
 	 * per domain monitor data directories.
@@ -4263,6 +4258,13 @@ void resctrl_offline_mon_domain(struct rdt_resource *r, struct rdt_domain_hdr *h
 	if (resctrl_mounted && resctrl_arch_mon_capable())
 		rmdir_mondata_subdir_allrdtgrp(r, hdr);
 
+	if (r->rid != RDT_RESOURCE_L3)
+		goto out_unlock;
+
+	if (!domain_header_is_valid(hdr, RESCTRL_MON_DOMAIN, RDT_RESOURCE_L3))
+		goto out_unlock;
+
+	d = container_of(hdr, struct rdt_l3_mon_domain, hdr);
 	if (resctrl_is_mbm_enabled())
 		cancel_delayed_work(&d->mbm_over);
 	if (resctrl_is_mon_event_enabled(QOS_L3_OCCUP_EVENT_ID) && has_busy_rmid(d)) {
@@ -4359,6 +4361,9 @@ int resctrl_online_mon_domain(struct rdt_resource *r, struct rdt_domain_hdr *hdr
 
 	mutex_lock(&rdtgroup_mutex);
 
+	if (r->rid != RDT_RESOURCE_L3)
+		goto mkdir;
+
 	if (!domain_header_is_valid(hdr, RESCTRL_MON_DOMAIN, RDT_RESOURCE_L3))
 		goto out_unlock;
 
@@ -4376,6 +4381,8 @@ int resctrl_online_mon_domain(struct rdt_resource *r, struct rdt_domain_hdr *hdr
 	if (resctrl_is_mon_event_enabled(QOS_L3_OCCUP_EVENT_ID))
 		INIT_DELAYED_WORK(&d->cqm_limbo, cqm_handle_limbo);
 
+mkdir:
+	err = 0;
 	/*
 	 * If the filesystem is not mounted then only the default resource group
 	 * exists. Creation of its directories is deferred until mount time
-- 
2.51.0


