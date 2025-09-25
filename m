Return-Path: <linux-kernel+bounces-833156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFC7BA14F4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 22:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42F4A7A0196
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 20:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A883294F2;
	Thu, 25 Sep 2025 20:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LR6ZWj2x"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD50324B38
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 20:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758830667; cv=none; b=dTnduHooEg49WzSGljIH7EGg5BNYCMpx3GEqkyT/MUr9t0yFIfBFDlFjAY4cXIlf7hw5EOr6fIFsK2+O4g+eFdDyFafXDXgVyfR8VjmPM6y4Wl0MzO4FIltMHD2XVlZGssWK7F+77IPTZD9wioq79m7UUAkj3XQnOFLf258VhRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758830667; c=relaxed/simple;
	bh=F/bYMDpwsvBJEBQwRTIY2pjvEIXc8qpGNlaU4LojosM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HAiUUfY1oCVmUWN9zamJd8uiWC+g9h9gsrcwioLmsiCfSVPIpLyQsaaLHfnEu6dWLYiA6HJvWUTD3w0GLQzmzNu98DbAGbxKadevaxbFZjrLJeC83q8IePrWVnZn6JFuOZyWOtlY4ZrEKRcd8WMPvROndyoGjp98O7nWZcuM++g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LR6ZWj2x; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758830666; x=1790366666;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F/bYMDpwsvBJEBQwRTIY2pjvEIXc8qpGNlaU4LojosM=;
  b=LR6ZWj2x3IQXxieIyjGyv9uaen/0qgk95KyfXD04rwQqr4xzD5S/8com
   +BhTsma/viIp7+QwEb2mif3nYt8vEYrx+3/iwPQmdO5cF5WYcNPc4ROte
   RCCUSV83SW4AfRZ83gABNGdDpr7zK4XkrG51Q//NbKnlEVxXRv3/Q1GKd
   jsKrRheRIASmNNomva8q8502yxRqDwnvDu4ptpDH6+qBdQ6979fKIzLoR
   aN0dXPYpSoLhTcrA+eFjXeSgf30K3UVS4tWMiyOF7myubUz5o2KAWrkX4
   cwYhsGyEhC7XYvTqlQ/xekC+5O2UAYCyISS6VRJSCHQk5xLAb5zoCtH2s
   w==;
X-CSE-ConnectionGUID: dlj1bZZ3QDqkHlK53D4Pqg==
X-CSE-MsgGUID: R3l9Jg7bScGl/ejdcqM2QA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="61074371"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="61074371"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 13:04:15 -0700
X-CSE-ConnectionGUID: CtTXJXAWQpyeXnkbOLvT5Q==
X-CSE-MsgGUID: HziKMY2BQrSNaNMrKi6+qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,293,1751266800"; 
   d="scan'208";a="177003699"
Received: from inaky-mobl1.amr.corp.intel.com (HELO agluck-desk3.intel.com) ([10.124.220.206])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 13:04:14 -0700
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
Subject: [PATCH v11 27/31] x86/resctrl: Enable RDT_RESOURCE_PERF_PKG
Date: Thu, 25 Sep 2025 13:03:21 -0700
Message-ID: <20250925200328.64155-28-tony.luck@intel.com>
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

Mark the RDT_RESOURCE_PERF_PKG resource as mon_capable and set the global
rdt_mon_capable flag.

Call domain_add_cpu_mon() for each online CPU to allocate all domains
for the RDT_RESOURCE_PERF_PKG since they were not created during resctrl
initialization because of the enumeration delay until first mount.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/resctrl/core.c      | 17 ++++++++++++++++-
 arch/x86/kernel/cpu/resctrl/intel_aet.c |  5 +++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 1d43087c5975..48ed6242d136 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -755,14 +755,29 @@ static int resctrl_arch_offline_cpu(unsigned int cpu)
 
 void resctrl_arch_pre_mount(void)
 {
+	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_PERF_PKG].r_resctrl;
 	static atomic_t only_once = ATOMIC_INIT(0);
-	int old = 0;
+	int cpu, old = 0;
 
 	if (!atomic_try_cmpxchg(&only_once, &old, 1))
 		return;
 
 	if (!intel_aet_get_events())
 		return;
+
+	if (!r->mon_capable)
+		return;
+
+	/*
+	 * Late discovery of telemetry events means the domains for the
+	 * resource were not built. Do that now.
+	 */
+	cpus_read_lock();
+	mutex_lock(&domain_list_lock);
+	for_each_online_cpu(cpu)
+		domain_add_cpu_mon(cpu, r);
+	mutex_unlock(&domain_list_lock);
+	cpus_read_unlock();
 }
 
 enum {
diff --git a/arch/x86/kernel/cpu/resctrl/intel_aet.c b/arch/x86/kernel/cpu/resctrl/intel_aet.c
index 039e63d8c2e7..f6afe862b9de 100644
--- a/arch/x86/kernel/cpu/resctrl/intel_aet.c
+++ b/arch/x86/kernel/cpu/resctrl/intel_aet.c
@@ -214,6 +214,9 @@ static bool enable_events(struct event_group *e, struct pmt_feature_group *p)
 	if (!usable_events)
 		return false;
 
+	r->mon_capable = true;
+	rdt_mon_capable = true;
+
 	if (r->mon.num_rmid)
 		r->mon.num_rmid = min(r->mon.num_rmid, e->num_rmids);
 	else
@@ -223,6 +226,8 @@ static bool enable_events(struct event_group *e, struct pmt_feature_group *p)
 		resctrl_enable_mon_event(e->evts[j].id, true,
 					 e->evts[j].bin_bits, &e->evts[j]);
 
+	pr_info("%s %s monitoring detected\n", r->name, e->name);
+
 	return true;
 }
 
-- 
2.51.0


