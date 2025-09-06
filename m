Return-Path: <linux-kernel+bounces-804171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0718BB46B7E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 13:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 702371B26881
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 11:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69EB428642A;
	Sat,  6 Sep 2025 11:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="PqlF00pE"
Received: from forward500d.mail.yandex.net (forward500d.mail.yandex.net [178.154.239.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4381A8F84;
	Sat,  6 Sep 2025 11:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757158562; cv=none; b=Y50CPJcxfiVejjmddRAVtP8qbpIvd4goz/8lZuvVSqxBPY1upsWjgw0M/w/kVRaIC1T2WOjqxR6kyHG/fY9heZeIAEhfTDmolBnePA6gycXYhq2cNRHEAmwxX9y+PcZu6TLnvenz1QmqonLDDx4goP0B9IrxjGO73xUdeHOp+JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757158562; c=relaxed/simple;
	bh=I38oPuW8lRi32IkWwiLzABakfRGFxHt+zF0uxWmmZ6I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tRrD8YtmlQJ92tyQAw2nYpOpLoVHEEOE+DjVw4qi84WLAyM9kvhxz3rXum7fWtKV2yhke3R2MB5set6mJ0LMPHHzLruz/WlGekRFaMxbxJtt18S6sv8h46IloLwnt634DU+0OTu9MEaD0vtUdmQTQrJurBngMSapU49ujM2CER8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=PqlF00pE; arc=none smtp.client-ip=178.154.239.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-84.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-84.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:418:0:640:bb5:0])
	by forward500d.mail.yandex.net (Yandex) with ESMTPS id C675A811C6;
	Sat, 06 Sep 2025 14:35:50 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-84.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id jZhg2eINw4Y0-hLOlQVS7;
	Sat, 06 Sep 2025 14:35:49 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1757158549;
	bh=MPjlFzrjLVAhdp7L3sXhsrrd1PVNpd15d6UL6WM3v8w=;
	h=Cc:Message-ID:Subject:Date:References:To:From:In-Reply-To;
	b=PqlF00pExGJBE9HvhdMnSvTaNUag8hCY9TU8iLh7YszEpwNdOqC92MpsC21dBp3UE
	 5qnds5k1d9p4/cZLvKURi9Iu9+Z1XnWLcVW4ewKKwoDdLabuTBwmRA2IxAQRMXLc11
	 gfs7sDk1YRFu4htE7KotQNaRyUoBQJLs42oaZk0g=
Authentication-Results: mail-nwsmtp-smtp-production-main-84.iva.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
Date: Sat, 6 Sep 2025 14:35:44 +0300
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
Message-ID: <20250906143544.3656ac45@nimda.home>
In-Reply-To: <886565B2-B5CD-49DA-9598-EBD60490C0DC@collabora.com>
References: <20250903131313.4365-1-work@onurozkan.dev>
	<20250903131313.4365-4-work@onurozkan.dev>
	<886565B2-B5CD-49DA-9598-EBD60490C0DC@collabora.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 5 Sep 2025 15:49:57 -0300
Daniel Almeida <daniel.almeida@collabora.com> wrote:

> Hi Onur,
>=20
> I think this is starting to come together IMHO. Some comments inline.
>=20
> > On 3 Sep 2025, at 10:13, Onur =C3=96zkan <work@onurozkan.dev> wrote:
> >=20
> > Includes full locking API (lock, try_lock, slow path, interruptible
> > variants) and integration with kernel bindings.
> >=20
> > Also adds the `EDEADLK` error code to support deadlock detection.
> >=20
> > Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>
> > ---
> > rust/kernel/error.rs              |   1 +
> > rust/kernel/sync/lock/ww_mutex.rs | 289
> > +++++++++++++++++++++++++++++- 2 files changed, 289 insertions(+),
> > 1 deletion(-)
> >=20
> > diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
> > index a41de293dcd1..560de6117094 100644
> > --- a/rust/kernel/error.rs
> > +++ b/rust/kernel/error.rs
> > @@ -64,6 +64,7 @@ macro_rules! declare_err {
> >     declare_err!(EPIPE, "Broken pipe.");
> >     declare_err!(EDOM, "Math argument out of domain of func.");
> >     declare_err!(ERANGE, "Math result not representable.");
> > +    declare_err!(EDEADLK, "Resource deadlock avoided.");
> >     declare_err!(EOVERFLOW, "Value too large for defined data
> > type."); declare_err!(ETIMEDOUT, "Connection timed out.");
> >     declare_err!(ERESTARTSYS, "Restart the system call.");
> > diff --git a/rust/kernel/sync/lock/ww_mutex.rs
> > b/rust/kernel/sync/lock/ww_mutex.rs index
> > ca5b4525ace6..314360632953 100644 ---
> > a/rust/kernel/sync/lock/ww_mutex.rs +++
> > b/rust/kernel/sync/lock/ww_mutex.rs @@ -10,8 +10,11 @@
> > //! For more information:
> > <https://docs.kernel.org/locking/ww-mutex-design.html>
> >=20
> > use crate::bindings;
> > +use crate::error::to_result;
> > use crate::prelude::*;
> > -use crate::types::Opaque;
> > +use crate::types::{NotThreadSafe, Opaque};
> > +use core::cell::UnsafeCell;
> > +use core::marker::PhantomData;
> >=20
> > /// Create static [`WwClass`] instances.
> > ///
> > @@ -134,3 +137,287 @@ pub fn new_wound_wait(name: &'static CStr) ->
> > impl PinInit<Self> { Self::new(name, false)
> >     }
> > }
> > +
> > +/// Groups multiple mutex acquisitions together for deadlock
> > avoidance. +///
> > +/// Must be used when acquiring multiple mutexes of the same class.
> > +///
> > +/// # Examples
> > +///
> > +/// ```
> > +/// use kernel::sync::lock::ww_mutex::{WwClass, WwAcquireCtx,
> > WwMutex}; +/// use kernel::c_str;
> > +/// use kernel::sync::Arc;
> > +/// use pin_init::stack_pin_init;
> > +///
> > +/// stack_pin_init!(let class =3D
> > WwClass::new_wound_wait(c_str!("my_class"))); +///
> > +/// // Create mutexes.
> > +/// let mutex1 =3D Arc::pin_init(WwMutex::new(1, &class),
> > GFP_KERNEL)?; +/// let mutex2 =3D Arc::pin_init(WwMutex::new(2,
> > &class), GFP_KERNEL)?; +///
> > +/// // Create acquire context for deadlock avoidance.
> > +/// let ctx =3D KBox::pin_init(WwAcquireCtx::new(&class),
> > GFP_KERNEL)?; +///
> > +/// // Acquire multiple locks safely.
> > +/// let guard1 =3D ctx.lock(&mutex1)?;
> > +/// let guard2 =3D ctx.lock(&mutex2)?;
> > +///
> > +/// // Mark acquisition phase as complete.
> > +/// ctx.done();
> > +///
> > +/// # Ok::<(), Error>(())
> > +/// ```
> > +#[pin_data(PinnedDrop)]
> > +pub struct WwAcquireCtx<'a> {
>=20
> Please drop the Ww prefix. This is ww_mutex.rs <http://ww_mutex.rs/>
> after all.
>=20
> > +    #[pin]
> > +    inner: Opaque<bindings::ww_acquire_ctx>,
> > +    _p: PhantomData<&'a WwClass>,
> > +}
> > +
> > +impl<'ww_class> WwAcquireCtx<'ww_class> {
> > +    /// Initializes `Self` with calling C side `ww_acquire_init`
> > inside.
> > +    pub fn new(ww_class: &'ww_class WwClass) -> impl PinInit<Self>
> > {
> > +        let class =3D ww_class.inner.get();
> > +        pin_init!(WwAcquireCtx {
> > +            inner <- Opaque::ffi_init(|slot: *mut
> > bindings::ww_acquire_ctx| {
> > +                // SAFETY: `ww_class` is valid for the lifetime
> > `'ww_class` captured by `Self`.
> > +                unsafe { bindings::ww_acquire_init(slot, class) }
> > +            }),
> > +            _p: PhantomData
> > +        })
> > +    }
> > +
> > +    /// Marks the end of the acquire phase.
> > +    ///
> > +    /// After calling this function, no more mutexes can be
> > acquired with this context.
> > +    pub fn done(&self) {
> > +        // SAFETY: The context is pinned and valid.
> > +        unsafe { bindings::ww_acquire_done(self.inner.get()) };
> > +    }
>=20
> This lets you call done() multiple times. We should probably use a
> typestate here.
>=20

Good point. I will see what I can do.

> > +
> > +    /// Locks the given mutex.
> > +    pub fn lock<'a, T>(&'a self, ww_mutex: &'a WwMutex<'a, T>) ->
> > Result<WwMutexGuard<'a, T>> {
>=20
> > +        // SAFETY: The mutex is pinned and valid.
> > +        let ret =3D unsafe {
> > bindings::ww_mutex_lock(ww_mutex.mutex.get(), self.inner.get()) }; +
> > +        to_result(ret)?;
> > +
> > +        Ok(WwMutexGuard::new(ww_mutex))
> > +    }
> > +
> > +    /// Similar to `lock`, but can be interrupted by signals.
> > +    pub fn lock_interruptible<'a, T>(
> > +        &'a self,
> > +        ww_mutex: &'a WwMutex<'a, T>,
> > +    ) -> Result<WwMutexGuard<'a, T>> {
> > +        // SAFETY: The mutex is pinned and valid.
> > +        let ret =3D unsafe {
> > +
> > bindings::ww_mutex_lock_interruptible(ww_mutex.mutex.get(),
> > self.inner.get())
> > +        };
> > +
> > +        to_result(ret)?;
> > +
> > +        Ok(WwMutexGuard::new(ww_mutex))
> > +    }
> > +
> > +    /// Locks the given mutex using the slow path.
> > +    ///
> > +    /// This function should be used when `lock` fails (typically
> > due to a potential deadlock).
> > +    pub fn lock_slow<'a, T>(&'a self, ww_mutex: &'a WwMutex<'a,
> > T>) -> Result<WwMutexGuard<'a, T>> {
> > +        // SAFETY: The mutex is pinned and valid, and we're in the
> > slow path.
> > +        unsafe {
> > bindings::ww_mutex_lock_slow(ww_mutex.mutex.get(),
> > self.inner.get()) }; +
> > +        Ok(WwMutexGuard::new(ww_mutex))
> > +    }
> > +
> > +    /// Similar to `lock_slow`, but can be interrupted by signals.
> > +    pub fn lock_slow_interruptible<'a, T>(
> > +        &'a self,
> > +        ww_mutex: &'a WwMutex<'a, T>,
> > +    ) -> Result<WwMutexGuard<'a, T>> {
> > +        // SAFETY: The mutex is pinned and valid, and we are in
> > the slow path.
> > +        let ret =3D unsafe {
> > +
> > bindings::ww_mutex_lock_slow_interruptible(ww_mutex.mutex.get(),
> > self.inner.get())
> > +        };
> > +
> > +        to_result(ret)?;
> > +
> > +        Ok(WwMutexGuard::new(ww_mutex))
> > +    }
> > +
> > +    /// Tries to lock the mutex without blocking.
> > +    ///
> > +    /// Unlike `lock`, no deadlock handling is performed.
> > +    pub fn try_lock<'a, T>(&'a self, ww_mutex: &'a WwMutex<'a, T>)
> > -> Result<WwMutexGuard<'a, T>> {
> > +        // SAFETY: The mutex is pinned and valid.
> > +        let ret =3D unsafe {
> > bindings::ww_mutex_trylock(ww_mutex.mutex.get(), self.inner.get())
> > }; +
> > +        if ret =3D=3D 0 {
> > +            return Err(EBUSY);
> > +        } else {
> > +            to_result(ret)?;
> > +        }
> > +
> > +        Ok(WwMutexGuard::new(ww_mutex))
> > +    }
> > +}
> > +
> > +#[pinned_drop]
> > +impl PinnedDrop for WwAcquireCtx<'_> {
> > +    fn drop(self: Pin<&mut Self>) {
> > +        // SAFETY: The context is being dropped and is pinned.
> > +        unsafe { bindings::ww_acquire_fini(self.inner.get()) };
> > +    }
> > +}
> > +
> > +/// A wound/wait mutex backed with C side `ww_mutex`.
> > +///
> > +/// This is a mutual exclusion primitive that provides deadlock
> > avoidance when +/// acquiring multiple locks of the same class.
>=20
> A link would be cool for the docs.
>=20
> > +///
> > +/// # Examples
> > +///
> > +/// ## Basic Usage
> > +///
> > +/// ```
> > +/// use kernel::c_str;
> > +/// use kernel::sync::Arc;
> > +/// use kernel::sync::lock::ww_mutex::{WwClass, WwAcquireCtx,
> > WwMutex }; +/// use pin_init::stack_pin_init;
> > +///
> > +/// stack_pin_init!(let class =3D
> > WwClass::new_wound_wait(c_str!("buffer_class"))); +/// let mutex =3D
> > Arc::pin_init(WwMutex::new(42, &class), GFP_KERNEL)?; +///
> > +/// let ctx =3D KBox::pin_init(WwAcquireCtx::new(&class),
> > GFP_KERNEL)?; +///
> > +/// let guard =3D ctx.lock(&mutex)?;
> > +/// assert_eq!(*guard, 42);
> > +///
> > +/// # Ok::<(), Error>(())
> > +/// ```
> > +///
> > +/// ## Multiple Locks
> > +///
> > +/// ```
> > +/// use kernel::c_str;
> > +/// use kernel::prelude::*;
> > +/// use kernel::sync::Arc;
> > +/// use kernel::sync::lock::ww_mutex::{WwClass, WwAcquireCtx,
> > WwMutex}; +/// use pin_init::stack_pin_init;
> > +///
> > +/// stack_pin_init!(let class =3D
> > WwClass::new_wait_die(c_str!("resource_class"))); +/// let mutex_a
> > =3D Arc::pin_init(WwMutex::new("Resource A", &class), GFP_KERNEL)?;
> > +/// let mutex_b =3D Arc::pin_init(WwMutex::new("Resource B",
> > &class), GFP_KERNEL)?; +/// +/// let ctx =3D
> > KBox::pin_init(WwAcquireCtx::new(&class), GFP_KERNEL)?; +///
> > +/// // Try to acquire both locks.
> > +/// let guard_a =3D match ctx.lock(&mutex_a) {
> > +///     Ok(guard) =3D> guard,
> > +///     Err(e) if e =3D=3D EDEADLK =3D> {
> > +///         // Deadlock detected, use slow path.
>=20
> You must release all other locks before calling this, except there
> aren=E2=80=99t any taken in your example.
>=20

