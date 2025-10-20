Return-Path: <linux-kernel+bounces-860996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B114BF18B0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1158421F6B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 13:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA51A31987A;
	Mon, 20 Oct 2025 13:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HyXqJntx"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE6D2FDC20
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 13:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760967238; cv=none; b=QHaMiketm093Iq3AnN+lGNkt3bFqMUfyT+0drPdNhymY7ZmMsnkH69+RBm4BxJaoWoxkfrUIIt8ycxHhLxIvmlfIxjyVCFxV7A9GYWFa+s5HHHMqLESDE3+73HrF5rBbxZ+e1NXZJkD+y1dRl/dIsS7GI9grXMIoHuKYBuvSdAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760967238; c=relaxed/simple;
	bh=thSFFHc18AWUj5aqWdgPfPpfkLxR0GCl0hag2FFKB38=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rjBJPMssr4Y1kZvzLuv+dq62cNlOU1G9YxuIJpuq4wT2SWDC4S6oxVlT7Sefuw3XcDlcV5MjJmDnhK4w5F9ww4FkENUL97x1BE7jKrYhYETpekeQsgFgdGPP2aOt13DyLyzjzE7o5g9Z1Bg71hY3ovOoHBmyFBr2gcItIey9kec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HyXqJntx; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-46e4cb3e4deso15873545e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 06:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760967235; x=1761572035; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hP+6efxF2qsVAZJqN5GtRW+FGzYHXSfL66ojkDSC4QY=;
        b=HyXqJntxTBZrmupaWyHiKmWsHteFX01f6iC/70eNIa9nDb6j+9nQtVcT3XnSJW9Tr0
         8g7MV7JMqDfx1AsW5xCw5f61ZGpJ1eQx8vZhbKukKvreziTSiXqMv7NNypAXObuI88J1
         pgBZ3v9eVtyLEJF4FtWlV7aPOPCMNNkFgR/+oH+f7TCA7/a9TTjiyJ/HHyIwDzOR5C/s
         VeBNkJugs0HBYj+mkfX7oWHWT2EptfkcEWI5JDUnIykLLdLZqeI2zEHvtKkLY+0Q1QKO
         +7o82UIXFpk3F/NZjKhcn855RqKmt1dNVU0VCLqqrvH31DYqcpDnS0LWk67N/gdayr2g
         gvgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760967235; x=1761572035;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hP+6efxF2qsVAZJqN5GtRW+FGzYHXSfL66ojkDSC4QY=;
        b=XHzA3+JOCxVO///onMQH6QOKivpPwZCE6Be/llZ3tOkZblIW4Og2K3oENhk7Hq1VOF
         bNg1S9Kv+WCimJ6osZWxbsCITllorqVCI7gYO0YgpRvWJPsTZlTHPDWluaBf3ZpnIPC5
         nCBheXdxS025Z2JV11l62Dt3HX5ipfosX42/hQBw4NxrujCAMfDpG9Ye5PtIdAxOglbS
         MTuk3dikivjrxlofKMW3ihzKhuzGRfhJ6s4K6okLvR40cCHWGblj4vm0NKaGdSW2tQtb
         uaTL9RigCGLdS37YDtjWMnBN0VHta0HflyAKSJ6BfU0BfHiFtVjvYbTBk3X5kaJTjw3O
         ZoXw==
X-Forwarded-Encrypted: i=1; AJvYcCVlV+J1tHNau/5IMUy8QJjGEQW4lNiAbH/IPUTLRRCTEYgfcRHSYHTmlM0gcoNZA5PU2WW6fbVz0Frkc88=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYbPWZVHFhBM5/dPtapGkBWSXtSjkNPcRnp4UvbLZvj1MNugEP
	DrmfGFCk1nVmGhfv1n+B6EJpPS676mnH1Vc/Q2/B5UxXX9hJUxb4YLJq+Ct99RWEOksGBNN66Qn
	q9DkCPrS/IE65BJWh4A==
X-Google-Smtp-Source: AGHT+IGsJYu7ivmzqWkEMta1m78AwxdpOsRB8GnsOYJkNeIzCPPDV8Af/U2XzI+UoFLtGfkAHK/DNZqKYu4z+S4=
X-Received: from wmqg20.prod.google.com ([2002:a05:600c:4ed4:b0:45d:dc32:3d4a])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8b0c:b0:46e:2815:8568 with SMTP id 5b1f17b1804b1-471172d7e15mr102633925e9.10.1760967235581;
 Mon, 20 Oct 2025 06:33:55 -0700 (PDT)
Date: Mon, 20 Oct 2025 13:33:41 +0000
In-Reply-To: <20251020-binder-bitmap-v1-0-879bec9cddc1@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251020-binder-bitmap-v1-0-879bec9cddc1@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2529; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=thSFFHc18AWUj5aqWdgPfPpfkLxR0GCl0hag2FFKB38=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBo9jpBcxwwb8kMGMy/7zHQfhjjqF1x9qVmgLLPY
 TMj/oGIL3qJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaPY6QQAKCRAEWL7uWMY5
 RrDUD/4llmvaB9bgfQsY+fQaRuNtXWlK4O9049eKPnNRPZaQdzfVJz2+jOFGLpEQwNBPa/NDWnh
 /1oB5DtKs6n6lvRSfHA4szqtfxBtXaC9kPqRCeRC5ANyINOlYb0RV7xl5K/3RfGk6d9/n7xRmOq
 iqJzVB2XBumsU2QsGM1IxE+66DkgFrTyNz1mjBkmmsO3EbSNOHEJI55GIe0hLDm+gbMypPzzeLY
 uzjRjryoB+hX2UWhrdLI+cvxzHZx0NMDTWiKV3ojcj09wHExwZCputoKRROyCTXqOdkjNUZkNK+
 VJYqTe0CT6+pKm5Gun6NG4hlWePYV7QV+Hkd21rOXjwlPz6r3u1/4ckfWkISmw2Pv6OVEHg6EdQ
 ATrrHWdJ9BnMUSfKQNNqjPgLq0MUmxviZjXCC8aK/LAqX3m5revkl/mbigHy29p6Fv9DiFQcngG
 ToUFw6LUznMznOdf77zH3vfpwYLEeihQ+fWMCMURj8yZMsIeGaid08FR/70OCH5Aa7MT/AdeTVt
 sltd1T3M1ORWsqFl196kYBoY8IUsW/cvC4ZOEQ7kNNYwa6RpPISJOo0sgM8YQDGvB/3doZJmX6H
 grcDQcWQBjUVgR5ytVWkGiTSGqsQMJ67wPOe6EP/cV27nuFAzAVyFThtiWhe3bbm7ZFzU9q+bdo /lvTLmZ2kX83S4w==
X-Mailer: b4 0.14.2
Message-ID: <20251020-binder-bitmap-v1-1-879bec9cddc1@google.com>
Subject: [PATCH 1/2] rust: bitmap: add MAX_LEN and NO_ALLOC_MAX_LEN constants
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
2.51.0.915.g61a8936c21-goog


