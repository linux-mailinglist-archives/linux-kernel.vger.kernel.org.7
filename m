Return-Path: <linux-kernel+bounces-720369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF24AFBAC0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 20:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 079404A2F20
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 18:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3EB267B19;
	Mon,  7 Jul 2025 18:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="k3v2wmnU"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2076.outbound.protection.outlook.com [40.107.96.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D6C264616
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 18:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751913228; cv=fail; b=KCYdt9sqUts6H2opj0FFja5qtEL26v02hTyGGmO1KlwOuOKFBXLaZHH6rE9vX/RZOZkX85RoTp5l7GFjgES5jKZK8Gy4Zlkuvoh9YXabbuwoYdCKaYHdPZ1ro+q6r0iWaEY/2ULPqxXrwhNi6aQCMKqpsS4f/P337+uFSvO72j8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751913228; c=relaxed/simple;
	bh=mG9YnBF9wBQKlsbr5eIIUHsqI22YsmFSW8sfDm+kuow=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gV2rhF1cZQg1DYRcvaSCPx2KmHoqtE1REo5+7nBe/sq+m42FMm3PTQpnNlVz2Tq01z0VlLhTn8GU7eWztaVa8Yc1eiuHL4V7M6jJyNxwmqU1xpG4XhhTpdPNrCLiCNDPdtTG/kkK6Dy4BeEtr0GbtgqXB6o9SwmYDFIXGuHdjDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=k3v2wmnU; arc=fail smtp.client-ip=40.107.96.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vws+4IrZshabqy5+LbMD/H+46ku+GneII6rRlpsavz0xPpbwXxdAneF3P8798vAd8MATk063yfuCawSn1lcu2Ax6I8lYEYTK92zVSzCl11hwvS//TsOfGhXp2gwqvoWdTqsiUjkoSzggq6125/Pw6rp/qP+5IWc7Xo1nhBsVCnCcR/eck+bCM5RT+wiAs/nL/K7jCMzJCx2HhG4PgJdRwqK7IxaWz4xPcL8NpH6Y66ScQTgBaJC6XduqIE3/wv9zKmKMoCVudHYJgKNMonKdvxpbwtGWtCxDw8ca+FMl2rGOWSjQaJiLd27X+rRIK89wozGO+35GyUoZiRiniNnFlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1JQlUFi4lWs/7Glche15I/siff0jyGit3lRFqAg8J0A=;
 b=M2ua7nuyQeSasSGCpwzvm1mhUMEPkcCD+5am/F3qNF1wdEu9vQsbCaxtvX+tCD9u4jFAqs2hKrO51+rLdtGs4TeZr8EPyx6nkwurV/fFfuCVUaZmovSaQI9VWuk0GIrZiXiq7pHWmVIZVcNIC1cqSA54w2X6d/wPjvCzvdJPwbxVeEn6ov9/2+JhRrfvOUPWmARrfnIGIj66bP6RdLsPB1FlynWGlQhUrOq456wuADG8XnJJnf0+NUYiLOIEFEeoqNvB/r30kwphYIzg47ILYPVHJDkAG3zbcYNADzeYRfAWFMEYjJ2fkiU77EUdkygW7FY/6V+61OzmvcADLchk7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1JQlUFi4lWs/7Glche15I/siff0jyGit3lRFqAg8J0A=;
 b=k3v2wmnUaFVwgbJUtiIdmMDzVAzIHSy7F3BkmNtrHhgrZuq9IVgF1wlPKl2PTqGqM7A4FrwDg6JThDq4tvXWExs5A3pJ6zo1eDHfR8YLAWwyvXnnhEex6VlVylEbp5oFN3Ux7rT/xDIQNTnwWXyisJyzt6HueCB+LsYn+ALnA3o=
Received: from MW4PR04CA0246.namprd04.prod.outlook.com (2603:10b6:303:88::11)
 by MN0PR12MB5740.namprd12.prod.outlook.com (2603:10b6:208:373::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Mon, 7 Jul
 2025 18:33:42 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:303:88:cafe::f6) by MW4PR04CA0246.outlook.office365.com
 (2603:10b6:303:88::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.26 via Frontend Transport; Mon,
 7 Jul 2025 18:33:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 7 Jul 2025 18:33:41 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Jul
 2025 13:33:37 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 14/21] x86/bugs: Add attack vector controls for BHI
Date: Mon, 7 Jul 2025 13:33:09 -0500
Message-ID: <20250707183316.1349127-15-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|MN0PR12MB5740:EE_
X-MS-Office365-Filtering-Correlation-Id: 82e0203d-c88a-43c6-cb89-08ddbd84cc4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cSd9CpLXUOJHxVDqun394cLz2sA3/knd2dQPHN4l+gzQIAi5BHGX0aVOZ+mh?=
 =?us-ascii?Q?B0ldvN73N1Y2apOgGZ9JmkSBvmJBaNnvyIv0GCkpbRSnemOIY9RdDHPYXZJ8?=
 =?us-ascii?Q?xVwpmvriOGCXMibpzlD7hQzW/nJgBnDzH1zoChqOEPmcbVxL9ZY6wphyT7Kp?=
 =?us-ascii?Q?iGAV4FsRbkStHwvx0z+WuSMaBrb8+DA4OivbXZi4331DY9R4xgYvM4bbArj8?=
 =?us-ascii?Q?lpcvU8ldFYrNbMPW+T4X7G89M7u59oWC90wboIK9pEA52hQ/W7EHIBk0dxtq?=
 =?us-ascii?Q?mC7Kilrv+r/ssFDHQVp8/wGmkNsX72PkC+zToLg8AWU/OnYdcdA4DHXwWuI3?=
 =?us-ascii?Q?UU7+XqeMWlfpoztn4pnOQgCpSfGO93VcmABkFpKmC9UjdTrjAk353ozAvcdI?=
 =?us-ascii?Q?TwfiAobpRGGVHnWTpMKGSrQh128IAgXuLAYe2MAdfQtB5hFsHhJrC6FmXPcu?=
 =?us-ascii?Q?xLx02RMCFRQ6AMtxP7lMRu/eGnlS26tkKcPM34o1laSTxElzWT7LGt2USdOq?=
 =?us-ascii?Q?2eWwNlKgCvdYhvUjlIIMlWobWXeRli0HaA/eYQ2Pc8kZMWmeNnuafWEb0vUJ?=
 =?us-ascii?Q?QUJIzuz6M+39wXoLXi8yAz8bUxN0eQUPLvJr9a/q/z/Rin09Zl3ILOibPA1p?=
 =?us-ascii?Q?1Rb2wVCD0E5rhy2KdgJeyJa4sQ0Hk2vpKzRRDz1oFQswt/ZySazjcnZgvDen?=
 =?us-ascii?Q?7QR/oKkm0Nlv1+W7QX+2b/DJB54s0JYWMFW8MvlwJzDCCzaZDqPo53voeS9u?=
 =?us-ascii?Q?6+V3e8Jiwm5K1PRwaAN6jiU0TILYoAnjn/F5owiwnDtErI4Vo18rzJsTTTqH?=
 =?us-ascii?Q?RJ+b9FpRhscx5fmnxBIEM6CyGu7RmTKyASu0WWRFac+8tuA2JKZsxeW3aolZ?=
 =?us-ascii?Q?i0M3MFmHIa5bTOzPJca2j0skOjU9jxGSuII9bnAjCbIXsiGN+IVGf58oWJzj?=
 =?us-ascii?Q?W/6XEXOoSCe/ev1VqFcsnPjPOwgY92k1zf+6KGnpuAtir8Mv7cMSBM545zzE?=
 =?us-ascii?Q?0NEht7/1SrtwKFps4V8tqANObYcjBaRdAusAz1jGl3y14xqWQQ/+VOROdPBm?=
 =?us-ascii?Q?AueKT3wJU9kQ/Ck7kDbl5f09xxGDsvtd8CaTIGjghavNinsU3dSa5l5TVdxK?=
 =?us-ascii?Q?5/1qJ8Tmh60A4OIe25KqRkN8D/Aht/zF5R4Zttx1UKYGUq6Ulfiz+suOhihU?=
 =?us-ascii?Q?JxrKQT5MYwMdW2+eutuaq0TsxkPFscVQQnZlcr9awz5dfQ2hECUgw1iK2T6/?=
 =?us-ascii?Q?Ts20V97IGiItz+B3tCSyMO9usyK+SYsuOcOpBmUgn4nJbG06WwcuceQRm+Cb?=
 =?us-ascii?Q?PIUYlDRgJFDJDQv2O5oOFQRKcxdPjiSlDkZ1Ds3gWniKmqnK/tk5TqrNUvXA?=
 =?us-ascii?Q?naPU217umchQ7H9lE0UowFcmhO+XW9pOqi16Mxl6Qki9nxrBCRQ+YHYwhYu1?=
 =?us-ascii?Q?VMnt2dLkL/lYEm1tIx07CJQArPgbzbLUyJMTbb3iAawNS7itYJ5rMrOvREG9?=
 =?us-ascii?Q?SkDHyGlcAbLQ2a/pEpCNvQgliQ5Nlqza5o77?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 18:33:41.5992
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82e0203d-c88a-43c6-cb89-08ddbd84cc4b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5740

Use attack vector controls to determine if BHI mitigation is required.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index f331cd70b0b4..adc563443c9d 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2125,11 +2125,20 @@ early_param("spectre_bhi", spectre_bhi_parse_cmdline);
 
 static void __init bhi_select_mitigation(void)
 {
-	if (!boot_cpu_has(X86_BUG_BHI) || cpu_mitigations_off())
+	if (!boot_cpu_has(X86_BUG_BHI))
 		bhi_mitigation = BHI_MITIGATION_OFF;
 
-	if (bhi_mitigation == BHI_MITIGATION_AUTO)
-		bhi_mitigation = BHI_MITIGATION_ON;
+	if (bhi_mitigation != BHI_MITIGATION_AUTO)
+		return;
+
+	if (cpu_attack_vector_mitigated(CPU_MITIGATE_GUEST_HOST)) {
+		if (cpu_attack_vector_mitigated(CPU_MITIGATE_USER_KERNEL))
+			bhi_mitigation = BHI_MITIGATION_ON;
+		else
+			bhi_mitigation = BHI_MITIGATION_VMEXIT_ONLY;
+	} else {
+		bhi_mitigation = BHI_MITIGATION_OFF;
+	}
 }
 
 static void __init bhi_update_mitigation(void)
-- 
2.34.1


