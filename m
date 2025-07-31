Return-Path: <linux-kernel+bounces-752002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B85B1B17031
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 13:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA5BD581772
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 11:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5BA2BE7B5;
	Thu, 31 Jul 2025 11:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THaiFsDq"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700CE2BE638;
	Thu, 31 Jul 2025 11:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753960362; cv=none; b=M6zAHiZKUkQfZZ9yRBcwwg6pMMo/iPW2cQy+wLDMLZeShmpE9eB45vgTg2wrLWdEqou3vqP9sYVH29V8EgtF8BTvFFRzNUA08pBQNcbsY8PoLUYzhysPIbCkYDlChMF8d3ndEC3JLi5msRdBKGlaU//uWBEpkThzWrWItk+HXEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753960362; c=relaxed/simple;
	bh=VdHDVkzkyvAlURKaNUeBWQWHCvk7GbPXWJGCxEX6Jzc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sSFG3quqIFiMMGZIkiyCVQ5vM3ByS6nPTPojx0omHI1L9EFCxgCzU86u29OGKExJfn16fSI7adSOeyxYeAoJPEk3tO6XEJ1/Qd5+/MerGGiRJZgfnVc5CdlTSwj8HRkLNjkDLxvzeaDUh6bqStsnBKI/PuNXplGG4a7hOvoLtjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=THaiFsDq; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76b36e6b9ddso623699b3a.1;
        Thu, 31 Jul 2025 04:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753960360; x=1754565160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4IwWy97OvGZq36Ea/vv8rtgmVuJu0EXO1lQWwmwlguo=;
        b=THaiFsDqqOfs40mr5nZH+YUaOvCb5QYTVbrJsBJhu+ye/tul11Jzhu31Sm+NFdWyAp
         Cbq0l6K4u/MvZiVgUFWybm/skkn3u/Ea4Nfdl69dS0vzgQ5akrdUxFrjO3J0+ceUE7xr
         LZzbMGdl0z5j4gjolkzlrWvktcvsOowll+br/6LzJp2iUQ7wrTSVVbt5Rm42v0QVbbOh
         qyv3v2AIUMaqcaqnHF4Z1eXISH1OhIMNJiaXpRIGGqQMa6Q3xI4h7Xs28VZnT4VSzezh
         3g/WBFHGTj93f7inOO8KSVl2O6MpfM1sGIAsq+cEeIQ6ESuPa2SowliJ1heHxtuGTf1k
         bHOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753960360; x=1754565160;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4IwWy97OvGZq36Ea/vv8rtgmVuJu0EXO1lQWwmwlguo=;
        b=cWlXRqj2KJCmiziT+6p1h9jaNVIoXueqlBw0lCiS629fvmLourer0GqH3Eo028z9wg
         r/pN8+LgvCBne3MJ57wKJrjVt0QD9ngx+bt49+nCAoHi5REE6aT8wWasgHGuxG/uB8k5
         hBSdeaG+kVMRALNAYobFqGZulqVe2oHsHG8mOICPqBiThAMkigJ0mgS92nINkZG3e2BK
         NeoJ+zmI+gCAJ3S43seaHescdKnsygC5DDERruHSlqjb6Jdu+wG9wJBMG0eIMiLJbj9P
         kDlENxkhEZ6YI53h77vQGWK78Fu+YD1k+M+iZVObtfg/F2GvLMc9VUr09U+fmJRqi/Q6
         O3Fw==
X-Forwarded-Encrypted: i=1; AJvYcCVlGEod4/xnVCmK7qFZ6AvCfyJdTs1JKFr/C0Qd32zwwvnf6/oPv0mn9uU5BdvTe3G6RmVzvMeDk4bntBQ=@vger.kernel.org, AJvYcCXu7MgwtRHyXiOSPuvFdKLNOXHtK85Q01gbEk2f/jXwj5Aw/g/QfXPxbwa9J7zHdEewPG+iNeYSlFCjEaeTksE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy26VIJI172dTqttI1KEEMsfVepbEGZS5H0HXgI/ByYeCC+yjNo
	lTRxSsDPDWj8y5KzLxa+N0fN/ivnqiQGIQ/VzvYptOzrE8GQi75kKQQD
X-Gm-Gg: ASbGncvJeaW5zB5/vCrfu/s7yCOOzOqYJnk/5Bs1e2+lpD7rBLznxIYUiZQnNVWuwsV
	6gqrGDj+SclBpftxmEgA2iSluP3fwy7qA5kvS0ukqJuXoGjyz7iiP9jfi7zjjrTpX3s5SIU6yUL
	hWKwxKtPL3nzZHfeG/zh1pE7EiL2qFnJh0ZmD+H4nTEW20d7sOYrBSBVPojWuY3L0T9fQ5ME/jL
	jlmw+iamiHg+ORdk0W3t2m6M5h/pgKYtGFqt6pUuchz8GJsX6KBeFx2oHM/IMF5k25OpeN9fXpR
	D9VgQFlbgj3XKmFQ1PFtATOXa3cVHEoe22B3D3mPRGbvRb8wS+fuI54siapjFWKgO3Hw2FbJge/
	UVWcjqXxAJa5t6B3BiZ9jbxZ5sXkiakyv+uE=
X-Google-Smtp-Source: AGHT+IHpa5118bbeNQZJpwNTbeJvJk7dBt/E3hcVWLfRp4iNi1DcMHaGI9lQ6q+fMkIiF3e3eua8FA==
X-Received: by 2002:a05:6a20:939f:b0:233:b51a:8597 with SMTP id adf61e73a8af0-23dc0ea7837mr11587999637.35.1753960359597;
        Thu, 31 Jul 2025 04:12:39 -0700 (PDT)
Received: from fedora ([2405:201:5501:4085:eece:e0ff:6b68:de2e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce8b5basm1327250b3a.41.2025.07.31.04.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 04:12:38 -0700 (PDT)
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
Subject: [PATCH v3] rust: kernel: introduce `unsafe_precondition_assert!` macro
Date: Thu, 31 Jul 2025 16:42:28 +0530
Message-ID: <20250731111234.28602-1-ritvikfoss@gmail.com>
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
 rust/kernel/safety.rs | 47 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)
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
index 000000000000..f591eed6da77
--- /dev/null
+++ b/rust/kernel/safety.rs
@@ -0,0 +1,47 @@
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
+/// /// - `buf` must be non-null.
+/// /// - `buf` must be 16-byte aligned.
+/// /// - `len` must be multiple of [`PAGE_SIZE`].
+/// unsafe fn foo(buf: *const u8, len: usize) {
+///     unsafe_precondition_assert!(!buf.is_null(), "buf must not be null");
+///     unsafe_precondition_assert!((buf as usize) % 16 == 0, "buf must be 16-byte aligned");
+///     unsafe_precondition_assert!(
+///         len % PAGE_SIZE == 0,
+///         "len ({}) must be multiple of PAGE_SIZE ({})",
+///         len,
+///         PAGE_SIZE
+///     );
+///     // ...
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


