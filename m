Return-Path: <linux-kernel+bounces-776403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 975C5B2CCEB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 21:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 79B224E2D4F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 19:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B8632C300;
	Tue, 19 Aug 2025 19:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="b8JPz8uS"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E926326D5E
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 19:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755631343; cv=fail; b=BwnA2oeoSaTZd4q7de3bZ9sKafRl/EA044Q4XyfNAFU2I1+cv1wX2SMoXkdQ0bb62tPQNKmlmRs8kqhKIvlqFqfaHhR3+d6VmAbHdBaB30cKvWUG6pXEfaLCHCzGf5+RsN6OQ9WSL+mxVOno3QJqazzL46mGz3dcYBbYRgWxcPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755631343; c=relaxed/simple;
	bh=nNEzNgX88p6/MaVISM3+4s4fB6qVdzVP9GWauEGT5JY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cXj2CwFugIJbJrXqYYCFrDABbp5nTPhpYwJl89WYQaijemgTxF8kTGA4AcZDR0zhgcIPikvKo6WNniOpnSBdesDkcHo7jCdMkKN+dpvR96QIVPHpI7TcztOFfRIg4okp/uk7vi/sewglgA9nIHhCKN9lJIBTpf1/O8cByBc55p8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=b8JPz8uS; arc=fail smtp.client-ip=40.107.93.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yi6kxkKKWl+4EqxOFI3Hj/YZrD7MWyYcMO8QGnjVxrQsjmfBUvNVMOi/7rSI41D1T3kVbgfviz2XZoWiMgRzYrRgEdKQwLuuJ+LrxoWZCebgL3NvGP5A7zBmHFNspE5D3Q4sIRYiUV3Ht3mUkIWO080I4sp6RfGdaXHs5TfaKMCERtfOBcoSOGBD7skFTi/0WMDKGFIjJqN4P0QMg77oxPAoF+ZTwMfCEQglMdh4CgAEVuiHNWCPNh9lhAHlBhxnkZRgAwNpuvFWSZ/rq7/R/OaWE6W5OI/iDSnHpby6jf3nyk9GZ/sGVMRRTxBkjr/zUW8PT/7S9fWjxIaj1biRWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BgLtTOw6hfabSZrjSJ0dpOoM80bj7DbqYwLaabnR4jM=;
 b=baPeGR1CU6wyCs/qikoWws0TUnNo14GOMVW4FMp6fukeFMM6rJFw2TPMuG50R2Vf3YDO0xXPTi/8qRm0vaEL+rR4oE3UnSICYnPa5HpSyNX54g8qI/KkYvh1RKQMnnZoIRA1GSC8YyJ88SUIKEMcrv3H2gbZhY55ANyu/1XOGvggM/nJ6KZZ/aWI3bArTrGjHUnkGBNrh0HxnfstyhKc4p+bdq3UdTdmBg46T9gF+dj7HBqxl342fUl1c16qof+3D43sTqllnevKwZR54qW/D10KdVfvUEbYIsrHYqWV0otxhfq2JiorNEcGXc578WMXHn+MTPeM7Zop0s0n7NlNDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BgLtTOw6hfabSZrjSJ0dpOoM80bj7DbqYwLaabnR4jM=;
 b=b8JPz8uSXGx5wymD85yki5t1qAj3YrUDN7NkBglzvsAfGmvoEFfgFy8NAXavcjO6rp/Iz81r5LGW0NrHmvNh/egtiTYD6vNXDvguVZ5jELTsRg789ltbjeOd1eosl2TjUs4vX0XIZzg4DzZkrRr5XXU0LOCxS1HqwFvyP2dXVSU=
