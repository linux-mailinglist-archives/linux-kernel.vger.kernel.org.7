Return-Path: <linux-kernel+bounces-689290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 115C4ADBEF9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 04:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A483E17158E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 02:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A5922CBD3;
	Tue, 17 Jun 2025 02:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MmjUV3iG"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2058.outbound.protection.outlook.com [40.107.102.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD021F3BAB
	for <linux-kernel@vger.kernel.org>; Tue, 17 Jun 2025 02:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750126566; cv=fail; b=Ee6obTkA+tOAKYi19qpWkLOQjf02ayz4X2OGsIuy4Z0GMV7bx8KHXzLbgRBcYly5yWegsOT9k8XSPp8zK9O/FOcqlSR0krVUINLXnehvz9QemlkjExcjdyOnj73g99Dsn3vJimBmoOVyIUnsPZNhz0r+jWM0eS5kquH8An8TIlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750126566; c=relaxed/simple;
	bh=9xwnm4DhvgkujEUCiep3HfPUBB6QFAWBolziOnlvVkw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PWSVRM8WLT8QRCKf2zaaSZ0HydAbwDGNsMRhVyFw3WMLLj+1bSfa4ip2Zv6JLgcnTIHY4KFerZWdyKiCRvWOfNuXJ78gYmUvGq86aQC/XS7IUkwuNPN3PSQ2V1aaFMYu9T0tVWlZAPSFhztIM80bEDOsu1VP2wRTlMCzC+i6YIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MmjUV3iG; arc=fail smtp.client-ip=40.107.102.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pM58qkk7zm/CGHzHu36sDBu4MAx0RE5YlBOhOhy4nG+FjLqTRLTE5/waREBuVtx2BDYeKAScneZvLMNtGTD2mymbQracPfbudr+xXY1i2kklvvJp1Xpzr2MR3aFJN2VqRO6Imuc09qiGP1S/QuTG0eFZSewN4moOgzUBWNTlGSbB8qnq/Cd+tptPlQ3fhaN9xqZ29h+nhVdddpt1v4XpJI9nzhut+aZ1U/CvQ9tewYfD6QdHkipEsc1fbVIxvgdMY6rhfbZh9dKbbN7tE6nRPhpRv8jfrHbCg6JZVlq8FImWQeDYg7d06RN7dr7fY10nrncWWExwZjK6hPYEIJ4NcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W5yIfLSijiWS1Q4Zm5fqH2pHiM0m5pekBQ4ekNfBQdU=;
 b=sW6I+RkVHVa+6I0c0Ud8pgToQi4Lb8N7Pn6Oet4aStHJsY/4VfzhViX4CCJ8Gft84pMKuSV5B6QWTzmkoCAcG5COkv71e5f43vBgasULOys0KDU6FUXYgxy00VyL2FI01/sIo1KYaUHkGVhjklvy/Va3sfD9Obxky9/IFw3EibZPDw4IRMizf1Dgi7EkISXtf5ifFJs1NUyRHiSYLwkBiaSC8UM02HJKnrrLWgI0/TXskeSS02pDB+5N1Y6f9QC5CYfI+buE8lKoaksiuMbjWmBRIijGlAmVkj17ssvP3ytgEMQl1JHjplkBG83hnf8qjoGvFHbVvLkKFrdkkO5T6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5yIfLSijiWS1Q4Zm5fqH2pHiM0m5pekBQ4ekNfBQdU=;
 b=MmjUV3iGhVfYTGN7nWiJ+t9wo3/t71/x1Zjpxw8W1dz9YNdtT/fdpMWN21xTjb1XHlxFJoGxeMNDyJ9HK8+bMWFCQ6tHUhpq8wf6rJro895ICRjlevGePsXZkhWO+ZeEB7b+b+C39URL7js3VCFqcR/nHzjNv5EJgq+G2veZ2bDHvVI01zxh1csHbMHACQCnEC8SqQOao4b6ALuZtS9qsZqZzVtC1+UknPIq1Pirfe/v94B9Jlcla3yl3H3mtoV5aGCAZPzsjXm0tJ+GPw4ONM4g2bH7SVpMg4rvTW4xfrtBXxX8yiJTpT8PERh20wcm/G5vigo2bC3s+Iy34hzqZg==
Received: from PH7P223CA0025.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:338::33)
 by IA1PR12MB6626.namprd12.prod.outlook.com (2603:10b6:208:3a2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Tue, 17 Jun
 2025 02:15:59 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:510:338:cafe::5f) by PH7P223CA0025.outlook.office365.com
 (2603:10b6:510:338::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.19 via Frontend Transport; Tue,
 17 Jun 2025 02:15:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Tue, 17 Jun 2025 02:15:58 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Jun
 2025 19:15:39 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 16 Jun 2025 19:15:38 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 16 Jun 2025 19:15:26 -0700
Date: Mon, 16 Jun 2025 19:15:19 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <joro@8bytes.org>, <yi.l.liu@intel.com>,
	<peterz@infradead.org>, <jsnitsel@redhat.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <patches@lists.linux.dev>,
	<baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2 10/14] iommu/arm-smmu-v3: Replace arm_vsmmu_alloc with
 arm_vsmmu_init
Message-ID: <aFDPtzY3EygoOpUx@nvidia.com>
References: <cover.1749882255.git.nicolinc@nvidia.com>
 <64e4b4c33acd26e1bd676e077be80e00fb63f17c.1749882255.git.nicolinc@nvidia.com>
 <aFCeCvKkm1MvT3xP@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aFCeCvKkm1MvT3xP@google.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|IA1PR12MB6626:EE_
X-MS-Office365-Filtering-Correlation-Id: bb14d5e1-e4c7-44a3-dfb2-08ddad44e60a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iTHSEZc/eD4pADwpJPD/SOtLD5RtIwRgzx6H51fjJX+K4XjSajjJjX+tynYb?=
 =?us-ascii?Q?itqsyjprCc3TBJjbEwWZJg3LgIOTf4aRg9lOkIH/kcl/wqroUDg5VuoU3Ba/?=
 =?us-ascii?Q?fqOgqd0GpK8sRUeJNClI4JFVkcx2yb8j4UlQfTSNdHnvgAzIsj7E9Ftpo7qK?=
 =?us-ascii?Q?WkSIkEFMxMnVUI7kAMTgxkRjWlVqnyLWU/pcN/UwduczWwTAXmUhjP1s/iQX?=
 =?us-ascii?Q?2OI5ChOxDWtARSDz49xWEH2ge5OZMtDArKWY/Ot2M7C2POQgzVufn1k5RsuV?=
 =?us-ascii?Q?KW5/2LlA/Rx2IqyMmUivhDnKg6wWL3BmuYedCFNlFuhJXUtQ5xjUEywf3EKC?=
 =?us-ascii?Q?seJC+7wWihmu/8LZzLp3wMXKeHS1yvPAzVY6iPDL3CduXTmnISTs5AJ5pONP?=
 =?us-ascii?Q?ZgFZ4vX3CmPBwlYuqohSj07A7WR7qc9LIpZ3hbPxMSqnYNPV9Anze0aqlQ3e?=
 =?us-ascii?Q?x7h2okGVLKtu/nJxknaeTMcLkLhYbvDEqWf1KE/4uDu384oeHVUPpM+PCxYq?=
 =?us-ascii?Q?E1YNclqGLJIhfRC08+xHBoOW9dKS4aYz8aggIcFAlgiuERfgnlbigKhG0BIM?=
 =?us-ascii?Q?ojiv2umD/BAU/TnLlPyr4n52JkD8O07QcrJko8zebPIiqaL4CFXeQJ32SXWL?=
 =?us-ascii?Q?XCepIA5rUzLy0HdILjtwS04zh7Qyjl2/bn+VKYmiB14Asyl7mxanHjryijmr?=
 =?us-ascii?Q?2hMF1dJ6EXgNBrcTqHVgLyRj3y+IwshhCL9v2VA0noq5yHXyytZB4TZfLCBL?=
 =?us-ascii?Q?3m51Xq6vD1zzu96qD5UYZeE+5zs9JTXmR6Rk3FnqK9s8Qvu/P16X8ZqnTMfE?=
 =?us-ascii?Q?rCiLcJNg6wR0TlJ2uJIjbhvNoptV071AAK5W8YFZy3kRabyk3z5uomjUL+KS?=
 =?us-ascii?Q?fsSrYOc+s4niDB5GfHtBPh+uwxvK+Ziza4c0QhqWwkH6Tx/waOSKWZHX5ejn?=
 =?us-ascii?Q?D9QzXv/029+ECkARuMAXXz3ZZIDIDlvfziFtSNDQOFTh/UwHsj2h9pgbFG5s?=
 =?us-ascii?Q?Wo+4RxrdviCfGWjiF2S1DMivMn15I3t6BgxmbmqP5YICA9dYkAW/tfkRMpw4?=
 =?us-ascii?Q?xE0VGTkrA4OWQEEJdf9MutAwXqu179S+RH3SRKu8LZpC4/ZcDreVX1zp/TJP?=
 =?us-ascii?Q?2fSdR6i74D/OtLv1EleIyOJKB02fNTftknsYIB2fs4npaEh0UaLAP+aH791k?=
 =?us-ascii?Q?Hid/E5nlBjHsyHlX0I0Wv/2D8caJwFomnyK4CZQFfjUYv9Kb40F2yx/AG98Y?=
 =?us-ascii?Q?6zwBwLxmN5PbXaJDN6RCombev4IoerGd7KVnFC6gkt4BbSMxYn8FSCYOPHwb?=
 =?us-ascii?Q?KVbxoKVu6kPFyzBumfTY7TbI32Ed8T7/hz3jpJrHjyq+emzFt4/mZvaCqKbA?=
 =?us-ascii?Q?SZ5X4mAdTTNT1gZhmjftKiOjrO6lvG6NKAotfW+hW15ru/AtlyY4OxKlTM4q?=
 =?us-ascii?Q?dM4xFH+wOj9azcHRmoY64gnWw/2qYwA01tOlx12Sb/Rzp9A0ysD1Ibu/l04v?=
 =?us-ascii?Q?OFdnjtOQbQGttYMdDlnd0Jxvq4b1lkGROKJd?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 02:15:58.4015
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb14d5e1-e4c7-44a3-dfb2-08ddad44e60a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6626

On Mon, Jun 16, 2025 at 10:43:22PM +0000, Pranjal Shrivastava wrote:
> On Fri, Jun 13, 2025 at 11:35:22PM -0700, Nicolin Chen wrote:
> > To ease the for-driver iommufd APIs, get_viommu_size and viommu_init ops
> > are introduced.
> > 
> > Sanitize the inputs and report the size of struct arm_vsmmu on success, in
> > arm_smmu_get_viommu_size().
> > 
> > Place the type sanity at the last, becase there will be soon an impl level
> > get_viommu_size op, which will require the same sanity tests prior. It can
> > simply insert a piece of code in front of the IOMMU_VIOMMU_TYPE_ARM_SMMUV3
> > sanity.
> > 
> 
> That's what I was wondering, so we plan to replace the impl->vsmmu_alloc
> op as well?

There is no such op in v6.16-rc1.

> > -	return &vsmmu->core;
> > +	viommu->ops = &arm_vsmmu_ops;
> > +	return 0;
> >  }
> 
> Seems much better now that the driver doesn't need to callback to the
> core for allocating viommu. One quick question though I see we've 
> removed the following too:
> 
>         if (master->smmu->impl_ops &&master->smmu->impl_ops->vsmmu_alloc)
> 	                vsmmu = master->smmu->impl_ops->vsmmu_alloc(
> 			                        master->smmu, s2_parent,
> 						ictx, viommu_type,
> 						user_data);
> 
> Not sure why don't I see that in the diffs.. do we plan to split this
> into an impl-specific size and init too?

Because there is no vsmmu_alloc in v6.16-rc1. I guess you are
referring to older versions of HW queue (vCMDQ) series that
was not merged?

Thanks
Nicolin

