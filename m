Return-Path: <linux-kernel+bounces-804174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16649B46BA0
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 13:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07B9C1B26EEA
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 11:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C5327A130;
	Sat,  6 Sep 2025 11:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="K56IjOPq"
Received: from forward501a.mail.yandex.net (forward501a.mail.yandex.net [178.154.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F161A8F84;
	Sat,  6 Sep 2025 11:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757158720; cv=none; b=cRf4oYK46Mi3BSM34hVtfAUz3FJBDCuugx27JqbGRY19DtxmpDiOOcOhB/cPSB9KOB0DX0jDUMe67eFBp4DKHUi7XEW4vAOlXu/Nhh1D5HQW99uSdFhVwTH2BJWgqtzIVnTi+hocpB6Xct9jJLC6EhmhqB+IHmkAnnZ6r9vYY90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757158720; c=relaxed/simple;
	bh=1jQB1Z2Ifm8VuoJljpVKSYwM2qLU6ZHDQUpJcobVxoY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HkRdBCqOIaPhbHRe2M+aGSorJyGrw5/cedlb/zjjdvpTTIlAiyaYqeawLEcX/rE/W0l9bJXapl0WoBjdHX8hfVRKUbdScTI+kGZy66Ip2QMgz8+1NqdeQJmVBCwpk1R6akLkv/RRifKNUOCrlWG4R9yY1xepIFz/bT4KM7WYMi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=K56IjOPq; arc=none smtp.client-ip=178.154.239.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net [IPv6:2a02:6b8:c2d:6c0a:0:640:c879:0])
	by forward501a.mail.yandex.net (Yandex) with ESMTPS id D471E80A4C;
	Sat, 06 Sep 2025 14:38:29 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id NchoYwZMriE0-6kgEAWoY;
	Sat, 06 Sep 2025 14:38:28 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1757158709;
	bh=fmg3TYCAGkD54hVmPROnZnbW7fdsqgW0JF+AsDmql+I=;
	h=Cc:Message-ID:Subject:Date:References:To:From:In-Reply-To;
	b=K56IjOPqUUj/IZzVlkLJr3WJ9aPC+DZltzpYU6R5CBLCZmj1NoW1K4bKxVkI6xZ37
	 wS63xZMOEKJL32yGid7kjljH8mhKAvzsOZtBhAAKKg/EK9P8OdoZEtUSTsXpJw6sna
	 rv2sTVPE9rC9gEiuT5H8m3SzTzkTX6khwFF1UK3I=
Authentication-Results: mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
Date: Sat, 6 Sep 2025 14:38:23 +0300
From: Onur <work@onurozkan.dev>
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
Message-ID: <20250906143823.337cb604@nimda.home>
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
>=20

Very true... Did you like the idea about embedding `ExecContext` cores
inside `WwAcquireCtx` ? It will still be optional to have `EDEADLK`
handling logic, but it will have better release mechanism on drop.

> =E2=80=94 Daniel
>=20
>=20