Received: from BYAPR07CA0099.namprd07.prod.outlook.com (2603:10b6:a03:12b::40)
 by MN2PR12MB4205.namprd12.prod.outlook.com (2603:10b6:208:198::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 19:22:18 +0000
Received: from MWH0EPF000A6731.namprd04.prod.outlook.com
 (2603:10b6:a03:12b:cafe::ac) by BYAPR07CA0099.outlook.office365.com
 (2603:10b6:a03:12b::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.24 via Frontend Transport; Tue,
 19 Aug 2025 19:22:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6731.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Tue, 19 Aug 2025 19:22:17 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Aug
 2025 14:22:15 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/5] x86/bugs: Use early_param for spectre_v2_user
Date: Tue, 19 Aug 2025 14:21:56 -0500
Message-ID: <20250819192200.2003074-2-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6731:EE_|MN2PR12MB4205:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b5cfff8-48e1-4bf7-c73f-08dddf55b658
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PPK8Od4Atnyw5T5OzTHAoFBtE46nDeCANASX6FG2GytQKuu72/XbaDKfCwoe?=
 =?us-ascii?Q?DBGkeGPNjGHx573lvELV+hhMEeRgIio5VHbFH7lZMvqeNlIWeOl5HFV5iK7O?=
 =?us-ascii?Q?WsF/VpoXmUj5pkmSY1yfTC/Kba5DCnp0ZD5VmHumBzFuDhieEBGwSzWmY06w?=
 =?us-ascii?Q?vELNO9tzMu2WtwkqipAAj9lOceD03buLWhv+UnFTyQP3B31GuTyNlbXI8+80?=
 =?us-ascii?Q?VTvsgkDMvTkKOyXa8FlaFHM/jXYkZCXRPVPPb0P8EUhThLSwGSaxgYyGf3X8?=
 =?us-ascii?Q?UabbT+IjwcKWpy9vFCgYHsufSjwgJZwQQLvSpfktJQaDJKvrSjg5UVvwWfhT?=
 =?us-ascii?Q?XKsbSx6bKFKONGMbZjWbZ70bgbL3txrsE7lSCASlcoH+g1TEL5ICvxj+iMcb?=
 =?us-ascii?Q?6ZcEAnve1cT7hv7CMaRY/ydPVv9pZ7Zc+q4XoVmVNwclHTx8Nir2MRWVFcvA?=
 =?us-ascii?Q?mDdnqkcpFVBLUwu0dbQygJFVP/JZMYbAiD1Kq2BZw4nkalj8A7xz5PCeU5NP?=
 =?us-ascii?Q?fbjcNydKqVdkpLHO1GrXacybRuKwzEu7mJ99rKYkYQyTDwA6YYCKQatxOmqA?=
 =?us-ascii?Q?BBVbCN5QId4urE0WvxtYn428WEkKl220FuFD+w+0ngtRrfPGMNfKcLHRIADA?=
 =?us-ascii?Q?5oA1a2fB7KiWEJpiGoKkkqntM5GlE78e7T8v+k7/SiO480guGI1O/vOzDEQW?=
 =?us-ascii?Q?j1ozKlkuGTlPWy7/mFjZBEQPCv+ArJ8QxPXEYpcCtvLey5yEEiHNvB8K1+m/?=
 =?us-ascii?Q?K6mYs7Nbb5ybarQna2+/XxmOVne//VolLi0C8Ylll6MCtrKxU9Fl8wFXMgTo?=
 =?us-ascii?Q?XZymEA8nP/lvQTMMMUSe4uiHq4LrOVYODzTQvP6egrqvcHsA1iHl6GcEqQfy?=
 =?us-ascii?Q?rxwlcigcdUfXEG8EfjK1wChA/WyAyB5CjI1qCuZ/w3Yvwko8wJLzr41gJpUb?=
 =?us-ascii?Q?o7qgDLgOKXoJcSOdlV8Vao77ndLyF7JOeuQykNITlBgHoEl15upIN5XOVQxN?=
 =?us-ascii?Q?QgK3drHc8BIMSWKawnsesy7QYgRyB6v3EQ4MVMIz1iYwgWIHSHFSelNueLcm?=
 =?us-ascii?Q?cmvLEg1uWy1HY4T2RFPLl7734srWsr3gTHy0fhBgD+atUSmapnrNYToDiluO?=
 =?us-ascii?Q?WW0ULSJk+15QTbYsqakfZLhvAV7N1L3e5z9V9jjwZDuyVbMaG8cNOyWtpstF?=
 =?us-ascii?Q?CiiL6PwBCNY412JLov4mW6W7e4DgxxZtDRZYzCNJIwNBvP4Ln7e394dPEjax?=
 =?us-ascii?Q?A1L+b1J+JYe4FAwJLv6cEGQT0mKxtGJ/XckJNShOzK/RHUcXSfXOpxnZzGFR?=
 =?us-ascii?Q?YwKMjMdujjyi0xVgCN26lRYhzSvN6eHoe/Skx8UYlreffttdW1WdYlTTbFld?=
 =?us-ascii?Q?scnHfA+klM094chPF2k0YT4rEd4Qw7F1TEHpPys3rzBE6bvPhlA22/3xkKFs?=
 =?us-ascii?Q?BXU5y7VrcXCH7lPYFFDVuMa3giGBVLec2hQJVzNtP8BoQbw4xGyLu6ozAqrd?=
 =?us-ascii?Q?FzGdpplF6RFj7TNHNEnMF9L6qIgY8y9Yy/K/?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 19:22:17.9612
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b5cfff8-48e1-4bf7-c73f-08dddf55b658
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6731.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4205

Most of the mitigations in bugs.c use early_param to parse their command
line options.  Modify spectre_v2_user to use early_param for consistency.

Remove spec_v2_user_print_cond() because informing a user about their
cmdline choice isn't very interesting and the chosen mitigation is already
printed in spectre_v2_user_update_mitigation().

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 65 +++++++++++++++-----------------------
 1 file changed, 26 insertions(+), 39 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 49ef1b832c1a..de78b76ae851 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1826,7 +1826,7 @@ enum spectre_v2_mitigation_cmd {
 
 static enum spectre_v2_mitigation_cmd spectre_v2_cmd __ro_after_init = SPECTRE_V2_CMD_AUTO;
 
-enum spectre_v2_user_cmd {
+enum spectre_v2_user_mitigation_cmd {
 	SPECTRE_V2_USER_CMD_NONE,
 	SPECTRE_V2_USER_CMD_AUTO,
 	SPECTRE_V2_USER_CMD_FORCE,
@@ -1836,6 +1836,9 @@ enum spectre_v2_user_cmd {
 	SPECTRE_V2_USER_CMD_SECCOMP_IBPB,
 };
 
+static enum spectre_v2_user_mitigation_cmd spectre_v2_user_cmd __ro_after_init =
+	SPECTRE_V2_USER_CMD_AUTO;
+
 static const char * const spectre_v2_user_strings[] = {
 	[SPECTRE_V2_USER_NONE]			= "User space: Vulnerable",
 	[SPECTRE_V2_USER_STRICT]		= "User space: Mitigation: STIBP protection",
@@ -1844,50 +1847,34 @@ static const char * const spectre_v2_user_strings[] = {
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
-
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
+early_param("spectre_v2_user", spectre_v2_parse_user_cmdline);
 
 static inline bool spectre_v2_in_ibrs_mode(enum spectre_v2_mitigation mode)
 {
@@ -1899,7 +1886,7 @@ static void __init spectre_v2_user_select_mitigation(void)
 	if (!boot_cpu_has(X86_FEATURE_IBPB) && !boot_cpu_has(X86_FEATURE_STIBP))
 		return;
 
-	switch (spectre_v2_parse_user_cmdline()) {
+	switch (spectre_v2_user_cmd) {
 	case SPECTRE_V2_USER_CMD_NONE:
 		return;
 	case SPECTRE_V2_USER_CMD_FORCE:
-- 
2.34.1


