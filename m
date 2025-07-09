Return-Path: <linux-kernel+bounces-724336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA20AFF17F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 21:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14850544A15
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 19:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28692417D9;
	Wed,  9 Jul 2025 19:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EoinKLL/"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA0124336B
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 19:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752088194; cv=none; b=Y9ZJI5z6EVQXwdOQXHmwzd4bn5tFRmrBnytqqnKC2CNU90uK6Cf9e/JcMMBsmYlWSTW3sAaPlfUUKzRBR02XTqJf10obad/Ezva5kmII5IjYIuxX5Ds9qrX8h2IGBzlaEWMOi1GnZYgnrNfevpCbuASddMiQiC9UftMMk0Y1XXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752088194; c=relaxed/simple;
	bh=AR0B3SprU80VUaI4tnKzWxLHs4hGBKduSVO4uwQ1dWg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MlLt8eRrG/agZ59nu5MbEnYCY0hdruxPNdmo1y8tsfHNyUCKfk5fcsrtav+jaTwNvorlu+0N0pRO/097XT3poHFykHg0rUm8/kfOr2snJLNRtshk2x3KhhrQskdrLl2z5g4wMLd6Ad1Ex5MJdOstAOK+KLvBeVOqx57UveFaG9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EoinKLL/; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-23dc7d3e708so963875ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 12:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752088192; x=1752692992; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vxBPqQEUhgd0jy+znq+ym2P4RbM+yShsSJqD7O7h4bQ=;
        b=EoinKLL/vxA525phTgQ00WlUkYQ6CENIze1roRMZSW9/V+Bjw8dMDuFYYHo1yWDz6R
         bECXYhH+wua7R4YVbIa1UpgcEIseBUHXL2LuROlqcyAzn1ucwCiialRiJ05c1J9UjG+R
         IzFrs4kuArvZfVtxOvb28+BCK/ZKkfBeIEO0bAeizfHDOgTeujO2FzUj8EYdyCtfKrp/
         lGRGWDH9mbVl4pw4yxcYnuiYPIHL7YFVBLQMb0o28XvaE2VewPFtZbovKv8Bxi3l7r1s
         PRlZQ4hDpT5yl2zl1Uee9hI9FTaahwPcNyaU90RQ1XMsjKkvo9/fOZe1grjBozV8T5ie
         x+Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752088192; x=1752692992;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vxBPqQEUhgd0jy+znq+ym2P4RbM+yShsSJqD7O7h4bQ=;
        b=vL/Yp02KRm5MFYbOlaTUQ1iqTbE5S1a9bsxT1nINZPjUXvSRLh6gOiA26FHTv4fgD6
         5o1yMSZeurUlmhXzt2N7mZ3yKl2qoZGH1jRJAOdVL+p5HIC80BCrzEku3yCejf9IlzOr
         za+1g4QM0NjaIyNSgfLC4syS9NehKfF3UfTIEvIwzelot2uUxxNnmAFGadG1g1pKJd5q
         Yq8lcOzvIkebM4300pdeVDql5/AKXhPVa7WkqIzsLuTbfpOsfrb0Cx4K1e8+nfSQltQa
         mB/RGKS3/ikDCMAAVSeWY6VLLp0+cD28gBnf6dmzTvE0bMGUGRT8xLFnR3OzThxoXgjo
         IoHA==
X-Gm-Message-State: AOJu0YzNygqxzAsXMw8EQDvTpSdxNaxDFDg6sWLlsMlOYC9giegyMrYA
	ST7KT5XDg4lRmvAejrvQvCQmISnfEHucoAVxMz9DUATw+QI83IqcpqWv2V7cXjebob/KK8hvkQP
	trArD3KzCFw==
