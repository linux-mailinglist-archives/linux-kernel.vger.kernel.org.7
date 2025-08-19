Return-Path: <linux-kernel+bounces-774637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B95C8B2B566
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 02:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D998719683CE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 00:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7AE91607AC;
	Tue, 19 Aug 2025 00:39:00 +0000 (UTC)
Received: from mail-10625.protonmail.ch (mail-10625.protonmail.ch [79.135.106.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9434134CF;
	Tue, 19 Aug 2025 00:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755563940; cv=none; b=NayAb6VWxGCZ5uWSy4J3oFsxq7lUFYN9ppBYw3wUak7BenGGdWKZ3RxFhblMIhfoJzaV1EZfZNAgetSAN4PdCUuJVEsQ62Z9341tPI+cnuGwOGuI6TXc9n7l5N3uYQVrp40n5/SXgE1uBdVleZM5SeWP+QBfmhmc3MGTsX1x0nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755563940; c=relaxed/simple;
	bh=NRxoU38+Hiaf1dltMuIgYCLU/GXOZnll4JAjoFDng6U=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QAtwER/iQUYI2VAAwz4XejxvFtpze5t/JQkJ9Vmas0o6S6JW/r8oe5bqzZSUBC7VgILE0jhtDG8dHigdqC29NnZdOLtKUchzSKz+/Gdk9f/8QLVNr4UQUeKBwjWmdlWovDT2Koc9DTORDoCJ0S8FdXFHF7awE2qnfz848p7Fyvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antoniohickey.com; spf=pass smtp.mailfrom=antoniohickey.com; arc=none smtp.client-ip=79.135.106.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antoniohickey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antoniohickey.com
Date: Tue, 19 Aug 2025 00:38:46 +0000
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
From: Antonio Hickey <contact@antoniohickey.com>
Cc: Antonio Hickey <contact@antoniohickey.com>, Daniel Cote <danielstonecote@gmail.com>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: [PATCH v5 1/2] rust: kernel: create `overflow_assert!` macro
Message-ID: <20250819003824.23019-2-contact@antoniohickey.com>
In-Reply-To: <20250819003824.23019-1-contact@antoniohickey.com>
References: <20250819003824.23019-1-contact@antoniohickey.com>
Feedback-ID: 144211621:user:proton
X-Pm-Message-ID: cd317eeb7309b27fe90dba0dd6b44e21b212765f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This commit creates a macro for overflow assertions, the use of this
macro will avoid local `#ifdef`s by encapsulating the conditional
behavior (like `#[cfg(CONFIG_RUST_OVERFLOW_CHECKS)]`) to the macro.

In addition this macro allows us to document the intent of the assertion
more clearly.

Co-developed-by: Daniel Cote <danielstonecote@gmail.com>
Signed-off-by: Daniel Cote <danielstonecote@gmail.com>
Signed-off-by: Antonio Hickey <contact@antoniohickey.com>
Link: https://github.com/Rust-for-Linux/linux/issues/1159
Suggested-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/kernel/lib.rs             |  1 +
 rust/kernel/overflow_assert.rs | 44 ++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)
 create mode 100644 rust/kernel/overflow_assert.rs

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index ed53169e795c..901e54a509a3 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -103,6 +103,7 @@
 pub mod of;
 #[cfg(CONFIG_PM_OPP)]
 pub mod opp;
+pub mod overflow_assert;
 pub mod page;
 #[cfg(CONFIG_PCI)]
 pub mod pci;
diff --git a/rust/kernel/overflow_assert.rs b/rust/kernel/overflow_assert.r=
s
new file mode 100644
index 000000000000..f3de3b1b2cf3
--- /dev/null
+++ b/rust/kernel/overflow_assert.rs
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Overflow assertion.
+
+/// Asserts that a boolean expression is `true` at runtime.
+///
+/// This will invoke the [`panic!`] macro if the provided
+/// expression cannot be evaluated to `true` at runtime.
+///
+/// This macro only has effect when `CONFIG_RUST_OVERFLOW_CHECKS`
+/// is enabled, otherwise it expands to a no-op.
+///
+/// This assertion is intended only for extra validation within
+/// builds and environments where panics are acceptable. **Do not
+/// rely on `overflow_assert!` for checks that must *always* execute**
+/// (e.g. to prevent undefined behavior, perform access checks, etc).
+///
+/// # Examples
+///
+/// Basic boolean condition:
+///
+/// ```
+/// let a: u32 =3D 10;
+/// let b: u32 =3D 5;
+/// overflow_assert!(a >=3D b);
+/// ```
+///
+/// A guard before doing a size computation that could overflow:
+/// ```
+/// fn reserve_for_concat(curr: usize, to_add: usize, cap: usize) {
+///     // If enabled, catch obvious overflow logic errors early:
+///     overflow_assert!(curr <=3D cap, "curr=3D{} > cap=3D{}", curr, cap)=
;
+///     overflow_assert!(to_add <=3D cap - curr, "would exceed cap: {}+{} =
> {}", curr, to_add, cap);
+///     // ... then proceed to grow/append
+/// }
+/// ```
+#[macro_export]
+macro_rules! overflow_assert {
+    ($($arg:tt)*) =3D> {
+        if cfg!(CONFIG_RUST_OVERFLOW_CHECKS) {
+            ::core::assert!($($arg)*);
+        }
+    };
+}
--=20
2.50.1



