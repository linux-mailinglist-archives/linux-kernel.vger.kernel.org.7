Return-Path: <linux-kernel+bounces-803599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D2EB462DD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 20:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59BB43BCC8A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 18:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FC028312E;
	Fri,  5 Sep 2025 18:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="ZrjfXZXA"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45DF27E07F;
	Fri,  5 Sep 2025 18:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757098248; cv=pass; b=rz/KM24TV5BRFX0fxeEjXS8eisLuQ5jBpHHjYCqlbr2pGcjcvgZw+OaKL8xLxXrdkksKxjjDxpRXcrAcrPOUlmYTdLOKV2lbvKObqzCGMt8LP65d0s9GEUgi/A4QGsBPTfdjztYk3h1wnVtt3xtGl7wzHpFDi2jb6aR3C67+67g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757098248; c=relaxed/simple;
	bh=psnnZEHO1jLg6QFHHneQeik3rC53a/rYz22ZqHoWlAc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=TAEHR7qFoH/A+wYMnr4Lj/ZdkVsFn6WI55XwuvZjmJwYE3ruTVVmmyNHN0H2nK74zUzxzqjqjbvI3UV3hGE9ABtLVQt5wmLDgOpkWPhRwRBe5cd4OfCZiF592MIzx1+8nzkJawqAmyVSfIn7f7yxS6NHDGFkFa6UphqUpekxSi4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=ZrjfXZXA; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1757098216; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=MGszn2MP1l39+Iqv8mWTs3TJdW8srp547RJ61/GwtVjJPYGiuG3NhhVmSXustrTduRk8BkLPAgdgOdW6attE/vJqrlYTneTVkkWKohFvcqK9lJ8c6QVgB3SJZ9Jyr088XiYIhU2RQa9SiVnGiEELmz+qMhoWMQVGrY84qJ3iFgE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757098216; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=8RQIiHyNynBWq6LtRFAmJpE3Kl8lr5mXan0DTdyIJrM=; 
	b=kVGm408EeF49iGab28OTDPun0UTb7ci+26wsAgYUbAClzN/5pWQUyCxQ0vb3cr96mi9z5ByYgZPBzedPZVRs5gU4YykIgr7TruzioShmFBO2c3J8NUbvfU7JatHZEWb0mCui1VbjbFPNgYcsLg6mJMsvEmLVyko8wS/M7d/0XYs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757098216;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=8RQIiHyNynBWq6LtRFAmJpE3Kl8lr5mXan0DTdyIJrM=;
	b=ZrjfXZXA/qRCIOMKo5HNkBJ44NEJXSLVVgopwjDNo8fP9lBMQQc/44ul7VOvjycG
	T+TO5uZxaaPW0rwztqecFrvSMl9GACbTiFDm6x9D/E17qliOw3rZwEGn/jYqH8CfuBo
	EAqv4HSELpsr4nHc5KTlnpQTXpEt5WAnrppdceGU=
Received: by mx.zohomail.com with SMTPS id 1757098215259640.9815782272678;
	Fri, 5 Sep 2025 11:50:15 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v6 3/7] rust: implement `WwMutex`, `WwAcquireCtx` and
 `WwMutexGuard`
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250903131313.4365-4-work@onurozkan.dev>
Date: Fri, 5 Sep 2025 15:49:57 -0300
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
Message-Id: <886565B2-B5CD-49DA-9598-EBD60490C0DC@collabora.com>
References: <20250903131313.4365-1-work@onurozkan.dev>
 <20250903131313.4365-4-work@onurozkan.dev>
To: =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External

Hi Onur,

I think this is starting to come together IMHO. Some comments inline.

