Return-Path: <linux-kernel+bounces-876701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 842CAC1C84D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AC456282C5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F27350A1B;
	Wed, 29 Oct 2025 16:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PWFQqyY7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175F334F465
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 16:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761754896; cv=none; b=KtwgiLTCZR7c5nNyAd8DJgpOVFAIJRj1G32+9knd3oj4PNCR/ieFoig0GJ/4bP8vNxHhHfziGRDoyo+SSDE1cEFgUMhQIMjlJ+EkGYwINml4uG3tjHcw4M76ehZPba94Yj62fhz8SqxGDnKczYvnxpTUG7UvI2KrR8yjp26XwvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761754896; c=relaxed/simple;
	bh=BFzzBcBsNPwLmYYPqw9ZqCaQ1hYVrnpLzhorJovMWCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d6Fk+ma+/yu+BwQxK9WddvVQZZd66HPqK8QX7zWMNQPCOXdGWsl/oHcs8XXN/wyLmrEKBxlv729a4iXspfEETtEJPFp5bht03UuWxP8YVqxaE+3UByoqvML/M85/7OqjvjrA30ujK5qtivRDT8hvZB5aMWfcZ4JIi/IAQqWwYc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PWFQqyY7; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761754894; x=1793290894;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BFzzBcBsNPwLmYYPqw9ZqCaQ1hYVrnpLzhorJovMWCk=;
  b=PWFQqyY7D2aG8smVAMrJAcVaaoT4Su1CR/6JkYoA6BBKmDP7FQvIE5Gf
   64otNtSQy7S4JM7QUhr772CR/h8LbbV7RFaW+p6RLzTtRgOe8dKHHs/jv
   XkjYLaHPyce9jMYzzInamSIhloJvtt4yPiVgPb7AMO7bIsTUjGz2yxq2T
   sTRIghp8Vql/rBV/eSgjvEBNk5oKe8Yy59gPlwGOc6Q7ZV2Z7yaRx7XRy
   lFepKK1+nKbNwbYKCkugtU2wc6O37HSxbfDTdQef8G+h9hwPgT26L5a4J
   CfDKg+FKT2hwyz++Mw0d7lmykyi1crH2XT1xzDEZacJ0UZaGGGuOSl7sY
   A==;
X-CSE-ConnectionGUID: ju7Vg5+VRAmKy85cHUTe7Q==
X-CSE-MsgGUID: WeWzJ41tSbKkzrOwQ2NYkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="75331013"
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="75331013"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 09:21:28 -0700
X-CSE-ConnectionGUID: kb8MrSkNSxWdcacoutcFwQ==
X-CSE-MsgGUID: I8MprbcvRkqk3WO/Pk9a4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="184901334"
Received: from mgerlach-mobl1.amr.corp.intel.com (HELO agluck-desk3.home.arpa) ([10.124.223.146])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 09:21:28 -0700
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
Subject: [PATCH v13 11/32] x86,fs/resctrl: Handle events that can be read from any CPU
Date: Wed, 29 Oct 2025 09:20:54 -0700
Message-ID: <20251029162118.40604-12-tony.luck@intel.com>
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

resctrl assumes that monitor events can only be read from a CPU in the
cpumask_t set of each domain.  This is true for x86 events accessed
with an MSR interface, but may not be true for other access methods such
as MMIO.

Introduce and use flag mon_evt::any_cpu, settable by architecture, that
indicates there are no restrictions on which CPU can read that event.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 include/linux/resctrl.h            | 2 +-
 fs/resctrl/internal.h              | 2 ++
 arch/x86/kernel/cpu/resctrl/core.c | 6 +++---
 fs/resctrl/ctrlmondata.c           | 6 ++++++
 fs/resctrl/monitor.c               | 3 ++-
 5 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index a07542957e5a..702205505dc9 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -409,7 +409,7 @@ u32 resctrl_arch_get_num_closid(struct rdt_resource *r);
 u32 resctrl_arch_system_num_rmid_idx(void);
 int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid);
 
