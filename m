Return-Path: <linux-kernel+bounces-827296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EDEB915E1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 177F47B0EA3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 13:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92310283FE9;
	Mon, 22 Sep 2025 13:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pdrya4z+"
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012044.outbound.protection.outlook.com [40.107.209.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C22A2745E
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 13:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758547196; cv=fail; b=rumd4ZuguBE6fORwcItI7oC9ux/XgvHCdkv7Qnh1hYrKpJbDcOPTk7WoFy1+5X0a+cCmdWrnqiF71NMb9VCLaZ4cVWrmWmazE/tJdvvrWLtiel8S+jLKdOix26H8LqZS5pRF9K7yHSltExauQWN4F94RDAEX/uyaQF/apkhRfC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758547196; c=relaxed/simple;
	bh=HOLTgGIXG7/f7w9UjTc7ALAfQtHM/x0NbmMS9ATBvzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ARIgRSx/4lTBUQBA9Q95bbL5o6cdT5VruR2vVkp12y7Z5l5Hd0+epH9ar/LMkZY09HUEk2LG66GUvnZin+EYmt4KY+0+X97xy2Dba6+kwZobvRtCcValEfAoPkbKme9Q14BOaFCgL4zvfoCmwETdbBXt5QDZPYwSdouzLSNFnFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pdrya4z+; arc=fail smtp.client-ip=40.107.209.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=seMkrQkUZkt9eBHwi7tq100dp5HFGG08NgKcYUb2K9AgClCy/2ZOE9aMr7zxx0MnHP5GKqPb/AGe72E1A2ni+WUNnHN0otdt1atQNievReGYlZc4fJLfBoVawoxdQ7CdPZ5miHzyNekvBkIyvt2iE4FG8LKGU8ZWxb0cWY0d6N6m4PICBjoag/aFHagucCIZV7QYIiHmDTvAnRcTElX1dX2ixBljHEUXQ7odQIzWU7bdwVczPdoIBqYKdT50OU4tM7GezYoVNaZ0K/uy2Xs7/574P+q+1uP44+5V+S1ImkoKzq6b7NrOO/v+feujS9NfPv6IGzkfyvYEqtDJpuecNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E+Moc9BSunqJpw75iqcTAe8J1McxIT0EvavtWtrPnUc=;
 b=sZIKtdG9hkW2k4gFpXeu/Yhns11o4DJ0OndlXDvA9+pFpIjAmlU2iCitnatdh109UWjM+a8tWDVlaq6tW3zOpAjXZGWkoN4Vu9UPV+DDI8YYcBbQf+dY7pVB6kLWZvgZZkSuwuy7yXat8YfJukyhjkELvwZaAGBVSJDXgvkD9kINFglqOz3I0qQKb7Go4azOIrP1XM4RgMpYPQQaUuO+HwGDty9/pG9KKo7gtre514DJ2BadPGxIzLz5L0ZP+vyi7ugLhIg+az69wZJZrybMew3ZR1C6OGmI5IJd3X6crcijWK9wsWZnISDtPyifCu/5BWjsOgZYS75ti455DfYlWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E+Moc9BSunqJpw75iqcTAe8J1McxIT0EvavtWtrPnUc=;
 b=pdrya4z+553dTfWToRltU9ZIRWOOi1sCNTEJkmCyDr30I7GrsVi9jjPUn17axNgARVMVWY3ouGczP2VYHuoSBoFtI6Ku5BNknMcf0Rvkz7elHtSKxAybaOZm4JbbF8vMYYWzWaWwi8/1DzhMHruKtqWS/8hOqQrnGdoqbHHUDhdy1A/3Z3GCb6nCC7+VXjFPOE+kBGQOZNffum9T0UOukeGD1Uf4Mr9EFicE/CXcRtx3fCc9P1d+2PKcr5iH3bcKLZb0kbz7eZR7rATsMYpq2JxRuAni95LxDRRbGFDjSJWt8DIDvhk0LcEwy6t1T5p9zL59kzYQnw3lxQZhm03ndA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by CH2PR12MB9520.namprd12.prod.outlook.com (2603:10b6:610:280::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 13:19:51 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9137.018; Mon, 22 Sep 2025
 13:19:50 +0000
Date: Mon, 22 Sep 2025 10:19:48 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Graf <graf@amazon.com>, Baoquan He <bhe@redhat.com>,
	Changyuan Lyu <changyuanl@google.com>, Chris Li <chrisl@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/4] kho: add support for preserving vmalloc
 allocations
Message-ID: <20250922131948.GX1391379@nvidia.com>
References: <20250921054458.4043761-1-rppt@kernel.org>
 <20250921054458.4043761-4-rppt@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250921054458.4043761-4-rppt@kernel.org>
X-ClientProxiedBy: SJ0PR05CA0035.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::10) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|CH2PR12MB9520:EE_
X-MS-Office365-Filtering-Correlation-Id: df27103f-f92d-477f-e060-08ddf9dab5e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MVCTRUJxN2Q5eslGmqyXllwyLrZ6ZQKJ3KFVVXLPkQCVTlEFn4FEb8VQz/3t?=
 =?us-ascii?Q?47Yyzwup8WsKxVY/JSPxdIzd8v6JW24RabzeRNlkaCIP5BPoCoutjD16rI5m?=
 =?us-ascii?Q?21IyaGcC1R/8rD8s/RKC2UxTmyWWqD02a5wXSzOWFFe2HHBWQV55ENCmEr4C?=
 =?us-ascii?Q?KPfx9qnNwRKkJ/M2+dqcTw8DLdJL2fqIyWdgRY2+zkmXbu6eORfqkH4PbSm4?=
 =?us-ascii?Q?qEvWym5dqIvL3UhK0Mvje8Tm0sW95l9Z7vQtLu/T9Vn6ONItQy1/BOaCwaDP?=
 =?us-ascii?Q?c3IBZifAxlIkg0ttnu88XMCJ29TjwfoRoXX9Ercowqlj46eK0wYbY8vqYAtA?=
 =?us-ascii?Q?0ViARPTLQsey/zJTYOM8QmzS4dezlfTW2yM7vbS+WhGkGClWw6Di4/Yhgafl?=
 =?us-ascii?Q?fs7N/aJvd9QVbRplGt/hlzONynLwGU2HylLEK1SjXgwSjH3c/KtCRy1W5xTI?=
 =?us-ascii?Q?Ncvw+l05AsqzUYfJMNLQ3oqTSMKlB6RdUVxBjzQi08nv1QZWkhhk4zhypl3D?=
 =?us-ascii?Q?47BhoPHFu86jXzbUkpt2mJW4YKZBGOjW7y/121EzgWHqTBzHFZlOgQqdJHRq?=
 =?us-ascii?Q?Xsph4lTrOnWYkjZ+UCCcEO5sU4tkpXK39SURBBQD1vNnkgBjKV7cbsHCmbyy?=
 =?us-ascii?Q?VZMmcJjr5LkhmsCmQq416BsfpueDbxmyS3Om+BifaagBnNopNNnrzTKC9t38?=
 =?us-ascii?Q?5OUaOsgNIB0ohuL8CpCQORirY09YnCRwtHKIJ67xh+CbQbDMKUOK2y6HPwrt?=
 =?us-ascii?Q?61bPZamvL/RKgXLkxCq7YL4Pz3UzDJUSWn7zFkCtII294f+1WVzYtha2orw1?=
 =?us-ascii?Q?W8UzCJmQYA5XC9r14zLYi/xyvvL9crDnD7WydzNFVjxlCOxWFBtgZvdR9gTb?=
 =?us-ascii?Q?lPgslSxsfPtI9BfMBZTDAKpPGJS953Uzmn87HsiAKR+7PJbgNHn1eyw7I7WT?=
 =?us-ascii?Q?44kfofuVrqWXAASP+c8Z2/Uw9s1K/DmAuN6joFVhZRXT46J7qExwNdj2dmOX?=
 =?us-ascii?Q?SryVEzq2h4L9JfyM8fCyGBlVeAkwMG2EQO67yMWquOBTW2xIBL5z2kLfm6ZY?=
 =?us-ascii?Q?XPt0EBHca0V20nflYSmDJIqtSzYXFbWFp92fDnKcA4R6S746p6IOok2DLvku?=
 =?us-ascii?Q?4q6ttgLBeTc3vCPCjdBO6A8OJA0aX8FH0w8nac7dYcd3q4ey1GuHEKESU2Bm?=
 =?us-ascii?Q?ZbQm6IaVnhl6ufCHIwuM+i6qQcgJOKVZkn93rYPrSq6p/m8kUs0+U0BOIsQQ?=
 =?us-ascii?Q?8LzAXLodplJat4Gx8dFg72C4cUqrL+p3JRIp7bKNKuW7zwNzf3xLTUo/IcE0?=
 =?us-ascii?Q?XMC6JhXlU21jHtsPRni2K+Fqiy4r1dNBXMduCRcHVHInQhJzCYEhhIZgE0Cw?=
 =?us-ascii?Q?tXgbk0i2mlMjHKiI7sosYF7fjYsu+maJTpEa7MS4XRV5HahwEYN1A82lps+L?=
 =?us-ascii?Q?22Z6Au/zC1c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5RuNLLfUHuzDj8DSsc3axagblY8pKL5KaripE7WxVjD/8KH21CJPUym7Idtz?=
 =?us-ascii?Q?d2Ice1K+0ghlQygRcVgpJyi83fML7ivUutC9O5xuc4/qO/NuPBw4EJprxaSN?=
 =?us-ascii?Q?kdKNXpphVxjb6r3Qgzq3FRYufGfj52bH7nxNc1jQLUByzJQV4AaVngTeu+86?=
 =?us-ascii?Q?a3N5ErH8Sv1nSQPPYbzafGN0OGDrx3JwuC6AfVqhYyjyY7GavBJFljHozE6Q?=
 =?us-ascii?Q?P9CPMWT+QmDsCjyy1Pr2JpRhrYk4txobvACn7WRS7GcKKhd8AczZdTmhO5j8?=
 =?us-ascii?Q?tvO85gPAwrUGNYAJBNE6nbk3pwn0QKEhM1HMRdp4xCAovnq68KBDf7KzBQTv?=
 =?us-ascii?Q?gsMgBU779vjqwPwFDdo8m18R5ds/KIpLz/38IP5fYxGNg6ziV2a20U1AfzaV?=
 =?us-ascii?Q?VKCLaFCWv8o47QocHqbv+QVDy5Vxcc4VNs1j4ZbCnVq76M/4gqxWUuvrbw8j?=
 =?us-ascii?Q?noOb+b8q9U5uau21/Mw76ZuLh9byEOMr558LBBUgkhjrTO+22f1Esbqci8e+?=
 =?us-ascii?Q?g8X0sd8T28AxbQOzco5fDVIQ/wogZ/RgOn53X5mN8PIxlmpRNvabmSEuJYQA?=
 =?us-ascii?Q?qSs1m0qmr4PeIqzsXMQ/UrzLS2+eJf3kLpHFOkph2uOUE/IaKG64cq+nVup/?=
 =?us-ascii?Q?O30WphAPGMHpQ4fNmwbVle0SPoAoUtkUqz6cl19d5kPJ84oM9JW+E/Y1ekzQ?=
 =?us-ascii?Q?Gbr+3ytHvgqKXB/Kj3ahfG2KFOsxXA21G9zCZbwc0/LtHykkTTx7WIV1pIDV?=
 =?us-ascii?Q?nkwIFWbkjUM8tzyyFeilFqqTB5ZP/1BJYhn6NiF/S3zZJqNErBVMg8Z/3ios?=
 =?us-ascii?Q?BBCtE/U3WVsjBZTfKlNGr3iC4wMRAwu7NzC/qIEXth4NwbtBRJvW3ghk2yyU?=
 =?us-ascii?Q?uAPdSFU7HAuiO0+XMYkCCR/TWokpbnlUITrFwh+7X8NMWz8O61o/ql3r/aJ1?=
 =?us-ascii?Q?EU7PuQaBcerNAHHyUx0+UmGclRkXcApWswuxELBMrFXHgxCrIWu2M+/lx7Cq?=
 =?us-ascii?Q?Nou9wOBeiv0CG13HHPq9NP8ewnniw1YNs6CP/2n7XMm35gTnSAKv5EYPKU7Z?=
 =?us-ascii?Q?Xk439YtkYNnVVG+kJ43qg6HpW2OSr2g3e7EAlq/TKI5FWiTlU6R82EN5Uz7r?=
 =?us-ascii?Q?1v4mBAExqhUqMfGMHGcJc3I1lXp+Z/tSFcwGzO5fX4wiL8W8naOsOoFHxXw0?=
 =?us-ascii?Q?upKNOTQio7bkzws4xGyHAVnjcupOeGLH+Ep+Gp72uGXrHwQwahiDmJnC8aET?=
 =?us-ascii?Q?rereQ2f9egdfImqk8C9OvaGfasTFvFvrobVEGnV/feH5SjAqPpauX/XEfwmq?=
 =?us-ascii?Q?Dn0oju+iFwz0bQgG2plC8mBSbWFnmrQN7DEO+XVS/LlPUrVTe+j2bbpGRAcY?=
 =?us-ascii?Q?rGe/+C9W4lk2oS62EQx3CNa+iuf0sP2pNIVKiGBUgstTU8AuN+va9kjQGb5u?=
 =?us-ascii?Q?YfNKXr88vvVYQB+O5pDYSQQHAFOTNXcVCmEmDjgs5CpwazGDqIiyYOT++8aX?=
 =?us-ascii?Q?XJ4IIFBEr6ntxfGErB0Uepk0vnGovcbmIUmw4mFe4utfG5JlPMF4icGk1FW9?=
 =?us-ascii?Q?TJPQN+nItOiS/DpqXq/o3trikAlXW4hH50u029di?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df27103f-f92d-477f-e060-08ddf9dab5e5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 13:19:50.8178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IjOrA2M9Wmj7JAJ5Ig65t+RvF9v06wHCVg1EUTRV3OY+ZryTFU50teDeqATwVXFq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9520

On Sun, Sep 21, 2025 at 08:44:57AM +0300, Mike Rapoport wrote:
> +/* KHO internal flags for vmalloc preservations */
> +#define KHO_VMALLOC_ALLOC	0x0001
> +#define KHO_VMALLOC_HUGE_VMAP	0x0002

Maybe something for a followup, but we should really move all these
"ABI" structs and constants into clear ABI header files,
include/linux/kho/abi/XX.h? 

Having them sprinkled about makes it harder to notice when people
propose to change them and that makes it harder to enforce ABI rules.

> +static struct kho_vmalloc_chunk *new_vmalloc_chunk(struct kho_vmalloc_chunk *cur)
> +{
> +	struct kho_vmalloc_chunk *chunk;
> +	int err;
> +
> +	chunk = (struct kho_vmalloc_chunk *)get_zeroed_page(GFP_KERNEL);
> +	if (!chunk)
> +		return NULL;
> +
> +	err = kho_preserve_pages(virt_to_page(chunk), 1);
> +	if (err)
> +		goto err_free;
> +	if (cur)
> +		KHOSER_STORE_PTR(cur->hdr.next, chunk);
> +	return chunk;
> +
> +err_free:
> +	free_page((unsigned long)chunk);
> +	return NULL;
> +}
> +
> +static void kho_vmalloc_unpreserve_chunk(struct kho_vmalloc_chunk *chunk)
> +{
> +	struct kho_mem_track *track = &kho_out.ser.track;
> +	unsigned long pfn = PHYS_PFN(virt_to_phys(chunk));
> +
> +	__kho_unpreserve(track, pfn, pfn + 1);
> +
> +	for (int i = 0; chunk->phys[i]; i++) {
> +		pfn = PHYS_PFN(chunk->phys[i]);
> +		__kho_unpreserve(track, pfn, pfn + 1);
> +	}
> +}
> +
> +static void kho_vmalloc_free_chunks(struct kho_vmalloc *kho_vmalloc)
> +{
> +	struct kho_vmalloc_chunk *chunk = KHOSER_LOAD_PTR(kho_vmalloc->first);
> +
> +	while (chunk) {
> +		struct kho_vmalloc_chunk *tmp = chunk;
> +
> +		kho_vmalloc_unpreserve_chunk(chunk);
> +
> +		chunk = KHOSER_LOAD_PTR(chunk->hdr.next);
> +		kfree(tmp);

Shouldn't this be free_page()?

Otherwise looks OK

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

