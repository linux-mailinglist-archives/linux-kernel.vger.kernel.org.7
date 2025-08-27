Return-Path: <linux-kernel+bounces-788476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FD2B3851E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 16:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 254C01614BA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 14:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03F520B80A;
	Wed, 27 Aug 2025 14:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZCo7ljL"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D581E5B88
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 14:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756305392; cv=none; b=HaN4eJKSQWq3AvU4DYezy4Eb53Tm7OFK7N0+GHNmKMLUMA/705uwvIvCPYdCAHEtD0ZccfGvj4MBQy39YlrblmcQIRcxSYW9ueppwc3rFMItIKc6XqwX6xgPBjKR9xB/h7sdBUHwjgwUbCPJd/LJ8/3RmGC/EVGn7PXBRJwlM/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756305392; c=relaxed/simple;
	bh=ZzLiY+i5zPaz7lO+nPGOxp9CCzwMtrW5ChFcoule59A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VdLUUlOqBvmUewGndX04rcKWokfIt+ITgGOQOZQIq1u9qBZ0M9QwY8tpaoHbUX0LQK8REZgKyOhPpHQqZZyYmODK5VN6Uxj+4KSdBFwFVqN5xvaM4lXCfXabKOh6t81IOXypheC1Zr0/GkDkjGqoKLPytglq7IIt0mN1Vdwv92M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZCo7ljL; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-336989ed3a4so4350971fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 07:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756305389; x=1756910189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yER43C8X788IpQP0esrNVi7SuiWvauhx8PuShr745bA=;
        b=CZCo7ljL6XzdnqMBiuO+S7C+gIoTw9hIlXaOq8EatwjoAW80Chp66UwsrQVIpmOCTJ
         lWyzgsuHO4WvskLubjLdtCAdgs3j4GNB+/SEaae1ywquo8BqADk0z42BTF5Krge8z37m
         ObxNjpv12k3qdvWNpU/Nvbx5948EjJtZkuhoMsgmO6kibXj/kuuCDaHwVM7KnUqiMk5w
         XsMEwrmGBx14LDErCp4EG9KZ6V0+MhObiw4ujsmo51cZRxuXSrzZ1qTC1TWIW+kEeZFN
         Pl3duitJMsQMSed4XbFnoxnelg464RtQmBnAz+wyqKiyaOjXwBnPft3cF7l7EX1BQDlg
         +zMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756305389; x=1756910189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yER43C8X788IpQP0esrNVi7SuiWvauhx8PuShr745bA=;
        b=f79UpptY1xyR0X+pn+1H4hUYqftlnprrdZqP+ghe7+r7/4+CHJ+ZTHZGEniRj+hWQm
         XRvrz7Z5H+SIdWRtFOhmi+4u+JWK/5i6tRXVTmjocPIxHry0cHE26QYzIG5hTycdUDXw
         3eGNKrrCAgwS4N6+vIY4wvHkvJAo65GT+hbSoYjPeMyNVjUW8sHV3TKiFXJQK3tLyiai
         k34m/FX5GFpvzrWT63mNZWPj9veALYSH6IHbOm/99zN16LnTiEjTgMIhL6pYU5ZSusJ3
         VnChxpoW15unG1WOiqHSEB5YbBaBkh92GgAntrN2ZiR4ZqwCsEKQeIMqKVXpyq4xPScv
         DSoA==
X-Forwarded-Encrypted: i=1; AJvYcCUIYtaXyLNCStlIF6rmjxSfn1/xgk1Yy4vKNBLwZTx1qMKq6/Dcffkp6ckN5Kv5ra3Ne1OxVooKMGmhnIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRUmLOhh7GK1Gxl0aF/rwlt1vSf+OAI2pd9xb0S36gGfwwfyNy
	taeN5JobpQ7UrKhce/pySV1z+0IgcipYQN7ejGVoDhoTMxjM4gy4rXA5+DBkUwEYgS9s/7rJ2kw
	GA9Pd5y0p3m9TcDs7OlamqRZaWDqN8fw=
X-Gm-Gg: ASbGncuYJdPo/oBST4frSZLVwsEqhpB3N74hgmJjybcYbOvRgkA9y+8nYWfH1/1c2N7
	y/xfZOvlFxf6TPh/LbYqBO3z3anVnVR8yA+zRKrbN+4KwK5OFm+O1FbJg2OocyV2kYIykQ1NWMm
	qtQ5nlk57xpE7QrlrIbEnMyljhDD3bBmoLrk26sDy8+fHukeGgyTZ3RexDL/Dwj2LOY+TsBCmDX
	h7MhAo=
