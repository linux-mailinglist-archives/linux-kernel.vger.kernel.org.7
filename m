Return-Path: <linux-kernel+bounces-892989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23BCBC464B6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3131B18872B8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACFD255E43;
	Mon, 10 Nov 2025 11:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxLArBwx"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AEF30BB94
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762774292; cv=none; b=Y7UjqTzskksVSx1Vvvxq6DHRuJUWL6TrOAB53zk4aHzqTdhPGy0z5/gde1eGA1xzkafSL6o0F2ykqPUAfyLhph8lEUEInqxH6GjOIY8/TXTdJbnKIur8MoLshzDORV+jdj8ZkENad9AUKEOCC3gv2T3YbXC8srDaHiScSHDqN1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762774292; c=relaxed/simple;
	bh=bFIQQ06Agyt2upC6J1Gjh5h7YG0NBP+vayKdmqFopoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ipyuHBl16iLDiIj8v/uxQ4fXWpf0hM5TVS0KV7/SFVwJRiWbJiPDq4yNkH+M0gKLYy3U1ha45dfjr8LxdhZDgqbgJ6MG2Zz127LYkHGBU41VU8Z0pjcIVeSGLL36nveUVv96C8joHbuvF3Qnd3hEf1zjwl4AGa1AWvpRixAb8Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jxLArBwx; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47777000dadso10068525e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 03:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762774288; x=1763379088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5LWQjcrvAOJQ7nTF8lLDP1PEbSkHG+HZiQBcb+5o/+U=;
        b=jxLArBwxlDZ9V4eEJ0Zg1roUqPvEfMlIaGCpxE75fEOHlZhHYadsA6ErkaofLlAyTg
         fE5H6Kr+eBby1xYxhjCS+aE5Wkthx8xNXILEgIFbgs8GgD80DBbOOCgu2sDDwEOV4lCk
         7wmd0lUYumwcg8nctxuuDIoBiivC7KP+2hGEbhQ2w7xQUU12ZKs72qO8oe9eHb5rKp+U
         Wufb6yrs+2OiRKccQqhciKCA7l3RB+wwveGYwfp6GgGnJm2UqytkMYLX1yh8rfKRotWh
         Ciagopuk8EuayeU3gv3ilzwbkG4zTnz1Qyr3VUiBgNu35K7Xch9hc9by2nRqfq6Gjgra
         +2Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762774288; x=1763379088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5LWQjcrvAOJQ7nTF8lLDP1PEbSkHG+HZiQBcb+5o/+U=;
        b=GI0K13p44DnBIFnLuENRQn2oJ2OFv+E43dJfVNIAb3WRMIdCJnTCfGaXE/RQ6POzo0
         MTmWOWnkCwuHPN0XNJOcsVtZ00LUjE1UMVsFiX1WOEbejc9D4ci/00lqSfbC1PlkvTdU
         ume5OPzr3fgSPWJs5xJvHxBh6lkq+gGJI2egjdZWwvzggsNMyGUcvSwFzipJC4ARYKw0
         mI1vza+XMQrwAGZoiDooL2wVeXXuiDBP7ICINz1fndFy/pGfmmQtisBjP4ahnHfi+wfD
         ytXDseVSmsPNDxbuMaXrwS9vv0Ep1APYNXkV8QD9H1KBUO+D8N2sNd7/N+fQbNC5Y0eu
         s2wg==
X-Forwarded-Encrypted: i=1; AJvYcCVFZSpLAamu1iFVAgnx18e+1IneraxGzdlP8tMxk4ehOHoCY+vqnbVkp+rOjkBeoQKl3vPLMqr0ADHXrPs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm6WChr+b8u+8Cp2mHOBcWpLmCvfFhTNpXBZLbIjJQnFm+n+Ul
	lDLiUl0bwGwTMEbXcudKHAv/JcCedpm7ahv7VXYe+CRUk83mO6InCOu0
X-Gm-Gg: ASbGncva5rLi/js1N2/6rd5uKSb98u6d0OZh8WE9zcLXHzrJI/bL0r9mHpnFW4ByIS2
	zazUKstWHfd2LKKrZVGy4lZz6RJcpkXlY+oRo8yPd3gO6+/US26/lb7h2yRZbOtYNIY6J0OHH3N
	cIRIUa64clp+FY+5fgjpgsa2AiNzp3hLw1N8oyG6zvaMNRNo7Mi9hWtvpnujw7+b9Q3lcxRREdg
	/yp5UKMuo2GGZHWjrm4zGuAHBrfEx235F+8b9seRI53piVFGN3YxMqbmK0MIeC6FNxSPFDXquch
	T7jqa/GC9dGVI8i6dQ1NmXtKLcNVAFbFeVryZfvVBThi89r4otcWE8UDEqvO3FTa6IWAyjny+aY
	p8APb4PB2Yrvqy1cillmTQEC5qrtVX20A2yZYHKpb2/IdLC4HHueWFyOEVgBvLX+D8PJzhn2YQ5
	kwSwrJYjsreKyNHnY=
X-Google-Smtp-Source: AGHT+IHNdc/e330G/TR0zgRaxlQY2smuqz4tCYVox7ImE1AomlpN3YaqWPqupsE85ysERCk7P5VP4Q==
X-Received: by 2002:a05:600c:1f83:b0:471:786:94d3 with SMTP id 5b1f17b1804b1-477732832afmr66138085e9.22.1762774288132;
        Mon, 10 Nov 2025 03:31:28 -0800 (PST)
Received: from Vasilio.Home ([176.26.203.25])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47774d3557csm127361405e9.8.2025.11.10.03.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 03:31:27 -0800 (PST)
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
Subject: [PATCH v7 4/4] samples: rust: add Rust I2C client registration sample
Date: Mon, 10 Nov 2025 11:31:25 +0000
Message-ID: <20251110113125.51785-1-igor.korotin.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251110112437.50405-1-igor.korotin.linux@gmail.com>
References: <20251110112437.50405-1-igor.korotin.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new `rust_i2c_client` sample, showing how to create a new
i2c client using `i2c::Registration`

Signed-off-by: Igor Korotin <igor.korotin.linux@gmail.com>
---
 samples/rust/Kconfig            |  12 +++
 samples/rust/Makefile           |   1 +
 samples/rust/rust_i2c_client.rs | 142 ++++++++++++++++++++++++++++++++
 3 files changed, 155 insertions(+)
 create mode 100644 samples/rust/rust_i2c_client.rs

diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
index 181466319588..a952220cdff7 100644
--- a/samples/rust/Kconfig
+++ b/samples/rust/Kconfig
@@ -95,6 +95,18 @@ config SAMPLE_RUST_DRIVER_I2C
 
 	  If unsure, say N.
 
+config SAMPLE_RUST_I2C_CLIENT
+	tristate "Manual I2C Client"
+	depends on I2C && I2C_CHARDEV
+	help
+	  This option builds the Rust I2C client manual creation
+	  sample.
+
+	  To compile this as a module, choose M here:
+	  the module will be called rust_i2c_client.
+
+	  If unsure, say N.
+
 config SAMPLE_RUST_DRIVER_PCI
 	tristate "PCI Driver"
 	depends on PCI
diff --git a/samples/rust/Makefile b/samples/rust/Makefile
index aec865e2adef..f65885d1d62b 100644
--- a/samples/rust/Makefile
+++ b/samples/rust/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_SAMPLE_RUST_DEBUGFS)		+= rust_debugfs.o
 obj-$(CONFIG_SAMPLE_RUST_DEBUGFS_SCOPED)	+= rust_debugfs_scoped.o
 obj-$(CONFIG_SAMPLE_RUST_DMA)			+= rust_dma.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_I2C)		+= rust_driver_i2c.o
