Return-Path: <linux-kernel+bounces-720372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1062EAFBAC4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 20:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 778D91AA75F0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 18:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B28126B946;
	Mon,  7 Jul 2025 18:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="I+WgsI46"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2079.outbound.protection.outlook.com [40.107.102.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3048426B776
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 18:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751913231; cv=fail; b=nYFYKmJc9L4ZaVb8MKWNLaX7HsK7jODvtEeANTBQlBkJ7ScQrm/d//Fx9YL5Dx6cX+J8XRHV9PKucc0t6tJ9POTFLFMRD45HHKwP0g0JianxWX69EjuyrOqhd/3Y4WSx+jNU06Nm8uEctuOkeRJkcuUMdc15/xcTeAQ4k5lw0qk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751913231; c=relaxed/simple;
	bh=OAeQGfJRSc/yfGqnDEGQJh+MhE0gcNuFnYpN0tJFp+s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dKPzH/zqSFfinNvnPLOUqPmNECT6DSyZXkmWSNNPnGU+qWICJcYWWsB46mUTQIAB37WSyHa/Nv9Isc8Z+HPPJX/pm/vikWlN1aXHCTY54A6C1KGXvCVQet21S8gr1j0NBRj1IiSAhDDXtGYk/lygDkO3waTbYtntmmlTVQPD8UA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=I+WgsI46; arc=fail smtp.client-ip=40.107.102.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OJyvqH4TtT9gltpL3epDEqCnRvfo+ZFKKJDuhIHgEFCm3fjQTm6a3FKCh5SuLfByZ1eMbMVRRcETe9LPW3LpHg08iSgqPH2WxGyC/RalGik315Q2MN2BkpF0vyQvneiDq29MkPZ92XZuG7/v2tbU7B0RqqIHFlauL3nnEbcQGBbYuDnCCgdEWVx3xhifxwXKYclz5c5/M8YD0MnAakyzGygTBsdREXaBeB3aaRCFxd+5Gn+grLnRC3tpTvucCXVVIDVAhHMtb1/PQe5WF02aQjt7pJihS4Z5WMr1G+NE0VuujUtMSv7gwSGvYuEQQZUQhwM2C+cFHbSMW6VtIyPjPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=02U2US11ebDKiFo+FtxmjCB82RnST0ycZW2jDhKQDlw=;
 b=ndHeCpnFrxXkpaEFHu2GOfeJYb50jQPfgFdr9tzMYUxYsnB4FhV9X3UVi4aU50JYP2nA9sLPlbFUWbGlHLm2hGR+xZ4ly/dHV9k8Je9E9GP970TM4BybL/grkeQJ3PqUCnYMdlAzlePLW6JPqjDGWi0VuZIjAhnrR+U86XAzL0CfQ5AwdH/LnGMwozldCtvehC13eI76fL37smnOZdKEiaGIWIxP9VR8aJpvmwXSmlRPJU9padlXbthST1P15iK/qtxEpV91tM4yytcG6CLKRAVO2fAnMxVB5Rg7LSXfAuIyRvlcAfG4Fs3gNnawfMXVGb7ML2ZDYcs7klNdK7sFow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=02U2US11ebDKiFo+FtxmjCB82RnST0ycZW2jDhKQDlw=;
 b=I+WgsI46IW3JeWvqB4RI+AEu9jCqU9qXOSrQGV+39XAhRJ0ccIh6FoYYhvhHezwq9R1PK1cPgqy3lPY07j+UT7OtiSr4BWTZ/bWQ0VdPSUVK+6slgc6fg1U2JMfrdNt5+scbxDedbL5/hp3zFFV37wEv1PRuVT99B9UiQzkqlAI=
Received: from BY5PR16CA0005.namprd16.prod.outlook.com (2603:10b6:a03:1a0::18)
 by BL3PR12MB6570.namprd12.prod.outlook.com (2603:10b6:208:38d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Mon, 7 Jul
 2025 18:33:45 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::bd) by BY5PR16CA0005.outlook.office365.com
 (2603:10b6:a03:1a0::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Mon,
 7 Jul 2025 18:33:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.20 via Frontend Transport; Mon, 7 Jul 2025 18:33:44 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Jul
 2025 13:33:40 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 18/21] x86/bugs: Add attack vector controls for ITS
Date: Mon, 7 Jul 2025 13:33:13 -0500
Message-ID: <20250707183316.1349127-19-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|BL3PR12MB6570:EE_
X-MS-Office365-Filtering-Correlation-Id: bac2e397-d36d-4171-3568-08ddbd84ce14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8zSxi4rv9qkxvr/rtMAitMMUV7TmnhZCf+8cEoIuUd+L7vvAzKJo319UqzQ+?=
 =?us-ascii?Q?1GDMyY34Auf8Ss+214m+dVl82xYIDb5FCOldr9W/lxTlbQNuVVqOgRpgj+gr?=
 =?us-ascii?Q?kuwbZoZg5F72w3l6/knDSY9xj0b1T+k8ce55wD/jNqsBeWhtW0UANSjSooij?=
 =?us-ascii?Q?yxkAkWn1x5GFrzCR886CHTH11ovUGl97eKZ8ws9R5RospqNzTO+qNxG/D6O6?=
 =?us-ascii?Q?25WrdxEsAtGMtbR8JmzzB+iPniqt4ixx+erxL4Hof12lDpBzGzItiBuasG96?=
 =?us-ascii?Q?7E8W9KEEXGUCtZsi24yS/We2ph2LKhpogK/Pk9nesGRRefbQAirwdFnHFQrj?=
 =?us-ascii?Q?R6RhZehN9sGZMUh+elU6t+R2kBr5nvqx3FTnp1LQ+L0uLt0dyY7V2LpTaO5n?=
 =?us-ascii?Q?bCtV1cX+iAO/HR7ZRi2OjaGiqZv54W2/PLhDScg/mm/Ls2uRNFdwQfCnBJzu?=
 =?us-ascii?Q?afbwtNoUY17pJLnLbI5azOHz8iTBfYER2rlYuYllzCHjhc16PG2MxHsWOZl/?=
 =?us-ascii?Q?4pQgKvMMjbXf7UElSwQs/DB1yBT9UL1qwZ2qoHDQCtk+fbR17VxFMji6Q2wU?=
 =?us-ascii?Q?upXRPvS8hAdzHglZBlbKWlJaHt0aShMdDNHH5QOH/UFm1ZVnUGiX8RmHg9Qz?=
 =?us-ascii?Q?BB3h0n8PiypQLKXVqYwlXVQe1EdjRIwCokyFJ+KnnbG/NX58b5NhC7PEDyXA?=
 =?us-ascii?Q?Y5rWjcL2q+r37n2SViwG8kuXx4h4SJxeZzryls2yjv99lH3wslz28ptZ2VRx?=
 =?us-ascii?Q?ypVrMxFfhw1vI/4thO7GF0mCMlFRnpOpisMuV/nhTzWfCc43cBCB7nykxCYG?=
 =?us-ascii?Q?IinoUYqLRyifSiTRNpMqk+h40GBs6ZHf5Zf7HwTrJDpMfJrVQ/8Py+7bGwam?=
 =?us-ascii?Q?FV6o7l7+eB88w/k3tlXSN2vAwsPoFb1jvJr16/gJiPd6lkbtW//GXtVlq6jw?=
 =?us-ascii?Q?D8TDFFoN1SrsKIMp0FHVt9zZlHW+AhzPCus1uGTkdwrc+TGX4PdrdqG/XwLH?=
 =?us-ascii?Q?KoerjO5DEfNJVC2XvE6Rmu0F8FW6lWSwRnLRzDaJWuy3jI0ia6NXYH5+k7Kr?=
 =?us-ascii?Q?mc/uLERUAf+G4Nldyux7o21ELPipFh67VLsNxzdPLlxndgC8v80O+0VGXefb?=
 =?us-ascii?Q?sNHHi4DSILqpdU8DkEajqT+B3KGSELtRqjVWaim5n7R3eI5n77yDjAG6+FnP?=
 =?us-ascii?Q?nm9Uu5YCeUMpMMPrtNAbOxDzbOHKthyjJkuX53amVVRqJBXy/5Vk5MAht3Ok?=
 =?us-ascii?Q?nJGTW2ZJ5apQkuhNqqv6JZYG1MRF40s4FA/GUGKKe4xAKXproWbalhybZsIr?=
 =?us-ascii?Q?a0w4FluEieLVVt2TZzun3SNFXUCg5JToF5hqMtIJAOa5m+DZZl3IkWjm0KLG?=
 =?us-ascii?Q?3r9ir+a032vEgf1UYg2t0Ozn1QlA+8+0jOVo56lgZlMw0bhwWANM1KZIW+pa?=
 =?us-ascii?Q?AdODIcrBioph51FLfFZt/4BrlyBO/P4C91FYZKrbkKgNzrCb8jSmmbFfVKg+?=
 =?us-ascii?Q?KmzQvQHCrXvELcxpD0ZbgqYA9/aySwG7v99R?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 18:33:44.5892
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bac2e397-d36d-4171-3568-08ddbd84ce14
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6570

Use attack vector controls to determine if ITS mitigation is required.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index c0e23e625b6f..7972c9b16e8a 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1514,13 +1514,17 @@ early_param("indirect_target_selection", its_parse_cmdline);
 
 static void __init its_select_mitigation(void)
 {
-	if (!boot_cpu_has_bug(X86_BUG_ITS) || cpu_mitigations_off()) {
+	if (!boot_cpu_has_bug(X86_BUG_ITS)) {
 		its_mitigation = ITS_MITIGATION_OFF;
 		return;
 	}
 
-	if (its_mitigation == ITS_MITIGATION_AUTO)
-		its_mitigation = ITS_MITIGATION_ALIGNED_THUNKS;
+	if (its_mitigation == ITS_MITIGATION_AUTO) {
+		if (should_mitigate_vuln(X86_BUG_ITS))
+			its_mitigation = ITS_MITIGATION_ALIGNED_THUNKS;
+		else
+			its_mitigation = ITS_MITIGATION_OFF;
+	}
 
 	if (its_mitigation == ITS_MITIGATION_OFF)
 		return;
@@ -1551,12 +1555,13 @@ static void __init its_select_mitigation(void)
 
 static void __init its_update_mitigation(void)
 {
-	if (!boot_cpu_has_bug(X86_BUG_ITS) || cpu_mitigations_off())
+	if (!boot_cpu_has_bug(X86_BUG_ITS))
 		return;
 
 	switch (spectre_v2_enabled) {
 	case SPECTRE_V2_NONE:
-		pr_err("WARNING: Spectre-v2 mitigation is off, disabling ITS\n");
+		if (its_mitigation != ITS_MITIGATION_OFF)
+			pr_err("WARNING: Spectre-v2 mitigation is off, disabling ITS\n");
 		its_mitigation = ITS_MITIGATION_OFF;
 		break;
 	case SPECTRE_V2_RETPOLINE:
-- 
2.34.1


