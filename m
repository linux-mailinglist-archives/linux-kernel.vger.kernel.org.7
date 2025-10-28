Return-Path: <linux-kernel+bounces-873609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CC2C14416
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E806E544553
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9307D30B526;
	Tue, 28 Oct 2025 10:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n+5owXJB"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F003090CD
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761648930; cv=none; b=OB9M810oKkgMIol1WlY8DEi8xzqEvSjlmj2s1jq7jxy6KbmK4YfKF7U26SG36STHMfQYDBUmo0vVFxubhQlP52Lmjb5XnVCTeiozJHxfSzeWfdY0wEVv5FdpXz2E3lBxQ9uEe5vqkxDx9klaGmkT7XVgwe/p0SuTLMQsgmm6lT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761648930; c=relaxed/simple;
	bh=u5cQmrhUMazV/NbgrGa0POvpnkdiyA3r9buDRqet4wA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fZCnyQy7BTkqIV/TPGabE6mn7yeTNOTyPdm+TJapgL9T4O+e2LRFAULYf84LAZAxmK5zqweEu6dnRKsgWyevaMSOCfV8QN5AS671+dux/I9zAUmIpqrP5YyHkE1iGKl/FxV7nyYSryYdE7r9MUMDIohLiK6LFLI2mnY8X9Ug+UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n+5owXJB; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-47111dc7c5dso34103325e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 03:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761648927; x=1762253727; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kA4eaFrdLr1JSkUKeDkNkT7+AEWbhQjt26vQGgnU0WU=;
        b=n+5owXJBrA6OBuR58/vANOK5DUWs5eqhheUaAUbxhoHlI06A0r6kazitHzh8HKVIv4
         Gaq9wc4apDpeE49kUj4OL5flb43Beqr6iGVvnwBQAb/fbvtLqsL1g6FbxAeGqHliRRz5
         2vQ6LTKJI6W8RfkShShThdSlCuHmIzngoyIdXv8f9TQBbqtyO6aKLqRC8+phOVxnZpU6
         g3GdPgigi5t74J0eHK4d7d03gF0Y2SqgHSq5187JAnuG0sIlsftSTZ5Y/WNssUjiJ06c
         U6pZu88JCI7thl6idwTBr6aEaPwy2oNKwhQSqsI6J45ikYz6xoBOTRP70gS+M650rjSC
         0zzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761648927; x=1762253727;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kA4eaFrdLr1JSkUKeDkNkT7+AEWbhQjt26vQGgnU0WU=;
        b=eh0PX5LBvKrYJTqlwj/5fxUBWX46XEPi9qHJuT+jk8jiFsHvlr7VAmNIwqZSxjXcgd
         dGe9VBLhHdPPOdwC3xiabeRyyhJFsPUzVCrfgMRGHCW6/lm6O/4angKAJVVbR6Ro71WZ
         p78VFAagty8wN8iipMf8LKpm7XnDbu75502AKSGsmBuiv9ENvUAFkHKR4b9drW1pubMw
         TdJKH4kBanoLhfIOvoPLwHgKZhkCkaBxT3erPAfuCY88dzS6sF+gVw5rafuGljDxafwQ
         tUE15vEta1bu0HKFy6iWsc3mD83OLVcZjLPeU6QTXVJqiKO4Ckl3/FT72A+8jzyF3ELf
         7AQg==
X-Forwarded-Encrypted: i=1; AJvYcCXKna/PzCVvGTnEVqX9r4gRuS6m8LgH5oqDwPrj751zJx3w80ngI7IcpvK8bVrytZ4nWN0WVwQkUTYfwVY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx65SAKsldBof5Y6QgNyAEFmJlGbJ38d1CXYt44lguuAjDtDkmW
	S4ysyPyr6Rw9dQOvin9+17hpQbcJ1olRiw/TwMV1YPVz0dNtWQ88NhsPLz8Phjvds+xhNFx6E8d
	sJ0PjQMFStDihS6s3EA==
X-Google-Smtp-Source: AGHT+IFRbJ1tH44lIpEv23gIpvmhBMuxiE+JbhC8TVzF6WmLYlq4uRK7OPBTmIpSxquYR3bw2fwC37MlLZWhza8=
X-Received: from wmmu18.prod.google.com ([2002:a05:600c:d2:b0:475:d8ac:bbb0])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5246:b0:46e:6339:79c5 with SMTP id 5b1f17b1804b1-4771812e415mr29064065e9.5.1761648927520;
 Tue, 28 Oct 2025 03:55:27 -0700 (PDT)
Date: Tue, 28 Oct 2025 10:55:15 +0000
In-Reply-To: <20251028-binder-bitmap-v3-0-32822d4b3207@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251028-binder-bitmap-v3-0-32822d4b3207@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1240; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=u5cQmrhUMazV/NbgrGa0POvpnkdiyA3r9buDRqet4wA=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpAKEb/ewdk1lpt9r1xeOREyfL4xflpbXO9tvCh
 oxRUEcrfsGJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaQChGwAKCRAEWL7uWMY5
 RmPfEACfpfOQOfGSTuquxnxa9aaTAoYP42qpAtVpDHCibufjxtFsccqhbnZ0HotxsAXILZqYHLN
 mvdg7QyxmXMFPed8pdiEZp3PnpCKNWMWHlWGl2mG02bwq3xxj3Z7lQru1D1Ik273TgBsKw/6Z7+
 R3Wv7Z67yLe8AtLMo+/GBz2oCm4JHasM/Gfj9Nec/N0/8Ay3eTed5Xv9EIdiS/WaPFrvDJQ26Rm
 pV2fcA4dWtI+J8Kr/wkAGB5baWqQ1D/hxKbp+0mC3DnNht7YLxhMf1pyN2hpjklzSOeXcuZGVhk
 btYbncIoeLeknvtsMG2aPml8ZsYt7WPC8qk8dC551ma7cIQ4/Pk7PVQ2Ikv6OgRaPz4Tdg9AhFv
 T3jloqyCq2qlhpw6pIMlvAeCuoCHjPrSdBo5AKfyhXQ+bWk6ITDspAO5zBFr39cpf04NKHV9Y8X
 nKWlkbAaIQmvoUrXsqcttKRbAJirN6KCVtPYdT/ARSWBAIQyXM5X/g3lp1eTMY4baZhns8kWos9
 zs6fXKSMS6RMSCgifnXqgm7m8I/XoX1kdAVh8srSxTAl4MiykIbpLVZZsUUylxjBprpQNug0z5D
 AWlrZ3wqaSk4kQJqjqtYLoxViFKm9fda2ydPVhDOjdd5v+eHGm0a73O5HXQ4aLYDemYGtwsCNz3 l25Y+iqrYTgIGwA==
X-Mailer: b4 0.14.2
Message-ID: <20251028-binder-bitmap-v3-2-32822d4b3207@google.com>
Subject: [PATCH v3 2/5] rust: bitmap: add BitmapVec::new_inline()
From: Alice Ryhl <aliceryhl@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Yury Norov <yury.norov@gmail.com>
Cc: "=?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, 
	Martijn Coenen <maco@android.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Christian Brauner <brauner@kernel.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Burak Emir <bqe@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

This constructor is useful when you just want to create a BitmapVec
without allocating but don't care how large it is.

Acked-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
Reviewed-by: Burak Emir <bqe@google.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/bitmap.rs | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
index 15fa23b45054b9272415fcc000e3e3b52c74d7c1..f385a539a90ba87a7b9f6d686e150e95e358bbef 100644
--- a/rust/kernel/bitmap.rs
+++ b/rust/kernel/bitmap.rs
@@ -232,6 +232,16 @@ impl BitmapVec {
     /// The maximum length that avoids allocating.
     pub const NO_ALLOC_MAX_LEN: usize = BITS_PER_LONG;
 
+    /// Construct a longest possible inline [`BitmapVec`].
+    #[inline]
+    pub fn new_inline() -> Self {
+        // INVARIANT: `nbits <= NO_ALLOC_MAX_LEN`, so an inline bitmap is the right repr.
+        BitmapVec {
+            repr: BitmapRepr { bitmap: 0 },
+            nbits: BitmapVec::NO_ALLOC_MAX_LEN,
+        }
+    }
+
     /// Constructs a new [`BitmapVec`].
     ///
     /// Fails with [`AllocError`] when the [`BitmapVec`] could not be allocated. This

-- 
2.51.1.838.g19442a804e-goog


