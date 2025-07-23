Return-Path: <linux-kernel+bounces-743147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B36B0FB2A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 21:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 500061CC08FE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 19:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5133D229B21;
	Wed, 23 Jul 2025 19:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V+0pYH0h"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3BE22FAFD
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 19:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753300401; cv=none; b=MJgrQq9TscpFpYGSRH0Pg6G5L8AecR+78S0LihP+K42QzftgG+eeOGqBvWCmMEXJuM1alcivGeF9XG0ThqFnK1DKULtQIjkXYiR/ZvNY5FV/I7vs7/bsCBIelTFDdAORAuYWNyeYnriMYRTESSfIuvbjmPb0g8hjdBoBiPwsLhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753300401; c=relaxed/simple;
	bh=+tFh962v8sYhok4cVRelwItYZlJghinDgEuVc6mAJxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bQRIGaIcePLPycnNTYenaIwdEu3c49OMZomsr0cpkupLMcO94+ZsgBRlG05YkRBqe8OEYJJ2tQnpbg4utbhXxlc7VcRLD7Esj782T0+P9gbrMPgifUPk9jqAZlofsgODlo/xcfF/+lL6sgHpjnt/h5ugoyIXSzr09fdQPK3iU1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V+0pYH0h; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5f438523d6fso416a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 12:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753300398; x=1753905198; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3bnpcnE1fkwQyW3rhyr9hOHNwso9We4QMT1uHZvBtss=;
        b=V+0pYH0hLPhoOl94KDGyjsZILz3tcNjBQt7oA3Bboy3wrt3xCeuEtINQc4lTwVtf+Y
         gHS2fUGbMvLkKU7pFNRSazRGqJsxO3Ga14yxnGZCMKRUsM6UfewnxyzLkwL0sI/QNel7
         HtkaUw9SddS82IPEPLXUP7nkVcpaNuNpIY6X3eO+eA/2HKslY2ejwftwhnwl39hZxbKa
         wcHpxnL7qEcXOfNJSlAAQwfDoQ3mLkoH83FSWkNLDdVDeO23zu5SNtcLuER0+z+74ZXz
         wPr2/VcAtnsxY9yBnKesIJfEACwv14ZROjP3MRyaHd5g3kMs24gkfoRKQuyEILo5GPtj
         n7ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753300398; x=1753905198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3bnpcnE1fkwQyW3rhyr9hOHNwso9We4QMT1uHZvBtss=;
        b=sEtW/sLl9CjvqxtXB6s5HGmIgVOKmVHmkmRCydZJrDM+CzQ0++WsNPVCTvxlvBUV2G
         UjE08NykpuCPn6GLK8Xv+07pY873SD/ysKqDv5o4QfpPCJwhbT77LZIyiqhkUKBXwUMI
         yLh9c2HuSC1ylPQYSv8DPPfeMpGJUkEPODEG25S6JmM41/8UymjQEP2zBlrkb+eeaaKU
         V5SSHXV6ubs2WEXrEvh1zqYozkAXcMsSQKFW+N+4z5pdJk4VOfxpebSwyzfwN26Z1T2g
         pvREnyc1HTjZWdBcMvc5STJhp4v0jUH6ZifEH+RBimJOhgGsGM67awd70mfztRLVQsEq
         BkuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCENLDo4gPnHsO8dT/zFWFUSQ9Zo7mrLDcoOyFcngOWpFo1sfjVoaN9x8ccl6YdVWLzDuN6H0247zezYc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCkDHjHW8sG3x4cS50ST5YH8Bm5VKeD7peufGbSeDXINT5QIoM
	tlol2d5KGapHAd/gMKBrVb1GgtOn3ZffMv6m0+X0OtO9U1hTn4p1HCw3e6NBxpuprZN70gcm5Q1
	U0FSksU5IYCc2ki6Ilxul18rveqx7+CRA6Cz8yenm
X-Gm-Gg: ASbGncs4aSylckl0EkY1ktvkZpvUnERDJ/40rJ/e+ueHsWWsibvvZe+i1iRUhGCGPIH
	x0nK4dWaSKs4PbsQV8rEnuLzg1JM0tHw/+VJ/BcNudOz2xSIdnbGMNQIyiB7FR55JnbwOs4v+sZ
	xJJuVI7jZD7T33CwKjb4SIVZ92gONohXl8E6Mhhcl/sktshgwn0biniQASM3zcINPwxomFzYSpD
	S0LiPNhchk6MGqGSE0fdjz84NlN1ZvRlpE=
X-Google-Smtp-Source: AGHT+IEpUE9GYvSLtb7w3d/O+eozi8+DViR6ZZEdPliTC+wgOSS818919CJlmXbVLWW4EIEGd+NJv6m8e+Vvpdp5io8=
X-Received: by 2002:a05:6402:290e:b0:60e:5391:a9e5 with SMTP id
 4fb4d7f45d1cf-614c50e54camr9355a12.5.1753300397200; Wed, 23 Jul 2025 12:53:17
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG48ez0-deFbVH=E3jbkWx=X3uVbd8nWeo6kbJPQ0KoUD+m2tA@mail.gmail.com>
 <16c97e30-19c9-41e8-b73b-c0b3c8eceff3@suse.cz> <CAG48ez1qhjQNHC+3572udqVWHTANFpQ0ngxn_4ZDC9F8NCXsFA@mail.gmail.com>
 <c53b22c3-9f7f-4793-9d10-f4df861a3e32@suse.cz> <CAG48ez2cGX3e5bqgcw0OEnho29+YhwG2eOrHRgNwGAA_Nb65nw@mail.gmail.com>
 <28e1fc65-995c-4185-b5c2-7eb001312698@lucifer.local>
