Return-Path: <linux-kernel+bounces-876719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5C9C1C0F6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6167C34BF25
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C8F357A3A;
	Wed, 29 Oct 2025 16:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NW+XK19O"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2469C3570B5
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 16:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761754910; cv=none; b=czElENfa/LLA9qKRceL93T/uA+kIaGPjInr6+xGNhJXgxc2Uh7MlmQY3kTWMrWsZlWoqFHoM7zfzJF4rYHVEJo/DNpjaLBpo138j8d2aIuXH1qvPyRVidoPA68yp6kauYAFWtx9QhWXi+qmAa//xnkAkIJLaYjqxVdT1GIT1yhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761754910; c=relaxed/simple;
	bh=L3bnERHte5K3EQEQaQOEGgTPYtoNGtXVw5Rfevci4qo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FhKIivlN0DkqErRVVDS3+HfjtTufNatZ4daT6eqXm+xs6KLlYVY4Wetg6gO9Y2VmzyR2vI/dYr/fD2AjvX829Slp39CQIZSKi/GNEU/uycEk6LdgG1Nyadw6DHqZypxgL62WVcoQ+UuOBpU0lrBFTqKGtRvGOYqBknthQSnAdEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NW+XK19O; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761754908; x=1793290908;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L3bnERHte5K3EQEQaQOEGgTPYtoNGtXVw5Rfevci4qo=;
  b=NW+XK19ON+DV589SEyptT8pGDqnBsFnjRA59Q9SPdyOKJC2bkSw0wSQV
   KpbQjtq5EcEADH1IpiKmkMGGDhowZbk3xHznpoFjFpDVpVgz+6Eh+3VyY
   6OOdvgC0xoGLpTL6BgSSmhtzWoBc4UYkReKg51kNARSo7sSluARoZ3qEX
   KyRX2+2rOXpCJbzSQxfbW2ZOTG1rz1925yfsXvb1F2Lxu32OKSudSC1mI
   PoExd5Imal4wgwSQBWEsv1i96NzlUgFKdBFrjDpmlW8DqJl6g+fTGW5kJ
   nSWNWOzO304xfBwRW3yWkFo/09AedSDvXAZbqvtOTTuIHvyo1WT6t2nZe
   A==;
X-CSE-ConnectionGUID: zHRAOku5QW+vuD9bnY9XWA==
X-CSE-MsgGUID: nnVD0NkdQKWl28s6E5y+/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="75331049"
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="75331049"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 09:21:36 -0700
X-CSE-ConnectionGUID: Wadt/yhSQ1ug70ZB7/ubKg==
X-CSE-MsgGUID: mFwODwc4QGi/z+qyoQUvcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="184901413"
Received: from mgerlach-mobl1.amr.corp.intel.com (HELO agluck-desk3.home.arpa) ([10.124.223.146])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 09:21:36 -0700
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
Subject: [PATCH v13 29/32] x86/resctrl: Enable RDT_RESOURCE_PERF_PKG
Date: Wed, 29 Oct 2025 09:21:12 -0700
Message-ID: <20251029162118.40604-30-tony.luck@intel.com>
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

Since telemetry events are enumerated on resctrl mount the RDT_RESOURCE_PERF_PKG
resource is not considered "monitoring capable" during early resctrl initialization.
This means that the domain list for RDT_RESOURCE_PERF_PKG is not built when the CPU
hot plug notifiers are registered and run for the first time right after resctrl
initialization.

Mark the RDT_RESOURCE_PERF_PKG as "monitoring capable" upon successful telemetry
event enumeration to ensure future CPU hotplug events include this resource and
initialize its domain list for CPUs that are already online.

Print to console log announcing the name of the telemetry feature detected.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/resctrl/core.c      | 16 +++++++++++++++-
 arch/x86/kernel/cpu/resctrl/intel_aet.c |  2 ++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 9eb1bca9436b..7a9c7e6ad712 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -761,14 +761,28 @@ static int resctrl_arch_offline_cpu(unsigned int cpu)
 
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
+	/*
+	 * Late discovery of telemetry events means the domains for the
+	 * resource were not built. Do that now.
+	 */
+	cpus_read_lock();
+	mutex_lock(&domain_list_lock);
+	r->mon_capable = true;
+	rdt_mon_capable = true;
+	for_each_online_cpu(cpu)
+		domain_add_cpu_mon(cpu, r);
+	mutex_unlock(&domain_list_lock);
+	cpus_read_unlock();
 }
 
 enum {
diff --git a/arch/x86/kernel/cpu/resctrl/intel_aet.c b/arch/x86/kernel/cpu/resctrl/intel_aet.c
index 252a3fd4260c..2f4f8fb317d7 100644
--- a/arch/x86/kernel/cpu/resctrl/intel_aet.c
+++ b/arch/x86/kernel/cpu/resctrl/intel_aet.c
@@ -238,6 +238,8 @@ static bool enable_events(struct event_group *e, struct pmt_feature_group *p)
 		resctrl_enable_mon_event(e->evts[j].id, true,
 					 e->evts[j].bin_bits, &e->evts[j]);
 
+	pr_info("%s %s monitoring detected\n", r->name, e->name);
+
 	return true;
 }
 
-- 
2.51.0


