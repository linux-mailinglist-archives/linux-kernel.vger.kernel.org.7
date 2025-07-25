Return-Path: <linux-kernel+bounces-746183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA9BB123F9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF3C6AC2A71
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661F4254B09;
	Fri, 25 Jul 2025 18:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ktdHbfRw"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CB024C66F;
	Fri, 25 Jul 2025 18:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753468426; cv=fail; b=AHoLw0xO6f8uTm2/sU+QtR0txFc4CtJcbw1NJyLupAI6qlwqsGQSqUk0TGVa1iaAzoAPnuPXvcME3TZ4v6+o2Q2wO+xgBvWt8xriAHr1g33z+K1nThNpQYbJCMkXlx2w74akJL/Hhk/TRjvIGVD1jY0qzv7SemQY8YLuHy0hBgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753468426; c=relaxed/simple;
	bh=kPuAWnadL2ztYRcSWyosPg+ssT34+hFBpgbt20qxhpI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sHq00fZljAgAf/Lnmz3v+j6nLUlkEwloIaRD1+FGV0/PRPGpCt4/umS2nYyBJSzp/tQnUJsWJMY8aZhBRih8J+UIF6+U0jyQX2rwJ6e+NcrCUdS2m3H/9Xo8/VGaBp0DOqB7abIqWFikDozjQKNH3dg5xBWDCT1PvGBH2/aqqtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ktdHbfRw; arc=fail smtp.client-ip=40.107.92.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UTg8HbOmubWzPNo21L8/EFrUa+heXpS0rSTTj5GU8iVeTTEcxEHSDv32r/0n86QU/Y9Sl+LQOT8AfaOWqQpu1k4ZC9WyGKMx3+EFPA5N+5RuburyzMv1U7EDYd7Uo/kGE8+NogF/xeYC1m4mnffwTQm6pKMIWep0w4cVgBfD/2JRsGg+7ceJ7aCYf+AiGneqDnUWWmWkjRzgmhMqssomqJe7Rbm5j1u6wAEgpKB4IJZlfaSYaDYslVcXJlg0swLDr+E0x2+Io5N9SOpehYRQ4DpqEMEf18175z1/wsqjHYJXn2jmhG7xqnYH4xd5Oi/7oR6E146nBeHE9/imG8Hf3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7e/W5Ai75uYxciNIqix+0uhd70zevITYNySCFH+8myM=;
 b=XgNB0N8pAScD9sfTVZ7HTMk7NDZiWaISp1nrjGxZ6eqPsWkKKGcNbzWFp9TNYz8m5mAALCq9R8ysNXTr1P6lfoG5xh2YyKuLzO0hByHNgr/Rar7kBCuPri76Zow3wKybIQ2KhgDSexUZUjEGMgK7mhwUri6VwJKeHY6teH7E9bwLp7g8Ku8ek09LO2ebkmX6wqK4b6Y+QGt49OxaTzkLynjXjyj/30vl4/V9mYPD0flpbqU9F5QBhM6jzpnpAXdU0P5Lhdy2tOXXgtAdFcfyhqEMjWA4zHCmz+BqbN/WZNq0pFSqWoQqGR3EUJ6tjQZbFORUyymDxu7N+CDI+kNHyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7e/W5Ai75uYxciNIqix+0uhd70zevITYNySCFH+8myM=;
 b=ktdHbfRwBSFOMwSnd8uHcgpxst066tCLTUjhaDkTu7FTzAPQpFdHaPbq0SVaVwbUkEv1BNjYkvyFQ3MDLsu76QlE1FTygitCEcyMDhIFvQLGKAFgalUUSFsbLCFALQtA+cFjVIQMZAmWQupLD6gTjtGekEusPn8YF+ZJO4bpSoE=
Received: from DS7PR03CA0319.namprd03.prod.outlook.com (2603:10b6:8:2b::27) by
 IA0PR12MB8840.namprd12.prod.outlook.com (2603:10b6:208:490::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Fri, 25 Jul
 2025 18:33:41 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:8:2b:cafe::70) by DS7PR03CA0319.outlook.office365.com
 (2603:10b6:8:2b::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.23 via Frontend Transport; Fri,
 25 Jul 2025 18:33:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Fri, 25 Jul 2025 18:33:41 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Jul
 2025 13:33:38 -0500
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
Subject: [PATCH v16 20/34] fs/resctrl: Introduce counter ID read, reset calls in mbm_event mode
Date: Fri, 25 Jul 2025 13:29:39 -0500
Message-ID: <518b133429018f8b2f51055cfc2342536df98b84.1753467772.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|IA0PR12MB8840:EE_
X-MS-Office365-Filtering-Correlation-Id: ddef93ba-f981-4dda-3eee-08ddcba9c779
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vENrwaOX7OkBjyEzVyXNV3EBtdYCo1i8Atk8ATQYm1SXRv5EzoclgwLie/vv?=
 =?us-ascii?Q?x6vwsBLQZ5uUvrvzrJAnTKfY7j24iN92sLR/QDNDGyZnRB3SWP7cFMoDGLFu?=
 =?us-ascii?Q?HfNcF3Zeq9d/bdqCRHHs32kLSn+HX8Rp7zyozLYDYqPLKt5QQQLsAyYJAfJq?=
 =?us-ascii?Q?6cd5ptGuhfjBCl4iPWCn2FG3JsJSkKRp4rPBTLRh8Vs8H+OntYEBbrg15Ofs?=
 =?us-ascii?Q?cM7saVuIm7iuGSG7FLaXpEtAmsDEnK29sVZeBicMQn2uOp7pIW4+vvZGV+EW?=
 =?us-ascii?Q?X9zsp1/WPZsvSKg/TIyL9NLPhpYD81/rExb2B/g8WZ0c21f9lJsZ4OnHm2ft?=
 =?us-ascii?Q?plSTZNVICbB9OYTb4S4yqmI4zy5Ni16SWioj98dCfeMfN230H8OJbYj8tPag?=
 =?us-ascii?Q?W/ueiS9s2nANl4REbI7Cf9Kl8Yj+m2k+BEmtvaWuYlw+oT0vAph5hZFDhbvl?=
 =?us-ascii?Q?Gn/YBuAqoGmN+zU/qJyHBFCrfim2Q6Qetkeyr5zPOdb8DHENJgX4vpIQL3Te?=
 =?us-ascii?Q?eSFgLbxv4MfXDkkKjsoaKInfhVmMH+ickAuISAFjth+yZ0f/Dt3KpSvwJjw7?=
 =?us-ascii?Q?tgm91aUTzVPsOnO7PnS5n03oRKEa0X8OPy1Q/c9m08DM3YemXJo075lw2H47?=
 =?us-ascii?Q?E8QOJhkR5n9moK3Bbh5zJjFBXt4PzbypotKMTNPisQw2FdK8rrSP+XqfoeuZ?=
 =?us-ascii?Q?ko7YzJQoBMZvtAChuJV+CQBhVt49GIbhqIwsn3o0pb8tLLM8n5ZSgi5n7Q2J?=
 =?us-ascii?Q?91HFQ8KHmMk/W2YPc2kxeahjc+MGQK0/ozwdJj1UpG1xCXwi9cSEVYTDpN0P?=
 =?us-ascii?Q?+vO172zFgrSJfnWmighDgfXZildeHe37W7tVupq4sxktoS2y9Lc6Ot+7sE/j?=
 =?us-ascii?Q?/QV7o9toostgPno6y2DKAkf3vszN4hs2oKe2ZAmdkC64+3WmcL3blt80OfTe?=
 =?us-ascii?Q?HEl8xs/RbwN1sKO7kMof960Xf2mAL/5HTudOmQp31C5J+hJpPWUM8htr8QFX?=
 =?us-ascii?Q?RoVNj2ld+p2MHkMSrU1oS7X/AGA+paYIhcgbVf2jKdLsotDN0G7pVl38EdRo?=
 =?us-ascii?Q?3wU1S5DlGrVYO8pTElv/jOL7/tKqBBOydRDpN0FkkuPY2eKfE5kzZ7UsU1fh?=
 =?us-ascii?Q?dNCT9CCltmRUy9A4Vkvl8wYEXxn157iKL3vXkfxUqzMahLOmvsq4JHVd/B+c?=
 =?us-ascii?Q?kbaAU9Y58z8WsvmsjE2gWaGhqmvIktrAmArFrN94um7gA2riOGotnoqv7Spo?=
 =?us-ascii?Q?eqjBP1lfeQSA7exoHXwvX8Xcn2UzYs4H1FWZnCBRozU5+9Gyzc3fkgJS5fp8?=
 =?us-ascii?Q?OU3ZGBxrA1iM09fof6Y4OMEF+Vxa6Gdi4O2pWWy6igbSvm2orPaQQa/4Vv8T?=
 =?us-ascii?Q?BTLHReVvuPYwvQQwbSPwy8Ljq1pOwNQsFtWq4xOr1GkK56m8mIfmxbeW6FBu?=
 =?us-ascii?Q?qPvQ+8bOxyahbZucbuRRmHSqTzqUpRbC6kdUBd0aXOlBbLlj3DbibY6hS4Co?=
 =?us-ascii?Q?xNMmTRmlmlMyJulCi62ldiliKRZm7N6IGGaddveODzp+XEQeE1QgyfiaEg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 18:33:41.2121
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddef93ba-f981-4dda-3eee-08ddcba9c779
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8840

When supported, "mbm_event" counter assignment mode allows users to assign
a hardware counter to an RMID, event pair and monitor the bandwidth usage
as long as it is assigned. The hardware continues to track the assigned
counter until it is explicitly unassigned by the user.

Introduce the architecture calls resctrl_arch_cntr_read() and
resctrl_arch_reset_cntr() to read and reset event counters when "mbm_event"
mode is supported. Function names are chosen to match existing
resctrl_arch_rmid_read() and resctrl_arch_reset_rmid().

Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v16: Updated the changelog.
     Removed lots of copied and unnecessary text from resctrl.h.
     Also removed references to LLC occupancy.
     Removed arch_mon_ctx from resctrl_arch_cntr_read().

v15: New patch to add arch calls resctrl_arch_cntr_read() and resctrl_arch_reset_cntr()
     with mbm_event mode.
     https://lore.kernel.org/lkml/b4b14670-9cb0-4f65-abd5-39db996e8da9@intel.com/
---
 include/linux/resctrl.h | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 50e38445183a..4d37827121a6 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -613,6 +613,44 @@ void resctrl_arch_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
 			      enum resctrl_event_id evtid, u32 rmid, u32 closid,
 			      u32 cntr_id, bool assign);
 
