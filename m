Return-Path: <linux-kernel+bounces-654138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 948FBABC450
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 18:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF8F34A4BAA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 16:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E265C28A1F0;
	Mon, 19 May 2025 16:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hfhd0+E9"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0977928A1CB
	for <linux-kernel@vger.kernel.org>; Mon, 19 May 2025 16:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747671461; cv=none; b=IFJzYO3XH/mTlwqcy2rie6gugsRMzZjkxfNCqbqWQgCVA2dfySRFlmomwtlAy9edR5VBamun/qA9xpiReQ5JQ6aO0DGMDF3HlyIu2hMajPikb/Eqhqte7g/qwk7F+cWyYUyp02y/82BNlZ6GldUvejdj2YD7tZPp1MKEzenGXvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747671461; c=relaxed/simple;
	bh=A2vcimdo91Db/C+CJNN9YS7LNgV+bE3hpqZjImDFRQw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R8rz2eUavcgfHer3xS8xn2KN3gS/0s2UJ8tZFcl0Ah8l2Geq2X+AJ8HFk97s4xvp37WSra+W88SAIKof1SmcLyqXdO4mmnB55D6mu09O3umNt9YVUAf60MUPwGkZuss2CA5w685Ge9DETJ7B56yTwto9QOnoxaHnghA6ahw4q1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hfhd0+E9; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43e9a3d2977so34439065e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 May 2025 09:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747671457; x=1748276257; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MSmVioyXmmwvYcQv1eghQliH8ReaGKH9UaRa1j6LEaY=;
        b=Hfhd0+E9wMYuhbvT7h6X3I6WOGqazT+SDQT0lYzgmpXbiox0OgvxkBaQy2vYkA4owS
         Kv7xyNdcFaZF5TDvOYrnujrNIQp1NMPNE2RneP30YwIkPZ5AFDA0AoyF2p8egZlnr8Ql
         5agFyzdbiNINcQ1W1ed/Y3WLwVXd0Ts+YDGABhJC/chdxtMoIrWaicEYUx1gknzE/hdJ
         7ldyIyXCrvpAyfwubKrIvCbSdEJbMacwgIAwwbAknyGZVIzClGasFo+H+XmF18DOIug/
         Ve+Z5zWXrBQlW4GGuVAMn/BTyINhJR+lSDSXGyh0HHXmvxPxIftatI08w7HWhiUsdGJ0
         dcLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747671457; x=1748276257;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MSmVioyXmmwvYcQv1eghQliH8ReaGKH9UaRa1j6LEaY=;
        b=LxQHwGAHb+3mxuB8CE3K1JxikbZ1/gHQUmD5ZD9QuL5IOA6zGX5WEtqZ4LNIX/jMNr
         WCzjTpOH4/szx+sFutUSmA67jTHH8G3uu7I+Cerchwlf5Wb9sa+VJPs0T7phqQGPcK2A
         yd43xr4IEaMvkvr8pHvIlfvpP2HMW58c2x/mSCaBybtKWjSlNY/SYm36kvYGNOkKglC4
         qaWFp5vr/0vpCGOq/0D4iG+hvEdnXmC/XXzyaMv+UyL5lGHlO4vhR4VS1tvfjxUoT+tt
         OPZryd9m7PKi5RStPmceZ9hESS5z8+pJI4d9Ra66tShVbuzMVX+heXYQPoZFGgfAkWn8
         zJpg==
X-Forwarded-Encrypted: i=1; AJvYcCXeJFHtLkWBMPpcHYZlTq4WJkj8AzzjXFIsVsc3gzZQ4EQj5zNo4obDv0FUYGCJVYn4RurALfFQmM1iEPM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0XKYKRIocJ7ZgO7czlKWjB7ZELOzGxhBVit4GM8gfMMxPTwyV
	uxtWR3Pb/9UsGsfmo8xZT8N7pA8BBSV+hKiCWexftT26cQdP8vqPDOGU4cdx7gZRyHNvFw==
X-Google-Smtp-Source: AGHT+IGml/YtjllhNJ54nIk+Ysxm78efQivAD3ThoIWPXeVgkiOEHYcUO6jbPJ9gyRT2W4tdao3tzLw=
X-Received: from wmqb16.prod.google.com ([2002:a05:600c:4e10:b0:440:68aa:44b])
 (user=bqe job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:8889:20b0:442:f44f:66f
 with SMTP id 5b1f17b1804b1-442fd672542mr85780545e9.31.1747671457562; Mon, 19
 May 2025 09:17:37 -0700 (PDT)
Date: Mon, 19 May 2025 16:17:04 +0000
In-Reply-To: <20250519161712.2609395-1-bqe@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250519161712.2609395-1-bqe@google.com>
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
Message-ID: <20250519161712.2609395-5-bqe@google.com>
Subject: [PATCH v8 4/5] rust: add find_bit_benchmark_rust module.
From: Burak Emir <bqe@google.com>
To: Yury Norov <yury.norov@gmail.com>, Kees Cook <kees@kernel.org>
Cc: Burak Emir <bqe@google.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, "Gustavo A . R . Silva" <gustavoars@kernel.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Microbenchmark protected by a config FIND_BIT_BENCHMARK_RUST,
following `find_bit_benchmark.c` but testing the Rust Bitmap API.

We add a fill_random() method protected by the config in order to
maintain the abstraction.

Suggested-by: Alice Ryhl <aliceryhl@google.com>
Suggested-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Burak Emir <bqe@google.com>
---
 MAINTAINERS                     |  1 +
 lib/Kconfig.debug               | 13 +++++
 lib/Makefile                    |  1 +
 lib/find_bit_benchmark_rust.rs  | 94 +++++++++++++++++++++++++++++++++
 rust/bindings/bindings_helper.h |  1 +
 rust/kernel/bitmap.rs           | 14 +++++
 6 files changed, 124 insertions(+)
 create mode 100644 lib/find_bit_benchmark_rust.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index 565eaa015d9e..943d85ed1876 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4132,6 +4132,7 @@ M:	Alice Ryhl <aliceryhl@google.com>
 M:	Burak Emir <bqe@google.com>
 R:	Yury Norov <yury.norov@gmail.com>
 S:	Maintained
+F:	lib/find_bit_benchmark_rust.rs
 F:	rust/kernel/bitmap.rs
 
 BITOPS API
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index f9051ab610d5..37a07559243e 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2605,6 +2605,19 @@ config FIND_BIT_BENCHMARK
 
 	  If unsure, say N.
 
+config FIND_BIT_BENCHMARK_RUST
+	tristate "Test find_bit functions in Rust"
+	help
+	  This builds the "find_bit_benchmark_rust" module. It is a micro
+          benchmark that measures the performance of Rust functions that
+          correspond to the find_*_bit() operations in C. It follows the
+          FIND_BIT_BENCHMARK closely but will in general not yield same
+          numbers due to extra bounds checks and overhead of foreign
+          function calls.
+
+	  If unsure, say N.
+
+
 config TEST_FIRMWARE
 	tristate "Test firmware loading via userspace interface"
 	depends on FW_LOADER
diff --git a/lib/Makefile b/lib/Makefile
index f07b24ce1b3f..99e49a8f5bf8 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -62,6 +62,7 @@ obj-y += hexdump.o
 obj-$(CONFIG_TEST_HEXDUMP) += test_hexdump.o
 obj-y += kstrtox.o
 obj-$(CONFIG_FIND_BIT_BENCHMARK) += find_bit_benchmark.o
+obj-$(CONFIG_FIND_BIT_BENCHMARK_RUST) += find_bit_benchmark_rust.o
 obj-$(CONFIG_TEST_BPF) += test_bpf.o
 test_dhry-objs := dhry_1.o dhry_2.o dhry_run.o
 obj-$(CONFIG_TEST_DHRY) += test_dhry.o
diff --git a/lib/find_bit_benchmark_rust.rs b/lib/find_bit_benchmark_rust.rs
new file mode 100644
index 000000000000..13830477a8d2
--- /dev/null
+++ b/lib/find_bit_benchmark_rust.rs
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: GPL-2.0
+//! Benchmark for find_bit-like methods in Bitmap Rust API.
+
+use kernel::alloc::flags::GFP_KERNEL;
+use kernel::bindings;
+use kernel::bitmap::Bitmap;
+use kernel::error::{code, Result};
+use kernel::pr_err;
+use kernel::prelude::module;
+use kernel::time::Ktime;
+use kernel::ThisModule;
+
+const BITMAP_LEN: usize = 4096 * 8 * 10;
+// Reciprocal of the fraction of bits that are set in sparse bitmap.
+const SPARSENESS: usize = 500;
+
+/// Test module that benchmarks performance of traversing bitmaps.
+struct FindBitBenchmarkModule();
+
+fn test_next_bit(bitmap: &Bitmap) {
+    let mut time = Ktime::ktime_get();
+    let mut cnt = 0;
+    let mut i = 0;
+
+    while let Some(index) = bitmap.next_bit(i) {
+        cnt += 1;
+        i = index + 1;
+    }
+
+    time = Ktime::ktime_get() - time;
+    pr_err!(
+        "next_bit:           {:18} ns, {:6} iterations\n",
+        time.to_ns(),
+        cnt
+    );
+}
+
+fn test_next_zero_bit(bitmap: &Bitmap) {
+    let mut time = Ktime::ktime_get();
+    let mut cnt = 0;
+    let mut i = 0;
+
+    while let Some(index) = bitmap.next_zero_bit(i) {
+        cnt += 1;
+        i = index + 1;
+    }
+
+    time = Ktime::ktime_get() - time;
+    pr_err!(
+        "next_zero_bit:      {:18} ns, {:6} iterations\n",
+        time.to_ns(),
+        cnt
+    );
+}
+
+fn find_bit_test() {
+    pr_err!("Start testing find_bit() Rust with random-filled bitmap\n");
+
+    let mut bitmap = Bitmap::new(BITMAP_LEN, GFP_KERNEL).expect("alloc bitmap failed");
+    bitmap.fill_random();
+
+    test_next_bit(&bitmap);
+    test_next_zero_bit(&bitmap);
+
+    pr_err!("Start testing find_bit() Rust with sparse bitmap\n");
+
+    let mut bitmap = Bitmap::new(BITMAP_LEN, GFP_KERNEL).expect("alloc sparse bitmap failed");
+    let nbits = BITMAP_LEN / SPARSENESS;
+    for _i in 0..nbits {
+        // SAFETY: BITMAP_LEN fits in 32 bits.
+        let bit: usize =
+            unsafe { bindings::__get_random_u32_below(BITMAP_LEN.try_into().unwrap()) as _ };
+        bitmap.set_bit(bit);
+    }
+
+    test_next_bit(&bitmap);
+    test_next_zero_bit(&bitmap);
+}
+
+impl kernel::Module for FindBitBenchmarkModule {
+    fn init(_module: &'static ThisModule) -> Result<Self> {
+        find_bit_test();
+        // Return error so test module can be inserted again without rmmod.
+        Err(code::EINVAL)
+    }
+}
+
+module! {
+    type: FindBitBenchmarkModule,
+    name: "find_bit_benchmark_rust_module",
+    authors: ["Rust for Linux Contributors"],
+    description: "Module with benchmark for bitmap code!",
+    license: "GPL v2",
+}
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index b6bf3b039c1b..f6ca7f1dd08b 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -31,6 +31,7 @@
 #include <linux/platform_device.h>
 #include <linux/poll.h>
 #include <linux/property.h>
+#include <linux/random.h>
 #include <linux/refcount.h>
 #include <linux/sched.h>
 #include <linux/security.h>
diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
index 943dbef7948b..fb0c687420cd 100644
--- a/rust/kernel/bitmap.rs
+++ b/rust/kernel/bitmap.rs
@@ -124,6 +124,20 @@ pub fn len(&self) -> usize {
         self.nbits
     }
 
+    /// Fills this `Bitmap` with random bits.
+    #[cfg(CONFIG_FIND_BIT_BENCHMARK_RUST)]
+    pub fn fill_random(&mut self) {
+        // SAFETY: `self.as_mut_ptr` points to either an array of the
+        // appropriate length or one usize.
+        unsafe {
+            bindings::get_random_bytes(
+                self.as_mut_ptr() as *mut ffi::c_void,
+                usize::div_ceil(self.nbits, bindings::BITS_PER_LONG as usize)
+                    * bindings::BITS_PER_LONG as usize,
+            );
+        }
+    }
+
     /// Returns a mutable raw pointer to the backing [`Bitmap`].
     #[inline]
     fn as_mut_ptr(&mut self) -> *mut usize {
-- 
2.49.0.1101.gccaa498523-goog


