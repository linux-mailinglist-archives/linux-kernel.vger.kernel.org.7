Return-Path: <linux-kernel+bounces-799097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 952DDB426EE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 18:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F86A1BC179A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 16:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952B42D3ED2;
	Wed,  3 Sep 2025 16:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a0yAlfhm"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADE32D372A
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 16:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756917020; cv=fail; b=st1nLE4b/f3Mx6ZGIW2UfTjUwMr8ofQMaYDFht61DqcKsJRp8WZBt21StO5DZar1Ytqhn43jj5ReoK+B/xtGaY/ZFgv6AbQDhW+uHi47iTcNPhm0ca6kEa3emI5P6rCTPBUiaGqDMSSqsCal3iuXG8WhG1PIWKdFHmNUtXNMZUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756917020; c=relaxed/simple;
	bh=+dawaVKy1EV4092ISx2OZZXs8MvyDJXhNEWHpoP4PO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jSc2ReJeY/7Be6jzxCHwaC8y2Yp7rBNETUlFDAU3dW7hcm+mW6Ewp1wyNKgTxJnWxaQvZObf4d1k63Qhlkg0IDuea6Ok4md5xyRHOyF2I/Mg7NnTx6RqoogDhKaUC03kPq3HuLHYIg/Qf/N99WaIeQ2NEEmNxHzL1+EwaWeGWic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a0yAlfhm; arc=fail smtp.client-ip=40.107.92.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fTvpy9Ci38F4AH7HNUsNAby9qGgUPub3+IUR1NryOii0QxZ2rCX5IMk976OQ7fxPKySjXNxOedkAHyUdNHow6mdsQZZiS9uWH17HyE/weStUibZygX6/QsnrinScQV6fxvToFM8QPxP8mHhL3q8v60C5tGVi6GMgQPIhApZR+J9RId9PAaDnlbf8iQN1MQyBKb/vwriFP9uNB+Y6QkDRhu7hyYYm/1iGIw5f96vzoIcyR9PgBynJuBT5iQ1jvx44QSy1GVnRP5jIyHEEtaiBYQI0BN5knSPBMdQXP9OclFNz3ysh4J65p9aDzXt2+sH0vg2LqbdmWWv4XP+b23tnPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ikd4Ck5K9rBEjcpNcMFAassNR2Z7UbD11SsNKNHLkNE=;
 b=JaFU7wDqp+FHklzQafHlsGT1qlOIvsIBb43Uu5APqYmXNd84c6IPtCzIlTgiGoxvAZOdken/SJsQDv8/b/OWYsH3Yfr5hh1WHhBILa9trNFcc4rdYrkwVpqe80JdEp3e/lF1T5NZRLNn3y8kEhtg/TUxuv5W+Ila+qEC3hMvNMuh4OEsj9OFG+vhmGddNG+lTg60F+tv2QxxRQEmTnadhAerpU4EF6uuijsoNalbg7zjw8RWGxAHvznxutSg3OrEukXI+a+uX5lwWvf2a2ynnoV8IVJFIbe5FE6hmNUJSdCcksEnFOB8t9SnIriWQqmVM14xQIi10X6EJ5tR3zd53w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ikd4Ck5K9rBEjcpNcMFAassNR2Z7UbD11SsNKNHLkNE=;
 b=a0yAlfhmSpxatn2iIgzBnQMnYC/vv0hgGXMPTnPMX9TT/gpCWhi2dxqTBje0gnVvsmjATKv2as4h1h57JPGX0QMBTnGf3wuZBPrB1kFEqn1qGJBHUSMgX2f1lUxo6JTCVWLO+qbZNjr2e/HVhEvYnIhfhUuzj166Vb1UsIpfVnGaa6bYvawBliECvcRytye7Pb0IGsFF9oY9FhHU/SiuGDNKK1z8jZlRMRDe0LG/CNisYOyWv6IQPrEqaVXI0V0Pn/guus0VJGXF4cEcGkaZlZQ60NutuXhCS0SN2Do8MkZ0hRS3kFw4kejMXhq9dFfxga25yKiBO+FJIPgag6xvLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CH3PR12MB8850.namprd12.prod.outlook.com (2603:10b6:610:167::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Wed, 3 Sep
 2025 16:30:12 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.9094.016; Wed, 3 Sep 2025
 16:30:12 +0000
From: Zi Yan <ziy@nvidia.com>
To: Yueyang Pan <pyyjason@gmail.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>,
 Michal Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Vishal Moola <vishal.moola@gmail.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Usama Arif <usamaarif642@gmail.com>,
 linux-mm@kvack.org, kernel-team@meta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] mm/show_mem: Add trylock while printing alloc info
Date: Wed, 03 Sep 2025 12:30:10 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <087C9FD8-BEDD-4CF8-82DB-E3B909FEE321@nvidia.com>
In-Reply-To: <4ed91296e0c595d945a38458f7a8d9611b0c1e52.1756897825.git.pyyjason@gmail.com>
References: <cover.1756897825.git.pyyjason@gmail.com>
 <4ed91296e0c595d945a38458f7a8d9611b0c1e52.1756897825.git.pyyjason@gmail.com>
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0567.namprd03.prod.outlook.com
 (2603:10b6:408:138::32) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CH3PR12MB8850:EE_
