Return-Path: <linux-kernel+bounces-840541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0F1BB4A4F
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 19:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A670D7B008C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 17:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E1D2673B0;
	Thu,  2 Oct 2025 17:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZZtTapyr"
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013023.outbound.protection.outlook.com [40.107.201.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EB842A99
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 17:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759425500; cv=fail; b=LnnfhV+kRzntpgnKNCFXQMhQqWlEsRGqkm86MYKJuG1k9+5UIfZCb6htGw+U8a9yvDILiMaazE6tsmiHWqO0k1Id7q37LsaGxdynJWhegc3lXOYwN9f1ibxGV+PKvj9C8MUI5KAtzMZNcQiUL0oNF+ydOkgzfXvjfuUATwPFveg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759425500; c=relaxed/simple;
	bh=wWT8T/P8UstQzVe9ta9D/xQrFPSqDJuexvL1naoVU9Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bICkZpwJPYyQGjH4NzB1vCLhTPE4+RYqagyaTWx1LzG/BvB3ULd0Kii0fieN2wu97FMriqgPXqryi/hPD6LwPkb5Px11vLjStLdQU+jK/nB8m/ZVzbySrO7/YcmcqH94tDFcOsdOLekwZfsbPZszEuJ2P0ugO1p65ifhxZ5tMAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZZtTapyr; arc=fail smtp.client-ip=40.107.201.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OeB6/BvxdIW9dFY7Q2o2Mlqr7W89nYlg697vnlkmTfhmClWbZvwYfkeIS/BAIUDc4bbM4JdNelc49+zf6l4hqUdJfLEJYNyyg05oG1S/RrSlm0R1edzzKRZGsxhCLI5HWFpL6v38b17oFn4BiDvfoiAL1WJqef5VVP9PYgSYA+CUhP+Qslmaw8wOfRGsdmH8V8c5VYUPB0EDVAJUGIo9M3nm0YuCFRdQZ3BIuZDGFMBKmPhUTLmwfuaJGraQM0WrxqdhPoTDA/vF0/Kpxwk+luRbJslNdlKUw2AXWVKSPESv3Ml9mF1PipyqRjJbtNOfchlHryWMMac3Tcg9gQXHaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fvMzmeGhXfQnAzzJJ0Eb4WHLYqky9w8pBICfyyqhNVY=;
 b=RatRMbsAIXQX7Tu5g2+aqjJKpqw/oC81hjQSmobP7xEqOfBKir0Ya/6i/9fz4YS58iuyllHFvgAXBuYIfYDB+KajXIaclv94ryfxmbUyySGYcvz30Jkc8Vpge45x9Hyy3Pz1YF21FMUiEvSjRZwybz0T0xCBhayrijiDzNURwga83gsZNvETUUTGjuGe4OPSPIrAt74GW+0Ye/jbuj7iPncLHa0SeItI9NFjuralk2xPpsQt6jMHxNWotF1/ziNEEESdwteo3TTnCL2eEUG0YRBLosZITh3FLiQVyGFm2WdMvzg0lEUqUZt0wUZy2t4knLByFabaooiLiwrucnqbtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fvMzmeGhXfQnAzzJJ0Eb4WHLYqky9w8pBICfyyqhNVY=;
 b=ZZtTapyrViMAfKKIewx1F+8e4mjqPQYg79O3w4L+qjE17mdOxc5dbyOJ/xy/D5A5T/zLlWHp0dxU66uqswncx3gXYeHmzfp5Ud3Q6kHHpBhG+6p1kLI0tJqRlqN73SbClP17ZCbwQSBhGeGWj5bYjKa7k+jxzVaB5d58B4JLrJzc9Jma+3i0lEJIYw+79zLWmenAjcqV+TE7iTWRaFfgm+SmQOutl0VQQlQoAX8HuHQtflNIKziZZEMqC5O2FNG78tAXbvlFOyVJWEEs1XqyiD8GnGB0h/lM0UdAupzgiE5kr90IZ4yWdqvBPQ93LHiVJOTMYeMlPx3cV0rZ1RE+Ng==
Received: from BN9PR03CA0913.namprd03.prod.outlook.com (2603:10b6:408:107::18)
 by PH7PR12MB7891.namprd12.prod.outlook.com (2603:10b6:510:27a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 17:18:08 +0000
Received: from BN2PEPF000055E1.namprd21.prod.outlook.com
 (2603:10b6:408:107:cafe::f2) by BN9PR03CA0913.outlook.office365.com
 (2603:10b6:408:107::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.14 via Frontend Transport; Thu,
 2 Oct 2025 17:18:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF000055E1.mail.protection.outlook.com (10.167.245.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.1 via Frontend Transport; Thu, 2 Oct 2025 17:18:07 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 2 Oct
 2025 10:17:58 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 2 Oct 2025 10:17:58 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 2 Oct 2025 10:17:57 -0700
Date: Thu, 2 Oct 2025 10:17:56 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
CC: <jgg@nvidia.com>, <linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>,
	<will@kernel.org>, <joro@8bytes.org>, <kevin.tian@intel.com>,
	<jsnitsel@redhat.com>, <vasant.hegde@amd.com>, <iommu@lists.linux.dev>,
	<santosh.shukla@amd.com>, <sairaj.arunkodilkar@amd.com>, <jon.grimm@amd.com>,
	<prashanthpra@google.com>, <wvw@google.com>, <wnliu@google.com>,
	<gptran@google.com>, <kpsingh@google.com>, <joao.m.martins@oracle.com>,
	<alejandro.j.jimenez@oracle.com>
Subject: Re: [PATCH v2 06/12] iommu/amd: Make amd_iommu_make_clear_dte()
 non-static inline
Message-ID: <aN6zxC3aKLFX+gdt@Asurada-Nvidia>
References: <20251001060954.5030-1-suravee.suthikulpanit@amd.com>
 <20251001060954.5030-7-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251001060954.5030-7-suravee.suthikulpanit@amd.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E1:EE_|PH7PR12MB7891:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bd9b00f-5707-4b2c-fda8-08de01d7a800
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|36860700013|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8NP2JefSNbBLNz2LWxUWHJcjGpgBSDbnmGkhDPxEABlwW8Xi18yYFL7ep2F2?=
 =?us-ascii?Q?4bhMq2oKZ6oc0C1WSVB079G6HhvbUth0H5vYUdkckUEToNevc5zOSQTKqMXo?=
 =?us-ascii?Q?LLOGukJlta37lhFA4v+KSIDUxjxhZM5hCd12dDbWwU7+/AnbZfBDZChMdhf2?=
 =?us-ascii?Q?q9VBxO06ZjNekoKG3dagnsuduahOuRwM6FWH+CnuzHtnMOjwF876lmRLcZCS?=
 =?us-ascii?Q?W9htUT0dGgTJ3jhPfZaHomPKuyAARzT221CKTXulEX5nLrV5e5L8fEJX27Mw?=
 =?us-ascii?Q?SA9RqHBmJwODzotLw48oIINFZ+UqV+tn1VSWE5CHkTn6zlxOGJ7QtckKuSqS?=
 =?us-ascii?Q?fJ/LFBXmu49H+Q/wLrCHL0J5YH76Yz6msxuCOTZUz6H/9/PVsEZ8UsDHDUlG?=
 =?us-ascii?Q?DSaeEzOrjK6jTNPwjLp8cOZLQFQxL/hrAVlRsuGhPjZWgOcgRT/1dHVNpQts?=
 =?us-ascii?Q?kPxtvYT0IwDEILeM9LC1nRpA+D5P4Mkc0owhahzrLUDdNYSCqGONcDrKPJRi?=
 =?us-ascii?Q?sIJz4XmhUGsKgXreMOj2M9Jcn+Xkv0vhcUkDZYP2j0sInRMSNnv8PftWCTdJ?=
 =?us-ascii?Q?ruFsmoba0tWiTKnRyyRyo8BWVfB6mQBuTeUsx4hasjOI6zsyUZ6xmgcgqHCb?=
 =?us-ascii?Q?nGtE8SzN1huQdbGiig2GakHoWfhakNUUO1VtsJISg5SNuyX7iucgQO4NE4lU?=
 =?us-ascii?Q?o99dEP+4uMIP1no/uDRRobXqoNvrk+VQe9s2ACv0tdvQPN+YfRfk7E8UuNF3?=
 =?us-ascii?Q?fSXmw/YPOZnFmQ/MEzqurNsP3KHs7fcCWe57VKhq8zHDwE+LGn9lrpCJWDTb?=
 =?us-ascii?Q?gR90CjRxI5PuU6vlQR1JcsCUnYZqyA0P7Wyuu+Mm79sA5SeEMXU22OQx5LtV?=
 =?us-ascii?Q?vLsf80MZ+HzYhAVwIMb4sDZLU4bh6aeTYZmTbG0GN6TUmOdLGDJBd5zIVU0l?=
 =?us-ascii?Q?75rdCtYPSlopyq7WXiGPoiigeaEGbSsygcwgKbs9Cq9WDnI0EUrNrOiRp452?=
 =?us-ascii?Q?5iTUf8UTlPkZGAmtgcC3kNJEkeg6ZiGZuESCr2Sdqz4lUj9F58VfMGe8ogZa?=
 =?us-ascii?Q?kX33vtm/3Cwzts6ylRJh/HhRiJ8rHfaedkzLrorlBwjpvMD/jVl6dso/Vc8y?=
 =?us-ascii?Q?tIhRKC5M7c3K7RuEkq20tUTWSTlyahCH8DaqnDA4YZSfHztFsOTeTTaHoBy8?=
 =?us-ascii?Q?VEDcqjyWayIfRjqHFwYLxZnrA7fIW13lsNHHmubPWmjEVUd+LTM40aLStmM3?=
 =?us-ascii?Q?8YipuigKH43VcHo+13UjKzbTuJTX6hsd3pvDuY2hPFGSxJKhoYoCIwjH+rOJ?=
 =?us-ascii?Q?ys7L1UqMHaV/UAoHiPuJhH/YiMZkg0v5FKwKu8vw5DksGePYx+amIRwY+31B?=
 =?us-ascii?Q?u7aJ5dF4JsiryuXcGX5n21yGxkF4wFen2vFJhhPasxNz6dcb1k3ZBF3DhPkm?=
 =?us-ascii?Q?v7i3DQ/2a7PUsCud9x5ZkllHi7B6ccid8GzHPWCkREbKo7F6skWNfFJgbSgS?=
 =?us-ascii?Q?bZ5uqkq7x44lUhX5bqHZC7iv3FIFnrRdjnKFYqkZ36uFEwK1qV1GsA5DGy/d?=
 =?us-ascii?Q?sjTXDfVtIseqrFl3wLY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(36860700013)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 17:18:07.9552
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bd9b00f-5707-4b2c-fda8-08de01d7a800
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055E1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7891

On Wed, Oct 01, 2025 at 06:09:48AM +0000, Suravee Suthikulpanit wrote:
> To allow reuse in other files in subsequent patches.
> 
> Also, remove unused function parameter ptr.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

