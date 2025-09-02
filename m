Return-Path: <linux-kernel+bounces-796314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66596B3FEDC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 13:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24BC3201CB7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83C72FCC16;
	Tue,  2 Sep 2025 11:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFoBhU+l"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1D827A456
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 11:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756813905; cv=none; b=HT5Xy8vrstz18W58Qp1QeFjqNc9HUHwK9Z1Lc0mS99JOaNJHXLayOI5YtnIJmrktU5KbWjujNWKMgHWHiAYftb6ewVXTFdNJn0YyYhbl++s6Q+qwm9YGlrQPqkxaptUbV8bX8x0QeQn1SasixTqK8+6jI3cSpsa2G/aQLXsAUAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756813905; c=relaxed/simple;
	bh=stkzb5qZmNxd/2kejaNDGWHHRB9X+fqeYD+0GtMHhTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KbCRdUtoMYrSbK+pUKELl73DZguPt/5mHRXuP4B+oKAtRPPU9LdICFAP0KabEuvnMbpd3JUPRJKJviZd0eVBGSB4EJ0346rJKzmfOxvflRhZEj+QdF134JyJL9Y4NiE04ufVjja8YUSlkWdQM8NQZGhkz3Mqv5PtfnC8ZlARUBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AFoBhU+l; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-afcb7322da8so1029422866b.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 04:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756813901; x=1757418701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lSvS5Dw8cbSzTPFTeTjrx7vGtggJfEg2AXxdD6ZOy9M=;
        b=AFoBhU+lmC1VsPAAOtuCE9YEWnxUymQiaHntZhr7ltkulwpI7pLJaKOO/67eGzDCmq
         zJizc2w1XcJWRVJTQHUXqks1XLWC/TziaU0qUuOG0nsqlqje+mqDLupm/HUXKtJa5paK
         8bRoTOA4Qew8WKPvqapURl87FGUEpcIPN8W/296NYBWlQzsFTe5gFQfMUu0Jdmffm8/N
         mfZS+ToOeBXmUeJ1WY3rNWZYMGKOl9M2oegAsQKdrYSeq2A5x5MOMHHgKsfkstdPA88P
         gPkjL0x4EH2Y1vfiVjw5y3hkt1k+QVuHvqHNTexhLzJgbfPAFE5iZm0hmtTVESeJSayc
         B7dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756813901; x=1757418701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lSvS5Dw8cbSzTPFTeTjrx7vGtggJfEg2AXxdD6ZOy9M=;
        b=fSIwPq7B0CyOtB6c0gErpEBvJ9YgjTjJ5tSw1tG6LRlsbpaJ31F71RAQ/Qsub6DU3V
         AhB5XpfFmP1kG897TVd7RY+1DLcbkSQ5zXw78d0Jlj2oZHwqzzFtjLf98mnNo8bv/ItR
         ucyicFYXh0PAHoCJRABLvSA9yflWeqx/2D3wpsFvyd/t/JFJoWJJ0cQyBiJa/c20vWkB
         P+1fMB0T/p13L6+7AhKq9clEypfOFwixC+q7rnF62NhCDCyWYDjAZ3s/xuJOiUoZNwcm
         3t7biPoYfBs/ZJPeVrxJ9DAOEY80Lofyi425+RHsu5wTKsJRk9YKUEPsuegV7yQb6IDk
         xFcA==
X-Forwarded-Encrypted: i=1; AJvYcCUR9btv+jn6y5bCnH5bfRmBkj873DttJFAFmPKMJw+k1zMx+zNkPsxQ0UvX3Idu8imSiKjLNdVjXfssQH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMNJZaibVBuMsogUowYArKtWPxAxxwvy8eYa0S3ahi0CM89tjn
	uaZqERL3eVlAvfwmHwUkrWz9KusyxhCGtts1C6AYX1ibZGsjjTujtU7NcGacLRAxDgqJHGB4e0j
	ugTpOQECqxicNdv0vJrHuOBsjkLRiklA=
X-Gm-Gg: ASbGncvr9qFvtBY7mWAeLx+Q2s3PX9VhHmb6jz1exC2NeLWts2klc0CFXJQX84yKQbP
	JKDRu6cXBn9+JXCkEC3JznJRWWrM2Zy/NkcMYFVHYOY8ygEZpHL/zM+R/LsM+SYs6bgGutQgsQ7
	2T9bs8dL5p0/hzbzE6PTDUdzeQv3YLCEdH6EqzIPxwo0r7u9Bk1VG5lUxJgjhd7/9++9WUM2ZrN
	P+IeVA9q/Q0mi+7grCs3w==
X-Google-Smtp-Source: AGHT+IEx3B21oLYPOIdFxDMDtY3rkvLZ5XDzFg7HBKdAm9QNvZitc4dm3sU8EHJLhha4a/khNoeUbmWYmy6zPKCIeHw=
X-Received: by 2002:a17:907:7ea8:b0:b04:53cc:441c with SMTP id
 a640c23a62f3a-b0453cc4688mr191417766b.28.1756813901119; Tue, 02 Sep 2025
 04:51:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822192023.13477-1-ryncsn@gmail.com> <20250822192023.13477-7-ryncsn@gmail.com>
 <CACePvbVVz5G9mC=Od3Uhw9Dkkgz-_jMg9R5EzNxUwx0adKKPQw@mail.gmail.com>
 <CAMgjq7BjsuooaHr=6cYTzGsj1nm+xG7jzCVdEsFgxyBHwq4GXw@mail.gmail.com> <CANeU7Q=_TveYGa2OK93YCRyJRYBc7QVi1pTTfQM7vm4Qh9tNbA@mail.gmail.com>
In-Reply-To: <CANeU7Q=_TveYGa2OK93YCRyJRYBc7QVi1pTTfQM7vm4Qh9tNbA@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 2 Sep 2025 19:51:04 +0800
X-Gm-Features: Ac12FXxYKyC5qWDDx3xJPXEBEpk0d9wlxb__9hhFkPyO3auILUM2eu8faNXvPQ8
Message-ID: <CAMgjq7CWPt8Ue7AjkfwAtFEtsZx8wk3Ge4LcFHx9=ur9vUCEyA@mail.gmail.com>
Subject: Re: [PATCH 6/9] mm, swap: use the swap table for the swap cache and
 switch API
To: Chris Li <chrisl@kernel.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>, Barry Song <baohua@kernel.org>, 
	Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 31, 2025 at 9:00=E2=80=AFAM Chris Li <chrisl@kernel.org> wrote:
>
> On Sat, Aug 30, 2025 at 9:53=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wr=
ote:
> >
> > On Sat, Aug 30, 2025 at 11:43=E2=80=AFAM Chris Li <chrisl@kernel.org> w=
rote:
> > >
> > > On Fri, Aug 22, 2025 at 12:21=E2=80=AFPM Kairui Song <ryncsn@gmail.co=
m> wrote:
> > > >
> > > > From: Kairui Song <kasong@tencent.com>
> > > >
> > > > Introduce basic swap table infrastructures, which are now just a
> > > > fixed-sized flat array inside each swap cluster, with access wrappe=
rs.
> > > >
> > > > Each cluster contains a swap table of 512 entries. Each table entry=
 is
> > > > an opaque atomic long. It could be in 3 types: a shadow type (XA_VA=
LUE),
> > > > a folio type (pointer), or NULL.
> > > >
> > > > In this first step, it only supports storing a folio or shadow, and=
 it
