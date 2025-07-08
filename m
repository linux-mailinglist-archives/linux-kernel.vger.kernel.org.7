Return-Path: <linux-kernel+bounces-722442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC91AFDAD1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 00:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44146540068
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 22:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A772F25D917;
	Tue,  8 Jul 2025 22:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BboryOie"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2088.outbound.protection.outlook.com [40.107.102.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDD925B1D5;
	Tue,  8 Jul 2025 22:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752013111; cv=fail; b=uMR6tan38Xyg6nNWXUYlrXRQdsWmI+nlcSeupiEqKQXybe3JClmvTalCOIIo5Q/HHNqMFmEd3YYSik90ibPGZ7SJnoP8kprvG7DVCe0XC616oAOQ7oeSN5Xx0qE4qhwMdjmdOcN2Lw5eMrEDRMv86loho2SZXQbz1mjNS90CKdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752013111; c=relaxed/simple;
	bh=5yRoK86gJuG+A9ARqxaJT7kh9YYqb9KWoIgJoYl6f3w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pTtl/ynP635wRX5CE9wqApxnRTxBkTCF7+3NFmLJhY9ydl/q2DnSOWDt3mnsLBwJltgmXSRVggvN5v9kcRwht8+9jORXTb4JCW0O7Z05tgsOMVRyn0AgtEnAJUBW7KhLknFF0c5KNGHbnKQIKyG3+IU0CkVHDeabMQzevMGBj1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BboryOie; arc=fail smtp.client-ip=40.107.102.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O64lsrOYK4xXCPowF7rViVK6bE2xBOB9qB2blMHAmNf6wKTWIqG3nBSio9dFB4ol8p+mv/3Neb6fQukuegDBy8GfCZePrsYl7K90/mEBlQhb96/CJ4Rj6sR5QiL/u7/b1G0lJGJfx9TmF0IirT3ZMLVVn9FUrO6akik/oja+HtFiXKPy3t54FJn6e1MJRAqSguD0+s3hdsRRagVP/I5PoK8XGOqMhi1m80JGmgfOVUO2mT4yatDAFvrZh6RaGYzjM9XtKPeT8QuF4VhTGRl3Htlko+9Sx88pjOmUuRcGeZr4OtXCOg3qVCI9KMgnD8UCdQYHWhSoK8lnxeZzinltHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MMC4CD6jzKvqgN2dFL+Zj9wRztHiR7Il/5FzvQbj1fk=;
 b=B2UiDzUXx5krC3mxD5xmgUHnmoRWTBVJLsFx3dvJNAeAXoj02Ho8DLjRaRMN6AmBL8ZqhD0b3x1usUWJ8jCDW1zVLHZGxh7/MeuWafqE4n+LZPVhvfYPGUjuSdOXG6O5iAIOfYJdbC7OCeHuKffBKif7/eHNEJ0RM3t2s5xNev9BqNBJgqHBpJHogftqUYXUuTItFwbXBfl5aFRlpBir7QqCVIuWxPOMQ9w6GWmZc0TKyhRZ4287cBhI8uj9UmGrHPAxMq8pjik7WsUYZxJgedn7EngN22Bckr+ExWU9VefixPsecZd1UKM+f+WkokgAJ9W26wXwnaP0HPNYvaV8AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MMC4CD6jzKvqgN2dFL+Zj9wRztHiR7Il/5FzvQbj1fk=;
 b=BboryOieKm3+pOj+bxjig9igw2pgMojzWGueJ63z8Wqp/atwoPwtBl+wqnx36iJ4C13EkgUegrlAbvQn4Vew2iF73S+qHTEftTroUyrg7b4HGX175BzFTgzfAOPzSggZP/gLntIX3iUklyZcMrwlWW5pRO3bLoPdOshD/R3F4GI=
Received: from MW4PR04CA0197.namprd04.prod.outlook.com (2603:10b6:303:86::22)
 by PH7PR12MB6420.namprd12.prod.outlook.com (2603:10b6:510:1fc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Tue, 8 Jul
 2025 22:18:27 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:303:86:cafe::e7) by MW4PR04CA0197.outlook.office365.com
 (2603:10b6:303:86::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.20 via Frontend Transport; Tue,
 8 Jul 2025 22:18:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.20 via Frontend Transport; Tue, 8 Jul 2025 22:18:26 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Jul
 2025 17:18:23 -0500
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
Subject: [PATCH v15 03/34] x86/resctrl: Remove 'rdt_mon_features' global variable
Date: Tue, 8 Jul 2025 17:17:12 -0500
Message-ID: <46e6e0d0e6bee7485aaff6392b4fb59b12ce1208.1752013061.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|PH7PR12MB6420:EE_
X-MS-Office365-Filtering-Correlation-Id: ae1145b0-6693-4cc3-486e-08ddbe6d5c7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bwC5+L+GNPEGfKqqPw1pMOeuOvBYrr/STK8XZUDeC0oLGIvd9TRMCnOzACHQ?=
 =?us-ascii?Q?JQ1LPzOFkihjcK4GGNyYuD6l2zdaA2pulX80vtv3xhEtBcBIgJwBIO7YUEiY?=
 =?us-ascii?Q?QB7304eG2084WknwEdRhZXDlANhafUbXs7xC9rU3LiYMf9zTyV5gLv4oE4Be?=
 =?us-ascii?Q?9t9Ogju75IHg36Gus7H1u4b+3RSpQklDn0lGy7bJM/q69f+5ETCuE+MAe1NL?=
 =?us-ascii?Q?O/4CqFPiig+d+2KIUVVLPKH2LwE42fZEGldJXys/dT/2AtENwXrMV+aMZB4x?=
 =?us-ascii?Q?2NYzV6yyec8mRQfmoRvGiPC6ED8WLBjwQqrsuBRwc97tPBk/13wLN+htVo78?=
 =?us-ascii?Q?BnRt6rf57scjgEOMpudSEkV5K93YIKnCeJ7pDwxltFFHbPEzsK6nBEOKcsn9?=
 =?us-ascii?Q?EOrsMT3JZZNzs7AR3VojhPGKfd+d27fBJ53oeDqZqcYZ2n+O60P/aZgHbYlA?=
 =?us-ascii?Q?Z2b3W66ZmgFwMEKHjjgRISdCn4QcjIPtMq6bunmJf2S23rc/aZ5l0Ew/7Rbm?=
 =?us-ascii?Q?/uazjlb6fpoRYsg28cypUyk6Zl2dZdlohWCWU7F91/DNa9d0/frYB08D2AQY?=
 =?us-ascii?Q?bDHWTR+vBKdZlULu/S6ng6WSvw3VwpRW/9R+WQSbHl4OtVKpig+YiA+1PNCu?=
 =?us-ascii?Q?wG6llVrGNv95Lggk/35ElZFC47cqSyJS2IETtowSMgAOUU943nf9iiKFrqbV?=
 =?us-ascii?Q?qf8HH9nHu55pOw0zGx+CZyGZjtHGLPMYI8lHyPdvujvy8basgq6ZF5IjrLCN?=
 =?us-ascii?Q?9mFY5HQWUFxtjgSxSEVLNzd6e7m6woaQktb5hXLCZQSivfUmZ7QtsGMcFDpz?=
 =?us-ascii?Q?uB0P+tuj1HpJZQxQK0rb7tql2JREvH8GtYs++SehOBzKjXFpPGr+TxfE6nfs?=
 =?us-ascii?Q?Qfvjd08+r9O6JzUVXfcFj/nwQ0wWska9yEFTZEUrxxw8aMknzWVDcmLRiERi?=
 =?us-ascii?Q?pxaVA5STtRqw5rzeIJqx32f/73x2ZV0fjRidWDOp4DwjRx9FSHx9b8LEG+wt?=
 =?us-ascii?Q?QlNZADYWOdN0jk5oMqL8wIA5ZsD+y+ScXhXohPKPGvCd2xNz/JAlE8aOA8T7?=
 =?us-ascii?Q?CtIgVKJpzkvcQtvirnN1Rfsal+HFMiG9HwE0jVbhlwfwMWYSzHet9qua3Bcy?=
 =?us-ascii?Q?/81+HvEWmhgdVHHQRljStYr/Gqme1i7bSQt/2nhycVVeZoLs9z+6gixUGKsf?=
 =?us-ascii?Q?n3346EyAD7WfRmqmlEfpEBTr7iKh6GwLEsEsstJhoY4l8quPdauAULMeoSnN?=
 =?us-ascii?Q?GpgKmFNR/SNKbQujIXokgmFXBexMDDAFhBypdYe0xZXLaHFgtQJKE+5d+TAV?=
 =?us-ascii?Q?VDS6+OPLfbF41kbKpFAsfLBT3ORaY3XDOlleGH0+Ok4xwBiuRAJ/0kVuHML/?=
 =?us-ascii?Q?8FswK5ITv2M7aNn0wDQvUyLRJITSqTPJ0/UH4J8DHy02WLhyTDmRY8BuOGGH?=
 =?us-ascii?Q?iSGf+RmlUrGeejRlcEGGIYuEbr9H+fDJUq0lbE4jsfcRDHrFAo1/n52PSeq4?=
 =?us-ascii?Q?qoT9XDxke68JyujMm7XoqhYEU6QtuxPomgR27ACjW+9qnytyCXXn9s0yMQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 22:18:26.7427
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae1145b0-6693-4cc3-486e-08ddbe6d5c7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6420

From: Tony Luck <tony.luck@intel.com>

rdt_mon_features is used as a bitmask of enabled monitor events. A monitor
event's status is now maintained in mon_evt::enabled with all monitor
events' mon_evt structures found in the filesystem's mon_event_all[] array.

Remove the remaining uses of rdt_mon_features.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
v15: Picked up Tony's tree.
     rdt-aet-v5.5 branch of git://git.kernel.org/pub/scm/linux/kernel/git/aegl/linux.git
     After Reinette's comment on previous version.
     https://lore.kernel.org/lkml/e9eb906f-d463-4c1e-9e15-5ed795fe5366@intel.com/
     https://lore.kernel.org/lkml/b761e6ec-a874-4d06-8437-a3a717a91abb@intel.com/

v14: This is Tony's work. This is part of Tony's telemetry series.
     https://lore.kernel.org/lkml/20250521225049.132551-1-tony.luck@intel.com/

     Tony made special update for me to include in this series.
     https://lore.kernel.org/lkml/20250609162139.91651-1-tony.luck@intel.com/.
---
 arch/x86/include/asm/resctrl.h        | 1 -
 arch/x86/kernel/cpu/resctrl/core.c    | 9 +++++----
 arch/x86/kernel/cpu/resctrl/monitor.c | 5 -----
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
index b1dd5d6b87db..575f8408a9e7 100644
--- a/arch/x86/include/asm/resctrl.h
+++ b/arch/x86/include/asm/resctrl.h
@@ -44,7 +44,6 @@ DECLARE_PER_CPU(struct resctrl_pqr_state, pqr_state);
 
 extern bool rdt_alloc_capable;
 extern bool rdt_mon_capable;
-extern unsigned int rdt_mon_features;
 
 DECLARE_STATIC_KEY_FALSE(rdt_enable_key);
 DECLARE_STATIC_KEY_FALSE(rdt_alloc_enable_key);
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 1a319ce9328c..5d14f9a14eda 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -863,21 +863,22 @@ static __init bool get_rdt_alloc_resources(void)
 static __init bool get_rdt_mon_resources(void)
 {
 	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+	bool ret = false;
 
 	if (rdt_cpu_has(X86_FEATURE_CQM_OCCUP_LLC)) {
 		resctrl_enable_mon_event(QOS_L3_OCCUP_EVENT_ID);
-		rdt_mon_features |= (1 << QOS_L3_OCCUP_EVENT_ID);
+		ret = true;
 	}
 	if (rdt_cpu_has(X86_FEATURE_CQM_MBM_TOTAL)) {
 		resctrl_enable_mon_event(QOS_L3_MBM_TOTAL_EVENT_ID);
-		rdt_mon_features |= (1 << QOS_L3_MBM_TOTAL_EVENT_ID);
+		ret = true;
 	}
 	if (rdt_cpu_has(X86_FEATURE_CQM_MBM_LOCAL)) {
 		resctrl_enable_mon_event(QOS_L3_MBM_LOCAL_EVENT_ID);
-		rdt_mon_features |= (1 << QOS_L3_MBM_LOCAL_EVENT_ID);
+		ret = true;
 	}
 
-	if (!rdt_mon_features)
+	if (!ret)
 		return false;
 
 	return !rdt_get_mon_l3_config(r);
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 61d38517e2bf..07f8ab097cbe 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -31,11 +31,6 @@
  */
 bool rdt_mon_capable;
 
-/*
- * Global to indicate which monitoring events are enabled.
- */
-unsigned int rdt_mon_features;
-
 #define CF(cf)	((unsigned long)(1048576 * (cf) + 0.5))
 
 static int snc_nodes_per_l3_cache = 1;
-- 
2.34.1


