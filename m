Return-Path: <linux-kernel+bounces-864103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DB304BF9E96
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 06:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 995454EE1C1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 04:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106F51DE4DC;
	Wed, 22 Oct 2025 04:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eUr6MIsJ"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC6B279358
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 04:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761106143; cv=none; b=NoVi+vagnZI2jerC777eRsrh8HvzprgcFhQ9fUiCwFjays/5YSSEHgciJ6qDWiUgB9BI4GZ4xzYz2nOGrohiHfsgS1mfziS/+G+dESfLC8pFMClsNyiPHozvhc2CU94uguW6fi57D5iNhKBgvka9SUjPkI+6qdpFWcCLvHR97GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761106143; c=relaxed/simple;
	bh=I8qRM+kpqS0ojcdEOO1tGcuHmMCvEq69+dG5eW2Aapo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mXeaNigXmmbnw5SzOsLN/EFFp2IgHO3ecIRKoBsQQpwSmHlCDlNuJw4B8vWgUjxePZFF4YbqPNz19OzvsVus0J8LeEYWmkk6209lFKKe72Mh1Hm87B/RxLh1WKrsttKrIDFKFkFrD+7/dvvSHymq9ngNXGquGhbJ+HwGTKtevy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eUr6MIsJ; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8906eb94264so867096685a.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 21:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761106138; x=1761710938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=URErFMYOLyHpAjEwaEXcwkMOPsj73MCltrwJY2rXne8=;
        b=eUr6MIsJYdUKv5TXASfNXAYyPwcJjuxnAPbnt1xIu/CG3RbBw4kp9UBeK+IZsO3425
         VJfzJ+Joq6LyZu1FvClj3R4YgeMcqCruhdQdXg6fHc4hFEILRUObvTeCBAap0mU2Cjny
         dThnEhTDPqfPHIbphoxPiCmWmlpKw2Edn3oZE1ICx2986qeq2KJSbZs3B2YVBwNo/W/U
         SURtRofpCiNxa9TBjHSIwhaKsBeH2pUzZqovUVohCBuhbpWboiBvEU7ktCquYcCDjrcV
         ozGL0Auv/4n5FV1pYs6zhCf85ev40yib3MyWuAb8y4FgoxgSXglht81+JZaPj8mhFdES
         UULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761106138; x=1761710938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=URErFMYOLyHpAjEwaEXcwkMOPsj73MCltrwJY2rXne8=;
        b=s2ZzgrOmjgY68qFQ+ncuhI9Jbqr4P4NKjX8jRoOCxh4PN1Ui1cIT4qLIbc1KiigZFy
         3+KLORfFB5VCE2UQFjetDBjnWeYU1Lb5qSkZin4fz1p+ssGFUOWdo8dDeIG2JwDqLhcX
         7H5JebEQMVvqKMJrcVM3MxhtaAuEZassU7g4sSCuaar6v7KT2GrPP648gFvHASDRl7a5
         VMHgFhk6TA/QJ9SvIOyntiGuGIgfTjpJ+LQoVjxRqv6Af7gxKcB3Fy4V+mDm7Oo66gnp
         5kwxpjYMgzWAFlfDbaCoscrIxfbN71d7sryd/mpsffpj6HyN84K1EvZ3ZfPuTkkENlXH
         jKzQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3syXWUNx6HEoXH8TbYOpPZMN3X/khzdXtdQRanJfybECn8b9B3KA1CIWRb/Df0BdY3Aypa4TWlu5GFt8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHimclnqp7+XyZF+Dzc8z3w3qx766aFBSSLE4W7WZ2UBqkYi+C
	o/8jDmpvbKcSNvkJbkNwpa8pC+3AlQ74AUKwkXKeSWWFmv4Z+1WrTsGW2fuJJ78xzBS35WzZUGu
	Nn4Cwo2jeEgpHiZQXVv34sky7BCxRQ08=
