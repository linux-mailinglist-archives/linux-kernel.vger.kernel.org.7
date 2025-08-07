Return-Path: <linux-kernel+bounces-759398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5A5B1DD02
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 20:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA3C57B36BC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 18:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AB8272E6B;
	Thu,  7 Aug 2025 18:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JYWnB1dJ"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F8035959
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 18:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754591208; cv=none; b=QmyiOilplxc0XVYWpXT+il7U8KhHYIQ9mz+wY0lbQDiyML48BniEbw64drkmt4nG+Li4AxbniOtY0xsvtuK0iv7qDe0vAWcbhT2X8/9iNkLc/kCGAooxCk8xpQ4WO1/RZColp8kf51tDDHYGYQrUzhYqIsV2kHCOuldGLgfL9UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754591208; c=relaxed/simple;
	bh=G5l1joTK2yvdpnZmYURhx7NKeb7JBYOZzKSZ9LsBXD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ay9HqYh+sPV2BYzUS8jUxoDdoGJHYtC5uC8FyMo3FI2Wm9JBkm64Wf0Jt38YtrXQxi9nZ7930xPVzVWGC7Vn1Jb1R1WSwlpOqCkECHyxppZh4DKoJAr/JjikJ3hsWudVcznCpnVpSP80J41cRXddmQXFpg0SEF7IMLNAac+2h8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JYWnB1dJ; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3e5268129b7so10588635ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 11:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754591206; x=1755196006; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ScqXmRSb91i/fJ0OdvWuOeCIHyAxHTNz1Za1Q6VYOq8=;
        b=JYWnB1dJfXN+budh6IxaOjvLkcC75S3sbZM5ADG/T1CgvjsPtf7sFD6D5s/Pg/BCPj
         QuXZuGkUCdTO2yC+9dmGjW5H5zMCLmY0MLFdHmhCccNFn5IciGFIJifRt+Y9cyec7cZ2
         CaZSFCRCqmZ0fc4Rw7oXCaHIEt/ujBRmQspnoH2MQ21LagdKbTPAhkv1f/ADM5lqNq5H
         bYEA7PWIy93qN/wWHprt56OfFETSdWJXQODjQyMG53ZMdb0LcmxUUyFDs5KDy4Skj5mX
         4DdnOUSC/HQTOsMfAmlqFr/y0/DDuYFyWWwV4C+du7eW1qUX36BCv2dwAlepRZGW43tA
         vYgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754591206; x=1755196006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ScqXmRSb91i/fJ0OdvWuOeCIHyAxHTNz1Za1Q6VYOq8=;
        b=D+aPeL2HSkFsD1ezwrZtpD6mu7957wLGHC0h+q3Z9UIJgrC1eGQz2e8XRQSVm8JO4c
         GUcv2RNVIG4dI0cvsiVmZId5wGJd+NoTCWeN8qs92Yy4Dij7hzsLfMVK0MElMCTz1Xtx
         JfkmxOXEgl+yI+HafisrBrJUGJxp2EpiL2U8JiS8bBn9nNrNyCcDn4KjDkmzHPuAdpH/
         hkCLp8JcLob38iAz/cuyAGijo23WTOI5svUmIxfV/kg5/rZOcyefUFHRhpYehgAzwPtd
         dkXCPV3AyOvFNWU3Bz5vH+59SNgjZIyDl94xJVn7LvtTtNqOpah0NqZCN6maVnVnVC+D
         u/xQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTFRzT6gGtqpEWiyg7K+4vWxcIl+pQcqdhszpA1B7IqaCw0tmyVz8uhok6/k2oEAOzQt7K/mM3rK6eYQU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yypmr4FisD1o9zV/4AEvyWcIb5O4I2eSFMQ3p5aF6HixRjMZbYq
	pmUPklyXm6inJT6VHrtY+kUjSlP19BwgaI04UPYQddvB5sSsQKmKsPZhvACbTzJk33m9hgoSCY0
	w1QL/2DH8PlCiLuH08uxZV90jUng+teg=
X-Gm-Gg: ASbGncutQ/fTRD7ZzMPr6xojDuTi5SzOIzW5QoErVugqXI/DC+rF+tvL5oxrV04xo/C
	eZgjtHITBBT1q9gS4kil3JFLX7ng662FsvUlkcCBz5NnDACAk/SU3RNCai29zwPkXnyxI8DrGUp
	wqcurhPSsfSE7kI6zucaCVilDYR2J/w+6Nc9VAI/mRR5yGOFhgrRpZDi5g7ktaanPkhol91Cxv+
	cvukYtb6tWjYBMipw==
X-Google-Smtp-Source: AGHT+IGPT9yhU7B5nv/bo0l1oDGLpiii8QisPFuMqAz2CYCZji2txYrtMUdiLQneKqmJmqdwo+eI/34ZFlubQ7WOyWQ=
X-Received: by 2002:a05:6e02:1a23:b0:3e3:d52b:dc56 with SMTP id
 e9e14a558f8ab-3e5330b5235mr2361575ab.6.1754591205735; Thu, 07 Aug 2025
 11:26:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806161748.76651-1-ryncsn@gmail.com> <20250806161748.76651-2-ryncsn@gmail.com>
 <CAF8kJuNSvQTxEOiWZRwwB4117713Ks51AvD0gbMhuA7KUhtARA@mail.gmail.com>
In-Reply-To: <CAF8kJuNSvQTxEOiWZRwwB4117713Ks51AvD0gbMhuA7KUhtARA@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Fri, 8 Aug 2025 02:26:06 +0800
X-Gm-Features: Ac12FXwYXOUkcg6XwG8WOJeG5t9LxnRCQDsRrNtU2l__zfw6bkfKif65MAjMmLE
Message-ID: <CAMgjq7CAGSjocez9C+Vs9r4-hUyaPFVTa55E9WFVi9qB=x0hqQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] mm, swap: only scan one cluster in fragment list
To: Chris Li <chrisl@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	"Huang, Ying" <ying.huang@linux.alibaba.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 1:32=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote:
>
> Acked-by: Chris Li <chrisl@kernel.org>
>
> Chris
>
> On Wed, Aug 6, 2025 at 9:18=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wro=
te:
> >
> > From: Kairui Song <kasong@tencent.com>
> >
> > Fragment clusters were mostly failing high order allocation already.
> > The reason we scan it through now is that a swap slot may get freed
> > without releasing the swap cache, so a swap map entry will end up in
> > HAS_CACHE only status, and the cluster won't be moved back to non-full
> > or free cluster list. This may cause a higher allocation failure rate.
> >
> > Usually only !SWP_SYNCHRONOUS_IO devices may have a large number of
> > slots stuck in HAS_CACHE only status. Because when a !SWP_SYNCHRONOUS_I=
O
> > device's usage is low (!vm_swap_full()), it will try to lazy free
> > the swap cache.
> >
> > But this fragment list scan out is a bit overkill. Fragmentation
> > is only an issue for the allocator when the device is getting full,
> > and by that time, swap will be releasing the swap cache aggressively
> > already. Only scan one fragment cluster at a time is good enough to
>
> Only *scanning* one fragment cluster...

Thanks.

Hi, Andrew, can help update this word in the commit message?

>
> > reclaim already pinned slots, and move the cluster back to nonfull.
> >
> > And besides, only high order allocation requires iterating over the
> > list, order 0 allocation will succeed on the first attempt. And
> > high order allocation failure isn't a serious problem.
> >
> > So the iteration of fragment clusters is trivial, but it will slow down
> > large allocation by a lot when the fragment cluster list is long.
> > So it's better to drop this fragment cluster iteration design.
>
> One side note is that we make some trade off here. We trade lower
> success rates >4K swap entry allocation on fragment lists with overall
> faster swap entry time, because we stop searching the fragment list
> early.
>
> I notice this patch will suffer from fragment list trap behavior. The
> clusters go from free -> non full -> fragment -> free again (ignore
> the full list for now). Only when the cluster is completely free
> again, it will reset the cluster back to the free list. Otherwise
> given random swap entry access pattern, and long life cycle of some
> swap entry.  Free clusters are very hard to come by. Once it is in the
> fragment list, it is not easy to move back to a non full list. The
> cluster will eventually gravitate towards the fragment list and trap
> there. This kind of problem is not easy to expose by the kernel
> compile work load, which is a batch job in nature, with very few long
> running processes. If most of the clusters in the swapfile are in the
> fragment list. This will cause us to give up too early and force the
> more expensive swap cache reclaim path more often.
>
> To counter that fragmentation list trap effect,  one idea is that not
> all clusters in the fragment list are equal. If we make the fragment
> list into a few buckets by how empty it is. e.g. >50% vs <50%. I
> expect the <50% free cluster has a very low success rate for order >0
> allocation. Given an order "o", we can have a math formula P(o, count)
> of the success rate if slots are even randomly distributed with count
> slots used. The >50% free cluster will likely have a much higher
> success rate.  We should set a different search termination threshold
> for different bucket classes. That way we can give the cluster a
> chance to move up or down the bucket class. We should try the high
> free bucket before the low free bucket.
>
> That can combat the fragmentation list trap behavior.

That's a very good point!

