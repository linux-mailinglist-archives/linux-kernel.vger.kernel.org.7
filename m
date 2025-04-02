Return-Path: <linux-kernel+bounces-585803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7357AA797CA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 23:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13CD116FA18
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 21:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8A51F4CBE;
	Wed,  2 Apr 2025 21:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="chPi8+fk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C241F428C
	for <linux-kernel@vger.kernel.org>; Wed,  2 Apr 2025 21:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743630093; cv=none; b=JnJvkKNL7/C3iHr7RUtAsvJ3bJHv3CQG4Qy2FaV0eMrRPhMk1s2n+mAImElaPRVX4iTrNAowhoVGiMb9nhC4YcoSOLEUHvzUQuRM/U6MrnaZi+wR6+mPq49O93KYbLf7BV2hW2uOeRlWqz7Xx4728PT/wM1bxPObNiAmV1tWSxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743630093; c=relaxed/simple;
	bh=ZkZlqKh3TceDVJ4Clh8E+fEPxmXmVYODwVdNwB6xVMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QSWSLXOtw2d9j/Ras0oEnWZ6s8cTrXK32zADzOUpKisNR8iOwtV+F1G5uDilx/HtL9NG/dJaV6KYu7Y0ukBSJ8h6YwIXxniRgvVAMm9av04bWHiX5C5kJ1InxzdQn/dP4YfE+Osgk81AD3FPc0hG26tyiOOu3MVYs7+sJTQBYXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=chPi8+fk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743630090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FXmgHMVH1wAQ3fmowWavtpFj8y/HpxS5YV1/7Oqix2E=;
	b=chPi8+fkSA93REiPkrf/Lldgc0kxcbo1792VoDNPZ445bAjIPo3PLA8ydhrrhu9jt5gsvw
	CdO1t0bp1pjfwvkuK4gu1s1WmXKQE4yaSGcJ/scjcgebv1z4j1nAQUXisBfeE2Y4OcphrR
	IWzbOOhlz+tjj6J7nEdVO1W7MyTMCtU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-55-sjcS6BBnMGCnFnCANeXyNA-1; Wed,
 02 Apr 2025 17:41:27 -0400
X-MC-Unique: sjcS6BBnMGCnFnCANeXyNA-1
X-Mimecast-MFC-AGG-ID: sjcS6BBnMGCnFnCANeXyNA_1743630085
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 30C7019560AB;
	Wed,  2 Apr 2025 21:41:25 +0000 (UTC)
Received: from chopper.lyude.net (unknown [10.22.80.95])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0EE643000704;
	Wed,  2 Apr 2025 21:41:21 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: rust-for-linux@vger.kernel.org,
	Andreas Hindborg <a.hindborg@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>
Subject: [PATCH 2/6] rust: hrtimer: Add HrTimerCallbackContext and ::forward()
Date: Wed,  2 Apr 2025 17:40:30 -0400
Message-ID: <20250402214109.653341-3-lyude@redhat.com>
In-Reply-To: <20250402214109.653341-1-lyude@redhat.com>
References: <20250402214109.653341-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

With Linux's hrtimer API, certain functions require we either acquire
proper locking to call specific methods - or that we call said methods from
the context of the timer callback. hrtimer_forward() is one of these
functions, so we start by adding a new HrTimerCallbackContext type which
provides a way of calling these methods that is inaccessible outside of
hrtimer callbacks.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 rust/kernel/time/hrtimer.rs         | 50 +++++++++++++++++++++++++++--
 rust/kernel/time/hrtimer/arc.rs     |  7 +++-
 rust/kernel/time/hrtimer/pin.rs     |  7 +++-
 rust/kernel/time/hrtimer/pin_mut.rs |  9 ++++--
 rust/kernel/time/hrtimer/tbox.rs    |  7 +++-
 5 files changed, 73 insertions(+), 7 deletions(-)

diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
index 4fc49f1931259..c92b10524f892 100644
--- a/rust/kernel/time/hrtimer.rs
+++ b/rust/kernel/time/hrtimer.rs
@@ -69,7 +69,7 @@
 
 use super::ClockId;
 use crate::{init::PinInit, prelude::*, time::Ktime, types::Opaque};
