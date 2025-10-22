Return-Path: <linux-kernel+bounces-865072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B20BBFC17A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D118E1886CF0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCA35733E;
	Wed, 22 Oct 2025 13:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pdaf3y0K"
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010056.outbound.protection.outlook.com [52.101.193.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15C226ED3F
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 13:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761139154; cv=fail; b=fxwLVvkeTmLBdhlwY/fBZVIVbybmK449QZHP7FLE/OTbZwNp6oKntXu0CyZ4ly/x3m2uABG36HE6ZKSPaDoX6KQ//bUkNkpnRKIaQsTTYUINCjjnvPC5thJbLJqKiVNm5aDq4qVjGuz2IaYNNZpISHdiKAtjeBedF46SWmR8CFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761139154; c=relaxed/simple;
	bh=+ythOVqjDMTyUiI7IShmsSMk5maV+Bj8oht7ZonChFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GNBWxHqyaDirpevgPkoXIqYJjM5F5Msm6d+bB2P0lLKT+PfhnTnIPRO5NVT0KorylXdv/0j7GfgwJnypkOwiQA/DrNwKxR48pVdfEuyDBjOmhYXbWx9/WJ3/ot4zMWYOfqtJAxFH21yHKVEkt3NlX0Nsy0qFIqPoFgWYxa0fvYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pdaf3y0K; arc=fail smtp.client-ip=52.101.193.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XR/PF/jeOMa/UqYsmFkqpVT366xrPB1X+oI249SpY5aq8Bj5H7Xy+jDJum6X5YldlgRkPUoalE8dbVy3h6c28i1/SsGMGkjvIFK+ej2VyzNrgwUg3ylsuCV1UMQACa4PySiMWKvg8uwMDvi0NS+Z32rxlKUmXPRcPJTM9EvS17c9kA+NT0rZOxb2ej/tyIMlPRDjr7gOO0MvW66L3w4NC4cmG4HC1fvMt7LiJYQhgz8m+qljsYbmeRQBiBwJKBz//qfupkdrWdPP4wGp7h5QvhQ4sCbKKUpwrZYV3Mr4ZhsIJxYZi0cjbwXOjAMYhzB4q35GBZ0wUWEcMS4fHVs3fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CrjczJg9/TFFUaNnmCJ072R2N2wVMXiFF2eiKF92uJY=;
 b=lEYuRjZ0wqTXn2NZxrVvVOFmUaeI07OCq4gx+y80FXGiLH7WMeCY5xH/OUm5torR43zanqymE9tj2c+i5qYIPHrFE7UX615JsWmFu+qZIqM2uUb2nFrcj1VR2aUckECJj6dbUhE34qQ1jDTGL3dlMuAf2d6vaK9QflvnqyAt9DyDvat3fa0K90/dQJuYjDiwojdnDJ4Ig1EKQDdWomQenypaVVa5UBI2RV0H7rDKlxOBYqXTwg4BD1itz0XjwO9Zi6Mep2XjKfy4Ai0XjRf8S+1kJNCXztLvZQTooPRQvMfgI4nfa+HoPhRt3ScIaudY3s51mOieeOFnEMKNSLqOeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CrjczJg9/TFFUaNnmCJ072R2N2wVMXiFF2eiKF92uJY=;
 b=pdaf3y0KAcnR1Fp0dThOdxvYDdxavpApPSGSYeWmMe1plnZKGGxYbtsR5Fe1FzyqxxojtV8leyqrBJ/OM9KVPmDKyLxyz2ky3w2qic477Rxdrp+l3l++jFxmZ9saFAjF8TznyzWEa9Hvlk4aXefXwQLZCxPQSjxrNRJCu+ADEzw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 LV2PR12MB5943.namprd12.prod.outlook.com (2603:10b6:408:170::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.13; Wed, 22 Oct 2025 13:19:09 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%6]) with mapi id 15.20.9228.016; Wed, 22 Oct 2025
 13:19:08 +0000
Date: Wed, 22 Oct 2025 09:19:04 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	Filip Barczyk <filip.barczyk@pico.net>
Subject: Re: [PATCH 1/2] x86/amd_node: Fix AMD root device caching
Message-ID: <20251022131904.GA7243@yaz-khff2.amd.com>
References: <20250930-fix-amd-root-v1-0-ce28731c349f@amd.com>
 <20250930-fix-amd-root-v1-1-ce28731c349f@amd.com>
 <20251022111342.GNaPi8ZqATfwpja2GR@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022111342.GNaPi8ZqATfwpja2GR@fat_crate.local>
X-ClientProxiedBy: MN2PR08CA0009.namprd08.prod.outlook.com
 (2603:10b6:208:239::14) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|LV2PR12MB5943:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d1850a1-cda4-4cd7-5c28-08de116d94e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pHLglPAJgk1YUouYHMe7bgJeIA4s+y0QLzsnA0O7MxQivEurxleoOxnKacY4?=
 =?us-ascii?Q?AfJmL25a4lE7oYFwfa0V9c7nXpoJTmHGe2scuISzKf34mONMP1DG1HTpVoEQ?=
 =?us-ascii?Q?D9rblPDMyatg11YxfIPky7p8ODP/uuU0WJ6UidQ7jMwI5T+yiGvmNJGFsvc9?=
 =?us-ascii?Q?ajZ/yFi/NaSNEv2asWLJM79rVDjBeK5nDO+6eQDnTeR8mCLnNHTqjnh0Wo3+?=
 =?us-ascii?Q?KWv6mRH9+dfCS/O6c/hUXSa2LpPsWWl7jrGcPfv7tSpW1PMWWLx5pngUmxWu?=
 =?us-ascii?Q?lufnVAYN4bd1wHSMe2nd6+VpX6O2KgeRDgfjR/dAOogDptI7PvvTvXrxI2aI?=
 =?us-ascii?Q?ycCYsplvsEzVAGcJernkkmPmhVOEK8dTYPjcpufcAs8iN3mfYRe1bctf1Ofr?=
 =?us-ascii?Q?1q0ekWmkn55wLpocH1KqHb8BbLqhMy6+Ws8VyODw6xDz/Vva8DRZ07ULIK1J?=
 =?us-ascii?Q?n+2xvtUXVvfv0HTV9LYNriufPTsIEG72S+fP4AgdXHUXNmWT4/UbZWti7wiv?=
 =?us-ascii?Q?tAUKYlPX5hnn0I9r5aokHWvDaeF4NVvx38V34tqEIQwbFY8nb5xBUglrinWF?=
 =?us-ascii?Q?APxiRw9slwp1v9jgElQRkgpAm9oUtWxFCKfjX/HkPz2u0t0/2VE6kewoj5OD?=
 =?us-ascii?Q?k72rnFaMpl0YXihR6KIPdVesDoTI6qmbDZPjByXDc+cHUQVpmcxxei5O2kx+?=
 =?us-ascii?Q?lG0aC6sE6GqpiJEQfp3HpR/W/7NLXkb/bB8qvUOuBBqjyMtolNebGCqTDLHJ?=
 =?us-ascii?Q?UmenQjhwjs4APUWJwPQ4enDhA3htldxEebvuppIN0B2iP4pfqPIHY3Xh7Zzs?=
 =?us-ascii?Q?c/9yyV4tP+EyhTbKvcaYZe5Hzv2BXqDEZ+qT+megGcNlAE16zPl8ZN6dByjX?=
 =?us-ascii?Q?ccORUZ1Gqk6PNkGVooSSCjhL/DLdzePuYJhTKyOyJA/IxiotOtUh3DtYh2RK?=
 =?us-ascii?Q?btVWJywCBUq9CZH2CDydukBAcqtfrBsmsg4Ei6vFZ4psvUE+xViSsmL/rsif?=
 =?us-ascii?Q?pG9MeVFkuHNVqteRO0jd04p1j/T8JmgEshV0xRylupH6iX4sErBg1RjCf230?=
 =?us-ascii?Q?PDNjrOCgExekSPSVFd65bwmfMlblFKTzBVTgx6Cm42wTi66MNxLaSWVG5IOU?=
 =?us-ascii?Q?+bz2e3vI41laFIlp0E5Qk76sr2vzNoVrGFEbJMJu/qP65AuXxhytQJLRXc3X?=
 =?us-ascii?Q?rGceAIs3EmljdCW/CQ6EZNQhrHGfwrTmLYXpKMK4Bnwj0JJVr+kXm5z8EB1a?=
 =?us-ascii?Q?y50+997tRX4d6H2NtFz26nIlKF5nLZ8YBEc6eet7tLStRQokShtyBovquF/C?=
 =?us-ascii?Q?kYrNEOHCA6Vvqqk7cANyn04lQFNMdeN6g7ntpSCxxAJWB1I+1qcFSxhSAfai?=
 =?us-ascii?Q?zZXzqeu5Y4ZPAA37aekqmslHpoO56+TRbi/ExC9p6NhgUhKD0FY3AoFsRrtQ?=
 =?us-ascii?Q?kecAYC3n8TvmOvBLIYXof+ffDn64CnTy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MBYEeXv2WTu0kcUta/KKiysep9C9IgWULLGPLfzx0A10WN/GbnqLm2nbj4Ox?=
 =?us-ascii?Q?dJNY1rl/D2goV8FehBNu5gnko4MForKfMr6/tQg23TkCSbiWZWkBcZtocjlA?=
 =?us-ascii?Q?pmekojr/bWzTny/NEh4mFzZrHHfLmyiCrHD5+hw70OcXXcbRoBNni7Lefy8O?=
 =?us-ascii?Q?veWqlR0BwhuQ9ctiQ9jiFxQh4tsBqYdG3Pr6ihRwdUliUTGsVkB04nK7fTlT?=
 =?us-ascii?Q?F/RaBi8kk4MCSCCB+AnYrq1LrAcf8LB/ziqS7a/U8C74T+8xTfOb57d8BvV+?=
 =?us-ascii?Q?uPbok2lnoG6j32IoHqhJzhb9rMAfqaMJdNLDmYGHFTFI216Q2ocTF0qisRIT?=
 =?us-ascii?Q?Vng4UDJ1zIQWWZWrWUh6v4MCFreukuJg9EqoIT83lUXtRIOWcCwCPEIdLsw9?=
 =?us-ascii?Q?gdKx8sEoIQifqKyME1+uGnsrX7wIsYq50aKsOoUxiTLnAKA0B2jwfU5jmltT?=
 =?us-ascii?Q?9lfOgK7TrPJVuaiJN5dVawc7QtvL4+vDlOk8THb7emuAgsB1oR+P7j+fOyXM?=
 =?us-ascii?Q?Yd1bhwo972kAyiKiRZgi/GNscvsmeg3ZJu7dJ5n3dqwJoO0mdlnzfNWdB8rw?=
 =?us-ascii?Q?qjuyT6ghKbX0MTA5LrDI88ApwvWtCyahmU/67tksPwf+rswdO8p/bOY1mJT1?=
 =?us-ascii?Q?yJ6LY/9WKT2hMpa2hi0YMDY/XrXv1I03CUhzRn1J8qtttUR2Dql84uxo7SLA?=
 =?us-ascii?Q?kSbgtXZMVfQMfrv2VBbuwCsCB3ELfC8c4XGxZFiywbN4ECSMrzTa9NIjqFFG?=
 =?us-ascii?Q?+9VasCB1d8qEF+jIJCVxiHM8oKwk1A3UaajwTAA0SwHIjW2hVtR4+uWfBpDl?=
 =?us-ascii?Q?BVflGJJtKPtDh2uoDatw0cJmwuwNz//RgRdRrG+ZBzWSigDGwb3eLGLIfCAQ?=
 =?us-ascii?Q?TF8Ht9AikBS5M06MIYSNdc50kzcv42U31DSiDvW0bNrnMNdCi4HPSvEbl2F/?=
 =?us-ascii?Q?zKsUszA6QHJnAbd280c9m2WhijKrd7nrG/sQhXRki9eREggHwBPk5FR50EY0?=
 =?us-ascii?Q?AyBC1xZKATccxJCn0YblFNwEyZB4JJuf18bgUwaJ5urVkwNsqNy49ylSIolu?=
 =?us-ascii?Q?HT7OH7ZSotHeFr29zianI12EsFPpy3G/sgov1hYmjj3gqFedgfVGNGl2ZGBz?=
 =?us-ascii?Q?3ij0LVCrydCZ9A3t8E9qiFbaLDkE77XDUXpKPyLrdZSjx0VJm9fJhHNi9jOq?=
 =?us-ascii?Q?4X81ow7GHxlWxTXJCHGv1fl2rdg8yhp1x/rdrKFRUNspbV7hU6ObK+EC+8cI?=
 =?us-ascii?Q?20AJgXMyNz0X5ADg533Jan1wBX4oLaXdycTYPqioXHsoZDcMDFQoHhgIAp/O?=
 =?us-ascii?Q?DLI9GxXhRcdBuJ7uAc03alm/LeTTILv45ZUkKEaEnbj1JIN3vu6RSp+7vVGQ?=
 =?us-ascii?Q?k0V8w2L62Z/1lgMSkQxmcMiuLT7uBK6D0MFRqFytLxYQKB7tSZf1uEMc6PO/?=
 =?us-ascii?Q?eoqTT+LbIh8qXfpDJCcr8tYsE6mSUqHwRScJOahNfxtMeSwHNoWColGxCm4J?=
 =?us-ascii?Q?TA+RJKTP2swsL5UbIippNtseOtndbJg0+FoYIRCIC6seWlAKdPAvkjCp5xVJ?=
 =?us-ascii?Q?FIMFRC9tSCj8dJwhjvW4Z5oD/F5EIo+flLd6Czhp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d1850a1-cda4-4cd7-5c28-08de116d94e7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 13:19:08.3788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bPpAmW8UeS/yJxIvh8BZZ1qJAuhsXNvuV2mc1A9olJZtMGxr+QRHt+j+LNofPNAqRV8MvnWa54fzGmStDnqhoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5943

On Wed, Oct 22, 2025 at 01:13:42PM +0200, Borislav Petkov wrote:
> On Tue, Sep 30, 2025 at 04:45:45PM +0000, Yazen Ghannam wrote:
> > This behavior is benign on AMD reference design boards, since the bus
> > numbers are aligned. This results in a bitwise-OR value matching one of
> > the buses. For example, 0x00 | 0x40 | 0xA0 | 0xE0 = 0xE0.
> > 
> > This behavior breaks on boards where the bus numbers are not exactly
> > aligned. For example, 0x00 | 0x07 | 0xE0 | 0x15 = 0x1F.
> 
> <---
> 
> Please add here something along the lines of:
> 
> "And even if one could say, they both have bus 0x0 containing the root
> devices, this is not true on the other AMD nodes besides 0."
> 

Okay, will do.

> >  static int amd_cache_roots(void)
> >  {
> > -	u16 node, num_nodes = amd_num_nodes();
> > +	u16 count = 0, num_roots = 0, roots_per_node, node = 0, num_nodes = amd_num_nodes();
> > +	struct pci_dev *root = NULL;
> >  
> >  	amd_roots = kcalloc(num_nodes, sizeof(*amd_roots), GFP_KERNEL);
> >  	if (!amd_roots)
> >  		return -ENOMEM;
> >  
> > -	for (node = 0; node < num_nodes; node++)
> > -		amd_roots[node] = amd_node_get_root(node);
> > +	while ((root = get_next_root(root))) {
> > +		pci_dbg(root, "is an AMD root device\n");
> > +		num_roots++;
> > +	}
> > +
> > +	pr_debug("Found %d AMD root devices\n", num_roots);
> > +
> > +	roots_per_node = num_roots / num_nodes;
> 
> What happens if num_roots = 0? IOW, you need to handle that here.

Yes, will do.

> 
> > +
> > +	while ((root = get_next_root(root)) && node < num_nodes) {
> > +		/* Use one root for each node and skip the rest. */
> > +		if (count++ % roots_per_node)
> > +			continue;
> > +
> > +		pci_dbg(root, "is root for AMD node %u\n", node);
> > +		amd_roots[node++] = root;
> > +	}
> 
> If I squint my eyes hard enough, I can see you getting rid of the *three*
> while loops here. So please try again.
> 

I don't follow. Do you mean to combine the other loops into this one? Or
that this loop should be expanded into three loops explicitly doing one
thing each?

Thanks,
Yazen

