Return-Path: <linux-kernel+bounces-890257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE4AC3F9F6
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 12:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 009E21886C05
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 11:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29C931BC96;
	Fri,  7 Nov 2025 11:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="RRKF3SmG"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2119C30FC23
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 11:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762513432; cv=none; b=OEsXJsEEbHTQvGgCbxCqnFEW5xApqweCuF3A2oi0EHIsxL6RlwSXusSuAybV9/L1hk9Z37/5cRrD1to+nBu1x+KZeqO+z5ytIpnFg+SqnDadCB/8Pti2GxSq0RpNM9+Knlkdy6S7VfFOfO/R03enF/qzq4RM4of8Od5IrYE9GfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762513432; c=relaxed/simple;
	bh=0fw1/YbRWy6gWq68BnCE8l2uBEBd3mCZS6gv/mQw5O8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RhDxEmqzmEcWQgvFKm10+R9/gprQiR0WwXAgj3kos+k+ZUhsqtB27yn/9FndS19DJaxMPFouLV7A/cPpVM9Biygy/6lv7PVVMJnPpYaj6aJYCOZSQxr5QVjcihgUGF7R9jwebNpMiIWewtwYEeP/KzSaPk9PTXhNGjdUG5UwOF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=RRKF3SmG; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-4334e884b9dso2079945ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 03:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1762513429; x=1763118229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wHYVI+8cZwmcaMV+j3m2ndZp/CPeHOqPlXMZfLRT9g4=;
        b=RRKF3SmGutSbZEumZuJG2j+dFhuPXIefqmsWpx5TXKWla8xTSsxDtAVSd7JEEtpv3I
         nXGjbXCfaWeVlc7kTv24oFaC2kS1qk5ubhBReXJse3Yv2YF+LuZmXlblMYRM641L6mXT
         mYEL29UyaIwiVQRXx4sUlS9P8bynjR2/wp5dMrYojr5VHqahdp89wWxPvc/wObfVyc7l
         e2ezTY9zbieZdFHghh3O+yttleuBP/G4zp2XPxBlMrO3W4sojIMlYcpK73E15LxkXaQE
         u3hwvLKmfSiGD6DwKkGoJR9aLLddz2BtWF0Ww7Zz91kW2pUgXYqaV44AHMlH4KX/Y4Pg
         Jk6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762513429; x=1763118229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wHYVI+8cZwmcaMV+j3m2ndZp/CPeHOqPlXMZfLRT9g4=;
        b=giHjUl/7uzwnrVzPhTOiuRm1tFwrV3RNdYw9Y4WcSki99j0Smz4iXzxStRs57zJzMX
         p61eQvb0XSPoYQ/2r3XZ84h12MPvVtEW6ILFX+z1nTNqrEyRnPzkBjmjE4L1P86WL3Fa
         VqufmMZbRkBhxeBQKITxBmjHc5t+ZHgOGVFUbkzgDiXGqFu7E7aIW16X5QaL4r9gH8EE
         rSE+wqixoMHjJmksSvkuWTKWM1MJVBuSCVhPpZCVixfRJV7dYjDC0Jnt1wCcaKskU9tl
         mM1NLJqEmiEo+9OCEitk2A5XDWKl4CfVmxca6EiTGwyv7xIV88d+QPr1MEmD1VhMCtkb
         zH8g==
X-Forwarded-Encrypted: i=1; AJvYcCV68ledSjgPlb1u4o5WNjzyI8jG4XstuK5Soyb0C3J/1En2JPk4w0Xsi9M9E7hlytT3jG0T5xFYSNx6U3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YypNxzdPiJHE6quEY8vm2DfqvFwwAB4boyfpbMFrseOdhLiZ3oD
	fQcjrp0l36WlaziN6B/V+PFprmMCzd6Iqy6fPrczLGWnpeq5cNx3kzRkMvqvLqmu3kz2ihw3Fxq
	rlbfmzM0oZSJOvoVfqjFjC/Tgi+8lAw7KoBT8cgtWWw==
X-Gm-Gg: ASbGnct7IXEVRZsImTwQxfsKxxQaPgD5s2AfdhNT2BcUu/pdyPSIHMLqHSWi4g6RLiR
	A+QLQA98tMqpe8eaooE7NZMSXv2D3tSzydBCI4TIDSdhGAN2u64RAOUw4nxW07tSWNj3dF9boQJ
	q1uxw8U3aYz7HjC6CUUc6y2S5bEEYKx+GES2Vc/J1IZWkDgV14/TCDWon3F11/2fZGDlO6f/yQF
	Y+UTsJTLy+SV/wcuXS5/YjzE3YFbEOx14Lq7L3deb+N4DAcnGTjS5E4Q8xJvrehcC8nYGzQ
X-Google-Smtp-Source: AGHT+IFtcA147LKxgqVhXLwksm/C9cqoMFmxz+pjS9Ugqk04E6hCfo3BhIC9tYqTe4/PzGza7zQwdYHoqwV6apXMQ6Y=
X-Received: by 2002:a92:ce05:0:b0:433:2499:92f8 with SMTP id
 e9e14a558f8ab-433629909d2mr10843565ab.5.1762513429091; Fri, 07 Nov 2025
 03:03:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202509301520545960_jMIljfZY7bMHBkBbaHR@zte.com.cn>
In-Reply-To: <202509301520545960_jMIljfZY7bMHBkBbaHR@zte.com.cn>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 7 Nov 2025 16:33:38 +0530
X-Gm-Features: AWmQ_bmTbcoZymk1iItPjpuqlNXRDDtkY0L31utCtpv82eMgZLUJ2JB8cmAcIn4
Message-ID: <CAAhSdy1u0MkWqreL-fDYZq3KvpAVFPefK0osJ7tai1oXGSyw7w@mail.gmail.com>
Subject: Re: [PATCH v2] RISC-V: KVM: Transparent huge page support
To: liu.xuemei1@zte.com.cn
Cc: atish.patra@linux.dev, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 12:51=E2=80=AFPM <liu.xuemei1@zte.com.cn> wrote:
>
> From: Jessica Liu <liu.xuemei1@zte.com.cn>
>
> Use block mapping if backed by a THP, as implemented in architectures
> like ARM and x86_64.
>
> Signed-off-by: Jessica Liu <liu.xuemei1@zte.com.cn>
> ---
> Changes in v2:
> - Fixed the typo of writing PAGE_SHIFT as PAGE_SIZE.
>
>  arch/riscv/include/asm/kvm_gstage.h |   3 +
>  arch/riscv/kvm/gstage.c             | 100 ++++++++++++++++++++++++++++
>  arch/riscv/kvm/mmu.c                |  12 +++-
>  3 files changed, 114 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/kvm_gstage.h b/arch/riscv/include/asm=
/kvm_gstage.h
> index 595e2183173e..cc67fb2d2d42 100644
> --- a/arch/riscv/include/asm/kvm_gstage.h
> +++ b/arch/riscv/include/asm/kvm_gstage.h
> @@ -69,4 +69,7 @@ void kvm_riscv_gstage_wp_range(struct kvm_gstage *gstag=
e, gpa_t start, gpa_t end
>
>  void kvm_riscv_gstage_mode_detect(void);
>
> +long kvm_riscv_gstage_thp_adjust(struct kvm *kvm, struct kvm_memory_slot=
 *memslot,
> +                                unsigned long hva, kvm_pfn_t *pfnp, gpa_=
t *gpa);
> +
>  #endif
> diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
> index 24c270d6d0e2..129dee62c570 100644
> --- a/arch/riscv/kvm/gstage.c
> +++ b/arch/riscv/kvm/gstage.c
> @@ -77,6 +77,106 @@ static int gstage_level_to_page_size(u32 level, unsig=
ned long *out_pgsize)
>         return 0;
>  }
>
> +static int gstage_get_user_mapping_size(struct kvm *kvm, u64 addr)
> +{
> +       pte_t *ptepp;
> +       u32 ptep_level;
> +       unsigned long out_pgsize;
> +       struct kvm_gstage gstage =3D {
> +               .pgd =3D kvm->mm->pgd
> +       };
> +
> +       if (!kvm_riscv_gstage_get_leaf(&gstage, addr, &ptepp, &ptep_level=
))
> +               return -EFAULT;
> +
> +       if (gstage_level_to_page_size(ptep_level, &out_pgsize))
> +               return -EFAULT;
> +
> +       return out_pgsize;
> +}
> +
> +static bool gstage_supports_huge_mapping(struct kvm_memory_slot *memslot=
, unsigned long hva)
> +{
> +       gpa_t gpa_start;
> +       hva_t uaddr_start, uaddr_end;
> +       size_t size;
> +
> +       size =3D memslot->npages * PAGE_SIZE;
> +       uaddr_start =3D memslot->userspace_addr;
> +       uaddr_end =3D uaddr_start + size;
> +
> +       gpa_start =3D memslot->base_gfn << PAGE_SHIFT;
> +
> +       /*
> +        * Pages belonging to memslots that don't have the same alignment
> +        * within a PMD for userspace and GPA cannot be mapped with g-sta=
ge
> +        * PMD entries, because we'll end up mapping the wrong pages.
> +        *
> +        * Consider a layout like the following:
> +        *
> +        *    memslot->userspace_addr:
> +        *    +-----+--------------------+--------------------+---+
> +        *    |abcde|fgh  vs-stage block  |    vs-stage block tv|xyz|
> +        *    +-----+--------------------+--------------------+---+
> +        *
> +        *    memslot->base_gfn << PAGE_SHIFT:
> +        *      +---+--------------------+--------------------+-----+
> +        *      |abc|def  g-stage block  |    g-stage block   |tvxyz|
> +        *      +---+--------------------+--------------------+-----+
> +        *
> +        * If we create those g-stage blocks, we'll end up with this inco=
rrect
> +        * mapping:
> +        *   d -> f
> +        *   e -> g
> +        *   f -> h
> +        */
> +       if ((gpa_start & (PMD_SIZE - 1)) !=3D (uaddr_start & (PMD_SIZE - =
1)))
> +               return false;
> +
> +       /*
> +        * Next, let's make sure we're not trying to map anything not cov=
ered
> +        * by the memslot. This means we have to prohibit block size mapp=
ings
> +        * for the beginning and end of a non-block aligned and non-block=
 sized
> +        * memory slot (illustrated by the head and tail parts of the
> +        * userspace view above containing pages 'abcde' and 'xyz',
> +        * respectively).
> +        *
> +        * Note that it doesn't matter if we do the check using the
> +        * userspace_addr or the base_gfn, as both are equally aligned (p=
er
> +        * the check above) and equally sized.
> +        */
> +       return (hva >=3D ALIGN(uaddr_start, PMD_SIZE)) && (hva < ALIGN_DO=
WN(uaddr_end, PMD_SIZE));
> +}
> +
> +long kvm_riscv_gstage_thp_adjust(struct kvm *kvm, struct kvm_memory_slot=
 *memslot,
> +                                unsigned long hva, kvm_pfn_t *hfnp, gpa_=
t *gpa)
> +{
> +       kvm_pfn_t hfn =3D *hfnp;
> +
> +       /*
> +        * Make sure the adjustment is done only for THP pages. Also make
> +        * sure that the HVA and GPA are sufficiently aligned and that th=
e
> +        * block map is contained within the memslot.
> +        */
> +       if (gstage_supports_huge_mapping(memslot, hva)) {
> +               int sz =3D gstage_get_user_mapping_size(kvm, hva);
> +
> +               if (sz < 0)
> +                       return sz;
> +
> +               if (sz < PMD_SIZE)
> +                       return PAGE_SIZE;
> +
> +               *gpa &=3D PMD_MASK;
> +               hfn &=3D ~(PTRS_PER_PMD - 1);
> +               *hfnp =3D hfn;
> +
> +               return PMD_SIZE;
> +       }
> +
> +       return PAGE_SIZE;
> +}
> +

