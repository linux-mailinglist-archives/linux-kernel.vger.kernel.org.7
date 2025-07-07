Return-Path: <linux-kernel+bounces-720371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB05AFBAC2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 20:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA28D3A339D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 18:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBCB26CE02;
	Mon,  7 Jul 2025 18:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PKWg9PCz"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F44526462B
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 18:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751913230; cv=fail; b=N1NcfLRRhAvD8KtFQ2fkagtY4DQdY3ZqfImEWiHLLwkMlEgm1Q0T/jJ5nuYvqrvUhYVqSHpUyh0wjRCFvb///6j05PdEjwRwEi/fmVb7rJ8abq5RqymtRsBRjvR0JoMG8QTcED3yEsEIDWft1t39+tfSHwOiKcahlnQ87IQQ2x0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751913230; c=relaxed/simple;
	bh=ZD5FODUyefxO8YfPP0MkUu2ZQWVazEXBVUfztpawULE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h0wUXG9tmeDWhrkgss5YzLab+1x6kttCRBQWvH+Yf8LRdBfFuue0HAs+n1t9dGHBlbPCLLdarwRRvvE8UPyH5NDXBtuK0R03rsXzl+zFl34UJcQ7q5Swr2CobavJm98rc16YsoZjrdyPO6R4N7om62egnWUH28CsN9vG3Itbn1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PKWg9PCz; arc=fail smtp.client-ip=40.107.94.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vsRuRsGNKRDTKKn2YON7CYyc/ureM1zDeq85tODMxXf7Ukd+vLaEx6pUIc36vhhglLvjwxMzCbK7YESz2opZO6PviL8pAS01II9amHCbfoEuH93mpNPJZpvb8fymJ2vni35KiuywPci5/bTE7fv7ju+tG3T5kFRneHfXMJ9c2k2cHhDQ3+rWlq3AlJdeK1CbaJjEs77AKvlbQ/owdMplnyB2Q4x3q7Po0dLlqPeswC9YygakzkXgalmhaLO7096u9GGBvDc80qNUqMU+mmWde2vq7QK1KO17k7jgfk05LI+s3a0UCkTRp4+yWaNbY/CETppSZdXopRkJiikgWtyS+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rqcN6HjCtJ+YQdWmucGEJg/ynTu426YpoLGLA/gkjz8=;
 b=Ty7On7+L4KBdavM9wIdDurLQjeozb4mWpClsnXSOdLukHxozj9Rjvx8vWhO1kbmGaHZnbuN8D4tcJJ1sLe09S5RP1IfJavjB/ru/tFvuUJFakKCQzgcjvAOqsDNKfmYicIIUEeC60Xlc2ggguJoYUv4r88NX+us8D0Y3rNwjz3sSS2HDrMWikLYi7+nzQBYQhEPP/BrRNIevE8iKLFAF0GyoHZAQ95ETXISgGfVg1q56+4CDuKQueCEtJbhf6HkfEGUEdIYCTbRklswaiSSRsUCWlaKiBtsrUtdQB78Aw7+4+DfSMG1hqtkMkMppDMSFZcLqdQS6xRJMh+8svUAwTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rqcN6HjCtJ+YQdWmucGEJg/ynTu426YpoLGLA/gkjz8=;
 b=PKWg9PCzZXxgMuwiTrQcn3P0uGcaVKQ0AaTVIwD6A/HEWld7x/ww+/pXESHD74DFvYoAXmvgaW/vds2xGOljnFekYHtc8X5rh7s3HHb8I8Kayf2xlum48wOsG6Bs54AEcUeOsaqRVlR7selOmt6rSAm6lkeuJrmnFn55f0Iaz1s=
Received: from BY5PR16CA0032.namprd16.prod.outlook.com (2603:10b6:a03:1a0::45)
 by LV3PR12MB9329.namprd12.prod.outlook.com (2603:10b6:408:21c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Mon, 7 Jul
 2025 18:33:43 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::16) by BY5PR16CA0032.outlook.office365.com
 (2603:10b6:a03:1a0::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Mon,
 7 Jul 2025 18:33:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.20 via Frontend Transport; Mon, 7 Jul 2025 18:33:42 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Jul
 2025 13:33:38 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 15/21] x86/bugs: Add attack vector controls for spectre_v2