+/**
+ * resctrl_arch_cntr_read() - Read the event data corresponding to the counter ID
+ *			      assigned to the RMID, event pair for this resource
+ *			      and domain.
+ * @r:			Resource that the counter should be read from.
+ * @d:			Domain that the counter should be read from.
+ * @closid:		CLOSID that matches the RMID.
+ * @rmid:		RMID used for counter ID assignment.
+ * @cntr_id:		The counter ID whose event data should be read. Valid when
+ *			"mbm_event" mode is enabled and @eventid is MBM event.
+ * @eventid:		eventid used for counter ID assignment, such as
+ *			QOS_L3_MBM_TOTAL_EVENT_ID or QOS_L3_MBM_LOCAL_EVENT_ID.
+ * @val:		Result of the counter read in bytes.
+ *
+ * Return:
+ * 0 on success, or -EIO, -EINVAL etc on error.
+ */
+int resctrl_arch_cntr_read(struct rdt_resource *r, struct rdt_mon_domain *d,
+			   u32 closid, u32 rmid, int cntr_id,
+			   enum resctrl_event_id eventid, u64 *val);
+
+/**
+ * resctrl_arch_reset_cntr() - Reset any private state associated with counter ID.
+ * @r:		The domain's resource.
+ * @d:		The counter ID's domain.
+ * @closid:	CLOSID that matches the RMID.
+ * @rmid:	RMID used for counter ID assignment.
+ * @cntr_id:	The counter ID whose event data should be reset. Valid when
+ *		"mbm_event" mode is enabled and @eventid is MBM event.
+ * @eventid:	eventid used for counter ID assignment, such as
+ *		QOS_L3_MBM_TOTAL_EVENT_ID or QOS_L3_MBM_LOCAL_EVENT_ID.
+ *
+ * This can be called from any CPU.
+ */
+void resctrl_arch_reset_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
+			     u32 closid, u32 rmid, int cntr_id,
+			     enum resctrl_event_id eventid);
+
 extern unsigned int resctrl_rmid_realloc_threshold;
 extern unsigned int resctrl_rmid_realloc_limit;
 
-- 
2.34.1


