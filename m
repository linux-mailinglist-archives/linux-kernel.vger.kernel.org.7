Return-Path: <linux-kernel+bounces-863253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D273BBF767E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 842E950710C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F2F343D6E;
	Tue, 21 Oct 2025 15:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HmuHWM1d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB3D342C81
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 15:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761060485; cv=none; b=hfFgySEkWcdAxskr6SkHWGb8Bhb5vX+GGunYh9ul5GSNnugQVyvRC4JiGMJrlrTQggOsuq802VvELE7xpmYYktDcCipLqKmJfbkZvUvRqTnC00Ru+H4/pnUGJbEsMtDYY+eVpd400jy0yEsbLa7zfa2WzQmCuRe5STLR/WgWZeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761060485; c=relaxed/simple;
	bh=WMbjQNf+/6fBiKLcm2bw8S34Kgq52o5ZMkrYeVMZGuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j0hTUnySldfWgewxc2CV1FVuNBT9NlGhsHtNZYHcc8fBQsQsqshcZyIr022K1pohVAW4DfWD156EqcYC6NlJHG0kOSSMsJE4niRSn0GLpG1gGF+8R5EMn+InvAdUZxiIVlcob+j8BGfojv97d3doeNkMi+ThKO356HDku5RFILs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HmuHWM1d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0831BC19423
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 15:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761060485;
	bh=WMbjQNf+/6fBiKLcm2bw8S34Kgq52o5ZMkrYeVMZGuE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HmuHWM1dCEMkQEuNjQv0XBBPq6oZ2G3mrQ+kjKzsLZyVNkVghb85j9HKAkAV4juMe
	 Ho8u+SFRQfAOiM7ZZMhfvby7fH7oCb752Ao37hwmuZuCUItwt49qVAq/gyxAlg4QAh
	 m+g8tkEK4KtxcQbJ4I/ZH8xVdimW6byRuvnLsAiin/r6F/ODnWKvl4az3Mm86iVmjZ
	 qKfHn/FKVbDkX2Uheh1wFOUkZ+WY4DJBYJdC7jFGQj64s3rBHuC5G/RWr19JhOPmyb
	 Vtb4KcS0MMkNxaybqMLncMbIRlzp/PDC9c9DLlu97TXS23tWuICJQmccrgfB1nCEfr
	 XryhxEP3J/BQw==
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4711f156326so44290475e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 08:28:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU5ftS6nLlRt2J1PiqKUO1r72yIHqskGy9Exr8YwQM0lYd9998Aarvpjm+yeK3d+nKigRcMeaTe5K6ZKAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhrngikN85ocaYGqiuBpT7FtBW1Yoyu7auQ5j23LmmeKHhJf0S
	A1Fh+o96rsnywSRh4E3F5UmOKeniv3fFgZXcqNdrzBykAzaXpQtBJaGtLesMlHDeoz8oJWnpccO
	aVW8SUl2JwLESRai/msboKyTPtocckTA=
X-Google-Smtp-Source: AGHT+IHRoCdSFqTwXlcQgKf1IBsD/W3re0yM+Mwfei0lXknc2hlfjdQNBmIPRhDMhPEHa/Lq+5tmuCu1/kOCqlcbuEE=
X-Received: by 2002:a05:600c:870e:b0:46e:37a7:48d1 with SMTP id
 5b1f17b1804b1-4711791f94dmr163749325e9.34.1761060483386; Tue, 21 Oct 2025
 08:28:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020130801.68356-1-fangyu.yu@linux.alibaba.com>
In-Reply-To: <20251020130801.68356-1-fangyu.yu@linux.alibaba.com>
From: Guo Ren <guoren@kernel.org>
Date: Tue, 21 Oct 2025 08:27:50 -0700
X-Gmail-Original-Message-ID: <CAJF2gTRwHJsA7jFvAXbqy-6LyfaVTqfsFXgHfAeOZ8M3JNsikg@mail.gmail.com>
X-Gm-Features: AS18NWAxsjIpybjWNUteC13IenF-VTwNuRsft_RJ2w2vZiotn8Q2h6SsETn4OI4
Message-ID: <CAJF2gTRwHJsA7jFvAXbqy-6LyfaVTqfsFXgHfAeOZ8M3JNsikg@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Remove automatic I/O mapping for VM_PFNMAP
To: fangyu.yu@linux.alibaba.com
Cc: anup@brainfault.org, atish.patra@linux.dev, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, pbonzini@redhat.com, 
	jiangyifei@huawei.com, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, jgg@nvidia.com, 
	alex.williamson@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 6:08=E2=80=AFAM <fangyu.yu@linux.alibaba.com> wrote=
:
>
> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>
> As of commit aac6db75a9fc ("vfio/pci: Use unmap_mapping_range()"),
> vm_pgoff may no longer guaranteed to hold the PFN for VM_PFNMAP
> regions. Using vma->vm_pgoff to derive the HPA here may therefore
> produce incorrect mappings.
>
> Instead, I/O mappings for such regions can be established on-demand
> during g-stage page faults, making the upfront ioremap in this path
> is unnecessary.
>
> Fixes: 9d05c1fee837 ("RISC-V: KVM: Implement stage2 page table programmin=
g")
The Fixes tag should be 'commit aac6db75a9fc ("vfio/pci: Use
unmap_mapping_range()")'.

A stable tree necessitates minimizing the "Fixes tag" interference.

We also need to
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
For review.

> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> ---
>  arch/riscv/kvm/mmu.c | 20 +-------------------
>  1 file changed, 1 insertion(+), 19 deletions(-)
>
> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 525fb5a330c0..84c04c8f0892 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -197,8 +197,7 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
>
>         /*
>          * A memory region could potentially cover multiple VMAs, and
> -        * any holes between them, so iterate over all of them to find
> -        * out if we can map any of them right now.
> +        * any holes between them, so iterate over all of them.
>          *
>          *     +--------------------------------------------+
>          * +---------------+----------------+   +----------------+
> @@ -229,32 +228,15 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
>                 vm_end =3D min(reg_end, vma->vm_end);
>
>                 if (vma->vm_flags & VM_PFNMAP) {
> -                       gpa_t gpa =3D base_gpa + (vm_start - hva);
> -                       phys_addr_t pa;
> -
> -                       pa =3D (phys_addr_t)vma->vm_pgoff << PAGE_SHIFT;
> -                       pa +=3D vm_start - vma->vm_start;
> -
>                         /* IO region dirty page logging not allowed */
>                         if (new->flags & KVM_MEM_LOG_DIRTY_PAGES) {
>                                 ret =3D -EINVAL;
>                                 goto out;
>                         }
> -
> -                       ret =3D kvm_riscv_mmu_ioremap(kvm, gpa, pa, vm_en=
d - vm_start,
> -                                                   writable, false);
> -                       if (ret)
> -                               break;
Defering the ioremap to the g-stage page fault looks good to me, as it
simplifies the implementation here.

Acked-by: Guo Ren <guoren@kernel.org>

>                 }
>                 hva =3D vm_end;
>         } while (hva < reg_end);
>
> -       if (change =3D=3D KVM_MR_FLAGS_ONLY)
> -               goto out;
> -
> -       if (ret)
> -               kvm_riscv_mmu_iounmap(kvm, base_gpa, size);
> -
>  out:
>         mmap_read_unlock(current->mm);
>         return ret;
> --
> 2.50.1
>


--=20
Best Regards
 Guo Ren

