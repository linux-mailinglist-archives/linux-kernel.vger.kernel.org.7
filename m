Return-Path: <linux-kernel+bounces-792378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 072E6B3C329
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 21:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B674C17D09D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 19:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A018334574F;
	Fri, 29 Aug 2025 19:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KHzPLVR3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D012773EA
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 19:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756496051; cv=none; b=uU5vocTWF/iM+xbTNZWOe52ErxP1dpAc41z4ii5pjSctCe8yL1G5BSXsHJXRCZCihXqMSRZL9EJeKJPP5qBcUs8mnu7GIRnzLiN5APpF7P2KRik41XFZDsPV3f+oHIzujvXUCEUjnZJpef2m2IWJGj65VV6Kgij0+LXkS6VlMEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756496051; c=relaxed/simple;
	bh=u7nflaaK9SR00aq5mURnYleQnuPekikxAT275MC/cYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZdGuAwyLMrW0jEJ72J0+SeF1rYL2xDBk9xOXq7N8HDFXO0KUXFt5JygrFLq6kO5OXI5U48TaGy9YAIzpHqwRwlAGmAXpZVRk5MvTxx3AGmV01Ue+SK28dIHyOX8yi7h2UgbyU6M1otwlccS7YwHDULUWHXRjSxxU6HVr6TjuwOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KHzPLVR3; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756496048; x=1788032048;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u7nflaaK9SR00aq5mURnYleQnuPekikxAT275MC/cYs=;
  b=KHzPLVR3vzISIr9KqtzrtEatMGvoSKMg77G94T0SnzKZRhRlSjkUEXAz
   QyZ1Hdjv/SKkuWF0tvodKcn7pQRSgjpI/NObQnuWtLG+2yBRNkHHu7XLX
   MB86UsRjDW0vUX1Q2TZ1Xca2+yyoyrkWUzUCPibw5Hmr9wDn+ar2fwWLF
   PQD6QCEDO5UitXm4PwRMsJOEy8HUkCaEH4XDAlBPaNDeCYF/7HeH8yWjh
   O71lwczBbZI+Op6HdiH9vqBOE5iH/uRx7Ih6IuO36rr+kxcOQ0GgTlYja
   jXCYfC3+Y3Ne6VHNVHTjYoNnJO0qWEKDbEWWev/2byETTgp2mV1xc2U7K
   Q==;
X-CSE-ConnectionGUID: TKbdh6VERGqrgOOdoHboLg==
X-CSE-MsgGUID: RdL3LhsUQVW1agE+pDTE1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62625297"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62625297"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 12:33:55 -0700
X-CSE-ConnectionGUID: BUf3KgrISe2EmJldaqm7eA==
X-CSE-MsgGUID: LZwObDh6SNG+TZ0HODb4Ng==
X-ExtLoop1: 1
Received: from ldmartin-desk2.corp.intel.com (HELO agluck-desk3.intel.com) ([10.124.220.202])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 12:33:55 -0700
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
Subject: [PATCH v9 20/31] x86/resctrl: Find and enable usable telemetry events
Date: Fri, 29 Aug 2025 12:33:32 -0700
Message-ID: <20250829193346.31565-21-tony.luck@intel.com>
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

The INTEL_PMT driver provides telemetry region structures of the
types requested by resctrl.

Scan these structures to discover which pass sanity checks:

1) They have guid known to resctrl.
2) They have a valid package ID.
3) The enumerated size of the MMIO region matches the expected
   value from the XML description file.
4) At least one region passes the above checks.

Enable the active events in resctrl filesystem to make them available to
user space. Pass a pointer to the pmt_event structure of the event within
the struct event_group that resctrl stores in mon_evt::arch_priv. resctrl
passes this pointer back when asking to read the event data which enables
the data to be found in MMIO.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/resctrl/intel_aet.c | 36 +++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/intel_aet.c b/arch/x86/kernel/cpu/resctrl/intel_aet.c
index 565777841f5c..5c5466dc3189 100644
--- a/arch/x86/kernel/cpu/resctrl/intel_aet.c
+++ b/arch/x86/kernel/cpu/resctrl/intel_aet.c
@@ -102,12 +102,44 @@ static struct event_group *known_perf_event_groups[] = {
 	for (_peg = _grp; _peg < &_grp[ARRAY_SIZE(_grp)]; _peg++)	\
 		if ((*_peg)->pfg)
 
-/* Stub for now */
-static bool enable_events(struct event_group *e, struct pmt_feature_group *p)
+static bool skip_this_region(struct telemetry_region *tr, struct event_group *e)
 {
+	if (tr->guid != e->guid)
+		return true;
+	if (tr->plat_info.package_id >= topology_max_packages()) {
+		pr_warn_once("Bad package %d in guid 0x%x\n", tr->plat_info.package_id,
+			     tr->guid);
+		return true;
+	}
+	if (tr->size != e->mmio_size) {
+		pr_warn_once("MMIO space wrong size (%zu bytes) for guid 0x%x. Expected %zu bytes.\n",
+			     tr->size, e->guid, e->mmio_size);
+		return true;
+	}
+
 	return false;
 }
 
+static bool enable_events(struct event_group *e, struct pmt_feature_group *p)
+{
+	bool usable_events = false;
+
+	for (int i = 0; i < p->count; i++) {
+		if (skip_this_region(&p->regions[i], e))
+			continue;
+		usable_events = true;
+	}
+
+	if (!usable_events)
+		return false;
+
+	for (int j = 0; j < e->num_events; j++)
+		resctrl_enable_mon_event(e->evts[j].id, true,
+					 e->evts[j].bin_bits, &e->evts[j]);
+
+	return true;
+}
+
 DEFINE_FREE(intel_pmt_put_feature_group, struct pmt_feature_group *,
 		if (!IS_ERR_OR_NULL(_T))
 			intel_pmt_put_feature_group(_T))
-- 
2.50.1


