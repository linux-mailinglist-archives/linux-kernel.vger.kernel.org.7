Return-Path: <linux-kernel+bounces-720374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2EAEAFBAC5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 20:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2191A1AA7D2D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 18:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C1826E15F;
	Mon,  7 Jul 2025 18:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xyEsz196"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D370E26B765
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 18:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751913232; cv=fail; b=DatVuzoxyXvg93lWgVLFmxGHZBSrMqpR1k8Qzn65Fn3WaSfHXrWIsG1ZGThmnIOxUgCFjM64y8Sey0FfuplaCvbhjGnVoyA8hN0IfPZaXi7wfITtMJfp1mVLmkmrKw6c7VUsk/z1xnwef5/gT3ZicDZtigVa/3cYuJLHdGm68V0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751913232; c=relaxed/simple;
	bh=CmaRJ46vRjjv8/cquhIry2PyYxlQizg0pGjjwabSe18=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ffy0jjrokoD3KUjg53YaOtw7n5y+hpBcWVZ3icZWfuBkRykc48aefG+nxuTzd1gGC8UcagJ4r2nP8XawedOIhJh7dkuNMUo6yBLKzgUL4QZzm0VkQGKpYLEMiqCVgcoz4Y+lfVO3+nyjRiGve6z09pazBmZLCgFWLQnnKEqxu0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xyEsz196; arc=fail smtp.client-ip=40.107.223.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oCN9Jivmn0Rz8qVnYiv+g6zv6btVwpd7eXg8QvbZnKY+gDJQw64kJOt+4qn33CX9GQC/gDak8ymt4mKiIOJauGayyObPuWB25h9McIfD6G1qG14pqPDeOgf2LsMdOzkZHeDs3rgMqnoZ3k7bkBIWcGwfzJvZuolvxrbkTSu0FIAq8v2QOlxJRCW2zi1I/7blujoDm+LJ6A5PTpRZbFXDFwg0TPhoD0UsbLfyPTcCC7tk8QDhF2DTtADDx3O3zVpKOeT7aqRwDvauw8yGDkMIdp2z2A9lNbPrePsdBmKojcwI5dKDd/6tLiZ9jbmQShClxqtCiKfsFV2wQVSuRYJkcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=APXX1QMgmhLb5zV6BO3BbXFgNojNzHQxEOT84uA8hqQ=;
 b=ZLD88Cr4nMeWnvk6oIGmAI3VcHaToOU2LWoeGdcZMKVyHFo1aQUdZbO7FpCUQs0n7vNUrlZ2bUtOHWFYrgT6+mnM02+qFYvyHZxhKWCIia0+QncFNj9mgabtJnr07dMqb9lVtDHacBxK+Sk52lRNGgidTNMM8lAJg8ElCJAppimjztJtzoKWLSHq8ZsGaz57XgZzCtDQSuJW/haL40vCAcJPMjO4PiLwIDjnUgV5MsMldI4c4tq7nx9dTVbz93ycNJu82lpWaMuc+bQzuRdm1RhE2SF+lB7xLm4eo80tP/7nKB6IytGs5/vO8uusROWgfG8SVO2Y4h4k6dQct8YECw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=APXX1QMgmhLb5zV6BO3BbXFgNojNzHQxEOT84uA8hqQ=;
 b=xyEsz196fOfXtpVS08qeupnVG0S7/7QwMMOldOeY3SxRoVpAe4JdD4nr53Mon0nmyxYh+Vo7weykn2BiwbwvrxtWVuVPwC7fikiE6ahvpwTaFE/jVWzcWqReaZWfKV2mLK89HPT3oKjY/FoGNmaTf2gMBQZteoi4eA+wvk9L+lM=
Received: from MW4PR04CA0263.namprd04.prod.outlook.com (2603:10b6:303:88::28)
 by BY5PR12MB4243.namprd12.prod.outlook.com (2603:10b6:a03:20f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Mon, 7 Jul
 2025 18:33:45 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:303:88:cafe::3a) by MW4PR04CA0263.outlook.office365.com
 (2603:10b6:303:88::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.26 via Frontend Transport; Mon,
 7 Jul 2025 18:33:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 7 Jul 2025 18:33:45 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Jul
 2025 13:33:41 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 20/21] x86/bugs: Print enabled attack vectors
