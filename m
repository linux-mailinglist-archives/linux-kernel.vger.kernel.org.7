Return-Path: <linux-kernel+bounces-851516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CBDBD6A39
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 00:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E6A24003A4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 22:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199CB30F925;
	Mon, 13 Oct 2025 22:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LtONZCQy"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD21D30EF75
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 22:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760394862; cv=none; b=EbG2UfDM/x7tt6XjBJpsw++WaOkZYhDytk2jPa+rOKlKPWUv2xWueFTWwvrVffYLov27QlyJUdN3Xcjg3vOtQoVuoEgBD+z+nPhuJWgcHSx8NXesIosS3c6JxSfpwc4FqHLxRsT2DCMmbNeE50q8MnAIsCYqOGNqUIJSryez7X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760394862; c=relaxed/simple;
	bh=cuRhoizmfwXcJSSVDXuZyJahB4wrm/4dq13lhFeHdfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=akh/+PwlDLt7UZACV17b4GuGrufsxhA76miICaeZM4alblD6ogC6/3VHWpnEf1hTy4QzycqMUNLTk3rkKaXMxPgj3NoiMPhSVRIJpHRnXRAEBNZNp9TifHKMB/NW2RYblkYjLOJb/KSU24GA0oDejehhyBdL2KMT7JJScDxRVrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LtONZCQy; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760394860; x=1791930860;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cuRhoizmfwXcJSSVDXuZyJahB4wrm/4dq13lhFeHdfc=;
  b=LtONZCQyND0/0w+h6eNLiEmU/lomnhIxzqECK0ByKFdSagAPDqg1yaBS
   RVDsN2GjsKkROuq5O+OT+6HcXUs393KC49AHLX+a0slGVsokTc4nSVGAp
   GlJc9Dj3f+gbQYaDDKpmAp79xe0fMBeLx3mytvcBmEFDTS7a3KOGrQAQj
   UgUtLVDs+Bc9BkKZGRZ92/DLdeWy7WivH3TmG3pY7Vo1KPbPjeWnjcQ0w
   M29EVQBfp+ykxNq6Xmkee3EtJBsoffIpVOgD4/Q3k4oNBU5/+hAq/F3Tg
   eyCpnOKfZIAchbiitjz7LyhmfiodiJX45IKbuJjcglkLf3rHUlnhwpIkh
   Q==;
X-CSE-ConnectionGUID: 69SmUuUaStykcHHs8twcNg==
X-CSE-MsgGUID: yEiVsMFQRxehfpF86WL80Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="85168963"
X-IronPort-AV: E=Sophos;i="6.19,226,1754982000"; 
   d="scan'208";a="85168963"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 15:34:04 -0700
X-CSE-ConnectionGUID: NNpPc321R8SXQs/hq1wpoA==
X-CSE-MsgGUID: Erua9l8eSdiXfVY6jr4xhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,226,1754982000"; 
   d="scan'208";a="182145339"
Received: from sramkris-mobl1.amr.corp.intel.com (HELO agluck-desk3.intel.com) ([10.124.222.79])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 15:34:03 -0700
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
Subject: [PATCH v12 28/31] x86/resctrl: Enable RDT_RESOURCE_PERF_PKG
Date: Mon, 13 Oct 2025 15:33:42 -0700
Message-ID: <20251013223348.103390-29-tony.luck@intel.com>
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

Since telemetry events are enumerated on resctrl mount the RDT_RESOURCE_PERF_PKG
resource is not considered "monitoring capable" during early resctrl initialization.
This means that the domain list for RDT_RESOURCE_PERF_PKG is not built when the CPU
hot plug notifiers are registered and run for the first time right after resctrl
initialization.

Mark the RDT_RESOURCE_PERF_PKG as "monitoring capable" upon successful telemetry event
enumeration to ensure future CPU hotplug events include this resource and initialize its
domain list for CPUs that are already online.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/resctrl/core.c      | 16 +++++++++++++++-
 arch/x86/kernel/cpu/resctrl/intel_aet.c |  2 ++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 955a1904ba2a..2d8c20819ec3 100644
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
index 03d159afcfe1..bc0a4d84a4e0 100644
--- a/arch/x86/kernel/cpu/resctrl/intel_aet.c
+++ b/arch/x86/kernel/cpu/resctrl/intel_aet.c
@@ -225,6 +225,8 @@ static bool enable_events(struct event_group *e, struct pmt_feature_group *p)
 		resctrl_enable_mon_event(e->evts[j].id, true,
 					 e->evts[j].bin_bits, &e->evts[j]);
 
+	pr_info("%s %s monitoring detected\n", r->name, e->name);
+
 	return true;
 }
 
-- 
2.51.0


