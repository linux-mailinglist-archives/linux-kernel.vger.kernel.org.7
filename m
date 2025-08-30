Return-Path: <linux-kernel+bounces-793084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F89AB3CDFA
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 19:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01D31205949
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 17:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F50233134;
	Sat, 30 Aug 2025 17:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W9bHNT9d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623AEAD5A
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 17:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756574252; cv=none; b=mKvD9d2H+ujSeJCM+XY6+ORgHyGwt5jPWzGQ7Ykg9FaEn9T+mqO5Vv/StdCTXkYc9W9gsAhNnP64v4/IdFJkgFWIQm4fFn7y30hFGh4pDz9hAcdJCEOzOSCPGSg8OcbLIZknLcowjD3UYymm3EI95iXKlfgAWN03Uug4TvDCZno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756574252; c=relaxed/simple;
	bh=zYGWS+/CkrUPWyjkFxvoPxHf5pqXrVxA/dhPwOro6RM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iYWigC42w5zzI6N1a14RLlRfEIw4liOBno2Nv7x8wIrwt696K0NIP9gAVpZQdftBNIAWtb7aboeziQA9LbKrIKvjb/t4tciWP1StiS8mNjhpQKlE1Sf10uwMxcFxse7rmFVz5PLsO/DI9nkhWbFpc9AflVVWcYFIe0PEeHFXMG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W9bHNT9d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41DFDC4CEF7
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 17:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756574252;
	bh=zYGWS+/CkrUPWyjkFxvoPxHf5pqXrVxA/dhPwOro6RM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=W9bHNT9d1L31wYLYzZKyDzSvpdtEZe2wbduQgjHmFvGQlMW9zlcEH4t38Rbv+JHfJ
	 zNhwPQD2hyC/0sck6lXxbY69riXR07vWk0yJChbSypXGmERrAY4Y/G3sTnLOPbbG/m
	 eZ02LP2rK73QBoBfBVilvxvTDnQe/ZZzcpEBSUpQ1+S5bAXZA9omFbbaVLbztTjF6B
	 hqlNoVeXcdlKG/iMX5bpRKNLinE2Ijt/HRDvlnYLaTd4AQlv42EF6/zfBpIOti+YsQ
	 NQlPKEaS9uWx8TFIMVdWaiIUu3RYWot6sZi71BnLUcQzclyBLt8RvBjdlbwUP+rfx0
	 WpgFQsuU8WRjw==
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-71d603a269cso24644407b3.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 10:17:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVJG2LG4nYOG9NN4BuFuDZ02eoai+x3D3fVqNgyeCgaWLHkmfJPlA+n4oRi+CmD8V2mclZpCYIrE+R1soQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyihhrpzzLCEsdRKac9laRRWuYK50ZVg2EEqsPP+ztYY+Tj0317
	OtpYCovSmI4nSskWMId+LANR6wqjrZKJ8BjTOof4C9/StlaQLWIAm05AhrRVv8bdNzDrijm2CxA
	0CvPmq+BafUkej5g2D4lrsZpsA4tnx/LVT4LZkyQpgQ==
X-Google-Smtp-Source: AGHT+IEdAhZDP+hdNmVRZ+bpKP98LzQNJPQlctmdKbNNJ6Tvh/8OZfNSaP9u+dd1GC3FYlNNBFbdEQO21IDezBANZBw=
X-Received: by 2002:a05:690c:7105:b0:721:318f:85ba with SMTP id
 00721157ae682-72276361f59mr24403037b3.17.1756574251353; Sat, 30 Aug 2025
 10:17:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822192023.13477-1-ryncsn@gmail.com> <20250822192023.13477-3-ryncsn@gmail.com>
 <CAF8kJuO0efOE-os=qi=i5jT1YWxspHYc=Ti1KN=uKgyFpWTRbA@mail.gmail.com>
 <CAMgjq7AkUc7hKrEL8cQ7jJTeXYBq7WqM55uQ_SZNNY8vJ7+ODQ@mail.gmail.com>
 <CACePvbWnsrGxUv15R4kMpc10wsBE2Bc-rapGyBYjekrqFJgJbw@mail.gmail.com> <CAMgjq7B-Uvs7CcCdVaFjgzK6DEr47v7ULg6EbzE72OouPRFcSw@mail.gmail.com>
In-Reply-To: <CAMgjq7B-Uvs7CcCdVaFjgzK6DEr47v7ULg6EbzE72OouPRFcSw@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Sat, 30 Aug 2025 10:17:20 -0700
X-Gmail-Original-Message-ID: <CACePvbUrxe1ynqKpuaaU3DfEO8UHwiFgOdVv2OWvxs2Eiz6_Wg@mail.gmail.com>
X-Gm-Features: Ac12FXzKH3DzMhXsO6Feyl6tISayrNok-qAv8F-WPT4_dkWAxnxoVPLD6zGRraw
Message-ID: <CACePvbUrxe1ynqKpuaaU3DfEO8UHwiFgOdVv2OWvxs2Eiz6_Wg@mail.gmail.com>
Subject: Re: [PATCH 2/9] mm, swap: always lock and check the swap cache folio
 before use
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

