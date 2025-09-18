Return-Path: <linux-kernel+bounces-823490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D9EB86A38
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 21:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 688401C8738A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 19:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F5F2C11DF;
	Thu, 18 Sep 2025 19:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="boyaSaSK"
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010070.outbound.protection.outlook.com [52.101.193.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3692C17B3
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 19:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758222786; cv=fail; b=NzbvgEwfRBdMMtUNrQ02lJO0jtH177hPLi9ehAfgUiTBBMWxby1x173uB6KB13IJxP9b4pTYKjmoBI6hyjhjZ7p5O5gh0BHyiDr0XmhRmvd/52HbBPLJhqeqYfRHlNcHbFLbGfcu1njg4lmrk1OAL9qQV7WHyeRDx4QLr2/KQis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758222786; c=relaxed/simple;
	bh=2HBwUBO/4l9VVT6WrKmS+ix+oIwDS34NnFlBV5R3m5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o0IueTs3axVOu5cErbY3WYTmUzGdD8K/r72+dUg7/Ocox39fn3OXvp0dwwHGOo9GRulT0hmB5vYJquZLVHtdXb2EqKg/Bq8q0rXuLeo9XRTbZDMbeKzlmch0PmPgndpbWOxjNdC2/YldQRoM3mbeUhrBKfUIUJP8N+kUSVc9ocs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=boyaSaSK; arc=fail smtp.client-ip=52.101.193.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BcirsHLEytaJvlyAujHklRtVXtypXz/TSIuc/N+8zZZ6xCQW+RVfHBeKpEEbkcQVxY92+dIvpFItBjNl5If/yDK0cERM6sU06eGo9/nK165xHbGztjCm8Ieiw5mR11KioO8x0u7rHpUeiXStjvcYYZPnCR9pS/ifCyn5Kc1t08SkzvqmBxgNt3j3Ie8DZLs8c7/RRWg7kNmFMw/UVvNaTqMflxKFm5+ZLx2Kc58QgttJ/TanopDDDFo/V42eHaq6xjxj/GJmybe7lk/0kDOGn6JpQciY8yQePqDh5eTmMbpBnVEiuMckeODVwt7i0CNMd51xgqzGVGEZAQ/rJzxPjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wbg12Bt7xTElU5opAl3u86JthcVKoP0ghJUJfey/ULw=;
 b=dw50I41LwL5ZLhFDP34KkyEsJrZ2NOFcSSj8JBt2eNZB8zSay+3LQlZuUMllfFyT/L0/WPywX8UxH7gPFg3IPtII6Q7CHbavolBjuTRi+aNw86EiDQCjn1nbins4FWtZbBETp3AF/+h+FJLDfH3KldswGoEodlO8PVdBFCGiZ+UsjA8mTQ+i8rsDpcQsKJQWHccdWq8izMzR5SnqBHCt92KLfEDC8cRADXCKqau5ApNxxdqS4xPCsyt1IySjK5xdbwoRYVsMYW+jkx4hSi63iLo9xHa1ymhkyRvvG7NN8jtoZ6khP4uPp4ZC/Mzkz0kYe/WNqy9HE+3bJiLR2ISgQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wbg12Bt7xTElU5opAl3u86JthcVKoP0ghJUJfey/ULw=;
 b=boyaSaSKmF3l+2vTqW00M2/qUIM/srmr1bWYHytOnU2ZMj/N+SGpdE+/L9qOX1Cbay3ENwUgakr0HEFwUZrM5NY4jrAi4Rx5KbnYz+Qr4W09TH+d38Ib3c4qpr/5k/V4l2wwrn90XDNzzHxKTENcvlpu1fvmAX5xdrak1xV8MwOhDJYyFm6V9kIANZlqFyXTjlWlofnn3PfQk2JPWnEnbtMGedHG/J15fhhdO5B1tKGiAQW2TafPi85IopSjfuE6hB2kLKCse57juW8S64sbLP35sWICWc5qbz694kogh/+xMhqJWU0II0v3ppLbPRb+YN/GPljnnlTVakw9QWTSow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DM6PR12MB4297.namprd12.prod.outlook.com (2603:10b6:5:211::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.14; Thu, 18 Sep 2025 19:13:02 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 19:13:01 +0000
From: Zi Yan <ziy@nvidia.com>
To: Lance Yang <lance.yang@linux.dev>
Cc: akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 ioworker0@gmail.com, kirill@shutemov.name, hughd@google.com,
 mpenttil@redhat.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH mm-new v2 2/2] mm/khugepaged: abort collapse scan on guard
 PTEs
Date: Thu, 18 Sep 2025 15:12:59 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <6BAE5498-D0AB-40F5-85F8-B92A05CA72AD@nvidia.com>
In-Reply-To: <20250918050431.36855-3-lance.yang@linux.dev>
References: <20250918050431.36855-1-lance.yang@linux.dev>
 <20250918050431.36855-3-lance.yang@linux.dev>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN0PR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:208:52c::6) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DM6PR12MB4297:EE_
X-MS-Office365-Filtering-Correlation-Id: fe887765-bf20-4523-c0b7-08ddf6e7630d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?15FO33qV0/fQ9UV2htia2wiJjVerV0EWHsrLzshWR7QRI1IL0Sv9vQRjOmVy?=
 =?us-ascii?Q?w8wHxQKxe6YNaWLjZQkb7H+gjwOIkV608N5BDvs4CFxjIFNHNOQ5ap/Jle2k?=
 =?us-ascii?Q?3VAMt8sF5lxjJlwTlxTshTc0mNHrOW0F7N8OGyMVjnn5jH/Lv3Q6hnrTdScp?=
 =?us-ascii?Q?RxYaVB9kZ8khxRxkvHjdHlo1TxiszoYOiWzU5VjRXL1Y7J3gl0O4FdN0IsUK?=
 =?us-ascii?Q?DmE1HpVU1ofrVUwkeerbZNXZmUu7XHnh9gQ69QX1w4mRSuLUOR9ocjVTTEQc?=
 =?us-ascii?Q?4QtmBwftCr9xf5A6GXi0WYS4IwfmrOzEqyVUq6x1Nr+RT9MGneab2u2VI9rv?=
 =?us-ascii?Q?o6YKurtNn/CjFfCC6dPXoYIOaqDCTU4ScHxJiSZT2upLs4tJ66tMGIPgUvgO?=
 =?us-ascii?Q?YOFhSJl2VvI0YKh7fJXWdHPDhkETmWgjJ5jRGTyPV6VVCJ1YgvKRKvr0U8bp?=
 =?us-ascii?Q?3WhBN7n5/+mZBvZNtnvB2JwLpEIbPp6eaeaGu49L1VjFJGaGsc/cD6k9PS8n?=
 =?us-ascii?Q?3giilrsa9JtlLPMigSsj81zlky9Nc1H1MdjyRJ452rhSFbjdAoogyRcqueSP?=
 =?us-ascii?Q?W684KX75EMXLQRvLf7BIyKTAoHqcUKQ9sCMhBwWPS3r5t8XpCCeGpZWAINtx?=
 =?us-ascii?Q?a1LzPUT8DXa24NjiogJH6I0ie6rQ2xfl0Du5EPVj6nHBzgpfQuZaueZmzJ9G?=
 =?us-ascii?Q?o0L6MRGtQQoa46mhjIyA+atPZLfRW/1K2DhJZhCvfkaw4RC5NZDK4y2XYp6s?=
 =?us-ascii?Q?BWByPAg4H13qx+7aIHqcWZzXCwer/J+uLncz8qQf6hHHso+s8/csN9BspuU0?=
 =?us-ascii?Q?sSsaal2BN/P269gK5Vprl62eHR8KQi9n8HsiTffiG9KJwnEq7QNSOrwHNYAx?=
 =?us-ascii?Q?SwB3WLjJsRRPx4/y2RRGdMiACXWwPqfddJ8qa8dve7A6+wZosEJZkYozMh+O?=
 =?us-ascii?Q?vrnA3LR9iCS1wqNBKGfYPYoxxIu2q3nBLRTayda0GOUHDiX7I0y3WNFESL3x?=
 =?us-ascii?Q?v1+uKGTsX1cp/hwDndY/VQBcXMSBqeHrvlR5id6Up4C3fvSqgs2BhysKgJe/?=
 =?us-ascii?Q?mo7huBcyp+CUByPUuhZIrMchO/UgWWWGvMzfgQ4aZMoG+499qG3A12v6cgD3?=
 =?us-ascii?Q?LqVgqj/9N1o3DhmaYbRV5Be9nBF2L1M+MnHxhM/sVVH0oBH8oxzBFRj0XX/C?=
 =?us-ascii?Q?APQStpZgRMqmRK2qHxvmAz4b6NK4bm3tI7g1fUTjEfd9OdUQ02YNNw/8in53?=
 =?us-ascii?Q?JMdHckg4ge5oCdzf/dPNa35RbiJYI5PlFHTlupE08buGg5dmESFMbEudercC?=
 =?us-ascii?Q?QZGTyFdBHw2sjzXCV2ICzBbmwTDF1jzZDwnvaExnJiMz10B/Po5DY7JzAahy?=
 =?us-ascii?Q?SFDV+agWOlcgSjQPVuiYHQsb4QAUUr+RcGE0ducjTNlLeZvalo/sHaLqz5Py?=
 =?us-ascii?Q?FDOT2m0zo2o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tqWnuO45qVlQZFSTzsy940J93WSNwP4CJZ4A02kP8/ie28+6euv3Nk29zPMg?=
 =?us-ascii?Q?3GUxAJ3NQZmkcIiZyEl/+leefvsrt61tcWv1/QwacPRkjf5xrUHfIil6zaas?=
 =?us-ascii?Q?sd4VQMzJNFZXj7AHbf6DvS0e2R4SbgSlXxEy7W8sB+EdSkfDpuwKa95xNog2?=
 =?us-ascii?Q?d4pfhlwDaa6yEyI3fs2lOcLDwKzsrK9TdpayAyKQXvUpTzs6kkOObjLm3Jed?=
 =?us-ascii?Q?CSQlB8KZVgIvCYlNpsBnDmdPio5GM1FwAGmIm1nfQvIl+Xd0d3CgY3N80hO6?=
 =?us-ascii?Q?XE8t3wp7Dn7Iwvy1oIkun+eq/DYPYOGceQpVejehGI16qXvNC0ZYP+gmbuvB?=
 =?us-ascii?Q?dSQLvhjWqfXBOkJCoDx0wUZYFBWXbnrXeMf0K24RV42JqO+7tZ1FnqneWyAJ?=
 =?us-ascii?Q?F54Qzc0SHvV9Cj+P3tjRePQKavFcuZ+KuE2BwYyaD9TY+zN7Hl31q0ydcpZp?=
 =?us-ascii?Q?tLJjG0DYvD7Z4wJJx12nJ3GpM+mvxE+CsnIZ0elPfjgIdJzYabrfxhklixBp?=
 =?us-ascii?Q?t1SLgjK8wtgleSqDk5h80uE2yhj3HdTbygqo+PZWO9YAscqNxmsATlKYfAr1?=
 =?us-ascii?Q?+rLV1DwEx1tL81CoqA7efYG+MppWlI86Thq+2e0X3AvrUoYsO83OLSuMG3pP?=
 =?us-ascii?Q?LIisESZATZMWe9ASefEs2ec+nrpaQmJTyNC+dme5q7InLN7wD3+zAE0jFAFw?=
 =?us-ascii?Q?WyxjzlwkiDUmesat5etQMzm7UVX2OYYX93UQYR1elXdFEv+YxvDmg30ec+2q?=
 =?us-ascii?Q?llXpQrvKYu1Hdr9mGr+iEoST3KNDA7KwUrXbn2DHtvljANRms+vMDwyc1W0T?=
 =?us-ascii?Q?eYcybJsqGJ3RHPiwGT4KuFRRzmAxUNQn7r+iFvXhpICmodFz7fv8kpOltAnX?=
 =?us-ascii?Q?mYHQVO724WwMrLp0VQCa3lUQ/DUzjHPAINrZfCVDTda81CExL8HYe19WXlMj?=
 =?us-ascii?Q?DRFhkxJ0LuUQS4JPb01iWmhyGe8QsfeAKJ2JNnrVFqJjszVgWRBQb93JQo2F?=
 =?us-ascii?Q?IDJeDzN2wzQx6c7/CmvwfDOMolcqXzapicH9tlBVIDjrAL7fjvQ2XjFg/6Ky?=
 =?us-ascii?Q?X7RI8p1u2vIeeRp77r4tQ0Ib95ezHAdePV+w5yxVotE4d32ZmFr0/yRXVcTT?=
 =?us-ascii?Q?Itdzfll+OuCEXwg2oC7Pn9xZMwhih3W+ySwWYF4TYAP0D9N+MvD3sDJiMvYI?=
 =?us-ascii?Q?SrsjHJylBmlzwS1WAoDQyoZymQHHRUBNVqI0tpySWYJVCNyyRCajUH1enXO9?=
 =?us-ascii?Q?k9rLWUOauQ/CNQpwP56hlfXECpZsK9q1/vJ3xR2QnCk3N97LY+R3MqNzY9GF?=
 =?us-ascii?Q?OVs0MOVPofBtHTeueiYkKbuHuX+OQdu9ySxATm0gsh23xB/QmGw4iqj9U+FC?=
 =?us-ascii?Q?Q1VsNC/AXJ5N2loxAsl0JUyiNz8zFtHWS4oRF7CPHBSVwrXoXlmwGTZfJrvV?=
 =?us-ascii?Q?PtRWvBko13X6HQBJye0HYIVSO1cYBUfTi7d8j0bmNNgtzcBQKiLVhNh7+/UZ?=
 =?us-ascii?Q?MBsbvfEyI9GvchAu1njm2frkGYbMxQhCjxVAmMbsdmvLXcyd9lWIX4uBHx7c?=
 =?us-ascii?Q?7lBVRJPg8HAEJSKzgUxJ63ToicVJT74KZRXsbRdS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe887765-bf20-4523-c0b7-08ddf6e7630d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 19:13:01.7491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ybBNPvP9/Wtsl2IAAIqBKeXyFtSUe8CcB0Pffn/FfBgWD8ue3eTzWlDxz4ZE3td
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4297

On 18 Sep 2025, at 1:04, Lance Yang wrote:

> From: Lance Yang <lance.yang@linux.dev>
>
> Guard PTE markers are installed via MADV_GUARD_INSTALL to create
> lightweight guard regions.
>
> Currently, any collapse path (khugepaged or MADV_COLLAPSE) will fail wh=
en
> encountering such a range.
>
> MADV_COLLAPSE fails deep inside the collapse logic when trying to swap-=
in
> the special marker in __collapse_huge_page_swapin().
>
> hpage_collapse_scan_pmd()
>  `- collapse_huge_page()
>      `- __collapse_huge_page_swapin() -> fails!
>
> khugepaged's behavior is slightly different due to its max_ptes_swap li=
mit
> (default 64). It won't fail as deep, but it will still needlessly scan =
up
> to 64 swap entries before bailing out.
>
> IMHO, we can and should detect this much earlier.
>
> This patch adds a check directly inside the PTE scan loop. If a guard
> marker is found, the scan is aborted immediately with SCAN_PTE_NON_PRES=
ENT,
> avoiding wasted work.
>
> Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Signed-off-by: Lance Yang <lance.yang@linux.dev>
> ---
>  mm/khugepaged.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 9ed1af2b5c38..70ebfc7c1f3e 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1306,6 +1306,16 @@ static int hpage_collapse_scan_pmd(struct mm_str=
uct *mm,
>  					result =3D SCAN_PTE_UFFD_WP;
>  					goto out_unmap;
>  				}
> +				/*
> +				 * Guard PTE markers are installed by
> +				 * MADV_GUARD_INSTALL. Any collapse path must
> +				 * not touch them, so abort the scan immediately
> +				 * if one is found.
> +				 */
> +				if (is_guard_pte_marker(pteval)) {

pteval is already is_swap_pte(), would is_guard_swp_entry() be a better
choice here? Save one is_swap_pte() call.

> +					result =3D SCAN_PTE_NON_PRESENT;
> +					goto out_unmap;
> +				}
>  				continue;
>  			} else {
>  				result =3D SCAN_EXCEED_SWAP_PTE;
> -- =

> 2.49.0


Best Regards,
Yan, Zi

