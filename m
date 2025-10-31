Return-Path: <linux-kernel+bounces-880391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61055C25AB5
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 15:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC96F1A615B8
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D1E34F47D;
	Fri, 31 Oct 2025 14:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kczf8wxt"
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012002.outbound.protection.outlook.com [40.93.195.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF02934EF12;
	Fri, 31 Oct 2025 14:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761921813; cv=fail; b=ZDtKsuCMZbKshHPNT3bBmIspRHRMIbvWILVJKB4STvDU8vEhFxHvx5LhxkDFlQ5p7wccEikb6OAq2yn0v6vPJCzDe662zWimwGWsqpD9rfsZ7W16V3X9gLqNYwD5p2henHmEBYPPy2aC84FkivIlbdETKKRUvhgs+cLod7zG84k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761921813; c=relaxed/simple;
	bh=0JIv3aEpc9I5/8BH413cRJtsdLvIuUom/cGej8HDAfc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZzYE8yxOQuCmcOKqpDfudeW4LiJ5Ihk2OLSTijvnDzNsonLGaUBzOu1ra/Rf92sYRI+bgJaK8BJ2t1R+zSIBLGLJMvbhs4R7lg96QqlvD9s10PTnnH9Nx7v+agaeWIXLQHXktBFJA+XveRzrcyWZcOwBlGliDEy98VKTHHuJ8Xs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=kczf8wxt; arc=fail smtp.client-ip=40.93.195.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m0pGIxHsTQVW+kawZ6dkj20xNbFclShEc65PWb4+ZQEycheQfD9dxT4NYGcvwX/bQ9WYkElgulB9GZ5E4nwzh1PngASbCzuI+CDq9J2defSeGjFAWS+0nzjEWO7PLO7iMTuJV50eONn8fvU1YOfh6fALCsxLG31rnGsKyWqYlBJom2tfGab3PbU99SIwibH+wFqBglD2xU2q8RPDgR8L+Y7M6XZvYd2iBUNzXshEdS4XlUa+PIPkMy7cLP9xmExPIVkqBlp5taGOMsbx/iEx2u8CRr6ORVCrUvdVwC+1VDxKcZxggS/iWExBa/JTJq6UXaLL/J9uK6K8b1rbT/TbzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hYEz0LlzqW56NSEG9zzoWDnjyQ4mCMBlcUdJVY5yHng=;
 b=HAX1bpAujsk3qA3Gxb2Tnst0im1N/+uZGfQ3VexCAyZ4q7HSbeaSIf12mvs24qX8h4/x43QyxbGO32nFXIvTTLa8pLu4v5rVWDOB5lQWb/m0dGNSIjbdkcGi5JZ+bPdmDQhe7tEPQcBW/HC5BPRlpcxvDrOj53eyUp1nUIrw3ecq/RZsHu827sdZ2/5xwBvoh9fIbT34YCiyK9UjzBQcXVHZNKxvaJnaK0h+eZipKqqrlurz5sz8o8dNdyukUsaYqDuOsnX2FV94Wno3EgQw+O1zTImurdyAj+ZUAFrtflSsPyNetCmTt6n647szzEXhaeCKiS3BwRsR5lCvwXRM5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hYEz0LlzqW56NSEG9zzoWDnjyQ4mCMBlcUdJVY5yHng=;
 b=kczf8wxtmD6mTJOjHDuGbLRVfz6nfL0GwOwfANY46ydVb4U5iQkEu57YYiE+dmad9KTX5oK+TZbO7bS2iybKqeS9JfJ1IRZ/jU3iAzyDe3uXV+Sa/Xv8tsA9HSFNzRJGgQD/GKL7/zhs67IZxOMDlq68GTtP82J/8pkA6x6e8WM=
Received: from BL1PR13CA0318.namprd13.prod.outlook.com (2603:10b6:208:2c1::23)
 by MW4PR10MB6372.namprd10.prod.outlook.com (2603:10b6:303:1e9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 14:43:23 +0000
Received: from BL02EPF00021F6D.namprd02.prod.outlook.com
 (2603:10b6:208:2c1:cafe::e8) by BL1PR13CA0318.outlook.office365.com
 (2603:10b6:208:2c1::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Fri,
 31 Oct 2025 14:43:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BL02EPF00021F6D.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 14:43:22 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 09:43:12 -0500
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 09:43:11 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 31 Oct 2025 09:43:11 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.233.103])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59VEgf5c4024498;
	Fri, 31 Oct 2025 09:43:09 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <nm@ti.com>, <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Sai Sree
 Kartheek Adivi" <s-adivi@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-am642-evm: Add DMA support for tscadc
Date: Fri, 31 Oct 2025 20:11:00 +0530
Message-ID: <176192142807.427883.14111257672969371338.b4-ty@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251013115225.3668641-1-s-adivi@ti.com>
References: <20251013115225.3668641-1-s-adivi@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6D:EE_|MW4PR10MB6372:EE_
X-MS-Office365-Filtering-Correlation-Id: 58b9152d-6995-4c1b-7374-08de188bd742
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|34020700016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L2hpczByaENldllNRE03SDJZMjBZcHdzRE1DbFlXV3V4UjNLRmNpSHc1ZVB1?=
 =?utf-8?B?L0Izb2hEYmk0ZzhiRlpVNzdueWd4UkpjcVY1bzdNT3FnamZGcGtMN2ZNaDl0?=
 =?utf-8?B?TkJldFRXTU1xaVhoSHRscXBnOWltWlFQOHdXSnA0QjJyQStEdUJNa2hBVU9t?=
 =?utf-8?B?YjBPYktCMjY0d0JRelhzazZYMytveUxNd21JaTAwcWVHeXlkN1hCTzZBaHcw?=
 =?utf-8?B?MWJXUHdqY3pFb3BjU2RuYTAyeFh2YlRpSDM3V2dOVWxRSmYwYmVIajJ4eEp1?=
 =?utf-8?B?cW04YXp6Q1ZGY255V3A2S1dFYVpqQmptVStBdTZkckMwRmtQQ1Bwbi9ZYjlz?=
 =?utf-8?B?YWJqVlBONXNVVVJwM1JmdUpIamkzNWRyR3NqVXpZWjQ4S0hmTEVIR2RZdG9U?=
 =?utf-8?B?b3hwSTlzQzhqdWxUSXFURC90RW1vRGpYZ1hqdCt5S3Rlejk0a3dSRlJGL2Zu?=
 =?utf-8?B?b2c0WCtHUEljUk9WRUtHZnZKNkc1aCtqcmtVVm5zUkN4QWFiZnpZV2RyZjYr?=
 =?utf-8?B?bjBJaXJuMkFYMlV3aHhwZlVlcG1udUljaGlZVkplQzVocVQ1RVl6UDQvZW5v?=
 =?utf-8?B?SkRYK2pGdGNZMHpLc3lHSVhDN1VDQWQyTDNKN1o5UURSS3Frd2dyekNzOHVw?=
 =?utf-8?B?RU5XZ2xsSGZ1OTY2elRkYStrWHlKbWxxWVhsR002WjFuK1BYdnQrTjJlU2Q2?=
 =?utf-8?B?dnRKRnVVM2RzNFFyWFNEMU0waGtyZEUwRVNCUENWM3o3eHlKOUdQWEF1MWpr?=
 =?utf-8?B?SGVFSldwZFIyMzJXSi9lcWNQa1dhaXI5SHdTbm5icm9vbWxJN29jaCtKVXlE?=
 =?utf-8?B?OVFkSTIrSkQ1L1FEYTBNRk43UU9kWUdsVC9sYU53WEhZUVBnalhTYWltVldM?=
 =?utf-8?B?aDFuQXhSY2cyOHF5Um1VMzN1QWhRUk5aYVFlL0syakpXMGNVZldCN2hQVDFH?=
 =?utf-8?B?U0thNmpCanJlbFljbjBXUjdQYmd5aDlSOGJLNEIyak1jdVNITEpaY25jbFk5?=
 =?utf-8?B?MUZnaXBSMjhQMm9VKzFZWVV3RmVZeng1d0c3eFBiMldYajgvV2lLVEgxek42?=
 =?utf-8?B?UllBWDV5OXpVc3lsVGc0alN2SmVydllvSVZBY255MVBFRU5ScFljN2xUdmIv?=
 =?utf-8?B?cUVuRTUzSndlTWRMb1JaQjZVMGJyVjZXeUtJQUtQd2lJaWJwTkswZkpHM2xv?=
 =?utf-8?B?KzBhUytCbk5UM0NHTmNtTUJQdWVmNjVOMDlOdzJrU2lTWnZOVXJyb0NBT283?=
 =?utf-8?B?YnpFaVZUVkh5b1hGOVE0bXMramZaa2VLSW9sa0ZyM21EK3B2MU5KcnJSRHQ3?=
 =?utf-8?B?RGNzNWl0TW9uL3B2c29Ka2x3QkxvdDNia0poRGlSZDBBU3Qvc2VsbE1ReDNX?=
 =?utf-8?B?Y0xBU0cyTDdSWmxSeE5JSTd3b3RxQnovRDVRNTJQSUJCZnFLRGpDWlpHdjlk?=
 =?utf-8?B?b0kyU3RsY3E0Y2x1cFpCdFE0UVpkSXJkSUg1Y3c3TnNWc05oZlZ0QWl5Qm10?=
 =?utf-8?B?TnN3ZlQwYUNUODVmZ1RBWmNuSk1RN0xaM3NIOTZkd3dNRVJ5RWViYk51TWZh?=
 =?utf-8?B?cUtrUnYvSlZTaFJTVEJQNFNidHNsOFc4VHI2L1FOMXJYbi9WVTZoL2EyeFdH?=
 =?utf-8?B?VUM0clVxSGtoL0tSZUpPVGtBSmpMdmViRXNHNkp3WkdWVFpjR3JoenZjTWwx?=
 =?utf-8?B?K21ySkNzQ0tOSHo4ZGJVNy8yaWl6RlZaTGhoUERKWExZU0xtVGFVL1hqMVND?=
 =?utf-8?B?UFcwVHN6cTNRKzF0QWlCZENaQVQ5ek8vWGlWSE9YSG5Sb2k5bkFhWlJBUGJM?=
 =?utf-8?B?YWdYdGhrODNZRTZRekFmeC9WOXoxNkJMbnBQa0d1d2tOR2RJR1JpWXN1QXAr?=
 =?utf-8?B?a1UxZkE4ZE5BbkJoU1JWUzZieFNQdk9xSm1Xdmh3YnBRZDlTZEpoVUJRMjU5?=
 =?utf-8?B?SVZVaHVIZzFJTmNPdDZ1aHJFVWtzRFlaTEI0WXBDajRCTktBazZzZk5RTTNq?=
 =?utf-8?B?aUFOOXo5QXpXOVZybC9COW1ydU11NnlYUTF0aHBST2FHcTZEd0NxYmRVU3ZD?=
 =?utf-8?B?alhaQ3l3T0xCYnJRNzhKTUUyeHJRVFJSdGVnN2ltcm5GYytKanVES0hGQ3k3?=
 =?utf-8?Q?1g80=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(34020700016)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 14:43:22.3430
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58b9152d-6995-4c1b-7374-08de188bd742
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6372

Hi Sai Sree Kartheek Adivi,

On Mon, 13 Oct 2025 17:22:25 +0530, Sai Sree Kartheek Adivi wrote:
> Add dma support for tscadc0
> 
> 

I have applied the following to branch ti-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am642-evm: Add DMA support for tscadc
      commit: 5ccb63373d6568d9f99e927b23bc758a4b102a34

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent up the chain during
the next merge window (or sooner if it is a relevant bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
--
Vignesh


