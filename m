Return-Path: <linux-kernel+bounces-855283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE77BE0BBE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 23:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 44EDA4F7BE5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 21:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEAFD29B8C7;
	Wed, 15 Oct 2025 21:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NeaMLktb"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0A02C187
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 21:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760562065; cv=none; b=bZkvZRJVdHfPqvHoh+59FsbR6mk3k/2HSFJaYmNIw3SGOWUJvKkGHXv/BeYdQ/7iGOCwy9dx0mUfaeFY5uDlwVdX1XTcwRWHwo2wKtyoZsusypKTZIri1oKZHK927Fay2lRXwzaQHNJV97daeURuWIJmNJBm3q013CoLrgFhI08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760562065; c=relaxed/simple;
	bh=/Mc//C09Fvs/en1rt/ODrcIYr2xrTUD2a++fxVCYYt4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kN6gtdhicMLKf5UzqK4rtbUGr5KY7gmXsk9aXfeRwC1iD3FJs7kDTLZ61IEyfCQsMU0dOm0vwOtrG8ZsQbUezr5TsJoH65lylk+7SeWXxTN1DYxv7A0ckXAIv0vA4iht3iIsgoZlh4WVEy9NqWDUhviNCbIgopIAjCjopXgLy1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NeaMLktb; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-46e35baddc1so179165e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 14:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760562061; x=1761166861; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jD+kFUBYAeeVe/ddE0v3sfAZUgaXP696q8DDibnTqBE=;
        b=NeaMLktb9Whk3hZJqrS3cbRLseM3Q0E9HvUz9hlcHcuwNt0PusnrdA7J8rXXRQ6Pg0
         P7aOQYim4sjBs4KTV/Lb5ielT/rmADIWGbqOn0yAZcKxIxWbuoDwi9Y4OE8xQoVU9Kwb
         /iKukiO62KelakypCtfhlmjqnpVQQ3SyAfw6UQVFra9wlcDSAGbwhYM1ABAQJIr/avfl
         Uj3+olT/IdWNCo4VWEsNs+FFKEOBHjYIQA/SvM+UJ2ZPuiuTzCpCdFYVX3ofq7z+m+AY
         MdFibQV/UNBuAPBtEoE9avtrv4mpJ02w1yJ/N2S0oXnfsJ14ayTRtTSfq1GL+PzohEkz
         moTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760562062; x=1761166862;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jD+kFUBYAeeVe/ddE0v3sfAZUgaXP696q8DDibnTqBE=;
        b=SuzHvDONMXVgIfj6qdovegufYHAexRhsH3IBREajJWESJ1TAaTBIx27i6/FqTXv4qA
         FOBGTsKToeNTkrPeqMhaIN9U4sMD6VTYt4KwfnGMS2x6j574Jvb72VyepWFcY7Mi4ljZ
         G9q6UBeABC7ggcRvXxDAyYSz5ozkGcb+MUdhAya/Kl20H6Qt/2xXoOyJqG6GLFNTZPhn
         nT/68dA1V/NHatJJO+6vMqU6Bj4113y2a3qMPQgsElxnX1LsodjUa1AFpsZH6hLUof1P
         sFJ3peJ90gZUwX5g7Wu5ZycSLgbf20ocBixD1WxehwqKrj2ClrkNeTnMKe+QEkSE6Sw0
         MYsg==
X-Gm-Message-State: AOJu0YxDaxz9eSZ8eAnXZP/1z7ZBXc/I8WSesaxXlERZu7hvJ2nQdTwo
	iY89jqKV3ZIXDpEkkEOFqAb5sosG2E0e8G4kpXlRRKGKPoAJLU5R66EFVvHYVmoQ5PFPKqnrBQ=
	=
X-Google-Smtp-Source: AGHT+IFxvD/EQ8rSJVlE+EW9W2l6da03H/DDoZRFzID9t/ZfX7njnQlyQo8cNARQr75jwnOiLRm17aJC
X-Received: from wmgg6.prod.google.com ([2002:a05:600d:6:b0:46f:aafc:e6d4])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3b2a:b0:46e:3e63:9a8e
 with SMTP id 5b1f17b1804b1-46fa9b07717mr171322045e9.26.1760562061580; Wed, 15
 Oct 2025 14:01:01 -0700 (PDT)
