Return-Path: <linux-kernel+bounces-802843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1925FB45791
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17158566AD4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFAE534AAED;
	Fri,  5 Sep 2025 12:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gmHLEOTj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hq/Tj+c6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871CA353360
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 12:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757074579; cv=none; b=dMN7xaRbH6YQ7G2rqrxiAa9kUirv4mXyslDSyPW/J85VhLGWgogK9lfXLigeyMJZ1qTbaRYc2aEhn96Bo7imL4dzFkFhCj1KppSm6LSZB3Qh/6QxnVu7mfcLtfUljD7L8K5p6bSGlV+8hJJcfUxvZcN4g9KR3KtCDrd1Z5XJKmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757074579; c=relaxed/simple;
	bh=xVqoHGuwZYp0oVe1N6Tc0h9taOAqtIoYB7l4Ck/j0eY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C4XmM+uASsfojc0frH4kql/Cvsi6t+qWGCRHlwxe4ghKaaLuoFKa/NbbvxbnUuCONyQZEk5vNT3eXEoBeVVTfApmME8Ds0X5oGDfDfDdpZl8XEM9E0oDrnEtqKlTt0gArW9c4rByhmDpopXN6GCSxrHF76h0wpx3Xe7BZES3VlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gmHLEOTj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hq/Tj+c6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757074576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vna62liQ3pVm5VyCtMFSOLzwHagCpxK9YGKs/jyMQks=;
	b=gmHLEOTjb11NGH+lroyzuaFIjJCpRg2CzkvA+QhY1FyLH56xk73NGh5dZcwlnu9rcKhheL
	7BS0a9tEls5j4c8+8IDDdStl9HHyXwdTSKw6FR3Amu0lvtA2sjYjFsBWYB9Ip3AVusRY61
	4PCy+/KWJhrd6FNzyg47HSWg2bM7FibZlTBtG+je3f1gPTk8VWLmjQg/BYMgS/BREeIpHd
	1rLlNfKy6u/iyNFMrP0Vuwzp/Smb3L6IJKW/1zhfg3m6uVuHEqkldsXlnZXED+u532tgZM
	OK8moFCNsV2+MjRqRJ59hpOXa8/4nsuI4NTOxdeAoWowmkemr+VRtWax9BzVeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757074576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vna62liQ3pVm5VyCtMFSOLzwHagCpxK9YGKs/jyMQks=;
	b=hq/Tj+c6sXIT15j6u831ArZlmXtqUOYr1SXVQi3JmPvNSrDViQJiryoBJq9JlyLhadeuKf
	bgPSB1l3I3DbYwAw==
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
Subject: [PATCH v5 18/35] x86/cpuid: Parse CPUID(0x2)
Date: Fri,  5 Sep 2025 14:14:58 +0200
Message-ID: <20250905121515.192792-19-darwi@linutronix.de>
In-Reply-To: <20250905121515.192792-1-darwi@linutronix.de>
References: <20250905121515.192792-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add CPUID(0x2) support to the CPUID parser.

Query CPUID(0x2) only for Intel, Centaur, and Zhaoxin.  Such vendor
information was extracted from the kernel's boot code, given that

    kernel/cpu/cacheinfo.c :: init_intel_cacheinfo()

is called by

    kernel/cpu/intel.c		cpu_dev.c_x86_vendor = X86_VENDOR_INTEL
    kernel/cpu/centaur.c	cpu_dev.c_x86_vendor = X86_VENDOR_CENTAUR
    kernel/cpu/zhaoxin.c	cpu_dev.c_x86_vendor = X86_VENDOR_ZHAOXIN

At the CPUID leaf output table, keep CPUID(0x2) marked as invalidif the
whole leaf, or all of its output registers separately, were malformed.

Note, the cpuid_leaf_0x2() logic at <asm/cpuid/api.h> will be removed
once all CPUID(0x2) call sites are transformed to the new CPUID model.

References: fe78079ec07f ("x86/cpu: Introduce and use CPUID leaf 0x2 parsing helpers")
Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/include/asm/cpuid/types.h |  1 +
 arch/x86/kernel/cpu/cpuid_parser.c | 35 ++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/cpuid_parser.h |  2 ++
 3 files changed, 38 insertions(+)

diff --git a/arch/x86/include/asm/cpuid/types.h b/arch/x86/include/asm/cpuid/types.h
index 6f4da51126b3..b54080066084 100644
--- a/arch/x86/include/asm/cpuid/types.h
+++ b/arch/x86/include/asm/cpuid/types.h
@@ -236,6 +236,7 @@ struct cpuid_leaves {
 	/*		Leaf		Subleaf number (or max number of dynamic subleaves) */
 	CPUID_LEAF   (	0x0,		0  );
 	CPUID_LEAF   (	0x1,		0  );
+	CPUID_LEAF   (  0x2,		0  );
 	CPUID_LEAF   (  0x80000000,	0  );
 	CPUID_LEAF   (  0x80000002,	0  );
 	CPUID_LEAF   (  0x80000003,	0  );
diff --git a/arch/x86/kernel/cpu/cpuid_parser.c b/arch/x86/kernel/cpu/cpuid_parser.c
index a176722672ba..6efe594b9f2b 100644
--- a/arch/x86/kernel/cpu/cpuid_parser.c
+++ b/arch/x86/kernel/cpu/cpuid_parser.c
@@ -31,6 +31,41 @@ static void cpuid_read_generic(const struct cpuid_parse_entry *e, struct cpuid_r
 		cpuid_read_subleaf(e->leaf, e->subleaf + i, output->regs);
 }
 
+static void cpuid_read_0x2(const struct cpuid_parse_entry *e, struct cpuid_read_output *output)
+{
+	union leaf_0x2_regs *regs = (union leaf_0x2_regs *)output->regs;
+	struct leaf_0x2_0 *l = (struct leaf_0x2_0 *)output->regs;
+	int invalid_regs = 0;
+
+	/*
+	 * All Intel CPUs must report an iteration count of 1.  For broken hardware,
+	 * keep the leaf marked as invalid at the CPUID table.
+	 */
+	cpuid_read_subleaf(e->leaf, e->subleaf, l);
+	if (l->iteration_count != 0x01)
+		return;
+
+	/*
+	 * The most significant bit (MSB) of each CPUID(0x2) register must be clear.
+	 * If a register is malformed, replace its 1-byte descriptors with NULL.
+	 */
+	for (int i = 0; i < 4; i++) {
+		if (regs->reg[i].invalid) {
+			regs->regv[i] = 0;
+			invalid_regs++;
+		}
+	}
+
+	/*
+	 * If all of the CPUID(0x2) output registers were malformed, keep the leaf
+	 * marked as invalid at the CPUID table.
+	 */
+	if (invalid_regs == 4)
+		return;
+
+	output->info->nr_entries = 1;
+}
+
 static void cpuid_read_0x80000000(const struct cpuid_parse_entry *e, struct cpuid_read_output *output)
 {
 	struct leaf_0x80000000_0 *el0 = (struct leaf_0x80000000_0 *)output->regs;
diff --git a/arch/x86/kernel/cpu/cpuid_parser.h b/arch/x86/kernel/cpu/cpuid_parser.h
index 066d4d60bf59..7366e8468116 100644
--- a/arch/x86/kernel/cpu/cpuid_parser.h
+++ b/arch/x86/kernel/cpu/cpuid_parser.h
@@ -139,6 +139,7 @@ struct cpuid_parse_entry {
  */
 #define CPUID_COMMON_PARSE_ENTRIES								\
 	/*			Leaf		Subleaf		Reader function */		\
+	CPUID_PARSE_ENTRY   (	0x2,		0,		0x2			),	\
 	CPUID_PARSE_ENTRY   (	0x80000000,	0,		0x80000000		),	\
 	CPUID_PARSE_ENTRY   (	0x80000002,	0,		generic			),	\
 	CPUID_PARSE_ENTRY   (	0x80000003,	0,		generic			),	\
@@ -175,5 +176,6 @@ struct cpuid_vendor_entry {
 
 #define CPUID_VENDOR_ENTRIES								\
 	/*		   Leaf		Vendor list		    */			\
+	CPUID_VENDOR_ENTRY(0x2,		X86_VENDOR_INTEL, X86_VENDOR_CENTAUR, X86_VENDOR_ZHAOXIN),\
 
 #endif /* _ARCH_X86_CPUID_PARSER_H */
-- 
2.50.1


