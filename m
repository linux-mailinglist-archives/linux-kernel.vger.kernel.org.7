Return-Path: <linux-kernel+bounces-856945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC0ABE5834
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 23:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 041FE5484FA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 21:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E452DF3E7;
	Thu, 16 Oct 2025 21:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+d/Dd0K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79783BB5A;
	Thu, 16 Oct 2025 21:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760648747; cv=none; b=m9/vJxhqTU64VIYwXwBwq1w7sOmxVGVm2FBOpWvQVGhxovisezx4vQiH+BTwmX3YEBz+tkRBNCdpGPNrel1miNdDo8rz66rjDRNfJw7MxzldzQEdeMl/E1ZTuuUqJWKBLT9m/uG2mb8eclH8EHIfvicb2d7yL1Leuf4jTNNsHRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760648747; c=relaxed/simple;
	bh=KzjbcAo/PwUxext8umITliZVstWqP+nCRZJf+X0AXhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=id+O80XPhuuU5UP+v+kcoN6lb0a36wZUwejJY/7UMqJw1WKQ0NmlX8IfDTCqx9wD6z4S6gWNP6EVFd4wOHMV1w8LX/Wb6fJU65MKtpPJE/mQE+Sz8cK5Y2PzYVUNlhn6IQbAEvbqBi4aBm0bC0Spk7fwWMljhMbsZ5mSUe3ksRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+d/Dd0K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A389C4CEF1;
	Thu, 16 Oct 2025 21:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760648747;
	bh=KzjbcAo/PwUxext8umITliZVstWqP+nCRZJf+X0AXhQ=;
	h=From:To:Cc:Subject:Date:From;
	b=Y+d/Dd0KT1E643lExUM2uTgU5/Y6Y+fiHscI9ACyQG18AsO0O6B5SjcbTmwZejU0y
	 4sbR94VZMMPbY4McWqvQyw/OXH9Ng8za/evK0/Pc2VEF4vQVvBTcFRD9/K2HZ0uKSR
	 y8vz6IHtnQvKxOAMRltmTRjbcG8S1fKORsPsFB/Xvuq+jlNAYIxVWVrJwnKOqJrW3R
	 xVPa5x6JVBKAHqT5PgYJZ7R4keOGtVwOBqk9b/2ObiHTOXOMnQjIBXvUuT85JwAIdI
	 MgUCJ6FCMgYPeXnxN1Wa/jZ+nL26P/zXP8Hw9wQCVlonfbVsjCbz4qZpFGLBiFf13e
	 A3co5k8Sol7Rw==
From: Benno Lossin <lossin@kernel.org>
To: Benno Lossin <lossin@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Fiona Behrens <me@kloenk.dev>,
	Christian Schrefl <chrisi.schrefl@gmail.com>
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] add `[pin_]init_scope` to execute code before creating an initializer
Date: Thu, 16 Oct 2025 23:05:39 +0200
Message-ID: <20251016210541.650056-1-lossin@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In more complex cases, initializers need to run arbitrary code before
assigning initializers to fields. While this is possible using the
underscore codeblock feature (`_: {}`), values returned by such
functions cannot be used from later field initializers.

The two new functinos `[pin_]init_scope` allow users to first run some
fallible code and then return an initializer which the function turns
into a single initializer. This permits using the same value multiple
times by different fields.

Reviewed-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Benno Lossin <lossin@kernel.org>
---
 rust/pin-init/src/lib.rs | 87 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/rust/pin-init/src/lib.rs b/rust/pin-init/src/lib.rs
index dd553212836e..8dc9dd5ac6fd 100644
--- a/rust/pin-init/src/lib.rs
+++ b/rust/pin-init/src/lib.rs
@@ -1392,6 +1392,93 @@ pub fn pin_init_array_from_fn<I, const N: usize, T, E>(
     unsafe { pin_init_from_closure(init) }
 }
 
+/// Construct an initializer in a closure and run it.
+///
+/// Returns an initializer that first runs the closure and then the initializer returned by it.
+///
+/// See also [`init_scope`].
+///
+/// # Examples
+///
+/// ```
+/// # use pin_init::*;
+/// # #[pin_data]
+/// # struct Foo { a: u64, b: isize }
+/// # struct Bar { a: u32, b: isize }
+/// # fn lookup_bar() -> Result<Bar, Error> { todo!() }
+/// # struct Error;
+/// fn init_foo() -> impl PinInit<Foo, Error> {
+///     pin_init_scope(|| {
+///         let bar = lookup_bar()?;
+///         Ok(try_pin_init!(Foo { a: bar.a.into(), b: bar.b }? Error))
+///     })
+/// }
+/// ```
+///
+/// This initializer will first execute `lookup_bar()`, match on it, if it returned an error, the
+/// initializer itself will fail with that error. If it returned `Ok`, then it will run the
+/// initializer returned by the [`try_pin_init!`] invocation.
+pub fn pin_init_scope<T, E, F, I>(make_init: F) -> impl PinInit<T, E>
+where
+    F: FnOnce() -> Result<I, E>,
+    I: PinInit<T, E>,
+{
+    // SAFETY:
+    // - If `make_init` returns `Err`, `Err` is returned and `slot` is completely uninitialized,
+    // - If `make_init` returns `Ok`, safety requirement are fulfilled by `init.__pinned_init`.
+    // - The safety requirements of `init.__pinned_init` are fulfilled, since it's being called
+    //   from an initializer.
+    unsafe {
+        pin_init_from_closure(move |slot: *mut T| -> Result<(), E> {
+            let init = make_init()?;
+            init.__pinned_init(slot)
+        })
+    }
+}
+
+/// Construct an initializer in a closure and run it.
+///
+/// Returns an initializer that first runs the closure and then the initializer returned by it.
+///
+/// See also [`pin_init_scope`].
+///
+/// # Examples
+///
+/// ```
+/// # use pin_init::*;
+/// # struct Foo { a: u64, b: isize }
+/// # struct Bar { a: u32, b: isize }
+/// # fn lookup_bar() -> Result<Bar, Error> { todo!() }
+/// # struct Error;
+/// fn init_foo() -> impl Init<Foo, Error> {
+///     init_scope(|| {
+///         let bar = lookup_bar()?;
+///         Ok(try_init!(Foo { a: bar.a.into(), b: bar.b }? Error))
+///     })
+/// }
+/// ```
+///
+/// This initializer will first execute `lookup_bar()`, match on it, if it returned an error, the
+/// initializer itself will fail with that error. If it returned `Ok`, then it will run the
+/// initializer returned by the [`try_init!`] invocation.
+pub fn init_scope<T, E, F, I>(make_init: F) -> impl Init<T, E>
+where
+    F: FnOnce() -> Result<I, E>,
+    I: Init<T, E>,
+{
+    // SAFETY:
+    // - If `make_init` returns `Err`, `Err` is returned and `slot` is completely uninitialized,
+    // - If `make_init` returns `Ok`, safety requirement are fulfilled by `init.__init`.
+    // - The safety requirements of `init.__init` are fulfilled, since it's being called from an
+    //   initializer.
+    unsafe {
+        init_from_closure(move |slot: *mut T| -> Result<(), E> {
+            let init = make_init()?;
+            init.__init(slot)
+        })
+    }
+}
+
 // SAFETY: the `__init` function always returns `Ok(())` and initializes every field of `slot`.
 unsafe impl<T> Init<T> for T {
     unsafe fn __init(self, slot: *mut T) -> Result<(), Infallible> {

base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
-- 
2.51.0


