Return-Path: <linux-kernel+bounces-787711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB46B37A19
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 08:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 883BD364BB5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 06:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA5E30F94A;
	Wed, 27 Aug 2025 06:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fDtRTav1"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEEE2DCF5F;
	Wed, 27 Aug 2025 06:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756274425; cv=none; b=HSmekQTMTk1cgNzBiRgjfyW0gs5jLAhaep2Xza2cnXyA5r/9de7r2C1OHxbkxYoPNtNrpy+xNmX8DjS0kL8gbBINnthkpXiyomn7A6ARp/H50YeWY8VbMBQ00Sd/mZAN3vEleAjpHmTk7vLFI672eK7fxdZn8qPjVsqa89KR67Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756274425; c=relaxed/simple;
	bh=3/XDT/Wjm/E0x/KfIBkufkuKiKbnqCecNkQYBevU9WE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NMGsrYHJmjiXSdhhU0gYsSKQafxH9iWNz2p0sAgWDbjxGuhHX/0zGS3FNJWlucMWoGXLf3YgqebFFqWE/x6I1MjEZXdia0cM5lTQefk+5/SaIpbC1jO+WjhYTqcds2T1tkg9af2MKPB85W1SAEoIE+u1URwlJEI9VcddT7gKEOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fDtRTav1; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-61c266e81caso5666936a12.3;
        Tue, 26 Aug 2025 23:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756274421; x=1756879221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xnAvNpYK/d4feWDnZ2eneoT0hUG01qbZEZ4vonbJ2yA=;
        b=fDtRTav1R+U+5atNflJUkr4wbYk7ghh846ZRzZwwy5KOiUG05580eb8rIxhNHC2Nrx
         PzLqpQ7w7bze05XCTTtfzIgkuTsVN/O2pJOnUKX0DvCcxMINuxpAIIQInC3T3FRIN2sZ
         JeftxJ8psMRwuU9do8SBh8lBlDrx5CSZAgNj607SWUgxpGV88PvD/E6OXYZDxf+Y8yZ6
         C5nwVZhvM4gZ5RdlGSklw1r/ujJmwxlAKlLTAy3Lc9zXtnmAQbpjpuYNBFGT+Rhv8OSE
         g5/mfV0Jv5mE8GdflO3GzyvuCQZhnYzu8eRnsf947OmuMxkZ9uJtvqxIiV/mivNUdEBg
         ON1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756274421; x=1756879221;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xnAvNpYK/d4feWDnZ2eneoT0hUG01qbZEZ4vonbJ2yA=;
        b=kbaRR4a36PDsjC6u01zZ3PjPGCA8WKDTzgKeeCoCpK1n4lWWoY10UZpe9q7pKs1rZI
         PQxAj9ykNqcr5ILkzoWt16aUJnIUgDHr2YE8oC1Q4HYVd5cs4STYB0Oc/VxCpFmB8U4g
         NdHtdib61QP+5creHR2zBkFqWUAmGNPR4WSGFVzbg4+cQ6e1iIDY443AiJj+7vgZsPY6
         mJ/Rw5hYEqX8AL4yQvbL/aM5feOBEML4eeTq4466YDRPdaljvBI9ItSJTmqKqDCSzpB0
         OyQGKBNe+K+bLNBsHB/Apzwm1qFHa5lUA1wXCDAFxuPx34IHn8XPvpkQLTFPMponqudK
         Pa9Q==
X-Forwarded-Encrypted: i=1; AJvYcCV9bW3FPWYPNw0NZJsAb9t0wd3KiDgr4aFM7VVJPbVmO8IY0rjn8rAJrs5+RY3cUTN7EN5QhX+Qdo79HSs=@vger.kernel.org, AJvYcCWzrXMp5z3Io96rKg6IEV+iqh9WcAYh9aex5D0w8ezrOAVSq/biTkp80eJ0wfhlx/Em8x0aoZ/0n8a4y4q2RiI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm5ggFMyYEZZyvp3kPmhJvUaQXxSwlASHm4MSTYRr8LJwylH1F
	oZ2vplXa1nz3Oe+34NxOhJdclNFAufywnQhJTmWGWgiMlN9Liy0l/D5N
X-Gm-Gg: ASbGnctHyQoxogAOOlvk82NKPAchqYh0a91YEOcaJYc40xuZR8D3eTYcjfsGsvV7y+5
	tFXTswIZu5NN/PEhybGtZ8GS7zySKtBipo2UXTuKdgKnwDh+bsQQk//yL/6Pw40vz80wFQLxA2f
	lNyHp15/so2f1y+ZVlm9uOS/NS2U4RooHzdY57jpr5FxaCvDOuHy40Jy/7/rUKd2lGS7+Qzakep
	xn7YYccteNTPkHERFrWC0x1O/gFeiHT2Lc2Y17m3gkUItexWXUjG0pXozyRQBQLyqRQhdILWyL5
	Y7LZz2Fxdqi9dava9qkxoit8tXxwAzWRBI5CnuV/nJfLl9m9d18VYKELG64Kcknw4M13a1AdnEe
	nSK8kZCUn/Tf0kRzc/As=
X-Google-Smtp-Source: AGHT+IHeJPxAMlja2fxC0b7zCt8jkHNyZHTw3nPVvmyHgSGyqgPyTjCqRmiVKVLVdeCAgfsqswhpBA==
X-Received: by 2002:a17:907:72d2:b0:af9:8c20:145b with SMTP id a640c23a62f3a-afe28f7622amr1756774366b.10.1756274421038;
        Tue, 26 Aug 2025 23:00:21 -0700 (PDT)
Received: from fedora ([2405:201:5501:40b7:23f2:cb46:b049:a045])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afeae4ca4bdsm287129866b.5.2025.08.26.23.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 23:00:20 -0700 (PDT)
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
Subject: [RESEND PATCH v5] rust: kernel: introduce `unsafe_precondition_assert!` macro
Date: Wed, 27 Aug 2025 11:30:08 +0530
Message-ID: <20250827060013.6874-1-ritvikfoss@gmail.com>
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


