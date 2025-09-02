Return-Path: <linux-kernel+bounces-797065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE49B40B60
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 19:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 479971A86F17
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 17:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99393341651;
	Tue,  2 Sep 2025 16:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="lFhvMuUn"
Received: from forward500a.mail.yandex.net (forward500a.mail.yandex.net [178.154.239.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8757C338F22;
	Tue,  2 Sep 2025 16:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756832375; cv=none; b=ZnZrJeQ9AL0F34t3+iCmyrGtIBLYxOadalJljkRwBQ6w5qTcbht9lXY2wVo8WTcxNAEizwIcHUz/BTiDSo2FmzSLWcQi3eGrwKA94jhuyBRT5ce5hAtN64typA8GzUQHObpcqRsxOcM+crbxQRowdMLsUvj3qtKSpSLDvw5AKHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756832375; c=relaxed/simple;
	bh=qFnTN56sB7klTE/kTUgYsnLu/b/+XZos+9jGaW7e2nc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BeXKXBaUQl9jV8+h0xjZ5siuB/7T00TNhKGVarITesChmfqS3BaGYsRB/L4LS2o0vTC8/EtwLy1DlCUkWK4gaCbfmA/HSQhjMRGlCGpQAw7LRIGeq9t0KQ4djf7fTFnc3t7S7EIZRz0Rfz/lqa5zJxQURBn9h3MnTqYolEh7i4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=lFhvMuUn; arc=none smtp.client-ip=178.154.239.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-81.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-81.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0f:571a:0:640:23e3:0])
	by forward500a.mail.yandex.net (Yandex) with ESMTPS id BF93D81022;
	Tue, 02 Sep 2025 19:53:34 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-81.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id SriSpSnM4qM0-TBd5IlpC;
	Tue, 02 Sep 2025 19:53:33 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1756832013;
	bh=xa7umx4Lfjhq/cyvWV7Gk2Jm4uEENeyJxqeKfOkYBA8=;
	h=Cc:Message-ID:Subject:Date:References:To:From:In-Reply-To;
	b=lFhvMuUn47FkuNTCEr3SnWpEOHS9SXg7MF92lxirfOfNllxTb8I+0+5t47mnqdiwu
	 eipCbokzD8pKz7tbUDGt08wfifVDUkzA4vIVviVdovbFA9hnmxhb9qEYd0JDrQpAIe
	 hK9rC3WldTAJL7rVRUBPox4aErrG/BOwDZOZRCZk=
Authentication-Results: mail-nwsmtp-smtp-production-main-81.vla.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
Date: Tue, 2 Sep 2025 19:53:28 +0300
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
Message-ID: <20250902195328.6293b5d4@nimda.home>
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
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-unknown-linux-gnu)
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

Finally, I was able to allocate some time to work on this week. The
implementation covers all the items you listed above.

I am sharing some of the unit tests from my work. My intention is to
demonstrate the user API and I would like your feedback on whether
anything should be changed before I send the v6 patch.

    #[test]
    fn test_with_different_input_type() -> Result {
        stack_pin_init!(let class =3D
    WwClass::new_wound_wait(c_str!("lock_all_ok")));

        let mu1 =3D Arc::pin_init(WwMutex::new(1, &class), GFP_KERNEL)?;
        let mu2 =3D Arc::pin_init(WwMutex::new("hello", &class),
        GFP_KERNEL)?;

        lock_all(
            &class,
            |ctx| {
                ctx.lock(&mu1)?;
                ctx.lock(&mu2)?;
                Ok(())
            },
            |ctx| {
                ctx.with_locked(&mu1, |v| assert_eq!(*v, 1))?;
                ctx.with_locked(&mu2, |v| assert_eq!(*v, "hello"))?;
                Ok(())
            },
        )?;

        Ok(())
    }

    #[test]
    fn test_lock_all_retries_on_deadlock() -> Result {
        stack_pin_init!(let class =3D
    WwClass::new_wound_wait(c_str!("lock_all_retry")));

        let mu =3D Arc::pin_init(WwMutex::new(99, &class), GFP_KERNEL)?;
        let mut first_try =3D true;

        let res =3D lock_all(
            &class,
            |ctx| {
                if first_try {
                    first_try =3D false;
                    // simulate deadlock on first attempt
                    return Err(EDEADLK);
                }
                ctx.lock(&mu)
            },
            |ctx| {
                ctx.with_locked(&mu, |v| {
                    *v +=3D 1;
                    *v
                })
            },
        )?;

        assert_eq!(res, 100);
        Ok(())
    }

    #[test]
    fn test_with_locked_on_unlocked_mutex() -> Result {
        stack_pin_init!(let class =3D
    WwClass::new_wound_wait(c_str!("with_unlocked_mutex")));

        let mu =3D Arc::pin_init(WwMutex::new(5, &class), GFP_KERNEL)?;

        let mut ctx =3D ExecContext::new(&class)?;

        let ecode =3D ctx.with_locked(&mu, |_v| {}).unwrap_err();
        assert_eq!(EINVAL, ecode);

        Ok(())
    }


Please let me know if this looks fine in terms of user API so
I can make any necessary adjustments before sending v6.

Regards,
Onur

