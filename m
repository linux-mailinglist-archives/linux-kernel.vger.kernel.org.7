Return-Path: <linux-kernel+bounces-754429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28859B19437
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 16:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 320101736EC
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 14:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7B926560B;
	Sun,  3 Aug 2025 14:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJI2MLLz"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D91367;
	Sun,  3 Aug 2025 14:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754230892; cv=none; b=f6mTp4hWw/PjE+x9z/mFOvvSV8xqKIaGcAN7AKC7wzul9wSjowTfQpW3E/LAcXp1S7FauiJtjMUFwQalLCYXJUYihF9HlRw6DrOPOmy1+HXoZ4WzyI45QRCYFJuPqAKwU92f04fmczAh6UUU89+LRkxKOMnwkHO0SxEZhF+Spuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754230892; c=relaxed/simple;
	bh=uOoEHbQIP4eH31so4WafM++NDXrOm/ao6tLqTeppibk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tTE4kfpAO2beAp/4qYJiWi69fpIPgqP++Tj5DzupLCTLzMGoO/8ggdXMMJIE1Gj3YK5ovBB651PzQzIqCKKEKon6hFMiGP/Xmjb8H85fqqqAp/mSmZK56QFIG/igcW82bGs71o1SIRIBjpT2AfTILlyc5l6sqLM9o4GQlbopYUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GJI2MLLz; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-76bc68cc9e4so2934877b3a.2;
        Sun, 03 Aug 2025 07:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754230890; x=1754835690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=114e6dFe36rXGszuWHRDJN4O+b6P/WGKkf7Q+pRcpDg=;
        b=GJI2MLLzgD0rblgcWCxoargqbnYpeX76nTuM22BH4vuhQ7txULN1vIOiU/2grH35f2
         7pfqmGz4Zgu4tXdcZ4mFQKCUoBxTjP/fQDf8lwfK9Z7Lcm53VJXLx+X8LbhsPfJMRO4U
         55W0zu8vszpMOzjz9OnFUczJnnlUEDjer0QHT2uRZkauSppc5kts3WdYonc6Gy13eLhu
         Rmtgje8lnimPqs7Tt4mDL8QU4/vGz2Opr8wpoaulUIiiH+w5V5Ntdzm/MaFvvdFMrGth
         PoRdp/EFLinDpOpUD1PqADao/fVYYdWaA2FYaeQKrbKdYjgaHflBRIen65O0rK200Qtc
         m9Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754230890; x=1754835690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=114e6dFe36rXGszuWHRDJN4O+b6P/WGKkf7Q+pRcpDg=;
        b=Rs7LTanJFlTXeRDU/GHzhxDrwMCGopnYqrjmDVt6Lo6cajW6gYDngbLM9m6x57bQNa
         2ZAe5kwzKa0w2xf89S29m1+DRq49Ek+7PwK3Q6Zm96lONV5TgFGJSE15lU+JNtC4OcgB
         uFgilCmkvA5gqOssyDcKWXaPoWjq1/olmCw9VWDFemh8uZyIYt3nmItMHI/BQAzFkZ/h
         /eOYr735GE/rrfouk5wjiDOBvjn3Upy/q4+cBlLbWowSJ1tafLVK3oo8eY+iOaWUEmml
         MgF6fy7VHRmyIFZIXDRp8mq0fjZV1Y5aWRRJnpqfsvxVKRnMPO1ASP/nwkJDGiNqWMtV
         a2CA==
X-Forwarded-Encrypted: i=1; AJvYcCXIZzyn8r/yItOAavRtz0LNNeniahx/8m3M1fSo/A5Kz5w/AvspXMNTz92ajeQInA2vxYk5P/Yhb5fhaZp9ig==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi4NRqz4GFhQieI/EMCdlgHRdS2QUwI3o+jdPf122enQk3e180
	KpbMMP5Aojn0PbKGO5/rza8VdOVFYPxkOiKCqyva9E/8qrduhVWsIPOREc3DJweClFU=
X-Gm-Gg: ASbGncuOk+hEm/q02Y8e8CtAdV1JGLPvHucfQCqPCzD/oR/nCbGAmyEYi9LzQwwIL42
	5N+odpryPPteM4PJwJnMvZYcRe83ANvhK/uTRXKp5bKVS3xbqYONxlbAB+DlPriQ3HrqCSWTT/E
	H5V10YyM7nwKGWkQCCtmJ6Df5n86+wU56eWbAIDrOjL9QjAWmnOe+7zuLPqCvwSdEJY5W5Ootsj
	t3Mh4lb1fdhJ6+p7y+oGoUxvdP036oFnz4GxdhiH9PZe4FTC53GD7q50CvHpaS/aCfPsSOevqvK
	s6qweYmSqDJJ9MtQQ8GEsyR9EusA++75js7lUsWroW3g/ZKbv5C1yCrEHPQz0w1GRJnSK+0OhRD
	C6rBaIa2Naz1QWX9WqorJxc3++fXvTPPdZw==
X-Google-Smtp-Source: AGHT+IHKX7auywt4u3zIKgU2fIOKGxq02XNCOJ7Xi4MWV+Fhm3m6UNnqEL+P/ENvgfCJ4sKMDzFRxg==
X-Received: by 2002:a05:6a00:1884:b0:76b:49af:eceb with SMTP id d2e1a72fcca58-76bec4d1ef6mr6004641b3a.20.1754230890481;
        Sun, 03 Aug 2025 07:21:30 -0700 (PDT)
Received: from localhost.localdomain ([104.28.217.213])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfd0279sm8431306b3a.98.2025.08.03.07.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 07:21:30 -0700 (PDT)
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
Subject: [PATCH 1/4] rust: macros: extend custom `quote!()` macro
Date: Sun,  3 Aug 2025 14:20:51 +0000
Message-Id: <c9637a605dd718ce25311c736d208ac9ecff18ad.1754228164.git.y.j3ms.n@gmail.com>
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

Implement the `ToTokens` trait for `&T` where `T` implements `ToTokens`.
This allows users to use the `quote!()` macro with references directly,
avoiding the need to clone values.

Extend the `quote_spanned!()` macro to support additional punctuation
tokens: `->`, `<`, `>`, and `==`. This symbols are commonly needed when
dealing with functions, generic bounds, and equality comparisons.

Signed-off-by: Jesung Yang <y.j3ms.n@gmail.com>
---
 rust/macros/quote.rs | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/rust/macros/quote.rs b/rust/macros/quote.rs
index 92cacc4067c9..24764b04a07d 100644
--- a/rust/macros/quote.rs
+++ b/rust/macros/quote.rs
@@ -7,6 +7,12 @@ pub(crate) trait ToTokens {
     fn to_tokens(&self, tokens: &mut TokenStream);
 }
 
+impl<T: ToTokens> ToTokens for &T {
+    fn to_tokens(&self, tokens: &mut TokenStream) {
+        (*self).to_tokens(tokens);
+    }
+}
+
 impl<T: ToTokens> ToTokens for Option<T> {
     fn to_tokens(&self, tokens: &mut TokenStream) {
         if let Some(v) = self {
@@ -144,6 +150,36 @@ macro_rules! quote_spanned {
         ));
         quote_spanned!(@proc $v $span $($tt)*);
     };
+    (@proc $v:ident $span:ident -> $($tt:tt)*) => {
+        $v.push(::proc_macro::TokenTree::Punct(
+                ::proc_macro::Punct::new('-', ::proc_macro::Spacing::Joint)
+        ));
+        $v.push(::proc_macro::TokenTree::Punct(
+                ::proc_macro::Punct::new('>', ::proc_macro::Spacing::Alone)
+        ));
+        quote_spanned!(@proc $v $span $($tt)*);
+    };
+    (@proc $v:ident $span:ident < $($tt:tt)*) => {
+        $v.push(::proc_macro::TokenTree::Punct(
+                ::proc_macro::Punct::new('<', ::proc_macro::Spacing::Alone)
+        ));
+        quote_spanned!(@proc $v $span $($tt)*);
+    };
+    (@proc $v:ident $span:ident > $($tt:tt)*) => {
+        $v.push(::proc_macro::TokenTree::Punct(
+                ::proc_macro::Punct::new('>', ::proc_macro::Spacing::Alone)
+        ));
+        quote_spanned!(@proc $v $span $($tt)*);
+    };
+    (@proc $v:ident $span:ident == $($tt:tt)*) => {
+        $v.push(::proc_macro::TokenTree::Punct(
+                ::proc_macro::Punct::new('=', ::proc_macro::Spacing::Joint)
+        ));
+        $v.push(::proc_macro::TokenTree::Punct(
+                ::proc_macro::Punct::new('=', ::proc_macro::Spacing::Alone)
+        ));
+        quote_spanned!(@proc $v $span $($tt)*);
+    };
     (@proc $v:ident $span:ident = $($tt:tt)*) => {
         $v.push(::proc_macro::TokenTree::Punct(
                 ::proc_macro::Punct::new('=', ::proc_macro::Spacing::Alone)
-- 
2.39.5