X-Google-Smtp-Source: AGHT+IEdOj0pKOFhGzu8gBtRzFTYOZWkbszM7Fmdw5DNtYW3ObU2NnNlfYN3QQ35XVly64iYYt24LonYJUdBbferTSA=
X-Received: by 2002:a2e:b8c2:0:b0:336:74c6:37b with SMTP id
 38308e7fff4ca-33674c6093amr32296471fa.22.1756305388609; Wed, 27 Aug 2025
 07:36:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822192023.13477-1-ryncsn@gmail.com> <20250822192023.13477-3-ryncsn@gmail.com>
 <CAF8kJuO0efOE-os=qi=i5jT1YWxspHYc=Ti1KN=uKgyFpWTRbA@mail.gmail.com>
In-Reply-To: <CAF8kJuO0efOE-os=qi=i5jT1YWxspHYc=Ti1KN=uKgyFpWTRbA@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 27 Aug 2025 22:35:51 +0800
X-Gm-Features: Ac12FXwm2WfLl0mEmBMmQ0g2aVDQZhjEraUkxB4QSctNwOn_Ntr7pZee2ZGHLyY
Message-ID: <CAMgjq7AkUc7hKrEL8cQ7jJTeXYBq7WqM55uQ_SZNNY8vJ7+ODQ@mail.gmail.com>
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

