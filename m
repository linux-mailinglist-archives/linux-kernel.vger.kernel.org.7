Return-Path: <linux-kernel+bounces-728409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F598B027EE
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 01:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2D6C1C468BA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 23:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE0B2343B6;
	Fri, 11 Jul 2025 23:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lQlaKR05"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104F7228C9D
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 23:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752278036; cv=none; b=WdUGPcSLBsV12Gzu4sqZB+WLHMWNBixlpL9D2n3ff++zwSOedQ/tdsRmNQtHlQyAqb2FHbErGJuTRvUxzfivw8BhjBbH/m9A87vJjGwzwg8t0EDMLiYoVh812poJMV6C92TvdqK/+/sdRaxd/c37qRsTcDHiVpS2dgxN5aUer6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752278036; c=relaxed/simple;
	bh=fHP8zvR9kp5bvOEn+tYunmND9DYnT8NjwMql4mIOWhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tCxtHWiHNShKxJvVfVUL2ev7+6/6xPK6bK2eB5KzCivFKz15Y6lBYSJyreL8QszCcqNokGvTswlJexCqucfgWeVjAdyzatuQCyeFkmWCXL4D71BopAA/vc7itskzqcrGCa5QU2vW+S67IFi4mr/83p2b3/qIfnM2Irmdvhlquu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lQlaKR05; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752278035; x=1783814035;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fHP8zvR9kp5bvOEn+tYunmND9DYnT8NjwMql4mIOWhY=;
  b=lQlaKR05/7PwFuGBFqGT9NfxaEXi/mSHTO1ROJ7TpzIkJx4kPzQfTnBx
   /Vkf8tLAH7JWebZ5y691rLB2NQWVktU3qecWeYsuNp9QkcZbFDYetN2in
   E0pfBXI6MUQ9E13sqD0YjVSqUCFdskxpVZcgDvIUyve/0OsR7IOSgRphp
   Nt1n//ys4rFELNQWuAjbKaK2tls6QSWe7K9lIaQP1UmcRq6iLAbHtkca4
   nWbxTS2EUohPKYSEViuGQMoMecGpdArdR7YZ8P3jrcz/ndDLn00TrV5id
   ccJ3pLjDtgYjoqlsY/PvH8N+0FQGuEJQHrJA0N4mYqiyvDtbPZ1f2Tmfb
   A==;
X-CSE-ConnectionGUID: /jo3lIcDQjm7ueQZn5+rkg==
X-CSE-MsgGUID: YIrsrql3Sjur0+ZFtHq6QQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54292618"
X-IronPort-AV: E=Sophos;i="6.16,305,1744095600"; 
   d="scan'208";a="54292618"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 16:53:53 -0700
X-CSE-ConnectionGUID: Y9m2W4vVQjuqkSC5hePxhg==
X-CSE-MsgGUID: NgiJS2X8Su2nEmtVDgaJWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,305,1744095600"; 
   d="scan'208";a="155902104"
Received: from agluck-desk3.sc.intel.com ([172.25.103.51])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 16:53:54 -0700
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
Subject: [PATCH v7 06/31] x86/resctrl: Move L3 initialization into new helper function
Date: Fri, 11 Jul 2025 16:53:13 -0700
Message-ID: <20250711235341.113933-7-tony.luck@intel.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250711235341.113933-1-tony.luck@intel.com>
References: <20250711235341.113933-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To prepare for additional types of monitoring domains, move open coded L3
resource monitoring domain initialization from domain_add_cpu_mon() into
a new helper function l3_mon_domain_setup() called by domain_add_cpu_mon().

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/resctrl/core.c | 55 ++++++++++++++++++------------
 1 file changed, 33 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 420e4eb7c160..20b6f2bbf858 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -496,34 +496,13 @@ static void domain_add_cpu_ctrl(int cpu, struct rdt_resource *r)
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
-		return;
-	}
-
 	hw_dom = kzalloc_node(sizeof(*hw_dom), GFP_KERNEL, cpu_to_node(cpu));
 	if (!hw_dom)
 		return;
@@ -558,6 +537,38 @@ static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
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
+	if (hdr) {
+		if (!domain_header_is_valid(hdr, RESCTRL_MON_DOMAIN, r->rid))
+			return;
+		cpumask_set_cpu(cpu, &hdr->cpu_mask);
+
+		return;
+	}
+
+	switch (r->rid) {
+	case RDT_RESOURCE_L3:
+		l3_mon_domain_setup(cpu, id, r, add_pos);
+		break;
+	default:
+		WARN_ON_ONCE(1);
+	}
+}
+
 static void domain_add_cpu(int cpu, struct rdt_resource *r)
 {
 	if (r->alloc_capable)
-- 
2.50.0