> On 3 Sep 2025, at 10:13, Onur =C3=96zkan <work@onurozkan.dev> wrote:
>=20
> Includes full locking API (lock, try_lock, slow path, interruptible =
variants)
> and integration with kernel bindings.
>=20
> Also adds the `EDEADLK` error code to support deadlock detection.
>=20
> Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>
> ---
> rust/kernel/error.rs              |   1 +
> rust/kernel/sync/lock/ww_mutex.rs | 289 +++++++++++++++++++++++++++++-
> 2 files changed, 289 insertions(+), 1 deletion(-)
>=20
> diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
> index a41de293dcd1..560de6117094 100644
> --- a/rust/kernel/error.rs
> +++ b/rust/kernel/error.rs
> @@ -64,6 +64,7 @@ macro_rules! declare_err {
>     declare_err!(EPIPE, "Broken pipe.");
>     declare_err!(EDOM, "Math argument out of domain of func.");
>     declare_err!(ERANGE, "Math result not representable.");
> +    declare_err!(EDEADLK, "Resource deadlock avoided.");
>     declare_err!(EOVERFLOW, "Value too large for defined data type.");
>     declare_err!(ETIMEDOUT, "Connection timed out.");
>     declare_err!(ERESTARTSYS, "Restart the system call.");
> diff --git a/rust/kernel/sync/lock/ww_mutex.rs =
b/rust/kernel/sync/lock/ww_mutex.rs
> index ca5b4525ace6..314360632953 100644
> --- a/rust/kernel/sync/lock/ww_mutex.rs
> +++ b/rust/kernel/sync/lock/ww_mutex.rs
> @@ -10,8 +10,11 @@
> //! For more information: =
<https://docs.kernel.org/locking/ww-mutex-design.html>
>=20
> use crate::bindings;
> +use crate::error::to_result;
> use crate::prelude::*;
> -use crate::types::Opaque;
> +use crate::types::{NotThreadSafe, Opaque};
> +use core::cell::UnsafeCell;
> +use core::marker::PhantomData;
>=20
> /// Create static [`WwClass`] instances.
> ///
> @@ -134,3 +137,287 @@ pub fn new_wound_wait(name: &'static CStr) -> =
impl PinInit<Self> {
>         Self::new(name, false)
>     }
> }
> +
> +/// Groups multiple mutex acquisitions together for deadlock =
avoidance.
> +///
> +/// Must be used when acquiring multiple mutexes of the same class.
> +///
> +/// # Examples
> +///
> +/// ```
> +/// use kernel::sync::lock::ww_mutex::{WwClass, WwAcquireCtx, =
WwMutex};
> +/// use kernel::c_str;
> +/// use kernel::sync::Arc;
> +/// use pin_init::stack_pin_init;
> +///
> +/// stack_pin_init!(let class =3D =
WwClass::new_wound_wait(c_str!("my_class")));
> +///
> +/// // Create mutexes.
> +/// let mutex1 =3D Arc::pin_init(WwMutex::new(1, &class), =
GFP_KERNEL)?;
> +/// let mutex2 =3D Arc::pin_init(WwMutex::new(2, &class), =
GFP_KERNEL)?;
> +///
> +/// // Create acquire context for deadlock avoidance.
> +/// let ctx =3D KBox::pin_init(WwAcquireCtx::new(&class), =
GFP_KERNEL)?;
> +///
> +/// // Acquire multiple locks safely.
> +/// let guard1 =3D ctx.lock(&mutex1)?;
> +/// let guard2 =3D ctx.lock(&mutex2)?;
> +///
> +/// // Mark acquisition phase as complete.
> +/// ctx.done();
> +///
> +/// # Ok::<(), Error>(())
> +/// ```
> +#[pin_data(PinnedDrop)]
> +pub struct WwAcquireCtx<'a> {

Please drop the Ww prefix. This is ww_mutex.rs <http://ww_mutex.rs/> =
after all.

> +    #[pin]
> +    inner: Opaque<bindings::ww_acquire_ctx>,
> +    _p: PhantomData<&'a WwClass>,
> +}
> +
> +impl<'ww_class> WwAcquireCtx<'ww_class> {
> +    /// Initializes `Self` with calling C side `ww_acquire_init` =
inside.
> +    pub fn new(ww_class: &'ww_class WwClass) -> impl PinInit<Self> {
> +        let class =3D ww_class.inner.get();
> +        pin_init!(WwAcquireCtx {
> +            inner <- Opaque::ffi_init(|slot: *mut =
bindings::ww_acquire_ctx| {
> +                // SAFETY: `ww_class` is valid for the lifetime =
`'ww_class` captured by `Self`.
> +                unsafe { bindings::ww_acquire_init(slot, class) }
> +            }),
> +            _p: PhantomData
> +        })
> +    }
> +
> +    /// Marks the end of the acquire phase.
> +    ///
> +    /// After calling this function, no more mutexes can be acquired =
with this context.
> +    pub fn done(&self) {
> +        // SAFETY: The context is pinned and valid.
> +        unsafe { bindings::ww_acquire_done(self.inner.get()) };
> +    }

This lets you call done() multiple times. We should probably use a =
typestate here.

> +
> +    /// Locks the given mutex.
> +    pub fn lock<'a, T>(&'a self, ww_mutex: &'a WwMutex<'a, T>) -> =
Result<WwMutexGuard<'a, T>> {

> +        // SAFETY: The mutex is pinned and valid.
> +        let ret =3D unsafe { =
bindings::ww_mutex_lock(ww_mutex.mutex.get(), self.inner.get()) };
> +
> +        to_result(ret)?;
> +
> +        Ok(WwMutexGuard::new(ww_mutex))
> +    }
> +
> +    /// Similar to `lock`, but can be interrupted by signals.
> +    pub fn lock_interruptible<'a, T>(
> +        &'a self,
> +        ww_mutex: &'a WwMutex<'a, T>,
> +    ) -> Result<WwMutexGuard<'a, T>> {
> +        // SAFETY: The mutex is pinned and valid.
> +        let ret =3D unsafe {
> +            =
bindings::ww_mutex_lock_interruptible(ww_mutex.mutex.get(), =
self.inner.get())
> +        };
> +
> +        to_result(ret)?;
> +
> +        Ok(WwMutexGuard::new(ww_mutex))
> +    }
> +
> +    /// Locks the given mutex using the slow path.
> +    ///
> +    /// This function should be used when `lock` fails (typically due =
to a potential deadlock).
> +    pub fn lock_slow<'a, T>(&'a self, ww_mutex: &'a WwMutex<'a, T>) =
-> Result<WwMutexGuard<'a, T>> {
> +        // SAFETY: The mutex is pinned and valid, and we're in the =
slow path.
> +        unsafe { bindings::ww_mutex_lock_slow(ww_mutex.mutex.get(), =
self.inner.get()) };
> +
> +        Ok(WwMutexGuard::new(ww_mutex))
> +    }
> +
> +    /// Similar to `lock_slow`, but can be interrupted by signals.
> +    pub fn lock_slow_interruptible<'a, T>(
> +        &'a self,
> +        ww_mutex: &'a WwMutex<'a, T>,
> +    ) -> Result<WwMutexGuard<'a, T>> {
> +        // SAFETY: The mutex is pinned and valid, and we are in the =
slow path.
> +        let ret =3D unsafe {
> +            =
bindings::ww_mutex_lock_slow_interruptible(ww_mutex.mutex.get(), =
self.inner.get())
> +        };
> +
> +        to_result(ret)?;
> +
> +        Ok(WwMutexGuard::new(ww_mutex))
> +    }
> +
> +    /// Tries to lock the mutex without blocking.
> +    ///
> +    /// Unlike `lock`, no deadlock handling is performed.
> +    pub fn try_lock<'a, T>(&'a self, ww_mutex: &'a WwMutex<'a, T>) -> =
Result<WwMutexGuard<'a, T>> {
> +        // SAFETY: The mutex is pinned and valid.
> +        let ret =3D unsafe { =
bindings::ww_mutex_trylock(ww_mutex.mutex.get(), self.inner.get()) };
> +
> +        if ret =3D=3D 0 {
> +            return Err(EBUSY);
> +        } else {
> +            to_result(ret)?;
> +        }
> +
> +        Ok(WwMutexGuard::new(ww_mutex))
> +    }
> +}
> +
> +#[pinned_drop]
> +impl PinnedDrop for WwAcquireCtx<'_> {
> +    fn drop(self: Pin<&mut Self>) {
> +        // SAFETY: The context is being dropped and is pinned.
> +        unsafe { bindings::ww_acquire_fini(self.inner.get()) };
> +    }
> +}
> +
> +/// A wound/wait mutex backed with C side `ww_mutex`.
> +///
> +/// This is a mutual exclusion primitive that provides deadlock =
avoidance when
> +/// acquiring multiple locks of the same class.

A link would be cool for the docs.

> +///
> +/// # Examples
> +///
> +/// ## Basic Usage
> +///
> +/// ```
> +/// use kernel::c_str;
> +/// use kernel::sync::Arc;
> +/// use kernel::sync::lock::ww_mutex::{WwClass, WwAcquireCtx, WwMutex =
};
> +/// use pin_init::stack_pin_init;
> +///
> +/// stack_pin_init!(let class =3D =
WwClass::new_wound_wait(c_str!("buffer_class")));
> +/// let mutex =3D Arc::pin_init(WwMutex::new(42, &class), =
GFP_KERNEL)?;
> +///
> +/// let ctx =3D KBox::pin_init(WwAcquireCtx::new(&class), =
GFP_KERNEL)?;
> +///
> +/// let guard =3D ctx.lock(&mutex)?;
> +/// assert_eq!(*guard, 42);
> +///
> +/// # Ok::<(), Error>(())
> +/// ```
> +///
> +/// ## Multiple Locks
> +///
> +/// ```
> +/// use kernel::c_str;
> +/// use kernel::prelude::*;
> +/// use kernel::sync::Arc;
> +/// use kernel::sync::lock::ww_mutex::{WwClass, WwAcquireCtx, =
WwMutex};
> +/// use pin_init::stack_pin_init;
> +///
> +/// stack_pin_init!(let class =3D =
WwClass::new_wait_die(c_str!("resource_class")));
> +/// let mutex_a =3D Arc::pin_init(WwMutex::new("Resource A", &class), =
GFP_KERNEL)?;
> +/// let mutex_b =3D Arc::pin_init(WwMutex::new("Resource B", &class), =
GFP_KERNEL)?;
> +///
> +/// let ctx =3D KBox::pin_init(WwAcquireCtx::new(&class), =
GFP_KERNEL)?;
> +///
> +/// // Try to acquire both locks.
> +/// let guard_a =3D match ctx.lock(&mutex_a) {
> +///     Ok(guard) =3D> guard,
> +///     Err(e) if e =3D=3D EDEADLK =3D> {
> +///         // Deadlock detected, use slow path.

You must release all other locks before calling this, except there =
aren=E2=80=99t any taken in your example.

You should perhaps add a release_all() function to the context.

> +///         ctx.lock_slow(&mutex_a)?
> +///     }
> +///     Err(e) =3D> return Err(e),
> +/// };
> +///
> +/// let guard_b =3D ctx.lock(&mutex_b)?;
> +/// ctx.done();
> +///
> +/// # Ok::<(), Error>(())
> +/// ```
> +#[pin_data]
> +pub struct WwMutex<'a, T: ?Sized> {
> +    _p: PhantomData<&'a WwClass>,

Make the PhantomData last, please.

> +    #[pin]
> +    mutex: Opaque<bindings::ww_mutex>,
> +    data: UnsafeCell<T>,
> +}
> +
> +// SAFETY: [`WwMutex`] can be shared between threads.
> +unsafe impl<T: ?Sized + Send> Send for WwMutex<'_, T> {}

=E2=80=9CSend=E2=80=9D does not share anything. When you send something, =
some other
thread has it, and you don=E2=80=99t have it anymore.

Blank here.

> +// SAFETY: [`WwMutex`] can be safely accessed from multiple threads =
concurrently.
> +unsafe impl<T: ?Sized + Send + Sync> Sync for WwMutex<'_, T> {}
> +
> +impl<'ww_class, T> WwMutex<'ww_class, T> {
> +    /// Creates `Self` with calling `ww_mutex_init` inside.

^ This does not parse very well.

> +    pub fn new(t: T, ww_class: &'ww_class WwClass) -> impl =
PinInit<Self> {

Please rename =E2=80=9Ct=E2=80=9D to =E2=80=9Cdata=E2=80=9D.

> +        let class =3D ww_class.inner.get();
> +        pin_init!(WwMutex {
> +            mutex <- Opaque::ffi_init(|slot: *mut bindings::ww_mutex| =
{
> +                // SAFETY: `ww_class` is valid for the lifetime =
`'ww_class` captured by `Self`.
> +                unsafe { bindings::ww_mutex_init(slot, class) }
> +            }),
> +            data: UnsafeCell::new(t),
> +            _p: PhantomData,
> +        })
> +    }
> +}
> +
> +impl<T: ?Sized> WwMutex<'_, T> {

I wonder why we need this ?Sized here?

> +    /// Returns a raw pointer to the inner mutex.
> +    fn as_ptr(&self) -> *mut bindings::ww_mutex {
> +        self.mutex.get()
> +    }
> +
> +    /// Checks if the mutex is currently locked.
> +    ///
> +    /// Intended for internal tests only and should not be used
> +    /// anywhere else.

Why?

> +    #[cfg(CONFIG_KUNIT)]
> +    fn is_locked(&self) -> bool {

I=E2=80=99d recommend removing this CONFIG_KUNIT and making this pub. =
You can see
that there are users for this function in the C code, like for example,
dma_resv_is_locked().

> +        // SAFETY: The mutex is pinned and valid.
> +        unsafe { bindings::ww_mutex_is_locked(self.mutex.get()) }
> +    }
> +}
> +
> +/// A guard that provides exclusive access to the data protected
> +/// by a [`WwMutex`].
> +///
> +/// # Invariants
> +///
> +/// The guard holds an exclusive lock on the associated [`WwMutex`]. =
The lock is held
> +/// for the entire lifetime of this guard and is automatically =
released when the
> +/// guard is dropped.
> +#[must_use =3D "the lock unlocks immediately when the guard is =
unused"]
> +pub struct WwMutexGuard<'a, T: ?Sized> {
> +    mutex: &'a WwMutex<'a, T>,
> +    _not_send: NotThreadSafe,
> +}
> +
> +// SAFETY: [`WwMutexGuard`] can be shared between threads if the data =
can.
> +unsafe impl<T: ?Sized + Sync> Sync for WwMutexGuard<'_, T> {}
> +
> +impl<'a, T: ?Sized> WwMutexGuard<'a, T> {
> +    /// Creates a new guard for a locked mutex.
> +    fn new(mutex: &'a WwMutex<'a, T>) -> Self {
> +        Self {
> +            mutex,
> +            _not_send: NotThreadSafe,
> +        }
> +    }
> +}
> +
> +impl<T: ?Sized> core::ops::Deref for WwMutexGuard<'_, T> {
> +    type Target =3D T;
> +
> +    fn deref(&self) -> &Self::Target {
> +        // SAFETY: We hold the lock, so we have exclusive access.
> +        unsafe { &*self.mutex.data.get() }
> +    }
> +}
> +
> +impl<T: ?Sized> core::ops::DerefMut for WwMutexGuard<'_, T> {
> +    fn deref_mut(&mut self) -> &mut Self::Target {
> +        // SAFETY: We hold the lock, so we have exclusive access.
> +        unsafe { &mut *self.mutex.data.get() }
> +    }

We need to add a bound on Unpin. See [0].

> +}
> +
> +impl<T: ?Sized> Drop for WwMutexGuard<'_, T> {
> +    fn drop(&mut self) {
> +        // SAFETY: We hold the lock and are about to release it.
> +        unsafe { bindings::ww_mutex_unlock(self.mutex.as_ptr()) };
> +    }
> +}
> =E2=80=94
> 2.50.0
>=20
>=20

[0]: =
https://lore.kernel.org/rust-for-linux/20250828-lock-t-when-t-is-pinned-v2=
-1-b067c4b93fd6@collabora.com/


