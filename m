Return-Path: <linux-kernel+bounces-793062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9041B3CD83
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 18:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26A9A188E6CF
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 16:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04881274668;
	Sat, 30 Aug 2025 16:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCKZgFG2"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6523C253359
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 16:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756572800; cv=none; b=Lflrd3rdP/uWwxRWhRd3RNEhKj5eLEIPrkbcNebA/C548bJ8JizrI6QBEDCyCQLuwIZBpBRP1ObFXAXiWuPQ+0xG2wRnFJz8RnAvGB6i+nK4vbc8YitExGSq378hqd5mLQTqR9/ur7XJJTZlF1KtmrUETgEF7xD9wyoZS5oPnMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756572800; c=relaxed/simple;
	bh=CO75rKEHoy3I6kI2xHDWTdpDWSK0G5GGjBMCl01HQKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mPV/qevOboP2PjwcgweZXhXjRxgSgUVNwbeY1ysB9ZH96/bQ9JhVjvEXqUrIjMclgja0HAgsPENZo+4+ekPKihGulM3xYmaLSrrL7qUTWk49TSrWNzk4KfphUjjuE/hQMbcVlkdkFiOPu+/xgzdyaQt/M9GEStg/mAa2ZicveQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dCKZgFG2; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6188b6f501cso3462565a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 09:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756572796; x=1757177596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/3ep0bCmQiqVsV1i5AG/4ePqsJvhv+CF0yAihCPBkTA=;
        b=dCKZgFG26uDmw02JV05RtEOtaaKsteSxF2FwWjxFnF/m1pTEjQyHtJahWJI3eDOa2e
         qIdL0hzdLj8aXLU4TlBQt7gxfrslCcfc8ISLyGz13eSUW+II6f0WisACa8XxdKmbzoli
         v/BQ2JuQu0GZ9BJCSIU8XBfcUGse+Qlz+76lNvXoOCKZkgVAwee8K5wsTfm7lDVpSXKr
         M+TdN6tmoPgwbfGDWXe2PIuj2tBNHI/sjIx7EMstOG7u/zDGEs8y1xtJ77MnONDHYbVa
         prVMdrSyyySb6VYvh+5vGsSJy+/UnhkEekISK/6sTLCZDU4zBzEGgIvkhGt4bSgsk72B
         OSpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756572796; x=1757177596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/3ep0bCmQiqVsV1i5AG/4ePqsJvhv+CF0yAihCPBkTA=;
        b=lrhaPtx6cdaZedvx9ZMOSFClqTKGRIl5i6tk3zncTLHEPBytiNHRDo6btoOPOmGxy7
         HnUYjRSuGlEb7x2Bw7NdWvxVstCOwGyNjP5JnBy+FdxNvfXXdUAKmkK4f8MkHHNNUQXC
         6B2iks3IvY77TzDOnlwpLv7SpnwRa/IV+VrsOH/pEj4pU+cbx73TM5WGKf05wQB/DoMT
         b3ZonowA5VOTj6y7BtY5i+94FtxfNgk9woH2mUKdKGria1nV7O4HxKmEZP200p0x6Eg6
         psrQBL85+pSGa1+qn501xIvZHYVvA7M+tuqtUKeBCdM3u7DgfHo9nMIyjkecoU9sJQKG
         GaLg==
X-Forwarded-Encrypted: i=1; AJvYcCWm45T1XlG+a4dxblB9Nrap8Ct/BimKLrRywCKAktPi/eDq7lS1qUpv8la8mh1AwpkacmfxGF9T+wuc/K0=@vger.kernel.org
X-Gm-Message-State: AOJu0YywYWzrlssFz9OmL0VD8H+EykHeW9fkrdJqOrPr1d5NDs6JRZJN
	AUSKPzVKk2UlthECG0cIdOW3919/NGEPSKAfG4TwOJcnMxcCFXyQ4rGCa4D3Czvap2IVGV0WmJw
	T7aIc3XTy11epBLL+7YHoIvVET5NW2i4=
X-Gm-Gg: ASbGncsj/nMWrf8W/A0IfjB+v7hdv16e2oWOf6BdV7whth0X/rNeYebGcmjuYCsuo7+
	TdKwLaw5hCYR8a/I/2YNSucLEkj57ngr4hLzx25MQxVyH7mRS9W+ojzyocrvlWP9shcEMrORiwQ
	YNxrJjsmvzOXluwVkpvV+Rw5LrF8oLga3wdqnjWpAPfoXe5HNVpziiYRGgfkzMWoGQDqZdoNsjN
	LlX1KIEm5/GEUxvQQ==
X-Google-Smtp-Source: AGHT+IFdDEGaMeg7X7RmM8uQJ1o0p1N6UcwN57NiYKrqIrh1Zx4Y8B5e/LiSK1SPCLcJ9Iisv3/279yBCICL0dkSc/0=
X-Received: by 2002:a05:6402:504b:b0:61c:5264:902c with SMTP id
 4fb4d7f45d1cf-61d26c53e03mr2342187a12.23.1756572796291; Sat, 30 Aug 2025
 09:53:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822192023.13477-1-ryncsn@gmail.com> <20250822192023.13477-7-ryncsn@gmail.com>
 <CACePvbVVz5G9mC=Od3Uhw9Dkkgz-_jMg9R5EzNxUwx0adKKPQw@mail.gmail.com>
