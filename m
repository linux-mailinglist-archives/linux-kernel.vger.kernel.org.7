Return-Path: <linux-kernel+bounces-792376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 525DBB3C328
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 21:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A9577C199B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 19:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B04244686;
	Fri, 29 Aug 2025 19:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z34pF+35"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C94C242D9D
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 19:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756496049; cv=none; b=Y2XC8Hz3pXDWaWRw5MeyQN1/w3DEUkX1NbP640rt+shVR1/VR3covqrPTdbAnQeyvuHIOLDhF7gftnZX3aBE8mEPwyHdORpLg4NugyFADnFpQUVHU6uyazA3e9oQQhiT4F+JntpZ+HZtBor/IVHUyYlI7SyLfz7yOK5WOA3x1k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756496049; c=relaxed/simple;
	bh=7QMN9b7SlJZlu5xFqH/n2H6loELeuLunhM+odA40Ix4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ECarUBaMriqadiUYJmZ7mb5d5cgQC/lHAHlVwVP4KUQqjXQ/pGAklYigOM7A2FRBRMIz3+q2JO21Nuw8bdh4VEi8eF/HA8+UXNXIvtQ8FU/lwtRx2JoEyxR/DKAcdsqqZXzOngl+O9TDaQVhJ32klumInqmrM+aa6P2HgrTc7hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z34pF+35; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756496047; x=1788032047;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7QMN9b7SlJZlu5xFqH/n2H6loELeuLunhM+odA40Ix4=;
  b=Z34pF+35APNE7TVO6B9IbJJLppQik1gck/n8Fesvykj4zKxrxl1WhVJp
   ERtGBKpPyt8szauRalhfy0EqTnpoJvf3Y9EC8gSZ/Url6NoGbHgejJCCa
   P46Rn/VlZRDK8csZ6L+OP7C0dv1r5CyH5SXDA27R1qVKoo0tSe04lxu+l
   jQW+u6anKg9hbpjOI6t8pNak9v5EnkFAKAbjOUGM1Ac7VfhLNi2T0+Lgm
   3Azsvw5t6tiDpJQazLuBXNqvj+Rk3CYYeqqV/XAfpfDYLkSBcyWN+z1mP
   8j0tlQIvO51BPwn3g4cEU+V+u+qbElIdXsbuun8+VRk3d3fqmDZnIFntJ
   w==;
X-CSE-ConnectionGUID: cUoj32WrRwKCuIizABeofg==
X-CSE-MsgGUID: J2DOQLgqQwGcYf+wIPuasw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62625317"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62625317"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 12:33:56 -0700
X-CSE-ConnectionGUID: 2ER0hYQvSBykVlbLYQT19A==
X-CSE-MsgGUID: /DVzThcES+y5qNQkor3DkA==
X-ExtLoop1: 1
Received: from ldmartin-desk2.corp.intel.com (HELO agluck-desk3.intel.com) ([10.124.220.202])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 12:33:56 -0700
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
Subject: [PATCH v9 22/31] x86/resctrl: Handle domain creation/deletion for RDT_RESOURCE_PERF_PKG
Date: Fri, 29 Aug 2025 12:33:34 -0700
Message-ID: <20250829193346.31565-23-tony.luck@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250829193346.31565-1-tony.luck@intel.com>
References: <20250829193346.31565-1-tony.luck@intel.com>
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

Define a new rdt_perf_pkg_mon_domain structure which just consists of
the standard rdt_domain_hdr to keep track of domain id and CPU mask.

Support the PERF_PKG resource in the CPU online/offline handlers.
Allocate and initialize the rdt_perf_pkg_mon_domain structure when the
first CPU of a domain comes online and do necessary cleanup when the
last CPU of a domain goes offline.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/resctrl/internal.h  | 13 +++++++++++++
 arch/x86/kernel/cpu/resctrl/core.c      | 12 ++++++++++++
 arch/x86/kernel/cpu/resctrl/intel_aet.c | 24 ++++++++++++++++++++++++
 3 files changed, 49 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 8986071dd72a..b054c7cd13f1 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -75,6 +75,14 @@ static inline struct rdt_hw_l3_mon_domain *resctrl_to_arch_mon_dom(struct rdt_l3
 	return container_of(r, struct rdt_hw_l3_mon_domain, d_resctrl);
 }
 
+/**
+ * struct rdt_perf_pkg_mon_domain - CPUs sharing an package scoped resctrl monitor resource
+ * @hdr:	common header for different domain types
+ */
+struct rdt_perf_pkg_mon_domain {
+	struct rdt_domain_hdr   hdr;
+};
+
 /**
  * struct msr_param - set a range of MSRs from a domain
  * @res:       The resource to use
@@ -174,6 +182,8 @@ bool intel_aet_get_events(void);
 void __exit intel_aet_exit(void);
 int intel_aet_read_event(int domid, int rmid, enum resctrl_event_id evtid,
 			 void *arch_priv, u64 *val);
+void intel_aet_setup_mon_domain(int cpu, int id, struct rdt_resource *r,
+				struct list_head *add_pos);
 #else
 static inline bool intel_aet_get_events(void) { return false; }
 static inline void __exit intel_aet_exit(void) { }
@@ -182,6 +192,9 @@ static inline int intel_aet_read_event(int domid, int rmid, enum resctrl_event_i
 {
 	return -EINVAL;
 }
+
+static inline void intel_aet_setup_mon_domain(int cpu, int id, struct rdt_resource *r,
+					      struct list_head *add_pos) { }
 #endif
 
 #endif /* _ASM_X86_RESCTRL_INTERNAL_H */
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 039a00c58514..5745c6979293 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -574,6 +574,9 @@ static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
 	case RDT_RESOURCE_L3:
 		l3_mon_domain_setup(cpu, id, r, add_pos);
 		break;
+	case RDT_RESOURCE_PERF_PKG:
+		intel_aet_setup_mon_domain(cpu, id, r, add_pos);
+		break;
 	default:
 		pr_warn_once("Unknown resource rid=%d\n", r->rid);
 		break;
@@ -671,6 +674,15 @@ static void domain_remove_cpu_mon(int cpu, struct rdt_resource *r)
 		synchronize_rcu();
 		l3_mon_domain_free(hw_dom);
 		break;
+	case RDT_RESOURCE_PERF_PKG:
+		if (!domain_header_is_valid(hdr, RESCTRL_MON_DOMAIN, RDT_RESOURCE_PERF_PKG))
+			return;
+
+		resctrl_offline_mon_domain(r, hdr);
+		list_del_rcu(&hdr->list);
+		synchronize_rcu();
+		kfree(container_of(hdr, struct rdt_perf_pkg_mon_domain, hdr));
+		break;
 	default:
 		pr_warn_once("Unknown resource rid=%d\n", r->rid);
 		break;
diff --git a/arch/x86/kernel/cpu/resctrl/intel_aet.c b/arch/x86/kernel/cpu/resctrl/intel_aet.c
index 9239740e9647..71aed96f9499 100644
--- a/arch/x86/kernel/cpu/resctrl/intel_aet.c
+++ b/arch/x86/kernel/cpu/resctrl/intel_aet.c
@@ -255,3 +255,27 @@ int intel_aet_read_event(int domid, int rmid, enum resctrl_event_id eventid,
 
 	return valid ? 0 : -EINVAL;
 }
+
+void intel_aet_setup_mon_domain(int cpu, int id, struct rdt_resource *r,
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
+	d->hdr.rid = r->rid;
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
-- 
2.50.1


