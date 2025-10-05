Return-Path: <linux-kernel+bounces-842256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA56DBB9578
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 12:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CE701897677
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 10:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BFD26B973;
	Sun,  5 Oct 2025 10:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NxXWL8Ui"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53DC26C399
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 10:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759659835; cv=none; b=jy+PURL+7UAwJ37c/D0PoE4llpE/PdYWoVGnCEkCLvyJkycBTJqEcVt1iQ4237Odun+9TVpUlUml6G0vrLC8lJwygB20n7mPgIPCCUJDC5ApCkEAgFHFlYXAOjyBtdyhkcKVlI8gYyzMssnH+ZIJUQyxF4tzjySxdvEbAgpVTtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759659835; c=relaxed/simple;
	bh=q+WTdvd20EQ+5LcFvIvTRIFw16rgVBtHz4Xy4O5ISho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F/EasipPEKXsImg7S8RDpnrUUCYGsvAmrUawd8jVo/bztbkUKXMpoEhYN3YvxjAeDZqeuUw2ln4kC7qDRhTLuDSzn6FtK2/yPsLutI46an/dg09656piTXrSi0n5z7UikB/HxzBZAp9iGTFPYyp3L+MTpVNwhlQG5g7S0Terr0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NxXWL8Ui; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4060b4b1200so3419148f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 03:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759659832; x=1760264632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ngfEm+DQ3DVDPW9zq8FsaUOLCfe9b0eQ1gcmjeKbeXc=;
        b=NxXWL8Ui0iyQDJS/Tt9EnonWCpThJG+zUaWwkDD9ZVB3/PKZUESCCx0NcjcSYOFkyj
         uxL5ODk0TrtL66mJ9D9gCDD8NXObDx0h6n/S25onR1kY1fvHD3UK30onI3UbK3OEVmkF
         ieOPrRMg3/szBVNl6MeBlddATjckfQD9iu65cW9ZsJYbshBYJ9VKXoGdEG7tqeSBPoGC
         at8FYdO4JD45gJOfLHghtknwUBxUt34sM3MuvOkczazjzxb5EhrW2Ie3k8pOYeMb6Udu
         SRbXj99iLWUIr4XC9mOc69KpUFDMTnSqDJ260Emt5seNegA2bJ2mKIALilHsXU/ICUAT
         KTPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759659832; x=1760264632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ngfEm+DQ3DVDPW9zq8FsaUOLCfe9b0eQ1gcmjeKbeXc=;
        b=uTMUJqCNYc8QgiZXEBtdKhznCTrswrbV3qwvMdnTkAjrDUWVR5tHTx9B/jt16EMBTq
         zzfs5mtrMH6lMlhGqx1wdHVTUMvfvAm6ErP4X7nG4iLb4NvqDR/3I/hR9lDG6P4TANTh
         28O9xCjjiR5Ec8E0y4VFDMJZKJu1PT6O1aMcessp5n92/lWfDYR9fiDBfy6GKb0SZn0X
         XUeQdvzKBKuVdTzeVhd5dIUuQiQZ56c/8XJYWo4WMRfEnIALzF5cAqEW9Z0kHrBr3Wtw
         5DlCPPQQprX2ifWbyboxCMF/KNDh06ZA+/qImSW8DH2eTnjcQFSL8lXnhToZ5Fv/tghn
         /7Nw==
X-Forwarded-Encrypted: i=1; AJvYcCXGV/JVJtidj5CsbwARGxDJdUhgHHELQ95e1wF4SCAuXhvcTHb5ylI+FIZGqLkNjJkvyUKFpmeVzGM4kLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqN5h2By+jG32mVesJJGJVkHy8omWyZYqQDO3UNDeVQjQ8oNhI
	lyxgyR9U79s9o+LZDlwVwaxdpIo92cUKBLRAXfxYyVH/HbOq66PR2qgl
X-Gm-Gg: ASbGncv8qp0zH4+BhlJGDWWwDyo0bOoQSxnBhDcqEN+hWInK0CtJZLAcfwW2pnrtIwJ
	jG5B12YK60Q/o3vRh/EdK1ZOpn//9S050Dpbbk6Hz3Y9fLfr/ApK/I1iGpstOdUZNYyDs+XlXk2
	nt29bbAw4Ka9f3oqwTAdGRFCmTX57NU/PI6LMPfuSMp9QRSpt8ZBbb/GqwwZCfTj1P/BF5U9Un4
	HQC869wlS+EyC5zy/oBFsjsts77+rCo9e82fS6Qj1B3xsD2W35rvqRoVLPx/g8aQ6vH7riIHjpA
	R9oBgqd8p0HB0ytiq6CnWLE0dx0mZrPAWkzrOzgJnbnvZwaskI8q98+yiPer1LAg3Z7DBU2TqPM
	N1AsLH0tTZT+b7nWYzidNh6sCWYhtLlDoyOh9uK6f6kperMxfZNZUmLf83NfBo4gUa/Q=
X-Google-Smtp-Source: AGHT+IF17RBTJIOkohlNDQohlW0bXClHHtsE7aCBssZ9CCNLPAILpVfcFgHOU0RfquJetXJuGo/2oQ==
X-Received: by 2002:a05:6000:603:b0:3ee:1461:165f with SMTP id ffacd0b85a97d-42567194bb2mr5418875f8f.31.1759659831787;
        Sun, 05 Oct 2025 03:23:51 -0700 (PDT)
Received: from Vasilio.Home ([2.127.51.206])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8e9703sm16055425f8f.30.2025.10.05.03.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Oct 2025 03:23:51 -0700 (PDT)
From: Igor Korotin <igor.korotin.linux@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Asahi Lina <lina+kernel@asahilina.net>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Alex Hung <alex.hung@amd.com>,
	Tamir Duberstein <tamird@gmail.com>,
	Xiangfei Ding <dingxiangfei2009@gmail.com>,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-i2c@vger.kernel.org
Subject: [PATCH v6 3/3] samples: rust: add Rust I2C sample driver
Date: Sun,  5 Oct 2025 11:23:48 +0100
Message-ID: <20251005102348.41935-1-igor.korotin.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251005102226.41876-1-igor.korotin.linux@gmail.com>
References: <20251005102226.41876-1-igor.korotin.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new `rust_driver_i2c` sample, showing how to create a new
i2c client using `i2c::Registration` and bind a driver to it
via legacy I2C-ID table.

Signed-off-by: Igor Korotin <igor.korotin.linux@gmail.com>
---
 MAINTAINERS                     |   1 +
 samples/rust/Kconfig            |  11 +++
 samples/rust/Makefile           |   1 +
 samples/rust/rust_driver_i2c.rs | 126 ++++++++++++++++++++++++++++++++
 4 files changed, 139 insertions(+)
 create mode 100644 samples/rust/rust_driver_i2c.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index c44c7ac317b1..2654a7ea0c80 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11523,6 +11523,7 @@ R:	Daniel Almeida <daniel.almeida@collabora.com>
 L:	rust-for-linux@vger.kernel.org
 S:	Maintained
 F:	rust/kernel/i2c.rs
+F:	samples/rust/rust_driver_i2c.rs
 
 I2C SUBSYSTEM HOST DRIVERS
 M:	Andi Shyti <andi.shyti@kernel.org>
diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
index 7f7371a004ee..28dae070b365 100644
--- a/samples/rust/Kconfig
+++ b/samples/rust/Kconfig
@@ -62,6 +62,17 @@ config SAMPLE_RUST_DMA
 
 	  If unsure, say N.
 
+config SAMPLE_RUST_DRIVER_I2C
+	tristate "I2C Driver"
+	depends on I2C=y
+	help
+	  This option builds the Rust I2C driver sample.
+
+	  To compile this as a module, choose M here:
+	  the module will be called rust_driver_i2c.
+
+	  If unsure, say N.
+
 config SAMPLE_RUST_DRIVER_PCI
 	tristate "PCI Driver"
 	depends on PCI
diff --git a/samples/rust/Makefile b/samples/rust/Makefile
index bd2faad63b4f..141d8f078248 100644
--- a/samples/rust/Makefile
+++ b/samples/rust/Makefile
@@ -5,6 +5,7 @@ obj-$(CONFIG_SAMPLE_RUST_MINIMAL)		+= rust_minimal.o
 obj-$(CONFIG_SAMPLE_RUST_MISC_DEVICE)		+= rust_misc_device.o
 obj-$(CONFIG_SAMPLE_RUST_PRINT)			+= rust_print.o
 obj-$(CONFIG_SAMPLE_RUST_DMA)			+= rust_dma.o
+obj-$(CONFIG_SAMPLE_RUST_DRIVER_I2C)		+= rust_driver_i2c.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_PCI)		+= rust_driver_pci.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_PLATFORM)	+= rust_driver_platform.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_FAUX)		+= rust_driver_faux.o
diff --git a/samples/rust/rust_driver_i2c.rs b/samples/rust/rust_driver_i2c.rs
new file mode 100644
index 000000000000..b2d1d234b077
--- /dev/null
+++ b/samples/rust/rust_driver_i2c.rs
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust I2C driver sample.
+//!
+//! This module shows how to:
+//!
+//! 1. Manually create an `i2c_client` at address `SAMPLE_I2C_CLIENT_ADDR`
+//!    on the adapter with index `SAMPLE_I2C_ADAPTER_INDEX`.
+//!
+//! 2. Register a matching Rust-based I2C driver for that client.
+//!
+//! # Requirements
+//!
+//! - The target system must expose an I2C adapter at index
+//!   `SAMPLE_I2C_ADAPTER_INDEX`.
+//!
+//! - To emulate an adapter for testing, you can load the
+//!   `i2c-stub` kernel module with an option `chip_addr`
+//!   For example for this sample driver to emulate an I2C device with
+//!   an address 0x30 you can use:
+//!      `modprobe i2c-stub chip_addr=0x30`
+//!
+
+use kernel::{
+    acpi, c_str,
+    device::Core,
+    i2c, of,
+    prelude::*,
+    types::ARef,
+};
+
+const SAMPLE_I2C_CLIENT_ADDR: u16 = 0x30;
+const SAMPLE_I2C_ADAPTER_INDEX: i32 = 0;
+const BOARD_INFO: i2c::I2cBoardInfo =
+    i2c::I2cBoardInfo::new(c_str!("rust_driver_i2c"), SAMPLE_I2C_CLIENT_ADDR);
+
+struct SampleDriver {
+    idev: ARef<i2c::I2cClient>,
+}
+
+kernel::acpi_device_table! {
+    ACPI_TABLE,
+    MODULE_ACPI_TABLE,
+    <SampleDriver as i2c::Driver>::IdInfo,
+    [(acpi::DeviceId::new(c_str!("LNUXBEEF")), 0)]
+}
+
+kernel::i2c_device_table! {
+    I2C_TABLE,
+    MODULE_I2C_TABLE,
+    <SampleDriver as i2c::Driver>::IdInfo,
+    [(i2c::DeviceId::new(c_str!("rust_driver_i2c")), 0)]
+}
+
+kernel::of_device_table! {
+    OF_TABLE,
+    MODULE_OF_TABLE,
+    <SampleDriver as i2c::Driver>::IdInfo,
+    [(of::DeviceId::new(c_str!("test,rust_driver_i2c")), 0)]
+}
+
+impl i2c::Driver for SampleDriver {
+    type IdInfo = u32;
+
+    const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = Some(&ACPI_TABLE);
+    const I2C_ID_TABLE: Option<i2c::IdTable<Self::IdInfo>> = Some(&I2C_TABLE);
+    const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
+
+    fn probe(idev: &i2c::I2cClient<Core>, info: Option<&Self::IdInfo>) -> Result<Pin<KBox<Self>>> {
+        let dev = idev.as_ref();
+
+        dev_info!(dev, "Probe Rust I2C driver sample.\n");
+
+        if let Some(info) = info {
+            dev_info!(dev, "Probed with info: '{}'.\n", info);
+        }
+
+        let drvdata = KBox::new(Self { idev: idev.into() }, GFP_KERNEL)?;
+
+        Ok(drvdata.into())
+    }
+
+    fn shutdown(idev: &i2c::I2cClient<Core>, _this: Pin<&Self>) {
+        dev_info!(idev.as_ref(), "Shutdown Rust I2C driver sample.\n");
+    }
+}
+
+impl Drop for SampleDriver {
+    fn drop(&mut self) {
+        dev_info!(self.idev.as_ref(), "Remove Rust I2C driver sample.\n");
+    }
+}
+
+// NOTE: The code below is expanded macro module_i2c_driver. It is not used here
+//       because we need to manually create an I2C client in `init()`. The macro
+//       hides `init()`, so to demo client creation on adapter SAMPLE_I2C_ADAPTER_INDEX
+//       we expand it by hand.
+#[pin_data]
+struct DriverModule {
+    #[pin]
+    _driver: kernel::driver::Registration<i2c::Adapter<SampleDriver>>,
+    _reg: i2c::Registration,
+}
+
+impl kernel::InPlaceModule for DriverModule {
+    fn init(
+        module: &'static kernel::ThisModule,
+    ) -> impl ::pin_init::PinInit<Self, kernel::error::Error> {
+        kernel::try_pin_init!(Self {
+            _reg <- {
+                let adapter = i2c::I2cAdapter::get(SAMPLE_I2C_ADAPTER_INDEX)?;
+
+                i2c::Registration::new(&adapter, &BOARD_INFO)
+            },
+            _driver <- kernel::driver::Registration::new(<Self as kernel::ModuleMetadata>::NAME,module,),
+        })
+    }
+}
+
+kernel::prelude::module! {
+    type: DriverModule,
+    name: "rust_driver_i2c",
+    authors: ["Igor Korotin"],
+    description: "Rust I2C driver",
+    license: "GPL v2",
+}
-- 
2.43.0