I'm also thinking about after we remove HAS_CACHE, maybe we can
improve the lazy free policy or scanning design making use of the
better defined swap allocation / freeing workflows.

Just a random idea for now, I'll keep your suggestion in mind.


> BTW, we can have some simple bucket statistics to see what is the
> distribution of fragmented clusters. The bucket class threshold can
> dynamically adjust using the overall fullness of the swapfile.
>
> Chris
>
> >
> > Test on a 48c96t system, build linux kernel using 10G ZRAM, make -j48,
> > defconfig with 768M cgroup memory limit, on top of tmpfs, 4K folio
> > only:
> >
> > Before: sys time: 4432.56s
> > After:  sys time: 4430.18s
> >
> > Change to make -j96, 2G memory limit, 64kB mTHP enabled, and 10G ZRAM:
> >
> > Before: sys time: 11609.69s  64kB/swpout: 1787051  64kB/swpout_fallback=
: 20917
> > After:  sys time: 5572.85s   64kB/swpout: 1797612  64kB/swpout_fallback=
: 19254
> >
> > Change to 8G ZRAM:
> >
> > Before: sys time: 21524.35s  64kB/swpout: 1687142  64kB/swpout_fallback=
: 128496
> > After:  sys time: 6278.45s   64kB/swpout: 1679127  64kB/swpout_fallback=
: 130942
> >
> > Change to use 10G brd device with SWP_SYNCHRONOUS_IO flag removed:
> >
> > Before: sys time: 7393.50s  64kB/swpout:1788246  swpout_fallback: 0
> > After:  sys time: 7399.88s  64kB/swpout:1784257  swpout_fallback: 0
> >
> > Change to use 8G brd device with SWP_SYNCHRONOUS_IO flag removed:
> >
> > Before: sys time: 26292.26s 64kB/swpout:1645236  swpout_fallback: 13894=
5
> > After:  sys time: 9463.16s  64kB/swpout:1581376  swpout_fallback: 25997=
9
> >
> > The performance is a lot better for large folios, and the large order
> > allocation failure rate is only very slightly higher or unchanged even
> > for !SWP_SYNCHRONOUS_IO devices high pressure.
> >
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > Acked-by: Nhat Pham <nphamcs@gmail.com>
> > ---
> >  mm/swapfile.c | 23 ++++++++---------------
> >  1 file changed, 8 insertions(+), 15 deletions(-)
> >
> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > index b4f3cc712580..1f1110e37f68 100644
> > --- a/mm/swapfile.c
> > +++ b/mm/swapfile.c
> > @@ -926,32 +926,25 @@ static unsigned long cluster_alloc_swap_entry(str=
uct swap_info_struct *si, int o
> >                 swap_reclaim_full_clusters(si, false);
> >
> >         if (order < PMD_ORDER) {
> > -               unsigned int frags =3D 0, frags_existing;
> > -
> >                 while ((ci =3D isolate_lock_cluster(si, &si->nonfull_cl=
usters[order]))) {
> >                         found =3D alloc_swap_scan_cluster(si, ci, clust=
er_offset(si, ci),
> >                                                         order, usage);
> >                         if (found)
> >                                 goto done;
> > -                       /* Clusters failed to allocate are moved to fra=
g_clusters */
> > -                       frags++;
> >                 }
> >
> > -               frags_existing =3D atomic_long_read(&si->frag_cluster_n=
r[order]);
> > -               while (frags < frags_existing &&
> > -                      (ci =3D isolate_lock_cluster(si, &si->frag_clust=
ers[order]))) {
> > -                       atomic_long_dec(&si->frag_cluster_nr[order]);
> > -                       /*
> > -                        * Rotate the frag list to iterate, they were a=
ll
> > -                        * failing high order allocation or moved here =
due to
> > -                        * per-CPU usage, but they could contain newly =
released
> > -                        * reclaimable (eg. lazy-freed swap cache) slot=
s.
> > -                        */
> > +               /*
> > +                * Scan only one fragment cluster is good enough. Order=
 0
> > +                * allocation will surely success, and large allocation
> > +                * failure is not critical. Scanning one cluster still
> > +                * keeps the list rotated and reclaimed (for HAS_CACHE)=
.
> > +                */
> > +               ci =3D isolate_lock_cluster(si, &si->frag_clusters[orde=
r]);
> > +               if (ci) {
> >                         found =3D alloc_swap_scan_cluster(si, ci, clust=
er_offset(si, ci),
> >                                                         order, usage);
> >                         if (found)
> >                                 goto done;
> > -                       frags++;
> >                 }
> >         }
> >
> > --
> > 2.50.1
> >
> >
>

