Return-Path: <linux-kernel+bounces-854901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA55BDFB76
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 18:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 469284E0328
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4681A338F39;
	Wed, 15 Oct 2025 16:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EQy+luZJ"
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010065.outbound.protection.outlook.com [52.101.46.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1986E3376B8;
	Wed, 15 Oct 2025 16:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760546601; cv=fail; b=dBv14PfAltLdkkaY/D2yu0PYEAzY9sCdANpoNrDJ2dN9cosvSd5ejThHfa/+nCLzhtp7fYenSLBnfET5f6Q0Jd7+f7R7k3eMJeoHWMdurExpDpWrPvhgYJM7nUmc1CBEtJnSiCV2lZISE0UjyGMb81LjSfTXVa7GXxSmsQHTS4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760546601; c=relaxed/simple;
	bh=WJoxvcFgu4677mqC8fTGWpBgy1+tg6NZikDoq1bB5ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ru2DH6WXmTruXlcg1SLG3hPQl9mHCEZVWyw/r4rpqGM54ISELacU8j2UaA9YZBOcyRqwkEi0bWwF6XbX2jN+fVZlNunsMR3aMk79ZUK74a0Gz0tC8tO8EkNTjnNmnHvPufCNc4sC/clAz46dSVbcQvKGtMnImbHzjwXmOlG8Spg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EQy+luZJ; arc=fail smtp.client-ip=52.101.46.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e5tQsJLGZkv7wrraGaMANCjofa3VyZvPlN3lB18cwUfe/cWM7WzNOt32VtWd/ATWcd+lIoPAo8jsCZNZrpqEdYcacrq/x4qUkwXOuRU/bbydSePwo6PZJvpPwXPHf6VBVjWv0woDIdwxCsKV+t0uMppKip9wZwFbVW6ZjLRPSdmRthTvOOliDlAUQCffeMN5KY3AwgCJtNGp9n5xsbFlb/ytJFi7YT6auLKMtVNVlvTt5cwDimWBiZVznai+DPN05Myrd4Lvkm48l5iq6p75ZwxsUXdoZVyr5M8sdL4sK05zNVM0hCxRZUX5ot39Tqv3dEWK6+OXog02YYA3czWO4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gWrOxhgpK2v7kzXImNAfkBknTIpmb6IcJHIyFTxyLok=;
 b=wW3iMoUk1hXt6gNQxLU6YlfUipXh8qr3rN837w6BIYZGk6Yl+fTMF+y+0cqR0jWgg2I6/TUcaur/LUMpJHHxovtMs5Z7b+rhCKyskRO5gEFwrOj3n3JYGagfw9NpswMvq7s8SIwA9lFoxC1Cacpo3PLuQ7mZVOh0fONqTvLq1Ji+ykzHzrgu/MW8dJakIty5Gdub7/B6x6e1r4Olc+12VAn7vr9poDYm9kPz7QQ62tSHAO95D8xlwEtuEdcW9tEde0VWxEKFDagRvQDvmeo1XNe/te+AnTC+JKK4QqQDDoy9DVusWO3hg7MurxeXIBQd/bDotRFgw6EEjQVVYtYV4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWrOxhgpK2v7kzXImNAfkBknTIpmb6IcJHIyFTxyLok=;
 b=EQy+luZJwDikXEg0YmF7Sl+LMt/gNe56MN7DnSs/ogu0ba+zNwlXFofbaZtxZPT7SeUqSk3PeroILU9+z+JN1oQiiSF6wwEJXTnT8cst6aM9jk7vDCnqjHTOxG7HbX0h4F6g2Kgu2MWppazMv7G3NQqVHWvu5K+miFTxftWAGeA6WSXeQR36lvxlWjCbNqWlVa5A+syKZ8yRof25i268YaQC8R8y9z+9AyRkdLOX3zuBEZRpuwPCf0ZDldBz1CRiPuhv/mOj+lyLX+4higZgK+yCLuGJW+gMZ5VEIEFht7MSxLRGvcTUlXDs+3vOtNbXShnYyVMp2lsu8S5T2GEuKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by SJ1PR12MB6339.namprd12.prod.outlook.com (2603:10b6:a03:454::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Wed, 15 Oct
 2025 16:43:12 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9228.010; Wed, 15 Oct 2025
 16:43:12 +0000
Date: Wed, 15 Oct 2025 13:43:09 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, David Gow <davidgow@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] docs: admin-guide: update tiny script for number of
 taint flags
Message-ID: <20251015164309.GA3901471@nvidia.com>
References: <20251014031538.764059-1-rdunlap@infradead.org>
 <20251014121403.GX3901471@nvidia.com>
 <3b7f31b9-443a-465c-90ac-5b539852d799@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b7f31b9-443a-465c-90ac-5b539852d799@infradead.org>
X-ClientProxiedBy: BY5PR13CA0012.namprd13.prod.outlook.com
 (2603:10b6:a03:180::25) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|SJ1PR12MB6339:EE_
X-MS-Office365-Filtering-Correlation-Id: 99bac8b5-3878-4f2d-71dc-08de0c09edba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7TLvsCpcxoRawNRsuMnpZZgSlD4AHg+RChcExmIFAWX2FLCYXsCuD8Lo+t5t?=
 =?us-ascii?Q?mxOwMpuI+nV72U/ES5AaByKgRai9cZiJRaxUoetglN6mHdKgMoTkJp4xlz4b?=
 =?us-ascii?Q?ePggZdzXgMMxf3MwBKhRhfjTr3eOUEVjJQPGhBIp4b559ZH0QQehECqdeOf4?=
 =?us-ascii?Q?zxpgCugB30g0fBRMXTtSh3vkZyw0kwvkGo/7LXSNRv9gTDOeH0OkhA9IKodo?=
 =?us-ascii?Q?YtROCjhkeX/6VCEW1gNFhNiEEZkgew8bwFXIeUnPmm7S3jbFKXh6VgAQwvgh?=
 =?us-ascii?Q?y6bpJ9mHjPWBLs+a+v7Bn5TL0FVSyyIkv0uUZoFHxPhkLcTbUxkrVqzo8Rnr?=
 =?us-ascii?Q?421KMeQ6EHIVZp6soN2zSVJk7gSKNx6ZR5KuuupoiGY6B4wZ63/Car8VjuEL?=
 =?us-ascii?Q?sDRFRHpQ4W85yqS3/Cfd+ky01VuFr4PQ+y9tv1yIle2s9KGwSqRSpuErzLsR?=
 =?us-ascii?Q?5WlAw/R351rwH8IgDAE5NlWuoZptLOL58Id1WF2tRxT88yyETd5TmIhDswG3?=
 =?us-ascii?Q?UnK6mgmbOeewSBezVqpiInqMHKRxXjTA9JerU2QHjMNJOXm9I0K5A7EAjJ4k?=
 =?us-ascii?Q?ilmthKjuN3I2z3UnKnJlkcGk1LdvKLghbdmkwC7Rm4oG1wNrvXtABq42CDiY?=
 =?us-ascii?Q?NZlGUMmgWkhnMdABpfnCZ8/+y6eU+NVBkHSGEoqC5iD6foEHD//hEzthyjsF?=
 =?us-ascii?Q?iX3p52eDjigkRxIJz1TqXmfk90n05xUqlF6oGag/G6BcgPvkrJ9nMvVibziC?=
 =?us-ascii?Q?qmoBD++OeZOy3TcY8B5m9PzjkxSloDMzQyYNP57EtPPUMXuSwQiVoP/UJOmS?=
 =?us-ascii?Q?J11ubxudHsuyZ3c/prhCRvbRRXWLyB05YLptSxGfEdB5FJKoB9DB8Ybso37Z?=
 =?us-ascii?Q?yVHxY8UN5+SzamMyMnQ0egAfyxiHylHm78EociReebaUdcshrUzb+e2J3sv6?=
 =?us-ascii?Q?F4v3vqVn1DmTJb34qGrWYc+nOJI+H1iosBxeQ+AFwfS0UXgn5IOuRRXB4kRh?=
 =?us-ascii?Q?mcFxsuKgA+DVaiH9vdgXaxM0Su8fa26aFm/70RzX1Y1Y1pYxPiSXh3krddHL?=
 =?us-ascii?Q?LQjeLwmaWMGdf4Az5Mhvv70T+rDroZnJ6qlGlRlqXEdzRgvsuYgWQ7EztwHW?=
 =?us-ascii?Q?ROmCoQBhhoXydQeBttXnsOcyP6iqcrjtWOLsKWKQTkixngAmF+L6Ed21r44t?=
 =?us-ascii?Q?ADmABcics+MxuDU87nt8DYVPPAdwKglolvC03oDR47naQGKL6H6oFvWkaDy1?=
 =?us-ascii?Q?+cG+hJfyzEVzdV9Ueib2iAzHQdIA8hktnzrjwj1reLeiGgXK9Dwxsu2+3FFb?=
 =?us-ascii?Q?6WcZNkiHSkbLv7qEt7P0JzurVgbctvHv7UtPSdQpdLLzgNPL9ohpKThnBVK+?=
 =?us-ascii?Q?jj82Fwi6z0IPW6Bo7OWRKFOXs2ksRE01JF6LlHb5MRjalqlmVtDvlxVmX1bK?=
 =?us-ascii?Q?pggFX3XFHwM7kto1iARGNuN5s+Qqfkp1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zIVFXq9WaQJMxW6vCXpPVP+oxy+XvFxehN/Gg5ZHLOVSgMcg8Dk5Hv8gK1qo?=
 =?us-ascii?Q?xz2QsGSZ7NTN2DXIQNaXidJlYfPi8a2j7p6vTxapqPS1yKv99MXH9Y5JweOn?=
 =?us-ascii?Q?MzC0Ue8xmFlXrSPWAZ3M4M4s927jpwI5d/jF95jnioHuw3V3kUGMasRiqz2m?=
 =?us-ascii?Q?Na94j0SR15RxcEYl2uJUU+lnA6ASSFlCaZJ5v/5TX67f8Jldpf0zpz7I/aqj?=
 =?us-ascii?Q?iUcTLNENaFKbpV2eZwV07aoznXILuh5z98PVGjDk+8jTISLDyyvZ0hcc0FqZ?=
 =?us-ascii?Q?8HJv0ZuT/snjuJZJcT2ZDUSNfLJbAVxD09hKrNKIWIF/4DuZ2751rMZm0uYo?=
 =?us-ascii?Q?jezcGchBdsYwbVHnfv9XCLntcTkbtERt3ocdMG+ifC5/sLBCpecoQsEF6cwg?=
 =?us-ascii?Q?BzOPvC58TdXu9K4l9usitFbXoHWimAJ1sTj19PruzjbbN5ococBnJiEbiSjM?=
 =?us-ascii?Q?cNiXDzpVFxfx69tKy/HhqCAgCTBmm1wkjbQD7+A4VTN+zibymHBsItYElT3r?=
 =?us-ascii?Q?qnxHigRjOSIF0G2MbN5tDbw69vTqyMqmEXRSdHMIR+SgPM+RdTA5lSH96JPT?=
 =?us-ascii?Q?segvjuFoTEjwLSAL/COKq3ageuAamSeLcQ7e6uMDwIWrXFmBqvtmJ7KkHXl7?=
 =?us-ascii?Q?yGZrz85pJac1jx+Pe1kYDPhz62sTWNqE7OXvYc5kHVfJ0Q9ld01jikLzIw1O?=
 =?us-ascii?Q?3+VLsqrAjcBEJewNRWxQV2KuaUFudg7GlAxIC7MBNWKrn0p6/6K8fYkSxQkT?=
 =?us-ascii?Q?Ny3FEUEQhPmTPrQHSYiS5PAyJPYXawQhVKymzoPFw3IiXC01uYzgrHOQAccQ?=
 =?us-ascii?Q?z2WLmTPwTFUy6chz0SdPP9GgxYcRPJ6fWD70hkVhX+ObvnOR6q80NZsggylN?=
 =?us-ascii?Q?WZBRLRtqrdtwdRyfgleyMmEfTeQenZs0w1FSN8slNbIBASApbc3LVo7TBQRZ?=
 =?us-ascii?Q?BnM4WOkajD9yiPeaX7KuYrswyAZf7S6gO7CRdb1Qx5LYW7F6vDjqz0L65tQF?=
 =?us-ascii?Q?d/9E/ZVMgOSrR9vr6CHDNRS7cU1dYfdhiLG6ObTE26y5deKqAhgzoXDuyF7Z?=
 =?us-ascii?Q?RXBRbJQIXLqqviFgaBvcHa9fEJxjoQoQdXeG7SMFqVzJHVr+/7K7uxQN/yjD?=
 =?us-ascii?Q?35l9TFIBRSQkdkXC/f2NXOaYghHS0D4hT0OB0J/P4t5OhY7kbb4AKoEV/2UA?=
 =?us-ascii?Q?2cNn2DUklLV66MdZzV0IaOj4ymLblxQOaaVusaifHQwlMMbs2DWxpeiFqjdk?=
 =?us-ascii?Q?ZYWahbT9zRFdiVX0c6p2kxZUjfPiqGLj0NvkRbmDwq+kJSQopdrzv+WQXxpR?=
 =?us-ascii?Q?Q45P7FcwxjGI5ipNQKZv98NSBmGmMTDUt3EzWCIYV9VfJWEeIniXDEJiV91O?=
 =?us-ascii?Q?HGwABHzjcpvvrI+zG59xhFapBq7E9YxhRYjKbM3Tjp0rVX0xx3zXntFkkcX/?=
 =?us-ascii?Q?6X1edl5dgvypNDO2VSll38kEXAI/Zns7PD/+UFCS6Mc/lMTp5gS5Zb+Btjm3?=
 =?us-ascii?Q?YmyaeQyVtHqsy++IbT6iFOWA4xKSLLeAMg9w0wo4HLGNm/wbUc8j6e05J/wo?=
 =?us-ascii?Q?1Zi5z4n/OGc4HEF6ULc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99bac8b5-3878-4f2d-71dc-08de0c09edba
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 16:43:11.9041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: urRBK5FOWBG1M4pYfblA2w+BSaDkLCk19YmovPAu5u1WlV2NBuRYphKRe5Bez2DS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6339

On Tue, Oct 14, 2025 at 03:57:15PM -0700, Randy Dunlap wrote:
> 
> 
> On 10/14/25 5:14 AM, Jason Gunthorpe wrote:
> > On Mon, Oct 13, 2025 at 08:15:38PM -0700, Randy Dunlap wrote:
> >> Account for 2 new taint flags being added by increasing the number of
> >> bits handled by the tiny show-tainted-flags example script.
> > 
> > Maybe add a comment near the array about this :\
> 
> Something like this?
> 
> 
> --- linux-next-20251014.orig/kernel/panic.c
> +++ linux-next-20251014/kernel/panic.c
> @@ -638,6 +638,12 @@ EXPORT_SYMBOL(panic);
>  /*
>   * TAINT_FORCED_RMMOD could be a per-module flag but the module
>   * is being removed anyway.
> + *
> + * NOTE: if you modify the taint_flags or TAINT_FLAGS_COUNT,
> + * please also modify tools/debugging/kernel-chktaint and
> + * Documentation/admin-guide/tainted-kernels.rst, including its
> + * small shell script that prints the TAINT_FLAGS_COUNT bits of
> + * /proc/sys/kernel/tainted.
>   */
>  const struct taint_flag taint_flags[TAINT_FLAGS_COUNT] = {
>  	TAINT_FLAG(PROPRIETARY_MODULE,		'P', 'G', true),

Yeah, that looks great

Thanks,
Jason

