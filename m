Return-Path: <linux-kernel+bounces-770211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEADCB2787C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 07:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D97E5A602A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 05:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E462BDC35;
	Fri, 15 Aug 2025 05:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2VxM+FZ"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B411D8DE1;
	Fri, 15 Aug 2025 05:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755235959; cv=none; b=AtkPfGevXexRZSMxfE3PN6D3bY69Ri/3Z3qI5yJHWlB8lkn/4G9JY0SauOHLuZeBS3jIgKdQTU6rnU6h0uYAsrHHvIhRXHZO2+mQqe/V96QKd9UMeWCeSRMCYOxHj5jdp22InFf9XOInE8z5BY/NYyWivfdjyoLl1UMIAZa4Z0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755235959; c=relaxed/simple;
	bh=Y+Yfz9Dw4Ufpsqr/U4oC6W7Qc4yAJ1hU21nEBVZaTU8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UubMR6YF3Dk/jNRbGM02qYkwJI7dq86O7iyDzsQ/b7D8zuHhkERb+DUZQLGr5Rapxk1KKEv81coQAkZ5eY3Vx3m9dEQlT3XhyzX5WS739J1YqiwsiG906V38eJP7FP+QVsTtBfBRglK8bA2zyCDVWPKhRGovstifviVDifjnFCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a2VxM+FZ; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-76e2ebe86ecso2026417b3a.3;
        Thu, 14 Aug 2025 22:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755235957; x=1755840757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QXSg086tVDmosf88eO3jx6G+rWDU/dGxOYa3gmyNHdQ=;
        b=a2VxM+FZTY5BtE5TwAlV6QXHd2FkLLYte54X9aNQ3/fce7VH62nhbZciQlm/+7FD45
         a6uJwXBZQ0BY3NhUWfem2xB+bU4vJjbn353LjsMlCTK5YrvQaWsauht+QR+eXYKUCtX2
         fKPVOdP5OspoTn0uFYkqeVeJvkrSdiSwYwo8ewVHh+byEZSvomS8jQwrtbfIt2hUguGh
         VUF6QRMEpJiJtgR8mqty1G+K7cNtd/ftbFjtHIJXQt2RwTAqEBdSjq3Okx3KP25SGZ0K
         bv2tLR8eee3joW1C9vYTkENgBN/lrRl9PJ86WY6N1AaySjnDQoz8ZvYYTLIIdc/fnALc
         D64w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755235957; x=1755840757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QXSg086tVDmosf88eO3jx6G+rWDU/dGxOYa3gmyNHdQ=;
        b=vuVPWhn2PpJdECEc4lzwZJR1C7iyMOIJiGcb98OKgWTEjOtsuUqq/uYdQS3lxOWLUq
         XCLac+XdogoYiHHe9T8JEBTd8bJDcAOvRPEtXmBa1KrY9IuNzWnvwZshonq+DmcUoMQc
         ij+kDjBd+y1OPG257p/FAhZOC+tkpVEu1RCfsRaEVhgiOj9QOIlcic/PLXzx6GMzzG4I
         MflFa8NoGKaQs9lWB/Ez0IxqIQUU9MgNUEqrM9PkVMARyGULj7UZ8o60PBh//naghPhX
         JK8x32evurEDoNyGtte1rmjt3dC0SsqkNVGdNUK3rQ/hEHT0RufUhRLotmfnibfmmZ4S
         RE+w==
X-Forwarded-Encrypted: i=1; AJvYcCWMYkRbTijapfQJVvWmTQnBngoA7V2Agfias+HHWGG6TmH8BZjNXNw0FfCwgyVBi12u6sJLNFXzpG7+kzIOsw==@vger.kernel.org
X-Gm-Message-State: AOJu0YznhZR+gA/Up9dh2BpQJVmerDkzL3+sQOanRYxQ6QDGpp0e4BKJ
	WaTT9pzNXVEih/2Du2g25jpRpS79IvGnpm8aUcq1P5wS83s83H8w8pUf
X-Gm-Gg: ASbGncta65Q6nNy+0WfPBPyJ41O5iUl4P2wuTCvuYbrEbZ1szXKh6vQTWXnOQW+bfKh
	4khwKWe350DxUlbBhsolCY9mUoSnxHY7h0Rbq9Iw2gcGdGbnrM/I2yGcT3SgZViDzGBPidCIymi
	PxZLq7dwWtHBKJsyqCjNi+HFcISbDEhbobgwgV4N2AcWc4vzxXmsN05CbOjUWckBppUxKjSGBfe
	gjvyAC96B6IAwDN+pWBZCVnbvKwukP7xuVl/6VSwUA2nNtzqwoo9G49oUWRR1NM7OuDNAXO7nNU
	wWaAA98eaQjkDDTXW7F01yRBEeIcOvO5et4k7Co2YNFosc9ELODlBggmpeOadPAWX8/NjgyXWoz
	4GQtetWxZ9shI2WTIkGcJF76WLeOrh2AKJhw2Pwabb9c=
X-Google-Smtp-Source: AGHT+IG4HU8MP0xJ+330waF1yTeFRAjq/5O+h8g/Lloz/jm6OtLbcslz6UUMOu+0mWZdRzPENl618A==
X-Received: by 2002:a05:6a00:14c8:b0:76b:42e5:fa84 with SMTP id d2e1a72fcca58-76e446ee0afmr1193988b3a.7.1755235956849;
        Thu, 14 Aug 2025 22:32:36 -0700 (PDT)
Received: from localhost.localdomain ([112.149.32.52])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e4556692bsm335234b3a.61.2025.08.14.22.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 22:32:36 -0700 (PDT)
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
Subject: [PATCH v2 2/5] rust: macros: extend custom `quote!()` macro
Date: Fri, 15 Aug 2025 05:32:12 +0000
Message-Id: <948a28f26a0e9924d82eb1d8d377e3ddc7335b24.1755235180.git.y.j3ms.n@gmail.com>
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

Extend the `quote_spanned!()` macro to support additional punctuation
tokens: `->`, `<`, `>`, and `==`. This symbols are commonly needed when
dealing with functions, generic bounds, and equality comparisons.

Tested-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Jesung Yang <y.j3ms.n@gmail.com>
---
 rust/macros/quote.rs | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/rust/macros/quote.rs b/rust/macros/quote.rs
index 8a89f0b1e785..24764b04a07d 100644
--- a/rust/macros/quote.rs
+++ b/rust/macros/quote.rs
@@ -150,6 +150,36 @@ macro_rules! quote_spanned {
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


