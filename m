Return-Path: <linux-kernel+bounces-743080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C06DB0FA4C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 20:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA4491C872E6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 18:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA873131E2D;
	Wed, 23 Jul 2025 18:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UIfWEmIz"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403B22E36FD
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 18:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753295472; cv=none; b=peEEkZa918UQOwUzZb+sxF5M9Pn5KTZm/IvHd1j7FkT8xSHWY7WuBXZ8qMQgwNfE6WEvngadB7pV5No4ajZSvpJ2THvqUF0u+ghRXvHtfl/UE84ZbLARzFbBR8uUTQAxtvoN7Frn40BjAXrEsy9wtv+HaYemjeGawkTZlNNLYm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753295472; c=relaxed/simple;
	bh=TV/ryN8zpn8oHOu6b24EXS0+/+bBmhsI7LdNHcW/SgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cW5b8AixCkSNSwN6PHAJLtxJMd/8t1/qysUCnAzd+oh0uhx7KVxhn5SWhcExNOprodlyxDzQotIgzonR4iPFgC6VqeHNZfei9ma3DWy910Pefw3yUlujcLAKOiDQUU13vwyylkOzWevew7WngZLQ0da1Wpj6fdk4+U8CsYJO/vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UIfWEmIz; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-609b169834cso1944a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 11:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753295468; x=1753900268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PxdQ/2scAxyhDcmRUHh4GMEXZ+h/aTnjT/f58sFEb/0=;
        b=UIfWEmIzEBpmgR6PMuZ7ypJCkWS0Tr0An9XWMnM12bceRxb1btzrS08NPLwm6ChHMH
         WGoDdf/oQN65HTIp1DzgcctGa8O/NZMd1bQZx0khcN4x3NMGHtIAcfl0dlnOld5i1O1g
         eD1MYhKcwBQ4+iBOUgrF9iXsSWaqnuT+iPlXZtIuoFEUprEPxiYV+rMm4AnWeElIe2ih
         6eEp5DRghhQOGhOa085/OI1LcvW+KOoA3ICSbrROCTcAiqTz1UFV42BSj2tPlbZpkUSI
         IXYey1lpQLylXuN4g1Zx6Fy62eMyhw/u18UtgqNrxEe6SYnaPcLx/8kepxP/A+ITnYrv
         Uv6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753295468; x=1753900268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PxdQ/2scAxyhDcmRUHh4GMEXZ+h/aTnjT/f58sFEb/0=;
        b=T7phf8ag2UxgSzAT+GnHL9Rm/0QDxno0GZSoyCA67mRI2m1HPUAdsIapljP4IadO7l
         on2fiGCCsv2C8qd9wrclOWdUFhSUxrDZKEOzxqlzglUHctBcj7ew4/OUzfprmDCnEBMq
         oGu82DKSi3jAp12eopcSOiDIDgbDC0QkUSYGxCNrsKjWgR4TjkujkYuepMY+HbvpY5GB
         tW8HqEx5lRlj24ME48oAndPdXmSk80HJP4pDF2gG3tftjXCNr0HtR9oXcoTH38zn9vv3
         JF5RlTdIKDh5s1Qx4NCxiCMJ7k3hObZQYey/6rcUt/heZ2nx8U08MsyfoMEUhVpCYLxp
         w8XQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGcj0IrrUxsnPq3J8X3O8L2WFWVDCmM2K2DkDhV9/EMGpv7C7x+UTM3QgHj5Ymvd5jyNHCBlc635xAKNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCRjbDJbvRZbpdKQU0T2+Vk5pxyuT6bcss8j38oV7assuSjQVo
	IGJ1o6pAG24mUu/nNQfu9+6s9BjumT3SWBzJHMMeJE85eg7RdEQcDkM+BUhKgDojxPnV8u23lBo
	d3M1PCa4P/Ni8iP1WgiS96yI02crDfkwobq6DqRDi
X-Gm-Gg: ASbGncutvdDF2RL1bi8TfFA1dNoyNTaIEbqM0xcLSEjg4/+juXvoSYOAtG8z03nhwwS
	XBW1FMTReS26CRflgESmbMktJEpB2x6CvpuanUFG/19g2M76RPifKbrSDd4UwYWicmbFIO8taay
	BQ8R10UoyOMjuC5IDEamwdsUh6WQXJAv7MeJh7bqLkVhteMcavk2RTf1FsqGdHXUZA93M+M4E8Q
	yz5rznitMXHKQgBbig0+hrLIhS6r88FJko=
X-Google-Smtp-Source: AGHT+IFrP5YlrTclJr4hnQq4xu1KXB4Tzina61Zi3tUWZhFyV8bZGBSC09/EiVrv02o5c3QT1Qvs43q/HqOY+cnRl9M=
X-Received: by 2002:a05:6402:1c94:b0:60e:2e88:13b4 with SMTP id
 4fb4d7f45d1cf-614c50ca843mr2659a12.3.1753295467875; Wed, 23 Jul 2025 11:31:07
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG48ez0-deFbVH=E3jbkWx=X3uVbd8nWeo6kbJPQ0KoUD+m2tA@mail.gmail.com>
 <6df9812c-96a5-41be-8b0e-5fff95ec757c@lucifer.local>
In-Reply-To: <6df9812c-96a5-41be-8b0e-5fff95ec757c@lucifer.local>
From: Jann Horn <jannh@google.com>
Date: Wed, 23 Jul 2025 20:30:30 +0200
X-Gm-Features: Ac12FXxNoJl69yJqOiOLuD0JUEmbVCZC18OJvmewyPdVImEJfUHr0S8XmycP6Gw
Message-ID: <CAG48ez1A17JC7Q35jmurY+Co0t_a78bPy9eRWRim7xJy9oLCvA@mail.gmail.com>
Subject: Re: [BUG] hard-to-hit mm_struct UAF due to insufficiently careful
 vma_refcount_put() wrt SLAB_TYPESAFE_BY_RCU
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, Pedro Falcato <pfalcato@suse.de>, 
	Linux-MM <linux-mm@kvack.org>, kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2025 at 8:14=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
> On Wed, Jul 23, 2025 at 06:26:53PM +0200, Jann Horn wrote:
> > There's a racy UAF in `vma_refcount_put()` when called on the
> > `lock_vma_under_rcu()` path because `SLAB_TYPESAFE_BY_RCU` is used
> > without sufficient protection against concurrent object reuse:
> >
> > lock_vma_under_rcu() looks up a VMA locklessly with mas_walk() under
> > rcu_read_lock(). At that point, the VMA may be concurrently freed, and
> > it can be recycled by another process. vma_start_read() then
> > increments the vma->vm_refcnt (if it is in an acceptable range), and
> > if this succeeds, vma_start_read() can return a reycled VMA. (As a
> > sidenote, this goes against what the surrounding comments above
> > vma_start_read() and in lock_vma_under_rcu() say - it would probably
> > be cleaner to perform the vma->vm_mm check inside vma_start_read().)
> >
> > In this scenario where the VMA has been recycled, lock_vma_under_rcu()
> > will then detect the mismatching ->vm_mm pointer and drop the VMA
> > through vma_end_read(), which calls vma_refcount_put().
>
> So in _correctly_ identifying the recycling, we then hit a problem. Fun!
>
> > vma_refcount_put() does this:
> >
> > ```
> > static inline void vma_refcount_put(struct vm_area_struct *vma)
> > {
> >         /* Use a copy of vm_mm in case vma is freed after we drop vm_re=
fcnt */
> >         struct mm_struct *mm =3D vma->vm_mm;
>
> Are we at a point where we _should_ be looking at a VMA with vma->vm_mm =
=3D=3D
> current->mm here?

Well, you _hope_ to be looking at a VMA with vma->vm_mm=3D=3Dcurrent->mm,
but if you lose a race it is intentional that you can end up with
another MM's VMA here.

> Or can we not safely assume this?

No.

> Because if we can, can we not check for that here?
>
> Do we need to keep the old mm around to wake up waiters if we're happily
> freeing it anyway?

Well, we don't know if the MM has already been freed, or if it is
still alive and well and has writers who are stuck waiting for our
wakeup.

> If not, then surely we can just do this check, and not do the wake up if
> false?
>
> I may be mising something or being stupid here so :P
>
> >         int oldcnt;
> >
> >         rwsem_release(&vma->vmlock_dep_map, _RET_IP_);
> >         if (!__refcount_dec_and_test(&vma->vm_refcnt, &oldcnt)) {
> >
> >                 if (is_vma_writer_only(oldcnt - 1))
> >                         rcuwait_wake_up(&mm->vma_writer_wait);
> >         }
> > }
> > ```
> >
> > This is wrong: It implicitly assumes that the caller is keeping the
> > VMA's mm alive, but in this scenario the caller has no relation to the
> > VMA's mm, so the rcuwait_wake_up() can cause UAF.
>
> Oh yikes. Yikes yikes yikes.
>
> >
> > In theory, this could happen to any multithreaded process where thread
> > A is in the middle of pagefault handling while thread B is
> > manipulating adjacent VMAs such that VMA merging frees the VMA looked
> > up by thread A - but in practice, for UAF to actually happen, I think
> > you need to at least hit three race windows in a row that are each on
> > the order of a single memory access wide.
>
> Hmm ok this is confusing, below you reference threads by number with
> letter=3Dprocess, and here you say thread 'A' and "B'.

Ah, yeah, sorry.

> > The interleaving leading to UAF is the following, where threads A1 and
> > A2 are part of one process and thread B1 is part of another process:
>
> Err but you refer to A1, A2, A3 below, should A3=3DB1?

... clearly I should have proofread this more carefully. Yes, A3 should be =
B1.

>
> > ```
> > A1               A2               A3
> > =3D=3D               =3D=3D               =3D=3D
> > lock_vma_under_rcu
> >   mas_walk
> >                  <VMA modification removes the VMA>
> >                                   mmap
> >                                     <reallocate the VMA>
> >   vma_start_read
> >     READ_ONCE(vma->vm_lock_seq)
> >     __refcount_inc_not_zero_limited_acquire
> >                                   munmap
>                                    ^
>                                    |
>                                    OK so here, we have unmapped and
>                                    returned VMA to the slab so
>                                    SLAB_TYPESAFE_BY_RCU may now result in
>                                    you having a VMA with vma->vm_mm !=3D
>                                    current->mm right?

Yes. The VMA is unmapped and returned to the slab at the "<VMA
modification removes the VMA>" in A2 above, and then reallocated when
B1 does "mmap".

> >                                     __vma_enter_locked
> >                                       refcount_add_not_zero
> >   vma_end_read
> >     vma_refcount_put
>       ^
>       |
>       Then here, we're grabbing process
>       B's mm... whoops...

Yeah.

> >       __refcount_dec_and_test
> >                                       rcuwait_wait_event
> >                                     <finish operation>
>                                       ^
>                                       |
>                                       Then here, the VMA is finally
>                                       freed right?

Yeah.

> >       rcuwait_wake_up [UAF]
>         ^
>         |
>         And then here we try to deref freed mm->vma_writer_wait
>         and boom.

Yeah.

> > I'm not sure what the right fix is; I guess one approach would be to
> > have a special version of vma_refcount_put() for cases where the VMA
> > has been recycled by another MM that grabs an extra reference to the
> > MM? But then dropping a reference to the MM afterwards might be a bit
> > annoying and might require something like mmdrop_async()...
>
> This seems a bit convoluted... And I worry about us getting the refcount
> stuff wrong somehow, we'd have to be very careful about this to avoid
> leaking VMAs somehow...

FWIW, the slow and boring solution would be to use wake_up_var() and
wait_var_event(), but those might be too slow for this usecase.

