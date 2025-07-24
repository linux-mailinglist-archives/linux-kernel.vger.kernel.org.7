Return-Path: <linux-kernel+bounces-744530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D20AB10E1B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC1787BFD04
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 14:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3D12E8DF2;
	Thu, 24 Jul 2025 14:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IYgEucmv"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB39C293B48
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 14:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753368689; cv=none; b=WVOQ1VU4ZWZQCKga0E7Bq+ZOpmy3cybsMRiWK1kBHYcFaG1R2NQaJctYPBwY1jhfDXlf4krGpDy2FtXc2EBC4aVGRTfzEm+yv1wquOINuxptQG+fNhas/baYYHFO0gxgBFC+mQrGO1y5KBm2tGzTDd4NZ0XBUECfXWyZ2VbmTuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753368689; c=relaxed/simple;
	bh=krQSXf68qp0JMrskEvSb37u4JvM76b82wqBxCrxfy60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C1oaGZQ8ezkf8J/3QEVAO/T+yE95jBELDY5Ij1/7w4xoOnVygMsWc12tcb1d9FHRSY9u+XBOcam7P7pRyWm+vMCZAOKn8KMlamheeqv5kS5HriFIM/9hvU/j7v/7dFR5Rg2SJ0sYMI3dXb4U8pm28OrsO+WiTOlhnci7s4x4nqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IYgEucmv; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5f438523d6fso10637a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 07:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753368686; x=1753973486; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oZBzBNB+u1GHY7Eewg0Wa8/2bvpUh1nZ72QzMOssxqc=;
        b=IYgEucmvPc2RUbcVIeEcH8aSAQAmTFsBOZv41RYyAZl6FCzBrc3WPLkQ1eDeMvKhud
         +VxG/DU7j3f0pTA1JXFWOxEFl24DYQPxhEJnT/MFDaPn8suuYdVVx3s5D+oeYaVjTS79
         Lj1eLgw6RjreD9mtQFPlV18RONTCS9HbnJGf5VhM7DmJacZmSP9kMNTmevdIKvlMAnW1
         M432ZkpQTSgUlDDVx5s9Wh36b7p1hLOZITmpvoQ+0c445tf4zcwMCY/aMG7PWgxKwFwB
         TUQL7Z6YeVWPIMjeGtk078lDWKl4x7wPSGgp54hAbPnwvwXfBiXsfpYyuNudDbm9eDSq
         JTxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753368686; x=1753973486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oZBzBNB+u1GHY7Eewg0Wa8/2bvpUh1nZ72QzMOssxqc=;
        b=KmAU6qfgw+y3VzY6YoxH8lBUmzyeiJgOJkOGRTsaQ3xcbh5ncGYFI00O3zXKKj9jzA
         3hYNiRkcikx0bTj7U0SV+X7aKtpGQw17KLEOou8HLEKj4BglTB0l/dwSsyG2jMZh0J9w
         1Q6ULivL5Dv4L6f9PdA7YT5Vy4K4GAgXaadFKW+87hsXRs9N8JWrYPRFmQ+o19xYVC39
         KgWOTdVA1vlRP/eBjI3sAZcGuyoWMUjJQN9RLx30ayma0baaZMEukr/DnfQqh0dklrGV
         ZFMj+VoszRkIllQv+G5B3/vKuTx8u1DbifGtHod1oLwoMzmLqf2kZt8Wlo0etWYrBqWe
         epzw==
X-Forwarded-Encrypted: i=1; AJvYcCWlAHNIWURAwIWMLpwWQTJ8fGy9VMO0AOTcsjUVDaXwxn9Aam1epzNsNplFiXibWvlyCMmtcd4nL3AtDac=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvRjSW+1C3tpQn6ErPzkEg8WJ5BG072IqymKQqklFz/B9H97z5
	NX328fqmE1Br5Qt2BZl6IEt/FiBXAhEVaFS2CaP/6szzIVui52QaI7Ir7PAvcUx0x0ODUV8XvdC
	JQ58sbFSBSNnP6zd6SP7yfjSY01KWnvxQC8SOIPhF
