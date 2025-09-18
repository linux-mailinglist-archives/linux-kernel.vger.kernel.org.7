Return-Path: <linux-kernel+bounces-796959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 119CAB40A0A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 18:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86B8B1BA0C29
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24052322C9A;
	Tue,  2 Sep 2025 16:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UpzLtEkX"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2067.outbound.protection.outlook.com [40.107.102.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AE2305E04
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 16:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756828902; cv=fail; b=dfeJCJJnKsduDnRhEpuSCFS1yVGbb7vQLPbJbygv02KdI2nmg4h7FggaATTex7DVGE6OoxdpUwGeG1+RLWcdL7nFcdpUq1EAiZHbY+/ENjLrR2lNh89U4K1e3BUkrbFKj6qOv8OOBHNLdWivnw0+h3yCSxvnesQ3PJorgK25m0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756828902; c=relaxed/simple;
	bh=WTRhS4wl1ciEkAjxr6V821dhKB8x3Hg/yeRzDVTXbjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HPI8Yiq6uOwqNvHOsEoLJRJnYiNhah3dVjdnif6gU7hysqBqlFeqJ0coc1gm+WbMKxa9MnxVidPHboDL5wHhUQ8a0+ijJAtiujhB6b4dbGHwHKA+0MwL39+uYG+hGIXe3IBze1ZSi0wL81JVtyfvAG/nSkMWMLXno8NtQQ44o5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UpzLtEkX; arc=fail smtp.client-ip=40.107.102.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yEEQzr1NiSdJnLi0THTMyytmpueiQIQAiSffTLO92RyKqLag0QXG82vLHnMCGO+OkDpUez5+Ep7H+EhVF+4ucW16QRsrPrZt7bKOj19LdXehyXya2Ic+uAemqLkjDgtLUZTlJ8dwW/jFkk9kySEI6ptgUQcMkdBw6weZVv9EIolX2vs/ZrzwTGb4GdUdU9rUHP/6x0cZHdjeh+HuG1zjyaJKCElkaH4LAuuOIk7p6sRiu4jicZSOmQdvB5kbmiZXG4MpxzTvw/m36O+dvrrkvKUxpnD6skfCvqCxapOAaAl5D//uu3LxlbwyiJ+5qP4j4QXJuP76sYmcCB1tN0Fr7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qa09wQ1pZGbhXof86rlhq4hgXoKZwPwugWRI/oGgDgg=;
 b=vlFAEV2qq/rjakNjfI7NHXdKEH+gRZqYmV2to5z1J1du22FKD4E/CATzb6Nextcn/O7NKBwaegb0i7p7JeB/OnwjmVJ/Wr5wy2D0bOYQrqtqnhCrUHD0yXETf6kRsMTUdBcHHc+xgmptq3iH9vGSOxBIaLVcPGG+endRqWzEN6SXTnnX2LcMxHz1W6ufhT6Oz1Ovnk6YjJwIOnq3TTTRRU+3tbl7djdxTCbWB4ejhoeQvy9cihwCsn5BxtAonK0GwctMg75qO5ODlBECvrqFOzBLGPZCVdkTAEm0hWvP6jkC6xdnmax2S6HIJV/aVsVSW3OY6zlxFVnDPLk+apiDuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qa09wQ1pZGbhXof86rlhq4hgXoKZwPwugWRI/oGgDgg=;
 b=UpzLtEkX0kyv0j3a3BksBdjrCo91/eJgWTJyPovF99CZdloiJmVFhMYf9Cz3dITVrqUX8FEr+PA6ThI5DbhGYgWwqJ6GhkXZHrJABLv/T9DCEhPztVnWRGLyrXp2aV1I6t+UaQL9iCr/rF7YcP+F5TwxLtyI7EHmQTan5JxzB/wmiEfekENeJV5LKpZuVE4yIrmavAlypuh1tkLnhzKZphutygZ+i/vbruy9Dmo1mPOEzkmC1jY30oR5Fk1retwmTlNOH1Zf9jOFSuoQcwrlo92iSRd0VEwthfgYa6u3Y/UUmIXVbjbNGXIuGrKGtscEeLyoYvAnqf7IOuyabelUHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DS0PR12MB8501.namprd12.prod.outlook.com (2603:10b6:8:15d::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.27; Tue, 2 Sep 2025 16:01:33 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.9073.021; Tue, 2 Sep 2025
 16:01:33 +0000
From: Zi Yan <ziy@nvidia.com>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Minchan Kim <minchan@kernel.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Yosry Ahmed <yosry.ahmed@linux.dev>, Nhat Pham <nphamcs@gmail.com>,
 Chengming Zhou <chengming.zhou@linux.dev>, SeongJae Park <sj@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com
Subject: Re: [PATCH v2] mm: show_mem: show number of zspages in
 show_free_areas
Date: Tue, 02 Sep 2025 12:01:27 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <60FFF867-F92B-4187-8AA5-40A91C3AD4A5@nvidia.com>
In-Reply-To: <20250902-show_mem_zspages-v2-1-545daaa8b410@igalia.com>
References: <20250902-show_mem_zspages-v2-1-545daaa8b410@igalia.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN2PR14CA0013.namprd14.prod.outlook.com
 (2603:10b6:208:23e::18) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DS0PR12MB8501:EE_
X-MS-Office365-Filtering-Correlation-Id: 9165883a-d64b-4e91-e2b6-08ddea39fca9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EOuvTUdMTXnTks/M9G2ZFOp6EYAxT4ux22q1jPEZfqCR3BkY3rRpEPygkUSf?=
 =?us-ascii?Q?HJnxb5E3w+IgGvKMw4jOOxdgc/rNB5yuAVzT2l2aw/hGqGeHg+MiEn982yaV?=
 =?us-ascii?Q?9huIGxHK9RiBrERrr62fj2JhyLd+FFljl2oGG+cquMRIPBCnN9jSS1i2af4T?=
 =?us-ascii?Q?DJpinnsaq63aD673BUDgIgLGlGBLqBvtKckOdkMRbroAxWdzGB4/2zzKHLJk?=
 =?us-ascii?Q?VujhomC6sM+g57uenNmlkmtlctj7Q1BxRGqf0mGLHJDAZOSuQUOddUXrCYrr?=
 =?us-ascii?Q?2+k9LDoUzoRvzWi2cTBKdJ3cAuvIM7QXTF/bDoDhjAsecB6WfpXBWm4/mPij?=
 =?us-ascii?Q?jsc8Q1eJDdgXQbMDEHWcwGkYFdAnm3qIgNTEp7BD39t6JKME01qTbzCV280/?=
 =?us-ascii?Q?F/Y8VbT+dQlrw+EYci++SKYrS7bZqbaJue3EWAaFGTBjYg1QM/1fRTZxiq3o?=
 =?us-ascii?Q?i/SDuKht4KZQ+FFpzCy64yKh7shoGUgxlXbQrwDECnVaY475D1M0ohBfxhSp?=
 =?us-ascii?Q?zfhUv3+lTSaiTC51OC1OAeEU7OnvmDfpmqermOQISBK96kol/XlBL+q3phaL?=
 =?us-ascii?Q?ycud41EVqpDSFoYD7u/BRQBFumAJzo/+HTn6m3suO2TjolEl3AYHeXM3lB7b?=
 =?us-ascii?Q?fCYaa8nZZJUBaox6ZMvEQEZo3CcWD0K8ZfsnYVs3M/Aqz3LZsRh6UdsTZpnU?=
 =?us-ascii?Q?n/xItGaHDhjNkXhZS7UR51nZEn57bDTq8zPmuSS7EHOi1oKUD/tamgzMM9IO?=
 =?us-ascii?Q?f4KulE/dLv1dVXiqELvlHesvFzfxgjDUeIkWF39splBT8EHSSLa5HyRqGGEj?=
 =?us-ascii?Q?iC6lzp9zzP33eDdi4PpSppZg/gdgax1XgHV1+s3+pvz9rQ2myQaGFEbeI/Bs?=
 =?us-ascii?Q?R+hQYIw4cBrRv8kSJ2KQLXMhJJzwjCNbb9lS3JvSbAjeAHcUTNybhAeRLaT/?=
 =?us-ascii?Q?lCQ2ecTZ2XaDk9v0GtIfdxzRB3uRzBKZKQkK1sfoYzTji696WeTn+gEdhHOj?=
 =?us-ascii?Q?8S6mSTgpZ1JvVEiKkATb7BKWkYu5H/jhX9Mv0Qgk2HOUydmkLqWRtMYZBke9?=
 =?us-ascii?Q?tLqdBjy9zlluDIZ8XneTT+0kvm7VUyar/YLYuJIJ/9OaDOCcZtB9Pd+W9gQo?=
 =?us-ascii?Q?2CImwE9Xb6g+qyqLyewRwYvnu9gbxbEwf0+U8iWyRjaRUkobEFwok1rPLg2N?=
 =?us-ascii?Q?q6npNcla0gr/c5VdQVPpanxYhN8k19vHj+4UfXM6l9/9vo+vym9zyN7jVFSv?=
 =?us-ascii?Q?R9FjHGHrOIvjmVCwClELGCeOIQrZM/j3zJ5xObJFDF6n25Xhi9uYf3FxuOiG?=
 =?us-ascii?Q?2JCaHI9dpsrBOXmMzrf5Uc0j/NxQDr4w7lH87xItJ01D5pvBFwXq5KKYZmC8?=
 =?us-ascii?Q?4x+6/JuPNKVgol+WFpaDUU+41f4IFDzmHVHIWi8s6nHnxIS/OjuegXw9tJVm?=
 =?us-ascii?Q?VB97oobHUgY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QTTDKdlQhRcxgsiQU/BA6tclC1Ksd7oKEU2g2d92Ch3TaPw/TAKElZYfjOOm?=
 =?us-ascii?Q?IJXLQbJ7BrCuYoPCKe8lHNqLfzSvwJcCYaPzQe1eqNXtviv3qlhNRqnLCgOh?=
 =?us-ascii?Q?mFaphl+Rf6foSvnARd4VpLJQmFjNfgj7RJla1JS9Eg3EtY1ZmsVkB8fwTKaO?=
 =?us-ascii?Q?1FfD6YgfDcFG+xMTKDTkBPvBs8T0cTpmXItgiwJF6W3uXb2ggR0vPKO4grj4?=
 =?us-ascii?Q?kSoWTdZMA1Sd32muF/qcASg8NvRGsxnuOs+BxUJvEtzn4W4KwojgifXpL0rC?=
 =?us-ascii?Q?s6O+oii6rMaJWfqwWwXLRGBFzsyVwvGN/OHfbH+7FYKhSUlnzn6ji+Nut0aU?=
 =?us-ascii?Q?sxGMCs89fMyM8wTxg+HayYXJKRe94yN4ux7YWhMNygv0d64TMPUDSObU3qTR?=
 =?us-ascii?Q?6X4Y1at/w1NGLK9trNdwt+l/JouG6dXWCwz23sNvKsuPRoiQOSWi4Hp1tb75?=
 =?us-ascii?Q?B1pO2cYLsuX2A19M5DSDLEVOk0AgfPNJ1PxvnK/k3tG7OrZTd+py6I7AlD/Q?=
 =?us-ascii?Q?Pt5t3dtJQ9kSLyOYKEhL8D9zZnnperkec+v3g57E4CRZBjg0IYJTByL9Teeh?=
 =?us-ascii?Q?iAiTGw9swVgoAdO8PTz+SrrBinxo0R4pF0E4HZD6dABX2EeRYjZPpkhD96aq?=
 =?us-ascii?Q?Nt6ZnbF36h8RkdMTJ7XSGIJASiYbdaaRSNBwVIkuYNg2QG1t3tIVJpvDFzSo?=
 =?us-ascii?Q?v8etBdWoTURxkmF5WYzpCs8y2wL3WMQImUaRPhPrPF4jOF9DxyongYjUjNEI?=
 =?us-ascii?Q?nj8QzwyI+9Z00rrCWoLqvIAxMjqs7p1MRblJNl4F385f/WBidWKqyk/bgIle?=
 =?us-ascii?Q?WLjU5/8J4cmNGyiRZIptIHqCKHbLI5sYd+VlZzQsEIz8V0xufQriJYmfAsP/?=
 =?us-ascii?Q?hHYD10eGnmI20DLfG/xeIFS9oEaQ1+0igL0fc4St0If86CsADGjgZIcSrUJD?=
 =?us-ascii?Q?K+QWsYV6SJidXROO6OOPXuSnU4IGYECGl4LBiD7mXlxZlGGXL4/tozB3B3p9?=
 =?us-ascii?Q?aOg9ZpKAZbSQXsbjNE5yLhnUFkiywivJsPFQfbitRwdxv50yCtWSXN72LO4j?=
 =?us-ascii?Q?2PiReDaJ1GyR4wMEpV4pMCPKEHOZngAmCP0SLlPUZMUCX/eA1z2PjdqoyWMW?=
 =?us-ascii?Q?FcbhnZKSmqDXbXZcB8mIwft6I5SwvsOln8SV2CNQ8aeVUxJDYDVocYw8I6jf?=
 =?us-ascii?Q?MmLcDFSDCJ0LTDU+RkVDErWLTHHFV/5tidSWFdESyltJo3WQHjt6FTR76VvJ?=
 =?us-ascii?Q?LEGl601VcOfIFFB4E1v4Riq07bpyTcYe1rDWFnVOLp7TDQxcm6p2WwWnPiT6?=
 =?us-ascii?Q?KWVotfccQuzgVOWa3oqLTu6nGim5S9rmg5zyIfP9HG1BBmhAhNsp+ACjT+Gd?=
 =?us-ascii?Q?u4olSCRv8S+Y9T+rZxkmL3SBbPqFw2m2LcqIQpEs+BgNBb62dJ8Xqz5FxbUZ?=
 =?us-ascii?Q?M8yS+SIcWuy+BDZVJyP8CtczVGSH9vTAscgvbkRFugFH3XUTMsiQy2JxkasQ?=
 =?us-ascii?Q?DRbQ2Y+GXYKkwl/u0Fb8dgIft62qCB2Cl1Molc2iZf9xhQtIYFOpVGw63eok?=
 =?us-ascii?Q?i918I/g7lM76ZiVKQaUsOmX85a6WFJ+fCpOUAiLP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9165883a-d64b-4e91-e2b6-08ddea39fca9
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 16:01:33.2042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V9RBXEtNyIFlVtQBnUu6/LOkTuEHiS3D64CGVLr+xwD3y40QbseXmoAcsjvWnRt0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8501

On 2 Sep 2025, at 8:49, Thadeu Lima de Souza Cascardo wrote:

> When OOM is triggered, it will show where the pages might be for each z=
one.
> When using zram or zswap, it might look like lots of pages are missing.=

> After this patch, zspages are shown as below.
>
> [   48.792859] Node 0 DMA free:2812kB boost:0kB min:60kB low:72kB high:=
84kB reserved_highatomic:0KB free_highatomic:0KB active_anon:0kB inactive=
_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:=
0kB zspages:11160kB present:15992kB managed:15360kB mlocked:0kB bounce:0k=
B free_pcp:0kB local_pcp:0kB free_cma:0kB
> [   48.792962] lowmem_reserve[]: 0 956 956 956 956
> [   48.792988] Node 0 DMA32 free:3512kB boost:0kB min:3912kB low:4888kB=
 high:5864kB reserved_highatomic:0KB free_highatomic:0KB active_anon:0kB =
inactive_anon:28kB active_file:8kB inactive_file:16kB unevictable:0kB wri=
tepending:0kB zspages:916780kB present:1032064kB managed:978944kB mlocked=
:0kB bounce:0kB free_pcp:500kB local_pcp:248kB free_cma:0kB
> [   48.793118] lowmem_reserve[]: 0 0 0 0 0
>
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> ---
> v2:
> - fix build when CONFIG_ZSMALLOC is not enabled
> ---
>  mm/show_mem.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>

Acked-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi

