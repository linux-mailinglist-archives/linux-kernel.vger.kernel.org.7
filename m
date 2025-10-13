Return-Path: <linux-kernel+bounces-850743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA7ABD3A9E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07E4D3E3CF2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF4530DED0;
	Mon, 13 Oct 2025 14:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SnWnSzm2"
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012017.outbound.protection.outlook.com [40.93.195.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9926F30DD1A
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366164; cv=fail; b=DiraHauZdvJOgvm/Elzkqz1jdwYYqm+HEGr9o7OcNzQYZA6d4CAF8/V39Bx+JKZ/Pk8OPJPQQM8V9hslxAZe1BYAA67LUUuE4d2XGrwnNefPhrBp5XCCc79xNp9TSra0muEm3/GJ5EVHYSARP3a2r68+XqiGhclmR5+dUe8aVmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366164; c=relaxed/simple;
	bh=mGW/vkSeRiwLWzSHLryU0/XYqsoGK1XpU1gMfl9robw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b46c9mTJ9H1w2TbzTFRDPpIbczl96vFAMiHzemQiCKvHeTIjeK/uIW18lwFGNxflW0wdEHWifswr/fFQ9qeZaz23AWYK5P3cLIQ5EM2LNIXlB3qOXDknu2FswpziSdDb4+KcY7HX55u5tiq0skgY2eMZmK/Dix+Wg7p2e7aiUOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SnWnSzm2; arc=fail smtp.client-ip=40.93.195.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C8+y1kHcopM+TV19fzBAlDdcCr4NVvxr+dfANGLdi/HupZprhobFjl2kNU78rdX9s4fGWNyCExE8QTcGPuStnE/VyWLutnCGXN2B9/eGqLXa78jFAMe3qJr/PU3fUod/iO0zFQiJ5a6WlBx2Fu6EtxRm7xSMzcoVBnFJ4dYZlkkEd8o5ROenw8ts9V/XaMwAstCJvHcfjkjyUqHj3BEthYUOcGRHMPQpcVVQxGVYvgtSHhoFz7Kq2ahlJw5SKMiiDkEqnNki4blM4quYUlEEMxskzHKCweEcabZ6A1ItFiOPXhbcTBg2OyQtmuuKM5OQa6Mqw4s9F0r6tjl3HjBejA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f5A8TAb/Aqsv6GFDARqrHNFnXeHVh8cGNLik9QdaCko=;
 b=Y2agdfpwwBCDyIBgA9mwz276bnfJkdtGTOaIQC7c/7sjeJAcbLq323nJos53SG9UAKjEsDHiEP/zb2U2EGtX1OAHQaWCfWS/cmmwRrvPpfP4zLP2R0H1sQDMUrek50ld7BnZnZDhhjaPhk8xtiP+8yUFLdv0SP3dZYIP1Zv3o2NrbcpNQqh1GUe8g4Xxl8U4hHTaBpepAPowLgYeaJ6g4b6KAZ1hmbKazIG9+TpPoVBQjpmO3WiVrxsuwWoDXf2idDTHufY72lq5BrOXBBDsMUwBooJ3ALcSSvrtnrH7Oyu50YdYyWCwcyJA3+hd9HY5dtO7AYrxFtQCal+QOch7Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f5A8TAb/Aqsv6GFDARqrHNFnXeHVh8cGNLik9QdaCko=;
 b=SnWnSzm2lmXg4WBqGjrAyzoe4janfHTNAAmq9ihxtOPUr8yeD1YcnGQGd8SNzmeEa939NQMwxJJ8cZwA0FfHh/3nztBa+ejf3s3nSBy14P76ObZ3wXugX/Fx68J8yVfkWyfeQm9pf7vuuOKTiTm6FkNRiQ0eRZ+JyOjyRkGMYdw=
Received: from MW4PR04CA0102.namprd04.prod.outlook.com (2603:10b6:303:83::17)
 by MW4PR12MB6973.namprd12.prod.outlook.com (2603:10b6:303:20a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Mon, 13 Oct
 2025 14:35:58 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:303:83:cafe::61) by MW4PR04CA0102.outlook.office365.com
 (2603:10b6:303:83::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.12 via Frontend Transport; Mon,
 13 Oct 2025 14:35:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Mon, 13 Oct 2025 14:35:57 +0000
Received: from tiny.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Oct
 2025 07:35:42 -0700
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: Alexander Graf <graf@amazon.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 34/56] x86/alternative: Save old bytes for alternatives
Date: Mon, 13 Oct 2025 09:34:22 -0500
Message-ID: <20251013143444.3999-35-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|MW4PR12MB6973:EE_
X-MS-Office365-Filtering-Correlation-Id: c89ec11f-b3bc-45fc-fc69-08de0a65d2fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y+ee4I3sbr104bTqBTk8FqqzUG+gWmm/NHoqhTTDAgt0+h0p7CUzur33rqP4?=
 =?us-ascii?Q?KPIVMPaSQdstdD76Lzt+iLn/p3qgBY5uSzmTTJLuA905Ss6PT68wQMM5FiSB?=
 =?us-ascii?Q?jF09PRdYfL9Zfuf9owEJU3IQUCpKdtcsrZoXzsEAo6lqnZNN1W5C/hore+5X?=
 =?us-ascii?Q?Srs71g9X2ymUdCJEZ8GuqWGBWIMXkQdOMqWNwcxgTlR4rnA/cQmOvOhka7Aj?=
 =?us-ascii?Q?zwh+smTC5SWO3jGFJA9madbpfvqNXLWal0ocn0BuBhkvOQsolUZk24Ahqm9H?=
 =?us-ascii?Q?oxpAX9p8k8euRrtx7uWfPRQ9bg3DjdW3JfzZjcOv9sLXhvctESanqDJwo98L?=
 =?us-ascii?Q?5sZK3kP2Ajbd/YelcR1Z3ZqhtQKGLP9YEtnbRGbYJYu1mfQDBJlgZnFB3G6r?=
 =?us-ascii?Q?ShUGkBrrpUGYb/0PjApEdarb2eSznEmo0MD5KkABz5ZJNk8ervVpDWK6nmoE?=
 =?us-ascii?Q?XhFTK7ri+VsQbnbjxS6/bnfZwAvpOCg10+xsve3zFApUhYPIf5K/nGOhAGUu?=
 =?us-ascii?Q?8b46nw6Wr2iduQlL1qSA6sGW3Q265XUgGbMavoLvjzYRKNcGuFG3icTblYxR?=
 =?us-ascii?Q?lJZ71GCY55LLSNBGN5F5Y4NApp6Hp1bV9AFPOoRVlVN/V69edNx3eADir4nJ?=
 =?us-ascii?Q?NBeAcAelPAGYgvTze7/cZ/yG/UHIRZm6BM1qiQ9G8KX/jD49grJ+Q9e9XoTN?=
 =?us-ascii?Q?GabxWhMNjnzpp06f9oTvqbIzpn6arn2cbsTNDg3lmVbE6bbxN47NsmiSeh4Y?=
 =?us-ascii?Q?AUeYGsHbNKXgsdZ5eVVRdUIav5pz64O1JOBbg7NmlTPrS1AtggWsFH9u02pD?=
 =?us-ascii?Q?gUfo7OcbnYGEuoUMibjRC1zwQzt/Dxx9Ft3LKRteOYMNONnlFpBrIlKh+zbr?=
 =?us-ascii?Q?NlxzixtxHxMM10vIqTdZEg6gz9yvh8JmykFhcFZkf+o0z/umdsMeG9ZgUs9s?=
 =?us-ascii?Q?qULO9KAAyiv8MCpop1eZHTXxb/9g7q3Kw1SFX1A2UG4Y0rxL1x6zXI6ibWQr?=
 =?us-ascii?Q?CcYPz/Ky896+ES6TQH8zlynxj3cShMMNzFY0gqOYDVPCDf34Svi7jWx/BW/d?=
 =?us-ascii?Q?L22YPUI5uOJ5qIMEdmV5ryggGEbkY/smFsWLMS7f1r8DlURMhKq2UJ4g3vPX?=
 =?us-ascii?Q?CJ8/s8hIyKZ+YoxZHbYTJRS5RiL+jpS797fxWmTTazQ5Semo2NukcmcN1+i9?=
 =?us-ascii?Q?up3ZPeX7wO+JE0+SbYx00C+pfn03nniKT/S38PkJF/xphTPcDD4E64IkKt4e?=
 =?us-ascii?Q?xSTqH+kpUFwnMBCf306juVypmkgIX0TDmcUkL75V3hCEKN4VxRmLM4785Hof?=
 =?us-ascii?Q?KcdjEVBIo+5diKpUJS4tmmkGEwDz1S8ZtUOdAa5f5mj4XpXMhz4FH+5CiL51?=
 =?us-ascii?Q?7EnYNfgb9o8CBDjXMEp4fpWnc1T/tLzE1LRfJcx+7rcprmOe1bUrrcckujP7?=
 =?us-ascii?Q?FkdkXx8TT6jkY2N4/KRED40ezm2Csc3+6YHNldSpj7RIY2d4YVmoV/nlKpU7?=
 =?us-ascii?Q?4nHY38ORYV/L91++qiTgVMLRLlmb90Wk6lSkvz91KlqhHQOWo465NbG6Apxa?=
 =?us-ascii?Q?Rb8TKLCW0jPcJDDEG6g=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 14:35:57.9669
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c89ec11f-b3bc-45fc-fc69-08de0a65d2fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6973

Save the existing instruction bytes at each alternative site when patching.
This is only done the first time, and these will be used later to help
restore the code back to its original form.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/include/asm/alternative.h |  5 ++++
 arch/x86/include/asm/module.h      |  3 +++
 arch/x86/kernel/alternative.c      | 37 +++++++++++++++++++++++++++++-
 3 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 73fd8ebdf8d9..3ee781d61927 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -97,6 +97,11 @@ extern int alternatives_patched;
 
 struct module;
 
+struct alt_site {
+	u8 *pbytes;
+	u8 len;
+};
+
 extern void alternative_instructions(void);
 extern void apply_alternatives(struct alt_instr *start, struct alt_instr *end,
 		struct module *mod);
diff --git a/arch/x86/include/asm/module.h b/arch/x86/include/asm/module.h
index 3c2de4ce3b10..2bb602f99154 100644
--- a/arch/x86/include/asm/module.h
+++ b/arch/x86/include/asm/module.h
@@ -19,6 +19,9 @@ struct mod_arch_specific {
 	struct orc_entry *orc_unwind;
 #endif
 	struct its_array its_pages;
+#ifdef CONFIG_DYNAMIC_MITIGATIONS
+	struct alt_site *alt_sites;
+#endif
 };
 
 #endif /* _ASM_X86_MODULE_H */
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index a821ea37fc29..8037076e9301 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -301,6 +301,8 @@ static inline void its_fini_core(void) {}
 static bool __maybe_unused repatch_in_progress;
 
 #ifdef CONFIG_DYNAMIC_MITIGATIONS
+static struct alt_site *alt_sites;
+
 /* Do not patch __init text addresses when repatching */
 static bool should_patch(void *addr, struct module *mod)
 {
@@ -642,6 +644,27 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 	u8 insn_buff[MAX_PATCH_LEN];
 	u8 *instr, *replacement;
 	struct alt_instr *a, *b;
+	u32 idx = 0;
+	struct alt_site *save_site = NULL;
+
+#ifdef CONFIG_DYNAMIC_MITIGATIONS
+	u32 size = ((u64)end - (u64)start)/sizeof(struct alt_instr);
+
+	/* Main kernel text alternatives */
+	if (!mod && !alt_sites) {
+		alt_sites =  kcalloc(size, sizeof(struct alt_site), GFP_KERNEL);
+		if (WARN_ON(!alt_sites))
+			return;
+
+		save_site = alt_sites;
+	} else if (mod && !mod->arch.alt_sites) {
+		mod->arch.alt_sites =  kcalloc(size, sizeof(struct alt_site), GFP_KERNEL);
+		if (WARN_ON(!mod->arch.alt_sites))
+			return;
+
+		save_site = mod->arch.alt_sites;
+	}
+#endif
 
 	DPRINTK(ALT, "alt table %px, -> %px", start, end);
 
@@ -664,7 +687,7 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 	 * So be careful if you want to change the scan order to any other
 	 * order.
 	 */
-	for (a = start; a < end; a++) {
+	for (a = start; a < end; a++, idx++) {
 		int insn_buff_sz = 0;
 
 		/*
@@ -687,6 +710,18 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 		BUG_ON(a->instrlen > sizeof(insn_buff));
 		BUG_ON(a->cpuid >= (NCAPINTS + NBUGINTS) * 32);
 
+		if (IS_ENABLED(CONFIG_DYNAMIC_MITIGATIONS) && save_site) {
+			/* Only save the original bytes for each location */
+			if (a == start || (instr_va(a) != instr_va(a-1))) {
+				save_site[idx].len = a->instrlen;
+				save_site[idx].pbytes = kmalloc(a->instrlen, GFP_KERNEL);
+				if (WARN_ON(!save_site[idx].pbytes))
+					return;
+
+				memcpy(save_site[idx].pbytes, instr, a->instrlen);
+			}
+		}
+
 		/*
 		 * Patch if either:
 		 * - feature is present
-- 
2.34.1


