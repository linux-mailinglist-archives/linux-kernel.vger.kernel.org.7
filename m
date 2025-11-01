Return-Path: <linux-kernel+bounces-881405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A3FC2824B
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 17:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86BA13AA2ED
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 16:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038792FD1D9;
	Sat,  1 Nov 2025 16:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="HO+i7eBO"
Received: from forward100d.mail.yandex.net (forward100d.mail.yandex.net [178.154.239.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14C02E6CA8;
	Sat,  1 Nov 2025 16:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762013489; cv=none; b=FLX1pQhFvf9uBdm3o2SgeFNP3dAbyvYnukxPE2bLQxUXinhdPFAdMggTwuUrWOjmTcpTonqqiPFFF7VCzulI342GOiz02WGTUp2I8L34OEUd0nOvF8fTQnN0pY0aLmixT/1BRXxMFRHUmkBIk9c2SsbfUN8He8Or1Y5ADEs6Ndc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762013489; c=relaxed/simple;
	bh=Knwxuci/X+GhWYa24wgFnzbOEjJvzPD64yA+A2FQd+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gye4qiAMflEJeSGTExeCmTshajyvaalJDbjwxEHUnhORJ9k0vWyEeVTJz0mdXdbIPpPMmrgP04hr9bqWTJd/74mvPSkz+hQiX4tBeFd3zpK4tTDP3GNCu5djK1nqLKHYsmgjHCG6A7IuaxLt3n/8IJZNXLEAQtlA3iIiFjHAOlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=HO+i7eBO; arc=none smtp.client-ip=178.154.239.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:d7c6:0:640:5e67:0])
	by forward100d.mail.yandex.net (Yandex) with ESMTPS id 132C5C0031;
	Sat, 01 Nov 2025 19:11:24 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id wAkixRhLDOs0-PWpMpCYg;
	Sat, 01 Nov 2025 19:11:23 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1762013483;
	bh=AXzltMKi+uQ4kaGjizVoMVhSCSVN1iyKFtehXj1aQCI=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=HO+i7eBOWFMLoxsIaCuz7DHVQDpe0lKb3HDC2qruW2vaE7zVzGxhvVPk4SaEe8TvL
	 +rDEblrvljqLMEL4JRn1qllwQj/v7rdNATirY8s5noPifSEXvNVpJOJ2OVZa2Svn1r
	 GvHyFz6HK0OlveyBSBi10iVojLqEuHAUBDaN7HPg=
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
Subject: [PATCH v7 6/6] rust: add test coverage for ww_mutex implementation
Date: Sat,  1 Nov 2025 19:10:56 +0300
Message-ID: <20251101161056.22408-7-work@onurozkan.dev>
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

Adds test coverage on the core ww_mutex functionality.

Signed-off-by: Onur Özkan <work@onurozkan.dev>
---
 rust/kernel/sync/lock/ww_mutex.rs          | 151 +++++++++++++++++++
 rust/kernel/sync/lock/ww_mutex/lock_set.rs | 165 +++++++++++++++++++++
 2 files changed, 316 insertions(+)

diff --git a/rust/kernel/sync/lock/ww_mutex.rs b/rust/kernel/sync/lock/ww_mutex.rs
index d4c3b272912d..cf4872bd258e 100644
--- a/rust/kernel/sync/lock/ww_mutex.rs
+++ b/rust/kernel/sync/lock/ww_mutex.rs
@@ -287,3 +287,154 @@ unsafe fn lock_common<'a, T: ?Sized>(
 
     Ok(MutexGuard::new(mutex))
 }