Date: Mon, 7 Jul 2025 13:33:10 -0500
Message-ID: <20250707183316.1349127-16-david.kaplan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250707183316.1349127-1-david.kaplan@amd.com>
References: <20250707183316.1349127-1-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|LV3PR12MB9329:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a92b7c5-c761-449d-edf0-08ddbd84ccc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sAybhEgX6FuWNWn1/pqMuwqcyxBwtAVWPZYn/Zjo3P/IFWtraprKmrvzOFJk?=
 =?us-ascii?Q?A1ncjjBpq2DsRGkoIVjMeq38ZZ3pDjWm7sVRkYKgtxGwYBLibhZC3vF+AiKy?=
 =?us-ascii?Q?8uucWnU949V6YXzRR+m0Kg0EqswX4Ewa++g3WfT9SP7spehJB6FoYjkAxdsr?=
 =?us-ascii?Q?dsqmoMEX1AicfGrpS0eYAH/1HvkVW7FaHUMWTZRks9EeneSmulSDKDaMMPZa?=
 =?us-ascii?Q?YZJlltHy0fe8LSE9e7lRv7iu73woP12JjbeZQpOW+WVwIsnsHj8KZ4qlaZj4?=
 =?us-ascii?Q?u98tYGkZjGS6fPxcJXok+kiHPqqziRNGntYmGlpw894ThgxSLcjrKG8AWZ3u?=
 =?us-ascii?Q?YTUn9oAwE+qPuTPhOsGdeoPZ2UKMXD8UzngvVX9HA3Wp75Blmc/liNHLLZ22?=
 =?us-ascii?Q?uWhm6zQMlCwftRMdSLo3oVHh8/ib8slmq1snls4w0lfJOM+1p9Ilsp+ms/AV?=
 =?us-ascii?Q?4OMRPL/IbugU0dkP/7EqHGJnIHdMGPxTGXmFWVWqAJWukyH7y75xO6a0+5Wc?=
 =?us-ascii?Q?8+RGR6wHLa+o1lwsqJRjpqs+Bl015FoIAnp7RF/RwCu71WsBOzEwHJwVdyoe?=
 =?us-ascii?Q?IKUN/xn0uMf+7XL5ay4uk3hOBAk5szWvGNb0GXmZjnICaHUK5tAG3o5/bT3Y?=
 =?us-ascii?Q?9b3ndqaayPlKx3Ubq1n8mdIMoaFn8UR3P4M3qQypLv1a4V69VQDxvDdfLrgj?=
 =?us-ascii?Q?DC+zK0B2SPCpJ+i9OFCj02H8NsqhnftXjKQ5HbrKBDYbhfmSRMhHFxUrMale?=
 =?us-ascii?Q?Z95X5fsasdlJfyQJRP/zXU35Ljqs6P8mnj8SNlKh8UjZEUnVKPGxPuh/5TML?=
 =?us-ascii?Q?cCG2WGfhs23Y3f9IEMUSlJOn0l61gXVNkGltjEY3W8Z7OEGbU7IK1E+2ekRs?=
 =?us-ascii?Q?FJ8dKPe7gbEKwDYsOuHwbGWzyAw46IBc4qeWAJ9Z4L8nwo0+nhjf4FsgirpR?=
 =?us-ascii?Q?V0yDEqlKyxRcMhc09MTAiVvAJzWO4n9CLBnRPAd6fTJx6Yru9nNya0RoGIMn?=
 =?us-ascii?Q?dkXdC40xJ6lhNs9Op0G+x7Yrxx3/iHL+gu6+Xqq5gj2Q78FPlZW1eN/HD23Z?=
 =?us-ascii?Q?FvSTuDs09HUl7Zo29ot93XvKY8kza5ksSqVip2qQyR9uwqyTYidrViOtEGjF?=
 =?us-ascii?Q?5PjkTI+gJ6tmGhrVrcJK7XJY5x0efnFXd46irWZ0xtrZA1CMqzArVGGYw+71?=
 =?us-ascii?Q?Gc9AonvRn+lpy/6bYNaFTZ7JWlS44DfIYtXI/oY8en2qPqy5GCYsu8d9HGf0?=
 =?us-ascii?Q?xrRf7t4BFdxzFC1VvL386hMl6vK70LsLP8lpR0Vwf2rAhR43ZD6sEX75wUKO?=
 =?us-ascii?Q?/auF1kBvSR6iNt6whN2vtEhiJ7Ls8Xj8BLKJF8iXtrPG6h5ogsbcHUrYTMrC?=
 =?us-ascii?Q?h+cgvWtgxIlm5RLPeKtouGTAJNFZD2yUgPQxzHqt1nXG9L/8ta5jgH/ylxa9?=
 =?us-ascii?Q?wlwyWzA5bzbyRIbbSYAYIa8F8yp2ldf6Ag2DcOis2dJtHE0XA9yvzcm/BSGb?=
 =?us-ascii?Q?PmczgBmQVUvxST8cUKnzLO7g5HVaDgn/Q66K?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 18:33:42.4192
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a92b7c5-c761-449d-edf0-08ddbd84ccc9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9329

Use attack vector controls to determine if spectre_v2 mitigation is
required.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index adc563443c9d..2168e75bc1ac 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1921,8 +1921,7 @@ static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
 	int ret, i;
 
 	cmd = IS_ENABLED(CONFIG_MITIGATION_SPECTRE_V2) ?  SPECTRE_V2_CMD_AUTO : SPECTRE_V2_CMD_NONE;
-	if (cmdline_find_option_bool(boot_command_line, "nospectre_v2") ||
-	    cpu_mitigations_off())
+	if (cmdline_find_option_bool(boot_command_line, "nospectre_v2"))
 		return SPECTRE_V2_CMD_NONE;
 
 	ret = cmdline_find_option(boot_command_line, "spectre_v2", arg, sizeof(arg));
@@ -2194,8 +2193,11 @@ static void __init spectre_v2_select_mitigation(void)
 	case SPECTRE_V2_CMD_NONE:
 		return;
 
-	case SPECTRE_V2_CMD_FORCE:
 	case SPECTRE_V2_CMD_AUTO:
+		if (!should_mitigate_vuln(X86_BUG_SPECTRE_V2))
+			break;
+		fallthrough;
+	case SPECTRE_V2_CMD_FORCE:
 		if (boot_cpu_has(X86_FEATURE_IBRS_ENHANCED)) {
 			spectre_v2_enabled = SPECTRE_V2_EIBRS;
 			break;
@@ -2249,7 +2251,7 @@ static void __init spectre_v2_update_mitigation(void)
 		}
 	}
 
-	if (boot_cpu_has_bug(X86_BUG_SPECTRE_V2) && !cpu_mitigations_off())
+	if (boot_cpu_has_bug(X86_BUG_SPECTRE_V2))
 		pr_info("%s\n", spectre_v2_strings[spectre_v2_enabled]);
 }
 
-- 
2.34.1


