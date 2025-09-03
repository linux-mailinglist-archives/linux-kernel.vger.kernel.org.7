Return-Path: <linux-kernel+bounces-798679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C741CB42143
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97DED1BC2B26
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FE126CE3A;
	Wed,  3 Sep 2025 13:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="INEbLN0+"
Received: from forward200a.mail.yandex.net (forward200a.mail.yandex.net [178.154.239.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC8C302776;
	Wed,  3 Sep 2025 13:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756905714; cv=none; b=rmqTEeWx2+0DyAMXaZrAVD77YGvv93IIWy/rcnUdrZQ3CdxVBZwgTYD3ZNeMgEgtUQIYsTwP8QJffmz+qnYkTRSVmQvSo//p3YOnLKk2aoSp3o97zh+v8vKyv4L/yZwQrxML644KvOiAibEZBNsPs74qiEItKsRwNOCnIJUIHWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756905714; c=relaxed/simple;
	bh=241EcV2ADYh/RMMNn/20PxWBFaGYRKkSQEUt0Gl0+Jo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VOoiX4ehLXXaO7juygrlxiN5Lx2OT4Iy4/whc0yTD0pEoQOJAwHuvSWjvSLyFoHnEz1w8xPuq1KW8LmiJhUZ4ht4LD4Iw016veia1Zy698mDmRbGYKpoQsw+AYbbpLp/E7Zv1FD6eolXrQbFfklt/LL+aaTZ6SLalkNzC4wyhFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=INEbLN0+; arc=none smtp.client-ip=178.154.239.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d101])
	by forward200a.mail.yandex.net (Yandex) with ESMTPS id 069AF87274;
	Wed, 03 Sep 2025 16:14:04 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-60.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-60.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1d:3e17:0:640:f9aa:0])
	by forward101a.mail.yandex.net (Yandex) with ESMTPS id 1AAE980CE4;
	Wed, 03 Sep 2025 16:13:56 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-60.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id GDgKkBDMquQ0-nq4gd7wA;
	Wed, 03 Sep 2025 16:13:55 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1756905235;
	bh=3cG9UNuKFe5wpsh/oW1uFyaeMYCPP67dHmjUcqImnK0=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=INEbLN0+31LQnfKTu6qCQA0bkNM1JObFtzmusCrZW6oKSVFLrimrWbzmKX4E7p73i
	 uMZY53x+NyTt4F6JpBNEQPBcW5UuHuxVpvH+FIdea6Isf1Ru4sC7O24SZXUxQd4qqY
	 QhjTt+KRLPruxeegaFOC+Er4xEr23AUgSz1FlXVc=
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
Subject: [PATCH v6 5/7] rust: ww_mutex: add context-free locking functions
Date: Wed,  3 Sep 2025 16:13:11 +0300
Message-ID: <20250903131313.4365-6-work@onurozkan.dev>
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

Adds new `WwMutex` functions (`lock`, `lock_interruptible`,
`lock_slow`, `lock_slow_interruptible` and `try_lock`) that
can be used without `WwAcquireCtx`. This provides simpler API
when deadlock avoidance grouping is not needed.

Signed-off-by: Onur Özkan <work@onurozkan.dev>
---
 rust/kernel/sync/lock/ww_mutex.rs | 162 ++++++++++++++++++++++--------
 1 file changed, 122 insertions(+), 40 deletions(-)

diff --git a/rust/kernel/sync/lock/ww_mutex.rs b/rust/kernel/sync/lock/ww_mutex.rs
index d289718d2c98..b415d6deae9b 100644
--- a/rust/kernel/sync/lock/ww_mutex.rs
+++ b/rust/kernel/sync/lock/ww_mutex.rs
@@ -138,6 +138,75 @@ pub fn new_wound_wait(name: &'static CStr) -> impl PinInit<Self> {
     }
 }

