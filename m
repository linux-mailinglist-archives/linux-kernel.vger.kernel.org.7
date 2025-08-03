Return-Path: <linux-kernel+bounces-754432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D94F0B1943A
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 16:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DEBB176168
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 14:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B4726AAAB;
	Sun,  3 Aug 2025 14:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ky499cqD"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB9326A0D5;
	Sun,  3 Aug 2025 14:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754230910; cv=none; b=izrrpNUFFw0YNJbbgpA/kqUT+NmULlSiCgkE2kJPY8bRZlqWUYvikZSkvCmteY0XdCwX9W3rnCJsSt/K5Qeq8cih0bMiNMTH8kv3iPPI0tcqAeuIPG6IiLFTkFthsWT4k92ktFk0aYcC8rYrt4yHscMHy5aWK+Op8JiN9nklHAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754230910; c=relaxed/simple;
	bh=4EgI0v2m+Yvuw7v12aV6d/bqVWoPc0XuNyB+NUvdbwQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FAS2nj+/2L2akMguku3GHy/LUV6q9oukt0SfizZ7PXJNCi5UxPRwejZEzQXBg2eqni95j2b9quddwOG5TlNkQ3ROs2nWHsvlW443+tbfJCUw0JU8P0iQqL2x2Ouzl0gldvymufPSKf0ls7L8ukTyOC6mgcXIeAVUuh2m5TJUMWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ky499cqD; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-76b36e6b9ddso2899087b3a.1;
        Sun, 03 Aug 2025 07:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754230908; x=1754835708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=APj1c+UB2oHtQRNfZRsuIg6Lw5yFU6MmLLNl9Pq1JRU=;
        b=Ky499cqDgPO0X11VhOow+d8toFPTLmhO+fNCxSdJYYS10/4zGKhP9lGqwx2qLFTXxN
         CnvebVaMAR369cmB3ulrP0q+phdPBj044qSf33p5SsinSdq8/eLKpDBe3JrSADcePT8i
         ldzz9vA5lZK2RH1vmEegQp7Lk/i+J+oX45DySAw6Tfp3dPCWUcpEffM7yHseL1oZX8f5
         X1568y1KbNbkkN/YYSafOQaZ1x9xnxBLqg3IqSHdMpWc/4sLhWWiI3Uz2+rIc+A1N/bE
         ye/1AxNKw5Gt+olwh+4I6lKjXho8GWa7oMeukG2z2GOk9Bn4aVDd1nwS4JrghoRloVGy
         ImPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754230908; x=1754835708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=APj1c+UB2oHtQRNfZRsuIg6Lw5yFU6MmLLNl9Pq1JRU=;
        b=UlN7gpqz3WZl450HZY4rT9nAhl1I4RMIRu1Trzv1v3rtFG1aGAR+wMLSQw5TFbvUu7
         ReAb4PwG1Bc/FeiL6P3H5JTCQqOXvK8TSCo1E09TW00VFSx59BZZC638RuB0heKJyMml
         Uot/NvlvXWWZv0bwyCRLLRxHrZC93Il417zW04U4+hRionFDHjEEu30M1uE50G5jsa4p
         79THtN83JQ3W2Hwao8zzMO6iBRwOdi40K2JJJHBlp9/Wrst2hmXw42211F89sTUhkCEZ
         TzLZ9q8cpWOrDBWXGKPOQKTgw+qKNwypQ+HBflts49apmgp1vGGCE7r6xO/sdqjoULcP
         sPCw==
X-Forwarded-Encrypted: i=1; AJvYcCUpU7kmlamPlnSVvQINbo7eblyY35z9tvJBloRMdTk1VCSW0keHi2fut2iJy2DA8m//mTs/pMTgmqf4eo3dyA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzOWITuQXH5OTRaJGaa3mqauLLwpyEOurNEWzHglx5AwrjrY4pq
	25eg+VXR3KJ61e2J1GKT//edF3Fb0RbBq0JcjlSpE5WZfSobENFc+0NW
X-Gm-Gg: ASbGncsiHiE2J+3M5QLOCtuPWCyFRlpFwAvTUwGe9aKBSUKQ+pHcaS0EaV8w+yGa9kH
	FYlts4sxPlQOXNY+p639iEsCGhZZTUNqkiVVwQiKp38PjvPl3jyr4Prfuy1HJAt7tRlBnKD2VuB
	ItaJcehJ8QPUzw5kteyRB46hOTWqoMeau07gnXi+YHVFrAwWmV9koJBBuhqYOPODeWSDSXMix/m
	qGgUseG6xAxQUAyktJXpUBlSGH2wfsy8cCO8DX/QUWhXFsUZNV1NVKO1KXfyJt0Ux3dz29oJ1eA
	fuMBdqaZ9XTd6Kg+0jBKxkpkkDyKkYuAkUUmd4N0UV8W+aOnAiEjGwC9x+OdZsR2MD+rU6nh0GG
	zNWnpZWgCk434jWZCCWOJI4Rxw5FLeOaelQ==
X-Google-Smtp-Source: AGHT+IGyyGgtZEcS4DW/mmaf6MBx0aYT/R4DDHKjOPs9I2a1dvSC67wZ0LzCZPaKLpRqjYMvlWpcdQ==
X-Received: by 2002:a05:6a20:3c8f:b0:220:9d82:a290 with SMTP id adf61e73a8af0-23df8f94a16mr8795243637.8.1754230908273;
        Sun, 03 Aug 2025 07:21:48 -0700 (PDT)
Received: from localhost.localdomain ([104.28.217.213])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfd0279sm8431306b3a.98.2025.08.03.07.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 07:21:48 -0700 (PDT)
From: Jesung Yang <y.j3ms.n@gmail.com>
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
	Alexandre Courbot <acourbot@nvidia.com>
Cc: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	nouveau@lists.freedesktop.org,
	Jesung Yang <y.j3ms.n@gmail.com>
Subject: [PATCH 4/4] rust: macro: add derive macro for `Into`
Date: Sun,  3 Aug 2025 14:20:54 +0000
Message-Id: <c7a1a9a872f206deb65b7e84a8ecc88c528ed50e.1754228164.git.y.j3ms.n@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1754228164.git.y.j3ms.n@gmail.com>
References: <cover.1754228164.git.y.j3ms.n@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a procedural macro `Into` to automatically implement the
`Into` trait for unit-only enums.

This reduces boilerplate in cases where enum variants need to be
interpreted as relevant numeric values. A concrete example can be
found in nova-core, where the `register!()` macro requires enum types
used within it to be convertible via `u32::from()` [1].

Note that the macro actually generates `From<E> for T` implementations,
where `E` is an enum identifier and `T` is an arbitrary integer type.
This automatically provides the corresponding `Into<T> for E`
implementations through the blanket implementation.

Link: https://lore.kernel.org/rust-for-linux/20250624132337.2242-1-dakr@kernel.org/ [1]
Signed-off-by: Jesung Yang <y.j3ms.n@gmail.com>
---
 rust/macros/convert.rs |  36 ++++++++++---
 rust/macros/lib.rs     | 115 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 145 insertions(+), 6 deletions(-)

diff --git a/rust/macros/convert.rs b/rust/macros/convert.rs
index 0084bc4308c1..a6ef67ba27c7 100644
--- a/rust/macros/convert.rs
+++ b/rust/macros/convert.rs
@@ -3,6 +3,12 @@
 use proc_macro::{token_stream, Delimiter, Ident, Span, TokenStream, TokenTree};
 use std::iter::Peekable;
 
+#[derive(Debug)]
+enum DeriveTarget {
+    TryFrom,
+    Into,
+}
+
 #[derive(Debug)]
 struct TypeArgs {
     helper: Vec<Ident>,
@@ -13,13 +19,20 @@ struct TypeArgs {
     "u8", "u16", "u32", "u64", "u128", "usize", "i8", "i16", "i32", "i64", "i128", "isize",
 ];
 
+pub(crate) fn derive_into(input: TokenStream) -> TokenStream {
+    derive(input, DeriveTarget::Into)
+}
+
 pub(crate) fn derive_try_from(input: TokenStream) -> TokenStream {
-    derive(input)
+    derive(input, DeriveTarget::TryFrom)
 }
 
-fn derive(input: TokenStream) -> TokenStream {
-    let derive_target = "TryFrom";
-    let derive_helper = "try_from";
+fn derive(input: TokenStream, target: DeriveTarget) -> TokenStream {
+    type ImplFn = fn(&Ident, &Ident, &[Ident]) -> TokenStream;
+    let (derive_target, derive_helper, impl_trait) = match target {
+        DeriveTarget::TryFrom => ("TryFrom", "try_from", impl_try_from as ImplFn),
+        DeriveTarget::Into => ("Into", "into", impl_into as ImplFn),
+    };
 
     let mut tokens = input.into_iter().peekable();
 
@@ -85,12 +98,12 @@ fn derive(input: TokenStream) -> TokenStream {
         let ty = type_args
             .repr
             .unwrap_or_else(|| Ident::new("isize", Span::mixed_site()));
-        impl_try_from(&ty, &enum_ident, &variants)
+        impl_trait(&ty, &enum_ident, &variants)
     } else {
         let impls = type_args
             .helper
             .iter()
-            .map(|ty| impl_try_from(ty, &enum_ident, &variants));
+            .map(|ty| impl_trait(ty, &enum_ident, &variants));
         quote! { #(#impls)* }
     }
 }
@@ -335,3 +348,14 @@ fn try_from(#param: #ty) -> Result<Self, Self::Error> {
         }
     }
 }
+
+fn impl_into(ty: &Ident, enum_ident: &Ident, _: &[Ident]) -> TokenStream {
+    quote! {
+        #[automatically_derived]
+        impl ::core::convert::From<#enum_ident> for #ty {
+            fn from(value: #enum_ident) -> #ty {
+                value as #ty
+            }
+        }
+    }
+}
diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
index 569198f188f7..374c1bdb696a 100644
--- a/rust/macros/lib.rs
+++ b/rust/macros/lib.rs
@@ -427,6 +427,121 @@ pub fn kunit_tests(attr: TokenStream, ts: TokenStream) -> TokenStream {
     kunit::kunit_tests(attr, ts)
 }
 
