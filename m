Return-Path: <linux-kernel+bounces-748436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 765D8B14145
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 19:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F9103BF78D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 17:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FC827511B;
	Mon, 28 Jul 2025 17:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QOOPV2za"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB5E1E5B60
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 17:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753724246; cv=none; b=cbNQGAGAH+cIBAmwTsaHlR0jOtR1Po2rYlURmCEZzb66KUT3doSsP1Wp+a3ylvQYP8jRRGwVtyxCkkhWAxjyznfZvCQ5fzMOb0++199+F5K9PuLIFIHCEfdez9InB7vu9vgrwcUgr8/AS1eRc6II1vdi0hXGzI0TROdDChnPUlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753724246; c=relaxed/simple;
	bh=rtP0/6x/PYqZv29uZLUlx9Wmv7dWl+o4QQa82Q5wNB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sSLGmMgDqqpq3hJ7Dhl0VyZEk74gHXB9hCwI/Haa+ZKLgw7CWQnhrTXQg/55q9pnkQ4AnCprW7CNWU6EO48LX5jepeQKpj5AbS5kUPJ/7jAH7Qi4XSA7eAQCJLBj4wtGsXAGHzSWIFyXm1RIJVKjDUCYqMYBW6286+17hGXlmnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QOOPV2za; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4ab3ad4c61fso48821cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 10:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753724244; x=1754329044; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pTCbhOW20UHq+C7vediNNb7AZzzKUerbw3OMJQ79PLs=;
        b=QOOPV2zawW3mHNBI4XidkIG3EON1YQA2bHm3UMrSjj98Ld6lAjEhA6N4NVMBO/yG5e
         xSXwQg+GDeCAVJsZWmcMmWF8Wq51ZjPBW9IXm4ifR1Bcaqgqh/MdBjmdCmro07srVUHt
         V2NxIxXZsg49V0AwewVVGIszagF6SeZ25Msuuz0v/R972nl/42RpLO6QyCW1RxrMNod1
         Et82WSwsxHes6a9qfFuN9l/11UBAa+97CipL10tmTIg8CDHsN5LxMJ/yhSdQG8mYlzX7
         IoGCflG6kg2XkamGifd9ritU2hYiwuK4aervkEnIiYydAJVZuMHaEsHs2Pm/h3Q6NaRt
         qk5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753724244; x=1754329044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pTCbhOW20UHq+C7vediNNb7AZzzKUerbw3OMJQ79PLs=;
        b=XDxdlVLdlX2ywMNHaE/T7tR2gZXfpmJsOSlpFJI/5mBa2B9hLe4c3o4+6Dm+p6+b3x
         MJTYXkdqTM+nuc0wdoNwdTy+peYP/WrILnQi4E/yrXOjU2ME9HZslWIGZC6snSOLWTvo
         nSAEl+BNABRPaQgCajZIol3JhiEEaJsRWquoEw1y4go4i7WySdUqyQeK9xjqzJpu54Ze
         G+bhQGmWX/ODD/o2MZIvwi5hRyxIb1wpS5LCt3nVguHBAoHmYRAGC/pbTGFY4f/6fir7
         XelCwJ1bDJ81Nl27fm1MklhooYm+3JaZgoSvxyxvl6ci1mKhHBammgs5EnAg2GPrv+ni
         e9MQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTft0Fw2rfK+Xl93QpCN4R5VTq1kWrOgl21ugugbLeE9JZ8ewyOaWQwW5XAgev2pzNL3dbtpYkv8gyKJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4pvh7tfgDRZ1mIeu4pOy7MPlFX5mK0N+Gx0RZeumioKYVCcOE
	LHAIrxVFxaWf+pplnhRnhVeBtg86F/YWC8jAkgZq3qzsRDVUUEjZZTNR2lKH6L27KAWaRiGrHPd
	BUiLef47KCpFclVj7qXTW7u8Bfywl1DrWhPAl9HxJ
