Return-Path: <linux-kernel+bounces-754431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F166B19439
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 16:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD6201761E2
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 14:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3201D26A087;
	Sun,  3 Aug 2025 14:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNLZm1fD"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABE3156CA;
	Sun,  3 Aug 2025 14:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754230905; cv=none; b=swkCQ3uKh0p1b2oe3mGL3zNq4dlsHZU8sTwVeT2bL0aNCxodG3Ao1CW063lfHaS7QBu9eFs1LlDKnGO9xLZlUHDOps5mPrWqUJ993J2xzR2wvRkKUGe5NQXdlvYg3DGksPxA4lK5H6DLWRR7jo059Cb9+HUbBlUad6tVxAVEM/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754230905; c=relaxed/simple;
	bh=UW4NgyqkgvDyq/INEfqhRNlZQ1MrMBA5Nk73EGCcPak=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LUw4tnCdVqYpr+7a1ARAu/z7DQzheafZouwg07YWcyQouLGHOIEKiE6YYMw3poG+5eBdn61c9HupStn58+/i8KEhO7trRatO/srDf7nbc5d0dcMYKoT6pmK/+ax+4elcVsz7SPTJ7OfZ5He8OzVAl2+sG377ZxXX6LwPaSnDQfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HNLZm1fD; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-76bd202ef81so3862438b3a.3;
        Sun, 03 Aug 2025 07:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754230902; x=1754835702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fXGv88gAYzT87NJ3puOwVetFEtHU40d9kzRdaa9qaB8=;
        b=HNLZm1fDZl3WVElM9I5hPZizVvh2UUIkWJBk919ZfdQ2ORYB5l35Jd1G7wE5LPI9Q2
         b4OPWe+ZyzZlGiUdNsSZU1Mol3lOd3xNpRkGZ+fh/74YqcEq3RZS6aEELN1HCK9jqJ5s
         Kn3oWUbJZGyqAmuV4Bhdfr99kSqPRCLbKjBkLzduEsS5FwHF+uvvJl7OjU5zj8DvJnaa
         bDXQOgPji3K3IzjYTN1HPOC5tytnAfv6+ITxt6rFDXji1/gfPXxbQbAEJWcQiMvo56BK
         HPMwVvCe0AcIHfxAwxKxNAS1LShe0Y2ZO2DmWxg9d/zjplWk1HIzYWH0P7iD4VbKpfp6
         KQtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754230902; x=1754835702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fXGv88gAYzT87NJ3puOwVetFEtHU40d9kzRdaa9qaB8=;
        b=BQTbjDsQFVgi4xtd54DbXSs//SGGEmY+5D8SNnDDyvUTqiBn2HbZYZ9SqQZHN8wWUg
         RxO64KTLUYKmsAG8KqnD8px6SGUMbEwX9lEoqgeIIsy8Auw+QIFI+tl4NJ8d+F1/2NL9
         nCwLRdjqc/2lXd67skZMuoTvOehqq5SI9Ao1LQ5CVLyfsHMAk+f4p70IMvYVxdf9M6iv
         Ej94jaUyAAbF38Q3nG7zHk8+tDZWTYlCJNaOT1WnsC1jZAuFPhkUDlCsyjEa1Ex7Hl/k
         +/dqm5T89Z/UlT2ANhXOr1g+uIkFb5CAeO5L3RmB2PL3HdHZ6xMnX/Vyy/TGfYD6UPK5
         gR2g==
X-Forwarded-Encrypted: i=1; AJvYcCXYu0iYbFKlz73MjAn2QbBFtmsDHk/9yNE9zCE2QqRPiilOqBjgQ8IMSpO6oUHnVBnMVExGAFmkvT1c1HJalQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyA8lRiOuZJRGK1Zk2KNFYKS2xlI7CyHiGNuRYGAAxIoCYZYfRt
	eXCr0gF3AsRSKeVyHP0VVUFe7eM7nHavNR98TQkbZVFctTwa33h6wxvl
