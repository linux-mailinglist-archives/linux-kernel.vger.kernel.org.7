Return-Path: <linux-kernel+bounces-770344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9F4B279C3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59FDDAC50DD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 07:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF5C2F60BE;
	Fri, 15 Aug 2025 07:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n0QHX90g";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="81YNADR+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BFB2F60BF
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 07:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755241607; cv=none; b=MZZ2NPNtR5VPeAbtkz/rUEpBcu1byjGWH7Ta2AJlN7hk0Tr7z5DMEpppxUQcoljcyecInZZtLI7MW3JgJDZl+gKgKtAmEY/e5v7an/1kxgvODUk77tfBrK44/aZpCwL2d/BtnreZ4aw7K70krIW8IFDVwku/Sn7SBwinp9CnoUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755241607; c=relaxed/simple;
	bh=T2jnn7H6An6ZppQ8C2g482EY7glbALuRPrTUlZ2ModI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WeriwiZbdDwl3FEEAa0ZD4sAfJVkoHxLrceElS1cybOOWYQWb2Y4KrXPLeJNK6mr6v4BgyddcAXywDQ8zCWTD/gFwg5KswgYx0UO8+2UZDyQDVcHrXetNYYz32w70rtP/s3JT+Pa23Th00NDykita2pwZeUwhmFPpd/O+7IiHPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n0QHX90g; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=81YNADR+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755241604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bh9Q+43+awkKttwJOUI2IJgf6MviDp6qy9I4KiU3rzo=;
	b=n0QHX90gFZBah4XR8zxrSGyBgU3pZxHA3HojKpD9RGqaShRGBiwlxJgcAvZoI6NrzdWao9
	ket80TqZt1W1KNgGyBNbYWqwhVVJ40ywSXDIFI6Etrk8UhjRE/UpQm1nVmqQeZJaMcba2B
	M+Gwtp2o93ds40bpVIX/RAD+jSJ0uXlYkIazPhiRRoV2nR+En7ykSdH7mdvSvJruI+mo0Q
	TUVIwTWQbmsJOZJFppBokYMDM5SuUKQ+Ra0gPZL7E741Tb+GjKKt0bedaS5oX2R7N5QyY+
	bNUdy9zG2D/ifA4OytekhH4uMaY0PV5VA2og6dbGgkrKNsfgNOxIrJweSSfI+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755241604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bh9Q+43+awkKttwJOUI2IJgf6MviDp6qy9I4KiU3rzo=;
	b=81YNADR++sVu+/aprF/C2Jxl2DhXPGcveP5AaMepBEHK6qdTCesTBV3/clcUoN3aIUJgnX
	1zowbf8SfkzdmpDQ==
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
Subject: [PATCH v4 31/34] x86/cpu: Rescan CPUID table after PSN disable
Date: Fri, 15 Aug 2025 09:02:24 +0200
Message-ID: <20250815070227.19981-32-darwi@linutronix.de>
In-Reply-To: <20250815070227.19981-1-darwi@linutronix.de>
References: <20250815070227.19981-1-darwi@linutronix.de>
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
index 048b285e7741..64038637bf4a 100644
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
@@ -1982,7 +1988,7 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 	bus_lock_init();
 
 	/* Disable the PN if appropriate */
-	squash_the_stupid_serial_number(c);
+	disable_cpu_serial_number(c);
 
 	/* Set up SMEP/SMAP/UMIP */
 	setup_smep(c);
-- 
2.50.1


