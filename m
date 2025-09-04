Return-Path: <linux-kernel+bounces-801648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E64BB44851
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 23:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 055B7A04E17
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 21:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43AAF2D0C79;
	Thu,  4 Sep 2025 21:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zoV5pZBM"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F3829BD92
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 21:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757020453; cv=none; b=NAfowhj5hhG5z6zILT1YfulFNTVOvd9KW0NXYZKg8ITElP/kOp958bGocuoKtQDrwPJBbSgDLMFNfnssVpmzCUE30izH+KQLJwq07vJ5hxrAWcDwxoi8uTx79yTEE6PclBMkPmHD25kyzFfJP6Ov9nHPNOoSnjmK8jIcYf2zwfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757020453; c=relaxed/simple;
	bh=IX+FmUJAsAt3bbv6WP+sppw+TzVK8DRPJvw00HnhzEY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LSN5de816wm3Th/sx2vc8eT3XDYBnjSnHxCcIqA7HHcGMN1QjC0PVmPuyu0kkj6GN7PN/lhEmApGJ2k8r6xmdTxtSrLK3g+BKJLDbXr2wPQCQgfrE9gMjTyTjQY5xn9oUqZcynQOHJDIltxI6zNSxH7AbVw8KgSt4UTINX5XToE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zoV5pZBM; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3234811cab3so1699766a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 14:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757020451; x=1757625251; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=arN2pmQBVtYOvUg5waEtOueGktesFqbTHbSY6edCK8Y=;
        b=zoV5pZBMjfEmoWMvwse4R8qkrAJrkPvbbmhaIxm845Ljhfed9OzicE8/JKDVdlqm9A
         y0eFhqMpwGr8AzBDwGgvTvEr015ZxlLv4edOZa4ze6ue8d/EsxYehOSjP9YncSfdecux
         ssimJOs979aStSmF0nUvwz3jhwPgbrr/a5Lrzjsv6JshHEZPFnft+H7XqEEJ1A51yfWR
         AfQgmH0GVg18mczS3a8TURLFGES/+TOHGpXMvPl5qHV/Huz9Q0r9+eKS0qP7KiYHHvfL
         s3F26BGSMLDLyxm7Kxn3HrCFJCRiKflBVxp+td3aKX1tfjCB6LbnvfuluNimNPbKYy0d
         tEow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757020451; x=1757625251;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=arN2pmQBVtYOvUg5waEtOueGktesFqbTHbSY6edCK8Y=;
        b=th3nSNFecX9WIZQHIfKFNHXIPRlujq1AQexm8R197FyOOJxFHe1deFYlaSLAeWbQ7w
         5fxGZ11V/MjBCLdKhIlGqZdcqfMxkPbf9DDzisEPq8fXiwFNRDKuug6avHugSIP8ZhwJ
         RnrWBWNAm/q92wlrNnw3zb4PT5wx41vret9C5XdwmHtso3oZ2/ktyyWqIrgJ7sDGi4E3
         ghUMjtK4zuSDvciJaBDOko/3SKMbkiQWeC3bK+6p05LXnqL5Z1zgUAT8503F1hAir64v
         3QrZmw59h2KQdbMFa6a+g53QQ+qkvgUOQN4+s1KNgo+2ilBwvz1HYHUW3SJV5zf798jk
         N+gw==
X-Gm-Message-State: AOJu0YyWQfGqI0JVZiw87Xtdhxly23SOzHBaotBPcu3aXoX16sxYQnxg
	Sf7VwO1IeOaLxoeoL2nnqkO2j5V0CXO+G67uIe301RxpRcAdHJ1Zx3s/5+ti1TIC2VL0bIC+FLz
	KJ9KbZbm6gQ==
X-Google-Smtp-Source: AGHT+IGAgAM+cMeURLjfyTSd3DY3sRO4QhH61uz52v0RlipIbIDIiNT3/8p2I/kKs4JfuGm3wPmrDUpj6CNx
X-Received: from pjbsl12.prod.google.com ([2002:a17:90b:2e0c:b0:32b:61c4:e48b])
 (user=mmaurer job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1b0d:b0:32b:bc2c:f9fd
 with SMTP id 98e67ed59e1d1-32bbc2cfd32mr1255448a91.24.1757020450800; Thu, 04
 Sep 2025 14:14:10 -0700 (PDT)
Date: Thu, 04 Sep 2025 21:13:56 +0000
In-Reply-To: <20250904-debugfs-rust-v11-0-7d12a165685a@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904-debugfs-rust-v11-0-7d12a165685a@google.com>
X-Developer-Key: i=mmaurer@google.com; a=ed25519; pk=2Ezhl7+fEjTOMVFpplDeak2AdQ8cjJieLRVJdNzrW+E=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757020440; l=7445;
 i=mmaurer@google.com; s=20250429; h=from:subject:message-id;
 bh=IX+FmUJAsAt3bbv6WP+sppw+TzVK8DRPJvw00HnhzEY=; b=WIjuHal8JPzrlTATTMgG7QCC701Z6YtD5hkSb1UaUNhCrvBGdxIBURre06/pLD+tg6sy0M+OT
 p082DNgLNfLC2S0n0yJ6Gf/6LQ2C7vCpyJAysUK+AM6n08SlbAij80Y
X-Mailer: b4 0.14.2
Message-ID: <20250904-debugfs-rust-v11-5-7d12a165685a@google.com>
Subject: [PATCH v11 5/7] samples: rust: Add debugfs sample driver
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
2.51.0.355.g5224444f11-goog


