Return-Path: <linux-kernel+bounces-746164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5596B123CD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCF6C5608C2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97062494D8;
	Fri, 25 Jul 2025 18:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wGkA1UDs"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2070.outbound.protection.outlook.com [40.107.96.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3392248869;
	Fri, 25 Jul 2025 18:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753468229; cv=fail; b=E+dNO3NC8C9i+RK2vkzGvkwc3TgEAkBxfW/algmTbBwjgpXLX0d9co6yMsZjxuCbERphnwZJmHV9KgJTfJNr5xe+KjVXCfO9UsBk8oPL9vI/PL5G4DHLKI/RPToBzG9JxUIaGLymXiiYg0aRg5Bz+X0KCmINx/v0KrJVE1pUMd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753468229; c=relaxed/simple;
	bh=PQtYcn0iyZ16Gg0giG6SH4tsoC5AVPlBzZab273Jupg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OliwhN6FUAg6CGJFNBCJQ4BkGOD82/j09wj7uyzBFCchqfyn62C9yBtqfG85leT2+nKDol8yXlCK/4wa8pb+Y/IytD6fmrtJ8CrJAQ3lXNCSfSIPXaXkAOCp56PwgcSXqzsSQ0jNlFoj1I/JPUjDqQuB+Sh2M/jsLDFnGkwPof4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wGkA1UDs; arc=fail smtp.client-ip=40.107.96.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B77T417PWR5bcLygPEmL2pU7/5IWdmoq0d7Ns4XIwEMv95w6OnY8eZinerW/EklelymOTTv4Q/p6aoEic23rwHYuM6EzIroGFBF7ANg++izh6mdSfAMo/QPGjZb00mqGzoneZQq9L0wkSjeEamua6RibHhG64+lEFfSM6XizBFhNsm6U1d9hy9YzRyfmjDZnQgQwoUnpjwFJgsXuxIZyEPvlXhWt0Ldpl/gi4LcEq+l2X0S/lHAAIDyig532rG9Q9NhspM+QDOwLVG+1ul52faAP3hvn1ISc6VunHWOokbyA0m13M3JMKYmxqvBdOHvlU5vuyxde/oX35fqzq3XheA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V73REeLkcPpC4b6iBiWhbphtCeB8hbGCKHOLhwaoiMU=;
 b=DZaJER5n63EraY0z1kuScHM17YWvpl4pSzqyiTq++c6cRfV2C8V2VXyrPLjarp2BibxU+m3osRtFnbt2Ni3xdOFN0SOoC8aqwdqk0So68lkjNU3CWd4osW0HZdppL5zg72ULGAljiKF1Lae9czwzwniizxtPuezJ5upJ75O9Qo3lJCLoahhJ10DzmZ0PCOeWn0+IrAtlOAHru/SlsCxJbZd3jDbu4qF0VzhZPSh89mVHLYen4/EERf7XM69i4iAQDxj6gRWx1bMR7e4ILhJGf6a2PIJvj0tRgi6MK8tcyVyMq+gXeqFK0tEkGG5Z98vZR4sWQQySIg/af64Ej5gCTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V73REeLkcPpC4b6iBiWhbphtCeB8hbGCKHOLhwaoiMU=;
 b=wGkA1UDshEhgJjJJ2dhADxlA95Kisr66/EXJBKga3e6+BUG8O87me0rgDzl7Eo8gyXwO7DkLldtRWgm5pvNTrLTA1KVVec6xaaFolKwgkABVwb2VdDH7o+0TObUfRNYT/86ML0zD7m20xOI0H9OERjjzWgB1ddUfWBtLrts4kQc=
