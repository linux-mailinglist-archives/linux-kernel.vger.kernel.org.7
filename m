Return-Path: <linux-kernel+bounces-741323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBA0B0E2BD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 19:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E1D117B780
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 17:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FBDE27F756;
	Tue, 22 Jul 2025 17:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LqW0ENbv"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53E36AA7
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 17:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753206174; cv=fail; b=FUbllJZtCKkDTqh0dPc8aZcTP3TnNTnNQp95+FUwitA68srcei6LuNydyUYRZya0erGo5fOJCiPBq8qDQDFUlsTbf8t/3BYaeDJLtEpNDP3oIU5AfntiVzbLLxmxrIe9TFWzVHbcnfJLJ96U3rzrPIrRZUvDT119DWDsipSs9x4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753206174; c=relaxed/simple;
	bh=tU00rTS10wg4lIGttKC364LoqeXIOn/CZ7rXCqgqCMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PGLOmH541rt29YTzA7y1NoxBZDF1BU7a2Jvgsm0/Bl2Ktg5VQYRZ+KopNgVtyljz2hb/Y/2UKcM6Rx9I4xvTyBDeJFrPuCYlzAKC97tO1EqjdECjmTohPZ4NDMIDBLx25I4U3sdCingDSsH9t5NYZUVSNY4K5gZznBE024ZPOmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LqW0ENbv; arc=fail smtp.client-ip=40.107.243.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uK0szno05SIul0nIR9tvKdLilUm9kJlgVa6VtkRNyokeaB+czaE6/pKKhQ+yp4pDu+lMJFQB4cg9IKAxLSeifz6bd0ipWbcMMkhRw2wfu0qNhkjXtxlkDj0CvtyXR6T9ogKOfqgBF8N3iecmtkVwMyQH0f4Ho+7uAhANpPWdWpnvL82tmi/L0Mqj26uguNwZgsZVdiS9A57MV0QuDNuCqfW5yevNmCTOSaU/mfUaHbR/gCTQmSrnCy+zUnBt4wSC5INwQk9mV16XhHbnPxFjptY2cP3NLSQEtexAycTUAlQYpPbnEgaT36/c1FeVyBFzd8AHfRzwaGMjft4ecrhYkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NllU4BmxovW1+vZrhd4CzJVJqZHr9398Ci1RK1d8H/4=;
 b=oieX4z2yuFzlcMTms7LaXsH3P0ERMBTsABeK8CvDUjhbVafG/ZGwnPlxCqnZuRbNtm0d4jGOIKCyhwwp3WfGzfwrKMgDE0eDClbRKLpL+2tVAv8LQH9zCsauqAy+0T+QZSEhtECqLtmeaU5y/RxgtBE6tRIPwdvdaA8QoM4SUJN2W6wjTtSj0IVTcw/7mQ0RIvMqJ3f9CYlsTtutCj3cduZ+z3XbNlgP/E0ifVZP+PeU8+yU6YcfuwWUy4mwH8zjvnI+9I13Yj9bv1f92lQImGMv3rSn2yWr4Bwx2Tp5Uasl1ARPs4fYjclUA0N2C9rKjJVJmYKpBsZv8b60eISXbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NllU4BmxovW1+vZrhd4CzJVJqZHr9398Ci1RK1d8H/4=;
 b=LqW0ENbvmNfLDDSyNZOxe1gg4jh1ReBN9akWR41a/ctVauGJ3VBgiOxVCDSd7ANONofp1Z2Wdv5dVkoU3KJTv249ggw6jEA0D8/H3lZ0RDLAhpUauYB9mKLxpJDbafNfQLkgEVvDYcQNkt8p0nbELnv+lnQOKEldCoC+SiICoQdzVuUqOzKd6CGvw9iJxGt5/rEKmgzFWtBPwL853+m7xM2yIsD/eDuAZs67U2f+9AwH2UGiVF4TlYLb/X3B6ZpSjRlk3h3QXjUEtCs0H6dkJ5ZgBagsgfNHfn7IO2HxqJoAvKnIS5SVXPglBVeyRyIe24qkI6cLOz6QdNHBpRTmLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SA3PR12MB7782.namprd12.prod.outlook.com (2603:10b6:806:31c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 17:42:50 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8922.037; Tue, 22 Jul 2025
 17:42:50 +0000
From: Zi Yan <ziy@nvidia.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH] MAINTAINERS: add missing files to page alloc section
Date: Tue, 22 Jul 2025 13:42:46 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <F551AD99-F191-453D-8115-F37E0A74EE65@nvidia.com>
In-Reply-To: <20250722174143.147143-1-lorenzo.stoakes@oracle.com>
References: <20250722174143.147143-1-lorenzo.stoakes@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SA1P222CA0084.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:35e::25) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SA3PR12MB7782:EE_
X-MS-Office365-Filtering-Correlation-Id: b1f1da59-814f-4cfd-d5e2-08ddc9472d77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VJotzgJO3fLkD5k2DsOp7t/8YoGN3fG0j7NA/esEopDMhsX40IQ8pAn9Fq9M?=
 =?us-ascii?Q?qECgH4IsW+olmJcPx/MrgwQq96uU6BCEbWiMytD3K41ebqzrfnRa5NgygwTU?=
 =?us-ascii?Q?irRKFbOQT7EKs/TDo1YyHk+iFk6SYqH36x2B1kaRKKrUInHr89RhM0L8DZPx?=
 =?us-ascii?Q?mhyxvNwU+rumz+xRsH2VXBg876Dyd6VextEP0FMHnZOcgaKoo8h6fuz6DsoJ?=
 =?us-ascii?Q?GlTSTFc+YBDyseOqlYuthORuc/S+jhIp5ltTXJq9YMiUBgdde9CCZv196cj2?=
 =?us-ascii?Q?jB5xMXjLfBFKLru6kyAHykAlnRQxTCYCRWNwowV+k1Tdjq6lVxo6TkzWlKuF?=
 =?us-ascii?Q?E5i4N35kgCBXXLReK55oJS6yM7dHaHo5TzVyEXXm+iR6VKT5pRaRlle4+7Kq?=
 =?us-ascii?Q?TAv2VUY+toHRzyFEp+sqAQJx72hzlxF0Nci8dbs70SMU458NV1BHOhg5M/Zn?=
 =?us-ascii?Q?g9H6gsH8Js73iDBpSjEviTDaiGEhJgXQhfvNa0Bi3nd0UIrEbK8q/0/LObsr?=
 =?us-ascii?Q?ZKB3gPv/AxU9v69ld8sEmRHbuQm2DQ3MQDE9ptwGNcR6xU2luYtMs8I68X58?=
 =?us-ascii?Q?H1HE2vaSyM9yA+nG2qOpuh0p4RDibcT/kJDTmjRgbBClSWjN3aYfUb4dz4v6?=
 =?us-ascii?Q?Z/ZrcXsRcxz2j/N7IEcYS9iHEak32A6aGoJgbmyTAZhDr6CO8yc55r06YPeG?=
 =?us-ascii?Q?hCp3wPDUAF5Ka8YzaFDSKcvIjS+TnypCOXEVrtKc5PfFdARb7Vy2siRbygvV?=
 =?us-ascii?Q?BHh6MFEwcL7jdjnMdzLt9Ibd5fuMJa3Zao9Ly/SpAReSm1VZst/uC7oyy3p+?=
 =?us-ascii?Q?4LvUQFE07vqKKkPLQFPm+fpcDKlAYOKLp5EaxT7A6tEAESbuQfDGGCwMJpOS?=
 =?us-ascii?Q?Vw1NP0o562ou6SEHVGxlSN6IuGKp1f19gnI3nIJChiIRxJfdJhHDwAX85MkI?=
 =?us-ascii?Q?9bU45jz9yLcSsj1zkTzJi3yesLP7ArBvhX5Gz76+O7njJ7c097+3d2yF8/kV?=
 =?us-ascii?Q?MF6Wgix0DXOOhz8dC41RQcXw0Uqoqvt7B7K/uRxICqJhQlW5ALqQ/J1l9YnP?=
 =?us-ascii?Q?ma05bXTfibhdfIdwMXEtdp4qtwUhVWkR1bN/uD8/IWFIDqeiowwjy1xs2bso?=
 =?us-ascii?Q?HUntGpxjHTp5ds2zF/Qh1SfyF/EVmlRJ1YAXmL6YPBzSt/Rf3ri/Mu9DNTvu?=
 =?us-ascii?Q?Lh4Mj/b1zGmc574JRvaxdmamY4gvvjnasDj8k5qkqA6LaJru4ID3h1cFsOeo?=
 =?us-ascii?Q?tZA98YJ7gAc5mrG9gD0LGSjXJ2sHYlnFUfB2ohnIBhhx64w4Rnnua/fXihLw?=
 =?us-ascii?Q?6MWoZ1bXfcsoVgCI+wUdZpIErWBE+ZY3wBSp8gdE0d2gJoPmxnWL2/B0a2Hn?=
 =?us-ascii?Q?LOYB1nAYlR5TWoP8gdj9Lr3KNclCxVYE4CJpbi7OkY8scMRjb3juZggbawyd?=
 =?us-ascii?Q?FwIfMPTVi+A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BjEZLsNy2sn8YmfBLxcI1xtMGwYpebWQgQ58+Z0a5uh8tVcWGrbwx3ueuAaW?=
 =?us-ascii?Q?1Z3wlORI604Dea/uJQc1y8mW/huDoc8mBBbR9TzjXsW6TAeXu5tAWdZwpBoa?=
 =?us-ascii?Q?TbefSUonfbj2hG4UvdYBC8Kdc/hp/LCopYX9Pn6j92DGXKy6WWpNL1x1Biux?=
 =?us-ascii?Q?+SPALtXVPIsQwMPTT8CjsamHpOdCJCPAMRXC4wRqmHUZMsrXRWPcAJg89RDx?=
 =?us-ascii?Q?DHRoI1zzqIhgpI7RgM3QivPt/L0aNPLbVG2BakbQlgIqckOnTyPlDJR5BCK3?=
 =?us-ascii?Q?RYEg+o8nKfOGroN+9BUXa/V/yv42HWyo1H6kBcfacts5TfGhRApifwBOwQf0?=
 =?us-ascii?Q?y78cAHcoUVSmUTtvhXzndwep9e990JnETqSANwo47MXY3KSlZlW14wxg02Fa?=
 =?us-ascii?Q?Yi84I3i3u8Bc4XSkE87MJtVGn1kld5zYS/GlD5h84llELWTOYaE9vmNOdV5s?=
 =?us-ascii?Q?tf7U7gp7T1O+6wO5Orumt7kb2+QHMGgKfpZJXCpWVEvjiUxzKpZEHEvL4KH1?=
 =?us-ascii?Q?hmjM2k6XoGZdmaU/otVMQOtLwkQlWyWA4Uo/umxUafz/4N9JvpYjdHvjt9hn?=
 =?us-ascii?Q?jUfrR0RXYMtxlxgdMtYcVNX1e/DYNeWYQAju76wx2hawK4wHvL/xO3HoHr7/?=
 =?us-ascii?Q?11Mei7UA+b8zFPzHoVWebvZvRS7ZKoNfkCJjk3E5zgkDJ8j6ECfUbhCXZJtD?=
 =?us-ascii?Q?4pDnSNReOAnfVtV0us1vXBcGQFABMxKzGuZNxERVjdDhbyLDAZsYk5lwtcZR?=
 =?us-ascii?Q?hg2V0WLSLs3pwn1SRKTSUHYJ1d2+sQRsRPm1uQy8Ll/BCoajz/gl4ZUbkiHx?=
 =?us-ascii?Q?Vgrq4fWRPL7cWtVsbiycNmBaHDV6nWLnKgm1HUMPbemSZGvBCks62Ww4Wlcs?=
 =?us-ascii?Q?3umDgy3ee/EB66fFSvPp3mP/9JN4TJTnPu7gfGJo3PG7rmTym7igc0P8Gg9+?=
 =?us-ascii?Q?STAfP8VxtRMQ12qv6uiR+Gnif3ANVbsPoo/KdVBwsyNbZQkt/dUrFfPjtdSq?=
 =?us-ascii?Q?/h0+Z2kq8pPO+iQQY6pvWXizgkYkGapSDoAP4YRXejpUS5c13HQAeseNqKjI?=
 =?us-ascii?Q?6hfm5hMyJuOuX0NOCKshiVpLaC6VvcnqGFs+NYEtImeFJk7O4f30Y5Ka3Khn?=
 =?us-ascii?Q?1ts/t9Viv2UZCO7G+L1GjF820bML61upmLQYpeu4uA4fHvjxm+i9BoP7sQ33?=
 =?us-ascii?Q?16f7wOEmYbiETHb6+YdCWOMvn8JOZnpPC25R/O6rg/o/8+EnkyV8zDALbgcc?=
 =?us-ascii?Q?67NjpeeB5uG71wAjJH3xzsOMW0Lv2lGQx63pVGg0IDh/bgwlHjhCxAca5FIx?=
 =?us-ascii?Q?Qgaf94NJG4H9qbJ4PSOMAcKycw6rQ/5lVAsMOiDDFl/h3zgvwUXjXv4+hbIM?=
 =?us-ascii?Q?G+Ik1xFqy5V1NeXOf2atqbme3+fR4VuoYAzwexAJ0slmIdtF2iX+OquZBu2X?=
 =?us-ascii?Q?nASgOZCVWIZ2bf+f8XThpa6GtB+smRaC8ZOuSErKw+GCrja4tHF12EJXJkGU?=
 =?us-ascii?Q?xCh4/q2Ewk8X24V8xBxoRGjiY54KGVii3nTEFGgBy17aEhuCgv34FGgsXJPx?=
 =?us-ascii?Q?WC1+iFBmLDJtaj0vPke+2M3IIzjIzvgrXtYgWkhQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1f1da59-814f-4cfd-d5e2-08ddc9472d77
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 17:42:50.0415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o0Bit1J8l2qOG/7JcU+Ttiah5fJQlwajt8WNgWYPmjAZVEQgbqcUhaRQx3UYYr4x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7782

On 22 Jul 2025, at 13:41, Lorenzo Stoakes wrote:

> There are a couple of mm/-specific header files that were accidentally
> missed previously, and some page ref debug code also that ought to live
> here.
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  MAINTAINERS | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 837bc5cd6166..703f176315d5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15879,6 +15879,7 @@ F:	include/linux/gfp.h
>  F:	include/linux/page-isolation.h
>  F:	mm/compaction.c
>  F:	mm/debug_page_alloc.c
> +F:	mm/debug_page_ref.c
>  F:	mm/fail_page_alloc.c
>  F:	mm/page_alloc.c
>  F:	mm/page_ext.c
> @@ -15887,8 +15888,10 @@ F:	mm/page_isolation.c
>  F:	mm/page_owner.c
>  F:	mm/page_poison.c
>  F:	mm/page_reporting.c
> +F:	mm/page_reporting.h
>  F:	mm/show_mem.c
>  F:	mm/shuffle.c
> +F:	mm/shuffle.h
>
>  MEMORY MANAGEMENT - RECLAIM
>  M:	Andrew Morton <akpm@linux-foundation.org>
> -- 
> 2.50.1

Acked-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi

