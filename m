Return-Path: <linux-kernel+bounces-727121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 576B9B0154B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 10:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99A1D16F289
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 08:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14631F150B;
	Fri, 11 Jul 2025 07:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rk08rZ+2"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC171F4CBB
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 07:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752220797; cv=none; b=D0MaSPv4zTadzQUX7Qxo9+FxGPDaJoFNNiarNkXEpUxsLRNpveMNHGDLb6TQ6lx2uBLIfeafahVFqYaGw5Fd0vansJQaoqtx6amBucbK4RhgUT449jgaWg0y0x9OyR/JdSRnndhMwQdXwiw5I/nsOlWznmc4E+7obFeeeh4YB2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752220797; c=relaxed/simple;
	bh=meOWtz10ZubHsvhWutUrpcEUvqcCA66Q0seTG5HoT6w=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=BSPwDIm00vEXJW1rZ3vvEQBw3ykCdeWSOZiJed3mpGSt8i2o7+ioGngwOwGsfaGq1ees+b7E9hctRspJkFqRTvZOd/agroRb9GxSuGmhLT4JcPIfW77HseixGq6FbuwWawnbWqwQs5oW2lnhfgzcZR+WYJ8+E18JxithVyzmMJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rk08rZ+2; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3a4f858bc5eso1353532f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 00:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752220794; x=1752825594; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=obXhWEVIVAGxuRyoSerNF8wGzpmpf96LcuiO93QSmmU=;
        b=Rk08rZ+2FYQhWf3kDMN2keX+3PZyn58UcF9F2+F1l2mWkDwLqR9dvv9d8coNsYghID
         mR77uyonGy7GH4IEAs0TmUqMv9IFfN7fhduS+QEZovuUz8UZcELLKWL6xk4BXFSVDAy2
         d83TmfHeil+nSuRVT7fNr/OzX+h32CLUfnLOBsNHmyMTGrWsiv8xRANjQ8XcHSRmMqkF
         nKQMsBQSiSkB4jBPVraIuKFNaMYGZDuPHyprFyW3YB8gx5ix/K5Ds/BEn7deTWKQvRlE
         16dro2JsqCG6FvV+tDTzSlzPV5T0LBy7T9UbQpUYbpEYIUe+6fRpFHIEUTNemTMB+fOC
         nP1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752220794; x=1752825594;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=obXhWEVIVAGxuRyoSerNF8wGzpmpf96LcuiO93QSmmU=;
        b=EzFYY3NaQDGQhsdd3zVNzVX60BSq+KjKDBdYJOHyWEu8UqU/Q0aHJ1BnpZq6uqmMGw
         8zLcJtk/2yomIMZ/ilC+rTfWQ4slexwU4dLHp3L2CP274AvGM+5yIM4vtCx6Jcjpa5+y
         E41eTe/qJe81Qmqn8H9R3EwLb49TdxDgtRx266cmWEuVeLEnLq70NaxCmyevUEOXf5Qa
         NYyXX+IAfo0b7mFrZ0qiZUgOf+nHFQztsmtTUuJ1Z4lfNg/nSnBifWhu18l0pXpxbvkp
         49iQgl4LUHyw0bo/j6tpso4GqxY1/00jktZnscm/i+rnLNUJv6xyYU3AO7prKpP5SVC6
         1d9A==
X-Forwarded-Encrypted: i=1; AJvYcCV52dQ+SICSsTYQyGYcHBVsU710h3zxHSG6OvIL4sLcEWhPuB4SL2HDTIwV5NmoTQn77HWKGz+p1XbEKBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkXEdaW/HoKiinRhsEoOarErRaJopLBQX7uoYYI4wR1ZB9B08i
	R5iKMI41fAHjzdIKyNOFpPAX0BCscmnElP+q/NF9uodb3xwFT0xKsibhnaEFsxkb2CFfw9GS5ll
	iI54lvwwUI/9u7KVz4w==
X-Google-Smtp-Source: AGHT+IE2u5pEBkYblzuQrldRINmzbfoGKfR4zcd2q5danruEhP6rtQJBl7y+zt24j4OSRs3V7tf4JQLw6AiV6/8=
X-Received: from wrrc17.prod.google.com ([2002:adf:fb11:0:b0:3a5:7a4e:8e1e])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2dc6:b0:3a5:2e84:cc7b with SMTP id ffacd0b85a97d-3b5f2dac5ebmr1330964f8f.11.1752220793846;
 Fri, 11 Jul 2025 00:59:53 -0700 (PDT)
Date: Fri, 11 Jul 2025 07:59:40 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAGvEcGgC/2WQzY7CMAyEX6XKGaMkpCn0tO+x4pAfp0RQAkkbQ
 KjvTqBI7Irj2PI3M76ThNFjIm11JxGzTz4ci1gtKmJ26tgheFs04ZTXVNANXELcn0ccESwe1A0
 ERU2NbYy0lJSrU0Tnry/i77bonU9DiLeXQWbP6ZvF2BcrM2DApd4I3mhGa/HThdAdcGlCT56wz
 D8AyZtvAC+AtdBUSGe1cOYfYJrjRTyPpecwZyRaJYSy7/3QVlkumYRoVuTvA9pqdmQNhJMqhuB i6CGqCyhT6zU66ZTibYm3naYHvOY0QVQBAAA=
X-Change-Id: 20250409-workqueue-delay-40eb0cd7c6d0
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=18039; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=meOWtz10ZubHsvhWutUrpcEUvqcCA66Q0seTG5HoT6w=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBocMR0Fk+dTcayuG7HkerjncEFHpu7wZfBcFLgM
 fITL9LakBWJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaHDEdAAKCRAEWL7uWMY5
 RhX5D/9ou5e9DHhpzz1ysbO64jtVlBo06N1j5gUN8MOgh+TFBFFkU2HeEQt1GCUN7gHWh/uA087
 NqdajlOUQKyvr5POp6R22Z4iP9RZMFnuKGe6U4BZ4HFnSsQ4xM2AykRgWLppIBlQjzfRvsThDdp
 ccA56KU4PrnfUMq1qVXsUZr8YxNDn9YED0vmutqSJ7NajIQ8PyNePqtIfh6O1kNPCPI0AhTpnqY
 QPPrKfnn7Ok7PYulVLGDp1oVigPgA4upU3B0W39Xxa1VtpBDekHBorZV6JP5i4cuRnO78LkZJ8p
 bk/8Y7WA6EIyMj1jIeNuB9y2Hi3JCXOtWwUuF630XnwLo20O9pwbggdSuAyRawfKtaUyfLT2Tbi
 MtO5xFH+RFjuYqWnpg1SoUErs0VQkz7tFiskzEkJCM8TdAQdfPN/0HsHo4hDJZbH3UiAEb1bbVg
 YYTO15n5tNBJy29wv6Jm9PMVw4SP4fMMtQTo7D3aq6VZucZ2I9mHn8uFDe0uq9Pz0Gc00nUEUf4
 7rtJgUtuhXhetgMFExcw2PwITcheorBCbwHHtvZ7GmpKmCKX/eTQVRiPVMv/q+NV5MoyF6Z5G0E
 6vn5SzhpKrHAKK41NG0auvoEXEYNFgJpdw3tDvpy/PHHrnw0p+uafsgEswkBrLkHEiheFkgP/Gr c1PT1+wskAdHSaQ==
X-Mailer: b4 0.14.2
Message-ID: <20250711-workqueue-delay-v3-1-3fe17b18b9d1@google.com>
Subject: [PATCH v3] workqueue: rust: add delayed work items
From: Alice Ryhl <aliceryhl@google.com>
To: Tejun Heo <tj@kernel.org>, Miguel Ojeda <ojeda@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@gmail.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

This patch is being sent for use in the various Rust GPU drivers that
are under development. It provides the additional feature of work items
that are executed after a delay.

The design of the existing workqueue is rather extensible, as most of
the logic is reused for delayed work items even though a different work
item type is required. The new logic consists of:

* A new DelayedWork struct that wraps struct delayed_work.
* A new impl_has_delayed_work! macro that provides adjusted versions of
  the container_of logic, that is suitable with delayed work items.
* A `enqueue_delayed` method that can enqueue a delayed work item.

This patch does *not* rely on the fact that `struct delayed_work`
contains `struct work_struct` at offset zero. It will continue to work
even if the layout is changed to hold the `work` field at a different
offset.

Please see the example introduced at the top of the file for example
usage of delayed work items.

Acked-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
To avoid conflicts with the rename of Opaque::raw_get, this is based on
top of the patch that renames it. Due to this conflict, I think it's
easier to land this through Miguel's tree if it lands this cycle.