-use core::marker::PhantomData;
+use core::{marker::PhantomData, ptr::NonNull};
 
 /// A timer backed by a C `struct hrtimer`.
 ///
@@ -279,7 +279,10 @@ pub trait HrTimerCallback {
     type Pointer<'a>: RawHrTimerCallback;
 
     /// Called by the timer logic when the timer fires.
-    fn run(this: <Self::Pointer<'_> as RawHrTimerCallback>::CallbackTarget<'_>) -> HrTimerRestart
+    fn run<T>(
+        this: <Self::Pointer<'_> as RawHrTimerCallback>::CallbackTarget<'_>,
+        ctx: HrTimerCallbackContext<'_, T>
+    ) -> HrTimerRestart
     where
         Self: Sized;
 }
@@ -470,6 +473,49 @@ fn into_c(self) -> bindings::hrtimer_mode {
     }
 }
 
+/// Privileged smart-pointer for a [`HrTimer`] callback context.
+///
+/// This provides access to various methods for a [`HrTimer`] which can only be safely called within
+/// its callback.
+///
+/// # Invariants
+///
+/// * The existence of this type means the caller is currently within the callback for a
+///   [`HrTimer`].
+/// * `self.0` always points to a live instance of [`HrTimer<T>`].
+pub struct HrTimerCallbackContext<'a, T>(NonNull<HrTimer<T>>, PhantomData<&'a ()>);
+
+impl<'a, T> HrTimerCallbackContext<'a, T> {
+    /// Create a new [`HrTimerCallbackContext`].
+    ///
+    /// # Safety
+    ///
+    /// This function relies on the caller being within the context of a timer callback, so it must
+    /// not be used anywhere except for within implementations of [`RawHrTimerCallback::run`]. The
+    /// caller promises that `timer` points to a valid initialized instance of
+    /// [`bindings::hrtimer`].
+    pub(crate) unsafe fn from_raw(timer: *mut HrTimer<T>) -> Self {
+        // SAFETY: The caller guarantees `timer` is a valid pointer to an initialized
+        // `bindings::hrtimer`
+        Self(unsafe { NonNull::new_unchecked(timer) }, PhantomData)
+    }
+
+    /// Get the raw `bindings::hrtimer` pointer for this [`HrTimerCallbackContext`].
+    pub(crate) fn raw_get_timer(&self) -> *mut bindings::hrtimer {
+        // SAFETY: By our type invariants, `self.0` always points to a valid [`HrTimer<T>`].
+        unsafe { HrTimer::raw_get(self.0.as_ptr()) }
+    }
+
+    /// Forward the timer expiry so it will expire in the future.
+    ///
+    /// Note that this does not requeue the timer, it simply updates its expiry value. It returns
+    /// the number of overruns that have occurred as a result of the expiry change.
+    pub fn forward(&self, now: Ktime, interval: Ktime) -> u64 {
+        // SAFETY: The C API requirements for this function are fulfilled by our type invariants.
+        unsafe { bindings::hrtimer_forward(self.raw_get_timer(), now.to_ns(), interval.to_ns()) }
+    }
+}
+
 /// Use to implement the [`HasHrTimer<T>`] trait.
 ///
 /// See [`module`] documentation for an example.
diff --git a/rust/kernel/time/hrtimer/arc.rs b/rust/kernel/time/hrtimer/arc.rs
index 4a984d85b4a10..7dd9f46a0720d 100644
--- a/rust/kernel/time/hrtimer/arc.rs
+++ b/rust/kernel/time/hrtimer/arc.rs
@@ -3,6 +3,7 @@
 use super::HasHrTimer;
 use super::HrTimer;
 use super::HrTimerCallback;
+use super::HrTimerCallbackContext;
 use super::HrTimerHandle;
 use super::HrTimerPointer;
 use super::RawHrTimerCallback;
@@ -95,6 +96,10 @@ impl<T> RawHrTimerCallback for Arc<T>
         //    allocation from other `Arc` clones.
         let receiver = unsafe { ArcBorrow::from_raw(data_ptr) };
 