X-MS-Office365-Filtering-Correlation-Id: 41eb13e4-346d-44fd-e8ac-08ddeb072815
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vhDPPkL/HYV65FEtikGC8/5wl9D7uJ9M5kcsL0vVYMRdTSTM/jKvUAFVz2xR?=
 =?us-ascii?Q?pgvQ5mc3U+VDrZMefKRSBq6oM1tCstPok+e0zfJF9OD9VbY9fUQVQzFSM9vV?=
 =?us-ascii?Q?9GoGAEQPbdEEZBRi2Cb3v9blqMf3BZJkR5uUZ+amX50t9/Vh4SDofRmGNuGv?=
 =?us-ascii?Q?/yxqSuOEWheIR6AgIm4TkN6HcEvWyk988BrZlle6RpBAc5PQqW58ZepqbLmb?=
 =?us-ascii?Q?je/ow62w6fx+jRCpayS8WBHSHxwNGsvU4WQqjeYADFWNf83CNOcFkQog5eOs?=
 =?us-ascii?Q?hJTNxBLPdIvfdjINmBukEZqMbrspTR+49tN+VwVD38vUOTYmCUDpUdBwUK/t?=
 =?us-ascii?Q?EbXvAEBMuX6++Kms0HGTA45h0V8D3hCVmC3mzjuWsOe3f+Lor5MoV9XU4B4L?=
 =?us-ascii?Q?CvhG80/G0k3g87q6wRH7QolOhUvXIaMoUi6ATyVTV7xIGvWxUzcQQI399pKn?=
 =?us-ascii?Q?W5WX0Xhl4W8Mcd+IBrw5bGKRvHZph2WDz0QIequuDGLtKIgeY8OBtxTGGzH8?=
 =?us-ascii?Q?2WSSFt1GuO6uZD8Cejfabr2CkgmUdY4IXqiXzq3T8yD14WOvGzlHyeRB5Zvl?=
 =?us-ascii?Q?jZTWtZMiVfUHsliSKzXjiO3cgQhBMBVOXf8SEt9NGmUq0SXeUfayWVu3BIH3?=
 =?us-ascii?Q?qa6cZcm3KCv9G6pIMiU1zIJINAgNCODQgARqTGZezKGiydlOuaiOuwZFsRVc?=
 =?us-ascii?Q?Zov0sZCwq3XwBJSrMrZQtLMgOr+78Olb7tIdMDlgnpqgCGGZhFdSHVg3QKrc?=
 =?us-ascii?Q?SRacvEh6IWYj4eUrdK8nXT5NgQl8UOI64Vxao+V8akCYk0bsDjtFKbuEv0FI?=
 =?us-ascii?Q?/3dmAXOfZtoKoMGoDm3ZPUOK23nKnt/u9dOcnuNvnTlm01JebMOcxARtC1rW?=
 =?us-ascii?Q?vf791XqZd7HGbYnSOclY8TF80u+jBOyTwglG2asLUZ7c54xJHtXexL6wirob?=
 =?us-ascii?Q?BNV1ES5ZTMKBZh1SaCAnT3aGZgfogn1d5VHqBTSZ9F9TpYH+oMIAFY57fH47?=
 =?us-ascii?Q?Yf9yOkSELWgzg2pLJ0Y37E/yCHUjZmsCpteykuuu7cGVm6K7G0c+ouQwuKdQ?=
 =?us-ascii?Q?ickvplckfeuLiNLiJ21ekHAwAK65c9JJlAUe8oqiHgFS5XPl5mu/RaPs8DvA?=
 =?us-ascii?Q?hYM7I2QfaktSUFM9tcH3Yl2AzKKgpCp0HrerwPI3DX9VRK1AbOMUaC6I/MPO?=
 =?us-ascii?Q?q7mTRTCu+xHmtIrYptxpyAqyB/NdsDUN+IsCN19Xokd46ExvaUdSkwbO4nJu?=
 =?us-ascii?Q?d4ETULxcK0iWC0+mUbWiXZWYIxYnwIjR24syug/77dKJLUWJHW1pOad2cfp8?=
 =?us-ascii?Q?w5UooEBugMcSbBHQIX6eG++fbzvCcrUoSs3I1STIUHaz3u2lpq0T4r9GHQVR?=
 =?us-ascii?Q?6Vrrqumd5RI549kxc5O2eNhjbHCbYgdJLhHNZQ/5XGEZCdqgprIvane2mlSj?=
 =?us-ascii?Q?w//q+3y55w0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nQBrmnWuKz92x3IyNGgLn81rpn2u8nHjyWtV5GoQGjR8wuJgaMNsuj5cNCU5?=
 =?us-ascii?Q?yAMb4cLMvHg0xQEUyTWxdUd9r4hPUcu+qFpPwHb77ifx/vS+oRCB+GdJXqkj?=
 =?us-ascii?Q?iR5ElFRfYUh3vx6Ojmm26k+Zj1RLY3NpdbIgtzpXYcGbusDI+wuuVPkYyV4c?=
 =?us-ascii?Q?eS+0ydbFzRSUfLjxVOQ0Sq290H2p2Qh0kwl/9e8sB2g5yL/AeuZL6WxY6+8e?=
 =?us-ascii?Q?qSV7xPIF9iNyL/2vdHrgJ6wHqn5yYlcsmVIMi38+/Br9bRSXTUKccJ5izw/7?=
 =?us-ascii?Q?8hyvjHR9E5DcciB4xJ1U3JVs5wWbrd9Q+69tSxPafBYi9v31K6DCsyoT9Pdz?=
 =?us-ascii?Q?2BK3Yfi5Lin3IuFL/Zj89LzRidT1xpGayMcmmsAwC2zATF60CJcj1O4Cj1K/?=
 =?us-ascii?Q?QCOqnUBAf4lxH7Fx9St6iBHVHtso9E3uNQu4anuAT40OR8CkARPFGxmucrkW?=
 =?us-ascii?Q?yCZXAxrxSz/LIDEfLyNl/a9DFUVhN7MuOmjYmz2nH0KUlHt1dwnvvxCjHsWw?=
 =?us-ascii?Q?cPGlcS03gb8XXVA+7pM/LHzhO9XSpfks05erNEkyWyZR1+0G+ZTFmzZILiST?=
 =?us-ascii?Q?IA8xGPPdYxJ7w5yM04xUihMaJ8BL2a8TErb9NofvWM+rPRGHSZq3QC3iDOSP?=
 =?us-ascii?Q?9CV12uOWYsApIJMO4gskcrqr7PCZy2ns/+hgMxrbqlZ6cHfBtf8as4CL6evX?=
 =?us-ascii?Q?9QUHX9ZVmyZd9ZxFBNbCF2PN/3RRapiLEEzr7GbsSVycDqTk3W33fvSstQ5j?=
 =?us-ascii?Q?hmDkvK1u5brKEJV97JsxwJkNEBy1p7f8LRfxkXqr3/2b6O3nxIKNZH+TVxuy?=
 =?us-ascii?Q?AvSSuNhlW92Cc3LXXA6NiI8F/LmiWVykIa60vBWQtqgI3+TbxsnhISZ0APWN?=
 =?us-ascii?Q?zIB0tSmwC+5s6ciY/S8p6q5tymjfdsXA1o3axE6kKncHod1ghq5hTfpHSYL9?=
 =?us-ascii?Q?y+SiXpzVQaz9VA3AhRRi/KAKwacHoO8/QPV/w49lObtRTMingsnp1UyGqBtO?=
 =?us-ascii?Q?czEJkXXrgzZG6ox6PXakDxmyTtR7msh6I7jwUGclEgJtatmNunmA+nd392a5?=
 =?us-ascii?Q?3ATaHv1Nb50B4OTfmTdIJgkrqeLZHhxV9FSfyCy0b+W1CI4F7RLy47AdmhUt?=
 =?us-ascii?Q?W13OevsNC3UIfWkx1r/ihTqjy0Q7iIVoUxs+d6qyX3xeuG6XgKGS0LdWHvwn?=
 =?us-ascii?Q?GRviI7pxamJxtS7Io/orvSKy4s/m4qQ3pMFgNgTRSE7heTzj5jVFIeqng+88?=
 =?us-ascii?Q?gTFxh4w40NgnIWRne5Da8R3EKdusJII8RvXzJQ7ZvtUiouQ1mR7w+crBhQD5?=
 =?us-ascii?Q?4o/bd2KgZexL7nGwCtyq9FxaBrkq2iNCxg/jFttBkDVv+aKcXitLF2ti7Mwu?=
 =?us-ascii?Q?aI458vA2YTfR3GGcyYBiLfNpHaj52DKhx9QjhHi2k55JDCQnAHo5AEfQcxKw?=
 =?us-ascii?Q?IF6BOypJAQtqir0yf5E8moL2d2BnMC2xSLYVfKkwT6FU+irPEZ7zYN75Z/sW?=
 =?us-ascii?Q?B0uJX2sBd6rGxT9rUYbYESTUySoAfWgjIRmSsZNDiN8+V+YzwUm/GSc9MOmM?=
 =?us-ascii?Q?iBd30+6GIqH3nFGUZWtrmjNNIp1V3l4BshqlD6jb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41eb13e4-346d-44fd-e8ac-08ddeb072815
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 16:30:12.7434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gF519BJ583SSZWL2s04ButGgHZ+eOCCU/Wt8qR6/wXO3tokX3ptXW7Mum74Ge24V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8850

On 3 Sep 2025, at 7:16, Yueyang Pan wrote:

> In production, show_mem() can be called concurrently from two
> different entities, for example one from oom_kill_process()
> another from __alloc_pages_slowpath from another kthread. This
> patch adds a spinlock and invokes trylock before printing out the
> kernel alloc info in show_mem(). This way two alloc info won't
> interleave with each other, which then makes parsing easier.
>
> Signed-off-by: Yueyang Pan <pyyjason@gmail.com>
> ---
>  mm/show_mem.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>

Acked-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi

