Return-Path: <linux-kernel+bounces-798674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47323B4214B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 888572063BA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96DA2FFDE6;
	Wed,  3 Sep 2025 13:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="XPxrepaM"
Received: from forward201a.mail.yandex.net (forward201a.mail.yandex.net [178.154.239.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8362FFDCA;
	Wed,  3 Sep 2025 13:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756905616; cv=none; b=WUjlBO0Y07Au3pT1N8HaValSUkN9MKFCBWu2Sqh0dfPJ2fiUBWYxZy5nOcxcvDu4NRmsLoJLRKLvrwKiXYjq3s7RlOzUZWEyW03jzORdYvW+YrOf19FKh4UzaJgQ/4+wcAgRo4sOLja1VL2pbNHlY3UJfB+R19IKZ4/VKVxnI3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756905616; c=relaxed/simple;
	bh=wPLs9MaBuHrrFvs1AV/wqQc7ExYa69dkZnKTlSk9fRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YuCl3O+7nc+0iRHEiwQ7j9NgfFDH8Pqn+BhrGrlSWSIOOLIZcKTU9AlvRm4mUSYcK9j0QnjBSv09j9ulmgs7lAd9tm46APPzE1ETObscJ0vJnvPOMzPEPpsTR23CE7mO0z30jsreZP8YiKkB13OqwT2wWdcQlh1VKur95z2Xi4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=XPxrepaM; arc=none smtp.client-ip=178.154.239.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from forward100a.mail.yandex.net (forward100a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d100])
	by forward201a.mail.yandex.net (Yandex) with ESMTPS id EFEDA87B3E;
	Wed, 03 Sep 2025 16:13:53 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-60.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-60.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1d:3e17:0:640:f9aa:0])
	by forward100a.mail.yandex.net (Yandex) with ESMTPS id 7D475C0072;
	Wed, 03 Sep 2025 16:13:46 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-60.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id GDgKkBDMquQ0-MqKpFOhl;
	Wed, 03 Sep 2025 16:13:45 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1756905225;
	bh=iXnvkLKoz5DPGCrAQJ3fuzmev6s3f2CTHUPCTUNUIkY=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=XPxrepaMdCHUvTzy1AZApYPzymxbbpRMT2czG5cYIqzs6mFZILrvmMblLzJdWCVkx
	 MeFEp/TxoT8qHwwY/UMAGuYzvmYgUJHbFXu/9eyiKTacjMDae40cAnxDx1hnB2rzMf
	 lYJtXYAfCHuOyxi0WWbX+H5mDcy382CLawBUICcQ=
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
Subject: [PATCH v6 3/7] rust: implement `WwMutex`, `WwAcquireCtx` and `WwMutexGuard`
Date: Wed,  3 Sep 2025 16:13:09 +0300
Message-ID: <20250903131313.4365-4-work@onurozkan.dev>
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

Includes full locking API (lock, try_lock, slow path, interruptible variants)
and integration with kernel bindings.

Also adds the `EDEADLK` error code to support deadlock detection.

Signed-off-by: Onur Özkan <work@onurozkan.dev>
---
 rust/kernel/error.rs              |   1 +
 rust/kernel/sync/lock/ww_mutex.rs | 289 +++++++++++++++++++++++++++++-
 2 files changed, 289 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index a41de293dcd1..560de6117094 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -64,6 +64,7 @@ macro_rules! declare_err {
     declare_err!(EPIPE, "Broken pipe.");
     declare_err!(EDOM, "Math argument out of domain of func.");
     declare_err!(ERANGE, "Math result not representable.");
+    declare_err!(EDEADLK, "Resource deadlock avoided.");
     declare_err!(EOVERFLOW, "Value too large for defined data type.");
     declare_err!(ETIMEDOUT, "Connection timed out.");
     declare_err!(ERESTARTSYS, "Restart the system call.");
diff --git a/rust/kernel/sync/lock/ww_mutex.rs b/rust/kernel/sync/lock/ww_mutex.rs
index ca5b4525ace6..314360632953 100644
--- a/rust/kernel/sync/lock/ww_mutex.rs
+++ b/rust/kernel/sync/lock/ww_mutex.rs
@@ -10,8 +10,11 @@
 //! For more information: <https://docs.kernel.org/locking/ww-mutex-design.html>

 use crate::bindings;
+use crate::error::to_result;
 use crate::prelude::*;
-use crate::types::Opaque;
+use crate::types::{NotThreadSafe, Opaque};
+use core::cell::UnsafeCell;
+use core::marker::PhantomData;

 /// Create static [`WwClass`] instances.
 ///
@@ -134,3 +137,287 @@ pub fn new_wound_wait(name: &'static CStr) -> impl PinInit<Self> {
         Self::new(name, false)
     }
 }
+
+/// Groups multiple mutex acquisitions together for deadlock avoidance.
+///
+/// Must be used when acquiring multiple mutexes of the same class.
+///
+/// # Examples
+///
+/// ```
+/// use kernel::sync::lock::ww_mutex::{WwClass, WwAcquireCtx, WwMutex};
+/// use kernel::c_str;
+/// use kernel::sync::Arc;
+/// use pin_init::stack_pin_init;
+///
+/// stack_pin_init!(let class = WwClass::new_wound_wait(c_str!("my_class")));
+///
+/// // Create mutexes.
+/// let mutex1 = Arc::pin_init(WwMutex::new(1, &class), GFP_KERNEL)?;
+/// let mutex2 = Arc::pin_init(WwMutex::new(2, &class), GFP_KERNEL)?;
+///
+/// // Create acquire context for deadlock avoidance.
+/// let ctx = KBox::pin_init(WwAcquireCtx::new(&class), GFP_KERNEL)?;
+///
+/// // Acquire multiple locks safely.
+/// let guard1 = ctx.lock(&mutex1)?;
+/// let guard2 = ctx.lock(&mutex2)?;
+///
+/// // Mark acquisition phase as complete.
+/// ctx.done();
+///
+/// # Ok::<(), Error>(())
+/// ```
+#[pin_data(PinnedDrop)]
+pub struct WwAcquireCtx<'a> {
+    #[pin]
+    inner: Opaque<bindings::ww_acquire_ctx>,
+    _p: PhantomData<&'a WwClass>,
+}
+
+impl<'ww_class> WwAcquireCtx<'ww_class> {
+    /// Initializes `Self` with calling C side `ww_acquire_init` inside.
+    pub fn new(ww_class: &'ww_class WwClass) -> impl PinInit<Self> {
+        let class = ww_class.inner.get();
+        pin_init!(WwAcquireCtx {
+            inner <- Opaque::ffi_init(|slot: *mut bindings::ww_acquire_ctx| {
+                // SAFETY: `ww_class` is valid for the lifetime `'ww_class` captured by `Self`.
+                unsafe { bindings::ww_acquire_init(slot, class) }
+            }),
+            _p: PhantomData
+        })
+    }
+
+    /// Marks the end of the acquire phase.
+    ///
+    /// After calling this function, no more mutexes can be acquired with this context.
+    pub fn done(&self) {
+        // SAFETY: The context is pinned and valid.
+        unsafe { bindings::ww_acquire_done(self.inner.get()) };
+    }
+
+    /// Locks the given mutex.
+    pub fn lock<'a, T>(&'a self, ww_mutex: &'a WwMutex<'a, T>) -> Result<WwMutexGuard<'a, T>> {
+        // SAFETY: The mutex is pinned and valid.
+        let ret = unsafe { bindings::ww_mutex_lock(ww_mutex.mutex.get(), self.inner.get()) };
+
+        to_result(ret)?;
+
+        Ok(WwMutexGuard::new(ww_mutex))
+    }
+
+    /// Similar to `lock`, but can be interrupted by signals.
+    pub fn lock_interruptible<'a, T>(
+        &'a self,
+        ww_mutex: &'a WwMutex<'a, T>,
+    ) -> Result<WwMutexGuard<'a, T>> {
+        // SAFETY: The mutex is pinned and valid.
+        let ret = unsafe {
+            bindings::ww_mutex_lock_interruptible(ww_mutex.mutex.get(), self.inner.get())
+        };
+
+        to_result(ret)?;
+
+        Ok(WwMutexGuard::new(ww_mutex))
+    }
+
+    /// Locks the given mutex using the slow path.
+    ///
+    /// This function should be used when `lock` fails (typically due to a potential deadlock).
+    pub fn lock_slow<'a, T>(&'a self, ww_mutex: &'a WwMutex<'a, T>) -> Result<WwMutexGuard<'a, T>> {
+        // SAFETY: The mutex is pinned and valid, and we're in the slow path.
+        unsafe { bindings::ww_mutex_lock_slow(ww_mutex.mutex.get(), self.inner.get()) };
+
+        Ok(WwMutexGuard::new(ww_mutex))
+    }
+
+    /// Similar to `lock_slow`, but can be interrupted by signals.
+    pub fn lock_slow_interruptible<'a, T>(
+        &'a self,
+        ww_mutex: &'a WwMutex<'a, T>,
+    ) -> Result<WwMutexGuard<'a, T>> {
+        // SAFETY: The mutex is pinned and valid, and we are in the slow path.
+        let ret = unsafe {
+            bindings::ww_mutex_lock_slow_interruptible(ww_mutex.mutex.get(), self.inner.get())
+        };
+
+        to_result(ret)?;
+
+        Ok(WwMutexGuard::new(ww_mutex))
+    }
+
+    /// Tries to lock the mutex without blocking.
+    ///
+    /// Unlike `lock`, no deadlock handling is performed.
+    pub fn try_lock<'a, T>(&'a self, ww_mutex: &'a WwMutex<'a, T>) -> Result<WwMutexGuard<'a, T>> {
+        // SAFETY: The mutex is pinned and valid.
+        let ret = unsafe { bindings::ww_mutex_trylock(ww_mutex.mutex.get(), self.inner.get()) };
+
+        if ret == 0 {
+            return Err(EBUSY);
+        } else {
+            to_result(ret)?;
+        }
+
+        Ok(WwMutexGuard::new(ww_mutex))
+    }
+}
+
+#[pinned_drop]
+impl PinnedDrop for WwAcquireCtx<'_> {
+    fn drop(self: Pin<&mut Self>) {
+        // SAFETY: The context is being dropped and is pinned.
+        unsafe { bindings::ww_acquire_fini(self.inner.get()) };
+    }
+}
+
+/// A wound/wait mutex backed with C side `ww_mutex`.
+///
+/// This is a mutual exclusion primitive that provides deadlock avoidance when
+/// acquiring multiple locks of the same class.
+///
+/// # Examples
+///
+/// ## Basic Usage
+///
+/// ```
+/// use kernel::c_str;
+/// use kernel::sync::Arc;
+/// use kernel::sync::lock::ww_mutex::{WwClass, WwAcquireCtx, WwMutex };
+/// use pin_init::stack_pin_init;
+///
+/// stack_pin_init!(let class = WwClass::new_wound_wait(c_str!("buffer_class")));
+/// let mutex = Arc::pin_init(WwMutex::new(42, &class), GFP_KERNEL)?;
+///
+/// let ctx = KBox::pin_init(WwAcquireCtx::new(&class), GFP_KERNEL)?;
+///
+/// let guard = ctx.lock(&mutex)?;
+/// assert_eq!(*guard, 42);
+///
+/// # Ok::<(), Error>(())
+/// ```
+///
+/// ## Multiple Locks
+///
+/// ```
+/// use kernel::c_str;
+/// use kernel::prelude::*;
+/// use kernel::sync::Arc;
+/// use kernel::sync::lock::ww_mutex::{WwClass, WwAcquireCtx, WwMutex};
+/// use pin_init::stack_pin_init;
+///
+/// stack_pin_init!(let class = WwClass::new_wait_die(c_str!("resource_class")));
+/// let mutex_a = Arc::pin_init(WwMutex::new("Resource A", &class), GFP_KERNEL)?;
+/// let mutex_b = Arc::pin_init(WwMutex::new("Resource B", &class), GFP_KERNEL)?;
+///
+/// let ctx = KBox::pin_init(WwAcquireCtx::new(&class), GFP_KERNEL)?;
+///
+/// // Try to acquire both locks.
+/// let guard_a = match ctx.lock(&mutex_a) {
+///     Ok(guard) => guard,
+///     Err(e) if e == EDEADLK => {
+///         // Deadlock detected, use slow path.
+///         ctx.lock_slow(&mutex_a)?
+///     }
+///     Err(e) => return Err(e),
+/// };
+///
+/// let guard_b = ctx.lock(&mutex_b)?;
+/// ctx.done();
+///
+/// # Ok::<(), Error>(())
+/// ```
+#[pin_data]
+pub struct WwMutex<'a, T: ?Sized> {
+    _p: PhantomData<&'a WwClass>,
+    #[pin]
+    mutex: Opaque<bindings::ww_mutex>,
+    data: UnsafeCell<T>,
+}
+
+// SAFETY: [`WwMutex`] can be shared between threads.
+unsafe impl<T: ?Sized + Send> Send for WwMutex<'_, T> {}
+// SAFETY: [`WwMutex`] can be safely accessed from multiple threads concurrently.
+unsafe impl<T: ?Sized + Send + Sync> Sync for WwMutex<'_, T> {}
+
+impl<'ww_class, T> WwMutex<'ww_class, T> {
+    /// Creates `Self` with calling `ww_mutex_init` inside.
+    pub fn new(t: T, ww_class: &'ww_class WwClass) -> impl PinInit<Self> {
+        let class = ww_class.inner.get();
+        pin_init!(WwMutex {
+            mutex <- Opaque::ffi_init(|slot: *mut bindings::ww_mutex| {
+                // SAFETY: `ww_class` is valid for the lifetime `'ww_class` captured by `Self`.
+                unsafe { bindings::ww_mutex_init(slot, class) }
+            }),
+            data: UnsafeCell::new(t),
+            _p: PhantomData,
+        })
+    }
+}
+
+impl<T: ?Sized> WwMutex<'_, T> {
+    /// Returns a raw pointer to the inner mutex.
+    fn as_ptr(&self) -> *mut bindings::ww_mutex {
+        self.mutex.get()
+    }
+
+    /// Checks if the mutex is currently locked.
+    ///
+    /// Intended for internal tests only and should not be used
+    /// anywhere else.
+    #[cfg(CONFIG_KUNIT)]
+    fn is_locked(&self) -> bool {
+        // SAFETY: The mutex is pinned and valid.
+        unsafe { bindings::ww_mutex_is_locked(self.mutex.get()) }
+    }
+}
+
+/// A guard that provides exclusive access to the data protected
+/// by a [`WwMutex`].
+///
+/// # Invariants
+///
+/// The guard holds an exclusive lock on the associated [`WwMutex`]. The lock is held
+/// for the entire lifetime of this guard and is automatically released when the
+/// guard is dropped.
+#[must_use = "the lock unlocks immediately when the guard is unused"]
+pub struct WwMutexGuard<'a, T: ?Sized> {
+    mutex: &'a WwMutex<'a, T>,
+    _not_send: NotThreadSafe,
+}
+
+// SAFETY: [`WwMutexGuard`] can be shared between threads if the data can.
+unsafe impl<T: ?Sized + Sync> Sync for WwMutexGuard<'_, T> {}
+
+impl<'a, T: ?Sized> WwMutexGuard<'a, T> {
+    /// Creates a new guard for a locked mutex.
+    fn new(mutex: &'a WwMutex<'a, T>) -> Self {
+        Self {
+            mutex,
+            _not_send: NotThreadSafe,
+        }
+    }
+}
+
+impl<T: ?Sized> core::ops::Deref for WwMutexGuard<'_, T> {
+    type Target = T;
+
+    fn deref(&self) -> &Self::Target {
+        // SAFETY: We hold the lock, so we have exclusive access.
+        unsafe { &*self.mutex.data.get() }
+    }
+}
+
+impl<T: ?Sized> core::ops::DerefMut for WwMutexGuard<'_, T> {
+    fn deref_mut(&mut self) -> &mut Self::Target {
+        // SAFETY: We hold the lock, so we have exclusive access.
+        unsafe { &mut *self.mutex.data.get() }
+    }
+}
+
+impl<T: ?Sized> Drop for WwMutexGuard<'_, T> {
+    fn drop(&mut self) {
+        // SAFETY: We hold the lock and are about to release it.
+        unsafe { bindings::ww_mutex_unlock(self.mutex.as_ptr()) };
+    }
+}
--
2.50.0


