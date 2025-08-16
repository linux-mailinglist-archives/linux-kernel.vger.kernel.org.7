Return-Path: <linux-kernel+bounces-771980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC21B28D76
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 13:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49DF95C604D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 11:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7443F28C851;
	Sat, 16 Aug 2025 11:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mApjoGkR"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B90218EB1
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 11:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755344562; cv=fail; b=boGdNA3ugTfzdeSHg5Ir+fKGGrasIRk0P0sRW+vQuH+s45y6jKyBLskqH5pwXeWfewiKyM5ke+SlgaZS4fSD4Cmx8a3EueoupUPtYAzhr4sOZizdkafZ9jPGQXcPeHS48ks0cZ4fbUXK6pbX2zfaft2cjeoK64oOjZtxLmWfOVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755344562; c=relaxed/simple;
	bh=Gf1LofXg5t9I2oIPjSnK5xR27SuYPobfhMHW0wgKv1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GG5lUxCFNKwdubE2Ob+DP89KXmjtZhnN+dqpLeFbmXZnn9fjM9ydCACMSg0UUgJCqg/cL1lFjivBH7e1/qP5uMpIUf90nSU+z/jCC1Kvtg+Ua7zQUVHnN8tz1akhUYwGC1BAEp+DqpoCu0wqJLFInKQXtN4lC9MgsFzXNfniCc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mApjoGkR; arc=fail smtp.client-ip=40.107.237.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U/CbWULcGE5FFKpq6UQMsYXO3bCz0zWGWHQGkFacFPEV299YiWGNTZYwALqKUpqqZ5qpM5aHNPZRbqXuNNuwErU1NlY9NA7J0xe/C03/vM8HIdkC+TivMExxNS5AoZdwBcrUv4WAddYVB9QUVn1s9/0mbovSLggK2kS/aPXLTnUu1k5gOcR322YPKVfJ4t3D/vJnFvH6mYrxP2udBWIRZX6r7xubYyFa2tovniga6Lnj1Xlihqjz1xT0fXi550BJjXCLsnmw5U8wn4Mv4zQJKdy7xc0FgBqr7yLRVqxFNupdDyDkzlmGke5Jsxu/vVljc/Vq2t2cBE3/79DbC6yHzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MV0WIeSObquQJoIJE2mivwsCB0byrqghOGeMvRUyp6U=;
 b=YWeJxXNQmRC8F/mAZD3Kem7nNYENe0cLUpOoWh1dxWhR7laO375p+HL/luUY4q++BcNX/SZu/D/nXJ0yEYXlu8jSdISa1V6io0Bg9uetaVmW0/ycacL8t21KtDbu+8LvDpCxYaPZ2o1zIMPylV3UvZhXBt75JQPpjVLWeL4p3Ky7KZpZjxde3wvsdORdFo2ZGd2/fJJZa5kzza5Ij5JMX9T0KQPqIB6zsjMCRj0DtQ+yzvTOLcDxff5uz9ONSTTLeqRH3BIbfzyLMzA5uetUkQzR/H5Mj8nGVpILauBj70JuqU8NWx8Cl+NKxnZlGHLygW5XawoEZz4Hf0WQ76dMsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MV0WIeSObquQJoIJE2mivwsCB0byrqghOGeMvRUyp6U=;
 b=mApjoGkRP8q/+rA6ySo2Jhey1226oNrDa/4aqQlqwkNwnacnyjGDnxsfFpq+yd+CKigUII1d5CK8xZhRerNymDnmubgx9NreOp6B2r6MFkezracrPhcWecxm8XxfW7nAwefUKxSi9uFGPjUm2UE9tGIoOsNwnw5gd9m+XVxaIQm7WukEiGM+6xgGFrEjk5TStxmWub8R8MOj6HfMRkP38ogicSIptlUnp4PHknp0jkAvQzRuiZY6R0aChpdnWqP10ATsEoX7HwCdVTcSSP35oS/GvFxWnVqcWjuXcBBsU37jbCYbIC1gjn3pkG1KkxsGtB3epiHizmko5YumZmPwiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SJ2PR12MB8135.namprd12.prod.outlook.com (2603:10b6:a03:4f3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Sat, 16 Aug
 2025 11:42:36 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.9031.014; Sat, 16 Aug 2025
 11:42:36 +0000
From: Zi Yan <ziy@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ye Liu <ye.liu@linux.dev>, Vlastimil Babka <vbabka@suse.cz>,
 Ye Liu <liuye@kylinos.cn>, Johannes Weiner <hannes@cmpxchg.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Brendan Jackman <jackmanb@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH v3] mm/page_alloc: simplify lowmem_reserve max calculation
Date: Sat, 16 Aug 2025 07:42:33 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <8A6CFFC7-36D2-4E79-87C4-580C31694F78@nvidia.com>
In-Reply-To: <20250816002742.5582d91edc4905e3af69480e@linux-foundation.org>
References: <20250815024509.37900-1-ye.liu@linux.dev>
 <20250816002742.5582d91edc4905e3af69480e@linux-foundation.org>
Content-Type: text/plain
X-ClientProxiedBy: MN2PR08CA0026.namprd08.prod.outlook.com
 (2603:10b6:208:239::31) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SJ2PR12MB8135:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ab97f7d-f606-46b1-d0f3-08dddcb9fefa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HjnjvpHgyq7G2oZqB7vbMwPdbdvwWBsN7GlT7aE6ukWRpl44HiDqxXKvn/cE?=
 =?us-ascii?Q?6i9Twl5y0BgMF0GG1xALQN9ZirfbxG9I4JfZ0itnFZGNQOq6iFKiXn4QH1zy?=
 =?us-ascii?Q?R314h+8J2czM9nH4D8yY21CQYaYDQElvT/TdKdl/Th+cjhg4K7iK/+ZtBe1i?=
 =?us-ascii?Q?xnW2/aobzIlGyeReQTtAOpM47na6pKWTwKiVoeXlVHtpamoIgnqnza3h60HJ?=
 =?us-ascii?Q?C5hvF+vwGxN4FEx42JzQ2dYCwKa9X5a2lysYFItBaFnsPQh9zlcMI9TgtEnq?=
 =?us-ascii?Q?AMyzxovSvVgNpRT3hryb1YylkyO0vOOctwUtDwlkTSHDq9RRkjJIPHssJvY+?=
 =?us-ascii?Q?KPf8LMkG4TK+Mi/gifVA1nsUqSxt1CTyKr/1nP1fi/gh7+g96L+tQDoHbmgS?=
 =?us-ascii?Q?JvlHVN6+0r3elQvt5oobTRVGfR4ZSZ+SXWuLrKilOUsef0PFqCFI4tmx35XC?=
 =?us-ascii?Q?9HMpKxZ71OU1W4Lnr76F040TZ7c1lLJBcrfmbYxilBDBD2nacPoupTir3rEx?=
 =?us-ascii?Q?5cJI+xtJ+oBn8xOBQ2fU5kiDpxwJ9NX/4B0BZQ+L8d6xkH3z2+WW1mYqhTaM?=
 =?us-ascii?Q?P+2kS38uYMZRlsKUnml2GJ4iwCE3VHPkC8UwjzbUr+2OcgYvzafOmVyko7o4?=
 =?us-ascii?Q?7ZtvY9LHaPhSkOI7MEpETS6/agTjilMRvXs47mjeRzTwD7b2Hx1HYX1aPo7o?=
 =?us-ascii?Q?coVXAe7fSU/MBj528OHAPKxdCjnTwNt513z3z0K1OciB7hHk7OV6rUJOtYLs?=
 =?us-ascii?Q?3nRvsyZuNTOdfLx+YkGyCpM9ktfLZKIkV20h+0mYTzWcyhQcwoK3d4T3zcSz?=
 =?us-ascii?Q?f2AymU14m1gWYayTQ+oEvZRg8CVzk8hRvZccuAys5KGBAqXLff9hEYD9djEs?=
 =?us-ascii?Q?kzMS411PKzhNEh8IsWSeXnUygmH4QAPvDRAu+trGohlACvkCgJ6HFh2TuOf5?=
 =?us-ascii?Q?Q7v4X0jp85G1nWP9l5lSIrpeLCzMv3eaLqGxiYlstUJQnDzOMN8exPhcYpB9?=
 =?us-ascii?Q?/bX7eSU8nadFijzg3kzef5GQm/zUUC6a5YJM1g+OuUMXCBW2GG0rRoPuvVbE?=
 =?us-ascii?Q?/N2YYce1HJ4aweWSuV5gKfNVjs8rieHPR7Gp7IAOYtq4p0BX0pAq4BcVTCUV?=
 =?us-ascii?Q?7rVSk6943NUg2SBIkBjHEVvDOxR5OgjJ0Vob/ZaZdcxa3fQ/mKh0xJJzRPDi?=
 =?us-ascii?Q?JDSVkyGkmHVo6yaB1BhDDz90oPHVbLEzMIn9AH+5/l5SmnFA7Qk/7rshTVcL?=
 =?us-ascii?Q?ZF5GbW6xv5qxeTtDrzJOTlbDTbdX2PmOGEbTka4c+yYpeBa8Mi+REYUAqj44?=
 =?us-ascii?Q?apLsMUY//uLlV4ZXpVcAfmVKnxJPAqzGP64ThGPodloErk3SC7j1Idgdk5+4?=
 =?us-ascii?Q?B1QIMLIg8sSxP64eHZD0znYPq7I622sq18YNh8KnyG9yi+vkpGkF2lgXoifq?=
 =?us-ascii?Q?jSYqKtSYsuw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HFVrfp5SAFt7P7DDWKyX6DQqwZnOOl3ldzgrvTWk8hQspX4p4c9ab3PSqFzX?=
 =?us-ascii?Q?9ISTPKg33mb2nBn1IgaGp3A0oCd1SP3xYIt5sv+4mWJdQui5T8CLfUSVaXV2?=
 =?us-ascii?Q?Z/90dvVlNJL9i1RvDKKqbOG/hUX2Hsh2LASzl0XGMP6yblj0Yxe2IEFKSxFt?=
 =?us-ascii?Q?TbbYEPsbRvSt/AkzzRjB9rRy8q3T91solEmdkbP6+nKEoN8m0vvlD4IjHGN0?=
 =?us-ascii?Q?olNNM64ahuWLt0E2iSFON0drZbflv5ObukQKGYhaFmkwQk+/Y0v48bQxbH8z?=
 =?us-ascii?Q?SE3XXVROxLU52t+pm44GN64AEnTzCadb6HHBgOJ5RYj/PA7WlzJo1WmguvdU?=
 =?us-ascii?Q?ocPeDF5900KsJNXgYInBK7rZV1FM0GxyJfZoLvQfHMJ3j3OKatbnotPSPnkC?=
 =?us-ascii?Q?Av/rfkxMmpOOAm/pcTUm0CGWE4yPHq/QnbWhflN4XmfwjHkTUMuIXon9WdE0?=
 =?us-ascii?Q?NIxniGChFOArT5OucfytYWNPW3UvBG1fnVDAPMPB7Ue8lJXSzA1hBCz8CLyx?=
 =?us-ascii?Q?HKKmzgzqO88Td9gnqmig/4Q6iyCrOn0YA8x5bbw/Dzg//g9z6tLXDXO23VNY?=
 =?us-ascii?Q?uX7katx5nk/EE47ADCnRCiEm1r1pJ30uoirdna8vmAvVEYxUUN2JcNXDCImQ?=
 =?us-ascii?Q?Bl/oubIXmMJJaBwBC3sXfXDTyc663btUH0YFEfv3mEWkD0rjwPf7SO2q1IjF?=
 =?us-ascii?Q?Uo9XpSn7e/vKaboqamBUERIDRT1kS9n2QD/cSSAk5GZiJiLI3DTT8LCaKM+o?=
 =?us-ascii?Q?swPOaAoz7iJp0a7Q/Dg/HacifHBgyw9wKrR9H9AtEpQ1iO5swZMq7NCMB92K?=
 =?us-ascii?Q?Bn3zLKpH63rKOKiQ9E6WhzPeF67HZY5Bh1XPRnQAdDhW11Nj2Zio98FajH8u?=
 =?us-ascii?Q?UhvwIesYlIN6wEToxlG8xLBmKh4u8asw0g9WMQySae6Iz2inJDXTBSsa+WgE?=
 =?us-ascii?Q?sjTQxw90Dyss1YFBhIe3LHqFfh4oPBMhTKyMtpQAM2zJf1+eWWhfrDz034zQ?=
 =?us-ascii?Q?5yBqPt0SLT0mg0ffHEC69XKrP4SksM0EKqWjz/+fgnwKGvJikXLC6T8htutI?=
 =?us-ascii?Q?RT+svAJqOFOZZujFKFVL7Dk9hQbTP3olEObwkuIl4qfzsJr+jNaQInFeiS1L?=
 =?us-ascii?Q?0S+BNsdUdZPMEqNy6/F53sV/ELgZqS0LnEzIShBcE3EFE3cg5+cxjcI+1kYy?=
 =?us-ascii?Q?HKWTHFjlhukfV8tQt59Lina17jecCcfa7Nmh5eql+Ya7dx6PqQzTdIB7tZge?=
 =?us-ascii?Q?q/77fGg8mwYWBJtdDxm0WDh49joXbHQXyhtaRhzbQdzR6vgL3YZIcIYw41+F?=
 =?us-ascii?Q?7id9lyaiIu5xNc1ODeKPu5duhwRYqOLg6cz/6ilW4Huzs61ApjE/3aMKFZcE?=
 =?us-ascii?Q?b0f3DXVduAtXQqNcCi26vvmTOfH7OFPhx2D4kr+gUIEmu7uiUkdsUHIo5pQh?=
 =?us-ascii?Q?k5f28yTtSIbxWpyp/vNlRMdllNtyqagCLqPEnAQU36ZcDL3rXKXa1rwQzwYE?=
 =?us-ascii?Q?mcqzVUYLtIcbECB17tlNEohWuCtkymv0ngyzX6yVhismxNbPMbt33i7ZH9n1?=
 =?us-ascii?Q?AF2PjWu5vtcF1CYfbYoWf3Fhv4+9OT4XFOYG7bba?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ab97f7d-f606-46b1-d0f3-08dddcb9fefa
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2025 11:42:36.2450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B+PmF+jYOe7W8oAlMG/7C0ucbl3UAytj0QE+nL0MnUITJ2XzGWe95wyb4M8cBMOY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8135

On 16 Aug 2025, at 3:27, Andrew Morton wrote:

> On Fri, 15 Aug 2025 10:45:09 +0800 Ye Liu <ye.liu@linux.dev> wrote:
>
>> From: Ye Liu <liuye@kylinos.cn>
>>
>> Use max() to find the maximum lowmem_reserve value and min_t() to
>> cap it to managed_pages in calculate_totalreserve_pages(), instead
>> of open-coding the comparisons. No functional change.
>>
>> ...
>>
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -6235,16 +6235,13 @@ static void calculate_totalreserve_pages(void)
>>  			unsigned long managed_pages = zone_managed_pages(zone);
>>
>>  			/* Find valid and maximum lowmem_reserve in the zone */
>> -			for (j = i; j < MAX_NR_ZONES; j++) {
>> -				if (zone->lowmem_reserve[j] > max)
>> -					max = zone->lowmem_reserve[j];
>> -			}
>> +			for (j = i; j < MAX_NR_ZONES; j++)
>> +				max = max(max, zone->lowmem_reserve[j]);
>>
>>  			/* we treat the high watermark as reserved pages. */
>>  			max += high_wmark_pages(zone);
>>
>> -			if (max > managed_pages)
>> -				max = managed_pages;
>> +			max = min_t(unsigned long, max, managed_pages);
>>
>
> Use of max_t/min_t is usually a sign that we messed up the type choices
> somewhere.
>
> In this case, I'd say that zone.lowmem_reserve[] should have been
> ulong.  Oh well.

It was, but then changed into long because in __zone_watermark_ok() it is compared
to can-be-negative free_pages (see commit 3484b2de9499). Maybe it is better to revert
that change and convert ulong lowmem_reserve to long in __zone_watermark_ok()
for the comparison.

+Mel, for his opinion on it, since he made the change in 3484b2de9499.

--
Best Regards,
Yan, Zi

