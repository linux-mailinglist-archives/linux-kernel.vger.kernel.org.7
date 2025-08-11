Return-Path: <linux-kernel+bounces-763377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F53AB21407
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 20:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F575621C68
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 18:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E974B2E283C;
	Mon, 11 Aug 2025 18:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QTOBmBL6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E16F2E1754
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 18:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754936258; cv=none; b=PR3qpCS6f5LyDiQoBcQSSI6oKIEzEy5KcVlP3NQaroSK2FFjuBDqBgM5rsPhJoqiOOg7ZPFOjITaYW5guiGW7S7BiFdoGffRoY0fa11AXnwuQk5UH3zpk6EYYhxSoMqsF7XECe+yZaK9zDML7TbxA7FRq+V2qMMHzChDehyFgFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754936258; c=relaxed/simple;
	bh=LtCIWxRjo81w25b5/equjWzNBh8gkG5EfSSMHGMzUKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XmMJqJ1SSNzEtLGdCBUIL0dQGYyoAAKpIjBGICFQDk4ca5+aaw6yXP958Fn1GAs+Ksnr8J71gXPK2js05cMeltoLJEFgMZ7ZsVDZS9xo7OHVTj3A8WVhF6u4XlrETI9FeM5Ojx5773sJg7kvFEaD6hkzhWZKZ/mJ7VnLhrwFHEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QTOBmBL6; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754936257; x=1786472257;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LtCIWxRjo81w25b5/equjWzNBh8gkG5EfSSMHGMzUKM=;
  b=QTOBmBL6qRQcIYLL3OLgt5Z4UXKu7Rnxw4Jft2CTfCs9ITzD+BEaHa4q
   sBr59HSm7ZDoNHVHDoHotN6bxtaLRCAdJpOrYwk9aeQcXBctK2Me+mWTH
   ZNDWfuIvsYH0e2s6462YMjY+LEZThguAIN4jt3iChRqYQqGEvTkgejsly
   JdRZzAhsFLrpI2tHhRV5qfS23tFhin2UJSh1/1wh+yYm9DAxB7Udac0S/
   5eZbUNISOw03SC47QPzgNNCcoGQQKGeutlc/VOdeNrvUH+3FNZVuQUcJB
   eTtQR3obBWY7G/TZscG3mcno8ui1orag6owZ47OE6dVWJBIQZ/dPmDIrU
   A==;
X-CSE-ConnectionGUID: vPe18kSJT7a1tUHQ/SENRg==
X-CSE-MsgGUID: 8GXkfnQ+Q+GRaItKxTAkqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="68277364"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="68277364"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 11:17:26 -0700
X-CSE-ConnectionGUID: 4bXFEu6iROmp1QBhPDy8Gg==
X-CSE-MsgGUID: SSa0qaHTSeWvG2kb1DlBDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="196825627"
Received: from puneetse-mobl.amr.corp.intel.com (HELO agluck-desk3.home.arpa) ([10.124.221.229])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 11:17:23 -0700
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
Subject: [PATCH v8 06/32] x86/resctrl: Move L3 initialization into new helper function
Date: Mon, 11 Aug 2025 11:16:40 -0700
Message-ID: <20250811181709.6241-7-tony.luck@intel.com>
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

All resctrl monitor events are associated with the L3 resource, but
this is about to change.

To prepare for additional types of monitoring domains, move open coded L3
resource monitoring domain initialization from domain_add_cpu_mon() into
a new helper l3_mon_domain_setup() called by domain_add_cpu_mon().

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/resctrl/core.c | 56 ++++++++++++++++++------------
 1 file changed, 34 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 420e4eb7c160..66270c230b4e 100644
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
@@ -558,6 +537,39 @@ static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
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
+		break;
+	}
+}
+
 static void domain_add_cpu(int cpu, struct rdt_resource *r)
 {
 	if (r->alloc_capable)
-- 
2.50.1


