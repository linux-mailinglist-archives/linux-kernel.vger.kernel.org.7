Return-Path: <linux-kernel+bounces-793204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F42AB3D062
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 03:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AA4D189FA79
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 01:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652B6433AC;
	Sun, 31 Aug 2025 01:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gvGY0DPJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785A51863E
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 01:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756602038; cv=none; b=WIshxrF1AS4nYoMDRQ9+Ds0nQbZ6U0uMl7b3uwUkfQCsJwoaBB4Bb0OB5kk8JL6FvnTXEy5G4kPOWMCW/jaGOGIuuyC4Dscv027VoXftfV55/wch7/UwYEebMimXRwwxWykVC3L2ur2Ivg81yd7ALj0CihyfK/IEJUl/l13Y/SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756602038; c=relaxed/simple;
	bh=6Dq0bT7P37D+tqa1bZiIjyxkQVukfOzrScOUvR18WiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iEwL1MWxr3YCBpu95M0xUjCn4eWajziq36PyRftfYKsEkMZH2cFFCoP4EPbX9sl2+YHVz38lwl2vZOcw7v0GH2qB+VU1I4O5Lw14SkkD+k8PywpGvclJV7whvrDXr1id0vlZ5WAsr//w9oguZ1KqleE24CmsiGIdDwoVRygtltI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gvGY0DPJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF3B6C4CEFA
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 01:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756602038;
	bh=6Dq0bT7P37D+tqa1bZiIjyxkQVukfOzrScOUvR18WiA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gvGY0DPJ9YDmLrKjGlcm+lTssHu/zicjqTZg/XEAsq+OICnLGfPTb0HvdFyhVKYAN
	 cdDiK9MYqe5jLzrGpqSw/PnE1NnfEpopAepFJoZOifxNuNHdQHQGV6XJJDcsyEcy4r
	 5a2RkNnMxLuA+5TryUZhvFPifTOaNCmjSWDqqP7BieT9vo8VK4BPaFlGOv13OKERQD
	 kib1PjdGUHW/zyo7QlH1g3MgiJrx4lU2dJo1nu2w3G+ubUP5aT+6Zgk66695yoIFQG
	 AkoW1KR6IfLBX3FJXor/bVT6i01ekcGyje2PExWoRutMfw36NIgKzWst6XRlewlyP5
	 mNqHbYpuAwoyA==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-55f6017004dso3006062e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 18:00:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVPcCiMaKpekckZJsDDzk6NTdI1M7Y9Bg8A5NuQlaRIe93KbHZLvg+1hMdY4Xl49MXEfxrEJnkyyV33JnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtpuZYJoQalDV8FzQL60twt1mN0IKFHKr191qUvY1XkCei6XQa
	DS8+LQBLarItEYaKsYSzxz6UkGmw77+aVTV5CgwPprtkGT1cnDCVR444JmfwIt6yo66q1boOk49
	TtVGYiHjs0eJpLpv0y7TPLcpdJKP90w==
X-Google-Smtp-Source: AGHT+IHfVsk/cqMz+InJlu9TsCkYb6uQZFU3v5twViynKiT9JHx+rS9+O2dvLbGy6pNvzXqGhJoarHXMfA3b+lX6PX8=
X-Received: by 2002:a05:651c:1118:10b0:32a:7856:7412 with SMTP id
 38308e7fff4ca-336caf7bde4mr6565661fa.27.1756602036540; Sat, 30 Aug 2025
 18:00:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822192023.13477-1-ryncsn@gmail.com> <20250822192023.13477-7-ryncsn@gmail.com>
 <CACePvbVVz5G9mC=Od3Uhw9Dkkgz-_jMg9R5EzNxUwx0adKKPQw@mail.gmail.com> <CAMgjq7BjsuooaHr=6cYTzGsj1nm+xG7jzCVdEsFgxyBHwq4GXw@mail.gmail.com>
In-Reply-To: <CAMgjq7BjsuooaHr=6cYTzGsj1nm+xG7jzCVdEsFgxyBHwq4GXw@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Sat, 30 Aug 2025 18:00:24 -0700
X-Gmail-Original-Message-ID: <CANeU7Q=_TveYGa2OK93YCRyJRYBc7QVi1pTTfQM7vm4Qh9tNbA@mail.gmail.com>
X-Gm-Features: Ac12FXxbPyEUFw3YkMkI78ZCn3kR4M-xdMMaAiaM1jBCzIl-tOsvwNN6_Nt7wt8
Message-ID: <CANeU7Q=_TveYGa2OK93YCRyJRYBc7QVi1pTTfQM7vm4Qh9tNbA@mail.gmail.com>
Subject: Re: [PATCH 6/9] mm, swap: use the swap table for the swap cache and
 switch API
