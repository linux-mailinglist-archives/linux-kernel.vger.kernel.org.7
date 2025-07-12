Return-Path: <linux-kernel+bounces-728817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C477B02D3C
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 23:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C81E34E0B63
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 21:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18309232785;
	Sat, 12 Jul 2025 21:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWV9vpek"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BFF22F16C;
	Sat, 12 Jul 2025 21:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752355932; cv=none; b=T2cSUgVVqGAAmyQOb7GV5riRQ1tvPHHRa7kmbdff8WSA4QAXsD5vtZ0otY2EujizZq+WBDJxP2pjPI8kN8MTEiVVjAh1lYoC/VLpvXn21mzZKKCU5uekirdmzHaH0TJARLTPWs2xUAz/6jS5a4LPC8Ydx0JJ5HYTNj8KxGHcqHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752355932; c=relaxed/simple;
	bh=Yhc2AZNWstxq/JmR6oLcJC1JQH1zZ60L+8ZJ13d/Yes=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sWku+16VaYVSVJZq6zVS+8e0Wo9Atmbz97Zt+p0lX7rn8l/eyUyi3kogmbnkfgCTq8AbQTQqX+O404ItmAdXwjbqlSqifcAx/JA5AdbyGi3uQDQqotmObARIbckcHBTlgT3ja2LTdKjxzD8/dX5xTQafawPjl6uieehC9MXNouo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iWV9vpek; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-313eeb77b1fso2719187a91.1;
        Sat, 12 Jul 2025 14:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752355929; x=1752960729; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7j+nFClWMYu+z4RxyaBNy1i8eSeqUJQPpZ3XTZUjlQs=;
        b=iWV9vpekQ6CHjffOM4MnleRPqDyO/F6tvsuWh146EKFndw+rjulJKmoGdpW4lAft+E
         QvQqT8F+GgxxYWx5lguD5Lcn7JDJ6i8yphB+yf55f0lusHbitPtHxCm313Skb8WtGhgL
         vymKSzMPSYQ2LM2TsI3QWHvBYDt4kBAQGOLisONu/X7Ikfydpd3i4lukzZGzO+58Gtn9
         tKrh4xE+f17Cue2IBLztHhl1B4Iek7Pe4Z9Te5Z4TzAqigEQ0a4vz8uyacJz6Ieh5h4g
         rGpGtTAneRQ6jRRbXuzybvjK3vpJFQ6zvJT8g95UKkQ0Z8gemb0VNl/syh3bl1X9p1Dp
         aZ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752355929; x=1752960729;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7j+nFClWMYu+z4RxyaBNy1i8eSeqUJQPpZ3XTZUjlQs=;
        b=QhX1svdStuOoA1Ne5/7L7Sq39rQfRggNErAE2HnOIZgZGhVPxcR3hN4ekBDiOnBx8y
         G8S7/HQ2QKoDt81+jy8thI2AsS9y9gS6HOjF0ee9qRDIgIypiFiWzafMWxPjZCOdhqNT
         rKJJ5NSpKPM+JwnnNJwIEQFXzjz6OLmE44cbf+VYX5EGfIsX2BShuWH3USc86AjJWAc9
         eBptKgC45qf+rz47PtY6K8A8USnB0z9pq4nHCBakuvLJACPWLC5Tiid+6mYkRgHI91SJ
         AnV+T1YyUMWYhrbBcZurRHlPVNCnacTgUPvaZlnsD5xhB0WQ52B7QTOpKCZMhOfMzwKk
         8bPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgtOBCA/b8UNicE/zmQDVFI/lqixx54oqB3WJyBog6WAD4QNTCsvnnYWCPhUeQXf3R1TePeGiCL5J9kNg6/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQtIUNczzDmZwLN8SOv228eZmsgrl8vbIS6kvty8OWVhIuZtGM
	F8anLJZL0A3pM9g3N1RVqMVUk6ppdYcoE2BD2CWoB/sUW+DFYK0l9GY7MyHA53xeT50=
X-Gm-Gg: ASbGncvtZ6JEV/PCeW1fMldKY5Ww8mKyGGCQdY1goO2NeRWuQC8/5y98cx7d/lSgadv
	zaetkJnjslPoFCJtjOuwuqnEOjATLo09z4YLIm7hwlgqOl07flxPfNg+AJpqz+oDZjjdKPA4So+
	0PBj5XJ5xLrU3Q0K1yYSnlq/peVrO8JxbUeiWFs/sZxbcAyk+6G2m9Kc9vq3bk9WMshfRTp9oBi
	rCXoBR7WCc6oiJUnFXDApFSbi1S2NbwuT8FDiZCpxSsBY0HCpPAp9HmSeF78w+iSOdrL/2fN1PV
	TH8CU4i5oNqr5qMK9zB4AAwVTufg40Cm70aYzUJaArJfXgK4OjHi0HLE/XEHPvjUDAVtbaMxgMZ
	Rp2+1XODv5aMPCXQvmXdtVqR0bSyicwRAAvOWPt53zWGcVg==
X-Google-Smtp-Source: AGHT+IE4OVGv0ZHONTY8jo3BV9GHDYUu3GtoFhSxfwHUuz7H8XXTW3Jjoc+7pdproO8lCLYVAmLqDw==
X-Received: by 2002:a17:90b:3503:b0:31c:260e:5603 with SMTP id 98e67ed59e1d1-31c4f562f15mr11707603a91.24.1752355928711;
        Sat, 12 Jul 2025 14:32:08 -0700 (PDT)
Received: from mitchelllevy.localdomain ([174.127.224.194])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3eb65aa2sm8003935a91.40.2025.07.12.14.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jul 2025 14:32:08 -0700 (PDT)
From: Mitchell Levy <levymitchell0@gmail.com>
Date: Sat, 12 Jul 2025 14:31:15 -0700
Subject: [PATCH v2 4/5] rust: percpu: Add pin-hole optimizations for
 numerics
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250712-rust-percpu-v2-4-826f2567521b@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752355923; l=8164;
 i=levymitchell0@gmail.com; s=20240719; h=from:subject:message-id;
 bh=Yhc2AZNWstxq/JmR6oLcJC1JQH1zZ60L+8ZJ13d/Yes=;
 b=7PlUlkr00EGSTFBjGecI5Y1jCbBQRf4K+CpEu8vYyLOv26zqXz/i9wBlJRC3sha4iMw1CGAtR
 dmDSdeDAdtXCDQ1FfikH92Lsn9VQUB/B0uiLGstCcKlAmie94nNufey
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
 lib/percpu_test_rust.rs       |  36 +++++++++++++
 rust/kernel/percpu.rs         |   1 +
 rust/kernel/percpu/numeric.rs | 117 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 154 insertions(+)

diff --git a/lib/percpu_test_rust.rs b/lib/percpu_test_rust.rs
index a9652e6ece08..114015435a85 100644
--- a/lib/percpu_test_rust.rs
+++ b/lib/percpu_test_rust.rs
@@ -25,6 +25,26 @@
 define_per_cpu!(PERCPU: i64 = 0);
 define_per_cpu!(UPERCPU: u64 = 0);
 
+macro_rules! make_optimization_test {
+    ($ty:ty) => {
+        let mut test: DynamicPerCpu<$ty> = DynamicPerCpu::new(GFP_KERNEL).unwrap();
+        {
+            let _ = CpuGuard::new();
+            // SAFETY: No other usage of `test`
+            unsafe { test.get(CpuGuard::new()) }.with(|val: &mut $ty| *val = 10);
+            test.num().add(1);
+            // SAFETY: No other usage of `test`
+            unsafe { test.get(CpuGuard::new()) }.with(|val: &mut $ty| assert_eq!(*val, 11));
+            test.num().add(10);
+            // SAFETY: No other usage of `test`
+            unsafe { test.get(CpuGuard::new()) }.with(|val: &mut $ty| assert_eq!(*val, 21));
+            test.num().sub(5);
+            // SAFETY: No other usage of `test`
+            unsafe { test.get(CpuGuard::new()) }.with(|val: &mut $ty| assert_eq!(*val, 16));
+        }
+    };
+}
+
 impl kernel::Module for PerCpuTestModule {
     fn init(_module: &'static ThisModule) -> Result<Self, Error> {
         pr_info!("rust percpu test start\n");
@@ -94,6 +114,22 @@ fn init(_module: &'static ThisModule) -> Result<Self, Error> {
 
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
diff --git a/rust/kernel/percpu.rs b/rust/kernel/percpu.rs
index 7dfceb6aefd7..b97d1d07a614 100644
--- a/rust/kernel/percpu.rs
+++ b/rust/kernel/percpu.rs
@@ -2,6 +2,7 @@
 //! This module contains abstractions for creating and using per-CPU variables from Rust.
 //! See the define_per_cpu! macro and the DynamicPerCpu<T> type, as well as the PerCpu<T> trait.
 pub mod cpu_guard;
+pub mod numeric;
 
 use bindings::{alloc_percpu, free_percpu};
 
diff --git a/rust/kernel/percpu/numeric.rs b/rust/kernel/percpu/numeric.rs
new file mode 100644
index 000000000000..e4008f872af1
--- /dev/null
+++ b/rust/kernel/percpu/numeric.rs
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0
+//! Pin-hole optimizations for PerCpu<T> where T is a numeric type.
+
+use crate::percpu::*;
+use core::arch::asm;
+
+/// Represents a per-CPU variable that can be manipulated with machine-intrinsic numeric
+/// operations.
+pub struct PerCpuNumeric<'a, T> {
+    ptr: &'a PerCpuPtr<T>,
+}
+
+macro_rules! impl_ops {
+    ($ty:ty, $reg:tt) => {
+        impl DynamicPerCpu<$ty> {
+            /// Returns a `PerCpuNumeric` that can be used to manipulate the underlying per-CPU variable.
+            pub fn num(&self) -> PerCpuNumeric<'_, $ty> {
+                PerCpuNumeric { ptr: &self.alloc.0 }
+            }
+        }
+        impl StaticPerCpu<$ty> {
+            /// Returns a `PerCpuNumeric` that can be used to manipulate the underlying per-CPU variable.
+            pub fn num(&self) -> PerCpuNumeric<'_, $ty> {
+                PerCpuNumeric { ptr: &self.0 }
+            }
+        }
+
+        impl PerCpuNumeric<'_, $ty> {
+            /// Adds `rhs` to the per-CPU variable.
+            pub fn add(&mut self, rhs: $ty) {
+                // SAFETY: `self.ptr.0` is a valid offset into the per-CPU area (i.e., valid as a
+                // pointer relative to the `gs` segment register) by the invariants of PerCpu.
+                unsafe {
+                    asm!(
+                        concat!("add gs:[{off}], {val:", $reg, "}"),
+                        off = in(reg) self.ptr.0 as *mut $ty,
+                        val = in(reg) rhs,
+                    );
+                }
+            }
+        }
+        impl PerCpuNumeric<'_, $ty> {
+            /// Subtracts `rhs` from the per-CPU variable.
+            pub fn sub(&mut self, rhs: $ty) {
+                // SAFETY: `self.ptr.0` is a valid offset into the per-CPU area (i.e., valid as a
+                // pointer relative to the `gs` segment register) by the invariants of PerCpu.
+                unsafe {
+                    asm!(
+                        concat!("sub gs:[{off}], {val:", $reg, "}"),
+                        off = in(reg) self.ptr.0 as *mut $ty,
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
+            /// Returns a `PerCpuNumeric` that can be used to manipulate the underlying per-CPU
+            /// variable.
+            pub fn num(&self) -> PerCpuNumeric<'_, $ty> {
+                PerCpuNumeric { ptr: &self.alloc.0 }
+            }
+        }
+        impl StaticPerCpu<$ty> {
+            /// Returns a `PerCpuNumeric` that can be used to manipulate the underlying per-CPU
+            /// variable.
+            pub fn num(&self) -> PerCpuNumeric<'_, $ty> {
+                PerCpuNumeric { ptr: &self.0 }
+            }
+        }
+
+        impl PerCpuNumeric<'_, $ty> {
+            /// Adds `rhs` to the per-CPU variable.
+            pub fn add(&mut self, rhs: $ty) {
+                // SAFETY: `self.ptr.0` is a valid offset into the per-CPU area (i.e., valid as a
+                // pointer relative to the `gs` segment register) by the invariants of PerCpu.
+                unsafe {
+                    asm!(
+                        concat!("add gs:[{off}], {val}"),
+                        off = in(reg) self.ptr.0 as *mut $ty,
+                        val = in(reg_byte) rhs,
+                    );
+                }
+            }
+        }
+        impl PerCpuNumeric<'_, $ty> {
+            /// Subtracts `rhs` from the per-CPU variable.
+            pub fn sub(&mut self, rhs: $ty) {
+                // SAFETY: `self.ptr.0` is a valid offset into the per-CPU area (i.e., valid as a
+                // pointer relative to the `gs` segment register) by the invariants of PerCpu.
+                unsafe {
+                    asm!(
+                        concat!("sub gs:[{off}], {val}"),
+                        off = in(reg) self.ptr.0 as *mut $ty,
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

-- 
2.34.1


