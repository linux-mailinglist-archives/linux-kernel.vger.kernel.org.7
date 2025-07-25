Return-Path: <linux-kernel+bounces-745693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3F4B11D21
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 13:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67F1E175F22
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 11:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2832D9EE3;
	Fri, 25 Jul 2025 11:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VfTTbW0o"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2089.outbound.protection.outlook.com [40.107.102.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476AA2E4247
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 11:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753441665; cv=fail; b=nuDuaUnBOq4MnCDmA9e1EsYZ7DHQjtCWX9NCJW57GuAhp2k0lzXzYvEZqqgNWeOpzkWogl1lvGr/E1ilFa5PayyUqwui91t9QD/AXqomoVdmK3r4N8QIUUPYBXZk3vVUnHVLf8upeJGkAKHbbLTh67I2/llejKiRSp9MO5cnx18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753441665; c=relaxed/simple;
	bh=mnujbUMpu+LYfKA4U4eJOO5r6pJglY2Z+zaC+90YhgE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pai9HRRIQzbX7dvJEkDlHQfudu8+QZOthwRbVheT8f/+FXoveaczUbZgrkA6/zSRhpVVmrbGdXfRC8lKm/YlfaGCa5UUD27cbmEMR58Fu8kIuwJz5Jwok0pPT7KrcJOBcRMdOJ0Hobmc3GGX7hOP8FLo47HItzie/QTuqCWfcPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VfTTbW0o; arc=fail smtp.client-ip=40.107.102.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bHXUk+ZxCD1VeTXZjGmtjeD8TwxoI3XKLSFg7bRD9iGnn246xxPKNAikFlYifT6f56VIMToj61d090gdzDyZcKJHot+b0H3HK6Xhrx8CZf617ZcX3d7EmQbvYx3PyGU0V4WBOgiufwqjBo/1Mgbj/y3yEZDA9TEXqWEl7m8qlUy/k/rXWrSORW9O1LW8QnCYRQcYONbxj5vDzb0xvv5utRSnkhQGM/S29WbpMXiHdBrk0DmkfDwH0Fwb8CzP3mz7iDbRcJy/dU96s4DMt+d6KwFJ6Bq7QOx1f48mnHfEe0CQa7woChMQJjDgBVQay/Gm+0pq89yTl4PymxJojjrzFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1jC1EMC8huNsPA3EgX23hLei2Oqh2HUrFMdXUYw7atc=;
 b=jAQoKnzwFHjl/HwcdbWrwrFdfpEhxDx9C0GNuKAvjfQ64jig6OcBdOrYgatF/EM+Z0RjyrVE3VYRNACMoj1unfrhIlV8qS/hsUIBVZIIkfO6Kp64Z/Udav1cwPALstNzmoItwxobuuyoKBLjcqnhyfOG/Cv3d2QAXhkXSIkL6GDMYVEQ44LZHo/6O8NrjGv/hwwgLUKgsuMJLn9lQiY4VHDE9rhvjAWSEgq+FOHrdasuxt+GJ4a6Bj6oVPbGGBm+yJ6EqOyWySfb9juKGEP6AXCtzfrmUK+0DzvBpxoBhNIDPaI+DQaTGCBCrB/+gcht7gQd2HvTLhpVfDMw0CVdxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1jC1EMC8huNsPA3EgX23hLei2Oqh2HUrFMdXUYw7atc=;
 b=VfTTbW0oMQFqjs3YqVe7YXxgXpa/znKrhXI025oRYcbD6MNtLfVtQQQMBbah0hPScAxnW64MnerOuf3wqne+rkcpRR72qm1VtcxYJrhjnHDaMJmNichxoddNReUw3heMctA/SFI7ket61CB0JDCbJk2MZZsCV4semPO4TY9Nh+8=
Received: from CY5PR17CA0051.namprd17.prod.outlook.com (2603:10b6:930:12::6)
 by CH3PR12MB8283.namprd12.prod.outlook.com (2603:10b6:610:12a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Fri, 25 Jul
 2025 11:07:38 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:930:12:cafe::9a) by CY5PR17CA0051.outlook.office365.com
 (2603:10b6:930:12::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.23 via Frontend Transport; Fri,
 25 Jul 2025 11:07:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Fri, 25 Jul 2025 11:07:38 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Jul
 2025 06:07:32 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>
CC: Naveen rao <naveen.rao@amd.com>, Sairaj Kodilkar <sarunkod@amd.com>, "H.
 Peter Anvin" <hpa@zytor.com>, "Peter Zijlstra (Intel)"
	<peterz@infradead.org>, "Xin Li (Intel)" <xin@zytor.com>, Pawan Gupta
	<pawan.kumar.gupta@linux.intel.com>, <linux-kernel@vger.kernel.org>, "Mario
 Limonciello" <mario.limonciello@amd.com>, "Gautham R. Shenoy"
	<gautham.shenoy@amd.com>, Babu Moger <babu.moger@amd.com>, "Suravee
 Suthikulpanit" <suravee.suthikulpanit@amd.com>, K Prateek Nayak
	<kprateek.nayak@amd.com>
Subject: [PATCH v2 3/3] x86/cpu/topology: Check for X86_FEATURE_XTOPOLOGY instead of passing has_topoext
Date: Fri, 25 Jul 2025 11:06:22 +0000
Message-ID: <20250725110622.59743-4-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250725110622.59743-1-kprateek.nayak@amd.com>
References: <20250725110622.59743-1-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|CH3PR12MB8283:EE_
X-MS-Office365-Filtering-Correlation-Id: d93044b1-91b3-4961-36ef-08ddcb6b77a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ivr+7KXEMZvivMGxpHzBJPD3F8EnBYpoPNidNv8ZSf0Ffoy293n3QRLtctZg?=
 =?us-ascii?Q?BwoO/+cdAGjM7AZyw9iKfFGnhHkiiIkcYRVuQ6tSRrd47HPRnAJOm3RDSOPG?=
 =?us-ascii?Q?KGS9z6Od8Akyh8wX5iEnXbAgyKWUWDYGNiLn4pLsdK2662l5RktIZZSZFQCi?=
 =?us-ascii?Q?ZyLfXj3o9YGLkHwEgHrDqun2BAJOgvc8yZOH9BGxfKnVNCvAa62+LTcOvMo1?=
 =?us-ascii?Q?EOw4zB+FFgFN9wfK+DZDr6/BcOonuAkSdC66ibwjd+h30ZQ+NlgZ+yNILEmE?=
 =?us-ascii?Q?pBbk3kfBJj8kEv6pVeVVl2uhpvGYKj30v/fEpt+bCfScRGppYM6wliJQisy2?=
 =?us-ascii?Q?hP+S5ZUtR9KJIOulhquG3/LF8clw9wzwU2lesjYIP8Q0FIZAUUVQW97mgiVN?=
 =?us-ascii?Q?aekU7OHQCMKT1eCxhTeHzjlbK7ZPBFuUyEOg/oDC4Sk2f3U7zolvfXJvJUjD?=
 =?us-ascii?Q?1G8kMm6XjFXinR47QScWMlAUPIrKbuSQshviQPY2SQqRH6mWadeug8tTucKs?=
 =?us-ascii?Q?MxaASvp0pHLNVP6MxRpIdvIuFfWi7tV0zlZ0EuJPoMKab6/g2TxHqYazuLGE?=
 =?us-ascii?Q?d2TVHkRnzH5Hq/aUrcc6EGWm/pbwfK1h8umiMzo6RIKQYLtPi+B4B/v50uQs?=
 =?us-ascii?Q?hwCmD7TM9/YEMvpCe6dsjzXwChWtyst4AGryCpii/32Q/Rs0GI+Cl65ckukJ?=
 =?us-ascii?Q?RtMEAfF/wh0Shlf0UQbiW2s58sSIeOCYS74gkEEIlBxGcxcqiZHYRX3UBtNB?=
 =?us-ascii?Q?597Ce+r+hexbGC/ciJryQ8T5r2HBiPOUidAVGhnt/qNC6xaGkLigw6SeKMZZ?=
 =?us-ascii?Q?fQcTQiBUKB3LqyBy1viPIGwsHhZWuYsnN4FcLrQZcgcwdKRiYDbFClva9y1Y?=
 =?us-ascii?Q?EQDLlm4Knv8xoiNml1wi2cHjElm6zlICyFCha9g1mVJWc568fVgX0oilrDoi?=
 =?us-ascii?Q?y5ntynL6YFUStGgqaUgMwZr3hmXywg3RZ8rMFC+RlQBcFXN+IS0cQYdPoKZq?=
 =?us-ascii?Q?k53gb8ULDzL2O0npFGu2GY5GVdIQ2DvBgmzMPAyrSQyahYTWoTd5dyLobhWD?=
 =?us-ascii?Q?8HEbQRrmdKxicVwgqMWkC7fFbIJQmdZ27EqRid4CzWn15zhQyKqTktCkiWz0?=
 =?us-ascii?Q?raVbDHnRghpso5n3JON6HzagRBdkHZC5CAW41T5Eqsb9lQI5ovrVshhQnEue?=
 =?us-ascii?Q?NmSn1bdz4rsE2JY14CxraNS//vURs+yULmOTsTBnEH6eH4lOcx1mgFGazeqF?=
 =?us-ascii?Q?l3zW8iLOXhwD/XEDC41tHd5On1VHesqUizW5hmMXJD2abLPhaD7jxQblSe4T?=
 =?us-ascii?Q?m2EvwnQnxLwg26T76zQhfQteDZk1FIALJS+YKtZyIKBW7O6Btx6++gLyKKWk?=
 =?us-ascii?Q?C2uWI0bwkY48zzz9lC+B4Rtep4k3imYm4+mGaKoni9/AFxAe9FtDCKzPe/jB?=
 =?us-ascii?Q?PQb3enfcjPlP93gRjuOy7RoO+ZhYVFLpFs91k1R6nE5Ts8CAyAmS062fJQwG?=
 =?us-ascii?Q?hiE1WMuTMCzpgtixtoghNpAMSd99zvZ/4EOT?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 11:07:38.4826
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d93044b1-91b3-4961-36ef-08ddcb6b77a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8283

cpu_parse_topology_ext() sets X86_FEATURE_XTOPOLOGY before returning
true if any of the XTOPOLOGY leaf could be parsed successfully.

Instead of storing and passing around this return value using
"has_topoext" in parse_topology_amd(), check for X86_FEATURE_XTOPOLOGY
instead in parse_8000_001e() to simplify the flow.

No functional changes intended.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
Changelog v1..v2:

o New patch.
---
 arch/x86/kernel/cpu/topology_amd.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/topology_amd.c b/arch/x86/kernel/cpu/topology_amd.c
index b392d91c6df4..1b4f178edd72 100644
--- a/arch/x86/kernel/cpu/topology_amd.c
+++ b/arch/x86/kernel/cpu/topology_amd.c
@@ -59,7 +59,7 @@ static void store_node(struct topo_scan *tscan, u16 nr_nodes, u16 node_id)
 	tscan->amd_node_id = node_id;
 }
 
-static bool parse_8000_001e(struct topo_scan *tscan, bool has_topoext)
+static bool parse_8000_001e(struct topo_scan *tscan)
 {
 	struct {
 		// eax
@@ -81,7 +81,7 @@ static bool parse_8000_001e(struct topo_scan *tscan, bool has_topoext)
 
 	cpuid_leaf(0x8000001e, &leaf);
 
-	if (!has_topoext) {
+	if (!boot_cpu_has(X86_FEATURE_XTOPOLOGY)) {
 		/*
 		 * Prefer initial_apicid parsed from XTOPOLOGY leaf
 		 * 0x8000026 or 0xb if available. Otherwise prefer the
@@ -178,6 +178,9 @@ static void topoext_fixup(struct topo_scan *tscan)
 
 static void parse_topology_amd(struct topo_scan *tscan)
 {
+	if (cpu_feature_enabled(X86_FEATURE_AMD_HTR_CORES))
+		tscan->c->topo.cpu_type = cpuid_ebx(0x80000026);
+
 	/*
 	 * Try to get SMT, CORE, TILE, and DIE shifts from extended
 	 * CPUID leaf 0x8000_0026 on supported processors first. If
@@ -185,16 +188,11 @@ static void parse_topology_amd(struct topo_scan *tscan)
 	 * get SMT and CORE shift from leaf 0xb first, then try to
 	 * get the CORE shift from leaf 0x8000_0008.
 	 */
-	bool has_topoext = cpu_parse_topology_ext(tscan);
-
-	if (cpu_feature_enabled(X86_FEATURE_AMD_HTR_CORES))
-		tscan->c->topo.cpu_type = cpuid_ebx(0x80000026);
-
-	if (!has_topoext && !parse_8000_0008(tscan))
+	if (!cpu_parse_topology_ext(tscan) && !parse_8000_0008(tscan))
 		return;
 
 	/* Prefer leaf 0x8000001e if available */
-	if (parse_8000_001e(tscan, has_topoext))
+	if (parse_8000_001e(tscan))
 		return;
 
 	/* Try the NODEID MSR */
-- 
2.34.1


