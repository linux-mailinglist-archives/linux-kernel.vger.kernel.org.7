Return-Path: <linux-kernel+bounces-600012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EFEA85AF8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 13:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ABF18C014B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 11:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FCEB29CB35;
	Fri, 11 Apr 2025 10:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NviPOeo7"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A32238C3B
	for <linux-kernel@vger.kernel.org>; Fri, 11 Apr 2025 10:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744369175; cv=none; b=lwk0/lzvCtbNO6eY0AZjAxcN5XmoKrvubMB+Umz/tEIYpNpvAMBxqFWigQRq8rLUkEVDFdpgZ1wrPhy+bq7QHvHgNjCm/YQHjV45jeXO7L57jezSPKaUMz/W4bG8qktYMtvxJmsDadcRD8gPgIg1EiGrjrr8oBx/3FNrzvFsfhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744369175; c=relaxed/simple;
	bh=Byyja/LGiSc3XLWcrkh1dI+1vAbHiMVZxbMK+5UoA5o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IIB8tssNsrjY8+PxnoLdR+IRuJMNlT7gGkOc/EUNnY9MqwWEbPDwiZaYUFJFZv30J+1ifbexS+0+93eNI/83crD8WkQGRJ+2pMhyk7fBgglp/sHDpSe+p9UN9LmzHLe9oXWJVuVPBmCvazBqoqI8hN5xDZuwnCVqkD6w2hpGOIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NviPOeo7; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-224100e9a5cso20105975ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Apr 2025 03:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744369172; x=1744973972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+Cdlcrsb0s4b6sV0qOOxY8kfU8SJ6MQU1RsCnBdvL8=;
        b=NviPOeo7m3bFs5pclrqrdwRClbuZnskMh3kDwmyCLhpG6vx0y5kNuvQy0ptCfR2kIV
         isIsXyzsUD43cHj4bHOb0gH30PK6Ms1K4KJb5XB0jG4UnYQZI/axscoqEnCgBjoz5v7Q
         zm/bLEWYGa9uEXQ/Z73wkCSwvs+LWyPeQpabb/BEkVSEGVWr4tMxRw3WlsGzpNfAN6QB
         PjvYo+FAxeNP4OkWTARWwwtpfwbKdNa3X1lbHLQBViLaCSG3iI070sGCoJvh/0Xu3T5I
         X1+yH4xM48ZXzADajDpkjisY5Zv/3OVGl34+mIKIdORm8HZBw3kFG1gGeM4Fxae4xUMQ
         oSuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744369172; x=1744973972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X+Cdlcrsb0s4b6sV0qOOxY8kfU8SJ6MQU1RsCnBdvL8=;
        b=oXttBIi2Evws4sIQDmYuiDhTt0yWcqTNQb9Qsuo3U3tV3eocbzeWJTHw0wYFjmap/s
         PxoPubpRDRRd/9bQ0dMGnikDW5a6fhzaFdgRZnSCz3RRy2d0vYPWl35wd/W8D1BnJ3oI
         BK+utun6G9C6mNEa0KO2ILBFpavixWmeSZ1BTELiNcITrrQ9hF/M8tMSTWvNrr//NRz1
         DL+IFBDySz0mgMTITyc/44bRmH+k0gej5VMQJOzB5/3rJDZbR8uJ20TusdTj34g5Xr4E
         oBc5aMD5NqfBZ5Pl3ouSvhPH6J5QfX1sol2suOSjEUWJyU52ANQORZiZl/uaIuMyZpR4
         uR5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVXh1OSsa5owQjL4Y4z9OCM0jXX5zNoyxtKG8xAg5PShYCYw4VOn8DgBFHt9NLDdx8sxkN5p9yPaA5H6eo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD2WCfPcbFv0Mxet1t78JEewwsBFjyk3GXvnS6rU85pyhNdB+Z
	WirGNrqjGkYhP7feF1U1xKkOyYw1g/3VUfTv1Q3DoRdDok/82qLxW99K74QFteAH//2L9kjOfps
	w
X-Gm-Gg: ASbGnctOxtK5zMrlScP3m3F06CpIxb2D9ZwAzMOrESbb+CMpbGnglW4HIeRCdlaS+LM
	gETzvbPEGeOk/NHFvG+CkRBLz53Fk5g9JSEf316d5n/TRkv3y4mlYtqO8Nc14HRo3TVF5M3FJVo
	CcqZ2/kSlEUXp+7EMqAyhLdIh2fdtIM6HF1DN2Ol3ZRR7bCJ/BPqsLnYFX8w0y0S8dQVinnu1vn
	56pSG7k0EE2V0O0Rsmpd5mckqyWfx32nghttFi2/1Ei+6/jsGzCFp/c8UxmVjaIQF2zadgbM8G9
	DmM0x8D7hpxgfFZzeKysS6iWtDh4xYF6N884c01gag==
X-Google-Smtp-Source: AGHT+IFzxhsDTNlU/qz7rOhat5Sn8AXMBCAAIpk2YH/+AobNOEjEcLNAinjLGlCu2Vf5XXJJin63Pw==
X-Received: by 2002:a17:902:e751:b0:224:2715:bf44 with SMTP id d9443c01a7336-22bea4ab7a0mr31283275ad.19.1744369172173;
        Fri, 11 Apr 2025 03:59:32 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7c95c8esm45981535ad.145.2025.04.11.03.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 03:59:31 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Erik Schilling <erik.schilling@linaro.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Yury Norov <yury.norov@gmail.com>,
	Burak Emir <bqe@google.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Russell King <linux@armlinux.org.uk>,
	linux-clk@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH V9 09/17] rust: cpu: Add from_cpu()
Date: Fri, 11 Apr 2025 16:25:08 +0530
Message-Id: <475bc73d8d11290446a4135af76aea123c6d80ee.1744366571.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1744366571.git.viresh.kumar@linaro.org>
References: <cover.1744366571.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This implements cpu::from_cpu(), which returns a reference to
Device for a CPU. The C struct is created at initialization time for
CPUs and is never freed and so ARef isn't returned from this function.

The new helper will be used by Rust based cpufreq drivers.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 MAINTAINERS                     |  1 +
 rust/bindings/bindings_helper.h |  1 +
 rust/kernel/cpu.rs              | 31 +++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |  1 +
 4 files changed, 34 insertions(+)
 create mode 100644 rust/kernel/cpu.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index 12cde55579a0..475abf72869c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6155,6 +6155,7 @@ F:	include/linux/cpuhotplug.h
 F:	include/linux/smpboot.h
 F:	kernel/cpu.c
 F:	kernel/smpboot.*
+F:	rust/kernel/cpu.rs
 
 CPU IDLE TIME MANAGEMENT FRAMEWORK
 M:	"Rafael J. Wysocki" <rafael@kernel.org>
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index f53d6e1a21f2..ac92c67d2c38 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -11,6 +11,7 @@
 #include <linux/blk_types.h>
 #include <linux/blkdev.h>
 #include <linux/clk.h>
+#include <linux/cpu.h>
 #include <linux/cpumask.h>
 #include <linux/cred.h>
 #include <linux/device/faux.h>
diff --git a/rust/kernel/cpu.rs b/rust/kernel/cpu.rs
new file mode 100644
index 000000000000..3054165d3818
--- /dev/null
+++ b/rust/kernel/cpu.rs
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Generic CPU definitions.
+//!
+//! C header: [`include/linux/cpu.h`](srctree/include/linux/cpu.h)
+
+use crate::{bindings, device::Device, error::Result, prelude::ENODEV};
+
+/// Creates a new instance of CPU's device.
+///
+/// # Safety
+///
+/// Reference counting is not implemented for the CPU device in the C code. When a CPU is
+/// hot-unplugged, the corresponding CPU device is unregistered, but its associated memory
+/// is not freed.
+///
+/// Callers must ensure that the CPU device is not used after it has been unregistered.
+/// This can be achieved, for example, by registering a CPU hotplug notifier and removing
+/// any references to the CPU device within the notifier's callback.
+pub unsafe fn from_cpu(cpu: u32) -> Result<&'static Device> {
+    // SAFETY: The pointer returned by `get_cpu_device()`, if not `NULL`, is a valid pointer to
+    // a `struct device` and is never freed by the C code.
+    let ptr = unsafe { bindings::get_cpu_device(cpu) };
+    if ptr.is_null() {
+        return Err(ENODEV);
+    }
+
+    // SAFETY: The pointer returned by `get_cpu_device()`, if not `NULL`, is a valid pointer to
+    // a `struct device` and is never freed by the C code.
+    Ok(unsafe { Device::as_ref(ptr) })
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index f4dcfefe94be..db372f806875 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -44,6 +44,7 @@
 pub mod build_assert;
 #[cfg(CONFIG_COMMON_CLK)]
 pub mod clk;
+pub mod cpu;
 pub mod cpumask;
 pub mod cred;
 pub mod device;
-- 
2.31.1.272.g89b43f80a514


