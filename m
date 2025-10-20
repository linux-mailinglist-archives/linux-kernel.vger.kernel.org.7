Return-Path: <linux-kernel+bounces-861673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAA0BF3507
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 22:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F9933B6EDA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 20:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B852DA742;
	Mon, 20 Oct 2025 20:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Zu3bO17v"
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010065.outbound.protection.outlook.com [40.93.198.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BA42BDC14
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 20:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760990487; cv=fail; b=M6L9Ix/j58jCStSDJLh6W4JL8kfNy22uu3i5I2ZJiIHkvKtWpPacE2drsV2VJiJ+iVgTCFZZ5CiMxXTCJjA+Y75WwuVRBE8WYqKzTYfKiskNpmNcRNzILwUCTkC2VWVYdb+nYZM3gtjMOtlLeocRjLr0dUWBrxhW6whEjAoIOBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760990487; c=relaxed/simple;
	bh=7F3PKfCaCEwTwupHS7K9GSbSPwbUL/T1FP59KpctYL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=trD3ul5pTjrBQqYExi0jpr+8U7C91Kb00Ca+g/36nUL7xeu8eoVpQ8snajULwSJ+4ld6U0VnqgcbEIT036Fdn877pPNrGTuK7lVZVuO1O1rNRMVIxTluDsLhQP0NWB4ZvHdZSGxBM3dkYiq0LFsqfIVEztgVCMlAimZwisz+1Ls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Zu3bO17v; arc=fail smtp.client-ip=40.93.198.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d7hCfimFAkbjvIGyI9/y6sudtotSmKWxusF04VClt4zyg3kfk+DiMVATIrWvSgoher37RwpKlYAF8Uqyy2TrJXXanNmAmj1Is1X5Zg0mcbtnckiINmXFQFGu3fexDPLgNViRqQflEYAXzQg5c+rcaY92oqxJAD5wA/t9vkqJ4AW0PBqRY6gdNLxy/Z9X2/qEuXfvufCsMT9fo9Ro3hNCzmFSA6t3m8mWzDPPPG6lZv2UEPmoNpRUzZwemDk7h96NghIkJupvBijpmLOillpZG87CjsECz4NvCQh9g+nQoaPLdkVlvrC88QuxIrvVzhqxwy0f/klaDmiA8DWAuB8iLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B32BgOM9SR3tLlD5QC8TVECs4zeRvk9nxrUVy4O/zIo=;
 b=S2Bj8PL/qbxQeHaIexLCyv+x1v6ONfHbdfIWf2VWoutcs3SCKkyXSBjtNDichYeu8LOdb5K+YHQkU/MhYZTSXFU955ymkyL0+dANQAQ46+MBdbyG0jt7rBpPQ7yt+dnTxBT1EjsXVz1N79ipbxR3eDrqnk6dwD6u26m/bv4GFmW0V+DXK0QT7xpzhSuPubiHfPHrGjd/Q8gBDDYu/a+WsmO93dOtgLre5VnAXKPDS5ngWBATI9HUexOZrHehqDxBJX2mCDt21iyTfEycE257yIuZRPHtNwrtFuQw9F12WZ8uCfRCk2s7ya8RQvImpVgccHjTcFAVV8nmWErnSehVUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B32BgOM9SR3tLlD5QC8TVECs4zeRvk9nxrUVy4O/zIo=;
 b=Zu3bO17vOgosTRtfNfcOYtarMO1cuixHd5ll2WiLqLuR1ErqH1LtLCWwblAZlUCRAMFGT/aAyo4Fmt9kbhgbwuvWNUzELXWUo7qXQPK5y5Pz2SAqT1bxRmbInPqpLLrqOHKvye+aHPlXoiw/GDCfTpGLpDE0O/0fVIws0aktmlPmwVpKxpJK25LvmQ2L5KvhczEap+BJ1Ju7kVjtGtzRWVPAw2XSZwG3rCmsaRMuKtMOBNwZt5dY/0tnFuxhyHUYJ/XfIlLH5cFBBDIoSUkVRzRYXPFDZsBWhORHpeNcyFhsdB/qEsEbne5SX20Rs6ZqGXLHFdCfcpWpNyiUHjmh4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 LV2PR12MB5824.namprd12.prod.outlook.com (2603:10b6:408:176::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 20:01:20 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 20:01:20 +0000
From: Zi Yan <ziy@nvidia.com>
To: Leon Hwang <leon.hwang@linux.dev>
Cc: akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 lance.yang@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH mm-new 1/1] mm/khugepaged: Factor out common logic in
 [scan,alloc]_sleep_millisecs_store()
Date: Mon, 20 Oct 2025 16:01:19 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <99B909C2-F0A9-4D29-9F59-B48F8120F82A@nvidia.com>
In-Reply-To: <20251020115350.8175-1-leon.hwang@linux.dev>
References: <20251020115350.8175-1-leon.hwang@linux.dev>
Content-Type: text/plain
X-ClientProxiedBy: MN2PR05CA0042.namprd05.prod.outlook.com
 (2603:10b6:208:236::11) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|LV2PR12MB5824:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bf29e80-0556-44e1-af39-08de10137044
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fdMqw7anF713MMEEPxA/ENjDXSIRZ1qdUN2i3pLPYME9ubb4NT0jdcHWCkbc?=
 =?us-ascii?Q?PYIFMCGJ36T2i7u70Ybs197L5+zumR6fAuqQUJHEbaM9biam5gQUfcjYci6y?=
 =?us-ascii?Q?ocwXVEOkEMvBgOI9EdkDG1LvPYZef1CdcWLTMO+tRsBdKFqWblbTMOoW/YAK?=
 =?us-ascii?Q?CI6lhXUIMcCmQ+LpSaZEhJgF/C5nIFWM/+p/H+5jGQ3qSBTJCRSNTw47Jmpk?=
 =?us-ascii?Q?/qgdXLYa4MMXlEkd7MIcvI5372D0DI9U9Ugtewh2IpJP2a7Ybvq4ZsvN2WMq?=
 =?us-ascii?Q?iUfjH7FuVceooPp4iU3dqLceaEVFLFqSjZqgqMxJa5eN1UKcNyfX9gx9jLJm?=
 =?us-ascii?Q?7uSyEHBQfGelEHUmZoSmzUeLRvix8ftP7SzrNUgss6fsIyDj5aTQCuAQ7X5h?=
 =?us-ascii?Q?86HRwEQiWEL6fESte7HTH9w/Srt+nesVh6i1Ax8gsfX9nA2OA5Xxe4boNkEf?=
 =?us-ascii?Q?HRGT86i5WTi0BNsnJ7GyTfqN1/5P1lV38/2JZaqYm+teTAic2j3/EhoLsG1/?=
 =?us-ascii?Q?6o/XEfXKJdrRLMq4a40d7G6r4wgNUQaXWNyWKjqPxDMkDHYxlsRq6QG0QXtS?=
 =?us-ascii?Q?BqvWXAE8IRGDkqUqPm/d6Y0UvI5jnOSnUxhd2zS4Qy2EFB0bDwPQ+YTqithu?=
 =?us-ascii?Q?7EYiHUFnhR3zkFob7M6bBW5jblg6HkJBcAfiHSX0HkDrhCyZMK+MiCGXdZsS?=
 =?us-ascii?Q?tt3Wux/x83XShT6xmldsDJ7tJEgpTZmSTYIQ+D03vCvo+39U4DW1CwLtG8VN?=
 =?us-ascii?Q?nbdlCEijy3f9HkPnprAsMuGcrGtquvDlq/CCqnfVLWTXtvTN1OV1XGi1kqVD?=
 =?us-ascii?Q?gFD3s52U3WgZ3HLQhe2yNKMBvcQzov4NuflpT5rgIaJilV2Ta3rXMTgy8dW7?=
 =?us-ascii?Q?2MbKy4LTHFdLUsHoledhNeITQIXAjIWfYf4EEnN6aOpEUp6k4ivszQsIbV2s?=
 =?us-ascii?Q?HjkrhwuKGtE5opeFvJTeLSwlWCcDfdnBETu3yTIR1l6EfTMKh2A4BYUf51uk?=
 =?us-ascii?Q?Feoty7H641bQpv5OSQTFvs8m/JovpFjlxrmatk/Eo6Tq0tm164QbYZG2K8ub?=
 =?us-ascii?Q?0s13mjh+9ayCSypLWrYJGe7yoPoxV2SGdPkTj5YZ7foXCcI1h9tsoMYUZ6BR?=
 =?us-ascii?Q?UZRpQEhnFDZP7tZjcf8Fr50FpbI3G1B+j7gKII1QQASzftCZIL7EAc28gtX5?=
 =?us-ascii?Q?P9dNup41A0AGF3Lw1R0OaN6A8ejFrAxWIRQrKcijm3W0k4WsMrm3x0jNtnXZ?=
 =?us-ascii?Q?bjrZl61acjOArdsM0q0EtXdIwOQp5fsJap29gikW5xuU8BHH+G33hMLwYDpX?=
 =?us-ascii?Q?EkroitzMyNjVk64FCgEsDwRs0d0xuG7Wj59KaMAsKVQluN6wHsH2j1I741aO?=
 =?us-ascii?Q?CU1+fGz7AHrX97D51mXT/sP6edpns+admUoFm8zAo2Gt5Xb+Nzp9mxlM0IV4?=
 =?us-ascii?Q?qQONAHaAeVbXfTQpRHzEMq+Wm9SAGmyi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Wlt/LKmuQn0qoPcjt1s1z+murN5XA+nH7QcVdkjfSX9uw272yucjK1E78l//?=
 =?us-ascii?Q?zUUCK6a2gWpl/+OJHPJSjcsCQEWcNB98sef2H8qnc7uEDuWZMCUXnseYkDAo?=
 =?us-ascii?Q?O4PmsvnocwDmiKbcz02RBEZgpkr7XD1TBlswUZwP2HEAFTpExovGzT+wvQ+V?=
 =?us-ascii?Q?itonBR1wjm6oaRlW52JgnPC6waU3yI1SB9ZAR4QtTLBuk2i+tAN1E+is5zmi?=
 =?us-ascii?Q?GQ8WGT4liWW4pKlV+R72Oof0y5GkaebeHTEX8co/FmvIASaIrWCu7zO45ccB?=
 =?us-ascii?Q?QGeS2p3ae6px835IrNBPxWmqz8JhZRkeJTA+6ywmZ8mMEsJ9wKglPW891MsR?=
 =?us-ascii?Q?fyCm+yOdhW0DcmjkPGWxg9pibQWRRWR1jdS1SFN4Z+xkYnCgRWMFe1Tu8rT4?=
 =?us-ascii?Q?s1tZlht9LmzKJ59qIbmYLeCEdMa4QlsTRKUmr0Hha4ajMjqq9Cb4FGYhwmbh?=
 =?us-ascii?Q?v5ZzJj7Vbs28ZrBM9lkYkofMWynCK74tGvhTLWZE9axXXhdZ7qMVq2O2yee1?=
 =?us-ascii?Q?nwyCDTSxu3nFgXOeNyxFEbxS8GzUshs8U7Ypgc+emnDj8ddZbKs8j7ACKCaZ?=
 =?us-ascii?Q?3WG5bItkyEx889xPfhsvfqEIYqlvZAZxF7Du4hMh408jsqLDVCFNE/k9Md6y?=
 =?us-ascii?Q?pdc5cqx9lF+EcgxQg2ij/YFfWobvAjH5w6RXds3et8NpEahPOdF871K3aZQx?=
 =?us-ascii?Q?qBwZ0P8iTw8sBSjNgdceLqHPD5KwEKrWvj/Y/ukhHZDe+d9is5AAsTmG/Msi?=
 =?us-ascii?Q?C6KilCI5phujkOoYG0JNByWX4E+Unp8UObrXEcJOk7uwCM/DVXKGN4dbHVzW?=
 =?us-ascii?Q?A9H88KNgUFzgo/z98qK0siiqFEUwRhZft+A0EeHVxY7lyJOB7IKOde8CWN8e?=
 =?us-ascii?Q?htvvdoNu9Vj6Afvb65e4KENeln9ea71Kn7v1CSfQ7aKzvTOIyfHnrA0hHVm5?=
 =?us-ascii?Q?BWedNmdNMiTvbEqhpLMIzfRlHdxXx2eaVkXbAkF5CpehkXB21C/jnhzCEnzG?=
 =?us-ascii?Q?VIZWc11C/dWdkG5BBlYhfH7JO0jUDhcqKMkgzeKNgtAG66Xp3icsR1zhver9?=
 =?us-ascii?Q?elKgMj1PTqQY6VxQzH2XKPA2C9tlxvWW+pvWBBHHCynts76H40ni4an1/xn+?=
 =?us-ascii?Q?wzHI18xITrI79gtnYqjMiDqyvmPBexk2xIoe9OOUZX65GD1/f2ZC/uUQ1wCT?=
 =?us-ascii?Q?8X9hmMSP9ts4cWdBGwqIDviQb/w9kS23BYxnHQkAJAM1XzkTOPfRQtqf/YoT?=
 =?us-ascii?Q?ICpuSO+Sn43ROGJ7cjgaJzXNQZL7xjbzZYaiEFbWV49/q7v7HAqYhQq9qGmx?=
 =?us-ascii?Q?vG4gmJV5DlcAQP0hfCe2UK1YhfNr7AiNaH5mP7xavmksnCLsuSZYuv/E2xIb?=
 =?us-ascii?Q?jDGh20XxPryzf2cVPiWnrzTKhTk7azYdYUkbAdFRfR94McfNvCG+cq+gL70e?=
 =?us-ascii?Q?3miwdLG2lVNX+JxDO7+Y9UVRgXdxw6BczDJZo1oJB1ZEb23vQtf6XwXgSjir?=
 =?us-ascii?Q?QXdHDuYprwFjYHxt9j7peOW+uV/BRI0Picgu5RnqwVRyByMzXj57aLrnHOeL?=
 =?us-ascii?Q?Eb5k83bwg8EDF32dPUhldl5p86eqE1kv5bvHGa2w?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bf29e80-0556-44e1-af39-08de10137044
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 20:01:20.8473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f3hept6RxVIFYFbMivbV/ifDrpNgCYEL45PHcSJ3hcY8so5GkauYsHl26voQrhyk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5824

On 20 Oct 2025, at 7:53, Leon Hwang wrote:

> Both scan_sleep_millisecs_store() and alloc_sleep_millisecs_store()
> perform the same operations: parse the input value, update their
> respective sleep interval, reset khugepaged_sleep_expire, and wake up
> the khugepaged thread.
>
> Factor out this duplicated logic into a helper function
> __sleep_millisecs_store(), and simplify both store functions.
>
> No functional change intended.
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  mm/khugepaged.c | 29 ++++++++++++++---------------
>  1 file changed, 14 insertions(+), 15 deletions(-)
>
With the changes suggested by Lorenzo, feel free to add
Reviewed-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

