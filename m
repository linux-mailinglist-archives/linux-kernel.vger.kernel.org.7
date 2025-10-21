Return-Path: <linux-kernel+bounces-863018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB571BF6CB5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31F8919A4BFE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308CD33858F;
	Tue, 21 Oct 2025 13:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u5JxU01q"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C312E3385A2
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761053601; cv=none; b=jKKlpj869YTLp70H/fJLZmW9u8K57Fo9Pzb8HlcmBJ3gCEQr68nYQxdkSuqLcayGoQnO21Kae60JGTlC/MoWhSMOJDtB0lwJupKbmY0oh9gALVlft/w0IoYc6drptCweZADtcX2iV9Kq8PGHs4y6UspP+jifZtoCP6ezoLg3/84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761053601; c=relaxed/simple;
	bh=y0H0co/pGG3mnaoefgv7jJBWHvIIQnYFtiVxMl2tyu0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kBmwJoQ1m92x3gnauH74uKWpPwtybDGtG4QkFSHf/qysKm9F1S0lr5C232nObAIXG0LvCwEp9L97iX4rwVSRhp5IXEowBR1KclLw09UrwxEMmPbDRoq/g64g4BHGO5MbKVUeeVJ0EnB8NOCzKoZNo1VhJMDY1pWv/WFhJzwOQL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u5JxU01q; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-47114d373d5so53876285e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 06:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761053594; x=1761658394; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YusvqkwYLWumMyM3OygPRZKhF9bgc4APSkdbz1xg4sY=;
        b=u5JxU01qQxZ96FXpXlTJhlS75taT+NXHliWBZxEjklSJN1fQ0oz7csPPOO6zGpXVb+
         153+5dHkGdOnPL5ccH+dOwzQlVTBl/2HY3eL9D2sztCre3d/ytjJYKCGzNZk40sCG6L9
         A1vkQFysHIgD+cuwg4ebDMsc8wUnsM6G4eIc0186Gxzb6sIalfmuyyCX3i6JrGz6PPhk
         8iJwl2iSWRE6rxf8mKhlDyznNdPkc+izrhK/m+LO9RHXNHVQKuUApNRYHBap3BX2nBQu
         i16Uxh5CZ9Xu32OjuLhvsqNI2aZAhw4ntT10QLrI2srN7BQIuHGGCxgzqc3KjaEeGccG
         nRqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761053594; x=1761658394;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YusvqkwYLWumMyM3OygPRZKhF9bgc4APSkdbz1xg4sY=;
        b=oklLt3N0dZ+LVPnwH+87pNWH4Q90pKhxOpYh7iU16ygMKegcMxehzpx11GngvSUVxb
         ZN5RNpD8KqkehtvomhiVW9rZOuJ95nEUU2pxuv9YHK83sFF0SnXiYTo4CvvZy21fWo7y
         hvpE1ipjAx/+p2jncLawlg65vAfAP3NVLwSwrBI7enN4qcs3GSO7iMFWA/FBzh1mu0T6
         d/c04OUFD70r1mR0NFpLq170he8ucdNUG2C4NVW3JBMU4HVQQtq82qvB3MmPa+z2PELg
         H8sb8DL5ujqmArO212cpiLMqVV9WnEtu1lrI4yDSHdw9/TQ9/dGg+tB4c5L8tmeeN0kk
         AV6A==
X-Forwarded-Encrypted: i=1; AJvYcCUofQZseeROuepJi8rk56z5ssPibF7Oz28F7LZv3m9dRqKjOswvXHVEC67bhHmx6AiDbvZBHjplgIL6kt0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5CZIr29nvKk9UXUwHh7Tm/lVBPxPFqLeRwZ6KijFL2OYp/g6m
	LiuoAzrbIug7f2hYjolL02PQtlQL0N6tRGUPuzFxGwiTrcjoy0VVITtUwbpLMdMYn70fR4TEc0Y
	cchOefODZ/TxKNAN5bg==
X-Google-Smtp-Source: AGHT+IGHAgnRN/r9kkpyIgetmO5A2D9wd+5oaqIK8kJ6Puo5wRwP5Luw9i0GPB6EuIZssrvr5wxVUNGHB3+wWF4=
X-Received: from wmbz7.prod.google.com ([2002:a05:600c:c087:b0:45f:2306:167])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:468d:b0:45f:28d2:bd38 with SMTP id 5b1f17b1804b1-471178b14acmr121528965e9.18.1761053594119;
 Tue, 21 Oct 2025 06:33:14 -0700 (PDT)
Date: Tue, 21 Oct 2025 13:32:43 +0000
In-Reply-To: <20251021-binder-bitmap-v2-0-e652d172c62b@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251021-binder-bitmap-v2-0-e652d172c62b@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2617; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=y0H0co/pGG3mnaoefgv7jJBWHvIIQnYFtiVxMl2tyu0=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBo94uX1NMWifM6CkoHtyygykkIM1ifibZQp3rD/
 xyR7Hgs+wCJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaPeLlwAKCRAEWL7uWMY5
 RozgD/9XaOkDjMN8jCzn0IHApKOCYXGttdJuj7aYLxaz/Khss34iJS7KOd2qxRyPVUIM5wlmOcj
 mg2vmqlTwRxfBq/FfVWt3DCghKKjzdiBXyhDjpT4OteR0Qai99wAl//XjLolq+aTApMALai9vEN
 eLVb+YoikoehilUP0p6h/V0E2SdFyB6RMnYCNJX5RFRcAG0+GmlT+WzjRD+zIh7rWx/fRdns1yz
 ru2urA5bBSV1xnqxDsr1S8p3C2riKpnVy5nXtuUYibtYzREZcJn5/N+VMf1+Jx1wB9vN10vlBq3
 +oHDOubkLPqu641tBIR0FAbX9mAE9HVdi/zq3Qc6jRhcbqohmgsIqkM/7hm6gdhQSpHu2KpVb6G
 MQlpW7nOEbVEKTEu/rl/YhHZImzrEzccGZtZbGy9hNRuljc6cKBPqd5HIrpfCysRw8b/NISJdKR
 Xi+B3rhADaEnyotWXyaB0WlzRVfse4SpSxDS3GMyZ5zPAcPQPGqjBeVZOR3HZDONv1LhL/aKy9J
 nI5IfG2G3T3KkcdkPIfXI99Y3PbecAqe1FFIz+QiiUJeQ2bb4KhaliyVNOu4cEeJVxqkBm7ue+z
 7pnoHkrakBfWQrDqFYwHjkRK8l0QW6YUD5S0EVWon/HwAAw1N5ujZ37AuEhWRpQnV5t/qGyQ8Mn n40886pW/I9QwGw==
X-Mailer: b4 0.14.2
Message-ID: <20251021-binder-bitmap-v2-1-e652d172c62b@google.com>
Subject: [PATCH v2 1/5] rust: bitmap: add MAX_LEN and NO_ALLOC_MAX_LEN constants
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
2.51.0.869.ge66316f041-goog


