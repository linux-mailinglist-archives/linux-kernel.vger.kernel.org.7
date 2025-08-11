Return-Path: <linux-kernel+bounces-762888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F59B20BE6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 16:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23C033AB0EA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F65246788;
	Mon, 11 Aug 2025 14:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nvAA41Ov"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2050.outbound.protection.outlook.com [40.107.212.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317F0242913
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 14:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754922437; cv=fail; b=rIe3zWw4/h7Bl11aSCPZQXTZRxZsnXO5yP1kGGNtOH48HCZ+cfN/OIHd1R4CjIyPBNc71qovaSxYC9K6o7lCiLxHyccIyn029AlDb+kpaqqZIM5MhpIHjamqxqhqlYlLcGZ1zka2fh+WJi1OOiGb9Abq4e5Xh2Gu5qNCUthFKxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754922437; c=relaxed/simple;
	bh=Y140zJWnp/pYkAAnar2/RKwamP0sZqhbB8irYSv6OwA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AKJYTYwvtcitF8457QS+xziKz1PeyFfIGZuo3DsLAQK+p3Z8lKJvIKfnlfUq1MqZ1FL6Oa6eSB0Rr30ImGncnHoK9n1awlnxSFJr3kUzkDneatXGMlVAuOa/XYLSFEn3ipfyjvcsvnyAkzuuMZAiXs/L6Za9Ph+1GJOS3HOnuco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nvAA41Ov; arc=fail smtp.client-ip=40.107.212.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AlrUErpKVdKoEuvf3yAVUGnYPjFQslU/ot0C6+b0sfhfAD9eSl9seP42TMvqIkuIf1MyoyEg2G+Fn5Xcpc+Bq3m31n9o1aSflM8x9V0Wg+hg3DbJTOoaEJ7o4GT522rIs++Jmvm6J9/XgH/cmNdWMl4n1Vaf1aus7NW70RFL8Q+c5BTfqTpGthBywFOqY5quHvCBO0VaQCEEIIX29DOW3mQPWnWGNyREFuuzirEn7X7wrmkAkkkaYesxeZmbY0bJX5UYuESxnDdCJi+Zgs9Zp6RRLXfRQTGu/D7lDWqLJzE4MchAPxM43LCvrdXbdagvCP9oIhjgRLPBQSgO3ZntvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+ANmrmHcARMaWCJEqb0n951X2yrGC2CIL+/sTpr+8Y=;
 b=fatf53iLZIAxQkV5zrzI4Vt3V2s4+RclIdpUrhwWc/+jsFXAgpYIAuEQfeaqe5ChXEWpXv3u45McB55W4Sm1qSu+pxY6QtUrSHUSUc1QIB2HTpeGUpL1NIhadocXWtSidjKno3/79XTnKK5XPcJgOshFsYipiJSM242Hch+/XzbHJ/zw2rU0De8WuTwTnD6l+fjqMFBAvc8VfyfD4UUtMS/JZJJ3XlBqGA3RwAKD8R/fVxX8euQN9ReI9jGzeP/+7vNw+l+gRmmitfFfAInvKX97PX8Y9gg1GtLsK8nhNLlDSi6nN8oVkNxoYDnrKAnWUeJg3IlymD9tHxLw0KcjVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+ANmrmHcARMaWCJEqb0n951X2yrGC2CIL+/sTpr+8Y=;
 b=nvAA41Ov561UcVmLbg32a8UFIfMRIRPMv5XBf37HHN1yHA/nepLjatb+ghAG18aolEQxWq0JOOX3vfkobdCCUSrfwxjimhT4+nWu2jlB0KsduMPlWeAXl5BX6oIEiaklQrUvfgFw3UPwMjASdpmPEj+AiApFvQN7FzlqSGa6/fo=
