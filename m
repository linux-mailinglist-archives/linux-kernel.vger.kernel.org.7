Return-Path: <linux-kernel+bounces-750139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8F0B157D5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 05:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E54E817F45A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 03:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905C01ACEDE;
	Wed, 30 Jul 2025 03:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YgsBfiaB"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2EA18DB27
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 03:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753846618; cv=none; b=rcbDpO1ME7susmG81D1cInZT1qC2Sm/YlqlzpmSmCsxELKpO3ogUqbtXzbc898Tf3NHg2mxOekqMQswkbv7wCK/VEnXC+Iw0u82Ax/b6OYFfVvK+od5pwGKCOtwZ/gL4qA6kivPJCfWioMx1YFVg9/uDu7iLrmXLEPwrKfNa3Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753846618; c=relaxed/simple;
	bh=HYywDqKiv34kOX7gRKWSI8RGs7zQkfd0xeZpQZkImRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iC5cBmcUfoG/TZmERATa7WgCXm21dut2OkA5bBLp9JZ0QMrxKQeWJE9jSyW/mP5Dt2XxzIA77ddmdAv1YTi320LP1kzIzGnJr2UxGcoSOYDRIy3yTgQvO0HH7dcXj5/GnUjsVyC08KfXLWWdl6Un5Rw12XAud0uA+opQvkt0EBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YgsBfiaB; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753846615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TemiC/peMt9AXLXu/qa2eGX0iZwfkiigeEqsbhADwKA=;
	b=YgsBfiaBKgpkE99wNjaWSXsRrv1aVx4bmw+eksKCziJw61zY1Ic6TJHS1kvNw3MpActYeW
	6xLkqyYpHHxe8fQNh8fp/1gpAL/hYs6qL/0FoYlxPRlwmGJEPSW9hIRXZAqfc1mPLJk1Gf
	Z3HS8YcH5U5QraBgrRTK14p06w5Ic8E=
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
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH v6 1/2] rust: allocator: add KUnit tests for alignment guarantees
Date: Wed, 30 Jul 2025 11:35:21 +0800
Message-ID: <3ad14f15b6d2639d6e998ecd03158313414b69dd.1753841900.git.zhuhui@kylinos.cn>
In-Reply-To: <cover.1753841900.git.zhuhui@kylinos.cn>
References: <cover.1753841900.git.zhuhui@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hui Zhu <zhuhui@kylinos.cn>

Add a test module to verify memory alignment guarantees for Rust kernel
allocators.
The tests cover `Kmalloc`, `Vmalloc` and `KVmalloc` allocators
with both standard and large page-aligned allocations.

Key features of the tests:
1. Creates alignment-constrained types:
   - 128-byte aligned `Blob`
   - 8192-byte (4-page) aligned `LargeAlignBlob`
2. Validates allocators using `TestAlign` helper which:
   - Checks address alignment masks
   - Supports uninitialized allocations
3. Tests all three allocators with both alignment requirements:
   - Kmalloc with 128B and 8192B
   - Vmalloc with 128B and 8192B
   - KVmalloc with 128B and 8192B

Co-developed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
---
 rust/kernel/alloc/allocator.rs | 56 ++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocator.rs
index 63f271624428..1f173038cec9 100644
--- a/rust/kernel/alloc/allocator.rs
+++ b/rust/kernel/alloc/allocator.rs
@@ -184,3 +184,59 @@ unsafe fn realloc(
         unsafe { ReallocFunc::KVREALLOC.call(ptr, layout, old_layout, flags, nid) }
     }
 }
+
+#[macros::kunit_tests(rust_allocator_kunit)]
+mod tests {
+    use super::*;
+    use core::mem::MaybeUninit;
+    use kernel::prelude::*;
+
+    #[test]
+    fn test_alignment() -> Result<()> {
+        const TEST_SIZE: usize = 1024;
+        const TEST_LARGE_ALIGN_SIZE: usize = kernel::page::PAGE_SIZE * 4;
+
+        // These two structs are used to test allocating aligned memory.
+        // they don't need to be accessed, so they're marked as dead_code.
+        #[expect(dead_code)]
+        #[repr(align(128))]
+        struct Blob([u8; TEST_SIZE]);
+        #[expect(dead_code)]
+        #[repr(align(8192))]
+        struct LargeAlignBlob([u8; TEST_LARGE_ALIGN_SIZE]);
+
+        struct TestAlign<T, A: Allocator>(Box<MaybeUninit<T>, A>);
+        impl<T, A: Allocator> TestAlign<T, A> {
+            fn new() -> Result<Self> {
+                Ok(Self(Box::<_, A>::new_uninit(GFP_KERNEL)?))
+            }
+
+            fn alignment_valid(&self, align: usize) -> bool {
+                assert!(align.is_power_of_two());
+
+                let addr = self.0.as_ptr() as usize;
+                addr & (align - 1) == 0
+            }
+        }
+
+        let ta = TestAlign::<Blob, Kmalloc>::new()?;
+        assert!(ta.alignment_valid(128));
+
+        let ta = TestAlign::<LargeAlignBlob, Kmalloc>::new()?;
+        assert!(ta.alignment_valid(8192));
+
+        let ta = TestAlign::<Blob, Vmalloc>::new()?;
+        assert!(ta.alignment_valid(128));
+
+        let ta = TestAlign::<LargeAlignBlob, Vmalloc>::new()?;
+        assert!(ta.alignment_valid(8192));
+
+        let ta = TestAlign::<Blob, KVmalloc>::new()?;
+        assert!(ta.alignment_valid(128));
+
+        let ta = TestAlign::<LargeAlignBlob, KVmalloc>::new()?;
+        assert!(ta.alignment_valid(8192));
+
+        Ok(())
+    }
+}
-- 
2.43.0


