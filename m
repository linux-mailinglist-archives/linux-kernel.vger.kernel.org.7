Return-Path: <linux-kernel+bounces-899086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1571AC56BEE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 11:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 335593B4E32
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E7A2DE6F8;
	Thu, 13 Nov 2025 10:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D3wRZ1g1"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B7F2DE700
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763028081; cv=none; b=kIgTTWXFwRrkeazGgG/vqK0ZkfhajolAGLv79/yPHVDXMvsZzQkb5ACeWSlU0yrkcAvgPkf7FE9xI+t8U7NFcDtbiZxYy6uP/i4kdGopqb+q8jF1iPTdOvG3/OnLfw96BmdfobKPGCzR2e3oMdG+CQHy+c0r3igg+btXG1wYs6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763028081; c=relaxed/simple;
	bh=l1/lGRU6QWtE1ji0evLZ6kXzVT69Z9Ki+win41xjeig=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kYpdT950l5KWWIJU46jry+dpYbRBNrQy3YPFQhtmT5OsOXHyzC7k/dhi+VY9Gk1I0UAj/99qkipFDdeOtoi5/MWVwx1ZHePZrhv2rwqkskcyjaOYhiSn2EZPMEOiJgLnpdCcKS+Rt3VruGKlaIZRuQeJPoY2eHsBWtPxW4Knszc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D3wRZ1g1; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-6430e4b5f04so740656a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 02:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763028078; x=1763632878; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=03pL0zzIHyKK2WTeQxTsKv3aVniqrabjazbbF5k53yA=;
        b=D3wRZ1g1KPcDBuXutuDgFdg+MDFdHzL8sCEa8wBeQfIDh22YteCGaZBKwhkkf4XcDu
         +viXzp9CtjshmB0QofqJk58J2XmgrrE4K5Jsbd/4lbyOUi/z5Iqfam06VUc6XOVMIa29
         sqXdX6W4BQhye6a6t8mRJzW2ZOa7Z9YuFHxHephPJi4TcrzwGBFfdE7LnOKSoBQ54myV
         bhk72gZKIS7dVeNK2xmUppABOMxR1n9qWTKr3rdaSmJg2yaYPTQZBKagzMGxQz0lhbYO
         LSpEN8sKp7DPge9IxhHpGNaCz0AtidaASzUYGLm4WFeWWnVwuZxNZsEmOCj+rwJfr2Ob
         jlgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763028078; x=1763632878;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=03pL0zzIHyKK2WTeQxTsKv3aVniqrabjazbbF5k53yA=;
        b=Q26XGGPtur8wnPxJuJB0BFLzPJc4u1fNOxPAgxQFSgXu7AD3chWufRY/5Zri882ydg
         Oy/pKGiUI9aAHBGubx3z83Kc3fFIheudqz3mgSLx71XtTRsqhDiPYsEai6PDBmAPop9A
         /kXcZt9VHwGdD50Psy0XiOcPRGyB6cNeGGP0iVNlWQ/Dcverxc3UnID5xHWpAq5Q5kkH
         +dvWrWJDk3QHC+QLsIzqBMAb0Lz/3posgSTbqdc2U80Wlax2JwJYI/gsnJJ3A40RLYNq
         TMei28aPGa9g3t3TX/KmakUgdCAKGNqDzuNwHbCo32LUUFRMId+9YeGOt3ZBdq4nZlxY
         T4hg==
X-Forwarded-Encrypted: i=1; AJvYcCXiLDgyQASvsBh5eP5EZIjnrXYsIZq1yHMiHYU3rN8yHwym5SHRMN8MRwwSAip0F9Xa05tMF+9mXC0he/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxO0XxaApR4rLtvHno3ORZtffbifZmXQ1lsD73gGS4eUizVbHg
	5O07xlxp7jkhNE8AY8bdKmdugYw8Ymcqxco291o5vMYzgMxe6e1xXJm4yVp1rIpkmVuPrvYEbJg
	yyAZnL/ac3Vo7nUQhlQ==
