Return-Path: <linux-kernel+bounces-751093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C507B16533
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84CFC5621CC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 17:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B17A2DEA8A;
	Wed, 30 Jul 2025 17:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="McuJ3ANK"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2571DFDAB
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 17:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753895496; cv=none; b=FQ/Pv9d0RAB/1ArHb8APMYmywrD1jfDXLvbntSzRuwE22StUw823fYwpFhfLrydV3eJ6nRHG3c08Bcbpnx2Gw8kVyGr8E8uOlB9yReQaax35hdUE2BU/sRtWZMMr5uQuN1qayaZrX7KvoU8CtPMMphJZcjln0WcXKMZeiVhrJVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753895496; c=relaxed/simple;
	bh=lTl7O86CdhVhsw1u1JWo7BeSkjr0eOliuXXvn2a2Qd8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VsfBy7sL66m+cLrRC+2BuEmalQ25J/CJzmdKCufcDBW/nhjaqZ0R6OXJ0YokL5ij6DXtuJDxojtNZgVA0VvTV/DZTX4oj7vIBnaBR1CjR1BUSwOxIVda7/inaHeb+uLS9E6sOBde76IvvGeX+VXuqMC/pqViSwGw6WP3C1zvkEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=McuJ3ANK; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-71a4742d81aso355937b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 10:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753895493; x=1754500293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2A3aGElXexFcgB7X8Jk+vj1U/1B6G7ycFxlimZHTXrQ=;
        b=McuJ3ANKb2OrxBNzXyfk2ZmbEXA25MluJXI3v25AcPmAqZNmdghjSSsy2aSBo8VgpF
         hNdYTALxl3EP55Cbt3TXFMiPulceMQepcHrDlvPa3iQrvYdRsJ339MSSqLkpdAT3kW7Z
         eQn3cA+ZhdmIY/jxR/2YSjvioXczjXzaqv+1+be2L6mjeqkmLIgQAu3lMb4sJTdnelQ0
         +8bCVTg+8km+MuAnQhS7OxPflGpxZiY8eUNqlX3zYsHq/i93qX+7xtmurnB1btyiwV7y
         ahU/QU+xgiYgYwuiopy8xdNEDqyp2QPFhrpKWcCKAZXXN3GE9HPn+M8Pt5cdOOKgf3cj
         QANA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753895493; x=1754500293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2A3aGElXexFcgB7X8Jk+vj1U/1B6G7ycFxlimZHTXrQ=;
        b=S1uvGgljiGqJBzYtI/3os1pA3AV85t0A/YFk+tIkkli8P0a4j8y/FdBjGdJGTfw0wG
         ENWMNST+o2Ku05BZc99ZvN3wF0EmXhVseAjJVXSjzAD+eoK1zE8tmHHqJAf/rCvxGtPY
         7kpk+dA43WNSsnzwpVCW3e6QPFno5rCN1oi+jedSXG5QT/tziHupBK2oxmbWav7DBwYU
         6LOspDqxXEwX3S8J5jkbI5igNB0WUcV3Bn4x0Ug7UCciecfLIZj+F83keUXq2hkJ+Lu8
         xJvMdPNDtVNLr5fskrPOGWpW6q3zAb/7I9kX3QsB13CsXXEGd/7YV4UdNm8ofnE9Q/un
         l1CQ==
X-Forwarded-Encrypted: i=1; AJvYcCWk1D+ZFgqNh4c48KUUmNwtqQ/XH2BEgFT04OjO+1TTgizfgL93IuKrhmdFLxQ7xGU690ONIEwF/Dc+b4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv5MHkS8/3tqhZZnLn7wzKoFwpIgPrnbQH6SI+3YymYuoRnu/M
	b6yO/U7bfDwiiYZOaKBFX2n4hzk2kf3W5zlqQb63tMwAmkEzmkts9Z2c
X-Gm-Gg: ASbGncsiPqF8Pz/OFb3oT/2b1fBgYrO5j4eAxgcAW3tnttJmDqVhykfpSDYJZpXtq9B
	vcRLBboclsB8EnbTMHI4IGeXTv0X+80rv6GM4II12ROPWPCdwKwTXJuKztFcSpj+L2n+0tK67S2
	LeyNjXubJJpGTkzGStWd+Y+nNREpl97JvXGFl/8ae51rQURT16684sIj6nTtpYbGeP2L/bL4Tzv
	WPXwk/JrUbBeu26JkxLLPgmtUC+Oc8yFCQ/CAPR3FfDfg3Ex3yls2EslTPgrkRq57nrOeOzdhi7
	WeqbzwsiiZmbnrvCbYyu89ZJsBjCny3uRXGVjdaNsXsM5wVnUD4ub8g+t1p75XcU0vO6bMVCnVJ
	h34W1swIgSZzLdAZj7bE=
X-Google-Smtp-Source: AGHT+IFKQ+bQ+/QNw1rg1hdJMWQ/KdH3tix2n6+c1/4gC1YrA5k5p0YSdJstLz4ryFRl5TGFE0/5OQ==
X-Received: by 2002:a05:6902:1896:b0:e8e:187:c22c with SMTP id 3f1490d57ef6-e8e314c3e74mr5307621276.14.1753895493311;
        Wed, 30 Jul 2025 10:11:33 -0700 (PDT)
Received: from fedora ([2405:201:5501:4085:eece:e0ff:6b68:de2e])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8e0ebdb2aesm2861189276.31.2025.07.30.10.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 10:11:32 -0700 (PDT)
From: Ritvik Gupta <ritvikfoss@gmail.com>
To: ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org
Subject: [PATCH v2] rust: kernel: introduce `unsafe_precondition_assert!` macro
Date: Wed, 30 Jul 2025 22:41:28 +0530
Message-ID: <20250730171132.159917-1-ritvikfoss@gmail.com>
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

Changes in v2:
 - Wrap `debug_assert!` internally instead of using `pr_err!` with `assert!` + `cfg!(debug_assertions)
 - Print “unsafe precondition(s) violated” only on assertion failure (no longer always printed)
 - Use `# Safety` section instead of comment in the example
 - Rename module-level doc
 - Link to v1: https://lore.kernel.org/rust-for-linux/20250716045957.39732-1-ritvikfoss@gmail.com/

---
 rust/kernel/lib.rs    |  1 +
 rust/kernel/safety.rs | 52 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)
 create mode 100644 rust/kernel/safety.rs

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 11a6461e98da..7aab607dd879 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -104,6 +104,7 @@
 pub mod print;
 pub mod rbtree;
 pub mod revocable;
+pub mod safety;
 pub mod security;
 pub mod seq_file;
 pub mod sizes;
diff --git a/rust/kernel/safety.rs b/rust/kernel/safety.rs
new file mode 100644
index 000000000000..42f7763a044f
--- /dev/null
+++ b/rust/kernel/safety.rs
@@ -0,0 +1,52 @@
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
+/// ```
+/// /// # Safety
+/// ///
+/// /// The caller must ensure that interpreting the bytes of `[T; N]` as `[U; N]` is valid.
+/// ///
+/// /// This requires:
+/// /// - `T` and `U` must have same size.
+/// /// - The bit pattern of `T` must be valid for `U`.
+/// /// - The alignment of `T` must be at least as strict as `U`.
+/// unsafe fn transmute_array<const N: usize, T: Copy, U: Copy>(input: [T; N]) -> [U; N] {
+///     unsafe_precondition_assert!(
+///         core::mem::size_of::<T>() == core::mem::size_of::<U>(),
+///         "src and dst must have the same size"
+///     );
+///
+///     unsafe_precondition_assert!(
+///         core::mem::align_of::<T>() >= core::mem::align_of::<U>(),
+///         "src alignment must be compatible with dst alignment"
+///     );
+///
+///     unsafe { core::mem::transmute_copy(&input) }
+/// }
+/// ```
+///
+/// # Panics
+///
+/// Panics if the expression is evaluated to `false` at runtime.
+///
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

base-commit: dff64b072708ffef23c117fa1ee1ea59eb417807
-- 
2.50.1


