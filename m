Return-Path: <linux-kernel+bounces-878605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56703C21183
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCECB1896DCF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E093655C3;
	Thu, 30 Oct 2025 16:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JV32dgmv"
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011032.outbound.protection.outlook.com [40.107.208.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B75262FF3;
	Thu, 30 Oct 2025 16:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761840240; cv=fail; b=sRQ1fbwqUQ+5zGTgrwqEjrhRtgDMJKPHagw0xXQOBvUQm3/aIg1Inz4Ve6SgUGzn9LoaHTxiEFZxnaIJ9TBBdGNy+NHmYAwvIp+2vc5qE+AQXqFIIXSFHcEMa3Zof35xhJ2AMVdAbS1PFqYQWyaPx1qshbfLnI0UPK72lJ4hTf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761840240; c=relaxed/simple;
	bh=wz30yFN/O1wc/bSqf+LifY2Ynownmx7x/8ij46Fuipg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RD/SP2+SMgZnasKf/ONRvwMAgZX/RzgjAyoDRusg5ajJ5JZcwF3R0Uiq15Rc3p4/w0NbJ+mWn+8badfF8+JcTIl+Loffx4cvD/5/Q0CWAHYhGsX1CJEQcP7NGD+c+ZwvJZ3/X42SFUG5OUOlDAI8hcOs7FP9tTDbwtMc3/uIB4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JV32dgmv; arc=fail smtp.client-ip=40.107.208.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CdiHxztCRCiHsKkjIXX40sws7+mrak2IS99iYeghDo9l7luLBHvQ4vVQJz881kIxS7XKvLfdbAzdH6nFz9nw8JOdMIOIJTYu3I7woKG7DFGmHyiF/vrir0zzF4NqkU+S3V+HBEpKL1ThUc5qXOSmBnpPzGfiPYErHfC2nnx3Rvimfi40ZgqVV9BCsJjVpNfuajwxxEga9zhKE1xnO1xmasz9LCFM7D0SYN63Vpoa228jlS5QAj/1Fz8LesD5bWMrUiObpG+Y8X90qO2hKXSLV+IjiIjiC3IG0CQRksj7BM7wt4cXc9cIWwf4r6E5M7bfPyDETD3HEfgNpJ7o2RYluw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xmhTs6V8cwNkeNgS/NWISqqWm7c5Oo/ye30LM2WwOMw=;
 b=h2gWo6akc8NJlpYdU4Nwk6Ce4rC7sz+tqr5/2tMIK2ZWS5umtAl8zDPlC797FJJbdTcxmJKhYeYXXF/PCV9Nx+oMwdDqDA91MZ8vIFNH75qlWWzMCCtwAarBYZvOkNIxZA2R9tG7qEecvMa9xpQZYB3D1y1p1dJ5fgPTg495q3wo/v+6hYC58a+4/h7hu97LSjmnHkipOa7VeZpJdS01NiczXAf+2nQXkSxNvkup+++Ri7hREn9e9Z5TQ6C8VzOpdIfviOq5JgcCuz9OeraK0tIA1JjGospJKgdda8GyWI6vozxlkpKubdBWCGqxIWYkpV53ciSB13dOa9B/uUfO+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmhTs6V8cwNkeNgS/NWISqqWm7c5Oo/ye30LM2WwOMw=;
 b=JV32dgmvp6yxY/YWJ6TxgXaDBw5a+LRouRYQQ56BejiHTOx1zr/5L8CHqbKDuYVC5Avk8AmLutrpksMna1F98pPLx8OnpEipS1xN87NOy2eui6hNIFiUk0lx4g8/SBZoaCfqPlxOJiSsVcW1KOwMEEz52qGtp/DaHM/qL9Efpv3ir5H3/n16hgRCZ8WkMQ3cmvZxFnpD1yU2IG8KZkrLMa2LcXaoemf4Ym7xnx7YDFmhI7NmeRJ0F5oYF97z+Ljjdst0iA16R9Scoa2ScdafeiHkxaLbDa97Rf2EJJuSRkZXcyZo1/aAP1ffnfN6iglmVYMTXmmIPMA5M2D6dFETaQ==
Received: from BN1PR14CA0026.namprd14.prod.outlook.com (2603:10b6:408:e3::31)
 by SN7PR12MB7910.namprd12.prod.outlook.com (2603:10b6:806:34b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 16:03:49 +0000
Received: from BN1PEPF00005FFF.namprd05.prod.outlook.com
 (2603:10b6:408:e3:cafe::8a) by BN1PR14CA0026.outlook.office365.com
 (2603:10b6:408:e3::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Thu,
 30 Oct 2025 16:03:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00005FFF.mail.protection.outlook.com (10.167.243.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 16:03:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 09:03:28 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 09:03:28 -0700
Received: from ipp2-2168.ipp2a1.colossus.nvidia.com (10.127.8.14) by
 mail.nvidia.com (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Thu, 30 Oct 2025 09:03:27 -0700
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
Subject: [RFC 1/2] rust: introduce abstractions for fwctl
Date: Thu, 30 Oct 2025 16:03:12 +0000
Message-ID: <20251030160315.451841-2-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFF:EE_|SN7PR12MB7910:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c10accd-23ab-4dfe-ae93-08de17cdea37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NfhwFOczKLYhe7upc50HGLJkTdBKKyroD0gYjezFNVw2gnisUHVYP6EGRrfq?=
 =?us-ascii?Q?NTEu/jsAdndQdAn3a+92KUtOus8pZ+wRl0vAVebB+PHiJj+Lvn/hHzuPwcwC?=
 =?us-ascii?Q?jCafFxpj0/8XkjsyZQlt3yNQctAqeHhinGVRXBF1Tizw4iw4IyjwKFwxDZz9?=
 =?us-ascii?Q?/O57gzfWjKooeVrkgsT7Rd7s4Wbr2crttC5dsqbAmYkVqzhiqZy89nj2pPYC?=
 =?us-ascii?Q?rt89SVrt5O0PK677VEqmrvkybfimCNcpmoho0QrXtSMIYC6GBZfqrC4/TC5v?=
 =?us-ascii?Q?9GhcR6SlXbFu+PYbWq2n/jWPSt7xie2UU6zxSD8EDcccytDr9d3xkj+zy0UW?=
 =?us-ascii?Q?dNcumUCjdf5bdXoVh4DdgMtTXErv4uvxW9WHqIQeiiXb/xfRar3t7WqK9wOG?=
 =?us-ascii?Q?yiaeDtKjgo3kbo8zwzXWqSgvAF/ARyrwrOQxIb7XgBV3SF86CTPTLLY+b0BD?=
 =?us-ascii?Q?3VEeaamWS2IsKZbyq9Fd/yk6WJjHjVsbRL2sp01BpuTmMzktYcXPiISzEH0p?=
 =?us-ascii?Q?2bEYR92YuLlrElIDWTH4TwHo2oWEiSlKMpVmrZa2HO/7y2s7bmsI0dd9IjL2?=
 =?us-ascii?Q?iG6cWuRDDaYOA4Fs8trnCKbDL0qjdTCe/QUix/1WgRUQKOyi+tWIoK5OG3Gq?=
 =?us-ascii?Q?VhDCe4/x2uUNmd88KnvN7mlhFG0jOVnRLsbAazUkMqYoE9qyC7GYX3iaESpQ?=
 =?us-ascii?Q?xVix8hU5Zn+jZS1xfvzwHho1z2kmAJnKt0S+FSTpjs4nkILnaoa1fzkPAILd?=
 =?us-ascii?Q?J44KGUOVeonq3Y5vGAj+y6xVSeOz5aLbgccd82d6gF+PYzMb6BFqDr2CE0b7?=
 =?us-ascii?Q?cB5FMh3Z3Jvfc9R/VxZn7jmoYT8AVDDZBDqmOCE5Jc0aCe5GAEiV0USjPluX?=
 =?us-ascii?Q?qLYdRrMDraeEfvvwixKBkNLbnDERrSnciePL0h95LwwUl1ZW4eW1ULV9k+AD?=
 =?us-ascii?Q?97mW3q0ikyGWW8qrk9FlOB9PNyG5R7QTuxHOWFHidLGyxCOhAylQ/8RA8xLJ?=
 =?us-ascii?Q?Y57cyES8CA4mdaH5twU0WvthAZq/hBO/dLnCd0Nay/XnBRkhi3VTi9eTP4ab?=
 =?us-ascii?Q?bCmUsLVzkbujgw5QCwsJmw3g67QOtndrmrcm6QSnITabzftcbEYVsVOGl+2E?=
 =?us-ascii?Q?yBiWXNMGa1OtNIpl6L4uTUGf6pR+0MdYW44EsGi5SF4ZrOpNUR1T2OvLLttx?=
 =?us-ascii?Q?/LycAjzUYPkIqTCHCOdaHHj/MYv7QipSPfndZXEAbe8+kpsNLPm/8wofihId?=
 =?us-ascii?Q?JKeeIuKmrs/V7FljkFS+doR0YFwzypX0j9ttB2AhLy6cF499RoZD08We9DGo?=
 =?us-ascii?Q?kVe/LgAx3RlSSqECE9l8aR2gLAL7TltJEGbXv5OtFbd2ygoYmehbabuqmLmR?=
 =?us-ascii?Q?3x3dPVIxmozfEDJZa7kh6+r9Gpe5DgZXjWtQaNT6hHqJkRNqZuwAfjSAGIgO?=
 =?us-ascii?Q?S9r/PL+JL1k6s+0d1qtet0knt9VMCEFYPOB48LtTwsw2atiLPmg0+05DPsmy?=
 =?us-ascii?Q?ERqcbnwfaYrDc7Mv9OTvDB9AzhwclDTWjS9rRD6RZQ1CVai5+hZXAFWPcOX0?=
 =?us-ascii?Q?Y6qsOZlqqGJl9qHevGY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 16:03:49.6589
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c10accd-23ab-4dfe-ae93-08de17cdea37
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7910

Introduce safe wrappers around `struct fwctl_device` and
`struct fwctl_uctx`, allowing rust drivers to register fwctl devices and
implement their control and RPC logic in safe rust.

The core of the abstraction is the `FwCtlOps` trait, which defines the
driver callbacks (`open_uctx`, `close_uctx`, `info`, and `fw_rpc`).
`FwCtlVTable` bridges these trait methods to the C fwctl core through a
static vtable.

`rust/kernel/lib.rs` is updated to conditionally build this module when
`CONFIG_FWCTL` is enabled.

Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 rust/bindings/bindings_helper.h |   1 +
 rust/kernel/fwctl.rs            | 254 ++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |   2 +
 3 files changed, 257 insertions(+)
 create mode 100644 rust/kernel/fwctl.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 2e43c66635a2..5c374965f0f1 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -56,6 +56,7 @@
 #include <linux/fdtable.h>
 #include <linux/file.h>
 #include <linux/firmware.h>
+#include <linux/fwctl.h>
 #include <linux/interrupt.h>
 #include <linux/fs.h>
 #include <linux/ioport.h>
diff --git a/rust/kernel/fwctl.rs b/rust/kernel/fwctl.rs
new file mode 100644
index 000000000000..21f8f7d11d6f
--- /dev/null
+++ b/rust/kernel/fwctl.rs
@@ -0,0 +1,254 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+//! Abstractions for the fwctl.
+//!
+//! This module provides bindings for working with fwctl devices in kernel modules.
+//!
+//! C header: [`include/linux/fwctl.h`]
+
+use crate::device::Device;
+use crate::types::ARef;
+use crate::{bindings, container_of, device, error::code::*, prelude::*};
+
+use core::marker::PhantomData;
+use core::ptr::NonNull;
+use core::slice;
+
+/// The registration of a fwctl device.
+///
+/// This type represents the registration of a [`struct fwctl_device`]. When an instance of this
+/// type is dropped, its respective fwctl device will be unregistered and freed.
+///
+/// [`struct fwctl_device`]: srctree/include/linux/device/fwctl.h
+pub struct Registration<T: FwCtlOps> {
+    fwctl_dev: NonNull<bindings::fwctl_device>,
+    _marker: PhantomData<T>,
+}
+
+impl<T: FwCtlOps> Registration<T> {
+    /// Allocate and register a new fwctl device under the given parent device.
+    pub fn new(parent: &device::Device) -> Result<Self> {
+        let ops = &FwCtlVTable::<T>::VTABLE as *const _ as *mut _;
+
+        // SAFETY: `_fwctl_alloc_device()` allocates a new `fwctl_device`
+        // and initializes its embedded `struct device`.
+        let dev = unsafe {
+            bindings::_fwctl_alloc_device(
+                parent.as_raw(),
+                ops,
+                core::mem::size_of::<bindings::fwctl_device>(),
+            )
+        };
+
+        let dev = NonNull::new(dev).ok_or(ENOMEM)?;
+
+        // SAFETY: `fwctl_register()` expects a valid device from `_fwctl_alloc_device()`.
+        let ret = unsafe { bindings::fwctl_register(dev.as_ptr()) };
+        if ret != 0 {
+            // SAFETY: If registration fails, release the allocated fwctl_device().
+            unsafe {
+                bindings::put_device(core::ptr::addr_of_mut!((*dev.as_ptr()).dev));
+            }
+            return Err(Error::from_errno(ret));
+        }
+
+        Ok(Self {
+            fwctl_dev: dev,
+            _marker: PhantomData,
+        })
+    }
+
+    fn as_raw(&self) -> *mut bindings::fwctl_device {
+        self.fwctl_dev.as_ptr()
+    }
+}
+
+impl<T: FwCtlOps> Drop for Registration<T> {
+    fn drop(&mut self) {
+        // SAFETY: `fwctl_unregister()` expects a valid device from `_fwctl_alloc_device()`.
+        unsafe {
+            bindings::fwctl_unregister(self.as_raw());
+            bindings::put_device(core::ptr::addr_of_mut!((*self.as_raw()).dev));
+        }
+    }
+}
+
+// SAFETY: The only action allowed in a `Registration` instance is dropping it, which is safe to do
+// from any thread because `fwctl_unregister()/put_device()` can be called from any sleepible
+// context.
+unsafe impl<T: FwCtlOps> Send for Registration<T> {}
+
+/// Trait implemented by each Rust driver that integrates with the fwctl subsystem.
+///
+/// Each implementation corresponds to a specific device type and provides
+/// the vtable used by the core `fwctl` layer to manage per-FD user contexts
+/// and handle RPC requests.
+pub trait FwCtlOps: Sized {
+    /// Driver UCtx type.
+    type UCtx;
+
+    /// fwctl device type, matching the C enum `fwctl_device_type`.
+    const DEVICE_TYPE: u32;
+
+    /// Called when a new user context is opened by userspace.
+    fn open_uctx(uctx: &mut FwCtlUCtx<Self::UCtx>) -> Result<(), Error>;
+
+    /// Called when the user context is being closed.
+    fn close_uctx(uctx: &mut FwCtlUCtx<Self::UCtx>);
+
+    /// Return device or context information to userspace.
+    fn info(uctx: &mut FwCtlUCtx<Self::UCtx>) -> Result<KVec<u8>, Error>;
+
+    /// Called when a userspace RPC request is received.
+    fn fw_rpc(
+        uctx: &mut FwCtlUCtx<Self::UCtx>,
+        scope: u32,
+        rpc_in: &mut [u8],
+        out_len: *mut usize,
+    ) -> Result<Option<KVec<u8>>, Error>;
+}
+
+/// Represents a per-FD user context (`struct fwctl_uctx`).
+///
+/// Each driver embeds `struct fwctl_uctx` as the first field of its own
+/// context type and uses this wrapper to access driver-specific data.
+#[repr(C)]
+#[pin_data]
+pub struct FwCtlUCtx<T> {
+    /// The core fwctl user context shared with the C implementation.
+    #[pin]
+    pub fwctl_uctx: bindings::fwctl_uctx,
+    /// Driver-specific data associated with this user context.
+    pub uctx: T,
+}
+
+impl<T> FwCtlUCtx<T> {
+    /// Converts a raw C pointer to `struct fwctl_uctx` into a reference to the
+    /// enclosing `FwCtlUCtx<T>`.
+    ///
+    /// # Safety
+    /// * `ptr` must be a valid pointer to a `fwctl_uctx` that is embedded
+    ///   inside an existing `FwCtlUCtx<T>` instance.
+    /// * The caller must ensure that the lifetime of the returned reference
+    ///   does not outlive the underlying object managed on the C side.
+    pub unsafe fn from_raw<'a>(ptr: *mut bindings::fwctl_uctx) -> &'a mut Self {
+        // SAFETY: `ptr` was originally created from a valid `FwCtlUCtx<T>`.
+        unsafe { &mut *container_of!(ptr, FwCtlUCtx<T>, fwctl_uctx) }
+    }
+
+    /// Returns the parent device of this user context.
+    ///
+    /// # Safety
+    /// The `fwctl_device` pointer inside `fwctl_uctx` must be valid.
+    pub fn get_parent_device(&self) -> ARef<Device> {
+        // SAFETY: `self.fwctl_uctx.fwctl` is initialized by the fwctl subsystem and guaranteed
+        // to remain valid for the lifetime of this `FwCtlUCtx`.
+        let raw_dev =
+            unsafe { (*(self.fwctl_uctx.fwctl)).dev.parent as *mut kernel::bindings::device };
+        // SAFETY: `raw_dev` points to a live device object.
+        unsafe { Device::get_device(raw_dev) }
+    }
+
+    /// Returns a mutable reference to the driver-specific context.
+    pub fn to_driver_uctx_mut(&mut self) -> &mut T {
+        &mut self.uctx
+    }
+}
+
+/// Static vtable mapping Rust trait methods to C callbacks.
+pub struct FwCtlVTable<T: FwCtlOps>(PhantomData<T>);
+
+impl<T: FwCtlOps> FwCtlVTable<T> {
+    /// Static instance of `fwctl_ops` used by the C core to call into Rust.
+    pub const VTABLE: bindings::fwctl_ops = bindings::fwctl_ops {
+        device_type: T::DEVICE_TYPE,
+        uctx_size: core::mem::size_of::<FwCtlUCtx<T::UCtx>>(),
+        open_uctx: Some(Self::open_uctx_callback),
+        close_uctx: Some(Self::close_uctx_callback),
+        info: Some(Self::info_callback),
+        fw_rpc: Some(Self::fw_rpc_callback),
+    };
+
+    /// Called when a new user context is opened by userspace.
+    unsafe extern "C" fn open_uctx_callback(uctx: *mut bindings::fwctl_uctx) -> ffi::c_int {
+        // SAFETY: `uctx` is guaranteed by the fwctl subsystem to be a valid pointer.
+        let ctx = unsafe { FwCtlUCtx::<T::UCtx>::from_raw(uctx) };
+        match T::open_uctx(ctx) {
+            Ok(()) => 0,
+            Err(e) => e.to_errno(),
+        }
+    }
+
+    /// Called when the user context is being closed.
+    unsafe extern "C" fn close_uctx_callback(uctx: *mut bindings::fwctl_uctx) {
+        // SAFETY: `uctx` is guaranteed by the fwctl subsystem to be a valid pointer.
+        let ctx = unsafe { FwCtlUCtx::<T::UCtx>::from_raw(uctx) };
+        T::close_uctx(ctx);
+    }
+
+    /// Returns device or context information.
+    unsafe extern "C" fn info_callback(
+        uctx: *mut bindings::fwctl_uctx,
+        length: *mut usize,
+    ) -> *mut ffi::c_void {
+        // SAFETY: `uctx` is guaranteed by the fwctl subsystem to be a valid pointer.
+        let ctx = unsafe { FwCtlUCtx::<T::UCtx>::from_raw(uctx) };
+
+        match T::info(ctx) {
+            Ok(kvec) => {
+                // The ownership of the buffer is now transferred to the foreign
+                // caller. It must eventually be released by fwctl framework.
+                let (ptr, len, _cap) = kvec.into_raw_parts();
+
+                // SAFETY: `length` is a valid out-parameter provided by the C
+                // caller. Write the number of bytes in the returned buffer.
+                unsafe {
+                    *length = len;
+                }
+
+                ptr.cast::<ffi::c_void>()
+            }
+
+            Err(e) => Error::to_ptr(e),
+        }
+    }
+
+    /// Called when a user-space RPC request is received.
+    unsafe extern "C" fn fw_rpc_callback(
+        uctx: *mut bindings::fwctl_uctx,
+        scope: u32,
+        rpc_in: *mut ffi::c_void,
+        in_len: usize,
+        out_len: *mut usize,
+    ) -> *mut ffi::c_void {
+        // SAFETY: `uctx` is guaranteed by the fwctl framework to be a valid pointer.
+        let ctx = unsafe { FwCtlUCtx::<T::UCtx>::from_raw(uctx) };
+
+        // SAFETY: `rpc_in` points to a valid input buffer of size `in_len`
+        // provided by fwctl subsystem.
+        let rpc_in_slice: &mut [u8] =
+            unsafe { slice::from_raw_parts_mut(rpc_in as *mut u8, in_len) };
+
+        match T::fw_rpc(ctx, scope, rpc_in_slice, out_len) {
+            // Driver allocates a new output buffer.
+            Ok(Some(kvec)) => {
+                // The ownership of the buffer is now transferred to the foreign
+                // caller. It must eventually be released by fwctl subsystem.
+                let (ptr, len, _cap) = kvec.into_raw_parts();
+
+                // SAFETY: `out_len` is a valid writable pointer provided by the C caller.
+                unsafe {
+                    *out_len = len;
+                }
+
+                ptr.cast::<ffi::c_void>()
+            }
+
+            // Driver re-uses the existing input buffer and writes the out_len.
+            Ok(None) => rpc_in,
+
+            // Return an ERR_PTR-style encoded error pointer.
+            Err(e) => Error::to_ptr(e),
+        }
+    }
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 3dd7bebe7888..8ddad8ae211a 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -94,6 +94,8 @@
 pub mod firmware;
 pub mod fmt;
 pub mod fs;
+#[cfg(CONFIG_FWCTL)]
+pub mod fwctl;
 pub mod id_pool;
 pub mod init;
 pub mod io;
-- 
2.47.3


