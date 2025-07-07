Return-Path: <linux-kernel+bounces-720370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE42EAFBAC1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 20:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0FE31AA357B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 18:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B43226B770;
	Mon,  7 Jul 2025 18:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="p1Jn52xe"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86EF26B2BE
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 18:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751913229; cv=fail; b=pvGclyoRQcBAqusTgudzU17+GGExBvl9KPDXDyru3gp7gIx4/OsffxxBU+46hqo9tmrnykCZVdwMQeCraSU26LSxHhm7EkAeyGbGKVyhJTwJxt9ODT6yqTUVGz2ZfIfN5EeT6W84riQZJO6ng/3asOaDECAC62nJD4Pwyr91ARk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751913229; c=relaxed/simple;
	bh=qA/O+SEyqTU3uZiSvZ/nV2fCKX1gY5CV6Gz/+ayxy0U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fU4fpvbb29uKvtnJLbyDxzBDyO5jhwyvfIEUMnq7C1MDUPh2vc5HP8KVBElFMb+Arvp0F3Fzi3EKuESpJMVcurnBb4/WlNDvD73g+ZBMggQk+Y3V6LLEoCnt7cfw28sb142G4JqOhvYDCYsUSXAXMs1XSxvMk7saPCUl9Ljod9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=p1Jn52xe; arc=fail smtp.client-ip=40.107.92.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EKHNH8vKezwvafT7d6vQPR+wAb4RfLuRSPxUYMOPrRTYdcq9qaMCSyGH9a8nS//a0KlhFClDkQDs1UYkYRk+/QoZgu18GK3Z2Evn3kvXla2TAzGwn0XPqGMjptgkWeSN+NoL6CRozzwdy2kndLXqGLSD7JmatbYDw7cIzHopp/u0eXgWfZSRGHVzmf34S1uydkMEiNgVAKYqnhqvzvaOd+BPUAcMxVsrTe4zCukcd3xaaYrAoXrUZ6KJeGgPvhGn5eI5UHlU9/neXXzrnHriHVhZ/+bmOiZJ5hWGldxCx3pocctPsjJ7S8NVYSws7E+wj8CMfp51+h/jUjlFRJLcGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ya0SwZG/OwM+u4A6if5pHJd43eCTzD7yYugGz8cLw3w=;
 b=D8hNE/7uBMwpqm2OowPhY1KRxT789CnzdUrHIuN+tiextFr4USfBw+9Ulu5sxS7MWMiGiWrjY6SqoQFkTc7EU9euRNMZV8ENmHtId3TVuZlF25l9u1+fUtki3IFl/B6c1zSlwtTd1zEPCD0+LsSz/RkI+gXzssi7InuixpTCBMGFGBPTjzFrZP6sA+YPMnehvXXLDEb+MU9fqsZj+Q2qPMLOu31uqmLxMBbAgxGf/g/35yKGfnV2L1Wzuw0EwazZAW98WP4aHVDIqMmesz3FG7tiOA5hvxQeKrUIA4nub4QMlLtlVXvl/+1v4nYM/uyiXSeiBJlzUh6X6HM4neVnoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ya0SwZG/OwM+u4A6if5pHJd43eCTzD7yYugGz8cLw3w=;
 b=p1Jn52xehrHKT6Ka3cU4cN0O++LvCr+rc9X2rVLcraoIlDC09xZHD27bhGlmgY2Dgx9ezL4mWDh4gef/qn62T1RRps6zOlsCYPocb3fGMkgiidgIjFnWfJhK/qnxnKOq2qy8EPN9P4jcdQFwX8RoIvj6eFwC9rLRJOCGY5OBvSA=
Received: from BY5PR16CA0025.namprd16.prod.outlook.com (2603:10b6:a03:1a0::38)
 by SJ0PR12MB6733.namprd12.prod.outlook.com (2603:10b6:a03:477::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Mon, 7 Jul
 2025 18:33:44 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::b0) by BY5PR16CA0025.outlook.office365.com
 (2603:10b6:a03:1a0::38) with Microsoft SMTP Server (version=TLS1_3,
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
 15.20.8901.20 via Frontend Transport; Mon, 7 Jul 2025 18:33:43 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Jul
 2025 13:33:39 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 17/21] x86/bugs: Add attack vector controls for SRSO
