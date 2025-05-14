Return-Path: <linux-kernel+bounces-648178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85BD2AB7313
	for <lists+linux-kernel@lfdr.de>; Wed, 14 May 2025 19:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3E9E3A83E3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 May 2025 17:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53915281364;
	Wed, 14 May 2025 17:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1Vx4bAIe"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17BE27FB2B
	for <linux-kernel@vger.kernel.org>; Wed, 14 May 2025 17:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747244638; cv=none; b=g+5VJP7dBUitmHJtNHjYFF79+v3wdmmtmo0gpRDGmMlbSqE/PB+uPYHA2yHnPc3njhYXyMjq7WfE7H2buwHyteulVIO484mG11kZqFbb60UFbjHVPN9UCtl7tBeHP4ghkZ3NQPuEoNVBvzQgH7NQMH50bViAjh+DT4098LwTQM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747244638; c=relaxed/simple;
	bh=yhMpWCUXqTLvUsjh7Gmyr11MSo4dZ5QBtyUVoVF4eJU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=DQwXtrFMat5icVw09DCCRUUuQbrXBvqkrICaSSDJKerjBhxNo0JiitwUEmO/XBomEYWyKC4QNn7dCyEkJBV21c5dt+A1A3mx6PfCiV/mhvJYEkfmM2Ccoa9iwluJWsd+NJFx3t7c+GWyWyHJK9+nuaXvbfebJd5Ys7kyiHXDO88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1Vx4bAIe; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-442dc6f0138so486175e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 May 2025 10:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747244635; x=1747849435; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jkJfwo8xpBpJbrVIx6UOqAm0kur6+ObopwN4A021JGU=;
        b=1Vx4bAIe1786Li8F/q2gHPfen8ctxlT8TmgxCVFew2zKtTWr8U9tbIZIVOh7lAaBiy
         jQjNTOqn+i6C1JiQIWHFhotSsprNdrvtaj9YnIL9QYzFAl56uGO29o/B5hINOuIce3fE
         fIk1bkpu5QS9VwXwut48AQtf0oWbv0ZSDlOUKfYSmOL94fkSNVeKyNz/43H3upW8xT65
         tRdGVZk8/+h9R4jz2WeitKs3JzvMgNo8z0qAPLkusX3ugR9ZEqYxxJq9BiS7W3CQ0opR
         hARQqhOvQb2X3//GaCYL8jNRL36lVOyb1PagxoxMluoWxFuMVAPTXD0zHgP4eTmW+jUc
         x7ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747244635; x=1747849435;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jkJfwo8xpBpJbrVIx6UOqAm0kur6+ObopwN4A021JGU=;
        b=qwacZAQU0gH3Le11fcbR4WdYaMpdFST4i2CijYBFMecErrDFOcefAsARJ1JAy1YMpM
         AyLMCL8LVLqzy4EImiLE4zn4xOSn0BS/99fb27my+cmJGI2aT71T19Dy+OPmUV+E+MFB
         URAdJOXc/4IuA7V44GMn/b+nM4HBTa4QutOVLzDZVOBHENtdEeQv7UdAahfEjIow3SjE
         1bAN0oVaJtt2u5CtH4qj/oLdqCqAJZpKlWD0s74RAUuKgY2NAC676QPsCcu3atYZwjXt
         sU+ofcWMtQYrseNeGPBz85v+ib+NKXgYByQ1xWpd5T1FHrzLcL59aLCkas2JENwb8s5R
         5xig==
X-Gm-Message-State: AOJu0Yw1J+k/PS9z2fHjbjSMvtUOUVUvvHq2mMyx1Ta2gK3R1VBXO3v2
	06tDv17IZm+G5LXWQp1w+sUOHNp062A4hrEG8u1I7qzF/bJnHQV6gRxBWLGZ/Kk183rRBA==
X-Google-Smtp-Source: AGHT+IGadySak7rBVDWqJCLGSxkPkZ2SIdOa3WalcC/ytBQcEahJVGu+EdIXS9X2q6vXYOUEx7HQqf+B
X-Received: from wmben12.prod.google.com ([2002:a05:600c:828c:b0:43d:1f28:b8bf])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600d:d:b0:442:f44f:65b
 with SMTP id 5b1f17b1804b1-442f44f09a9mr28697025e9.32.1747244635236; Wed, 14
 May 2025 10:43:55 -0700 (PDT)
Date: Wed, 14 May 2025 19:43:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3009; i=ardb@kernel.org;
 h=from:subject; bh=K7cxMrEeOi5MLsm9UXTEEGQ2PJi6zRJCdveu0RXcm6U=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIUPlmk908a2ewi2NlRcOfrzbEr36wZqdbZ3PEpNTpiy60
 K6i4buto5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEzkHDPD/zy39z+f8TwJtWj2
 Pjj/75SX7elf5hawnNNtq9IT3sr9kZ3hn8ndvqiO38aGxc+NSk4ytGereTr6HWhKlPLfyFm5Nqa RFwA=
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
Message-ID: <20250514174339.1834871-9-ardb+git@google.com>
Subject: [RFC PATCH 0/7] arm64: Make EFI calls preemptible
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Ard Biesheuvel <ardb@kernel.org>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The arm64 port permits the use of the baseline FP/SIMD register file in
kernel mode, and no longer requires preemption to be disabled. Now that
the EFI spec is being clarified to state that EFI runtime services may
only use baseline FP/SIMD, the fact that EFI may code may use FP/SIMD
registers (while executing at the same privilege level as the kernel) is
no longer a reason to disable preemption when invoking them.

This means that the only remaining reason for disabling preemption is
the fact that the active mm is swapped out and replaced with efi_mm in a
way that is hidden from the scheduler, and so scheduling is not
supported currently. However, given that virtually all (*) EFI runtime
calls are made from the efi_rts_wq workqueue, the efi_mm can simply be
loaded into the workqueue worker kthread while the call is in progress,
and this does not require preemption to be disabled.

Note that this is only a partial solution in terms of RT guarantees,
given that the runtime services execute at the same privilege level as
the kernel, and can therefore disable interrupts (and therefore
preemption) directly. But it should prevent scheduling latency spikes
for EFI calls that simply take a long time to run to completion.

(*) only efi_reset_system() and EFI pstore invoke EFI runtime services
    without going through the workqueue, and the latter only when saving
    a kernel oops log to the EFI varstore

Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>

Ard Biesheuvel (7):
  efi: Add missing static initializer for efi_mm::cpus_allowed_lock
  efi/runtime: Return success/failure from arch_efi_call_virt_setup()
  efi/runtime: Deal with arch_efi_call_virt_setup() returning failure
  arm64/fpsimd: Don't warn when EFI execution context is preemptible
  arm64/efi: Use a semaphore to protect the EFI stack and FP/SIMD state
  arm64/efi: Move uaccess en/disable out of efi_set_pgd()
  arm64/efi: Call EFI runtime services without disabling preemption

 arch/arm/include/asm/efi.h              |  2 +-
 arch/arm64/include/asm/efi.h            |  5 +--
 arch/arm64/kernel/efi.c                 | 34 ++++++++++++++++----
 arch/arm64/kernel/fpsimd.c              |  4 +--
 arch/loongarch/include/asm/efi.h        |  2 +-
 arch/riscv/include/asm/efi.h            |  2 +-
 arch/x86/include/asm/efi.h              |  2 +-
 arch/x86/platform/efi/efi_32.c          |  3 +-
 arch/x86/platform/efi/efi_64.c          |  3 +-
 arch/x86/platform/uv/bios_uv.c          |  3 +-
 drivers/firmware/efi/efi.c              |  3 ++
 drivers/firmware/efi/riscv-runtime.c    |  3 +-
 drivers/firmware/efi/runtime-wrappers.c | 20 ++++++++----
 include/linux/efi.h                     |  8 ++---
 14 files changed, 63 insertions(+), 31 deletions(-)


base-commit: e04796c8b5980700c78f2fd1b29724afd80dcc62
-- 
2.49.0.1101.gccaa498523-goog


