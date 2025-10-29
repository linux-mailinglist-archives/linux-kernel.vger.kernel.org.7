Return-Path: <linux-kernel+bounces-876714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D96C1C132
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 111261A24A07
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F723570A9;
	Wed, 29 Oct 2025 16:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mdfZYLqo"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914923559C4
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 16:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761754906; cv=none; b=QjIM95DoljM8iyUXIhbbVvC0t82urxUJKW+CeplIInL7fKZ7ebTWes4XEbsQTYt9gwyoGpxFvcekAAW8cKSSwhDCiFH1vX7kZ4tE87eeU5bsAEofx3UWHPBTYNtQURikg1CIFY3DJ4YMUe7R+cNGoAt/OoDP7udUeg7/nhXnVEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761754906; c=relaxed/simple;
	bh=ag8fjtURW9GliF7naWMqy38kzou/iSU65C4OXVMIasg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BoCD2FqfYkUaR+fSqO9S7AKPu+TS10/ef9D5D5ZLIPF+AribZt81WjqXMBtkREE7aGiR7hkgg0X7T2YRO7HFJ5pkOEE8CzQvp79QlZ2N5wgAdCCu4RxXLopffkb913TaK6o57FcHghegGvpV2QVHisoTH6VRgrTpNSQItcWloSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mdfZYLqo; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761754904; x=1793290904;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ag8fjtURW9GliF7naWMqy38kzou/iSU65C4OXVMIasg=;
  b=mdfZYLqop/5NM0x2iQIHt3tCwUv5bbnaGgjD/fasphl3aOxLXbDWoH5M
   u4SD2G6Hza3054W2Ecx6hS9FsEkRMJ/ORQizClF+IE3GFpCMAnGLN/z23
   mC26jFarPV9eEE0pODszkqirDFgiCm+0r1tkGknEf6Og0JMI6X6JzkGuW
   wAoU5pp4KUpwTPaZiV1gBEtda0TaaC64c7wV2y0K+LBKsS8B8GVLVoZE0
   Y8l2ERYzKs3qdWT7cvYywL9sZmOm/XpSpiArwsDOHyBCIs+h4Z4EyxDdW
   tsIAYcXtvIgH1bt8hybPHnSEL9kpWKKnaOR+udchN8cwGuoB03eV/s+XR
   w==;
X-CSE-ConnectionGUID: I4xE5uBUSimwgd/iMdzzug==
X-CSE-MsgGUID: boCEUA2NRKaInieLWG/OWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="75331039"
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="75331039"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 09:21:34 -0700
X-CSE-ConnectionGUID: 6UQCyTBoTdOsYdReRA8tUA==
X-CSE-MsgGUID: ayghP97tTDeeyFHRFF0oog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="184901392"
Received: from mgerlach-mobl1.amr.corp.intel.com (HELO agluck-desk3.home.arpa) ([10.124.223.146])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 09:21:34 -0700
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
Subject: [PATCH v13 24/32] x86/resctrl: Add energy/perf choices to rdt boot option
Date: Wed, 29 Oct 2025 09:21:07 -0700
Message-ID: <20251029162118.40604-25-tony.luck@intel.com>
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

Legacy resctrl features are enumerated by X86_FEATURE_* flags. These
may be overridden by quirks to disable features in the case of errata.
Users can use kernel command line options to either disable a feature,
or to force enable a feature that was disabled by a quirk.

Provide similar functionality for hardware features that do not have an
X86_FEATURE_* flag.  Unlike other features that are tied to X86_FEATURE_*
flags, these must be queried by name. Add rdt_is_feature_enabled()
to check whether quirks or kernel command line have disabled a feature.

Users may force a feature to be disabled. E.g. "rdt=!perf" will ensure
that none of the perf telemetry events are enabled.

Resctrl architecture code may disable a feature that does not provide
full functionality. Users may override that decision.  E.g. "rdt=energy"
will enable any available energy telemetry events even if they do not
provide full functionality.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
 .../admin-guide/kernel-parameters.txt         |  2 +-
 arch/x86/kernel/cpu/resctrl/internal.h        |  2 ++
 arch/x86/kernel/cpu/resctrl/core.c            | 29 +++++++++++++++++++
 3 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 6c42061ca20e..bb8f5d73ebf8 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6207,7 +6207,7 @@
 	rdt=		[HW,X86,RDT]
 			Turn on/off individual RDT features. List is:
 			cmt, mbmtotal, mbmlocal, l3cat, l3cdp, l2cat, l2cdp,
-			mba, smba, bmec, abmc.
+			mba, smba, bmec, abmc, energy, perf.
 			E.g. to turn on cmt and turn off mba use:
 				rdt=cmt,!mba
 
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index b920f54f8736..e3710b9f993e 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -225,6 +225,8 @@ void __init intel_rdt_mbm_apply_quirk(void);
 void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
 void resctrl_arch_mbm_cntr_assign_set_one(struct rdt_resource *r);
 
+bool rdt_is_feature_enabled(char *name);
+
 #ifdef CONFIG_X86_CPU_RESCTRL_INTEL_AET
 bool intel_aet_get_events(void);
 void __exit intel_aet_exit(void);
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index ba1ddc2eec15..7013911d3575 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -772,6 +772,8 @@ enum {
 	RDT_FLAG_SMBA,
 	RDT_FLAG_BMEC,
 	RDT_FLAG_ABMC,
+	RDT_FLAG_ENERGY,
+	RDT_FLAG_PERF,
 };
 
 #define RDT_OPT(idx, n, f)	\
@@ -798,6 +800,8 @@ static struct rdt_options rdt_options[]  __ro_after_init = {
 	RDT_OPT(RDT_FLAG_SMBA,	    "smba",	X86_FEATURE_SMBA),
 	RDT_OPT(RDT_FLAG_BMEC,	    "bmec",	X86_FEATURE_BMEC),
 	RDT_OPT(RDT_FLAG_ABMC,	    "abmc",	X86_FEATURE_ABMC),
+	RDT_OPT(RDT_FLAG_ENERGY,    "energy",	0),
+	RDT_OPT(RDT_FLAG_PERF,	    "perf",	0),
 };
 #define NUM_RDT_OPTIONS ARRAY_SIZE(rdt_options)
 
@@ -847,6 +851,31 @@ bool rdt_cpu_has(int flag)
 	return ret;
 }
 
+/*
+ * Hardware features that do not have X86_FEATURE_* bits. There is no
+ * "hardware does not support this at all" case. Assume that the caller
+ * has already determined that hardware support is present and just needs
+ * to check if the feature has been disabled by a quirk that has not been
+ * overridden by a command line option.
+ */
+bool rdt_is_feature_enabled(char *name)
+{
+	struct rdt_options *o;
+	bool ret = true;
+
+	for (o = rdt_options; o < &rdt_options[NUM_RDT_OPTIONS]; o++) {
+		if (!strcmp(name, o->name)) {
+			if (o->force_off)
+				ret = false;
+			if (o->force_on)
+				ret = true;
+			break;
+		}
+	}
+
+	return ret;
+}
+
 bool resctrl_arch_is_evt_configurable(enum resctrl_event_id evt)
 {
 	if (!rdt_cpu_has(X86_FEATURE_BMEC))
-- 
2.51.0


