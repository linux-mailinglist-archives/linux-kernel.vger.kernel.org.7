Return-Path: <linux-kernel+bounces-897233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 72294C5255B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7A8F24FB07D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A403385A9;
	Wed, 12 Nov 2025 12:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lr/4Yxiq"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892CD336ECC
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 12:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762951655; cv=none; b=H4AUIXG7fodtFX6/FE06ggl7WQApfN2nAxqGF9zIQJH1t+6dBFvHQ2JCiMIpg+fnG2BhXT1PCr/OvnV2ISQFOs+eV3LFObzkuZ4zs0eb407N3jXq0Xs/DL4afTP7J1iCr0/ZUot9zsjnXy5JZQv+7OZ39DHwKcZ6gBaRyU/5I5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762951655; c=relaxed/simple;
	bh=hKaPMy9+GEI/b3Oq8xi/5gaYtlyCO77NYnlh7ZIaMpw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OeW00m7OzvWzdPAfdRxD+QtDVMl0bTtqSlm1/jtw4L2RqsKqABhEXCexo21/yBmllewbmjNiRQEV5h/uId5LMTsut6eVd+tZ6xX1hwMbzDVZ3Mmu6OqPv9AMbr1YYbHYPSEibsLUFLbiPOrIrT45JZXdAt1ChAjJeyVTBMxSKw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lr/4Yxiq; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-640cc916e65so1206988a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 04:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762951652; x=1763556452; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=q4UBJCHM5aA25nWu21zr/8ZKj4a6mo6pSN1iH3EBauU=;
        b=Lr/4YxiqJFOgOamqPnrFeA4bOq1yzl5XAt16+O36lD8g7kzKHzgkkisU1BGRmlbtec
         ybBI2L5DgMXuLR4Cmz4ZKZx19D99uMNXyhD/fWrngK4R4gKU0ReZD/IQmgKYzyYD6q2S
         K3hGgERNMycTu/FGSAzmq6Lg6N9jZ2fOI8oFjy9HKOf8TuWsemtqX+0CDjYuvayEVzLC
         nr+w8JGu0uc4igr7Rw2MHrrg+A3zLEKdOradZTf2mvU3WD/kxQ+7qtSfSzNUhOgg+53n
         ZWv1BTY8AMSN0gCsud+sX/MHFQ7YTht0mxuZ0P7W8YMQ35vrPvDW0qicLJr0BvXAsLJ6
         HbzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762951652; x=1763556452;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q4UBJCHM5aA25nWu21zr/8ZKj4a6mo6pSN1iH3EBauU=;
        b=gSJFIQTVAKd437IOw8EZVDqW6tXuW0/27MRI2hlCd5GgPEv5o1vqfQe87o5kQbFVra
         +IVHDsaOplQIYELkYwi5oqG0apwWfcjrXXqcou8JR/FyIsYxgf27YSAmGjLZTpsX1Q8i
         Dn+WaYd9O9EfTNrTYQb6uDFGB5+KSAgeBg7lc8wEAO93082f36JnKCZMB3xoBPhAVA2U
         KcN1Xdsc7K1qgCn1nPKQOHJU/gr9GXSHWOHUKp/DCHrWj/tF3eFHML1XzA+68RANDjDo
         4XmaJhPYs6HQK9XOV4d5O+Q9HXRFwGZe8gEFDxdk68M30ae8KMoa4upZnqQOi4ZDp7MH
         HKFw==
X-Forwarded-Encrypted: i=1; AJvYcCW35m6251FTrSEXSQY7XUpW5OutYs9xCYKlQLZ8FwJXiJcf6ZFF2rirptj/8RdI8eVcght2sYcEgTkfeVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqWH5mtS+ztJlZI/SoInEB99HQvVOu+cpAS4oUAsiR0r3FNhQy
	iM4ylk3LrtDSvAnBlEndGAxdFUNRagB+04oPZRug152A13A48nFCNbX82jrUAE1wNEjF0/yjyim
	Exf9ePLmzB8cyP9eafg==
X-Google-Smtp-Source: AGHT+IHxrwjiNI/+r47De2XruyMMvKVXWthxfhc+G7EBXTftcxSNxu1BR123UupilsNII15IfXeoMMP7ssWXVIo=
X-Received: from edi12.prod.google.com ([2002:a05:6402:304c:b0:641:92ae:b59b])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:254c:b0:640:948e:7da4 with SMTP id 4fb4d7f45d1cf-6431a561bb6mr2237679a12.29.1762951651735;
 Wed, 12 Nov 2025 04:47:31 -0800 (PST)
Date: Wed, 12 Nov 2025 12:47:21 +0000
In-Reply-To: <20251112-binder-bitmap-v5-0-8b9d7c7eca82@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251112-binder-bitmap-v5-0-8b9d7c7eca82@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2409; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=hKaPMy9+GEI/b3Oq8xi/5gaYtlyCO77NYnlh7ZIaMpw=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpFIHeFXZ2PL2RerOIjW5w3K+2z5Ixlz4dZRF5f
 v1uZDU8i6iJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaRSB3gAKCRAEWL7uWMY5
 RirOD/0U3Rlj9i0S+NJHFFYvnCIpbHdOCpzHotQsXuGX+YxJX7s8lVY4rxGJ5VbIFENTfyG96S4
 SDSHoVT9Z34zf/ehrodn0xU4HTkFMwQoXG66Xml+9432Re/2sRXFO75N2lcSWJpoBnfOPhSpseV
 vvTLwzWEL2TGM86usmVGaKKsdmyTOXZIUz1w3qwXlMdh6rnPxi+Zb24dazPNaz0jL1+a7t84q7Y
 vj0fzZ9p7GFQOsbvgnvIFnBvthnd8qEWqffJl16wMQHDdq7/keeI/lUZcolitLo+SEZjMf62VXo
 oZZr7P89hSX3RCQpKHXofnYbrpDqAkIX1JXJVETLTLuuoKhzqLkmDLuuMmuFMkAQ8VqblvGK379
 8EZQo06tt6WvU5Q9IcU3wXJz+komB/IoLow2A/20tPERkQ1H6mOXuhxwjyeVFCcnrPYJaZMvfpU
 RXxv62dZ0xg+uEJKnOc/5eM6Iuk+pynJvtlFGU6d7tudJNLlHJ2mos1TaL+c7uZgX4jgkD/OVMX
 uuLqEHjfMa6MVi8A79lPgA+y8wQD7TiO5Cdz8R0wpxJZe6vLlrB32PBwFzqL8oyFM7oJV4W61r4
 fnV7izyl4zvfcRfZyl+D+N39EtClHoJvK0B6p6kA6bkLzrMBmJZgkl9JCQ2rGGBfJS/OeXydvKx o4ZljuhUUwZ1L1g==
X-Mailer: b4 0.14.2
Message-ID: <20251112-binder-bitmap-v5-3-8b9d7c7eca82@google.com>
Subject: [PATCH v5 3/6] rust: bitmap: rename IdPool::new() to with_capacity()
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

Reviewed-by: Burak Emir <bqe@google.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/id_pool.rs | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/rust/kernel/id_pool.rs b/rust/kernel/id_pool.rs
index 8f68b45a3da1f62dd0d010480837de49b9a343ba..90836b05c6155f98ab8393c8291749f408dbd4da 100644
--- a/rust/kernel/id_pool.rs
+++ b/rust/kernel/id_pool.rs
@@ -26,7 +26,7 @@
 /// use kernel::alloc::{AllocError, flags::GFP_KERNEL};
 /// use kernel::id_pool::IdPool;
 ///
-/// let mut pool = IdPool::new(64, GFP_KERNEL)?;
+/// let mut pool = IdPool::with_capacity(64, GFP_KERNEL)?;
 /// for i in 0..64 {
 ///     assert_eq!(i, pool.acquire_next_id(i).ok_or(ENOSPC)?);
 /// }
@@ -93,14 +93,14 @@ pub fn realloc(&self, flags: Flags) -> Result<PoolResizer, AllocError> {
 }
 
 impl IdPool {
-    /// Constructs a new [`IdPool`].
+    /// Constructs a new [`IdPool`] with space for a specific number of bits.
     ///
     /// A capacity below [`MAX_INLINE_LEN`] is adjusted to [`MAX_INLINE_LEN`].
     ///
     /// [`MAX_INLINE_LEN`]: BitmapVec::MAX_INLINE_LEN
     #[inline]
-    pub fn new(num_ids: usize, flags: Flags) -> Result<Self, AllocError> {
-        let num_ids = usize::max(num_ids, BitmapVec::MAX_INLINE_LEN);
+    pub fn with_capacity(num_ids: usize, flags: Flags) -> Result<Self, AllocError> {
+        let num_ids = usize::max(num_ids, BITS_PER_LONG);
         let map = BitmapVec::new(num_ids, flags)?;
         Ok(Self { map })
     }
@@ -123,7 +123,7 @@ pub fn capacity(&self) -> usize {
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