X-Gm-Gg: ASbGncv71mQFgqitp1ROz+oDDKzScSY7XiuaYc7tybOVPLP59uSxy+7GCNV0gWccMQy
	sp80AAiNxUL6sqnQyFiCtZx/aN6W7w0BBy6epMoTh+2yXnh1o4iOF3NU0xy3QxebPamNDFwPiQP
	XBmXDb62Rz99gJzEPx0ybR+3rqNnKGIGoyJC7RQ1IxPwUDXErLo2HNmc/jPJ6A944pSeGZCGcu0
	urXfc21gKKrHT3b
X-Google-Smtp-Source: AGHT+IENa5AGIFuVcHbre+a/L8J3WjIlVRfxGzMy9W5lbE7QXr2SDd/9GH/kk2ilXf1n4ePG0C3rZTZ7IKDT0LXZrMY=
X-Received: by 2002:a05:622a:4591:b0:4a8:eb0:c528 with SMTP id
 d75a77b69052e-4ae9e817721mr5765641cf.15.1753724243449; Mon, 28 Jul 2025
 10:37:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250728170950.2216966-1-surenb@google.com> <3f8c28f4-6935-4581-83ec-d3bc1e6c400e@suse.cz>
In-Reply-To: <3f8c28f4-6935-4581-83ec-d3bc1e6c400e@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 28 Jul 2025 10:37:11 -0700
X-Gm-Features: Ac12FXybVm9KWjF_cAJM2oZct0U7vehd95FOiYr0FOaxIl4MJxcEbBTmA3eMfZ8
Message-ID: <CAJuCfpGZXGF_k_QVQqHWZpnypB-sWB8hwZeOYMOD0xmAFOBxkA@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: fix a UAF when vma->mm is freed after
 vma->vm_refcnt got dropped
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, jannh@google.com, Liam.Howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, pfalcato@suse.de, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025 at 10:19=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> w=
rote:
>
> On 7/28/25 19:09, Suren Baghdasaryan wrote:
> > By inducing delays in the right places, Jann Horn created a reproducer
> > for a hard to hit UAF issue that became possible after VMAs were allowe=
d
> > to be recycled by adding SLAB_TYPESAFE_BY_RCU to their cache.
> >
> > Race description is borrowed from Jann's discovery report:
> > lock_vma_under_rcu() looks up a VMA locklessly with mas_walk() under
> > rcu_read_lock(). At that point, the VMA may be concurrently freed, and
> > it can be recycled by another process. vma_start_read() then
> > increments the vma->vm_refcnt (if it is in an acceptable range), and
> > if this succeeds, vma_start_read() can return a recycled VMA.
> >
> > In this scenario where the VMA has been recycled, lock_vma_under_rcu()
> > will then detect the mismatching ->vm_mm pointer and drop the VMA
> > through vma_end_read(), which calls vma_refcount_put().
> > vma_refcount_put() drops the refcount and then calls rcuwait_wake_up()
> > using a copy of vma->vm_mm. This is wrong: It implicitly assumes that
> > the caller is keeping the VMA's mm alive, but in this scenario the call=
er
> > has no relation to the VMA's mm, so the rcuwait_wake_up() can cause UAF=
.
> >
> > The diagram depicting the race:
> > T1         T2         T3
> > =3D=3D         =3D=3D         =3D=3D
> > lock_vma_under_rcu
> >   mas_walk
> >           <VMA gets removed from mm>
> >                       mmap
> >                         <the same VMA is reallocated>
> >   vma_start_read
> >     __refcount_inc_not_zero_limited_acquire
> >                       munmap
> >                         __vma_enter_locked
> >                           refcount_add_not_zero
> >   vma_end_read
> >     vma_refcount_put
> >       __refcount_dec_and_test
> >                           rcuwait_wait_event
> >                             <finish operation>
> >       rcuwait_wake_up [UAF]
> >
> > Note that rcuwait_wait_event() in T3 does not block because refcount
> > was already dropped by T1. At this point T3 can exit and free the mm
> > causing UAF in T1.
> > To avoid this we move vma->vm_mm verification into vma_start_read() and
> > grab vma->vm_mm to stabilize it before vma_refcount_put() operation.
> >
> > Fixes: 3104138517fc ("mm: make vma cache SLAB_TYPESAFE_BY_RCU")
> > Reported-by: Jann Horn <jannh@google.com>
> > Closes: https://lore.kernel.org/all/CAG48ez0-deFbVH=3DE3jbkWx=3DX3uVbd8=
nWeo6kbJPQ0KoUD+m2tA@mail.gmail.com/
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > Cc: <stable@vger.kernel.org>
> > ---
> > - Applies cleanly over mm-unstable.
> > - Should be applied to 6.15 and 6.16 but these branches do not
> > have lock_next_vma() function, so the change in lock_next_vma() should =
be
> > skipped when applying to those branches.
> >
> >  include/linux/mmap_lock.h | 21 +++++++++++++++++++++
> >  mm/mmap_lock.c            | 10 +++-------
> >  2 files changed, 24 insertions(+), 7 deletions(-)
> >
> > diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> > index 1f4f44951abe..4ee4ab835c41 100644
> > --- a/include/linux/mmap_lock.h
> > +++ b/include/linux/mmap_lock.h
> > @@ -12,6 +12,7 @@ extern int rcuwait_wake_up(struct rcuwait *w);
> >  #include <linux/tracepoint-defs.h>
> >  #include <linux/types.h>
> >  #include <linux/cleanup.h>
> > +#include <linux/sched/mm.h>
> >
> >  #define MMAP_LOCK_INITIALIZER(name) \
> >       .mmap_lock =3D __RWSEM_INITIALIZER((name).mmap_lock),
> > @@ -183,6 +184,26 @@ static inline struct vm_area_struct *vma_start_rea=
d(struct mm_struct *mm,
> >       }
> >
> >       rwsem_acquire_read(&vma->vmlock_dep_map, 0, 1, _RET_IP_);
> > +
> > +     /*
> > +      * If vma got attached to another mm from under us, that mm is no=
t
> > +      * stable and can be freed in the narrow window after vma->vm_ref=
cnt
> > +      * is dropped and before rcuwait_wake_up(mm) is called. Grab it b=
efore
> > +      * releasing vma->vm_refcnt.
> > +      */
> > +     if (unlikely(vma->vm_mm !=3D mm)) {
> > +             /*
> > +              * __mmdrop() is a heavy operation and we don't need RCU
> > +              * protection here. Release RCU lock during these operati=
ons.
> > +              */
> > +             rcu_read_unlock();
> > +             mmgrab(vma->vm_mm);
> > +             vma_refcount_put(vma);
>
> The vma can go away here.

No, the vma can't go away here because we are holding vm_refcnt. So,
the vma and its mm are stable up until vma_refcount_put() drops
vm_refcnt.

>
> > +             mmdrop(vma->vm_mm);
>
> So we need to copy the vma->vm_mm first?
>
> > +             rcu_read_lock();
> > +             return NULL;
> > +     }
> > +
> >       /*
> >        * Overflow of vm_lock_seq/mm_lock_seq might produce false locked=
 result.
> >        * False unlocked result is impossible because we modify and chec=
k
> > diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
> > index 729fb7d0dd59..aa3bc42ecde0 100644
> > --- a/mm/mmap_lock.c
> > +++ b/mm/mmap_lock.c
> > @@ -164,8 +164,7 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm=
_struct *mm,
> >        */
> >
> >       /* Check if the vma we locked is the right one. */
> > -     if (unlikely(vma->vm_mm !=3D mm ||
> > -                  address < vma->vm_start || address >=3D vma->vm_end)=
)
> > +     if (unlikely(address < vma->vm_start || address >=3D vma->vm_end)=
)
> >               goto inval_end_read;
> >
> >       rcu_read_unlock();
> > @@ -236,11 +235,8 @@ struct vm_area_struct *lock_next_vma(struct mm_str=
uct *mm,
> >               goto fallback;
> >       }
> >
> > -     /*
> > -      * Verify the vma we locked belongs to the same address space and=
 it's
> > -      * not behind of the last search position.
> > -      */
> > -     if (unlikely(vma->vm_mm !=3D mm || from_addr >=3D vma->vm_end))
> > +     /* Verify the vma is not behind of the last search position. */
> > +     if (unlikely(from_addr >=3D vma->vm_end))
> >               goto fallback_unlock;
> >
> >       /*
> >
> > base-commit: c617a4dd7102e691fa0fb2bc4f6b369e37d7f509
>

