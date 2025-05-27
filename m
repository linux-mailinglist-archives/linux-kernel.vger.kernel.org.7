Return-Path: <linux-kernel+bounces-663235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E49AC4598
	for <lists+linux-kernel@lfdr.de>; Tue, 27 May 2025 01:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0AA23BC07F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 May 2025 23:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D5A1F55FA;
	Mon, 26 May 2025 23:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iJaKBgdk"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D6E1A8401
	for <linux-kernel@vger.kernel.org>; Mon, 26 May 2025 23:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748303548; cv=fail; b=dICVVQz4duExi0M29F0c23WhOktF+sulJsXfm9s/R5Jqe8HDvEmMATerx8dFF+Z6NDEZM9l4AtGDZmNoH61qnaKiJBgTDN+QUBVpIPXhrgEOz8xGGtXPY4iZtSCfJF0ha/TE5/X9TtjZLSVgCUXibFeSupwrs+FhI/lxp67RkIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748303548; c=relaxed/simple;
	bh=5QbEjIcDiUiI4oNwzE2AnJt+eIb6ES323fgq9CGa/zA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Nm0WfNGzBLIHbswuHbwJLt4HiLELhBNS1puUS27rRfVtYSwgEg7Z7RlaaDCDR+xGsiZRhSzzhorV8aJgeRV+1wxsIwOJFCF//2aA9t3xYnAKnpOGHO3KXgURmX/jGNrKHq9Ri1EO9/oIa2Jp2tz6AHpnYibjxGysFzj+dGJaaOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iJaKBgdk; arc=fail smtp.client-ip=40.107.92.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EnR6cUqRaBmmhTihIpcqNT4jKhf9qqhWdYzKjpWnMh1WgURioyTFbHsPG1qICUavw06OKRPjq6yMQ7k4tH1sUI/sP6zPN4cuL0gG4brffrVVf3jtJxn89Xz7DMYc9/esJwby/T4dYcI57r2Pz5TQqVZrZcvwNDDpEPK6ZREuH7ijx5/wWRSWTJc18ia3IJb/1Tc1VL279aoLCSWIzhcPckxIklHf3BR4MXlQG0gNZdVq4JblEL5AwsplOTAxv1GjkMYtoNIYkX1D4m6HAaInq2kCmcLIotW7H1zUuZhX8Q7odhNS5DIKh/0/FnJHOSB4ZnboyQ8xI86HvANCR//nXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k2n4m5z2+Qa8vYenE3eQZUj5xwI8yE7mHJ2k3nOhgtA=;
 b=GMh2IJnF/jf5Xe4c2GT8E83p2ENRPR71FL9PB2S6iO/Fzk3WKuYybvmHYlti/+9CF6MRqT4R4iG+6DFOZqhQ7TEtu0qTh/YFDx1tjRqlOMq4IkJJlvIVDiRuMu5kzgCB4qXV7OxwIs4PwZqhA486C/4dOG9/ekt4Nnk/jBDXY+oHeAKARiGiHtU+BTZMGLCIPwE25V7fsG8fEIdepRLSLoh+2X/601HgTpHjTyn+sVvsdWaAylK5gx3HHVYFS3NJzM0cdgdkjxnp8JnQXHAatACoWEf7iC5rwA35Zn9dIA+RvM+HPE7BNiAFcUw057lTywhMAqkLSjmsPG7Wvf2GrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k2n4m5z2+Qa8vYenE3eQZUj5xwI8yE7mHJ2k3nOhgtA=;
 b=iJaKBgdk0P+fQfm9QDC+V5oGC9zi4zjDZ+uJd0rOSGw+DUbfFf2XVgp5cCjAQB1340TCqvskoicJub/l6am/ovNq2TCqXlf/+zEWWFstkDVStCWn2zW2cVPw97PjPdTnCv+jnzmqlbor686jrDILPBWfKRWkqSQ7HSkpcvRcWAPtVVwks7cybJPBmG2Pji1csIt83I4DqPcazIMgK1RK79uT7eOiiZRDDyOFo6jiUJFhvXh+2uus6Dw53O9FpG/B//nQhZeDI3+oAjNi43DQ+F3QsKYUZ1jm2y4FdDrVdCs7fxg5JGJpsIT25hu91oUVc+EwZWM/hhz3RIosPC7LCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SN7PR12MB7978.namprd12.prod.outlook.com (2603:10b6:806:34b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Mon, 26 May
 2025 23:52:23 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8769.022; Mon, 26 May 2025
 23:52:23 +0000
Date: Mon, 26 May 2025 20:52:22 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Alex Williamson <alex.williamson@redhat.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>, Zhang Yu <zhangyu1@microsoft.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>
Subject: Re: [PATCH 1/2] vfio: Fix unbalanced vfio_df_close call in no-iommu
 mode
Message-ID: <20250526235222.GI61950@nvidia.com>
References: <20250516164522.51905-1-jacob.pan@linux.microsoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516164522.51905-1-jacob.pan@linux.microsoft.com>
X-ClientProxiedBy: BL1PR13CA0397.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::12) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SN7PR12MB7978:EE_
X-MS-Office365-Filtering-Correlation-Id: e919cad0-5f65-4e53-60fe-08dd9cb05c1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eZfaZ+cIMqfIV+zk95hIzDl8vjID0XRb8K/baBaIXGYj3C1kNLSXcowfes9p?=
 =?us-ascii?Q?RAyEuOaynFHTG93I9+6N07/c7YOuYQ4XifDUpK4TnE66wsLOww0U2Dr6bFQZ?=
 =?us-ascii?Q?DiIq7wt/K5n0P+oOwWtq5w6FkSJicHp7cQylT94ICmURSEVDcxTnV5s/lJgt?=
 =?us-ascii?Q?CES4mmicejntVWyIITx7SYV2hOaU2DmNkZT4hS9fPBhhcgonHT3IYW6I7fo7?=
 =?us-ascii?Q?5jl31xmFyL1LZYbR2t/8vgSI0Uu3veSnax4W7aZMJxYO+3ZBixCcD4c1g5NN?=
 =?us-ascii?Q?vfrRp5GGn3fHBQPxjdhVoj7YVQV1d63QPrXlCN+6WPQ6CqLyYhkmltEqeWiS?=
 =?us-ascii?Q?/BApGwuP9CLHTUx4ZZvODJ2v+51BQ0jNmUvrvJROadPu3ldWWAmT7w6N68lO?=
 =?us-ascii?Q?YAtE0iZmheqG+9VwdVP2ooT/iZsYOH9MxZR6+w1laqCBkYqURPcVA62OxxUt?=
 =?us-ascii?Q?z3I4Qs/4P7lcpDgPFw2JlqXWB7NxhLFZWzRekEWGPQ0TrX/f98SHx5zZImuk?=
 =?us-ascii?Q?IIMcsrEerfds4UGuU23xXlyJEZr6MRgzmANhLFEFK/I71CZJwzgETe91T+Vn?=
 =?us-ascii?Q?dyDIQnB+w7YWKlGWncPEBfaMf7ItUHczGFlNoVN/SgwpoPkLX4ELFrg1glKU?=
 =?us-ascii?Q?sBniFJc5bDV0v8ae61I79QDcWZ+rdoMEjVCWy2LuOdvB+L7+KecLKfBC/fFz?=
 =?us-ascii?Q?s6d3HG4vRYFyZnkdU17f8QXIwymk5Nr9G2Hcj7M3HI5MG/0+Gkzd0gphhY9s?=
 =?us-ascii?Q?SGQqB1mwlxbNO+7N/+o/8OgJeRHJSiutadYQQwHq3TYV0ln4c/pWtfXBPbfl?=
 =?us-ascii?Q?VLOPkYm2bSKNZcuilYfBUrAi3XhsZI+vmNi6JLUrmlvlQ7QT5vj+q+8D7vca?=
 =?us-ascii?Q?4hAE2bFn9eD6Zq9cto3omqNNREdumXnBAmxujFQ12hmhkvEkWichEScu7fL/?=
 =?us-ascii?Q?3SKIzhqgXzFvXq52xQCmqyJZNHQQDU/nbZZaT2TIXQHELIvsbTsqlpQPsmlR?=
 =?us-ascii?Q?PLF04wJ5oTbyGPc541vfTnfIGIi9g1qXlvyZ0l0C5F6DgpOfWD/HyRWyOIZT?=
 =?us-ascii?Q?Reu8V52gZC6CFO2UOuJRM7w5wI9Hs8CO8N2qzCu74NQaeITcxRq8duM5G9N6?=
 =?us-ascii?Q?o755lZzWpc1gFWrvZ5tYy7pkUdmLjiZmO1raWm1yDEY+wGTI/jakWM3nWQvO?=
 =?us-ascii?Q?W9CRr8jXx3HjrpXdErAqf0a3WTeby+LiKGu2K89yLXUlIS7t9jJe65nOTNpF?=
 =?us-ascii?Q?7JMaHPPZru4jrKKYNw4IJAelibMzrRpLmdBvZJpulfdfCPXLfoPqUS5F+Wpa?=
 =?us-ascii?Q?+6hOzCsR3S9y7HfpS+MOcSuy+twgh++/BmtmFsPTQQdxctV/fWJ6kRxF3ZS4?=
 =?us-ascii?Q?csi0mmEpfMiAWw6LtUbvtF5DZ72sPOw5Ygp+T83VkQ2ozOiWhE1pupUqA9Ut?=
 =?us-ascii?Q?n0HpyCqn5Fw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B3tbaDsLK1tIP3WF47HcW+aAZ0UCqL9Hpy4w6yQkIrhWeq63kBErfCvQSx1v?=
 =?us-ascii?Q?9uAM6A/CpFhRbYcz2PkfnIxKV9Oekpirqu84Fke2EEgGGkJ6pJnZ5Jni983j?=
 =?us-ascii?Q?1JUsqqASgp/m5lyXciyQfpqe1rQxgtpTyoALG4b3HQSY0uUAeFugkfW4Y4nJ?=
 =?us-ascii?Q?nNuL8+q8rZBPEg9ZPj7RPYYNdvr7MNGSSBYp1O7NLQm6XcZ17aOXUu6mBtIy?=
 =?us-ascii?Q?N7ODaVZar8BooKSMLX9S3HJFVcL7cdP/ZxmPV/1h+L7fzdMZNDaHUKjbWMuR?=
 =?us-ascii?Q?6NzDzhZq+UWIYNsO+qXhCAXD9d33CTDWiTcsJ2np3bNURG673z68fS4Fq+82?=
 =?us-ascii?Q?ZaJgQX1CcBWEsh/oWLCEc0bZW7+yYGcYUIONFsOnsIKXCV0sSLLfy1Ce2YWb?=
 =?us-ascii?Q?oHdA1PBVwwbDbiYm5vxzqGxRNL5MCDf8EbZtod5UI5DV24L8sDtP4/XkGC1p?=
 =?us-ascii?Q?7c3sfWQQsODtbCPRBabUJ4YMQaPjiHLJVYalc44ipACjxoTZzkQw9rvEm5gq?=
 =?us-ascii?Q?B5/FNhkFOTieFWI+4VaPpDEe1TBNa61jPBlaFOZPtCiCXOLk7h1oGB1byePN?=
 =?us-ascii?Q?CEyrXR904XLv5L13oIExdBMMgKIXZgzadC+SBqgzpslQmasyEW2dR+cXBg8D?=
 =?us-ascii?Q?5BDE2nT/gvQnYdD1YkqyV4KaiXDwAVoqpf1K65HziiXCJYXPRyJhJEiAoSS8?=
 =?us-ascii?Q?JdrmSQh5/62Vq3FeJE8exryXJ3coEln+gYUkZ8+U9NYBnrTrjU+lWvfY1uff?=
 =?us-ascii?Q?MQ0CPGX3+cZpzj0RM+u8q/DzP6+wwSVOxPz8AMrHEEXrVhIADGDYwhvpjfr1?=
 =?us-ascii?Q?7K11Ov95sCz3E9jusjRqtH3RfzuDgrYKWzPgFNbt6CuEVF91FrUKqLRSEfsn?=
 =?us-ascii?Q?ynAtZzpy7pCluk7dgItBF1OAlMmco/3hpW8S/Uew4Nt2w9xQZrCPKV94mO1A?=
 =?us-ascii?Q?99KtoCXeRJBXTK1kP0njC9JC75HzRepnT5b6zkfk4mro1+f1+FCrrwjrbHRn?=
 =?us-ascii?Q?GV4Pt9Dj/+Em4RElOi1tgdO7BZ3JgTOM0UOzTGMnA19W+AQfAVLZ8tBhCk8K?=
 =?us-ascii?Q?G+MeBKxIFo59Uh3gY+Dhb8lJXGMmEpvxepVC7VH7Pf6LFG8HUdppGAJ+YyWE?=
 =?us-ascii?Q?83qONgCeypEypNWa8FYRmj3Fa3RvuFhLNraclsoHAEiBnAfQEbucloZhRTfP?=
 =?us-ascii?Q?v9ETxcvJy4Va2vV4WoNzYrsQMG7JE54pZYix2qXQ9IZOIqAlulV1OToC1xWp?=
 =?us-ascii?Q?PtIBe+oc1uWCBtmyrn+CdXwka0TEM2BybKDrJtAsYcB7N+0WircdrgO/0YpW?=
 =?us-ascii?Q?khIqBowFdf9CpE1LMhdLoHTtphGxq1D5//dw1jinBt88WGHA99SBCWbUCwVd?=
 =?us-ascii?Q?JDJZBX0YSQl9PrkIN362UU+QF3ddWThS7HP+VXOoLvPghTVEPTbu7VO8A3cT?=
 =?us-ascii?Q?QceV1odsZioi8aDndWwlJC8+/xniFP9F4kUnRKyepvb0sBVDPaKxpxSJontk?=
 =?us-ascii?Q?i0/69KMH5acZzo903Kfbjo7K8MdTTI7IIAx9FYhKBDAnBi0csCvadE1+aWnU?=
 =?us-ascii?Q?yenG6SHtHTVBwL5v/yEdTSq6abmaQN9KeXURNb5s?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e919cad0-5f65-4e53-60fe-08dd9cb05c1c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2025 23:52:23.2612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WSkYNdE38OrqrqxVF61gusy1J5xre/W/G4IMuByQAsvKKTUI3gIY5TZDXed2iseX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7978

On Fri, May 16, 2025 at 09:45:21AM -0700, Jacob Pan wrote:
> For no-iommu enabled devices working under IOMMUFD VFIO compat mode, the
> group open path does not call vfio_df_open() and the open_count is 0. So
> calling vfio_df_close() in the group close path will trigger warning in
> vfio_assert_device_open(device);
> 
> E.g. The following warning can be seen by running VFIO test.
> https://github.com/awilliam/tests/blob/master/vfio-noiommu-pci-device-open.c
> CONFIG_VFIO_CONTAINER = n
> [   29.094781] vfio-pci 0000:02:01.0: vfio-noiommu device opened by user (vfio-noiommu-pc:164)
> Failed to get device info
> [   29.096540] ------------[ cut here ]------------
> [   29.096616] WARNING: CPU: 1 PID: 164 at drivers/vfio/vfio_main.c:487 vfio_df_close+0xac/0xb4
> 
> This patch adds checks for no-iommu mode and open_count to skip calling vfio_df_close.
> 
> Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> ---
>  drivers/vfio/group.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

