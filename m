Return-Path: <linux-kernel+bounces-762889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8696B20BE7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 16:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7D0D3AB94F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93AF246794;
	Mon, 11 Aug 2025 14:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PHJYb6P7"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415F3244196
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 14:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754922437; cv=fail; b=IB/o4w6nU2cm/9g8YShLJsBhT+zjltMHjdO1TaEgEnhY6MUI8ccgrcmUwMI/KRnLVg8cKWkt7vIRunHRT1p4GYthXk8iBQ0MtpAdXyZ448ZcLpk3gRXwVYIAIWlFLWNLrEMDzxjRWBAvvexKkfshyuTN9b1Y3m1jQ/QoHWvqyCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754922437; c=relaxed/simple;
	bh=XAWOo5K8DB8LHQ91pGuwfjp+oyrQpVKxd3kT7fqHXjk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XZeMsMEUBnkZnL1UFrzcZgHE7rJI+IB8m522U57n2G+uuzOJv+pYqCRPRuMX/oWRQ4Dd226yXpxFGGTG516wZFgmSA4UVyrhVt47EljfgXRG5N/8s91+62OdhcvJbzWrWEsH5brWFyzfIAwiS/u5ztIFi/M7h04O4U6Ou514kMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PHJYb6P7; arc=fail smtp.client-ip=40.107.236.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PVFvLhOCjjYTi8BeGBqQrG4OpCQaPKoDQvunjgycbGMc1rlMLts1R3+MiM6wr6x8XLYIL7y5FwVuou2n7l0pxKH+M1WxNgYWtRfFHM9VofAngK36vLAgHlPXI3WsYPs9SwfIzQMYQDzR6tCXyotNKjy3y7Fw6mwF+v1tTtvTAeQVojHJaZrWwd4EVRQ7m8y23aphsC5jxG0fxQT++nVFEG+YQnoYcB0uj0jrKYd5IIO0uQ5iYSIcM2USC95miFjXp6WOlPkndnE0II+Di8xI2N3j46786sBj9RZSPLK8jIcOiTEvWTPs6ICErMd7oGir+CWERyCorXtQ7Q+c8deXKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ieOwOs1MVYPG5vyTknV3gYoPAS3jtZdyf34ZvNaQ0wY=;
 b=Po/Jb8hHAFm40qTsJpnsBicPo4TYifa0WxC3oT1QAaPcObCvt9YDB1wutBBuFmUGe1yZDFdAwrRGCTKKg5Dv/q+U9fvkMe5f0lgBFG8m+C7nYMaaTXAkrrzuvNWRFyf2rjogSVW4gjmhCQU1yKd63mO8o8b8iA593FyVgUjyf9+NINpGfGWrMzhdHuLC5VDiDsSpSAvx6yF9y9mRTkmOVxa7lYAoxVo1nRnid9Wv+PGirR0Mu4wIqx5G0RtlAJOTJ2bG6wXhi7CpzoDzsY5MspBT79Zo4YzExxPRY7KNYqTnpcVN3U57LGfVH6lVZiTVkTjYQZR4eyFZm0iKpEG1sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ieOwOs1MVYPG5vyTknV3gYoPAS3jtZdyf34ZvNaQ0wY=;
 b=PHJYb6P7JMdfS16yAADrwqHahBs3OiWqMfK1nlkM2Fn7gckscHuz8nHlwuchN7Je4xjVOedwpc3wY3MPODolsJfd77F/G5rPE8h0GBGGpIglFWkTlSPu4mQ4K/H/Yhf1KEzqSgJaMRjVT6eu1oOcgdtITICcTml8uTR42wRTDNo=
