Return-Path: <linux-kernel+bounces-790583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B75B3AA7E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 21:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF1F5A01CB1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 19:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885AC32BF2E;
	Thu, 28 Aug 2025 19:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezHTKu/E"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A236340DA2;
	Thu, 28 Aug 2025 19:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756407663; cv=none; b=Ict7vesxPxVq86Z6an+bwi3UctXPg0AwVmx5IYzP22fM6DJOgiZGiSHaIVxWaU/wNUcJvCPhpVwpf4GA/LEvDQStMAM277hl5MI2bccHEsZb38uZRXbek//x/Nyg5fa81+Rn5rLpIRNv1UVC+tgT2Fddv+EKmv7NYAG6DQm+N90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756407663; c=relaxed/simple;
	bh=+lEJbTpkz2WbxbYDrCnnJg9tQe8ptqmkgyWr5/FAI6E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Uqubia+GsLk0ETk+2RRZ0YiUvZ5IGRRHSA4vFAOve9sImnJeul/H4F4Tj60yLZnVtxfGJLAqGF5wQxMJ+7pfvD+7PUX3CWYQkJCtvrADmoUODkjqLA14NqruTYEvKuXIUJY0ZF9MS5fb/Q0PY2nM7SsYd8A4Bb7M5dqnoSwaYpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ezHTKu/E; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-325393d0ddaso1032201a91.3;
        Thu, 28 Aug 2025 12:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756407661; x=1757012461; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MV4GmSdkUNmPQjyOi2VED+Xs96RqoKvGI46q2QRv97g=;
        b=ezHTKu/EtcbZTtQuCmyM+rW8pXq1hrxD+493tRWaaK/v4SalfhaSK4Z+SszKRkuaC1
         U0jPxa9EYUuMqyrK1dezjV+J5PdLltPkA2J3pWphrNi5yofNPz+OBXBEhpCgJk8jh9xF
         lzQpoHru8puTMxm4XBqbUGvp+BQw3ZGvgKyBxbX6XNJV+XwsuZqeyl+Q/Rgx/KGPS23M
         L0IfbQ/i85XRGMazRGw+YGMLbAziYzKK0dh4YnZ/pXDnljpb+GYCYkZXiEmdHNsTWxAr
         c+QXF8Y2O3euT+85EOBfDP7bbiRPzmABebeATo2+kOXhXpA2n3POFEwWT/AyR79J2Prb
         LzGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756407661; x=1757012461;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MV4GmSdkUNmPQjyOi2VED+Xs96RqoKvGI46q2QRv97g=;
        b=DLQ08DqlwVVBrhgqg3odjtUIlnZiaYtM8g507uHhYpQz2q19s8nay5YuYzRGyqdg8Z
         lVQtEwXrdV9R2lnyn8Xvb08HebtVNDMbnnKUVfKybHjQ57r6Uu6MCl44TJARHJflZaTU
         IRpcrVT4doqPnzIDh7B9+9uiquQeq9pAIp6Z7ZtjadDalaOKoXvo9TzN1Iskl42/gbp9
         ENrMXeuXzvEH0F+ozbpqReqMPNb5b0LriYUYAFBApZUV/+0fAF8rg8UwqNuMkzhdAMe0
         xdDDxpDVEL7v2lkgBmdl531xjN4nH0coyZFTxHcWIYNKRl4jb41dgAfEQOjtc2gNhpCT
         G1Zw==
X-Forwarded-Encrypted: i=1; AJvYcCVhyBX4w9kmYGZ8j7SjaBOsHi/Ml3hGcsKw8h7xqZ+n4GaskrcKI7od3+soITwlEPLgpBryopJ9ikyvDDuf4qo=@vger.kernel.org, AJvYcCXnpX6sDcecbRB5pHvPhRFIHh5JfPIjTo6Eluvoo2Pxbnsjl83XxD5j3fAH6vkuqAzcjCz5a+Jaetjfszk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI2y2eRKotuseSHH+1rvwVO9veh0Ekhi7SYjPjqNQjbQ94ues8
	yvY/+4o7gOe+lCkLyatzaEvaM8AKV8CtzCOt6FhEjvAFnj0d9ngm/gkpvedaI1nJ