+/// Locking kinds used by [`lock_common`] to unify internal FFI locking logic.
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
+fn lock_common<'a, T: ?Sized>(
+    ww_mutex: &'a WwMutex<'a, T>,
+    ctx: Option<&WwAcquireCtx<'_>>,
+    kind: LockKind,
+) -> Result<WwMutexGuard<'a, T>> {
+    let ctx_ptr = ctx.map_or(core::ptr::null_mut(), |c| c.inner.get());
+
+    match kind {
+        LockKind::Regular => {
+            // SAFETY: `WwMutex` is always pinned. If `WwAcquireCtx` is `Some`, it is pinned,
+            // if `None`, it is set to `core::ptr::null_mut()`. Both cases are safe.
+            let ret = unsafe { bindings::ww_mutex_lock(ww_mutex.mutex.get(), ctx_ptr) };
+
+            to_result(ret)?;
+        }
+        LockKind::Interruptible => {
+            // SAFETY: `WwMutex` is always pinned. If `WwAcquireCtx` is `Some`, it is pinned,
+            // if `None`, it is set to `core::ptr::null_mut()`. Both cases are safe.
+            let ret =
+                unsafe { bindings::ww_mutex_lock_interruptible(ww_mutex.mutex.get(), ctx_ptr) };
+
+            to_result(ret)?;
+        }
+        LockKind::Slow => {
+            // SAFETY: `WwMutex` is always pinned. If `WwAcquireCtx` is `Some`, it is pinned,
+            // if `None`, it is set to `core::ptr::null_mut()`. Both cases are safe.
+            unsafe { bindings::ww_mutex_lock_slow(ww_mutex.mutex.get(), ctx_ptr) };
+        }
+        LockKind::SlowInterruptible => {
+            // SAFETY: `WwMutex` is always pinned. If `WwAcquireCtx` is `Some`, it is pinned,
+            // if `None`, it is set to `core::ptr::null_mut()`. Both cases are safe.
+            let ret = unsafe {
+                bindings::ww_mutex_lock_slow_interruptible(ww_mutex.mutex.get(), ctx_ptr)
+            };
+
+            to_result(ret)?;
+        }
+        LockKind::Try => {
+            // SAFETY: `WwMutex` is always pinned. If `WwAcquireCtx` is `Some`, it is pinned,
+            // if `None`, it is set to `core::ptr::null_mut()`. Both cases are safe.
+            let ret = unsafe { bindings::ww_mutex_trylock(ww_mutex.mutex.get(), ctx_ptr) };
+
+            if ret == 0 {
+                return Err(EBUSY);
+            } else {
+                to_result(ret)?;
+            }
+        }
+    };
+
+    Ok(WwMutexGuard::new(ww_mutex))
+}
+
 /// Groups multiple mutex acquisitions together for deadlock avoidance.
 ///
 /// Must be used when acquiring multiple mutexes of the same class.
@@ -196,14 +265,9 @@ pub fn done(&self) {
         unsafe { bindings::ww_acquire_done(self.inner.get()) };
     }

-    /// Locks the given mutex.
+    /// Locks the given mutex on this acquire context ([`WwAcquireCtx`]).
     pub fn lock<'a, T>(&'a self, ww_mutex: &'a WwMutex<'a, T>) -> Result<WwMutexGuard<'a, T>> {
-        // SAFETY: The mutex is pinned and valid.
-        let ret = unsafe { bindings::ww_mutex_lock(ww_mutex.mutex.get(), self.inner.get()) };
-
-        to_result(ret)?;
-
-        Ok(WwMutexGuard::new(ww_mutex))
+        lock_common(ww_mutex, Some(self), LockKind::Regular)
     }

     /// Similar to `lock`, but can be interrupted by signals.
@@ -211,24 +275,14 @@ pub fn lock_interruptible<'a, T>(
         &'a self,
         ww_mutex: &'a WwMutex<'a, T>,
     ) -> Result<WwMutexGuard<'a, T>> {
-        // SAFETY: The mutex is pinned and valid.
-        let ret = unsafe {
-            bindings::ww_mutex_lock_interruptible(ww_mutex.mutex.get(), self.inner.get())
-        };
-
-        to_result(ret)?;
-
-        Ok(WwMutexGuard::new(ww_mutex))
+        lock_common(ww_mutex, Some(self), LockKind::Interruptible)
     }

-    /// Locks the given mutex using the slow path.
+    /// Locks the given mutex on this acquire context ([`WwAcquireCtx`]) using the slow path.
     ///
     /// This function should be used when `lock` fails (typically due to a potential deadlock).
     pub fn lock_slow<'a, T>(&'a self, ww_mutex: &'a WwMutex<'a, T>) -> Result<WwMutexGuard<'a, T>> {
-        // SAFETY: The mutex is pinned and valid, and we're in the slow path.
-        unsafe { bindings::ww_mutex_lock_slow(ww_mutex.mutex.get(), self.inner.get()) };
-
-        Ok(WwMutexGuard::new(ww_mutex))
+        lock_common(ww_mutex, Some(self), LockKind::Slow)
     }

     /// Similar to `lock_slow`, but can be interrupted by signals.
