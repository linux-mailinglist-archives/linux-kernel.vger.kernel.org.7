Return-Path: <linux-kernel+bounces-760685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1120BB1EECD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 21:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A29407A6EE6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 19:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439E726463B;
	Fri,  8 Aug 2025 19:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X818RuSs"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0210A78F20;
	Fri,  8 Aug 2025 19:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754680805; cv=none; b=AeARn3qO6csJ70iKR5nqlrolYKqvcsrU1o89HlwYA5O/6wSsM1DoacPK+KiA3oHjc3aQ5vTbCZhU/Qv/3WaCb+kE7Q9wvEfH00ckG3QXYVHpRaTO+DTb3PyRI2Q3Jue1hFqarHnUn4QJ7wv8sYnM1ar3XehNUEUgVxXfLS7NhWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754680805; c=relaxed/simple;
	bh=rEXSqhIYJL8RL0GStTLtjvpF5obfmNTaeHoupqhYEkA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QMZll3FlCgTXx7ZhJYWh4tFG1VpV5ABwx8HsJBdYTDSg4mkrJ/W1j/rVVxJ6r/HyT1WV7PEk2eCyc/GxDuzWOEUySSXADEop3Ye5NhiVdSrc6USmsWg7YVgiumNfxm3aIFDgc6BLXRGiK/ckQrCBzT/4Bur4mJqK5JEEbfedAp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X818RuSs; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-76bd6e84eddso3331936b3a.0;
        Fri, 08 Aug 2025 12:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754680803; x=1755285603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rkk0FV59gE6/32qGCCqmE3gD2QpzFpo2afaJLYq6+rU=;
        b=X818RuSsETot88DWKj8sq2HkF8b/9tWHsJFMJmhUEOjHU1X16BAKbgBgnGrQn7ewCy
         DK4CIcRse/55nn0M7ItRp9ikHkGcCYrpt0Tc3p4vUNfxCn+f18987enEXxHe3S6t+tyN
         ZEAuWVnKVeaTo4VPmTvkEdqWIM52y0tDNzo76XXvJY8qTeQzjAIs872uCUBe0Zku5Msp
         XcvzeTWLfxxP0lRBGwwjCbdDWAV5t3vhegkvp6I93dOHbS3QNzS9vWJQ9zi3tFzuFuyJ
         TlSyaMVG+tGEqy72zRmL1hm6stQp1pJR/tfBBCwY83tdRkJ8L4W+Pjur3jYLZH9nGLAM
         9DXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754680803; x=1755285603;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rkk0FV59gE6/32qGCCqmE3gD2QpzFpo2afaJLYq6+rU=;
        b=JjI2Xq2bdP/N4/URu3RPgoaAzryUiJNemgvq3clSREoVAoL03+anGVxCE4oqLwkyb7
         jxdQywEkfhhMLI95zw/r2xXHUyNKU8CjsBFIlY4Wi+MAz8zlw50c9SXPiMsg9oN+f2HR
         zmdvADFeTQ4bQf61J9b6/3R8KhlcY8FFFsR/FyoAnH+jfFmqpJz4MUiUOPC1pK6AsSy1
         0d0syLPcwFvXG5A0xyKYcZAElvaXAt0RRhEfXxIveLgAhEwuhZh0JmwFtQNaFIq2or31
         tEvbQneS1e4E1EXY1iaFoP4eQXER28ZT6hZvQs4/XUqNf3IxGEECIydwveKgw9Dyvloi
         nXXw==
X-Forwarded-Encrypted: i=1; AJvYcCViDwucxIaMTR9Jhe6/sHj0Zy4HbCNYCKbKyZQaL3qdyJxLr1bgd8GgKerWo3EWSD1fUNKNkCny/pAUpA4k4A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yybm6BfYrTJ5/vCeq3JJL2jpgL/SiorD/i4Q1XwI51A3erm2s70
	cVghpUS9jh51LoBYxg2AKWkT++ce8jEvOoXSmu4Lht219DssUZk1Dc99
X-Gm-Gg: ASbGncv6yulhv6Yc3bkY+20/I1uyCl7xEImNwiCjj9y6hCSTRB23DVD0kXYfcfRt61K
	uqCgAmhHmq2EBDtUDpJThRYAi+XV+nl9fz0W9RNEk3ltWcwiMSk7Bq8uagmBZ+xdAbtj/MpWz58
	68u5/CRfMoLuHtTUu0ilPdo4jd0b3tmB3atYftaH/OlQQa6kJzmz3yGDe3jIoAkzu7w1rPzHO0a
	RbbuZLGaLi8H2f/NyGlbGOs3x6dIx483RJyh7Y9xioLJXX2O4Dp9j0cxs+ZcUdHql1+NanUz3IU
	5zvZcGmxAHa2ItNj/oJQ0ceRfVNt9ntxS9V6yYyxdAXue4xI3FRlB362OZYEqcOM8xIDuO29tOS
	dQh6Fm3YGSCO6o1s=
