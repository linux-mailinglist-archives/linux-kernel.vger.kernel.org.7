Return-Path: <linux-kernel+bounces-842208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A62BB9384
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 04:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A303A188C19C
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 02:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD37B186E40;
	Sun,  5 Oct 2025 02:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AVF5EfLp"
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013020.outbound.protection.outlook.com [40.107.201.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4F91CD1F
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 02:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759631936; cv=fail; b=NKfaBXvdsHziIxMV4MIohAmDlA7t7qFlcnRrxaIjZKIXpU+MJwR/fBL9p4KXYYMolBKRgDdaYHE4E/pQQqceqfaU36NH37UhOLWQLVFA9vms/sE/SUxBFN8ZLXaCVhHfUuf4Ol6Sk0Qi4eU6PZ9KnweR9eJFOaVH/IXUmOIObzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759631936; c=relaxed/simple;
	bh=m7SFsXQ+lbmj6f5uzzqO20xonDZ7FRQWzNwVdWAp90Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=afWDCUSyNQUz3Rsd21BCZpiWOAoseRpwnHoXWnBJqxsGXuoWST1wRHHy6IUTdChn6OzmqIFM1d0u15mmZUtaF72Xveg3TugP9rVp7kgD3C1tZV3x+KJXaozmLbMscM3dlRIEg7E/IU1xgOY0Mj0hgXRYNvpSjzDLksZQGfRgVv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AVF5EfLp; arc=fail smtp.client-ip=40.107.201.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WW6niIwUkLmhlNBB7NQmDty/dneidZIAUIdaMqOEBC5cF33FOMMr0AwADAt1klMCLU/4yJ4RwytaILBC0931y3ufARQSj2lN5SDt5mL1DgQR3l7g/lpJcgsfpmaNVcfwRZo9N/hUskIPeMn4oJDVjuXxGgzVM00FBaJIC/5HMWzds/ACUb7Q0/XhwVVTqk0puynlXhDe+BBsT+yFsLIsIyPVvw9Cs7DZ5ZNBzz5oRJf84k2h5AAWVNhi7fhvNmy7Elrx5isp+MT93Kn6PIiBHRr+UT9Ni3jDhVDNHQfQ/jxxwmJagWaimXxGWcf2yTaAcvFnXhUmtlIXcgFeBkOynA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m7SFsXQ+lbmj6f5uzzqO20xonDZ7FRQWzNwVdWAp90Q=;
 b=R/yiGq8hLDHsUNoYrIS8ziGS9mNcWuOIYQB7WEWFPPH3tSMdEXgR2CUjiuSoSeCsDKmkLJpPlMY68xZv4aSODnjQ1s6XaGXJsolE0WbJe2TGHW4vtP4oweI3m/DwuhiuLLGBK65KXk9oghWWgKXmh1LQdbSE85/r4c3mG+6MuAvFZmh+ljMeOY0fj5bBI1sBa/PipwLjCnlCa9IHMkSPXhjnlutZ/2i2/pP05pDMjbQ9L2g0QmG0d/av39h/cNl0LOGlpxW+1E6vdrMMy+KQebtBPhRuXaTZCdFaA/RG5qUCMT+dbfkfvyYvW8HBYyFeNCET22u0PaxCLQoXyQxADg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7SFsXQ+lbmj6f5uzzqO20xonDZ7FRQWzNwVdWAp90Q=;
 b=AVF5EfLpatN9aycB9qSLE3vwsUxhF+FcXki18MhuI72v2KVjMk4rHdWDKuZGGbEbuZofisNhsC41lIe5Sf8L+/79tAME65hICkoAmXyGWUxPlQlf/TWhsn+pom/YxeyJi17i0OZXC8oZr+0yQ/Ah2u1CgYaeFetWKheryi32d3oyI8xrDz7+PDaOICXr+p5emIHhLP8IzUsWrdazNA8rMGPM0Ulc+KAhfWNenUVpg7BVcSc8iQbQ8ppqMVqSJVZWakPD9+iMs1/4ZziSN+EKpJJkAcRqM+YMoTMpYzVQZzbzYsOxxRShOu5LXkLxIXuLr3iTIUFCqyKC3onvh8tl6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SJ2PR12MB9162.namprd12.prod.outlook.com (2603:10b6:a03:555::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.18; Sun, 5 Oct 2025 02:38:47 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9182.015; Sun, 5 Oct 2025
 02:38:46 +0000
From: Zi Yan <ziy@nvidia.com>
To: Lance Yang <lance.yang@linux.dev>
Cc: Wei Yang <richard.weiyang@gmail.com>, Dev Jain <dev.jain@arm.com>,
 akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, baohua@kernel.org, ioworker0@gmail.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH mm-new 2/2] mm/khugepaged: merge PTE scanning logic into a
 new helper
Date: Sat, 04 Oct 2025 22:38:44 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <8FF0358E-1ECE-42DA-AE4B-8D5A578450EC@nvidia.com>
In-Reply-To: <054ca3f1-b219-49dc-9c4a-6f648b9df7f1@linux.dev>
References: <20251002073255.14867-1-lance.yang@linux.dev>
 <20251002073255.14867-3-lance.yang@linux.dev>
 <0d55d763-81ff-4b99-bb13-3dbb9af53cdc@arm.com>
 <20251004094217.bah5q2zxczrqontm@master>
 <f235a557-d031-4fcd-8c68-81d9ab7b54e0@arm.com>
 <054ca3f1-b219-49dc-9c4a-6f648b9df7f1@linux.dev>
Content-Type: text/plain
X-ClientProxiedBy: MN2PR10CA0011.namprd10.prod.outlook.com
 (2603:10b6:208:120::24) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SJ2PR12MB9162:EE_
X-MS-Office365-Filtering-Correlation-Id: db273c1d-661f-4ac7-c286-08de03b84eeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3byvHCW0JgPw3i4076RlSUGV6PlkdmNP1ZkPHeTUNHaf3ILhAsbRfRuOeaov?=
 =?us-ascii?Q?as8Wt9iYzrQiHwL3ZBxeszaGyX9rkHZY5HmzuIfU/CLfjW03BSUWCUAGZUce?=
 =?us-ascii?Q?7jRtk3I6BMCnr3OwPnurj7W9csMm5qQnnA8XGHefp3utzKZMSk+KgYXjCEe4?=
 =?us-ascii?Q?vn01AKU1UNYLkoAk3rmmFgTSQ4SAVHsIM2Qq4Lm6fdwhiIKbzIeeWYdDMhUR?=
 =?us-ascii?Q?cOVHtGgNzz24R38IaZXTnVm77u/8mG9VgU2d5/WTHew5veVg9bwIHi9q4G81?=
 =?us-ascii?Q?P0MlvOjAMaMHFInwFlyHxjFp4/ExQhKXBiv7QvPwOv1C3HmyRHlLRnLSNvvE?=
 =?us-ascii?Q?40XKXcPpLyCLcJNoRnBoPqy5gqiUsZHpuVTQ6mOg427MgNkVMWdaFeDU+jke?=
 =?us-ascii?Q?2qBz+jUgXMzw8C2LyUOMWaTPnlPmrJckwKFb6MvqBBhbkvogbo9hKX11M4zz?=
 =?us-ascii?Q?SxZytxTVtdGmF2s06/Kg9eCWX0o2jDvCMg5T5uIz8FdvXfPohwh9UVghsX5r?=
 =?us-ascii?Q?YX6kYs/14XdBy1RqHQSFC0XbU49NLS9ksQCjgd/N51IAOtP+6t0y/PdBdZ3x?=
 =?us-ascii?Q?nKcWAdY7PcVQF5kqFhDF8rpQBT1qLIz8EIrKzD/LF8iyLn1iTv5ZKknsTmiI?=
 =?us-ascii?Q?7sWlZp11O1ohYzk26KIetgry/zQIeUggp5LgaQDj75t5lmrh6J3MKoxfvBgF?=
 =?us-ascii?Q?HGiRIOWcB0fTskTXcKcKD8ejsC9Pc4kRLXboMuTGdwqHwwLKUAe/IT+CJJZ2?=
 =?us-ascii?Q?HUzpvavxtUQ+6TebCD+0Pda4s024TePyvZCue7mcuTpL4hy8qIPjun85xIoN?=
 =?us-ascii?Q?NUNH2mvAy1NT9aTh+AxSujCAiU5sGrCbhQo17fbUsak+I6M2J6gcsi3TZtLW?=
 =?us-ascii?Q?cX0FGUCD/MZkO5heSXkIf04Hm3W6wj2T8BX+5vSDH1ZwehNoU4Vh/C+f69ew?=
 =?us-ascii?Q?WVr27i3l+x6J+oTfn7O0MxM9fG+yLPsxABOEpoCCipCR9DSea5U4DCb8a4Ym?=
 =?us-ascii?Q?A839F3OsfZxxUiY3uHYIP/Ks5h2o4iWRZAYEbntj3a4TAMqkPI3brK/flBdz?=
 =?us-ascii?Q?/Z4tQWY/h3leYjaO7KQ11aJWFhPhsw6q07Pn8pBvtAo3xdBcp2tKR8FIpUho?=
 =?us-ascii?Q?Dd0TobkccJoXu2rp5/fGXfOjqEXpxQ9TkqzAP0etnF5c2+6TQV82RHd/jFIR?=
 =?us-ascii?Q?HXezNZ4mL52F5vE93icRek6ZE/SB8xEMQHVDZkJqBiay4tT7bYBfnM1k6LVY?=
 =?us-ascii?Q?9qZ3KaHgADS35VzsTGKNAZiRP98ifffsBBNAlr24+Dv6e+O/yg+Vw3CJnIHU?=
 =?us-ascii?Q?pCFxwCCsBLHN0Pqz8eYn3L0Xun1Al0U5+FnYNlXMiepxE4bM97p8Yrqwq9Ve?=
 =?us-ascii?Q?JNOc3gkjLi5xsCzJo875yPNLRxyfa/7HHfWsCBeIgeojrHG8JGWY6tw0I4FA?=
 =?us-ascii?Q?0DYYuCLxjMLJGIIRkcs9cpH4QsqYR+vh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SaLZRV6bgzwASy+wfCXVD/PHppp0pxQtnNqsj/uYR5g6bMDiA4zPYdXk6ijQ?=
 =?us-ascii?Q?uwpWxyN0GSoiHCr6uHHZh2aJ2XfksSB/H24bTHwkUAmaPrXkbpCpwHK0rJmJ?=
 =?us-ascii?Q?+0Zh9YGeHmbg7x0X2EgYdTI9oUK7odUFOGCqJvWGyvrdzADV/FSthKaZ9v6H?=
 =?us-ascii?Q?zmXjL7Aa6xG0C0AScWkjrO4U97hlkBl+TY9fGzGh6UsLFZG5nV8l8KyVCORY?=
 =?us-ascii?Q?GB6X1r+o1JZ7+45uXWTo64lRHWlEmi83/adKEocboATioPYZCHCtuumAzyp/?=
 =?us-ascii?Q?FUXRsyXvbQQCzoQanQOENqW7XQqH+FMcA40QqZfpewKcs0CItB55LK/doCDp?=
 =?us-ascii?Q?W5OeumTvyHFrsEB9rdo8YZzPdx6M0BkXozbuiiebD+VWPEZFQZxTKmYQ2AFb?=
 =?us-ascii?Q?bcldrTqLyoD7gM/wK0w8LZBwxGLbOAkwPqQSGXxhta9WxGuhZVUCf5zDLGXL?=
 =?us-ascii?Q?jaOaAJZrVC/B2pcWAmaXjYseEZ4L5ILYKG/63aUjhisFhPhYwf9qN8jAb3FX?=
 =?us-ascii?Q?6DUZ1hJTmoVw25J26jYhkby24ampqzYpAiD8YEqa8W3hBKBboxxGB+3++/mL?=
 =?us-ascii?Q?lqXwsUNPipUfIpDzSDyJ4ljrL/uM4GGk7GSWxjGsMFIuasEIyAo325gXCAIU?=
 =?us-ascii?Q?VlRG57oXBv9efJl+5WA4kfFJZr4CNHoGXXwSG/Djo0+y+RRc3cT1J4bVo2z7?=
 =?us-ascii?Q?Sb4nOTvBwa7bISh2XJqj9qlfH6iDHWILmSa7syeh/KdzsHn1QI0E5lhZbDzI?=
 =?us-ascii?Q?1ThYNl046MEyzC3PYMrOESYpfojfWkdzHz0DCLFAC0UF1armB/l6OV8OJHvQ?=
 =?us-ascii?Q?6adaHkZ8cHEJmaNAYqVy/CTc+/rK5RbGEQeyWKokIOg7klGbYEGR91RJ0+e2?=
 =?us-ascii?Q?btghP8Gy2Zrm7eBT8nWbFg1mCmOjso0T844fdta0sl8JwVvv0UYYU/hD4GzL?=
 =?us-ascii?Q?bXS2hmpfS23AMsFPwMLg9Ww0MWmNtDbYtrJLYKbCAVnRB0PZ9bnNmPaOsexf?=
 =?us-ascii?Q?Mqr0Fd6W8JaL1Qe3+JbZfbwd0Y+DBZiS5bS9Z0LBNTjfW/Pn7w5Q4JI8jzow?=
 =?us-ascii?Q?i7YQCh0vsnitTZAdyZehQtV2LdXdwX6pmvz8l4pzHodAjl57oV/FgzUvR2BU?=
 =?us-ascii?Q?Kix5EATIf0IXZQDaivEdTGs0vnC32P55lySfsBh/o5MQyjQDIh1rpkVRolJ3?=
 =?us-ascii?Q?hB953mVPfxyX0aMSXamFj17fJ/j5XQb9KvPkOGIPg6l0ABiD5ihTJ8pCK/jX?=
 =?us-ascii?Q?jLcrynmLkQH3q7laiIHuZ+HHA9nnG2UgxVkvAMDlhUAte9xd8uJho7aNKAXk?=
 =?us-ascii?Q?KigcxGRkszoF/XZUkFXeWsczr2NFFfBc/ZMYoJSgJvRxrK1ofUXW3suPvVGQ?=
 =?us-ascii?Q?0T8G8Jak3zdeG0WxFlFhtu3WH6/izT+k6+QfyE0kd+VAHgj6neScs5DcQImT?=
 =?us-ascii?Q?PxhckHtICaF5lSruWtxj/6v/da30nN6orpbyluT7DS3vg3jq8i9hKOuAcO4C?=
 =?us-ascii?Q?K6pr6q9Yz5YRJJ7KtZKsMIlpk8iSZUD/6xrNlNt3KZnnttx/z48dTtNbWpg4?=
 =?us-ascii?Q?zjcOKyD1fDDcwVhAiS0I9P8/Iz53iffMaF/vG9fo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db273c1d-661f-4ac7-c286-08de03b84eeb
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2025 02:38:46.8186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y0ZBRSF6Mp6V+DupxeYUgQ3hh4EWkhtjeYcjaNZcTJ6yYL63p42fYVHWSRcJ0Bw5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9162

On 4 Oct 2025, at 22:35, Lance Yang wrote:

> On 2025/10/4 21:11, Dev Jain wrote:
>>
>> On 04/10/25 3:12 pm, Wei Yang wrote:
>>> On Fri, Oct 03, 2025 at 10:35:12PM +0530, Dev Jain wrote:
>>>> On 02/10/25 1:02 pm, Lance Yang wrote:
>>>>> From: Lance Yang <lance.yang@linux.dev>
>>>>>
>>>>> As David suggested, the PTE scanning logic in hpage_collapse_scan_pmd()
>>>>> and __collapse_huge_page_isolate() was almost duplicated.
>>>>>
>>>>> This patch cleans things up by moving all the common PTE checking logic
>>>>> into a new shared helper, thp_collapse_check_pte().
>>>>>
>>>>> Suggested-by: David Hildenbrand <david@redhat.com>
>>>>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
>>>>> ---
>>>> In hpage_collapse_scan_pmd(), we enter with mmap lock held, so for
>>> This is true for the first loop, but we will unlock/lock mmap and revalidate
>>> vma before isolation.
>>>
>>>> an anonymous vma, is it even possible to hit if (! folio_test_anon(folio))?
>>>> In which case we can replace this with VM_BUG_ON_FOLIO and abstract away
>>>> till the folio_maybe_mapped_shared() block?
>>> But it looks still valid, since hugepage_vma_revalidate() will check the vma
>>> is still anonymous vma after grab the mmap lock again.
>>>
>>> My concern is would VM_BUG_ON_FOLIO() be too heavy? How about warn on and
>>> return?
>>
>> Frankly I do not have much opinion on the BUG_ON/WARN_ON debate since I haven't
>> properly understood that, but this BUG_ON is under CONFIG_DEBUG_VM anways. But
>
> Yeah, VM_BUG_ON_FOLIO() is under CONFIG_DEBUG_VM, so it won't affect
> production kernels.

Many distros enable it by default. For mm, we are moving away from
using BUG_ON or VM_BUG_ON. No need to crash the system if it is possible
to handle it gracefully.

>
>> if you want to change this to WARN then you can do it at both places.
>
> It should flag such an impossible condition there during development.
> So, I'd prefer to stick with VM_BUG_ON_FOLIO().
>
> @Wei please let me know if you feel strongly otherwise :)


--
Best Regards,
Yan, Zi