Received: from SN6PR04CA0089.namprd04.prod.outlook.com (2603:10b6:805:f2::30)
 by PH0PR12MB5607.namprd12.prod.outlook.com (2603:10b6:510:142::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Fri, 25 Jul
 2025 18:30:23 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:805:f2:cafe::7b) by SN6PR04CA0089.outlook.office365.com
 (2603:10b6:805:f2::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.23 via Frontend Transport; Fri,
 25 Jul 2025 18:30:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Fri, 25 Jul 2025 18:30:23 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Jul
 2025 13:30:20 -0500
From: Babu Moger <babu.moger@amd.com>
To: <corbet@lwn.net>, <tony.luck@intel.com>, <reinette.chatre@intel.com>,
	<james.morse@arm.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <Dave.Martin@arm.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<akpm@linux-foundation.org>, <paulmck@kernel.org>, <rostedt@goodmis.org>,
	<Neeraj.Upadhyay@amd.com>, <david@redhat.com>, <arnd@arndb.de>,
	<fvdl@google.com>, <seanjc@google.com>, <jpoimboe@kernel.org>,
	<pawan.kumar.gupta@linux.intel.com>, <xin@zytor.com>,
	<manali.shukla@amd.com>, <babu.moger@amd.com>, <tao1.su@linux.intel.com>,
	<sohil.mehta@intel.com>, <kai.huang@intel.com>, <xiaoyao.li@intel.com>,
	<peterz@infradead.org>, <xin3.li@intel.com>, <kan.liang@linux.intel.com>,
	<mario.limonciello@amd.com>, <thomas.lendacky@amd.com>, <perry.yuan@amd.com>,
	<gautham.shenoy@amd.com>, <chang.seok.bae@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<peternewman@google.com>, <eranian@google.com>
Subject: [PATCH v16 01/34] x86,fs/resctrl: Consolidate monitor event descriptions
Date: Fri, 25 Jul 2025 13:29:20 -0500
Message-ID: <404b149d4e717fa7e7f93cbe85cd5abd990202ca.1753467772.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1753467772.git.babu.moger@amd.com>
References: <cover.1753467772.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|PH0PR12MB5607:EE_
X-MS-Office365-Filtering-Correlation-Id: 83686049-813e-4e32-6dcf-08ddcba9516f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d33hoe02CGcvUqnBMxl5dKgRLhK9B35isLnU7ZOi4+n3/HYtaPoeaKx/SV0E?=
 =?us-ascii?Q?5lv1HlNSS2qecrosIWNh5rTBCjPQRfqkZ2iW3DSbB3u+7rdA5LYR3jAXgex2?=
 =?us-ascii?Q?cBf1RTtagxPgkpxzCc6rwf1HOs4UbEiRdq2BE2ZgJWnet4ej+4hhK2Zh6r2a?=
 =?us-ascii?Q?9h8p4/a2+KtyShkKOq6N+e6Gc6ywLyXHw84Q9iB8gdJzJvZkmntb7o6SOuD1?=
 =?us-ascii?Q?8PKOiV2oMXdJ5SM8C8koSyRSfbYtVcyTPU2NvKf+401n8UZTI3NQhlNxe/8d?=
 =?us-ascii?Q?W13mT1i9ws0qDzDepp94IrrqQ1mRzRFUIudl07hDB67y3/TjgBZUQDRPlOX/?=
 =?us-ascii?Q?ResiqjpyOO2o0ybJeQNehHoBazYJUJOuFPXY+a3xYhWom2fkCxjLFhapBWnx?=
 =?us-ascii?Q?gEKrKWbxc9fCbWdfELoC0ZmlgINhluiLNcbeLZxdyBsAMoYyx4vaVyj3IFhn?=
 =?us-ascii?Q?ExDVD0iSx40YWQ3iCn4nYTE8sJbazmcclP1unEzocGMabc3TGRyrpY8N8Eri?=
 =?us-ascii?Q?b0yNBnTAOOQ9aZfp8NK4nV3gzUW6+MCo9MBU9nw8r8Bgkm3/O4qPcUSm2ie7?=
 =?us-ascii?Q?A5dpQo9Lz1ZCj0gS8iJgoC70pZFrKaOZE3tZoylQ8Lg1XnrhQvTWQ1cnoQyO?=
 =?us-ascii?Q?Mo/k4h0b6Ikq0gQOrxXoCHuC8cGuvFyL59uPvnKOA0y8bv19h5YpKQZbQVur?=
 =?us-ascii?Q?BokynDjqlAssUHjGu+EqLuzdT6Zaq5mB/6yOS+LA+4ueTe6K3gR/6+Xy3FMP?=
 =?us-ascii?Q?Ai4yp8FNxiEr8yGx4Hwd4Xl2onDld4t0xaK0grdaMXEhoa/nY+jt+/yDNuW/?=
 =?us-ascii?Q?HEI2zUVaOKEeGvIu9w+NkiNY6YfCa8ibVoNIQbh4lMTkTvD5omxWi5NjgsDy?=
 =?us-ascii?Q?Is8irR4iX+iCyeRdCGYZJcTgGdvKhaQ7SsIBRkEN5YefDVzeAWAi4KPcSxcA?=
 =?us-ascii?Q?qpu3ZUnMhrWdZC8GwWO75DKP5s1Ab2+WBK3wGPNplftQkn3XvEmmLN7vAzVF?=
 =?us-ascii?Q?Bkx7G2zWf6EIt2MOTC/qrOZfyhN4C0flGkh31+Z+nTcqO9D5iTTYGLHX6Y94?=
 =?us-ascii?Q?M6yl1RfacZfO+EA3tz9i2z3CPPioEqLHZuGfiaZurSRIi0wkzmkCyfalks/A?=
 =?us-ascii?Q?aNG//RxHhF/fKH13FuySsWY0SRhPKr7y8iMCwA89NirmW2S3tMw7ceB4jVZd?=
 =?us-ascii?Q?ceFrkZRib58vpbDVbvr35SQxNvFrY++vMPuRUkPDJnDRsEpvnNopv2NPxSP5?=
 =?us-ascii?Q?SaQd37MB6gUArOiDsFBqOKSxQmSLly0PDWNA3du4MHliPxZbkKL+KQSINzvY?=
 =?us-ascii?Q?tbL/xtO6jQBq89Q4ucBGaB0tRPoa+YbyzUVb79emvXyWOvNtJgOUIJo9kLaW?=
 =?us-ascii?Q?bWm7kMitLjaxJNRX6T1yS17hTRj/UoHeCIs4Qb/uwf2dUctNmEPHIxgOO26Q?=
 =?us-ascii?Q?j6FOAKxwvYI0f3fqRCnvtPh8kPFUdV8pxbJ6If/NmGYFF5z0SDikQtmY4oha?=
 =?us-ascii?Q?H7AbYM+2g6sJyuhYRry4WcF5pQNlYqSsjEdP1fAf7hVa3fpcQ70L96xEHw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 18:30:23.1956
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83686049-813e-4e32-6dcf-08ddcba9516f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5607

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
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
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