On Sat, Aug 30, 2025 at 8:16=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
> > So the missing readahead stats update behavior is the correct and
> > better behavior. I suggest you spit that out as a separate patch with
> > appropriate comments about it too. It is also easier to bisect the
> > commit if that kind of the subtle change which is considered safe
> > turns out causing a problem. Causing problem not happen very often but
> > it does happen before.
>
> Yes, I'm planning to split one patch out for the readahead change.

Ack.
>
> > > > >  /*
> > > > > - * Lookup a swap entry in the swap cache. A found folio will be =
returned
> > > > > - * unlocked and with its refcount incremented.
> > > > > + * swap_cache_get_folio - Lookup a swap entry in the swap cache.
> > > > >   *
> > > > > - * Caller must lock the swap device or hold a reference to keep =
it valid.
> > > > > + * A found folio will be returned unlocked and with its refcount=
 increased.
> > > > > + *
> > > > > + * Context: Caller must ensure @entry is valid and pin the swap =
device, also
> > > > Is the "pin" the same as  "lock the swap device or hold a reference=
"?
> > > > Not sure why you changed that comment to "pin".
> > >
> > > Yes it's the same thing. We don't lock the device though, the device
> > > can be pinned by the refcounf (get_swap_device) or locking anything
> > > that is referencing the device (locking PTL the a PTE that contains a=
n
> > > swap entry pointing to the device, or locking a swap cache folio of a
> > > swap entry that points to the device). So I juse used the word "pin".
> > > I added some comments in mm/swap.h in later commits about what the
> > > "pin" means.
> >
> > In that case why not reuse the previous comment keeping "lock the swap
> > device or hold a reference" instead of "pin"?
>
> I'm worried that the sentence "lock the swap device" is kind of fuzzy,
> people may misunderstand that they need to hold si->lock. Actually
> they only need to hold si->user or lock anything. It's not wrong but
> kind of overkill.

What you just told me is a lot more useful than what was previously there.
Try to incorporate that into the comments. e.g. instead of "lock the
swap device", do "lock si->user or any other lock" or something like
that.

> > > > It seems to me that you want to add the comment for the return valu=
e check.
> > > > Is that it?
> > >
> > > Right, the caller has to check the folio before use, so I'm trying to
> > > document this convention.
> >
> > Again, I recommend reducing the unnecessary impact to the code, make
> > it more obvious what you did actually change. I spend quite some time
> > there trying to figure out what you are trying to accomplish with the
> > comments.
> >
> > > > > + * check the returned folio after locking it (e.g. folio_swap_co=
ntains).
> > > > >   */
> > > > >  struct folio *swap_cache_get_folio(swp_entry_t entry)
> > > > >  {
> > > > > @@ -338,7 +340,10 @@ struct folio *__read_swap_cache_async(swp_en=
try_t entry, gfp_t gfp_mask,
> > > > >         for (;;) {
> > > > >                 int err;
> > > > >
> > > > > -               /* Check the swap cache in case the folio is alre=
ady there */
> > > > > +               /*
> > > > > +                * Check the swap cache first, if a cached folio =
is found,
> > > > > +                * return it unlocked. The caller will lock and c=
heck it.
> > > > > +                */
> > > > >                 folio =3D swap_cache_get_folio(entry);
> > > > >                 if (folio)
> > > > >                         goto got_folio;
> > > > > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > > > > index 4b8ab2cb49ca..12f2580ebe8d 100644
> > > > > --- a/mm/swapfile.c
> > > > > +++ b/mm/swapfile.c
> > > > > @@ -240,12 +240,12 @@ static int __try_to_reclaim_swap(struct swa=
p_info_struct *si,
> > > > >          * Offset could point to the middle of a large folio, or =
folio
> > > > >          * may no longer point to the expected offset before it's=
 locked.
> > > > >          */
> > > > > -       entry =3D folio->swap;
> > > > > -       if (offset < swp_offset(entry) || offset >=3D swp_offset(=
entry) + nr_pages) {
> > > > > +       if (!folio_contains_swap(folio, entry)) {
> > > > >                 folio_unlock(folio);
> > > > >                 folio_put(folio);
> > > > >                 goto again;
> > > > >         }
> > > > > +       entry =3D folio->swap;
> > > >
> > > > Can you also check this as well? The "goto again" will have entries
> > > > not assigned compared to previously.
> > > > Too late for me to think straight now if that will cause a problem.
> > >
> > > Oh, thanks for pointing this part out. This patch is correct, it's th=
e
> > > original behaviour that is not correct. If the folio is no longer
> > > valid (the if check here failed), changing the `entry` value before
> > > could lead to a wrong look in the next attempt with `goto again`. Tha=
t
> > > could lead to reclaim of an unrelated folio. It's a trivial issue
> > > though, only might marginally slow down the performance. Maybe I
> > > should make a seperate patch to fix this issue first in case anyone
> > > wants to backport it.
> >
> > Thanks for the explanation, please do split this subtle behavior
> > change out with appropriate commit messages documenting your change,
> > why it is safe and the better behavior.
> >
> > Thanks
>
> Thanks for the review, I think separating 2 patches (one for
> __try_to_reclaim_swap and one for readahead) out of this one should be
> good enough and make everyone happy, overall the code is still the
> same.

It is your call. I am happy to review them the same. It might take me
more time to reason about it and slightly delay your series merge to
mm-unstable, that is all.

Chris

