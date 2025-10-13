Return-Path: <linux-kernel+bounces-850740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8762ABD3A08
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0BA6E34D343
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137D630DD24;
	Mon, 13 Oct 2025 14:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WGNFpyu2"
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012034.outbound.protection.outlook.com [52.101.48.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D542E30CD87
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366161; cv=fail; b=C6f7dlpmDY6biymfRF9+nAMl40+Mqi+rJ0EvIzVog1cDm31CQuC05gp+OrfJod12Q9ewDFBd6yZQmrWruL66Ri9ze/Qb3vDhXPhdWQ0orBvMtEWkLblcauxjivFWMWOic41dxRZil/1499ld51tBo6uDgHEtr04cMZ1N+0i82bA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366161; c=relaxed/simple;
	bh=4wgqe7N27rsjsbcndHBp0NQ+epQwC5pPO5FVCjNXaGk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o+gdEEqiiCipQQFpIDIwJs5x86X4T0STGNZVWv6XDh3dFoj3ZM5RM1lFQacJ4NphnKF4549nM3kHYsVlvTJNqE3LC6N1245FXsFx1jsLkm4NatLQI6EJ2kyL0NbnGf0u1UjUPXLWEbWphcttP1ZAcQMGT/desUGC7yVezJ1gUY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WGNFpyu2; arc=fail smtp.client-ip=52.101.48.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iFSg5E6HYrf/evOWUB7q2GqJzlGnFh6uzqjDtcr7/u/Id5MGAYcRqAhWYnn0uvBiqhcorlwFxMQN/ucKDhlHI4soCWKT32/DJd3ODAzQWVJH0ss1uDq1kHRkUz0Mr0qH4LUh1TQUxKrzcZFlSik5ZJuXQdpeMEGfMo/63XsgBygUr12Pu08r3mftQph1FMeFxbr8S9ezEln5YBl98xa4FDSfssPt1DC4XEErJ5A9+bY3dQWHhsGEGFdEGThK+lBRnmgy1ox+17m7Y0rvsfOx4v3j9LsqmOTylQrJ9pFUifxmTQhz+Ih5Vt0oyFG3H0rYrOgUozzKQLYjE/OOfClPbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/eN39qjNA5rL6R5SqKEN4XFJOmz3NrezM3rZVUBP8o=;
 b=FidpHFqLNFNe+/bQaDLsXfwyrClB0TnJpIWrPgNU0I90vX8fbBV9UuXRDOaMeVGV2JV3LTs3uuVoiuqxqf7g1KPjJTTfyAHgQ/iUwUeGNXlp5QfEsjTXRpQ8T0nh2Agn1ZD3nnGMXot679eljLzsCah0HZKWXAH9DeFE6VzC5WJEk2HfapkermcNRk5Nc+TsoG+AN2tOPrtMU+JQ+vtuKEYitCEzXTUB+RFZmoSpKFPAaur2T5rRgXYhpsCfG23vI0L7iIYvCMFs2KfEs0Z29KFYF6wVYLpm2pfhxkFH7bSsRjSF6BHjMbkC+OmoLNztmJkaMWOsIqmTBahF+2D6XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/eN39qjNA5rL6R5SqKEN4XFJOmz3NrezM3rZVUBP8o=;
 b=WGNFpyu2XglYRbo2Ejc1q2MU2omZcr1c4jtIhb4Eroge+1PGczzatqKgpyGOz2oVaya2c4beZ5eHe50w3TAsQKWOIRYXn7+Uzgf18SmLU/Lym0L2FY4U0yN+6/clKNsbO8AXGZNj39WZVCyMcDOelF1BG+Sk32iuJ00+yp5KycE=
Received: from MW4PR04CA0120.namprd04.prod.outlook.com (2603:10b6:303:83::35)
 by MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 14:35:56 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:303:83:cafe::a8) by MW4PR04CA0120.outlook.office365.com
 (2603:10b6:303:83::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.12 via Frontend Transport; Mon,
 13 Oct 2025 14:35:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Mon, 13 Oct 2025 14:35:56 +0000
Received: from tiny.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Oct
 2025 07:35:41 -0700
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: Alexander Graf <graf@amazon.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 32/56] x86/alternative: Add module param
Date: Mon, 13 Oct 2025 09:34:20 -0500
Message-ID: <20251013143444.3999-33-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|MN0PR12MB5953:EE_
X-MS-Office365-Filtering-Correlation-Id: 67aabca7-0db8-4a7b-500f-08de0a65d221
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yndSNGBI5DpG6R76q2LAy/81VlnkQM9vvu23imcF4Rbnw3NYNyOGrj3cZhPt?=
 =?us-ascii?Q?7vmtmsH2XHO9L0uHtFQrNjIQZFiFyX9YpfJdJmkjCTJ3/zPFkG1FKVGjG+bg?=
 =?us-ascii?Q?ro4KbCTRdVdDdlINyio10vYY9lhnFpWv57BhhTb+Uqth185/4K4ECViQJFzO?=
 =?us-ascii?Q?PhpFPKyXHy+42aOmkFLGq6IRBUGBgH3q8p5b63ssEdRknGY5pzRlaEQOsG6l?=
 =?us-ascii?Q?L2dPbYHzXzn1rTL9BaEonFruyFCVtGiK5hCI3+ozsik8X2AtHP27Od+hLDOa?=
 =?us-ascii?Q?Y1lRgKo/rIjgFWPTxLK0JJyQQVP3ZgCmVpcEcq/m8L4BIRCfFRwwJZ2JbFJX?=
 =?us-ascii?Q?DSKbaVAEnCtC/fgU8cSrpwcZUqwkBZbtsNwW73zIv+YcZ9kjAYodK+PIRBO2?=
 =?us-ascii?Q?ikYrdm+nWlZCdQz06Lu5GPaO+K73HswcxYtc4OD7hyhpug4SQN29BVUzJ88U?=
 =?us-ascii?Q?LV82IRbEDE0B9GUpTtSyim9CiEA5EgoORP5bJVKZ3CZXnEkizulXnQMLkLV7?=
 =?us-ascii?Q?ANQVyhQQrVmEML/PzbhPvzTOWYLFtd6gJ0XwrPI+NxotmJMcfSel0SAssV9k?=
 =?us-ascii?Q?vWgml13jjFgp0eaTA8n7zQDOR5Ka2Yoh3UELF0Lb2ShyTgJPyxDMjZGnMNCv?=
 =?us-ascii?Q?zoqwswe9kDvljvDi0q5m8dLt/8oglBVT4DXH7lahxCTkbs1wdF/8fjmeOwjt?=
 =?us-ascii?Q?X2ENwlvm4/iSHcvPB/NmgN7XsFegyGjh328DH6CRZZSMlte4L1Y1tCQYxp/l?=
 =?us-ascii?Q?rj/zRoHpmzdVeGhnF4uXSs9vYJ1YzfS3NpPo55m8g15yDy5SkK2g452HtBD0?=
 =?us-ascii?Q?vwrSJVk6e2fA1xdTDQdzhaQoopaOPKxRV4mmDmT/Khi2BzJDjzxeFyLr1kT3?=
 =?us-ascii?Q?amnVjwFXec/Msp29kzgSMoM3wkO9mT7VkjBztvw/Munz1CQHOxmJkD610N0t?=
 =?us-ascii?Q?w1M944YhaCnVFHOCDDGO8a3I/7iofJJtFk6vhqK0dTeTUVKKu/k59Q1tpQYe?=
 =?us-ascii?Q?4qO9Gqgk8Yw1K0drIZAIy0r4OmMkdxaOJl2XskJA9LT9kxJDWv0hTc09BFnT?=
 =?us-ascii?Q?nnKSv0AXDaWsIio9KEMHJzT586ZP/EQKZqaOEpUTbDy8ObywKFvP50ywdYMp?=
 =?us-ascii?Q?M6VRAEsmglN+N6bc16kiEGz473HmzTy+S2hwKTggdLVsm4OHfa5tBAsOvYfX?=
 =?us-ascii?Q?xfkPXaZ/ZNMNWJFgcbP83Rn/PL33UlkzKzkaKvscL2tZHt4icmoKXozDoNqi?=
 =?us-ascii?Q?D6FiMiZHImBhE2m+H8l7f/njNKCtLSeZFUtUMBtCieOusjamvGsqLoF4xvJX?=
 =?us-ascii?Q?3KqlykBPdQoT9wZalDMyJzJeodFfbsmaMvc48IY/uidoFu/awpMq6x7AZIPs?=
 =?us-ascii?Q?JMzSejxzlyf7r649osNm8JVPNgY4eRWo4vbvUGGRqqSR5CUNfGbTjM5gcOIK?=
 =?us-ascii?Q?LY//i/9o1gRetCX3wk5CXp67NvDIgZ2y24nCtUWjvPm49shbu3gCccY6DXoo?=
 =?us-ascii?Q?sAE78cRTyThwJG9DDUYpvdH/dBhTnLh4pqhynY71/I2xIwBnjmPeniR8Z9mi?=
 =?us-ascii?Q?7Gspg1If7CFnIfMMxG0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 14:35:56.5152
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67aabca7-0db8-4a7b-500f-08de0a65d221
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5953

