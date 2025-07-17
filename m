Return-Path: <linux-kernel+bounces-735548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86524B090D6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 17:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56AF97BB37C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11FB1F30AD;
	Thu, 17 Jul 2025 15:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lkgLx99A"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80813188713
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 15:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752767120; cv=fail; b=ZPQ0P5vvXLUl9w/OQR8hy1hKxKiG9T0LXsqI2W8hS7lwxsGtAqJVZk1GPY5ggimjasHeU2r/4JkthdwFtFf1ISxeltavbDa1knUxKVz1jVUn386oo9KoVjTVzDQUbNL/sGsNo4Z+5Y52tiXW0AY3gPaGXoVgs+JEh2njakrY698=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752767120; c=relaxed/simple;
	bh=siquv2KGqAJ2kRdvLRV+xOeICpL/AbvC1zCr35MZgE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pazutKVAXcbPPyxc3uA4g7BxUmZkffFwLl6At+rlYk1VROQpZU7QoA+UMNS18iBr6T96e7u8+VnkPSVQcY0xxzZ7N4lNfU/yeucUsdTUUFaFvsT10s0wrSnLK75cgwIlQne0WUiYopbVQQUGKaDbAgHNzoQicUlK9ogsruAIZoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lkgLx99A; arc=fail smtp.client-ip=40.107.94.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PcGUKgJ5MPAWK32aRlL3IPQxRx/zyVkT80uOidlbhWe2/7oEfchCJclxf4GcrjTrIpbAdlIi8RCeeBy0C8REtRid/HBR+PkUItrOxQrW4tpGznAHU0vEpZ9Nol6sxLxvAupPvtI82DXq+WQIRjpRD7wecTpvSW9wPcL/OkD2idLUqg38tqwD2niH6Tm9Rv2L24d4EReXuLHvFZvD1FK8P8gBpFiWDz/w8FVj1KyffU8U3f349O/jDEegQedK9z5UD7E63QVIv1cSRvhcwDpna0TvbqKBKdbWwp/kwCsau7H0tdHFznODtJeKIKqZCh30qNWqOYAYY1nI16r3SzRyZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=siquv2KGqAJ2kRdvLRV+xOeICpL/AbvC1zCr35MZgE0=;
 b=B7xuY7/TH8Epey9twXUJJLe8JDdLuGEBg4KqaMDzs3vPUyo6xKCnrl8EE2IXv4B1xQZNdedAPc3I25QhGyj1w6fi68hVeavS9sKzPc1Op7XsAysLQnyqGBYLCDyeCkLmWBTzW4loNaeZM0CYWvcyid9Kw41O7Aiu2loKsdQ3KQ7UWEHR6LFZRPkL2AxIbUmeHVIZ6aqyBVmX6rgWNfEeAJuc6DUL8c/svGd3matnT0hPSubBEeb3uzThj81Y+RYdX1x3qigVDh9TnUMNNOQVVvcXuSpIxEYn0zWhcq0fn4hgGX7yeBz8oVM7ZC7FEciYk/W0SZpeu8SIfhe38st15w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=siquv2KGqAJ2kRdvLRV+xOeICpL/AbvC1zCr35MZgE0=;
 b=lkgLx99AE6O64OOsUaPgzEtdzJWUAno8w4mh2hUp1g8GgnfP4g8h+3fmU4KHRDLqjAhvzez9uFLhotVlXcZAWTLZv58GXyB/6XzWsH7fZB8wk6f9Bn0k/VYog7dIj3ON/W42N9bQ3dZxAN/ILSY56Ibr2JwC92doBpW1rnTOJdhqFk4Y4W3dnprZqbEm1dKcK8Qb3zM3L2xEjWnA+QyeI3OTabodETovrkQAUVUk5hu4cv6YvQsiALNaOxrK7fnlJCw+pRlIyDiUcTZ2drIcf/MAnCPeyy7938Z/XZ6jl9MjLS/J/Xzc6W1c5QvUq1C+b54JqdLn8CZUiJZwLdX98g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 MN2PR12MB4376.namprd12.prod.outlook.com (2603:10b6:208:26c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Thu, 17 Jul
 2025 15:45:16 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 15:45:16 +0000
From: Zi Yan <ziy@nvidia.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Antonio Quartulli <antonio@mandelbit.com>, <linux-mm@kvack.org>,
 Hugh Dickins <hughd@google.com>, Kirill Shutemov <k.shutemov@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/huge_memory: refactor after-split (page) cache code.
Date: Thu, 17 Jul 2025 11:45:13 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <5464ABD7-C4C9-4BEF-9E5E-21F5A18C42D9@nvidia.com>
In-Reply-To: <31D32C5B-6719-4E3D-880A-666044C4A48B@nvidia.com>
References: <20250716171112.3666150-1-ziy@nvidia.com>
 <a479057f-5401-44ea-b3a8-dfd82b826721@lucifer.local>
 <31D32C5B-6719-4E3D-880A-666044C4A48B@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0225.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::20) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|MN2PR12MB4376:EE_
