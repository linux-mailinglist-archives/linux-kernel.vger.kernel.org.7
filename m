Return-Path: <linux-kernel+bounces-887461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FBCC384B0
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 00:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 22F834F488C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 23:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9FD2F6922;
	Wed,  5 Nov 2025 23:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6pHZc2N"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CAD2F60DF
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 23:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762383759; cv=none; b=Z71x1PaQr7u97oemGeTe/ywbWWYXijTKhNujCOXHahi0qSncR6pN48UP6VALghqBDNUCMhrD8BVYszR3abUsXR2NWGWDHEeJDidX6HCpHTdeG4FgDiTlodqkA1k2UQrfb6wbxYfkAzMRY1NlYkaSMlAb3wJ533dlLLjbMUM7BXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762383759; c=relaxed/simple;
	bh=N2+WVoODdmEMs33Jmf91+GyS5dqY4IkppGnGifhlfUw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pqEaFuX+FpnC32nb/X+ogR65BIIim/bD9wIK/TjfKdDYAi4UQbdcoVXCXh4NnIhv/xrkBpy+V963VV7e4wVuGAr4pBPnwEjGJ25WvACPvCrRbHG8gQOtzEN1TZGwRD8C8AY7RUzHc71WiURdj8d1IdM4SGkreiBilLtgeP1GtqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N6pHZc2N; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2947d345949so3124115ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 15:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762383757; x=1762988557; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kN9/UL7jFZa5RKDycC8BJ8oS9HZfDBeA7oqBiSHbTHc=;
        b=N6pHZc2Npl5eaVO2n/b7b04fm+P9pqcJhHCenZIGBiFSwNHKQ7Z+PfNceGuTlzVvZb
         EJv4CLqoG92u+KD3EufQgzAXGA3fCWCIM9TgcVyRwbnKY7P+bszKhlUIq+D9hdlGxbwR
         VjNet2wSSjVwiFo7DbG0UmROco+eGl3rsqZL9cUSTLsQYkAYuU1yy+six4gwq9NLOQIx
         SMpFphRCTc+UKhwo0cX2dnvRhBA0Ho6DpKdWx3Bka76dBaeaQIQbK2+5aKehNk+vdgXC
         37dv7d6IxSMaWww5ZS3gCTjxNnTQyLBpmlIn3VTxRYkFTsy7iNbZJBYQH9RX5m2WcLN9
         6diA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762383757; x=1762988557;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kN9/UL7jFZa5RKDycC8BJ8oS9HZfDBeA7oqBiSHbTHc=;
        b=Gxd/LFsZDTEeaxo/g2BOSsGYr57yxtkc/PzkGlGCOeroGsegG+d/wB2VRtArFKTaqb
         riuiciE4RP7wEnysUPFJXYsuVCVvbYcfAz3lw4Oitat/zMAIKxTzIX+Bd25mmV8WRoLa
         CS9E0JGhwu1MvB6ceJJJaRIsjZgdApXZ1Q9G/t/X9D7DagmpV0DZRVirWn7Dn6Xa2bmT
         Nv4anBepjbmSFkKrcCAjlw5ziVkGnS9YSfeZQgew5kyuMIFvnfT/X1B22ZzRS7Dd1mzK
         fq9ShjbhXaX3SKynvtCmo6cka0Q8Y/LnuHmIt71BsGwfUOqMbVA3XbpRdl2Cq0p/IlDm
         Htxg==
X-Forwarded-Encrypted: i=1; AJvYcCWnHGXswqQWRQTAVOVJm6NWplqxU+BbzeRVhhsbM7FgmThWICdp8ojV/c+u3ig+p30g5kyjIl6WMRNCe/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUFi0qijJNVlXdksO+5bSs0+b/99kXdoUhMrfwZfP/L5SI+ePa
	Zoboww34dE502k8MlarGGkbpQ6rCYOgwuDP3uyRzDeV6TvW+Yl4VpmZY
X-Gm-Gg: ASbGnct8Woi2Xr0syX2mZZVChSqH0gwHGoKX3smYUMrDaShQxOeaSmdXy5HzR2zrhBS
	GktEfYSyboWOrcw5Cn7avSlxbo4B/0foSooCzSQHceK5jkMdpO/hAzbfYvtXJ270u9Yb0Qs7HIi
	CNsTFboKV9igtLxzyWnLrH4HgsP4yq7+4TUYPHZIcGLhyxTZKUp+zaeej5uQLThnK09dd0WLizp
	7ul96dkZOeNCTikFycIxrOZfgg4/JDBLTL9ws/ELvIF1jqOaohCE8CgDwoh7R8N0QDOieUdE39+
	N/qY6hz5HKH8g3ZjG/ZQpT/xXwIXvH+StQ8I/Q8mnZGrzs++/xBX3DmWr72GXsrCefE8N75aWYT
	NisCpgqPIeRS+2eYaT67rxPtJM+Gr262iRIV5TBMMITDV+jlbgQi+nggJB9rNbMAcOU83Vlx7Ru
	jWPOAzeOXYCW6QT8nDNSm5hbxY45Vet1SGWw==
X-Google-Smtp-Source: AGHT+IFQkxzoaevtRmWsYeKKLp4dhk9UzDcwkiSO54MpJYOtGliGQSf/Idp109RNMzxqYIG9F5TfdA==
X-Received: by 2002:a17:902:ea09:b0:293:623:3260 with SMTP id d9443c01a7336-2962ae9b937mr61526055ad.57.1762383756270;
        Wed, 05 Nov 2025 15:02:36 -0800 (PST)
Received: from mitchelllevy.localdomain ([131.107.147.147])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2965096839asm6325645ad.13.2025.11.05.15.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 15:02:35 -0800 (PST)
From: Mitchell Levy <levymitchell0@gmail.com>
Date: Wed, 05 Nov 2025 15:01:20 -0800
Subject: [PATCH v4 8/9] rust: percpu: Add pin-hole optimizations for
 numerics
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-rust-percpu-v4-8-984b1470adcb@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762383744; l=10554;
 i=levymitchell0@gmail.com; s=20240719; h=from:subject:message-id;
 bh=N2+WVoODdmEMs33Jmf91+GyS5dqY4IkppGnGifhlfUw=;
 b=Z2rvF5hwLPBTS4udKgnmGgDRG4sF6Te7a0VTPOZNeZ9aQJCrtJODteQuQetfsAi6BEb6zjaF0
 IBremlr6jdEBRfajV62taxvmYwsiKbLAK9s6VdxCrwqQp8iWjg7VVVT
X-Developer-Key: i=levymitchell0@gmail.com; a=ed25519;
 pk=n6kBmUnb+UNmjVkTnDwrLwTJAEKUfs2e8E+MFPZI93E=

The C implementations of `this_cpu_add`, `this_cpu_sub`, etc., are
optimized to save an instruction by avoiding having to compute
`this_cpu_ptr(&x)` for some per-CPU variable `x`. For example, rather
than

    u64 *x_ptr = this_cpu_ptr(&x);
    *x_ptr += 5;

the implementation of `this_cpu_add` is clever enough to make use of the
fact that per-CPU variables are implemented on x86 via segment
registers, and so we can use only a single instruction (where we assume
`&x` is already in `rax`)

    add gs:[rax], 5

Add this optimization via a `PerCpuNumeric` type to enable code-reuse
between `DynamicPerCpu` and `StaticPerCpu`.

Signed-off-by: Mitchell Levy <levymitchell0@gmail.com>
---
 rust/kernel/percpu.rs         |   1 +
 rust/kernel/percpu/dynamic.rs |  10 ++-
 rust/kernel/percpu/numeric.rs | 138 ++++++++++++++++++++++++++++++++++++++++++
 samples/rust/rust_percpu.rs   |  36 +++++++++++
 4 files changed, 184 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/percpu.rs b/rust/kernel/percpu.rs
index 2db670c87fae..c1148cb36eff 100644
--- a/rust/kernel/percpu.rs
+++ b/rust/kernel/percpu.rs
@@ -6,6 +6,7 @@
 
 pub mod cpu_guard;
 mod dynamic;
+pub mod numeric;
 mod static_;
 
 #[doc(inline)]
diff --git a/rust/kernel/percpu/dynamic.rs b/rust/kernel/percpu/dynamic.rs
index a74c8841aeb2..99acbf6363f5 100644
--- a/rust/kernel/percpu/dynamic.rs
+++ b/rust/kernel/percpu/dynamic.rs
@@ -18,7 +18,7 @@
 /// the memory location on any particular CPU has been initialized. This means that it cannot tell
 /// whether it should drop the *contents* of the allocation when it is dropped. It is up to the
 /// user to do this via something like [`core::ptr::drop_in_place`].
-pub struct PerCpuAllocation<T>(PerCpuPtr<T>);
+pub struct PerCpuAllocation<T>(pub(super) PerCpuPtr<T>);
 
 impl<T: Zeroable> PerCpuAllocation<T> {
     /// Dynamically allocates a space in the per-CPU area suitably sized and aligned to hold a `T`,
@@ -119,6 +119,14 @@ pub fn new_with(val: &T, flags: Flags) -> Option<Self> {
     }
 }
 
