Return-Path: <linux-kernel+bounces-876692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CCACAC1C408
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8E1814E0665
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526D1346E42;
	Wed, 29 Oct 2025 16:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ULALtIyd"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924912F12C0
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 16:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761754889; cv=none; b=sJsBYD/5bRFhG9ivDis3w9e4vNQRegjxqHKDsP8Z5b9v6RhbYcC7dlPd2vT/Ms5c5B/hqRBQ6WCg15jrHjSdX9Phm6vwOROL6yR7ViJnftDOevS83kEGdxsTiIkkVq+kjIxVu+WbuAh6jRmDaBAlnVUaS4y5gx00XW08ADaWYW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761754889; c=relaxed/simple;
	bh=2NERTTpRBukwyEdFXTV78Gd57tx8U3uzSLcMRWY7tOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GuSqbn2wAfqnzUKEtqu0PuAAdzQz3G9vpFB1pb+QcBOfJ37HguvRBU/7Ziv/GrpGoGLAwCQI/FAJTyzfm3AHS14yKLU5CX9zi8wal4xq9vw/+YiNUV2umA9tdhVU0gP/XaA9fx9FpvEJQBRYLsXXgy7v1krT2OqAvdrOopqBSZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ULALtIyd; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761754887; x=1793290887;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2NERTTpRBukwyEdFXTV78Gd57tx8U3uzSLcMRWY7tOE=;
  b=ULALtIyd9rHkyhpvr8NqL2S3NGF9spgFrS4zE0b5aFnGVQwXztFLit9F
   pJxEwChcAAVvZVHmRRz3febWZr1XxcMmnavvjEo8vZFANaKTH69Bun5Vz
   gQbJYrXvta1JUT5DrzeeA9sKLRpGCcmXyXbItcgR1QBiHpGhSsfTo/3QW
   ZBY13VlqlyPPoNr6fy+tm9/xxYymhWMXmmGrAyxoLZFxiYl3SlvRY640Z
   e7TLqTam5N54MNBF1X+YpkuKKuABTmb58RMN8xlXcEN16lTPtWfC9jLU8
   ftV9bqqCiKb/BmdPtM1qBFOvWo030v+31nls9maVErWh0DYURqHva6LwO
   A==;
X-CSE-ConnectionGUID: sBpo5GLNQQS9Y63hNB13Lw==
X-CSE-MsgGUID: wBlqc7M9TAGvDBohv2jyWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="75330987"
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="75330987"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 09:21:25 -0700
X-CSE-ConnectionGUID: uAshOUoaQPuM+OL9jmdw/w==
X-CSE-MsgGUID: G6aiEEzhRtOpRQv+uN4rUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="184901300"
Received: from mgerlach-mobl1.amr.corp.intel.com (HELO agluck-desk3.home.arpa) ([10.124.223.146])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 09:21:25 -0700
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
Subject: [PATCH v13 02/32] x86/resctrl: Move L3 initialization into new helper function
Date: Wed, 29 Oct 2025 09:20:45 -0700
Message-ID: <20251029162118.40604-3-tony.luck@intel.com>
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

Carve out the resource monitoring domain init code into a separate helper
in order to be able to initialize new types of monitoring domains besides
the usual L3 ones.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
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


