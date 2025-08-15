Return-Path: <linux-kernel+bounces-770334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD42CB279B7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66196AC2FB3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 07:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342B02EACEB;
	Fri, 15 Aug 2025 07:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SNRFyEu6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6vTVAVmw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A732EAB65
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 07:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755241575; cv=none; b=uczK/jzTMCQRaUDWkjLq2whOexJRM3tASluCaUjQQKqLIqOtnOiBN/2rG62J7Xlhi3ZWzuiZL6iZFw2Qq2DKnXMQ+bYDdyEbiaqxBi96mmkuaOxmXKJ7QWUEXe9Z14T9wJ6jSXBD5AWsG3es1DqZkuBJ6I3LJOPouxt3ehb5/Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755241575; c=relaxed/simple;
	bh=HTpRnqlKso/FXDrHqiIJ8nvmJi4tgHXFOk46HUFzkTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GWLkJrhDahA1nwK7zSVDs626AGSmBDhfY7o1ceGH95hwVOEuCcap1LYDmEbmei6V1ed8PlGY8fkQqc3691ttX2qFlQvG2ddXHQWS5zcokrat+WfxB8rdvCOzcea9Y0S/JDsV3vf/kY6vlcIfZ9ww6OndfW94Pi0xue04M14Aq8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SNRFyEu6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6vTVAVmw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755241572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a5stZDyoyjR3gb+Wxf514suR2rNmBwiWAX20aFG4VoA=;
	b=SNRFyEu6Trq0tL/lIEuYKqgtZe5NmbbVTah+qGSYMHv/Fj3/KEMITJdX+mSbBfTGlZwfHl
	YArFVcKfqHi5cKxMaVr00UeWFOuGaD8zWY+qp19ADtr9NDpgZRCd1DCDgZkQZ+od8MAyxH
	078OwWH8jLrEfPTVBUS2mfEbzXcvQ3cF+DyVcGtmbJKdFIzT6p8Wz+ZGFTLaog4L6SeaEa
	X1+6UHv/vHmMbOxAfeikvCxWGOw3imzXnY4icNDOvG+PcN07qeq686FwzRvM/MbdHEc6+J
	AMgbnsM21rp4GB9gheJJrUlXlgbdomjgFpRWCcTjHppPwiOL4MPIqwFswYIb2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755241572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a5stZDyoyjR3gb+Wxf514suR2rNmBwiWAX20aFG4VoA=;
	b=6vTVAVmwNnnA2WhhfozmqKT0dG1ubZnQRY8b+cvOMtr1YtR4FNfLyom0GpL5AJrjPzxkUR
	49KzTBdKpeMgyYAQ==
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
Subject: [PATCH v4 22/34] x86/cpuid: Parse 'deterministic cache parameters' CPUID leaves
Date: Fri, 15 Aug 2025 09:02:15 +0200
Message-ID: <20250815070227.19981-23-darwi@linutronix.de>
In-Reply-To: <20250815070227.19981-1-darwi@linutronix.de>
References: <20250815070227.19981-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add CPUID(0x4) and CPUID(0x8000001d) support to the CPUID parser.

Query CPUID(0x4) only for Intel, Centaur, and Zhaoxin as these are the
only x86 vendors where it is supported.  Query CPUID(0x8000001d) only for
AMD and Hygon.

Define a single output parsing function for both CPUID leaves, as both
have the same subleaf cache enumeration logic.

Introduce the macro

    __define_cpuid_read_function()

to avoid code duplication between the CPUID parser default read function,
cpuid_read_generic(), and the new CPUID(0x4)/CPUID(0x8000001d) parsing
logic.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/include/asm/cpuid/types.h |  2 ++
 arch/x86/kernel/cpu/cpuid_parser.c | 37 +++++++++++++++++++++++++-----
 arch/x86/kernel/cpu/cpuid_parser.h |  4 ++++
 3 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/cpuid/types.h b/arch/x86/include/asm/cpuid/types.h
index 7bbf0671cb95..89c399629e58 100644
--- a/arch/x86/include/asm/cpuid/types.h
+++ b/arch/x86/include/asm/cpuid/types.h
@@ -216,7 +216,9 @@ struct cpuid_leaves {
 	CPUID_LEAF(0x0,		0,		1);
 	CPUID_LEAF(0x1,		0,		1);
 	CPUID_LEAF(0x2,		0,		1);
+	CPUID_LEAF(0x4,		0,		8);
 	CPUID_LEAF(0x80000000,	0,		1);
+	CPUID_LEAF(0x8000001d,	0,		8);
 };
 
 /*
diff --git a/arch/x86/kernel/cpu/cpuid_parser.c b/arch/x86/kernel/cpu/cpuid_parser.c
index c340ad6eca3d..60da1e452831 100644
--- a/arch/x86/kernel/cpu/cpuid_parser.c
+++ b/arch/x86/kernel/cpu/cpuid_parser.c
@@ -22,17 +22,36 @@ static const struct cpuid_vendor_entry cpuid_vendor_entries[] = {
  * Leaf read functions:
  */
 
-/*
- * Default CPUID parser read function
+/**
+ * __define_cpuid_parser_read_function() - Generate a CPUID parser leaf read function
+ * @suffix:	Generated function name suffix (full name becomes: cpuid_read_@suffix())
+ * @_leaf_t:	Type to cast the CPUID query output storage pointer
+ * @_leaf:	Name of the CPUID query storage pointer
+ * @_break_c:	Condition to break the CPUID parsing loop, which may reference @_leaf, and
+ *		where @_leaf stores each iteration's CPUID query output.
  *
  * Satisfies the requirements stated at 'struct cpuid_parse_entry'->read().
+ * Define a CPUID parser read function according to the requirements stated at
+ * 'struct cpuid_parse_entry'->read().
  */
-static void cpuid_read_generic(const struct cpuid_parse_entry *e, struct cpuid_read_output *output)
-{
-	for (int i = 0; i < e->maxcnt; i++, output->regs++, output->info->nr_entries++)
-		cpuid_read_subleaf(e->leaf, e->subleaf + i, output->regs);
+#define __define_cpuid_parser_read_function(suffix, _leaf_t, _leaf, _break_c)			\
+static void											\
+cpuid_read_##suffix(const struct cpuid_parse_entry *e, struct cpuid_read_output *output)	\
+{												\
+	struct _leaf_t *_leaf = (struct _leaf_t *)output->regs;					\
+												\
+	for (int i = 0; i < e->maxcnt; i++, _leaf++, output->info->nr_entries++) {		\
+		cpuid_read_subleaf(e->leaf, e->subleaf + i, _leaf);				\
+		if (_break_c)									\
+			break;									\
+	}											\
 }
 
+/*
+ * Default CPUID parser read function
+ */
+__define_cpuid_parser_read_function(generic, cpuid_regs, ignored, false);
+
 static void cpuid_read_0x2(const struct cpuid_parse_entry *e, struct cpuid_read_output *output)
 {
 	union leaf_0x2_regs *regs = (union leaf_0x2_regs *)output->regs;
@@ -71,6 +90,12 @@ static void cpuid_read_0x2(const struct cpuid_parse_entry *e, struct cpuid_read_
 	output->info->nr_entries = 1;
 }
 
+/*
+ * Shared read function for Intel CPUID(0x4) and AMD CPUID(0x8000001d), as both have
+ * the same subleaf enumeration logic and registers output format.
+ */
+__define_cpuid_parser_read_function(deterministic_cache, leaf_0x4_0, l, l->cache_type == 0);
+
 static void cpuid_read_0x80000000(const struct cpuid_parse_entry *e, struct cpuid_read_output *output)
 {
 	struct leaf_0x80000000_0 *l = (struct leaf_0x80000000_0 *)output->regs;
diff --git a/arch/x86/kernel/cpu/cpuid_parser.h b/arch/x86/kernel/cpu/cpuid_parser.h
index 0e3ac9a7700d..15ad37b0b3b2 100644
--- a/arch/x86/kernel/cpu/cpuid_parser.h
+++ b/arch/x86/kernel/cpu/cpuid_parser.h
@@ -128,7 +128,9 @@ struct cpuid_parse_entry {
 #define CPUID_COMMON_PARSE_ENTRIES							\
 	/*		  Leaf		Subleaf		Reader function */		\
 	CPUID_PARSE_ENTRY(0x2,		0,		0x2),				\
+	CPUID_PARSE_ENTRY(0x4,		0,		deterministic_cache),		\
 	CPUID_PARSE_ENTRY(0x80000000,	0,		0x80000000),			\
+	CPUID_PARSE_ENTRY(0x8000001d,	0,		deterministic_cache),		\
 
 /*
  * CPUID parser tables repository:
@@ -162,5 +164,7 @@ struct cpuid_vendor_entry {
 #define CPUID_VENDOR_ENTRIES								\
  	/*		   Leaf		Vendor list */					\
 	CPUID_VENDOR_ENTRY(0x2,		X86_VENDOR_INTEL, X86_VENDOR_CENTAUR, X86_VENDOR_ZHAOXIN),\
+	CPUID_VENDOR_ENTRY(0x4,		X86_VENDOR_INTEL, X86_VENDOR_CENTAUR, X86_VENDOR_ZHAOXIN),\
+	CPUID_VENDOR_ENTRY(0x8000001d,	X86_VENDOR_AMD, X86_VENDOR_HYGON),		\
 
 #endif /* _ARCH_X86_CPUID_PARSER_H */
-- 
2.50.1


