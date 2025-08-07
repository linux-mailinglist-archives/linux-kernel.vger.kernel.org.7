Return-Path: <linux-kernel+bounces-759055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D383B1D7C9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 14:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C51B3A5E27
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 12:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8127223F422;
	Thu,  7 Aug 2025 12:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ldw2R7Bb"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA7E23ABB2
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 12:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754569305; cv=fail; b=GtLUw4bmqIiwkN1vAVGAB/MLTLgh2N0uF2x4W93yZr5Bfk+jrBpfZC2unRb7UMuONS+b4m4sXVnD82ae7nXfb4Vrpg9PEtrhf6UaT6X+b/ymEzWicW8Z3c4HgzT1iLa+aYWCH8Z4ydLTPbf24rOFCEiqN9nI7wquVI/dyp1FLgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754569305; c=relaxed/simple;
	bh=IJojZ6kE63g5o31HKPchU4DKGyq7VX5+UJMUeTQTuWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QnDpGXIEU0x6nVdbvr/L3uDpiNyOM5BeM+sSbCZclykhB7wNQc/KZLKxVuceQf9YM3a9UekwwnMvoj7X9h5eFaJZI33ifI5iDXgqg7HoAMPt8OACylQMrTTjcwTIJSUXA46NrrMGllzPFGpUOrIj2bnLmfgHBlhvzX5gGXQB/E0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ldw2R7Bb; arc=fail smtp.client-ip=40.107.94.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SyDs/TdUbrofTb7kV9fj40Wl7iPhfoW4GF6zP2XaRnb+cKXO4aCSdFkZwZfgoDIIRxWVxtb6d7lZJFKJcRDmRvQXcDWQIldTSOC5UIPPXiIBMNO/Iq9AuPQcZWL7nAaz8vi8P0Er5fkbduFL4jh3p9UMQUxQkTnttGowhqSVhrNgd9xiiMp3MTiixGhiwwlHd/L8FC4xGmFtgMwL7ZEEUc5lFeO4wurp0FcF/HqWWQsKYwdom7J827dFYOr9DvLxOkCjPk9VWYcMLHOpsrDVs/KBvL7jElcsWw2NHdxUw8Tw+jQQKj8cMma3TYFQ8rvuSqx52f9O/Oi+nsQfoeR6GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zzueePh+YPKcdxUnwFSn0EWd6nbr2mgK9GGe/+9jDwg=;
 b=Pzv9bIv0Q2/R5QyeKOqBfxlZYnqINU0DbNzQW99VblrR2sYJrzP3vjPN88k/aC1hRdENHVhA2VRTW04bbGlzITwVUXE6dxipDkPCySefmxqm/de9mE306lBa21+89dV0utDG8VsVq/4vzAjUiO7mrwFH6nZfHwxZ0F/KKQRvByobtlhHwxRSr1cYvU4iCFM1Jh0e7FK8ENDLZKCY1fs+23uzNuFxPO//iyagDyYSMvdIEbRxQ7ttHap8bA2JjjjgQkbhBM7dENO1EvBsLfngoYx1U+sAMs3wovkE9NNL9l9vKRgUyCYzzC8fMumqRnQ8Hz4hKmeplMh9x5ZR4oFqQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zzueePh+YPKcdxUnwFSn0EWd6nbr2mgK9GGe/+9jDwg=;
 b=ldw2R7Bb130JXGO8wW8myu06hmE8kEvTTLNefA8APrIV7OhcEYjicuOJctEXJBKLX8wjr/V0nkT3aY/tmHn7DIR0YgYZXbM9aw0NcOENMPmNX+q4pkXBn1ZQbGyMvkAJXT2ggJOpknq1olivs/YAYr/dpBfwJL624LpIjZS0NdmnMqoz7pO3SbhltfugmhB5tAQU4OIbV3ksWRJ7DrOzOckvZllWrfcwS7QV0cpbMy3QJbhnxlDIbiyVDdWZOlRz4b3kUGx8hkUdjP+Rw4yLuqJlxpS3XbO7Gf23dXn3+KQDuUTeUJxO4muRs9I8MP5MK0jhv8dCe06oEkDYfgkwUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DS0PR12MB8416.namprd12.prod.outlook.com (2603:10b6:8:ff::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.18; Thu, 7 Aug 2025 12:21:41 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 12:21:41 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: wang lian <lianux.mm@gmail.com>, akpm@linux-foundation.org,
 broonie@kernel.org, david@redhat.com, lorenzo.stoakes@oracle.com,
 sj@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 brauner@kernel.org, gkwang@linx-info.com, jannh@google.com,
 Liam.Howlett@oracle.com, ludovico.zy.wu@gmail.com, p1ucky0923@gmail.com,
 richard.weiyang@gmail.com, ryncsn@gmail.com, shuah@kernel.org,
 vbabka@suse.cz, zijing.zhang@proton.me
Subject: Re: [PATCH 1/2] selftests/mm: reuse FORCE_READ to replace "asm
 volatile("" : "+r" (XXX));"
Date: Thu, 07 Aug 2025 08:21:38 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <4A8C53B9-694C-4313-BB65-A406AABD6B8B@nvidia.com>
In-Reply-To: <20250807131611.430a097a@pumpkin>
References: <20250717131857.59909-1-lianux.mm@gmail.com>
 <20250717131857.59909-2-lianux.mm@gmail.com>
 <22169C82-5701-4ABB-811F-075D22CE6FCD@nvidia.com>
 <20250807131611.430a097a@pumpkin>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BN9PR03CA0501.namprd03.prod.outlook.com
 (2603:10b6:408:130::26) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DS0PR12MB8416:EE_
X-MS-Office365-Filtering-Correlation-Id: 74316815-dc2b-43df-701c-08ddd5acf70e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FAU7qGPJYrcqVRWCSuX1s/C6JapUph9JYSxR2NZ/tKxxEK6kk5nv4E36yFoy?=
 =?us-ascii?Q?CfIHsT+DnGDeukpZ1ko2PCdURq88v8KRDkx6N1N5R+EXz2jf0XnhNBaVgKuU?=
 =?us-ascii?Q?eEHcWjC1hoTjQ5/HZPf+pF+Q8XE6WhFmq5Cb5kWg9VKjJbfWYf5/ek6KNObJ?=
 =?us-ascii?Q?jF8AgFpNQXnCnyaTa22he6ziLuFzkIXWO713em4q3BZ38a6wHEsmdPgHbnc+?=
 =?us-ascii?Q?OXX/qBGY2iR9gmqGzkk+XbM6vmINCAPzPtdHDDN70e44OVZvD0MUYJBlXYz5?=
 =?us-ascii?Q?SHG0ouHFgLumKhQn6DvsdM4Kh4Y8KsbYSKbyaClXvTJp4hXmvKJQoUrFU8J8?=
 =?us-ascii?Q?HrSsKO8G7xsOuy6/iWH9LaVJ/osSjcpFYPfEykPJYA7V37/fWTenBB5TVdbm?=
 =?us-ascii?Q?bEp3AeJDqYiXh5BSRJxSJroWhknFcUkWWtmzeNm+2T66dV6jjdRM0qrQjyoa?=
 =?us-ascii?Q?+LQ5pJDduzcT7xwcIYdhFt7WTR+XPDQi2VV+r080WwQbmSlfBCUQMsDmAok3?=
 =?us-ascii?Q?/yo/9CAdbTWPq2HyV+lUGSo9VmWqAxFUcKVuGdWd/VGzwLiF/dDCavGuastl?=
 =?us-ascii?Q?AUgHMbri8qQpqW/e6tcZlcq2gi8B/Xm409iKCxrP3BcRFUB37wbMHevGmp3r?=
 =?us-ascii?Q?u2ZGX7HmXHvZ68AURWPHgHAsj2ux8bjwhxUhJURmo4Hj94wrZGVtgNhjnORS?=
 =?us-ascii?Q?bOANCQ/UUTcLRD+ldPvHI9T3cN4sF7Cto/YGCUEXw3c/uBpYgQhiNrygiIRM?=
 =?us-ascii?Q?IY4vKaCFqbIO32AO8TsJZdU6t6dBpOJrrtvvSXJPTEC+msuEO/pVObH3S7hg?=
 =?us-ascii?Q?fOTwSioWdRHkyN65RDrVisdKiY7LzTbqVbuyGAVPPfLRAEN8TvuwrUeKw1E4?=
 =?us-ascii?Q?7P0zGkPMbGQ9sso+KqxSM36XmCPawoP30gxNAV6R3k7Sa/Z1u9cJAOdRZDKQ?=
 =?us-ascii?Q?NPz7TP/AKZgtHsQxfWkbbzqdsNZ7MAnvMGI83izXbxKVTTnlB334AvIXqrms?=
 =?us-ascii?Q?FRm371pboOxHm+xvl7A0dMQM5SIiArf4Trr5IzWiIGKAbl/ON7XY9LzTYmbr?=
 =?us-ascii?Q?ctN9QfRipDqqQJWwUL1EmEfJp3PQUv0e3ZKPWBHsoEy5j+N06zF8dqHXwRe+?=
 =?us-ascii?Q?RAh35viBTvaIm+wfZlnvCS2amsAxupmVQ5zEiDMAcy68sIB7a1RdXdK3HsM3?=
 =?us-ascii?Q?HM67l14yZ1G7EilEIlkNlHCgwsjFlkDAxdSJgja/SwHPhfBtbFHDZ1QqZOOw?=
 =?us-ascii?Q?9S148fcZ52e/kAoMWPwNP7P3haxIhIaMOaQcSiCAnkMBvDx/zQsADUQywA/1?=
 =?us-ascii?Q?E/JgH8kbEks/WoCfLSIQN/QWM532FcVt1F6IYc+Tbql5V5EdUJGP4FVjM8F7?=
 =?us-ascii?Q?mtZhHZJoWDWJiTmINKIRVOSjHUelgljKb+SvO5LVMUm/G/CXOA/ol6gcOl92?=
 =?us-ascii?Q?DYGyht90m98=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dbtQ83VJWN9XJEbssQN54ofFAjguAV7BihmGDGYsfHYUbwe/Cx05adatLYrv?=
 =?us-ascii?Q?cM0HmwRM5wbGZSlK2hKGKwARTzCB6iIiKKcIqhPWLCop9ps+tpuFmphDXUAs?=
 =?us-ascii?Q?uPSSvMvs5gR3sdazAyO77jAWZD32eZW9Zsr2AjUhOGussu5EtbEZVSyqQ8HI?=
 =?us-ascii?Q?3yZ5dpnn+gLSwE30uNAfrT/ieZC7QCxMK+JAHZEFCmjDSSZA0bprQlAqLMNq?=
 =?us-ascii?Q?Iu5IhLoCayBChgJlde0880izvVGcA0Jekaa9ajHMpmNia+uLRy1bij/eqVsW?=
 =?us-ascii?Q?0t+IKdSOdWV0ZJanw5w7iNgQ15ea6xo9cU48zenFCxBQ6eFpyEudEWq4XRSi?=
 =?us-ascii?Q?O9Hv81FYg/WTBqzoUV2K6vbt+upSTvd3btziCLsh9idK1jdyaOlv0k6xbtbc?=
 =?us-ascii?Q?lQsjXashCTgBloSN+QFqz5A0kluJ+aSWb5hskk1msgqph+hqRlTo6qwz/3VT?=
 =?us-ascii?Q?upexey+vTFrDlbGzqSIilJ95jzP7tXGRM6FKDsumnSzg07fubzvW0nn1mNTz?=
 =?us-ascii?Q?TtAUZ1SGCGmlR9yK6OI9r3qXSEyemUKVnlUZ8cM7Q6DdRQOI41ysvZ7F5U6d?=
 =?us-ascii?Q?UmRrsFns+6iB1eBHI8D2m2JAa8AaB9V3VKHYRi++h6u9xoitPTacpkMrTPPe?=
 =?us-ascii?Q?CDMyrjjUbgreOI3L/Q6/v997OBF1RZZe3fmPGOxparPXSk3IiWU9Foy4s5yl?=
 =?us-ascii?Q?sQmOA2qAqUJtez/NO2dzEv2FOoUNlENjpnQe2HywhpFgNqDWixmhd3vc3An1?=
 =?us-ascii?Q?eArXKgQonjOTvPCAIc9nhjojUivEZD+g/xSPI+iTGH7dHdm4Gaxw74iTn9lj?=
 =?us-ascii?Q?HVKUCAb5T6uwcLReyBbFAQMxCJ0JeWhFImsfTIc1eob3kD3lxDTfGKQDDkdj?=
 =?us-ascii?Q?MJacqVcFf2074/nQo0xvsSuquXCadH0Wy/SqsX+f+vpcuQ8UaOS3zrRRD/nd?=
 =?us-ascii?Q?AsV0k18sqx/lZOOtBoLxO/E0mYvImQgeRgjoxcV134UHhVTDQrX5PdIbe84J?=
 =?us-ascii?Q?uE+T5nI+g7eLy8XCT9ewVY2AzB1DTsbqx0pNMi4oGiZMN21dxmjKzd6EbSzP?=
 =?us-ascii?Q?bxPhU7l0wjRDf21JWk8LCR9Q1qETV+xu/auTkxbKbLE4RHOEMxXAKMGcYtWV?=
 =?us-ascii?Q?8mTcUkl5+s1FtaFNOB0+QEBoXKS1L6cPkUmYaeOsIc2znebpVj65l/E2LgX3?=
 =?us-ascii?Q?MjMKVNpPrg2uxaVpyqzcuPdiZz1ETJWgKkKzekOqGEhJkKh0MifjTHcEzucc?=
 =?us-ascii?Q?orN+XsBEPxPmci3ffto2zmy7QGZyJPRNcUd7Z6WUMDwCJx9MajHFJwDpMcio?=
 =?us-ascii?Q?HEy4m9X9Md0EjIIEImxzdjmsZ9knC/oOzvLGnYzLZy76Coxrnid//5v1jvtT?=
 =?us-ascii?Q?bA68o1N63493mo7BXu+OL0lvfQNUjww7eihYkG6eN0oWIFHb7aIdYvHzVnc5?=
 =?us-ascii?Q?jJn/K0QncYZ2v+TvzZGmcoEe7KBC8XJ1+dgGcm5mtXDXRaJ2v9rFqt17Rk0g?=
 =?us-ascii?Q?B5xD/FdJjB93ThM93hsFK52/7yBsSEsv0FR7efVRKCSxF2JbJJ1cFGR0g58+?=
 =?us-ascii?Q?tJGfbE5kdnpw2CV5bCF6TraOREmbTQPupMr0KU5X?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74316815-dc2b-43df-701c-08ddd5acf70e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 12:21:41.4059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ApqHJ7WwkzEae6uOksDkw3aM83qVd+BGJuJVq/LU/4VgZ3OUwBl0ZsaAfPZ8Cpv+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8416

On 7 Aug 2025, at 8:16, David Laight wrote:

> On Tue, 05 Aug 2025 10:26:17 -0400
> Zi Yan <ziy@nvidia.com> wrote:
>
>> On 17 Jul 2025, at 9:18, wang lian wrote:
>>
>>> Several mm selftests use the `asm volatile("" : "+r" (variable));`
>>> construct to force a read of a variable, preventing the compiler from=

>>> optimizing away the memory access. This idiom is cryptic and duplicat=
ed
>>> across multiple test files.
>>>
>>> Following a suggestion from David[1], this patch refactors this
>>> common pattern into a FORCE_READ() macro
>>>
>>> [1] https://lore.kernel.org/lkml/4a3e0759-caa1-4cfa-bc3f-402593f1eee3=
@redhat.com/
>>>
>>> Signed-off-by: wang lian <lianux.mm@gmail.com>
>>> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>>> ---
>>>  tools/testing/selftests/mm/cow.c              | 30 +++++++++--------=
--
>>>  tools/testing/selftests/mm/guard-regions.c    |  7 -----
>>>  tools/testing/selftests/mm/hugetlb-madvise.c  |  5 +---
>>>  tools/testing/selftests/mm/migration.c        | 13 ++++----
>>>  tools/testing/selftests/mm/pagemap_ioctl.c    |  4 +--
>>>  .../selftests/mm/split_huge_page_test.c       |  4 +--
>>>  tools/testing/selftests/mm/vm_util.h          |  7 +++++
>>>  7 files changed, 31 insertions(+), 39 deletions(-)
>>>
>>
>> <snip>
>>
>>> diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tool=
s/testing/selftests/mm/split_huge_page_test.c
>>> index f0d9c035641d..05de1fc0005b 100644
>>> --- a/tools/testing/selftests/mm/split_huge_page_test.c
>>> +++ b/tools/testing/selftests/mm/split_huge_page_test.c
>>> @@ -399,7 +399,6 @@ int create_pagecache_thp_and_fd(const char *testf=
ile, size_t fd_size, int *fd,
>>>  		char **addr)
>>>  {
>>>  	size_t i;
>>> -	int dummy =3D 0;
>>>  	unsigned char buf[1024];
>>>
>>>  	srand(time(NULL));
>>> @@ -441,8 +440,7 @@ int create_pagecache_thp_and_fd(const char *testf=
ile, size_t fd_size, int *fd,
>>>  	madvise(*addr, fd_size, MADV_HUGEPAGE);
>>>
>>>  	for (size_t i =3D 0; i < fd_size; i++)
>>> -		dummy +=3D *(*addr + i);
>>> -	asm volatile("" : "+r" (dummy));
>>> +		FORCE_READ((*addr + i));
>>
>> I encountered a segfault when running the test on x86_64.
>> i is 4194297 and fd_size is 4194304.
>> It seems that FORCE_READ() is reading (*addr + i) in 8 byte size
>> and i is only 7 bytes away from the end of the memory address.
>> This led to segfault.
>>
>> (*(volatile char*)(*addr + i)); works fine.
>>
>> Both gcc-12 and gcc-14 have the issue.
>
> The definition of FORCE_READ in 6.16 is:
> #define FORCE_READ(x) (*(volatile typeof(x) *)x)
> this is clearly bogus.
> 'x' is a pointer - follow it through.
> Possibly:
> #define FORCE_READ(x) (*(volatile typeof(*(x)) *)(x))
> is better,
> But why not use READ_ONCE(*addr[i]) ?

Yeah, that is my fix to this:
https://lore.kernel.org/linux-mm/20250805175140.241656-1-ziy@nvidia.com/


>
>>
>>>
>>>  	if (!check_huge_file(*addr, fd_size / pmd_pagesize, pmd_pagesize)) =
{
>>>  		ksft_print_msg("No large pagecache folio generated, please provide=
 a filesystem supporting large folio\n");
>>> diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/sel=
ftests/mm/vm_util.h
>>> index 2b154c287591..c20298ae98ea  100644
>>> --- a/tools/testing/selftests/mm/vm_util.h
>>> +++ b/tools/testing/selftests/mm/vm_util.h
>>> @@ -18,6 +18,13 @@
>>>  #define PM_SWAP                       BIT_ULL(62)
>>>  #define PM_PRESENT                    BIT_ULL(63)
>>>
>>> +/*
>>> + * Ignore the checkpatch warning, we must read from x but don't want=
 to do
>>> + * anything with it in order to trigger a read page fault. We theref=
ore must use
>>> + * volatile to stop the compiler from optimising this away.
>>> + */
>>> +#define FORCE_READ(x) (*(volatile typeof(x) *)x)
>>> +
>>
>> Also, look at FORCE_READ again, it converts x to a pointer to x and
>> deferences x as a point. It does not seem right to me.
>>
>> Best Regards,
>> Yan, Zi
>>


--
Best Regards,
Yan, Zi

