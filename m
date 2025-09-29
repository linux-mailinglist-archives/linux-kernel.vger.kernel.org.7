Return-Path: <linux-kernel+bounces-836627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9F8BAA30B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 19:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C4EB3AAD61
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 17:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE2221C19E;
	Mon, 29 Sep 2025 17:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c0FHlgiz"
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012009.outbound.protection.outlook.com [52.101.48.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C1572626
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 17:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759167484; cv=fail; b=jvTdmmnhb2maPPHCGBKFBt8iuS2XCH4UC6KBV1czo4iFoae9wDUwMYVHJwEJk7tdoIFt/79rgCm+AxM7JRbV8QrVT4jStuabtH+wcgZhHnl1u+zrM2JANlWXVOO7x9NNYSOUzTkAyOrMqg1oTIh4EFQ+QJu2cPkTwgC6pPs57Rk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759167484; c=relaxed/simple;
	bh=VcNmE+Z4Hu6scszx6i8vPk1yavWuq9lBw2qRV8mGokw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SJZHoGFhyE+JQ/XIGndWXzLKdoRkJ36eljlrqrTklnSsq1G0uM/ro0ECCexkxPrduR9Js/AyyBuFAZTwercBaXztG8epI8s/op5gUbbim96QWPIqiYBKP+LWhlwMk3G5A40hqU/+1sZMSGBfwOmCubnIpi0w1InGLvK0tPVCSQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c0FHlgiz; arc=fail smtp.client-ip=52.101.48.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VDMq2CCp47es7DyBodDVrWytMKZpwCQFk2Upq+ibY6VHKMNVJcLlZk1YiCwiWqg5Owbnn6aZe9VxpxbcdwrzEZjql2rsjgi9IOnWU3r+S7vQvsEuakSPIE2FIRsRbS/tXvUxo2vEEFfubGSToS9BX+CHrmrXY9zRQnJcrnCRdhaWeg1Hid5eCfcC/ztb0EGdVJh2hIAxbxUSLry3jPuaCHJbmI6nV/wIcCM6JLSWDzSWVMADLBvklCTeTUBT4+kmyuRQkQe6xT6cxVd+MTCTJhYxhSVEzEydIgE9zBtCDoAwPI2GoEnG24/lbeMoSL+6s0ov/hLiqYDUvHcF4KpK4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oF74VPPHEjE4XwB3q2M/KfcPnKwJHc3I0+qZKMETvzc=;
 b=cVPIKQtrY48PU5KyqdAtcBDW+MBO5Qrz8HtlwkwbBdcxcJnKBVxYlWfPEbuWgSJJf2LNA5Qf4eOTvblsU74xKnG6Tq0s1R9xvQcGgZylofZXwEGKj+AN3DlCb+wL1yeWYaNVxMYwKxt660yeimclFZ9aQEOim66H11/yvk8wYt35atPhLsgtL18ysIYR4Lep+RBpIHpaNviojL8A7Baxsz4G5oBrU2SR58LfzxLL1m5Gy1Wf9wjPfua4x6cbOvKK8UXGYNKa2zU0HoUK5ymiiPyKcCcrvphuPOFZetFMcoE1THwngTFTTLVbmyVdNNr9g4EQUFVF2to1w83n6ZfejQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oF74VPPHEjE4XwB3q2M/KfcPnKwJHc3I0+qZKMETvzc=;
 b=c0FHlgizpouPngbGDaY4VL8cFyf1plkNlhUa6xga9MsMHO1LL37bgsoOzhG9P9uGmtwUmGCYUfe5bSiWzlVFgyZujNB+SelNeb0Jmhed9XwcteD8b8dfyyRQKYFTjeNuhc46+oZaVTNKIsUdej7aymOExNM/MyoINUgeaR2n+34xu2911UpvLW/dyy01XdvpY7cGtyj3Il15wktMQYF4JFtAcOnSPXGKSDdxpGqa2CZiAVdJ6bmTMDHN1xbqup8bRODCLRA8Bx561EzCWSjzwTfcS3Bx4RiCqVCIBPg63ZEp8oymSu47a8NLry8c2cbiqVY77N3hkCLEsRuvRL3S9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by MN0PR12MB5907.namprd12.prod.outlook.com (2603:10b6:208:37b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 17:37:59 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9160.014; Mon, 29 Sep 2025
 17:37:57 +0000
Date: Mon, 29 Sep 2025 14:37:55 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Leon Romanovsky <leonro@nvidia.com>, iommu@lists.linux.dev,
	Juergen Gross <jgross@suse.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	Stefano Stabellini <sstabellini@kernel.org>,
	xen-devel@lists.xenproject.org
Subject: Re: [PATCH v4 3/6] ARM: dma-mapping: Reduce struct page exposure in
 arch_sync_dma*()
Message-ID: <20250929173755.GD2942991@nvidia.com>
References: <cover.1758203802.git.leon@kernel.org>
 <2f20069c2b616808c034ba4e75905820b94e0e22.1758203802.git.leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f20069c2b616808c034ba4e75905820b94e0e22.1758203802.git.leon@kernel.org>
X-ClientProxiedBy: BLAPR03CA0075.namprd03.prod.outlook.com
 (2603:10b6:208:329::20) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|MN0PR12MB5907:EE_
X-MS-Office365-Filtering-Correlation-Id: e67072d2-7f07-4cfb-5634-08ddff7eedbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tpSBc9tfMjdSjmNhAiZRDTRAak5b7gvEIu1hS5TSV2mXP926e8a/UVjVn4D3?=
 =?us-ascii?Q?nPHjK08pgo3G0wFlCvw0IepJMcXZoLnaqcQZ/V+QozWBJjvH1mVq4gQt8qDs?=
 =?us-ascii?Q?9Sh0HYUJfEc7t4j8oexxXqI5XAH5npPvnl8N2HszXQh9tdY1aDBXtgDuWc5i?=
 =?us-ascii?Q?/uDOLASgMpQiGslQ0Ev2d1xOPgImuysmnO6hk4uYlT58xrFaDrn94vRMlBN+?=
 =?us-ascii?Q?GqcISxIuRNqHFdh15HGFPvsFVHAM1kqlGusRU416xEaFMFtUKLP0eAy/k+Ah?=
 =?us-ascii?Q?bQg2r+bXGt9QsTpNAoj0jtdUXeQeJvtnBV9QrrVdtZuhaazxd/XTVVOx2O0s?=
 =?us-ascii?Q?qMhGOPLPwJkMrfeJH+r8A1uyhxGc9dFwchah5yAFkl3XZWiy1yCvC8JqHhNW?=
 =?us-ascii?Q?JpdsGna+V+HcROgFJLyszqiSt8C1R26LpbldSdULISBFu8/yj3T3kR0KLDd5?=
 =?us-ascii?Q?HhnWv9QADIQ/mAJ+jtzBYDu2YUakz6iJXut4klcCya6dltAT/X9TmQt7NdWl?=
 =?us-ascii?Q?PaO9oLFb9EcmebxftlM6FNUG2xx3KNMmdtRshcfx9UuzrUo1EWbKPgAeLqct?=
 =?us-ascii?Q?3LZOtfMQgv5EoqkdKfZUkaNBdN9f48FPa9XvT3p8zzxAKNg+0qbRMi+r+iRB?=
 =?us-ascii?Q?04kD8rJ7H6i37hHhC1rLRZ/2t4GvHaDgrk58AHCzLSV2NY8OavN9HIGerjyr?=
 =?us-ascii?Q?6aU4SyaXQijxifse6LB/n29PIFovBr8vF2GizomdHoR16Y4GkdMtXYb4EcRl?=
 =?us-ascii?Q?i4vn3DdqMkYkKAcm8Q3wa3mWvVDRRMUFvEISKwfXmr1FsPh2+LbqtBCzevjZ?=
 =?us-ascii?Q?bgYRpJgBJ2/1gGVcF2e5MqAkuzn9VZSd/x0JYlJ2AJ7gn98zun/kwK6MouvJ?=
 =?us-ascii?Q?ZwAD2AyJ9cnK8hLUU+C1XNB77S8r2/vFYP6NdxwhyxsxaWJ4JcL2ZzzCmn3b?=
 =?us-ascii?Q?pfAfbZiLKPdipuVF0JdDtLeot38E9ZlRtm77d9zTQC6UwX1RcIBVaDY2EXab?=
 =?us-ascii?Q?ZO/y7tVUTZOiikK/CbQsvKQfU2RDJKH2TBscK2I4rjVvdc1qFCKsdb50jIvO?=
 =?us-ascii?Q?8aQIuViiYTBaW/XWvGrgv8Fgikp82zbBlUsmR3j7nENgYf3v8Qy5oP8CRiJ2?=
 =?us-ascii?Q?GPUGxSTBheHNMV7wmHEor9Zi/eahIbS2eGr9gHELyjgx+hRWK+/kHh5QwimC?=
 =?us-ascii?Q?OMvL5xsZJX0Xh3rluae9q4iKZCUFrV4S97Giz5/uaJK3NRjoGw6ujQvlVwVW?=
 =?us-ascii?Q?B9G55mXZcAKCwGhK9frdkUJuXGxWE1cQ1TC55aedr6uqCcQ0PFViLN90016N?=
 =?us-ascii?Q?X/+sdCUTh7AuK/19OtwtJWKDl0jVAs9eo/wk/ViKT1bImD205CdsxkQ7pFG0?=
 =?us-ascii?Q?RiqZkc/chsIyjWO0v2kZKJpRlUWr/zTJjBHLEsiTGOpJl1wkDMffyQgeTkfi?=
 =?us-ascii?Q?z2vv6FB19hwj9M/Pzr4P8Joc+WeoKwzA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OXqqvf5Wg1hkvjCceFkQsx3qwL0XN8hegrU1q2jK3v3N5wyqGihj3CXVnGpz?=
 =?us-ascii?Q?ZlA59uFHqhDEsrYVOYWGly+BhdVxpJoK5vsxCIPRwWtMr1wgG8vHpBBTwBFn?=
 =?us-ascii?Q?SUE5kCXkgwh4YUJTC7RmgBZUsr2dBr1a3ltjAVws4HchX3WwfCRsFtHtXge/?=
 =?us-ascii?Q?ALRlCU8VHfIrk9WZjaUDdq/ZWq4sB3XZKznAlObtHz5XJzcEBum+kymcblds?=
 =?us-ascii?Q?QOZjlZFiiSYDtdgws668HDXNOrjdwIWjot2M/aVqy9hT1q9cfFN8K1DmJ9wV?=
 =?us-ascii?Q?r0iDVvwqa8kPyZFl/RqgIvgCaxPgT0DL9tyzPiNt6+dJCB9almdMwpMy8zVN?=
 =?us-ascii?Q?bj524rT6MBSYK8H/SeqP2HlhWjjRlwe8uO57jsUXey1XvS8ofhP5S9N25vOJ?=
 =?us-ascii?Q?0VyyZHbCU0X9udZh1wsztzQEsfLwfXkyxZ9c/ge8h49op0Vy6IqpepJ3GBaW?=
 =?us-ascii?Q?IYueIvAMZUoOsrPOiYhQzTpb73OpCAacZoQUnidquFyHTlrR3L164l2wLoUF?=
 =?us-ascii?Q?qqhuEKe0UbJvRU1dy1tU48TYtldPZlORl8LFcnXSG7eKzJJOe5lsAM//SyZI?=
 =?us-ascii?Q?YM/yZKgz14CC9LPPitWsdms7S1R9FebupyUNU3BCYSLoVNSgLUfc+a2GJWAo?=
 =?us-ascii?Q?IxwtIXkOlPWMCk3ZlU6A7e/uroE5aditPmHlRILY/u6Aum/Z6p0qPeU+J/Fn?=
 =?us-ascii?Q?Oae6YCXfCy788MkZjCrYJkNfnAbd8QZdSlOyKckZJRmfCeOTPQsZWlwk7HsV?=
 =?us-ascii?Q?BsUJ63NFEtTJ/IX1RsmNWfM4Rp3L+9dhYF6qGl2kRYobv6V2kj7Si4Zfh1hW?=
 =?us-ascii?Q?FW13bKpNtl3QxYl5hj63hsAGoTpco+WyypWG91mPODjwzhzEMWefS9d4sQ+O?=
 =?us-ascii?Q?+TUkFGoLpnZeeXC7LnEIG53kjA8FvZzTFEQbKhtRFdQKtnU0Rvc7BJhdE1A9?=
 =?us-ascii?Q?OziqaZvQpMP9D36OdcXQ4rAaglS7BZtRGrS3dUcfZQthiQ/1a43yiQ7P0vKK?=
 =?us-ascii?Q?iqZsLwH3XTtl2BQMxrYH6FLZhC27XgUpaT7NeLhI6Lhzu0/PcEi83JU5rMTk?=
 =?us-ascii?Q?W+vfnHd9BbxrVF8ITJuckFJl8JIrxsZkTosC0et6VjgHAjHYSoI0+sEe3rTX?=
 =?us-ascii?Q?cDAxOV3sWJnu40a6Pqc/0q7eg7mvRkkgRcrPSiW1tUB680PNpKE2gl1Mk/7J?=
 =?us-ascii?Q?ibq8kkL7GV4eL9EQ6D2Pm0YxG0QvKGSQ383iSiwSXc06UUQQrS+o8w59B3N2?=
 =?us-ascii?Q?XLYIwLYhL9eKkjms5YC2USlVVWdWTwW6pGNwRwJ+2qAuYFDjZXB82sHZCrGD?=
 =?us-ascii?Q?ADBOHDc477IlQuNPgV7Ogd+XOG3+yfGE30Kry2ojr51SZc1iy9K/IMOK+SJd?=
 =?us-ascii?Q?1U+esNcQ1BmzwOKZUXUOJp+Lm812wtduGxfHFK7EWeddQYO9ljGDQLAw8OPQ?=
 =?us-ascii?Q?PPihGidCyLhXiK6ytg9nbkofrePm+4z7kLPv6a9Qu/Vjw4zO3Vi9eHAmdDul?=
 =?us-ascii?Q?ZjieX1PhWvQeNvnkzrU7L/IMrry1+ct8hEJZOumBrmT6uTuMogLcTQyGgrRh?=
 =?us-ascii?Q?MerEJkZGzY5zr4QGB5XTN0B33/sD5ao+a1Giqtzr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e67072d2-7f07-4cfb-5634-08ddff7eedbb
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 17:37:57.8585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PjbfPMXm/K6Pv13Dx14ay3arFUwSi+Hnt6H763AyJRqGyJ4SyYrg7WPr9UdQ3XP8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5907

On Thu, Sep 18, 2025 at 05:09:26PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> As a preparation to changing from .map_page to use .map_phys DMA
> callbacks, convert arch_sync_dma*() functions to use physical addresses
> instead of struct page.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  arch/arm/mm/dma-mapping.c | 82 +++++++++++++++------------------------
>  1 file changed, 31 insertions(+), 51 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