+
+#[kunit_tests(rust_kernel_ww_mutex)]
+mod tests {
+    use crate::prelude::*;
+    use crate::sync::Arc;
+    use crate::{c_str, define_class};
+    use pin_init::stack_pin_init;
+
+    use super::*;
+
+    // A simple coverage on `define_class` macro.
+    define_class!(TEST_WOUND_WAIT_CLASS, wound_wait, c_str!("test"));
+    define_class!(TEST_WAIT_DIE_CLASS, wait_die, c_str!("test"));
+
+    #[test]
+    fn test_ww_mutex_basic_lock_unlock() -> Result {
+        stack_pin_init!(let class = Class::new_wound_wait(c_str!("test")));
+
+        let mutex = Arc::pin_init(Mutex::new(42, &class), GFP_KERNEL)?;
+
+        let ctx = KBox::pin_init(AcquireCtx::new(&class), GFP_KERNEL)?;
+
+        // SAFETY: Both `ctx` and `mutex` uses the same class.
+        let guard = unsafe { ctx.lock(&mutex)? };
+        assert_eq!(*guard, 42);
+
+        // Drop the lock.
+        drop(guard);
+
+        // SAFETY: Both `ctx` and `mutex` uses the same class.
+        let mut guard = unsafe { ctx.lock(&mutex)? };
+        *guard = 100;
+        assert_eq!(*guard, 100);
+
+        Ok(())
+    }
+
+    #[test]
+    fn test_ww_mutex_trylock() -> Result {
+        stack_pin_init!(let class = Class::new_wound_wait(c_str!("test")));
+
+        let mutex = Arc::pin_init(Mutex::new(123, &class), GFP_KERNEL)?;
+
+        let ctx = KBox::pin_init(AcquireCtx::new(&class), GFP_KERNEL)?;
+
+        // `try_lock` on unlocked mutex should succeed.
+        // SAFETY: Both `ctx` and `mutex` uses the same class.
+        let guard = unsafe { ctx.try_lock(&mutex)? };
+        assert_eq!(*guard, 123);
+
+        // Now it should fail immediately as it's already locked.
+        // SAFETY: Both `ctx` and `mutex` uses the same class.
+        assert!(unsafe { ctx.try_lock(&mutex).is_err() });
+
+        Ok(())
+    }
+
+    #[test]
+    fn test_ww_mutex_is_locked() -> Result {
+        stack_pin_init!(let class = Class::new_wait_die(c_str!("test")));
+
+        let mutex = Arc::pin_init(Mutex::new("hello", &class), GFP_KERNEL)?;
+
+        let ctx = KBox::pin_init(AcquireCtx::new(&class), GFP_KERNEL)?;
+
+        // Should not be locked initially.
+        assert!(!mutex.is_locked());
+
+        // SAFETY: Both `ctx` and `mutex` uses the same class.
+        let guard = unsafe { ctx.lock(&mutex)? };
+        assert!(mutex.is_locked());
+
+        drop(guard);
+        assert!(!mutex.is_locked());
+
+        Ok(())
+    }
+
+    #[test]
+    fn test_ww_acquire_context_done() -> Result {
+        stack_pin_init!(let class = Class::new_wound_wait(c_str!("test")));
+
+        let mutex1 = Arc::pin_init(Mutex::new(1, &class), GFP_KERNEL)?;
+        let mutex2 = Arc::pin_init(Mutex::new(2, &class), GFP_KERNEL)?;
+
+        let ctx = KBox::pin_init(AcquireCtx::new(&class), GFP_KERNEL)?;
+
+        // Acquire multiple mutexes with the same context.
+        // SAFETY: Both `ctx` and `mutex1` uses the same class.
+        let guard1 = unsafe { ctx.lock(&mutex1)? };
+        // SAFETY: Both `ctx` and `mutex2` uses the same class.
+        let guard2 = unsafe { ctx.lock(&mutex2)? };
+
+        assert_eq!(*guard1, 1);
+        assert_eq!(*guard2, 2);
+
+        // SAFETY: It's called exactly once here and nowhere else.
+        unsafe { ctx.done() };
+
+        // We shouldn't be able to lock once it's `done`.
+        // SAFETY: Both `ctx` and `mutex1` uses the same class.
+        assert!(unsafe { ctx.lock(&mutex1).is_err() });
+        // SAFETY: Both `ctx` and `mutex2` uses the same class.
+        assert!(unsafe { ctx.lock(&mutex2).is_err() });
+
+        Ok(())
+    }
+
+    #[test]
+    fn test_with_global_classes() -> Result {
+        let mutex1 = Arc::pin_init(Mutex::new(100, &TEST_WOUND_WAIT_CLASS), GFP_KERNEL)?;
+        let mutex2 = Arc::pin_init(Mutex::new(200, &TEST_WAIT_DIE_CLASS), GFP_KERNEL)?;
+
+        let ww_ctx = KBox::pin_init(AcquireCtx::new(&TEST_WOUND_WAIT_CLASS), GFP_KERNEL)?;
+        let wd_ctx = KBox::pin_init(AcquireCtx::new(&TEST_WAIT_DIE_CLASS), GFP_KERNEL)?;
+
+        // SAFETY: Both `ww_ctx` and `mutex1` uses the same class.
+        let ww_guard = unsafe { ww_ctx.lock(&mutex1)? };
+        // SAFETY: Both `wd_ctx` and `mutex2` uses the same class.
+        let wd_guard = unsafe { wd_ctx.lock(&mutex2)? };
+
+        assert_eq!(*ww_guard, 100);
+        assert_eq!(*wd_guard, 200);
+
+        assert!(mutex1.is_locked());
+        assert!(mutex2.is_locked());
+
+        drop(ww_guard);
+        drop(wd_guard);
+
+        assert!(!mutex1.is_locked());
+        assert!(!mutex2.is_locked());
+
+        Ok(())
+    }
+
+    #[test]
+    fn test_mutex_without_ctx() -> Result {
+        let mutex = Arc::pin_init(Mutex::new(100, &TEST_WOUND_WAIT_CLASS), GFP_KERNEL)?;
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
+}
diff --git a/rust/kernel/sync/lock/ww_mutex/lock_set.rs b/rust/kernel/sync/lock/ww_mutex/lock_set.rs
index ae234fd1e0be..f5800755fc6b 100644
--- a/rust/kernel/sync/lock/ww_mutex/lock_set.rs
+++ b/rust/kernel/sync/lock/ww_mutex/lock_set.rs
@@ -243,3 +243,168 @@ fn cleanup_on_deadlock(&mut self) {
         unsafe { self.acquire_ctx.as_mut().reinit(self.class) };
     }
 }
+
+#[kunit_tests(rust_kernel_lock_set)]
+mod tests {
+    use crate::c_str;
+    use crate::prelude::*;
+    use crate::sync::Arc;
+    use pin_init::stack_pin_init;
+
+    use super::*;
+
+    #[test]
+    fn test_lock_set_basic_lock_unlock() -> Result {
+        stack_pin_init!(let class = Class::new_wound_wait(c_str!("test")));
+
+        let mutex = Arc::pin_init(Mutex::new(10, &class), GFP_KERNEL)?;
+        let mut lock_set = KBox::pin_init(LockSet::new(&class)?, GFP_KERNEL)?;
+
+        // SAFETY: Both `lock_set` and `mutex` uses the same class.
+        unsafe { lock_set.lock(&mutex)? };
+
+        lock_set.with_locked(&mutex, |v| {
+            assert_eq!(*v, 10);
+        })?;
+
+        lock_set.release_all_locks();
+        assert!(!mutex.is_locked());
+
+        Ok(())
+    }
+
+    #[test]
+    fn test_lock_set_with_locked_mutates_data() -> Result {
+        stack_pin_init!(let class = Class::new_wound_wait(c_str!("test")));
+
+        let mutex = Arc::pin_init(Mutex::new(5, &class), GFP_KERNEL)?;
+        let mut lock_set = KBox::pin_init(LockSet::new(&class)?, GFP_KERNEL)?;
+
+        // SAFETY: Both `lock_set` and `mutex` uses the same class.
+        unsafe { lock_set.lock(&mutex)? };
+
+        lock_set.with_locked(&mutex, |v| {
+            assert_eq!(*v, 5);
+            // Increment the value.
+            *v += 7;
+        })?;
+
+        lock_set.with_locked(&mutex, |v| {
+            // Check that mutation took effect.
+            assert_eq!(*v, 12);
+        })?;
+
+        Ok(())
+    }
+
+    #[test]
+    fn test_lock_all_success() -> Result {
+        stack_pin_init!(let class = Class::new_wound_wait(c_str!("test")));
+
+        let mutex1 = Arc::pin_init(Mutex::new(1, &class), GFP_KERNEL)?;
+        let mutex2 = Arc::pin_init(Mutex::new(2, &class), GFP_KERNEL)?;
+        let mut lock_set = KBox::pin_init(LockSet::new(&class)?, GFP_KERNEL)?;
+
+        let res = lock_set.lock_all(
+            // `locking_algorithm` closure
+            |lock_set| {
+                // SAFETY: Both `lock_set` and `mutex1` uses the same class.
+                let _ = unsafe { lock_set.lock(&mutex1)? };
+
+                // SAFETY: Both `lock_set` and `mutex2` uses the same class.
+                let _ = unsafe { lock_set.lock(&mutex2)? };
+                Ok(())
+            },
+            // `on_all_locks_taken` closure
+            |lock_set| {
+                lock_set.with_locked(&mutex1, |v| *v += 10)?;
+                lock_set.with_locked(&mutex2, |v| *v += 20)?;
+                Ok((
+                    lock_set.with_locked(&mutex1, |v| *v)?,
+                    lock_set.with_locked(&mutex2, |v| *v)?,
+                ))
+            },
+        )?;
+
+        assert_eq!(res, (11, 22));
+        assert!(!mutex1.is_locked());
+        assert!(!mutex2.is_locked());
+
+        Ok(())
+    }
+
+    #[test]
+    fn test_with_different_input_type() -> Result {
+        stack_pin_init!(let class = Class::new_wound_wait(c_str!("test")));
+
+        let mutex1 = Arc::pin_init(Mutex::new(1, &class), GFP_KERNEL)?;
+        let mutex2 = Arc::pin_init(Mutex::new("hello", &class), GFP_KERNEL)?;
+        let mut lock_set = KBox::pin_init(LockSet::new(&class)?, GFP_KERNEL)?;
+
+        lock_set.lock_all(
+            // `locking_algorithm` closure
+            |lock_set| {
+                // SAFETY: Both `lock_set` and `mutex1` uses the same class.
+                unsafe { lock_set.lock(&mutex1)? };
+
+                // SAFETY: Both `lock_set` and `mutex2` uses the same class.
+                unsafe { lock_set.lock(&mutex2)? };
+
+                Ok(())
+            },
+            // `on_all_locks_taken` closure
+            |lock_set| {
+                lock_set.with_locked(&mutex1, |v| assert_eq!(*v, 1))?;
+                lock_set.with_locked(&mutex2, |v| assert_eq!(*v, "hello"))?;
+                Ok(())
+            },
+        )?;
+
+        Ok(())
+    }
+
+    #[test]
+    fn test_lock_all_retries_on_deadlock() -> Result {
+        stack_pin_init!(let class = Class::new_wound_wait(c_str!("test")));
+
+        let mutex = Arc::pin_init(Mutex::new(99, &class), GFP_KERNEL)?;
+        let mut lock_set = KBox::pin_init(LockSet::new(&class)?, GFP_KERNEL)?;
+        let mut first_try = true;
+
+        let res = lock_set.lock_all(
+            // `locking_algorithm` closure
+            |lock_set| {
+                if first_try {
+                    first_try = false;
+                    // Simulate deadlock on first attempt.
+                    return Err(EDEADLK);
+                }
+                // SAFETY: Both `lock_set` and `mutex` uses the same class.
+                unsafe { lock_set.lock(&mutex) }
+            },
+            // `on_all_locks_taken` closure
+            |lock_set| {
+                lock_set.with_locked(&mutex, |v| {
+                    *v += 1;
+                    *v
+                })
+            },
+        )?;
+
+        assert_eq!(res, 100);
+        Ok(())
+    }
+
+    #[test]
+    fn test_with_locked_on_unlocked_mutex() -> Result {
+        stack_pin_init!(let class = Class::new_wound_wait(c_str!("test")));
+
+        let mutex = Arc::pin_init(Mutex::new(5, &class), GFP_KERNEL)?;
+        let mut lock_set = KBox::pin_init(LockSet::new(&class)?, GFP_KERNEL)?;
+
+        let ecode = lock_set.with_locked(&mutex, |_v| {}).unwrap_err();
+        assert_eq!(EINVAL, ecode);
+
+        Ok(())
+    }
+}
-- 
2.51.2


