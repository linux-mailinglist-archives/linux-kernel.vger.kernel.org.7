Return-Path: <linux-kernel+bounces-768810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40790B265B6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E4775C2BD5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE263009CD;
	Thu, 14 Aug 2025 12:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bpq/oQSq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D892FF166;
	Thu, 14 Aug 2025 12:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755175491; cv=none; b=umEpO+hEnRkgExoUPqCbpJkSySs9wCErV0G4olR1z3voGGb4Pi3qEYeTd6V8SlLJPyRgn8ZV9UCtsbz+qMLUWgU8Clrb1ConKMbPwP3Q/El0mHO2drWi8WsZjG/xVb8TFmKhmfq8BRbUU5Hw1vY0xRJy2kTPBZHJ5mCQXI8KCPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755175491; c=relaxed/simple;
	bh=zm6AR4LdGo7kZKj41pqErGqx9PcmRmXgtjDSZe9VwcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ai2t8xp3/DwOKXbKSjGqbDZjvH0Wx5HSxeBx3LpaYTVhWDscNX1aDLX5eECNRe0qPCJunb34G67QjBgMpAdJ2903lviIrLgpMxTHkuvPyIIYAJeBWnqWXWFIH45Mc16B2REX8VaFCumU890kTMl+t7+mUbAVnMxkGNWuPWDXngY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bpq/oQSq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C4A6C4CEF9;
	Thu, 14 Aug 2025 12:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755175491;
	bh=zm6AR4LdGo7kZKj41pqErGqx9PcmRmXgtjDSZe9VwcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bpq/oQSqPJ0AG9aH/E7YsHdrODMEutIuyRZs/sEORcREwsCi1VGpU2cXb9O3gVq/G
	 C9Z0acNojy1kfrlatgR6g+t4J3xZ+/ouU8MBqCF2weuLSvRqHYwdnBCAZGryt7ghFT
	 QexWg8xM1Qe26bJRYITn12079SYrwJvPXzZwQl1YCNPLVMDNqMUCEibX4vJRo4129F
	 a3NC5jImY56PlG+z0qT6SsNBeDh81vt2MRe8p3GcNVXmmhj0UIR2LL7i+ZpKDnnKTm
	 liWdx1uNcmfi14qBkYBT/FHq8T6/NzML+37SI9Cp7S21uIEIrh9V/ZFh5Pcy4b1vuw
	 AViLfjiygKx4Q==
From: Benno Lossin <lossin@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Benno Lossin <benno.lossin@proton.me>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v4 3/4] rust: validate: add `Validate` trait
Date: Thu, 14 Aug 2025 14:44:15 +0200
Message-ID: <20250814124424.516191-4-lossin@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814124424.516191-1-lossin@kernel.org>
References: <20250814124424.516191-1-lossin@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Benno Lossin <benno.lossin@proton.me>

Introduce the `Validate<Input>` trait and functions to validate
`Untrusted<T>` using said trait. This allows one to access the inner
value of `Untrusted<T>` via `validate{,_ref,_mut}` functions which
subsequently delegate the validation to user-implemented `Validate`
trait.

The `Validate` trait is the only entry point for validation code, making
it easy to spot where data is being validated.

The reason for restricting the types that can be inputs to
`Validate::validate` is to be able to have the `validate...` functions
on `Untrusted`. This is also the reason for the suggestions in the
`Usage in API Design` section in the commit that introduced
`Untrusted<T>`.

Signed-off-by: Benno Lossin <benno.lossin@proton.me>
---
 rust/kernel/validate.rs | 70 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 69 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/validate.rs b/rust/kernel/validate.rs
index 1f75ccb79532..2a582a572aa5 100644
--- a/rust/kernel/validate.rs
+++ b/rust/kernel/validate.rs
@@ -11,6 +11,9 @@
 //! APIs that write back into userspace usually allow writing untrusted bytes directly, allowing
 //! direct copying of untrusted user data back into userspace without validation.
 //!
+//! The only way to access untrusted data is to [`Validate::validate`] it. This is facilitated by
+//! the [`Validate`] trait.
+//!
 //! # Rationale
 //!
 //! When reading data from an untrusted source, it must be validated before it can be used for
@@ -46,7 +49,7 @@
 /// untrusted, as it would otherwise violate normal Rust rules. For this reason, one can easily
 /// convert that reference to `&[Untrusted<u8>]`. Another such example is `Untrusted<KVec<T>>`, it
 /// derefs to `KVec<Untrusted<T>>`. Raw bytes however do not behave in this way, `Untrusted<u8>` is
-/// totally opaque.
+/// totally opaque and one can only access its value by calling [`Untrusted::validate()`].
 ///
 /// # Usage in API Design
 ///
@@ -101,6 +104,30 @@ pub fn new(value: T) -> Self
     {
         Self(value)
     }
+
+    /// Validate the underlying untrusted data.
+    ///
+    /// See the [`Validate`] trait for more information.
+    pub fn validate<V: Validate<Self>>(self) -> Result<V, V::Err>
+    where
+        T: Sized,
+    {
+        V::validate(self.0)
+    }
+
+    /// Validate the underlying untrusted data.
+    ///
+    /// See the [`Validate`] trait for more information.
+    pub fn validate_ref<'a, V: Validate<&'a Self>>(&'a self) -> Result<V, V::Err> {
+        V::validate(&self.0)
+    }
+
+    /// Validate the underlying untrusted data.
+    ///
+    /// See the [`Validate`] trait for more information.
+    pub fn validate_mut<'a, V: Validate<&'a mut Self>>(&'a mut self) -> Result<V, V::Err> {
+        V::validate(&mut self.0)
+    }
 }
 
 impl<T> Deref for Untrusted<[T]> {
@@ -140,3 +167,44 @@ fn deref_mut(&mut self) -> &mut Self::Target {
         unsafe { &mut *ptr }
     }
 }
+
+/// Marks valid input for the [`Validate`] trait.
+pub trait ValidateInput: private::Sealed {
+    /// Type of the inner data.
+    type Inner: ?Sized;
+}
+
+impl<T: ?Sized> ValidateInput for Untrusted<T> {
+    type Inner = T;
+}
+
+impl<'a, T: ?Sized> ValidateInput for &'a Untrusted<T> {
+    type Inner = &'a T;
+}
+
+impl<'a, T: ?Sized> ValidateInput for &'a mut Untrusted<T> {
+    type Inner = &'a mut T;
+}
+
+mod private {
+    use super::Untrusted;
+
+    pub trait Sealed {}
+
+    impl<T: ?Sized> Sealed for Untrusted<T> {}
+    impl<'a, T: ?Sized> Sealed for &'a Untrusted<T> {}
+    impl<'a, T: ?Sized> Sealed for &'a mut Untrusted<T> {}
+}
+
+/// Validate [`Untrusted`] data.
+///
+/// Care must be taken when implementing this trait, as unprotected access to unvalidated data is
+/// given to the [`Validate::validate`] function. The implementer must ensure that the data is only
+/// used for logic after successful validation.
+pub trait Validate<Input: ValidateInput>: Sized {
+    /// Validation error.
+    type Err;
+
+    /// Validate the raw input.
+    fn validate(raw: Input::Inner) -> Result<Self, Self::Err>;
+}
-- 
2.50.1


