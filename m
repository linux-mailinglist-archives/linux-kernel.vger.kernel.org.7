Return-Path: <linux-kernel+bounces-802834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 42717B45780
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2624B4E6086
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21497350D6F;
	Fri,  5 Sep 2025 12:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B2JfNfy+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bQnChvHy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE0B350856
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 12:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757074555; cv=none; b=jFYNyLSH3RY7ozRUrHYhtwJDSCiuAEbtmTIArEGqwZvLgeLQAmdCqNj58kjpuvMl1TvnV9NE11qr4c+vKY9koiCILkGzgxR/eTAxhItfHH+dvlaYC1kqM+HxzjajGXgW4zAZU/G5S4TwYn9NXRyjyiae6jURfLXurZIa9qQmPoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757074555; c=relaxed/simple;
	bh=CZQxvJ8yZW2Uybl6DNxQviBz3JoFOy/YVYuEocyTwn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U+RMMSRvhg2dM/cCIpQayrbDqiY/sZtf26Me7837M+RBDUCJkgLJeeNHamgUOrnikHhxxGY+tXEETaPbeifmSOZsnZ+2wV002iZxZrSp0ef1hZEKjI3p8koXvEYXHMz8KiUg+iC8mRmLCO6ix3C8uhJXoiPeZ2LXW2Tz3xR19yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=B2JfNfy+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bQnChvHy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757074551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pV8btSTDmEhVwNVX3DuRLi9n1R7LR7F6k5vsNfqRbDo=;
	b=B2JfNfy+9ybYMxYNnXVMtsvNCnRA9ny79B9zuCGUWJAZBZZIVfdCXvRyP6z7d68ExeNytm
	QCz+6u0qDQ+I+F9gJqgcROdNO6n1GB61ZtVfdFRSatlC9eUXL8ogmf1MZnX4CVzVc6uuUk
	BiiqarrstuYA0yKMzEEjD/YNEaScMBZWCUrUCPOt+sgb3rcrsFRGzloilNSde0vPjdRJpf
	iTUiHKMdlBzD4QRK0JwwomfYOB3XYJOXdqRT0Inlguuu+7Q60HzbdDIL+umBv0m9O96zM/
	43Rb5+ft/2BJXVfXHLYfS4P5O6MxI2+GYCDXtXpOZNK/yne6+Qs9fpl3Q8KZXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757074551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pV8btSTDmEhVwNVX3DuRLi9n1R7LR7F6k5vsNfqRbDo=;
	b=bQnChvHyCXrLC0Ew9zpnTOKqLFDKSeOGn84GuyFZiZ0U+jZr+cxoJqZRxdVrxBtx8Zi05p
	yvK43YNoUEdWI8CA==
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
Subject: [PATCH v5 10/35] x86/lib: Add CPUID(0x1) CPU family and model calculation
Date: Fri,  5 Sep 2025 14:14:50 +0200
Message-ID: <20250905121515.192792-11-darwi@linutronix.de>
In-Reply-To: <20250905121515.192792-1-darwi@linutronix.de>
References: <20250905121515.192792-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The x86 library code provides x86_family() and x86_model().  They take
raw CPUID(0x1) register output, extract the necessary fields with bitwise
operations, then calculate the CPU family and model out of that.

In follow-up work, the x86 subystem will use parsed CPUID access, along
with its auto-generated <asm/cpuid/leaf_types.h> CPUID leaf data types,
instead of direct CPUID access.

Introduce x86 family and model calculation functions to x86/lib that take
such auto-generateds 'struct leaf_0x1_0' data types.  Refactor the
original bitwise operations code so that no logic is duplicated.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/include/asm/cpu.h |  6 ++++++
 arch/x86/lib/cpu.c         | 41 ++++++++++++++++++++++----------------
 2 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index ad235dda1ded..90902cd91335 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -7,7 +7,9 @@
 #include <linux/topology.h>
 #include <linux/nodemask.h>
 #include <linux/percpu.h>
+
 #include <asm/ibt.h>
+#include <asm/cpuid/leaf_types.h>
 
 #ifndef CONFIG_SMP
 #define cpu_physical_id(cpu)			boot_cpu_physical_apicid
@@ -25,6 +27,10 @@ int mwait_usable(const struct cpuinfo_x86 *);
 unsigned int x86_family(unsigned int sig);
 unsigned int x86_model(unsigned int sig);
 unsigned int x86_stepping(unsigned int sig);
+
+unsigned int cpuid_family(const struct leaf_0x1_0 *l);
+unsigned int cpuid_model(const struct leaf_0x1_0 *l);
+
 #ifdef CONFIG_X86_BUS_LOCK_DETECT
 extern void __init sld_setup(struct cpuinfo_x86 *c);
 extern bool handle_user_split_lock(struct pt_regs *regs, long error_code);
diff --git a/arch/x86/lib/cpu.c b/arch/x86/lib/cpu.c
index 7ad68917a51e..eac217d637ac 100644
--- a/arch/x86/lib/cpu.c
+++ b/arch/x86/lib/cpu.c
@@ -1,36 +1,43 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <linux/types.h>
 #include <linux/export.h>
+
 #include <asm/cpu.h>
+#include <asm/cpuid/leaf_types.h>
 
-unsigned int x86_family(unsigned int sig)
+static unsigned int __x86_family(unsigned int base_fam, unsigned int ext_fam)
 {
-	unsigned int x86;
-
-	x86 = (sig >> 8) & 0xf;
+	return (base_fam == 0xf) ? base_fam + ext_fam : base_fam;
+}
 
-	if (x86 == 0xf)
-		x86 += (sig >> 20) & 0xff;
+static unsigned int
+__x86_model(unsigned int family, unsigned int base_model, unsigned int ext_model)
+{
+	return (family >= 0x6) ? base_model | ext_model << 4 : base_model;
+}
 
-	return x86;
+unsigned int x86_family(unsigned int sig)
+{
+	return __x86_family((sig >> 8) & 0xf, (sig >> 20) & 0xff);
 }
 EXPORT_SYMBOL_GPL(x86_family);
 
-unsigned int x86_model(unsigned int sig)
+unsigned int cpuid_family(const struct leaf_0x1_0 *l)
 {
-	unsigned int fam, model;
-
-	fam = x86_family(sig);
-
-	model = (sig >> 4) & 0xf;
-
-	if (fam >= 0x6)
-		model += ((sig >> 16) & 0xf) << 4;
+	return __x86_family(l->base_family_id, l->ext_family);
+}
 
-	return model;
+unsigned int x86_model(unsigned int sig)
+{
+	return __x86_model(x86_family(sig), (sig >> 4) & 0xf, (sig >> 16) & 0xf);
 }
 EXPORT_SYMBOL_GPL(x86_model);
 
+unsigned int cpuid_model(const struct leaf_0x1_0 *l)
+{
+	return __x86_model(cpuid_family(l), l->base_model, l->ext_model);
+}
+
 unsigned int x86_stepping(unsigned int sig)
 {
 	return sig & 0xf;
-- 
2.50.1


