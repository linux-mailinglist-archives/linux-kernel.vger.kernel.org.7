Return-Path: <linux-kernel+bounces-887458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BA843C384A1
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 00:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C482E4F7DC3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 23:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8A829992A;
	Wed,  5 Nov 2025 23:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTk6P1vu"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F4B2F5316
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 23:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762383754; cv=none; b=MYtuONDszKnVRTPJEP9b2Nu5qtsOrebO8KZIwd80aQFA8CRRhIfkewcK+j8GzhkFdrCd8du62zI4+THpZi0Dl/cYnjUP5oyL2zqq+YBulHhhKq27wMS34FpKZhsYjhIFVgInEiapbk0sIy53dufhY7gihQmT7xn3GktkhMFW36U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762383754; c=relaxed/simple;
	bh=mFg9QLMAwyqIxa/N6WNggn20WoF/wqWYILNGfUHwvYw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oYjqpYYASPTjQtsOzC1NNSmAd9OYaNt2A3XAJTOZC+DKtMgoDKcY0TmC2bzFpU4s74lrQ3Yhw0eJBRTz5A2cMrDw9HcgAzdd+G/BFosuI0aHeDwWno6IJlXub7/Vo3cb/1K1rhbfg6MnGYOhFvVd6TF2wyhYd9Z70SaGCGVnNV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mTk6P1vu; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-33292adb180so365995a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 15:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762383752; x=1762988552; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WFJ1wrPBcxrrD+LBS55P13yiT8NfiLst30CpnCOiPfc=;
        b=mTk6P1vuXWUriJvC0nFh8CdhlAZVDPPqTdYbH2LlHcacney1GY1wo8Xd8jRNRXs/Ax
         HXgnpc1hlIhzQaKLc0ZA9xv58WrtVAuQ3dc6QKO/BgZyDjGffNyj3pJasyOjImxNhWvn
         zNCqoGOxAh7nXH9AWsiJR1TCXN5qUJ3pbyc22BeK1b9HqkIij/jBwdkehDpQPTfks3bM
         REjsHLyddO0H98deZXbCAS6ownS4w1ZpE+5B+G9HucbfGVEjAzaanmLN5otPR+Y/DX5L
         BpGVmfPo44NGSmx7MBip1U70gR0A+8nUkmSNcjpHZeMYG/kAWMiXjm5c4WtT7viLdHnd
         MsJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762383752; x=1762988552;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WFJ1wrPBcxrrD+LBS55P13yiT8NfiLst30CpnCOiPfc=;
        b=p/upGh/75P4fNZzSVJ3QB4EhFsX5qKugtBzUuhG1Eb5jNPZa+HsSBipgNE3nJmyX3v
         fbw+vmEiV/LQLOfdBOaBI4sVH+PaHiEWo1duUE61KOxbYxuSJF0e6yCz9x/vMa/mkUyS
         MwXBok8fHABYhkdoBQO3vifQEZ6xJ6aDRz5Qb3ZihZHvXuX6n49wUk8f0t0O7dQsDvhf
         o2FqPqdt+5p7vlRND3AWS4ABl00IP0PzR7owAmDumO75XL5V8Klc2zlRdgnn0nPWigXN
         0wUxLnYkslCjS/azaHX/ZQGkxkGMmtMNBk3jRjbeRwfbJJsnoNfmZ91+NYBcXnw7Geeg
         8wfg==
X-Forwarded-Encrypted: i=1; AJvYcCVfPk8fpniuXIRfpBqF328pQIsjCeocZ2sd4uesJ4oojYYxnQPpTMFUMVC0x5O4YJEOdU9QY28rGA2gEZA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi3wciCJsgJbVyucgxtQjlozx8QISD+TT+Iy7SFhZgePsSKGtQ
	C1ealVBCREJViEwdR3wP+Gq6F0WzUAbr91w24ruJLjz94m5sq9sXiEON
X-Gm-Gg: ASbGncurqcyB8iBmd4LzEf28yihHhiVyy9OCF3jTc7b/9DT0mV0qVhlhO+e0q6f/Hl+
	1V7SXTzA8M+dUhcEqJvqANww4Lwkk7FIHSyo2BZmTBNpT0TO3qpRMqWJQ2cDqBvj6S7zKPkbGvC
	klQVbDmwyRp4j4T2P5RqkwLmSU9cxTUT33CwBni4sbkozj/E0e/RKLreaxLvOs8bZF36F+yc5h0
	eeeu2MO9zPlWd5GTkPYB6kWertl8LY6MJF1dYEovKbA8fZI6UYsP3mNC2/bIHJL/3tdAme/VSd/
	ubb6EJlrgmdDaPk8PBxS2hBVoge/kLZKzzX12/Vj96Q3eIeB9PJl9tR29kVyUnSzl2lfLhITZQ+
	J2WOTiE33iw9gZJ2g8Q/WPNb4JJOBXoKrYR+u5NRs6nfIky3NVZJ0JgWfcXFdDleQSCcXXbJLoU
	SQHc+W59qtw+dPyEF6KP7OjCl111JvVdRD4g==
