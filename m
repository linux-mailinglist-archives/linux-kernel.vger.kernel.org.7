Return-Path: <linux-kernel+bounces-592766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6E0A7F12B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 01:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 253B83B3DE2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Apr 2025 23:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CA822A1ED;
	Mon,  7 Apr 2025 23:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ja69zNJt"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB85122D4C6
	for <linux-kernel@vger.kernel.org>; Mon,  7 Apr 2025 23:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744069255; cv=none; b=Qdh37UKXgQzg+4RT4ySQelIJY4xvq7hFKMiddrWd+em3RURnX95/icmY7lwtUIRtUTVB+I0/7Nn2vYdm0K17TI868rK+mml7GqvlYJOne2hD0HpyAgaWXLzijdMX2qhGBmA93WMIENliWyKBGZ8+6KAFek8c8MiwYUlMPR1C7r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744069255; c=relaxed/simple;
	bh=1icKE0bniMiuJhJCyj7+IYsrPql8p3uvDM3vCIF6VoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I7Ti6CPjRk8irV8nZM+QWPGcBpjVzdwzLyT093M65Biw+xGp9jzACF/8c5hx5GsvBoNCb6RPi/SWXgRkPzUWUvPvxMvriOrIwtngLaACvNkSiXOXPHXwlZSwZPxwgvCfLYZfuiSqL7FErlCRJh4jElP3i08Lb8Jfb1YGaGQQlEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ja69zNJt; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744069254; x=1775605254;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1icKE0bniMiuJhJCyj7+IYsrPql8p3uvDM3vCIF6VoQ=;
  b=Ja69zNJteHQBu2GbUXGShfX5QYl6O/eJhOdIpDkTsJsjncHqx+sSzQ8R
   9r0HG/JcV33gK5Tb0HZrtOdy2sLUbavSq4P3zo+cemaEAsPNCFLYgACVu
   Q74syiS/I8ziDHADB+/ZvC88NHx/uIayzNhzru8cu89e0Modw8BLJpzAW
   qL6/D7J66aYJubay2U9xanpGdxD/QGXueiMS3anPyJBahUilB6i5fScLx
   0cvdzlbBbdxYynievQlCoOc84JjQo5BVEs3ufgVElbnPjVfH2gjObfcyM
   pEhoQMLtbCK4Z6axHwUWstNg1SDp/EqJCJaUFWcI9DO2TM583+2S3zdim
   g==;
X-CSE-ConnectionGUID: iYbNwgMCQpKgOwbUtiWk8g==
X-CSE-MsgGUID: jPJ71MLFSkGwhxdRL7EXfQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="48193194"
X-IronPort-AV: E=Sophos;i="6.15,196,1739865600"; 
   d="scan'208";a="48193194"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 16:40:50 -0700
X-CSE-ConnectionGUID: 6w+55wZxQ6u9aSJ2wQfPRQ==
X-CSE-MsgGUID: arwLGiF2RuOu/F4pxhPYiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,196,1739865600"; 
   d="scan'208";a="165315479"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 16:40:49 -0700
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
Subject: [PATCH v3 11/26] fs/resctrl: Add support for additional monitor event display formats
Date: Mon,  7 Apr 2025 16:40:13 -0700
Message-ID: <20250407234032.241215-12-tony.luck@intel.com>
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

Add a type field to both the mon_evt and mon_data structures.

Legacy monitor events are still all displayed as an unsigned decimal
64-bit integer.

Add an additional format of fixed-point with 18 binary places displayed
as a floating point value with six decimal places.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 include/linux/resctrl_types.h |  8 ++++++++
 fs/resctrl/internal.h         |  4 ++++
 fs/resctrl/ctrlmondata.c      | 23 ++++++++++++++++++++++-
 fs/resctrl/monitor.c          |  3 +++
 fs/resctrl/rdtgroup.c         |  1 +
 5 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/include/linux/resctrl_types.h b/include/linux/resctrl_types.h
