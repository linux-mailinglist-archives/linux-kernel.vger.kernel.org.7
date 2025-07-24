Return-Path: <linux-kernel+bounces-745101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E67A3B114E9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 01:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 900373AE12D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 23:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683262472A6;
	Thu, 24 Jul 2025 23:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a7W/wyIn"
Received: from mail-io1-f73.google.com (mail-io1-f73.google.com [209.85.166.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6CC2441A0
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 23:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753401110; cv=none; b=TE4AIhiUfH77lCznyUOHJt+NCX4k8q/AynEyJiYZ6TuEQEgUdBmoxCe4EBolxnkCJt4Mpp+FjQf5VRMF709nlvIuvpiRkv4/ziMuTKotWIlMuDCWMg2fyyLT5RzG/5hx9no0Zjj8JntnS5KPxIQziOikMxWy8Rjvj9D86AGGhFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753401110; c=relaxed/simple;
	bh=tsqTBiiUtIi3vn7VFW3l6S+Foh9dSWRS7ErMls5dXjg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=LlGW33NyEPphmS9mzrwuoCRZajXvEvROCmN5iWyYuITEKlfTHbIUAohW9ttz/Z8DHX4m97vnO+x9ftSG5ZSkl9T8MG15Y8y5ObgUPJuU7ipD9JPEw5huI7afUOXZc09zrjsJ8kHirexvBZI20MDB0hZvheX/5mEO5WgUCur+ro0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a7W/wyIn; arc=none smtp.client-ip=209.85.166.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com
Received: by mail-io1-f73.google.com with SMTP id ca18e2360f4ac-87c0915ba7dso91641139f.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 16:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753401108; x=1754005908; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yBgNXOzVYMuT3p5X0sPGb1CyLZHQHf4C3ha7d+WUCs8=;
        b=a7W/wyInyEFcZmYVja+XnUfo972bzgeeP8nN3HHN7vBnh4/DxBfzvIN5f/OEd6rWv/
         eNcad5gUk0IXHRSaEjYY8Tx8+FS0/ozMcxyQmCXqKuaBht9ODU1qZ9+P9lHd2djo4NI2
         ARKwdn4mPQaYQbmaU92SYXpdIH5bZ7+lWoPfXx4/QeX2oPLguR/4xosIwuIcrv9ba406
         adSUclfXoOZgvE3k00U+EcbkZdHRSRZHc3VATjmo1pJrRWR+60mIR+aQQIc8ZCq4JCGz
         U0RnYYxifpoNn+CXSEM8GAzwcWJgwfmcvdQycV4InTw02kq5FMEKJRNuJpPMjFWcCyxl
         3rAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753401108; x=1754005908;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yBgNXOzVYMuT3p5X0sPGb1CyLZHQHf4C3ha7d+WUCs8=;
        b=T+KDICh/Dg+uikEVu0hqF2Dog7AvArRsDzZS/hMWEIrGf3k/I3jqZtZmkNmZEOk62V
         +5UL/nJmOU58Fox7Xl2XyWFJrLXJVRVq3p1nw16/LJ3dRa94mJxSKiW9YdQ49+BGIGjs
         +hyqRPsq0r7Fj4SOTYTNgleDejVIPbtUaTx19gXntoE4JU1gcc7pVRIFeAJlh/ak1+OV
         8xxP+VZey0Ik+C99rz3pNJfGHNsKiblafyDkQkOqoCT8BRwgjMhPDoys8mWyKjG8wK4X
         59Y6GRX6isgkTbKLXEsqHixdGTCirbVx23IpZovldbyQUxymSxyBndCQJYwiT8ZBW253
         geqw==
X-Forwarded-Encrypted: i=1; AJvYcCXknsXix0qw0sjd4fWjIWVJnFKy5FLK82nnQe7Qj7+8SGZO20uQglQJufHjpVVUF4qUSvjAOuZpFTbvtkU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+YBauEoE3dhIRkrGCgxvlr56UdWlIS14IdXEyIlLzmHqXyuQR
	bVlHZhV/iA+By7xnPDkxLXoxEkQ0PxZA3vlDmJHEo/Xams+HC2OFW2LizYRTS/CJArTEV1Htwa3
	rm1kcxXWlug==
X-Google-Smtp-Source: AGHT+IGJJw5L0nOEev3xzncdd7QXg/JvCOjo9FLlOHz8os9ojHiaM/jdOkQnSqh8f7hlvencNdgmFK+BlV4o
X-Received: from ioqc13.prod.google.com ([2002:a6b:7d0d:0:b0:87c:3255:3907])
 (user=rananta job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6602:b8e:b0:876:7876:a587
 with SMTP id ca18e2360f4ac-87c64dc5c35mr1439425539f.0.1753401108447; Thu, 24
 Jul 2025 16:51:48 -0700 (PDT)
Date: Thu, 24 Jul 2025 23:51:42 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.470.g6ba607880d-goog
Message-ID: <20250724235144.2428795-1-rananta@google.com>
Subject: [PATCH 0/2] KVM: arm64: Destroy the stage-2 page-table periodically
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

Thank you.
Raghavendra

Raghavendra Rao Ananta (2):
  KVM: arm64: Split kvm_pgtable_stage2_destroy()
  KVM: arm64: Destroy the stage-2 page-table periodically

 arch/arm64/include/asm/kvm_pgtable.h | 19 ++++++++++++
 arch/arm64/kvm/hyp/pgtable.c         | 23 ++++++++++++--
 arch/arm64/kvm/mmu.c                 | 46 +++++++++++++++++++++++++---
 3 files changed, 80 insertions(+), 8 deletions(-)


base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
-- 
2.50.1.470.g6ba607880d-goog


