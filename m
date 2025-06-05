Return-Path: <linux-kernel+bounces-675019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B25ACF7EC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jun 2025 21:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 661BA189D797
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jun 2025 19:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91CA27F736;
	Thu,  5 Jun 2025 19:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PPUmrZen";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9CC40TBt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A422857FB
	for <linux-kernel@vger.kernel.org>; Thu,  5 Jun 2025 19:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749151534; cv=none; b=dqxCq7Va3RNkVt4PA/qh4gOxpjkIQgvz9h2aWfmEr4os36EG3PJ0ZlrSmvtiAUk44zdo4eO1GTuBScLTbVHpZYwzp66FuLNkAQV8JxPJ0diL7DNuNQt9xb1uHSe+dU5e8prnA8B1okMHUNLtjIBOAH7lYZiLUG3ZhnqeWYiyi7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749151534; c=relaxed/simple;
	bh=W3dTfIe7wNxHvY5661/WbK2xZkXVVQCSXUOWHesObeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d5r9rCgkRYK9ipLJYzEE68+ASU6JNHlv08vng3ljgr5WEJO+e9v/DvmL+c7/hcID+Bg973pgp4Jt3Tekzf1XvTv+o5Xeje1UPCMXYWrge7iTDuzc3FTbyMWKpX1tUQomDw0HHmKINPlQltl9ciIBej12oJQ3CbP5910mX0CHqbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PPUmrZen; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9CC40TBt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749151531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=06vLN0q3YMEOZ8znXlguEvGzBlU5hq5/7MCh3v91C8E=;
	b=PPUmrZenVsJf/PMG/HCzYGyQOknltFXrU3Vmw+cnpCgbnxaLczXgTyNCaZgvm9Vq1HOUzV
	I3mNX0nKRPM9B77azOBbBOtJwHKAbNNKEcR2nN13bwu5GSctJf1JWDt4ssc+OwAQZQzAsJ
	45eHw0npcUZdEgTmCxnxRI12emf+/tKZ7Ix1jiNXVm/+OnDhJZZapUlp+ideL8tTXJLslg
	pGq5syfUy4xmWTbWEhsRQo4oTurSghGlXiMjgScpa7dd5Ne1siDh90Crqhf7wT27+HoxBe
	rcqZjHl5rLFmM+0EizQrL4MNv5YVKXeOVaKqNO50JHKn1uSFBi8viQqpIGRxAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749151531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=06vLN0q3YMEOZ8znXlguEvGzBlU5hq5/7MCh3v91C8E=;
	b=9CC40TBtHgmw8SgIX/htO9vZLZ4xefhfZ8L58uRKvzs+tS7Cf/yaFQLUrSb9pJbzRfNRaK
	EwhgRHjpr+/mvnCQ==
To: Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sean Christopherson <seanjc@google.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	x86@kernel.org,
	x86-cpuid@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v2 26/27] x86/cpu: Rescan system CPUID table after PSN disable
Date: Thu,  5 Jun 2025 21:23:55 +0200
Message-ID: <20250605192356.82250-27-darwi@linutronix.de>
In-Reply-To: <20250605192356.82250-1-darwi@linutronix.de>
References: <20250605192356.82250-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Pentium-III and Transmeta CPUs, disabling the CPUID(0x3) Processor
Serial Number (PSN) can affect the maximum valid CPUID standard leaf.

Rescan the CPU's CPUID table in that case, not to have stale cached data.
Use parsed CPUID(0x0) access, instead of direct CPUID query, afterwards.

Rename squash_the_stupid_serial_number() to disable_cpu_serial_number()
and explain the rational for disabling the CPU's PSN.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/kernel/cpu/common.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 023613698b15..d74a098d259a 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -327,15 +327,17 @@ bool cpuid_feature(void)
 	return flag_is_changeable_p(X86_EFLAGS_ID);
 }
 
-static void squash_the_stupid_serial_number(struct cpuinfo_x86 *c)
+/*
+ * For privacy concerns, disable legacy Intel and Transmeta CPUID(0x3)
+ * feature, Processor Serial Number, by default.
+ */
+static void disable_cpu_serial_number(struct cpuinfo_x86 *c)
 {
 	unsigned long lo, hi;
 
 	if (!cpu_has(c, X86_FEATURE_PN) || !disable_x86_serial_nr)
 		return;
 
-	/* Disable processor serial number: */
-
 	rdmsr(MSR_IA32_BBL_CR_CTL, lo, hi);
 	lo |= 0x200000;
 	wrmsr(MSR_IA32_BBL_CR_CTL, lo, hi);
@@ -343,8 +345,12 @@ static void squash_the_stupid_serial_number(struct cpuinfo_x86 *c)
 	pr_notice("CPU serial number disabled.\n");
 	clear_cpu_cap(c, X86_FEATURE_PN);
 
-	/* Disabling the serial number may affect the cpuid level */
-	c->cpuid_level = cpuid_eax(0);
+	/*
+	 * Disabling CPUID(0x3) might affect the maximum standard CPUID
+	 * level.  Rescan the CPU's CPUID table afterwards.
+	 */
+	cpuid_parser_rescan_cpu(c);
+	c->cpuid_level = cpuid_leaf(c, 0x0)->max_std_leaf;
 }
 
 static int __init x86_serial_nr_setup(char *s)
@@ -354,7 +360,7 @@ static int __init x86_serial_nr_setup(char *s)
 }
 __setup("serialnumber", x86_serial_nr_setup);
 #else
-static inline void squash_the_stupid_serial_number(struct cpuinfo_x86 *c)
+static inline void disable_cpu_serial_number(struct cpuinfo_x86 *c)
 {
 }
 #endif
@@ -1968,7 +1974,7 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 	bus_lock_init();
 
 	/* Disable the PN if appropriate */
-	squash_the_stupid_serial_number(c);
+	disable_cpu_serial_number(c);
 
 	/* Set up SMEP/SMAP/UMIP */
 	setup_smep(c);
-- 
2.49.0


