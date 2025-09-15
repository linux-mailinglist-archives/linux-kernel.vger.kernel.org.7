Return-Path: <linux-kernel+bounces-817093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9DEB57DD8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D56417DE61
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F8E31D722;
	Mon, 15 Sep 2025 13:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Gyw3ivKH"
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011057.outbound.protection.outlook.com [52.101.57.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B423631B808
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 13:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757944054; cv=fail; b=aO9Ns4OYOFq88xIfY39k8F1KuD9umg1ZEKMN0mOMAusrRAmTBhWFnxoc+Mlm6PMx0L+0wU+R8KRFONcR3FOH1XG2z9H+P1RgXZfRwmHrAmDANKlb0pThKZYD3Lkr80Vqp1rG6FRHrlylpysvYIEETw/wfVz1OTBUSGAXyRTqJm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757944054; c=relaxed/simple;
	bh=pAP0HZDC5hkjUB/uHcYJZj4dN0Rv+z+0tE9CDItUCfI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PjPlweaXhVvoJVLfu4ZCWqQ4o06htnGkRQ4LwB3S7slKgDwxBrB0w/xywKTGxSvaT3P4e8lh2j5TwzJvRvbWxa0ZSMalBr07tjbQ2EbofCLKl/eBvHKH5QfOysi2WcwTnmYj1fvzMgIp+LyW8e4ka/dm/ZgRtHCWqpOaon0ySeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Gyw3ivKH; arc=fail smtp.client-ip=52.101.57.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cCCMtnoiZdk2/iYqRYg/xOEqCNa0J+XpjGPlJh3KKR53gpMKULx9oTzvKIh+jqA+oj0LBQUzS2GkoCK7DdcOrMWiMN1LFL2LnRKUZbQkKWjzLt6+s4WEE+e6SbVyy4YXN1gY5H0q++VXXwuPQp3ljh8ZqaM5cIKcsn8eU/qOnlzow6Acrvc22Zxy1WTaQnELATk9YIjNRz4zQLV1g0rzkISmvaIfwsiulxFleMsZSOY7dVkHOcjC3MHG8Kvz1v1VR+ihKOdfhXEllFSbzQ1L3bSKYNo94h7cHpFUES/5ZwqqU++R5E99CX2qSYwOlDT0Ftu3nxPKtq499i8HFto/nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yMcHlvm+fgxajDTFz/cq1jCbiG3/bxDjNX69dN2Hsn4=;
 b=qxfg0I/DEh2zNN1yhaF4h36Bof9McF9Aa7qsTGvsKnBtwR8Bi2u1OZHNqPXxHEAhElCtz9o/y7KnPl6fGKLDvFQiF1a+DD20uFvL6A1TloZygQhSBPdTD2bt2CzCQfiDwAkWP5qF7cenn5oofa1Hk/Z6XTkfiK5j+CsXLxJzlehrUkgUccvwo8uRfzbd7RzwnU46IKvBMel2ViqeuHTngpLG6PLW35Md4YlIMM2xu82KlygfM7ZVp/tfj6bbOyeukT9KsFoJHYbFhd1Sobvk0qVZVV3pow0j6xMVZUKTonSVE4I0IP2Xb0KCZFBwcMDtSkjhNnpytuMRm92nwfEjUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMcHlvm+fgxajDTFz/cq1jCbiG3/bxDjNX69dN2Hsn4=;
 b=Gyw3ivKH7EGIYKi+ycsk0lprft+kIVdKtTnT3SmfdiQW9fhjjfWeoB2ZUq4jkC7oCvE/okUXBn3uG/MOnpn18nKi+dH5RDiIwCOQuYYtPJj5JcVpqlN1Z3GDV92ieOH/w+f6CpzEq+bhEZ1r3UdSuq46Bb25UKiWXRpVGCAd+sc=
Received: from SJ0PR03CA0103.namprd03.prod.outlook.com (2603:10b6:a03:333::18)
 by SA1PR12MB6946.namprd12.prod.outlook.com (2603:10b6:806:24d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.33; Mon, 15 Sep
 2025 13:47:27 +0000
Received: from SJ5PEPF000001D4.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::62) by SJ0PR03CA0103.outlook.office365.com
 (2603:10b6:a03:333::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.22 via Frontend Transport; Mon,
 15 Sep 2025 13:47:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D4.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 15 Sep 2025 13:47:27 +0000
Received: from tiny.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Sep
 2025 06:47:24 -0700
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 5/7] x86/bugs: Fix spectre_v2 forcing
Date: Mon, 15 Sep 2025 08:47:04 -0500
Message-ID: <20250915134706.3201818-6-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D4:EE_|SA1PR12MB6946:EE_
X-MS-Office365-Filtering-Correlation-Id: 26460b58-901a-4970-415d-08ddf45e686c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IUjPS/wBFI9EJmY5KSgTNurfpJXG0ssmUUjppm0dCeXI1V0nhDvX1PXli76F?=
 =?us-ascii?Q?xj9cbJMAtQOF3+i+M/km3K7+wJfAZv01V74BFVMRRnikhmLjbAa/VubY65mU?=
 =?us-ascii?Q?oXCJ+wFAHPAAjKvQtX4UZNf7d60KkkEZ8DO3gOEJdRhGhzSSlk/2He9SsWjj?=
 =?us-ascii?Q?jPwJkbCqQtgh68tZ0RoLgl9jAjWAoN+9kRZQLTSSj9GBCG+de3HZYmJxsnPK?=
 =?us-ascii?Q?jz45amT6J965qGjpSqv/Sf2JAWGz5vMbtKevWa5ypuPkjPeJBu/eZbBn1X9T?=
 =?us-ascii?Q?wNSfuaySbOE/buGSUaIGNaxJihhMPwqX/Tw5HdRXRu2z3Dl4mEZEh+DNfcae?=
 =?us-ascii?Q?GHg9n0G04/uV8vzHdONgdkAEruZkY+QdgZBYJvHtlOnIVA8lApS7q/gljJHH?=
 =?us-ascii?Q?NriH2jZrqnWFD2zqQp99aEmoJA9/GujCrjbVwOMehYcPKATA7IGSzuJEVCg/?=
 =?us-ascii?Q?mfjt/o9th2ZWiyTAJ783ZpuVpCH4rysB7GVAlNN3h28fMSOUlwsPtzQLbbNz?=
 =?us-ascii?Q?5Na0XdRN4ocxf6Fsvg2xUOO9HQghiIcFI7w5RO530wze52r7bgK2tKxrK3+I?=
 =?us-ascii?Q?ZMXj3jou7Il1DHIVSFThngytzrMvpXqzjtQkxC3aL/KJhdJUwmqoCV+VwKhe?=
 =?us-ascii?Q?s+p8Kxe7sc9QXMpumUCw1v88x/TpbMBsk4eRSPC0xDlWJKJsK0Yvk6nuBcCU?=
 =?us-ascii?Q?RcsqQ5Nk48bCmoweTKWJ1mWue8aXrw19qunGDEcZiqCq5LcjfTiIHitq9dX/?=
 =?us-ascii?Q?CW7BL9WVGl6TcfN6VOOQYti5EkDK0/VKVQUq/bNpWbSENMxMDtYtc9/6GxDp?=
 =?us-ascii?Q?0bE0jYrDXJKuXPyVDOLsitZjCzz6CzYmlOtLxlFfS+CaBAYuO6sKf5JQ3nY3?=
 =?us-ascii?Q?SCbQKOFA3VhYiG5CpQWheM2gNCm5IPxkz2rhgZtE3O5g8dgJ8wXW9o7QLGDX?=
 =?us-ascii?Q?8mVhfhzjjoDXyk0GYB4Fq5Ox+uAVsMag6i1kqYtAE4B7YJ1TZAbUzWoVAMo/?=
 =?us-ascii?Q?k/UsI3GVJku/K05+cShjCEzqEL+Gsr2V5WLFLouL0tJwTGOXzpRsXgNTgobq?=
 =?us-ascii?Q?Hkshxy84wPNI+i/VIanQ/ei9CHz+wC6M7CTx3bAi42Vk/IKgTArxDTPsEp/9?=
 =?us-ascii?Q?UA5S3B2tQhMXw8mbbw0cwoeYMf44cs4PR24GBMlR+RNvGs/L0kuEgh7t3xiw?=
 =?us-ascii?Q?ve+Nn82QqDMV7zuQ8Zv/ocPbUVakcvY6AnaLMsZEyQswasZffWUULuELWndu?=
 =?us-ascii?Q?40XjMJra+MEpTsYBPg8xu39Na3NEi4PAF1W2KbnfKZvfA6slKQYn4kK5Xvhr?=
 =?us-ascii?Q?Bsz2JC+0W9kOJLquhPROy7Wrkiy0xTheTgWX1PHa16DJ/tE/QEq563lqkpSc?=
 =?us-ascii?Q?uLoV3EcZKF3cpot8nqYsc3zO4VCGPxxcYTfcTR7XEZ6h4vGddhLLwZSQqUk8?=
 =?us-ascii?Q?ij5R5muO4v1Jmqu+oIoM7RZoz7QItTAKRb6ACnrTFt5MN4+uwl3zkycQr2CK?=
 =?us-ascii?Q?a9EF9VpELMeoMTuxDl+ARJUWeYurhUjwUV4i?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 13:47:27.1176
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26460b58-901a-4970-415d-08ddf45e686c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6946

There were two oddities with spectre_v2 command line options.

First, any option other than 'off' or 'auto' would force spectre_v2
mitigations even if the CPU (hypothetically) wasn't vulnerable to
spectre_v2.  That was inconsistent with all the other bugs where
mitigations are ignored unless an explicit 'force' option is specified.

Second, even though spectre_v2 mitigations would be enabled in these cases,
the X86_BUG_SPECTRE_V2 bit wasn't set.  This is again inconsistent with the
forcing behavior of other bugs and arguably incorrect as it doesn't make
sense to enable a mitigation if the X86_BUG bit isn't set.

Fix both issues by only forcing spectre_v2 mitigations when the
'spectre_v2=on' option is specified (which was already called
SPECTRE_V2_CMD_FORCE) and setting the relevant X86_BUG_* bits in that case.

This also allows for simplifying bhi_update_mitigation() because
spectre_v2_cmd will now always be SPECTRE_V2_CMD_NONE if the CPU is immune
to spectre_v2.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index d52600b89d60..317c26e08827 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2057,29 +2057,32 @@ static int __init spectre_v2_parse_cmdline(char *str)
 	if (nospectre_v2)
 		return 0;
 
-	if (!strcmp(str, "off"))
+	if (!strcmp(str, "off")) {
 		spectre_v2_cmd = SPECTRE_V2_CMD_NONE;
-	else if (!strcmp(str, "on"))
+	} else if (!strcmp(str, "on")) {
 		spectre_v2_cmd = SPECTRE_V2_CMD_FORCE;
-	else if (!strcmp(str, "retpoline"))
+		setup_force_cpu_bug(X86_BUG_SPECTRE_V2);
+		setup_force_cpu_bug(X86_BUG_SPECTRE_V2_USER);
+	} else if (!strcmp(str, "retpoline")) {
 		spectre_v2_cmd = SPECTRE_V2_CMD_RETPOLINE;
-	else if (!strcmp(str, "retpoline,amd") ||
-		 !strcmp(str, "retpoline,lfence"))
+	} else if (!strcmp(str, "retpoline,amd") ||
+		 !strcmp(str, "retpoline,lfence")) {
 		spectre_v2_cmd = SPECTRE_V2_CMD_RETPOLINE_LFENCE;
-	else if (!strcmp(str, "retpoline,generic"))
+	} else if (!strcmp(str, "retpoline,generic")) {
 		spectre_v2_cmd = SPECTRE_V2_CMD_RETPOLINE_GENERIC;
-	else if (!strcmp(str, "eibrs"))
+	} else if (!strcmp(str, "eibrs")) {
 		spectre_v2_cmd = SPECTRE_V2_CMD_EIBRS;
-	else if (!strcmp(str, "eibrs,lfence"))
+	} else if (!strcmp(str, "eibrs,lfence")) {
 		spectre_v2_cmd = SPECTRE_V2_CMD_EIBRS_LFENCE;
-	else if (!strcmp(str, "eibrs,retpoline"))
+	} else if (!strcmp(str, "eibrs,retpoline")) {
 		spectre_v2_cmd = SPECTRE_V2_CMD_EIBRS_RETPOLINE;
-	else if (!strcmp(str, "auto"))
+	} else if (!strcmp(str, "auto")) {
 		spectre_v2_cmd = SPECTRE_V2_CMD_AUTO;
-	else if (!strcmp(str, "ibrs"))
+	} else if (!strcmp(str, "ibrs")) {
 		spectre_v2_cmd = SPECTRE_V2_CMD_IBRS;
-	else
+	} else {
 		pr_err("Ignoring unknown spectre_v2 option (%s).", str);
+	}
 
 	return 0;
 }
@@ -2232,10 +2235,6 @@ static void __init bhi_update_mitigation(void)
 {
 	if (spectre_v2_cmd == SPECTRE_V2_CMD_NONE)
 		bhi_mitigation = BHI_MITIGATION_OFF;
-
-	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V2) &&
-	     spectre_v2_cmd == SPECTRE_V2_CMD_AUTO)
-		bhi_mitigation = BHI_MITIGATION_OFF;
 }
 
 static void __init bhi_apply_mitigation(void)
@@ -2321,9 +2320,10 @@ static void __init spectre_v2_select_mitigation(void)
 {
 	spectre_v2_check_cmd();
 
-	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V2) &&
-	    (spectre_v2_cmd == SPECTRE_V2_CMD_NONE || spectre_v2_cmd == SPECTRE_V2_CMD_AUTO))
+	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V2)) {
+		spectre_v2_cmd = SPECTRE_V2_CMD_NONE;
 		return;
+	}
 
 	switch (spectre_v2_cmd) {
 	case SPECTRE_V2_CMD_NONE:
-- 
2.34.1