On Wed, Aug 27, 2025 at 4:21=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote:
>
> On Fri, Aug 22, 2025 at 12:21=E2=80=AFPM Kairui Song <ryncsn@gmail.com> w=
rote:
>
> > diff --git a/mm/shmem.c b/mm/shmem.c
> > index e9d0d2784cd5..b4d39f2a1e0a 100644
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -2379,8 +2379,6 @@ static int shmem_swapin_folio(struct inode *inode=
, pgoff_t index,
> >                         count_vm_event(PGMAJFAULT);
> >                         count_memcg_event_mm(fault_mm, PGMAJFAULT);
> >                 }
> > -       } else {
> > -               swap_update_readahead(folio, NULL, 0);
>
> Also this update readahead move to later might have a similar problem.
> All the bail out in the move will lose the readahead status update.
>
> The readahead deed is already done. Missing the status update seems
> incorrect.

Thanks for the detailed review.

The only change I wanted here is that swap readahead update should be
done after checking the folio still corresponds to the swap entry
triggering the swapin. That should have slight to none effect compared
to before considering the extremely tiny time window. We are only
following the convention more strictly.

In theory it might even help to reduce false updates: if the folio no
longer corresponds to the swap entry, we are hitting an unrelated
folio, doing a readahead update will either mislead vma readahead's
address hint, or could clean up the readahead flag of an unrelated
folio without actually using it. If the folio does get hit in the
future, due to the missing readahead flag, the statistic will go
wrong.

>
>
> >         }
> >
> >         if (order > folio_order(folio)) {
> > @@ -2431,6 +2429,8 @@ static int shmem_swapin_folio(struct inode *inode=
, pgoff_t index,
> >                 error =3D -EIO;
> >                 goto failed;
> >         }
> > +       if (!skip_swapcache)
> > +               swap_update_readahead(folio, NULL, 0);
> >         folio_wait_writeback(folio);
> >         nr_pages =3D folio_nr_pages(folio);
>
>
> >
> > diff --git a/mm/swap.h b/mm/swap.h
> > index efb6d7ff9f30..bb2adbfd64a9 100644
> > --- a/mm/swap.h
> > +++ b/mm/swap.h
> > @@ -52,6 +52,29 @@ static inline pgoff_t swap_cache_index(swp_entry_t e=
ntry)
> >         return swp_offset(entry) & SWAP_ADDRESS_SPACE_MASK;
> >  }
> >
> > +/**
> > + * folio_contains_swap - Does this folio contain this swap entry?
> > + * @folio: The folio.
> > + * @entry: The swap entry to check against.
> > + *
> > + * Swap version of folio_contains()
> > + *
> > + * Context: The caller should have the folio locked to ensure
> > + * nothing will move it out of the swap cache.
> > + * Return: true or false.
> > + */
> > +static inline bool folio_contains_swap(struct folio *folio, swp_entry_=
t entry)
> > +{
> > +       pgoff_t offset =3D swp_offset(entry);
> > +
> > +       VM_WARN_ON_ONCE(!folio_test_locked(folio));
> > +       if (unlikely(!folio_test_swapcache(folio)))
> > +               return false;
> > +       if (unlikely(swp_type(entry) !=3D swp_type(folio->swap)))
> > +               return false;
> > +       return offset - swp_offset(folio->swap) < folio_nr_pages(folio)=
;
> > +}
> > +
> >  void show_swap_cache_info(void);
> >  void *get_shadow_from_swap_cache(swp_entry_t entry);
> >  int add_to_swap_cache(struct folio *folio, swp_entry_t entry,
> > @@ -144,6 +167,11 @@ static inline pgoff_t swap_cache_index(swp_entry_t=
 entry)
> >         return 0;
> >  }
> >
> > +static inline bool folio_contains_swap(struct folio *folio, swp_entry_=
t entry)
> > +{
> > +       return false;
> > +}
> > +
> >  static inline void show_swap_cache_info(void)
> >  {
> >  }
> > diff --git a/mm/swap_state.c b/mm/swap_state.c
> > index ff9eb761a103..be0d96494dc1 100644
> > --- a/mm/swap_state.c
> > +++ b/mm/swap_state.c
> > @@ -70,10 +70,12 @@ void show_swap_cache_info(void)
> >  }
> >
> >  /*
> > - * Lookup a swap entry in the swap cache. A found folio will be return=
ed
> > - * unlocked and with its refcount incremented.
> > + * swap_cache_get_folio - Lookup a swap entry in the swap cache.
> >   *
> > - * Caller must lock the swap device or hold a reference to keep it val=
id.
> > + * A found folio will be returned unlocked and with its refcount incre=
ased.
> > + *
> > + * Context: Caller must ensure @entry is valid and pin the swap device=
, also
> Is the "pin" the same as  "lock the swap device or hold a reference"?
> Not sure why you changed that comment to "pin".

Yes it's the same thing. We don't lock the device though, the device
can be pinned by the refcounf (get_swap_device) or locking anything
that is referencing the device (locking PTL the a PTE that contains an
swap entry pointing to the device, or locking a swap cache folio of a
swap entry that points to the device). So I juse used the word "pin".
I added some comments in mm/swap.h in later commits about what the
"pin" means.

>
> It seems to me that you want to add the comment for the return value chec=
k.
> Is that it?

Right, the caller has to check the folio before use, so I'm trying to
document this convention.

> > + * check the returned folio after locking it (e.g. folio_swap_contains=
).
> >   */
> >  struct folio *swap_cache_get_folio(swp_entry_t entry)
> >  {
> > @@ -338,7 +340,10 @@ struct folio *__read_swap_cache_async(swp_entry_t =
entry, gfp_t gfp_mask,
> >         for (;;) {
> >                 int err;
> >
> > -               /* Check the swap cache in case the folio is already th=
ere */
> > +               /*
> > +                * Check the swap cache first, if a cached folio is fou=
nd,
> > +                * return it unlocked. The caller will lock and check i=
t.
> > +                */
> >                 folio =3D swap_cache_get_folio(entry);
> >                 if (folio)
> >                         goto got_folio;
> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > index 4b8ab2cb49ca..12f2580ebe8d 100644
> > --- a/mm/swapfile.c
> > +++ b/mm/swapfile.c
> > @@ -240,12 +240,12 @@ static int __try_to_reclaim_swap(struct swap_info=
_struct *si,
> >          * Offset could point to the middle of a large folio, or folio
> >          * may no longer point to the expected offset before it's locke=
d.
> >          */
> > -       entry =3D folio->swap;
> > -       if (offset < swp_offset(entry) || offset >=3D swp_offset(entry)=
 + nr_pages) {
> > +       if (!folio_contains_swap(folio, entry)) {
> >                 folio_unlock(folio);
> >                 folio_put(folio);
> >                 goto again;
> >         }
> > +       entry =3D folio->swap;
>
> Can you also check this as well? The "goto again" will have entries
> not assigned compared to previously.
> Too late for me to think straight now if that will cause a problem.

Oh, thanks for pointing this part out. This patch is correct, it's the
original behaviour that is not correct. If the folio is no longer
valid (the if check here failed), changing the `entry` value before
could lead to a wrong look in the next attempt with `goto again`. That
could lead to reclaim of an unrelated folio. It's a trivial issue
though, only might marginally slow down the performance. Maybe I
should make a seperate patch to fix this issue first in case anyone
wants to backport it.

>
> To be continued.
>
> Chris
>

