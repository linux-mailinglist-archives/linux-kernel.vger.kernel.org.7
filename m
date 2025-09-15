Return-Path: <linux-kernel+bounces-817092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 542D4B57DD6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8262171DC9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1512045B7;
	Mon, 15 Sep 2025 13:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Q3QhaDlW"
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013018.outbound.protection.outlook.com [40.93.196.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DA93191D0
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 13:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757944052; cv=fail; b=nLPUzemz9t5gf2Bgxa1+1kk4sQ6PAY21plOnIFzAWDyDqlCFRLCDjGMUtmceGJJ34J/cYDUpFkpl00r7r9TEBzNBcqluFRgDpQfYkwGmAgIiZiLXHWJKryctbPg+QXA814Le/Dd5usFAyi0lapxyTvqqC5cF2I3/uQYDoU/pqBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757944052; c=relaxed/simple;
	bh=AtGw9s6rfZrovj3Y64tN7QL11z/f3M9R+mWqdEZFdxM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b+YV+egJ/tyhCbLM7ySgiU+QM0zVbIhw2tTDrcASv/EqElmFMJx5OgHlAGBkrMe+HmZEeBKI/2SUHYeNVoEz1CPTWRnCRU/trD541N/HcIg2+yj+wkPfwPMLpfv4z/In09dhyOQnlAzW/jdtx2Cl3ms9KmSRtQPedGWDAcXItuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Q3QhaDlW; arc=fail smtp.client-ip=40.93.196.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fP5IHkVXICr7SllxqXEuG43YYgbo3wboOoPEN/GRRcnU2R/qbr6NkWhRAqLKhRRWoDuZVIR6ATHtwhnLaca1aeWNxLUkgf83w4TNrIZtPQthdiHtqMbmP7i6pjN89mr9P1OBb7GMJivazybJhiwvC436ZrpxqsmdNTnWvafwYoKpcFPOPU7Va7mioDMM7We0qQvB6BEpZKDrQ3oJ3/tQpdP3rXs5McwmlMBqT8L6xIQqUVoXJmpOHmGG4wdlsDgP7CAf146wfkIPd5gkOpA4VAEk2zozNZK9HMiz4ZTbeGF3vQNj6CQEqVqDkP3NGoktqLKLm+/mBhn/Mth8JtmdFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RXbYvvyEb4qjFyv3M6LQxTSj+13XoB2ld3iGGuDEjFc=;
 b=hDtd2J1g3nP93aaDe71/EQltxceP/dqYXJctVDDTrWjXXBhs6j0ychORsoK/SeWvvtWNafW0kB3sWSarpM4LaiNCrrmpht8/GUupv2asn1M/KfhZjzkPAFI+cQlk225wObJkicaVh7jLpxQUD9nZ01vEaNdHZ7rXyWMLtK2aiOd7f2CHAm4FVFD+4BJtROFOX0X0qaea9w+WNBrvEOP0cCiz+FKGn87my8xIJkqlJXMX1mvhljkdxl9tuAEydk/xwlZAco4eQVXQwV9KQWsRp9bxXyrMQQvIHQdJECgneO0abcIAvAlPzEZSt/7nE2bceHVTuGZFBd04bft7QGSTaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXbYvvyEb4qjFyv3M6LQxTSj+13XoB2ld3iGGuDEjFc=;
 b=Q3QhaDlW6lrCXRsSP4ACsBXzoFOD4uGaH5EK+Hm0OvGjpDr+BfzfVgVPWjuIsUThrUN63kqBbyqIta/9o8fuvisHsJ2wr9xEb1J9F4/8jMAGofwtJFkUbfg8A5J0bWOjtyN9K+LUv7CEfcmfawouLUP9+NRvUIQu9Q8I8vM4HR4=
Received: from SJ0PR03CA0107.namprd03.prod.outlook.com (2603:10b6:a03:333::22)
 by SN7PR12MB7276.namprd12.prod.outlook.com (2603:10b6:806:2af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 15 Sep
 2025 13:47:26 +0000
Received: from SJ5PEPF000001D4.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::4) by SJ0PR03CA0107.outlook.office365.com
 (2603:10b6:a03:333::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.19 via Frontend Transport; Mon,
 15 Sep 2025 13:47:23 +0000
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
Subject: [PATCH v3 3/7] x86/bugs: Simplify SSB cmdline parsing
Date: Mon, 15 Sep 2025 08:47:02 -0500
Message-ID: <20250915134706.3201818-4-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D4:EE_|SN7PR12MB7276:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cbc9321-fb3a-4e06-6f82-08ddf45e679c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hUrxlHTQz3W7p7ovls/jgIYmXupQc6sCwXIl7sacZZfLZdJDWOI1vNwK1HhV?=
 =?us-ascii?Q?ylXFNxVcnIBjwS2vdqyY1eIhoJFo46OpGcdZyc1AT3aK7B8/BdUqvrPznXLm?=
 =?us-ascii?Q?V+g4ywDlzlqs0yYmgoIZtrDtCgFcfOzg9miHlm+8HFdhLaBNBCwMDMsDuy+e?=
 =?us-ascii?Q?oi55GIt6rnFhRgwnA/wfdpllhUa1f7nGRcrn6cIwv9SrSZZjEwxlTPm1jzpy?=
 =?us-ascii?Q?ccL5qKmj7zDEC/4FzzD7+xZrsglvSZ9lj24T+j/ZGyCK/voD67cc8mUiUqFf?=
 =?us-ascii?Q?7j/FSdXgQBZW3sqpkI4DagvIj3yWWhiqdzzLmyMlHZyiUSTCIrEboU1DOvyI?=
 =?us-ascii?Q?HoSyZlcoqpqlh47qQlEqRojZ5q59HamrPv18DLF+uYXHwPiWlTCjfStA347i?=
 =?us-ascii?Q?WCCf3YrLBPSDCG3mXfdlRj87SABEydTR0zFjdRKuSSO33adQ/bbW9f47fQDR?=
 =?us-ascii?Q?XJFNQRhSW0UodfzTyKdfIbbenZ/dJYqmncDm0ZNTkck3hmJy+1zYwm/pHuaJ?=
 =?us-ascii?Q?XqwY9K18m4J/LMG/beEFUmSGCabr3Q07VIfqfAxPZ0AjNgaCTeHl9hv6vSmu?=
 =?us-ascii?Q?vCLYxqFWuvP+eacm6RVyNvHI5rgQoJdYfLBaUS1vNZHu2cQjcJL/ALKk72El?=
 =?us-ascii?Q?xUqLGLBu+dHzrn3gb/3GmgGt/mFvXXMau5HlNUS0Y5agK5/+aJ+gIA9xoDeM?=
 =?us-ascii?Q?hkmtZcneH/nYZiWktSvwNfyi9pkYLqWn6wEaRXIB9X6zOV5Mx0WuD9nA6fg1?=
 =?us-ascii?Q?nFEQjK69/cF5SF6UvQ5ZHPyjpGWBD6iyArcfVPvgetMX5OMOFZrzCGKdQsCb?=
 =?us-ascii?Q?gheqJdI1PjJASnJaI9jCvqn+d04JLSToU63Puh1CUAxI0CuA/d+27GnYgVdo?=
 =?us-ascii?Q?8lyKGXXsvMEQ8auts9RUtHrcGDTPZ9zeuXlZi585Rr1f9S2vEHR0m8QQ/bdy?=
 =?us-ascii?Q?NlA5zigbEvZqCa8TaG/9Su/C6mYQRgm3RGS35HucZucf/OI+TcdcTVy+Ssqq?=
 =?us-ascii?Q?D+NTMm/XtLod4cn9LgBhGRiCGqz9emwjCDQrHhWIj0nh/So5pMp7QyGksu20?=
 =?us-ascii?Q?D7n+hwyFgcE1IuEQpGVs8yfLtZBA3QZ/PeD/S0ksySKyadTMK1IpZFwSFCpY?=
 =?us-ascii?Q?0+vkCHkGv2NgK4N3hpOA0VLew9PpnRUgHO+7dShFevkyuVP/W7YusYF3Q9sg?=
 =?us-ascii?Q?NeFpmjqT79huWc5I/NH/Pauo4Wlo5hI15sdwBsVo3PI8e87fFBQQZgNxe2eA?=
 =?us-ascii?Q?z4UZJTefsOY1jZInWUEPVwuNhD8zEwSm55YNOrvMrfatDCBupZD3+8Z94czj?=
 =?us-ascii?Q?Hvf2wkCQMp5Bomg2WBbuX99qdxOLWii/ErLySQY9/t7xQZA2CiMJlglalaVk?=
 =?us-ascii?Q?UTJ+ez0hc4C0Gk4vJo5/EiKFwtccmCq3F0uKtLWC2FUI41tiRIeuVl6X47xH?=
 =?us-ascii?Q?5Y7UR6CoG6aLGtHrFYRnmd1dx1cwL41OzcTPZOTGTYNTgI00iAbgSDLl2UeR?=
 =?us-ascii?Q?b1/qp/yRYda2hF7htWlqBHBK37bsgx4r9uDq?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 13:47:25.7542
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cbc9321-fb3a-4e06-6f82-08ddf45e679c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7276

Simplify the SSB command line parsing by selecting a mitigation directly,
as is done in most of the simpler vulnerabilities.  Use early_param instead
of cmdline_find_option for consistency with the other mitigation
selections.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
Reviewed-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/include/asm/nospec-branch.h |   1 +
 arch/x86/kernel/cpu/bugs.c           | 120 +++++++++------------------
 2 files changed, 41 insertions(+), 80 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index e29f82466f43..08ed5a2e46a5 100644
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
index aa2eb2e7878f..fe57e890d56c 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2530,16 +2530,8 @@ static void update_mds_branch_idle(void)
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
+	IS_ENABLED(CONFIG_MITIGATION_SSB) ? SPEC_STORE_BYPASS_AUTO : SPEC_STORE_BYPASS_NONE;
 
 static const char * const ssb_strings[] = {
 	[SPEC_STORE_BYPASS_NONE]	= "Vulnerable",
@@ -2548,94 +2540,61 @@ static const char * const ssb_strings[] = {
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
-
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
+	nossb = true;
+	ssb_mode = SPEC_STORE_BYPASS_NONE;
+	return 0;
+}
+early_param("nospec_store_bypass_disable", nossb_parse_cmdline);
 
-		for (i = 0; i < ARRAY_SIZE(ssb_mitigation_options); i++) {
-			if (!match_option(arg, ret, ssb_mitigation_options[i].option))
-				continue;
+static int __init ssb_parse_cmdline(char *str)
+{
+	if (!str)
+		return -EINVAL;
 
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
+		ssb_mode = SPEC_STORE_BYPASS_AUTO;
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
+	if (!boot_cpu_has_bug(X86_BUG_SPEC_STORE_BYPASS)) {
+		ssb_mode = SPEC_STORE_BYPASS_NONE;
 		return;
+	}
 
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
+	if (ssb_mode == SPEC_STORE_BYPASS_AUTO) {
 		if (should_mitigate_vuln(X86_BUG_SPEC_STORE_BYPASS))
 			ssb_mode = SPEC_STORE_BYPASS_PRCTL;
 		else
 			ssb_mode = SPEC_STORE_BYPASS_NONE;
-		break;
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
@@ -2851,6 +2810,7 @@ static int ssb_prctl_get(struct task_struct *task)
 		return PR_SPEC_DISABLE;
 	case SPEC_STORE_BYPASS_SECCOMP:
 	case SPEC_STORE_BYPASS_PRCTL:
+	case SPEC_STORE_BYPASS_AUTO:
 		if (task_spec_ssb_force_disable(task))
 			return PR_SPEC_PRCTL | PR_SPEC_FORCE_DISABLE;
 		if (task_spec_ssb_noexec(task))
-- 
2.34.1


