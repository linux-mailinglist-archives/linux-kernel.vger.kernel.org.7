Return-Path: <linux-kernel+bounces-790584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A9BB3AA7F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 21:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 755501C86B19
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 19:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B031B3431F8;
	Thu, 28 Aug 2025 19:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJo+oXkV"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B93342C92;
	Thu, 28 Aug 2025 19:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756407666; cv=none; b=Ahaf0JKB1kvXdOpmopJW/jmn/ciETAbBr0uFx9gAZvbhinFD+ABuAlQLl7muKH1Ocd9s8DmHE48RyO0lodOMOpaJAnMtFGnVL/foS0RkbJjwh4BwwRApnSKzoZpmZpanPGnsKJXydp1EnGO8+RJOrIOBykUGXX8Y17PlgdATkB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756407666; c=relaxed/simple;
	bh=FkPibw/wTeWHpca1nOecK532ZikijOEsQLvkO8BhfQs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OPVYaTo381umDuEoBKYIO5fkMjH83EY6Y3on9lsBw4H4jfhXZfxhw1AUxTs/kZvrMwevmrEbsOodLB1ajWbeLXipq/a0lGybF4u+K5Rrx1Jzos182VxxJPa+X5sPuL2mtxizpYwEvtzdZ8nlu4rao5EiU4skUs0fKvkm0CFaiV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UJo+oXkV; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b475dfb4f42so950944a12.0;
        Thu, 28 Aug 2025 12:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756407664; x=1757012464; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aAngSwZJY8wvhRdb+Us7Bf51kKhX3hLhPg8BAwh+qjA=;
        b=UJo+oXkVARHFGPiWFrrYhj7vYH2cg00ppTzLUIaEwu8OWNh4rTVCazq7uPXSRSLySC
         PY2CqRC10ZdB0IST3+jEoxkx5a5O/6tHSlhiBqUxgrEaaKPZC+XQrixVbckOj8X0x3Bh
         McLbWXMwrVN4Acnsh7HvUareYylRNAr/itodPsxhmeJYoWM94nxvaJx84pAO1Az0x4Ov
         DNIQE8kFhdVLaRHfAdyWY3djvKD095AU+ulrex/JB1YxYOBoM4BDaqYOPPUdoXsqLdkd
         POvlQ3A2wrm67cX88GjBCP7yBPFgMhq2NLipUzAprDrPDorRw8lhqZCSVsKoGD1zWtbn
         ioLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756407664; x=1757012464;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aAngSwZJY8wvhRdb+Us7Bf51kKhX3hLhPg8BAwh+qjA=;
        b=gRbbdyeI56K0ncSuZBh6EakIsaneV5c6oK7L8wuP/MtEP+4YGduQIiuKvnGeh4Qxqd
         jJFH7Qhei0UP61bCgYc8zHjOc5NvteTxGJBkJHYE+kwm/BTAhs8q/yjGHxVl09WKB4MI
         ZWGcecAibBgKmyezYrcbG9L4tcVQrbfF+HGVGh4S8blm0D3J97DXMqYiQbkHTn7uJhaZ
         Y3Nwsjv+25F26tdz8WDr1KRfcTW8N2J0Z7bZU5QZJxFVy0TfDF1IUD6i1OfchPV+0RJe
         YsMnKAmK/3wI38hT3PAzmHJVJo5aUNtfXRnHMT03YyQl0+wH41IWp/FGZELhi7hRDdcH
         lLtA==
X-Forwarded-Encrypted: i=1; AJvYcCU77X+6Jc7usM4AwbwjtCW7dosHc+nUAC8cA9uOlQUlb0Y9Ru7LuAGgEh6ydHPJP0yyR0bZQ8mgotGR0oaRtnY=@vger.kernel.org, AJvYcCUHoHox/M6WeXexhXIlBKusdGZwNrqgR8iVstGt/hNJR2ZsOhSqWZAv3woXsMTYKIWnT0+8Y9ka5yMhcFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwajRBAlC4xACLSUYQcNqLkJ0c8iQaTWFZbJZrSoxvbtiYp/cIM
	4C9I7Vw3w88AET+I1zARuLqvx5Y08swgbnpkaz04HgcllxGQg7DpCJhO6nk2AKop
X-Gm-Gg: ASbGncsMZ2t1srvyBqrHpyezSg2KTct2FfZrOahY3nvWztAbq7aXscUtLy3E3UR9W48
	DBCuckEcKp4vwh12S6maAaRjoJcjSl7puUu0okx40i2UDknzElIAQ1HgCNgJTl7FcHmf7ZNuzJa
	pPlL05zR8KAgE1zPUy7dehKXg/DV77/soUNDNfn+ti8nGA6n+kU1nFaCJ9rknFjSUZRL/xAIned
	JX0jY8n+X+FVjOZGm5AF1yaO81Z6KBPeAI5icdoo/BzUpmTdtElj2C1p8v3aO5thc4+BcZe+r35
	8eB3MH7oC2toAdH+a8matO4R+m9Ii3ydvzIgDtrsB6P27RkwvaNzuQpLvpBVcvSEKBBcTLtshh/
	3lBiVIhKYxUSj1luAX9FKHmzOJJECdD9Cx8vlQ03Nx3KtfQ==
X-Google-Smtp-Source: AGHT+IE26/lrl4f3dGjJW6QGStTgLdmIa26piskyaGIsHE5TO9Dbkag/vLov52+DzHKlj+iq5a9ckw==
X-Received: by 2002:a17:90b:3ec9:b0:327:5360:5b11 with SMTP id 98e67ed59e1d1-327536061fdmr12677471a91.27.1756407662991;
        Thu, 28 Aug 2025 12:01:02 -0700 (PDT)