Add a struct module* param to the apply_alternatives(), apply_returns(),
and apply_retpolines() functions.  This will later be used to help store
the old instruction bytes to support re-patching.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/entry/vdso/vma.c          |  2 +-
 arch/x86/include/asm/alternative.h | 11 ++++++-----
 arch/x86/kernel/alternative.c      | 19 ++++++++++---------
 arch/x86/kernel/module.c           |  6 +++---
 4 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index afe105b2f907..2451a8007854 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -42,7 +42,7 @@ int __init init_vdso_image(const struct vdso_image *image)
 
 	apply_alternatives((struct alt_instr *)(image->data + image->alt),
 			   (struct alt_instr *)(image->data + image->alt +
-						image->alt_len));
+						image->alt_len), NULL);
 
 	return 0;
 }
diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 15bc07a5ebb3..73fd8ebdf8d9 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -95,16 +95,17 @@ extern s32 __smp_locks[],	__smp_locks_end[];
  */
 extern int alternatives_patched;
 
+struct module;
+
 extern void alternative_instructions(void);
-extern void apply_alternatives(struct alt_instr *start, struct alt_instr *end);
-extern void apply_retpolines(s32 *start, s32 *end);
-extern void apply_returns(s32 *start, s32 *end);
+extern void apply_alternatives(struct alt_instr *start, struct alt_instr *end,
+		struct module *mod);
+extern void apply_retpolines(s32 *start, s32 *end, struct module *mod);
+extern void apply_returns(s32 *start, s32 *end, struct module *mod);
 extern void apply_seal_endbr(s32 *start, s32 *end);
 extern void apply_fineibt(s32 *start_retpoline, s32 *end_retpoine,
 			  s32 *start_cfi, s32 *end_cfi);
 
-struct module;
-
 struct callthunk_sites {
 	s32				*call_start, *call_end;
 };
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 7a1f17078581..9fbec219e98e 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -615,7 +615,8 @@ static inline u8 * instr_va(struct alt_instr *i)
  * to refetch changed I$ lines.
  */
 void __init_or_module noinline apply_alternatives(struct alt_instr *start,
-						  struct alt_instr *end)
+						  struct alt_instr *end,
+						  struct module *mod)
 {
 	u8 insn_buff[MAX_PATCH_LEN];
 	u8 *instr, *replacement;
@@ -972,7 +973,7 @@ static int patch_retpoline(void *addr, struct insn *insn, u8 *bytes)
 /*
  * Generated by 'objtool --retpoline'.
  */
-void __init_or_module noinline apply_retpolines(s32 *start, s32 *end)
+void __init_or_module noinline apply_retpolines(s32 *start, s32 *end, struct module *mod)
 {
 	s32 *s;
 
@@ -1076,7 +1077,7 @@ static int patch_return(void *addr, struct insn *insn, u8 *bytes)
 	return i;
 }
 
-void __init_or_module noinline apply_returns(s32 *start, s32 *end)
+void __init_or_module noinline apply_returns(s32 *start, s32 *end, struct module *mod)
 {
 	s32 *s;
 
@@ -1117,13 +1118,13 @@ void __init_or_module noinline apply_returns(s32 *start, s32 *end)
 	}
 }
 #else /* !CONFIG_MITIGATION_RETHUNK: */
-void __init_or_module noinline apply_returns(s32 *start, s32 *end) { }
+void __init_or_module noinline apply_returns(s32 *start, s32 *end, struct module *mod) { }
 #endif /* !CONFIG_MITIGATION_RETHUNK */
 
 #else /* !CONFIG_MITIGATION_RETPOLINE || !CONFIG_OBJTOOL */
 
-void __init_or_module noinline apply_retpolines(s32 *start, s32 *end) { }
-void __init_or_module noinline apply_returns(s32 *start, s32 *end) { }
+void __init_or_module noinline apply_retpolines(s32 *start, s32 *end, struct module *mod) { }
+void __init_or_module noinline apply_returns(s32 *start, s32 *end, struct module *mod) { }
 
 #endif /* !CONFIG_MITIGATION_RETPOLINE || !CONFIG_OBJTOOL */
 
@@ -2407,8 +2408,8 @@ void __init alternative_instructions(void)
 	 * Rewrite the retpolines, must be done before alternatives since
 	 * those can rewrite the retpoline thunks.
 	 */
-	apply_retpolines(__retpoline_sites, __retpoline_sites_end);
-	apply_returns(__return_sites, __return_sites_end);
+	apply_retpolines(__retpoline_sites, __retpoline_sites_end, NULL);
+	apply_returns(__return_sites, __return_sites_end, NULL);
 
 	its_fini_core();
 
@@ -2418,7 +2419,7 @@ void __init alternative_instructions(void)
 	 */
 	callthunks_patch_builtin_calls();
 
-	apply_alternatives(__alt_instructions, __alt_instructions_end);
+	apply_alternatives(__alt_instructions, __alt_instructions_end, NULL);
 
 	/*
 	 * Seal all functions that do not have their address taken.
diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
index 0ffbae902e2f..0765d2360a33 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -286,14 +286,14 @@ int module_finalize(const Elf_Ehdr *hdr,
 	}
 	if (retpolines) {
 		void *rseg = (void *)retpolines->sh_addr;
-		apply_retpolines(rseg, rseg + retpolines->sh_size);
+		apply_retpolines(rseg, rseg + retpolines->sh_size, me);
 	}
 
 	its_fini_mod(me);
 
 	if (returns) {
 		void *rseg = (void *)returns->sh_addr;
-		apply_returns(rseg, rseg + returns->sh_size);
+		apply_returns(rseg, rseg + returns->sh_size, me);
 	}
 	if (calls) {
 		struct callthunk_sites cs = {};
@@ -306,7 +306,7 @@ int module_finalize(const Elf_Ehdr *hdr,
 	if (alt) {
 		/* patch .altinstructions */
 		void *aseg = (void *)alt->sh_addr;
-		apply_alternatives(aseg, aseg + alt->sh_size);
+		apply_alternatives(aseg, aseg + alt->sh_size, me);
 	}
 	if (ibt_endbr) {
 		void *iseg = (void *)ibt_endbr->sh_addr;
-- 
2.34.1


