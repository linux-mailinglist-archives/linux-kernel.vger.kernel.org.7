Return-Path: <linux-kernel+bounces-743723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A78BB10274
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0831D1CE1DDA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 07:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2F2272E60;
	Thu, 24 Jul 2025 07:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fbqPQ2bU"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C625272E47
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 07:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753343691; cv=none; b=U80SqubkkaArbC8LSTb+RbAgvxTB1nKQM3JgsjbHdj/yhRkogX6cFXL7xE+OGJCcK5D1lxriow+UvsJTXfGyXhkxTkgY5f/QDqMnoXmaA+xKqhgMk81Hx6Afe8SUUb1STeVieBaESJJU5ij2SXoOcOpUdpd8XZasf1mt0LcwBzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753343691; c=relaxed/simple;
	bh=82M7kduRWRwnXxavLqTVQBEIeyc/P1MLwrB0Zw1JLj8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GgkVNkjbSHZrGaTj5I2Ifp0oNNFRIIr9Bkn/b8Gx/ZUuOjitHEyKZ42xxZqAwtyaaaaZXzXeljsBnFQtXXK4tazIu5Xjc8Dex/ofdRTlVbOvP42vtq44KeyS5Wognzv8OQDFmb3kI7ioU0qFM3k9FWKat8iPLqQ1UfE2WGReGak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fbqPQ2bU; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753343687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yijtlKWNOMxxyKll6m4irmOIbOxOroj9qUMsO8ydTXM=;
	b=fbqPQ2bU6NHvzPywHOpIT3u7Qkj+kK58FHmiO66/4/BOuLyMgKwn18N640DBajlLHVqTy5
	L1isfu2PxU1N1Q+zQVzIpsWswRTU2wnf0EzverL2lZP3heEbz88bsKFVNfVnN8gHe8AcGD
	YSmOblRFIGYVjnhPhi4nyU0kw0MjIY4=
From: Hui Zhu <hui.zhu@linux.dev>
To: Danilo Krummrich <dakr@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	bjorn3_gh@protonmail.com,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Hui Zhu <zhuhui@kylinos.cn>,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH v3 2/2] rust: alloc: kvec: add doc example for `as_slice` method
Date: Thu, 24 Jul 2025 15:54:19 +0800
Message-Id: <376014022fa799f5480f6f993f1e25b2561507e4.1753339262.git.zhuhui@kylinos.cn>
In-Reply-To: <cover.1753339262.git.zhuhui@kylinos.cn>
References: <cover.1753339262.git.zhuhui@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hui Zhu <zhuhui@kylinos.cn>

Add a practical usage example to the documentation of `KVec::as_slice()`
showing how to:
Create a new `KVec`
Push elements into it
Convert to a slice via `as_slice()`

Co-developed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
---
 rust/kernel/alloc/kvec.rs | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
index 3c72e0bdddb8..d384c34d1a5e 100644
--- a/rust/kernel/alloc/kvec.rs
+++ b/rust/kernel/alloc/kvec.rs
@@ -224,6 +224,15 @@ unsafe fn dec_len(&mut self, count: usize) -> &mut [T] {
     }
 
     /// Returns a slice of the entire vector.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut v = KVec::new();
+    /// v.push(1, GFP_KERNEL);
+    /// v.push(2, GFP_KERNEL);
+    /// assert_eq!(v.as_slice(), &[1, 2]);
+    /// ```
     #[inline]
     pub fn as_slice(&self) -> &[T] {
         self
-- 
2.43.0


