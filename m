Return-Path: <linux-kernel+bounces-762330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0E7B204FF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45298420A98
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3CC7226CF4;
	Mon, 11 Aug 2025 10:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="O98KwPcr";
	dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="GwSRppAX"
Received: from mailrelay-egress16.pub.mailoutpod3-cph3.one.com (mailrelay-egress16.pub.mailoutpod3-cph3.one.com [46.30.212.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C451DF97F
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.212.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754907312; cv=none; b=V6PwQyYdJqo99E3jOXELe85B2DQHWsjFbBUPY4+6at2BOWho2RY/PtoYw8e4bmJ4PLNkEi9xFXDAqQhE036ngugDx00sbFb8X/mklsqFsWlWGwugB/lwAYJuQE86pfoRJvLUHuVD/lm9Z+GesdKVdDeddKqPJyt9UALYH5zD/HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754907312; c=relaxed/simple;
	bh=iDo6uT2Dr5g1uhEmnQj8ZY1fZ0cJQ9BUtJFLb7W34NY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JyUhTqukJ1i5VOPr3RLixAvuWdhT0fd11SvgPQrSagX1gEfcrG/ubcx/txJrsKDgJrywbFawoMYuvLGNTGPxxqdOoMgy6J2JbhXSF6DGm/1ob4bN+A5tjDNAOFVBa0XmbWLQv8Xz0TiPkp7yO5WzA9GzKr55JugXodAJLHZy7cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se; spf=none smtp.mailfrom=konsulko.se; dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=O98KwPcr; dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=GwSRppAX; arc=none smtp.client-ip=46.30.212.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=konsulko.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1754907301; x=1755512101;
	d=konsulko.se; s=rsa1;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 from;
	bh=14R4+Gj/HwcaD0TXtbOX6HbfeIwMHoTAJNp5m0FSvT0=;
	b=O98KwPcrxJvMyf77pDgP5cmFedtBncws3QfWsFQKJtAhIdfWp7wu2yQ/Nj76wN/WDtmHjxjxbjlxN
	 WjJBRrJNl28hUoeVZKfOonCGDOfBWTSw6X5oBBlJBmpwqRCH3u3gspoEgQF8TZGUAPN414sPBs1J5s
	 vbehSX5hDybUto/M63wuJg/mSpl8FCum/VH85gllirZBBE7K3yP/9Uw/6wq87XfMfff4MdOPkK3IIr
	 dsocNxTY22y0+KfdaIZBvOvruVlXDUYzWxCvmWHG2+2ie1+gMc/JbPdYS5SALWRS3AH8HK0xc9oIDC
	 rgFN8p5fD3WzbsZMA/R3mJAnl9SI0eQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1754907301; x=1755512101;
	d=konsulko.se; s=ed1;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 from;
	bh=14R4+Gj/HwcaD0TXtbOX6HbfeIwMHoTAJNp5m0FSvT0=;
	b=GwSRppAXU3gBmGzatksNbCtufxeGENmGNRQG+jUJte3E3W5Ep/cop65Ccoqid3saBZkBTwRF1WXGe
	 DbB7HpTBQ==
X-HalOne-ID: 09db4792-769c-11f0-bde6-632fe8569f3f
Received: from slottsdator.home (host-95-203-16-218.mobileonline.telia.com [95.203.16.218])
	by mailrelay2.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
	id 09db4792-769c-11f0-bde6-632fe8569f3f;
	Mon, 11 Aug 2025 10:15:00 +0000 (UTC)
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
Subject: [PATCH v3] rust: alloc: implement Box::pin_slice()
Date: Mon, 11 Aug 2025 12:14:56 +0200
Message-Id: <20250811101456.2901694-1-vitaly.wool@konsulko.se>
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
 rust/kernel/alloc/kbox.rs | 72 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
index 1fef9beb57c8..ea9b08e3f8ea 100644
--- a/rust/kernel/alloc/kbox.rs
+++ b/rust/kernel/alloc/kbox.rs
@@ -290,6 +290,78 @@ pub fn pin(x: T, flags: Flags) -> Result<Pin<Box<T, A>>, AllocError>
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
+    /// use kernel::sync::{new_spinlock, SpinLock};
+    ///
+    /// struct Inner {
+    ///     a: u32,
+    ///     b: u32,
+    /// }
+    /// #[pin_data]
+    /// struct Example {
+    ///     c: u32,
+    ///     #[pin]
+    ///     d: SpinLock<Inner>,
+    /// }
+    ///
+    /// impl Example {
+    ///     fn new() -> impl PinInit<Self, Error> {
+    ///         try_pin_init!(Self {
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
+    /// assert_eq!(s[3].d.lock().a, 20);
+    /// # Ok::<(), Error>(())
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
+
+            // SAFETY:
+            // - `i + 1 <= len`, hence we don't exceed the capacity, due to the call to
+            // `with_capacity()` above
+            // - the new value at index buffer.len() + 1 is the only element being added here, and
+            // it has been initialized above by `init(i).__pinned_init(ptr)`
+            unsafe { buffer.inc_len(1) };
+        }
+        let (ptr, _, _) = buffer.into_raw_parts();
+        let slice = core::ptr::slice_from_raw_parts_mut(ptr, len);
+        // SAFETY: `slice` points to an allocation allocated with `A` (`buffer`) and holds a valid
+        // `[T]`
+        Ok(Pin::from(unsafe { Box::from_raw(slice) }))
+    }
+
     /// Convert a [`Box<T,A>`] to a [`Pin<Box<T,A>>`]. If `T` does not implement
     /// [`Unpin`], then `x` will be pinned in memory and can't be moved.
     pub fn into_pin(this: Self) -> Pin<Self> {
-- 
2.39.2


