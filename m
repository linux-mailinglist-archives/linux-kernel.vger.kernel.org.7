Return-Path: <linux-kernel+bounces-814816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 954A2B558F9
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 00:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AD2917663E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 22:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CF035AAB7;
	Fri, 12 Sep 2025 22:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HLHeGAQ8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E08353361
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 22:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757715080; cv=none; b=NZ02DEpwl4NYtmskpkGNeAVm4z0Dhhmz3VsynB27eEI3nDYV5PeW0YsFfBgaf4YEy8YnOxvH9/3cgGxm9fS3qVjCrG+kWsNo6IaFFr59SyMdTurq+bbmwI1+hDaRMDZetnGRqwjcv/DZ+/qB9k5L+IauxnTi6rX0WPor2XWm4k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757715080; c=relaxed/simple;
	bh=3Y6A/u7uY1/ZLibTNGO7QZGdsmFefDPpwgetJfSdbFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QnUSqVlA/exqVTMz8vJ7a/UfHTAn1Gf1XpdXGxYRK98lV09rW6VSHlRcbQA15Ez4POYo8RiJwPmvck8EOC1ZLcszftF7KFiqhjdtzAfL6dLbyxmWmQwyLZv5RisT0eK6fGUtd1HJWjvtyEIP1d8sIC/dWpUK63b5kYwQFY1lJeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HLHeGAQ8; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757715078; x=1789251078;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3Y6A/u7uY1/ZLibTNGO7QZGdsmFefDPpwgetJfSdbFg=;
  b=HLHeGAQ8NKLeh5YY7bSQD5ZJ8ejDLr104CdVenrbS2h2SaH/damYGIG6
   3Vl73/oDu4vZ4CI8ASmb/eEndNNjQaSikI4uM8xImeBjZEueZpA3z6Rp2
   junpRXxa3jtGTgCxhOMBX0N0Za9sSFAzOGKIC9PGDrBUUbzRMlbPQx7Gm
   jkxBLq0S0z2QzLH20Er32166aktNRbGhhRYay0XGcs32DmA8x2AjCrMtc
   p3I/RcmQLr8JKM9oF4n49gKuY9wy6B4hnXS6AVgMORfQ8jciF62VMChsJ
   RB+DP6z2vm5bXyqCw13wbpBNZ21t1vmAEwSFGbiaReVWhx8eieMg6i2KR
   g==;
X-CSE-ConnectionGUID: skVpEO6bQlWUqaSv7u3TCQ==
X-CSE-MsgGUID: Kl3x1JjsSHqO029IyrTxoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11551"; a="60002795"
X-IronPort-AV: E=Sophos;i="6.18,260,1751266800"; 
   d="scan'208";a="60002795"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 15:11:11 -0700
X-CSE-ConnectionGUID: mkVsBc/MS+OTT/Ogni+M+A==
X-CSE-MsgGUID: ax1AoiivTkK7ezywxWcg8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,260,1751266800"; 
   d="scan'208";a="179265207"
Received: from smoehrl-linux.amr.corp.intel.com (HELO agluck-desk3.intel.com) ([10.124.221.49])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 15:11:10 -0700
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
Subject: [PATCH v10 20/28] x86/resctrl: Add energy/perf choices to rdt boot option
Date: Fri, 12 Sep 2025 15:10:41 -0700
Message-ID: <20250912221053.11349-21-tony.luck@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250912221053.11349-1-tony.luck@intel.com>
References: <20250912221053.11349-1-tony.luck@intel.com>
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
index 5bab2eff81eb..70b04e8198b7 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6154,7 +6154,7 @@
 	rdt=		[HW,X86,RDT]
 			Turn on/off individual RDT features. List is:
 			cmt, mbmtotal, mbmlocal, l3cat, l3cdp, l2cat, l2cdp,
-			mba, smba, bmec, abmc.
+			mba, smba, bmec, abmc, energy, perf.
 			E.g. to turn on cmt and turn off mba use:
 				rdt=cmt,!mba
 
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 592c7cf8e354..db71ce336af3 100644
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
index f493f9a2fdf5..2f789d8bd970 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -766,6 +766,8 @@ enum {
 	RDT_FLAG_SMBA,
 	RDT_FLAG_BMEC,
 	RDT_FLAG_ABMC,
+	RDT_FLAG_ENERGY,
+	RDT_FLAG_PERF,
 };
 
 #define RDT_OPT(idx, n, f)	\
@@ -792,6 +794,8 @@ static struct rdt_options rdt_options[]  __ro_after_init = {
 	RDT_OPT(RDT_FLAG_SMBA,	    "smba",	X86_FEATURE_SMBA),
 	RDT_OPT(RDT_FLAG_BMEC,	    "bmec",	X86_FEATURE_BMEC),
 	RDT_OPT(RDT_FLAG_ABMC,	    "abmc",	X86_FEATURE_ABMC),
+	RDT_OPT(RDT_FLAG_ENERGY,    "energy",	0),
+	RDT_OPT(RDT_FLAG_PERF,	    "perf",	0),
 };
 #define NUM_RDT_OPTIONS ARRAY_SIZE(rdt_options)
 
@@ -841,6 +845,31 @@ bool rdt_cpu_has(int flag)
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


