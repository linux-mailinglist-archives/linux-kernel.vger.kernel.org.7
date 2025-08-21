Return-Path: <linux-kernel+bounces-780515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BDAB302F5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 21:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB0211BC72FF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 19:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD1D34DCCC;
	Thu, 21 Aug 2025 19:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eWt+Ho1G"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DEA1A9FAB
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 19:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755804836; cv=none; b=GVgHuV6OwUsbMEQt71zm5f9R6QSaETc5cDbMnFUbbzQEXgqFe1SCw1tpk7FI+iAmw1RuAKT27mhh97yj3HDZg4cGZI6g2TYp1Tuv18aKpuKf7L6k+787skUBXS6U+JNMj861G7nL4xt1s8cw6r7v/6In/nGyVZ0fg21Xo7ABhKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755804836; c=relaxed/simple;
	bh=U+RHJLEPoOu5aEa6o6ob+owYZ3FTasiYeFLqAF32YyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OKKZ2CItI4wMtYfCKKUF1V3Zffy35df4r6WYYVmjmoa7gP2nd6YzyGhui0+mTGeufPjbz1ptvVbs5oC18p52p84QKWLNyO88fihZnV7m/KlTaSQrKbYT+YmU+dNksnIZ5VaDOZThWmOKECOiwPjBAn9kdJ0LVZbTeJOswC3lWYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eWt+Ho1G; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755804833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=khkfrVfHumBuUwLUr11MvZty06PJhhGza2wz1vc7FYc=;
	b=eWt+Ho1GNm/NgxGSs9n3CLMLK8WMGCtbt38pb2TxN3VzyyDRDUx3Hlbm9WJkCoi0uU3Hpu
	Vd4SeZ8XIzIYoEiwlC1h3+sFpKJMY9/9jmKLJmbCOOzoXyZAB2inDgK3b4BHXSngNpZJ53
	aW9PF2s8rUFaN0WfgPterPyJPVOSaaU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-600-YbKq1ST7OfeOvSAPyhVLlQ-1; Thu,
 21 Aug 2025 15:33:45 -0400
X-MC-Unique: YbKq1ST7OfeOvSAPyhVLlQ-1
X-Mimecast-MFC-AGG-ID: YbKq1ST7OfeOvSAPyhVLlQ_1755804822
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6C771195608E;
	Thu, 21 Aug 2025 19:33:42 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.89.200])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2ACDB1955F24;
	Thu, 21 Aug 2025 19:33:38 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: 
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Tamir Duberstein <tamird@gmail.com>,
	rust-for-linux@vger.kernel.org (open list:DELAY, SLEEP, TIMEKEEPING, TIMERS [RUST]),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v9 4/7] rust: hrtimer: Add HrTimerCallbackContext and ::forward()
Date: Thu, 21 Aug 2025 15:32:44 -0400
Message-ID: <20250821193259.964504-5-lyude@redhat.com>
In-Reply-To: <20250821193259.964504-1-lyude@redhat.com>
References: <20250821193259.964504-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

With Linux's hrtimer API, there's a number of methods that can only be
called in two situations:

* When we have exclusive access to the hrtimer and it is not currently
  active
* When we're within the context of an hrtimer callback context

This commit handles the second situation and implements hrtimer_forward()
support in the context of a timer callback. We do this by introducing a
HrTimerCallbackContext type which is provided to users during the
RawHrTimerCallback::run() callback, and then add a forward() function to
the type.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>

---
V2:
* Improve SAFETY comments for HrTimerCallbackContext uses (I forgot to
  mention that we're within RawHrTimerCallback::run()
* Split forward into forward() and raw_forward() since we're going to have
  two contexts that we can call forward() from now.
* Clarify contexts in which certain hrtimer methods can be called.
* Make sure that we use a mutable reference for forward() here - just in
  case :).
* Rename interval to duration
V3:
* Rename duration -back- to interval (now that I actually have read
  hrtimer_forward's source, interval does make more sense than duration
  considering the fact we return the number of overruns that occurred
  according to the given interval).
* Rewrite documentation a bit (re: Andreas)
V5:
* Fix unbounded T on HrTimerCallbackContext
V6:
* Move reference to HrTimerCallbackContext::forward() in HrTimer::forward()
  comments into this commit so rustdoc doesn't fail.
* Deduplicate documentation for HrTimerCallbackContext::forward()
* Add missing changelog note

 rust/kernel/time/hrtimer.rs         | 63 +++++++++++++++++++++++++++--
 rust/kernel/time/hrtimer/arc.rs     |  9 ++++-
 rust/kernel/time/hrtimer/pin.rs     |  9 ++++-
 rust/kernel/time/hrtimer/pin_mut.rs | 12 ++++--
 rust/kernel/time/hrtimer/tbox.rs    |  9 ++++-
 5 files changed, 93 insertions(+), 9 deletions(-)

diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
index 79fed14b2d98e..1e8839d277292 100644
--- a/rust/kernel/time/hrtimer.rs
+++ b/rust/kernel/time/hrtimer.rs
@@ -69,7 +69,7 @@
 
 use super::{ClockSource, Delta, Instant};
 use crate::{prelude::*, types::Opaque};
-use core::marker::PhantomData;
+use core::{marker::PhantomData, ptr::NonNull};
 use pin_init::PinInit;
 
 /// A type-alias to refer to the [`Instant<C>`] for a given `T` from [`HrTimer<T>`].
@@ -196,6 +196,10 @@ unsafe fn raw_forward(self_ptr: *mut Self, now: HrTimerInstant<T>, interval: Del
     /// expires after `now` and then returns the number of times the timer was forwarded by
     /// `interval`.
     ///
+    /// This function is mainly useful for timer types which can provide exclusive access to the
+    /// timer when the timer is not running. For forwarding the timer from within the timer callback
+    /// context, see [`HrTimerCallbackContext::forward()`].
+    ///
     /// Returns the number of overruns that occurred as a result of the timer expiry change.
     pub fn forward(self: Pin<&mut Self>, now: HrTimerInstant<T>, interval: Delta) -> u64
     where
@@ -345,9 +349,13 @@ pub trait HrTimerCallback {
     type Pointer<'a>: RawHrTimerCallback;
 
     /// Called by the timer logic when the timer fires.
-    fn run(this: <Self::Pointer<'_> as RawHrTimerCallback>::CallbackTarget<'_>) -> HrTimerRestart
+    fn run(
+        this: <Self::Pointer<'_> as RawHrTimerCallback>::CallbackTarget<'_>,
+        ctx: HrTimerCallbackContext<'_, Self>,
+    ) -> HrTimerRestart
     where
-        Self: Sized;
+        Self: Sized,
+        Self: HasHrTimer<Self>;
 }
 
 /// A handle representing a potentially running timer.
@@ -632,6 +640,55 @@ impl<C: ClockSource> HrTimerMode for RelativePinnedHardMode<C> {
     type Expires = Delta;
 }
 
+/// Privileged smart-pointer for a [`HrTimer`] callback context.
+///
+/// Many [`HrTimer`] methods can only be called in two situations:
+///
+/// * When the caller has exclusive access to the `HrTimer` and the `HrTimer` is guaranteed not to
+///   be running.
+/// * From within the context of an `HrTimer`'s callback method.
+///
+/// This type provides access to said methods from within a timer callback context.
+///
+/// # Invariants
+///
+/// * The existence of this type means the caller is currently within the callback for an
+///   [`HrTimer`].
+/// * `self.0` always points to a live instance of [`HrTimer<T>`].
+pub struct HrTimerCallbackContext<'a, T: HasHrTimer<T>>(NonNull<HrTimer<T>>, PhantomData<&'a ()>);
+
+impl<'a, T: HasHrTimer<T>> HrTimerCallbackContext<'a, T> {
+    /// Create a new [`HrTimerCallbackContext`].
+    ///
+    /// # Safety
+    ///
+    /// This function relies on the caller being within the context of a timer callback, so it must
+    /// not be used anywhere except for within implementations of [`RawHrTimerCallback::run`]. The
+    /// caller promises that `timer` points to a valid initialized instance of
+    /// [`bindings::hrtimer`].
+    ///
+    /// The returned `Self` must not outlive the function context of [`RawHrTimerCallback::run`]
+    /// where this function is called.
+    pub(crate) unsafe fn from_raw(timer: *mut HrTimer<T>) -> Self {
+        // SAFETY: The caller guarantees `timer` is a valid pointer to an initialized
+        // `bindings::hrtimer`
+        // INVARIANT: Our safety contract ensures that we're within the context of a timer callback
+        // and that `timer` points to a live instance of `HrTimer<T>`.
+        Self(unsafe { NonNull::new_unchecked(timer) }, PhantomData)
+    }
+
+    /// Conditionally forward the timer.
+    ///
+    /// This function is identical to [`HrTimer::forward()`] except that it may only be used from
+    /// within the context of a [`HrTimer`] callback.
+    pub fn forward(&mut self, now: HrTimerInstant<T>, interval: Delta) -> u64 {
+        // SAFETY:
+        // - We are guaranteed to be within the context of a timer callback by our type invariants
+        // - By our type invariants, `self.0` always points to a valid `HrTimer<T>`
+        unsafe { HrTimer::<T>::raw_forward(self.0.as_ptr(), now, interval) }
+    }
+}
+
 /// Use to implement the [`HasHrTimer<T>`] trait.
 ///
 /// See [`module`] documentation for an example.
diff --git a/rust/kernel/time/hrtimer/arc.rs b/rust/kernel/time/hrtimer/arc.rs
index ed490a7a89503..7be82bcb352ac 100644
--- a/rust/kernel/time/hrtimer/arc.rs
+++ b/rust/kernel/time/hrtimer/arc.rs
@@ -3,6 +3,7 @@
 use super::HasHrTimer;
 use super::HrTimer;
 use super::HrTimerCallback;