X-Gm-Gg: ASbGncsMvCZ4tp5/xciTJ8JkCeqcorrTpfoyFTkiv0vMt5jeYqPiwMr1/htwOJkIXfk
	eV/o3+EIoVKh5tkw3UzFY3mJambat9tnlYk/R8hgDuMHgIA1TwWQDft47jAsQLC1ivjHBDIIgQF
	tvCeRAmm+toEUG5WX8Vk7t12IvQ+swa+RJwfU7eXjMLPse0NA5SrZQskqu4o8K5WQpI9bne4uPI
	0svuT+ePce7FiwocYz2KgR+4nGUZn1yr7bzSifm6Yj+N7vgdKJa3aN5hjT433gQkdfhJlvobLUe
	bxJ/X3ykWsOG1i85898bDTufO/Vk6+M3jbaAaJFLj/DghPqb+1sxdOyuq4fHT0v+Ez3cPHvQOc6
	nymYV5llQIDn2R5yWwIyV/6Da8DgBDVKYJvMYD/Sr4J/HBg==
X-Google-Smtp-Source: AGHT+IHvRbS5E1bKUmmAsVXFtXvCxFUCGJDcz57wzHvVzZP529pa37fN3+oWV7CfzyuGeLcSuQ1SWw==
X-Received: by 2002:a17:90b:2ccd:b0:321:4760:c65a with SMTP id 98e67ed59e1d1-32517d1e054mr30179480a91.27.1756407660486;
        Thu, 28 Aug 2025 12:01:00 -0700 (PDT)
Received: from mitchelllevy.localdomain ([174.127.224.194])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-327da8e5ad5sm405729a91.18.2025.08.28.12.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 12:00:59 -0700 (PDT)
From: Mitchell Levy <levymitchell0@gmail.com>
Date: Thu, 28 Aug 2025 12:00:12 -0700
Subject: [PATCH v3 5/7] rust: percpu: Support non-zeroable types for
 DynamicPerCpu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-rust-percpu-v3-5-4dd92e1e7904@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756407651; l=11574;
 i=levymitchell0@gmail.com; s=20240719; h=from:subject:message-id;
 bh=+lEJbTpkz2WbxbYDrCnnJg9tQe8ptqmkgyWr5/FAI6E=;
 b=nsWk0v7Bp3XRYlydEETW2ckzGyCaiUq6V4hFLtHmax5ZpM1J/foqW9qb/F9rKhy4xVojaLz9Z
 dAT4xoykz0EDR+zf6iRz4X92+VJiYDuSyBok2JQb7X66hAaNuKTChT9
X-Developer-Key: i=levymitchell0@gmail.com; a=ed25519;
 pk=n6kBmUnb+UNmjVkTnDwrLwTJAEKUfs2e8E+MFPZI93E=

Add functionality to `PerCpuPtr` to compute pointers to per-CPU variable
slots on other CPUs. Use this facility to initialize per-CPU variables
on all possible CPUs when a dynamic per-CPU variable is created with a
non-zeroable type. Since `RefCell` and other `Cell`-like types fall into
this category, `impl CheckedPerCpu` on `DynamicPerCpu` for these
`InteriorMutable` types since they can now be used. Add examples of
these usages to `samples/rust/rust_percpu.rs`.

Signed-off-by: Mitchell Levy <levymitchell0@gmail.com>
---
 rust/helpers/percpu.c         |  5 +++
 rust/kernel/percpu.rs         | 15 +++++++
 rust/kernel/percpu/dynamic.rs | 40 +++++++++++++++++
 samples/rust/rust_percpu.rs   | 99 ++++++++++++++++++++++++++++++++++++++++---
 4 files changed, 152 insertions(+), 7 deletions(-)

diff --git a/rust/helpers/percpu.c b/rust/helpers/percpu.c
index 8cc01d094752..8d83b6b86106 100644
--- a/rust/helpers/percpu.c
+++ b/rust/helpers/percpu.c
@@ -8,6 +8,11 @@ void __percpu *rust_helper_alloc_percpu(size_t sz, size_t align)
 	return __alloc_percpu(sz, align);
 }
 
+void *rust_helper_per_cpu_ptr(void __percpu *ptr, unsigned int cpu)
+{
+	return per_cpu_ptr(ptr, cpu);
+}
+
 void rust_helper_on_each_cpu(smp_call_func_t func, void *info, int wait)
 {
 	on_each_cpu(func, info, wait);
diff --git a/rust/kernel/percpu.rs b/rust/kernel/percpu.rs
index 35afcdba3ccd..c68c7520b67f 100644
--- a/rust/kernel/percpu.rs
+++ b/rust/kernel/percpu.rs
@@ -14,6 +14,7 @@
 use bindings::{alloc_percpu, free_percpu};
 
 use crate::alloc::Flags;
+use crate::cpu::CpuId;
 use crate::percpu::cpu_guard::CpuGuard;
 use crate::prelude::*;
 use crate::sync::Arc;
@@ -115,6 +116,20 @@ pub fn get_ptr(&self) -> *mut MaybeUninit<T> {
         // the invariant that self.0 is a valid offset into the per-CPU area.
         (this_cpu_area).wrapping_add(self.0 as usize).cast()
     }
+
+    /// Get a `*mut MaybeUninit<T>` to the per-CPU variable on the CPU represented by `cpu`. Note
+    /// that without some kind of synchronization, use of the returned pointer may cause a data
+    /// race. It is the caller's responsibility to use the returned pointer in a reasonable way.
+    ///
+    /// # Safety
+    /// - The returned pointer is valid only if `self` is (that is, it points to a live allocation
+    ///   correctly sized and aligned to hold a `T`)
+    /// - The returned pointer is valid only if the bit corresponding to `cpu` is set in
+    ///   `Cpumask::possible()`.
+    pub unsafe fn get_remote_ptr(&self, cpu: CpuId) -> *mut MaybeUninit<T> {
+        // SAFETY: The requirements of this function ensure this call is safe.
+        unsafe { bindings::per_cpu_ptr(self.0.cast(), cpu.as_u32()) }.cast()
+    }
 }
 
 // SAFETY: Sending a `PerCpuPtr<T>` to another thread is safe because as soon as it's sent, the
diff --git a/rust/kernel/percpu/dynamic.rs b/rust/kernel/percpu/dynamic.rs
index ce95e420f943..64f04cef3705 100644
--- a/rust/kernel/percpu/dynamic.rs
+++ b/rust/kernel/percpu/dynamic.rs
@@ -3,6 +3,8 @@
 
 use super::*;
 
+use crate::cpumask::Cpumask;
+
 /// Represents a dynamic allocation of a per-CPU variable via alloc_percpu. Calls free_percpu when
 /// dropped.
 pub struct PerCpuAllocation<T>(PerCpuPtr<T>);
@@ -74,6 +76,36 @@ pub fn new_zero(flags: Flags) -> Option<Self> {
     }
 }
 
+impl<T: Clone> DynamicPerCpu<T> {
+    /// Allocates a new per-CPU variable
+    ///
+    /// # Arguments
+    /// * `val` - The initial value of the per-CPU variable on all CPUs.
+    /// * `flags` - Flags used to allocate an `Arc` that keeps track of the underlying
+    ///   `PerCpuAllocation`.
+    pub fn new_with(val: T, flags: Flags) -> Option<Self> {
+        let alloc: PerCpuAllocation<T> = PerCpuAllocation::new_uninit()?;
+        let ptr = alloc.0;
+
+        for cpu in Cpumask::possible().iter() {
+            // SAFETY: `ptr` is a valid allocation, and `cpu` appears in `Cpumask::possible()`
+            let remote_ptr = unsafe { ptr.get_remote_ptr(cpu) };
+            // SAFETY: Each CPU's slot corresponding to `ptr` is currently uninitialized, and no
+            // one else has a reference to it. Therefore, we can freely write to it without
+            // worrying about the need to drop what was there or whether we're racing with someone
+            // else. `PerCpuPtr::get_remote_ptr` guarantees that the pointer is valid since we
+            // derived it from a valid allocation and `cpu`.
+            unsafe {
+                (*remote_ptr).write(val.clone());
+            }
+        }
+
+        let arc = Arc::new(alloc, flags).ok()?;
+
+        Some(Self { alloc: arc })
+    }
+}
+
 impl<T> PerCpu<T> for DynamicPerCpu<T> {
     unsafe fn get_mut(&mut self, guard: CpuGuard) -> PerCpuToken<'_, T> {
         // SAFETY: The requirements of `PerCpu::get_mut` and this type's invariant ensure that the
@@ -81,3 +113,11 @@ unsafe fn get_mut(&mut self, guard: CpuGuard) -> PerCpuToken<'_, T> {
         unsafe { PerCpuToken::new(guard, &self.alloc.0) }
     }
 }
+
+impl<T: InteriorMutable> CheckedPerCpu<T> for DynamicPerCpu<T> {
+    fn get(&mut self, guard: CpuGuard) -> CheckedPerCpuToken<'_, T> {
+        // SAFETY: By the invariant of `DynamicPerCpu`, the memory location in each CPU's
+        // per-CPU area corresponding to this variable has been initialized.
+        unsafe { CheckedPerCpuToken::new(guard, &self.alloc.0) }
+    }
+}
diff --git a/samples/rust/rust_percpu.rs b/samples/rust/rust_percpu.rs
index 98ca1c781b6b..06b322019134 100644
--- a/samples/rust/rust_percpu.rs
+++ b/samples/rust/rust_percpu.rs
@@ -130,13 +130,72 @@ fn init(_module: &'static ThisModule) -> Result<Self, Error> {
 
         // SAFETY: No prerequisites for on_each_cpu.
         unsafe {
-            on_each_cpu(Some(inc_percpu), (&raw mut test).cast(), 0);
-            on_each_cpu(Some(inc_percpu), (&raw mut test).cast(), 0);
-            on_each_cpu(Some(inc_percpu), (&raw mut test).cast(), 0);
-            on_each_cpu(Some(inc_percpu), (&raw mut test).cast(), 1);
-            on_each_cpu(Some(check_percpu), (&raw mut test).cast(), 1);
+            on_each_cpu(Some(inc_percpu_u64), (&raw mut test).cast(), 0);
+            on_each_cpu(Some(inc_percpu_u64), (&raw mut test).cast(), 0);
+            on_each_cpu(Some(inc_percpu_u64), (&raw mut test).cast(), 0);
+            on_each_cpu(Some(inc_percpu_u64), (&raw mut test).cast(), 1);
+            on_each_cpu(Some(check_percpu_u64), (&raw mut test).cast(), 1);
         }
 
+        let mut checked: DynamicPerCpu<RefCell<u64>> =
+            DynamicPerCpu::new_with(RefCell::new(100), GFP_KERNEL).unwrap();
+
+        // SAFETY: No prerequisites for on_each_cpu.
+        unsafe {
+            on_each_cpu(Some(inc_percpu_refcell_u64), (&raw mut checked).cast(), 0);
+            on_each_cpu(Some(inc_percpu_refcell_u64), (&raw mut checked).cast(), 0);
+            on_each_cpu(Some(inc_percpu_refcell_u64), (&raw mut checked).cast(), 0);
+            on_each_cpu(Some(inc_percpu_refcell_u64), (&raw mut checked).cast(), 1);
+            on_each_cpu(Some(check_percpu_refcell_u64), (&raw mut checked).cast(), 1);
+        }
+
+        checked.get(CpuGuard::new()).with(|val: &RefCell<u64>| {
+            assert!(*val.borrow() == 104);
+
+            let mut checked_native = 0;
+            *val.borrow_mut() = 0;
+
+            checked_native += 1;
+            *val.borrow_mut() += 1;
+            pr_info!(
+                "Checked native: {}, *checked: {}\n",
+                checked_native,
+                val.borrow()
+            );
+            assert!(checked_native == *val.borrow() && checked_native == 1);
+
+            checked_native = checked_native.wrapping_add((-1i64) as u64);
+            val.replace_with(|old: &mut u64| old.wrapping_add((-1i64) as u64));
+            pr_info!(
+                "Checked native: {}, *checked: {}\n",
+                checked_native,
+                val.borrow()
+            );
+            assert!(checked_native == *val.borrow() && checked_native == 0);
+
+            checked_native = checked_native.wrapping_add((-1i64) as u64);
+            val.replace_with(|old: &mut u64| old.wrapping_add((-1i64) as u64));
+            pr_info!(
+                "Checked native: {}, *checked: {}\n",
+                checked_native,
+                val.borrow()
+            );
+            assert!(checked_native == *val.borrow() && checked_native == (-1i64) as u64);
+
+            checked_native = 0;
+            *val.borrow_mut() = 0;
+
+            checked_native = checked_native.wrapping_sub(1);
+            val.replace_with(|old: &mut u64| old.wrapping_sub(1));
+            pr_info!(
+                "Checked native: {}, *checked: {}\n",
+                checked_native,
+                val.borrow()
+            );
+            assert!(checked_native == *val.borrow() && checked_native == (-1i64) as u64);
+            assert!(checked_native == *val.borrow() && checked_native == u64::MAX);
+        });
+
         pr_info!("rust dynamic percpu test done\n");
 
         // Return Err to unload the module
@@ -144,7 +203,7 @@ fn init(_module: &'static ThisModule) -> Result<Self, Error> {
     }
 }
 
