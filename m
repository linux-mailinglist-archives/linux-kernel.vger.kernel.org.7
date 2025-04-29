Return-Path: <linux-kernel+bounces-624078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDFDCA9FE67
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 02:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C340F7A6CD5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 00:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1648B2192F2;
	Tue, 29 Apr 2025 00:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LchUxxS2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EE5215791
	for <linux-kernel@vger.kernel.org>; Tue, 29 Apr 2025 00:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745886872; cv=none; b=nxYOQoqBVXT32JPMqZKyDrLUi4d0Rb+N8xquJopFhTrtEi+tQz05pCJs6hQis+2EKaDE44OHmP3vjD0wZ6/2xhEMAq4Lv4enTpzUPYWqIysFWLitNhyXh+vokmMB6kxfMBqte8ev4hbENMVvwQsQfW9C/jcXIGzuDp54VdltExQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745886872; c=relaxed/simple;
	bh=kOMp9z1scfUT1uqprTrt2iskyhryhvGGEZykm2shN0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o+khZZkUTmSEFI/I9LYjAyrohXBw1q9bqzq7RXWzfHqw0uvgcWl++W4zliNbqHNQKzzGq1QqIUHjrz4nUYReOWvXRP1wcA7Y28FLcI3lR8f9QYslvix/9Vd9FFmc5X+SsA4UGDurRbwLPbA4yFz/16w7x4YRXw9G/SvJNUXLgFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LchUxxS2; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745886870; x=1777422870;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kOMp9z1scfUT1uqprTrt2iskyhryhvGGEZykm2shN0g=;
  b=LchUxxS2j9tRwaOp3/trpkVFuke+rQrRRoVCo6mFQt3z5gSS5D9dhZKz
   XXzvPorEbdpToCrEltnUVOhX8eOoHNwgqeA+ldfUaId5Bj2ZYEf6pdmdf
   xa7zbwWwNwbrGMURzcGrVNBjtkZPLCFWoJFMVvWMzs24c+5+figgYd+XV
   bIemcgH7RmtxzU3yDYVPSgE5TUvrz55WF2eWBGezpcQE9nRHEDR66X3si
   DprvSd5TmRN+mpvYBROTx1Poe9Q9U1xepS4F3UqcCoPCyRKkK6TPZPLvO
   xX/V78Wpu70nIeyImmGf8L2l6w8mTPOptj7K81vOEM+FojmtPF28KWBwz
   w==;
X-CSE-ConnectionGUID: CcJqwPT0R4Ky/0kF2BNpVQ==
X-CSE-MsgGUID: pDDmBCoLTnqmRz6yg3o2yw==
X-IronPort-AV: E=McAfee;i="6700,10204,11417"; a="58148289"
X-IronPort-AV: E=Sophos;i="6.15,247,1739865600"; 
   d="scan'208";a="58148289"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 17:34:23 -0700
X-CSE-ConnectionGUID: +SwzuqKUSzqHyiQw2izBYw==
X-CSE-MsgGUID: W9zYiQgXQ4umUZVchGkaXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,247,1739865600"; 
   d="scan'208";a="133394073"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 17:34:22 -0700
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
Subject: [PATCH v4 26/31] x86/resctrl: Add energy/perf choices to rdt boot option
Date: Mon, 28 Apr 2025 17:33:52 -0700
Message-ID: <20250429003359.375508-27-tony.luck@intel.com>
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

Users may want to force either of the telemetry features on
(in the case where they are disabled due to erratum) or off
(in the case that a limited number of RMIDs for a telemetry
feature reduces the number of monitor groups that can be
created.)

Unlike other options that are tied to X86_FEATURE_* flags,
these must be queried by name. Add a function to do that.

Add checks for users who forced either feature off.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 .../admin-guide/kernel-parameters.txt         |  2 +-
 arch/x86/kernel/cpu/resctrl/internal.h        |  2 ++
 arch/x86/kernel/cpu/resctrl/core.c            | 19 +++++++++++++++++++
 arch/x86/kernel/cpu/resctrl/intel_aet.c       |  6 ++++++
 4 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index d9fd26b95b34..4811bc812f0f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5988,7 +5988,7 @@
 	rdt=		[HW,X86,RDT]
 			Turn on/off individual RDT features. List is:
 			cmt, mbmtotal, mbmlocal, l3cat, l3cdp, l2cat, l2cdp,
-			mba, smba, bmec.
+			mba, smba, bmec, energy, perf.
 			E.g. to turn on cmt and turn off mba use:
 				rdt=cmt,!mba
 
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index dd5fe8a98304..92cbba9d82a8 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -167,6 +167,8 @@ void __init intel_rdt_mbm_apply_quirk(void);
 
 void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
 
+bool rdt_check_option(char *name, bool is_on, bool is_off);
+
 #ifdef CONFIG_INTEL_AET_RESCTRL
 bool intel_aet_get_events(void);
 void __exit intel_aet_exit(void);
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 9fa4cc66faf4..dc312e24ab87 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -795,6 +795,8 @@ enum {
 	RDT_FLAG_MBA,
 	RDT_FLAG_SMBA,
 	RDT_FLAG_BMEC,
+	RDT_FLAG_ENERGY,
+	RDT_FLAG_PERF,
 };
 
 #define RDT_OPT(idx, n, f)	\
@@ -820,6 +822,8 @@ static struct rdt_options rdt_options[]  __ro_after_init = {
 	RDT_OPT(RDT_FLAG_MBA,	    "mba",	X86_FEATURE_MBA),
 	RDT_OPT(RDT_FLAG_SMBA,	    "smba",	X86_FEATURE_SMBA),
 	RDT_OPT(RDT_FLAG_BMEC,	    "bmec",	X86_FEATURE_BMEC),
+	RDT_OPT(RDT_FLAG_ENERGY,    "energy",	0),
+	RDT_OPT(RDT_FLAG_PERF,	    "perf",	0),
 };
 #define NUM_RDT_OPTIONS ARRAY_SIZE(rdt_options)
 
@@ -869,6 +873,21 @@ bool rdt_cpu_has(int flag)
 	return ret;
 }
 
+/* Check if a named option has been forced on, or forced off */
+bool rdt_check_option(char *name, bool is_on, bool is_off)
+{
+	struct rdt_options *o;
+
+	WARN_ON(!(is_on ^ is_off));
+
+	for (o = rdt_options; o < &rdt_options[NUM_RDT_OPTIONS]; o++) {
+		if (!strcmp(name, o->name))
+			return (is_on && o->force_on) || (is_off && o->force_off);
+	}
+
+	return false;
+}
+
 bool resctrl_arch_is_evt_configurable(enum resctrl_event_id evt)
 {
 	if (!rdt_cpu_has(X86_FEATURE_BMEC))
diff --git a/arch/x86/kernel/cpu/resctrl/intel_aet.c b/arch/x86/kernel/cpu/resctrl/intel_aet.c
index 0bbf991da981..aacaedcc7b74 100644
--- a/arch/x86/kernel/cpu/resctrl/intel_aet.c
+++ b/arch/x86/kernel/cpu/resctrl/intel_aet.c
@@ -49,6 +49,7 @@ struct pmt_event {
  *                      gleaned from the XML files. Others are set from data
  *                      retrieved from intel_pmt_get_regions_by_feature().
  * @pfg:		The pmt_feature_group for this event group
+ * @name:		Name for this group
  * @guid:		Unique number per XML description file
  * @mmio_size:		Number of bytes of mmio registers for this group
  * @pkginfo:		Per-package MMIO addresses
@@ -57,6 +58,7 @@ struct pmt_event {
  */
 struct event_group {
 	struct pmt_feature_group	*pfg;
+	char				*name;
 	int				guid;
 	int				mmio_size;
 	struct mmio_info		**pkginfo;
@@ -66,6 +68,7 @@ struct event_group {
 
 /* Link: https://github.com/intel/Intel-PMT xml/CWF/OOBMSM/RMID-ENERGY *.xml */
 static struct event_group energy_0x26696143 = {
+	.name		= "energy",
 	.guid		= 0x26696143,
 	.mmio_size	= (576 * 2 + 3) * 8,
 	.num_events	= 2,
@@ -77,6 +80,7 @@ static struct event_group energy_0x26696143 = {
 
 /* Link: https://github.com/intel/Intel-PMT xml/CWF/OOBMSM/RMID-PERF *.xml */
 static struct event_group perf_0x26557651 = {
+	.name		= "perf",
 	.guid		= 0x26557651,
 	.mmio_size	= (576 * 7 + 3) * 8,
 	.num_events	= 7,
@@ -208,6 +212,8 @@ static bool get_pmt_feature(enum pmt_feature_id feature)
 	for (peg = &known_event_groups[0]; peg < &known_event_groups[NUM_KNOWN_GROUPS]; peg++) {
 		for (int i = 0; i < p->count; i++) {
 			if ((*peg)->guid == p->regions[i].guid) {
+				if (rdt_check_option((*peg)->name, false, true))
+					return false;
 				ret = configure_events((*peg), p);
 				if (ret) {
 					(*peg)->pfg = no_free_ptr(p);
-- 
2.48.1


