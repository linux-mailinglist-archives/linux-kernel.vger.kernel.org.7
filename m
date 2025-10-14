Return-Path: <linux-kernel+bounces-851511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D745ABD6A2D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 00:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 501204E74AA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 22:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D52130EF8F;
	Mon, 13 Oct 2025 22:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mzD4zVsI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94AF30E0CB
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 22:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760394858; cv=none; b=KkFWSFe8uoERg8D3Mg5a95MsYuFSjC6hZc5sz5dl2NgYGAqRYpbKoIhrlqclZxNkH1PdJ3FK1m7J7YXE0sjMzTOtIgi7S7H0yxVfDjcR8SZrKurtRLyEDugS/HVoylYBP6kJwasFc6r8bKy0NIjJeQryy8D8+pT7SXzBdb74DXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760394858; c=relaxed/simple;
	bh=A0xpIAFNXiudoU6zMfneZZyG8i4phbCa2TqXAtfSSMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H37M8JQeahSTUFzoGqNrdkVVNbo6WyqsZYJ4WeSCVdpvMf75Or02GWXSnbrbYROu9BQnB6KkIDx+4yh5spZfag3xk5lXrKvsK3ZAaAj5cN3UZXJ1pgQEj3jAAYHXlXZmpYYXHefWqFO4EHpIICcQNTAadQWXRCZYmREeQ+hwZr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mzD4zVsI; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760394856; x=1791930856;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A0xpIAFNXiudoU6zMfneZZyG8i4phbCa2TqXAtfSSMo=;
  b=mzD4zVsIm/+XiMU1eKILeetBrgb7mw/DzB3JxZ+whTbrxwK1Uo4F6rfN
   hYnl6a4Jd8y34z1uNXTfUaljPRfaDY9iHwg7atUkZZcGeZUfXwCK2wPwp
   nZFKCQjuuRmRhT0+OxGsQTsKTzMozX5dmFVZN/sbJM43prT5JABpqBGnO
   J+T7pdQLcE21Kq0fPWa62g2FesQHO9jxHnJjXPFaXe3ijEs26dRlhVGNU
   MsHOZTyK2lfZvGRlHqsGkUYSsI0YzY3ZUpCRNzSdLMbVWxlrede3McsUG
   3M+fRpySpzrHRs89Lcl4OHzomMajjJNDAsDav/X44O1tigQBIj+HJuOs4
   Q==;
X-CSE-ConnectionGUID: Q8NUnFWNTR+epj8k1Yy0Jg==
X-CSE-MsgGUID: YY8cjHBATqmNNGmzJqt0Qw==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="85168923"
X-IronPort-AV: E=Sophos;i="6.19,226,1754982000"; 
   d="scan'208";a="85168923"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 15:34:03 -0700
X-CSE-ConnectionGUID: UVKu5CDmTFOqXJZbnQmNEw==
X-CSE-MsgGUID: 344k9HAVSi6BOanix+eeHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,226,1754982000"; 
   d="scan'208";a="182145323"
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
Subject: [PATCH v12 23/31] x86/resctrl: Add energy/perf choices to rdt boot option
Date: Mon, 13 Oct 2025 15:33:37 -0700
Message-ID: <20251013223348.103390-24-tony.luck@intel.com>
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
index 7d15112c5868..9d14ebde9d89 100644
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