Of course if it does not land this cycle, it can go through Tejun's
tree.
---
Changes in v3:
- Rebase on [PATCH v2 0/2] Add Opaque::cast_from.
- Use optional_name!().
- Use a different number of jiffies.
- Link to v2: https://lore.kernel.org/r/20250627-workqueue-delay-v2-1-84b046fdb4fc@google.com

Changes in v2:
- Rebase on v6.16-rc2.
- There are no longer any dependencies as they were merged into
  v6-16-rc1.
- Fix some compilation errors related to changes to container_of! and
  lock class keys.
- Link to v1: https://lore.kernel.org/r/20250411-workqueue-delay-v1-1-26b9427b1054@google.com
---
 rust/kernel/workqueue.rs | 330 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 327 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
index a3085a56419db9a7d4c4b757ddd0964b59e453f9..50d57be8f92af418145f44b5b6d2abea27c73119 100644
--- a/rust/kernel/workqueue.rs
+++ b/rust/kernel/workqueue.rs
@@ -131,10 +131,69 @@
 //! # print_2_later(MyStruct::new(41, 42).unwrap());
 //! ```
 //!
+//! This example shows how you can schedule delayed work items:
+//!
+//! ```
+//! use kernel::sync::Arc;
+//! use kernel::workqueue::{self, impl_has_delayed_work, new_delayed_work, DelayedWork, WorkItem};
+//!
+//! #[pin_data]
+//! struct MyStruct {
+//!     value: i32,
+//!     #[pin]
+//!     work: DelayedWork<MyStruct>,
+//! }
+//!
+//! impl_has_delayed_work! {
+//!     impl HasDelayedWork<Self> for MyStruct { self.work }
+//! }
+//!
+//! impl MyStruct {
+//!     fn new(value: i32) -> Result<Arc<Self>> {
+//!         Arc::pin_init(
+//!             pin_init!(MyStruct {
+//!                 value,
+//!                 work <- new_delayed_work!("MyStruct::work"),
+//!             }),
+//!             GFP_KERNEL,
+//!         )
+//!     }
+//! }
+//!
+//! impl WorkItem for MyStruct {
+//!     type Pointer = Arc<MyStruct>;
+//!
+//!     fn run(this: Arc<MyStruct>) {
+//!         pr_info!("The value is: {}\n", this.value);
+//!     }
+//! }
+//!
+//! /// This method will enqueue the struct for execution on the system workqueue, where its value
+//! /// will be printed 12 jiffies later.
+//! fn print_later(val: Arc<MyStruct>) {
+//!     let _ = workqueue::system().enqueue_delayed(val, 12);
+//! }
+//!
+//! /// It is also possible to use the ordinary `enqueue` method together with `DelayedWork`. This
+//! /// is equivalent to calling `enqueue_delayed` with a delay of zero.
+//! fn print_now(val: Arc<MyStruct>) {
+//!     let _ = workqueue::system().enqueue(val);
+//! }
+//! # print_later(MyStruct::new(42).unwrap());
+//! # print_now(MyStruct::new(42).unwrap());
+//! ```
+//!
 //! C header: [`include/linux/workqueue.h`](srctree/include/linux/workqueue.h)
 
-use crate::alloc::{AllocError, Flags};
-use crate::{prelude::*, sync::Arc, sync::LockClassKey, types::Opaque};
+use crate::{
+    alloc::{AllocError, Flags},
+    container_of,
+    prelude::*,
+    sync::Arc,
+    sync::LockClassKey,
+    time::Jiffies,
+    types::Opaque,
+};
 use core::marker::PhantomData;
 
 /// Creates a [`Work`] initialiser with the given name and a newly-created lock class.
@@ -146,6 +205,33 @@ macro_rules! new_work {
 }
 pub use new_work;
 
+/// Creates a [`DelayedWork`] initialiser with the given name and a newly-created lock class.
+#[macro_export]
+macro_rules! new_delayed_work {
+    () => {
+        $crate::workqueue::DelayedWork::new(
+            $crate::optional_name!(),
+            $crate::static_lock_class!(),
+            $crate::c_str!(::core::concat!(
+                ::core::file!(),
+                ":",
+                ::core::line!(),
+                "_timer"
+            )),
+            $crate::static_lock_class!(),
+        )
+    };
+    ($name:literal) => {
+        $crate::workqueue::DelayedWork::new(
+            $crate::c_str!($name),
+            $crate::static_lock_class!(),
+            $crate::c_str!(::core::concat!($name, "_timer")),
+            $crate::static_lock_class!(),
+        )
+    };
+}
+pub use new_delayed_work;
+
 /// A kernel work queue.
 ///
 /// Wraps the kernel's C `struct workqueue_struct`.
@@ -206,6 +292,42 @@ pub fn enqueue<W, const ID: u64>(&self, w: W) -> W::EnqueueOutput
         }
     }
 
+    /// Enqueues a delayed work item.
+    ///
+    /// This may fail if the work item is already enqueued in a workqueue.
+    ///
+    /// The work item will be submitted using `WORK_CPU_UNBOUND`.
+    pub fn enqueue_delayed<W, const ID: u64>(&self, w: W, delay: Jiffies) -> W::EnqueueOutput
+    where
+        W: RawDelayedWorkItem<ID> + Send + 'static,
+    {
+        let queue_ptr = self.0.get();
+
+        // SAFETY: We only return `false` if the `work_struct` is already in a workqueue. The other
+        // `__enqueue` requirements are not relevant since `W` is `Send` and static.
+        //
+        // The call to `bindings::queue_delayed_work_on` will dereference the provided raw pointer,
+        // which is ok because `__enqueue` guarantees that the pointer is valid for the duration of
+        // this closure, and the safety requirements of `RawDelayedWorkItem` expands this
+        // requirement to apply to the entire `delayed_work`.
+        //
+        // Furthermore, if the C workqueue code accesses the pointer after this call to
+        // `__enqueue`, then the work item was successfully enqueued, and
+        // `bindings::queue_delayed_work_on` will have returned true. In this case, `__enqueue`
+        // promises that the raw pointer will stay valid until we call the function pointer in the
+        // `work_struct`, so the access is ok.
+        unsafe {
+            w.__enqueue(move |work_ptr| {
+                bindings::queue_delayed_work_on(
+                    bindings::wq_misc_consts_WORK_CPU_UNBOUND as _,
+                    queue_ptr,
+                    container_of!(work_ptr, bindings::delayed_work, work),
+                    delay,
+                )
+            })
+        }
+    }
+
     /// Tries to spawn the given function or closure as a work item.
     ///
     /// This method can fail because it allocates memory to store the work item.
@@ -298,6 +420,16 @@ unsafe fn __enqueue<F>(self, queue_work_on: F) -> Self::EnqueueOutput
         F: FnOnce(*mut bindings::work_struct) -> bool;
 }
 
+/// A raw delayed work item.
+///
+/// # Safety
+///
+/// If the `__enqueue` method in the `RawWorkItem` implementation calls the closure, then the
+/// provided pointer must point at the `work` field of a valid `delayed_work`, and the guarantees
+/// that `__enqueue` provides about accessing the `work_struct` must also apply to the rest of the
+/// `delayed_work` struct.
+pub unsafe trait RawDelayedWorkItem<const ID: u64>: RawWorkItem<ID> {}
+
 /// Defines the method that should be called directly when a work item is executed.
 ///
 /// This trait is implemented by `Pin<KBox<T>>` and [`Arc<T>`], and is mainly intended to be
@@ -407,7 +539,7 @@ pub unsafe fn raw_get(ptr: *const Self) -> *mut bindings::work_struct {
     }
 }
 
-/// Declares that a type has a [`Work<T, ID>`] field.
+/// Declares that a type contains a [`Work<T, ID>`].
 ///
 /// The intended way of using this trait is via the [`impl_has_work!`] macro. You can use the macro
 /// like this:
@@ -506,6 +638,178 @@ unsafe fn work_container_of(
     impl{T} HasWork<Self> for ClosureWork<T> { self.work }
 }
 
