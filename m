Return-Path: <linux-kernel+bounces-798584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1FDB42024
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 987275E299B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49AAA3002B6;
	Wed,  3 Sep 2025 12:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DEwNG5zw"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC28978F58
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 12:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756904130; cv=none; b=d5lkOLE7UkX3WhYkVp7Ofwd+EKbBN6sVfnsZo5HeLQP45b80KXbGCTwAdWVVzN+YZA75PY2/qBih+8uSw+bKJ+oIBJJueil+0Xu+iquGqaHT8l0/843dpx5Ikf5otO55y5dviiLYahauY0xVJzrpkIkh8UIhULiIhFk6mqaJmCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756904130; c=relaxed/simple;
	bh=rnbuuCR+eCKI94dBWAsXT2umblHpqtHnTjA9dtC6mdk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XF3sBLoX8r9Kh52sDK0fNMbwDS44thn8p+8grzTlsPPp2PsEiJCjAQkhca7Z7tCysNCxfRzHe8zdnP4+OzEp/b+pYJoTeTKvU0hqBSpDHZXi3GWo6e3hhl5R+mUKIc9B53yxG2h5/ptu9V/0SBdsEt+ilWDpIUsfbGy35zyGnWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DEwNG5zw; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-61cd1046d42so7974351a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 05:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756904127; x=1757508927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tqa55yV4aTAm57v+SxbuLsg3N+TNVNUmjaRawpI6v5A=;
        b=DEwNG5zwMyY+deHqCZgHxobHaW62wpDrJlZrlWAizAq504PPLWyr8Z9rQfmWhC9cDl
         mJrMoTcW8kGIps54PFfexX/2sFM1Zs6py5C14lUMbFOSH8niEdaMYu8KzY+R/MUneMcL
         8Kl5RiHlq/m1DxHywsv4ZSBG1KkxBNCcQCv3jAwfaYjcPip19pKjBIhFTz86ddzE/qt8
         Rntqkt4KzrO3DRytLY6Zo8zl4b7qb9PVt7BAabtnCk9H7D3nZVqpLtWbr8aJ+DLkfp71
         Zj882rtPRLko4f1/gbCqW0BTNOcwXMXuTFj8WK5hYp54fsFwBmZI9GUf5LdDii9CmCTD
         7fQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756904127; x=1757508927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tqa55yV4aTAm57v+SxbuLsg3N+TNVNUmjaRawpI6v5A=;
        b=UDSAtilXpxGgHbvshQCWgrTMlGcIUytsn62Mupw5IsYeNsTUEC0ofcZcg8/hst1gAV
         BVJg5WuXKD9X9pRbZ2lxODe18Y7cEg3f0nqOo7jQsZ3Kvd1DcnuXiFf+S9taKmAo5wvM
         zwY/ylVJsy/OWPgEOIoxtKs+2oV25dy0c95aRuPipt2P2Hx+W8ogSa3gl+Kjx0zsuu2i
         dVdq3+q597lYDX67FI912D8VL6JYL+3pJF4aJ488J9i6SvbhyICMyToyKOxMbEgdQPZX
         1UYtJqwgt2yM3bNY1I4d63mSj8uNmvpL2/Qcsmq31Wfd9BvYQk5wbXvHh6xWD/m4IOdv
         zprQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEZZguKSAocJ/EZc5aNVUUETVek5Pi5d1+/UdZ8Jk9A1PwdXwWfUFwnTuXRhK0lfqv6zfAagdo2H9rooY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3ouzJTRbKCxu9DG7HXrSb1G3ZEoiuyjU8YsCe8vKgLpJrCxYd
	/oKKGxlvTgtsGmNzwn1krJB0cnndjymbsRkMB9S0u5CsQO+D8P+WgQo2JH2/7ewlMTq5lCZP0r2
	OhDPXG9hwTSI2U4+NtOGf7PpAK49aynZ/KhUNF4U=
X-Gm-Gg: ASbGncs8mHg5zXJ+3LvjU7nEZ/Po9l65ePl8auI711Bu4xY6NrzCaETd++PFboxeMto
	ORuTG2yysP15j5XK7VnCanAv+DJhcElZ3j2cif6P6i5a6zThKfxTsk7s7M3lIpcditnuUm6y3kd
	1MrPH/zO835PcPX+mUBzNVbX2TR8V5cNfEvGcpgGaDozDOWNe6eYExYErsYGKNmpRPkEu67r7oW
	vi5ebXTBTT6Lb+31i2Ulw==
X-Google-Smtp-Source: AGHT+IH93DlNhlDZom+cRlBgpdZ47jI+EeuVqgjSdW1pa295QyX5je3CwP+x4TvCpkpqWaBS09ok6f+z3WMHwh6D7CE=
X-Received: by 2002:a05:6402:40ce:b0:61c:7b6e:b242 with SMTP id
 4fb4d7f45d1cf-61d260cc398mr12917065a12.0.1756904126711; Wed, 03 Sep 2025
 05:55:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822192023.13477-1-ryncsn@gmail.com> <20250822192023.13477-7-ryncsn@gmail.com>
 <c492b99e-b6fb-4da8-8055-1e93c6141a12@redhat.com>
