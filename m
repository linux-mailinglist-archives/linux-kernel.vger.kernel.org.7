Return-Path: <linux-kernel+bounces-743372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C6BB0FDD6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 02:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D16D17DD9C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 00:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF19D273D8D;
	Thu, 24 Jul 2025 00:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K4E23MV3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A4D273817;
	Thu, 24 Jul 2025 00:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753315209; cv=none; b=nn4UbYD2s1FNhcjOan0gKIW0ZH8pEB8WZxVkndAlAFjlatCXif2ZD1TtvOAQUBuRcBAkxXRS/WN820YvFIJs02hOZv2gjx2iXlzQeD3qhDhu84ZT+fRLV92MuUZ/lTE37tVYTrbco1vbO1a7MqjHQM74Cy5eCT3RwBvjCWX+k7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753315209; c=relaxed/simple;
	bh=pdNqX9QyZwcd0g+aDfgqrfhZ2FNoP+4OScX7UxFdOA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=poHjRYo+uFfm3ttqgPBS1Jf2drcIOxaTk7tXftPtNjbyi/e5mj1NbJL5RwZsfpgh9f+wb3Z53+4QpWbeCT2a39HviPOBv4EZGfD1WZjlRYs1MlAIlNeMUX22Ood5XwsP1Q79CoSAbovJ9F7AjfhJ8rOHtGLoLx70tNjPnaq0lmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K4E23MV3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 354BEC4CEEF;
	Thu, 24 Jul 2025 00:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753315208;
	bh=pdNqX9QyZwcd0g+aDfgqrfhZ2FNoP+4OScX7UxFdOA8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K4E23MV3cUL0srDHgYn1MhJXINDyBsDUVgQ+0P+jspP31uleWJHYQPuc8kz0Qa7wu
	 QJmbN+C7u52hNNTKTVpE96wcYuy8TGeshYgiLHbIQrxqbJ7f+3bC6tETmZDOp7VpLY
	 WeMYxi1tSYdsofJIA8POoqVJ4NBjMIR4Pq/nMsQXRrSKhcg2U2AC3VeiSZ+uVJkpsV
	 b6LbSbIgsVvfhoIoo1+ECn4y34SJjQgT31IOZyhUKGHkgKt5ckX8iPGdB/6KKtGfix
	 SC+HUq0qGGDi0yu0JZ5saVwHJ+TlCvdLmZ5Ysd1Db+zoMe+q7vkPGCw92jN0YyIUoi
	 BVrN9gqFSkFkg==
From: Gary Guo <gary@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Tamir Duberstein <tamird@gmail.com>,
	Ingo Molnar <mingo@kernel.org>,
	Mitchell Levy <levymitchell0@gmail.com>,
	Lyude Paul <lyude@redhat.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: rust-for-linux@vger.kernel.org,
	Fiona Behrens <me@kloenk.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/5] rust: implement `kernel::sync::Refcount`
Date: Thu, 24 Jul 2025 00:32:54 +0100
Message-ID: <20250723233312.3304339-2-gary@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250723233312.3304339-1-gary@kernel.org>
References: <20250723233312.3304339-1-gary@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gary Guo <gary@garyguo.net>

This is a wrapping layer of `include/linux/refcount.h`. Currently the
kernel refcount has already been used in `Arc`, however it calls into
FFI directly.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Fiona Behrens <me@kloenk.dev>
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/helpers/refcount.c      | 10 ++++
 rust/kernel/sync.rs          |  2 +
 rust/kernel/sync/refcount.rs | 98 ++++++++++++++++++++++++++++++++++++
 3 files changed, 110 insertions(+)
 create mode 100644 rust/kernel/sync/refcount.rs

diff --git a/rust/helpers/refcount.c b/rust/helpers/refcount.c
index d6adbd2e45a18..d175898ad7b81 100644
--- a/rust/helpers/refcount.c
+++ b/rust/helpers/refcount.c
@@ -7,11 +7,21 @@ refcount_t rust_helper_REFCOUNT_INIT(int n)
 	return (refcount_t)REFCOUNT_INIT(n);
 }
 
+void rust_helper_refcount_set(refcount_t *r, int n)
+{
+	refcount_set(r, n);
+}
+
 void rust_helper_refcount_inc(refcount_t *r)
 {
 	refcount_inc(r);
 }
 
