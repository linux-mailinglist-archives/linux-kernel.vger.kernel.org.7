Return-Path: <linux-kernel+bounces-797021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F26E5B40ACF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 18:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB412207599
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574B733A005;
	Tue,  2 Sep 2025 16:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MIcwXU8R"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9702DCF70
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 16:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756831172; cv=none; b=f9AthVITPgwQnxxHvBnhGf3VlDAtgwGscJ3PnRQ+jkDbENBZm2h1Z8wbRv0pN2J1vLWDCaQXHjmUkLAh64OkVJ1yjCgA02dUN8P28vUh0FMIyvVpHcHwsjdYxdBnvNh8N+o9W+rlDzBH8MYxFIx2NTzgxPYZiWYHIJbZ73jRKEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756831172; c=relaxed/simple;
	bh=V2RT9c+Qh2Ovmwrfm8ch57L+ljt3Lulyp2wInlnTI58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MKoqGauk2F3TY4lV6UEW+pFnUr6aYHLC5FNQFdpkFV5e/ZQVEJXYdcDCaPclOzV4yQ0KAtJPhOr7mQe8QI3Ot73OEMtFojCqpNc/jjRAcM+WP6VNmexHonJ1i4U0pT4oY98GQMf/W3Mo4FbFD2hky3HPz4Gr0OEsMo4mzyhQLNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MIcwXU8R; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b04163fe08dso447743766b.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 09:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756831169; x=1757435969; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KULDNgiYHmmPCuUqyY0RJ/0WhWSbFCxPKKLg6IajuDI=;
        b=MIcwXU8ROFoye8NieNTUGGciqc6FkOMheUWyhBTwQvdwrwaQgZ6yq83ZNr7VXzLQL5
         pwOqMrV8YyaibVOeN565g4vk8wH7ty9zk9zWAJTQnsbfvnIHXfJUpsRk+q9ePIB5UTkk
         nE8M1Zch7XfsjT9NdRLUiM57VZmjRBCEqOUusTsnn70uh1Sh7ker9NpujEboDUgXuzvk
         CcePyJ6nweBTt6oGYJGzyjY0Nnl6Mh42LYWVnG98a/Y36tVRmMyGMcVZsd16YeWme+gq
         u7eOZlVtUaFxGrcIH5ePTv/Ej8gIm2fRXodYbEDW5uz9NIRZFrd95e9bjVOf+J7yQORF
         9IPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756831169; x=1757435969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KULDNgiYHmmPCuUqyY0RJ/0WhWSbFCxPKKLg6IajuDI=;
        b=lDpdJemnadyQ1Lhi0XUaQFZvxiSRaXXx5kHCXGnEbU85qvBOP8VXvtRPGJWs0QDT8k
         DloGIjf3+3JZjVOCOFWSoKFc1piiFAW/6aLBWXReVKY8T2FEc/g7cascAv8x36TjPs6Y
         YjxgTj2ep53h86zO5GZTMFwFROHCn13Km3mXQXTfzNT0uqRlcy5o+fcPS8oNDVunpKA1
         7ahFNlcUWek2WISLSgi+CmWNqu3RpoV3fv17rz0P+RgWc1wL8f7y6tf6wwN4I9/6/5JQ
         2QRoHt3VB2KX/so9ryqpYlVF0tjnmHx4G+6dPa0rgHJnrG7j2fFe9PyPxGL3iYNZjN5D
         BmDA==
X-Forwarded-Encrypted: i=1; AJvYcCXZX9SrrF3UgVdpl6NbyyEcM5oohULo1jMTR0E9az0J5WAnOX4BqVaWoYvxF9MtrOwlr5xn3a5G1j3zZV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX7oBJm/Q+TlmehlTtHsqIFiZH0vw237TACFwfbdoavGCbhxdr
	vhIs0fm+glQp5gJQRHEZozAKrlg+xttTEwcmFRD/hd1Orxs7TdSFSKmnYyWuXBx370vPhIEE0kp
	jsIyNytXWeJvbZOeaUEf1Z5uhas5tUko=
X-Gm-Gg: ASbGnct+uxNB2wNUXZFgr+6EDQBUwQNw3LJLu8iM2yx6RLjPcnsQBQjW/0PvEBB8IlF
	i9sPxWkpG23+SeYu6knfNStyuncLd3HjYH+ojmIK2iMrSrFqW+h5558xGzUtqkRCMOzqRVmgw1b
	4YVOU9+73VPDjdrofuXHNrtXjMairIA3bfi48ZL4osh5RFG8aidm8YKsgO2XOUOOvLAKrAVAk1w
	DVJygJI6i8=
