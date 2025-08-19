Return-Path: <linux-kernel+bounces-776626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BCA0B2CFA4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 01:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2EA1564D99
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 23:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42674274B30;
	Tue, 19 Aug 2025 23:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jL8Xmjqd"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4837A2749E0
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 23:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755645171; cv=none; b=PcMZEjJe+Qf08OU4t6ejN5677Ql8eCKcy35w8OueTycfliFxWlLb4r43HCifnHszOr5NxYg7kX9AAp0tVsnkg7Xj0DUuGmac7tfVc7HSC/079YTDJg0dSr7rz7y4/NPbMJns9GpjuGVPvzstR3uRUGclFhJDtbyvoIzWPmGly0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755645171; c=relaxed/simple;
	bh=7eKYiaufNGwLTTAPneefnNQO9hw86a6+BTDqQ54HWO4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oQCx1/TGWsgYAUqdCnaO4Zoo/uoLtUC4WajxBjzsOzjFm1jS4Zzqc/wzsY9HTTo7fn6PKl9z0ZkUCOQibXq1OFzDdhGQO5fcQPrVUm66wXBJPsllQXMqLXn3N3BG8gdU8YUPmong7+U35jiDEEUoQFf9NlEqLEHHkO7qZWuZxU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jL8Xmjqd; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b4731a95babso3384692a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 16:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755645169; x=1756249969; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vIkRKJVVbXpIA0Q8Uz/N+8okJDygRUzTlMPl28XgWG0=;
        b=jL8XmjqdsSAxSHTNgPd6bWG2WcV6w837Aq4EyfkYf2EtGrCWFrFHrvHh5AoY1D0Wbk
         FkTeIDOe8F85ZY35sWPkm61n0iwQ2OfDO+RkUgmxA+fIy/2rzLD01xKwBiHtsczxU2eu
         CZg7MazwEmpRtLJ+KurWCVw8BDR+4JmPQZOTkvZVO4vfuXbksZAjhfzh5CrsZojvJ7G6
         yuVqk07eYGXDcM0aj5PSNMysuFilG/K4xyso3Kk54qEofzl7Ywca2X4XwjDVoU/SZDsb
         pMBTzNsah9dpUF210aL3GsZNc5FuVJxZ4lxGclwfNZcWtmqn2q+yf/cJPPs6e4CS9tsB
         BC6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755645169; x=1756249969;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vIkRKJVVbXpIA0Q8Uz/N+8okJDygRUzTlMPl28XgWG0=;
        b=iEoMlbsNJxC1tXfZENrdIEnFwpFjfnCpzFvsj2eIiePlQ8d2MivWK88zOb0OJapIcO
         plnCXAbSDz1N1sebCSxMhdpT1S1Lm44r5a2CAl29QQ7Fh+lZWqtBfYCsc9HnPp7tW+Wa
         vNVN1awmUhK47WFicvsD8kf2A9gp60OCUNz5Cy7MjOpmnAE6zuKTWzkFDOwMstNSQDqM
         6DBSYl5O1nu8k0pES5celsWSdFQ9mOorFg8qRsdtAljHlK+6luaCcOSBHcJvzWetbzhb
         xyRiYFlW+V4YLSmE13Zg5hGnAGvVvp9qPUrYt035SFBG2VdyWFW9nIlWhEJWLFTD9JtF
         D9FQ==
X-Gm-Message-State: AOJu0YzP4/HyFcsvWjxFgCQajiF63L3P+wJhAYodocJBM2TShIWGN32x
	wUsp0uzcE8Fp9RdIKKPLI5Yy1Lc3VYR/pf6HTRlIZb+YV6ZoAFzhbQUEjDpxwgLTmj7S5bDSImu
	FwUoKFxQIPA==