> > > > is a drop-in replacement for the current swap cache. Convert all sw=
ap
> > > > cache users to use the new sets of APIs. Chris Li has been suggesti=
ng
> > > > using a new infrastructure for swap cache for better performance, a=
nd
> > > > that idea combined well with the swap table as the new backing
> > > > structure. Now the lock contention range is reduced to 2M clusters,
> > > > which is much smaller than the 64M address_space. And we can also d=
rop
> > > > the multiple address_space design.
> > > >
> > > > All the internal works are done with swap_cache_get_* helpers. Swap
> > > > cache lookup is still lock-less like before, and the helper's conte=
xts
> > > > are same with original swap cache helpers. They still require a pin
> > > > on the swap device to prevent the backing data from being freed.
> > > >
> > > > Swap cache updates are now protected by the swap cluster lock
> > > > instead of the Xarray lock. This is mostly handled internally, but =
new
> > > > __swap_cache_* helpers require the caller to lock the cluster. So, =
a
> > > > few new cluster access and locking helpers are also introduced.
> > > >
> > > > A fully cluster-based unified swap table can be implemented on top
> > > > of this to take care of all count tracking and synchronization work=
,
> > > > with dynamic allocation. It should reduce the memory usage while
> > > > making the performance even better.
> > > >
> > > > Co-developed-by: Chris Li <chrisl@kernel.org>
> > > > Signed-off-by: Chris Li <chrisl@kernel.org>
> > > > Signed-off-by: Kairui Song <kasong@tencent.com>
> > > > ---
> > > >  /*
> > > > - * This must be called only on folios that have
> > > > - * been verified to be in the swap cache and locked.
> > > > - * It will never put the folio into the free list,
> > > > - * the caller has a reference on the folio.
> > > > + * Replace an old folio in the swap cache with a new one. The call=
er must
> > > > + * hold the cluster lock and set the new folio's entry and flags.
> > > >   */
> > > > -void delete_from_swap_cache(struct folio *folio)
> > > > +void __swap_cache_replace_folio(struct swap_cluster_info *ci, swp_=
entry_t entry,
> > > > +                               struct folio *old, struct folio *ne=
w)
> > > > +{
> > > > +       unsigned int ci_off =3D swp_cluster_offset(entry);
> > > > +       unsigned long nr_pages =3D folio_nr_pages(new);
> > > > +       unsigned int ci_end =3D ci_off + nr_pages;
> > > > +
> > > > +       VM_WARN_ON_ONCE(entry.val !=3D new->swap.val);
> > > > +       VM_WARN_ON_ONCE(!folio_test_locked(old) || !folio_test_lock=
ed(new));
> > > > +       VM_WARN_ON_ONCE(!folio_test_swapcache(old) || !folio_test_s=
wapcache(new));
> > > > +       do {
> > > > +               WARN_ON_ONCE(swp_tb_to_folio(__swap_table_get(ci, c=
i_off)) !=3D old);
> > > > +               __swap_table_set_folio(ci, ci_off, new);
> > >
> > > I recall in my original experiment swap cache replacement patch I use=
d
> > > atomic compare exchange somewhere. It has been a while. Is there a
> > > reason to not use atomic cmpexchg() or that is in the later part of
> > > the series?
> >
> > For now all swap table modifications are protected by ci lock, extra
> > atomic / cmpxchg is not needed.
> >
> > We might be able to make use of cmpxchg in later phases. e.g. when
> > locking a folio is enough to ensure the final consistency of swap
> > count, cmpxchg can be used as a fast path to increase the swap count.
>
> You did not get what I am asking. Let me clarify.
>
> I mean even if we keep the ci lock, not change that locking
> requirement part. In the above code. Why can't we use cmpexchge to
> make sure that we only overwrite the form "old" -> "new".
> I am not saying we need to do the lockless part here.
>
> I mean in the possible sequence
> WARN_ON_ONCE(swp_tb_to_folio(__swap_table_get(ci, ci_off)) !=3D old); //
> still "old" here, not warning issued
> /// another CPU race writes "old" to "old2" because of a bug.
> __swap_table_set_folio(ci, ci_off, new); // now "new" overwrites
> "old2" without warning.
>
> Has the typical race that you check the value old, then you overwrite
> value new. But what if the old changes to "old2" before you overwrite
> it with "new"?
> You overwrite "old2" silently.
>
> I mean to catch that.
>
> Using cmpxchg will make sure we only change "old" -> "new". We can
> catch the buggy situation above by overwriting "old2" -> "new".
> Also when we find out the entry is "old2" not "old" there, is WARN_ONCE e=
nough?
>
> I also want to discuss what we should do if we did catch the "old2"
> there in the swap cache instead of "old".
> I feel that continuing with WARN_ONCE might not be good enough. It
> will make data corruption popergate.
>
> Should we roll back the new value and fail the swap cache folio set
> function to avoid the possible data corruption?
> if we found "old2", The new guy can't set the folio to the new value.
> Deal with that error. Will that avoid data corruption? Not being able
> to make forward progress is still much better than forward progress
> with data corruption.
>
> I just don't want silent overwritten values we aren't expecting.

Right, I just think-through about this. If we are super cautious
during the early phase, we can have more non-debug checks for
potential bugs.

There are currently three places modifying the swap table: replace
(huge_mm, migration, shmem) / insert (swapin / swapout) / del. I
checked the details, basically in all cases, there is no way to
rollback. Once the data is somehow corrupted, any operation could be
in the wrong direction.

So yeah, let me add some more checks.

I'll slightly adjust swap_cache_add_folio too. In this V1,
swap_cache_add_folio is designed to allow races and returns an int for
potential conflict. But , it should never fail in V1, cause there is
currently no racing caller: we still rely on the SWAP_HAS_CACHE to pin
slots before installing the swap cache. We will kill this ugly dance
very soon in phase 3. (phase 2 removes SYNC_IO swapin is an important
step). I used this version of swap_cache_add_folio from later phases,
just to make it easier later. So in V1 let's make it WARN/BUG if any
conflict folio exists and always return void, that's safer for
catching potential bugs. I'll change swap_cache_add_folio to allow the
race again in a later phase.

For other places, I think a relaxed xchg with WARN/BUG should be just fine.

Later phases can also use something like a CONFIG_DEBUG_VM_SWAP to
wrap these, after things are verified to be stable.

