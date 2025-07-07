Return-Path: <linux-kernel+bounces-720361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9E1AFBAB7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 20:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42BD14201EB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 18:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CF72673AF;
	Mon,  7 Jul 2025 18:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XO3GnsJf"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA14C2652B0
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 18:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751913221; cv=fail; b=rX7BpMyCNYDESGjnUWOIot1KZ8jnicntLrAIlcsej+GeThoRoIsyxVWWstbO/ifFleZjwBoHMYZGorR/E+YeeQNUxLRSbD0Tu+T4P0tajNQXk03qInG9nn2m2OveGUPLtRF3zoItssLT/OTVXALyXZmR1/t5nwT3Oq4U8K5tUH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751913221; c=relaxed/simple;
	bh=kFPF+78lwo9qlUMYIKbpjfx6hWjpSCpOwkJiN5tDDX8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=At8agr9gb7oJRoRMGnxqiZlRn8p80xa3Kc4+otrgAJ4vxyacVmvL72PEkDZXDzIL1xSRO0HE0Yayqqht1//QqN9DhogwNOvQiRTZMOnusKt6R4Ef4O+TsUk/AlLBr7B4D3c/DTHUD+fCH8SEvotTjx31tLrRUNvIjclD6T8rVNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XO3GnsJf; arc=fail smtp.client-ip=40.107.244.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ykYjcFQ6bbhcBiYEwbuLkXjzkLPlJ+hanb8fjGthT47mKxHuUvU1u38/iAcXprb/tOHrtsQi2g6E6RnEtFqM1heEj2/1ohJGS6aZdL8ojfGv+uT2ahM4uw8EAdTTmoDzdJTL2m3/FW3iI9kmux69Hi3RXpfNujUfw9/5xUS/QZ1XDQPTQwCvcCZQyz0KbOS++vVUNH2zItv0tZfyspFeSd+h2vZMTOp6ddHJhsOtN5ftdpfjMW07+mDBSh9weSMbwlRVYrCVprOhBqxaJvFN8fOPF0l1jPpswA0ZlRjucX6uXRhNlSUHSrXq1upbyJI22e55cqY+PxIMUriiGq1kcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DcJ85H/DFDAE8egqVxsD/bqet/WFj1nA4Qck7+i6UGQ=;
 b=ncfQuu1lJO496f8dPFGRAr93tXFZ1eJN5aPK4lay5vio5tcSgP0GlpSqR0taa83tdpqc1KYHtQoILsR2UYa32cqQ7wdiW4+dg+7cfomRHbCtyXmOlwLedmX4ZDQYcMeQQNuhuW7gbVG7mhDeY81iEjHGgAxfPZH5s+21pRW5ga1FMn6+pS59rzh+CJZlhmjTdW1djkqorolysj7wLZ28lWkiCA1YB7Jba9FKP/ptU764NVGJdEX8bwoD+T5LjiPT4JNmwRu3KmxJtnBsX3wYlkIfPhV4IJSylAJrLicyyrjm7RF45KwYkFvuK4O7mbIk42mIx+rTKUDWLcrqFh2ICQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DcJ85H/DFDAE8egqVxsD/bqet/WFj1nA4Qck7+i6UGQ=;
 b=XO3GnsJfuyl6kCiwUoUlXrUrraB0R/N8ZuYzI5ybJggpjN1/MdXACmszX3f3U+nTJrhBN2emgWlBoB3zguyRBa/+bh7BwXXiJLDEQ8mYaLQ5mpt2SKCCTSa0W63rr2gO4DRAso7YLv3e/HOZP09ZVG5a0JRurylFbSsOynVhgWY=
Received: from BY5PR16CA0020.namprd16.prod.outlook.com (2603:10b6:a03:1a0::33)
 by SA1PR12MB9470.namprd12.prod.outlook.com (2603:10b6:806:459::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Mon, 7 Jul
 2025 18:33:37 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::e1) by BY5PR16CA0020.outlook.office365.com
 (2603:10b6:a03:1a0::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Mon,
 7 Jul 2025 18:33:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.20 via Frontend Transport; Mon, 7 Jul 2025 18:33:36 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Jul
 2025 13:33:32 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 07/21] x86/bugs: Add attack vector controls for MMIO
