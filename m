Return-Path: <linux-kernel+bounces-770830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBAA9B27F69
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 13:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1943DAE6EBF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 11:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3873002A5;
	Fri, 15 Aug 2025 11:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cV+N/jRt"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB42285CBF;
	Fri, 15 Aug 2025 11:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755257931; cv=none; b=HnfTM1FT8JufBfcZKAkZaD5MxdtZh92Ot6JV+xKIDmSboAKvbPTqVKT2mVEGHYQ8bopeXp7WsD9SAj7Ql8h9d9EW9qTc/P7uPVuswQKGtMbFlnWiO1MpGiiRyvktfjfOH0VBOBf+EZOyaWrdO7pPmR6z6iyCQksjNXIcxqwkQ4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755257931; c=relaxed/simple;
	bh=3/XDT/Wjm/E0x/KfIBkufkuKiKbnqCecNkQYBevU9WE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZQhBFp0p5sqhF3erDaJogYvou/qS0xxbz4Uvqob9H4wflHmvi9dww93EcbsdX9DmTxOEk2umFcnChuI8nf0sZoDuFLTF9kkdNuPF0U5yX5Vh218L9ZbKnRARviy74FTUNPKvwQaQpyd9mnjz03nrObwCHaIHJ2e+OKQ3RwuuOQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cV+N/jRt; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-76e2eb6d07bso1798214b3a.3;
        Fri, 15 Aug 2025 04:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755257929; x=1755862729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xnAvNpYK/d4feWDnZ2eneoT0hUG01qbZEZ4vonbJ2yA=;
        b=cV+N/jRtQ2YV8iTMvLRq1oITwoc58qg0moliM+sNsJmWFwLBSB7cg74kZAT4HM7W6b
         0a49+GdQK319or7b04qkN21RCSdyAK5arVZ5myhYyzy8+rw2xhK4isSAc9v4v6dO3HFT
         4XqllTaJ6aoNNJd90sxb2w5P1/Ojr2mOWPXUP5CVvGZAzLfyunWkwc4WGxBfRS+DVuol
         Dhf1ThjvPuOB+QWOOxWNmnII/bn8z61rdtVCCVeCkHZR8jGxhQmpEEe12k4ZZ0SmOBEY
         31GB8wrjbW3aSd5pfIyZn+O8Zr6+6P8Aa3MA9RnAXOZHplom7Cuo8hRdckwU/d1jtvmU
         iaEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755257929; x=1755862729;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xnAvNpYK/d4feWDnZ2eneoT0hUG01qbZEZ4vonbJ2yA=;
        b=Xe3zl9KkSgB5pHwCCNRvS9XWmnjIPJRvJ0uo0BOiGhGsnITlRhu2srQzaFmHqCSvmb
         k2/Fe5OG3nSVRVo/wKokfC6Pcw5Uql2SAeu6H8SyPGIWA2COgTIlVaTnsqyitGObOod3
         XZBGp7XFTifusg/Q8gaUFLaH7l6cDfUAi+1b9tDlgIisJT4U22/8mUApjkGDVW3oczKo
         X+vAoyelbobn2+P27K6z5l+ToHnhGJN0h9Npgo/am94ruHdK6svqlAZqGhhDcd1pMY+g
         oLX18RZHYCTUaDGxRBApf5NOts+4o5STfDWm6e2lOTjsga5hLPWPR1qukJQCgc3MxQ9g
         hldQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6ctkwayiiSU5PSztGiR24/kw7M2mhPlfXdct38OhV/yspmIm9dSJVgIuO3B57GOvzG3C60eCMNF2KcOI=@vger.kernel.org, AJvYcCVdcxv1IAEgj/9D/BLZcKa/C6NhRPdqtQa9viPToTQk9+s8zx7rTM9Ka9EufClPRCsJSBggOqP4j8J8P8CuI3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDrlw7SQGa/USSc8JHjvF6jSFdTUchpQQKaiNfUf727AECixjM
	MahVJIskdtQ2mJattXhpqEG05O7qHtGmgGFnK2j28DdIBCFN4STMEOGW
X-Gm-Gg: ASbGnctL5nxDRLIPw3a00XrhDEU/5T6C6zrc0NInjdVoVP6+mz5xbp39T2oCc01pG3Y
	4p3mZSFRuDIvexnRNIGNSCSo978uf5EYnu8UmnJw8HDHXIcmCfL5sOVsLY+FG0OnJeQwXVB027x
	DH8H9FDDWs1T2zswTlntoQOCDKFVeDISVdiLBAhY9YRJiwiwiD5N3R6UbYMVnG5SPUi7SyuosK+
	MPrymMIhs9oF87UUUF7j1pCzRQutsUp2gTnKAVC9Odog1+jXQGpmrr9YHMUwOApSesYyLz14cI3
	QBd456RaDyWok9y7PtclDDUka8j60d+kT+rKZijXHSqr/RQHlE1fpbFqWfDByeuwd6ACPzRU+os
	RXh+JjHdXBrTVd8C352IJH2Py
X-Google-Smtp-Source: AGHT+IHH4PJEowdDXJzHwyolvlXgEZ5kmrKE9H2KRS66QaWxWvWwmU9oBfkpHtMch29KNsj5ZRm1cA==
X-Received: by 2002:a05:6a00:2183:b0:76b:cadf:5dbe with SMTP id d2e1a72fcca58-76e4455a32cmr2286850b3a.0.1755257928853;
        Fri, 15 Aug 2025 04:38:48 -0700 (PDT)
Received: from fedora ([2405:201:5501:4085:eece:e0ff:6b68:de2e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e45e278f1sm864917b3a.103.2025.08.15.04.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 04:38:48 -0700 (PDT)
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
Cc: skhan@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: [PATCH v5] rust: kernel: introduce `unsafe_precondition_assert!` macro
Date: Fri, 15 Aug 2025 17:08:34 +0530
Message-ID: <20250815113836.138071-1-ritvikfoss@gmail.com>
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

Changes in v5:
 - Change doc example
 - Use re-exported `kernel::prelude::fmt!` instead of `core::format_args!`
 - Link to v4: https://lore.kernel.org/rust-for-linux/20250808192005.209188-1-ritvikfoss@gmail.com/

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
 rust/kernel/safety.rs | 54 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)
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
index 000000000000..e78d49e3e7c8
--- /dev/null
+++ b/rust/kernel/safety.rs
@@ -0,0 +1,54 @@
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
+/// use kernel::unsafe_precondition_assert;
+///
+/// struct RawBuffer<T: Copy, const N: usize> {
+///     data: [T; N],
+/// }
+///
+/// impl<T: Copy, const N: usize> RawBuffer<T, N> {
+///     /// # Safety
+///     ///
+///     /// The caller must ensure that `index` is less than `N`
+///     unsafe fn set_unchecked(&mut self, index: usize, value: T) {
+///         unsafe_precondition_assert!(
+///             index < N,
+///             "RawBuffer::set_unchecked requires index ({}) < N ({})",
+///             index,
+///             N,
+///         );
+///
+///         // SAFETY: By the safety requirements of this function, `index` is valid
+///         unsafe {
+///             *self.data.get_unchecked_mut(index) = value;
+///         }
+///     }
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
+        $crate::unsafe_precondition_assert!(@inner $cond, $crate::prelude::fmt!($($arg)+))
+    };
+
+    (@inner $cond:expr, $msg:expr) => {
+        ::core::debug_assert!($cond, "unsafe precondition(s) violated: {}", $msg) };
+}

base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
-- 
2.50.1