X-MS-Office365-Filtering-Correlation-Id: 49c1d018-d246-402e-c813-08ddc548ed04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DjMPLS1FhNJDuJ3SLhl2taXa6yEp+uIYGmRUH9DEps6HbUDMa5rrwCDPxlX9?=
 =?us-ascii?Q?IPT+59C9LP0cMe7IhHS2OBJrv8GzqksQ4y4xOADAmMHlSwj+/JbOD6bc0CE2?=
 =?us-ascii?Q?UnfkGgVCGmZZN9HRPFytXcNuBDXRTx1UwsCUcXRzt+Gq+ii3xyix31M0U2pq?=
 =?us-ascii?Q?fwN+LjLsh8xWkFfDjj8sBF5EBWpKpB0c8L+DbUTTx6UAJxq7NE3zMINfIUK4?=
 =?us-ascii?Q?1yGmSaVqUttt8ie4GnE41bZBFSZldHhR3RszazRe3eY8XTYV4m79xwQKqdJg?=
 =?us-ascii?Q?hlHCvS+l3hodueGgaWhIx5aOpxm6syxqsGwNfmMr7nrWtqzH0T+VduiZGnfR?=
 =?us-ascii?Q?jo+gc25pxJvxnX0YZgFlHaYEpjFqSWCrprmeMSkYjSwXE7g31+/q7I/tUqWe?=
 =?us-ascii?Q?X9VHdguCJsMkslhnyLnBmJi4oolb4g7MQgzL5nHd7f9LmsYr3qu99gj6I6XJ?=
 =?us-ascii?Q?2BPbz/nFnHiS460ATVZrgcdZeeykZ6UruO0qZyVAXudeUnw+DeM8e2yAb5FW?=
 =?us-ascii?Q?Q8Wp0hjwZgUpiT869dGB3sZW0ZLqWn0dXsPJjz0VNLpZlZ6DkR5oF1jaGRF+?=
 =?us-ascii?Q?oMcFZDeF41a7K5Sl0dntjN2WwaH5psFLbarowY7EMACs5Fw1RDchKnd7gq6j?=
 =?us-ascii?Q?tCasgCD3rtVusnF8uLPRKdVd1+FRlaMTpYx9505vxHz4ew0XaxsSKyGQppE5?=
 =?us-ascii?Q?c0+caRZKgEWwcMZqXY95xkKypwRqacxgxZl5bb7fO4KUl5D5sFKt/ml4nsrD?=
 =?us-ascii?Q?y9LwkAYBOzAA5sn5y4TQydK4koOgovPaDTJC427Pu58ZyZPXR53/vo79WNfm?=
 =?us-ascii?Q?WYHSa8Tgv92HmPG/oHSXxK3e7WjZJpbRZlvan47Bzyi1yZoALNiS8GACykts?=
 =?us-ascii?Q?fm3RXwGnKnw5+1CulVcBC5mkl6yE1Z87CxLHmN8fGLE/KN1h+SRGf3EAJkDc?=
 =?us-ascii?Q?c9pYGtWyWP0r95MvV7RsfpsQ7PnBCEaM0jpT/D7HaVBqiMK/VSaR/38Vd0qp?=
 =?us-ascii?Q?ixQ8w0XFxsZ6F/hciG2wnXQn4GBpBs1yRtRzQpBs/b319QjQ2TlwW3DOM7jo?=
 =?us-ascii?Q?Zij1Asu03Eye8GiU0arzw05c69d439iBkv3AD46XhgZcWcjTXdR/MLqjfJAS?=
 =?us-ascii?Q?5IJ3mpSV0cwvbkrWVdIadPtaDZJG+acLQdSS6BluPhpoiW3GpKS94RlebJ4n?=
 =?us-ascii?Q?I5RgqzcLNgfSHsiiuoRL7a5DRK55DHsyA4gHhgoIqmwIIbGHsUV4sfFJjawT?=
 =?us-ascii?Q?kEa70f/UPW9yMdw6IR+TtOJnMhCtjO0lxBW+1EJxp9zHi3dMYPS5qawphCf7?=
 =?us-ascii?Q?9mZ4G6J9DsVFWTJ5F0/AKm9XJUibElFXyUKe8AHgcH6UWwFsmIsVMXU64Sos?=
 =?us-ascii?Q?qUOBJzHlBOvIVZsJup2OKzYEuNmk6Vd7t4MzH7U1y3gSH6EIYQgcDA5fc4u+?=
 =?us-ascii?Q?n7qvBfhcVW4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C5LmoF+TwYgwCw/YOQ3EPz/yAAMIHfrI4KHDQviBCCdb2FYman1vUDWmRKST?=
 =?us-ascii?Q?rQmHETeA9VGET168u3M910c4wcv3+FRyRIVI2lqAqZwLXcTt06cUOQfSioAQ?=
 =?us-ascii?Q?xH7zk0pgN131/BPGT5H1+SjHtSIfR7ec9llkBQ+mIjbXRJR82zu49Qu1ngpL?=
 =?us-ascii?Q?v5quTd4X/6pKFUJl04Cbg571pi2N+tfe7Oq+zf8J7AmDbba6hhHrXavskjP+?=
 =?us-ascii?Q?pXWXDepr6S4CDz1RV1nIguaFK4D6v+dk3m9rskqxL4Oqapptxmj+3PKkYB33?=
 =?us-ascii?Q?jNPZJjBHgYqu878Ecf8qJrBwrQNB2C0nv+UHCnivPjanQi9fA/9aMabxNnEV?=
 =?us-ascii?Q?tOavVMwDrbUBSXKi3ZbtyJLMkwtCjvtzYqC/p3mxQF0EDgvHaU7MAN1LoIk/?=
 =?us-ascii?Q?pX39kRiUPKKttAVMKIED9h/rSzvJa9ruDphiPTPE2EEsJcsGkD7jEMPOnHUm?=
 =?us-ascii?Q?ClSO0NDHUhaExY1m8emXEhhHxlCNqpBW5oWKg/LpXXoeUh/e9TM3ibdOcBu4?=
 =?us-ascii?Q?Vcw75m6wCNvLQbxfj4EFghNtRxE/stssXIztaISXPcQu/9MxjlMzHVLmwMlX?=
 =?us-ascii?Q?12N0S38kLePGUPyoTOMXo9+YCm8YRNk2Uv02Y6a5mrWPIETkMYB+frwI49CQ?=
 =?us-ascii?Q?ivewvqrkNKTOeuCnhGZNlqQ+x9J7Ck7IJKa0MH3mKMITbGItoS59jYJOEtSz?=
 =?us-ascii?Q?ZuOlAH0ABi2x3EpR8ohC7WpKWc8Ho97EqGng051wNhH0b3B18OcpjGKpLNKF?=
 =?us-ascii?Q?CmNgbRbR9BvCRuLfcyOWdyqJzkFh7eW1SYL7IkeuHRqCe0kjqnJcvFgVIr/n?=
 =?us-ascii?Q?qfTl3yDWSC9oXFqqP4p0+UeNBG2G3EIbH8jNQmBc/KWgWN0qkobC9hcatKjC?=
 =?us-ascii?Q?G72MtvFUxvlqijDleeYyZQKU+NKI6t6j5h1rtPKsjcfeLRSLvOSi964SR18V?=
 =?us-ascii?Q?TPHbMi6QbVwbCWbQCq223Ud9FlgzzEmrPWFin8RjswgzTlD0oPlGA7iwe23H?=
 =?us-ascii?Q?yscUWfDnDy60zpkSAd6E97JhWdTQFDu2mhngRNkzWC7VVt8vQHxkWg9N9qEB?=
 =?us-ascii?Q?DFlBLWwuUab5qq/PBX2GHvGKUXldfclHbvTGb2NlhQ49iVP6IhtBp3E6pJ0r?=
 =?us-ascii?Q?yqu6RBs5cPdFFMJYW1KNdr0yd/FRtVz4J5nn8+M8phHzLsewj/uo93l/7aQW?=
 =?us-ascii?Q?AXogapdnAV/0CFnjkb8MOG57lvRDFvXSamNazzrPhjDKj9k4+HslNT7AxZoL?=
 =?us-ascii?Q?wUMY6CrJwMEIxaZNwBFIUnOdPk66cA2nhY+bBvaKq5KwXmgnuOeC473Y0KqM?=
 =?us-ascii?Q?dQwUX+sHL3Xd0h8Lt3+PZOtDxE4w7KnaGiP1hCHzvh/vguFnvNPSXzVSiEbg?=
 =?us-ascii?Q?fRbfcNwyiyoL0iWJZaDDP5/hDGbYOj3PElr042gOYgCIogM5tQhJDiQ7CVAt?=
 =?us-ascii?Q?f4DY2eBtSkPwcIpm+msbPF/tHkJhNCp+SvTnnIzu9lj+VSuEFW/pDex9nKbR?=
 =?us-ascii?Q?7fSXy1WuBKixZvhWrk3d1ob45a+7E3371soqiE4WAIdWl4Meomupkqbnmc2Z?=
 =?us-ascii?Q?EV1jbd8CgvBOpA3F1F5U94IAZuHyFbUYUo2972ng?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49c1d018-d246-402e-c813-08ddc548ed04
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 15:45:16.6089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GEA3tzfxrjQFudtsIwooiYXTnLZbn60sm3dYoPjy4okwr4+YJJ580QZkjOvLD45O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4376


>>
>> Since we no longer need to make new_folio->index >= end work for anon
>> folios, can we drop the end = -1 in the if (is_anon) { ... } branch?
>
> Sure.

A second thought on this one. If I remove end = -1, can static analysis
tools understand that end is not used when a folio is anonymous?
Probably, I can initialize end to -1 and remove end = -1 in is_anon
branch.

Best Regards,
Yan, Zi

