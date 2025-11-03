Return-Path: <linux-kernel+bounces-882246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34791C29FBE
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 04:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 651B7188F928
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 03:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF722882A9;
	Mon,  3 Nov 2025 03:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rFn57gkF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779FE1684B0
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 03:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762141469; cv=none; b=Q3MNiiw99cwZ5Cqi2ab7NDoRHwcPkxOA8Oe4u3p1i3F6eDzt5QM9ca6e9dS4OXq1PPrkHFLUdtYhdseE7prnkCFmnZD/1nHunXE6SnTrqyNs4SMndk9qe2AWiKVQZyiuwtE0S5LqFc8R3fSqrC80VMteW81JCg4dMzJvaqS597k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762141469; c=relaxed/simple;
	bh=gdUkQPTJ/VPhEpfeRnKn2z1gE2JqH/SrDbDMetRQfZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rw5Z4fz2k/zgQHqE7gXkjAMeEiPUPHaweGqzU2uBoDgcL5rALA1fKlfjoYNvAeXdOX9E5J2oHm0apNlFSyCUbIsYFjaHXeSWQtZ6qkw2GI+m0kl9N2X2IPnGE5UKwkvG54xxqOwaKSlyBVUERoJqGyPwzfYhtITlyib7DAYXcAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rFn57gkF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1A04C4CEF8
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 03:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762141468;
	bh=gdUkQPTJ/VPhEpfeRnKn2z1gE2JqH/SrDbDMetRQfZk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rFn57gkFOYHOJYiPiDrpFN7XEkqaE2BJq+5anLEYB8G6l66AA3IUCvyJMwDaOjEoK
	 3B0E7UJ61AaYjkaEnYJbQT23ySeTKck+dZgA7OqoJRM0qLJ8PDpjH8nb74MSJH+Gk2
	 phLG7W6t64H8JC1MVlzZEnqVRVQ0gi1L6q9fOjmZliQn5L2oqrxPDYEmWJicRkBC5I
	 2dUC441hdBc8FX4eXS7re4yHoCgyQnlK8G9dDH4iYkYfOdr5pkdf6eCbYc5qv8OTPq
	 c9ob5gNZQZZdZFSAXEMuMypKFePK1Nc4xV+xE/6kIgH8znRmGu8+F/LyQ6GhaHs2zI
	 RrvNx4ah/+oTA==
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-470ffbf2150so27393515e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 19:44:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUwySmmUpdHytAvYgHG9JR8QbqjvUUuif2kVYhRq3j7NhtRyhANBx8UaO/D67+7QKv+pkI7TtRRY+fKV9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJlOXh1nxEiN/Ol6pmV3KdwGGosih7AuFSrw6XuowCAnWy7qQA
	qJHTRbAj7Zu8JzI4p6ZDzbGdJm5ykwF5iNirjOL61IqBDnXR6XJqNXhMcZ8gCpTzBU2/Qmv/sw6
	p2RZ2N6YbeL0dJGXUOhE2G4Am+p+z5yM=
X-Google-Smtp-Source: AGHT+IHrpYfgDGvlMRoqjzYnuod0FjOaTVgsVNAdM4ECirng3fTqP+kR1omSMgHtLa5e0wNZ4Y8EENS3Is6VetOLc7A=
X-Received: by 2002:a05:6000:25c2:b0:429:b8c7:1848 with SMTP id
 ffacd0b85a97d-429bcd5c6ccmr9547366f8f.19.1762141467311; Sun, 02 Nov 2025
 19:44:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030135652.63837-1-luxu.kernel@bytedance.com> <20251030135652.63837-5-luxu.kernel@bytedance.com>
