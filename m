Return-Path: <linux-kernel+bounces-782688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA58B323A2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 22:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 721E1B023CC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 20:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9B12D7803;
	Fri, 22 Aug 2025 20:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rlKd3oZA"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2084.outbound.protection.outlook.com [40.107.96.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5F6BE49;
	Fri, 22 Aug 2025 20:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755895119; cv=fail; b=ttLBiGSE44EADXarcm3+N+vU8VSoabG/JJ2NpVIkpKa4bQgKJ21p2HTQvTB6uCLxRK00lQIUmBmJqNQo/Nka+HYU1U2uNRy5zwr7WL2EwEdO+9Pt/gyEiy25QGJEeSX0luJe3p7Bp7bcrrMyC3mTrcevahnQUcuqq9DHCXldl4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755895119; c=relaxed/simple;
	bh=oZHMpWsT4UCtICPv5qt/qlEL4R2eLUQY4+eKYRaG06o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nGhNpt8WdYNKmraP8SL9vitmKqZTMkm5MGdFH9AzTCIxRWq2dXI78wTEluIUVspWxG+iwjnErRTjFworDptE/g3kZcy6/ztrs2ICFCFcTUGcO6OaUaf/H5/4f9jhPNh9js/C4ILi/PTE70mn/fRqhWRtnAIV7ZPpalRJP8mosLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rlKd3oZA; arc=fail smtp.client-ip=40.107.96.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L5++dEqnO7WReOIWbII9gk5vesmKRAArBWeqErXnrfRzAeC6Km+HUiMu/Vj5Wxno5rggqYWfMphTktcMLec3mpAgLzyN/seltQheYdd56aSmjHcvN1iBWzK5GKD2Wy8lWyqJHz+GLC01Q0uAHTMu8boWT6qbsBOAM+ItC795GAlnvpiAOavGpKcI4NRCOQdp8Ob4Birrp/mn9bFN+FjMW8tHw8mdkCHQK8Zk/Ih3ks3WN3W9oA03H/0ol+jdo5GcM4evqJI4Z+EZ+DEWVTCsbWDfSwH8veEE7sZ39VKlfMm4fm+L6TTo9fk1+R8v8mOAE9fvZuB44MT00byZdimoeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+F0W2Z+F1c3GYbNpOqd1CcEIgxmmC3UdfW2jhAjxQ0Q=;
 b=FsyE6s3iGxDCwm6CgfkNbzsU1ezZSnyl9u966X788OBiC/C667hs+8MkbR8tDHaJFG2za37WEcxIOeFfJLI7kq5vHigkRJ7kTEmn6AXVZtVVRYUMucofJmDpnqRHaaxb7/u1E1lRlY7cQ1zmw94GkJ/P/p5xLZnbtcJIo/emchaomIBiTxmuIDW6U30Uq8zBIP2pUsUu1SQhhS8P5kC5wSc2ouTzAMo7J2vX/iWvkjwxTN9vGNLMtYctFt/oq16FKXDGU4gCl+qKB+/dLc4Vo/aq9DGnxWrklRGkwQN5SIntSm0zXKoIbbfKDHclrm1fbRoBQD0wU4sy0C96IFd81Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+F0W2Z+F1c3GYbNpOqd1CcEIgxmmC3UdfW2jhAjxQ0Q=;
 b=rlKd3oZAS8SetsqFRX7Rx9k3b0FraxLv4F8RF+aRNP6BGoKZChpjdjfzTbInMWYb+0axI67pW8fOe9cCuIL2iOR2LXbJKjmW0qH/2YQdkn4I26RxCl8AbkAcomp3273g2e1d23p+meTitv20I/79HqhznKH+LBtCvDpUxF+L6kc3gsGN4vX7DTtsp5/NC2thYkEtBrAX5b26VyBb61el6UXqgd+t9ugmvrhVC1fyRLv4QW5L0Sl3tG2pxndrt5QW1rsTAj4Gg4w0yVRvbGunzuSXbZEfOr6PFltpRZ5Yl9zCbKgshAmv/h3BiB4gV5JnL8Di0LCNeI/FuHabyb9IyQ==
Received: from DM6PR11CA0010.namprd11.prod.outlook.com (2603:10b6:5:190::23)
 by SA3PR12MB9089.namprd12.prod.outlook.com (2603:10b6:806:39f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Fri, 22 Aug
 2025 20:38:34 +0000
Received: from DS1PEPF00017092.namprd03.prod.outlook.com
 (2603:10b6:5:190:cafe::4e) by DM6PR11CA0010.outlook.office365.com
 (2603:10b6:5:190::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.18 via Frontend Transport; Fri,
 22 Aug 2025 20:38:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF00017092.mail.protection.outlook.com (10.167.17.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 20:38:33 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 22 Aug
 2025 13:38:20 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 22 Aug
 2025 13:38:19 -0700
Received: from dondevbox.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Fri, 22 Aug 2025 13:38:19 -0700
From: Donald Shannon <donalds@nvidia.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<donalds@nvidia.com>
CC: <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<openbmc@lists.ozlabs.org>, <etanous@nvidia.com>
Subject: [PATCH v2 0/2] Add NVIDIA VR144NVL board
Date: Fri, 22 Aug 2025 13:38:16 -0700
Message-ID: <20250822203818.4062595-1-donalds@nvidia.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017092:EE_|SA3PR12MB9089:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dc3c9d5-6d19-4904-c0d8-08dde1bbdcf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|7416014|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ytXLIGE34nJF3POySvTaAdAL5rkkwxzmymDlG8uHsa3Js+GLHhPKDNWdkkLS?=
 =?us-ascii?Q?Ai5MiMZAauOvkFE9e68W0QGhanYX9OK/qRJdYm0KCI1yqr+fp1CEbMjX/LoY?=
 =?us-ascii?Q?D+WIvzWs3qPijuNgT6S/mGuYA5cfp86uG3V+nVovjXltn0jYM1mE6Cw8DvJy?=
 =?us-ascii?Q?3Ls+eTiqW70Z9Vu8CaWy7WziTkSWV/B/PNa9ATkhDNhPyhEFfhBHM4oZsyFT?=
 =?us-ascii?Q?R3FNLrYuVbnr7rGbeRUxgRQkVsb5jcbfbUILxDeY4GlRM79+9255eqtEVTxd?=
 =?us-ascii?Q?F0YYeCEdAe85/lHNzKAIjQrVRdDwgIQ2LTVyRzWVlyn4y1TyRZRo9RvMLw3j?=
 =?us-ascii?Q?YlqqmuwFiR+bTXU659jjit5xctfK3ZcwaizuSxOjUE1FDn1CoMz1024RbTqm?=
 =?us-ascii?Q?p+3tKbxffbNOhyrB/jvZEVnS8B6sHO6w9hFqmbvm6QaY45ecfFrvxzokZwqL?=
 =?us-ascii?Q?mOwyfl40AhNXGvEYyGlHq3GBNAreJlvnmDE7ywzOA6+H92GmEsC0rK0bH7Jx?=
 =?us-ascii?Q?LkYohnh4pSDzqZtoBezfE1H88x+XnCWBuCqAoe6SvodoxIifMKKUseAn+Tt4?=
 =?us-ascii?Q?poGDe5FOMAP/TPnUctpJhd9Hw6Ou8ereIPzqi8bhY2L4PKlpnIMkE/csq+G/?=
 =?us-ascii?Q?DsWArmrsBMRbRAeR6DihEslPuIOuBWnWNpontlciYFbI3nNygh/C0LoBCUbS?=
 =?us-ascii?Q?iwVzLtAkHw+ujJx0h8S6WNvK8xZwjNb4l+O5wSnoqeRAglomIdpMV634a9BG?=
 =?us-ascii?Q?5RR0uJFN9krN3HlTyBlbT7pwCowueNBTTuxYJ1dM5oiSmf5jHbhUKqiw8aej?=
 =?us-ascii?Q?X+WBI80DA8dml/WQuOkJFr/CMVlCXeNstGwrmNMxXcma246C780RDowGDYrO?=
 =?us-ascii?Q?YpJP+C74MLZhanEiYqjn2iR+RXJjEoKab4aXLUzEbpWcFOTJHvftK4Y4o0r+?=
 =?us-ascii?Q?Q3xxLV7ot99WZZE9u9iI4idTfUzVxkKCzkjC3K7wqHOlGMgxmBSnfzxBVV44?=
 =?us-ascii?Q?hms6Q1wfXjpg7wo+3AVKyN1eNHXv5HJn2/I/PsBKrg8Eyt75FhbMsIgIiSr4?=
 =?us-ascii?Q?1rRiDP9O3/tD/BV0U2fjm/UbSZZQYJ732xXZ9PjN2TBQZk2o+INq5oCf+dax?=
 =?us-ascii?Q?Su4VYSg2rUSJKS4Sz4wjVNGH4g1CHlKajgUEbyLQPUgj02omnLmEl7td4COt?=
 =?us-ascii?Q?hUyNv6u18XJd/7AOw0/7KkYaWgh+p6jdLXKS7FMZRsrF858CteefWpgfh/EV?=
 =?us-ascii?Q?vT3IrHjF5FAiq76HoUgJdvoQl+73YxEoRG+wTUtcRfqYit8QpzE8W6nwaYG+?=
 =?us-ascii?Q?Gt0mDQLbOcFHs+kEg4F2QXcf2SZrb2vsqU/pq+XGmm4jl7I6VyizSwp3My8x?=
 =?us-ascii?Q?4r1g6uiNAUaC9FLY0cn/+A4OM1rkQ9VhgsIaSGcW7APzZMHUYGnokj/HdRgK?=
 =?us-ascii?Q?xNvl5kv0WQ9n6fRZM/p0BLXjui1iSu0tqqcVIjrmFav2umYkjOSoAV/u/s17?=
 =?us-ascii?Q?8sV9Fx87ketvhM2d+oWXvd1FeSj0MonqkmQX?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(7416014)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 20:38:33.5956
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dc3c9d5-6d19-4904-c0d8-08dde1bbdcf0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9089

Patch 1 adds the device tree binding for the NVIDIA VR144NVL board.
Patch 2 adds the device tree for the NVIDIA VR144NVL board.

This is an Aspeed AST2600 based BMC board for the NVIDIA VR144NVL
platform BMC.

Reference to Ast2600 SOC [1].
Reference to DC-SCM Spec [2].

Link: https://www.aspeedtech.com/server_ast2600/ [1]
Link: https://www.opencompute.org/w/index.php?title=Server/MHS/DC-SCM-Specs-and-Designs [2]

Signed-off-by: Donald Shannon <donalds@nvidia.com>

Donald Shannon (2):
  dt-bindings: arm: aspeed: Add NVIDIA VR144NVL board
  ARM: dts: aspeed: Add NVIDIA VR144NVL board

 .../bindings/arm/aspeed/aspeed.yaml           |   1 +
 arch/arm/boot/dts/aspeed/Makefile             |   1 +
 .../dts/aspeed/aspeed-bmc-nvidia-vr144nvl.dts | 779 ++++++++++++++++++
 3 files changed, 781 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-vr144nvl.dts

-- 
2.43.0


