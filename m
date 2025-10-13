Return-Path: <linux-kernel+bounces-850714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32378BD39AB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E233188EE4F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881BD3081C4;
	Mon, 13 Oct 2025 14:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cj4bdiWG"
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010064.outbound.protection.outlook.com [52.101.85.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E931C2F9DB7
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366128; cv=fail; b=OAu2wYIwtE+1gTXMUkmizp18vgVVPAl2GCYFwB7in1nl5oJ9jn2OotjARdTZ63XyEJ5pgI+Ud0f9p9B6VFF7x9/ZIPzXKCyOTpYZD0cVjJtNq2KyNfmWoFNKD9nXSxYU0cx44JnNOjrK4BFmiz6LJsLeNbmoB+pbnslI5N6DpP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366128; c=relaxed/simple;
	bh=/BhkFKuMt6oYbabUBkh6nRPyLTnaph1qRomEz2KqIgY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CAAd9LxqCvsxIecmkhgEIbjMKLiqDXuiM4EJoGUjr4ZkrC3iEdcA4nanI+dJjD+qd2Z+XmJ5j8pyQz9hZj47BPEOAhCN94bP6GPkSkaFQ2NNM/P2sCHi8mq67mWU8fbHDG6ilYcQ2NY83bVWl3ArU1TVrgq9TtoPDoX+f8ARoh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cj4bdiWG; arc=fail smtp.client-ip=52.101.85.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GH8Q1TQhtSz1foizQW4FF0uRlWZKciKrYW84LsnB+YyY/Ud0n2pRl7Yfc9FKUOvgNf7n4l/QoOXh9M78uxe8vT2/1TjlSMN8uQeRm1USwMkhYHmEEVjvsTQHQvrC0WbJjEzFz/P+UhX81zlwbyBJpBaIsskr8sS6cmcaAnpd6REc2tf7ZmjDzoQeJAxeq26NaCfKaOE0na/iy6vKhLer3dkjemqK1OOTQxUoydbdFqAKH2akhZTgbfNQQugl4+NoOPoMylaMHOIAhZm8/WY6l6XC+Lpls801ltENWqkTpoNJJxUZYHe6eH0wC2reY+qHr0k/9wLLvaftWJompF/qew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vKa7I24jcV66uULwkL3v+iLVSR43sCuaRKQ1YxEOxoA=;
 b=hdPccSr16e7+Th/RMViFF0rlB0p/VLiZpznpEODI9h1oEPx4i3vLOixs0X04C7KDxopqozdmSAtAskzEW9GzqoT+d20BFlgRmUeTnP0JU9CpTlB/bxi/5k/9S4GCCpGEYi8GsiazJFlObBLJwFELbNECeYuObP9JOJ4WI5hSLExnqXMgozc9RsJRnmeOsbC2bvrlNOR07mnzXtoagzGL2pBpv2qQbU7NSnsmyUPsjv/zDfUl/y6xsaab+v9W2rH97yhBGEF025T21LzYSuVWfAiBH5LLmEZcv0q0jmjgPACvEVmNJ6A42hWVOlWXZln7j0ay4rI7VVYwM6jNZ9xMkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vKa7I24jcV66uULwkL3v+iLVSR43sCuaRKQ1YxEOxoA=;
 b=cj4bdiWGe8jlK7g0PKeFiXXkWtmrCSGTLTn34vG8lhkX7QwbG3pYJGPdyNSLOZjQTyuMUy73KPrrdqjUmhSqkTfqwfWaX59MXHeLFa5eYPwxChdC1mMZitHZHNMU+KfiEUQLFSo/2cAigcJRYhObQDRmq+gCu4h1iH6nEBxf6ig=
Received: from SA1P222CA0119.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::18)
 by LV3PR12MB9355.namprd12.prod.outlook.com (2603:10b6:408:216::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 14:35:22 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:806:3c5:cafe::ee) by SA1P222CA0119.outlook.office365.com
 (2603:10b6:806:3c5::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.13 via Frontend Transport; Mon,
 13 Oct 2025 14:35:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Mon, 13 Oct 2025 14:35:21 +0000
Received: from tiny.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Oct
 2025 07:35:20 -0700
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: Alexander Graf <graf@amazon.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 06/56] x86/bugs: Reset retbleed mitigations
Date: Mon, 13 Oct 2025 09:33:54 -0500
Message-ID: <20251013143444.3999-7-david.kaplan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251013143444.3999-1-david.kaplan@amd.com>
References: <20251013143444.3999-1-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|LV3PR12MB9355:EE_
X-MS-Office365-Filtering-Correlation-Id: b1b0c045-2af7-459e-dab6-08de0a65bd5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9NElyobDOCcBxN5TnF8ybxdADRthxahOTZD+hjs9iPdaGI69DRoW5z1yHvSU?=
 =?us-ascii?Q?i3racsjgwNFN8wQh8/utbLP/peM292kIGkyfGFjglw8rNONcp6My/m18kMd1?=
 =?us-ascii?Q?MWr/LSoDCJ2VT3p2DIGExDaRh4W1aO7ItY8PGwCPFIBc874OQ9hkyummJx0H?=
 =?us-ascii?Q?lcs3tSXCh/HaxguAw1MGIMGEfpqn77FDS+dPntJG5ihJ8X6quNUioHFGWLJe?=
 =?us-ascii?Q?tNC4f7fkV1f6JG5C0WGA08PwOHMRYmtzlEIVIS62i6qj6TXfo5esXeMtQdmH?=
 =?us-ascii?Q?zFtLlLVpW4Vy8grq/ip3IH8ysM/xkPZQncum5XbM17EAoj3wnKCricPs6UD8?=
 =?us-ascii?Q?1BMjkLpoaKktqzNBCDNNrZGbn4DZCLBiH9gbPWVKwEMsZ8imLoFbAA22SM+t?=
 =?us-ascii?Q?gEGxkLAyRu5Y1PDh2Scx6783ei+0MPusa8Z2wYzatjtMqhflVqFot++6yBvC?=
 =?us-ascii?Q?ks5Ix1ZdNs7H5Bu8lz6o4i8yZJoBZC9oJOv67rNv4DlR78GEMOTqYGo4ZuCZ?=
 =?us-ascii?Q?LRPmz41b26KeeeQWw93LQL2Oy3RMrkDPtI5PDFrwn/naNeTvVMahAAurXb76?=
 =?us-ascii?Q?QD5TpSw89l/5q57b8HqfqAbB1aBVqU5bUZtypzPwk223T/6gXguQ3iYPosKo?=
 =?us-ascii?Q?47CHOpKv67SVqp333EArezNYlILKAukn75o7z0SCyNHElwwT+YH07XvW1+Yf?=
 =?us-ascii?Q?D+ieK1z+bxTZJ9MOFQ/AciOPlGMrzD5E6Hc/NKf0IkGToZ+MHNX3wravGB1X?=
 =?us-ascii?Q?VD7wC28kaxXViyyOpGaDII6HstVDpGIUoUEccgxXO5ZqVypsWpop7N4jEKme?=
 =?us-ascii?Q?EROWpg8poEDSn9Iy8oA69PlC+Gg7tLvHfmaLH0w3fcP1c38g168BBv92qvtj?=
 =?us-ascii?Q?JmydgaMi6YtM3yNr0TfQKe70LgPPJ10Dn6jLeJFFgXPP0B5hVP1JdVBk3wbE?=
 =?us-ascii?Q?DUwBoYTZD+fa1nTinh6YwzBKKfrb8jhjnkmL3hHmrsHh/bVXLcXiZXAhOKeG?=
 =?us-ascii?Q?3ed7iJqYwBx+AsWVOuf6lmaPcUKMaag41d7MvdFLTZVL8ui40qkw9/2Xvj8F?=
 =?us-ascii?Q?vmboKaThk6wx9PEB6BHLBjahI5KM/AM8Yz9ilN73ztPf3jCvxMprbcTDnLRe?=
 =?us-ascii?Q?9v+8raLFd73vifc8VOCz/15k593CQW9qVXB924cxgrvVdHV/EX3HKhuuQmFE?=
 =?us-ascii?Q?wACa/XVGDwY7zVo/g77WcrzSr+Qq8xm8gckMLO3VhErYRCMK0RRj/G269US4?=
 =?us-ascii?Q?dgLoMozCLX+7b8s/CJxgWbZWUqUq5hcqtX48fNUFobElIiaufWAoOcOZQhR6?=
 =?us-ascii?Q?gLy2sd/eTEdXF+eUsoOg8Rh5I7YdRqmr4tOXRaR7EcTakNUn3ihask0aNF0V?=
 =?us-ascii?Q?iPJRmNzgcS9Vh6CVAYyYx9cP3Se42HptzaJXgL/iduHpC92KxduKeUugkKQv?=
 =?us-ascii?Q?GeF9OoK8FIxvPpzUjxyGiDVx64I2tK4WZLjO9pXlN46jWopvaP2A+5alHC7p?=
 =?us-ascii?Q?fiYw+DjLtDrVr2Cy6OyRkGYZRuf0cRvrPDbf2BzUmiDW8cc3oGyQbGIt8FD5?=
 =?us-ascii?Q?SvWApgyLJ2OuX1vlSas=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 14:35:21.7401
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1b0c045-2af7-459e-dab6-08de0a65bd5a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9355

Add function to reset retbleed mitigations back to their boot-time
defaults.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 0430635bb17d..1f56ccb5f641 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1542,6 +1542,20 @@ static void __init retbleed_apply_mitigation(void)
 		cpu_smt_disable(false);
 }
 
+#ifdef CONFIG_DYNAMIC_MITIGATIONS
+static void retbleed_reset_mitigation(void)
+{
+	setup_clear_cpu_cap(X86_FEATURE_RETHUNK);
+	setup_clear_cpu_cap(X86_FEATURE_UNRET);
+	setup_clear_cpu_cap(X86_FEATURE_ENTRY_IBPB);
+	setup_clear_cpu_cap(X86_FEATURE_IBPB_ON_VMEXIT);
+	setup_clear_cpu_cap(X86_FEATURE_CALL_DEPTH);
+	x86_return_thunk = __x86_return_thunk;
+	retbleed_mitigation = IS_ENABLED(CONFIG_MITIGATION_RETBLEED) ?
+		RETBLEED_MITIGATION_AUTO : RETBLEED_MITIGATION_NONE;
+}
+#endif
+
 #undef pr_fmt
 #define pr_fmt(fmt)     "ITS: " fmt
 
@@ -3829,5 +3843,6 @@ void arch_cpu_reset_mitigations(void)
 {
 	spectre_v1_reset_mitigation();
 	spectre_v2_reset_mitigation();
+	retbleed_reset_mitigation();
 }
 #endif
-- 
2.34.1


