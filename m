Return-Path: <linux-kernel+bounces-724076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D8FAFEE58
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 18:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 197A017F6B8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0FE2E9746;
	Wed,  9 Jul 2025 15:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CHPmSxfj"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C37187346
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 15:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752076741; cv=fail; b=sYjqC5Kv8VAQHuS2rm9HlxplDc9Zj5NJH9weK59QVuzp0DZF4pIPVtStwzIEZS3R9uDnEYoQ0yKGpwQu3Xtm4+h0YIfiElYKGXGXR0SnYPohK7gpuLs6P7vFhEoXHeeUd7gDnBbEy78NkzuHM/vUMsXVtEPLN0ux4ubsGFqQDjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752076741; c=relaxed/simple;
	bh=P3GRBv3TvNC4WU/ZSTT3xcb1UoLq7qRxvju4mXRWXmE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nrt0hs44yvgK8ffFq4CqzeZ5hjIGMaYPnc1SXTmwTlh6pjzhrOv/amOCfjYATXCLFH0s+haCrjIi/d8ju6+YP08PfAqImtwZ7NripPulhgZfuDyx2KEqrGAiCkQM4pBoJ/gqsnp2ojF1t4ikGGA6MGZVG7dh3/EaQDEWAdacgWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CHPmSxfj; arc=fail smtp.client-ip=40.107.92.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fjqDnu9ya5tiGUTrvxqaHEUAyTZ+N8sNIBk8Y0hRxX6rlW+jCDkqVbG7GEDrRg2qLMxJXL6dGXZk4K5Yy+v7oYI1NA9ZanpIGT5tBTsbUglc5NYV9ztL+xAfLzOQfAj2NhkpoWxA0jeoe82Up0anr8DEHTP6h//x39OYDIFo77MaEAd8Sl0XboSdRjv9WeuiFddBWSTM7YvDtgI8E5bcNl2Zy3Jelc13jMpX3OHRUAXe1iotSUN1CXbHfJk0mnr+d7Nicyq7HiYBmdguITBVaudFSB87P9e/5qoUsN/4S1G3Nve79s0UGWjTkkRP8PoEUEUtxVSyfp663epZi2dP+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uoSZFhiwauj3Q3o4wlbZuLF53i9pPeJ3ULXGx/8sOdE=;
 b=oyCBrhTORlxy2583ra7P+Bujc0ii5ofDocfRgq5y+v9CRrvhGRAWpYewfMxj/iYWUeEDuXaeE92oUKuz3YoFtrj7xN3B5h5T9QUfKN7xq1X3S3Hnfh3F/oh1J40ckwgN56c73qFie5wxn78K1jFydK7JEEYBQHU8Kt9rUEK1nkiso6q3d0i0gyK694M6wWm3AiQq4WHB13hPOxU0DrVxb5TAkjHLKlOCWNJQKja28HtS4XOqLqNcwo8EO0FD1mMS4GXQhFWQp9JG8SZcuUq1ApdbzYG7UKvLIsve/da//eAkAHng8FR0npp5ge3/jQyIkKPzfpFL97ezP27Igj4ZcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uoSZFhiwauj3Q3o4wlbZuLF53i9pPeJ3ULXGx/8sOdE=;
 b=CHPmSxfjE2FouNFmn/HvPkLzjcWBhExPtczO3d+HWoVLK5nCd4mfyVVAVg1IZz/wK6jZ+qBHhucM+Awzc62Qbx9iQKQl9OaMwHPo82ACFrfjR+GAz01O8b792V19opObeXJKyvPq0jiPJbikWR4Zg8Ui5rdW7C1HoWHMNPPZOpc=
Received: from MW4PR04CA0071.namprd04.prod.outlook.com (2603:10b6:303:6b::16)
 by CH0PR12MB8529.namprd12.prod.outlook.com (2603:10b6:610:18d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Wed, 9 Jul
 2025 15:58:55 +0000
Received: from SJ5PEPF000001F1.namprd05.prod.outlook.com
 (2603:10b6:303:6b:cafe::fa) by MW4PR04CA0071.outlook.office365.com
 (2603:10b6:303:6b::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.21 via Frontend Transport; Wed,
 9 Jul 2025 15:58:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F1.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Wed, 9 Jul 2025 15:58:54 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Jul
 2025 10:58:53 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 19/22] x86/bugs: Add attack vector controls for TSA
Date: Wed, 9 Jul 2025 10:58:44 -0500
Message-ID: <20250709155844.3279471-1-david.kaplan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250707183316.1349127-1-david.kaplan@amd.com>
References: <20250707183316.1349127-1-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F1:EE_|CH0PR12MB8529:EE_
X-MS-Office365-Filtering-Correlation-Id: 672bb07e-5144-4a4a-f742-08ddbf0181a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4nvWdyj+rMSTGlfqtIxGDmLJvWTPA3HiiDnXbZp1iwmo2thWdL6sd9AutGqq?=
 =?us-ascii?Q?YH26fV09B3RTrFJntyZaFBqKYXVujzWFLFMDxvyl0NCGA8euNt+6ZZC3/P1m?=
 =?us-ascii?Q?oI2yqoI/1kLJ34lXGmmDxTNCg+pI1IJtu2i5vD62KEa9cy8pILgcNDacWVie?=
 =?us-ascii?Q?7QutQ6iC36eEEifdEyBLGCXy8f84Z2AuMUxJH7Fc1HszzdO4ROHGbFUDQMZn?=
 =?us-ascii?Q?xjbS9PEZCSg9LYVcYYQoM5aEcOkE03xQHqunELpUs/0Rkx35CC1HCASfUFy0?=
 =?us-ascii?Q?lRyh3xfJ+rETZ3GX8Bk6NSbUa8vH0BLcmIDGoW03OY+t8+TAoK4LUjKvFsGO?=
 =?us-ascii?Q?UveIZ/mdv/+6AtpuczwCqgWALZr/TY7HxIybdMmcGTEkKyRopB0GIg9+a28J?=
 =?us-ascii?Q?SoBHLU+PFr+Fx4lSw4lLXzr0LvMmMRZm0xDa7HajMzotjDh9FVJL/Z40Dm6l?=
 =?us-ascii?Q?0x+KQ1OS52pioAPkVW8jF1ZiwjJKjmMfJY6iWphxFUYbcRhb5W+PruFKNCmv?=
 =?us-ascii?Q?iadJLT+TKfC6o9+WOmE31SZE20Sk/9baS/Xlqt/QGMPI0yiZyHP1lUSPLeay?=
 =?us-ascii?Q?ng3WNlBAhgCfa9WYqwRilfpugVpO462llbzuOEtabGFqfnCfhtizyQcuTnc2?=
 =?us-ascii?Q?Lteuv9NiwHR+mzetHXi1Vk2ldsX8H83S03QwFa5QwHAHMAURqbRxSzREWL2R?=
 =?us-ascii?Q?tku7L5NykQoht/VZ0q8hSxlHgJyWJkkj406o3V+GdIik0ahsASRXBkHJ5XfU?=
 =?us-ascii?Q?rgI+I6FvQMqsvfwWLjJARAHrHytuawcV7qlRCGbWAnUhF8hb2RDZzHTWN8Iv?=
 =?us-ascii?Q?PO/PWm7a5Z2zns6AlU1bIswPeOuWdrMyFdPC0du5ezE0CnrpAL1400kJfwWo?=
 =?us-ascii?Q?jbwSRGxOYL7Gssvz39Ura9aQn8J/swXp123rnYehzpwCzeOqkgmsQMrYUSWs?=
 =?us-ascii?Q?pyt2Y49uqM2n6B2OvGX+Pk1TYhno8fcFmpMYh8NS6BHHEQH7zi8pZny2DZcb?=
 =?us-ascii?Q?v+rySacjoHJ8jf+8fC7RohJJvCID3w9MOLNlBlkgyMpM/CawIr/CCrZJ9g5F?=
 =?us-ascii?Q?2KzTSdwJpXloC85zw78iNwbvM9RfCyk8muBkljSYkpL37gcF01nEdk1xtZSZ?=
 =?us-ascii?Q?96AoQbepfuppyTLAmUN+M5KfboeA+qSeIiJpkF/kT8YFXsW6NhfkxGY+MgZn?=
 =?us-ascii?Q?ErBpFA54ouSccpWeTbWTe0us2ZER75SyUg8H8x0wKFH7V+mu+Yq4g3mbcyzD?=
 =?us-ascii?Q?QKANnY9VHivzs3Rpfhque4COYuXhG14XMdXDoT4ZBB2pt90yloDSIbKKwNtG?=
 =?us-ascii?Q?x+GqEZZufPl5l609uNXDchchqqPZb5XPmpjjJI8wjKrgRSFL0WMvx7pIcHw2?=
 =?us-ascii?Q?7cuSlTKge2ZG+FY2u5R/OFXX77iIJ9XfqANsZpm8Mx9LwlWQMGhid5kjexPz?=
 =?us-ascii?Q?EOwSzbWpY+93swFm2kXNQvzSd7Ht9TtCiZZRiQXczPNV6Aojui2aQiywPrY3?=
 =?us-ascii?Q?/i2iHPkAP2TlhQBwXPWjhbAXl62DO3fkxucM?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 15:58:54.6070
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 672bb07e-5144-4a4a-f742-08ddbf0181a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8529

Use attack vector controls to determine which TSA mitigation to use.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index f41d871f0622..e02b232fcc6e 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1657,28 +1657,38 @@ early_param("tsa", tsa_parse_cmdline);
 
 static void __init tsa_select_mitigation(void)
 {
-	if (cpu_mitigations_off() || !boot_cpu_has_bug(X86_BUG_TSA)) {
+	if (!boot_cpu_has_bug(X86_BUG_TSA)) {
 		tsa_mitigation = TSA_MITIGATION_NONE;
 		return;
 	}
 
+	if (tsa_mitigation == TSA_MITIGATION_AUTO) {
+		if (cpu_attack_vector_mitigated(CPU_MITIGATE_USER_KERNEL) ||
+		    cpu_attack_vector_mitigated(CPU_MITIGATE_USER_USER)) {
+			if (cpu_attack_vector_mitigated(CPU_MITIGATE_GUEST_HOST) ||
+			    cpu_attack_vector_mitigated(CPU_MITIGATE_GUEST_GUEST))
+				tsa_mitigation = TSA_MITIGATION_FULL;
+			else
+				tsa_mitigation = TSA_MITIGATION_USER_KERNEL;
+		} else if (cpu_attack_vector_mitigated(CPU_MITIGATE_GUEST_HOST) ||
+			   cpu_attack_vector_mitigated(CPU_MITIGATE_GUEST_GUEST)) {
+			tsa_mitigation = TSA_MITIGATION_VM;
+		} else {
+			tsa_mitigation = TSA_MITIGATION_NONE;
+		}
+	}
+
 	if (tsa_mitigation == TSA_MITIGATION_NONE)
 		return;
 
-	if (!boot_cpu_has(X86_FEATURE_VERW_CLEAR)) {
+	if (!boot_cpu_has(X86_FEATURE_VERW_CLEAR))
 		tsa_mitigation = TSA_MITIGATION_UCODE_NEEDED;
-		goto out;
-	}
-
-	if (tsa_mitigation == TSA_MITIGATION_AUTO)
-		tsa_mitigation = TSA_MITIGATION_FULL;
 
 	/*
 	 * No need to set verw_clear_cpu_buf_mitigation_selected - it
 	 * doesn't fit all cases here and it is not needed because this
 	 * is the only VERW-based mitigation on AMD.
 	 */
-out:
 	pr_info("%s\n", tsa_strings[tsa_mitigation]);
 }
 
-- 
2.34.1


