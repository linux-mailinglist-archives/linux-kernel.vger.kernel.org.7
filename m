Return-Path: <linux-kernel+bounces-792649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A698B3C733
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 03:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FF9E568695
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 01:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D7324466C;
	Sat, 30 Aug 2025 01:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QdHGQGoo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C66E2AE89
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 01:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756518846; cv=none; b=IxxDQD5YI4UJftsCADm9iwbSGV4jKJSij9mELJ7DfTgGsR5wm6m8cRBa+0k620CV5fYGWer6gObQjVR7wczZtuXjW4JO0BNtrS0qBtTNGPksYCmZaK/Pnzq0KoEynkc9JbMLx+f3OgYq5LzXgrBzInAQY3ZX1NvXs6sCwFezKzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756518846; c=relaxed/simple;
	bh=ege+hdo/NEDl5bVu2HF6qh6wJNLzx4jRvmLsvzMn2x0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hpaMY63LL5Su1Goik5Pn+dF8QKKp5YNamzGZtSMJA54+wlzfU5fF/BJEg5VNZoviIf6PHOHEntjQe3L+uC5ZdxxhrAMvMpEEu9Av+77cg8iOJpIKmmFTYvfvMre/tkC9/VGa4NMlhX1OLhdv1J0YT0WZIdzUANkBvRnx7sigAFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QdHGQGoo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94EBEC4CEF8
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 01:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756518845;
	bh=ege+hdo/NEDl5bVu2HF6qh6wJNLzx4jRvmLsvzMn2x0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QdHGQGoo83RrwtkK94aa+YmoalGy22EoLSWJRK2acQzpAKmHAPSkEETJyvnBO7rW6
	 poVhTZ8Wr4W6FhBD7A5pKPnatWLHSnbUdr4T9TGRc4iSIiM2dizpFdtH0UFF1U2EbB
	 DRNOk8yaVKZZ4geziUQVLEwUutsBCdmUElGZq6F0mGAWGf1OexB8cemIDG+ZcaL/iq
	 rDi3oHRXgqMkz1ROzE1zvcug5LGADDgDauSpssu35NvczW7H6LhxISBp/F1U8E3IU1
	 HzSpZj2LHVraPOJ6vlyXz3Pqyhy/oREdnbP+Ddo10DB9TumzuNc/wBMmB5Lnn7ELk9
	 R7VXO9VHAwPEg==
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-71d605a70bdso16664577b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 18:54:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWdwgRJC+5FBal8/s/UaHxvSSf54eCfwMcrfmEzQv6JWepfoaFDEfyUcwlr3XySRQfRVVa4KQFfT+IUAm4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy++Fyb2IJPbSsgHtHq5yC5fIzGbYxF6DhSgiuj/OjPCwmr48x+
	tIFJEJaGmdQ71XLjwoNjGddqG6rT6j1vrYxwZw5gPOkrxthjg5o+DCb98mfMEikoAnpyXYgS3Zl
	6+96Gr0a2abbcqBSYl2dG3arubLv0ewUhfH0Gkk5IWw==
X-Google-Smtp-Source: AGHT+IGBZ1xL6FdwTO9yXaxuU6Nt58z3MWQ9+wnEUCEIX9zmetn0MTjllloph7ia1dbpPu0gIUEf8L0hQ0/Kiuu3Lrs=
X-Received: by 2002:a05:690c:358a:b0:71f:9a36:d33c with SMTP id
 00721157ae682-7227656413cmr6269987b3.46.1756518844763; Fri, 29 Aug 2025
 18:54:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822192023.13477-1-ryncsn@gmail.com> <20250822192023.13477-3-ryncsn@gmail.com>
 <CAF8kJuO0efOE-os=qi=i5jT1YWxspHYc=Ti1KN=uKgyFpWTRbA@mail.gmail.com> <CAMgjq7AkUc7hKrEL8cQ7jJTeXYBq7WqM55uQ_SZNNY8vJ7+ODQ@mail.gmail.com>
In-Reply-To: <CAMgjq7AkUc7hKrEL8cQ7jJTeXYBq7WqM55uQ_SZNNY8vJ7+ODQ@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 29 Aug 2025 18:53:53 -0700
X-Gmail-Original-Message-ID: <CACePvbWnsrGxUv15R4kMpc10wsBE2Bc-rapGyBYjekrqFJgJbw@mail.gmail.com>
X-Gm-Features: Ac12FXzjoYWbR33a8qw8WcX8eQ87VF6jdqd98ld297qjjjUhlL6PIubCngMCzzs
Message-ID: <CACePvbWnsrGxUv15R4kMpc10wsBE2Bc-rapGyBYjekrqFJgJbw@mail.gmail.com>
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

On Wed, Aug 27, 2025 at 7:36=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> On Wed, Aug 27, 2025 at 4:21=E2=80=AFPM Chris Li <chrisl@kernel.org> wrot=
e:
> >
> > On Fri, Aug 22, 2025 at 12:21=E2=80=AFPM Kairui Song <ryncsn@gmail.com>=
 wrote:
