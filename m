Return-Path: <linux-kernel+bounces-770346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A50B279D0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 014AE5E0E22
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 07:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647592F83CA;
	Fri, 15 Aug 2025 07:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WolOd4bg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mmZh6UEo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C20C2F7450
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 07:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755241613; cv=none; b=dle96hhR0xXK5wS37P5fiaCMWekA9hMYBhixlHVmvGBC2thFAUg/+glKOG3XWg4Uq7OSVjdztasrErV2kKiiQeKAqvVHMUNY8gC13FPR9cW58Qf8RF8+11LjZu77faRBe6GfLw0aVnL8bBpDhRahu8tcQ5PJU13vFupotCatvNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755241613; c=relaxed/simple;
	bh=9z1Sdq4BhIr3DLajt8jgfRyN+bMto1EjY0iFvW8JoCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O/BrnKPt1yBGX8H6IuJzjR/RTU7gqhLLX9fpl45wVHdp09eSgXWrcSfGcSmMp+SmPidZhnHQKwqFu1GOEQ7mUzoA00q0mlvzBgYbqbRKLq3mpM2n8wtn+gb3YvUzXbqyx7cq1nErXYfPDcjggCOdNy6+2FaTy14x23FeBTJlQmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WolOd4bg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mmZh6UEo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755241611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1eI8/xjW0UInlljX8bsLjNZVb1yWs78XL5H+yDv/aJc=;
	b=WolOd4bgfgXM9cpwd1QF1ILPnG14HQ1Xz/t2kKbCiiSYKBCnqFeSORX3N8rzD04MWUEcHw
	mS6HZlnj7kT05MraFGbbDnUA3ZdekTP7qjckkryd57/M7+gf96NbLBIm3ZGVl1kzpUrxPS
	0LwH1uX2Sw7gJqGZu4luPOpa3s0AnRrv9zb7QhqJ7caS5EqsabO64c+8OS6zP91Eox4ATB
	pImrR0nszenPDlz8fBpWCiUy37TrA7c3SqVz5nH1Anp+nyZMBnkLxO/BUuQjlSxi7ylJGC
	atrZ40aqPcN0gKKva//7+cPu76EbGHc3DBXp0iDN6wHL2/RsvNgrGwuRYLZmVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755241611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1eI8/xjW0UInlljX8bsLjNZVb1yWs78XL5H+yDv/aJc=;
	b=mmZh6UEoE10CqUL+DODgmESD2vK0Sm7qwztJQvtvmN0zjWatRr9MV4RWeXUjzJfpJEmOzn
	H7WaFpkZ+pWWsHCw==
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
Subject: [PATCH v4 33/34] x86/cpuid: Parse CPUID(0x16)
Date: Fri, 15 Aug 2025 09:02:26 +0200
Message-ID: <20250815070227.19981-34-darwi@linutronix.de>
In-Reply-To: <20250815070227.19981-1-darwi@linutronix.de>
References: <20250815070227.19981-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add CPUID(0x16) support to the CPUID parser.  It enumerates processor
frequency information.  Query the leaf only for Intel machines, as this
is where it is supported.

This allows converting CPUID(0x16) call sites to the new CPUID parser
APIs next.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/include/asm/cpuid/types.h | 1 +
 arch/x86/kernel/cpu/cpuid_parser.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/x86/include/asm/cpuid/types.h b/arch/x86/include/asm/cpuid/types.h
index 63d2569e2821..c044f7bc7137 100644
--- a/arch/x86/include/asm/cpuid/types.h
+++ b/arch/x86/include/asm/cpuid/types.h
@@ -217,6 +217,7 @@ struct cpuid_leaves {
 	CPUID_LEAF(0x1,		0,		1);
 	CPUID_LEAF(0x2,		0,		1);
 	CPUID_LEAF(0x4,		0,		8);
+	CPUID_LEAF(0x16,	0,		1);
 	CPUID_LEAF(0x80000000,	0,		1);
 	CPUID_LEAF(0x80000005,	0,		1);
 	CPUID_LEAF(0x80000006,	0,		1);
diff --git a/arch/x86/kernel/cpu/cpuid_parser.h b/arch/x86/kernel/cpu/cpuid_parser.h
index 1d0d1a3c2bb8..9ac66abeae81 100644
--- a/arch/x86/kernel/cpu/cpuid_parser.h
+++ b/arch/x86/kernel/cpu/cpuid_parser.h
@@ -129,6 +129,7 @@ struct cpuid_parse_entry {
 	/*		  Leaf		Subleaf		Reader function */		\
 	CPUID_PARSE_ENTRY(0x2,		0,		0x2),				\
 	CPUID_PARSE_ENTRY(0x4,		0,		deterministic_cache),		\
+	CPUID_PARSE_ENTRY(0x16,		0,		generic),			\
 	CPUID_PARSE_ENTRY(0x80000000,	0,		0x80000000),			\
 	CPUID_PARSE_ENTRY(0x80000005,	0,		generic),			\
 	CPUID_PARSE_ENTRY(0x80000006,	0,		generic),			\
@@ -167,6 +168,7 @@ struct cpuid_vendor_entry {
  	/*		   Leaf		Vendor list */					\
 	CPUID_VENDOR_ENTRY(0x2,		X86_VENDOR_INTEL, X86_VENDOR_CENTAUR, X86_VENDOR_ZHAOXIN),\
 	CPUID_VENDOR_ENTRY(0x4,		X86_VENDOR_INTEL, X86_VENDOR_CENTAUR, X86_VENDOR_ZHAOXIN),\
+	CPUID_VENDOR_ENTRY(0x16,	X86_VENDOR_INTEL),				\
 	CPUID_VENDOR_ENTRY(0x8000001d,	X86_VENDOR_AMD, X86_VENDOR_HYGON),		\
 
 #endif /* _ARCH_X86_CPUID_PARSER_H */
-- 
2.50.1


