Return-Path: <linux-kernel+bounces-776614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E565B2CF91
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 00:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93F641BC1CA3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 22:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BDF6274B42;
	Tue, 19 Aug 2025 22:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RmKSj6G+"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71007270EDF
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 22:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755644035; cv=none; b=rKk09K1CSaZdnNHppaGq5hbD6qG8qXYg7hbKRTbI8XhZnkqRQHUHrwPZ0QMwzJSIhaHAJZSUQwelnQPSWHTHjwGEGxfnWUiui+fZvVFTJFLiSr0Je1awkpwwGxhEexGHJEIMOVU7wnQn2MeE4Iq9DjV/YYBaQJ089EFbycnhg2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755644035; c=relaxed/simple;
	bh=ZpGc70QPrrtvElfWXJhaEH++kUb3knJDS/UdBQgrwLI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u6kVJTSrpKGd+F5TmF38iZO9gBuC8SgMHKrXQKCNe+aszY55o9Yywb1zcrkbAZ1N03j2sUexMBlmHX+SZozjNkkv1Qgv4gapi4WC+rtuhmZl24Rk8+yWLZNarLPZmFBG//dXfCNaeNNF2Hiy59jo/pDTKcGO6wPgtbbayrYwohg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RmKSj6G+; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-24458345f5dso62707005ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 15:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755644033; x=1756248833; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/SLswo1lDFjuBwXI2bgASbVb3tblBIglQLwWcu6IbpU=;
        b=RmKSj6G+XGEyqQNhdjkcAntzd2bMR99tiG0DmQfmWPxUBxgcEPCGAgr9wCF0ZaclBW
         K9SYZ4ik0cPKoRLtl6qPtyKCGoU2YCwAurbeqz+AB+/T/VytoW1GG+qpySy4XaCJPgwU
         v6S0zB9oiVUYo/1QrVc4nIgUq9Ne2KnnIxKGr1viJyspymjztV3QdUsO20KsrTKQpfB5
         OkpWykZWesYs/wS4i2uRPwQwY6FnU1D8Rps90DTsr/u2qvMXJOpLJ76HulymAO+EcAvQ
         BtJ6zOGLtuPbKcxZcMH3hEQkkqCj1zBOKzwaVzZkhuA/aP2P4eIsHyPX6PMDPjzpZACN
         g5Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755644033; x=1756248833;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/SLswo1lDFjuBwXI2bgASbVb3tblBIglQLwWcu6IbpU=;
        b=cH21QF51ot+rAJCKwFjlx9Au0pkPSmNE+I90HTg/xug0Y5ZPXZiXwPeaKPsQ2ZB2Ff
         bFqH1VZjjrPAz/JgOP/ukUmeeECopY58CNmdU5leVLdlFwzE0MeChPNAWZIdItw42K6q
         XwJCvzpaO/qZASyCH7qdyGKbiFfndaxl5FkzHiHEo8Rrb88lwm5O1AwNbFm3XLeM/ITu
         zSFmhRLY4cE8KASg4wHOgk7Rh+SLmSr643YGSa04+X1I+zmkz2kXyyMUoIsn+iaajAWL
         35yMHr/2PlBfGLzCehdCEo55vXsE7Hv1+wVk7Z5ixJFnaAVNekO0DJqEQCDQX/a2J6g6
         4p9A==
X-Gm-Message-State: AOJu0YzKAtag/X6rIZffu6kWeR5myafgZKNS3adETEyJR53oQXVpQRMd
	Un3lRYoJ4JHvXy5CSCeBg2O44q5FvwTRxa9Rmifyl4JW9zpoJDGDHn+6WanjVnn06Q2knexi/zm
	/wBMlogH0EQ==