X-Google-Smtp-Source: AGHT+IFWT1quZkc+Wym8Obb3ixgTPzjdxARDcTVN3LXG3Jsel/sTqKb74sGawQGdtqMXqIvwa+bwYA==
X-Received: by 2002:a05:6a20:4304:b0:231:acae:1983 with SMTP id adf61e73a8af0-2405501a3cdmr6537222637.3.1754680803161;
        Fri, 08 Aug 2025 12:20:03 -0700 (PDT)
Received: from fedora ([49.36.193.217])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422b7d9e30sm18144995a12.25.2025.08.08.12.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 12:20:02 -0700 (PDT)
From: Ritvik Gupta <ritvikfoss@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: [PATCH v4] rust: kernel: introduce `unsafe_precondition_assert!` macro
Date: Sat,  9 Aug 2025 00:47:49 +0530
Message-ID: <20250808192005.209188-1-ritvikfoss@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Introduce a new `safety` module containing `unsafe_precondition_assert!`
macro. It is a wrapper around `debug_assert!`, intended for validating
pre-conditions of unsafe function.

When `CONFIG_RUST_DEBUG_ASSERTIONS` flag is enabled, this macro performs
runtime checks to ensure that the preconditions for unsafe function hold.
Otherwise, the macro is a no-op.

Suggested-by: Miguel Ojeda <ojeda@kernel.org>
Link: https://github.com/Rust-for-Linux/linux/issues/1162
Link: https://rust-for-linux.zulipchat.com/#narrow/channel/291566-Library/topic/.60unsafe_precondition_assert.60.20macro/with/528457452
Signed-off-by: Ritvik Gupta <ritvikfoss@gmail.com>
---

Changes in v4:
 - Change doc example
 - Add `no_run` attribute to the doc example
 - Link to v3: https://lore.kernel.org/rust-for-linux/20250731111234.28602-1-ritvikfoss@gmail.com/

Changes in v3:
 - Change doc example
 - Link to v2: https://lore.kernel.org/all/20250730181420.6979b4f1@eugeo/T/#m9cd35a8fc02a18bd03934c7ecdcffe8667b5fbbd

Changes in v2:
 - Wrap `debug_assert!` internally instead of using `pr_err!` with `assert!` + `cfg!(debug_assertions)
 - Print “unsafe precondition(s) violated” only on assertion failure (no longer always printed)
 - Use `# Safety` section instead of comment in the example
 - Rename module-level doc
 - Link to v1: https://lore.kernel.org/rust-for-linux/20250716045957.39732-1-ritvikfoss@gmail.com/

---
 rust/kernel/lib.rs    |  1 +
 rust/kernel/safety.rs | 48 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)
 create mode 100644 rust/kernel/safety.rs

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index ed53169e795c..5eb301685ce8 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -113,6 +113,7 @@
 pub mod rbtree;
 pub mod regulator;
 pub mod revocable;
+pub mod safety;
 pub mod security;
 pub mod seq_file;
 pub mod sizes;
diff --git a/rust/kernel/safety.rs b/rust/kernel/safety.rs
new file mode 100644
index 000000000000..880307a5fbf4
--- /dev/null
+++ b/rust/kernel/safety.rs
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Safety related APIs.
+
+/// Checks that preconditions of an unsafe function are followed.
+///
+/// The check is enabled at runtime if debug assertions (`CONFIG_RUST_DEBUG_ASSERTIONS`)
+/// are enabled. Otherwise, this macro is no-op.
+///
+/// # Examples
+///
+/// ```no_run
+/// # use kernel::unsafe_precondition_assert;
+/// # use kernel::cpu::{nr_cpu_ids, CpuId};
+/// /// Creates a [`CpuId`] from the given `id` without bound checks.
+/// ///
+/// /// # Safety
+/// ///
+/// /// The caller must ensure that `id` is a valid CPU ID (i.e, `0 <= id < nr_cpu_ids()`).
+/// unsafe fn new_cpu_id_unchecked(id: i32) -> CpuId {
+///     let max_cpus = nr_cpu_ids();
+///
+///     unsafe_precondition_assert!(id >= 0, "id ({}) must be positive", id);
+///
+///     unsafe_precondition_assert!(
+///         id < max_cpus, "id ({}) must be less than total CPUs ({})", id, max_cpus
+///     );
+///
+///     CpuId(id)
+/// }
+/// ```
+///
+/// # Panics
+///
+/// Panics if the expression is evaluated to `false` at runtime.
+#[macro_export]
+macro_rules! unsafe_precondition_assert {
+    ($cond:expr $(,)?) => {
+        $crate::unsafe_precondition_assert!(@inner $cond, ::core::stringify!($cond))
+    };
+
+    ($cond:expr, $($arg:tt)+) => {
+        $crate::unsafe_precondition_assert!(@inner $cond, ::core::format_args!($($arg)+))
+    };
+
+    (@inner $cond:expr, $msg:expr) => {
+        ::core::debug_assert!($cond, "unsafe precondition(s) violated: {}", $msg) };
+}

base-commit: 37816488247ddddbc3de113c78c83572274b1e2e
-- 
2.50.1


