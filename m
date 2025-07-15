Return-Path: <linux-kernel+bounces-731627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED9EB05759
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 12:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04DB3563436
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 10:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28FE23BD0B;
	Tue, 15 Jul 2025 10:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nSpT6uLY"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0CB26FDA8
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 10:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752573630; cv=none; b=ayEAQ+qCWAfZbcMZiW6Ldm6f5egGWg5n8YXSvWJ6Miy/NS+GjO+NLqrRvBo7Y750bKkSfOVeFeb98AdGiOJtjIKwjDfNERMBPzYL8j8BwYhXDQbCRuUljz2Xids/DSffky4bw+Tqxj0WcX6ysU1UMo7+IJkU/Ad/Ls/wFXQpu5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752573630; c=relaxed/simple;
	bh=ZW3RqUJQuINLZ2qkCDUQ3IViyrhHhK2qpkUxP/3iNF4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D+PQeWXnWerfR9vzEPotGbgH8jXHbnfTUETk1xjAjzPze6/rx08r6QONJrTaV4T9Y54YRbhGmLeyYgeS7BKxsfvLywbyZvNG3UaFDHxUtCEjOoZs1SWWasgGL4JYngQ2+BVKnbiiKsdeAGR7bcWXoiMuHFrlhefiaOqXFJicMes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nSpT6uLY; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752573626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0hMXD4Bvb1YUfWztWBUy/WVwu1WJGbTx3ryS1MpxlDU=;
	b=nSpT6uLYE5l6za43VDR0XD6aFfHyA9chbD/+oRLXEvpAOhjkomitJTy5toxr/PXV1urzDF
	sRuFnKpIof8teSp/n5zjeybvYwzdwtuRcs6T5OEWkRXO0fSEBTwSwLhuOrq0i7f9Ms8I+Q
	kE7a/y0hwYE+jXc88x75fob7giS9KxQ=
From: Hui Zhu <hui.zhu@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
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
	Danilo Krummrich <dakr@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Hui Zhu <zhuhui@kylinos.cn>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	rust-for-linux@vger.kernel.org
Subject: [PATCH 3/3] rust: add a sample allocator usage
Date: Tue, 15 Jul 2025 17:59:48 +0800
Message-Id: <ea067b4df1cef7f724a9e8ef0d345087f06ad6a7.1752573305.git.zhuhui@kylinos.cn>
In-Reply-To: <cover.1752573305.git.zhuhui@kylinos.cn>
References: <cover.1752573305.git.zhuhui@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hui Zhu <zhuhui@kylinos.cn>

Add a sample to the samples memory allocator usage.

Co-developed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
---
 samples/rust/Kconfig           |  10 ++++
 samples/rust/Makefile          |   1 +
 samples/rust/rust_allocator.rs | 104 +++++++++++++++++++++++++++++++++
 3 files changed, 115 insertions(+)
 create mode 100644 samples/rust/rust_allocator.rs

diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
index 7f7371a004ee..79c73f6c5216 100644
--- a/samples/rust/Kconfig
+++ b/samples/rust/Kconfig
@@ -105,6 +105,16 @@ config SAMPLE_RUST_DRIVER_AUXILIARY
 
 	  If unsure, say N.
 
+config SAMPLE_RUST_ALLOCATOR
+	tristate "Allocator Test Driver"
+	help
+	  This option builds the Rust allocator Test driver sample.
+
+	  To compile this as a module, choose M here:
+	  the module will be called rust_dma.
+
+	  If unsure, say N.
+
 config SAMPLE_RUST_HOSTPROGS
 	bool "Host programs"
 	help
diff --git a/samples/rust/Makefile b/samples/rust/Makefile
index bd2faad63b4f..b378959eab19 100644
--- a/samples/rust/Makefile
+++ b/samples/rust/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_SAMPLE_RUST_DRIVER_PLATFORM)	+= rust_driver_platform.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_FAUX)		+= rust_driver_faux.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_AUXILIARY)	+= rust_driver_auxiliary.o
 obj-$(CONFIG_SAMPLE_RUST_CONFIGFS)		+= rust_configfs.o
