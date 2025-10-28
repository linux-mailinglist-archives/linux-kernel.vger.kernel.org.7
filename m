Return-Path: <linux-kernel+bounces-873610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9247BC143F7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C40AA545023
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9D4309EF2;
	Tue, 28 Oct 2025 10:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e/2rAbIS"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A160309DDB
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761648932; cv=none; b=HWRTg++FWK6kqVrTizNFmQRmuRFDZBXQNvJSQ2+krfCUx9UWc7DqOgo85Ded3buP35k4Welc+ObFs3wnBFQEXOzEUTVNVUfg0o2UKoCdYJ85XW+7bPfMAv6hlWJY03+ycBY1W9N+4YbUro54GRda5ghkhlnT8nXzMufslU/Hn30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761648932; c=relaxed/simple;
	bh=wVEdg6FeeLwB/hit6gnmFv1v8wpEUtieEvxq37cRo8o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=owBrOl4zMbVnyt9I/19cuNuj5mnX2Z93fwu29Cds+3YBF4rRTyqXg4K6AM2AS80hgu2O9vdGus+G4bLGFgU9JW3gowLKaIllYlmjWkbdkkcQZT1kdgtGGi7sAy7l4+t0DMXD6faL4HFP1puSknn+PUy7I72K7dRSgcNlC9kxtJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e/2rAbIS; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-47113dfdd20so21383475e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 03:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761648928; x=1762253728; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oyfRCk0EaJ1XWxrdb6W14tsx1dzvf/EiCVJtPUF+24A=;
        b=e/2rAbISoueCNyncAYsjvUGUERadFTXGWeic5xu2MQpSmXShYjDuDb4HeNi7d8OlTm
         iUw6HFeYoAsv8CT35wrAf+VrVc90yDKrT6/Gnjso7l1/s9D6WPLPFuSHMjHa/8rdND0r
         5nFaBq8IyPQYuYZEVDSo3e1jxr3zEoOUvw6zl53FyexrJ9EokEnVFmU7LwRn/0H6Q4gR
         AM+2EZNvQsKWhr1fmHq271m25m1BP8pK7JN1Ipy+pze9Kgg6OXzyWpFXzW9O+/6hDkft
         pvuhZ+08R4QaYeLf7eYRot2TIATAU2eoe6p/3ElnosC9Pb9JWROcwLdzc/3WERQoyHp2
         Ktbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761648928; x=1762253728;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oyfRCk0EaJ1XWxrdb6W14tsx1dzvf/EiCVJtPUF+24A=;
        b=XOnsTiUq6/rhbCyzN8wZ5gENwL30/ptmuFiClVJwA7wXQK18WBpZfI2kaqCa3UPiQa
         DdWWKwBkb0AUNUeIwDypK94+mf8csOl9GJMqrIdtuhyD93bHhMvtgKzi9j3xD786Ymij
         Rn+Cm+SDMTMJBjLYXXZtpOEL+jn58OWBJcMYz6wapUoUQySh8Do6OYTULglmaKtMYEVd
         q2E5MvjjpOyQPDn8i/SUmvxVKHZe00ITu6CJyq7NZZr6Nb0TRqVxkTCEWOgo3evBJbs4
         6Ox07+5TqWdnh1xTAEiqCqO5nb7XluLK4plB+p1i3QbHNPVBwh6xAcBal3BdQuKVCwze
         eWsA==
X-Forwarded-Encrypted: i=1; AJvYcCVYd4Ri0RCuUl1bf5fS08LiIb1uObv8eBSAKEa9+kEEqwTEBUjgww9ALGG+GLR8H0GuLXEHPZFvJ990dMA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvpXGkM4jx9r6+vgyAYWjIhpQCGrkHYrs34DUYZIXmQQC2Mbl/
	uwNZmJtdGVfMj9zPCfQWDE0T9lkQvI8emVlUezLHhdsPkXmvmwDoWGoLaeFtazTuhFTnQV9x6aB
	P8KdbJkS65oQW0wBXAw==
X-Google-Smtp-Source: AGHT+IGSToYHrvAtmCCKH93eCaQBK/1hSpp4oS1FPlqIAdAPq0AxsXI/5FVGw0BVLFvZb8SiQ189jAiQcfnEh0k=
X-Received: from wmgg16.prod.google.com ([2002:a05:600d:10:b0:475:de83:8f42])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8411:b0:471:7a:791a with SMTP id 5b1f17b1804b1-47717df6c67mr23657245e9.7.1761648928631;
 Tue, 28 Oct 2025 03:55:28 -0700 (PDT)
Date: Tue, 28 Oct 2025 10:55:16 +0000
In-Reply-To: <20251028-binder-bitmap-v3-0-32822d4b3207@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251028-binder-bitmap-v3-0-32822d4b3207@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=3606; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=wVEdg6FeeLwB/hit6gnmFv1v8wpEUtieEvxq37cRo8o=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpAKEbKP4cXyDZC8ed7UCVTDO0DjnqjfM+D/73U
 EKXjp0ZWzyJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaQChGwAKCRAEWL7uWMY5
 Rgg7EAC2hTlkGBo1Y8m7lyzJFdkLs6KX4tn7ZepP4Za9Yg30LJqD224EVERnchMH5puZk5xbi/l
 ZwVlNBGjsgd1h/PN22sSB8Q7VecMHuCGNKaVSFJRnJlyxnVCaNlxD5CIKdkmvhGa/b3g640tgah
 0Dl1GclvcuEzHCgarlqF3Dv058D6PwNQCOGEzyuu+OzwVDcIuH8p9mXqutotMmpKfBG5VdBXVv9
 LFrKptsZQ+pVjChYogKn8ZhknaF6azv1gjXz0P0xnOkf/XTP911Frn7K2yiTB3yypZBDSzmgWNk
 XYoVR+mkdsOs9r3gkfgSzDnbeAysn44h5iIHamsr9CZJkDtD28flpbPm9ie8BSDjtL2Fqd7a5e8
 E28YSsFA+m3uDY2UaMcwvtn8hZPLU7kjYw9YgcwmuzlgHq35v/avn443xSiKUnJP64/SOMcj/2A
 dMubIs1EA4glbJ/tcavyppxBOOUCMJRPy9PNEMVuRiW/2BVzOFq6clIosWacZaT7osA6BEi9e2C
 +RHZbLb34liEJTLQKPVaGoyP4xnEXswpytNlgOCz9mSxqbFwDJpb0Ogi4hmWwYrMhZ6Te55oUUQ
 1y78SIu8qjEivncLWfkefxFVl1v7EdBR5szqCcMNEeuN/Pz793Q66vJ+RlqHKxW4LAbeItmywGK rMOExOitiYOo7Nw==
X-Mailer: b4 0.14.2
Message-ID: <20251028-binder-bitmap-v3-3-32822d4b3207@google.com>
Subject: [PATCH v3 3/5] rust: id_pool: do not supply starting capacity
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

Rust Binder wants to use inline bitmaps whenever possible to avoid
allocations, so introduce a constructor for an IdPool with arbitrary
capacity that stores the bitmap inline.

The existing constructor could be renamed to with_capacity() to match
constructors for other similar types, but it is removed as there is
currently no user for it.

Acked-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
Reviewed-by: Burak Emir <bqe@google.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/id_pool.rs | 46 ++++++++++++++++++----------------------------
 1 file changed, 18 insertions(+), 28 deletions(-)

diff --git a/rust/kernel/id_pool.rs b/rust/kernel/id_pool.rs
index a41a3404213ca92d53b14c80101afff6ac8c416e..d53628a357ed84a6e00ef9dfd03a75e85a87532c 100644
--- a/rust/kernel/id_pool.rs
+++ b/rust/kernel/id_pool.rs
@@ -28,19 +28,21 @@
 /// use kernel::alloc::{AllocError, flags::GFP_KERNEL};
 /// use kernel::id_pool::IdPool;
 ///
-/// let mut pool = IdPool::new(64, GFP_KERNEL)?;
-/// for i in 0..64 {
+/// let mut pool = IdPool::new();
+/// let cap = pool.capacity();
+///
+/// for i in 0..cap {
 ///     assert_eq!(i, pool.acquire_next_id(i).ok_or(ENOSPC)?);
 /// }
 ///
-/// pool.release_id(23);
-/// assert_eq!(23, pool.acquire_next_id(0).ok_or(ENOSPC)?);
+/// pool.release_id(5);
+/// assert_eq!(5, pool.acquire_next_id(0).ok_or(ENOSPC)?);
 ///
 /// assert_eq!(None, pool.acquire_next_id(0));  // time to realloc.
 /// let resizer = pool.grow_request().ok_or(ENOSPC)?.realloc(GFP_KERNEL)?;
 /// pool.grow(resizer);
 ///
-/// assert_eq!(pool.acquire_next_id(0), Some(64));
+/// assert_eq!(pool.acquire_next_id(0), Some(cap));
 /// # Ok::<(), Error>(())
 /// ```
 ///
@@ -96,16 +98,11 @@ pub fn realloc(&self, flags: Flags) -> Result<PoolResizer, AllocError> {
 
 impl IdPool {
     /// Constructs a new [`IdPool`].
-    ///
-    /// A capacity below [`BITS_PER_LONG`] is adjusted to
-    /// [`BITS_PER_LONG`].
-    ///
-    /// [`BITS_PER_LONG`]: srctree/include/asm-generic/bitsperlong.h
     #[inline]
-    pub fn new(num_ids: usize, flags: Flags) -> Result<Self, AllocError> {
-        let num_ids = core::cmp::max(num_ids, BITS_PER_LONG);
-        let map = BitmapVec::new(num_ids, flags)?;
-        Ok(Self { map })
+    pub fn new() -> Self {
+        Self {
+            map: BitmapVec::new_inline(),
+        }
     }
 
     /// Returns how many IDs this pool can currently have.
@@ -119,20 +116,6 @@ pub fn capacity(&self) -> usize {
     /// The capacity of an [`IdPool`] cannot be shrunk below [`BITS_PER_LONG`].
     ///
     /// [`BITS_PER_LONG`]: srctree/include/asm-generic/bitsperlong.h
-    ///
-    /// # Examples
-    ///
-    /// ```
-    /// use kernel::alloc::{AllocError, flags::GFP_KERNEL};
-    /// use kernel::id_pool::{ReallocRequest, IdPool};
-    ///
-    /// let mut pool = IdPool::new(1024, GFP_KERNEL)?;
-    /// let alloc_request = pool.shrink_request().ok_or(AllocError)?;
-    /// let resizer = alloc_request.realloc(GFP_KERNEL)?;
-    /// pool.shrink(resizer);
-    /// assert_eq!(pool.capacity(), kernel::bindings::BITS_PER_LONG as usize);
-    /// # Ok::<(), AllocError>(())
-    /// ```
     #[inline]
     pub fn shrink_request(&self) -> Option<ReallocRequest> {
         let cap = self.capacity();
@@ -224,3 +207,10 @@ pub fn release_id(&mut self, id: usize) {
         self.map.clear_bit(id);
     }
 }
+
+impl Default for IdPool {
+    #[inline]
+    fn default() -> Self {
+        Self::new()
+    }
+}

-- 
2.51.1.838.g19442a804e-goog


