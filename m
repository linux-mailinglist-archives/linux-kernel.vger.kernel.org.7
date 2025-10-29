Return-Path: <linux-kernel+bounces-876695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE829C1C77A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A14DD6E19A7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2633431F6;
	Wed, 29 Oct 2025 16:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GhX/j+oL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D22833F8AD
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 16:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761754891; cv=none; b=DpjxD9wKsHWXYJj7y/VV2/0ETEechRdg1N4OaPlVAWEC5XNnj8dS6LCxdbdzw11HGqWTGJ/RJfRJEAP+3mrhg9uuxOW6b7FGaLac1oXciife/X/Pu2Xnlph+/5ErUAr5Gr3gBivaxwhUh+t/PC1Y3H+W1rgarfm/3tshHrDILXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761754891; c=relaxed/simple;
	bh=S9HaWzcxXMFw0jHafQiONR5gJD/44wXod7b+Cn3Qfb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IgoTrZKIR4eMeHrNy2R1LA0vG83P+VgC6hQvpOJCufGS05gzB87wAdfmOH9UIrV/vaM6Fk1Ez/kr1unRpKZ9f7tJ3xTCPU0kDV9R00hDS8dXbp+4mVlSaiVpKvxaWBSk1GlUjJQBLcBH1mGjbKYidUwTEAJB/DrLlIJKYoywodo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GhX/j+oL; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761754889; x=1793290889;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S9HaWzcxXMFw0jHafQiONR5gJD/44wXod7b+Cn3Qfb0=;
  b=GhX/j+oLDPfijvgz5FK90Y3cSFmJyR1UVMa/NKcr72Xz7PWAmP+kxOlS
   15hmdQphvUGy0L+zoWQ1Vl4DHmvzzSREy6fTqZXjVgw7QJerozt4VVIOP
   +1FkM+gZTijHTmuB3UcJiW+pqV6KP6/aujLYL9q5EFPLRGGykJIKckjlf
   hTbyBaYY1+hpYQFqws6RYr4Mue6ZIETzMOJyx38W28T3iF9XfNhVFy6pb
   C9bpxCLDhdU4/yKzJaHb1fCh/4LPEljGG5OUOQS/XISvJ/wnqWdmxXCrC
   exwrVOEyM8ZuR0V3ZVaDttOIttchOK/u2KpVygamqdbl6XXNVl9ZaHPQ+
   Q==;
X-CSE-ConnectionGUID: klscOWrpR8eBk/UacAXc8g==
X-CSE-MsgGUID: AOtszki2TFOnANiwRQiVJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="75331000"
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="75331000"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 09:21:26 -0700
X-CSE-ConnectionGUID: 6J4fzmZLQzK0wzSOahtzRA==
X-CSE-MsgGUID: bEORkgDFSamnQ59yZ1nUkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="184901314"
Received: from mgerlach-mobl1.amr.corp.intel.com (HELO agluck-desk3.home.arpa) ([10.124.223.146])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 09:21:26 -0700
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
Subject: [PATCH v13 06/32] fs/resctrl: Split L3 dependent parts out of __mon_event_count()
Date: Wed, 29 Oct 2025 09:20:49 -0700
Message-ID: <20251029162118.40604-7-tony.luck@intel.com>
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

Carve out the L3 resource specific event reading code into a separate
helper to support reading event data from a new monitoring resource.

Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 fs/resctrl/monitor.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index 572a9925bd6c..179962a81362 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -413,7 +413,7 @@ static void mbm_cntr_free(struct rdt_mon_domain *d, int cntr_id)
 	memset(&d->cntr_cfg[cntr_id], 0, sizeof(*d->cntr_cfg));
 }
 
-static int __mon_event_count(struct rdtgroup *rdtgrp, struct rmid_read *rr)
+static int __l3_mon_event_count(struct rdtgroup *rdtgrp, struct rmid_read *rr)
 {
 	int cpu = smp_processor_id();
 	u32 closid = rdtgrp->closid;
@@ -494,6 +494,18 @@ static int __mon_event_count(struct rdtgroup *rdtgrp, struct rmid_read *rr)
 	return ret;
 }
 
+static int __mon_event_count(struct rdtgroup *rdtgrp, struct rmid_read *rr)
+{
+	switch (rr->r->rid) {
+	case RDT_RESOURCE_L3:
+		return __l3_mon_event_count(rdtgrp, rr);
+
+	default:
+		rr->err = -EINVAL;
+		return -EINVAL;
+	}
+}
+
 /*
  * mbm_bw_count() - Update bw count from values previously read by
  *		    __mon_event_count().
-- 
2.51.0


