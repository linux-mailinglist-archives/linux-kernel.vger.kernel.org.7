Return-Path: <linux-kernel+bounces-873608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD18C143F4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 972EB543F31
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4283B309DC0;
	Tue, 28 Oct 2025 10:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nZU7Jcux"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1242DECC2
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761648929; cv=none; b=YmX79TfgGMxDf3YWROZT9vjWebwblOH/VWS8GX4WKbibhokrzIJ7VEGB3uvee4PCMvAD1GU6/zl+pwBGW52BG8Fd+vk2V55DUOvV/ttSmb5lwAb9tFz7vKJwua6s7BcsGoMdJ0WaQXdpCITrUzqQQtJefA9tMHMv/JkAmZIuXxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761648929; c=relaxed/simple;
	bh=l1yiCuIrEHrN9qTyEeGJb8gDUsEUM5CWLl0VkXTvO/Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bzA9MBWwQoLzDJGVOYcnsSfnLGF5ysuQxkNWMjBjhEfKuG4ym7+cn+604z30gvHJNzB2pUf0Ii3uX5nSjGaGIr9aFNBlhOse5gfq44xtOelaCDOlPAbdfeyltnvP5Jz67EE0Y9lz+G0Fr3vYMikR6nAukSxe0leSg/KXowuXnZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nZU7Jcux; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-4298da9effcso3639138f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 03:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761648926; x=1762253726; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XkfuEZJAJLwiOPcOM5KW0XWm5zAGxFJfsgxlppUu9Ew=;
        b=nZU7Jcux1HaH4h7UU3db1qHoHt/j3c6qg/Q9Wnbf91H+MlabiZnlCP9h9bzC1Vsf4f
         ISUUss6vm30X0CdVvzx1wPDkXF4BSCJhMWb9j2g5q9ZCQv5UFORdeyc8DabsM27Pc2MH
         PYI/j97VIWDe5pmchNBHG8qPciTeS3d1AYyJpn9r+/3FVtevwiMMt6XdD1sKL3cB3/lr
         YMiawcYemJAntA/oSZvuCgKDryhyeqXQPG7+BEih5CNtv9rznUD9nXF3z0dwVe1EXGfg
         qgUOGosqhPRIdDmB0fi1MBbp+aDSwyRr783oIBNmKsG5X0oL7KFnWS9hVVcUjpxfdO1l
         ODzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761648926; x=1762253726;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XkfuEZJAJLwiOPcOM5KW0XWm5zAGxFJfsgxlppUu9Ew=;
        b=eAvlJxGWrrv3EvtbbOWH0VOpudN1lvl1iPN9n3dry9As73Z3EBNQYgdOMfKgcIW4RT
         Zlp/2u2yrCXWP+6USMllJCnii1vjA00fdWaOGh/qql2Zkb/63pCx9VOSzXXojUMkJ6VO
         e5bCg0TwN8ljpQ3YnoU/2NVut/Iu2gbzGLdJ/vldUUHC0vh7fwgbj5TTG31UXM3RX8X1
         K3ggQfT8sAcbD+3PbMXVqx8mM42ldAQixA7CSJ8V9R1Ts0ulq7hJ4jQ+75bpTNGwFSsW
         qD7kClKBGG6bzk/TyE+5uAOSRR5W2f591C1nyVx0cJhOxFj4A93WN1/X5n6zZe6AR6yy
         5ryA==
X-Forwarded-Encrypted: i=1; AJvYcCVbBFydEXWaqRX/HJF6fvC6S6ME/pDusFeXRIpjlteob2eHmHc/CE2uXSEKTXIsFFUBOUMLqd+aQ1tQOxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbsyILqo07t24BhgMHAWfR+Tg3jJOoPdJqdwK/kP3m0PRA8eg6
	jbxDVNd5haldin+e2cFUzUS8RxdwN7fXmJm7rMHMgLPPC3o6cX1PjckVVoZVs/K9XJBD7BfyuCm
	346Qa8s85MseTTyt1WA==
X-Google-Smtp-Source: AGHT+IG6lAR1Exg+ZJ2zeUf3ihqt8puTw2kX4ttNtep8dx0xRWXe8BU2dAVTBuGkGoyamUr15I7XwqhwKq38BhA=
X-Received: from wmbjo7.prod.google.com ([2002:a05:600c:6b47:b0:46e:2f78:5910])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:611:b0:426:ff8f:a0a3 with SMTP id ffacd0b85a97d-429a7e7320dmr2182375f8f.34.1761648926292;
 Tue, 28 Oct 2025 03:55:26 -0700 (PDT)
