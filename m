Return-Path: <linux-kernel+bounces-802841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94339B45784
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 346FC1C87160
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EDC353352;
	Fri,  5 Sep 2025 12:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gD3T2kL4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gY+x5cOU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C966A352FE4
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 12:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757074573; cv=none; b=qDQ4sQJa05ZAmjeRxHZSyK7u1O2aVtiuY1Dxb6ofuGmBUs3PVrLP49QcF6Pr5jOP2PJMI2n/4CVG7OQHtJTZwez5WFH2w5GxSmAnA0bCGyNKpEdNTp/xHcUvs/dofMWW8RQNobF7O2a16s/RVsTFLsW640HJsSWcrYag2Q7ZFKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757074573; c=relaxed/simple;
	bh=URUnSTDb5haa4fYYLd6+D3Jje7Qu7hOkj6v/yO7YtOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p5z+DbLt1RLK5dQelnYEr9CfSbmNGXOsU3OBPiw7LxTMbC1J0MOV2Kxb8hTfdujY/wUfmqn5M4rszbh9aam0ezKvG7OUOIfIo9VcKoq3kDhJh++zx6VKYysvDhQwBqG1F0Hu2XqndAx3GmGMYrQn6c0MIKZD4B1UyOodeg/OmmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gD3T2kL4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gY+x5cOU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757074570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uY6TErsVte9LDQFAFTRgaU7CERMqfx2fDXfyQukGbhM=;
	b=gD3T2kL4mnfnVcLc7Hz2eMJFIXHACWglBsg2Qgy/lDxhB4MdL7/wVGbsBNRyUaiQTF+4k+
	x3qrJmQyAVpelNI5sMy9CDoh9ZDRHCWZn8UctWoY83VS7fOqtsuVjvGNq7BHIBaYriFkNJ
	Go1t19nSNE7yiKa9VXZCn0oeEJ6rsggzmQtKVmYPGI6Xq7wqq9bhmigOE3lYdw5xeXiI2N
	iJqnP1XpblaIhAzZZ6WPGm5VIicjnVzidp6gv6p0RxQ6adpPCf653Ss1j2mlsmT4a5d0RM
	zh7Gvn2dyDFjpYE+Clr7a4xUdkuWXUp1QW9zkxWMYKmm6E2PSyqI8Pk8heEklQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757074570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uY6TErsVte9LDQFAFTRgaU7CERMqfx2fDXfyQukGbhM=;
	b=gY+x5cOU6K71WUKjUn9xQtOvfcx+A3WcBKozqax7z5uKv0BsbCo+ztRj3UE4Q4drmpGYSE
	962NVrj+Sgpgh1BQ==
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
Subject: [PATCH v5 16/35] x86/cpuid: Introduce a parser leaf x86 vendor table
Date: Fri,  5 Sep 2025 14:14:56 +0200
Message-ID: <20250905121515.192792-17-darwi@linutronix.de>
In-Reply-To: <20250905121515.192792-1-darwi@linutronix.de>
References: <20250905121515.192792-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For the CPUID parser, introduce a table listing vendor-specific CPUID
leaves. Not all CPUID leaves should be queried on all x86 vendors, so the
parser will only enumerate such leaves if the boot machine's x86 vendor
is listed as supported.

This provides the following benefits:

  (a) Even when a CPUID leaf falls within the CPU's standard or extended
  maximum leaf range, querying architecturally unsupported and reserved
  CPUID leaves may trigger new kernel boot behaviors or subtle bugs,
  especially on legacy machines.

  (b) Associating x86 vendor information with CPUID leaves will enable
  the CPUID parser to emit (lightweight) error messages when malformed
  CPUID leaf output is detected.  This is due to the parser now being
  more certain that the queried leaf is valid on the machine.

  (c) Attaching x86 vendor information to CPUID leaves will relieve
  call-sites, especially drivers, from ugly x86 vendor checks before
  querying a CPUID leaf.  If the CPUID parsers API like cpuid_leaf() or
  cpuid_subleaf() return NULL, it willy simply implies the leaf is
  simply unavailable (or should not be queried) on the current machine.

Split the CPUID parsing table into an "early boot" table and a standard
one.  The early boot phase parses only CPUID(0x0) and CPUID(0x1), where
they will be needed to identify the CPU's x86 vendor.

Once the kernel saves the vendor info to the CPU's capability structure,
invoke the CPUID parser again to parse the rest of the CPUID leaves.  In
that second phase, the parser assumes that "boot_cpu_data.x86_vendor" is
valid and uses it for CPUID leaf x86 vendor validity checks.

For each vendor-specific CPUID leaf, build its list of matching x86
vendors using CPP varargs.  Encoding this as bitflags was not doable,
since the x86 vendor IDs are just raw monotonic numbers from 0 (Intel) to
11 (Vortex).

Keep the CPUID parser's vendor-specific leaf table empty for now.  Leaves
like CPUID(0x2), CPUID(0x4), CPUID(0x16), and CPUID(0x8000001d) will be
added to the vendor table once their support is actually added to the
parser.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/kernel/cpu/common.c       |   3 +-
 arch/x86/kernel/cpu/cpuid_parser.c | 100 +++++++++++++++++++++++++----
 arch/x86/kernel/cpu/cpuid_parser.h |  50 ++++++++++++++-
 3 files changed, 138 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 1d45dbdd0e05..b439f7cd0931 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1728,9 +1728,10 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 
 	/* cyrix could have cpuid enabled via c_identify()*/
 	if (cpuid_feature()) {
-		cpuid_parser_scan_cpu(c);
+		cpuid_parser_early_scan_cpu(c);
 		cpu_detect(c);
 		get_cpu_vendor(c);
+		cpuid_parser_scan_cpu(c);
 		intel_unlock_cpuid_leafs(c);
 		get_cpu_cap(c);
 		setup_force_cpu_cap(X86_FEATURE_CPUID);
diff --git a/arch/x86/kernel/cpu/cpuid_parser.c b/arch/x86/kernel/cpu/cpuid_parser.c
index 9c40c180e3d4..df73fd9286b8 100644
--- a/arch/x86/kernel/cpu/cpuid_parser.c
+++ b/arch/x86/kernel/cpu/cpuid_parser.c
@@ -12,6 +12,10 @@
 
 #include "cpuid_parser.h"
 
+static const struct cpuid_vendor_entry cpuid_vendor_entries[] = {
+	CPUID_VENDOR_ENTRIES
+};
+
 /*
  * Leaf read functions:
  */
@@ -49,10 +53,24 @@ static void cpuid_read_0x80000000(const struct cpuid_parse_entry *e, struct cpui
  *
  * Since these tables reference the leaf read functions above, they must be
  * defined afterwards.
+ *
+ * At early boot, only leaves at CPUID_EARLY_PARSE_ENTRIES should be parsed.
  */
 
-static const struct cpuid_parse_entry cpuid_parse_entries[] = {
-	CPUID_PARSE_ENTRIES
+static const struct cpuid_parse_entry cpuid_early_parse_entries[] = {
+	CPUID_EARLY_PARSE_ENTRIES
+};
+
+static const struct cpuid_parse_entry cpuid_common_parse_entries[] = {
+	CPUID_COMMON_PARSE_ENTRIES
+};
+
+static const struct {
+	const struct cpuid_parse_entry	*table;
+	int				nr_entries;
+} cpuid_parser_phases[] = {
+	{ cpuid_early_parse_entries,	ARRAY_SIZE(cpuid_early_parse_entries)	},
+	{ cpuid_common_parse_entries,	ARRAY_SIZE(cpuid_common_parse_entries)	},
 };
 
 /*
@@ -86,6 +104,32 @@ static bool cpuid_leaf_in_range(const struct cpuid_table *t, unsigned int leaf)
 	       cpuid_range_valid(t, leaf, CPUID_EXT_START, CPUID_EXT_END);
 }
 
+static bool cpuid_leaf_matches_vendor(unsigned int leaf, u8 cpu_vendor)
+{
+	const struct cpuid_parse_entry *p = cpuid_early_parse_entries;
+	const struct cpuid_vendor_entry *v = cpuid_vendor_entries;
+
+	/* Leaves in the early boot parser table are vendor agnostic */
+	for (int i = 0; i < ARRAY_SIZE(cpuid_early_parse_entries); i++, p++)
+		if (p->leaf == leaf)
+			return true;
+
+	/* Leaves in the vendor table must pass a CPU vendor check */
+	for (int i = 0; i < ARRAY_SIZE(cpuid_vendor_entries); i++, v++) {
+		if (v->leaf != leaf)
+			continue;
+
+		for (unsigned int j = 0; j < v->nvendors; j++)
+			if (cpu_vendor == v->vendors[j])
+				return true;
+
+		return false;
+	}
+
+	/* Remaining leaves are vendor agnostic */
+	return true;
+}
+
 static void
 cpuid_fill_table(struct cpuid_table *t, const struct cpuid_parse_entry entries[], unsigned int nr_entries)
 {
@@ -100,6 +144,9 @@ cpuid_fill_table(struct cpuid_table *t, const struct cpuid_parse_entry entries[]
 		if (!cpuid_leaf_in_range(t, entry->leaf))
 			continue;
 
+		if (!cpuid_leaf_matches_vendor(entry->leaf, boot_cpu_data.x86_vendor))
+			continue;
+
 		WARN_ON_ONCE(output.info->nr_entries != 0);
 		entry->read(entry, &output);
 	}
@@ -109,19 +156,13 @@ cpuid_fill_table(struct cpuid_table *t, const struct cpuid_parse_entry entries[]
  * Exported APIs:
  */
 
-/**
- * cpuid_parser_scan_cpu() - Populate current CPU's CPUID table
- * @c:		CPU capability structure associated with the current CPU
- *
- * Populate the CPUID table embedded within @c with parsed CPUID data.  Since all CPUID
- * instructions are invoked locally, this must be called on the CPU associated with @c.
- */
-void cpuid_parser_scan_cpu(struct cpuinfo_x86 *c)
+static void __cpuid_parser_scan_cpu(struct cpuinfo_x86 *c, bool early_boot)
 {
+	int nphases = early_boot ? 1 : ARRAY_SIZE(cpuid_parser_phases);
 	struct cpuid_table *table = &c->cpuid;
 
 	/*
-	 * For correctness, clear the CPUID table first.
+	 * After early boot, clear the CPUID table first.
 	 *
 	 * This is due to the CPUID parser APIs at <asm/cpuid/api.h> using leaf->nr_entries
 	 * as a leaf validity check: non-zero means that the CPUID leaf's cached output is
@@ -137,7 +178,40 @@ void cpuid_parser_scan_cpu(struct cpuinfo_x86 *c)
 	 * parsed (leaving stale leaf "nr_entries" fields behind.)  The table must thus be
 	 * also cleared.
 	 */
-	memset(table, 0, sizeof(*table));
+	if (!early_boot)
+		memset(table, 0, sizeof(*table));
+
+	for (int i = 0; i < nphases; i++)
+		cpuid_fill_table(table, cpuid_parser_phases[i].table, cpuid_parser_phases[i].nr_entries);
+}
 
-	cpuid_fill_table(table, cpuid_parse_entries, ARRAY_SIZE(cpuid_parse_entries));
+/**
+ * cpuid_parser_scan_cpu() - Populate the current CPU's CPUID table
+ * @c:		CPU capability structure for the current CPU
+ *
+ * Populate the CPUID table embedded within @c with parsed CPUID data.	Since all CPUID
+ * instructions are invoked locally, this must be run on the CPU associated with @c.
+ *
+ * cpuid_parser_early_scan_cpu() must've been called, at least once, beforehand.
+ */
+void cpuid_parser_scan_cpu(struct cpuinfo_x86 *c)
+{
+	__cpuid_parser_scan_cpu(c, false);
+}
+
+/**
+ * cpuid_parser_early_scan_cpu() - Populate primary CPU's CPUID table on early boot
+ * @c:		CPU capability structure associated with the current CPU
+ *
+ * Populate the CPUID table embedded within @c with parsed CPUID data.
+ *
+ * This must be called at early boot, so that the boot code can identify the CPU's
+ * x86 vendor.	Only CPUID(0x0) and CPUID(0x1) are parsed.
+ *
+ * After saving the x86 vendor info in the boot CPU's capability structure,
+ * cpuid_parser_scan_cpu() must be called to complete the CPU's CPUID table.
+ */
+void __init cpuid_parser_early_scan_cpu(struct cpuinfo_x86 *c)
+{
+	__cpuid_parser_scan_cpu(c, true);
 }
diff --git a/arch/x86/kernel/cpu/cpuid_parser.h b/arch/x86/kernel/cpu/cpuid_parser.h
index c56c3dbe39e1..6adcbde62e1a 100644
--- a/arch/x86/kernel/cpu/cpuid_parser.h
+++ b/arch/x86/kernel/cpu/cpuid_parser.h
@@ -2,6 +2,7 @@
 #ifndef _ARCH_X86_CPUID_PARSER_H
 #define _ARCH_X86_CPUID_PARSER_H
 
+#include <linux/types.h>
 #include <asm/cpuid/types.h>
 
 /*
@@ -107,13 +108,60 @@ struct cpuid_parse_entry {
  * CPUID parser tables:
  */
 
-#define CPUID_PARSE_ENTRIES									\
+/*
+ * Early-boot CPUID leaves (to be parsed before x86 vendor detection)
+ *
+ * These leaves must be parsed at early boot to identify the x86 vendor. The
+ * parser treats them as universally valid across all vendors.
+ *
+ * At early boot, only leaves in this table must be parsed.  For all other
+ * leaves, the CPUID parser will assume that "boot_cpu_data.x86_vendor" is
+ * properly set beforehand.
+ *
+ * Note: If these entries are to be modified, please adapt the kernel-doc of
+ * cpuid_parser_early_scan_cpu() accordingly.
+ */
+#define CPUID_EARLY_PARSE_ENTRIES								\
 	/*			Leaf		Subleaf		Reader function */		\
 	CPUID_PARSE_ENTRY   (	0x0,		0,		generic			),	\
 	CPUID_PARSE_ENTRY   (	0x1,		0,		generic			),	\
+
+/*
+ * Common CPUID leaves
+ *
+ * These leaves can be parsed once basic x86 vendor detection is in place.
+ * Further vendor-agnostic leaves, which are not needed at early boot, are also
+ * listed here.
+ *
+ * For vendor-specific leaves, a matching entry must be added to the CPUID leaf
+ * vendor table later defined.  Leaves which are here, but without a matching
+ * vendor entry, are treated by the CPUID parser as valid for all x86 vendors.
+ */
+#define CPUID_COMMON_PARSE_ENTRIES								\
+	/*			Leaf		Subleaf		Reader function */		\
 	CPUID_PARSE_ENTRY   (	0x80000000,	0,		0x80000000		),	\
 	CPUID_PARSE_ENTRY   (	0x80000002,	0,		generic			),	\
 	CPUID_PARSE_ENTRY   (	0x80000003,	0,		generic			),	\
 	CPUID_PARSE_ENTRY   (	0x80000004,	0,		generic			),	\
 
+/*
+ * CPUID leaf vendor table:
+ */
+
+struct cpuid_vendor_entry {
+	unsigned int	leaf;
+	u8		vendors[X86_VENDOR_NUM];
+	u8		nvendors;
+};
+
+#define CPUID_VENDOR_ENTRY(_leaf, ...)							\
+	{										\
+		.leaf		= _leaf,						\
+		.vendors	= { __VA_ARGS__ },					\
+		.nvendors	= (sizeof((u8[]){__VA_ARGS__})/sizeof(u8)),		\
+	}
+
+#define CPUID_VENDOR_ENTRIES								\
+	/*		   Leaf		Vendor list		    */			\
+
 #endif /* _ARCH_X86_CPUID_PARSER_H */
-- 
2.50.1


