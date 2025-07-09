Return-Path: <linux-kernel+bounces-724650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A76CFAFF56C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 01:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 553F94E410C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 23:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32F5269B08;
	Wed,  9 Jul 2025 23:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RNtO0uGB"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186FD244EA1
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 23:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752104116; cv=none; b=j4kf9z2I7R2imma0tBdLHyqED39JwTmFw6Kjpmdi1yuYT8Gh4Vv0tAmZjfYJf0eHFntp6EudJOSDIQW5kN+QACqxfgPfSwlv4MrQm0BPNJlNoT5POFSYOduzb8wmB8Qm4EAUo/OTEbb/VmetnKVGOj4+sk2/70qNVOXygjDiRgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752104116; c=relaxed/simple;
	bh=RU+jpcm+3jXM/R7Egs0R1XENSwJ50dX2hnvkpkYnVbM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tRUqGDH+RaW0MgbrWLRn30ZL2bBWTtB9fVp5vkL3MMSWCXy/b6wW1MGwEdbMhs9ANdOg85iMaTEsWt22m9+s/ZgaaG3LYYyHHfgNmOEelTzdE5zV+SpsXszhm/dsxTb0JyR9IWF1nN51/SXMIYDs12Tg2o5NBSlAyuSJ1AlsoGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RNtO0uGB; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-60b86fc4b47so2597a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 16:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752104113; x=1752708913; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qWiQAnEYHLFkU6hDE5kp2rvy2g/eJ5uVlEd2bJU+LVA=;
        b=RNtO0uGBGOfgAhWpXBF7brQ0UgH04LsBUvaaEoOaYvO7uxgOaseU5AGBgB3BJBsBNo
         P8EtHqxaa8567nXuEbHmvAKJki76wh39JIffhjvKx7L2X7NxDyinW2Vi56y30Sda6uPR
         dW4Fp9J9ErvnEPrqLpJdFnpIfY3BY6ofAPEIfcD+Fm/HinsxpaChduunSJ6YjeDlz19R
         fYv5FKTaDvwUW6J5MTbmIM6nMMzk5etIV23cCwPpiwsRn3OjrxoVbIzoHzSWS+Efbg6b
         05yBg83b3upmHZK6qluWL5DnskUTu1heXjwN+QMcEjQCZiAao9vi9Vj/UukA2LLPTVK1
         9xRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752104113; x=1752708913;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qWiQAnEYHLFkU6hDE5kp2rvy2g/eJ5uVlEd2bJU+LVA=;
        b=dJHvJ1xx18rW92DSqEjFwOxHekQE/XVJP/A1Ngv0nzjceQehff16j4d3hKuoQRiPxD
         v6+RqDtXNJj4ZC/uI1gvcrK7ZrWfzfRiFLHxwJXxNNIVNsabUCKWnsyxzvT4XwZ3LZfo
         XP7/wiNDm6Ed2X8nWrIa1mFITBwRbOAw3JKhIM8mz9Htz+8SGp9j1z0mewU6ap+5t39u
         sNe76wv5/kB0sEjTlC63Q072D+s6abykgEJvhBPOeLef+yuuIQHGH1gtGfYOwqRoKcBn
         jwziXYd5/12clFqmAViZyLYj9+Ex6D+w7ZAbDDMpk8nD3vGckk1Jm+cyFQ9agWQ9nULf
         EcpA==
X-Forwarded-Encrypted: i=1; AJvYcCVa8m6clX2b8U+I3uKl3C25oQ2GW7YWYvN+kEX5wrWSbRPHVrlqqC4IkGI8I35/bDtNO8S+p7L+JgXWrBM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj25zRas2M0IgkAwo5ycE4ARPABv5/pZ9Ayfhe2bJDr3ycdEgE
	DfDAe9jC+gqpMDT5Edb7Xy38bzfzU9Jz7pIYx2PhzfTved5eR2T8Gj/2IoLAPZR0al6G5wnpk3q
	lhritKorwiXufV31YLgf9EoL4RmTeC1tgGGihZFEZ
X-Gm-Gg: ASbGnctA/Zp+E85lX1tY6tETCQQi6QpcXHZvM3i8s8E9AmrGbzFkip6Tyr1iyGl9mYB
	OTMJs8FGKCC6BiiX6qgjP1scwULo7Fl2cRIK0NZ5JPGQymOG5PrdV/TzWBjQnefirWs0nAGqq9y
	t+skUrzVEC9k89bSraUjILIJexVS23pFoWxFl7FhytrKKok/MU4wudqeS81Q64uZsOdkfn1etzq
	Q==
X-Google-Smtp-Source: AGHT+IErSijasHaWxDAZKcdHGb84rFn+l/GYYHyMQqn288AUdzH6phbsB4mInaNJVVJxb6AFKXy5iSFSf9XNB5OZfY8=
X-Received: by 2002:a50:d742:0:b0:606:b6da:5028 with SMTP id
 4fb4d7f45d1cf-611c37eb47bmr35750a12.0.1752104113044; Wed, 09 Jul 2025
 16:35:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709-debugfs-rust-v9-0-92b9eab5a951@google.com>
 <20250709-debugfs-rust-v9-5-92b9eab5a951@google.com> <DB7UZCKSQ4G2.ZZBIWS6YJAOF@kernel.org>
In-Reply-To: <DB7UZCKSQ4G2.ZZBIWS6YJAOF@kernel.org>
From: Matthew Maurer <mmaurer@google.com>
Date: Wed, 9 Jul 2025 16:35:01 -0700
X-Gm-Features: Ac12FXxgGdYztUUvA1n-trl8yVSQzZP_PVMiUKzdW3gk35OQT4rrxcNTt1vvdQQ
Message-ID: <CAGSQo02rWt1nDOMeMXR1+nB9we59O-VR4annwrtOQSA+mWoDeA@mail.gmail.com>
Subject: Re: [PATCH v9 5/5] rust: samples: Add debugfs sample
To: Danilo Krummrich <dakr@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Timur Tabi <ttabi@nvidia.com>, Benno Lossin <lossin@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Keep it simple, Create some driver private data in probe() and export a couple
> of fields of this driver private data through debugfs.
>
> If you really want to showcase that those values can change, queue some work and
> modify the counter and / or the Inner type that is protected by a mutex.

I've included an example of what a simplified sample of the sort you
asked for might look like below. I'll include it in the updated series
unless someone wants the original functionality.

Provides an example of using the Rust DebugFS bindings.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 MAINTAINERS                  |   1 +
 samples/rust/Kconfig         |  11 +++
 samples/rust/Makefile        |   1 +
 samples/rust/rust_debugfs.rs | 136 +++++++++++++++++++++++++++++++++++
 4 files changed, 149 insertions(+)
 create mode 100644 samples/rust/rust_debugfs.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index 1427af9d9779..0d9cb77b54b4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7376,6 +7376,7 @@ F:        rust/kernel/devres.rs
 F:     rust/kernel/driver.rs
 F:     rust/kernel/faux.rs
 F:     rust/kernel/platform.rs
+F:     samples/rust/rust_debugfs.rs
 F:     samples/rust/rust_driver_platform.rs
 F:     samples/rust/rust_driver_faux.rs

diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
index 7f7371a004ee..01101db41ae3 100644
--- a/samples/rust/Kconfig
+++ b/samples/rust/Kconfig
@@ -62,6 +62,17 @@ config SAMPLE_RUST_DMA

          If unsure, say N.

+config SAMPLE_RUST_DEBUGFS
+       tristate "DebugFS Test Module"
+       depends on DEBUG_FS
+       help
+         This option builds the Rust DebugFS Test module sample.
+
+         To compile this as a module, choose M here:
+         the module will be called rust_debugfs.
+
+         If unsure, say N.
+
 config SAMPLE_RUST_DRIVER_PCI
        tristate "PCI Driver"
        depends on PCI
diff --git a/samples/rust/Makefile b/samples/rust/Makefile
index bd2faad63b4f..61276222a99f 100644
--- a/samples/rust/Makefile
+++ b/samples/rust/Makefile
@@ -4,6 +4,7 @@ ccflags-y += -I$(src)                           #
needed for trace events
 obj-$(CONFIG_SAMPLE_RUST_MINIMAL)              += rust_minimal.o
 obj-$(CONFIG_SAMPLE_RUST_MISC_DEVICE)          += rust_misc_device.o
 obj-$(CONFIG_SAMPLE_RUST_PRINT)                        += rust_print.o
+obj-$(CONFIG_SAMPLE_RUST_DEBUGFS)              += rust_debugfs.o
 obj-$(CONFIG_SAMPLE_RUST_DMA)                  += rust_dma.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_PCI)           += rust_driver_pci.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_PLATFORM)      += rust_driver_platform.o
diff --git a/samples/rust/rust_debugfs.rs b/samples/rust/rust_debugfs.rs
new file mode 100644
index 000000000000..47b337f2e960
--- /dev/null
+++ b/samples/rust/rust_debugfs.rs
@@ -0,0 +1,136 @@
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
+    // As we only hold these for drop effect (to remove the
directory/files) we have a leading
+    // underscore to indicate to the compiler that we don't expect to
use this field directly.
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
+    const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> =
Some(&ACPI_TABLE);
+
+    fn probe(
+        pdev: &platform::Device<Core>,
+        _info: Option<&Self::IdInfo>,
+    ) -> Result<Pin<KBox<Self>>> {
+        let result = KBox::try_pin_init(RustDebugFs::new(pdev), GFP_KERNEL)?;
+        // We can still mutate fields through the files which are
atomic or mutexed:
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
+    fn build_counter(dir: &Dir) -> impl PinInit<File<AtomicUsize>> + use<'_> {
+        dir.fmt_file(c_str!("counter"), AtomicUsize::new(0), &|counter, fmt| {
+            writeln!(fmt, "{}", counter.load(Ordering::Relaxed))
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
+    fn new(pdev: &platform::Device<Core>) -> impl PinInit<Self,
Error> + use<'_> {
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