@@ -236,30 +290,14 @@ pub fn lock_slow_interruptible<'a, T>(
         &'a self,
         ww_mutex: &'a WwMutex<'a, T>,
     ) -> Result<WwMutexGuard<'a, T>> {
-        // SAFETY: The mutex is pinned and valid, and we are in the slow path.
-        let ret = unsafe {
-            bindings::ww_mutex_lock_slow_interruptible(ww_mutex.mutex.get(), self.inner.get())
-        };
-
-        to_result(ret)?;
-
-        Ok(WwMutexGuard::new(ww_mutex))
+        lock_common(ww_mutex, Some(self), LockKind::SlowInterruptible)
     }

-    /// Tries to lock the mutex without blocking.
+    /// Tries to lock the mutex on this acquire context ([`WwAcquireCtx`]) without blocking.
     ///
     /// Unlike `lock`, no deadlock handling is performed.
     pub fn try_lock<'a, T>(&'a self, ww_mutex: &'a WwMutex<'a, T>) -> Result<WwMutexGuard<'a, T>> {
-        // SAFETY: The mutex is pinned and valid.
-        let ret = unsafe { bindings::ww_mutex_trylock(ww_mutex.mutex.get(), self.inner.get()) };
-
-        if ret == 0 {
-            return Err(EBUSY);
-        } else {
-            to_result(ret)?;
-        }
-
-        Ok(WwMutexGuard::new(ww_mutex))
+        lock_common(ww_mutex, Some(self), LockKind::Try)
     }
 }

@@ -355,7 +393,7 @@ pub fn new(t: T, ww_class: &'ww_class WwClass) -> impl PinInit<Self> {
     }
 }

-impl<T: ?Sized> WwMutex<'_, T> {
+impl<'ww_class, T: ?Sized> WwMutex<'ww_class, T> {
     /// Returns a raw pointer to the inner mutex.
     fn as_ptr(&self) -> *mut bindings::ww_mutex {
         self.mutex.get()
@@ -370,6 +408,35 @@ fn is_locked(&self) -> bool {
         // SAFETY: The mutex is pinned and valid.
         unsafe { bindings::ww_mutex_is_locked(self.mutex.get()) }
     }
+
+    /// Locks the given mutex without acquire context ([`WwAcquireCtx`]).
+    pub fn lock<'a>(&'a self) -> Result<WwMutexGuard<'a, T>> {
+        lock_common(self, None, LockKind::Regular)
+    }
+
+    /// Similar to `lock`, but can be interrupted by signals.
+    pub fn lock_interruptible<'a>(&'a self) -> Result<WwMutexGuard<'a, T>> {
+        lock_common(self, None, LockKind::Interruptible)
+    }
+
+    /// Locks the given mutex without acquire context ([`WwAcquireCtx`]) using the slow path.
+    ///
+    /// This function should be used when `lock` fails (typically due to a potential deadlock).
+    pub fn lock_slow<'a>(&'a self) -> Result<WwMutexGuard<'a, T>> {
+        lock_common(self, None, LockKind::Slow)
+    }
+
+    /// Similar to `lock_slow`, but can be interrupted by signals.
+    pub fn lock_slow_interruptible<'a>(&'a self) -> Result<WwMutexGuard<'a, T>> {
+        lock_common(self, None, LockKind::SlowInterruptible)
+    }
+
+    /// Tries to lock the mutex without acquire context ([`WwAcquireCtx`]) and without blocking.
+    ///
+    /// Unlike `lock`, no deadlock handling is performed.
+    pub fn try_lock<'a>(&'a self) -> Result<WwMutexGuard<'a, T>> {
+        lock_common(self, None, LockKind::Try)
+    }
 }

 /// A guard that provides exclusive access to the data protected
@@ -547,4 +614,19 @@ fn test_with_global_classes() -> Result {

         Ok(())
     }
+
+    #[test]
+    fn test_mutex_without_ctx() -> Result {
+        let mutex = Arc::pin_init(WwMutex::new(100, &TEST_WOUND_WAIT_CLASS), GFP_KERNEL)?;
+        let guard = mutex.lock()?;
+
+        assert_eq!(*guard, 100);
+        assert!(mutex.is_locked());
+
+        drop(guard);
+
+        assert!(!mutex.is_locked());
+
+        Ok(())
+    }
 }
--
2.50.0