Received: from SJ0P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::25)
 by DS7PR12MB6143.namprd12.prod.outlook.com (2603:10b6:8:99::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 14:27:13 +0000
Received: from CY4PEPF0000FCC1.namprd03.prod.outlook.com
 (2603:10b6:a03:41b:cafe::1) by SJ0P220CA0009.outlook.office365.com
 (2603:10b6:a03:41b::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.22 via Frontend Transport; Mon,
 11 Aug 2025 14:27:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC1.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Mon, 11 Aug 2025 14:27:12 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Aug
 2025 09:27:11 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] x86/bugs: Simplify SSB cmdline parsing
Date: Mon, 11 Aug 2025 09:26:59 -0500
Message-ID: <20250811142659.152248-4-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC1:EE_|DS7PR12MB6143:EE_
X-MS-Office365-Filtering-Correlation-Id: c9d5c3f7-59b5-417a-1e31-08ddd8e329eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qKbmJtZ8ev93gpZqg+0KhkyeQh7H6W+/8pAyFwIjn9nhrWiewxXkaUXw3Rqb?=
 =?us-ascii?Q?baFdtWyTdY1wk17+w+1kcLqCzCWE/C8ESA8hEFvrb4FL8lDnU5jXQSg30DYm?=
 =?us-ascii?Q?pIdOQe8VfXkUAXjAbtCDXU2oQkO0tJJRLD+hKHvFnGJi9QlCbgg1TbG9SBjs?=
 =?us-ascii?Q?imoP+a7mC4D8y1Ffb4DHVV6E/bWiz0FaiULpFswXEYFrTo8aZu1OMCt4NJUg?=
 =?us-ascii?Q?uv1+KUjebpZ0iqyn0rQ6bOF/A0KZ/QP4NoHMG0wM+01Aru8LLp4Jq3sa2Uq+?=
 =?us-ascii?Q?5Yi5/mQ7KDw8nNDDUVuEodnU57dpLGH80eomP4nJBEIsxArOEel1ptFyO/a+?=
 =?us-ascii?Q?N4lBglaUHywH13eq84n1FkaETy8qYARwqRtPWiMZ5wDkcoLk4obEGHoFtTw8?=
 =?us-ascii?Q?/i5y/dUoWwPWKPoZqQrxbHqJsdA9Vw0v8NqWNMdPmPg3FVg9+Jh3ku6P6c7/?=
 =?us-ascii?Q?IVYDa+phJHBIFoRBWAVXg+EFIhh6Fcs59DVr+0f+oKWm5vkg9FJ1y7X5FSPU?=
 =?us-ascii?Q?Hi//qGgvX7uIQvXpUKNHedIIqrsfLC7+bbEEFqxgQgDHdJM2rJ1hGvBulubG?=
 =?us-ascii?Q?KjEt6WcxUZf8vif0b/zoH30TU2dYS5TxBkmUKGLT2HUFOkNEQNrphzjwGyEK?=
 =?us-ascii?Q?kf9vK+oMQ8S0O1ndVORzqp62w1QmsbXUJDlQNT4iadxzwNIoJWeDqaDcBQA7?=
 =?us-ascii?Q?GjkCsfgX2OL6qHlm0R21Ygc23iDTR0I5olso5/e9rLeg3mWkTazqP/Wl3+Lp?=
 =?us-ascii?Q?S42BlEBNjcPdhIJy43vuYVqK+nkiyYhr7sOxekFW3IxiySAwYpQR0VgfTZia?=
 =?us-ascii?Q?eMmgFnxkgg1zr1tj7qM/TatORa0AuWygWNqnlM9MHVHsw/mpgcPdWSAwYKsq?=
 =?us-ascii?Q?x3Fk/bejwe/LhO6C35PyskctEasmrWfnkfonKxuEpTVgnExl/jW2kTnUWsar?=
 =?us-ascii?Q?1KbVxegrnozgb4AjBo/bbb35bDrlDWRNijVZli5ijlxkwGZzF8KKEN9ZGWJA?=
 =?us-ascii?Q?kPXh2PylzSr6gxp3AnD2o/zoIrac78J3RGLsRNtxw71sR1o0ACbbOcLEJzHD?=
 =?us-ascii?Q?1bf4GZGvHxWpn+IdCHlxDtGRMHOFpFuIGKOTMN6gNeiCs4oGYcaE+hBzx0ZJ?=
 =?us-ascii?Q?FZ0+FWSOjZV249KZPR9XUICOudFpYQmM1CoVwG0jFeiaO1bnmBWUxFh8dAr4?=
 =?us-ascii?Q?oXwvXl8TDnbrPeog+9cS+gkhy/mJgKj2JTBIlgUZhCW9G9NBggzQTpNsflrr?=
 =?us-ascii?Q?EtDStX3Gjw2aHtwk+hJS78WN5ZgDR37/Myq1liBA1cUjcvIMchuIKw8eOiGw?=
 =?us-ascii?Q?IhhI+r+dW9vj3wB+9Oo4zYIwyfrwxsAc/QxIDNOE4r70Ze0/AaTaEWJ3SFLA?=
 =?us-ascii?Q?rmajuTTHoaUR0fKKaOdP1hYZzNdTKJcDfBMMU79XaU6Vzzeq019SOqyp6DKC?=
 =?us-ascii?Q?sHWr7Dxx0PY1Uo25vlEnSFwDardjQug79pflwhZJ7C9mQfmb9gu3M0mN+/8l?=
 =?us-ascii?Q?WgpSgfzqNSvEV9o25ubSvjV813gbu2kfexSH?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 14:27:12.8005
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9d5c3f7-59b5-417a-1e31-08ddd8e329eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6143

Simplify the SSB command line parsing by selecting a mitigation directly,
as is done in most of the simpler vulnerabilities.  Use early_param instead
of cmdline_find_option for consistency with the other mitigation
selections.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 118 ++++++++++++-------------------------
 1 file changed, 39 insertions(+), 79 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 19a3891953c3..3766dff9a699 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2625,16 +2625,8 @@ void cpu_bugs_smt_update(void)
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
@@ -2643,89 +2635,57 @@ static const char * const ssb_strings[] = {
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


