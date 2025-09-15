Return-Path: <linux-kernel+bounces-817088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2CEB57DCC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B84257A2EB2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A1E1F4C98;
	Mon, 15 Sep 2025 13:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mG4BKj2L"
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012056.outbound.protection.outlook.com [40.93.195.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FAC1F17E8
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 13:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757944048; cv=fail; b=Zebo08i9Z6rlL4QYsm+H0JbqPmtJNAFiNXEJVvtoBr/jQu9mOJL6yitdnd29NLyCzsxKPWDbxDh0alWAzzqkI2Ki4khSBWpvab+yQa0UBfgJlk1sf+Qh6CWYhAPNpKcCN7IxeT/X2HsIHLCCuaHmnsWtNfp2oZi8C2JMLi5VVI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757944048; c=relaxed/simple;
	bh=Pd6+61E5rZdyszKyISXlq3Vv4FyOVuHYlVv49riCzmg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dh8ZdpvwOp9k5aPJK3JDyOIUN2RaK8t6RaMsBCw82k0tMNLsxL3ruLwj1bON71BzPRo4MAMy6Nmidm/HgERfAf0LyiJKwIqtPbqglarGI1jrgDWAeYJCH3lrmsawOEF+SeXsWt0FEgOoFyuN8w+kCNZdsBRH9A1qYS8+rHB2pbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mG4BKj2L; arc=fail smtp.client-ip=40.93.195.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MKmB2XE4uyAUDM7zarJ/duQz2ep8M/yxwVrQGHwuKyL4auMAE7Z3MpucMnLi9eIOfCoE3aHPANz60OVVUV9IwHjqziDcI9F1J3WEznxQFdLCoaHial+a/c0VgrVwpUMbjz9mD7m2z/kZEKQ0xrRew6/2OfhJprK4e+9QQHishMI023dxMAVjdWGoNkP0xSnAKv52OoDKr7lI+PdldWUwL0Pp8SfjzJzOI+dv6bXPwuikMdKhh4kuO3JNVperMv1440mkauW/LF+C+56BG7ZRPeI5+eP00WjYYXdv2uHPdwF0/PXSgmqVAPNVGQTu1g8d4w55x1YRjmNXxi25KDKXDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LqRBRfKLvNqicKgrOvz0tsrn52vPmIS4BuETxPYKVNw=;
 b=eSQorNDIHL+/1rMS+Q9KCb8BpVNNPYD+Lkwe1KyetwDSAbLw3qkjTKS5tbXMs3paL8eVBAzxukHtrFBbBCmkeESxR/GHujEPrjKsDEWEiblMOswYwxTyK6cv2qe3w3PhFI1QOMOG0fC0PgXGUi3IFn7ENCkg3R/NJuzQFd8hXaiIicW5Zf6+JRRmgNlUe1homhr7OZTcJNcFHY8bzJ198cmq4z8AmWGAOcqAfYu8FN9dkFixyTCWV0KGnh9QKlge0/e3sFk6ua5VDMabxgbiLLaqQFvu78teJv+YaDBcQBFO0eI7xKEru5eWTNJqVQQoYUY42NzJXOCt5zDELrN8wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LqRBRfKLvNqicKgrOvz0tsrn52vPmIS4BuETxPYKVNw=;
 b=mG4BKj2L2JKSmhWekFGiFeP96ssU7HGYieabmMhARZahQJqYPONoPOi5+6B/q2KY0AL+DYkIU+H68KUd2/lPVZ+qrEf55P3XbJR81VbR9H2FRkP5q07tZVcHgqQOoqCCEcCctgLRS0V7Rziq00Zmx1CdwMwqM2jU2BnXKYNuY6c=
Received: from SJ0PR03CA0110.namprd03.prod.outlook.com (2603:10b6:a03:333::25)
 by DM6PR12MB4371.namprd12.prod.outlook.com (2603:10b6:5:2a3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Mon, 15 Sep
 2025 13:47:23 +0000
Received: from SJ5PEPF000001D4.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::c9) by SJ0PR03CA0110.outlook.office365.com
 (2603:10b6:a03:333::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.21 via Frontend Transport; Mon,
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
 15.20.9137.12 via Frontend Transport; Mon, 15 Sep 2025 13:47:23 +0000
Received: from tiny.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Sep
 2025 06:47:21 -0700
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/7] x86/bugs: Use early_param for spectre_v2_user
Date: Mon, 15 Sep 2025 08:47:00 -0500
Message-ID: <20250915134706.3201818-2-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D4:EE_|DM6PR12MB4371:EE_
X-MS-Office365-Filtering-Correlation-Id: 26c7723c-0f50-45dd-3056-08ddf45e661d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NHT+JLsTQB3+a08/58m/MHc7I+qZ/z4aL7kM/6iIcnFyic+YPxZbXTQc1+Sc?=
 =?us-ascii?Q?gJKUTFnIIxO3k8KZmBOyHtvCpBsAs5isje2EUNE1prlUHGGZwH2/7dtFGKV3?=
 =?us-ascii?Q?ZSWtG3yr5gnVrEkpKOBKR/SiCBP6zhXJmiftvcHO4wdJLvxJr20UMJudFEYw?=
 =?us-ascii?Q?sZNUaqOHkzai38Fin8zvjXtIbc1gfGU0Rx2hMhNNcHJwqoRsq27it3AoYIRF?=
 =?us-ascii?Q?9KMeSjh/5R26M561GDMPfW8vWWIOAf4efk7foLH0CSgUTtjsCwGPUAHPv6BD?=
 =?us-ascii?Q?HDqAvaX4wMDYUUEu9SDkSIvu2+zuCjngUootkr5WuI07S4EneNs0cgnT/8Tx?=
 =?us-ascii?Q?8jzssZ6363hejzkNn+fXfV5VA0vhwzHxe3azjbBPw+dg1SMHexgik9oYFOkz?=
 =?us-ascii?Q?javGAsOlnGz5CKTabGOsnMb7iZ73du7b4TEzmvHxfyaHRgUXv/dYZThY9i3c?=
 =?us-ascii?Q?SnVar8IhHQcHNj7M8sgCVl2L5JHmbTAK8iP5HqJs+fspm6sTXGXR+xR42ctP?=
 =?us-ascii?Q?T472+WYFzJiJA4cokHIlX8Yd6uG/etnea3PmCN+VGDZ4ezeWy4TIUxl7FZGq?=
 =?us-ascii?Q?Qdv0T2gwdyOIlAAbt583qzpfTETmdZgdB5bnHEnzYpRYY7dh2ijHurd0rCV9?=
 =?us-ascii?Q?7hoOa/cVS6T9mYNl3O9REZh8KO/GDbZgDUVD1+mwH2XL5jTSQdj5HiyhSrrS?=
 =?us-ascii?Q?Mr0Gdo5ys4OyB1DBZ9vc8/N7RFjsHQWczCLGoXWqyPd4MagvM/2YPlXu9ffk?=
 =?us-ascii?Q?JCOALTk4r3zLGPDtzFd/iUsc3VpMhX+4xueyL0wMsOzbOel7DWspf62p5oCA?=
 =?us-ascii?Q?ikkv16BKTT4IgpSjGwiY+BE/OxL/pK7fLejAZY+nJNe6J6vtPlKiUNsd1E2r?=
 =?us-ascii?Q?PhHfNz5Df+CJFWVtBvqUvh6KKdEG9+HXpFhCX8M6+lGDqRCt2sUKr8IfXPIO?=
 =?us-ascii?Q?nXsvIs4H4g9gQvffQZSQVEQu0texV2AXdu5dotmhXxOOODbaCHZub3RrC18R?=
 =?us-ascii?Q?TymH5UaBwkEycI8Z74s3MGSwsRz6eC4mNYqEC5pMTpi6BsGZdwVZEieJpOND?=
 =?us-ascii?Q?8MOUP3OcTdn/n6A7hav85cdfSwa6HtT/IBnNhpO/n4OxW5KiUKUE0wKnQ7uE?=
 =?us-ascii?Q?2D3kZtxqD8X51z3SMaaxblbgD93hLpUq473dV5YzkKKyBBAjuwkuhJrA+U05?=
 =?us-ascii?Q?icTAKSEyRlpuxUsDF2Hvc3i2eVAkFKXYUAOeCqWKmBv9dBW2/YEpTk3ItXuw?=
 =?us-ascii?Q?lYgx0pdbI/PPaudfjpTs+ljuigx0ba5cKY8iZAmOdbka/LOhTuAWBX17zEzo?=
 =?us-ascii?Q?OAFlNvJwljBKo6cxn/Ngeph7pEzqQinvWw6jUEjjaX7ZkB/n9pbWBj2RcmmX?=
 =?us-ascii?Q?OwJ7XWG121gnIlVQkfmkB0mFuLJMlgIKBgEj1I6TYPW+h0HAlecHk7pcFxJa?=
 =?us-ascii?Q?Yj693p3ELezJ1arWH/DEywHK3Me7hhcPZNriyOf2MB3aMSTAYAbTycED9mtB?=
 =?us-ascii?Q?qm2Dw6McMRmGeNCCQgdLLL4av7efK4xw4A4Q?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 13:47:23.2433
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26c7723c-0f50-45dd-3056-08ddf45e661d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4371

Most of the mitigations in bugs.c use early_param to parse their command
line options.  Modify spectre_v2_user to use early_param for consistency.

Remove spec_v2_user_print_cond() because informing a user about their
cmdline choice isn't very interesting and the chosen mitigation is already
printed in spectre_v2_user_update_mitigation().

Signed-off-by: David Kaplan <david.kaplan@amd.com>
Reviewed-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/kernel/cpu/bugs.c | 68 +++++++++++++++-----------------------
 1 file changed, 26 insertions(+), 42 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index e817bbae0159..a5072ec6e5c5 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1847,7 +1847,7 @@ enum spectre_v2_mitigation_cmd {
 
 static enum spectre_v2_mitigation_cmd spectre_v2_cmd __ro_after_init = SPECTRE_V2_CMD_AUTO;
 
-enum spectre_v2_user_cmd {
+enum spectre_v2_user_mitigation_cmd {
 	SPECTRE_V2_USER_CMD_NONE,
 	SPECTRE_V2_USER_CMD_AUTO,
 	SPECTRE_V2_USER_CMD_FORCE,
@@ -1857,6 +1857,9 @@ enum spectre_v2_user_cmd {
 	SPECTRE_V2_USER_CMD_SECCOMP_IBPB,
 };
 
+static enum spectre_v2_user_mitigation_cmd spectre_v2_user_cmd __ro_after_init =
+	IS_ENABLED(CONFIG_MITIGATION_SPECTRE_V2) ? SPECTRE_V2_USER_CMD_AUTO : SPECTRE_V2_USER_CMD_NONE;
+
 static const char * const spectre_v2_user_strings[] = {
 	[SPECTRE_V2_USER_NONE]			= "User space: Vulnerable",
 	[SPECTRE_V2_USER_STRICT]		= "User space: Mitigation: STIBP protection",
@@ -1865,50 +1868,31 @@ static const char * const spectre_v2_user_strings[] = {
 	[SPECTRE_V2_USER_SECCOMP]		= "User space: Mitigation: STIBP via seccomp and prctl",
 };
 
-static const struct {
-	const char			*option;
-	enum spectre_v2_user_cmd	cmd;
-	bool				secure;
-} v2_user_options[] __initconst = {
-	{ "auto",		SPECTRE_V2_USER_CMD_AUTO,		false },
-	{ "off",		SPECTRE_V2_USER_CMD_NONE,		false },
-	{ "on",			SPECTRE_V2_USER_CMD_FORCE,		true  },
-	{ "prctl",		SPECTRE_V2_USER_CMD_PRCTL,		false },
-	{ "prctl,ibpb",		SPECTRE_V2_USER_CMD_PRCTL_IBPB,		false },
-	{ "seccomp",		SPECTRE_V2_USER_CMD_SECCOMP,		false },
-	{ "seccomp,ibpb",	SPECTRE_V2_USER_CMD_SECCOMP_IBPB,	false },
-};
-
-static void __init spec_v2_user_print_cond(const char *reason, bool secure)
-{
-	if (boot_cpu_has_bug(X86_BUG_SPECTRE_V2) != secure)
-		pr_info("spectre_v2_user=%s forced on command line.\n", reason);
-}
-
-static enum spectre_v2_user_cmd __init spectre_v2_parse_user_cmdline(void)
+static int __init spectre_v2_user_parse_cmdline(char *str)
 {
-	char arg[20];
-	int ret, i;
-
-	if (!IS_ENABLED(CONFIG_MITIGATION_SPECTRE_V2))
-		return SPECTRE_V2_USER_CMD_NONE;
-
-	ret = cmdline_find_option(boot_command_line, "spectre_v2_user",
-				  arg, sizeof(arg));
-	if (ret < 0)
-		return SPECTRE_V2_USER_CMD_AUTO;
+	if (!str)
+		return -EINVAL;
 
-	for (i = 0; i < ARRAY_SIZE(v2_user_options); i++) {
-		if (match_option(arg, ret, v2_user_options[i].option)) {
-			spec_v2_user_print_cond(v2_user_options[i].option,
-						v2_user_options[i].secure);
-			return v2_user_options[i].cmd;
-		}
-	}
+	if (!strcmp(str, "auto"))
+		spectre_v2_user_cmd = SPECTRE_V2_USER_CMD_AUTO;
+	else if (!strcmp(str, "off"))
+		spectre_v2_user_cmd = SPECTRE_V2_USER_CMD_NONE;
+	else if (!strcmp(str, "on"))
+		spectre_v2_user_cmd = SPECTRE_V2_USER_CMD_FORCE;
+	else if (!strcmp(str, "prctl"))
+		spectre_v2_user_cmd = SPECTRE_V2_USER_CMD_PRCTL;
+	else if (!strcmp(str, "prctl,ibpb"))
+		spectre_v2_user_cmd = SPECTRE_V2_USER_CMD_PRCTL_IBPB;
+	else if (!strcmp(str, "seccomp"))
+		spectre_v2_user_cmd = SPECTRE_V2_USER_CMD_SECCOMP;
+	else if (!strcmp(str, "seccomp,ibpb"))
+		spectre_v2_user_cmd = SPECTRE_V2_USER_CMD_SECCOMP_IBPB;
+	else
+		pr_err("Ignoring unknown spectre_v2_user option (%s).", str);
 
-	pr_err("Unknown user space protection option (%s). Switching to default\n", arg);
-	return SPECTRE_V2_USER_CMD_AUTO;
+	return 0;
 }
+early_param("spectre_v2_user", spectre_v2_user_parse_cmdline);
 
 static inline bool spectre_v2_in_ibrs_mode(enum spectre_v2_mitigation mode)
 {
@@ -1920,7 +1904,7 @@ static void __init spectre_v2_user_select_mitigation(void)
 	if (!boot_cpu_has(X86_FEATURE_IBPB) && !boot_cpu_has(X86_FEATURE_STIBP))
 		return;
 
-	switch (spectre_v2_parse_user_cmdline()) {
+	switch (spectre_v2_user_cmd) {
 	case SPECTRE_V2_USER_CMD_NONE:
 		return;
 	case SPECTRE_V2_USER_CMD_FORCE:
-- 
2.34.1


