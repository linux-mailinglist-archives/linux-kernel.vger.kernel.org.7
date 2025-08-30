Return-Path: <linux-kernel+bounces-793019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF748B3CBC0
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 17:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9ECA189E4CF
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 15:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905172253EE;
	Sat, 30 Aug 2025 15:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBlePYfj"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25E56FC5
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 15:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756566982; cv=none; b=Zh8zDQOMR90dxVEqwuj/5dOMfnxq3azdovyQZZWHGZ/ubdp7UD8v11VYXgKlppoDtS0bgM3PhVVftSK9GOtSIjD0G65nycDZrxeuVbpZHr2GGIscd08eRRA2dKNCkaoea8zFZ6P2eFpoh2b89ZiYJfjrKVljdmB4l5gw+zMdhXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756566982; c=relaxed/simple;
	bh=8gWAepcnEjcaGK029fi28fUgZao6jXkA+Rgy7NDIxdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WFWNp1jQn9Xu/Ob4/VFt2g2aQeDLnNHydeavPLOMOhF6Pq8WaOshryTJ3mNEW4ksPOvVkWwcvP+Ui/3lmvmMKKbMTjgEYuZXnmBQdzSF354tR+zja9rUs0EyNivufJtcJjjotxNxnHbpvtiqf8dQqqayLlQrp2UfTjQzhVQyP94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hBlePYfj; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-afcb7a8dd3dso414179666b.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 08:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756566978; x=1757171778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SLPiSegKxUNYAw3Zd6EdR2OPLH/om+bTuQuXULc/mjI=;
        b=hBlePYfjSYERvChU8YU4353xLhPaXB44LnXR18hiYmOCv2XbtecrT7B/cH3vikY/3h
         XSdWaZa9zw2JSvDXzjczrGtZyvFmw6+EoPpxZVbpztAkZLUZU0PCyHPoUAaXCuUeq2mV
         LkzrmY+uC5QB5pXoLC2kpDlN5+kwswzLFJlFN21tV9pVX2MXxIB93YjacGvd0vUDJJcG
         veow1TN8nJtVoMiJmkHRw6Fby1aruHxUNYp8/aJiQpj0cPcATP9V5TbRrnJXJyAPYhRe
         oFJPBiYy6DpKZcg14hOHSSExo3fKCkwoTS/tkMWb5R+lARy54b9sglDA0ZdNqqfd8jng
         W95w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756566978; x=1757171778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SLPiSegKxUNYAw3Zd6EdR2OPLH/om+bTuQuXULc/mjI=;
        b=u/5bvhCYRIana+jNVnSuL1A8/nOp7u+AR1m/ImesWqvSzByRetIX4m+eMwpq7+Zlfe
         KpnN0y5vds8OxYY9wW7xwnYQT9dHw/0eoE2jzrb5yTctLD1irlFfG9rYYfbsqwC/0EcU
         DYDkKHeEdqb3jEoXkxIyai7iqsyhjbML+ffCT4qt7/4hmOLti+IO4Gg/M2Tf9F++/LXn
         j+FYEwaFJcC52ONxdqfbOtoNLpEA+r7uuwz17X2XszjhX+Qz0w/S32VcJuGbbaz0eCeN
         odlbW2N5xWoRfhnJpEP314dZEIEa5xBS2zZQHZOeWWv7jSO5fz4xPUaeYlBo2SgNkwsL
         z/SA==
X-Forwarded-Encrypted: i=1; AJvYcCU0pAAhVh8ORBgKnHo39p9sjTc5CstjFZg+/2n4jFv0FX2/uR8bjJQOEi9JA65AGd6rJMpOkbXE00SKxS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHXCRlYHG7oRYRqTD8mQ3+Bt+UNMtxGMz4T8iNNM5lmlNszk9w
	BcdJ0wOtmPcTJSU9ZkLcYm3Dk3dO+heCb3vR0A6nT+t9N8xo4hpI1Wx8+DbYfMYKWkIODPZ2tG5
	vN6iDOqf/9CZPYjRbaVxxyPtoMFdN1ww=
X-Gm-Gg: ASbGncvYG1xAR7f1TuyBFHN/R1wxGu/+THhNl5obR/VmTPd1GhOUSNEbQJdPqydvRQ5
	fWb+LgLqUhUC28a9KdGo2MDWedaE28vzGq8EW7GqU6h64LU/m2YzUtNQLCHHlfa1QZ9hmdbLH5a
	x57RrY5hOmrRnw/7oxMmBwNnXKzIUbGoz3cE8n3vTIz4kRChMaGOtyVWPe3FvX9RbMf+Mc0B4YR
	4JWpTItNpALTWiGtQ==
