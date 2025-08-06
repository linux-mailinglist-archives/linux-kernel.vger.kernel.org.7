Return-Path: <linux-kernel+bounces-757273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 917E6B1C021
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 07:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32AE918C02FB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 05:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4EEE1FF7B4;
	Wed,  6 Aug 2025 05:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="eao6pOTq"
Received: from forward500d.mail.yandex.net (forward500d.mail.yandex.net [178.154.239.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F229B1DEFD2;
	Wed,  6 Aug 2025 05:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754459841; cv=none; b=WRcGGmJhAaLfEvZPiepOwgY/gbCESZcOqOt30LsMAwnNKe0TQadO44Ru7ZkQCt5R37WnndN6xbu0PYtNhr6OXlehpfPfDD6df1TbOHbTjsO3GJSO+GZLXoR+y8t1jQjZr9XoBYP9id3o9Ijv2k8C01pN0o5Q+j9vA2i4kY2xNEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754459841; c=relaxed/simple;
	bh=ayQesVw/rM4qaaKbOYFV/X23n9kB65dbpVD96KNFi1o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WkPN0ifbuxmYk90tNHL8y991AaIzM5NEtbfU3HhqCnxqQTzwiHR0RK6FKUfx/J5lnsS7yBkfTxrlm1cFHNAIiANlvL7n5Q3ixqIPFzouNBewAL4LyPdasxxr+jz0gTRMCChvCLU9wHxvO4vTC0l7nYxukek57DS0KniUHA0RrHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=eao6pOTq; arc=none smtp.client-ip=178.154.239.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net [IPv6:2a02:6b8:c43:152c:0:640:d236:0])
	by forward500d.mail.yandex.net (Yandex) with ESMTPS id 2B25981ED0;
	Wed, 06 Aug 2025 08:57:09 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 3vZDlV7L3a60-Fn31Me8l;
	Wed, 06 Aug 2025 08:57:08 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1754459828;
	bh=abbD+wbkBUwwZmPjkf0v357RVnk/hpuUN85h/N1bW5g=;
	h=Cc:Message-ID:Subject:Date:References:To:From:In-Reply-To;
	b=eao6pOTqrgm1dmllwxhTkdo+gSV8iaUyh6PljRA05+fG1WloE0ox0GZmF2T/iov8Y
	 Ww97hehpn6NNMvvDhK8WPwA8Sg0mg+cHG4s129qyzKffUPtmnV2pF5DiDMFiOdWPBK
	 oYzjL1d0D6/dG0Xx/IM36puV94FSZmE0JT0urxzs=
Authentication-Results: mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
Date: Wed, 6 Aug 2025 08:57:02 +0300
From: Onur =?UTF-8?B?w5Z6a2Fu?= <work@onurozkan.dev>
To: Lyude Paul <thatslyude@gmail.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
 gary@garyguo.net, lossin@kernel.org, a.hindborg@kernel.org,
 aliceryhl@google.com, tmgross@umich.edu, dakr@kernel.org,
 peterz@infradead.org, mingo@redhat.com, will@kernel.org,
 longman@redhat.com, felipe_life@live.com, daniel@sedlak.dev,
 bjorn3_gh@protonmail.com, lyude@redhat.com
Subject: Re: [PATCH v5 0/3] rust: add `ww_mutex` support
Message-ID: <20250806085702.5bf600a3@nimda.home>
In-Reply-To: <ec32fc5f5a8658c084f96540bd41f5462fa5c182.camel@gmail.com>
References: <20250621184454.8354-1-work@onurozkan.dev>
	<20250724165351.509cff53@nimda.home>
	<ec32fc5f5a8658c084f96540bd41f5462fa5c182.camel@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 05 Aug 2025 12:22:33 -0400
Lyude Paul <thatslyude@gmail.com> wrote:

> Hey! Onur, if you could make sure that future emails get sent to
>=20
> lyude at redhat dot com
>=20
> That would be appreciated! I usually am paying much closer attention
> to that email address. That being said, some comments down below:

Sure thing, added it the cc list.

> On Thu, 2025-07-24 at 16:53 +0300, Onur =C3=96zkan wrote:
> > Hi again,
> >=20
> > Just finished going over the C-side use of `ww_mutex` today and I
> > wanted to share some notes and thoughts based on that.
> >=20
> > To get the full context, you might want to take a look at this
> > thread [1].
> >=20
> > - The first note I took is that we shouldn't allow locking without
> > `WwAcquireCtx` (which is currently possible in v5). As explained in
> > ww_mutex documentation [2], this basically turns it into a regular
> > mutex and you don't get benefits of `ww_mutex`.
>=20
> I disagree about this conclusion actually, occasionally you do just
> need to acquire a single mutex and not multiple. Actually - we even
> have a drm_modeset_lock_single_*() set of functions in KMS
> specifically for this purpose.=20
>=20
> Here's an example where we use it in nouveau for inspecting the
> atomic display state of a specific crtc:
>=20
> https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/nouveau/dis=
pnv50/crc.c#L682
>=20
> This isn't actually too unusual of a usecase tbh, especially
> considering that the real reason we have ww_mutexes in KMS is to deal
> with the atomic transaction model that's used for modesetting in the
> kernel.
>=20
> A good example, which also doubles as a ww_mutex example you likely
> missed on your first skim since all of it is done through the
> drm_modeset_lock API and not ww_mutex directly:
>=20
> https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/nouveau/dis=
pnv50/crc.c#L544
>
> drm_modeset_acquire_init() is a wrapper around ww_mutex_init() which
> actually does pretty much exactly what Daniel is describing lower in
> the thread: keeping track of a list of each acquired lock so that
> they can be dropped once the context is released.
>=20
> drm_atomic_get_crtc_state() grabs the CRTC context and ensures that
> the crtc's modeset lock (e.g. a ww_mutex) is actually acquired
>=20
> drm_atomic_commit()=C2=A0performs the checking of the atomic modeset
> transaction, e.g. going through the requested display settings and
> ensuring that the display hardware is actually capable of supporting
> it before allowing the modeset to continue. Often times for GPU
> drivers this process can involve not just checking limitations on the
> modesetting object in question, but potentially adding other
> modesetting objects into the transaction that the driver needs to
> also inspect the state of. Adding any of these modesetting objects
> potentially means having to acquire their modeset locks using the
> same context, and we can't and don't really want to force users to
> have an idea of exactly how many locks can ever be acquired. Display
> hardware is wonderful at coming up with very wacky limitations we
> can't really know ahead of time because they can even depend on the
> global display state.
>=20
> So tracking locks is definitely the way to go, but we should keep in
> mind there's already infrastructure in the kernel doing this that we
> want to be able to handle with these APIs as well.


Thanks for the feedback! Supporting single locks is easy, I just
didn't think it was a good idea at first but it looks like I missed
some cases.

I can implement two types of locking functions: one on `WwMutex` where
`WwMutex::lock` handles a single lock without a context, and another on
`WwAcquireCtx`, where `WwAcquireCtx::lock` is used for handling
multiple contexts.

e.g.,:

    let mutex =3D WwMutex::new(...);
    mutex.lock(); // without context, for single locks

    let ctx =3D WwAcquireCtx::new(...);
    ctx.lock(mutex); // with context, for multiple locks

What do you think?

Regards,
Onur

