Return-Path: <linux-kernel+bounces-889721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C0BC3E503
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 04:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 839724E74BB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 03:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793D42EBB90;
	Fri,  7 Nov 2025 03:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BD9x5Tg2"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BD018DB35
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 03:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762485227; cv=none; b=OwV0Olv1e9qWpC5BrAyNNUHPclQoTKmCIgMXxcP1TH+Kop1b0Ho19ROD9JjCop6zDEwpDEQCfaqVrpGHpuCWCVn7FmZqS09IomZn1uIm0sBI+mqorcItzD0o34TcLGfaTiXuTVuZOAq+WuQCzxGzHMNG/sq1CbF7SrSdwWcKymk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762485227; c=relaxed/simple;
	bh=6KHke65KTBWucZCfIWXCKo5rQo4l9FpQNFyPq6a7/os=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lJaprYpkFrPKgHEEKn6jJYaklT5W6uq/Nq+wI+3NwH1j5ZgR69Xiqggdj8qCoZF3R/vxsf0bQFMEXB52wkqkrbVbBtKdPZtNDC9dJ7Kia7SR1p/FKrz178UF/byL90dGECLyycgs06cXhVfPj8LoP8tWFAv70jRy7WzkekkS+Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BD9x5Tg2; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b710601e659so45002166b.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 19:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762485224; x=1763090024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NvrTpOGP7aMJ3ofU6Kesaybm3QUz/kuK5E5YnIxHukE=;
        b=BD9x5Tg28hrmCOBYEwpoIx6F5LhbkCXyIuqUSkeOMS2PjUSmYvtL3zvVqU1BKizQ0k
         Iqd4+FrxuYOrQZXSobK7lqkCSrSmyR9saWBW6t1YGSS1iksgWtpJZ/SAEFcS3bTGdWQn
         jKds6q9kthRzpdOxeFgzOrQWCNXQzhUp2ywpYGiW74gwasPuzkI6rCF80Y+PGEuzyOen
         4VAcyZyhrhucwUrgtTdsug0NgMwcLNa9OP7ffvZE22fQjLu4aCP6Dh5zSo4me+GYO6Pq
         goTlh5yc2yop5mQ9aq1JgrnmgaI0EzSTMD7g0SUkp1QjMhQyvK6RQGGhC6MJkjXhiPlr
         t9ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762485224; x=1763090024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NvrTpOGP7aMJ3ofU6Kesaybm3QUz/kuK5E5YnIxHukE=;
        b=lFEYGPxEb4jak8BCKZ9ElCTc3IRAWbxEQSAFibH1xBcthvogGIA/6GFGSV5uhYqpee
         NGUlqGS5XfHdAqgJ8QtKcYpMCdqY7HjMpgMLSlwM58jmcC5Tj5cl3uuBWc/H5iXnahFF
         oO9Dso5BOXjRD/RdUXqKgR5lcYan/gErJih4CIR/c1zhghj/3+r4PyryCRrOFEGUonwV
         sNuhZpd7H90rivE2/TZbPP4MiecTKXTH9OTWtGN2thPv/DjbJjO8pinI+FnQhNJccSaW
         zHRUIsVxwmKDFoZWeioSyWkMxR2GwM1tdlFO6Q/qT6mAW1fs5V0zvIahrnpASf+hyctz
         qqvA==
X-Forwarded-Encrypted: i=1; AJvYcCX0R62c1vfEs7VES6YbDazQ3c8iFHqelUYLOpwT7hCJqL7KB0QfUnUaZJypqosfPi4ncxIcCF1NDQczDwo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo+YP9eWbMd2kexsDFpDOWV5ZwCYqNhm5pdgBuHXSCLVoHzi/C
	l8R//17ZL9+jYaaAr9v3vDpBtv+a0vvpV9aQPsHWsSh47SeeFzSg8CmiLMOsUc6uJpiR3zHrbLk
	px9uXmeRVW4DenIBS+3rrKnjbSRY89mU=
X-Gm-Gg: ASbGncv9/gN/++L/yWoFUkAGJ5G8CC40GPsGc2/gJpEIeLfiCElcP8DLWtTfMwKkUNd
	F+9AnH00sAQLwp2/emNAcb6Ykj1ArKqbZdt95nVu+LjQHCpJnAR/Fl3viBGZG4ILr28MIYx2FQe
	yTU1nEajJK1nwRmO7RFIR4jjx5BBaS77xEZcX/9WzEeyCg1Z/tpqi7exkpM/phBF921BFluZ6Yv
	RbWmVSUVv3td0ycmx5t517GcJSPR4FX5YluiYfsIFINzJ13WJuWxo8RF5N6goLg1zd+8duiWoo=
X-Google-Smtp-Source: AGHT+IFvgxJuStMmVIqGXsCVlkmwIxDJudtKdUSj37nh23HRpbEzPGQyRTGMo2HV4vxKZWgtPhjnfS6zCwu87LUXriY=
X-Received: by 2002:a17:907:3fa8:b0:b72:6383:4c49 with SMTP id
 a640c23a62f3a-b72c0a6dff2mr131328766b.34.1762485224270; Thu, 06 Nov 2025
 19:13:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029-swap-table-p2-v1-0-3d43f3b6ec32@tencent.com>
 <20251029-swap-table-p2-v1-16-3d43f3b6ec32@tencent.com> <CAGsJ_4zW92dnCk6qUF9fKe+=b0dORLrBjuQC5mjq_nbTK4aT4g@mail.gmail.com>
