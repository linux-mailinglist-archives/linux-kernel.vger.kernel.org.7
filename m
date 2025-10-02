Return-Path: <linux-kernel+bounces-839901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B94A1BB2B02
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 09:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78C447B3127
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 07:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F060C2C0F7A;
	Thu,  2 Oct 2025 07:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Epaec5LO"
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011004.outbound.protection.outlook.com [52.101.62.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A95F2C029B
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 07:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759390044; cv=fail; b=VFO0VoCO15Vw+DmEBA1xkUNVmSourlbeb9wCLcJ30XsdYOe7V4DLvwPP9+plDwGAagaqOl4rSxLICQQl3C5OPKgEfi8RaCyohbQSSOMf/Sk9ptRqbHK0KG1afNKnQshVxCMmHdkItWln9YnyWA/d9uQW64veGMWA5u4SHfvZzcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759390044; c=relaxed/simple;
	bh=lxh8nkbFSKl6Urz7CE60zlbotKDuhQjXdKtOjizrwXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oeCgrYfRfm/YN+nuEkYsKC3szglzHd3L2U1sYO/v0dRoMwzZygEHCJ8UWIXNdB51qIwfmV6Zts33kN519lzX67EBRy0rhbdUfZYw0Lg1aB+TgL/M3mkWE8FfmCf5+GRCNd7rQVZ+XGo+nfxMjSExDmgwuaSmtDQkxF8ztGqFiW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Epaec5LO; arc=fail smtp.client-ip=52.101.62.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vclW4rSsc6IM24xmIFvnUm8kC1HGsawgWMPJpGwoYvgww1nKsmW8UfNGta/3Tzm3cyEPiPGRtmY1RfklqCfUto1Im+U96B4/Ud1ajhTixbiBr/jzqshgQ/2AX6PMhp3ZWkMjHKyLFfHvG23lH1ewNGavxaJep8wHvWY51lDTEOZIXKeWByDnZ+qI+ix8XFWi8Lc6oShOm95QfAGbi+2h9Pkd1TxamH4Ub8q3fGxPOjaKqf9UAxQSKu9M39tsHdN3kO1Vy0ldaX5DxuBP898Gd6E7dzsGzamRMX4xSqRQ5s3bNA3sTCnhfiu5nm7W14hUbC9LdlS3EG+D/98PTyjeUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KHFed6gsFpz7n1lx8+XFuec9566DM5+y20+dGSoYj9s=;
 b=H4pPONJCDcLqar71M5mMcteI/UaBtFBeLQgbr55OZ6zxH8+gxozPe+h8njXsbGhQC9E4N77hXTYkwbOIHqxTUQktPXN4fE4OA9r804UNtiUrB3kXckt0sefV6pSHTGJ+fCnIRw44y6dpjjjas4Aq9TP3JAwazXGF8DG68+mZcKRHNGm4MX0XcVtAWS7KxTjtiC+LN1berPWIG1pmuQAtudpJdaCCf/6IcLOG4RdubHUZ2T/s24REhlLX9XAEwp0F2/FTDYGkkQZe2eAqpiXqLR2ayYzGtd6FkuxuXdxpg6GZhZFM/yxn27AlQ0DG1t/8L7WrKhlhxoiLaB2orV8xUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KHFed6gsFpz7n1lx8+XFuec9566DM5+y20+dGSoYj9s=;
 b=Epaec5LObV4c97tYtQc+gcUE/kpQxpXNMuCfw8cyLTLh1Kkflk9egMPmJzF+80N9uae1kkG9yxvShauNllZktPnbY+RqobJJf91bGc84stNe37FfgoKE22CxGICyTgHYyr7Pq155or3vUBeP1tIVboIplZsuYYIcf22dmZjdid5w6sOmK/VBOspy4DErJUQOFKzLZaPYfPwaI9MKMARbsSnVb+RtmsPEoDpYV5JQzSxVdszOUCvnnams0/VXp1cU8SsASoSzFCGCP8C9fxRxZiUN8H//V6ooapEuCkpLvhuu9kMtNSNSxnoVWuzFd9nO9FZ7eg97KfxiikI949qaiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA1PR12MB8743.namprd12.prod.outlook.com (2603:10b6:806:37c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 2 Oct
 2025 07:27:19 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9160.017; Thu, 2 Oct 2025
 07:27:19 +0000
Date: Thu, 2 Oct 2025 09:27:12 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Ryan Newton <rrnewton@gmail.com>
Cc: linux-kernel@vger.kernel.org, tj@kernel.org, newton@meta.com
Subject: Re: [PATCH 2/3] sched_ext: optimize first_task update logic
Message-ID: <aN4pUAfE30rF6-n4@gpd4>
References: <20251002025722.3420916-1-rrnewton@gmail.com>
 <20251002025722.3420916-3-rrnewton@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251002025722.3420916-3-rrnewton@gmail.com>
X-ClientProxiedBy: ZR2P278CA0038.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:47::7) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA1PR12MB8743:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cb483b1-0ce9-4d13-a3d9-08de01851ee3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?itd8vSBdyhIPbaYeinWNci4XZCVfTdB5OoSR0lOsontmFAR5bYHuUqn+xJSX?=
 =?us-ascii?Q?vAYZdPt4G6WgOHm6L9TGS5jQ40/u8kD3J2S38/G38hohYv7FQ4soOGGh9Guw?=
 =?us-ascii?Q?EqmsHYmVcJdLUONQDYbqZlFAKTyQvPb6VAXv0U7we7bm288WQ4QnhJ3A/xq2?=
 =?us-ascii?Q?mrpTuj/D9GWTH3/SKlwN3ylmRfP5Pv8XJQk/WCEg4d8vG1Bo/+qpnIKS8qVR?=
 =?us-ascii?Q?wk9ah1CdjAxxmnv3wz23w9m5wgDuydrvzr2bq2JaImX8gfhSNzuZrFIVNl/r?=
 =?us-ascii?Q?Qqvk3+X33KUla6jQvF6P78TNqpqycR7cYV/UyyYJ5JNpGxNS1uXH6OXm8eYh?=
 =?us-ascii?Q?KkrTmwb9PXw9SihiTADEZsci2HLULPjl7jjQfc8RsaiYXu1bZ7mWge/qBjrD?=
 =?us-ascii?Q?lUvofoRW/TpSZmrhvoUa4J34HPq92fdI7tYDZYZcFy/UDtKZNVAZ0WIU60ZI?=
 =?us-ascii?Q?C5kIddS4wigD/aFgOi8Obmg/Sbo4vL9T8sF4X0V89Voxde+VlxSbpwmbKbAk?=
 =?us-ascii?Q?vCjxl5xRDXsEtdd021uvtO/wNUJ2GUcuOBvAoq+Of8etTjpnLfbr1Pqb5yGf?=
 =?us-ascii?Q?dfm+LYoJsIe4fSuOPNnFHE69Vsh/I/pQ/3S5EA1OF2SH09w6ZjMis6xtgxsu?=
 =?us-ascii?Q?pPixoBxo1kpggtPvFcu1a9xSN/vBboc+cSrpAXF6NsMi8lKAL2UBe17FwMfj?=
 =?us-ascii?Q?unG5/YAsdpl1UusJdXaDK+tgOPkPnQo3tWwxWF/g2o7nTR1PjYfMduEJCmF3?=
 =?us-ascii?Q?LBLlyU340cqiEOPJVlsOWpfrYBA5Ai92Xvr/06ND00BhCaHrpM4sDynBy2Ze?=
 =?us-ascii?Q?fbVUmxK7WkOLBXYqxKYv2HReijWo+obViJ3qeWc9HLgqL3UBK/wycAZPl5KQ?=
 =?us-ascii?Q?FO9mDXjh2Qdhfd5KW44UkvlpWPjCAfx8AeAmsvvfQzk/d+FWJ59SEGSv8i0p?=
 =?us-ascii?Q?ZC+YzpBOwOxwiyfgEXKP9QpgPBqZtXGW7LeVHxuwxoZ6YcjkEM50o/0PD+Xt?=
 =?us-ascii?Q?TGr5Q93D9SiSxFoVeMqaX1smSz7zEh9cFjQhCOOuh31Gg47LIFLqp7cQdrHz?=
 =?us-ascii?Q?IQ/T3OCoXy9vetM1lCSB70Gw3zn2PtvIFe3QLXyXKfK5TV0oxr5V1zLT4MPj?=
 =?us-ascii?Q?Z+J65DaTaXWdrxilH/Bo85EEsLux2nGP9gur2Zwg9WruKYI37nsQhhawD+mJ?=
 =?us-ascii?Q?FH4uDpA8lRwf+TlFyPqfnDclk6Xeh25128QeLTf7gnJ0ru8w+XUum4ZUeANl?=
 =?us-ascii?Q?nKkQqMYuzRmcl/FzWKwcSpkL+y8Tcv8+0whU9/bWpTlJyisOdE4jT8BWY6TK?=
 =?us-ascii?Q?qhfhN8lUTeWi4o4jczXrOkvAivpI5m9QddNdaMEpVk4tIb0xFPDkC127j8Hn?=
 =?us-ascii?Q?zhkEXxN+JNfEvF90sndAAk8sMoloaNUhgQIKBVPp4Cxo70OGvsfLIRqIHifX?=
 =?us-ascii?Q?iHi0aMqt4NHDF1n64YvpVPyiuB2UKenv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eSd/r3xP5fpekD+JX7/EAW1QebedCH/72/rEXvdhrCxyrb8hoiZyiytmbQXe?=
 =?us-ascii?Q?MNxLhzgdzkEOPAcBjpCa00bt/9ElhiGwqq+SAEF9Z7F99dcZ7hMPhZuNp0Hc?=
 =?us-ascii?Q?cfD3wOeRwXu8ePJ9KoHEXpR3gd9pPIsWUkJkHNDyriThpl5ogkbo884oZ3hN?=
 =?us-ascii?Q?DLULpWh4tgMqjD7+aM3NHGkbAZio43G4ll9JJG+O46VWNoDk0p7f+FxZ5lIw?=
 =?us-ascii?Q?PvlxgDhgCy/67NUyv4o/6GC4vrwNWNflpEefn9GrrGCNReTHc2fuD4xbHBxZ?=
 =?us-ascii?Q?QsqMQb8BSxXEe797APRPaW1SKqhjVqqWBSrMKRZt6HwzQhGB6vXRPIyzR/6/?=
 =?us-ascii?Q?RmAyxOQpFcaVl6499Y2QOMbdDD5Vp8cJu/q+SflhnNmWB2MuyMHLJ0UYmuQm?=
 =?us-ascii?Q?IbYJYhZOGwgfa3bjbT4AdClWIlbLvRdNua4uV8OHwor7d756nUZElh4a5OIw?=
 =?us-ascii?Q?wbtIxb2cj/kGi6o7QFUZP+1SJrR2+6N6fdN/w9XfvyChuwwoIZc2IvBcSn8p?=
 =?us-ascii?Q?48pBJKZG4MaE9MHtDl0eswhfNxlFEEqCmOZnkCMjP5m4zxV/6vns7FDBUKKw?=
 =?us-ascii?Q?9PKpsy9J9/SWt0zZRIwm5Jcag6fEDQTUUtaC78xua2hADiBZKv0A15riDHpD?=
 =?us-ascii?Q?LnUcnPtLFOsB1X1cwsYRsklTFsoaMJRtIHoLVg5ZDSFhdlAUP7ROzEa9E7K3?=
 =?us-ascii?Q?reyBY3MvIw0y6w2XrF9uxOcW//kfdEQny3D9Uge5xdRo3H8aAoBCUUo4i1rY?=
 =?us-ascii?Q?UTkjMBYoidVL2Ck+6MV6YIknhqSrinkzdj7wePQ0/foncfB/wAQd8r0X/0mx?=
 =?us-ascii?Q?R6IssQjiqg/TdDZsnL4eakleToY7Of+E2XF/l2sfl384mHErZWxhiz+7l/VY?=
 =?us-ascii?Q?MM7GrAwlg3oLV+TgukQxGVkXVkHxq1eQzK81FkzfNgUzU7aeL2resNK1PO60?=
 =?us-ascii?Q?g2yEC5SArfjhJg6JK4A1ZNwKt7pZOe+cSWLF5EvtDee4m5VOkDPYbLBfB6DR?=
 =?us-ascii?Q?si5HcsTMZS6y+FEsiNpOpAgP5lIIR9mALGpwX2x3YIxWwDS6m9HlPatI/oh3?=
 =?us-ascii?Q?Pn1WiPwqB5XDHY4HwngmqmMbXbWdwfGlcci2h0yNxGHatSosn1Yk1pz2osVt?=
 =?us-ascii?Q?+f0XWcKF7ani6lmQqsWm6kSZoZssUGaV9wDWpaiW70F83SRLVGxnqSg5dXbQ?=
 =?us-ascii?Q?QjFQIcVYthSfrn9OCQYCyi0WfD+BiJmrNAbiWfS4gs9diJ+ipTRKYXSlT8Ag?=
 =?us-ascii?Q?v/QvgXLpAFJAiXsFgR1+fn7p6nhWEI3KQIYMOILaYPy+fMfPan6m+cLkvf9q?=
 =?us-ascii?Q?h0+ss73vSCZjFtNdO7lP+GGo1oEspqYfmpu4MknRjjuvMKcaiW/Bz2IDk/lR?=
 =?us-ascii?Q?jakdf6zX3bWYRpGVVwLlVIzVqh07qF/OmViaiXDqqXFju8xdWQlc1ymGuBLO?=
 =?us-ascii?Q?ePKSEcNCjrAQBGIGfe25gEdF3YbsO0lZ7bkGyqn0uh5gaKWHLcvDBH+ltNYh?=
 =?us-ascii?Q?sFowLDRJF1iTqdWn8YY/kwk7Rz2R+4HYR3mLGZxBGCdbrBaEr1zbRuCLG1uQ?=
 =?us-ascii?Q?yCvEW8idvM2aRnBslorBOFvudszeMUjmguOI399u?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cb483b1-0ce9-4d13-a3d9-08de01851ee3
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 07:27:19.5892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RCEuA6M+aRdbu+kQ1XI+pqLaeS/Szor3CjqR9+a+OiMlRlFOpEMtdKuO1ZwYqEXtEm3tdJyFGMGW2L4uc5npeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8743

On Wed, Oct 01, 2025 at 10:57:20PM -0400, Ryan Newton wrote:
> From: Ryan Newton <newton@meta.com>
> 
> This is a follow-on optimization to the prior commit which added a
> lockless peek operation on DSQs. That implementation is correct and
> simple, but elides several optimizations.
> 
> Previously, we read the first_task using the same slowpath, irrespective
> of where we enqueue the task. With this change, we instead base the
> update on what we know about the calling context. On both insert and
> removal we can break down whether the change (1) definitely, (2) never,
> or (3) sometimes changes first task. In some cases we know what the new
> first task will be, and can set it more directly.
> 
> Signed-off-by: Ryan Newton <newton@meta.com>
> ---
>  kernel/sched/ext.c | 26 ++++++++++++++++++++------
>  1 file changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index fd0121c03311..1cb10aa9913a 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -953,8 +953,11 @@ static void dispatch_enqueue(struct scx_sched *sch, struct scx_dispatch_q *dsq,
>  				container_of(rbp, struct task_struct,
>  					     scx.dsq_priq);
>  			list_add(&p->scx.dsq_list.node, &prev->scx.dsq_list.node);
> +			/* first task unchanged - no update needed */
>  		} else {
>  			list_add(&p->scx.dsq_list.node, &dsq->list);
> +			/* new task is at head - use fastpath */
> +			rcu_assign_pointer(dsq->first_task, p);
>  		}
>  	} else {
>  		/* a FIFO DSQ shouldn't be using PRIQ enqueuing */
> @@ -962,15 +965,20 @@ static void dispatch_enqueue(struct scx_sched *sch, struct scx_dispatch_q *dsq,
>  			scx_error(sch, "DSQ ID 0x%016llx already had PRIQ-enqueued tasks",
>  				  dsq->id);
>  
> -		if (enq_flags & (SCX_ENQ_HEAD | SCX_ENQ_PREEMPT))
> +		if (enq_flags & (SCX_ENQ_HEAD | SCX_ENQ_PREEMPT)) {
>  			list_add(&p->scx.dsq_list.node, &dsq->list);
> -		else
> +			/* new task inserted at head - use fastpath */
> +			rcu_assign_pointer(dsq->first_task, p);
> +		} else {
> +			bool was_empty;
> +
> +			was_empty = list_empty(&dsq->list);
>  			list_add_tail(&p->scx.dsq_list.node, &dsq->list);
> +			if (was_empty)
> +				rcu_assign_pointer(dsq->first_task, p);
> +		}
>  	}
>  
> -	/* even the add_tail code path may have changed the first element */
> -	dsq_update_first_task(dsq);
> -
>  	/* seq records the order tasks are queued, used by BPF DSQ iterator */
>  	dsq->seq++;
>  	p->scx.dsq_seq = dsq->seq;
> @@ -1023,9 +1031,15 @@ static void task_unlink_from_dsq(struct task_struct *p,
>  		p->scx.dsq_flags &= ~SCX_TASK_DSQ_ON_PRIQ;
>  	}
>  
> +	if (dsq->first_task == p) {
> +		if (dsq->id & SCX_DSQ_FLAG_BUILTIN)
> +			rcu_assign_pointer(dsq->first_task,
> +			  list_next_entry(p, scx.dsq_list.node));

nit: no need to split in two lines, it should fit in the 100 characters per
line limit.

> +		else
> +			dsq_update_first_task(dsq);
> +	}

However, from my comment in PATCH 1/3, if we allow to use
scx_bpf_dsq_peek() only with user DSQs this would become:

if (!(dsq->id & SCX_DSQ_FLAG_BUILTIN) && dsq->first_task == p)
	dsq_update_first_task(dsq);

>  	list_del_init(&p->scx.dsq_list.node);
>  	dsq_mod_nr(dsq, -1);
> -	dsq_update_first_task(dsq);
>  }
>  
>  static void dispatch_dequeue(struct rq *rq, struct task_struct *p)
> -- 
> 2.51.0
> 

Thanks,
-Andrea

