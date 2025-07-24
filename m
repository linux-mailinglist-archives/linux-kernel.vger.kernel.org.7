Return-Path: <linux-kernel+bounces-743956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DFFB10648
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7ECFAE4D8D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF62F2C374E;
	Thu, 24 Jul 2025 09:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="afGEQALB"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247D52C15B7
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 09:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753349156; cv=none; b=CjllvxaQ9WR9KBLlwbwYbuzJRGUF4Pl+l9FeZQfkOjFKr8acOIq72j3iz4qQx9SJha7H8P9XvTlh1wpht0D/R6Dea1YHGxXC+KcERZgeqEK4gYoM17hPbK5F7L6iUAD0dsdKsrVbX0v2pcxcpjIQdOPPDBDemZkXGIDUebqF26E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753349156; c=relaxed/simple;
	bh=CdaYOnb1fT0dOSjxWvCijusOmY1anMO+IiPPIZ2HYKA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZdiODOxEk8JjZF81hLbPQLcXQ7piD3sqhQyIpo/iGbT8InWhp7fvZVpprcGrwpSwikTxJsu5Uao/GUXOMfYVRSgnp/fS+JzVZ1mrfJvOz2SyltLLqdPpLl4R34KqCUJPgF/K//rVzuplATaMNScqheB5P61l09ea4PjbLn/sF7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=afGEQALB; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753349152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aclP+/7iJas2ebXPYU6OTuB0cYx+hB/y7RGCUOBq25M=;
	b=afGEQALBgX7XgFeC04pt3kJPDmJBrS2iDh7FMqMppO0s8lscq5Ad8msLEDQKIc3HKxTWZC
	Soidzmh0eHwpz9CUwcnRbRFZ4x0wReHnfKLTN0W13FUPo4EiJo0HO4KH5AQmj0RkdLGRNi
	nlpzErsaCjd3FqAA8YL4U/LfdGs32oo=
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
Subject: [PATCH v4 1/2] rust: allocator: add unit tests of kmalloc, vmalloc and kvmalloc
Date: Thu, 24 Jul 2025 17:25:34 +0800
Message-Id: <32d7663b7d07d13564bdfb6a1ec4cde1be8b8f80.1753348867.git.zhuhui@kylinos.cn>
In-Reply-To: <cover.1753348867.git.zhuhui@kylinos.cn>
References: <cover.1753348867.git.zhuhui@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hui Zhu <zhuhui@kylinos.cn>

Add KUnit test cases to validate the functionality of Rust allocation
wrappers (kmalloc, vmalloc, kvmalloc).

The tests include:
Basic allocation tests for each allocator using a 1024-byte Blob
structure initialized with a 0xfe pattern.
Large alignment (> PAGE_SIZE) allocation testing using an 8192-byte
aligned LargeAlignBlob structure.
Verification of allocation constraints:
- kmalloc successfully handles large alignments.
- vmalloc and kvmalloc correctly fail for unsupported large alignments.
Content verification through byte-by-byte pattern checking.

Co-developed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
---
 rust/kernel/alloc/allocator.rs | 57 ++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocator.rs
index aa2dfa9dca4c..430d1f664fdf 100644
--- a/rust/kernel/alloc/allocator.rs
+++ b/rust/kernel/alloc/allocator.rs
@@ -187,3 +187,60 @@ unsafe fn realloc(
         unsafe { ReallocFunc::KVREALLOC.call(ptr, layout, old_layout, flags) }
     }
 }
+
+#[macros::kunit_tests(rust_allocator_kunit)]
+mod tests {
+    use super::*;
+    use kernel::prelude::*;
+
+    const TEST_SIZE: usize = 1024;
+    const LARGE_ALIGN_TEST_SIZE: usize = kernel::page::PAGE_SIZE * 4;
+    #[repr(align(128))]
+    struct Blob([u8; TEST_SIZE]);
+    // This structure is used to test the allocation of alignments larger
+    // than PAGE_SIZE.
+    // Since this is not yet supported, avoid accessing the contents of
+    // the structure for now.
+    #[allow(dead_code)]
+    #[repr(align(8192))]
+    struct LargeAlignBlob([u8; LARGE_ALIGN_TEST_SIZE]);
+
+    #[test]
+    fn test_kmalloc() -> Result<(), AllocError> {
+        let blob = KBox::new(Blob([0xfeu8; TEST_SIZE]), GFP_KERNEL)?;
+        for b in blob.0.as_slice().iter() {
+            assert_eq!(*b, 0xfeu8);
+        }
+
+        let blob = KBox::new(LargeAlignBlob([0xfdu8; LARGE_ALIGN_TEST_SIZE]), GFP_KERNEL)?;
+        for b in blob.0.as_slice().iter() {
+            assert_eq!(*b, 0xfdu8);
+        }
+
+        Ok(())
+    }
+
+    #[test]
+    fn test_vmalloc() -> Result<(), AllocError> {
+        let blob = VBox::new(Blob([0xfeu8; TEST_SIZE]), GFP_KERNEL)?;
+        for b in blob.0.as_slice().iter() {
+            assert_eq!(*b, 0xfeu8);
+        }
+
+        assert!(VBox::<LargeAlignBlob>::new_uninit(GFP_KERNEL).is_err());
+
+        Ok(())
+    }
+
+    #[test]
+    fn test_kvmalloc() -> Result<(), AllocError> {
+        let blob = KVBox::new(Blob([0xfeu8; TEST_SIZE]), GFP_KERNEL)?;
+        for b in blob.0.as_slice().iter() {
+            assert_eq!(*b, 0xfeu8);
+        }
+
+        assert!(KVBox::<LargeAlignBlob>::new_uninit(GFP_KERNEL).is_err());
+
+        Ok(())
+    }
+}
-- 
2.43.0