X-Google-Smtp-Source: AGHT+IE1c9+ZrzqLcSGm3uQ2ejRBT2CJMVQlT9ke7gOJ6htC5411VVsiXKPhB80c9d8mxSq7gHQUCw==
X-Received: by 2002:a17:903:1b65:b0:294:e8a0:382b with SMTP id d9443c01a7336-2962ae57374mr72286265ad.54.1762383752237;
        Wed, 05 Nov 2025 15:02:32 -0800 (PST)
Received: from mitchelllevy.localdomain ([131.107.147.147])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2965096839asm6325645ad.13.2025.11.05.15.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 15:02:31 -0800 (PST)
From: Mitchell Levy <levymitchell0@gmail.com>
Date: Wed, 05 Nov 2025 15:01:17 -0800
Subject: [PATCH v4 5/9] rust: percpu: introduce a rust API for dynamic
 per-CPU variables
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-rust-percpu-v4-5-984b1470adcb@gmail.com>
References: <20251105-rust-percpu-v4-0-984b1470adcb@gmail.com>
In-Reply-To: <20251105-rust-percpu-v4-0-984b1470adcb@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Andrew Morton <akpm@linux-foundation.org>, 
 Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
 Christoph Lameter <cl@linux.com>, Danilo Krummrich <dakr@kernel.org>, 
 Benno Lossin <lossin@kernel.org>, Yury Norov <yury.norov@gmail.com>, 
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: Tyler Hicks <code@tyhicks.com>, Allen Pais <apais@linux.microsoft.com>, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-mm@kvack.org, Mitchell Levy <levymitchell0@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762383744; l=9789;
 i=levymitchell0@gmail.com; s=20240719; h=from:subject:message-id;
 bh=mFg9QLMAwyqIxa/N6WNggn20WoF/wqWYILNGfUHwvYw=;
 b=rC6LvrXQz84xbSb5BvGzEQo3PK2NO2XHoHUt+ISh2JaHvuW2RktvXy7YCgzUy8bvkJ1wqFQWO
 bxVWrfmsXOSBxGpV0RbAHoOa2jK6XivWxBpY5qWUYmJnPND48kmTwbK
X-Developer-Key: i=levymitchell0@gmail.com; a=ed25519;
 pk=n6kBmUnb+UNmjVkTnDwrLwTJAEKUfs2e8E+MFPZI93E=

Dynamically allocated per-CPU variables are core to many of the
use-cases of per-CPU variables (e.g., ref counting). Add support for
them using the core `PerCpuPtr<T>` primitive, implementing the
`PerCpu<T>` trait.

Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Mitchell Levy <levymitchell0@gmail.com>
---
 rust/helpers/percpu.c         |  10 ++++
 rust/kernel/percpu.rs         |  30 ++++++++--
 rust/kernel/percpu/dynamic.rs | 130 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 166 insertions(+), 4 deletions(-)

diff --git a/rust/helpers/percpu.c b/rust/helpers/percpu.c
index a091389f730f..35656333dfae 100644
--- a/rust/helpers/percpu.c
+++ b/rust/helpers/percpu.c
@@ -7,3 +7,13 @@ void __percpu *rust_helper_alloc_percpu(size_t sz, size_t align)
 	return __alloc_percpu(sz, align);
 }
 
+void *rust_helper_per_cpu_ptr(void __percpu *ptr, unsigned int cpu)
+{
+	return per_cpu_ptr(ptr, cpu);
+}
+
+void rust_helper_on_each_cpu(smp_call_func_t func, void *info, int wait)
+{
+	on_each_cpu(func, info, wait);
+}
+
diff --git a/rust/kernel/percpu.rs b/rust/kernel/percpu.rs
index 2fba9a165636..294b8ffc4f62 100644
--- a/rust/kernel/percpu.rs
+++ b/rust/kernel/percpu.rs
@@ -1,14 +1,19 @@
 // SPDX-License-Identifier: GPL-2.0
 //! Per-CPU variables.
 //!
-//! See the [`crate::define_per_cpu!`] macro and the [`PerCpu<T>`] trait.
+//! See the [`crate::define_per_cpu!`] macro, the [`DynamicPerCpu`] type, and the [`PerCpu<T>`]
+//! trait.
 
 pub mod cpu_guard;
+mod dynamic;
 mod static_;
 
+#[doc(inline)]
+pub use dynamic::*;
 #[doc(inline)]
 pub use static_::*;
 
+use crate::cpu::CpuId;
 use crate::declare_extern_per_cpu;
 use crate::percpu::cpu_guard::CpuGuard;
 use crate::types::Opaque;
@@ -123,6 +128,23 @@ pub fn get_ptr(&self) -> *mut MaybeUninit<T> {
         // the invariant that self.0 is a valid offset into the per-CPU area.
         (this_cpu_area).wrapping_add(self.0 as usize).cast()
     }
+
+    /// Get a [`*mut MaybeUninit<T>`](MaybeUninit) to the per-CPU variable on the CPU represented
+    /// by `cpu`. Note that without some kind of synchronization, use of the returned pointer may
+    /// cause a data race. It is the caller's responsibility to use the returned pointer in a
+    /// reasonable way.
+    ///
+    /// # Returns
+    /// - The returned pointer is valid only if `self` is (that is, it points to a live allocation
+    ///   correctly sized and aligned to hold a `T`)
+    /// - The returned pointer is valid only if the bit corresponding to `cpu` is set in
+    ///   [`kernel::cpumask::Cpumask::possible_cpus()`].
+    pub fn get_remote_ptr(&self, cpu: CpuId) -> *mut MaybeUninit<T> {
+        // SAFETY: `bindings::per_cpu_ptr` is just doing pointer arithmetic. The returned pointer
+        // may not be valid (under the conditions specified in this function's documentation), but
+        // the act of producing the pointer is safe.
+        unsafe { bindings::per_cpu_ptr(self.0.cast(), cpu.as_u32()) }.cast()
+    }
 }
 
 // SAFETY: Sending a [`PerCpuPtr<T>`] to another thread is safe because as soon as it's sent, the
@@ -146,9 +168,9 @@ impl<T> Copy for PerCpuPtr<T> {}
 
 /// A trait representing a per-CPU variable.
 ///
-/// This is implemented for [`StaticPerCpu<T>`]. The main usage of this trait is to call
-/// [`Self::get_mut`] to get a [`PerCpuToken`] that can be used to access the underlying per-CPU
-/// variable.
+/// This is implemented for both [`StaticPerCpu<T>`] and [`DynamicPerCpu<T>`]. The main usage of
+/// this trait is to call [`Self::get_mut`] to get a [`PerCpuToken`] that can be used to access the
+/// underlying per-CPU variable.
 ///
 /// See [`PerCpuToken::with`].
 pub trait PerCpu<T> {
diff --git a/rust/kernel/percpu/dynamic.rs b/rust/kernel/percpu/dynamic.rs
new file mode 100644
index 000000000000..1863f31a2817
--- /dev/null
+++ b/rust/kernel/percpu/dynamic.rs
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: GPL-2.0
+//! Dynamically allocated per-CPU variables.
+
+use super::*;
+
+use crate::alloc::Flags;
+use crate::bindings::{alloc_percpu, free_percpu};
+use crate::cpumask::Cpumask;
+use crate::prelude::*;
+use crate::sync::Arc;
+use core::mem::{align_of, size_of, MaybeUninit};
+
+/// Represents a dynamic allocation of a per-CPU variable via `alloc_percpu`. Calls `free_percpu`
+/// when dropped.
+///
+/// # Contents
+/// Note that the allocated memory need not be initialized, and this type does not track when/if
+/// the memory location on any particular CPU has been initialized. This means that it cannot tell
+/// whether it should drop the *contents* of the allocation when it is dropped. It is up to the
+/// user to do this via something like [`core::ptr::drop_in_place`].
+pub struct PerCpuAllocation<T>(PerCpuPtr<T>);
+
+impl<T: Zeroable> PerCpuAllocation<T> {
+    /// Dynamically allocates a space in the per-CPU area suitably sized and aligned to hold a `T`,
+    /// initially filled with the zero value for `T`.
+    ///
+    /// Returns [`None`] under the same circumstances the C function `alloc_percpu` returns `NULL`.
+    pub fn new_zero() -> Option<PerCpuAllocation<T>> {
+        let ptr: *mut MaybeUninit<T> =
+            // SAFETY: No preconditions to call `alloc_percpu`; `MaybeUninit<T>` is
+            // `#[repr(transparent)]`, so we can cast a `*mut T` to it.
+            unsafe { alloc_percpu(size_of::<T>(), align_of::<T>()) }.cast();
+        if ptr.is_null() {
+            return None;
+        }
+
+        // alloc_percpu returns zero'ed memory
+        Some(Self(PerCpuPtr::new(ptr)))
+    }
+}
+
+impl<T> PerCpuAllocation<T> {
+    /// Makes a per-CPU allocation sized and aligned to hold a `T`.
+    ///
+    /// Returns [`None`] under the same circumstances the C function `alloc_percpu` returns `NULL`.
+    pub fn new_uninit() -> Option<PerCpuAllocation<T>> {
+        let ptr: *mut MaybeUninit<T> =
+            // SAFETY: No preconditions to call `alloc_percpu`; `MaybeUninit<T>` is
+            // `#[repr(transparent)]`, so we can cast a `*mut T` to it.
+            unsafe { alloc_percpu(size_of::<T>(), align_of::<T>()) }.cast();
+        if ptr.is_null() {
+            return None;
+        }
+
+        Some(Self(PerCpuPtr::new(ptr)))
+    }
+}
+
+impl<T> Drop for PerCpuAllocation<T> {
+    fn drop(&mut self) {
+        // SAFETY: self.0.0 was returned by alloc_percpu, and so was a valid pointer into
+        // the percpu area, and has remained valid by the invariants of PerCpuAllocation<T>.
+        unsafe { free_percpu(self.0 .0.cast()) }
+    }
+}
+
+/// Holds a dynamically-allocated per-CPU variable.
+#[derive(Clone)]
+pub struct DynamicPerCpu<T> {
+    // INVARIANT: `alloc` is `Some` unless this object is in the process of being dropped.
+    // INVARIANT: The allocation held by `alloc` is sized and aligned for a `T`.
+    // INVARIANT: The memory location in each CPU's per-CPU area pointed at by the alloc is
+    // initialized.
+    alloc: Option<Arc<PerCpuAllocation<T>>>,
+}
+
+impl<T: Zeroable> DynamicPerCpu<T> {
+    /// Allocates a new per-CPU variable
+    ///
+    /// # Arguments
+    /// * `flags` - [`Flags`] used to allocate an [`Arc`] that keeps track of the underlying
+    ///   [`PerCpuAllocation`].
+    pub fn new_zero(flags: Flags) -> Option<Self> {
+        let alloc: PerCpuAllocation<T> = PerCpuAllocation::new_zero()?;
+
+        let arc = Arc::new(alloc, flags).ok()?;
+
+        Some(Self { alloc: Some(arc) })
+    }
+}
+
+impl<T> PerCpu<T> for DynamicPerCpu<T> {
+    unsafe fn get_mut(&mut self, guard: CpuGuard) -> PerCpuToken<'_, T> {
+        // SAFETY:
+        // 1. Invariants of this type assure that `alloc` is `Some`.
+        // 2. The requirements of `PerCpu::get_mut` ensure that no other `[Checked]PerCpuToken`
+        //    exists on the current CPU.
+        // 3. The invariants of `DynamicPerCpu` ensure that the contents of the allocation are
+        //    initialized on each CPU.
+        // 4. The existence of a reference to the `PerCpuAllocation` ensures that the allocation is
+        //    live.
+        // 5. The invariants of `DynamicPerCpu` ensure that the allocation is sized and aligned for
+        //    a `T`.
+        unsafe { PerCpuToken::new(guard, &self.alloc.as_ref().unwrap_unchecked().0) }
+    }
+}
+
+impl<T> Drop for DynamicPerCpu<T> {
+    fn drop(&mut self) {
+        // SAFETY: This type's invariant ensures that `self.alloc` is `Some`.
+        let alloc = unsafe { self.alloc.take().unwrap_unchecked() };
+        if let Some(unique_alloc) = alloc.into_unique_or_drop() {
+            let ptr = unique_alloc.0;
+            for cpu in Cpumask::possible_cpus().iter() {
+                let remote_ptr = ptr.get_remote_ptr(cpu);
+                // SAFETY: `remote_ptr` is valid because the allocation it points to is still live,
+                // `cpu` appears in `Cpumask::possible_cpus()`, and the original allocation was
+                // sized and aligned for a `T`.
+                //
+                // This type's invariant ensures that the memory location in each CPU's per-CPU
+                // area pointed at by `alloc.0` has been initialized. We have a `UniqueArc`, so we
+                // know we're the only ones with a reference to the memory. These two facts
+                // together satisfy the requirements for `assume_init_drop`.
+                unsafe {
+                    (*remote_ptr).assume_init_drop();
+                }
+            }
+        }
+    }
+}

-- 
2.34.1


