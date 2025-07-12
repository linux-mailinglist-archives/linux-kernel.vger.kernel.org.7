Return-Path: <linux-kernel+bounces-728813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E51B02D38
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 23:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92A7C7AF493
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 21:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94FB222DF86;
	Sat, 12 Jul 2025 21:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIU5p05M"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94D91F582F;
	Sat, 12 Jul 2025 21:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752355928; cv=none; b=Troiv5WmMV0W8OXZ1KB1A6QczT5686vz5oStpV72juSb1eoIlyFCT3GcApykZS660hSy+nmg2ckctxMMpl/VdgIuB2/pY9ierBb728zH2tzHZDr7b58IivGb0yHPlPC6d4zptQxzboFmsO4oNhGa4Mt2E3MNjcAv2fsahuvJlv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752355928; c=relaxed/simple;
	bh=/wdff0O+TBccIF+YWwxyFnAcyvOePCDxb+KptptoB68=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FI2NSIydaOGz6epNV6Fr+c5UQC8SUE5tlRXJjNfGpEr3XDwHbJP+Z1t0s0gYgP2PBhUuk6hkS9U0RrnTLy1yhrNVR60ES0No9TnceMa7xrkpODGCT0+25J5wHadTR6B2rrfOv/iwxzoK5HakQw3jTNK958x2jT2Unl7p5oICKjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FIU5p05M; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-747c2cc3419so2796890b3a.2;
        Sat, 12 Jul 2025 14:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752355926; x=1752960726; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CTtoMD2jUnmzV6fdblunt8Pya7UDWPcBKIFiwvtZyXU=;
        b=FIU5p05MWYNEzGuiczheuK2Fua0X4Vf/LuLKyT5yzurMPfEDLynPP5y40kPa/QTxa+
         Y2LYLpMQKGBMclbIWRQH5Zvow9HSt7N9zM8RoaXrMLTZI5ahbk7gL37J//Zz2QEQXb2e
         R+YwX9c7/BRC6fARiSX72SisOuv6Xkf1Cs3zRZpShRX4AtyKJ1ATA/nyxs1gEKyUIdeJ
         +w5lDK1QEKqgIUWyoiwt/wVitOWdga3+41Ql7QqfUKnlrJvQ4vpaka3f0pFpkdgZYu0u
         YfO8toymYyVo+4fmWvDUXE51ZrAssmXqAWiXzy/T6+4cNuOjJk0ztp/SXCazAYl3sQoe
         jQQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752355926; x=1752960726;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CTtoMD2jUnmzV6fdblunt8Pya7UDWPcBKIFiwvtZyXU=;
        b=a4jUhgUgXTnj6ynmqPweeYOTs4cDs1353UxURO0k0WVMFei1gO7qQLBTHn36RIyjMh
         66qVqujdvpHYRJlkCobcOn/yoH9p1Cd0YOTG19n9AFm+Y2sjgJdE/ALpJEtPm74aH4wF
         giJlmm3ye7kMWBVA6WwaLhWtdN5Yfhq/xMbMsXeHyFyzaWnUxwLOX5AtnTuFCCXYy5dr
         q1as9g8yhrDUnDd5gWx4kZCSORYEEw7whqn+kjAPDxr1054oVtjOB7DHx4yBnxEOwKUk
         GOqAuudDUmkSX+S6nVK8SVDF4UFewfcwMHt0QaSmVxaO9PpHrRBxwLZgrkMRDEoOBBpG
         AWSw==
X-Forwarded-Encrypted: i=1; AJvYcCVz/1U8KiPCmDJhYa0bOQvUt05Lw9D9t8wN2TUIlyxL4PMaKu0zMGRK1zWX+mROxj1TbwseKFXXR6fwHqD7qA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwFMI0MHdj5A6y4aWGit72eQkU5So568opHtVf7cnttgkJppkcF
	Vn1GwLaCRfY/5qyjODMG8FfqHHY0Leiih5LskTlGc5jsk8XLy8qN+dh6
X-Gm-Gg: ASbGnct26ZPrtCMpX4lSY9Dms5W1SN9h/O8YqkFV5bx5JghEX192RTYQhx45mqaOBSs
	cIr4jGHj7aIqqm0kTi70wQ2088SXneXznPAjo5yjEoYIDMAU7Ub+cDS6YDOIAzt7ZoIGJv32fTP
	HfgEvCyIWmB/GtrujH347UNtRRzYlZ0W+R55oJsPqDFp/CaH0/yL7R40ng0WvGquWo3m+XUh32F
	Ay40rhmnZ/kuNn7FiYuFHOG4sgadBh7ng1QKiaja0ttJjBKj8mMXGlJFKzXkgS3j1vKauKAh3/r
	BFHqniAejdDMnMJSHUdJtrf7Zpkdv+ec6BgzpRBxFAuEwiqHj+22CIakh37aQ3PdInT9f0bENW7
	MD3q9xC/K0FPlOgm7ZX/ri40gXcKr1RH/C7WppMCYWHfNNvzCPhgjxWiG
X-Google-Smtp-Source: AGHT+IHm5qpR1gjPtQZ/rA3SjPJLCrptEAwSAPqdZIC/RIhV1B17wk9gihcdL3O+6GYe4cBg0KSDew==
X-Received: by 2002:a17:90a:e18e:b0:312:1ae9:1529 with SMTP id 98e67ed59e1d1-31c4cd8b792mr13311488a91.27.1752355925629;
        Sat, 12 Jul 2025 14:32:05 -0700 (PDT)
Received: from mitchelllevy.localdomain ([174.127.224.194])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3eb65aa2sm8003935a91.40.2025.07.12.14.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jul 2025 14:32:05 -0700 (PDT)
From: Mitchell Levy <levymitchell0@gmail.com>
Date: Sat, 12 Jul 2025 14:31:12 -0700
Subject: [PATCH v2 1/5] rust: percpu: introduce a rust API for per-CPU
 variables
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250712-rust-percpu-v2-1-826f2567521b@gmail.com>
References: <20250712-rust-percpu-v2-0-826f2567521b@gmail.com>
In-Reply-To: <20250712-rust-percpu-v2-0-826f2567521b@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Andrew Morton <akpm@linux-foundation.org>, 
 Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
 Christoph Lameter <cl@linux.com>, Danilo Krummrich <dakr@kernel.org>, 
 Benno Lossin <lossin@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-mm@kvack.org, Mitchell Levy <levymitchell0@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752355923; l=15933;
 i=levymitchell0@gmail.com; s=20240719; h=from:subject:message-id;
 bh=/wdff0O+TBccIF+YWwxyFnAcyvOePCDxb+KptptoB68=;
 b=fGprdJqyWMecWZn0BZns5u9xCisKn6z932FGaZjQybSNKSx6RtIY/nAITGYWL2SRjzCB7MQIi
 XRcE08T71eXAgh4d8Zxj22bRAI+gzPsvVUhbxuCfGiO09XNkEGjbYkw
X-Developer-Key: i=levymitchell0@gmail.com; a=ed25519;
 pk=n6kBmUnb+UNmjVkTnDwrLwTJAEKUfs2e8E+MFPZI93E=

Add a `CpuGuard` type that disables preemption for its lifetime. Add a
`PerCpuAllocation` type used to track dynamic allocations. Add a
`define_per_cpu!` macro to create static per-CPU allocations. Add
`DynamicPerCpu` and `StaticPerCpu` to provide a high-level API. Add a
`PerCpu` trait to unify the dynamic and static cases.

Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Mitchell Levy <levymitchell0@gmail.com>
---
 rust/helpers/helpers.c          |   2 +
 rust/helpers/percpu.c           |   9 ++
 rust/helpers/preempt.c          |  14 ++
 rust/kernel/lib.rs              |   3 +
 rust/kernel/percpu.rs           | 308 ++++++++++++++++++++++++++++++++++++++++
 rust/kernel/percpu/cpu_guard.rs |  35 +++++
 6 files changed, 371 insertions(+)

diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 0f1b5d115985..d56bbe6334d3 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -29,7 +29,9 @@
 #include "page.c"
 #include "platform.c"
 #include "pci.c"
+#include "percpu.c"
 #include "pid_namespace.c"
