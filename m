Return-Path: <linux-kernel+bounces-836827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E60BAAAC2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 23:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C8CC3B9244
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 21:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7848B2522A1;
	Mon, 29 Sep 2025 21:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="imfbKcqo"
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011045.outbound.protection.outlook.com [52.101.52.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D136E222565
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 21:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759182873; cv=fail; b=kdUx9ZI+P5Mc+RDXx4eZhbrGJvIzZtTAg1ls3UR2dZIt+prjcyMyeKeuD8uPrRp3HhoJ3tO8TlPSjRutUvfgzxiDIKUdYuikgpm+/p+q6dA5RuX5JD7y0gau172a/4BNGvzyXjO6R/zOBorFgeRAaqSEnEmPi5dypKeuGun/UYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759182873; c=relaxed/simple;
	bh=daYKVhMjw9HuiVtxzvXzhavKH7YolQd493nsJ+2ecL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=H2tyP7qs7Aw+gTj5m+0GPIUB7j3kVXJg0eRzpVe5B2oD5dgqrQxDIR8QjF28TVqaNsUX1krNKoLUMcU/SVIHdh7tPPtmSw5U91EcN1oM937KBr6+av4Uusw3U6A2SCtlS+VgOvz+bDg1AZ244H78XKj/iUokT/28MxuDfinoeI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=imfbKcqo; arc=fail smtp.client-ip=52.101.52.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uRBbd5U8alb4qv2jJMEcMGKhd+LGkFK+X3B7mbHYjXr/s+6+a2EfOn53lO99/gec0PJa4+OPVzKRxhKDnXr/E+p/SsUDndVkd4f7jWQImu96RLg8IyezhOHb2BzWkmSj3fCGfjXAMs2kuDYMKSHpWA9Z99BqO5v0WX+Nw1UpMF6qhi7zbvjV4FX0sPCz7QuSD4bn9UqeeKssbh0a65faSe7+yhbMSykUtc9Di4ylv/EmO6qkZ6dUsy35/iBxlfMS3I5Vwuw1hTYYAsmrKd1nzNwZpsJ6zn1lqIaT/Q4BWobiGPnnnvv6bQr3yGG3xK1551VXPsgPgdOOXrn6SHOeUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qMKs5JJB8MnbXF/wP/o43V7sIijVfKHZ2nqE6E4m474=;
 b=oYzMd6Tu/5ZtJWSIhUhNCnlMNGxYKv5qIBxyJY7psquBN5xHzBHX48G6mJH8FzHZx88lZ4ULWAJg3R9t+c3NKmUGvI7SrCOU+dSo2woPX95eELRIzW/w7awNU86Y9PZE5s9kSjgY2kY4okykvMbjnikqF4Dm60QHCzUIqlxhrpf5VrLprtthzP2UVqQL8VQF5n6H1t3KFnjSoNmB/pvgJlLiOHPwJmSEgtGYF9T8D9zGD1mN+38zUEuk2/GXLMah/gfjnmNhWu7VpEQw9Fvz5HYKN7N18mNiWScOGLXyGM8X5Ddx9MeRu6+Fp6lzYAW1lGCGn8KX2+Kd7LmDErEEXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMKs5JJB8MnbXF/wP/o43V7sIijVfKHZ2nqE6E4m474=;
 b=imfbKcqouNG4WqxsJlTesT8zmuOgrPM6AnrIC/reYpkr+0fnjahBm8B/cMJ24GmxiJOyD6SujVUpuD+JGu9sG0keqfda93LBWz8AOSYV4JIbQ91y/kYsTho85xVeBsuA5ia+BKgumhqLUZ9yyqvyKaVjCd46usjtHoxFy2fDxDAkWD9+bpCdVPMBEuIne3HtNxHH4r3L6d5Yi07Nr6NzCpoo1da7F+fNWG8foe8cX56MVRl5eyar3L1N1sgaH91pi3GDLJvHLkV30uKonTdOlcQaoM7oM/UEbTBYw96lLs0+4K7QHZA1zlUBiv3nW8L+pMn78bCuA6crZ9qnkWFxNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 BY5PR12MB4324.namprd12.prod.outlook.com (2603:10b6:a03:209::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 21:54:28 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%4]) with mapi id 15.20.9160.015; Mon, 29 Sep 2025
 21:54:28 +0000
Date: Tue, 30 Sep 2025 07:54:23 +1000
From: Alistair Popple <apopple@nvidia.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Zi Yan <ziy@nvidia.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/thp: Drop follow_devmap_pmd() default stub
Message-ID: <2tzaop2mm53kx7b2chcpbg3wegfl5kgqojerth4dyt6n3gassb@t4zddx5r3fkp>
References: <20250929104643.1100421-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929104643.1100421-1-anshuman.khandual@arm.com>
X-ClientProxiedBy: SY5PR01CA0118.ausprd01.prod.outlook.com
 (2603:10c6:10:246::16) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|BY5PR12MB4324:EE_
X-MS-Office365-Filtering-Correlation-Id: d267737f-dbb2-4d35-557e-08ddffa2c303
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uYaQ+78OZoMKooyryRwAqfA4XtLlufJ+Bt4jLgqcUyCqD5w4ZvTWaJzaPUfP?=
 =?us-ascii?Q?DbCRv+vvR2b/e3hzl105M4fFBWgGwQamrCQyMgS2OoY4P2gwEBRQuo0v9ldC?=
 =?us-ascii?Q?0RvNVGKBgNJpzr7Tciuu6415S4lFZnb3f0zFgYK8S6TzWH3ROm0sZtg6CRah?=
 =?us-ascii?Q?2ZhOyxgxbq92ADG9VUfo0bR1EGAucEiXHjyMRKE1wgHYsfSoEbGTtE18lW1C?=
 =?us-ascii?Q?qRh3BtxrFEUfoqnKw4FW8ci1C4Kfh7ldAtlxV7vhWfaFy7HBrhQ1RbBU0XcV?=
 =?us-ascii?Q?tKizyHfxmPp7ME50dut6v4P5V2JrgbnZIzRUPvGvicQdj2scLLL9JM+01GT0?=
 =?us-ascii?Q?TGYc2Fmr9DjDiTMRfAwgnpYkqWzZBqBGDFyaoev3yVrwFQFVIblMLGZ+ZCl8?=
 =?us-ascii?Q?idqQclg2ff3/DZ8W+zomZO0nGIDi0gclC2w20nlcNdYmCKpHgkouEcWwpgYj?=
 =?us-ascii?Q?TBKmYydcADQit7ZHTiLqMGKxfcQzELTMFwX4O/EgmkJs91jRKXmmGn4FeeHR?=
 =?us-ascii?Q?9AKhZG/oS3BixsSeZw0Bq5Uro4TEl1hpxhFBWE8b2RqZ7qNS0uM1tpYiMSQQ?=
 =?us-ascii?Q?hvBfSgsBnSBDwe7mos9MWvJWsnkMNwnfOSwyTqMTHdtK3Ae9U/OmYBi/B4bK?=
 =?us-ascii?Q?LtIu2DoOVNwy9wIyowMa5sOFuw5z1m3DgVxzoAGxfwlvDzuamFlzU9WOCvoj?=
 =?us-ascii?Q?nNq6Ro2CRzn/7KINDQcQ8cb+GyZe4/22OqUb84FvFwVnPkBm01f7JssXVqs5?=
 =?us-ascii?Q?YWp1FRNIjXaFt6zxaQ80016ysbBixNgYnfG6W672/jo6NPBYysQma/nOLkJN?=
 =?us-ascii?Q?fizFgTK88LSfjsCSZOG8cBQQm8c+ERr/P/JIWXSW3YcHPHvi5tTi2L755fxM?=
 =?us-ascii?Q?wanGtsGEYoAviLcO8w776OvUHjEP07XizT6BmXUiUWIucIaS3LND/0noWWsx?=
 =?us-ascii?Q?CI1O2UI1gTKd7vh6jWFzeF0cBMqybfL9/Oqp+HMmojwq/3I8BlTkIAAzg7K9?=
 =?us-ascii?Q?UDqRz5UXMS55pjXjE1R2opANNC3XVYr+qhgCOzQ6Yd+bd43rBavlk9eg+Wly?=
 =?us-ascii?Q?94t48e/iLIOiC2CfkZ/BxabTLt8qTYBAD+V6Ei/1sd66mqgvxFam0/ay+F4n?=
 =?us-ascii?Q?I34TongVQeOPwr0CWsjQuBqaXX8H6dMfs7lFK3JgGzFS54Ouz2QhcKbjcedG?=
 =?us-ascii?Q?EXcATxbrOQM2xbo3gpkdTmOYL01c+O7KGcnK/bfOfnI8xVRNk/hnwh9/8Ldq?=
 =?us-ascii?Q?p5hNvY8pVsEmctaC/pcS+oz+JDqDGoxjFe/3VfQVocvuT8cyk4dGjSVd/K25?=
 =?us-ascii?Q?X9w/3gVSEiKSb9R06PRtEs55xtM7k6t4TBn0sK5mFLelKV5M2uavMnB3UA6s?=
 =?us-ascii?Q?NsUvq2qO3ni/vjsJC2iC+PkQFbeFwa/P1bL22KpbZnzqvwNNeR68tX6fqIhM?=
 =?us-ascii?Q?msu0THcD8aZHiiIkja/OvnrXtCR1pX/b?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3oXJF33pxq8XnIe44JOWIEmBYuIXMnReoGYnbIH0lPd1rGLOPDAr80499mGy?=
 =?us-ascii?Q?kb+PNnFfsS1JcYxaSHxYIZPGP6ojQjY7CJnSzyY1SxGQTkCoDehDiW02O434?=
 =?us-ascii?Q?8q7cKGbNH3pRxckyzH5otU0XCLEhHfVo25Am2odNciTPBXghAs+GkABeAiw1?=
 =?us-ascii?Q?fOhHcZy6ZrZcZulf2B9oh8B5yLPFD37mIXvQ2OK88eqPFlp8hfzU4GlPibYN?=
 =?us-ascii?Q?gjMHGG8z5pA9OEW5ep02RfSbdsEatkbp+0Y8IdBTaJXPmmC8rEK6afMmwmlf?=
 =?us-ascii?Q?eu/snuEm9e85shthpXLcnhIpNBgTYDdewn1CpmSgHU6ZXgu9mnyBB/J/68IM?=
 =?us-ascii?Q?teU45kM03mrx9yn+6rM43Wia2UMlyfZ7ziciEOUNy1BvgHN7wunN/r5YC/wW?=
 =?us-ascii?Q?BI1AxnUIYI1HRr755YRde+3IDjiLfIkZCwswva9pgiIWZ76SrleUjRjHAFkC?=
 =?us-ascii?Q?tr6ZRgwsbxanEg2dLYYjvCNHN27OA/cOCO4rvl9qZ6Lo8i/RgDcMKLLHw7Zy?=
 =?us-ascii?Q?e80myEEniXZyGtxXOP3Xkz0a+IOHMeiqBtWflWH0hSf+EUSByCAKCYl+lYyh?=
 =?us-ascii?Q?dyL+QVduUqlhc0Qy7w9bQF5iPbcIX9ofZBfOTz6RgG2EsFLHUnkf7oS/B3sh?=
 =?us-ascii?Q?kgMfSB9kJEmVRPaen3MBfGtfUo/GRWSwYrW45q9caJKGu1BhrisQadh6lHZ7?=
 =?us-ascii?Q?Aj7ZE799jiwAvX2uCSqiClXkJsyMsNrAsVpH4kVhtLuxddEEfOJy4uyMDOW5?=
 =?us-ascii?Q?NfBHpNgKLPMr2l5AQWZeQhPDXqJ0siZ3RtcX6MAJpN5S5mFGHGyhwUxQQr02?=
 =?us-ascii?Q?1EbekvHpXNbZJ+LsehHu8GXYscSF34o8vGQIJ7D9rjqy5njn3/V63AI8c2m6?=
 =?us-ascii?Q?TWetrJWv8YqOJskLqBchQChX4RzgWvxO/Rvaj9tP9379UU6HoJvVoY0w+7O3?=
 =?us-ascii?Q?bfDIJRgUma0HVG4eVaVmxnwAkz9Oki0LwkzDZugqf21IV85sv6PjTYTVvnZD?=
 =?us-ascii?Q?hzhJSwI0AOYoRhtjKRPohDo3aOSmNOxxfO56szQpqboyp1kQb5Al37qe3Unc?=
 =?us-ascii?Q?bSaho9lxv2DATrDT9dHVW63oV6ErcEkhIXUe5NBOeUH5pCYPlJt+TDuqsr0v?=
 =?us-ascii?Q?jeOtquB3qTsP3kAvN8RFD128+iqNlAzSC+1LBQqmuaeEAMVZBIVXCFC4qUsq?=
 =?us-ascii?Q?2iMHjOYsb1MqFdWzbs3zqraoYtXRUwyhnDzgUVrNNi72VEaeDJKtOkdZWRq9?=
 =?us-ascii?Q?DkP7IqBSTRNrienXoCZKeguvcmrYSKNmbX9t7dLNEchDPB2x2orRkSCZ21He?=
 =?us-ascii?Q?GuVb5GA8oqmH2pedn9uEzOIy8S5LL9sX0qOSQfJHjsa70CVBW5QarTiRvmFl?=
 =?us-ascii?Q?4/95gHCbSf7rLo12vLjz6HgeWFwh5dM5VL1QSW0WKuYl+/HXpY3CENteS2wN?=
 =?us-ascii?Q?mqLi+HWACunfQObPIzFrVkBOmGhinjol+/J5DtkaJYssJk0HbEpQVWP17g6F?=
 =?us-ascii?Q?YiXIW3MgxSJQWBnsRWkfYcuS8r97TBy3frKDUcfLOobbwNmZ55Z6wV2N0J+N?=
 =?us-ascii?Q?edh6Fqm63NDdj0QOMion66IbwsPWyNDGwnKz/IVL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d267737f-dbb2-4d35-557e-08ddffa2c303
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 21:54:28.0114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2F040/hb/nIawver+Y0np7DT9YHfsKMqIlZKYmbem+wv/46roHRzlhxglKOX+o7rhv7l0J8AMz7tKZ6VbZY/HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4324

On 2025-09-29 at 20:46 +1000, Anshuman Khandual <anshuman.khandual@arm.com> wrote...
> follow_devmap_pmd() has already been dropped by the commit fd2825b0760a
> ("mm/gup: remove pXX_devmap usage from get_user_pages()"). The fallback
> stub in the header which is now redundant, can be dropped off as well.

Looks good, thanks for the clean up.

Reviewed-by: Alistair Popple <apopple@nvidia.com>

> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  include/linux/huge_mm.h | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 7748489fde1b..96ce0ca54e49 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -652,12 +652,6 @@ static inline void mm_put_huge_zero_folio(struct mm_struct *mm)
>  	return;
>  }
>  
> -static inline struct page *follow_devmap_pmd(struct vm_area_struct *vma,
> -	unsigned long addr, pmd_t *pmd, int flags, struct dev_pagemap **pgmap)
> -{
> -	return NULL;
> -}
> -
>  static inline bool thp_migration_supported(void)
>  {
>  	return false;
> -- 
> 2.30.2
> 
> 

