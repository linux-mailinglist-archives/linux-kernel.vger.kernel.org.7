Return-Path: <linux-kernel+bounces-792363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 309C6B3C31B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 21:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 747A23A6CE5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 19:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1D3256C6D;
	Fri, 29 Aug 2025 19:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cTSx/RA5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959C52459D4
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 19:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756496040; cv=none; b=aK50AduJRzYvDKFCTMfsjrXf22GDxI2/um9Ie5enZa/yGA5nNNpJOPptFlf9Y7f0RyButfQu8YEeP9616xdHqgB/eW3f44Qm5f1tI0SzsD9IBu+rUjG82sINfCFoG8HYczR7AzHD+W5u2Gk3IL4o66ml5NZtq4/2DjbNOC4uwrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756496040; c=relaxed/simple;
	bh=sgTn18NxUgyf/UEH420jefEbiBwbco3CCd8zQ7xR3sE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G8yp5GrbYTu5V4TaN0YKsRbMYJ6jm4Hv9hTXePrfFVvWJfRkJAS4n+zuG2bkxCu6RGax8ME6cTzHcUAKEU8WKoKFfu91oMb1mRolITAH4S94WSfxjELIRtV4ZTHjE4AT741OCw0NSZhPTVNifTBQoL6MmCnYduGE6ZJTJ9CqT1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cTSx/RA5; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756496038; x=1788032038;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sgTn18NxUgyf/UEH420jefEbiBwbco3CCd8zQ7xR3sE=;
  b=cTSx/RA5MnN3Rj78bL9IJHH4pKQyhblwddiOF7q5gyFGwMaUI2LTbvZO
   BpLQJq+fQPEgJ12MYv+xR9nnAif9GAXtU2YKE2uOORLS8zoFw4un2Ep6g
   H3Fi+Yfkwd4Bz3PDwgBkE5+apf8ydLePSO3J/mlc9Yo8g1RBfUyxCRuMY
   6tLIPugkQIOnK0nvex7giAaCYJxwU0psyFS6bmBxw7YL9U7Az486gzrlT
   HZpgnwflTx0FUIuR0UjM+niDtlTWupzOR3t9D+7NMGpE0vVVdc/4FY8g6
   6a2r/NeAdjRkwnQIvguf/3ZNljN40EsMCJgVbmojFiuKHNbKVC3b6uitK
   w==;
X-CSE-ConnectionGUID: Y1RRyY4zR0a+r3Bad8hSww==
X-CSE-MsgGUID: aABLIsy8R8SOCZlUMUSvMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62625197"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62625197"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 12:33:53 -0700
X-CSE-ConnectionGUID: 9S+jYt04QceijoUcjwksyQ==
X-CSE-MsgGUID: kf5JAKVMRCK/SUGaYRdf+A==
X-ExtLoop1: 1
Received: from ldmartin-desk2.corp.intel.com (HELO agluck-desk3.intel.com) ([10.124.220.202])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 12:33:53 -0700
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
Subject: [PATCH v9 08/31] x86/resctrl: Clean up domain_remove_cpu_ctrl()
Date: Fri, 29 Aug 2025 12:33:20 -0700
Message-ID: <20250829193346.31565-9-tony.luck@intel.com>
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

For symmetry with domain_remove_cpu_mon() refactor
domain_remove_cpu_ctrl() to take an early return when removing
a CPU does not empty the domain.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/resctrl/core.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index f1b215b72844..44572973bcd4 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -600,28 +600,27 @@ static void domain_remove_cpu_ctrl(int cpu, struct rdt_resource *r)
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
2.50.1