X-Gm-Gg: ASbGncvdcanRPGfVHBmtfKNpjMmd02qn2b09p5ljCmGWkK9Kbn9TtFciPPkOjHVB15E
	29qOrq1G1LNcNhEeHM7ggyeSPTNH3ateSKYJtnIoKvgc9g8EFgGv1Z94T1M8j5ZD4BOTEq3/1CG
	nQED8Msm99qQ3x7IgwZkDAyemqHJtruHZMCieZAuPTIIrZ8DdfuM0Y+rzj/X4QEDJL56cCxJdXy
	LSwotU5BcAp/N9ajUDJ4GxRl1OvObmF6hRXSh+5gXFgYX+cVHbMKe+cmIRE/uwF9/alDQ9+YtVZ
	TwtVfI53NpBeBtuZ
X-Google-Smtp-Source: AGHT+IGH2SZ0WRdKh3j7EkOtPTZS6RKLKqRp7QWRcXCt+UnJ5XXc0fzRoyKcNi/2idgTj+GrP0UQbD3joeBzcCGF8bI=
X-Received: by 2002:a05:620a:394b:b0:85e:5fef:86fa with SMTP id
 af79cd13be357-8906e9a4759mr2627239885a.28.1761106138195; Tue, 21 Oct 2025
 21:08:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013092038.6963-1-ying.huang@linux.alibaba.com> <20251013092038.6963-3-ying.huang@linux.alibaba.com>
In-Reply-To: <20251013092038.6963-3-ying.huang@linux.alibaba.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 22 Oct 2025 17:08:47 +1300
X-Gm-Features: AS18NWC2SmOG0fXr6JtdNTOm9s8laV21PFicKhXafLS2YkktGrTmfAKkyqEoEAM
Message-ID: <CAGsJ_4xaA8QRjP9H=n1hQfEfGop7vOd5Y=J+KQzuOyfa8GK-kQ@mail.gmail.com>
Subject: Re: [PATCH -v2 2/2] arm64, tlbflush: don't TLBI broadcast if page
 reused in write fault
To: Huang Ying <ying.huang@linux.alibaba.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Yang Shi <yang@os.amperecomputing.com>, "Christoph Lameter (Ampere)" <cl@gentwo.org>, Dev Jain <dev.jain@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Kevin Brodsky <kevin.brodsky@arm.com>, 
	Yin Fengwei <fengwei_yin@linux.alibaba.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pg=
