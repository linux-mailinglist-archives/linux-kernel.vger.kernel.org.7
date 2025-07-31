Return-Path: <linux-kernel+bounces-752485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C86AB17629
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 20:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BB08565AFB
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 18:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DF11C5F06;
	Thu, 31 Jul 2025 18:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LgKKUQHk"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F003415383A
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 18:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753987525; cv=none; b=mCxwCAKZJovD4+Ojz/yE4DvjU3xKtRYgaa4HEjY9z7QNNmKUns1dMOF7obGNUPCcLAB18VZyHjKdBSSaHOGIwYAmWGYYVAeVoHJ1YJgjz0E4ThOL9G8e7TD8ficidz/8YwBQZb7ub14wI5ZaSNEBFIXbQQgM4vnytjmNvr3W8Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753987525; c=relaxed/simple;
	bh=6B4+xEpnfuEkCcr85FGuUmAHz56DyrEn/UHaQEbwM/Y=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type; b=OY3wQ4XFXHMohlj2rcgnAK5IKtCneUzdf4SQe+kM04OydtfDkq6hskahlRHc87ALWmfETwkDhoGphBg2WMlbxJ88tc1qHWH6tBgxg4pY71ez8l7cqGEfT1zLMP9XXqdRIuvdj1XzcumgUcgaTuKBcVDKlI7Qh4Iu1MAH4pAZ+Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LgKKUQHk; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-31f02b6cd37so41427a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 11:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753987523; x=1754592323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PJeyEpTILqOg780uBAW/1Q6eRMKdUSQqGOp04S222AQ=;
        b=LgKKUQHkSX9XDDKz+dxQD9i1Yr3kk67dzxinPLXcNC7kgS6l9Ux8O6z4LVY1gDE9qG
         F60U4cihftcusQoaSTxw06/sT8Urunx6dPe+nKxikBtLfd5foM1xy6FdMSUsMPYM+iyw
         EPHCkknKzR7LWvdlPSlNUSRRhC81jtCLy9rKsarFiLI1qevCW/2ftNrqH2hdtmHuQXBq
         UV+hWIm8lso8v2gGXis0ID8GA52qoqipeQTzo/PfsBJZBB2xBJ6R4z4f4X/KTKS2ZRjR
         DJk1bk1rSGROjb+AtMB/tatYhtAYcP9wY0M2YkSEQrGedVfQEyUYi0pYu5Ct5dUMvGME
         UOfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753987523; x=1754592323;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PJeyEpTILqOg780uBAW/1Q6eRMKdUSQqGOp04S222AQ=;
        b=pTSt5L+olWHNoh22rIzBGE9/P35iYiOQbst62M79vx2QdLdRo4w99nOuQHlNRAS7SC
         QrJl0FqPZYKmvpx1slf5Q2JbKz8L5i1BDFuaoJQ0exk+ChY7tb2TTpNtVoVIWb4hmyUV
         BjE2DOEJ8JghpFtsPDNldaYfkQ2aCIAawHZea4AhdxCQx1zcoLFG/047ltaztFmnNnYq
         w0EQi0XuN0QhH/gmnQY4OwlogqremYkKN1RjLe1cxvScZamOqSi3jwETyjfi3ZtaScBU
         afBO5vBq63dIEMUoqminQTwE8KQKXvB0MTehVIWNBb9BTlBMPQ9XxZRnC1jFX2i1PRDj
         e59g==
X-Gm-Message-State: AOJu0YyQDGF1dXzvRjyOnTbY9M8X6Csh1MyTZdLWB7wiYQNlVyNGwXtI
	9IQbdspY0oIYDm3JXbUWNj+98AxpA+cxvjJyXG5Sy+rFTjQiY+h3YRKX07EDeg==
X-Gm-Gg: ASbGncusGrX1zJZp0OC3A0aXV05w8QI1qn8T7wNNdrZON8V45gOb4WoyyjQgH7UJEJ/
	ut3GLs0wpzZ7LFUMhkfDzBdIOVAJT0kfobQTlMH3J78GnGdxFTQMVzhJlSbDp8FtdCYJi8KYzKt
	NclTu8f6I/0oslFGC9ZFB+N1mAOsyqcufAb1Jn5eWpWSwHFTriFwCgbjD1ATgj/WC9LJFY09FzW
	d35S4UgzRVrvcHbD40rfvWg7wliV3MMw1sveAjxRRjO/TwxblN8oKbvtWV6V70hrflSbjaC+qmc
	mtXwkIY3kpTrbEWN3xL0EPLDXN/7j1HwNF0GZYuIEZliTah7OSnyHohJOqIadty2khljOx/GCGW
	bASOjCTGMiejF5pY=
X-Google-Smtp-Source: AGHT+IGIKXi870n++oqGLeS8pVvIqOPLThRSJdGG8l23A2iY/Sca4F/BW6iTpJ39GXAVOT3CjLDwRQ==
X-Received: by 2002:a17:90b:3d06:b0:31f:1db2:69b1 with SMTP id 98e67ed59e1d1-31f5de96c7cmr13967732a91.18.1753987523009;
        Thu, 31 Jul 2025 11:45:23 -0700 (PDT)
Received: from dw-tp ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63da57b4sm5427406a91.5.2025.07.31.11.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 11:45:22 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Donet Tom <donettom@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Vishal Chourasia <vishalc@linux.ibm.com>, Donet Tom <donettom@linux.ibm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/mm: Switch MMU context on hash MMU if SLB preload cache is aged
In-Reply-To: <20250731161027.966196-1-donettom@linux.ibm.com>
Date: Thu, 31 Jul 2025 23:40:07 +0530
Message-ID: <87y0s4qlj4.fsf@gmail.com>
References: <20250731161027.966196-1-donettom@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Donet Tom <donettom@linux.ibm.com> writes:

> On systems using the hash MMU, there is a software SLB preload cache that
> mirrors the entries loaded into the hardware SLB buffer. This preload
> cache is subject to periodic eviction — typically after every 256 context
> switches — to remove old entry.
>
> Currently, the kernel skips the MMU context switch in switch_mm_irqs_off()
> if the prev and next mm_struct are the same, as an optimization. However,
> this behavior can lead to problems on hash MMU systems.
>

Let's also add detailed flow of events, as this was not really an easy
problem to catch. 

CPU 0                                   CPU 1

Process P
exec                                    swapper/1
 load_elf_binary
  begin_new_exc
    activate_mm
     switch_mm_irqs_off 
      switch_mmu_context
       switch_slb
       /* 
        * This invalidates all the
        * entries in the HW and setup 
        * the new HW SLB entries as per 
        * the preload cache.
        */
switch_switch
sched_migrate_task migrates process P to cpu-1

Process swapper/0                       context switch (to process P)
(uses mm_struct of Process P)           switch_mm_irqs_off()
                                         switch_slb
                                           load_slb++
                                            /*
                                            * load_slb becomes 0 here
                                            * and we evict an entry from
                                            * the preload cache with
                                            * preload_age(). We still
                                            * keep HW SLB and preload
                                            * cache in sync, that is
                                            * because all HW SLB entries
                                            * anyways gets evicted in
                                            * switch_slb during SLBIA.
                                            * We then only add those
                                            * entries back in HW SLB,
                                            * which are currently
                                            * present in preload_cache
                                            * (after eviction).
                                            */
                                        load_elf_binary continues...
                                         setup_new_exec()
                                          slb_setup_new_exec()

                                        sched_switch event
                                        sched_migrate_task migrates 
                                        process P to cpu-0

context_switch from swapper/0 to Process P
 switch_mm_irqs_off()
  /*
   * Since both prev and next mm struct are same we don't call
   * switch_mmu_context(). This will cause the HW SLB and SW preload
   * cache to go out of sync in preload_new_slb_context. Because there
   * was an SLB entry which was evicted from both HW and preload cache
   * on cpu-1. Now later in preload_new_slb_context(), when we will try
   * to add the same preload entry again, we will add this to the SW
   * preload cache and then will add it to the HW SLB. Since on cpu-0
   * this entry was never invalidated, hence adding this entry to the HW
   * SLB will cause a SLB multi-hit error.
   */
load_elf_binary continues...
 START_THREAD
  start_thread
   preload_new_slb_context
   /*
    * This tries to add a new EA to preload cache which was earlier
    * evicted from both cpu-1 HW SLB and preload cache. This caused the
    * HW SLB of cpu-0 to go out of sync with the SW preload cache. The
    * reason for this was, that when we context switched back on CPU-0,
    * we should have ideally called switch_mmu_context() which will
    * bring bring the HW SLB entries on CPU-0 in sync with SW preload cache
    * entries by setting up the mmu context properly. But we didn't do
    * that since the prev mm_struct running on cpu-0 was same as the
    * next mm_struct (which is true for swapper / kernel threads). So
    * now when we try to add this new entry into the HW SLB of cpu-0,
    * we hit a SLB multi-hit error.
    */

WARNING: CPU: 0 PID: 1810970 at arch/powerpc/mm/book3s64/slb.c:62 assert_slb_presence+0x2c/0x50(48 results) 02:47:29 [20157/42149]
Modules linked in:
CPU: 0 UID: 0 PID: 1810970 Comm: dd Not tainted 6.16.0-rc3-dirty #12 VOLUNTARY
Hardware name: IBM pSeries (emulated by qemu) POWER8 (architected) 0x4d0200 0xf000004 of:SLOF,HEAD hv:linux,kvm pSeries
NIP:  c00000000015426c LR: c0000000001543b4 CTR: 0000000000000000
REGS: c0000000497c77e0 TRAP: 0700   Not tainted  (6.16.0-rc3-dirty)
MSR:  8000000002823033 <SF,VEC,VSX,FP,ME,IR,DR,RI,LE>  CR: 28888482  XER: 00000000
CFAR: c0000000001543b0 IRQMASK: 3
<...>
NIP [c00000000015426c] assert_slb_presence+0x2c/0x50
LR [c0000000001543b4] slb_insert_entry+0x124/0x390
Call Trace:
  0x7fffceb5ffff (unreliable)
  preload_new_slb_context+0x100/0x1a0
  start_thread+0x26c/0x420
  load_elf_binary+0x1b04/0x1c40
  bprm_execve+0x358/0x680
  do_execveat_common+0x1f8/0x240
  sys_execve+0x58/0x70
  system_call_exception+0x114/0x300
  system_call_common+0x160/0x2c4


> Consider the following scenario: a process is running on CPU A and gets
> context-switched to CPU B. During this time, one of its SLB preload cache
> entries is evicted. Later, the process is rescheduled on CPU A, which was
> running swapper in the meantime, using the same mm_struct. Because
> prev == next, the kernel skips the MMU context switch. As a result, the
> hardware SLB buffer still contains the entry, but the software preload
> cache does not.
> 
> The absence of the entry in the preload cache causes it to attempt to
> reload the SLB. However, since the entry is already present in the hardware
> SLB, this leads to a SLB multi-hit error.
>

Can we use the detailed commit msg from above instead of above two paragraphs.
It is easier to visualize and document if we have it that way.


> To fix this issue, we add a code change to always switch the MMU context on
> hash MMU if the SLB preload cache has aged. With this change, the
> SLB multi-hit error no longer occurs.
>
> Fixes: 5434ae74629a ("powerpc/64s/hash: Add a SLB preload cache")

CC: stable@vger.kernel.org

Otherwise LGTM.

> Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
> ---
>  arch/powerpc/mm/book3s64/slb.c | 2 +-
>  arch/powerpc/mm/mmu_context.c  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/mm/book3s64/slb.c b/arch/powerpc/mm/book3s64/slb.c
> index 6b783552403c..08daac3f978c 100644
> --- a/arch/powerpc/mm/book3s64/slb.c
> +++ b/arch/powerpc/mm/book3s64/slb.c
> @@ -509,7 +509,7 @@ void switch_slb(struct task_struct *tsk, struct mm_struct *mm)
>  	 * SLB preload cache.
>  	 */
>  	tsk->thread.load_slb++;
> -	if (!tsk->thread.load_slb) {
> +	if (tsk->thread.load_slb == U8_MAX) {
>  		unsigned long pc = KSTK_EIP(tsk);
>  
>  		preload_age(ti);
> diff --git a/arch/powerpc/mm/mmu_context.c b/arch/powerpc/mm/mmu_context.c
> index 3e3af29b4523..d7b9ac8c9971 100644
> --- a/arch/powerpc/mm/mmu_context.c
> +++ b/arch/powerpc/mm/mmu_context.c
> @@ -84,7 +84,7 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
>  	switch_mm_pgdir(tsk, next);
>  
>  	/* Nothing else to do if we aren't actually switching */
> -	if (prev == next)
> +	if ((prev == next) && (tsk->thread.load_slb != U8_MAX))
>  		return;
>  
>  	/*
> -- 
> 2.50.1

