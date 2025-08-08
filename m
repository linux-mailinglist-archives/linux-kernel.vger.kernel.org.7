Return-Path: <linux-kernel+bounces-760440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4FBB1EB20
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 17:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B858B188717A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 15:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14EA2280037;
	Fri,  8 Aug 2025 15:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="Lc0mbJQN";
	dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="Ptx9D/MD"
Received: from mailrelay-egress16.pub.mailoutpod3-cph3.one.com (mailrelay-egress16.pub.mailoutpod3-cph3.one.com [46.30.212.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E7B78F36
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 15:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.212.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754665652; cv=none; b=A5fFXP2zJAmySFCdYXgt/P7DFBBdAEtspWScSP3YFpdOKeVT2ADUZsO5tnG7Or81Ku7+mUn2wQQ2I8svtfRMhW27w9kpeVB/SCwvFuLnyIcG1PTMauaWcoicEmQeGshEiZlxypUf8w/7Ze4gv2355gdtx+sVPBf2Xu9KTZf3i2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754665652; c=relaxed/simple;
	bh=qUmgf6BTlS6Tq4v69ENyws+aLYifYqV93BeLmR/roZ8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CKBvfbsB8M79IhdNkGmZocKHNR2YYsPU7uMWPYoPAw1AbZUBFihQtyeu/donlvsx8tUXYxDMYwazcFfEpM+F4RFfEcsJ9ZJbfKNJ1pcd67rE9gX8c+35oxTPTU50OMIObIcxQe/jf3qCAC/+zYnYn3K7msC3Dxt7u7NjJxNLl8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se; spf=none smtp.mailfrom=konsulko.se; dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=Lc0mbJQN; dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=Ptx9D/MD; arc=none smtp.client-ip=46.30.212.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=konsulko.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1754665640; x=1755270440;
	d=konsulko.se; s=rsa1;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 from;
	bh=uiWgxunv6QTnvQv+xN5Ogh6F+viAfMdu93dlj/u2MPI=;
	b=Lc0mbJQNoHJGieFCGZWvHI+38xxzNzO0raBpgPim4lpzZtA6mOeP07Y/qiLyV79Y0CuFF/PhE4EZF
	 7puIxpClse3Zl5y1QS3tNupfRBHi2jM1l6ryiWuvUmhguxiPr7bZvXv0ckR5fyUsMexkQvpV87v39n
	 VRJvX49hfChzedME0GCWbaMgsNSHBCce21mI3fyR8sloM0Y27MKSQRhAOaywAzFF0xaEN99yI9RFZZ
	 KaxkAubjn5klV+3tsQQXhKls3+j/6K3wNgsJg6djHaf9stvN/0TKfHrY+tDXU+N78Urc8AByDfGohs
	 OYw6f/si0mtUGXkZbWDQZ8Bz2BPTdXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1754665640; x=1755270440;
	d=konsulko.se; s=ed1;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 from;
	bh=uiWgxunv6QTnvQv+xN5Ogh6F+viAfMdu93dlj/u2MPI=;
	b=Ptx9D/MDVsaJXpWBQSzqjU4cxMjsfRNvc64v9H75xqHvCBh/K4MKhihgtfRncL4xsWN82l4G2wqVR
	 4JY5Kp3Dg==
X-HalOne-ID: 607fa9b2-7469-11f0-9500-85eb291bc831
Received: from localhost.localdomain (host-95-203-16-218.mobileonline.telia.com [95.203.16.218])
	by mailrelay5.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id 607fa9b2-7469-11f0-9500-85eb291bc831;
	Fri, 08 Aug 2025 15:07:19 +0000 (UTC)
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
Subject: [PATCH] rust: alloc: implement Box::pin_slice()
Date: Fri,  8 Aug 2025 17:07:16 +0200
Message-Id: <20250808150716.2479375-1-vitaly.wool@konsulko.se>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alice Ryhl <aliceryhl@google.com>

Add a new constructor to Box to facilitate Box creation from a pinned
slice of elements. This allows to efficiently allocate memory for e.g.
slices of structrures containing spinlocks or mutexes. Such slices may
be used in kmemcache like or zpool API implementations.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.se>
---

This patch supersedes "rust: extend kbox with a new constructor" posted
a day earlier.

 rust/kernel/alloc/kbox.rs | 61 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
index 1fef9beb57c8..f0be307f7242 100644
--- a/rust/kernel/alloc/kbox.rs
+++ b/rust/kernel/alloc/kbox.rs
@@ -290,6 +290,67 @@ pub fn pin(x: T, flags: Flags) -> Result<Pin<Box<T, A>>, AllocError>
         Ok(Self::new(x, flags)?.into())
     }
 
+    /// Construct a pinned slice of elements `Pin<Box<[T], A>>`.
+    ///
+    /// This is a convenient means for creation of e.g. slices of structrures containing spinlocks
+    /// or mutexes.
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
+    pub fn pin_slice<Func, Item, E>(
+        mut init: Func,
+        len: usize,
+        flags: Flags,
+    ) -> Result<Pin<Box<[T], A>>, E>
+    where
+        Func: FnMut(usize) -> Item,
+        Item: PinInit<T, E>,
+        E: From<AllocError>,
+    {
+        let mut buffer = super::Vec::<T, A>::with_capacity(len, flags)?;
+        for i in 0..len {
+            let ptr = buffer.spare_capacity_mut().as_mut_ptr().cast();
+            // SAFETY:
+            // - `ptr` is a valid pointer to uninitialized memory.
+            // - `ptr` is not used if an error is returned.
+            // - `ptr` won't be moved until it is dropped, i.e. it is pinned.
+            unsafe { init(i).__pinned_init(ptr)? };
+            // SAFETY:
+            // - `i + 1 <= len` => we don't exceed the capacity
+            // - this new value is initialized
+            unsafe { buffer.inc_len(1) };
+        }
+        let (ptr, _, _) = buffer.into_raw_parts();
+        let slice = core::ptr::slice_from_raw_parts_mut(ptr, len);
+        // SAFETY: `slice` is not a NULL pointer because it is a valid pointer to [T]
+        Ok(Pin::from(unsafe { Box::from_raw(slice) }))
+    }
+
     /// Convert a [`Box<T,A>`] to a [`Pin<Box<T,A>>`]. If `T` does not implement
     /// [`Unpin`], then `x` will be pinned in memory and can't be moved.
     pub fn into_pin(this: Self) -> Pin<Self> {
-- 
2.39.2


