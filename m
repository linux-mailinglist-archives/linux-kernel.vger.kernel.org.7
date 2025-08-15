Return-Path: <linux-kernel+bounces-770210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 393C4B2787B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 07:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34EDD5A49CB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 05:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4781D29E0F7;
	Fri, 15 Aug 2025 05:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gIe3Q+rS"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560D81D8DE1;
	Fri, 15 Aug 2025 05:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755235953; cv=none; b=c+rMDDIqQaT3waOhsmrL3rmqNerv69RQ1arFjj0eOuXh8BMZEe8sGHMMKbsX7L3iYpIN6GlUyS+7SumNmT6ypKitNwmlwjgmK+13OsGuYq40QImOEBw+ZLdveh5uDo2y/mJdzICsryURVAO3YUMg3v4tL/1Es4B3mIG6atPotVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755235953; c=relaxed/simple;
	bh=ObcRfBzSktAO/7XMRemg2S+7QI34iJ9KLPzc/3sgmxo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OV4BgOzvNb7KaGK4Mf1FFI6qWdTTMoH/Q4lK5f6E1zJVwZA44Qbe0yRhfu5ZE/5LLDRXR/V4YHK//4PplawEdZsUaoiFSMBwC7FhFzhy+xUCUPLOm8tQKpUq+6w8CE96cUnnLZMZXQGRnvodGIpbvg0Ar/XI5LcD+AY6pksrHcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gIe3Q+rS; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-76e2e60433eso1356869b3a.0;
        Thu, 14 Aug 2025 22:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755235951; x=1755840751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4lSopcLI3dVeo/3c4/pQ0iCsVLhFvEVu0yP3LOOzHlY=;
        b=gIe3Q+rS8fq3TYCoYH8gzFzDbnmpk4/mvPZViUYMWvgUd0FA0aRmpOPLQjUk2AW3k3
         DtIFdc4mtmQGKh8bUJb4IDeFDLSyMVEkytWaAx2RzJZfAiLYno9rl9hWxfebAvgYMYbW
         Ce7tgSzencEVbO6DGKrviyV6DCDrWhX77clgnssWXlSLcMTPMsUr8FH9ZaLy6yjqOO9N
         eFSxHsinO+lmO9H4xvgvPI2ozmbA7hKcqyIC0vy/isaG5wMjk0PzI/p9lqzG2yhsS7nI
         MDfCkGMChXlHdncjUYa5+6bVVIZK3lpGnRJ6WUnxRQDglkShLrCkCF10td7wD64oYhbU
         IipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755235951; x=1755840751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4lSopcLI3dVeo/3c4/pQ0iCsVLhFvEVu0yP3LOOzHlY=;
        b=l5gvdOJGKw9MCByuPEITvoH3yB77sBtISOpCgEDv+zPOYRWxgvzMnVw03nhPMxSbKt
         QOm+7i0HnRsjzPkbx5XEF5xfx/mZ6jqhFOxaAv92NKfR/sa1vbiuyHv2k1U5Kj1+22Wo
         Sh+kW70bl7NYW9QpDbduw4ewGc2P4qoe06vDFbJk5XxlO9YndJADvALb0bCqw/rxYF+k
         N+a+6RjYFj5t1hNnS8nYHJ15X2Jv0AB/V9/iyq1p8IPKOO+hQOhSEHIJ/oWCX21irM6B
         0V2eluRrZIzImjbLHC+U7teu9/6uj4oUDVrS9mC4VGyFwJwdoaQimiaB7B9XBby2uSud
         gy0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUOw7ewMr7m9r3/kwHsv28P2QlFQX0RbQUaJw85PpmY8Q7tW2/H/NLlkhPF8iPlMyH07ievzdM01iIF2/9Cjg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1WQng9R+mIRzs9LQMkbFdIuHmpG4wRjI9gZNisiuZq9vTdSjw
	Ls03hvq6IReXB7UgqDcg6/Bcx2OwWEqzhkQj5+UreB+qWvoRQEXDs6rL
X-Gm-Gg: ASbGnctHwTDjbPdnxWJ2Vr0Su8PX0rhMdVo/7fGvDIy0LAeP/VQ+96WwiUSWEPNKLJc
	FT8+4Asa01VPjWYIhZRMpRsuP1nwPDB5gN4DAEBTS5PhRbK0mcF1Jj083TFT3jcRz6u5wgnTniu
	tlRawnst4onwUYO/WIYjTQNkve03Abzugf2gvqMkrswUX+lWQ3RLY0r+z7s+bpWs77uU3c1KlUv
	KIkOQPH8PAWg1Lb6u3TDMGcITIHmBERODiVqClTVvvw3pbykgL+9VshBFPEM/NfQkUcfI2Cx5vL
	3ALiddU0POLVfn0r83pVy8ydHX9nUJ2siP5uj4T15CYvVr68drakW73Ujseq92wj0T5NDYmQzmw
	0haGyF1pkxNoooqGAA7jF30Z+Q6riCW6O+Emqemo1Bm8=
X-Google-Smtp-Source: AGHT+IEnEgL31QptJeXRJQyeWlFiXftFFWkzI6byVkMOjxMkpQiiFpcuDy0n02liiVDRtTpWNELp8w==
X-Received: by 2002:a05:6a00:180e:b0:748:e38d:fecc with SMTP id d2e1a72fcca58-76e44838c78mr1004327b3a.22.1755235951434;
        Thu, 14 Aug 2025 22:32:31 -0700 (PDT)
Received: from localhost.localdomain ([112.149.32.52])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e4556692bsm335234b3a.61.2025.08.14.22.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 22:32:31 -0700 (PDT)
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
Subject: [PATCH v2 1/5] rust: macros: allow conversion from `&T` to `TokenStream`
Date: Fri, 15 Aug 2025 05:32:11 +0000
Message-Id: <e349e0146bb4085b04245253e5e17c6275e14e31.1755235180.git.y.j3ms.n@gmail.com>
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

Implement the `ToTokens` trait for `&T` where `T` implements `ToTokens`.
This allows users to use the `quote!()` macro with references directly,
avoiding the need to clone values.

Tested-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Jesung Yang <y.j3ms.n@gmail.com>
---
 rust/macros/quote.rs | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/rust/macros/quote.rs b/rust/macros/quote.rs
index 92cacc4067c9..8a89f0b1e785 100644
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
-- 
2.39.5


