Return-Path: <linux-kernel+bounces-833133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F5BBA14A3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 22:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4A7B3876E5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 20:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A65E31FEEF;
	Thu, 25 Sep 2025 20:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yno78H6x"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2170B31E0E4
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 20:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758830648; cv=none; b=cpbTSCeg6RUbmwri++8j0RVMCzQV1qD3LA17f9NNsJC+VIZiy51jrhpTrydyEcqboqA/78aPaZ7eRtSjVJ6QUeU8pTFbVAero/BInfojsL3ycOXy/LUtqYx7bKYozX9SpzUxRcA9egHEwM5UkHMV5Pd3oQoZe5A7Css5wNnJzeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758830648; c=relaxed/simple;
	bh=3UhXG2+nFOE22Y9OsPyaWXsBmdTkUv4k885gDZlF2eQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cnZBdG3/V3dOI44UZKsQApe/pTdFqMrBT4OzI9eF6sWqhI1oKw6luYhe04hjRUYx5I7Xe7novtyX2nv8y7HAv9eigMvMSnIBdl/rVo35gooPAR+qDQgjHv3oz74ooxp7+JVrCPlHrGVFiCKs24RirxtSYO2TKmFckfpowFw/Qk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yno78H6x; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758830648; x=1790366648;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3UhXG2+nFOE22Y9OsPyaWXsBmdTkUv4k885gDZlF2eQ=;
  b=Yno78H6xZR48LyIEsFgVF5woM3SZxI1jMjnXA7xBw5/y8KPKcVoBmCb1
   kxIiDbeapDAYIUjEzQNIUc8+VfsEKP2adY41I7Uc2DkTcNZB+YLlODDE0
   BjsvIFc2Cb3p81CqLH1RdvBj6+zxQAFWdqk9sK/tRMmDdFtnvcYpEx/wG
   ur0VfYN7f04MOihdFU3/0lKOnmPXtwcpu1aeLzlcxTrxqXZZWhYcYXcx9
   jzleU8vhNGSaAqTyF9UJ0mK2vM/TB4Jj+fEWB+P2PU1VIHgIDXshDN8Kr
   SNGHJO/oP/RY5t5t1B4aDsHbNmSsl+IylmnOdrruqSoaDuAHGeswQnHhI
   A==;
X-CSE-ConnectionGUID: 3XOjtWldTAGiXncwCZaorg==
X-CSE-MsgGUID: B+5Erf0TR/6ANVv+9eKLRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="61074161"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="61074161"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 13:04:05 -0700
X-CSE-ConnectionGUID: pfk54LA2Q2KzhljmU4LYfg==
X-CSE-MsgGUID: eq9C6MZ9QH+SfbIoyaqfSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,293,1751266800"; 
   d="scan'208";a="177003609"
Received: from inaky-mobl1.amr.corp.intel.com (HELO agluck-desk3.intel.com) ([10.124.220.206])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 13:04:05 -0700
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
Subject: [PATCH v11 04/31] x86/resctrl: Clean up domain_remove_cpu_ctrl()
Date: Thu, 25 Sep 2025 13:02:58 -0700
Message-ID: <20250925200328.64155-5-tony.luck@intel.com>
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

For symmetry with domain_remove_cpu_mon() refactor
domain_remove_cpu_ctrl() to take an early return when removing
a CPU does not empty the domain.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/resctrl/core.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index b471918bced6..28c8e28bb1dd 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -599,28 +599,27 @@ static void domain_remove_cpu_ctrl(int cpu, struct rdt_resource *r)
 		return;
 	}
 
+	cpumask_clear_cpu(cpu, &hdr->cpu_mask);
+	if (!cpumask_empty(&hdr->cpu_mask))
+		return;
+
 	if (!domain_header_is_valid(hdr, RESCTRL_CTRL_DOMAIN, r->rid))
 		return;
 
 	d = container_of(hdr, struct rdt_ctrl_domain, hdr);
 	hw_dom = resctrl_to_arch_ctrl_dom(d);
 
-	cpumask_clear_cpu(cpu, &d->hdr.cpu_mask);
-	if (cpumask_empty(&d->hdr.cpu_mask)) {
-		resctrl_offline_ctrl_domain(r, d);
-		list_del_rcu(&d->hdr.list);
-		synchronize_rcu();
-
-		/*
-		 * rdt_ctrl_domain "d" is going to be freed below, so clear
-		 * its pointer from pseudo_lock_region struct.
-		 */
-		if (d->plr)
-			d->plr->d = NULL;
-		ctrl_domain_free(hw_dom);
+	resctrl_offline_ctrl_domain(r, d);
+	list_del_rcu(&hdr->list);
+	synchronize_rcu();
 
-		return;
-	}
+	/*
+	 * rdt_ctrl_domain "d" is going to be freed below, so clear
+	 * its pointer from pseudo_lock_region struct.
+	 */
+	if (d->plr)
+		d->plr->d = NULL;
+	ctrl_domain_free(hw_dom);
 }
 
 static void domain_remove_cpu_mon(int cpu, struct rdt_resource *r)
-- 
2.51.0