X-Google-Smtp-Source: AGHT+IH37StamLcK4PUuMQX1SIjU099+9OwF+NOr0jmIc/CH8Ekd7AK6CCkeKjzT4mOsz+mtgz8B98L2ho60
X-Received: from plbjb20.prod.google.com ([2002:a17:903:2594:b0:23f:8c3f:e0fc])
 (user=mmaurer job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:124f:b0:242:9aaa:1351
 with SMTP id d9443c01a7336-245ef141014mr8892105ad.13.1755645168739; Tue, 19
 Aug 2025 16:12:48 -0700 (PDT)
Date: Tue, 19 Aug 2025 23:12:36 +0000
In-Reply-To: <20250819-qcom-socinfo-v1-0-e8d32cc81270@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250819-qcom-socinfo-v1-0-e8d32cc81270@google.com>
X-Developer-Key: i=mmaurer@google.com; a=ed25519; pk=2Ezhl7+fEjTOMVFpplDeak2AdQ8cjJieLRVJdNzrW+E=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755645158; l=15022;
 i=mmaurer@google.com; s=20250429; h=from:subject:message-id;
 bh=7eKYiaufNGwLTTAPneefnNQO9hw86a6+BTDqQ54HWO4=; b=NiDQ5GqxoZBbHYIMb/oLre/hEihqmcraM0PQ3RDaFPDPPTmbHiIpBrroSwh8XhC+eB2i0GGqR
 zfh/Zbvnp1CCbgUxvJi2qkix0T1sP3dgYMe4jf8nNXzg8M9rv78qHvF
X-Mailer: b4 0.14.2
Message-ID: <20250819-qcom-socinfo-v1-5-e8d32cc81270@google.com>
Subject: [PATCH WIP 5/5] soc: qcom: socinfo: `Scoped`-based example
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

Re-implements qcom-socinfo driver in Rust, using `Scoped`-based DebugFS
bindings.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 drivers/soc/qcom/Makefile                          |   1 +
 drivers/soc/qcom/smem.c                            |   7 +-
 .../soc/qcom/socinfo_rust/socinfo_rust_scoped.rs   | 367 +++++++++++++++++++++
 3 files changed, 374 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index 6453a4f4f7da89d4e1677ad8f75257e94cec90f4..ab76fc1d6ae10bef74adbc1489518379b7d5c00b 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -41,3 +41,4 @@ obj-$(CONFIG_QCOM_INLINE_CRYPTO_ENGINE)	+= qcom_ice.o
 obj-$(CONFIG_QCOM_PBS) +=	qcom-pbs.o
 obj-$(CONFIG_QCOM_UBWC_CONFIG) += ubwc_config.o
 obj-$(CONFIG_QCOM_SOCINFO_RUST) += socinfo_rust/socinfo_rust_file.o
+obj-$(CONFIG_QCOM_SOCINFO_RUST) += socinfo_rust/socinfo_rust_scoped.o
diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index 5279db46a1e0dd7b2994b79d131367175e35290f..6810f0cdd37d7f393977ffeae5836f47132988c7 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -1230,13 +1230,18 @@ static int qcom_smem_probe(struct platform_device *pdev)
 
 	__smem = smem;
 
-	// TODO don't double load, this is just to diff the debugfs
+	// TODO don't triple load, this is just to diff the debugfs
 	smem->socinfo = platform_device_register_data(&pdev->dev, "qcom-socinfo",
 						      PLATFORM_DEVID_NONE, NULL, 0);
 	// TODO MODULE_ALIAS
 	smem->socinfo = platform_device_register_data(&pdev->dev, "qcom_socinfo_driver_file_rust",
 						      PLATFORM_DEVID_NONE, NULL,
 						      0);
+	// TODO MODULE_ALIAS
+	smem->socinfo = platform_device_register_data(&pdev->dev, "qcom_socinfo_driver_scoped_rust",
+						      PLATFORM_DEVID_NONE, NULL,
+						      0);
+
 	if (IS_ERR(smem->socinfo))
 		dev_dbg(&pdev->dev, "failed to register socinfo device\n");
 
diff --git a/drivers/soc/qcom/socinfo_rust/socinfo_rust_scoped.rs b/drivers/soc/qcom/socinfo_rust/socinfo_rust_scoped.rs
new file mode 100644
index 0000000000000000000000000000000000000000..845e91560a7879d4cf13c6b62fd9ad8a15c79826
--- /dev/null
+++ b/drivers/soc/qcom/socinfo_rust/socinfo_rust_scoped.rs
@@ -0,0 +1,367 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2025 Google LLC.
+
+//! Re-implementation of Qualcomm's Socinfo driver in Rust
+use core::convert::From;
+use core::fmt;
+use core::fmt::{Debug, Formatter};
+use kernel::c_str;
+use kernel::debugfs::{Render, Scope, ScopedDir};
+use kernel::device::Core;
+use kernel::module_platform_driver;
+use kernel::platform::{self, Device};
+use kernel::prelude::*;
+use kernel::soc;
+use kernel::str::CString;
+
+mod bindings;
+mod data;
+
+use bindings::{qcom_smem_get, ImageVersion, ImageVersions, PmicArray, PmicEntry, RawSocInfo};
+use data::{IMAGE_NAMES, PMIC_MODELS, SOC_IDS};
+
+module_platform_driver! {
+    type: QcomSocInfo,
+    name: "qcom_socinfo_driver_scoped_rust",
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
+    params: Scope<Params>,
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
+#[derive(Default)]
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
+            ..Default::default()
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
+macro_rules! value_attrs {
+    ($builder:ident, $params:ident, @) => {};
+    ($builder:ident, $params:ident, @ $s:ident $($rest:tt)*) => {
+        if let Some(v) = $params.$s.as_ref() {
+            $builder.read_only_file(c_str!(stringify!($s)), v);
+        }
+        value_attrs!($builder, $params, @ $($rest)*)
+    };
+    ($builder:ident, $params:ident, @ {$s:ident, $cb:expr} $($rest:tt)*) => {
+        if let Some(v) = $params.$s.as_ref() {
+            $builder.read_callback_file(c_str!(stringify!($s)), v, $cb);
+        }
+        value_attrs!($builder, $params, @ $($rest)*)
+    };
+    ($builder:ident, $params:ident, {$($items:tt),*}) => {
+        value_attrs!($builder, $params, @ $($items)*)
+    };
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
+impl ImageVersion {
+    fn build_debugfs<'a>(&'a self, dir: &ScopedDir<'a, '_>, image_name: &CStr) {
+        let subdir = dir.dir(image_name);
+        subdir.read_callback_file(c_str!("name"), &self.name, &nul_array);
+        subdir.read_callback_file(c_str!("variant"), &self.variant, &nul_array);
+        subdir.read_callback_file(c_str!("oem"), &self.oem, &nul_array);
+    }
+}
+
+fn hex(x: &u32, f: &mut Formatter<'_>) -> fmt::Result {
+    writeln!(f, "{x:#010x}")
+}
+
+impl Params {
+    fn build_debugfs<'data>(&'data self, dir: &ScopedDir<'data, '_>) {
+        dir.read_callback_file(c_str!("info_fmt"), &self.info_fmt, &hex);
+        dir.read_callback_file(c_str!("build_id"), &self.build_id, &no_quirk);
+        value_attrs!(dir, self, {
+            raw_version,
+            hardware_platform,
+            platform_version,
+            accessory_chip,
+            hardware_platform_subtype,
+            {raw_device_number, &hex},
+            {raw_device_family, &hex},
+            {chip_family, &hex},
+            {chip_id, &nul_array},
+            nproduct_id,
+            nsubset_parts_array_offset,
+            num_subset_parts,
+            ncluster_array_offset,
+            num_clusters,
+            nmodem_supported,
+            pcode,
+            feature_code,
+            oem_variant,
+            boot_core,
+            boot_cluster,
+            num_func_clusters,
+            foundry_id,
+            pmic_model,
+            pmic_die_rev,
+            pmic_model_array
+        });
+        if let Some(versions) = self.versions.as_ref() {
+            for (image_name, idx) in IMAGE_NAMES {
+                if let Some(version) = versions.0.get(*idx) {
+                    version.build_debugfs(dir, image_name);
+                }
+            }
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
+        let backing = info.build_params()?;
+        let soc_info = KBox::pin_init(
+            try_pin_init!(
+                    Self {
+                        registration <- soc::DeviceRegistration::register(info.device_attribute()?),
+                        params <- Scope::dir(backing, c_str!("qcom_socinfo_rs_scoped"),
+                                             Params::build_debugfs),
+                    }
+            ),
+            GFP_KERNEL,
+        )?;
+
+        kernel::rand::add_device_randomness(soc_info_mem);
+
+        Ok(soc_info)
+    }
+}

-- 
2.51.0.rc1.167.g924127e9c0-goog


