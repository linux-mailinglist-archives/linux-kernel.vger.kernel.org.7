Return-Path: <linux-kernel+bounces-763390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D2BB21415
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 20:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53D481907A14
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 18:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23B02E541D;
	Mon, 11 Aug 2025 18:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ypuhw+x/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C79F2E3394
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 18:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754936266; cv=none; b=ltf1Cy9f7Jq5L8O9yVyRCmlQ1NllQvRw5VklWXRxMO6j7AR27E2cH+CoZjqVu6Thzb3dEIOm7ra3hQ0tEWrBTgbsm7uXocvH4gWCl67aTNWRnUItYzdIwrQFkeo8JBPhW88kZuoGC6vrfaRxu2fn03XTg6Tj0QfYGIY5zdfxkrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754936266; c=relaxed/simple;
	bh=vPpRkpA1kWmXaq2JdSwo7aDBLrJCy4yxm2yZynCIedU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=INpArtrXRildj6gDI8IfK1c65Sy5EwL5cM+agRa1WOevRKNKM6yf9uw3JMAs4VCqi0PAdMuToDUb1EQVNofx1/wBodnQ4TPcrVXarnYpQCh187UhoOsCLDAu1OlWn+dwVkaLgxk/h5z6GX+7Wg+qnUhATj/BH4vMEqXUaYIExmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ypuhw+x/; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754936265; x=1786472265;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vPpRkpA1kWmXaq2JdSwo7aDBLrJCy4yxm2yZynCIedU=;
  b=Ypuhw+x/eUD5y2MZuIN6q/fMvF3IXtGQ4KRON+vnqTRZi6FdjDIlBKJo
   b5scKLB2xfWLBbDPPOvc8f7G4EOFEXu8u3Z8jDdG0HNdpV9ukINgOraFs
   Ri1FRGzNoYaORL+79wC6M/5FUSbdTea12i14sagUrkpA8/IIU82lUaMtF
   gpC33MHHt8qzGBhhD6YMDDuSNMGabDJFyotRs2+WIe5OzMUrCcUyv/Dxx
   G6q6d4Ox8E9F7cG3jHgKfJs/OKW5CVA0seNbiwonqk45HKHAe/8y+aYEC
   +ZPdvpvbSPGtN5dWHvCGj4M5XfDDFNBxp7XmV6p9gOyQK6O3aA97Cw1QG
   A==;
X-CSE-ConnectionGUID: cuQH2q9bS6u102C2gt9AKw==
X-CSE-MsgGUID: ss/fp2RKS56irIkRa73P4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="68277448"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="68277448"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 11:17:27 -0700
X-CSE-ConnectionGUID: nNl86vasQSiq0P/dhuCtvg==
X-CSE-MsgGUID: SA0v9RB2Tm6i41lEr3y7Tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="196825672"
Received: from puneetse-mobl.amr.corp.intel.com (HELO agluck-desk3.home.arpa) ([10.124.221.229])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 11:17:25 -0700
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
Subject: [PATCH v8 18/32] x86/resctrl: Count valid telemetry aggregators per package
Date: Mon, 11 Aug 2025 11:16:52 -0700
Message-ID: <20250811181709.6241-19-tony.luck@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250811181709.6241-1-tony.luck@intel.com>
References: <20250811181709.6241-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There may be multiple telemetry aggregators per package, each enumerated
by a telemetry region structure in the feature group.

Linux can only use telemetry regions when all of the following
conditions are met:
1) The "guid" of the region is known to Linux
2) The package id for the region is valid (less than
   topology_max_packages())
3) The size of the MMIO region exactly matches the expected
   size for this "guid" (as implied from description in the
   XML file for this "guid").

Scan the array of telemetry region structures and count how many are
usable in each package in preparation to allocate structures to save
the MMIO addresses for each in a convenient format for use when reading
event counters.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/resctrl/intel_aet.c | 56 ++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/intel_aet.c b/arch/x86/kernel/cpu/resctrl/intel_aet.c
index 25075f369148..09043d36e08c 100644
--- a/arch/x86/kernel/cpu/resctrl/intel_aet.c
+++ b/arch/x86/kernel/cpu/resctrl/intel_aet.c
@@ -15,6 +15,7 @@
 #include <linux/cpu.h>
 #include <linux/intel_vsec.h>
 #include <linux/resctrl.h>
+#include <linux/slab.h>
 
 #include "internal.h"
 
@@ -24,6 +25,7 @@
  *			within the OOBMSM driver that contains data for all
  *			telemetry regions.
  * @guid:		Unique number per XML description file.
+ * @mmio_size:		Number of bytes of MMIO registers for this group.
  */
 struct event_group {
 	/* Data fields for additional structures to manage this group. */
@@ -31,14 +33,19 @@ struct event_group {
 
 	/* Remaining fields initialized from XML file. */
 	u32				guid;
+	size_t				mmio_size;
 };
 
+#define XML_MMIO_SIZE(num_rmids, num_events, num_extra_status) \
+		      (((num_rmids) * (num_events) + (num_extra_status)) * sizeof(u64))
+
 /*
  * Link: https://github.com/intel/Intel-PMT
  * File: xml/CWF/OOBMSM/RMID-ENERGY/cwf_aggregator.xml
  */
 static struct event_group energy_0x26696143 = {
 	.guid		= 0x26696143,
+	.mmio_size	= XML_MMIO_SIZE(576, 2, 3),
 };
 
 /*
@@ -47,6 +54,7 @@ static struct event_group energy_0x26696143 = {
  */
 static struct event_group perf_0x26557651 = {
 	.guid		= 0x26557651,
+	.mmio_size	= XML_MMIO_SIZE(576, 7, 3),
 };
 
 static struct event_group *known_energy_event_groups[] = {
@@ -57,10 +65,54 @@ static struct event_group *known_perf_event_groups[] = {
 	&perf_0x26557651,
 };
 
-/* Stub for now */
+static bool skip_this_region(struct telemetry_region *tr, struct event_group *e)
+{
+	if (tr->guid != e->guid)
+		return true;
+	if (tr->plat_info.package_id >= topology_max_packages()) {
+		pr_warn_once("Bad package %d in guid 0x%x\n", tr->plat_info.package_id,
+			     tr->guid);
+		return true;
+	}
+	if (tr->size != e->mmio_size) {
+		pr_warn_once("MMIO space %zu wrong size for guid 0x%x\n", tr->size, e->guid);
+		return true;
+	}
+
+	return false;
+}
+
+/*
+ * Discover events from one pmt_feature_group.
+ * 1) Count how many usable telemetry regions per package.
+ * 2...) To be continued.
+ */
 static int discover_events(struct event_group *e, struct pmt_feature_group *p)
 {
-	return -EINVAL;
+	int *pkgcounts __free(kfree) = NULL;
+	struct telemetry_region *tr;
+	int num_pkgs;
+
+	num_pkgs = topology_max_packages();
+
+	/* Get per-package counts of telemetry regions for this event group */
+	for (int i = 0; i < p->count; i++) {
+		tr = &p->regions[i];
+		if (skip_this_region(tr, e))
+			continue;
+
+		if (!pkgcounts) {
+			pkgcounts = kcalloc(num_pkgs, sizeof(*pkgcounts), GFP_KERNEL);
+			if (!pkgcounts)
+				return -ENOMEM;
+		}
+		pkgcounts[tr->plat_info.package_id]++;
+	}
+
+	if (!pkgcounts)
+		return -ENODEV;
+
+	return 0;
 }
 
 DEFINE_FREE(intel_pmt_put_feature_group, struct pmt_feature_group *,
-- 
2.50.1