In-Reply-To: <CACePvbVVz5G9mC=Od3Uhw9Dkkgz-_jMg9R5EzNxUwx0adKKPQw@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Sun, 31 Aug 2025 00:52:39 +0800
X-Gm-Features: Ac12FXwIsQ5-CWCgMfQJCfaWrkz57jn-Epp2yA2_GbyTb-IBX7npj9twC9L3zqo
Message-ID: <CAMgjq7BjsuooaHr=6cYTzGsj1nm+xG7jzCVdEsFgxyBHwq4GXw@mail.gmail.com>
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

On Sat, Aug 30, 2025 at 11:43=E2=80=AFAM Chris Li <chrisl@kernel.org> wrote=
:
>
> On Fri, Aug 22, 2025 at 12:21=E2=80=AFPM Kairui Song <ryncsn@gmail.com> w=
rote:
> >
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
> >  /*
> > - * This must be called only on folios that have
> > - * been verified to be in the swap cache and locked.
> > - * It will never put the folio into the free list,
> > - * the caller has a reference on the folio.
> > + * Replace an old folio in the swap cache with a new one. The caller m=
ust
> > + * hold the cluster lock and set the new folio's entry and flags.
> >   */
> > -void delete_from_swap_cache(struct folio *folio)
> > +void __swap_cache_replace_folio(struct swap_cluster_info *ci, swp_entr=
y_t entry,
> > +                               struct folio *old, struct folio *new)
> > +{
> > +       unsigned int ci_off =3D swp_cluster_offset(entry);
> > +       unsigned long nr_pages =3D folio_nr_pages(new);
> > +       unsigned int ci_end =3D ci_off + nr_pages;
> > +
> > +       VM_WARN_ON_ONCE(entry.val !=3D new->swap.val);
> > +       VM_WARN_ON_ONCE(!folio_test_locked(old) || !folio_test_locked(n=
ew));
> > +       VM_WARN_ON_ONCE(!folio_test_swapcache(old) || !folio_test_swapc=
ache(new));
> > +       do {
> > +               WARN_ON_ONCE(swp_tb_to_folio(__swap_table_get(ci, ci_of=
f)) !=3D old);
> > +               __swap_table_set_folio(ci, ci_off, new);
>
> I recall in my original experiment swap cache replacement patch I used
> atomic compare exchange somewhere. It has been a while. Is there a
> reason to not use atomic cmpexchg() or that is in the later part of
> the series?

For now all swap table modifications are protected by ci lock, extra
atomic / cmpxchg is not needed.

We might be able to make use of cmpxchg in later phases. e.g. when
locking a folio is enough to ensure the final consistency of swap
count, cmpxchg can be used as a fast path to increase the swap count.

We can't do that now as the swap count is still managed by swap_map,
not swap table. And swap allocation / dup does not have a clear
definition about how they interact with folios, and range operations
all need the ci lock...  We might be able to figure out a stable way
to handle range operations too once we sort out how folios interact
with SWAP in a later phase, I tried that in the previous long series
and this part seems doable.

I'm not sure if that will benefit a lot, or will it make it more
complex for the high order swap table to be implemented. The cluster
lock is already very fine grained. We can do some experiments in the
future to verify it.

But the good thing is in either case, this is on the right path :)

> > +       } while (++ci_off < ci_end);
> > +
> > +       /*
> > +        * If the old folio is partially replaced (e.g., splitting a la=
rge
> > +        * folio, the old folio is shrunk in place, and new split sub f=
olios
> > +        * are added to cache), ensure the new folio doesn't overlap it=
.
> > +        */
> > +       if (IS_ENABLED(CONFIG_DEBUG_VM) &&
> > +           folio_order(old) !=3D folio_order(new)) {
> > +               ci_off =3D swp_cluster_offset(old->swap);
> > +               ci_end =3D ci_off + folio_nr_pages(old);
> > +               while (ci_off++ < ci_end)
> > +                       WARN_ON_ONCE(swp_tb_to_folio(__swap_table_get(c=
i, ci_off)) !=3D old);
>
> Will this cause the swap cache to replace less than full folio range
> of the swap entry in range?
> The swap cache set folio should atomically set the full range of swap
> entries. If there is some one race to set some partial range. I
> suspect it should fail and undo the particle set. I recall there are
> some bugs on xarray accidentally fixed by one of your patches related
> to that kind of atomic behavior.
>
> I want to make sure a similar bug does not happen here.
>
> It is worthwhile to double check if the atomic folio set behavior.

Right, some callers that hold the ci lock by themselves (migration /
huge_mm split) have to ensure they do the folio replacement in a
correct way by themselves.

This is the same story for Xarray. These callers just used to hold the
xa lock and manipulate the xarray directly: e.g. split generates new
folios, new sub folios have to be added to swap cache in the right
place to override the old folio. The behavior is the same before /
after this commit, I just added a sanity check here to ensure nothing
went wrong, only to make it more reliable by adding checks in the
debug build.

I checked the logic here multiple times and tested it on multiple
kernel versions that have slightly different code for huge_mm split,
all went well.

>
> Looks good to me otherwise. Just waiting for confirmation of the swap
> cache atomic set behavior.
>
> Chris

