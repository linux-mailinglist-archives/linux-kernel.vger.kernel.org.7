Return-Path: <linux-kernel+bounces-850756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F33BD3A3B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC245189F275
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8EF30F7FD;
	Mon, 13 Oct 2025 14:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CwaLLoN3"
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010000.outbound.protection.outlook.com [52.101.46.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B737930EF8F
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366186; cv=fail; b=HKVD6hood2WCcwvoGBG4o0Q0Ki9vkCpWga46+U5KLsnR7//C1ijy3w0QpB0kVYE8WJiATstFWj/Q1sjzta+EnOU8E1rDFCImioBCvFvs812VYJ48LwIFTgCZWO9IswvSZlf3abHe3zEEpPQb0UzLKNip4/RGME+SvzHbvrF9AEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366186; c=relaxed/simple;
	bh=LG0kWNwoDdpLDXoRSdVGYFbczmlCLa/knBUs8Yzzh2Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JV1eNlNAN/y4BAPEVeCPJb1U0x4k3QQrvLoB+ubnW89+J1bb66NllY7aSDXAQAZZngHJ7Om3YpKnVAh04OHKr2l3gdZ6tWa/IjTPNJjCKxfZqZuINUWMOQUB6XF4pdC30VDurYR2+cN9jCXHxu+nK5AfSThx02+b6Mv1C9S1HbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CwaLLoN3; arc=fail smtp.client-ip=52.101.46.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jrGW+8Akdfph2zgmoTCR3pVSXdOZ5CRoLlz4SyQpfiPpDQBhrYkV5mOgzXUxxcn8smXf5gpi5ijwHN8nZIMjZA/3b/BE8aaA3hlUY43kYLb6nQXTyal8ld+qlG59oF5mdksYYakDe2voUs6pvtoXFwMDr2LirKI+h1ChQbZLSotOXlMClFFolnwoEnF2yyQYkqrlkp55hzgVmuL6Q2JfiVjSVCJDmY6bvrBNK9+QzERyxr/kln7U+GLeqB0sCm6IaVSB69QzY2p2XbZ2ZNvtZWZJ5qXlCSo0YLE2ZBfTYFJW2vyQIXahVUwN8OBCK9yvWkaRiPzzcidPwAEGYxMI+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJ/HIDnNyt+7iXraBzNzjKoY7DtFRMH2QR9WX3QKP7Y=;
 b=CAZFA4XAUJCW3w5Xot87orDnE0hhjBDzpJvOJC1wdIXZRqaxSOUY5+9+9X3fTUul6fEd9AF9hVvsXrwhXCVrZMxtRAytr7dMtTY1fkNjoixcUSGFvUpylrrQ/AMoST9nzrN/Dr0BQCMCNCozE5k/yYm/F1XNfwgebJ5G1nusWtpmNey0d1bQdYjJSu/TT8w5Zml/SykX/8a0dLH0u4rjxgcMUMpImmGAzPvplI1Rm6DbqHdhM6ozIKgWVQYgjWO3b9u31dx+Yp/Ge7/Swozy67D3HDHcrZ/BFBWuKsnbmYgUldRlGQBF3YT03q75aC9D8Hd+Ta295n+3mGz0oP5EtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJ/HIDnNyt+7iXraBzNzjKoY7DtFRMH2QR9WX3QKP7Y=;
 b=CwaLLoN3k62E+OloV+pQ1oOpvSD/QDll2F7XnzG2I0lYo8z+xacKJax2Kb4jo42gVgGAMvfUpLVe6hvR5i2QovgeV0VXB6gCVF8u1DeZ5+hh5Pmlbxc1NAA+1+Cfe1yKBo/vTLHjNGfbnlGt9z9lT5xcXcBosUZZ+P0i56l269g=
Received: from MW4PR04CA0070.namprd04.prod.outlook.com (2603:10b6:303:6b::15)
 by DM4PR12MB5746.namprd12.prod.outlook.com (2603:10b6:8:5d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Mon, 13 Oct
 2025 14:36:19 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:303:6b:cafe::a7) by MW4PR04CA0070.outlook.office365.com
 (2603:10b6:303:6b::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.12 via Frontend Transport; Mon,
 13 Oct 2025 14:36:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Mon, 13 Oct 2025 14:36:19 +0000
Received: from tiny.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Oct
 2025 07:35:52 -0700
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: Alexander Graf <graf@amazon.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 46/56] x86/alternative: Add ITS re-patching support
Date: Mon, 13 Oct 2025 09:34:34 -0500
Message-ID: <20251013143444.3999-47-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|DM4PR12MB5746:EE_
X-MS-Office365-Filtering-Correlation-Id: e4bce6e7-6404-4cb0-4ea3-08de0a65dfd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zIMWR0APj4aLfNPQeycPeLsWSWgDcL2hHHJcWICb1mEOBVec1u0XB18ywjNH?=
 =?us-ascii?Q?BRGDJOsBn0KbiSFRcS0FbMtoJtZhPaNdkKhHeJhxYKG72N2BTvfEJlGucLNR?=
 =?us-ascii?Q?dx76vk81bBiKkEDhiybR9gZvzAuBijJqzv6/sVPeDlHQHE+TH2sjBIMeWe/Q?=
 =?us-ascii?Q?6o33FJvrYx4yxEBXvgeM75sBiM/vSn78WrG4O4X+LC80hDE/BQWKvOylF68E?=
 =?us-ascii?Q?hgUqT6cPX537xda3q2I1JNwgR6M+b+MSVA6/C4tVjWPVE4jOf78bFscBRBAl?=
 =?us-ascii?Q?HYuPViIIEVdwuD+dtSNCo3UUiDCx8CyqpTzXdQq6H/LhbDkNGz+3RNVrldaR?=
 =?us-ascii?Q?mAYzWAVawA36pSI+XTsF2hFgpBkiuocom4bimDf/HxcGdSMYhtkx/uAPZqip?=
 =?us-ascii?Q?Oy1yvSykrWFLtrUfVU0Xt/B/fVXufLlWn7H9LxbR4fXB9G+Z0siS91vnUgj6?=
 =?us-ascii?Q?e/2gbehI6p+9bpWSQKPDP2jL1wjSVq8HW9XJsyV3sJh32ixIjLV0Ylf1CeXc?=
 =?us-ascii?Q?o/FgZwZ10KOKj9BFWhrwYUWwalFxDRnnXiERfK5L2dHs9SXYiWjzft0L2fOl?=
 =?us-ascii?Q?5Jqcp9FLblgaQusKLIdlcsOQ6iucVV+dtmbRaKxR+rOA5SBYNyNgax/7JBW7?=
 =?us-ascii?Q?lPi3vT32uB/rjV7y4SoH+OPibkjSrwIaxlB0A6DvCIuCa2RcUcz4oIUpvA+V?=
 =?us-ascii?Q?FwbFXsf0Buo+L67iKNLHwLNbZKEjRXYMQxZ/AlUgMqbXxP+3S7Vsr1KWqceX?=
 =?us-ascii?Q?cSLi3b8VwkiUNqVjUfbPtu0kJNFKi8dw+d68+VtdO2X6ncVR4zYePxshuU0o?=
 =?us-ascii?Q?SNco+bCcuNMDwb3wtj7NO05sB+ZCJZxntAyb8gjPUeUjmn7Aa0Q/is8YBH2V?=
 =?us-ascii?Q?7DfErgburjj57+OaiHRAoQ8BOdDsSFNQVhEniiD9ew/fAFWj61VS00+8886o?=
 =?us-ascii?Q?WnTTIF4m3Y1dSq9CHaBqjP9HLPRuUilrrK/jUnbXQRyZr3QNuKW+s7UztZWk?=
 =?us-ascii?Q?bWABB/4jbnTtOssmtRzvsVKl1DVeh9YJxXqDPy+nNl5c5PUotAR9Rs9F05N8?=
 =?us-ascii?Q?wAjcXoVLadW+VicEwLbnw0LbnXYl5i/zA/r1gL1grQFbayCNUsjjchmRjHxk?=
 =?us-ascii?Q?6SwKxnm9J5InFXudlm2TcKEJ+bPzV9xruDujHeoxHyXOg5MJbfjsMY9N2p5g?=
 =?us-ascii?Q?kbK+nhyzSKUfvXDJFZHrruEoyH3leB2J+7pvwisHrN0QBf+Qogr5FiAZZExT?=
 =?us-ascii?Q?ZrGFuN6KgBP7hjwEFnuykbDkUXzsMJtMraoVzyPHWu3YX7X20MCf9gEUPziv?=
 =?us-ascii?Q?sU5JTC98MP9VTpOV3c+yFfFn/zfLYHzhsWQY46o/VRZKfyCGbxFe7l4oWTld?=
 =?us-ascii?Q?NJ9ODvhsX2iFlDebWYCS0n0xj56yQWKO2Dh1dojmdHs9+hlZkud46zX5e860?=
 =?us-ascii?Q?SHKJVO+Yl43vEw3MOwiYTZ0pHiKa7R2eQUNnVK0cD5h2JfJUNcZ5QgKAa2gx?=
 =?us-ascii?Q?pMpGe3LSIrTSfrphebvXqWzocbfb3AX9OqPft28mtQSJiRapzxvNeHpIweZS?=
 =?us-ascii?Q?VOXoMNk6kfZnzS5cyZI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 14:36:19.4726
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4bce6e7-6404-4cb0-4ea3-08de0a65dfd0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5746

Non-atomic memory allocations from execmem and memory permission changes
cannot be done under NMI context.  Therefore, pages needed for ITS
trampolines are "pre-allocated" before actual re-patching is done.  The
address for each unique trampoline is saved in the corresponding
retpoline_site structure for use later during actual re-patching.

Pre-allocation is only needed when ITS thunks were not being used but will
be used after the re-patch.  Otherwise we can re-use existing memory that
has been allocated and configured.

If ITS thunks are no longer required, they can be free'd after the re-patch
has taken place.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/include/asm/alternative.h |  10 +++
 arch/x86/kernel/alternative.c      | 111 +++++++++++++++++++++++++++--
 2 files changed, 114 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 00e60195d768..61ce8a4b1aa6 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -102,6 +102,13 @@ extern void reset_retpolines(s32 *start, s32 *end, struct module *mod);
 extern void reset_returns(s32 *start, s32 *end, struct module *mod);
 extern void reset_alternatives(struct alt_instr *start, struct alt_instr *end,
 		struct module *mod);
+#ifdef CONFIG_MITIGATION_ITS
+extern void its_prealloc(s32 *start, s32 *end, struct module *mod);
+extern void its_free_all(struct module *mod);
+#else
+void its_prealloc(s32 *start, s32 *end, struct module *mod) {}
+static __always_inline void its_free_all(struct module *mod) {}
+#endif
 #endif
 
 struct alt_site {
@@ -112,6 +119,9 @@ struct alt_site {
 struct retpoline_site {
 	u8 bytes[6];
 	u8 len;
+#ifdef CONFIG_MITIGATION_ITS
+	u8 *its_thunk;
+#endif
 } __packed;
 
 extern void alternative_instructions(void);
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 5a543ffca10d..23bb3386ec5e 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -181,6 +181,11 @@ static void its_fini_core(void)
 {
 	if (IS_ENABLED(CONFIG_STRICT_KERNEL_RWX))
 		its_pages_protect(&its_pages);
+
+	/* Need to keep the list of pages around in case we re-patch later. */
+	if (IS_ENABLED(CONFIG_DYNAMIC_MITIGATIONS))
+		return;
+
 	kfree(its_pages.pages);
 }
 
@@ -887,13 +892,22 @@ static int emit_call_track_retpoline(void *addr, struct insn *insn, int reg, u8
 }
 
 #ifdef CONFIG_MITIGATION_ITS
-static int emit_its_trampoline(void *addr, struct insn *insn, int reg, u8 *bytes)
+static int emit_its_trampoline(void *addr, struct insn *insn, int reg, u8 *bytes,
+				struct retpoline_site *this_site)
 {
 	u8 *thunk = __x86_indirect_its_thunk_array[reg];
-	u8 *tmp = its_allocate_thunk(reg);
+	u8 *tmp;
 
-	if (tmp)
-		thunk = tmp;
+	if (!this_site || !this_site->its_thunk) {
+		tmp = its_allocate_thunk(reg);
+		if (tmp)
+			thunk = tmp;
+
+		if (this_site)
+			this_site->its_thunk = thunk;
+	} else {
+		thunk = this_site->its_thunk;
+	}
 
 	return __emit_trampoline(addr, insn, bytes, thunk, thunk);
 }
@@ -952,7 +966,8 @@ static void prepend_nops(u8 *bytes, int curlen, int neededlen)
  *
  * It also tries to inline spectre_v2=retpoline,lfence when size permits.
  */
-static int patch_retpoline(void *addr, struct insn *insn, u8 *bytes)
+static int patch_retpoline(void *addr, struct insn *insn, u8 *bytes,
+				struct retpoline_site *this_site)
 {
 	retpoline_thunk_t *target;
 	int reg, ret, i = 0;
@@ -1016,7 +1031,7 @@ static int patch_retpoline(void *addr, struct insn *insn, u8 *bytes)
 	 * lower-half of the cacheline. Such branches need ITS mitigation.
 	 */
 	if (cpu_wants_indirect_its_thunk_at((unsigned long)addr + i, reg))
-		return emit_its_trampoline(addr, insn, reg, bytes);
+		return emit_its_trampoline(addr, insn, reg, bytes, this_site);
 #endif
 
 	ret = emit_indirect(op, reg, bytes + i, insn->length - i);
@@ -1124,7 +1139,7 @@ void __init_or_module noinline apply_retpolines(s32 *start, s32 *end, struct mod
 			memcpy(save_site[idx].bytes, addr, insn.length);
 		}
 
-		len = patch_retpoline(addr, &insn, bytes);
+		len = patch_retpoline(addr, &insn, bytes, &save_site[idx]);
 		if (len == insn.length) {
 			optimize_nops(addr, bytes, len);
 			DUMP_BYTES(RETPOLINE, ((u8*)addr),  len, "%px: orig: ", addr);
@@ -3371,4 +3386,86 @@ void reset_alternatives(struct alt_instr *start, struct alt_instr *end, struct m
 			text_poke_early(addr, sites[idx].pbytes, sites[idx].len);
 	}
 }
+
+#ifdef CONFIG_MITIGATION_ITS
+void its_prealloc(s32 *start, s32 *end, struct module *mod)
+{
+	s32 *s;
+	u32 idx = 0;
+	struct retpoline_site *sites;
+
+	/* If its_page!=NULL it means that we already have ITS pages ready. */
+	if (!boot_cpu_has(X86_FEATURE_INDIRECT_THUNK_ITS) || its_page)
+		return;
+
+	if (!mod)
+		sites = retpoline_sites;
+	else
+		sites = mod->arch.retpoline_sites;
+
+	if (WARN_ON(!sites))
+		return;
+
+	for (s = start; s < end; s++, idx++) {
+		void *addr = (void *)s + *s;
+		struct insn insn;
+		int ret;
+		u8 bytes[16];
+
+		if (!should_patch(addr, mod))
+			continue;
+
+		/* We are decoding the original (compile-time) instruction. */
+		ret = insn_decode_kernel(&insn, sites[idx].bytes);
+
+		if (WARN_ON_ONCE(ret < 0))
+			continue;
+
+		/*
+		 * This function prepares for patching but doesn't actually
+		 * change any kernel text.  We are using it to allocate and
+		 * prepare the its pages, which will be used later during
+		 * re-patching.
+		 */
+		patch_retpoline(addr, &insn, bytes, &sites[idx]);
+	}
+}
+
+/* Free all ITS pages if no longer needed. */
+void its_free_all(struct module *mod)
+{
+	int i;
+	int num_sites;
+	struct retpoline_site *sites;
+	struct its_array *pages;
+
+	if (cpu_feature_enabled(X86_FEATURE_INDIRECT_THUNK_ITS))
+		return;
+
+	if (!mod) {
+		pages = &its_pages;
+		sites = retpoline_sites;
+		num_sites = num_retpoline_sites;
+	} else {
+		pages = &mod->arch.its_pages;
+		sites = mod->arch.retpoline_sites;
+		num_sites = mod->arch.num_retpoline_sites;
+	}
+
+	for (i = 0; i < num_sites; i++)
+		sites[i].its_thunk = NULL;
+
+	for (i = 0; i < pages->num; i++) {
+		void *page = pages->pages[i];
+
+		execmem_free(page);
+	}
+
+	kfree(pages->pages);
+	its_offset = 0;
+	pages->pages = NULL;
+	pages->num = 0;
+	its_page = NULL;
+}
+#endif
 #endif
-- 
2.34.1


