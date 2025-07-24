Return-Path: <linux-kernel+bounces-743446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF2CB0FEC9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 04:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B93B4189CFF3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 02:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDF519CD1B;
	Thu, 24 Jul 2025 02:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sDFjH802"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B42033991
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 02:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753324227; cv=none; b=LBBogmPFf65Rup6evoebiaAKZrNl8GIg/vRA0enMc2Y01gC1PvHW0XBHPa4JHER+Hbw/0/zJMMnR/UBQT1gqBc2W6X2lZK5gQ/XYvFSlMUfdshg7IH1Tic3jvW4pWtRIKYXRihU0P5WvfX0t28O7iOiyRWjpNzPRZ5g+Rw726i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753324227; c=relaxed/simple;
	bh=gSk78ja8YBz8UyoGhB7h7sPq5u+e8kKC0A+x7KB3xxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dk/GhgvfI2jgoFlcCFfF2B4WXiQv+/Sirv1oV0/uWgTfoBCSZxFdi9uYXFchlHSY63knCIezI8x+YmFX9t7a68vNymF0c/e+muEN1Jrsiz0NTSE4Fu09UO+yz1EHDAIXsn3ywu6La1fDwjjlxlhYDlL1jBbRM2mjYmprGPQuV5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sDFjH802; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4aaf43cbbdcso75211cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 19:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753324224; x=1753929024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uhz9gu0FksG/+3WQimJkdZ69HI0pSq+ZcmQhr+seIE4=;
        b=sDFjH8026FbS5c/RZd+F1bULkmjPKyppezZWPJR7m0f1azRj0HvYKiksroVq3mfzry
         VK9hBHrFFvtWFwAWJW/NNHMWcbRwkm2nlh2Gx4LtOoqJPGOB8qWbzYwKm4GUYUosp7aw
         oLzcuiou1HJn7ICkS9ZDqS2VuNc0tqZUYUOsYjF/eCwcYfepR9vKbAi0HGUwgHfNOIAT
         xGr/AUkbxyoEIVS73ZTKHkti5IdDSsiTfMfybO1NkvgcQf95ZX2ylbcm1gdwymFFsQUV
         gtbvdG9yCQTcIXPKXFrhn0z7vG1EfbZiYsMR3hLyArWtiGfHMeCfXkG2aabyUp2L72TH
         Z7TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753324224; x=1753929024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uhz9gu0FksG/+3WQimJkdZ69HI0pSq+ZcmQhr+seIE4=;
        b=ezeg0eu724+1CTRrtNrpVjJ89Y4OqNU9Kehoinr3CTpvkbQOh8IphLMgjOtuWK0JsQ
         DuFMmDkdzfzfOamEe9kq8CQyiaVa5OhkJU0mkpxPEd8g/NsvvRz0el2EgqQ820i/DUZq
         M2W8ja62vJVIdZKvBdFP58zgB4nsmEqp5XNAvZyt9/m14LXR66F/oSlGqblSZ0zwoh/p
         Wc8q60WXNkv5pZkTJOkWnpH6J9M12uH1dPx6o0idwwW5OqKVvZUbl+n936/KH/BFVABg
         MASLXF1OcpwyGMN6P9ElkLhg75swy6J0s8EgyCEo+uy19xqUf3m3HJx7M1iToWLPt4H/
         /kbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZHECEmf3nVyrU6B90Zd6QPLCgH+2ad8/Nnw3ch1qW2u46CxdNw1Jrz53do5VzVtwT334/gxE2AtvCNSc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy00aV0r+LaZRNNvO0FTs2bY2LVeEYU1TzHs0gl9AA8h/x/7ZX+
	z26ljGYx1OSPHAXZwukZzDkxW44xg57rz12DkFdgBhKcj9d1u53PEfOAJmEaOIqmEkBM2XsAkYh
	7pkxQSd7XcCsxIbpTgeEp1xjaK3hvJ+qzNavnfkr0
X-Gm-Gg: ASbGncvQzhGxtHtR8PzMd146qf2UNA/ohSl7eghihKiXKU4Ortt5RGHF0E7HkxRWXlj
	NAZek3g6GS+5LBQhmEN6yV0L0RTURIc9AAvWtJbyi9ZlAdS5x4TkDP32iZJMzKothRHRakW03p3
	zolvWM0qGELQ2P4bHFK1FWvE5PFnTtcPQuZxgJw9S7ErYQ7Pdyu1srI+SWlDnEqlPO/nEV7HIc1
	aDxvg==
X-Google-Smtp-Source: AGHT+IHVMaulNLvc1zx4yHy8Nrn3HmQ77Cxx1g7QWtcrSOk+YXAwyY9tZvc856DCkinY1MuvRX/I7RwuKWT45oc0RFQ=
X-Received: by 2002:ac8:7f95:0:b0:4a7:26d2:5a38 with SMTP id
 d75a77b69052e-4ae7e2aa1efmr1346841cf.19.1753324223595; Wed, 23 Jul 2025
 19:30:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG48ez0-deFbVH=E3jbkWx=X3uVbd8nWeo6kbJPQ0KoUD+m2tA@mail.gmail.com>
 <16c97e30-19c9-41e8-b73b-c0b3c8eceff3@suse.cz> <CAG48ez1qhjQNHC+3572udqVWHTANFpQ0ngxn_4ZDC9F8NCXsFA@mail.gmail.com>
 <c53b22c3-9f7f-4793-9d10-f4df861a3e32@suse.cz> <CAG48ez2cGX3e5bqgcw0OEnho29+YhwG2eOrHRgNwGAA_Nb65nw@mail.gmail.com>
 <CAJuCfpEcjH+W83At8WSkgzO=JvZmapg6dPaXmuSRS4ufhSha4w@mail.gmail.com>
In-Reply-To: <CAJuCfpEcjH+W83At8WSkgzO=JvZmapg6dPaXmuSRS4ufhSha4w@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 23 Jul 2025 19:30:12 -0700
X-Gm-Features: Ac12FXyGI_TL4rNat7nkeSuGaWk8u2SFNub6ULGRe-fj0opu2rcTQxU7ydZQeAc
Message-ID: <CAJuCfpHk_k5eVhAZTK=jJvES9311Hyo_YXxY-S56EAYSBuRVRQ@mail.gmail.com>
Subject: Re: [BUG] hard-to-hit mm_struct UAF due to insufficiently careful
 vma_refcount_put() wrt SLAB_TYPESAFE_BY_RCU
To: Jann Horn <jannh@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Pedro Falcato <pfalcato@suse.de>, Linux-MM <linux-mm@kvack.org>, 
	kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2025 at 1:27=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Wed, Jul 23, 2025 at 11:19=E2=80=AFAM Jann Horn <jannh@google.com> wro=
te:
> >
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
> Yes, that's what I was checking to understand the race. In your explanati=
on:
>
> A1 found the vma
> A2 detached it
> A3 attached it to another mm
> A1 refcounts the vma
> A1 realizes it's from another mm and calls vma_end_read() which tries
> to wake up another mm's waiter.

Ok, I finally got the entire picture. Now I understand why it would be
so hard to reproduce and that it depends on a very specific order of
execution. These steps should happen in precisely this order:

A3 calls __vma_enter_locked() and refcount_add_not_zero() fails due to
A1 holding a refcount (usual situation);
By the time A3 calls rcuwait_wait_event(), A1 should drop its refcount
so that rcuwait_wait_event() does not enter wait;
By the time A1 calls rcuwait_wake_up(), A3 should free the mm leading
to A1's UAF;

Very clever.
I was wrong thinking that we can call rcuwait_wake_up() for the
original mm that vma was attached before. We do have to
rcuwait_wake_up() the mm that vma is attached to at the time of
vma_refcount_put(), so using vma->vm_mm in vma_refcount_put() is the
right thing to do because our refcount might be blocking operations on
the current vma->mm, not the one vma was originally attached to. We
just have to stabilize vma->mm.

So, I think vma_refcount_put() can mmgrab(vma->mm) before calling
__refcount_dec_and_test(), to stabilize that mm and then mmdrop()
after it calls rcuwait_wake_up(). What do you think about this
approach, folks?

>
> Vlastimil is right that if A1 was able to successfully elevate vma's
> refcount then:
> 1. vma must be attached to some valid mm. This is true because if the
> vma is detached, vma_start_read() would not be able to elevate its
> refcount. Once vma_start_read() elevates the refcount, vma will not
> detach from under us because vma_mark_detached() will block until no
> readers are using the vma.
> 2. vma->mm can't be destroyed from under us because of that
> exit_mmap()->vma_mark_detached() which again will ensure no readers
> are holding a reference to the vmas of that mm.
>
> So, a special version of vma_refcount_put() that takes mm as a
> parameter and does mmgrab/mmdrop before using that mm might work. I'll
> do some more digging and maybe test this solution with your reproducer
> to see if that works as I would expect.
> Thanks,
> Suren.

