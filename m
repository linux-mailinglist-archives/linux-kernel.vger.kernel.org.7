Return-Path: <linux-kernel+bounces-798648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D18F9B420B5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A807D5E401C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195A23009E4;
	Wed,  3 Sep 2025 13:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="gdFb9T+g"
Received: from forward206a.mail.yandex.net (forward206a.mail.yandex.net [178.154.239.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43D32ED84F;
	Wed,  3 Sep 2025 13:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756905243; cv=none; b=O0egUAcNxb054Arapa5jaKekUPMgLPduKjjb39WPNaOpc3RC6RMa8sEPTBMaai83UbOldeTxpQ3LR+6p3xuu7wy8T6/0cVH29WoGWuOHQFsMMMODTHnStUB8EHVk9E/gbmj0F0oGz8Vc/oJ7kVfzTg1tjoAxICOOK+bVv9Mw1SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756905243; c=relaxed/simple;
	bh=roSDQADUv3RkSm0N6OGbYxrmyfPumK04X12VD6UR6xs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pYdTcR6DnebB7PWrhASjxjKhqyW7EEhQir+7RhyJfOWVDxVZAI4ZoQHjBiK0VUsCpvLPV1Iz9xTgQ7lhWWBTr2tlwJzuSn/oR8drxAaqD1aRKJAuuHK14Yng+PCai6u8DTXTu7d8IwFBrbjrfcdrTjVOV8oyyCerG75d+RfU7SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=gdFb9T+g; arc=none smtp.client-ip=178.154.239.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d101])
	by forward206a.mail.yandex.net (Yandex) with ESMTPS id AC46F81418;
	Wed, 03 Sep 2025 16:13:58 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-60.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-60.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1d:3e17:0:640:f9aa:0])
	by forward101a.mail.yandex.net (Yandex) with ESMTPS id 5F97280CBD;
	Wed, 03 Sep 2025 16:13:51 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-60.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id GDgKkBDMquQ0-qWxoUOlp;
	Wed, 03 Sep 2025 16:13:50 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1756905230;
	bh=Hia1mfGHTnbizHC76TE+aNhM8CV8JljuaRKoDPy92gY=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=gdFb9T+gfHkHybRLuFgIyx+F3Ea1fFRNx6lL6SOykb0joH3XUWzkjHzoiokt22mWJ
	 tpeG+OQ+TGpUP0KgM/3jzC1b+1XoHJThpzmMfmjYh9GWYKbLkftA04rMe78534XaCF
	 QDGXl2vyB5PaXLNeBg2bmNySYjsqZE7u4jDs1oAU=
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
Subject: [PATCH v6 4/7] add KUnit coverage on Rust ww_mutex implementation
Date: Wed,  3 Sep 2025 16:13:10 +0300
Message-ID: <20250903131313.4365-5-work@onurozkan.dev>
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

Adds coverage around the core `ww_mutex` functionality

Signed-off-by: Onur Özkan <work@onurozkan.dev>
---
 rust/kernel/sync/lock/ww_mutex.rs | 127 ++++++++++++++++++++++++++++++
 1 file changed, 127 insertions(+)

diff --git a/rust/kernel/sync/lock/ww_mutex.rs b/rust/kernel/sync/lock/ww_mutex.rs
index 314360632953..d289718d2c98 100644
--- a/rust/kernel/sync/lock/ww_mutex.rs
+++ b/rust/kernel/sync/lock/ww_mutex.rs
@@ -421,3 +421,130 @@ fn drop(&mut self) {
         unsafe { bindings::ww_mutex_unlock(self.mutex.as_ptr()) };
     }
 }
+
+#[kunit_tests(rust_kernel_ww_mutex)]
+mod tests {
+    use crate::c_str;
+    use crate::prelude::*;
+    use crate::sync::Arc;
+    use pin_init::stack_pin_init;
+
+    use super::*;
+
+    // A simple coverage on `define_ww_class` macro.
+    define_ww_class!(TEST_WOUND_WAIT_CLASS, wound_wait, c_str!("test_wound_wait"));
+    define_ww_class!(TEST_WAIT_DIE_CLASS, wait_die, c_str!("test_wait_die"));
+
+    #[test]
+    fn test_ww_mutex_basic_lock_unlock() -> Result {
+        stack_pin_init!(let class = WwClass::new_wound_wait(c_str!("test_mutex_class")));
+
+        let mutex = Arc::pin_init(WwMutex::new(42, &class), GFP_KERNEL)?;
+
+        let ctx = KBox::pin_init(WwAcquireCtx::new(&class), GFP_KERNEL)?;
+
+        // Lock.
+        let guard = ctx.lock(&mutex)?;
+        assert_eq!(*guard, 42);
+
+        // Drop the lock.
+        drop(guard);
+
+        // Lock it again.
+        let mut guard = ctx.lock(&mutex)?;
+        *guard = 100;
+        assert_eq!(*guard, 100);
+
+        Ok(())
+    }
+
+    #[test]
+    fn test_ww_mutex_trylock() -> Result {
+        stack_pin_init!(let class = WwClass::new_wound_wait(c_str!("trylock_class")));
+
+        let mutex = Arc::pin_init(WwMutex::new(123, &class), GFP_KERNEL)?;
+
+        let ctx = KBox::pin_init(WwAcquireCtx::new(&class), GFP_KERNEL)?;
+
+        // `try_lock` on unlocked mutex should succeed.
+        let guard = ctx.try_lock(&mutex)?;
+        assert_eq!(*guard, 123);
+
+        // Now it should fail immediately as it's already locked.
+        assert!(ctx.try_lock(&mutex).is_err());
+
+        Ok(())
+    }
+
+    #[test]
+    fn test_ww_mutex_is_locked() -> Result {
+        stack_pin_init!(let class = WwClass::new_wait_die(c_str!("locked_check_class")));
+
+        let mutex = Arc::pin_init(WwMutex::new("hello", &class), GFP_KERNEL)?;
+
+        let ctx = KBox::pin_init(WwAcquireCtx::new(&class), GFP_KERNEL)?;
+
+        // Should not be locked initially.
+        assert!(!mutex.is_locked());
+
+        let guard = ctx.lock(&mutex)?;
+        assert!(mutex.is_locked());
+
+        drop(guard);
+        assert!(!mutex.is_locked());
+
+        Ok(())
+    }
+
+    #[test]
+    fn test_ww_acquire_context() -> Result {
+        stack_pin_init!(let class = WwClass::new_wound_wait(c_str!("ctx_class")));
+
+        let mutex1 = Arc::pin_init(WwMutex::new(1, &class), GFP_KERNEL)?;
+        let mutex2 = Arc::pin_init(WwMutex::new(2, &class), GFP_KERNEL)?;
+
+        let ctx = KBox::pin_init(WwAcquireCtx::new(&class), GFP_KERNEL)?;
+
+        // Acquire multiple mutexes with the same context.
+        let guard1 = ctx.lock(&mutex1)?;
+        let guard2 = ctx.lock(&mutex2)?;
+
+        assert_eq!(*guard1, 1);
+        assert_eq!(*guard2, 2);
+
+        ctx.done();
+
+        // We shouldn't be able to lock once it's `done`.
+        assert!(ctx.lock(&mutex1).is_err());
+        assert!(ctx.lock(&mutex2).is_err());
+
+        Ok(())
+    }
+
+    #[test]
+    fn test_with_global_classes() -> Result {
+        let wound_wait_mutex =
+            Arc::pin_init(WwMutex::new(100, &TEST_WOUND_WAIT_CLASS), GFP_KERNEL)?;
+        let wait_die_mutex = Arc::pin_init(WwMutex::new(200, &TEST_WAIT_DIE_CLASS), GFP_KERNEL)?;
+
+        let ww_ctx = KBox::pin_init(WwAcquireCtx::new(&TEST_WOUND_WAIT_CLASS), GFP_KERNEL)?;
+        let wd_ctx = KBox::pin_init(WwAcquireCtx::new(&TEST_WAIT_DIE_CLASS), GFP_KERNEL)?;
+
+        let ww_guard = ww_ctx.lock(&wound_wait_mutex)?;
+        let wd_guard = wd_ctx.lock(&wait_die_mutex)?;
+
+        assert_eq!(*ww_guard, 100);
+        assert_eq!(*wd_guard, 200);
+
+        assert!(wound_wait_mutex.is_locked());
+        assert!(wait_die_mutex.is_locked());
+
+        drop(ww_guard);
+        drop(wd_guard);
+
+        assert!(!wound_wait_mutex.is_locked());
+        assert!(!wait_die_mutex.is_locked());
+
+        Ok(())
+    }
+}
--
2.50.0


