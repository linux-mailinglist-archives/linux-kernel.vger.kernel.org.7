Return-Path: <linux-kernel+bounces-814386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A306B5533A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 17:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C20CB165562
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B126521CFF6;
	Fri, 12 Sep 2025 15:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YYduK5Tb"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C0A155A4E
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 15:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757690687; cv=fail; b=RrhItACKea9izmbxpmyzcotqudv7a7L6v5wD8QSypc1ze1pMSLeP2h+v3sPLU/sdSrQ8AH+aZMo84YTaK+TunAHrHl+316FnAgwfwRQsxsbx99SFeqG+LN1/VgpGkG1wmih/THMkFxY69r3hoFzJvfG6oLqa2nYO3DEEhTsIZa0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757690687; c=relaxed/simple;
	bh=Oey2dUSHvSBtj3rltGAMiI3d5peQUEh7YsOVQMUcoHc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OfYdvK2/oWWM9Xrw5g4SkJHSUiJq6yProxGXVFO1MUG1mi3lF+FBFSzMQ76OxveHTOpnRDUn1eQML+j7f3MnoPO6eqyw297o2GPVMadG7p0viP8WAbFeLslbVxXMpijM+slikoZYOPaK/dle22NYS8oaxH9y5u5OyRayM2I0Kbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YYduK5Tb; arc=fail smtp.client-ip=40.107.93.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xw7dg00wUuarDq3a/N7+c7+S8S5n2C5P2oqCHH64AjKVdTa0UJJJ0+FXNwDDoTW3h2AgLtELT8N1bsDbvuc1lP8xImPYVuOPFIb/8O15VCYZObq0svsFRTQR77CCmVkaBMxhF+vQmBPHWm06uIjoEMxztktZu99QLqRm0pwENO6XGm7/k5HewqqL755tC7uhpYxJjVrHopsDHahVxe2hhqsCtcvKBhqaXt0Tg5iIULqyt6OffIoAI6BYPiyx9reMo09ooMy1QjtCW4kXzJLnDajvso4zE9ePWeCy5p++jWhe5zC5lbvLgRIgVe472uUPsdiexv0vkN3Ozv0iqWTRYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0kKQt9k4SvDYqKV/yAVNpi7SM/8RSoiJoXlgfqK0If8=;
 b=hZcCV6HRhm0QSkPPXPZ6NMoJk/CU96MWWpOTf+uhqaczYWz4lulgklQY3W9atMzUY+W+xuOD71SVOMKXZ3PXsI3uyR15GnSOrVoOkYwsyawD785MwZoGqNafuJbQjsRA+hpdlskGlt8TeOQSArnEi1tlNXg6Yw2ucJiBY7nySTVRcfOAw1Tll8cbDbZ65uZGKUP+VZwKkMGzyBdTMgFjVISkQN5F259iuRe39Od2i8OaBnL0eE4eBVcXLgkXzdgHTV3K5ld5ZnAzmUacT2Hi00gDvx0UqI0zKkohHN7lqp9UE3gPusgI0/a3/vqg5cDbrXkDq76gd9D5EGCOEBRHXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0kKQt9k4SvDYqKV/yAVNpi7SM/8RSoiJoXlgfqK0If8=;
 b=YYduK5TbBaRX15NePlQykQuYkQCsXRQxRZISxStgtfrNkrOejcHqBeAGizgwofm8xDFkd/2cVNKAXxF7BVrB6MRhryOTog9qLDVG1om1qIUwk2ufaQbrTJ6Xk0EdPuCwUtp/VtkdL5IloKs063qXhpAcEqJ9f8hG4vU5PNEZBxw=
Received: from DM6PR02CA0108.namprd02.prod.outlook.com (2603:10b6:5:1f4::49)
 by IA1PR12MB8288.namprd12.prod.outlook.com (2603:10b6:208:3fe::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 15:24:42 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:5:1f4:cafe::72) by DM6PR02CA0108.outlook.office365.com
 (2603:10b6:5:1f4::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.18 via Frontend Transport; Fri,
 12 Sep 2025 15:24:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 15:24:42 +0000
Received: from tiny.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 12 Sep
 2025 08:24:38 -0700
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/bugs: Add attack vector controls for VMSCAPE
Date: Fri, 12 Sep 2025 10:24:28 -0500
Message-ID: <20250912152428.2761154-1-david.kaplan@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|IA1PR12MB8288:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c811cbf-10fd-46a1-58dd-08ddf2107f14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?irCT2ZNhQWfdIHgETq6Yxh4/sOynb0s6DyovgLVhqz5Iy0K9deGYR0nOp5vh?=
 =?us-ascii?Q?SUV5qzYsBH8Gk/ve+90HK+sVYlMjFVD1ojRSyyZtyRJe2xia48CXqX+nh4sx?=
 =?us-ascii?Q?FYB5KcaChCnLHNlZdaOIX6xXpZrW5tMzJLmtraZW4u57W2jUNvZrNv7uv2pC?=
 =?us-ascii?Q?XIB6E9/o1AKiWJuWXpUTyvV9hWWR72dveJJLWOFL8pKNyR8tl1qakdNG8AT3?=
 =?us-ascii?Q?XzVDV9jVC21MJ1/QvHfXnBWcAJNxBPw1jj6dvegySLlfkQ9RQ4LpXhTd4ooe?=
 =?us-ascii?Q?rKKRQEY9Tri8Erj+Fq3GTFyw3AImieSdCjM3gQu4MWGEwmgswhKDhbFG42U1?=
 =?us-ascii?Q?li/4mrhVsgQ6CbokFFokDzfMha/iTu8LXyYKn0RQIdF2MJyWJfA1t1JK+NZi?=
 =?us-ascii?Q?H0C73JCNvDllMEcRF+0z96YXk+gKcyzmPkz7d+/mBvRNAUXzz8Tm+zOUJOoC?=
 =?us-ascii?Q?wVktwIgy/oN2IgvCqSKj6HUf6Mr8+EhCuOVc85c73X9n8HoAGiDMWhZSViHE?=
 =?us-ascii?Q?32y0aL61kpEYjURSExkSSY2w9RSfWZKcRS8ovUWnUiT+hp7UhGqGJe0cOhDW?=
 =?us-ascii?Q?LmQ3a3uDZYq8prYvvBviY5jHbO4hmOnyTLAqT7nPKSkpeffxgP4yGX+BOPeT?=
 =?us-ascii?Q?XJZ8oazpBY9XpWq4uEg1W8Cqed9AulTQ3DEE+OQQRhsaaPCvIXPp/xiD27Lw?=
 =?us-ascii?Q?m2L35Biuk70bPIHDhu3FZGKVBBptzeQkDwEbcIpldWH7BWDGKrqK91ZPMAhf?=
 =?us-ascii?Q?hJKPscmXOXIqCpS4/1OyF3xyOmmb/GD1eqNfT+n5qfbLNCWp7+rds6UC5vzH?=
 =?us-ascii?Q?6yMWcmTAOsr/3M5MREeiWtUmOPIdtElY9+qRJllwDbKnTNYmn5Mlm3EXm/Wm?=
 =?us-ascii?Q?D6rxjVNvSwllhsk0yxe4eTO0epywWYimYylN9ZIOaFeMsOBzZHkqPolaW7tm?=
 =?us-ascii?Q?Junj2d7MvBe5do5NpaZ4y5fwt74xjj6HzjA4t3ve4XxuExDL6hnAJ+SoGH9y?=
 =?us-ascii?Q?dNpbSsFnqaoBHHuKzIi8fJwGirCCDmsTyUP7A3s0CMJ/rXyDECkheBoqetzD?=
 =?us-ascii?Q?HpalFdMhOZbFUZcmV0CM/BogMN2VnAPqXu/IFIJGGfw1Z1A1ubwQ5cfdCIgN?=
 =?us-ascii?Q?k77diw+Tlgfp3DslC/ZdFY2mN04e2ImCgEh6kafIfV8UR9WtDGKlHNHJ9RZ5?=
 =?us-ascii?Q?7gmbq1XM0vO4GOt6djpSp1jMYsSCMg51iu11Y+adPjmA5kcHw3R6TaWeuuFY?=
 =?us-ascii?Q?5+GJ3a/dLiAgRLEMmm9lzzmfBuYuzbIihsdomTzNQ6LGVW4UdnargnGmIH9j?=
 =?us-ascii?Q?8ZWvNtv7xxHGogUwSKMJmgoQDiBaI72dTekd7+kLwpA2tfaFy8RvSePMzrtK?=
 =?us-ascii?Q?cEj/U6xuWcc75UUlHgFVXQ+pC5LSPvaqPgrk9rXVyYmpwPti5MmlMJmKzyfU?=
 =?us-ascii?Q?C79exgJP7QDQYc49taPyOW6vLb0/zt88tCX4pyicziEkA0luM2ogz9IRRYeu?=
 =?us-ascii?Q?mnSnPyTwDahAco6qb+gG23Lp9eMnInwM+SCi?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 15:24:42.1109
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c811cbf-10fd-46a1-58dd-08ddf2107f14
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8288

Use attack vector controls to select whether VMSCAPE requires mitigation,
similar to other bugs.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 .../admin-guide/hw-vuln/attack_vector_controls.rst |  1 +
 arch/x86/kernel/cpu/bugs.c                         | 14 ++++++++++----
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/hw-vuln/attack_vector_controls.rst b/Documentation/admin-guide/hw-vuln/attack_vector_controls.rst
index 5964901d66e3..d0bdbd81dcf9 100644
--- a/Documentation/admin-guide/hw-vuln/attack_vector_controls.rst
+++ b/Documentation/admin-guide/hw-vuln/attack_vector_controls.rst
@@ -218,6 +218,7 @@ SRSO                  X              X            X              X
 SSB                                  X
 TAA                   X              X            X              X            *       (Note 2)
 TSA                   X              X            X              X
+VMSCAPE                                           X
 =============== ============== ============ ============= ============== ============ ========
 
 Notes:
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 36dcfc5105be..e817bbae0159 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -434,6 +434,9 @@ static bool __init should_mitigate_vuln(unsigned int bug)
 	case X86_BUG_SPEC_STORE_BYPASS:
 		return cpu_attack_vector_mitigated(CPU_MITIGATE_USER_USER);
 
+	case X86_BUG_VMSCAPE:
+		return cpu_attack_vector_mitigated(CPU_MITIGATE_GUEST_HOST);
+
 	default:
 		WARN(1, "Unknown bug %x\n", bug);
 		return false;
@@ -3304,15 +3307,18 @@ early_param("vmscape", vmscape_parse_cmdline);
 
 static void __init vmscape_select_mitigation(void)
 {
-	if (cpu_mitigations_off() ||
-	    !boot_cpu_has_bug(X86_BUG_VMSCAPE) ||
+	if (!boot_cpu_has_bug(X86_BUG_VMSCAPE) ||
 	    !boot_cpu_has(X86_FEATURE_IBPB)) {
 		vmscape_mitigation = VMSCAPE_MITIGATION_NONE;
 		return;
 	}
 
-	if (vmscape_mitigation == VMSCAPE_MITIGATION_AUTO)
-		vmscape_mitigation = VMSCAPE_MITIGATION_IBPB_EXIT_TO_USER;
+	if (vmscape_mitigation == VMSCAPE_MITIGATION_AUTO) {
+		if (should_mitigate_vuln(X86_BUG_VMSCAPE))
+			vmscape_mitigation = VMSCAPE_MITIGATION_IBPB_EXIT_TO_USER;
+		else
+			vmscape_mitigation = VMSCAPE_MITIGATION_NONE;
+	}
 }
 
 static void __init vmscape_update_mitigation(void)

base-commit: 41bab90bbfdc55228b8697d960839a4abb5016d4
-- 
2.34.1


