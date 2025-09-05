Return-Path: <linux-kernel+bounces-803659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED24AB46369
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 21:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3262188D418
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 19:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A642284886;
	Fri,  5 Sep 2025 19:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="Eiu3MTNY"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64709277017;
	Fri,  5 Sep 2025 19:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757099745; cv=pass; b=cxSXVW3fhzLOMq2wJDxtaV918s0GCzzOLedC0NqesHyf4TW3qJuHyTX8GfUk7w6HKKMGK2E7T9OfgGTvjwpU1UxIN+Tdy/I1hLS4ZkqrEiC6JF2MhPsDbawuOVP6ekxDhDfwwYLm/53Xoms3gXDffOqjXIi/Rcb46FirWhkxXj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757099745; c=relaxed/simple;
	bh=trBhDSRJL/q/ncJORWjfQrIqushpjeF4tocI6nVuB3w=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=O2bxQcub/pQczSdgq2L1NFLY99tIw5odMMtN5wS/KIhavxIr86B+kKWB4y6C3M8Fv2V2qbg2B6n9iWYjcISjE2lhvu8NIBFMzvTcC4IKOuYd7J6AAw2l9CUhCm3KIknbHen1TSerp7Wsf/oN3lI+/7wuXYRoQCoXGPmoM5Erg2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=Eiu3MTNY; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1757099719; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GPuIRa4B5DjLIFyUlQGTAGWkOyiT9aaGq98KDEqpzF52Lta3zGtDdFNaS4yDvyBNTR9u3g9/43DqYlCnRXPr4MtcuRko03pMd5VsVgty0H5S4TISB4ZBIEzfU6Xiqv93cKiDi35XwFUdqKgOumtsBkbcNNxhi/gxQKon+oKbghI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757099719; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=iZKWdGoMZSzHsG7N/j90AWQmwC2OHQArmXaUatyRrCA=; 
	b=FQl1xrHyIiP8wipz/lHHj7VAch+GmLMGnaLwiE3prKOa3tHqqDpWZgFuEyZrB4YGDyDYe5frGfq6lccT/oZbX0wozqRh9DulDozdXtANVnDkG+dJWzg6v5nYjA/bZE/IjqJvPUy14qu7QgcE/N45OeOgXLry4kIroIvtzy8LNT8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757099719;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=iZKWdGoMZSzHsG7N/j90AWQmwC2OHQArmXaUatyRrCA=;
	b=Eiu3MTNYompjLL/sLMXOeB1mgytHruwVVtgQBMxuiv4dxv+w+ql7Y5AkGlPwxE3A
	OzCRftHODxAXvxGWSYYUJVpf6nIY2Zgdd5pZdM8SQg/72pBm2jyiimM9CLA7LpGK8kL
	1x/1A9nq3/3Nxw/NzAkxXk6ZxTBCoNhhBzYAtVe4=
Received: by mx.zohomail.com with SMTPS id 1757099715789316.60580073066524;
	Fri, 5 Sep 2025 12:15:15 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v6 5/7] rust: ww_mutex: add context-free locking functions
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250903131313.4365-6-work@onurozkan.dev>
Date: Fri, 5 Sep 2025 16:14:59 -0300
Cc: rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 lossin@kernel.org,
 lyude@redhat.com,
 ojeda@kernel.org,
 alex.gaynor@gmail.com,
 boqun.feng@gmail.com,
 gary@garyguo.net,
 a.hindborg@kernel.org,
 aliceryhl@google.com,
 tmgross@umich.edu,
 dakr@kernel.org,
 peterz@infradead.org,
 mingo@redhat.com,
 will@kernel.org,
 longman@redhat.com,
 felipe_life@live.com,
 daniel@sedlak.dev,
 bjorn3_gh@protonmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <392B3416-61A7-4A41-8BDA-3A114F23D3F8@collabora.com>
References: <20250903131313.4365-1-work@onurozkan.dev>
 <20250903131313.4365-6-work@onurozkan.dev>
To: =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External

Hi Onur

