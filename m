Return-Path: <linux-kernel+bounces-799531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D2DB42D31
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 01:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 915983AB02F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 23:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C452E8E14;
	Wed,  3 Sep 2025 23:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JhkNwbtB"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0059019F12A
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 23:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756940859; cv=fail; b=cTPRiZ/b4laI7/Qp4Li2P4mT1C/V+01m4Lf5HHbzR4lo98yskGaUKZmvkw421g3flf3ihoYHuhH0kPjVoufXNHdCNocgGD4/7S4TaWkt3B+oQnG918aYeoQZ0EuVDvvseekAzPBl1be97X2hWPwj41257kO20Pa4DUapT3X65Ow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756940859; c=relaxed/simple;
	bh=KqpSPHH1Bv4fSmQShR8b3k9DuPdfxAT8Gqa7QK+wfGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S3rKuAoB9wp0w+tsk4CbttocX43aWK6pO5Clc9o+tH7NvGgLfJJV6mHJ8sBTma31+lPluWs9vgBnEC2Rse0JSoZfdFZA+zO1ASoLpb5atwQBgnlmcZlkG8W1ZMUFWBtouYMD048ADVH7teAlYP1PZsjHb+C6YGebqHHL/dNk0lo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JhkNwbtB; arc=fail smtp.client-ip=40.107.244.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qu5f3YVXa/hhFdKg9meG+MhtNhMGD6aObukTIp9+x+ZNXcWvVTKk6Wq9I7FXs8B80N9dh1xP5zY7MxLYJVs/yJNhNm/vzPetvViwPSflkykKqgyn1Um+nSvPeF6vBWzfEMBOcj6fKb63ncUd1CGPwfgVAEqBN0vlkidYFRX3UuGOeCsTWUh8yBBeqObHg1yP9wOnQp86rWEvzgwoQX1qmS/XHY5kDfsnaxx4zYo+KAkGFSUTJxaky5BkzdfXjK/BRaN4wzBJamYNb6LRcvz2ZCs266Q36SMEMnadqq1w+PjNzSdfWXnJuINJuRXaOeIH0VVABiq+SG5p275Fi5AN4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8civ0GXI8bqaPeLVMsv4hyQv400J6PS0dN051JSRGgE=;
 b=WLmABguy00JXGPJ9r8MGd1HUQ9SDsQLJstiTuTs8T7PzGg2rOtoOnG1v5X+kknolFQPE6hv+msIE7Oq+6Cs8o3KZ7yuDvTb/iwOIS2/ZVF6/77W9iVpECOQsXNnjyK7IE5TA4ha6WX7AIzuKUmU26qUGUl5EHqvelv0tdA72/42FqLat3JAo61j93ULud3S2gIfY4WL59EucH0g6Fd6w9KPx8rH8pcNoNcUF0I2ax0T4IaxqyjpJnGqfFxT6mN+eZrbDqe0/8zHqER+jK6ozhKlGBg0QOClQ3OOTbFweFKfvdVgYjXjqX6Q3Nr3FWDb0IpbTSS3A0Lj6S70wUycNfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8civ0GXI8bqaPeLVMsv4hyQv400J6PS0dN051JSRGgE=;
 b=JhkNwbtBSilaz4Myk+zPDraDiik878bdXQkkl8jWdzERs8k0EmyONPp0n71NVZZgILKvTei2tFf98rgXWAcFIYYNcKjyx7+gabf5X2JzxgUStXi4tnxjg0RlRloty4RMzkvnnx3Gn7vOulIbbTntVd1H/yRKS0MepmpHNnMxeTQyyKFeq9jSErRZsZbCmNQRuX4D87JbQwjycxlg98v3XucOhuYJijewH6oLLq/4G2mROVGjROOiFuCvAYW58p21EQ1Mrtw+3STsYwanVJooNldd/auJZz1a6J03gBxsHJ9NmrmR8wi9eDTuWrIZLfIYLxg+FpqQUv+xTBK3u7v7SQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS1SPRMB0005.namprd12.prod.outlook.com (2603:10b6:8:1e3::12) by
 CY5PR12MB6345.namprd12.prod.outlook.com (2603:10b6:930:22::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.17; Wed, 3 Sep 2025 23:07:35 +0000
Received: from DS1SPRMB0005.namprd12.prod.outlook.com
 ([fe80::7629:20ac:4306:5f4f]) by DS1SPRMB0005.namprd12.prod.outlook.com
 ([fe80::7629:20ac:4306:5f4f%5]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 23:07:35 +0000
Date: Thu, 4 Sep 2025 09:07:29 +1000
From: Alistair Popple <apopple@nvidia.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, david@redhat.com, 
	osalvador@suse.de, jhubbard@nvidia.com, peterx@redhat.com, 
	linux-kernel@vger.kernel.org, dan.j.williams@intel.com
Subject: Re: [PATCH 1/2] mm/gup: Remove dead pgmap refcounting code
Message-ID: <2eavixbzaofgm7ufqrotoii2ljs3yvz3sax7377k5pjq3q2jgt@m2trxwsnfpo6>
References: <20250902051421.162498-1-apopple@nvidia.com>
 <20250902120626.GA184112@ziepe.ca>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902120626.GA184112@ziepe.ca>
X-ClientProxiedBy: MEWP282CA0107.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:1d4::14) To DS1SPRMB0005.namprd12.prod.outlook.com
 (2603:10b6:8:1e3::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1SPRMB0005:EE_|CY5PR12MB6345:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dbae8c7-ae69-4040-8dcd-08ddeb3eab2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ol0WfyAb3f1odpNCSLZULOgOT3bHzxP3T0EUgSM1kaojqPnAgDAFEdbjnU6i?=
 =?us-ascii?Q?nmW49twDM7Q5ShJn+/G2/lo15EFmyB4sHusGUhL2SW75xUivta7uQZg3al4f?=
 =?us-ascii?Q?oEFcxz2MIIOql/+GTKpbUEfgWQLe9Hdwh2DmyPoYXFWUOcQkkE0YaYZ6HIVt?=
 =?us-ascii?Q?BpqmbYleRv0a6KtuxY0a+mUgkxCHiPIuqHcilExDq0xIQ5gzQJ+mBEM9cDBo?=
 =?us-ascii?Q?fYr8BSrFkWVL9XgYXiOClcz5YCGAVhxtGXvwXACSz/8swo2ThxwYZLrRs2u1?=
 =?us-ascii?Q?A49kOMEiNMTlPAUrsx1KmgD9sC0fbcT+QVL5NChWtQYcg1v49vRHSHutxPoK?=
 =?us-ascii?Q?34jZgwXYonBK0n77jsWax4BcfgOCs8YRq5JqGYEZWMOWOhK1ZFk+CAMbB/bF?=
 =?us-ascii?Q?nIboueZ2ebqJBbtnaIrGOnREekB44sernVWFwpVzdlGJNYPAX35ko8i/CrlS?=
 =?us-ascii?Q?pMfNn+/sSvAc478ziqJL4idnIxXIwrYw8X7P5lnBXxB3EY0hrPnAVuS/FHcU?=
 =?us-ascii?Q?I3Rpi59zvzFdNLoTYiXSbnGw4reyl5CqcFGCZUqKPPMvZYhVecfZ5f5R/Lt+?=
 =?us-ascii?Q?xvWSo2GkpWKcyR+UXtuPJMGKT8E7x6UdyVflH7SxLtL17ep/7mJIlRTmqbH/?=
 =?us-ascii?Q?QfsZwCxRcWxBuqqUPDaqEG4Uy9WWpzuh1j3YHTbQIIQOYtmR680XGTO8HAXu?=
 =?us-ascii?Q?7cWEGhvL0ZBJsPY20ZaokgqHpGob6qT8ky0gaTFb8pLTC1eHqEHA8D2KyV6b?=
 =?us-ascii?Q?IUKEbG9VN1LP/OTbMPxii6MbJpzzMTiwnSNikUpVIloTSINKNF5vg5qK4SDW?=
 =?us-ascii?Q?65an3l86v1XMS9ukAu3ubo0xIdxc/15GmZccxewzCS4d6TXopI0CklSCgZhd?=
 =?us-ascii?Q?QMtG4QAEisnzfaQ11EhDNTtHjem2JWnu4BI1t5OAgFAv5k+PbYmmrBg9Vfaw?=
 =?us-ascii?Q?/hpKcDirY+1MoS7fg2J98v9FgvNKHPtJveEGN1G5dZo/pQODVAm2ak4Skgap?=
 =?us-ascii?Q?6ejOuk/5oSiby4xHVkF4mLepGYaN7Vha4TZsa9C/Al87VDs0+Y9oV8si4l4J?=
 =?us-ascii?Q?snvJ6ONDhgwHIl1NlUt8F8FpB3uNgBBR5ZyM2ncoXf213AtoE6ShaT55iwR7?=
 =?us-ascii?Q?5JGvQgY87bOY1wlxY7LTf0IYlVkbSCCAgfj4fd7KmPzMf/kP4EjLqVR1ChBo?=
 =?us-ascii?Q?PDOfBP9i255MCxwfvFxu7qSIxUPWub2gNUCvM3JHYu5faz6ORyClGL2Y+ZeA?=
 =?us-ascii?Q?8An3JbgpzvqiIc19BQBYHoYUJ9qfEMrYHqWz7wO7OsO+mJ4UvqmSAL1x37q6?=
 =?us-ascii?Q?tl0Ay4IVM7deU+KrSHvAGHDWiUmEA21JvReE7UTQWmv2iAOykbaHFZZVjy57?=
 =?us-ascii?Q?xHMgRCOK+9TTSA260D+KIHnT7pMMgv8A4JG442E5/gdlLBc1nLR149osDXJM?=
 =?us-ascii?Q?Jce9NHztPGg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS1SPRMB0005.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y9ZvDXFPJGTSNykFp/lB3SIuWSLEPU+b64BjwauEhRN2/bq0bueuWe+8s08v?=
 =?us-ascii?Q?/mkg4Dc+P5O16h+E0xYvmd+WJaSl7IG+0W+UdironQPzm3ehLdJ7vHhT1tNL?=
 =?us-ascii?Q?DUkJ3ntJOFKwqF6Hm/X4KpH3MEtkUbAwUVrYdGHDXYZUp1yz4sKxEh73xLPZ?=
 =?us-ascii?Q?t9QS3vp3nENXheZQbLtljXrhk9frNsmm7ia7SuUXuCAdsuVmrXLgv5GiK3Uo?=
 =?us-ascii?Q?HMD/TWc2x6/VbInCBPLqCu/pYii2NIO6ElaXtLhJ6siI+bC7Cbimgt5T4/Z/?=
 =?us-ascii?Q?tvDvv/crOBc1/QEB8NRd2QoKnOK8wsxjBXQrvWGgNE1jBvU43Hqh9a8xnjWC?=
 =?us-ascii?Q?FyF3zPav8ZDOPvY5fVA9u4YK4scaZQRWB+9ts2HCMCYDYHtFpYU8UYkGmSQz?=
 =?us-ascii?Q?VpGyyYOJk844tbutn6/D4KNUi8rkwEAdquS0VVh8OXvwUdDQSHlPMqheqdjo?=
 =?us-ascii?Q?VQqWaRyauwTPLTc9km09I6oQ1PzfVF0lKz13SBZlVUtfhg/a9MhAG3hI7XQC?=
 =?us-ascii?Q?DxV8+OKS/RRXHPIzrvvo9VXN3AR6Falv05uLeM/qPq440ErRegZig/wkvEgF?=
 =?us-ascii?Q?6hyASB9Y00A8GA+z0MGeOQVvI5YLog5h/7dHSzLsCz+cpfQAmt6JGcv7bTAa?=
 =?us-ascii?Q?Kvk0L9z2+sgBv4vcp13OZob6MAxQmvXfwSDbx9qecQWv6oyvlJe2Aloy8TbW?=
 =?us-ascii?Q?VPA8Atrwwl1P2dsziA31DltoS41TvhvCAg1Y8pa+pxhq7l+hwsrY/9oChYZm?=
 =?us-ascii?Q?W+WEjJEN5MyklPSTG+p0N26sER67kcUwyKmFk++cX4VGAOcjU9IjC1uX9bZC?=
 =?us-ascii?Q?JpJ8QQXrGjTFH8OEIrmZ2a9t60Oiz8oIU7ljv1bx3khHkr2bk2u8s2NspMaq?=
 =?us-ascii?Q?Cs0sRJuQ1oWVszG29En/nGuB1ppkKO3+oVGaAG4XuifMP1kbbwKg9D1uAnrE?=
 =?us-ascii?Q?oT1vAe8W5pd5S6D55kWlMM7nLVZZpDtdd1o9P39Lv5TtSZfacGjq4AZiGK7B?=
 =?us-ascii?Q?uqS59XoAzFNg3zOlEOYSG1ESTxspqeL2nYwjFCSSwr/VHoqGTsHdmZ21ENpb?=
 =?us-ascii?Q?8NCuJ/vB44TrUbru3Eop8UEZ5FQ72I52XfyST0bprKQGFe8az4UDycRpp6vX?=
 =?us-ascii?Q?Ng0hakzL+Ex7tVuQ5RG9dVHjslIqob11muui4SIm3FtPnAWKfpWTC7nibGHP?=
 =?us-ascii?Q?r9RoC8GJYRXpPhuomFSO8gjSB7G5/g3fZhjoYN41U2KKVJlz/8HwY/98isUf?=
 =?us-ascii?Q?6H7IIW1nCigXbGgY3JJUTPfkosxmHDfSoF+Tln3miuVyB18xye0ZatKCw4Z/?=
 =?us-ascii?Q?3hNNp+b5H7hBb8OsagxMeCRrRz9aDSOIJwRJgzFtjq7Y2ZjQvWEe6kYZfVTl?=
 =?us-ascii?Q?VLpRWVxqbtwRmk7LwsJoE2yN3EXF8Q1Xv9okpguyRZ43qiAy+LvZrzi+pW+F?=
 =?us-ascii?Q?Deeey6mwGCKxBwhiJeSkS8V7WfzfEQxj0CjzUs9dG404R6UWGHrMuEWdS88m?=
 =?us-ascii?Q?mrFI6Ihu4f8wP2Vv7oy3cPm2uJX42R6DL3saCVxVkLukidNPzQujZQ4hOxj9?=
 =?us-ascii?Q?I9zlr0eLqR6BEm3seYQ0KUsllqp6igWU5nyUHWjZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dbae8c7-ae69-4040-8dcd-08ddeb3eab2d
X-MS-Exchange-CrossTenant-AuthSource: DS1SPRMB0005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 23:07:35.1432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Py/Z3dBBe9g9bUqm8mvXjMlR1pMc5sCfhDFDwT4T7bQ1XxF3dTdWXJScm3N/Z5JGuKFgEhQNd9CWoGqRjofrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6345

On 2025-09-02 at 22:06 +1000, Jason Gunthorpe <jgg@ziepe.ca> wrote...
> On Tue, Sep 02, 2025 at 03:14:20PM +1000, Alistair Popple wrote:
> > Prior to aed877c2b425 ("device/dax: properly refcount device dax pages
> > when mapping") ZONE_DEVICE pages were not fully reference counted when
> > mapped into user page tables. Instead GUP would take a reference on the
> > associated pgmap to ensure the results of pfn_to_page() remained valid.
> > 
> > This is no longer required and most of the code was removed by
> > fd2825b0760a ("mm/gup: remove pXX_devmap usage from get_user_pages()").
> > Finish cleaning this up by removing the dead calls to put_dev_pagemap()
> > and the temporary context struct.
> > 
> > Signed-off-by: Alistair Popple <apopple@nvidia.com>
> > ---
> >  mm/gup.c | 67 ++++++++++++++++++++++----------------------------------
> >  1 file changed, 26 insertions(+), 41 deletions(-)
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> Yay! This never made alot of sense :\

Yeah. We could probably get rid of the pagemap refcounting entirely, but that's
on my backlog for now as it doesn't seem super important.

> Jason

