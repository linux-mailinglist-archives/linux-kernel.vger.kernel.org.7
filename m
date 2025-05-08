Return-Path: <linux-kernel+bounces-639332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E10EFAAF621
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 10:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A5EA7B374C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 08:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEACD264FB8;
	Thu,  8 May 2025 08:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BOo5TH5r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1781239E95;
	Thu,  8 May 2025 08:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746694388; cv=none; b=QPnNAw0ouPGUYozT07b2boux0f6U8bpS8WOGWBQ63qqPct2NuqhZeyO9v7nm5wolEDruvndTFlGUmsdy8wINMS9ZdeDmdit1Oqj6oH7R7+6Jth8UWPShI5hDI1HE7jR0HYqYMhdw6F8IriSaF1xDr2n+HQ4bgFuJNneyUnU4lv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746694388; c=relaxed/simple;
	bh=15IRdWQGob8rEQnCZVjyZFm4/ckUzAPLo90k4EdjFYg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PpqN7drPXpYzr+9+ecUmCr9NSiaO1B/0BAM7/Aa8jRl05aat5vrZ6LuTKOJfLVBYg1HFdzYcOQ9+IBQRUR1FfNIm6C1W772Z/DT1YZHH6UOOj/UdciYrxLHymvnk5RMYUs18OysL05rUJ0xuWBnbz/8WpDkp05lEuib0riRMkXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BOo5TH5r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9908C4CEE7;
	Thu,  8 May 2025 08:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746694387;
	bh=15IRdWQGob8rEQnCZVjyZFm4/ckUzAPLo90k4EdjFYg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BOo5TH5rZLDF377GP/txciNaj/WL3toVq85kPL0zkROzRADJ1GUJ1LjlrY90h4gyC
	 F9zrwJzYtX06/wlyaiw8SBphq4FlavLQsczBFqa66pqDUBMgosWvgTRUuRaGfZoP3Q
	 9NdaL15bgbIX7veaLzcxjV10002mdkrFQE0fTeEgKd/jH+yL3a2slsNvt3SAb9DSXQ
	 Jbz9VhxioJNBnO3ys8NqpQLblU7r4nui9TqxpKgRVtiddQwFF/0etAWOIc03bMugLF
	 GnQPk9C2DIsOBBlR8F87H/3YrJEGIpA2L8fDaJyBouHUH7asGUNtxLIjGsvDIvmC/D
	 iWKMiJtclmRPg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Thu, 08 May 2025 10:52:10 +0200
Subject: [PATCH v8 2/3] rust: configfs: add a sample demonstrating configfs
 usage
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250508-configfs-v8-2-8ebde6180edc@kernel.org>
References: <20250508-configfs-v8-0-8ebde6180edc@kernel.org>
In-Reply-To: <20250508-configfs-v8-0-8ebde6180edc@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Joel Becker <jlbec@evilplan.org>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
 Fiona Behrens <me@kloenk.dev>, 
 Charalampos Mitrodimas <charmitro@posteo.net>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Breno Leitao <leitao@debian.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7524; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=15IRdWQGob8rEQnCZVjyZFm4/ckUzAPLo90k4EdjFYg=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBoHHDKL6c6pQQoRsx8uZzhaYVf4qA4WVS8zVa8B
 lVThMr23iSJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaBxwygAKCRDhuBo+eShj
 d7sWEAChED/w+wldOgABtlHqB6ECLbtBYbMU8NPxWkW0UmHUNBLdyWSAH0ytJikNfr2C9drjnrg
 G0grYcTbCYSKYvShHBJx8Ixx97ry1LI+idPbov7bVinok/3thPmvH7vUBFNGor046kKm68w6kvp
 e/x2zOtyNULIfWObpXw5rvQPF70H7s+M/9kKjTJWj1U/yQHJW76C8LVQhkXgN1UC4HoF2qpHYxA
 VccPtLUVlNWXgM74+zCiGH1j7nIIrE0TLkxxc8rQlvtQ45YbIPidqU7V31SXCoDe8lVfNV34roC
 yQFfNCWRfUdqCZATBVa56pxjQSi0355r7Q0d3i+SFOvPb+UcelBAFGw/wp+oz+8Mcf9vKXDvBMT
 9ld/fWU0Nx5VStN2bBNWL+R7DlPdlVdgKVH5FwTNnBwuFyp5WVuHEFAsgjG/zEXSPfCdZWKAGxB
 Ce2MaMBp3zK/bBPmeh6/w/L6CGtLlHjrOMxUmPP4luiZs9TiC39ZQS+RV8ul6GPcvQcKcxzLj/Q
 qSsTufv1KE6Q2C6Ovmi9dRh/bqbsJURcJcDku57920CDfJV2tw9aTFNIGGDmfT3VvMsxpjyFM11
 8F/XWF6CiU6uTAN56ScqYoXKiWm3MkdPqJi0pTrGBfWCoyRFU4qOLJ4MTid/CgJ8YA0mD8RBVjL
 FcFfylzSub8Trew==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add a sample to the samples folder, demonstrating the intended use of the
