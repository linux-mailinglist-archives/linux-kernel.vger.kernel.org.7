Return-Path: <linux-kernel+bounces-776404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEAECB2CCEE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 21:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79D187B6B92
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 19:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA778340D9A;
	Tue, 19 Aug 2025 19:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="l/51HxE4"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2447E326D73
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 19:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755631343; cv=fail; b=c6MyZCNDrud+JqjPBZgx3cF6O/70DAKeZ2zl54EUTB0nm6Kd0WlvcxAmYTqzNZWQhRD4dxUkYtaga8sLMmh7CCU68NZEHne4smi6rl0FHcIImmo8qF/4vmi5JP+mOccqyFarAz83mid0JDzdPlZvAyEGXhid5ioB7wWIIX22Va8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755631343; c=relaxed/simple;
	bh=X0hgLp085z/FiPxK6q9CSA+d6Y9GihJCNwny7njyikQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mFaXuHj5iF/rhS8gE5zA+PPjdVchXEXX6evC8cQEDH4vrdAHwoBXSMs3MnNJjJt/gftmPqYfR/M+dYVSfM+ZPWtDUjmqMTZbd3hhU+W7dcgGcR3tNZaqYMDYXCI25DIduC8VqKU13Dvp2azwCm+a0046lZCSOSNPF4JWbX9RP0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=l/51HxE4; arc=fail smtp.client-ip=40.107.92.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cB3MtCOlZr1KdIfhUweW3n9vl++Jg4MYRiovjqK4h5QU0Skxt3UTMNmCjmsAukpcPcGQRxMOv/ExVl0mMbn4VJCYZUEd8KTuFx7/QCNo5aZiKKE0I4CPxXJusVUk0uGlnPrhtlnFPHLDSIxGFgxYsgfWd87k5rgTZyEpG13fQa2h7Xqm6oEgLQeamlqADt4+O99owhPYIyd+ifVe2ySDuDMpjs2wx5fAd93j/qG6Ue0YamgA/WYHd19wOoir/uPT+ul15LSsXf01gE8KqL6hKZ+ECCw5p8ePiPdIRw9oXO7bTRwF/qTDAJxlWcp41zZ2FsORoOez/C62fJtBC7TYyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3dzpX4YY23ZXCGOScgfsVM80o6WO3CYjFA17NTQi2N0=;
 b=SXiuCAS3erFKmaG3iZdOOzXPpnfKTLfwvmNXBo4PX3Sa7TuCBD+y3faDN3f01XrCbNQyrCAN6KXaQuurMEJX4bm8/AMbIsOILJvBPb/Wkoj+0OBSswH5o/UifVx2QHAjyFETtYS8pDEuGmaCFvXEXQsJp2NZb0hn/o0jan0DGTS6CwJ9FdHMybQW40SJAygskeirB/CBFCcyd8UI0NxmC9QIj4LyoqHuJTRH46XnYiKvVg5Crn0muRETdxTmZ+sYUcQoWsZPhSw4khRsh8xHQ5/Nx9hHSlJPtfViN7g3X5X08Ruj/NAdbcVuKXzAjYUwX+18S8u447fSyBmiWui1CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3dzpX4YY23ZXCGOScgfsVM80o6WO3CYjFA17NTQi2N0=;
 b=l/51HxE4oyk0SSKvwbZkaWdkCzqcN4OZ+sqK/nNkb3iWMFatDFln8NXmYNibSBCHsap0N2GRzMJP4vvPtCAPlp+0GkqOIwWVGTE/1ITCDhb4QrBMeqspdN6ImCpfnZHoQLxG7bsd4pM27Du8OR+E4SDHhdtFqS8+fsS1Ka5xTpM=
Received: from MW4PR04CA0268.namprd04.prod.outlook.com (2603:10b6:303:88::33)
 by CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.25; Tue, 19 Aug
 2025 19:22:19 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:303:88:cafe::41) by MW4PR04CA0268.outlook.office365.com
 (2603:10b6:303:88::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.22 via Frontend Transport; Tue,
 19 Aug 2025 19:22:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Tue, 19 Aug 2025 19:22:18 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Aug
 2025 14:22:17 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/5] x86/bugs: Simplify SSB cmdline parsing
