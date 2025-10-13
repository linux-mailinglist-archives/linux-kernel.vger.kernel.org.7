Return-Path: <linux-kernel+bounces-850761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F14BBBD3ABC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2A4F34F8166
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D046230FC1E;
	Mon, 13 Oct 2025 14:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VV+uPGD+"
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013071.outbound.protection.outlook.com [40.107.201.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC6E30F557
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366190; cv=fail; b=qfFSRG0OP421zKnVc6yf5DvLBCzNDg/Es8WtBLUp0l9gM4FSB2jK3jHpZkbdi4JHMLLEZtTLZ34xFW1VpWObTkTdqRw4piBanb8ChkKzEo3DG9fNYgkApS3SW6ok84pY/ARwgZwsklBKJod1vc0/HGDLbREs2JX5mTtW8V5urSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366190; c=relaxed/simple;
	bh=y/X1C1gge8NrTtSP/SBWDtpXN7TKdqBc1xiu59d90gQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CQJUsuKB45+4TUHFG9o21Qdz8Eeccn/OkQUc1PK/rR5M7VGnIv3ale5ivm9VyHT6ZLnZkSlc/R44YP3uPRaUmE5YaQAgVdo6jEijjO4UrkkLAIJh117Yb91TCmnkfzlWxrZlYBXhEJTSh9coxeAtBX8WSiRJW1bEtKjIWiLqmcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VV+uPGD+; arc=fail smtp.client-ip=40.107.201.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DZ6mR8Rl2G6D9poJn9rvGru7nwilnXJjcDzQ/nNg1LnVrfAg2HjEfj7rEjShFZ/08AwvRYpxuo8hy28+fBuIJKwQAtMEekqhW+VSLMfNUqbcNhmvn9foAY1HIxTceoTE4Gr94UdRuUuP5r8U4pRE6pzz46WvGyjgeAbpY8nJGJ3yfW4AyFpKzT94RcKcofmRPHz4HvMhXCKQX7lyF+UMW/6FadIRA969uOvkTa77oGR79+57rA6nFQTq2gknVe32jmrhcBUTUETzAjjE12Vw4gE/JyHIv2ndpD27vXBvemCu/nPQEt2eWi0vkfI8BZfis8UtSqnRM7cdEC4BHCCZvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ra9pd1e1FAa+c7ZerVRsByviT/+mN8yismsAEmZKdwQ=;
 b=KHrWp2I4hvUOPUYyyAfLSafkUPEUo3jk9rfnWk9BLPDR5ItbBwylsHg2lM9grpaLbxllLEnkbY7Gvbj0Mcv6myxNfJwk8TKnYTH6MvaDoUNvbzpxH2EuKd3kofjYa6ypiKbHZlcXv9ZeHEIM91tE7uFPzvc1Ky5yVLWlV9/460QLtU2rTfJsTyOhR5wBmaXBbPIKZg/+MEYXDPpmXSd0gQzVTlFkd2I/0ZKL6yR6Gr2q/HddhTsB/H+Ba2vdaLHWuscZHmJ/BeIOuYBYkpQop09W+Yz+1Swz2qFY7Y5FtirVYOAgXjjWFWqABYYcKYXe5urxyH5bMs0zF0qJGgE58g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ra9pd1e1FAa+c7ZerVRsByviT/+mN8yismsAEmZKdwQ=;
 b=VV+uPGD+Pa6DuRzxVIWttP8njJwkFgcytqhve64iFWIrR1jA9kaWyzN4+TJKakPwBMplwpCmlWH263pwFwm1BvOzOLijKHi0jwrENquBRoMZq8B9a9ztI9e2rwwdc6r4Q5qed7XFp7X2i4xUi3ucuQ4c/HIsFYeGZj99P5D4h9Q=
Received: from BYAPR07CA0044.namprd07.prod.outlook.com (2603:10b6:a03:60::21)
 by DS0PR12MB8270.namprd12.prod.outlook.com (2603:10b6:8:fe::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Mon, 13 Oct
 2025 14:36:22 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:a03:60:cafe::c3) by BYAPR07CA0044.outlook.office365.com
 (2603:10b6:a03:60::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.12 via Frontend Transport; Mon,
 13 Oct 2025 14:36:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Mon, 13 Oct 2025 14:36:21 +0000
Received: from tiny.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Oct
 2025 07:35:55 -0700
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: Alexander Graf <graf@amazon.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 50/56] x86/alternative: Add re-patch support
Date: Mon, 13 Oct 2025 09:34:38 -0500
Message-ID: <20251013143444.3999-51-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|DS0PR12MB8270:EE_
X-MS-Office365-Filtering-Correlation-Id: 445a28f7-e527-44af-be9c-08de0a65e118
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n4bf5bUbz1w0C2Kq41PRRilUpoRHC4FqAofCCfB7rxSAmsorF3UzgRxUdxG+?=
 =?us-ascii?Q?UDE1TT188b9f2eyu3o5mUY9eeWqVh2xy4GCnqkKlgKrWYY1VNGvVTEz125t1?=
 =?us-ascii?Q?hOSSv14jvlnFU4AR1uvJYmFkSilj0g8KYwuwPBSI+P31AYP8OFzkofQBWe9+?=
 =?us-ascii?Q?12FTS+PuMF60rlCPCHPYy4w1gWVuCnTPZwFWV/d2HmU+Nel2RaWc3XKfNu+f?=
 =?us-ascii?Q?QraUj21yTyvZbmqhc0ys6LXyEPeR5puqrx8SrF5eSDDxReXx3W3KoqTtevws?=
 =?us-ascii?Q?gvFRGy1JZUbiI2mGWKS13HBH2BKIkteOppKNBYw468azMXgmaIxNV2C/p4Py?=
 =?us-ascii?Q?vvp0kAWUhU2gaXyNMLboQTbt/Ch+r0qVw2lUgTG/3XNuRE+BYXFjP9jcJkZD?=
 =?us-ascii?Q?v2hDIeEa1RstbLze9hlbe0Km90zCK+U5ZnB2MOR+c5ucn0z6nm4Pi0izB3+u?=
 =?us-ascii?Q?88gfT74QUQI5n9cgic12fzPPhmihisq+Qwz9nWEMj+mX0fZ8xPYyp7FGMAKy?=
 =?us-ascii?Q?xwiN43IkguJykdGlw9+UWBOeiVt0g2shKiEu+/zj0SwnwbInaeKGPcvT89p7?=
 =?us-ascii?Q?6BB9QcWdXHGNa0SarfB7fNCFr+WLDgzasT/7IjQNNw/pbS4XHfQqljVgTS6P?=
 =?us-ascii?Q?DLUX/QbU0S2qwOp6Wfx1JzPmlFj/RUbZKyFYkhEfD2MT6vT0cHNW5zUmqvSN?=
 =?us-ascii?Q?1IAonwfGKhuRe2XfVINsZ428rXh26lVREn+T/RWLh72fWhC9XMfvnv1U1+nl?=
 =?us-ascii?Q?gSZlcrtYbDu97mRhFyAPDDRBpB4HBM3UD+G8HFyxtHzn3bF6PjAB+BqjlpcD?=
 =?us-ascii?Q?90Gp3kdpQNXNsB9jUsNLHLXmMC2RILk3JLgkjeYPNPvv2JraJjvywuSxmtFm?=
 =?us-ascii?Q?yyBMZavLKS/NerrYF59ReSHjmZLrcR1TsfmsJ00/wa8cb2AOA2I5qsz26uBV?=
 =?us-ascii?Q?Wzg8sv8XWbN5HM/HBH8tZHX/pXixW+V6miM1BWLvCtZLQsT4lm77yVSSbdat?=
 =?us-ascii?Q?xE3+CGbq1SJuy7jUta0SM1+iHHRhmreSrARA4fvtOGxqUhOFPXeVAuyEWDsW?=
 =?us-ascii?Q?dU/7Q/fgHn1uVKdvw7d1RM4ptfPy280iXxX2/WkIw6ZNYbSqoh0LoMazv7hR?=
 =?us-ascii?Q?ui0dsylbi9muTKm2lPgq9vilEJujg3L8gGrQhl1mvp0EnQdVXktnHx4B9F/X?=
 =?us-ascii?Q?R5rCRHQ6yieWB90eeQxFnTuUdW4N2jdBqYkBvtYG+A0dlXld1pVjVkM6IaNT?=
 =?us-ascii?Q?fvWJR9fjeU98frk1RqRL/gdrknsrRQvoF/l36iIRVXXpRun2Eb+PdGhCDUc8?=
 =?us-ascii?Q?2+CSkN2lPOfcZwKKOABeMHDnvla9l09awPxqca/vfHGLwFJj+zPFn92O+7Bt?=
 =?us-ascii?Q?Cb+JqYKH2y+jZJGpKU/oWyRVAAf95VU+uEyA36G2ygRI5doTOCCVRfZ4lzTn?=
 =?us-ascii?Q?LEAZoiWAcsdLvXYM+uPuk5MIZLWIO9zAa8ZZXif8jtV03tvInPgN0TDwNegf?=
 =?us-ascii?Q?orPFPl58hOSywRXAA4yE5Rf+DJO8HxK0sd6MM3XAl2JSe71JCRCo4eZ2xi3m?=
 =?us-ascii?Q?2pXPQ35Gn7IuokGoeW0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 14:36:21.6257
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 445a28f7-e527-44af-be9c-08de0a65e118
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8270

Updating alternatives is done under the biggest hammers possible.  The
freezer is used to freeze all processes and kernel threads at safe
points to ensure they are not in the middle of a sequence we're about to
patch.  Then stop_machine_nmi() synchronizes all CPUs and puts them into
a tight spin loop while re-patching occurs.  The actual patching is done
using simple memcpy, just like during boot.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/include/asm/alternative.h |   6 ++
 arch/x86/kernel/alternative.c      | 131 +++++++++++++++++++++++++++++
 2 files changed, 137 insertions(+)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 61ce8a4b1aa6..f0b863292c3c 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -19,6 +19,7 @@
 #ifndef __ASSEMBLER__
 
 #include <linux/stddef.h>
+#include <linux/static_call_types.h>
 
 /*
  * Alternative inline assembly for SMP.
@@ -89,6 +90,9 @@ extern s32 __cfi_sites[],	__cfi_sites_end[];
 extern s32 __ibt_endbr_seal[],	__ibt_endbr_seal_end[];
 extern s32 __smp_locks[],	__smp_locks_end[];
 
+extern struct static_call_site __start_static_call_sites[],
+			       __stop_static_call_sites[];
+
 /*
  * Debug flag that can be tested to see whether alternative
  * instructions were patched in already:
@@ -98,6 +102,8 @@ extern int alternatives_patched;
 struct module;
 
 #ifdef CONFIG_DYNAMIC_MITIGATIONS
+extern void cpu_update_alternatives(void);
+extern void cpu_prepare_repatch_alternatives(void);
 extern void reset_retpolines(s32 *start, s32 *end, struct module *mod);
 extern void reset_returns(s32 *start, s32 *end, struct module *mod);
 extern void reset_alternatives(struct alt_instr *start, struct alt_instr *end,
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 23bb3386ec5e..613cb645bd9f 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -6,12 +6,15 @@
 #include <linux/vmalloc.h>
 #include <linux/memory.h>
 #include <linux/execmem.h>
+#include <linux/stop_machine.h>
+#include <linux/freezer.h>
 
 #include <asm/text-patching.h>
 #include <asm/insn.h>
 #include <asm/ibt.h>
 #include <asm/set_memory.h>
 #include <asm/nmi.h>
+#include <asm/bugs.h>
 
 int __read_mostly alternatives_patched;
 
@@ -3468,4 +3471,132 @@ void its_free_all(struct module *mod)
 	its_page = NULL;
 }
 #endif
+static atomic_t thread_ack;
+
+/*
+ * This function is called by ALL online CPUs but only CPU0 will do the
+ * re-patching.  It is important that all other cores spin in the tight loop
+ * below (and not in multi_cpu_stop) because they cannot safely do return
+ * instructions while returns are being patched.  Therefore, spin them here
+ * (with interrupts disabled) until CPU0 has finished its work.
+ */
+static int __cpu_update_alternatives(void *__unused)
+{
+	if (smp_processor_id()) {
+		atomic_dec(&thread_ack);
+		while (!READ_ONCE(alternatives_patched))
+			cpu_relax();
+
+		cpu_bugs_update_speculation_msrs();
+	} else {
+		repatch_in_progress = true;
+
+		/* Wait for all cores to enter this function. */
+		while (atomic_read(&thread_ack))
+			cpu_relax();
+
+		/* These must be un-done in the opposite order in which they were applied. */
+		reset_alternatives(__alt_instructions, __alt_instructions_end, NULL);
+		reset_builtin_callthunks();
+		reset_returns(__return_sites, __return_sites_end, NULL);
+		reset_retpolines(__retpoline_sites, __retpoline_sites_end, NULL);
+
+		apply_retpolines(__retpoline_sites, __retpoline_sites_end, NULL);
+		apply_returns(__return_sites, __return_sites_end, NULL);
+		callthunks_patch_builtin_calls();
+		apply_alternatives(__alt_instructions, __alt_instructions_end, NULL);
+
+		update_all_static_calls(__start_static_call_sites,
+				__stop_static_call_sites, NULL);
+		modules_update_alternatives();
+		cpu_bugs_update_speculation_msrs();
+		repatch_in_progress = false;
+
+		/* This will wake the other CPUs. */
+		WRITE_ONCE(alternatives_patched, 1);
+	}
+	return 0;
+}
+
+void cpu_prepare_repatch_alternatives(void)
+{
+	alternatives_patched = 0;
+	/* Reset the synchronization barrier. */
+	atomic_set(&thread_ack, num_online_cpus() - 1);
+}
+
+static void make_all_text_writeable(void)
+{
+	unsigned long start = PFN_ALIGN(_text);
+	unsigned long end = PFN_ALIGN(_etext);
+
+	set_memory_rw(start, (end - start) >> PAGE_SHIFT);
+	modules_prepare_repatch();
+}
+
+static void make_all_text_readonly(void)
+{
+	unsigned long start = PFN_ALIGN(_text);
+	unsigned long end = PFN_ALIGN(_etext);
+
+	set_memory_ro(start, (end - start) >> PAGE_SHIFT);
+	modules_post_repatch();
+}
+
+void cpu_update_alternatives(void)
+{
+	/*
+	 * Re-patching is not supported under Xen PV because it uses MOV-CR2
+	 * for synchronization (see sync_core_nmi_safe()).
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_XENPV)) {
+		pr_err("Xen PV does not support dynamic mitigations!\n");
+		alternatives_patched = 1;
+		return;
+	}
+
+	pr_info("Re-patching alternatives\n");
+
+	/*
+	 * ITS mitigation requires dynamic memory allocation and changing memory
+	 * permissions.  These are not possible under NMI context.
+	 *
+	 * Therefore, pre-allocate ITS pages if needed.  If previous ITS pages
+	 * exist, those will be used instead.
+	 */
+	its_prealloc(__retpoline_sites, __retpoline_sites_end, NULL);
+	modules_pre_update_alternatives();
+
+	/*
+	 * Freeze everything because we cannot have a thread be in the middle of
+	 * something we're about to change when we issue stop_machine.
+	 *
+	 * Therefore, use the freezer to get all tasks to a safe place before we
+	 * re-patch.
+	 */
+	if (freeze_processes()) {
+		pr_err("Unable to freeze processes for re-patching!\n");
+		return;
+	}
+
+	if (freeze_kernel_threads()) {
+		pr_err("Unable to freeze tasks for re-patching!\n");
+		thaw_processes();
+		return;
+	}
+
+	make_all_text_writeable();
+	stop_machine_nmi(__cpu_update_alternatives, NULL, cpu_online_mask);
+	make_all_text_readonly();
+
+	cpu_bugs_smt_update();
+
+	/* Free un-needed ITS pages.  This cannot happen in NMI context. */
+	its_free_all(NULL);
+	modules_post_update_alternatives();
+
+	thaw_kernel_threads();
+	thaw_processes();
+	pr_info("Finished re-patching alternatives\n");
+}
 #endif
-- 
2.34.1