-        T::run(receiver).into_c()
+        // SAFETY: By C API contract `ptr` is the pointer we passed when queuing the timer, so it is
+        // a `HrTimer<T>` embedded in a `T`.
+        let context = unsafe { HrTimerCallbackContext::from_raw(timer_ptr) };
+
+        T::run(receiver, context).into_c()
     }
 }
diff --git a/rust/kernel/time/hrtimer/pin.rs b/rust/kernel/time/hrtimer/pin.rs
index f760db265c7b5..a8e1b76bf0736 100644
--- a/rust/kernel/time/hrtimer/pin.rs
+++ b/rust/kernel/time/hrtimer/pin.rs
@@ -3,6 +3,7 @@
 use super::HasHrTimer;
 use super::HrTimer;
 use super::HrTimerCallback;
+use super::HrTimerCallbackContext;
 use super::HrTimerHandle;
 use super::RawHrTimerCallback;
 use super::UnsafeHrTimerPointer;
@@ -99,6 +100,10 @@ impl<'a, T> RawHrTimerCallback for Pin<&'a T>
         // here.
         let receiver_pin = unsafe { Pin::new_unchecked(receiver_ref) };
 
-        T::run(receiver_pin).into_c()
+        // SAFETY: By C API contract `ptr` is the pointer we passed when queuing the timer, so it is
+        // a `HrTimer<T>` embedded in a `T`.
+        let context = unsafe { HrTimerCallbackContext::from_raw(timer_ptr) };
+
+        T::run(receiver_pin, context).into_c()
     }
 }
diff --git a/rust/kernel/time/hrtimer/pin_mut.rs b/rust/kernel/time/hrtimer/pin_mut.rs
index 90c0351d62e4b..2dd2ebfd7efaf 100644
--- a/rust/kernel/time/hrtimer/pin_mut.rs
+++ b/rust/kernel/time/hrtimer/pin_mut.rs
@@ -1,7 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 
 use super::{
-    HasHrTimer, HrTimer, HrTimerCallback, HrTimerHandle, RawHrTimerCallback, UnsafeHrTimerPointer,
+    HasHrTimer, HrTimer, HrTimerCallback, HrTimerCallbackContext, HrTimerHandle, RawHrTimerCallback,
+    UnsafeHrTimerPointer,
 };
 use crate::time::Ktime;
 use core::{marker::PhantomData, pin::Pin, ptr::NonNull};
@@ -103,6 +104,10 @@ impl<'a, T> RawHrTimerCallback for Pin<&'a mut T>
         // here.
         let receiver_pin = unsafe { Pin::new_unchecked(receiver_ref) };
 
-        T::run(receiver_pin).into_c()
+        // SAFETY: By C API contract `ptr` is the pointer we passed when queuing the timer, so it is
+        // a `HrTimer<T>` embedded in a `T`.
+        let context = unsafe { HrTimerCallbackContext::from_raw(timer_ptr) };
+
+        T::run(receiver_pin, context).into_c()
     }
 }
diff --git a/rust/kernel/time/hrtimer/tbox.rs b/rust/kernel/time/hrtimer/tbox.rs
index 2071cae072342..e3214f7173beb 100644
--- a/rust/kernel/time/hrtimer/tbox.rs
+++ b/rust/kernel/time/hrtimer/tbox.rs
@@ -3,6 +3,7 @@
 use super::HasHrTimer;
 use super::HrTimer;
 use super::HrTimerCallback;
+use super::HrTimerCallbackContext;
 use super::HrTimerHandle;
 use super::HrTimerPointer;
 use super::RawHrTimerCallback;
@@ -115,6 +116,10 @@ impl<T, A> RawHrTimerCallback for Pin<Box<T, A>>
         //   `data_ptr` exist.
         let data_mut_ref = unsafe { Pin::new_unchecked(&mut *data_ptr) };
 
-        T::run(data_mut_ref).into_c()
+        // SAFETY: By C API contract `ptr` is the pointer we passed when queuing the timer, so it is
+        // a `HrTimer<T>` embedded in a `T`.
+        let context = unsafe { HrTimerCallbackContext::from_raw(timer_ptr) };
+
+        T::run(data_mut_ref, context).into_c()
     }
 }
-- 
2.48.1