X-Google-Smtp-Source: AGHT+IFRf7sPflJDkEdO/QSYtWCkjAgoR/6FK9Cto6Nj1y7bD9WdS6dLt7SGBpbWPpBvR6Vc9rlOJOqThfz0PWW7O/0=
X-Received: by 2002:a17:907:94d6:b0:afe:d590:b6af with SMTP id
 a640c23a62f3a-b01d8a8b60bmr1159614066b.20.1756831168587; Tue, 02 Sep 2025
 09:39:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822192023.13477-1-ryncsn@gmail.com> <20250822192023.13477-2-ryncsn@gmail.com>
 <c4a729b8-be9e-4005-aab6-91723fcf0080@redhat.com>
In-Reply-To: <c4a729b8-be9e-4005-aab6-91723fcf0080@redhat.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 3 Sep 2025 00:38:52 +0800
X-Gm-Features: Ac12FXwuchJT2yLVFLgtl3lm-EW28Pq9-K675kfkDbUYK12I5RGhC7MPXRDFURI
Message-ID: <CAMgjq7D9uO58213Shb5sHx=ebvUdvO1mOnaVdb=dOY2Zr1QoEg@mail.gmail.com>
Subject: Re: [PATCH 1/9] mm, swap: use unified helper for swap cache look up
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>, 
	Barry Song <baohua@kernel.org>, Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Yosry Ahmed <yosryahmed@google.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Zi Yan <ziy@nvidia.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 7:22=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 22.08.25 21:20, Kairui Song wrote:
> > From: Kairui Song <kasong@tencent.com>
> >
> > Always use swap_cache_get_folio for swap cache folio look up. The reaso=
n
> > we are not using it in all places is that it also updates the readahead
> > info, and some callsites want to avoid that.
> >
> > So decouple readahead update with swap cache lookup into a standalone
> > helper, let the caller call the readahead update helper if that's
> > needed. And convert all swap cache lookups to use swap_cache_get_folio.
> >
> > After this commit, there are only three special cases for accessing swa=
p
> > cache space now: huge memory splitting, migration and shmem replacing,
> > because they need to lock the Xarray. Following commits will wrap their
> > accesses to the swap cache too with special helpers.
> >
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > ---
> >   mm/memory.c      |  6 ++-
> >   mm/mincore.c     |  3 +-
> >   mm/shmem.c       |  4 +-
> >   mm/swap.h        | 13 +++++--
> >   mm/swap_state.c  | 99 +++++++++++++++++++++++------------------------=
-
> >   mm/swapfile.c    | 11 +++---
> >   mm/userfaultfd.c |  5 +--
> >   7 files changed, 72 insertions(+), 69 deletions(-)
> >
> > diff --git a/mm/memory.c b/mm/memory.c
> > index d9de6c056179..10ef528a5f44 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -4660,9 +4660,11 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >       if (unlikely(!si))
> >               goto out;
> >
> > -     folio =3D swap_cache_get_folio(entry, vma, vmf->address);
> > -     if (folio)
> > +     folio =3D swap_cache_get_folio(entry);
> > +     if (folio) {
> > +             swap_update_readahead(folio, vma, vmf->address);
> >               page =3D folio_file_page(folio, swp_offset(entry));
> > +     }
> >       swapcache =3D folio;
> >
> >       if (!folio) {
> > diff --git a/mm/mincore.c b/mm/mincore.c
> > index 2f3e1816a30d..8ec4719370e1 100644
> > --- a/mm/mincore.c
> > +++ b/mm/mincore.c
> > @@ -76,8 +76,7 @@ static unsigned char mincore_swap(swp_entry_t entry, =
bool shmem)
> >               if (!si)
> >                       return 0;
> >       }
> > -     folio =3D filemap_get_entry(swap_address_space(entry),
> > -                               swap_cache_index(entry));
> > +     folio =3D swap_cache_get_folio(entry);
> >       if (shmem)
> >               put_swap_device(si);
> >       /* The swap cache space contains either folio, shadow or NULL */
> > diff --git a/mm/shmem.c b/mm/shmem.c
> > index 13cc51df3893..e9d0d2784cd5 100644
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -2354,7 +2354,7 @@ static int shmem_swapin_folio(struct inode *inode=
, pgoff_t index,
> >       }
> >
> >       /* Look it up and read it in.. */
> > -     folio =3D swap_cache_get_folio(swap, NULL, 0);
> > +     folio =3D swap_cache_get_folio(swap);
> >       if (!folio) {
> >               if (data_race(si->flags & SWP_SYNCHRONOUS_IO)) {
> >                       /* Direct swapin skipping swap cache & readahead =
*/
> > @@ -2379,6 +2379,8 @@ static int shmem_swapin_folio(struct inode *inode=
, pgoff_t index,
> >                       count_vm_event(PGMAJFAULT);
> >                       count_memcg_event_mm(fault_mm, PGMAJFAULT);
> >               }
> > +     } else {
> > +             swap_update_readahead(folio, NULL, 0);
> >       }
> >
> >       if (order > folio_order(folio)) {
> > diff --git a/mm/swap.h b/mm/swap.h
> > index 1ae44d4193b1..efb6d7ff9f30 100644
> > --- a/mm/swap.h
> > +++ b/mm/swap.h
> > @@ -62,8 +62,7 @@ void delete_from_swap_cache(struct folio *folio);
> >   void clear_shadow_from_swap_cache(int type, unsigned long begin,
> >                                 unsigned long end);
> >   void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry, =
int nr);
> > -struct folio *swap_cache_get_folio(swp_entry_t entry,
> > -             struct vm_area_struct *vma, unsigned long addr);
> > +struct folio *swap_cache_get_folio(swp_entry_t entry);
> >   struct folio *read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask=
,
> >               struct vm_area_struct *vma, unsigned long addr,
> >               struct swap_iocb **plug);
> > @@ -74,6 +73,8 @@ struct folio *swap_cluster_readahead(swp_entry_t entr=
y, gfp_t flag,
> >               struct mempolicy *mpol, pgoff_t ilx);
> >   struct folio *swapin_readahead(swp_entry_t entry, gfp_t flag,
> >               struct vm_fault *vmf);
> > +void swap_update_readahead(struct folio *folio, struct vm_area_struct =
*vma,
> > +                        unsigned long addr);
> >
> >   static inline unsigned int folio_swap_flags(struct folio *folio)
> >   {
> > @@ -159,6 +160,11 @@ static inline struct folio *swapin_readahead(swp_e=
ntry_t swp, gfp_t gfp_mask,
> >       return NULL;
> >   }
> >
> > +static inline void swap_update_readahead(struct folio *folio,
> > +             struct vm_area_struct *vma, unsigned long addr)
> > +{
> > +}
> > +
> >   static inline int swap_writeout(struct folio *folio,
> >               struct swap_iocb **swap_plug)
> >   {
> > @@ -169,8 +175,7 @@ static inline void swapcache_clear(struct swap_info=
_struct *si, swp_entry_t entr
> >   {
> >   }
> >
> > -static inline struct folio *swap_cache_get_folio(swp_entry_t entry,
> > -             struct vm_area_struct *vma, unsigned long addr)
> > +static inline struct folio *swap_cache_get_folio(swp_entry_t entry)
> >   {
> >       return NULL;
> >   }
> > diff --git a/mm/swap_state.c b/mm/swap_state.c
> > index 99513b74b5d8..ff9eb761a103 100644
> > --- a/mm/swap_state.c
> > +++ b/mm/swap_state.c
> > @@ -69,6 +69,21 @@ void show_swap_cache_info(void)
> >       printk("Total swap =3D %lukB\n", K(total_swap_pages));
> >   }
> >
> > +/*
>
> While at it, proper kerneldoc?
>
> /**
>
> etc.
>
> Also documenting that it will only return a valid folio pointer or NULL

Good suggestion. I added some kerneldoc in later commit for this
function, do it earlier here is better.

>
> > + * Lookup a swap entry in the swap cache. A found folio will be return=
ed
> > + * unlocked and with its refcount incremented.
> > + *
> > + * Caller must lock the swap device or hold a reference to keep it val=
id.
> > + */
> > +struct folio *swap_cache_get_folio(swp_entry_t entry)
> > +{
> > +     struct folio *folio =3D filemap_get_folio(swap_address_space(entr=
y),
> > +                                             swap_cache_index(entry));
> > +     if (!IS_ERR(folio))
> > +             return folio;
> > +     return NULL;
>
> Maybe better as (avoid one !)
>
> if (IS_ERR(folio))
>         return NULL;
> return folio;
>
> or simply
>
> return IS_ERR(folio) ? NULL : folio.
>
> > +}
> > +
> >   void *get_shadow_from_swap_cache(swp_entry_t entry)
> >   {
> >       struct address_space *address_space =3D swap_address_space(entry)=
;
> > @@ -273,54 +288,40 @@ static inline bool swap_use_vma_readahead(void)
> >   }
> >
> >   /*
> > - * Lookup a swap entry in the swap cache. A found folio will be return=
ed
> > - * unlocked and with its refcount incremented - we rely on the kernel
> > - * lock getting page table operations atomic even if we drop the folio
> > - * lock before returning.
> > - *
> > - * Caller must lock the swap device or hold a reference to keep it val=
id.
> > + * Update the readahead statistics of a vma or globally.
> >    */
> > -struct folio *swap_cache_get_folio(swp_entry_t entry,
> > -             struct vm_area_struct *vma, unsigned long addr)
>
> This also sounds like a good kerneldoc candidate :)
>
> In particular, documenting that it is valid to pass in vma =3D=3D NULL (i=
n
> which case the addr is ignored).

Agree, I forgot this one, will add some doc.

>
> > +void swap_update_readahead(struct folio *folio,
> > +                        struct vm_area_struct *vma,
> > +                        unsigned long addr)
> >   {
>
>
> Apart from that LGTM.

Thanks!

>
> --
> Cheers
>
> David / dhildenb
>
>

