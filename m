Return-Path: <linux-kernel+bounces-759028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB41B1D73F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 14:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BA9F583CCA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 12:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E5824337B;
	Thu,  7 Aug 2025 12:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="EFIaPnUu";
	dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="5eg+fR6M"
Received: from mailrelay-egress16.pub.mailoutpod3-cph3.one.com (mailrelay-egress16.pub.mailoutpod3-cph3.one.com [46.30.212.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9EB239E7F
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 12:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.212.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754568626; cv=none; b=IvVhhK6Or1Yb3371DFoNsou4Onr4/PJYDDRwyxM9OV2ObNVIkZb8YJqImwHMNgc4Dq9OT5q+Gmft2BrABGJyqVm267LrH0ZjTP1olTd4dpn7M+4ruzQqpLSlzB2ZkU3GI9HE3psZ8TxztmIb8Td9aRz0bqRjaDby9Fw1eg2dnto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754568626; c=relaxed/simple;
	bh=bO8dcPP/dxchhlZwTJ+ksGxVRxEV4n3Jm2FmNev4q2E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kYer48kU1q1gwJmvTg7h8bHco9FdLB4FciBA1hXjml79BTqN45d8I8KESzuP5NQwCEZJMHoal5a4fQABCpDtyw/4ChjeEnwSX48YbH2UEb3ln9ne4FywoyxTLefSv3wmdljnJoyV8pYUeX550j4BATX6nuHCLvGQjHVDzDEf94k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se; spf=none smtp.mailfrom=konsulko.se; dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=EFIaPnUu; dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=5eg+fR6M; arc=none smtp.client-ip=46.30.212.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=konsulko.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1754568621; x=1755173421;
	d=konsulko.se; s=rsa1;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 from;
	bh=Q52bbfTzkfCRNzr97Nue/VaOOC2qoR/9F6VBSjElX9Y=;
	b=EFIaPnUuUmgLgR7m5p098Z8JsSBM3NAh8fuj/ZKhsTrnly0XTjXO1sTvIlxpB1d0YjnTfx20jEU0u
	 oBdHAtQyV4We2iaGDR4vAF41hNSTifC11zbyKJpT4utxZ6sF4G1EefTHE8bVwR9wUy/1yKpNLMfywa
	 8Y3kqgw7WOZnwlHn4kGDCZ9PeLJNYB4CkXY9gBC5tcviEkooJDtx2s2rTn6Z7K+AjJ3djR81odCLPR
	 YoO1ijZtf5M7aOCNviAUkZ0KO6vk/PzTyd9Y/tlbww8jQmLcnBNmvqLbL3gN1BAM3Dm9M4D2szLOeA
	 mxokO6DGTsh2arm1BeEbHrGJzNvoqUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1754568621; x=1755173421;
	d=konsulko.se; s=ed1;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 from;
	bh=Q52bbfTzkfCRNzr97Nue/VaOOC2qoR/9F6VBSjElX9Y=;
	b=5eg+fR6MTuRxb8YPyHtiF65WbTnnLGJR6G5WKX32WRmCaZfbM3wi/krwvJ3X6nClGPonaOwsY+EK+
	 NOYXjpODA==
X-HalOne-ID: 7ce91011-7387-11f0-b24c-d510462faafc
Received: from slottsdator.home (host-95-203-16-218.mobileonline.telia.com [95.203.16.218])
	by mailrelay4.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
	id 7ce91011-7387-11f0-b24c-d510462faafc;
	Thu, 07 Aug 2025 12:10:20 +0000 (UTC)
From: Vitaly Wool <vitaly.wool@konsulko.se>
To: rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Uladzislau Rezki <urezki@gmail.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	Bjorn Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Vitaly Wool <vitaly.wool@konsulko.se>
Subject: [PATCH] rust: extend kbox with a new constructor
Date: Thu,  7 Aug 2025 14:10:11 +0200
Message-Id: <20250807121011.2317762-1-vitaly.wool@konsulko.se>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alice Ryhl <aliceryhl@google.com>

Add a new constructor to KBox to facilitate KBox creation from a
pinned slice of elements. This allows to efficiently allocate memory for
e.g. arrays of structrures containing spinlocks or mutexes.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.se>
---
 rust/kernel/alloc/kbox.rs | 51 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
index 1fef9beb57c8..74877afab0a3 100644
--- a/rust/kernel/alloc/kbox.rs
+++ b/rust/kernel/alloc/kbox.rs
@@ -290,6 +290,57 @@ pub fn pin(x: T, flags: Flags) -> Result<Pin<Box<T, A>>, AllocError>
         Ok(Self::new(x, flags)?.into())
     }
 
+    /// Construct a pinned slice of elements `Pin<Box<[T], A>>`. This is a convenient means for
+    /// creation of e.g. arrays of structrures containing spinlocks or mutexes.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// #[pin_data]
+    /// struct Example {
+    ///     c: u32,
+    ///     #[pin]
+    ///     d: SpinLock<Inner>,
+    /// }
+    ///
+    /// impl Example {
+    ///     fn new() -> impl PinInit<Self> {
+    ///         pin_init!(Self {
+    ///             c: 10,
+    ///             d <- new_spinlock!(Inner { a: 20, b: 30 }),
+    ///         })
+    ///     }
+    /// }
+    /// // Allocate a boxed slice of 10 `Example`s.
+    /// let s = KBox::pin_slice(
+    ///     | _i | Example::new(),
+    ///     10,
+    ///     GFP_KERNEL
+    /// )?;
+    /// assert_eq!(s[5].c, 10);
+    /// assert_eq!(s[3].d.lock().a, 20),
+    /// ```
+    pub fn pin_slice<F, I, E>(mut init: F, len: usize, flags: Flags) -> Result<Pin<Box<[T], A>>, E>
+    where
+        F: FnMut(usize) -> I,
+        I: PinInit<T, E>,
+        E: From<AllocError>,
+    {
+        let mut buffer = super::Vec::<T, A>::with_capacity(len, flags)?;
+        for i in 0..len {
+            let ptr = buffer.spare_capacity_mut().as_mut_ptr().cast();
+            // SAFETY: This address is available to be initialized, and it will either be dropped
+            // on a future error or returned as a pinned location.
+            unsafe { init(i).__pinned_init(ptr)? };
+            // SAFETY: We initialized one more value.
+            unsafe { buffer.inc_len(1) };
+        }
+        let (ptr, _, _) = buffer.into_raw_parts();
+        let slice = core::ptr::slice_from_raw_parts_mut(ptr, len);
+        // SAFETY: This memory holds a valid [T] allocated with the right allocator.
+        Ok(Pin::from(unsafe { Box::from_raw(slice) }))
+    }
+
     /// Convert a [`Box<T,A>`] to a [`Pin<Box<T,A>>`]. If `T` does not implement
     /// [`Unpin`], then `x` will be pinned in memory and can't be moved.
     pub fn into_pin(this: Self) -> Pin<Self> {
-- 
2.39.2


