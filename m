Return-Path: <linux-kernel+bounces-798649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3AB3B420B9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCDC11BA77E3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F8630506B;
	Wed,  3 Sep 2025 13:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="BoK71ECS"
Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net [178.154.239.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8864F2FCBF3;
	Wed,  3 Sep 2025 13:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756905244; cv=none; b=MHQbXNKbz3K+eGgp+q3ef9sNJ5SZWKLSdcvjUWfa4uOrSN9v4uJISXgWW37+GXrv0TW3jTJ3pivzQ80RtWoIDxH/MGxdeF0IAVs2TZgxqG9O7JYVkrUKjEy02BeFo8o78f5LAMhjp4wqqUVpLaTZ5tB/m3JtLBWqiQtjz7y28LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756905244; c=relaxed/simple;
	bh=8a1/RDIg8GBMVKRyF9jzPeWsj1yUL3ElTD6jBWjf+9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O856Uq1NqOC9NvFJhqaWwcf/DZx9m0oPTmjnHq16ne18vfVxYF3K67aKanlZgexWK18iWKHaNriYYd+eiAN4MATEo01AqnlBElhJcyhtMKhvgdv9czp3ayiyeBAJgW9RQ3wGw1KlIM0wnf8/AD0KuCpkWdqFo+MemUN0ndIvGOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=BoK71ECS; arc=none smtp.client-ip=178.154.239.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-60.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-60.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1d:3e17:0:640:f9aa:0])
	by forward101a.mail.yandex.net (Yandex) with ESMTPS id EA1BA80667;
	Wed, 03 Sep 2025 16:14:00 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-60.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id GDgKkBDMquQ0-wB0L7ghY;
	Wed, 03 Sep 2025 16:14:00 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1756905240;
	bh=fX5tIadeGmsn1nuEvbzWpE8yuM5oc8WY6qQ0TIgO6+I=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=BoK71ECSSRAASnE0p7KIzD1Gxpg95AsBUPV3JmwQr2GW2zWWxZcOO7/9GR4DaIcLe
	 ae2dZ8nNS14pKOW2CJRqwrY1O+r06c9qjIGWMugxPul/36ErELEMZYKwPdNifyTV2o
	 z3yC4ylPLn8DexJjKZ/LqpH5cc1Pdg8g1l6UiUrs=
Authentication-Results: mail-nwsmtp-smtp-production-main-60.vla.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
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
	bjorn3_gh@protonmail.com,
	daniel.almeida@collabora.com,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Subject: [PATCH v6 6/7] rust: ww_mutex/exec: add high-level API
Date: Wed,  3 Sep 2025 16:13:12 +0300
Message-ID: <20250903131313.4365-7-work@onurozkan.dev>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250903131313.4365-1-work@onurozkan.dev>
References: <20250903131313.4365-1-work@onurozkan.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

`ExecContext` is a helper built on top of ww_mutex
that provides a retrying interface for lock acquisition.
When `EDEADLK` is hit, it drops all held locks, resets
the acquire context and retries the given (by the user)
locking algorithm until it succeeds.

The API keeps track of acquired locks, cleans them up
automatically and allows data access to the protected
data through `with_locked()`. The `lock_all()` helper
allows implementing multi-mutex algorithms in a simpler
and less error-prone way while keeping the ww_mutex
semantics.

Signed-off-by: Onur Özkan <work@onurozkan.dev>
---
 rust/kernel/sync/lock/ww_mutex.rs      |   2 +
 rust/kernel/sync/lock/ww_mutex/exec.rs | 176 +++++++++++++++++++++++++
 2 files changed, 178 insertions(+)
 create mode 100644 rust/kernel/sync/lock/ww_mutex/exec.rs

diff --git a/rust/kernel/sync/lock/ww_mutex.rs b/rust/kernel/sync/lock/ww_mutex.rs
index b415d6deae9b..7de6578513e5 100644
--- a/rust/kernel/sync/lock/ww_mutex.rs
+++ b/rust/kernel/sync/lock/ww_mutex.rs
@@ -16,6 +16,8 @@
 use core::cell::UnsafeCell;
 use core::marker::PhantomData;

+pub mod exec;
+
 /// Create static [`WwClass`] instances.
 ///
 /// # Examples
