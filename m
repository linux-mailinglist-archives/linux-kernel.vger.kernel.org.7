Return-Path: <linux-kernel+bounces-770212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA497B27883
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 07:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1BC8AA4C20
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 05:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6ECD2BE051;
	Fri, 15 Aug 2025 05:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejnVs7Jt"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1551D8DE1;
	Fri, 15 Aug 2025 05:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755235964; cv=none; b=ifQ8Od7Xoc7n8Puy94VH2wPXi/0/2HALC+LrAihpve5UDVdIaTfJS1zgljEinEUFkx2CNvXWbuOQXMmO9nJZwTMmbVvepebqK8Yx33iBQIUVq11U+GDDm7lk7KyQCMUsEa8NUL/T6FOS+DHp+xemsBgWElkZlxMW5DKW/RDmrt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755235964; c=relaxed/simple;
	bh=R434aX8WU3PIalfyTn2zvO3h3n8WODm9xszGH8ueP3U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dLX3Fk+zV72UnV2BeqD8JEg1T4sfxIPZ+lfyYOOTyMen6zO/aLUnDURl0by9daDEkMucbUjQRq05j8jwII9qMkLEACgl+AiIb9BCdEyoEzoaoIt2IkVJmN0lwqwZpuZUkSNtoo7b7R/PGj2eePGJ2m4liureksm13L1An3sFAHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ejnVs7Jt; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-76e2e8e54f8so1564318b3a.1;
        Thu, 14 Aug 2025 22:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755235962; x=1755840762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ItkcH2oOrHmGXKS1kIzQCIhIchwgBZlnH8595tjW2Y=;
        b=ejnVs7JtdPoa2ypeTlxISDsu//EKAh/0XXLtt+hO1JYAMBYfVa1f4dTjbSb81D9+PE
         5cGAWGrDqSjkVQ0Ad+INmAXOM8yh4aUxbwTDJPZWRHgBvkVQdrgNmRX0Volea5KOeDMz
         6tX6E3XqoX9QnqllfvDvsZE69bXRZ3vS8tdRunCyTAVJbFV8nxdjA5nA/C89gPDcsgPP
         7gCeTXCcUJSCwQWtAAP6UcNdZuYwcjGfda8yS/XUZfyLBvyh7hwkqPwlYmlKvo9jRfxN
         ikY+7/9/gDJmgYga+NFr21mJFNhISAU/TcL1ZD01nNDQSGRNe6Z0Q6xlz5XSBY8iC45d
         bOJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755235962; x=1755840762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ItkcH2oOrHmGXKS1kIzQCIhIchwgBZlnH8595tjW2Y=;
        b=IaOvAVXgCHWulNraoQAC+ZlWYvPBBDNL7bioa/S659SDjn4XDu3obj2bJV+niMza72
         NzaPRfBeGCDUM4cqkEj8ttFfQKnEnM4HCfHm6bPPlDfeM000qIOpyUONL6HPPSJ6dzug
         PzDNAULgYRyF4b2vl0TSYCm4GQmeX4FyLpdeYYNP7Xl/PXt6FJLskRt44HnUcoFM9IRA
         v4uKb6/6JpEEGlVq3bUTa7AHVJxbeBdTxQQ/aM+m9Zdc5gKEr6FZHgNb0KR7iVCdjufv
         QeI4AOTdiRZCMSCCEPl+xuQVhamdnSfv2IXIfjXQEom7Zu/95I32voFentOz7b/DD1eY
         fPmA==
X-Forwarded-Encrypted: i=1; AJvYcCVPn5TECwHp1OuvknyTWfRyZ1jKwDLbilKGuAz3HkVfwSRmnGrRCLykZFGLQxW6jWnPstQEs2NRERNoXHD1bA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/0vvLbBA52mHFc+VOvrZpXWUx+vZ7qvOSb8x+PzFXMMZ9ymjv
	dgcU8HbtW+Yr1sMAriUj03EhDvuIMOzwDzsUfP6t897CqHokw4DMLxCN
X-Gm-Gg: ASbGnctucd8G4n1IfbUvLM5c9RUoz1JnakqOV72HqmpAKwmiwYBAjqcU3KZ5HxJ9135
	YfzDcObqw11B4j6nmNR+MvsyjCbJPTYB2JcAddW7UOTKAPBQ1HLootnfaIWLJips1gBgLbmU/rW
	5GvVdEnfbx6GftyZV/1D02ZFRoyl/lE0139P/IiK2nzgWnr5SvjIXolR2U0sc0MbnV2KridvYki
	gL+BWf0FvC/dKfHzm+pcQtbulD+R5kni00v63in/xJkJtCP02G0eMGQU9kjK/edUDHvOHW9GRB2
	6JDZwUg7CWTqrcQW7KX5xUYb0fhb1onDhwJ0bHSAM6xk+yLhduOJHr1GwiBLgwNGc3ZfbRqS4qC
	icIBqN7RXhj9m2r9KQCV7M583CJ1kCwgt2dc7sZM676nwcMMgzqKM7Q==
X-Google-Smtp-Source: AGHT+IG6RpS5kBDo1uNCaTTuFsahy7gN7SvHmXtqbjLO2J8QO2AfC+R3FC64Kl85jAXYtBoEFXRCqg==
X-Received: by 2002:a05:6a00:92a4:b0:76b:fcac:f2ad with SMTP id d2e1a72fcca58-76e44847105mr1187592b3a.20.1755235961994;
        Thu, 14 Aug 2025 22:32:41 -0700 (PDT)
Received: from localhost.localdomain ([112.149.32.52])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e4556692bsm335234b3a.61.2025.08.14.22.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 22:32:41 -0700 (PDT)
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
Subject: [PATCH v2 3/5] rust: macros: prefix variable `span` with underscore
Date: Fri, 15 Aug 2025 05:32:13 +0000
Message-Id: <1455d8540acc62ad3acc1dd8ead71b1ad38935da.1755235180.git.y.j3ms.n@gmail.com>
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

Tested-by: Alexandre Courbot <acourbot@nvidia.com>
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


