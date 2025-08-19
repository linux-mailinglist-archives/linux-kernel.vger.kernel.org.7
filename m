Return-Path: <linux-kernel+bounces-776616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1E8B2CF93
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 00:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1A4C1C42E69
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 22:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E62D277C9A;
	Tue, 19 Aug 2025 22:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ASAlEIyU"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2A223F41F
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 22:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755644039; cv=none; b=eua1CVNHLlJwr8EM4xPo2acRduIF6uMKSwcv2J+fnZmzlYRUd38bBBsfFJikHwbaWuvo58FUAUi+DagNlLU6zkiY3CBhBpMTd+hjDgxzhS84/szhu7xW/NFNZs0m3KNNCdvjdWADVwkL9BzSGyqtcEl9FH9bxe0+Go0S/DKmRf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755644039; c=relaxed/simple;
	bh=guKkQWk0Wjy3KEPKk9viQ+9k5JCWYAdpW0xugQqvnfY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BQpmipT+uJR+P4GNYCNfho8v3dyc1QiZULWq4iRyNx2i3u8JtWNc5u0pvxiblCZ2fmbZpqEDr3RA0HLoKz4pbHsbNeSWifIRrEQcN1xvwj0VRV3ssFF7XGa3ZKlQ1y/3ickG6JDL87F1du+Cw0BkDNe9zHVhlylaIHauO0w0K28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ASAlEIyU; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24458345f5dso62707375ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 15:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755644037; x=1756248837; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=a5b7ATtWYbDHgkSUGYgdvos0SG8tLhPoIOBmVwWuj9Y=;
        b=ASAlEIyUnCLLf1PdGwc8unmgxoZTmAKjkPoesAbEh6nuTIdtOEWE+yh9UI4x39fXsi
         0OBCY44Jbq7OVVc/8t4WawYDsmc3t0teh/M9n4wa/IbxwTXwkAILEdhSe8FtBI9TKkGo
         DLfoiOgLEtHHyCjHcBZ+ePXbPgdbpZihr7sgg3ZLjShFtZnZeUH+6mABn02WHJ3l8wwp
         z2k68cw2bCyYncdUydU9CCg84uuLoDO1U5cBJ15jhn/cS33yOkNfOLBm7WyhqkSy0PD2
         VMKbHsT9lYvWnt0/ol0I+XZSTKB/pIxEJqiuT07jP0z+WrmLRZlTPhhEmMeQg2oNApAp
         Dyzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755644037; x=1756248837;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a5b7ATtWYbDHgkSUGYgdvos0SG8tLhPoIOBmVwWuj9Y=;
        b=AUqJ3tCiKW57EVjFvdPqdWQIe64EQS8OjXgFBWHpCEyl4bXG65DyXEXcvwIfDetZMO
         G5Fasy+L8lJU+t5IMRLRsjKfv5mpYeep2g0/L/1FJP8/mE4Y89uTV81sV9WE6J9ojLXI
         4fgndB9ozH5xidDGX6XMine4ZOqLfx45Jg0GKggWMClyudeaanmSuwLl1oDBW3GcB3Cw
         6MRjImvOPkFBSyIUjX67yNn240gXNdn1eqNKpo6C9O3FgimGbd5UGJFY5THkKad82VmW
         bS27K3S+H4HQ4l7mOryY1WtzRnAHJ96GiEO3g9QvkpEsiHNZP/5KVbRmY12X29aNInDx
         8aMQ==
X-Gm-Message-State: AOJu0YxOFcCzZxx5kulDfuzHFphrHG++SRVRMzcYPiiOc5rChud5O/nc
	dUSeFHI5pQUvQVJTsmCqybN4S/QCf46ILIp41Wkm1QD//dtdxrLJQE+lnT2AJi0jDf9Y+KF+dpT
	xIUjZKvXwZw==
X-Google-Smtp-Source: AGHT+IFVb5OKS4efQ9HXGY/B21B3D+QSi9OXzLMr7CD2GATBbB4apepGntwqOQXPMO28tpHljh4Xa0qkb3DQ
X-Received: from pjbsd14.prod.google.com ([2002:a17:90b:514e:b0:321:78e7:57fb])
 (user=mmaurer job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:181:b0:242:89fd:48cc
 with SMTP id d9443c01a7336-245ef25b64fmr6737275ad.50.1755644037264; Tue, 19
 Aug 2025 15:53:57 -0700 (PDT)
Date: Tue, 19 Aug 2025 22:53:42 +0000
In-Reply-To: <20250819-debugfs-rust-v10-0-86e20f3cf3bb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250819-debugfs-rust-v10-0-86e20f3cf3bb@google.com>
X-Developer-Key: i=mmaurer@google.com; a=ed25519; pk=2Ezhl7+fEjTOMVFpplDeak2AdQ8cjJieLRVJdNzrW+E=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755644022; l=7159;
 i=mmaurer@google.com; s=20250429; h=from:subject:message-id;
 bh=guKkQWk0Wjy3KEPKk9viQ+9k5JCWYAdpW0xugQqvnfY=; b=jk2cW46gmwo95KDYJcb0fC6ITVr/buzZ/KWUWFbtmsVlvWaZf4/5notCvfPMHxcEaU2Dy7/jh
 xeX1m3sFYeVCA0qaSM/V9ZmV08MirTHBWdmuAqEztjgQZag7PvA4CCb
X-Mailer: b4 0.14.2
Message-ID: <20250819-debugfs-rust-v10-7-86e20f3cf3bb@google.com>
Subject: [PATCH v10 7/7] samples: rust: Add scoped debugfs sample driver
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

Adds a new sample driver `rust_scoped_debugfs` that demonstrates the
use of the scoped debugfs APIs.

The driver creates a `control` directory with two write-only files,
`create` and `remove`. Writing a name and a series of numbers to
`create` will create a new subdirectory under a `dynamic` directory.
This new subdirectory will contain files that expose the numbers as
atomic values.

Writing a name to `remove` will remove the corresponding subdirectory
from the `dynamic` directory.

This sample serves as an example of how to use the `debugfs::Scope`
and `debugfs::ScopedDir` APIs to create and manage debugfs entries
that are tied to the lifetime of a data structure.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 MAINTAINERS                         |   1 +
 samples/rust/Kconfig                |  11 +++
 samples/rust/Makefile               |   1 +
 samples/rust/rust_scoped_debugfs.rs | 134 ++++++++++++++++++++++++++++++++++++
 4 files changed, 147 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5b6db584a33dd7ee39de3fdd0085d2bd7b7bef0e..2cbe890085dbb6a652623b38dd0eadeeaa127a94 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7482,6 +7482,7 @@ F:	rust/kernel/driver.rs
 F:	rust/kernel/faux.rs
 F:	rust/kernel/platform.rs
 F:	samples/rust/rust_debugfs.rs
+F:	samples/rust/rust_scoped_debugfs.rs
 F:	samples/rust/rust_driver_platform.rs
 F:	samples/rust/rust_driver_faux.rs
 
diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
index 01101db41ae31b08a86d048cdd27da8ef9bb23a2..3372935519d658529ee7ba25fb2c3fff6adae8c4 100644
--- a/samples/rust/Kconfig
+++ b/samples/rust/Kconfig
@@ -73,6 +73,17 @@ config SAMPLE_RUST_DEBUGFS
 
 	  If unsure, say N.
 
+config SAMPLE_RUST_SCOPED_DEBUGFS
+	tristate "Scoped DebugFS Test Module"
+	depends on DEBUG_FS
+	help
+	  This option builds the Rust Scoped DebugFS Test module sample.
+
+	  To compile this as a module, choose M here:
+	  the module will be called rust_scoped_debugfs.
+
+	  If unsure, say N.
+
 config SAMPLE_RUST_DRIVER_PCI
 	tristate "PCI Driver"
 	depends on PCI
diff --git a/samples/rust/Makefile b/samples/rust/Makefile
index 61276222a99f8cc6d7f84c26d0533b30815ebadd..de10b7f4db3996dc57be813ceb076d050ad8f65a 100644
--- a/samples/rust/Makefile
+++ b/samples/rust/Makefile
@@ -5,6 +5,7 @@ obj-$(CONFIG_SAMPLE_RUST_MINIMAL)		+= rust_minimal.o
 obj-$(CONFIG_SAMPLE_RUST_MISC_DEVICE)		+= rust_misc_device.o
 obj-$(CONFIG_SAMPLE_RUST_PRINT)			+= rust_print.o
 obj-$(CONFIG_SAMPLE_RUST_DEBUGFS)		+= rust_debugfs.o
+obj-$(CONFIG_SAMPLE_RUST_SCOPED_DEBUGFS)	+= rust_scoped_debugfs.o
 obj-$(CONFIG_SAMPLE_RUST_DMA)			+= rust_dma.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_PCI)		+= rust_driver_pci.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_PLATFORM)	+= rust_driver_platform.o
diff --git a/samples/rust/rust_scoped_debugfs.rs b/samples/rust/rust_scoped_debugfs.rs
new file mode 100644
index 0000000000000000000000000000000000000000..7c34cab62a2753d1ede3a1334be1fb13ddce780c
--- /dev/null
+++ b/samples/rust/rust_scoped_debugfs.rs
@@ -0,0 +1,134 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2025 Google LLC.
+
+//! Sample DebugFS exporting platform driver that demonstrates the use of
+//! `Scope::dir` to create a variety of files without the need to separately
+//! track them all.
+
+use core::sync::atomic::AtomicUsize;
+use kernel::debugfs::{Dir, Scope};
+use kernel::prelude::*;
+use kernel::sync::Mutex;
+use kernel::{c_str, new_mutex, str::CString};
+
+module! {
+    type: RustScopedDebugFs,
+    name: "rust_scoped_debugfs",
+    authors: ["Matthew Maurer"],
+    description: "Rust Scoped DebugFS usage sample",
+    license: "GPL",
+}
+
+fn remove_file_write(
+    mod_data: &ModuleData,
+    reader: &mut kernel::uaccess::UserSliceReader,
+) -> Result<()> {
+    let mut buf = [0u8; 128];
+    if reader.len() >= buf.len() {
+        return Err(EINVAL);
+    }
+    let n = reader.len();
+    reader.read_slice(&mut buf[..n])?;
+
+    let s = core::str::from_utf8(&buf[..n]).map_err(|_| EINVAL)?.trim();
+    let nul_idx = s.len();
+    buf[nul_idx] = 0;
+    let to_remove = CStr::from_bytes_with_nul(&buf[..nul_idx + 1]).map_err(|_| EINVAL)?;
+    mod_data
+        .devices
+        .lock()
+        .retain(|device| device.name.as_bytes() != to_remove.as_bytes());
+    Ok(())
+}
+
+fn create_file_write(
+    mod_data: &ModuleData,
+    reader: &mut kernel::uaccess::UserSliceReader,
+) -> Result<()> {
+    let mut buf = [0u8; 128];
+    if reader.len() > buf.len() {
+        return Err(EINVAL);
+    }
+    let n = reader.len();
+    reader.read_slice(&mut buf[..n])?;
+
+    let mut nums = KVec::new();
+
+    let s = core::str::from_utf8(&buf[..n]).map_err(|_| EINVAL)?.trim();
+    let mut items = s.split_whitespace();
+    let name_str = items.next().ok_or(EINVAL)?;
+    let name = CString::try_from_fmt(fmt!("{name_str}"))?;
+    let file_name = CString::try_from_fmt(fmt!("{name_str}"))?;
+    for sub in items {
+        nums.push(
+            AtomicUsize::new(sub.parse().map_err(|_| EINVAL)?),
+            GFP_KERNEL,
+        )?;
+    }
+
+    let scope = KBox::pin_init(
+        mod_data
+            .device_dir
+            .scope(DeviceData { name, nums }, &file_name, |dev_data, dir| {
+                for (idx, val) in dev_data.nums.iter().enumerate() {
+                    let Ok(name) = CString::try_from_fmt(fmt!("{idx}")) else {
+                        return;
+                    };
+                    dir.read_write_file(&name, val);
+                }
+            }),
+        GFP_KERNEL,
+    )?;
+    (*mod_data.devices.lock()).push(scope, GFP_KERNEL)?;
+
+    Ok(())
+}
+
+struct RustScopedDebugFs {
+    _data: Pin<KBox<Scope<ModuleData>>>,
+}
+
+#[pin_data]
+struct ModuleData {
+    device_dir: Dir,
+    #[pin]
+    devices: Mutex<KVec<Pin<KBox<Scope<DeviceData>>>>>,
+}
+
+impl ModuleData {
+    fn init(device_dir: Dir) -> impl PinInit<Self> {
+        pin_init! {
+            Self {
+                device_dir: device_dir,
+                devices <- new_mutex!(KVec::new())
+            }
+        }
+    }
+}
+
+struct DeviceData {
+    name: CString,
+    nums: KVec<AtomicUsize>,
+}
+
+fn init_control(base_dir: &Dir, dyn_dirs: Dir) -> impl PinInit<Scope<ModuleData>> + '_ {
+    base_dir.scope(
+        ModuleData::init(dyn_dirs),
+        c_str!("control"),
+        |data, dir| {
+            dir.write_only_callback_file(c_str!("create"), data, &create_file_write);
+            dir.write_only_callback_file(c_str!("remove"), data, &remove_file_write);
+        },
+    )
+}
+
+impl kernel::Module for RustScopedDebugFs {
+    fn init(_module: &'static kernel::ThisModule) -> Result<Self, Error> {
+        let base_dir = Dir::new(c_str!("rust_scoped_debugfs"));
+        let dyn_dirs = base_dir.subdir(c_str!("dynamic"));
+        Ok(Self {
+            _data: KBox::pin_init(init_control(&base_dir, dyn_dirs), GFP_KERNEL)?,
+        })
+    }
+}

-- 
2.51.0.rc1.167.g924127e9c0-goog


