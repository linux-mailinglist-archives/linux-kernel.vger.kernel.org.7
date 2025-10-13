Return-Path: <linux-kernel+bounces-850757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D045BD3A3E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5882189F2FC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4744330F801;
	Mon, 13 Oct 2025 14:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wgl71tlf"
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010039.outbound.protection.outlook.com [40.93.198.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FF630EF81
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366187; cv=fail; b=EzK6ZIMia9pMj412PGT3LCz83m9bt53d5OtuVcCuVKpjP/aYKeChTiFJvBtL8V3y5pYmN6vOTclo7JJnXIin0QUBm7Iv3nNF7qB/6TnvU3kVFol2Vs5N5xMEfFtbUSECk2oFUESlsQb+9y40TZaCMfAXYlgaK7CJ2vSckM3iSh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366187; c=relaxed/simple;
	bh=ZItGOC+JmmgPLYYN3t8qhXMMknKhd3ursZn9pLt8/6Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k8bAALBCONu/8/Ps4y/00ZLvp0/Gxvs9/y46A+zxN9VCLgsJKRKOw7I2tliwHe6S9Um8WV3xTXWMG/WgpTtiF2sqQYv7+RecFDb7m8p0tVPn766hF6pLn9imiCBVB/EwUt21pErcfe9GSvgg6yiujTypBTvoBtHI9FQKDeAxDk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wgl71tlf; arc=fail smtp.client-ip=40.93.198.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pJoPKhzXVUVyVpwHRNsKdKTTFbOv+pA7XRN0Ne9YsOS90nGV9aPbUVmPItOdeC9+vuue00144Y0Zt2DvidQoYUqb2bOBnoJYjj+6+xZplZgT8Vkgt3WErWUs6cA6gscuKz8376OAJJZa9Fa0U641w/mO7wtxo0avsuAisngz6I0k88uXA8ZLbJR3zWO0ZQhMpXRi2OwfN/B1QvPGCjocK9x0bO2mtrSebKn6CeTkNqlYi/bg/GNmp+Q62fL5xqpFHexA4x4kmgYuZQArR8G3+pzqhrtEm4coOK9+Jqiz1wp0xvLU7mqXWJQHq6eiT8vqos/f0m6foC591i4wt3niCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uKzjhwLWqYd1+ZZVw8t32y5b+d5dPjGF1pxOpwzThyw=;
 b=k+31ArMLLoqY8kjYHQPLv2u/qvrDEwmCEA68UDQXFp7abPlHSSPEOgAI1cJ7GG8gA2iOBm2WbTNuHRpaxwQVFgHMa3K6h2t+9Mu3XSi+XglJl3H9ur/IfkMhmj1sdzhKnWuGKyZJFOErhA50L2blR4gunuZ1fT8sM/6kqYtYU4i11CRjUFsUc35Cm1o4XO8+tjw5mdAsVNVdIxwBir0CkzoG2zeq8JNHcq8/Nj95//ZhVo0HacnQkEhJ4F/LO0jlBG1xzssnFNHQP/DN9Ly5KR+R/6TxOfOuJdfM6dWOaIloxoA5Pm2VcubTxpLGgiHQxjDZi06+tsj7Fiw6wzRA2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uKzjhwLWqYd1+ZZVw8t32y5b+d5dPjGF1pxOpwzThyw=;
 b=wgl71tlfTZ67NG1oJ5Me2djDYaOeTBwuXG0MCHllIgOiF/U8UtnfKRbkdff6c42AHKUVSsWUhk2jTjhtL+G9Cs4zjNumnskhqHFFWQGylt0ap+GmauchrlokcE8zbpzfXoCmHO4aNRG38pkICiYPyxrwjnAI4rePF2JC/9eqeQ8=
Received: from BYAPR07CA0044.namprd07.prod.outlook.com (2603:10b6:a03:60::21)
 by DS7PR12MB6024.namprd12.prod.outlook.com (2603:10b6:8:84::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 14:36:21 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:a03:60:cafe::3c) by BYAPR07CA0044.outlook.office365.com
 (2603:10b6:a03:60::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.12 via Frontend Transport; Mon,
 13 Oct 2025 14:36:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Mon, 13 Oct 2025 14:36:20 +0000
Received: from tiny.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Oct
 2025 07:35:53 -0700
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: Alexander Graf <graf@amazon.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 48/56] x86/bugs: Move code for updating speculation MSRs
Date: Mon, 13 Oct 2025 09:34:36 -0500
Message-ID: <20251013143444.3999-49-david.kaplan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251013143444.3999-1-david.kaplan@amd.com>
References: <20251013143444.3999-1-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|DS7PR12MB6024:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ea38052-f5dd-488e-9739-08de0a65e094
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bG7NKOnjs8W6111+IsnsB8tC9i/+lELia4iAP+ek+oIKDWz37z6gif49DmmA?=
 =?us-ascii?Q?xjN7qzXyH9pt7PmJAB84fSYo0glLPDj06BWek+S12sf1rn1MS1vwBEKa6zSJ?=
 =?us-ascii?Q?YVPMISYDqO7xT4DfzmImmNh4rDG0/gdB6YKre0PtgCkRGwVn1G9/keqJpOCe?=
 =?us-ascii?Q?5peKqGe07JDKOx01hB/wjQpl5evDY5xFbUD1LmkFJH1rM8clipj0efubmdAm?=
 =?us-ascii?Q?Mj0FALxSxR5LA6eLtqS3Yv3wb80Dxwhei8NJtiba3MIgNzKOQzKvWf7atfzJ?=
 =?us-ascii?Q?uNfaCgusFnVWFR275ADwrKorcHmNO3gbp/EpnRoA7aMKhzbHv8fxiZxIV9on?=
 =?us-ascii?Q?IOATiRY7qcdQtc9xYRFaVtheE9m6Zd8aNUU56UyIxwjneqYVYvKkt6M1Xocl?=
 =?us-ascii?Q?phHEqtLhCeyQUhJ4mIYpDRgDKq5c/av5f55yFwkSq+rbby72Cl+BpAyQcAYt?=
 =?us-ascii?Q?sZhommIvK+38ZG6CaI+funKVTalM1fb+lGDUgFJMujUtMHQ3xtun0mcxRydp?=
 =?us-ascii?Q?+G8fsvwDFpEl/eUsrCFkrGdbYlzjxZl2ExzNw5IB8neuoxN+OjYcgAz5MA+U?=
 =?us-ascii?Q?J3C6WdjHv6GBl8bk2wKkI203zNYt49aupkaWl+Aj1+9dfNtDEBPitFUgdvvh?=
 =?us-ascii?Q?uJvrv2FeyeOPAVXP1Ygf+zCMOafnRnmvmuuf0JRKWWaM1jPOGS/RSUSgntlm?=
 =?us-ascii?Q?SjnVbwgRwmBBfG1wK6gVTxTPILOEARqqIFz7DO2PKlonLprpU30n12My1Jw8?=
 =?us-ascii?Q?67SMfkvIRBh0XQMPN9QmvT0oDquNpsK+Z2CcGSvQKyYxxfzULOqCZmSbVv/O?=
 =?us-ascii?Q?xml2ku3B9jyrmzEhKAif9g332LxHPvCVTsJpr8q2GrImb1ELmWu1dTflmoPn?=
 =?us-ascii?Q?iQ6BvsruVgf1hYkRuQ202DiMiaGpm239fH07YKtO0mhEIG43IrD+SUKxzOXr?=
 =?us-ascii?Q?+CpIuVumsCRJoKX3wN0EuVmsmAaH8aMujOB9lVqSWI8iQ7Rc1el9hn7c7vKa?=
 =?us-ascii?Q?6D1iqxVU5trMTNwELtdAT1PpE0vPLo+aftHR8iypcfQQzlwmPNdN6eHD2MeJ?=
 =?us-ascii?Q?5uv2XcudKNXhIv6FeVS3hm+pgb6uTCwLxSScmBGJcvuNMTO3gHjJv4dE3BC1?=
 =?us-ascii?Q?rUnALymGZRQEFW7x3n79v2DldpDO/+FwFPCCHrktQzsw61cbXTHbHgkNF0gx?=
 =?us-ascii?Q?bxVo+dF3ORdMJflN7LQ7D6ZNsLVL0pvUo3wwDUS2bB462wjcsuI3cVJgaS0u?=
 =?us-ascii?Q?OYx8cwTUEZp6zLUrDoTqR2UybtfsBIfbIOWufCACAVgMaFjb7djXwIzNSAcN?=
 =?us-ascii?Q?frIJTskPQBl9VkY/wnqDzVtBN1rcDNho4lKRvHUfcZCz7v4o0lINNqZBzkzS?=
 =?us-ascii?Q?GM+gk1cQPy7E3bG6acyYSCt4pUnZF1ZeNUogpoPyr8lqx9G67gGDp0nWDugp?=
 =?us-ascii?Q?vxz1cWWVVSheL7OhPyDRnwe5fDi1MZ4UOOPL/N2KnSVtk80hRcZSVum/cfO6?=
 =?us-ascii?Q?bcKwm9ds8mpFss40X5diAYwUsF0TrOxMep/KlXs0CGIvzXc00Bbm83Nk2UaF?=
 =?us-ascii?Q?qv5AwVCfx0+Nx3okdfw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 14:36:20.7592
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ea38052-f5dd-488e-9739-08de0a65e094
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6024

Move the code for updating speculation related MSRs to bugs.c.  Besides
belonging more naturally there, this allows for making the 3 functions it
calls static.  Also this prepares the code for when re-patching will also
need to call this same routine.

No functional change.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/include/asm/bugs.h  |  1 +
 arch/x86/kernel/cpu/bugs.c   | 14 +++++++++++---
 arch/x86/kernel/cpu/common.c |  6 +-----
 arch/x86/kernel/cpu/cpu.h    |  4 ----
 4 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/bugs.h b/arch/x86/include/asm/bugs.h
index e43b9412645e..2e1a7d282e51 100644
--- a/arch/x86/include/asm/bugs.h
+++ b/arch/x86/include/asm/bugs.h
@@ -12,5 +12,6 @@ static inline int ppro_with_ram_bug(void) { return 0; }
 
 extern void cpu_bugs_smt_update(void);
 void arch_cpu_reset_mitigations(void);
+void cpu_bugs_update_speculation_msrs(void);
 
 #endif /* _ASM_X86_BUGS_H */
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 06061bcb08b8..2f82261d033d 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -925,7 +925,7 @@ static const char * const srbds_strings[] = {
 
 static bool srbds_off;
 
-void update_srbds_msr(void)
+static void update_srbds_msr(void)
 {
 	u64 mcu_ctrl;
 
@@ -1085,7 +1085,7 @@ bool gds_ucode_mitigated(void)
 }
 EXPORT_SYMBOL_GPL(gds_ucode_mitigated);
 
-void update_gds_msr(void)
+static void update_gds_msr(void)
 {
 	u64 mcu_ctrl_after;
 	u64 mcu_ctrl;
@@ -3014,7 +3014,7 @@ int arch_prctl_spec_ctrl_get(struct task_struct *task, unsigned long which)
 	}
 }
 
-void x86_spec_ctrl_setup_ap(void)
+static void x86_spec_ctrl_setup_ap(void)
 {
 	if (boot_cpu_has(X86_FEATURE_MSR_SPEC_CTRL))
 		update_spec_ctrl(x86_spec_ctrl_base);
@@ -4010,3 +4010,11 @@ void arch_cpu_reset_mitigations(void)
 	vmscape_reset_mitigation();
 }
 #endif
+
+void cpu_bugs_update_speculation_msrs(void)
+{
+	x86_spec_ctrl_setup_ap();
+	update_srbds_msr();
+	if (boot_cpu_has_bug(X86_BUG_GDS))
+		update_gds_msr();
+}
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index c7d3512914ca..c37ff92aaec2 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2138,11 +2138,7 @@ void identify_secondary_cpu(unsigned int cpu)
 #ifdef CONFIG_X86_32
 	enable_sep_cpu();
 #endif
-	x86_spec_ctrl_setup_ap();
-	update_srbds_msr();
-	if (boot_cpu_has_bug(X86_BUG_GDS))
-		update_gds_msr();
-
+	cpu_bugs_update_speculation_msrs();
 	tsx_ap_init();
 	c->initialized = true;
 }
diff --git a/arch/x86/kernel/cpu/cpu.h b/arch/x86/kernel/cpu/cpu.h
index bc38b2d56f26..48ecc6dbaaa1 100644
--- a/arch/x86/kernel/cpu/cpu.h
+++ b/arch/x86/kernel/cpu/cpu.h
@@ -87,10 +87,6 @@ static inline struct amd_northbridge *amd_init_l3_cache(int index)
 unsigned int aperfmperf_get_khz(int cpu);
 void cpu_select_mitigations(void);
 
-extern void x86_spec_ctrl_setup_ap(void);
-extern void update_srbds_msr(void);
-extern void update_gds_msr(void);
-
 extern enum spectre_v2_mitigation spectre_v2_enabled;
 
 static inline bool spectre_v2_in_eibrs_mode(enum spectre_v2_mitigation mode)
-- 
2.34.1


