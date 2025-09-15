Return-Path: <linux-kernel+bounces-817091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C0CB57DD5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92E8D3A7D88
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767FD31B828;
	Mon, 15 Sep 2025 13:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hR/9PDE9"
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012013.outbound.protection.outlook.com [52.101.48.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4EB315765
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 13:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757944052; cv=fail; b=h4FddIhCbcI1ixtKII1Ws375Xp7Nipe7kWmniMqi+bpYNoQ66QcUy1uG3bmGuWr6ueC8Ryzs0m/vdVTb2DKIuQThhR4LX7sI9Z28btT/Fjo9b3xONOLBjbZpuZG3Xox0EDKZ+0vIr41RFCXwFhbZSvsFxsEftHMpJ9O1cdbBRFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757944052; c=relaxed/simple;
	bh=T8laaNVb4oMMJHdLFSQrFzNQ7shsJyyNIsFXh//ywd0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cdnRcDFzF+KLMJZcQJAW0cX4EFlxhcADLlHdJN7MYHozy04M/yXCe470q9fZzrhederWYDXc5NzZVc/yTeq3sUqlPRxRwioj71g6RvVVT7064GmYddu2aCoBZY5lvAMFGEkV7Tl3dI0XbZK0DZ/r0oEVIpnZb8UJM6fucHbAsgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hR/9PDE9; arc=fail smtp.client-ip=52.101.48.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BJhxncT0xqhdKCT1b6wahMqyixj5tUjGnHQbjz+jPhbpaY1+hyVtwkuMQ0Vlc4YHzJk4LgjXf2t+XBtoFkeH6+NfUY8R/a4xjOXyPngyXhvVyFaVBlTP89HUPCkokJsAEpouL/HCZXUIR2OZ7EoK8OLxzME9vXH9AgJophv8nb+IsVcYpndCHGuqKYlnLKXUoB4h8yX3R8Uucye2rL1W94Ga441gvYxhDMLCA7E00q0EyVCQcICLSGb0gsFI77iGu31vhNXeUQW0PDayN7E0d5L+p+P92ryA0RgRiAoIZrmuGRtDL02GqaAb1tl23AAiNTv6SVg5PJC3YnKumtxOpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3H7LIWW4xbUPUOesIu4iqZaED8yLEtigQJkPuF3SHQg=;
 b=PPVlBJd4Gt4YYlEDQYpFurAq5ama0TwXIjt1tkE4pc70Bawny6lefB67UHm7n7NiJw3F9zYd35LSoOir+/xo2nxDzHFZk1RWFlG5ZGyRO3QAeiInsfnfKaN6Z9toqaxNn/UhyQ8rrrhziL55JHfQd64G45X62oWHCDneu3EL3qsLCrOVPn9FxVOrRiUwMeN4HT9mWdvhHuPrE1h6BTa2ygZIyRXIhLrh3gsojY3b6wtFuoI2Gnd9Uwtd/sSdCg+wj+BevEgAVkyAGkTK/BZoYSPovpvj9UoSi+Ze4KmwB2A2NX5yssPQNMXzHa+PXs5d4AZhBKTZkHiSF1EI52xPIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3H7LIWW4xbUPUOesIu4iqZaED8yLEtigQJkPuF3SHQg=;
 b=hR/9PDE9axy9Eve8BfO8a0gy7YxXkIFed1/WkPc3ucuo3HCP2xh45Z6qHxHUH7EFY218gzktcFkNrUq9DaE2REy1J+Lz2FzGF/C5Dd8zWgaofHra9HFVPje/kdlK+ULafS2sGs1IqQN8C7svXV9G7JiEHzbnCq24ewIh5RZ1PQ0=
Received: from SJ0PR03CA0116.namprd03.prod.outlook.com (2603:10b6:a03:333::31)
 by MW4PR12MB7238.namprd12.prod.outlook.com (2603:10b6:303:229::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Mon, 15 Sep
 2025 13:47:26 +0000
Received: from SJ5PEPF000001D4.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::e9) by SJ0PR03CA0116.outlook.office365.com
 (2603:10b6:a03:333::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.21 via Frontend Transport; Mon,
 15 Sep 2025 13:47:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D4.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 15 Sep 2025 13:47:26 +0000
Received: from tiny.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Sep
 2025 06:47:23 -0700
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 4/7] x86/bugs: Remove uses of cpu_mitigations_off()
Date: Mon, 15 Sep 2025 08:47:03 -0500
Message-ID: <20250915134706.3201818-5-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D4:EE_|MW4PR12MB7238:EE_
X-MS-Office365-Filtering-Correlation-Id: 35ac21a0-0fae-4a7f-cfbf-08ddf45e6814
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nUM+fnDaosWMjpWQvCEnIRBT4HERfIK6MRc6NXkqbOuLPMljKbuyDpsCbgCt?=
 =?us-ascii?Q?K9938tU9EOw8RdfRlDSUDjPEqSaPIYlb4/HkD1tzfBHkyUf5bOYqZ5vyZbET?=
 =?us-ascii?Q?vTPNG71gd27h4i0KOIJDW0+nV1ikk937b2BLVHVKA1Nx9A0S7YXuhmK8N1zL?=
 =?us-ascii?Q?yHTWb+S0P76syipbD1/FqsQYLnrxYQ8ckzYQwvasNc748z3JIxM9PFio0gMl?=
 =?us-ascii?Q?NLa05U8vLI3zG1E8JPTFkN+4M7I9FmIT+QdFK3FPXfVu40xZsRC1V7WDFO+q?=
 =?us-ascii?Q?916y0XtvVOcI+GjdI9BQLC7S3Go122m47hAdsm5IbLL7QfnhKZNEnqCwvI54?=
 =?us-ascii?Q?7WCqV5vKgNhW8L85z7bsi/5NkFH/ZwhLHsingaJQ70js9EE6y0PiUaqig38d?=
 =?us-ascii?Q?75Qu5VWeOeypnnC+Wx+4UA72f9j9tRyCoNW8w4AiC122oEIdRm9cEflXzV7r?=
 =?us-ascii?Q?PmZ5Mms4hFj0oftoC0hs9QQYJvSesglymVwr2LtnfWN7A1vAHcP9T4y0Y4zk?=
 =?us-ascii?Q?st3XghGQ3fj6NZT3A3GUCcVOVlyYA/60qjaJ5f/g1O6XeyOv9EvIQbgRQiXU?=
 =?us-ascii?Q?Ma+2agplw/U+TrWQii0oNAVXNaXKwL76Tl1smNGVXrN8JaIHiFU9FIaBBwLm?=
 =?us-ascii?Q?kQZwVkm/OL4ZtfzS2VD8eR5YBj/zs5jjl+JZyudORreeRtsWfR/1bLRKO01U?=
 =?us-ascii?Q?Sgp3FEXAdYZsmcSpsEN3waFkcZdSvwLLwDAC8Ycgpjn1nWI2yMyiyMaD64ah?=
 =?us-ascii?Q?Semu0o7ooWg6iRlec5BWDldoh716FTsExbNr+iZnukPdzKqTfsFRpZN03kqV?=
 =?us-ascii?Q?d21NhUr0yhN7u0git1+nU7bkxfhhR/S+gbUavGs1WnGzNNj5FsMs2pLXq8Pp?=
 =?us-ascii?Q?+tf6n8oONaZ2nCL5TlWtuKA/KkvJWEJrZaFibuHu3zsQC3lvEcDj3YCceltQ?=
 =?us-ascii?Q?FG3nNfQTqf6dUlLRBnHS5LzL75ipBauiDF3YRN9MciP7qgYvSJqXsUNKkocP?=
 =?us-ascii?Q?y/sjg8AvpzhEh6VW0OvSQuUV3LfcLms7NM3lUuLVwwXDQHrueANuNc9a2rDR?=
 =?us-ascii?Q?2Yd1RSwfC8ReaFDUZTwMsxmY252IHbFnS6hIfOdHqQiYYT+K3pgkUuTRQY+Y?=
 =?us-ascii?Q?wqLLF/05Ko42noLViHQ6wNAWNcyGjuBA/VuBC1aSvBiXnh2wrFqSiM95KUIs?=
 =?us-ascii?Q?IH/1TKMcnTv2JWTSoFmgjqp6rEKVLA/BERWJSXaQD0hckxRbEtjaxAndPnEe?=
 =?us-ascii?Q?RukiaNUQJoCSD869WRsjk/aLGVZfudDa/KGh0g4fOf0zHSzbuoVParlq92Gz?=
 =?us-ascii?Q?3HVbaHmtA61Og7H83/xg5UX1ZYbCaYDE3Tnxm47Q7Tdr7MYRNuiMlclX76IO?=
 =?us-ascii?Q?FhLC/LZuhys3rI+LuOkWFuTeuCyqLahfIOTicMBgP1qMMSgh4EGhJaf+itci?=
 =?us-ascii?Q?Ql9Y4r55UZnJlHTg03tX6W7q97fW3OqwH0Vw+QW9JrKQ9oxnGzw2YNeECXk9?=
 =?us-ascii?Q?/ySW+wCq5EzahoJHHmxpmKrqiQoljG0TY3hV?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 13:47:26.5448
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35ac21a0-0fae-4a7f-cfbf-08ddf45e6814
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7238

cpu_mitigations_off() is no longer needed because all bugs use attack
vector controls to select a mitigation, and cpu_mitigations_off() is
equivalent to no attack vectors being selected.

Remove the few remaining unnecessary uses of this function in this file.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
Reviewed-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/kernel/cpu/bugs.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index fe57e890d56c..d52600b89d60 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -687,8 +687,7 @@ static const char * const mmio_strings[] = {
 
 static void __init mmio_select_mitigation(void)
 {
-	if (!boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA) ||
-	     cpu_mitigations_off()) {
+	if (!boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA)) {
 		mmio_mitigation = MMIO_MITIGATION_OFF;
 		return;
 	}
@@ -3130,14 +3129,15 @@ static void __init srso_select_mitigation(void)
 
 static void __init srso_update_mitigation(void)
 {
+	if (!boot_cpu_has_bug(X86_BUG_SRSO))
+		return;
+
 	/* If retbleed is using IBPB, that works for SRSO as well */
 	if (retbleed_mitigation == RETBLEED_MITIGATION_IBPB &&
 	    boot_cpu_has(X86_FEATURE_IBPB_BRTYPE))
 		srso_mitigation = SRSO_MITIGATION_IBPB;
 
-	if (boot_cpu_has_bug(X86_BUG_SRSO) &&
-	    !cpu_mitigations_off())
-		pr_info("%s\n", srso_strings[srso_mitigation]);
+	pr_info("%s\n", srso_strings[srso_mitigation]);
 }
 
 static void __init srso_apply_mitigation(void)
-- 
2.34.1


