Return-Path: <linux-kernel+bounces-778174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22983B2E23F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 18:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9D504E5269
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E3B3277A1;
	Wed, 20 Aug 2025 16:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GsByX9lX"
Received: from mail-il1-f202.google.com (mail-il1-f202.google.com [209.85.166.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC3131E0FD
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 16:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755706966; cv=none; b=K9xCzoFmf9R4L9sHB5JJ9BOz+gflAuANxqGgGXWzZrB07GBi67nnSJkVwvwBazAe2lAJtOpnwORXcRuRguMLIf5cC/ST8WBwYeXYdjzCYtulRPCRT9NMRKnKaJw7QNjO0tNmNx0FdpF2t2pG+njTLaLMpes0baA7uX+9+Exwdnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755706966; c=relaxed/simple;
	bh=iPVxsXUNujsC1U+Opd6Rpr2ImETnsIiPSua0ih0w7yU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ESFA9YBPdTwamxLTDNUZcMwADqM87ZZsl6epn8tE7lXQDl97S5a8d/FoDSgyoxC6FgVKCeHXM9LbYk09z62rJpUMtTNkk+t/8E+tdSCs8iOx3jqyl9OgbM3JxCkuRBtM8U3cM2Q6wwDcS36lOUjNhQZ2PQZQRbXqA2A667YwIuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GsByX9lX; arc=none smtp.client-ip=209.85.166.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com
Received: by mail-il1-f202.google.com with SMTP id e9e14a558f8ab-3e57003d5f3so137905ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 09:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755706964; x=1756311764; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xp70zuJGemGh+mpz8QRBla/5oQc56EUs7B0hph1iaAo=;
        b=GsByX9lXyhPseCH18B52TRFNHoErfi18Lg9+APOpdZ56+11nKSUzWrpBNdtpN+MbIY
         yEYeQkItYC+ay80reOWUJpLK67l7LP4KulJ1rhsTIAEH/XoZ0o5pXXAJy1JUBzedITOZ
         NKvK9dqLHFfH7OP20hZleLIjn5EWS75X1PqdHVGL54ii/QWeiizdyjPGO8HG63sOTKzz
         lY8Q/HPjxdhM9ABS52dLgYBxSSd4X7INeeKEnLKU/NQWM1WBoRf4hAlm9nfL4Vfpktjp
         DFBaE2UAIuduKeY3TpcFFQcsephpD9EtEp6vj0rb/tMLJgi4SZy83KZO4XyHv4ikXdX9
         CN4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755706964; x=1756311764;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xp70zuJGemGh+mpz8QRBla/5oQc56EUs7B0hph1iaAo=;
        b=PPYccSnl5XzYVW6Xg8YveTNBW22CVUsr+2wjZs9P09Q1IEg+ofet0nhrE7mwNOJV8n
         6eplzn/cM2mdEIKB84mPjcms7j0yg5+wm4bAPVdt611LL4FFcGKUuPi+OwEJpYw9kiUY
         nM6iV0fd7tMnWiHxNDOuoI7QjCPsoJYDND7S86+CmRL8wQTh2M/Y1ctrTaXnheRuwt1w
         v5Hv7uJWbsLkYqWMZmGNxHhk8XgzlrUhOa3OcBz54dRQuoiWM5vCeqRxaV2X11TuPOn0
         QwcGklYy/LJq4KODCXLtqSfor2s9Uo4dRq0nI0VcGwGTn2F9Lg2T/dEBr0JoTdHrequY
         99iw==
X-Forwarded-Encrypted: i=1; AJvYcCVHzcvyCqoHqIJQ0IT7q5cyeYPHGJS4PWJBcHRzoVYUyQl+uHycU25kyz1bYMsfvtLA8OLKv5LwgHRqyXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbII0bQx3xa36O8eY65/1w9oFiOorKk5pUTEMINNjbYAXAo3gQ
	gmbGbv1ZvxtI6SzAoXFY9AC/mY9y8TR0lY/Ny2Ah2krv+kGNgPh8zOTgVSvaBvWvKFyrTpAVpLv
	4Fdu9A/EXeQ==
X-Google-Smtp-Source: AGHT+IGsv5qpMpbPMnhvJuzG9XWMKFu3kD7El3S3s+9IMN7sQmHkyA1j8NEArrIUJjtqdjMUoR/Kl3C1mf7+
X-Received: from ilbbm5.prod.google.com ([2002:a05:6e02:3305:b0:3e6:66db:cdf7])
 (user=rananta job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6e02:1a84:b0:3e5:51a0:bcf
 with SMTP id e9e14a558f8ab-3e67ca46ca9mr58572375ab.16.1755706964132; Wed, 20
 Aug 2025 09:22:44 -0700 (PDT)
Date: Wed, 20 Aug 2025 16:22:40 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250820162242.2624752-1-rananta@google.com>
Subject: [PATCH v2 0/2] KVM: arm64: Reschedule as needed when destroying the
 stage-2 page-tables
From: Raghavendra Rao Ananta <rananta@google.com>
To: Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>
Cc: Raghavendra Rao Anata <rananta@google.com>, Mingwei Zhang <mizhang@google.com>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

When destroying a fully-mapped 128G VM abruptly, the following scheduler
warning is observed:

  sched: CPU 0 need_resched set for > 100018840 ns (100 ticks) without schedule
  CPU: 0 UID: 0 PID: 9617 Comm: kvm_page_table_ Tainted: G O 6.16.0-smp-DEV #3 NONE
  Tainted: [O]=OOT_MODULE
  Call trace:
      show_stack+0x20/0x38 (C)
      dump_stack_lvl+0x3c/0xb8
      dump_stack+0x18/0x30
      resched_latency_warn+0x7c/0x88
      sched_tick+0x1c4/0x268
      update_process_times+0xa8/0xd8
      tick_nohz_handler+0xc8/0x168
      __hrtimer_run_queues+0x11c/0x338
      hrtimer_interrupt+0x104/0x308
      arch_timer_handler_phys+0x40/0x58
      handle_percpu_devid_irq+0x8c/0x1b0
      generic_handle_domain_irq+0x48/0x78
      gic_handle_irq+0x1b8/0x408
      call_on_irq_stack+0x24/0x30
      do_interrupt_handler+0x54/0x78
      el1_interrupt+0x44/0x88
      el1h_64_irq_handler+0x18/0x28
      el1h_64_irq+0x84/0x88
      stage2_free_walker+0x30/0xa0 (P)
      __kvm_pgtable_walk+0x11c/0x258
      __kvm_pgtable_walk+0x180/0x258
      __kvm_pgtable_walk+0x180/0x258
      __kvm_pgtable_walk+0x180/0x258
      kvm_pgtable_walk+0xc4/0x140
      kvm_pgtable_stage2_destroy+0x5c/0xf0
      kvm_free_stage2_pgd+0x6c/0xe8
      kvm_uninit_stage2_mmu+0x24/0x48
      kvm_arch_flush_shadow_all+0x80/0xa0
      kvm_mmu_notifier_release+0x38/0x78
      __mmu_notifier_release+0x15c/0x250
      exit_mmap+0x68/0x400
      __mmput+0x38/0x1c8
      mmput+0x30/0x68
      exit_mm+0xd4/0x198
      do_exit+0x1a4/0xb00
      do_group_exit+0x8c/0x120
      get_signal+0x6d4/0x778
      do_signal+0x90/0x718
      do_notify_resume+0x70/0x170
      el0_svc+0x74/0xd8
      el0t_64_sync_handler+0x60/0xc8
      el0t_64_sync+0x1b0/0x1b8

The host kernel was running with CONFIG_PREEMPT_NONE=y, and since the
page-table walk operation takes considerable amount of time for a VM
with such a large number of PTEs mapped, the warning is seen.

To mitigate this, split the walk into smaller ranges, by checking for
cond_resched() between each range. Since the path is executed during
VM destruction, after the page-table structure is unlinked from the
KVM MMU, relying on cond_resched_rwlock_write() isn't necessary.

Patch-1 splits the kvm_pgtable_stage2_destroy() function into separate
'walk' and 'free PGD' parts.

Patch-2 leverages the split and performs the walk periodically over
smaller ranges and calls cond_resched() between them.

v2: Thanks, Oliver for the suggestions.
 - Apply the rescheduling to pKVM as well.
 - Use VTCR_EL2_IPA(pgt->mmu->vtcr) to get the full possible range of the VM
   for pKVM.
 - Deference the pgd using rcu_deference_raw() in kvm_pgtable_stage2_destroy_pgd()
   instead of using a null walker.
 - Rename/restructure the functions to avoid duplications.

v1: https://lore.kernel.org/all/20250724235144.2428795-1-rananta@google.com/

Thank you.
Raghavendra

Raghavendra Rao Ananta (2):
  KVM: arm64: Split kvm_pgtable_stage2_destroy()
  KVM: arm64: Reschedule as needed when destroying the stage-2
    page-tables

 arch/arm64/include/asm/kvm_pgtable.h | 30 +++++++++++++++++++++++
 arch/arm64/include/asm/kvm_pkvm.h    |  4 +++-
 arch/arm64/kvm/hyp/pgtable.c         | 25 +++++++++++++++----
 arch/arm64/kvm/mmu.c                 | 36 ++++++++++++++++++++++++++--
 arch/arm64/kvm/pkvm.c                | 11 +++++++--
 5 files changed, 97 insertions(+), 9 deletions(-)


base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
--
2.51.0.rc2.233.g662b1ed5c5-goog


