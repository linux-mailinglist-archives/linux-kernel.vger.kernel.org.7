Return-Path: <linux-kernel+bounces-855290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A31BE0BEE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 23:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 63A944F9374
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 21:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E76303C86;
	Wed, 15 Oct 2025 21:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jTd2Opgm"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DE6303A08
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 21:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760562072; cv=none; b=YiawpP8XWGHBQEcdWqa2kWdPyhK/sGKgfgyfSl74h4vYDNsrUj+S/XJLoW6V6afCReYQl22mPp/tDuogzI3WfGTOlKgtxt4dID8/FM1Il99juoCo1bzeEZuSxLzgvMJaYR75PkyiXn4SluLcfE64zKd/fpf5wLTFHr56L4X3SFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760562072; c=relaxed/simple;
	bh=GEasR0yp9JDDzCfLFtnK5FtUGxYfMchQqiNVE7LLkTk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=APdyQpIUwc7n9tBXJY8O4Yd3YO6M1Lug4GAHqjijuD2VJU1z7kzeIP2RhmsHmH9GQNkMR0Ip1P/JEZQgoAiT4Dv0Yqk/w5AqjpWX3kSfnx/IsSmcMYYD/MZPlcsyI7e87kZgtZ+uPL43COOZgYl3BKNQaCO9fZ4Y3AiCdT1PeGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jTd2Opgm; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-471001b980eso197995e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 14:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760562069; x=1761166869; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MfJeYBJf9dKVExNOryhisMuvn1pJYVbY2e0JV1a62gs=;
        b=jTd2OpgmyULeNfFVLwsjcL+xqNoq/yBMHY9hXeVF1waW2yYOpcWHPNyKaBaxCl8ich
         YuqT8iiRXTKj1klWpEHouas8+hV5s0t56b6LeBDGU76jh5TNIb69ANKcsLZxLxfN2dGT
         6cTYUjWOB1kGK5dm7ji8hwTXON+M8xSOLxNAQx0ZKZQTRT5LDU8SNmwHezs/ATCvCfDW
         xtFqXYoNQ2H74kuGLyp5f7HdAprWUQ/4v9rd1G6hqeCt4jU/ur6fmQJNFqEYyy6DNpP1
         +cKVO8tFSKIG+OotbnM+ce92U9551rEAS+nmexXgepVfr07VqtMAI7HXChwRM7dR3546
         8UHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760562069; x=1761166869;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MfJeYBJf9dKVExNOryhisMuvn1pJYVbY2e0JV1a62gs=;
        b=b1uac2Mt68OUnUJMibkW7xTaruBQ8HCb2KUzfNRNDt73KivmnJHLEb78zCZRIF3pxu
         oouTXiHq4GVDv22TFLvmG0T7EkZwXIrT2HxOkfN11rbNHlmPlF9kSNZyO0bNyLbyHbWK
         4CCFn5YbAsS+Fy9QJ9MYSLdpR7ERbbLRlBv31eBCY8GKyIFlhkZgGv8/ddnCSJBct2F5
         ohbIDhIcv+v1MojBwK15PnNBPT3+1p4Lx6LUx0b9IVCu1k4OGRAndok+SJrSb/q7ryq2
         02VY0wzSGKi8nF++udLwLg0fQnDeJIPKKHyjdfhu6Nz6V3xjaMaWpOojAmUIlghOardX
         Hmnw==
X-Gm-Message-State: AOJu0YykUTFf1sXwnSCJUB/YuTEVjw2jXrvCS68t5FuZ22a8UJ3nnonb
	HFkYpXmsrMKklqoWef5Cmz2JN3WbvbbB5IZ0K0Ze/dYBC6ob9fz07/Qp3KwFiEW0Cmh4FZyQ8Q=
	=
X-Google-Smtp-Source: AGHT+IG+9dkTmwOQEgWRMCLUBLZu1hNOQYGDhgDBr9mXwrcUJWepG/mZYYY9jhBrgkyuHclPeYFheC4j
X-Received: from wmwq23.prod.google.com ([2002:a05:600d:8357:b0:46e:32e6:eb8f])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:c162:b0:46e:4a60:ea2c
 with SMTP id 5b1f17b1804b1-46fa9b17e57mr225565295e9.37.1760562069252; Wed, 15
 Oct 2025 14:01:09 -0700 (PDT)
Date: Wed, 15 Oct 2025 22:56:42 +0200
In-Reply-To: <20251015205634.3820870-9-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251015205634.3820870-9-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3342; i=ardb@kernel.org;
 h=from:subject; bh=V3JoExKah8YdhW3E7vX+STaF9jmPPtKMQXsXC3Dx8GU=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIeMDV6/Jz242lTS+WVIXjoZvt3DsOfpAQDKj6UxbRA9vo
 bXjjfSOUhYGMS4GWTFFFoHZf9/tPD1RqtZ5lizMHFYmkCEMXJwCMBEdI4Y/XAwX+9rNX0+Rdvlo
 fmVqpOjpZaUz1A+KsFpfrfn4ouyyDsMvZl2bLeJTdxe9UkgwLf07P13Kmv9tW+TczqTrKaXqwTw sAA==
X-Mailer: git-send-email 2.51.0.869.ge66316f041-goog
Message-ID: <20251015205634.3820870-16-ardb+git@google.com>
Subject: [PATCH v4 resend 7/7] arm64/efi: Call EFI runtime services without
 disabling preemption
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Ard Biesheuvel <ardb@kernel.org>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>, 
	Pierre Gondois <Pierre.Gondois@arm.com>, Sami Mujawar <Sami.Mujawar@arm.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The only remaining reason why EFI runtime services are invoked with
preemption disabled is the fact that the mm is swapped out behind the
back of the context switching code.

The kernel no longer disables preemption in kernel_neon_begin().
Furthermore, the EFI spec is being clarified to explicitly state that
only baseline FP/SIMD is permitted in EFI runtime service
implementations, and so the existing kernel mode NEON context switching
code is sufficient to preserve and restore the execution context of an
in-progress EFI runtime service call.

Most EFI calls are made from the efi_rts_wq, which is serviced by a
kthread. As kthreads never return to user space, they usually don't have
an mm, and so we can use the existing infrastructure to swap in the
efi_mm while the EFI call is in progress. This is visible to the
scheduler, which will therefore reactivate the selected mm when
switching out the kthread and back in again.

Given that the EFI spec explicitly permits runtime services to be called
with interrupts enabled, firmware code is already required to tolerate
interruptions. So rather than disable preemption, disable only migration
so that EFI runtime services are less likely to cause scheduling delays.
To avoid potential issues where runtime services are interrupted while
polling the secure firmware for async completions, keep migration
disabled so that a runtime service invocation does not resume on a
different CPU from the one it was started on.

Note, though, that the firmware executes at the same privilege level as
the kernel, and is therefore able to disable interrupts altogether.

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/efi.c | 23 ++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index 85f65d5c863c..a81cb4aa4738 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -10,6 +10,7 @@
 #include <linux/efi.h>
 #include <linux/init.h>
 #include <linux/kmemleak.h>
+#include <linux/kthread.h>
 #include <linux/screen_info.h>
 #include <linux/vmalloc.h>
 
@@ -168,7 +169,20 @@ asmlinkage efi_status_t efi_handle_corrupted_x18(efi_status_t s, const char *f)
 void arch_efi_call_virt_setup(void)
 {
 	efi_runtime_assert_lock_held();
-	efi_virtmap_load();
+
+	if (preemptible() && (current->flags & PF_KTHREAD)) {
+		/*
+		 * Disable migration to ensure that a preempted EFI runtime
+		 * service call will be resumed on the same CPU. This avoids
+		 * potential issues with EFI runtime calls that are preempted
+		 * while polling for an asynchronous completion of a secure
+		 * firmware call, which may not permit the CPU to change.
+		 */
+		migrate_disable();
+		kthread_use_mm(&efi_mm);
+	} else {
+		efi_virtmap_load();
+	}
 
 	/*
 	 * Enable access to the valid TTBR0_EL1 and invoke the errata
@@ -193,7 +207,12 @@ void arch_efi_call_virt_teardown(void)
 	 */
 	uaccess_ttbr0_disable();
 
-	efi_virtmap_unload();
+	if (preemptible() && (current->flags & PF_KTHREAD)) {
+		kthread_unuse_mm(&efi_mm);
+		migrate_enable();
+	} else {
+		efi_virtmap_unload();
+	}
 }
 
 asmlinkage u64 *efi_rt_stack_top __ro_after_init;
-- 
2.51.0.869.ge66316f041-goog


