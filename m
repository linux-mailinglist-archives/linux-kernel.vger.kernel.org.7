Return-Path: <linux-kernel+bounces-887459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB4EC384A4
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 00:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 35C904F8889
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 23:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE65F2F5A06;
	Wed,  5 Nov 2025 23:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uuytsrba"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35EC2F5A13
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 23:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762383756; cv=none; b=UTOvhj5rX4Xb6a3PGE4IIxoiRWnnXYgJUMqc/rem3yCgkLSA314oLUaSJ9OBrSn3AOz4g3IIcUdAzwmhWm6YB1mBzx4/DXY5VDoPkT9GM5ny/5/CVcmbwBx2JOGZ9zc9E0PQHUMPArZChL2SxClVF2moMMm/G1fMJkagxgjqLgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762383756; c=relaxed/simple;
	bh=ZGvpIhEgvWXGktZnhxfrMhN6hR7bkbAJOIhXp5Aq0Rs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ojLsDGYJ/oNeqju5P6vj87cCbgL4NobPvO70IiO11m8J3qmFjqwHvCvPQS/zjNqT2AdNyKIJmJRQX5DvHXl1wVJjBFcwz7dCSejcNR5mrMOq58jskJtKedVbCBTBz8tUFNnxVbykorMFZEZhpmY6bxlQD7MAGHK3ACgJEe86G1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uuytsrba; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2958db8ae4fso3308715ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 15:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762383754; x=1762988554; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=haGIr4TbAT28iZId1iIOWFqS56QerIllmXw1VE5QblA=;
        b=UuytsrbaALw8Q5my2uOdnsTlCl7N3PwpZgL1QKU9gzr2mDh+ngFN9PS0mYe+ixJ1Li
         GcXRXU43zsoSSx3SjBg0hhOj0vJ54NeTDGUdlcNfVYZK/ZTmNoIHais+uc3Qas479OuO
         orRtwpyKxE1xesyYc2jUb3GSeBKyyTZ+9lqF5qkFEImtkDGH4njnN27xDIybicFIaqIK
         qLQm5soW3ECVa3WvG8Yv0bLitxwgwOOB/VLKtiGevttZoLo77B8FEXjVJ7MNmbKNj0tZ
         ka+WoHqCe4T1tC368mSo2dLzo210tAU8JoJMgZQ8jz1ETY6iE54td43AQawKlwo/PWH+
         zfHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762383754; x=1762988554;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=haGIr4TbAT28iZId1iIOWFqS56QerIllmXw1VE5QblA=;
        b=tA4ORuXAClPaWD98pXNgh9rOcCmtSx2dJ7qytEVwBtLZf9D5dTibH4qMnUP9yfT7cS
         OaWY1gypfBaS2BmhPYyecPYWEdHharV9i/m83nwOJD8eYkAoUTn06TuRbJCJ98JogFrK
         vUM81vd4A3BEOVUZFYUxqbPnLZujHwGtlBcddaBYt2Xmg/Rc+rie48t2RRupUmfJ9ATs
         W5v5lK4S13DKZePOgqM+ZZ3iUAXhkyrtiBgvdPTKliD3kFu7IiUK26dZJY5r6Qr2OsU/
         k9/Yc00QjQ1buxk8705Ysx99cwTUS5vkoMidcjyEGyjGsSxiBLkCL9vePVZ06QyJGb0R
         9Z5g==
X-Forwarded-Encrypted: i=1; AJvYcCVjz8GUOEwIOqrQvSxWk51jlKCmrFj3RpgZR8BUAu7aQJpDSI4WwjqT5LLfMLMr2mB5dTpaHIYzycVtvq4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcb9fPQkAJimGoJfAkjLkgRQo03+z8PCuCl6PrlKEF8pGJKoEk
	hudv0h0dXKevj6NSzflQX4oGLAx18fuxib0ibdvwS1wMbOE/ys9/PoDj
X-Gm-Gg: ASbGnctgnXE/BeHmCuV4ghLMfOZS0cZGEdZVCsx3mUu3Ou07WH5t0incwnqc0qEeNhc
	QZeQIxMjsyjs4fUkBgD2NgvesE1iSTcu560PbpN8uLLyGhY924DK9/4/1vMaDzbFoy0GFbt+He+
	7q23wskUP0TCJaG57agmnEHy7OTrkLt+6E5zeZGv7ijFcFKDtDIc2j5lUmCDFikEws2UuanW0CZ
	dukMHNEq4sJRc2HCJJpRjw1FiiU6SDwgc/YnDQR48ONRuCvLe7CqqNmJhSjTFHwiH563iYMeF+f
	kW6zq0+JppzsknCZMWmyo3D0Gd5vqjROaGFkUu1IQtwBXctXjAFSl7UH5snTBQtv3Ciw/czKNoJ
	9XJCFEDIcwonwGsGmECgivx9okLOpsybzgxQHFf29vm2vErqNystmO4qFqRt3wwcMCnYrSj6+AM
	UZoGJfocAQ3uEMBS8AcfKCmnQ=
X-Google-Smtp-Source: AGHT+IFzjVuv6+fLc44rVR+754fMYDUlRbQZwzak3bXpRrpiq+jgHmjdZ9t766A4/ZV9UsiO7XyL/w==
X-Received: by 2002:a17:902:f647:b0:295:ceaf:8d76 with SMTP id d9443c01a7336-2962add07f1mr64418025ad.47.1762383753899;
        Wed, 05 Nov 2025 15:02:33 -0800 (PST)
Received: from mitchelllevy.localdomain ([131.107.147.147])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2965096839asm6325645ad.13.2025.11.05.15.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 15:02:32 -0800 (PST)
From: Mitchell Levy <levymitchell0@gmail.com>
Date: Wed, 05 Nov 2025 15:01:18 -0800
Subject: [PATCH v4 6/9] rust: percpu: add a rust per-CPU variable sample
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-rust-percpu-v4-6-984b1470adcb@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762383744; l=8909;
 i=levymitchell0@gmail.com; s=20240719; h=from:subject:message-id;
 bh=ZGvpIhEgvWXGktZnhxfrMhN6hR7bkbAJOIhXp5Aq0Rs=;
 b=ozCkxX8AZS18Od5RqpDdJAKT5PuC+PMadw19K3gHEt4Arzb8pfY48uoQC0iTTZKu5yH9GvgEW
 af2cVxSKoMTDgAGQOQCroH9OOVN/z/g6/S42VKg++yjX4kPceoA4rk9
X-Developer-Key: i=levymitchell0@gmail.com; a=ed25519;
 pk=n6kBmUnb+UNmjVkTnDwrLwTJAEKUfs2e8E+MFPZI93E=

Add a short exercise for Rust's per-CPU variable API, modelled after
lib/percpu_test.c

Signed-off-by: Mitchell Levy <levymitchell0@gmail.com>
---
 rust/helpers/percpu.c       |   1 +
 rust/kernel/percpu.rs       |   2 +-
 samples/rust/Kconfig        |   9 +++
 samples/rust/Makefile       |   1 +
 samples/rust/rust_percpu.rs | 163 ++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 175 insertions(+), 1 deletion(-)

diff --git a/rust/helpers/percpu.c b/rust/helpers/percpu.c
index 35656333dfae..8d83b6b86106 100644
--- a/rust/helpers/percpu.c
+++ b/rust/helpers/percpu.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <linux/percpu.h>
+#include <linux/smp.h>
 
 void __percpu *rust_helper_alloc_percpu(size_t sz, size_t align)
 {
diff --git a/rust/kernel/percpu.rs b/rust/kernel/percpu.rs
index 294b8ffc4f62..2db670c87fae 100644
--- a/rust/kernel/percpu.rs
+++ b/rust/kernel/percpu.rs
@@ -2,7 +2,7 @@
 //! Per-CPU variables.
 //!
 //! See the [`crate::define_per_cpu!`] macro, the [`DynamicPerCpu`] type, and the [`PerCpu<T>`]
-//! trait.
+//! trait. Example usage can be found in `samples/rust/rust_percpu.rs`.
 
 pub mod cpu_guard;
 mod dynamic;
diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
index 7f7371a004ee..23e35d64ac78 100644
--- a/samples/rust/Kconfig
+++ b/samples/rust/Kconfig
@@ -105,6 +105,15 @@ config SAMPLE_RUST_DRIVER_AUXILIARY
 
 	  If unsure, say N.
 
+config SAMPLE_RUST_PERCPU
+	tristate "Per-CPU support"
+	depends on m
+	help
+	  Enable this option to build a module which demonstrates Rust per-CPU
+	  operations.
+
+	  If unsure, say N.
+
 config SAMPLE_RUST_HOSTPROGS
 	bool "Host programs"
 	help
diff --git a/samples/rust/Makefile b/samples/rust/Makefile
index bd2faad63b4f..8a34d9d74754 100644
--- a/samples/rust/Makefile
+++ b/samples/rust/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_SAMPLE_RUST_DRIVER_PLATFORM)	+= rust_driver_platform.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_FAUX)		+= rust_driver_faux.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_AUXILIARY)	+= rust_driver_auxiliary.o
 obj-$(CONFIG_SAMPLE_RUST_CONFIGFS)		+= rust_configfs.o
+obj-$(CONFIG_SAMPLE_RUST_PERCPU)		+= rust_percpu.o
 
 rust_print-y := rust_print_main.o rust_print_events.o
 
