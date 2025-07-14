Return-Path: <linux-kernel+bounces-730417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5793CB04436
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 700EF7BAADF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B6A25F790;
	Mon, 14 Jul 2025 15:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ezKTdRI8"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2049.outbound.protection.outlook.com [40.107.101.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC0A25E451
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 15:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752507210; cv=fail; b=F7ETwi+34mx67LQOyTKfbX/+SCmdbCKN7MAyJm4d9+MNzxoAwFKWwxiv2xoRsnIW0WelBS+bJ/lscRVtwe9w70KBXKstX50XCu2BP89DyduTXqMSpeWvrVai/RYdd3Ew1KDyoM0kf6BhMiSnRCB+F0DJWvFMzlcmHlq8twsPAAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752507210; c=relaxed/simple;
	bh=KCOyDIwRhpGTZzCCDbQakUnQDZ/9qee3XIO6aMonGcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tb7ZilMvur6fIzE+DDK9s8ZFhunGfgH9FC3NC32/iVfdUV82YX4lVNqNnBek4TWpZeB6A+qQDXMRcGINjLUkQfViq4u6tZSiteR4B3xGBiBsc3E4e8PRlzenwBpKmgUXRmPbbwmmDnGme3rgHsDNo6RbW0NCkoG+GYIjNrUFTKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ezKTdRI8; arc=fail smtp.client-ip=40.107.101.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PMhJbtCQ1RRK7crW/DngygRDyVACSN/ZSzj5/2zQX1pMFN9oAtIOd2U32pORRkVAB8Yp1Yp/mWUf7i3nOJjF4b74EqtyGsBRzCpvqEugcbwGyEecq/wDOOKuc/lVVIpYH6aUH+oD05g+Y6rb46MPAlYR9tYB0OQ9tiPICOVk1HBIgk82afdx0yucH2ZKFw6r6Yws6x8Gn3g0RPbeVeupSYeaSfjkL7Lsj1y8BxWTESiOkQhW+3kb8rEBxC2w7EpEFegDrvPlvjF/qIVZV5qzVtvgTdxF5XILv6KKRrLuno/k5BrpmXG5ANtD+JEVDnvIG/b9Qk2VR9QC6/EuqmkKpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6J49ZAY3w/9bT2btBaDtFUR4t+JYHzlUSkuydoZUXww=;
 b=BZdM9v/5R5+ykml3T+d6KKGuJnwW+BGYoqLaaOOehk8GUPhZZ/Va/DK7t4VWootkwUQtIkIpwujzzN2r88xamSgI1co6uR6EZRlywE8v2RAKp4ENvxIaWLJr/p8aGETO/3b1pd6LdSk7Jh7nU1h5lUkZ5UYR8prJ6FTVXmqqTqgC4r6yeTOF5VupE8mvq2J7ug0ufFp4LRytpxD27W44eCjZmv16tMI4MDC60rxxceSIpIdToiUY1zOTomnqoadPE6mko9rmjcdtt+3bQqX1jzdLD0VN6rpM9kSTswFSui/6NgpOW01JBqmHXZb5bwH3xs7Cwhm5ZUsZPzjIJYO+oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6J49ZAY3w/9bT2btBaDtFUR4t+JYHzlUSkuydoZUXww=;
 b=ezKTdRI8mLjMTkGNE2bHmlggcxQjxzfhHb6f3XEsZoNRotU9lCILlhyWQsVigy0ylxOqaoz0FR/+vCGgbOtcSnHy009XYTCJtYt74hVC8HP/wcS4P3qTfrKqa2YMgYBbI/FCGnnZi1V2kCrKktLCW0nddZwr/zQaiaRLzFd/70UwpdDwgaC4xuwaid4d+ibSrQdSVVGEdVzQC7NlL2dY1SNrsg1gxyS0N5G/OzmhGY88JrzT1cNmAIDiIC72CHtMAhZAIRBoONXV+rEdlnPugoPuwGh1395VslHL3/pLuOve45c3OCOP4MWzXY537oh6pyPnCBA0VVWFYfsCD+9OBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DM4PR12MB6184.namprd12.prod.outlook.com (2603:10b6:8:a6::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.25; Mon, 14 Jul 2025 15:33:22 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8922.023; Mon, 14 Jul 2025
 15:33:22 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: Balbir Singh <balbirs@nvidia.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>,
 Kirill Shutemov <k.shutemov@gmail.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm/huge_memory: move unrelated code out of
 __split_unmapped_folio()
Date: Mon, 14 Jul 2025 11:33:20 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <A20FCC61-0809-4308-91F3-6F45E91FEF99@nvidia.com>
In-Reply-To: <d0c7b14a-6ce9-4e3a-8cd8-7cce4ee7d7cc@redhat.com>
References: <20250711182355.3592618-1-ziy@nvidia.com>
 <20250711182355.3592618-2-ziy@nvidia.com>
 <d0c7b14a-6ce9-4e3a-8cd8-7cce4ee7d7cc@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL1PR13CA0257.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::22) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DM4PR12MB6184:EE_
