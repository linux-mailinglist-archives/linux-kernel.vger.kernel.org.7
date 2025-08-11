Return-Path: <linux-kernel+bounces-763137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B57B210D1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 18:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E7A3685B58
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 15:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AAD22EA140;
	Mon, 11 Aug 2025 15:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HGjW5e6V"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2081.outbound.protection.outlook.com [40.107.95.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078302E9ECC;
	Mon, 11 Aug 2025 15:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754926802; cv=fail; b=OC5lIEXHR3ChbfYNYLpILEQHMJLHX3BX8cjbjJWVGKtMgFR3eMwrmejpLqecGZrH2iZN184gazvbgrBiVVK+9eUktNQDrKSU//z0pzBYtvvVctFl/B1e2ylBr6G9JARvFUrea1Y4LKFFb/GBAgi/vjG5GfZy6B74XSVELwDUhRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754926802; c=relaxed/simple;
	bh=wxZLb+OriLDdjHV4M/v5KJXOgjnGcGfEmf8Dj1CJxDE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RKH7apu7ibmqXBXWjhysnYTV48RT+citKGeb9U7JcJ17Y5RiSUMDtsC9yBklTaQWiBQdzVqIOeh2VplTzfSoCvqEHWI7c1m7P72QQTJmup6kVyRGk6cUbj3HOdhgnNKRRh6atCr6TMqIFc215tkXwe+BOT0Ao59yK753MEZnPac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HGjW5e6V; arc=fail smtp.client-ip=40.107.95.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JQdspGCXI3IhUO2CXQeJUWUSBuIVlzf4aADuCg0uiqTGoJmt5TKFjP/czu8+Z74SVHRXRKGJyCAt+0V2TV0/w6YnmRTs4Yoadive9yzCVPVYaW5sprMtHeur8f5H96AUlKY6Cfh1UM53oTpgktn1bhLKvNz3dBjjenvVE49vV03EKGw7f/Tfwe6Ugu4sgWhUOCl29+kOcwzfIQjbCuLHuTkmIjnMYD1i6h8Ff4LhMjho64f0gQBlx1flt2OeVrjtDf8rKwXbUG8TzB0GThL7Nb3aFSOgcd1h2IrKrTO10yf6Y/+epilXBt09vBJIgvh9N+Nc+VVcn2zVjKAKjEmhjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xeSqIQKa7wDR81Zn3uvajhMyokIC8+Z2Sn42e4jiuHc=;
 b=c2erBf0KKGRITZ9ljKUsoM2BJqkoWjqwbN7iEhdrFwTw2HfepLuI1VWsardPt/XHoAGIRlYAGtcAzTMRNrG1vL/ri0wTIbAuHzeN/ME4JJo+NL+K+LP75Z+v8q+GUtqBYo4p2cqFTxCBNT4H76GZi2aNpMp7qqtOAZrtcC+UJlLCZ6jS9/b/MU3P4loVh1Kz0IDxdNH6g9oGO2a/+QQc4cTxgnuWqR3CqP0SfFTYD4k9dg10MRU9BU+H7nnGfIIEi+Ji+yhT+xAHYfMCMbqHNgVmccqHYK+4oOc/CxgrymhNvfkcdUFKwUYCnGbO65xnoFhSV2DRJfNwhrsbWNu56A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xeSqIQKa7wDR81Zn3uvajhMyokIC8+Z2Sn42e4jiuHc=;
 b=HGjW5e6VE7gONImDDPBtsbGuN9PYjIEfsdjRHKeW8GX/sqZTSMW7wpY+2blWy1M/mfggZvYphWBayL3LwERK025MlTxbTdfbaZdbN2PqU8ThHhm6XeqbMCjLHJdMJAHnjNs0Khm0jRd+OBzRsCIdcF08awlFtuXbKN8M65nxyWDIQ9K897T0gwK31s0CSzuNVZPRfVJwMmIwJonB396Lya/AmxKH+dIoJAWUY8zJBLo48xX1D53XJ0iSmaQEE7ADb2uWQjhsPskX6D7LlK+hIMeSLov8EfZqnrV6ByJwwxsHSlP4AXwIqEjUV1WDZQci5p5ilBe0RzgK8K+BVfhYKA==
Received: from SJ0PR13CA0229.namprd13.prod.outlook.com (2603:10b6:a03:2c1::24)
 by DM6PR12MB4418.namprd12.prod.outlook.com (2603:10b6:5:28e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Mon, 11 Aug
 2025 15:39:58 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::f0) by SJ0PR13CA0229.outlook.office365.com
 (2603:10b6:a03:2c1::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.13 via Frontend Transport; Mon,
 11 Aug 2025 15:39:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Mon, 11 Aug 2025 15:39:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 11 Aug
 2025 08:39:38 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 11 Aug
 2025 08:39:38 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Mon, 11
 Aug 2025 08:39:38 -0700
From: Ron Li <xiangrongl@nvidia.com>
To: <hdegoede@redhat.com>, <ilpo.jarvinen@linux.intel.com>,
	<vadimp@nvidia.com>, <alok.a.tiwari@oracle.com>, <kblaiech@nvidia.com>,
	<davthompson@nvidia.com>
CC: <platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	"Ron Li" <xiangrongl@nvidia.com>
Subject: [PATCH v2 0/4] platform/mellanox: Add mlxbf_pka driver for BlueField DPU
Date: Mon, 11 Aug 2025 15:39:30 +0000
Message-ID: <20250811153934.671070-1-xiangrongl@nvidia.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|DM6PR12MB4418:EE_
X-MS-Office365-Filtering-Correlation-Id: f311e1e8-bc11-4a67-0902-08ddd8ed52cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3wmX98dxu7K00teO34JO7jQMbrRr4y27uTIgGYG0HETfNBnisoSxTSSou8xr?=
 =?us-ascii?Q?cdyRJG5fwXle1oge7m9OICsedxjr+MFpuu9DG1ugzoCqoYW1q5unkbMM8G+o?=
 =?us-ascii?Q?eWV25G/sy5BFHx65P3nKd/RiSlYekP7IB7x9lqNqWW6/TTL0EWOJXxPDhQJS?=
 =?us-ascii?Q?/ItcJM5P5W/l1c+JaJ+u077Yh5AJfuRrw3xtmqZpS1wAYENeN2Sbd9l5mJDS?=
 =?us-ascii?Q?RwQ0icJ3JNRtXBOqDysaxZSb2LpNY2mqHaqM0UVRo3Ay2qCalCda2t9zsfPh?=
 =?us-ascii?Q?IjAo8OtNS7RTQAgtdZoFbjuVGCNMvo4ddeLKKghoGE70DLmnZxouEKsxFEoS?=
 =?us-ascii?Q?YXcqtVDj3ZSZLOH2RP+JalM95KD6zEGtuPk+0p70bEzDIbolg9MfNv7wwj0N?=
 =?us-ascii?Q?U+EobiYOXO8AOlkigSO775BWDHem0QyOuh7bJ03LfjJ4OxFmxyxnENS/pWd7?=
 =?us-ascii?Q?28lNqC4UZAvWnCMoQE9AWmtgxk2ygeHoi0hRajcaEISjkivUMKh79A6eI3nW?=
 =?us-ascii?Q?Iu3xoUZKD42ueoh5BNR5Otb19glK3y8+ROvmW0R9vVxDlVTe0ycmOR71VraJ?=
 =?us-ascii?Q?BQ5CH9KsxM5zHa7WiVVVpdDEUwuEKTLoDp9nO8YjoIvKTJhHN7tD76bR8meC?=
 =?us-ascii?Q?KWqSaf0sZ6zzZkXqrLD5jlo+cWDYv1LKFHwxzlPeB/UiCuNuYOC2rv8NS5sE?=
 =?us-ascii?Q?K6jC7ZzmDhxwfDQSwm6pRWMKEXYyTCeSrItvY+AInIFRMpN3zlL1W7RH086X?=
 =?us-ascii?Q?0h39UDWRaQadIrNTWarK2a/QLaPLLngwdWKP6QfeS5HOpQVgXUGhDM07tsVc?=
 =?us-ascii?Q?zm3mCf6K2v8A0v7GKsCftJPTxyx7KbR6ggDz2/94OBURcq4rtrrBrt4fdp50?=
 =?us-ascii?Q?i97POYpBCOQalkQ9j0ZzNbAsUijMQUpmLmeFFB5hMOGPT1jG9YKcBfqd/EOi?=
 =?us-ascii?Q?p+XBBcLnJpvSkARn4iukXaTMQDPkx0R/z4g5gAYfFA982FnhmoquLYq2O9bL?=
 =?us-ascii?Q?L+Pwcvi/OPbeuDAr1G4dV5YJVqdScRcZlyY5hXKD1E+OEmMLqXP0natSEQ6C?=
 =?us-ascii?Q?ESbBCKCRz9Kt9GHFlTRz0kwEG9uwYYcgv/ChfnqUkEmHiuLcD8XAVEkvjykg?=
 =?us-ascii?Q?/nh0uYrvoqTexDWW+AUpz+CFOJ3jvloZWlfJFivbur9ndhBZ6sDbIOAFjfKZ?=
 =?us-ascii?Q?OoBENUOJnC/cOoC3ZhI5RUEbXg/TzpfRLgxWD/PR7cS5NS4qINTjLNPpk0s5?=
 =?us-ascii?Q?6tgJOY4za1pijXQR6aii1BaForamZoDdpZaKUufKoB478+54jTSwDQYKgqvQ?=
 =?us-ascii?Q?BU0ItH5ib3rtDcq+Aww7/KKqKq3Qg6xGlYGcJNoraP6WRnuMmMwGpFE21Vrg?=
 =?us-ascii?Q?uVLNSZapy5jcCsf0p7LDVEudOyp+o/uakGfyph4ibraBmEj+w6YdsHQ2PZ++?=
 =?us-ascii?Q?Yq0RbqRJK/H5BHRPS5Rv6+iJPMKkcxhyKcRXLD2ZYuPv6JWslHytTuSgREzm?=
 =?us-ascii?Q?FU/+tJ4ArQNn8qgVoiYjzJ4OaqHhSh5F89Np?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 15:39:56.3488
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f311e1e8-bc11-4a67-0902-08ddd8ed52cc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4418

This patch series adds the mlxbf_pka driver to support the BlueField DPU Public
Key Acceleration (PKA) hardware. The four patches in this series are:

Patch 1: The base implementation of the mlxbf_pka driver for the BlueField DPU.
        This patch implements the platform driver, probe and
        initialization/configuration of the PKA hardware blocks. Most of the
        kernel APIs used in this patch are also compatible with earlier kernel
        versions that are actively supported and used by the BlueField DPU
        OS distributions. As a result, this base implementation can be
        cherry-picked to earlier kenerl versions.

Patch 2: Add guard() and scoped_guard() to handle resource cleanup.

Patch 3: Add devm_mutex_init() to handle mutex initialization.

Patch 4: Add __free(kfree) to handle memory allocation.

Patch 2~4 are added to version 2 of this patch series to adopt the latest kernel
APIs and improve the memory management.

Signed-off-by: Ron Li <xiangrongl@nvidia.com>
---
v1->v2:
For patch 0001:
- Move ioctl related definition to include/uapi/linux/mlxbf-pka.h.
- Changed the ioctl number from 0xB7 to 0xBF, to avoid conflict with other
  drivers.
- Remove interrupt related code, since the PKA driver uses polling instread
  of interrupt.
- Use devm_kcalloc() to allocate memory with calculated length.
- Use read_poll_timeout() to handle infinite loop checking.
- Use lockdep_assert_held() to enforce serialization.
- Create mlxbf_pka_drv_verify_bootup_status() to handle duplicated code.
- Remove error handling in ***_remove_device functions since nothing useful
  can be done.
- Fix the rollbacks in some functions by adding proper goto rollback path.
- Updated all comments to under 80 characters per line.
- Upgrade some constant with kernel definitions.
- Include missing kernel libraries.
- Update some pr_xxx() to dev_xxx().
- Use FIELD_PREP and GENMASK to handle mask and offset of register access.
- Refactor some code snippet to improve readability.
- Update the comments of some functions and type definitions.
- The FRO in the source code stands for Free Running Oscillator.
- Fix typos.

---
Ron Li (4):
  platform/mellanox/mlxbf_pka: Add mlxbf_pka driver for BlueField DPU
  platform/mellanox/mlxbf_pka: add guard() and scoped_guard()
  platform/mellanox/mlxbf_pka: add devm_mutex_init() to initialize mutex
  platform/mellanox/mlxbf_pka: add __free(kfree) to handle memory
    allocation

 .../ABI/testing/sysfs-platform-mellanox-pka   |   35 +
 .../userspace-api/ioctl/ioctl-number.rst      |    3 +
 MAINTAINERS                                   |    8 +
 drivers/platform/mellanox/Kconfig             |   10 +
 drivers/platform/mellanox/Makefile            |    1 +
 drivers/platform/mellanox/mlxbf_pka/Makefile  |   10 +
 .../mellanox/mlxbf_pka/mlxbf_pka_dev.c        | 1925 +++++++++++++++++
 .../mellanox/mlxbf_pka/mlxbf_pka_dev.h        |  649 ++++++
 .../mellanox/mlxbf_pka/mlxbf_pka_drv.c        | 1017 +++++++++
 include/uapi/linux/mlxbf-pka.h                |  112 +
 10 files changed, 3770 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-mellanox-pka
 create mode 100644 drivers/platform/mellanox/mlxbf_pka/Makefile
 create mode 100644 drivers/platform/mellanox/mlxbf_pka/mlxbf_pka_dev.c
 create mode 100644 drivers/platform/mellanox/mlxbf_pka/mlxbf_pka_dev.h
 create mode 100644 drivers/platform/mellanox/mlxbf_pka/mlxbf_pka_drv.c
 create mode 100644 include/uapi/linux/mlxbf-pka.h

---
2.43.2


