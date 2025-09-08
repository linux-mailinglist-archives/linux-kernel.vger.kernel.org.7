Return-Path: <linux-kernel+bounces-806117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75348B49218
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 616951BC18FE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFD330AD18;
	Mon,  8 Sep 2025 14:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rqVIrLQQ"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2069.outbound.protection.outlook.com [40.107.95.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B22FF4F1
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 14:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757343212; cv=fail; b=YlQE1YolwSAj4lSBu6BjPrncsYF9qkHlTGG5LFoTfAZC6uWQJOa6jdCJLpK1gCA2NzojWdMWDf+HW/C7sBgVnTUhHOG7jk0O0hCJC0l8E9SBEDTS4fKI4OlG7T8bB/YYClDXm6fureAhenuDG0Sm91ruOJYdNNgy8kd6bh8Qrc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757343212; c=relaxed/simple;
	bh=sREQcjXsPRKSeISKMC3uaCC/d9IPwKvvFl2J+aeRi68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RRobV8av3jIQwOY9fXsD+MNB5BG/ny88swvIFGmDVN0Go2Epk0wlH4LPkxQFxyl3v4CYIGcVlnxrETgBy2NEeMPiL+5fGi6yPj9z10OdQiGOu/pr0Fc8j8Fc4irE75bZd+itBH6vP6uOTpfr8nbx7DPJHU8lHeQzm9ABcbp9GYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rqVIrLQQ; arc=fail smtp.client-ip=40.107.95.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xfk/pU+ZdeLm7jX6XG1keBeqQ0L6Qc8uMogNPCGGFLHmOJWEQm59FDT2n5fs1FQoykglRzVSbZoZKuCRnEI2NP8AK/I9L7RJosNj3ug1UmhBFO8HtoMMuLaUP7XMJ02GYBJOo3YO32uSs+9PHY1/trs72kSiYu+nAZTgds4tDoHa4E/f2yr2bBpILkX+QlsCmf26pvI3WygeJI9y59IPjtcebvgxGVGxGrad3jjd+maljcw6Mou+vGLe7qDj3s4UPtNPL0pabR0RmriRHpnDVPuhtDWvqnw6n7js9TieZtqYpV1ywmG6b/7wgREIqtjAP/VdXTQoU7dGc6Sp6BCgyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wy2mN/tV1XvU+FTFB5WGDEmpLAlYIlwcQCIb+OKY4CM=;
 b=feZkJL9lK9nqke8b+XSuUSxrSrF14DAp6njq5Dinjf7g6fALy/TUvxTBkMF36RohqN+6sNP7nI49cFpjcKhvN76Aq3f1BW71NpDMt6x0RLdkACWOj3gdaDVGJjJcg9URMNp/7CBFVTNF7gHnxD9XxCbfoIZQgP3gu2FdNnvyxYHqkN8GPe2t6JCHn87iPAl9rN61GAmomy0TQm6pkZO13qT8l1mxX7UPWgAmWn/k+2HjZHfg3XoMiSHlsPVIxre3VAn35hwZm7XZgx3WfYkqEcImriVnF9Jh+ql90OtfOC6wq+itysM1gNUzXUfxpTZg87vmQUpcg4xlAlBqH5OhHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wy2mN/tV1XvU+FTFB5WGDEmpLAlYIlwcQCIb+OKY4CM=;
 b=rqVIrLQQcqjgcnlH5ES+l8riLr7VKjNraTZx+xJksTzC9PiaZOewGDG60rNh+5lfzcYoL5Jx4NnbyZLziymNpAKVkcMnwIf7KH4gllxIFY0GTOsDSqnLC7g/NZn575K/7Fx3+Ac5oA535BKCY5yTAy6WXcPjDo8q5QVcW7qQLCi/WMAzrLQr1IWrkiIDTIx/57WfIDw+6uuRmL9jBfghlrlDwLTZ3mn5VH0CNrIqOVkbVKD8+J+W7E1hqh5MgE6/TthWR/6T8JIjb9u5U7qaVXxkJz2nB6RCgHEAYV18iyEGA1cBIDHaWki/GMkrO9C29JCDyaVQ/mCMCgZoSOIzmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CY5PR12MB6274.namprd12.prod.outlook.com (2603:10b6:930:21::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Mon, 8 Sep 2025 14:53:23 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.9094.021; Mon, 8 Sep 2025
 14:53:23 +0000
From: Zi Yan <ziy@nvidia.com>
To: Lance Yang <lance.yang@linux.dev>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 David Hildenbrand <david@redhat.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>
Subject: Re: [PATCH 1/1] MAINTAINERS: add Lance Yang as a THP reviewer
Date: Mon, 08 Sep 2025 10:53:20 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <232D9745-5B6C-4CF9-A64D-550FD67EE906@nvidia.com>
In-Reply-To: <20250908104857.35397-1-lance.yang@linux.dev>
References: <20250908104857.35397-1-lance.yang@linux.dev>
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0031.namprd03.prod.outlook.com
 (2603:10b6:408:fb::6) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CY5PR12MB6274:EE_
X-MS-Office365-Filtering-Correlation-Id: 413dee45-b803-49b5-d6c2-08ddeee77553
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jhWn4FOcIlWqZI9X4q/VBbVjnNMLFE4BJP4lM73F0BwNW6YUxdVBoa75O18Q?=
 =?us-ascii?Q?MaSKCc831+uBjoDt+opzeioa1mmpUMEI9zNX5BXoYLwUIoltGE483kuScjS8?=
 =?us-ascii?Q?PJp2J+uLY7V2SSm2RUrO0EVggyuFbIYWhSe0oDJrKjSryP+25kQNx9K/ezXG?=
 =?us-ascii?Q?jR4/mgskV84MLwKlMBpPaBabkl+uPInqkhjCy0V4ONkjLPRmECH0d+Vdz5ff?=
 =?us-ascii?Q?/sgdZ6T+pwL1D9ZckvV2M60ZiFTq82lEdawKiLBAiVt7+O58VjZdV9130oZH?=
 =?us-ascii?Q?LaoMKs5JM9t4tDfSCks6bFqD8Cqh558HWGuIvtLmhr+XIlb2OiQBlXuoy5aB?=
 =?us-ascii?Q?y1vbXeTHG49GbBPqOgQX/pFnHUMHf4n3Gp9PS/la3eZnu1joJNGi64NKk+qp?=
 =?us-ascii?Q?VI90e/I31kTcKSAOR55jWU3d9lhLCIshcoQUFtswVrzYhtPnSb2487yLxVKP?=
 =?us-ascii?Q?e/LWFPCjRPR14JeeIHu6/wQrPyqI/v6O6XseTadZ7YlEBvTpjGtrxI11vv+j?=
 =?us-ascii?Q?2xFt+CXUl+BVvUv0aeAZPcemLHIStzWLcD4mzcECbqWQItMlO9amrXZy6FjU?=
 =?us-ascii?Q?WXJT9hNLp7ETUZIbuiAu9LY8viIOFA6Ugt8+5nSX/+G3rsdS2lyM9yZNo9mu?=
 =?us-ascii?Q?RuttihbUWkw4HKXcYYudNhavxZ4xrkrfz8zdgsU3LHZsIplu/GMyyC8ATJPD?=
 =?us-ascii?Q?6gTZVWgZr0AJS6ny2XRFKS64UqhKAVHjgSdiqlJEtWLVRWM41tu+yx3tQ1JJ?=
 =?us-ascii?Q?4Oa0hiLDxFd6tjyfJVVuoBJJxnVXmpzYRfeKuWHS4ncYE1Jp6Ya3aCecQcK0?=
 =?us-ascii?Q?oXQsUF3xab4SVUwF5KovqQJltac9h50coPN+0+Ijcna0zXhyaDDtdhjJFib6?=
 =?us-ascii?Q?BLr9K2BOA6vWVNiU/QS2JfBJBjdgSYeoJsCDriUCRO3TEdcshgrC4ilpEwTq?=
 =?us-ascii?Q?rWaELUnQ43ypZhYU8jGtud+cQsTeKDGXwoLC8IA+gFhmmGFH6agAy0IQKWxD?=
 =?us-ascii?Q?9nmo1DjQ/0BMFRLGseehzPcbss78FLMUzIanWoFn/Tt52peyJmSq8snYaGEE?=
 =?us-ascii?Q?9ORZ/C9ueUx/CxJOb8ZHgQwxdxUTXPogiJePjMmR5BGOyTtAidMXQHw3mR8C?=
 =?us-ascii?Q?7hZrg17xhqOWHhvBnjcuWopanPizDHAxwtBK/X6olSp8pIOuWc4bSHwU+CzV?=
 =?us-ascii?Q?G57KRCd2j+6wzVgS77xj9HTQsBpFJkrmG16RqqtI2A9/oHqAk3LwBPvlEyRr?=
 =?us-ascii?Q?NeUh5wM133MP/UzvUoDXORmZfJXzQYkUyskv7KdHtSFbKeDsBgFC9G5L4yuX?=
 =?us-ascii?Q?wC7SBPdb4RsuzNaQV83QSnasw7A7cSetXpfnDTWDxKNY86fNxhWeNobonkQ3?=
 =?us-ascii?Q?bF7ABsaPTzAf/nWXIrPnKwhbvWwvSRqMtgF1RiAFiYnLIVY/3Xarotqe1jP5?=
 =?us-ascii?Q?YM+8MJAiUsI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?on/Sf4hS2Hq83ym9HC9OsdsIv1lnvQ/uvKjjLjfLqIl/69tPcaf+E6AtYmmI?=
 =?us-ascii?Q?nNrRNWDC99Mk4d4tR1x/FAGzXCGhj45OhzF/yUoiUrTZYSGTwqEr0Tr72N2a?=
 =?us-ascii?Q?StT30tZaagXKTBEy0VW16SY11GvZxpC/RC6sZuo7U76MbpKEB2NuPgk5Z2F+?=
 =?us-ascii?Q?ZxtVmG4K5muPG0eiZrG38MNbX7Fqnw6iE4oSMsjxdx23atNS4H/uHoXdGki5?=
 =?us-ascii?Q?RQIAux1caij8hm5jtWLzbl5Ldnc4t5b3aRWo962CF0II7MhnQGqZ2i/3X67N?=
 =?us-ascii?Q?nJ2YnnyigXlN1Yz8vSrrWkRgz0p8g580Ky8hSWXkCSDp3KTiN+YI/Jnm5Re3?=
 =?us-ascii?Q?HJNIGgMeVOEqgNwL9oy3wSIzRUQOg+oAALt3wuY194j3jVoTuplY43mplbqT?=
 =?us-ascii?Q?0vN3lhcrWlEky+ZkxvAMMWJtH9WdJLXN54c6YJ6q+hxSVdL2RJ9VIeuMYtSK?=
 =?us-ascii?Q?21eYsXdxYlds8DTBqrzpsewbZSMaQuA/zigx1P9wR1oDY3huxX1SN0Oyn4Uh?=
 =?us-ascii?Q?cHBuOqHDBbNQEKXyP3XWMFdVDLKKY/G2ir02GW3atLfRLGSc2IqzehD8vzdn?=
 =?us-ascii?Q?4NkY5hXpW5xycMqbTISWqiRGfMgT/D90EuYOsBv1JGbioWZuWUV1Xx1W9toT?=
 =?us-ascii?Q?5RilsM40z8qpFPvGze9LGoMJvLEVUpYLtJEKuYoZEKpIcn1qM0mn/9l+FHh6?=
 =?us-ascii?Q?0cznMtkiAakcpCK3vfDtOXKeigr96YA0AZHBsf7n5hE+U6EbSO88NBV3teUQ?=
 =?us-ascii?Q?IpPExwKwQoJYvrxO4dt1qkfPeIfBvh9m6Wdqwdwqxqxl7tuKGetiuit5rOdy?=
 =?us-ascii?Q?VAP35pndbuE73+aTBC4++zVaJwDgmmLa6kG5O8ZSZPVJtFVZCJ0JcCOQFYwK?=
 =?us-ascii?Q?5I5HAiiYAqjNN9d9JLARg2MUYzHXXVJTNyAqcqZXjK3t6AgfkQoJgomLiNs4?=
 =?us-ascii?Q?HHFNDf2k1IKspX7b6p3UscwWUOmWRCBAy1y+4zf8EHl+whRovHhxNSMUmIOH?=
 =?us-ascii?Q?H2qfnnuzicmt+d6dqhSD4loeZn/0sz529e6WngwEBOjjcKIgMfOxJic2w4Ij?=
 =?us-ascii?Q?HfvVqpMRTD7N0q98czlmkTBfCxaSdDxxSlZYy107THHMtpdw1jJbGoQg5bKU?=
 =?us-ascii?Q?41lealVNeCn4ZgEjIMnH3nrYdu9AmJ3WzFlqYWdT2qgF9wKuc6EPFPt0s3a2?=
 =?us-ascii?Q?z9HMUIU783tbVlNJOPTXaMd9h1Wa8mjUMm4oVr4Fq3j6AdCzRUWpQ0UcvhfJ?=
 =?us-ascii?Q?l/mN96Euza6Y+etc90PsLQuU0XvVgoO0LMyJyOeoxC8MvhCKzA0jt/Fepo2w?=
 =?us-ascii?Q?4ejSsL6Ft333Ono431+e3PdX/a5IsUZvOXuutSAUmguIIyZohs+HnhMcEmiR?=
 =?us-ascii?Q?TaUfO733YdFIYT6Gp7fIe2Nek4OTkU4SGC4JbX0p1MnDVRiSA6qYgtc27Qwe?=
 =?us-ascii?Q?d9hMl8VZfWyxUf5rNsFhjDkAoYPPGLdIZln3VpmGrTKcUhCsAW3aW5sp9ySi?=
 =?us-ascii?Q?bSlx7xA8XMqgPPOOqa1ADUcZUfFYJevv1OLw2ZYRRT8iCGSgip06Awre+DMG?=
 =?us-ascii?Q?ZFmzooSwgldogsNYklT7L8AI6a6dEdgnYLBOVE5v?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 413dee45-b803-49b5-d6c2-08ddeee77553
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 14:53:23.1137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZpNGq2G5WnKKUpk3JN/qHmH9nj8R3FqAVZCfwLjYQn4hHu+iWPtv9d4FvZ9Pxvt1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6274

On 8 Sep 2025, at 6:48, Lance Yang wrote:

> From: Lance Yang <lance.yang@linux.dev>
>
> I've been actively digging into the MM/THP subsystem for over a year now,
> and there's a real interest in contributing more and getting further
> involved.
>
> Well, missing out on any more cool THP things is really a pain ;)
>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
> Cc: Nico Pache <npache@redhat.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Dev Jain <dev.jain@arm.com>
> Cc: Barry Song <baohua@kernel.org>
> Signed-off-by: Lance Yang <lance.yang@linux.dev>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6dcfbd11efef..34c5cc3b05cd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16238,6 +16238,7 @@ R:	Nico Pache <npache@redhat.com>
>  R:	Ryan Roberts <ryan.roberts@arm.com>
>  R:	Dev Jain <dev.jain@arm.com>
>  R:	Barry Song <baohua@kernel.org>
> +R:	Lance Yang <lance.yang@linux.dev>

Acked-by: Zi Yan <ziy@nvidia.com>

>  L:	linux-mm@kvack.org
>  S:	Maintained
>  W:	http://www.linux-mm.org
> -- 
> 2.49.0


Best Regards,
Yan, Zi

