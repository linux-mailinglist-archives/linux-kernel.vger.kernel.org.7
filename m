Return-Path: <linux-kernel+bounces-722459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9929AFDAF8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 00:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09E663BECAF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 22:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B83125A355;
	Tue,  8 Jul 2025 22:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="J9YHSksY"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EF825B1DC;
	Tue,  8 Jul 2025 22:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752013257; cv=fail; b=Wkt/ZwH9DQSnUPPNmtMQHdKtf9qdE7/J9Avi5BkxXYimB/WlTg+xm++dHmEtjcVnvx7Vw/1yAdx8vQYEl6UJeza4EieFK8Ns180Rjj/4DTc6Tu4e9Icea1i7NzgExs9v6qCPimHoMJ05qwNflbcn/4WyffHtMBqfn8w/O2pr2CQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752013257; c=relaxed/simple;
	bh=6d44kpyhSKQc/7p2FWvbF1FvP/rBW9t7zic7a4OXtuY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uxGyzE8rSoHiFu2K4U+DP3pjKR9V8ORFPss0+yq14EYX91nKOWlJr4icvWO9QHYcoSu4v51VORWWHWV1MawkXrKapdS7oaotGsBHo6HBYE7MQUGBKvnW9wHf7vdWnEQB/cGcByMZMukoAiFl2nmvcjRF1/EBsGjFGBfVaVYXKjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=J9YHSksY; arc=fail smtp.client-ip=40.107.236.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q/AVPT8d6/CojyTnLSC7ALGqeOjos5yV3PMiTYijcmpkTARHO7D6MMk9oxkE2offuF1fGdBsKW3OZG/AqlmDqMqyt/YRItlyCkgEMwEpXpjcVYx9DUrteqDx4YpMfhkyV5pYD98Y6i4cpubWHuSbjTXzxfmBU2POkd/MkaXtazHe+2L9d8MexWx+D07JFEY8wdF++UPtZ24+jubP32Srak8JYkB7wkMrS3vC0IbEXm8e67ABw1Jj1z+Xg/FjZ3B92tCIkmgxmJMDyGRY06pBHsPFvVKHCNyuDLtOuwlNCoiTSulI7AYfN/JLSxdGjDPMWyoaia4yHpQUxDiyiiKnuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OXb1NpwNDEaU4hEjPdGGN2RImn8RDR5azq8a5NP7PWQ=;
 b=Ou+WH4jzB5wZI4JwGVlzORtuIpSdD6P6C1TukNIlAqKMT1VVdZUFJDgkehI8uoIXlRSc9GFej/E71k4XR/1yaD1C6zOswJfPnyMlRpdmn+rQopR2lvaqDaBqrXaPgxzwv+hec7Wgq1IZ38EM2JScIvfKFQ9DlCnL//iioMQkImlvJ/h216+XaGlkWJphEsNxp0UGjPCoujK3UkPFqoH0bn7V2q1OqFwA+mFCy45u5hLOaF6A/cSkryfNkxGhNLr9CCH+U/x2m07+J5Hk09kINfwtoLV4ThM1qUvMX0qhV3IzyVZQWif3uUrRQVULRXNGIQScVI6dvBjjWDksEcMaAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OXb1NpwNDEaU4hEjPdGGN2RImn8RDR5azq8a5NP7PWQ=;
 b=J9YHSksYxp6SKdAVQ+ECi8SsBTKYrkOstqnpsilogC/fLam/4j49vm1f59bSbyQJP50AfxSWjH114vj1idVtRKVARBSdSq/k/w/ZsVu3VG5MtuC+8pvTJSX3eQv6RBw+ZQtyv2KUvj+c4GhCNsQxP6kWQjFR441MzOMgyCIWScQ=