Date: Mon, 7 Jul 2025 13:33:02 -0500
Message-ID: <20250707183316.1349127-8-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|SA1PR12MB9470:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c11b92a-8a18-41c7-c847-08ddbd84c969
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4DS+arjD3/gHZwtwUoDMuuirgGkZkW8fEhC9DyhIu9JEgB1cr6aLMdVDJS72?=
 =?us-ascii?Q?tQpr38sEnmY11HwmL8Us9VB/tkidUgDbZOyUfQBNP8wPXWaoUUVAVuEA1Pi/?=
 =?us-ascii?Q?sZNJKpWwaEENs+2/gFDEYrWE7MZkEFcLNQboS+y/PmD0w/iYb7Wmm0zCFG2G?=
 =?us-ascii?Q?UC87DYT7r3OHHJN0q8cSdM3Z4ryf/CQYeJUqslEgkuVLov60xaKZa4JsJJbe?=
 =?us-ascii?Q?jBMQdnZCkv6e08w4EW1KtAUV/rY40gFsYqnmmciJD6QWETS8uk0MD0YDkzax?=
 =?us-ascii?Q?8tLWqBA0TZoAOxEd2M5DRW255OAd/w6Sh5DhEY5/22OtFi0LeXysmy11hSSC?=
 =?us-ascii?Q?qeNbrCBWKdRbF88KI0mBq52grE4p94K6lYfoJX3C9PKc56UbLNLy13do0sjS?=
 =?us-ascii?Q?vRSrbCccfLrWrU/J159/2e179LO2OSRdwecI2KDYn4G9p4gvq/SHOHtUyoEy?=
 =?us-ascii?Q?xETUYn8VKU3OwsCUp+s1kiJFTa8dKTjaKahWPVXYwT51d1UTLAGUSviWXoT5?=
 =?us-ascii?Q?khMn6RGBmWTQmu+vhfxVSowlbmXvIX8zu0FT36lRn0Pp++bBD/vs0Vrc9oN3?=
 =?us-ascii?Q?a/mEIqdMJgAOk7kb0uQLtP7Cf/pvh1NNZ/xYmT3PhtGfig5X2x2CzmLVcaIT?=
 =?us-ascii?Q?gtgVMSOHFhv1vR3uwOgRcvvloEZdV1buo5IdrUx5jPn8yljv1JjYBaOv4ssU?=
 =?us-ascii?Q?eKFi7bFy36M/ryJvg3/VrXqJhNPl8lg0KDYBaaKxMtTkUYIpk8UvM7FlkGhA?=
 =?us-ascii?Q?q6i9m09u5Zxwh7XBVM2H0hVhTb6IlTzCxNgWrQRH0Rf5C3OsR8Uy2AYQt2Dt?=
 =?us-ascii?Q?66yNlaJyJWYfBduZvCM8LLVWSeVNWhd/t5mcJTYwp+OTronJJdgEfHICqULk?=
 =?us-ascii?Q?cVUxg+5owKBRkCW8AGD9fiC9Q3svymcFRU/jfJ56ByW78EjXC3dfAbRQOr10?=
 =?us-ascii?Q?0Q/4LQzzZPWMwtk/RKYF74s58p4NW2T07Gv5Wfdm1UCvQyCdS/CpjZCcbhiI?=
 =?us-ascii?Q?TCBkrpI5g4E/vD6krfCj3BP4DnHK/j02i0zWE9boiiIhi636jC1o8XjDTHmM?=
 =?us-ascii?Q?z99i0rzgpYT5bIJVDkINrCPTajqC7cJXcE7pJoqf9iUjBoOo22BidhImn/xd?=
 =?us-ascii?Q?MLpwtMG7zmGOdx03lnLal8K2cCSmeVXbqAQoisoP+Kq5ClistHK+xl+Vt5zo?=
 =?us-ascii?Q?2XYJXtl17h3qrpn4CmQR9fLwY4T1NyAkBgOJwsedI22pu+7ZKBxAmKU89zTO?=
 =?us-ascii?Q?hFGXn28u13rJzvaG0Q0CPV7YxxSR40aNBut60FzjAU1wpUH54co2WkffRY1N?=
 =?us-ascii?Q?615wSNN/9MSfhgDIRhKlqBjaDELeI/vcGjamROJMwyyYnSTc9gvFu7Em5iT0?=
 =?us-ascii?Q?pxM3XzhtSgIDP4YMYxEVHip6n1LcJIhQQHXwrslY40LclRsASZHNrLFLEiV5?=
 =?us-ascii?Q?s8YKZ62M9Vg4WFnM3EVNQX+ilgcTsZZSzVKkJDJaM8UyOIOUsVLkATlpZZ8l?=
 =?us-ascii?Q?6YOYGoq6N8Egx6TnGcUohd4I/Q8SzCMShdba?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 18:33:36.7604
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c11b92a-8a18-41c7-c847-08ddbd84c969
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9470

Use attack vectors controls to determine if MMIO mitigation is required.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 527ea049d4cd..9f81a236735f 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -635,8 +635,12 @@ static void __init mmio_select_mitigation(void)
 	}
 
 	/* Microcode will be checked in mmio_update_mitigation(). */
-	if (mmio_mitigation == MMIO_MITIGATION_AUTO)
-		mmio_mitigation = MMIO_MITIGATION_VERW;
+	if (mmio_mitigation == MMIO_MITIGATION_AUTO) {
+		if (should_mitigate_vuln(X86_BUG_MMIO_STALE_DATA))
+			mmio_mitigation = MMIO_MITIGATION_VERW;
+		else
+			mmio_mitigation = MMIO_MITIGATION_OFF;
+	}
 
 	if (mmio_mitigation == MMIO_MITIGATION_OFF)
 		return;
@@ -651,7 +655,7 @@ static void __init mmio_select_mitigation(void)
 
 static void __init mmio_update_mitigation(void)
 {
-	if (!boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA) || cpu_mitigations_off())
+	if (!boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA))
 		return;
 
 	if (verw_clear_cpu_buf_mitigation_selected)
@@ -699,7 +703,7 @@ static void __init mmio_apply_mitigation(void)
 	if (!(x86_arch_cap_msr & ARCH_CAP_FBSDP_NO))
 		static_branch_enable(&mds_idle_clear);
 
-	if (mmio_nosmt || cpu_mitigations_auto_nosmt())
+	if (mmio_nosmt || smt_mitigations == SMT_MITIGATIONS_ON)
 		cpu_smt_disable(false);
 }
 
-- 
2.34.1


