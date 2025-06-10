Return-Path: <linux-kernel+bounces-679607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06464AD392C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jun 2025 15:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EF8317EBA9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jun 2025 13:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D0A298CD5;
	Tue, 10 Jun 2025 13:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cvzgMufQ"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABDE295DB8
	for <linux-kernel@vger.kernel.org>; Tue, 10 Jun 2025 13:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749561735; cv=none; b=l8yyNexALb0Nd/1ZP/5z5CvjQlwCZKONoxL9j8mgLcaA6S0By1wBnxE0x8Hod4Ek4pj7l75kJWaReMjAyIUKMgW52X+B+KbCLpQ2p8ipAD1b0nfISH9XcSVzahZ4RZZZnsRkngJhWq1wyn9qH6NfIoprTApMRWtIRn6zMi/NaW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749561735; c=relaxed/simple;
	bh=pg9//lGKC5q7jStTMIlzjM/+UsizaQyTQXjdeOlLvIo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AtqfsMgR5Y+WjyhFboMkDLCBYxLYQCkNxFq2UrNZobKPH2ywQ8V0DTYy3iSOVQOz8hncvPfPLsM4BhFOVUK6oqR+TYPYX8Z84qa5l6p2wDCflKA83K3Es5ynUlhylaDh1tiO2sCAXTSjehKSYSsWNFCBSb5Ynnj8gbgjnUJ/Mxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cvzgMufQ; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b2f11866376so3571301a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jun 2025 06:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749561733; x=1750166533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3vGS9bFhaItWzg1MY3+mfwEAkDgZMtZN5zzSGR+CYpA=;
        b=cvzgMufQmsGsaLmBr7x6nJEu5g+XCA90uGxEfxhM06qRXNrQkCVqeIamRBSaYo45Hw
         94EvpwYaNhK0GcZDAxfs/pOeKGJ48OivnnerijdeHnpaArlOcsPA4OSySmMMEG95c85R
         DaKrcU7l1Kb0O9tIrsIfdEYqMoJzLkS5YOA/FtumabACqwnILOrrm5ecYblJfqUwkT8K
         1mFnMdp1WPO0fBWOXVzWuX8d7yp+JsQc+9vvKbIzQ+4hMSvbz16kkQboOi6b6h+CBdZP
         FF4MXteeboANe4/Sp3h3XF4O+il/CaNsICayDKC1nsRvyMIEdta5Jg3cudMd1uFXQBSK
         xfIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749561733; x=1750166533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3vGS9bFhaItWzg1MY3+mfwEAkDgZMtZN5zzSGR+CYpA=;
        b=cr8wnXrGcj19oPDllQtQ2vzCXLBJrrO5ZTN3WtHu/rYImoLgiWZAXG+JHimd+WwD/N
         +NeayvOpdyXyHw4d0cQXftCEiqPX4l6UIEq+yvNJFQ19XPPTKa/FE7LEGDQSsFKF9hT5
         OtGJQJHPhvFC5fC3eoL2/H2JrWHna5Rt18NiWRaRi4d9Xtc64r8E8P6rsZ0SUn+mjez5
         V188UX1hK4ooANl/y3trZzuIcCw2Unlpi9mAKZ0ifaiC6GEfQgWGrgPWRj9ie44vqKz+
         sJfJ4avbUZxqoZmRLi22Im4/ygRyeNdLeSrzgXioIYqXqJ2Ai7MvPDBkXr7sSrekXolx
         V1/w==
X-Forwarded-Encrypted: i=1; AJvYcCVW2WDT+9Jxia1/F/WyHDCI1nVRCx+s78tf1n+f9a0T6bcUwhbUUh9ev8U47eulqTS/ipxLMZFnvopDdbc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3WZdtidHzV+q0b7xw6hNLZftjKt5S31oJWZxwO0edtWfCWJLb
	ppDBZsmpVgl7Gy3+ouf6Fa7m72KUqqJKY2iTLuq7VDa/0V9A/CIIUfVTxAOc+OFKxxw=
X-Gm-Gg: ASbGncuMewmxBadmKw08wr4uW6anXwlCf2Z+WiaeJOLZqzJX8NQ4uGGEuiVsgcqnwUc
	KMJxFnlEEcO9+ScZFs8IvWFIG6I2LEqSW+B1l3WQWdrvMH42K9exBQskjXmWmP3LyuEdM7v2QY6
	/L+oeN3J0eMxkbObxDxPdLPzPGI5tIusqoQidfkvqv7NhZo8zgbDVniyADvlaY0UyAlHISbHNyZ
	Exoy5+om6XjWWkFtyj8/AJu/6UHYPlSJiU0iFilQwpG0fv98A0vGmbBAM2i4FYmfM56E748ZeJG
	jSg6CQ/NjZcR9CP7CfreFiAimiu+NUxc+NAFnCgSToNyieJOYUbvjhkIMoGUMT0=
X-Google-Smtp-Source: AGHT+IGjFiliPKrObq5ltswR8UB2srN9m8x8jJE9BnDPvMHBx3FP7jXqQwepXBVXuRD19df18OKJqw==
X-Received: by 2002:a17:90b:5107:b0:313:5d2f:54f8 with SMTP id 98e67ed59e1d1-3135d2f5588mr22158152a91.33.1749561732026;
        Tue, 10 Jun 2025 06:22:12 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3134b180dbesm7947163a91.48.2025.06.10.06.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 06:22:11 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Boqun Feng <boqun.feng@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Yury Norov <yury.norov@gmail.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
	rust-for-linux@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V3 2/3] rust: Use CpuId in place of raw CPU numbers
Date: Tue, 10 Jun 2025 18:51:57 +0530
Message-Id: <e790f17123beb45c6a811135ec3df8f0bd761c0e.1749554685.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1749554685.git.viresh.kumar@linaro.org>
References: <cover.1749554685.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Use the newly defined `CpuId` abstraction instead of raw CPU numbers.

This also fixes a doctest failure for configurations where `nr_cpu_ids <
4`.

The C `cpumask_{set|clear}_cpu()` APIs emit a warning when given an
invalid CPU number — but only if `CONFIG_DEBUG_PER_CPU_MAPS=y` is set.

Meanwhile, `cpumask_weight()` only considers CPUs up to `nr_cpu_ids`,
which can cause inconsistencies: a CPU number greater than `nr_cpu_ids`
may be set in the mask, yet the weight calculation won't reflect it.

This leads to doctest failures when `nr_cpu_ids < 4`, as the test tries
to set CPUs 2 and 3:

  rust_doctest_kernel_cpumask_rs_0.location: rust/kernel/cpumask.rs:180
  rust_doctest_kernel_cpumask_rs_0: ASSERTION FAILED at rust/kernel/cpumask.rs:190

Fixes: 8961b8cb3099 ("rust: cpumask: Add initial abstractions")
Reported-by: Miguel Ojeda <ojeda@kernel.org>
Closes: https://lore.kernel.org/rust-for-linux/CANiq72k3ozKkLMinTLQwvkyg9K=BeRxs1oYZSKhJHY-veEyZdg@mail.gmail.com/
Reported-by: Andreas Hindborg <a.hindborg@kernel.org>
Closes: https://lore.kernel.org/all/87qzzy3ric.fsf@kernel.org/
Suggested-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/rcpufreq_dt.rs |  4 +--
 rust/kernel/cpu.rs             |  4 +--
 rust/kernel/cpufreq.rs         | 27 ++++++++++++------
 rust/kernel/cpumask.rs         | 51 ++++++++++++++++++++++++----------
 4 files changed, 59 insertions(+), 27 deletions(-)

diff --git a/drivers/cpufreq/rcpufreq_dt.rs b/drivers/cpufreq/rcpufreq_dt.rs
index 94ed81644fe1..43c87d0259b6 100644
--- a/drivers/cpufreq/rcpufreq_dt.rs
+++ b/drivers/cpufreq/rcpufreq_dt.rs
@@ -26,9 +26,9 @@ fn find_supply_name_exact(dev: &Device, name: &str) -> Option<CString> {
 }
 
 /// Finds supply name for the CPU from DT.
