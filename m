Return-Path: <linux-kernel+bounces-743166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5C7B0FB66
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 22:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 646461AA5A18
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 20:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7AC7230270;
	Wed, 23 Jul 2025 20:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fFp755Rx"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A070A1F4190
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 20:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753302455; cv=none; b=OdKR7+FD9Yz/MNEPx0u4F1TMGqSoMes1hr/qOO3tFjSi35J72HZ9JlRUHGQPTRfPh3K9TIY/jg2elZh9nZLhKiENWDkyLBfS0Vamok5LH2+i/KAIJDoiwRX9tdKjfQcNaRJh1qhyR9CibC0lnZQ90GWQMBsAP02o+hMUBqcJZHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753302455; c=relaxed/simple;
	bh=cqpIlwslBVxzS7l9bz/0u4HW947b0PI/rh4p4FQwT+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EWLv7qiYTN5bbLnSKwuYyFgxWYsIVRrtjlXSwEtNUsehsWkNrnBEQLX1sQJoYxy41wrf+GAMKdv97XY+slHNXU+gOGwqC/Gjia10RPF1LDqOeBWxLDwzSaCIGJe6qgjqfXuE/OQMS96B9k21UTm3iMHgtuHw/YcZULf1M+UZ98Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fFp755Rx; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4ab86a29c98so102961cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 13:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753302452; x=1753907252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u1sl538/KvnDXhxqydqRnh34xu1UR7rQ6zY7czcklQI=;
        b=fFp755RxCAhVN2XKcal5XvcKo/OzfSu5FaouvS3Vsdvg/BstRtu7ejCNPuGO3Y4rWi
         x8Dm7BV/C9Io7+706P7dLQ1qBuzZAHXv7lUy/L8zjSepTA9HkV7N2Ybt9ug5ZbU9Vdzi
         VOpmH+xiF6qfUvIbR492/3EJ6HaM7dFAokWXTidM1bKJ/nUglGlmZUFAWRmQpXeGWq+2
         D/KXp1yWKYjxjmSV5kkeOwbgt9UA9ZVCafN4yYTwykUJ0G13JtfgRa76NeZ74o2TMnfS
         YUDdD1dTjpg2+niYDp938a14IxwVtjh/GhOXPgmHIxSk0s/mjVQkhnnlAlTO6+jWBptG
         4fcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753302452; x=1753907252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u1sl538/KvnDXhxqydqRnh34xu1UR7rQ6zY7czcklQI=;
        b=IWOpnc4KVhcE+SCGvPl1AgeLemG4PBZzfeSGF3XO/M7Rn1NI2PZE+JRj8kTHrtMX2N
         zoF841Mirw8wmTaKpq0iQzPHwZupPBWjAwD1Y2w9kmEwZk8H3IntBJHWlBX2W/iLhedX
         W6hjRfpaRrWD/6GD6mBBXwdpy+VYIsvGegfbvdcGVRQLJWV8wCx4DPVsEiBT0hVeEzAA
         5I6p2ArFnrrLXdFwJkhgHdAYQe6zNI/5oZFeRG2Sdg6x4ceycaCx/OJLsb75V+GsyJDR
         SODosDsaptcBpYp5ZWq6shkj3rTxj+lgayHmZrt6UITEm7w4NLcok8owB3Dh4KtnAHP3
         7lxA==
X-Forwarded-Encrypted: i=1; AJvYcCW0yBEl0TzAK36Bzi/OPQkO2tT+BbBNy9oCursYgZGMaaaaeUDXdtxWC2frEA5oZWyz4JLvAnJL+FE5BCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YymkE37O4YJCbiaGOOqyNgwGfNH/JDGXCl6ptLvtHz8sRRolF+G
	FEdVdXzo77411E+kQ+fUGfQoq3h69PXsbKKZmzzpUZuw1McZVM7H49dqbIPDHruF+OM2cHrfvxh
	qd+PqL+nVNT4mbowpEJjdBjkhjjY8rgv7QGbhv/XP
X-Gm-Gg: ASbGncuEQOKOC3TWvbV7Sgbh4XYEC3JOSANnJYvXjs/je0ZGmhil9ouzouuu5M9u2RR
	2Wcp1pIQ+3FegbWMpnB+gz7aGaCxLciPi82lzjf6FlTaHOa03jZDSxA6gK5b7fqHT86bQoQftvm
	PLbO8T/sCgv4NKRCljxA+oREyRtK1vNasPKEUK2YaGPlLXGcXgdttkwG5yvDmqejfxkNQFpTvQv
	GcigBC2WPJ8MCfPBPjbH25fjOzsmhmpF9jmrw==
X-Google-Smtp-Source: AGHT+IGCMUKReDm9rDYrTHEMKvMYKPJkSr2F6cj2WDS/6iB7ipxJsWeghCcTu7SSmIYlZYU6TUc/FsND7oQ7ikAinBI=
X-Received: by 2002:a05:622a:1aa0:b0:4a9:95a6:3a69 with SMTP id
 d75a77b69052e-4ae7ca85ae5mr973601cf.8.1753302452100; Wed, 23 Jul 2025
 13:27:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG48ez0-deFbVH=E3jbkWx=X3uVbd8nWeo6kbJPQ0KoUD+m2tA@mail.gmail.com>
 <16c97e30-19c9-41e8-b73b-c0b3c8eceff3@suse.cz> <CAG48ez1qhjQNHC+3572udqVWHTANFpQ0ngxn_4ZDC9F8NCXsFA@mail.gmail.com>
 <c53b22c3-9f7f-4793-9d10-f4df861a3e32@suse.cz> <CAG48ez2cGX3e5bqgcw0OEnho29+YhwG2eOrHRgNwGAA_Nb65nw@mail.gmail.com>
In-Reply-To: <CAG48ez2cGX3e5bqgcw0OEnho29+YhwG2eOrHRgNwGAA_Nb65nw@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 23 Jul 2025 13:27:21 -0700
X-Gm-Features: Ac12FXwDkJdWDEWHSxsTTq8QRFoQHdLvE_k02s-NBUeCrpxTck2q_By7-kpyS0c
Message-ID: <CAJuCfpEcjH+W83At8WSkgzO=JvZmapg6dPaXmuSRS4ufhSha4w@mail.gmail.com>
Subject: Re: [BUG] hard-to-hit mm_struct UAF due to insufficiently careful
 vma_refcount_put() wrt SLAB_TYPESAFE_BY_RCU
To: Jann Horn <jannh@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Pedro Falcato <pfalcato@suse.de>, Linux-MM <linux-mm@kvack.org>, 
	kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2025 at 11:19=E2=80=AFAM Jann Horn <jannh@google.com> wrote=
:
>
> On Wed, Jul 23, 2025 at 8:10=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> =
wrote:
> > On 7/23/25 19:49, Jann Horn wrote:
> > > On Wed, Jul 23, 2025 at 7:32=E2=80=AFPM Vlastimil Babka <vbabka@suse.=
cz> wrote:
> > >> On 7/23/25 18:26, Jann Horn wrote:
> > >> > There's a racy UAF in `vma_refcount_put()` when called on the
> > >> > `lock_vma_under_rcu()` path because `SLAB_TYPESAFE_BY_RCU` is used
> > >> > without sufficient protection against concurrent object reuse:
> > >>
> > >> Oof.
> > >>
> > >> > I'm not sure what the right fix is; I guess one approach would be =
to
> > >> > have a special version of vma_refcount_put() for cases where the V=
MA
> > >> > has been recycled by another MM that grabs an extra reference to t=
he
> > >> > MM? But then dropping a reference to the MM afterwards might be a =
bit
> > >> > annoying and might require something like mmdrop_async()...
> > >>
> > >> Would we need mmdrop_async()? Isn't this the case for mmget_not_zero=
() and
> > >> mmput_async()?
> > >
> > > Now I'm not sure anymore if either of those approaches would work,
> > > because they rely on the task that's removing the VMA to wait until w=
e
> > > do __refcount_dec_and_test() before deleting the MM... but I don't
> > > think we have any such guarantee...
> >
> > I think it would be waiting in exit_mmap->vma_mark_detached(), but then
> > AFAIU you're right and we'd really need to work with mmgrab/mmdrop beca=
use
> > at that point the  mmget_not_zero() would already be failing...
>
> Ah, I see! vma_mark_detached() drops its reference, then does
> __vma_enter_locked() to bump the refcount by VMA_LOCK_OFFSET again
> (after which the reader path can't acquire it anymore), then waits
> until the refcount drops to VMA_LOCK_OFFSET, and then decrements it
> down to 0 from there. Makes sense.

Yes, that's what I was checking to understand the race. In your explanation=
:

A1 found the vma
A2 detached it
A3 attached it to another mm
A1 refcounts the vma
A1 realizes it's from another mm and calls vma_end_read() which tries
to wake up another mm's waiter.

Vlastimil is right that if A1 was able to successfully elevate vma's
refcount then:
1. vma must be attached to some valid mm. This is true because if the
vma is detached, vma_start_read() would not be able to elevate its
refcount. Once vma_start_read() elevates the refcount, vma will not
detach from under us because vma_mark_detached() will block until no
readers are using the vma.
2. vma->mm can't be destroyed from under us because of that
exit_mmap()->vma_mark_detached() which again will ensure no readers
are holding a reference to the vmas of that mm.

So, a special version of vma_refcount_put() that takes mm as a
parameter and does mmgrab/mmdrop before using that mm might work. I'll
do some more digging and maybe test this solution with your reproducer
to see if that works as I would expect.
Thanks,
Suren.

