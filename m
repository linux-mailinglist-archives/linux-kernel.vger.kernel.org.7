Return-Path: <linux-kernel+bounces-624057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 105ABA9FE4D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 02:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42C441A8635C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 00:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0F515748F;
	Tue, 29 Apr 2025 00:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KtqaYqIL"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A7481ACA
	for <linux-kernel@vger.kernel.org>; Tue, 29 Apr 2025 00:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745886853; cv=none; b=Xsm5o5nJVaWmc8seBzjyKzGklLRVieCT5gLWZM01nbBnB6CCjYYtK25lPborA4Q3WUQowvOTlCtDl5XjSxLP7SvsLO92HUBxYv5Cb02MMrZXDTMOSNxJLfwVXZvJxzNK0QlQgGWqo9xrSD0SGRLtYH2DcaX6i3Cr0tH4EjfPaRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745886853; c=relaxed/simple;
	bh=PSGSVPL1y5gfIEsTCyHzQWhaIEhLiR5vVHdcdEvaO4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iPskdxSRZRiwjQTby9gPkL5Ld5sfsdKOw9NFp6uWK3SvJeTkwV39In9pg+2beYpbXIvxppCfPawpd800HzeLz5tE9p24W9FagLmigDQBfD+oXqnw90dMK5Ja7pWrkf793uYbrmFGAy+OTEFXOe32li4xQUqwnVP/BeZKkLyeg1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KtqaYqIL; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745886852; x=1777422852;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PSGSVPL1y5gfIEsTCyHzQWhaIEhLiR5vVHdcdEvaO4o=;
  b=KtqaYqIL03thIrs3XKMtEFB+qO5xpUpag1Sk9eaA36hLiIVUXMaa4228
   tkgA6yFem5rPElpWsVhznnde6b9T1vIf5niNw6QOzMyhEYhufh5LteM5T
   o5IRzW35sr2nT34ArLR8qGjxUvjiqJ1zO5Macu5csC1vr+YTq5Fh98dwH
   NrMZYmc43mwiWsOcHfRT+3bTZcycSEyhLKeY8kzzwxlGaQFlF52bEnYYE
   wqTOGjeTK8dtc2GmrUApsTQdEbPkjbXwFzCSAi8AQUPZrcpRRANENDtOS
   x9NlHiCwKj8+YDCN4sciin0F3Dvh3tljOiAUe96yGatpO4MiyiyFsXlD0
   Q==;
X-CSE-ConnectionGUID: 11SmuzqWQniaAODfIdiPjA==
X-CSE-MsgGUID: WBG8zLqoSzWAxEzf7zXGdw==
X-IronPort-AV: E=McAfee;i="6700,10204,11417"; a="58148073"
X-IronPort-AV: E=Sophos;i="6.15,247,1739865600"; 
   d="scan'208";a="58148073"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 17:34:10 -0700
X-CSE-ConnectionGUID: mSmTnzVlQI+ECmkty2vR+w==
X-CSE-MsgGUID: d0IezkNwQZ2WHTDy4dpwFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,247,1739865600"; 
   d="scan'208";a="133393967"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 17:34:09 -0700
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
Subject: [PATCH v4 05/31] fs/resctrl: Set up Kconfig options for telemetry events
Date: Mon, 28 Apr 2025 17:33:31 -0700
Message-ID: <20250429003359.375508-6-tony.luck@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250429003359.375508-1-tony.luck@intel.com>
References: <20250429003359.375508-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Intel RMID based telemetry events are counted by each CPU core
and then aggregated by one or more per-socket micro controllers.
Enumeration support is provided by the Intel PMT subsystem.

N.B. Patches for the Intel PMT system are still in progress.
They will define an INTEL_PMT_DISCOVERY Kconfig symbol that
will be one of the dependencies. This is commented out for
now. Final version will include this dependency.

arch/x86 selects this option based on:

X86_64: Counter registers are in MMIO space. There is no readq()
function on 32-bit. Emulation is possible with readl(), but there
are races. Running 32-bit kernels on systems that support this
feature seems pointless.

CPU_SUP_INTEL: It is an Intel specific feature.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/Kconfig                       | 1 +
 drivers/platform/x86/intel/pmt/Kconfig | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5a09acf41c8e..19107fdb4264 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -508,6 +508,7 @@ config X86_CPU_RESCTRL
 	bool "x86 CPU resource control support"
 	depends on X86 && (CPU_SUP_INTEL || CPU_SUP_AMD)
 	depends on MISC_FILESYSTEMS
+	select INTEL_AET_RESCTRL if (X86_64 && CPU_SUP_INTEL)
 	select ARCH_HAS_CPU_RESCTRL
 	select RESCTRL_FS
 	select RESCTRL_FS_PSEUDO_LOCK
diff --git a/drivers/platform/x86/intel/pmt/Kconfig b/drivers/platform/x86/intel/pmt/Kconfig
index e916fc966221..3a8ce39d1004 100644
--- a/drivers/platform/x86/intel/pmt/Kconfig
+++ b/drivers/platform/x86/intel/pmt/Kconfig
@@ -38,3 +38,10 @@ config INTEL_PMT_CRASHLOG
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called intel_pmt_crashlog.
+
+config INTEL_AET_RESCTRL
+	depends on INTEL_PMT_TELEMETRY # && INTEL_PMT_DISCOVERY
+	bool
+	help
+	  Architecture config should "select" this option to enable
+	  support for RMID telemetry events in the resctrl file system.
-- 
2.48.1