X-Gm-Gg: ASbGnctpYUgL66zS+SNo/5rCsqANTTxeW4/lIzkYyTYBKzf+UbFZz/nE++JzSfyYAvI
	zEsIclne0RQ/z7IX4wGRUHQ4prn3t0PQDk+os+n0B2bLTwPPgtFVlF70eBfkJzNQD7sm8tyO89c
	GWFaiY98k0V9w80r5K6Mwkv1FNGaTotg0Yl5NN95D5k5DysD8B87yK0U+qavImglXURFCv39bx8
	BQkgiPOzrxMhCpcKeeJpdp0rcf7IywqO9YBFkUQObiV6DmG/TBqGvvEpKsBaXdiiorjyW1n50mc
	pez9EpcKSjoMtBwzlF47+tUauhQE0cDJscJxHSGg6dTtLHcMR7lHtcMcwp9XZVu/15R1TRvr00M
	/K/xatSoTUn7YnelS/2eHnRycv6eS7QrddFPW/XH8VK1A
X-Google-Smtp-Source: AGHT+IFDgKyZSfBrsaDU/Nae3URYZoGmkvcLbrkczRPqQQTRhdX+/81NmbjdbpX/nJj0Wo3Lv346RQ==
X-Received: by 2002:a05:6a00:1495:b0:749:ad1:ac8a with SMTP id d2e1a72fcca58-76bec48f3e7mr7804931b3a.11.1754230902411;
        Sun, 03 Aug 2025 07:21:42 -0700 (PDT)
Received: from localhost.localdomain ([104.28.217.213])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfd0279sm8431306b3a.98.2025.08.03.07.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 07:21:42 -0700 (PDT)
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
Subject: [PATCH 3/4] rust: macro: add derive macro for `TryFrom`
Date: Sun,  3 Aug 2025 14:20:53 +0000
Message-Id: <58f312f85a30d1da0130b10735ddba89244241cb.1754228164.git.y.j3ms.n@gmail.com>
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

Introduce a procedural macro `TryFrom` to automatically implement the
`TryFrom` trait for unit-only enums.

This reduces boilerplate in cases where numeric values need to be
interpreted as relevant enum variants. This situation often arise when
working with low-level data sources. A typical example is the `Chipset`
enum in nova-core, where the value read from a GPU register should be
mapped to a corresponding variant.

Since a pending RFC [1] proposes adding the `syn` crate [2] as a
dependency, keep the parsing logic minimal.

Link: https://lore.kernel.org/rust-for-linux/20250304225536.2033853-1-benno.lossin@proton.me [1]
Link: https://docs.rs/syn/latest/syn [2]

Signed-off-by: Jesung Yang <y.j3ms.n@gmail.com>
---
 rust/macros/convert.rs | 337 +++++++++++++++++++++++++++++++++++++++++
 rust/macros/lib.rs     | 124 +++++++++++++++
 2 files changed, 461 insertions(+)
 create mode 100644 rust/macros/convert.rs

diff --git a/rust/macros/convert.rs b/rust/macros/convert.rs
new file mode 100644
index 000000000000..0084bc4308c1
--- /dev/null
+++ b/rust/macros/convert.rs
@@ -0,0 +1,337 @@
+// SPDX-License-Identifier: GPL-2.0
+
+use proc_macro::{token_stream, Delimiter, Ident, Span, TokenStream, TokenTree};
+use std::iter::Peekable;
+
+#[derive(Debug)]
+struct TypeArgs {
+    helper: Vec<Ident>,
+    repr: Option<Ident>,
+}
+
+const VALID_TYPES: [&str; 12] = [
+    "u8", "u16", "u32", "u64", "u128", "usize", "i8", "i16", "i32", "i64", "i128", "isize",
+];
+
+pub(crate) fn derive_try_from(input: TokenStream) -> TokenStream {
+    derive(input)
+}
+
+fn derive(input: TokenStream) -> TokenStream {
+    let derive_target = "TryFrom";
+    let derive_helper = "try_from";
+
+    let mut tokens = input.into_iter().peekable();
+
+    let type_args = match parse_types(&mut tokens, derive_helper) {
+        Ok(type_args) => type_args,
+        Err(errs) => return errs,
+    };
+
+    // Skip until the `enum` keyword, including the `enum` itself.
+    for tt in tokens.by_ref() {
+        if matches!(tt, TokenTree::Ident(ident) if ident.to_string() == "enum") {
+            break;
+        }
+    }
+
+    let Some(TokenTree::Ident(enum_ident)) = tokens.next() else {
+        return format!(
+            "::core::compile_error!(\"`#[derive({derive_target})]` can only \
+            be applied to an enum\");"
+        )
+        .parse::<TokenStream>()
+        .unwrap();
+    };
+
+    let mut errs = TokenStream::new();
+
+    if matches!(tokens.peek(), Some(TokenTree::Punct(p)) if p.as_char() == '<') {
+        errs.extend(
+            format!(
+                "::core::compile_error!(\"`#[derive({derive_target})]` \
+                does not support enums with generic parameters\");"
+            )
+            .parse::<TokenStream>()
+            .unwrap(),
+        );
+    }
+
+    let Some(variants_group) = tokens.find_map(|tt| match tt {
+        TokenTree::Group(g) if g.delimiter() == Delimiter::Brace => Some(g),
+        _ => None,
+    }) else {
+        unreachable!("Enums have its corresponding body")
+    };
+
+    let enum_body_tokens = variants_group.stream().into_iter().peekable();
+    let variants = match parse_enum_variants(enum_body_tokens, &enum_ident, derive_target) {
+        Ok(variants) => variants,
+        Err(new_errs) => {
+            errs.extend(new_errs);
+            return errs;
+        }
+    };
+
+    if !errs.is_empty() {
+        return errs;
+    }
+
+    if type_args.helper.is_empty() {
+        // Extract the representation passed by `#[repr(...)]` if present.
+        // If nothing is specified, the default is `Rust` representation,
+        // which uses `isize` for the discriminant type.
+        // See: https://doc.rust-lang.org/reference/items/enumerations.html#r-items.enum.discriminant.repr-rust
+        let ty = type_args
+            .repr
+            .unwrap_or_else(|| Ident::new("isize", Span::mixed_site()));
+        impl_try_from(&ty, &enum_ident, &variants)
+    } else {
+        let impls = type_args
+            .helper
+            .iter()
+            .map(|ty| impl_try_from(ty, &enum_ident, &variants));
+        quote! { #(#impls)* }
+    }
+}
+
+fn parse_types(
+    attrs: &mut Peekable<token_stream::IntoIter>,
+    helper: &str,
+) -> Result<TypeArgs, TokenStream> {
+    let mut helper_args = vec![];
+    let mut repr_arg = None;
+
+    // Scan only the attributes. As soon as we see a token that is
+    // not `#`, we know we have consumed all attributes.
+    while let Some(TokenTree::Punct(p)) = attrs.peek() {
+        if p.as_char() != '#' {
+            unreachable!("Outer attributes start with `#`");
+        }
+        attrs.next();
+
+        // The next token should be a `Group` delimited by brackets.
+        // (e.g., #[try_from(u8, u16)])
+        //         ^^^^^^^^^^^^^^^^^^^
+        let Some(TokenTree::Group(attr_group)) = attrs.next() else {
+            unreachable!("Outer attributes are surrounded by `[` and `]`");
+        };
+
+        let mut inner = attr_group.stream().into_iter();
+
+        // Extract the attribute identifier.
+        // (e.g., #[try_from(u8, u16)])
+        //          ^^^^^^^^
+        let attr_name = match inner.next() {
+            Some(TokenTree::Ident(ident)) => ident.to_string(),
+            _ => unreachable!("Attributes have identifiers"),
+        };
+
+        if attr_name == helper {
+            match parse_helper_args(inner, helper) {
+                Ok(v) => helper_args.extend_from_slice(&v),
+                Err(errs) => return Err(errs),
+            }
+        } else if attr_name == "repr" {
+            repr_arg = parse_repr_args(inner);
+        }
+    }
+
+    Ok(TypeArgs {
+        helper: helper_args,
+        repr: repr_arg,
+    })
+}
+
+fn parse_repr_args(mut tt_group: impl Iterator<Item = TokenTree>) -> Option<Ident> {
+    // The next token should be a `Group` delimited by parentheses.
+    // (e.g., #[repr(C, u8)])
+    //              ^^^^^^^
+    let Some(TokenTree::Group(args_group)) = tt_group.next() else {
+        unreachable!("`repr` attribute has at least one argument")
+    };
+
+    for arg in args_group.stream() {
+        if let TokenTree::Ident(type_ident) = arg {
+            if VALID_TYPES.contains(&type_ident.to_string().as_str()) {
+                return Some(type_ident);
+            }
+        }
+    }
+
+    None
+}
+
+fn parse_helper_args(
+    mut tt_group: impl Iterator<Item = TokenTree>,
+    helper: &str,
+) -> Result<Vec<Ident>, TokenStream> {
+    let mut errs = TokenStream::new();
+    let mut args = vec![];
+
+    // The next token should be a `Group`.
+    // (e.g., #[try_from(u8, u16)])
+    //                  ^^^^^^^^^
+    let Some(TokenTree::Group(args_group)) = tt_group.next() else {
+        return Err(format!(
+            "::core::compile_error!(\"`{helper}` attribute expects at \
+            least one integer type argument (e.g., `#[{helper}(u8)]`)\");"
+        )
+        .parse::<TokenStream>()
+        .unwrap());
+    };
+
+    let raw_args = args_group.stream();
+    if raw_args.is_empty() {
+        return Err(format!(
+            "::core::compile_error!(\"`{helper}` attribute expects at \
+            least one integer type argument (e.g., `#[{helper}(u8)]`)\");"
+        )
+        .parse::<TokenStream>()
+        .unwrap());
+    }
+
+    // Iterate over the attribute argument tokens to collect valid integer
+    // type identifiers.
+    let mut raw_args = raw_args.into_iter();
+    while let Some(tt) = raw_args.next() {
+        let TokenTree::Ident(type_ident) = tt else {
+            errs.extend(
+                format!(
+                    "::core::compile_error!(\"`{helper}` attribute expects \
+                    comma-separated integer type arguments \
+                    (e.g., `#[{helper}(u8, u16)]`)\");"
+                )
+                .parse::<TokenStream>()
+                .unwrap(),
+            );
+            return Err(errs);
+        };
+
+        if VALID_TYPES.contains(&type_ident.to_string().as_str()) {
+            args.push(type_ident);
+        } else {
+            errs.extend(
+                format!(
+                    "::core::compile_error!(\"`{type_ident}` in `{helper}` \
+                    attribute is not an integer type\");"
+                )
+                .parse::<TokenStream>()
+                .unwrap(),
+            );
+        }
+
+        match raw_args.next() {
+            Some(TokenTree::Punct(p)) if p.as_char() == ',' => continue,
+            None => break,
+            Some(_) => {
+                errs.extend(
+                    format!(
+                        "::core::compile_error!(\"`{helper}` attribute expects \
+                        comma-separated integer type arguments \
+                        (e.g., `#[{helper}(u8, u16)]`)\");"
+                    )
+                    .parse::<TokenStream>()
+                    .unwrap(),
+                );
+                return Err(errs);
+            }
+        }
+    }
+
+    if !errs.is_empty() {
+        return Err(errs);
+    }
+
+    Ok(args)
+}
+
+fn parse_enum_variants(
+    mut tokens: Peekable<token_stream::IntoIter>,
+    enum_ident: &Ident,
+    derive_target: &str,
+) -> Result<Vec<Ident>, TokenStream> {
+    let mut errs = TokenStream::new();
+
+    let mut variants = vec![];
+
+    if tokens.peek().is_none() {
+        errs.extend(
+            format!(
+                "::core::compile_error!(\"`#[derive({derive_target})]` \
+                does not support zero-variant enums\");"
+            )
+            .parse::<TokenStream>()
+            .unwrap(),
+        );
+    }
+
+    while let Some(tt) = tokens.next() {
+        // Skip attributes like `#[...]` if present.
+        if matches!(&tt, TokenTree::Punct(p) if p.as_char() == '#') {
+            tokens.next();
+            continue;
+        }
+
+        let TokenTree::Ident(ident) = tt else {
+            unreachable!("Enum variants have its corresponding identifier");
+        };
+
+        // Reject tuple-like or struct-like variants.
+        if let Some(TokenTree::Group(g)) = tokens.peek() {
+            let variant_kind = match g.delimiter() {
+                Delimiter::Brace => "struct-like",
+                Delimiter::Parenthesis => "tuple-like",
+                _ => unreachable!("Invalid enum variant syntax"),
+            };
+            errs.extend(
+                format!(
+                    "::core::compile_error!(\"`#[derive({derive_target})]` does not \
+                    support {variant_kind} variant `{enum_ident}::{ident}`; \
+                    only unit variants are allowed\");"
+                )
+                .parse::<TokenStream>()
+                .unwrap(),
+            );
+        }
+
+        // Skip through the comma.
+        for tt in tokens.by_ref() {
+            if matches!(tt, TokenTree::Punct(p) if p.as_char() == ',') {
+                break;
+            }
+        }
+
+        variants.push(ident);
+    }
+
+    if !errs.is_empty() {
+        return Err(errs);
+    }
+
+    Ok(variants)
+}
+
+fn impl_try_from(ty: &Ident, enum_ident: &Ident, variants: &[Ident]) -> TokenStream {
+    let param = Ident::new("value", Span::mixed_site());
+
+    let clauses = variants.iter().map(|variant| {
+        quote! {
+            if #param == Self::#variant as #ty {
+                ::core::result::Result::Ok(Self::#variant)
+            } else
+        }
+    });
+
+    quote! {
+        #[automatically_derived]
+        impl ::core::convert::TryFrom<#ty> for #enum_ident {
+            type Error = ::kernel::prelude::Error;
+            fn try_from(#param: #ty) -> Result<Self, Self::Error> {
+                #(#clauses)* {
+                    ::core::result::Result::Err(::kernel::prelude::EINVAL)
+                }
+            }
+        }
+    }
+}
diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
index fa847cf3a9b5..569198f188f7 100644
--- a/rust/macros/lib.rs
+++ b/rust/macros/lib.rs
@@ -14,6 +14,7 @@
 #[macro_use]
 mod quote;
 mod concat_idents;
+mod convert;
 mod export;
 mod helpers;
 mod kunit;
@@ -425,3 +426,126 @@ pub fn paste(input: TokenStream) -> TokenStream {
 pub fn kunit_tests(attr: TokenStream, ts: TokenStream) -> TokenStream {
     kunit::kunit_tests(attr, ts)
 }
+
+/// A derive macro for generating an impl of the [`TryFrom`] trait.
+///
+/// This macro automatically derives [`TryFrom`] trait for a given enum. Currently,
+/// it only supports [unit-only enum]s without generic parameters.
+///
+/// [unit-only enum]: https://doc.rust-lang.org/reference/items/enumerations.html#r-items.enum.unit-only
+///
+/// # Notes
+///
+/// The macro generates [`TryFrom`] implementations that:
+/// - Convert numeric values to enum variants by matching discriminant values.
+/// - Return `Ok(VARIANT)` for valid matches.
+/// - Return `Err(EINVAL)` for invalid matches (where `EINVAL` is from
+///   [`kernel::error::code`]).
+///
+/// The macro uses the `try_from` custom attribute or `repr` attribute to generate
+/// corresponding [`TryFrom`] implementations. `try_from` always takes precedence
+/// over `repr`.
+///
+/// [`kernel::error::code`]: ../kernel/error/code/index.html
+///
+/// # Caveats
+///
+/// Ensure that every integer type specified in `#[try_from(...)]` is large enough
+/// to cover all enum discriminants. Otherwise, the internal `as` casts may overflow.
+///
+/// # Examples
+///
+/// ## Without Attributes
+///
+/// Since [the default `Rust` representation uses `isize` for the discriminant type][repr-rs],
+/// the macro implements `TryFrom<isize>`:
+///
+/// [repr-rs]: https://doc.rust-lang.org/reference/items/enumerations.html#r-items.enum.discriminant.repr-rust
+///
+/// ```rust
+/// use kernel::macros::TryFrom;
+/// use kernel::prelude::*;
+///
+/// #[derive(Debug, Default, PartialEq, TryFrom)]
+/// enum Foo {
+///     #[default]
+///     A,
+///     B = 0x17,
+/// }
+///
+/// assert_eq!(Foo::try_from(0isize), Ok(Foo::A));
+/// assert_eq!(Foo::try_from(0x17isize), Ok(Foo::B));
+/// assert_eq!(Foo::try_from(0x19isize), Err(EINVAL));
+/// ```
+///
+/// ## With `#[repr(T)]`
+///
+/// The macro implements `TryFrom<T>`:
+///
+/// ```rust
+/// use kernel::macros::TryFrom;
+/// use kernel::prelude::*;
+///
+/// #[derive(Debug, Default, PartialEq, TryFrom)]
+/// #[repr(u8)]
+/// enum Foo {
+///     #[default]
+///     A,
+///     B = 0x17,
+/// }
+///
+/// assert_eq!(Foo::try_from(0u8), Ok(Foo::A));
+/// assert_eq!(Foo::try_from(0x17u8), Ok(Foo::B));
+/// assert_eq!(Foo::try_from(0x19u8), Err(EINVAL));
+/// ```
+///
+/// ## With `#[try_from(...)]`
+///
+/// The macro implements `TryFrom<T>` for each `T` specified in `#[try_from(...)]`,
+/// which always overrides `#[repr(...)]`:
+///
+/// ```rust
+/// use kernel::macros::TryFrom;
+/// use kernel::prelude::*;
+///
+/// #[derive(Debug, Default, PartialEq, TryFrom)]
+/// #[try_from(u8, u16)]
+/// #[repr(u8)]
+/// enum Foo {
+///     #[default]
+///     A,
+///     B = 0x17,
+/// }
+///
+/// assert_eq!(Foo::try_from(0u16), Ok(Foo::A));
+/// assert_eq!(Foo::try_from(0x17u16), Ok(Foo::B));
+/// assert_eq!(Foo::try_from(0x19u16), Err(EINVAL));
+/// ```
+///
+/// ## Unsupported Cases
+///
+/// The following examples do not compile:
+///
+/// ```compile_fail
+/// # use kernel::macros::TryFrom;
+/// // Generic parameters are not allowed.
+/// #[derive(TryFrom)]
+/// enum Foo<T> {
+///     A,
+/// }
+///
+/// // Tuple-like enums or struct-like enums are not allowed.
+/// #[derive(TryFrom)]
+/// enum Bar {
+///     A(u8),
+///     B { inner: u8 },
+/// }
+///
+/// // Structs are not allowed.
+/// #[derive(TryFrom)]
+/// struct Baz(u8);
+/// ```
+#[proc_macro_derive(TryFrom, attributes(try_from))]
+pub fn derive_try_from(input: TokenStream) -> TokenStream {
+    convert::derive_try_from(input)
+}
-- 
2.39.5


