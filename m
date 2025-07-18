Return-Path: <linux-kernel+bounces-737037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B897B0A6D8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 17:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EA815A4774
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 15:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F4C2DCF47;
	Fri, 18 Jul 2025 15:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fD8KNrro"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D271D2343BE
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 15:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752851492; cv=fail; b=ljCVFf7kO/dAyYAFhVz/+7j8x/OwheVL8IjRyqGLai+gOhMrLunLUvENlouCNKUm08Edl5LZ/wSxuwv9I+/jPe/d4ZgLAMSE/VCWQIsqyN720HpxIuc2tDhHMas7h26HXvIOMMlP34UXV1l4zOqIjLmppLX3RCuh2kZB6nYJ+bA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752851492; c=relaxed/simple;
	bh=xmORQ28fZUpvGY2P3mkBO4l1akGWIR6vbZ624NpAjoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uSOY68gi8WXfJfaKfsDW8vS7OpYS80b8juLb3VV/XZXVL0MRneEQlWEs0w9P6cdWFZHjQN1xfQYm4tKDKcoYW+lY4nqTq3AD7YjbXXPsqUiSz/z9yCvK02srgMwH4eZsOnL+4AKO6zBvFRRi5j10mLW3+UFQWcAVEEdPOS3y8fI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fD8KNrro; arc=fail smtp.client-ip=40.107.243.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p1v/fD3hVb8LEDScxScXS18M7Ysr915b55eS+PaAnDgIYolc0zopYXEk8zMnIR1a8hjgFL5cj3SvsjvpYNTclSKrWpGI8jzWJBqRwO8Xnvsnu358+kiEtpgvp7xJQPdUiDDoPwlpbCUI/vrndvhNbweIJmwaOdG7am5G45/tlsONwyNCarkmbLjfN3GIQLPYBOLoULC/WSUtD2iE/Doi7//gm4+nIAZ1SGzETig/xhGf5BkEA7Xs+teeey0B6AinEqeEirMGWJAvuCPxeU8IIi3LywLfQYhoxBXFxhg//mtznWp+KjMnEtGfGhJndJFLwpJq3Nqj5jenk6dGhsBN2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JFgtiMfe4DXwuKZnRk/iEmrEvy0YMGCmdYTvCq4qMYY=;
 b=muo+hZ7UUSlooLNovKjc9YusIxTKp1Wa0Ll22Yh1VB7ug7nwvzIgsWVQEiJv/RJyNT6JbL7r1eHwCv1X8zRsK8AA2XTaTcbUqN0tERGbeihgF27oofskr3AMpk3FvfaRA44qxQC/375OqEU4WJQ6P5FNrqcixn8nyLkZ+QYHYjLk+28WXy0C1NeZdkKy2N7zMFT1BTWpbttJhCa9OuczYEacwY7M4WoUAa5wsAyYOJZDmDMhgAXwb9s/tZ19SCbBFtbLZcwy5K2ShBo9zu0i0VRmP6yIhqOOGep6UI9R47C4BB/2vfFnAUKhEcPJZbUThiad4Ac6JcGjfLuDHaXLQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JFgtiMfe4DXwuKZnRk/iEmrEvy0YMGCmdYTvCq4qMYY=;
 b=fD8KNrroF2uUGCBP2oPRa/XA29qNWeWrTNGlBKSfw+vXjriVn4ZqsT7eqwI/0doOIMSrPRP17dyoWjTf5ktpzqr0FUnNjK+tfsL0lnXGEFYHQciutBCEavd8ErrW1GDxU39WvsU6Ctzo8lWtVBjDvmEk8RxNk23SbXLILmoDxe1SoE1p4t5Yzss/G692f3Wl9WhpfTriqtU/LhitPtctprfXAid8fyVfAV573584MoRjl8Sy4yRjrwZx2Y4CriREbsp3M1hXHyQiX58Sh56OhUzvmj+unFvxX95Im3nhFtytXsFgRW7V84f80QKThxM8hh+rtom8wmgLEvRRFGPHXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SN7PR12MB7300.namprd12.prod.outlook.com (2603:10b6:806:298::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.39; Fri, 18 Jul 2025 15:11:26 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 15:11:26 +0000
From: Zi Yan <ziy@nvidia.com>
To: wang lian <lianux.mm@gmail.com>
Cc: akpm@linux-foundation.org, broonie@kernel.org, david@redhat.com,
 lorenzo.stoakes@oracle.com, sj@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, brauner@kernel.org, gkwang@linx-info.com,
 jannh@google.com, Liam.Howlett@oracle.com, ludovico.zy.wu@gmail.com,
 p1ucky0923@gmail.com, richard.weiyang@gmail.com, ryncsn@gmail.com,
 shuah@kernel.org, vbabka@suse.cz, zijing.zhang@proton.me
Subject: Re: [PATCH 1/2] selftests/mm: reuse FORCE_READ to replace "asm
 volatile("" : "+r" (XXX));"
Date: Fri, 18 Jul 2025 11:11:23 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <2173758C-0BFE-4AFE-BF46-A32F69F1CBCA@nvidia.com>
In-Reply-To: <20250717131857.59909-2-lianux.mm@gmail.com>
References: <20250717131857.59909-1-lianux.mm@gmail.com>
 <20250717131857.59909-2-lianux.mm@gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL1PR13CA0389.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::34) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SN7PR12MB7300:EE_