+obj-$(CONFIG_SAMPLE_RUST_ALLOCATOR)		+= rust_allocator.o
 
 rust_print-y := rust_print_main.o rust_print_events.o
 
diff --git a/samples/rust/rust_allocator.rs b/samples/rust/rust_allocator.rs
new file mode 100644
index 000000000000..13d23cc9d682
--- /dev/null
+++ b/samples/rust/rust_allocator.rs
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (c) 2025, Kylin Software
+
+//! Rust allocator sample.
+
+use core::{alloc::Layout, ptr::NonNull};
+use kernel::alloc::allocator;
+use kernel::alloc::Allocator;
+use kernel::bindings;
+use kernel::prelude::*;
+
+module! {
+    type: RustAllocator,
+    name: "rust_allocator",
+    authors: ["Rust for Linux Contributors"],
+    description: "Rust allocator sample",
+    license: "GPL",
+}
+
+const VMALLOC_ARG: [(usize, usize); 2] = [
+    (bindings::PAGE_SIZE * 4, bindings::PAGE_SIZE * 2),
+    (1024, 128),
+];
+
+struct RustAllocator {
+    vmalloc_vec: KVec<(usize, Layout)>,
+}
+
+fn vmalloc_align(size: usize, align: usize) -> Result<(NonNull<[u8]>, Layout)> {
+    let layout = Layout::from_size_align(size, align).map_err(|_| EINVAL)?;
+
+    Ok((
+        <allocator::Vmalloc as Allocator>::alloc(layout, GFP_KERNEL).map_err(|_| EINVAL)?,
+        layout,
+    ))
+}
+
+fn vfree(addr: usize, layout: Layout) {
+    let vmalloc_ptr = NonNull::new(addr as *mut u8);
+    if let Some(ptr) = vmalloc_ptr {
+        unsafe {
+            <allocator::Vmalloc as Allocator>::free(ptr, layout);
+        }
+    } else {
+        pr_err!("Failed to vfree: pointer is null\n");
+    }
+}
+
+fn check_ptr(ptr: NonNull<[u8]>, size: usize, align: usize) -> (usize, bool) {
+    let current_size = unsafe { ptr.as_ref().len() };
+    if current_size != size {
+        pr_err!(
+            "The length to be allocated is {}, and the actually allocated memory length is {}.\n",
+            size,
+            current_size
+        );
+        return (0, false);
+    }
+
+    let addr = ptr.cast::<u8>().as_ptr() as usize;
+    debug_assert!(align.is_power_of_two());
+    if addr & (align - 1) != 0 {
+        pr_err!("Address {:#x} is not aligned with {:#x}.\n", addr, align);
+        return (0, false);
+    }
+
+    (addr, true)
+}
+
+fn clear_vmalloc_vec(v: &KVec<(usize, Layout)>) {
+    for (addr, layout) in v {
+        vfree(*addr, *layout);
+    }
+}
+
+impl kernel::Module for RustAllocator {
+    fn init(_module: &'static ThisModule) -> Result<Self> {
+        pr_info!("Rust allocator sample (init)\n");
+
+        let mut vmalloc_vec = KVec::new();
+        for (size, align) in VMALLOC_ARG {
+            let (ptr, layout) = vmalloc_align(size, align)?;
+
+            let (addr, is_ok) = check_ptr(ptr, size, align);
+            if !is_ok {
+                clear_vmalloc_vec(&vmalloc_vec);
+                return Err(EINVAL);
+            }
+
+            vmalloc_vec.push((addr, layout), GFP_KERNEL)?;
+        }
+
+        Ok(RustAllocator { vmalloc_vec })
+    }
+}
+
+impl Drop for RustAllocator {
+    fn drop(&mut self) {
+        pr_info!("Rust allocator sample (exit)\n");
+
+        clear_vmalloc_vec(&self.vmalloc_vec);
+    }
+}
-- 
2.43.0


