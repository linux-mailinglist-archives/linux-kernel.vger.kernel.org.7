Return-Path: <linux-kernel+bounces-823482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5427B869E7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 21:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A8533BFFFB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 19:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2122D1905;
	Thu, 18 Sep 2025 19:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EqYM8Wnl"
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013021.outbound.protection.outlook.com [40.93.201.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C374A2D
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 19:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758222471; cv=fail; b=F0+ap/UnCRO9enTbi/9p7Y9RRkMVikdxhH9mPnb1qsIKk6IyY7+C8AUkKdcKKwOyG23sp2tuoHkkoYrw63i/WbMzFvcQlo0T/iIuebfijsf1d+c2wfaoBGhJrjuQzOVT8FOcsLrjgSm3DkW4hsgqPFxSYHXPUApviw3u1YpfpVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758222471; c=relaxed/simple;
	bh=6efY2+Qvoc7tMYE9MZrL2BRIuPMq3TWikzIcQ5jxYyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X+orfheLWAyzymNlnaG8lrSFZa/rdG5567q5e9+uGlnFtVfIVZijhyAHIQakNidYCCpoiJl8oN+LmYacJArvr3M5k41oh4/MzSEppZ8QmQ0zwrv8QSEXzLrhOxTGEcxLb5qRj+wTbltovwwFt7cngkBoBC7B9BG7Te95fXkrXOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EqYM8Wnl; arc=fail smtp.client-ip=40.93.201.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dfIZPUWC9wZltFoq7Ckv0gDtGRJHebPIJogDWJhqVV6Z29RW5tXuYQVCttPh0p9vQVHaIq3KbMcVy8DxAao0L4kW4pOuH4PcK6Sp8Nizg5bxqxauyGonyOgqk93FclDzSfpQjc44Wx2pZvkh55mscAHQg8hbVHRwJtXsM9+5/kKvhn9eRqIY+u7Y3ZjpynUUPFreSdQAXkuWLYoZ03m4lrr4AK8/VkcoyAqj13w7P7P/AhhuQgkBrUpB7oBOuXZpMOx4VI/karLeEKQAn0+IGxFL8O5/5Ep/zktu8lEEIUXyMgXjZFkpCN4lcpWKbNx5C3xo5rUcwJ3QKMEjK+AsQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LHQ1GsJyq37ZK5GSdbMI0I3uZiYr1KlJwQp2czvbGPM=;
 b=WJi5xfuanz8qcgGnqPpJsuqTm7RObP0HoQmMJoPuU4R8oR7HR8QrC/txwYtk3i/N+dxRLhGsKpaixXNszUDj89twRITALiwy0gyXdYfxDkanGIV0Cfv8jx5eZ0nSx8zLCOjBpLm4/Trm82qcjaAD+wLHKN5t+esf0VzgWnNTWen//AzvA4loKnpN0hXF3K8il11tyHbrcFM+wUOedeOsqfeVriaN81Y6e/YyeSGzYGjtRmutL7ONkegz60Zvf6MjGBEeId89S8IOZ2buosYyH7hiZH+8x2TLIBv3QY0vwispK7Z16E3JdqZs296nJcJQrN9mvmbp4h7dQHBBxUa7+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LHQ1GsJyq37ZK5GSdbMI0I3uZiYr1KlJwQp2czvbGPM=;
 b=EqYM8Wnl6TparRrGsu1HtVAzNd+gFiIR8JQEHobTYQ5qOV2B0gBRv6SHkXwwWQnMD6MoUFdVFepi1ZHOyYu8KtlfRqtvEMO+GcKkHZGNfDSjPp6YACY5CjFJent7IdRM64v+rDLxOHiFOWQwWYg9RJs4wL2uQFZbQe7lY0NHiiN0G1zh1+N2aiN7mww5oTJqmSzww03g+hw5Dvr+5N6hpqlxg0IEoCtSVzgHv30ZBQaTZX/9tIw83chGvXQnepiNlK5+seuaUKkVKLtd11fSnTEa+i8ezdY0+7n7MtINcyUCXA+0sV10aFTD+MkernIzJY790xbOEspxdnyPxrW0YQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 BY5PR12MB4209.namprd12.prod.outlook.com (2603:10b6:a03:20d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Thu, 18 Sep
 2025 19:07:44 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 19:07:44 +0000
From: Zi Yan <ziy@nvidia.com>
To: Lance Yang <lance.yang@linux.dev>
Cc: akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 ioworker0@gmail.com, kirill@shutemov.name, hughd@google.com,
 mpenttil@redhat.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Kairui Song <kasong@tencent.com>
Subject: Re: [PATCH mm-new v2 1/2] mm: make is_guard_pte_marker() available
 for hugepage collapse
Date: Thu, 18 Sep 2025 15:07:42 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <E6C0F9F8-B024-45DB-BD53-2BB964EC7703@nvidia.com>
In-Reply-To: <20250918050431.36855-2-lance.yang@linux.dev>
References: <20250918050431.36855-1-lance.yang@linux.dev>
 <20250918050431.36855-2-lance.yang@linux.dev>
Content-Type: text/plain
X-ClientProxiedBy: BL1P223CA0044.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:5b6::17) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|BY5PR12MB4209:EE_
X-MS-Office365-Filtering-Correlation-Id: d54abd97-fd5e-4ffa-54ef-08ddf6e6a607
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NeiCL+SWIip1DeH/2C4RfTnJGuZssLli4fBKy+XtYvCnb6wsLF7UcoadTOrl?=
 =?us-ascii?Q?Yqmsk0k3SIlof5LtlK8XWl8kWdVRUW98+aD8DleOmkjkQ9axMafk11HgN402?=
 =?us-ascii?Q?3EMNNugrMDjLQVyj1r2cE4G5f1TwW99t45CHEoMv8fyq7CNE2kYkIlbC0i2B?=
 =?us-ascii?Q?nPjHsCXd4wz5/Lx4Dsq8fEB6GLTEXypv8fG2lZV+ScChzTBfQ6BTVacrUEOn?=
 =?us-ascii?Q?w/ZtBYEO7o+HXGH9UhCNPBaV9nGtpDUlWLg5dP5S8qYQy1fDxyQ/UO8Q9XhN?=
 =?us-ascii?Q?vqGsbt+kDu759kvBi/XRZzT/nOerYv728Ai6KX7w0HQel7nr5dRF9jeG7gT0?=
 =?us-ascii?Q?p0FoI6nDKgM1uSgEia2M1rHWnjOGqHsrnM/gtpOcaZa+FrKOF+uWjBysiyOB?=
 =?us-ascii?Q?HLNuYX2YeHptod6cUtg6GpUqz6Y2B4IooVW8u3AxSU3ImRgNfIF0wrn4l5kN?=
 =?us-ascii?Q?f7hDRb/sMsSQXp0maAq7gZXedYBs8lozAGGYau1nxGwcprcDNnNC3WReIL23?=
 =?us-ascii?Q?iyXC00Lb+yl4w8n/5L2cRbtT+b1f6oaOHIAFmqgds9o/LTW6cy+pGe0dA8gq?=
 =?us-ascii?Q?1ebyqUxYzNrh8kVre6uIZA0jaPc4fZT1IEmphAav+CIdqNWZ3HW9QZXqWjMo?=
 =?us-ascii?Q?ZrDl2S2M4VjNUDKK1yflxxhfXqng/UyvVL83iPrvi0g9fpBOzLjcjgqvO4qI?=
 =?us-ascii?Q?Dz0MO7htuu1XDdFcLjnip5ED4zGQxrlmi+onZjV8hkin8iO1tO6kLFYf3jr4?=
 =?us-ascii?Q?KGsZa8GJzkA3dAaqajLAuqc3InfK7lZrt9QFjpVQ0ozG0ey31YGYDg6iMKCs?=
 =?us-ascii?Q?3YdhG/njJHXHUKHobBmQtluG9Uhbi5/uQvrkz+woGf7VJlbqbYMeOVaveuXY?=
 =?us-ascii?Q?tKNjGW+DLg+QfGebXhyT5v+7703PPnX//KEoU+GBHQEEi7nRXNhH3/D2Ges2?=
 =?us-ascii?Q?AIKlLHbAhYlgOFQwFo2A+uMVva2czPVIztBDZef5721Q15VN8yyo6HnGMPUS?=
 =?us-ascii?Q?SNcco7jnZkZrDT29kS6MG856SwxI875rJNVZ8+Zksn0mkS/YqDDHgaeynfxQ?=
 =?us-ascii?Q?rWj3pYjmUxHT5+UZ8niSNQ7NEFHfJlQRRsCBCSjQDoKbVNmFwSokFnmH4ApP?=
 =?us-ascii?Q?Tt8aXYJH9S+/GZmxavyKPe0ATlNgI2EIHshPKaw3gQSh7CTmIUCBi9mD4iqI?=
 =?us-ascii?Q?3vpbZ3h8+iJVXQyC0VejhiLfnHp834hg8iY+pm+2OuAlZ2fFx+M+80Qgv90X?=
 =?us-ascii?Q?lRrUhXctJf20qZKHBFpFwQGMYi9CLt0UOZas/XP9Yeh6Sg4msq7a/xm4d3Ca?=
 =?us-ascii?Q?UkmjufpIRqoL76g2dkkF1TRhyHSPfGY71Hzw8D5qua02g0hwH4fhVgUjYBBy?=
 =?us-ascii?Q?RZ5gXDu2Vwq6mSbF/qh3LrMdBZNgt2u47hXknd6A/goAMKexCg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?syBBEoadb2CN8nQfevmzADrsR3iWaQp13urih29wIXVlO4WhaSLo3ZhoY2Jq?=
 =?us-ascii?Q?mbuw/ke9bp+EeLqRzcZtJr+EAeyi/kkLedpsI6AJyBgHoOHsW/tXOLLnbE+p?=
 =?us-ascii?Q?KFppw1E3PRZHP/61p7fHN5vmC+arswNdZYFxUro9Vg5m7GdNn/hfUG+LjdN/?=
 =?us-ascii?Q?QFPXdQfUr/UmeHp/wHVL0kdydc9lUU8MGO0Q0Fq0nriCQRbEsZTCUOLeus/4?=
 =?us-ascii?Q?KZ7rhsTMzwZheY14kHu39dzjrG7NPC/ehtdfLIcYNP1bVJQk3mvyWtlj6xbC?=
 =?us-ascii?Q?RoFOiLlPrK98vMADWypeDVLU+23j9bY22yZPOVXXSCNCT1aJKJxNfrtiWYNO?=
 =?us-ascii?Q?3qEWXmdRzHQeo6y7miI6UBLa1dK0BhuL4Vi8+qOPRNJSnhQaP1ihdjGfGcz3?=
 =?us-ascii?Q?+jhIse76Zdfi0g7ubqF3h8YHwdWU/2z0qB4G/P2VskYASLS//oRywdqbYboO?=
 =?us-ascii?Q?SPYG4xW6Gm6xwLhD7Xj7EFMZvDkNqubI7mWSxpAliUi9HICgPfu/e9BDhPD+?=
 =?us-ascii?Q?7tkWQ2PDFXP79WLWpcg2LJ0jdO9ZbnFsg2UP/ZnCEH9Q5uxQq9TmnMhVu5rN?=
 =?us-ascii?Q?4Q0XuQLzxH7hDU5OXZv450xTNOirzU68rKPksvs6fxqdnQ3nEuFqApmNG+ZR?=
 =?us-ascii?Q?olDpF7KR1JkyBtTq6/GSERQ36IePbUFS8Ik3L6R4kMw/ey9APRe09dumsY7M?=
 =?us-ascii?Q?ovCkziBSl41RO+DInLJe02z8Tev42cEzT1M0g6GQyPbrTEoBf3Q/xcWY1scG?=
 =?us-ascii?Q?EhDBYbpvXgFePlpHcQ+h/fZhN7Vz80NP3e3gsLVvKP3/ZLFOXcnZgG5+WaUG?=
 =?us-ascii?Q?Xc7a0rSgl04vNtTUMkatM1aLZBjphpfT3nqinsB/QoApA/YjpcjFvAJR5SKK?=
 =?us-ascii?Q?gKxUqQOjCUCcv9OQNS/zaYBoLbd1sEvNXl/r4imPNh2qj8ozflkIzWDnX8R6?=
 =?us-ascii?Q?othHn+gfXzxq6XeMFTs8DCeijuOufvKVq0pbwXHTFAgudnTJllKiVu2xS8hb?=
 =?us-ascii?Q?NcW8M+Kv9Ylr1DEtB/OCtBOp0Y8QAJNNyHUMFBuVhirVLnb+Vvvesnr+c4BE?=
 =?us-ascii?Q?zTmdsu/J/GcEQ6PfhJNZgA6KXZZEDawTNyDxWEQKJer6il1EmwaxSQ+he82s?=
 =?us-ascii?Q?Rt7A6V4ougYuKLURbbb+HXD5Thnfc2zSeUwrLQijHREQ091ECY09E7rcW9FW?=
 =?us-ascii?Q?yT3584eAg3RtV73IAd989vzODbO4y+aP//RNMHEmSxVqMTTn52i2ncrXubsy?=
 =?us-ascii?Q?QkBFEJd/ZvxiJhxBuSBhORAIlzncAqFpN47ANP0RFgaLzfsu26og1z1WN9Bh?=
 =?us-ascii?Q?jGIqKDpw/HplAeaz8DtED7AfB/GHc/7PbkLLkX4HRDIPZ1EnDqgJVGRnOf9+?=
 =?us-ascii?Q?wlZUnIozaamOhouMdORiTwR5yGotVgJULBddRudrAEFeZI5YefGtiR/d7l3T?=
 =?us-ascii?Q?irCFQtZIIan962yO9H8YNeqDKAFM/qfV0Cebcf4B6RFRr6CcknKjXBZ00OQa?=
 =?us-ascii?Q?bbw/3d+NXw8sLyPdpYjVBdk4gLpO5fA2447Yav86pv9OLD8eafhzhxZAAJK7?=
 =?us-ascii?Q?shGJ3+Ykbi7GFDmihQmXcwTcKnR8TQon29snm9OD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d54abd97-fd5e-4ffa-54ef-08ddf6e6a607
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 19:07:44.6295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xeZzO9h7hkKwQV0N7Y6A7eoaAuktJaL1FM4a9bISIrLGQfs+eYp+y3O1euFFnz1q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4209

On 18 Sep 2025, at 1:04, Lance Yang wrote:

> From: Lance Yang <lance.yang@linux.dev>
>
> The hugepage collapsing code needs is_guard_pte_marker() to correctly
> handle PTE guard markers. Move the helper to a shared header and expose
> it.
>
> While at it, simplify the implementation. The current code is redundant
> as it effectively expands to:
>
>   is_swap_pte(pte) &&
>   is_pte_marker_entry(...) && // from is_pte_marker()
>   is_pte_marker_entry(...)    // from is_guard_swp_entry()
>
> While a modern compiler could likely optimize this away, let's have clean
> code and not rely on it.
>
> Cc: Kairui Song <kasong@tencent.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Signed-off-by: Lance Yang <lance.yang@linux.dev>
> ---
>  include/linux/swapops.h | 6 ++++++
>  mm/madvise.c            | 6 ------
>  2 files changed, 6 insertions(+), 6 deletions(-)
>
LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi

