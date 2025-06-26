Return-Path: <linux-kernel+bounces-704963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 051BCAEA3C2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jun 2025 18:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E5F97AAF04
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jun 2025 16:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D6B2951D7;
	Thu, 26 Jun 2025 16:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NK5+jewY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE6028FFEE
	for <linux-kernel@vger.kernel.org>; Thu, 26 Jun 2025 16:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750956595; cv=none; b=cw4+vfxNaKQVX9MnS9jCiqJdMAoHjIcRN531UMfK0sa0Meek/pjqiT/9xqDkTPV0BSNpBHJKrbfzZkZeLUH9v8i9KS+ImUIzERThibZiU5MmuQzRQqCGGQpVk/f1IZHrco83UvHbI9dLmzjQ0+WE3D55yd9AM9B1smEAsfoIWpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750956595; c=relaxed/simple;
	bh=ohU9oFXgklw2CWCxEtCjAVewl1W1kGyl4PI2z+dhjBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R/3VKoe6uIGmc8i8I42O4tcF52SUrUx0XE76wEl96RsjXWjLcuvkZGtMHDECXiYsC2pPUpuEaN7CzDFhHPYv4jiuDy9lkJUZgl9EsGisaF8wlPXfx4XlmbgVJCF8m4cDgZBj94gOPQPhBYU6bx+P+EVfOjYxj+hSnumzQjbqTEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NK5+jewY; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750956594; x=1782492594;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ohU9oFXgklw2CWCxEtCjAVewl1W1kGyl4PI2z+dhjBI=;
  b=NK5+jewYKm4baJcJKAFJ99iiWE1AzQvGN/LBNIA/pH6hRS7JoPAhYhQv
   ZvJg8BMulpw3XzeAyJfDIINS84N0Q+k7XtPlOo67b/SlRWlvlg7Di1pTs
   rm1IoU/fI7qlku1kbc7ZDoJbzeJq9RipbsaA56SpsTewr7dnUd/pes7ro
   ZdTIqAk2uratQ5ONMG9+GGzImZ7UHwfUGXSTC+MjfMPGwVOkVYsNb5Y47
   qFxvopNhzyWQ5Z/JCVR4fTs1wSRMrZUOmRClayXozZOGwL2njLzYMoluk
   Z/6EiCBY09GKN6raNIM9UznPOEA3FsYK5/jgqZtdGqr2k8SpYu8waAM/y
   w==;
X-CSE-ConnectionGUID: U+l+bvetQCqfHNGVK2xbGA==
X-CSE-MsgGUID: X8dijuYGQq6a0wi1dB0KBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11476"; a="53136330"
X-IronPort-AV: E=Sophos;i="6.16,268,1744095600"; 
   d="scan'208";a="53136330"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 09:49:52 -0700
X-CSE-ConnectionGUID: 8qfW+FaCS8mfBeQtkRkbbQ==
X-CSE-MsgGUID: cI71nm9ORAO3SuPSntI/Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,268,1744095600"; 
   d="scan'208";a="153069153"
Received: from agluck-desk3.sc.intel.com ([172.25.103.51])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 09:49:51 -0700
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
Subject: [PATCH v6 03/30] x86/resctrl: Remove 'rdt_mon_features' global variable
Date: Thu, 26 Jun 2025 09:49:12 -0700
Message-ID: <20250626164941.106341-4-tony.luck@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250626164941.106341-1-tony.luck@intel.com>
References: <20250626164941.106341-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rdt_mon_features is used as a bitmask of enabled monitor events. A monitor
event's status is now maintained in mon_evt::enabled with all monitor
events' mon_evt structures found in the filesystem's mon_event_all[] array.

Remove the remaining uses of rdt_mon_features.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/include/asm/resctrl.h        | 1 -
 arch/x86/kernel/cpu/resctrl/core.c    | 9 +++++----
 arch/x86/kernel/cpu/resctrl/monitor.c | 5 -----
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
index b1dd5d6b87db..575f8408a9e7 100644
--- a/arch/x86/include/asm/resctrl.h
+++ b/arch/x86/include/asm/resctrl.h
@@ -44,7 +44,6 @@ DECLARE_PER_CPU(struct resctrl_pqr_state, pqr_state);
 
 extern bool rdt_alloc_capable;
 extern bool rdt_mon_capable;
-extern unsigned int rdt_mon_features;
 
 DECLARE_STATIC_KEY_FALSE(rdt_enable_key);
 DECLARE_STATIC_KEY_FALSE(rdt_alloc_enable_key);
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 1a319ce9328c..5d14f9a14eda 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -863,21 +863,22 @@ static __init bool get_rdt_alloc_resources(void)
 static __init bool get_rdt_mon_resources(void)
 {
 	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+	bool ret = false;
 
 	if (rdt_cpu_has(X86_FEATURE_CQM_OCCUP_LLC)) {
 		resctrl_enable_mon_event(QOS_L3_OCCUP_EVENT_ID);
-		rdt_mon_features |= (1 << QOS_L3_OCCUP_EVENT_ID);
+		ret = true;
 	}
 	if (rdt_cpu_has(X86_FEATURE_CQM_MBM_TOTAL)) {
 		resctrl_enable_mon_event(QOS_L3_MBM_TOTAL_EVENT_ID);
-		rdt_mon_features |= (1 << QOS_L3_MBM_TOTAL_EVENT_ID);
+		ret = true;
 	}
 	if (rdt_cpu_has(X86_FEATURE_CQM_MBM_LOCAL)) {
 		resctrl_enable_mon_event(QOS_L3_MBM_LOCAL_EVENT_ID);
-		rdt_mon_features |= (1 << QOS_L3_MBM_LOCAL_EVENT_ID);
+		ret = true;
 	}
 
-	if (!rdt_mon_features)
+	if (!ret)
 		return false;
 
 	return !rdt_get_mon_l3_config(r);
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 61d38517e2bf..07f8ab097cbe 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -31,11 +31,6 @@
  */
 bool rdt_mon_capable;
 
-/*
- * Global to indicate which monitoring events are enabled.
- */
-unsigned int rdt_mon_features;
-
 #define CF(cf)	((unsigned long)(1048576 * (cf) + 0.5))
 
 static int snc_nodes_per_l3_cache = 1;
-- 
2.49.0