Date: Mon, 7 Jul 2025 13:33:15 -0500
Message-ID: <20250707183316.1349127-21-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|BY5PR12MB4243:EE_
X-MS-Office365-Filtering-Correlation-Id: de99c7ef-5865-4056-bdc8-08ddbd84ceab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4awD0pFfUuz98JXhV5MQ4UadHNwY710G4r3lVhabevAvDjs13PrD812SnZmX?=
 =?us-ascii?Q?3TYWjWNRuGIsJh86wwrf1k3mbQhu8gcc5+b4RlArkF/xDUwHL20DyTA2lh5c?=
 =?us-ascii?Q?x3O6nfDSiPeds9B3vX8+YopAa4DdI+PouvVjmAEyW7qkZvLXwWAdG+pmqFMV?=
 =?us-ascii?Q?McgcOegx4mspACgIHm0NfnOf9HO/MWTM3GSDBs7ddtXKRQc5DjAXdU9hDzrw?=
 =?us-ascii?Q?ulh9T6ghmgv9J0YMZaWRkzCFC24gnxIo3m/b7mvY9Ba5mjqMOKZdh/b02gNp?=
 =?us-ascii?Q?9pvrHvGA+t/OuNEYubEUQZSukLr8pq6NFsJZCxEbgU5AaWHzFLBO+vBmIoTi?=
 =?us-ascii?Q?sokDGythmMjWwsmcWKHpEIHEMCP/OsygFYQ++3jUFf5nQnwafqVGcEkevzsy?=
 =?us-ascii?Q?pkYxzaVOsdTh9B1P9IfXMyRsAqD1saWjKI6b4tSkVmZUXTOW/BqjvqEFQgaH?=
 =?us-ascii?Q?R73YXZFqJ0Hed8eBAf3ArN0MDNYQOGqG3ZhzPqItlt7ylql8F/IbALx9Dnwn?=
 =?us-ascii?Q?/HpaMrSsbc+bcB9wCXYYYdSzEGZE2uO6HLaWIbGC+++Ty0UxapZlAoI1zlK2?=
 =?us-ascii?Q?5R2lq7whNFuT0yLRpZKzM4uxkVaH4EakG+8iW15ZbuR9d6OsVO+NoGdS4BGn?=
 =?us-ascii?Q?pF+4ZG4RwaXWhY9mSKwbsU0VBoImkwgW8CDxaf4r6qvoy+X/DVV26iWAtrqp?=
 =?us-ascii?Q?8/51F76eatLM/e4VIXwcrStYPKPkcn7nEJGnoycgeTq69wrH88pj3J8BzSNm?=
 =?us-ascii?Q?MT2EaSoawxba95/2jLPS8BG09atO8y+hJhkRNUWUrDWfiOy6hXlWlBQ0f0d6?=
 =?us-ascii?Q?gc8UX5ggVAJM5mlkHqk46oioXqsdZVQ/qcW4fXlaY3FkTrE6t5z/RubodkQY?=
 =?us-ascii?Q?I7LJILbYwebETwY/uFpebnm1EPkwn80IGfOJDDlzOtteFpYQAIWEZdQJ3Fsk?=
 =?us-ascii?Q?SKv8hb2Ef2kHatn3+Vb94mxS2vkPuJfabdKMKLrVLQopmiLWZJKaUoISjTo5?=
 =?us-ascii?Q?XhijoCTjssi1VWPzhD+GEy6PxUs/8l0DULrM4zji3Vsx3jrjOMG/3oPZ35gt?=
 =?us-ascii?Q?77yyqnDT/lXInh3Aa5wZGsiwba2lNnYcGnx9E6Th+JcotxW2s1KnduOwms5j?=
 =?us-ascii?Q?PTiGLFeLDvDLgfU8qjIXwKGXVNANPEAEbP5DW4mMRmWIR2KW3gJRlbi3hCHz?=
 =?us-ascii?Q?tTrN7OFMw+8CUMLotneShFG/RK5ZEE8EdjpXW7LYbhs4xJSkbgdvuVp4CGH+?=
 =?us-ascii?Q?VtbuDpxqxt/G07EFBkYzm+x36IuBCkfOACW5LHYxKvt6TerkrXfIXki3BKmR?=
 =?us-ascii?Q?5zFmBSb3Y/MJURg4G6WoNjzH2USNn0NpWI+SSkcYPWABA7S+/Mljfvb1H8lF?=
 =?us-ascii?Q?jxymu3gQ0Q82wQAB8DR2Nkoa9zudIfqadaXsqyT27t2wRjTV+dAZ4K2OGhOQ?=
 =?us-ascii?Q?fDeX7NXuToDcJS2YeiwQI7huxVe1VDKqGMzkWTYn/QvXJXYqugmmKqR8g74L?=
 =?us-ascii?Q?npLadi+3cjUhh1MfDOdIVYgneFPir4YoENSV?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 18:33:45.5835
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de99c7ef-5865-4056-bdc8-08ddbd84ceab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4243

Print the status of enabled attack vectors and SMT mitigation status in the
boot log for easier reporting and debugging.  This information will also be
available through sysfs.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 7972c9b16e8a..917acf99eb6a 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -187,6 +187,39 @@ DEFINE_STATIC_KEY_FALSE(switch_mm_cond_l1d_flush);
 DEFINE_STATIC_KEY_FALSE(cpu_buf_vm_clear);
 EXPORT_SYMBOL_GPL(cpu_buf_vm_clear);
 
+#undef pr_fmt
+#define pr_fmt(fmt)	"mitigations: " fmt
+
+static void __init cpu_print_attack_vectors(void)
+{
+	pr_info("Enabled attack vectors: ");
+
+	if (cpu_attack_vector_mitigated(CPU_MITIGATE_USER_KERNEL))
+		pr_cont("user_kernel, ");
+
+	if (cpu_attack_vector_mitigated(CPU_MITIGATE_USER_USER))
+		pr_cont("user_user, ");
+
+	if (cpu_attack_vector_mitigated(CPU_MITIGATE_GUEST_HOST))
+		pr_cont("guest_host, ");
+
+	if (cpu_attack_vector_mitigated(CPU_MITIGATE_GUEST_GUEST))
+		pr_cont("guest_guest, ");
+
+	pr_cont("SMT mitigations: ");
+
+	switch (smt_mitigations) {
+	case SMT_MITIGATIONS_OFF:
+		pr_cont("off\n");
+		break;
+	case SMT_MITIGATIONS_AUTO:
+		pr_cont("auto\n");
+		break;
+	case SMT_MITIGATIONS_ON:
+		pr_cont("on\n");
+	}
+}
+
 void __init cpu_select_mitigations(void)
 {
 	/*
@@ -207,6 +240,8 @@ void __init cpu_select_mitigations(void)
 
 	x86_arch_cap_msr = x86_read_arch_cap_msr();
 
+	cpu_print_attack_vectors();
+
 	/* Select the proper CPU mitigations before patching alternatives: */
 	spectre_v1_select_mitigation();
 	spectre_v2_select_mitigation();
-- 
2.34.1