True, thanks!

> You should perhaps add a release_all() function to the context.
>=20

Do you mean we should track guards in `WwAcquireCtx` wrapper? That
would drop the need for `ExecContext` (mostly), which is a good idea
IMO.

> > +///         ctx.lock_slow(&mutex_a)?
> > +///     }
> > +///     Err(e) =3D> return Err(e),
> > +/// };
> > +///
> > +/// let guard_b =3D ctx.lock(&mutex_b)?;
> > +/// ctx.done();
> > +///
> > +/// # Ok::<(), Error>(())
> > +/// ```
> > +#[pin_data]
> > +pub struct WwMutex<'a, T: ?Sized> {
> > +    _p: PhantomData<&'a WwClass>,
>=20
> Make the PhantomData last, please.
>=20
> > +    #[pin]
> > +    mutex: Opaque<bindings::ww_mutex>,
> > +    data: UnsafeCell<T>,
> > +}
> > +
> > +// SAFETY: [`WwMutex`] can be shared between threads.
> > +unsafe impl<T: ?Sized + Send> Send for WwMutex<'_, T> {}
>=20
> =E2=80=9CSend=E2=80=9D does not share anything. When you send something, =
some other
> thread has it, and you don=E2=80=99t have it anymore.
>=20
> Blank here.
>=20
> > +// SAFETY: [`WwMutex`] can be safely accessed from multiple
> > threads concurrently. +unsafe impl<T: ?Sized + Send + Sync> Sync
> > for WwMutex<'_, T> {} +
> > +impl<'ww_class, T> WwMutex<'ww_class, T> {
> > +    /// Creates `Self` with calling `ww_mutex_init` inside.
>=20
> ^ This does not parse very well.
>=20
> > +    pub fn new(t: T, ww_class: &'ww_class WwClass) -> impl
> > PinInit<Self> {
>=20
> Please rename =E2=80=9Ct=E2=80=9D to =E2=80=9Cdata=E2=80=9D.
>=20
> > +        let class =3D ww_class.inner.get();
> > +        pin_init!(WwMutex {
> > +            mutex <- Opaque::ffi_init(|slot: *mut
> > bindings::ww_mutex| {
> > +                // SAFETY: `ww_class` is valid for the lifetime
> > `'ww_class` captured by `Self`.
> > +                unsafe { bindings::ww_mutex_init(slot, class) }
> > +            }),
> > +            data: UnsafeCell::new(t),
> > +            _p: PhantomData,
> > +        })
> > +    }
> > +}
> > +
> > +impl<T: ?Sized> WwMutex<'_, T> {
>=20
> I wonder why we need this ?Sized here?
>=20

If I recall it correctly it was required by `self.mutex.get()` call. I
will re-check when I am working for the next patch.

> > +    /// Returns a raw pointer to the inner mutex.
> > +    fn as_ptr(&self) -> *mut bindings::ww_mutex {
> > +        self.mutex.get()
> > +    }
> > +
> > +    /// Checks if the mutex is currently locked.
> > +    ///
> > +    /// Intended for internal tests only and should not be used
> > +    /// anywhere else.
>=20
> Why?
>=20

It was requested by Boqun and Peter here [0].

[0]:
https://lore.kernel.org/rust-for-linux/aFReIdlPPg4MmaYX@tardis.local/

> > +    #[cfg(CONFIG_KUNIT)]
> > +    fn is_locked(&self) -> bool {
>=20
> I=E2=80=99d recommend removing this CONFIG_KUNIT and making this pub. You=
 can
> see that there are users for this function in the C code, like for
> example, dma_resv_is_locked().
>=20
> > +        // SAFETY: The mutex is pinned and valid.
> > +        unsafe { bindings::ww_mutex_is_locked(self.mutex.get()) }
> > +    }
> > +}
> > +
> > +/// A guard that provides exclusive access to the data protected
> > +/// by a [`WwMutex`].
> > +///
> > +/// # Invariants
> > +///
> > +/// The guard holds an exclusive lock on the associated
> > [`WwMutex`]. The lock is held +/// for the entire lifetime of this
> > guard and is automatically released when the +/// guard is dropped.
> > +#[must_use =3D "the lock unlocks immediately when the guard is
> > unused"] +pub struct WwMutexGuard<'a, T: ?Sized> {
> > +    mutex: &'a WwMutex<'a, T>,
> > +    _not_send: NotThreadSafe,
> > +}
> > +
> > +// SAFETY: [`WwMutexGuard`] can be shared between threads if the
> > data can. +unsafe impl<T: ?Sized + Sync> Sync for WwMutexGuard<'_,
> > T> {} +
> > +impl<'a, T: ?Sized> WwMutexGuard<'a, T> {
> > +    /// Creates a new guard for a locked mutex.
> > +    fn new(mutex: &'a WwMutex<'a, T>) -> Self {
> > +        Self {
> > +            mutex,
> > +            _not_send: NotThreadSafe,
> > +        }
> > +    }
> > +}
> > +
> > +impl<T: ?Sized> core::ops::Deref for WwMutexGuard<'_, T> {
> > +    type Target =3D T;
> > +
> > +    fn deref(&self) -> &Self::Target {
> > +        // SAFETY: We hold the lock, so we have exclusive access.
> > +        unsafe { &*self.mutex.data.get() }
> > +    }
> > +}
> > +
> > +impl<T: ?Sized> core::ops::DerefMut for WwMutexGuard<'_, T> {
> > +    fn deref_mut(&mut self) -> &mut Self::Target {
> > +        // SAFETY: We hold the lock, so we have exclusive access.
> > +        unsafe { &mut *self.mutex.data.get() }
> > +    }
>=20
> We need to add a bound on Unpin. See [0].
>=20
> > +}
> > +
> > +impl<T: ?Sized> Drop for WwMutexGuard<'_, T> {
> > +    fn drop(&mut self) {
> > +        // SAFETY: We hold the lock and are about to release it.
> > +        unsafe { bindings::ww_mutex_unlock(self.mutex.as_ptr()) };
> > +    }
> > +}
> > =E2=80=94
> > 2.50.0
> >=20
> >=20
>=20
> [0]:
> https://lore.kernel.org/rust-for-linux/20250828-lock-t-when-t-is-pinned-v=
2-1-b067c4b93fd6@collabora.com/
>=20


