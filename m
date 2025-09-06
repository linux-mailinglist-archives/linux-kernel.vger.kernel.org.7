Return-Path: <linux-kernel+bounces-804179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D521B46BC1
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 13:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A2F6567702
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 11:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03125284B3C;
	Sat,  6 Sep 2025 11:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="n3cr0A3P"
Received: from forward500a.mail.yandex.net (forward500a.mail.yandex.net [178.154.239.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2771D416E;
	Sat,  6 Sep 2025 11:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757159280; cv=none; b=e1nwKfL88/yiTdI0SYrzOd7PDr9wIAfhX/cG4p5KVMxvVOWDghgQfHakqELWigLuH0qfkC9QHgQuhS442dQMLPA2pZ7/im814tGZv4TqfWcXFn5SvCtMLEePkAbtj2um8dfU74b3tWiwDVxFDbNuwbGYHrR2KupkOvjuSbeQ7Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757159280; c=relaxed/simple;
	bh=3oLZe+coCdn9rfxL+2CIWYH+9LyKTDZLQai2zKKkHfY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uJ/SPuHSfOJoixqVV3Wv4g5h8cMkRqElvlHEgBs7Ch+QIl9UR2n2M/yk6wsjQYCTX049qI+//NlbSwVXy0yeXxhNAO7VB2iv7CGy6gJqLsvEnJ8YbuOB9SdCr/vXvevOJkZCnREennSjH3Zca7CO3DEiusRYOBqOOGzEUfex2q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=n3cr0A3P; arc=none smtp.client-ip=178.154.239.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1d:5abd:0:640:ff5b:0])
	by forward500a.mail.yandex.net (Yandex) with ESMTPS id 16658812ED;
	Sat, 06 Sep 2025 14:47:49 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id ilh13FRM0a60-QeYHBdHP;
	Sat, 06 Sep 2025 14:47:48 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1757159268;
	bh=Qm+SnWMHnFkeWiAXtpibins9mR1RIJ+YBP2wBbOHc4o=;
	h=Cc:Message-ID:Subject:Date:References:To:From:In-Reply-To;
	b=n3cr0A3Pz/d7wkBP1BlRfd0T2KrMyqu8en5crhAQ/bY8t/yYjYHPjhk94P/YG97a7
	 M2ecuR7apxLnyTLOtvX9p4FhDKkohF3Qn9hTkEToM1XReGV9JVutF3V/TEc3pOw4Pd
	 1x3/VnIMFdhQwOtTXsWy7I9qUA/gMCeIOlTfi49E=
Authentication-Results: mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
Date: Sat, 6 Sep 2025 14:47:41 +0300
From: Onur =?UTF-8?B?w5Z6a2Fu?= <work@onurozkan.dev>
To: Elle Rhumsaa <elle@weathered-steel.dev>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 lossin@kernel.org, lyude@redhat.com, ojeda@kernel.org,
 alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
 a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
 dakr@kernel.org, peterz@infradead.org, mingo@redhat.com, will@kernel.org,
 longman@redhat.com, felipe_life@live.com, daniel@sedlak.dev,
 bjorn3_gh@protonmail.com, daniel.almeida@collabora.com
Subject: Re: [PATCH v6 6/7] rust: ww_mutex/exec: add high-level API
Message-ID: <20250906144741.14906fb9@nimda.home>
In-Reply-To: <aLtt6YaPAfGgfZdq@archiso>
References: <20250903131313.4365-1-work@onurozkan.dev>
	<20250903131313.4365-7-work@onurozkan.dev>
	<aLtt6YaPAfGgfZdq@archiso>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 5 Sep 2025 23:11:01 +0000
Elle Rhumsaa <elle@weathered-steel.dev> wrote:

> On Wed, Sep 03, 2025 at 04:13:12PM +0300, Onur =C3=83=E2=80=93zkan wrote:
> > `ExecContext` is a helper built on top of ww_mutex
> > that provides a retrying interface for lock acquisition.
> > When `EDEADLK` is hit, it drops all held locks, resets
> > the acquire context and retries the given (by the user)
> > locking algorithm until it succeeds.
> >=20
> > The API keeps track of acquired locks, cleans them up
> > automatically and allows data access to the protected
> > data through `with_locked()`. The `lock_all()` helper
> > allows implementing multi-mutex algorithms in a simpler
> > and less error-prone way while keeping the ww_mutex
> > semantics.
> >=20
> > Signed-off-by: Onur =C3=83=E2=80=93zkan <work@onurozkan.dev>
> > ---
> >  rust/kernel/sync/lock/ww_mutex.rs      |   2 +
> >  rust/kernel/sync/lock/ww_mutex/exec.rs | 176
> > +++++++++++++++++++++++++ 2 files changed, 178 insertions(+)
> >  create mode 100644 rust/kernel/sync/lock/ww_mutex/exec.rs
> >=20
> > diff --git a/rust/kernel/sync/lock/ww_mutex.rs
> > b/rust/kernel/sync/lock/ww_mutex.rs index
> > b415d6deae9b..7de6578513e5 100644 ---
> > a/rust/kernel/sync/lock/ww_mutex.rs +++
> > b/rust/kernel/sync/lock/ww_mutex.rs @@ -16,6 +16,8 @@
> >  use core::cell::UnsafeCell;
> >  use core::marker::PhantomData;
> >=20
> > +pub mod exec;
> > +
> >  /// Create static [`WwClass`] instances.
> >  ///
> >  /// # Examples
> > diff --git a/rust/kernel/sync/lock/ww_mutex/exec.rs
> > b/rust/kernel/sync/lock/ww_mutex/exec.rs new file mode 100644
> > index 000000000000..2f1fc540f0b8
> > --- /dev/null
> > +++ b/rust/kernel/sync/lock/ww_mutex/exec.rs
> > @@ -0,0 +1,176 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +//! A high-level [`WwMutex`] execution helper.
> > +//!
> > +//! Provides a retrying lock mechanism on top of [`WwMutex`] and
> > [`WwAcquireCtx`]. +//! It detects [`EDEADLK`] and handles it by
> > rolling back and retrying the +//! user-supplied locking algorithm
> > until success. +
> > +use crate::prelude::*;
> > +use crate::sync::lock::ww_mutex::{WwAcquireCtx, WwClass, WwMutex,
> > WwMutexGuard}; +use core::ptr;
> > +
> > +/// High-level execution type for ww_mutex.
> > +///
> > +/// Tracks a series of locks acquired under a common
> > [`WwAcquireCtx`]. +/// It ensures proper cleanup and retry
> > mechanism on deadlocks and provides +/// type-safe access to locked
> > data via [`with_locked`]. +///
> > +/// Typical usage is through [`lock_all`], which retries a
> > user-supplied +/// locking algorithm until it succeeds without
> > deadlock. +pub struct ExecContext<'a> {
> > +    class: &'a WwClass,
> > +    acquire: Pin<KBox<WwAcquireCtx<'a>>>,
> > +    taken: KVec<WwMutexGuard<'a, ()>>,
> > +}
> > +
> > +impl<'a> Drop for ExecContext<'a> {
> > +    fn drop(&mut self) {
> > +        self.release_all_locks();
> > +    }
> > +}
> > +
> > +impl<'a> ExecContext<'a> {
> > +    /// Creates a new [`ExecContext`] for the given lock class.
> > +    ///
> > +    /// All locks taken through this context must belong to the
> > same class.
> > +    ///
> > +    /// TODO: Add some safety mechanism to ensure classes are not
> > different.
> > +    pub fn new(class: &'a WwClass) -> Result<Self> {
> > +        Ok(Self {
> > +            class,
> > +            acquire: KBox::pin_init(WwAcquireCtx::new(class),
> > GFP_KERNEL)?,
> > +            taken: KVec::new(),
> > +        })
> > +    }
> > +
> > +    /// Attempts to lock a [`WwMutex`] and records the guard.
> > +    ///
> > +    /// Returns [`EDEADLK`] if lock ordering would cause a
> > deadlock.
> > +    pub fn lock<T>(&mut self, mutex: &'a WwMutex<'a, T>) ->
> > Result<()> {
> > +        let guard =3D self.acquire.lock(mutex)?;
> > +        // SAFETY: Type is erased for storage. Actual access uses
> > `with_locked`
> > +        // which safely casts back.
> > +        let erased: WwMutexGuard<'a, ()> =3D unsafe {
> > core::mem::transmute(guard) };
> > +        self.taken.push(erased, GFP_KERNEL)?;
> > +
> > +        Ok(())
> > +    }
> > +
> > +    /// Runs `locking_algorithm` until success with retrying on
> > deadlock.
> > +    ///
> > +    /// `locking_algorithm` should attempt to acquire all needed
> > locks.
> > +    /// If [`EDEADLK`] is detected, this function will roll back,
> > reset
> > +    /// the context and retry automatically.
> > +    ///
> > +    /// Once all locks are acquired successfully,
> > `on_all_locks_taken` is
> > +    /// invoked for exclusive access to the locked values.
> > Afterwards, all
> > +    /// locks are released.
> > +    ///
> > +    /// # Example
> > +    ///
> > +    /// ```
> > +    /// use kernel::alloc::KBox;
> > +    /// use kernel::c_str;
> > +    /// use kernel::prelude::*;
> > +    /// use kernel::sync::Arc;
> > +    /// use kernel::sync::lock::ww_mutex;
> > +    /// use pin_init::stack_pin_init;
> > +    ///
> > +    /// stack_pin_init!(let class =3D
> > ww_mutex::WwClass::new_wound_wait(c_str!("lock_all_example")));
> > +    ///
> > +    /// let mutex1 =3D Arc::pin_init(ww_mutex::WwMutex::new(0,
> > &class), GFP_KERNEL)?;
> > +    /// let mutex2 =3D Arc::pin_init(ww_mutex::WwMutex::new(0,
> > &class), GFP_KERNEL)?;
> > +    /// let mut ctx =3D
> > KBox::pin_init(ww_mutex::exec::ExecContext::new(&class)?,
> > GFP_KERNEL)?;
> > +    ///
> > +    /// ctx.lock_all(
> > +    ///     |ctx| {
> > +    ///         // Try to lock both mutexes.
> > +    ///         ctx.lock(&mutex1)?;
> > +    ///         ctx.lock(&mutex2)?;
> > +    ///
> > +    ///         Ok(())
> > +    ///     },
> > +    ///     |ctx| {
> > +    ///         // Safely mutate both values while holding the
> > locks.
> > +    ///         ctx.with_locked(&mutex1, |v| *v +=3D 1)?;
> > +    ///         ctx.with_locked(&mutex2, |v| *v +=3D 1)?;
> > +    ///
> > +    ///         Ok(())
> > +    ///     },
> > +    /// )?;
> > +    ///
> > +    /// # Ok::<(), Error>(())
> > +    /// ```
> > +    pub fn lock_all<T, Y, Z>(
> > +        &mut self,
> > +        mut locking_algorithm: T,
> > +        mut on_all_locks_taken: Y,
> > +    ) -> Result<Z>
> > +    where
> > +        T: FnMut(&mut ExecContext<'a>) -> Result<()>,
> > +        Y: FnMut(&mut ExecContext<'a>) -> Result<Z>,
> > +    {
> > +        loop {
> > +            match locking_algorithm(self) {
> > +                Ok(()) =3D> {
> > +                    // All locks in `locking_algorithm` succeeded.
> > +                    // The user can now safely use them in
> > `on_all_locks_taken`.
> > +                    let res =3D on_all_locks_taken(self);
> > +                    self.release_all_locks();
> > +
> > +                    return res;
> > +                }
> > +                Err(e) if e =3D=3D EDEADLK =3D> {
> > +                    // Deadlock detected, retry from scratch.
> > +                    self.cleanup_on_deadlock()?;
> > +                    continue;
> > +                }
> > +                Err(e) =3D> {
> > +                    return Err(e);
> > +                }
> > +            }
> > +        }
> > +    }
> > +
> > +    /// Executes `f` with a mutable reference to the data behind
> > `mutex`.
> > +    ///
> > +    /// Fails with [`EINVAL`] if the mutex was not locked in this
> > context.
> > +    pub fn with_locked<T, Y>(
> > +        &mut self,
> > +        mutex: &'a WwMutex<'a, T>,
> > +        f: impl FnOnce(&mut T) -> Y,
> > +    ) -> Result<Y> {
> > +        // Find the matching guard.
> > +        for guard in &mut self.taken {
> > +            if mutex.as_ptr() =3D=3D guard.mutex.as_ptr() {
> > +                // SAFETY: We know this guard belongs to `mutex`
> > and holds the lock.
> > +                let typed =3D unsafe { &mut
> > *ptr::from_mut(guard).cast::<WwMutexGuard<'a, T>>() };
> > +                return Ok(f(&mut **typed));
> > +            }
> > +        }
> > +
> > +        // `mutex` isn't locked in this `ExecContext`.
> > +        Err(EINVAL)
> > +    }
>=20
> This can be refactored using a more idiomatic functional style:
>=20
> diff --git a/rust/kernel/sync/lock/ww_mutex/exec.rs
> b/rust/kernel/sync/lock/ww_mutex/exec.rs index
> 543c5218232a..8fdfb11104b9 100644 ---
> a/rust/kernel/sync/lock/ww_mutex/exec.rs +++
> b/rust/kernel/sync/lock/ww_mutex/exec.rs @@ -142,16 +142,17 @@ pub fn
> with_locked<T, Y>( f: impl FnOnce(&mut T) -> Y,
>      ) -> Result<Y> {
>          // Find the matching guard.
> -        for guard in &mut self.taken {
> -            if mutex.as_ptr() =3D=3D guard.mutex.as_ptr() {
> +        self.taken
> +            .iter_mut()
> +            .find_map(|guard| if mutex.as_ptr() =3D=3D
> guard.mutex.as_ptr() { // SAFETY: We know this guard belongs to
> `mutex` and holds the lock.
> -                let typed =3D unsafe { &mut
> *ptr::from_mut(guard).cast::<WwMutexGuard<'a, T>>() };
> -                return Ok(f(&mut **typed));
> -            }
> -        }
> -
> -        // `mutex` isn't locked in this `ExecContext`.
> -        Err(EINVAL)
> +                Some(unsafe { &mut
> *ptr::from_mut(guard).cast::<WwMutexGuard<'a, T>>() })
> +            } else {
> +                None
> +            })
> +            .map(|typed| f(&mut **typed))
> +            // `mutex` isn't locked in this `ExecContext`.
> +            .ok_or(EINVAL)
>      }
>=20

Looks nice, I will apply it if the flow doesn't change in the next
patch. Thanks!

-Onur

>      /// Releases all currently held locks in this context.
>=20
> > +
> > +    /// Releases all currently held locks in this context.
> > +    ///
> > +    /// It is intended to be used for internal implementation only.
> > +    fn release_all_locks(&mut self) {
> > +        self.taken.clear();
> > +    }
> > +
> > +    /// Resets this context after a deadlock detection.
> > +    ///
> > +    /// Drops all held locks and reinitializes the
> > [`WwAcquireCtx`].
> > +    ///
> > +    /// It is intended to be used for internal implementation only.
> > +    fn cleanup_on_deadlock(&mut self) -> Result {
> > +        self.release_all_locks();
> > +        // Re-init fresh `WwAcquireCtx`.
> > +        self.acquire =3D
> > KBox::pin_init(WwAcquireCtx::new(self.class), GFP_KERNEL)?; +
> > +        Ok(())
> > +    }
> > +}
> > --
> > 2.50.0
> >=20
> >=20
>=20
> Reviewed-by: Elle Rhumsaa <elle@weathered-steel.dev>


