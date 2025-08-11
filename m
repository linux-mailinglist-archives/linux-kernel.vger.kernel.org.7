Return-Path: <linux-kernel+bounces-762887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55522B20BE2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 16:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F5CC17008C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E230524502E;
	Mon, 11 Aug 2025 14:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DFVMoLZ9"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2065.outbound.protection.outlook.com [40.107.102.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225502165EC
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 14:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754922436; cv=fail; b=XSSstQ5EYfpj/86vZFBTeLtNCetV/qbIbi24Tz62qj0XW0WzG8HhOExt1Sy2G4whO8TOYlX5A4Ya7dYtlIjOxlbxeipubE03t0aOFGF8UAs4wzmeo5248KVIrImQ1eAZy6buu7PZMrf9t/oZshD43iFuNsuUaLm5FNqnwh5TsFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754922436; c=relaxed/simple;
	bh=abW6JAHrSsRrx0OGgKeVqF+683qTLvQ1BN+bgYIP4kk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eY/Rgme40CZ6JwUwBbbm27oDNXf2Z7/ZQJtoZU1s4X543VRihLXSQFD9Av8vAmqYtsAL3oQHMyCDK18SHJ5MA1ogujHpjan+PSxVJEEOMn67wblke/dvQnOzUpjkbndiNvq9Z9/VIncovXwszUq4Vxf7Is3fLmelS1nqb/iixuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DFVMoLZ9; arc=fail smtp.client-ip=40.107.102.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q+Bblgq9ikg/2DK1cnHzrErJ+J1h3R68wahZMgeIXqqdXqZJMEcBBASy2BqtUBr24C1bWeZxIkt2aygNe0lDC9lYKzEiL1sJ9PZmkcz5emngqQTfXWGVBFPxQ9ELFkfzybSUFRgsDaMerOo1sw96GZE9mJl+uY9yk2+LqAghkC/diwzqoBQlTxEwTENi4R3kUzRfr0ogMzVeaj2x6bKrlV/UI2LLpInGdu9gSeBMtXTl6MZjASxXrk2MWCmcr7P1AQ1Jo3EXj4sZ7bzIp33BsTHAY8zAsE2/cgRq21HXQrF6m/A2n+mPzW6DyOQGcyeK2KsT1JC9UWSj/Md/J7lPOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=byupWgkLKjKkfNQK6YZ8W+a4zOb/RrOorOnRl4HAQiU=;
 b=UzGVat4q3yhZQVAmFkN+imQODfX3NmLJA97RqWSD8ukDWoFHoDd7fMNZ4Z8ynZJ+zjxabaQMSD7LDUqcJUEXQStbK19H/+bTSZbjK4rdp3ZNCe+e3yZL0NgMisBLGbdIQyqwAhzB+KV/MXopSSYXS3nEiG2BlQLOLfGw9nHDO3Cuk5weBONHG9rmhacuMKEXJ6g49lnzRX6NfvJikVHVTeB9tbCxcKM0K+DuucFGgWo+NAvhRo2fF0C9ZC+UcC76PAR0svwKPx4Y+CJb3ftPtS0lLaOeHlqsR7HOyw9miJ0xqGvsMa46SrnB4E+OXokIAjJa0xDculL4uQX6o9MFTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=byupWgkLKjKkfNQK6YZ8W+a4zOb/RrOorOnRl4HAQiU=;
 b=DFVMoLZ9QRq7VF2IBBV8QcGCMLUCJ2uppmZYC1ESbQ2dH0xnsXZ0n/gmPvNcRbbhlWNV9rrCJ7IJ705tjNGjCDtna1r8FCwnXqlV0ullLX6vk3O+I/lJaANHyu81+hW8GkJcvHqs+bMth19VGYYhhXGbKKst1TqenGhRKef39dQ=
Received: from MW3PR05CA0029.namprd05.prod.outlook.com (2603:10b6:303:2b::34)
 by PH7PR12MB7892.namprd12.prod.outlook.com (2603:10b6:510:27e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Mon, 11 Aug
 2025 14:27:12 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:303:2b:cafe::ed) by MW3PR05CA0029.outlook.office365.com
 (2603:10b6:303:2b::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.13 via Frontend Transport; Mon,
 11 Aug 2025 14:27:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Mon, 11 Aug 2025 14:27:12 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Aug
 2025 09:27:10 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] x86/bugs: Use early_param for spectre_v2
Date: Mon, 11 Aug 2025 09:26:58 -0500
Message-ID: <20250811142659.152248-3-david.kaplan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250811142659.152248-1-david.kaplan@amd.com>
References: <20250811142659.152248-1-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|PH7PR12MB7892:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ab028d2-7adb-4c19-4e7f-08ddd8e329a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Wa3e4XEDRc6albx4ntIuEeJgL5bETEvtgoRzvhT+FYufQZHhvWLp8KEXqJPM?=
 =?us-ascii?Q?6fzV+KjmM+FyzGhVEYBWHofxAzyb4SGncVVrn0HWUKmShBGfz1JSK/Txe3On?=
 =?us-ascii?Q?PGLcdA8suEoob6XjPCt3iG3UEOoo75K7iBHoRYLJJlTtchA26uMIZJ/oWdEA?=
 =?us-ascii?Q?+cimqwHfOAIYd4w2SJ9EfOIX5nEWWgVkC6kuxc9Wi1N6ekmvt9uMr0Lwjw3s?=
 =?us-ascii?Q?xRRRlmpdO2oMaA2ijxZsr8vD92mA/CkQRccMjY/FzdTEQ91NKSEBMvW9o0MG?=
 =?us-ascii?Q?cRU73UsR4Dr66Lbo08KTxbL6LJV+msdupG68sbMw+ZBQLBm7ls1IR0k3/0gC?=
 =?us-ascii?Q?Pf5hjaiOQqgvnsP7jvrGQJ5gqUOEpj3x05nbZB+IanzWSTwByMaiwdSbcDMj?=
 =?us-ascii?Q?98wXVRCvUHPLz8wuj7bBbLWzkBCwzmi7rV/PsVs01cNvyJta6dxQj+cvx8k/?=
 =?us-ascii?Q?4MXL/liRxxJq2Up6cHMpOuBPCnaFRvU3UPeNs8SvhrUUJSyBqKe/fU/Zc9qz?=
 =?us-ascii?Q?b6Y27Pk1qJS1q/kvqnEjbh+cWMN8C3GPLLU5frvB2HrZMEpTXPmw2d5KzM6c?=
 =?us-ascii?Q?OBhGB6yHxSxtorPyRdNXOUZd6XjFgTl2q8Nacw8r/L6O9DcyDN7qzuOB5S20?=
 =?us-ascii?Q?m93WZ4O0hBrKA+g3A7JR8bJ6nFEcfpUGs2LeXCnththSmUXuV6CM2kmN5rmy?=
 =?us-ascii?Q?FSKo+0X78PdssD1tHmDB9uItnyp/2/AU6MOp5pRKvprYtYzFygctkmVcEYoq?=
 =?us-ascii?Q?d13IStR+KGTNy4otd0IFaUJw4rHljt9kyHc8NMBsZ6xQbd0f34NQNKmOktIc?=
 =?us-ascii?Q?JjqkkhI5Kn4Nhdm9IezphbxMlfDCrukTN9ppPZpGOnm+8V5XqfNeW7n4Y7SZ?=
 =?us-ascii?Q?ZcCsaFCL9pxK0sBk1Frju1P6Q2qKChhuU2QGHlvcNXPJNgJE06fthtUkPxSp?=
 =?us-ascii?Q?k8IBfOTWsUddNZd3oXhZWM4+yX72x1y5pnDCYi08JomeaeD3pwY2oC857j5j?=
 =?us-ascii?Q?MtFZLAgqeGaG4+e93FxLVK++tggEqjfaDRQCUr/GOOF1ivCo5NldHfdYS7Ak?=
 =?us-ascii?Q?lnbHdxrPrkRjSF8SvaOHPNuq0F1I8GU9es8WzL06YstDmwGG3Z0g9ksQi3Vd?=
 =?us-ascii?Q?931cH0KNEOYgU++CwGicJpp4+VCemDp2r/dTogX2s1MsQuqTfsSmQE27aeCK?=
 =?us-ascii?Q?iQSnK53jyfzoDf4vRPg+SAeX4ykpCPAoK8KN6u0Dt3Fq19GVpG8EvKZ/Ketb?=
 =?us-ascii?Q?IJjxnf7iJECXddpl1EY53gJu/0PbYOgDo7RetrN+mNUYxZXQB5JBgCrXGqVm?=
 =?us-ascii?Q?qFuw3WwHfpBUxGuD4NBCNZIUCCODvzgMPKPZHjb3PhCcMWD4z2FwulpEskl8?=
 =?us-ascii?Q?iY9S3W7xKB9kNVXRl//weybHsFRIFM+qmyy0El9RdozDrQff4r7Fi0cg2Mwe?=
 =?us-ascii?Q?Gn2BBj/Q8MC6leXLORUlJBRetKwCpD/pIJtv6VsC2rShFF/bRQJnUaXl+u86?=
 =?us-ascii?Q?SUE/+Zpv8Bpb6uB6B5vw0v9RZppXDus/bO7k?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 14:27:12.3598
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ab028d2-7adb-4c19-4e7f-08ddd8e329a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7892

