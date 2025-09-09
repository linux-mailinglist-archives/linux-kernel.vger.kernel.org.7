Return-Path: <linux-kernel+bounces-809113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D08FBB508CD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 00:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DAE6443BFD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 22:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39C5264A90;
	Tue,  9 Sep 2025 22:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M5ojAfY+"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E5BDDC3
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 22:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757456191; cv=none; b=Z/PL9pHCO1ed/PxZFg6p53KgAdYTpH4Ri5Z/OoPPr1WFxv5um+wNgvRasTZKS4kvwbx2gqIqUxfht2pRr41sKo5ZUhgjAiCGIBftqOa23nzYVPsXTdcWj858z3JK1UlrwS1lJHNIkJzGSHZ35icPK9VLg6tvAtvW5LQYniKkGlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757456191; c=relaxed/simple;
	bh=t4wiaymRSnweULxkALpGPSnnhQaw9uKJs8ohNg2FHnY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PDHlN3IAClHRmYYoFMtYJMt1z1AVDlDLwMbQal88AxeuAe29lRWuT/W+hAwJ7hBOIj9dkwSm1u4oalp5gXQ++qddBM6+4PpA5182RcBowBG2qKgXISRoEueDAzwOjqNXTU2wcYMCmDIgPXtkEFV3YMWyDLnf1dBRffvS6F7vaWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M5ojAfY+; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4b48fc1d998so48441cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 15:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757456188; x=1758060988; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8UED7BejBHlF/77adf0K9Lgcj4lQwJd8bxj9aaOqzio=;
        b=M5ojAfY++UWSe9VFUGDkN/NJDjHkznm63BLGYOId1+gm/qb38CAj0F1UkST7wCYHQf
         EL1NvihCtksRvPL5r3eN/JsrLa/2iPO2y8PfTDOUp6icnLF+zqJGd55hXH1I7LGiBYXF
         SBC7jyZ1SWIffgyctFbgDdJW9hj7p9YXvl1ZURtvJq9JVk4NVfm3bdl++Mz8FGMG8/i+
         u/OMpDXtplpiDweCAYeptgaNXDZ2tA+9JpYhBT8hh+tokc0TFUUK7hli1Q3OX08yC6Jg
         Sl7/MDT5KmIda/nArmIvlSNeqq+pvUmO53dXKHYMftf0+kf8WOZHGBT1G4qmYw+5wjwc
         rOGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757456188; x=1758060988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8UED7BejBHlF/77adf0K9Lgcj4lQwJd8bxj9aaOqzio=;
        b=WZ7VSzegwS/+5K+BNA0aDi2pzgblSNDcchkKBsGl+sHLh9tjNU6W8V/nVXt6Wgz2i+
         9SiikcaeY9B4YIIbU2DMc3zn74TjgruHG9xXwJq4CBQ4VHfIDi2xMBMHjCSyMCNTiL96
         G7FkTrigCH1OTBVczfY5NU1J4QcSPkvWYBv0i2csO11dE3QRwfzr624SJraoV/RThD/E
         rCECB6QN26MXceCyfJyi0QiviphxWEeZzgNCqDM53n3CURGztHmH/lC+OBjyPSbbXmw+
         NUZsOKWUiZAaAOI9Hn9DLzQaK6EvJJS6VnVF8mvcegKDzQ70mt+teusldkbdHx9FaRUO
         pX1g==
X-Forwarded-Encrypted: i=1; AJvYcCWBBmnzX5pbs77st2I2+WaoJOJQn/kP35glXqN/gEkuiu2JGXywZe2YLX8ySxYhoieSHvxNiwKBbozInLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmNoCepTCCaHUJq9XFZIWyMcH0jN+HpCOMuOa2vUM5EQ6Vr2cP
	y4lNxGRmWPw9irfcujhcXIUoRwND98TqIEoQ4djddO1AxD5ccjBhVWPh091iMHc1JbSzpWycbRr
	Ui7QPEtgIJP1S4a6zTZ0ko4tAf5LyLg26MBAu1LtW
X-Gm-Gg: ASbGncvftgLRluKbXSJwqfpaK8xSeoncjtK7E47W0qAqppYZfF2FDA3z01tptiUvDEw
	NywRO8NssSuBTJ2yVu1QplFa5SIaWpJN64WGa5XUBG3YEDnc8iFfW5VL/0I+2xlor3v3+30vrjE
	Gds3DUVi7z6WBQZkXAk26hnSxwlBTnY9jAKhEBMpZebNXZmqAECBkubLdxwectMtJXVzguldY/m
	far6ALgPF9YLGGcRlPb6UW5G8bfNemJfGQxYrkkSwN6
