Return-Path: <linux-kernel+bounces-864758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F456BFB7A9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 408A0507C3B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BB2328613;
	Wed, 22 Oct 2025 10:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="PsoK9a3j"
Received: from forward502d.mail.yandex.net (forward502d.mail.yandex.net [178.154.239.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917C72D3231;
	Wed, 22 Oct 2025 10:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761130393; cv=none; b=jjqwtvC9cmtbZ0ha9L5PPnWpZefqGIRN++UCb49JE6ech1CLaN3o11e7qLA23ZACd2z7WBtEejte32hYhV0u7XGLd2OIE4czcxQ7iJBDQDcSpHIz91//9JVbbscjw1Ey8hKsQik/RWXUHQbU7g9CVRezmEgRQXFtarEI67GUcUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761130393; c=relaxed/simple;
	bh=zt8uxkdbqQzapKcBrVoV8/gQMIawtmzx5vveZrtl6qw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eQad4fOc8xUQkhGrJxKn7OPO8lzrb9FKiHtQG3+XpT5Ey9f5u1fsKSjtWZyzO9e6zZeVYF66R+jHIvsTLIx5RKLHNoeNACAnbiR0pJHAVE0tcX3Cmhb7z3LgD2q1E9rKOKXR88kTP/GyXbZA8EW1ZP1fu0xuELrODhqo+cfhRy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=PsoK9a3j; arc=none smtp.client-ip=178.154.239.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-88.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-88.klg.yp-c.yandex.net [IPv6:2a02:6b8:c43:84a0:0:640:dfd2:0])
	by forward502d.mail.yandex.net (Yandex) with ESMTPS id 52399C0AE4;
	Wed, 22 Oct 2025 13:47:18 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-88.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id ClUg8fCR30U0-mFQIpW0b;
	Wed, 22 Oct 2025 13:47:17 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1761130037;
	bh=0E+EBgQsNDyNzTW4wNEOa6xsi+Q7o8SpYmABR6Q6Fyo=;
	h=Cc:Message-ID:Subject:Date:References:To:From:In-Reply-To;
	b=PsoK9a3jz9CNKVQ4TdaXf5yYRk7fByokatXx1pVBqMLm6NFr8QT1j9Sij2cLPm0DJ
	 TzslpY++6DkRip6BvRX3Nu/lJuVOjVs62I+nx3AzatyOKyGk/lkJvgT+EEfGw9GXzx
	 JGQ+Xe28aaXh4V6yOToeYk7W+dGGmA4KBWsuzzdk=
Authentication-Results: mail-nwsmtp-smtp-production-main-88.klg.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
Date: Wed, 22 Oct 2025 13:47:11 +0300
From: Onur =?UTF-8?B?w5Z6a2Fu?= <work@onurozkan.dev>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 lossin@kernel.org, lyude@redhat.com, ojeda@kernel.org,
 alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
 a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
 dakr@kernel.org, peterz@infradead.org, mingo@redhat.com, will@kernel.org,
 longman@redhat.com, felipe_life@live.com, daniel@sedlak.dev,
 bjorn3_gh@protonmail.com
Subject: Re: [PATCH v6 3/7] rust: implement `WwMutex`, `WwAcquireCtx` and
 `WwMutexGuard`
Message-ID: <20251022134711.75194e08@nimda.home>
In-Reply-To: <E98866AA-AE29-432E-B6D3-4625103B8D07@collabora.com>
References: <20250903131313.4365-1-work@onurozkan.dev>
	<20250903131313.4365-4-work@onurozkan.dev>
	<886565B2-B5CD-49DA-9598-EBD60490C0DC@collabora.com>
	<E98866AA-AE29-432E-B6D3-4625103B8D07@collabora.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 5 Sep 2025 16:03:02 -0300
Daniel Almeida <daniel.almeida@collabora.com> wrote:

> [=E2=80=A6]
>=20
> >=20
> >> +///
> >> +/// # Examples
> >> +///
> >> +/// ## Basic Usage
> >> +///
> >> +/// ```
> >> +/// use kernel::c_str;
> >> +/// use kernel::sync::Arc;
> >> +/// use kernel::sync::lock::ww_mutex::{WwClass, WwAcquireCtx,
> >> WwMutex }; +/// use pin_init::stack_pin_init;
> >> +///
> >> +/// stack_pin_init!(let class =3D
> >> WwClass::new_wound_wait(c_str!("buffer_class"))); +/// let mutex =3D
> >> Arc::pin_init(WwMutex::new(42, &class), GFP_KERNEL)?; +///
> >> +/// let ctx =3D KBox::pin_init(WwAcquireCtx::new(&class),
> >> GFP_KERNEL)?; +///
> >> +/// let guard =3D ctx.lock(&mutex)?;
> >> +/// assert_eq!(*guard, 42);
> >> +///
> >> +/// # Ok::<(), Error>(())
> >> +/// ```
> >> +///
> >> +/// ## Multiple Locks
> >> +///
> >> +/// ```
> >> +/// use kernel::c_str;
> >> +/// use kernel::prelude::*;
> >> +/// use kernel::sync::Arc;
> >> +/// use kernel::sync::lock::ww_mutex::{WwClass, WwAcquireCtx,
> >> WwMutex}; +/// use pin_init::stack_pin_init;
> >> +///
> >> +/// stack_pin_init!(let class =3D
> >> WwClass::new_wait_die(c_str!("resource_class"))); +/// let mutex_a
> >> =3D Arc::pin_init(WwMutex::new("Resource A", &class), GFP_KERNEL)?;
> >> +/// let mutex_b =3D Arc::pin_init(WwMutex::new("Resource B",
> >> &class), GFP_KERNEL)?; +/// +/// let ctx =3D
> >> KBox::pin_init(WwAcquireCtx::new(&class), GFP_KERNEL)?; +///
> >> +/// // Try to acquire both locks.
> >> +/// let guard_a =3D match ctx.lock(&mutex_a) {
> >> +///     Ok(guard) =3D> guard,
> >> +///     Err(e) if e =3D=3D EDEADLK =3D> {
> >> +///         // Deadlock detected, use slow path.
> >=20
> > You must release all other locks before calling this, except there
> > aren=E2=80=99t any taken in your example.
> >=20
> > You should perhaps add a release_all() function to the context.
> >=20
>=20
> By the way, if we need a context in the first place to lock, it makes
> sense to release_all() once this context is dropped.

I am going to need to implement release_all anyway since the C code [1]
requires that all locks be released before calling ww_acquire_fini
(which we already do in PinnedDrop and now in reinit (a new function)).

To make that work, we need to keep track of the locks which is what
ExecContext is currently doing. So I will probably just drop ExecContext
entirely and fold that logic into WwAcquireCtx instead (like I
mentioned a while back) for the next version in this week.

[1]:
https://github.com/torvalds/linux/blob/552c50713f27/include/linux/ww_mutex.=
h#L195-L196

Regards,
Onur=20

>=20
> =E2=80=94 Daniel
>=20
>=20
>=20


