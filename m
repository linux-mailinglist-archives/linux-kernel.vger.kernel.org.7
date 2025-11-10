Return-Path: <linux-kernel+bounces-892489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 784CFC45323
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 08:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31D713A1E96
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 07:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073BD28B7D7;
	Mon, 10 Nov 2025 07:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKAaR1UL"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926D02E92AB
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 07:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762759311; cv=none; b=lTvkjGht9nC+QTQIqizO37YQCp6I04PN3dVMWzkWA+JgVwlk/nSzOdKjhu4ikrtgKJDdTHXzHFophGeWP+KyQteg9fZgoVJm9OCJHb/Dfoz/MJ76VLcEnolm0DGXPfthaHaX9ymR55kM0Oe++ouL9XGVvrwUrHZ2qy6GKtPy5MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762759311; c=relaxed/simple;
	bh=LbId0cs+jIXCDpuoZ7pf2teSGbpT9xXON8p4nWi/BkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f82h7QndzGuF0kb4XPXcFx+PBCso3SLotj5hMt/AiXHZVMuTznYf0xTp0m5+/4q1/FDli4LTBV0lAocXPegEeCuaR2kdHCvwCNkmZEG4dout2V/aRNho1+9O6kbz+BwQ9USM+DNoWIjbgVrrxTeWew6b6yEJN8+tIZq+MrBzYoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bKAaR1UL; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-882399d60baso13882246d6.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 23:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762759307; x=1763364107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GoBnDddgwxi54Ox4ulLdEbbKlN5YhwIYGFKDFNhc/GM=;
        b=bKAaR1ULvYl0ZcbXDHXpENiRgoD4N+4r4qjVlWNBJDViCWLLOQteJxXuAtEMdOLruj
         oPgRNgDxwHeLiZY91rLAsHRwWEacTMUR8+rqTRQi1025ulbvbz41IJVHjSZhvzHFueA7
         pqgGVYfGIEv0YpElqD8OyWVa48XWU+q7S1ziG/nrWzGrSDP71E+4LIaH+ZURW/doJbKb
         b1XNPbPNjKMUDMetRXiz75+dG7/3qIr475xV001hYjs5BmJa2QWJ95OdOIIxzmWWXN7T
         uPwxxmyQeU5ZBndwMrOcVZ+N/s+LIlkHlgL1yhzKL1J4MXxsgUPEZVfcObT8uYG9wduk
         B7tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762759307; x=1763364107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GoBnDddgwxi54Ox4ulLdEbbKlN5YhwIYGFKDFNhc/GM=;
        b=r3ch20+zfYyNSxx9yYtaKREyeRDT324aJKRc01v9g6uIojQUD3KcG5W4EEc69PsuDb
         Rt/YJ0KqJ7MYmQGNt5KPrnrdmOUjacpe/DAAYGt/7CHGeeoTj8xBZprf8QbFByS0SCwj
         3zh/nxD1IYij8ruMGzqoP9CjBtks/lkt+95/RYwsnFdz28gk3McciP7GVpE0/rayrSVg
         QUh//4wzpruepgRqvs7nYAmHHQPJpjiS1QFrM34kkgnGNxLDiXkLWfVQ3f5f9rIo5so/
         0gIjAmhJzAGEGo8JagVm4Ll8+As/64Hlwyw4lMFddhNY6E2R3NYasUf/fxeZZigNdaVX
         A5jg==
X-Forwarded-Encrypted: i=1; AJvYcCX0PLNqHD60Bk2aDhCSNd19+WrtEMFH0Fx5Am5OKxXAJIPkC7PpR/WYDYagBiduA+8sV5bQPkjWOD3BAY4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4DF3jToJ2nxuTQ7wrKc7ZG+DKp3jyJZlUhJ9QaXoPV4f+ykON
	2G2JQUbUVYIoc4YD+iut+e/zWGuit1F2d6K/BeDmlm0rW/S/LKYWMwAT7CLcDzeGPR45nlQJ++r
	74lJSFXWqTVBetj+Xueg/GorBGGDXrwk=
X-Gm-Gg: ASbGncsuLR+6GAXSRKInIXdOrb9x+/XIYxUrEc4p5yNemMM4CODnDEec/16CTlfInyc
	z4NDk4l2Gdt+vQtZ9HYYpEuogaVKYq83eCw7rMVmq8dptRMiaP5Gc6zOy5Tsc9ROCFpi+VGn1x4
	5VBZ4blI7OK/IIZymDFQO2Quxwij/nViLTGZlZNRd7TjMvNbPGX2ogBc9pnKocnTjnJ9J3tPZR0
	Lj4MD97RM9QjRdn7hZzurmgtT6yBMbeA9DkEQkaVtyC8ovuhSDkME/FQVRH6S7nitTrPU5WYS/u
	liSSV/NBHFLj7Xnb4uTiV73tDnmRlJawjZlZHw==
X-Google-Smtp-Source: AGHT+IEBdVrR3hNO6pDaxwfyknGdyA8SyCItARstRpB9gJQWXGbeUcoj8HHGmoH2ybsWzG2TRwFckQUVQYzfGCKj9wQ=
X-Received: by 2002:ad4:5947:0:b0:87c:28cc:9e69 with SMTP id
 6a1803df08f44-882386ed75emr110475186d6.55.1762759307133; Sun, 09 Nov 2025
 23:21:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029-swap-table-p2-v1-0-3d43f3b6ec32@tencent.com>
 <20251029-swap-table-p2-v1-13-3d43f3b6ec32@tencent.com> <CAGsJ_4xquj2Kbc2qu0vtY6Q+-q3sg56BgKEdPs8eHtKxLBk0gQ@mail.gmail.com>
 <CAMgjq7CDXh5OWy5BMXzNPCSuMQfODTdFPOhpCDGXrhisNfAGdg@mail.gmail.com>
In-Reply-To: <CAMgjq7CDXh5OWy5BMXzNPCSuMQfODTdFPOhpCDGXrhisNfAGdg@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 10 Nov 2025 15:21:35 +0800
X-Gm-Features: AWmQ_bkaePCXz9PxjeKLBi1CR7nTqqrSmYzt2ZcuiFZI3AOKt-kIolk1ydLq4N8
Message-ID: <CAGsJ_4yjU0NmQe0cM2xDkMYVdAWRc2Q1FUMGxpo8cVkEt5ifVQ@mail.gmail.com>
Subject: Re: [PATCH 13/19] mm, swap: remove workaround for unsynchronized swap
 map cache state
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	David Hildenbrand <david@redhat.com>, Youngjun Park <youngjun.park@lge.com>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Huang, Ying" <ying.huang@linux.alibaba.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 9, 2025 at 10:18=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> On Fri, Nov 7, 2025 at 11:07=E2=80=AFAM Barry Song <21cnbao@gmail.com> wr=
ote:
> >
> > >  struct folio *swap_cache_alloc_folio(swp_entry_t entry, gfp_t gfp_ma=
sk,
> > >                                      struct mempolicy *mpol, pgoff_t =
ilx,
> > > -                                    bool *new_page_allocated,
> > > -                                    bool skip_if_exists)
> > > +                                    bool *new_page_allocated)
> > >  {
> > >         struct swap_info_struct *si =3D __swap_entry_to_info(entry);
> > >         struct folio *folio;
> > > @@ -548,8 +542,7 @@ struct folio *swap_cache_alloc_folio(swp_entry_t =
entry, gfp_t gfp_mask,
> > >         if (!folio)
> > >                 return NULL;
> > >         /* Try add the new folio, returns existing folio or NULL on f=
ailure. */
> > > -       result =3D __swap_cache_prepare_and_add(entry, folio, gfp_mas=
k,
> > > -                                             false, skip_if_exists);
> > > +       result =3D __swap_cache_prepare_and_add(entry, folio, gfp_mas=
k, false);
> > >         if (result =3D=3D folio)
> > >                 *new_page_allocated =3D true;
> > >         else
> > > @@ -578,7 +571,7 @@ struct folio *swapin_folio(swp_entry_t entry, str=
uct folio *folio)
> > >         unsigned long nr_pages =3D folio_nr_pages(folio);
> > >
> > >         entry =3D swp_entry(swp_type(entry), round_down(offset, nr_pa=
ges));
> > > -       swapcache =3D __swap_cache_prepare_and_add(entry, folio, 0, t=
rue, false);
> > > +       swapcache =3D __swap_cache_prepare_and_add(entry, folio, 0, t=
rue);
> > >         if (swapcache =3D=3D folio)
> > >                 swap_read_folio(folio, NULL);
> > >         return swapcache;
> >
> > I wonder if we could also drop the "charged" =E2=80=94 it doesn=E2=80=
=99t seem
> > difficult to move the charging step before
> > __swap_cache_prepare_and_add(), even for swap_cache_alloc_folio()?
>
> Hi Barry, thanks for the review and suggestion.
>
> It may cause much more serious cgroup thrashing. Charge may cause
> reclaim, so races swapin will have a much larger race window and cause
> a lot of repeated folio alloc / charge.
>
> This param exists because anon / shmem does their own charge for large
> folio swapin, and then inserts the folio into the swap cache, which is
> causing more memory pressure already. I think ideally we want to unify
> all alloc & charging for swap in folio allocation, and have a
> swap_cache_alloc_folio that supports `orders`. For raced swapin only
> one will insert a folio successfully into the swap cache and charge
> it, which should make the race window very tiny or maybe avoid
> redundant folio allocation completely with further work. I did some
> tests and it shows that it will improve the memory usage and avoid
> some OOM under pressure for (m)THP.

This is quite interesting. I wonder if the change below could help reduce
mTHP swap thrashing. The fallback order-0 path also changes after
swap_cache_add_folio(), as order-0 pages are typically the ones triggering
memcg reclamation.

diff --git a/mm/memory.c b/mm/memory.c
index 27d91ae3648a..d97f1a8a5ca3 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4470,11 +4470,13 @@ static struct folio *__alloc_swap_folio(struct
vm_fault *vmf)
                return NULL;

        entry =3D pte_to_swp_entry(vmf->orig_pte);
+#if 0
        if (mem_cgroup_swapin_charge_folio(folio, vma->vm_mm,
                                           GFP_KERNEL, entry)) {
                folio_put(folio);
                return NULL;
        }
+#endif

        return folio;
 }
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 2bf72d58f6ee..9d0b55deacc6 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -605,7 +605,7 @@ struct folio *swapin_folio(swp_entry_t entry,
struct folio *folio)
        unsigned long nr_pages =3D folio_nr_pages(folio);

        entry =3D swp_entry(swp_type(entry), round_down(offset, nr_pages));
-       swapcache =3D __swap_cache_prepare_and_add(entry, folio, 0, true);
+       swapcache =3D __swap_cache_prepare_and_add(entry, folio, 0,
folio_order(folio));
        if (swapcache =3D=3D folio)
                swap_read_folio(folio, NULL);
        return swapcache;

>
> BTW with current SWAP_HAS_CACHE design, we also have redundant folio
> alloc for order 0 when under global pressure, as folio alloc is done
> before setting SWAP_HAS_CACHE.  But having SWAP_HAS_CACHE set then do
> the folio alloc will increase the chance of hitting the idle/busy loop
> on SWAP_HAS_CACHE which is also kind of problematic. We should be able
> to clean it up in later phases.

Thanks
Barry

