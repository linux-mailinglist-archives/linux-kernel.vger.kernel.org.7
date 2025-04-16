Return-Path: <linux-kernel+bounces-603417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D320FA8871B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 17:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6A0D168793
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 15:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D80D27A100;
	Mon, 14 Apr 2025 15:27:03 +0000 (UTC)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126AF274642;
	Mon, 14 Apr 2025 15:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744644422; cv=none; b=sq6roskqF47De0PunvhVSQWLTcMEZ9cIHD/MeargdjNYa6aA3Ux9D4vZjSPGTLDKJ0V4XWexlLCf0I0bDRejCP4kkKPTj+joaD5TiIuxd7B7ihvNp9vWGpu1jCZts+wcQk2jc07Qe0DtmnhgXw5qJQj32zqR8Jmz/GWDX02M17o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744644422; c=relaxed/simple;
	bh=myCQWYQ5yFgd2BuNSiywex37N2f8bLHvBD8YV269Ips=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nbSkVvBfbnuAyqdztd/ki0CuOHPUGxjDx0chebThjcBpSPbWCxLuLUSgZ5xJeLNm+NGoa6ZY0yjbD4jsvIbHHb8c+grBWXW638nd5HPlBPFYKvHY97fowkbFC/kwjdWumjSoSHwHzaiY4ALrY833T1MjabYZA0DZDOK/e3C4mXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev; spf=pass smtp.mailfrom=buenzli.dev; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buenzli.dev
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Zbrk92D4Yz9vGD;
	Mon, 14 Apr 2025 17:26:57 +0200 (CEST)
From: Remo Senekowitsch <remo@buenzli.dev>
To: Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Remo Senekowitsch <remo@buenzli.dev>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: [PATCH v2 5/5] samples: rust: platform: Add property read examples
Date: Mon, 14 Apr 2025 17:26:30 +0200
Message-ID: <20250414152630.1691179-6-remo@buenzli.dev>
In-Reply-To: <20250414152630.1691179-1-remo@buenzli.dev>
References: <20250326171411.590681-1-remo@buenzli.dev>
 <20250414152630.1691179-1-remo@buenzli.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4Zbrk92D4Yz9vGD

Add some example usage of the device property read methods for
DT/ACPI/swnode properties.

Co-developed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Remo Senekowitsch <remo@buenzli.dev>
---
 drivers/of/unittest-data/tests-platform.dtsi |  3 +
 samples/rust/rust_driver_platform.rs         | 69 +++++++++++++++++++-
 2 files changed, 69 insertions(+), 3 deletions(-)

diff --git a/drivers/of/unittest-data/tests-platform.dtsi b/drivers/of/unittest-data/tests-platform.dtsi
index 4171f43cf..50a51f38a 100644
--- a/drivers/of/unittest-data/tests-platform.dtsi
+++ b/drivers/of/unittest-data/tests-platform.dtsi
@@ -37,6 +37,9 @@ dev@100 {
 			test-device@2 {
 				compatible = "test,rust-device";
 				reg = <0x2>;
+
+				test,u32-prop = <0xdeadbeef>;
+				test,i16-array = /bits/ 16 <1 2 (-3) (-4)>;
 			};
 		};
 
diff --git a/samples/rust/rust_driver_platform.rs b/samples/rust/rust_driver_platform.rs
index 8120609e2..0284f1840 100644
--- a/samples/rust/rust_driver_platform.rs
+++ b/samples/rust/rust_driver_platform.rs
@@ -2,7 +2,7 @@
 
 //! Rust Platform driver sample.
 
-use kernel::{c_str, of, platform, prelude::*};
+use kernel::{c_str, of, platform, prelude::*, str::CString};
 
 struct SampleDriver {
     pdev: platform::Device,
@@ -22,18 +22,81 @@ impl platform::Driver for SampleDriver {
     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
 
     fn probe(pdev: &mut platform::Device, info: Option<&Self::IdInfo>) -> Result<Pin<KBox<Self>>> {
-        dev_dbg!(pdev.as_ref(), "Probe Rust Platform driver sample.\n");
+        let dev = pdev.as_ref();
+
+        dev_dbg!(dev, "Probe Rust Platform driver sample.\n");
 
         if let Some(info) = info {
-            dev_info!(pdev.as_ref(), "Probed with info: '{}'.\n", info.0);
+            dev_info!(dev, "Probed with info: '{}'.\n", info.0);
         }
 
+        Self::properties_parse(dev)?;
+
         let drvdata = KBox::new(Self { pdev: pdev.clone() }, GFP_KERNEL)?;
 
         Ok(drvdata.into())
     }
 }
 
+impl SampleDriver {
+    fn properties_parse(dev: &kernel::device::Device) -> Result<()> {
+        if let Ok(idx) = dev.property_match_string(c_str!("compatible"), c_str!("test,rust-device"))
+        {
+            dev_info!(dev, "matched compatible string idx = {}\n", idx);
+        }
+
+        if let Ok(str) = dev
+            .property_read::<CString>(c_str!("compatible"))
+            .required()
+        {
+            dev_info!(dev, "compatible string = {:?}\n", str);
+        }
+
+        let prop = dev.property_read_bool(c_str!("test,bool-prop"));
+        dev_info!(dev, "bool prop is {}\n", prop);
+
+        if dev.property_present(c_str!("test,u32-prop")) {
+            dev_info!(dev, "'test,u32-prop' is present\n");
+        }
+
+        let prop = dev
+            .property_read::<u32>(c_str!("test,u32-optional-prop"))
+            .or(0x12);
+        dev_info!(
+            dev,
+            "'test,u32-optional-prop' is {:#x} (default = {:#x})\n",
+            prop,
+            0x12
+        );
+
+        // Missing property without a default will print an error
+        let _ = dev
+            .property_read::<u32>(c_str!("test,u32-required-prop"))
+            .required()?;
+
+        let prop: u32 = dev.property_read(c_str!("test,u32-prop")).required()?;
+        dev_info!(dev, "'test,u32-prop' is {:#x}\n", prop);
+
+        // TODO: remove or replace with u16? `Property` is not implemented for
+        // unsigned integers, as suggested by Andy Shevchenko.
+
+        let prop: [i16; 4] = dev.property_read(c_str!("test,i16-array")).required()?;
+        dev_info!(dev, "'test,i16-array' is {:?}\n", prop);
+        dev_info!(
+            dev,
+            "'test,i16-array' length is {}\n",
+            dev.property_count_elem::<u16>(c_str!("test,i16-array"))?,
+        );
+
+        let prop: KVec<i16> = dev
+            .property_read_array_vec(c_str!("test,i16-array"), 4)?
+            .required()?;
+        dev_info!(dev, "'test,i16-array' is KVec {:?}\n", prop);
+
+        Ok(())
+    }
+}
+
 impl Drop for SampleDriver {
     fn drop(&mut self) {
         dev_dbg!(self.pdev.as_ref(), "Remove Rust Platform driver sample.\n");
-- 
2.49.0