diff --git a/rust/kernel/sync/lock/ww_mutex/exec.rs b/rust/kernel/sync/lock/ww_mutex/exec.rs
new file mode 100644
index 000000000000..2f1fc540f0b8
--- /dev/null
+++ b/rust/kernel/sync/lock/ww_mutex/exec.rs
@@ -0,0 +1,176 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! A high-level [`WwMutex`] execution helper.
+//!
+//! Provides a retrying lock mechanism on top of [`WwMutex`] and [`WwAcquireCtx`].
+//! It detects [`EDEADLK`] and handles it by rolling back and retrying the
+//! user-supplied locking algorithm until success.
+
+use crate::prelude::*;
+use crate::sync::lock::ww_mutex::{WwAcquireCtx, WwClass, WwMutex, WwMutexGuard};
+use core::ptr;
+
+/// High-level execution type for ww_mutex.
+///
+/// Tracks a series of locks acquired under a common [`WwAcquireCtx`].
+/// It ensures proper cleanup and retry mechanism on deadlocks and provides
+/// type-safe access to locked data via [`with_locked`].
+///
+/// Typical usage is through [`lock_all`], which retries a user-supplied
+/// locking algorithm until it succeeds without deadlock.
+pub struct ExecContext<'a> {
+    class: &'a WwClass,
+    acquire: Pin<KBox<WwAcquireCtx<'a>>>,
+    taken: KVec<WwMutexGuard<'a, ()>>,
+}
+
+impl<'a> Drop for ExecContext<'a> {
+    fn drop(&mut self) {
+        self.release_all_locks();
+    }
+}
+
+impl<'a> ExecContext<'a> {
+    /// Creates a new [`ExecContext`] for the given lock class.
+    ///
+    /// All locks taken through this context must belong to the same class.
+    ///
+    /// TODO: Add some safety mechanism to ensure classes are not different.
+    pub fn new(class: &'a WwClass) -> Result<Self> {
+        Ok(Self {
+            class,
+            acquire: KBox::pin_init(WwAcquireCtx::new(class), GFP_KERNEL)?,
+            taken: KVec::new(),
+        })
+    }
+
+    /// Attempts to lock a [`WwMutex`] and records the guard.
+    ///
+    /// Returns [`EDEADLK`] if lock ordering would cause a deadlock.
+    pub fn lock<T>(&mut self, mutex: &'a WwMutex<'a, T>) -> Result<()> {
+        let guard = self.acquire.lock(mutex)?;
+        // SAFETY: Type is erased for storage. Actual access uses `with_locked`
+        // which safely casts back.
+        let erased: WwMutexGuard<'a, ()> = unsafe { core::mem::transmute(guard) };
+        self.taken.push(erased, GFP_KERNEL)?;
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
+    /// use kernel::sync::lock::ww_mutex;
+    /// use pin_init::stack_pin_init;
+    ///
+    /// stack_pin_init!(let class = ww_mutex::WwClass::new_wound_wait(c_str!("lock_all_example")));
+    ///
+    /// let mutex1 = Arc::pin_init(ww_mutex::WwMutex::new(0, &class), GFP_KERNEL)?;
+    /// let mutex2 = Arc::pin_init(ww_mutex::WwMutex::new(0, &class), GFP_KERNEL)?;
+    /// let mut ctx = KBox::pin_init(ww_mutex::exec::ExecContext::new(&class)?, GFP_KERNEL)?;
+    ///
+    /// ctx.lock_all(
+    ///     |ctx| {
+    ///         // Try to lock both mutexes.
+    ///         ctx.lock(&mutex1)?;
+    ///         ctx.lock(&mutex2)?;
+    ///
+    ///         Ok(())
+    ///     },
+    ///     |ctx| {
+    ///         // Safely mutate both values while holding the locks.
+    ///         ctx.with_locked(&mutex1, |v| *v += 1)?;
+    ///         ctx.with_locked(&mutex2, |v| *v += 1)?;
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
+        T: FnMut(&mut ExecContext<'a>) -> Result<()>,
+        Y: FnMut(&mut ExecContext<'a>) -> Result<Z>,
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
+                    self.cleanup_on_deadlock()?;
+                    continue;
+                }
+                Err(e) => {
+                    return Err(e);
+                }
+            }
+        }
+    }
+
+    /// Executes `f` with a mutable reference to the data behind `mutex`.
+    ///
+    /// Fails with [`EINVAL`] if the mutex was not locked in this context.
+    pub fn with_locked<T, Y>(
+        &mut self,
+        mutex: &'a WwMutex<'a, T>,
+        f: impl FnOnce(&mut T) -> Y,
+    ) -> Result<Y> {
+        // Find the matching guard.
+        for guard in &mut self.taken {
+            if mutex.as_ptr() == guard.mutex.as_ptr() {
+                // SAFETY: We know this guard belongs to `mutex` and holds the lock.
+                let typed = unsafe { &mut *ptr::from_mut(guard).cast::<WwMutexGuard<'a, T>>() };
+                return Ok(f(&mut **typed));
+            }
+        }
+
+        // `mutex` isn't locked in this `ExecContext`.
+        Err(EINVAL)
+    }
+
+    /// Releases all currently held locks in this context.
+    ///
+    /// It is intended to be used for internal implementation only.
+    fn release_all_locks(&mut self) {
+        self.taken.clear();
+    }
+
+    /// Resets this context after a deadlock detection.
+    ///
+    /// Drops all held locks and reinitializes the [`WwAcquireCtx`].
+    ///
+    /// It is intended to be used for internal implementation only.
+    fn cleanup_on_deadlock(&mut self) -> Result {
+        self.release_all_locks();
+        // Re-init fresh `WwAcquireCtx`.
+        self.acquire = KBox::pin_init(WwAcquireCtx::new(self.class), GFP_KERNEL)?;
+
+        Ok(())
+    }
+}
--
2.50.0