+obj-$(CONFIG_SAMPLE_RUST_I2C_CLIENT)		+= rust_i2c_client.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_PCI)		+= rust_driver_pci.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_PLATFORM)	+= rust_driver_platform.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_USB)		+= rust_driver_usb.o
diff --git a/samples/rust/rust_i2c_client.rs b/samples/rust/rust_i2c_client.rs
new file mode 100644
index 000000000000..e876a81ffe6e
--- /dev/null
+++ b/samples/rust/rust_i2c_client.rs
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust I2C client registration sample.
+//!
+//! An I2C client in Rust cannot exist on its own. To register a new I2C client,
+//! it must be bound to a parent device. In this sample driver, a platform device
+//! is used as the parent.
+//!
+
+//! ACPI match table test
+//!
+//! This demonstrates how to test an ACPI-based Rust I2C client registration driver
+//! using QEMU with a custom SSDT.
+//!
+//! Steps:
+//!
+//! 1. **Create an SSDT source file** (`ssdt.dsl`) with the following content:
+//!
+//!     ```asl
+//!     DefinitionBlock ("", "SSDT", 2, "TEST", "VIRTACPI", 0x00000001)
+//!     {
+//!         Scope (\_SB)
+//!         {
+//!             Device (T432)
+//!             {
+//!                 Name (_HID, "LNUXBEEF")  // ACPI hardware ID to match
+//!                 Name (_UID, 1)
+//!                 Name (_STA, 0x0F)        // Device present, enabled
+//!                 Name (_CRS, ResourceTemplate ()
+//!                 {
+//!                     Memory32Fixed (ReadWrite, 0xFED00000, 0x1000)
+//!                 })
+//!             }
+//!         }
+//!     }
+//!     ```
+//!
+//! 2. **Compile the table**:
+//!
+//!     ```sh
+//!     iasl -tc ssdt.dsl
+//!     ```
+//!
+//!     This generates `ssdt.aml`
+//!
+//! 3. **Run QEMU** with the compiled AML file:
+//!
+//!     ```sh
+//!     qemu-system-x86_64 -m 512M \
+//!         -enable-kvm \
+//!         -kernel path/to/bzImage \
+//!         -append "root=/dev/sda console=ttyS0" \
+//!         -hda rootfs.img \
+//!         -serial stdio \
+//!         -acpitable file=ssdt.aml
+//!     ```
+//!
+//!     Requirements:
+//!     - The `rust_driver_platform` must be present either:
+//!         - built directly into the kernel (`bzImage`), or
+//!         - available as a `.ko` file and loadable from `rootfs.img`
+//!
+//! 4. **Verify it worked** by checking `dmesg`:
+//!
+//!     ```
+//!     rust_driver_platform LNUXBEEF:00: Probed with info: '0'.
+//!     ```
+//!
+
+use kernel::{acpi, c_str, device, devres, i2c, of, platform, prelude::*, sync::aref::ARef};
+
+#[pin_data(PinnedDrop)]
+struct SampleDriver {
+    parent_dev: ARef<platform::Device>,
+    #[pin]
+    idev: devres::Devres<i2c::Registration>,
+}
+
+kernel::of_device_table!(
+    OF_TABLE,
+    MODULE_OF_TABLE,
+    <SampleDriver as platform::Driver>::IdInfo,
+    [(of::DeviceId::new(c_str!("test,rust-device")), ())]
+);
+
+kernel::acpi_device_table!(
+    ACPI_TABLE,
+    MODULE_ACPI_TABLE,
+    <SampleDriver as platform::Driver>::IdInfo,
+    [(acpi::DeviceId::new(c_str!("LNUXBEEF")), ())]
+);
+
+const SAMPLE_I2C_CLIENT_ADDR: u16 = 0x30;
+const SAMPLE_I2C_ADAPTER_INDEX: i32 = 0;
+const BOARD_INFO: i2c::I2cBoardInfo =
+    i2c::I2cBoardInfo::new(c_str!("rust_driver_i2c"), SAMPLE_I2C_CLIENT_ADDR);
+
+impl platform::Driver for SampleDriver {
+    type IdInfo = ();
+    const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
+    const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = Some(&ACPI_TABLE);
+
+    fn probe(
+        pdev: &platform::Device<device::Core>,
+        _info: Option<&Self::IdInfo>,
+    ) -> impl PinInit<Self, Error> {
+        pin_init::pin_init_scope(move || {
+            dev_info!(
+                pdev.as_ref(),
+                "Probe Rust I2C Client registration sample.\n"
+            );
+
+            Ok(kernel::try_pin_init!( Self {
+                parent_dev: pdev.into(),
+
+                idev <- {
+                    let adapter = i2c::I2cAdapter::get(SAMPLE_I2C_ADAPTER_INDEX)?;
+
+                    i2c::Registration::new(&adapter, &BOARD_INFO, pdev.as_ref())
+                }
+            }))
+        })
+    }
+}
+
+#[pinned_drop]
+impl PinnedDrop for SampleDriver {
+    fn drop(self: Pin<&mut Self>) {
+        dev_info!(
+            self.parent_dev.as_ref(),
+            "Remove Rust Platform driver for I2C Client registration sample.\n"
+        );
+    }
+}
+
+kernel::module_platform_driver! {
+    type: SampleDriver,
+    name: "rust_device_i2c",
+    authors: ["Danilo Krummrich", "Igor Korotin"],
+    description: "Rust Platform driver",
+    license: "GPL v2",
+}
-- 
2.43.0


