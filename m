Return-Path: <linux-kernel+bounces-884481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CCCC30488
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 10:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 083143B77BF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 09:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7EF23EA81;
	Tue,  4 Nov 2025 09:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i8ByyYt8"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB25314D03
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 09:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762247712; cv=none; b=Ds1CCamG4GuqkI33X7B/pjTy1WAxWrcuhsu/8B1bkHwiiF9N4pmbpS+Pnj7LyFsxT7PXokzJ32IcgEvcQ/D+7bI/cUzHfZwOuPQneeFrh6L1U0NDoVokVUfyVaT+Xl0wxzBFwh2wcSKXkNMOQgR2F3bGIah+6yGSbsbv9Vwxseo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762247712; c=relaxed/simple;
	bh=IMrhZDRyWpuenM1LcD1s2FyOLmooxFZeCMzyRcCQGu4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TXTf2fL6Iw2aVyyrw6IiuSqb4q1bn0wERYnedcl/BO0W/+N2DJdC749lpTdqqtf0sfSdZZ/DkjGS4jaAtXwo8PGMrUHxg7Q9Lj/kQoa+pKaVwRrC5F89G1GWNYX/mr4Gw6B2GGBfAD8UsZaucdMg2rA3nVnEViYBRLVryK1i32o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i8ByyYt8; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-88025eb208bso45201586d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 01:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762247710; x=1762852510; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+7o3OoWVf3VwmhIykzAVGSS+Z6xkTROuk1L23o0STyY=;
        b=i8ByyYt8C4TUspxbheYyRltcndbEHLqKwM9rzyYNqSJR/nry8D1BmE4ziB9D1nLd8B
         OTmgS8MyGeBXJ+ZsLP4+/nqpgUamRebZUQqV/MD6W+Yu5CvZ5VC30fnbnO3cQOUMUfER
         zzFTM4Pq8+PkCHZ325DtBcGHvMK4zHmJ6iZPQcPkXm17WXN3Id2wPT/8FROipTrfQyYu
         G7VkOLv0Ki3wsJErB2+PT0MlMu1Ptdn6tql0C0Qaphlk+oZUp4MKcbYwSGBgO572m5IB
         dJw2bRcUw9SY2H6YnqFhb6WoJcew1TfeOJbJHnQiNpEZOc8xNqhydlflOewP1Z2KJ8lI
         d6Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762247710; x=1762852510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+7o3OoWVf3VwmhIykzAVGSS+Z6xkTROuk1L23o0STyY=;
        b=OIjxN0SwYzYkTeVcWQxq9Zd80RDdURrN0qnslokWIoOtNwgVTJBrqdzwnErSQgvDXY
         dF1D6yw6CZhHM7PUgASL0S1vklPXKWpc3N36x+2uUkx7NdrWjTGgnN60Bodthi3/Cw53
         4iyji4CFhNurM8Fc7BrjOdwMQW7v8Ni84qP6+yQxbX2Ouq2qD0jxdC5ucYW0kL3KzZ79
         F+zn8iRcJcGBsSnVHeqLkGmo1Nb1WXd/OT0FFEAxTDl5Wpm28h2UN6MtWW25/v5LnoId
         h2mjVgXdMZA2nea+DPqyWVlJjGTizYweJALOcTgfJh29JiP4rDFbySFbmBma7b5bUQU9
         6LYw==
X-Forwarded-Encrypted: i=1; AJvYcCVSOsv5SX8h5i1n0Ci6mLEQ0bfWY7Xm1jxCN8HuoRI+hQP9B8iMeBfH2ciTm6noH/UFV7TMkGEYZMoNMXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhmkLNBc30pYsnPyL+eF5BZqD1VOa8NTGfn+jHSSslo4g7Ym1H
	/dEPeIANUgIyzaUm6ONd16P5zsEJNeKzjPH/5zA+V2jJIuWXz4MPQC7bmlWcmIY1bPLtMxONgOP
	oFfsf9YqR4kxKWIHC+mS+cuD5xoI2vBQ=
X-Gm-Gg: ASbGnctJore1DsCOVHm5xUtWKrlAkinmFDZPodyEv75xaxvwJtsUgjebZOcSl9kuEAA
	2GZ1cYKJV8a/gbthqLa67Btv550Pex3spHTGjqd+Ryi3prWoVTlDf0Enqc05xoziitflfKBJr1b
	PiiB9Goci417TdfJwt3Q04xEB4fLVzKVyDo0YK+NZvRxtgJW60K2oLj3h0MSmhkbij3Plgw3Gwp
	0jBLkzi6xbr+7TNA99pysnOngnxLwQ/jyTMsGxO8WfqVNmJeyKgo0za4/QhqoLWX9+VnkJIzwHL
	N2K0Hf+lnLIaI1zD/Hw/ySOyb84=