In-Reply-To: <c492b99e-b6fb-4da8-8055-1e93c6141a12@redhat.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 3 Sep 2025 20:54:50 +0800
X-Gm-Features: Ac12FXzPseeYqc65OYbpAk29ZR2hTSrQ01RR4YQVxqkNFFK3XdgC_fBKw5zTuo0
Message-ID: <CAMgjq7DAbMMmPVPqiGg_-2vghpPc9Jn8rkVNDFgq3reFx6CZtw@mail.gmail.com>
Subject: Re: [PATCH 6/9] mm, swap: use the swap table for the swap cache and
 switch API
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

On Wed, Sep 3, 2025 at 7:44=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 22.08.25 21:20, Kairui Song wrote:
> > From: Kairui Song <kasong@tencent.com>
> >
> > Introduce basic swap table infrastructures, which are now just a
> > fixed-sized flat array inside each swap cluster, with access wrappers.
> >
> > Each cluster contains a swap table of 512 entries. Each table entry is
> > an opaque atomic long. It could be in 3 types: a shadow type (XA_VALUE)=
,
> > a folio type (pointer), or NULL.
> >
> > In this first step, it only supports storing a folio or shadow, and it
> > is a drop-in replacement for the current swap cache. Convert all swap
> > cache users to use the new sets of APIs. Chris Li has been suggesting
> > using a new infrastructure for swap cache for better performance, and
> > that idea combined well with the swap table as the new backing
> > structure. Now the lock contention range is reduced to 2M clusters,
> > which is much smaller than the 64M address_space. And we can also drop
> > the multiple address_space design.
> >
> > All the internal works are done with swap_cache_get_* helpers. Swap
> > cache lookup is still lock-less like before, and the helper's contexts
> > are same with original swap cache helpers. They still require a pin
> > on the swap device to prevent the backing data from being freed.
> >
> > Swap cache updates are now protected by the swap cluster lock
> > instead of the Xarray lock. This is mostly handled internally, but new
> > __swap_cache_* helpers require the caller to lock the cluster. So, a
> > few new cluster access and locking helpers are also introduced.
> >
> > A fully cluster-based unified swap table can be implemented on top
> > of this to take care of all count tracking and synchronization work,
> > with dynamic allocation. It should reduce the memory usage while
> > making the performance even better.
> >
> > Co-developed-by: Chris Li <chrisl@kernel.org>
> > Signed-off-by: Chris Li <chrisl@kernel.org>
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > ---
>
> [...]
>
> > @@ -4504,7 +4504,7 @@ static void filemap_cachestat(struct address_spac=
e *mapping,
> >                                * invalidation, so there might not be
> >                                * a shadow in the swapcache (yet).
> >                                */
> > -                             shadow =3D get_shadow_from_swap_cache(swp=
);
> > +                             shadow =3D swap_cache_get_shadow(swp);
> >                               if (!shadow)
> >                                       goto resched;
> >                       }
>
> This looks like a cleanup that can be performed separately upfront to
> make this patch smaller.
>
> Same applies to delete_from_swap_cache->swap_cache_del_folio

I can have a patch to rename and add kernel doc / comments in swap.h
for a few helpers like this one. That will make this patch a bit
smaller.

> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 2a47cd3bb649..209580d395a1 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -3721,7 +3721,7 @@ static int __folio_split(struct folio *folio, uns=
igned int new_order,
> >       /* Prevent deferred_split_scan() touching ->_refcount */
> >       spin_lock(&ds_queue->split_queue_lock);
> >       if (folio_ref_freeze(folio, 1 + extra_pins)) {
> > -             struct address_space *swap_cache =3D NULL;
> > +             struct swap_cluster_info *swp_ci =3D NULL;
>
> I'm wondering if we could also perform this change upfront, so we can ...

This one seems not very doable on itsown since the cluster idea wasn't
used out side of swap before this patch..

>
> >               struct lruvec *lruvec;
> >               int expected_refs;
> >
> > @@ -3765,8 +3765,7 @@ static int __folio_split(struct folio *folio, uns=
igned int new_order,
> >                               goto fail;
> >                       }
> >
> > -                     swap_cache =3D swap_address_space(folio->swap);
> > -                     xa_lock(&swap_cache->i_pages);
> > +                     swp_ci =3D swap_cluster_lock_by_folio(folio);
>
> ... perform these cleanups outside of the main patch. Just a thought.
>
>
> Because this patch is rather big and touches quite some code (hard to
> review)

Thanks for the review!


>
> --
> Cheers
>
> David / dhildenb
>
>