table.h
> index aa89c2e67ebc..35bae2e4bcfe 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -130,12 +130,16 @@ static inline void arch_leave_lazy_mmu_mode(void)
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>
>  /*
> - * Outside of a few very special situations (e.g. hibernation), we alway=
s
> - * use broadcast TLB invalidation instructions, therefore a spurious pag=
e
> - * fault on one CPU which has been handled concurrently by another CPU
> - * does not need to perform additional invalidation.
> + * We use local TLB invalidation instruction when reusing page in
> + * write protection fault handler to avoid TLBI broadcast in the hot
> + * path.  This will cause spurious page faults if stall read-only TLB
> + * entries exist.
>   */
> -#define flush_tlb_fix_spurious_fault(vma, address, ptep) do { } while (0=
)
> +#define flush_tlb_fix_spurious_fault(vma, address, ptep)       \
> +       local_flush_tlb_page_nonotify(vma, address)
> +
> +#define flush_tlb_fix_spurious_fault_pmd(vma, address, pmdp)   \
> +       local_flush_tlb_page_nonotify(vma, address)
>
>  /*
>   * ZERO_PAGE is a global shared page that is always zero: used
> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/t=
lbflush.h
> index 18a5dc0c9a54..651b31fd18bb 100644
> --- a/arch/arm64/include/asm/tlbflush.h
> +++ b/arch/arm64/include/asm/tlbflush.h
> @@ -249,6 +249,18 @@ static inline unsigned long get_trans_granule(void)
>   *             cannot be easily determined, the value TLBI_TTL_UNKNOWN w=
ill
>   *             perform a non-hinted invalidation.
>   *
> + *     local_flush_tlb_page(vma, addr)
> + *             Local variant of flush_tlb_page().  Stale TLB entries may
> + *             remain in remote CPUs.
> + *
> + *     local_flush_tlb_page_nonotify(vma, addr)
> + *             Same as local_flush_tlb_page() except MMU notifier will n=
ot be
> + *             called.
> + *
> + *     local_flush_tlb_contpte_range(vma, start, end)
> + *             Invalidate the virtual-address range '[start, end)' mappe=
d with
> + *             contpte on local CPU for the user address space correspon=
ding
> + *             to 'vma->mm'.  Stale TLB entries may remain in remote CPU=
s.
>   *
>   *     Finally, take a look at asm/tlb.h to see how tlb_flush() is imple=
mented
>   *     on top of these routines, since that is our interface to the mmu_=
gather
> @@ -282,6 +294,33 @@ static inline void flush_tlb_mm(struct mm_struct *mm=
)
>         mmu_notifier_arch_invalidate_secondary_tlbs(mm, 0, -1UL);
>  }
>
> +static inline void __local_flush_tlb_page_nonotify_nosync(
> +       struct mm_struct *mm, unsigned long uaddr)
> +{
> +       unsigned long addr;
> +
> +       dsb(nshst);

We were issuing dsb(ishst) even for the nosync case, likely to ensure
PTE visibility across cores. However, since set_ptes already includes a
dsb(ishst) in __set_pte_complete(), does this mean we=E2=80=99re being over=
ly
cautious in __flush_tlb_page_nosync() in many cases?

static inline void __flush_tlb_page_nosync(struct mm_struct *mm,
                                           unsigned long uaddr)
{
        unsigned long addr;

        dsb(ishst);
        addr =3D __TLBI_VADDR(uaddr, ASID(mm));
        __tlbi(vale1is, addr);
        __tlbi_user(vale1is, addr);
        mmu_notifier_arch_invalidate_secondary_tlbs(mm, uaddr & PAGE_MASK,
                                                (uaddr & PAGE_MASK) +
PAGE_SIZE);
}

On the other hand, __ptep_set_access_flags() doesn=E2=80=99t seem to use
set_ptes(), so there=E2=80=99s no guarantee the updated PTEs are visible to=
 all
cores. If a remote CPU later encounters a page fault and performs a TLB
invalidation, will it still see a stable PTE?

> +       addr =3D __TLBI_VADDR(uaddr, ASID(mm));
> +       __tlbi(vale1, addr);
> +       __tlbi_user(vale1, addr);
> +}
> +
> +static inline void local_flush_tlb_page_nonotify(
> +       struct vm_area_struct *vma, unsigned long uaddr)
> +{
> +       __local_flush_tlb_page_nonotify_nosync(vma->vm_mm, uaddr);
> +       dsb(nsh);
> +}
> +
> +static inline void local_flush_tlb_page(struct vm_area_struct *vma,
> +                                       unsigned long uaddr)
> +{
> +       __local_flush_tlb_page_nonotify_nosync(vma->vm_mm, uaddr);
> +       mmu_notifier_arch_invalidate_secondary_tlbs(vma->vm_mm, uaddr & P=
AGE_MASK,
> +                                               (uaddr & PAGE_MASK) + PAG=
E_SIZE);
> +       dsb(nsh);
> +}
> +
>  static inline void __flush_tlb_page_nosync(struct mm_struct *mm,
>                                            unsigned long uaddr)
>  {
> @@ -472,6 +511,23 @@ static inline void __flush_tlb_range(struct vm_area_=
struct *vma,
>         dsb(ish);
>  }
>

We already have functions like
__flush_tlb_page_nosync() and __flush_tlb_range_nosync().
Is there a way to factor out or extract their common parts?

Is it because of the differences in barriers that this extraction of
common code isn=E2=80=99t feasible?

Thanks
Barry

