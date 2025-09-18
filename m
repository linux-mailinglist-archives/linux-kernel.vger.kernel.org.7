Return-Path: <linux-kernel+bounces-822555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B63D3B84201
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 12:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D4111C8307B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD407305065;
	Thu, 18 Sep 2025 10:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z2v5hAYp"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432BE304BCC
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 10:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758191448; cv=none; b=jLFLmqx/FhJK/c7dZXhbEP/5MEYh7m6ef/RXSP7R3+EEQtb/qeRd1FPw3/Ie6PNabwac13AEYE4kf053oC1pieiGUm2E8BytZK1A8GR/Tx8uVPKwUmF7k2N6eSFMTg2nV6BcFvbnCeDLUgoJaGJWL2XTEbIxaXK6knD54rdhfNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758191448; c=relaxed/simple;
	bh=nj7i29BJluBpWURQYZUxvNADD0EB9W2SAuUGs1F5qNo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cfPkLVLPj7+2kQ2Ir5+zGn2j2zmubxSNqykczUcjIs+4iWbYwg2/9zJthq7Q/4q3cggNz2osw7AODRzW9ZVEMbcEGjmZfiKI7R/Y1KD1B7NztGOIxAoif+AP5aM3923mgamT+NLx/o79IQvzIEi2Ph8+7V8FnxmplH8DnBGQ4ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z2v5hAYp; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-62f9cfb8075so760288a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 03:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758191443; x=1758796243; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1LXz7drZR69NRcqoi9vT6ordOH/o85U4ZownXle33jo=;
        b=z2v5hAYpnReyIWnakau8oe5tl49Qq1x1VQj4Saa27PvWAA8cW8lsMXNZAUNepZuBsu
         n1QBXB209G1k6wmHEq1OOLfcmd5xXe6iF17CY6kbp6GbrKHJmCjTDIYdZhli562KCrF5
         CIvW2LeiuGUXC4EL89PtQoBIXTtJl0qNOzMlpdh53gVGVs5egn40ghbipQ1yYrusaN2d
         ZKfV31GniYO3vKveS06Cw/aef/sQFc8unE1BCNzfZ23Zvoxszzk1B/AJTfcYFjl/CwCG
         v8A4747j21EHN2a9DmC8Ze8D0gHpChq8ue+J1xSSxrm22c5CGLYIKaMqrakuA3/BHWcu
         KMSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758191443; x=1758796243;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1LXz7drZR69NRcqoi9vT6ordOH/o85U4ZownXle33jo=;
        b=rkTIDe1NRVTsFNFN73KTq625dKBusQGYH8Z5wbAh9HCgAyn6VOS8J9LYdkUYUVsa2K
         eh/Nc8FZsQlf/jyXjxmwOSLzOOIWknJ34mYlcyOiOTfzPx5Vt346RqgBETAaRWx3dnaT
         Pcuh5RDDLxu5rossgichyQmrZ+O3bz8xc1D3wVQ1cHBd76GyE3oHGf9PhmjxC23KYDyf
         u6v2ZKz/h0Xr5HOVnyixQ3Pt9deRNHZ/jeDGWpChIetBuG4LywTAQGFaN8AHThC45laC
         6A2f5ktQfwCdArNxL+SaH2fjhj3IGcdlpMTwVzwPQsS4PYGMpZh9euJK5Yx3xCpGKrE6
         ukWQ==
X-Gm-Message-State: AOJu0YzJ0IBZgB6lcp3S0LNpKwhv/0C41QMIhId8FbwyY0E7pNIgNlcu
	FtltYSFzD6I78plBf6GBGPUFgKCq/A7H6OEhiygtVh4ohvL+vUYFA+Q6HgWs1B1lS5STMjzSYA=
	=
X-Google-Smtp-Source: AGHT+IGUquYXpi2xrIo18MZawlB6gxNVwBfa77lbrIIZHKX8Fpb5Qx9xXEK4QYttljX7a5cizhaLtJAe
X-Received: from edbev11.prod.google.com ([2002:a05:6402:540b:b0:62f:f6a:43ba])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:5210:b0:62f:3721:fc8c
 with SMTP id 4fb4d7f45d1cf-62f846a13f7mr4583585a12.37.1758191443543; Thu, 18
 Sep 2025 03:30:43 -0700 (PDT)
Date: Thu, 18 Sep 2025 12:30:19 +0200
In-Reply-To: <20250918103010.2973462-10-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250918103010.2973462-10-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3226; i=ardb@kernel.org;
 h=from:subject; bh=AwRe+ieGv51rAlmd3os99ZtjQYVM4Fjtomg80IO3BGI=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIeP0ffu7Hx2rC6Yu2+C13jZCdw5DvK+nWau/35sVhftaX
 tp8npDfUcrCIMbFICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACbyIp6RYcV5l8DV7Qfd7C7x
 d5Wun8r8crV6ic8C9h1zMjXOSHO8v8rwP3F1/+/nc0s3B19zT/4R/KFS8CZb2eepvuv4xAMuFnN LcgMA
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250918103010.2973462-18-ardb+git@google.com>
Subject: [PATCH v3 8/8] arm64/efi: Call EFI runtime services without disabling preemption
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Ard Biesheuvel <ardb@kernel.org>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>
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

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/efi.c | 23 ++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index a60444dcec68..9b1603a69b69 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -10,6 +10,7 @@
 #include <linux/efi.h>
 #include <linux/init.h>
 #include <linux/kmemleak.h>
+#include <linux/kthread.h>
 #include <linux/screen_info.h>
 #include <linux/vmalloc.h>
 
@@ -181,7 +182,19 @@ bool arch_efi_call_virt_setup(void)
 	if (WARN_ON(!mutex_trylock(&efi_rt_lock)))
 		return false;
 
-	efi_virtmap_load();
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
@@ -207,7 +220,13 @@ void arch_efi_call_virt_teardown(void)
 	 */
 	uaccess_ttbr0_disable();
 
-	efi_virtmap_unload();
+	if (preemptible() && (current->flags & PF_KTHREAD)) {
+		kthread_unuse_mm(&efi_mm);
+		migrate_enable();
+	} else {
+		efi_virtmap_unload();
+	}
+
 	mutex_unlock(&efi_rt_lock);
 }
 
-- 
2.51.0.384.g4c02a37b29-goog