Rust configfs API.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 samples/rust/Kconfig          |  11 +++
 samples/rust/Makefile         |   1 +
 samples/rust/rust_configfs.rs | 192 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 204 insertions(+)

diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
index cad52b7120b5143e85d737234be4ff27d2c7f99f..be491ad9b3af1b21d5c1d6000ef6c5488f9c5e91 100644
--- a/samples/rust/Kconfig
+++ b/samples/rust/Kconfig
@@ -10,6 +10,17 @@ menuconfig SAMPLES_RUST
 
 if SAMPLES_RUST
 
+config SAMPLE_RUST_CONFIGFS
+	tristate "Configfs sample"
+	depends on CONFIGFS_FS
+	help
+	  This option builds the Rust configfs sample.
+
+	  To compile this as a module, choose M here:
+	  the module will be called rust_configfs.
+
+	  If unsure, say N.
+
 config SAMPLE_RUST_MINIMAL
 	tristate "Minimal"
 	help
diff --git a/samples/rust/Makefile b/samples/rust/Makefile
index c6a2479f7d9cf3a8695fa08b33b71d0df077eb59..b3c9178d654afed5c9553b1b6fa91ae8736c316e 100644
--- a/samples/rust/Makefile
+++ b/samples/rust/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_SAMPLE_RUST_DMA)			+= rust_dma.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_PCI)		+= rust_driver_pci.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_PLATFORM)	+= rust_driver_platform.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_FAUX)		+= rust_driver_faux.o
+obj-$(CONFIG_SAMPLE_RUST_CONFIGFS)		+= rust_configfs.o
 
 rust_print-y := rust_print_main.o rust_print_events.o
 
diff --git a/samples/rust/rust_configfs.rs b/samples/rust/rust_configfs.rs
new file mode 100644
index 0000000000000000000000000000000000000000..60ddbe62cda31465f799f1c15f92bdc88f855830
--- /dev/null
+++ b/samples/rust/rust_configfs.rs
@@ -0,0 +1,192 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust configfs sample.
+
+use kernel::alloc::flags;
+use kernel::c_str;
+use kernel::configfs;
+use kernel::configfs_attrs;
+use kernel::new_mutex;
+use kernel::page::PAGE_SIZE;
+use kernel::prelude::*;
+use kernel::sync::Mutex;
+
+module! {
+    type: RustConfigfs,
+    name: "rust_configfs",
+    author: "Rust for Linux Contributors",
+    description: "Rust configfs sample",
+    license: "GPL",
+}
+
+#[pin_data]
+struct RustConfigfs {
+    #[pin]
+    config: configfs::Subsystem<Configuration>,
+}
+
+#[pin_data]
+struct Configuration {
+    message: &'static CStr,
+    #[pin]
+    bar: Mutex<(KBox<[u8; PAGE_SIZE]>, usize)>,
+}
+
+impl Configuration {
+    fn new() -> impl PinInit<Self, Error> {
+        try_pin_init!(Self {
+            message: c_str!("Hello World\n"),
+            bar <- new_mutex!((KBox::new([0; PAGE_SIZE], flags::GFP_KERNEL)?, 0)),
+        })
+    }
+}
+
+impl kernel::InPlaceModule for RustConfigfs {
+    fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
+        pr_info!("Rust configfs sample (init)\n");
+
+        // Define a subsystem with the data type `Configuration`, two
+        // attributes, `message` and `bar` and child group type `Child`. `mkdir`
+        // in the directory representing this subsystem will create directories
+        // backed by the `Child` type.
+        let item_type = configfs_attrs! {
+            container: configfs::Subsystem<Configuration>,
+            data: Configuration,
+            child: Child,
+            attributes: [
+                message: 0,
+                bar: 1,
+            ],
+        };
+
+        try_pin_init!(Self {
+            config <- configfs::Subsystem::new(
+                c_str!("rust_configfs"), item_type, Configuration::new()
+            ),
+        })
+    }
+}
+
+#[vtable]
+impl configfs::GroupOperations for Configuration {
+    type Child = Child;
+
+    fn make_group(&self, name: &CStr) -> Result<impl PinInit<configfs::Group<Child>, Error>> {
+        // Define a group with data type `Child`, one attribute `baz` and child
+        // group type `GrandChild`. `mkdir` in the directory representing this
+        // group will create directories backed by the `GrandChild` type.
+        let tpe = configfs_attrs! {
+            container: configfs::Group<Child>,
+            data: Child,
+            child: GrandChild,
+            attributes: [
+                baz: 0,
+            ],
+        };
+
+        Ok(configfs::Group::new(name.try_into()?, tpe, Child::new()))
+    }
+}
+
+#[vtable]
+impl configfs::AttributeOperations<0> for Configuration {
+    type Data = Configuration;
+
+    fn show(container: &Configuration, page: &mut [u8; PAGE_SIZE]) -> Result<usize> {
+        pr_info!("Show message\n");
+        let data = container.message;
+        page[0..data.len()].copy_from_slice(data);
+        Ok(data.len())
+    }
+}
+
+#[vtable]
+impl configfs::AttributeOperations<1> for Configuration {
+    type Data = Configuration;
+
+    fn show(container: &Configuration, page: &mut [u8; PAGE_SIZE]) -> Result<usize> {
+        pr_info!("Show bar\n");
+        let guard = container.bar.lock();
+        let data = guard.0.as_slice();
+        let len = guard.1;
+        page[0..len].copy_from_slice(&data[0..len]);
+        Ok(len)
+    }
+
+    fn store(container: &Configuration, page: &[u8]) -> Result {
+        pr_info!("Store bar\n");
+        let mut guard = container.bar.lock();
+        guard.0[0..page.len()].copy_from_slice(page);
+        guard.1 = page.len();
+        Ok(())
+    }
+}
+
+// `pin_data` cannot handle structs without braces.
+#[pin_data]
+struct Child {}
+
+impl Child {
+    fn new() -> impl PinInit<Self, Error> {
+        try_pin_init!(Self {})
+    }
+}
+
+#[vtable]
+impl configfs::GroupOperations for Child {
+    type Child = GrandChild;
+
+    fn make_group(&self, name: &CStr) -> Result<impl PinInit<configfs::Group<GrandChild>, Error>> {
+        // Define a group with data type `GrandChild`, one attribute `gc`. As no
+        // child type is specified, it will not be possible to create subgroups
+        // in this group, and `mkdir`in the directory representing this group
+        // will return an error.
+        let tpe = configfs_attrs! {
+            container: configfs::Group<GrandChild>,
+            data: GrandChild,
+            attributes: [
+                gc: 0,
+            ],
+        };
+
+        Ok(configfs::Group::new(
+            name.try_into()?,
+            tpe,
+            GrandChild::new(),
+        ))
+    }
+}
+
+#[vtable]
+impl configfs::AttributeOperations<0> for Child {
+    type Data = Child;
+
+    fn show(_container: &Child, page: &mut [u8; PAGE_SIZE]) -> Result<usize> {
+        pr_info!("Show baz\n");
+        let data = c"Hello Baz\n".to_bytes();
+        page[0..data.len()].copy_from_slice(data);
+        Ok(data.len())
+    }
+}
+
+// `pin_data` cannot handle structs without braces.
+#[pin_data]
+struct GrandChild {}
+
+impl GrandChild {
+    fn new() -> impl PinInit<Self, Error> {
+        try_pin_init!(Self {})
+    }
+}
+
+#[vtable]
+impl configfs::AttributeOperations<0> for GrandChild {
+    type Data = GrandChild;
+
+    fn show(_container: &GrandChild, page: &mut [u8; PAGE_SIZE]) -> Result<usize> {
+        pr_info!("Show grand child\n");
+        let data = c"Hello GC\n".to_bytes();
+        page[0..data.len()].copy_from_slice(data);
+        Ok(data.len())
+    }
+}

-- 
2.47.2



