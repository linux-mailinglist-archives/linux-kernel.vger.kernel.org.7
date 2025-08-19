Return-Path: <linux-kernel+bounces-776402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E46F7B2CCEC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 21:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74F721C20111
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 19:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E9433EB02;
	Tue, 19 Aug 2025 19:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="arrhL3HY"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22025326D45
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 19:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755631342; cv=fail; b=QDtYNmPXDrSMY4fGQdUDxUkW3bGZ/K/kDY0KQ51PfcNaSuS96b0dz7FYMIMM6OrpTdRKpg1oovDIFz5Ymybfl0H/0hTgKlDOygjs8OaQ70BQJrYE9w/maRc8bHejn7ofOTxG3v9rAj/nNin/LYlD6SSjwx0y9GXjkKO3Jna5XC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755631342; c=relaxed/simple;
	bh=MSRM/NMfE2zCgjF4Ju8RUvg60FQ6Vp1Q2EU6tE9H2XQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JmpGP6cBUJdaYcXeKxhIrNm267yHxt12b5aDkHg1Xt+C4PP/nzBh4aLwm7Jde1qaV+H4wNM+jO74UwWUpTEFqyLkXGM6EQTAw7yGd78DfVlZZOB1S7KfSPa8G5mYbn6m0+fUlOXpiKkQ6zjhEe4jlaVxGth4dFZJaXxS2UlIPRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=arrhL3HY; arc=fail smtp.client-ip=40.107.93.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JAbAKAEk5h0y/Y6E5mNUsFL4K+1ZB6dqA0tAiLVwbelreLC/txw26OZxenmsWIxlGe+l4xfzliSI7eSkTVua4IsiCwIrb9vSU1ewqssYhuizjFp1ZZBZ2Pyz0p61+LJV41gvKgRxWsXh+J+7aqKRtfSAvBJzXW66KAw1amC/honUoScB3uSyeomySNrJhmkUFDN26xHfZNwDrpZufHaNs+kNxDNJxE15jhlwgqbwjGsKigA7Q4jom3DQ6gKvaFuGggbnWPoPXIiI5ZHT8YyTSoyJo7xbpMTJKb16UNB0mPsxW7ozEAyBG4ZX3uQYtnMW/fL1hOx1imGTQbBqZHf+hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AhsC68SjhgtzdcTQ9GJ7YQG0w0C+dgKkJrVj8848EE4=;
 b=In8WvPKkBSP7yVlhSkyAkuhT/BNqZdOWpiAzd2QrzfEU0Mto/zSTwWz3JoL7p4azsvxAwkmgY2g1Fb5hTLM1Y9V3RlGN39zCI37Xlo0z4ESPLoc2VCw2i68OuHzsUOlVPeDd0N/NK7GWd7uuNTUK8ZtHIPfmxRMFIhMtUSaltfAPp5MOAPOSHlBBNGr0NO/IeUK7OlRm758a6DzkCNB1pvbuXX37Un1eza0tRYriZ+RszGzv4JPAFv9mNXI2WTv/M4hKrcKl1BXbsdguWG8bOwdSn9qThdKQLAzbH1naUu8qxs6ExSiwV0hekzc2t4Uz207zqC5TZFHFGQzSQYVP3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AhsC68SjhgtzdcTQ9GJ7YQG0w0C+dgKkJrVj8848EE4=;
 b=arrhL3HYH9jKxaZVU1ENPon7nQBwqkbjsclYVegluEz5edtOm1CnjFZMvm+WrnoA1ol8CTGKSjY/VBpToUvGO1n/XTq7pnHZzoGmOYhKEelGFr+czLlgs5bDO3+riht/ZyjMuRt7Qk1za0Ekwy2/GrvhgcpTw6nLVGj5t12tFMI=
Received: from MW4PR04CA0251.namprd04.prod.outlook.com (2603:10b6:303:88::16)
 by MW6PR12MB9020.namprd12.prod.outlook.com (2603:10b6:303:240::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Tue, 19 Aug
 2025 19:22:18 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:303:88:cafe::fa) by MW4PR04CA0251.outlook.office365.com
 (2603:10b6:303:88::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.13 via Frontend Transport; Tue,
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
 2025 14:22:16 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/5] x86/bugs: Use early_param for spectre_v2
Date: Tue, 19 Aug 2025 14:21:57 -0500
Message-ID: <20250819192200.2003074-3-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|MW6PR12MB9020:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c2adf0f-97af-41a8-6178-08dddf55b68f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z7W0zNl33Yy1LHtTn8l9Tq9lfdhkLTT9KWrclNjDrlLPnV9qIPHilp01iLeD?=
 =?us-ascii?Q?kf8FH/qP11+CfwIOuP81Z2bcAse9AxT2i9s0/VqkBV6dgy0xWiXtCUz1d5va?=
 =?us-ascii?Q?2eAChNtbwc5DqfxlQuIZSFGXKt7XQ7UzWetc9AeuROJ1ezOcyDvjBrWl2m2j?=
 =?us-ascii?Q?vqa7JG4w7vtfL3q06hE0WXCAKh5Khbi8vBGWnzxvMuTCu7BEZBjtIzna1ocv?=
 =?us-ascii?Q?eu+ndgW95Y4clFBB/5wiQEecItT1wEqnTs6SiQHFKfF4Pvu8HPP95rsPDDFs?=
 =?us-ascii?Q?dU3asq4Z9YIGB8R1NNRw6PWtEz1RmjprBT4VqM9x2ZO1C9gLpPyWfMhbRCke?=
 =?us-ascii?Q?paymi0G9oNYnct5gVE/SMuFmO2FnbwAY4MFcS5SNu+jOmNSBvccstEN4KSn0?=
 =?us-ascii?Q?g/0E2lAJxauTakVLr9DDYMmTnj6LZUBB5X45DCdCCVcpJFtpcu8HYrl2Qq9i?=
 =?us-ascii?Q?A/VlGTxvC05hV7JBDeWA0h0+tW0FSs6bU+pBVZM45l8631aSUFRhbYCaM0Sb?=
 =?us-ascii?Q?8BHMD2enSqzdtgoQIe4nsiRYVglWWFl0HG5e7KxjuJ1KPjfCoSdYBNLvlUbp?=
 =?us-ascii?Q?gKVREJ0VTbiTPWaL3VMKtZdiKjpv93IjJi/JbNa/ABIMdcYq/bW/Y5xl8BKC?=
 =?us-ascii?Q?maclykfSWc33JORqgJllP3OramECLU5wU6Q9GICaC97AUn5MW6S12+cczeB2?=
 =?us-ascii?Q?MIzwqGDvualZlf3DclIzbP7uQKfz15TLRI/pfSJ+8nY1C+Ny2/w5PdM/t8go?=
 =?us-ascii?Q?uKSoZ49/EWt2CKIhmeMhDAfmz502IUA2aWVPEoFt8FR+kJYyp6lTBK9Cd1hS?=
 =?us-ascii?Q?6YjO1hQaEddmmb451tqSbqjbitYz79wKfJvVFwSVdbz0JMSY6VbOOJjnCYH+?=
 =?us-ascii?Q?1VEjpjq6KOiAeE81wn/ydnhSZP6nFrf5WHWOgptDkzT77Lw081JZc2cN/M+i?=
 =?us-ascii?Q?1TxMbOmzJ1MsRbuzGH5BagQMJ37GY1aBhF1cnCBuAGTdUqBpIm1bQct8Xm1x?=
 =?us-ascii?Q?vEH1KQHtk5qSX1AuurczHK9z2n6+KVGVf2qmLybn2aXrXS2OVhskDC92f1SO?=
 =?us-ascii?Q?h+Z3eJ2gMJAXmHAjrJBIU0f7jObiHhU+qmMUy9ZpnxdHv3rwMxR2Uts0vxRt?=
 =?us-ascii?Q?naGS+pJRgDpt8kqhZBFr9wx0pF8CpQE9TXEKQSdjkYNSw9Ix3MlhW26iaHDH?=
 =?us-ascii?Q?VrHLBM142lTZEm5sAHQHCqh3SH38Z8Qmt7YFTswzbZhmvDdIm+e2D+3yvGRK?=
 =?us-ascii?Q?6nThCQzQ4k/V8GtO9KUNO2nRyb7cqfT3ZRl9ZQy+H7vfBVsvdX73kPEhfx3O?=
 =?us-ascii?Q?ycwJ5zK4cI3iQeoQ1ogK3mFenkLV4ZSePh+iqmrckhjc+QbMnvjhd272vMOT?=
 =?us-ascii?Q?npSl4AC5gpVH2EXTV+OG6JfG73NngfveS39sEnn08b+yF+YPhurbeVHQM8bk?=
 =?us-ascii?Q?exK9QUuE+pOKCRXAbpLSyuo9EE5u0H9rVSzszu9B4f0Sq//bPFJVkVACn3fo?=
 =?us-ascii?Q?N8imcK1sdR7L4N+czG0YzQ0AZ1bBHEGNRn6h?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 19:22:18.3112
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c2adf0f-97af-41a8-6178-08dddf55b68f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9020