+/// A derive macro for providing an impl of the [`Into`] trait.
+///
+/// This macro automatically derives [`Into`] trait for a given enum by generating
+/// the relevant [`From`] implementation. Currently, it only supports [unit-only enum]s
+/// without generic parameters.
+///
+/// [unit-only enum]: https://doc.rust-lang.org/reference/items/enumerations.html#r-items.enum.unit-only
+///
+/// # Notes
+///
+/// Unlike its name suggests, the macro actually generates [`From`] implementations
+/// which automatically provide corresponding [`Into`] implementations.
+///
+/// The macro uses the `into` custom attribute or `repr` attribute to generate [`From`]
+/// implementations. `into` always takes precedence over `repr`.
+///
+/// # Caveats
+///
+/// Ensure that every integer type specified in `#[into(...)]` is large enough to cover
+/// all enum discriminants. Otherwise, the internal `as` casts may overflow.
+///
+/// # Examples
+///
+/// ## Without Attributes
+///
+/// Since [the default `Rust` representation uses `isize` for the discriminant type][repr-rs],
+/// the macro implements `From<Foo>` for `isize`:
+///
+/// [repr-rs]: https://doc.rust-lang.org/reference/items/enumerations.html#r-items.enum.discriminant.repr-rust
+///
+/// ```rust
+/// use kernel::macros::Into;
+/// use kernel::prelude::*;
+///
+/// #[derive(Debug, Default, Into)]
+/// enum Foo {
+///     #[default]
+///     A,
+///     B = 0x17,
+/// }
+///
+/// assert_eq!(0isize, Foo::A.into());
+/// assert_eq!(0x17isize, Foo::B.into());
+/// ```
+///
+/// ## With `#[repr(T)]`
+///
+/// The macro implements `From<Foo>` for `T`:
+///
+/// ```rust
+/// use kernel::macros::Into;
+/// use kernel::prelude::*;
+///
+/// #[derive(Debug, Default, Into)]
+/// #[repr(u8)]
+/// enum Foo {
+///     #[default]
+///     A,
+///     B = 0x17,
+/// }
+///
+/// assert_eq!(0u8, Foo::A.into());
+/// assert_eq!(0x17u8, Foo::B.into());
+/// ```
+///
+/// ## With `#[into(...)]`
+///
+/// The macro implements `From<Foo>` for each `T` specified in `#[into(...)]`,
+/// which always overrides `#[repr(...)]`:
+///
+/// ```rust
+/// use kernel::macros::Into;
+/// use kernel::prelude::*;
+///
+/// #[derive(Debug, Default, Into)]
+/// #[into(u8, u16)]
+/// #[repr(u8)]
+/// enum Foo {
+///     #[default]
+///     A,
+///     B = 0x17,
+/// }
+///
+/// assert_eq!(0u16, Foo::A.into());
+/// assert_eq!(0x17u16, Foo::B.into());
+/// ```
+///
+/// ## Unsupported Cases
+///
+/// The following examples do not compile:
+///
+/// ```compile_fail
+/// # use kernel::macros::Into;
+/// // Generic parameters are not allowed.
+/// #[derive(Into)]
+/// enum Foo<T> {
+///     A,
+/// }
+///
+/// // Tuple-like enums or struct-like enums are not allowed.
+/// #[derive(Into)]
+/// enum Bar {
+///     A(u8),
+///     B { inner: u8 },
+/// }
+///
+/// // Structs are not allowed.
+/// #[derive(Into)]
+/// struct Baz(u8);
+/// ```
+#[proc_macro_derive(Into, attributes(into))]
+pub fn derive_into(input: TokenStream) -> TokenStream {
+    convert::derive_into(input)
+}
+
 /// A derive macro for generating an impl of the [`TryFrom`] trait.
 ///
 /// This macro automatically derives [`TryFrom`] trait for a given enum. Currently,
-- 
2.39.5