Date: Wed, 15 Oct 2025 22:56:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=4002; i=ardb@kernel.org;
 h=from:subject; bh=QKe9AxQhtU5DJebwz0TSUBdR0vmdHpGkcHrtGscOZ1Q=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIeMDV7O1rafFzh1TTcR2Pj5858b/I+ev7jt29OWyN3McL
 tp41UokdpSyMIhxMciKKbIIzP77bufpiVK1zrNkYeawMoEMYeDiFICJHExk+F9r/Df39eEsxodc
 EruWlkoqqfxi/cDuVKYia/4qIHbl8ukM/yweKRW8ODp5XmdnbmTQ0kRfr9qrtrFZrxWnetzevcD bnh0A
X-Mailer: git-send-email 2.51.0.869.ge66316f041-goog
Message-ID: <20251015205634.3820870-9-ardb+git@google.com>
Subject: [PATCH v4 resend 0/7] arm64: Make EFI calls preemptible
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Ard Biesheuvel <ardb@kernel.org>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>, 
	Pierre Gondois <Pierre.Gondois@arm.com>, Sami Mujawar <Sami.Mujawar@arm.com>
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

No changes since v4, rebase to v6.18-rc1 only.

Changes since v3:
- Abandon changes that disallow EFI runtime calls in hardirq or NMI
  context, as these might occur when EFI pstore records an OOPS into the
  EFI variable store. Note that this suggests that preserving/restoring
  userland SVE state in such cases is rather futile, but this can be
  revisited at a later time.
- Drop the lock in the arch wrapper, which has become redundant now that
  all EFI calls are serialized under the efi_runtime_lock semaphore
- Add code comment to patch #4 to explain the kludge
- Add some acks from Will

Changes since v2:
- Permit ordinary kernel mode FP/SIMD with IRQs disabled, so that the
  special EFI case only deals with invocations in hardirq or NMI context
- Disallow EFI runtime calls in hardirq or NMI context, so that the
  special FP/SIMD handling for EFI can be dropped entirely
- Use a mutex rather than a semaphore for the arm64 EFI runtime lock,
  now that it is never trylock()ed in IRQ or NMI context.

Changes since v1/RFC:
- Disable uaccess for SWPAN before updating the preserved TTBR0 value
- Document why disabling migration is needed
- Rebase onto v6.17-rc1

(*) only efi_reset_system() and EFI pstore invoke EFI runtime services
    without going through the workqueue, and the latter only when saving
    a kernel oops log to the EFI varstore

Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Pierre Gondois <Pierre.Gondois@arm.com>
Cc: Sami Mujawar <Sami.Mujawar@arm.com>

Ard Biesheuvel (7):
  efi: Add missing static initializer for efi_mm::cpus_allowed_lock
  efi/runtime-wrappers: Keep track of the efi_runtime_lock owner
  arm64/fpsimd: Don't warn when EFI execution context is preemptible
  arm64/fpsimd: Permit kernel mode NEON with IRQs off
  arm64/efi: Drop efi_rt_lock spinlock from EFI arch wrapper
  arm64/efi: Move uaccess en/disable out of efi_set_pgd()
  arm64/efi: Call EFI runtime services without disabling preemption

 arch/arm64/include/asm/efi.h            | 13 ++----
 arch/arm64/include/asm/simd.h           |  2 +-
 arch/arm64/kernel/efi.c                 | 46 +++++++++++++++++---
 arch/arm64/kernel/fpsimd.c              | 29 ++++++++----
 drivers/firmware/efi/efi.c              |  3 ++
 drivers/firmware/efi/runtime-wrappers.c | 17 +++++++-
 include/linux/efi.h                     |  2 +
 7 files changed, 86 insertions(+), 26 deletions(-)


base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
-- 
2.51.0.869.ge66316f041-goog


