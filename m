Return-Path: <linux-kernel+bounces-851081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF885BD57CF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 19:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B35F401D59
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 17:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881B32C0F7F;
	Mon, 13 Oct 2025 17:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uYSB+nEz"
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010021.outbound.protection.outlook.com [52.101.85.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D3125A33F
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 17:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760375728; cv=fail; b=dc2KFHHZmCGOVWW6rFJD6NTvOvtvj4m669wJvLz3Cxlz8La2TN7KyuaQUoDwS3KesyWvlw7MWBZhBCR57L9OFD05kn7HDQy5hm5F3tILY/Aac7gLjKa0G0wmPWf3debr+BOlxshkFrIVXMXSEVjQ0/wh3mJmcK2BjYO6Z40dtgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760375728; c=relaxed/simple;
	bh=L+SMHYF7OVm9JAOWTWYGrbroFQ6Oy9IUFxIIGjP0ksM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SZK2fzNOAyyFqeUNn7ue3fyuQx9Y39RcAX0BQWovjQFle59nipUSxPUH8yXv2mcH64yh2i01SR9dZdw3Nfa5hRTjX1+6D19JttWNeqDo/iwOTcb1are2m0rzv3jygSbnJknEwy2OZj2YeJSslOBtRQkD7TgGUR3mEHq3o6FgD5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uYSB+nEz; arc=fail smtp.client-ip=52.101.85.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wWL6uuu1IglSPGVze//WaNMRJsAJhoeqLnGI6I8OOfel0nO+WHDcLiXXy1wNlNRrY9XdBrQlY0SWUKtT8EeTovX0S8OMU/uGbdObsqWIlr1YYcOAoZT1xHpcxrW6K441xuTTkiOeQorgTAqEpZecv4v7Wcryu5+/PYOYV1Z2+MxwhiRhfcfAvLH5MJVmVyIJWjPc2Pu6OCumFvO5LSnIET1r5HTzohf/WnPEB/rUmnr/fl05R1E6BMTfUrrOnm8k/5uRyTrH5IRxi3kAD4EzC7SzWtcaC2QD+xhAWwdo2JVf9CEutjOe3oOmmubl/yfG2dW2vjURC6vNV0j6xxgC6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j3JBMtlszUbxeUQ0kxc80ynHD3M85r/QMLxvbfhZxvo=;
 b=HQxw1cU8fepGJsKM8Slkt6+Ai40bbplHJIUlV0JjX/ZjOsR728WYturssjjnKIQFZBEWeOai3RJ5WC7hX0FOqeAdwB7gSUuYKOgnlnHTYhenxFSV7fMd5UO9P/e6Nem3+xxafWYD9I5PI3y8inCYFGMOuMz1IXVDUHGn6MC7uyB8kn8iVnoa3JGNnaT5bEK141AYJSO2oauqHJQOyivt9X1tRDxbJVYtfLMf3zyzHpgT911sUEdPovNH6mgQ8vteouneLLA86rsgfNJXISyH8IbpIWfKXZlEsT77iqpglDfQzpWZfgdEwzsztu+ry/lHQMkT/S1991gM/pqx/OpfQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j3JBMtlszUbxeUQ0kxc80ynHD3M85r/QMLxvbfhZxvo=;
 b=uYSB+nEzftFugLpQPWxyQgBCyVgikNc5rbP38RGvEYIMYLkhyJ8E0Qz8lnbHU3/4W1ik9nvaoCuDZFeZobJ9v6e2dP3xSqiPKT/mS4Wb7P/Ai43zQviumKIRy8O+rYVfNrzlzDrqhGfsJWafKfOjz4QQ2fO0hihw5vunfkPYAiGjBw/mLTNrraKaspiNyavsDzILj+l/aKvHBVuAYXlsCAH0AFieXPbBRUbvw77AA3czp0otKfQ3EovP3ucj0edgpKyoShDVkPszRPLu1h5FTsXJwr+Uf9AJXJH7sGq0ZZk0tAISurHwbRIQIwovG+pITDT1g1tZ95Bor0R6rGpqbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DS0PR12MB9037.namprd12.prod.outlook.com (2603:10b6:8:f1::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.13; Mon, 13 Oct 2025 17:15:23 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 17:15:23 +0000
From: Zi Yan <ziy@nvidia.com>
To: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc: akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com,
 linmiaohe@huawei.com, tony.luck@intel.com, baolin.wang@linux.alibaba.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, baohua@kernel.org, nao.horiguchi@gmail.com,
 farrah.chen@intel.com, jiaqiyan@google.com, lance.yang@linux.dev,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] mm: prevent poison consumption when splitting THP
Date: Mon, 13 Oct 2025 13:15:18 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <0ABAE11C-1DF4-4E76-AEE5-CE5E8ADFDC15@nvidia.com>
In-Reply-To: <20251011075520.320862-1-qiuxu.zhuo@intel.com>
References: <20250928032842.1399147-1-qiuxu.zhuo@intel.com>
 <20251011075520.320862-1-qiuxu.zhuo@intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BN8PR15CA0016.namprd15.prod.outlook.com
 (2603:10b6:408:c0::29) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DS0PR12MB9037:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f175468-41b7-4241-2797-08de0a7c1800
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MCKL1XwaKgxH3tTue8D0w2Wc+xH8fmlv+p5IvjTujOZSWdoKxuiF9KUWVcTM?=
 =?us-ascii?Q?nF4X4yYP3eXmIpnr7L21Mie1Q38wzYRvGr0t/Vo68C5grHSE2e2mAbK/84eB?=
 =?us-ascii?Q?4KpKo1nYwRwMI69ceTka9UUBDbrBuPFwOq1rvnYCtRyb7KmlsvqJhr0ItDWl?=
 =?us-ascii?Q?00f/RZVdITImimQ1y2asbT3RQf7Qg2a0yB/43t0/epsJzKDyTrRmA7K1Dqp2?=
 =?us-ascii?Q?BI0suymIiw/CROmZGZ1hYbH2Ld6t7ncP1YNd4iKnP+9kUa2jOA3/kUd3XHH2?=
 =?us-ascii?Q?QuLBSlkRtw3jhP0FxHtwL3uHDX5M6TY/vZWgPBlDson5w+38urevVtHCX2rF?=
 =?us-ascii?Q?fR015JSOiXMCWewu5cZBbLJtW+YlA6+eYUkWvIRE8Opln/Et4Zqwq5QCr8rT?=
 =?us-ascii?Q?V1++PklBcyYsloeFkqXjHTtimmNQAq8R4vMBIrx4VOh2P6gFUoN2/EyWe+dG?=
 =?us-ascii?Q?FsqhGO1c6v/JMHXxheDyZ+2WeQTuof4S/AxDfEyRarmkpFrdUXVtBqXBLj09?=
 =?us-ascii?Q?aLOrmCi9zrae2olVzC9HWRWasZjTkRHf0m7m5sxb/axiwHl/C98fHIrEi29U?=
 =?us-ascii?Q?5b1gPGgqJXjQ1vFayTrFWogGtuMKzudzdLBxU9q/5R2D426pF0mrvUiuujeD?=
 =?us-ascii?Q?h8r6xuxgmAOFDw7c3kEPvW7A6/v/vAknRBJY5dp3Wopi1PnuVE4cOm08qRaQ?=
 =?us-ascii?Q?LgkkpVl3roPAR34eSqe4WW33GNhuqowByv2TIpkxQSD72RGTzWjc2aOZwgKA?=
 =?us-ascii?Q?6922NJpu9Of0A2//5UtAFEZolcF4mtGXT/R7F9b4kBSlLhiL3kqN52wNkAmq?=
 =?us-ascii?Q?luY//1JzCbDoDBZmD/2udTlglrJfhisCMfKK5aP1w5cCtLIokKtSazRKoGW1?=
 =?us-ascii?Q?Kupzq1Np4+kbCibp1gIAf4ZHYeaJ82dA7j8c/PoZVfES2C9Ga0uKThTlLgDm?=
 =?us-ascii?Q?KsaHi34bjpw+QDBx/PQZ5U4wKHEp0eh7+7NhkrVmdH/Rm4d7uqfERcejV+8w?=
 =?us-ascii?Q?PXH3+98lWiXuC6xSTHnZUBZlmnwd1k5RoQxcTxfN/6T9U9+sXgiAGw9nhLd8?=
 =?us-ascii?Q?zHIhEi8wGDOdatwRUgUphnV3+mebfqhDGKw4fDlLD83IzAYyQaW21Ub8lZms?=
 =?us-ascii?Q?3s285FrF9BsEzEQIcuf7gc/vORsEgxPBoRCUXVvQ18ccppOkI5NQgt1tNVHo?=
 =?us-ascii?Q?bBGOVXjeDC3lsxMCFEwTWCIoc5N9UiWY03H/Zcim7EAlIUz5ke3qaDAp1fVR?=
 =?us-ascii?Q?es21I5rZoBTAB8qBt+FcY1OM9MV7WzuxrCTk3Dl0gMvZWfp0y8LzhtuZxBzk?=
 =?us-ascii?Q?ptXfn/iqpgrSU2xwUMi/MhubpQcNuZsn6hAbLE2ZjOychHQH4QN+qu+j5vdv?=
 =?us-ascii?Q?B9Mam2YFUNO56SsAxvkOQrTqP3mjv1eGVq6/SQNc56lf4a7kTiaCNPape6Ow?=
 =?us-ascii?Q?gJaZWxR7vEggLg27iGkRGUcPiBvpLA2e?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EeaksIezRB9yWwURrDguih2wFZlWU49Rl+Rl+bDlGRiIqFyW8ag6rql5YA5e?=
 =?us-ascii?Q?8SzL0c8RdRAWJ3Pr1o9M9KMY/O6AIGjSWl9cSjjuHuLXZizoJbyawoPXFwRD?=
 =?us-ascii?Q?Nbs5sCd5ylg/+gwipsGlosPKMZk4eyD3QJrGLl+a81sqczVu9EZWlputriZz?=
 =?us-ascii?Q?0/KOXed84mxWxQJoeZsBD9TQu6j/+KWa4sIRgWN/sd1gixpcM2RDQU8thz+Z?=
 =?us-ascii?Q?1t0PcS1bknufiZqMr54dTvG8zq/S7Hj5isvUzbVKP/Fhop9kJXXWzRH7mSPL?=
 =?us-ascii?Q?oDRfyGjVSjAanR3QTk/GWf69s0dA51z7fiVpVNqt/21iqjhHYn45deoROMRb?=
 =?us-ascii?Q?nCAv3L+nUaa9s/pDgkSK7ngFML6IMrrmf5Cxgx+iVzt9rsUI06DWDa43WQ/i?=
 =?us-ascii?Q?BvNc7olCUYLO+1VHnlASvQOdDzj6Q2MaGtewt/xhv7YbgaHQCpWOmGCb1GPM?=
 =?us-ascii?Q?yZ6K79rCOx3xp828NHX0R6oQ+Tmsc2zkjIiSgpBblI9T35subTw3D3RiZnN1?=
 =?us-ascii?Q?2KPf2EMcekFPm92UrW+9R9IIbwstLidXCt4mfcEx63Zukj/YZajIr1Dcyusl?=
 =?us-ascii?Q?6sa01vkP2zIsJIPDhGeNuHruQo2vOmMRPxlyMcxvW5GnelZ0uoFHzEmcciYI?=
 =?us-ascii?Q?F37UqWoSTL3s86vu2D8+yWHbK+l2A6PWuyK25r1ZzSUivWue5N1ajDYkXqcS?=
 =?us-ascii?Q?P8D27Vn7hmTVSVE+kfbHPF1z9s0gMkQa5H95uI7Eg2n/HI9JslcYZx5kV+gC?=
 =?us-ascii?Q?lKE26elDqEHSTpQ0x33N84CRx0LrR83kHpi18uMNpXbngVdHXqBaPHDEhf+I?=
 =?us-ascii?Q?xRLRXv+GrtcFY3yK7ARgqUe+PoBXz/xQj9QSV+sT6VNUSgheuOIf0L38j0iY?=
 =?us-ascii?Q?wdw4/5K8VHhzRov/lathD5WrT2fWW+hqPDvpTvHpPGwTuVDGJQNTTPYhpLrk?=
 =?us-ascii?Q?XRF3p+3K/auGTSkVUaoTuH14JE6Vj89Q2mMoJFNE7G06xA9d8Wd5quy0igqf?=
 =?us-ascii?Q?hm/K9RgicAO9yTKVg65+akl/qg940mB39YkBxw+XHv9ONIJGfWd/WilGmv6U?=
 =?us-ascii?Q?AMV+uf9PSnlGCkOfPiNAJr7zk9qu6dtN9CuGmFLe6SS064Nqi1Ivbdj1Cndi?=
 =?us-ascii?Q?zZa1qPDiP5tg98t+eBwWBxoWZOGjGkr1cbgVM9bBgavS/NukjdNGCQvRn/jm?=
 =?us-ascii?Q?Vw0QFihMwYOdbYXcDmcWCoC/uhqtM41WJZd3J0IMXThgEuleP58AhISvLFr2?=
 =?us-ascii?Q?dQEg0Nn79ftjaPcAyKBSy342BcsRJUoyVBzsPl/IloIjEzyYHvk38NekuUF1?=
 =?us-ascii?Q?ZYOI4BgL06G4IL+9wbicgO8CLOhYfeeZ/4zYSsb/lvMHP3nP9Wj/rRbc4TjP?=
 =?us-ascii?Q?Q7S6/e4IPa48RV603lFoqK/xlqyuEb0qcACRJXqBO/q5z4GS1MaQNVByqeuF?=
 =?us-ascii?Q?A1IHzBCIeLyQbbXkFStJZ9lsMLRkT0phMQQcE+5B3eyg6w+xsqjlozTHapMf?=
 =?us-ascii?Q?6H8V+hXhU2L5CDDyuxDvFFhtue7RT9tXSBKflYsCgViXHAOy+lA4rTimXoSw?=
 =?us-ascii?Q?2Q1DPupdKrLFcJNmqMGkyms3kmb8bj3TNTvSUC5h?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f175468-41b7-4241-2797-08de0a7c1800
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 17:15:22.9711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qsFRdzyrS4w3OZe6KlHRMDhd6Zge+mL15CbGFgbSgBb7L1YMv57HcT0A8XBhR3xN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9037

On 11 Oct 2025, at 3:55, Qiuxu Zhuo wrote:

> When performing memory error injection on a THP (Transparent Huge Page)=

> mapped to userspace on an x86 server, the kernel panics with the follow=
ing
> trace. The expected behavior is to terminate the affected process inste=
ad
> of panicking the kernel, as the x86 Machine Check code can recover from=
 an
> in-userspace #MC.
>
>   mce: [Hardware Error]: CPU 0: Machine Check Exception: f Bank 3: bd80=
000000070134
>   mce: [Hardware Error]: RIP 10:<ffffffff8372f8bc> {memchr_inv+0x4c/0xf=
0}
>   mce: [Hardware Error]: TSC afff7bbff88a ADDR 1d301b000 MISC 80 PPIN 1=
e741e77539027db
>   mce: [Hardware Error]: PROCESSOR 0:d06d0 TIME 1758093249 SOCKET 0 API=
C 0 microcode 80000320
>   mce: [Hardware Error]: Run the above through 'mcelog --ascii'
>   mce: [Hardware Error]: Machine check: Data load in unrecoverable area=
 of kernel
>   Kernel panic - not syncing: Fatal local machine check
>
> The root cause of this panic is that handling a memory failure triggere=
d by
> an in-userspace #MC necessitates splitting the THP. The splitting proce=
ss
> employs a mechanism, implemented in try_to_map_unused_to_zeropage(), wh=
ich
> reads the sub-pages of the THP to identify zero-filled pages. However,
> reading the sub-pages results in a second in-kernel #MC, occurring befo=
re
> the initial memory_failure() completes, ultimately leading to a kernel
> panic. See the kernel panic call trace on the two #MCs.
>
>   First Machine Check occurs // [1]
>     memory_failure()         // [2]
>       try_to_split_thp_page()
>         split_huge_page()
>           split_huge_page_to_list_to_order()
>             __folio_split()  // [3]
>               remap_page()
>                 remove_migration_ptes()
>                   remove_migration_pte()
>                     try_to_map_unused_to_zeropage()  // [4]
>                       memchr_inv()                   // [5]
>                         Second Machine Check occurs  // [6]
>                           Kernel panic
>
> [1] Triggered by accessing a hardware-poisoned THP in userspace, which =
is
>     typically recoverable by terminating the affected process.
>
> [2] Call folio_set_has_hwpoisoned() before try_to_split_thp_page().
>
> [3] Pass the RMP_USE_SHARED_ZEROPAGE remap flag to remap_page().
>
> [4] Try to map the unused THP to zeropage.
>
> [5] Re-access sub-pages of the hw-poisoned THP in the kernel.
>
> [6] Triggered in-kernel, leading to a panic kernel.
>
> In Step[2], memory_failure() sets the poisoned flag on the sub-page of =
the
> THP by TestSetPageHWPoison() before calling try_to_split_thp_page().
>
> As suggested by David Hildenbrand, fix this panic by not accessing to t=
he
> poisoned sub-page of the THP during zeropage identification, while
> continuing to scan unaffected sub-pages of the THP for possible zeropag=
e
> mapping. This prevents a second in-kernel #MC that would cause kernel
> panic in Step[4].
>
> [ Credits to Andrew Zaborowski <andrew.zaborowski@intel.com> for his
>   original fix that prevents passing the RMP_USE_SHARED_ZEROPAGE flag
>   to remap_page() in Step[3] if the THP has the has_hwpoisoned flag set=
,
>   avoiding access to the entire THP for zero-page identification. ]
>
> Reported-by: Farrah Chen <farrah.chen@intel.com>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Tested-by: Farrah Chen <farrah.chen@intel.com>
> Tested-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> ---
> v1 -> v2:
>   - Apply David Hildenbrand's fix suggestion.
>
>   - Update the commit message to reflect the new fix.
>
>   - Add David Hildenbrand's "Suggested-by:" tag.
>
>   - Remove Andrew Zaborowski's SoB but add credits to him in the commit=
 message.
>     [ I cannot reach him to get his SoB for the completely rewritten co=
mmit
>       message and new fix approach. ]
>
>  mm/huge_memory.c | 3 +++
>  mm/migrate.c     | 3 ++-
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
LGTM. Acked-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