Most of the mitigations in bugs.c use early_param for command line parsing.
Rework the spectre_v2 and nospectre_v2 command line options to be
consistent with the others.

Remove spec_v2_print_cond() as informing the user of the their cmdline
choice isn't interesting.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 186 +++++++++++++++++--------------------
 1 file changed, 87 insertions(+), 99 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index de78b76ae851..44e0315b58a5 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1824,7 +1824,8 @@ enum spectre_v2_mitigation_cmd {
 	SPECTRE_V2_CMD_IBRS,
 };
 
-static enum spectre_v2_mitigation_cmd spectre_v2_cmd __ro_after_init = SPECTRE_V2_CMD_AUTO;
+static enum spectre_v2_mitigation_cmd spectre_v2_cmd __ro_after_init =
+	IS_ENABLED(CONFIG_MITIGATION_SPECTRE_V2) ? SPECTRE_V2_CMD_AUTO : SPECTRE_V2_CMD_NONE;
 
 enum spectre_v2_user_mitigation_cmd {
 	SPECTRE_V2_USER_CMD_NONE,
@@ -2021,112 +2022,51 @@ static const char * const spectre_v2_strings[] = {
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
+static bool nospectre_v2 __ro_after_init;
 
-static void __init spec_v2_print_cond(const char *reason, bool secure)
+static int __init nospectre_v2_parse_cmdline(char *str)
 {
-	if (boot_cpu_has_bug(X86_BUG_SPECTRE_V2) != secure)
-		pr_info("%s selected on command line.\n", reason);
+	nospectre_v2 = true;
+	spectre_v2_cmd = SPECTRE_V2_CMD_NONE;
+	return 0;
 }
+early_param("nospectre_v2", nospectre_v2_parse_cmdline);
 
-static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
+static int __init spectre_v2_parse_cmdline(char *str)
 {
-	enum spectre_v2_mitigation_cmd cmd;
-	char arg[20];
-	int ret, i;
-
-	cmd = IS_ENABLED(CONFIG_MITIGATION_SPECTRE_V2) ?  SPECTRE_V2_CMD_AUTO : SPECTRE_V2_CMD_NONE;
-	if (cmdline_find_option_bool(boot_command_line, "nospectre_v2"))
-		return SPECTRE_V2_CMD_NONE;
-
-	ret = cmdline_find_option(boot_command_line, "spectre_v2", arg, sizeof(arg));
-	if (ret < 0)
-		return cmd;
-
-	for (i = 0; i < ARRAY_SIZE(mitigation_options); i++) {
-		if (!match_option(arg, ret, mitigation_options[i].option))
-			continue;
-		cmd = mitigation_options[i].cmd;
-		break;
-	}
-
-	if (i >= ARRAY_SIZE(mitigation_options)) {
-		pr_err("unknown option (%s). Switching to default mode\n", arg);
-		return cmd;
-	}
-
-	if ((cmd == SPECTRE_V2_CMD_RETPOLINE ||
-	     cmd == SPECTRE_V2_CMD_RETPOLINE_LFENCE ||
-	     cmd == SPECTRE_V2_CMD_RETPOLINE_GENERIC ||
-	     cmd == SPECTRE_V2_CMD_EIBRS_LFENCE ||
-	     cmd == SPECTRE_V2_CMD_EIBRS_RETPOLINE) &&
-	    !IS_ENABLED(CONFIG_MITIGATION_RETPOLINE)) {
-		pr_err("%s selected but not compiled in. Switching to AUTO select\n",
-		       mitigation_options[i].option);
-		return SPECTRE_V2_CMD_AUTO;
-	}
-
-	if ((cmd == SPECTRE_V2_CMD_EIBRS ||
-	     cmd == SPECTRE_V2_CMD_EIBRS_LFENCE ||
-	     cmd == SPECTRE_V2_CMD_EIBRS_RETPOLINE) &&
-	    !boot_cpu_has(X86_FEATURE_IBRS_ENHANCED)) {
-		pr_err("%s selected but CPU doesn't have Enhanced or Automatic IBRS. Switching to AUTO select\n",
-		       mitigation_options[i].option);
-		return SPECTRE_V2_CMD_AUTO;
-	}
-
-	if ((cmd == SPECTRE_V2_CMD_RETPOLINE_LFENCE ||
-	     cmd == SPECTRE_V2_CMD_EIBRS_LFENCE) &&
-	    !boot_cpu_has(X86_FEATURE_LFENCE_RDTSC)) {
-		pr_err("%s selected, but CPU doesn't have a serializing LFENCE. Switching to AUTO select\n",
-		       mitigation_options[i].option);
-		return SPECTRE_V2_CMD_AUTO;
-	}
-
-	if (cmd == SPECTRE_V2_CMD_IBRS && !IS_ENABLED(CONFIG_MITIGATION_IBRS_ENTRY)) {
-		pr_err("%s selected but not compiled in. Switching to AUTO select\n",
-		       mitigation_options[i].option);
-		return SPECTRE_V2_CMD_AUTO;
-	}
-
-	if (cmd == SPECTRE_V2_CMD_IBRS && boot_cpu_data.x86_vendor != X86_VENDOR_INTEL) {
-		pr_err("%s selected but not Intel CPU. Switching to AUTO select\n",
-		       mitigation_options[i].option);
-		return SPECTRE_V2_CMD_AUTO;
-	}
+	if (!str)
+		return -EINVAL;
 
-	if (cmd == SPECTRE_V2_CMD_IBRS && !boot_cpu_has(X86_FEATURE_IBRS)) {
-		pr_err("%s selected but CPU doesn't have IBRS. Switching to AUTO select\n",
-		       mitigation_options[i].option);
-		return SPECTRE_V2_CMD_AUTO;
-	}
+	if (nospectre_v2)
+		return 0;
 
-	if (cmd == SPECTRE_V2_CMD_IBRS && cpu_feature_enabled(X86_FEATURE_XENPV)) {
-		pr_err("%s selected but running as XenPV guest. Switching to AUTO select\n",
-		       mitigation_options[i].option);
-		return SPECTRE_V2_CMD_AUTO;
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
 
-	spec_v2_print_cond(mitigation_options[i].option,
-			   mitigation_options[i].secure);
-	return cmd;
+	return 0;
 }
+early_param("spectre_v2", spectre_v2_parse_cmdline);
 
 static enum spectre_v2_mitigation __init spectre_v2_select_retpoline(void)
 {
@@ -2312,9 +2252,57 @@ static void __init bhi_apply_mitigation(void)
 	setup_force_cpu_cap(X86_FEATURE_CLEAR_BHB_VMEXIT);
 }
 
+static void __init spectre_v2_check_cmd(void)
+{
+	if ((spectre_v2_cmd == SPECTRE_V2_CMD_RETPOLINE ||
+	     spectre_v2_cmd == SPECTRE_V2_CMD_RETPOLINE_LFENCE ||
+	     spectre_v2_cmd == SPECTRE_V2_CMD_RETPOLINE_GENERIC ||
+	     spectre_v2_cmd == SPECTRE_V2_CMD_EIBRS_LFENCE ||
+	     spectre_v2_cmd == SPECTRE_V2_CMD_EIBRS_RETPOLINE) &&
+	    !IS_ENABLED(CONFIG_MITIGATION_RETPOLINE)) {
+		pr_err("RETPOLINE selected but not compiled in. Switching to AUTO select\n");
+		spectre_v2_cmd = SPECTRE_V2_CMD_AUTO;
+	}
+
+	if ((spectre_v2_cmd == SPECTRE_V2_CMD_EIBRS ||
+	     spectre_v2_cmd == SPECTRE_V2_CMD_EIBRS_LFENCE ||
+	     spectre_v2_cmd == SPECTRE_V2_CMD_EIBRS_RETPOLINE) &&
+	    !boot_cpu_has(X86_FEATURE_IBRS_ENHANCED)) {
+		pr_err("EIBRS selected but CPU doesn't have Enhanced or Automatic IBRS. Switching to AUTO select\n");
+		spectre_v2_cmd = SPECTRE_V2_CMD_AUTO;
+	}
+
+	if ((spectre_v2_cmd == SPECTRE_V2_CMD_RETPOLINE_LFENCE ||
+	     spectre_v2_cmd == SPECTRE_V2_CMD_EIBRS_LFENCE) &&
+	    !boot_cpu_has(X86_FEATURE_LFENCE_RDTSC)) {
+		pr_err("LFENCE selected, but CPU doesn't have a serializing LFENCE. Switching to AUTO select\n");
+		spectre_v2_cmd = SPECTRE_V2_CMD_AUTO;
+	}
+
+	if (spectre_v2_cmd == SPECTRE_V2_CMD_IBRS && !IS_ENABLED(CONFIG_MITIGATION_IBRS_ENTRY)) {
+		pr_err("IBRS selected but not compiled in. Switching to AUTO select\n");
+		spectre_v2_cmd = SPECTRE_V2_CMD_AUTO;
+	}
+
+	if (spectre_v2_cmd == SPECTRE_V2_CMD_IBRS && boot_cpu_data.x86_vendor != X86_VENDOR_INTEL) {
+		pr_err("IBRS selected but not Intel CPU. Switching to AUTO select\n");
+		spectre_v2_cmd = SPECTRE_V2_CMD_AUTO;
+	}
+
+	if (spectre_v2_cmd == SPECTRE_V2_CMD_IBRS && !boot_cpu_has(X86_FEATURE_IBRS)) {
+		pr_err("IBRS selected but CPU doesn't have IBRS. Switching to AUTO select\n");
+		spectre_v2_cmd = SPECTRE_V2_CMD_AUTO;
+	}
+
+	if (spectre_v2_cmd == SPECTRE_V2_CMD_IBRS && cpu_feature_enabled(X86_FEATURE_XENPV)) {
+		pr_err("IBRS selected but running as XenPV guest. Switching to AUTO select\n");
+		spectre_v2_cmd = SPECTRE_V2_CMD_AUTO;
+	}
+}
+
 static void __init spectre_v2_select_mitigation(void)
 {
-	spectre_v2_cmd = spectre_v2_parse_cmdline();
+	spectre_v2_check_cmd();
 
 	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V2) &&
 	    (spectre_v2_cmd == SPECTRE_V2_CMD_NONE || spectre_v2_cmd == SPECTRE_V2_CMD_AUTO))
-- 
2.34.1


