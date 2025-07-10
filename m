Return-Path: <linux-kernel+bounces-725946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AEA8B005CA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 16:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78D691C87ED2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 14:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9CB274664;
	Thu, 10 Jul 2025 14:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9nyL/0o"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CAB273D91;
	Thu, 10 Jul 2025 14:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752159224; cv=none; b=PpfqVGF9RoMf3n+k2rk0kE34wfpaNpClXhzSoQAKhGQUXvM2kw/7jvnA7huzRQJlYkfQgqIE84FjRQaYy6jFlsj4Nt4dCkC+NvvzNgeePSHDydLPxvQitSp6UZ3s//mfhuz7Eq3c+wbITAiqQtFz8naMx2PRhDm8EzWkzPbuExI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752159224; c=relaxed/simple;
	bh=chk1wwizZG1MPIiCNwD46/EZhbEvHPTiZmXZqpThA3c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X/RFVCl/6Jn2OH8jZDv90lYoNBFAQongb+heXkjGAkL5lyUr9VOjGqxi2Uwh8ZaVzJzNx6g2YfcSENv/PBT3phX+23jl41cyotll4euHyCr8SiHVRoXVFeHncIPQz2gkX4qmEXGe8DJaG8rGeFSz+XCOlGnfCyk8pcX1m4kU2vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d9nyL/0o; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6fd0a91ae98so7044696d6.1;
        Thu, 10 Jul 2025 07:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752159222; x=1752764022; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KPiSjh0N/D3OxLvptKuG8AXPpYOOl5hUxlwQvU9k874=;
        b=d9nyL/0o67qjsbIQCv26KIa/pVwu6cMEMzxdyozW5IwtrriI3ofhtgJifOODEPr+09
         c+eP/RXiUOn1IF1u2oeQd51vLH5ugxQVCK4u+TXqFFQb2K0Jl7OzG4GcBYTFw6ewUryo
         loGnBN/3L2zAWYos5fIeNVKZG1qM42qU0k318PXnP5ody5k6sO7uJ2abEse9iUtPhs4Y
         jjDCKPN5IguA9qAN2+Ed7DCDa9oVBKq81EnDZ1WEtZkxv+zAZb6AcQRZZ2LxSoO7LLrC
         2y1C7+6dmDiEUYoSusyy0cYSN4pNdNriFhXZ1O0s5Im4s133DHn+zP10pOHobU2ZDes1
         mNyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752159222; x=1752764022;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KPiSjh0N/D3OxLvptKuG8AXPpYOOl5hUxlwQvU9k874=;
        b=BL/caOkJ9Vql8IADcJEJk5St9TFh54Oy/alv+zPS8jg2ygFwqTomdMCLYb1QcNcHFu
         tpSY+FX9OjL2KT2jWKIVs91rRnFr7ky5f2lKX2Jj7iz3Vjs/sDeDtSQ2tVt0doiqqQK5
         CMP0j5+rBdGzG295O1FbvXTQYNBTIySI4Ox37wtLXzJ8xKASUa4SISJ4LMwxugt4OO4R
         Wtm2p5/ymKlWr2O1/GLo1dzhKukF0mSF/2QJjBZIsWC2gYpVbvMdNzpnCWxkEnyvifYH
         J/YcCjt6qpC0POYi7hLQXZTbIloW57Rm0mfGqR052ffzUjEcGJ2Ls0rpQWlS+HOfZ7W6
         rF3g==
X-Forwarded-Encrypted: i=1; AJvYcCXuQj8XQKLvrmY7TfbarqcwoH2cM6V99LVkFrFCU8Uvtc4gCCYFvi3dMouiuAFw+KERxqYVWYeJzP6/rNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YydgONvRyb/hMKtFXgc5UqWxm8cg8tOL5hZgyG5FO8jUWXHm3Xu
	FF8aucE6itGiCJ1+ADxUBmOpeQJV0eVTYw/sdfj41XbSXQFaRovArbQ0
