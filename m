Return-Path: <linux-kernel+bounces-743138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1798B0FB1B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 21:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ED3F963D75
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 19:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F63221DB7;
	Wed, 23 Jul 2025 19:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r8XcIPEs"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F405821D3DF
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 19:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753299855; cv=none; b=NBbVN0zD+Oob4vXrwjpV1WU/2l4DIb5LcSd9xgvdCf9vBr++caiimbM7IVNO2lfl6PB1/JWN93DgUq9VxQaBs5jvOu+PH3CL2tw1XC0+CbtuHpTkHJgoJECYop7wfIf2q8cPSSZq15w/fvLwjVon9KSF3ieiMNv2YGYE66csLII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753299855; c=relaxed/simple;
	bh=y1HShGMBKQcICWb2rFyvVR7qFhlkvF5vzKQKZ+LM+Tc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gtkV1vnEr8jBts2iIj8u8pNs7ZrPaAdwvCG4Uw957Zn8rLF30RGguJ3ZtBRfMsd+5TlWxOtKkTXvtr02OmG86FysuQymsaOc7XseDfX1jlgKu0SvRd7a7B3QP1YwbpEMz5FFNNG3L+4c6ZzLMBv/QbpOwT/x746tjyY1YUzTsso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r8XcIPEs; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-611d32903d5so2348a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 12:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753299852; x=1753904652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XaN1WGDKQHaiwhr4TxEnHlfmCKQPYHCZzOv+G3IA8EE=;
        b=r8XcIPEsT+GpEgMohx77pz4mjvBO7xxx3LmJPw6Ln1PZ4Dr42wHKHfCzT4tH6PM8sv
         2TBXcRa/hHLFBJ7YmVtneWRh/3B6Ub+UNgs7HUoaWKV4EzQkWiSmaUzZ3HRgoux4bFc8
         w1NmeRK0yl9cuF9nXNAAY72LbXzcf6VTpJ2/S/lOntIWf2jN8HtrTf5qTQw676oyiX32
         yi2PXps1hIp8+GfaDEKZ/BiR1XzEdNK6EAlPdBkDLAzhn1Ra8lDkgrgJe50CmAgQk4eF
         REecaL8ZKfwGCJ6AOD8tMjCoRtIYg/p5KMKX4mQSuRZ4eOXMRZ8yqX6ShXdvzHjzBYYF
         7f8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753299852; x=1753904652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XaN1WGDKQHaiwhr4TxEnHlfmCKQPYHCZzOv+G3IA8EE=;
        b=gHcK040xYk7kAaIGzkghK4ISo89xUSABN+qCGvrYbA/xEdKsW9v3ckciBZLgfm+JLe
         MULWnyk5uLXE3d9snva5Vp9tJYHsMyZRZfA4feg0J/nmqiya1ykpa4IrqCwJfh4DJhJW
         CS3Z8DkbEtNiLHjbrDUJGJDFtirMqZ+S0fgbeIcxzwfVAoayzI24TQ/X3hrCZNYfIdSj
         4bIjyz+jCpgeGi80OIsJ4tEJLz0tG7NoIbuzatL5aLq3b/6z+ZN5BQ/SIt0RhCimVxtb
         bWmo05azHFV1juuPl1LyixfPt3wzDmy1pDWKOub+hnRSnjvr4py5kgdKhFrCE5Yj/mlT
         Vi9w==
X-Forwarded-Encrypted: i=1; AJvYcCWEt/5yqMz5fh/ihm95RYfF4u/bT+usQUSu1erdVCnNJjlhEM21PCiuQ+x9mhDSo+j2lVVCxxPLLNa327g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0jHlIaI6iAMea/leqIXviQhLYyhSHC3jJJlmY57mIkoNG+5+X
	lEI1xvzSe07czCOxO9o/0RFNWw3knoM6deKQGULSIu4ivnHCMga6+4MFUljnXIOisZCP5g+4TF7
	lqIs7e92PCyEUONfvRibFiWGGI00i3RKfKV1JtH9O