-extern "C" fn inc_percpu(info: *mut c_void) {
+extern "C" fn inc_percpu_u64(info: *mut c_void) {
     // SAFETY: We know that info is a void *const DynamicPerCpu<u64> and DynamicPerCpu<u64> is Send.
     let mut pcpu = unsafe { (*(info as *const DynamicPerCpu<u64>)).clone() };
     pr_info!("Incrementing on {}\n", CpuId::current().as_u32());
@@ -153,7 +212,7 @@ extern "C" fn inc_percpu(info: *mut c_void) {
     unsafe { pcpu.get_mut(CpuGuard::new()) }.with(|val: &mut u64| *val += 1);
 }
 
-extern "C" fn check_percpu(info: *mut c_void) {
+extern "C" fn check_percpu_u64(info: *mut c_void) {
     // SAFETY: We know that info is a void *const DynamicPerCpu<u64> and DynamicPerCpu<u64> is Send.
     let mut pcpu = unsafe { (*(info as *const DynamicPerCpu<u64>)).clone() };
     pr_info!("Asserting on {}\n", CpuId::current().as_u32());
@@ -161,3 +220,29 @@ extern "C" fn check_percpu(info: *mut c_void) {
     // SAFETY: We don't have multiple clones of pcpu in scope
     unsafe { pcpu.get_mut(CpuGuard::new()) }.with(|val: &mut u64| assert!(*val == 4));
 }
+
+extern "C" fn inc_percpu_refcell_u64(info: *mut c_void) {
+    // SAFETY: We know that info is a void *const DynamicPerCpu<RefCell<u64>> and
+    // DynamicPerCpu<RefCell<u64>> is Send.
+    let mut pcpu = unsafe { (*(info as *const DynamicPerCpu<RefCell<u64>>)).clone() };
+    // SAFETY: smp_processor_id has no preconditions
+    pr_info!("Incrementing on {}\n", CpuId::current().as_u32());
+
+    pcpu.get(CpuGuard::new()).with(|val: &RefCell<u64>| {
+        let mut val = val.borrow_mut();
+        *val += 1;
+    });
+}
+
+extern "C" fn check_percpu_refcell_u64(info: *mut c_void) {
+    // SAFETY: We know that info is a void *const DynamicPerCpu<RefCell<u64>> and
+    // DynamicPerCpu<RefCell<u64>> is Send.
+    let mut pcpu = unsafe { (*(info as *const DynamicPerCpu<RefCell<u64>>)).clone() };
+    // SAFETY: smp_processor_id has no preconditions
+    pr_info!("Asserting on {}\n", CpuId::current().as_u32());
+
+    pcpu.get(CpuGuard::new()).with(|val: &RefCell<u64>| {
+        let val = val.borrow();
+        assert!(*val == 104);
+    });
+}

-- 
2.34.1


