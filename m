Return-Path: <linux-kernel+bounces-801650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 008BEB44853
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 23:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87910AA2CD3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 21:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB712BE7BA;
	Thu,  4 Sep 2025 21:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BL7ohsv+"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8112FC88C
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 21:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757020459; cv=none; b=B+j4DsQLU3YUvUtws4EUSn66pwUHJkgr5qVxkVHvm2MC9UUshHT93U/yHfNJeVqzggd/mXDnsVw3/R+wPiJ2ZPbjieUZ+kBObpJVYqpMXNlZQvXvR0jb5Ionpp/QpvTUvE8oJkP0mZUeTO1cpe0wwhLtK+er7huSx6vLd97ZXcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757020459; c=relaxed/simple;
	bh=ZOByofkirTEhHxljqlcJt3YijCsj4603lkXVxLBHevc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Fpw/cLDprVU9pTciiUlKEqwtbkxCO6eEkZLPXYTma+Ae6U/lAeXOCddY7Qz/AnsxF/YZXnOVYipeqibfaqtPmCtvUTBb4KixvMp/JZ8wQm6Dmstg7QF3CVCzoeUvNWwgSx3I++90H6fRzsrrKHkI8qGDA7xoY4GDWpDsoeBv1S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BL7ohsv+; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-77260707951so2124071b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 14:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757020455; x=1757625255; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MuVbHTcTn1dGtaw/xfjGHfOlmUWLY+u0Yv+dfyfZ2z0=;
        b=BL7ohsv+0QJsYKvY/8WoZ/6ufGM0HjlHpe2JUftH6WiV5zaHS7f9jn184BlKilDPsA
         GC4yvBywrHw+E0r5uaT86gkuMZWA3e0gTWaDm8hm8woGm9DU8/AMRsR903diXYQnTuZW
         Z2Lsl99uyRWRkLpH6g2mxyCxhFCVpjJWRIYi5QDIic0C5XtfogGh2L0/md4lcNry8Wkp
         yiC3CmCa9u3m3YHeoPg4GY+6FH/y6tbBBcXj55MecLOtb+R/ZalWjIeWT4kkEYHVfBp5
         1eeiBOrhFhpx7xhnPotnnr1/P7r088rdBzSUZL/qQK77P0THBHWYdO8UQFie5OoArbnu
         Bgiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757020455; x=1757625255;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MuVbHTcTn1dGtaw/xfjGHfOlmUWLY+u0Yv+dfyfZ2z0=;
        b=nRdszmsNkHgXUv+UU32gvmaZX9nDTjMVfcb/xNbAyAgiKtW3/3YqcgZKyAi5ac7iE+
         i3R7xXkZCpYhrXSVMVOLV0DXgk8wk+gYz4OM9p1dmBKLgyQbcWrFSk2OzCqaucyVgvn5
         TWE8NKMLpvc3ibSmvAuiRKr7eZOCKQFtQ8qCPjipTVMIULxb9odAZy/STmXSVauzCyQs
         pKcHnX5rUU4eyv/qW8VpsG4qoI2FBDcP2uZQWsNjqiaUii9mZC9OILFXy7E4zy4JIsoK
         D4jpwZLF74eYFMF53P6MUl5ry6C4617kpLZp4lSfDbUPlyNDI6W7+VB789aOoF+6O+aL
         MQPA==
X-Gm-Message-State: AOJu0Yz7O9Hr2NcepgqFR6BOS6q8JWlI2XmXrBs8X9iWKsSPRW8LpUS5
	Ts4SXZkEHv7NhMfDAicusjcw+xZEp30zvEUUrrzrqaiT84XJZaMRxJ7l+qcdrqPGX3ZYV770RTw
	+Q4jQ3583JQ==
X-Google-Smtp-Source: AGHT+IE8miOQ1cTcO0C+Ywnb/WSRBEUZzd7DMsAk3P0BP9MWStesJpoYvtzfZYCTN4qKw3/Cfc/6aI10NvFj
X-Received: from pfbjo21.prod.google.com ([2002:a05:6a00:9095:b0:771:83fa:dfac])
 (user=mmaurer job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6300:218a:b0:243:b20d:5e05
 with SMTP id adf61e73a8af0-243d6f051e5mr28631242637.39.1757020455228; Thu, 04
 Sep 2025 14:14:15 -0700 (PDT)
Date: Thu, 04 Sep 2025 21:13:58 +0000
In-Reply-To: <20250904-debugfs-rust-v11-0-7d12a165685a@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904-debugfs-rust-v11-0-7d12a165685a@google.com>
X-Developer-Key: i=mmaurer@google.com; a=ed25519; pk=2Ezhl7+fEjTOMVFpplDeak2AdQ8cjJieLRVJdNzrW+E=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757020440; l=7155;
 i=mmaurer@google.com; s=20250429; h=from:subject:message-id;
 bh=ZOByofkirTEhHxljqlcJt3YijCsj4603lkXVxLBHevc=; b=z+SsK8AErLja4NFbvWC9hBFsO/jociQidr7OHZFQUBBZxVNnfNJfH3+U1dQALNPMVtQF/RxOC
 ABPHJUeKBRkBVRtNo40OpsQ44BZRYj8V0p1k7vJcJ/y5gvyxSfqOGJr
X-Mailer: b4 0.14.2
Message-ID: <20250904-debugfs-rust-v11-7-7d12a165685a@google.com>
Subject: [PATCH v11 7/7] samples: rust: Add scoped debugfs sample driver
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
2.51.0.355.g5224444f11-goog