X-Google-Smtp-Source: AGHT+IHyHsQrHTD6Qk6o6qOwYHWyJ1p0XxWiWzJNGaE5RYZ2PCyNLexaz4jFcSo4K6HpvzF2n/10ueZQwOY3
X-Received: from plblg14.prod.google.com ([2002:a17:902:fb8e:b0:235:f4e3:ba29])
 (user=mmaurer job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e885:b0:234:d399:f948
 with SMTP id d9443c01a7336-23ddb2f1a47mr58637115ad.33.1752088192329; Wed, 09
 Jul 2025 12:09:52 -0700 (PDT)
Date: Wed, 09 Jul 2025 19:09:32 +0000
In-Reply-To: <20250709-debugfs-rust-v9-0-92b9eab5a951@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250709-debugfs-rust-v9-0-92b9eab5a951@google.com>
X-Developer-Key: i=mmaurer@google.com; a=ed25519; pk=2Ezhl7+fEjTOMVFpplDeak2AdQ8cjJieLRVJdNzrW+E=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752088183; l=8478;
 i=mmaurer@google.com; s=20250429; h=from:subject:message-id;
 bh=AR0B3SprU80VUaI4tnKzWxLHs4hGBKduSVO4uwQ1dWg=; b=FGLdEjOdFMaYqdf9QqUzH0XSvY2yutpAM4KSEPX7j36Dz+KRnCFXzR4SFgHk3vkrvnXvz1Cu+
 CMsWBia64ffBUR1mXfCNQYKEO6Rz0IdZKVMbh29I66TqftxEHi5w84p
X-Mailer: b4 0.14.2
Message-ID: <20250709-debugfs-rust-v9-5-92b9eab5a951@google.com>
Subject: [PATCH v9 5/5] rust: samples: Add debugfs sample
From: Matthew Maurer <mmaurer@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Timur Tabi <ttabi@nvidia.com>, Benno Lossin <lossin@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Matthew Maurer <mmaurer@google.com>
Content-Type: text/plain; charset="utf-8"

Provides an example of using the Rust DebugFS bindings.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 MAINTAINERS                  |   1 +
 samples/rust/Kconfig         |  11 +++
 samples/rust/Makefile        |   1 +
 samples/rust/rust_debugfs.rs | 182 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 195 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1427af9d9779b1f6463409f4392e2900438bdc2a..0d9cb77b54b4608a0e1006ae45761ed7440495ba 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7376,6 +7376,7 @@ F:	rust/kernel/devres.rs
 F:	rust/kernel/driver.rs
 F:	rust/kernel/faux.rs
 F:	rust/kernel/platform.rs
+F:	samples/rust/rust_debugfs.rs
 F:	samples/rust/rust_driver_platform.rs
 F:	samples/rust/rust_driver_faux.rs
 
diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
index 7f7371a004ee0a8f67dca99c836596709a70c4fa..01101db41ae31b08a86d048cdd27da8ef9bb23a2 100644
--- a/samples/rust/Kconfig
+++ b/samples/rust/Kconfig
@@ -62,6 +62,17 @@ config SAMPLE_RUST_DMA
 
 	  If unsure, say N.
 
+config SAMPLE_RUST_DEBUGFS
+	tristate "DebugFS Test Module"
+	depends on DEBUG_FS
+	help
+	  This option builds the Rust DebugFS Test module sample.
+
+	  To compile this as a module, choose M here:
+	  the module will be called rust_debugfs.
+
+	  If unsure, say N.
+
 config SAMPLE_RUST_DRIVER_PCI
 	tristate "PCI Driver"
 	depends on PCI
diff --git a/samples/rust/Makefile b/samples/rust/Makefile
index bd2faad63b4f3befe7d1ed5139fe25c7a8b6d7f6..61276222a99f8cc6d7f84c26d0533b30815ebadd 100644
--- a/samples/rust/Makefile
+++ b/samples/rust/Makefile
@@ -4,6 +4,7 @@ ccflags-y += -I$(src)				# needed for trace events
 obj-$(CONFIG_SAMPLE_RUST_MINIMAL)		+= rust_minimal.o
 obj-$(CONFIG_SAMPLE_RUST_MISC_DEVICE)		+= rust_misc_device.o
 obj-$(CONFIG_SAMPLE_RUST_PRINT)			+= rust_print.o
+obj-$(CONFIG_SAMPLE_RUST_DEBUGFS)		+= rust_debugfs.o
 obj-$(CONFIG_SAMPLE_RUST_DMA)			+= rust_dma.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_PCI)		+= rust_driver_pci.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_PLATFORM)	+= rust_driver_platform.o