In-Reply-To: <CAGsJ_4zW92dnCk6qUF9fKe+=b0dORLrBjuQC5mjq_nbTK4aT4g@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Fri, 7 Nov 2025 11:13:07 +0800
X-Gm-Features: AWmQ_bld9YwZqZ0D7Pb92DTAq9jlfQw-Il4i-YD5dCPjDDQ_ZS3qtNSBlgava0g
Message-ID: <CAMgjq7Dwhtt4ACmOFSqEvzSoA+Ny0D9_1yeZz9gf7bWvSjj9jA@mail.gmail.com>
Subject: Re: [PATCH 16/19] mm, swap: check swap table directly for checking cache
To: Barry Song <21cnbao@gmail.com>
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

On Fri, Nov 7, 2025 at 5:03=E2=80=AFAM Barry Song <21cnbao@gmail.com> wrote=
:
>
> On Thu, Oct 30, 2025 at 12:00=E2=80=AFAM Kairui Song <ryncsn@gmail.com> w=
rote:
> >
> > From: Kairui Song <kasong@tencent.com>
> >
> > Instead of looking at the swap map, check swap table directly to tell
> > if a swap slot is cached. Prepares for the removal of SWAP_HAS_CACHE.
> >
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > ---
> >  mm/swap.h        | 11 ++++++++---
> >  mm/swap_state.c  | 16 ++++++++++++++++
> >  mm/swapfile.c    | 55 +++++++++++++++++++++++++++++-------------------=
-------
> >  mm/userfaultfd.c | 10 +++-------
> >  4 files changed, 56 insertions(+), 36 deletions(-)
> >
> > diff --git a/mm/swap.h b/mm/swap.h
> > index 03694ffa662f..73f07bcea5f0 100644
> > --- a/mm/swap.h
> > +++ b/mm/swap.h
> > @@ -275,6 +275,7 @@ void __swapcache_clear_cached(struct swap_info_stru=
ct *si,
> >   *   swap entries in the page table, similar to locking swap cache fol=
io.
> >   * - See the comment of get_swap_device() for more complex usage.
> >   */
> > +bool swap_cache_check_folio(swp_entry_t entry);
> >  struct folio *swap_cache_get_folio(swp_entry_t entry);
> >  void *swap_cache_get_shadow(swp_entry_t entry);
> >  void swap_cache_del_folio(struct folio *folio);
> > @@ -335,8 +336,6 @@ static inline int swap_zeromap_batch(swp_entry_t en=
try, int max_nr,
> >
> >  static inline int non_swapcache_batch(swp_entry_t entry, int max_nr)
> >  {
> > -       struct swap_info_struct *si =3D __swap_entry_to_info(entry);
> > -       pgoff_t offset =3D swp_offset(entry);
> >         int i;
> >
> >         /*
> > @@ -345,8 +344,9 @@ static inline int non_swapcache_batch(swp_entry_t e=
ntry, int max_nr)
> >          * be in conflict with the folio in swap cache.
> >          */
> >         for (i =3D 0; i < max_nr; i++) {
> > -               if ((si->swap_map[offset + i] & SWAP_HAS_CACHE))
> > +               if (swap_cache_check_folio(entry))
> >                         return i;
> > +               entry.val++;
> >         }
> >
> >         return i;
> > @@ -449,6 +449,11 @@ static inline int swap_writeout(struct folio *foli=
o,
> >         return 0;
> >  }
> >
> > +static inline bool swap_cache_check_folio(swp_entry_t entry)
> > +{
> > +       return false;
> > +}
> > +
> >  static inline struct folio *swap_cache_get_folio(swp_entry_t entry)
> >  {
> >         return NULL;
> > diff --git a/mm/swap_state.c b/mm/swap_state.c
> > index 85d9f99c384f..41d4fa056203 100644
> > --- a/mm/swap_state.c
> > +++ b/mm/swap_state.c
> > @@ -103,6 +103,22 @@ struct folio *swap_cache_get_folio(swp_entry_t ent=
ry)
> >         return NULL;
> >  }
> >
> > +/**
> > + * swap_cache_check_folio - Check if a swap slot has cache.
> > + * @entry: swap entry indicating the slot.
> > + *
> > + * Context: Caller must ensure @entry is valid and protect the swap
> > + * device with reference count or locks.
> > + */
> > +bool swap_cache_check_folio(swp_entry_t entry)
> > +{
> > +       unsigned long swp_tb;
> > +
> > +       swp_tb =3D swap_table_get(__swap_entry_to_cluster(entry),
> > +                               swp_cluster_offset(entry));
> > +       return swp_tb_is_folio(swp_tb);
> > +}
> > +
>
> The name swap_cache_check_folio() sounds a bit odd to me =E2=80=94 what w=
e=E2=80=99re
> actually doing is checking whether the swapcache contains (or is)
> a folio, i.e., whether there=E2=80=99s a folio hit in the swapcache.
> The word "check" could misleadingly suggest verifying the folio=E2=80=99s=
 health
> or validity instead.
>
> what about swap_cache_has_folio() or simply:
>
> struct folio *__swap_cache_get_folio(swp_entry_t entry);

I was worrying people may misuse this, the returned folio could be
invalided anytime if caller is not holding rcu lock.

I think swap_cache_has_folio seems better indeed.

