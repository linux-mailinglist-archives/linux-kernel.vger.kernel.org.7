Return-Path: <linux-kernel+bounces-748670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D07B14482
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 00:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD3024E266E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 22:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C05238C10;
	Mon, 28 Jul 2025 22:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AjRfhMAu"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00DB238152
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 22:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753743235; cv=none; b=HUzDeVNYwq0VeOhE380XLzv/5OGOHvxeZo9VcIOY1OknH+xYkOF035xEYybkBXXlmbfoiruP59NMqJqpkpBgVE5ndmA2d4BS9/r9R1erOXqgiX0F/WfS8hGS67hNuuQoQQJsk2XpuB/W/IRhGvltnInTmLf45Ulm+bGYa6RqbtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753743235; c=relaxed/simple;
	bh=YhCqEiOEnvrAEeYIVHZlET6clIv1cNi6eIqYJBi9dMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B/hzS89W9mxAuqwSCCGw3vDm8esQXLOeAIZiRllig2cwflTHGggqvd+XGAOHGXqrJbfjILEFaQuTgn5EYaunHnz3EAWyGTUD4AaDfi2qgREF0HtnUK5En5Qf4beczzyyWNFujsmnC6JtS8Wzix3FbeaMHUhAnBVU9NVlEnl3ZHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AjRfhMAu; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4ab86a29c98so115641cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 15:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753743233; x=1754348033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z4Qt12vqG6j3Vgncu41uP3H99WwAJYr2jwWzpmpk2jg=;
        b=AjRfhMAujALYgLC4wtGpPSEwqRNYRSpaFGvvjU7AO68oBV0jw+i+X4pYo7qs8o1pUD
         2J1a9B4mG3R9OhPMqiC+BVEi5x6mHv96trev/5XqrxneQvzZAXOULGtcESvtr1+MKKYq
         6F+dQ/sfBf8lQRCidtMDQLrnTvtLcikD7u4uRkTBhxrqZ6kBMmuC4wC/zgwHyfYVlMQY
         WVbN50ZKrnjiqXeal5zFm4jBzxf745wwbYA0jq9x2oIGXkhbPu81OR3C/A4jSuYR6tE5
         New2SiJOykPFh7PO+GbVp71SCs2klPqaxVGGmTa993//3jg9OeFyheeRHYj9JA7vmaK/
         bDiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753743233; x=1754348033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z4Qt12vqG6j3Vgncu41uP3H99WwAJYr2jwWzpmpk2jg=;
        b=dHOhHSNa6JU+TqqUOnQ2jCxA7WH810UlojC5sAjO0YelTPeikcu4sclfnZGy7hVGVB
         JFnTIVOLY1z0SdGaR0a5I+d6YS3D2aWy46hm5OFn0tp96kdwDfBFHHKdDT3ypqWrVpzV
         K1nCJTHI8MPqLBoxarSziwfFjrOLzocCs4aj19KeHVtIjQYhHE933lf2G0mPN09s8ntU
         I1OfAMZHFKJUV4Dy2NKJtwj4upa+jh9SYNy2lFfITbn2kMDYMnLLKenIRxNaMxOJwM1Y
         PgBLKG+a+1iG2h16Z6ZtEjAl6sE0i/GfU10syotWrUs/KrtEWD5f1R0WQMgX3vaws88v
         fkdg==
X-Forwarded-Encrypted: i=1; AJvYcCUm752pyM2VZ28qlCVMIcF49BcnyprhCStqel8b8gEfvQU2O9eAZ3d+bCYv/+C419NCgyl2CiCnsJG2r4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGx3+J4lVvmoVm4ZuK4KpeBhMc3iCzPWGWDZOEXZc61CSB/dwZ
	AMcavrJ/kUMAWwa/AnNlYUK8KIfIA/zgdIDFQQcswbE7E4l4DryIo/xFAtAKN1QzdubAYO6kdGs
	YJQKp6ruHOoHSOjPS4SpM+HesdiQ06qhXuMClIrgb
X-Gm-Gg: ASbGncvO+etJgGfh8hb8SNELUy4/rZcQzw2RFAa1FsA5CyR237TahZt5Gnm3Ezugjif
	IPEBYUbCgbSUhcNXpjXR3TNPFQk9o+Ce5bmNLnjZtgtjj7Cg1ZDdZM2BBij2hffoGCxSPXEo5YR
	EmEBwY6CuQNSyQzyrUDhC7FwPIvOq/R7avcHyaMiu2CZqhijQBp2KMMGSZUhBhqttSR0Flb9A3o
	/TaGmJLr+JJzs+3d/tUHZa1YpuEmIfuZhEZMNLhvby4MA==
X-Google-Smtp-Source: AGHT+IGATSooD8GgEjASGSXd3OgOeRWrGHiPgkXjO2g/J75z5wCxzzWlwo3yh3PbhmnWOhAg0GHBVwvm9kJx3eRxq08=
X-Received: by 2002:ac8:580b:0:b0:479:1958:d81a with SMTP id
 d75a77b69052e-4aecda09537mr1715651cf.6.1753743232125; Mon, 28 Jul 2025
 15:53:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250728175355.2282375-1-surenb@google.com> <197389ce-9f42-4d6a-91c4-fce116e988b4@suse.cz>
In-Reply-To: <197389ce-9f42-4d6a-91c4-fce116e988b4@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 28 Jul 2025 22:53:41 +0000
X-Gm-Features: Ac12FXzf7uyrUFgvW6_WolevPBj5eXWmthBTkEGcLn2Bxpz2kQtaKNbJdU9mnS4
Message-ID: <CAJuCfpFzxCayf083d35dS7Py0AK-CSr3H=_mymP9yXcyWzOqPQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm: fix a UAF when vma->mm is freed after
 vma->vm_refcnt got dropped
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, jannh@google.com, Liam.Howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, pfalcato@suse.de, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025 at 10:04=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> w=
rote:
>
> On 7/28/25 19:53, Suren Baghdasaryan wrote:
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
>
> As for further steps, considered replying to [1] but maybe it's better he=
re.
>
> As for a KISS fix including stable, great. Seems a nice improvement to
> actually handle "vma->vm_mm !=3D mm" in vma_start_read() like this - good=
 idea!
>
> Less great is that there's now a subtle assumption that some (but not all=
!)
> cases where vma_start_read() returns NULL imply that we dropped the rcu
> lock. And it doesn't matter as the callers abort or fallback to mmap sem
> anyway in that case. Hopefully we can improve that a bit.
>
> The idea of moving rcu lock and mas walk inside vma_start_read() is indee=
d
> busted with lock_next_vma(). The iterator difference could be perhaps sol=
ved
> by having lock_vma_under_rcu() set up its own one (instead of MA_STATE) i=
n a
> way that vma_next() would do the right thing for it. However there would
> still be the difference that lock_next_vma() expects we are already under
> rcu lock, and lock_vma_under_rcu() doesn't.
>
> So what we can perhaps do instead is move vma_start_read() to mm/mmap_loc=
k.c
> (no other users so why expose it in a header for potential misuse). And t=
hen
> indeed just make it drop rcu lock completely (and not reacquire) any time
> it's returning NULL, document that and adjust callers to that. I think it=
's
> less subtle than dropping and reacquring, and should simplify the error
> handling in the callers a bit.

Thanks for the suggestion. That was actually exactly one of the
options I was considering but I thought this dropping RCU schema would
still be uglier than dropping and reacquiring the RCU lock. If you
think otherwise I can make the change as you suggested for mm-unstable
and keep this original change for stable only. Should I do that?

>
> [1]
> https://lore.kernel.org/all/CAJuCfpEMhGe_eZuFm__4CDstM9%3DOG2kTUTziNL-f%3=
DM3BYQor2A@mail.gmail.com/
>
> > ---
> > Changes since v1 [1]
> > - Made a copy of vma->mm before using it in vma_start_read(),
> > per Vlastimil Babka
> >
> > Notes:
> > - Applies cleanly over mm-unstable.
> > - Should be applied to 6.15 and 6.16 but these branches do not
> > have lock_next_vma() function, so the change in lock_next_vma() should =
be
> > skipped when applying to those branches.
> >
> > [1] https://lore.kernel.org/all/20250728170950.2216966-1-surenb@google.=
com/
> >
> >  include/linux/mmap_lock.h | 23 +++++++++++++++++++++++
> >  mm/mmap_lock.c            | 10 +++-------
> >  2 files changed, 26 insertions(+), 7 deletions(-)
> >
> > diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> > index 1f4f44951abe..da34afa2f8ef 100644
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
> > @@ -183,6 +184,28 @@ static inline struct vm_area_struct *vma_start_rea=
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
> > +             /* Use a copy of vm_mm in case vma is freed after we drop=
 vm_refcnt */
> > +             struct mm_struct *other_mm =3D vma->vm_mm;
> > +             /*
> > +              * __mmdrop() is a heavy operation and we don't need RCU
> > +              * protection here. Release RCU lock during these operati=
ons.
> > +              */
> > +             rcu_read_unlock();
> > +             mmgrab(other_mm);
> > +             vma_refcount_put(vma);
> > +             mmdrop(other_mm);
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