X-Gm-Gg: ASbGncvQp+LhUrMFA/YEqkgYlrUwFSkuFycRqjUpKrHKfSmxEkCABabmfCyvE3p9IVL
	ghyFbJ4f2Ea92XiWcqNvkLAccitW/FZygMNvmI7PCGpA9n2pXxyQe75L4jwte40sD3m+bRRTFw7
	d/vOyti/oER3WSIIllqIYlD6ymMVFEDTgbyeOwVWu6nrgPqDQQZhen1kstfiNiDBqNAwaQKlZjx
	JLXWb0PQQG7nJPQtt6ZDGV5fL12q9FQ1A==
X-Google-Smtp-Source: AGHT+IEOrsDqVo5ci8aYn8jCdtj5CeXQAyO6/Tl1aEs7FqRIBfFdqhP4tUAk0s46m+L4Fi+pXaBVScYi4SEPT7gsT8s=
X-Received: by 2002:a50:c2c9:0:b0:613:5007:6448 with SMTP id
 4fb4d7f45d1cf-614cce2f1efmr81961a12.3.1753368685537; Thu, 24 Jul 2025
 07:51:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG48ez0-deFbVH=E3jbkWx=X3uVbd8nWeo6kbJPQ0KoUD+m2tA@mail.gmail.com>
 <6df9812c-96a5-41be-8b0e-5fff95ec757c@lucifer.local> <CAG48ez1A17JC7Q35jmurY+Co0t_a78bPy9eRWRim7xJy9oLCvA@mail.gmail.com>
 <3a233a85-3a94-422e-87be-591f93acbac7@lucifer.local> <CAG48ez36AcGBy8_wo09WEHz98Dp44yKZ_FiVtFt8tcV9WiHafA@mail.gmail.com>
 <b798c84e-f3fd-486d-ad70-c827385a558a@lucifer.local>
In-Reply-To: <b798c84e-f3fd-486d-ad70-c827385a558a@lucifer.local>
From: Jann Horn <jannh@google.com>
Date: Thu, 24 Jul 2025 16:50:49 +0200
X-Gm-Features: Ac12FXyobmXk6Rg8bysoNNk35-q0E97inAQrfimfGZSKIsFeLOaEfZN3ZnDmKGw
Message-ID: <CAG48ez07dfabOERsOQoh8LWkcYTXo+svQk9X31afmWVGAVg9Tg@mail.gmail.com>
Subject: Re: [BUG] hard-to-hit mm_struct UAF due to insufficiently careful
 vma_refcount_put() wrt SLAB_TYPESAFE_BY_RCU
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, Pedro Falcato <pfalcato@suse.de>, 
	Linux-MM <linux-mm@kvack.org>, kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 7:13=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
> On Wed, Jul 23, 2025 at 09:43:35PM +0200, Jann Horn wrote:
> > Sorry, while typing up this mail I realized I didn't have this stuff
> > particularly straight in my head myself when writing my previous mails
> > about this...
> >
> > On Wed, Jul 23, 2025 at 8:45=E2=80=AFPM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > > On Wed, Jul 23, 2025 at 08:30:30PM +0200, Jann Horn wrote:
> > > > On Wed, Jul 23, 2025 at 8:14=E2=80=AFPM Lorenzo Stoakes
> > > > <lorenzo.stoakes@oracle.com> wrote:
> > > > > On Wed, Jul 23, 2025 at 06:26:53PM +0200, Jann Horn wrote:
> > > > > > There's a racy UAF in `vma_refcount_put()` when called on the
> > > > > > `lock_vma_under_rcu()` path because `SLAB_TYPESAFE_BY_RCU` is u=
sed
> > > > > > without sufficient protection against concurrent object reuse:
> > > > > >
> > > > > > lock_vma_under_rcu() looks up a VMA locklessly with mas_walk() =
under
> > > > > > rcu_read_lock(). At that point, the VMA may be concurrently fre=
ed, and
> > > > > > it can be recycled by another process. vma_start_read() then
> > > > > > increments the vma->vm_refcnt (if it is in an acceptable range)=
, and
> > > > > > if this succeeds, vma_start_read() can return a reycled VMA. (A=
s a
> > > > > > sidenote, this goes against what the surrounding comments above
> > > > > > vma_start_read() and in lock_vma_under_rcu() say - it would pro=
bably
> > > > > > be cleaner to perform the vma->vm_mm check inside vma_start_rea=
d().)
> > > > > >
> > > > > > In this scenario where the VMA has been recycled, lock_vma_unde=
r_rcu()
> > > > > > will then detect the mismatching ->vm_mm pointer and drop the V=
MA
> > > > > > through vma_end_read(), which calls vma_refcount_put().
> > > > >
> > > > > So in _correctly_ identifying the recycling, we then hit a proble=
m. Fun!
> > > > >
> > > > > > vma_refcount_put() does this:
> > > > > >
> > > > > > ```
> > > > > > static inline void vma_refcount_put(struct vm_area_struct *vma)
> > > > > > {
> > > > > >         /* Use a copy of vm_mm in case vma is freed after we dr=
op vm_refcnt */
> > > > > >         struct mm_struct *mm =3D vma->vm_mm;
> > > > >
> > > > > Are we at a point where we _should_ be looking at a VMA with vma-=
>vm_mm =3D=3D
> > > > > current->mm here?
> > > >
> > > > Well, you _hope_ to be looking at a VMA with vma->vm_mm=3D=3Dcurren=
t->mm,
> > > > but if you lose a race it is intentional that you can end up with
> > > > another MM's VMA here.
>
> Right I get the SLAB_TYPESAFE_BY_RCU thing, what I'm saying overall is 'c=
an we
> detect that we lost the race by knowing what mm this should be'...
>
> >
> > (I forgot: The mm passed to lock_vma_under_rcu() is potentially
> > different from current->mm if we're coming from uffd_mfill_lock(),
> > which would be intentional and desired, but that's not relevant here.
> > Sorry for making things more confusing.)
>
> ...and because of this, no we can't. I hate how uffd is implemented.

I mean, we are in a context where we're looking up a VMA under a
specific MM, we know which MM the VMA should be from. And we have a
bailout that checks for this. It's just that by the time we can check
if the MM matches the expected one, we've already grabbed the VMA.

> > > Right so, we have:
> > >
> > > 'mm we meant to get' (which apparently can't be assumed to be current=
->mm)
> > > 'mm we actually got' (which may or may not be freed at any time)
> > >
> > > The _meant to get_ one might have eternal waiters. Or might not even =
need
> > > to be woken up.
> > >
> > > I don't see why keeping the 'actually got' one around really helps us=
? Am I
> > > missing something?
> >
> > We basically have taken a read lock on a VMA that is part of the
> > "actually got" MM, and so we may have caused writers from that MM to
> > block and sleep, and since we did that we have to wake them back up
> > and say "sorry, locked the wrong object, please continue".
>
> OK I think this is the crux of it then, and what I've been missing here -
> we have taken a read lock _by mistake_ in effect on the recycled mm, whic=
h
> may end up to be a spurious one that we need to immediately drop, but
> because of this we might have waiters that could wait forever.
>
> OK I get it. But to safely reference the mm here we need to be assured it
> stays around because in case of this not being true, we have nothing to
> prevent that mm going away right?

Yes - as Suren explained, as long as we hold a reference to the VMA,
the MM also stays around, but to access the MM after dropping the VMA
we need to somehow grab a reference on the MM first.

