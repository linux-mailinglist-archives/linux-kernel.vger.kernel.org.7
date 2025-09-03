Return-Path: <linux-kernel+bounces-797767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AA4B41524
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 08:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EB8168020F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 06:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E716D2D77F6;
	Wed,  3 Sep 2025 06:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="Mq4kB78t"
Received: from forward500a.mail.yandex.net (forward500a.mail.yandex.net [178.154.239.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9205D263C75;
	Wed,  3 Sep 2025 06:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756880676; cv=none; b=dN2AmjqvR+v0ZvcXGnxhwBX13938G5KAYc9r9O+R5WrizXzZ8d4Ni2v/cFIBTcCNfqbS/INeQdykUjaj2mogHdSHZU8HG3KwtYO9eHwnVR+zVdNwVVpfAXBLyZS8vPhTWj9IDdF65aPuNuBKm29NK8U/ueDm/uy9sT2XMbMKHJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756880676; c=relaxed/simple;
	bh=HQ4GcK6psRNsjQKvl0aV1CT5lOymSoezznIizaNDOvY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HbrIDn3qLXbZ4HwqMca2wZL8sUFzafNBDCIs7ZfssY8UjJKcp4MRYQVgdlXDSg3z0iLY5t8Cpf/0iCBTOgcsGX2lleZPshZMCnPn1ctO7gJ7X0XwjwdCvedL2qz8riq+7kp9tbPMHHb9puc9XgtkAOgwCyDEVRCGKun8oAKp7k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=Mq4kB78t; arc=none smtp.client-ip=178.154.239.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net [IPv6:2a02:6b8:c15:2a0e:0:640:b7ff:0])
	by forward500a.mail.yandex.net (Yandex) with ESMTPS id DC7ED81DBF;
	Wed, 03 Sep 2025 09:24:28 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id MOZ1RjtLJSw0-tbbcjoQb;
	Wed, 03 Sep 2025 09:24:27 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1756880667;
	bh=e7CXoEgbqdQlnVu4AkvrhZJos3vjANNbFz6CwkwPdi4=;
	h=Cc:Message-ID:Subject:Date:References:To:From:In-Reply-To;
	b=Mq4kB78t24eHmeffzFge6Z9ViLx2kpqsb2J5LxaXkIHBOsGISjpj4jhql0SUDuSGt
	 pu/CvzbHlIP2ZbOsjzQGNmJLC8cWYjx7hqRZgp2OaBFG+dblvZgv28crweJuoB87VG
	 CtS/mYJZRUneUe189aTQw/WfMwk4ZvIARRLf3xQo=
Authentication-Results: mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
Date: Wed, 3 Sep 2025 09:24:22 +0300
From: Onur <work@onurozkan.dev>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Benno Lossin <lossin@kernel.org>, Lyude Paul <lyude@redhat.com>,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
 gary@garyguo.net, a.hindborg@kernel.org, aliceryhl@google.com,
 tmgross@umich.edu, dakr@kernel.org, peterz@infradead.org, mingo@redhat.com,
 will@kernel.org, longman@redhat.com, felipe_life@live.com,
 daniel@sedlak.dev, bjorn3_gh@protonmail.com
Subject: Re: [PATCH v5 0/3] rust: add `ww_mutex` support
Message-ID: <20250903092422.37b29315@nimda.home>
In-Reply-To: <20250902195328.6293b5d4@nimda.home>
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
	<20250902195328.6293b5d4@nimda.home>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 2 Sep 2025 19:53:28 +0300
Onur <work@onurozkan.dev> wrote:

> On Thu, 14 Aug 2025 15:22:57 -0300
> Daniel Almeida <daniel.almeida@collabora.com> wrote:
>=20
> >=20
> > Hi Onur,
> >=20
> > > On 14 Aug 2025, at 12:56, Onur <work@onurozkan.dev> wrote:
> > >=20
> > > On Thu, 14 Aug 2025 09:38:38 -0300
> > > Daniel Almeida <daniel.almeida@collabora.com> wrote:
> > >=20
> > >> Hi Onur,
> > >>=20
> > >>> On 14 Aug 2025, at 08:13, Onur =C3=96zkan <work@onurozkan.dev> wrot=
e:
> > >>>=20
> > >>> Hi all,
> > >>>=20
> > >>> I have been brainstorming on the auto-unlocking (on dynamic
> > >>> number of mutexes) idea we have been discussing for some time.
> > >>>=20
> > >>> There is a challange with how we handle lock guards and my
> > >>> current thought is to remove direct data dereferencing from
> > >>> guards. Instead, data access would only be possible through a
> > >>> fallible method (e.g., `try_get`). If the guard is no longer
> > >>> valid, this method would fail to not allow data-accessing after
> > >>> auto-unlock.
> > >>>=20
> > >>> In practice, it would work like this:
> > >>>=20
> > >>> let a_guard =3D ctx.lock(mutex_a)?;
> > >>> let b_guard =3D ctx.lock(mutex_b)?;
> > >>>=20
> > >>> // Suppose user tries to lock `mutex_c` without aborting the
> > >>> // entire function (for some reason). This means that even on
> > >>> // failure, `a_guard` and `b_guard` will still be accessible.
> > >>> if let Ok(c_guard) =3D ctx.lock(mutex_c) {
> > >>>    // ...some logic
> > >>> }
> > >>>=20
> > >>> let a_data =3D a_guard.try_get()?;
> > >>> let b_data =3D b_guard.try_get()?;
> > >>=20
> > >> Can you add more code here? How is this going to look like with
> > >> the two closures we=E2=80=99ve been discussing?
> > >=20
> > > Didn't we said that tuple-based closures are not sufficient when
> > > dealing with a dynamic number of locks (ref [1]) and ww_mutex is
> > > mostly used with dynamic locks? I thought implementing that
> > > approach is not worth it (at least for now) because of that.
> > >=20
> > > [1]:
> > > https://lore.kernel.org/all/DBS8REY5E82S.3937FAHS25ANA@kernel.org
> > >=20
> > > Regards,
> > > Onur
> >=20
> >=20
> >=20
> > I am referring to this [0]. See the discussion and itemized list at
> > the end.
> >=20
> > To recap, I am proposing a separate type that is similar to
> > drm_exec, and that implements this:
> >=20
> > ```
> > a) run a user closure where the user can indicate which ww_mutexes
> > they want to lock b) keep track of the objects above
> > c) keep track of whether a contention happened
> > d) rollback if a contention happened, releasing all locks
> > e) rerun the user closure from a clean slate after rolling back
> > f) run a separate user closure whenever we know that all objects
> > have been locked. ```
> >=20
>=20
> Finally, I was able to allocate some time to work on this week. The
> implementation covers all the items you listed above.
>=20
> I am sharing some of the unit tests from my work. My intention is to
> demonstrate the user API and I would like your feedback on whether
> anything should be changed before I send the v6 patch.
>=20
>     #[test]
>     fn test_with_different_input_type() -> Result {
>         stack_pin_init!(let class =3D
>     WwClass::new_wound_wait(c_str!("lock_all_ok")));
>=20
>         let mu1 =3D Arc::pin_init(WwMutex::new(1, &class), GFP_KERNEL)?;
>         let mu2 =3D Arc::pin_init(WwMutex::new("hello", &class),
>         GFP_KERNEL)?;
>=20
>         lock_all(
>             &class,
>             |ctx| {
>                 ctx.lock(&mu1)?;
>                 ctx.lock(&mu2)?;
>                 Ok(())
>             },
>             |ctx| {
>                 ctx.with_locked(&mu1, |v| assert_eq!(*v, 1))?;
>                 ctx.with_locked(&mu2, |v| assert_eq!(*v, "hello"))?;
>                 Ok(())
>             },
>         )?;
>=20
>         Ok(())
>     }
>=20
>     #[test]
>     fn test_lock_all_retries_on_deadlock() -> Result {
>         stack_pin_init!(let class =3D
>     WwClass::new_wound_wait(c_str!("lock_all_retry")));
>=20
>         let mu =3D Arc::pin_init(WwMutex::new(99, &class), GFP_KERNEL)?;
>         let mut first_try =3D true;
>=20
>         let res =3D lock_all(
>             &class,
>             |ctx| {
>                 if first_try {
>                     first_try =3D false;
>                     // simulate deadlock on first attempt
>                     return Err(EDEADLK);
>                 }
>                 ctx.lock(&mu)
>             },
>             |ctx| {
>                 ctx.with_locked(&mu, |v| {
>                     *v +=3D 1;
>                     *v
>                 })
>             },
>         )?;
>=20
>         assert_eq!(res, 100);
>         Ok(())
>     }
>=20
>     #[test]
>     fn test_with_locked_on_unlocked_mutex() -> Result {
>         stack_pin_init!(let class =3D
>     WwClass::new_wound_wait(c_str!("with_unlocked_mutex")));
>=20
>         let mu =3D Arc::pin_init(WwMutex::new(5, &class), GFP_KERNEL)?;
>=20
>         let mut ctx =3D ExecContext::new(&class)?;
>=20
>         let ecode =3D ctx.with_locked(&mu, |_v| {}).unwrap_err();
>         assert_eq!(EINVAL, ecode);
>=20
>         Ok(())
>     }
>=20
>=20
> Please let me know if this looks fine in terms of user API so
> I can make any necessary adjustments before sending v6.
>=20
> Regards,
> Onur

There will be some changes to this API, I found some design issues on
it. Previously, lock_all was an individual function, I will
move it under `impl ExecContext` so that we can track more mutexes.

I will send v6 in a day or two. To avoid confusion, please ignore the
previous mail and review v6 directly since there will be some
differences.

Thanks,
Onur

