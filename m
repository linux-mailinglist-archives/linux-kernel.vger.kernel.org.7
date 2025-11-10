Return-Path: <linux-kernel+bounces-893199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 026F8C46C5F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 77D52348FD0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6C630C609;
	Mon, 10 Nov 2025 13:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YUchCdrJ"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC013112C9
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 13:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762779980; cv=none; b=ck1XxAhprCCyY2M7fvgrZGz+051eWjwY3s3w6fzwiBGP3I6utGeGvy0BYN+3//A65EV9Rv0gE+XMtdOdUQfgIBYgR6pBgqgtH9CKYta6805uIw6etEKwcMzFmrLdJqAn4/yoFhCPh7MPH1YzbrQhpWzVhKd7NePV//L2UrpNRrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762779980; c=relaxed/simple;
	bh=m1vVqdokFGJjs0Wc5xiNelJgyQeXsj1xAzq9sutLqvQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qFQoDUOq48B1F48LDRK2/LLQBffpwvTSSwHHw8MvDaTmf0jzLqYvZO7hqHk2iNbKl4mnBRTrzGGCDFWirpkpac9RAMmva3ejSqRrEWIBQEfIwk4g/iNw5HLvzZ8j06GqW5POBUDGU9aIT35i10BFX9Tq/yzgGBZmCcXO0yF1qZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YUchCdrJ; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-47777158a85so18884775e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 05:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762779977; x=1763384777; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cdy78GHJToK/JjNyIhLRtXUU+0hlDX8vDSmxqOI6fJE=;
        b=YUchCdrJTDw7QdmT5W4FwiyV3QbE+cJ/qegMxg9Mxty5DtwKTH1JN+8M460LYhzdWu
         TONoy9BFNpLSn+vgdVWI+juusSHKgSUu8FiL5wnTeSNe9/eNl5nzz4r43ofFQb4x1z66
         I8Dzx+sBHCDk5F0GpeMlyQZFM0el+8wTBazp/0p4drCV3eTEClXPTKga3TEf9MB0DgfO
         SvHghrqfS2Nv6hQc8B5L8KcHRvS7jcvo5dBVte2Ndndv5yrYeUY46vrsnOy6UFVea0Vr
         7SSekyxMPJnSRkUljBFKqKPyJXgTvK/e6JGCH42p1By5821Ck5E4oawMjWi9fTUaWvNu
         tfFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762779977; x=1763384777;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cdy78GHJToK/JjNyIhLRtXUU+0hlDX8vDSmxqOI6fJE=;
        b=cLH3vFw80hJvUnnnEhOf/r1Yo9QDo7SyzOSI0T+QkacKrarYX9pfhgEN1BuuomDXHv
         bl+sHqguZWxY96WF4D6DsRuQwRqK+U3L+9MvvjqAdcymdr2KkFTsFAjAKsjMvKmRr/uC
         7YBndMv9SSJVHrnWxQZ/qCVcqYhVHiF0GNsIvjBIKd9HDpUnEoPoJ3w8pfqm2ux1v7Pm
         8nlOYS/32OSSc5S6ePHb9LVujVJEOSSPuO1poRnMOqhF/5h+6dN6MpityyqFTo/tuYjs
         fsA6LLxsZQSouDd19+dMbpW2SRkfj1rG9f04Cy922vY4irslTaUnBTI2m6HTzxJrDAec
         m+pQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoqVO93OvWuMOR3OC5V3sv9FM+2/uJcIpf5CKSIsA6gdxSmUNKMUALquvvhrN/9G+r+tX59DCk7eOM9Zw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH1tyvjDYySUkgErWa/V7v1FuaBE6xAPAF8W7FUODZpzLNsDA5
	aJAdU31mTs5dVcURgLYA2Oa7Qnmrb6NMS28iJHva2w0oiOJpkQ/Rlqvk59tdlgrvS4P4xP40Ype
	lFrcsIP1H9FVk617otA==
X-Google-Smtp-Source: AGHT+IEc22nyf0SxRXO1MsTddRElJjOhoLrCVVBkpsoGR23XRROluM5qaNXAmsmXS0MF8ilFDXjhtNk6g+l6jOU=
X-Received: from wmmr22.prod.google.com ([2002:a05:600c:4256:b0:477:5b53:e6e6])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:35c8:b0:477:7c45:87b2 with SMTP id 5b1f17b1804b1-4777c458895mr25242705e9.16.1762779976819;
 Mon, 10 Nov 2025 05:06:16 -0800 (PST)