Most of the mitigations in bugs.c use early_param for command line parsing.
Rework the spectre_v2 and nospectre_v2 command line options to be
consistent with the others.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 151 +++++++++++++++++++------------------
 1 file changed, 78 insertions(+), 73 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 6bfe199b9f3e..19a3891953c3 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1827,7 +1827,8 @@ enum spectre_v2_mitigation_cmd {
 	SPECTRE_V2_CMD_IBRS,
 };
 
-static enum spectre_v2_mitigation_cmd spectre_v2_cmd __ro_after_init = SPECTRE_V2_CMD_AUTO;
+static enum spectre_v2_mitigation_cmd spectre_v2_cmd __ro_after_init =
+	IS_ENABLED(CONFIG_MITIGATION_SPECTRE_V2) ? SPECTRE_V2_CMD_AUTO : SPECTRE_V2_CMD_NONE;
 
 enum spectre_v2_user_mitigation_cmd {
 	SPECTRE_V2_USER_CMD_NONE,
@@ -2035,112 +2036,118 @@ static const char * const spectre_v2_strings[] = {
 	[SPECTRE_V2_IBRS]			= "Mitigation: IBRS",
 };
 
-static const struct {
-	const char *option;
-	enum spectre_v2_mitigation_cmd cmd;
-	bool secure;
-} mitigation_options[] __initconst = {
-	{ "off",		SPECTRE_V2_CMD_NONE,		  false },
-	{ "on",			SPECTRE_V2_CMD_FORCE,		  true  },
-	{ "retpoline",		SPECTRE_V2_CMD_RETPOLINE,	  false },
-	{ "retpoline,amd",	SPECTRE_V2_CMD_RETPOLINE_LFENCE,  false },
-	{ "retpoline,lfence",	SPECTRE_V2_CMD_RETPOLINE_LFENCE,  false },
-	{ "retpoline,generic",	SPECTRE_V2_CMD_RETPOLINE_GENERIC, false },
-	{ "eibrs",		SPECTRE_V2_CMD_EIBRS,		  false },
-	{ "eibrs,lfence",	SPECTRE_V2_CMD_EIBRS_LFENCE,	  false },
-	{ "eibrs,retpoline",	SPECTRE_V2_CMD_EIBRS_RETPOLINE,	  false },
-	{ "auto",		SPECTRE_V2_CMD_AUTO,		  false },
-	{ "ibrs",		SPECTRE_V2_CMD_IBRS,              false },
-};
-
 static void __init spec_v2_print_cond(const char *reason, bool secure)
 {
 	if (boot_cpu_has_bug(X86_BUG_SPECTRE_V2) != secure)
 		pr_info("%s selected on command line.\n", reason);
 }
 
-static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
-{
-	enum spectre_v2_mitigation_cmd cmd;
-	char arg[20];
-	int ret, i;
+static bool nospectre_v2 __ro_after_init;
 
-	cmd = IS_ENABLED(CONFIG_MITIGATION_SPECTRE_V2) ?  SPECTRE_V2_CMD_AUTO : SPECTRE_V2_CMD_NONE;
-	if (cmdline_find_option_bool(boot_command_line, "nospectre_v2"))
-		return SPECTRE_V2_CMD_NONE;
+static int __init nospectre_v2_parse_cmdline(char *str)
+{
+	nospectre_v2 = true;
+	spectre_v2_cmd = SPECTRE_V2_CMD_NONE;
+	return 0;
+}
+early_param("nospectre_v2", nospectre_v2_parse_cmdline);
 
-	ret = cmdline_find_option(boot_command_line, "spectre_v2", arg, sizeof(arg));
-	if (ret < 0)
-		return cmd;
+static int __init spectre_v2_parse_cmdline(char *str)
+{
+	if (!str)
+		return -EINVAL;
 
-	for (i = 0; i < ARRAY_SIZE(mitigation_options); i++) {
-		if (!match_option(arg, ret, mitigation_options[i].option))
-			continue;
-		cmd = mitigation_options[i].cmd;
-		break;
-	}
+	if (nospectre_v2)
+		return 0;
 
-	if (i >= ARRAY_SIZE(mitigation_options)) {
-		pr_err("unknown option (%s). Switching to default mode\n", arg);
-		return cmd;
-	}
+	if (!strcmp(str, "off"))
+		spectre_v2_cmd = SPECTRE_V2_CMD_NONE;
+	else if (!strcmp(str, "on"))
+		spectre_v2_cmd = SPECTRE_V2_CMD_FORCE;
+	else if (!strcmp(str, "retpoline"))
+		spectre_v2_cmd = SPECTRE_V2_CMD_RETPOLINE;
+	else if (!strcmp(str, "retpoline,amd") ||
+		 !strcmp(str, "retpoline,lfence"))
+		spectre_v2_cmd = SPECTRE_V2_CMD_RETPOLINE_LFENCE;
+	else if (!strcmp(str, "retpoline,generic"))
+		spectre_v2_cmd = SPECTRE_V2_CMD_RETPOLINE_GENERIC;
+	else if (!strcmp(str, "eibrs"))
+		spectre_v2_cmd = SPECTRE_V2_CMD_EIBRS;
+	else if (!strcmp(str, "eibrs,lfence"))
+		spectre_v2_cmd = SPECTRE_V2_CMD_EIBRS_LFENCE;
+	else if (!strcmp(str, "eibrs,retpoline"))
+		spectre_v2_cmd = SPECTRE_V2_CMD_EIBRS_RETPOLINE;
+	else if (!strcmp(str, "auto"))
+		spectre_v2_cmd = SPECTRE_V2_CMD_AUTO;
+	else if (!strcmp(str, "ibrs"))
+		spectre_v2_cmd = SPECTRE_V2_CMD_IBRS;
+	else
+		pr_err("Ignoring unknown spectre_v2 option (%s).", str);
 
-	if ((cmd == SPECTRE_V2_CMD_RETPOLINE ||
-	     cmd == SPECTRE_V2_CMD_RETPOLINE_LFENCE ||
-	     cmd == SPECTRE_V2_CMD_RETPOLINE_GENERIC ||
-	     cmd == SPECTRE_V2_CMD_EIBRS_LFENCE ||
-	     cmd == SPECTRE_V2_CMD_EIBRS_RETPOLINE) &&
+	if ((spectre_v2_cmd == SPECTRE_V2_CMD_RETPOLINE ||
+	     spectre_v2_cmd == SPECTRE_V2_CMD_RETPOLINE_LFENCE ||
+	     spectre_v2_cmd == SPECTRE_V2_CMD_RETPOLINE_GENERIC ||
+	     spectre_v2_cmd == SPECTRE_V2_CMD_EIBRS_LFENCE ||
+	     spectre_v2_cmd == SPECTRE_V2_CMD_EIBRS_RETPOLINE) &&
 	    !IS_ENABLED(CONFIG_MITIGATION_RETPOLINE)) {
 		pr_err("%s selected but not compiled in. Switching to AUTO select\n",
-		       mitigation_options[i].option);
-		return SPECTRE_V2_CMD_AUTO;
+			str);
+		spectre_v2_cmd = SPECTRE_V2_CMD_AUTO;
 	}
 
-	if ((cmd == SPECTRE_V2_CMD_EIBRS ||
-	     cmd == SPECTRE_V2_CMD_EIBRS_LFENCE ||
-	     cmd == SPECTRE_V2_CMD_EIBRS_RETPOLINE) &&
+	if ((spectre_v2_cmd == SPECTRE_V2_CMD_EIBRS ||
+	     spectre_v2_cmd == SPECTRE_V2_CMD_EIBRS_LFENCE ||
+	     spectre_v2_cmd == SPECTRE_V2_CMD_EIBRS_RETPOLINE) &&
 	    !boot_cpu_has(X86_FEATURE_IBRS_ENHANCED)) {
 		pr_err("%s selected but CPU doesn't have Enhanced or Automatic IBRS. Switching to AUTO select\n",
-		       mitigation_options[i].option);
-		return SPECTRE_V2_CMD_AUTO;
+		       str);
+		spectre_v2_cmd = SPECTRE_V2_CMD_AUTO;
 	}
 
-	if ((cmd == SPECTRE_V2_CMD_RETPOLINE_LFENCE ||
-	     cmd == SPECTRE_V2_CMD_EIBRS_LFENCE) &&
+	if ((spectre_v2_cmd == SPECTRE_V2_CMD_RETPOLINE_LFENCE ||
+	     spectre_v2_cmd == SPECTRE_V2_CMD_EIBRS_LFENCE) &&
 	    !boot_cpu_has(X86_FEATURE_LFENCE_RDTSC)) {
 		pr_err("%s selected, but CPU doesn't have a serializing LFENCE. Switching to AUTO select\n",
-		       mitigation_options[i].option);
-		return SPECTRE_V2_CMD_AUTO;
+		       str);
+		spectre_v2_cmd = SPECTRE_V2_CMD_AUTO;
 	}
 
-	if (cmd == SPECTRE_V2_CMD_IBRS && !IS_ENABLED(CONFIG_MITIGATION_IBRS_ENTRY)) {
+	if (spectre_v2_cmd == SPECTRE_V2_CMD_IBRS && !IS_ENABLED(CONFIG_MITIGATION_IBRS_ENTRY)) {
 		pr_err("%s selected but not compiled in. Switching to AUTO select\n",
-		       mitigation_options[i].option);
-		return SPECTRE_V2_CMD_AUTO;
+		       str);
+		spectre_v2_cmd = SPECTRE_V2_CMD_AUTO;
 	}
 
-	if (cmd == SPECTRE_V2_CMD_IBRS && boot_cpu_data.x86_vendor != X86_VENDOR_INTEL) {
+	if (spectre_v2_cmd == SPECTRE_V2_CMD_IBRS && boot_cpu_data.x86_vendor != X86_VENDOR_INTEL) {
 		pr_err("%s selected but not Intel CPU. Switching to AUTO select\n",
-		       mitigation_options[i].option);
-		return SPECTRE_V2_CMD_AUTO;
+		       str);
+		spectre_v2_cmd = SPECTRE_V2_CMD_AUTO;
 	}
 
-	if (cmd == SPECTRE_V2_CMD_IBRS && !boot_cpu_has(X86_FEATURE_IBRS)) {
+	if (spectre_v2_cmd == SPECTRE_V2_CMD_IBRS && !boot_cpu_has(X86_FEATURE_IBRS)) {
 		pr_err("%s selected but CPU doesn't have IBRS. Switching to AUTO select\n",
-		       mitigation_options[i].option);
-		return SPECTRE_V2_CMD_AUTO;
+		       str);
+		spectre_v2_cmd = SPECTRE_V2_CMD_AUTO;
 	}
 
-	if (cmd == SPECTRE_V2_CMD_IBRS && cpu_feature_enabled(X86_FEATURE_XENPV)) {
+	if (spectre_v2_cmd == SPECTRE_V2_CMD_IBRS && cpu_feature_enabled(X86_FEATURE_XENPV)) {
 		pr_err("%s selected but running as XenPV guest. Switching to AUTO select\n",
-		       mitigation_options[i].option);
-		return SPECTRE_V2_CMD_AUTO;
+		       str);
+		spectre_v2_cmd = SPECTRE_V2_CMD_AUTO;
 	}
 
-	spec_v2_print_cond(mitigation_options[i].option,
-			   mitigation_options[i].secure);
-	return cmd;
+	/* Print a warning if forcing an option.  AUTO is not forcing. */
+	if (spectre_v2_cmd == SPECTRE_V2_CMD_AUTO)
+		return 0;
+
+	if (spectre_v2_cmd == SPECTRE_V2_CMD_FORCE)
+		spec_v2_print_cond(str, true);
+	else
+		spec_v2_print_cond(str, false);
+
+	return 0;
 }
+early_param("spectre_v2", spectre_v2_parse_cmdline);
 
 static enum spectre_v2_mitigation __init spectre_v2_select_retpoline(void)
 {
@@ -2328,8 +2335,6 @@ static void __init bhi_apply_mitigation(void)
 
 static void __init spectre_v2_select_mitigation(void)
 {
-	spectre_v2_cmd = spectre_v2_parse_cmdline();
-
 	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V2) &&
 	    (spectre_v2_cmd == SPECTRE_V2_CMD_NONE || spectre_v2_cmd == SPECTRE_V2_CMD_AUTO))
 		return;
-- 
2.34.1


