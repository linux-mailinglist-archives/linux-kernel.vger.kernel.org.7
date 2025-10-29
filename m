Return-Path: <linux-kernel+bounces-876709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F557C1C874
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B34C6940314
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B83355818;
	Wed, 29 Oct 2025 16:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GGLEaKiF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E26354714
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 16:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761754902; cv=none; b=DXx3igBPOniEzXPD/I2mLdBOBlXjhlBtZ7laKKV7pAxElny6D/YJ3EV5P2Rs/98+r4Ccc88S9fPCpWSMlm6jj07hZUWfUmtjipCzOpPTTZm394dzFl/nUIAw3F2YkkCtqygo0Adb70Ch9HkKuPsIiKwncX4mekz0yexxpyDkz7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761754902; c=relaxed/simple;
	bh=8waToVXIRH1+Who05gUQ619chnkbQ33UmlggM94nuh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pjWlqsncOqSi0VsVLeQQOmJy1k74z3RhvX7v2ZIkqSAhDhOEOP6+U/b9TZV6snEni1ej5kk8G3021wIKhhp0m81ERJdMTL2JKtfvZ6fx9jf9cZYfGsrOqByLgLv3nO11liI5y1JZUY1F+hb4+A2Z3PeRWoRBV5fcmwPpzwdC38E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GGLEaKiF; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761754900; x=1793290900;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8waToVXIRH1+Who05gUQ619chnkbQ33UmlggM94nuh4=;
  b=GGLEaKiF1rqxKxrhesMdl010CKLURPxdT0wkMB5JKjaw4ySHIn4SkWcR
   Y1YCxe558KmwCjUGX0EKvI98QNuXe5tcRvXi9TQy4TbxkJUYRARn9apgq
   871EkF90usE7wOfAqgR37vf5HUpdpG8GuP5GKP14fYUl1/Rr3DKR8HPSh
   uc+rb0UJy8Sj9CHstPbkbtFgBRVrS3LUKsvNZ4HTL62pErfn82g1c++1s
   st0VV40nT6PldXkD1IGoujTR2jPCHI5Bp9zTWaG0Bi2AvnMFF95nH+WTJ
   AZX2JZ9VaYn14Si+iGHC4d4uSSKCfuH8TKz1ptTNL2AdgBqmQ0wFoS0Is
   Q==;
X-CSE-ConnectionGUID: 0q7zpbC8RiSNOxbDo4mzMQ==
X-CSE-MsgGUID: 9KmVP8edQrK1FR+Emmgmig==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="75331025"
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="75331025"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 09:21:31 -0700
X-CSE-ConnectionGUID: 2LH8gmHFSj2x+5v29Jtqdw==
X-CSE-MsgGUID: A/nrCL40SqGmyfsz6o0LQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="184901376"
Received: from mgerlach-mobl1.amr.corp.intel.com (HELO agluck-desk3.home.arpa) ([10.124.223.146])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 09:21:31 -0700
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
Subject: [PATCH v13 19/32] x86/resctrl: Find and enable usable telemetry events
Date: Wed, 29 Oct 2025 09:21:02 -0700
Message-ID: <20251029162118.40604-20-tony.luck@intel.com>
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

resctrl requests a copy of struct pmt_feature_group from the INTEL_PMT_TELEMETRY
driver for each event_group known to resctrl.

Scan pmt_feature_group::regions[] and mark those that fail the following tests:

1) guid does not match the guid for the event_group.
2) Package ID is invalid.
3) The enumerated size of the MMIO region does not match the expected
   value from the XML description file.

If there are any regions that pass all of these checks enable each of the
telemetry events in event_group::evts[].

Note that it is architecturally possible that some telemetry events are only
supported by a subset of the packages in the system. It is not expected that
systems will ever do this. If they do the user will see event files in resctrl
that always return "Unavailable".

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/resctrl/intel_aet.c | 58 ++++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/intel_aet.c b/arch/x86/kernel/cpu/resctrl/intel_aet.c
index 5aec929c3441..e8da70eaa7c6 100644
--- a/arch/x86/kernel/cpu/resctrl/intel_aet.c
+++ b/arch/x86/kernel/cpu/resctrl/intel_aet.c
@@ -20,9 +20,11 @@
 #include <linux/intel_pmt_features.h>
 #include <linux/intel_vsec.h>
 #include <linux/overflow.h>
+#include <linux/printk.h>
 #include <linux/resctrl.h>
 #include <linux/resctrl_types.h>
 #include <linux/stddef.h>
+#include <linux/topology.h>
 #include <linux/types.h>
 
 #include "internal.h"
@@ -117,12 +119,64 @@ static struct event_group *known_event_groups[] = {
 	     _peg < &known_event_groups[ARRAY_SIZE(known_event_groups)];	\
 	     _peg++)
 
-/* Stub for now */
-static bool enable_events(struct event_group *e, struct pmt_feature_group *p)
+/*
+ * Clear the address field of regions that did not pass the checks in
+ * skip_telem_region() so they will not be used by intel_aet_read_event().
+ * This is safe to do because intel_pmt_get_regions_by_feature() allocates
+ * a new pmt_feature_group structure to return to each caller and only makes
+ * use of the pmt_feature_group::kref field when intel_pmt_put_feature_group()
+ * returns the structure.
+ */
+static void mark_telem_region_unusable(struct telemetry_region *tr)
+{
+	tr->addr = NULL;
+}
+
+static bool skip_telem_region(struct telemetry_region *tr, struct event_group *e)
 {
+	if (tr->guid != e->guid)
+		return true;
+	if (tr->plat_info.package_id >= topology_max_packages()) {
+		pr_warn("Bad package %u in guid 0x%x\n", tr->plat_info.package_id,
+			tr->guid);
+		return true;
+	}
+	if (tr->size != e->mmio_size) {
+		pr_warn("MMIO space wrong size (%zu bytes) for guid 0x%x. Expected %zu bytes.\n",
+			tr->size, e->guid, e->mmio_size);
+		return true;
+	}
+
 	return false;
 }
 
+static bool group_has_usable_regions(struct event_group *e, struct pmt_feature_group *p)
+{
+	bool usable_regions = false;
+
+	for (int i = 0; i < p->count; i++) {
+		if (skip_telem_region(&p->regions[i], e)) {
+			mark_telem_region_unusable(&p->regions[i]);
+			continue;
+		}
+		usable_regions = true;
+	}
+
+	return usable_regions;
+}
+
+static bool enable_events(struct event_group *e, struct pmt_feature_group *p)
+{
+	if (!group_has_usable_regions(e, p))
+		return false;
+
+	for (int j = 0; j < e->num_events; j++)
+		resctrl_enable_mon_event(e->evts[j].id, true,
+					 e->evts[j].bin_bits, &e->evts[j]);
+
+	return true;
+}
+
 /*
  * Make a request to the INTEL_PMT_TELEMETRY driver for a copy of the
  * pmt_feature_group for each known feature. If there is one, the returned
-- 
2.51.0