Received: from MW4PR04CA0181.namprd04.prod.outlook.com (2603:10b6:303:86::6)
 by LV2PR12MB5893.namprd12.prod.outlook.com (2603:10b6:408:175::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Tue, 8 Jul
 2025 22:20:46 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:303:86:cafe::ef) by MW4PR04CA0181.outlook.office365.com
 (2603:10b6:303:86::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.21 via Frontend Transport; Tue,
 8 Jul 2025 22:20:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.20 via Frontend Transport; Tue, 8 Jul 2025 22:20:45 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Jul
 2025 17:20:43 -0500
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
Subject: [PATCH v15 19/34] fs/resctrl: Pass struct rdtgroup instead of individual members
Date: Tue, 8 Jul 2025 17:17:28 -0500
Message-ID: <5b017f308d3bff1b746c8904d0dfde0c11706fc1.1752013061.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1752013061.git.babu.moger@amd.com>
References: <cover.1752013061.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|LV2PR12MB5893:EE_
X-MS-Office365-Filtering-Correlation-Id: d89f998f-e884-4cee-5d17-08ddbe6daf5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xTSZAGXAVSzMBzzabHPRpGFcLIMPOQ26BUXhaVg5iJgU7GuTsEL7ly6nQ4h7?=
 =?us-ascii?Q?Zrt5Mn0BmR5gJ1OM71hHp2UqGuAT/Hq02ag/AbpOCe4GP81+n1fTlCIZLX86?=
 =?us-ascii?Q?kzc9TM8K5BwJxsSw0V37y5xN9PM+eWyh4p7ppAmJm+zHjB4+m0IT0dIpBRwe?=
 =?us-ascii?Q?iv6dw020AP7etgQWGmv830wesoU5mp4TqDkoXWcbpAjiF9dmBS3g/LucxdVV?=
 =?us-ascii?Q?vg2C1gqYR4my3JlVqVCs1dSy7EAzWOd/+IhmIz7pADIyr0lTToei4YjFhcik?=
 =?us-ascii?Q?JnLAelwLEFF+A8/YBUubSe2B9R8QeUNnLdQqH1v/oEutEp3nvXYpSD6QLb/B?=
 =?us-ascii?Q?sEoosJVQPGVlOQL73Y+GucuAwnqomK5v8spS5t9qZpYQJpkwv6J1JymNDfia?=
 =?us-ascii?Q?hVrj0uZ0cy8/6gDaGY2LUsZQY7CXgrwu0F6vdqUFNh56dY38cVU1qc4CsVV+?=
 =?us-ascii?Q?o7DfQdhg3RxtDK25mr11Pd+Psj6P5vOmEqZUvkGU5yoCyVlHd3W6ImFuuJCR?=
 =?us-ascii?Q?GJzgpX2/mUvIdDc6KZX9SV/FnruBsYqe+jpeellp+uDKqbKmYYGkClQFqQTY?=
 =?us-ascii?Q?6QmIgQjZYxJ9ri/42h0mnXm77n628ee7cnCybLO7FSoSp2XUo+wtUN1N6hFq?=
 =?us-ascii?Q?cqKJUPAKfrbKKJGm2DADWAwa8rf6a7X1ECqJOlc/XLtZMVk+ajLQKByENbxH?=
 =?us-ascii?Q?4PDtvmsFN7gkWhZVdi1thaMp09+tNNQJXoBkmRl/IyTKDHbR9yegZPhSL6+k?=
 =?us-ascii?Q?Jf2whEFLMsLJg6o7bODD0Nd3PfRnrObJXjYdIBNjSkmAKh0hNtJrZ8CdS3F7?=
 =?us-ascii?Q?lr0Ur8rQhWOEDxIvDrqd3gNj+Bi3Z7xWSYS5fpYlcNhqtULhxWApQumIBuon?=
 =?us-ascii?Q?rtU58utx8Z3dtZAvYHzYwBLAeIbaERocQlS7hF1EcHSbrlAGrfUqlNZCHFQs?=
 =?us-ascii?Q?bywe9C2P8maGWnDVURRh6LPz8KLbkz7Pl73xbsVq1qCfwCYkkmsgx0X1EKW6?=
 =?us-ascii?Q?RD+mSpzmImcvitTNnLy9FrLVzlmjA7AkyZd6V4mF9QLKPuIrEDiuNFYq1xLq?=
 =?us-ascii?Q?QMxfxGJA3poLHEwxIdm+jv26dBtLvS65gG+OK+WGqr3rt6jofCi5MdaCC9mF?=
 =?us-ascii?Q?asvZoGs7LX/HonPdnA7J5/UBSkS/wQxc9fVcF64+VpFsBJAJLQhDGbehcC7U?=
 =?us-ascii?Q?3oLW3+hTzEY63ABNkTPwy/bGoarekaqDop4s584gp+A5gr1MZZFuZkV7SQtk?=
 =?us-ascii?Q?jJmCz32Fy9cGfKxbZ1CaHqrTv1r07XsDla3FwXwLCuyq+/H35uDMdddLH8Zh?=
 =?us-ascii?Q?U4/Os+V1Gxtg9s/dhQ9/lZC/EEmrlSHnpuQYsmIIN1eCklwVz+xHAa++bcRu?=
 =?us-ascii?Q?r7TG7np7IzySDsMjx//KxMm+VixVkmxprZi5R9qtgagCFI3xPFovAKWMWKdH?=
 =?us-ascii?Q?xePK3TotDlpNvCSMPqVJfdEsPYIA4E4O67OEf1Urvfg6GJw2vkXi3QD0ty9i?=
 =?us-ascii?Q?QQQjjIBNHVvDuGiDivHth8AZaNDA9rb0zCbi?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 22:20:45.8109
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d89f998f-e884-4cee-5d17-08ddbe6daf5f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5893

Reading monitoring data for a monitoring group requires both the RMID and
CLOSID. The RMID and CLOSID are members of struct rdtgroup but passed
separately to several functions involved in retrieving event data.

When "mbm_event" counter assignment mode is enabled, a counter ID is
required to read event data. The counter ID is obtained through
mbm_cntr_get(), which expects a struct rdtgroup pointer.

Provide a pointer to the struct rdtgroup as parameter to functions involved
in retrieving event data to simplify access to RMID, CLOSID, and counter
ID.

Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v15: Rephrased the changelog. Thanks to Reinette.

v14: Few text update to commit log.

v13: New patch to pass the entire struct rdtgroup to __mon_event_count(),
     mbm_update(), and related functions.
---
 fs/resctrl/monitor.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index 6c0410cf0195..73f507942b6d 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -356,9 +356,11 @@ static struct mbm_state *get_mbm_state(struct rdt_mon_domain *d, u32 closid,
 	return state ? &state[idx] : NULL;
 }
 
-static int __mon_event_count(u32 closid, u32 rmid, struct rmid_read *rr)
+static int __mon_event_count(struct rdtgroup *rdtgrp, struct rmid_read *rr)
 {
 	int cpu = smp_processor_id();
+	u32 closid = rdtgrp->closid;
+	u32 rmid = rdtgrp->mon.rmid;
 	struct rdt_mon_domain *d;
 	struct cacheinfo *ci;
 	struct mbm_state *m;
@@ -429,9 +431,11 @@ static int __mon_event_count(u32 closid, u32 rmid, struct rmid_read *rr)
  * __mon_event_count() is compared with the chunks value from the previous
  * invocation. This must be called once per second to maintain values in MBps.
  */
-static void mbm_bw_count(u32 closid, u32 rmid, struct rmid_read *rr)
+static void mbm_bw_count(struct rdtgroup *rdtgrp, struct rmid_read *rr)
 {
 	u64 cur_bw, bytes, cur_bytes;
+	u32 closid = rdtgrp->closid;
+	u32 rmid = rdtgrp->mon.rmid;
 	struct mbm_state *m;
 
 	m = get_mbm_state(rr->d, closid, rmid, rr->evtid);
@@ -460,7 +464,7 @@ void mon_event_count(void *info)
 
 	rdtgrp = rr->rgrp;
 
-	ret = __mon_event_count(rdtgrp->closid, rdtgrp->mon.rmid, rr);
+	ret = __mon_event_count(rdtgrp, rr);
 
 	/*
 	 * For Ctrl groups read data from child monitor groups and
@@ -471,8 +475,7 @@ void mon_event_count(void *info)
 
 	if (rdtgrp->type == RDTCTRL_GROUP) {
 		list_for_each_entry(entry, head, mon.crdtgrp_list) {
-			if (__mon_event_count(entry->closid, entry->mon.rmid,
-					      rr) == 0)
+			if (__mon_event_count(entry, rr) == 0)
 				ret = 0;
 		}
 	}
@@ -603,7 +606,7 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_mon_domain *dom_mbm)
 }
 
 static void mbm_update_one_event(struct rdt_resource *r, struct rdt_mon_domain *d,
-				 u32 closid, u32 rmid, enum resctrl_event_id evtid)
+				 struct rdtgroup *rdtgrp, enum resctrl_event_id evtid)
 {
 	struct rmid_read rr = {0};
 
@@ -617,30 +620,30 @@ static void mbm_update_one_event(struct rdt_resource *r, struct rdt_mon_domain *
 		return;
 	}
 
-	__mon_event_count(closid, rmid, &rr);
+	__mon_event_count(rdtgrp, &rr);
 
 	/*
 	 * If the software controller is enabled, compute the
 	 * bandwidth for this event id.
 	 */
 	if (is_mba_sc(NULL))
-		mbm_bw_count(closid, rmid, &rr);
+		mbm_bw_count(rdtgrp, &rr);
 
 	resctrl_arch_mon_ctx_free(rr.r, rr.evtid, rr.arch_mon_ctx);
 }
 
 static void mbm_update(struct rdt_resource *r, struct rdt_mon_domain *d,
-		       u32 closid, u32 rmid)
+		       struct rdtgroup *rdtgrp)
 {
 	/*
 	 * This is protected from concurrent reads from user as both
 	 * the user and overflow handler hold the global mutex.
 	 */
 	if (resctrl_is_mon_event_enabled(QOS_L3_MBM_TOTAL_EVENT_ID))
-		mbm_update_one_event(r, d, closid, rmid, QOS_L3_MBM_TOTAL_EVENT_ID);
+		mbm_update_one_event(r, d, rdtgrp, QOS_L3_MBM_TOTAL_EVENT_ID);
 
 	if (resctrl_is_mon_event_enabled(QOS_L3_MBM_LOCAL_EVENT_ID))
-		mbm_update_one_event(r, d, closid, rmid, QOS_L3_MBM_LOCAL_EVENT_ID);
+		mbm_update_one_event(r, d, rdtgrp, QOS_L3_MBM_LOCAL_EVENT_ID);
 }
 
 /*
@@ -713,11 +716,11 @@ void mbm_handle_overflow(struct work_struct *work)
 	d = container_of(work, struct rdt_mon_domain, mbm_over.work);
 
 	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
-		mbm_update(r, d, prgrp->closid, prgrp->mon.rmid);
+		mbm_update(r, d, prgrp);
 
 		head = &prgrp->mon.crdtgrp_list;
 		list_for_each_entry(crgrp, head, mon.crdtgrp_list)
-			mbm_update(r, d, crgrp->closid, crgrp->mon.rmid);
+			mbm_update(r, d, crgrp);
 
 		if (is_mba_sc(NULL))
 			update_mba_bw(prgrp, d);
-- 
2.34.1