X-Gm-Gg: ASbGnctAGXCehx0W0TZ5gu4wF0E8SPc5nry+qj1X8dY/xMP/YXZWPXMP09nrSJmeBSj
	xUZXqXjR0UnAhdDYMkP9h8BE/KWPW59n+00QFUN1JN1BGblBREn3wGoWHkqoVhzdY5ae4Yruxon
	Ixo/iSqYpBvVpiCPG93Qhxs8E9Y0icAhLISCEHj9Z9f2Un2bgXTJS+hZ9cDdfDb1ZKQ/WrZ0UPr
	QKGsxobgh7tpyKY0AfSBfZLbMyJBhbgJVs=
X-Google-Smtp-Source: AGHT+IFMeqCitJD6jm1zqvi8Ttzy3WukgRxUcRQxmGCyWwc9SJ6vzxv4EsIqbCmMjDmLpqk2WxMCVB8xiYvHJZ/JAfg=
X-Received: by 2002:a05:6402:290e:b0:60e:5391:a9e5 with SMTP id
 4fb4d7f45d1cf-614c50e54camr8707a12.5.1753299851863; Wed, 23 Jul 2025 12:44:11
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG48ez0-deFbVH=E3jbkWx=X3uVbd8nWeo6kbJPQ0KoUD+m2tA@mail.gmail.com>
 <6df9812c-96a5-41be-8b0e-5fff95ec757c@lucifer.local> <CAG48ez1A17JC7Q35jmurY+Co0t_a78bPy9eRWRim7xJy9oLCvA@mail.gmail.com>
 <3a233a85-3a94-422e-87be-591f93acbac7@lucifer.local>
In-Reply-To: <3a233a85-3a94-422e-87be-591f93acbac7@lucifer.local>
From: Jann Horn <jannh@google.com>
Date: Wed, 23 Jul 2025 21:43:35 +0200
X-Gm-Features: Ac12FXxW2NJbsvvD76QaLD1QW0CpKWEf0udDddiz4nnxYVo6u6jF9RMz2kxQd3k
Message-ID: <CAG48ez36AcGBy8_wo09WEHz98Dp44yKZ_FiVtFt8tcV9WiHafA@mail.gmail.com>
Subject: Re: [BUG] hard-to-hit mm_struct UAF due to insufficiently careful
 vma_refcount_put() wrt SLAB_TYPESAFE_BY_RCU
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, Pedro Falcato <pfalcato@suse.de>, 
	Linux-MM <linux-mm@kvack.org>, kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry, while typing up this mail I realized I didn't have this stuff
particularly straight in my head myself when writing my previous mails
about this...

On Wed, Jul 23, 2025 at 8:45=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
> On Wed, Jul 23, 2025 at 08:30:30PM +0200, Jann Horn wrote:
> > On Wed, Jul 23, 2025 at 8:14=E2=80=AFPM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > > On Wed, Jul 23, 2025 at 06:26:53PM +0200, Jann Horn wrote:
> > > > There's a racy UAF in `vma_refcount_put()` when called on the
> > > > `lock_vma_under_rcu()` path because `SLAB_TYPESAFE_BY_RCU` is used
> > > > without sufficient protection against concurrent object reuse:
> > > >
> > > > lock_vma_under_rcu() looks up a VMA locklessly with mas_walk() unde=
r
> > > > rcu_read_lock(). At that point, the VMA may be concurrently freed, =
and
> > > > it can be recycled by another process. vma_start_read() then
> > > > increments the vma->vm_refcnt (if it is in an acceptable range), an=
d
> > > > if this succeeds, vma_start_read() can return a reycled VMA. (As a
> > > > sidenote, this goes against what the surrounding comments above
> > > > vma_start_read() and in lock_vma_under_rcu() say - it would probabl=
y
> > > > be cleaner to perform the vma->vm_mm check inside vma_start_read().=
)
> > > >
> > > > In this scenario where the VMA has been recycled, lock_vma_under_rc=
u()
> > > > will then detect the mismatching ->vm_mm pointer and drop the VMA
> > > > through vma_end_read(), which calls vma_refcount_put().
> > >
> > > So in _correctly_ identifying the recycling, we then hit a problem. F=
un!
> > >
> > > > vma_refcount_put() does this:
> > > >
> > > > ```
> > > > static inline void vma_refcount_put(struct vm_area_struct *vma)
> > > > {
> > > >         /* Use a copy of vm_mm in case vma is freed after we drop v=
m_refcnt */
> > > >         struct mm_struct *mm =3D vma->vm_mm;
> > >
> > > Are we at a point where we _should_ be looking at a VMA with vma->vm_=
mm =3D=3D
> > > current->mm here?
> >
> > Well, you _hope_ to be looking at a VMA with vma->vm_mm=3D=3Dcurrent->m=
m,
> > but if you lose a race it is intentional that you can end up with
> > another MM's VMA here.

(I forgot: The mm passed to lock_vma_under_rcu() is potentially
different from current->mm if we're coming from uffd_mfill_lock(),
which would be intentional and desired, but that's not relevant here.
Sorry for making things more confusing.)

> > > Or can we not safely assume this?
> >
> > No.
>
> What code paths lead to vma_refcount_put() with a foreign mm?

Calls to vma_refcount_put() from vma_start_read() or from
lock_vma_under_rcu() can have an MM different from the mm that was
passed to lock_vma_under_rcu().

Basically, lock_vma_under_rcu() locklessly looks up a VMA in the maple
tree of the provided MM; and so immediately after the maple tree
lookup, before we grab any sort of reference on the VMA, the VMA can
be freed, and reallocated by another process. If we then essentially
read-lock this VMA which is used by another MM (by incrementing its
refcount), waiters in that other MM might start waiting for us; and in
that case, when we notice we got the wrong VMA and bail out, we have
to wake those waiters up again after unlocking the VMA by dropping its
refcount.

> I mean maybe it's an unsafe assumption.
>
> I realise we are doing stuff for _reasons_, but I sort of HATE that we ha=
ve
> put ourselves in a position where we might always see a recycled VMA and
> rely on a very very complicated seqnum-based locking mechanism to make su=
re
> this doesn't happen.

Yes, that is pretty much the definition of SLAB_TYPESAFE_BY_RCU. ^^
You get higher data cache hit rates in exchange for complicated "grab
some kinda stable object reference and then recheck if we got the
right one" stuff, though it is less annoying when dealing with a
normal refcount or spinlock or such rather than this kind of
open-coded sleepable read-write semaphore.

> It feels like we've made ourselves a challenging bed and uncomfy bed...
>
> >
> > > Because if we can, can we not check for that here?
> > >
> > > Do we need to keep the old mm around to wake up waiters if we're happ=
ily
> > > freeing it anyway?
> >
> > Well, we don't know if the MM has already been freed, or if it is
> > still alive and well and has writers who are stuck waiting for our
> > wakeup.
>
> But the mm we're talking about here is some recycled one from another
> thread?

The MM is not recycled, the VMA is recycled.

> Right so, we have:
>
> 'mm we meant to get' (which apparently can't be assumed to be current->mm=
)
> 'mm we actually got' (which may or may not be freed at any time)
>
> The _meant to get_ one might have eternal waiters. Or might not even need
> to be woken up.
>
> I don't see why keeping the 'actually got' one around really helps us? Am=
 I
> missing something?

We basically have taken a read lock on a VMA that is part of the
"actually got" MM, and so we may have caused writers from that MM to
block and sleep, and since we did that we have to wake them back up
and say "sorry, locked the wrong object, please continue".

