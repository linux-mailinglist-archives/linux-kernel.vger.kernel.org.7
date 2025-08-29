Return-Path: <linux-kernel+bounces-792377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 023B3B3C32C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 21:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B95ABA66486
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 19:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2272B345726;
	Fri, 29 Aug 2025 19:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K8DqX8QG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650DB2E370C
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 19:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756496050; cv=none; b=iS1pAitDLHKcJLRR9/F4VXBB50SHVExnnlBxVW0z+VOkjcem31y2vUlTaxOY6gixUZiKvA93JaoeOWoPNEk4wcOpE3hQa2jPD3G0KOUiqBHls7/Q7n7Z4BM0aPAldbD8fn7Zyy5DYuxx1sC3/dbARWscXBeXNwOWyEkyNB951rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756496050; c=relaxed/simple;
	bh=Ge4YJzu+pwOLV1vhLbuHumdMcI5LaIReEZ/LYgZ2obM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kVOqh/6j9j2SkZQTH/f56ZqfUkbl9SNrEA00UEiOXad0rybvUd4mcercGah6/vyg0clz2q7dQYT2X7wEahQw/Dl7Bsdz6QXYRmilxTyhTbaDv1BTWmxH/deC2mThtaEzmkeihh1XUe94H+v0nTkwYEgvz240sWVs1YXppf12qWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K8DqX8QG; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756496048; x=1788032048;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ge4YJzu+pwOLV1vhLbuHumdMcI5LaIReEZ/LYgZ2obM=;
  b=K8DqX8QG6elxeFC7ILsFVy09j1uktbH4Y5TKdvTTgBq3upWzLy3I/ryn
   korxWS5uCQ0vn6nAmD841Q7+C3ce3k+2mEOVaItggqZ/hyASm8o2UEhIA
   G9wQ8hyuVnRjPQRJxqXXTCI1wDxZBG1FY9lcaqrsCdgLHwUg2Mx68Roi8
   4ObqP7Ouj97ZzE0Z+DssMIM02xF6KDdC5t9RHMi5CMZFtZ8HBpIgNb02c
   WZk+UqRgzcj7D8QiHocS+s+h/7gEoJcx4pulCF4DxJE3+qthg2M0nOgAh
   jps3tCFeWFRQrCo+xYJ6qJnpH9j4X3eXFw0rodv5/LgxUCl5lN8DibdXY
   A==;
X-CSE-ConnectionGUID: JFLJdZo0TSaKoXLRxjKD3w==
X-CSE-MsgGUID: excvykP+R2uEZOb99SVcQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62625326"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62625326"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 12:33:56 -0700
X-CSE-ConnectionGUID: Q3fCdlNqTYC6Jdkk8GfMLA==
X-CSE-MsgGUID: Z//9mFviTVOrTEqdx+8ohA==
X-ExtLoop1: 1
Received: from ldmartin-desk2.corp.intel.com (HELO agluck-desk3.intel.com) ([10.124.220.202])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 12:33:56 -0700
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
Subject: [PATCH v9 23/31] x86/resctrl: Add energy/perf choices to rdt boot option
Date: Fri, 29 Aug 2025 12:33:35 -0700
Message-ID: <20250829193346.31565-24-tony.luck@intel.com>
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

Legacy resctrl features are enumerated by X86_FEATURE_* flags. These
may be overridden by quirks to disable features in the case of errata.

Users can use kernel command line options to either disable a feature,
or to force enable a feature that was disabled by a quirk.

Provide similar functionality for hardware features that do not have an
X86_FEATURE_* flag.

Unlike other features that are tied to X86_FEATURE_* flags, these must
be queried by name. Add rdt_is_feature_enabled() to check whether quirks
or kernel command line have disabled a feature.

Users may force a feature to be disabled. E.g. "rdt=!perf" will ensure
that none of the perf telemetry events are enabled.

Resctrl architecture code may disable a feature that does not provide
full functionality. Users may override that decision.  E.g. "rdt=energy"
will enable any available energy telemetry events even if they do not
provide full functionality.

Signed-off-by: Tony Luck <tony.luck@intel.com>

starting # with '#' will be ignored, and an empty message
aborts the commit.  # # Date:	   Mon Aug 11 09:36:45 2025
-0700 # # On branch rdt-aet-v9-wip # Changes to be committed:
modified:   arch/x86/kernel/cpu/resctrl/core.c #       modified:
arch/x86/kernel/cpu/resctrl/internal.h # # Untracked files: #
20250811181709.6241-1-tony.luck@intel.com.mbx #       cscope-x86.out #
cscope-x86.out.in #	  cscope-x86.out.po #	    v8/ #
---
 .../admin-guide/kernel-parameters.txt         |  2 +-
 arch/x86/kernel/cpu/resctrl/internal.h        |  2 ++
 arch/x86/kernel/cpu/resctrl/core.c            | 30 +++++++++++++++++++
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 747a55abf494..b600e1b47b0c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6154,7 +6154,7 @@
 	rdt=		[HW,X86,RDT]
 			Turn on/off individual RDT features. List is:
 			cmt, mbmtotal, mbmlocal, l3cat, l3cdp, l2cat, l2cdp,
-			mba, smba, bmec.
+			mba, smba, bmec, energy, perf.
 			E.g. to turn on cmt and turn off mba use:
 				rdt=cmt,!mba
 
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index b054c7cd13f1..6948803721e4 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -177,6 +177,8 @@ void __init intel_rdt_mbm_apply_quirk(void);
 
 void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
 
+bool rdt_is_feature_enabled(char *name);
+
 #ifdef CONFIG_X86_CPU_RESCTRL_INTEL_AET
 bool intel_aet_get_events(void);
 void __exit intel_aet_exit(void);
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 5745c6979293..d6e7a9125a10 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -763,6 +763,8 @@ enum {
 	RDT_FLAG_MBA,
 	RDT_FLAG_SMBA,
 	RDT_FLAG_BMEC,
+	RDT_FLAG_ENERGY,
+	RDT_FLAG_PERF,
 };
 
 #define RDT_OPT(idx, n, f)	\
@@ -788,6 +790,8 @@ static struct rdt_options rdt_options[]  __ro_after_init = {
 	RDT_OPT(RDT_FLAG_MBA,	    "mba",	X86_FEATURE_MBA),
 	RDT_OPT(RDT_FLAG_SMBA,	    "smba",	X86_FEATURE_SMBA),
 	RDT_OPT(RDT_FLAG_BMEC,	    "bmec",	X86_FEATURE_BMEC),
+	RDT_OPT(RDT_FLAG_ENERGY,    "energy",	0),
+	RDT_OPT(RDT_FLAG_PERF,	    "perf",	0),
 };
 #define NUM_RDT_OPTIONS ARRAY_SIZE(rdt_options)
 
@@ -837,6 +841,32 @@ bool rdt_cpu_has(int flag)
 	return ret;
 }
 
+/*
+ * Hardware features that do not have X86_FEATURE_* bits.
+ * There is no "hardware does not support this at all" case.
+ * Assume that the caller has already determined that hardware
+ * support is present and just needs to check if the feature has been
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
-- 
2.50.1


