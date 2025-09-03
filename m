Return-Path: <linux-kernel+bounces-798650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB551B420BC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7F5A1BA393F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD193019D1;
	Wed,  3 Sep 2025 13:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="j9k+F5O+"
Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net [178.154.239.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CE43054D2;
	Wed,  3 Sep 2025 13:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756905249; cv=none; b=HKQp9tGhri2FAZhrWCHwRkbvl6UFxOg926Q7kZTgOUprMHem6mqWSAdpvbgGkHcZKa+zq9i8hXohhtOhCUIXXUb+obXBUixpNcrdT9XhwoMCVk+Vcvsxqhh5yIbNIwszI+Kbe2Tm4R0Wm0lg9JpbwQYKB7CXGcwDAk+R6avUsCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756905249; c=relaxed/simple;
	bh=WDgi77rHJ3KjGrxK8G5crmuDAGRMwJ1W8jArU1YRac4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IiOtkOGT0lL4O4k5rg4aAdS78oyCtMOV5eQux7g2iNNk4tPfHGN0Q8jWv7hd5onR1yyL6vxrJA2eON78eMKuOb+lT1yKpyKIuSfw6zTLEX5QiyMZxOtSmdiJWmBYl7sDrQIB4veF7wbfNs4sN36C/hjSpxJcrE41wGlvVX0FoFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=j9k+F5O+; arc=none smtp.client-ip=178.154.239.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-60.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-60.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1d:3e17:0:640:f9aa:0])
	by forward101a.mail.yandex.net (Yandex) with ESMTPS id 915E580CEF;
	Wed, 03 Sep 2025 16:14:05 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-60.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id GDgKkBDMquQ0-8CpvrUK2;
	Wed, 03 Sep 2025 16:14:04 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1756905245;
	bh=56lL8HtTww3Qk1jXGegwX7g8StiwO1fPanZh6GQONiU=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=j9k+F5O+beFYhoRAki/f3yizs5o2e7BCmYVntWmTYKExb1XKPc5t16vuY7Y0w6fRU
	 n47MiqlBwLILyyvNnrOQZ+OV4PiZPel/RmeOjLvyNR3pnrGgpVuodwreaUhBgMGguR
	 og6xYNDFANhjwzrP3KIc+dQUx/dtBQi85eaRZJIo=
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
Subject: [PATCH v6 7/7] add KUnit coverage on ww_mutex/exec implementation
Date: Wed,  3 Sep 2025 16:13:13 +0300
Message-ID: <20250903131313.4365-8-work@onurozkan.dev>
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

Adds coverage for `ww_mutex/exec.rs` implementation.

Signed-off-by: Onur Özkan <work@onurozkan.dev>
---
 rust/kernel/sync/lock/ww_mutex/exec.rs | 148 +++++++++++++++++++++++++
 1 file changed, 148 insertions(+)

diff --git a/rust/kernel/sync/lock/ww_mutex/exec.rs b/rust/kernel/sync/lock/ww_mutex/exec.rs
index 2f1fc540f0b8..543c5218232a 100644
--- a/rust/kernel/sync/lock/ww_mutex/exec.rs
+++ b/rust/kernel/sync/lock/ww_mutex/exec.rs
@@ -174,3 +174,151 @@ fn cleanup_on_deadlock(&mut self) -> Result {
         Ok(())
     }
 }
+
+#[kunit_tests(rust_kernel_ww_exec)]
+mod tests {
+    use crate::c_str;
+    use crate::prelude::*;
+    use crate::sync::Arc;
+    use pin_init::stack_pin_init;
+
+    use super::*;
+
+    #[test]
+    fn test_exec_context_basic_lock_unlock() -> Result {
+        stack_pin_init!(let class = WwClass::new_wound_wait(c_str!("exec_ctx_basic")));
+
+        let mutex = Arc::pin_init(WwMutex::new(10, &class), GFP_KERNEL)?;
+        let mut ctx = KBox::pin_init(ExecContext::new(&class)?, GFP_KERNEL)?;
+
+        ctx.lock(&mutex)?;
+        ctx.with_locked(&mutex, |v| {
+            assert_eq!(*v, 10);
+        })?;
+
+        ctx.release_all_locks();
+        assert!(!mutex.is_locked());
+
+        Ok(())
+    }
+
+    #[test]
+    fn test_exec_context_with_locked_mutates_data() -> Result {
+        stack_pin_init!(let class = WwClass::new_wound_wait(c_str!("exec_ctx_with_locked")));
+
+        let mutex = Arc::pin_init(WwMutex::new(5, &class), GFP_KERNEL)?;
+        let mut ctx = KBox::pin_init(ExecContext::new(&class)?, GFP_KERNEL)?;
+
+        ctx.lock(&mutex)?;
+
+        ctx.with_locked(&mutex, |v| {
+            assert_eq!(*v, 5);
+            // Increment the value.
+            *v += 7;
+        })?;
+
+        ctx.with_locked(&mutex, |v| {
+            // Check that mutation took effect.
+            assert_eq!(*v, 12);
+        })?;
+
+        Ok(())
+    }
+
+    #[test]
+    fn test_lock_all_success() -> Result {
+        stack_pin_init!(let class = WwClass::new_wound_wait(c_str!("lock_all_ok")));
+
+        let mutex1 = Arc::pin_init(WwMutex::new(1, &class), GFP_KERNEL)?;
+        let mutex2 = Arc::pin_init(WwMutex::new(2, &class), GFP_KERNEL)?;
+        let mut ctx = KBox::pin_init(ExecContext::new(&class)?, GFP_KERNEL)?;
+
+        let res = ctx.lock_all(
+            |ctx| {
+                let _ = ctx.lock(&mutex1)?;
+                let _ = ctx.lock(&mutex2)?;
+                Ok(())
+            },
+            |ctx| {
+                ctx.with_locked(&mutex1, |v| *v += 10)?;
+                ctx.with_locked(&mutex2, |v| *v += 20)?;
+                Ok((
+                    ctx.with_locked(&mutex1, |v| *v)?,
+                    ctx.with_locked(&mutex2, |v| *v)?,
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
+        stack_pin_init!(let class = WwClass::new_wound_wait(c_str!("lock_all_ok")));
+
+        let mutex1 = Arc::pin_init(WwMutex::new(1, &class), GFP_KERNEL)?;
+        let mutex2 = Arc::pin_init(WwMutex::new("hello", &class), GFP_KERNEL)?;
+        let mut ctx = KBox::pin_init(ExecContext::new(&class)?, GFP_KERNEL)?;
+
+        ctx.lock_all(
+            |ctx| {
+                ctx.lock(&mutex1)?;
+                ctx.lock(&mutex2)?;
+                Ok(())
+            },
+            |ctx| {
+                ctx.with_locked(&mutex1, |v| assert_eq!(*v, 1))?;
+                ctx.with_locked(&mutex2, |v| assert_eq!(*v, "hello"))?;
+                Ok(())
+            },
+        )?;
+
+        Ok(())
+    }
+
+    #[test]
+    fn test_lock_all_retries_on_deadlock() -> Result {
+        stack_pin_init!(let class = WwClass::new_wound_wait(c_str!("lock_all_retry")));
+
+        let mutex = Arc::pin_init(WwMutex::new(99, &class), GFP_KERNEL)?;
+        let mut ctx = KBox::pin_init(ExecContext::new(&class)?, GFP_KERNEL)?;
+        let mut first_try = true;
+
+        let res = ctx.lock_all(
+            |ctx| {
+                if first_try {
+                    first_try = false;
+                    // Simulate deadlock on first attempt.
+                    return Err(EDEADLK);
+                }
+                ctx.lock(&mutex)
+            },
+            |ctx| {
+                ctx.with_locked(&mutex, |v| {
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
+        stack_pin_init!(let class = WwClass::new_wound_wait(c_str!("with_unlocked_mutex")));
+
+        let mutex = Arc::pin_init(WwMutex::new(5, &class), GFP_KERNEL)?;
+        let mut ctx = KBox::pin_init(ExecContext::new(&class)?, GFP_KERNEL)?;
+
+        let ecode = ctx.with_locked(&mutex, |_v| {}).unwrap_err();
+        assert_eq!(EINVAL, ecode);
+
+        Ok(())
+    }
+}
--
2.50.0


