Return-Path: <linux-kernel+bounces-816839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 423F6B578E6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E885C164A64
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D8D301489;
	Mon, 15 Sep 2025 11:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ls8iSwrA"
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010000.outbound.protection.outlook.com [52.101.85.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150542FE07E;
	Mon, 15 Sep 2025 11:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757936838; cv=fail; b=OfmjqJqWWApXoptO/xFAKPXAaOjMaOY/E6Hd+hxZhcPPgS+BN4ek1Ns4EswXRnF322fgSJdeWr8q5FNxtt1hINm7mOcEg99AlgI+I38cnxpgKuiVI4Rm1QzhtqelUcMs7Ej8B20+H5XN0qhrUhUACQZDr0irqHPcbeE8NPz823o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757936838; c=relaxed/simple;
	bh=L2AsPQWRklrYld4/0JVBBxRvfbdCCs3keRo9ye+4JXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WxG6KJvNErU+cDZvEvR2vC02xfcwU221HtNl+7s28n9K4OLNI6OzpSt/F/ok52xuRhzWSMACYOxw3kDHuLrajeah16OG2p9guySbyPM0d6/k24X95wPdQQTwtxBaknKqZ9q9ML7FqaeUo25KYU2yfBjFsgdLLXse+cBaYsBau5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ls8iSwrA; arc=fail smtp.client-ip=52.101.85.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=URN7+y2kuUhg/OLlMubMrAxLwgpfmHEMvwRcf5UlUseL2220CcRVS6Alm+SBfO+Z8mIpchvH30z/9EEI2Cj9i/I0qh+E7H5i1KKWAqabrvKNbRmEw375oESj0r/pDOGM2oGcCVxGPKN768KPWoQ2yLy4oLNHNKWgKBIE4pfAzVecXyhUBqNgbcG8w2NCC/lyhi6BVHXN4ts1kG0QrYfA+1bBabH9TKpjNW/xChiGVux8iPHIRRb3frMMAVSNziK/XwctNUNNXWgKuHxOFVOGcsyGcw1xrqW28mamOfjKRzdFLZ7mGtEYjK6bKk8NRd3r7xcLa6PvE7KB5PMZayeTKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MQL2enNrilG5Klwx19AbsAsgsuKKC9g23G2o+HDUSm0=;
 b=ZqGa8J51qopkUhLG1y1HIm59q6/GF2i2XM6zqLDPDqX8Uf+8l7JEnT7moSjR/jjUmvFGtXcrWOf+OXFyvBwKn9w2LhjnyGeaZ3tffVH2zsV+rAle/k6puiKtB6i/j+AcaB0kJy63DMzyt2xb1F9hUip/F5XtwLxdiREli2XI4+/Ab4ZSnbr59NEObF3hEK+UAWeLSo+fY4x/T3s6hMlTU4R07SXArsGqaw7oAf3fTBek+PWEmIFvQV6zf4nwIjCaxSwhOisfY9CMNFXxcC9ADTspGWuCNRMG0RJW8eP4SiNvYLzXED4toTwffhd8QioYSC9Ih3+wXhipUpy9dc0sAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQL2enNrilG5Klwx19AbsAsgsuKKC9g23G2o+HDUSm0=;
 b=Ls8iSwrAICxUh3ZGsRrGYcvdizlRBjTfhgfh5lrsj7Al+Vdbf+DNQJI6QskFaPVSWtILJYaEDN89WrjTKuPFM11bkQruZKoP5zs12+Bu5V+WVLIztLGFTdYIZFzmkERDiF1jr4uMew/5dskf5xAwQ6LPIy5DJO2nn+6dUGuQ+dtqdunLnqjpeeclOqj+UrD6BsNgzuHNpdxLqZMRzD+YYB2R/6gC3fwGvGQcghzO5gxi7PHFLS0A/UqOqDwHYdE4chfq6Su/t4BZhAls3A/0VgR6yegm3nWuHjIal8StGUWu9Xv1bLVWkwH6AnsIkL18Mn+MunueU3Nmco+WrjMgJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Mon, 15 Sep
 2025 11:47:09 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 11:47:09 +0000
Date: Mon, 15 Sep 2025 08:47:07 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Andrey Ryabinin <arbn@yandex-team.com>
Cc: linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>, James Gowans <jgowans@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org, Pratyush Yadav <ptyadav@amazon.de>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Rientjes <rientjes@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Chris Li <chrisl@kernel.org>, Ashish.Kalra@amd.com,
	William Tu <witu@nvidia.com>, David Matlack <dmatlack@google.com>
Subject: Re: [PATCH v3 6/7] mm/memblock: Use KSTATE instead of kho to
 preserve preserved_mem_table
Message-ID: <20250915114707.GB1024672@nvidia.com>
References: <20250909201446.13138-1-arbn@yandex-team.com>
 <20250909201446.13138-7-arbn@yandex-team.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909201446.13138-7-arbn@yandex-team.com>
X-ClientProxiedBy: YT3PR01CA0128.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::6) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|DS7PR12MB6005:EE_
X-MS-Office365-Filtering-Correlation-Id: cfea70a8-0fea-4dfd-1c13-08ddf44d9a02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ya7ru0aU4mx4eNJfhYHQaXo0YhFl/wDFmoA7Hv+DC2lm/QLbykiv99UJwS3C?=
 =?us-ascii?Q?9xlCsALTNpIFfvOGlhveW7CoMeqycBnVD4ShpC9VY0O4d/7ttPUQAqjZkQnW?=
 =?us-ascii?Q?6hZkU5PFpwp+vDJAd8M+vmtMFeZ9ylvp9wz526thiQROI2Wl+w5pdL9I/i2o?=
 =?us-ascii?Q?mPxGe0F4ABxOddx5LXRtu/7o6LGCquW3hPxQxyrEXzdf4Wpg0NqhgeM4SXEe?=
 =?us-ascii?Q?+T3f3+xJnt0AIVR2Jnk1PRSp2eiBaFi50eEx6MU2f1FA2F/l/jXd5yXgy3xg?=
 =?us-ascii?Q?lOwls2WK14HQ4QAee3kACXyc5FruEKx8cyMsNrpt4P+DtauV7FP3hrfldIgd?=
 =?us-ascii?Q?vFxKQQWTyGbqYBCmeAuStYLS/+mo01s0UE9m0J/5qIOA28cqojZVo9AhWF/V?=
 =?us-ascii?Q?A25rtTcqXrajnnx8enLmCj4MfapgDZYHsjXqUi2/rwnGWj1zmnxdI28S4PyD?=
 =?us-ascii?Q?kYBggthmfntuUzSXg6gfDsosQJzi7YmQhNd+6C6ppmp4thY506pavlg2xptx?=
 =?us-ascii?Q?I0Sav6QJNmjZK+ybrTfooDiX8dPmAExVZJifwES4wnMIBc2Qxjy/kAeYF3y4?=
 =?us-ascii?Q?+v1f9xfmQqLGwxXQ1sEb1OSqBIzRuNu5TObTppF8t8AEXQyEDQ4Nt1QP/wAS?=
 =?us-ascii?Q?gVRc5iujopKZx7JxUlDuDPE6nZbs7AK0e86W/0/D1TWitCxoUX5K86pxB+gn?=
 =?us-ascii?Q?uvaC+aueQahjOzbSWN3zEe7sIMelIlIhmNHjm5zZgv85q3RQ0mL+7KTFadX7?=
 =?us-ascii?Q?klc3qLAX20nrzNRrRCAze8iDnsoDbJtxNkKmLPjftv3LnyLbYTZPcXXQg6gt?=
 =?us-ascii?Q?zCr2mn3hUBFFcmFRwJPKrHSQfoXawe3t3YzMKQ5gl25NRiX1peUTid2mhntp?=
 =?us-ascii?Q?7N17bZRHSmagBzeyj6bakQI/RWIJsr/9of33rRcDMIaD5htFzruyRM5Tkj2m?=
 =?us-ascii?Q?eKQwj/bR2hwYletFtkxHx0LhLl2qwBtxsu/u5mkVHooDMJfPkrodmX6nttL2?=
 =?us-ascii?Q?6PWAYHzviRguUyOI7L7vttMmjq7MmnJCXt4UssFul8bF1GWE0Fjk2zref+T0?=
 =?us-ascii?Q?ZKweh+HfYtpJcjezoigtqfqgL/k9frkRrElNWHo7mkdwq9+GfPLlB7hWmB73?=
 =?us-ascii?Q?DkTIPojb6Mk/FMbgyTxFD6GsnT+/AFoUH0RmrH5DWjoW0TwczQGvjcF3ax0x?=
 =?us-ascii?Q?B9OFkMs9/bRdiPxKLnFiZLHyAHvz0KT1h4Xd1uyzrjKYiRvPsw8oTuFLS7J0?=
 =?us-ascii?Q?XQViyrKPZPLbRORgNMubYsc1nOOt/r82lh5iETg3abN9MtRuS8+FjdP+vTlS?=
 =?us-ascii?Q?+XMPB7yVkUR2rPIE2q6O4QECO0cndwteUmB6Ra6NBK9fe7/JGw30RrDbT3lq?=
 =?us-ascii?Q?YnBR7FeVzoSfF/bspxj57W3btrDxTSwcz4VPcBLYJw319cclmLybfEnFdW9p?=
 =?us-ascii?Q?LApnz2oJg6c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aXY8unhMel7EQoJtgLD3hRff8zILwNhWsKOW0S1i7U0Ee3NXzt6po4X1Mkh5?=
 =?us-ascii?Q?+z3BABjReF0X6B2Jh94VQDVeTbeZsjCBpPK1BNgIDRGa5gV/NTD3VuYOa0wj?=
 =?us-ascii?Q?e1uugRVh8Jndc5TP4KMSMDl6zI+j7ztg/hQwTG2GM2wQSpoUVrTGGhAprQqX?=
 =?us-ascii?Q?wxrWaC59Xx7U3KIWf6P7Wiqv84g1tgX+b2zuEXH+FpuhepEM0f+MPQA4ZT2w?=
 =?us-ascii?Q?lsS0BykKPWCdqhhbBJg8whVtNXM9hrJYTSKVxYd3Hw4qAfKrRNCqLSHZm/Hy?=
 =?us-ascii?Q?fkLfTwtFC1otTprZthLxpOI16st4j7nLSyPFQ+XTTc7Fz03l+PbRnz7noB5E?=
 =?us-ascii?Q?Wd96M+91JCiBgGXpKz5mwuQSdcO3n9VeZbK8JmxKC79YTosJ+svJtQpMQccJ?=
 =?us-ascii?Q?ZaTbF2RtSTizzhZpijXMIXXJ1b4O1aOJbbp01F+gqDReLMQF5oU3odF0vVbp?=
 =?us-ascii?Q?ZAzJ43+Ppxhudgjw9voygCYY0mskex05uTOiPp4BkMmmDQl31+oOsfMVlHeu?=
 =?us-ascii?Q?qzBgustLJ4OPxlAoy46HxOL184bS3OUbqRuoyeaFuyGCl9d8AYREDf6PvBHH?=
 =?us-ascii?Q?VRccXxF7J3WT6STNDZkFs16ukCGHZSl41XxRiQTf3n3Mut03PLZY9Qy1fMBF?=
 =?us-ascii?Q?I3bJ3C4tgZ8NhRjPljm90pWoa2EKz3+bypqAmP9cu8/2Ywp7lOoJHhbPrNxo?=
 =?us-ascii?Q?aJpvbTuMgnnSLtu68IZMc06KuJ5dqww0Q0/U6C7Zays0lV3g9mkAZxLhBel0?=
 =?us-ascii?Q?UwaetZoNboXLZX6+A8bFhNwl6eeyM+22H3BfZNHMCaPxRIvgrxMJu3WMPM0m?=
 =?us-ascii?Q?KTxVzm2ddzZj1cEy9ZuAbM9Q3u02uJT/DsRfa1lpy4Xu5qQdwUuexR8HXLXS?=
 =?us-ascii?Q?ToohPkoCdObNn5t0gXPBWC2snpY5Gdz4hw56SdZBifmnf8dajPL8GgxQZtza?=
 =?us-ascii?Q?w/CGJFECA9cVRM0fB2Phgwdh28fIlSqi0w0kBjJQekl1fjJUKfcWIgEVa2Im?=
 =?us-ascii?Q?kI9RpgKOJmGzV1h0rUtabOHsCcWIrhGumegyiwmnEoQm1AVVSiQL1cdtpglU?=
 =?us-ascii?Q?bLqa8/uOaf0vQRboIagYYSZ8aSoN1ioeb6MiFVeAROKscblq6OZpQ7vWVQfH?=
 =?us-ascii?Q?HOvh/3LkF2QRBHvQvkhFNWMlCL2VaFwdhvBiYas3I8/ND6+fFoc1sDgILBIx?=
 =?us-ascii?Q?uldudJ+Nt/egk3ni01KxWspUHEloeyap/QFKDDOi3lLJS633rPaBi6wEyger?=
 =?us-ascii?Q?wCc3LLshu6wZFhdZPJO2uHBDavFcbnY4jeTO18DPPiq83sjeWHvK2y9DXcXG?=
 =?us-ascii?Q?HW47Us8QltmmBZ2ZBLR0H6AoLJr8d7JagFqeXFj0VVIxMZAPQ+lLZ5jUCa6h?=
 =?us-ascii?Q?2qux5ckXe9IvU39ekEOCnoXsd/AqjlbEj2TeRWIjBgLqHkxSazmhDravis6j?=
 =?us-ascii?Q?M9+Aschj4BzXTBYZr2ZXDp0hrvzLOC8Z6JdD5iltFIbQnTCvHkHeNBVvNHxk?=
 =?us-ascii?Q?5bGvQUbrBDZbeHFjQ36RFJQE8AZL8vcBg0XaQBjPhQG+7uujXV2lHeKKRMyK?=
 =?us-ascii?Q?DY1OUxNaPct31pPck8k=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfea70a8-0fea-4dfd-1c13-08ddf44d9a02
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 11:47:09.1808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IPZ+9P+zCHeBskwdwSaqaQOqZn4BbmpyCLnF9kIwC98C390qV6bnTCMvGcOE29a2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6005

On Tue, Sep 09, 2025 at 10:14:41PM +0200, Andrey Ryabinin wrote:
> +static int kstate_preserve_phys(struct kstate_stream *stream, void *obj,
> +				const struct kstate_field *field)
> +{
> +	struct reserve_mem_table *map = obj;
> +
> +	return kho_preserve_phys(map->start, map->size);
> +}
> +
> +struct kstate_description kstate_reserve_mem = {
> +	.name = "reserved_mem",
> +	.id = KSTATE_RESERVED_MEM_ID,
> +	.fields = (const struct kstate_field[]) {
> +		KSTATE_BASE_TYPE(name, struct reserve_mem_table,
> +				char[RESERVE_MEM_NAME_SIZE]),
> +		KSTATE_BASE_TYPE(start, struct reserve_mem_table, phys_addr_t),
> +		KSTATE_BASE_TYPE(size, struct reserve_mem_table, phys_addr_t),
> +		{
> +			.name = "phys_range",
> +			.flags = KS_CUSTOM,
> +			.save = kstate_preserve_phys,
> +		},
> +		KSTATE_END_OF_LIST(),
> +	},
> +};
>  
>  static int __init reserve_mem_init(void)
>  {
>  	int err;
> +	int i;
>  
>  	if (!kho_is_enabled() || !reserved_mem_count)
>  		return 0;
>  
> +	for (i = 0; i < reserved_mem_count; i++) {
> +		struct reserve_mem_table *map = &reserved_mem_table[i];
>  
> +		err = kstate_register(&kstate_reserve_mem,
> +				map, crc32(~0, map->name, RESERVE_MEM_NAME_SIZE));
> +		if (err)
> +			goto out;
>  	}

As I've said to the other proposals, this doesn't seem to be bringing
that much value compared to just using a normal struct:

	for (i = 0; i < reserved_mem_count; i++) {
		struct reserve_mem_table *map = &reserved_mem_table[i];
		struct khoser_reserve_mem_table abi_map = {.name = map->name. .start = map->start, .size = map->size};

		err = kho_preserve_phys(map->start, map->size);
		if (err)
		    return err; // Should unwind the other preservations!
		
		luo_preserve_key(luo_obj, map->name, &abi_map, sizeof(abi_map), VERSION_0);
 	}

Jason

