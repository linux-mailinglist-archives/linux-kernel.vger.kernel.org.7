Return-Path: <linux-kernel+bounces-881401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABFCC28232
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 17:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2BC23B1352
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 16:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3602FB087;
	Sat,  1 Nov 2025 16:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="mlDvymYV"
Received: from forward103d.mail.yandex.net (forward103d.mail.yandex.net [178.154.239.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE53C22172E;
	Sat,  1 Nov 2025 16:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762013478; cv=none; b=pbAkvzjBbkWunWnB/4qWhBEttUgBJLZjlNQvnheQMUVlbUmBPXGCvza7yvuU3efmaFr0waP/OmXvXb5E+B53wlsCDNcPzl/8FT5gCDzcyV38+Pwpl472vpTrRK7czwUCRl2r0RKwanWO54yCBXilwaqhWitoYQXAZUODrvcn3qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762013478; c=relaxed/simple;
	bh=g/y0VSXvPRU/zyilBUexl1Kwo2HCQ6otTjPXzT6Httw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eBODfkAMW6/BrIhH8s+0gKz0txCVo1aWfpAidCsuzN2BE13NrM1Nbd2EaZ2bItYHULlFeV0lZj0uhEX1Ikm4t+74kELmda2TQUrr71ItKI9seTAGZaWIW1AJCTJYT4UI6DlnxPnvhQ4hiKiBZ/CJO66gBkwFPFR0graUSoemtpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=mlDvymYV; arc=none smtp.client-ip=178.154.239.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:d7c6:0:640:5e67:0])
	by forward103d.mail.yandex.net (Yandex) with ESMTPS id D9FBDC00CE;
	Sat, 01 Nov 2025 19:11:11 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id wAkixRhLDOs0-fEWxwdXz;
	Sat, 01 Nov 2025 19:11:10 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1762013471;
	bh=87A9u2bi5X8AtzknDv82nR70wZ9vXkMZioJ4Ntio0pA=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=mlDvymYV07haU9HEi3nU1x8vnvzL7Bapg14LGeU5itu42Rwu1va23O45zARZeDADh
	 dgYXvTmxNrKJ6b9Y/QLzd/sZx68unKGWGqM5gVpQxQHpGBlHynPXDVFApmg1tK0JtX
	 EQ3bUM9+tTrvuLzb4z2VVIykDPnczMu84TrQWWs8=
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
Subject: [PATCH v7 2/6] rust: implement `Class` for ww_class support
Date: Sat,  1 Nov 2025 19:10:52 +0300
Message-ID: <20251101161056.22408-3-work@onurozkan.dev>
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

Adds the `Class` type, the first step in supporting
`ww_mutex` in Rust. `Class` represents ww_class, used
for deadlock avoidance for supporting both wait-die
and wound-wait semantics.

Also adds the `define_class!` macro for safely declaring
static instances.

Signed-off-by: Onur Özkan <work@onurozkan.dev>
---
 rust/kernel/sync/lock.rs                |   1 +
 rust/kernel/sync/lock/ww_mutex.rs       |   7 ++
 rust/kernel/sync/lock/ww_mutex/class.rs | 156 ++++++++++++++++++++++++
 3 files changed, 164 insertions(+)
 create mode 100644 rust/kernel/sync/lock/ww_mutex.rs
 create mode 100644 rust/kernel/sync/lock/ww_mutex/class.rs

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index 27202beef90c..5b320c2b28c1 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -15,6 +15,7 @@
 
 pub mod mutex;
 pub mod spinlock;
+pub mod ww_mutex;
 
 pub(super) mod global;
 pub use global::{GlobalGuard, GlobalLock, GlobalLockBackend, GlobalLockedBy};
diff --git a/rust/kernel/sync/lock/ww_mutex.rs b/rust/kernel/sync/lock/ww_mutex.rs
new file mode 100644
index 000000000000..727c51cc73af
--- /dev/null
+++ b/rust/kernel/sync/lock/ww_mutex.rs
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust abstractions for the kernel's wound-wait locking primitives.
+
+pub use class::Class;
+
+mod class;
diff --git a/rust/kernel/sync/lock/ww_mutex/class.rs b/rust/kernel/sync/lock/ww_mutex/class.rs
new file mode 100644
index 000000000000..d10db5da01d2
--- /dev/null
+++ b/rust/kernel/sync/lock/ww_mutex/class.rs
@@ -0,0 +1,156 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Provides [`Class`] to group wound/wait mutexes to be acquired together
+//! and specifies which deadlock avoidance algorithm to use (e.g., wound-wait
+//! or wait-die).
+//!
+//! The [`define_class`] macro and [`Class::new_wait_die`]/[`Class::new_wound_wait`]
+//! constructors provide safe ways to create classes.
+
+use crate::bindings;
+use crate::prelude::*;
+use crate::types::Opaque;
+
+/// Creates static [`Class`] instances.
+///
+/// # Examples
+///
+/// ```
+/// use kernel::{c_str, define_class};
+///
+/// define_class!(WOUND_WAIT_GLOBAL_CLASS, wound_wait, c_str!("wound_wait_global_class"));
+/// define_class!(WAIT_DIE_GLOBAL_CLASS, wait_die, c_str!("wait_die_global_class"));
+/// ```
+#[macro_export]
+macro_rules! define_class {
+    ($name:ident, wound_wait, $class_name:expr) => {
+        static $name: $crate::sync::lock::ww_mutex::Class =
+            // SAFETY: This is `static`, so address is fixed and won't move.
+            unsafe { $crate::sync::lock::ww_mutex::Class::unpinned_new($class_name, false) };
+    };
+    ($name:ident, wait_die, $class_name:expr) => {
+        static $name: $crate::sync::lock::ww_mutex::Class =
+            // SAFETY: This is `static`, so address is fixed and won't move.
+            unsafe { $crate::sync::lock::ww_mutex::Class::unpinned_new($class_name, true) };
+    };
+}
+
+/// Used to group mutexes together for deadlock avoidance.
+///
+/// All mutexes that might be acquired together should use the same class.
+///
+/// # Examples
+///
+/// ```
+/// use kernel::sync::lock::ww_mutex::Class;
+/// use kernel::c_str;
+/// use pin_init::stack_pin_init;
+///
+/// stack_pin_init!(let _wait_die_class = Class::new_wait_die(c_str!("some_class")));
+/// stack_pin_init!(let _wound_wait_class = Class::new_wound_wait(c_str!("some_other_class")));
+///
+/// # Ok::<(), Error>(())
+/// ```
+#[pin_data]
+#[repr(transparent)]
+pub struct Class {
+    #[pin]
+    pub(super) inner: Opaque<bindings::ww_class>,
+}
+
+// SAFETY: [`Class`] is set up once and never modified. It's fine to share it across threads.
+unsafe impl Sync for Class {}
+// SAFETY: Doesn't hold anything thread-specific. It's safe to send to other threads.
+unsafe impl Send for Class {}
+
+impl Class {
+    /// Creates an unpinned [`Class`].
+    ///
+    /// # Safety
+    ///
+    /// Caller must guarantee that the returned value is not moved after creation.
+    pub const unsafe fn unpinned_new(name: &'static CStr, is_wait_die: bool) -> Self {
+        Class {
+            inner: Opaque::new(bindings::ww_class {
+                stamp: bindings::atomic_long_t { counter: 0 },
+                acquire_name: name.as_char_ptr(),
+                mutex_name: name.as_char_ptr(),
+                is_wait_die: is_wait_die as u32,
+                // TODO: Replace with `bindings::lock_class_key::default()` once
+                // stabilized for `const`.
+                //
+                // SAFETY: This is always zero-initialized when defined with
+                // `DEFINE_WD_CLASS` globally on C side.
+                //
+                // For reference, see __WW_CLASS_INITIALIZER() in
+                // "include/linux/ww_mutex.h".
+                acquire_key: unsafe { core::mem::zeroed() },
+                // TODO: Replace with `bindings::lock_class_key::default()` once
+                // stabilized for `const`.
+                //
+                // SAFETY: This is always zero-initialized when defined with
+                // `DEFINE_WD_CLASS` globally on C side.
+                //
+                // For reference, see __WW_CLASS_INITIALIZER() in
+                // "include/linux/ww_mutex.h".
+                mutex_key: unsafe { core::mem::zeroed() },
+            }),
+        }
+    }
+
+    /// Creates a [`Class`].
+    ///
+    /// You should not use this function directly. Use the [`define_class!`]
+    /// macro or call [`Class::new_wait_die`] or [`Class::new_wound_wait`] instead.
+    fn new(name: &'static CStr, is_wait_die: bool) -> impl PinInit<Self> {
+        pin_init! {
+            Self {
+                inner <- Opaque::ffi_init(|slot: *mut bindings::ww_class| {
+                    // SAFETY: The fields are being initialized. The `name` pointer is valid for a
+                    // static lifetime. The keys are zeroed, which is what the C side does.
+                    unsafe {
+                        slot.write(bindings::ww_class {
+                            stamp: bindings::atomic_long_t { counter: 0 },
+                            acquire_name: name.as_char_ptr(),
+                            mutex_name: name.as_char_ptr(),
+                            is_wait_die: is_wait_die.into(),
+                            // TODO: Replace with `bindings::lock_class_key::default()` once
+                            // stabilized for `const`.
+                            //
+                            // SAFETY: This is always zero-initialized when defined with
+                            // `DEFINE_WD_CLASS` globally on C side.
+                            //
+                            // For reference, see __WW_CLASS_INITIALIZER() in
+                            // "include/linux/ww_mutex.h".
+                            acquire_key: core::mem::zeroed(),
+                            mutex_key: core::mem::zeroed(),
+                        });
+                    }
+                }),
+            }
+        }
+    }
+
+    /// Creates wait-die [`Class`].
+    pub fn new_wait_die(name: &'static CStr) -> impl PinInit<Self> {
+        Self::new(name, true)
+    }
+
+    /// Creates wound-wait [`Class`].
+    pub fn new_wound_wait(name: &'static CStr) -> impl PinInit<Self> {
+        Self::new(name, false)
+    }
+
+    /// Creates a `Class` from a raw pointer.
+    ///
+    /// This function is intended for interoperability with C code.
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that `ptr` points to the `inner` field of
+    /// [`Class`] and that it remains valid for the lifetime `'a`.
+    pub const unsafe fn from_raw<'a>(ptr: *mut bindings::ww_class) -> &'a Self {
+        // SAFETY: By the safety contract, `ptr` is valid to construct `Class`.
+        unsafe { &*ptr.cast() }
+    }
+}
-- 
2.51.2


