Return-Path: <linux-kernel+bounces-745354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B26D2B118D3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 09:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCDF11897677
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 07:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF86225FA05;
	Fri, 25 Jul 2025 07:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ToEzEuli"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD4A26B2D2
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 07:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753427006; cv=none; b=r2ACWyPu2cCPZZckqDsnvnA0M7AFA5M3dndpJwSojcxRHHHF3OoCigjF4o7TgOEBbDyhiT9nS5JYhBw5zgsnstA2k8Gb65QxGWCqsRSJCE10ciISNaO8F0jjg2ow3mOnXxJsKO8DpKJpNsNaZTxJe0vd43oQBnPlLSHCD4/Ctj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753427006; c=relaxed/simple;
	bh=2Gl2cahgaLVZIWDnYUk8nnvaJfE907iYPgS3oeXMn4w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cdgBpB8tcSBL66ysXDetFymtVIHafHu/DqTY0PDW0mnxB5FD+6gDMWZi5JbwRVJ6p+UMf32Ich4dEzxLTl4H6+WsAO3aYpiM1AO/NO/1F8C7Urc5YO8RK0/9jiZxTebTySEH2Em2OpSVXbpRIEZBElS1X78SpuUYU35a/7BTlpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ToEzEuli; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753426964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LOIbM2mlp9tLy2hxdmtCOBP2OarogA8hGYUa+KiCIXA=;
	b=ToEzEuliIBOYXCUIHJwC9N2o8l+dhi9t9IUeAftEN5wg1Ch8rO3fRFRck7zdxV2QcPQbO0
	JnSRrRqvXtFzjAa3uDEmXtSdO3rb2OG84i0DjbLb0UtitzLXKPZTrFA8FZSkZN0W2+bz3V
	CaRyS4eC9kNpZKnLkoLjpaorcovZINQ=
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
Subject: [PATCH v5 1/2] rust: allocator: add KUnit tests for alignment guarantees
Date: Fri, 25 Jul 2025 15:02:20 +0800
Message-Id: <da9b2afca02124ec14fc9ac7f2a2a85e5be96bc7.1753423953.git.zhuhui@kylinos.cn>
In-Reply-To: <cover.1753423953.git.zhuhui@kylinos.cn>
References: <cover.1753423953.git.zhuhui@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hui Zhu <zhuhui@kylinos.cn>

Add comprehensive tests to verify correct alignment handling in Rust
allocator wrappers. The tests validate:

That kmalloc respects both standard (128-byte) and page-size
(8192-byte) alignments when allocating structs with explicit alignment
attributes.

That vmalloc correctly handles standard alignments but intentionally
rejects allocations requiring alignments larger than its capabilities.

That kvmalloc mirrors vmalloc's constraints, accepting standard
alignments but rejecting excessive alignment requirements.

The test infrastructure uses specialized aligned structs (Blob and
LargeAlignBlob) and a test harness (TestAlign) to validate pointer
alignment through different allocation paths. This ensures our Rust
allocators correctly propagate kernel allocation constraints.

Co-developed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
---
 rust/kernel/alloc/allocator.rs | 58 ++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocator.rs
index aa2dfa9dca4c..bcc916240f11 100644
--- a/rust/kernel/alloc/allocator.rs
+++ b/rust/kernel/alloc/allocator.rs
@@ -187,3 +187,61 @@ unsafe fn realloc(
         unsafe { ReallocFunc::KVREALLOC.call(ptr, layout, old_layout, flags) }
     }
 }
+
+#[macros::kunit_tests(rust_allocator_kunit)]
+mod tests {
+    use super::*;
+    use core::mem::MaybeUninit;
+    use kernel::prelude::*;
+
+    const TEST_SIZE: usize = 1024;
+    const TEST_LARGE_ALIGN_SIZE: usize = kernel::page::PAGE_SIZE * 4;
+
+    // These two structs are used to test allocating aligned memory.
+    // they don't need to be accessed, so they're marked as dead_code.
+    #[allow(dead_code)]
+    #[repr(align(128))]
+    struct Blob([u8; TEST_SIZE]);
+    #[allow(dead_code)]
+    #[repr(align(8192))]
+    struct LargeAlignBlob([u8; TEST_LARGE_ALIGN_SIZE]);
+
+    struct TestAlign<T, A: Allocator>(Box<MaybeUninit<T>, A>);
+    impl<T, A: Allocator> TestAlign<T, A> {
+        fn new() -> Result<Self> {
+            Ok(Self(Box::<_, A>::new_uninit(GFP_KERNEL)?))
+        }
+
+        fn alignment_valid(&self, align: usize) -> bool {
+            assert!(align.is_power_of_two());
+
+            let addr = self.0.as_ptr() as usize;
+            if addr & (align - 1) != 0 {
+                false
+            } else {
+                true
+            }
+        }
+    }
+
+    #[test]
+    fn test_alignment() -> Result<()> {
+        let ta = TestAlign::<Blob, Kmalloc>::new()?;
+        assert!(ta.alignment_valid(128));
+
+        let ta = TestAlign::<LargeAlignBlob, Kmalloc>::new()?;
+        assert!(ta.alignment_valid(8192));
+
+        let ta = TestAlign::<Blob, Vmalloc>::new()?;
+        assert!(ta.alignment_valid(128));
+
+        assert!(TestAlign::<LargeAlignBlob, Vmalloc>::new().is_err());
+
+        let ta = TestAlign::<Blob, KVmalloc>::new()?;
+        assert!(ta.alignment_valid(128));
+
+        assert!(TestAlign::<LargeAlignBlob, KVmalloc>::new().is_err());
+
+        Ok(())
+    }
+}
-- 
2.43.0


