Return-Path: <linux-kernel+bounces-773624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EADB2A271
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 759874E2E0C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 12:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B5131A04A;
	Mon, 18 Aug 2025 12:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="CKf91Tca"
Received: from forward500b.mail.yandex.net (forward500b.mail.yandex.net [178.154.239.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD7A3218B8;
	Mon, 18 Aug 2025 12:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755521808; cv=none; b=OK4I45MSfwodWGJeY/v5O10p+XZpOpmRIuDlDWP9nu1UTiqPQ1PynywPQEInmoraRjSKxbSHarS2bVw4RzExPtLOLq0hlWsELtVmHR9ayglHYT0dKWTCSNaorMsN1Fjps2igvHKi/uc1UAIAOOWzw8VQ6t1UcU2b7Wk3W6ffOLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755521808; c=relaxed/simple;
	bh=j18pZK5Ny7MjkAw/PUElBPSgqsHy73e7TEABV3NGo4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qaDYmuhm6gFw2RMOQV4e+qTZZCHdHLpfv5yBPU3X7S2ksLUaxGga7ycbRnow0Xw0yb+vpQSba2EntTzE5UymRcAoCxyL/tTn1xWbMr+u5vwx+U4UcWHjg4tu4sRioYisIH9C4qPyvCGDLzHANPu1NF5ogltgIRWsBK2y827/2HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=CKf91Tca; arc=none smtp.client-ip=178.154.239.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-76.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-76.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:bc97:0:640:ee90:0])
	by forward500b.mail.yandex.net (Yandex) with ESMTPS id 73A57C0BF9;
	Mon, 18 Aug 2025 15:56:36 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-76.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id UuPdqlTMi4Y0-G3neT293;
	Mon, 18 Aug 2025 15:56:35 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1755521795;
	bh=L+z0+mToYCz8H2p+prbV8yZDUcxhYIV8KhXqpZtJTqU=;
	h=Cc:Message-ID:Subject:Date:References:To:From:In-Reply-To;
	b=CKf91TcaYKbSeY9zZR+CSWq24IFrLC0zSVhwALuzP1hBX4oZV2aUY0Fo+he18QVWz
	 l3xW0C9WaQN707AMvfs7NiuhnHgzU6s4EdVPVOgH28CbCj4m/bubzQVWVtXrqMz/4B
	 JUx72wUhx76Zh2Wlm+jEGNVtNC5VdZtC0XkvGSJA=
Authentication-Results: mail-nwsmtp-smtp-production-main-76.iva.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
Date: Mon, 18 Aug 2025 15:56:28 +0300
From: Onur =?UTF-8?B?w5Z6a2Fu?= <work@onurozkan.dev>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Benno Lossin <lossin@kernel.org>, Lyude Paul <lyude@redhat.com>,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
 gary@garyguo.net, a.hindborg@kernel.org, aliceryhl@google.com,
 tmgross@umich.edu, dakr@kernel.org, peterz@infradead.org, mingo@redhat.com,
 will@kernel.org, longman@redhat.com, felipe_life@live.com,
 daniel@sedlak.dev, bjorn3_gh@protonmail.com
Subject: Re: [PATCH v5 0/3] rust: add `ww_mutex` support
Message-ID: <20250818155628.1b39d511@nimda.home>
In-Reply-To: <182E916F-3B59-4721-B415-81C3CF175DA7@collabora.com>
References: <20250621184454.8354-1-work@onurozkan.dev>
	<20250724165351.509cff53@nimda.home>
	<ec32fc5f5a8658c084f96540bd41f5462fa5c182.camel@gmail.com>
	<20250806085702.5bf600a3@nimda.home>
	<539d3e0da773c32a42b4ab5c9d4aa90383481ff6.camel@redhat.com>
	<DBVLEGFYBWKE.2RW8J853CJHTY@kernel.org>
	<20250814141302.1eabda12@nimda.home>
	<76D4D052-79B6-4D3F-AAA1-164FF7A41284@collabora.com>
	<20250814185622.468aad30@nimda.home>
	<182E916F-3B59-4721-B415-81C3CF175DA7@collabora.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 14 Aug 2025 15:22:57 -0300
Daniel Almeida <daniel.almeida@collabora.com> wrote:

>=20
> Hi Onur,
>=20
> > On 14 Aug 2025, at 12:56, Onur <work@onurozkan.dev> wrote:
> >=20
> > On Thu, 14 Aug 2025 09:38:38 -0300
> > Daniel Almeida <daniel.almeida@collabora.com> wrote:
> >=20
> >> Hi Onur,
> >>=20
> >>> On 14 Aug 2025, at 08:13, Onur =C3=96zkan <work@onurozkan.dev> wrote:
> >>>=20
> >>> Hi all,
> >>>=20
> >>> I have been brainstorming on the auto-unlocking (on dynamic number
> >>> of mutexes) idea we have been discussing for some time.
> >>>=20
> >>> There is a challange with how we handle lock guards and my current
> >>> thought is to remove direct data dereferencing from guards.
> >>> Instead, data access would only be possible through a fallible
> >>> method (e.g., `try_get`). If the guard is no longer valid, this
> >>> method would fail to not allow data-accessing after auto-unlock.
> >>>=20
> >>> In practice, it would work like this:
> >>>=20
> >>> let a_guard =3D ctx.lock(mutex_a)?;
> >>> let b_guard =3D ctx.lock(mutex_b)?;
> >>>=20
> >>> // Suppose user tries to lock `mutex_c` without aborting the
> >>> // entire function (for some reason). This means that even on
> >>> // failure, `a_guard` and `b_guard` will still be accessible.
> >>> if let Ok(c_guard) =3D ctx.lock(mutex_c) {
> >>>    // ...some logic
> >>> }
> >>>=20
> >>> let a_data =3D a_guard.try_get()?;
> >>> let b_data =3D b_guard.try_get()?;
> >>=20
> >> Can you add more code here? How is this going to look like with the
> >> two closures we=E2=80=99ve been discussing?
> >=20
> > Didn't we said that tuple-based closures are not sufficient when
> > dealing with a dynamic number of locks (ref [1]) and ww_mutex is
> > mostly used with dynamic locks? I thought implementing that
> > approach is not worth it (at least for now) because of that.
> >=20
> > [1]:
> > https://lore.kernel.org/all/DBS8REY5E82S.3937FAHS25ANA@kernel.org
> >=20
> > Regards,
> > Onur
>=20
>=20
>=20
> I am referring to this [0]. See the discussion and itemized list at
> the end.
>=20
> To recap, I am proposing a separate type that is similar to drm_exec,
> and that implements this:
>=20
> ```
> a) run a user closure where the user can indicate which ww_mutexes
> they want to lock b) keep track of the objects above
> c) keep track of whether a contention happened
> d) rollback if a contention happened, releasing all locks
> e) rerun the user closure from a clean slate after rolling back
> f) run a separate user closure whenever we know that all objects have
> been locked. ```
>=20
> In other words, we need to run a closure to let the user implement a
> given locking strategy, and then one closure that runs when the user
> signals that there are no more locks to take.
>=20
> What I said is different from what Benno suggested here:
>=20
> >>>>>>    let (a, c, d) =3D ctx.begin()
> >>>>>>        .lock(a)
> >>>>>>        .lock(b)
> >>>>>>        .lock(c)
> >>>>>>        .custom(|(a, _, c)| (a, c))
> >>>>>>        .lock(d)
> >>>>>>        .finish();
>=20
> i.e.: here is a brief example of how the API should be used by
> clients:
>=20
> ```
> // The Context keeps track of which locks were successfully taken.
> let locking_algorithm =3D |ctx: &Context| {
>   // client-specific code, likely some loop trying to acquire
> multiple locks: //
>   // note that it does not _have_ to be a loop, though. It up to the
> clients to // provide a suitable implementation here.
>   for (..) {
>     ctx.lock(foo); // If this succeeds, the context will add  "foo"
> to the list of taken locks. }
>=20
>   // if this closure returns EDEADLK, then our abstraction must
> rollback, and // run it again.
> };
>=20
> // This runs when the closure above has indicated that there are no
> more locks // to take.
> let on_all_locks_taken =3D |ctx: &Context| {
>   // everything is locked here, give access to the data in the guards.
> };
>=20
> ctx.lock_all(locking_algorithm, on_all_locks_taken)?;
> ```
>=20
> Yes, this will allocate but that is fine because drm_exec allocates
> as well.
>=20
> We might be able to give more control of when the allocation happens
> if the number of locks is known in advance, e.g.:
>=20
> ```
> struct Context<T> {
>   taken_locks: KVec<Guard<T>>,
> }
>=20
> impl<T> Context<T> {
>   fn prealloc_slots(num_slots: usize, flags: ...) -> Result<Self> {
>     let taken_locks =3D ... // pre-alloc a KVec here.=20
>     Self {
>       taken_slots,
>     }=20
>   }
> }
> ```
>=20
> The main point is that this API is optional. It builds a lot of
> convenience of top of the Rust WWMutex abstraction, but no one is
> forced to use it.
>=20
> IOW: What I said should be implementable with a dynamic number of
> locks. Please let me know if I did not explain this very well.=20
>=20
> [0]:
> https://lore.kernel.org/rust-for-linux/8B1FB608-7D43-4DD9-8737-DCE59ED74C=
CA@collabora.com/

Hi Daniel,

Thank you for repointing it, I must have missed your previour mail.

It seems crystal clear, I will review this mail in detail when I am
working on this patch again.

Regards,
Onur

