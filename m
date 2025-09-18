Return-Path: <linux-kernel+bounces-799007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 131D2B425C8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 17:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C29113ADBA1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C6B21CC7B;
	Wed,  3 Sep 2025 15:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AHH3TYs5"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31964207A
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 15:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756914399; cv=fail; b=HpBs74SEwd3zVE12cJ089u2+BvDfPaR4s44Cuz5zUD/Q04VgXJ8Y0qDbdZlv8XYrBGl8YaDv1Nnn9jyLA2x7tjRTgBdx5zbjFG2FHnhug0T4Vc4erKSqryL72JzJ8tFomZ9Dlt19hhGZZ7HXBauj4H10jotQ+3FKdVGT/cGRzYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756914399; c=relaxed/simple;
	bh=fZM6p3fASbR5I8Af8G6zm2A5Sycfdnm/JBFeUV61qZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ojG9Apypyp3ZquHX7V5pekd1VePL0zLZ42W0D+tY2sC+bU7d6AQUNuplkKxm6UY+lqiFEpEtGVyp5MaNWRUaHoexj8WcEZWViaKlLehC+O3QdiIA9p/pJ0fR7iz2E3HHAni61QhXUE87fniDHxy6oB36Iy80tsuVASiUYJZUGD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AHH3TYs5; arc=fail smtp.client-ip=40.107.236.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YJxLrT2Q+1sRI3OvkpB9FopQ3iEfHGCHV6oxQU9fbx7MNZryjkVtXoxXLvgDAsQ2YQ+aGNOaio7i5FXqeafj4vkU9nFEJlYj0y2iWssBd/nM64ngnrYO64L3IIP3taHxYqlXioZiNtwYW7u8vpCCJZ8/jMDTYk3Z4S+j7v6vupqMc47h5yRzJHiCWJcDJKo7LPYNc3zkCP9eV6DpHOBC2VdUmksJgYdRuKe+YlgM63j33rJNnaCZYTAg5yAn0oED+BJXnXD9+rSX3o0f4fbL4UQ/NR7NZkpmZj7tIa5GEdAmOK1yg0vX2aeIOkkQE9IZ3NxfraYia0b+xWsSP5GvcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vfgfun54Eyt+H1kr82jjedU4Gap2AhoJHAfG++ekZr8=;
 b=RXYAhkpV355GVDG4nmEKF93ANDYRaFfK7Gfnq8pe04WAJux1lf2Y48vGqxWc2EmKiQ6xv/MlUdj9pNsIphfuSXEdxeCzF7cipQdZyv2i8fN3athJGikyZkLKXpwyIOvXJxbixMof0GpCjzlr5MvWoWBPShMqBHm5LZeIpqAAX21jwPC7IcLU3YTEPXfUMBTiVt4IEesnKU8J4GHnO25Fv7boHr/5Jup7bbSGn5iJigXEB40ZtKk6TeKUKpiK3VeRB9TQp7z/jzUL3Q0DBF7i3mNdFgc00B/6q0a1MBTrLbVqXvDqdRiMF6jjVL9ErS5nI4hbBI3TKkKbv1oxW91A1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vfgfun54Eyt+H1kr82jjedU4Gap2AhoJHAfG++ekZr8=;
 b=AHH3TYs55F5OKnqyvgQi/tEemMtdCc2FHbA4Ks5wtA/bYxMPcl/COP4E6xFWQNwrI+VuPVAQAZt3/7P4Z6j7d99/6ZdzqP9xsO0rWRqGHjripWpnDtXu7Z+h3xMr/alGcQuoToNnbZ+OsTFQTonpMqjZuiAkJiDgH2s0FH5c27MWa+mqMw0qcoAVsVEDmLbSyh3YvoKy+FXB3cs3etSFmZIuIrAPU8O29np3zpGKscyv/DyIvAGcSmL6TGGIzd84ZXH7UFBiK+tEqo9T79LjNGDjTrbZ269Tfdqa2O0i34Fz2UcvBibeAF3Dym8X3Ykn92wZQ0V2IEx9swCthQ4v0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 LV8PR12MB9232.namprd12.prod.outlook.com (2603:10b6:408:182::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 15:46:34 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.9094.016; Wed, 3 Sep 2025
 15:46:34 +0000
From: Zi Yan <ziy@nvidia.com>
To: Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, david@redhat.com, kas@kernel.org,
 willy@infradead.org, hughd@google.com, baolin.wang@linux.alibaba.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, baohua@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: Enable khugepaged to operate on non-writable VMAs
Date: Wed, 03 Sep 2025 11:46:31 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <EF78EC48-5AA7-4999-99A9-181C50C35A6D@nvidia.com>
In-Reply-To: <20250903054635.19949-1-dev.jain@arm.com>
References: <20250903054635.19949-1-dev.jain@arm.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BN9PR03CA0060.namprd03.prod.outlook.com
 (2603:10b6:408:fb::35) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|LV8PR12MB9232:EE_
X-MS-Office365-Filtering-Correlation-Id: 8df8e291-337c-4c9a-46b9-08ddeb010f5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F2zZjxj3Fyys8ITba1j58TS30wo4LLXpOo06AXFxGqvl0nX0yZYny/5CaMM9?=
 =?us-ascii?Q?PvObY6e7DL6gzVLspi6vtA/LbwjkHTuILWSZeeZ5CtrEtWvTRrUSiwApbu0E?=
 =?us-ascii?Q?xT+r/BXh6TNKXRwMTszp/e1MsLGAwSAvb5iGdKrG0NghK0XauQp8knHiyBfs?=
 =?us-ascii?Q?T2nbTQ1FyGnbz6m+wZm2+b3w8Qe/s1A9F+6MSLlcq4EQEa+lLzWtceEwl83Z?=
 =?us-ascii?Q?Uyl+h9jlqcHpZ9pbJifI0Ta0u2MC0HXxgUJkhDJad33LJZspMyEVZILj8SVq?=
 =?us-ascii?Q?zDBzhvNqjznVdXUgj01aXB03BKteeg0INiuWPsmWXwIKDNtSM9lyqmxMmOwG?=
 =?us-ascii?Q?4QzqDarkxM6zIW1wTEzGrtRewXdHQfBn+LD8IEi4N0E/juMiSHDJMcPW3BJW?=
 =?us-ascii?Q?lg7CsE4X+qPDfgUiX8MrmmuBZRnQIuT2YeJPeqjbnweRzNPAcZmS3PE+p/WF?=
 =?us-ascii?Q?j5X6z1n+LQq4eR6gBxRqMh0zCeULbDXeUtnMpeLP61wZ7dTHdb+CB0q9lRPh?=
 =?us-ascii?Q?wOi0UjHW5avdXjgpHzAYRbpUyTwGfXDsy+JWKXe1u/Met2TwqucmfUrJ0KF2?=
 =?us-ascii?Q?nSVJRLGfHt4a52ohsDBN2lTvssaxWVT5fujswieImCG40ZpzYgZ+wqVU+LAj?=
 =?us-ascii?Q?FD9dNgKZyM80E/2yu1k7mflV8OneGYf/QK+Tv5aGPbMsoMO1zEZ7rAjfFrlH?=
 =?us-ascii?Q?gxz/k/sQ/gPYABMHsO9ItdwbR7VgwFvrhB3g9/HdHg9Em+JdYOeBtLBRl4+7?=
 =?us-ascii?Q?3CfP3dEkw6oNJDAZjJpDZIqgbNXfCv916ANUt3Pz4fDlm57xw/7GrlbJxM4F?=
 =?us-ascii?Q?C0PInD65KHNX7kpWxV25lZm+q4pSLNaF26LW6c3gLLo00ELOtf8xA+zOSQEN?=
 =?us-ascii?Q?jT/4EmKKekRhJE7+kXM1sPJfXyiAIBGydoMlzHqlL5j9z/ffSEsT71veykHk?=
 =?us-ascii?Q?VGfScG+iYhiDQRkf3/1zQPKMP7N+ME7eJBJPZjT9Em2xPhl2UoptWjZ4qAV6?=
 =?us-ascii?Q?3lOeKD4R/YtT/+XufNji6zq80G0xWLTOdzf4ZCW5ScD1MczxNUMC52CK4oS4?=
 =?us-ascii?Q?IHS2bdbvWhj99aKUg41GOcLNra5baWgRvnqQJmXxdNr4TrZ4KY2uqaL6HDVx?=
 =?us-ascii?Q?rwtDXdjBJMg10guatwSAW+BtIjeDbiRyzWl+3Ho3vNAqoKzI3PDGgLGKjMU0?=
 =?us-ascii?Q?1ZviZsjDsN5i5fmVPr0CTgU5sqJWzK82Lc6C9aX1BR34wKGSLCyOKu63Paq0?=
 =?us-ascii?Q?U6OibIRS8ez7snNhMHpIWT2xT/dwspO9olM6OhMDMDY6Hb4QaaokgmDcW8o2?=
 =?us-ascii?Q?lhsYCC/MXzSYwM/wc1mmch+RUHdHVid5BagLAZSRspdnXxGx3U5AISWN1rwP?=
 =?us-ascii?Q?q07jof7DInMxtWzisQZ42H2f7WCzqo/Ulzyu0XHX+wewYiMn/ouLp3pPggKm?=
 =?us-ascii?Q?wblSOG+KgQo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gWKXvo7NS8e/LLHiwlS1VNrkMIWQKX1hVlHxm02//1Wr33V5GdYJtakGLIVJ?=
 =?us-ascii?Q?jlQ917p/oRq/IuAWTUeSTmM6En7M6p/34IZMYnO9mmLy9maZeTuJkgDihTnJ?=
 =?us-ascii?Q?cNwErtHKbeONh+7xcTIG4futErVN/eHkaId9kD+Jj1RtqdCrav2UnmFh6mhW?=
 =?us-ascii?Q?ZaTHpwlSASMWQp7BQlwD2eARFU3l/DyQcgPdaP0CV1NKcTaVIRTDx+NERFnW?=
 =?us-ascii?Q?f3eNIjBzGHagkRymFKlIzxnGiaT98SN46VMwGHJmS3BhStmAR3O7POiH+sxS?=
 =?us-ascii?Q?fTsdPHi82r2H+ogbpkZFz9lGp4GRQs/Ctd3iijO0S2+Qypqgxc+MIhjN8Zk+?=
 =?us-ascii?Q?4+WGL0AIyOlE56APAn47F0aueAShAgdsaSvOjAwmeMaFuwroP4wK04V4xRGE?=
 =?us-ascii?Q?IB0mpua6wQUpz5/D4X5ouxPaR8QFLsP099VoQLL9lwfYW5REIcVGWH8XBUae?=
 =?us-ascii?Q?Cf73X5iSwkCCwBUB3RQzWAGsXIuAqZEKk2pHdDV6rQL/wkxYrn9m5kq4LKVT?=
 =?us-ascii?Q?yIAMrs7HbonkInAxLQ+qlY7BFBtvOCKa1YRKY9wtgDhFWNdM7foPgvQ+77N/?=
 =?us-ascii?Q?VFrx8NFy5kXwQEuDEKn5abQE8zmjnyiVIDwSPLIX6sb81C5ZFPyAveCtZq/l?=
 =?us-ascii?Q?pKgOmak9JShBIOpq+5xiLZxY95RUxvEfyCzvubQ5kZWcg2KyGgV/FXohiXBa?=
 =?us-ascii?Q?9u9eOP6bKWUf3nq28Q9Kt3jP0V/hWjRvSS6hXVkGrRpbJVWBlWo3ZdBOXVX+?=
 =?us-ascii?Q?5odkm9fuGAClziNuaKTENr9LBPRUUiIuuAKpfkWMBf3FQ6Eml1ELRRC/hgya?=
 =?us-ascii?Q?M2aB5WeLyKpCaXD27JnxgUe35HqdukqD+7GdmfYmbvSPL3ZbhjRJ//NiJEs7?=
 =?us-ascii?Q?onXtjzpjkHqOafz74Tdj0uWXlf/OC6+wADG0o3vNBZ1RnEI5Crez/z8UAWSg?=
 =?us-ascii?Q?+/2556od2X2BYjCgJtoCQ0iSdoJhZwClZWUbEg+URMmBzYzUUdvUWTFGXkRX?=
 =?us-ascii?Q?S6Dqrm+olboy2HW3qBz8+wrEaAtdS8/vPw/j/Mt2LUrWHtab8mUxdr2mirah?=
 =?us-ascii?Q?K0AqeJvU4nz0rKyA9p+lA9qlClJKwlRDuUUK6Wecas5etaR3SN3b6HdJhLTF?=
 =?us-ascii?Q?Ik1vhtzD7LwrYT3e1nNV7lGsQuAdcW1wGj0Mh1IQUbGj2NTdi60moXTach4P?=
 =?us-ascii?Q?g/1fCxWjugGLCieq5GWyN6zgJixOVZWt012hWbItbAfUM1pOVivCMQRU9ebp?=
 =?us-ascii?Q?oRT4FoyDgI1Pzs2Y9KgpGwucoYSTGL7ScQ7zNmnpg8KGINs49kPQxEfDMv62?=
 =?us-ascii?Q?ZLd1Z+8zKV6IaJUk7QLP+hcy7vGuubiKXCJ3ydhIwxEDMIlaqKP4YPVwbrB8?=
 =?us-ascii?Q?SFkPbMbHdXSL4TOqMsn5hNye5Ge/Fp522vshtqjYhoE4aaNWWNN+xa3qksD4?=
 =?us-ascii?Q?FhYPEkcxw8jOiB6JMLqznSZtlv1TSlmmpbe9v+d6533c2dTPRUeXfj5jLPOs?=
 =?us-ascii?Q?qcw3hWOfRhmaocrW7OGBVlx4Oa8fwocakByrVGBwZSSGTXH8Vofe8/sGmvmu?=
 =?us-ascii?Q?L6spWFEU1b3TS3h1uEdSKxksHIviYJhn3FA7uUvn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8df8e291-337c-4c9a-46b9-08ddeb010f5d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 15:46:34.3066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U3HPE6TMpdVeVvP3sHwAkOdE1M/Qv8bL4TY6an1LRd0j0a/QtgIYu2XYCE2Q4WVW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9232

On 3 Sep 2025, at 1:46, Dev Jain wrote:

> Currently khugepaged does not collapse a region which does not have a
> single writable page. This is wasteful since non-writable VMAs mapped b=
y
> the application won't benefit from THP collapse. Therefore, remove this=

> restriction and allow khugepaged to collapse a VMA with arbitrary
> protections.
>
> Along with this, currently MADV_COLLAPSE does not perform a collapse on=
 a
> non-writable VMA, and this restriction is nowhere to be found on the
> manpage - the restriction itself sounds wrong to me since the user know=
s
> the protection of the memory it has mapped, so collapsing read-only
> memory via madvise() should be a choice of the user which shouldn't
> be overriden by the kernel.
>
> On an arm64 machine, an average of 5% improvement is seen on some mmtes=
ts
> benchmarks, particularly hackbench, with a maximum improvement of 12%.
>
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
> RFC->v1:
> Drop writable references from tracepoints
>
> RFC:
> https://lore.kernel.org/all/20250901074817.73012-1-dev.jain@arm.com/
>
> I can see performance improvements on mmtests run on an arm64 machine
> comparing with 6.17-rc2. (I) denotes statistically significant improvem=
ent,
> (R) denotes statistically significant regression (Please ignore the
> numbers in the middle column):
>
> +------------------------------------+---------------------------------=
-------------------------+-----------------------+-----------------------=
---+
> | mmtests/hackbench                  | process-pipes-1 (seconds)       =
                         |                 0.145 |                   -0.0=
6% |
> |                                    | process-pipes-4 (seconds)       =
                         |                0.4335 |                   -0.2=
7% |
> |                                    | process-pipes-7 (seconds)       =
                         |                 0.823 |              (I) -12.1=
3% |
> |                                    | process-pipes-12 (seconds)      =
                         |    1.3538333333333334 |               (I) -5.3=
2% |
> |                                    | process-pipes-21 (seconds)      =
                         |    1.8971666666666664 |               (I) -2.8=
7% |
> |                                    | process-pipes-30 (seconds)      =
                         |    2.5023333333333335 |               (I) -3.3=
9% |
> |                                    | process-pipes-48 (seconds)      =
                         |                3.4305 |               (I) -5.6=
5% |
> |                                    | process-pipes-79 (seconds)      =
                         |     4.245833333333334 |               (I) -6.7=
4% |
> |                                    | process-pipes-110 (seconds)     =
                         |     5.114833333333333 |               (I) -6.2=
6% |
> |                                    | process-pipes-141 (seconds)     =
                         |                6.1885 |               (I) -4.9=
9% |
> |                                    | process-pipes-172 (seconds)     =
                         |     7.231833333333334 |               (I) -4.4=
5% |
> |                                    | process-pipes-203 (seconds)     =
                         |     8.393166666666668 |               (I) -3.6=
5% |
> |                                    | process-pipes-234 (seconds)     =
                         |     9.487499999999999 |               (I) -3.4=
5% |
> |                                    | process-pipes-256 (seconds)     =
                         |    10.316166666666666 |               (I) -3.4=
7% |
> |                                    | process-sockets-1 (seconds)     =
                         |                 0.289 |                    2.1=
3% |
> |                                    | process-sockets-4 (seconds)     =
                         |    0.7596666666666666 |                    1.0=
2% |
> |                                    | process-sockets-7 (seconds)     =
                         |    1.1663333333333334 |                   -0.2=
6% |
> |                                    | process-sockets-12 (seconds)    =
                         |    1.8641666666666665 |                   -1.2=
4% |
> |                                    | process-sockets-21 (seconds)    =
                         |    3.0773333333333333 |                    0.0=
1% |
> |                                    | process-sockets-30 (seconds)    =
                         |                4.2405 |                   -0.1=
5% |
> |                                    | process-sockets-48 (seconds)    =
                         |     6.459666666666666 |                    0.1=
5% |
> |                                    | process-sockets-79 (seconds)    =
                         |    10.156833333333333 |                    1.4=
5% |
> |                                    | process-sockets-110 (seconds)   =
                         |    14.317833333333333 |                   -1.6=
4% |
> |                                    | process-sockets-141 (seconds)   =
                         |               20.8735 |               (I) -4.2=
7% |
> |                                    | process-sockets-172 (seconds)   =
                         |    26.205333333333332 |                    0.3=
0% |
> |                                    | process-sockets-203 (seconds)   =
                         |    31.298000000000002 |                   -1.7=
1% |
> |                                    | process-sockets-234 (seconds)   =
                         |    36.104000000000006 |                   -1.9=
4% |
> |                                    | process-sockets-256 (seconds)   =
                         |     39.44016666666667 |                   -0.7=
1% |
> |                                    | thread-pipes-1 (seconds)        =
                         |   0.17550000000000002 |                    0.6=
6% |
> |                                    | thread-pipes-4 (seconds)        =
                         |   0.44716666666666666 |                    1.6=
6% |
> |                                    | thread-pipes-7 (seconds)        =
                         |                0.7345 |                   -0.1=
7% |
> |                                    | thread-pipes-12 (seconds)       =
                         |     1.405833333333333 |               (I) -4.1=
2% |
> |                                    | thread-pipes-21 (seconds)       =
                         |    2.0113333333333334 |               (I) -2.1=
3% |
> |                                    | thread-pipes-30 (seconds)       =
                         |    2.6648333333333336 |               (I) -3.7=
8% |
> |                                    | thread-pipes-48 (seconds)       =
                         |    3.6341666666666668 |               (I) -5.7=
7% |
> |                                    | thread-pipes-79 (seconds)       =
                         |                4.4085 |               (I) -5.3=
1% |
> |                                    | thread-pipes-110 (seconds)      =
                         |     5.374666666666666 |               (I) -6.1=
2% |
> |                                    | thread-pipes-141 (seconds)      =
                         |     6.385666666666666 |               (I) -4.0=
0% |
> |                                    | thread-pipes-172 (seconds)      =
                         |     7.403000000000001 |               (I) -3.0=
1% |
> |                                    | thread-pipes-203 (seconds)      =
                         |     8.570333333333332 |               (I) -2.6=
2% |
> |                                    | thread-pipes-234 (seconds)      =
                         |     9.719166666666666 |               (I) -2.0=
0% |
> |                                    | thread-pipes-256 (seconds)      =
                         |    10.552833333333334 |               (I) -2.3=
0% |
> |                                    | thread-sockets-1 (seconds)      =
                         |                0.3065 |                (R) 2.3=
9% |
> +------------------------------------+---------------------------------=
-------------------------+-----------------------+-----------------------=
---+
>
> +------------------------------------+---------------------------------=
-------------------------+-----------------------+-----------------------=
---+
> | mmtests/sysbench-mutex             | sysbenchmutex-1 (usec)          =
                         |    194.38333333333333 |                   -0.0=
2% |
> |                                    | sysbenchmutex-4 (usec)          =
                         |               200.875 |                   -0.0=
2% |
> |                                    | sysbenchmutex-7 (usec)          =
                         |    201.23000000000002 |                    0.0=
0% |
> |                                    | sysbenchmutex-12 (usec)         =
                         |    201.77666666666664 |                    0.1=
2% |
> |                                    | sysbenchmutex-21 (usec)         =
                         |                203.03 |                   -0.4=
0% |
> |                                    | sysbenchmutex-30 (usec)         =
                         |               203.285 |                    0.0=
8% |
> |                                    | sysbenchmutex-48 (usec)         =
                         |    231.30000000000004 |                    2.5=
9% |
> |                                    | sysbenchmutex-79 (usec)         =
                         |               362.075 |                   -0.8=
0% |
> |                                    | sysbenchmutex-110 (usec)        =
                         |     516.8233333333334 |                   -3.8=
7% |
> |                                    | sysbenchmutex-128 (usec)        =
                         |     593.3533333333334 |               (I) -4.4=
6% |
> +------------------------------------+---------------------------------=
-------------------------+-----------------------+-----------------------=
---+
>
>  mm/khugepaged.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>

Acked-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi

