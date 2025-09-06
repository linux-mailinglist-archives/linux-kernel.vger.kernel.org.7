Return-Path: <linux-kernel+bounces-804161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B92B46AE9
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 13:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C4D6A082C8
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 11:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6217283C9D;
	Sat,  6 Sep 2025 11:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="OkxPHkF8"
Received: from forward500b.mail.yandex.net (forward500b.mail.yandex.net [178.154.239.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0F227B32B;
	Sat,  6 Sep 2025 11:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757157210; cv=none; b=N40WBCRcg10rheKJWyi8JmEjiczQjeLDOI9dt5DSJaCkwsAh9HV809HSbs+O/ts5ffjdirrAXpiYDfU6vImutT0YqnVVx1hQZmvj1v8pdMikZbxJUW8KbGP7pl13LUIZuONU5ACX0DmoSC5zwuCPSJC021vzz6cUpL03gBJ1vRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757157210; c=relaxed/simple;
	bh=oLkCwW3bmwI6aDgacrIM9H7Mu2tjXybKLg3++ZwrU24=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rvj0pYTTFMkZxtQ/TSqz/iVAFMdeN+7Gy6mzn3f6rm5x+Pojoxk6yq9hz4p47ek63lx2ZvEnDIBY1mJNIdt4oTvZ9yrYTzVFNjhMM89mnN1ogs221v6D/7D7DykqS+K8MbmVnZhebt9Vj59sclNEX11e8Vg97SYtW7q4VgS2XMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=OkxPHkF8; arc=none smtp.client-ip=178.154.239.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-74.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-74.sas.yp-c.yandex.net [IPv6:2a02:6b8:c1b:3715:0:640:1185:0])
	by forward500b.mail.yandex.net (Yandex) with ESMTPS id BA05DC0AB9;
	Sat, 06 Sep 2025 14:13:17 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-74.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id BDhPTRTL3Ko0-5VpRIetM;
	Sat, 06 Sep 2025 14:13:16 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1757157196;
	bh=ITACWoCzYsXVdJZpGO6qE8kq+WSCC/iOE8WQ4nZOUEY=;
	h=Cc:Message-ID:Subject:Date:References:To:From:In-Reply-To;
	b=OkxPHkF8UlO2LliBAUP65z2xJsjif20gCd3VYX6PdEmR6UFk3m08JuCKkC6s9OX9n
	 qAqDAf//2gM9TEq5DoUMBEnak8NSMnFwzFXWDUgNMqHJSKjlzUSGHumy66Lt9UJ2Sy
	 S7AtvuS792JPvpeMLOur4XvbmqDHiiHj3LudlQCI=
Authentication-Results: mail-nwsmtp-smtp-production-main-74.sas.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
Date: Sat, 6 Sep 2025 14:13:10 +0300
From: Onur <work@onurozkan.dev>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 lossin@kernel.org, lyude@redhat.com, ojeda@kernel.org,
 alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
 a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
 dakr@kernel.org, peterz@infradead.org, mingo@redhat.com, will@kernel.org,
 longman@redhat.com, felipe_life@live.com, daniel@sedlak.dev,
 bjorn3_gh@protonmail.com
Subject: Re: [PATCH v6 6/7] rust: ww_mutex/exec: add high-level API
Message-ID: <20250906141310.2c29aa8e@nimda.home>
In-Reply-To: <6D30FEF7-07E7-4851-A7A2-76649AD0B217@collabora.com>
References: <20250903131313.4365-1-work@onurozkan.dev>
	<20250903131313.4365-7-work@onurozkan.dev>
	<6D30FEF7-07E7-4851-A7A2-76649AD0B217@collabora.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 5 Sep 2025 16:42:09 -0300
Daniel Almeida <daniel.almeida@collabora.com> wrote:

> Hi Onur,
>=20
> > On 3 Sep 2025, at 10:13, Onur =C3=96zkan <work@onurozkan.dev> wrote:
> >=20
> > `ExecContext` is a helper built on top of ww_mutex
>=20
> Again, I wonder what people think about this particular name.
>=20
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
>=20
> Great, this was exactly what I was looking for! :)
>=20
> > Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>
> > ---
> > rust/kernel/sync/lock/ww_mutex.rs      |   2 +
> > rust/kernel/sync/lock/ww_mutex/exec.rs | 176
> > +++++++++++++++++++++++++ 2 files changed, 178 insertions(+)
> > create mode 100644 rust/kernel/sync/lock/ww_mutex/exec.rs
> >=20
> > diff --git a/rust/kernel/sync/lock/ww_mutex.rs
> > b/rust/kernel/sync/lock/ww_mutex.rs index
> > b415d6deae9b..7de6578513e5 100644 ---
> > a/rust/kernel/sync/lock/ww_mutex.rs +++
> > b/rust/kernel/sync/lock/ww_mutex.rs @@ -16,6 +16,8 @@
> > use core::cell::UnsafeCell;
> > use core::marker::PhantomData;
> >=20
> > +pub mod exec;
> > +
> > /// Create static [`WwClass`] instances.
> > ///
> > /// # Examples
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
>=20
> If we move this to the acquire context, then we can do away with this
> drop impl.
>=20
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
>=20
> core::ptr::eq()?
>

I was thinking more of a type-level mechanism to do ensure that.

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
>=20
> Why?
>=20
> > +        let erased: WwMutexGuard<'a, ()> =3D unsafe {
> > core::mem::transmute(guard) };
>=20
> We should really try our very best to avoid transmuting things.
>=20
> Why can=E2=80=99t you store a KVec<MutexGuard<=E2=80=98a, T>>? Seems stra=
ightforward
> if you add a T parameter to ExecContext.
>=20
> Also, someone correct me if I am wrong, but users can explicitly have
> T be e.g.: KBox<dyn SomeTrait> if they want to.

So it can run different types inside the same execution context (see
test_with_different_input_type). If there isn't a use-case for this, I
can change it into `T`.

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
>=20
> Can you add intermediary variables to hold the closures, just for
> extra clarity?
>=20
> i.e.:
>=20
> let locking_algorithm =3D =E2=80=A6;
> let on_all_locks_taken =3D =E2=80=A6;
>=20
> This is of course identical, but it conveys the meaning just a bit
> better.
>=20

Sure, I will do that in the following patch.

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
>=20
> Just =E2=80=9CResult=E2=80=9D.
>=20
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
>=20
> This apparently looks ok.
>=20
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
>=20
> core::ptr::eq() ?
>=20
> > +                // SAFETY: We know this guard belongs to `mutex`
> > and holds the lock.
> > +                let typed =3D unsafe { &mut
> > *ptr::from_mut(guard).cast::<WwMutexGuard<'a, T>>() };
> > +                return Ok(f(&mut **typed));
>=20
> This doesn=E2=80=99t look good, but it will probably improve once we get =
rid
> of the transmute.
>=20
>  Also, can you find a comparable use-case for this in the C code?
>=20

I think there is no use case in C code that can be compared to what I
was aiming for (the multi-type support in single context). I thought it
was cool thing to have but I am not sure if it's really needed. :)

> > +            }
> > +        }
> > +
> > +        // `mutex` isn't locked in this `ExecContext`.
> > +        Err(EINVAL)
> > +    }
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
>=20
> ^ This last line can go away as this is private.
>=20
> > +    fn cleanup_on_deadlock(&mut self) -> Result {
> > +        self.release_all_locks();
> > +        // Re-init fresh `WwAcquireCtx`.
> > +        self.acquire =3D
> > KBox::pin_init(WwAcquireCtx::new(self.class), GFP_KERNEL)?;
>=20
> This will require one allocation per rollback.
>=20

Good point, will re-work on that too.

> > +
> > +        Ok(())
> > +    }
> > +}
> > --
> > 2.50.0
> >=20
>=20


