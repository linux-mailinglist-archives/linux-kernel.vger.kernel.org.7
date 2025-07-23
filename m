Return-Path: <linux-kernel+bounces-742676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF94FB0F53D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 16:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1CA0AC0FE0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 14:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739B219CC3D;
	Wed, 23 Jul 2025 14:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D6EHIOEF"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDD62F2C45
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 14:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753280761; cv=fail; b=ryhdUuxx3DZDRsx755botFgbmaU64qcp29HL6PYCZZenuVopuR0ZjOa+Tyz2ePeg/ZYvtKDYtzJDqCfWl5tbydlCVrfH+Nh7J+Sr9losgXfxhUL7e508t0DvW0NyINekqae7SFG1i+auN/5yjgoLiqNILTBFyD9DbcXPMhM6FV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753280761; c=relaxed/simple;
	bh=b+quB1J7kTOkmUvEOGMDhqYwFNotSlXxFPqctf3WKL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rlPeGUsNFBbpnlZu6arhDOk9ykmMOC8cQWNpjd2oWSJ4/f5gs3Utnahn04HGPcCfWn0fMOP7W5eRAtDpNGKzJ4NP1zTgsSsr3PvEZO8r6GIypa7usCHL1Y7xz6i07JCco/bGRhKcqz9OaflxDh3WXn/9ZR8cGFCykltXRIwWewg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D6EHIOEF; arc=fail smtp.client-ip=40.107.220.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wLR6somp83MDgbo+M6+VKbbHtx9+IbA0Z6LsxGagXIVFR2CwqxhWkJYYu5HGDG9yXbKx7L3MYCfBpKxxGFwlGbx2srlyTzVha8acK2BnMty+MaKZNGBk2rL9hWewJxXOvxd8AyfP7APs5EJLwMWGeg7Sqc+9CknH91laTwBzx2qn92NqZXfyrRYNlk3D9YAQ12s4GlS1zbvDkPjW1+Zps/K/Q575zVXGLPIAGH/LAfSCsN/kh4YsZB+XPtrbd+jMg6NLHk4NzqRwEz4M5vGAWd4H8xn5pLdQf8KSCzAztBpeWEIH+ptuLI4xh8tWTGHW1uSy8INH59Ru5aD6Z7sS1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xggzz74VhrGJVZh212xhWqbyvpgt7mcbG1OonLM7cXQ=;
 b=nmo6iOWG5UOm5blrYSw//pglmI2CVjEX4fsdkaquEGU05pgJVvWXc+TmeiD0/KhOzUzk43B/NLFesuslpNMSeuIP98OWoLdshA9o5ayLFsl7KXEskvJFrXF7WT8AAQMQMuNfwqJ/iA2HOoRvbAv8vzpFL7zMPmwAzJwz298phqJIrXT0shyB3+uX0RuMF7B/jymNXEg2ihICA79/lwvhSgT2JqUSZLSE/pMUJuRm7pTmJiiX+AbCTFbsxkTcGMLXziyxTu56MvPo7sFpTrzPZMD5+zT4JDxe1dsUbBsgL3ZztgUGs6atuJYBYjl9t8Xuij93jK5/wP/exA+8/XdaaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xggzz74VhrGJVZh212xhWqbyvpgt7mcbG1OonLM7cXQ=;
 b=D6EHIOEFHDY0cngeVAjl9bwWaRubDuWOy4Hk0pQ49iFVhPml25Rh8Ysc8ytw8kqH0jy6BWeSrB7X1uSk2M4S3qngJn4/JY5r6J7MTC8bAKYTeUxStOGi5AsfwlNogzYv/+31m72O73Uz5DGTH6PGIjoR66KH8pN7pdnhYX0lrJBHu+52A/ZKNTDnMJSJFLSD4EYopkB8/728P/9Y+v2K/IO2JYCHGhElni0709DE9/gXIhjQfOzGE/Dnz49o6RoBq2qYypjonueQiWfMkmIPkf+d8yA1UCoqR4Ww0VPVgWCCyv97eM8lyeOP79z++UUkB2BNjfOKq44mLjlC8C1b6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DM4PR12MB8560.namprd12.prod.outlook.com (2603:10b6:8:189::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.21; Wed, 23 Jul 2025 14:25:56 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8922.037; Wed, 23 Jul 2025
 14:25:56 +0000
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
Subject: Re: [PATCH v5 2/7] mm: Optimize mprotect() for MM_CP_PROT_NUMA by
 batch-skipping PTEs
Date: Wed, 23 Jul 2025 10:25:52 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <463ADA54-E6CB-4B63-B306-E108E303F07C@nvidia.com>
In-Reply-To: <20250718090244.21092-3-dev.jain@arm.com>
References: <20250718090244.21092-1-dev.jain@arm.com>
 <20250718090244.21092-3-dev.jain@arm.com>
Content-Type: text/plain
X-ClientProxiedBy: SN6PR2101CA0003.namprd21.prod.outlook.com
 (2603:10b6:805:106::13) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DM4PR12MB8560:EE_
X-MS-Office365-Filtering-Correlation-Id: 156169fe-4baf-4605-4e8a-08ddc9f4d682
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ORzCh3/NHfcCWOUnRC5ZTcar5QIURRRxPgWidXEyjAwpagxBhKXYhNftGUuM?=
 =?us-ascii?Q?R+Or/8QrjMYwaRiAgedeUKrmOA0HU407Ee0POuwrKn0jfubMbyZz4q4AzkuO?=
 =?us-ascii?Q?WT5Inmnw/Xz/QG3kZr9KXXNbk6xLgjpHDE39UYz9g/txiA4C4aEHZdtZKILI?=
 =?us-ascii?Q?fviaQbb92uMJ/gJt+gH8B3RRYbUqjzjshYbduJdYjcH6XBHHV5hBMa1b6uQY?=
 =?us-ascii?Q?8oM0WQdlj6VZ798bpkGTXiAk37mTM5NNl4gVQ+sQMV6pUZ+1OCD7VhUEZZIw?=
 =?us-ascii?Q?VKpzl5l/l07Mes05bKOKnWBiPBJLH3o6+4VXiLsEQ7XQvZ/1esSWuwDdN4TC?=
 =?us-ascii?Q?mr7rDRZCWHWjWO9X4vKyvazeCxxuXwx2Z7jyUXLB8m+w4RMMQ4JK74jqf73J?=
 =?us-ascii?Q?w+DsdKzOhzfxHvhqMmTneuaUQVF0xM4uUU0wMWwGRHiOb0xWqluQtVq3G6bv?=
 =?us-ascii?Q?bInc5KjnYXgRMGp/00lxrBJbWA9vAuAVNAb0G2Koo5BbDQmqzUAviku+3wfg?=
 =?us-ascii?Q?1sL1axqJ4qO2MnBUtVjPdm6sguXdLf2zDBsFsEj57FXw9Y3qmzJCTy4TolCe?=
 =?us-ascii?Q?Hs88hDIbNE7ktiJxT7dLXuz5fxt770D9yNuSyE3H8xZT6SMyXpxQaANJdei+?=
 =?us-ascii?Q?w2r4E92uS9BCP8ziqbxjux//O0Jjkal5jOu0c1W4ljsWWtpRFkEvxzlMo1q1?=
 =?us-ascii?Q?ce0OK4zX/MVIrdYoFZPhCwaf/p8r4eFLStpdAs807TNpPZBH0F8yvs24wSIN?=
 =?us-ascii?Q?nxcRdP2n4WGhs54NUZOfHc0cQ+cfvFfPfLZwKnvEvsgGQIMZzCykQXrJVuUF?=
 =?us-ascii?Q?1sdJkKgoDUMKNmmVNHu17R3Iy/t6hfQ7l0UgCVCDlF9gE9Qt+7zAFavXw52P?=
 =?us-ascii?Q?0tLTyNu8wU//btsFVEZ638uj8NN1mnBqPjnBsyPPLbhafOFcuyqRwLqLTqWJ?=
 =?us-ascii?Q?0McdVTZITM8C0lYh0OUrdOd/WA/sOlS8tvrBZivNmtRR7v+cTIM/h4tHibss?=
 =?us-ascii?Q?896dA/h5nXSYNCDZwy4eK7ULay54OZqwSqGwReMb8mj4EVfswcCTfbETlYYu?=
 =?us-ascii?Q?kFyMqjfUyizjtLUQAvKt5QFPEehYq8QXs5gJb7vwVUUUykyp7YSU/h7VHFQy?=
 =?us-ascii?Q?yt/pkqGe3PTm1wdxTsilqQQ+/8XOdn6zfbtaBmj1vA59zpM9y3ubghqhPQ+w?=
 =?us-ascii?Q?PDDdyRmSYiuc2of/+xR6L5ng2eOFAYqVyxbyBhuqagN5mH2JBDW8ZS6/08jS?=
 =?us-ascii?Q?CSsdDRvKhlLt01IulrJaYT6NlP+Be/42MVhbMsW8XhRu0smERjMcnx+V9d0+?=
 =?us-ascii?Q?pUcJaVFufXbVrQvktOk1xX1yiXUrVnYVUxgRkTnFVzbx/Z1NwvP3ohQXQ6ch?=
 =?us-ascii?Q?I45K3H7KPN1OhFR/OXOmEG/iBkwG786XSWPLLql5PPvO3rTdlw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lXj+s4SJ1PpVPUhL2s2FpSJNDGcBCyst3CxzmMo1Oedjbusu3ocVA2xGREtT?=
 =?us-ascii?Q?ua7kq4cvKgwR6kJWl5njU6H+LmhaShFRP0SzySjLLgy8wYuK63/ORaUoxQnB?=
 =?us-ascii?Q?gvb8ti3RI6iLu8Kd+hoPEzny/8F9sRIXMUbKjEIYrvf9dYYNUxI7JrRSztgC?=
 =?us-ascii?Q?ESkef/t3Di81lDuZjsROjloP7iBqWDnX49DhkO7t0IvI/OCRCLTZl4IiPFsB?=
 =?us-ascii?Q?aU40nmg9tidAp2Z4Kg9zz/zrrJY5011S4/1SySYH+zd1pbUidSZzlB1dHwUs?=
 =?us-ascii?Q?XpUu73sckmFUkmI3GBUBnsq6YBJ0sm+pQkziMZX7IGPrwrGo5CIdb7PAZ5xJ?=
 =?us-ascii?Q?rymkReSJWp57p4wERg9psEYUTtnK/I06mHm4jrpobmQl7ixlJolxHF3tDw4H?=
 =?us-ascii?Q?pzaFc/R8usQvxt9cJLsTLNDe5at+maMmdqBOT2TkOU6VP9HH0bwwIKXv+ICh?=
 =?us-ascii?Q?ZI+wZLz6wyjfyr+ajg3Um4l9rtmgbWLHUTM/BqyICpFUWw0wEVJMMkCpM5Tk?=
 =?us-ascii?Q?xYKd10B+2EC2ya6LEQ4LQU9WSl72B81k0IPjWpMhSlym7PJi62TLxeE67nnl?=
 =?us-ascii?Q?hRgpiSsbnxSCD/ofMZfrriGdU1wanYyyF14ydYQ9lJHItRMrVYT/K+h4OPfb?=
 =?us-ascii?Q?kzHE5Y45dUlCStDnUCBDyQHdHFNU+srBDCXmIxmL3l62ziph8qEtJZ0A7FGx?=
 =?us-ascii?Q?YVHlmkFpZe6Eeyo7F91JCM9AwJLURmI1tBK4URV6GSttgm1jRYWnejSyAa3c?=
 =?us-ascii?Q?aKQ8CZbZ759YnMyEy2ClhsDigLS9/lpV28YTFj5IgMpclK1XlOTSB5+ezRvd?=
 =?us-ascii?Q?H5B809lwjulGTA1vZwMUEA5i/+kluDBEyTqfBBNa9+h1EZko8KFqzIurLAev?=
 =?us-ascii?Q?u+LX5gxhXJnjcNRVaIRd2PKuuONyqVy9RKDIvIsPIQQlcgNiM1Hi1zXFP4LU?=
 =?us-ascii?Q?89ALI70OqwvgdDWvsX58y0YsvFuD5BmNHUPQ/MSs9hdHxQREK/iZTscgvV6U?=
 =?us-ascii?Q?wzZAH1EIogQj909UAanWg9431ywtpKZ5TA+yXYO1lmGgLbuntd5aMiRiEqid?=
 =?us-ascii?Q?dU7h6WNGQuQQHHlWxs/kn2VOt+0zayptc0LJOghTOUG5aDGkXRtYGETFl/gs?=
 =?us-ascii?Q?6GW1m9lIynASfO3h3TTkG/eYCeOss4HFI2VLm+cPd3fnrgeR9jMSAsr6tcZ2?=
 =?us-ascii?Q?acAals/4EieKwsY2uv8ii+ARhWkgwQQRmYF4juK3mwXSrGfWaltU/Pvr/Zhm?=
 =?us-ascii?Q?GpbXcKjQnDT27Ry7NAgD6QAIG+pwf8tFn1/hbQ/0S6Vis/tUhJeB2peJGcCD?=
 =?us-ascii?Q?tQq5740Ef4IOFeyNpPOENWbVAzjuj2GZnGasclP1IFz1TtUvtQC8d6/HHIJg?=
 =?us-ascii?Q?pbCCTkO2xAwS/LGwrbS+pHhNpxm/HAXBImbPT1iEWTOPsb3hRAH+WOuzvegW?=
 =?us-ascii?Q?VCIxLuHT886upk+5hRCWyD0Ww93j/f1YUIzO8etLEB/eIq2VvGFh8i+puObO?=
 =?us-ascii?Q?+1vJO/OihxLcpH3XxKfFSGGoItdkkP/ivi2OZrG+t1mr0wXQB1G4x7N+8AkR?=
 =?us-ascii?Q?mrp7bpFfr7M3ezDguGArG5WlguDBjG14XJKYfaQv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 156169fe-4baf-4605-4e8a-08ddc9f4d682
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 14:25:56.5581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YGEudM55H0inIYhY7Kpdmxw2yQOHv8KaIqEAaalfC1/+8MBrYN1bGQZ7GoOnqCFK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8560

On 18 Jul 2025, at 5:02, Dev Jain wrote:

> For the MM_CP_PROT_NUMA skipping case, observe that, if we skip an
> iteration due to the underlying folio satisfying any of the skip
> conditions, then for all subsequent ptes which map the same folio, the
> iteration will be skipped for them too. Therefore, we can optimize
> by using folio_pte_batch() to batch skip the iterations.
>
> Use prot_numa_skip() introduced in the previous patch to determine whether
> we need to skip the iteration. Change its signature to have a double
> pointer to a folio, which will be used by mprotect_folio_pte_batch() to
> determine the number of iterations we can safely skip.
>
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
>  mm/mprotect.c | 55 +++++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 42 insertions(+), 13 deletions(-)
>
LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi

