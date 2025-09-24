Return-Path: <linux-kernel+bounces-830827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6718B9AA6D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F87D4C2EFE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3192C2FE570;
	Wed, 24 Sep 2025 15:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0CX7I7lo"
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AE43148B8
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 15:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758727656; cv=none; b=o0bnsd7cCn9+RQhCk2CFkuKON3nLSvgIjvTp8h2WwFdRnQzPQKdbxA6zj7UPnWpceW2OoOnCEZxjoGrHLKoR19JYKlH/4Stc8PDxEUvksr92JkxCSCeoRJEVyjwAL6vqoX/kiNYgobAHiDDV4HoiLFAc1cxwy515Ia7Zh6OGsLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758727656; c=relaxed/simple;
	bh=yPsv4tmUGpx19aaWjDO9Ojm0C3uT1FNckcRU2Atthqo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JOUj01tWThTwalcMB3TDHzYSOzeBpEdG871EAAo47oD4aUQH/MTLpS4QC8Tlv0imlxmox43Fz2WZaepfpbAGTdc2+4s14nLLdGVqi0fUwzUnOZ1GJmrpr1rU5tOnFHf7IDcjIKYZ89n+n4sH0L+mAEpsrMqhJFyiPqQx4Mik4pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0CX7I7lo; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-b2f989de76eso113969866b.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 08:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758727653; x=1759332453; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sPyujSEjHofHg9YDm/Jyl8IxXmB1G+6YXd/CQAOVg0g=;
        b=0CX7I7loixeIXvyjRribwVAXyCXNuurxqeoHL6SfonIyrkGJl8iVsaPStkijx4sERE
         NTi1mETxlsSB2BtqrKjcrd+ugQjkVX3rKZt81J91y5EqhAoOlUqjwDxr6HAmKKUqJkhB
         ltvpO/gqIVG05zcQlvi4BBvGudqzfn2P9J5RLXmerahrBGiUS4kpMlED2OWsqZ65lM2q
         pACui5rGBWJWGtwzrly41g5B5n2hLvePj5ZyyNYvipTHCEDO2UIzZZ448WM3UKhgBIf5
         gFtnjjcO8mZX3JMRyapB57Rx/HZ2Zpkl1S8e/oc2OaAD2yKdGnkA/pVUieN1XPtAmgPd
         iS2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758727653; x=1759332453;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sPyujSEjHofHg9YDm/Jyl8IxXmB1G+6YXd/CQAOVg0g=;
        b=XVyCZ7HixkdgR4CgIPGtRH42/iN7JBcRJVjTv1OUEQfeSUU0x5LMqj/bUBhDikIJep
         f48AzWdSGCZV8w7HY6Ufb+H8R8m62U4ax6JJilaNJsdrGFzTsm7oLS/ZM/G00wqll/5Y
         DwYqSGzK/9ouqyGFqJriDoDasSaGmrMwC+tiQ3MsK4AxYMevLU2b501VncjZlp2qwf+S
         1Y8D6O5AUEOcaBwjKxR4kXo2e69rkpueELKKl6ZYeHNv4y+vm5tr2wS45ayOrTGlX9I5
         nj2/gCgM/CYGQLbT4G8Ryjte2lpmgZaTdrtLHa/IRMUhnqV//ofeE5FFei8JCa1GTqsC
         r9ng==
X-Gm-Message-State: AOJu0YwQwU2DrxDzwEHP49ldfnanh06/uHvs958kitsWEZE0oocyhTbZ
	TxCiRruOBT2ROdR3MDyGGTAiqMYzzNKjb2xVFpJM8OVx4BMXy2uUCqsQbtlhS+uHLxRTRj42Dg=
	=
X-Google-Smtp-Source: AGHT+IGhYJri2jw2StcIcnozNtBl5X8wH5wzUecPXuiOreaVtyiBeuhRrBBP2IZw5zrKucj7w3PXpApx
X-Received: from ejcvk3.prod.google.com ([2002:a17:907:cbc3:b0:b29:9df3:352a])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:868e:b0:b0d:400:9182
 with SMTP id a640c23a62f3a-b34d97c9779mr811566b.22.1758727652921; Wed, 24 Sep
 2025 08:27:32 -0700 (PDT)
Date: Wed, 24 Sep 2025 17:26:59 +0200
In-Reply-To: <20250924152651.3328941-9-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250924152651.3328941-9-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3342; i=ardb@kernel.org;
 h=from:subject; bh=CE858YGwYUY/DV8BNXHqb59oe3QHOpqPxAjPh5x7H10=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIeMK78lkzuc7891fhPp9vvPkx4xPP3bezZiqJb6oYdLRh
 TEarxokO0pZGMS4GGTFFFkEZv99t/P0RKla51myMHNYmUCGMHBxCsBEGi8z/Hd1spzUWVpgZF90
 X8z6fe7v11eNVF17d278MLOa9d8kgWuMDPt8rfx/a1xa9mXKu5QAjQm8v38xlUyfPN/i54RAQVF zYS4A
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250924152651.3328941-16-ardb+git@google.com>
Subject: [PATCH v4 7/7] arm64/efi: Call EFI runtime services without disabling preemption
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
2.51.0.534.gc79095c0ca-goog


