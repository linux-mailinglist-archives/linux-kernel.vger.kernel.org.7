Return-Path: <linux-kernel+bounces-592774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E03DA7F138
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 01:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 780523B56A6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Apr 2025 23:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC5323DEAD;
	Mon,  7 Apr 2025 23:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X5hHBKy9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6209235BF5
	for <linux-kernel@vger.kernel.org>; Mon,  7 Apr 2025 23:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744069261; cv=none; b=EhgtBbB3uruwNm+JBjEJZ5JN9D3uIXmJKEZvPslXTurHxXUPSlK/Qhv1Awhz0IA83BU22uGxyvZq4Zp2RqE0Nql6OamZYbc0k6+lNyqJoKpfCTviEnanZFJZ1DNXZjAnb7lI62wl/kmtKrcTjkdXPy+4kCtFGA+jxKeCjTKe69Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744069261; c=relaxed/simple;
	bh=SUUftBtwxxFxmK3JdMowGHqFvP3+5TntU1UsnXpOCUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IwjJpf97POI+BieXZQNf3GfMJr4q5h2VbZxnEYUToUXDe41rF36EYyIduRvs6q6IERs/B3Q2QcItTUjfzZ4Mo2nMmHQm/BEzp/SyAzYW2ecsE9xZxyRu+JCMpArAOVW95ClDfHBinLI7HaUtqJBe6cxMDk5ZWkMptAx90PxakNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X5hHBKy9; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744069260; x=1775605260;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SUUftBtwxxFxmK3JdMowGHqFvP3+5TntU1UsnXpOCUo=;
  b=X5hHBKy9cFj5SzYI/zgDYBLtYKpLMf2SOXBu6a/zwaFBrpKoZwWRcMOd
   N9VNLSn1Sqo/R21hFO5Q8jujhjd3e18iUESrCjwsLfJ5OfgNGp6jndkdH
   FKnl93X3OhO+FRBKjzUULg5LqMUJOU/59hebY+8IJrXBAXu2G8KbY5gy0
   +nrZPrWD+df4n2wTrBi1W6PRsE2amMERkNFjfregQ/NSRSusCLUkm/Anl
   HuQfDNSrkbSWSd+I3xN38Sqmq8NE008M9PelONUYLZnVDthPE60zZQb/t
   93nVAejHTn0ajiU87likYD9BhQV10q4R1JVJ4Wsl7f+t8vTOLxnVZH4/e
   Q==;
X-CSE-ConnectionGUID: 087ivOFkQ72a1Mw0b3wqlQ==
X-CSE-MsgGUID: kp/TaWobSr+oYfR/qmljbg==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="48193256"
X-IronPort-AV: E=Sophos;i="6.15,196,1739865600"; 
   d="scan'208";a="48193256"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 16:40:55 -0700
X-CSE-ConnectionGUID: cIex8e2YSSOvFi0TNWr+Qw==
X-CSE-MsgGUID: hl+xutEBTeKnnTNrOykWZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,196,1739865600"; 
   d="scan'208";a="165315508"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 16:40:54 -0700
From: Tony Luck <tony.luck@intel.com>
To: Fenghua Yu <fenghuay@nvidia.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Peter Newman <peternewman@google.com>,
	James Morse <james.morse@arm.com>,
	Babu Moger <babu.moger@amd.com>,
	Drew Fustini <dfustini@baylibre.com>,
	Dave Martin <Dave.Martin@arm.com>,
	Anil Keshavamurthy <anil.s.keshavamurthy@intel.com>
Cc: linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v3 19/26] x86/resctrl: Sanity check telemetry RMID values
Date: Mon,  7 Apr 2025 16:40:21 -0700
Message-ID: <20250407234032.241215-20-tony.luck@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250407234032.241215-1-tony.luck@intel.com>
References: <20250407234032.241215-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are three values of interest:
1) The number of RMIDs supported by the CPU core. This is enumerated by
   CPUID leaf 0xF. Linux saves the value in boot_cpu_data.x86_cache_max_rmid.
2) The number of counter registers in each telemetry region. This is
   described in the XML file for the region. Linux hard codes it into
   the struct telem_entry..num_rmids field.
3) The maximum number of RMIDs that can be tracked simultaneously for
   a telemetry region. This is provided in the structures received from
   the intel_pmt_get_regions_by_feature() calls.

Print appropriate warnings if these values do not match.

TODO: Need a better UI. The number of implemented counters can be
different per telemetry region.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/resctrl/intel_aet.c | 31 +++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/intel_aet.c b/arch/x86/kernel/cpu/resctrl/intel_aet.c
index 67a1245858dc..0bcbac326bee 100644
--- a/arch/x86/kernel/cpu/resctrl/intel_aet.c
+++ b/arch/x86/kernel/cpu/resctrl/intel_aet.c
@@ -13,6 +13,7 @@
 
 #include <linux/cpu.h>
 #include <linux/cleanup.h>
+#include <linux/minmax.h>
 #include "fake_intel_aet_features.h"
 #include <linux/intel_vsec.h>
 #include <linux/resctrl.h>
@@ -51,6 +52,7 @@ struct pmt_event {
  * @last_overflow_tstamp_off:	Offset of overflow timestamp
  * @last_update_tstamp_off:	Offset of last update timestamp
  * @active:			Marks this group as active on this system
+ * @rmid_warned:		Set to stop multiple rmid sanity warnings
  * @num_events:			Size of @evts array
  * @evts:			Telemetry events in this group
  */
@@ -63,6 +65,7 @@ struct telem_entry {
 	int	last_overflow_tstamp_off;
 	int	last_update_tstamp_off;
 	bool	active;
+	bool	rmid_warned;
 	int	num_events;
 	struct pmt_event evts[];
 };
@@ -84,6 +87,33 @@ static struct telem_entry *telem_entry[] = {
 	NULL
 };
 
+static void rmid_sanity_check(struct telemetry_region *tr, struct telem_entry *tentry)
+{
+	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_PERF_PKG].r_resctrl;
+	int system_rmids = boot_cpu_data.x86_cache_max_rmid + 1;
+
+	if (tentry->rmid_warned)
+		return;
+
+	if (tentry->num_rmids != system_rmids) {
+		pr_info("Telemetry region %s has %d RMIDs system supports %d\n",
+			tentry->name, tentry->num_rmids, system_rmids);
+		tentry->rmid_warned = true;
+	}
+
+	if (tr->num_rmids < tentry->num_rmids) {
+		pr_info("Telemetry region %s only supports %d simultaneous RMIDS\n",
+			tentry->name, tr->num_rmids);
+		tentry->rmid_warned = true;
+	}
+
+	/* info/PKG_PERF_MON/num_rmids reports number of guaranteed counters */
+	if (!r->num_rmid)
+		r->num_rmid = tr->num_rmids;
+	else
+		r->num_rmid = min((u32)r->num_rmid, tr->num_rmids);
+}
+
 /*
  * Scan a feature group looking for guids recognized
  * and update the per-package counts of known groups.
@@ -109,6 +139,7 @@ static bool count_events(struct pkg_info *pkg, int max_pkgs, struct pmt_feature_
 					pr_warn_once("MMIO region for guid 0x%x too small\n", tr->guid);
 					continue;
 				}
+				rmid_sanity_check(tr, *tentry);
 				found = true;
 				(*tentry)->active = true;
 				pkg[tr->plat_info.package_id].count++;
-- 
2.48.1