Date: Tue, 19 Aug 2025 14:21:58 -0500
Message-ID: <20250819192200.2003074-4-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|CH2PR12MB4181:EE_
X-MS-Office365-Filtering-Correlation-Id: 14e73db9-8240-4ce1-af80-08dddf55b6da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Gm0ygYxMRmyyCxPHOvPMXjdPbAhAnIbgk9qUxiTJt50l1Kj14ZRU0nt9aDXt?=
 =?us-ascii?Q?dzN6C3sB1pxx3C5//hdNjfQMXfvBNY6j7LMxtFNiKnstscYmfbNkOZ1JECTL?=
 =?us-ascii?Q?2QdsBcfX7TFrtriYfi9vKjVFOzzJNYqGtNo5VuPmeeKSE6m499fIH40xt+zD?=
 =?us-ascii?Q?eCBC5z02hMZTwoF+tihyTtsw5iQIiK5vyeL3ZscEcSxxZ7fNjX9y/P68H5bH?=
 =?us-ascii?Q?7KFXcrvFHNxJxWafFS8SJ3FmcfEDqqbGolMDJG+gyTksuXEB4NDi/7eHurFI?=
 =?us-ascii?Q?xdMwhaGfctjmPZZyCrY1KzhjqT87gGV+KG5+hPIQR3VzpqvivBulmp8GiHrn?=
 =?us-ascii?Q?ru9xlXAg+AzCV2K/EvFEiuyPg46csDbbh2XWa4uqbKnTbmt2W1FsYH+v7EDn?=
 =?us-ascii?Q?WEMUsxHY8j3FYFwRbGclpVHQoE573TDnvZETaUbZaJDdPAXvvwHAfHIFpjhb?=
 =?us-ascii?Q?pladgjl9OegrEKi/GYjfiC8wopoRDAsZBrBwlTnR5nZ8F9mz/99R5WQI8yr8?=
 =?us-ascii?Q?y7NB9tEYxYgonUdw7Uaon0UFfQb6jqGrp96PVnCzn6bPZF8usRFerWK3WdGF?=
 =?us-ascii?Q?WrC9zB9lDKPdm2wMDJ4+mbSmoHukxyk+YuyRtG7447JyaW1Px4bMJs6Yjirb?=
 =?us-ascii?Q?ySFR3QRHWUGaVlcQgGmua0GuDDH9iv8KdOqaUOvS8BIN9ih7Twwl25ElFfA0?=
 =?us-ascii?Q?mhHLnr33QwzKx5F56yNrisjzKHJaf0EybUlBsDpwsR7gE/+te+H41aO7fTWq?=
 =?us-ascii?Q?Oe0KaGp8zVqyYzEgO1iHLIuG2FpiIGsZgvdoIwRWY6vp9e4emjzriLWUop7+?=
 =?us-ascii?Q?ydj16OIplRy7hOyFolAApNCMyYNENO5u0Ix8KpYDhSJDy/Nx0a0CpyPxhscK?=
 =?us-ascii?Q?t1X46CsxekzGi6V1VAPGNJ2R4Uj2R0JWdT79eM8SrcTvA/lbEoIDU9ytzVWh?=
 =?us-ascii?Q?1vuixwBVIi8XGadWCdqJMQCEShXbhm2bKG003UoCVUUKXd/ydDvW8bEn23CX?=
 =?us-ascii?Q?Fz+H7MogQTWXS7aeP/WK7B1acWRPckx4xZwAMQNedQEaThrSV3YVbbRwAGMO?=
 =?us-ascii?Q?arCu+STsqq3L4BA2cUP0qSCf1b6Hnh8P6ZOzAVX3lYlV6jbH1c8tnDjhp3rL?=
 =?us-ascii?Q?Kg01LqEmB6jg/l2bQSxMJ8jpnJqNq72TVYexvkM1z1tvYVNgXGLmqnUdHP1J?=
 =?us-ascii?Q?s5wKJk1vE+BIs99N0EJekU0xWrTZRlqCUL09+EwHoMcy2Ni3Sp6J0O8z/nZe?=
 =?us-ascii?Q?3I+EViYmP02WmxYeLa2vwwqD53OBUB8vL8DUe7XfrX6AtnS5tgVBpB9qnM+I?=
 =?us-ascii?Q?UN/lK9PsbDh/FZZR6DwDhUo1PaIAQCezfnXmwv2+vVs8GQTPMtTMCOwBTl0S?=
 =?us-ascii?Q?8TO5HajqVs3gJ25tPGRvsiJFmjWw2gZy7dIZkH7t7oHAp4rbaRdzulg4eiwW?=
 =?us-ascii?Q?85aSWYhIv0dcnLzYYI659PoRTOdGdqWXPhUVAw5mBrjdlJWvvVZqetcLR4gf?=
 =?us-ascii?Q?nlR8GkvNGT2v7OelfMBJ3i3WRPPQi/U6eRI4?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 19:22:18.8131
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14e73db9-8240-4ce1-af80-08dddf55b6da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4181

