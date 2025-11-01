Return-Path: <linux-kernel+bounces-881404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 70347C2823F
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 17:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B92054EAE9A
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 16:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0E32FC865;
	Sat,  1 Nov 2025 16:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="HiirFc5t"
Received: from forward103d.mail.yandex.net (forward103d.mail.yandex.net [178.154.239.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92182299943;
	Sat,  1 Nov 2025 16:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762013486; cv=none; b=kecxmlpqmDOQE5U/Uz7TpnSPNCz5ibLF1x1YHmCgopMhD+JYIaiSaCa5ujpBxobqs549Fj2p2HBxP8QH/dnH8zo3GpKgLOziR1QpCnNPEKzkK+rI3DUJ4O8Bo1dTuaIqD2AjZ9V4M2q34Gre7LLiekyWG971BEgmMGq9KBa7hdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762013486; c=relaxed/simple;
	bh=rbCeEuQmjACa3b+JGbAUkecAav6r4rUs3d5KiQCiLEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZqvoHTEQm7hbi9Ph7gI2GHx6Ejv97jkwepF+b0VxITq6X+yHoAbxe1vDClA3MYuYMZXh3azlOC9YCP+yrXbiGNM/LRowKrlf6Ga+pWeZfjNv/hl5T9Og1R6VmEVmJxNdtrjDnALbvNdyC6uzwO1Ky6UJlOpYdQ/UPyc6Sqcc49o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=HiirFc5t; arc=none smtp.client-ip=178.154.239.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:d7c6:0:640:5e67:0])
	by forward103d.mail.yandex.net (Yandex) with ESMTPS id 0C88EC00A2;
	Sat, 01 Nov 2025 19:11:21 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id wAkixRhLDOs0-mtTarMM9;
	Sat, 01 Nov 2025 19:11:20 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1762013480;
	bh=Q0ZO3k2nzppJbl+LT2AvxYEwKlwIAbMp9O9oraiRtEM=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=HiirFc5t8cLaYcqEfu8VgU2jHZ8hyylYG/dhYJRKAgpCQANagTSC9Y1a6Xf6OgvwU
	 BTdgJYdPRI3iqw1ZN3Z1zKBgLxO2NwOXB3XsByXkslNDDsTCkt4x0HGtkH43CV3Aia
	 nS8E7vWsrGffeATkdngksDOU1wsMIFdQ+roRnMwA=
Authentication-Results: mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: rust-for-linux@vger.kernel.org
Cc: lossin@kernel.org,
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
	bjorn3_gh@protonmail.com,
	daniel.almeida@collabora.com,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Subject: [PATCH v7 5/6] rust: ww_mutex: implement LockSet
Date: Sat,  1 Nov 2025 19:10:55 +0300
Message-ID: <20251101161056.22408-6-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251101161056.22408-1-work@onurozkan.dev>
References: <20251101161056.22408-1-work@onurozkan.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

`LockSet` is a high-level and safe API built on top of
ww_mutex, provides a simple API while keeping the ww_mutex
semantics.

When `EDEADLK` is hit, it drops all held locks, resets
the acquire context and retries the given (by the user)
locking algorithm until it succeeds.

Signed-off-by: Onur Özkan <work@onurozkan.dev>
---
 rust/kernel/sync/lock/ww_mutex.rs          |   6 +
 rust/kernel/sync/lock/ww_mutex/lock_set.rs | 245 +++++++++++++++++++++
 2 files changed, 251 insertions(+)
 create mode 100644 rust/kernel/sync/lock/ww_mutex/lock_set.rs

diff --git a/rust/kernel/sync/lock/ww_mutex.rs b/rust/kernel/sync/lock/ww_mutex.rs
index 2a9c1c20281b..d4c3b272912d 100644
--- a/rust/kernel/sync/lock/ww_mutex.rs
+++ b/rust/kernel/sync/lock/ww_mutex.rs
@@ -5,6 +5,10 @@
 //! It is designed to avoid deadlocks when locking multiple [`Mutex`]es
 //! that belong to the same [`Class`]. Each lock acquisition uses an
 //! [`AcquireCtx`] to track ordering and ensure forward progress.
+//!
+//! It is recommended to use [`LockSet`] as it provides safe high-level
+//! interface that automatically handles deadlocks, retries and context
+//! management.
 
 use crate::error::to_result;
 use crate::prelude::*;
@@ -16,9 +20,11 @@
 
 pub use acquire_ctx::AcquireCtx;
 pub use class::Class;
+pub use lock_set::LockSet;
 
 mod acquire_ctx;
 mod class;
+mod lock_set;
 
 /// A wound-wait (ww) mutex that is powered with deadlock avoidance
 /// when acquiring multiple locks of the same [`Class`].
diff --git a/rust/kernel/sync/lock/ww_mutex/lock_set.rs b/rust/kernel/sync/lock/ww_mutex/lock_set.rs
new file mode 100644
index 000000000000..ae234fd1e0be
--- /dev/null
+++ b/rust/kernel/sync/lock/ww_mutex/lock_set.rs
@@ -0,0 +1,245 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Provides [`LockSet`] which automatically detects [`EDEADLK`],
+//! releases all locks, resets the state and retries the user
+//! supplied locking algorithm until success.
+
+use super::{AcquireCtx, Class, Mutex};
+use crate::bindings;
+use crate::prelude::*;
+use crate::types::NotThreadSafe;
+use core::ptr::NonNull;
+
+/// A tracked set of [`Mutex`] locks acquired under the same [`Class`].
+///
+/// It ensures proper cleanup and retry mechanism on deadlocks and provides
+/// safe access to locked data via [`LockSet::with_locked`].
+///
+/// Typical usage is through [`LockSet::lock_all`], which retries a
+/// user supplied locking algorithm until it succeeds without deadlock.
+pub struct LockSet<'a> {
+    acquire_ctx: Pin<KBox<AcquireCtx<'a>>>,
+    taken: KVec<RawGuard>,
+    class: &'a Class,
+}
+
+/// Used by `LockSet` to track acquired locks.
+///
+/// This type is strictly crate-private and must never be exposed
+/// outside this crate.
+struct RawGuard {
+    mutex_ptr: NonNull<bindings::ww_mutex>,
+    _not_send: NotThreadSafe,
+}
+
+impl Drop for RawGuard {
+    fn drop(&mut self) {
+        // SAFETY: `mutex_ptr` originates from a locked `Mutex` and remains
+        // valid for the lifetime of this guard, so unlocking here is sound.
+        unsafe { bindings::ww_mutex_unlock(self.mutex_ptr.as_ptr()) };
+    }
+}
+
+impl<'a> Drop for LockSet<'a> {
+    fn drop(&mut self) {
+        self.release_all_locks();
+    }
+}
+
+impl<'a> LockSet<'a> {
+    /// Creates a new [`LockSet`] with the given class.
+    ///
+    /// All locks taken through this [`LockSet`] must belong to the
+    /// same class.
+    pub fn new(class: &'a Class) -> Result<Self> {
+        Ok(Self {
+            acquire_ctx: KBox::pin_init(AcquireCtx::new(class), GFP_KERNEL)?,
+            taken: KVec::new(),
+            class,
+        })
+    }
+
+    /// Creates a new [`LockSet`] using an existing [`AcquireCtx`] and
+    /// [`Class`].
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that `acquire_ctx` is properly initialized,
+    /// holds no mutexes and that the provided `class` matches the one used
+    /// to initialize the given `acquire_ctx`.
+    pub unsafe fn new_with_acquire_ctx(
+        acquire_ctx: Pin<KBox<AcquireCtx<'a>>>,
+        class: &'a Class,
+    ) -> Self {
+        Self {
+            acquire_ctx,
+            taken: KVec::new(),
+            class,
+        }
+    }
+
+    /// Attempts to lock a [`Mutex`] and records the guard.
+    ///
+    /// Returns [`EDEADLK`] if lock ordering would cause a deadlock.
+    ///
+    /// Returns [`EBUSY`] if `mutex` was locked outside of this [`LockSet`].
+    ///
+    /// # Safety
+    ///
+    /// The given `mutex` must be created with the [`Class`] that was used
+    /// to initialize this [`LockSet`].
+    pub unsafe fn lock<T>(&mut self, mutex: &'a Mutex<'a, T>) -> Result {
+        if mutex.is_locked()
+            && !self
+                .taken
+                .iter()
+                .any(|guard| guard.mutex_ptr.as_ptr() == mutex.inner.get())
+        {
+            return Err(EBUSY);
+        }
+
+        // SAFETY: By the safety contract, `mutex` belongs to the same `Class`
+        // as `self.acquire_ctx` does.
+        let guard = unsafe { self.acquire_ctx.lock(mutex)? };
+
+        self.taken.push(
+            RawGuard {
+                // SAFETY: We just locked it above so it's a valid pointer.
+                mutex_ptr: unsafe { NonNull::new_unchecked(guard.mutex.inner.get()) },
+                _not_send: NotThreadSafe,
+            },
+            GFP_KERNEL,
+        )?;
+
+        // Avoid unlocking here; `release_all_locks` (also run by `Drop`)
+        // performs the unlock for `LockSet`.
+        core::mem::forget(guard);
+
+        Ok(())
+    }
+
+    /// Runs `locking_algorithm` until success with retrying on deadlock.
+    ///
+    /// `locking_algorithm` should attempt to acquire all needed locks.
+    /// If [`EDEADLK`] is detected, this function will roll back, reset
+    /// the context and retry automatically.
+    ///
+    /// Once all locks are acquired successfully, `on_all_locks_taken` is
+    /// invoked for exclusive access to the locked values. Afterwards, all
+    /// locks are released.
+    ///
+    /// # Example
+    ///
+    /// ```
+    /// use kernel::alloc::KBox;
+    /// use kernel::c_str;
+    /// use kernel::prelude::*;
+    /// use kernel::sync::Arc;
+    /// use kernel::sync::lock::ww_mutex::{Class, LockSet, Mutex};
+    /// use pin_init::stack_pin_init;
+    ///
+    /// stack_pin_init!(let class = Class::new_wound_wait(c_str!("test")));
+    ///
+    /// let mutex1 = Arc::pin_init(Mutex::new(0, &class), GFP_KERNEL)?;
+    /// let mutex2 = Arc::pin_init(Mutex::new(0, &class), GFP_KERNEL)?;
+    /// let mut lock_set = KBox::pin_init(LockSet::new(&class)?, GFP_KERNEL)?;
+    ///
+    /// lock_set.lock_all(
+    ///     // `locking_algorithm` closure
+    ///     |lock_set| {
+    ///         // SAFETY: Both `lock_set` and `mutex1` uses the same class.
+    ///         unsafe { lock_set.lock(&mutex1)? };
+    ///
+    ///         // SAFETY: Both `lock_set` and `mutex2` uses the same class.
+    ///         unsafe { lock_set.lock(&mutex2)? };
+    ///
+    ///         Ok(())
+    ///     },
+    ///     // `on_all_locks_taken` closure
+    ///     |lock_set| {
+    ///         // Safely mutate both values while holding the locks.
+    ///         lock_set.with_locked(&mutex1, |v| *v += 1)?;
+    ///         lock_set.with_locked(&mutex2, |v| *v += 1)?;
+    ///
+    ///         Ok(())
+    ///     },
+    /// )?;
+    ///
+    /// # Ok::<(), Error>(())
+    /// ```
+    pub fn lock_all<T, Y, Z>(
+        &mut self,
+        mut locking_algorithm: T,
+        mut on_all_locks_taken: Y,
+    ) -> Result<Z>
+    where
+        T: FnMut(&mut LockSet<'a>) -> Result,
+        Y: FnMut(&mut LockSet<'a>) -> Result<Z>,
+    {
+        loop {
+            match locking_algorithm(self) {
+                Ok(()) => {
+                    // All locks in `locking_algorithm` succeeded.
+                    // The user can now safely use them in `on_all_locks_taken`.
+                    let res = on_all_locks_taken(self);
+                    self.release_all_locks();
+
+                    return res;
+                }
+                Err(e) if e == EDEADLK => {
+                    // Deadlock detected, retry from scratch.
+                    self.cleanup_on_deadlock();
+                    continue;
+                }
+                Err(e) => {
+                    self.release_all_locks();
+                    return Err(e);
+                }
+            }
+        }
+    }
+
+    /// Executes `access` with a mutable reference to the data behind `mutex`.
+    ///
+    /// Fails with [`EINVAL`] if the mutex was not locked in this [`LockSet`].
+    pub fn with_locked<T: Unpin, Y>(
+        &mut self,
+        mutex: &'a Mutex<'a, T>,
+        access: impl for<'b> FnOnce(&'b mut T) -> Y,
+    ) -> Result<Y> {
+        let mutex_ptr = mutex.inner.get();
+
+        if self
+            .taken
+            .iter()
+            .any(|guard| guard.mutex_ptr.as_ptr() == mutex_ptr)
+        {
+            // SAFETY: We hold the lock corresponding to `mutex`, so we have
+            // exclusive access to its protected data.
+            let value = unsafe { &mut *mutex.data.get() };
+            Ok(access(value))
+        } else {
+            // `mutex` isn't locked in this `LockSet`.
+            Err(EINVAL)
+        }
+    }
+
+    /// Releases all currently held locks in this [`LockSet`].
+    fn release_all_locks(&mut self) {
+        // `Drop` implementation of the `RawGuard` takes care of the unlocking.
+        self.taken.clear();
+    }
+
+    /// Resets this [`LockSet`] after a deadlock detection.
+    ///
+    /// Drops all held locks and reinitializes the [`AcquireCtx`].
+    ///
+    /// It is intended to be used for internal implementation only.
+    fn cleanup_on_deadlock(&mut self) {
+        self.release_all_locks();
+
+        // SAFETY: We are passing the same `class` that was used
+        // to initialize `self.acquire_ctx`.
+        unsafe { self.acquire_ctx.as_mut().reinit(self.class) };
+    }
+}
-- 
2.51.2


