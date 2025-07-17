Return-Path: <linux-kernel+bounces-735033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68108B089C5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 11:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A91C7564ECB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 09:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D23291C3F;
	Thu, 17 Jul 2025 09:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fDCuc43a"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10C1291C24;
	Thu, 17 Jul 2025 09:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752745871; cv=none; b=fNaEQzTmDrdt3ZHtnCd7MG8N+Celm1paweG7kW71xUcgG0CgZ1xWPEUvfiunFcHHb47rzs29+oUg3SYKvKkZVjryvz1tTmz4f1HR8mz6c83TGE9CJMay+7rvZdNbMHKerA7Nx5eI/sDJWzgK5QITWDEZ73luXd1LUrB4pUqfZCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752745871; c=relaxed/simple;
	bh=gTGc9Q0kuZcvZ15PRhRvcZIH+uTuL1H6qRpJG6v8lbs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pOQ51sh2H1LVuFucHUDCLIJdrFqpVmAkCq8oFiMMbjo1Bh0Cd6L5dQgowL8AzjwxWknIPKqOQLEj9Hq4bSMbjHVTmjYZa5Teu7Z742xyZNnnEKtmMZEWEGlTYXeXkVa2znr2YYRV1nJEllvjqVlGh14oN55WES8haOX12PWmchw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fDCuc43a; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752745866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EOGwF+G8radFkFO5pwtQ/ujChSi9rE5HGRMwefiYiWE=;
	b=fDCuc43aw6jIBCqC14o+PRsWrwQPD1rCHLHFAG+i7sXn/9rGPlr0JuIga/hJrASvwkpkoc
	GA9P4l6LBEZQ7cog6GXbL3qFiwuz0HVp+CmsnAWiZUd4mtpevMWkPJ8STNfX3ftR8d06UG
	O2TKw3hpPsF3MX7+K6ec/tJjDvTAhXo=
From: Hui Zhu <hui.zhu@linux.dev>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	bjorn3_gh@protonmail.com,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: Hui Zhu <zhuhui@kylinos.cn>,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH v2] rust: add a sample alloc usage
Date: Thu, 17 Jul 2025 17:50:52 +0800
Message-Id: <20250717095053.49239-1-hui.zhu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hui Zhu <zhuhui@kylinos.cn>

Add a sample to the samples memory alloc usage.
It will samples the usage of VBox and KVec.

It also includes a test for allocating alignments larger than PAGE_SIZE
using VBox.
Since this feature is currently unsupported, it will report errors even
when successful.

Changelog:
v2:
According to the comments of Danilo, updated the commit to samples the
usage of VBox and KVec.

Co-developed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
---
 samples/rust/Kconfig       | 10 +++++
 samples/rust/Makefile      |  1 +
 samples/rust/rust_alloc.rs | 88 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 99 insertions(+)
 create mode 100644 samples/rust/rust_alloc.rs

diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
index 7f7371a004ee..03a86f819768 100644
--- a/samples/rust/Kconfig
+++ b/samples/rust/Kconfig
@@ -105,6 +105,16 @@ config SAMPLE_RUST_DRIVER_AUXILIARY
 
 	  If unsure, say N.
 
+config SAMPLE_RUST_ALLOC
+	tristate "Alloc Test Driver"
+	help
+	  This option builds the Rust alloc Test driver sample.
+
+	  To compile this as a module, choose M here:
+	  the module will be called rust_alloc.
+
+	  If unsure, say N.
+
 config SAMPLE_RUST_HOSTPROGS
 	bool "Host programs"
 	help
diff --git a/samples/rust/Makefile b/samples/rust/Makefile
index bd2faad63b4f..7c3e68d9ada5 100644
--- a/samples/rust/Makefile
+++ b/samples/rust/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_SAMPLE_RUST_DRIVER_PLATFORM)	+= rust_driver_platform.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_FAUX)		+= rust_driver_faux.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_AUXILIARY)	+= rust_driver_auxiliary.o
 obj-$(CONFIG_SAMPLE_RUST_CONFIGFS)		+= rust_configfs.o
+obj-$(CONFIG_SAMPLE_RUST_ALLOC)		+= rust_alloc.o
 
 rust_print-y := rust_print_main.o rust_print_events.o
 
diff --git a/samples/rust/rust_alloc.rs b/samples/rust/rust_alloc.rs
new file mode 100644
index 000000000000..61efde37b5f2
--- /dev/null
+++ b/samples/rust/rust_alloc.rs
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (c) 2025, Kylin Software
+
+//! Rust alloc sample.
+
+use kernel::bindings;
+use kernel::prelude::*;
+
+module! {
+    type: RustAlloc,
+    name: "rust_alloc",
+    authors: ["Rust for Linux Contributors"],
+    description: "Rust alloc sample",
+    license: "GPL",
+}
+
+const VBOX_SIZE: usize = 1024;
+const VBOX_LARGE_ALIGN: usize = bindings::PAGE_SIZE * 4;
+const KVEC_VAL: [usize; 3] = [10, 20, 30];
+
+#[repr(align(128))]
+struct VboxBlob([u8; VBOX_SIZE]);
+
+// This structure is used to test the allocation of alignments larger
+// than PAGE_SIZE.
+// Since this is not yet supported, avoid accessing the contents of
+// the structure for now.
+#[allow(dead_code)]
+#[repr(align(8192))]
+struct VboxLargeAlignBlob([u8; VBOX_LARGE_ALIGN]);
+
+struct RustAlloc {
+    vbox_blob: VBox<VboxBlob>,
+    kvec_blob: KVec<usize>,
+}
+
+fn check_align(addr: usize, align: usize) -> bool {
+    debug_assert!(align.is_power_of_two());
+    if addr & (align - 1) != 0 {
+        pr_err!("Address {:#x} is not aligned with {:#x}.\n", addr, align);
+        false
+    } else {
+        true
+    }
+}
+
+impl kernel::Module for RustAlloc {
+    fn init(_module: &'static ThisModule) -> Result<Self> {
+        pr_info!("Rust allocator sample (init)\n");
+
+        let vbox_blob = VBox::<VboxBlob>::new_uninit(GFP_KERNEL)?;
+        if !check_align(vbox_blob.as_ptr() as usize, 128) {
+            return Err(EINVAL);
+        }
+        let vbox_blob = vbox_blob.write(VboxBlob([0xfeu8; VBOX_SIZE]));
+
+        if let Ok(_) = VBox::<VboxLargeAlignBlob>::new_uninit(GFP_KERNEL) {
+            pr_err!("Allocations for VBox with alignments larger than PAGE_SIZE should fail, but here it succeeded.\n");
+            return Err(EINVAL);
+        }
+
+        let mut kvec_blob = KVec::new();
+        kvec_blob.extend_from_slice(&KVEC_VAL, GFP_KERNEL)?;
+
+        Ok(Self {
+            vbox_blob,
+            kvec_blob,
+        })
+    }
+}
+
+impl Drop for RustAlloc {
+    fn drop(&mut self) {
+        pr_info!("Rust allocator sample (exit)\n");
+
+        // check the values
+        for b in self.vbox_blob.0.as_slice().iter() {
+            if *b != 0xfeu8 {
+                pr_err!("vbox_blob contains wrong values\n");
+            }
+        }
+
+        if self.kvec_blob.as_slice() != KVEC_VAL {
+            pr_err!("kvec_blob contains wrong values\n");
+        }
+    }
+}
-- 
2.43.0


