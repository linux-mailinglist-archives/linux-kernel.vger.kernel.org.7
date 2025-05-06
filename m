Return-Path: <linux-kernel+bounces-635194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 859CFAABA7A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 09:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 510F8507E6C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 07:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD84245008;
	Tue,  6 May 2025 05:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Sqpt+Hl7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5Bq4IfE8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B07B244678
	for <linux-kernel@vger.kernel.org>; Tue,  6 May 2025 05:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746507903; cv=none; b=YPVRIm4FkQ93fyLXN+Lw9mwpjo8kaOWv7FIC9osyiFRzTQNdJAdJ0Jxd+6yF4b3O/Se4isrP/RbZD2xzNRhMACzsBB9/n8+2SdEakCaHA6BNZy17A34CHYvdY90eH7pLFv26bhiI9GruGrB4fdFBEbvvD2vMsQOngO0zNzpSzFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746507903; c=relaxed/simple;
	bh=ku7agXtCwJK2QkTOHSB5HnQNjs/5/7ibtQKL8k43CVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vw6tzHs9oIiwgh7Gstzmt2tF/taFLvVtY39szXFVYHp9U3Vtge/Wd1xSfnDZRlXN6VYL3bSl/VxBiYP5Wihz/rLMdKFymC1P/8W5oM0DphHmEK5VVoozxLx7XDFvcamCLh0xE6l7DiRT2kMYS6A0ri/OdHmZK4rM2cd23vLYB9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Sqpt+Hl7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5Bq4IfE8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746507900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eVRFHQebq3GssJx7+6LeDQQroMEGLf7iHEUQbu2ovnM=;
	b=Sqpt+Hl7i8Ej9s4zFPY+O0NMB1z1MLiP4zYTIUovHsgUry/a/7bqJbj1tBc6iIebeVAM7s
	nVgwLuEgHdQbTEK4McL8DSkNEKp7FLPpQ60SC9y0/dXAya+csDjdVnvUsT/6QSq/TXOcPG
	EoG3QFtUiBAvkEV0DogFfMZBNWCsjyzfuhaIBcOFf99fAZOcu6sO1/gWujU3L/D+VVcaSs
	DRJbGvmcSPG2HX0i2+m9wexBzqONIGlQZsOqS+LJmquA1Lvu2JqsADWXB3Jq0JO3qduBL1
	gC4g0H5EcpZqGNetwea4wGfaWi/FFuxaNfu7ORVNti4SVlsYwv8kqefaXagCUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746507900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eVRFHQebq3GssJx7+6LeDQQroMEGLf7iHEUQbu2ovnM=;
	b=5Bq4IfE8+n+IqOtX77eK5V+dOzA/ORQzRkOervnFnqeOgri8POj3OArC74n7ltunnOUAWv
	aspUnMEMk1DypBBQ==
To: Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	John Ogness <john.ogness@linutronix.de>,
	x86@kernel.org,
	x86-cpuid@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v1 04/26] x86/cpuid: Introduce centralized CPUID data
Date: Tue,  6 May 2025 07:04:15 +0200
Message-ID: <20250506050437.10264-5-darwi@linutronix.de>
In-Reply-To: <20250506050437.10264-1-darwi@linutronix.de>
References: <20250506050437.10264-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define the CPUID_LEAF() macro for building up centralized CPUID data.
It automates defining a CPUID data repository in the form:

    struct cpuid_leaves {
	struct leaf_0x0_0	leaf_0x0_0[1];
	struct leaf_query_info	leaf_0x0_0_info;
	struct leaf_0x1_0	leaf_0x1_0[1];
	struct leaf_query_info	leaf_0x0_0_info;

	struct leaf_0x4_0	leaf_0x4_0[8];
	struct leaf_query_info	leaf_0x4_0_info;
	...
    };

where for each 'struct leaf_0xN_M', N is the leaf number and M is the
subleaf.

The complete C99 bitfield listings of the 'leaf_0xN_M' structures is auto
generated by the x86-cpuid-db project and is merged in parent commits at
<asm/cpuid/leaves.h>.  This avoids using ugly bitwise operations on CPUID
register output.

Let the CPUID_LEAF() macro generate an array of output storage entries
for each leaf/subleaf combination.  An array is used to accommodate
leaves which produce the same output format for a large subleaf range,
which is typical for CPUID leaves enumerating hierarchical objects;
e.g. leaf 0x4 cache topology enumeration, leaf 0xd XSAVE enumeration, and
leaf 0x12 SGX Enclave Page Cache enumeration.  In the CPUID table snippet
above, leaf 0x4 has 8 storage entries.

For each of the leaf/subleaf entries in the CPUID table, attach a
'leaf_query_info' leaf_0xN_M_info structure.  It is to be filled by the
generic scanning logic filling the CPUID table.  For now, that info
structure has one element: the number of filled slots in the leaf/subleaf
storage array.

Define 'struct cpuid_table' for representing the actual CPUID table, and
embed in it a 'struct cpuid_leaves' instance.  This way, global table
data can be later added.

Embed an instance of that 'struct cpuid_table' in the CPU capability
structure 'struct cpuinfo_x86'.  This way, centralized CPUID data can be
accessed on early boot (through boot_cpu_data) and later on a per-CPU
basis through the 'cpu_info' per-CPU capability structures.  Since
multiple code paths dealing with 'struct cpuinfo_x86' assume that it has
no embedded pointers, embedding the cpuid_table instance avoids creating
special cases for no apparent benefit.

Define entries for leaf 0x0 and leaf 0x1 in the CPUID table.  Next
commits will add generic scanning logic for filling the CPUID data.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/include/asm/cpuid/internal_api.h | 62 +++++++++++++++++++++++
 arch/x86/include/asm/cpuid/types.h        | 61 ++++++++++++++++++++++
 arch/x86/include/asm/processor.h          |  1 +
 3 files changed, 124 insertions(+)
 create mode 100644 arch/x86/include/asm/cpuid/internal_api.h

diff --git a/arch/x86/include/asm/cpuid/internal_api.h b/arch/x86/include/asm/cpuid/internal_api.h
new file mode 100644
index 000000000000..a1321ed19679
--- /dev/null
+++ b/arch/x86/include/asm/cpuid/internal_api.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_CPUID_INTERNAL_API_H
+#define _ASM_X86_CPUID_INTERNAL_API_H
+
+/*
+ * Raw 'struct cpuid_leaves' accessors
+ */
+
+#include <asm/cpuid/types.h>
+
+/**
+ * __cpuid_get() - Get scanned CPUID output (without sanity checks)
+ * @_leaves:	&struct cpuid_leaves instance
+ * @_leaf:	Leaf number in the 0xN format
+ * @_subleaf:	Subleaf number in decimal
+ * @_idx:	@_leaf/@_subleaf query output storage index
+ *
+ * Return the scanned CPUID output in a ready to parse <cpuid/leaves.h> type:
+ * struct leaf_0xN_M, where 0xN is the token provided at @_leaf, and M is the
+ * token provided at @_subleaf.
+ */
+#define __cpuid_get(__leaves, __leaf, __subleaf, __idx)			\
+	((__leaves)->leaf_ ## __leaf ## _ ## __subleaf)[__idx]
+
+/**
+ * __cpuid_info_get() - Get @_leaf/@_subleaf CPUID query info
+ * @_leaves:	&struct cpuid_leaves instance
+ * @_leaf:	Leaf number in the 0xN format
+ * @_subleaf:	Subleaf number in decimal
+ *
+ * Return @_leaves repository scanned @_leaf/@_subleaf CPUID query info, as
+ * &struct leaf_query_info.
+ */
+#define __cpuid_info_get(__leaves, __leaf, __subleaf)			\
+	((__leaves)->leaf_ ## __leaf ## _ ## __subleaf ## _ ## info)
+
+/**
+ * cpuid_get() - Get scanned CPUID output (without sanity checks)
+ * @_leaves:	&struct cpuid_leaves instance
+ * @_leaf:	Leaf number in the 0xN format
+ *
+ * Like __cpuid_get(), but with the subleaf and output storage index assumed
+ * as zero.
+ */
+#define cpuid_get(_leaves, _leaf)					\
+	__cpuid_get(_leaves, _leaf, 0, 0)
+
+/*
+ * struct cpuid_table accessors (with sanity checks)
+ *
+ * Return requested data as a <cpuid/leaves.h> data type, or NULL if the
+ * entry is not available.
+ */
+
+#define __cpudata_cpuid_subleaf_idx(__table, __leaf, __subleaf, __idx)	\
+	((__cpuid_info_get(&((__table)->leaves), __leaf, __subleaf).nr_entries > __idx) ? \
+	 &__cpuid_get(&((__table)->leaves), __leaf, __subleaf, __idx) : NULL)
+
+#define __cpudata_cpuid_subleaf(__table, __leaf, __subleaf)		\
+	__cpudata_cpuid_subleaf_idx(__table, __leaf, __subleaf, 0)
+
+#endif /* _ASM_X86_CPUID_INTERNAL_API_H */
diff --git a/arch/x86/include/asm/cpuid/types.h b/arch/x86/include/asm/cpuid/types.h
index c95fee66e148..df115a8440bc 100644
--- a/arch/x86/include/asm/cpuid/types.h
+++ b/arch/x86/include/asm/cpuid/types.h
@@ -5,6 +5,8 @@
 #include <linux/build_bug.h>
 #include <linux/types.h>
 
+#include <asm/cpuid/leaves.h>
+
 /*
  * Types for raw CPUID access:
  */
@@ -125,4 +127,63 @@ extern const struct leaf_0x2_table cpuid_0x2_table[256];
  */
 #define TLB_0x63_2M_4M_ENTRIES		32
 
+/*
+ * Types for centralized CPUID tables:
+ */
+
+/**
+ * struct leaf_query_info - Info for a CPUID leaf/subleaf query
+ * @nr_entries:	Number of filled entries by the CPUID scanner for leaf/subleaf
+ *
+ * Each leaf/subleaf entry in a CPUID table (struct cpuid_leaves) has this
+ * dedicated query info.
+ */
+struct leaf_query_info {
+	unsigned int		nr_entries;
+};
+
+/**
+ * __CPUID_LEAF() - Define CPUID storage entries as <cpuid/leaves.h> structures
+ * @_name:	leaf_0xN_M structure name and type as found in <cpuid/leaves.h>,
+ *		where N is the leaf and M is the subleaf.
+ * @_count:	Max storage capacity for the combined leaf/subleaf @_name entry
+ *
+ * Define an array of storage entries for each leaf/subleaf combination.
+ * Use an array to accommodate leaves which produce the same output format
+ * for a large subleaf range, which is common for hierarchical objects
+ * enumeration; e.g., leaf 0x4, 0xd, and 0x12.
+ */
+#define __CPUID_LEAF(_name, _count)				\
+	struct _name		_name[_count];			\
+	struct leaf_query_info	_name ## _ ## info
+
+/**
+ * CPUID_LEAF() - Define CPUID storage entries for @_leaf/@_subleaf
+ * @_leaf:	Leaf number in the 0xN format
+ * @_subleaf:	Subleaf number in decimal
+ * @_count:	Number of repeated storage entries for @_leaf/@_subleaf
+ */
+#define CPUID_LEAF(_leaf, _subleaf, _count)			\
+	__CPUID_LEAF(leaf_ ## _leaf ## _ ## _subleaf, _count)
+
+/*
+ * struct cpuid_leaves - CPUID leaf/subleaf output storage
+ */
+struct cpuid_leaves {
+	/*         leaf		subleaf		count */
+	CPUID_LEAF(0x0,		0,		1);
+	CPUID_LEAF(0x1,		0,		1);
+};
+
+/**
+ * struct cpuid_table - System CPUID data table
+ * @leaves:	Leaf/subleaf output storage space
+ *
+ * struct cpuinfo_x86 embeds an instance of this table so that CPUID
+ * data can be extracted using a CPU capability structure reference.
+ */
+struct cpuid_table {
+	struct cpuid_leaves	leaves;
+};
+
 #endif /* _ASM_X86_CPUID_TYPES_H */
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 5d2f7e5aff26..df85dab402b8 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -165,6 +165,7 @@ struct cpuinfo_x86 {
 	char			x86_vendor_id[16];
 	char			x86_model_id[64];
 	struct cpuinfo_topology	topo;
+	struct cpuid_table	cpuid_table;
 	/* in KB - valid for CPUS which support this call: */
 	unsigned int		x86_cache_size;
 	int			x86_cache_alignment;	/* In bytes */
-- 
2.49.0