diff --git a/samples/rust/rust_percpu.rs b/samples/rust/rust_percpu.rs
new file mode 100644
index 000000000000..98ca1c781b6b
--- /dev/null
+++ b/samples/rust/rust_percpu.rs
@@ -0,0 +1,163 @@
+// SPDX-License-Identifier: GPL-2.0
+//! A simple demonstration of the rust per-CPU API.
+
+use core::cell::RefCell;
+use core::ffi::c_void;
+
+use kernel::{
+    bindings::on_each_cpu,
+    cpu::CpuId,
+    define_per_cpu, get_static_per_cpu,
+    percpu::{cpu_guard::*, *},
+    pr_info,
+    prelude::*,
+};
+
+module! {
+    type: PerCpuMod,
+    name: "rust_percpu",
+    authors: ["Mitchell Levy"],
+    description: "Sample to demonstrate the Rust per-CPU API",
+    license: "GPL v2",
+}
+
+struct PerCpuMod;
+
+define_per_cpu!(PERCPU: i64 = 0);
+define_per_cpu!(UPERCPU: u64 = 0);
+define_per_cpu!(CHECKED: RefCell<u64> = RefCell::new(0));
+
+impl kernel::Module for PerCpuMod {
+    fn init(_module: &'static ThisModule) -> Result<Self, Error> {
+        pr_info!("rust percpu test start\n");
+
+        let mut native: i64 = 0;
+        let mut pcpu: StaticPerCpu<i64> = get_static_per_cpu!(PERCPU);
+
+        // SAFETY: We only have one PerCpu that points at PERCPU
+        unsafe { pcpu.get_mut(CpuGuard::new()) }.with(|val: &mut i64| {
+            pr_info!("The contents of pcpu are {}\n", val);
+
+            native += -1;
+            *val += -1;
+            pr_info!("Native: {}, *pcpu: {}\n", native, val);
+            assert!(native == *val && native == -1);
+
+            native += 1;
+            *val += 1;
+            pr_info!("Native: {}, *pcpu: {}\n", native, val);
+            assert!(native == *val && native == 0);
+        });
+
+        let mut unative: u64 = 0;
+        let mut upcpu: StaticPerCpu<u64> = get_static_per_cpu!(UPERCPU);
+
+        // SAFETY: We only have one PerCpu pointing at UPERCPU
+        unsafe { upcpu.get_mut(CpuGuard::new()) }.with(|val: &mut u64| {
+            unative += 1;
+            *val += 1;
+            pr_info!("Unative: {}, *upcpu: {}\n", unative, val);
+            assert!(unative == *val && unative == 1);
+
+            unative = unative.wrapping_add((-1i64) as u64);
+            *val = val.wrapping_add((-1i64) as u64);
+            pr_info!("Unative: {}, *upcpu: {}\n", unative, val);
+            assert!(unative == *val && unative == 0);
+
+            unative = unative.wrapping_add((-1i64) as u64);
+            *val = val.wrapping_add((-1i64) as u64);
+            pr_info!("Unative: {}, *upcpu: {}\n", unative, val);
+            assert!(unative == *val && unative == (-1i64) as u64);
+
+            unative = 0;
+            *val = 0;
+
+            unative = unative.wrapping_sub(1);
+            *val = val.wrapping_sub(1);
+            pr_info!("Unative: {}, *upcpu: {}\n", unative, val);
+            assert!(unative == *val && unative == (-1i64) as u64);
+            assert!(unative == *val && unative == u64::MAX);
+        });
+
+        let mut checked_native: u64 = 0;
+        let mut checked: StaticPerCpu<RefCell<u64>> = get_static_per_cpu!(CHECKED);
+        checked.get(CpuGuard::new()).with(|val: &RefCell<u64>| {
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
+        pr_info!("rust static percpu test done\n");
+
+        pr_info!("rust dynamic percpu test start\n");
+        let mut test: DynamicPerCpu<u64> = DynamicPerCpu::new_zero(GFP_KERNEL).unwrap();
+
+        // SAFETY: No prerequisites for on_each_cpu.
+        unsafe {
+            on_each_cpu(Some(inc_percpu), (&raw mut test).cast(), 0);
+            on_each_cpu(Some(inc_percpu), (&raw mut test).cast(), 0);
+            on_each_cpu(Some(inc_percpu), (&raw mut test).cast(), 0);
+            on_each_cpu(Some(inc_percpu), (&raw mut test).cast(), 1);
+            on_each_cpu(Some(check_percpu), (&raw mut test).cast(), 1);
+        }
+
+        pr_info!("rust dynamic percpu test done\n");
+
+        // Return Err to unload the module
+        Result::Err(EINVAL)
+    }
+}
+
+extern "C" fn inc_percpu(info: *mut c_void) {
+    // SAFETY: We know that info is a void *const DynamicPerCpu<u64> and DynamicPerCpu<u64> is Send.
+    let mut pcpu = unsafe { (*(info as *const DynamicPerCpu<u64>)).clone() };
+    pr_info!("Incrementing on {}\n", CpuId::current().as_u32());
+
+    // SAFETY: We don't have multiple clones of pcpu in scope
+    unsafe { pcpu.get_mut(CpuGuard::new()) }.with(|val: &mut u64| *val += 1);
+}
+
+extern "C" fn check_percpu(info: *mut c_void) {
+    // SAFETY: We know that info is a void *const DynamicPerCpu<u64> and DynamicPerCpu<u64> is Send.
+    let mut pcpu = unsafe { (*(info as *const DynamicPerCpu<u64>)).clone() };
+    pr_info!("Asserting on {}\n", CpuId::current().as_u32());
+
+    // SAFETY: We don't have multiple clones of pcpu in scope
+    unsafe { pcpu.get_mut(CpuGuard::new()) }.with(|val: &mut u64| assert!(*val == 4));
+}

-- 
2.34.1


