Return-Path: <linux-kernel+bounces-754430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 270EFB19438
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 16:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69E047A721A
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 14:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2386E2641EE;
	Sun,  3 Aug 2025 14:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CeiqM/Wz"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26193367;
	Sun,  3 Aug 2025 14:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754230898; cv=none; b=BK+MSRNigGFVl/Rg3reHlHKLnyS7YyP1DP0BO/Zaqq/Bn9J4LV835ufsma5tY3XOG8EjgtBrMo3QqMWuAsLVq3VD3M4zG6jpKCvvcmCZDQTZkL/2R6IDePmkMhw8xclObvH46z2QG2dyiDvMJMMc3OJsf3ZBwlJPeuq2L/NtXnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754230898; c=relaxed/simple;
	bh=w26Wr8Qt7YlWCv+uO1QqpfC4cUDgjOmEp19U/1ygDvA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y38M/aTfrhVVFOX2jOCxbazLEg4+8ljmLGrDndEMeZhdbDz9rb8HHLSe0KmSkTxC+wx0dTtQgbaJeYUm8UNab2VSob8CSU6FNsidbiK1MXn1clla0DKFs2D+2uHqVAVYofjERf4MbvncyNXeRoh3wkd9hIdiPAwxVFTEppT2ZtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CeiqM/Wz; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-76b8d289f73so2387497b3a.1;
        Sun, 03 Aug 2025 07:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754230896; x=1754835696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WqYDYr0tBuZpHy7d+0t7MzRWJjDlIyRDeWJHNv8j1g0=;
        b=CeiqM/WzGvQuvvJJNaaD5Hbxpnu9JYPDbxxxbd3eZte/G3VJ5iPeE0X6/LdlqO9s1M
         H2VPSuJz67+GKjJZ+QKtAaQjkwDRwykh0BfxJEZxQvtXZGgqN8Muhat/svEO72Esawgj
         RmNeNsZhWjdwHGPwLP8DnvtpfVl0LR6xM6Kip3Acr3vaI6LDSRT1YgBl7oHttopbugMV
         L5mv/tqEBl505Snw6Isfs/dGhDGNaHpEMNHGXa0Qv+5at2ocGpltTT+65Jq4JzBSYX9m
         mzB3Dck8b8tD8GXQ2KgQzJlnpSsXdhBC9QkCacMF5RPe7G/VAs+qhJMQ8k0g/Zg5ztrq
         YsUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754230896; x=1754835696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WqYDYr0tBuZpHy7d+0t7MzRWJjDlIyRDeWJHNv8j1g0=;
        b=BrOdP+mm0qWqwq4fz4H3g1cC8CvusJTSfTHkzYp2S6RoinVb8gWh6K0EXLVuLeby/p
         K3djHGd1Nu9sR19zTYYsxYlI7rabkmPfozQCifbovQXDCAkO6bBrhEiPMHRbptJVkct5
         Pie5t5kZJxpMr29yi3BwKQ4N9FC/IKMXQG+quOPAxt9NdUMwIiwnWZZtuZAfL3M6HaCs
         CtjXmOR3x1jMUSuO2//motKulMU5rTSod+TiTaWWFKeL+Y8D3iY/YVw1qsfAZkB2widj
         FWlnUtE5jNc1C16eqmRoHaChwuozq6W1mlCUBMvSf+1GlJeseinj0Vkdde4a/bYuHfXs
         IDrA==
X-Forwarded-Encrypted: i=1; AJvYcCVeC0TkqP7eCiCl9ez3bH1qfx9WpoZRSntkwBWMvcjVBIxC4FpbFI+btX/nxx6oFGPdpg+9RVLri9tE/24E6g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1f/B5MSrzcToo3soaNx8kuPumIt0K8voC7mKiUQf+C5jOy8Q8
	vCazJl5lqabcH9/3SA2XpwgWzp+lN7mx9gWazeuTr+9rbGYWLh3a0CaC
X-Gm-Gg: ASbGncvFo8arDWtZl3vf7inlyWp+SO8um0KSF6hlwEBbwoWHyb5Gz66uppefWeHtgC+
	jSFrFNVrEwIDS/712739QRY2M3Ao0zLENSSY3APQ1cc6mDOA2G09P9SFH+uS5em+Va5P7xwlu8s
	jN3b53dKzrrksJ8lAwSemFeQLD+fcl+yY1uzYTwfUNjuCC/zsQkhYSiAsK/oNSeQtrzxdD9blSF
	4Yx7Y0cr5NK9iwtC6I4gXMZq3trgyCPBgxESXOrQamse4n5hGad2wRvnMGhY1qhp0A87kxzFUlt
	AIqkvwPWNkKhTIfv6u5hIPcDNcFPmp53SZIWGrS1QF/MYz3AxBd9q4c2aD9kD0wdjPag7KpEZfa
	5ByPxZSa9ReG29Q9wluQcNLMGsmkIHUwaFg==
X-Google-Smtp-Source: AGHT+IEhGtCjS9xv0mGVzidB/Y10oRyRYka+R3Bd+zYx80YYBNp2XSW4Qe16PVuCeuUmU165+yjKfQ==
X-Received: by 2002:a05:6a00:3993:b0:74c:e253:6c83 with SMTP id d2e1a72fcca58-76bec314a45mr7544823b3a.6.1754230896381;
        Sun, 03 Aug 2025 07:21:36 -0700 (PDT)
Received: from localhost.localdomain ([104.28.217.213])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfd0279sm8431306b3a.98.2025.08.03.07.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 07:21:36 -0700 (PDT)
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
Subject: [PATCH 2/4] rust: macros: prefix variable `span` with underscore
Date: Sun,  3 Aug 2025 14:20:52 +0000
Message-Id: <797d4e9577c8cdd219cee879a5cb2f6c25006b32.1754228164.git.y.j3ms.n@gmail.com>
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

Prefix the variable `span` in `quote_spanned!()` macro with an
underscore to silence unused variable warnings.

The warning occurs when the macro is used without any uninterpolated
identifiers. For example:

    // Triggers a warning: "unused variable: `span`"
    quote! { #foo }

    // This is fine
    quote! { Some(#foo) }

There is no good reason to disallow such quoting patterns, so fix the
warning instead.

Signed-off-by: Jesung Yang <y.j3ms.n@gmail.com>
---
 rust/macros/quote.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/macros/quote.rs b/rust/macros/quote.rs
index 24764b04a07d..75367a93e0d3 100644
--- a/rust/macros/quote.rs
+++ b/rust/macros/quote.rs
@@ -57,8 +57,8 @@ macro_rules! quote_spanned {
         #[allow(clippy::vec_init_then_push)]
         {
             tokens = ::std::vec::Vec::new();
-            let span = $span;
-            quote_spanned!(@proc tokens span $($tt)*);
+            let _span = $span;
+            quote_spanned!(@proc tokens _span $($tt)*);
         }
         ::proc_macro::TokenStream::from_iter(tokens)
     }};
-- 
2.39.5


