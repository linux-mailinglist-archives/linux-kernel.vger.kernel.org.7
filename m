Return-Path: <linux-kernel+bounces-751817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2363B16DDC
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 10:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E3777A34BF
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 08:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2661C2BDC01;
	Thu, 31 Jul 2025 08:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZJ8y8uny"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6C22BD58F
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 08:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753951472; cv=none; b=Iq05rWAE8zpj8atlFVEaL7Az+oEpxXSNxct7cGUrocc3FfPwYP+SCXKxDaG2j5wk9IZhVA0qMQvBIcd95fO3G/RZ5mP0hWEdfr31taDptfsu094bBC6o/3+W7ASSZMFLoIUA/eRAYAFCdxzHf8IzGFonjV94zDVKRPlDvCgp2Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753951472; c=relaxed/simple;
	bh=stX/5xrE5fpgRIYjEH7KhBEXQWewp8OJcVtghk/99SA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d8an0SPIELqcfHn8J1y0ZM/ctIVGOfSBHLEzoxvIR3ZM+iJSVkZtovCIMJ6Cztfrf0RTPa06XXOZTUKL14k8IXVktDP2YEZ+ReQLDAK7FnXwwppSL+Bm+5LJP/XYJa9cK1rMTmN84aIsWFKbl+zgdB4QukGPK4UbIenKs+ZxfDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZJ8y8uny; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753951468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9YWPCu2PJvY7QNysJhJawZ8Dkj2Bs7vci47IYemb9sk=;
	b=ZJ8y8unyrObkzY0ZIzhs3/YRbeOBArp6/dXH3CybbqGuTgtM6o3KBM3LWBbq/iS/ZJG3Cj
	NVMGPmR+Q9dLlAlpBXpzawhgmMSnBNyV3l9//L6NtPvptVUkeYLFHwVwzhVIUCGwu46jCb
	4KJZxncb964oEQlV9HC/8GeQZV3Clzk=
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
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	vitaly.wool@konsulko.se
Cc: Hui Zhu <zhuhui@kylinos.cn>,
	Geliang Tang <geliang@kernel.org>,
	Kunwu Chan <chentao@kylinos.cn>,
	David Gow <davidgow@google.com>
Subject: [PATCH v8 2/2] rust: alloc: kvec: add doc example for as_slice method
Date: Thu, 31 Jul 2025 16:42:38 +0800
Message-ID: <e31c55f62eef5ae729849f17ec4a434970ca37ee.1753950392.git.zhuhui@kylinos.cn>
In-Reply-To: <cover.1753950392.git.zhuhui@kylinos.cn>
References: <cover.1753950392.git.zhuhui@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hui Zhu <zhuhui@kylinos.cn>

Add a practical usage example to the documentation of KVec::as_slice()
showing how to:
Create a new KVec.
Push elements into it.
Convert to a slice via as_slice().

Co-developed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Kunwu Chan <chentao@kylinos.cn>
Reviewed-by: David Gow <davidgow@google.com>
---
 rust/kernel/alloc/kvec.rs | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
index f912a9642969..d71f6a1513e2 100644
--- a/rust/kernel/alloc/kvec.rs
+++ b/rust/kernel/alloc/kvec.rs
@@ -224,6 +224,16 @@ unsafe fn dec_len(&mut self, count: usize) -> &mut [T] {
     }
 
     /// Returns a slice of the entire vector.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut v = KVec::new();
+    /// v.push(1, GFP_KERNEL)?;
+    /// v.push(2, GFP_KERNEL)?;
+    /// assert_eq!(v.as_slice(), &[1, 2]);
+    /// # Ok::<(), Error>(())
+    /// ```
     #[inline]
     pub fn as_slice(&self) -> &[T] {
         self
-- 
2.43.0