In-Reply-To: <20251030135652.63837-5-luxu.kernel@bytedance.com>
From: Guo Ren <guoren@kernel.org>
Date: Mon, 3 Nov 2025 11:44:15 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQXunyTdwKrLF2By13u3-n3LRNpC8j2Pnv6umCh89wCJQ@mail.gmail.com>
X-Gm-Features: AWmQ_blAzsZQaFgVv69HaEet96wXDSYvFZq30UlZuizoCFkbz_N3fvc6h5ZzmcA
Message-ID: <CAJF2gTQXunyTdwKrLF2By13u3-n3LRNpC8j2Pnv6umCh89wCJQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 4/4] riscv: mm: Perform tlb flush during context_switch
To: Xu Lu <luxu.kernel@bytedance.com>
Cc: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	apatel@ventanamicro.com, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 9:57=E2=80=AFPM Xu Lu <luxu.kernel@bytedance.com> w=
rote:
>
> During context_switch, check the percpu tlb flush queue and lazily
> perform tlb flush.
>
> Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
> ---
>  arch/riscv/include/asm/tlbflush.h |  4 ++++
>  arch/riscv/mm/context.c           |  6 ++++++
>  arch/riscv/mm/tlbflush.c          | 34 +++++++++++++++++++++++++++++++
>  3 files changed, 44 insertions(+)
>
> diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/t=
lbflush.h
> index eed0abc405143..7735c36f13d9f 100644
> --- a/arch/riscv/include/asm/tlbflush.h
> +++ b/arch/riscv/include/asm/tlbflush.h
> @@ -66,6 +66,10 @@ void arch_tlbbatch_add_pending(struct arch_tlbflush_un=
map_batch *batch,
>  void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch);
>
>  extern unsigned long tlb_flush_all_threshold;
> +
> +DECLARE_PER_CPU(bool, need_tlb_flush);
> +void local_tlb_flush_queue_drain(void);
> +
>  #else /* CONFIG_MMU */
>  #define local_flush_tlb_all()                  do { } while (0)
>  #endif /* CONFIG_MMU */
> diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
> index 4d5792c3a8c19..82b743bc81e4c 100644
> --- a/arch/riscv/mm/context.c
> +++ b/arch/riscv/mm/context.c
> @@ -199,6 +199,12 @@ static void set_mm_asid(struct mm_struct *mm, unsign=
ed int cpu)
>
>         if (need_flush_tlb)
>                 local_flush_tlb_all();
> +
> +       /* Paired with RISCV_FENCE in should_ipi_flush() */
> +       RISCV_FENCE(w, r);
> +
> +       if (this_cpu_read(need_tlb_flush))
> +               local_tlb_flush_queue_drain();
>  }
>
>  static void set_mm_noasid(struct mm_struct *mm)
> diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> index f4333c3a6d251..6592f72354df9 100644
> --- a/arch/riscv/mm/tlbflush.c
> +++ b/arch/riscv/mm/tlbflush.c
> @@ -115,6 +115,8 @@ DEFINE_PER_CPU(struct tlb_flush_queue, tlb_flush_queu=
e) =3D {
>         .len =3D 0,
>  };
>
> +DEFINE_PER_CPU(bool, need_tlb_flush) =3D false;
> +
>  static bool should_ipi_flush(int cpu, void *info)
>  {
>         struct tlb_flush_queue *queue =3D per_cpu_ptr(&tlb_flush_queue, c=
pu);
> @@ -134,6 +136,14 @@ static bool should_ipi_flush(int cpu, void *info)
>         }
>         raw_spin_unlock_irqrestore(&queue->lock, flags);
>
> +       /* Ensure tlb flush info is queued before setting need_tlb_flush =
flag */
> +       smp_wmb();
> +
> +       per_cpu(need_tlb_flush, cpu) =3D true;
> +
> +       /* Paired with RISCV_FENCE in set_mm_asid() */
> +       RISCV_FENCE(w, r);
> +
>         /* Recheck whether loaded_asid changed during enqueueing task */
>         if (per_cpu(loaded_asid, cpu) =3D=3D d->asid)
>                 return true;
> @@ -146,6 +156,9 @@ static void __ipi_flush_tlb_range_asid(void *info)
>         struct flush_tlb_range_data *d =3D info;
>
>         local_flush_tlb_range_asid(d->start, d->size, d->stride, d->asid)=
;
> +
> +       if (this_cpu_read(need_tlb_flush))
> +               local_tlb_flush_queue_drain();
>  }
>
>  static inline unsigned long get_mm_asid(struct mm_struct *mm)
> @@ -280,3 +293,24 @@ void arch_tlbbatch_flush(struct arch_tlbflush_unmap_=
batch *batch)
>                           0, FLUSH_TLB_MAX_SIZE, PAGE_SIZE);
>         cpumask_clear(&batch->cpumask);
>  }
> +
> +void local_tlb_flush_queue_drain(void)
> +{
> +       struct tlb_flush_queue *queue =3D this_cpu_ptr(&tlb_flush_queue);
> +       struct flush_tlb_range_data *d;
> +       unsigned int i;
> +
> +       this_cpu_write(need_tlb_flush, false);
> +
> +       /* Ensure clearing the need_tlb_flush flags before real tlb flush=
 */
> +       smp_wmb();
> +
> +       raw_spin_lock(&queue->lock);
> +       for (i =3D 0; i < queue->len; i++) {
> +               d =3D &queue->tasks[i];
> +               local_flush_tlb_range_asid(d->start, d->size, d->stride,
> +                                          d->asid);
Here, do we need an accurate flush for a delay flush?

> +       }
> +       queue->len =3D 0;
> +       raw_spin_unlock(&queue->lock);
> +}
> --
> 2.20.1
>


--=20
Best Regards
 Guo Ren

