Return-Path: <linux-kernel+bounces-769984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B0AB275A4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 04:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F317AA25A35
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 02:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03C629992B;
	Fri, 15 Aug 2025 02:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WcB9ochP"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7534298CA1;
	Fri, 15 Aug 2025 02:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755224770; cv=fail; b=bbESGV3BEoYZu/WoFgHCoOsgzXuLXnMiomd4o8HiMq9uVsUMHjz+8GFIzlQsbcx8vzUiyV9ryhDdJPWnOHDd9rl7D4WpqcQh4rSqVUyNWKHWMkVRGT1yeeheqms3b2OjAf2nc4FzGdjz7vsffA07WPjpFpsl2NOhxu53ifHCcfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755224770; c=relaxed/simple;
	bh=2c6FI0ZdnqsVJ0E/NR6zEyEckmf4bq9EuV6PtLn7I6Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AGf4rEU4Bl4jSUgI2I2pyOT9gta/gHaKuyB17xyfh6FMAY8qu288Kq6YRD3CaCswj75qiXwjCfUdyj3TlTj6mYI3gj1UpyvheqXAk9Iep/hfDdlkO9YnMdPmI7quwYZdrsR+NlI573b09l/LTjvv+iiOvBrB0pAWhVZEHIWvq+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WcB9ochP; arc=fail smtp.client-ip=40.107.243.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UnM6NFcY8WFjOZ/IP83M4w2NPF4skFvbclqEdtDgBIAK71vhKNl7Co0DcVUH5WwukT6dyS2lBpZn0FHsy86uW10lGwImrCdKFHKifSgExcxVX4+3JXe7lWcs29U+7fD9gROJ5UgFgqow10dR+4lxYmDkvrhZsfzfN5Ouprf4jANzOEQp+4lnpYVWYBB+lXq+nBZnDX4PIKH5B/e7SNZapRPRrsm8c+EIU4GPl84oIJqCNtP0AeL/oa/RiIwf4Svl7uA8qJG3GL2I8JNEk4XnsdG0coQEvNHxHVa4Hp/bNLCm8STvr3iey6ZeCsbCR0NPDJb66RatN+vfbuX+XVkHyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tjvZYsZK9jx1vv1z/IHCTqjglTM7e7siVeNVC1mzY2g=;
 b=o6FiRniMCcWgeHLqpMHnhnkDUlyw6LcZiI3p1dYqJQPaURofG2sCxF5M/rcGi5oVPcKG216qH4oHENqMKJxMhEnV6lXbADNF/fpmXnBqEPWR4AaJfuhIEX/HrAHk/907SJ06nq+n7OGDMu0chom20OYEn01cR5PLKgqSSbWr3ub5lIrhVV1FGMxzL6OSkNCl5JG8e0qU1XgXidG+Zp3ri3PBRpTuU58mMDgcpHp4mTt9LvEgDO+hH6w8NhyUIOS6SrpHNyajfQfOEZkvYYKITlHyRss8ol+3t71G3AGBJGtB7BFoMkR7Ajh32o/Gnq9UmxS6YgGQpzRE9DyWA1aVTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tjvZYsZK9jx1vv1z/IHCTqjglTM7e7siVeNVC1mzY2g=;
 b=WcB9ochPqfA4Zd1IH9QzxmX2AbA8tN2kFaOruqZIvWpe1a+iWqxyiz0uSDwMurSRmnNflgD624mEZ1KCIin1L1Eh69oc9I2mAX4+yMxTMjX0BwxW0WI/UfINlRxjJQMkHwj7NSjYL8dhEwpwGygZYl6VK7cIzpn/+J3wifcQid8=
Received: from BYAPR04CA0006.namprd04.prod.outlook.com (2603:10b6:a03:40::19)
 by MW3PR12MB4459.namprd12.prod.outlook.com (2603:10b6:303:56::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Fri, 15 Aug
 2025 02:26:02 +0000
Received: from SN1PEPF00036F3C.namprd05.prod.outlook.com
 (2603:10b6:a03:40:cafe::a7) by BYAPR04CA0006.outlook.office365.com
 (2603:10b6:a03:40::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.17 via Frontend Transport; Fri,
 15 Aug 2025 02:26:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00036F3C.mail.protection.outlook.com (10.167.248.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Fri, 15 Aug 2025 02:26:02 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 21:25:58 -0500
From: Babu Moger <babu.moger@amd.com>
To: <corbet@lwn.net>, <tony.luck@intel.com>, <reinette.chatre@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <Dave.Martin@arm.com>, <james.morse@arm.com>, <babu.moger@amd.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<rostedt@goodmis.org>, <paulmck@kernel.org>,
	<pawan.kumar.gupta@linux.intel.com>, <kees@kernel.org>, <arnd@arndb.de>,
	<fvdl@google.com>, <seanjc@google.com>, <thomas.lendacky@amd.com>,
	<yosry.ahmed@linux.dev>, <xin@zytor.com>, <sohil.mehta@intel.com>,
	<kai.huang@intel.com>, <xiaoyao.li@intel.com>, <peterz@infradead.org>,
	<mario.limonciello@amd.com>, <xin3.li@intel.com>, <perry.yuan@amd.com>,
	<chang.seok.bae@intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <peternewman@google.com>,
	<eranian@google.com>, <gautham.shenoy@amd.com>
Subject: [PATCH v17 01/33] x86,fs/resctrl: Consolidate monitor event descriptions
Date: Thu, 14 Aug 2025 21:25:05 -0500
Message-ID: <386ef42c5c545931672d82b147c10b702e40d69a.1755224735.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1755224735.git.babu.moger@amd.com>
References: <cover.1755224735.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3C:EE_|MW3PR12MB4459:EE_
X-MS-Office365-Filtering-Correlation-Id: cb7ba663-5026-4717-a17d-08dddba3145a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AibL8KqgpSOuoKO+5FgSRYt33PW2rA4m2ueHb5ahOOhH9U0Cs9clL53RnVyT?=
 =?us-ascii?Q?uitYlpJG/aE6o70Gco+m7/urBOuZU9SBA5+YB+FWka98Q3aARtyXfNensrg0?=
 =?us-ascii?Q?0bW1/QvAzPK9wUVBbD+eP4rDQ7V6kZKgJE55+xWEfyt/hMMqGZsgrNtcnHkB?=
 =?us-ascii?Q?Owiykn9A44yGPZ+FUlDY46AbIwDIqMKMRF2PEe8tWbA8CBHJjQBsNe5z9bTh?=
 =?us-ascii?Q?0GYjU0K7tu9CG7PtM5L5Qcwj+X6zq2QEAJbogFoWZ8+zU8wCUYdl4o6ZIMKf?=
 =?us-ascii?Q?xGZ+htusznpcgk7wFjSP8MmSjbr7rBUE8SR8g2eh0DbpWVG2BYqtBrVyVVwR?=
 =?us-ascii?Q?GwRt9X20g3JGr7KfHtrZOj2mVoUgC3pl/t53NpmjXCFcbGtx+AMq+f+spcx0?=
 =?us-ascii?Q?HqUFyOk+vaizuI9rfvoKWcITA8dWZYb28LKnRQY/sj0/gQVLwkv/n1Z/rQNC?=
 =?us-ascii?Q?JOX1c65SeW3TEp9L3xr1C2WfFh+dlW2pV9MpDqKo6sRZJD8azd8Ul/j43p3r?=
 =?us-ascii?Q?rY8LsY5PJriYv4nYcY8eLQi8lIZxzVhxUj3NzsAuiXZyQVcS/8Zn9BGNe8vj?=
 =?us-ascii?Q?9B3v5TygjRznbrs4OzEbo3n1cVeKVsNiYjDZh8FHvFHQO6qDs610gukArAbI?=
 =?us-ascii?Q?7ptSuuym+LvxclfznXi2T5Qj0c37iOqhZYwUKp1Tk0J/qq+3+cqnlfiHZst7?=
 =?us-ascii?Q?YjlkqGMMMRh16thnAK4NgVQPQbeelgSdR4LbhNlWb8Qv3n+ZnbQ6OgJ/jggb?=
 =?us-ascii?Q?oK0thxvstXlaaOC9krbrpa0LN3t84gka0Wkto9OTqU5IYrKYwz/KzfECB1cr?=
 =?us-ascii?Q?K8Q8UQz0RiQJCAPZaIvryLVpw06Dkaa77gwmO7z9zJLzCRXJ+bcwZ8qYeC96?=
 =?us-ascii?Q?SnON0wqihV7vaCNBDNJN8udDXqoDXV0S+eMS5HdUAX/UUt6cfpvVBRgZ1+Uf?=
 =?us-ascii?Q?Kx+HNmojyeObnfTMvciZ3tKU1gW159pq7ihSBjsAjaeAI0OUlP33TY4plLom?=
 =?us-ascii?Q?FWRHwZeYwmMenjCWijkh/SceYjEaVTx7YrFZBnMjaYy8nWRO2lpwGLaeg7fJ?=
 =?us-ascii?Q?VP5Aff24pOSVy89Z+2aoB7ZM/yctSz/B6Udb1SS68quIe/d4wLWhj+idyWDO?=
 =?us-ascii?Q?2F1k4xpBRQmEKJrCp0ccuQck6tqTfppYTGYzeDki0dXkuMow5FDh0+1NY3c6?=
 =?us-ascii?Q?jl8WqDAIUnCN03kptZrobplKylgWPWBbguxuevpdo1/s0HC1ntEm+KnpCcQH?=
 =?us-ascii?Q?C/KzNW/rikZogmWwrvTF/E9JqYWi7ZR0O25ulV4KbvtLWhzN311bR56lmN5+?=
 =?us-ascii?Q?A47ZNQt0ELGTxu/+eg2KsuJiWaYWUUlS/9oUWlTEeKf/7dH++9IPzPuCzmbm?=
 =?us-ascii?Q?3t0L+cbLYm1ecLgfwIf4jJPnT7EJwuO7STvCMHu5ca1qolzcZjwrb6/TyHDI?=
 =?us-ascii?Q?ra7pl2+kDfRs3HxMU0s+hYecqNCMiEcQYtBpVA/GKeukUzScWiAj5ytk5zZw?=
 =?us-ascii?Q?bj1/jnDA9sI3RKRr43UkdlndGTQVJiK/CFvmI3YW42/4siQfdiimwEuorA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 02:26:02.3388
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb7ba663-5026-4717-a17d-08dddba3145a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4459

From: Tony Luck <tony.luck@intel.com>

There are currently only three monitor events, all associated with
the RDT_RESOURCE_L3 resource. Growing support for additional events
will be easier with some restructuring to have a single point in
file system code where all attributes of all events are defined.

Place all event descriptions into an array mon_event_all[]. Doing
this has the beneficial side effect of removing the need for
rdt_resource::evt_list.

Add resctrl_event_id::QOS_FIRST_EVENT for a lower bound on range
checks for event ids and as the starting index to scan mon_event_all[].

Drop the code that builds evt_list and change the two places where
the list is scanned to scan mon_event_all[] instead using a new
helper macro for_each_mon_event().

Architecture code now informs file system code which events are
available with resctrl_enable_mon_event().

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
v17: Added Signed-off-by tag.

Picked up first four patches from:
https://lore.kernel.org/lkml/20250711235341.113933-1-tony.luck@intel.com/
These patches have already been reviewed.
---
 arch/x86/kernel/cpu/resctrl/core.c | 12 ++++--
 fs/resctrl/internal.h              | 13 ++++--
 fs/resctrl/monitor.c               | 63 +++++++++++++++---------------
 fs/resctrl/rdtgroup.c              | 11 +++---
 include/linux/resctrl.h            |  4 +-
 include/linux/resctrl_types.h      | 12 ++++--
 6 files changed, 66 insertions(+), 49 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 187d527ef73b..7fcae25874fe 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -864,12 +864,18 @@ static __init bool get_rdt_mon_resources(void)
 {
 	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
 
-	if (rdt_cpu_has(X86_FEATURE_CQM_OCCUP_LLC))
+	if (rdt_cpu_has(X86_FEATURE_CQM_OCCUP_LLC)) {
+		resctrl_enable_mon_event(QOS_L3_OCCUP_EVENT_ID);
 		rdt_mon_features |= (1 << QOS_L3_OCCUP_EVENT_ID);
-	if (rdt_cpu_has(X86_FEATURE_CQM_MBM_TOTAL))
+	}
+	if (rdt_cpu_has(X86_FEATURE_CQM_MBM_TOTAL)) {
+		resctrl_enable_mon_event(QOS_L3_MBM_TOTAL_EVENT_ID);
 		rdt_mon_features |= (1 << QOS_L3_MBM_TOTAL_EVENT_ID);
-	if (rdt_cpu_has(X86_FEATURE_CQM_MBM_LOCAL))
+	}
+	if (rdt_cpu_has(X86_FEATURE_CQM_MBM_LOCAL)) {
+		resctrl_enable_mon_event(QOS_L3_MBM_LOCAL_EVENT_ID);
 		rdt_mon_features |= (1 << QOS_L3_MBM_LOCAL_EVENT_ID);
+	}
 
 	if (!rdt_mon_features)
 		return false;
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index 0a1eedba2b03..4f315b7e9ec0 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -52,19 +52,26 @@ static inline struct rdt_fs_context *rdt_fc2context(struct fs_context *fc)
 }
 
 /**
- * struct mon_evt - Entry in the event list of a resource
+ * struct mon_evt - Properties of a monitor event
  * @evtid:		event id
+ * @rid:		resource id for this event
  * @name:		name of the event
  * @configurable:	true if the event is configurable
- * @list:		entry in &rdt_resource->evt_list
+ * @enabled:		true if the event is enabled
  */
 struct mon_evt {
 	enum resctrl_event_id	evtid;
+	enum resctrl_res_level	rid;
 	char			*name;
 	bool			configurable;
-	struct list_head	list;
+	bool			enabled;
 };
 
+extern struct mon_evt mon_event_all[QOS_NUM_EVENTS];
+
+#define for_each_mon_event(mevt) for (mevt = &mon_event_all[QOS_FIRST_EVENT];	\
+				      mevt < &mon_event_all[QOS_NUM_EVENTS]; mevt++)
+
 /**
  * struct mon_data - Monitoring details for each event file.
  * @list:            Member of the global @mon_data_kn_priv_list list.
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index f5637855c3ac..2313e48de55f 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -844,38 +844,39 @@ static void dom_data_exit(struct rdt_resource *r)
 	mutex_unlock(&rdtgroup_mutex);
 }
 
-static struct mon_evt llc_occupancy_event = {
-	.name		= "llc_occupancy",
-	.evtid		= QOS_L3_OCCUP_EVENT_ID,
-};
-
-static struct mon_evt mbm_total_event = {
-	.name		= "mbm_total_bytes",
-	.evtid		= QOS_L3_MBM_TOTAL_EVENT_ID,
-};
-
-static struct mon_evt mbm_local_event = {
-	.name		= "mbm_local_bytes",
-	.evtid		= QOS_L3_MBM_LOCAL_EVENT_ID,
-};
-
 /*
- * Initialize the event list for the resource.
- *
- * Note that MBM events are also part of RDT_RESOURCE_L3 resource
- * because as per the SDM the total and local memory bandwidth
- * are enumerated as part of L3 monitoring.
+ * All available events. Architecture code marks the ones that
+ * are supported by a system using resctrl_enable_mon_event()
+ * to set .enabled.
  */
-static void l3_mon_evt_init(struct rdt_resource *r)
+struct mon_evt mon_event_all[QOS_NUM_EVENTS] = {
+	[QOS_L3_OCCUP_EVENT_ID] = {
+		.name	= "llc_occupancy",
+		.evtid	= QOS_L3_OCCUP_EVENT_ID,
+		.rid	= RDT_RESOURCE_L3,
+	},
+	[QOS_L3_MBM_TOTAL_EVENT_ID] = {
+		.name	= "mbm_total_bytes",
+		.evtid	= QOS_L3_MBM_TOTAL_EVENT_ID,
+		.rid	= RDT_RESOURCE_L3,
+	},
+	[QOS_L3_MBM_LOCAL_EVENT_ID] = {
+		.name	= "mbm_local_bytes",
+		.evtid	= QOS_L3_MBM_LOCAL_EVENT_ID,
+		.rid	= RDT_RESOURCE_L3,
+	},
+};
+
+void resctrl_enable_mon_event(enum resctrl_event_id eventid)
 {
-	INIT_LIST_HEAD(&r->evt_list);
+	if (WARN_ON_ONCE(eventid < QOS_FIRST_EVENT || eventid >= QOS_NUM_EVENTS))
+		return;
+	if (mon_event_all[eventid].enabled) {
+		pr_warn("Duplicate enable for event %d\n", eventid);
+		return;
+	}
 
-	if (resctrl_arch_is_llc_occupancy_enabled())
-		list_add_tail(&llc_occupancy_event.list, &r->evt_list);
-	if (resctrl_arch_is_mbm_total_enabled())
-		list_add_tail(&mbm_total_event.list, &r->evt_list);
-	if (resctrl_arch_is_mbm_local_enabled())
-		list_add_tail(&mbm_local_event.list, &r->evt_list);
+	mon_event_all[eventid].enabled = true;
 }
 
 /**
@@ -902,15 +903,13 @@ int resctrl_mon_resource_init(void)
 	if (ret)
 		return ret;
 
-	l3_mon_evt_init(r);
-
 	if (resctrl_arch_is_evt_configurable(QOS_L3_MBM_TOTAL_EVENT_ID)) {
-		mbm_total_event.configurable = true;
+		mon_event_all[QOS_L3_MBM_TOTAL_EVENT_ID].configurable = true;
 		resctrl_file_fflags_init("mbm_total_bytes_config",
 					 RFTYPE_MON_INFO | RFTYPE_RES_CACHE);
 	}
 	if (resctrl_arch_is_evt_configurable(QOS_L3_MBM_LOCAL_EVENT_ID)) {
-		mbm_local_event.configurable = true;
+		mon_event_all[QOS_L3_MBM_LOCAL_EVENT_ID].configurable = true;
 		resctrl_file_fflags_init("mbm_local_bytes_config",
 					 RFTYPE_MON_INFO | RFTYPE_RES_CACHE);
 	}
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 77d08229d855..b95501d4b5de 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -1152,7 +1152,9 @@ static int rdt_mon_features_show(struct kernfs_open_file *of,
 	struct rdt_resource *r = rdt_kn_parent_priv(of->kn);
 	struct mon_evt *mevt;
 
-	list_for_each_entry(mevt, &r->evt_list, list) {
+	for_each_mon_event(mevt) {
+		if (mevt->rid != r->rid || !mevt->enabled)
+			continue;
 		seq_printf(seq, "%s\n", mevt->name);
 		if (mevt->configurable)
 			seq_printf(seq, "%s_config\n", mevt->name);
@@ -3057,10 +3059,9 @@ static int mon_add_all_files(struct kernfs_node *kn, struct rdt_mon_domain *d,
 	struct mon_evt *mevt;
 	int ret, domid;
 
-	if (WARN_ON(list_empty(&r->evt_list)))
-		return -EPERM;
-
-	list_for_each_entry(mevt, &r->evt_list, list) {
+	for_each_mon_event(mevt) {
+		if (mevt->rid != r->rid || !mevt->enabled)
+			continue;
 		domid = do_sum ? d->ci_id : d->hdr.id;
 		priv = mon_get_kn_priv(r->rid, domid, mevt, do_sum);
 		if (WARN_ON_ONCE(!priv))
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 6fb4894b8cfd..2944042bd84c 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -269,7 +269,6 @@ enum resctrl_schema_fmt {
  * @mon_domains:	RCU list of all monitor domains for this resource
  * @name:		Name to use in "schemata" file.
  * @schema_fmt:		Which format string and parser is used for this schema.
- * @evt_list:		List of monitoring events
  * @mbm_cfg_mask:	Bandwidth sources that can be tracked when bandwidth
  *			monitoring events can be configured.
  * @cdp_capable:	Is the CDP feature available on this resource
@@ -287,7 +286,6 @@ struct rdt_resource {
 	struct list_head	mon_domains;
 	char			*name;
 	enum resctrl_schema_fmt	schema_fmt;
-	struct list_head	evt_list;
 	unsigned int		mbm_cfg_mask;
 	bool			cdp_capable;
 };
@@ -372,6 +370,8 @@ u32 resctrl_arch_get_num_closid(struct rdt_resource *r);
 u32 resctrl_arch_system_num_rmid_idx(void);
 int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid);
 
+void resctrl_enable_mon_event(enum resctrl_event_id eventid);
+
 bool resctrl_arch_is_evt_configurable(enum resctrl_event_id evt);
 
 /**
diff --git a/include/linux/resctrl_types.h b/include/linux/resctrl_types.h
index a25fb9c4070d..2dadbc54e4b3 100644
--- a/include/linux/resctrl_types.h
+++ b/include/linux/resctrl_types.h
@@ -34,11 +34,15 @@
 /* Max event bits supported */
 #define MAX_EVT_CONFIG_BITS		GENMASK(6, 0)
 
-/*
- * Event IDs, the values match those used to program IA32_QM_EVTSEL before
- * reading IA32_QM_CTR on RDT systems.
- */
+/* Event IDs */
 enum resctrl_event_id {
+	/* Must match value of first event below */
+	QOS_FIRST_EVENT			= 0x01,
+
+	/*
+	 * These values match those used to program IA32_QM_EVTSEL before
+	 * reading IA32_QM_CTR on RDT systems.
+	 */
 	QOS_L3_OCCUP_EVENT_ID		= 0x01,
 	QOS_L3_MBM_TOTAL_EVENT_ID	= 0x02,
 	QOS_L3_MBM_LOCAL_EVENT_ID	= 0x03,
-- 
2.34.1