> >
> > > diff --git a/mm/shmem.c b/mm/shmem.c
> > > index e9d0d2784cd5..b4d39f2a1e0a 100644
> > > --- a/mm/shmem.c
> > > +++ b/mm/shmem.c
> > > @@ -2379,8 +2379,6 @@ static int shmem_swapin_folio(struct inode *ino=
de, pgoff_t index,
> > >                         count_vm_event(PGMAJFAULT);
> > >                         count_memcg_event_mm(fault_mm, PGMAJFAULT);
> > >                 }
> > > -       } else {
> > > -               swap_update_readahead(folio, NULL, 0);
> >
> > Also this update readahead move to later might have a similar problem.
> > All the bail out in the move will lose the readahead status update.
> >
> > The readahead deed is already done. Missing the status update seems
> > incorrect.
>
> Thanks for the detailed review.
>
> The only change I wanted here is that swap readahead update should be
> done after checking the folio still corresponds to the swap entry
> triggering the swapin. That should have slight to none effect compared
> to before considering the extremely tiny time window. We are only
> following the convention more strictly.
>
> In theory it might even help to reduce false updates: if the folio no
> longer corresponds to the swap entry, we are hitting an unrelated
> folio, doing a readahead update will either mislead vma readahead's
> address hint, or could clean up the readahead flag of an unrelated
> folio without actually using it. If the folio does get hit in the
> future, due to the missing readahead flag, the statistic will go
> wrong.

So the missing readahead stats update behavior is the correct and
better behavior. I suggest you spit that out as a separate patch with
appropriate comments about it too. It is also easier to bisect the
commit if that kind of the subtle change which is considered safe
turns out causing a problem. Causing problem not happen very often but
it does happen before.

> > >  /*
> > > - * Lookup a swap entry in the swap cache. A found folio will be retu=
rned
> > > - * unlocked and with its refcount incremented.
> > > + * swap_cache_get_folio - Lookup a swap entry in the swap cache.
> > >   *
> > > - * Caller must lock the swap device or hold a reference to keep it v=
alid.
> > > + * A found folio will be returned unlocked and with its refcount inc=
reased.
> > > + *
> > > + * Context: Caller must ensure @entry is valid and pin the swap devi=
ce, also
> > Is the "pin" the same as  "lock the swap device or hold a reference"?
> > Not sure why you changed that comment to "pin".
>
> Yes it's the same thing. We don't lock the device though, the device
> can be pinned by the refcounf (get_swap_device) or locking anything
> that is referencing the device (locking PTL the a PTE that contains an
> swap entry pointing to the device, or locking a swap cache folio of a
> swap entry that points to the device). So I juse used the word "pin".
> I added some comments in mm/swap.h in later commits about what the
> "pin" means.

In that case why not reuse the previous comment keeping "lock the swap
device or hold a reference" instead of "pin"?

> > It seems to me that you want to add the comment for the return value ch=
eck.
> > Is that it?
>
> Right, the caller has to check the folio before use, so I'm trying to
> document this convention.

Again, I recommend reducing the unnecessary impact to the code, make
it more obvious what you did actually change. I spend quite some time
there trying to figure out what you are trying to accomplish with the
comments.

> > > + * check the returned folio after locking it (e.g. folio_swap_contai=
ns).
> > >   */
> > >  struct folio *swap_cache_get_folio(swp_entry_t entry)
> > >  {
> > > @@ -338,7 +340,10 @@ struct folio *__read_swap_cache_async(swp_entry_=
t entry, gfp_t gfp_mask,
> > >         for (;;) {
> > >                 int err;
> > >
> > > -               /* Check the swap cache in case the folio is already =
there */
> > > +               /*
> > > +                * Check the swap cache first, if a cached folio is f=
ound,
> > > +                * return it unlocked. The caller will lock and check=
 it.
> > > +                */
> > >                 folio =3D swap_cache_get_folio(entry);
> > >                 if (folio)
> > >                         goto got_folio;
> > > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > > index 4b8ab2cb49ca..12f2580ebe8d 100644
> > > --- a/mm/swapfile.c
> > > +++ b/mm/swapfile.c
> > > @@ -240,12 +240,12 @@ static int __try_to_reclaim_swap(struct swap_in=
fo_struct *si,
> > >          * Offset could point to the middle of a large folio, or foli=
o
> > >          * may no longer point to the expected offset before it's loc=
ked.
> > >          */
> > > -       entry =3D folio->swap;
> > > -       if (offset < swp_offset(entry) || offset >=3D swp_offset(entr=
y) + nr_pages) {
> > > +       if (!folio_contains_swap(folio, entry)) {
> > >                 folio_unlock(folio);
> > >                 folio_put(folio);
> > >                 goto again;
> > >         }
> > > +       entry =3D folio->swap;
> >
> > Can you also check this as well? The "goto again" will have entries
> > not assigned compared to previously.
> > Too late for me to think straight now if that will cause a problem.
>
> Oh, thanks for pointing this part out. This patch is correct, it's the
> original behaviour that is not correct. If the folio is no longer
> valid (the if check here failed), changing the `entry` value before
> could lead to a wrong look in the next attempt with `goto again`. That
> could lead to reclaim of an unrelated folio. It's a trivial issue
> though, only might marginally slow down the performance. Maybe I
> should make a seperate patch to fix this issue first in case anyone
> wants to backport it.

Thanks for the explanation, please do split this subtle behavior
change out with appropriate commit messages documenting your change,
why it is safe and the better behavior.

Thanks

Chris