X-Gm-Gg: ASbGncvt8r+csLpg5dPo2N8CI4CGg+3A8o2e59RS2kjuygeYUQzUCXKGtLDFKtfslLH
	n9OmlYcVa35egUe+HoakIcwJ0TusdXztHVPj7Yz53CDAtsz+0Hxy1bWefq/V4P/E3i9euR7LfYo
	VK1G7UX+m68cPJwFnn+zt91V74EyG0Dtj2+uKMsAkXgiRTCTG9agf5GiJgVTBBEjmly4MwzI+Cp
	hrQF/aHyz7sZMSG3UM1ntycj2iLaPH8BxJYOjKCRVHye5xpdku+jwf7UMyPWN9HLMGRvfUFO6Tl
	UXp1ICxB00p5KKsHwMSMXK01FK+kNVJ0JHpaoeagssqx+gVXjmaTsgzT4oOFIEorkkwD1qzZiYS
	zpQevqnuk3YHc3pWfk4jPhlTCFVAh6jr4uTTbIEBiGQsUhqqeIpyPIm9V6RhuEvE=
X-Google-Smtp-Source: AGHT+IHsA0S1uR5csIvV21f8twHmmLirD7wOsEentFwiH8SSVW3uMJxFn1Nggw92EpBPmaN7Ny/2yQ==
X-Received: by 2002:a05:6214:626:b0:704:78b9:d348 with SMTP id 6a1803df08f44-70497fa9858mr33508286d6.3.1752159221680;
        Thu, 10 Jul 2025 07:53:41 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([148.76.185.197])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-704979f49b0sm9138996d6.54.2025.07.10.07.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 07:53:41 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 10 Jul 2025 10:53:29 -0400
Subject: [PATCH v14 1/3] rust: macros: reduce collections in `quote!` macro
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-cstr-core-v14-1-ca7e0ca82c82@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1752159218; l=8684;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=chk1wwizZG1MPIiCNwD46/EZhbEvHPTiZmXZqpThA3c=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QK0PrCJ12TPOCRzT/VW6HMwwfVx80XeLE3F2pCMBLzFRXW5XoX4grak+cGiUVnhbxupMqhs0Gbj
 GPb0g7n1RYQw=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Remove a handful of unncessary intermediate vectors and token streams;
mainly the top-level stream can be directly extended with the notable
exception of groups.

Remove an unnecessary `#[allow(dead_code)]` added in commit dbd5058ba60c
("rust: make pin-init its own crate").

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/macros/quote.rs | 104 ++++++++++++++++++++++++---------------------------
 1 file changed, 49 insertions(+), 55 deletions(-)

diff --git a/rust/macros/quote.rs b/rust/macros/quote.rs
index 92cacc4067c9..acc140c18653 100644
--- a/rust/macros/quote.rs
+++ b/rust/macros/quote.rs
@@ -2,7 +2,6 @@
 
 use proc_macro::{TokenStream, TokenTree};
 
-#[allow(dead_code)]
 pub(crate) trait ToTokens {
     fn to_tokens(&self, tokens: &mut TokenStream);
 }
@@ -47,121 +46,116 @@ fn to_tokens(&self, tokens: &mut TokenStream) {
 /// `quote` crate but provides only just enough functionality needed by the current `macros` crate.
 macro_rules! quote_spanned {
     ($span:expr => $($tt:tt)*) => {{
-        let mut tokens: ::std::vec::Vec<::proc_macro::TokenTree>;
-        #[allow(clippy::vec_init_then_push)]
+        let mut tokens = ::proc_macro::TokenStream::new();
         {
-            tokens = ::std::vec::Vec::new();
             let span = $span;
             quote_spanned!(@proc tokens span $($tt)*);
         }
-        ::proc_macro::TokenStream::from_iter(tokens)
+        tokens
     }};
     (@proc $v:ident $span:ident) => {};
     (@proc $v:ident $span:ident #$id:ident $($tt:tt)*) => {
-        let mut ts = ::proc_macro::TokenStream::new();
-        $crate::quote::ToTokens::to_tokens(&$id, &mut ts);
-        $v.extend(ts);
+        $crate::quote::ToTokens::to_tokens(&$id, &mut $v);
         quote_spanned!(@proc $v $span $($tt)*);
     };
     (@proc $v:ident $span:ident #(#$id:ident)* $($tt:tt)*) => {
         for token in $id {
-            let mut ts = ::proc_macro::TokenStream::new();
-            $crate::quote::ToTokens::to_tokens(&token, &mut ts);
-            $v.extend(ts);
+            $crate::quote::ToTokens::to_tokens(&token, &mut $v);
         }
         quote_spanned!(@proc $v $span $($tt)*);
     };
     (@proc $v:ident $span:ident ( $($inner:tt)* ) $($tt:tt)*) => {
         #[allow(unused_mut)]
-        let mut tokens = ::std::vec::Vec::<::proc_macro::TokenTree>::new();
+        let mut tokens = ::proc_macro::TokenStream::new();
         quote_spanned!(@proc tokens $span $($inner)*);
-        $v.push(::proc_macro::TokenTree::Group(::proc_macro::Group::new(
+        $v.extend([::proc_macro::TokenTree::Group(::proc_macro::Group::new(
             ::proc_macro::Delimiter::Parenthesis,
-            ::proc_macro::TokenStream::from_iter(tokens)
-        )));
+            tokens,
+        ))]);
         quote_spanned!(@proc $v $span $($tt)*);
     };
     (@proc $v:ident $span:ident [ $($inner:tt)* ] $($tt:tt)*) => {
-        let mut tokens = ::std::vec::Vec::new();
+        let mut tokens = ::proc_macro::TokenStream::new();
         quote_spanned!(@proc tokens $span $($inner)*);
-        $v.push(::proc_macro::TokenTree::Group(::proc_macro::Group::new(
+        $v.extend([::proc_macro::TokenTree::Group(::proc_macro::Group::new(
             ::proc_macro::Delimiter::Bracket,
-            ::proc_macro::TokenStream::from_iter(tokens)
-        )));
+            tokens,
+        ))]);
         quote_spanned!(@proc $v $span $($tt)*);
     };
     (@proc $v:ident $span:ident { $($inner:tt)* } $($tt:tt)*) => {
-        let mut tokens = ::std::vec::Vec::new();
+        let mut tokens = ::proc_macro::TokenStream::new();
         quote_spanned!(@proc tokens $span $($inner)*);
-        $v.push(::proc_macro::TokenTree::Group(::proc_macro::Group::new(
+        $v.extend([::proc_macro::TokenTree::Group(::proc_macro::Group::new(
             ::proc_macro::Delimiter::Brace,
-            ::proc_macro::TokenStream::from_iter(tokens)
-        )));
+            tokens,
+        ))]);
         quote_spanned!(@proc $v $span $($tt)*);
     };
     (@proc $v:ident $span:ident :: $($tt:tt)*) => {
-        $v.push(::proc_macro::TokenTree::Punct(
-                ::proc_macro::Punct::new(':', ::proc_macro::Spacing::Joint)
-        ));
-        $v.push(::proc_macro::TokenTree::Punct(
-                ::proc_macro::Punct::new(':', ::proc_macro::Spacing::Alone)
-        ));
+        $v.extend([::proc_macro::Spacing::Joint, ::proc_macro::Spacing::Alone].map(|spacing| {
+            ::proc_macro::TokenTree::Punct(::proc_macro::Punct::new(':', spacing))
+        }));
         quote_spanned!(@proc $v $span $($tt)*);
     };
     (@proc $v:ident $span:ident : $($tt:tt)*) => {
-        $v.push(::proc_macro::TokenTree::Punct(
-                ::proc_macro::Punct::new(':', ::proc_macro::Spacing::Alone)
-        ));
+        $v.extend([::proc_macro::TokenTree::Punct(
+            ::proc_macro::Punct::new(':', ::proc_macro::Spacing::Alone),
+        )]);
         quote_spanned!(@proc $v $span $($tt)*);
     };
     (@proc $v:ident $span:ident , $($tt:tt)*) => {
-        $v.push(::proc_macro::TokenTree::Punct(
-                ::proc_macro::Punct::new(',', ::proc_macro::Spacing::Alone)
-        ));
+        $v.extend([::proc_macro::TokenTree::Punct(
+            ::proc_macro::Punct::new(',', ::proc_macro::Spacing::Alone),
+        )]);
         quote_spanned!(@proc $v $span $($tt)*);
     };
     (@proc $v:ident $span:ident @ $($tt:tt)*) => {
-        $v.push(::proc_macro::TokenTree::Punct(
-                ::proc_macro::Punct::new('@', ::proc_macro::Spacing::Alone)
-        ));
+        $v.extend([::proc_macro::TokenTree::Punct(
+            ::proc_macro::Punct::new('@', ::proc_macro::Spacing::Alone),
+        )]);
         quote_spanned!(@proc $v $span $($tt)*);
     };
     (@proc $v:ident $span:ident ! $($tt:tt)*) => {
-        $v.push(::proc_macro::TokenTree::Punct(
-                ::proc_macro::Punct::new('!', ::proc_macro::Spacing::Alone)
-        ));
+        $v.extend([::proc_macro::TokenTree::Punct(
+            ::proc_macro::Punct::new('!', ::proc_macro::Spacing::Alone),
+        )]);
         quote_spanned!(@proc $v $span $($tt)*);
     };
     (@proc $v:ident $span:ident ; $($tt:tt)*) => {
-        $v.push(::proc_macro::TokenTree::Punct(
-                ::proc_macro::Punct::new(';', ::proc_macro::Spacing::Alone)
-        ));
+        $v.extend([::proc_macro::TokenTree::Punct(
+            ::proc_macro::Punct::new(';', ::proc_macro::Spacing::Alone),
+        )]);
         quote_spanned!(@proc $v $span $($tt)*);
     };
     (@proc $v:ident $span:ident + $($tt:tt)*) => {
-        $v.push(::proc_macro::TokenTree::Punct(
-                ::proc_macro::Punct::new('+', ::proc_macro::Spacing::Alone)
-        ));
+        $v.extend([::proc_macro::TokenTree::Punct(
+            ::proc_macro::Punct::new('+', ::proc_macro::Spacing::Alone),
+        )]);
         quote_spanned!(@proc $v $span $($tt)*);
     };
     (@proc $v:ident $span:ident = $($tt:tt)*) => {
-        $v.push(::proc_macro::TokenTree::Punct(
-                ::proc_macro::Punct::new('=', ::proc_macro::Spacing::Alone)
-        ));
+        $v.extend([::proc_macro::TokenTree::Punct(
+            ::proc_macro::Punct::new('=', ::proc_macro::Spacing::Alone),
+        )]);
         quote_spanned!(@proc $v $span $($tt)*);
     };
     (@proc $v:ident $span:ident # $($tt:tt)*) => {
-        $v.push(::proc_macro::TokenTree::Punct(
-                ::proc_macro::Punct::new('#', ::proc_macro::Spacing::Alone)
-        ));
+        $v.extend([::proc_macro::TokenTree::Punct(
+            ::proc_macro::Punct::new('#', ::proc_macro::Spacing::Alone),
+        )]);
         quote_spanned!(@proc $v $span $($tt)*);
     };
     (@proc $v:ident $span:ident _ $($tt:tt)*) => {
-        $v.push(::proc_macro::TokenTree::Ident(::proc_macro::Ident::new("_", $span)));
+        $v.extend([::proc_macro::TokenTree::Ident(
+            ::proc_macro::Ident::new("_", $span),
+        )]);
         quote_spanned!(@proc $v $span $($tt)*);
     };
     (@proc $v:ident $span:ident $id:ident $($tt:tt)*) => {
-        $v.push(::proc_macro::TokenTree::Ident(::proc_macro::Ident::new(stringify!($id), $span)));
+        $v.extend([::proc_macro::TokenTree::Ident(
+            ::proc_macro::Ident::new(stringify!($id), $span),
+        )]);
         quote_spanned!(@proc $v $span $($tt)*);
     };
 }

-- 
2.50.0


