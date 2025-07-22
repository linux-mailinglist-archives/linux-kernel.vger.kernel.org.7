Return-Path: <linux-kernel+bounces-741300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF97B0E28E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 19:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A13111C8541B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 17:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48D527FB03;
	Tue, 22 Jul 2025 17:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EIb6TLQ0"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8950227EC78
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 17:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753205191; cv=fail; b=HKS923GxDGw/6FXhmCCM29Tj4TJswjgBoOzWlwCq/A/ub/P4gT9DClJy29jGBPJuz3UqRaJzQ4Cde96uZicS2BQzGeeP84sqQi3roTrfZWnw8pLf4f8jU+FyrLGLukDYFTP1sXShiudQQ9KjYfN2A7OkI4GO3RDgBSe0yMyyL7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753205191; c=relaxed/simple;
	bh=5RLWPYJHyvpDV0Co/aJZcm65WAkPJL6f449T5DnMCaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JHlhsjKti/lOmDBKlCVlWBM5uoYvCMa/4ZapWXG9EA0yEtgoxs9U2piRBEI3zK/zA/6oWcnH/rN8XK68B4KwGfd+F/cGphFy07jRCo5ffzd1k7/sT8WLJ0+i5cm0Lclk8jyiHeAH4tOoPFrx6acltBBfPl3tVLPC4B29jI71Too=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EIb6TLQ0; arc=fail smtp.client-ip=40.107.243.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BPTija1haEPhHvq//kFz4zuhTIhEJ4jnmFoTjmOZpl7458K6nrRpkz4duZ5iTvsy6L/+EfqXcFO9Vec7YllX2DtesCKFfc7uhEU5EbYWAZu4+k17nXy0kjiyQSIq2BxSzM7VLrtkulpUOxznA8plL+FuBy0eVxgUkSd2yWyPXYNdd7XlbIXBAay7W7SFogb2VklGXMVan//fgJnBnaiPW9mEtIGwc7E7qIbOaf4ll/YjuzS4kde0tLGVGy7qIspUeqWFap98RcikFsL5P7I6la8yGBDC/OnVg7oKjFnZBmo/gTE4s+TbJLvXRDyGkj/k4MLWNRbbaaypmvFJw4ZAJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Ho7mEGzE8qh5/5UFBZ5GGrNFut1RxZgpAxrnn522YI=;
 b=hCrflkPwlf/q3vuMJBJ/lttheMiB8R4gMxyE05JnTznuJ6NB5twxJmSNkOwVEla5yAELMr1pOIcffTXd2qRXDb4+Fwb5OkeKLcCX8uR+j3IEiHLOuVmo7o90RSZPKHiBNa2JAbSxMfV4/Kl4EvrbYIcZ2aRumaPTnvc0vd0RLZBDS1+1LyVAENzeLmILiTjgll20t1GKGNsejFigXu2r/D7VKF5nErOjmRRcxm9QBSk+x4BXiknJWXk1tM3tFYjJurSESTkUyr5RS+vW064nFZNjnxD7hUkjhw4U7PwSZ6LVsbo6/DtEVL9lNewoY+wb9Vw2FG+5JIHugtnH0/Bl+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Ho7mEGzE8qh5/5UFBZ5GGrNFut1RxZgpAxrnn522YI=;
 b=EIb6TLQ0N+M5FjGVUhS1pPrLeTvZQFVTYcvQnXStOAxUI19yIgR1ILYMrvJ6311gXV/ISX56yb2J3PtOhouYXgAEnULqDCPpN7QoguRWof9vmk1F7v5CyZW+svOmDL0u+Ydv6Nawx6v9rQbfWOy5YqryQRSzL8Ktm+ffd/vjxjcAO9zyojlC/EJ+c7KnBlzo7L25g1kCSiIbXvfWvdiMVKg3uA6johXFLFQbqe/alTz8wD1gNMPzwwhAIIxw0RExw5Xp+zZa5MHngbwpTA+Y19+6PiCgR3b03QQmp3dPbgbd8hP7ssZtWN4FlSfPODmtTkIYcRTPE2cR6cmeq09uaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.25; Tue, 22 Jul 2025 17:26:26 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8922.037; Tue, 22 Jul 2025
 17:26:26 +0000
From: Zi Yan <ziy@nvidia.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: add missing mm_slot.h file THP section
Date: Tue, 22 Jul 2025 13:26:21 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <B2E5CD10-E574-4D3D-9C02-FE23800E11B6@nvidia.com>
In-Reply-To: <20250722171904.142306-1-lorenzo.stoakes@oracle.com>
References: <20250722171904.142306-1-lorenzo.stoakes@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SA1P222CA0115.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::24) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|MN2PR12MB4342:EE_
X-MS-Office365-Filtering-Correlation-Id: 20b4de4c-b2dc-49f4-30ee-08ddc944e374
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j6FdoT4qBc18ZqwW2Hh1yADIjZe0kscGr/Ny9+ubOGxNCgaDluJdvTwUOmwC?=
 =?us-ascii?Q?+loz8T27WfA7ilSPIc1L8OWfHNt/v5ESQo2qnW6iXM/qgmSPMnjr2ddSJIbD?=
 =?us-ascii?Q?U2vzgLAliB/uqnptapX6xTOu9pJryEbJ/Bergj/FYmO1ZoXiGajyxU0VCt/g?=
 =?us-ascii?Q?j0u11XdvtjyVPUjuSU+djnktL1lzpp8QZKwsHrMi9nsGqIKHrZxbALaSeQ0h?=
 =?us-ascii?Q?SImmjKQHHYfMtzqF/8nXdSrTdnkJXgUHRKUlF9LGM7lrS/6fzEPJoFVSUYgc?=
 =?us-ascii?Q?W9/anX8vqcC7o188xK87gryuhZtzNc34H92UkKNoIonNobsyONyInnHHCC27?=
 =?us-ascii?Q?x3J/vPhi+lxkHR965nDTfZk582UubBBFb/OxDFfQKId4HvLVVw68sp6AMyxM?=
 =?us-ascii?Q?mbp6GLiQZAgpGCqpL9aROgGmSiJZ0oyResc5nlY0CY97SBGZTlHeoz1jmOco?=
 =?us-ascii?Q?PdVyPY70v71pF0SMBIktnNFsiImRhsrPmev/1RslC1wS5r1crhTZaB/eHE+G?=
 =?us-ascii?Q?4UpQAO7A6Uz40m6pA9BWGao0rAAQmeLV74DzDAs2xsj2vRCHGSsejmhUb5Mp?=
 =?us-ascii?Q?FEqKD9yNvV1LvVM9S5chiOqhxExUS37odqDD23Iu2oumRnwzEBogZ0lIwX9/?=
 =?us-ascii?Q?bph2QcDoYF/DvI76vCAou8HjVeXUMk7j1MDUhplcG/fqfjSwjwaQwuJoMXSE?=
 =?us-ascii?Q?iqPg0tnrnN/wCqSAjX4KR2OTL3ydFRyZOD/ZUUNVvPHYNJ0K7gwTNiR3T7Q5?=
 =?us-ascii?Q?CAldVEhn1qS2DESt9NgjRPfwejiuuggoHCEjGwRLYPFVH8O84hKnxPtdRIWT?=
 =?us-ascii?Q?bEnzrW4yT9FrCpWZSVxPyueFtkjzwR/USrhkFHInmZ5lu/rSSvFPnc2Fn41N?=
 =?us-ascii?Q?xi4iivs2hzVtMe3/zdqflcxK5n+aq3TwppB2xrEY4n8ZkDWTpzDMckzNRwNF?=
 =?us-ascii?Q?B5k/1xn8k2aFZ5sP7QZ39jS3hyi8fA9tsKGHHeI566g3pYW9ZzOZQ0gjKHlN?=
 =?us-ascii?Q?m6U+LfdLiEpWrXIgEOQ5GOcTQpR4Yrya6Qm1Z41f7czeWqnhbBApjOvqbt4O?=
 =?us-ascii?Q?+AHPOTeFQZcxNiDaF3/kUeyJOh8ytm6fnEzT4F7MvSfepR5/5htLVo3rPxd6?=
 =?us-ascii?Q?EWbW8WeY/EfJxlmdVe1dz51c72BFPw5gR6CVhXuXf7YvxFO9Je4jHdpk6vul?=
 =?us-ascii?Q?N4dfy7i31jFkwbJjGE2qlqUFJx3k8ALXrOmWAA+ISxWBrTW26SGm2ZHUqZAB?=
 =?us-ascii?Q?OD2ku1gSpY3dp1d3ZtgTa803+PhmC/BC75BugnKlsr0qwyNQJGyF7RJYODFd?=
 =?us-ascii?Q?bmmqCxWpEH5KhcvnpudLAebv4cshJ9riH8uJLQnGZMBEq78a7Z8csquoUJer?=
 =?us-ascii?Q?M/mbBWyd7ecpnnYJyE4Jqg2MsZxZVzdVG5WgSjtNo1rMqZwpkdocxIU8T66d?=
 =?us-ascii?Q?c+9tDHhir3c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Wc5f4DAhPWfXSLPRM9MRanfgcAZjZC8lWfPMm2WRT2vDuw7V7JiZRbu+m8bO?=
 =?us-ascii?Q?N2xpxfILtYpITX++GnL2vyoXkf2poyUy7v+QYB3hsG/gG2rvInP1wiOpwwZw?=
 =?us-ascii?Q?n7kEiqpmEN4SWxRne/o2gJjMmWNRuVEu6TcjzRHma5HjJj0Q8Wo5OqQJ1y5Y?=
 =?us-ascii?Q?s5qCH8IJLxVxPXFtd71HH5zJD9ovXb+IP/CQLNiIK3LZ1FpPM+iz8aQNfVMs?=
 =?us-ascii?Q?jikzLdI2IynYRz7eIt/n5rDP5Axmr+OfZsLC21Xo02aIFgEl52mBGixgnD19?=
 =?us-ascii?Q?pFKJlbh7kA+nJh7X2UYtbI1KlHrIpCO4u8MhP9211RkCoP00WDWOaPdaf1cC?=
 =?us-ascii?Q?3B3Wr69Jv0mXtRbTY5+XE1Vhr32mwz3IczgxAjfFfM/ba2M/kuUr+zMhLFtu?=
 =?us-ascii?Q?5VmShL815zpkkOVkGTCtchndNUacDbP9iLPOHfOKGlC9jyVC5L3x3ip9W87L?=
 =?us-ascii?Q?Sa9Zv779yDCiOWopmR6KJk6UdLvNU7IrC+kysxKGRqQ9J+DC4NevWITP+VnX?=
 =?us-ascii?Q?A/a6i9w9MZhV/+2fKeVgJSRRcGY1rhXpwi8BBaFdhZuW4QxfEIaMQcpiRABC?=
 =?us-ascii?Q?XOtAXkIN/Pz3C0jbBlveZFzJex6QY03bMufjDRL5aa1/M7sHrX23Kba6eWf8?=
 =?us-ascii?Q?vY0RyuLsjWw/EN+Do0i4BXWg0EX5xB88Q34xuNIZ3kpbSimPtZOe7D5zL1O2?=
 =?us-ascii?Q?YC8e9CaLN18vrNwOegUIWehupcQ1QNYQoui5arJmntZeJn264wbFlpLWkMxy?=
 =?us-ascii?Q?30Ae660Hh5g9WKKySbh0jkJw6DEsqP9zFQNSdIcugM8cannEgNHKZVk9y5bf?=
 =?us-ascii?Q?SYZUqHgl5ENlbvQnCsLwN/ugQy1VMIvdulS2PE3RNyChsrcHBRT0Pe6F542n?=
 =?us-ascii?Q?kZtP5V7IjV4PNE3ofYS6ukUsy3fuajgziexp5/6ehRl7LD4ULAw0zozFAKDW?=
 =?us-ascii?Q?Q1e25f/QKkqmt4Fb9aUablhMYwkJaG996fAQ4bJlK9rmYA0CbO/JuKIpuM2R?=
 =?us-ascii?Q?xGY7Eiu43k6b5TJSDuTZ55GIXscN1XEJgwQmhCC3mrufswGbR8Q0RCydmETa?=
 =?us-ascii?Q?eJSQ+0YM5jWT3M3HF/QPrZrPDwEqEoxSIdKqOktflofeQrAURO0adlzzXjoX?=
 =?us-ascii?Q?SLveS/hWmXTlinl5DQiqmZQ7f3iRe+Ft+R4UVSzgBGM/pCElIny4vQq9Hj9o?=
 =?us-ascii?Q?OeSMzDtoKOcRHWn50GhfSs9IJ0jpNcXtfXax3UCB6lHpPxL+HFM2FImCy+kq?=
 =?us-ascii?Q?Qp9CjSy9uu6e3bQgDHLlsQVzRWa2xhUaKUjP8giftrlqfwglal3dPMVtvA5d?=
 =?us-ascii?Q?/ysbqfZMFYeBvVZhLl6wEkYB14a/fYGsDcpCzDSm02VrXfikrV2Cwa+FtNQV?=
 =?us-ascii?Q?HP9dVGKvMC1Ay8EHLdsuV/ZWld3vpHA/8V+CPfxSbw6OmWpzKlS/il5TE9B/?=
 =?us-ascii?Q?e6JPnYUsdci7miLlNo4rafHwwGTU7Ex8n9uNXjhVg4k4L4xefHIGgrsO38BJ?=
 =?us-ascii?Q?5VwMU/qomsJoyXioyE+pxWWu8Z8GQOZSx+Rko0DY7CflSS4SGeckIyMObf4Q?=
 =?us-ascii?Q?aYJuuXtakhNCfnieilkeS0PvvZLLhg/zgmZT/uHL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20b4de4c-b2dc-49f4-30ee-08ddc944e374
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 17:26:26.8476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IChQHYso/qWMoGazWFqAFnlcqc56W+2FUsXyojjYcRWkxMy703OegzvvGQT9eO4h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4342

On 22 Jul 2025, at 13:19, Lorenzo Stoakes wrote:

> This seems to be the most appropriate place for this file.
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 837bc5cd6166..3f83fb317f51 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15966,6 +15966,7 @@ F:	include/linux/khugepaged.h
>  F:	include/trace/events/huge_memory.h
>  F:	mm/huge_memory.c
>  F:	mm/khugepaged.c
> +F:	mm/mm_slot.h
>  F:	tools/testing/selftests/mm/khugepaged.c
>  F:	tools/testing/selftests/mm/split_huge_page_test.c
>  F:	tools/testing/selftests/mm/transhuge-stress.c
> -- 
> 2.50.1

Acked-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi

