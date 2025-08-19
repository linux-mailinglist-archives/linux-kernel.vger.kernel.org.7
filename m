Return-Path: <linux-kernel+bounces-776405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 146CDB2CCF0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 21:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13469A04869
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 19:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5F0341AB1;
	Tue, 19 Aug 2025 19:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SMnuQGaV"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2071.outbound.protection.outlook.com [40.107.102.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BB532A3E2
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 19:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755631345; cv=fail; b=ku476+/mLRzh6ssvH41G2c8JBNQjU2rawE2C4AIihmWTQslKcOmsQ0AurKTEnkkd21cxvMzl72+HjMu5s3lbliE+iZDaxW4uoieF0FyTpBfnXAQ0MhFIfwWk0oyWrlKX+umigjwACOJsVXb2NKcZMTWJe3j5DoqQzjHMM/p3uQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755631345; c=relaxed/simple;
	bh=wcRY98+Yq5umvCgrzPK3fIHYPid3orBMKWQ+WrOPjJY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NNHI1jsxr45+pTbpeec0kqxrQRfm+4ZIMoXFsw22xuPH1ncjgf2jMjmZ8ZZKmCh7QIIN8W7z8n5zSbaHXgpsKg43M5iqQK18eIkt3VvuW/bsuNv6lEHD0sVEsc1wwAh05Kpb/0aKIs+ub87S17noN+voeMfwzdCWLDA9WJntlK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SMnuQGaV; arc=fail smtp.client-ip=40.107.102.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HIE8NbjABMhn+iu5h42s3ZEF0z6f1hqgY2BAu50GOajDC/jguwgVsT2wgmjy9mwW4LlJWvsBdnp3CDmJmRtQs/PE/vIK8b7Zsx8j+5b4/3dGredq60xh8yBK6hBNpSHNw4szUrczJp83hB10J/4Ts481jjPX/1tnYxNRTWJ40scWwvr8LW9jw/k24Mrry/W9UBOOC88qi16qvhJUIDg1JAwcZMbwF6jnqUs2jSyxayEhtHVKcS0tfF6HAXOagpK6R//1Tz4o133Pg92VXGug19eSUcq1wqjkmIQOv+sGIgevuQM7YfjvKaaBj+ChinMjCCLkszp5FLAKx9GcvUmuCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fIqYrRYe+ME9q0KBACWunz/3Af18ClFdAHb2Mam8vIc=;
 b=lqd3nku/i6tdDYfo2wFBLFX0m5jGv/2irDDL0Dtqzxj6LQ/znTMdx0g8wOJ9TOLM3wNwfQ1y2U7Ve7URVGto5/eK0ovPmc0mIuuTNKWS9t06u29z7Mq5jsMszTxKBf8Krs43UmUQk0fWrm6S55mSLCYLwrc2F9CxIs8C3dzECJJmB+LN9MS/OcvfZu+eejkqx/Iioo3r43CanGliVcBTz40DLYdxhy2LhFGFG++cGYKXlr3Fh6xogKc4F9qFkhkVA/3u94WqjIvFK0M7KasIPU5ysRghdZQyC2r/r+tJOEHuuR4LAFC6QUDyiMzuIghcx6AQgPsIOFINTLzOiUN60g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fIqYrRYe+ME9q0KBACWunz/3Af18ClFdAHb2Mam8vIc=;
 b=SMnuQGaVXct9Kkedc4KzhytvWOqrhEFiC/h+Nm2tIEs4+oEwhUS0gBPyHxlVj0469ZWWUzf7KhGxBoIbNiCkEBwtOsduGkzVrRscd5FZ3mnDcKKCeUorXzuySKI+ibyfGWQzsIUNIS4DIzetrQ2kMkpFv+inyvtLKAEbS/ZD0Ik=
Received: from BYAPR07CA0086.namprd07.prod.outlook.com (2603:10b6:a03:12b::27)
 by MN2PR12MB4094.namprd12.prod.outlook.com (2603:10b6:208:15f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 19:22:19 +0000
Received: from MWH0EPF000A6731.namprd04.prod.outlook.com
 (2603:10b6:a03:12b:cafe::51) by BYAPR07CA0086.outlook.office365.com
 (2603:10b6:a03:12b::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.25 via Frontend Transport; Tue,
 19 Aug 2025 19:22:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6731.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Tue, 19 Aug 2025 19:22:19 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Aug
 2025 14:22:18 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 4/5] x86/bugs: Add attack vector controls for SSB
Date: Tue, 19 Aug 2025 14:21:59 -0500
Message-ID: <20250819192200.2003074-5-david.kaplan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250819192200.2003074-1-david.kaplan@amd.com>
References: <20250819192200.2003074-1-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6731:EE_|MN2PR12MB4094:EE_
X-MS-Office365-Filtering-Correlation-Id: ab3973f0-f132-44fd-8b7f-08dddf55b712
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EwjxU9QWZ1u+tCmrrbhirk/lHXtEa1y8NVmbUyS5NK75Fcyx19ZUc1vCZKHO?=
 =?us-ascii?Q?xyOHzQnVaD2j9xmCXLwU3PjlIOKnUY7QDWrS7DNRV5gsU9w3PXhfygklFUrt?=
 =?us-ascii?Q?P6z7aJBXTNhje/NcVKPyA1rfpUt3Mt/eDdWftZZxcxgkoy4vmWAVmxQvzRVs?=
 =?us-ascii?Q?ol9gB9x488Re3U4xup6J0VpApIdAjWzhzJaJJMY6mU7TEYYc57MMRBgjJE2W?=
 =?us-ascii?Q?0FBh1MmAx1tnvtQBp3/JW1okyhGajotHJGjGAxJD1bHpR8wYfXnipnI0W7Wk?=
 =?us-ascii?Q?eNvx4pncKfuXq9xdiz5ZtnX393vF+jxS7YV/4QcBxz1dO5Dg77avTHSNrOn5?=
 =?us-ascii?Q?ZFA/lVl8FkeDoHevqujwKBmvBlfW66HN7INLngULx1IpENQdkF+Jh8sWa6+2?=
 =?us-ascii?Q?Jvp0MhcYKMd5KboCG3N7FlsoMdQ714ocge+NlomM5R11qOLe8GJrZkBeuOWk?=
 =?us-ascii?Q?a2dUJdCALKB0x9QJIkH7RRP+LNG7O9XPaDTgN3Qu5mPl1uGoFMLF24ZE9WFt?=
 =?us-ascii?Q?U4SQbkDIYRb9OkAF3ULqxlZUTjksbNGL4Y9QZxKMz0q36HJ0qGnVh55ckiOK?=
 =?us-ascii?Q?119jJRlFC1sLF2JXBqEMyJ6/xyYhocrJJslRufgJUC8IQ1L1VJdkR+I0fs8w?=
 =?us-ascii?Q?hMvAbtO9dbhNciPuICMw2+x149oYMx9lhhXvFtzGuUsp3Fyxwv4BAZmtTzmD?=
 =?us-ascii?Q?CxdATf+SLMZXx7msft6vQx7HktINLbrZ5qcN8Sd9hu7bktBeuLeD+YywASut?=
 =?us-ascii?Q?T2nYf9w8vrQ9gD959oSRPcDAQ/qT59InWz5blmXdNeleCuv5/1q4Y/thNyS6?=
 =?us-ascii?Q?1Ng/JrlEGhnQlAwcS6pSfVOtUChBSmomWfKaFmS+3io1+K0D+W+0Nr/3C5eU?=
 =?us-ascii?Q?tQTymeNAwOIVRQ3Hjx8bKv1ezdsyps4yyaMf3ivln72DLdTPW2W/W3xPtrho?=
 =?us-ascii?Q?C1nFcaPcV07mN/xdY6KjhJ0vlH4wh0cSrd3mqrA2NL/6BYwdTM33cH3gjvhh?=
 =?us-ascii?Q?uO+Ips9mI7+s8vXxMs1CnBsxtwe5AhGAreddcxGQebXXxSMILKo0uOW2CnrF?=
 =?us-ascii?Q?bABDZpJu5IFmPdh7wJTLpR1vJeCrDuBomzVL75UlK5R8yTFhPXAe+XO3krs6?=
 =?us-ascii?Q?gIy097Yid8BUYJ+N3AJ9J8XTFdla2d3helHeZM8qT292UFhpJpAY2MC2B+RV?=
 =?us-ascii?Q?UOSh7tQo/bqIA9NK0w2j6oMU1YqCFOrRVBc4WOFZVDPv+S23vmcHZMMxy9oh?=
 =?us-ascii?Q?jZawIn03O14Et22lTfmcUKnwM6a1VWlC9yecnAK7E4WqrP/E3cxwcACWGjFq?=
 =?us-ascii?Q?xYtf5Oc/0f8+bYPrlDVjbofRuELsA+K990LISKi1Lx69wpXYkHRi+KsvypJs?=
 =?us-ascii?Q?xBINv1O8gfBIz9K/PbwRrhLuwVZIXVv4VVnQiCDdzLWDLJQWTNN2ckRr8R4Y?=
 =?us-ascii?Q?fMK4ednRaikrdkgtR5jnLJ8bn3FqK18z5sH1RAfD4mrXc4PdWS/ieggrnVh1?=
 =?us-ascii?Q?zz7VacQr6SSV0zpMqXAnBZlJ8qZha06kpAgc?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 19:22:19.1799
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab3973f0-f132-44fd-8b7f-08dddf55b712
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6731.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4094

Attack vector controls for SSB were missed in the initial attack vector
series.  The default mitigation for SSB requires user-space opt-in so it is
only relevant for user->user attacks.  Add an AUTO mitigation for SSB and
use this attack vector control to select the SSB mitigation.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 .../hw-vuln/attack_vector_controls.rst         |  5 +----
 arch/x86/include/asm/nospec-branch.h           |  1 +
 arch/x86/kernel/cpu/bugs.c                     | 18 +++++++++++++++---
 3 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/hw-vuln/attack_vector_controls.rst b/Documentation/admin-guide/hw-vuln/attack_vector_controls.rst
index 6dd0800146f6..5964901d66e3 100644
--- a/Documentation/admin-guide/hw-vuln/attack_vector_controls.rst
+++ b/Documentation/admin-guide/hw-vuln/attack_vector_controls.rst
@@ -215,7 +215,7 @@ Spectre_v2            X                           X
 Spectre_v2_user                      X                           X            *       (Note 1)
 SRBDS                 X              X            X              X
 SRSO                  X              X            X              X
-SSB                                                                                   (Note 4)
+SSB                                  X
 TAA                   X              X            X              X            *       (Note 2)
 TSA                   X              X            X              X
 =============== ============== ============ ============= ============== ============ ========
@@ -229,9 +229,6 @@ Notes:
    3 --  Disables SMT if cross-thread mitigations are fully enabled, the CPU is
    vulnerable, and STIBP is not supported
 
-   4 --  Speculative store bypass is always enabled by default (no kernel
-   mitigation applied) unless overridden with spec_store_bypass_disable option
-
 When an attack-vector is disabled, all mitigations for the vulnerabilities
 listed in the above table are disabled, unless mitigation is required for a
 different enabled attack-vector or a mitigation is explicitly selected via a
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 10f261678749..e263c126723a 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -514,6 +514,7 @@ enum spectre_v2_user_mitigation {
 /* The Speculative Store Bypass disable variants */
 enum ssb_mitigation {
 	SPEC_STORE_BYPASS_NONE,
+	SPEC_STORE_BYPASS_AUTO,
 	SPEC_STORE_BYPASS_DISABLE,
 	SPEC_STORE_BYPASS_PRCTL,
 	SPEC_STORE_BYPASS_SECCOMP,
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 8dc654ccdbb9..059269f3f56f 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -416,6 +416,10 @@ static bool __init should_mitigate_vuln(unsigned int bug)
 		       cpu_attack_vector_mitigated(CPU_MITIGATE_USER_USER) ||
 		       cpu_attack_vector_mitigated(CPU_MITIGATE_GUEST_GUEST) ||
 		       (smt_mitigations != SMT_MITIGATIONS_OFF);
+
+	case X86_BUG_SPEC_STORE_BYPASS:
+		return cpu_attack_vector_mitigated(CPU_MITIGATE_USER_USER);
+
 	default:
 		WARN(1, "Unknown bug %x\n", bug);
 		return false;
@@ -2595,7 +2599,7 @@ void cpu_bugs_smt_update(void)
 #define pr_fmt(fmt)	"Speculative Store Bypass: " fmt
 
 static enum ssb_mitigation ssb_mode __ro_after_init =
-	IS_ENABLED(CONFIG_MITIGATION_SSB) ? SPEC_STORE_BYPASS_PRCTL : SPEC_STORE_BYPASS_NONE;
+	IS_ENABLED(CONFIG_MITIGATION_SSB) ? SPEC_STORE_BYPASS_AUTO : SPEC_STORE_BYPASS_NONE;
 
 static const char * const ssb_strings[] = {
 	[SPEC_STORE_BYPASS_NONE]	= "Vulnerable",
@@ -2626,7 +2630,7 @@ static int __init ssb_parse_cmdline(char *str)
 		return 0;
 
 	if (!strcmp(str, "auto"))
-		ssb_mode = SPEC_STORE_BYPASS_PRCTL;
+		ssb_mode = SPEC_STORE_BYPASS_AUTO;
 	else if (!strcmp(str, "on"))
 		ssb_mode = SPEC_STORE_BYPASS_DISABLE;
 	else if (!strcmp(str, "off"))
@@ -2646,11 +2650,18 @@ early_param("spec_store_bypass_disable", ssb_parse_cmdline);
 
 static void __init ssb_select_mitigation(void)
 {
-	if (!boot_cpu_has_bug(X86_BUG_SPEC_STORE_BYPASS) || cpu_mitigations_off()) {
+	if (!boot_cpu_has_bug(X86_BUG_SPEC_STORE_BYPASS)) {
 		ssb_mode = SPEC_STORE_BYPASS_NONE;
 		return;
 	}
 
+	if (ssb_mode == SPEC_STORE_BYPASS_AUTO) {
+		if (should_mitigate_vuln(X86_BUG_SPEC_STORE_BYPASS))
+			ssb_mode = SPEC_STORE_BYPASS_PRCTL;
+		else
+			ssb_mode = SPEC_STORE_BYPASS_NONE;
+	}
+
 	if (!boot_cpu_has(X86_FEATURE_SSBD))
 		ssb_mode = SPEC_STORE_BYPASS_NONE;
 
@@ -2870,6 +2881,7 @@ static int ssb_prctl_get(struct task_struct *task)
 		return PR_SPEC_DISABLE;
 	case SPEC_STORE_BYPASS_SECCOMP:
 	case SPEC_STORE_BYPASS_PRCTL:
+	case SPEC_STORE_BYPASS_AUTO:
 		if (task_spec_ssb_force_disable(task))
 			return PR_SPEC_PRCTL | PR_SPEC_FORCE_DISABLE;
 		if (task_spec_ssb_noexec(task))
-- 
2.34.1


