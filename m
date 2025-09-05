Return-Path: <linux-kernel+bounces-802857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4A1B457A5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 982E63B85F5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5014135CECB;
	Fri,  5 Sep 2025 12:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FKm6tFG5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ltWo3yiN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0973A35CEB8
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 12:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757074631; cv=none; b=Ij/IqCaX7umUD1C+iOEyhwudjeQf6WPjRF5XDxKKI606yyLfpWNEUnSSorzPPrAm922zWfgzESd7O00qIq9Ky2o9LGq7Gb+K+iUJwVy6p2n3V5AsdPft7JPX2C8drQEBsSwdfYJLSK/MhBtTRz9P1rBxx8i4CkPmU6qUvrz6tg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757074631; c=relaxed/simple;
	bh=g+3E6nDj5KS1CrR0tozgVXmymJ5NVXDPP0PSmHwU7uo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HutfdajJGaf994fUbyA+E8Aibid2GIfUksCRLSPahDtovjLl1SalHiF3n8/ubZQ+eSEJXdK39XtTz/ZoTof43IqAM5F9Mln4yUsbzk2zVqmI44J+R31+O0YOJgKmqGsSSRW1VksRFa4eiPbdBOWtOYLVx1BkHhf3TimTySD+rJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FKm6tFG5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ltWo3yiN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757074628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iO/bLlHOMbYL2N9P2uJRmHVZGJlxMv6LsNM4sHKXhzg=;
	b=FKm6tFG5qxy2u5MQvZmwb05xQnkMS+J67+9q6yen1+RpY5u41NWhVP9thfYMaS9vQwXzf2
	13+DTYY1IGZ5JXhiD4uooShYjnl3S7SDRiAew+zKHqBMZ5T9KQASPfBDlovpEMkhuxqp6j
	wAntSB3CRnc+rnP5ukn5R11gtN3yZFsbj+8JweNyf5/qOX9T42PV7wwD6MFUpVKcV/0tSi
	MIAQYZGaUfwlTQJ9gayIcOzxg+Eyvu3x9Z+1sikm+QXCCnXCfj2SINaXbC5uo2qsDec5MS
	/SbWanFqwAyA0ubsfBvsKeiqV0/yveRzbgEGCotnvG2CjBbC2vMaml1YxaAbaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757074628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iO/bLlHOMbYL2N9P2uJRmHVZGJlxMv6LsNM4sHKXhzg=;
	b=ltWo3yiN6JMk7mBT3LL/qPoUmXzHt5NTCd2MsU90qvD4MObJGmfNwSXOfdDPv5hHIFbeVu
	1x6i9cSdIlQ0feDw==
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
Subject: [PATCH v5 32/35] x86/cpu: Rescan CPUID table after PSN disable
Date: Fri,  5 Sep 2025 14:15:12 +0200
Message-ID: <20250905121515.192792-33-darwi@linutronix.de>
In-Reply-To: <20250905121515.192792-1-darwi@linutronix.de>
References: <20250905121515.192792-1-darwi@linutronix.de>
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
index b439f7cd0931..2867111ae40b 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -328,15 +328,17 @@ bool cpuid_feature(void)
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
@@ -344,8 +346,12 @@ static void squash_the_stupid_serial_number(struct cpuinfo_x86 *c)
 	pr_notice("CPU serial number disabled.\n");
 	clear_cpu_cap(c, X86_FEATURE_PN);
 
-	/* Disabling the serial number may affect the cpuid level */
-	c->cpuid_level = cpuid_eax(0);
+	/*
+	 * Disabling CPUID(0x3) might have affected the maximum standard
+	 * CPUID level.  Rescan the CPU's CPUID table afterwards.
+	 */
+	cpuid_parser_scan_cpu(c);
+	c->cpuid_level = cpuid_leaf(c, 0x0)->max_std_leaf;
 }
 
 static int __init x86_serial_nr_setup(char *s)
@@ -355,7 +361,7 @@ static int __init x86_serial_nr_setup(char *s)
 }
 __setup("serialnumber", x86_serial_nr_setup);
 #else
-static inline void squash_the_stupid_serial_number(struct cpuinfo_x86 *c)
+static inline void disable_cpu_serial_number(struct cpuinfo_x86 *c)
 {
 }
 #endif
@@ -1985,7 +1991,7 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 	bus_lock_init();
 
 	/* Disable the PN if appropriate */
-	squash_the_stupid_serial_number(c);
+	disable_cpu_serial_number(c);
 
 	/* Set up SMEP/SMAP/UMIP */
 	setup_smep(c);
-- 
2.50.1