X-Google-Smtp-Source: AGHT+IGN/lEWRlwT6eKifuXyyLzVLEsXneoy1dl2bE2k/h77XFsGwwJyYUKYAzuWeQ9thvjF6YVdF4tOL+9DsEHwGxg=
X-Received: by 2002:a17:907:7f90:b0:afe:d0c9:8f50 with SMTP id
 a640c23a62f3a-b01d978e50amr206066466b.44.1756566977983; Sat, 30 Aug 2025
 08:16:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822192023.13477-1-ryncsn@gmail.com> <20250822192023.13477-3-ryncsn@gmail.com>
 <CAF8kJuO0efOE-os=qi=i5jT1YWxspHYc=Ti1KN=uKgyFpWTRbA@mail.gmail.com>
 <CAMgjq7AkUc7hKrEL8cQ7jJTeXYBq7WqM55uQ_SZNNY8vJ7+ODQ@mail.gmail.com> <CACePvbWnsrGxUv15R4kMpc10wsBE2Bc-rapGyBYjekrqFJgJbw@mail.gmail.com>
In-Reply-To: <CACePvbWnsrGxUv15R4kMpc10wsBE2Bc-rapGyBYjekrqFJgJbw@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Sat, 30 Aug 2025 23:15:41 +0800
X-Gm-Features: Ac12FXzTgmJbHwtTxDAlynGWHj0VIPcPVJqjGLFzJhXQmeTqGU9ymfK1vQbPET0
Message-ID: <CAMgjq7B-Uvs7CcCdVaFjgzK6DEr47v7ULg6EbzE72OouPRFcSw@mail.gmail.com>
Subject: Re: [PATCH 2/9] mm, swap: always lock and check the swap cache folio
 before use
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

