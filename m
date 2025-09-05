Return-Path: <linux-kernel+bounces-802832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF9BB45782
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB75FA47423
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1376334DCED;
	Fri,  5 Sep 2025 12:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ongHyHb2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cwrAr7vY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816E234A333
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 12:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757074548; cv=none; b=KUCnUnPNI6Nge33XxfVxDpumICO7egGUpsW1nofCkH5BKOMqeN3peXLkWtuui1NKt4hpNTYlb1NMIyzvJLfE4mc55qHStrEabdNJoUaTOGflfj+0RU6EY3lWZDgchCMP93vasBIcPi+o0DVhuaJishL0gzWwqtIhmS3rqO1dFlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757074548; c=relaxed/simple;
	bh=UT2k8xPnlzdweRIzqWkKlHLzoKnY64KahQOkpWodKLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uFy+RovoAusLmZ2xc0cbQkSSmuqZQFrYoIPT/Ag2ZH7vHdQHwcnxtC7uIX67bvc16dgMKdrqwu3X8heSsG/q7yWW5ZQSkOhwVAuHwN5toGTgOWFqzvEjAj2tXGNbYi3msEF9jZ1SWhs9yDToF8cnq7v0CzUZENHBxJg9R4xntcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ongHyHb2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cwrAr7vY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757074545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+9CmVpsEmD7IM8i/kOsBRaO429i2Fexcqa0TnN+USBI=;
	b=ongHyHb2aeylN2vXFtqrFjrOeJevSOx4UeEK3hicKzTVSjtoOGjH0SMFnwu9CTQTGWPy/i
	rpURUoY3/3bcx5PgEsyYUfBAhH/VcEUfF9jdBacKzgsyvKBxU5UIAbkGrWfultJQMP6+Uf
	s/jPGcJofJek3Q5KDu8nrF1o9zxwoJsJIWalTvHzdnzITvCu28EPRyPHRpNnh1gboQRWTV
	h6LzhR5u1M/AUK9KJXwZ5WyUGm+JwXRcfts+kmqlDqkWz9ijN8O81bHAo0MePo9pZmWCKt
	1yiW6aC7u0lHliBRVM0Ypi54xa9OAG+YkDAnOUhObY7nINZ+ZVkx+x124+Gf+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757074545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+9CmVpsEmD7IM8i/kOsBRaO429i2Fexcqa0TnN+USBI=;
	b=cwrAr7vYeWxJoKqqT/MbPslOGdtIZzxzngKXURT7bSiBkSAXi1pxYZZ47nqwiU7djf7Sln
	J9gIdww6KpKolICA==
To: Borislav Petkov <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Sean Christopherson <seanjc@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sohil Mehta <sohil.mehta@intel.com>,
	John Ogness <john.ogness@linutronix.de>,
	x86@kernel.org,
	x86-cpuid@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v5 08/35] x86/cpuid: Introduce a centralized CPUID parser
Date: Fri,  5 Sep 2025 14:14:48 +0200
Message-ID: <20250905121515.192792-9-darwi@linutronix.de>
In-Reply-To: <20250905121515.192792-1-darwi@linutronix.de>
References: <20250905121515.192792-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a centralized CPUID parser to populate the per-CPU CPUID
tables.  To ensures consistent and early availablity of parsed CPUID
data, invoke this parser during both early boot and secondary CPUs bring
up.

Since accessing the CPUID leaf output storage areas at 'struct
cpuid_table' requires compile time tokenization, split the parser
implementation into two stages: compile time macros for tokenizing the
leaf/subleaf output offsets within a CPUID table, and generic runtime
code to access and populate the relevant CPUID leaf/subleaf data
structures using such offsets.

For flexible parsing of CPUID leaf/subleaf outputs, support both generic
and leaf-specific CPUID read functions.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/include/asm/cpuid/api.h   |  17 +++-
 arch/x86/include/asm/cpuid/types.h |   3 +
 arch/x86/kernel/cpu/Makefile       |   1 +
 arch/x86/kernel/cpu/common.c       |   2 +
 arch/x86/kernel/cpu/cpuid_parser.c | 123 +++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/cpuid_parser.h | 115 +++++++++++++++++++++++++++
 6 files changed, 257 insertions(+), 4 deletions(-)
 create mode 100644 arch/x86/kernel/cpu/cpuid_parser.c
 create mode 100644 arch/x86/kernel/cpu/cpuid_parser.h

diff --git a/arch/x86/include/asm/cpuid/api.h b/arch/x86/include/asm/cpuid/api.h
index dbe94c8c4900..7b7951b28105 100644
--- a/arch/x86/include/asm/cpuid/api.h
+++ b/arch/x86/include/asm/cpuid/api.h
@@ -5,8 +5,10 @@
 #include <asm/cpuid/types.h>
 
 #include <linux/build_bug.h>
+#include <linux/init.h>
 #include <linux/types.h>
 
+#include <asm/processor.h>
 #include <asm/string.h>
 
 /*
@@ -483,14 +485,14 @@ static inline bool cpuid_amd_hygon_has_l3_cache(void)
 	cpuid_subleaf(_cpuinfo, _leaf, 0)
 
 /**
- * cpuid_leaf_regs() - Access parsed CPUID data in raw format
+ * cpuid_leaf_raw() - Access parsed CPUID data in raw format
  * @_cpuinfo:	CPU capability structure reference ('struct cpuinfo_x86')
  * @_leaf:	CPUID leaf, in compile-time 0xN format
  *
  * Similar to cpuid_leaf(), but returns a raw 'struct cpuid_regs' pointer to
  * the parsed CPUID data instead of a "typed" <asm/cpuid/leaf_types.h> pointer.
  */
-#define cpuid_leaf_regs(_cpuinfo, _leaf)					\
+#define cpuid_leaf_raw(_cpuinfo, _leaf)					\
 	((const struct cpuid_regs *)(cpuid_leaf(_cpuinfo, _leaf)))
 
 /*
@@ -534,7 +536,7 @@ static inline bool cpuid_amd_hygon_has_l3_cache(void)
 })
 
 /**
- * cpuid_subleaf_n_regs() - Access parsed CPUID data for leaf with dynamic subleaf range
+ * cpuid_subleaf_n_raw() - Access parsed CPUID data for leaf with dynamic subleaf range
  * @_cpuinfo:	CPU capability structure reference ('struct cpuinfo_x86')
  * @_leaf:	CPUID leaf, in compile-time 0xN format; e.g. 0x4, 0x8000001d
  * @_subleaf:	Subleaf number, which can be passed dynamically.  It must be smaller
@@ -543,7 +545,7 @@ static inline bool cpuid_amd_hygon_has_l3_cache(void)
  * Similar to cpuid_subleaf_n(), but returns a raw 'struct cpuid_regs' pointer to
  * the parsed CPUID data instead of a "typed" <asm/cpuid/leaf_types.h> pointer.
  */
-#define cpuid_subleaf_n_regs(_cpuinfo, _leaf, _subleaf)				\
+#define cpuid_subleaf_n_raw(_cpuinfo, _leaf, _subleaf)				\
 	((const struct cpuid_regs *)cpuid_subleaf_n(_cpuinfo, _leaf, _subleaf))
 
 /**
@@ -562,4 +564,11 @@ static inline bool cpuid_amd_hygon_has_l3_cache(void)
 	__cpuid_table_nr_filled_subleaves(&(_cpuinfo)->cpuid, _leaf, n);	\
 })
 
+/*
+ * CPUID parser exported APIs:
+ */
+
+void __init cpuid_parser_early_scan_cpu(struct cpuinfo_x86 *c);
+void cpuid_parser_scan_cpu(struct cpuinfo_x86 *c);
+
 #endif /* _ASM_X86_CPUID_API_H */
diff --git a/arch/x86/include/asm/cpuid/types.h b/arch/x86/include/asm/cpuid/types.h
index bd6e016ef035..9b8bd6b22ff3 100644
--- a/arch/x86/include/asm/cpuid/types.h
+++ b/arch/x86/include/asm/cpuid/types.h
@@ -32,6 +32,9 @@ enum cpuid_regs_idx {
 #define CPUID_LEAF_FREQ		0x16
 #define CPUID_LEAF_TILE		0x1d
 
+#define CPUID_BASE_START	0x0
+#define CPUID_BASE_END		(CPUID_BASE_START + 0xffff)
+
 /*
  * Types for CPUID(0x2) parsing:
  */
diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index 1e26179ff18c..b2421cfb59ed 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -19,6 +19,7 @@ KCSAN_SANITIZE_common.o := n
 
 obj-y			:= cacheinfo.o scattered.o
 obj-y			+= topology_common.o topology_ext.o topology_amd.o
+obj-y			+= cpuid_parser.o
 obj-y			+= common.o
 obj-y			+= rdrand.o
 obj-y			+= match.o
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 34a054181c4d..43582d7e167d 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1729,6 +1729,7 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 
 	/* cyrix could have cpuid enabled via c_identify()*/
 	if (cpuid_feature()) {
+		cpuid_parser_scan_cpu(c);
 		cpu_detect(c);
 		get_cpu_vendor(c);
 		intel_unlock_cpuid_leafs(c);
@@ -2109,6 +2110,7 @@ void identify_secondary_cpu(unsigned int cpu)
 		*c = boot_cpu_data;
 	c->cpu_index = cpu;
 
+	cpuid_parser_scan_cpu(c);
 	identify_cpu(c);
 #ifdef CONFIG_X86_32
 	enable_sep_cpu();
diff --git a/arch/x86/kernel/cpu/cpuid_parser.c b/arch/x86/kernel/cpu/cpuid_parser.c
new file mode 100644
index 000000000000..15264696eaad
--- /dev/null
+++ b/arch/x86/kernel/cpu/cpuid_parser.c
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Centralized CPUID parser (for populating the system's CPUID tables.)
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+
+#include <asm/cpuid/api.h>
+#include <asm/percpu.h>
+#include <asm/processor.h>
+
+#include "cpuid_parser.h"
+
+/*
+ * Leaf read functions:
+ */
+
+/*
+ * Default CPUID parser read function
+ *
+ * Satisfies the requirements stated at 'struct cpuid_parse_entry'->read().
+ */
+static void cpuid_read_generic(const struct cpuid_parse_entry *e, struct cpuid_read_output *output)
+{
+	for (int i = 0; i < e->maxcnt; i++, output->regs++, output->info->nr_entries++)
+		cpuid_read_subleaf(e->leaf, e->subleaf + i, output->regs);
+}
+
+/*
+ * CPUID parser tables:
+ *
+ * Since these tables reference the leaf read functions above, they must be
+ * defined afterwards.
+ */
+
+static const struct cpuid_parse_entry cpuid_parse_entries[] = {
+	CPUID_PARSE_ENTRIES
+};
+
+/*
+ * Leaf-independent parser code:
+ */
+
+static unsigned int cpuid_range_max_leaf(const struct cpuid_table *t, unsigned int range)
+{
+	const struct leaf_0x0_0 *l0 = __cpuid_table_subleaf(t, 0x0, 0);
+
+	switch (range) {
+	case CPUID_BASE_START:	return l0  ?  l0->max_std_leaf : 0;
+	default:		return 0;
+	}
+}
+
+static bool
+cpuid_range_valid(const struct cpuid_table *t, unsigned int leaf, unsigned int start, unsigned int end)
+{
+	if (leaf < start || leaf > end)
+		return false;
+
+	return leaf == start || leaf <= cpuid_range_max_leaf(t, start);
+}
+
+static bool cpuid_leaf_in_range(const struct cpuid_table *t, unsigned int leaf)
+{
+	return cpuid_range_valid(t, leaf, CPUID_BASE_START, CPUID_BASE_END);
+}
+
+static void
+cpuid_fill_table(struct cpuid_table *t, const struct cpuid_parse_entry entries[], unsigned int nr_entries)
+{
+	const struct cpuid_parse_entry *entry = entries;
+
+	for (unsigned int i = 0; i < nr_entries; i++, entry++) {
+		struct cpuid_read_output output = {
+			.regs	= cpuid_table_query_regs_p(t, entry->regs_offs),
+			.info	= cpuid_table_query_info_p(t, entry->info_offs),
+		};
+
+		if (!cpuid_leaf_in_range(t, entry->leaf))
+			continue;
+
+		WARN_ON_ONCE(output.info->nr_entries != 0);
+		entry->read(entry, &output);
+	}
+}
+
+/*
+ * Exported APIs:
+ */
+
+/**
+ * cpuid_parser_scan_cpu() - Populate current CPU's CPUID table
+ * @c:		CPU capability structure associated with the current CPU
+ *
+ * Populate the CPUID table embedded within @c with parsed CPUID data.  Since all CPUID
+ * instructions are invoked locally, this must be called on the CPU associated with @c.
+ */
+void cpuid_parser_scan_cpu(struct cpuinfo_x86 *c)
+{
+	struct cpuid_table *table = &c->cpuid;
+
+	/*
+	 * For correctness, clear the CPUID table first.
+	 *
+	 * This is due to the CPUID parser APIs at <asm/cpuid/api.h> using leaf->nr_entries
+	 * as a leaf validity check: non-zero means that the CPUID leaf's cached output is
+	 * valid.  Otherwise, NULL is returned.
+	 *
+	 * For the primary CPU's early boot code, the tables are already zeroed.  For
+	 * secondary CPUs though, their capability structures (containing the CPUID table)
+	 * are copied from the primary CPU.  This would result in a leaf->nr_entries value
+	 * carry over, unless the table is zeroed first.
+	 *
+	 * Also for CPUID table re-scans, which are triggered by hardware state changes,
+	 * previously valid CPUID leaves can become no longer available and thus no longer
+	 * parsed (leaving stale leaf "nr_entries" fields behind.)  The table must thus be
+	 * also cleared.
+	 */
+	memset(table, 0, sizeof(*table));
+
+	cpuid_fill_table(table, cpuid_parse_entries, ARRAY_SIZE(cpuid_parse_entries));
+}
diff --git a/arch/x86/kernel/cpu/cpuid_parser.h b/arch/x86/kernel/cpu/cpuid_parser.h
new file mode 100644
index 000000000000..acddcbc9bd06
--- /dev/null
+++ b/arch/x86/kernel/cpu/cpuid_parser.h
@@ -0,0 +1,115 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ARCH_X86_CPUID_PARSER_H
+#define _ARCH_X86_CPUID_PARSER_H
+
+#include <asm/cpuid/types.h>
+
+/*
+ * 'struct cpuid_leaves' CPUID query output storage area accessors:
+ *
+ * @_leaf:	CPUID leaf, in compile-time 0xN format
+ * @_subleaf:	CPUID subleaf, in compile-time decimal format
+ *
+ * Since accessing the CPUID leaf output storage areas at 'struct cpuid_leaves' requires
+ * compile time tokenization, split the CPUID parser implementation into two stages:
+ * compile time macros for tokenizing the leaf/subleaf output offsets within the CPUID
+ * table, and generic runtime code to access and populate the relevant CPUID leaf/subleaf
+ * output data structures using such offsets.
+ *
+ * That is, the output of the  __cpuid_leaves_query_*_offset() macros will be cached by a
+ * compile time "parse entry" (see 'struct cpuid_parse_entry').  The runtime parser code
+ * will then utilize such offsets by passing them to cpuid_table_query_*_p() functions.
+ */
+
+#define __cpuid_leaves_query_regs_offset(_leaf, _subleaf)			\
+	offsetof(struct cpuid_leaves, leaf_ ## _leaf ## _ ## _subleaf)
+
+#define __cpuid_leaves_query_info_offset(_leaf, _subleaf)			\
+	offsetof(struct cpuid_leaves, leaf_ ## _leaf ## _ ## _subleaf ## _ ## info)
+
+#define __cpuid_leaves_query_regs_maxcnt(_leaf, _subleaf)			\
+	ARRAY_SIZE(((struct cpuid_leaves *)NULL)->leaf_ ## _leaf ## _ ## _subleaf)
+
+static inline struct cpuid_regs *
+cpuid_table_query_regs_p(const struct cpuid_table *t, unsigned long regs_offset)
+{
+	return (struct cpuid_regs *)((unsigned long)(&t->leaves) + regs_offset);
+}
+
+static inline struct leaf_query_info *
+cpuid_table_query_info_p(const struct cpuid_table *t, unsigned long info_offset)
+{
+	return (struct leaf_query_info *)((unsigned long)(&t->leaves) + info_offset);
+}
+
+/**
+ * struct cpuid_read_output - Output of a CPUID parser read operation
+ * @regs:	Pointer to an array of CPUID outputs, where each array element covers the
+ *		full EAX->EDX output range.
+ * @info:	Pointer to query info; for saving the number of filled @regs array elements.
+ *
+ * A CPUID parser read function like cpuid_read_generic() or cpuid_read_0xN() uses this
+ * structure to save its CPUID query outputs.  Actual storage for @regs and @info is provided
+ * by its caller, and is typically within a CPU's CPUID table (struct cpuid_table.leaves).
+ *
+ * See struct cpuid_parse_entry.read().
+ */
+struct cpuid_read_output {
+	struct cpuid_regs	*regs;
+	struct leaf_query_info	*info;
+};
+
+/**
+ * struct cpuid_parse_entry - Runtime CPUID parsing context for @leaf/@subleaf
+ * @leaf:	Leaf number to be parsed
+ * @subleaf:	Subleaf number to be parsed
+ * @regs_offs:	Offset within 'struct cpuid_leaves' for saving CPUID @leaf/@subleaf output; to be
+ *		passed to cpuid_table_query_regs_p().
+ * @info_offs:	Offset within 'struct cpuid_leaves' for accessing @leaf/@subleaf parse info; to be
+ *		passed to cpuid_table_query_info_p().
+ * @maxcnt:	Maximum number of output storage entries available for the @leaf/@subleaf query
+ * @read:	Read function for this entry.  It must save the parsed CPUID output to the passed
+ *		'struct cpuid_read_output'->regs registers array of size >= @maxcnt.  It must set
+ *		'struct cpuid_read_output'->info.nr_entries to the actual number of storage output
+ *		entries filled.  A generic implementation is provided at cpuid_read_generic().
+ */
+struct cpuid_parse_entry {
+	unsigned int	leaf;
+	unsigned int	subleaf;
+	unsigned int	regs_offs;
+	unsigned int	info_offs;
+	unsigned int	maxcnt;
+	void		(*read)(const struct cpuid_parse_entry *e, struct cpuid_read_output *o);
+};
+
+#define __CPUID_PARSE_ENTRY(_leaf, _subleaf, _suffix, _reader_fn)			\
+	{										\
+		.leaf		= _leaf,						\
+		.subleaf	= _subleaf,						\
+		.regs_offs	= __cpuid_leaves_query_regs_offset(_leaf, _suffix),	\
+		.info_offs	= __cpuid_leaves_query_info_offset(_leaf, _suffix),	\
+		.maxcnt		= __cpuid_leaves_query_regs_maxcnt(_leaf, _suffix),	\
+		.read		= cpuid_read_ ## _reader_fn,				\
+	}
+
+/*
+ * CPUID_PARSE_ENTRY_N() is for CPUID leaves with a dynamic subleaf range.
+ * Check <asm/cpuid/types.h> __CPUID_LEAF() and CPUID_LEAF_N().
+ */
+
+#define CPUID_PARSE_ENTRY(_leaf, _subleaf, _reader_fn)					\
+	__CPUID_PARSE_ENTRY(_leaf, _subleaf, _subleaf, _reader_fn)
+
+#define CPUID_PARSE_ENTRY_N(_leaf, _reader_fn)						\
+	__CPUID_PARSE_ENTRY(_leaf, __cpuid_leaf_first_dynamic_subleaf(_leaf), n, _reader_fn)
+
+/*
+ * CPUID parser tables:
+ */
+
+#define CPUID_PARSE_ENTRIES									\
+	/*			Leaf		Subleaf		Reader function */		\
+	CPUID_PARSE_ENTRY   (	0x0,		0,		generic			),	\
+	CPUID_PARSE_ENTRY   (	0x1,		0,		generic			),	\
+
+#endif /* _ARCH_X86_CPUID_PARSER_H */
-- 
2.50.1