X-MS-Office365-Filtering-Correlation-Id: 7791439a-c926-4d5a-e94c-08ddc2ebc492
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SNmP7fjYakTyLCj23L7kFQsYRB013JDaEPl2cKhffc5lnEvrWEDYzrN+p3lA?=
 =?us-ascii?Q?spSMFIMHGsHLRTPeBhjlR8FycgLPZO3sgmbNwT8VzcYyS1MuxJFSvc/qavVa?=
 =?us-ascii?Q?r8dW6JbfzTt65xJbwMiPT2CElxVGhkEMxz2tRyWluRwSESji4o/vCqms+ha/?=
 =?us-ascii?Q?84gpHlUsScmZ2axuG5XlR1GvIGUaBiSJyyuyYLCkRV0lxVHP/v1BCvi+KdMu?=
 =?us-ascii?Q?yNUI6EZXVnCgDjJUVzNFfH5vniM1mAi2mqnz4LryI3SpQAhEe4zyXx9qqjPR?=
 =?us-ascii?Q?PpunvAkSveZcvl3s4m7hXL5+LZo26M4nrPtIr28tk2xb5ChOgeVOKg/dSbIw?=
 =?us-ascii?Q?tieVCllfOxNQvkZbC8v/L/4rpFh7wLmmobG6eovwpEWxuW1wP3WCDf8XIexs?=
 =?us-ascii?Q?7lpA0JSlaFFmgMkui7n70nNdLRGxRoI1wlJnFYbq4rFQHRTPQLpoeUI8XP0L?=
 =?us-ascii?Q?zEEHz4XLdeSkJt0wIofCBIJgoF+kKIOMF6NuDs8H+2MNe6ekKcvF6J2dELLN?=
 =?us-ascii?Q?6ssmqeRC+15YKKWp9A8zHRA0KIcmZe+QRGn8vbh9lrX7WTnlHRtsjyp//Giw?=
 =?us-ascii?Q?z8vBgnVkTAldnDLmEkwa/LOApMUUF0manAbnDm1wyd8hNcy4HXX/fCcW4znF?=
 =?us-ascii?Q?xgWG+SKVJxCCq+X2/tjnGTSfpO2iKTYUZFcad5K3SFj30sxrm0R1U7XLAdkn?=
 =?us-ascii?Q?ZULZGjZ25HBOo6yODJ/7b2FgbfAM4LUAe3sUc7lnMmjPPDTGyQ8ZUukykA3R?=
 =?us-ascii?Q?xMjqQIah9NsroaFCzsiJclYJ1igqtohPDvyu/gqa9DsTYRPI+P8yw1lyvz0J?=
 =?us-ascii?Q?rVtUQnB+bhD18adFvFn0hjHefU5cSFOcrwTzzP87EvtmSbhT0YzRENSpuvFQ?=
 =?us-ascii?Q?Ih0ece0o19aNVuaDk6LwuWQSouSzHxx+2bc7pBVwLY73CtpaMS3sHDySjA/R?=
 =?us-ascii?Q?iLXbgkpvA9CBpkhas/gWOfFNfxpncYieVp/Ly/8hoyNHEcnJjCCZNf25cZs1?=
 =?us-ascii?Q?6ShxwWad+4oDj8x3PmQxKBdpcLCnpO1dI0zPj1dvthU5ZHGnSFvNe5YGQRM8?=
 =?us-ascii?Q?vgGgPOV0inQvYrxNRMKANyunipEmPrQZSreRNPKyZY3Nhc1FIObBT0ii0twZ?=
 =?us-ascii?Q?l9opqXwcr26qv3djBp3m2cN66WltcK55a7lAgcJde7XrDYECTl0gPFwYTriz?=
 =?us-ascii?Q?DI3gSPaZOuIYnWI2Yf5ZgOGWcD+5lNDTukxzmcnk6BSMhPT5AQ7OHPcEpjK/?=
 =?us-ascii?Q?W3Q1hfyeap6e8sZe2BfdB3xeKVCGXGJv+II5JWU8moj2KEHZssjmQdkY+gx4?=
 =?us-ascii?Q?ovU27Ud3tcJ15gEt4uEBywRRjlyOheo9I/of+1n8whRRuSjlPnGuCx2wbHHw?=
 =?us-ascii?Q?q7LYEwtU5EGGhYtuIGAY7M8q8coPT5ZBBxkVD9ZF2vrYmDXkr6Z1V1YXo6E1?=
 =?us-ascii?Q?z98+oMoDsEw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LDs+dyukL24D88LL1+FyDyVwfiYePlS4NS02birOt6j5kAUyG9YARbGh7SEl?=
 =?us-ascii?Q?AaZWP8OpTFx4J1MvQl+hcGhhwfAgx8teLNgnek1E+ijswUBLbAJuvPR7ocF1?=
 =?us-ascii?Q?DXMqQvrjG5UBRh1mU5r1lrxMTMTwnWHxKTEhVuqqH0vmSstT2wiai2okEWBy?=
 =?us-ascii?Q?mfg7hACAQAJuh+OxUB4DORHzCszGiDthpviCgU8wGshP55h6acnA/zZ83Tq+?=
 =?us-ascii?Q?Bo//kxiz9VscvNqJFLncYJW6ALIyYEsz7LqNnK5V9pQbaKIk3G1syDc+xTGd?=
 =?us-ascii?Q?X8NfsQpersHifasvoMCn/1kBZu3hRIYYfFKjGawt8tquf6DwKdNlePs+wlTK?=
 =?us-ascii?Q?LSjsdsEAj59IzzhdSRgh3GxqopDeVm1o83kBxwkRjzYN2YsSuQs+1c/a65GY?=
 =?us-ascii?Q?TNd2T/PfKXGByMvstNaueGW2tbcj3CYcJN5sWWznYqsIEmdWIgnQD07Gokia?=
 =?us-ascii?Q?4O6P6zVaanIitsCmQiQQ8G8pzFFNXJoP+oWupkt6Ucpg1yLnWXP1KEQhrcSl?=
 =?us-ascii?Q?VtQqkRykJ25mchj65+WJSZznscRntM1ssZcyKsK403OSSBkAzPfzBTg5r7Xx?=
 =?us-ascii?Q?bZF+Z7jMqF3ua5sXzhY72A7MSvBbybN7OsYqs68KmDxLlRRjEUIF6dWBv7Wh?=
 =?us-ascii?Q?E00h7R4jRFs4FA64lkjp+zNGyHwkOGm7imExxD1NSgb5hKMW0ePQFwATbONd?=
 =?us-ascii?Q?J3e2V3cp7/zuFFNO5CRMKs/LlN8kWhutpE0uQUwYAx7bTXkiV2oxOFH+qYB0?=
 =?us-ascii?Q?VeY3/x/CJNkKGDSWVsZvVGca3PkBju5Qj/oxZfVQ60AYzoAwgQIBin+wZzeg?=
 =?us-ascii?Q?zHHJxAw0raubwGrJgQQ9GLJmIvLK0VPGSelkj0D0EQ7mn7/XuFYt3AQQP1GO?=
 =?us-ascii?Q?P2IuBQbP9jfbvp16e7Gb9y4ZZ9ndw5TSeMxfDMVacIdN7Zrvx+ItxZlZ2u1X?=
 =?us-ascii?Q?NjsRD8cwIw/yy1YBVYZmtOskXA0D6MMbG9PQ2Wxl0B/buxon9HEe496BIuCG?=
 =?us-ascii?Q?Y8uNhe9j/1sye4aluQClbnLJxEPTho/cH0aLonofz/xiaw8a1I1e9GwJXGWS?=
 =?us-ascii?Q?8cbNnvHQWUnSaBTlyx0IDpXq8IvKcY5gBrnjTmmHQU0e/x/TMz5pDnjP9J1G?=
 =?us-ascii?Q?Ujow0Ib0rl9bVBNViDOzTm+AEqiuEvxOH0DyQ26Dk5PYodggr+IJkTHAsrQe?=
 =?us-ascii?Q?J+RaNTrPXTTR955W8cWUMXFNGG5ysih1/X3GOtmoxx6AVVa/gp4hQx/8KZ9u?=
 =?us-ascii?Q?EJxi3b3wdA39SR7haiT1NuGCjEb5ZH5tCvYuisDYdqzEP63OIBew5A6mUxsV?=
 =?us-ascii?Q?iZOb5koNWNsLMvQQqU+xmb9rlhzZg/yV8AmJbkGwar1SNPqGXmpiojCRco/c?=
 =?us-ascii?Q?XENCZapzdsWsLkXAjg1u5BS+XpC2v6m+/S052mhjbfWIL2nf7b8LiY6bK/ah?=
 =?us-ascii?Q?wrpDxK2t7DgdWoJL7G7Jj+4Rhw1mXZcoW8p76tCponGNPUKg+PZnjsPFZgLG?=
 =?us-ascii?Q?BP//C8FYv6zCTh4GSPsQ0+kF49rr3Lt4zqNcd12N8EIW3viLQInm8UX/6eEN?=
 =?us-ascii?Q?HjxXIMzOEm6BaxbOEAOYhvkI9qaMlNyvdfA6XMRf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7791439a-c926-4d5a-e94c-08ddc2ebc492
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 15:33:22.8600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3pT1a3rPlilX8h0T/9wQgZnAfQQjeiZ4BR+qsXkUJFlkaOEiQtfnTxDO1uiyMDRm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6184

On 14 Jul 2025, at 11:30, David Hildenbrand wrote:

> On 11.07.25 20:23, Zi Yan wrote:
>> remap(), folio_ref_unfreeze(), lru_add_split_folio() are not relevant =
to
>> splitting unmapped folio operations. Move them out to the caller so th=
at
>> __split_unmapped_folio() only handles unmapped folio splits. This make=
s
>> __split_unmapped_folio() reusable.
>>
>> Convert VM_BUG_ON(mapping) to use VM_WARN_ON_ONCE_FOLIO().
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>
> [...]
>
>> -	if (folio_test_swapcache(folio)) {
>> -		VM_BUG_ON(mapping);
>> -
>> -		/* a swapcache folio can only be uniformly split to order-0 */
>> -		if (!uniform_split || new_order !=3D 0)
>> -			return -EINVAL;
>> -
>> -		swap_cache =3D swap_address_space(folio->swap);
>> -		xa_lock(&swap_cache->i_pages);
>> -	}
>> -
>>   	if (folio_test_anon(folio))
>>   		mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
>>  -	/* lock lru list/PageCompound, ref frozen by page_ref_freeze */
>> -	lruvec =3D folio_lruvec_lock(folio);
>>
>
> Nit: now double empty line.
Will fix it.

>
>>   	folio_clear_has_hwpoisoned(folio);
>>  @@ -3480,9 +3451,9 @@ static int __split_unmapped_folio(struct folio =
*folio, int new_order,
>>   	for (split_order =3D start_order;
>>   	     split_order >=3D new_order && !stop_split;
>>   	     split_order--) {
>> -		int old_order =3D folio_order(folio);
>> -		struct folio *release;
>>   		struct folio *end_folio =3D folio_next(folio);
>> +		int old_order =3D folio_order(folio);
>> +		struct folio *new_folio;
>>    		/* order-1 anonymous folio is not supported */
>>   		if (folio_test_anon(folio) && split_order =3D=3D 1)
>> @@ -3517,113 +3488,34 @@ static int __split_unmapped_folio(struct foli=
o *folio, int new_order,
>>    after_split:
>>   		/*
>> -		 * Iterate through after-split folios and perform related
>> -		 * operations. But in buddy allocator like split, the folio
>> +		 * Iterate through after-split folios and update folio stats.
>> +		 * But in buddy allocator like split, the folio
>>   		 * containing the specified page is skipped until its order
>>   		 * is new_order, since the folio will be worked on in next
>>   		 * iteration.
>>   		 */
>> -		for (release =3D folio; release !=3D end_folio; release =3D next) {=

>> -			next =3D folio_next(release);
>> +		for (new_folio =3D folio; new_folio !=3D end_folio; new_folio =3D n=
ext) {
>> +			next =3D folio_next(new_folio);
>>   			/*
>> -			 * for buddy allocator like split, the folio containing
>> -			 * page will be split next and should not be released,
>> -			 * until the folio's order is new_order or stop_split
>> -			 * is set to true by the above xas_split() failure.
>> +			 * for buddy allocator like split, new_folio containing
>> +			 * page could be split again, thus do not change stats
>> +			 * yet. Wait until new_folio's order is new_order or
>> +			 * stop_split is set to true by the above xas_split()
>> +			 * failure.
>>   			 */
>> -			if (release =3D=3D page_folio(split_at)) {
>> -				folio =3D release;
>> +			if (new_folio =3D=3D page_folio(split_at)) {
>> +				folio =3D new_folio;
>>   				if (split_order !=3D new_order && !stop_split)
>>   					continue;
>>   			}
>> -			if (folio_test_anon(release)) {
>> -				mod_mthp_stat(folio_order(release),
>> +			if (folio_test_anon(new_folio)) {
>> +				mod_mthp_stat(folio_order(new_folio),
>>   						MTHP_STAT_NR_ANON, 1);
>>   			}
>
> Nit: {} can be dropped

Sure.

>
> Code is still confusing, so could be that I miss something, but in gene=
ral
> looks like an improvement to me.
>
> I think we can easily get rid of the goto label in __split_unmapped_fol=
io() doing something like
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 14bc0b54cf9f0..db0ae957a0ba8 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3435,18 +3435,18 @@ static int __split_unmapped_folio(struct folio =
*folio, int new_order,
>                                 if (xas_error(xas)) {
>                                         ret =3D xas_error(xas);
>                                         stop_split =3D true;
> -                                       goto after_split;
>                                 }
>                         }
>                 }
>  -               folio_split_memcg_refs(folio, old_order, split_order);=

> -               split_page_owner(&folio->page, old_order, split_order);=

> -               pgalloc_tag_split(folio, old_order, split_order);
> +               if (!stop_split) {
> +                       folio_split_memcg_refs(folio, old_order, split_=
order);
> +                       split_page_owner(&folio->page, old_order, split=
_order);
> +                       pgalloc_tag_split(folio, old_order, split_order=
);
>  -               __split_folio_to_order(folio, old_order, split_order);=

> +                       __split_folio_to_order(folio, old_order, split_=
order);
> +               }
>  -after_split:
>                 /*
>                  * Iterate through after-split folios and update folio =
stats.
>                  * But in buddy allocator like split, the folio
>

Yep, looks much better to me. Let me fix it in V3. Thank you for the revi=
ew
and suggestions.

Best Regards,
Yan, Zi

