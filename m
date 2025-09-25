Return-Path: <linux-kernel+bounces-833131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C82BA149D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 22:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99CA63A3D82
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 20:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87EF031FECE;
	Thu, 25 Sep 2025 20:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e0NRjNfi"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1B131B824
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 20:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758830647; cv=none; b=ombtDumuMlNq1aq9/UYaNegaEEvct5YCLedBtnZTVjjZX87ZBQbSJgj/TYzHthHCFlwJfdO4EwhPaLxoOIVTjnAk4zNM6ORmsfK4jdspe/sSNUfp3pmsB4A5YhxqBCYZrbRYA0Pz+xPsVGLS6BGlh+eFlDXbgzv8Vzfym6XJxsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758830647; c=relaxed/simple;
	bh=QpDDN10wiuqjDcD8OQKIjrS6jeO4TdOlFQbokXt5DZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VTwIrLZgo5sc7XiXZVVwiBKdwERKKg5lIRUcfTKRwiTMOlEYC9ndXKcdcdJJzk6D7vhjy4brHo+wPmH18phLvxh4QUr1vT0ElWaNPDu83aDitj84yXBC5/FYZGvy3DDD+bxkhjkWqqRLDr9DAzdP1PXXvwkSML58KritFscjAx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e0NRjNfi; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758830646; x=1790366646;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QpDDN10wiuqjDcD8OQKIjrS6jeO4TdOlFQbokXt5DZE=;
  b=e0NRjNfibSswMhUQXqLPaqAKxiWCwcIo/HRtpsRAUAJt65AaWLyM7UYc
   6xMBQjwUXC4t7OIwy9UxULbpNXq2M9G8ejJeo9sVQhIQUeUQUq06WkeEk
   /smUY8U1zCDeMfC9ij9FwmVYy1e5UqODCRut38V6dPb/FV+1Fed0RlKAa
   S9mIS5CMfdnuGzLccgSPhXlopRXu+FFjH0uQgf0hfozUzunfWuJdjz3J1
   3+Pv8T8zCzpozTivfbkOxK1ynCZJF/E34bFJ9S02PC/tMjjph7h5X6UOW
   3yivIt1eeXc3acSGWn+S4Mre2+L8C8ZCC5AqvqBgbSZc70vX0FwckaMLL
   Q==;
X-CSE-ConnectionGUID: eAw9GHzrTFm+U/zQn3PfGg==
X-CSE-MsgGUID: ZRGoWstjRh+ljK/fkhjvtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="61074144"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="61074144"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 13:04:05 -0700
X-CSE-ConnectionGUID: pJsaP+pZQdmBTMXc5SHqog==
X-CSE-MsgGUID: 9Hd5LD+ZTHCbTILRVq0uiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,293,1751266800"; 
   d="scan'208";a="177003600"
Received: from inaky-mobl1.amr.corp.intel.com (HELO agluck-desk3.intel.com) ([10.124.220.206])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 13:04:04 -0700
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
Subject: [PATCH v11 02/31] x86/resctrl: Move L3 initialization into new helper function
Date: Thu, 25 Sep 2025 13:02:56 -0700
Message-ID: <20250925200328.64155-3-tony.luck@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250925200328.64155-1-tony.luck@intel.com>
References: <20250925200328.64155-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Carve out the resource monitoring domain init code into a separate helper
in order to be able to initialize new types of monitoring domains besides
the usual L3 ones.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/resctrl/core.c | 64 ++++++++++++++++--------------
 1 file changed, 34 insertions(+), 30 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 8be2619db2e7..d422ae3b7ed6 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -496,37 +496,13 @@ static void domain_add_cpu_ctrl(int cpu, struct rdt_resource *r)
 	}
 }
 
-static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
+static void l3_mon_domain_setup(int cpu, int id, struct rdt_resource *r, struct list_head *add_pos)
 {
-	int id = get_domain_id_from_scope(cpu, r->mon_scope);
-	struct list_head *add_pos = NULL;
 	struct rdt_hw_mon_domain *hw_dom;
-	struct rdt_domain_hdr *hdr;
 	struct rdt_mon_domain *d;
 	struct cacheinfo *ci;
 	int err;
 
-	lockdep_assert_held(&domain_list_lock);
-
-	if (id < 0) {
-		pr_warn_once("Can't find monitor domain id for CPU:%d scope:%d for resource %s\n",
-			     cpu, r->mon_scope, r->name);
-		return;
-	}
-
-	hdr = resctrl_find_domain(&r->mon_domains, id, &add_pos);
-	if (hdr) {
-		if (!domain_header_is_valid(hdr, RESCTRL_MON_DOMAIN, r->rid))
-			return;
-		d = container_of(hdr, struct rdt_mon_domain, hdr);
-
-		cpumask_set_cpu(cpu, &d->hdr.cpu_mask);
-		/* Update the mbm_assign_mode state for the CPU if supported */
-		if (r->mon.mbm_cntr_assignable)
-			resctrl_arch_mbm_cntr_assign_set_one(r);
-		return;
-	}
-
 	hw_dom = kzalloc_node(sizeof(*hw_dom), GFP_KERNEL, cpu_to_node(cpu));
 	if (!hw_dom)
 		return;
@@ -534,7 +510,7 @@ static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
 	d = &hw_dom->d_resctrl;
 	d->hdr.id = id;
 	d->hdr.type = RESCTRL_MON_DOMAIN;
-	d->hdr.rid = r->rid;
+	d->hdr.rid = RDT_RESOURCE_L3;
 	ci = get_cpu_cacheinfo_level(cpu, RESCTRL_L3_CACHE);
 	if (!ci) {
 		pr_warn_once("Can't find L3 cache for CPU:%d resource %s\n", cpu, r->name);
@@ -544,10 +520,6 @@ static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
 	d->ci_id = ci->id;
 	cpumask_set_cpu(cpu, &d->hdr.cpu_mask);
 
-	/* Update the mbm_assign_mode state for the CPU if supported */
-	if (r->mon.mbm_cntr_assignable)
-		resctrl_arch_mbm_cntr_assign_set_one(r);
-
 	arch_mon_domain_online(r, d);
 
 	if (arch_domain_mbm_alloc(r->mon.num_rmid, hw_dom)) {
@@ -565,6 +537,38 @@ static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
 	}
 }
 
+static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
+{
+	int id = get_domain_id_from_scope(cpu, r->mon_scope);
+	struct list_head *add_pos = NULL;
+	struct rdt_domain_hdr *hdr;
+
+	lockdep_assert_held(&domain_list_lock);
+
+	if (id < 0) {
+		pr_warn_once("Can't find monitor domain id for CPU:%d scope:%d for resource %s\n",
+			     cpu, r->mon_scope, r->name);
+		return;
+	}
+
+	hdr = resctrl_find_domain(&r->mon_domains, id, &add_pos);
+	if (hdr)
+		cpumask_set_cpu(cpu, &hdr->cpu_mask);
+
+	switch (r->rid) {
+	case RDT_RESOURCE_L3:
+		/* Update the mbm_assign_mode state for the CPU if supported */
+		if (r->mon.mbm_cntr_assignable)
+			resctrl_arch_mbm_cntr_assign_set_one(r);
+		if (!hdr)
+			l3_mon_domain_setup(cpu, id, r, add_pos);
+		break;
+	default:
+		pr_warn_once("Unknown resource rid=%d\n", r->rid);
+		break;
+	}
+}
+
 static void domain_add_cpu(int cpu, struct rdt_resource *r)
 {
 	if (r->alloc_capable)
-- 
2.51.0


