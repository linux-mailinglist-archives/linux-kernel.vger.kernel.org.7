Return-Path: <linux-kernel+bounces-742433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8ADB0F1A0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 13:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B6BC9605D6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 11:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E192E54C4;
	Wed, 23 Jul 2025 11:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0aVAwJ+R"
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B62226A0D5
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 11:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753271392; cv=none; b=ud8iqF+8Am3A2cfaSED8miwFwWk4j7+S0TM37I2/dgABfOtjwd27CigujHTVv88GFQ0xThFUG8bTO11OVK4Q1Zr8OpeNxJvCVTUz+ke8GJqNWai468wz9vRZ4JFCyyIVrAGqr5a2auKgjkLzb46uD41V2GpQz/obpMoUhtZYhKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753271392; c=relaxed/simple;
	bh=uSIzTh2B9rBYN6WZod8iksXQFVhHUXx/CncWZE2dFG0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EPwJ5c07RFWuqiYtD5H/opra+nSdp8ujQ2GXH2b7dBefqhJIHjwuEeVEUtZeD3afutN8sBx6jdVVefpYt+FPbvdlc8tWWG7526xr6yClo1wrd3YlE9g4nGzSS493CpVyqDp77KqArhZDfBaCxuO/MfN11DkmI3Tvw1nW90/nRr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0aVAwJ+R; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-ae6f9b15604so478736466b.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 04:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753271389; x=1753876189; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HXd/qCB8VS41ci4FOiH8r3Fnz/alprHme1ZlecJv9so=;
        b=0aVAwJ+RymH3j6T6eyPOVc/0uLmg02afLIROxrgZ9ad8T2WBchknxY20ifVDPhI8Un
         V68HiD8jjJyp1XShMSHqqVBMzflaleA7lZ/uQo0anBIhnHlKlsirWI8Te5SWiDcMH1s8
         ixVtqC5BMwe+NohAml9kQxaHaiPHwvFkAVmDrCkVwN0sMRnOHXnoLT+hUWEMpBdkP8Eh
         G6NtHBEe4wS1/RyaeL/nKn9oRuzXd8OAcaDAc1R35GLJZbLZs0rCzf9j9XlP4HSj+4+e
         Wxo35hAfLH2lPPpGGfFr7fraHCpHANvcpMCrwAZdMcPfbaByzaLTPJOTABdzaART5glH
         23+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753271389; x=1753876189;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HXd/qCB8VS41ci4FOiH8r3Fnz/alprHme1ZlecJv9so=;
        b=XMJFpZtdrBRBurQC8xmBh3xtE/6NnG+qTggKJxg8q551Lt3G5bjTkMEX4ECUHs/fIx
         f1VUs4SzU8tCyB1fq6tUciPSMztLfJphCYFqJQscj1v9toXhjYDfkyJtWwpKDwlo74OM
         zlS5RB4l8mo2rhr9bCul+MiLVPCxVDSLkvjMgZaDfA/VaBwQjPjVvfyeGJZSNLt4vXY+
         7NZ46leflKs6H6k6SCxEXrdgKI9cU0jQnUw9NOhGU//MZ9+99KkFS6r7JwC4ryENTfD9
         xBpZdXXQRRMCuMLb5EM2X7MJ0jGjL9oBdrVeEN5QSvQJLL3dXYEw1lcDFsgHCR90yUjc
         Rbtg==
X-Forwarded-Encrypted: i=1; AJvYcCVitH/4s8Vx80eh2tFTlmB60txw6MAvyDPpK+szQ7d0vuiOjunwBSPRHxx8VK2nTlpI2kbN9q70amVE5k4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF6MtjHyYBh+KiJEUz7kh9sOQYndClfIOPb/OeKSEmvCtQOGEZ
	+7Li4Ru9hVI9gxj+cof61y7kXWYVDFOgOV0JektRWyDK0hOSmbOjVrEl6nkz3XYcEhPUaIkB0xC
	ai6nvW1xVdumb8koEgg==
X-Google-Smtp-Source: AGHT+IFtQ7TcGqfEKPMNSLFNbKS+z9hdY4P7P4/3Czm5sGi200J4k5yBunHeQD1BP7KEARfacjCrGUGRKD0DDvM=
X-Received: from ejcvu11.prod.google.com ([2002:a17:907:a64b:b0:ae3:6cfa:d4e])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:3d4e:b0:aec:f8bb:abeb with SMTP id a640c23a62f3a-af2f8e514c7mr265695466b.42.1753271389379;
 Wed, 23 Jul 2025 04:49:49 -0700 (PDT)