+impl<T> DynamicPerCpu<T> {
+    /// Gets the allocation backing this per-CPU variable.
+    pub(crate) fn alloc(&self) -> &Arc<PerCpuAllocation<T>> {
+        // SAFETY: This type's invariant ensures that `self.alloc` is `Some`.
+        unsafe { self.alloc.as_ref().unwrap_unchecked() }
+    }
+}
+
 impl<T> PerCpu<T> for DynamicPerCpu<T> {
     unsafe fn get_mut(&mut self, guard: CpuGuard) -> PerCpuToken<'_, T> {
         // SAFETY:
diff --git a/rust/kernel/percpu/numeric.rs b/rust/kernel/percpu/numeric.rs
new file mode 100644
index 000000000000..e76461f05c66
--- /dev/null
+++ b/rust/kernel/percpu/numeric.rs
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0
+//! Pin-hole optimizations for [`PerCpu<T>`] where T is a numeric type.
+
+use super::*;
+use core::arch::asm;
+
+/// Represents a per-CPU variable that can be manipulated with machine-intrinsic numeric
+/// operations.
+pub struct PerCpuNumeric<'a, T> {
+    // INVARIANT: `ptr.0` is a valid offset into the per-CPU area and is initialized on all CPUs
+    // (since we don't have a CPU guard, we have to be pessimistic and assume we could be on any
+    // CPU).
+    ptr: &'a PerCpuPtr<T>,
+}
+
+macro_rules! impl_ops {
+    ($ty:ty, $reg:tt) => {
+        impl DynamicPerCpu<$ty> {
+            /// Returns a [`PerCpuNumeric`] that can be used to manipulate the underlying per-CPU
+            /// variable.
+            #[inline]
+            pub fn num(&mut self) -> PerCpuNumeric<'_, $ty> {
+                // The invariant is satisfied because `DynamicPerCpu`'s invariant guarantees that
+                // this pointer is valid and initialized on all CPUs.
+                PerCpuNumeric { ptr: &self.alloc().0 }
+            }
+        }
+        impl StaticPerCpu<$ty> {
+            /// Returns a [`PerCpuNumeric`] that can be used to manipulate the underlying per-CPU
+            /// variable.
+            #[inline]
+            pub fn num(&mut self) -> PerCpuNumeric<'_, $ty> {
+                // The invariant is satisfied because `StaticPerCpu`'s invariant guarantees that
+                // this pointer is valid and initialized on all CPUs.
+                PerCpuNumeric { ptr: &self.0 }
+            }
+        }
+
+        impl PerCpuNumeric<'_, $ty> {
+            /// Adds `rhs` to the per-CPU variable.
+            #[inline]
+            pub fn add(&mut self, rhs: $ty) {
+                // SAFETY: `self.ptr.0` is a valid offset into the per-CPU area (i.e., valid as a
+                // pointer relative to the `gs` segment register) by the invariants of this type.
+                unsafe {
+                    asm!(
+                        concat!("add gs:[{off}], {val:", $reg, "}"),
+                        off = in(reg) self.ptr.0.cast::<*mut $ty>(),
+                        val = in(reg) rhs,
+                    );
+                }
+            }
+        }
+        impl PerCpuNumeric<'_, $ty> {
+            /// Subtracts `rhs` from the per-CPU variable.
+            #[inline]
+            pub fn sub(&mut self, rhs: $ty) {
+                // SAFETY: `self.ptr.0` is a valid offset into the per-CPU area (i.e., valid as a
+                // pointer relative to the `gs` segment register) by the invariants of this type.
+                unsafe {
+                    asm!(
+                        concat!("sub gs:[{off}], {val:", $reg, "}"),
+                        off = in(reg) self.ptr.0.cast::<*mut $ty>(),
+                        val = in(reg) rhs,
+                    );
+                }
+            }
+        }
+    };
+}
+
+macro_rules! impl_ops_byte {
+    ($ty:ty) => {
+        impl DynamicPerCpu<$ty> {
+            /// Returns a [`PerCpuNumeric`] that can be used to manipulate the underlying per-CPU
+            /// variable.
+            #[inline]
+            pub fn num(&mut self) -> PerCpuNumeric<'_, $ty> {
+                // The invariant is satisfied because `DynamicPerCpu`'s invariant guarantees that
+                // this pointer is valid and initialized on all CPUs.
+                PerCpuNumeric { ptr: &self.alloc().0 }
+            }
+        }
+        impl StaticPerCpu<$ty> {
+            /// Returns a [`PerCpuNumeric`] that can be used to manipulate the underlying per-CPU
+            /// variable.
+            #[inline]
+            pub fn num(&mut self) -> PerCpuNumeric<'_, $ty> {
+                // The invariant is satisfied because `DynamicPerCpu`'s invariant guarantees that
+                // this pointer is valid and initialized on all CPUs.
+                PerCpuNumeric { ptr: &self.0 }
+            }
+        }
+
+        impl PerCpuNumeric<'_, $ty> {
+            /// Adds `rhs` to the per-CPU variable.
+            #[inline]
+            pub fn add(&mut self, rhs: $ty) {
+                // SAFETY: `self.ptr.0` is a valid offset into the per-CPU area (i.e., valid as a
+                // pointer relative to the `gs` segment register) by the invariants of this type.
+                unsafe {
+                    asm!(
+                        concat!("add gs:[{off}], {val}"),
+                        off = in(reg) self.ptr.0.cast::<*mut $ty>(),
+                        val = in(reg_byte) rhs,
+                    );
+                }
+            }
+        }
+        impl PerCpuNumeric<'_, $ty> {
+            /// Subtracts `rhs` from the per-CPU variable.
+            #[inline]
+            pub fn sub(&mut self, rhs: $ty) {
+                // SAFETY: `self.ptr.0` is a valid offset into the per-CPU area (i.e., valid as a
+                // pointer relative to the `gs` segment register) by the invariants of this type.
+                unsafe {
+                    asm!(
+                        concat!("sub gs:[{off}], {val}"),
+                        off = in(reg) self.ptr.0.cast::<*mut $ty>(),
+                        val = in(reg_byte) rhs,
+                    );
+                }
+            }
+        }
+    };
+}
+
+impl_ops_byte!(i8);
+impl_ops!(i16, "x");
+impl_ops!(i32, "e");
+impl_ops!(i64, "r");
+impl_ops!(isize, "r");
+
+impl_ops_byte!(u8);
+impl_ops!(u16, "x");
+impl_ops!(u32, "e");
+impl_ops!(u64, "r");
+impl_ops!(usize, "r");
diff --git a/samples/rust/rust_percpu.rs b/samples/rust/rust_percpu.rs
index be70ee2e513f..31ab3fcf5c6c 100644
--- a/samples/rust/rust_percpu.rs
+++ b/samples/rust/rust_percpu.rs
@@ -28,6 +28,26 @@
 define_per_cpu!(UPERCPU: u64 = 0);
 define_per_cpu!(CHECKED: RefCell<u64> = RefCell::new(0));
 