X-Google-Smtp-Source: AGHT+IHdxvd6RkK9PSEXxbjF2WAu6QKHnoL49XnAdQLn9meZGPGDr1UTcOTG4ZvbS/kJNMhGKSxyiXfzIeif8M0V8so=
X-Received: by 2002:a05:6214:268d:b0:880:627c:fe12 with SMTP id
 6a1803df08f44-880627d093emr27581196d6.4.1762247709375; Tue, 04 Nov 2025
 01:15:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029-swap-table-p2-v1-0-3d43f3b6ec32@tencent.com> <20251029-swap-table-p2-v1-6-3d43f3b6ec32@tencent.com>
In-Reply-To: <20251029-swap-table-p2-v1-6-3d43f3b6ec32@tencent.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 4 Nov 2025 17:14:58 +0800
X-Gm-Features: AWmQ_blp6dnewniw6fnHSgucGMfj2_C3pvALLTtnVEZclPTP67n_dTPWemRXR3c
Message-ID: <CAGsJ_4z1gB8x7GNUL4THdC7G9ZGMqbM3UtWM2LXPoT0xcLAQ3A@mail.gmail.com>
Subject: Re: [PATCH 06/19] mm, swap: free the swap cache after folio is mapped
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	David Hildenbrand <david@redhat.com>, Youngjun Park <youngjun.park@lge.com>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Huang, Ying" <ying.huang@linux.alibaba.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-kernel@vger.kernel.org, 
	Kairui Song <kasong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 11:59=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wro=
te:
>
> From: Kairui Song <kasong@tencent.com>
>
> To prevent repeated faults of parallel swapin of the same PTE, remove
> the folio from the swap cache after the folio is mapped. So any user
> faulting from the swap PTE should see the folio in the swap cache and
> wait on it.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/memory.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 6c5cd86c4a66..589d6fc3d424 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4362,6 +4362,7 @@ static vm_fault_t remove_device_exclusive_entry(str=
uct vm_fault *vmf)
>  static inline bool should_try_to_free_swap(struct swap_info_struct *si,
>                                            struct folio *folio,
>                                            struct vm_area_struct *vma,
> +                                          unsigned int extra_refs,
>                                            unsigned int fault_flags)
>  {
>         if (!folio_test_swapcache(folio))
> @@ -4384,7 +4385,7 @@ static inline bool should_try_to_free_swap(struct s=
wap_info_struct *si,
>          * reference only in case it's likely that we'll be the exclusive=
 user.
>          */
>         return (fault_flags & FAULT_FLAG_WRITE) && !folio_test_ksm(folio)=
 &&
> -               folio_ref_count(folio) =3D=3D (1 + folio_nr_pages(folio))=
;
> +               folio_ref_count(folio) =3D=3D (extra_refs + folio_nr_page=
s(folio));
>  }
>
>  static vm_fault_t pte_marker_clear(struct vm_fault *vmf)
> @@ -4935,15 +4936,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>          */
>         arch_swap_restore(folio_swap(entry, folio), folio);
>
> -       /*
> -        * Remove the swap entry and conditionally try to free up the swa=
pcache.
> -        * We're already holding a reference on the page but haven't mapp=
ed it
> -        * yet.
> -        */
> -       swap_free_nr(entry, nr_pages);
> -       if (should_try_to_free_swap(si, folio, vma, vmf->flags))
> -               folio_free_swap(folio);
> -
>         add_mm_counter(vma->vm_mm, MM_ANONPAGES, nr_pages);
>         add_mm_counter(vma->vm_mm, MM_SWAPENTS, -nr_pages);
>         pte =3D mk_pte(page, vma->vm_page_prot);
> @@ -4997,6 +4989,15 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>         arch_do_swap_page_nr(vma->vm_mm, vma, address,
>                         pte, pte, nr_pages);
>
> +       /*
> +        * Remove the swap entry and conditionally try to free up the
> +        * swapcache. Do it after mapping so any raced page fault will
> +        * see the folio in swap cache and wait for us.

This seems like the right optimization=E2=80=94it reduces the race window w=
here we might
allocate a folio, perform the read, and then attempt to map it, only
to find after
taking the PTL that the PTE has already changed.

Although I am not entirely sure that =E2=80=9Cany raced page fault will see=
 the folio in
swapcache,=E2=80=9D it seems there could still be cases where a fault occur=
s after
folio_free_swap(), and thus can=E2=80=99t see the swapcache entry.

T1:
swap in PF, allocate and add swapcache, map PTE, delete swapcache

T2:
swap in PF before PTE is changed;
...........................................................;
check swapcache after T1 deletes swapcache -> no swapcache found.


> +        */
> +       swap_free_nr(entry, nr_pages);
> +       if (should_try_to_free_swap(si, folio, vma, nr_pages, vmf->flags)=
)
> +               folio_free_swap(folio);
> +
>         folio_unlock(folio);
>         if (unlikely(folio !=3D swapcache)) {
>                 /*
>
> --
> 2.51.1
>

Thanks
Barry