+/// Links for a delayed work item.
+///
+/// This struct contains a function pointer to the [`run`] function from the [`WorkItemPointer`]
+/// trait, and defines the linked list pointers necessary to enqueue a work item in a workqueue in
+/// a delayed manner.
+///
+/// Wraps the kernel's C `struct delayed_work`.
+///
+/// This is a helper type used to associate a `delayed_work` with the [`WorkItem`] that uses it.
+///
+/// [`run`]: WorkItemPointer::run
+#[pin_data]
+#[repr(transparent)]
+pub struct DelayedWork<T: ?Sized, const ID: u64 = 0> {
+    #[pin]
+    dwork: Opaque<bindings::delayed_work>,
+    _inner: PhantomData<T>,
+}
+
+// SAFETY: Kernel work items are usable from any thread.
+//
+// We do not need to constrain `T` since the work item does not actually contain a `T`.
+unsafe impl<T: ?Sized, const ID: u64> Send for DelayedWork<T, ID> {}
+// SAFETY: Kernel work items are usable from any thread.
+//
+// We do not need to constrain `T` since the work item does not actually contain a `T`.
+unsafe impl<T: ?Sized, const ID: u64> Sync for DelayedWork<T, ID> {}
+
+impl<T: ?Sized, const ID: u64> DelayedWork<T, ID> {
+    /// Creates a new instance of [`DelayedWork`].
+    #[inline]
+    pub fn new(
+        work_name: &'static CStr,
+        work_key: Pin<&'static LockClassKey>,
+        timer_name: &'static CStr,
+        timer_key: Pin<&'static LockClassKey>,
+    ) -> impl PinInit<Self>
+    where
+        T: WorkItem<ID>,
+    {
+        pin_init!(Self {
+            dwork <- Opaque::ffi_init(|slot: *mut bindings::delayed_work| {
+                // SAFETY: The `WorkItemPointer` implementation promises that `run` can be used as
+                // the work item function.
+                unsafe {
+                    bindings::init_work_with_key(
+                        core::ptr::addr_of_mut!((*slot).work),
+                        Some(T::Pointer::run),
+                        false,
+                        work_name.as_char_ptr(),
+                        work_key.as_ptr(),
+                    )
+                }
+
+                // SAFETY: The `delayed_work_timer_fn` function pointer can be used here because
+                // the timer is embedded in a `struct delayed_work`, and only ever scheduled via
+                // the core workqueue code, and configured to run in irqsafe context.
+                unsafe {
+                    bindings::timer_init_key(
+                        core::ptr::addr_of_mut!((*slot).timer),
+                        Some(bindings::delayed_work_timer_fn),
+                        bindings::TIMER_IRQSAFE,
+                        timer_name.as_char_ptr(),
+                        timer_key.as_ptr(),
+                    )
+                }
+            }),
+            _inner: PhantomData,
+        })
+    }
+
+    /// Get a pointer to the inner `delayed_work`.
+    ///
+    /// # Safety
+    ///
+    /// The provided pointer must not be dangling and must be properly aligned. (But the memory
+    /// need not be initialized.)
+    #[inline]
+    pub unsafe fn raw_as_work(ptr: *const Self) -> *mut Work<T, ID> {
+        // SAFETY: The caller promises that the pointer is aligned and not dangling.
+        let dw: *mut bindings::delayed_work =
+            unsafe { Opaque::cast_into(core::ptr::addr_of!((*ptr).dwork)) };
+        // SAFETY: The caller promises that the pointer is aligned and not dangling.
+        let wrk: *mut bindings::work_struct = unsafe { core::ptr::addr_of_mut!((*dw).work) };
+        // CAST: Work and work_struct have compatible layouts.
+        wrk.cast()
+    }
+}
+
+/// Declares that a type contains a [`DelayedWork<T, ID>`].
+///
+/// # Safety
+///
+/// The `HasWork<T, ID>` implementation must return a `work_struct` that is stored in the `work`
+/// field of a `delayed_work` with the same access rules as the `work_struct`.
+pub unsafe trait HasDelayedWork<T, const ID: u64 = 0>: HasWork<T, ID> {}
+
+/// Used to safely implement the [`HasDelayedWork<T, ID>`] trait.
+///
+/// This macro also implements the [`HasWork`] trait, so you do not need to use [`impl_has_work!`]
+/// when using this macro.
+///
+/// # Examples
+///
+/// ```
+/// use kernel::sync::Arc;
+/// use kernel::workqueue::{self, impl_has_delayed_work, DelayedWork};
+///
+/// struct MyStruct<'a, T, const N: usize> {
+///     work_field: DelayedWork<MyStruct<'a, T, N>, 17>,
+///     f: fn(&'a [T; N]),
+/// }
+///
+/// impl_has_delayed_work! {
+///     impl{'a, T, const N: usize} HasDelayedWork<MyStruct<'a, T, N>, 17>
+///     for MyStruct<'a, T, N> { self.work_field }
+/// }
+/// ```
+#[macro_export]
+macro_rules! impl_has_delayed_work {
+    ($(impl$({$($generics:tt)*})?
+       HasDelayedWork<$work_type:ty $(, $id:tt)?>
+       for $self:ty
+       { self.$field:ident }
+    )*) => {$(
+        // SAFETY: The implementation of `raw_get_work` only compiles if the field has the right
+        // type.
+        unsafe impl$(<$($generics)+>)?
+            $crate::workqueue::HasDelayedWork<$work_type $(, $id)?> for $self {}
+
+        // SAFETY: The implementation of `raw_get_work` only compiles if the field has the right
+        // type.
+        unsafe impl$(<$($generics)+>)? $crate::workqueue::HasWork<$work_type $(, $id)?> for $self {
+            #[inline]
+            unsafe fn raw_get_work(
+                ptr: *mut Self
+            ) -> *mut $crate::workqueue::Work<$work_type $(, $id)?> {
+                // SAFETY: The caller promises that the pointer is not dangling.
+                let ptr: *mut $crate::workqueue::DelayedWork<$work_type $(, $id)?> = unsafe {
+                    ::core::ptr::addr_of_mut!((*ptr).$field)
+                };
+
+                // SAFETY: The caller promises that the pointer is not dangling.
+                unsafe { $crate::workqueue::DelayedWork::raw_as_work(ptr) }
+            }
+
+            #[inline]
+            unsafe fn work_container_of(
+                ptr: *mut $crate::workqueue::Work<$work_type $(, $id)?>,
+            ) -> *mut Self {
+                // SAFETY: The caller promises that the pointer points at a field of the right type
+                // in the right kind of struct.
+                let ptr = unsafe { $crate::workqueue::Work::raw_get(ptr) };
+
+                // SAFETY: The caller promises that the pointer points at a field of the right type
+                // in the right kind of struct.
+                let delayed_work = unsafe {
+                    $crate::container_of!(ptr, $crate::bindings::delayed_work, work)
+                };
+
+                let delayed_work: *mut $crate::workqueue::DelayedWork<$work_type $(, $id)?> =
+                    delayed_work.cast();
+
+                // SAFETY: The caller promises that the pointer points at a field of the right type
+                // in the right kind of struct.
+                unsafe { $crate::container_of!(delayed_work, Self, $field) }
+            }
+        }
+    )*};
+}
+pub use impl_has_delayed_work;
+
 // SAFETY: The `__enqueue` implementation in RawWorkItem uses a `work_struct` initialized with the
 // `run` method of this trait as the function pointer because:
 //   - `__enqueue` gets the `work_struct` from the `Work` field, using `T::raw_get_work`.
@@ -567,6 +871,16 @@ unsafe fn __enqueue<F>(self, queue_work_on: F) -> Self::EnqueueOutput
     }
 }
 
+// SAFETY: By the safety requirements of `HasDelayedWork`, the `work_struct` returned by methods in
+// `HasWork` provides a `work_struct` that is the `work` field of a `delayed_work`, and the rest of
+// the `delayed_work` has the same access rules as its `work` field.
+unsafe impl<T, const ID: u64> RawDelayedWorkItem<ID> for Arc<T>
+where
+    T: WorkItem<ID, Pointer = Self>,
+    T: HasDelayedWork<T, ID>,
+{
+}
+
 // SAFETY: TODO.
 unsafe impl<T, const ID: u64> WorkItemPointer<ID> for Pin<KBox<T>>
 where
@@ -617,6 +931,16 @@ unsafe fn __enqueue<F>(self, queue_work_on: F) -> Self::EnqueueOutput
     }
 }
 
+// SAFETY: By the safety requirements of `HasDelayedWork`, the `work_struct` returned by methods in
+// `HasWork` provides a `work_struct` that is the `work` field of a `delayed_work`, and the rest of
+// the `delayed_work` has the same access rules as its `work` field.
+unsafe impl<T, const ID: u64> RawDelayedWorkItem<ID> for Pin<KBox<T>>
+where
+    T: WorkItem<ID, Pointer = Self>,
+    T: HasDelayedWork<T, ID>,
+{
+}
+
 /// Returns the system work queue (`system_wq`).
 ///
 /// It is the one used by `schedule[_delayed]_work[_on]()`. Multi-CPU multi-threaded. There are

---
base-commit: 7204503c922cfdb4fcfce4a4ab61f4558a01a73b
change-id: 20250409-workqueue-delay-40eb0cd7c6d0
prerequisite-change-id: 20250617-opaque-from-raw-ac5b8ef6faa2:v2
prerequisite-patch-id: 10c681492e723b206b10b86744227a41c6fc8279
prerequisite-patch-id: 2bd3f821d3cbfd752fe5018bdbc4891004339baa

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