Date: Tue, 28 Oct 2025 10:55:14 +0000
In-Reply-To: <20251028-binder-bitmap-v3-0-32822d4b3207@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251028-binder-bitmap-v3-0-32822d4b3207@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2617; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=l1yiCuIrEHrN9qTyEeGJb8gDUsEUM5CWLl0VkXTvO/Q=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpAKEbulObCzB8CJqtGdcXGSog2T3jFiGI7DMrh
 LYWsDttYl2JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaQChGwAKCRAEWL7uWMY5
 Rq9MEACayJs55q3EtpvYIg6w0qS+F2kplLuZ0uQ7Qeyl1olMJ/GnBjf4QMiXXQFmg3lWn7JsbJZ
 tO6UuQC4wMLPRoZvv7TNjWYuANM1nVBX8MZKaSFRVOzPt3OmOdpkC6nnnyVg+Lj8xrN1alK46J/
 jr2l3rJzEND+9LDWrtS74micAoggZVG4hiNA99Ln1dhHsfHvicJ7KYV/CDLkKuEsS+AOa0O+5P7
 yrMSJjtrNWt7CleJVInCJOPMqzVLHs0IIAz/tvQNDvG/0n2pP+sVOaahCGoIGw2bfC+48NZHi3Q
 wcuxMFlBO4AZTr9L8GANjs/EN171RGxhXbR1KPSXkAoCF2afTCDwrI6Dkv/1cij+JbbwVgoq/cM
 VA/ByzSxbm3Fs4yfKB+SDhRoiOlgp6QhBC5Fz9frhh1I2UAIQrG95xmUemRM9kZwSJxkEcQn37P
 pEF8EJxaCYDumGGH9bxWyL5+f2FFyiTc4WRdgvaasqgO8hgU8jkmxZ3k+XaqY8TKssbizlE3Pjt
 Nys9/u9floX1lB/rAK+R9JVg4VCir5biNws7dxRhS+Q1SXnjTLshiNyciSZzjrYglcKv+ySyAnH
 lh+iycc6RhfeMJkLnxeWlfzXXVeAXu57/eKt9pR5T9mHXKRQo8TCvpsC0y0mlHh5BM4xGXpxqtZ ejAvjyBCI5e48mA==
X-Mailer: b4 0.14.2
Message-ID: <20251028-binder-bitmap-v3-1-32822d4b3207@google.com>
Subject: [PATCH v3 1/5] rust: bitmap: add MAX_LEN and NO_ALLOC_MAX_LEN constants
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

To avoid hard-coding these values in drivers, define constants for them
that drivers can reference.

Acked-by: Danilo Krummrich <dakr@kernel.org>
Reviewed-by: Burak Emir <bqe@google.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/bitmap.rs | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
index aa8fc7bf06fc99865ae755d8694e4bec3dc8e7f0..15fa23b45054b9272415fcc000e3e3b52c74d7c1 100644
--- a/rust/kernel/bitmap.rs
+++ b/rust/kernel/bitmap.rs
@@ -149,14 +149,14 @@ macro_rules! bitmap_assert_return {
 ///
 /// # Invariants
 ///
-/// * `nbits` is `<= i32::MAX` and never changes.
+/// * `nbits` is `<= MAX_LEN`.
 /// * if `nbits <= bindings::BITS_PER_LONG`, then `repr` is a `usize`.
 /// * otherwise, `repr` holds a non-null pointer to an initialized
 ///   array of `unsigned long` that is large enough to hold `nbits` bits.
 pub struct BitmapVec {
     /// Representation of bitmap.
     repr: BitmapRepr,
-    /// Length of this bitmap. Must be `<= i32::MAX`.
+    /// Length of this bitmap. Must be `<= MAX_LEN`.
     nbits: usize,
 }
 
@@ -226,10 +226,16 @@ fn drop(&mut self) {
 }
 
 impl BitmapVec {
+    /// The maximum possible length of a `BitmapVec`.
+    pub const MAX_LEN: usize = i32::MAX as usize;
+
+    /// The maximum length that avoids allocating.
+    pub const NO_ALLOC_MAX_LEN: usize = BITS_PER_LONG;
+
     /// Constructs a new [`BitmapVec`].
     ///
     /// Fails with [`AllocError`] when the [`BitmapVec`] could not be allocated. This
-    /// includes the case when `nbits` is greater than `i32::MAX`.
+    /// includes the case when `nbits` is greater than `MAX_LEN`.
     #[inline]
     pub fn new(nbits: usize, flags: Flags) -> Result<Self, AllocError> {
         if nbits <= BITS_PER_LONG {
@@ -238,11 +244,11 @@ pub fn new(nbits: usize, flags: Flags) -> Result<Self, AllocError> {
                 nbits,
             });
         }
-        if nbits > i32::MAX.try_into().unwrap() {
+        if nbits > Self::MAX_LEN {
             return Err(AllocError);
         }
         let nbits_u32 = u32::try_from(nbits).unwrap();
-        // SAFETY: `BITS_PER_LONG < nbits` and `nbits <= i32::MAX`.
+        // SAFETY: `BITS_PER_LONG < nbits` and `nbits <= MAX_LEN`.
         let ptr = unsafe { bindings::bitmap_zalloc(nbits_u32, flags.as_raw()) };
         let ptr = NonNull::new(ptr).ok_or(AllocError)?;
         // INVARIANT: `ptr` returned by C `bitmap_zalloc` and `nbits` checked.

-- 
2.51.1.838.g19442a804e-goog


