Return-Path: <linux-kernel+bounces-745890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC67B1201D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 16:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BE3E3B9C26
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 14:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866FF242D67;
	Fri, 25 Jul 2025 14:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EghiTEm6"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC881F0E26
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 14:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753453665; cv=fail; b=odmP8+eSjMQjJ5kMi5QNFId5FBCrxkSStMHCmgTklCcN0vcOCRgNGSioHgOnf1M1CgoLxnOO7LV09M3k+D3ByShleIK8bGpsC0I/Kka8ipW+qAzdNIrD1U5PRaz4TEwrHKPnYzQhrJyPwDxFfgXmYUSA9QH/QgdVE2x+eWVChtk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753453665; c=relaxed/simple;
	bh=GDleesNkQ9d3+ALkYbXJjk6FXUq5i78yr7LR1BJ3eKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=okQQcZ5qyDCrOonl+8GO4VnuAihp/3sEjx4cD183ufo+/BrOO2XlWR5/IGe2WIH7eyNMiCTutJUJHXqQnCp5PMsE4V0jqFw0N0uJWlSl852EEyDxywoL5PuFmRnIHLjzOfhm3GwLx+zoq/WTlCM71ItrJmamhUlkJVXHCZ2O690=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EghiTEm6; arc=fail smtp.client-ip=40.107.223.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t6xrYp/5Ti77YoXCDZmTmZb3easGqJNfIawtDPz9gn1jEKT6pEk1CyK+D8ahiO8NnLJ0irhU+piLNjN6zTMDzRaXOYPZXIfSVJLlUICouJGJGtJAGnUfknlXs8gh1tLUbqjPIAa7p5UUBDAru53/hB3s3Kw5XWQpXP1Nu58T30MKC8KTE1H6mW9L2Wt5t++b3bX4ME/fI5R4a19XyuiN/k6fc4kbQQZgKB53+05h8fGCgCLAyBUnnX2s2n0FwommhTlmGPlrk1hCw9bKBoqS62K6Ij7iAFVGq8tGfQ6IaIMfRW0f76QGyLRTtVuoBBLad9pOYL+i8CMDZhr8gGlkaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mDjJq/TaZ7G+Vrp5JRrcnZi4KR4rNV2fczy3Y4096/o=;
 b=PknGx92YG35jyWr/C4sGBpYiQ0YYxp6UgWWIMs7bVQPqjEVr7rCIwXc5ztKP3f0vmelt3NzvlOsIcXyaWthxA7iN055GiOaDcFnF2JEqOPiB7c2v3dy1jhDJlKNNGz/Vk34cKPvok69bMEGusTIyFMYoRLLjGzLEeNXXtRd1PYL4MZFGNmQGy193AJZGWksCsiq0vnlOoko7eXL9gLBWz5DjXp7jafGksMktzAr1x5VajkOWHQqiimukprsYkaEaTlspz1js7cGdrlLppVJTEYXBb3sXyOhPFGxdcouYTcZy+9zDfOD18SoE93zmNNjTWalWZWfO0B0aH6+CkoA1CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mDjJq/TaZ7G+Vrp5JRrcnZi4KR4rNV2fczy3Y4096/o=;
 b=EghiTEm6EZTiLvSvZMH7qqnBxbrrMDda+pqI/wU7hELB55bCQlyAyRDVSUJYPT+vtfp9O/71dCb3919vEwA+LGPktd6VH0mrb4mEHRPqiSbbQMn5tGQxA/lHGwi7ZEkOQcPWgxpWjTs2kH5+iHMQxr8FNm1DPraxD5TgIy2ZoCURfINNa0u6uGQfzNIiIsuibjKf4yxuj/gXdwFzQ9aDnJfwtun63mCbOO1c4PC737qMLpak76CHKEE+nQF6kEcDWV4MBHOdBelfkKRQqOI70uKcpphvMp5ltQql3v90fgdG/7vb4jQ5NtTQ1B7jnzEF/iSR9K7VNcgzm03XnGbswg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CY5PR12MB6345.namprd12.prod.outlook.com (2603:10b6:930:22::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.21; Fri, 25 Jul 2025 14:27:39 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8922.037; Fri, 25 Jul 2025
 14:27:38 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: "akash.tyagi" <akash.tyagi@mediatek.com>, akpm@linux-foundation.org,
 vbabka@suse.cz, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, surenb@google.com, mhocko@suse.com,
 jackmanb@google.com, hannes@cmpxchg.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com,
 chinwen.chang@mediatek.com
Subject: Re: [RFC PATCH] mm/page_alloc: Add PCP list for THP CMA
Date: Fri, 25 Jul 2025 10:27:33 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <E70C1648-DDAB-4027-AB07-1C19B10C6AEF@nvidia.com>
In-Reply-To: <c678789a-4fe3-46f0-9cba-9298b55b328a@redhat.com>
References: <67a54f31-e568-427a-8fc8-9791fd34e11b@redhat.com>
 <20250725050810.1164957-1-akash.tyagi@mediatek.com>
 <c678789a-4fe3-46f0-9cba-9298b55b328a@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BY3PR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::25) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CY5PR12MB6345:EE_
X-MS-Office365-Filtering-Correlation-Id: fbd4da72-00e9-4cb4-76de-08ddcb876848
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?B16vuqgELm4d/SdwBZ7PP3IcxHKzH+FAuFrjIXmgesksxPvDRBzbyfVSxxwd?=
 =?us-ascii?Q?vJIwJUvUZTTFO0WRFaHfCU4maOQnlvTkYP2ebEWXyzeqC8KTIQQyMtnHNWWX?=
 =?us-ascii?Q?xwQ3aLMBlXb12n1arpHO8OJNPl1ZChFGStgn/hcMCeCXSQpyastzGPR4XnyD?=
 =?us-ascii?Q?7p68lpiF43XCHyAxVfPwz0Kg49LMuilzPIy6mK16wFgsRUQt5q+UNgMChWvG?=
 =?us-ascii?Q?lIbk9XkTuoUZZIY/Di+w3IsyUS9lH8FS8RCVbXty0TIXU5DrYtpemhAtzUvj?=
 =?us-ascii?Q?MrOhfafJMPY33s6DPNO/YaZp+L5UItckXBz72P3h/JYBPwMITiJlmBXMSY2n?=
 =?us-ascii?Q?DJhNakj6x0b35NOnxCelLYkF1DD7y6CtdxT/hNF0uYNs42KOxOjuYKXRBRtP?=
 =?us-ascii?Q?vrGurwjTwk3QgDYAB/ddkC1vqn47NJnFhY+/KYq5Hr2QpFZJhfn/fxo9nEUA?=
 =?us-ascii?Q?8VTO+6zBGQ8NxJiiyLBuWZ9DzEWJgsH4DAS+9jz+wIDY6dbpFaLOCe4Di6nG?=
 =?us-ascii?Q?hh+COb2kpko2QxLACrVIGd1E4DnwXRhJRbL9DDc+Dk6AmI8Z3zYfpZGNDQ1r?=
 =?us-ascii?Q?zBaOAcKwXiho2AjqAbZCVYuFBy0euHu9oOLolBrKaAfh2P8magjaM4rDRIhk?=
 =?us-ascii?Q?uV8dF2xSGa1DHDsJduJfcUyu+JcIryMVaj9UA3P0+3068CcX1WefBkiT1VkN?=
 =?us-ascii?Q?nUGr+HNRmzApIfUU/t+Ib+676GGisjevEMK/ceCg/STzt4WObuwcOppSXyFy?=
 =?us-ascii?Q?j2nvFaL5HIG+B5Y/A+yUu+/RWyIyT1G1IPsWMpc36mElmLCOVnOFb1Ps0BhY?=
 =?us-ascii?Q?e8xymY/lmcmpxtqbMMMk8cAE6sSYFG4bXxq8fMWVbNhHKZu3637p0WPyv9nl?=
 =?us-ascii?Q?OOQproaFkfMsppCvouW004COdPnlOidCxjto93bV0m77psLq8tV9ZiBhkMc0?=
 =?us-ascii?Q?nkFZ6kCOTlZkAUrKbssFBGT2/uUdLwsxnDl0lv21ISQXYaWWVQ53Py+enbju?=
 =?us-ascii?Q?S6WJWoJhOqQbjbzJKnk7S2nj+OYqekBSIe/i7eLpOrIscFVeaUf6wDkimgaX?=
 =?us-ascii?Q?+el+zYPzOzKEgAJhiCWUY+fYI6r+W4o6eqxgj9AklnYIlYxM6DE7jR9QWy0f?=
 =?us-ascii?Q?noNsb7SyO0HE1CudZTvEiOIyBydR7pMcA+7xWMcvfGbVbMvH/VdsKRCpIeJ9?=
 =?us-ascii?Q?YNlQb+Lu0ioE2ZCdQgM3ZqbwG2UCQqGnr9bz6Y2Ko2MN9Pt7U7epMm6KtCdM?=
 =?us-ascii?Q?BRQ7CkmGlB2tbwp3XBVnrBl7TvEGsTJbcGlOORI6q/4rkGJVNA7PU7lCuO7o?=
 =?us-ascii?Q?6u0W4QqdONtxpVciRIYgRFQ6AsrbwpCgCpiNGrRwnXwffVqonhjJoRttSjBQ?=
 =?us-ascii?Q?m7Ll9zr/stO1FTuwuQPUMc0MWAnFtN9u+RE85bxDijbo314xaGzvMOTJJdg0?=
 =?us-ascii?Q?KLnvUij8ykg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WAi1kW7OX3ij0V5hkkqkUb4k45ymwrXCgrXoKA0JuGkwR5p3v/Rl5FucMdpR?=
 =?us-ascii?Q?yab5CmV4kgzD50aerqnp730J8hQQukBmUE+cP17R1C5PbOMUvIYP7+JfyL2k?=
 =?us-ascii?Q?LKXCG49fDWQ4TXUXYXXjBNRyfQZJwPdHsGIc9F0UERkxP0yGHJ2Fk4021xto?=
 =?us-ascii?Q?eglrh1u6HdKl5sMghEyPDsw/fDCffmcbxycXCkBKKSURmOhPaRCYm0Yamra2?=
 =?us-ascii?Q?4vP/B+Qzp4ol6F+IHJlOtmgIi5lwDhtTFrKC6g5OVX5O9JEn0tjszBx5TCnt?=
 =?us-ascii?Q?85Mms/w5Z5lQKmhZswUFyYeQMQy7iPPoXZOnUp37HoqrQ6K0DrY8TSsBXy/8?=
 =?us-ascii?Q?TKd+nPsayJP67eAJIH4tKOyuB98GxJ7+N3KuDQE1v734xnkHfj1IrMCxScP1?=
 =?us-ascii?Q?17EM8GizeAoW07jAijodX9HSmwRsguyvepfdyO044REaD9p1MWNzZ8tm7W74?=
 =?us-ascii?Q?MunQ1oql0UqhOFAWpw8CLgGeGekH2xKyALMmsdWiusrjzyvQcseF5sttRtq7?=
 =?us-ascii?Q?U3NAeBGNrNU40oCgERj55lsO4Moe7/84iUbSs9OwJ4GiNLZrZMUIwznczz9M?=
 =?us-ascii?Q?xjbiPeBp5ak8b1qMSwViNHgdG2/ZiyV2BQW8FegbMPOzSpXlab0D86yyMjiH?=
 =?us-ascii?Q?I7yqkOiCgHq3dCqZIbqmbdl1QxHeJT9HLHpx1W290jzOInab9WwxKNdFIsBA?=
 =?us-ascii?Q?3Xz+OmmUeFlgLGvviZUyyeAgjMJicOzmNrmIedQ18a8ZaSlzTEnBpXHb3kbZ?=
 =?us-ascii?Q?vvQhQnyxglwJMkj+WhKn8nETsOrKhaKVhqEHhM0NxnmIeHqE9aIsmxCW6shL?=
 =?us-ascii?Q?6XKkbPo2QjPK1RXSLtKXuxGJl9rN5cPsuoSNISJILstDU+cJ+nPh6dMVHWfl?=
 =?us-ascii?Q?Sq9uEfHuT1paukjZNht5hRoEgDsXnX891/VvROqssCRRZzLazqrweGNy6e8b?=
 =?us-ascii?Q?MFgCNCVhNXgAmoqsX4W3GnCAQFf2Y1NuGsQ5/CUVxZt0FJ6WtofKgKmIzKR2?=
 =?us-ascii?Q?E46+Ee/RMvP6QY/IzqHAvQ+ds/NrqTSAxVEMNmzo4+USmu3yM61DoXi3pRsI?=
 =?us-ascii?Q?ftT4hVwxQBxf+bOEfzX/g2pNPWe3p6JLthp+0mknRcRWcNqerpI3YNb9b0qY?=
 =?us-ascii?Q?FbdEtk1NGSBaprhM8XriXAigm+TjU7bL/HytQttjO0r305OFX0x7xdDz1ngA?=
 =?us-ascii?Q?QZTRCSGXqAw4u6rHMk0nkbjU2GM/kOz7fMvaIRk0fJAFBi83Cfsb7lfP88my?=
 =?us-ascii?Q?7vsqwa4ZtVi1V++5cysVPJe+VFD6+foGq5le/vYiOyOzSfDiTrQA8m8TtxOW?=
 =?us-ascii?Q?GaUdWr3edhdUtEDYORCXnaP8ngQyf9tKNDY+cTZyilp1VFeOrF4kPpZynV0l?=
 =?us-ascii?Q?yc4Lorjr+OEi5Cd9yE1qP+i730WpXiloMDDa2UpiTx1Ph1J/96VrKqF8g5UQ?=
 =?us-ascii?Q?SYha8fdYA6c82UE1DXbXmfSWbI7QoP6qksJQVxxncmNPNrFmQ2OlN8C04kgI?=
 =?us-ascii?Q?xgbm6FL/ZJ7m5EIpSa0CRUFTv+IF7L18bbvBSn2+E3sPjLEvdE7iZjHDNj9X?=
 =?us-ascii?Q?ypJpnHVKZo8VKPFkHig=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbd4da72-00e9-4cb4-76de-08ddcb876848
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 14:27:38.9020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o7QOQOD/YgHzVmlz87V3fiTSNQ0IWRWL0fjYomi6WNs2u0jupeInWfgxHdlX10Nx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6345

On 25 Jul 2025, at 3:04, David Hildenbrand wrote:

> On 25.07.25 07:08, akash.tyagi wrote:
>> Hi David,
>>
>> Thank you for your feedback.
>>
>> We encountered this issue in the Android Common Kernel (version 6.12),=
 which uses PCP lists for CMA pages.
>>
>> page_owner trace-
>> Page allocated via order 9, mask 0x52dc0(GFP_KERNEL|__GFP_NOWARN|__GFP=
_NORETRY|__GFP_COMP|__GFP_ZERO), pid 1, tgid 1 (swapper/0), ts 1065952310=
 ns
>> PFN 0x23d200 type Unmovable Block 4585 type CMA Flags 0x40000000000000=
40(head|zone=3D1|kasantag=3D0x0)
>>   post_alloc_hook+0x228/0x230
>>   prep_new_page+0x28/0x148
>>   get_page_from_freelist+0x19d0/0x1a38
>>   __alloc_pages_noprof+0x1b0/0x440
>>   ___kmalloc_large_node+0xb4/0x1ec
>>   __kmalloc_large_node_noprof+0x2c/0xec
>>   __kmalloc_node_noprof+0x39c/0x548
>>   __kvmalloc_node_noprof+0xd8/0x18c
>>   nf_ct_alloc_hashtable+0x64/0x108
>>   nf_nat_init+0x3c/0xf8
>>   do_one_initcall+0x150/0x3c0
>>   do_initcall_level+0xa4/0x15c
>>   do_initcalls+0x70/0xc0
>>   do_basic_setup+0x1c/0x28
>>   kernel_init_freeable+0xcc/0x130
>>   kernel_init+0x20/0x1ac
>>  This UNMOVABLE page was allocated from CMA, but it could not be migra=
ted - so CMA alloc failed
>> At first, we fixed this by adding CMA THP pages to the movable THP PCP=
 list.
