Return-Path: <linux-kernel+bounces-725947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 318BAB005D1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 16:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46EBD4E0B61
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 14:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7583E2749FA;
	Thu, 10 Jul 2025 14:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Afgf3OWi"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890F3274656;
	Thu, 10 Jul 2025 14:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752159227; cv=none; b=O72I5Y4GlhReA7wl/g2w9AxfAF7kOqJy04i8ROsbcptJzKcSfb72JLK2yjvYEdaFz766Dgnab76bDJGhKNp5XQ/NEdX6IKazVKXL1BUgxHbrzD7KyMjuGNHSH0FPqVHXh/d6hVwZJowhrdIQMQyQTRek2JNcMn2aZpsBVrSPny0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752159227; c=relaxed/simple;
	bh=0wSR+ShttbtczHAy5H0Sl3UOKI7A4jLRX6PugrLKwKk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SNKAzbf9NIgG99LF+uBekJ9lkwm7lsalCY47Bq2X7G81V0oYxeSIJwje7j2vFhu+zjpITlPEnnGWQtdY2PW4f4Wl4izaIS0UtYuEOLEa/c2rdObphj9hOei7Uv3J5s+vXMfxbmtNMcqjqKThV1Dyg/URVq9aTWLG1p5fTkFwNtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Afgf3OWi; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7d9e2f85ab4so101402785a.3;
        Thu, 10 Jul 2025 07:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752159223; x=1752764023; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GAN8zb60ZxRXD0+KvDN0I2W4zoHQYT5AMmD/2Mo3ya0=;
        b=Afgf3OWieUL1V41/qsTO/UiTBjpdr6DjZQ2yCRAu4RcUOtxSTHnztezYZm0FDSozg5
         PKCRYsD+JFpiJDE6TetaNVcniB3L5daiL7Z0DX7C3hD1/sKmkpoOYiUUvRkHO9oZS5fE
         6R3rYRccceMwRC3DT1wZrobUPY5HFE6G9I51jxGCb1kUTR+dxuYq15EtGa+PPCQsal7n
         ggebksAp8sT4SFIhaOKZRUQvQeYc6rNv0c59+gZ1CPHuqzObho1XZpI56112VOWIF9lV
         AC75QmXOU2k86Pzw2gbZW36Ki19t3euAf1geLt3TfVPKI4enEyB18W3P44tvoENyXShj
         P1Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752159223; x=1752764023;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GAN8zb60ZxRXD0+KvDN0I2W4zoHQYT5AMmD/2Mo3ya0=;
        b=cWl99izZ/7p+Oy1O4Dd2vnIls/uFz/ZAv4/p6Te1wT+n2L3R0+j/ZxJs1ldRWu6aot
         2BBUHOfosfS26TqfHmlRnI23ng13Jz+WEAIHn63Mx4HN2TrakIF+ymxLzBP0nT7dNq4e
         epX1ZR0ty/B/xlipK8Vx8kG3XBurhjPkjxkOcYyTikZsexyXkF7xxa4KNEmTuicbtiqP
         0U8hGmQ7L3QDg6fjTi1/oGI15LR88ssarK2CDiT0lPQmLam7SEVcyjXpZEgNlg1jrRac
         LDZLyLFWVuiuZqKAYB+u/ucz4HtYW3AcqEHl8LXoiqdSC6r/9BH9bIbPCXdNN7szPZ0y
         GrMA==
X-Forwarded-Encrypted: i=1; AJvYcCXGRSIuY6bbYzo3LBbbMINvuvjNvw6cyZTTgEcdhfgNt5h8YB60ojNQQ/ZfbpiLlUTtbA1rfU9Q5UcwB9A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd211PBUdVxDJqPVVvosylSmkcNe3C0PHuQ4vijZfc/9cxkyML
	iMNWF5R92uyzHXLeCjtjXQ46LYFpkCcOTSGZiwxXJE1LL6jOS+K0MxB1
X-Gm-Gg: ASbGnctWqgYuWxb3x/O8smNlnnREI8f5am/ijbeKmRgahUkm/dmzdeDUJhfrH9hRUzD
	m1COPMIq6LlYzdBXmglw1pQts69nTr3R7XcLYlC4SM3AMTeCgfDPZsUKPm4IFw1GW7G3u3cj8As
	I5kezbMZ5zVUpX3N9X9bP1NFzVg9P4dIaYAUDah+sFTtxD/FBPIJ1Wqu1DWDGFAVGV1zRakmbgo
	TsmQ/WTE6j9VrWl17OJ7jf4jUrdOIs525FK8xaBXgOHo0nwwl7ygmqNam+p3QiwyOyPOYJSMtRr
	lbGDlKgfAY3ovrChg2a0BSYYmu0v+qOK2uNDYe4yK3cJZhgBcOpTGqPSpHiWC/b4AELmSvxROD5
	eBwCAkWDEyVfQByjIihdTFLAsrNuMDjClrbWbZ8z2UUCr45PPjj44UPFymaGnrGU=
X-Google-Smtp-Source: AGHT+IE7hMhI+MTblX5H8f4iRMMlk/Pc6Mc7fPn7fgU+t69i2WLafJcQzrz9FSbV4rCvreCl2EZzZg==
X-Received: by 2002:a05:6214:23cd:b0:6fd:5cf4:cbb0 with SMTP id 6a1803df08f44-7048b992b7fmr120657796d6.25.1752159223090;
        Thu, 10 Jul 2025 07:53:43 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([148.76.185.197])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-704979f49b0sm9138996d6.54.2025.07.10.07.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 07:53:42 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 10 Jul 2025 10:53:30 -0400
Subject: [PATCH v14 2/3] rust: support formatting of foreign types
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-cstr-core-v14-2-ca7e0ca82c82@gmail.com>
References: <20250710-cstr-core-v14-0-ca7e0ca82c82@gmail.com>
In-Reply-To: <20250710-cstr-core-v14-0-ca7e0ca82c82@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1752159218; l=11033;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=0wSR+ShttbtczHAy5H0Sl3UOKI7A4jLRX6PugrLKwKk=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QMda5hBskhE4Q3DHX1XP+tCgPsUQ/0foFWthQrb6dnCRnovULze6KdKxGgLj2jDDsbvvWCBVug9
 BTpn0TE5WdQQ=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Introduce a `fmt!` macro which wraps all arguments in
`kernel::fmt::Adapter` and a `kernel::fmt::Display` trait. This enables
formatting of foreign types (like `core::ffi::CStr`) that do not
implement `core::fmt::Display` due to concerns around lossy conversions
which do not apply in the kernel.

Suggested-by: Alice Ryhl <aliceryhl@google.com>
Link: https://rust-for-linux.zulipchat.com/#narrow/channel/288089-General/topic/Custom.20formatting/with/516476467
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/fmt.rs     | 87 +++++++++++++++++++++++++++++++++++++++++++++-
 rust/kernel/prelude.rs |  3 +-
 rust/macros/fmt.rs     | 94 ++++++++++++++++++++++++++++++++++++++++++++++++++
 rust/macros/lib.rs     | 19 ++++++++++
 rust/macros/quote.rs   |  7 ++++
 5 files changed, 207 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/fmt.rs b/rust/kernel/fmt.rs
index 0306e8388968..84d634201d90 100644
--- a/rust/kernel/fmt.rs
+++ b/rust/kernel/fmt.rs
@@ -4,4 +4,89 @@
 //!
 //! This module is intended to be used in place of `core::fmt` in kernel code.
 
-pub use core::fmt::{Arguments, Debug, Display, Error, Formatter, Result, Write};
+pub use core::fmt::{Arguments, Debug, Error, Formatter, Result, Write};
+
+/// Internal adapter used to route allow implementations of formatting traits for foreign types.
+///
+/// It is inserted automatically by the [`fmt!`] macro and is not meant to be used directly.
+///
+/// [`fmt!`]: crate::prelude::fmt!
+#[doc(hidden)]
+pub struct Adapter<T>(pub T);
+
+macro_rules! impl_fmt_adapter_forward {
+    ($($trait:ident),* $(,)?) => {
+        $(
+            impl<T: $trait> $trait for Adapter<T> {
+                fn fmt(&self, f: &mut Formatter<'_>) -> Result {
+                    let Self(t) = self;
+                    $trait::fmt(t, f)
+                }
+            }
+        )*
+    };
+}
+
+use core::fmt::{Binary, LowerExp, LowerHex, Octal, Pointer, UpperExp, UpperHex};
+impl_fmt_adapter_forward!(Debug, LowerHex, UpperHex, Octal, Binary, Pointer, LowerExp, UpperExp);
+
+/// A copy of [`core::fmt::Display`] that allows us to implement it for foreign types.
+///
+/// Types should implement this trait rather than [`core::fmt::Display`]. Together with the
+/// [`Adapter`] type and [`fmt!`] macro, it allows for formatting foreign types (e.g. types from
+/// core) which do not implement [`core::fmt::Display`] directly.
+///
+/// [`fmt!`]: crate::prelude::fmt!
+pub trait Display {
+    /// Same as [`core::fmt::Display::fmt`].
+    fn fmt(&self, f: &mut Formatter<'_>) -> Result;
+}
+
+impl<T: ?Sized + Display> Display for &T {
+    fn fmt(&self, f: &mut Formatter<'_>) -> Result {
+        Display::fmt(*self, f)
+    }
+}
+
+impl<T: ?Sized + Display> core::fmt::Display for Adapter<&T> {
+    fn fmt(&self, f: &mut Formatter<'_>) -> Result {
+        let Self(t) = self;
+        Display::fmt(t, f)
+    }
+}
+
+macro_rules! impl_display_forward {
+    ($(
+        $( { $($generics:tt)* } )? $ty:ty $( { where $($where:tt)* } )?
+    ),* $(,)?) => {
+        $(
+            impl$($($generics)*)? Display for $ty $(where $($where)*)? {
+                fn fmt(&self, f: &mut Formatter<'_>) -> Result {
+                    core::fmt::Display::fmt(self, f)
+                }
+            }
+        )*
+    };
+}
+
+impl_display_forward!(
+    bool,
+    char,
+    core::panic::PanicInfo<'_>,
+    Arguments<'_>,
+    i128,
+    i16,
+    i32,
+    i64,
+    i8,
+    isize,
+    str,
+    u128,
+    u16,
+    u32,
+    u64,
+    u8,
+    usize,
+    {<T: ?Sized>} crate::sync::Arc<T> {where crate::sync::Arc<T>: core::fmt::Display},
+    {<T: ?Sized>} crate::sync::UniqueArc<T> {where crate::sync::UniqueArc<T>: core::fmt::Display},
+);
diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
index 3ca934885797..41cebd906c4c 100644
--- a/rust/kernel/prelude.rs
+++ b/rust/kernel/prelude.rs
@@ -22,7 +22,7 @@
 pub use crate::alloc::{flags::*, Box, KBox, KVBox, KVVec, KVec, VBox, VVec, Vec};
 
 #[doc(no_inline)]
-pub use macros::{export, kunit_tests, module, vtable};
+pub use macros::{export, fmt, kunit_tests, module, vtable};
 
 pub use pin_init::{init, pin_data, pin_init, pinned_drop, InPlaceWrite, Init, PinInit, Zeroable};
 
@@ -33,7 +33,6 @@
 pub use super::dbg;
 pub use super::{dev_alert, dev_crit, dev_dbg, dev_emerg, dev_err, dev_info, dev_notice, dev_warn};
 pub use super::{pr_alert, pr_crit, pr_debug, pr_emerg, pr_err, pr_info, pr_notice, pr_warn};
-pub use core::format_args as fmt;
 
 pub use super::{try_init, try_pin_init};
 
diff --git a/rust/macros/fmt.rs b/rust/macros/fmt.rs
new file mode 100644
index 000000000000..2f4b9f6e2211
--- /dev/null
+++ b/rust/macros/fmt.rs
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: GPL-2.0
+
+use proc_macro::{Ident, TokenStream, TokenTree};
+use std::collections::BTreeSet;
+
+/// Please see [`crate::fmt`] for documentation.
+pub(crate) fn fmt(input: TokenStream) -> TokenStream {
+    let mut input = input.into_iter();
+
+    let first_opt = input.next();
+    let first_owned_str;
+    let mut names = BTreeSet::new();
+    let first_span = {
+        let Some((mut first_str, first_span)) = (match first_opt.as_ref() {
+            Some(TokenTree::Literal(first_lit)) => {
+                first_owned_str = first_lit.to_string();
+                Some(first_owned_str.as_str()).and_then(|first| {
+                    let first = first.strip_prefix('"')?;
+                    let first = first.strip_suffix('"')?;
+                    Some((first, first_lit.span()))
+                })
+            }
+            _ => None,
+        }) else {
+            return first_opt.into_iter().chain(input).collect();
+        };
+
+        // Parse `identifier`s from the format string.
+        //
+        // See https://doc.rust-lang.org/std/fmt/index.html#syntax.
+        while let Some((_, rest)) = first_str.split_once('{') {
+            first_str = rest;
+            if let Some(rest) = first_str.strip_prefix('{') {
+                first_str = rest;
+                continue;
+            }
+            if let Some((name, rest)) = first_str.split_once('}') {
+                first_str = rest;
+                let name = name.split_once(':').map_or(name, |(name, _)| name);
+                if !name.is_empty() && !name.chars().all(|c| c.is_ascii_digit()) {
+                    names.insert(name);
+                }
+            }
+        }
+        first_span
+    };
+
+    let adapter = quote_spanned!(first_span => ::kernel::fmt::Adapter);
+
+    let mut args = TokenStream::from_iter(first_opt);
+    {
+        let mut flush = |args: &mut TokenStream, current: &mut TokenStream| {
+            let current = std::mem::take(current);
+            if !current.is_empty() {
+                let (lhs, rhs) = (|| {
+                    let mut current = current.into_iter();
+                    let mut acc = TokenStream::new();
+                    while let Some(tt) = current.next() {
+                        // Split on `=` only once to handle cases like `a = b = c`.
+                        if matches!(&tt, TokenTree::Punct(p) if p.as_char() == '=') {
+                            names.remove(acc.to_string().as_str());
+                            // Include the `=` itself to keep the handling below uniform.
+                            acc.extend([tt]);
+                            return (Some(acc), current.collect::<TokenStream>());
+                        }
+                        acc.extend([tt]);
+                    }
+                    (None, acc)
+                })();
+                args.extend(quote_spanned!(first_span => #lhs #adapter(&#rhs)));
+            }
+        };
+
+        let mut current = TokenStream::new();
+        for tt in input {
+            match &tt {
+                TokenTree::Punct(p) if p.as_char() == ',' => {
+                    flush(&mut args, &mut current);
+                    &mut args
+                }
+                _ => &mut current,
+            }
+            .extend([tt]);
+        }
+        flush(&mut args, &mut current);
+    }
+
+    for name in names {
+        let name = Ident::new(name, first_span);
+        args.extend(quote_spanned!(first_span => , #name = #adapter(&#name)));
+    }
+
+    quote_spanned!(first_span => ::core::format_args!(#args))
+}
diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
index fa847cf3a9b5..793f712dbf7c 100644
--- a/rust/macros/lib.rs
+++ b/rust/macros/lib.rs
@@ -15,6 +15,7 @@
 mod quote;
 mod concat_idents;
 mod export;
+mod fmt;
 mod helpers;
 mod kunit;
 mod module;
@@ -201,6 +202,24 @@ pub fn export(attr: TokenStream, ts: TokenStream) -> TokenStream {
     export::export(attr, ts)
 }
 
+/// Like [`core::format_args!`], but automatically wraps arguments in [`kernel::fmt::Adapter`].
+///
+/// This macro allows generating `fmt::Arguments` while ensuring that each argument is wrapped with
+/// `::kernel::fmt::Adapter`, which customizes formatting behavior for kernel logging.
+///
+/// Named arguments used in the format string (e.g. `{foo}`) are detected and resolved from local
+/// bindings. All positional and named arguments are automatically wrapped.
+///
+/// This macro is an implementation detail of other kernel logging macros like [`pr_info!`] and
+/// should not typically be used directly.
+///
+/// [`kernel::fmt::Adapter`]: ../kernel/fmt/struct.Adapter.html
+/// [`pr_info!`]: ../kernel/macro.pr_info.html
+#[proc_macro]
+pub fn fmt(input: TokenStream) -> TokenStream {
+    fmt::fmt(input)
+}
+
 /// Concatenate two identifiers.
 ///
 /// This is useful in macros that need to declare or reference items with names
diff --git a/rust/macros/quote.rs b/rust/macros/quote.rs
index acc140c18653..ddfc21577539 100644
--- a/rust/macros/quote.rs
+++ b/rust/macros/quote.rs
@@ -48,6 +48,7 @@ macro_rules! quote_spanned {
     ($span:expr => $($tt:tt)*) => {{
         let mut tokens = ::proc_macro::TokenStream::new();
         {
+            #[allow(unused_variables)]
             let span = $span;
             quote_spanned!(@proc tokens span $($tt)*);
         }
@@ -146,6 +147,12 @@ macro_rules! quote_spanned {
         )]);
         quote_spanned!(@proc $v $span $($tt)*);
     };
+    (@proc $v:ident $span:ident & $($tt:tt)*) => {
+        $v.extend([::proc_macro::TokenTree::Punct(
+            ::proc_macro::Punct::new('&', ::proc_macro::Spacing::Alone),
+        )]);
+        quote_spanned!(@proc $v $span $($tt)*);
+    };
     (@proc $v:ident $span:ident _ $($tt:tt)*) => {
         $v.extend([::proc_macro::TokenTree::Ident(
             ::proc_macro::Ident::new("_", $span),

-- 
2.50.0


