Return-Path: <linux-kernel+bounces-841559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BEE0BB7A57
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 19:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 52F834EB0E2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 17:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788372D7DD4;
	Fri,  3 Oct 2025 17:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DIPkFVHP"
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010070.outbound.protection.outlook.com [52.101.56.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1C22D77F6
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 17:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759511079; cv=fail; b=e3DMHGnBy94pQ6Sxxt5fh7piOxoXOJUWhUV9KarzoHZ6bg/gBXMzJngmgLACqqb8a4Cz4sFW0rK5Z3s6iYmOsGyVUF5XQodmXvRsbb5d08I5r58dvqRUMYK+MYFTy4PHW1+S7YV/ts9uJ8lQ6pO0mratjCl/mCFU4SPkcWtMjRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759511079; c=relaxed/simple;
	bh=a46/Hc/tHv8B7GkLebQPSKQ1qSExCJZ6zLcQj82jyqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LLPEr5z4tgIlRwfbFkiSy5QGS7w8nYyxOH5JAJ/J1luYBzEtPGL14AJMGkIpeZ9QlBDftL+Hfyzp5g2N180TsVK7xpQtlOtwPGMM31mX98pSmlWrlxMBEaS7cWilhAbU2LoKCaFk8bSWCCQvsrlN58sImpKuuqnALyi/4rpMxnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DIPkFVHP; arc=fail smtp.client-ip=52.101.56.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aCPafiwux4uqVdZbVaZ45wN5N+zfc4dh6qAKd7m/LRi+yCm4gZReoCKyQTxdBz/fNG0ZSAc8rmk39gX/XhgZbOqh8XNfBqiLL2ERj2WU7kl0oDfYlNJXDZHArZ2kSM3WBVJTC6lCHBQ/IKyoJDhnnv+thgLKt7FOxinTE5fKSiVdsyGvbRPgoQ0M1MhSXmponE6xhWG/dqUUtWHVFHPKJF2+LXrV81T0rRpHaSKySbGRvoS+a8ImtvHD+dyiJt2lN7dZcSXkgUV1mAbRxHI4+vOYmWsgx8kaBYJRQKSDq0xEWvi1z30lmejY/pMzbl0agLHR+SjwulEWmO1r3ew9KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T/vNt78+hgjIZu3YydAOh+5hwKVyIPwOoz2XX033DIE=;
 b=MEva5zdRJEQrY/9AxUP4mjrHPGMOl8NMypXga6692nmbU1EFtFq70P4pCQ3i6BE32tJIXIQjOb0gjh1ggrl0lthOepkk3zLuS3F6ZjzJ5CNs2Cfrlxt2dIsXxsfrjg/CuCodMSWzNfNceduvvMexp5Ddvaf4LPFT4odg4Qg+0h0zHcXvD6aRm+Ucoh7aK6+GxuEp+mA86NRCRdWFJLRV9cIx4by9G9Wq9v0FDw5Itb7YAXtQdXJYYWU52TPuc7QWdwLvQUh8I7/F9AjnH2pzVqdcvCVqoRGTpCGS2KMdeT/Z6D9M3rnMReK1NIvLP7ssqyj4FOu2EdozQ/Lv2Ha3Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/vNt78+hgjIZu3YydAOh+5hwKVyIPwOoz2XX033DIE=;
 b=DIPkFVHP1vBMVpU+p/o6DTO40nG2TWEQjX/xn4Xb41LfcFbiHYVyJ3pR1p8s1oDHn5eItqy6dU32YMGUQPd/qb0DNPknGTtO87IP4jnrVHGfF7/2PPtnj0Xb4PNOCYXhj02tUO/QsbuoZ9kUUDVNmFY5zvoHjQM6PMnzWDkXu4zmLsryalQpRuwXeTjMcj/HlxhQf1gud17QFyxALbFi3H0pob3F/C3EwK5/mfTv7qTCEQF4vMd3PFb2GnMVoSGbObgBm/o1H12z/JwXMTW2PC2Xo+j9d8WOiajd0CT/w9SiZYj55x0V8+hNUpynS9N6HxTEQY1zpz0UVfGSpJDd2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DS7PR12MB6262.namprd12.prod.outlook.com (2603:10b6:8:96::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.18; Fri, 3 Oct 2025 17:04:28 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9160.017; Fri, 3 Oct 2025
 17:04:28 +0000
From: Zi Yan <ziy@nvidia.com>
To: Lance Yang <lance.yang@linux.dev>
Cc: akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 ioworker0@gmail.com, richard.weiyang@gmail.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH mm-new 1/2] mm/khugepaged: optimize PTE scanning with
 if-else-if-else-if chain
Date: Fri, 03 Oct 2025 13:04:25 -0400
X-Mailer: MailMate (2.0r6283)
Message-ID: <1EF78444-75F3-4483-B499-DD49ABCDE6FF@nvidia.com>
In-Reply-To: <20251002073255.14867-2-lance.yang@linux.dev>
References: <20251002073255.14867-1-lance.yang@linux.dev>
 <20251002073255.14867-2-lance.yang@linux.dev>
Content-Type: text/plain
X-ClientProxiedBy: BN1PR14CA0018.namprd14.prod.outlook.com
 (2603:10b6:408:e3::23) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DS7PR12MB6262:EE_
X-MS-Office365-Filtering-Correlation-Id: 4847329d-cd59-4c92-d766-08de029ee983
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vR8ct+9wvXoWHEfvFDd/gy4nwHjLY8G9Es8WQj++YQwM8leO0Z+ywQvoAmUi?=
 =?us-ascii?Q?cIroVLA4n9IDDUQKOJ+X9Itc+Jsa897pXpGgyY6eDhJtFHKpObalMVzEyBmJ?=
 =?us-ascii?Q?J0FFsEG70cxfV6ymphO49Ur/G1UpJvKOwnT4LYzCLRXk8QSQ265vx/J60MVR?=
 =?us-ascii?Q?/JuvgmFMXjAL5zNCRP52EPV7Onh659NccXUn06Rza1O5rEGON2G9cc2IdDBj?=
 =?us-ascii?Q?IBuOV1fMDKwSYvFWsqth8kMZtz4I7LjCn2HySszHhg3JThx+RL1SmRR2oXFU?=
 =?us-ascii?Q?DmCy8mfogymBdCW8+ngSoGw94vNZQShmnSroIeJ64/q99cW1L1V870hg30rk?=
 =?us-ascii?Q?Zr698C88k7WUAh7bqIYNJQO61rjhVL3jvZ/m88Ie077gHz7SZmUeZuCuLUIk?=
 =?us-ascii?Q?Ee8RYhDKmjYyjIZ7bsu0QjLrS3Pn7uhBo1GY0KVXd1EKWeSEXk6N5tgf/qjJ?=
 =?us-ascii?Q?YIviQipLTyEcoG7oB9NXUaaQHoNYcyWsynqf4WjvM+i9IsN0NMPX7UGxuyxl?=
 =?us-ascii?Q?tgfa+RV7POBvgrBpZphiLn557433XuT00abXHsftBnAc+e65McwLdPTofCGW?=
 =?us-ascii?Q?eqUVynyMQ2cziYT9dht1+RNr1gMbjfdyGjL4PQ2St5dGgPhsxZNMmWJF4z6y?=
 =?us-ascii?Q?t4oC/43sFixRzHnfaypKwKp6XkT0nwgkMlUMUvy9vDjlu/VR2373ITpIWRs/?=
 =?us-ascii?Q?DTHILVq6DiJZI9/6LU+LWu5GFtUfwOjjK/qFrFjIrGpUjt7V8V2OOy0m5RGh?=
 =?us-ascii?Q?8vaiHyUstzxd8n2Dt6+t4Wv/rFGxyKVtRwTNlGdqgou7dAqHI3Dzsi79HjBf?=
 =?us-ascii?Q?piUsD/SNwaSGGPSvWC0YK3IcoRTrLX2rSl+GOIV1K1egpD2fR4xBg+TM6NnT?=
 =?us-ascii?Q?9yVT7Wp5s4eKv7aQKVrhUSXGB8+kexHG/faISYgb6hgKF9VPqSBVI1K+JHiV?=
 =?us-ascii?Q?PuZAxExtCooDiiWYYgrlUuaYfXeef8q4aIM9V7k7QbpLDsflEo1awcEQzknt?=
 =?us-ascii?Q?UAMWNzraULBrYqToF6dz5IufaiK25S+VgM25/NdwJaoZhu2K5SV1rR02SiFT?=
 =?us-ascii?Q?Tzxd8l4wIbHWDwlsz6T0PO50x98EDNeK01H4OJ7oMmTg1clK2t+LTj8XGl8S?=
 =?us-ascii?Q?/7E4jlNGeaIfttfnYfQuGUfKbElxkVBXEzbhGQW+mzqLKwbUkdOn/q++BYwC?=
 =?us-ascii?Q?mosmvdveOPmltsKEmXXdaiy8v3gCG61BrbeEpWIWZVJFRkJeVx+8hOhgPKTS?=
 =?us-ascii?Q?FJYDiDyDZx30FPD3pqgWgdO62eandQNPfMwoZZfDcFY0u+W7X1dFc6/lh0Ya?=
 =?us-ascii?Q?oqUQzI27PZuOS07CS5rmjArPPbXgl3irsACJAvSL8Wk7dlc/sbo2pBXCIIYF?=
 =?us-ascii?Q?FHaCNSA3Is30do0U+nvc6wDK4mYJUNcKc7RNqLSqqkZ+RdV7f/8YoFQKYpXh?=
 =?us-ascii?Q?xV99NckHZd+DXTa0tLBfGs6iDkMr4Qar?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8n6+P1lhqxiUKd7lU8YorUwuFPxgTh5LJJLYVNGprU4AZrv6PObdZwrUS1FU?=
 =?us-ascii?Q?FeueOtIqV9aym4kjTqsHmPaX8wWtNYR4WaOZMuF11Oxt8mDdglntnqHq/AdL?=
 =?us-ascii?Q?YFcx5tzWbhG05vP5ZXveyg08wamHySBvM8BNLl4cUoW83D5DBXeQfkQwmHmH?=
 =?us-ascii?Q?q3lLrIxVz9saj2PIukh/hQEpkEjZmanlB9dHcTYpsXLdMl4mfhFnPT9P3Pnn?=
 =?us-ascii?Q?VmP2ST45iEAC8dyKjVxi0s0B4lGX0K/fnEUXGsyaElVzj6sfdkBH6NTaC351?=
 =?us-ascii?Q?Vn/LEYe0FYUgoQNEkkPo9YuNU0f/+mvCFEZWpmxf98hcD27stJy8MpeF0o/v?=
 =?us-ascii?Q?xNvEKvS1BsJvjIbKhiFzVWqZcNXsWlHxbdMQfHQ+BxN5wIcx8fO1xBz9Jcpg?=
 =?us-ascii?Q?Lqa6cPha1m6CcBoIBr70AuWE44uoeV7HbsZiFCav9O7ToEZ7UgS2Ij6ONt11?=
 =?us-ascii?Q?4qfiEL4e3gc62qHnLjJZsgZtfOlbMl8dcNmBN8gwskOMjF+xi+EGkKk8yPgB?=
 =?us-ascii?Q?Mes8AZ3+bLtV808qLG24+wJ/+k4Kp42KcZk2hgd5dNIJdotn+lZl7PB6nMVs?=
 =?us-ascii?Q?kblkOkWuCYhGge1ROoH17D35SbUirp0qvj1GDFACiq/pV5sNhWyncRgW7K5y?=
 =?us-ascii?Q?SXRM0dtCnqrFcX46pYSfRG70FdlcLZVAz80cFRQyKL2tCIuTe44bQb7dhyny?=
 =?us-ascii?Q?nNtKI6Z+RQMU9yewxdVYIZ0dVlUrHKpmUIvIh0mENvZJ3tAAEx5dRLvjNGhg?=
 =?us-ascii?Q?vqnWQUTJlj9/A3se6g90hmSsC9MTa4MByybsOhkEX1SUg29hwdhGRHkcEb+R?=
 =?us-ascii?Q?ERok7IAZbP8Jtg280l465u0rQtZGsYx8+09XsscueqU+qfAL4C/153eF7I4q?=
 =?us-ascii?Q?JLPtVgHKT0sJYmDCEv1QUyGlGRZETN8LhDSYx+1op5a1zxrq5JEgbwWKPKVm?=
 =?us-ascii?Q?B2ipAdJwWf7PV4PeLadbuo26AWlfbkdNEPJghgbeRrjk1eUPQtzaCkKRCe5O?=
 =?us-ascii?Q?LIAIJ5K6j3X7q6KmBszcwYbT37bEEFNtaWPbHqNiUH+CWOjql1o/z3mbqP7e?=
 =?us-ascii?Q?nkPcDg8dyp4S5qm3d3Stc/IanMpDGvXjsAUDz8Kyst7ablb5TYoUrUaTfY0V?=
 =?us-ascii?Q?y044KJJqVznaw2rARCjWKInCdEfC4Gq7Qbchit22jaYF69dNIaR9rg1ji7El?=
 =?us-ascii?Q?xgxeBkJr2lPK7lF2wtcE+mYDachGASSJFhMs7cmcey5O16FFkLW3GhgRxYmS?=
 =?us-ascii?Q?sIPXR5PLTN1XRxVH4s4rGqOPbbwAEYmksfWDhfoCNnzr65dzJt/YB0cWvw7T?=
 =?us-ascii?Q?4Kj3dOaS+llgk3uPn1w6gww1gxTJEblkZXC/lpMKl2ceJAdCDT5lrX4E610g?=
 =?us-ascii?Q?NaHaRfNQOMmSR5e6DMsVIWw2TIsFqfnIzYTEvZP/rlmyYWwnO+7bHKPWN/gJ?=
 =?us-ascii?Q?SxhKpW2lGL9j9aWGYacFYesa+XMPK9ut9i1/3Lup8cSyGJFi45suNgXtACxa?=
 =?us-ascii?Q?Y64w42pmcOzjhm0yoPRo0wESpmy+doiJnZJodvZ+VsKxqCGAhgwFJQWncmkO?=
 =?us-ascii?Q?Ro7UwFEm0BXWLz383fv2/L34d3dhgk1SCnjRDzOQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4847329d-cd59-4c92-d766-08de029ee983
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 17:04:28.0419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LcoO8RaT8kdygC6zXmGY+qv3dEjQMCJmNJGfJWaGKHGh3VBqj2RO0tLsOBPQ4z7Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6262

On 2 Oct 2025, at 3:32, Lance Yang wrote:

> From: Lance Yang <lance.yang@linux.dev>
>
> As pointed out by Dev, the PTE checks for disjoint conditions in the
> scanning loops can be optimized. is_swap_pte, (pte_none && is_zero_pfn),
> and pte_uffd_wp are mutually exclusive.
>
> This patch refactors the loops in both __collapse_huge_page_isolate() and
> hpage_collapse_scan_pmd() to use a continuous if-else-if-else-if chain
> instead of separate if blocks.
>
> Also, this is a preparatory step to make it easier to merge the
> almost-duplicated scanning logic in these two functions, as suggested
> by David.
>
> Suggested-by: Dev Jain <dev.jain@arm.com>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Lance Yang <lance.yang@linux.dev>
> ---
>  mm/khugepaged.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>

LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi

