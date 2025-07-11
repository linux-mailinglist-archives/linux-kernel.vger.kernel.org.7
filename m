Return-Path: <linux-kernel+bounces-728427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B58B027FE
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 01:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD0567BAD58
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 23:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24176244696;
	Fri, 11 Jul 2025 23:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jGcz+8Lj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3015B2417EE
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 23:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752278051; cv=none; b=taHsmzmpUZ4BGpdq7mLhLbhy/TQjv2O/RZq1lgDOgLag+aMbyJZVwqwc1D+GPqtcQXa+k4kIx45tFTHZGuIiUtNlcZj3pBzUfDuDvjbaEs+Z3uYjL3ddLc4RUlS1R3BUkTMP09lqovtYGeZ5gTVEU7iJ9MxaqS4KqyNsEvuCmfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752278051; c=relaxed/simple;
	bh=d84VgkCXBtXfc0HuHPVmzCr0+JqKDJaMuirqvTzotDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lD7t04gB7eTGhKJxqFkJiWIU6w/qoHuNBaf6PDSOrxlX1EJqDPhnXKXJOFffEnNlTWoqQVohlqN1FnJpty68MnULYanziwmI7VCE0rBi73ootYSkMBI7ewGRHaknNpugES2S3KCoHQiJJfMANQLRPAR8jpbhHTOUN8JWTTtLAp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jGcz+8Lj; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752278049; x=1783814049;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d84VgkCXBtXfc0HuHPVmzCr0+JqKDJaMuirqvTzotDY=;
  b=jGcz+8LjEoYgeMG0uZWq0Ap4K6RiWe0xDaDTnQu0FYHr2O9IO4WnxrEo
   z+2GR8Lva/lyF/2vaS6jc0Tw1fiRRvqzUr+YtutEJ2CangqdYMCzz6lEl
   FPBbeIXN8bY6b3a+T2SB02pVFrmNNr556XYzAXQxWWcI0sVxG0jGRE8dx
   /w9Pi2CpSzewiI2dnWx1VMKcRQyg+wm3wFCGatUswgEI4TQafwhDGKCmo
   hevpKuUvfgVqO2c2qNFu30vVBArSOVOkRoOA8xD5RbgC41SMdPn0uPblM
   hQ/Smve0PfnKRXKNscrVNa7SWUcpeFgfOx7vS8vVaWhoHIA+4OqJoawY3
   w==;
X-CSE-ConnectionGUID: zJWTDPAaQ1SIgksOW6Ld2w==
X-CSE-MsgGUID: uyuwBRzeRceaa/NLyuL3fg==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54292767"
X-IronPort-AV: E=Sophos;i="6.16,305,1744095600"; 
   d="scan'208";a="54292767"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 16:54:04 -0700
X-CSE-ConnectionGUID: yee5ZQWqR1KU9SG5UNQ94Q==
X-CSE-MsgGUID: t8triOZAQ/GV3aOgb/43iA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,305,1744095600"; 
   d="scan'208";a="155902160"
Received: from agluck-desk3.sc.intel.com ([172.25.103.51])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 16:54:05 -0700
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
Subject: [PATCH v7 24/31] x86/resctrl: Add energy/perf choices to rdt boot option
Date: Fri, 11 Jul 2025 16:53:31 -0700
Message-ID: <20250711235341.113933-25-tony.luck@intel.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250711235341.113933-1-tony.luck@intel.com>
References: <20250711235341.113933-1-tony.luck@intel.com>
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
X86_FEATURE_* flag.

Unlike other options that are tied to X86_FEATURE_* flags, these must be
queried by name. Add rdt_is_feature_enabled() to check whether quirks
or kernel command line have disabled a feature. Just like the legacy
feature options the command line enable overrides quirk disable.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 .../admin-guide/kernel-parameters.txt         |  2 +-
 arch/x86/kernel/cpu/resctrl/internal.h        |  2 ++
 arch/x86/kernel/cpu/resctrl/core.c            | 30 +++++++++++++++++++
 arch/x86/kernel/cpu/resctrl/intel_aet.c       |  7 +++++
 4 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f1f2c0874da9..4c12159f3ea0 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6066,7 +6066,7 @@
 	rdt=		[HW,X86,RDT]
 			Turn on/off individual RDT features. List is:
 			cmt, mbmtotal, mbmlocal, l3cat, l3cdp, l2cat, l2cdp,
