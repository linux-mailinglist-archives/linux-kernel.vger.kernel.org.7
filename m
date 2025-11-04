Return-Path: <linux-kernel+bounces-884047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B91C2F311
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 04:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B77CA188DC5B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 03:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF5129BDBC;
	Tue,  4 Nov 2025 03:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qnambgyn"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EB8275AE4
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 03:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762228069; cv=none; b=kmE4A6Ix5gWTjLdEJNp6DrFFS+GTcciGnDzLf/L2LaBZqa4NO7dbhcQ8LkHiz5s5sjcl31vnuRuY8oTupAevoOwL9Heos6VrYD6GUKm+KDGOXtq7irKB9zJycTsAKvaIApxiGg0wo49o/IAtmsKaw0zPL3ehoE8Np7tsO7/JS6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762228069; c=relaxed/simple;
	bh=3G4ivgHLnrh9nBo6zOTHiKSXg1Xy2OD15ydixZBz+60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gE7loUb+4/kKfT9y6nOCBU7756GSrFZvUlNkb1vgZVR+pLFbdRmhREQw4dA8kjecS6vVrqmgggfS8btCkobg4YeaV55ZqSYfnPcZO2EnJO3xZGdLoCnn7x4HGxMGZYkb0Gspfq1IUYylUB5gmCp9okh2hBOKvCFRZrCe2zq+C8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qnambgyn; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8a1744d9b8fso691030985a.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 19:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762228067; x=1762832867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i0pa7WeHz47MLgq+rdOSlkeWgaQxlJG3XLSzMhA+sBw=;
        b=QnambgynARn+WxCM/uBRTUdYXinaFOT4k2pLiFPO1shZFiydwBdENqNl/QvRbdRJ5v
         RafXUba//4FQA923VeJpI1YaMPVrViq0dT7/nKxpW97PvpWy1iUgjW9wbXiV2NxNjcQl
         RBTBRL+6MpHCcwQlg3vRqeBrnxK79ObXqtaYnQ8+0nmFg59DEhUQtIuqZLUeNHrKBJZa
         vJrywjC4lgWHaOKbJIRthzk2f1pSxzyJzppMp0XTuAxIiAfi6U+u/9jOpQh3Hcj2IivZ
         m5g2ZN0ybC6LOToEaOVl88Dq/VwGs4Zl6qktirJvmzS4AqBylC0MZCbpaFMnxDi8rNh8
         JIxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762228067; x=1762832867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i0pa7WeHz47MLgq+rdOSlkeWgaQxlJG3XLSzMhA+sBw=;
        b=IrEqTxlEcjEI7d9o7zzRNoyfNO8BfGdnECpqFI4N2S/yuxybDm2nqPU1U6IKSIY3j3
         gE8IPjXIVS1PLAk8UTdc4m+VUXbLqKsRZQiga1N18nsy0mayhLFRMzOv7QE/qnOpKzMP
         ec2sczwxpcEsONPgh2h2CpxdLqTMiUGn1qowbDEKuQSZogsz6avGg6JNb9yv7dWSsOXj
         ddbXmy9AQBjWNrV9rMBc7+txzmL7hahGTxKHbGCcFGJTdojw6+7N9pmJAYoD3EV3/P+N
         JLTdIWnEVxhen9MW9DtnQJB3ZE6QAgwgQHVkwp8f8pFvX0/B1hn1cATY89eOr+DwC6iB
         dZGg==
X-Forwarded-Encrypted: i=1; AJvYcCWowQsyy4bt581EARBMXVWZj1IRQTJg7rRPHxvn6vQqfOtIXtqSIsQZKd4+xJO7zUds2H4tJ0XrHxkwNWI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMx9VSWpQFvoQRL+gISZxiZc7fxIoKNPs1F7UunWqoICN88ZXA
	TJFLmQp/Z/44laEOwATZEy6lG8z1hN/eXeCAMby/Xl+MMd0n/M5M/4RpjK7DpjkZuQspgNCnqP2
	HjWElSzL30BTeNESToEMBwgFqy6UI8z8=
X-Gm-Gg: ASbGncsdHQHJ3PbFoHGBl6TNJe0CdY/6CgJEh0G1Ivz3gCWNLFnyyFVeheZOZLwnerN
	IO6pLcEEJpd1s8tZjB6tLLpIvkrivqtaimT4c7NhbfSiBxrqeOhZnPo4qhoz9GmiWOMA6bZ81xM
	qGDfmzpdXLGoesHUv8ndV8UCtx4S4i041Liq2ATkZ2jPoWHuS/edaOYwkrJB5Kw4nlCU7xIzIqV
	bJc0OQRS6FMBgfaKuKswPMUnsGz/SFctMcs5jwUbleqMWUhg5JIDskWY2PAeC1+hrGL63+6IJ9/
	gllQDKze88wzoYdE
X-Google-Smtp-Source: AGHT+IGOIVCFrSUGPZxgm5CFHiWVd9cq9GgBXRxZwbWr0M8xS7ROgHPlmVFJAjqv8pGjWXVr2hKxx8I/3dtQzmHBvdM=
X-Received: by 2002:a05:620a:448a:b0:8a4:40da:b8f9 with SMTP id
 af79cd13be357-8ab9b88036bmr1932468985a.76.1762228066783; Mon, 03 Nov 2025
 19:47:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029-swap-table-p2-v1-0-3d43f3b6ec32@tencent.com> <20251029-swap-table-p2-v1-3-3d43f3b6ec32@tencent.com>