To: Kairui Song <ryncsn@gmail.com>
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

On Sat, Aug 30, 2025 at 9:53=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> On Sat, Aug 30, 2025 at 11:43=E2=80=AFAM Chris Li <chrisl@kernel.org> wro=
te:
> >
> > On Fri, Aug 22, 2025 at 12:21=E2=80=AFPM Kairui Song <ryncsn@gmail.com>=
 wrote:
> > >
> > > From: Kairui Song <kasong@tencent.com>
> > >
> > > Introduce basic swap table infrastructures, which are now just a
> > > fixed-sized flat array inside each swap cluster, with access wrappers=
.
> > >
> > > Each cluster contains a swap table of 512 entries. Each table entry i=
s
> > > an opaque atomic long. It could be in 3 types: a shadow type (XA_VALU=
E),
> > > a folio type (pointer), or NULL.
> > >
> > > In this first step, it only supports storing a folio or shadow, and i=
t
> > > is a drop-in replacement for the current swap cache. Convert all swap
> > > cache users to use the new sets of APIs. Chris Li has been suggesting
> > > using a new infrastructure for swap cache for better performance, and
> > > that idea combined well with the swap table as the new backing
> > > structure. Now the lock contention range is reduced to 2M clusters,
> > > which is much smaller than the 64M address_space. And we can also dro=
p
> > > the multiple address_space design.
> > >
> > > All the internal works are done with swap_cache_get_* helpers. Swap
> > > cache lookup is still lock-less like before, and the helper's context=
s
> > > are same with original swap cache helpers. They still require a pin
> > > on the swap device to prevent the backing data from being freed.
> > >
> > > Swap cache updates are now protected by the swap cluster lock
> > > instead of the Xarray lock. This is mostly handled internally, but ne=
w
> > > __swap_cache_* helpers require the caller to lock the cluster. So, a
> > > few new cluster access and locking helpers are also introduced.
> > >
> > > A fully cluster-based unified swap table can be implemented on top
> > > of this to take care of all count tracking and synchronization work,
> > > with dynamic allocation. It should reduce the memory usage while
> > > making the performance even better.
> > >
> > > Co-developed-by: Chris Li <chrisl@kernel.org>
> > > Signed-off-by: Chris Li <chrisl@kernel.org>
> > > Signed-off-by: Kairui Song <kasong@tencent.com>
> > > ---
> > >  /*
> > > - * This must be called only on folios that have
> > > - * been verified to be in the swap cache and locked.
> > > - * It will never put the folio into the free list,
> > > - * the caller has a reference on the folio.
> > > + * Replace an old folio in the swap cache with a new one. The caller=
 must
> > > + * hold the cluster lock and set the new folio's entry and flags.
> > >   */
> > > -void delete_from_swap_cache(struct folio *folio)
> > > +void __swap_cache_replace_folio(struct swap_cluster_info *ci, swp_en=
try_t entry,
> > > +                               struct folio *old, struct folio *new)
> > > +{
> > > +       unsigned int ci_off =3D swp_cluster_offset(entry);
> > > +       unsigned long nr_pages =3D folio_nr_pages(new);
> > > +       unsigned int ci_end =3D ci_off + nr_pages;
> > > +
> > > +       VM_WARN_ON_ONCE(entry.val !=3D new->swap.val);
> > > +       VM_WARN_ON_ONCE(!folio_test_locked(old) || !folio_test_locked=
(new));
> > > +       VM_WARN_ON_ONCE(!folio_test_swapcache(old) || !folio_test_swa=
pcache(new));
> > > +       do {
> > > +               WARN_ON_ONCE(swp_tb_to_folio(__swap_table_get(ci, ci_=
off)) !=3D old);
> > > +               __swap_table_set_folio(ci, ci_off, new);
> >
> > I recall in my original experiment swap cache replacement patch I used
> > atomic compare exchange somewhere. It has been a while. Is there a
> > reason to not use atomic cmpexchg() or that is in the later part of
> > the series?
>
> For now all swap table modifications are protected by ci lock, extra
> atomic / cmpxchg is not needed.
>
> We might be able to make use of cmpxchg in later phases. e.g. when
> locking a folio is enough to ensure the final consistency of swap
> count, cmpxchg can be used as a fast path to increase the swap count.

You did not get what I am asking. Let me clarify.

I mean even if we keep the ci lock, not change that locking
requirement part. In the above code. Why can't we use cmpexchge to
make sure that we only overwrite the form "old" -> "new".
I am not saying we need to do the lockless part here.

I mean in the possible sequence
WARN_ON_ONCE(swp_tb_to_folio(__swap_table_get(ci, ci_off)) !=3D old); //
still "old" here, not warning issued
/// another CPU race writes "old" to "old2" because of a bug.
__swap_table_set_folio(ci, ci_off, new); // now "new" overwrites
"old2" without warning.

Has the typical race that you check the value old, then you overwrite
value new. But what if the old changes to "old2" before you overwrite
it with "new"?
You overwrite "old2" silently.

I mean to catch that.

Using cmpxchg will make sure we only change "old" -> "new". We can
catch the buggy situation above by overwriting "old2" -> "new".
Also when we find out the entry is "old2" not "old" there, is WARN_ONCE eno=
ugh?

I also want to discuss what we should do if we did catch the "old2"
there in the swap cache instead of "old".
I feel that continuing with WARN_ONCE might not be good enough. It
will make data corruption popergate.

Should we roll back the new value and fail the swap cache folio set
function to avoid the possible data corruption?
if we found "old2", The new guy can't set the folio to the new value.
Deal with that error. Will that avoid data corruption? Not being able
to make forward progress is still much better than forward progress
with data corruption.

I just don't want silent overwritten values we aren't expecting.

> We can't do that now as the swap count is still managed by swap_map,
> not swap table. And swap allocation / dup does not have a clear
> definition about how they interact with folios, and range operations
> all need the ci lock...  We might be able to figure out a stable way
> to handle range operations too once we sort out how folios interact
> with SWAP in a later phase, I tried that in the previous long series
> and this part seems doable.

See above I don't mean to change the locking logic here. Only assert
the previous value is old when overwritten to new.

>
> I'm not sure if that will benefit a lot, or will it make it more
> complex for the high order swap table to be implemented. The cluster
> lock is already very fine grained. We can do some experiments in the
> future to verify it.

Not asking to change lock logic. See above.

I feel that we should always use cmpxchg to assign value to the swap
table just to be paranoid. It is data corruption we are risking here.

> But the good thing is in either case, this is on the right path :)
>
> > > +       } while (++ci_off < ci_end);
> > > +
> > > +       /*
> > > +        * If the old folio is partially replaced (e.g., splitting a =
large
> > > +        * folio, the old folio is shrunk in place, and new split sub=
 folios
> > > +        * are added to cache), ensure the new folio doesn't overlap =
it.
> > > +        */
> > > +       if (IS_ENABLED(CONFIG_DEBUG_VM) &&
> > > +           folio_order(old) !=3D folio_order(new)) {
> > > +               ci_off =3D swp_cluster_offset(old->swap);
> > > +               ci_end =3D ci_off + folio_nr_pages(old);
> > > +               while (ci_off++ < ci_end)
> > > +                       WARN_ON_ONCE(swp_tb_to_folio(__swap_table_get=
(ci, ci_off)) !=3D old);
> >
> > Will this cause the swap cache to replace less than full folio range
> > of the swap entry in range?
> > The swap cache set folio should atomically set the full range of swap
> > entries. If there is some one race to set some partial range. I
> > suspect it should fail and undo the particle set. I recall there are
> > some bugs on xarray accidentally fixed by one of your patches related
> > to that kind of atomic behavior.
> >
> > I want to make sure a similar bug does not happen here.
> >
> > It is worthwhile to double check if the atomic folio set behavior.
>
> Right, some callers that hold the ci lock by themselves (migration /
> huge_mm split) have to ensure they do the folio replacement in a
> correct way by themselves.
>
> This is the same story for Xarray. These callers just used to hold the
> xa lock and manipulate the xarray directly: e.g. split generates new
> folios, new sub folios have to be added to swap cache in the right
> place to override the old folio. The behavior is the same before /
> after this commit, I just added a sanity check here to ensure nothing
> went wrong, only to make it more reliable by adding checks in the
> debug build.
>
> I checked the logic here multiple times and tested it on multiple
> kernel versions that have slightly different code for huge_mm split,
> all went well.

Thanks for the double checking.

Chris