Simplify the SSB command line parsing by selecting a mitigation directly,
as is done in most of the simpler vulnerabilities.  Use early_param instead
of cmdline_find_option for consistency with the other mitigation
selections.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 118 ++++++++++++-------------------------
 1 file changed, 39 insertions(+), 79 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 44e0315b58a5..8dc654ccdbb9 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2594,16 +2594,8 @@ void cpu_bugs_smt_update(void)
 #undef pr_fmt
 #define pr_fmt(fmt)	"Speculative Store Bypass: " fmt
 
-static enum ssb_mitigation ssb_mode __ro_after_init = SPEC_STORE_BYPASS_NONE;
-
-/* The kernel command line selection */
-enum ssb_mitigation_cmd {
-	SPEC_STORE_BYPASS_CMD_NONE,
-	SPEC_STORE_BYPASS_CMD_AUTO,
-	SPEC_STORE_BYPASS_CMD_ON,
-	SPEC_STORE_BYPASS_CMD_PRCTL,
-	SPEC_STORE_BYPASS_CMD_SECCOMP,
-};
+static enum ssb_mitigation ssb_mode __ro_after_init =
+	IS_ENABLED(CONFIG_MITIGATION_SSB) ? SPEC_STORE_BYPASS_PRCTL : SPEC_STORE_BYPASS_NONE;
 
 static const char * const ssb_strings[] = {
 	[SPEC_STORE_BYPASS_NONE]	= "Vulnerable",
@@ -2612,89 +2604,57 @@ static const char * const ssb_strings[] = {
 	[SPEC_STORE_BYPASS_SECCOMP]	= "Mitigation: Speculative Store Bypass disabled via prctl and seccomp",
 };
 
-static const struct {
-	const char *option;
-	enum ssb_mitigation_cmd cmd;
-} ssb_mitigation_options[]  __initconst = {
-	{ "auto",	SPEC_STORE_BYPASS_CMD_AUTO },    /* Platform decides */
-	{ "on",		SPEC_STORE_BYPASS_CMD_ON },      /* Disable Speculative Store Bypass */
-	{ "off",	SPEC_STORE_BYPASS_CMD_NONE },    /* Don't touch Speculative Store Bypass */
-	{ "prctl",	SPEC_STORE_BYPASS_CMD_PRCTL },   /* Disable Speculative Store Bypass via prctl */
-	{ "seccomp",	SPEC_STORE_BYPASS_CMD_SECCOMP }, /* Disable Speculative Store Bypass via prctl and seccomp */
-};
+static bool nossb __ro_after_init;
 
-static enum ssb_mitigation_cmd __init ssb_parse_cmdline(void)
+static int __init nossb_parse_cmdline(char *str)
 {
-	enum ssb_mitigation_cmd cmd;
-	char arg[20];
-	int ret, i;
+	nossb = true;
+	ssb_mode = SPEC_STORE_BYPASS_NONE;
+	return 0;
+}
+early_param("nospec_store_bypass_disable", nossb_parse_cmdline);
 
-	cmd = IS_ENABLED(CONFIG_MITIGATION_SSB) ?
-		SPEC_STORE_BYPASS_CMD_AUTO : SPEC_STORE_BYPASS_CMD_NONE;
-	if (cmdline_find_option_bool(boot_command_line, "nospec_store_bypass_disable") ||
-	    cpu_mitigations_off()) {
-		return SPEC_STORE_BYPASS_CMD_NONE;
-	} else {
-		ret = cmdline_find_option(boot_command_line, "spec_store_bypass_disable",
-					  arg, sizeof(arg));
-		if (ret < 0)
-			return cmd;
+static int __init ssb_parse_cmdline(char *str)
+{
+	if (!str)
+		return -EINVAL;
 
-		for (i = 0; i < ARRAY_SIZE(ssb_mitigation_options); i++) {
-			if (!match_option(arg, ret, ssb_mitigation_options[i].option))
-				continue;
+	if (!IS_ENABLED(CONFIG_MITIGATION_SSB))
+		return 0;
 
-			cmd = ssb_mitigation_options[i].cmd;
-			break;
-		}
+	if (nossb)
+		return 0;
 
-		if (i >= ARRAY_SIZE(ssb_mitigation_options)) {
-			pr_err("unknown option (%s). Switching to default mode\n", arg);
-			return cmd;
-		}
-	}
+	if (!strcmp(str, "auto"))
+		ssb_mode = SPEC_STORE_BYPASS_PRCTL;
+	else if (!strcmp(str, "on"))
+		ssb_mode = SPEC_STORE_BYPASS_DISABLE;
+	else if (!strcmp(str, "off"))
+		ssb_mode = SPEC_STORE_BYPASS_NONE;
+	else if (!strcmp(str, "prctl"))
+		ssb_mode = SPEC_STORE_BYPASS_PRCTL;
+	else if (!strcmp(str, "seccomp"))
+		ssb_mode = IS_ENABLED(CONFIG_SECCOMP) ?
+			SPEC_STORE_BYPASS_SECCOMP : SPEC_STORE_BYPASS_PRCTL;
+	else
+		pr_err("Ignoring unknown spec_store_bypass_disable option (%s).\n",
+			str);
 
-	return cmd;
+	return 0;
 }
+early_param("spec_store_bypass_disable", ssb_parse_cmdline);
 
 static void __init ssb_select_mitigation(void)
 {
-	enum ssb_mitigation_cmd cmd;
-
-	if (!boot_cpu_has(X86_FEATURE_SSBD))
-		goto out;
-
-	cmd = ssb_parse_cmdline();
-	if (!boot_cpu_has_bug(X86_BUG_SPEC_STORE_BYPASS) &&
-	    (cmd == SPEC_STORE_BYPASS_CMD_NONE ||
-	     cmd == SPEC_STORE_BYPASS_CMD_AUTO))
+	if (!boot_cpu_has_bug(X86_BUG_SPEC_STORE_BYPASS) || cpu_mitigations_off()) {
+		ssb_mode = SPEC_STORE_BYPASS_NONE;
 		return;
-
-	switch (cmd) {
-	case SPEC_STORE_BYPASS_CMD_SECCOMP:
-		/*
-		 * Choose prctl+seccomp as the default mode if seccomp is
-		 * enabled.
-		 */
-		if (IS_ENABLED(CONFIG_SECCOMP))
-			ssb_mode = SPEC_STORE_BYPASS_SECCOMP;
-		else
-			ssb_mode = SPEC_STORE_BYPASS_PRCTL;
-		break;
-	case SPEC_STORE_BYPASS_CMD_ON:
-		ssb_mode = SPEC_STORE_BYPASS_DISABLE;
-		break;
-	case SPEC_STORE_BYPASS_CMD_AUTO:
-	case SPEC_STORE_BYPASS_CMD_PRCTL:
-		ssb_mode = SPEC_STORE_BYPASS_PRCTL;
-		break;
-	case SPEC_STORE_BYPASS_CMD_NONE:
-		break;
 	}
 
-out:
-	if (boot_cpu_has_bug(X86_BUG_SPEC_STORE_BYPASS))
-		pr_info("%s\n", ssb_strings[ssb_mode]);
+	if (!boot_cpu_has(X86_FEATURE_SSBD))
+		ssb_mode = SPEC_STORE_BYPASS_NONE;
+
+	pr_info("%s\n", ssb_strings[ssb_mode]);
 }
 
 static void __init ssb_apply_mitigation(void)
-- 
2.34.1