-			mba, smba, bmec.
+			mba, smba, bmec, energy, perf.
 			E.g. to turn on cmt and turn off mba use:
 				rdt=cmt,!mba
 
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 0081fb5a4420..83166dd0b9c8 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -169,6 +169,8 @@ void __init intel_rdt_mbm_apply_quirk(void);
 
 void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
 
+bool rdt_is_feature_enabled(char *option);
+
 #ifdef CONFIG_X86_RESCTRL_CPU_INTEL_AET
 bool intel_aet_get_events(void);
 void __exit intel_aet_exit(void);
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index c954171073c7..83e046313600 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -791,6 +791,8 @@ enum {
 	RDT_FLAG_MBA,
 	RDT_FLAG_SMBA,
 	RDT_FLAG_BMEC,
+	RDT_FLAG_ENERGY,
+	RDT_FLAG_PERF,
 };
 
 #define RDT_OPT(idx, n, f)	\
@@ -816,6 +818,8 @@ static struct rdt_options rdt_options[]  __ro_after_init = {
 	RDT_OPT(RDT_FLAG_MBA,	    "mba",	X86_FEATURE_MBA),
 	RDT_OPT(RDT_FLAG_SMBA,	    "smba",	X86_FEATURE_SMBA),
 	RDT_OPT(RDT_FLAG_BMEC,	    "bmec",	X86_FEATURE_BMEC),
+	RDT_OPT(RDT_FLAG_ENERGY,    "energy",	0),
+	RDT_OPT(RDT_FLAG_PERF,	    "perf",	0),
 };
 #define NUM_RDT_OPTIONS ARRAY_SIZE(rdt_options)
 
@@ -865,6 +869,32 @@ bool rdt_cpu_has(int flag)
 	return ret;
 }
 
+/*
+ * Hardware features that do not have X86_FEATURE_* bits.
+ * There is no "hardware does not support this at all" case.
+ * Assume that the caller has already determined that
+ * support is present and just needs to check if the option has been
+ * disabled by a quirk that has not been overridden by a command
+ * line option.
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
diff --git a/arch/x86/kernel/cpu/resctrl/intel_aet.c b/arch/x86/kernel/cpu/resctrl/intel_aet.c
index bd6011a95d12..e64a4630e95c 100644
--- a/arch/x86/kernel/cpu/resctrl/intel_aet.c
+++ b/arch/x86/kernel/cpu/resctrl/intel_aet.c
@@ -49,6 +49,7 @@ struct pmt_event {
 
 /**
  * struct event_group - All information about a group of telemetry events.
+ * @name:		Name for this group (used by boot rdt= option)
  * @pfg:		Points to the aggregated telemetry space information
  *			within the OOBMSM driver that contains data for all
  *			telemetry regions.
@@ -61,6 +62,7 @@ struct pmt_event {
  */
 struct event_group {
 	/* Data fields for additional structures to manage this group. */
+	char				*name;
 	struct pmt_feature_group	*pfg;
 	struct list_head		list;
 	struct pkg_mmio_info		**pkginfo;
@@ -82,6 +84,7 @@ static LIST_HEAD(active_event_groups);
  * File: xml/CWF/OOBMSM/RMID-ENERGY/cwf_aggregator.xml
  */
 static struct event_group energy_0x26696143 = {
+	.name		= "energy",
 	.guid		= 0x26696143,
 	.mmio_size	= XML_MMIO_SIZE(576, 2, 3),
 	.num_events	= 2,
@@ -96,6 +99,7 @@ static struct event_group energy_0x26696143 = {
  * File: xml/CWF/OOBMSM/RMID-PERF/cwf_aggregator.xml
  */
 static struct event_group perf_0x26557651 = {
+	.name		= "perf",
 	.guid		= 0x26557651,
 	.mmio_size	= XML_MMIO_SIZE(576, 7, 3),
 	.num_events	= 7,
@@ -167,6 +171,9 @@ static int discover_events(struct event_group *e, struct pmt_feature_group *p)
 	struct pkg_mmio_info *mmi;
 	int num_pkgs;
 
+	if (!rdt_is_feature_enabled(e->name))
+		return -EINVAL;
+
 	num_pkgs = topology_max_packages();
 
 	/* Get per-package counts of telemetry regions for this event group */
-- 
2.50.0