diff --git a/samples/rust/rust_debugfs.rs b/samples/rust/rust_debugfs.rs
new file mode 100644
index 0000000000000000000000000000000000000000..21fbf26f7ec07fabad782915046da3cdf52b03b3
--- /dev/null
+++ b/samples/rust/rust_debugfs.rs
@@ -0,0 +1,182 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2025 Google LLC.
+
+//! Sample DebugFS exporting platform driver
+//!
+//! To successfully probe this driver with ACPI, use an ssdt that looks like
+//!
+//! ```dsl
+//! DefinitionBlock ("", "SSDT", 2, "TEST", "VIRTACPI", 0x00000001)
+//!{
+//!    Scope (\_SB)
+//!    {
+//!        Device (T432)
+//!        {
+//!            Name (_HID, "LNUXDEBF")  // ACPI hardware ID to match
+//!            Name (_UID, 1)
+//!            Name (_STA, 0x0F)        // Device present, enabled
+//!            Name (_DSD, Package () { // Sample attribute
+//!                ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
+//!                Package() {
+//!                    Package(2) {"compatible", "sample-debugfs"}
+//!                }
+//!            })
+//!            Name (_CRS, ResourceTemplate ()
+//!            {
+//!                Memory32Fixed (ReadWrite, 0xFED00000, 0x1000)
+//!            })
+//!        }
+//!    }
+//!}
+//! ```
+
+use core::sync::atomic::AtomicUsize;
+use core::sync::atomic::Ordering;
+use kernel::c_str;
+use kernel::debugfs::{Dir, File};
+use kernel::new_mutex;
+use kernel::prelude::*;
+use kernel::sync::Mutex;
+
+use kernel::{acpi, device::Core, of, platform, str::CString, types::ARef};
+
+kernel::module_platform_driver! {
+    type: Wrapper,
+    name: "rust_debugfs",
+    authors: ["Matthew Maurer"],
+    description: "Rust DebugFS usage sample",
+    license: "GPL",
+}
+
+// This data structure would be unlikely to be there in a real driver - it's to hook up mutation
+// that would normally be driven by whatever the driver was actually servicing and show how that
+// would work. We're assuming here that those methods would have access to a `&RustDebugFs`.
+#[pin_data]
+struct Wrapper {
+    _dir: Dir,
+    #[pin]
+    _wrapped: File<File<RustDebugFs>>,
+}
+
+#[pin_data]
+struct RustDebugFs {
+    pdev: ARef<platform::Device>,
+    // As we only hold these for drop effect (to remove the directory/files) we have a leading
+    // underscore to indicate to the compiler that we don't expect to use this field directly.
+    _debugfs: Dir,
+    #[pin]
+    _compatible: File<CString>,
+    #[pin]
+    counter: File<File<AtomicUsize>>,
+    #[pin]
+    inner: File<Mutex<Inner>>,
+}
+
+#[derive(Debug)]
+struct Inner {
+    x: u32,
+    y: u32,
+}
+
+kernel::of_device_table!(
+    OF_TABLE,
+    MODULE_OF_TABLE,
+    <Wrapper as platform::Driver>::IdInfo,
+    [(of::DeviceId::new(c_str!("test,rust-debugfs-device")), ())]
+);
+
+kernel::acpi_device_table!(
+    ACPI_TABLE,
+    MODULE_ACPI_TABLE,
+    <Wrapper as platform::Driver>::IdInfo,
+    [(acpi::DeviceId::new(c_str!("LNUXDEBF")), ())]
+);
+
+impl platform::Driver for Wrapper {
+    type IdInfo = ();
+    const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
+    const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = Some(&ACPI_TABLE);
+
+    fn probe(
+        pdev: &platform::Device<Core>,
+        _info: Option<&Self::IdInfo>,
+    ) -> Result<Pin<KBox<Self>>> {
+        KBox::try_pin_init(Wrapper::new(RustDebugFs::new(pdev)), GFP_KERNEL)
+    }
+}
+
+impl Wrapper {
+    /// This builds two debugfs files that would be unusual to exist in the real world to emulate
+    /// actions taken servicing the device. They trigger their action when the debugfs file is
+    /// opened.
+    fn build_control<I: PinInit<RustDebugFs, Error>>(
+        dir: &Dir,
+        init: I,
+    ) -> impl PinInit<File<File<RustDebugFs>>, Error> + use<'_, I> {
+        let swap = dir.fmt_file(c_str!("swap"), init, &|sample, fmt| {
+            let mut guard = sample.inner.lock();
+            let x = guard.x;
+            guard.x = guard.y;
+            guard.y = x;
+            writeln!(fmt, "Swapped!")
+        });
+
+        dir.fmt_file(c_str!("add_counter"), swap, &|sample, fmt| {
+            let mut inner = sample.inner.lock();
+            inner.x += sample.counter.load(Ordering::Relaxed) as u32;
+            writeln!(fmt, "Counter added!")
+        })
+    }
+
+    fn new<I: PinInit<RustDebugFs, Error>>(init: I) -> impl PinInit<Self, Error> + use<I> {
+        let dir = Dir::new(c_str!("sample_control"));
+        try_pin_init! {
+            Self {
+                _wrapped <- Wrapper::build_control(&dir, init),
+                _dir: dir,
+            } ? Error
+        }
+    }
+}
+
+impl RustDebugFs {
+    fn build_counter(dir: &Dir) -> impl PinInit<File<File<AtomicUsize>>> + use<'_> {
+        let counter = dir.fmt_file(c_str!("counter"), AtomicUsize::new(0), &|counter, fmt| {
+            writeln!(fmt, "{}", counter.load(Ordering::Relaxed))
+        });
+        dir.fmt_file(c_str!("inc_counter"), counter, &|counter, fmt| {
+            writeln!(fmt, "{}", counter.fetch_add(1, Ordering::Relaxed))
+        })
+    }
+
+    fn build_inner(dir: &Dir) -> impl PinInit<File<Mutex<Inner>>> + use<'_> {
+        dir.fmt_file(
+            c_str!("pair"),
+            new_mutex!(Inner { x: 3, y: 10 }),
+            &|i, fmt| writeln!(fmt, "{:?}", *i.lock()),
+        )
+    }
+
+    fn new(pdev: &platform::Device<Core>) -> impl PinInit<Self, Error> + use<'_> {
+        let debugfs = Dir::new(c_str!("sample_debugfs"));
+        let dev = pdev.as_ref();
+
+        try_pin_init! {
+            Self {
+                _compatible <- debugfs.fmt_file(
+                    c_str!("compatible"),
+                    dev.fwnode()
+                        .ok_or(ENOENT)?
+                        .property_read::<CString>(c_str!("compatible"))
+                        .required_by(dev)?,
+                    &|cs, w| writeln!(w, "{cs:?}"),
+                ),
+                counter <- Self::build_counter(&debugfs),
+                inner <- Self::build_inner(&debugfs),
+                _debugfs: debugfs,
+                pdev: pdev.into(),
+            }
+        }
+    }
+}

-- 
2.50.0.727.gbf7dc18ff4-goog