Received: from mitchelllevy.localdomain ([174.127.224.194])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-327da8e5ad5sm405729a91.18.2025.08.28.12.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 12:01:01 -0700 (PDT)
From: Mitchell Levy <levymitchell0@gmail.com>
Date: Thu, 28 Aug 2025 12:00:13 -0700
Subject: [PATCH v3 6/7] rust: percpu: Add pin-hole optimizations for
 numerics
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-rust-percpu-v3-6-4dd92e1e7904@gmail.com>
References: <20250828-rust-percpu-v3-0-4dd92e1e7904@gmail.com>
In-Reply-To: <20250828-rust-percpu-v3-0-4dd92e1e7904@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Andrew Morton <akpm@linux-foundation.org>, 
 Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
 Christoph Lameter <cl@linux.com>, Danilo Krummrich <dakr@kernel.org>, 
 Benno Lossin <lossin@kernel.org>, Yury Norov <yury.norov@gmail.com>, 
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: Tyler Hicks <code@tyhicks.com>, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-mm@kvack.org, 
 Mitchell Levy <levymitchell0@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756407651; l=9614;
 i=levymitchell0@gmail.com; s=20240719; h=from:subject:message-id;
 bh=FkPibw/wTeWHpca1nOecK532ZikijOEsQLvkO8BhfQs=;
 b=G3nMpuN/5qYzhXKfS67YeHPg6iQlvPE/KO79sTBsc4eHDPXaEL+ZfiGMssCN5FNO96iohtJUT
 XZe3XfI2Na1Dz4CdbL+lGwMMy+olOmlki7WomhFHkbFKPpofXIRqhnD
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
 rust/kernel/percpu/dynamic.rs |   2 +-
 rust/kernel/percpu/numeric.rs | 128 ++++++++++++++++++++++++++++++++++++++++++
 samples/rust/rust_percpu.rs   |  36 ++++++++++++
 4 files changed, 166 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/percpu.rs b/rust/kernel/percpu.rs
index c68c7520b67f..c693d16518d2 100644
--- a/rust/kernel/percpu.rs
+++ b/rust/kernel/percpu.rs
@@ -4,6 +4,7 @@
 
 pub mod cpu_guard;
 mod dynamic;
+pub mod numeric;
 mod static_;
 
 #[doc(inline)]
diff --git a/rust/kernel/percpu/dynamic.rs b/rust/kernel/percpu/dynamic.rs
index 64f04cef3705..aad08e4b4251 100644
--- a/rust/kernel/percpu/dynamic.rs
+++ b/rust/kernel/percpu/dynamic.rs
@@ -7,7 +7,7 @@
 
 /// Represents a dynamic allocation of a per-CPU variable via alloc_percpu. Calls free_percpu when
 /// dropped.
-pub struct PerCpuAllocation<T>(PerCpuPtr<T>);
+pub struct PerCpuAllocation<T>(pub(super) PerCpuPtr<T>);
 
 impl<T: Zeroable> PerCpuAllocation<T> {
     /// Dynamically allocates a space in the per-CPU area suitably sized and aligned to hold a `T`,
diff --git a/rust/kernel/percpu/numeric.rs b/rust/kernel/percpu/numeric.rs
new file mode 100644
index 000000000000..4de93f653f0e
--- /dev/null
+++ b/rust/kernel/percpu/numeric.rs
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0
+//! Pin-hole optimizations for PerCpu<T> where T is a numeric type.
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
+            /// Returns a `PerCpuNumeric` that can be used to manipulate the underlying per-CPU variable.
+            pub fn num(&mut self) -> PerCpuNumeric<'_, $ty> {
+                // The invariant is satisfied because `DynamicPerCpu`'s invariant guarantees that
+                // this pointer is valid and initialized on all CPUs.
+                PerCpuNumeric { ptr: &self.alloc.0 }
+            }
+        }
+        impl StaticPerCpu<$ty> {
+            /// Returns a `PerCpuNumeric` that can be used to manipulate the underlying per-CPU variable.
+            pub fn num(&mut self) -> PerCpuNumeric<'_, $ty> {
+                // The invariant is satisfied because `StaticPerCpu`'s invariant guarantees that
+                // this pointer is valid and initialized on all CPUs.
+                PerCpuNumeric { ptr: &self.0 }
+            }
+        }
+
+        impl PerCpuNumeric<'_, $ty> {
+            /// Adds `rhs` to the per-CPU variable.
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
+            /// Returns a `PerCpuNumeric` that can be used to manipulate the underlying per-CPU
+            /// variable.
+            pub fn num(&mut self) -> PerCpuNumeric<'_, $ty> {
+                // The invariant is satisfied because `DynamicPerCpu`'s invariant guarantees that
+                // this pointer is valid and initialized on all CPUs.
+                PerCpuNumeric { ptr: &self.alloc.0 }
+            }
+        }
+        impl StaticPerCpu<$ty> {
+            /// Returns a `PerCpuNumeric` that can be used to manipulate the underlying per-CPU
+            /// variable.
+            pub fn num(&mut self) -> PerCpuNumeric<'_, $ty> {
+                // The invariant is satisfied because `DynamicPerCpu`'s invariant guarantees that
+                // this pointer is valid and initialized on all CPUs.
+                PerCpuNumeric { ptr: &self.0 }
+            }
+        }
+
+        impl PerCpuNumeric<'_, $ty> {
+            /// Adds `rhs` to the per-CPU variable.
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
index 06b322019134..e3a46a053b8d 100644
--- a/samples/rust/rust_percpu.rs
+++ b/samples/rust/rust_percpu.rs
@@ -27,6 +27,26 @@
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
@@ -198,6 +218,22 @@ fn init(_module: &'static ThisModule) -> Result<Self, Error> {
 
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