Received: from SJ0P220CA0029.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::13)
 by SJ2PR12MB9237.namprd12.prod.outlook.com (2603:10b6:a03:554::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 14:27:12 +0000
Received: from CY4PEPF0000FCC1.namprd03.prod.outlook.com
 (2603:10b6:a03:41b:cafe::7) by SJ0P220CA0029.outlook.office365.com
 (2603:10b6:a03:41b::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.21 via Frontend Transport; Mon,
 11 Aug 2025 14:27:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC1.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Mon, 11 Aug 2025 14:27:11 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Aug
 2025 09:27:09 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] x86/bugs: Use early_param for spectre_v2_user
Date: Mon, 11 Aug 2025 09:26:57 -0500
Message-ID: <20250811142659.152248-2-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC1:EE_|SJ2PR12MB9237:EE_
X-MS-Office365-Filtering-Correlation-Id: ab5d4df3-3cbf-46dd-e4f6-08ddd8e328e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zU0/NfBWkzeKyJQz3frmfWI98TzwaUBUvIhr6gdUfZ6T18dWt6TN1PPQjpVw?=
 =?us-ascii?Q?xbmzTw8f1unHKM14HuvDEBNfn2RKdmnGgei9TIYIgZF8uQ/nl2wXNzUgGvUi?=
 =?us-ascii?Q?gWQpMmKPMQHATLIsoJNUhlL3895Wyn5enfq0OsVRSXpdminMiSB4+XRLNtNE?=
 =?us-ascii?Q?wx0jAYon16LFa/7GkvHEndJPPoq0DTEWJ8dj8gps3AkvRBz/r0TQ4Xj8O8su?=
 =?us-ascii?Q?v2nCMx+tR76f+BU4dZ72TGyzQT+bS6x/E3YKfBTubOqVnUwB3dsl1EIpeEgT?=
 =?us-ascii?Q?1gB5uilgasUQ3xpmTWcww9cAFJD2sfox0+03Jf0FoxHXP5xKfml70BqtTb0B?=
 =?us-ascii?Q?uGj9MB9odFv9n+0o5c1u7JOWMrPdvA3EtW/RJkJLx9vSbXMeuvR8gOKKQn/S?=
 =?us-ascii?Q?hiHm2guSgFjl46iFTBU0juynZEExAJKkNAGC2oAnL4Qj81Jj9SBXduOa1epx?=
 =?us-ascii?Q?rhh9hiuL8G36B5j5FMlJm7J8yblEznzQBDPwWmXGNA/EM8/XvULscbcJcm9f?=
 =?us-ascii?Q?d+D1vt16otA6m/o2S6VFOQe6i3UlLLFw2MyRD67/sngf9Aw7GiNcLdKBHYrW?=
 =?us-ascii?Q?EALscihx8gUslmSY8sCKFXB2BycpTmLTZDT4/3Lrgd/J+7ErRlNb2xVt7ZgV?=
 =?us-ascii?Q?9ccHDyjnpE8ZKR8v8rBiG7xXg5dWOWiXkEsUOE93EKUBH6l5qQ35SyVabvbc?=
 =?us-ascii?Q?Rcrhx0VQqYSx2f8u3kMpnVH3/5XjH0xlOqWXb3R1Z4sWRf5fDsoaLfibojjG?=
 =?us-ascii?Q?XRCnPqPKS+Gzq4tuMqCQI1+oZ1MRMjafIx2rKg8WHGtnoqXL329PAsfs0eRb?=
 =?us-ascii?Q?bfO5T3noVD+aWSILitZhRXqWk+X95Wk3b3YgeGSrPE0nJZ+ARIKeqXJPx6yU?=
 =?us-ascii?Q?nidOyEWSKRQ1MVois1CL60VD/cEe6L4AbBoJzuVYzIAEjmWc8/YrBU2MSHDI?=
 =?us-ascii?Q?lbb1/eIu/LijBZ2exCtxYYGO2xjkJ+lI4+A4zI3KcqZyMistmuw9pVMMXY29?=
 =?us-ascii?Q?/Vl87a/pkzXk9KHCbXWXKfdG5UGjiuopAwH3MjqjXutUT24cKwRreAhQLUo4?=
 =?us-ascii?Q?lVbPITJL77MMjKckxqHM4oIsAYhL4gdQaUD9QcxSeKJHbORO3B7bI8hNEYDN?=
 =?us-ascii?Q?EQDrrV4guz9dg+RoLFs1JiYCeqoH/gdB6XjCUgA2Y1Esuy4w9xitjUwaie3x?=
 =?us-ascii?Q?dc1ChUc3yEbJAKpvl4GRIF5gujPEPRTG20cF5+oO3rVs8JNepmMC7gYe6Nws?=
 =?us-ascii?Q?JiyrEwoLpIztzrBZaQVEM1pPVhblrF9Lm4NjdUFH2/Apoh6FJ/X0abYIbn5Y?=
 =?us-ascii?Q?TOZ4WAeBfYyQKINuQheiEpZVjUT8b1LtouByoOJo5LSN81NiVTYZHw0SkG4J?=
 =?us-ascii?Q?tyZ57tmHDtlzTKMJAyHwJ9jcHfqWSJ20X5LyB4aHzAkPpIarE7FC8RO4+ZWI?=
 =?us-ascii?Q?u4fp02Fw9Bp0qGVRkWBkEOknFrPfIA6144uybZcNs2WdrFkE+nuZxZZ+HHsL?=
 =?us-ascii?Q?KcWg2f/4DD+N3aQzbMwa4xHHa4OqpGJnsJ8D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 14:27:11.0870
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab5d4df3-3cbf-46dd-e4f6-08ddd8e328e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9237

Most of the mitigations in bugs.c use early_param to parse their command
line options.  Modify spectre_v2_user to use early_param for consistency.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 62 ++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 32 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index b74bf937cd9f..6bfe199b9f3e 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1829,7 +1829,7 @@ enum spectre_v2_mitigation_cmd {
 
 static enum spectre_v2_mitigation_cmd spectre_v2_cmd __ro_after_init = SPECTRE_V2_CMD_AUTO;
 
-enum spectre_v2_user_cmd {
+enum spectre_v2_user_mitigation_cmd {
 	SPECTRE_V2_USER_CMD_NONE,
 	SPECTRE_V2_USER_CMD_AUTO,
 	SPECTRE_V2_USER_CMD_FORCE,
@@ -1839,6 +1839,9 @@ enum spectre_v2_user_cmd {
 	SPECTRE_V2_USER_CMD_SECCOMP_IBPB,
 };
 
+static enum spectre_v2_user_mitigation_cmd spectre_v2_user_cmd __ro_after_init =
+	SPECTRE_V2_USER_CMD_AUTO;
+
 static const char * const spectre_v2_user_strings[] = {
 	[SPECTRE_V2_USER_NONE]			= "User space: Vulnerable",
 	[SPECTRE_V2_USER_STRICT]		= "User space: Mitigation: STIBP protection",
@@ -1847,50 +1850,45 @@ static const char * const spectre_v2_user_strings[] = {
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
 static void __init spec_v2_user_print_cond(const char *reason, bool secure)
 {
 	if (boot_cpu_has_bug(X86_BUG_SPECTRE_V2) != secure)
 		pr_info("spectre_v2_user=%s forced on command line.\n", reason);
 }
 
-static enum spectre_v2_user_cmd __init spectre_v2_parse_user_cmdline(void)
+static int __init spectre_v2_parse_user_cmdline(char *str)
 {
-	char arg[20];
-	int ret, i;
+	if (!str)
+		return -EINVAL;
 
 	if (!IS_ENABLED(CONFIG_MITIGATION_SPECTRE_V2))
 		return SPECTRE_V2_USER_CMD_NONE;
 
-	ret = cmdline_find_option(boot_command_line, "spectre_v2_user",
-				  arg, sizeof(arg));
-	if (ret < 0)
-		return SPECTRE_V2_USER_CMD_AUTO;
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
 
-	for (i = 0; i < ARRAY_SIZE(v2_user_options); i++) {
-		if (match_option(arg, ret, v2_user_options[i].option)) {
-			spec_v2_user_print_cond(v2_user_options[i].option,
-						v2_user_options[i].secure);
-			return v2_user_options[i].cmd;
-		}
-	}
+	if (spectre_v2_user_cmd == SPECTRE_V2_USER_CMD_FORCE)
+		spec_v2_user_print_cond(str, true);
+	else
+		spec_v2_user_print_cond(str, false);
 
-	pr_err("Unknown user space protection option (%s). Switching to default\n", arg);
-	return SPECTRE_V2_USER_CMD_AUTO;
+	return 0;
 }
+early_param("spectre_v2_user", spectre_v2_parse_user_cmdline);
 
 static inline bool spectre_v2_in_ibrs_mode(enum spectre_v2_mitigation mode)
 {
@@ -1902,7 +1900,7 @@ static void __init spectre_v2_user_select_mitigation(void)
 	if (!boot_cpu_has(X86_FEATURE_IBPB) && !boot_cpu_has(X86_FEATURE_STIBP))
 		return;
 
-	switch (spectre_v2_parse_user_cmdline()) {
+	switch (spectre_v2_user_cmd) {
 	case SPECTRE_V2_USER_CMD_NONE:
 		return;
 	case SPECTRE_V2_USER_CMD_FORCE:
-- 
2.34.1


