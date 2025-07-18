Return-Path: <linux-kernel+bounces-737038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6EDDB0A6D9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 17:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBB423B9710
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 15:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05D32DCF71;
	Fri, 18 Jul 2025 15:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Cv5cAXPd"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B164914D283
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 15:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752851518; cv=fail; b=KVtF+nQ2nsyRqX1VWtSBqSbwoXBz0kOwVB4b+1Qye++Or5r6fi/r2UFrGuzfhMhBHMyX6c8XovcC2rvqT67d+DqDG4Avmalo6JN0cub4M75auXzg6HBbvXS3jWXLh1W9ZFbowVg58zrjXB4zn9jlyRp0DkuVYLJ3CzEwcocS860=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752851518; c=relaxed/simple;
	bh=D+/lvh4SkpAk82o2yOlp1SZhdTsjFqh5UOFTeRJpG6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c2hCm7AqNkNO4Fw2sN8EArR1FJeaCv7o3QDerHrwyzlHSG8a4UIu2KZGg5Kh260SJlC+AzQez9QvXkCgZtBcfhopaGn4O3Z3nRlWGqdeDZ98tpGzK4f/vPT0AUeH9twqmLUwY6tT/vZHkJ56VaMJL3OQO5yNPbOm2pbrpCzxxGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Cv5cAXPd; arc=fail smtp.client-ip=40.107.237.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oCEUbfVwSxruIOdoyLPRuGr5uza2wU19h1noC2afdfh4CoFpsQoyThH8YLb/5H20qI43Qpi5ZpTfK6RlPQdroLluOyis96DENUAwj7mkGPDd+IC3LHQET+ScVxV0Wnn0agSlOCTrOUVedzLtDYY1LJtCKhd+cZjavoNv1RHYNZpN0bR7qc9RAx2XK8sBQ7K7yVNfr2K/tBR9Fal1jNrLfoPLmAScbjfbHFuirV/nMyfUTTJlDLToKH6ZQoG9AIjQYMRoEJk3DHqt81G6AC5uthnhux1ZR4uw8hKue5NVEzg00lLeFWvoAGNXIwCuThfCd31wFynmSSK1+zhzTkF/og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+1fzhjAmqgmMN77BsXFSk+s1IwO0JIFr7/Wjw+kUxNQ=;
 b=OtNt9ziPKZruq7JVotg5g/rJInvjUBFfEDmWw2TlA9QSyjZwq3fUnMRyNY2tVsVV9pSSpsn3LzTqxb0E5xh4DCUa0J6rMmE5FmC6VwYDe9XrBlmJNgRJYemTktG+zWtQRp+7KLYCC+v5yY65gRizdcL3zy8NcE7/1KNfMpyNd9bcSKtyi3Ju3kIrlNctFDLKBHULGxb38CkaryVseXLMapHS44+UZSWHxW4w85BQRhjKDhlNURJQaFVxl35Wk91/ef6N4G1luIA+XCjPaLKfkRY0w7+a/sKf1mRjiT8sjagwLbP3h5zRVx0oPf3CUw3qBtkrr+xDRA2kZUREA2hidA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+1fzhjAmqgmMN77BsXFSk+s1IwO0JIFr7/Wjw+kUxNQ=;
 b=Cv5cAXPdQz7mtOlfi5r3mwSSz/Wx4rx0acbt/hs5N6gCbfLak7pxUDN3G/9pcoyeEd3tj/rkb2/Smym0ufG2fVw9O229sEw72CGkGnuvpvhmCKnKv1dsLfs6hZMqF9ArtDzXXUmE9VeHXo/BYi/5CJ+NycF5vn2RLdP6gn8dQEH7bSoKAItqdgGu50YRPmo+9d8j5Tkw+QCehnuz/+JIBNHQEj1jzysyVKtVQuoHhtocAxFe2uJ1xZZjJVYJumIS9bJ8r4btSMozJ4GKMi6XljhSvebcxyw/72vbjPL/7FKTfYybabITGUnBhNho8Fl5YlHO3COtNPjwpw2kmhHfqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SN7PR12MB7300.namprd12.prod.outlook.com (2603:10b6:806:298::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.39; Fri, 18 Jul 2025 15:11:54 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 15:11:53 +0000
From: Zi Yan <ziy@nvidia.com>
To: wang lian <lianux.mm@gmail.com>
Cc: akpm@linux-foundation.org, broonie@kernel.org, david@redhat.com,
 lorenzo.stoakes@oracle.com, sj@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, brauner@kernel.org, gkwang@linx-info.com,
 jannh@google.com, Liam.Howlett@oracle.com, ludovico.zy.wu@gmail.com,
 p1ucky0923@gmail.com, richard.weiyang@gmail.com, ryncsn@gmail.com,
 shuah@kernel.org, vbabka@suse.cz, zijing.zhang@proton.me
Subject: Re: [PATCH 2/2] selftests/mm: guard-regions: Use SKIP() instead of
 ksft_exit_skip()
Date: Fri, 18 Jul 2025 11:11:51 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <4129FB57-615F-4436-B42B-6CDE3D827BA2@nvidia.com>
In-Reply-To: <20250717131857.59909-3-lianux.mm@gmail.com>
References: <20250717131857.59909-1-lianux.mm@gmail.com>
 <20250717131857.59909-3-lianux.mm@gmail.com>
Content-Type: text/plain
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
X-MS-Office365-Filtering-Correlation-Id: fc8b18e1-8a6a-4301-f21c-08ddc60d6deb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z+s9cA5CR8ZpylSZM3Txe4kg0UdmJfKQF9GWi799r/oNzlfb9zMWEPIST+am?=
 =?us-ascii?Q?81mTxqzJYh5ya65v+OM0Nt7KWigJrfRwmfb2xadicFTuKmU4E3yJcZZfuyom?=
 =?us-ascii?Q?Oh0i339CJbwudfWztoZsKVf1xRFzQtTbNxc8DsaCQ1k3H6qm/pYRkIlNdusj?=
 =?us-ascii?Q?s24KC1jim3EjI3qTY88H9KNFlfMU/GiUdgq5tK4+LxkJIh0/kk0NlSLLZAW/?=
 =?us-ascii?Q?hytyXAkx5Xw8z/wGka9BwC9dTbi0N19aU8RFw1HcY3Cbe8Njq0TxGmxWhiex?=
 =?us-ascii?Q?UMlOSBWXqEqvXm43BZ/oxPIfW4dUrK7CpamVO5W5HPXZjP7LTxObMn+ksR/A?=
 =?us-ascii?Q?AwIJRylRRg0rOs7rCBszMsdKdM8xS4ywhHCvrjhKwqPkjZ40doafA2NyWADd?=
 =?us-ascii?Q?4JDpWyX7EOOI+widh5MPpqORJbFKaC4UvWf/WRDaKMVYlWcCGqwSGN57BlSV?=
 =?us-ascii?Q?Tt63d9WYi+bqz5FA7HVEx6jbGtmHq/BI/wCzkUFnMcgmkZws45kPzCfyjQzA?=
 =?us-ascii?Q?nBwh0SbKjmCbtj0RNYgPRaN+hoe/xqpfFsRjsTZBzVkBEA9jtUPkgngpfJGY?=
 =?us-ascii?Q?gcbxalQO9jvXNk8NcZMV3z7tkW/daoFokXSjdKRxmTVlMJjwmD8MvrFUoDJL?=
 =?us-ascii?Q?LBmIIRgN6DWQ+tvu++8SPBDaZVi6f/BGnCUApaaUVD0kSVpaA1yQE5rgeCqf?=
 =?us-ascii?Q?oM62dhJkRy0CnlEQHo4ICBf5Nh5bzjj5/ugT7dpJG/7IKrYAg7YxKQWZQ53S?=
 =?us-ascii?Q?IPboG+ojn8JBceatJyW+GUhTtTlZcRUbATSE9uETBnVYkLARef7czNn4Rl86?=
 =?us-ascii?Q?oE+U9m80OgjwTZVu6FiJSu8ivTj5dVLWsGROWDeT3InohTVHLcA7St59BE9m?=
 =?us-ascii?Q?LcNfQ6JgjECPrGqH7ZkumAyyXXX0uP5fUb7/EB1unf+6kC7npf0qxrwa4lCA?=
 =?us-ascii?Q?GR5XL5c9NPlXCGogTRcZo9WxL5OTgV8f/RGRmxAP5hKABy0zNEC0Co8Ki59w?=
 =?us-ascii?Q?u8Qx/9xJXv8UOt/WzIvbH6FPIym1ZwEANcLIrUD7VYGu/Nrgq+fd5iIX+HaW?=
 =?us-ascii?Q?jNhP7AaiMrrA/5jNi4+T6pxVdl4P8orHsHWjzWjfsadFxzgYjeYkhJ3tg5R2?=
 =?us-ascii?Q?XTbKCPEMO1QXxmnPbym42Xc83nF5prbq+tWYqE/5PYHy/ro0gfHZDIlOXqVy?=
 =?us-ascii?Q?CRc5hWbTasOy77Z7ejH2pBchxVwKXdNaDcgElfKq/zOUFEMsYJKor7/pWxo6?=
 =?us-ascii?Q?t9RVlF66jHSerlvQdTFzBhn6SiDxnko0wEi/p3n0a0ePC/+xBvFlApDUIuOl?=
 =?us-ascii?Q?6nKpqh8O0yqnlmm3Tey1X1ZHa9Tq907hb0OQO6IoCzTfj9nKEImyUcVdaIDt?=
 =?us-ascii?Q?HehnYVL7dbdeGsen8aNDZqiso741Gt2fGYqf+fETtvxMtZ4pZq6CvIMrAOmj?=
 =?us-ascii?Q?va5be/egFmY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v0bjmaXZtMLaM1ZE56CajSjzAfc5zgg0LwVjX0hjDhoC0JehVLKXCCOCRWnV?=
 =?us-ascii?Q?1/PfcicbnWO8wk1DTHO4CKiCCzSe5oiqWAu5kGdK+Y7f9sxMpExiTtAH1fS7?=
 =?us-ascii?Q?+8yUn6MNTkot8YQVnBDJMhk5GevMaDUk2BQCIai9LGdL3cmP80jp2uiTYSiy?=
 =?us-ascii?Q?uy7icJqNzc6XLiUoKQ9Tenl8tSe++whwMZh6k4CoCOwIZvWSw9qQwNqajGFm?=
 =?us-ascii?Q?NwDv6uBCgngTRteFsEzTMKvtEpsauf75F8n0/WM9uhvZjF2iIHs+715jHvH0?=
 =?us-ascii?Q?9TOwDutmhtwTiBu8hgG8dE6HGmeOLpKxTQP0PXtLO591v2dvNaQiZogmWYBp?=
 =?us-ascii?Q?Yri+H2RGbDULtLE1pIhW34ppTpZ20GaLmMNlUpNCPF7j/P9kcxVMT0LqOshj?=
 =?us-ascii?Q?9Ie2dFpY+8Zko/B/l0Y9VrlySJdF+QMYYY9Fh/UCwgVA7zjU4f9uHR0wFTjl?=
 =?us-ascii?Q?TBuxf5dYJhUKQmlx8gLLc1jvsD7DGv/VzLOPRyC8JGbsvzNB9ZQWmqRFZMPZ?=
 =?us-ascii?Q?ekek/bkjEa+f+KuvVOYorW12jfHCT70+0AnV2PAgjR0vg+M0/tgX+lJ5xQ9C?=
 =?us-ascii?Q?FvmdtpIfQq6zkACIkSX+kQ/XvpqcHzZjD3uEO4IjbQqwVsK5h9QGTOgKAbxT?=
 =?us-ascii?Q?gVB00fD1D1+QiMkARLMhZHpdIouFQnrOIIOWrpdAR/NJOnxv07koSgPmDR5S?=
 =?us-ascii?Q?7gxKdk5s54fUhXoX469m9ZWDgH1LQQ1PBafkLFgGT8KQCf+cHHbyIbx9n03V?=
 =?us-ascii?Q?jMAPfEMpHXYsJ7ztMRAonwk9Gf7BVzhXOcji+m5i/LFqBnpJ0aS6GQvO0mfv?=
 =?us-ascii?Q?068x6Hh2EcOU75FCkhkNa6De9qIruzMod/3SehlacrvZuHPn26AOc382daoa?=
 =?us-ascii?Q?AczCliFRYNEAj0+6BluCiD7PWnThMYS+95i8MHdpMT6pFFdHf71o+3vbUFrA?=
 =?us-ascii?Q?a8knTdu+cIPy5sgckKyNaPzMHnNyJ7z2sCmj4e88JUqzkkfrA0vy/0oQwgAE?=
 =?us-ascii?Q?Ahwe2ip0jqrIjI58mK+tNDqSG4rrY9+c4xFYA9kAGDd27mDx8xUdrGJFqP7I?=
 =?us-ascii?Q?pDpStBhsHNkPgzxFffutSVjbyzlR0hYGjiYAdAbP6PqfrWAbuaRovEBMEpFe?=
 =?us-ascii?Q?CWcitja2OV88FcxBER+XcDOANMXJVK/1+HM/kASvinM8a6yIIVLkXHHzDQqc?=
 =?us-ascii?Q?jnCllIr8id5fOlULZtwTVM/2HHlPPIeLuP/pzSoQJrLZdoo6I0VWBt77pCLp?=
 =?us-ascii?Q?Q1evsk++plyYAkCf00+a9/ZqW7Ha0S+n2J/yGhp/uVhitX9M/eeuPOsP5MeM?=
 =?us-ascii?Q?XvmnRwWComz4fg13FpchHwkP4aVMVJHS/WDXjnc0HM4AHIZBwbSkiHnGM7eu?=
 =?us-ascii?Q?PiWkQoMHcXbobMdXaq+zI2RS9QZy2lByzBfpfJegKNHMU+60mew4NKUglqmj?=
 =?us-ascii?Q?W1xndLrLLj/3lOAW4Ia3G4V1+ul9F5pOYqYlZKmmHEg/ERerkPJSRvLMtmBk?=
 =?us-ascii?Q?ZBsgF15rz1OArqWDQ8Q181239bs06gOtOusOV249SRRkfdpjz3UOp37OSq1p?=
 =?us-ascii?Q?UYG2pYOnHbLweOarb/u6UhBeeRprbnmKJBAo+141?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc8b18e1-8a6a-4301-f21c-08ddc60d6deb
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 15:11:53.8709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cVgD02xbVcFa97Hd5nZbmCIeCiVT049O7/uHphwez/k7USjv+JUJymNNElsxuWx6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7300

On 17 Jul 2025, at 9:18, wang lian wrote:

> To ensure only the current test is skipped on permission failure, instead
> of terminating the entire test binary.
>
> Signed-off-by: wang lian <lianux.mm@gmail.com>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> ---
>  tools/testing/selftests/mm/guard-regions.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi

