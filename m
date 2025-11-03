Return-Path: <linux-kernel+bounces-883193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 31545C2CB6D
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 16:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 444174F2977
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 15:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F728324B0C;
	Mon,  3 Nov 2025 15:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EBwJJ0bx"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51937322DD4
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 15:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762182786; cv=none; b=ON9HtMEIkNo1Zn/M/Vv7gBK/V070hSyAUmo4GQ1ffAiv2yJ5L3HAMz8v9lwW5mifIFJvqttzoQW692nxXjkLxqJnkzC5xsbMKtP87PgF1anxdXZrX/XgEbQVZ4bih0pKIo+YP/EnMH3tU2b/2NYKcpqfFxXkcxZTCQmjqONA5Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762182786; c=relaxed/simple;
	bh=wxCkQ3oWnrj9sIpxebUDyyLvESGurzSFqY8w3aHLJ+o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ORmLmSpJYZeex/LOPIIb4/QmhhvosaYfWGfrLBKyVm+UJqPdOuvJ3Z+yXfPjBTsT70nQpQF9qcVJsPZbvlJbRuvAkYyiuYAAQMWQNmed/1IjSaxQLqCBS4sfH+SbiojRM4tJvTYs6bQmc7l5h7YvB/ItnxcBcCOrvTWxJYFGfQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EBwJJ0bx; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762182782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UafltDOZK3o7GUULuUsbhHg5VOoYolKyYZp0eSy1Ywc=;
	b=EBwJJ0bxo9Wky2GlFgZjtYcwDZOnhiFOzbi0B47ngO4yhe5H5TD6/rRI5sbLc8Dj8DTENX
	dLpwUFdf/aBYBbSczdfVcVtEvkQLIvGqB8NTlb7T3ZMUVIb/V2HYYyRw4C+BY3QV55kNy6
	N2u9W4ejzQrHIZDL+/rP8nVaJ3gK2sU=
From: Fushuai Wang <fushuai.wang@linux.dev>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org
Cc: hpa@zytor.com,
	peterz@infradead.org,
	brgerst@gmail.com,
	kai.huang@intel.com,
	wangfushuai@baidu.com,
	andrew.cooper3@citrix.com,
	linux-kernel@vger.kernel.org,
	Fushuai Wang <fushuai.wang@linux.dev>
Subject: [PATCH] x86/process: Use guard() macro in process.c
Date: Mon,  3 Nov 2025 23:12:27 +0800
Message-Id: <20251103151227.25950-1-fushuai.wang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The guard() macro will automatically execute cleanup when
leaving the scope. So this patch use guard() to simplify
to code.

Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
---
 arch/x86/kernel/process.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 4c718f8adc59..481010fb3aee 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -294,26 +294,24 @@ void flush_thread(void)
 
 void disable_TSC(void)
 {
-	preempt_disable();
+	guard(preempt)();
 	if (!test_and_set_thread_flag(TIF_NOTSC))
 		/*
 		 * Must flip the CPU state synchronously with
 		 * TIF_NOTSC in the current running context.
 		 */
 		cr4_set_bits(X86_CR4_TSD);
-	preempt_enable();
 }
 
 static void enable_TSC(void)
 {
-	preempt_disable();
+	guard(preempt)();
 	if (test_and_clear_thread_flag(TIF_NOTSC))
 		/*
 		 * Must flip the CPU state synchronously with
 		 * TIF_NOTSC in the current running context.
 		 */
 		cr4_clear_bits(X86_CR4_TSD);
-	preempt_enable();
 }
 
 int get_tsc_mode(unsigned long adr)
@@ -363,7 +361,7 @@ static void set_cpuid_faulting(bool on)
 
 static void disable_cpuid(void)
 {
-	preempt_disable();
+	guard(preempt)();
 	if (!test_and_set_thread_flag(TIF_NOCPUID)) {
 		/*
 		 * Must flip the CPU state synchronously with
@@ -371,12 +369,11 @@ static void disable_cpuid(void)
 		 */
 		set_cpuid_faulting(true);
 	}
-	preempt_enable();
 }
 
 static void enable_cpuid(void)
 {
-	preempt_disable();
+	guard(preempt)();
 	if (test_and_clear_thread_flag(TIF_NOCPUID)) {
 		/*
 		 * Must flip the CPU state synchronously with
@@ -384,7 +381,6 @@ static void enable_cpuid(void)
 		 */
 		set_cpuid_faulting(false);
 	}
-	preempt_enable();
 }
 
 static int get_cpuid_mode(void)
@@ -594,21 +590,19 @@ static __always_inline void amd_set_core_ssb_state(unsigned long tifn)
 
 		msr |= x86_amd_ls_cfg_ssbd_mask;
 
-		raw_spin_lock(&st->shared_state->lock);
+		guard(raw_spinlock_irq)(&st->shared_state->lock);
 		/* First sibling enables SSBD: */
 		if (!st->shared_state->disable_state)
 			wrmsrq(MSR_AMD64_LS_CFG, msr);
 		st->shared_state->disable_state++;
-		raw_spin_unlock(&st->shared_state->lock);
 	} else {
 		if (!__test_and_clear_bit(LSTATE_SSB, &st->local_state))
 			return;
 
-		raw_spin_lock(&st->shared_state->lock);
+		guard(raw_spinlock_irq)(&st->shared_state->lock);
 		st->shared_state->disable_state--;
 		if (!st->shared_state->disable_state)
 			wrmsrq(MSR_AMD64_LS_CFG, msr);
-		raw_spin_unlock(&st->shared_state->lock);
 	}
 }
 #else
@@ -687,20 +681,16 @@ static unsigned long speculation_ctrl_update_tif(struct task_struct *tsk)
 
 void speculation_ctrl_update(unsigned long tif)
 {
-	unsigned long flags;
-
 	/* Forced update. Make sure all relevant TIF flags are different */
-	local_irq_save(flags);
+	guard(irqsave)();
 	__speculation_ctrl_update(~tif, tif);
-	local_irq_restore(flags);
 }
 
 /* Called from seccomp/prctl update */
 void speculation_ctrl_update_current(void)
 {
-	preempt_disable();
+	guard(preempt)();
 	speculation_ctrl_update(speculation_ctrl_update_tif(current));
-	preempt_enable();
 }
 
 static inline void cr4_toggle_bits_irqsoff(unsigned long mask)
@@ -961,9 +951,8 @@ void amd_e400_c1e_apic_setup(void)
 {
 	if (boot_cpu_has_bug(X86_BUG_AMD_APIC_C1E)) {
 		pr_info("Switch to broadcast mode on CPU%d\n", smp_processor_id());
-		local_irq_disable();
+		guard(irq)();
 		tick_broadcast_force();
-		local_irq_enable();
 	}
 }
 
-- 
2.36.1