X-Google-Smtp-Source: AGHT+IE3H/SdYKRJfmy7QtD9T+6UGxj+Ps8s8uwL4nrDI/GDDg3zFTD+cehisHjgy5z9d1F23iE1jQ0Fg4Fo
X-Received: from plbmq6.prod.google.com ([2002:a17:902:fd46:b0:23f:e9a5:d20a])
 (user=mmaurer job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cec3:b0:240:70d4:85d9
 with SMTP id d9443c01a7336-245eee3fd84mr7365435ad.0.1755644032810; Tue, 19
 Aug 2025 15:53:52 -0700 (PDT)
Date: Tue, 19 Aug 2025 22:53:40 +0000
In-Reply-To: <20250819-debugfs-rust-v10-0-86e20f3cf3bb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250819-debugfs-rust-v10-0-86e20f3cf3bb@google.com>
X-Developer-Key: i=mmaurer@google.com; a=ed25519; pk=2Ezhl7+fEjTOMVFpplDeak2AdQ8cjJieLRVJdNzrW+E=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755644022; l=7449;
 i=mmaurer@google.com; s=20250429; h=from:subject:message-id;
 bh=ZpGc70QPrrtvElfWXJhaEH++kUb3knJDS/UdBQgrwLI=; b=9QmaIAstxTcrp08mXXo5Gzw9nlNHf5yZZNsJA3fvv6cPu0QlQH7XntqecATb38XL917IOyf5s
 NrO8cyphnf+BDTxJz4iw/4xFMIEIwL+toGyFlPrbtBLXsodgDk8uaHY
X-Mailer: b4 0.14.2
Message-ID: <20250819-debugfs-rust-v10-5-86e20f3cf3bb@google.com>
Subject: [PATCH v10 5/7] samples: rust: Add debugfs sample driver
From: Matthew Maurer <mmaurer@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Timur Tabi <ttabi@nvidia.com>, Benno Lossin <lossin@kernel.org>, 
	Dirk Beheme <dirk.behme@de.bosch.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Matthew Maurer <mmaurer@google.com>
Content-Type: text/plain; charset="utf-8"

Adds a new sample driver that demonstrates the debugfs APIs.

The driver creates a directory in debugfs and populates it with a few
files:
- A read-only file that displays a fwnode property.
- A read-write file that exposes an atomic counter.
- A read-write file that exposes a custom struct.

This sample serves as a basic example of how to use the `debugfs::Dir`
and `debugfs::File` APIs to create and manage debugfs entries.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 MAINTAINERS                  |   1 +
 samples/rust/Kconfig         |  11 ++++
 samples/rust/Makefile        |   1 +
 samples/rust/rust_debugfs.rs | 151 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 164 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8f2dbf71ca3f8f97e4d7619375279ed11d1261b2..5b6db584a33dd7ee39de3fdd0085d2bd7b7bef0e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7481,6 +7481,7 @@ F:	rust/kernel/devres.rs
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
index 0000000000000000000000000000000000000000..8d394f06b37e69ea1c30a3b0d8444c80562cc5ab
--- /dev/null
+++ b/samples/rust/rust_debugfs.rs
@@ -0,0 +1,151 @@
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
+//! {
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
+//! }
+//! ```
+
+use core::str::FromStr;
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
+    type: RustDebugFs,
+    name: "rust_debugfs",
+    authors: ["Matthew Maurer"],
+    description: "Rust DebugFS usage sample",
+    license: "GPL",
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
+    counter: File<AtomicUsize>,
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
+impl FromStr for Inner {
+    type Err = Error;
+    fn from_str(s: &str) -> Result<Self> {
+        let mut parts = s.split_whitespace();
+        let x = parts
+            .next()
+            .ok_or(EINVAL)?
+            .parse::<u32>()
+            .map_err(|_| EINVAL)?;
+        let y = parts
+            .next()
+            .ok_or(EINVAL)?
+            .parse::<u32>()
+            .map_err(|_| EINVAL)?;
+        if parts.next().is_some() {
+            return Err(EINVAL);
+        }
+        Ok(Inner { x, y })
+    }
+}
+
+kernel::acpi_device_table!(
+    ACPI_TABLE,
+    MODULE_ACPI_TABLE,
+    <RustDebugFs as platform::Driver>::IdInfo,
+    [(acpi::DeviceId::new(c_str!("LNUXDEBF")), ())]
+);
+
+impl platform::Driver for RustDebugFs {
+    type IdInfo = ();
+    const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = None;
+    const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = Some(&ACPI_TABLE);
+
+    fn probe(
+        pdev: &platform::Device<Core>,
+        _info: Option<&Self::IdInfo>,
+    ) -> Result<Pin<KBox<Self>>> {
+        let result = KBox::try_pin_init(RustDebugFs::new(pdev), GFP_KERNEL)?;
+        // We can still mutate fields through the files which are atomic or mutexed:
+        result.counter.store(91, Ordering::Relaxed);
+        {
+            let mut guard = result.inner.lock();
+            guard.x = guard.y;
+            guard.y = 42;
+        }
+        Ok(result)
+    }
+}
+
+impl RustDebugFs {
+    fn build_counter(dir: &Dir) -> impl PinInit<File<AtomicUsize>> + '_ {
+        dir.read_write_file(c_str!("counter"), AtomicUsize::new(0))
+    }
+
+    fn build_inner(dir: &Dir) -> impl PinInit<File<Mutex<Inner>>> + '_ {
+        dir.read_write_file(c_str!("pair"), new_mutex!(Inner { x: 3, y: 10 }))
+    }
+
+    fn new(pdev: &platform::Device<Core>) -> impl PinInit<Self, Error> + '_ {
+        let debugfs = Dir::new(c_str!("sample_debugfs"));
+        let dev = pdev.as_ref();
+
+        try_pin_init! {
+            Self {
+                _compatible <- debugfs.read_only_file(
+                    c_str!("compatible"),
+                    dev.fwnode()
+                        .ok_or(ENOENT)?
+                        .property_read::<CString>(c_str!("compatible"))
+                        .required_by(dev)?,
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
2.51.0.rc1.167.g924127e9c0-goog