-void resctrl_enable_mon_event(enum resctrl_event_id eventid);
+void resctrl_enable_mon_event(enum resctrl_event_id eventid, bool any_cpu);
 
 bool resctrl_is_mon_event_enabled(enum resctrl_event_id eventid);
 
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index 12a2ab7e3c9b..40b76eaa33d0 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -61,6 +61,7 @@ static inline struct rdt_fs_context *rdt_fc2context(struct fs_context *fc)
  *			READS_TO_REMOTE_MEM) being tracked by @evtid.
  *			Only valid if @evtid is an MBM event.
  * @configurable:	true if the event is configurable
+ * @any_cpu:		true if the event can be read from any CPU
  * @enabled:		true if the event is enabled
  */
 struct mon_evt {
@@ -69,6 +70,7 @@ struct mon_evt {
 	char			*name;
 	u32			evt_cfg;
 	bool			configurable;
+	bool			any_cpu;
 	bool			enabled;
 };
 
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 99d1048d29d1..78ad493dcc01 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -893,15 +893,15 @@ static __init bool get_rdt_mon_resources(void)
 	bool ret = false;
 
 	if (rdt_cpu_has(X86_FEATURE_CQM_OCCUP_LLC)) {
-		resctrl_enable_mon_event(QOS_L3_OCCUP_EVENT_ID);
+		resctrl_enable_mon_event(QOS_L3_OCCUP_EVENT_ID, false);
 		ret = true;
 	}
 	if (rdt_cpu_has(X86_FEATURE_CQM_MBM_TOTAL)) {
-		resctrl_enable_mon_event(QOS_L3_MBM_TOTAL_EVENT_ID);
+		resctrl_enable_mon_event(QOS_L3_MBM_TOTAL_EVENT_ID, false);
 		ret = true;
 	}
 	if (rdt_cpu_has(X86_FEATURE_CQM_MBM_LOCAL)) {
-		resctrl_enable_mon_event(QOS_L3_MBM_LOCAL_EVENT_ID);
+		resctrl_enable_mon_event(QOS_L3_MBM_LOCAL_EVENT_ID, false);
 		ret = true;
 	}
 	if (rdt_cpu_has(X86_FEATURE_ABMC))
diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
index c3656812848b..883be6f0810f 100644
--- a/fs/resctrl/ctrlmondata.c
+++ b/fs/resctrl/ctrlmondata.c
@@ -574,6 +574,11 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 		}
 	}
 
+	if (evt->any_cpu) {
+		mon_event_count(rr);
+		goto out_ctx_free;
+	}
+
 	cpu = cpumask_any_housekeeping(cpumask, RESCTRL_PICK_ANY_CPU);
 
 	/*
@@ -587,6 +592,7 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 	else
 		smp_call_on_cpu(cpu, smp_mon_event_count, rr, false);
 
+out_ctx_free:
 	if (rr->arch_mon_ctx)
 		resctrl_arch_mon_ctx_free(r, evt->evtid, rr->arch_mon_ctx);
 }
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index 5cf928e10eaf..6eab98b47816 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -975,7 +975,7 @@ struct mon_evt mon_event_all[QOS_NUM_EVENTS] = {
 	},
 };
 
-void resctrl_enable_mon_event(enum resctrl_event_id eventid)
+void resctrl_enable_mon_event(enum resctrl_event_id eventid, bool any_cpu)
 {
 	if (WARN_ON_ONCE(eventid < QOS_FIRST_EVENT || eventid >= QOS_NUM_EVENTS))
 		return;
@@ -984,6 +984,7 @@ void resctrl_enable_mon_event(enum resctrl_event_id eventid)
 		return;
 	}
 
+	mon_event_all[eventid].any_cpu = any_cpu;
 	mon_event_all[eventid].enabled = true;
 }
 
-- 
2.51.0


