Return-Path: <linux-kernel+bounces-785398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15759B34A15
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 20:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D02B43B0D6C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 18:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE60330F53E;
	Mon, 25 Aug 2025 18:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="KXYrZ07n"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1DA2FE59A;
	Mon, 25 Aug 2025 18:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756145943; cv=pass; b=ER53SmcjX2MBJ7ufkTSKO7LpdS2B/gPmgramPnMnTO/OUzxCd/q7BvZxjfBuFTRjxeeF33OiP0CkBr82TUqIWv46cVpWnovjLPvqYeh6gMHAjn9OzLnSVIsukO/QVIv9P6UVYyYanXbPI/ozSUEf4VaUHONcxzVgR6qoHyhNDus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756145943; c=relaxed/simple;
	bh=3tJ9dZXgeDJgIZdsufr5ZgbRo+KGPU8NdxZcUxsMjxU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CN1wQ3EyxtXjwY7kCqOjglFKPKSBm2bSqEJHI5EZDKiwNP9hfa9aV9l6RyH5KzZ8JjgxF2lAh8QHiDDwzu4A8X2yWppi78jF6GW5zapqJe76U2qpMQ/Fckw8t+Ln1Ra05Hsbe8RpR1FJCJpQs2qo2VtZMGSYzasJ6YR9XQF/4sY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=KXYrZ07n; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1756145926; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=AQj4vhC/HjOTVaNGxD8ph0hlUJVbbuzLzDqoZmRxaB5ZyNwzktuiaAeGPykvVQFUpdZzuD8TvhimFMzNNLLNFdAgYrHHmAs+mDx2lPqjrJ8fUu6fkTUa2EwXCPcT7PG+dtaaYm0aOmnr/OALkdKlGkPZBrA9j+lOXWQuItiY9uY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756145926; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=mX0wI1lvfd3ehGoCKuBLzZQfEsvA4ksqig2rYhiSTXs=; 
	b=lsoepccTWp3R1WekBX+l1FfdISHdTvkU0a2uhceb1mD+u+dAodDHWR0s3JoJRB/26138HlCuKkgY4Dy6V8SMiEoN/wXn4S+HGxiI39GCtbX2PsfkukrsdTtlZIBu2GRZfYaWPrQz2SUANgWCVgkT6+N5ti7Ephz479IezWU46HY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756145926;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=mX0wI1lvfd3ehGoCKuBLzZQfEsvA4ksqig2rYhiSTXs=;
	b=KXYrZ07nuO8tYo052tqoE4KrZ0NX1TKWQkRVkBTy0asRhyTSFEUJPnMgzsbi58oi
	wXujpTCuC1eGiPPJ/A2uXNk+Eqv64B6UcvHlobuxmIASLFgQ3Vs2MgFyWH9dgA658p3
	NtKQMWSr5RFe0JVdtvCwDuVCk9neM0KrspUu9RYU=
Received: by mx.zohomail.com with SMTPS id 17561459252311001.394186775597;
	Mon, 25 Aug 2025 11:18:45 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Mon, 25 Aug 2025 15:18:06 -0300
Subject: [PATCH 2/2] samples: rust: add a USB driver sample
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-b4-usb-v1-2-7aa024de7ae8@collabora.com>
References: <20250825-b4-usb-v1-0-7aa024de7ae8@collabora.com>
In-Reply-To: <20250825-b4-usb-v1-0-7aa024de7ae8@collabora.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-usb@vger.kernel.org, Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.14.2
X-ZohoMailClient: External

In light of the newly-added Rust abstractions for USB devices and
drivers, add a sample USB rust driver that serves both to showcase what
is currently supported, as well as be the only user of the USB
abstractions for now.

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 samples/rust/Kconfig            | 11 ++++++++++
 samples/rust/Makefile           |  1 +
 samples/rust/rust_driver_usb.rs | 47 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+)

diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
index 7f7371a004ee0a8f67dca99c836596709a70c4fa..fb222f93014c921b27a8a9a4293e90a2532faa82 100644
--- a/samples/rust/Kconfig
+++ b/samples/rust/Kconfig
@@ -83,6 +83,17 @@ config SAMPLE_RUST_DRIVER_PLATFORM
 
 	  If unsure, say N.
 
+config SAMPLE_RUST_DRIVER_USB
+	tristate "USB Driver"
+	depends on USB
+	help
+	  This option builds the Rust USB driver sample.
+
+	  To compile this as a module, choose M here:
+	  the module will be called rust_driver_usb.
+
+	  If unsure, say N.
+
 config SAMPLE_RUST_DRIVER_FAUX
 	tristate "Faux Driver"
 	help
diff --git a/samples/rust/Makefile b/samples/rust/Makefile
index bd2faad63b4f3befe7d1ed5139fe25c7a8b6d7f6..4e7df8a5cd277d101920c4b89a3ac6648b372b28 100644
--- a/samples/rust/Makefile
+++ b/samples/rust/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_SAMPLE_RUST_PRINT)			+= rust_print.o
 obj-$(CONFIG_SAMPLE_RUST_DMA)			+= rust_dma.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_PCI)		+= rust_driver_pci.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_PLATFORM)	+= rust_driver_platform.o
+obj-$(CONFIG_SAMPLE_RUST_DRIVER_USB)		+= rust_driver_usb.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_FAUX)		+= rust_driver_faux.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_AUXILIARY)	+= rust_driver_auxiliary.o
 obj-$(CONFIG_SAMPLE_RUST_CONFIGFS)		+= rust_configfs.o
diff --git a/samples/rust/rust_driver_usb.rs b/samples/rust/rust_driver_usb.rs
new file mode 100644
index 0000000000000000000000000000000000000000..5c396f421de7f972985e57af48e8a9da0c558973
--- /dev/null
+++ b/samples/rust/rust_driver_usb.rs
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright (C) 2025 Collabora Ltd.
+
+//! Rust USB driver sample.
+
+use kernel::{device, device::Core, prelude::*, sync::aref::ARef, usb};
+
+struct SampleDriver {
+    _intf: ARef<usb::Interface>,
+}
+
+kernel::usb_device_table!(
+    USB_TABLE,
+    MODULE_USB_TABLE,
+    <SampleDriver as usb::Driver>::IdInfo,
+    [(usb::DeviceId::from_id(0x1234, 0x5678), ()),]
+);
+
+impl usb::Driver for SampleDriver {
+    type IdInfo = ();
+    const ID_TABLE: usb::IdTable<Self::IdInfo> = &USB_TABLE;
+
+    fn probe(
+        intf: &usb::Interface<Core>,
+        _id: &usb::DeviceId,
+        _info: &Self::IdInfo,
+    ) -> Result<Pin<KBox<Self>>> {
+        let dev: &device::Device<Core> = intf.as_ref();
+        dev_info!(dev, "Rust USB driver sample probed\n");
+
+        let drvdata = KBox::new(Self { _intf: intf.into() }, GFP_KERNEL)?;
+        Ok(drvdata.into())
+    }
+
+    fn disconnect(intf: &usb::Interface<Core>, _data: Pin<&Self>) {
+        let dev: &device::Device<Core> = intf.as_ref();
+        dev_info!(dev, "Rust USB driver sample disconnected\n");
+    }
+}
+
+kernel::module_usb_driver! {
+    type: SampleDriver,
+    name: "rust_driver_usb",
+    authors: ["Daniel Almeida"],
+    description: "Rust USB driver sample",
+    license: "GPL v2",
+}

-- 
2.50.1