+macro_rules! make_optimization_test {
+    ($ty:ty) => {
+        let mut test: DynamicPerCpu<$ty> = DynamicPerCpu::new_zero(GFP_KERNEL).unwrap();
+        {
+            let _ = CpuGuard::new();
+            // SAFETY: No other usage of `test`
+            unsafe { test.get_mut(CpuGuard::new()) }.with(|val: &mut $ty| *val = 10);
+            test.num().add(1);
+            // SAFETY: No other usage of `test`
+            unsafe { test.get_mut(CpuGuard::new()) }.with(|val: &mut $ty| assert_eq!(*val, 11));
+            test.num().add(10);
+            // SAFETY: No other usage of `test`
+            unsafe { test.get_mut(CpuGuard::new()) }.with(|val: &mut $ty| assert_eq!(*val, 21));
+            test.num().sub(5);
+            // SAFETY: No other usage of `test`
+            unsafe { test.get_mut(CpuGuard::new()) }.with(|val: &mut $ty| assert_eq!(*val, 16));
+        }
+    };
+}
+
 impl kernel::Module for PerCpuMod {
     fn init(_module: &'static ThisModule) -> Result<Self, Error> {
         pr_info!("rust percpu test start\n");
@@ -208,6 +228,22 @@ fn init(_module: &'static ThisModule) -> Result<Self, Error> {
 
         pr_info!("rust dynamic percpu test done\n");
 
+        pr_info!("rust numeric optimizations test start\n");
+
+        make_optimization_test!(u8);
+        make_optimization_test!(u16);
+        make_optimization_test!(u32);
+        make_optimization_test!(u64);
+        make_optimization_test!(usize);
+
+        make_optimization_test!(i8);
+        make_optimization_test!(i16);
+        make_optimization_test!(i32);
+        make_optimization_test!(i64);
+        make_optimization_test!(isize);
+
+        pr_info!("rust numeric optimizations test done\n");
+
         // Return Err to unload the module
         Result::Err(EINVAL)
     }

-- 
2.34.1


