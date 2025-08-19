Return-Path: <linux-kernel+bounces-776627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3055EB2CFA5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 01:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9824A1BC8B60
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 23:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7340275844;
	Tue, 19 Aug 2025 23:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vA6LHOsM"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF7B272E51
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 23:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755645171; cv=none; b=dU8loM8jXtrU0ONoUfoPV8l0pj77+bkYgorYvp6pN9xJTld0wA9b6kw1Bf2QOovxgDAidCsPlW2gz35RqduFXaKdPGWXc9KDUAF01McseofEhO8kgVHinmwGARaansM9kmHMJWLfL6h4RL/Ha2vBGbhUUPu2meu80Tfr98r4uXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755645171; c=relaxed/simple;
	bh=mSv+x1L9eMtL0OkyZq/yFX6Imiv7TtipLVfjxSafJV0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Tzr1xzBJVlSnxkJ+9VnBAlWERwlF+cgRtICOjsCDaiKjVREqOXip45aermsv7AIzuMNO/eeVTKoc7kszcNYCBKkjHS5WwOPJCVtIG9aR4r5SopFItfngSQTvmceBS9JshPzfE8GdXcdiBrUs1EIrCQePYM4HtUkKXe68V5a5vF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vA6LHOsM; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-24457f59889so62139305ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 16:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755645167; x=1756249967; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ik9kDnFXL5ALU71hgbOB6yqEspgxHmD7cFIQ61hlnao=;
        b=vA6LHOsM0M55bAKNHRhaVYqgZ6lHzH3G4tpjKS/WRe8LSzpY6X/UKjh9XHWEF0MDZs
         B2KGDXlCv1+yu2G26goAvJ8vtqhkPNqR+7gUEyNTXqb3tpsmUT+6ogIOB72zjULHBI+6
         iZOfUB77wgW62cxopsBqqqBIBa1Lmn4L2MK7UKzuzv+f/c6AUki8mu1B7AUCCGItLqHD
         V0qGfQMi9/9x7wLnhoZB+KfhP5y+5DdGtpgnfIqT9ZK0jIEwUcb+iXvCmuxS4BwbS5JG
         o9DfH72q3J1E0Fw7LpkiR6FaMZ0k4Rt43wEFkoTGdbujCKweUyP24iGy3yilZQDu719B
         Jq5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755645167; x=1756249967;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ik9kDnFXL5ALU71hgbOB6yqEspgxHmD7cFIQ61hlnao=;
        b=PCHpLsvoeGhTiLN7tJGkGY5nrQ05Y7mSjFdJZLLvhAS3GSjy61VYkdQ48D+IqJeFx2
         t2b5EyIh2/cgZGWBXYktYrboXx2nM/8YnaNVAaaWnXh6OZPrdjtbvJldErxjj0kWxFGU
         A1QnwCRmLbWILnqLR+IAuc+adS3XMyyz4x2gK6Z0jyGxaxyhDc3Vt++UPim4hKGBfrxw
         t+6nYZ8Temmqf6qHY97p+vK2wzXeTShKXFzI1act+DqfZww60SQwmcqqYAJrCf8zNm4c
         XPmrUhbWIWJbbG0jr2g6hMk12BTY5xZjWTTJDfEX4tjKwK5R2dGSO2BwGGFTtnNsV9MU
         tOgw==
X-Gm-Message-State: AOJu0YxCcFrAHfVt+Y5OsJ5IY83gYHsar6atFEdS1PnQ2iU/90R4xxkD
	nTDqzXqgux4HAtOYsmhICddIM5mOGxPLVRL54OtMpfxZgDAdK6cUDG8nnnnflGu8GKgT2k2ujYL
	BfkdpUMijpg==
X-Google-Smtp-Source: AGHT+IGhxXoO3WNVNQs8687O16B4BmVLBwYyTCSrX98tU1Zdta6Nul9EYl/Ycjx7bidfNNxbqFGUPUgY2F88
X-Received: from plbkf5.prod.google.com ([2002:a17:903:5c5:b0:243:31a:f8e2])
 (user=mmaurer job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e750:b0:234:a139:11fb
 with SMTP id d9443c01a7336-245ef22704cmr7506595ad.27.1755645167014; Tue, 19
 Aug 2025 16:12:47 -0700 (PDT)
Date: Tue, 19 Aug 2025 23:12:35 +0000
In-Reply-To: <20250819-qcom-socinfo-v1-0-e8d32cc81270@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250819-qcom-socinfo-v1-0-e8d32cc81270@google.com>
X-Developer-Key: i=mmaurer@google.com; a=ed25519; pk=2Ezhl7+fEjTOMVFpplDeak2AdQ8cjJieLRVJdNzrW+E=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755645158; l=40958;
 i=mmaurer@google.com; s=20250429; h=from:subject:message-id;
 bh=mSv+x1L9eMtL0OkyZq/yFX6Imiv7TtipLVfjxSafJV0=; b=CLV7kgLLSJr/NrVWq+3bK4nk7wNCZtTLzeMIGuzR4vRUIh9gKC0HA632maJcwouZWqLI/+7Ke
 6uoW0KzqKGeA54l+OqLNDp9CzniS1KqEHDs+Z0v2LO+D7Wrzj3IjMuj
X-Mailer: b4 0.14.2
Message-ID: <20250819-qcom-socinfo-v1-4-e8d32cc81270@google.com>
Subject: [PATCH WIP 4/5] soc: qcom: socinfo: `File`-based example
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

Re-implements qcom-socinfo driver in Rust, using `File`-based DebugFS
bindings.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 drivers/soc/qcom/Kconfig                           |  12 +
 drivers/soc/qcom/Makefile                          |   1 +
 drivers/soc/qcom/smem.c                            |   4 +
 drivers/soc/qcom/socinfo_rust/bindings.rs          | 126 +++++
 drivers/soc/qcom/socinfo_rust/data.rs              | 387 +++++++++++++++
 drivers/soc/qcom/socinfo_rust/socinfo_rust_file.rs | 538 +++++++++++++++++++++
 rust/bindings/bindings_helper.h                    |   6 +
 7 files changed, 1074 insertions(+)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 2caadbbcf8307ff94f5afbdd1481e5e5e291749f..362ea8c1a18a24a06bb5456e7d1ac8a0cb1003b5 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -227,6 +227,18 @@ config QCOM_SOCINFO
 	 Say yes here to support the Qualcomm socinfo driver, providing
 	 information about the SoC to user space.
 
+config QCOM_SOCINFO_RUST
+	tristate "Qualcomm socinfo driver"
+	depends on QCOM_SMEM && RUST
+	select SOC_BUS
+	help
+	 Say yes here to support the Qualcomm socinfo driver, providing
+	 information about the SoC to user space.
+
+	 This is a draft Rust re-implementation which will enable two
+	 additional copies of the driver to registered alongside the
+	 original.
+
 config QCOM_SPM
 	tristate "Qualcomm Subsystem Power Manager (SPM)"
 	depends on ARCH_QCOM || COMPILE_TEST
diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index b7f1d2a5736748b8772c090fd24462fa91f321c6..6453a4f4f7da89d4e1677ad8f75257e94cec90f4 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -40,3 +40,4 @@ qcom_ice-objs			+= ice.o
 obj-$(CONFIG_QCOM_INLINE_CRYPTO_ENGINE)	+= qcom_ice.o
 obj-$(CONFIG_QCOM_PBS) +=	qcom-pbs.o
 obj-$(CONFIG_QCOM_UBWC_CONFIG) += ubwc_config.o
+obj-$(CONFIG_QCOM_SOCINFO_RUST) += socinfo_rust/socinfo_rust_file.o
diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index cf425930539e406fb81307a17803955371545f32..5279db46a1e0dd7b2994b79d131367175e35290f 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -1230,7 +1230,11 @@ static int qcom_smem_probe(struct platform_device *pdev)
 
 	__smem = smem;
 
+	// TODO don't double load, this is just to diff the debugfs
 	smem->socinfo = platform_device_register_data(&pdev->dev, "qcom-socinfo",
+						      PLATFORM_DEVID_NONE, NULL, 0);
+	// TODO MODULE_ALIAS
+	smem->socinfo = platform_device_register_data(&pdev->dev, "qcom_socinfo_driver_file_rust",
 						      PLATFORM_DEVID_NONE, NULL,
 						      0);
 	if (IS_ERR(smem->socinfo))
diff --git a/drivers/soc/qcom/socinfo_rust/bindings.rs b/drivers/soc/qcom/socinfo_rust/bindings.rs
new file mode 100644
index 0000000000000000000000000000000000000000..8c2b5cecbfdde05e1a81ad0c78be0e7b6432afc5
--- /dev/null
+++ b/drivers/soc/qcom/socinfo_rust/bindings.rs
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2025 Google LLC.
+
+use core::ops::Deref;
+use kernel::error::from_err_ptr;
+use kernel::ffi::c_char;
+use kernel::prelude::*;
+use kernel::transmute::{sized_from_bytes, sized_from_bytes_mut, AsBytes, FromBytes};
+
+pub(crate) fn qcom_smem_get(host: i32, item: u32) -> Result<&'static [u8]> {
+    let mut size = 0;
+    // SAFETY: qcom_smem_get only requires that the size pointer be a writable size_t,
+    // host and item are error checked in the qcom_smem module.
+    let err_ptr = unsafe { kernel::bindings::qcom_smem_get(host as u32, item, &mut size) };
+    let ptr = from_err_ptr(err_ptr)?;
+    // SAFETY: If qcom_smem_get does not return an error, the returned pointer points to a readable
+    // byte buffer with its size written into size. Because these buffers are derived from the
+    // static ranges in the DT, this buffer remains accessible even if the qcom_smem module is
+    // unloaded, so 'static is appropriate. The underlying buffer cannot mutate, so upgrading it
+    // to a reference is allowed.
+    Ok(unsafe { core::slice::from_raw_parts(ptr as *const u8, size) })
+}
+
+pub(crate) const SMEM_IMAGE_VERSION_TABLE: u32 = 469;
+
+// bindgen does not know that struct socinfo is AsBytes, so we implement it here
+#[derive(Default, Copy, Clone)]
+#[repr(transparent)]
+pub(crate) struct RawSocInfo(kernel::bindings::socinfo);
+// SAFETY: Transparent wrapper for the socinfo struct, which is a padding-free
+// C-origin type
+unsafe impl AsBytes for RawSocInfo {}
+// SAFETY: Transparent wrapper for the socinfo struct, a C-origin type
+unsafe impl FromBytes for RawSocInfo {
+    fn from_bytes(bytes: &[u8]) -> Option<&Self> {
+        sized_from_bytes(bytes)
+    }
+    fn from_bytes_mut(bytes: &mut [u8]) -> Option<&mut Self> {
+        sized_from_bytes_mut(bytes)
+    }
+}
+
+impl Deref for RawSocInfo {
+    type Target = kernel::bindings::socinfo;
+    fn deref(&self) -> &Self::Target {
+        &self.0
+    }
+}
+
+impl RawSocInfo {
+    /// Produce RawSocInfo by initializing from a byte buffer that may be too small.
+    /// Code using the resulting value is expected to use the info_fmt field to determine
+    /// which fields have meaningful values.
+    pub(crate) fn from_partial_bytes(soc_info_mem: &[u8]) -> Self {
+        let mut soc_info = RawSocInfo::default();
+        let byte_view = soc_info.as_mut_bytes();
+        let len = core::cmp::min(soc_info_mem.len(), byte_view.len());
+        byte_view[..len].copy_from_slice(&soc_info_mem[..len]);
+        soc_info
+    }
+}
+
+#[repr(C)]
+pub(crate) struct PmicEntry {
+    pub(crate) model: u32,
+    pub(crate) die_rev: u32,
+}
+
+// SAFETY: All bit patterns are valid for all fields, and C layout for two u32s
+// does not require padding
+unsafe impl AsBytes for PmicEntry {}
+// SAFETY: All bit patterns are valid for all fields
+unsafe impl FromBytes for PmicEntry {
+    fn from_bytes(bytes: &[u8]) -> Option<&Self> {
+        sized_from_bytes(bytes)
+    }
+    fn from_bytes_mut(bytes: &mut [u8]) -> Option<&mut Self> {
+        sized_from_bytes_mut(bytes)
+    }
+}
+
+#[derive(Default)]
+#[repr(transparent)]
+pub(crate) struct PmicArray(pub(crate) &'static [PmicEntry]);
+
+impl PmicArray {
+    pub(crate) fn from_bytes(bytes: &'static [u8]) -> Option<Self> {
+        Some(Self(FromBytes::from_bytes(bytes)?))
+    }
+}
+
+const SMEM_IMAGE_VERSION_NAME_SIZE: usize = 75;
+const SMEM_IMAGE_VERSION_VARIANT_SIZE: usize = 20;
+const SMEM_IMAGE_VERSION_OEM_SIZE: usize = 32;
+
+#[repr(C)]
+pub(crate) struct ImageVersion {
+    pub(crate) name: [c_char; SMEM_IMAGE_VERSION_NAME_SIZE],
+    pub(crate) variant: [c_char; SMEM_IMAGE_VERSION_VARIANT_SIZE],
+    pub(crate) pad: c_char,
+    pub(crate) oem: [c_char; SMEM_IMAGE_VERSION_OEM_SIZE],
+}
+
+// SAFETY: All bit patterns are valid for all fields, and C layout for two u32s
+// does not require padding
+unsafe impl AsBytes for ImageVersion {}
+// SAFETY: All bit patterns are valid for all fields
+unsafe impl FromBytes for ImageVersion {
+    fn from_bytes(bytes: &[u8]) -> Option<&Self> {
+        sized_from_bytes(bytes)
+    }
+    fn from_bytes_mut(bytes: &mut [u8]) -> Option<&mut Self> {
+        sized_from_bytes_mut(bytes)
+    }
+}
+
+#[derive(Default)]
+#[repr(transparent)]
+pub(crate) struct ImageVersions(pub(crate) &'static [ImageVersion]);
+
+impl ImageVersions {
+    pub(crate) fn from_bytes(bytes: &'static [u8]) -> Option<Self> {
+        Some(Self(FromBytes::from_bytes(bytes)?))
+    }
+}
diff --git a/drivers/soc/qcom/socinfo_rust/data.rs b/drivers/soc/qcom/socinfo_rust/data.rs
new file mode 100644
index 0000000000000000000000000000000000000000..1575d3c5452f801ae27c2c67ea71410e36521846
--- /dev/null
+++ b/drivers/soc/qcom/socinfo_rust/data.rs
@@ -0,0 +1,387 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2025 Google LLC.
+
+//! Data tables for QCom SocInfo driver
+use kernel::c_str;
+use kernel::prelude::*;
+
+macro_rules! id_entry {
+    ($id:ident) => {
+        kernel::macros::paste! {
+            SocId {
+                id: kernel::bindings::[<QCOM_ID_ $id>],
+                name: c_str!(stringify!($id)),
+            }
+        }
+    };
+    ($id:ident, $name:tt) => {
+        SocId {
+            id: kernel::macros::paste!(kernel::bindings::[<QCOM_ID_ $id>]), name: c_str!($name),
+        }
+    }
+}
+
+pub(crate) struct SocId {
+    pub(crate) id: u32,
+    pub(crate) name: &'static CStr,
+}
+
+pub(crate) static SOC_IDS: &[SocId] = &[
+    { id_entry!(MSM8260) },
+    { id_entry!(MSM8660) },
+    { id_entry!(APQ8060) },
+    { id_entry!(MSM8960) },
+    { id_entry!(APQ8064) },
+    { id_entry!(MSM8930) },
+    { id_entry!(MSM8630) },
+    { id_entry!(MSM8230) },
+    { id_entry!(APQ8030) },
+    { id_entry!(MSM8627) },
+    { id_entry!(MSM8227) },
+    { id_entry!(MSM8660A) },
+    { id_entry!(MSM8260A) },
+    { id_entry!(APQ8060A) },
+    { id_entry!(MSM8974) },
+    { id_entry!(MSM8225) },
+    { id_entry!(MSM8625) },
+    { id_entry!(MPQ8064) },
+    { id_entry!(MSM8960AB) },
+    { id_entry!(APQ8060AB) },
+    { id_entry!(MSM8260AB) },
+    { id_entry!(MSM8660AB) },
+    { id_entry!(MSM8930AA) },
+    { id_entry!(MSM8630AA) },
+    { id_entry!(MSM8230AA) },
+    { id_entry!(MSM8626) },
+    { id_entry!(MSM8610) },
+    { id_entry!(APQ8064AB) },
+    { id_entry!(MSM8930AB) },
+    { id_entry!(MSM8630AB) },
+    { id_entry!(MSM8230AB) },
+    { id_entry!(APQ8030AB) },
+    { id_entry!(MSM8226) },
+    { id_entry!(MSM8526) },
+    { id_entry!(APQ8030AA) },
+    { id_entry!(MSM8110) },
+    { id_entry!(MSM8210) },
+    { id_entry!(MSM8810) },
+    { id_entry!(MSM8212) },
+    { id_entry!(MSM8612) },
+    { id_entry!(MSM8112) },
+    { id_entry!(MSM8125) },
+    { id_entry!(MSM8225Q) },
+    { id_entry!(MSM8625Q) },
+    { id_entry!(MSM8125Q) },
+    { id_entry!(APQ8064AA) },
+    { id_entry!(APQ8084) },
+    { id_entry!(MSM8130) },
+    { id_entry!(MSM8130AA) },
+    { id_entry!(MSM8130AB) },
+    { id_entry!(MSM8627AA) },
+    { id_entry!(MSM8227AA) },
+    { id_entry!(APQ8074) },
+    { id_entry!(MSM8274) },
+    { id_entry!(MSM8674) },
+    { id_entry!(MDM9635) },
+    { id_entry!(MSM8974PRO_AC, "MSM8974PRO-AC") },
+    { id_entry!(MSM8126) },
+    { id_entry!(APQ8026) },
+    { id_entry!(MSM8926) },
+    { id_entry!(IPQ8062) },
+    { id_entry!(IPQ8064) },
+    { id_entry!(IPQ8066) },
+    { id_entry!(IPQ8068) },
+    { id_entry!(MSM8326) },
+    { id_entry!(MSM8916) },
+    { id_entry!(MSM8994) },
+    { id_entry!(APQ8074PRO_AA, "APQ8074PRO-AA") },
+    { id_entry!(APQ8074PRO_AB, "APQ8074PRO-AB") },
+    { id_entry!(APQ8074PRO_AC, "APQ8074PRO-AC") },
+    { id_entry!(MSM8274PRO_AA, "MSM8274PRO-AA") },
+    { id_entry!(MSM8274PRO_AB, "MSM8274PRO-AB") },
+    { id_entry!(MSM8274PRO_AC, "MSM8274PRO-AC") },
+    { id_entry!(MSM8674PRO_AA, "MSM8674PRO-AA") },
+    { id_entry!(MSM8674PRO_AB, "MSM8674PRO-AB") },
+    { id_entry!(MSM8674PRO_AC, "MSM8674PRO-AC") },
+    { id_entry!(MSM8974PRO_AA, "MSM8974PRO-AA") },
+    { id_entry!(MSM8974PRO_AB, "MSM8974PRO-AB") },
+    { id_entry!(APQ8028) },
+    { id_entry!(MSM8128) },
+    { id_entry!(MSM8228) },
+    { id_entry!(MSM8528) },
+    { id_entry!(MSM8628) },
+    { id_entry!(MSM8928) },
+    { id_entry!(MSM8510) },
+    { id_entry!(MSM8512) },
+    { id_entry!(MSM8936) },
+    { id_entry!(MDM9640) },
+    { id_entry!(MSM8939) },
+    { id_entry!(APQ8036) },
+    { id_entry!(APQ8039) },
+    { id_entry!(MSM8236) },
+    { id_entry!(MSM8636) },
+    { id_entry!(MSM8909) },
+    { id_entry!(MSM8996) },
+    { id_entry!(APQ8016) },
+    { id_entry!(MSM8216) },
+    { id_entry!(MSM8116) },
+    { id_entry!(MSM8616) },
+    { id_entry!(MSM8992) },
+    { id_entry!(APQ8092) },
+    { id_entry!(APQ8094) },
+    { id_entry!(MSM8209) },
+    { id_entry!(MSM8208) },
+    { id_entry!(MDM9209) },
+    { id_entry!(MDM9309) },
+    { id_entry!(MDM9609) },
+    { id_entry!(MSM8239) },
+    { id_entry!(MSM8952) },
+    { id_entry!(APQ8009) },
+    { id_entry!(MSM8956) },
+    { id_entry!(MSM8929) },
+    { id_entry!(MSM8629) },
+    { id_entry!(MSM8229) },
+    { id_entry!(APQ8029) },
+    { id_entry!(APQ8056) },
+    { id_entry!(MSM8609) },
+    { id_entry!(APQ8076) },
+    { id_entry!(MSM8976) },
+    { id_entry!(IPQ8065) },
+    { id_entry!(IPQ8069) },
+    { id_entry!(MDM9650) },
+    { id_entry!(MDM9655) },
+    { id_entry!(MDM9250) },
+    { id_entry!(MDM9255) },
+    { id_entry!(MDM9350) },
+    { id_entry!(APQ8052) },
+    { id_entry!(MDM9607) },
+    { id_entry!(APQ8096) },
+    { id_entry!(MSM8998) },
+    { id_entry!(MSM8953) },
+    { id_entry!(MSM8937) },
+    { id_entry!(APQ8037) },
+    { id_entry!(MDM8207) },
+    { id_entry!(MDM9207) },
+    { id_entry!(MDM9307) },
+    { id_entry!(MDM9628) },
+    { id_entry!(MSM8909W) },
+    { id_entry!(APQ8009W) },
+    { id_entry!(MSM8996L) },
+    { id_entry!(MSM8917) },
+    { id_entry!(APQ8053) },
+    { id_entry!(MSM8996SG) },
+    { id_entry!(APQ8017) },
+    { id_entry!(MSM8217) },
+    { id_entry!(MSM8617) },
+    { id_entry!(MSM8996AU) },
+    { id_entry!(APQ8096AU) },
+    { id_entry!(APQ8096SG) },
+    { id_entry!(MSM8940) },
+    { id_entry!(SDX201) },
+    { id_entry!(SDM660) },
+    { id_entry!(SDM630) },
+    { id_entry!(APQ8098) },
+    { id_entry!(MSM8920) },
+    { id_entry!(SDM845) },
+    { id_entry!(MDM9206) },
+    { id_entry!(IPQ8074) },
+    { id_entry!(SDA660) },
+    { id_entry!(SDM658) },
+    { id_entry!(SDA658) },
+    { id_entry!(SDA630) },
+    { id_entry!(MSM8905) },
+    { id_entry!(SDX202) },
+    { id_entry!(SDM670) },
+    { id_entry!(SDM450) },
+    { id_entry!(SM8150) },
+    { id_entry!(SDA845) },
+    { id_entry!(IPQ8072) },
+    { id_entry!(IPQ8076) },
+    { id_entry!(IPQ8078) },
+    { id_entry!(SDM636) },
+    { id_entry!(SDA636) },
+    { id_entry!(SDM632) },
+    { id_entry!(SDA632) },
+    { id_entry!(SDA450) },
+    { id_entry!(SDM439) },
+    { id_entry!(SDM429) },
+    { id_entry!(SM8250) },
+    { id_entry!(SA8155) },
+    { id_entry!(SDA439) },
+    { id_entry!(SDA429) },
+    { id_entry!(SM7150) },
+    { id_entry!(SM7150P) },
+    { id_entry!(IPQ8070) },
+    { id_entry!(IPQ8071) },
+    { id_entry!(QM215) },
+    { id_entry!(IPQ8072A) },
+    { id_entry!(IPQ8074A) },
+    { id_entry!(IPQ8076A) },
+    { id_entry!(IPQ8078A) },
+    { id_entry!(SM6125) },
+    { id_entry!(IPQ8070A) },
+    { id_entry!(IPQ8071A) },
+    { id_entry!(IPQ8172) },
+    { id_entry!(IPQ8173) },
+    { id_entry!(IPQ8174) },
+    { id_entry!(IPQ6018) },
+    { id_entry!(IPQ6028) },
+    { id_entry!(SDM429W) },
+    { id_entry!(SM4250) },
+    { id_entry!(IPQ6000) },
+    { id_entry!(IPQ6010) },
+    { id_entry!(SC7180) },
+    { id_entry!(SM6350) },
+    { id_entry!(QCM2150) },
+    { id_entry!(SDA429W) },
+    { id_entry!(SM8350) },
+    { id_entry!(QCM2290) },
+    { id_entry!(SM7125) },
+    { id_entry!(SM6115) },
+    { id_entry!(IPQ5010) },
+    { id_entry!(IPQ5018) },
+    { id_entry!(IPQ5028) },
+    { id_entry!(SC8280XP) },
+    { id_entry!(IPQ6005) },
+    { id_entry!(QRB5165) },
+    { id_entry!(SM8450) },
+    { id_entry!(SM7225) },
+    { id_entry!(SA8295P) },
+    { id_entry!(SA8540P) },
+    { id_entry!(QCM4290) },
+    { id_entry!(QCS4290) },
+    { id_entry!(SM7325) },
+    { id_entry!(SM8450_2, "SM8450") },
+    { id_entry!(SM8450_3, "SM8450") },
+    { id_entry!(SC7280) },
+    { id_entry!(SC7180P) },
+    { id_entry!(QCM6490) },
+    { id_entry!(SM7325P) },
+    { id_entry!(IPQ5000) },
+    { id_entry!(IPQ0509) },
+    { id_entry!(IPQ0518) },
+    { id_entry!(SM6375) },
+    { id_entry!(IPQ9514) },
+    { id_entry!(IPQ9550) },
+    { id_entry!(IPQ9554) },
+    { id_entry!(IPQ9570) },
+    { id_entry!(IPQ9574) },
+    { id_entry!(SM8550) },
+    { id_entry!(IPQ5016) },
+    { id_entry!(IPQ9510) },
+    { id_entry!(QRB4210) },
+    { id_entry!(QRB2210) },
+    { id_entry!(SAR2130P) },
+    { id_entry!(SM8475) },
+    { id_entry!(SM8475P) },
+    { id_entry!(SA8255P) },
+    { id_entry!(SA8775P) },
+    { id_entry!(QRU1000) },
+    { id_entry!(SM8475_2) },
+    { id_entry!(QDU1000) },
+    { id_entry!(X1E80100) },
+    { id_entry!(SM8650) },
+    { id_entry!(SM4450) },
+    { id_entry!(SAR1130P) },
+    { id_entry!(QDU1010) },
+    { id_entry!(QRU1032) },
+    { id_entry!(QRU1052) },
+    { id_entry!(QRU1062) },
+    { id_entry!(IPQ5332) },
+    { id_entry!(IPQ5322) },
+    { id_entry!(IPQ5312) },
+    { id_entry!(IPQ5302) },
+    { id_entry!(QCS8550) },
+    { id_entry!(QCM8550) },
+    { id_entry!(IPQ5300) },
+    { id_entry!(IPQ5321) },
+    { id_entry!(IPQ5424) },
+    { id_entry!(IPQ5404) },
+    { id_entry!(QCS9100) },
+    { id_entry!(QCS8300) },
+    { id_entry!(QCS8275) },
+    { id_entry!(QCS9075) },
+    { id_entry!(QCS615) },
+];
+
+pub(crate) const PMIC_MODELS: [Option<&str>; 84] = {
+    let mut models = [None; 84];
+    models[0] = Some("Unknown PMIC model");
+    models[1] = Some("PM8941");
+    models[2] = Some("PM8841");
+    models[3] = Some("PM8019");
+    models[4] = Some("PM8226");
+    models[5] = Some("PM8110");
+    models[6] = Some("PMA8084");
+    models[7] = Some("PMI8962");
+    models[8] = Some("PMD9635");
+    models[9] = Some("PM8994");
+    models[10] = Some("PMI8994");
+    models[11] = Some("PM8916");
+    models[12] = Some("PM8004");
+    models[13] = Some("PM8909/PM8058");
+    models[14] = Some("PM8028");
+    models[15] = Some("PM8901");
+    models[16] = Some("PM8950/PM8027");
+    models[17] = Some("PMI8950/ISL9519");
+    models[18] = Some("PMK8001/PM8921");
+    models[19] = Some("PMI8996/PM8018");
+    models[20] = Some("PM8998/PM8015");
+    models[21] = Some("PMI8998/PM8014");
+    models[22] = Some("PM8821");
+    models[23] = Some("PM8038");
+    models[24] = Some("PM8005/PM8922");
+    models[25] = Some("PM8917/PM8937");
+    models[26] = Some("PM660L");
+    models[27] = Some("PM660");
+    models[30] = Some("PM8150");
+    models[31] = Some("PM8150L");
+    models[32] = Some("PM8150B");
+    models[33] = Some("PMK8002");
+    models[36] = Some("PM8009");
+    models[37] = Some("PMI632");
+    models[38] = Some("PM8150C");
+    models[40] = Some("PM6150");
+    models[41] = Some("SMB2351");
+    models[44] = Some("PM8008");
+    models[45] = Some("PM6125");
+    models[46] = Some("PM7250B");
+    models[47] = Some("PMK8350");
+    models[48] = Some("PM8350");
+    models[49] = Some("PM8350C");
+    models[50] = Some("PM8350B");
+    models[51] = Some("PMR735A");
+    models[52] = Some("PMR735B");
+    models[54] = Some("PM6350");
+    models[55] = Some("PM4125");
+    models[58] = Some("PM8450");
+    models[65] = Some("PM8010");
+    models[69] = Some("PM8550VS");
+    models[70] = Some("PM8550VE");
+    models[71] = Some("PM8550B");
+    models[72] = Some("PMR735D");
+    models[73] = Some("PM8550");
+    models[74] = Some("PMK8550");
+    models[82] = Some("PMC8380");
+    models[83] = Some("SMB2360");
+    models
+};
+
+pub(crate) const IMAGE_NAMES: &[(&CStr, usize)] = &[
+    (c_str!("adsp"), 12),
+    (c_str!("apps"), 10),
+    (c_str!("appsbl"), 9),
+    (c_str!("boot"), 0),
+    (c_str!("cnss"), 13),
+    (c_str!("mpss"), 11),
+    (c_str!("rpm"), 3),
+    (c_str!("tz"), 1),
+    (c_str!("video"), 14),
+    (c_str!("dsps"), 15),
+    (c_str!("cdsp"), 16),
+    (c_str!("cdsp1"), 19),
+    (c_str!("gpdsp"), 20),
+    (c_str!("gpdsp1"), 21),
+    (c_str!("tme"), 28),
+];
diff --git a/drivers/soc/qcom/socinfo_rust/socinfo_rust_file.rs b/drivers/soc/qcom/socinfo_rust/socinfo_rust_file.rs
new file mode 100644
index 0000000000000000000000000000000000000000..6a7f7af807b53341325dd3e5c5318f36efc52b1d
--- /dev/null
+++ b/drivers/soc/qcom/socinfo_rust/socinfo_rust_file.rs
@@ -0,0 +1,538 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2025 Google LLC.
+
+#![recursion_limit = "256"]
+
+//! Re-implementation of Qualcomm's Socinfo driver in Rust
+use core::convert::From;
+use core::fmt;
+use core::fmt::{Debug, Formatter};
+use core::mem::MaybeUninit;
+use kernel::c_str;
+use kernel::debugfs::{Dir, File, Render};
+use kernel::device::Core;
+use kernel::module_platform_driver;
+use kernel::platform::{self, Device};
+use kernel::prelude::*;
+use kernel::soc;
+use kernel::str::CString;
+
+use pin_init::pin_init_from_closure;
+
+mod bindings;
+mod data;
+
+use bindings::{qcom_smem_get, ImageVersion, ImageVersions, PmicArray, PmicEntry, RawSocInfo};
+use data::{IMAGE_NAMES, PMIC_MODELS, SOC_IDS};
+
+module_platform_driver! {
+    type: QcomSocInfo,
+    name: "qcom_socinfo_driver_file_rust",
+    authors: ["Matthew Maurer"],
+    description: "Rust re-implementation of Qualcomm's Socinfo driver",
+    license: "GPL",
+}
+
+#[pin_data]
+struct QcomSocInfo {
+    #[pin]
+    registration: soc::DeviceRegistration,
+    #[pin]
+    _debugfs: QcomSocInfoDebugFs,
+}
+
+#[derive(Default)]
+#[repr(transparent)]
+struct PmicModel(u32);
+
+impl From<u32> for PmicModel {
+    fn from(x: u32) -> Self {
+        Self(x)
+    }
+}
+
+impl Debug for PmicModel {
+    fn fmt(&self, f: &mut Formatter<'_>) -> fmt::Result {
+        let model = SocInfo::version_split(self.0).1;
+        if let Some(Some(model)) = PMIC_MODELS.get(model as usize) {
+            write!(f, "{model}")
+        } else {
+            write!(f, "unknown ({})", model)
+        }
+    }
+}
+
+#[derive(Default)]
+#[repr(transparent)]
+struct PmicDieRev(u32);
+
+impl From<u32> for PmicDieRev {
+    fn from(x: u32) -> Self {
+        Self(x)
+    }
+}
+
+impl Debug for PmicDieRev {
+    fn fmt(&self, f: &mut Formatter<'_>) -> fmt::Result {
+        let (major, minor) = SocInfo::version_split(self.0);
+        write!(f, "{major}.{minor}")
+    }
+}
+
+impl Render for PmicArray {
+    fn render(&self, f: &mut Formatter<'_>) -> fmt::Result {
+        for pmic_entry in self.0 {
+            let (die_rev_major, die_rev_minor) =
+                SocInfo::version_split(u32::from_le(pmic_entry.die_rev));
+            let model_idx = SocInfo::version_split(pmic_entry.model).1 as usize;
+            if let Some(Some(model)) = PMIC_MODELS.get(model_idx) {
+                writeln!(f, "{model} {die_rev_major}.{die_rev_minor}")?
+            } else {
+                writeln!(f, "unknown ({})", pmic_entry.model)?
+            }
+        }
+        Ok(())
+    }
+}
+
+struct Params {
+    info_fmt: u32,
+    build_id: [u8; 32],
+    raw_version: Option<u32>,
+    hardware_platform: Option<u32>,
+    platform_version: Option<u32>,
+    accessory_chip: Option<u32>,
+    hardware_platform_subtype: Option<u32>,
+    pmic_model: Option<PmicModel>,
+    pmic_die_rev: Option<PmicDieRev>,
+    foundry_id: Option<u32>,
+    pmic_model_array: Option<PmicArray>,
+    chip_family: Option<u32>,       // x32
+    raw_device_family: Option<u32>, // x32
+    raw_device_number: Option<u32>, // x32
+    nproduct_id: Option<u32>,
+    chip_id: Option<[u8; 32]>,
+    num_clusters: Option<u32>,
+    ncluster_array_offset: Option<u32>,
+    num_subset_parts: Option<u32>,
+    nsubset_parts_array_offset: Option<u32>,
+    nmodem_supported: Option<u32>,
+    feature_code: Option<u32>,
+    pcode: Option<u32>,
+    oem_variant: Option<u32>,
+    boot_core: Option<u32>,
+    boot_cluster: Option<u32>,
+    num_func_clusters: Option<u32>,
+    versions: Option<ImageVersions>,
+}
+
+#[derive(Copy, Clone)]
+struct SocInfo<'a> {
+    soc_info: RawSocInfo,
+    soc_info_mem: &'a [u8],
+    version_mem: &'a [u8],
+}
+
+impl<'a> SocInfo<'a> {
+    fn from_mem(soc_info_mem: &'a [u8], version_mem: &'a [u8]) -> Self {
+        Self {
+            soc_info: RawSocInfo::from_partial_bytes(soc_info_mem),
+            soc_info_mem,
+            version_mem,
+        }
+    }
+    fn id(&self) -> u32 {
+        u32::from_le(self.soc_info.id)
+    }
+    fn version_split(ver: u32) -> (u16, u16) {
+        let major = (ver >> 16) as u16;
+        let minor = (ver & 0xFFFF) as u16;
+        (major, minor)
+    }
+    fn version_fuse(major: u16, minor: u16) -> u32 {
+        (u32::from(major) << 16) | u32::from(minor)
+    }
+    fn version(&self) -> (u16, u16) {
+        Self::version_split(self.soc_info.ver)
+    }
+    fn serial(&self) -> u32 {
+        u32::from_le(self.soc_info.id)
+    }
+    fn machine(&self) -> Result<Option<CString>> {
+        for soc in SOC_IDS {
+            if soc.id == self.id() {
+                return Ok(Some(soc.name.to_cstring()?));
+            }
+        }
+        Ok(None)
+    }
+    fn device_attribute(&self) -> Result<soc::DeviceAttribute> {
+        Ok(soc::DeviceAttribute {
+            family: Some(c_str!("Snapdragon").to_cstring()?),
+            machine: self.machine()?,
+            revision: Some(CString::try_from_fmt(fmt!(
+                "{}.{}",
+                self.version().0,
+                self.version().1
+            ))?),
+            serial_number: Some(CString::try_from_fmt(fmt!("{}", self.serial()))?),
+            soc_id: Some(CString::try_from_fmt(fmt!("{}", self.id()))?),
+        })
+    }
+}
+
+macro_rules! u32_le_versioned {
+    { $params:expr, $self:ident,
+        [ $( { $major:expr, $minor:expr, { $( $dst:ident: $src:ident ),* } } ),*  ] } => {$(
+        if $params.info_fmt >= SocInfo::version_fuse($major, $minor) {
+            $( $params.$dst = Some(u32::from_le($self.soc_info.$src).into()) );*
+        }
+    )*}
+}
+
+impl SocInfo<'static> {
+    fn build_params(&self) -> Result<Params> {
+        let mut params = Params {
+            build_id: self.soc_info.build_id,
+            info_fmt: u32::from_le(self.soc_info.fmt),
+            raw_version: None,
+            hardware_platform: None,
+            platform_version: None,
+            accessory_chip: None,
+            hardware_platform_subtype: None,
+            pmic_model: None,
+            pmic_die_rev: None,
+            foundry_id: None,
+            pmic_model_array: None,
+            chip_family: None,
+            raw_device_family: None,
+            raw_device_number: None,
+            nproduct_id: None,
+            chip_id: None,
+            num_clusters: None,
+            ncluster_array_offset: None,
+            num_subset_parts: None,
+            nsubset_parts_array_offset: None,
+            nmodem_supported: None,
+            feature_code: None,
+            pcode: None,
+            oem_variant: None,
+            boot_core: None,
+            boot_cluster: None,
+            num_func_clusters: None,
+            versions: None,
+        };
+        u32_le_versioned! { params, self, [
+            {0, 2, { raw_version: raw_ver }},
+            {0, 3, { hardware_platform: hw_plat }},
+            {0, 4, { platform_version: plat_ver }},
+            {0, 5, { accessory_chip: accessory_chip }},
+            {0, 6, { hardware_platform_subtype: hw_plat_subtype }},
+            {0, 7, { pmic_model: pmic_model, pmic_die_rev: pmic_die_rev }},
+            {0, 9, { foundry_id: foundry_id }},
+            {0, 12, {
+                chip_family: chip_family,
+                raw_device_family: raw_device_family,
+                raw_device_number: raw_device_num
+            }},
+            {0, 13, { nproduct_id: nproduct_id }},
+            {0, 14, {
+                num_clusters: num_clusters,
+                ncluster_array_offset: ncluster_array_offset,
+                num_subset_parts: num_subset_parts,
+                nsubset_parts_array_offset: nsubset_parts_array_offset
+            }},
+            {0, 15, { nmodem_supported: nmodem_supported }},
+            {0, 16, { feature_code: feature_code, pcode: pcode }},
+            {0, 17, { oem_variant: oem_variant }},
+            {0, 19, {
+                boot_core: boot_core,
+                boot_cluster: boot_cluster,
+                num_func_clusters: num_func_clusters
+            }}
+        ]};
+        if params.info_fmt >= SocInfo::version_fuse(0, 11) {
+            let offset = u32::from_le(self.soc_info.pmic_array_offset) as usize;
+            let num_pmics = u32::from_le(self.soc_info.num_pmics) as usize;
+            let size = num_pmics * core::mem::size_of::<PmicEntry>();
+            params.pmic_model_array =
+                PmicArray::from_bytes(&self.soc_info_mem[offset..offset + size]);
+        }
+        if params.info_fmt >= SocInfo::version_fuse(0, 13) {
+            params.chip_id = Some(self.soc_info.chip_id);
+        }
+        params.versions = ImageVersions::from_bytes(self.version_mem);
+        Ok(params)
+    }
+}
+
+fn no_quirk<const SIZE: usize>(buf: &[u8; SIZE], f: &mut Formatter<'_>) -> fmt::Result {
+    if buf[0] == 0 {
+        writeln!(f)
+    } else {
+        nul_array(buf, f)
+    }
+}
+
+fn nul_array<const SIZE: usize>(buf: &[u8; SIZE], f: &mut Formatter<'_>) -> fmt::Result {
+    if let Some(end) = buf.iter().position(|x| *x == 0) {
+        if end == 0 {
+            // Match original driver quirk - empty strings don't have a trailing newline
+            return Ok(());
+        }
+        let Ok(c_str) = CStr::from_bytes_with_nul(&buf[0..=end]) else {
+            pr_warn!("Creating CStr from bytes with known first NUL failed?");
+            return Ok(());
+        };
+        writeln!(f, "{c_str}")
+    } else {
+        writeln!(f, "Missing NUL: {buf:?}")
+    }
+}
+
+fn hex(x: &u32, f: &mut Formatter<'_>) -> fmt::Result {
+    writeln!(f, "{x:#010x}")
+}
+
+#[pin_data]
+struct ImageVersionFiles {
+    _dir: Dir,
+    #[pin]
+    name: File<[u8; 75]>,
+    #[pin]
+    variant: File<[u8; 20]>,
+    #[pin]
+    oem: File<[u8; 32]>,
+}
+
+impl ImageVersionFiles {
+    fn create<'a>(
+        parent: &'a Dir,
+        image_name: &'a CStr,
+        version: &'a ImageVersion,
+    ) -> impl PinInit<Self> + 'a {
+        let dir = parent.subdir(image_name);
+        pin_init! {
+            Self {
+                _dir: dir.clone(),
+                name <- dir.read_callback_file(c_str!("name"), version.name, &nul_array),
+                variant <- dir.read_callback_file(c_str!("variant"), version.variant, &nul_array),
+                oem <- dir.read_callback_file(c_str!("oem"), version.oem, &nul_array),
+            }
+        }
+    }
+}
+
+#[pin_data]
+struct QcomSocInfoDebugFs {
+    _dir: Dir,
+    #[pin]
+    info_fmt: File<u32>,
+    #[pin]
+    build_id: File<[u8; 32]>,
+    #[pin]
+    raw_version: Option<File<u32>>,
+    #[pin]
+    hardware_platform: Option<File<u32>>,
+    #[pin]
+    platform_version: Option<File<u32>>,
+    #[pin]
+    accessory_chip: Option<File<u32>>,
+    #[pin]
+    hardware_platform_subtype: Option<File<u32>>,
+    #[pin]
+    pmic_model: Option<File<PmicModel>>,
+    #[pin]
+    pmic_die_rev: Option<File<PmicDieRev>>,
+    #[pin]
+    foundry_id: Option<File<u32>>,
+    #[pin]
+    pmic_model_array: Option<File<PmicArray>>,
+    #[pin]
+    chip_family: Option<File<u32>>,
+    #[pin]
+    raw_device_family: Option<File<u32>>,
+    #[pin]
+    raw_device_number: Option<File<u32>>,
+    #[pin]
+    nproduct_id: Option<File<u32>>,
+    #[pin]
+    chip_id: Option<File<[u8; 32]>>,
+    #[pin]
+    num_clusters: Option<File<u32>>,
+    #[pin]
+    ncluster_array_offset: Option<File<u32>>,
+    #[pin]
+    num_subset_parts: Option<File<u32>>,
+    #[pin]
+    nsubset_parts_array_offset: Option<File<u32>>,
+    #[pin]
+    nmodem_supported: Option<File<u32>>,
+    #[pin]
+    feature_code: Option<File<u32>>,
+    #[pin]
+    pcode: Option<File<u32>>,
+    #[pin]
+    oem_variant: Option<File<u32>>,
+    #[pin]
+    boot_core: Option<File<u32>>,
+    #[pin]
+    boot_cluster: Option<File<u32>>,
+    #[pin]
+    num_func_clusters: Option<File<u32>>,
+    versions: KVec<Pin<KBox<ImageVersionFiles>>>,
+}
+
+// TODO this doesn't seem like we should be defining it here, but without it,
+// it's hard to construct an `Option<File<u32>>`, which is required for this driver.
+fn pin_init_option<T, R, F, E, PI>(val: Option<T>, f: F) -> impl PinInit<Option<R>, E>
+where
+    F: FnOnce(T) -> PI,
+    PI: PinInit<R, E>,
+{
+    let init = move |slot: *mut Option<R>| -> Result<(), E> {
+        let Some(val) = val else {
+            // SAFETY: The constructor guarantees we're called with a writable pointer
+            unsafe { core::ptr::write(slot, None) };
+            return Ok(());
+        };
+
+        let slot_uninit: *mut Option<MaybeUninit<R>> = slot.cast();
+        // SAFETY: The constructor guarantees we're called with a writable pointer
+        // *mut Option<MaybeUninit<R>> is layout compatible with `Option<R>`
+        unsafe { core::ptr::write(slot_uninit, Some(MaybeUninit::uninit())) };
+        // SAFETY: We just initialized it, and we have unique access
+        let inner_slot: *mut R = unsafe { (*slot_uninit).as_mut().unwrap().as_mut_ptr() };
+        // SAFETY: `inner_slot` is a pointer to the uninitialized portion of the option.
+        if let Err(e) = unsafe { f(val).__pinned_init(inner_slot) } {
+            // Wipe out slot with a safe default
+            // SAFETY: The slot is still writable, and the other initializer has cleared out
+            // the payload.
+            unsafe { core::ptr::write(slot, None) };
+            return Err(e);
+        }
+
+        // Since we've initialized the `MaybeUninit` portion, we're fully initialized.
+        Ok(())
+    };
+
+    // SAFETY: If val is None, we always fully initialize it. If we successfully run the
+    // initializer, we fully initialize the Some arm. If we fail to run the initializer, we wipe it
+    // out with None before returning.
+    unsafe { pin_init_from_closure(init) }
+}
+
+macro_rules! create_optional_file {
+    ($dir:expr, $name:expr, $value:expr) => {
+        pin_init_option($value, |v| $dir.read_only_file(c_str!($name), v))
+    };
+    ($dir:expr, $name:expr, $value:expr, $callback:expr) => {
+        pin_init_option($value, |v| {
+            $dir.read_callback_file(c_str!($name), v, $callback)
+        })
+    };
+}
+
+fn create_version_files(
+    parent: &Dir,
+    versions: Option<ImageVersions>,
+) -> Result<KVec<Pin<KBox<ImageVersionFiles>>>> {
+    let mut res = KVec::new();
+    if let Some(v) = versions.as_ref() {
+        for (image_name, idx) in IMAGE_NAMES {
+            if let Some(version) = v.0.get(*idx) {
+                res.push(
+                    KBox::pin_init(
+                        ImageVersionFiles::create(parent, image_name, version),
+                        GFP_KERNEL,
+                    )?,
+                    GFP_KERNEL,
+                )?;
+            }
+        }
+    }
+    Ok(res)
+}
+
+impl QcomSocInfoDebugFs {
+    fn create(mut params: Params) -> impl PinInit<Self, Error> {
+        let dir = Dir::new(c_str!("qcom_socinfo_rs_file"));
+        let versions_data = params.versions.take();
+        try_pin_init! {
+            Self {
+                _dir: dir.clone(),
+                info_fmt <- dir.read_callback_file(c_str!("info_fmt"), params.info_fmt, &hex),
+                build_id <- dir.read_callback_file(c_str!("build_id"), params.build_id, &no_quirk),
+                raw_version <- create_optional_file!(dir, "raw_version", params.raw_version),
+                hardware_platform <- create_optional_file!(dir, "hardware_platform",
+                    params.hardware_platform),
+                platform_version <- create_optional_file!(dir, "platform_version",
+                    params.platform_version),
+                accessory_chip <- create_optional_file!(dir, "accessory_chip",
+                    params.accessory_chip),
+                hardware_platform_subtype <- create_optional_file!(dir,
+                    "hardware_platform_subtype", params.hardware_platform_subtype),
+                raw_device_number <- create_optional_file!(dir, "raw_device_number",
+                    params.raw_device_number, &hex),
+                raw_device_family <- create_optional_file!(dir, "raw_device_family",
+                    params.raw_device_family, &hex),
+                chip_family <- create_optional_file!(dir, "chip_family", params.chip_family, &hex),
+                chip_id <- create_optional_file!(dir, "chip_id", params.chip_id, &nul_array),
+                nproduct_id <- create_optional_file!(dir, "nproduct_id", params.nproduct_id),
+                nsubset_parts_array_offset <- create_optional_file!(dir,
+                    "nsubset_parts_array_offset", params.nsubset_parts_array_offset),
+                num_subset_parts <- create_optional_file!(dir, "num_subset_parts",
+                    params.num_subset_parts),
+                ncluster_array_offset <- create_optional_file!(dir, "ncluster_array_offset",
+                    params.ncluster_array_offset),
+                num_clusters <- create_optional_file!(dir, "num_clusters", params.num_clusters),
+                nmodem_supported <- create_optional_file!(dir, "nmodem_supported",
+                    params.nmodem_supported),
+                pcode <- create_optional_file!(dir, "pcode", params.pcode),
+                feature_code <- create_optional_file!(dir, "feature_code", params.feature_code),
+                oem_variant <- create_optional_file!(dir, "oem_variant", params.oem_variant),
+                boot_core <- create_optional_file!(dir, "boot_core", params.boot_core),
+                boot_cluster <- create_optional_file!(dir, "boot_cluster", params.boot_cluster),
+                num_func_clusters <- create_optional_file!(dir, "num_func_clusters",
+                    params.num_func_clusters),
+                foundry_id <- create_optional_file!(dir, "foundry_id", params.foundry_id),
+                pmic_model <- create_optional_file!(dir, "pmic_model", params.pmic_model),
+                pmic_die_rev <- create_optional_file!(dir, "pmic_die_rev", params.pmic_die_rev),
+                pmic_model_array <- create_optional_file!(dir, "pmic_model_array",
+                    params.pmic_model_array),
+                versions: create_version_files(&dir, versions_data)?,
+            } ? Error
+        }
+    }
+}
+
+impl platform::Driver for QcomSocInfo {
+    type IdInfo = ();
+    const OF_ID_TABLE: Option<kernel::of::IdTable<Self::IdInfo>> = None;
+    fn probe(_dev: &Device<Core>, _id_info: Option<&Self::IdInfo>) -> Result<Pin<KBox<Self>>> {
+        let soc_info_mem = qcom_smem_get(
+            kernel::bindings::QCOM_SMEM_HOST_ANY,
+            kernel::bindings::SMEM_HW_SW_BUILD_ID,
+        )?;
+        let version_mem = qcom_smem_get(
+            kernel::bindings::QCOM_SMEM_HOST_ANY,
+            bindings::SMEM_IMAGE_VERSION_TABLE,
+        )?;
+        let info = SocInfo::from_mem(soc_info_mem, version_mem);
+        let params = info.build_params()?;
+        let soc_info = KBox::pin_init(
+            try_pin_init!(
+                    Self {
+                        registration <- soc::DeviceRegistration::register(info.device_attribute()?),
+                        _debugfs <- QcomSocInfoDebugFs::create(params),
+                    } ? Error
+            ),
+            GFP_KERNEL,
+        )?;
+
+        kernel::rand::add_device_randomness(soc_info_mem);
+
+        Ok(soc_info)
+    }
+}
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index afe8be55a6db1d29706c19a91dc51c1ae3494ed4..f22320757e76a77df0e95bdb5bb43afc8cd51616 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -80,6 +80,12 @@
 #include <linux/xarray.h>
 #include <trace/events/rust_sample.h>
 
+#if defined(CONFIG_QCOM_SOCINFO_RUST)
+#include <dt-bindings/arm/qcom,ids.h>
+#include <linux/soc/qcom/smem.h>
+#include <linux/soc/qcom/socinfo.h>
+#endif
+
 #if defined(CONFIG_DRM_PANIC_SCREEN_QR_CODE)
 // Used by `#[export]` in `drivers/gpu/drm/drm_panic_qr.rs`.
 #include <drm/drm_panic.h>

-- 
2.51.0.rc1.167.g924127e9c0-goog


