Return-Path: <linux-kernel+bounces-831698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 841E3B9D588
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 05:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 363364A653D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 03:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48991BC9E2;
	Thu, 25 Sep 2025 03:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="R8I04f9b"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012038.outbound.protection.outlook.com [52.101.66.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D3F2AE8D
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 03:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758772728; cv=fail; b=AIQ/e8/hpaqXTCnhsKWYK/haBbs2MyGKb0JpI/aci/a9zjrHojFyuPqNP35YeMwY6rkX/9tO8NNhhqvr2T87Y7OfQNSIHZE0gHqBFOO20XOnPIZuDsKUrfJ1UUuce4XuOQIjT9MiumuglbKMhDEG+G/LBxFC3S5Eovr2tJ4W4v4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758772728; c=relaxed/simple;
	bh=fwclC1CvZeOcEg5msJTvI+uTatit+/1IcFeeVMnhgmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lh1rtBzMWnNfM45q7Z+svuOWyPmGF9ito6t2qPJIXUdbqpWFFAFkJg3AJJvXSJ5tKkUDBOW9gedmNmnFs2FwwxXjz5oupcclQeb4He+LcfvhC39jSjWfc3BP0QiupqAZPquZXd9Fgf8NWuUC6TbYP6l/kyYU0kFBXHDXQ16Y0s8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=R8I04f9b; arc=fail smtp.client-ip=52.101.66.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KTh9GOHvma4skRSbisHUqM9S8QPz19YmUOXwdw7tU9UWxsXuU4HIGFeJM8tXAut7WzrlwoZt8ZajVBbN4N0qtEZ6fLcfXpX8hkQBUUr74W77dyiyODpf9Ug9bhRzmugCk4BYgh3u0gjSslR9SvReK/ij2vy9OXemNE4dvAaqQ0QneA16ZXGSBNlW63wQ37g0tVIsbPTwXtsVmtkATo0aK49U/JayxCam02wfJsK4P7S71XgFa59D2n7WPQ4Js/qiaft3q8i/pVKuG712iGvnwm2Zpv/nd3Ld9V7hhKq+tZ5cdsaJhB3ORhJ8JBfhpuYX1Rvb7wbduJtjrXu7hiCkMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2wCCyfYeRD2IFSBTLmGsU159j7Tj1QVsG95hOkKGvgg=;
 b=wK8B1/kXDlLHpSAMGlQ7rUN95GOTrj4MgxlTLIFBoBi2foM5piReseW80V9HsQXEB5xOlDON1aPvtYgZ8id8YPS76umwBNndQE4aniMUgMrcjsuLMXA7iwv7HDUBb4IGon9EWV0imgeYUj8otil41zuGGkB56YQOY9tp00RyvzoGUQhuowoVaMdLBeKXwRAXxW7gP1Jqf8ozjnOvOqqHhL04OMjSsiKA5ZjaXwJnyKz95n1CHiMtKNiZ2f068TPjyhP1NRYokfNffLW8okSSgAdjP2mJ07rbmjEg9YHYp17slqZGQSKWxWyu5lrkwthe4nbOuJNZKuleC5MSg8xdoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wCCyfYeRD2IFSBTLmGsU159j7Tj1QVsG95hOkKGvgg=;
 b=R8I04f9biuLmEgqj49iepbf6M5UL9iGKe2FU4nDIqjm9bESqwFxvmMXtdxKrX981c8tDm6J9NAX3kCNbu6NRcI+V+x/Yksr9sNe31y7XAGGb9hGoDWeJ+Sdb0wKgANvJpqaqamkuhE431p6d3XCi6Ln+Cla8ChBi8aW5ZJXA/zv+ptqrg3Fs7JojP8oZ3mQMN2YSakhNW9AEH+rXBrwXdAUhTglI7dhcjG2L/Tx08neQywtrWK5ECSgBCM/imsJxNr/JT3GtaVH6jZR0wo4TLJNne67E/F+Js9AGysl5EcUvlkFUiPqLS8ow7PhkkIs9Ak5SK6UxalWC0OMYvgUdiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by AM8PR04MB7267.eurprd04.prod.outlook.com (2603:10a6:20b:1df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 03:58:44 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 03:58:44 +0000
Date: Wed, 24 Sep 2025 23:58:35 -0400
From: Frank Li <Frank.li@nxp.com>
To: Xiaolei Wang <xiaolei.wang@windriver.com>
Cc: vkoul@kernel.org, kishon@kernel.org, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	linux-phy@lists.infradead.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] phy: freescale: Initialize priv->lock
Message-ID: <aNS96z6GZb8sUdOy@lizhi-Precision-Tower-5810>
References: <20250925013806.569658-1-xiaolei.wang@windriver.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925013806.569658-1-xiaolei.wang@windriver.com>
X-ClientProxiedBy: BYAPR11CA0082.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::23) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|AM8PR04MB7267:EE_
X-MS-Office365-Filtering-Correlation-Id: e209ac5a-03e7-4e09-88b9-08ddfbe7d1c2
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|52116014|366016|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?mCXImGLVA3jtOg8ip7RLshTS/np4ILLeaqp/mpCR/Ae2pvyV3TELoexe6Ekv?=
 =?us-ascii?Q?lJYvE/Hp6XZM1Tp/nTd6TSTx1fc+7qc2DN70SSmBP8NjluPNJjBGyxwxiPOr?=
 =?us-ascii?Q?xFTuEa2c+GZ4BvjUx8cS4CkQJl97cWsE4OnGJpsMC09d6z/PxE1LGc0BbQJK?=
 =?us-ascii?Q?/Kd4GLyW6T8iT7rKwFEIaHhEuWusEOnjLs6aR7gSiJXZY/GXJ4sq6nZCz0/6?=
 =?us-ascii?Q?ti0Esrp9kb1tR0NL2RxdVKie94/s8CqIZ6gIeyhgdTaqez0ETSeVJw7mj8T8?=
 =?us-ascii?Q?HA+lDyeNFBaVg0FqGrHM7tKeV24YZycGKI7D3fRDiQQ8Gc7X7ct4S9IznIGf?=
 =?us-ascii?Q?sXRED3Tm+eovOMqEsIrEmScSugM/ycK4wbm8abVnqmo5V3Ltu+fc0OvfFN25?=
 =?us-ascii?Q?kITpUplnPm2OthT/5OuAcq/ojHB+uC9K2+pFTyV9WNu0PlJtKjuGorNE7gni?=
 =?us-ascii?Q?N2l+eKpramiym/k6hSE4Gs0FpmDIN44tOIWXASlQZ458BR++QfS5akNTxSSI?=
 =?us-ascii?Q?UwRSik2M3NMeAhznVGqKxaGngR7tD0sJWglujPFjGEjdYSWbhle/Ahy9sosF?=
 =?us-ascii?Q?GclHcdRsIMMBlSHXlDAxoLT6yO/5HP3kjEgfDX3SKPxlDxjkz1FIjNnqVI5V?=
 =?us-ascii?Q?nktJlxYih7x9lQnwQWn1dhComocnTcbhkwBAIa/VmNKvgWRsU7tJmZ6jIgBa?=
 =?us-ascii?Q?0wjQ/ZC47gFHKN+1Uc3OLLUJM4XRoxLLrpjWhcB722ONWhThHTgZ41RDmFCd?=
 =?us-ascii?Q?2zXA++y4Taf3hMLr0e69kQOWkZz4hqDjxIXyhFPdEtOTK+JaJHJuG24cGucj?=
 =?us-ascii?Q?5PrkqARqAZqrooyExghxET1MTwGbRNb9GxUoJrWpixy5EvBhIgP7wx2tewNb?=
 =?us-ascii?Q?s+Nn9JIoQrTJx43ISgD+4L0WuZoisfX0A7wzupcLR7Pr0g/MudCEouV4fK+d?=
 =?us-ascii?Q?PnCRoS6b+PPEPLRBLylta3NL1QTcBlkghgDLVNubVhqCdh3aLArQeoTB0DHo?=
 =?us-ascii?Q?zipnn9TgOuc84/ZSxU6s1E+zrpThvL9m7gkz5IYBWwxOOBrT7e+L+X7Beh4P?=
 =?us-ascii?Q?cnIK40ncsV17VJ9aqOYzYHaOT0+NGIYJFKOiPSPsTr3RC2qXoGHCvf6/p427?=
 =?us-ascii?Q?yGUheXfoC80JvEfIVGLnOdDuU3jVuiB2xSfzwP7ENg/CJho6/rOgLXkbfILv?=
 =?us-ascii?Q?kAzxYRBnCt+E/VF/lgXuBntlkjSrziUx65n1+BeF6q731PlHeImOjW86gPvX?=
 =?us-ascii?Q?IB2nm6hgGx47BaAxfNAkOJzSu97yGYZO4MFyHBuWs+OP6h+TTmHjjoIAcM+6?=
 =?us-ascii?Q?v289wSxcrQOwPGXOvinQ3OWjk3TrjNpB5XzavhmbQPDi+V7Vjvt5V9vVq7R8?=
 =?us-ascii?Q?IriptZFQBNxURByY1Q2q9x8fjVzf3L/3aIgiw119lSprdw4hCCz3WmCJ+ZXJ?=
 =?us-ascii?Q?kU0MChN1A9A=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(52116014)(366016)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?AWnfMObfDtjwdmDJ/uzHfbrN/ZoJZBCGb1Vz05LOcYdyMoc55jmLMUauWBUy?=
 =?us-ascii?Q?P8cQxgLD+jgr9E7V67g6++nfsoHWA9nb4DRSKEx/NMGm8RJdsPH3GcNabGy8?=
 =?us-ascii?Q?zYtKYn2eh1vOVnRDzMODoRWJPX8I4pE/GsyJiMWUrh2j4uqvu1VkFeiwwh0o?=
 =?us-ascii?Q?ncjyoH8KL763rwQ9yv2IDq8DorjFCTZ41xgtz0HVOik6ANDo5gOJMs6FFqhb?=
 =?us-ascii?Q?Lx28moB0Hj4YX0UMTvJUFmyy2s523yTTenzlbociVJZ2uHEZR+/g5LbJWBvZ?=
 =?us-ascii?Q?mmPJFhIBke9o1dBLh2C0c8V9SyWqDTbFnNue18Op5x77mYV+lBqG6fvRdP3A?=
 =?us-ascii?Q?4MLEI3uZPjA8oniNBmXbPEP59E+rlK1K0r6IlqNHrHZPwVoj1qQpl9fCfglj?=
 =?us-ascii?Q?fBaPK+RWP/0lfhU6mmFFGG2NxFG9y1oua21IN3ZJ5QR2zFIst8QwlsGr8UDM?=
 =?us-ascii?Q?jM7SMP9+yn44CFgIVREWNKLFcxmOU2NY4pXGvmE9oVPliniR4tP1ecIpifdB?=
 =?us-ascii?Q?hDAj3cqrlyl/dZ2jEM6QHJ0FAKjC+sAhNJNSuz2hggtGVAOA7VCLrmkg/arF?=
 =?us-ascii?Q?jsEjyWjd1Z5JfV4+eS62rfODLPf46x+f5FtEEV1lQn6xxc6b+ogyyJOlgZlv?=
 =?us-ascii?Q?DjRw7fuh5X4w15GKk+0ZnWrilKyzBxC3k02FhrCFRuZ63qh/vGgs2Fb45m4K?=
 =?us-ascii?Q?g9n3KLgAIgfvhQPYhO/XgREyiihqKslO0GfsjO6rKOmK8AEIBENX8P0ZRBI7?=
 =?us-ascii?Q?rFICr8CLvA6AFA0nz6PHqKV2popXY0H5SHvZCWWh2v3TCJs9Qv+TX8UhbV4p?=
 =?us-ascii?Q?BeWemgYBcu+c/aL8P7jTT6zTAwgjL2fxrRpm+oOB9lb5qBEFhJjeddOgTQR5?=
 =?us-ascii?Q?yqDX+S/1coqZJy01d3Z8ZvhL9XpRYDe7tOR+pxarR/hH+s5JNvxWsiQ3lz/S?=
 =?us-ascii?Q?5zxoPU4SbfBf1bGoG7V4FB63fnsbEgp3ZkIJSOPSbqb9woIF/VZkURU7aEC1?=
 =?us-ascii?Q?fuk+PYbP8/9OHJai3DaGSd+l4Xcc+yc51pBWnQri8ax+D4wwd2dJJMxZBLjI?=
 =?us-ascii?Q?nXyoU6eYcrOnSS97je9f/TxEbKlAF79g77TtN2njICJymssY4p0fVAWMxK8E?=
 =?us-ascii?Q?yHwTNGxfM0+8PD8l5vmVqUhLcSCZq/RdfxJnk/O36gzU7TiGSI2S44KNygxY?=
 =?us-ascii?Q?h6a5/wOel1Qf+AWgUPcEAHsmS4SSD6bnZumu7Wf9/mi6HQRcwXAtKGgLgWhv?=
 =?us-ascii?Q?/Lbk7pPAn5rZGrBP+t5QzayaKJocbJE4VUNjFnSnB6AF89XQwclim38DBjWN?=
 =?us-ascii?Q?syRPz9yGwUAeCwoaSkovxU5wdJHK6nZhpei4Zet0giP94iOANLcgJVb0qHZL?=
 =?us-ascii?Q?UiuskUx+g/4oW/ysY4kUoDqfLqvhzdppIb49BaB2wuDQalzYnfkwGNm6Q8Wi?=
 =?us-ascii?Q?mrrR7+u61JVg22DsSvNca95ZUPpw7ifUqUK4ODpLyx0OjTxG/3/iYUUfPtgk?=
 =?us-ascii?Q?QSG9j65N/w8+a9Buuu4nQVwYzjutxvsj8vZ5KmdxQUeC/PmlgAIzmKss3C+v?=
 =?us-ascii?Q?so6rWODzUrt97JwHKDjUoc9cD0+4DJZ+EMBVYhKS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e209ac5a-03e7-4e09-88b9-08ddfbe7d1c2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 03:58:43.9339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oUu8XO+L4Frju3QhIQnuf4iQsGQFxj2V8RbjgudrxdTeLlNFkF13auT3A9rcVDLl5ddknWQ1zQAoKRgWFec5Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7267

On Thu, Sep 25, 2025 at 09:38:06AM +0800, Xiaolei Wang wrote:
> Initialize priv->lock to fix the following warning.
>
> WARNING: CPU: 0 PID: 12 at kernel/locking/mutex.c:577 __mutex_lock+0x70c/0x8b8
>  Modules linked in:
>  Hardware name: Freescale i.MX8QM MEK (DT)
>  Call trace:
>   __mutex_lock+0x70c/0x8b8 (P)
>   mutex_lock_nested+0x24/0x30
>   imx_hsio_power_on+0x4c/0x764
>   phy_power_on+0x7c/0x12c
>   imx_pcie_host_init+0x1d0/0x4d4
>   dw_pcie_host_init+0x188/0x4b0
>   imx_pcie_probe+0x324/0x6f4
>   platform_probe+0x5c/0x98
>   really_probe+0xbc/0x29c
>   __driver_probe_device+0x78/0x12c
>   driver_probe_device+0xd8/0x160
>   __device_attach_driver+0xb8/0x138
>   bus_for_each_drv+0x84/0xe4
>   __device_attach_async_helper+0xb8/0xdc
>   async_run_entry_fn+0x34/0xe0
>   process_one_work+0x220/0x694
>   worker_thread+0x1c0/0x36c
>   kthread+0x14c/0x224
>
> Fixes: 82c56b6dd24f ("phy: freescale: imx8qm-hsio: Add i.MX8QM HSIO PHY driver support")
> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> v1: https://patchwork.kernel.org/project/imx/patch/20250923141611.1295395-1-xiaolei.wang@windriver.com/
>
> v2: Use devm_mutex_init() instead of mutex_init()
>
>  drivers/phy/freescale/phy-fsl-imx8qm-hsio.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/phy/freescale/phy-fsl-imx8qm-hsio.c b/drivers/phy/freescale/phy-fsl-imx8qm-hsio.c
> index 5dca93cd325c..977d21d753a5 100644
> --- a/drivers/phy/freescale/phy-fsl-imx8qm-hsio.c
> +++ b/drivers/phy/freescale/phy-fsl-imx8qm-hsio.c
> @@ -533,7 +533,7 @@ static struct phy *imx_hsio_xlate(struct device *dev,
>
>  static int imx_hsio_probe(struct platform_device *pdev)
>  {
> -	int i;
> +	int i, ret;
>  	void __iomem *off;
>  	struct device *dev = &pdev->dev;
>  	struct device_node *np = dev->of_node;
> @@ -545,6 +545,9 @@ static int imx_hsio_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  	priv->dev = &pdev->dev;
>  	priv->drvdata = of_device_get_match_data(dev);
> +	ret = devm_mutex_init(dev, &priv->lock);
> +	if (ret)
> +		return ret;
>
>  	/* Get HSIO configuration mode */
>  	if (of_property_read_string(np, "fsl,hsio-cfg", &priv->hsio_cfg))
> --
> 2.43.0
>

