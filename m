Return-Path: <linux-kernel+bounces-770214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B05D7B2787E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 07:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27F1D5A5D40
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 05:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F062F2BE7AF;
	Fri, 15 Aug 2025 05:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M39SLHOE"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C5C2BE65B;
	Fri, 15 Aug 2025 05:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755235976; cv=none; b=IFRON3AQHjoICxcMXx1TBYFTy8b0+0DGg5+TyLMzD/z/FXLYQxvNi4t8YRVc9nBkPe1PpVhgM1IQ4DsSHMVVTVq1KAQh2BILGxowN2/gZ+ImN8WbTpGa8cfxD51BSsi5Q/7OzNRGwOm+cCOl7CMcmNiDQlZzOkrOmkGuxga/YU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755235976; c=relaxed/simple;
	bh=BQlAO40Fkf8jj/Luuxq4Hy8WbOuf4ZzAo8KvzU12f5o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TqavWEMIlqSjSOC/tMq4+7PkOs1/gpkgm0JB/mSn6gUTCVNaNCMoo1xEKKYqS+59kNuEWZtHlhUcGNFNJbTaje3dWxePTwdWGDPk9yJjZXh6W2avmM5gcvUSWhM2nPROPe6stvhYmxVGH6OPjMIbmpBtAOKgFZTMQGIZQO3XHpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M39SLHOE; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-76e2ea94c7dso2178910b3a.2;
        Thu, 14 Aug 2025 22:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755235973; x=1755840773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QTd2SnS44QbWRezmUmEtQLo0ES7cL0NdhN8U5PrZ/34=;
        b=M39SLHOEIIf9JpZ1OFFToOnBh9PfbbAm1Zz+YLhalBzCJUcq5tI0XbTXLYmggUM0qS
         H5eJgmgdofX51sdFDNoqnbdjFsZvqHCFgDNq4YiYEfxiDefLZvvab22+oBeaKZbdvL/3
         MG3cKTRZv+MdJ3xoTnMWdnN+ZkOgBR7dCwJu9EZXJfhbevvemxzEcanHsBTIOsqkeT94
         TAWUazgeA4M21zjUoI+mWyU8J//nFKoob64qYSq5xEmoO0TM+0UnP/R1EwH/yR+2maoS
         S0Aa5mXz303DNyQGOKv5s4lgiZA78IT5XXgUhiqFNLDu5oaHmL6gbzoDbqFzwaJ4QbzQ
         +m2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755235973; x=1755840773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QTd2SnS44QbWRezmUmEtQLo0ES7cL0NdhN8U5PrZ/34=;
        b=feu458C4YjbRz7UGFrmqZQQ488kMb6q6fqyCL7nkAOqGJV1/j3zZXOY18JaZiuBhob
         a/PBYyBeeuGV6GM+n3Pto5hd8WJYXSXKlad+H60ctVG+8QB5a6MMtEtX9JAiqC9kzMYR
         qw56fiwCkR0wME52IEt3cNQ1Got/XToH3Hqw4sWPRyGddziZGyStciw5Pz1HAvlIrC7+
         TW2ryvlnhuyOSgsA3yYD2j+zyEVoXW/dmUtQgxMQrUzQ+YyRsxFZE3ODz8Z+n7tIx/xg
         FtihFc8jfOmOcIZ6IaUh4+9tU1+RAJbmhjlf6s5ZWLDBHHG5PgeqKL2Q7KO0nyPCamsg
         HSzg==
X-Forwarded-Encrypted: i=1; AJvYcCWJkgGHpZ3Pmv8TMgajWNTHCUHT/TMNYE7Lx0LfZAPTrk2SgsjkeS5pniz84w0Twf2Lyzptpdk4JTTIqeLM+w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyewN7J4mwDf/IGU7x19yaDP6f1rSs+LzzWkoxPx4ZyGh4cTSqp
	ndIXw1Mki4jI9JHERY0YGE3+IZUpVQWJSW/MKHB0mFu0IuPz3jRinL7w
X-Gm-Gg: ASbGncuAm7HqdZUaLdA7q+D4L7hPIeFgESn15LmZx1xiGk0LU1ApCqKV01EZ0hd3bAt
	3cq9KifjfE7F6AMUggSZ4hR9Hsxj7IxolAjRpyvHQ/P20lk6b+D1VsdmrWxYttccnE/+US0uglV
	vrUb1FhaczY3D97tYO14WkdclraBT/HhyhHqU+Cg7bLkORT/2JSScP+vo5bdd+ppVH/15i1glvj
	rucGXgG6J51y33B733hqI0mbn1ldonenpP2NnvAUEo21U+BN0YSn6mbT/BtJ+XmRhU4EVZoScnm
	RyXQ6gsVJ/qzQRRd2eQR2ulVsrMu7APEbkYcJJ/pXt3T5Num89fOX/dxeMzKCe9HUU1SWymE9yQ
	bZVhopUp070tZ6VA3wPZJ0/Yvn3tTEPqP2NPGBcRBuCc=
X-Google-Smtp-Source: AGHT+IHuZOMmR+ZHN6RawSbyEcHlvGHloyTnjAjRuRVJt3T79TKeciymvac/iLTdRF79wIc9l0ITyA==
X-Received: by 2002:a05:6a00:1acd:b0:748:e585:3c42 with SMTP id d2e1a72fcca58-76e447ab3b2mr978211b3a.15.1755235972528;
        Thu, 14 Aug 2025 22:32:52 -0700 (PDT)
Received: from localhost.localdomain ([112.149.32.52])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e4556692bsm335234b3a.61.2025.08.14.22.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 22:32:52 -0700 (PDT)
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
Subject: [PATCH v2 5/5] rust: macros: add derive macro for `Into`
Date: Fri, 15 Aug 2025 05:32:15 +0000
Message-Id: <042f8ba119337b090e8774355fc77478d86ea8ef.1755235180.git.y.j3ms.n@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1755235180.git.y.j3ms.n@gmail.com>
References: <cover.1755235180.git.y.j3ms.n@gmail.com>
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

Tested-by: Alexandre Courbot <acourbot@nvidia.com>
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