On Sat, Aug 30, 2025 at 9:54=E2=80=AFAM Chris Li <chrisl@kernel.org> wrote:
>
> On Wed, Aug 27, 2025 at 7:36=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wr=
ote:
> >
> > On Wed, Aug 27, 2025 at 4:21=E2=80=AFPM Chris Li <chrisl@kernel.org> wr=
ote:
> > >
> > > On Fri, Aug 22, 2025 at 12:21=E2=80=AFPM Kairui Song <ryncsn@gmail.co=
m> wrote:
> > >
> > > > diff --git a/mm/shmem.c b/mm/shmem.c
> > > > index e9d0d2784cd5..b4d39f2a1e0a 100644
> > > > --- a/mm/shmem.c
> > > > +++ b/mm/shmem.c
> > > > @@ -2379,8 +2379,6 @@ static int shmem_swapin_folio(struct inode *i=
node, pgoff_t index,
> > > >                         count_vm_event(PGMAJFAULT);
> > > >                         count_memcg_event_mm(fault_mm, PGMAJFAULT);
> > > >                 }
> > > > -       } else {
> > > > -               swap_update_readahead(folio, NULL, 0);
> > >
> > > Also this update readahead move to later might have a similar problem=
.
> > > All the bail out in the move will lose the readahead status update.
> > >
> > > The readahead deed is already done. Missing the status update seems
> > > incorrect.
> >
> > Thanks for the detailed review.
> >
> > The only change I wanted here is that swap readahead update should be
> > done after checking the folio still corresponds to the swap entry
> > triggering the swapin. That should have slight to none effect compared
> > to before considering the extremely tiny time window. We are only
> > following the convention more strictly.
> >
> > In theory it might even help to reduce false updates: if the folio no
> > longer corresponds to the swap entry, we are hitting an unrelated
> > folio, doing a readahead update will either mislead vma readahead's
> > address hint, or could clean up the readahead flag of an unrelated
> > folio without actually using it. If the folio does get hit in the
> > future, due to the missing readahead flag, the statistic will go
> > wrong.
>
> So the missing readahead stats update behavior is the correct and
> better behavior. I suggest you spit that out as a separate patch with
> appropriate comments about it too. It is also easier to bisect the
> commit if that kind of the subtle change which is considered safe
> turns out causing a problem. Causing problem not happen very often but
> it does happen before.

Yes, I'm planning to split one patch out for the readahead change.

> > > >  /*
> > > > - * Lookup a swap entry in the swap cache. A found folio will be re=
turned
> > > > - * unlocked and with its refcount incremented.
> > > > + * swap_cache_get_folio - Lookup a swap entry in the swap cache.
> > > >   *
> > > > - * Caller must lock the swap device or hold a reference to keep it=
 valid.
> > > > + * A found folio will be returned unlocked and with its refcount i=
ncreased.
> > > > + *
> > > > + * Context: Caller must ensure @entry is valid and pin the swap de=
vice, also
> > > Is the "pin" the same as  "lock the swap device or hold a reference"?
> > > Not sure why you changed that comment to "pin".
> >
> > Yes it's the same thing. We don't lock the device though, the device
> > can be pinned by the refcounf (get_swap_device) or locking anything
> > that is referencing the device (locking PTL the a PTE that contains an
> > swap entry pointing to the device, or locking a swap cache folio of a
> > swap entry that points to the device). So I juse used the word "pin".
> > I added some comments in mm/swap.h in later commits about what the
> > "pin" means.
>
> In that case why not reuse the previous comment keeping "lock the swap
> device or hold a reference" instead of "pin"?

I'm worried that the sentence "lock the swap device" is kind of fuzzy,
people may misunderstand that they need to hold si->lock. Actually
they only need to hold si->user or lock anything. It's not wrong but
kind of overkill.

>
> > > It seems to me that you want to add the comment for the return value =
check.
> > > Is that it?
> >
> > Right, the caller has to check the folio before use, so I'm trying to
> > document this convention.
>
> Again, I recommend reducing the unnecessary impact to the code, make
> it more obvious what you did actually change. I spend quite some time
> there trying to figure out what you are trying to accomplish with the
> comments.
>
> > > > + * check the returned folio after locking it (e.g. folio_swap_cont=
ains).
> > > >   */
> > > >  struct folio *swap_cache_get_folio(swp_entry_t entry)
> > > >  {
> > > > @@ -338,7 +340,10 @@ struct folio *__read_swap_cache_async(swp_entr=
y_t entry, gfp_t gfp_mask,
> > > >         for (;;) {
> > > >                 int err;
> > > >
> > > > -               /* Check the swap cache in case the folio is alread=
y there */
> > > > +               /*
> > > > +                * Check the swap cache first, if a cached folio is=
 found,
> > > > +                * return it unlocked. The caller will lock and che=
ck it.
> > > > +                */
> > > >                 folio =3D swap_cache_get_folio(entry);
> > > >                 if (folio)
> > > >                         goto got_folio;
> > > > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > > > index 4b8ab2cb49ca..12f2580ebe8d 100644
> > > > --- a/mm/swapfile.c
> > > > +++ b/mm/swapfile.c
> > > > @@ -240,12 +240,12 @@ static int __try_to_reclaim_swap(struct swap_=
info_struct *si,
> > > >          * Offset could point to the middle of a large folio, or fo=
lio
> > > >          * may no longer point to the expected offset before it's l=
ocked.
> > > >          */
> > > > -       entry =3D folio->swap;
> > > > -       if (offset < swp_offset(entry) || offset >=3D swp_offset(en=
try) + nr_pages) {
> > > > +       if (!folio_contains_swap(folio, entry)) {
> > > >                 folio_unlock(folio);
> > > >                 folio_put(folio);
> > > >                 goto again;
> > > >         }
> > > > +       entry =3D folio->swap;
> > >
> > > Can you also check this as well? The "goto again" will have entries
> > > not assigned compared to previously.
> > > Too late for me to think straight now if that will cause a problem.
> >
> > Oh, thanks for pointing this part out. This patch is correct, it's the
> > original behaviour that is not correct. If the folio is no longer
> > valid (the if check here failed), changing the `entry` value before
> > could lead to a wrong look in the next attempt with `goto again`. That
> > could lead to reclaim of an unrelated folio. It's a trivial issue
> > though, only might marginally slow down the performance. Maybe I
> > should make a seperate patch to fix this issue first in case anyone
> > wants to backport it.
>
> Thanks for the explanation, please do split this subtle behavior
> change out with appropriate commit messages documenting your change,
> why it is safe and the better behavior.
>
> Thanks

Thanks for the review, I think separating 2 patches (one for
__try_to_reclaim_swap and one for readahead) out of this one should be
good enough and make everyone happy, overall the code is still the
same.

>
> Chris