In-Reply-To: <28e1fc65-995c-4185-b5c2-7eb001312698@lucifer.local>
From: Jann Horn <jannh@google.com>
Date: Wed, 23 Jul 2025 21:52:41 +0200
X-Gm-Features: Ac12FXwPWJF6R7SG9BtZJpb2I9YFfCkUYHPki1cbGvCKwCZKU_i67BSwznUK6t8
Message-ID: <CAG48ez0KE9bfFJ+yAMPUAj=_hcNRfes3=nfQd7Rv95TSnHtUCg@mail.gmail.com>
Subject: Re: [BUG] hard-to-hit mm_struct UAF due to insufficiently careful
 vma_refcount_put() wrt SLAB_TYPESAFE_BY_RCU
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, Linux-MM <linux-mm@kvack.org>, 
	kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2025 at 8:39=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
> On Wed, Jul 23, 2025 at 08:19:09PM +0200, Jann Horn wrote:
> > On Wed, Jul 23, 2025 at 8:10=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz=
> wrote:
> > > On 7/23/25 19:49, Jann Horn wrote:
> > > > On Wed, Jul 23, 2025 at 7:32=E2=80=AFPM Vlastimil Babka <vbabka@sus=
e.cz> wrote:
> > > >> On 7/23/25 18:26, Jann Horn wrote:
> > > >> > There's a racy UAF in `vma_refcount_put()` when called on the
> > > >> > `lock_vma_under_rcu()` path because `SLAB_TYPESAFE_BY_RCU` is us=
ed
> > > >> > without sufficient protection against concurrent object reuse:
> > > >>
> > > >> Oof.
> > > >>
> > > >> > I'm not sure what the right fix is; I guess one approach would b=
e to
> > > >> > have a special version of vma_refcount_put() for cases where the=
 VMA
> > > >> > has been recycled by another MM that grabs an extra reference to=
 the
> > > >> > MM? But then dropping a reference to the MM afterwards might be =
a bit
> > > >> > annoying and might require something like mmdrop_async()...
> > > >>
> > > >> Would we need mmdrop_async()? Isn't this the case for mmget_not_ze=
ro() and
> > > >> mmput_async()?
> > > >
> > > > Now I'm not sure anymore if either of those approaches would work,
> > > > because they rely on the task that's removing the VMA to wait until=
 we
> > > > do __refcount_dec_and_test() before deleting the MM... but I don't
> > > > think we have any such guarantee...
> > >
> > > I think it would be waiting in exit_mmap->vma_mark_detached(), but th=
en
> > > AFAIU you're right and we'd really need to work with mmgrab/mmdrop be=
cause
> > > at that point the  mmget_not_zero() would already be failing...
> >
> > Ah, I see! vma_mark_detached() drops its reference, then does
> > __vma_enter_locked() to bump the refcount by VMA_LOCK_OFFSET again
> > (after which the reader path can't acquire it anymore), then waits
> > until the refcount drops to VMA_LOCK_OFFSET, and then decrements it
> > down to 0 from there. Makes sense.
>
> Sorry, this is really my fault because I didn't closely follow the
> reimplementation of the VMA locks closely enough and so am a little behin=
d
> here (I'll fix this, probably by documenting them fully in the relevant d=
oc
> page).
>
> So forgive me if I"m asking stupid questions.
>
> What exactly is the issue with the waiter not being triggered?
>
> I see in vma_mark_detached():
>
>         /*
>          * We are the only writer, so no need to use vma_refcount_put().
>          * The condition below is unlikely because the vma has been alrea=
dy
>          * write-locked and readers can increment vm_refcnt only temporar=
ily
>          * before they check vm_lock_seq, realize the vma is locked and d=
rop
>          * back the vm_refcnt. That is a narrow window for observing a ra=
ised
>          * vm_refcnt.
>          */
>
> So, if this is happening at the point of the unmap, and we're unlucky eno=
ugh to
> have some readers have spuriously incremented the refcnt before they chec=
k
> vm_lock_seq, we trigger __vma_enter_locked() and wait on other VMAs to
> vma_refcount_put() to wake it up vai rcuwait_wake_up() if the refcount is=
 still
> raised (which it should be right?)

I'm not sure if I'm understanding you correctly; but yes,
__vma_enter_locked() waits for all the waiters to drop their
"refcounts". (It's not really a refcount, you can also think of it as
a sleepable read-write lock where the low bits are the number of
readers.)

> So actually are we going to be left with readers sat around waiting forev=
er? If
> the scenario mentioned happens?

I'm not sure I understand the question. Readers don't wait, they bail
out if they hit contention and retry with the mmap lock. As far as VMA
locks are concerned, readers basically always trylock, only writers
can wait.

> If we make the rando mm we are now referencing stick around, aren't we ju=
st
> spuriously triggering this thing while potentially leaving actual waiters
> waiting?

In that case, the thing we've read-locked is not part of the MM we
were trying to operate on, it is part of the rando other VM, so the
writers we've blocked are also part of the rando other VM, and so the
rando other VM is where we have to do a wakeup.

> I may be completely misunderstanding here...

