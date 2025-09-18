Return-Path: <linux-kernel+bounces-822852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A94F7B84CAC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1FC1627ED3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 13:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE2930C111;
	Thu, 18 Sep 2025 13:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JhDRyWrq"
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011030.outbound.protection.outlook.com [52.101.52.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B7E30C0FB
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 13:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758201984; cv=fail; b=eQHlayMGfUtMxzknMbZ1tU5+G9moHhiNIJznWSy+QzgPKfUP+Fmb7biufPstPO6UdqAQaNhB9bcAj04/0r2Kn7uETEwqKBHc0xdD/JqqQ8bKX3XJmNZCi+yNcESI4v6es0q352v9t1e2B/gUV9z+Ksvk6PkS3jj72BnedxF+OME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758201984; c=relaxed/simple;
	bh=xL9BM7CCVkPZtpV3JZFbdb0FZVEkNBQpF/ZrjxWKJVw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UYW6l91xRwMbqZojXKRY58UPYiU5moba/0cpkmAoqsh+ofmwf1tVGx5pjDR+/zrFeOSTTTzzm2m/3j6rYzUv7F7s28lMgaLNUJqs3ZctBchpQ7UklcPxBL2bCdVbTCmsVz8YqLlpaff/sZx4U+Kt6+XynPMnKxx8LZ1n1x9CNYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JhDRyWrq; arc=fail smtp.client-ip=52.101.52.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XWu84odhhw9xSYQKgUnXCB+MSmCgV6bXOSfqRia0umxqWgrh7qKWQJuLF473LYGBEL6qEF0tAnp1ztuyXtqrFsXK6Xu5bfDVvflMbm5+n5sQpOHJIWFJFtLUgXq6cmyoXXfdfzF/ixUqTOCu+9jyCQ9LpH50AZDqn8njYvhNJwMRoGhdwlJRKZlVIiAyQktEIHAPBBYfHjZGfTYPckyKy+bEA5+SdbxvyTLjjX/eORd3y8nVJLQh42wtiDIgArmEuzaWeTjFuPkhHFdlrQ97vhyaErd9x+5J0qPn9+iWGCOIkaQmVuNBoA5gX4NV0+X5rvHtrj+7CZxyspTKk+r1uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EZijdWcDxvfx44WFCiAD6IQnKCejQp83sqo+cj+bfEM=;
 b=FdoQp0qMIEdyw+GTtJZUyyRlbXD6w/CpsOUVdhhUsaFlCJ/dXhyY6EvMKgi49sM84qgmtUYe+TQ3HxJitp7b+DC3n5KZj1aNELtPFuwWGCLJ/PDG3qOmYY7j6w/SjWiakGD5K6ohjQ9h6eu2xFxzF+0A8Se5GjbgpRgOsUZZcY2g6Zv+88tF+tlDf8CgS7q0iygLBf5Vto8ApFE+tCfGgZwga7myGYs9liej2MXQ6KT9FsVMngd8lhAM79Fythf9pRzb5l4UH6lrtJOmrI4UMkEU5xcpcc+8s5MGCpQSEWzEAT3cLmaIFHqlBuuegfWjbKwU9v9KZvhTpKB1yAzawg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZijdWcDxvfx44WFCiAD6IQnKCejQp83sqo+cj+bfEM=;
 b=JhDRyWrqWR5ugG5k3uGya2xUKYzxsX468enoSYD0tpmCXnOCuiW2We0EJAsqOPwRGkB9Y+9/uWkmykxkADRf8f6UIOAB5jIwa9F8uGzeG/QJ60osojfRMzPtZ710dwBWB1gqbIOTIYEG/SPqwlpfN6vJ5K78lD9TV9upPlXGMkrLiD148z6Yo0Bp69vfQqO2M/s4qeihzsax+lcNl4bS/wdWR0mxphQ9YmM4KRM2V0/qUdVWxZk6QkIW3XBd/qN1BE8PthOOvrLsPn4e8uPx0/KuGkYQ8SumroZcCMohSZkmlXbndDySFAY39gPVdoGx4DMxgNzX9xPpUoz5+bPM/Q==
Received: from BN1PR13CA0019.namprd13.prod.outlook.com (2603:10b6:408:e2::24)
 by DS7PR12MB6264.namprd12.prod.outlook.com (2603:10b6:8:94::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 13:26:18 +0000
Received: from MN1PEPF0000F0E1.namprd04.prod.outlook.com
 (2603:10b6:408:e2:cafe::48) by BN1PR13CA0019.outlook.office365.com
 (2603:10b6:408:e2::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Thu,
 18 Sep 2025 13:26:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MN1PEPF0000F0E1.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 13:26:18 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 18 Sep
 2025 06:26:03 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 18 Sep 2025 06:26:03 -0700
Received: from SDONTHINENI-DESKTOP.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 18 Sep 2025 06:26:02 -0700
From: Shanker Donthineni <sdonthineni@nvidia.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
CC: <linux-kernel@vger.kernel.org>, Shanker Donthineni
	<sdonthineni@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>
Subject: [PATCH 0/2] Enable FEAT_BBM (Level 2) for Olympus core
Date: Thu, 18 Sep 2025 08:25:46 -0500
Message-ID: <20250918132548.1141306-1-sdonthineni@nvidia.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E1:EE_|DS7PR12MB6264:EE_
X-MS-Office365-Filtering-Correlation-Id: ad68d061-2c0c-4bce-2913-08ddf6b6f346
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?B7eapmkc82np6hga0/aG9mAiqG9MkRpMXoGJXm0JH64ONuebAoWHWA//dukp?=
 =?us-ascii?Q?Pjul2yS4k6W+XWuqC57CGtQM9HT2XlUi6NIOh+A+ngVhj9drOXM/L6k+AWpV?=
 =?us-ascii?Q?6gD7b9cYQEmujQb9wJa1JnYSzY2jSB2KWNi8DIHn7n+dIBFltI9yzDGLaMNV?=
 =?us-ascii?Q?2TuFyBxgWanA6340DQikETvHUATjYUmeNCvzYF40S6H242RYUi03sS4X1xMK?=
 =?us-ascii?Q?CUQSUcO/5g129zMSuygUsqHLuRjukGlPwsrF8HvCnimBvDbTQmwFFzSqji1L?=
 =?us-ascii?Q?btuU0Y+nZvn0s9Jf/g4B08elvMkiB+QhXZvRvwSVJMW4mdGBzLF2mWCFaUNB?=
 =?us-ascii?Q?3QeFYph3kL1+S71+1+Qps9xAOmVeur5U53FE5jgcbcL8Boop98BnLMO3JwWg?=
 =?us-ascii?Q?/cljmHzUkgXklKEHEmqBTiyTkRr0938vb1pEDcIKLRLBMNP/tpOTWP//PerJ?=
 =?us-ascii?Q?xoigGrkC4D33d3zzAblLOgZ39lD5PdL/CsUA7BTSOEU9tDrwFqfCt1bJWHZ5?=
 =?us-ascii?Q?2CM2RKu2RwXEPp7TXgEVYzDBIHwOwJlvg6lMw+jhXN8TNzlcxRJl4Ma75K6F?=
 =?us-ascii?Q?xjsoP9jA9Nz/VjmrX12anHBc1JevrihrCNdncVSxevPtFTTprrdXSdpZgygM?=
 =?us-ascii?Q?Z5eR+TbiXHcrSBtoM/Su16W1m5Eo9ap8woeg71/dCbuw488tTHSdVMBOgLkt?=
 =?us-ascii?Q?0b7hz/i4xdMOIPR7O7bmLm+TL3TBK1nu9XrbgxoVOaEwDlyGqcaIQXpZ9oUP?=
 =?us-ascii?Q?0D65Uj8D3jB655xeZgXfUZ6rtTy+9YrBjG5jtvqQiIPLmksEIjku3xCXjQif?=
 =?us-ascii?Q?h+xzfmpaWRUuVAgdkU8Z3BdFIRqxbPp+euCFK9qFZ2oz6QvPScRgznT2hS9A?=
 =?us-ascii?Q?UK1HpUlAObf8T5hFSosj9Ngma7z29djucMoynAT0RgyGNF/QZAg/9ESHWyLu?=
 =?us-ascii?Q?JjRgdKCeYztP8603ggJHpj4btMOmhUmAWw8VEMi79brKQZ/WcXRNB/NdQPjX?=
 =?us-ascii?Q?qTEGdrMy9ic9KbnhmL6uV/7/tb7qdi2wUqQNeDgcJhyA1e8rnuch5bE+sTbG?=
 =?us-ascii?Q?DieTrc0e3W55c9TXJsMxIdMX//bixGHR2A6e3h7H1quNyuK8iJRPywwppqIR?=
 =?us-ascii?Q?MFyXoWmYcs16GzcuP/1JdWYxtkwQOTaJdwFRvC01GjM/5YTTVdGM4WErTgY8?=
 =?us-ascii?Q?nPKoX7IM80IDm3V/SOkOzztF36hBkJQPQhQDLARkagZzeWTlQpOtElzmw9Mn?=
 =?us-ascii?Q?F8E8cS4UbrLY2bKILHfKm4OqaaohxFKB/caKdsYHGA3IEv53KdknqhGbanT5?=
 =?us-ascii?Q?CL38Fq8JNa7hqwBk609vEoLAZQbXm7psmUg3N2dSyEy1lEOlElkEb2zsMIbv?=
 =?us-ascii?Q?Vi/cuRiY7SM11u8flEL7iZebrbLITHwkWUFtFy/BJJQwfBGLXqH16Y6PhkVK?=
 =?us-ascii?Q?CSqR+Htr/XmcJl79N6LrShoEuNT0JNbnuemfIDeVhkxj/dK9XiS3lyrNIGlz?=
 =?us-ascii?Q?emDBaVWRx8mYaTQuIgI2CaaueKAm0V+BwZTQ?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 13:26:18.1247
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad68d061-2c0c-4bce-2913-08ddf6b6f346
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6264

The NVIDIA Olympus cpu supports BBML2 without conflict aborts.
Enable ARM64_HAS_BBML2_NOABORT by adding its MIDR to the allow list.

Shanker Donthineni (2):
  arm64: cputype: Add NVIDIA Olympus definitions
  arm64: cpufeature: Add Olympus MIDR to BBML2 allow list

 arch/arm64/include/asm/cputype.h       | 2 ++
 arch/arm64/kernel/cpufeature.c         | 1 +
 tools/arch/arm64/include/asm/cputype.h | 2 ++
 3 files changed, 5 insertions(+)

-- 
2.25.1