+#include "preempt.c"
 #include "rbtree.c"
 #include "rcu.c"
 #include "refcount.c"
diff --git a/rust/helpers/percpu.c b/rust/helpers/percpu.c
new file mode 100644
index 000000000000..a091389f730f
--- /dev/null
+++ b/rust/helpers/percpu.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/percpu.h>
+
+void __percpu *rust_helper_alloc_percpu(size_t sz, size_t align)
+{
+	return __alloc_percpu(sz, align);
+}
+
diff --git a/rust/helpers/preempt.c b/rust/helpers/preempt.c
new file mode 100644
index 000000000000..2c7529528ddd
--- /dev/null
+++ b/rust/helpers/preempt.c
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/preempt.h>
+
+void rust_helper_preempt_disable(void)
+{
+	preempt_disable();
+}
+
+void rust_helper_preempt_enable(void)
+{
+	preempt_enable();
+}
+
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 6b4774b2b1c3..733f9ff8b888 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -95,6 +95,9 @@
 pub mod page;
 #[cfg(CONFIG_PCI)]
 pub mod pci;
+// Only x86_64 is supported by percpu for now
+#[cfg(CONFIG_X86_64)]
+pub mod percpu;
 pub mod pid_namespace;
 pub mod platform;
 pub mod prelude;
diff --git a/rust/kernel/percpu.rs b/rust/kernel/percpu.rs
new file mode 100644
index 000000000000..7dfceb6aefd7
--- /dev/null
+++ b/rust/kernel/percpu.rs
@@ -0,0 +1,308 @@
+// SPDX-License-Identifier: GPL-2.0
+//! This module contains abstractions for creating and using per-CPU variables from Rust.
+//! See the define_per_cpu! macro and the DynamicPerCpu<T> type, as well as the PerCpu<T> trait.
+pub mod cpu_guard;
+
+use bindings::{alloc_percpu, free_percpu};
+
+use crate::alloc::Flags;
+use crate::percpu::cpu_guard::CpuGuard;
+use crate::prelude::*;
+use crate::sync::Arc;
+
+use core::arch::asm;
+use core::mem::{align_of, size_of};
+
+use ffi::c_void;
+
+/// A per-CPU pointer; that is, an offset into the per-CPU area. Note that this type is NOT a smart
+/// pointer, it does not manage the allocation.
+pub struct PerCpuPtr<T>(*mut T);
+
+/// Represents a dynamic allocation of a per-CPU variable via alloc_percpu. Calls free_percpu when
+/// dropped.
+pub struct PerCpuAllocation<T>(PerCpuPtr<T>);
+
+/// Holds a dynamically-allocated per-CPU variable.
+pub struct DynamicPerCpu<T> {
+    alloc: Arc<PerCpuAllocation<T>>,
+}
+
+/// Holds a statically-allocated per-CPU variable.
+pub struct StaticPerCpu<T>(PerCpuPtr<T>);
+
+/// Represents exclusive access to the memory location pointed at by a particular PerCpu<T>.
+pub struct PerCpuToken<'a, T> {
+    _guard: CpuGuard,
+    ptr: &'a PerCpuPtr<T>,
+}
+
+/// A wrapper used for declaring static per-CPU variables. These symbols are "virtual" in that the
+/// linker uses them to generate offsets into each CPU's per-CPU area, but shouldn't be read
+/// from/written to directly. The fact that the statics are immutable prevents them being written
+/// to (generally), this struct having _val be non-public prevents reading from them.
+///
+/// The end-user of the per-CPU API should make use of the define_per_cpu! macro instead of
+/// declaring variables of this type directly.
+#[repr(transparent)]
+pub struct StaticPerCpuSymbol<T> {
+    _val: T, // generate a correctly sized type
+}
+
+impl<T> PerCpuPtr<T> {
+    /// Makes a new PerCpuPtr from a raw per-CPU pointer.
+    ///
+    /// # Safety
+    /// `ptr` must be a valid per-CPU pointer.
+    pub unsafe fn new(ptr: *mut T) -> Self {
+        Self(ptr)
+    }
+
+    /// Get a `&mut T` to the per-CPU variable represented by `&self`
+    ///
+    /// # Safety
+    /// The returned `&mut T` must follow Rust's aliasing rules. That is, no other `&(mut) T` may
+    /// exist that points to the same location in memory. In practice, this means that `get_ref`
+    /// must not be called on another `PerCpuPtr<T>` that is a copy/clone of `&self` for as long as
+    /// the returned reference lives.
+    ///
+    /// CPU preemption must be disabled before calling this function and for the lifetime of the
+    /// returned reference. Otherwise, the returned &mut T might end up being a reference to a
+    /// different CPU's per-CPU area, causing the potential for a data race.
+    #[allow(clippy::mut_from_ref)] // Safety requirements prevent aliasing issues
+    pub unsafe fn get_ref(&self) -> &mut T {
+        let this_cpu_off_pcpu = core::ptr::addr_of!(this_cpu_off);
+        let mut this_cpu_area: *mut c_void;
+        // SAFETY: gs + this_cpu_off_pcpu is guaranteed to be a valid pointer because `gs` points
+        // to the per-CPU area and this_cpu_off_pcpu is a valid per-CPU allocation.
+        unsafe {
+            asm!(
+                "mov {out}, gs:[{off_val}]",
+                off_val = in(reg) this_cpu_off_pcpu,
+                out = out(reg) this_cpu_area,
+            )
+        };
+        // SAFETY: this_cpu_area + self.0 is guaranteed to be a valid pointer by the per-CPU
+        // subsystem and the invariant that self.0 is a valid offset into the per-CPU area.
+        //
+        // We know no-one else has a reference to the underlying pcpu variable because of the
+        // safety requirements of this function.
+        unsafe { &mut *((this_cpu_area).wrapping_add(self.0 as usize) as *mut T) }
+    }
+}
+
+impl<T> Clone for PerCpuPtr<T> {
+    fn clone(&self) -> Self {
+        *self
+    }
+}
+
+/// PerCpuPtr is just a pointer, so it's safe to copy.
+impl<T> Copy for PerCpuPtr<T> {}
+
+impl<T: Zeroable> PerCpuAllocation<T> {
+    /// Dynamically allocates a space in the per-CPU area suitably sized and aligned to hold a `T`.
+    ///
+    /// Returns `None` under the same circumstances the C function `alloc_percpu` returns `NULL`.
+    pub fn new() -> Option<PerCpuAllocation<T>> {
+        // SAFETY: No preconditions to call alloc_percpu
+        let ptr: *mut T = unsafe { alloc_percpu(size_of::<T>(), align_of::<T>()) } as *mut T;
+        if ptr.is_null() {
+            return None;
+        }
+
+        Some(Self(PerCpuPtr(ptr)))
+    }
+}
+
+impl<T> Drop for PerCpuAllocation<T> {
+    fn drop(&mut self) {
+        // SAFETY: self.0.0 was returned by alloc_percpu, and so was a valid pointer into
+        // the percpu area, and has remained valid by the invariants of PerCpuAllocation<T>.
+        unsafe { free_percpu(self.0 .0 as *mut c_void) }
+    }
+}
+
+/// A trait representing a per-CPU variable. This is implemented for both `StaticPerCpu<T>` and
+/// `DynamicPerCpu<T>`. The main usage of this trait is to call `get` to get a `PerCpuToken` that
+/// can be used to access the underlying per-CPU variable. See `PerCpuToken::with`.
+///
+/// # Safety
+/// The returned value from `ptr` must be valid for the lifetime of `&mut self`.
+pub unsafe trait PerCpu<T> {
+    /// Gets a `PerCpuPtr<T>` to the per-CPU variable represented by `&mut self`
+    ///
+    /// # Safety
+    /// `self` may be doing all sorts of things to track when the underlying per-CPU variable can
+    /// be deallocated. You almost certainly shouldn't be calling this function directly (it's
+    /// essentially an implementation detail of the trait), and you certainly shouldn't be making
+    /// copies of the returned `PerCpuPtr<T>` that may outlive `&mut self`.
+    ///
+    /// Implementers of this trait must ensure that the returned `PerCpuPtr<T>` is valid for the
+    /// lifetime of `&mut self`.
+    unsafe fn ptr(&mut self) -> &PerCpuPtr<T>;
+
+    /// Produces a token, asserting that the holder has exclusive access to the underlying memory
+    /// pointed to by `self`
+    ///
+    /// # Safety
+    /// `func` (or its callees that execute on the same CPU) may not, for any `x: PerCpu<T>` that
+    /// is a `clone` of `&mut self` (or, for a statically allocated variable, a `StaticPerCpu<T>`
+    /// that came from the same `define_per_cpu!`):
+    /// - call `x.get()`
+    /// - make use of the value returned by `x.ptr()`
+    ///
+    /// `func` and its callees must not access or modify the memory associated with `&mut self`'s
+    /// allocation in the per-CPU area, except via (reborrows of) the reference passed to `func`.
+    ///
+    /// The underlying per-CPU variable cannot ever be mutated from an interrupt context, unless
+    /// irqs are disabled for the lifetime of the returned `PerCpuToken`.
+    unsafe fn get(&mut self, guard: CpuGuard) -> PerCpuToken<'_, T> {
+        PerCpuToken {
+            _guard: guard,
+            // SAFETY: The lifetime of the returned `PerCpuToken<'_, T>` is bounded by the lifetime
+            // of `&mut self`.
+            ptr: unsafe { self.ptr() },
+        }
+    }
+}
+
+impl<T> StaticPerCpu<T> {
+    /// Creates a new PerCpu<T> pointing to the statically allocated variable at `ptr`. End-users
+    /// should probably be using the `unsafe_get_per_cpu!` macro instead of calling this function.
+    ///
+    /// # Safety
+    /// `ptr` must be a valid pointer to a per-CPU variable. This means that it must be a valid
+    /// offset into the per-CPU area, and that the per-CPU area must be suitably sized and aligned
+    /// to hold a `T`.
+    pub unsafe fn new(ptr: *mut T) -> Self {
+        Self(PerCpuPtr(ptr))
+    }
+}
+
+// SAFETY: The `PerCpuPtr<T>` returned by `ptr` is valid for the lifetime of `self` (and in fact,
+// forever).
+unsafe impl<T> PerCpu<T> for StaticPerCpu<T> {
+    unsafe fn ptr(&mut self) -> &PerCpuPtr<T> {
+        &self.0
+    }
+}
+
+impl<T> Clone for StaticPerCpu<T> {
+    fn clone(&self) -> Self {
+        Self(self.0)
+    }
+}
+
+impl<T: Zeroable> DynamicPerCpu<T> {
+    /// Allocates a new per-CPU variable
+    ///
+    /// # Arguments
+    /// * `flags` - Flags used to allocate an `Arc` that keeps track of the underlying
+    ///   `PerCpuAllocation`.
+    pub fn new(flags: Flags) -> Option<Self> {
+        let alloc: PerCpuAllocation<T> = PerCpuAllocation::new()?;
+
+        let arc = Arc::new(alloc, flags).ok()?;
+
+        Some(Self { alloc: arc })
+    }
+}
+
+impl<T> DynamicPerCpu<T> {
+    /// Wraps a `PerCpuAllocation<T>` in a `PerCpu<T>`
+    ///
+    /// # Arguments
+    /// * `alloc` - The allocation to use
+    /// * `flags` - The flags used to allocate an `Arc` that keeps track of the `PerCpuAllocation`.
+    pub fn new_from_allocation(alloc: PerCpuAllocation<T>, flags: Flags) -> Option<Self> {
+        let arc = Arc::new(alloc, flags).ok()?;
+        Some(Self { alloc: arc })
+    }
+}
+
+// SAFETY: The `PerCpuPtr<T>` returned by `ptr` is valid for the lifetime of `self` because we
+// don't deallocate the underlying `PerCpuAllocation` until `self` is dropped.
+unsafe impl<T> PerCpu<T> for DynamicPerCpu<T> {
+    unsafe fn ptr(&mut self) -> &PerCpuPtr<T> {
+        &self.alloc.0
+    }
+}
+
+impl<T> Clone for DynamicPerCpu<T> {
+    fn clone(&self) -> Self {
+        Self {
+            alloc: self.alloc.clone(),
+        }
+    }
+}
+
+impl<T> PerCpuToken<'_, T> {
+    /// Immediately invokes `func` with a `&mut T` that points at the underlying per-CPU variable
+    /// that `&mut self` represents.
+    pub fn with<U>(&mut self, func: U)
+    where
+        U: FnOnce(&mut T),
+    {
+        // SAFETY: The existence of a PerCpuToken means that the requirements for get_ref are
+        // satisfied.
+        func(unsafe { self.ptr.get_ref() });
+    }
+}
+
+/// define_per_cpu! is analogous to the C DEFINE_PER_CPU macro in that it lets you create a
+/// statically allocated per-CPU variable.
+///
+/// # Example
+/// ```
+/// use kernel::define_per_cpu;
+/// use kernel::percpu::StaticPerCpuSymbol;
+///
+/// define_per_cpu!(pub MY_PERCPU: u64 = 0);
+/// ```
+#[macro_export]
+macro_rules! define_per_cpu {
+    ($vis:vis $id:ident: $ty:ty = $expr:expr) => {
+        $crate::macros::paste! {
+            // Expand $expr outside of the unsafe block to avoid silently allowing unsafe code to be
+            // used without a user-facing unsafe block
+            static [<__INIT_ $id>]: $ty = $expr;
+
+            // SAFETY: StaticPerCpuSymbol<T> is #[repr(transparent)], so we can freely convert from T
+            #[link_section = ".data..percpu"]
+            $vis static $id: StaticPerCpuSymbol<$ty> = unsafe {
+                core::mem::transmute::<$ty, StaticPerCpuSymbol<$ty>>([<__INIT_ $id>])
+            };
+        }
+    };
+}
+
+/// Gets a `StaticPerCpu<T>` from a symbol declared with `define_per_cpu!` or
+/// `declare_extern_per_cpu!`.
+///
+/// # Arguments
+/// * `ident` - The identifier declared
+///
+/// # Safety
+/// `$id` must be declared with either `define_per_cpu!` or `declare_extern_per_cpu!`, and the
+/// returned value must be stored in a `StaticPerCpu<T>` where `T` matches the declared type of
+/// `$id`.
+#[macro_export]
+macro_rules! unsafe_get_per_cpu {
+    ($id:ident) => {{
+        $crate::percpu::StaticPerCpu::new((&$id) as *const _ as *mut _)
+    }};
+}
+
+/// Declares a StaticPerCpuSymbol corresponding to a per-CPU variable defined in C. Be sure to read
+/// the safety requirements of `PerCpu::get`.
+#[macro_export]
+macro_rules! declare_extern_per_cpu {
+    ($id:ident: $ty:ty) => {
+        extern "C" {
+            static $id: StaticPerCpuSymbol<$ty>;
+        }
+    };
+}
+
+declare_extern_per_cpu!(this_cpu_off: u64);
diff --git a/rust/kernel/percpu/cpu_guard.rs b/rust/kernel/percpu/cpu_guard.rs
new file mode 100644
index 000000000000..14c04b12e7f0
--- /dev/null
+++ b/rust/kernel/percpu/cpu_guard.rs
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0
+//! Contains abstractions for disabling CPU preemption. See `CpuGuard`.
+
+/// A RAII guard for bindings::preempt_disable and bindings::preempt_enable. Guarantees preemption
+/// is disabled for as long as this object exists.
+pub struct CpuGuard {
+    // Don't make one without using new()
+    _phantom: (),
+}
+
+impl CpuGuard {
+    /// Create a new CpuGuard. Disables preemption for its lifetime.
+    pub fn new() -> Self {
+        // SAFETY: There are no preconditions required to call preempt_disable
+        unsafe {
+            bindings::preempt_disable();
+        }
+        CpuGuard { _phantom: () }
+    }
+}
+
+impl Default for CpuGuard {
+    fn default() -> Self {
+        Self::new()
+    }
+}
+
+impl Drop for CpuGuard {
+    fn drop(&mut self) {
+        // SAFETY: There are no preconditions required to call preempt_enable
+        unsafe {
+            bindings::preempt_enable();
+        }
+    }
+}

-- 
2.34.1


