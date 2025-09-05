Return-Path: <linux-kernel+bounces-803903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFF0B46705
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 01:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 783BE16B954
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 23:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4091C2BEFEA;
	Fri,  5 Sep 2025 23:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=weathered-steel.dev header.i=@weathered-steel.dev header.b="SL/rYTeC"
Received: from mail-106111.protonmail.ch (mail-106111.protonmail.ch [79.135.106.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C743E29D29D
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 23:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757113873; cv=none; b=BIf1OUx5WQg4Y8WNfiGrwun3BOGntpYSK+0GKh0ZL1CbtKd+AmiPQ9RENmFQvNXg4a+v1ac6W+uZDlzm5LRj7tSwydFfOc3kvLxUJLM7KhlcNBbWzK4nBlkang9MqiPv7oCibunUHPIZdkDqrcMrl06MauIU1LD/v3fRsqXRmbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757113873; c=relaxed/simple;
	bh=J97RolsDZMOWZlBo3x+/AMGYoHsy38vAcO8LAqZ3ZkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D3Wx4oFtBJEZk1+gLEv0GvGqInIfOgI3iOZOwxDmBlvnRSRCb+l0G76TqBMuqf4/IIqoc+ADx/QvhEKlq++evYGDTHr2gqLrMcHjWqxBzTSkkcfjGfOZ0M+ZyM4oR7yL1a9rcp0In2eDrZgrFzA/gPXHx1KDMEpau5XGYTQVxC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weathered-steel.dev; spf=pass smtp.mailfrom=weathered-steel.dev; dkim=pass (2048-bit key) header.d=weathered-steel.dev header.i=@weathered-steel.dev header.b=SL/rYTeC; arc=none smtp.client-ip=79.135.106.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weathered-steel.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weathered-steel.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weathered-steel.dev;
	s=protonmail3; t=1757113867; x=1757373067;
	bh=CMpThxO7D1GsCHv7hwjIfxuRhz5SaFAtCrRQOcNVqXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:In-Reply-To:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=SL/rYTeCwe2ocFyMVXbki26JogoQL3RYP++L8vcXDjU2UOu1yYvKCUUbjndqEPfgK
	 C3WIP8VJmPlQEMhezTDqFt1bMq8d6D0Rlu4kNuTS/VhP515tqvIbAjWh+Wz6QyUTV/
	 bvUm+t9Pc7Qfhe8+u11ypkI0fudY9BbD7Qr+ecFXx/ozGuYk46b1lo/2atbRehGhuC
	 63XUQ/Zbi4vnyxDqEwE96P893WZPs01CzPL1rEZT4L7R7pHtFzTjiveFypyH+BQflY
	 QHG7jQI50JsFKoFH6EdmqvIl8U8J/TZvz+O+7ZT8N7l/jv4oaP91xe0RKlZE5i/9MI
	 cMz5cfSpkmIQw==
X-Pm-Submission-Id: 4cJXCD5cDPz1DDrM
Date: Fri, 5 Sep 2025 23:11:01 +0000
From: Elle Rhumsaa <elle@weathered-steel.dev>
To: Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	lossin@kernel.org, lyude@redhat.com, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	dakr@kernel.org, peterz@infradead.org, mingo@redhat.com,
	will@kernel.org, longman@redhat.com, felipe_life@live.com,
	daniel@sedlak.dev, bjorn3_gh@protonmail.com,
	daniel.almeida@collabora.com
Subject: Re: [PATCH v6 6/7] rust: ww_mutex/exec: add high-level API
Message-ID: <aLtt6YaPAfGgfZdq@archiso>
References: <20250903131313.4365-1-work@onurozkan.dev>
 <20250903131313.4365-7-work@onurozkan.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250903131313.4365-7-work@onurozkan.dev>

On Wed, Sep 03, 2025 at 04:13:12PM +0300, Onur Özkan wrote:
> `ExecContext` is a helper built on top of ww_mutex
> that provides a retrying interface for lock acquisition.
> When `EDEADLK` is hit, it drops all held locks, resets
> the acquire context and retries the given (by the user)
> locking algorithm until it succeeds.
> 
> The API keeps track of acquired locks, cleans them up
> automatically and allows data access to the protected
> data through `with_locked()`. The `lock_all()` helper
> allows implementing multi-mutex algorithms in a simpler
> and less error-prone way while keeping the ww_mutex
> semantics.
> 
> Signed-off-by: Onur Özkan <work@onurozkan.dev>
> ---
>  rust/kernel/sync/lock/ww_mutex.rs      |   2 +
>  rust/kernel/sync/lock/ww_mutex/exec.rs | 176 +++++++++++++++++++++++++
>  2 files changed, 178 insertions(+)
>  create mode 100644 rust/kernel/sync/lock/ww_mutex/exec.rs
> 
> diff --git a/rust/kernel/sync/lock/ww_mutex.rs b/rust/kernel/sync/lock/ww_mutex.rs
> index b415d6deae9b..7de6578513e5 100644
> --- a/rust/kernel/sync/lock/ww_mutex.rs
> +++ b/rust/kernel/sync/lock/ww_mutex.rs
> @@ -16,6 +16,8 @@
>  use core::cell::UnsafeCell;
>  use core::marker::PhantomData;
> 
> +pub mod exec;
> +
>  /// Create static [`WwClass`] instances.
>  ///
>  /// # Examples
> diff --git a/rust/kernel/sync/lock/ww_mutex/exec.rs b/rust/kernel/sync/lock/ww_mutex/exec.rs
> new file mode 100644
> index 000000000000..2f1fc540f0b8
> --- /dev/null
> +++ b/rust/kernel/sync/lock/ww_mutex/exec.rs
> @@ -0,0 +1,176 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! A high-level [`WwMutex`] execution helper.
> +//!
> +//! Provides a retrying lock mechanism on top of [`WwMutex`] and [`WwAcquireCtx`].
> +//! It detects [`EDEADLK`] and handles it by rolling back and retrying the
> +//! user-supplied locking algorithm until success.
> +
> +use crate::prelude::*;
> +use crate::sync::lock::ww_mutex::{WwAcquireCtx, WwClass, WwMutex, WwMutexGuard};
> +use core::ptr;
> +
> +/// High-level execution type for ww_mutex.
> +///
> +/// Tracks a series of locks acquired under a common [`WwAcquireCtx`].
> +/// It ensures proper cleanup and retry mechanism on deadlocks and provides
> +/// type-safe access to locked data via [`with_locked`].
> +///
> +/// Typical usage is through [`lock_all`], which retries a user-supplied
> +/// locking algorithm until it succeeds without deadlock.
> +pub struct ExecContext<'a> {
> +    class: &'a WwClass,
> +    acquire: Pin<KBox<WwAcquireCtx<'a>>>,
> +    taken: KVec<WwMutexGuard<'a, ()>>,
> +}
> +
> +impl<'a> Drop for ExecContext<'a> {
> +    fn drop(&mut self) {
> +        self.release_all_locks();
> +    }
> +}
> +
> +impl<'a> ExecContext<'a> {
> +    /// Creates a new [`ExecContext`] for the given lock class.
> +    ///
> +    /// All locks taken through this context must belong to the same class.
> +    ///
> +    /// TODO: Add some safety mechanism to ensure classes are not different.
> +    pub fn new(class: &'a WwClass) -> Result<Self> {
> +        Ok(Self {
> +            class,
> +            acquire: KBox::pin_init(WwAcquireCtx::new(class), GFP_KERNEL)?,
> +            taken: KVec::new(),
> +        })
> +    }
> +
> +    /// Attempts to lock a [`WwMutex`] and records the guard.
> +    ///
> +    /// Returns [`EDEADLK`] if lock ordering would cause a deadlock.
> +    pub fn lock<T>(&mut self, mutex: &'a WwMutex<'a, T>) -> Result<()> {
> +        let guard = self.acquire.lock(mutex)?;
> +        // SAFETY: Type is erased for storage. Actual access uses `with_locked`
> +        // which safely casts back.
> +        let erased: WwMutexGuard<'a, ()> = unsafe { core::mem::transmute(guard) };
> +        self.taken.push(erased, GFP_KERNEL)?;
> +
> +        Ok(())
> +    }
> +
> +    /// Runs `locking_algorithm` until success with retrying on deadlock.
> +    ///
> +    /// `locking_algorithm` should attempt to acquire all needed locks.
> +    /// If [`EDEADLK`] is detected, this function will roll back, reset
> +    /// the context and retry automatically.
> +    ///
> +    /// Once all locks are acquired successfully, `on_all_locks_taken` is
> +    /// invoked for exclusive access to the locked values. Afterwards, all
> +    /// locks are released.
> +    ///
> +    /// # Example
> +    ///
> +    /// ```
> +    /// use kernel::alloc::KBox;
> +    /// use kernel::c_str;
> +    /// use kernel::prelude::*;
> +    /// use kernel::sync::Arc;
> +    /// use kernel::sync::lock::ww_mutex;
> +    /// use pin_init::stack_pin_init;
> +    ///
> +    /// stack_pin_init!(let class = ww_mutex::WwClass::new_wound_wait(c_str!("lock_all_example")));
> +    ///
> +    /// let mutex1 = Arc::pin_init(ww_mutex::WwMutex::new(0, &class), GFP_KERNEL)?;
> +    /// let mutex2 = Arc::pin_init(ww_mutex::WwMutex::new(0, &class), GFP_KERNEL)?;
> +    /// let mut ctx = KBox::pin_init(ww_mutex::exec::ExecContext::new(&class)?, GFP_KERNEL)?;
> +    ///
> +    /// ctx.lock_all(
> +    ///     |ctx| {
> +    ///         // Try to lock both mutexes.
> +    ///         ctx.lock(&mutex1)?;
> +    ///         ctx.lock(&mutex2)?;
> +    ///
> +    ///         Ok(())
> +    ///     },
> +    ///     |ctx| {
> +    ///         // Safely mutate both values while holding the locks.
> +    ///         ctx.with_locked(&mutex1, |v| *v += 1)?;
> +    ///         ctx.with_locked(&mutex2, |v| *v += 1)?;
> +    ///
> +    ///         Ok(())
> +    ///     },
> +    /// )?;
> +    ///
> +    /// # Ok::<(), Error>(())
> +    /// ```
> +    pub fn lock_all<T, Y, Z>(
> +        &mut self,
> +        mut locking_algorithm: T,
> +        mut on_all_locks_taken: Y,
> +    ) -> Result<Z>
> +    where
> +        T: FnMut(&mut ExecContext<'a>) -> Result<()>,
> +        Y: FnMut(&mut ExecContext<'a>) -> Result<Z>,
> +    {
> +        loop {
> +            match locking_algorithm(self) {
> +                Ok(()) => {
> +                    // All locks in `locking_algorithm` succeeded.
> +                    // The user can now safely use them in `on_all_locks_taken`.
> +                    let res = on_all_locks_taken(self);
> +                    self.release_all_locks();
> +
> +                    return res;
> +                }
> +                Err(e) if e == EDEADLK => {
> +                    // Deadlock detected, retry from scratch.
> +                    self.cleanup_on_deadlock()?;
> +                    continue;
> +                }
> +                Err(e) => {
> +                    return Err(e);
> +                }
> +            }
> +        }
> +    }
> +
> +    /// Executes `f` with a mutable reference to the data behind `mutex`.
> +    ///
> +    /// Fails with [`EINVAL`] if the mutex was not locked in this context.
> +    pub fn with_locked<T, Y>(
> +        &mut self,
> +        mutex: &'a WwMutex<'a, T>,
> +        f: impl FnOnce(&mut T) -> Y,
> +    ) -> Result<Y> {
> +        // Find the matching guard.
> +        for guard in &mut self.taken {
> +            if mutex.as_ptr() == guard.mutex.as_ptr() {
> +                // SAFETY: We know this guard belongs to `mutex` and holds the lock.
> +                let typed = unsafe { &mut *ptr::from_mut(guard).cast::<WwMutexGuard<'a, T>>() };
> +                return Ok(f(&mut **typed));
> +            }
> +        }
> +
> +        // `mutex` isn't locked in this `ExecContext`.
> +        Err(EINVAL)
> +    }

This can be refactored using a more idiomatic functional style:

diff --git a/rust/kernel/sync/lock/ww_mutex/exec.rs b/rust/kernel/sync/lock/ww_mutex/exec.rs
index 543c5218232a..8fdfb11104b9 100644
--- a/rust/kernel/sync/lock/ww_mutex/exec.rs
+++ b/rust/kernel/sync/lock/ww_mutex/exec.rs
@@ -142,16 +142,17 @@ pub fn with_locked<T, Y>(
         f: impl FnOnce(&mut T) -> Y,
     ) -> Result<Y> {
         // Find the matching guard.
-        for guard in &mut self.taken {
-            if mutex.as_ptr() == guard.mutex.as_ptr() {
+        self.taken
+            .iter_mut()
+            .find_map(|guard| if mutex.as_ptr() == guard.mutex.as_ptr() {
                 // SAFETY: We know this guard belongs to `mutex` and holds the lock.
-                let typed = unsafe { &mut *ptr::from_mut(guard).cast::<WwMutexGuard<'a, T>>() };
-                return Ok(f(&mut **typed));
-            }
-        }
-
-        // `mutex` isn't locked in this `ExecContext`.
-        Err(EINVAL)
+                Some(unsafe { &mut *ptr::from_mut(guard).cast::<WwMutexGuard<'a, T>>() })
+            } else {
+                None
+            })
+            .map(|typed| f(&mut **typed))
+            // `mutex` isn't locked in this `ExecContext`.
+            .ok_or(EINVAL)
     }

     /// Releases all currently held locks in this context.

> +
> +    /// Releases all currently held locks in this context.
> +    ///
> +    /// It is intended to be used for internal implementation only.
> +    fn release_all_locks(&mut self) {
> +        self.taken.clear();
> +    }
> +
> +    /// Resets this context after a deadlock detection.
> +    ///
> +    /// Drops all held locks and reinitializes the [`WwAcquireCtx`].
> +    ///
> +    /// It is intended to be used for internal implementation only.
> +    fn cleanup_on_deadlock(&mut self) -> Result {
> +        self.release_all_locks();
> +        // Re-init fresh `WwAcquireCtx`.
> +        self.acquire = KBox::pin_init(WwAcquireCtx::new(self.class), GFP_KERNEL)?;
> +
> +        Ok(())
> +    }
> +}
> --
> 2.50.0
> 
> 

Reviewed-by: Elle Rhumsaa <elle@weathered-steel.dev>