X-Google-Smtp-Source: AGHT+IEcXgBXlv8XPNCxv6BkbMGmnKO+vkjF7bIJRkUFgM/Y8hmvK9zA4Y0Tpy1PvYPFWYUJApeFEFOuOBn4s9kvME8=
X-Received: by 2002:ac8:5fc4:0:b0:4b4:9590:e091 with SMTP id
 d75a77b69052e-4b626eb8d89mr803731cf.5.1757456187636; Tue, 09 Sep 2025
 15:16:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909190945.1030905-1-Liam.Howlett@oracle.com> <20250909190945.1030905-9-Liam.Howlett@oracle.com>
In-Reply-To: <20250909190945.1030905-9-Liam.Howlett@oracle.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 9 Sep 2025 15:16:16 -0700
X-Gm-Features: AS18NWCg20zYnHtLpwe4CYG1V6SoxxfcPtcH39dZBp2f7xr11kxNoKhH3k65OYs
Message-ID: <CAJuCfpFGo4JXQQGECFdCgNNVaQc5MDLghdmnVXEK8Zfag7KHiw@mail.gmail.com>
Subject: Re: [PATCH v1 8/9] mm/vma: Use unmap_desc in vms_clear_ptes() and exit_mmap()
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, maple-tree@lists.infradead.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	David Hildenbrand <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, Charan Teja Kalla <quic_charante@quicinc.com>, shikemeng@huaweicloud.com, 
	kasong@tencent.com, nphamcs@gmail.com, bhe@redhat.com, baohua@kernel.org, 
	chrisl@kernel.org, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 12:10=E2=80=AFPM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> vms_clear_ptes() is slightly different than other callers to
> unmap_region() and so had the unmapping open-coded.  Using the new
> structure it is now possible to special-case the struct setup instead of
> having the open-coded function.
>
> exit_mmap() also calls unmap_vmas() with many arguemnts.  Using the
> unmap_all_init() function to set the unmap descriptor for all vmas makes
> this a bit easier to read.
>
> Update to the vma test code is necessary to ensure testing continues to
> function.
>
> No functional changes intended.
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>  include/linux/mm.h               |  3 ---
>  mm/internal.h                    |  3 +++
>  mm/memory.c                      | 24 ++++++++------------
>  mm/mmap.c                        |  5 +++-
>  mm/vma.c                         | 39 ++++++++++++++++++--------------
>  mm/vma.h                         | 14 ++++++++++++
>  tools/testing/vma/vma_internal.h | 14 ++++--------
>  7 files changed, 56 insertions(+), 46 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 892fe5dbf9de0..23eb59d543390 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2450,9 +2450,6 @@ static inline void zap_vma_pages(struct vm_area_str=
uct *vma)
>         zap_page_range_single(vma, vma->vm_start,
>                               vma->vm_end - vma->vm_start, NULL);
>  }
> -void unmap_vmas(struct mmu_gather *tlb, struct ma_state *mas,
> -               struct vm_area_struct *start_vma, unsigned long start,
> -               unsigned long end, unsigned long tree_end, bool mm_wr_loc=
ked);
>
>  struct mmu_notifier_range;
>
> diff --git a/mm/internal.h b/mm/internal.h
> index d295252407fee..1239944f2830a 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -197,6 +197,9 @@ static inline void vma_close(struct vm_area_struct *v=
ma)
>         }
>  }
>
> +/* unmap_vmas is in mm/memory.c */
> +void unmap_vmas(struct mmu_gather *tlb, struct unmap_desc *unmap);
> +
>  #ifdef CONFIG_MMU
>
>  /* Flags for folio_pte_batch(). */
> diff --git a/mm/memory.c b/mm/memory.c
> index 829cd94950182..8d4d976311037 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -2084,12 +2084,7 @@ static void unmap_single_vma(struct mmu_gather *tl=
b,
>  /**
>   * unmap_vmas - unmap a range of memory covered by a list of vma's
>   * @tlb: address of the caller's struct mmu_gather
> - * @mas: the maple state
> - * @vma: the starting vma
> - * @start_addr: virtual address at which to start unmapping
> - * @end_addr: virtual address at which to end unmapping
> - * @tree_end: The maximum index to check
> - * @mm_wr_locked: lock flag
> + * @unmap: The unmap_desc
>   *
>   * Unmap all pages in the vma list.
>   *
> @@ -2102,11 +2097,9 @@ static void unmap_single_vma(struct mmu_gather *tl=
b,
>   * ensure that any thus-far unmapped pages are flushed before unmap_vmas=
()
>   * drops the lock and schedules.
>   */
> -void unmap_vmas(struct mmu_gather *tlb, struct ma_state *mas,
> -               struct vm_area_struct *vma, unsigned long start_addr,
> -               unsigned long end_addr, unsigned long tree_end,
> -               bool mm_wr_locked)
> +void unmap_vmas(struct mmu_gather *tlb, struct unmap_desc *unmap)
>  {
> +       struct vm_area_struct *vma;
>         struct mmu_notifier_range range;
>         struct zap_details details =3D {
>                 .zap_flags =3D ZAP_FLAG_DROP_MARKER | ZAP_FLAG_UNMAP,
> @@ -2114,17 +2107,18 @@ void unmap_vmas(struct mmu_gather *tlb, struct ma=
_state *mas,
>                 .even_cows =3D true,
>         };
>
> +       vma =3D unmap->first;
>         mmu_notifier_range_init(&range, MMU_NOTIFY_UNMAP, 0, vma->vm_mm,
> -                               start_addr, end_addr);
> +                               unmap->vma_min, unmap->vma_max);
>         mmu_notifier_invalidate_range_start(&range);
>         do {
> -               unsigned long start =3D start_addr;
> -               unsigned long end =3D end_addr;
> +               unsigned long start =3D unmap->vma_min;
> +               unsigned long end =3D unmap->vma_max;
>                 hugetlb_zap_begin(vma, &start, &end);
>                 unmap_single_vma(tlb, vma, start, end, &details,
> -                                mm_wr_locked);
> +                                unmap->mm_wr_locked);
>                 hugetlb_zap_end(vma, &details);
> -               vma =3D mas_find(mas, tree_end - 1);
> +               vma =3D mas_find(unmap->mas, unmap->tree_max - 1);
>         } while (vma);
>         mmu_notifier_invalidate_range_end(&range);
>  }
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 5c9bd3f20e53f..6011f62b0a294 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1280,10 +1280,12 @@ void exit_mmap(struct mm_struct *mm)
>         struct vm_area_struct *vma;
>         unsigned long nr_accounted =3D 0;
>         VMA_ITERATOR(vmi, mm, 0);
> +       struct unmap_desc unmap;
>
>         /* mm's last user has gone, and its about to be pulled down */
>         mmu_notifier_release(mm);
>
> +       unmap.mm_wr_locked =3D false;

