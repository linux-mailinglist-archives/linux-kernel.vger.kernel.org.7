Return-Path: <linux-kernel+bounces-817090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 741E2B57DD4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 603334C07CE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0B830EF80;
	Mon, 15 Sep 2025 13:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vmt6OepF"
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010040.outbound.protection.outlook.com [52.101.85.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935FD1F3D56
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 13:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757944049; cv=fail; b=EAtNRj8b4hw7ljfEYqDu7ZWHO94S60MsY1bhlwCcUFMTf1JOqY+/3a+xXn4vol2B3xvSptPkkb16uwlyP4jtwSR5Q6ejXe7hZnNRvw131tK5ztvVqATfOPniDeKa3Ifg1J3d7yExc6Nn68S0d4bhj4K8chcxP5JzeHjROPWbI1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757944049; c=relaxed/simple;
	bh=CL5r61ZPqYvtoxkuyuhDgKKVYPcIvtA3S6/dplBgceQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dzyBa7zC9yY1xhwXC9hd2GaqMMR0RAWj+7qpBvm1y84qiwZRLuFaVrE/JbGtZlkz1x/wqdqaGbKxsGLDPqZjTDTDeeZBzGWhxIsODrjZ6L6uubUzFt4n3T+QqJkZk2gRjtKJ+PJr8ND2KjvxB8P0fLTz7G6vvJfEHFbBVokWkzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vmt6OepF; arc=fail smtp.client-ip=52.101.85.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hn+NfSUKi52k8pkyqenCgY7C4T9g2oFX17T40elG9qj3eA7i9BMFZ+A4mRiWyGioAx7uOAMiYNfQW8VuNQAlbHushSxx/0dJL/X7xkS/vbhr+XkbOsTWynud6VCLCYuxjwEswCETPhhNalNvQSJq0YYXbHFJkpoPTrNQIJc/+MyoEQIgCS1acigckXnAh3ecDxo3DO02sOKI6f17vP2wAdp625Bhpf20oDjV+yBkRI47xism7ytdOdWE5KIPq8XxOekhJBqOb6PGzwsQsplWJWWQer3G/yLOHbJDokOaWrPCcHZ7cli8HDQz5VuzNHJB5o5hDok6MLpXeYpTlHfPsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pj9FXj8QQp/CLXjmSx5sAOjVkl9+MhXF8b3d7A6yprE=;
 b=rer9EsVxiPAyMWNy2S41856AHOtswHxmWMGV1CwZ9TzGRBYAda/CwohQen65lUrHkHhGhAV9kM4Jn1o9s4vsbYhtsYVRgMWAgez4ZNR2rprqgyzo6dmOt7P58sCdDXzNz2oO5baVZLVT7P1HMYmoUA15rv9m6JpDxvYjdN5LvayMvExSTuily5CUJfs8LaE3T3w8KKI5v9lSCtq3/YvZjjqG1GshSjZDWvModpvh0mFVsyUjywDWG6uF3jV72ZFOG6XI0TJLzeIu8iTiyN6kDEgH8SoncvYrhpl+Clr8VZjg8VGs0L2ohey5paZGnPcvNIosClEDgTE7mroGSLGJtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pj9FXj8QQp/CLXjmSx5sAOjVkl9+MhXF8b3d7A6yprE=;
 b=vmt6OepFzNUkQFQDJUCnHLyc6sOvxmsIDaVlwNf5RSHgpZ9A8T8bFhPZFad/isaKl9jWYhQ+aJGmIMC6BkW+IqBjVPOcnP/HQJVk9eh0hwaeZSS7Dq8fUae3TX7I7weqg7L44QBsiQ488DiN5nwCLks8e5HAVLMgUnDVwzdrrfA=
Received: from SJ0PR03CA0104.namprd03.prod.outlook.com (2603:10b6:a03:333::19)
 by CH1PPF931B95D07.namprd12.prod.outlook.com (2603:10b6:61f:fc00::619) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Mon, 15 Sep
 2025 13:47:25 +0000
Received: from SJ5PEPF000001D4.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::1f) by SJ0PR03CA0104.outlook.office365.com
 (2603:10b6:a03:333::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.21 via Frontend Transport; Mon,
 15 Sep 2025 13:47:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D4.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 15 Sep 2025 13:47:25 +0000
Received: from tiny.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Sep
 2025 06:47:22 -0700
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/7] x86/bugs: Use early_param for spectre_v2
Date: Mon, 15 Sep 2025 08:47:01 -0500
Message-ID: <20250915134706.3201818-3-david.kaplan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250915134706.3201818-1-david.kaplan@amd.com>
References: <20250915134706.3201818-1-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D4:EE_|CH1PPF931B95D07:EE_
X-MS-Office365-Filtering-Correlation-Id: 14751a00-5067-4a96-5d26-08ddf45e672d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nMsDj2OeLNFiSRtH3LA4o5TI3jRGp9npd7ENMaijrHNnYoLjcWgJjEFMC0m8?=
 =?us-ascii?Q?AJ6r0Zt/b44H9NhCIXGzipjRfh+NlVV8EO1/bCSrdSfCjhjhzzIyA1NEPCEU?=
 =?us-ascii?Q?OKVs4TfLH0gz2cSW0eZwKEdW+6cm7vmXV5pU4hxwdO/t0QtiwC8jvHrceEAv?=
 =?us-ascii?Q?pmrElpoDJgiGGvJj2UjAaqMPgAgH1pViFrAr07qVAQABdQmC8ttlp8/FvGwt?=
 =?us-ascii?Q?6ufx/4oxXiLU0bggH7fNxG38KqQOvGtz6sgPkRbBh1BpOmZokUqVZLK2Uz5B?=
 =?us-ascii?Q?g/tH2P1HJEr3n52Ws84E5/aPjhyzftQ8CuU5hwnFdYGdpgAh6xOaTCRn6p77?=
 =?us-ascii?Q?np6qfNgy37CJ+L0BdQasmLvjia2ArPrxXs8wiUzZCIpv2nVd6UpbmfVplk6j?=
 =?us-ascii?Q?13RuZZyC7DkhPB7S8e/iN8+s01hPpXFAjmGv7W6GsmSimrqWKv49cBp1d9PO?=
 =?us-ascii?Q?2dcPWTimmYYJa6ajXPl9YSLsKWApS6IcgxNYGEpLnmNusImu2K9mqkoevSIR?=
 =?us-ascii?Q?1YPomncG47pjDFTqYCUZTOcQONoTdytcwOg3ISAPpR8mtRjjPXSwKDyT1FQQ?=
 =?us-ascii?Q?jRR6GMSGKcMgnT/pbAd6OTu/JUtXFfUD03kxta7YPFvq1l9x8jbwme1PGiYt?=
 =?us-ascii?Q?DJO1h+c0uFuFHay9DygS0miwOprXeLDbIY8fj44ndNjPK2QYQLpSgarBHkqS?=
 =?us-ascii?Q?Bi/cXQZpsEjkCg2eGSv579AcOxrTcXb4MqF8RqUDXvZO4cyhqeYfEqSAyN0f?=
 =?us-ascii?Q?g2QemZ/2zq1gr+uGeGBCGwJyAz8Di38isp4dPq8AylcTU73xEgNSny/449Hc?=
 =?us-ascii?Q?V6frEIW/3MV7LvZr8CSEiyEd6r8n5aWTNKzeUOro6kbm/1hMXZzmsr606mox?=
 =?us-ascii?Q?2gv6GqlMAgNVVWbdbnPt1CfXQ8Dsrs1307JZulVbgKlNXN6fNSuiMmiVlc1B?=
 =?us-ascii?Q?vMcnUfNB3nOvmfp+qAiHkqpkN90VHohp3fvr+rfkxbCRfiw4JFy0TUeuKZY6?=
 =?us-ascii?Q?MBRN9kE4uRllNjtigxLM22DB8S0htSef8bkWFdEJjIR6eI1cqS0vQ/h1LJnA?=
 =?us-ascii?Q?7DRKyWmZ+YBYUV3IBFyI4wUhagq2olVEwhx+GKUdZ45VW1YfEzQnhusfvMXS?=
 =?us-ascii?Q?XnN9Ec06fmHrUNJkBipBmCMXiatYp1dXEwK5/DF1+4oaDAKMqSPoG1YT6EY/?=
 =?us-ascii?Q?d+euAGI4oDCcrziDl/+JllUTqVtzIgpJEIbbN2BdgeiaKrrTS/3B0KBuRkVn?=
 =?us-ascii?Q?K3xUX4HV2Fps9RTY1s9geSCzd4oiayKn0ZP/ypWwQShDgH5r8EvOgqVmirmF?=
 =?us-ascii?Q?N4yo46cIomM9143iJlgBCXJi2H4wOBJXXQMJk+sULCB6Ly8mT9/6/pTJHDZC?=
 =?us-ascii?Q?pSJMZEycDO8AcLD/5+Iee42AgDNCf03umY3tBvcjwywX8S0tixCXSkCFdiBK?=
 =?us-ascii?Q?h4iFXjFrD1amdP2VV+wsKFuodAPXPc3wK54CDPq/OvV7r8kO33mwNjWQVd1V?=
 =?us-ascii?Q?aCNXe2EHnk+OKEFC+vouyJGWloBIphgIFd7X?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 13:47:25.0273
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14751a00-5067-4a96-5d26-08ddf45e672d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF931B95D07

Most of the mitigations in bugs.c use early_param for command line parsing.
Rework the spectre_v2 and nospectre_v2 command line options to be
consistent with the others.

Remove spec_v2_print_cond() as informing the user of the their cmdline
choice isn't interesting.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
Reviewed-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/kernel/cpu/bugs.c | 186 +++++++++++++++++--------------------
 1 file changed, 87 insertions(+), 99 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index a5072ec6e5c5..aa2eb2e7878f 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1845,7 +1845,8 @@ enum spectre_v2_mitigation_cmd {
 	SPECTRE_V2_CMD_IBRS,
 };
 
-static enum spectre_v2_mitigation_cmd spectre_v2_cmd __ro_after_init = SPECTRE_V2_CMD_AUTO;
+static enum spectre_v2_mitigation_cmd spectre_v2_cmd __ro_after_init =
+	IS_ENABLED(CONFIG_MITIGATION_SPECTRE_V2) ? SPECTRE_V2_CMD_AUTO : SPECTRE_V2_CMD_NONE;
 
 enum spectre_v2_user_mitigation_cmd {
 	SPECTRE_V2_USER_CMD_NONE,
@@ -2039,112 +2040,51 @@ static const char * const spectre_v2_strings[] = {
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
@@ -2330,9 +2270,57 @@ static void __init bhi_apply_mitigation(void)
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


