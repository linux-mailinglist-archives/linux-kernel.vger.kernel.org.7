Return-Path: <linux-kernel+bounces-893197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0B2C46C5C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 632AA348D2B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23B43115A1;
	Mon, 10 Nov 2025 13:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M0/81zFE"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE8E302169
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 13:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762779978; cv=none; b=StYz7VRlOqWv5/qozWl2/+de9v7id5Ueb49z1aaMjuq/KLyJmp/oYD+mde+hK6wZEdHmiHQol+8qyX/BbQjnrJWmH6SObKWYrlUOJufS/U4mkSHoNQOAraVVed7bFKFdFYabzOq1nZU3hvxZX4CloxRtLNTDNNwKPoMGxrg341I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762779978; c=relaxed/simple;
	bh=Lz6COCva7yG6KNSx8r9nfcyJx0BW/9KhmoJVhFJNDyY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZnHvDObwekLFXinI8Dq3rsKQ0iMpLIMaqxEBybdQAAlKtT9j8iy4FLV84CHcMGULzF/vndUxTzgf+s5uk64y4c6VpviLL0DKwh7ZBBn18pbFXSjRs9cvGYCsUf8mxdgIvYIEIqgOtIjByAGfZQ0sokXRz9Bc9Kp4owBJ4ftnnxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M0/81zFE; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-429c76c8a1bso2125559f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 05:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762779974; x=1763384774; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gS41oALaXXy1Rj0bz/L9Rj/ludgCw5mZxJ04H0Sb1qA=;
        b=M0/81zFE9ssfRwqurPqbPl09AHHAA4cLIzFfRNlrm9H5iSfNS/Rj7Y0sgX9VlyQmmB
         X2ICLRdw+SAPOduTKvunhktGkALIMYPbViQkn89i0BGIfIKxC9Uf3V5/A0Tzu/Lr3UfN
         /e3V9E8r+KcXji9JdiDvMxn+J/Vl2tRZInPoeF+y0n/YLluPgVap3fiFvOrWE3wJyMfZ
         93G4u1zSsIamyWWIPue/CI6AdLI0Hfuw+r32ZkZen5SyhtCWQcmmyyPq7aN0xirsTw7c
         C5nW921Es3tltu3lyCVTEw+YTd9EXQ3GmBTCxx9oDj3kB1+n1E46vYV6P3s5OyGfwkmE
         dTnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762779974; x=1763384774;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gS41oALaXXy1Rj0bz/L9Rj/ludgCw5mZxJ04H0Sb1qA=;
        b=wqAEEzgtloOeElBDIac2GMJ4w+yBYP36/qWSfV6hbLM2/jXF1fxJ4pCJpLVkATBkeD
         4UOMbuRCxIlLc7XNUj5rNH0y7ZDtszNcRBOoLYHqUF+HUthHF7FFsRKeBQK+rzzxPJUo
         oqjr1uv6QuRFNQdNHZZ6rYaM3GEQlgnCZ8u8srTAM4XOkmLh1mCRxyWSNRTsaCC9SbsC
         9JbbIzDR/3Bm9EGRjo62m6eXAP0EraO1FQX/Z7HMQ0DZEXU/WMeLfJx/LG73MDL6Pvqm
         h3CnfiJAskRAxAc4zGw9Oo0U2vYRMWGMfMzef7lzHLckDH13gcppvNhgNu35Yzrh2bj/
         6MqA==
X-Forwarded-Encrypted: i=1; AJvYcCXL3auap9Ifw7xXwUuvJCmR2x9hagvlBvWvkFFVgb5+/tSuK2F0qUWABC+5y3hrn2zTAyu0nwuSbAd+FjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDoWz56Rbm6mkQA22LEhOWIsTHMJml9ts//plfz5FRvWZ419jW
	jH0RpPd9AYdCyKwdh8AuXrPqrR4qZXk31y4ykQjBj11qFDgrN7V5cVnwzF9ppUArSltlWgv11Wy
	+Txv8Bu/v63yId7/Xhg==
X-Google-Smtp-Source: AGHT+IGlOVyTmUXKrCuFsOI6dOMwcSdmtb1mLdvS6be1D0Wm7u7bVMnUILhedvTgwRdfrttqFRSVLcINP+0G8zw=
X-Received: from wroz11.prod.google.com ([2002:adf:f1cb:0:b0:429:bb75:80ae])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:18a3:b0:429:8b47:2f35 with SMTP id ffacd0b85a97d-42b2dc23fafmr7775853f8f.26.1762779974157;
 Mon, 10 Nov 2025 05:06:14 -0800 (PST)
Date: Mon, 10 Nov 2025 13:05:54 +0000
In-Reply-To: <20251110-binder-bitmap-v4-0-5ed8a7fab1b9@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251110-binder-bitmap-v4-0-5ed8a7fab1b9@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2618; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=Lz6COCva7yG6KNSx8r9nfcyJx0BW/9KhmoJVhFJNDyY=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpEeND3kEbJSfW34TbElEzLRGE+NXAamJaABVG7
 P46pIIJws2JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaRHjQwAKCRAEWL7uWMY5
 Rso9EACKo86FEsGZCtPzS9tIoQ7FfSam1lLZIBWn86nSeWY+SWQNSlGpatXzASBOU2bK00hyOmt
 mbdowJtTebDhaZiFbmposRFoKSSg88tWDSZ9qfoQdyKzfxutcRHrZqaHUDad4pNcLhOi9SLSkb3
 4cdWprRWaLwVVl+YERHb0rCXbAIqECR39aPwJzdORYetKhzUEBLXaeFRNBfzSWFL8ElWQcGuvVf
 8pqS/C+aBhFsigs5xsaGXD6yBIhd1lIhm2RUBj+tt3MCZg+IdJHSMQcJGu1Oz/mfcnIVknnbftg
 f3r2oSvtV/1uCrPNnsXg7kRClqnVSFPpTqvdiMfK3vBe51Hw5tuTvWsOXmflvzmJeGt0y7WiGkc
 /aa060ckj+ngLAL+UQpFU+YCOzqARJWogWsZnNbbs6JhXyD2VHtHcKZj04++u2fr1c3LNUp6xVG
 VQRucQz/E+m9c4amfrB5QqWe0KkWoohHWikjrPWxNc1K8fPjO2i0mQR9HKuCF1anOPrBbxMXXON
 TWzy2aALpkj2LyalLESW4PFwUP8a+BtWNqIhHKyv31kTzle87G34ccX46uh2PqTD/XmandoO6Ds
 LVtQav4B92m2FZyczcEduwCZ5QCCsNfQbdNoFoO/9sAml0Yw9Wy1tQTn37Uv8/V+h9wp/YzXL3D gDPoC9/EOtSj3xA==
X-Mailer: b4 0.14.2
Message-ID: <20251110-binder-bitmap-v4-1-5ed8a7fab1b9@google.com>
Subject: [PATCH v4 1/6] rust: bitmap: add MAX_LEN and NO_ALLOC_MAX_LEN constants
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
2.51.2.1041.gc1ab5b90ca-goog


