Return-Path: <linux-kernel+bounces-769521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CB7B26FBC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 21:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBAB5170E4D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 19:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AFCF2405FD;
	Thu, 14 Aug 2025 19:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IJ7EsMH3"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37B71FDA94
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 19:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755200032; cv=fail; b=p3rY8v2HOuEwPrjZXqYtgPNXqiCh1qe105eXChYAvThNkZsXYqy4vfxeQH3NB8gEe//f3B+nsIU3RCv7FOx89TipFqS8qZE4EhytZFfjs/jkGptNYErADPLpy8SdvZKwnq/Q9Bhxw8arXoFLtcEehO3sMIRM55LqshtZK4mjfY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755200032; c=relaxed/simple;
	bh=C///VMGL+OvGGY0W1jxYKYAY4uP6kivnHyAEvtAARGU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=biNHgP1+/UGgJfsJs5YgKg77EtSGm9CVJxTuNaPmsVPeJuX1hj8K4sPMNvnA5MsoqK7Il6nj6MMIboYLjjl6tSfIQjgql3t+lLS32XwzDmyRxnO6jvLgTop/UXc0jb1Br08XsVp/A/0kdYsQYkGJnmQJZJZvpVwh8GFHjsxvaVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IJ7EsMH3; arc=fail smtp.client-ip=40.107.243.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dd5vYvfhcS19qAVarVlaZIOCu4HVzaCvsJg0FAFl9q/z9NjjNZO/zMReCs6g0X4BUOVioxY8b8OaOhZ3QXoulzPg0E5itOyMVqDWphnzOtiknNIR3z2FAMO29/mHjMucU1hvMs29+Q8IgmdICu3NFfRBI+IKKAwTZ7QqOGUF3qVnrzkfr2ojoLJXk8Iv6obIXIHNogVafktdas9lkx4eQ3hfdTa1aUdJysAUdjmOQmFVPaD2vknrVbj9R5LWig4WB6RiFbxqaY+l3hYEQLC/lXtda4JBO0b5NV7Ofw7ekBGWv0vtayyVnDFEf22Dq6gesnB9PJXf8KLgDQ8IkjqR6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DWaVugKrYm+5un4zhoeWtiYbTwawlrIIBqF5NcU+BBU=;
 b=QRoPoaMGIDNAvOdqBODkrn3ZUzI2wWq8eOpG8LLkr77OFj3tXsErlyvSct8dKU7mw7LC81+1OuJsfoU6Z7Q1fB+iiV/Kpn7yF2Uv9U6k1Wr6yX0EcI5xqnl6tRqpkB/2rMJlWexGeyzW8W947xFBYYE85IBfvuj729FoKATGzIQ8JILnPOf2sGGHddx0WuIXCiDs++8xEOTFlx8Gbu7IWS02bNGnZBdDfWYeRgayPfBNTGt1oX0Q8pPkB1cWRhS/lPcxJpKbR1Y6YlVmMdloL2v+OAIZmTkConlbF4nUW/KECIj4O3xudw141frIIpUw1sppbkbVvW5wlLPcqm65tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DWaVugKrYm+5un4zhoeWtiYbTwawlrIIBqF5NcU+BBU=;
 b=IJ7EsMH3xOM8gAuIPe07Hpik99HVafEZ+Vp2deQqfeEpjV7ALhxtIBE0fe1TvLTxRq9kddXngy4G1mSINvSHUGkGvIQJC8HnjKfHP5K4hbFpa20pAerO2OFAsCF3T8S1xnSj572KF8GLBRdkxdKAgFgp3aoGfBqru6dYzezxfHzP0RRic4z+taofXV596SifMo4pvLesi9ALjwnRuVGxQh/TAaJMxrWNdQB3SGRm4Ybg+PbpiqzHdx8WZ0QYeamOUshdvOJwmeo5q+actRpM7gbzyvsao3v6ii6ccbuyQ8TWoLtQSbg6TtkRZ1H1Rr98elNo0bVz1hX9zAUeQ35y6w==
Received: from DS7PR05CA0094.namprd05.prod.outlook.com (2603:10b6:8:56::11) by
 DS0PR12MB8453.namprd12.prod.outlook.com (2603:10b6:8:157::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.15; Thu, 14 Aug 2025 19:33:48 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:8:56:cafe::2e) by DS7PR05CA0094.outlook.office365.com
 (2603:10b6:8:56::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.11 via Frontend Transport; Thu,
 14 Aug 2025 19:33:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Thu, 14 Aug 2025 19:33:48 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 14 Aug
 2025 12:33:41 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 14 Aug 2025 12:33:40 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 14 Aug 2025 12:33:40 -0700
Date: Thu, 14 Aug 2025 12:33:39 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: kernel test robot <lkp@intel.com>, <oe-kbuild-all@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Alok Tiwari
	<alok.a.tiwari@oracle.com>
Subject: Re: drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c:305:47: sparse:
 sparse: incorrect type in assignment (different base types)
Message-ID: <aJ46E6IFcMGXITDt@Asurada-Nvidia>
References: <202508142105.Jb5Smjsg-lkp@intel.com>
 <aJ3l0Te5Q1d4g3u-@google.com>
 <CAN6iL-SXvgRGSmUQ2-M115_y_k=cVCH3M3UATO7SzC8vMV3T9A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN6iL-SXvgRGSmUQ2-M115_y_k=cVCH3M3UATO7SzC8vMV3T9A@mail.gmail.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|DS0PR12MB8453:EE_
X-MS-Office365-Filtering-Correlation-Id: fb12b67f-1b59-4e41-dfd6-08dddb697ddb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZndEUU1kYXAzRnJlNng0c3k5OVRvNGpkaVlpbzIwMStzUldFNEZ6aUdzSFc5?=
 =?utf-8?B?R0hGNVltVnJMWllubE53MHREcFd5dWppcXkzdlNya2RvbTdwWElPQWVoVW04?=
 =?utf-8?B?OEtoblR6dFpIajVGeGxoYjdtSlJFSXRaOGpJM2hUSTF3Y3F5SnhoRVpSUHI2?=
 =?utf-8?B?ZktVanViT281K2s1NC9ROGVmSXhPUDBmNW96SWxxMTNFaVJiUGlWdktZbnRv?=
 =?utf-8?B?QU5JNklTZU1QTnVxQlArVWhyMWtJYUlyWEVlWjh6bXhtdjgxQmRwYlFuOW1T?=
 =?utf-8?B?QXN6b1ZwU3p2QkFxaEFWUnZvRGQxbFNrRkI5UHQvelBiTmpjb3EvRFFMenN3?=
 =?utf-8?B?NDlqbU03TWErMTdvOWR4RnF6cXgwaUxsMFg1b201eDlIVHZQUFhaZFRqUEEw?=
 =?utf-8?B?a2tEZUJkTnQvbXRiRmdQcVBiZTBCVjRvWStvcXVJM0d0RkV4b2dVMm5QUWdJ?=
 =?utf-8?B?N2p0M2lad0JpQmlOS2RJSktNU1o1VUlaMU11ZDBxK0tqZzhGZ1hPVFErVTg2?=
 =?utf-8?B?LzJHbFBiWkg4WFd4M3oyWHZhbHppaUlvWnJGT2xsd3dXbnBmSUdMZzNFM0ZG?=
 =?utf-8?B?Q010cFJVM2tubGdWZDNkVGU4UWJlVjIzdEc3cjRRellxRWVXSi80QTJOY21N?=
 =?utf-8?B?UGhrZmRvdFBodk9EeHA3SENyRGJBNno4UWdpeVZrMzRiR29SeFhmVU5wNVRW?=
 =?utf-8?B?UjRyVG9hQWFrUk92QmxTakJqeFNiTWpEUmd6enBaSHRSY3JTemt1dlB4S3dU?=
 =?utf-8?B?NXgxeTkwcnExZll0MWpXY1F0elRES0xNTENHR1VpUXMxTHZpeFlmL2xISDJq?=
 =?utf-8?B?Y283bS84dU9TUWFTby9vNWlCRlpxSXZqTktia3FDOTMvN3BoNTFacEx0Zlc1?=
 =?utf-8?B?R0s0aWN2UHlXOUNod0ZCTDFZWVZiOFY5Y2dzUWJMN3gwdEVrRWsrQTBaL0Rn?=
 =?utf-8?B?dEpmZUFQVzNnSTFqSjgzKzZsQkp2TnZsTjZGNFNVTFhvVWJhT1VUaEJEa1lL?=
 =?utf-8?B?N1pZQWk5QTFUMDRwM2Q2d2VPR0hCZWEwRnF1bWVXMyt4WVFqYWk3UTNxU3l5?=
 =?utf-8?B?dzBVbDVXZE83aXRqWU9xVXVhOHovVytCbGZKQTBQa3VzdGtscWxOY2xNSVl4?=
 =?utf-8?B?SG9RYUI4NFNHalZRUFF2OC9Ud09lOGEzc3hDdmdtYUhRS1FZQmtyWlJmMmZL?=
 =?utf-8?B?QjdTY24zcU50U3B1Z1llL3p6UnFlTUhPdTg4cmxTK2lwVll2U3luRmNMRXBV?=
 =?utf-8?B?YVVDZ1Y1clhrWFJpK21LZTk4eHZzL2lWUGQ0aitiUE9jSU9DcTg1K3A2ODk5?=
 =?utf-8?B?NGVTQzJjTGd3YkY0Q25qYWM0UjVEbkJPbE5tcXlEVVRxSXNvU0pJVWpxcjNr?=
 =?utf-8?B?UHFJQWtsOHJZcnN1bU1rbCtPTEZDOVBnK0dsVzRVV3NCbElkOGN2WG02QXFn?=
 =?utf-8?B?azFWb1d2MHdiOUVaZm5KeHgzN3Ivc044b2hIaHk3TWhIcVJTNlU2dGYzZDNn?=
 =?utf-8?B?WXYxSVVMa3VXVU05QVdvY0h0ZnVTM1pBcVpKaDVlUkdnVnBEZXJLTVNubUxT?=
 =?utf-8?B?OE50amFuUHQ4T3RyZTYwY2F3S1hxY1c4L2VWR05rMFRITFVzSVV3aFRpWVMz?=
 =?utf-8?B?VW5UcUxhc0pOLzdPT2hDZGR0VUZac1d5Z1RyMCsyOUhTdEVIRHB1Z2xTNi8y?=
 =?utf-8?B?T0txOEZwQUZUVHh3U0lLajRpZXNTRGpXUmg1U1g4UGFoOUNFQ0o4VjZKUXlk?=
 =?utf-8?B?eUUzZFZMTTl5RUQxWXpUeWxjTVBtZ2RSM2JOdTNaS2Noakc5SjVBWG5YK1NG?=
 =?utf-8?B?SldiWE9BM2UxakU2K1ZWaVFLZ3BnWXVEVzhTeVN5S2tlcldpckQxUEdzRXBV?=
 =?utf-8?B?SFl3RVMwQWhIeGJnQU1EUFkzUDlLRXZlWEZuWlJoMzc0b1FpK0tMVWhscXhs?=
 =?utf-8?B?bWxndldTMGRKVXdwM0Vsay9XVmY4K1M4MzlZenFnN2diZFJDbXd6OFZrTXlX?=
 =?utf-8?B?UjgxakhtZ3pwZDZEQkRGaHcyNnBITVl3TU9tQXRINUp6TEE2WHYzUmVJVEZs?=
 =?utf-8?Q?fP5UYI?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 19:33:48.4691
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb12b67f-1b59-4e41-dfd6-08dddb697ddb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8453

On Thu, Aug 14, 2025 at 07:22:15PM +0530, Pranjal Shrivastava wrote:
> On Thu, Aug 14, 2025 at 7:04 PM Pranjal Shrivastava <praan@google.com> wrote:
> > I assume we'd need something like the following (untested) for this:
> >
> > --- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> > @@ -303,8 +303,8 @@
> >
> >         for (i = 0; i < LVCMDQ_ERR_MAP_NUM_64; i++)
> >                 vevent_data.lvcmdq_err_map[i] =
> > -                       readq_relaxed(REG_VINTF(vintf, LVCMDQ_ERR_MAP_64(i)));
> > +                       cpu_to_le64(readq_relaxed(REG_VINTF(vintf, LVCMDQ_ERR_MAP_64(i))));
> >
> >         iommufd_viommu_report_event(viommu, IOMMU_VEVENTQ_TYPE_TEGRA241_CMDQV,
> >                                       &vevent_data, sizeof(vevent_data));
> >
> 
> Running `make C=2 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.o`
> seems to remove the warning, I haven't tested this on HW, though.
> LMK, if this needs to be sent as a separate patch?

I tested and sent a version with your Suggested-by.

Thanks
Nicolin

