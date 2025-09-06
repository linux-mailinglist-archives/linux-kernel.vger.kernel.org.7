Return-Path: <linux-kernel+bounces-804169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A002BB46B50
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 13:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E9983AFA87
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 11:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500392836A3;
	Sat,  6 Sep 2025 11:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="VG5EH3ik"
Received: from forward502a.mail.yandex.net (forward502a.mail.yandex.net [178.154.239.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040C42165E2;
	Sat,  6 Sep 2025 11:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757158103; cv=none; b=SK7Wf7KftJGSKIXz9MfplteuoCLDXlV55wKRWASx7NKZuRrrZ9Cl4YX7vdaQIfL4IPlr87qEjFiWSr2ccDAkCBFZR7M1e8JOxgmqy/hfikFjLDS+J5dudh9zRwQGA5Yf8tbLXZzen6vTFSNxdVswDIdntRnQHjb49Uc9p5IFGik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757158103; c=relaxed/simple;
	bh=MrP8jt3+NKI4KBa5MR5lEb7qK4sSqVmSyRr5DvEMErg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QONuH4cWtWb0vlbjhd3JRmvnLBgpbGq3Ue5ERvgv0vckEYn+ap1Sqpxpg46Tk0c9bG4PVMep2PCxIrY4OqjcEbEF0Rsfc9J5Bc4f2Yx/O27twhn0mTFYGFx7mONMHy28z6m8n6h8deS0d5WzzGlGd2rhZN2zNUkirKZN6Cgl3ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=VG5EH3ik; arc=none smtp.client-ip=178.154.239.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-88.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-88.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:14a6:0:640:e35f:0])
	by forward502a.mail.yandex.net (Yandex) with ESMTPS id 79CCE81152;
	Sat, 06 Sep 2025 14:21:04 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-88.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id xKhrQWhM1eA0-dl8zAIlT;
	Sat, 06 Sep 2025 14:21:03 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1757157663;
	bh=9J6cIE61cUlbr0W2N2gsc8+dpG5X8UO0m1iQ9d4R7tE=;
	h=Cc:Message-ID:Subject:Date:References:To:From:In-Reply-To;
	b=VG5EH3ikwCvms4tzh6vbJucdHnAY0fml6tE0irNpPpSekqNHd/9MgRfQ1k7GfGwcJ
	 p9HPX3BgIg6RLWtOt5CQyKcfWJfGr3YsIW41exbH1wT0Iw5Nb+UyjQfGAqt/tCXiFT
	 HcSzAkNJznOtxUZXUMjlpqtYDe0t4QJKJ9ORpb58=
Authentication-Results: mail-nwsmtp-smtp-production-main-88.iva.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
Date: Sat, 6 Sep 2025 14:20:59 +0300
From: Onur <work@onurozkan.dev>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 lossin@kernel.org, lyude@redhat.com, ojeda@kernel.org,
 alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
 a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
 dakr@kernel.org, peterz@infradead.org, mingo@redhat.com, will@kernel.org,
 longman@redhat.com, felipe_life@live.com, daniel@sedlak.dev,
 bjorn3_gh@protonmail.com
Subject: Re: [PATCH v6 5/7] rust: ww_mutex: add context-free locking
 functions
Message-ID: <20250906142059.35bf5fc1@nimda.home>
In-Reply-To: <392B3416-61A7-4A41-8BDA-3A114F23D3F8@collabora.com>
References: <20250903131313.4365-1-work@onurozkan.dev>
	<20250903131313.4365-6-work@onurozkan.dev>
	<392B3416-61A7-4A41-8BDA-3A114F23D3F8@collabora.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 5 Sep 2025 16:14:59 -0300
Daniel Almeida <daniel.almeida@collabora.com> wrote:

> Hi Onur
>=20
> > On 3 Sep 2025, at 10:13, Onur =C3=96zkan <work@onurozkan.dev> wrote:
> >=20
> > Adds new `WwMutex` functions (`lock`, `lock_interruptible`,
> > `lock_slow`, `lock_slow_interruptible` and `try_lock`) that
> > can be used without `WwAcquireCtx`. This provides simpler API
> > when deadlock avoidance grouping is not needed.
> >=20
> > Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>
> > ---
> > rust/kernel/sync/lock/ww_mutex.rs | 162
> > ++++++++++++++++++++++-------- 1 file changed, 122 insertions(+),
> > 40 deletions(-)
> >=20
> > diff --git a/rust/kernel/sync/lock/ww_mutex.rs
> > b/rust/kernel/sync/lock/ww_mutex.rs index
> > d289718d2c98..b415d6deae9b 100644 ---
> > a/rust/kernel/sync/lock/ww_mutex.rs +++
> > b/rust/kernel/sync/lock/ww_mutex.rs @@ -138,6 +138,75 @@ pub fn
> > new_wound_wait(name: &'static CStr) -> impl PinInit<Self> { }
> > }
> >=20
> > +/// Locking kinds used by [`lock_common`] to unify internal FFI
> > locking logic.
>=20
> Can you please mention how this is not exposed to the outside world?
>=20
> It should be obvious from its private visibility, but still.
>=20

I would like to keep this private and force users to go through the
public ones. This function contains the entire internal locking logic
and its signature may need to change if we update any of the internals.
Since it's private, we can safely make breaking changes without
affecting external calls.

The public functions on the other hand are much more stable (at worst,
only one or two of them might need a breaking change).

> > +#[derive(Copy, Clone, Debug)]
> > +enum LockKind {
> > +    /// Blocks until lock is acquired.
> > +    Regular,
> > +    /// Blocks but can be interrupted by signals.
> > +    Interruptible,
> > +    /// Used in slow path after deadlock detection.
> > +    Slow,
> > +    /// Slow path but interruptible.
> > +    SlowInterruptible,
> > +    /// Does not block, returns immediately if busy.
> > +    Try,
> > +}
> > +
> > +/// Internal helper that unifies the different locking kinds.
> > +fn lock_common<'a, T: ?Sized>(
> > +    ww_mutex: &'a WwMutex<'a, T>,
> > +    ctx: Option<&WwAcquireCtx<'_>>,
> > +    kind: LockKind,
> > +) -> Result<WwMutexGuard<'a, T>> {
> > +    let ctx_ptr =3D ctx.map_or(core::ptr::null_mut(), |c|
> > c.inner.get()); +
> > +    match kind {
> > +        LockKind::Regular =3D> {
> > +            // SAFETY: `WwMutex` is always pinned. If
> > `WwAcquireCtx` is `Some`, it is pinned,
> > +            // if `None`, it is set to `core::ptr::null_mut()`.
> > Both cases are safe.
> > +            let ret =3D unsafe {
> > bindings::ww_mutex_lock(ww_mutex.mutex.get(), ctx_ptr) };
>=20
> Use an intermediary variable to refer to the actual function. Then
> call this only once below the match statement.
>=20
> This will consolidate all the safety comments and "to_result()" calls
> into a single place, considerably reducing the clutter here.
>

Good idea!
=20
> > +
> > +            to_result(ret)?;
> > +        }
> > +        LockKind::Interruptible =3D> {
> > +            // SAFETY: `WwMutex` is always pinned. If
> > `WwAcquireCtx` is `Some`, it is pinned,
> > +            // if `None`, it is set to `core::ptr::null_mut()`.
> > Both cases are safe.
> > +            let ret =3D
> > +                unsafe {
> > bindings::ww_mutex_lock_interruptible(ww_mutex.mutex.get(),
> > ctx_ptr) }; +
> > +            to_result(ret)?;
> > +        }
> > +        LockKind::Slow =3D> {
> > +            // SAFETY: `WwMutex` is always pinned. If
> > `WwAcquireCtx` is `Some`, it is pinned,
> > +            // if `None`, it is set to `core::ptr::null_mut()`.
> > Both cases are safe.
> > +            unsafe {
> > bindings::ww_mutex_lock_slow(ww_mutex.mutex.get(), ctx_ptr) };
> > +        }
> > +        LockKind::SlowInterruptible =3D> {
> > +            // SAFETY: `WwMutex` is always pinned. If
> > `WwAcquireCtx` is `Some`, it is pinned,
> > +            // if `None`, it is set to `core::ptr::null_mut()`.
> > Both cases are safe.
> > +            let ret =3D unsafe {
> > +
> > bindings::ww_mutex_lock_slow_interruptible(ww_mutex.mutex.get(),
> > ctx_ptr)
> > +            };
> > +
> > +            to_result(ret)?;
> > +        }
> > +        LockKind::Try =3D> {
> > +            // SAFETY: `WwMutex` is always pinned. If
> > `WwAcquireCtx` is `Some`, it is pinned,
> > +            // if `None`, it is set to `core::ptr::null_mut()`.
> > Both cases are safe.
> > +            let ret =3D unsafe {
> > bindings::ww_mutex_trylock(ww_mutex.mutex.get(), ctx_ptr) }; +
> > +            if ret =3D=3D 0 {
> > +                return Err(EBUSY);
> > +            } else {
> > +                to_result(ret)?;
> > +            }
> > +        }
> > +    };
> > +
> > +    Ok(WwMutexGuard::new(ww_mutex))
> > +}
> > +
> > /// Groups multiple mutex acquisitions together for deadlock
> > avoidance. ///
> > /// Must be used when acquiring multiple mutexes of the same class.
> > @@ -196,14 +265,9 @@ pub fn done(&self) {
> >         unsafe { bindings::ww_acquire_done(self.inner.get()) };
> >     }
> >=20
> > -    /// Locks the given mutex.
> > +    /// Locks the given mutex on this acquire context
> > ([`WwAcquireCtx`]). pub fn lock<'a, T>(&'a self, ww_mutex: &'a
> > WwMutex<'a, T>) -> Result<WwMutexGuard<'a, T>> {
> > -        // SAFETY: The mutex is pinned and valid.
> > -        let ret =3D unsafe {
> > bindings::ww_mutex_lock(ww_mutex.mutex.get(), self.inner.get()) }; -
> > -        to_result(ret)?;
> > -
> > -        Ok(WwMutexGuard::new(ww_mutex))
> > +        lock_common(ww_mutex, Some(self), LockKind::Regular)
> >     }
> >=20
> >     /// Similar to `lock`, but can be interrupted by signals.
> > @@ -211,24 +275,14 @@ pub fn lock_interruptible<'a, T>(
> >         &'a self,
> >         ww_mutex: &'a WwMutex<'a, T>,
> >     ) -> Result<WwMutexGuard<'a, T>> {
> > -        // SAFETY: The mutex is pinned and valid.
> > -        let ret =3D unsafe {
> > -
> > bindings::ww_mutex_lock_interruptible(ww_mutex.mutex.get(),
> > self.inner.get())
> > -        };
> > -
> > -        to_result(ret)?;
> > -
> > -        Ok(WwMutexGuard::new(ww_mutex))
> > +        lock_common(ww_mutex, Some(self), LockKind::Interruptible)
> >     }
> >=20
> > -    /// Locks the given mutex using the slow path.
> > +    /// Locks the given mutex on this acquire context
> > ([`WwAcquireCtx`]) using the slow path. ///
> >     /// This function should be used when `lock` fails (typically
> > due to a potential deadlock). pub fn lock_slow<'a, T>(&'a self,
> > ww_mutex: &'a WwMutex<'a, T>) -> Result<WwMutexGuard<'a, T>> {
> > -        // SAFETY: The mutex is pinned and valid, and we're in the
> > slow path.
> > -        unsafe {
> > bindings::ww_mutex_lock_slow(ww_mutex.mutex.get(),
> > self.inner.get()) }; -
> > -        Ok(WwMutexGuard::new(ww_mutex))
> > +        lock_common(ww_mutex, Some(self), LockKind::Slow)
> >     }
> >=20
> >     /// Similar to `lock_slow`, but can be interrupted by signals.
> > @@ -236,30 +290,14 @@ pub fn lock_slow_interruptible<'a, T>(
> >         &'a self,
> >         ww_mutex: &'a WwMutex<'a, T>,
> >     ) -> Result<WwMutexGuard<'a, T>> {
> > -        // SAFETY: The mutex is pinned and valid, and we are in
> > the slow path.
> > -        let ret =3D unsafe {
> > -
> > bindings::ww_mutex_lock_slow_interruptible(ww_mutex.mutex.get(),
> > self.inner.get())
> > -        };
> > -
> > -        to_result(ret)?;
> > -
> > -        Ok(WwMutexGuard::new(ww_mutex))
> > +        lock_common(ww_mutex, Some(self),
> > LockKind::SlowInterruptible) }
> >=20
> > -    /// Tries to lock the mutex without blocking.
> > +    /// Tries to lock the mutex on this acquire context
> > ([`WwAcquireCtx`]) without blocking. ///
> >     /// Unlike `lock`, no deadlock handling is performed.
> >     pub fn try_lock<'a, T>(&'a self, ww_mutex: &'a WwMutex<'a, T>)
> > -> Result<WwMutexGuard<'a, T>> {
> > -        // SAFETY: The mutex is pinned and valid.
> > -        let ret =3D unsafe {
> > bindings::ww_mutex_trylock(ww_mutex.mutex.get(), self.inner.get())
> > }; -
> > -        if ret =3D=3D 0 {
> > -            return Err(EBUSY);
> > -        } else {
> > -            to_result(ret)?;
> > -        }
> > -
> > -        Ok(WwMutexGuard::new(ww_mutex))
> > +        lock_common(ww_mutex, Some(self), LockKind::Try)
> >     }
> > }
> >=20
> > @@ -355,7 +393,7 @@ pub fn new(t: T, ww_class: &'ww_class WwClass)
> > -> impl PinInit<Self> { }
> > }
> >=20
> > -impl<T: ?Sized> WwMutex<'_, T> {
> > +impl<'ww_class, T: ?Sized> WwMutex<'ww_class, T> {
> >     /// Returns a raw pointer to the inner mutex.
> >     fn as_ptr(&self) -> *mut bindings::ww_mutex {
> >         self.mutex.get()
> > @@ -370,6 +408,35 @@ fn is_locked(&self) -> bool {
> >         // SAFETY: The mutex is pinned and valid.
> >         unsafe { bindings::ww_mutex_is_locked(self.mutex.get()) }
> >     }
> > +
> > +    /// Locks the given mutex without acquire context
> > ([`WwAcquireCtx`]).
> > +    pub fn lock<'a>(&'a self) -> Result<WwMutexGuard<'a, T>> {
> > +        lock_common(self, None, LockKind::Regular)
> > +    }
> > +
> > +    /// Similar to `lock`, but can be interrupted by signals.
> > +    pub fn lock_interruptible<'a>(&'a self) ->
> > Result<WwMutexGuard<'a, T>> {
> > +        lock_common(self, None, LockKind::Interruptible)
> > +    }
> > +
> > +    /// Locks the given mutex without acquire context
> > ([`WwAcquireCtx`]) using the slow path.
> > +    ///
> > +    /// This function should be used when `lock` fails (typically
> > due to a potential deadlock).
> > +    pub fn lock_slow<'a>(&'a self) -> Result<WwMutexGuard<'a, T>> {
> > +        lock_common(self, None, LockKind::Slow)
> > +    }
> > +
> > +    /// Similar to `lock_slow`, but can be interrupted by signals.
> > +    pub fn lock_slow_interruptible<'a>(&'a self) ->
> > Result<WwMutexGuard<'a, T>> {
> > +        lock_common(self, None, LockKind::SlowInterruptible)
> > +    }
> > +
> > +    /// Tries to lock the mutex without acquire context
> > ([`WwAcquireCtx`]) and without blocking.
>=20
> =E2=80=9CWith no acquire context=E2=80=9D.
>=20
> > +    ///
> > +    /// Unlike `lock`, no deadlock handling is performed.
> > +    pub fn try_lock<'a>(&'a self) -> Result<WwMutexGuard<'a, T>> {
> > +        lock_common(self, None, LockKind::Try)
> > +    }
> > }
> >=20
> > /// A guard that provides exclusive access to the data protected
> > @@ -547,4 +614,19 @@ fn test_with_global_classes() -> Result {
> >=20
> >         Ok(())
> >     }
> > +
> > +    #[test]
> > +    fn test_mutex_without_ctx() -> Result {
> > +        let mutex =3D Arc::pin_init(WwMutex::new(100,
> > &TEST_WOUND_WAIT_CLASS), GFP_KERNEL)?;
> > +        let guard =3D mutex.lock()?;
> > +
> > +        assert_eq!(*guard, 100);
> > +        assert!(mutex.is_locked());
> > +
> > +        drop(guard);
> > +
> > +        assert!(!mutex.is_locked());
> > +
> > +        Ok(())
> > +    }
> > }
> > --
> > 2.50.0
> >=20
> >=20
>=20


