Return-Path: <linux-kernel+bounces-827279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E9586B91586
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AE1764E236F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 13:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41ACC30ACF7;
	Mon, 22 Sep 2025 13:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N0h64Fls"
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011049.outbound.protection.outlook.com [40.93.194.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD0130C364
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 13:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758546850; cv=fail; b=pVUF3eGG/3xJ4Gdn2cvdChwGIHSxyhg9Gtgl6B85lozt1Kte4EBbdn49chfd9FFqEXG8p3k/5xfxdUibgkvQ57rM4/NGnag9I/mQwK1gNdpNNs883mta9BIpuB3rtUfYVbsmgMTN6/4VKzBZBPWqsGH5+y6jPlRtgq0k1MDHCu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758546850; c=relaxed/simple;
	bh=a+hKPWEcpeUCFaVHThBTyuZSg4uxvttS7uhaGFDX9l0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Pxo+v+IMzD0zqmM0ryIjk1n6Bj+oomv5ckS66xcpFrqyQNebvBOxVD5kSwiL0bbeDnOMZ0fDOUTVWgIz4q0Uq2yNwQm1+/lYKZRd6u1zyXzDMN3MCPLc6Erm/tEO3sJKTk9u7YiyU3qKCuV7dg79PWsR868SpfUb94uOHFg2J5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N0h64Fls; arc=fail smtp.client-ip=40.93.194.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R8A5PY5+BnqpMjXX+bqJVaT78qQqdU26Rs7R/8TB2oR4IdrEh7TO1hVURPSAGrwci/Nfl4k6VLrDLCPv7luzB2hECxi63rH1ZgF2CwpOxVzdArAaTJvF3V9KV4GDWEANtA1FITkJSRxbrJKnOLmvY77gBw1AVyyTdJlST1xz/a1+681/rSd72sUE1V9lweS8Iwt+EsjgA4BWbLcKasXLrGv/ihMNiNtkWQbS+98Z18Z+WrSmr75XYWGfeI3sqK/d7wBCFpexJAX2stAm9AE1UWkujsRL/O27RFkhh2SY9xvYhb8obFZuAlPne2p/ie5E8kiV3yScVtgJ5Mcbe5YNZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VBsiI8bPXZ+ecqCC8s5yZP07lfqQS5GoGWq5a6P3tuk=;
 b=kE+4/7TOg3rZI9Y7i7GzEtTmePt/Y0pzPkZkGh6AT1D320sTwAEQlph8GfCnSk6EZid3OFuUCUWU47h2Uso9ofvr2kuXwIlPB9e68tVaoFiBUrOBW37Org3rNsw1LXfUP9F9dj1Ua4SSrNYNG1uGIEonfty4nvPeFoKRFtJ6pntLbIH0Hx8nPFyTEkBKXxalpozZTzxmsOSurUxTSAv6NG0mCmTp9aAgGpJEOe63qG0Yar9xPWkHW8uLtYenH43y7lQbcJ96vPdVMm0BmwRnUq3E5c9Tq68cAglmiA8Fpr0kjBpKVIhWmSnuL29+bI/85vtnVuPLA0H/RHe0vWHbRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VBsiI8bPXZ+ecqCC8s5yZP07lfqQS5GoGWq5a6P3tuk=;
 b=N0h64Flsc2VFYCrS33WuGZ8FHRLBuI0uKKvg6DUvFoiFQxtAHKO0OKHrr3MSQE9KYB9oBPGrOZyKDFlu0e3b29wKtBsQXAyUes4v6M3gIKqAPCDvcKUz1mCZuqSNPEpawT9cFXZeMdpDJdiXuC3l/j4FNGJQN1x1xZiLprJ1Kale+zaWC7cku6yp0CH5uznxNXsIHpjtxR2erpLnz7qtYNrH+NR8hA8VGrcaohMbQ1vImO2eL0qSakXtpxMPJK9xRApujnUA/crrvfLewaezK3YNDzb1o0a1jEVJ1xtGxSzAUzgSeGgVgV0OYDRjNplhMFlpBDVLI8I87q1QlN15NA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by SA1PR12MB7198.namprd12.prod.outlook.com (2603:10b6:806:2bf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 13:14:05 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9137.018; Mon, 22 Sep 2025
 13:14:05 +0000
Date: Mon, 22 Sep 2025 10:14:02 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Graf <graf@amazon.com>, Baoquan He <bhe@redhat.com>,
	Changyuan Lyu <changyuanl@google.com>, Chris Li <chrisl@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/4] kho: replace kho_preserve_phys() with
 kho_preserve_pages()
Message-ID: <20250922131402.GW1391379@nvidia.com>
References: <20250921054458.4043761-1-rppt@kernel.org>
 <20250921054458.4043761-3-rppt@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250921054458.4043761-3-rppt@kernel.org>
X-ClientProxiedBy: BN9PR03CA0065.namprd03.prod.outlook.com
 (2603:10b6:408:fc::10) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|SA1PR12MB7198:EE_
X-MS-Office365-Filtering-Correlation-Id: 24a9687d-fad2-47a0-2c35-08ddf9d9e7c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dvPDz2dPY+/g87MAwkXaZjaRwiPCmZSFKVuTbXcO8u2bd1ieq+fENn5CdMqb?=
 =?us-ascii?Q?dH0Oi7vA5ianti0yzrV1udamYqWnPtqjX6R2VjE3uVqyV6OeNopwhR6/8Xg5?=
 =?us-ascii?Q?FAiPCyyWj2KJjrofepxJi15coyo9CqrBmZNxUwzU+cK2jie/js1w2Wk5UL47?=
 =?us-ascii?Q?q2dfB3IXjKCknT4ZYFiNeFUtd33NVhu5JSKoqKiiKAT3e4glRND4qQ7WJaYZ?=
 =?us-ascii?Q?gQJhcK7ex0mbUSvXtkS/c3Yprnid1Yl0d8pMT2qGuF5ZcszKf647E9D/2JJt?=
 =?us-ascii?Q?WK2PPrOA5621aukjv+LeeO8B2KAs8YYznArTgSatGK5CO4AsvkLKPcXFhROq?=
 =?us-ascii?Q?E+4f52GCS3jUzY+SvwYnx3emeGi1WYH6bS6LgLR0S2pbVZGgO2yEvLbhxO51?=
 =?us-ascii?Q?1sNKGAF4F8rMdcjwOv5Gp7uoQEU7ofHMlCrK028FDzQYdcziQ+hu6CaTXrmy?=
 =?us-ascii?Q?rPIkF54T2KseMgSKhsqzeomLZ28srrCIghG1sGgbcxpSsZ2axBm8F4j/WAhc?=
 =?us-ascii?Q?tWixfVNiFvdXg1BtBDJu2bjYlBRbt0me4TbJ4G62soE6A/rpLQWA0n4XRoV5?=
 =?us-ascii?Q?7/jygNTD3drlZ+7K//jGMn56K3vzfEQZrbJ7d41e60V2XrmvrRGPBiui9NL2?=
 =?us-ascii?Q?PVYBlw7nPHuS+iX+lrf1e0kMos1uML8cheRt43QRCH1Dh32KemV1ZNm40IJT?=
 =?us-ascii?Q?oiBirWmO/LqOsBZODjj7LR13FcSXzYSYKuQbnmCu3rduAwHkKeLx7EFLagkf?=
 =?us-ascii?Q?W5V8I+sB8f2kqEbZZLYwOTrRavNpJxgEQC3RP/d8wmiG2vk2vzoLRAJIHHUq?=
 =?us-ascii?Q?hagqTQy9n/0O+eFIkM//yjJpHsU/3+NUmankXVfaXZH63DPE0bPt47rDQ7Op?=
 =?us-ascii?Q?yRDQhwGi1ffjBZqit7K2z6C82sMcLIw+8nxr5FjLzTkB1wLmd6UR0XAAj98h?=
 =?us-ascii?Q?MJfZkLhwb3msw2z1xSk/ti89GM06Y275C8ziWIcToPA00Jk2/HpXAmx5f/ze?=
 =?us-ascii?Q?WNQ/CwUds1jnTAwEmxZ05DONKyLSlRV4BcwEISx27LW4XK0eMUm4OfpqpWn4?=
 =?us-ascii?Q?bi73XUPBCumNI6V1kNBqp5dBxm3HzNXVtgM3EwjX9bQoejhY85nBLzUaGm8q?=
 =?us-ascii?Q?Je6/0l0yy7Yt+sz/DxbayqKhqUk7TJxE9lbic1H+SWXpQC4MCxg0NE8oE4LQ?=
 =?us-ascii?Q?yUFSZqlmxEbGkbT5G35jF8rMGmj/qaetYOHf6OjTPcxyhIo/3dGiXbKJ6VKd?=
 =?us-ascii?Q?dm+ypyGULITFA9joVGk4MxnvxV6gcjJ+Jomqi1anbf7/Gs612FEQOCWgwohK?=
 =?us-ascii?Q?X7zwOjoBPMjB3T1Z3GM7++kIcYqnKTxHNzpw/DhVL5NZs87IsSaw02N1Mvv/?=
 =?us-ascii?Q?/Ng7hYgUpPC4JpIz6UAybhJqMpDphBD3uHLJnJR1AYzWVOhIKpdLeHWfYB+B?=
 =?us-ascii?Q?xuWSdFghnjA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8Z1b4aPONTjX6Or8lYQXjJCECuGWS+5SeOqvs5CC/cJjeIqUoB5y9PXQjuJh?=
 =?us-ascii?Q?XA0eGRzu/lMbUzJDw638JaxPwLXWdlF2OvJImH6Dh5Rz+qt3FiAAZe03ZuLx?=
 =?us-ascii?Q?8ImVirP6tUa2BtvUIK7t+46BaBlsdjslkGgI0vJR3H1HIa6mbRaevslTC1K7?=
 =?us-ascii?Q?KuZdDCG/lVUlC5WkgnoO3ZyM+K/MXyRLGFZFk2CHSx3Z2ZoIbQpOmBNZRRJH?=
 =?us-ascii?Q?37O+W2vMf1zhmzJk8LO8UjJdYyNB6R8+kQ+OIIjqVmLW9yWnvSo/BmSdO8Jd?=
 =?us-ascii?Q?ka5MikiZL2xipt7+druBA52Nk9pwQObQQGV0ZfEJowsSRuudkGgm9lvLFEkl?=
 =?us-ascii?Q?a0gYS+AOiSCKADpQPGLlKS+EiVpoi2HpVWeXZ4uutl+kmHPAFan2YapCMxoL?=
 =?us-ascii?Q?KOXRlFdZHJT2f9JVikCq0oXgFF1+esb6z20AmN3ab0Xg97uDQ001hGOIZqny?=
 =?us-ascii?Q?cosVVlKhUdZhwypZCl5Bz7cfEQ3FqZ5t/p8ZQP1nNUeyD67FCGdN721jxftv?=
 =?us-ascii?Q?BZJzX+0oxyXtL3jpE4k7HyNcZBaukAAiTcH8qbg0sJah0CFSClTBUQdU/KL6?=
 =?us-ascii?Q?9NHHOMAcQi7nj814OXgAJ1DpXn8PTYkpA0C1LkvpRDaWfqMwbyA0QDls+lVF?=
 =?us-ascii?Q?jbrebPSXJEwswcqY9/nE0k3kGX/jTuHRKm5vwcJOSEV9IPCYXxMNE9M5T2Ah?=
 =?us-ascii?Q?1dqXamrcRP0auvbSpMh6a31CLkHgR6i0vbmKDCwrdB/z8wzCxN5qEs8gQFIG?=
 =?us-ascii?Q?YH+/F0LShQ5e+NvpIOJci+UfeZLWEi3iVd5JtWaKz/StHNlbd2Uf04MzpmkC?=
 =?us-ascii?Q?Pjju4defxlURlmeDnS5PfwVT6vWP1cLYPCUuiiRnWgeI0gtVpGPIhnGUbtAB?=
 =?us-ascii?Q?o9kSYsN0FoFhrIOylSHMOJk4W5eQoEvbFgh0ApWD+wCAy6a8yqSD9lJnyrT1?=
 =?us-ascii?Q?TfQX56Qel6lktjln2KhawEVNzyjWNwJTJZEVgdf6hOvDNOPItjtfsMMokqju?=
 =?us-ascii?Q?fMQ6zKR6afWlDQDRVZd8vbvt/7A0/cnTJRrtaBZVTwpISqbYTIyQk0RiInYK?=
 =?us-ascii?Q?QV8ZE69w8CxlHsWyiAQ7VdbBO60YNPdVGwKIvU9R53dsu52koa36zmCJnV+i?=
 =?us-ascii?Q?GLbupDE3Ulx0GFBojSDL/yikOEUTLliFWVjp4Y5Q+epi3ZtId2hRHQB6x0F0?=
 =?us-ascii?Q?AM+h+SDxqz1x9/8+hO9cLva5GNc/HpO3cBKOf9HRdSl/wx5SyA/ui+VA4rHh?=
 =?us-ascii?Q?7un30sDl6s41rGBeagE0oMiEQTL10FLB4T1qbLgIrh69TyALy23xVeN/Vst6?=
 =?us-ascii?Q?RJzrOezawKyrb7Wu8qnDzv+ZOuEyFL9AYHCT78hu95pThpVxnx0Ietr2GAZk?=
 =?us-ascii?Q?CYX4u8JZEfAXtSHZW6pG1V/td1CksejnOUOgkJC8UUnEzMfn7guSOnQwHiCm?=
 =?us-ascii?Q?Ovq63Xlw4+IeyGvmJFqmEvcziZZgDN7f+ziBXQXWI+nuAZ98v1a5eEkbRJzD?=
 =?us-ascii?Q?7jjejM5+GhApDQzwEWEReTap2COH7jXDh7XHrnzeKgVi980e/kVoZjE+tVrI?=
 =?us-ascii?Q?/v02dolRNayMgvPMorit5YRcwkfblzHsilIB8CVg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24a9687d-fad2-47a0-2c35-08ddf9d9e7c4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 13:14:04.9718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e2IkIT6b0i8+R+y2PmZ2Vnzo8+NeHFMVf3/l63UoIqRwIam6lJpY7ymPUUnWmMey
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7198

On Sun, Sep 21, 2025 at 08:44:56AM +0300, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> to make it clear that KHO operates on pages rather than on a random
> physical address.
> 
> The kho_preserve_pages() will be also used in upcoming support for
> vmalloc preservation.
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  include/linux/kexec_handover.h |  5 +++--
>  kernel/kexec_handover.c        | 25 +++++++++++--------------
>  mm/memblock.c                  |  4 +++-
>  3 files changed, 17 insertions(+), 17 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