Date: Mon, 7 Jul 2025 13:33:12 -0500
Message-ID: <20250707183316.1349127-18-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|SJ0PR12MB6733:EE_
X-MS-Office365-Filtering-Correlation-Id: b2ebacea-3fa6-4528-54bd-08ddbd84cdb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H+ibLuQMK1FZeeZm/OoPnQZtzTCRaP3Of+cstswp2HC7Gx1ljdAUr8V0YW61?=
 =?us-ascii?Q?w3iWHcCVRbsb1hhM/n2S2RfIXcvrYLK4nDeSOtkhCzEgkpb6gnj2/TEtRVQD?=
 =?us-ascii?Q?Ist72Is1kftPybC4jOvil7gtpNdqE5OXewON+eXOYhNyvR4tq3SSRUHsZMR3?=
 =?us-ascii?Q?lI0VDEw7EYw+O0BWELFCYDKYt3TifHk8S89AxBobu1NiyAkmZ4+6Wtmz6Cgi?=
 =?us-ascii?Q?zG9hIgRQhO7lv47hMroZR/mCbM+67je8P0KJ4XTPya51zM9FEX863cBXmm0k?=
 =?us-ascii?Q?X2MnhhU7/RewJn35vMhwoDFJcwPJgHZ9eY6jdIPQHlIrciKAJ950JlfnlP2Y?=
 =?us-ascii?Q?iRiuFdxTsks34yfRj7IkRed7k6iX1Xec+bCzEasVajK42/3fMpJ7/WFS7Bss?=
 =?us-ascii?Q?v4bcy0PBKAqcHV4CU4YEzocJ4kf0/SWTwrlf7zjk9zO67Wq3H6ejUeAbTKew?=
 =?us-ascii?Q?IzXa3Yj3jNw4oT8e4GW3kFpUADyK3GW6v4jDaC1EokRekQ/zEVMa151BDsnu?=
 =?us-ascii?Q?CfqUDd74mLhebX448ffafdDkl7gVx/qzZOhXfnAlIqt/CuUtkLnCYf7yviPC?=
 =?us-ascii?Q?zRMsVMSVasmxMhQVxO+eqvBRIVGkJYoT5Fz3gDSKCA7WqNrGYuOpnV1fFCcJ?=
 =?us-ascii?Q?wtfth9XA0Q3jysuliAyjLEy5dOmtbtjpJ0jXN6wCo156rzuNPk0o90Aa3iDD?=
 =?us-ascii?Q?DU87RZejLYdKqLJpPjevPuK0sbTEeaJIkxyHiJqtwltwVDSnqXAzxnUTHKdy?=
 =?us-ascii?Q?rmjcpBi1ZDJmojbsBAFOYhPGigiGeHg5MGeJPb7OddePk+E9AQnfdleGCFGD?=
 =?us-ascii?Q?B5bNfJ/AggMZ36slH6gPsCBNm+B0avfHGeH2v/PzSaeMbaJ6X7zbYyWCOKZC?=
 =?us-ascii?Q?pwBQNTcFzNuP0fVThEGooDTBjXlVSFKFC1SF78rauOhyIjsuNP8HUcJC7m6+?=
 =?us-ascii?Q?IbZ+TmzmrOo0BFRM075J4UYKZcVCvaCl2KgYZnXFok/wcbhLobzuN7hxyMrh?=
 =?us-ascii?Q?pSgifnwn7W3KjH/GVTUVkFoya1tVpu8tk3NFHZT3MBM3Mi1aPFx1fsOOJhLB?=
 =?us-ascii?Q?UTQn++Dg093b5kWFyLMC7ORZTQq5NyUST/xeci6ulpLv458avvIJOatOCQeA?=
 =?us-ascii?Q?yjFpmEVRj1f4q1IwTyNq63XXj+Z+3ABckkayzTM/ZeZAJTp9SCJch8+zvaLK?=
 =?us-ascii?Q?E6Q3Rd3PCgi7tbeaVyu+nns8XvjJEpTZOLC/+tDjQNvH8hB6Qwwj29cKkbwn?=
 =?us-ascii?Q?HyMcUEhf4YTCxKowER3j2Xmhgjl0SrVftIl0TkBNDrJcZndUI7NpLuaaHcPG?=
 =?us-ascii?Q?Q2Vtam5PpWm7nl57qsEBURNMr97QBa1woHIFapNx2w4EeUdXCMxgOH2kRygx?=
 =?us-ascii?Q?bmzJG2DJrX6r2FkFr6WSi99JXN91FlkwjTLinMs4UTMNQ4JDXrcueXtoVt5R?=
 =?us-ascii?Q?z47rrx1DOsNocSeupWszWZGseaNx0yKOKQTCCfiXDIteQWc7IlISZ+izRPvE?=
 =?us-ascii?Q?81SyURAvaF8gjj6UL8yfeLU4mhJxpJxh8aVI?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 18:33:43.9405
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2ebacea-3fa6-4528-54bd-08ddbd84cdb1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6733

Use attack vector controls to determine if SRSO mitigation is required.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index ecfd7d728ac5..c0e23e625b6f 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -3012,14 +3012,19 @@ early_param("spec_rstack_overflow", srso_parse_cmdline);
 
 static void __init srso_select_mitigation(void)
 {
-	if (!boot_cpu_has_bug(X86_BUG_SRSO) || cpu_mitigations_off())
+	if (!boot_cpu_has_bug(X86_BUG_SRSO)) {
 		srso_mitigation = SRSO_MITIGATION_NONE;
-
-	if (srso_mitigation == SRSO_MITIGATION_NONE)
 		return;
+	}
 
-	if (srso_mitigation == SRSO_MITIGATION_AUTO)
-		srso_mitigation = SRSO_MITIGATION_SAFE_RET;
+	if (srso_mitigation == SRSO_MITIGATION_AUTO) {
+		if (should_mitigate_vuln(X86_BUG_SRSO)) {
+			srso_mitigation = SRSO_MITIGATION_SAFE_RET;
+		} else {
+			srso_mitigation = SRSO_MITIGATION_NONE;
+			return;
+		}
+	}
 
 	/* Zen1/2 with SMT off aren't vulnerable to SRSO. */
 	if (boot_cpu_data.x86 < 0x19 && !cpu_smt_possible()) {
-- 
2.34.1