X-Google-Smtp-Source: AGHT+IFqw21bQymwrmtUD7X8lwWdZKRJR6b/npb91JTc8YHVlQ2yJB0q9zmoMBjX+k6quYlAWM1QZioP9Ur5O54=
X-Received: from ejcrg8.prod.google.com ([2002:a17:907:6b88:b0:b73:4279:3a04])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:1c01:b0:b73:54d8:7bc8 with SMTP id a640c23a62f3a-b7354d89206mr105452766b.59.1763028077954;
 Thu, 13 Nov 2025 02:01:17 -0800 (PST)
Date: Thu, 13 Nov 2025 10:01:07 +0000
In-Reply-To: <20251113-create-workqueue-v2-0-8b45277119bc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113-create-workqueue-v2-0-8b45277119bc@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=8091; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=l1/lGRU6QWtE1ji0evLZ6kXzVT69Z9Ki+win41xjeig=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpFaxqBR8EwdfIjIWZa2JfxNyOkKEqVmBqxLk6K
 3NFH5Gtn6KJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaRWsagAKCRAEWL7uWMY5
 RkWGD/9VeIBYcYedkXNFdbhZl1oHN81NP0QYcx59r1347zIBodkI7HkrCllfRaHE1tHE0FpgmU2
 SuXy0K4EPhpXSTC4T4rXn2kymXbj0Kn8J+tk5kdpGVCo9FXTEgNebQFc5YNns2o5dY3N9//VsP+
 kcR5fC64BTAUJdI+yHCjU/zs/G18JxQJ/QYqxMFUhe7bqbxb2LdoGGj9Zn4DeWQh835IYSnH3G2
 /7bW7awUrfAR7fNj4TDRY0j9Y6C/t0qVPP40/5u+fVHkVUIFH+WNFQH1f4OCTlmxFCn8DNbjcmh
 5b+ls9OHmfmKvs3gJIiBXGEhvhjmw2vJr35fq5z6wTAbwtweS90Yg20wKQamfCGv3LFURjVuwOI
 N0fPvLBWnjnF6+UzVF03yK62ODNk2WMD4R5E4NGcMAniANUbgedbUhtJpga5UIdGoJvYJtvrzLV
 sk67v76XeURUlhNxu2OuEQFZpoOK25hY7hsqwZuU0KTWHxwXFuVhYlDtJ3vInMCo6UEFj/VGdy9
 fuM2EDU4eSi1dHa2IukFf7Qkj7ntKhwY51TTrYjCFOWatoA8SY52Mm5mcm9syVKk7BlkYwXTdc9
 7IOple/E2Gvn8RByiTu7qaGA+5ueJw7nRiqAsxddIaFhtVUtCYhuI3BGNLPxjC2F7gaXL+gdVAu 8NVHD0xCvEj3c6g==
X-Mailer: b4 0.14.2
Message-ID: <20251113-create-workqueue-v2-2-8b45277119bc@google.com>
Subject: [PATCH v2 2/2] rust: workqueue: add creation of workqueues
From: Alice Ryhl <aliceryhl@google.com>
To: Tejun Heo <tj@kernel.org>, Miguel Ojeda <ojeda@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, John Hubbard <jhubbard@nvidia.com>, 
	Philipp Stanner <phasta@kernel.org>, Tamir Duberstein <tamird@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	Benno Lossin <lossin@kernel.org>
Content-Type: text/plain; charset="utf-8"

Creating workqueues is needed by various GPU drivers. Not only does it
give you better control over execution, it also allows devices to ensure
that all tasks have exited before the device is unbound (or similar) by
running the workqueue destructor.

A wrapper type Flags is provided for workqueue flags. It allows you to
build any valid flag combination, while using a type-level marker for
whether WQ_BH is used to prevent invalid flag combinations. The Flags wrapper
also forces you to explicitly pick one of percpu, unbound, or bh.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/helpers/workqueue.c |   6 ++
 rust/kernel/workqueue.rs | 185 ++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 188 insertions(+), 3 deletions(-)

diff --git a/rust/helpers/workqueue.c b/rust/helpers/workqueue.c
index b2b82753509bf5dbd0f4ddebb96a95a51e5976b1..a67ed284b062b29937f09303cb516e6322cc961a 100644
--- a/rust/helpers/workqueue.c
+++ b/rust/helpers/workqueue.c
@@ -12,3 +12,9 @@ void rust_helper_init_work_with_key(struct work_struct *work, work_func_t func,
 	INIT_LIST_HEAD(&work->entry);
 	work->func = func;
 }
+
+struct workqueue_struct *rust_helper_alloc_workqueue(const char *fmt, unsigned int flags,
+						      int max_active, const void *data)
+{
+	return alloc_workqueue(fmt, flags, max_active, data);
+}
diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
index 901102a8bca54c9fb58655d80fc9624b4dfe1dc1..313d897fe93ceb84844ce9b253edec837e60ba6d 100644
--- a/rust/kernel/workqueue.rs
+++ b/rust/kernel/workqueue.rs
@@ -186,7 +186,7 @@
 //! C header: [`include/linux/workqueue.h`](srctree/include/linux/workqueue.h)
 
 use crate::{
-    alloc::{AllocError, Flags},
+    alloc::{self, AllocError},
     container_of,
     prelude::*,
     sync::Arc,
@@ -194,7 +194,11 @@
     time::Jiffies,
     types::Opaque,
 };
-use core::marker::PhantomData;
+use core::{
+    marker::PhantomData,
+    ops::Deref,
+    ptr::NonNull, //
+};
 
 /// Creates a [`Work`] initialiser with the given name and a newly-created lock class.
 #[macro_export]
@@ -333,7 +337,7 @@ pub fn enqueue_delayed<W, const ID: u64>(&'static self, w: W, delay: Jiffies) ->
     /// This method can fail because it allocates memory to store the work item.
     pub fn try_spawn<T: 'static + Send + FnOnce()>(
         &self,
-        flags: Flags,
+        flags: alloc::Flags,
         func: T,
     ) -> Result<(), AllocError> {
         let init = pin_init!(ClosureWork {
@@ -346,6 +350,181 @@ pub fn try_spawn<T: 'static + Send + FnOnce()>(
     }
 }
 
+/// Workqueue flags.
+///
+/// A valid combination of workqueue flags contains one of the base flags (`WQ_UNBOUND`, `WQ_BH`,
+/// or `WQ_PERCPU`) and a combination of modifier flags that are compatible with the selected base
+/// flag.
+///
+/// For details, please refer to `Documentation/core-api/workqueue.rst`.
+#[repr(transparent)]
+#[derive(Copy, Clone)]
+pub struct Flags<const BH: bool>(bindings::wq_flags);
+
+// BH only methods
+impl Flags<true> {
+    /// Execute in bottom half (softirq) context.
+    #[inline]
+    pub const fn bh() -> Flags<true> {
+        Flags(bindings::wq_flags_WQ_BH)
+    }
+}
+
+// Non-BH only methods
+impl Flags<false> {
+    /// Not bound to any cpu.
+    #[inline]
+    pub const fn unbound() -> Flags<false> {
+        Flags(bindings::wq_flags_WQ_UNBOUND)
+    }
+
+    /// Bound to a specific cpu.
+    #[inline]
+    pub const fn percpu() -> Flags<false> {
+        Flags(bindings::wq_flags_WQ_PERCPU)
+    }
+
+    /// Allow this workqueue to be frozen during suspend.
+    #[inline]
+    pub const fn freezable(self) -> Self {
+        Flags(self.0 | bindings::wq_flags_WQ_FREEZABLE)
+    }
+
+    /// This workqueue may be used during memory reclaim.
+    #[inline]
+    pub const fn mem_reclaim(self) -> Self {
+        Flags(self.0 | bindings::wq_flags_WQ_MEM_RECLAIM)
+    }
+
+    /// Mark this workqueue as cpu intensive.
+    #[inline]
+    pub const fn cpu_intensive(self) -> Self {
+        Flags(self.0 | bindings::wq_flags_WQ_CPU_INTENSIVE)
+    }
+
+    /// Make this workqueue visible in sysfs.
+    #[inline]
+    pub const fn sysfs(self) -> Self {
+        Flags(self.0 | bindings::wq_flags_WQ_SYSFS)
+    }
+}
+
+// Methods for BH and non-BH.
+impl<const BH: bool> Flags<BH> {
+    /// High priority workqueue.
+    #[inline]
+    pub const fn highpri(self) -> Self {
+        Flags(self.0 | bindings::wq_flags_WQ_HIGHPRI)
+    }
+}
+
+/// An owned kernel work queue.
+///
+/// Dropping a workqueue blocks on all pending work.
+///
+/// # Invariants
+///
+/// `queue` points at a valid workqueue that is owned by this `OwnedQueue`.
+pub struct OwnedQueue {
+    queue: NonNull<Queue>,
+}
+
+#[expect(clippy::manual_c_str_literals)]
+impl OwnedQueue {
+    /// Allocates a new workqueue.
+    ///
+    /// The provided name is used verbatim as the workqueue name.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::c_str;
+    /// use kernel::workqueue::{OwnedQueue, Flags};
+    ///
+    /// let wq = OwnedQueue::new(c_str!("my-wq"), Flags::unbound().sysfs(), 0)?;
+    /// wq.try_spawn(
+    ///     GFP_KERNEL,
+    ///     || pr_warn!("Printing from my-wq"),
+    /// )?;
+    /// # Ok::<(), Error>(())
+    /// ```
+    #[inline]
+    pub fn new<const BH: bool>(
+        name: &CStr,
+        flags: Flags<BH>,
+        max_active: usize,
+    ) -> Result<OwnedQueue, AllocError> {
+        // SAFETY:
+        // * "%s\0" is compatible with passing the name as a c-string.
+        // * the flags argument does not include internal flags.
+        let ptr = unsafe {
+            bindings::alloc_workqueue(
+                b"%s\0".as_ptr(),
+                flags.0,
+                i32::try_from(max_active).unwrap_or(i32::MAX),
+                name.as_char_ptr().cast::<c_void>(),
+            )
+        };
+
+        Ok(OwnedQueue {
+            queue: NonNull::new(ptr).ok_or(AllocError)?.cast(),
+        })
+    }
+
+    /// Allocates a new workqueue.
+    ///
+    /// # Examples
+    ///
+    /// This example shows how to pass a Rust string formatter to the workqueue name, creating
+    /// workqueues with names such as `my-wq-1` and `my-wq-2`.
+    ///
+    /// ```
+    /// use kernel::alloc::AllocError;
+    /// use kernel::workqueue::{OwnedQueue, Flags};
+    ///
+    /// fn my_wq(num: u32) -> Result<OwnedQueue, AllocError> {
+    ///     OwnedQueue::new_fmt(format_args!("my-wq-{num}"), Flags::percpu(), 0)
+    /// }
+    /// ```
+    #[inline]
+    pub fn new_fmt<const BH: bool>(
+        name: core::fmt::Arguments<'_>,
+        flags: Flags<BH>,
+        max_active: usize,
+    ) -> Result<OwnedQueue, AllocError> {
+        // SAFETY:
+        // * "%pA\0" is compatible with passing an `Arguments` pointer.
+        // * the flags argument does not include internal flags.
+        let ptr = unsafe {
+            bindings::alloc_workqueue(
+                b"%pA\0".as_ptr(),
+                flags.0,
+                i32::try_from(max_active).unwrap_or(i32::MAX),
+                core::ptr::from_ref(&name).cast::<c_void>(),
+            )
+        };
+
+        Ok(OwnedQueue {
+            queue: NonNull::new(ptr).ok_or(AllocError)?.cast(),
+        })
+    }
+}
+
+impl Deref for OwnedQueue {
+    type Target = Queue;
+    fn deref(&self) -> &Queue {
+        // SAFETY: By the type invariants, this pointer references a valid queue.
+        unsafe { &*self.queue.as_ptr() }
+    }
+}
+
+impl Drop for OwnedQueue {
+    fn drop(&mut self) {
+        // SAFETY: The `OwnedQueue` is being destroyed, so we can destroy the workqueue it owns.
+        unsafe { bindings::destroy_workqueue(self.queue.as_ptr().cast()) }
+    }
+}
+
 /// A helper type used in [`try_spawn`].
 ///
 /// [`try_spawn`]: Queue::try_spawn

-- 
2.51.2.1041.gc1ab5b90ca-goog