In-Reply-To: <20251029-swap-table-p2-v1-3-3d43f3b6ec32@tencent.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 4 Nov 2025 11:47:35 +0800
X-Gm-Features: AWmQ_blJfTuoUvr32Du3u6wr18BZxK5VzePjdpb6Cvkx1_DpxqtXBlWvqOETAzM
Message-ID: <CAGsJ_4xsUwUH_VyeYaXHURqTS66Fbuxa00GTM5izwK-=Vg_20g@mail.gmail.com>
Subject: Re: [PATCH 03/19] mm, swap: never bypass the swap cache even for SWP_SYNCHRONOUS_IO
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
> Now the overhead of the swap cache is trivial, bypassing the swap
> cache is no longer a valid optimization. So unify the swapin path using
> the swap cache. This changes the swap in behavior in multiple ways:
>
> We used to rely on `SWP_SYNCHRONOUS_IO && __swap_count(entry) =3D=3D 1` a=
s
> the indicator to bypass both the swap cache and readahead. The swap
> count check is not a good indicator for readahead. It existed because
> the previously swap design made readahead strictly coupled with swap
> cache bypassing. We actually want to always bypass readahead for
> SWP_SYNCHRONOUS_IO devices even if swap count > 1, But bypassing the
> swap cache will cause redundant IO.

I suppose it=E2=80=99s not only redundant I/O, but also causes additional m=
emory
copies, as each swap-in allocates a new folio. Using swapcache allows the
folio to be shared instead?

>
> Now that limitation is gone, with the new introduced helpers and design,
> we will always swap cache, so this check can be simplified to check
> SWP_SYNCHRONOUS_IO only, effectively disabling readahead for all
> SWP_SYNCHRONOUS_IO cases, this is a huge win for many workloads.
>
> The second thing here is that this enabled a large swap for all swap
> entries on SWP_SYNCHRONOUS_IO devices. Previously, the large swap in is
> also coupled with swap cache bypassing, and so the count checking side
> effect also makes large swap in less effective. Now this is also fixed.
> We will always have a large swap in support for all SWP_SYNCHRONOUS_IO
> cases.
>

In your cover letter, you mentioned: =E2=80=9Cit=E2=80=99s especially bette=
r for workloads
with swap count > 1 on SYNC_IO devices, about ~20% gain in the above test.=
=E2=80=9D
Is this improvement mainly from mTHP swap-in?


> And to catch potential issues with large swap in, especially with page
> exclusiveness and swap cache, more debug sanity checks and comments are
> added. But overall, the code is simpler. And new helper and routines
> will be used by other components in later commits too. And now it's
> possible to rely on the swap cache layer for resolving synchronization
> issues, which will also be done by a later commit.
>
> Worth mentioning that for a large folio workload, this may cause more
> serious thrashing. This isn't a problem with this commit, but a generic
> large folio issue. For a 4K workload, this commit increases the
> performance.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/memory.c     | 136 +++++++++++++++++++++-----------------------------=
------
>  mm/swap.h       |   6 +++
>  mm/swap_state.c |  27 +++++++++++
>  3 files changed, 84 insertions(+), 85 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 4c3a7e09a159..9a43d4811781 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4613,7 +4613,15 @@ static struct folio *alloc_swap_folio(struct vm_fa=
ult *vmf)
>  }
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>
> -static DECLARE_WAIT_QUEUE_HEAD(swapcache_wq);
> +/* Sanity check that a folio is fully exclusive */
> +static void check_swap_exclusive(struct folio *folio, swp_entry_t entry,
> +                                unsigned int nr_pages)
> +{
> +       do {
> +               VM_WARN_ON_ONCE_FOLIO(__swap_count(entry) !=3D 1, folio);
> +               entry.val++;
> +       } while (--nr_pages);
> +}
>
>  /*
>   * We enter with non-exclusive mmap_lock (to exclude vma changes,
> @@ -4626,17 +4634,14 @@ static DECLARE_WAIT_QUEUE_HEAD(swapcache_wq);
>  vm_fault_t do_swap_page(struct vm_fault *vmf)
>  {
>         struct vm_area_struct *vma =3D vmf->vma;
> -       struct folio *swapcache, *folio =3D NULL;
> -       DECLARE_WAITQUEUE(wait, current);
> +       struct folio *swapcache =3D NULL, *folio;
>         struct page *page;
>         struct swap_info_struct *si =3D NULL;
>         rmap_t rmap_flags =3D RMAP_NONE;
> -       bool need_clear_cache =3D false;
>         bool exclusive =3D false;
>         swp_entry_t entry;
>         pte_t pte;
>         vm_fault_t ret =3D 0;
> -       void *shadow =3D NULL;
>         int nr_pages;
>         unsigned long page_idx;
>         unsigned long address;
> @@ -4707,57 +4712,21 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>         folio =3D swap_cache_get_folio(entry);
>         if (folio)
>                 swap_update_readahead(folio, vma, vmf->address);
> -       swapcache =3D folio;
> -

I wonder if we should move swap_update_readahead() elsewhere. Since for
sync IO you=E2=80=99ve completely dropped readahead, why do we still need t=
o call
update_readahead()?

Thanks
Barry