X-MS-Office365-Filtering-Correlation-Id: 54c8e85b-2bcf-4c84-ba16-08ddc60d5db1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JlsqAaOmgZ3Mt3dvtx/dnJtERDNb8bhgtt6LMql6nBQ4AzhXOqeIio0F5R2R?=
 =?us-ascii?Q?/VO5HXWSloAmuYvdgJu4RIXJzZcihKZLtvDsF4psvkrF3cJb3y/jQf8aGkUA?=
 =?us-ascii?Q?XPokSQM7+CJKiDMB0C85w/IMsURnterG4CGrg5GL+JLjRsUNMcJ3o5KF06ka?=
 =?us-ascii?Q?gAkfHv8jckZChgAAJN4nG4vlAdzMT5qRhNIRvt70WTRYnhECDt4xWuePWwu8?=
 =?us-ascii?Q?IiVraiGlic/y9ZvQVc//ly3y0dHMn3R2VzXDcKCkYs75pQcEAyc2nsOafln2?=
 =?us-ascii?Q?2G3JS8Kxul7FH0znHjB5bX0AdJr5Ckk8cD3r9M+feDCnjDQ16AC9O8+p9ZO6?=
 =?us-ascii?Q?DrHZuRD7N4ZkSK7pqVNe8VN2zFcwFa8uANrJIMxr/Vwca3AYDVas7BDgyGNW?=
 =?us-ascii?Q?ZZb0Xl0GU7gXQoYaFaDa4vRt5pHU4G9mN/COFfgsgG7ohH6GoRUSkELUEvDt?=
 =?us-ascii?Q?kIz+45sO3nPXIxe0wXEbhAMXAy08VvPzQahNR+tqXsUFrzHga5U8DnN53Ng5?=
 =?us-ascii?Q?FOPo5s/Zc41A1cNrE0amZrdsENBXa2X/skG2VX+J6WE5S4a+C/NRghGZCap5?=
 =?us-ascii?Q?/uhjHp1ZL6cirij15mpos34Y5dNxJq7N2vTWf72pwayY5Kjca4iYFyG+22IB?=
 =?us-ascii?Q?S5zzUHpcRVQcGj7y2HIiV2Xvrkap8p4tTxbIovz810gZ51VA51Bu2oKr4lhh?=
 =?us-ascii?Q?nLXPPUwJOirIh9VAPhN/sla+FXY7Yyzw6lBQ6YGxojQrAnk9bUzNywEbGHjD?=
 =?us-ascii?Q?xeE+KO5FDUJCaaJ7XrcL9/NHl/jNWrezZPJfu7z4w5aeICEKoS7k8W+2oPWf?=
 =?us-ascii?Q?S4JkFud/sf6gcIr6hxO7nlwJwmAJZ0e/0sS+LPGpeVdpQTXLMjWDRa3M3a6l?=
 =?us-ascii?Q?EhnQpRofpfVJUJ1L03Avubi3m2VL/07SQZ6QgxoTmzfFY0oZA/qeIxzuDTfV?=
 =?us-ascii?Q?W1X9h2/5nAIKMPXqvwM2KRN9yOuulM9l4FAnMW4OA4W7KzXGR2lJw/qDNYUk?=
 =?us-ascii?Q?LukP4ErrAklU5Bq/g8zY6lJLpun/KJHtJcTKx0N+WC2tslr6WUjedOHsE/Eo?=
 =?us-ascii?Q?NGXQ0EfbrNDXxNk0xEmZYpXk5S7ZKNsyypZcE02wU14P7t/7Tc7GmqI27Lzt?=
 =?us-ascii?Q?bOackkHTuEaUMjmJN3wo6kVjOeubcDtOSJJuPmsghhQ4bJZFETPn3/w1zlmr?=
 =?us-ascii?Q?ZT3HdnYA0SJK/waL+8V/Q94BAAzJZN7/xzrjs/Ud1QVr6tg4i/thShMNbu33?=
 =?us-ascii?Q?A11XxlMTXshHP+FXUIsCsXDKvNA4KoeEy82GyBLYHcnUzcFGG6iioTl26/Tn?=
 =?us-ascii?Q?6zXyL7/ePiquaBvmXhHXoxuVdkgOtM2jmrlv95pwLmwbK+ycQBUG0YiUShM7?=
 =?us-ascii?Q?fHFatNuFMEfRWal/WG536I12INmfesXc7LpilC+WERwXNQTUaE4MU/CCC1Hl?=
 =?us-ascii?Q?QJOLVBzIxKk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?il6jDr67iIPaQNQeOvpABOpxx/RrBLaTRcfDCloUKIGtjcKCT271agdcuk8m?=
 =?us-ascii?Q?x4ULWfp/EJ4uAyrgssXE/pL2Tsoxgjh/XNuw1PM2WMZoomi/S5UgL9gFlW4o?=
 =?us-ascii?Q?aUm70nqglfdxOlYNdH76c3V0ySh++GYfUWzE7FtumjrSVMlgZ7txkpCDYuBJ?=
 =?us-ascii?Q?ByrhTsmsuctB6GHrL6bfhF+wYvzLWpaCC/xkstj1fh39pwtjrPIVnE486EFe?=
 =?us-ascii?Q?3n/x8O0oFSFHOVin375Ct2gN4egzAkGcCcIdJvZWEMtq+ANpvkGhYizmYF1k?=
 =?us-ascii?Q?Ph97NyT/WhyEO8jMyZ/uGRGfxnVHiTfaWbX431C0WnC4UbYGvt7B/NicGEcK?=
 =?us-ascii?Q?AaCZQNiOxNxCMGR0qKX4TADfvwFV43eh8Vtw48YCCklN7qcTXsmJqZA9ByYl?=
 =?us-ascii?Q?eIBcD6NC3RlKNjKZLaBAYmdgiyMoqYYZrI6Lv6N2s4kw2xXM5GVZ8iva/FGv?=
 =?us-ascii?Q?iU1PGhKdlAH2QOASxaXp/vUPw5hGSOX+zHanu75ht4AC6k7iFFntSZcWUUIe?=
 =?us-ascii?Q?T0NYo/RAMJmCsSmnkfQPZK5pgtbt772K89aRGAh+cHuOlkt00oBOTeOcH/w0?=
 =?us-ascii?Q?7vE0iSMc770x1umsh9mn8TOZOfiZGzUtqYqMaLTz5Y6Zb2S3ixy+RTRdMEBu?=
 =?us-ascii?Q?+FFoIONsM7bwPt6/7ZX1ATtHPxKcf78XGKUkzRscj6XVW8x07NTnxdzq8GeM?=
 =?us-ascii?Q?R7+MvwgtFuX53kIfx5lM/O4RkRA/4iWR/JyxpIevGuHabQ77ajO75I0CxtaD?=
 =?us-ascii?Q?5XlLPcgCeIkMk1f4SG6O/e0edwJmbusJKVRYcoLDs3WxC3LO1CbgstslUwuI?=
 =?us-ascii?Q?XkgA9ORlR755JWRNwmhsdQBFVrM0RJ41Hram7k2b59KlhxM4deP9VFBrZMoD?=
 =?us-ascii?Q?pKPDYH4J43biF1vGEL6aKOx8iqk97mqQOFvY/e06boN1ZHhPYY8GWYbaE2AG?=
 =?us-ascii?Q?b/9Fv+ucJ/OGfG3PlmaXHq/j7zCS/xUVVVfxY+ewAuy1qb1iTGX/SINzKiTg?=
 =?us-ascii?Q?aP0rHFJph4+oA4Lu8J0OqyoLseG78Sj/odf/fkyaYkRQPB6TklRg91tAreYj?=
 =?us-ascii?Q?fosBMynTB2bIiGwfldpZLtlUuIiqjnSKMjSm4lKw0ySrRJ0DyAWTNKlSOhk8?=
 =?us-ascii?Q?eUCbidNihqB5IGfhztgA1Z1gJKNiPNDx6FEphUxZOhBFStXG6u3sgb8KU4cR?=
 =?us-ascii?Q?na0YAHuUR16BDCM8KcFZ9HIBe8XCO2Ia8Rx9bTb8HoCOiZ6W4WepDsHTEJ0x?=
 =?us-ascii?Q?1VF0XRK3x0AZMYAqn8ZvAXP+uOheZaM2TwBs1sfWq628QXoERgSb6RHfRdvJ?=
 =?us-ascii?Q?CSMtmZg3twKtABSlt6ejXjG/kKHzi9rX6elq/Qw3j1ONATmqN58Cr8g0fM0S?=
 =?us-ascii?Q?S0UgJN1T/4kI2ftoQsSUegXkSMxb+kw6cVO0Ye6IRmLc+vxgH33/hHOCt6z3?=
 =?us-ascii?Q?6ph9rGjf6dJYKf7RuLB1NhD0uQRJb1ysAUPErN7ViiuIn+oTIxm4EiWQ4zA9?=
 =?us-ascii?Q?XxZBJ7XwL3Xg9sGtJHe4gCKyY22qjss7SZjAg7sZZViq5aPIVDHv0wGLaEVL?=
 =?us-ascii?Q?je8RXEG8npVjLRIdXeENoIfJv1c5fn47xEhunI5E?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54c8e85b-2bcf-4c84-ba16-08ddc60d5db1
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 15:11:26.6938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AF8YuRCGYIvbtHSX6gASZ/I7xk1tiUwd4GTT8xKL/oPCQDYsLVdpSmBXoIbqRPmg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7300

On 17 Jul 2025, at 9:18, wang lian wrote:

> Several mm selftests use the `asm volatile("" : "+r" (variable));`
> construct to force a read of a variable, preventing the compiler from
> optimizing away the memory access. This idiom is cryptic and duplicated=

> across multiple test files.
>
> Following a suggestion from David[1], this patch refactors this
> common pattern into a FORCE_READ() macro
>
> [1] https://lore.kernel.org/lkml/4a3e0759-caa1-4cfa-bc3f-402593f1eee3@r=
edhat.com/
>
> Signed-off-by: wang lian <lianux.mm@gmail.com>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  tools/testing/selftests/mm/cow.c              | 30 +++++++++----------=

>  tools/testing/selftests/mm/guard-regions.c    |  7 -----
>  tools/testing/selftests/mm/hugetlb-madvise.c  |  5 +---
>  tools/testing/selftests/mm/migration.c        | 13 ++++----
>  tools/testing/selftests/mm/pagemap_ioctl.c    |  4 +--
>  .../selftests/mm/split_huge_page_test.c       |  4 +--
>  tools/testing/selftests/mm/vm_util.h          |  7 +++++
>  7 files changed, 31 insertions(+), 39 deletions(-)

Reviewed-by: Zi Yan <ziy@nvidia.com>
Best Regards,
Yan, Zi

