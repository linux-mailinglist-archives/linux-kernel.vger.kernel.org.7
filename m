Return-Path: <linux-kernel+bounces-881403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FFCC2823C
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 17:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A863B188C273
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 16:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B592FC010;
	Sat,  1 Nov 2025 16:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="FCAatfVT"
Received: from forward101d.mail.yandex.net (forward101d.mail.yandex.net [178.154.239.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82D71DFE26;
	Sat,  1 Nov 2025 16:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762013483; cv=none; b=LKjGNGsnJhKDTRh2R5DCLikuX5I6FRpmLYe24bEvzmTFqbfDTl8gifvZbMoEnUtdSfnahJ6t9Vt+4Ai6qmWFlL8d6PD8fvkHq/evIbC8y7AWD/9ZUcx5HqEzgCghFPyguvZMBQ/XCr0uTpurLe/FFvFIN7U1w7LLrIAwTldgX7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762013483; c=relaxed/simple;
	bh=pQZ1MaIlcBXVwJxO4wZy9IihKHbiQd8gAWLdk6As2pg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cBYdRgQOUFzbxK5/+QMoKBfyYKPZL1gh74aH3FGWCeegtXBUybM4djas3va1SWBT2ab/iw4zZ5RPuuZF0a2XBdS89PkYhK/lKuWSb16Bvr+o9hv1HsM8mgNC85Jllf3nMC4UIgaiGnCKheMLQU1/eCuerD4PsCXPCTr0cE243lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=FCAatfVT; arc=none smtp.client-ip=178.154.239.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:d7c6:0:640:5e67:0])
	by forward101d.mail.yandex.net (Yandex) with ESMTPS id 5A126C0084;
	Sat, 01 Nov 2025 19:11:18 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id wAkixRhLDOs0-AQDSChSN;
	Sat, 01 Nov 2025 19:11:17 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1762013477;
	bh=dAkHDegiGh4VGjRaX+pxYFkxfd7h4NKoi/+XtBkhWuw=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=FCAatfVTG1I0K+iR72eG+T+0RQVw70mAXechJI/d4uwoXOC+6NhAM1RCzMvVUXhBm
	 v54FyvYvXHtfZ0A/IybQ5V+T+NQKxJ/oU31kKNDyHbixm3ppB66K8N53k/QZHIyiL7
	 gk/U0pJBacSZ9qchjiNF2pnDJnff01tVmiNtdOPU=
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
Subject: [PATCH v7 4/6] rust: ww_mutex: add Mutex, AcquireCtx and MutexGuard
Date: Sat,  1 Nov 2025 19:10:54 +0300
Message-ID: <20251101161056.22408-5-work@onurozkan.dev>
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

Implements full locking API (lock, try_lock, slow path,
interruptible variants) and integration with kernel bindings.

Signed-off-by: Onur Özkan <work@onurozkan.dev>
---
 rust/kernel/sync/lock/ww_mutex.rs             | 276 ++++++++++++++++++
 rust/kernel/sync/lock/ww_mutex/acquire_ctx.rs | 211 +++++++++++++
 2 files changed, 487 insertions(+)
 create mode 100644 rust/kernel/sync/lock/ww_mutex/acquire_ctx.rs

diff --git a/rust/kernel/sync/lock/ww_mutex.rs b/rust/kernel/sync/lock/ww_mutex.rs
index 727c51cc73af..2a9c1c20281b 100644
--- a/rust/kernel/sync/lock/ww_mutex.rs
+++ b/rust/kernel/sync/lock/ww_mutex.rs
@@ -1,7 +1,283 @@
 // SPDX-License-Identifier: GPL-2.0
 
 //! Rust abstractions for the kernel's wound-wait locking primitives.
+//!
+//! It is designed to avoid deadlocks when locking multiple [`Mutex`]es
+//! that belong to the same [`Class`]. Each lock acquisition uses an
+//! [`AcquireCtx`] to track ordering and ensure forward progress.
 
+use crate::error::to_result;
+use crate::prelude::*;
+use crate::types::{NotThreadSafe, Opaque};
+use crate::{bindings, container_of};
+
+use core::cell::UnsafeCell;
+use core::marker::PhantomData;
+
+pub use acquire_ctx::AcquireCtx;
 pub use class::Class;
 
+mod acquire_ctx;
 mod class;
+
+/// A wound-wait (ww) mutex that is powered with deadlock avoidance
+/// when acquiring multiple locks of the same [`Class`].
+///
+/// Each mutex belongs to a [`Class`], which the wound-wait algorithm
+/// uses to figure out the order of acquisition and prevent deadlocks.
+///
+/// # Examples
+///
+/// ```
+/// use kernel::c_str;
+/// use kernel::sync::Arc;
+/// use kernel::sync::lock::ww_mutex::{AcquireCtx, Class, Mutex};
+/// use pin_init::stack_pin_init;
+///
+/// stack_pin_init!(let class = Class::new_wound_wait(c_str!("some_class")));
+/// let mutex = Arc::pin_init(Mutex::new(42, &class), GFP_KERNEL)?;
+///
+/// let ctx = KBox::pin_init(AcquireCtx::new(&class), GFP_KERNEL)?;
+///
+/// // SAFETY: Both `ctx` and `mutex` uses the same class.
+/// let guard = unsafe { ctx.lock(&mutex)? };
+/// assert_eq!(*guard, 42);
+///
+/// # Ok::<(), Error>(())
+/// ```
+#[pin_data]
+pub struct Mutex<'a, T: ?Sized> {
+    #[pin]
+    inner: Opaque<bindings::ww_mutex>,
+    _p: PhantomData<&'a Class>,
+    data: UnsafeCell<T>,
+}
+
+// SAFETY: `Mutex` can be sent to another thread if the protected
+// data `T` can be.
+unsafe impl<T: ?Sized + Send> Send for Mutex<'_, T> {}
+
+// SAFETY: `Mutex` can be shared across threads if the protected
+// data `T` can be.
+unsafe impl<T: ?Sized + Send + Sync> Sync for Mutex<'_, T> {}
+
+impl<'class, T> Mutex<'class, T> {
+    /// Initializes [`Mutex`] with the given `data` and [`Class`].
+    pub fn new(data: T, class: &'class Class) -> impl PinInit<Self> {
+        let class_ptr = class.inner.get();
+        pin_init!(Mutex {
+            inner <- Opaque::ffi_init(|slot: *mut bindings::ww_mutex| {
+                // SAFETY: `class` is valid for the lifetime `'class` captured by `Self`.
+                unsafe { bindings::ww_mutex_init(slot, class_ptr) }
+            }),
+            data: UnsafeCell::new(data),
+            _p: PhantomData
+        })
+    }
+}
+
+impl<'class> Mutex<'class, ()> {
+    /// Creates a [`Mutex`] from a raw pointer.
+    ///
+    /// This function is intended for interoperability with C code.
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that `ptr` is a valid pointer to a `ww_mutex`
+    /// and that it remains valid for the lifetime `'a`.
+    pub unsafe fn from_raw<'a>(ptr: *mut bindings::ww_mutex) -> &'a Self {
+        // SAFETY: By the safety contract, the caller guarantees that `ptr`
+        // points to a valid `ww_mutex` which is the `inner` field of `Mutex`
+        // and remains valid for the lifetime `'a`.
+        unsafe { &*container_of!(Opaque::cast_from(ptr), Self, inner) }
+    }
+}
+
+impl<'class, T: ?Sized> Mutex<'class, T> {
+    /// Checks if the mutex is currently locked.
+    pub fn is_locked(&self) -> bool {
+        // SAFETY: The mutex is pinned and valid.
+        unsafe { bindings::ww_mutex_is_locked(self.inner.get()) }
+    }
+
+    /// Locks the given mutex without acquire context ([`AcquireCtx`]).
+    pub fn lock<'a>(&'a self) -> Result<MutexGuard<'a, T>> {
+        // SAFETY: `ctx` is `None`, so no class matching is required.
+        unsafe { lock_common(self, None, LockKind::Regular) }
+    }
+
+    /// Similar to `lock`, but can be interrupted by signals.
+    pub fn lock_interruptible<'a>(&'a self) -> Result<MutexGuard<'a, T>> {
+        // SAFETY: `ctx` is `None`, so no class matching is required.
+        unsafe { lock_common(self, None, LockKind::Interruptible) }
+    }
+
+    /// Locks the given mutex without acquire context ([`AcquireCtx`]) using the slow path.
+    ///
+    /// This function should be used when `lock` fails (typically due to a potential deadlock).
+    pub fn lock_slow<'a>(&'a self) -> Result<MutexGuard<'a, T>> {
+        // SAFETY: `ctx` is `None`, so no class matching is required.
+        unsafe { lock_common(self, None, LockKind::Slow) }
+    }
+
+    /// Similar to `lock_slow`, but can be interrupted by signals.
+    pub fn lock_slow_interruptible<'a>(&'a self) -> Result<MutexGuard<'a, T>> {
+        // SAFETY: `ctx` is `None`, so no class matching is required.
+        unsafe { lock_common(self, None, LockKind::SlowInterruptible) }
+    }
+
+    /// Tries to lock the mutex with no [`AcquireCtx`] and without blocking.
+    ///
+    /// Unlike `lock`, no deadlock handling is performed.
+    pub fn try_lock<'a>(&'a self) -> Result<MutexGuard<'a, T>> {
+        // SAFETY: `ctx` is `None`, so no class matching is required.
+        unsafe { lock_common(self, None, LockKind::Try) }
+    }
+}
+
+/// A guard that provides exclusive access to the data protected
+/// by a [`Mutex`].
+///
+/// # Invariants
+///
+/// The guard holds an exclusive lock on the associated [`Mutex`]. The lock is held
+/// for the entire lifetime of this guard and is automatically released when the
+/// guard is dropped.
+#[must_use = "the lock unlocks immediately when the guard is unused"]
+pub struct MutexGuard<'a, T: ?Sized> {
+    mutex: &'a Mutex<'a, T>,
+    _not_send: NotThreadSafe,
+}
+
+// SAFETY: [`MutexGuard`] can be shared between threads if the data can.
+unsafe impl<T: ?Sized + Sync> Sync for MutexGuard<'_, T> {}
+
+impl<'a, T: ?Sized> MutexGuard<'a, T> {
+    /// Creates a new guard for a locked mutex.
+    fn new(mutex: &'a Mutex<'a, T>) -> Self {
+        Self {
+            mutex,
+            _not_send: NotThreadSafe,
+        }
+    }
+}
+
+impl<'a> MutexGuard<'a, ()> {
+    /// Creates a [`MutexGuard`] from a raw pointer.
+    ///
+    /// This function is intended for interoperability with C code.
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that `ptr` is a valid pointer to a `ww_mutex`
+    /// and that it remains valid for the lifetime `'a`.
+    pub unsafe fn from_raw<'b>(ptr: *mut bindings::ww_mutex) -> MutexGuard<'b, ()> {
+        // SAFETY: By the safety contract, the caller guarantees that `ptr`
+        // points to a valid `ww_mutex` which is the `mutex` field of `Mutex`
+        // and remains valid for the lifetime `'a`.
+        let mutex = unsafe { Mutex::from_raw(ptr) };
+
+        MutexGuard::new(mutex)
+    }
+}
+
+impl<T: ?Sized> core::ops::Deref for MutexGuard<'_, T> {
+    type Target = T;
+
+    fn deref(&self) -> &Self::Target {
+        // SAFETY: We hold the lock, so we have exclusive access.
+        unsafe { &*self.mutex.data.get() }
+    }
+}
+
+impl<T: ?Sized + Unpin> core::ops::DerefMut for MutexGuard<'_, T> {
+    fn deref_mut(&mut self) -> &mut Self::Target {
+        // SAFETY: We hold the lock, so we have exclusive access.
+        unsafe { &mut *self.mutex.data.get() }
+    }
+}
+
+impl<T: ?Sized> Drop for MutexGuard<'_, T> {
+    fn drop(&mut self) {
+        // SAFETY: We hold the lock and are about to release it.
+        unsafe { bindings::ww_mutex_unlock(self.mutex.inner.get()) };
+    }
+}
+
+/// Locking kinds used by [`lock_common`] to unify the internal
+/// locking logic.
+///
+/// It's best not to expose this type (and [`lock_common`]) to the
+/// kernel, as it allows internal API changes without worrying
+/// about breaking external compatibility.
+#[derive(Copy, Clone, Debug)]
+enum LockKind {
+    /// Blocks until lock is acquired.
+    Regular,
+    /// Blocks but can be interrupted by signals.
+    Interruptible,
+    /// Used in slow path after deadlock detection.
+    Slow,
+    /// Slow path but interruptible.
+    SlowInterruptible,
+    /// Does not block, returns immediately if busy.
+    Try,
+}
+
+/// Internal helper that unifies the different locking kinds.
+///
+/// # Safety
+///
+/// If `ctx` is `Some`, the given `mutex` must be created with the [`Class`] that
+/// was used to initialize `ctx`.
+unsafe fn lock_common<'a, T: ?Sized>(
+    mutex: &'a Mutex<'a, T>,
+    ctx: Option<&AcquireCtx<'_>>,
+    kind: LockKind,
+) -> Result<MutexGuard<'a, T>> {
+    let ctx_ptr = ctx.map_or(core::ptr::null_mut(), |c| c.inner.get());
+
+    let mutex_ptr = mutex.inner.get();
+
+    match kind {
+        LockKind::Regular => {
+            // SAFETY: `Mutex` is always pinned. If `AcquireCtx` is `Some`, it is pinned,
+            // if `None`, it is set to `core::ptr::null_mut()`. Both cases are safe.
+            let ret = unsafe { bindings::ww_mutex_lock(mutex_ptr, ctx_ptr) };
+
+            to_result(ret)?;
+        }
+        LockKind::Interruptible => {
+            // SAFETY: `Mutex` is always pinned. If `AcquireCtx` is `Some`, it is pinned,
+            // if `None`, it is set to `core::ptr::null_mut()`. Both cases are safe.
+            let ret = unsafe { bindings::ww_mutex_lock_interruptible(mutex_ptr, ctx_ptr) };
+
+            to_result(ret)?;
+        }
+        LockKind::Slow => {
+            // SAFETY: `Mutex` is always pinned. If `AcquireCtx` is `Some`, it is pinned,
+            // if `None`, it is set to `core::ptr::null_mut()`. Both cases are safe.
+            unsafe { bindings::ww_mutex_lock_slow(mutex_ptr, ctx_ptr) };
+        }
+        LockKind::SlowInterruptible => {
+            // SAFETY: `Mutex` is always pinned. If `AcquireCtx` is `Some`, it is pinned,
+            // if `None`, it is set to `core::ptr::null_mut()`. Both cases are safe.
+            let ret = unsafe { bindings::ww_mutex_lock_slow_interruptible(mutex_ptr, ctx_ptr) };
+
+            to_result(ret)?;
+        }
+        LockKind::Try => {
+            // SAFETY: `Mutex` is always pinned. If `AcquireCtx` is `Some`, it is pinned,
+            // if `None`, it is set to `core::ptr::null_mut()`. Both cases are safe.
+            let ret = unsafe { bindings::ww_mutex_trylock(mutex_ptr, ctx_ptr) };
+
+            if ret == 0 {
+                return Err(EBUSY);
+            } else {
+                to_result(ret)?;
+            }
+        }
+    };
+
+    Ok(MutexGuard::new(mutex))
+}
diff --git a/rust/kernel/sync/lock/ww_mutex/acquire_ctx.rs b/rust/kernel/sync/lock/ww_mutex/acquire_ctx.rs
new file mode 100644
index 000000000000..65a955b5809d
--- /dev/null
+++ b/rust/kernel/sync/lock/ww_mutex/acquire_ctx.rs
@@ -0,0 +1,211 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Provides [`AcquireCtx`] for managing multiple wound/wait
+//! mutexes from the same [`Class`].
+
+use crate::bindings;
+use crate::prelude::*;
+use crate::types::Opaque;
+
+use core::marker::PhantomData;
+
+use super::{lock_common, Class, LockKind, Mutex, MutexGuard};
+
+/// Groups multiple [`Mutex`]es for deadlock avoidance when acquired
+/// with the same [`Class`].
+///
+/// # Examples
+///
+/// ```
+/// use kernel::sync::lock::ww_mutex::{Class, AcquireCtx, Mutex};
+/// use kernel::c_str;
+/// use kernel::sync::Arc;
+/// use pin_init::stack_pin_init;
+///
+/// stack_pin_init!(let class = Class::new_wound_wait(c_str!("demo")));
+///
+/// // Create mutexes.
+/// let mutex1 = Arc::pin_init(Mutex::new(1, &class), GFP_KERNEL)?;
+/// let mutex2 = Arc::pin_init(Mutex::new(2, &class), GFP_KERNEL)?;
+///
+/// // Create acquire context for deadlock avoidance.
+/// let ctx = KBox::pin_init(AcquireCtx::new(&class), GFP_KERNEL)?;
+///
+/// let guard1 = unsafe { ctx.lock(&mutex1)? };
+/// let guard2 = unsafe { ctx.lock(&mutex2)? };
+///
+/// // Mark acquisition phase as complete.
+/// // SAFETY: It's called exactly once here and nowhere else.
+/// unsafe { ctx.done() };
+///
+/// # Ok::<(), Error>(())
+/// ```
+#[pin_data(PinnedDrop)]
+#[repr(transparent)]
+pub struct AcquireCtx<'a> {
+    #[pin]
+    pub(super) inner: Opaque<bindings::ww_acquire_ctx>,
+    _p: PhantomData<&'a Class>,
+}
+
+impl<'class> AcquireCtx<'class> {
+    /// Initializes a new [`AcquireCtx`] with the given `class`.
+    pub fn new(class: &'class Class) -> impl PinInit<Self> {
+        let class_ptr = class.inner.get();
+        pin_init!(AcquireCtx {
+            inner <- Opaque::ffi_init(|slot: *mut bindings::ww_acquire_ctx| {
+                // SAFETY: `class` is valid for the lifetime `'class` captured
+                // by `AcquireCtx`.
+                unsafe { bindings::ww_acquire_init(slot, class_ptr) }
+            }),
+            _p: PhantomData
+        })
+    }
+
+    /// Creates a [`AcquireCtx`] from a raw pointer.
+    ///
+    /// This function is intended for interoperability with C code.
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that `ptr` is a valid pointer to the `inner` field
+    /// of [`AcquireCtx`] and that it remains valid for the lifetime `'a`.
+    pub unsafe fn from_raw<'a>(ptr: *mut bindings::ww_acquire_ctx) -> &'a Self {
+        // SAFETY: By the safety contract, `ptr` is valid to construct `AcquireCtx`.
+        unsafe { &*ptr.cast() }
+    }
+
+    /// Marks the end of the acquire phase.
+    ///
+    /// Calling this function is optional. It is just useful to document
+    /// the code and clearly designated the acquire phase from actually
+    /// using the locked data structures.
+    ///
+    /// After calling this function, no more mutexes can be acquired with
+    /// this context.
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that this function is called only once.
+    pub unsafe fn done(&self) {
+        // SAFETY: By the safety contract, the caller guarantees that this
+        // function is called only once.
+        unsafe { bindings::ww_acquire_done(self.inner.get()) };
+    }
+
+    /// Re-initializes the [`AcquireCtx`].
+    ///
+    /// Must be called after releasing all locks when [`EDEADLK`] occurs.
+    ///
+    /// # Safety
+    ///
+    /// The given class must be equal to the class that was used to
+    /// initialize this [`AcquireCtx`].
+    pub unsafe fn reinit(self: Pin<&mut Self>, class: &'class Class) {
+        let ctx = self.inner.get();
+
+        // SAFETY:
+        //  - Lifetime of any guard (which hold an immutable borrow of `self`) cannot overlap
+        //    with the execution of this function. This enforces that all locks acquired via
+        //    this context have been released.
+        //
+        //  - `ctx` is valid pointer to a `ww_acquire_ctx`.
+        //
+        //  - `ctx` is guaranteed to be initialized because `ww_acquire_fini`
+        //    can only be called from the `Drop` implementation.
+        //
+        //  - `ww_acquire_fini` is safe to call on an initialized context.
+        unsafe { bindings::ww_acquire_fini(ctx) };
+
+        // SAFETY:
+        //  - `ctx` is valid pointer to a `ww_acquire_ctx`.
+        //
+        //  - `class` is a valid pointer to a `ww_class`.
+        //
+        //  - `ww_acquire_init` is safe to call with valid pointers
+        //     to initialize an uninitialized context.
+        //
+        //   - By the safety contract, the caller guarantees that the given
+        //     `class` is the same as the one used to initialize this `AcquireCtx`.
+        unsafe { bindings::ww_acquire_init(ctx, class.inner.get()) };
+    }
+
+    /// Locks the given mutex on this [`AcquireCtx`].
+    ///
+    /// # Safety
+    ///
+    /// The given `mutex` must be created with the [`Class`] that was used
+    /// to initialize this [`AcquireCtx`].
+    pub unsafe fn lock<'a, T>(&'a self, mutex: &'a Mutex<'a, T>) -> Result<MutexGuard<'a, T>> {
+        // SAFETY: By the safety contract, `mutex` belongs to the same `Class`
+        // as `self` does.
+        unsafe { lock_common(mutex, Some(self), LockKind::Regular) }
+    }
+
+    /// Similar to `lock`, but can be interrupted by signals.
+    ///
+    /// # Safety
+    ///
+    /// The given `mutex` must be created with the [`Class`] that was used
+    /// to initialize this [`AcquireCtx`].
+    pub unsafe fn lock_interruptible<'a, T>(
+        &'a self,
+        mutex: &'a Mutex<'a, T>,
+    ) -> Result<MutexGuard<'a, T>> {
+        // SAFETY: By the safety contract, `mutex` belongs to the same `Class`
+        // as `self` does.
+        unsafe { lock_common(mutex, Some(self), LockKind::Interruptible) }
+    }
+
+    /// Locks the given mutex on this [`AcquireCtx`] using the slow path.
+    ///
+    /// This function should be used when `lock` fails (typically due to a potential deadlock).
+    ///
+    /// # Safety
+    ///
+    /// The given `mutex` must be created with the [`Class`] that was used
+    /// to initialize this [`AcquireCtx`].
+    pub unsafe fn lock_slow<'a, T>(&'a self, mutex: &'a Mutex<'a, T>) -> Result<MutexGuard<'a, T>> {
+        // SAFETY: By the safety contract, `mutex` belongs to the same `Class`
+        // as `self` does.
+        unsafe { lock_common(mutex, Some(self), LockKind::Slow) }
+    }
+
+    /// Similar to `lock_slow`, but can be interrupted by signals.
+    ///
+    /// # Safety
+    ///
+    /// The given `mutex` must be created with the [`Class`] that was used
+    /// to initialize this [`AcquireCtx`].
+    pub unsafe fn lock_slow_interruptible<'a, T>(
+        &'a self,
+        mutex: &'a Mutex<'a, T>,
+    ) -> Result<MutexGuard<'a, T>> {
+        // SAFETY: By the safety contract, `mutex` belongs to the same `Class`
+        // as `self` does.
+        unsafe { lock_common(mutex, Some(self), LockKind::SlowInterruptible) }
+    }
+
+    /// Tries to lock the mutex on this [`AcquireCtx`] without blocking.
+    ///
+    /// Unlike `lock`, no deadlock handling is performed.
+    ///
+    /// # Safety
+    ///
+    /// The given `mutex` must be created with the [`Class`] that was used
+    /// to initialize this [`AcquireCtx`].
+    pub unsafe fn try_lock<'a, T>(&'a self, mutex: &'a Mutex<'a, T>) -> Result<MutexGuard<'a, T>> {
+        // SAFETY: By the safety contract, `mutex` belongs to the same `Class`
+        // as `self` does.
+        unsafe { lock_common(mutex, Some(self), LockKind::Try) }
+    }
+}
+
+#[pinned_drop]
+impl PinnedDrop for AcquireCtx<'_> {
+    fn drop(self: Pin<&mut Self>) {
+        // SAFETY: Given the lifetime bounds we know no locks are held,
+        // so calling `ww_acquire_fini` is safe.
+        unsafe { bindings::ww_acquire_fini(self.inner.get()) };
+    }
+}
-- 
2.51.2


