Return-Path: <linux-kernel+bounces-770328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3800BB279B0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99AE5AC3136
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 07:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2462E5B22;
	Fri, 15 Aug 2025 07:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iCx4OQM7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="npkJut/e"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FA12D29AA
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 07:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755241556; cv=none; b=iFR7DJBv6jsuLwL9TU+2DutbUEb2lg0hXGNG0f4XyLzX5mZGzp0ofc4QEybyzpo60OsYSd7oJwUzK5JyJzO8Q7KvdkLdSRniigEH2Y63FREAegnc2yteVJ6lPsFKx+7Ewrrv26vphgdZcsmb+bsKIk3bk2+IEY3JBOARRV4vErg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755241556; c=relaxed/simple;
	bh=/VE63AtxVVj73KkvZcEIf/zdUBoXijIRRqYaialVL7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kDwF+agXbpuh6O9pdRnMnlLK3sOpYsYBOGk4aDZyQQaFOygjQJwV5Bg8TBrgCIuSGXhZRMOKmJa/sV5XM+Ob91/Hj24DA3Pb47ycTHE65mqk3d9+QTM/jSU3gOZJ0GRYfgD1QAwbi8e4VIImuzVVwmSnzUnwQ5MKIiJEXB2vols=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iCx4OQM7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=npkJut/e; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755241553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TMgezEz1RsvC1uFOjiCB0IYTpuqnq6yks4w29vKpSDM=;
	b=iCx4OQM7lx9jUy0QLYn02JDIbV+5ZB93nyT7smALSj+VxOvJmCjWFR2DuJrzhz02JMqGVp
	WzU2UCYnco1DKfBa83k85FLunS9OFGDll0yFLuYTn6PVJU6FRy4KK3iUOQf5By+mwo0pqn
	CmzAufFrGXF75m83+kh1AcAf9+/GJowYouA3wxd6lR5hqZT5T0OY2AJHPSIiArru3F18ku
	KsZC7nK1DFnfUfJZgMS4AC8bbQEx8fbHiE9gl0VVBrA/ism0923zsch6D+vqKDtfibpmyH
	tlanUS1flVJ1sq5hG69V5f2PA1a12Y0dZG7RVrDhuqaPRQRRR09ognoXAmyiSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755241553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TMgezEz1RsvC1uFOjiCB0IYTpuqnq6yks4w29vKpSDM=;
	b=npkJut/ebDeEIDeVIJ1sXN93Z489B8/qIOxZe7OKCy4f74CxZolbOUtA4M6CLG2fRatuZ8
	/xCLcyHTBl6c7ZAg==
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
Subject: [PATCH v4 16/34] x86/cpuid: Parse CPUID(0x2)
Date: Fri, 15 Aug 2025 09:02:09 +0200
Message-ID: <20250815070227.19981-17-darwi@linutronix.de>
In-Reply-To: <20250815070227.19981-1-darwi@linutronix.de>
References: <20250815070227.19981-1-darwi@linutronix.de>
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
index d0f0e6a8a457..7bbf0671cb95 100644
--- a/arch/x86/include/asm/cpuid/types.h
+++ b/arch/x86/include/asm/cpuid/types.h
@@ -215,6 +215,7 @@ struct cpuid_leaves {
 	/*         leaf		subleaf		count */
 	CPUID_LEAF(0x0,		0,		1);
 	CPUID_LEAF(0x1,		0,		1);
+	CPUID_LEAF(0x2,		0,		1);
 	CPUID_LEAF(0x80000000,	0,		1);
 };
 
diff --git a/arch/x86/kernel/cpu/cpuid_parser.c b/arch/x86/kernel/cpu/cpuid_parser.c
index 3942ea2526f2..f3dffdd43779 100644
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
 	struct leaf_0x80000000_0 *l = (struct leaf_0x80000000_0 *)output->regs;
diff --git a/arch/x86/kernel/cpu/cpuid_parser.h b/arch/x86/kernel/cpu/cpuid_parser.h
index 1be5c323d5eb..0e3ac9a7700d 100644
--- a/arch/x86/kernel/cpu/cpuid_parser.h
+++ b/arch/x86/kernel/cpu/cpuid_parser.h
@@ -127,6 +127,7 @@ struct cpuid_parse_entry {
  */
 #define CPUID_COMMON_PARSE_ENTRIES							\
 	/*		  Leaf		Subleaf		Reader function */		\
+	CPUID_PARSE_ENTRY(0x2,		0,		0x2),				\
 	CPUID_PARSE_ENTRY(0x80000000,	0,		0x80000000),			\
 
 /*
@@ -160,5 +161,6 @@ struct cpuid_vendor_entry {
 
 #define CPUID_VENDOR_ENTRIES								\
  	/*		   Leaf		Vendor list */					\
+	CPUID_VENDOR_ENTRY(0x2,		X86_VENDOR_INTEL, X86_VENDOR_CENTAUR, X86_VENDOR_ZHAOXIN),\
 
 #endif /* _ARCH_X86_CPUID_PARSER_H */
-- 
2.50.1


