Return-Path: <linux-kernel+bounces-768997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC49B26893
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 16:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 270E47B450C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25C21D6188;
	Thu, 14 Aug 2025 14:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UGDRZoAH"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC1F1D7E4A
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 14:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755180109; cv=fail; b=WMW3bRGwm9L/uzCdL6YyoxjEc6I3bhkfxGhxd+tx0QL8snl7on5hwo3UyxZHWmvul86tWUSDoJz0WGqM5tiRcCZ1XRrnn/sl8d6MEWRf1dR6/9yk6AmhNl25S/p1PNguSaN25CPsNfp02OJK1MVWj685xSJFay/sX1wnyE8RovA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755180109; c=relaxed/simple;
	bh=y9B3FrjZUu800+JdrZTxLBMUB9IsJdT5nLZoDG8dHRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FeNZ58kwxZBmCsHz79N2gbhRCZdkvnox7wJ1bzhKq4zcLRc+0aY+kw4vLByUKLxuJ1Rh6+420y50oRmA1p+FNtPF3ESvAMi3QeqbgxVzR8RrvbT6rGOoWJCgb1QOYdtG2muFLsVBaOGe2vxOEk1FQSvHT4F6pFaJTEPocohXF6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UGDRZoAH; arc=fail smtp.client-ip=40.107.220.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eeIAZyviMA6+425q53wg6Cc3zZAv6YXsV0m6uB5JhbeNjMSeZG6MkIrzpIqKwyF4wWVNPWKLI8GN+I8Urg2O68f7W3MP8mhMkEwxMQOVWYAllYMvSWyPgOsBsXKzp2QIR0O0qdu3HPG1KOsB2aPiYYCL2QjbqZZE0sf0KbdUgbJEqRefpXm4QMLPTrXB3CrJeu6BFUQbPl//f2QRiYe2QNm1QCPqnYhiW3CL2kcxfkhfJ6HQpfzSya9cYNtEAMQ2Qtg3WU8/Hmh7Q+UXCsSzPsJndKWelw2e/AARixiVPC+yrlLgC+5xdI7nk9bUIBYHQ6jZikRXES8wGQ6FoWfBNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eh0lIZAv8UqET9TsdWCGcooP8nZrVP5IWt9MpzmE3NM=;
 b=Sr/FLMxmV5hKMjS6uxqTdorrR9Vq0ueTKOMMjqrhnEl/mbwEahYX7lvhiVbkGgnLXhrVUna8n5HMVz63dhH1Dx1x21g9ZfCX+lS2CeLnZcY8LWqoty7SvfBs5Ix6/vuhkmKBshP/oDovltVKDSKasUFhDCiEfqWOr2vI5JkgHq9yyy4drGdj2hbhQ6ubRxWax+8CiFW80HkIjI5X+dVx88CwNODHbG/MuCS57ZjxYfleUFymABYkJeZr2sMPsq8kqA+ZrM/o8Vwr9D3NSgCMI9yjQS6/W1JmHoAaR/ridNcCZhf6m01x5+MDO/mq9sU1OTEz2zvuz6gfOkptRvSDew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eh0lIZAv8UqET9TsdWCGcooP8nZrVP5IWt9MpzmE3NM=;
 b=UGDRZoAHJKkVlucvhb/nB7XMwg2XyW18VfBSRTb7JyUFSQpL0o4Uaf9Bdn9Jnl+1R4YsDcIFwT1qa4iqBeNflYYP40B38VrdS1jJOsvrFEG8lAUluk8tSjKhaD9NMwNdV/T9fZur54YOF3Q3i5a2fgBboWtddPaHVBdWrTC0M1oMhmeLSS1jcKnvzH6v3gIG+opVSkleGg211H0fRVp82oJpJsiEbW2Ds9HBWf9zlJ+NLt6LvbuWXBvnwWzNxW+Nyp2ZBQyjCModDjheJUZP0Rm6uuYXJwviBFV2UPST8U/4JJGfqFFmOIRBQorhrcBbA0Y3b7cCAGhXVcK9TZRX7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SJ1PR12MB6243.namprd12.prod.outlook.com (2603:10b6:a03:456::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Thu, 14 Aug
 2025 14:01:41 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 14:01:41 +0000
From: Zi Yan <ziy@nvidia.com>
To: Ye Liu <ye.liu@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Vlastimil Babka <vbabka@suse.cz>, Ye Liu <liuye@kylinos.cn>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: Remove redundant pcp->free_count
 initialization in per_cpu_pages_init()
Date: Thu, 14 Aug 2025 10:01:39 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <4C309170-5096-4794-8369-CEC9DD45F2EB@nvidia.com>
In-Reply-To: <20250814071828.12036-1-ye.liu@linux.dev>
References: <20250814071828.12036-1-ye.liu@linux.dev>
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0367.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::12) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SJ1PR12MB6243:EE_
X-MS-Office365-Filtering-Correlation-Id: fe1a9233-4abd-42d0-bad2-08dddb3b185b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zH2oLv0sCzXlq9oNOvJc3gl8ldKZqOd8nMyx9H3qqYWN7kCAFTdY1l59BiFZ?=
 =?us-ascii?Q?PvaF8QQGD8OT+VSHpjxmuQ9TlVz3O59fGYAwxeu6FQGt3xVhfNbvdhGJwLyC?=
 =?us-ascii?Q?WkqHRqHO9CBhrMiyzBit7zHPfyUuN2iCkgRj1x/zop571ajx22v9W+V//Z9P?=
 =?us-ascii?Q?QieggUGFnJaq+Wxe7rp8IyL6QkqLzPTQmpu3NueuC08Y7HEEJDBzvzG0olU6?=
 =?us-ascii?Q?wNo4KplOxy5YN6VCb96dN4KdP3/tSW+YwZSxvBhs44dfcT0qklBcOBuJHniX?=
 =?us-ascii?Q?R7q1jTNgdSlGs3aGcnwMyVr/5kybQMXg8hDezCtIQF+YKmRlKspm1woamKZw?=
 =?us-ascii?Q?W2dKaBCQ1SlI+gn+GkNUMIZlapOYg+I0NiXXTOIatCV8gYoAHLs2XLZlr4S0?=
 =?us-ascii?Q?2UoaprLk7u6cMv74KaUJL2DLTT/uM/SyS/xWMJh6KjK41Zoei9coJITFngoh?=
 =?us-ascii?Q?6MsjIC6i/yKiC1QQIwA8tmuftV+d27WMsfM1YUDRLN0GFB3dlZLletHYwpOu?=
 =?us-ascii?Q?MIEOrujDLa9iL3FrpLPuWN7/fSHyRrzZrhea/ZfYqieOaPFff0Ep9aMKZmJV?=
 =?us-ascii?Q?2s1X1azjRxC2ew3WygWohq00WO1pzH1B7sq+uH3ajjeOPP67pISsXeszpIrr?=
 =?us-ascii?Q?+E+y/01qQOYWCFELayxj74/uTkjG/dfGwdcZI1NSO9g20bRyRoI3D2EOLYk6?=
 =?us-ascii?Q?AvCyWk1MdWySqsUhHkgrVoAiE3tyoelbmK2q8gcUkX7V1dVBw9cuvo2jTjba?=
 =?us-ascii?Q?s65rLW7DK0f5Nd+z3zAqqdYNuSYXxPT6kqk+/8tS11J3KPSlXB4BbNwid8Pr?=
 =?us-ascii?Q?mAemlBuKtQXv1wZ5XnZbXTkU/095cpMsnNMMkSnxEjayVjtbQRGbxlqo4O5f?=
 =?us-ascii?Q?/VMs1vMP4gJSl7g/kH79eMAmNGH9v4RDds0YB68frL5PU2/XIBj9gvNQiyDi?=
 =?us-ascii?Q?rNkGr+qU3utLtfxwH/eEEgiL91ZlLZ5z9UiKkkW4Wvc0IVpLU0nH3Sl1oojR?=
 =?us-ascii?Q?R6Y5wI3OD26rUO8JenGB5sedtYfXMfYuy9UuaQfYSw1V7LdbqlAH4o8CNPvd?=
 =?us-ascii?Q?Q5K2RwW4hgPgHxqLQZCzJP9DqQTNqFmn8OXqFBOAM7xzNn/Kspk36BEKhI4H?=
 =?us-ascii?Q?tKXSmbfrTZe+Raj1HLAEXJwwwTlb1CHvpTzGrgC3rrbeUvD+zZ8LyL/6gAS1?=
 =?us-ascii?Q?Lz+L/E0hfoDC4lqFOJHwKRLHF1DLLE6SvQC2UeHBoYhVGt+jLHIb5HZG1LiJ?=
 =?us-ascii?Q?+BkfOdivO8y1XNgrUJd78C2w/0reBbO8W/QBegmXvZF8fsXTnziBsokhsiyL?=
 =?us-ascii?Q?ghdWFJSUmtJjmePiyZyIansnjWTLexhlH/i/Lk+Z8wAFDSagl1YzuehzVqrz?=
 =?us-ascii?Q?fZP6ZWik1a3noacnZsuAbszZ8xDy3zFwa/gKN1fBc1PGYd8EZy8I8IMgHvvU?=
 =?us-ascii?Q?/yvtjXSyCCw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Xr1ymfkV+Tb1i32VhWuyWYYxvr2YYzy6GohgVa1QNSXpYjqjKVDM907oUTU5?=
 =?us-ascii?Q?2lv+gyYdHVT8vVSnoDH5JcjeIKJ5k9nzaWBVm7V9tW1Ss7paW1p5A1b5GY81?=
 =?us-ascii?Q?kFuyCN58PUadnNnjF5XMVIJg6tIMS/hSi669Hh33PvXxvaTrL/wksP7pgIqi?=
 =?us-ascii?Q?rejUUOS82tEc0rdBSdpC7pnXlHP3/YDz1r57hMBE9cBY58qGi4jZ3QFqElWB?=
 =?us-ascii?Q?EOtqPnc7Tt0GNlO0Z/W2GGCqdSldrMnuIARvOEHAcsQB6V5ddA61E78AGDwF?=
 =?us-ascii?Q?1A4MyQRcIs02sW9WqLpK9SOcS/1qu7Bb1z96jvlzIlNkL7J8v9rqsRtWPrln?=
 =?us-ascii?Q?LttYLAzJ1jtgwR+pasow3n8sReKPRW3rENCP/b4xqNg7LtPPtG5iKNWB0peV?=
 =?us-ascii?Q?L8z/vobj6tRRiHhNX5DqvKTAKFRCMP+hBC3wTzV+rUOs5us5fOBUzV1PpcGD?=
 =?us-ascii?Q?+898dHv+Z8so4yoFufSQQJclTnzTMurfuzszNw1NxDMY447f/9zWMYgDr1VY?=
 =?us-ascii?Q?B7JbiZfz/vHyFNXgcdh5f9VbhZlbOUWFRAimvg+3SQrG5s20fuuR3GlXLDNi?=
 =?us-ascii?Q?yUH+hUahq9GBI3D9SX88B0VFfc32jiL4Vs73Uu5xy4gjjqEupEih4wwi3vaf?=
 =?us-ascii?Q?iiYywG/RWVUYeyu+hXorwDqB55LdG1gOR9mSWINx/dc/5zQ9/4f/3tjLq/ZP?=
 =?us-ascii?Q?ZBPHoyV/sH3rK0U1sfslSLhJinh+o2dleJzePXnkXp8zS7Y0Rh//kjLWsNGN?=
 =?us-ascii?Q?FSoC7qBA6dwNZ9yb0dqCI10ZeAuuZYxB9m+szduwFjJZdKrgyKFE10TZ4k9z?=
 =?us-ascii?Q?8s2areJb4oF+cNZndbI5iMt/CC2hxZ2yrBD+5GqcVXWliHb26/eUKkt1xler?=
 =?us-ascii?Q?Vctl7A75KyCaMY+1F/CF3Zpo7q1D6tLfp3XE5k0b3CrFLDfHlqN7DB37YW9f?=
 =?us-ascii?Q?Cq0PlXz4Wc9KlAG1P6OdPQageWZ3HK9kEvYXedempBq57bOi9qzCA/lz3Qdg?=
 =?us-ascii?Q?+13tpjV0VKWgrtj9KPd/2OnYw/8wMANmOuEKyLcLF0tC6h1bK64/kcARl8AL?=
 =?us-ascii?Q?AsNS29r8m1dUzhzUB9j7tkQpeTEBs/EtmBPT6Si5N3mAsWChKCehaVH3QCRl?=
 =?us-ascii?Q?cj+JjYAMt8m5XoahTOL2skPAnzBiVGoBfMezjfzVWlmcHuivgOIy1PiiAhIa?=
 =?us-ascii?Q?PofLZKqky4EWzhhoSUd0nqHbojAe9XYQ9ftieIeF9IXZGRFNRxDyfJgqg8dc?=
 =?us-ascii?Q?U1FbDRUcyUDZnhOUy20h47K0dyag63EX99sO903JfXgFufucrONgjAB7tFqZ?=
 =?us-ascii?Q?AH8E7Wgpy7+wsw9VrYugN8C/KCRuv4oO34mYDRIvLvNrCSAbzekiKI3t6NPG?=
 =?us-ascii?Q?PoMNIP6HQcZx97tjYOCP3NkjqijVWBmjXDyjDpeiO5yt6exJ8yxno+4g+zWs?=
 =?us-ascii?Q?M15VEGEN2IF5Hqq7qmF3/AARLuUb4IWjB355P6nSHUfQfodkOvrr7SyHDeeI?=
 =?us-ascii?Q?vgRw6aCPbNKQ0qbv1h0Ov0JvT4ztcV8BvmsX1ZWgUEb72NaxoVPJOkWQ0hvm?=
 =?us-ascii?Q?zqoEpNYYkKalQZhKAtLWAH4J7ti6mi1UWAQeUzRO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe1a9233-4abd-42d0-bad2-08dddb3b185b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 14:01:41.6144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eYfWnKYXWzs+V+tdsyDGK4LtMW1pnAxwaZq5fyiQ4xIoiDkxkfwPqp9TIrtQdCpp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6243

On 14 Aug 2025, at 3:18, Ye Liu wrote:

> From: Ye Liu <liuye@kylinos.cn>
>
> In per_cpu_pages_init(), pcp->free_count is explicitly initialized to 0,
> but this is redundant because the entire struct is already zeroed by
> memset(pcp, 0, sizeof(*pcp)).
>
> Signed-off-by: Ye Liu <liuye@kylinos.cn>
> ---
>  mm/page_alloc.c | 1 -
>  1 file changed, 1 deletion(-)
>

Reviewed-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