Date: Mon, 10 Nov 2025 13:05:56 +0000
In-Reply-To: <20251110-binder-bitmap-v4-0-5ed8a7fab1b9@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251110-binder-bitmap-v4-0-5ed8a7fab1b9@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2473; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=m1vVqdokFGJjs0Wc5xiNelJgyQeXsj1xAzq9sutLqvQ=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpEeNDj0+4b38ogh/01MXmXpq9AWMLVEfFTgFI4
 ELaPwWpxTCJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaRHjQwAKCRAEWL7uWMY5
 Ru5BEACjYUnsofpWcJ0H+hy5wsR6XrOYJ9I5zDeaF/4c1fr515jbIpNwBsjIJkijkqdipOllZ+T
 pi1JSDpE9A3FK6Ee8C14sITKmi7zvM1UXdlvwRo/LDrJgrWikJ6huduz+LhlQnL7VOL6nVVUAUs
 3woqAMAzCaZ+5cNO+p/FCTQBK5Kkt178AbIa091Jodjk32CGLs1bWa1HenYvfbZSV8LvClIbMel
 t3Uw/lQz9z95IeORgsZWqSPoCeaukP3phxLR2dSgD/b6weJcLX57ey/gsrNhNhPzmbvsOFU9StT
 OVgWATZ9Zd1i/jMDEpEZlKsVsIxgeCa7eHAmxChZMV6tjYdiBS2idR3PnhoHfznIs4rQR91MkMI
 cpkY3ceEVKdhUh2ovjfp9Wzg94k8zlWTaggpA74/DmFoVcObQ8GA6PDcebHbGE2gC2JvCPPU2n+
 nlMG3sNfC3V8Jg9V301jYDpJdYAaSF3cMsxnNBptfGUJ6g5kYzsKZvb5mW9PF2LGhN9oLqhww1H
 LMReh/32jqtU0wQUIGWrawdrF7SeVdbPTJEdoPXQsDH0b9LOyNCdXDKbCFwXln5TyUGSXtCwatQ
 8EZP7BoptWrI6yT1IrA3KswC+dRGVxGjACRKqF5Gxj9mBtw9Xso45AS0TogcObsb3w8B2ebQ6/d 8CV9FBblUsXQUWQ==
X-Mailer: b4 0.14.2
Message-ID: <20251110-binder-bitmap-v4-3-5ed8a7fab1b9@google.com>
Subject: [PATCH v4 3/6] rust: bitmap: rename IdPool::new to with_capacity
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

We want to change ::new() to take no parameters and produce a pool that
is as large as possible while also being inline because that is the
constructor that Rust Binder actually needs.

However, to avoid complications in examples, we still need the current
constructor. So rename it to with_capacity(), which is the idiomatic
Rust name for this kind constructor.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/id_pool.rs | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/rust/kernel/id_pool.rs b/rust/kernel/id_pool.rs
index a41a3404213ca92d53b14c80101afff6ac8c416e..5942f678db015e902fa482eb64c38512a468e449 100644
--- a/rust/kernel/id_pool.rs
+++ b/rust/kernel/id_pool.rs
@@ -28,7 +28,7 @@
 /// use kernel::alloc::{AllocError, flags::GFP_KERNEL};
 /// use kernel::id_pool::IdPool;
 ///
-/// let mut pool = IdPool::new(64, GFP_KERNEL)?;
+/// let mut pool = IdPool::with_capacity(64, GFP_KERNEL)?;
 /// for i in 0..64 {
 ///     assert_eq!(i, pool.acquire_next_id(i).ok_or(ENOSPC)?);
 /// }
@@ -95,14 +95,14 @@ pub fn realloc(&self, flags: Flags) -> Result<PoolResizer, AllocError> {
 }
 
 impl IdPool {
-    /// Constructs a new [`IdPool`].
+    /// Constructs a new [`IdPool`] with space for a specific number of bits.
     ///
-    /// A capacity below [`BITS_PER_LONG`] is adjusted to
-    /// [`BITS_PER_LONG`].
+    /// A capacity below [`NO_ALLOC_MAX_LEN`] is adjusted to
+    /// [`NO_ALLOC_MAX_LEN`].
     ///
-    /// [`BITS_PER_LONG`]: srctree/include/asm-generic/bitsperlong.h
+    /// [`NO_ALLOC_MAX_LEN`]: BitmapVec::NO_ALLOC_MAX_LEN
     #[inline]
-    pub fn new(num_ids: usize, flags: Flags) -> Result<Self, AllocError> {
+    pub fn with_capacity(num_ids: usize, flags: Flags) -> Result<Self, AllocError> {
         let num_ids = core::cmp::max(num_ids, BITS_PER_LONG);
         let map = BitmapVec::new(num_ids, flags)?;
         Ok(Self { map })
@@ -126,7 +126,7 @@ pub fn capacity(&self) -> usize {
     /// use kernel::alloc::{AllocError, flags::GFP_KERNEL};
     /// use kernel::id_pool::{ReallocRequest, IdPool};
     ///
-    /// let mut pool = IdPool::new(1024, GFP_KERNEL)?;
+    /// let mut pool = IdPool::with_capacity(1024, GFP_KERNEL)?;
     /// let alloc_request = pool.shrink_request().ok_or(AllocError)?;
     /// let resizer = alloc_request.realloc(GFP_KERNEL)?;
     /// pool.shrink(resizer);

-- 
2.51.2.1041.gc1ab5b90ca-goog


