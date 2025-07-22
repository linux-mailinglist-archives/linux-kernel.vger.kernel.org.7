Return-Path: <linux-kernel+bounces-740046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8493B0CF01
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 03:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 170DE1705B5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 01:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21B818FC91;
	Tue, 22 Jul 2025 01:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PO9wQe+t"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D4B13A265;
	Tue, 22 Jul 2025 01:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753146811; cv=fail; b=myqWhiQOOmS8riAcO6mc1Igj+kFeFbhSyihl69UShr8+3g5y9yOTgKgATL749un9ptiO824MkYr3hyPzYoY9K2m4/iT2dU1JngPMpfVWO+p6ZMsBS+8nc72pcc/LaG7ZvCFO7388UZfHndchylEdA/q8/2PeG7AFzbiepe4kMes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753146811; c=relaxed/simple;
	bh=AXj4OXT33gmoO+kFWGySShp1mcF2E73p2ucuYNXNTnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=smxsbmvlj9qjxR8ubECCNaIwgrdzdqORNZnP/5FNjFHnkG3stp4yLVrXVyWwXf9dlh3FDRbqP2KKjRdC7IH8GGbPsuYN0C6A/rjIe6WJ8fKgeTkhKS08XF0DU5xv2gM07MhLBfdslfzWWdpLQqOYsNak38ihMb0F254MtNdM48g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PO9wQe+t; arc=fail smtp.client-ip=40.107.236.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g5wv8tgcnVXS9dJBl2nnYGmng0vIlUkCfPAUeHaeFMXUfJofdwp/QAdI+Z0cb5m38mJ2efzoPKyErsmuyCCnO+EVUHU2Ylq77lwGj5KoIdxhFKlxOlRelFZL/1tBpVXoOXdWHBHd9MFwEFgCyD6W2LtHqXW6nNoEpCeSY9yUgbC8UFZOs1PP0aTXtClWnVhHv/u0sHQWcCTaag0aM7sp4YgGdSGEUbn0qR0LejnuUS+VIIB3yUdUlaZs8uAx5TUAZrDpfM9qp30svmki4+q5KYjE7yoxc55AMuDV9v1OMRBS0hfIe5/50tQyvwkCfnsb9jnT8VqQ20nXGi0POKejBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UUHta6sNvihvfE+aRaKQcYxqylCHmaq3A5N8b8g8Vlk=;
 b=bDiZAGwjZVl4dghNM1ZubTGBPge6qYiNHXgxgC1OVCcoImL4kjeH2XCw5r16ijWsqNECEZbBxUZodhHHDE9B8EIosRaau4ewoCuuLy+VW/QMpF1wnw3x/E6wImRvR8PUuNBqyJRGoNJq5mZvDPr0X8jogdzJgQIonC7lGQdWp6Isc0N5PDCzkrSWRquMzh1XJbokAuR70UU+L9jWsz4eY0KvoLPjwBIAdkGkmc1/3urSqqknWoginUJBScr4Sjz+kFQcwyYGtQcGvLNRuauqSEpkIp4Dpg5SlLOXic+Hb11UwV5o3JLF5UGFK9zFxXIDLRrSleq1ryJD30tCLMikqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UUHta6sNvihvfE+aRaKQcYxqylCHmaq3A5N8b8g8Vlk=;
 b=PO9wQe+tKtnHjF2WLA4ecfg4BsOYs3a554RCT1z4Ad5xqjouO+d3OBkoOUiQKWRU9hYdtuFkYuf6QiSnPqMt5EgIzT+wa2Tk/dTihfUzo1XItc+SWEc9S1WySGWwhIC2jkXlHmIkV5oZcRKcOyNo2C9fsREcPMmB6JVSAwcummfEANodyx2XWv/gqWTGkmZGS1iBO4y2NV3SBXDvM8Fq/mbMIpqu5P15b8XiSS/hBFRkXguqwXot8aSQ4n77O/j3QTuLHbirZ/PHRS6K3ozcY884mwZFHpJ2BkzdDp6HvsViSEn5ijquaH2GSIND1BMrRoDIBPMHQh+7IO3C2OFvLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SA1PR12MB6917.namprd12.prod.outlook.com (2603:10b6:806:24c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 01:13:26 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8922.037; Tue, 22 Jul 2025
 01:13:26 +0000
From: Zi Yan <ziy@nvidia.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: update THP documentation to clarify sysfs "never"
 setting
Date: Mon, 21 Jul 2025 21:13:21 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <E48F7A00-D103-4C5D-901D-44085E92AB7A@nvidia.com>
In-Reply-To: <20250721155530.75944-1-lorenzo.stoakes@oracle.com>
References: <20250721155530.75944-1-lorenzo.stoakes@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0688.namprd03.prod.outlook.com
 (2603:10b6:408:10e::33) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SA1PR12MB6917:EE_
X-MS-Office365-Filtering-Correlation-Id: b19d1ea5-2db7-4f00-4324-08ddc8bcf5b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WbohhIXPX7eBma+cosaj9kGZREowCwfJTg28ADhMJNN6/19kIp9+TdOPR8IO?=
 =?us-ascii?Q?7rQ+xDbzVNEKPad4wCfrz2uIZs/4OWkrWFx7je7Zbm3NFwFGPJMLAwKer0ax?=
 =?us-ascii?Q?3cje4zitJjgayXqG2MFYqsw8iBWkh6EQc3ZSfWdKdSzuoNR/zy1K2JSvaZXv?=
 =?us-ascii?Q?cQzD8DCuLNdBsvDNmB5gfXAUH4BOLk9AYcb8og3bulmPsVpsKrEqoQ48ROS7?=
 =?us-ascii?Q?0b06xdBoG85qiud//Vn8zOk6vBXCqwfEpFIMROU2+T3hi6Lpn3vIrBh+l4bT?=
 =?us-ascii?Q?0P0cwAC0g8xlS/TKGcc7lLCoquoWjRzekF1jDHvD9AlqXAgwSUL93trm+IhI?=
 =?us-ascii?Q?TW8s92YD6QMDGDK2CAFfUfpx8sAj5XO0SXTHCnLApC5Q+x1S2uZ4gLRYHB1M?=
 =?us-ascii?Q?9YwYBjEqKpRG3r6mxGkj5d9Wrtna+rSBhj6fhNMBQYmLxVxvIbRVxVSZXKNu?=
 =?us-ascii?Q?bSq8my5YAwuaRoG/Mv6f8B+BJrn60vVpTpMLPTGlSkP+fTw+mDyUjN+d5uNT?=
 =?us-ascii?Q?Ty/ooqd1fNIXiJ2RjeRV42iKBsCgYe/YnkYmpNdii1Nwx1M9xQ26UIZaXu3l?=
 =?us-ascii?Q?RFQBBJHAPhrGCtVn0YBccdXNPt9kpNcL6UvTl+8HM0nhUU9nu5kyudDpScss?=
 =?us-ascii?Q?q9rtb5OBd3m6tRMXBzwxL3CCeybV4cELQqTil6fgprDThJ1E3oK2DFWZjjOx?=
 =?us-ascii?Q?7ypGJimkWLOT4Ph3qe6fD7YV5Xe1boa21M4DtbkAOIp5hQDdBB8aSh8vnwei?=
 =?us-ascii?Q?lFw3h3aWGM4divAwJsqmn0YQpzaGEV/qdDJ7r2SPzXLR3nLm+NS5LPNhxYAA?=
 =?us-ascii?Q?Ytv+9uwhH2ABvROU+3TNxNNALhu48k5hm/d/wt3kSUd6yip+HEFzH3uwmA1S?=
 =?us-ascii?Q?6v3a8VjabLX2UO7hSGbohs/zVWRb1iFKj93ovepwUMZUrp4tqvQnWE2O9mXt?=
 =?us-ascii?Q?96eCromT/2zn5XTyxoSZD30+fEUDOuZxzgHqaJmejfwye9Wuuujm6MDHXfnC?=
 =?us-ascii?Q?UVJy6pIFt0vAfJ9tlbOwmGttR9ihEfkbv2dSRnzbW0zKjEzB/wF2DEJ6CorK?=
 =?us-ascii?Q?8His1zP4HqF5XLjLV3MM3sSfmoL9b9kIyMERluI5z5VwB6XrcNv0Nw6tvVHu?=
 =?us-ascii?Q?++L8ilrwREcBPLBaAukWsPkA+ayhIKnVyUGlepss1xzOYq7r7f2Z3SIZxkGf?=
 =?us-ascii?Q?ZHz56SIgN2uR3wHryqBny4JsbjUJ2DWGoknMsfI+oRzkly0tvcUyv6TTGcLd?=
 =?us-ascii?Q?0CNsyBVYSxVawhTnKb5D9nAvYwltGmzowy2b21nqP8LX6sBc9sLa+gCpVBDY?=
 =?us-ascii?Q?UTt1/tXQb8H8O8mNIGAhAUOfAaFXDvy6dtmw+fR9HQ6R+jDfR2wGxkiNH73h?=
 =?us-ascii?Q?OncHQsGjgacrYTCWCUjokipyFWtDL/rtnFVNpROx7nHlre1RqOjv3K8qLTFr?=
 =?us-ascii?Q?zX5xIroHhpM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DmgZuHRS7wnqLHn0LKQX4O88NSC86BIt9Cx3Ofsrm7McfT6DWzo005WVhxyF?=
 =?us-ascii?Q?L7K6qXAHe4I1qp4/w18B+BC4g98EhA7WnsAj29VjN8kVNDTK4fufzoAqIRkx?=
 =?us-ascii?Q?vHxUm5c6sQiDqDUED99x5e313oNC96b2TRA9ps8udtabgvMqcbilHA2SJAk9?=
 =?us-ascii?Q?rVrV0ds+RYQUGCgwZroue54s1c7CxL2/tg/+KYtYxXtcgmP8INh7IqSGtnjE?=
 =?us-ascii?Q?Ku7YSp/87XopCfAS54mmu1GNmmR7AbvhWDiOjW9Bgiq3ilTJyGIbHVnSCJk2?=
 =?us-ascii?Q?OAc1FJglATevv97IoEaS/EvvKLBY3jr/nHo6fiG7PdGzGPVtI9/EXNYRgolb?=
 =?us-ascii?Q?8FhDfmKYJ8ezrHfagJP7SD3/9LAfCgs64UdawBDEKP3Z05osfJcRpMIzAkd8?=
 =?us-ascii?Q?ajIxL+GsICFyqjz1FG65H7999Pchkbg+W9ym0dM1NpgTrGYsDkZ/4fAwZ+OF?=
 =?us-ascii?Q?5U2mWAB2U3vu0LzFg5ke7j4ZOKfOhbXqfPWw8+pENXdPSQZswJKjATqI5tYl?=
 =?us-ascii?Q?vvO/8m2NZCMnfgBLOB63BkSEofLz21e8idmB6lPIZU6xo5lcvrYToxi9x9Xo?=
 =?us-ascii?Q?K0xxv2OYt2wuGXB2ekOmEAqAwLJfvpW1HufB2tPFEf/H+uwwjt23OlerS3pz?=
 =?us-ascii?Q?b7CS0CVmntbpu+ebEOqI9Vt+KYDZOfT6HlNZcfwDevOwYNOIYzfQyn0JDnoQ?=
 =?us-ascii?Q?kH8WQh2uBzeUkz4mIuFcNid1r/uEbGVaLgVOHgAZL1pKJX0fQopC1GQBW6s9?=
 =?us-ascii?Q?CADNS5Pp+LhLNHwfVrX10D77jtf+DXZXpNVYmZGxglQaVIo1mawvT8grOx9i?=
 =?us-ascii?Q?361XN5zyGzeBY+nb3IwJ8jsFu08HS33gJrmbX1ese95LnzGA2mSJW+EVPrv7?=
 =?us-ascii?Q?qh2B8HcH1qAfPcFGSVFymFumQISFcPFcbALy9aLrZ+mH4pC6qtO4MJKDYMEV?=
 =?us-ascii?Q?2BOde4SNpLg6BG8Ge8MiMhDc+1H4FoB2YwcEy7f+WaApQdJFaao8Cu344pK9?=
 =?us-ascii?Q?e+5Td5+e4pTyJnzXf163oRMcALoY6Zt+wuK+SuVkgfNSgm4CX/iVa+xkegKQ?=
 =?us-ascii?Q?Qo1HqhGAvCAKOBHOXxSTvMBU7Uwjw/GrozMZxX9HVcR8u8CcrOUjjl8APQJC?=
 =?us-ascii?Q?0EXKVftNGwQqX64RPNCYAJ2O99k21v+c6zIZgSYq2N97WhGFGtoAG/kzg/c9?=
 =?us-ascii?Q?8YWDeBOCH903xzM6F7gJpz6eBD6rsWh8A6sUmq6KHqa5uEg7Be8nozPiRXhl?=
 =?us-ascii?Q?tP/e0h8IXvGBB59v9SgjHlJTZc/zmMkoN7wXqERaUa/c8yGQZCY0Qa8EDMPJ?=
 =?us-ascii?Q?6pkE7/I1hr5KANxvCX/saBTas2r3SROBW8WVB6x8U6kGLrNFwgkfKC4b2i0K?=
 =?us-ascii?Q?SARVinLonVQVYVojtrhb8Hpy1oI6WAYconC9se899pEQTrcxUzQEA/2ou4+z?=
 =?us-ascii?Q?v2ujC8Za/kFTChS9bZpTqM/a2yNHSpmRkcRuSlAmlLJI+TBp5Ts5H3PhFzjs?=
 =?us-ascii?Q?u7Z6YHKeopHhK80G6fxZlk3TxS2IMzsajge/TGNKat1vpvtqcMnDGgA8OvGo?=
 =?us-ascii?Q?iSwl1No6Qkgan3jUdyhYZZPVIJUGpPmC9W9bPruf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b19d1ea5-2db7-4f00-4324-08ddc8bcf5b2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 01:13:25.9417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +BH/WbGSrjHuogXtP//aMj6ZM9pSwS6Rn+kAzj/9UwlRjv3HSJHP1z9KlpMEwP4c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6917

On 21 Jul 2025, at 11:55, Lorenzo Stoakes wrote:

> Rather confusingly, setting all Transparent Huge Page sysfs settings to
> "never" does not in fact result in THP being globally disabled.
>
> Rather, it results in khugepaged being disabled, but one can still obtain
> THP pages using madvise(..., MADV_COLLAPSE).
>
> This is something that has remained poorly documented for some time, and it
> is likely the received wisdom of most users of THP that never does, in
> fact, mean never.
>
> It is therefore important to highlight, very clearly, that this is not the
> ase.
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  Documentation/admin-guide/mm/transhuge.rst | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>

LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>


Best Regards,
Yan, Zi