Date: Wed, 23 Jul 2025 11:49:33 +0000
In-Reply-To: <20250723-lock-class-key-cleanup-v1-0-85fa506b8ca4@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250723-lock-class-key-cleanup-v1-0-85fa506b8ca4@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2485; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=uSIzTh2B9rBYN6WZod8iksXQFVhHUXx/CncWZE2dFG0=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBogMxadMiaNob8bqYbU1vQHmR5HUyBFbqd6r/MB
 tuSfDrzu/SJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaIDMWgAKCRAEWL7uWMY5
 RuLCD/9t5cui5Y7HFtTLMbhmJxO8JDoxn3FyCGHdSYAA+dCeH2N7GxBIj3WnaA5w9h1Mywng4Sm
 bTetWFniGPqDSMManJjEVNzdmZVkCvkyB/QnlHVTzsxA338nX6CYOBalAaqRxr13TifH4+XU5UR
 nWy0bcKHwNtQiBcveFS56vYLFU6qwYRE7KSGfxG9ZG1L2yjqA+xs+quGUNXFb7pgOnTN3c5n3Yf
 Q2nwQsaq6qjQQJd1trH4uzv1YFcdNVwmpsK5isM8wkz7nYe6wFVRliiY0t1q30054YuXgI7Ky6b
 qWW5/vvZWkZyNV7LA6crMjaig3ggX7MTgxNdtC3GhexACs14/974WCk/xnh59H8MQGiLS2iB2Yv
 dcVdjH2iTzJSq3UxPXeOwdcyi/TdtVcEzTrtui19Ne370am23ZefPbfipOmZ8U0lLy7dyK6QiCG
 gGem3vpiVBhEmHhRIjZpMSUOvmATnIkTR5BdhfGTUt9kxngmThM50FcILwc7u2D25PF8cde0o/+
 Y4DkO84SNvryiDRXpXUQ7FewMF+1EVYhLWdykLWZG0eL9Pl4TWWwAUGgUwF/ahrvRUiqWWD1IeY
 uNRuvFDlm6DQnz861k5UL0NkuFhtBPzjBE/j7u6F9QY4iHyIzwDezQ+HmmwM7wid200Ok01HjCT Iotm2yN7tSbC/EQ==
X-Mailer: b4 0.14.2
Message-ID: <20250723-lock-class-key-cleanup-v1-1-85fa506b8ca4@google.com>
Subject: [PATCH 1/2] rust: sync: refactor static_lock_class!() macro
From: Alice Ryhl <aliceryhl@google.com>
To: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>
Cc: Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

By introducing a new_static() constructor, the macro does not need to go
through MaybeUninit::uninit().assume_init(), which is a pattern that is
best avoided when possible.

That the destructor must never run is a sufficient safety requirement
for new_static() because to actually use it you must also pin it.
This implies that the memory location remains valid forever, which is
what is needed when using a statically allocated lock class key.

Suggested-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/sync.rs | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index 00f9b558a3ade19e442b32b46d05885b67e1d830..9545bedf47b67976ab8c22d8368991cf1f382e42 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -39,6 +39,20 @@ pub struct LockClassKey {
 unsafe impl Sync for LockClassKey {}
 
 impl LockClassKey {
+    /// Initializes a statically allocated lock class key.
+    ///
+    /// This is usually used indirectly through the [`static_lock_class!`] macro.
+    ///
+    /// # Safety
+    ///
+    /// The destructor must never run on the returned `LockClassKey`.
+    #[doc(hidden)]
+    pub const unsafe fn new_static() -> Self {
+        LockClassKey {
+            inner: Opaque::uninit(),
+        }
+    }
+
     /// Initializes a dynamically allocated lock class key. In the common case of using a
     /// statically allocated lock class key, the static_lock_class! macro should be used instead.
     ///
@@ -95,13 +109,11 @@ fn drop(self: Pin<&mut Self>) {
 #[macro_export]
 macro_rules! static_lock_class {
     () => {{
-        static CLASS: $crate::sync::LockClassKey =
-            // Lockdep expects uninitialized memory when it's handed a statically allocated `struct
-            // lock_class_key`.
-            //
-            // SAFETY: `LockClassKey` transparently wraps `Opaque` which permits uninitialized
-            // memory.
-            unsafe { ::core::mem::MaybeUninit::uninit().assume_init() };
+        // SAFETY: The returned `LockClassKey` is stored in static memory, so its destructor will
+        // not run.
+        static CLASS: $crate::sync::LockClassKey = unsafe {
+            $crate::sync::LockClassKey::new_static()
+        };
         $crate::prelude::Pin::static_ref(&CLASS)
     }};
 }

-- 
2.50.0.727.gbf7dc18ff4-goog


