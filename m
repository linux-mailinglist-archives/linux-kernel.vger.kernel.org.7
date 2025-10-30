Return-Path: <linux-kernel+bounces-878606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E61FC21189
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D137189C2E5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70EE53655E5;
	Thu, 30 Oct 2025 16:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ltUgrmeT"
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010062.outbound.protection.outlook.com [52.101.56.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFCFB640;
	Thu, 30 Oct 2025 16:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761840241; cv=fail; b=oT9dnfSWdEmOVpD+A0FDji9wxMgRXpsC0HhZ779w5H8WC4XrU817wj/watll/jnXWURydVw93/ssiwZ9sG2yVI79ZXNEib+bXgRGPLEQLW1uFii5eB3mEU3oh/7yKFbw0VBgckAFS0sS92LXAK4c9cAfVNFIB5O9Dk1/Zwkqh7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761840241; c=relaxed/simple;
	bh=NNI/ap9A6vABeifh/IiNznYL0lmDe+k6G2d20L3JU6I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CI+tK1k6npX+pN273wv/K8SNHNlM4SrKEH1EwALjIo3TH1xotdFmanCJhlw2vFKx4AvGEASr/H4ABpUPIzw0aAuyYZzQxyevuLDa3CRC8J8cJKCkn8ijz7+nZjEjU3X3UeAse8lwgRPIUYtfNDymfje8PFDMM9wCyVGPs5lML98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ltUgrmeT; arc=fail smtp.client-ip=52.101.56.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TKn1UySLJhFiSKONo7eBfWF4S9dOE9RG55nZfm1dudqamMMA0sXZJTbuiF/susjouK6nCEOi+Ogo7GOpZhQl0gEwGkzZPllz2f+KU48CnoRuw5yLELd7HAYnW36KIvVpcXz95wkUJ58OP7zzUgbrt77E3P7E4nDjnvvlvSaa592Ej0T2dNneo6L6fTajiR16KdDLyjvsKHcLtz6bc3D7s0l7fq9HZ4HvFN2dJhUmXoCUuzNw8tGGK90rtg6pH0av1+fiR1jfIB+kD9HM4aflAGjcR8fECvYGnZn3fTcIXYuZG2fe2kW2cPhtBvmB6YhdQW6jzSBFnrVvJkaSwKgxIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vYzVjS7OYsZmH4Fazo2IatsShR7L2ECN0Msqmzt133E=;
 b=IRfER8LVE8OqvutLp5pMpxcrFH3zeOUEu5yT0oFbkgfPaKwQZE/NDZq8+4NpSCMDsc/gUfMXvYRyptbvasRzSf/wVMzU4FT1hK7dYCwyWGUzAaRqH6RzXWzv9lOLcOtD+/48r+ZsFFz4t8k7++MYBExBgkAU85bbkOaTyhyW6MgVXhRIuc0b/6K/LzNEJPIKyadBfWXP7Yrgpj+OrooLo0QYFjc0QAytD3eg+ZVWIYSLBNCo0agtOMShd2vE1PtKhUYwSWSCKLV1o/U4Ur/qZ/PV55Uum6oZ41xb/Xi/nN8B48xu1+VgalaHwRmDzekPefz+KTEUGDv5CyhIDmi+QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vYzVjS7OYsZmH4Fazo2IatsShR7L2ECN0Msqmzt133E=;
 b=ltUgrmeTeW2vPmuiBxXfELLELpbBg3MuFPgh9F5FfsE1Vacy7sj+F0z4Qo/008zkeU63NxHPk8KPgjYpsBgG09sDzgLnLOD2OU7fclnToRYEuEbi+srbEnFecgF8JqIa1lAdZtIJ0dh9AQZCw6YFcx9Gnq+36WQO8eeQskr4j5ll/+LSutbRqwksgSR5vqahM1dDxquysBHpaKE6Ukmz0MxMmHyyFUULe4xCh7VtHb9brQEBetoVd8XIfr1OYNS1/R49r+EIAzVoymbDaNZD5uQb6ar3Tsb8aZHMfbIMRlgLU3A9YP8ePuvdbiogCp+Fu36rB2kFxQSfp1+ij7U9Dg==
Received: from BLAPR03CA0112.namprd03.prod.outlook.com (2603:10b6:208:32a::27)
 by SA3PR12MB7949.namprd12.prod.outlook.com (2603:10b6:806:31a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 16:03:54 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:208:32a:cafe::c0) by BLAPR03CA0112.outlook.office365.com
 (2603:10b6:208:32a::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.19 via Frontend Transport; Thu,
 30 Oct 2025 16:03:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 16:03:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 30 Oct
 2025 09:03:29 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 09:03:28 -0700
Received: from ipp2-2168.ipp2a1.colossus.nvidia.com (10.127.8.14) by
 mail.nvidia.com (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Thu, 30 Oct 2025 09:03:28 -0700
From: Zhi Wang <zhiw@nvidia.com>
To: <rust-for-linux@vger.kernel.org>
CC: <dakr@kernel.org>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
	<ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
	<gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
	<a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
	<linux-kernel@vger.kernel.org>, <cjia@nvidia.com>, <smitra@nvidia.com>,
	<ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
	<targupta@nvidia.com>, <zhiw@nvidia.com>, <zhiwang@kernel.org>,
	<alwilliamson@nvidia.com>, <acourbot@nvidia.com>, <joelagnelf@nvidia.com>,
	<jhubbard@nvidia.com>, <jgg@nvidia.com>
Subject: [RFC 2/2] samples: rust: fwctl: add sample code for FwCtl
Date: Thu, 30 Oct 2025 16:03:13 +0000
Message-ID: <20251030160315.451841-3-zhiw@nvidia.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251030160315.451841-1-zhiw@nvidia.com>
References: <20251030160315.451841-1-zhiw@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|SA3PR12MB7949:EE_
X-MS-Office365-Filtering-Correlation-Id: a59677cc-1010-4c63-ffab-08de17cdeca6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9ADc/JYwQmrJSVcCv2X8zAyTz9f+DjWFbozm+JleRHd/utgH/HluM4kmU5Va?=
 =?us-ascii?Q?EI1+/fbdhkI8fsCDKGjaaLCwgob6mbUwSSPzvB14BAU89yEIgScoc8CNOBTF?=
 =?us-ascii?Q?/l7//nvFE/dDVYehc1+OgatNiq/tzW9qi13tBhBwcCGvAljwK/cfFLwjPbeq?=
 =?us-ascii?Q?K8KEUKKhnDu49DgU7VxWABd0fJe+o6fRg6lz0WSesG5pWUmC0brOR37yd9YQ?=
 =?us-ascii?Q?kkPqKiJ3q2WRyShaSa7u6OjbAswV52O7k+rUONzKLGwgEPNjIiW6bSRfgE4T?=
 =?us-ascii?Q?Ve0833T3p8MG7ZBCLQDTjSJ6kI82ikAC1aNqNuPM4Tf/mYmNgcqoDH9ruB2w?=
 =?us-ascii?Q?dAQursO/dZ5jGQeIeDe7CLlkRz3Tnxv7PhyazLSiR6DyXW0VfFoEb6rw+A/1?=
 =?us-ascii?Q?SgTTJWHOQ82jzRgUfWlAEPxBL0Sgz965wIDZLQpFX+iQLtdCSosonrGhtywT?=
 =?us-ascii?Q?Fz0TvL4a0/Y62Qbdmv4LLDNuQ24McKZWRImoxxs8b/ZahXUGEIvlLp6g/b/F?=
 =?us-ascii?Q?7TtZPcpex+M5C5QswdPuYT3pYFTLHNQex/p5rRPXnnxfxvRcO3baBT7215d3?=
 =?us-ascii?Q?+YFK5OiPQxd7UrLWgmVoYxOmT+wUj8ME047358mvogXdHCNm5bcroact2La/?=
 =?us-ascii?Q?G/PekX05cbnxPYPoPOvj44WdpOJDpN1ITYAOyiK7hTeDOvmZEZ2Rw079FRJR?=
 =?us-ascii?Q?NsDds9nMxL0eukA23HJl4IJgCvP9BL/FasWUu98jgFDAlSdBXpLmZlOjp8+n?=
 =?us-ascii?Q?ZfyD+LkGJZ7hSqoAZu7SyABttv9rR2VI5ppsjYroKOvzvcW+zlN2HXsnYHtI?=
 =?us-ascii?Q?tZ1g+A4NeEcl+ROfTqh400B6HbYUmDwIdv08hY/EfZhQZtBa1uPt//XMDmo1?=
 =?us-ascii?Q?18UY7Vd4wAu5keVjddbYkztXQhftb8yvDeHjE32r/9Pltoc3UiI2VbHQcAbK?=
 =?us-ascii?Q?3L6Vo4TMGcbRqw69wfAwGv8Cuxfb9aKXITE2WfzLtfLhqxcsim0SrS0rNwO0?=
 =?us-ascii?Q?J4XUKwscAKRWFzBdTdTow2ROfNSm8DiAL0KR4uaq9iDbx0eMsWjUEjMLLB2s?=
 =?us-ascii?Q?UteGzBnUMz2qFXW9mw7uqpJ2kmhfIkQ4FiG9gzJ29qS/tF879foR4rMyz+BD?=
 =?us-ascii?Q?RCc8CtPEsm1zMavrWmsiasxO+rCpj+uXTdeyxtMCu8566RC8ekfJw3tVvFGn?=
 =?us-ascii?Q?mHxxggW85jTP2WHqVNfZw/gkK3cl8tCmAFdM/i+l7fXzbUhbDP/mkdHdUZt7?=
 =?us-ascii?Q?N9XBXyImLAScz5vpInsc9yH8+0qKTNuD9WPBuNsfna7oSBEvSYka+a4QdBVo?=
 =?us-ascii?Q?q5q7SFxR+FrTXuTXQEkvI+dvrSrxdTKkPjDVB7Wxd+/61ClzsaaTdOI9Dp3p?=
 =?us-ascii?Q?KR3k/S2t8Zc92G7d0CFrDZ5sGiwWh3BjaDIentwk7O+ibjf6dGZ5I924EAKq?=
 =?us-ascii?Q?gcwuHHqQ6CqarSoL9blxx6NrpeBPGqWO7k5nfh1My4XEECetlU2V/DwJcIvt?=
 =?us-ascii?Q?xkq7+Lz4n6YilJriOlchUpCmF6+3Zqih2M4SXF/00+t7ijyH0LF0q84zc0av?=
 =?us-ascii?Q?Ze8sW4REHomOi/K8FOQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 16:03:53.7554
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a59677cc-1010-4c63-ffab-08de17cdeca6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7949

Add sample code for creating a FwCtl device, getting device info and
issuing an RPC.

Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 include/uapi/fwctl/fwctl.h        |   1 +
 samples/rust/Kconfig              |  11 +++
 samples/rust/Makefile             |   1 +
 samples/rust/rust_driver_fwctl.rs | 123 ++++++++++++++++++++++++++++++
 4 files changed, 136 insertions(+)
 create mode 100644 samples/rust/rust_driver_fwctl.rs

diff --git a/include/uapi/fwctl/fwctl.h b/include/uapi/fwctl/fwctl.h
index 716ac0eee42d..eea1020ad180 100644
--- a/include/uapi/fwctl/fwctl.h
+++ b/include/uapi/fwctl/fwctl.h
@@ -45,6 +45,7 @@ enum fwctl_device_type {
 	FWCTL_DEVICE_TYPE_MLX5 = 1,
 	FWCTL_DEVICE_TYPE_CXL = 2,
 	FWCTL_DEVICE_TYPE_PDS = 4,
+	FWCTL_DEVICE_TYPE_RUST_FWCTL_TEST = 8,
 };
 
 /**
diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
index c376eb899b7a..54ed2b0b86e2 100644
--- a/samples/rust/Kconfig
+++ b/samples/rust/Kconfig
@@ -138,6 +138,17 @@ config SAMPLE_RUST_DRIVER_AUXILIARY
 
 	  If unsure, say N.
 
+config SAMPLE_RUST_DRIVER_FWCTL
+	tristate "Fwctl Driver"
+	depends on FWCTL
+	help
+	  This option builds the Rust Fwctl driver sample.
+
+	  To compile this as a module, choose M here:
+	  the module will be called rust_driver_fwctl.
+
+	  If unsure, say N.
+
 config SAMPLE_RUST_HOSTPROGS
 	bool "Host programs"
 	help
diff --git a/samples/rust/Makefile b/samples/rust/Makefile
index cf8422f8f219..643208c2380e 100644
--- a/samples/rust/Makefile
+++ b/samples/rust/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_SAMPLE_RUST_DRIVER_PLATFORM)	+= rust_driver_platform.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_USB)		+= rust_driver_usb.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_FAUX)		+= rust_driver_faux.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_AUXILIARY)	+= rust_driver_auxiliary.o
+obj-$(CONFIG_SAMPLE_RUST_DRIVER_FWCTL)		+= rust_driver_fwctl.o
 obj-$(CONFIG_SAMPLE_RUST_CONFIGFS)		+= rust_configfs.o
 
 rust_print-y := rust_print_main.o rust_print_events.o
diff --git a/samples/rust/rust_driver_fwctl.rs b/samples/rust/rust_driver_fwctl.rs
new file mode 100644
index 000000000000..386299eaf82c
--- /dev/null
+++ b/samples/rust/rust_driver_fwctl.rs
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust fwctl API test (based on QEMU's `pci-testdev`).
+//!
+//! To make this driver probe, QEMU must be run with `-device pci-testdev`.
+
+use kernel::{
+    bindings, device::Core, fwctl, fwctl::FwCtlOps, fwctl::FwCtlUCtx, pci, prelude::*,
+    sync::aref::ARef,
+};
+
+struct FwCtlSampleUCtx {
+    _drvdata: u32,
+}
+
+struct FwCtlSampleOps;
+
+impl FwCtlOps for FwCtlSampleOps {
+    type UCtx = FwCtlSampleUCtx;
+
+    const DEVICE_TYPE: u32 = bindings::fwctl_device_type_FWCTL_DEVICE_TYPE_RUST_FWCTL_TEST as u32;
+
+    fn open_uctx(uctx: &mut FwCtlUCtx<FwCtlSampleUCtx>) -> Result<(), Error> {
+        let dev = uctx.get_parent_device();
+
+        dev_info!(dev, "fwctl test driver: open_uctx().\n");
+        Ok(())
+    }
+
+    fn close_uctx(uctx: &mut FwCtlUCtx<FwCtlSampleUCtx>) {
+        let dev = uctx.get_parent_device();
+
+        dev_info!(dev, "fwctl test driver: close_uctx().\n");
+    }
+
+    fn info(uctx: &mut FwCtlUCtx<FwCtlSampleUCtx>) -> Result<KVec<u8>, Error> {
+        let dev = uctx.get_parent_device();
+
+        dev_info!(dev, "fwctl test driver: info().\n");
+
+        let mut infobuf = KVec::<u8>::new();
+        infobuf.push(0xef, GFP_KERNEL)?;
+        infobuf.push(0xbe, GFP_KERNEL)?;
+        infobuf.push(0xad, GFP_KERNEL)?;
+        infobuf.push(0xde, GFP_KERNEL)?;
+
+        Ok(infobuf)
+    }
+
+    fn fw_rpc(
+        uctx: &mut FwCtlUCtx<FwCtlSampleUCtx>,
+        scope: u32,
+        rpc_in: &mut [u8],
+        _out_len: *mut usize,
+    ) -> Result<Option<KVec<u8>>, Error> {
+        let dev = uctx.get_parent_device();
+
+        dev_info!(dev, "fwctl test driver: fw_rpc() scope {}.\n", scope);
+
+        if rpc_in.len() != 4 {
+            return Err(EINVAL);
+        }
+
+        dev_info!(
+            dev,
+            "fwctl test driver: inbuf len{} bytes[0-3] {:x} {:x} {:x} {:x}.\n",
+            rpc_in.len(),
+            rpc_in[0],
+            rpc_in[1],
+            rpc_in[2],
+            rpc_in[3]
+        );
+
+        let mut outbuf = KVec::<u8>::new();
+        outbuf.push(0xef, GFP_KERNEL)?;
+        outbuf.push(0xbe, GFP_KERNEL)?;
+        outbuf.push(0xad, GFP_KERNEL)?;
+        outbuf.push(0xde, GFP_KERNEL)?;
+
+        Ok(Some(outbuf))
+    }
+}
+
+#[pin_data]
+struct FwCtlSampleDriver {
+    pdev: ARef<pci::Device>,
+    #[pin]
+    fwctl: fwctl::Registration<FwCtlSampleOps>,
+}
+
+kernel::pci_device_table!(
+    PCI_TABLE,
+    MODULE_PCI_TABLE,
+    <FwCtlSampleDriver as pci::Driver>::IdInfo,
+    [(pci::DeviceId::from_id(pci::Vendor::REDHAT, 0x5), ())]
+);
+
+impl pci::Driver for FwCtlSampleDriver {
+    type IdInfo = ();
+    const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
+
+    fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> Result<Pin<KBox<Self>>> {
+        dev_info!(pdev.as_ref(), "Probe fwctl test driver.\n");
+
+        let drvdata = KBox::pin_init(
+            try_pin_init!(Self {
+                pdev: pdev.into(),
+                fwctl <- fwctl::Registration::<FwCtlSampleOps>::new(pdev.as_ref())?,
+            }),
+            GFP_KERNEL,
+        )?;
+
+        Ok(drvdata)
+    }
+}
+
+kernel::module_pci_driver! {
+    type: FwCtlSampleDriver,
+    name: "rust_driver_fwctl",
+    authors: ["Zhi Wang"],
+    description: "Rust fwctl test",
+    license: "GPL v2",
+}
-- 
2.47.3


