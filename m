Return-Path: <linux-kernel+bounces-735898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 968C5B094FA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 21:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B12435A0E66
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 19:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B562F7CEE;
	Thu, 17 Jul 2025 19:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SKxKy99v"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90431EE7D5
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 19:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752780438; cv=fail; b=Ty8btFmdEGkEp/OHz8nSi61UEBZesqhGwqOEx1f6AgA2MkgAbFnQmZ+K66pa7FVranxqHi/p3dwm1NcS3rbp3N3BQ2xkiaulbZPUBOcv+iYHkmtFMWXHaiNS4V8EbJ2gGPkgqjY660Kwp29j9oNMpPgv3dm0LGRy9onUfVubleM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752780438; c=relaxed/simple;
	bh=ayXTwvIPpLYObcZ40B6hRL6V/xrUtrooHRXfgQovQtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hVrdFKvCUTW+saCCUjKFg9cDmOn4QQjwTbR8nfxlpm0p2BjJMjcNF11EZv7nztpUPuTQrquu5smXw6pfinhE9Ge3sKY6vtuCYOpCYsmHtGh9bQtQaqqflF/dMsEZLWv8pznbPzzWF+Q7Mue4XX3xhhj3SKDnyXZ3EDYWJLkCZ5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SKxKy99v; arc=fail smtp.client-ip=40.107.223.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RmAtWg4iWyJEagLMBzlkfIMS5E2YqQK85zLlEBHN8lBVhfZg1pP2vDwKljQF8pL8X4FnLwrhyEL/vOZZXkQ7eCfDMa5PJvpsrD3ZbHIlanEppS5I7brY7Mcg4fWJ9dgD/QnjJmt1FMWgA3IVfGgTfVvTnp17r7ZTfI3cAJOj8ev5MAc3wHKJnxF/FDCFBBB5U0VpI2g186ucY0haGuxmjvLLj6Hzq0wIiXfp1N98khWFWXK2kX8BJ2z0u5EBMp8Wet+0UjSt//DsMk36E4xQ3a7Y+sSMDrix45ENqdQ938pMhytDP+hqCZgTghs17rNfRCwCZ3FOEywIY/MMVirebw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hMJ7YiOd+KDBv3p3OzhBgbEKXQo2wxmMbcpA2HAOs7o=;
 b=mRF/qeSfmMLyTQayLvjWBlC0rxhM3jsOb8oWD+SA5MK973TNkUDpEnO8pkoPH1XTy9OANU/gQJvOZgfoFI+2djM7yumbe1tTiBBQQSyzmyc1D4WkH5CxRZrtnKz4hAAhkx3XF8nAI0q71/x0U0m7GrgzOHyYDkzxThPhIBrLsT05ExnoPlFx2MtvTrAs7Bn+zbmOqoirYiyLYqN4xWj5rp4vYY48s4/ARdBN35XaRtPSW3TUOkRvtFdeU6g8VTCkPIhwOBhPy5/EJLzqjwqqTJhHVKJBKJGVG0j/V3se6X0ING6gmlH/s8gxwl49o/weKuiBVRoTQSak+CTqnUwchQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMJ7YiOd+KDBv3p3OzhBgbEKXQo2wxmMbcpA2HAOs7o=;
 b=SKxKy99vtiDr7i5nPRQsIoWs0TKf4+xTEPdoNe4AExa+TNEdIn87pU9UcEZhatK6F2hpTJn7HjXVwtS3izV+o9Pup9qzdp1cF+hqx2SH52JNjxbLVbMpbDcQDwktDvbv4y9rx8RVIQ+Tt96i5ZioZAChNB9fn5Fvrx52BPJROzIvFObio4B1ghVe40SedLF21qoKzlfjQdpZJohUS8HSuqZcdeS/EZ9k75TFYBxJ2gV0noGJiQEtIZIyk5Z5iPRTHIYYHHzvHB/exRrTn26jXD+oZ8ZpFQlDhIlcOOd8hVc3tVKnqF2p5D+IDcDG3avBRYe4Fep29esmzez+1bXFRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CYYPR12MB8921.namprd12.prod.outlook.com (2603:10b6:930:c7::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.30; Thu, 17 Jul 2025 19:27:13 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 19:27:12 +0000
From: Zi Yan <ziy@nvidia.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 Antonio Quartulli <antonio@mandelbit.com>, linux-mm@kvack.org,
 Hugh Dickins <hughd@google.com>, Kirill Shutemov <k.shutemov@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/huge_memory: refactor after-split (page) cache code.
Date: Thu, 17 Jul 2025 15:27:08 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <7CE81DF9-7ACD-4288-A246-BF7A8206CF80@nvidia.com>
In-Reply-To: <57a80de0-c5f8-4fd9-9b4a-fea97fe6c533@suswa.mountain>
References: <20250716171112.3666150-1-ziy@nvidia.com>
 <a479057f-5401-44ea-b3a8-dfd82b826721@lucifer.local>
 <31D32C5B-6719-4E3D-880A-666044C4A48B@nvidia.com>
 <5464ABD7-C4C9-4BEF-9E5E-21F5A18C42D9@nvidia.com>
 <57a80de0-c5f8-4fd9-9b4a-fea97fe6c533@suswa.mountain>
Content-Type: text/plain
X-ClientProxiedBy: MN2PR20CA0016.namprd20.prod.outlook.com
 (2603:10b6:208:e8::29) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CYYPR12MB8921:EE_
X-MS-Office365-Filtering-Correlation-Id: da1b7f61-c470-450a-6ce7-08ddc567ee2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HiY93bbSbCJeO+VO98LR4Kp1yVerBP0XeoHahOgBOvePjxrtNDMRL6sLqGxj?=
 =?us-ascii?Q?CSgckmqDa8/IpTRIj4Oq4yaOtI+qZH+ukbl3yug5Hcl4djZQ878Ekncm9k9D?=
 =?us-ascii?Q?RGHhi8YoxJc57L6nH9X0IPdSRnc/FhAtd2hVsT6prDfV0rJRRmEsJzNwQlMH?=
 =?us-ascii?Q?ItBGSWK5S8OBh1WbukCPDlIfHrd1NTNWZu+9LDM4+covZFCASNXQzOdHrnfL?=
 =?us-ascii?Q?8ADe3xTgfpz3M4rr8TsCeRmeRZmXVT4Opr+YO80JWU0ytwUcrD3Gx7PBJX/r?=
 =?us-ascii?Q?uLJg7enbKow32DMjU+bl38ZfKoCAPIZ7IbnLU6sAFS7uF2tMAgJ823RhPBRC?=
 =?us-ascii?Q?nUp7DpqgBkWBHRVeyYfjDeOaz1ms6r9rhOScz5djBug7pZrQkBNKTvbvHDlA?=
 =?us-ascii?Q?bruY6XiIz0U3VB1GV+pWY9IAPnz9p9UZ0YPP3twTycKvcI7BJxzK/vKfIxrA?=
 =?us-ascii?Q?I8Mz18bSAGMPvXmF/VTP0G2IyvEtc+P9Htb/kLLx+du1v8VmWau16hzXEoGt?=
 =?us-ascii?Q?h779nVpF0/eH3Us7C05dQghxUO0TwyCAGClQXP9NeC+zb8/pDeleZDW+LRcI?=
 =?us-ascii?Q?qwF8Bi/9SwORIwdtiKmxyapQSbEeFSMNp/1LqdVUjLIsTQAaqvfYO2nJNhix?=
 =?us-ascii?Q?vyTNB1RW0CrGIA7MzU/Mn5mcS5pIIjfUo9c/RTKJ3Nz79q1cd+OeTSrnpGPp?=
 =?us-ascii?Q?/6EwZGjN6na7jhb5zRIhKgj1+YPV4clhJHvXFJ+McleayKQV3tbyb5ky6VVO?=
 =?us-ascii?Q?iybV4FZOnBRuPr23jAggqdIpBusBa21Fb2Wk+fRJPNS6uQP8IttepA33ch9V?=
 =?us-ascii?Q?sANqfXIvBRRSRCLykXlz4ZYBV8c5nw0OukNs/4aN3gefUqHAPqQ57zafutXw?=
 =?us-ascii?Q?lrQkO/KpBPearjIFLDUnOak3rE+2nTqhSVUZ7pnr/mODZpDj/+eZbcSJAHh5?=
 =?us-ascii?Q?tBg4bsAzpvdBlCRE2pICflJ4yfWYRBDKmZcD5unZD6oAD4IQrIPxsBpiwk1W?=
 =?us-ascii?Q?noFJ7/P8dJt2kNQaWbl5yTOrugo0+HkmSg7y0EcYGAefWNRFDi+SZoxCENDY?=
 =?us-ascii?Q?/1dsBLEdM4DEa5+mhphQDAjykY3TAcsR68rjY5LTY2sXfKD3hrBqL1jA2e9y?=
 =?us-ascii?Q?Nt3+Ua/r/qMJfB/Mu/0lkke+9OlQ9XVBwr+Y5R4rWhNdYRd1m9gcznse3ouN?=
 =?us-ascii?Q?Pa+fD0j7y2Hj3XOMKfKHahL0/EP70fA5y2Zweuo8LKP0xbYBshzBlF5an4mf?=
 =?us-ascii?Q?Gt148848YW7N/UrFjjhDSIrvGKk4naliNN7lALc72sapIXMEjGm1+Dc599U7?=
 =?us-ascii?Q?tuYHKYAGHLLLqzkDyE3x5SDkUztBiJyGPiugnu9h0lKyItiatzRM4zStqkwX?=
 =?us-ascii?Q?hDB5iVH48zAAYNQ/NaxzzjESLYNJ7nhQQTtiYc/bQKfS2xrJe7ydZFcDv+8t?=
 =?us-ascii?Q?v8PepGh1sjU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Kc98rDVvd9vx4xXJRAf97lOkWG3Z50vYHQWSIc4s0NWOJ156NNHYXqCr3OHA?=
 =?us-ascii?Q?Km5ZjJF6Y9vxM3nAjAC0sDX+nAf3k7Rd7fR8JqQcUcrCDybK1LPXQ8Ey4+qb?=
 =?us-ascii?Q?/nUDJGtdufwH3MFDAMYRYJy5XTZyIg2KTGWfQ8pjcn/PSXVi1MlXeVUyDl4v?=
 =?us-ascii?Q?bjwVsulK3ndPDS7mvajr73fsPBN4tybGcx2XvY10ioo2UX3l2K6pYkfZJBA+?=
 =?us-ascii?Q?7CJ+1+PpSsx3/jH70H0RdsDuccWuuKLemCW+u+s29/MyGV1mhMn6G6pEEydt?=
 =?us-ascii?Q?hv5nh9Nbdph4RdCGZdTx9z1wAVdZbZtWmjcgxolAJPhj0xL8tdOXmUeOrMCm?=
 =?us-ascii?Q?p1hBvYeQJ/aoc+jxHFATzGVHs6/7QGuBEp7OdIPrR5H/q0r7ml/CTWjzDzsH?=
 =?us-ascii?Q?psw14srft3dUdYpKM6G3FslRz38sRWJpstT+GKWvzQVNJ2blj4/ZGOtQdfR9?=
 =?us-ascii?Q?cuIXL/seyjplLak46aaqJZVwS24corZgwsiOCcq0d7tDExv3OguRXlQ5yo7j?=
 =?us-ascii?Q?l8hLLs0vJmIxoc6uuCh3H9nl0BvJjYjrsFRlSdYilpeXEUSrxRyOcfpW6jWy?=
 =?us-ascii?Q?JuLjIgG+UWOx4t62mcWJI723qN1VHWfpLYt7Qe8JSLbYRke0wSLDo1b29LJu?=
 =?us-ascii?Q?ZakEAtMQPgYL45iYO7Axn6KoJy429QhMd9FNcw0uyw4vNi6SyY8Eh5k516sx?=
 =?us-ascii?Q?aCM8nTmMdFmFjwc0yiyTx+kelUCAJqcs855VLByLy5DlnYtSki55ma4EJaK3?=
 =?us-ascii?Q?MtzEPXO8BFhXghdGcsB7njYaxj8UTNefS1pH+QnaqIuOdIIs3z6YntOHJTJD?=
 =?us-ascii?Q?E4P/3I8G49pEBbMPG38S0XLEE3z8hqh+yvQg+CtOnJPTsqh5eBZ5FDEcK1Ia?=
 =?us-ascii?Q?OSUf4yaWlG42ZjXemRcoChrFMPajBCRjEECmIbauZO7Vlczgu+4cJA2QrmuN?=
 =?us-ascii?Q?okofBkphBqE8smvsfcg2zLxDJmKKBNuMxtJN+WAmhe4nfir1BJtzcrqkJBxH?=
 =?us-ascii?Q?7e5QrDzasBB6YblMKjNT36zU5F1wXFvpJbi9EfEFsGYxWs/XfhZDaWtIz2WX?=
 =?us-ascii?Q?pw8S8TxjMhH7mO/wt/mCp0vaCbVZfaG0ZaKENFq8QrVO2ZeYeDXepE4ZmbBD?=
 =?us-ascii?Q?odn4wHJRB3y2+mqWvsHtNXu5GCUfPrrHIY2tqPR0cSP5Q0jYK4L3fB7y/pD+?=
 =?us-ascii?Q?8vAC6R61uaNXHsYlc6NqcklrOhcmECMYU3F5oQl39kxh/htpNRZvnLNEIS2J?=
 =?us-ascii?Q?hRJADBDLHPAA4t3II9+QE9aSAxVdMcsl/q/Q14eWrAzo1xMZv4wzs+qoL9zG?=
 =?us-ascii?Q?jsGOPieiG1pf3ZU7gqhWVSBC5XFmWGSHJi3cDD1XlfvVFW5rf0az+i0qXR8h?=
 =?us-ascii?Q?WGzjqOubs1JaIbuSn6dgEZrnNFtham4XNRqKu81zYhU6qtRi0EGn4ZDZLsEz?=
 =?us-ascii?Q?7gxDUeVZi1ciJaDYPAgscBD9P72VeyaHKfDA8zZeLE+O82vjSb5nTOK0GsSW?=
 =?us-ascii?Q?YvRbOuBcX35nSFIGovd8nuXt3jqbRJGqcCjnf9SZdWAMVVv1mimqv6kta+5a?=
 =?us-ascii?Q?9bHVH86Sd+SRBYKTHYaevelsftIWeLxS90wmh976?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da1b7f61-c470-450a-6ce7-08ddc567ee2b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 19:27:12.5926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CMxrkfaJi/H/XKh6pmZ6vyPPdC4tZ5Ij161aaR+il6eV+Yy614CZux7OwNIfm+6U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8921

On 17 Jul 2025, at 15:22, Dan Carpenter wrote:

> On Thu, Jul 17, 2025 at 11:45:13AM -0400, Zi Yan wrote:
>>
>>>>
>>>> Since we no longer need to make new_folio->index >= end work for anon
>>>> folios, can we drop the end = -1 in the if (is_anon) { ... } branch?
>>>
>>> Sure.
>>
>> A second thought on this one. If I remove end = -1, can static analysis
>> tools understand that end is not used when a folio is anonymous?
>> Probably, I can initialize end to -1 and remove end = -1 in is_anon
>> branch.
>
> Smatch says that "if "mapping" is non-NULL then "end" is initialized"
> and it doesn't trigger a warning.  I don't know how the other checkers
> handle it.

Great. Thank you for running smatch for it.

>
> Btw, the only thing you really have to pay attention to is Clang because
> we treat build warnings as failure.  You're always free to ignore other
> checkers.

Good to know. I will compile my code using clang to get a sense on how
checkers will react to my changes. Thank you for the information.

Best Regards,
Yan, Zi

