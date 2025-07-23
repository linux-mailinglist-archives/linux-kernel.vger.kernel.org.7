Return-Path: <linux-kernel+bounces-742843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E898B0F744
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 17:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D93D7AA66F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 15:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FC4201278;
	Wed, 23 Jul 2025 15:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SDksnwR1"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8360200132
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 15:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753285214; cv=fail; b=UQn5QnCKzORwdxRieP+fiTWSFQ+eJS7eLXKoKojNVf0e3jsNUS+9WNchNLo/BveGF0oIVHd44sTpH89bgvub/hjLwB6hIys5JpSstwCIqGLfrBhPJBjTSWj88wCv2jdy4BfrkSPwEQBDvZQbRzit6vmrVnPSMjsQ5tNZR2X6jbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753285214; c=relaxed/simple;
	bh=ISWswsAD6A2OZdbpy1jUg2Y4Q3SR1WT8Ug/J8PAFuCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rMFPwQJKiTnX1nnEg6K3Xh51tsfcMnkyVkyOCeEDpJhJXvJjSMHpvIMWxzdZrfEx7oXbToYZtK1oBZmXKy+jkHsexVVToz/P/3RIBefFBUL+DuSndXvmj06so5TajrfBEX8JlZG/++Yxrn3ORtc/AbaesSYSKsQJIUEEB5inJO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SDksnwR1; arc=fail smtp.client-ip=40.107.94.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yK3/mC2TCZPwi8PjRjhdm+LmSajAvh/rAkmccw8t4gXsRGrB8CbGjXice57FLwynaZD6lzDPGJdzQsTYqxM2TvgUogY0vpe6obAKl7TvGb/0wZUzKqwZjCbQd2S3DQoyDpg4U1cz0tciBAUBURx1p7YOn9a49Ch3ZAbCycJIObgR2ZsQXP/rPkadFDLPe0d6joWyLbpWqGV5cOP7mSHQhk02gSJnuJ1OeARXwav8/+ddQl+0YgxEuWTCZo8pZTYPFycBMQs3Ha/cBy7cAMDLiHvo4A+D3aFrKmUrdQT/mfWe6mbGkNwYALDWGmxpShlSl2ktKm1Qv+ef1wM4FnmggA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JzH5SMM9WlcVbLiX1jjvjAjYLtSDNGgllJ0RmGuOLTg=;
 b=wKsgNkqNqcCMwFOmLhpvUz/T1L9gTnN2JcabPQJg4fG3obrMcKiyP4ha3iU7OrHL1/ybrtVXVGWyl6P9WS2g4NV11f8JJ0oEkjA/KwWJYgzOxk49LKrJ3O3yxPJMCytATxmQAjhFhcuwrhP4XKFUXD1rGTfLgW4ktayeoOblAYUXZXxN9JGb2mA3zGfPoCOWGVMKYMDeE2/VEM+WWeD+jXJ8NY/WC66CEVpDQYa6biGiclmw1JMUjNRgXGT8g2tobWYlv9juu82k54GmLtsxR7NNIrPjF9EzsnnKYLS6TaFGotJygouHOITJ/Qpp4GusFKxSc7Jj6Vmr9Cf7TZL/BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JzH5SMM9WlcVbLiX1jjvjAjYLtSDNGgllJ0RmGuOLTg=;
 b=SDksnwR1JbMhN65X+FoIGwUewfw/nfb5v4vyVzLAyOPlL3lJLHH127q7cduPJ4QjrXQ6nohfb3TdEUQxGdk9uFyX2y3TvTZZfogX7GqPfEtRYctVMUy7I2KfWOfBfu9NIo+qASCWENId3fPDB3p31E6tXwgA4MC8C6ri18R8PJ8/WJfn707ahZjCck4th+98q4mv1cI1/d8e0NjzeqVu2GLsqBFgBdezaTPNcXTxjsHqKh3Gxd7XQ+BHfHXM0kdkGBaefTGrO0UZAKpDcLx1T9lIicC+5IcEfqHuq7vVSleOe0gKiaX4R/hZfCp4czJ6JeUHftGtAD1UPLEZzN9ncA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SA3PR12MB7880.namprd12.prod.outlook.com (2603:10b6:806:305::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Wed, 23 Jul
 2025 15:40:08 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8922.037; Wed, 23 Jul 2025
 15:40:08 +0000
From: Zi Yan <ziy@nvidia.com>
To: Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, ryan.roberts@arm.com, david@redhat.com,
 willy@infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 catalin.marinas@arm.com, will@kernel.org, Liam.Howlett@oracle.com,
 lorenzo.stoakes@oracle.com, vbabka@suse.cz, jannh@google.com,
 anshuman.khandual@arm.com, peterx@redhat.com, joey.gouly@arm.com,
 ioworker0@gmail.com, baohua@kernel.org, kevin.brodsky@arm.com,
 quic_zhenhuah@quicinc.com, christophe.leroy@csgroup.eu,
 yangyicong@hisilicon.com, linux-arm-kernel@lists.infradead.org,
 hughd@google.com, yang@os.amperecomputing.com
Subject: Re: [PATCH v5 5/7] mm: Split can_change_pte_writable() into private
 and shared parts
Date: Wed, 23 Jul 2025 11:40:04 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <724DD429-82CC-4C6D-9425-086258ECF63D@nvidia.com>
In-Reply-To: <20250718090244.21092-6-dev.jain@arm.com>
References: <20250718090244.21092-1-dev.jain@arm.com>
 <20250718090244.21092-6-dev.jain@arm.com>
Content-Type: text/plain
X-ClientProxiedBy: SA1P222CA0133.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::18) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SA3PR12MB7880:EE_
X-MS-Office365-Filtering-Correlation-Id: a8016663-8552-4566-c57a-08ddc9ff343a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dK8CTEwj5SDlQ7y1cv67rtyB3JKwJqmmRaRGc51w1kA+mr6LFUQnpJFCZp/e?=
 =?us-ascii?Q?HN7vpLOk1LpLCkOV+LJA0YlYULk8oayeX6+/yCCvEUJf7DvVw3hu+GpQwMiS?=
 =?us-ascii?Q?2uRc98ALcoysn1740g/acRcg97i4Uk/qMS8ry1aoBmFj+QSycqKmiqAp5FHF?=
 =?us-ascii?Q?cYDcKbW7KYIlssb3dPtsMDaUKeAHjFrb1LDYbYNymu/EC4H2ZIbrDnKi7XfD?=
 =?us-ascii?Q?rKPB/koIaVNJMIi5jFtqS9yf5bSkzGnrA4iiu6kyzsEK3e/UVO8KKmM9BQYy?=
 =?us-ascii?Q?98gk0gfd9mcUSVxJ2ylpFfqLAVB86inJ25GSUI0yDhV3srzac/HI39UExPUM?=
 =?us-ascii?Q?tyZX2oAgpnnT24GN4aD6q9iyQcxsGKEfltP50cFlKche1qcIDw7Gdim8nhXk?=
 =?us-ascii?Q?4vN0wZWjNYGu0SSTQomgP56kph5nI32f4fImxyIXa/Q3WuSHPcYuNAqWqtID?=
 =?us-ascii?Q?NzmFXpM9Q2U5oFXReG05iDefMXWnDEDUw+ZyIm9JohyVb6GVVAJ5Jkllakgg?=
 =?us-ascii?Q?aWN7KSNacPZDAT4Jmz+YvS0dg8BauWT9c45IVeNlXvxf208Mi7+HFNJhT61Z?=
 =?us-ascii?Q?4SLVJfHgyixmhjARwb2aKEfHl2cSd2ir98f2bd7bmYQRaOz0T0iU2m16I/Q6?=
 =?us-ascii?Q?f9eGELdKOOxbT9DVegFJTnYw0cWRlYjIIyup982MkOBeQkuF8ZcW7r0NJSDR?=
 =?us-ascii?Q?QhFISyViJALxObvXnOepqmHgKhoPA+c9TLzwNbvsAE77OZcPflhLX8bOkW3f?=
 =?us-ascii?Q?t7Mdf/wPD8qyv4b2YALenmL9rksZxSYWQVu96A7F2LNpN5JJN3ZxdMTTFlYw?=
 =?us-ascii?Q?8Kd8/Ro/XrodW/g8gGdRawXLMVqN03ktqfzIYt1ow2ziwrSmIUfg4+Pb7hzN?=
 =?us-ascii?Q?8q5uvDvAt7bmBSIfQQIqRXXp5AIJBrxe3DwYOUX5cHX7hu07DWVElopQbC2i?=
 =?us-ascii?Q?hIN7zXjd7qX0GvFhZQHlH1AQ5NrzGblOD462bUQLMj7OwH/E89xoa0BC7TqL?=
 =?us-ascii?Q?JycEa0F28PfjFlAUIkX3h2ttuGqf2+pYExHPwd4DKRRFUTSkRvnM7Mfdtnz0?=
 =?us-ascii?Q?T/rSrBGmL6VC9sco0JNnT9GLEUedxrk5TLIkNFZNb8r5wl1/YhWiWp8+nWM+?=
 =?us-ascii?Q?ODOZj7ybSxxF/earflAIYvSfH1A476fUdovLJdjnZPaDIovhQGRF3K51BLjC?=
 =?us-ascii?Q?b1IF2wu23jSp8C0gXXUvXitv16XeC9cDLF9ar9isaJyX/qypjtTtyx5ZDah+?=
 =?us-ascii?Q?h9BlL5U3so6v4ETeAvlGGCmMX4wOWynFn1A2ODByarpNy23PUzIKOWexOi58?=
 =?us-ascii?Q?CAF/XKnt1GyQsRwH/nGUbB86uSJZEIxvMOwKHLRkmgT92iEbrYxNuzlr6LDK?=
 =?us-ascii?Q?XBQK7kxtwdrhFfeZ7gqHc5Qt9vSwRduv3cDvFYxNwfIrwxgfO0xORUuEexK4?=
 =?us-ascii?Q?3sbPJQWz3Ik=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Tgd5WdZafGcU+ohh5v4/6j8JVKm+58oTjnMJSm3lR2AoYtoVpBKx8+aEzY+r?=
 =?us-ascii?Q?vnpEpMh4BOWkQIYSjbjXYveAY0I82RnjH2s7KPK/w6DvAUOzGbzUsp1S+jpm?=
 =?us-ascii?Q?45GSwLoO3sQbRv5sKYbzIRyEX/MBOd9WXny9XFbfvxfeoGheUyL6Kovfk+zQ?=
 =?us-ascii?Q?aqTuZIBzFcHUmCfqosKYjvy3o/BR5aFvSnUeOK+UA5LtcMmWNbEzhKzJ1omK?=
 =?us-ascii?Q?x/SPzugHb6Q1Cn3aR1tGA6Wr8nmtbU4QyQXvPGV2UbmMI8JmrvBTtOKIOMYY?=
 =?us-ascii?Q?Gbh5ky0IXiA6MaVhe0YVENsvGxWr1KMIcM2J8NX5fLkN4rnfC0ZmRn90E0qF?=
 =?us-ascii?Q?h0XXO6Esjt/vCQfOqeAH5SLmzZGmZgbs7Oz0NLVvgKzcqWG/3iyJaLiJMT1F?=
 =?us-ascii?Q?46Bi9QhoVs4GvJnY88OsZOWZeGCiK/WvCs9YgwimRoPHJE5eyEVr/kcAdsYy?=
 =?us-ascii?Q?iQlV6tEGL/adj1a5QnbdAnffqHvVMZbeyZi3O3hm3Fqq2E0jkGuX5Xsh12th?=
 =?us-ascii?Q?fSwkTOUGQ5MLAfjrVPvQUhLyfImS8PXXkSQkvlQa7A21pJMhFJjvkGlG4xa3?=
 =?us-ascii?Q?fHonFaMbJPsfuAC77sISKFtTA5YnoMVwHatf0uJA1T5ZT321hdftE+r2hsBk?=
 =?us-ascii?Q?MjXW6SkGujb41maqVNnL+pKoUouJp8yfVlnLvB4Wa/eURagPT7BPOTFo+O2x?=
 =?us-ascii?Q?olCRsH55U9kW/UkDEGcEiGaLUu81m7RKZspXzlQ9uC+mn6G6o9ex01WdPmax?=
 =?us-ascii?Q?UFPcYUzqopgVKOQ4lJGks8+gztVlZP55Xjh+qyOBHotczLQB9R5YxXyUwczL?=
 =?us-ascii?Q?lgSC1vEDpGUBo/k9KS92EVBY/lhIP4Twd8ivYNh4YOCL377u0TUg2YWIJG3o?=
 =?us-ascii?Q?0kUfspQX62nTh1XoYLV+SVErHUIDL2RlUgM4y52fj3aT1PCyKmCa2pSBj1IL?=
 =?us-ascii?Q?ArF1Rkt1naUDxqcCYJkMVdZ//jNhgDU8zarIX9tvz+VvVPUL0Ck3rGN0MYLG?=
 =?us-ascii?Q?nXxPR1c446QYWDJ8kbskcjygkRh71KREs+OBSQ5G6BetOt5ecHkHFtJ1AwKc?=
 =?us-ascii?Q?GkJuQ5la53iWc8sUqYooI6MoaCIyJGSkiKgAMA7q04+Ul7GlgGyFFnWxaiiq?=
 =?us-ascii?Q?Tp+FpQF05C/75AQrSgsK6nvlR4MVF2Axxv9g0k9CoBxbbXL1+8ZZnDOb4NoT?=
 =?us-ascii?Q?93emf+sCj8z61v8NWXxTRQmfVbADS6SSUvXB3CKbrarTtsOsWkEtnN9bzwtS?=
 =?us-ascii?Q?HJ1tcTAlafWSqD+6yyLog3kfj+I8KdrEdsd/SbQcIO47da9vjqwZWhGW5cNO?=
 =?us-ascii?Q?Y0aREziQ1WN+gd0eN0QbvZh9ztocF1s6FbYgDw+ewMIIaCwqLzP5s2HCeHDh?=
 =?us-ascii?Q?0ghFguZ51O11JgIbr+f5EOAja5RMmjbb+3JG73d7m1zVmtqcUEpwPSX/VA1d?=
 =?us-ascii?Q?fqobofYAR0P2iGjOcKjca/33w/jmICj5zr4wNz3TBF4H6ruh8tmA7JPovaTD?=
 =?us-ascii?Q?lcgglvVEU+6gzVwqu5lLD4/wjOJNWz5sL3DPrwPHMTbC3E7ABjC48g4m5F7v?=
 =?us-ascii?Q?bWx1VF67TxMwDBruShOWCFuKExCqoE5eo6gGLYJ2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8016663-8552-4566-c57a-08ddc9ff343a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 15:40:08.7708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9IVwHjAnpeHp5c+bc0Yae3gR9gNrzxOnVzk+KlFgsCszQQ3Phf8LX7y7va7CQH5u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7880

On 18 Jul 2025, at 5:02, Dev Jain wrote:

> In preparation for patch 6 and modularizing the code in general, split
> can_change_pte_writable() into private and shared VMA parts. No functional
> change intended.
>
> Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
>  mm/mprotect.c | 50 ++++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 36 insertions(+), 14 deletions(-)
>

LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi

