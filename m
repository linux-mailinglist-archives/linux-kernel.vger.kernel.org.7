Return-Path: <linux-kernel+bounces-755907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2ACB1AD2D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 06:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B788188EAAE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 04:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB1D1C5D5E;
	Tue,  5 Aug 2025 04:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jS96Vd6Q"
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F961B960
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 04:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754368553; cv=none; b=XkSB/K2cnOWgkCw6GKenxAd2Y740l1X8CwpbMdflaciLGEEAG0MIzvMY4zFK7cRennDi6m6HLCTJrE8jvdtB5V5vjUxdLL45QsqMFfVHsSQXupQsmE7VMl0ajaWcU9PcEkKvcKwrIvXKldF8Pw1CYPxpG5HuEFyGAIhC7eO6JK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754368553; c=relaxed/simple;
	bh=G3HvNSu/7vxGr5e4FPSzWQm7pO3v8no5Ynbp/3aUz4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qCCAJ7/FrwY1vh6OCUXiMoK0lXg4VynOlCg3Ieh+0PCC9SCbTZR5GUYIDmp35dOkRxRv/+cYE2xnlMJYd6mEl1KBIoHVgq1tLch7IBU3fhkHQaVfC2KoqZsWkraQ+nX9fI/Keibd7y2Ik+F3JRY+rBeABSGSboniRpRyR5oWSeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jS96Vd6Q; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-4fe7dd45935so1085745137.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 21:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754368551; x=1754973351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KrVxzJX4t1BltjWBEp2/n51TWEMkIY0NHFDZNcU8IC0=;
        b=jS96Vd6QERBzjEeVnJ7qEPXZqHA6AXHBttekpAjSGNFTZmVPR0U1x/0mlphpQkxEh/
         5n3zPC8GELCf7z8s0OBN9mke9xoAhRRCU6lOkvgGx28JhWepP3/yoFbaeyzgEparuQUk
         HkGSl6x664w+OGtRn+w54oHei8bM1dciJvW9I6ByFSuRZypgNL471+Kn2M3MTVxpwbFg
         JivYxkujcduDXqWNWI3glARKeYbz/H3QNUFPu0YwVS0Li8P0CWdqscUbuLQIDauvimo/
         ermRwLU/JMgr1HzdcXxMu/ekFiR2WvOlEo+kdMA7zgSr4xvkasusEnddRiu5sswgL6Q+
         1cuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754368551; x=1754973351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KrVxzJX4t1BltjWBEp2/n51TWEMkIY0NHFDZNcU8IC0=;
        b=ewSLSmqngnYXFfQPZkXGkrkNvGc7hwTMIzkLtbXCzC1X8aurJ5VAUjZLagAt6dKqUc
         7872mzirxmEDdPpNm6lKt7JoBoCQb0NbBsP7ImtKh5XuoXgtkgXTLKDPgA/nfZZaKB5f
         Zr0PbJ7qlqiFxkEEif83Bp0+Pq+G6XreCflxhLcdoW4gfDqZizM/2/CHWZnRNRPdR0jF
         x/peG9rdyMYYxp1xx88frSkTffqK6SjeEPGoGlG2fBLvE3tDv/0Y+8PQ/c/k4ONoFBwJ
         EUsLbxTC7F2s9XJJrXcjIl0HDUGUe09ojKE+vcTLfbUcuy3Wf9/gt9SDLLwJKGMKr1KJ
         K+Rg==
X-Forwarded-Encrypted: i=1; AJvYcCXHCCBvyewm2oOa8HMKh453kOnPFo30z9Z1tWQq+rEBLOopywlUkLLGsEqz/PkxVlMVuUYEfrsTSVhigYY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzktQ0xeC+J2xBuJzAyY1vPQMgqC9EWb6o0ZQMEcpFgi5/xJwLo
	42RT4gOG7yZRfFWDg0Tt96tD3v9+GT97FXgfskJ4TCF4gKTnCJoY850uIIQahUTAVDqNz4kLTmw
	jruqkjucJKeqmV7x17fGqDfRzHtGbC8s=
X-Gm-Gg: ASbGnctt6vzunX5qATOj+w7qy2rRcZp38o+9HoU83PWWjQBsddZDq1MM/rpWsyTnGzx
	DC6Ur3DCLAowgSFb5STfAR0kEArQ1OQbY5uOeYCp92Ks0NauZ4MYgIO+fiXv6yANPwCTW4LI+DZ
	R0/q9UlcTuQtpKIIb/MetBIIVjr8kDxOsr+CFwHj7KcVA5ZtXDPsJxAMpk/760qqnSwW03xpAdK
	mwwlFs=
X-Google-Smtp-Source: AGHT+IFkvdFOCiNIJbthzi6nYhoUdCEQi014JIFL6hmsWzhgV/SedYlYwX1OXPH7HE8mkUUR2rDIVdiqkBNFtJt2wi4=
X-Received: by 2002:a05:6102:800c:b0:4ec:c548:e10e with SMTP id
 ada2fe7eead31-4fdc1954e12mr5531645137.3.1754368550800; Mon, 04 Aug 2025
 21:35:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731104726.103071-1-lokeshgidra@google.com>
In-Reply-To: <20250731104726.103071-1-lokeshgidra@google.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 5 Aug 2025 12:35:39 +0800
X-Gm-Features: Ac12FXymlTMYwPCxmyr6leqj8wZSHxW3roj7vV4cwZ9AAUBxFtkVExOdqRVGi5c
Message-ID: <CAGsJ_4yJ5mtk_mp3r=PsMZOnHdtEk2Q_UTDjwy=4cmV8mcz+mg@mail.gmail.com>
Subject: Re: [PATCH] userfaultfd: opportunistic TLB-flush batching for present
 pages in MOVE
To: Lokesh Gidra <lokeshgidra@google.com>
Cc: akpm@linux-foundation.org, aarcange@redhat.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, ngeoffray@google.com, 
	Suren Baghdasaryan <surenb@google.com>, Kalesh Singh <kaleshsingh@google.com>, 
	Barry Song <v-songbaohua@oppo.com>, David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2025 at 6:47=E2=80=AFPM Lokesh Gidra <lokeshgidra@google.co=
m> wrote:
>
> MOVE ioctl's runtime is dominated by TLB-flush cost, which is required
> for moving present pages. Mitigate this cost by opportunistically
> batching present contiguous pages for TLB flushing.
>
> Without batching, in our testing on an arm64 Android device with UFFD GC,
> which uses MOVE ioctl for compaction, we observed that out of the total
> time spent in move_pages_pte(), over 40% is in ptep_clear_flush(), and
> ~20% in vm_normal_folio().
>
> With batching, the proportion of vm_normal_folio() increases to over
> 70% of move_pages_pte() without any changes to vm_normal_folio().
> Furthermore, time spent within move_pages_pte() is only ~20%, which
> includes TLB-flush overhead.
>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Kalesh Singh <kaleshsingh@google.com>
> Cc: Barry Song <v-songbaohua@oppo.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
> ---
>  mm/userfaultfd.c | 179 +++++++++++++++++++++++++++++++++--------------
>  1 file changed, 127 insertions(+), 52 deletions(-)
>
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 8253978ee0fb..2465fb234671 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -1026,18 +1026,62 @@ static inline bool is_pte_pages_stable(pte_t *dst=
_pte, pte_t *src_pte,
>                pmd_same(dst_pmdval, pmdp_get_lockless(dst_pmd));
>  }
>
> -static int move_present_pte(struct mm_struct *mm,
> -                           struct vm_area_struct *dst_vma,
> -                           struct vm_area_struct *src_vma,
> -                           unsigned long dst_addr, unsigned long src_add=
r,
> -                           pte_t *dst_pte, pte_t *src_pte,
> -                           pte_t orig_dst_pte, pte_t orig_src_pte,
> -                           pmd_t *dst_pmd, pmd_t dst_pmdval,
> -                           spinlock_t *dst_ptl, spinlock_t *src_ptl,
> -                           struct folio *src_folio)
> +/*
> + * Checks if the two ptes and the corresponding folio are eligible for b=
atched
> + * move. If so, then returns pointer to the folio, after locking it. Oth=
erwise,
> + * returns NULL.
> + */
> +static struct folio *check_ptes_for_batched_move(struct vm_area_struct *=
src_vma,
> +                                                unsigned long src_addr,
> +                                                pte_t *src_pte, pte_t *d=
st_pte)
> +{
> +       pte_t orig_dst_pte, orig_src_pte;
> +       struct folio *folio;
> +
> +       orig_dst_pte =3D ptep_get(dst_pte);
> +       if (!pte_none(orig_dst_pte))
> +               return NULL;
> +
> +       orig_src_pte =3D ptep_get(src_pte);
> +       if (pte_none(orig_src_pte))
> +               return NULL;
> +       if (!pte_present(orig_src_pte) || is_zero_pfn(pte_pfn(orig_src_pt=
e)))
> +               return NULL;
> +
> +       folio =3D vm_normal_folio(src_vma, src_addr, orig_src_pte);
> +       if (!folio || !folio_trylock(folio))
> +               return NULL;
> +       if (!PageAnonExclusive(&folio->page) || folio_test_large(folio)) =
{
> +               folio_unlock(folio);
> +               return NULL;
> +       }
> +       return folio;
> +}
> +
> +static long move_present_ptes(struct mm_struct *mm,
> +                             struct vm_area_struct *dst_vma,
> +                             struct vm_area_struct *src_vma,
> +                             unsigned long dst_addr, unsigned long src_a=
ddr,
> +                             pte_t *dst_pte, pte_t *src_pte,
> +                             pte_t orig_dst_pte, pte_t orig_src_pte,
> +                             pmd_t *dst_pmd, pmd_t dst_pmdval,
> +                             spinlock_t *dst_ptl, spinlock_t *src_ptl,
> +                             struct folio *src_folio, unsigned long len)
>  {
>         int err =3D 0;
> +       unsigned long src_start =3D src_addr;
> +       unsigned long addr_end;
> +
> +       if (len > PAGE_SIZE) {
> +               addr_end =3D (dst_addr + PMD_SIZE) & PMD_MASK;
> +               if (dst_addr + len > addr_end)
> +                       len =3D addr_end - dst_addr;
>
> +               addr_end =3D (src_addr + PMD_SIZE) & PMD_MASK;
> +               if (src_addr + len > addr_end)
> +                       len =3D addr_end - src_addr;
> +       }
> +       flush_cache_range(src_vma, src_addr, src_addr + len);
>         double_pt_lock(dst_ptl, src_ptl);
>
>         if (!is_pte_pages_stable(dst_pte, src_pte, orig_dst_pte, orig_src=
_pte,
> @@ -1051,31 +1095,60 @@ static int move_present_pte(struct mm_struct *mm,
>                 err =3D -EBUSY;
>                 goto out;
>         }
> +       /* Avoid batching overhead for single page case */
> +       if (len > PAGE_SIZE) {
> +               flush_tlb_batched_pending(mm);

What=E2=80=99s confusing to me is that they track the unmapping of multiple
consecutive PTEs and defer TLB invalidation until later.
In contrast, you=E2=80=99re not tracking anything and instead call
flush_tlb_range() directly, which triggers the flush immediately.

It seems you might be combining two different batching approaches.
From what I can tell, you're essentially using flush_range
as a replacement for flushing each entry individually.

> +               arch_enter_lazy_mmu_mode();
> +               orig_src_pte =3D ptep_get_and_clear(mm, src_addr, src_pte=
);
> +       } else
> +               orig_src_pte =3D ptep_clear_flush(src_vma, src_addr, src_=
pte);
> +
> +       addr_end =3D src_start + len;
> +       do {
> +               /* Folio got pinned from under us. Put it back and fail t=
he move. */
> +               if (folio_maybe_dma_pinned(src_folio)) {
> +                       set_pte_at(mm, src_addr, src_pte, orig_src_pte);
> +                       err =3D -EBUSY;
> +                       break;
> +               }
>
> -       orig_src_pte =3D ptep_clear_flush(src_vma, src_addr, src_pte);
> -       /* Folio got pinned from under us. Put it back and fail the move.=
 */
> -       if (folio_maybe_dma_pinned(src_folio)) {
> -               set_pte_at(mm, src_addr, src_pte, orig_src_pte);
> -               err =3D -EBUSY;
> -               goto out;
> -       }
> -
> -       folio_move_anon_rmap(src_folio, dst_vma);
> -       src_folio->index =3D linear_page_index(dst_vma, dst_addr);
> +               folio_move_anon_rmap(src_folio, dst_vma);
> +               src_folio->index =3D linear_page_index(dst_vma, dst_addr)=
;
>
> -       orig_dst_pte =3D folio_mk_pte(src_folio, dst_vma->vm_page_prot);
> -       /* Set soft dirty bit so userspace can notice the pte was moved *=
/
> +               orig_dst_pte =3D folio_mk_pte(src_folio, dst_vma->vm_page=
_prot);
> +               /* Set soft dirty bit so userspace can notice the pte was=
 moved */
>  #ifdef CONFIG_MEM_SOFT_DIRTY
> -       orig_dst_pte =3D pte_mksoft_dirty(orig_dst_pte);
> +               orig_dst_pte =3D pte_mksoft_dirty(orig_dst_pte);
>  #endif
> -       if (pte_dirty(orig_src_pte))
> -               orig_dst_pte =3D pte_mkdirty(orig_dst_pte);
> -       orig_dst_pte =3D pte_mkwrite(orig_dst_pte, dst_vma);
> +               if (pte_dirty(orig_src_pte))
> +                       orig_dst_pte =3D pte_mkdirty(orig_dst_pte);
> +               orig_dst_pte =3D pte_mkwrite(orig_dst_pte, dst_vma);
> +               set_pte_at(mm, dst_addr, dst_pte, orig_dst_pte);
> +
> +               src_addr +=3D PAGE_SIZE;
> +               if (src_addr =3D=3D addr_end)
> +                       break;
> +               src_pte++;
> +               dst_pte++;
>
> -       set_pte_at(mm, dst_addr, dst_pte, orig_dst_pte);
> +               folio_unlock(src_folio);
> +               src_folio =3D check_ptes_for_batched_move(src_vma, src_ad=
dr, src_pte, dst_pte);
> +               if (!src_folio)
> +                       break;
> +               orig_src_pte =3D ptep_get_and_clear(mm, src_addr, src_pte=
);
> +               dst_addr +=3D PAGE_SIZE;
> +       } while (true);
> +
> +       if (len > PAGE_SIZE) {
> +               arch_leave_lazy_mmu_mode();
> +               if (src_addr > src_start)
> +                       flush_tlb_range(src_vma, src_start, src_addr);
> +       }

Can't we just remove the `if (len > PAGE_SIZE)` check and unify the
handling for both single-page and multi-page cases?


Thanks
Barry

