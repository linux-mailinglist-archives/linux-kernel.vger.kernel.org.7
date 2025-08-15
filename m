Return-Path: <linux-kernel+bounces-770213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0045DB2787D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 07:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DFFE5A539D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 05:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01802BD58C;
	Fri, 15 Aug 2025 05:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7Dbuujc"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672B629D27F;
	Fri, 15 Aug 2025 05:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755235970; cv=none; b=YEVLKyNVk+evYEIPrukPaxd4v7T5jpiBHNkFJUIghr+/9JevMWBBDul31YpFJ8YlylOyR7hkX/AG1DSzbyyKZOqVaNvOxkleknsDzqKtTH1HPv7aOB5IbwjIdzpIMjRH0kDdDHdfjiIL1g7lzk1+iIBjQaoeX4aIl8hMePqk9a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755235970; c=relaxed/simple;
	bh=Q1QijZaIyNilZgfcTR3okvN6t2dytzDlyw7S4CQUlBw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r6tjtPstXUbIdVD09VSm3qtUBJo0oyZIdAtV+SrWENDiij9M8dPNBs3qgJM5qdkDmDiEZDqU4kp7MPlk5PtUi+cTtSyAodPklSmciw+SVjte1SPokypEgBWlnf+9EARPRgdXxbWb9VK4Zdy+xXSdId9os69thvAQ1yclalJqsUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h7Dbuujc; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b472fd93b4aso62433a12.0;
        Thu, 14 Aug 2025 22:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755235967; x=1755840767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v++t53P4EgG48rVd8q9X8cTEHlETjx3oHYParZ2OE2U=;
        b=h7Dbuujc5sN/3QG8PNEksDYxdKGq174z8NGhEYbq8ZLqCAfbomLiMaZS/zbDfXIANu
         VMSO6pzPyrnQ3tFmRKt6Qbcl/htV8VFDQzZ6fEKfJA+QoyIE4Plnjsaks+AKHjC5FUGU
         H8fBXPFGRsE2YPQGshgxkoR2PfKgTYxZufnQ6wrMOoqgK6m3Wyv6+CdDYj4fNPaw+ksB
         WZ2df0rFlogzWPSG4da4H5jtQudkNl21iudZoTxOE7VC5gmWyGYQDCQsptkZm/ueSYxj
         b1KXNHKHhTZbbePQpeby3+XqyBKzTraorwzWwZsx/SGbQwCWRTw1gtkSdiXgSnWpVik1
         PhEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755235967; x=1755840767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v++t53P4EgG48rVd8q9X8cTEHlETjx3oHYParZ2OE2U=;
        b=U0ru2qGP6Ciyi2R18lPuHh7sWLHLqs1olsvCM4d/PHCR+xAsxMNXoPn1GcW2eb8TFf
         +fCgWogtRAz/rCsOCGwpDjr8Rmx/JLSGMw+hnxw+QrKKTPgSq7aZJNu8BHMUTcf2kiXG
         Qfonz/DH5OrKpl3iQTrdzELnEhmSmRAAU+NUJxCQWhFHbZBShLy71ZS6tSEsFZXlHPHW
         JELtXI9AorJs25yn8a58Hsx/7UL3z+dmih/8NpcdRxSTNQZ9AIlSsxxlAoMtltEv+TbX
         BTBgrfaRwCJJFQP9K09vp5xp1aE7Fp9NLF1E1XOyp82LHRet0CGvRiKUJkqbXVoSCHvR
         zdGw==
X-Forwarded-Encrypted: i=1; AJvYcCWevAbJr9nBQa4wh/15Raj+Ee+8+i/hcEF23VSWTANV9+zgW0NNDVIJ+i+KrTTF9myyCQ7swZmbelxQ33Qh4Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzvizjoMQMhYkCEqfKvBz5RAl0PudYGNoRRYKkcW69mjzDsO3b2
	wMItN6mbe8eyKffqFlrxDsCz38tZVno6L0ptuac+VcQDKN9nU5EclFdf
X-Gm-Gg: ASbGncubQBNimoZvjmWncl2hHqN3fVyh6QLW292PuUgVuhsYVf8jy3T+bvrXv5HDWN2
	tBrjQTnR8XtkYiNRcS/OXH6rOyQfSKsyICQhTe91jcPyro4ey41Aghikbm5TR/dv+vERGZYaSMe
	cP/OZyC7LtlE7uG0OqKyaHZbtAiHjEjVJS0EJlfs00Qpi6KVQWczE8hcuF/+IfeoeGbB1QHFst4
	r7jEptMBQMxkws78XuyN4heOZq1BKGsIhHBYRElrwIif/xd9uPNxFgFaXXRaPUM0RsIavFlD6ZC
	AfLbD2r3U2jaScNNarrv1OGuC9ku7RIm1S5qgXfXK3OjSiJT1dOzjkGnn0rasIS6vv4pZaQ+lAT
	X45T4/7T+e2ESTYPGVOeRGJA4rYVjeXTUQZ/NN3u3Gr119seL0pkfUw==
X-Google-Smtp-Source: AGHT+IEuP38negAiTWY+byl6T/38/ZPMacDl/61+NORQDMLLFI1r5I/hC9/JTBTB8whMfGGc35G05g==
X-Received: by 2002:a17:903:228a:b0:240:1bca:54 with SMTP id d9443c01a7336-2446d861ff2mr14514005ad.35.1755235967324;
        Thu, 14 Aug 2025 22:32:47 -0700 (PDT)
Received: from localhost.localdomain ([112.149.32.52])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e4556692bsm335234b3a.61.2025.08.14.22.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 22:32:47 -0700 (PDT)
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
Subject: [PATCH v2 4/5] rust: macros: add derive macro for `TryFrom`
Date: Fri, 15 Aug 2025 05:32:14 +0000
Message-Id: <fe6b77690dabff7833582bb728b822cca4f1cf62.1755235180.git.y.j3ms.n@gmail.com>
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

Introduce a procedural macro `TryFrom` to automatically implement the
`TryFrom` trait for unit-only enums.

This reduces boilerplate in cases where numeric values need to be
interpreted as relevant enum variants. This situation often arise when
working with low-level data sources. A typical example is the `Chipset`
enum in nova-core, where the value read from a GPU register should be
mapped to a corresponding variant.

Since a pending RFC [1] proposes adding the `syn` crate [2] as a
dependency, keep the parsing logic minimal.

Tested-by: Alexandre Courbot <acourbot@nvidia.com>
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