+void rust_helper_refcount_dec(refcount_t *r)
+{
+	refcount_dec(r);
+}
+
 bool rust_helper_refcount_dec_and_test(refcount_t *r)
 {
 	return refcount_dec_and_test(r);
diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index 63c99e015ad6f..43bbc21134c14 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -16,6 +16,7 @@
 mod locked_by;
 pub mod poll;
 pub mod rcu;
+mod refcount;
 
 pub use arc::{Arc, ArcBorrow, UniqueArc};
 pub use completion::Completion;
@@ -24,6 +25,7 @@
 pub use lock::mutex::{new_mutex, Mutex, MutexGuard};
 pub use lock::spinlock::{new_spinlock, SpinLock, SpinLockGuard};
 pub use locked_by::LockedBy;
+pub use refcount::Refcount;
 
 /// Represents a lockdep class. It's a wrapper around C's `lock_class_key`.
 #[repr(transparent)]
diff --git a/rust/kernel/sync/refcount.rs b/rust/kernel/sync/refcount.rs
new file mode 100644
index 0000000000000..3ff4585326b41
--- /dev/null
+++ b/rust/kernel/sync/refcount.rs
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Atomic reference counting.
+//!
+//! C header: [`include/linux/refcount.h`](srctree/include/linux/refcount.h)
+
+use crate::build_assert;
+use crate::types::Opaque;
+
+/// Atomic reference counter.
+///
+/// This type is conceptually an atomic integer, but provides saturation semantics compared to
+/// normal atomic integers. Values in the negative range when viewed as a signed integer are
+/// saturation (bad) values. For details about the saturation semantics, please refer to top of
+/// [`include/linux/refcount.h`](srctree/include/linux/refcount.h).
+///
+/// Wraps the kernel's C `refcount_t`.
+#[repr(transparent)]
+pub struct Refcount(Opaque<bindings::refcount_t>);
+
+impl Refcount {
+    /// Construct a new [`Refcount`] from an initial value.
+    ///
+    /// The initial value should be non-saturated.
+    #[inline]
+    pub fn new(value: i32) -> Self {
+        build_assert!(value >= 0, "initial value saturated");
+        // SAFETY: There are no safety requirements for this FFI call.
+        Self(Opaque::new(unsafe { bindings::REFCOUNT_INIT(value) }))
+    }
+
+    #[inline]
+    fn as_ptr(&self) -> *mut bindings::refcount_t {
+        self.0.get()
+    }
+
+    /// Set a refcount's value.
+    #[inline]
+    pub fn set(&self, value: i32) {
+        // SAFETY: `self.as_ptr()` is valid.
+        unsafe { bindings::refcount_set(self.as_ptr(), value) }
+    }
+
+    /// Increment a refcount.
+    ///
+    /// It will saturate if overflows and `WARN`. It will also `WARN` if the refcount is 0, as this
+    /// represents a possible use-after-free condition.
+    ///
+    /// Provides no memory ordering, it is assumed that caller already has a reference on the
+    /// object.
+    #[inline]
+    pub fn inc(&self) {
+        // SAFETY: self is valid.
+        unsafe { bindings::refcount_inc(self.as_ptr()) }
+    }
+
+    /// Decrement a refcount.
+    ///
+    /// It will `WARN` on underflow and fail to decrement when saturated.
+    ///
+    /// Provides release memory ordering, such that prior loads and stores are done
+    /// before.
+    #[inline]
+    pub fn dec(&self) {
+        // SAFETY: `self.as_ptr()` is valid.
+        unsafe { bindings::refcount_dec(self.as_ptr()) }
+    }
+
+    /// Decrement a refcount and test if it is 0.
+    ///
+    /// It will `WARN` on underflow and fail to decrement when saturated.
+    ///
+    /// Provides release memory ordering, such that prior loads and stores are done
+    /// before, and provides an acquire ordering on success such that memory deallocation
+    /// must come after.
+    ///
+    /// Returns true if the resulting refcount is 0, false otherwise.
+    ///
+    /// # Notes
+    ///
+    /// A common pattern of using `Refcount` is to free memory when the reference count reaches
+    /// zero. This means that the reference to `Refcount` could become invalid after calling this
+    /// function. This is fine as long as the reference to `Refcount` is no longer used when this
+    /// function returns `false`. It is not necessary to use raw pointers in this scenario, see
+    /// https://github.com/rust-lang/rust/issues/55005.
+    #[inline]
+    #[must_use = "use `dec` instead if you do not need to test if it is 0"]
+    pub fn dec_and_test(&self) -> bool {
+        // SAFETY: `self.as_ptr()` is valid.
+        unsafe { bindings::refcount_dec_and_test(self.as_ptr()) }
+    }
+}
+
+// SAFETY: `refcount_t` is thread-safe.
+unsafe impl Send for Refcount {}
+
+// SAFETY: `refcount_t` is thread-safe.
+unsafe impl Sync for Refcount {}
-- 
2.49.0