-fn find_supply_names(dev: &Device, cpu: u32) -> Option<KVec<CString>> {
+fn find_supply_names(dev: &Device, cpu: cpu::CpuId) -> Option<KVec<CString>> {
     // Try "cpu0" for older DTs, fallback to "cpu".
-    let name = (cpu == 0)
+    let name = (cpu.as_u32() == 0)
         .then(|| find_supply_name_exact(dev, "cpu0"))
         .flatten()
         .or_else(|| find_supply_name_exact(dev, "cpu"))?;
diff --git a/rust/kernel/cpu.rs b/rust/kernel/cpu.rs
index 6a3aecb12468..7549594fad7f 100644
--- a/rust/kernel/cpu.rs
+++ b/rust/kernel/cpu.rs
@@ -127,9 +127,9 @@ fn from(id: CpuId) -> Self {
 /// Callers must ensure that the CPU device is not used after it has been unregistered.
 /// This can be achieved, for example, by registering a CPU hotplug notifier and removing
 /// any references to the CPU device within the notifier's callback.
-pub unsafe fn from_cpu(cpu: u32) -> Result<&'static Device> {
+pub unsafe fn from_cpu(cpu: CpuId) -> Result<&'static Device> {
     // SAFETY: It is safe to call `get_cpu_device()` for any CPU.
-    let ptr = unsafe { bindings::get_cpu_device(cpu) };
+    let ptr = unsafe { bindings::get_cpu_device(cpu.into()) };
     if ptr.is_null() {
         return Err(ENODEV);
     }
diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
index 9b995f18aac6..ea6106db5c29 100644
--- a/rust/kernel/cpufreq.rs
+++ b/rust/kernel/cpufreq.rs
@@ -10,6 +10,7 @@
 
 use crate::{
     clk::Hertz,
+    cpu::CpuId,
     cpumask,
     device::{Bound, Device},
     devres::Devres,
@@ -465,8 +466,9 @@ fn as_mut_ref(&mut self) -> &mut bindings::cpufreq_policy {
 
     /// Returns the primary CPU for the [`Policy`].
     #[inline]
-    pub fn cpu(&self) -> u32 {
-        self.as_ref().cpu
+    pub fn cpu(&self) -> CpuId {
+        // SAFETY: The C API guarantees that `cpu` refers to a valid CPU number.
+        unsafe { CpuId::from_u32_unchecked(self.as_ref().cpu) }
     }
 
     /// Returns the minimum frequency for the [`Policy`].
@@ -525,7 +527,7 @@ pub fn generic_suspend(&mut self) -> Result {
     #[inline]
     pub fn generic_get(&self) -> Result<u32> {
         // SAFETY: By the type invariant, the pointer stored in `self` is valid.
-        Ok(unsafe { bindings::cpufreq_generic_get(self.cpu()) })
+        Ok(unsafe { bindings::cpufreq_generic_get(self.cpu().into()) })
     }
 
     /// Provides a wrapper to the register with energy model using the OPP core.
@@ -678,9 +680,9 @@ fn clear_data<T: ForeignOwnable>(&mut self) -> Option<T> {
 struct PolicyCpu<'a>(&'a mut Policy);
 
 impl<'a> PolicyCpu<'a> {
-    fn from_cpu(cpu: u32) -> Result<Self> {
+    fn from_cpu(cpu: CpuId) -> Result<Self> {
         // SAFETY: It is safe to call `cpufreq_cpu_get` for any valid CPU.
-        let ptr = from_err_ptr(unsafe { bindings::cpufreq_cpu_get(cpu) })?;
+        let ptr = from_err_ptr(unsafe { bindings::cpufreq_cpu_get(cpu.into()) })?;
 
         Ok(Self(
             // SAFETY: The `ptr` is guaranteed to be valid and remains valid for the lifetime of
@@ -1266,7 +1268,10 @@ impl<T: Driver> Registration<T> {
         target_perf: usize,
         capacity: usize,
     ) {
-        if let Ok(mut policy) = PolicyCpu::from_cpu(cpu) {
+        // SAFETY: The C API guarantees that `cpu` refers to a valid CPU number.
+        let cpu_id = unsafe { CpuId::from_u32_unchecked(cpu) };
+
+        if let Ok(mut policy) = PolicyCpu::from_cpu(cpu_id) {
             T::adjust_perf(&mut policy, min_perf, target_perf, capacity);
         }
     }
@@ -1321,7 +1326,10 @@ impl<T: Driver> Registration<T> {
     ///
     /// - This function may only be called from the cpufreq C infrastructure.
     unsafe extern "C" fn get_callback(cpu: u32) -> kernel::ffi::c_uint {
-        PolicyCpu::from_cpu(cpu).map_or(0, |mut policy| T::get(&mut policy).map_or(0, |f| f))
+        // SAFETY: The C API guarantees that `cpu` refers to a valid CPU number.
+        let cpu_id = unsafe { CpuId::from_u32_unchecked(cpu) };
+
+        PolicyCpu::from_cpu(cpu_id).map_or(0, |mut policy| T::get(&mut policy).map_or(0, |f| f))
     }
 
     /// Driver's `update_limit` callback.
@@ -1344,8 +1352,11 @@ impl<T: Driver> Registration<T> {
     /// - This function may only be called from the cpufreq C infrastructure.
     /// - The pointer arguments must be valid pointers.
     unsafe extern "C" fn bios_limit_callback(cpu: i32, limit: *mut u32) -> kernel::ffi::c_int {
+        // SAFETY: The C API guarantees that `cpu` refers to a valid CPU number.
+        let cpu_id = unsafe { CpuId::from_i32_unchecked(cpu) };
+
         from_result(|| {
-            let mut policy = PolicyCpu::from_cpu(cpu as u32)?;
+            let mut policy = PolicyCpu::from_cpu(cpu_id)?;
 
             // SAFETY: `limit` is guaranteed by the C code to be valid.
             T::bios_limit(&mut policy, &mut (unsafe { *limit })).map(|()| 0)
diff --git a/rust/kernel/cpumask.rs b/rust/kernel/cpumask.rs
index c90bfac9346a..11ddd43edcb5 100644
--- a/rust/kernel/cpumask.rs
+++ b/rust/kernel/cpumask.rs
@@ -6,6 +6,7 @@
 
 use crate::{
     alloc::{AllocError, Flags},
+    cpu::CpuId,
     prelude::*,
     types::Opaque,
 };
@@ -35,9 +36,10 @@
 ///
 /// ```
 /// use kernel::bindings;
+/// use kernel::cpu::CpuId;
 /// use kernel::cpumask::Cpumask;
 ///
-/// fn set_clear_cpu(ptr: *mut bindings::cpumask, set_cpu: u32, clear_cpu: i32) {
+/// fn set_clear_cpu(ptr: *mut bindings::cpumask, set_cpu: CpuId, clear_cpu: CpuId) {
 ///     // SAFETY: The `ptr` is valid for writing and remains valid for the lifetime of the
 ///     // returned reference.
 ///     let mask = unsafe { Cpumask::as_mut_ref(ptr) };
@@ -90,9 +92,9 @@ pub fn as_raw(&self) -> *mut bindings::cpumask {
     /// This mismatches kernel naming convention and corresponds to the C
     /// function `__cpumask_set_cpu()`.
     #[inline]
-    pub fn set(&mut self, cpu: u32) {
+    pub fn set(&mut self, cpu: CpuId) {
         // SAFETY: By the type invariant, `self.as_raw` is a valid argument to `__cpumask_set_cpu`.
-        unsafe { bindings::__cpumask_set_cpu(cpu, self.as_raw()) };
+        unsafe { bindings::__cpumask_set_cpu(cpu.into(), self.as_raw()) };
     }
 
     /// Clear `cpu` in the cpumask.
@@ -101,19 +103,19 @@ pub fn set(&mut self, cpu: u32) {
     /// This mismatches kernel naming convention and corresponds to the C
     /// function `__cpumask_clear_cpu()`.
     #[inline]
-    pub fn clear(&mut self, cpu: i32) {
+    pub fn clear(&mut self, cpu: CpuId) {
         // SAFETY: By the type invariant, `self.as_raw` is a valid argument to
         // `__cpumask_clear_cpu`.
-        unsafe { bindings::__cpumask_clear_cpu(cpu, self.as_raw()) };
+        unsafe { bindings::__cpumask_clear_cpu(cpu.into(), self.as_raw()) };
     }
 
     /// Test `cpu` in the cpumask.
     ///
     /// Equivalent to the kernel's `cpumask_test_cpu` API.
     #[inline]
-    pub fn test(&self, cpu: i32) -> bool {
+    pub fn test(&self, cpu: CpuId) -> bool {
         // SAFETY: By the type invariant, `self.as_raw` is a valid argument to `cpumask_test_cpu`.
-        unsafe { bindings::cpumask_test_cpu(cpu, self.as_raw()) }
+        unsafe { bindings::cpumask_test_cpu(cpu.into(), self.as_raw()) }
     }
 
     /// Set all CPUs in the cpumask.
@@ -178,21 +180,40 @@ pub fn copy(&self, dstp: &mut Self) {
 /// The following example demonstrates how to create and update a [`CpumaskVar`].
 ///
 /// ```
+/// use kernel::cpu::CpuId;
 /// use kernel::cpumask::CpumaskVar;
 ///
 /// let mut mask = CpumaskVar::new_zero(GFP_KERNEL).unwrap();
 ///
 /// assert!(mask.empty());
-/// mask.set(2);
-/// assert!(mask.test(2));
-/// mask.set(3);
-/// assert!(mask.test(3));
-/// assert_eq!(mask.weight(), 2);
+/// let mut count = 0;
+///
+/// let cpu2 = CpuId::from_u32(2);
+/// if let Some(cpu) = cpu2 {
+///     mask.set(cpu);
+///     assert!(mask.test(cpu));
+///     count += 1;
+/// }
+///
+/// let cpu3 = CpuId::from_u32(3);
+/// if let Some(cpu) = cpu3 {
+///     mask.set(cpu);
+///     assert!(mask.test(cpu));
+///     count += 1;
+/// }
+///
+/// assert_eq!(mask.weight(), count);
 ///
 /// let mask2 = CpumaskVar::try_clone(&mask).unwrap();
-/// assert!(mask2.test(2));
-/// assert!(mask2.test(3));
-/// assert_eq!(mask2.weight(), 2);
+///
+/// if let Some(cpu) = cpu2 {
+///     assert!(mask2.test(cpu));
+/// }
+///
+/// if let Some(cpu) = cpu3 {
+///     assert!(mask2.test(cpu));
+/// }
+/// assert_eq!(mask2.weight(), count);
 /// ```
 pub struct CpumaskVar {
     #[cfg(CONFIG_CPUMASK_OFFSTACK)]
-- 
2.31.1.272.g89b43f80a514


