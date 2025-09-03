Return-Path: <linux-kernel+bounces-799138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C2AB4278C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 19:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E9061B21787
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 17:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1EC92F99A4;
	Wed,  3 Sep 2025 17:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pFRKKAAC"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2047.outbound.protection.outlook.com [40.107.100.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888DA239562
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 17:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756919198; cv=fail; b=jabWCVDm36blAUuWa+dA61V1giQYc28sm7h//wLYS2RcMTykrFD7Je9ZvVPwyiHGwt6PgbLLYrJ5fp+GXHDlNGwY+lYGtvsFtPkvSlMnwb/YxkzgJ5wwGtzRQTPQOWf7Cbu7JrsB0iqnCvDdVa4n7PS6GJLDkMNOWILLgMtf9FI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756919198; c=relaxed/simple;
	bh=cfR70DZiBc3renPHlLhvRL/w6AQ3auypmLWvDH6GioU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FoBXlMdodiszW/uW7vb/OwucHL43JZ7H0Btv7G5+Z0Kf7BnXzWE+DP2qENw+tS93W28K45yJivDKZxOj+8Uvwn4aw5V0hF/5GzPT4K/vtiFBCqzPVcn7zqniCjx+VostKknn5DCY/B2WrLf6KwBWl0IyS3A+upBfWDmTlmtvNQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pFRKKAAC; arc=fail smtp.client-ip=40.107.100.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WuBU8R379BlADwEtLLQWoY9wBKN/hQ96fII5sgtagDMl2SPYeZA8tUxPz2a7KWE3xSt5t9ra2HUazP39Mj8iB+ChrSDlIo6qkcsr4YP9onkytPb0tQMpcYm/oqQK5UykgStINAUUYpBKwnOawpzw371gGRleKI1pkVNnQifoq6/czgdSlwMV2zwhKqF97f8pMh1dj91t+XBF2p+V3+efNzdTZuIf1Kc3f+Uf1TatL3hnrBVMVS2/Mv0/RCVWohhpaF2OFg/uBxkKdCeyzS+XpCJXUgPilawsOa7wk/u+s/z2YMFVStGDkuHEUWa3sFGyWpF4h9rqomIfTfN8+kY3ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DsE1hiqNNWdX1K9d8qh4nNysrbtwaSqriEk9Wbt5RD0=;
 b=UjPX66ue6cN4gOFoROToDkKUpBNLffwDDnRdyXmUrf5rMNSwa090qVm4I0nzzEqnQBFiC68kPNOvq3wlxqB0bBM+jlD7LVDPJ2qHWnKWYnw6WS2DpvsL6oH5giR4ndz3K3LIirKmQtn0lS2TgG1xu9c/3M6C+ScKLcQtNBrhU/vg7CzJJ9qEPxBlOjRenJEDvwthnF6MuFNbYIP6tRT3sFg9r/B9+LMO+e8QRCkt6KIIOgqu28HzWzOUFjWggl+q+eOx0dz61IonMInT2mC1h1G325ibNH+SYejsbyLC/aVFqJ+Fzh+CWPrBNFE1j7i2KPuVh1b81AdSvYh0ketqMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DsE1hiqNNWdX1K9d8qh4nNysrbtwaSqriEk9Wbt5RD0=;
 b=pFRKKAACeW2KxYXAeL8Ed0gIgI0MNuu5GVqxHbRMFcYKaA7VkOmPKVxb5nrBtJJyUCNHvkkQn+IbaTd9ppOaBh57V6+X7B5H9w6l8ZhgPyREw5VUMU5RetZGS8mbFOvLEjjxPOsROY7idZIve4P/XnOreJDYH/nL5S3o/vMOP47wCGIanOjE5WRpYSd/6dpSGRg/8z7/iJRym12GYK4A3RZbAAdPi4smNV5wOzqj0Hi63+VvZGi3sYeAjBRYg5wBJRZJDgFQSG/uuWlGzQ7Z5rO9xubzhXng0U4IT7RJk+6959gxK4fH6muGsuocwV9zqa/NhbZr+FOl7mHCao8sYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by MN0PR12MB6272.namprd12.prod.outlook.com (2603:10b6:208:3c0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 17:06:32 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 17:06:32 +0000
Date: Wed, 3 Sep 2025 14:06:31 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Graf <graf@amazon.com>, Baoquan He <bhe@redhat.com>,
	Changyuan Lyu <changyuanl@google.com>, Chris Li <chrisl@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] kho: add support for preserving vmalloc allocations
Message-ID: <20250903170631.GK470103@nvidia.com>
References: <20250903063018.3346652-1-rppt@kernel.org>
 <20250903063018.3346652-2-rppt@kernel.org>
 <20250903125620.GG470103@nvidia.com>
 <aLhg2Jli0KUe-CXC@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLhg2Jli0KUe-CXC@kernel.org>
X-ClientProxiedBy: YT3PR01CA0041.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::21) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|MN0PR12MB6272:EE_
X-MS-Office365-Filtering-Correlation-Id: c2d12f61-4d5e-4a4f-6ac1-08ddeb0c3b4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sQ6JEcnz5UCa3HUguqDO4kgpZxyy7eiPxzsQhBx/lyUf91NSSkZ6fid/N3Hp?=
 =?us-ascii?Q?ZBVWHtM8UfqZQnDfz42HDcZd06SvL31FvNUwcj4M4VZMyeFFR9jK81bsbqhU?=
 =?us-ascii?Q?WveSk/xalhvxttAEyTW1ifo1VvlsBQK5TfrGb27avpziHDPN+6hGYA20aWlE?=
 =?us-ascii?Q?dH9Y8oSas+X8/9+AlyC+raChzxjPF1qKVGq1t8C6MfWvs54lkXzm3wh6U/ow?=
 =?us-ascii?Q?dKfWBmqnJYoreE5eW4Xl1SRmD7tUD+Ip+5KFEQp0tCVtWF60qIJbYeRvQ72q?=
 =?us-ascii?Q?IFvwt8cnuPd3a59NmYEmtZzjGx1w/8M9039K6rJAOEVdijEqwjL55uyftLyv?=
 =?us-ascii?Q?2M6vhBsgRsPFvpDmrLcweiGc/6kdx5OyWJiZ4lvWHCVGQL2ShuTo7fLHEVdf?=
 =?us-ascii?Q?0SD0BdW6UY5Fbw84It/vg3FLn8N4tlvNlvxvYOvzyO0e89XKtN5d6fqKJvaO?=
 =?us-ascii?Q?yaMXwptapmO/4HlQJpOCRwLD6Mwr9CIpCrFot7pv4+yAI2NMRsr2osCisvQq?=
 =?us-ascii?Q?DDZOGKG1xA2ywXi/EmGrw3wYXF801go/K/MX3iwc2yL/6vfCJy9T4Z4UHWJa?=
 =?us-ascii?Q?18S5S9aGvd4dhqR5+2f7h5MIs2LlyEDJC7rqrKtIfifd8STt6q0zOMFgiWc8?=
 =?us-ascii?Q?+XlVursGsKCAqN9s1Rw+ZKH7qmBadN8ey1iLjJKpnkPCWJGx5L8/Iwb7lXFJ?=
 =?us-ascii?Q?3DMyKpfXcGzBSHs7kB79zXcZDSuNJNIxSPjFKkbzQoRha/QKy1lkd0O5aiug?=
 =?us-ascii?Q?FIH4DlO3TyHM6vsHMWBG4thmeessLuOf/XiEZ0P4+NZuQGWCjJV1VdKfw+tg?=
 =?us-ascii?Q?JYndHg3UIDOAoOMhoIpxhx2PwfBIpMTvGBuhtDmuk7z1nt0V6O9J/GHGfG2b?=
 =?us-ascii?Q?vNRLJw1zl89UYDCFkIWz/Q2vJ1MCW9XEyfs2kyRQ+ROGIzivJ8POiPpsxzza?=
 =?us-ascii?Q?vlwM2F7wH3TVGwpb4HPaX2ZdSG+5buvE3roIDv+Opq7L0PUBIyRR84I87746?=
 =?us-ascii?Q?QkoVn5sJAGvj+7H6tr+Tw8zNSGibLjmBRMDLmCNwUgXMsmsuPEaj054JG21s?=
 =?us-ascii?Q?la+vHmKzDywMPg+kDv0jKKqtQz3v8IYJ0ewSlPrGVz2Ku0mvYx4gYwDjwCYF?=
 =?us-ascii?Q?lZ/X+6LggyaXu57lP6p5r89amxTVHrVS7wA0Njan9wUpj7qhOCTV5WlYRCMS?=
 =?us-ascii?Q?3iF1sKPhkndPLtI1FR7/JmzbAC9QE+b8v+vX2c+5hCPzG29ZG7HGlvlPBxkF?=
 =?us-ascii?Q?3P+d9d2CqtYHA//RodYUQQ5JbPejJvNqcgciAT+94dTh2CbRHQcOP60llPA5?=
 =?us-ascii?Q?BOxif5GIB7vfkJYF7tnZIn7YtSPVqn/VaLhi7DPx/yYpdT19P8+KSdFKgKgv?=
 =?us-ascii?Q?inN63i/9FVlQwnsRve03R9dV7bs5MxQ5slYP2oX+oJyxIZFZHSJNWqMHybnP?=
 =?us-ascii?Q?x3LvCnXkFQw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZoszUNMrhvCN3AJDkVXVJ9vZOjtV6ciaSVL/JHDNtuJPYCDesZxYhGfG6un/?=
 =?us-ascii?Q?x/ypt2GyUSm3dzIXZW4BAciXlhl7CtoYLRWmgBfGZn82tHrRAe9fnkjaR+ff?=
 =?us-ascii?Q?huveDF3nEQd4iO4vGGyMqn77qSo+YUGSHFZpuhHLgYYdao+VZurMVSyWLeCL?=
 =?us-ascii?Q?iIlMLOZdE4mskkNcurldkEHb4Tss+CN54snSqJJx+4emrKbAsjRI3+r6iZ/z?=
 =?us-ascii?Q?f83Ghfv2JYHmnDvpoZddCjDAKEqi8sOTbmGHYGDYEvuxL0U0p9D7l0+gz9mH?=
 =?us-ascii?Q?JbJP+IDJ25emEzVsLkKeq43oMrVZ+FO271Y0cKk6DheWab7H/NnUPnQ0KcKM?=
 =?us-ascii?Q?AjQotET+XR+XxBbgO2xYXqZqFHUaLZKE3XycPxYjRlccj/HNB3VN3F2cD7/t?=
 =?us-ascii?Q?Oh1mR60wSg1l5flRMLcrDPM78Mf6xvayi9rPfOd7cxIrqmIzgzzGK6K3T2Gk?=
 =?us-ascii?Q?7En9Rqp3PLm4n+xnw4OlCjVT8OyjH3k/4juEOH/bJOrS4awQh6K30Es2eOTN?=
 =?us-ascii?Q?uPFian3gP3LZkYBrNmamPODgM/bStQqKC+0xZtsiqWhK0tgIfdDU0i7qGgQj?=
 =?us-ascii?Q?Z2uLg1mGCg/r44p0fSAme++MELtVGM9oqcz5ITnF17u/Y3gwDtv5R+BNZy94?=
 =?us-ascii?Q?2h/usSBCXKIcxT5YOz3ethaK3mniUV3Ky8AQSD5z+jHV06/awmSrjev4ezos?=
 =?us-ascii?Q?SoQQjB9qVc6AKDtIoh0vafpX6taQErME7x/L8vfe2wPJEvRZnMl1V4i5TLN0?=
 =?us-ascii?Q?jxXhgnwmNgS+Pgm7UABcHQuHazcsYlbxniWTwIb3/M/Roet4Gj2v1RMRHTkK?=
 =?us-ascii?Q?eSumABQ2zd/UECgI22VpTQ5a+0+zEVwe7qKA5axVAoAXlP2pVe7aT1y23NP5?=
 =?us-ascii?Q?7RhUGOTXmdn5iAP21QfYhl3NSUuXeixW5qyn55MMg2EpiUiqrZgGqDv9KaMi?=
 =?us-ascii?Q?A/CxC4wrmzyZwxEopeLw6yd4bWdW/vYQClvWxDxz6OOSTi0xnZfxcLiJFt8z?=
 =?us-ascii?Q?tmvrvNqTjqocKcRTmHMc1L8iQM+xhh/KE/+NMEt59ex5yXRebeN6EBEJzyDm?=
 =?us-ascii?Q?swmx+isM4o5QMpw7wcFjFJLb6LEI9ZZz2NYqERHvyB35CptsKGOF3iF4Jw/I?=
 =?us-ascii?Q?+7z+yh7WqMccW2KckORucu2xLDD0E8WK4GHhBmCumk5vNm68yu2qmJ0a+Zq/?=
 =?us-ascii?Q?r/3rI/ReFsFzuPPauj1zLnl2pBVtjNUzICilXTjauul/p1G2gSxyLFyK7LUl?=
 =?us-ascii?Q?f8xqdwZFN1KmGNhZb3YRTwXOMsa8VHGBxARuy6aXKlxIoGKUAAeGTTsOfDmr?=
 =?us-ascii?Q?axzplWlOlPg08Ymfhr+aQ9FxjBuWEWKsAKGPuwpIDSj+wU+X2uV+JGFph8Kq?=
 =?us-ascii?Q?Auvm2TZpLmMssGdQheiNHNa5nU5AZhTxpe766Qw7nrdF5kuOpeFImnmm3cP4?=
 =?us-ascii?Q?ueJEWzeX3Tt+y91RON8ZFMK3ZnxG/JVjAeLp48r29WoC3at4tB+51CMiNBQk?=
 =?us-ascii?Q?2vXcOP3gohkc4MHQXMoiVMz1Mcd7XBrOq6PuEcpKNkxG+4C8wW6y52uG0qFF?=
 =?us-ascii?Q?3pqUURMSnhmW9HJ6bMk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2d12f61-4d5e-4a4f-6ac1-08ddeb0c3b4e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 17:06:32.5351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rXPRXdHEJQf5H5SSoLJ9W/UUzE4y+5ZVCPvl2qyKDjEFUtp1gSlsJxOjPNqWOkPo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6272

On Wed, Sep 03, 2025 at 06:38:00PM +0300, Mike Rapoport wrote:
> > Don't call kho_preserve_phy if you already have a page!
> 
> Ok, I'll add kho_preserve_page() ;-P.

Cast it to a folio :P
 
> Now seriously, by no means this is a folio, 

It really is. The entire bitmap thing is about preserving folios/page
which are basically the same thing ATM. folio is the prefered type for
what used to be compound pages.

As Matthew moves ahead it will effectively become preserving
memdescs. This may even start to happen this year..

Every memdesc has a type, so when ever the physical pages are restored
KHO will need to recreate the struct page and page->memdesc with the
correct values, including the memdesc type code and any memdesc
allocation that Matthew plans.

Meaning everything should be struct page or folio based at this API
level, and restore functions should be logically paired with the
allocation functions that created the memory in the first place.

vmalloc() is calling alloc_pages_bulk_node_noprof() to allocate the
memory, so the restore of that memory should also have a 'kho restore
page' type of name that clearly refers back to the allocator it pairs
with.

In the more general case this should be setting the cgroup and
charging it as well.

> How do you suggest to preserve memblock?

Does the memory have a struct page? Then it should be a preserved
folio list so you get back struct pages in the right state for what
memblock is doing. Someday that will turn into some specific memdesc
type and so on.

If it doesn't have a struct page then it shouldn't be in the bitmaps
at all.

Jason