This will be reset by unmap_all_init() anyway, right?

>         mmap_read_lock(mm);
>         arch_exit_mmap(mm);
>
> @@ -1295,11 +1297,12 @@ void exit_mmap(struct mm_struct *mm)
>                 goto destroy;
>         }
>
> +       unmap_all_init(&unmap, &vmi, vma);

Can we use a macro, something like DEFINE_UNMAP_ALL_REGIONS() instead
of unmap_all_init()?

>         flush_cache_mm(mm);
>         tlb_gather_mmu_fullmm(&tlb, mm);
>         /* update_hiwater_rss(mm) here? but nobody should be looking */
>         /* Use ULONG_MAX here to ensure all VMAs in the mm are unmapped *=
/
> -       unmap_vmas(&tlb, &vmi.mas, vma, 0, ULONG_MAX, ULONG_MAX, false);
> +       unmap_vmas(&tlb, &unmap);
>         mmap_read_unlock(mm);
>
>         /*
> diff --git a/mm/vma.c b/mm/vma.c
> index c92384975cbb2..ad64cd9795ef3 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -481,8 +481,7 @@ void unmap_region(struct unmap_desc *desc)
>
>         tlb_gather_mmu(&tlb, mm);
>         update_hiwater_rss(mm);
> -       unmap_vmas(&tlb, mas, desc->first, desc->vma_min, desc->vma_max,
> -                  desc->vma_max, desc->mm_wr_locked);
> +       unmap_vmas(&tlb, desc);
>         mas_set(mas, desc->tree_reset);
>         free_pgtables(&tlb, mas, desc->first, desc->first_pgaddr,
>                       desc->last_pgaddr, desc->tree_max,
> @@ -1213,26 +1212,32 @@ int vma_shrink(struct vma_iterator *vmi, struct v=
m_area_struct *vma,
>  static inline void vms_clear_ptes(struct vma_munmap_struct *vms,
>                     struct ma_state *mas_detach, bool mm_wr_locked)
>  {
> -       struct mmu_gather tlb;
> +       struct unmap_desc unmap =3D {
> +               .mas =3D mas_detach,
> +               .first =3D vms->vma,
> +               /* start and end may be different if there is no prev or =
next vma. */
> +               .first_pgaddr =3D vms->unmap_start,
> +               .last_pgaddr =3D vms->unmap_end,
> +               .vma_min =3D vms->start,
> +               .vma_max =3D vms->end,
> +               /*
> +                * The tree limits and reset differ from the normal case =
since it's a
> +                * side-tree
> +                */
> +               .tree_reset =3D 1,
> +               .tree_max =3D vms->vma_count,
> +               /*
> +                * We can free page tables without write-locking mmap_loc=
k because VMAs
> +                * were isolated before we downgraded mmap_lock.
> +                */
> +               .mm_wr_locked =3D mm_wr_locked,
> +       };
>
>         if (!vms->clear_ptes) /* Nothing to do */
>                 return;
>
> -       /*
> -        * We can free page tables without write-locking mmap_lock becaus=
e VMAs
> -        * were isolated before we downgraded mmap_lock.
> -        */
>         mas_set(mas_detach, 1);
> -       tlb_gather_mmu(&tlb, vms->vma->vm_mm);
> -       update_hiwater_rss(vms->vma->vm_mm);
> -       unmap_vmas(&tlb, mas_detach, vms->vma, vms->start, vms->end,
> -                  vms->vma_count, mm_wr_locked);
> -
> -       mas_set(mas_detach, 1);
> -       /* start and end may be different if there is no prev or next vma=
. */
> -       free_pgtables(&tlb, mas_detach, vms->vma, vms->unmap_start,
> -                     vms->unmap_end, vms->unmap_end, mm_wr_locked);
> -       tlb_finish_mmu(&tlb);
> +       unmap_region(&unmap);
>         vms->clear_ptes =3D false;
>  }
>
> diff --git a/mm/vma.h b/mm/vma.h
> index 4edd5d26ffcfc..8b55a0c73d097 100644
> --- a/mm/vma.h
> +++ b/mm/vma.h
> @@ -164,6 +164,20 @@ struct unmap_desc {
>         bool mm_wr_locked;            /* If the mmap write lock is held *=
/
>  };
>
> +static inline void unmap_all_init(struct unmap_desc *desc,
> +               struct vma_iterator *vmi, struct vm_area_struct *vma)
> +{
> +       desc->mas =3D &vmi->mas;
> +       desc->first =3D vma;
> +       desc->first_pgaddr =3D FIRST_USER_ADDRESS;
> +       desc->last_pgaddr =3D USER_PGTABLES_CEILING;
> +       desc->vma_min =3D 0;
> +       desc->vma_max =3D ULONG_MAX;
> +       desc->tree_max =3D ULONG_MAX;
> +       desc->tree_reset =3D vma->vm_end;
> +       desc->mm_wr_locked =3D false;
> +}
> +
>  #define UNMAP_REGION(name, _vmi, _vma, _vma_min, _vma_max, _prev, _next)=
      \
>         struct unmap_desc name =3D {                                     =
     \
>                 .mas =3D &(_vmi)->mas,                                   =
       \
> diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_int=
ernal.h
> index 823d379e1fac2..d73ad4747d40a 100644
> --- a/tools/testing/vma/vma_internal.h
> +++ b/tools/testing/vma/vma_internal.h
> @@ -884,18 +884,12 @@ static inline void update_hiwater_vm(struct mm_stru=
ct *)
>  {
>  }
>
> -static inline void unmap_vmas(struct mmu_gather *tlb, struct ma_state *m=
as,
> -                     struct vm_area_struct *vma, unsigned long start_add=
r,
> -                     unsigned long end_addr, unsigned long tree_end,
> -                     bool mm_wr_locked)
> +struct unmap_desc;
> +
> +static inline void unmap_vmas(struct mmu_gather *tlb, struct unmap_desc =
*unmap)
>  {
>         (void)tlb;
> -       (void)mas;
> -       (void)vma;
> -       (void)start_addr;
> -       (void)end_addr;
> -       (void)tree_end;
> -       (void)mm_wr_locked;
> +       (void)unmap;
>  }
>
>  static inline void free_pgtables(struct mmu_gather *tlb, struct ma_state=
 *mas,
> --
> 2.47.2
>

