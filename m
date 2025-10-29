Return-Path: <linux-kernel+bounces-876705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B99C1C11A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27E74189BF81
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F48354ACB;
	Wed, 29 Oct 2025 16:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FS8fqEp1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCC5350A2F
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 16:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761754899; cv=none; b=JLsgRCBiaXtKT8h6ZZ3P34RXVLgeycJ84DBqAcQ0PVgYJGOkg2otPTMk4YEIJBRxlUnYZoqT50DEJz4xn1Gnx8y4wwFD9kCRH6kGv5ToSzKb2zSc52VqZy5Ws6+JG1G7+uXyaueZB8+WZzu5eeoRvb6cwgP05WgwucC/Z5g/zUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761754899; c=relaxed/simple;
	bh=qUv+3py18EutDM4Fk4emsZD6QoK2hmxOkiwYzdDC7/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tmcGCf0iuC8EyrstwR2BVDk6cYo1Hv2UHolYDHfN9CwosbQRPh0+KeO6jNGP9R1KdTmoxoyPfV0VarkJW8x1kttL3EMo09fU7GYMyxyDct6CYXvLD72BoKPJZcUN5GQ60ZjzUh5MpkEsDeoqzq8kOGm63AOKHM2I6tH1EqkGJn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FS8fqEp1; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761754897; x=1793290897;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qUv+3py18EutDM4Fk4emsZD6QoK2hmxOkiwYzdDC7/U=;
  b=FS8fqEp1BHB+/swEhyYx0V16TQV/xCTWijB3TZQModz6ZH9XIsS5id0r
   eHGxTMuAuhMDUEScZa44/N1UWHyRm6vlnIDQ63fR3IDilFTHziJ7jSxqL
   vptS9Te8wRlwiTGoK5FAuMSsWT1XqJwestXnsNEwDbS4HiWOWadLyTzAw
   +Ty18yTN+aX3gC3ODWaAu9aMk1GpaWHaBbVuo5iTNyTxe2gDQoGflrzNk
   Zi1tGElliP+XkdijeZenXylaP2CM5piCXH4hXdzh8JMo+I+d+R9CJovtb
   WRV//hlsFjdVIqkBfRvcUxiqBA6I7WQYOM4ZRk20G89MOEp5czojeVULK
   g==;
X-CSE-ConnectionGUID: +U2GwRxFQ3q6xo1/YGq7rw==
X-CSE-MsgGUID: UQ42IsP9R6SN1qXEH35w0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="75331019"
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="75331019"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 09:21:30 -0700
X-CSE-ConnectionGUID: G3Vz45NdTHyZL0qfURY8Gg==
X-CSE-MsgGUID: OYhtcUwZQhWT3lEJWlJ7zQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="184901362"
Received: from mgerlach-mobl1.amr.corp.intel.com (HELO agluck-desk3.home.arpa) ([10.124.223.146])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 09:21:30 -0700
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
Subject: [PATCH v13 15/32] fs/resctrl: Cleanup as L3 is no longer the only monitor resource
Date: Wed, 29 Oct 2025 09:20:58 -0700
Message-ID: <20251029162118.40604-16-tony.luck@intel.com>
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

The feature to sum event data across multiple domains supports systems
with Sub-NUMA Cluster (SNC) mode enabled. The top-level monitoring files
in each "mon_L3_XX" directory provide the sum of data across all SNC
nodes sharing an L3 cache instance while the "mon_sub_L3_YY" sub-directories
provide the event data of the individual nodes.

SNC is only associated with the L3 resource and domains and as a result
the flow handling the sum of event data implicitly assumes it is
working with the L3 resource and domains.

Reading of telemetry events do not require to sum event data so this
feature can remain dedicated to SNC and keep the implicit assumption
of working with the L3 resource and domains.

Add a WARN to where the implicit assumption of working with the L3 resource
is made and add comments on how the structure controlling the event sum
feature is used.

Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 fs/resctrl/internal.h    | 4 ++--
 fs/resctrl/ctrlmondata.c | 8 +++++++-
 fs/resctrl/rdtgroup.c    | 3 ++-
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index 96d97f4ff957..39bdaf45fa2a 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -92,8 +92,8 @@ extern struct mon_evt mon_event_all[QOS_NUM_EVENTS];
  * @list:            Member of the global @mon_data_kn_priv_list list.
  * @rid:             Resource id associated with the event file.
  * @evt:             Event structure associated with the event file.
- * @sum:             Set when event must be summed across multiple
- *                   domains.
+ * @sum:             Set for RDT_RESOURCE_L3 when event must be summed
+ *                   across multiple domains.
  * @domid:           When @sum is zero this is the domain to which
  *                   the event file belongs. When @sum is one this
  *                   is the id of the L3 cache that all domains to be
diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
index 290a959776de..f7fbfc4d258d 100644
--- a/fs/resctrl/ctrlmondata.c
+++ b/fs/resctrl/ctrlmondata.c
@@ -683,7 +683,6 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 {
 	struct kernfs_open_file *of = m->private;
 	enum resctrl_res_level resid;
-	struct rdt_l3_mon_domain *d;
 	struct rdt_domain_hdr *hdr;
 	struct rmid_read rr = {0};
 	struct rdtgroup *rdtgrp;
@@ -711,6 +710,13 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 	r = resctrl_arch_get_resource(resid);
 
 	if (md->sum) {
+		struct rdt_l3_mon_domain *d;
+
+		if (WARN_ON_ONCE(resid != RDT_RESOURCE_L3)) {
+			ret = -EINVAL;
+			goto out;
+		}
+
 		/*
 		 * This file requires summing across all domains that share
 		 * the L3 cache id that was provided in the "domid" field of the
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 26f0d1f93da2..fa1398787e83 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -3030,7 +3030,8 @@ static void rmdir_all_sub(void)
  * @rid:    The resource id for the event file being created.
  * @domid:  The domain id for the event file being created.
  * @mevt:   The type of event file being created.
- * @do_sum: Whether SNC summing monitors are being created.
+ * @do_sum: Whether SNC summing monitors are being created. Only set
+ *	    when @rid == RDT_RESOURCE_L3.
  */
 static struct mon_data *mon_get_kn_priv(enum resctrl_res_level rid, int domid,
 					struct mon_evt *mevt,
-- 
2.51.0


