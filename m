Return-Path: <linux-kernel+bounces-830824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7B5B9AA76
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A6CD1B242BC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB71D311C27;
	Wed, 24 Sep 2025 15:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uPHuLho9"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C235311580
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 15:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758727652; cv=none; b=BZWPSC3Vq8Zbh84FBUodPQ3jnFbHYKWUDSXVtTaYeGibr9nMPlkzJakFbqClBfFzWNegIFRtoLqcva8syrFSnXPgCmUgwJ20dR9dloPaM3d4xBbUK1+aMtjvytlIQSR9iGc5OhmHDrubdku93zGsD8mpAfmgg1OYy3yF7SYMK5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758727652; c=relaxed/simple;
	bh=Y9G9ZcpuP4jyflsfcA7Yauxl9RDI9adiNi9OlP5g1sk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eHbzLB/zHpZJ4/qnxFJrcgjD4yYSsVkIJTL825RsijSAre5owlR1CAXSBzuS+X0nJRJjCSdPNL4sKsi/xGzELomcILGAK+pd1+uZ2tJzxqEJvieGN0ZmZTJHZu+GTlwZPZvq+1eN1wwAJF0A7jnRSQtl49NOlVtfO2+tXmkxv8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uPHuLho9; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-62fd7f9857cso2136614a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 08:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758727649; x=1759332449; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=j8cxVw/7cCYHvLHRmPD20gr9/jU6KZGxeKnW/6kPkh4=;
        b=uPHuLho98P3cGyVzhcwV++CZNO36MEF3vzwxsa6I73Bh5uqjez4gjjc0HdcLfKHFgs
         xzkDAgzLxE+E6zulSQOnCBklFK+15Aq+UeTJYJ6Hx2bz7dmHlOGM//F9t1eLFsMNZeYW
         OKfM68JUYevJgElvCdirMIZDaQGri9y9JAcWI0KMTCNaCzz1+z2hPpFzrIGFsfuclo/t
         90ZrwTnJHB2C6bcwKDGftP6Z36jfB1Yi1ElCf8cn98M2wM8CUTDKxsXZdtC38lTon4zD
         PfEuKNksr74tKOx6xlHZHZLJUqLZ9KVZH3dlNgOHh4TUFBBSIHNm1Q9ENTcM7qMdFV3g
         z78w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758727649; x=1759332449;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j8cxVw/7cCYHvLHRmPD20gr9/jU6KZGxeKnW/6kPkh4=;
        b=rufdsZn0lwwRaXKlnmKVek9YvdyQF5sRhDTuoY2Wt9pqt9Xcfr6F5k/M5+zd6BaaTf
         ka9N3abPrc0CBEUyeDGGbBPH/xJIb38Y+wqdwbCBZbT/1Axif88qNtLHs11kPFg7ykDI
         +OKLgahMd+/GSHsHjmJgqPo9g82toZA0b8OTU/BeReYiYmdf49ZaPg7ZuBLKGRI4e0OC
         RlqL/dJu8uvnPUQsn7KrzR9W8Ql7wgVzl8Idgs4gleGVEYMakZR8gvrmx+aSHMMwvsgL
         OMtTPcrj7Jasv2dqyI+HTdbXop//Ks1MynICPFfm2udOhCxyh52LqhN90y86T4ZTC7Ke
         Q+8w==
X-Gm-Message-State: AOJu0YzBtU5v2vVLAECj7ULupL07bLDRqVaWPQKF/6SvbdP+V8F9qUIh
	CrSDE6qxtH26KVnfbE/Kn2DsDfB8VaUN4c5SqjBv2q8xqr2VPDVopfSF2vVSOMEDtAuV0GM70g=
	=
X-Google-Smtp-Source: AGHT+IH4bVunQjsBO/jFeFQ/40wQ6/8E/Cc61XBJcsk8PC0On7+XU7q5CsbrMyF4FwtbVkJiBxDn5Gl8
X-Received: from edc10.prod.google.com ([2002:a05:6402:460a:b0:631:d068:2197])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:3553:b0:62f:5992:a64a
 with SMTP id 4fb4d7f45d1cf-634677b5aa0mr6138973a12.13.1758727649406; Wed, 24
 Sep 2025 08:27:29 -0700 (PDT)
Date: Wed, 24 Sep 2025 17:26:56 +0200
In-Reply-To: <20250924152651.3328941-9-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250924152651.3328941-9-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3253; i=ardb@kernel.org;
 h=from:subject; bh=VXQIH5e7qk0odJJeP5mqROl0N0Kotb4txaIG+Rdz7OQ=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIeMK75EVtWHbDBr3pDX8rbf32+8eueq4P9vfBO7u4CDBT
 UtS9/R1lLIwiHExyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIns5mD4H32F995U74DtPb4R
 +buOif/bad73KDLz9V6OTTfShC5dbGdkuL8nPmmZs/qkfYGxy5N+RH/LWyGenmPwTlHv6edf6tE LmAA=
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250924152651.3328941-13-ardb+git@google.com>
Subject: [PATCH v4 4/7] arm64/fpsimd: Permit kernel mode NEON with IRQs off
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Ard Biesheuvel <ardb@kernel.org>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Currently, may_use_simd() will return false when called from a context
where IRQs are disabled. One notable case where this happens is when
calling the ResetSystem() EFI runtime service from the reboot/poweroff
code path. For this case alone, there is a substantial amount of FP/SIMD
support code to handle the corner case where a EFI runtime service is
invoked with IRQs disabled.

The only reason kernel mode SIMD is not allowed when IRQs are disabled
is that re-enabling softirqs in this case produces a noisy diagnostic
when lockdep is enabled. The warning is valid, in the sense that
delivering pending softirqs over the back of the call to
local_bh_enable() is problematic when IRQs are disabled.

While the API lacks a facility to simply mask and unmask softirqs
without triggering their delivery, disabling softirqs is not needed to
begin with when IRQs are disabled, given that softirqs are only every
taken asynchronously over the back of a hard IRQ.

So dis/enable softirq processing conditionally, based on whether IRQs
are enabled, and relax the check in may_use_simd().

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/simd.h |  2 +-
 arch/arm64/kernel/fpsimd.c    | 25 +++++++++++++++-----
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/simd.h b/arch/arm64/include/asm/simd.h
index 8e86c9e70e48..abd642c92f86 100644
--- a/arch/arm64/include/asm/simd.h
+++ b/arch/arm64/include/asm/simd.h
@@ -29,7 +29,7 @@ static __must_check inline bool may_use_simd(void)
 	 */
 	return !WARN_ON(!system_capabilities_finalized()) &&
 	       system_supports_fpsimd() &&
-	       !in_hardirq() && !irqs_disabled() && !in_nmi();
+	       !in_hardirq() && !in_nmi();
 }
 
 #else /* ! CONFIG_KERNEL_MODE_NEON */
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index d26a02ea2bb9..5af3043fb0ca 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -225,10 +225,21 @@ static void fpsimd_bind_task_to_cpu(void);
  */
 static void get_cpu_fpsimd_context(void)
 {
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
-		local_bh_disable();
-	else
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		/*
+		 * The softirq subsystem lacks a true unmask/mask API, and
+		 * re-enabling softirq processing using local_bh_enable() will
+		 * not only unmask softirqs, it will also result in immediate
+		 * delivery of any pending softirqs.
+		 * This is undesirable when running with IRQs disabled, but in
+		 * that case, there is no need to mask softirqs in the first
+		 * place, so only bother doing so when IRQs are enabled.
+		 */
+		if (!irqs_disabled())
+			local_bh_disable();
+	} else {
 		preempt_disable();
+	}
 }
 
 /*
@@ -240,10 +251,12 @@ static void get_cpu_fpsimd_context(void)
  */
 static void put_cpu_fpsimd_context(void)
 {
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
-		local_bh_enable();
-	else
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		if (!irqs_disabled())
+			local_bh_enable();
+	} else {
 		preempt_enable();
+	}
 }
 
 unsigned int task_get_vl(const struct task_struct *task, enum vec_type type)
-- 
2.51.0.534.gc79095c0ca-goog


