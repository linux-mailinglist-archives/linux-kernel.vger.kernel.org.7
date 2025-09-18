Return-Path: <linux-kernel+bounces-802979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E44ADB4591D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AE24A48282
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 13:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82603570D3;
	Fri,  5 Sep 2025 13:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HUgm5XfA"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9037D35691E
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 13:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757079058; cv=none; b=MfwS72DVHYKKUE8Me7nyl0L4U0pED/fkylwnP+zl6O4nIRUaIM/vamEJVo4W8F0rW0LRHr1BiNC5ggtMLKpAOPIF6hxkBrZ6WgnAMJ+CgRSAGuXqXr6swW9jvpRdkxlZccSxm+aDOxpCjMZkoLtgQrtGvuktq1rJY9tdwA27p0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757079058; c=relaxed/simple;
	bh=Xvp85F/Dx4S0XK/y27QHNKNLSZPPXOsjzftN/mdI1yw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ippI6ZgW3ob2XYGGC04IEHqURZAUD4k9muh1uq1CD2MecsZgWlKDh/jMQngyfLt7Q5InKvpdAOR8/c16EYXbnBVWLBsHdsvrY5Kq5CXEh37cuVY3mQBbUJc3qN3UFybUfea5KknShrb5ZvhNamAnsBIUCpw88NGbrb+iFpOGH24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HUgm5XfA; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45dd5c1b67dso7125325e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 06:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757079055; x=1757683855; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=k7SGgiq8e0ibQjNE492pNxUn28Q/j5kSsNWzW80icFw=;
        b=HUgm5XfAMLak3zZnaDg1v+l8z2p6ts9VdCXLiI3tio/WUs43+oI550FZLkcd39V/z2
         31vZMRpcxlETz7yRzQX+sgRrJpD8D/pWR0FWo/DRYXunauytJTtxBtAwNzo8IIsAqnBh
         P7tDG8342Sxr1NH6dVgNyMEEpXUjjW4WcRlS0pGkvJTeRXcf3LxcICjaQ6EdWeO4EB7u
         r2MAd18GQ46R4YDvJdxmkyt5u+HJugqlXEiBBdRXABmC/AJp/8UdDBBd1gcksitf7tkC
         3+pndo46N7ajvlaZgOaYnxzAKNqCrJJTdUB3UxTLlAGZzyubfr4ht53qlILjalxpOnrX
         kndA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757079055; x=1757683855;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k7SGgiq8e0ibQjNE492pNxUn28Q/j5kSsNWzW80icFw=;
        b=gf+y7kphE/EbHipB5OrOuubdcel/+L/5uJUH2aSC9Y/sgsFL0ZA1oVlUrUd/7A7tAk
         efY59SVqtQk3JcIDbFRGJdZYefNHKePwGQcKeRAa9gWODYRwzHh+6XArGa/wUkD9YZ/E
         ASurr4Pcm3ezeABSKUT4vXnr18nfPJyp59QBDr/hlMUMznyQy9mHaXFK1vhHsY8JjCnM
         tAwh11IFYBzEmPzuu+7jUcrboYZaEgGHpotjpPignyPI4++w6VXCeg4H9qftxBcHMjSn
         Ofj8q8ea/ye6fC47ulTRa66abyFWynQ5thvU6MpTH5veTRb04BLYXqebXh7cFCEXC0jD
         1++g==
X-Gm-Message-State: AOJu0YwBNstxF1eOqzTtxiJT9SIw1yxyRntn/ZL5gFbaU0zKdlKMJzpY
	yY3qSTkYCpaeKNxEVxpFzOto3+alGcPuh/TM7QqZh0FU5lwOg1vksZ7rcaJV3X0HauC8/xytrA=
	=
X-Google-Smtp-Source: AGHT+IFvcFnuIOuoqBisDROlcvYmwSXQfsXo7xa1mO1oe2SxbUKBbSt14Xcgr/JdOQQx2fY9o0Bwyd8Z
X-Received: from wmbds17.prod.google.com ([2002:a05:600c:6291:b0:45d:cf67:3908])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1584:b0:45d:d609:117f
 with SMTP id 5b1f17b1804b1-45dd60912c7mr22883895e9.8.1757079055152; Fri, 05
 Sep 2025 06:30:55 -0700 (PDT)
Date: Fri,  5 Sep 2025 15:30:43 +0200
In-Reply-To: <20250905133035.275517-9-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250905133035.275517-9-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3214; i=ardb@kernel.org;
 h=from:subject; bh=p0S4tXXYoOutiRiXN4g5SW9wNTpd5LNBz7e6ejjtylE=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIWPXM6a5x+oyuYWeVatHRHPziD3YeKNUdPtTxXs12SJnl
 Od3eJl2lLIwiHExyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgImomjH8U0s6sDv2b+D/4x6C
 tWKuAms0VPqiFj35WPi5XDr/7YONqowMx9Vfi//Ymfzk8RSXx5mrF5VGb3q0ap1LTp9bBVtGypV SdgA=
X-Mailer: git-send-email 2.51.0.355.g5224444f11-goog
Message-ID: <20250905133035.275517-16-ardb+git@google.com>
Subject: [PATCH v2 7/7] arm64/efi: Call EFI runtime services without disabling preemption
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Ard Biesheuvel <ardb@kernel.org>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Peter Zijlstra <peterz@infradead.org>
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
index ece046bcf0db..cf62980006ea 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -10,6 +10,7 @@
 #include <linux/efi.h>
 #include <linux/init.h>
 #include <linux/kmemleak.h>
+#include <linux/kthread.h>
 #include <linux/screen_info.h>
 #include <linux/vmalloc.h>
 
@@ -177,7 +178,19 @@ bool arch_efi_call_virt_setup(void)
 	if (WARN_ON(down_trylock(&efi_rt_lock)))
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
@@ -203,7 +216,13 @@ void arch_efi_call_virt_teardown(void)
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
 	up(&efi_rt_lock);
 }
 
-- 
2.51.0.355.g5224444f11-goog