> On 3 Sep 2025, at 10:13, Onur =C3=96zkan <work@onurozkan.dev> wrote:
>=20
> Adds new `WwMutex` functions (`lock`, `lock_interruptible`,
> `lock_slow`, `lock_slow_interruptible` and `try_lock`) that
> can be used without `WwAcquireCtx`. This provides simpler API
> when deadlock avoidance grouping is not needed.
>=20
> Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>
> ---
> rust/kernel/sync/lock/ww_mutex.rs | 162 ++++++++++++++++++++++--------
> 1 file changed, 122 insertions(+), 40 deletions(-)
>=20
> diff --git a/rust/kernel/sync/lock/ww_mutex.rs =
b/rust/kernel/sync/lock/ww_mutex.rs
> index d289718d2c98..b415d6deae9b 100644
> --- a/rust/kernel/sync/lock/ww_mutex.rs
> +++ b/rust/kernel/sync/lock/ww_mutex.rs
> @@ -138,6 +138,75 @@ pub fn new_wound_wait(name: &'static CStr) -> =
impl PinInit<Self> {
>     }
> }
>=20
> +/// Locking kinds used by [`lock_common`] to unify internal FFI =
locking logic.

Can you please mention how this is not exposed to the outside world?

It should be obvious from its private visibility, but still.

> +#[derive(Copy, Clone, Debug)]
> +enum LockKind {
> +    /// Blocks until lock is acquired.
> +    Regular,
> +    /// Blocks but can be interrupted by signals.
> +    Interruptible,
> +    /// Used in slow path after deadlock detection.
> +    Slow,
> +    /// Slow path but interruptible.
> +    SlowInterruptible,
> +    /// Does not block, returns immediately if busy.
> +    Try,
> +}
> +
> +/// Internal helper that unifies the different locking kinds.
> +fn lock_common<'a, T: ?Sized>(
> +    ww_mutex: &'a WwMutex<'a, T>,
> +    ctx: Option<&WwAcquireCtx<'_>>,
> +    kind: LockKind,
> +) -> Result<WwMutexGuard<'a, T>> {
> +    let ctx_ptr =3D ctx.map_or(core::ptr::null_mut(), |c| =
c.inner.get());
> +
> +    match kind {
> +        LockKind::Regular =3D> {
> +            // SAFETY: `WwMutex` is always pinned. If `WwAcquireCtx` =
is `Some`, it is pinned,
> +            // if `None`, it is set to `core::ptr::null_mut()`. Both =
cases are safe.
> +            let ret =3D unsafe { =
bindings::ww_mutex_lock(ww_mutex.mutex.get(), ctx_ptr) };

Use an intermediary variable to refer to the actual function. Then call =
this
only once below the match statement.

This will consolidate all the safety comments and "to_result()" calls =
into a
single place, considerably reducing the clutter here.

> +
> +            to_result(ret)?;
> +        }
> +        LockKind::Interruptible =3D> {
> +            // SAFETY: `WwMutex` is always pinned. If `WwAcquireCtx` =
is `Some`, it is pinned,
> +            // if `None`, it is set to `core::ptr::null_mut()`. Both =
cases are safe.
> +            let ret =3D
> +                unsafe { =
bindings::ww_mutex_lock_interruptible(ww_mutex.mutex.get(), ctx_ptr) };
> +
> +            to_result(ret)?;
> +        }
> +        LockKind::Slow =3D> {
> +            // SAFETY: `WwMutex` is always pinned. If `WwAcquireCtx` =
is `Some`, it is pinned,
> +            // if `None`, it is set to `core::ptr::null_mut()`. Both =
cases are safe.
> +            unsafe { =
bindings::ww_mutex_lock_slow(ww_mutex.mutex.get(), ctx_ptr) };
> +        }
> +        LockKind::SlowInterruptible =3D> {
> +            // SAFETY: `WwMutex` is always pinned. If `WwAcquireCtx` =
is `Some`, it is pinned,
> +            // if `None`, it is set to `core::ptr::null_mut()`. Both =
cases are safe.
> +            let ret =3D unsafe {
> +                =
bindings::ww_mutex_lock_slow_interruptible(ww_mutex.mutex.get(), =
ctx_ptr)
> +            };
> +
> +            to_result(ret)?;
> +        }
> +        LockKind::Try =3D> {
> +            // SAFETY: `WwMutex` is always pinned. If `WwAcquireCtx` =
is `Some`, it is pinned,
> +            // if `None`, it is set to `core::ptr::null_mut()`. Both =
cases are safe.
> +            let ret =3D unsafe { =
bindings::ww_mutex_trylock(ww_mutex.mutex.get(), ctx_ptr) };
> +
> +            if ret =3D=3D 0 {
> +                return Err(EBUSY);
> +            } else {
> +                to_result(ret)?;
> +            }
> +        }
> +    };
> +
> +    Ok(WwMutexGuard::new(ww_mutex))
> +}
> +
> /// Groups multiple mutex acquisitions together for deadlock =
avoidance.
> ///
> /// Must be used when acquiring multiple mutexes of the same class.
> @@ -196,14 +265,9 @@ pub fn done(&self) {
>         unsafe { bindings::ww_acquire_done(self.inner.get()) };
>     }
>=20
> -    /// Locks the given mutex.
> +    /// Locks the given mutex on this acquire context =
([`WwAcquireCtx`]).
>     pub fn lock<'a, T>(&'a self, ww_mutex: &'a WwMutex<'a, T>) -> =
Result<WwMutexGuard<'a, T>> {
> -        // SAFETY: The mutex is pinned and valid.
> -        let ret =3D unsafe { =
bindings::ww_mutex_lock(ww_mutex.mutex.get(), self.inner.get()) };
> -
> -        to_result(ret)?;
> -
> -        Ok(WwMutexGuard::new(ww_mutex))
> +        lock_common(ww_mutex, Some(self), LockKind::Regular)
>     }
>=20
>     /// Similar to `lock`, but can be interrupted by signals.
> @@ -211,24 +275,14 @@ pub fn lock_interruptible<'a, T>(
>         &'a self,
>         ww_mutex: &'a WwMutex<'a, T>,
>     ) -> Result<WwMutexGuard<'a, T>> {
> -        // SAFETY: The mutex is pinned and valid.
> -        let ret =3D unsafe {
> -            =
bindings::ww_mutex_lock_interruptible(ww_mutex.mutex.get(), =
self.inner.get())
> -        };
> -
> -        to_result(ret)?;
> -
> -        Ok(WwMutexGuard::new(ww_mutex))
> +        lock_common(ww_mutex, Some(self), LockKind::Interruptible)
>     }
>=20
> -    /// Locks the given mutex using the slow path.
> +    /// Locks the given mutex on this acquire context =
([`WwAcquireCtx`]) using the slow path.
>     ///
>     /// This function should be used when `lock` fails (typically due =
to a potential deadlock).
>     pub fn lock_slow<'a, T>(&'a self, ww_mutex: &'a WwMutex<'a, T>) -> =
Result<WwMutexGuard<'a, T>> {
> -        // SAFETY: The mutex is pinned and valid, and we're in the =
slow path.
> -        unsafe { bindings::ww_mutex_lock_slow(ww_mutex.mutex.get(), =
self.inner.get()) };
> -
> -        Ok(WwMutexGuard::new(ww_mutex))
> +        lock_common(ww_mutex, Some(self), LockKind::Slow)
>     }
>=20
>     /// Similar to `lock_slow`, but can be interrupted by signals.
> @@ -236,30 +290,14 @@ pub fn lock_slow_interruptible<'a, T>(
>         &'a self,
>         ww_mutex: &'a WwMutex<'a, T>,
>     ) -> Result<WwMutexGuard<'a, T>> {
> -        // SAFETY: The mutex is pinned and valid, and we are in the =
slow path.
> -        let ret =3D unsafe {
> -            =
bindings::ww_mutex_lock_slow_interruptible(ww_mutex.mutex.get(), =
self.inner.get())
> -        };
> -
> -        to_result(ret)?;
> -
> -        Ok(WwMutexGuard::new(ww_mutex))
> +        lock_common(ww_mutex, Some(self), =
LockKind::SlowInterruptible)
>     }
>=20
> -    /// Tries to lock the mutex without blocking.
> +    /// Tries to lock the mutex on this acquire context =
([`WwAcquireCtx`]) without blocking.
>     ///
>     /// Unlike `lock`, no deadlock handling is performed.
>     pub fn try_lock<'a, T>(&'a self, ww_mutex: &'a WwMutex<'a, T>) -> =
Result<WwMutexGuard<'a, T>> {
> -        // SAFETY: The mutex is pinned and valid.
> -        let ret =3D unsafe { =
bindings::ww_mutex_trylock(ww_mutex.mutex.get(), self.inner.get()) };
> -
> -        if ret =3D=3D 0 {
> -            return Err(EBUSY);
> -        } else {
> -            to_result(ret)?;
> -        }
> -
> -        Ok(WwMutexGuard::new(ww_mutex))
> +        lock_common(ww_mutex, Some(self), LockKind::Try)
>     }
> }
>=20
> @@ -355,7 +393,7 @@ pub fn new(t: T, ww_class: &'ww_class WwClass) -> =
impl PinInit<Self> {
>     }
> }
>=20
> -impl<T: ?Sized> WwMutex<'_, T> {
> +impl<'ww_class, T: ?Sized> WwMutex<'ww_class, T> {
>     /// Returns a raw pointer to the inner mutex.
>     fn as_ptr(&self) -> *mut bindings::ww_mutex {
>         self.mutex.get()
> @@ -370,6 +408,35 @@ fn is_locked(&self) -> bool {
>         // SAFETY: The mutex is pinned and valid.
>         unsafe { bindings::ww_mutex_is_locked(self.mutex.get()) }
>     }
> +
> +    /// Locks the given mutex without acquire context =
([`WwAcquireCtx`]).
> +    pub fn lock<'a>(&'a self) -> Result<WwMutexGuard<'a, T>> {
> +        lock_common(self, None, LockKind::Regular)
> +    }
> +
> +    /// Similar to `lock`, but can be interrupted by signals.
> +    pub fn lock_interruptible<'a>(&'a self) -> =
Result<WwMutexGuard<'a, T>> {
> +        lock_common(self, None, LockKind::Interruptible)
> +    }
> +
> +    /// Locks the given mutex without acquire context =
([`WwAcquireCtx`]) using the slow path.
> +    ///
> +    /// This function should be used when `lock` fails (typically due =
to a potential deadlock).
> +    pub fn lock_slow<'a>(&'a self) -> Result<WwMutexGuard<'a, T>> {
> +        lock_common(self, None, LockKind::Slow)
> +    }
> +
> +    /// Similar to `lock_slow`, but can be interrupted by signals.
> +    pub fn lock_slow_interruptible<'a>(&'a self) -> =
Result<WwMutexGuard<'a, T>> {
> +        lock_common(self, None, LockKind::SlowInterruptible)
> +    }
> +
> +    /// Tries to lock the mutex without acquire context =
([`WwAcquireCtx`]) and without blocking.

=E2=80=9CWith no acquire context=E2=80=9D.

> +    ///
> +    /// Unlike `lock`, no deadlock handling is performed.
> +    pub fn try_lock<'a>(&'a self) -> Result<WwMutexGuard<'a, T>> {
> +        lock_common(self, None, LockKind::Try)
> +    }
> }
>=20
> /// A guard that provides exclusive access to the data protected
> @@ -547,4 +614,19 @@ fn test_with_global_classes() -> Result {
>=20
>         Ok(())
>     }
> +
> +    #[test]
> +    fn test_mutex_without_ctx() -> Result {
> +        let mutex =3D Arc::pin_init(WwMutex::new(100, =
&TEST_WOUND_WAIT_CLASS), GFP_KERNEL)?;
> +        let guard =3D mutex.lock()?;
> +
> +        assert_eq!(*guard, 100);
> +        assert!(mutex.is_locked());
> +
> +        drop(guard);
> +
> +        assert!(!mutex.is_locked());
> +
> +        Ok(())
> +    }
> }
> --
> 2.50.0
>=20
>=20


