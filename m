Return-Path: <linux-kernel+bounces-878607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B65C21171
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBBF23B2BE2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CF83655F3;
	Thu, 30 Oct 2025 16:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mgRFtVDD"
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012033.outbound.protection.outlook.com [52.101.53.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD81A363BAC;
	Thu, 30 Oct 2025 16:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761840242; cv=fail; b=pttr2U77ltjG3otG04ymtl4IfpnrMHI9pI606cWiBA94Urz30DRejYZYCePjGI6JD2NzH7aGmJb+F3JGcv4ozsjZTN2Ptd6mT7mmo7dKU2yDaW/jQzORBh1owe5O8HDqNAjDaTTIO7EHlGX5INWgh2v1ERNVwjnPaYn22TvAEg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761840242; c=relaxed/simple;
	bh=uVlbBXlJHimajAzl/jdObPj4mjZKDLAFw9iUTadmzYM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JGRLQ45qs5veP54lJZ+4fRhkTrVLA9tUuBimH7lXbXOdNXf0x6M0QrPngzlm9ouYuYSv+VAsA6AEsWZTouS/QNVxHMCw+fgqd2Wa6vybnjX/z/iLVmT6Rak6KRpKc9JICIpXCvZV3QR5d8Y0iAgHHQgwdpCaXStgNaWQJcgGW7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mgRFtVDD; arc=fail smtp.client-ip=52.101.53.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yr6e8NmS/WQPXbTS4dWHtCzHhxpVb0M+j2tfEdXarTV650nFvhjqaGvnQU5Agef9hQVHB2HPvbsppT43T3mgOf/fPakjQDgcAgX5ErtaiZC+mmx/eSPsKJ/s6uF7ESZg0QEUhoupNkA0ZzKFuewG8R7e3zvphNyGXleRfB/UTrBT73OwuJ+rJ+R3R8pgad8Qbnxn2A99F7mjNlxN6Sb2NG0QEhS8uf25VkjerKh8rXEJATBE/UlzExiWRfJWTw+iZKP9KseNKhe6fRvodXf3jdLYWweQ2/qg6X4hYVeka8aplVPLelKcxmixGC6vHJpDHBrwTtBbhhXZhr3BdXevPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+louDTwrnaaI5gaZihzZJ6g6YE2rlEsShBwOLp9xU5A=;
 b=CCDuot1dNOoUr0UtdlrJzwkKc0aG2RtXLKGPJj0gBFfqrE3kEppyCKAoihvANT/c8EEGvHKm/KJ4RZYevk++I4fHlAEEGHi2QEX7z4X5a5TN1Z0KbakbQSXHIW56tg4qBLM6iZ8KBdUDV9GSO3fRSG4vmWl0+NCSHEt8aVVyPEefqvutTR6G+X6jXvSNWb+2oStMcA2Y4ROVT6IA4qRCeziOrpTCalvmWzXMegcbodVSttp4HkyB0Scvte7fQMZf9E5/1B3yaiZhRowVAIFtXsEtSP0Sia8MHMAM6AY8ICer70UXlCIzkA7nGRF7LedqivGMM2tK+QbON+E5Dx3SFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+louDTwrnaaI5gaZihzZJ6g6YE2rlEsShBwOLp9xU5A=;
 b=mgRFtVDDY/dfcdU6Ertbcd7ykKbamzsRpRyOLfIs6Y8kagOl6K5l4lQA5/b3bIIOHx2e1M2OW+O7fV8xvotoi40//xqA+DzY00XC+xVpmnazj1cpbOgReS1UNLL3NFkGw55SxWeVOKgMgSeJVSl1la5haxVgp5PKjtDkZHVrgTTDG/Y6yjW0jqj5a9pYMvd86GAz1d66zusBFhFxBNMdizZVFE4L1lbf0SDngzi+IClXNFX+Iu4Sf1y2cJ/peHjoapujOR0UchG/zD3/XT8KIF9V2H8/Ymdhsgt4Tg2DuTZnN7YZovU0nl6uRAAtduPW09wsovxFZNLcZjfBs3NL5w==
Received: from BN9PR03CA0704.namprd03.prod.outlook.com (2603:10b6:408:ef::19)
 by CH1PPF2C6B99E0C.namprd12.prod.outlook.com (2603:10b6:61f:fc00::609) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Thu, 30 Oct
 2025 16:03:51 +0000
Received: from BN1PEPF00005FFC.namprd05.prod.outlook.com
 (2603:10b6:408:ef:cafe::17) by BN9PR03CA0704.outlook.office365.com
 (2603:10b6:408:ef::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Thu,
 30 Oct 2025 16:03:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00005FFC.mail.protection.outlook.com (10.167.243.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 16:03:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 09:03:28 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 09:03:27 -0700
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
Subject: [RFC 0/2] rust: introduce abstractions for fwctl
Date: Thu, 30 Oct 2025 16:03:11 +0000
Message-ID: <20251030160315.451841-1-zhiw@nvidia.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFC:EE_|CH1PPF2C6B99E0C:EE_
X-MS-Office365-Filtering-Correlation-Id: 3916cf4f-4ba9-4989-04f6-08de17cde9e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S3RyaEllbnZLWk0yNTQyM2dEM1hRSXdXMFYwNkNUSFIyQlFwWUhmd3dHYmt0?=
 =?utf-8?B?S1pOb0VKNmhaZDJDc0hsdklBOEduckIvZ3pqVEd5WjVUSXFmaDZvOWJpeFVE?=
 =?utf-8?B?cE9HQ0FsWU1hR1lpS1Zhakp2U1hCWTBxVmQyTDJpZk1SVjhXWnpZTHNjSEU4?=
 =?utf-8?B?dGtQWm9aa25HVWlyd3E3STRTd3NMc3VRcEpSTy9OUzRaL1pPMHRHcXUzMVhs?=
 =?utf-8?B?alZaK2V3MmJXVGxiK1RDZkozN3VhSS94aTEzMFA1bUpPYm40S2hFcjloc25l?=
 =?utf-8?B?ZVFYK1VUUUZlRTFKMXphL1NtUVZmTDNpYUJoMjhqYkJBRkN6SklRVVlVSCtB?=
 =?utf-8?B?MmpVcXFianRXOENnWlBzbnRVMzdpMGdYYVo4bXFvOUFoZHZXRjFMZjU5R1Bz?=
 =?utf-8?B?L2FjVDVNUXYzbEtqVkc1MzFiVHhpR09EVnJaNjJ0cUg2M0N0K0FaMUxjcmp6?=
 =?utf-8?B?ZmFsY2JQdmlXSExnMUcxdVErQlBmYmFmNVdVMERQTG9uNnlrNnJtNFViL3Rz?=
 =?utf-8?B?M1J0WjdsZnBKODFRWXVMUmVGRzliT0NrNnFuV0RCcVRwendWb0F6S1pVQVVR?=
 =?utf-8?B?SFllQTQrOG9zZzZvTXhNVllmR1hGUXI3Vm92WDdsRm9SbVdLZkh2MVFKc0Vw?=
 =?utf-8?B?NjY1TUpKUEw4ZlU3SHZqZHpHUGYrU3l5VGZnV2hyUmRwUVd2RDRNV3IweFRn?=
 =?utf-8?B?ZG85V3dBVW5wSzZ5aUtWNmtKTmtVUkRPOEU1aVpYTmNmWlZuVmhQaDIrMktY?=
 =?utf-8?B?c2Z2cVJNbEd0S0ZHODU1cWhBQ1hiNGo5c0NKNkoyenU4bnVZRFBoTThmamt2?=
 =?utf-8?B?elBQOTBTbEJQUCt2dEtQL3hkT3FWTjR4YVFwaEwySWxVdnk1a3NkNk5LaktW?=
 =?utf-8?B?Ly9ZMjlFMTFmOFk3VnpSRmRJdjJVd1M5MUFzYWd2d0FuS0xNTC9QekZTL0dG?=
 =?utf-8?B?aDV6TTZSaXBxNHV5bzRsTkxrMFIwT1A2cmswNXVjTEdycDFCbVF5VDJ4L2sx?=
 =?utf-8?B?dWV6SStmRW1FWUhldlBTeVJhVzl6ZXFCQ3BqTjh4R2ozbzMrSEp0cENsZTJL?=
 =?utf-8?B?bVB0YnhJbkl1ZXliTGx6dEdNT3pkYkMwL0xXb3A2dm9SSkNlZ3dWc0JlbEE3?=
 =?utf-8?B?MlhSSG45QWtpZ2gvM05KQXBKbFBKaEtBNHFjVGx5NGNKK2NLemFOWkk4TG1F?=
 =?utf-8?B?eEp5R3Vqc3RuSmpxRExtT3dtMUEva0lDdHU4NjBuNUNocXZ3YXgvbWQ4L1Fv?=
 =?utf-8?B?TVB2OG9sRTlaUUNoUFF4SG9KSkNqTmhLTnRIRS9JRmNsamZPNVBEdS9YWWph?=
 =?utf-8?B?OW4zSzcvTHZwVnVTdG5zQklLa3JGMVQyMlJ2NTQ3UDF6SHJxV0YrYUhLVXdZ?=
 =?utf-8?B?VjdNcGhHN2IrSUtLOVE4NjMzL3ZTUlRscjhTUmYySW8vVXVWYVN5TkpCQ2h2?=
 =?utf-8?B?akFGb3pUemVocjcvWlZZd1llZ1kwUlFrdWVNN0RXVHBBcXBCMUdLU1RhYUc5?=
 =?utf-8?B?dE8wSkRDSUs3Wk5IeExRWjUxVEJvS3VFNkxJaXNydUh5TGJ2V2UrVVRRaHYx?=
 =?utf-8?B?anRLaEZSY1pCbzNMSEw2eUhHRldqMVJrNi85VkJKdnZIaVhpcW9ub1AveW5Y?=
 =?utf-8?B?LzJhR3dncURHT3dZelRYWU5kSzZ3WFZsLytCTVd6N1dkdVlPVjQyeDdQVCsv?=
 =?utf-8?B?aTdRSkJUa016bjNnU3hvNUloOEY4cy93NnJQM3BQNEx0KzRQL3Z5UXNRQ3dm?=
 =?utf-8?B?bFRHTUY1VmxXVnJCWEt0emdwTWFnZzZHc0d0ZlFDL3pmbW1zV01WQmdCM0pk?=
 =?utf-8?B?Z3owUnVzek1UejJSS1I1RXdTem9vZCtVZHI2bWF4NHdSbDVydDhLMXNqemRh?=
 =?utf-8?B?TmUyN3RuclcwWXgyWVpTSVJ6VTh3NmZla0tFOUF4L01MckEyREJGQWdaeGE4?=
 =?utf-8?B?a3plQ1BwVHMvUXJrTk40SlRuaVpLcWkzcnRqeG53cmNJR1d0MVowV2kvNjlk?=
 =?utf-8?B?a0xDcDhOMk1hRk4xRERUdmJOWE9TZWUzbjIvdEwrWFIyNFo2bHN5UHAzaFFw?=
 =?utf-8?B?WGtPaGovTzUxdFBoNXRBcnJNMGhWa3N6WDdVNEg1aFVTUjJkWW1peDdyb253?=
 =?utf-8?Q?P2CI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 16:03:49.1641
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3916cf4f-4ba9-4989-04f6-08de17cde9e3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF2C6B99E0C

In the NVIDIA vGPU RFC [1], the vGPU type blobs must be provided to the GSP
before userspace can enumerate available vGPU types and create vGPU
instances. The original design relied on the firmware loading interface,
but fwctl is a more natural fit for this use case, as it is designed for
uploading configuration or firmware data required before the device becomes
operational.

This patch introduces a Rust abstraction over the fwctl subsystem,
providing safe and idiomatic bindings.

The new `fwctl` module allows Rust drivers to integrate with the existing
C-side fwctl core through a typed trait interface. It provides:

  - `FwCtlOps` trait — defines driver-specific operations such as
    `open_uctx()`, `close_uctx()`, `info()`, and `fw_rpc()`.  
    Each Rust driver implements this trait to describe its own per-FD
    user-context behavior and RPC handling.

  - `FwCtlUCtx<T>` — a generic wrapper around `struct fwctl_uctx`
    embedding driver-specific context data, providing safe conversion
    from raw C pointers and access to the parent device.

  - `Registration<T>` — safe registration and automatic unregistration
    of `struct fwctl_device` objects using the kernel’s device model.

  - `FwCtlVTable<T>` — a static vtable bridging C callbacks and Rust
    trait methods, ensuring type safety across the FFI boundary.

`rust/kernel/lib.rs` is updated to conditionally include this module
under `CONFIG_FWCTL`.

[1] https://lore.kernel.org/all/20250903221111.3866249-1-zhiw@nvidia.com/

Zhi Wang (2):
  rust: introduce abstractions for fwctl
  samples: rust: fwctl: add sample code for FwCtl

 include/uapi/fwctl/fwctl.h        |   1 +
 rust/bindings/bindings_helper.h   |   1 +
 rust/kernel/fwctl.rs              | 254 ++++++++++++++++++++++++++++++
 rust/kernel/lib.rs                |   2 +
 samples/rust/Kconfig              |  11 ++
 samples/rust/Makefile             |   1 +
 samples/rust/rust_driver_fwctl.rs | 123 +++++++++++++++
 7 files changed, 393 insertions(+)
 create mode 100644 rust/kernel/fwctl.rs
 create mode 100644 samples/rust/rust_driver_fwctl.rs

-- 
2.47.3