The gstage.c is for common page table management which will be
shared by nested virtualization and pKVM. whereas mmu.c is for
host/hypervisor mappings.

All above functions except gstage_get_user_mapping_size() must
be moved to mmu.c.

Also, change prototype of gstage_get_user_mapping_size() to
int kvm_riscv_gstage_get_mapping_size(struct kvm_gstage *gstage, gpa_t addr=
);

>  bool kvm_riscv_gstage_get_leaf(struct kvm_gstage *gstage, gpa_t addr,
>                                pte_t **ptepp, u32 *ptep_level)
>  {
> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 525fb5a330c0..f70cf721ebb8 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -337,7 +337,8 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct k=
vm_memory_slot *memslot,
>         struct kvm_mmu_memory_cache *pcache =3D &vcpu->arch.mmu_page_cach=
e;
>         bool logging =3D (memslot->dirty_bitmap &&
>                         !(memslot->flags & KVM_MEM_READONLY)) ? true : fa=
lse;
> -       unsigned long vma_pagesize, mmu_seq;
> +       unsigned long mmu_seq;
> +       long vma_pagesize;
>         struct kvm_gstage gstage;
>         struct page *page;
>
> @@ -416,6 +417,15 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct =
kvm_memory_slot *memslot,
>         if (mmu_invalidate_retry(kvm, mmu_seq))
>                 goto out_unlock;
>
> +       /* check if we are backed by a THP and thus use block mapping if =
possible */
> +       if (vma_pagesize =3D=3D PAGE_SIZE) {
> +               vma_pagesize =3D kvm_riscv_gstage_thp_adjust(kvm, memslot=
, hva, &hfn, &gpa);
> +               if (vma_pagesize < 0) {
> +                       ret =3D vma_pagesize;
> +                       goto out_unlock;
> +               }
> +       }
> +
>         if (writable) {
>                 mark_page_dirty_in_slot(kvm, memslot, gfn);
>                 ret =3D kvm_riscv_gstage_map_page(&gstage, pcache, gpa, h=
fn << PAGE_SHIFT,
> --
> 2.27.0
>

Regards,
Anup