>> This fixed the issue of CMA pages being put in the wrong list, but now=
 any movable allocation can use these CMA pages.
>>
>> Later, we saw that a movable allocation used a CMA page and was pinned=
 by __filemap_get_folio(). This page was pinned for too long, and eventua=
lly, CMA allocation failed
>>
>> page_owner trace-
>> Page allocated via order 0, mask 0x140c48(GFP_NOFS|__GFP_COMP|__GFP_HA=
RDWALL|__GFP_MOVABLE), pid 1198, tgid 1194 (ccci_mdinit), ts 17918751965 =
ns
>> PFN 0x207233 type Movable Block 4153 type CMA Flags 0x4020000000008224=
(referenced|lru|workingset|private|zone=3D1|kasantag=3D0x0)
>>   post_alloc_hook+0x23c/0x254
>>   prep_new_page+0x28/0x148
>>   get_page_from_freelist+0x19d8/0x1a40
>>   __alloc_pages_noprof+0x1a8/0x430
>>   __folio_alloc_noprof+0x14/0x5c
>>   __filemap_get_folio+0x1bc/0x430
>>   bdev_getblk+0xd4/0x294
>>   __read_extent_tree_block+0x6c/0x260
>>   ext4_find_extent+0x22c/0x3dc
>>   ext4_ext_map_blocks+0x88/0x173c
>>   ext4_map_query_blocks+0x54/0xe0
>>   ext4_map_blocks+0xf8/0x518
>>   _ext4_get_block+0x70/0x188
>>   ext4_get_block+0x18/0x24
>>   ext4_block_write_begin+0x154/0x62c
>>   ext4_write_begin+0x20c/0x630
>> Page has been migrated, last migrate reason: compaction
>> Charged to memcg /
>>
>>
>> Currently, free_unref_page treats CMA pages as movable. So, some MOVAB=
LE allocations may use these CMA pages and pinned them. Later, when CMA n=
eeds these pages, these pages failed to migrate.
>
>
> MOVABLE allocations commonly fallback to CMA allocations, independent o=
f pcp.
>
> Long-term pinning is forbidden on MIGRATE_CMA pages. We had a bug recen=
tly fixed,
> maybe you ran into that?
>
> See
>
> commit 517f496e1e61bd169d585dab4dd77e7147506322
> Author: David Hildenbrand <david@redhat.com>
> Date:   Wed Jun 11 15:13:14 2025 +0200
>
>     mm/gup: revert "mm: gup: fix infinite loop within __get_longterm_lo=
cked"
>         After commit 1aaf8c122918 ("mm: gup: fix infinite loop within
>     __get_longterm_locked") we are able to longterm pin folios that are=
 not
>     supposed to get longterm pinned, simply because they temporarily ha=
ve the
>     LRU flag cleared (esp.  temporarily isolated).
>         For example, two __get_longterm_locked() callers can race, or
>     __get_longterm_locked() can race with anything else that temporaril=
y
>     isolates folios.
>
> But there is this known problem that CMA can fail temporarily due to
> short-term pinnings. See the "reliable CMA" work (don't remember the ex=
act name).
I think you mean Guaranteed CMA[1].

[1] https://lore.kernel.org/linux-mm/CAJuCfpEWVEqsivd7oTvp4foEho_HaD1XNP8=
KTeKWzG_X2skfGQ@mail.gmail.com/

Best Regards,
Yan, Zi

