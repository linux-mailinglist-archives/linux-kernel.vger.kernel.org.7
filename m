Return-Path: <linux-kernel+bounces-770327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6813B279B3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B34C2B62F3E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 07:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09292E54AC;
	Fri, 15 Aug 2025 07:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k1CXdkOr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2WeGBUwL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E923D2E5427
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 07:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755241555; cv=none; b=Pt8NEEQsC5c55Y3SAEM0LQqcxo1uRabHOg3G51wcaNH8PDPCGvMXXh2wgYwE4RKOQaAAzN+5fUSZbEAG8VcCX+N554Je+qoRVDscGKeEV1csBt/MUG1umP9lN4bvZ5E1Zkzrq6LFrJq6x4E1d0FYV4SeTxzyPdA3gk3Gog4BXJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755241555; c=relaxed/simple;
	bh=PyVA86oM4856fHuH2OtWGqH1muetJmQk14kCXYD++WU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OdvDTKasfAbZ9MnuoDQB/wxom0WPSoayQUVSCNhq4tai4D4h3IiHQwo5cJ8UGnyg3qu0yTffbqWtJ+zZ3Xgaj63+1ojAX7hWkJvQ/A5VCDKs3S0SATGTdvRhzUIMoEpBDGIQyebRyKpPVpmnh43ZXfJFRzbwaUR5j7/GhO/LQnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k1CXdkOr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2WeGBUwL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755241550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DLJZnVaOHIl4IgTzRd51CLt0DVovSUA9MzkReZhRy80=;
	b=k1CXdkOrtK3ZBfxD1O5AHSx81E9lRATGEqVSZ85lTcnBd5MwNd5c+I/5Zimz7qN5zi/u+g
	ZBc/GlfDfZLg7zNXN7+imV1prwxM/W0HdIAyCw9ZmYatOqS6pV/WBW/jUNeYOJFGaM9Hsq
	TY67Ir8HqFg3kRc2JGPIUpnXgZx6w3QAjVmQAuS2Xaa8pk6wZAE+MKpRbuJIkKDDwhjaRN
	6vdIl+/V74PK/chiVtpnVj7HP5jfwjVvotFEyvtYn9z/fOHxyJOTsdsPT4Pa5O3Ez78Jvc
	Q2va9wALnpTBpmKtu1dLtupLBOx2kM/sRCS4aZJ3BguLl0weaFb2IGTCzYSs3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755241550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DLJZnVaOHIl4IgTzRd51CLt0DVovSUA9MzkReZhRy80=;
	b=2WeGBUwLVoxoUP2VZbexRar+bhp1+dvohjEm9tL5ZrP4Tpq9eYrhobcNaBzII5WK2oIChk
	eY2JrZ/xBBam5JBw==
To: Borislav Petkov <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Sean Christopherson <seanjc@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sohil Mehta <sohil.mehta@intel.com>,
	John Ogness <john.ogness@linutronix.de>,
	x86@kernel.org,
	x86-cpuid@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v4 15/34] x86/cpuid: Introduce CPUID parser debugfs interface
Date: Fri, 15 Aug 2025 09:02:08 +0200
Message-ID: <20250815070227.19981-16-darwi@linutronix.de>
In-Reply-To: <20250815070227.19981-1-darwi@linutronix.de>
References: <20250815070227.19981-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce the debugfs files 'x86/cpuid/[0-ncpus]' to dump each CPU's
cached CPUID table.  For each cached CPUID leaf/subleaf, invoke the
CPUID instruction on the target CPU and compare the hardware result
against the cached values.

Mark any mismatched cached CPUID output value with an asterisk.  This
should help with tricky bug reports in the future, if/when the cached
CPUID tables get unexpectedly out of sync with actual hardware state.  It
also simplifies the development and testing of adding new CPUID leaves to
the CPUID parser.

Note, expose cpuid_parse_phases[] via "cpuid_parser.h" to allow the
debugfs code to traverse and dump the parsed CPUID data.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/kernel/cpu/Makefile        |   2 +-
 arch/x86/kernel/cpu/cpuid_debugfs.c | 108 ++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/cpuid_parser.c  |   9 ++-
 arch/x86/kernel/cpu/cpuid_parser.h  |  12 ++++
 4 files changed, 125 insertions(+), 6 deletions(-)
 create mode 100644 arch/x86/kernel/cpu/cpuid_debugfs.c

diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index b2421cfb59ed..4e032ad851c7 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -61,7 +61,7 @@ obj-$(CONFIG_X86_LOCAL_APIC)		+= perfctr-watchdog.o
 obj-$(CONFIG_HYPERVISOR_GUEST)		+= vmware.o hypervisor.o mshyperv.o
 obj-$(CONFIG_ACRN_GUEST)		+= acrn.o
 
-obj-$(CONFIG_DEBUG_FS)			+= debugfs.o
+obj-$(CONFIG_DEBUG_FS)			+= debugfs.o cpuid_debugfs.o
 
 obj-$(CONFIG_X86_BUS_LOCK_DETECT)	+= bus_lock.o
 
diff --git a/arch/x86/kernel/cpu/cpuid_debugfs.c b/arch/x86/kernel/cpu/cpuid_debugfs.c
new file mode 100644
index 000000000000..62aa92f7d226
--- /dev/null
+++ b/arch/x86/kernel/cpu/cpuid_debugfs.c
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * CPUID parser debugfs entries: x86/cpuid/[0-ncpus]
+ *
+ * Dump each CPU's cached CPUID table and compare its values against current
+ * CPUID output on that CPU.  Mark changed entries with an asterisk.
+ */
+
+#include <linux/debugfs.h>
+#include <linux/init.h>
+#include <linux/smp.h>
+#include <linux/types.h>
+
+#include <asm/cpuid/api.h>
+#include <asm/percpu.h>
+#include <asm/processor.h>
+
+#include "cpuid_parser.h"
+
+static void cpuid_this_cpu(void *info)
+{
+	struct cpuid_regs *regs = info;
+
+	__cpuid(&regs->eax, &regs->ebx, &regs->ecx, &regs->edx);
+}
+
+static void
+cpuid_show_leaf(struct seq_file *m, uintptr_t cpu_id, const struct cpuid_parse_entry *entry,
+		const struct leaf_query_info *info, const struct cpuid_regs *cached)
+{
+	for (int j = 0; j < info->nr_entries; j++) {
+		u32 subleaf = entry->subleaf + j;
+		struct cpuid_regs regs = {
+			.eax = entry->leaf,
+			.ecx = subleaf,
+		};
+		int ret;
+
+		seq_printf(m, "Leaf 0x%08x, subleaf %u:\n", entry->leaf, subleaf);
+
+		ret = smp_call_function_single(cpu_id, cpuid_this_cpu, &regs, true);
+		if (ret) {
+			seq_printf(m, "Failed to invoke CPUID on CPU %lu: %d\n\n", cpu_id, ret);
+			continue;
+		}
+
+		seq_printf(m, "  cached:   %cEAX=0x%08x   %cEBX=0x%08x   %cECX=0x%08x   %cEDX=0x%08x\n",
+			   cached[j].eax == regs.eax ? ' ' : '*', cached[j].eax,
+			   cached[j].ebx == regs.ebx ? ' ' : '*', cached[j].ebx,
+			   cached[j].ecx == regs.ecx ? ' ' : '*', cached[j].ecx,
+			   cached[j].edx == regs.edx ? ' ' : '*', cached[j].edx);
+		seq_printf(m, "  actual:    EAX=0x%08x    EBX=0x%08x    ECX=0x%08x    EDX=0x%08x\n",
+			   regs.eax, regs.ebx, regs.ecx, regs.edx);
+	}
+}
+
+static void __cpuid_debug_show(struct seq_file *m, uintptr_t cpu_id,
+			       const struct cpuid_parse_entry *entry, int nr_entries)
+{
+	const struct cpuinfo_x86 *c = per_cpu_ptr(&cpu_info, cpu_id);
+	const struct cpuid_table *t = &c->cpuid;
+
+	for (int i = 0; i < nr_entries; i++, entry++) {
+		const struct leaf_query_info *qi = cpuid_table_query_info_p(t, entry->info_offs);
+		const struct cpuid_regs *qr = cpuid_table_query_regs_p(t, entry->regs_offs);
+
+		cpuid_show_leaf(m, cpu_id, entry, qi, qr);
+	}
+}
+
+static int cpuid_debug_show(struct seq_file *m, void *p)
+{
+	uintptr_t cpu_id = (uintptr_t)m->private;
+
+	for (int i = 0; i < cpuid_parser_nphases; i++)
+		__cpuid_debug_show(m, cpu_id, cpuid_parser_phases[i].table, cpuid_parser_phases[i].nr_entries);
+
+	return 0;
+}
+
+static int cpuid_debug_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, cpuid_debug_show, inode->i_private);
+}
+
+static const struct file_operations cpuid_ops = {
+	.open		= cpuid_debug_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static __init int cpuid_init_debugfs(void)
+{
+	struct dentry *dir;
+	uintptr_t cpu_id;
+	char cpu_name[24];
+
+	dir = debugfs_create_dir("cpuid", arch_debugfs_dir);
+
+	for_each_possible_cpu(cpu_id) {
+		scnprintf(cpu_name, sizeof(cpu_name), "%lu", cpu_id);
+		debugfs_create_file(cpu_name, 0444, dir, (void *)cpu_id, &cpuid_ops);
+	}
+
+	return 0;
+}
+late_initcall(cpuid_init_debugfs);
diff --git a/arch/x86/kernel/cpu/cpuid_parser.c b/arch/x86/kernel/cpu/cpuid_parser.c
index 84d70a432212..3942ea2526f2 100644
--- a/arch/x86/kernel/cpu/cpuid_parser.c
+++ b/arch/x86/kernel/cpu/cpuid_parser.c
@@ -71,14 +71,13 @@ static const struct cpuid_parse_entry cpuid_common_parse_entries[] = {
 	CPUID_COMMON_PARSE_ENTRIES
 };
 
-static const struct {
-	const struct cpuid_parse_entry	*table;
-	int				nr_entries;
-} cpuid_parser_phases[] = {
+const struct cpuid_parser_phase cpuid_parser_phases[] = {
 	{ cpuid_early_parse_entries,	ARRAY_SIZE(cpuid_early_parse_entries)	},
 	{ cpuid_common_parse_entries,	ARRAY_SIZE(cpuid_common_parse_entries)	},
 };
 
+const int cpuid_parser_nphases = ARRAY_SIZE(cpuid_parser_phases);
+
 /*
  * Leaf-independent parser code:
  */
@@ -157,7 +156,7 @@ cpuid_fill_table(struct cpuid_table *t, const struct cpuid_parse_entry entries[]
 
 static void __cpuid_parser_scan_cpu(struct cpuinfo_x86 *c, bool early_boot)
 {
-	int nphases = early_boot ? 1 : ARRAY_SIZE(cpuid_parser_phases);
+	int nphases = early_boot ? 1 : cpuid_parser_nphases;
 	struct cpuid_table *table = &c->cpuid;
 
 	/*
diff --git a/arch/x86/kernel/cpu/cpuid_parser.h b/arch/x86/kernel/cpu/cpuid_parser.h
index 5d7a05e4b9cd..1be5c323d5eb 100644
--- a/arch/x86/kernel/cpu/cpuid_parser.h
+++ b/arch/x86/kernel/cpu/cpuid_parser.h
@@ -129,6 +129,18 @@ struct cpuid_parse_entry {
 	/*		  Leaf		Subleaf		Reader function */		\
 	CPUID_PARSE_ENTRY(0x80000000,	0,		0x80000000),			\
 
+/*
+ * CPUID parser tables repository:
+ */
+
+struct cpuid_parser_phase {
+	const struct cpuid_parse_entry	*table;
+	int				nr_entries;
+};
+
+extern const struct cpuid_parser_phase cpuid_parser_phases[];
+extern const int cpuid_parser_nphases;
+
 /*
  * CPUID leaf vendor table:
  */
-- 
2.50.1


