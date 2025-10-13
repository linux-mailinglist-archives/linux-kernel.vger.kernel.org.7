Return-Path: <linux-kernel+bounces-851490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A5BBD69E4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 00:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 17FED4E9ADC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 22:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02ED43093C4;
	Mon, 13 Oct 2025 22:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jH2JQvdi"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F622FF160
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 22:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760394843; cv=none; b=YI7+wHVXdHO7Q1eu3ErOySJvhdFac3j2INyG9J2KU1ncO2PVbIf/YcdqsPzk7cUNgeUlqb5KYRVHOVfBisxsqKGZT1Q61kIODF791wLcdl4QX2yIqQ0nDLTeUWhc7GG97f8steI1ZIqQjT8z8RaBQtXGwkKg6G0Wtq+5HUXBR/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760394843; c=relaxed/simple;
	bh=CXSkuQZDd3X/TQ8dxx/SG82mfLvO4sV6yEaaCfxbpQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tRZhoEfM0KHrHip9pWxPY070FVrigaiPTbatflDHmbe1QFQ9wt4Adpf8v8L84vfHr2kSn0yBEtg1+sTtrbUuH2be4G+hrYfEIVjaRQn3AwCBt72IxYFnOBKSo57pq7dkLQSDBvCd2hHp4tnF4RFGPp6F/eMOsMCJPJVuc4fCRKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jH2JQvdi; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760394842; x=1791930842;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CXSkuQZDd3X/TQ8dxx/SG82mfLvO4sV6yEaaCfxbpQo=;
  b=jH2JQvdiY4vq9dpyofjmaON1e9J8zjvD3f0QeyjlyKUbmkT2QXXYe6fE
   G0tvYGGc+4PIv8g8bOJ2PE2lJOyqKTfQWCaBqlpwjbLml2oZgVrE9qItI
   HaIa4bnYQEP7sAt1yxMz8/90MEx4x1B2U2XyNt+UWtVGPo1KBUU2WfDFg
   PPu6PgpTZ+VZmj+BfWvEHxrddbrdFfqvKYqoiyqh23lNT+rnnwwMOTLLq
   HIdJNVLniMVn9qbDmSZYOqhzunS4PUnB3fqV38gV7eD8cuovlWpxfYouJ
   9q3YKTZUWcjSq0835lKH1h7wQGefDuK/siBsyJTAtmd2wBSlEG9JfnlBH
   Q==;
X-CSE-ConnectionGUID: M44e6U1bRBSl9lHIc2TqrA==
X-CSE-MsgGUID: BMQsp3fkRguOAcbdKFhv6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="85168745"
X-IronPort-AV: E=Sophos;i="6.19,226,1754982000"; 
   d="scan'208";a="85168745"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 15:33:59 -0700
X-CSE-ConnectionGUID: dGIzacfhRA2VaiMcfktnLw==
X-CSE-MsgGUID: HFAdzW2lRMOKw/KFd1y/AQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,226,1754982000"; 
   d="scan'208";a="182145251"
Received: from sramkris-mobl1.amr.corp.intel.com (HELO agluck-desk3.intel.com) ([10.124.222.79])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 15:33:59 -0700
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
Subject: [PATCH v12 03/31] x86/resctrl: Refactor domain_remove_cpu_mon() ready for new domain types
Date: Mon, 13 Oct 2025 15:33:17 -0700
Message-ID: <20251013223348.103390-4-tony.luck@intel.com>
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

New telemetry events will be associated with a new package scoped resource with
new domain structures.

Refactor domain_remove_cpu_mon() so all the L3 domain processing is separate
from general domain actions of clearing the CPU bit in the mask.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/resctrl/core.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index d422ae3b7ed6..c7bfaa391e9f 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -626,9 +626,7 @@ static void domain_remove_cpu_ctrl(int cpu, struct rdt_resource *r)
 static void domain_remove_cpu_mon(int cpu, struct rdt_resource *r)
 {
 	int id = get_domain_id_from_scope(cpu, r->mon_scope);
-	struct rdt_hw_mon_domain *hw_dom;
 	struct rdt_domain_hdr *hdr;
-	struct rdt_mon_domain *d;
 
 	lockdep_assert_held(&domain_list_lock);
 
@@ -645,20 +643,29 @@ static void domain_remove_cpu_mon(int cpu, struct rdt_resource *r)
 		return;
 	}
 
-	if (!domain_header_is_valid(hdr, RESCTRL_MON_DOMAIN, r->rid))
+	cpumask_clear_cpu(cpu, &hdr->cpu_mask);
+	if (!cpumask_empty(&hdr->cpu_mask))
 		return;
 
-	d = container_of(hdr, struct rdt_mon_domain, hdr);
-	hw_dom = resctrl_to_arch_mon_dom(d);
+	switch (r->rid) {
+	case RDT_RESOURCE_L3: {
+		struct rdt_hw_mon_domain *hw_dom;
+		struct rdt_mon_domain *d;
 
-	cpumask_clear_cpu(cpu, &d->hdr.cpu_mask);
-	if (cpumask_empty(&d->hdr.cpu_mask)) {
+		if (!domain_header_is_valid(hdr, RESCTRL_MON_DOMAIN, RDT_RESOURCE_L3))
+			return;
+
+		d = container_of(hdr, struct rdt_mon_domain, hdr);
+		hw_dom = resctrl_to_arch_mon_dom(d);
 		resctrl_offline_mon_domain(r, d);
-		list_del_rcu(&d->hdr.list);
+		list_del_rcu(&hdr->list);
 		synchronize_rcu();
 		mon_domain_free(hw_dom);
-
-		return;
+		break;
+	}
+	default:
+		pr_warn_once("Unknown resource rid=%d\n", r->rid);
+		break;
 	}
 }
 
-- 
2.51.0