index 898068a99ef7..fbd4b55c41aa 100644
--- a/include/linux/resctrl_types.h
+++ b/include/linux/resctrl_types.h
@@ -58,6 +58,14 @@ enum resctrl_event_id {
 #define QOS_NUM_MBM_EVENTS	(QOS_L3_MBM_LOCAL_EVENT_ID - QOS_L3_MBM_TOTAL_EVENT_ID + 1)
 #define MBM_EVENT_IDX(evt)	((evt) - QOS_L3_MBM_TOTAL_EVENT_ID)
 
+/*
+ * Event value display types
+ */
+enum resctrl_event_type {
+	EVT_TYPE_U64,
+	EVT_TYPE_U46_18,
+};
+
 static inline bool resctrl_is_mbm_event(int e)
 {
 	return (e >= QOS_L3_MBM_TOTAL_EVENT_ID &&
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index 74a77794364d..4a840e683e96 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -71,6 +71,7 @@ static inline struct rdt_fs_context *rdt_fc2context(struct fs_context *fc)
  * struct mon_evt - Entry in the event list of a resource
  * @evtid:		event id
  * @name:		name of the event
+ * @type:		format for display to user
  * @configurable:	true if the event is configurable
  * @any_cpu:		true if this event can be read from any CPU
  * @list:		entry in &rdt_resource->evt_list
@@ -79,6 +80,7 @@ struct mon_evt {
 	enum resctrl_event_id	evtid;
 	enum resctrl_res_level	rid;
 	char			*name;
+	enum resctrl_event_type	type;
 	bool			configurable;
 	bool			any_cpu;
 	struct list_head	list;
@@ -89,6 +91,7 @@ struct mon_evt {
  * @list:            List of all allocated structures.
  * @rid:             Resource id associated with the event file.
  * @evtid:           Event id associated with the event file.
+ * @type:            Format for display to user
  * @sum:             Set when event must be summed across multiple
  *                   domains.
  * @domid:           When @sum is zero this is the domain to which
@@ -104,6 +107,7 @@ struct mon_data {
 	struct list_head list;
 	unsigned int rid;
 	enum resctrl_event_id evtid;
+	enum resctrl_event_type type;
 	unsigned int sum;
 	unsigned int domid;
 	bool any_cpu;
diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
index cd77960657f0..5ea8113c96ac 100644
--- a/fs/resctrl/ctrlmondata.c
+++ b/fs/resctrl/ctrlmondata.c
@@ -562,6 +562,27 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 	resctrl_arch_mon_ctx_free(r, evtid, rr->arch_mon_ctx);
 }
 
+#define NUM_FRAC_BITS	18
+#define FRAC_MASK	GENMASK(NUM_FRAC_BITS - 1, 0)
+
+static void show_value(struct seq_file *m, enum resctrl_event_type type, u64 val)
+{
+	u64 frac;
+
+	switch (type) {
+	case EVT_TYPE_U64:
+		seq_printf(m, "%llu\n", val);
+		break;
+	case EVT_TYPE_U46_18:
+		frac = val & FRAC_MASK;
+		frac = frac * 1000000;
+		frac += 1ul << (NUM_FRAC_BITS - 1);
+		frac >>= NUM_FRAC_BITS;
+		seq_printf(m, "%llu.%06llu\n", val >> NUM_FRAC_BITS, frac);
+		break;
+	}
+}
+
 int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 {
 	struct kernfs_open_file *of = m->private;
@@ -633,7 +654,7 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 	else if (rr.err == -EINVAL)
 		seq_puts(m, "Unavailable\n");
 	else
-		seq_printf(m, "%llu\n", rr.val);
+		show_value(m, md->type, rr.val);
 
 out:
 	rdtgroup_kn_unlock(of->kn);
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index 1cf0b085e07a..1efad57d1d85 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -847,16 +847,19 @@ static struct mon_evt all_events[QOS_NUM_EVENTS] = {
 		.name	= "llc_occupancy",
 		.evtid	= QOS_L3_OCCUP_EVENT_ID,
 		.rid	= RDT_RESOURCE_L3,
+		.type	= EVT_TYPE_U64,
 	},
 	[QOS_L3_MBM_TOTAL_EVENT_ID] = {
 		.name	= "mbm_total_bytes",
 		.evtid	= QOS_L3_MBM_TOTAL_EVENT_ID,
 		.rid	= RDT_RESOURCE_L3,
+		.type	= EVT_TYPE_U64,
 	},
 	[QOS_L3_MBM_LOCAL_EVENT_ID] = {
 		.name	= "mbm_local_bytes",
 		.evtid	= QOS_L3_MBM_LOCAL_EVENT_ID,
 		.rid	= RDT_RESOURCE_L3,
+		.type	= EVT_TYPE_U64,
 	},
 };
 
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 97c2ba8af930..bd41f7a0f416 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -2927,6 +2927,7 @@ static struct mon_data *mon_get_kn_priv(int rid, int domid, struct mon_evt *mevt
 	priv->sum = do_sum;
 	priv->evtid = mevt->evtid;
 	priv->any_cpu = mevt->any_cpu;
+	priv->type = mevt->type;
 	list_add_tail(&priv->list, &kn_priv_list);
 
 	return priv;
-- 
2.48.1


