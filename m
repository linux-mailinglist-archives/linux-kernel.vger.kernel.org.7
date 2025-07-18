Return-Path: <linux-kernel+bounces-737006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8186EB0A693
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 16:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B4F43BF3DA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 14:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228FB86344;
	Fri, 18 Jul 2025 14:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EatDTx3T"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2072.outbound.protection.outlook.com [40.107.212.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240CA1EF1D
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 14:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752850144; cv=fail; b=rfgZN1uRmYrSOG5zb3xU13F+GLD9t758f8JSpFlKFI9MTf1/c0KQD+xNejpsojx47V1gusu8D965xNsdKIo11Y2lrQxVkx1SsnM02opDi/dyAz1tpISk1O6gOPDJxpqItJn27IdjHL6y6HhR8tTO3mnAkpaSLQk+F1peSXAex9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752850144; c=relaxed/simple;
	bh=ocVkAYzf+WLDd42B8dUuwBEwtstuqT8+zPFrVDBuCyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Kabp+ILHmbDYA3+u9wauHvNcmY3nHkko6Ee5jJ6fQoGPU2qistBzLjHdGc8OumL08ppP4AXTCO5GIn8m2yhINTZDG7pip2r05t+yoSn8CUXweu2Zqn66EWJnl8fp1xXn/acFZnxP4xdDAIgAdyOXVio8sECfeX+j6+pKgqxXmLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EatDTx3T; arc=fail smtp.client-ip=40.107.212.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zFUNiOo7+iIV5QEbAOZjKcw3E//Gi37cX7D6AXVPvd10uThEFAxct/imwGTSA2K9K3TQtkZOYrA1tbxydnARuY6UG0x6hdrQ/S0NOCbeTQR+gw81PujGV0f/s47Aec5LO0TPdci3/Bb1S6z0M1ymX8HKAjYxuYgAIGh2lrZYpdc1o20IbmcTQqJbDUNjA1U0aaPslrFp2Dm+FpxatAtxXoH6D7JqQTt5m2AemAJiFVc/3+PSdD+rrX7oORdBllfZzglkegeRTJ/f3oeD41fIkKJNshhpcVIlLkfDQuPQ5v5h3f0wn+hN7BuS338X1UFiPH6TCic4N+LpyDzTXJyXmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qe0jvMsIu4Rmo68AtQobuARs/BkNuymbcxjwVz8ChNA=;
 b=akgwhQBctQSQDs5PmIVhzWObPwgh2cOeUOsJdHE52q4g2yVdMdzpY/mnIAlT6DbE9dqYINDaHuPRJuHgytOdDNYAwLjrq+Ha2NrU0nmm4GRlKsNB4S+k6WHMi/KpXORCycJvPMDqu2vGaCWVF356yF5nAM0Oc8FA0P/pOC6dP+N/urqP2DhEuGdDIF+gqj/HZ0SGeXQw3Cmi1Tdc2VbVfwk0MMTMRUs06udLv7SC3pOY4ckGqNYHy5302mXOZqPIlDlw4VgWJ49gVplSddm/ZQkfVlyLcpjwEYcojBznJJq8UglEc0DZP2yB45kop04S0iAzquA0u8ZuN+mJ1YPosQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qe0jvMsIu4Rmo68AtQobuARs/BkNuymbcxjwVz8ChNA=;
 b=EatDTx3T1jxuclrdKbOxrZUwz3sIXLI/cAwr2up1FV4CO/R3zkScgxbRrvMh67twsGoFjM2NlzUeS2MueRSqekr7XbYsvqE6WefKvbhr/NYTtxF8/+DF7EU2POnHY2988YJHJ6AVK+ip9F/OScg7glcUPAHxhfLd7GFin+E0OiXbDmcvxTHMsIFNWdTnQOjxnbhtskCusTzpfr0zBlCDixPyXY305waApNhwoQbjwRDvKgyGcjp4u6NW/fCYWAFhTBUr91zBYoGM3TWP+IGsKhonGQdoHDOWybd45emwW1WTBKKYKOrFFQav34MKtJzDwqKelSS+il0y4u/yvyHrmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SJ0PR12MB7474.namprd12.prod.outlook.com (2603:10b6:a03:48d::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.39; Fri, 18 Jul 2025 14:48:57 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 14:48:57 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Antonio Quartulli <antonio@mandelbit.com>, Hugh Dickins <hughd@google.com>,
 Kirill Shutemov <k.shutemov@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Balbir Singh <balbirs@nvidia.com>,
 Matthew Brost <matthew.brost@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/6] mm/huge_memory: convert VM_BUG* to VM_WARN* in
 __folio_split.
Date: Fri, 18 Jul 2025 10:48:54 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <F7FAD17A-9F00-411E-9B12-D38699534D18@nvidia.com>
In-Reply-To: <3ecb7e94-c0c2-4dff-98bb-a9e32a48c369@redhat.com>
References: <20250718023000.4044406-1-ziy@nvidia.com>
 <20250718023000.4044406-5-ziy@nvidia.com>
 <3ecb7e94-c0c2-4dff-98bb-a9e32a48c369@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN2PR01CA0043.prod.exchangelabs.com (2603:10b6:208:23f::12)
 To DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SJ0PR12MB7474:EE_
X-MS-Office365-Filtering-Correlation-Id: ed621cbe-97c2-4bed-a9a4-08ddc60a395d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VrF6c0uYhZay2RUy1Cu9WEKFa/Fz9gTa6JYXmGrBYYZTwomN8QO828nkJkI3?=
 =?us-ascii?Q?zAhiMNAaC0qE9R0l75MX5fPzdFHAsnELEUbWMSQemGXGIKBNsgKnuCyDS7gN?=
 =?us-ascii?Q?yVUxEXJ7CcIk43JOase1ZKhmDXjnzojpsyIZVVTOsQ/euo9uohwIN9jZWAUB?=
 =?us-ascii?Q?p7ve0lkQdiuSoLwCcJDbbbiZbmm79bCrQnK4N0H4CtkoaPF+0dUgHdLB3RnR?=
 =?us-ascii?Q?GGsrkRRmJ9rA+vSDqnwEQMIOG+7xr4kQBSk4xJeQp5e+XSCuROgVitOMZIR7?=
 =?us-ascii?Q?kOAzAw8gDtIuirsrTnhhliFXF5vtCluYv9l/1a/OXE8/CZbbtiOc1tEa3gAa?=
 =?us-ascii?Q?iOxW0sYQwzP15RETrRcGEBreBh5m+HcRjmPQuKjT7G8txg/LXBgo6Vw+ABcZ?=
 =?us-ascii?Q?KCoQPtGT6eDV2HKEoVE2mN5HXXgTG17Cv+HPBZhHFjcN8OprezHuP0h7Lcq6?=
 =?us-ascii?Q?PAkvN0S1NOnluwwpcH+9Ie/2UnETg78wXJ0A7Eycr4rbQPktTIemg9fHlVg+?=
 =?us-ascii?Q?pHP0BYfYvSRJRlFJV4zbfzFLBPv+6StouHvwaTybOz5K/VJpVsgkCIMTja/p?=
 =?us-ascii?Q?2YXG5hT54xTVXO+OsGwgI9JSit3L5oKZVFJLEBzy8YUqojtzXW4lFg0YBd8K?=
 =?us-ascii?Q?ve8EmI5l3VtxHMdtBMQR2fwhlD33q5IdSpT0UmMdIO7241EbOByp6Y0Cftyb?=
 =?us-ascii?Q?rd9YdI4m7izBRXJ0TOeHrznS2vT+hjy8/OWJ3oUNCoaPi1jdtcbRfkKLnnS7?=
 =?us-ascii?Q?gcZDM3NXPQmeXaV5xDs/HpIJhzhz3y8p2ro7l+AYj+XQkYA0qarae0NyXqfl?=
 =?us-ascii?Q?ioR2pF/kgkh17eeHhnz8T9OcRRtQ9JfuulhoEgyf0xVWh/rFBzPZVoh9JNAf?=
 =?us-ascii?Q?KSX8xHzMkZ8ffY1QlwCNfr3xmG2Foedjh+1KMunWzzkRdC2yM+6zKRv1wlJ6?=
 =?us-ascii?Q?LftR6hi52ySjhCxtCuZo7AoKmcuXm/KZfKaJnzn/e7uxbAREoare2/8IULLg?=
 =?us-ascii?Q?R28Ns6dmwr4oTbQnpiK+mAAARisJNWgxyurB4KmCxnwFfJJYEfH+xacCmKQH?=
 =?us-ascii?Q?u8SvMESf6hJjW8lTlpJZzPim4fSw9+kh0op7PBuuVh+wew4L9fUt+VYvr4us?=
 =?us-ascii?Q?tx14CqS63+0QQbMaN81AWsHUG0g8AzUIBz3skkK1CFOmV1dxlmw8Uqqi59ri?=
 =?us-ascii?Q?k4d+cTgyEDyabH4ItTYEb0/D9xix5LAo59g+BlG2YgKW44p1D71ryrHVKcBa?=
 =?us-ascii?Q?jqXOrMoZBSsdF74aC/s5gIGUycm365ugU8Sc8El1zy1uVaDPpv0TbRuz7qDn?=
 =?us-ascii?Q?8XqO6RP1lYoTFnmNi913wHAidMO8KbRxjeIbCYq8mmzPEvM+ZwmSYK2j0s5D?=
 =?us-ascii?Q?pNWYiwV4IIzoUdx1AA1A86BXhaX1DWZ1fAKIssh822BUf0swGG7R+o/lGdHN?=
 =?us-ascii?Q?czLvKnkmwxE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bBURzPjtHI3XVLo23EzCxmXg1Ke1DcKTsTPQehgkwfWvDn+5rwVsu5wI4D3g?=
 =?us-ascii?Q?3gs8qcctxTWFEg3CN9aSyBufglOCRIPIL9MLJfW6dbjZHyjXI0TaHYQ73Rqd?=
 =?us-ascii?Q?QWwyHbuC8WyEb4hmST0AzLSBe4wYYyHd5mipTTP65dlIqiAe9vXeJ7aFCD3U?=
 =?us-ascii?Q?CFuV0eP2fC+ovq94b1hpRsvONHRrYRF7d9S55B+DcsuYRzucgKz2UpK/ZCY9?=
 =?us-ascii?Q?DDp2cqe60ReSIhGKuQUgYRxEm3dwuNRMmyM/hX4Q/v0rq3FbbbZNAveEM09F?=
 =?us-ascii?Q?iIShv/kdGOXa6x2HSuvoRGDLB823HFnB9q0Tg7NGMSJ/C7Fs1mr5SyfgdBrr?=
 =?us-ascii?Q?rm6crL39qwKlBI/pQ0d104EOV+9/C1bzgApCvgH3wtokRd6uxCDI1sVNaoWS?=
 =?us-ascii?Q?myZEQlK9Pq9LRtUhL4W1SeVPA6WjK+E44+CpSzvD6PIzOoVrASZpX8OuYkD9?=
 =?us-ascii?Q?iCXI9RXHMzzPON7CYT6ZUOdh4Hcrceit0Y3v9gmAWQZ1k2CmD7m7OOeXOtUA?=
 =?us-ascii?Q?PQ8O4Ef/12JWeLG00yxvqpjeG1RE1z8goZvIb3Vf9qSZcdD0GurCEkpuVx7U?=
 =?us-ascii?Q?D4/qxHCpUYI7WFy2Q8dPBQhMZ7JTaAfFT5iGvj6OdnL7oHJe6Zf+yBJEZ43T?=
 =?us-ascii?Q?L/uyoiH4K9f0XfKNvEfUtW1pP3KfAQLWhLJttFv3jSJ3rWWVnnWI3huuluSQ?=
 =?us-ascii?Q?XwZdq7vlGgl5R5MQcD4YaMNaMziCFMnq6j7xTBBCOhe/w8l+hor3ya6k5M0c?=
 =?us-ascii?Q?kQeiRbFo2QhD5fBfXz6Znf+/xLgidRS3lM/O2rC4uqZyaglu3WMlK4y+4YDn?=
 =?us-ascii?Q?R1ZecZlO+T+NsRo54NXWGmzRDbHO1JqB/WxWo1GDNdqbQ2sgskmGhpIkxh2i?=
 =?us-ascii?Q?VYuoXSO6vX/JtkytjjA+Iixu59/MQYMvbhHwqZQpvvxZDgXpgDJkBnrQIiaI?=
 =?us-ascii?Q?3x61WfJpqzsxT4ZBL4G9QocsdVzMw8V+N/Wv6IvoLRAsNHUCaFUTetEFvzTi?=
 =?us-ascii?Q?QX1pol7A0dM7KBWx+iSxvytmZce2T3gunNcyO0Sd0uoX/qAADBLTQmJS4d7p?=
 =?us-ascii?Q?UihpVtrDg5+Fxf6TG8ZUdryCzwqyNKhhRYy11uXbveeccNcgm/YgA/BXojXa?=
 =?us-ascii?Q?Ua7+FbgvL7N3DSfq/yoreJp1oA9X3WM7IiDVLkQWiVx4S3Oc4+m6hoSzhqDJ?=
 =?us-ascii?Q?1sd7LK8i24l5zUexEg1FngLUpMwS3HXumFwzzBq89D6xoeEYbo5jeIgEOBT6?=
 =?us-ascii?Q?EsArSDO+SjilTRUPt/hWFedw6c/eDo03N4vUGnvFTJTklhWz6IaLxevw29vr?=
 =?us-ascii?Q?5i9jMtyaDYuJsxe+kBggOL0FE5Z65vS+asOzRK49/CpAneZl6Pkja3oX1aKL?=
 =?us-ascii?Q?YDLXYLwa1X0ClaedqKMZnj7U8cSL2nVL5sVG6p42yqrRhV9u8bw1x2IL7zez?=
 =?us-ascii?Q?kFadn3E0CND9sBjUVkp8r/jveYim8+bu4wgNiSeMyguMfrRvwtCMqESLs0uK?=
 =?us-ascii?Q?ZQbazb/4Z9ycCheGeBkmA28CeP0mSCV1TVLGSgXiOD2mT8BiEYqRGQkATprA?=
 =?us-ascii?Q?Pk9b5VCQF5FRn8XkgyipIzhajg7wFQ4gYJ8jsrg9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed621cbe-97c2-4bed-a9a4-08ddc60a395d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 14:48:57.1959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zPJ/1bcyzgKlkUBZfUUaLoqylmMhMdu58d2d0opp/ufaIAvDeSqMHvRm+IlepBGp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7474

On 18 Jul 2025, at 3:22, David Hildenbrand wrote:

> On 18.07.25 04:29, Zi Yan wrote:
>> These VM_BUG* can be handled gracefully without crashing kernel.
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>>   mm/huge_memory.c | 16 +++++++++++++---
>>   1 file changed, 13 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index d36f7bdaeb38..d6ff5e8c89d7 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -3601,8 +3601,14 @@ static int __folio_split(struct folio *folio, u=
nsigned int new_order,
>>   	pgoff_t end;
>>   	bool is_hzp;
>>  -	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
>> -	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
>> +	if (!folio_test_locked(folio)) {
>> +		VM_WARN_ON_ONCE_FOLIO(1, folio);
>> +		return -EINVAL;
>> +	}
>> +	if (!folio_test_large(folio)) {
>> +		VM_WARN_ON_ONCE_FOLIO(1, folio);
>> +		return -EINVAL;
>> +	}
>
> For cases that we handle gracefully you usually want to use
>
> if (WARN_ON_ONCE(..))

Got it.

>
> because then you get actually notified when that unexpected thing happe=
ns.
>
> I am not really sure if recovery is warranted here: smells like a strai=
ght VM_WARN_ON_ONCE_FOLIO() is sufficient, and catching this early during=
 development that something is extremely off.

OK. I will update it to just VM_WARN_ON_ONCE_FOLIO().

Thanks.

Best Regards,
Yan, Zi

