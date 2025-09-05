Return-Path: <linux-kernel+bounces-802849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5CBB45792
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4115E3AC18C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D01E3570C2;
	Fri,  5 Sep 2025 12:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZTeGvr8j";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b+BrGIv/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22E835690A
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 12:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757074607; cv=none; b=eAb6U9tBQTpDCCSgzC0Vb2fDUWzm72wXFr++wLyrZvtllmWm3h/JFZaHJ39hlr3wuFiTuQfuWVD3NkThHlmYHgJt6qklYQmoGAGfRRu3Oh+j6UFJcFVD1mQeHBfb3J7u+Nr3TCKfySNDUs7cuzN1PI1qsnlg037Ibv8vcCOMEas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757074607; c=relaxed/simple;
	bh=zHGfdATx2CbM80sSBFShaRQR46slZRAipaOxYzCj5mw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bGpw/PrfPXAqUHYtAKJpPG1HaVh8EtF0G+1b9mWYNdWrVaM7aVfyT8qi6xTTGnR+c57EH0c8Sw9cPVrmbUeprOuW/9STvnSeiOKG9Gi1mCpA85hJDSaT3G32yr/oQLSIxhNmyIcd+5UTIfLCMQlustM6ruwT6gMqr927X8TcA1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZTeGvr8j; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b+BrGIv/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757074603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J2o1gQPsOlt6+EV7FAqZn/kp7f8rsb9zroA5aANr7Go=;
	b=ZTeGvr8jFO7FgPrpGpD+zVI/iN7FrFeKrfR9yewnsmgHA70L/oefs//7IrU90Em6KUA8nw
	ELibTaT2gI27k0+HadbIiFzo6Q0Wxy9jX0cA0vgaA+kLZhlEnQ0yY9uXfhRkx5Go1ODeDC
	s/xt5AuClatOGbBK6Y2UbnkertBYJ1oRtqzXa6Y7De8x/x/4/3QZ5g1xFZhmYHbZJdVNHy
	dATuH7aJcYIgHGnk1A9Puj/I4IxYYwi59cUtx+yr8Hnl4nnOXisSCaYtnsAaVmtqRvsknh
	f00CkL3VwXNAKYlYHG4TUckhmhOYEZt8Bxk87g4bA1mOcaLl/o0wEI4Hnj9TAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757074603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J2o1gQPsOlt6+EV7FAqZn/kp7f8rsb9zroA5aANr7Go=;
	b=b+BrGIv/vdOmlQ6ELZdX9iKxqAa2WmVtA3HnRXTbny9lOZcoVsG81rUUPx8fPkipzF2yC9
	RQFI2csxWiL6OYAg==
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
Subject: [PATCH v5 24/35] x86/cpuid: Parse 'deterministic cache parameters' CPUID leaves
Date: Fri,  5 Sep 2025 14:15:04 +0200
Message-ID: <20250905121515.192792-25-darwi@linutronix.de>
In-Reply-To: <20250905121515.192792-1-darwi@linutronix.de>
References: <20250905121515.192792-1-darwi@linutronix.de>
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
 arch/x86/kernel/cpu/cpuid_parser.h |  6 ++++-
 3 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/cpuid/types.h b/arch/x86/include/asm/cpuid/types.h
index b54080066084..411a2a96e3ed 100644
--- a/arch/x86/include/asm/cpuid/types.h
+++ b/arch/x86/include/asm/cpuid/types.h
@@ -237,10 +237,12 @@ struct cpuid_leaves {
 	CPUID_LEAF   (	0x0,		0  );
 	CPUID_LEAF   (	0x1,		0  );
 	CPUID_LEAF   (  0x2,		0  );
+	CPUID_LEAF_N (  0x4,		8  );
 	CPUID_LEAF   (  0x80000000,	0  );
 	CPUID_LEAF   (  0x80000002,	0  );
 	CPUID_LEAF   (  0x80000003,	0  );
 	CPUID_LEAF   (  0x80000004,	0  );
+	CPUID_LEAF_N (  0x8000001d,	8  );
 };
 
 /*
diff --git a/arch/x86/kernel/cpu/cpuid_parser.c b/arch/x86/kernel/cpu/cpuid_parser.c
index f7dc5c78b06b..6d1dc56f11f2 100644
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
+ * the same subleaf enumeration logic and register output format.
+ */
+__define_cpuid_parser_read_function(deterministic_cache, leaf_0x4_n, l, l->cache_type == 0);
+
 static void cpuid_read_0x80000000(const struct cpuid_parse_entry *e, struct cpuid_read_output *output)
 {
 	struct leaf_0x80000000_0 *el0 = (struct leaf_0x80000000_0 *)output->regs;
diff --git a/arch/x86/kernel/cpu/cpuid_parser.h b/arch/x86/kernel/cpu/cpuid_parser.h
index 7366e8468116..227ffac6b297 100644
--- a/arch/x86/kernel/cpu/cpuid_parser.h
+++ b/arch/x86/kernel/cpu/cpuid_parser.h
@@ -138,12 +138,14 @@ struct cpuid_parse_entry {
  * vendor entry, are treated by the CPUID parser as valid for all x86 vendors.
  */
 #define CPUID_COMMON_PARSE_ENTRIES								\
-	/*			Leaf		Subleaf		Reader function */		\
+	/*			Leaf		Static subleaf	Reader function */		\
 	CPUID_PARSE_ENTRY   (	0x2,		0,		0x2			),	\
+	CPUID_PARSE_ENTRY_N (	0x4,				deterministic_cache	),	\
 	CPUID_PARSE_ENTRY   (	0x80000000,	0,		0x80000000		),	\
 	CPUID_PARSE_ENTRY   (	0x80000002,	0,		generic			),	\
 	CPUID_PARSE_ENTRY   (	0x80000003,	0,		generic			),	\
 	CPUID_PARSE_ENTRY   (	0x80000004,	0,		generic			),	\
+	CPUID_PARSE_ENTRY_N (	0x8000001d,			deterministic_cache	),	\
 
 /*
  * CPUID parser tables repository:
@@ -177,5 +179,7 @@ struct cpuid_vendor_entry {
 #define CPUID_VENDOR_ENTRIES								\
 	/*		   Leaf		Vendor list		    */			\
 	CPUID_VENDOR_ENTRY(0x2,		X86_VENDOR_INTEL, X86_VENDOR_CENTAUR, X86_VENDOR_ZHAOXIN),\
+	CPUID_VENDOR_ENTRY(0x4,		X86_VENDOR_INTEL, X86_VENDOR_CENTAUR, X86_VENDOR_ZHAOXIN),\
+	CPUID_VENDOR_ENTRY(0x8000001d,	X86_VENDOR_AMD, X86_VENDOR_HYGON),		\
 
 #endif /* _ARCH_X86_CPUID_PARSER_H */
-- 
2.50.1


