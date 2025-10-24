Return-Path: <linux-kernel+bounces-867907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A32C6C03E10
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 01:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72E5618C6F69
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 23:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2122A2727F3;
	Thu, 23 Oct 2025 23:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qFkTpNsY"
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010043.outbound.protection.outlook.com [52.101.201.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E900DA59
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 23:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761263139; cv=fail; b=C5JTWM8i4lrh7Ee1+CJvwPeTs6EzQ2R2qth2c7dJxt5G2jZ1chJl+hrzUieckYBJzTa+AIkciVFmri5xKwmf1SrzFthDDW5l4s5bBavdLUGumAVTWjFJztTVMXh0JsviiGQjbPySVmxn7JSzJergXx5IgyS0MVzt6NnDrZlVdlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761263139; c=relaxed/simple;
	bh=aBRu+bDZSd38TH4vya9R8bzq8D84glk4VahM8o3XZpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=erc4Yhetx3aqh1U/jVn22ShlIoCSBXCjoaQaVXwDa3PlHgdZFgT0mdIXtvsvpuvzq9xu2LoTEf5R2JnIDcXAp7b0ywUhl8ORjO0YfWxHTcvSlBcnwEMR1NYBr1r0QNBR2nLYJLfAEZVidIDXtVc3jvDT+RtP6B/ARQkeQnhBo+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qFkTpNsY; arc=fail smtp.client-ip=52.101.201.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZdEu+8iggtx7UyTcT2jm1IhGCP7KMveZ6FuQxCG8vry2aHmFABgGSwN+ZniRcfWetvLsykGhwattYIxeobqGseuWpm2fSnbW9DEOSoNhzERb7EzWthPSol5Wf085xgiggR0ibFy2ycoLK6SRFuoI4/0Zrq4C6O6VLdHQitPLLR5uE7RAomf+kOiy9K3piyahRUbOxGqGJ6+6pHe2ySijxXrSOTCZZFRNk6YZsINY1BwsnGL4ioZRbV2Uk2N35EYVmFjhuvdCIGcpJhqqOA2HtMQ1it5VslhP31k76S3HrOGKNYN4JRRRxGfWBc9f/knubr8qbX1QyIioNpbgL8etnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DYh/LUwmjipxvru2U6E1rADS08debEQwjf0l7L81a+A=;
 b=I8TlxKz2OP7iuGZQJZtxpo9vDsYNYsWArdzzRKKHFvK1b+B1To2ro0/fSV5Rutp9FNFiXr49x32fXmPbaMJbE7oKgYI6KMj5sv413/CJurHKbzpfE5N0lH90dV4A1JLLH7gNwpuDWn8MLBAZXm5kI30XnMeoI9/Ck8Vb0EBOFxheK1O7DUcRonTSHvJ2KrZifWrtYO3x9PL+B30/jhjBXZkNYcqWmhLDHs4gEXS2xDEXFLUq2ORDiLyxJzIOkdiP0fbr/AJaJ3bOG5mrwH+ZTRaXhXDn9qw75QDz7d7n4P/v8CZgxHdHvo+DLkN7aSRFSVyqbP4Rfl5ckmtP/Ay8Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DYh/LUwmjipxvru2U6E1rADS08debEQwjf0l7L81a+A=;
 b=qFkTpNsY6kteH7VGCdRhxOaV+Cywlfrmu5Vm8ODtfY+n9mbQYCg4Qag5dXMFfTuOhtiETAqPedUKyHm1ZLC9DvlMFT9/gUDMrCcxLkcHLdnq8LNgygzrOijkz2CpBrvd1pHKCfsLcfozuOaktMo/wbHWbbrDl9cloH/G7kje5zo5vfSdC/scpSyCCosCSND+aJA5oTSnqGjNRGnHJDXoZhccq+D2fJnAngeIANGPLq5B5wxXQixeYUh1EIqi2/fkG4OVt8ixU1ojmux3w0YRt1gtVbUIOqiTNLjZP28z3/1exWATKbGM9YsjD46eP4vPJIxp3jW0piKn42PpTseKZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by CY8PR12MB9034.namprd12.prod.outlook.com (2603:10b6:930:76::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 23:45:34 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 23:45:34 +0000
Date: Thu, 23 Oct 2025 20:45:32 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jason Miu <jasonmiu@google.com>
Cc: Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>,
	David Matlack <dmatlack@google.com>,
	David Rientjes <rientjes@google.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 1/3] kho: Adopt KHO radix tree data structures
Message-ID: <20251023234532.GA846943@nvidia.com>
References: <20251020100306.2709352-1-jasonmiu@google.com>
 <20251020100306.2709352-2-jasonmiu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020100306.2709352-2-jasonmiu@google.com>
X-ClientProxiedBy: BYAPR05CA0003.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::16) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|CY8PR12MB9034:EE_
X-MS-Office365-Filtering-Correlation-Id: 1796e3a6-13d6-45f2-2dd6-08de128e4290
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rCYfmymM6jdjiVP8FW2XS+IVQX/I/a5TYXOedkjPrpG8b95wg1snsEMOL5cj?=
 =?us-ascii?Q?A6M1ECiW6XBy8QxYh2ECxMeOyCQw1N2BKksm9WU1EkE6/hHv4/3qxNibZDkY?=
 =?us-ascii?Q?JtwEAyxrNMa2RKyyrO0kQRGybdsuY5bo7k8x6qiVa/fdRCyel8SnHbzK/Epj?=
 =?us-ascii?Q?Hx75W5g5Kt4wNqNLEMa5L7+EYmHIZ60NG2uUNUOy2/KXS0Os0a9ZJvpnbJoG?=
 =?us-ascii?Q?fyFIJYt9/xfRf6OKPnAX42dHQTvF2z3jse+9VB+3VaQ0MJRzY28N4NKlKNlj?=
 =?us-ascii?Q?ycGWT1RrTP4v6jYMVLJaHauL8rVY3ZyhhGUjcqIbtw2vQpRblhNmJ9gZ507f?=
 =?us-ascii?Q?6Tg5EsVXBaOeTOr5tCAgN0B3/Z6PX0bdi9dKIByHzCX88XrqbitVar1olU1W?=
 =?us-ascii?Q?ZmLSRAMQAfdAEgJUhJVEtlZ6Vw5Ur/xpxhWOJaM0/oVSnTsxGBzznXsBYH6g?=
 =?us-ascii?Q?oHXIdRwdiv19pNzceGwUfrATdGVjDE2+TKWQ1etA34aVLNFIf1qnKzA8X94y?=
 =?us-ascii?Q?e1YdRPjA3OqnFuxHKbU9qDVEIveVPZg/yw0aIYtqUN52NpEwig0tTh/8f50u?=
 =?us-ascii?Q?/3WQtvq2g3nCg2oGuv7yxVTDh8QlJ57dRR/pntoEQF4sbj5hz/3a1OnZWgz5?=
 =?us-ascii?Q?Gu3VNmGfo07Owgh2aJ914XJKR/duBUKe4GW5Bwt6MTZkYdXA35rLmqdijG3X?=
 =?us-ascii?Q?/UDojXG27fFIbNqm0qZwUB4mChzHGErDXFTbWDgkI3xN6lF25WDvNVdfD/0E?=
 =?us-ascii?Q?98FTJ1htjZiGnvbIDbKumVEnDeJ8y+SffP9tlcX9w+esabXEbkPJP8CsqMps?=
 =?us-ascii?Q?v0zRE3LySjUg2IFDvHXLsMKOUgTMFTBK/zyhib9mYxTcA3u4H2fwzRWF872f?=
 =?us-ascii?Q?Q/r8i41tfAp7UvQC5nVRe3K4vkOwJ1J5/WhCrQBgDrWlgMkdNiDhCdz4FCG+?=
 =?us-ascii?Q?PHdBIqPPVXQFebO41j+6GgPhhzFwFcF8zxFG64HR26zdvCjq4psHDC4rUzbG?=
 =?us-ascii?Q?7qORye8ulZu/yTQC2/U+zNXzog55h5/RPfs2LpnFY3AafGRLjavxFWDhKlNc?=
 =?us-ascii?Q?NqKPDmRybV+JxU749hMMcrKhS89/QHHfdUZgGDim5l+vlSqZaj06/pv3HJDK?=
 =?us-ascii?Q?DwTR/pUF1EyNZq5ky4aD2JcJIVoY+7YE1Q6QacL4uS1Bo1oI1Asg1tL5vt83?=
 =?us-ascii?Q?LX0e2bHZzfVDrhs/ecu1rGAjxuZmHY+qVkozbWvYFcT6d6A+dCNCinE7FBBi?=
 =?us-ascii?Q?pzn5QyzWnd88+eWUUOIsaGiDKr98SjVlg7Q7+JTYrAziL+8kRSPUQvd+XDoV?=
 =?us-ascii?Q?LlaCPBAns4km38mBGA4rGE5a2hMNfr7LfUAUP8mm9CjUx1w8zZfQcgocjqvp?=
 =?us-ascii?Q?rZe3SbibaSGEJ7EsKoxxjDCbuQYG72GfcVS8xBBNVw4Q9JQXzBcZl+0lYt/q?=
 =?us-ascii?Q?s2wkmBzc0VmqVDZo7Q9QUL0QpJ2ORMliL7hr3DEWpc8HDff4C5ZQgw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7k0HpeGU7h2ZAouoS1QF/904C8jfj6Zy99s46rfsWNLZgNyGKKUE+4fQ4b8w?=
 =?us-ascii?Q?U+sTeUmiAi82PqYr/wrdesgbSrF00BZ+pTiQCe7sCWZgDH33go4BgFqSlhXp?=
 =?us-ascii?Q?8WUkgd/SCDrQgrUciEbqoI33SWLVp0XiA1RB2NOGz0FL6aJ79RU4/IaOpwDi?=
 =?us-ascii?Q?Pw0gEMMLK2PKjZu9rhGKAQMY+F67Oom3UrVxf/0lNmCft91dEj1dm3mEnkCp?=
 =?us-ascii?Q?jKDXg7SD0vK2K0aP1a+ArfQssBagtv2OMr/hbwEtYq1rKqSekmoFX62l34OX?=
 =?us-ascii?Q?wpaiX3BEH2Hflmb6oSl0S3f8ZNcPJqiIi2X6D2UJM8QqJJ0NCXKQ2JMeYNj/?=
 =?us-ascii?Q?ndFyGt/Mnvnbwds+GMHatPaujQpt+VX3/+voYsQgLDwV+lpGFFduoRcezAeD?=
 =?us-ascii?Q?wCyruYFeKNxOH4YCu4IGC930tUzsgSu97geHSvofXjaUkfnulCPqcbxmIy5l?=
 =?us-ascii?Q?EwQWy+zimziHsCREID5LIc3BYsQxO60BySvwIWxy6UYCHw+RjP5mSmqywoW3?=
 =?us-ascii?Q?sqEPPJrmf4oBpc+ZrQ6N4fCPQRpzW27Y0MItjBvHQ2GMAHuk4h/6DXObfvS+?=
 =?us-ascii?Q?umHA6fOXBlXwnlxKfgLzY7+wqSuuB+ndmCYM9jAD2VzbJaqd21Palc8uhU53?=
 =?us-ascii?Q?Bm1/au7z9bnSJM3sVS29FyIND7viR0Uf7rim6x3omvzHYCFXlrTtkzHOhh8m?=
 =?us-ascii?Q?VXKfc/JQCyFIU/Xb0Ns6q3bkDAdCm/gFJ/zV6MPPOF0DUWfRajpFLikKhUM9?=
 =?us-ascii?Q?HXlkfe8+20bCynP8HALQLFRvvkABDwjlcrcZEA2kmyPFDGK4khHUfUy/VnWv?=
 =?us-ascii?Q?P5/aab9j3kKJ3K+sbulvQpgIx/qmltQNqV04LNTHb/Fr28Ehm+/vv+uYEKBJ?=
 =?us-ascii?Q?lwY1zuBgvQzMcQPraZ/79Sjv6VxARhmuQhs3fqtPPpDb/+Bqv3EgvPYr3Kee?=
 =?us-ascii?Q?/GagZ3v36z5mBy3rYBi5PBpS3zu8xAZoZneL+xKnISIrtCX7ut20GLo9EGDg?=
 =?us-ascii?Q?RdXkW4LeN2+QVvkQu7jP0493elfrIhMncoihZYajOmU2OWVqFSaonAqr1oQA?=
 =?us-ascii?Q?mfmLcH69Q9BnkXS74JKdvYxM43q60GhNrTQFdkASlc1hiXBjJlJD9AUb5J/P?=
 =?us-ascii?Q?EbEVKQS+/ItMJ92NiQEjbjM4XVQyVj7ySex+6900gSPk3mNKCcqiNUN32D6I?=
 =?us-ascii?Q?qqIRYYdbOBOpe1r9lkaUHwNe9/JYwoOwqX03+p+nU+/Jf+MqYxFAWNciBe68?=
 =?us-ascii?Q?0N8nQM/BRs/qnjrToVkqeL9VIoUxX3FoFrvi6SXC9ERIgMP931z6C2NVPEu/?=
 =?us-ascii?Q?ynZdf2PFfIAYqCS+m8t16gaaYsNii1451XkRpk3hHIemm7ExwNGtG1avmgin?=
 =?us-ascii?Q?+6Y+OnXzebn1rvOgVPCc0kTG3wD8YNE0lRojBf9lIJe2ZHYzKfZJ1bgFfRtj?=
 =?us-ascii?Q?XG0w28JQEKDa9DfnF285KASvcCmxa9VScxKbmPsGTyE2HSFesdxYW06JYugV?=
 =?us-ascii?Q?XcHNy/PNuW75VGiFQMPmq8KYMLsy4hoY6+fW4+p9q3iFD++v8h0Qug/L5Rhj?=
 =?us-ascii?Q?+xrwgrlfEprsTzi1NXQm5kh0X32Rwoz7BEvBVIyz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1796e3a6-13d6-45f2-2dd6-08de128e4290
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 23:45:34.7015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IwAiRuosF7f5piijmTZmF92VB61lWkmk7SQKDIF6rUdz6BAKpv9F52LcPXIlUjIx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB9034

On Mon, Oct 20, 2025 at 03:03:04AM -0700, Jason Miu wrote:

> +static struct kho_radix_tree *kho_alloc_radix_tree(void)
>  {
> +	return (struct kho_radix_tree *)get_zeroed_page(GFP_KERNEL);
> +}

I was reading the thread over here:

https://lore.kernel.org/all/20151222210435.GB20997@ZenIV.linux.org.uk/

And I guess this stuff should just use
  kzalloc(sizeof(struct kho_radix_tree), GFP_KERNEL);

Jason

