Return-Path: <linux-kernel+bounces-839891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B288BB2AA7
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 09:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A37A71925231
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 07:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8A02882A6;
	Thu,  2 Oct 2025 07:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C5wZT1gW"
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010066.outbound.protection.outlook.com [52.101.201.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E78D2571B8
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 07:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759389233; cv=fail; b=Bf48jYi9lR+wbziZRNYkBEMT4gVxghxO1FUF65kZS1/JznG1d0IKVLOquWNbk095UH5JqvOj0iNyn7giA1uXzDFJ6ZGxwD+NlYXLs8VmuhxByGO4k9ZR+MajY/CsBOgyxvfKfQii5B771IDnlBJcBDMrhQvSpVJsEZ+i4rAy0Co=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759389233; c=relaxed/simple;
	bh=/qSRievyIhPVCkKmKxKk/omoXhniiRXrEf6zuSg78q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HScoe75NAyiWghfINFhOMHzLsiumnWQDsRkBO1KE5/ryzp6lr5RSF7JCRAA4AmTJvkQ86Cog0YicWNiQRM/yI3hDk3sZOIBTXvSBlmfQg2CJqtzjWOudk1nNxK0km51yhpkUoQ1uTlXCtPKTJHNCTHu2nLTIChPGsC/hMmSpHZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C5wZT1gW; arc=fail smtp.client-ip=52.101.201.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZID/tdOheqRGjNp765beG4C7Umod3c3l9IzbqhTj0A33PijwRIKlXToihAyb7j1g+AeUKC2JSVy6qQZ8Q/12XzQJJMx6Jo2Eo2st5dZWGvgjRzfFQ7L9tHv7VvJAq+7TYSbRWZ62I8qkAVQcvluVbZhbJYpJBMat/3s2Bd2k8x1hcnwu1SfGKlkXIc7cc/1N6gkOZM3ccYfSRP3j7eexMCPNPMX3j3dhQyILAlnrV6Sn7vvSdqPsO7eJNhGOH91yp3toU3B0gddu5QIrojBbtmZghGkfjLyRQ6a+pkAARR19twFG7Bld5a+S+mr/1A+xS+3BJR01oBaepNoFUmHFMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GgCE4veA7TnU0NsJTD8JH1b40WRPc6a/GTDf0DmXViA=;
 b=dU6taFfEGfmYd6LdVzSZ2NBB7atohdCIstIZUyULokOAoMEQMR802Fl3uyWKo8llcAjCPzB69qC/moebJqopW5yx+Ko0dEV0Gsu6UnjLnh6CU6+yor5gK1vKejdLRc9L/7b+dTEI6lJh2kBk6H032a8ZrvfBuswuMKRIrHDSbkMpOveuf08u1XGBcrEz3TLbHuOcRvFjZai15mPOdPl/iwsAqfUrwf8xf06GfSsZaijm8UoGwKH9sj7P93rVtcEQpEU5+D9Oo7vfuioYjlI+pOcJSLR3VNwcwWWFVvyIsYMPHkvTPaids0OgDzl6u3rjAMZlhvSDsE1ONgvXECdqIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GgCE4veA7TnU0NsJTD8JH1b40WRPc6a/GTDf0DmXViA=;
 b=C5wZT1gWL7mdygfOoCYToE9GSVlvxapQSilZP2O4Z/59+4ToXhxqRWPUTtTd+1t828Q84WG/13mw7hg08/oAb62bZuK5M7fm38NFdrhGLWPSaWxQ8uFt7hK7eYbp/KqGfv4WWg6JdKeH7ETb8Ji8csgJVHUXXAWFM4yl4Opt9pCVSjWDlrW8Ej2JQ3NiHeWRK9GpaZTb8mzmU6+ikmAPT8zzmMnDferrcB/opdWM94QkNCNyoM3F8vp/jtF7wg/Vor6qLPKXztf9cxh4xJkB3idBjbaxsuEBsO8ELzErzs01OUTtJRTrcG6C/u/uBQzT69zqzp7FdSZI3k4WHxl2zw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MW4PR12MB7192.namprd12.prod.outlook.com (2603:10b6:303:22a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Thu, 2 Oct
 2025 07:13:46 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9160.017; Thu, 2 Oct 2025
 07:13:45 +0000
Date: Thu, 2 Oct 2025 09:13:35 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Ryan Newton <rrnewton@gmail.com>
Cc: linux-kernel@vger.kernel.org, tj@kernel.org, newton@meta.com
Subject: Re: [PATCH 1/3] sched_ext: Add lockless peek operation for DSQs
Message-ID: <aN4mH-t8xISo6uKr@gpd4>
References: <20251002025722.3420916-1-rrnewton@gmail.com>
 <20251002025722.3420916-2-rrnewton@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251002025722.3420916-2-rrnewton@gmail.com>
X-ClientProxiedBy: MI0P293CA0014.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::14) To DS2PR12MB9615.namprd12.prod.outlook.com
 (2603:10b6:8:275::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MW4PR12MB7192:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a75f19b-b6ff-4f95-57e1-08de01833964
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZShkjyzZ8mMo5/Z47b6agnC1k5otGohW4ejZ578JLO8KwMIk0wkmQfTZJmXj?=
 =?us-ascii?Q?Sy3JQCLddDwtQuSpo8qXvyWSALulH71GKJ7nBSpQlKnLeM41yJhl1LKPTvfG?=
 =?us-ascii?Q?bpY15A3VIthVLNxwX/NTLgXM27p0fOKlk+bDxvTsWniDgp4WD+d10GuYj77L?=
 =?us-ascii?Q?PHt1OH1AoUbOrjZ/DfIG1ojkTsCs4eWWmtjcMTrUosw6B72juDCXl2d99xRv?=
 =?us-ascii?Q?yX5bo0hHH8J0I+RAN3O145n6yY1u9Sxo19od+MoJEUPhVMwLYh1xRsQjH8au?=
 =?us-ascii?Q?y9ECTYJdId3kN8Fa/DEvSUaXXZh4LMUeT252Pj40aZv0gokIOaDS0/ic4h3x?=
 =?us-ascii?Q?c8JluvWrXH2mVa3d8K9rwT5siGjxmRbeWdJKlRmkHPYPl3scKTBf2nI1hOKL?=
 =?us-ascii?Q?m5sdSX9OUz0IqAIzDwYwE5yAvFyKRKtWu9VQGf7Cg3AywtzAUxNeGtaH4VWh?=
 =?us-ascii?Q?2c0lpIlH0VN19P8Ckd/xHcAFXXSAlWg05wd31sHciYpC6NUICClOZLLLIS7r?=
 =?us-ascii?Q?w+nbKDYVqbCGfN1pneBKNwrPfj/kuE/YUjuy2laeXaZWJgUAgh4qLYFjQhlq?=
 =?us-ascii?Q?2wywZpOb1UDt0y7f7g9/tz5MqDvi7ZR1Bfgp5OcFi0NIMRqKmEBXad9AtXnt?=
 =?us-ascii?Q?wJ8DYEAn2tV7kJkBaCHW2UVhNZK8fl6SGuH9WASF4Afbkh5mDnLuJ7xk5j8U?=
 =?us-ascii?Q?s/QZbsfu9GpPfxSkYGKR9YRxjQI0lDyOSughfXc8ZVKQ7z2eJ41DFyhQR3vM?=
 =?us-ascii?Q?TAi2BM/d2vsHb75CM64XeSEgcy972FmQ7BNlo0iasmxVZW6eZHZJ81AweQaa?=
 =?us-ascii?Q?z8yZIN6rMn7c/jcRW7aa88/gYWH2a1UpdInx+XfgzgZooUC6owNuf6uQ38wF?=
 =?us-ascii?Q?3aLnTf6RhZcd2c5Uv8T08On7dMNxEsr2+saJtWrQ3OxALt1EJjD8vVz0AVLP?=
 =?us-ascii?Q?JtzWKk48m7R5Lv1b3wYeB2EUHti8InR71LwNcAmsqOW6uBHA+7g0dzcYeX4U?=
 =?us-ascii?Q?cN1M6TzIfU6558PBDgvQ5/A34/nwhH6wzPtD4PWuElAK2SujmIiPBdef8ybZ?=
 =?us-ascii?Q?LoC3SH3QDPCrOAK52lvbOG8JPJ5CmTdT39Vpp3b2PYiBixvFEI4bArceuT/k?=
 =?us-ascii?Q?sREaaXBJKrSvXs80jYKIV6AFaPKhmch5TCbkiLVwFqhQT0TMUdbOu+ODsbkP?=
 =?us-ascii?Q?x91tQqzz8lveGUYaOT0VHVgWNvXSeiE69ic/WJnec8XEbVtdVKlJGatx4pxv?=
 =?us-ascii?Q?hsjoKYZ1PJl0ZxJ/7y0wWP1pKRJUpC3Hjf5sdHQRB9OFQqHOWiZvaVu+bM8C?=
 =?us-ascii?Q?+Efc4ijQymKGFgX1b7mtiY6YN9bKy5h/gMmItKCJ3NodpSraoozrz63nLpd7?=
 =?us-ascii?Q?lfQoS2gqptRnffvhMATRfteiYFldPN6gPNgdYOCbVvyC46yKGA0TbeUV9u80?=
 =?us-ascii?Q?ClusY0R9Zp7Icbluhh/AC3TJuYvaWudR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IuExQkX4VLMozY5H4vIDdEo8EWwAxXJsEmXFed51FxmLiupyFOi1wDX8Ks4i?=
 =?us-ascii?Q?FWvpOS0kH+LNYEzenatyKHL35tSK1CxVzo7GybjNlCrZYDJ7TSfQz7WUxILY?=
 =?us-ascii?Q?ybbxGB3Vc0zX7sMtFPOSYVydfYkfViy6Rh9XhaziS90Cyq7PD3CGErqtCdyy?=
 =?us-ascii?Q?2cWHvKF+yOAIuikFWqnuAZJnVoquDnICrNyV8LFSzMbipgElzwuparZ2OMf4?=
 =?us-ascii?Q?U3no45fznOeffBsL6gaf725veyMEMaxPDW/dnlosCrws383w7/iEzCz9FnrJ?=
 =?us-ascii?Q?7syK57rZQZ6u+ZlF5Qp5mFi+WTUUFrIcE09UpgWMb5fwe8PZcc04Hf97jsrT?=
 =?us-ascii?Q?2+kh/sv+hPT6H1HbvnwkgFLXL94PzTqzIEKRlsERMaaF2WQ+sjVFa7HDEyMs?=
 =?us-ascii?Q?eLl6gIGav7WPzf7u8trsZdNKm1puqJP+43DXPUUKL5lHIleLHT+TZIsCaclN?=
 =?us-ascii?Q?jJ9gDW4Kq5OiNXtqGgbcomYqyOpRjDtr17vLipUORJD2R1Pki1PMK5HUAt6+?=
 =?us-ascii?Q?BtTeYb+bdAWQPEM+7N2ehRgkmd+5NwjhaMAnb+oUZxpkpaV5J934hEot9ciN?=
 =?us-ascii?Q?0UEuoS6lj6RaJNSQQ3aF4WQ/u70tFMtDdHTZCYnjlNZpxQE/NlyVbnqhEUPI?=
 =?us-ascii?Q?MUFSaWLuu5BzoThR6YR+T1eYWTtQMaO4bpf5ECSzkowLmjxyPUOkOV1kd+q4?=
 =?us-ascii?Q?qle2giagvi32OLVb81T5B5LTbLZ7GmGuYIj8FXFQC66otvo0FgdzzEVOLLcg?=
 =?us-ascii?Q?BeUoHNo2dS/ZquGU3OSJbR8x1nuhItQ4LnJBPVn3ICKheDEEGEGHn+6+9RDy?=
 =?us-ascii?Q?g5uqXW9cnuGITBr1N2YDy32NapHN7FN7sdpRxBjXL+G1BoaxUMN3ZjV31ZG7?=
 =?us-ascii?Q?ajfEtLSBNQpBtBTTLE6YO09EI0GXSGy4dTfcMUpqurlgqnybW0H6h/mpfaQr?=
 =?us-ascii?Q?9wYqW1MyKSKzdw7eEXrzQbkzIv1am8Uk+V5o9k7w3eIXFBVVAq8PqGya+6RU?=
 =?us-ascii?Q?AZzaH/wT1PypKLPBjwgCmr82KtG95Z0YBs55EHvs3XxZ9GCdyc4iNJOMIFCS?=
 =?us-ascii?Q?pHDbKJHoH3fQd8GcDiO9MpwJqipPvnm1KRo4TBYQA1e9ZuKjcP3AWJSn/4Eb?=
 =?us-ascii?Q?lkOV8sg2ekZfxHrRJUQbejMeAUAYQzPJ3qpPnktjz5Qd/kOYu/jYsOHJUq/Z?=
 =?us-ascii?Q?NCTmmXswAFWTcJ11Q/tb8XgNTu8jK2RBb0n5T5UMIadBW1Nn4qoHeDdeMXam?=
 =?us-ascii?Q?ZOiSVy6PheVBfoXuMIW+KauVcXC+Xlijp1a7NHp4TlsOUB48UV2KCWAEmy4E?=
 =?us-ascii?Q?7fG4fpyLgzR9BmL4jOCrQnTYRIdinBtUjXAl/wT5bV8fdSYpwfrH4rUBDnoL?=
 =?us-ascii?Q?Uyk5t4qwqNC5rMAYvlSSqbbjXYV2tsbocVGWKSftp1x6Pu8LkOE1Tjb2WqEa?=
 =?us-ascii?Q?ipqVOy7vtwxBNxbLkpOSJgBuBTiGa8IX3EaNMlOCqma8PGcGX5M576ryYYIy?=
 =?us-ascii?Q?0OexZqR0b4UXTBma0kOYFUzDFtTHCkmOJ0f8vvbpOQtvmWDs3x0NhvDXa18C?=
 =?us-ascii?Q?NxOOoH1QGgawd2AZH+gemQ9TRxYc4plaOimm/q6I?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a75f19b-b6ff-4f95-57e1-08de01833964
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9615.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 07:13:45.7162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MSNUkt5U13Ix47dNEZmpxe+JyVMQW+ZmA6EDkN4ge/6NcGL3sxGX2oMNnx1Xw65LmaOAl+Hr4rGk+Bw0EXk4Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7192

Hi Ryan,

On Wed, Oct 01, 2025 at 10:57:19PM -0400, Ryan Newton wrote:
> From: Ryan Newton <newton@meta.com>
> 
> The builtin DSQ queue data structures are meant to be used by a wide
> range of different sched_ext schedulers with different demands on these
> data structures. They might be per-cpu with low-contention, or
> high-contention shared queues. Unfortunately, DSQs have a coarse-grained
> lock around the whole data structure. Without going all the way to a
> lock-free, more scalable implementation, a small step we can take to
> reduce lock contention is to allow a lockless, small-fixed-cost peek at
> the head of the queue.
> 
> This change allows certain custom SCX schedulers to cheaply peek at
> queues, e.g. during load balancing, before locking them. But it
> represents a few extra memory operations to update the pointer each
> time the DSQ is modified, including a memory barrier on ARM so the write
> appears correctly ordered.
> 
> This commit adds a first_task pointer field which is updated
> atomically when the DSQ is modified, and allows any thread to peek at
> the head of the queue without holding the lock.
> 
> Signed-off-by: Ryan Newton <newton@meta.com>
> ---
>  include/linux/sched/ext.h                |  1 +
>  kernel/sched/ext.c                       | 37 ++++++++++++++++++++++++
>  tools/sched_ext/include/scx/common.bpf.h |  1 +
>  tools/sched_ext/include/scx/compat.bpf.h | 19 ++++++++++++
>  4 files changed, 58 insertions(+)
> 
> diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
> index d82b7a9b0658..81478d4ae782 100644
> --- a/include/linux/sched/ext.h
> +++ b/include/linux/sched/ext.h
> @@ -58,6 +58,7 @@ enum scx_dsq_id_flags {
>   */
>  struct scx_dispatch_q {
>  	raw_spinlock_t		lock;
> +	struct task_struct __rcu *first_task; /* lockless peek at head */
>  	struct list_head	list;	/* tasks in dispatch order */
>  	struct rb_root		priq;	/* used to order by p->scx.dsq_vtime */
>  	u32			nr;
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 2b0e88206d07..fd0121c03311 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -885,6 +885,15 @@ static void refill_task_slice_dfl(struct scx_sched *sch, struct task_struct *p)
>  	__scx_add_event(sch, SCX_EV_REFILL_SLICE_DFL, 1);
>  }
>  
> +/* while holding dsq->lock */
> +static void dsq_update_first_task(struct scx_dispatch_q *dsq)
> +{
> +	struct task_struct *first_task;
> +
> +	first_task = nldsq_next_task(dsq, NULL, false);

This requires holding dsq->lock, but...

> +	rcu_assign_pointer(dsq->first_task, first_task);
> +}
> +
>  static void dispatch_enqueue(struct scx_sched *sch, struct scx_dispatch_q *dsq,
>  			     struct task_struct *p, u64 enq_flags)
>  {
> @@ -959,6 +968,9 @@ static void dispatch_enqueue(struct scx_sched *sch, struct scx_dispatch_q *dsq,
>  			list_add_tail(&p->scx.dsq_list.node, &dsq->list);
>  	}
>  
> +	/* even the add_tail code path may have changed the first element */
> +	dsq_update_first_task(dsq);

...we're not holding dsq->lock here when dsq->id == SCX_DSQ_LOCAL.

This seems to be fixed in PATCH 2/3, so I'd suggest squashing that change
into this one to avoid triggering lockdep warnings during bisect.

Moreover, I think splitting them doesn't add much value for the review, so
merging both makes more sense to me.

> +
>  	/* seq records the order tasks are queued, used by BPF DSQ iterator */
>  	dsq->seq++;
>  	p->scx.dsq_seq = dsq->seq;
> @@ -1013,6 +1025,7 @@ static void task_unlink_from_dsq(struct task_struct *p,
>  
>  	list_del_init(&p->scx.dsq_list.node);
>  	dsq_mod_nr(dsq, -1);
> +	dsq_update_first_task(dsq);
>  }
>  
>  static void dispatch_dequeue(struct rq *rq, struct task_struct *p)
> @@ -6084,6 +6097,29 @@ __bpf_kfunc void bpf_iter_scx_dsq_destroy(struct bpf_iter_scx_dsq *it)
>  	kit->dsq = NULL;
>  }
>  
> +/**
> + * scx_bpf_dsq_peek - Lockless peek at the first element.
> + * @dsq_id: DSQ to examine.
> + *
> + * Read the first element in the DSQ. This is semantically equivalent to using
> + * the DSQ iterator, but is lockfree.
> + *
> + * Returns the pointer, or uses ERR_PTR() to encode an error as the pointer.
> + */
> +__bpf_kfunc struct task_struct *scx_bpf_dsq_peek(u64 dsq_id)
> +{
> +	struct scx_sched *sch;
> +	struct scx_dispatch_q *dsq;
> +
> +	/* KF_RCU_PROTECTED means no need to guard(rcu)() */

I think this comment can be dropped, the meaning should already be clear
from the KF_RCU_PROTECTED annotation.

> +	sch = rcu_dereference(scx_root);
> +
> +	if (unlikely(!sch))
> +		return ERR_PTR(-ENODEV);

I'm wondering if we should just return NULL here, to simplify error
handling in the caller. In this way we just need to check for (p != NULL),
instead of (p != NULL) && !IS_ERR(p).

> +	dsq = find_user_dsq(sch, dsq_id);

Hm.. let's do something like this:

if (unlikely(!dsq)) {
	scx_error(sch, "non-existent DSQ ID 0x%016llx", dsq_id);
	return NULL;
}

or bad things can happen. :)

This also implies that scx_bpf_dsq_peek() works only with user DSQs and
will always return NULL for built-in DSQs.

So, what about adding also:

if (unlikely((dsq_id & SCX_DSQ_FLAG_BUILTIN))) {
	scx_error(sch, "invalid DSQ ID 0x%016llx (only user DSQs allowed)", dsq_id);
	return NULL;
}

I think this would be a reasonable requirement. Typically once a task is
queued to a built-in DSQ (e.g., SCX_DSQ_LOCAL[_ON]), it is effectively
considered dispatched, so peeking at its state is rarely needed.

This would also allows us to get rid of updating the first_task pointer
with built-in DSQs, saving some memory ops in the hot paths.

> +	return rcu_dereference(dsq->first_task);
> +}
> +
>  __bpf_kfunc_end_defs();
>  
>  static s32 __bstr_format(struct scx_sched *sch, u64 *data_buf, char *line_buf,
> @@ -6641,6 +6677,7 @@ BTF_KFUNCS_START(scx_kfunc_ids_any)
>  BTF_ID_FLAGS(func, scx_bpf_kick_cpu)
>  BTF_ID_FLAGS(func, scx_bpf_dsq_nr_queued)
>  BTF_ID_FLAGS(func, scx_bpf_destroy_dsq)
> +BTF_ID_FLAGS(func, scx_bpf_dsq_peek, KF_RCU_PROTECTED | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_iter_scx_dsq_new, KF_ITER_NEW | KF_RCU_PROTECTED)
>  BTF_ID_FLAGS(func, bpf_iter_scx_dsq_next, KF_ITER_NEXT | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_iter_scx_dsq_destroy, KF_ITER_DESTROY)
> diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
> index 06e2551033cb..fbf3e7f9526c 100644
> --- a/tools/sched_ext/include/scx/common.bpf.h
> +++ b/tools/sched_ext/include/scx/common.bpf.h
> @@ -75,6 +75,7 @@ u32 scx_bpf_reenqueue_local(void) __ksym;
>  void scx_bpf_kick_cpu(s32 cpu, u64 flags) __ksym;
>  s32 scx_bpf_dsq_nr_queued(u64 dsq_id) __ksym;
>  void scx_bpf_destroy_dsq(u64 dsq_id) __ksym;
> +struct task_struct *scx_bpf_dsq_peek(u64 dsq_id) __ksym __weak;
>  int bpf_iter_scx_dsq_new(struct bpf_iter_scx_dsq *it, u64 dsq_id, u64 flags) __ksym __weak;
>  struct task_struct *bpf_iter_scx_dsq_next(struct bpf_iter_scx_dsq *it) __ksym __weak;
>  void bpf_iter_scx_dsq_destroy(struct bpf_iter_scx_dsq *it) __ksym __weak;
> diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
> index dd9144624dc9..0af1922d66a8 100644
> --- a/tools/sched_ext/include/scx/compat.bpf.h
> +++ b/tools/sched_ext/include/scx/compat.bpf.h
> @@ -130,6 +130,25 @@ int bpf_cpumask_populate(struct cpumask *dst, void *src, size_t src__sz) __ksym
>  	false;									\
>  })
>  
> +
> +/*
> + * v6.19: Introduce lockless peek API for user DSQs.
> + *
> + * Preserve the following macro until v6.20.

Usually we keep the __COMPAT_*() helpers for 2 major kernel versions, maybe
let's bump this to v6.21.

> + */
> +static inline struct task_struct *__COMPAT_scx_bpf_dsq_peek(u64 dsq_id)
> +{
> +	struct task_struct *p = NULL;
> +	struct bpf_iter_scx_dsq it;
> +
> +	if (bpf_ksym_exists(scx_bpf_dsq_peek))
> +		return scx_bpf_dsq_peek(dsq_id);
> +	if (!bpf_iter_scx_dsq_new(&it, dsq_id, 0))
> +		p = bpf_iter_scx_dsq_next(&it);
> +	bpf_iter_scx_dsq_destroy(&it);
> +	return p;
> +}
> +
>  /**
>   * __COMPAT_is_enq_cpu_selected - Test if SCX_ENQ_CPU_SELECTED is on
>   * in a compatible way. We will preserve this __COMPAT helper until v6.16.
> -- 
> 2.51.0
> 

Thanks,
-Andrea