+use super::HrTimerCallbackContext;
 use super::HrTimerHandle;
 use super::HrTimerMode;
 use super::HrTimerPointer;
@@ -99,6 +100,12 @@ impl<T> RawHrTimerCallback for Arc<T>
         //    allocation from other `Arc` clones.
         let receiver = unsafe { ArcBorrow::from_raw(data_ptr) };
 
-        T::run(receiver).into_c()
+        // SAFETY:
+        // - By C API contract `timer_ptr` is the pointer that we passed when queuing the timer, so
+        //   it is a valid pointer to a `HrTimer<T>` embedded in a `T`.
+        // - We are within `RawHrTimerCallback::run`
+        let context = unsafe { HrTimerCallbackContext::from_raw(timer_ptr) };
+
+        T::run(receiver, context).into_c()
     }
 }
diff --git a/rust/kernel/time/hrtimer/pin.rs b/rust/kernel/time/hrtimer/pin.rs
index aef16d9ee2f0c..4d39ef7816971 100644
--- a/rust/kernel/time/hrtimer/pin.rs
+++ b/rust/kernel/time/hrtimer/pin.rs
@@ -3,6 +3,7 @@
 use super::HasHrTimer;
 use super::HrTimer;
 use super::HrTimerCallback;
+use super::HrTimerCallbackContext;
 use super::HrTimerHandle;
 use super::HrTimerMode;
 use super::RawHrTimerCallback;
@@ -103,6 +104,12 @@ impl<'a, T> RawHrTimerCallback for Pin<&'a T>
         // here.
         let receiver_pin = unsafe { Pin::new_unchecked(receiver_ref) };
 
-        T::run(receiver_pin).into_c()
+        // SAFETY:
+        // - By C API contract `timer_ptr` is the pointer that we passed when queuing the timer, so
+        //   it is a valid pointer to a `HrTimer<T>` embedded in a `T`.
+        // - We are within `RawHrTimerCallback::run`
+        let context = unsafe { HrTimerCallbackContext::from_raw(timer_ptr) };
+
+        T::run(receiver_pin, context).into_c()
     }
 }
diff --git a/rust/kernel/time/hrtimer/pin_mut.rs b/rust/kernel/time/hrtimer/pin_mut.rs
index 767d0a4e8a2c1..9d9447d4d57e8 100644
--- a/rust/kernel/time/hrtimer/pin_mut.rs
+++ b/rust/kernel/time/hrtimer/pin_mut.rs
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 
 use super::{
-    HasHrTimer, HrTimer, HrTimerCallback, HrTimerHandle, HrTimerMode, RawHrTimerCallback,
-    UnsafeHrTimerPointer,
+    HasHrTimer, HrTimer, HrTimerCallback, HrTimerCallbackContext, HrTimerHandle, HrTimerMode,
+    RawHrTimerCallback, UnsafeHrTimerPointer,
 };
 use core::{marker::PhantomData, pin::Pin, ptr::NonNull};
 
@@ -107,6 +107,12 @@ impl<'a, T> RawHrTimerCallback for Pin<&'a mut T>
         // here.
         let receiver_pin = unsafe { Pin::new_unchecked(receiver_ref) };
 
-        T::run(receiver_pin).into_c()
+        // SAFETY:
+        // - By C API contract `timer_ptr` is the pointer that we passed when queuing the timer, so
+        //   it is a valid pointer to a `HrTimer<T>` embedded in a `T`.
+        // - We are within `RawHrTimerCallback::run`
+        let context = unsafe { HrTimerCallbackContext::from_raw(timer_ptr) };
+
+        T::run(receiver_pin, context).into_c()
     }
 }
diff --git a/rust/kernel/time/hrtimer/tbox.rs b/rust/kernel/time/hrtimer/tbox.rs
index ec08303315f28..aa1ee31a71953 100644
--- a/rust/kernel/time/hrtimer/tbox.rs
+++ b/rust/kernel/time/hrtimer/tbox.rs
@@ -3,6 +3,7 @@
 use super::HasHrTimer;
 use super::HrTimer;
 use super::HrTimerCallback;
+use super::HrTimerCallbackContext;
 use super::HrTimerHandle;
 use super::HrTimerMode;
 use super::HrTimerPointer;
@@ -119,6 +120,12 @@ impl<T, A> RawHrTimerCallback for Pin<Box<T, A>>
         //   `data_ptr` exist.
         let data_mut_ref = unsafe { Pin::new_unchecked(&mut *data_ptr) };
 
-        T::run(data_mut_ref).into_c()
+        // SAFETY:
+        // - By C API contract `timer_ptr` is the pointer that we passed when queuing the timer, so
+        //   it is a valid pointer to a `HrTimer<T>` embedded in a `T`.
+        // - We are within `RawHrTimerCallback::run`
+        let context = unsafe { HrTimerCallbackContext::from_raw(timer_ptr) };
+
+        T::run(data_mut_ref, context).into_c()
     }
 }
-- 
2.50.0


