Return-Path: <linux-kernel+bounces-802831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9528DB45781
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 696D77C4AD4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C339E34DCEF;
	Fri,  5 Sep 2025 12:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tGsK9NcW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="drrTUPEo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B234334DCEA
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 12:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757074546; cv=none; b=T2kwat8PzQsh6mte59fywSCeP3gAOQ6xf/9ux1GV+muanqLVrU+/YY6lelykt47Le3neTUqnLIBaT7F7zepLRapLtDokiogzY9+gjwVZGqg+DA+KtnA7Njpx6bOR5HOuYO/rcO4tR1Yfu8ggP0KDVkOaT1T/WywzTtg++7lKmEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757074546; c=relaxed/simple;
	bh=nVzmx+VBFMAIeK1xZkch6zN41rKSSM7fSfVwTKYfqmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OHL+rAN8LNXkkTlePQ5GCJ6T4xkncky+Foyf98YYq4QDZ1j3dAb+IaWtwXfihryU7d7aQFjTfm1dPYXr4zhLRv32oI6XfwU42ExhuhkKEP4K6xlPXNewBbT3lLkTzkKLcWjoaY27JIxspmD3QxMItHrL9PH9CqEm2gtxE+xMD7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tGsK9NcW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=drrTUPEo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757074542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PL+ILi/B3wQ4riPW8csosjR4rJ3qnOvXyB/TuLz+BUk=;
	b=tGsK9NcWqsQ1DpPm8Rf85bOUvwQ41FVRXgexE/tb/o0bKqs2p1XvxEnVQ5ezOu2TaB06Fz
	7KVXww2yYZ3Q9czmfJ/M0280sxk7ZH/T6QdiWkFPL6OSgg43uXGF2RbR4zh5uJG/76Z736
	fQucvg9gCqlXMZftT1q2IGTAuCbErwvXZnB6eZkDupFW0ZgnUeTyX/tfOqn9KSkpOgbun6
	HIPZ3QJGGDVWLh7vTwc5NwbRud9/Pfi3YvfYVJIPltRlEOOGAGCjg2NJKwVRNyTeI8zoHM
	5HPH2wjTe1nxnetcB1yqFrtrJpk/SSBeePQVrFAF7WDNjR1ksWRHHYTmcO4tWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757074542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PL+ILi/B3wQ4riPW8csosjR4rJ3qnOvXyB/TuLz+BUk=;
	b=drrTUPEoIH/SyYafrTY3IOp+lQ6+ug7Kgk48XLNlflZFwha3l7oKiHQE75GnfYm24BhAVn
	xJThLTA1C5X/jzBg==
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
Subject: [PATCH v5 07/35] x86: Introduce a centralized CPUID data model
Date: Fri,  5 Sep 2025 14:14:47 +0200
Message-ID: <20250905121515.192792-8-darwi@linutronix.de>
In-Reply-To: <20250905121515.192792-1-darwi@linutronix.de>
References: <20250905121515.192792-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

** Context

The x86-cpuid-db project generates a C header file with full C99 bitfield
listings for all known CPUID leaf/subleaf query outputs.

That header is now merged by parent commits at <asm/cpuid/leaf_types.h>,
and is in the form:

    struct leaf_0x0_0 { /* CPUID(0x0).0 C99 bitfields */ };
    ...
    struct leaf_0x4_n { /* CPUID(0x4).n C99 bitfields */ };
    ...
    struct leaf_0xd_0 { /* CPUID(0xd).0 C99 bitfields */ };
    struct leaf_0xd_1 { /* CPUID(0xd).1 C99 bitfields */ };
    struct leaf_0xd_n { /* CPUID(0xd).n C99 bitfields */ };
    ...

** Goal

Introduce a structured, size-efficient, per-CPU, CPUID data repository.

Use the x86-cpuid-db auto-generated data types, and custom CPUID leaf
parsers, to build that repository.  Given a leaf, subleaf, and index,
provide direct memory access to the parsed and cached per-CPU CPUID
output.

** Long-term goal

Remove the need for drivers and other areas in the kernel to invoke
direct CPUID queries.  Only one place in the kernel should be allowed to
use the CPUID instruction: the CPUID parser code.

** Implementation

Introduce CPUID_LEAF()/CPUID_LEAF_N() to build a compact CPUID storage
layout in the form:

    struct leaf_0x0_0		leaf_0x0_0[1];
    struct leaf_query_info	leaf_0x0_0_info;

    struct leaf_0x1_0		leaf_0x1_0[1];
    struct leaf_query_info	leaf_0x0_0_info;

    struct leaf_0x4_n		leaf_0x4_n[8];
    struct leaf_query_info	leaf_0x4_n_info;
    ...

where each CPUID query stores its output at the designated leaf/subleaf
array and has an associated "CPUID query info" structure.

Introduce 'struct cpuid_leaves' to group all the parsed CPUID outputs and
their metadata –in the layout above– in one structure.  Define a 'struct
cpuid_table' to wrap it, so that global per-table CPUID data can be added
later.  Embed 'struct cpuid_table' inside 'struct cpuinfo_x86' to ensure
early-boot and per-CPU access through the CPU(s) capability structures.

Given the data layout above, and assuming a CPU capability structure 'c',
a macro can access CPUID(0x7) subleaf 0 parsed query output using the
compile-time tokenization below:

    const struct leaf_0x7_0 *l7_0;

    l7_0 = cpuid_subleaf(c, 0x7, 0);
                         |   |   └────────┐
                         |   └─────────┐  |
                         *             *  *
                        &c.cpuid.leaf_0x7_0[0]

Similarly, CPUID(0x7) subleaf 1 output can be accessed using the CPP
tokenization:

    const struct leaf_0x7_1 *l7_1;

    l7_1 = cpuid_subleaf(c, 0x7, 1);
                         |   |   └────────┐
                         |   └─────────┐  |
                         *             *  *
                        &c.cpuid.leaf_0x7_1[0]

which all translate to a single assembly instruction offset calculation.

Use an array of CPUID output storage entries for each leaf/subleaf
combination to accommodate leaves which produce the same output format
for a large subleaf range.  This is typical for CPUID leaves enumerating
hierarchical objects; e.g. CPUID(0x4) cache topology enumeration,
CPUID(0xd) XSAVE enumeration, and CPUID(0x12) SGX Enclave Page Cache
enumeration.

In the CPUID table layout above, CPUID(0x4) has 8 storage entries to
accomodate suleaves 0 to 7, which all have the same bitfield's output
format.  With that, CPUID(0x4) can be accessed using the compile time
tokenization:

    const struct leaf_0x4_n *l4_0, *l4_1, l4_2;

    l4_0 = cpuid_subleaf_n(c, 0x4, 0);
                           |   |   └──────────┐
                           |   └─────────┐    |
                           *             *    v
                          &c.cpuid.leaf_0x4_n[0]

    l4_1 = cpuid_subleaf_n(c, 0x4, 1);
                           |   |   └──────────┐
                           |   └─────────┐    |
                           *             *    v
                          &c.cpuid.leaf_0x4_n[1]

    l4_2 = cpuid_subleaf_n(c, 0x4, 2);
                           |   |   └──────────┐
                           |   └─────────┐    |
                           *             *    v
                          &c.cpuid.leaf_0x4_n[2]

where dynamic leaf types are marked by their "_n" suffix and the indices
0, 1, 2 above can be passed dynamically.  This is by design: hierarchical
CPUID enumeration usually passes the CPUID subleaf dynamically; e.g.,
within a for loop.

For each of the CPUID leaf/subleaf output storage entries, attach a
'struct leaf_query_info' instance.  It is to be set by the CPUID parser
while filling the CPUID tables.  For now, this info structure has one
element: the number of filled slots at the respective output storage
array.

** Call-site APIs

Introduce below APIs for CPUID leaves with static subleaves:

    cpuid_leaf(_cpuinfo, _leaf)
    cpuid_leaf_raw(_cpuinfo, _leaf)
    cpuid_subleaf(_cpuinfo, _leaf, _subleaf)

and below APIs for CPUID leaves with dynamic subleaves:

    cpuid_subleaf_n(_cpuinfo, _leaf, _idx)
    cpuid_subleaf_n_raw(_cpuinfo, _leaf, _idx)
    cpuid_subleaf_count(_cpuinfo, _leaf)

At <asm/cpuid/api.h>, add a clear rationale for why call sites should use
the above APIs instead of directly invoking CPUID queries.

** Next steps

For now, define entries for CPUID(0x0) and CPUID(0x1) in the CPUID table.

Generic CPUID parser logic to fill the CPUID tables, along with more
CPUID leaves support, will be added next.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>	# CPUID data model
Suggested-by: Andrew Cooper <andrew.cooper3@citrix.com>	# x86-cpuid-db schema
Suggested-by: Borislav Petkov <bp@alien8.de>		# Early CPUID centralization drafts
Suggested-by: Ingo Molnar <mingo@kernel.org>		# CPUID APIs restructuring
Suggested-by: Sean Christopherson <seanjc@google.com>	# Dynamic leaves CPUID API
Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Link: https://lore.kernel.org/lkml/874ixernra.ffs@tglx
Link: https://gitlab.com/x86-cpuid.org/x86-cpuid-db
Link: https://lore.kernel.org/lkml/aBnSgu_JyEi8fvog@gmail.com
Link: https://lore.kernel.org/lkml/aJ9TbaNMgaplKSbH@google.com
---
 arch/x86/include/asm/cpuid/api.h   | 273 +++++++++++++++++++++++++++++
 arch/x86/include/asm/cpuid/types.h | 125 +++++++++++++
 arch/x86/include/asm/processor.h   |   2 +
 3 files changed, 400 insertions(+)

diff --git a/arch/x86/include/asm/cpuid/api.h b/arch/x86/include/asm/cpuid/api.h
index 2b9750cc8a75..dbe94c8c4900 100644
--- a/arch/x86/include/asm/cpuid/api.h
+++ b/arch/x86/include/asm/cpuid/api.h
@@ -289,4 +289,277 @@ static inline bool cpuid_amd_hygon_has_l3_cache(void)
 	return cpuid_edx(0x80000006);
 }
 
+/*
+ * 'struct cpuid_leaves' accessors (without sanity checks):
+ *
+ * For internal use by the CPUID parser.
+ */
+
+/*
+ * Return constified pointers for all call-site APIs
+ */
+#define __const_ptr(_ptr)							\
+	((const __typeof__(*(_ptr)) *)(_ptr))
+
+/*
+ * __cpuid_leaves_subleaf() - Get parsed CPUID output (without sanity checks)
+ * @_leaves:	&struct cpuid_leaves instance
+ * @_leaf:	CPUID leaf, in compile-time 0xN format
+ * @_subleaf:	CPUID subleaf, in compile-time decimal format
+ */
+#define __cpuid_leaves_subleaf(_leaves, _leaf, _subleaf)			\
+	__const_ptr(&((_leaves)->leaf_ ## _leaf ## _ ## _subleaf)[0])
+
+/*
+ * __cpuid_leaves_subleaf_n() - Get parsed CPUID output for dynamic subleaf (without checks)
+ * @_leaves:	&struct cpuid_leaves instance
+ * @_leaf:	CPUID leaf, in compile-time 0xN format
+ * @_index:	Index within the dynamic subleaf storage array
+ */
+#define __cpuid_leaves_subleaf_n(_leaves, _leaf, _index)			\
+	__const_ptr(&((_leaves)->leaf_ ## _leaf ## _ ## n)[_index])
+
+/*
+ * __cpuid_leaves_subleaf_info() - Get CPUID query info for @_leaf/@_subleaf
+ * @_leaves:	&struct cpuid_leaves instance
+ * @_leaf:	CPUID leaf, in compile-time 0xN format
+ * @_subleaf:	CPUID subleaf, in compile-time decimal format, or just 'n' for
+ *		leaves with a dynamic subleaf range.
+ */
+#define __cpuid_leaves_subleaf_info(_leaves, _leaf, _subleaf)			\
+	__const_ptr(&((_leaves)->leaf_ ## _leaf ## _ ## _subleaf ## _ ## info))
+
+/*
+ * 'struct cpuid_table' accessors (with sanity checks):
+ *
+ * For internal use by the CPUID parser.
+ */
+
+#define __cpuid_table_nr_filled_subleaves(_table, _leaf, _subleaf)				\
+	__cpuid_leaves_subleaf_info(&((_table)->leaves), _leaf, _subleaf)->nr_entries
+
+#define __cpuid_table_dynamic_subleaf_storage(_table, _leaf)					\
+	ARRAY_SIZE((_table)->leaves.leaf_ ## _leaf ## _n)
+
+#define __cpuid_table_invalid_dynamic_subleaf(_table, _leaf, _subleaf)				\
+	(((_subleaf) < (__cpuid_leaf_first_dynamic_subleaf(_leaf))) ||				\
+	 ((_subleaf) > (__cpuid_leaf_first_dynamic_subleaf(_leaf) +				\
+			__cpuid_table_dynamic_subleaf_storage(_table, _leaf) - 1)))
+
+/*
+ * __cpuid_table_subleaf() - Get parsed CPUID output (with sanity checks)
+ * @_table:	&struct cpuid_table instance
+ * @_leaf:	CPUID leaf, in compile-time 0xN format
+ * @_subleaf:	CPUID subleaf, in compile-time decimal format
+ *
+ * A return of NULL implies that the CPUID parser did not fill that leaf.  This
+ * can happen due to the conditions listed at cpuid_leaf().
+ */
+#define __cpuid_table_subleaf(_table, _leaf, _subleaf)						\
+({												\
+	unsigned int ____f = __cpuid_table_nr_filled_subleaves(_table, _leaf, _subleaf);	\
+												\
+	/* CPUID parser fills exactly one entry for static leaves */				\
+	(____f != 1) ? NULL : __cpuid_leaves_subleaf(&((_table)->leaves), _leaf, _subleaf);	\
+})
+
+/*
+ * __cpuid_table_subleaf_n() - Get parsed CPUID output (with sanity checks)
+ * @_table:	&struct cpuid_table instance
+ * @_leaf:	CPUID leaf, in compile-time 0xN format
+ * @_subleaf:	CPUID subleaf, which can be given dynamically
+ *
+ * A return of NULL implies that the CPUID parser did not fill this leaf, or that
+ * the given dynamic subleaf value is out of range.  Check cpuid_subleaf_n().
+ */
+#define __cpuid_table_subleaf_n(_table, _leaf, _subleaf)					\
+({												\
+	unsigned int ____i = (_subleaf) - __cpuid_leaf_first_dynamic_subleaf(_leaf);		\
+	unsigned int ____f = __cpuid_table_nr_filled_subleaves(_table, _leaf, n);		\
+												\
+	/* CPUID parser might not have filled the entire dynamic subleaf range */		\
+	((____i >= ____f) || __cpuid_table_invalid_dynamic_subleaf(_table, _leaf, _subleaf)) ?	\
+		NULL : __cpuid_leaves_subleaf_n(&((_table)->leaves), _leaf, ____i);		\
+})
+
+/*
+ * Compile-time checks for leaves with a dynamic subleaf range:
+ */
+
+#define __cpuid_assert_dynamic_subleaves(_cpuinfo, _leaf)					\
+	static_assert(__cpuid_table_dynamic_subleaf_storage(&(_cpuinfo)->cpuid, _leaf) > 1)
+
+#define __cpuid_assert_dynamic_subleaf_range(_cpuinfo, _leaf, _subleaf)				\
+	BUILD_BUG_ON(__builtin_constant_p(_subleaf) &&						\
+		     __cpuid_table_invalid_dynamic_subleaf(&(_cpuinfo)->cpuid, _leaf, _subleaf))
+
+/*
+ *                     CPUID Parser Call-site APIs
+ *
+ * Call sites should use below APIs instead of invoking direct CPUID queries.
+ *
+ * Benefits include:
+ *
+ * - Return CPUID output as typed C structures that are auto-generated from a
+ *   centralized database (see <asm/cpuid/leaf_types.h).  Such data types have a
+ *   full C99 bitfield layout per CPUID leaf/subleaf combination.  Call sites
+ *   can thus avoid doing ugly and cryptic bitwise operations on raw CPUID data.
+ *
+ * - Return cached, per-CPU, CPUID output.  Below APIs do not invoke any CPUID
+ *   queries, thus avoiding their side effects like serialization and VM exits.
+ *   Call-site-specific hard coded constants and macros for caching CPUID query
+ *   outputs can also be avoided.
+ *
+ * - Return sanitized CPUID data.  Below APIs return NULL if the given CPUID
+ *   leaf/subleaf input is not supported by hardware, or if the hardware CPUID
+ *   output was deemed invalid by the CPUID parser.  This centralizes all CPUID
+ *   data sanitization in one place (the kernel's CPUID parser.)
+ *
+ * - A centralized global view of system CPUID data.  Below APIs will reflect
+ *   any kernel-enforced feature masking or overrides, unlike ad hoc parsing of
+ *   raw CPUID output by drivers and individual call sites.
+ */
+
+/*
+ * Call-site APIs for CPUID leaves with a static subleaf:
+ */
+
+/**
+ * cpuid_subleaf() - Access parsed CPUID
+ * @_cpuinfo:	CPU capability structure reference ('struct cpuinfo_x86')
+ * @_leaf:	CPUID leaf, in compile-time 0xN format; e.g. 0x7, 0xf
+ * @_subleaf:	CPUID subleaf, in compile-time decimal format; e.g. 0, 1, 3
+ *
+ * Returns a pointer to parsed CPUID output, from the CPUID table inside
+ * @_cpuinfo, as a <cpuid/leaf_types.h> data type: 'struct leaf_0xM_N', where
+ * 0xM is the token provided at @_leaf, and N is the token provided at
+ * @_subleaf; e.g. struct leaf_0x7_0.
+ *
+ * Returns NULL if the requested CPUID @_leaf/@_subleaf query output is not
+ * present at the parsed CPUID table inside @_cpuinfo.  This can happen if:
+ *
+ * - The CPUID table inside @_cpuinfo has not yet been populated.
+ * - The CPUID table inside @_cpuinfo was populated, but the CPU does not
+ *   implement the requested CPUID @_leaf/@_subleaf combination.
+ * - The CPUID table inside @_cpuinfo was populated, but the kernel's CPUID
+ *   parser has predetermined that the requested CPUID @_leaf/@_subleaf
+ *   hardware output is invalid or unsupported.
+ *
+ * Example usage::
+ *
+ *	const struct leaf_0x7_0 *l7_0 = cpuid_subleaf(c, 0x7, 0);
+ *	if (!l7_0) {
+ *		// Handle error
+ *	}
+ *
+ *	const struct leaf_0x7_1 *l7_1 = cpuid_subleaf(c, 0x7, 1);
+ *	if (!l7_1) {
+ *		// Handle error
+ *	}
+ */
+#define cpuid_subleaf(_cpuinfo, _leaf, _subleaf)				\
+	__cpuid_table_subleaf(&(_cpuinfo)->cpuid, _leaf, _subleaf)		\
+
+/**
+ * cpuid_leaf() - Access parsed CPUID data
+ * @_cpuinfo:	CPU capability structure reference ('struct cpuinfo_x86')
+ * @_leaf:	CPUID leaf, in compile-time 0xN format; e.g. 0x0, 0x2, 0x80000000
+ *
+ * Similar to cpuid_subleaf(), but with a CPUID subleaf = 0.
+ *
+ * Example usage::
+ *
+ *	const struct leaf_0x0_0 *l0 = cpuid_leaf(c, 0x0);
+ *	if (!l0) {
+ *		// Handle error
+ *	}
+ *
+ *	const struct leaf_0x80000000_0 *el0 = cpuid_leaf(c, 0x80000000);
+ *	if (!el0) {
+ *		// Handle error
+ *	}
+ */
+#define cpuid_leaf(_cpuinfo, _leaf)						\
+	cpuid_subleaf(_cpuinfo, _leaf, 0)
+
+/**
+ * cpuid_leaf_regs() - Access parsed CPUID data in raw format
+ * @_cpuinfo:	CPU capability structure reference ('struct cpuinfo_x86')
+ * @_leaf:	CPUID leaf, in compile-time 0xN format
+ *
+ * Similar to cpuid_leaf(), but returns a raw 'struct cpuid_regs' pointer to
+ * the parsed CPUID data instead of a "typed" <asm/cpuid/leaf_types.h> pointer.
+ */
+#define cpuid_leaf_regs(_cpuinfo, _leaf)					\
+	((const struct cpuid_regs *)(cpuid_leaf(_cpuinfo, _leaf)))
+
+/*
+ * Call-site APIs for leaves with a dynamic subleaf range:
+ */
+
+/**
+ * cpuid_subleaf_n() - Access parsed CPUID data for leaf with dynamic subleaf range
+ * @_cpuinfo:	CPU capability structure reference ('struct cpuinfo_x86')
+ * @_leaf:	CPUID leaf, in compile-time 0xN format; e.g. 0x4, 0x8000001d
+ * @_subleaf:	Subleaf number, which can be passed dynamically.  It must be smaller
+ *		than cpuid_subleaf_count(@_cpuinfo, @_leaf).
+ *
+ * Build-time errors will be emitted in the following cases:
+ *
+ * - @_leaf has no dynamic subleaf range.  Dynamic leaves have an '_n' data type
+ *   suffix and are listed at <asm/cpuid/types.h> using the CPUID_LEAF_N() macro.
+ *
+ * - @_subleaf is known at compile-time but is out of range.
+ *
+ * Example usage::
+ *
+ *	const struct leaf_0x4_n *l4;
+ *
+ *	for (int i = 0; i < cpuid_subleaf_count(c, 0x4); i++) {
+ *		l4 = cpuid_subleaf_n(c, 0x4, i);
+ *		if (!l4) {
+ *			// Handle error
+ *		}
+ *		...
+ *	}
+ *
+ * Beside the standard error situations detailed at cpuid_subleaf(), this
+ * macro will also return NULL if @_subleaf is out of runtime range.
+ */
+#define cpuid_subleaf_n(_cpuinfo, _leaf, _subleaf)				\
+({										\
+	__cpuid_assert_dynamic_subleaves(_cpuinfo, _leaf);			\
+	__cpuid_assert_dynamic_subleaf_range(_cpuinfo, _leaf, _subleaf);	\
+	__cpuid_table_subleaf_n(&(_cpuinfo)->cpuid, _leaf, _subleaf);		\
+})
+
+/**
+ * cpuid_subleaf_n_regs() - Access parsed CPUID data for leaf with dynamic subleaf range
+ * @_cpuinfo:	CPU capability structure reference ('struct cpuinfo_x86')
+ * @_leaf:	CPUID leaf, in compile-time 0xN format; e.g. 0x4, 0x8000001d
+ * @_subleaf:	Subleaf number, which can be passed dynamically.  It must be smaller
+ *		than cpuid_subleaf_count(@_cpuinfo, @_leaf).
+ *
+ * Similar to cpuid_subleaf_n(), but returns a raw 'struct cpuid_regs' pointer to
+ * the parsed CPUID data instead of a "typed" <asm/cpuid/leaf_types.h> pointer.
+ */
+#define cpuid_subleaf_n_regs(_cpuinfo, _leaf, _subleaf)				\
+	((const struct cpuid_regs *)cpuid_subleaf_n(_cpuinfo, _leaf, _subleaf))
+
+/**
+ * cpuid_subleaf_count() - Number of filled subleaves for dynamic @_leaf
+ * @_cpuinfo:	CPU capability structure reference ('struct cpuinfo_x86')
+ * @_leaf:	CPUID leaf, in compile-time 0xN format; e.g. 0x4, 0x8000001d
+ *
+ * Return the number of dynamic subleaves filled by the CPUID parser for @_leaf.
+ *
+ * @_leaf must have a dynamic subleaf range.  Dynamic leaves have an '_n' type
+ * suffix and are listed at <asm/cpuid/types.h> using the CPUID_LEAF_N() macro.
+ */
+#define cpuid_subleaf_count(_cpuinfo, _leaf)					\
+({										\
+	__cpuid_assert_dynamic_subleaves(_cpuinfo, _leaf);			\
+	__cpuid_table_nr_filled_subleaves(&(_cpuinfo)->cpuid, _leaf, n);	\
+})
+
 #endif /* _ASM_X86_CPUID_API_H */
diff --git a/arch/x86/include/asm/cpuid/types.h b/arch/x86/include/asm/cpuid/types.h
index 8a00364b79de..bd6e016ef035 100644
--- a/arch/x86/include/asm/cpuid/types.h
+++ b/arch/x86/include/asm/cpuid/types.h
@@ -5,6 +5,8 @@
 #include <linux/build_bug.h>
 #include <linux/types.h>
 
+#include <asm/cpuid/leaf_types.h>
+
 /*
  * Types for raw CPUID access:
  */
@@ -124,4 +126,127 @@ extern const struct leaf_0x2_table cpuid_0x2_table[256];
  */
 #define TLB_0x63_2M_4M_ENTRIES		32
 
+/*
+ * Types for centralized CPUID tables:
+ *
+ * For internal use by the CPUID parser.
+ */
+
+/**
+ * struct leaf_query_info - Parse info for a CPUID leaf/subleaf query
+ * @nr_entries:	Number of valid output storage entries filled by the CPUID parser
+ *
+ * In a CPUID table (struct cpuid_leaves), each CPUID leaf/subleaf query output
+ * storage entry from <cpuid/leaf_types.h> is paired with a unique instance of
+ * this type.
+ */
+struct leaf_query_info {
+	unsigned int		nr_entries;
+};
+
+/**
+ * __CPUID_LEAF() - Define a CPUID output storage and query info entry
+ * @_name:	Struct type name of the CPUID leaf/subleaf (e.g. 'leaf_0x7_0'). Such
+ *		types are defined at <cpuid/leaf_types.h> and follow the leaf_0xM_N
+ *		format, where 0xM is the leaf and N is the subleaf.  If N is 'n' instead
+ *		of a decimal literal, then this storage entry is for a "dynamic" leaf.
+ * @_count:	Number of storage entries to allocate for this leaf/subleaf.  Static
+ *		leaves need only one entry, while dynamic leaves require more.
+ *
+ * For the given leaf/subleaf combination, define an array of CPUID output storage
+ * entries and an associated query info structure — both residing at a
+ * 'struct cpuid_leaves' instance.
+ *
+ * Use an array of storage entries to accommodate "dynamic" CPUID leaves. Such leaves
+ * have the same subleaf output format for a large subleaf range.  This is common for
+ * hierarchical enumeration; e.g., CPUID(0x4), CPUID(0x12), and CPUID(0x8000001d).
+ *
+ * The example invocation::
+ *
+ *	__CPUID_LEAF(leaf_0x7_0, 1);
+ *	__CPUID_LEAF(leaf_0x7_1, 1);
+ *
+ * generates 'struct cpuid_leaves' storage entries in the form::
+ *
+ *	struct leaf_0x7_0		leaf_0x7_0[1];
+ *	struct leaf_query_info		leaf_0x7_0_info;
+ *
+ *	struct leaf_0x7_1		leaf_0x7_1[1];
+ *	struct leaf_query_info		leaf_0x7_1_info;
+ *
+ * While the example invocation for CPUID(0x4) storage::
+ *
+ *	__CPUID_LEAF(leaf_0x4_n, 8);
+ *
+ * generates storage entries in the form::
+ *
+ *	struct leaf_0x4_n		leaf_0x4_n[8];
+ *	struct leaf_query_info		leaf_0x4_n_info;
+ *
+ * where the 'leaf_0x4_n[8]' storage array can accommodate the output of CPUID(0x4)
+ * subleaves 0 -> 7, since they all have the same output format.
+ */
+#define __CPUID_LEAF(_name, _count)				\
+	struct _name		_name[_count];			\
+	struct leaf_query_info	_name##_info
+
+/**
+ * CPUID_LEAF() - Define a 'struct cpuid_leaves' storage entry for static leaf
+ * @_leaf:	Leaf number, in compile-time 0xN format
+ * @_subleaf:	Subleaf number, in compile-time decimal format
+ *
+ * Convenience wrapper around __CPUID_LEAF().
+ */
+#define CPUID_LEAF(_leaf, _subleaf)				\
+	__CPUID_LEAF(leaf_ ## _leaf ## _ ## _subleaf, 1)
+
+#define __cpuid_leaf_first_dynamic_subleaf(_l)			\
+	LEAF_ ## _l ## _ ## SUBLEAF_N_FIRST
+#define __cpuid_leaf_last_dynamic_subleaf(_l)			\
+	LEAF_ ## _l ## _ ## SUBLEAF_N_LAST
+
+#define __cpuid_leaf_subleaf_count_min(_l)			2
+#define __cpuid_leaf_subleaf_count_max(_l)			\
+	(__cpuid_leaf_last_dynamic_subleaf(_l) - __cpuid_leaf_first_dynamic_subleaf(_l) + 1)
+
+/**
+ * CPUID_LEAF_N() - Define a 'struct cpuid_leaves' storage entry for dynamic leaf
+ * @_leaf:	Leaf number, in compile-time 0xN format
+ * @_count:	Number of storage entries to allocate for that leaf with dynamic subleaf
+ *		range.  It must not exceed the limits defined at <cpuid/leaf_types.h>.
+ *
+ * Convenience wrapper around __CPUID_LEAF().
+ */
+#define CPUID_LEAF_N(_leaf, _count)					\
+	static_assert(_count >= __cpuid_leaf_subleaf_count_min(_leaf));	\
+	static_assert(_count <= __cpuid_leaf_subleaf_count_max(_leaf));	\
+	__CPUID_LEAF(leaf_ ## _leaf ## _ ## n, _count)
+
+/*
+ * struct cpuid_leaves - Structured CPUID data repository
+ */
+struct cpuid_leaves {
+	/*		Leaf		Subleaf number (or max number of dynamic subleaves) */
+	CPUID_LEAF   (	0x0,		0  );
+	CPUID_LEAF   (	0x1,		0  );
+};
+
+/*
+ * Types for centralized CPUID tables:
+ *
+ * For external use.
+ */
+
+/**
+ * struct cpuid_table - Per-CPU CPUID data repository
+ * @leaves:	CPUID leaf/subleaf queries output storage and metadata
+ *
+ * This is to be embedded inside 'struct cpuinfo_x86' to provide cached, parsed, and
+ * sanitized CPUID query output per CPU.  Thus removing the need for direct CPUID
+ * queries from call sites code.
+ */
+struct cpuid_table {
+	struct cpuid_leaves	leaves;
+};
+
 #endif /* _ASM_X86_CPUID_TYPES_H */
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 910e36b0c00d..88f8ee33bfca 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -16,6 +16,7 @@ struct vm86;
 #include <uapi/asm/sigcontext.h>
 #include <asm/current.h>
 #include <asm/cpufeatures.h>
+#include <asm/cpuid/types.h>
 #include <asm/page.h>
 #include <asm/pgtable_types.h>
 #include <asm/percpu.h>
@@ -164,6 +165,7 @@ struct cpuinfo_x86 {
 	char			x86_vendor_id[16];
 	char			x86_model_id[64];
 	struct cpuinfo_topology	topo;
+	struct cpuid_table	cpuid;
 	/* in KB - valid for CPUS which support this call: */
 	unsigned int		x86_cache_size;
 	int			x86_cache_alignment;	/* In bytes */
-- 
2.50.1


