Return-Path: <linux-kernel+bounces-893741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DF41CC4835F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 18:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 73B4D4F2D19
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47E528B7DB;
	Mon, 10 Nov 2025 17:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XqxweZLW"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010012.outbound.protection.outlook.com [52.101.69.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3029286D57
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 17:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762794061; cv=fail; b=SnvSYto7G19bsqMRlIfcr1qyRdGm68ztMOzo5lQ9SBKf/QaqJUvkuhfrsGCAUKpHnJGKBxCHZ4IYPNcJ8VKh5hSUUa1gPDAcQm/1mv+JJvOkrGeJ/3FZ9wrJ7EHlvPz4Z25C/xt1o/gFL5cGB8x6vEnQ/yoxxTE/xEIu4R4xbeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762794061; c=relaxed/simple;
	bh=sZMseh8ftQSVsHQkmYFK2BaNVMLPBmxC1JIl9bKyYsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qaPlmde0Mzk5fzkRcI52FvYoE5TaBHjD+tLHHPrPj1P55OYABvtzWZUdzYF7sgRS8wkXjken+7/orQ/c3CSlzD7lfd8/cb+kxHG/2SSfe1UwpSyJsPFmYU4QEFv5CrQPLZNbH4VD1jttlGUGZLbYc0zo9qxmR6ylYu7vy4cLYHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XqxweZLW; arc=fail smtp.client-ip=52.101.69.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yIYcbJ7apBnPUy4seHqR4pSmyD2uWW9/wmgo6c1NIetQzS/yj3AdQ6h8YqPG54C8qS5RlEj6dfdBtUVeOpfouutQuu7YimRY+56VEID1NxGMozG0L0B+ImjKN0C+v5VLYAMF1tOhmqeP/htbHFvl6uvhKIPM/huJpvMWuqotsVeQHlWgU2q3NbBb/WB60kX6DoGaDwUXqbgbtoPKuQTvAuN+ichKshHq5QhDa6Q+2BjrNDimRvXaoa41UiypBlhL0KNJN4X0QS7uUCcnX/owvuKn0KOsdn2wiypEmatR8Ro6hucBP4LFpCaCKNIQQlXfI8RubQHEOZQo7Kx5p9fFcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wRP3PdMfJV3KqQXgiQUFWQuhUzkN9lmBpptx7e1nCTw=;
 b=i+5wyEQmB0BvQvVD2nPlRpU/Kdj3ZxeWeWXEL8MzOXR3Teiq9oW72t2nh8+PnJjzPqSn3HxXNTk5LzdqCMJHB5Z8jwCeSI8CBLYRUsrvKn3Nt0E7dFBW+BCXGLfUOUTLVDgPbvX0V1RSc3zfiNOnrdy1y+566KEIWe6imj0uTOKTxo+7h/Rrp+TFjSH3rz5v9dmsec5sORpcKrHjPG6Vjp+MbLUGQwUNlo9a1fkEdU+zg53idEXy8vxblxfRoUFJWnVDsNt0MFtyLoZnXbjTWvIm0IQvUlb2zFBZ3jIxpu/IKlSbRqC8uggoUP4qGWG8mQ0JunfsicodP9ccyFrc2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wRP3PdMfJV3KqQXgiQUFWQuhUzkN9lmBpptx7e1nCTw=;
 b=XqxweZLWAKHYMHqGpEqqQ0Fc2tVG3DujyVuCspVK3KXZrXIBeAVjATk1GzNaPj2hu6XJY6xmhy0pKLZ02BScTnh6vYq24vST7VXxuOFg0dqgartnwIRqUDYJfgwxT0UQ7iEmJoP2+8IXcX2DF2Tj/2F3Tb9wfuwm50fJpxyCqTm8rUYpDWL1uHaX9GrJwTcH38iEQ5FVPYKq4ACKlmC5Op3qeJXfgyt4PvwEusPj8p3Za37TKnUMBcHJXSsufGrlATFEWhoUVwaLd4F/wCK5eU9uh9YcJ/m2tLJZws0OfAmzgYvglPQWm1KVpvA7xNPtUqYOEZAbsdtWQUBCUFmmJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by GV4PR04MB11944.eurprd04.prod.outlook.com (2603:10a6:150:2ec::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 17:00:56 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 17:00:55 +0000
Date: Mon, 10 Nov 2025 12:00:48 -0500
From: Frank Li <Frank.li@nxp.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Marco Crivellari <marco.crivellari@suse.com>,
	linux-kernel@vger.kernel.org, linux-i3c@lists.infradead.org,
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH] i3c: master: add WQ_PERCPU to alloc_workqueue users
Message-ID: <aRIaQOQkbPOFpJM+@lizhi-Precision-Tower-5810>
References: <20251107132949.184944-1-marco.crivellari@suse.com>
 <aQ5d1g95N86lXXT2@lizhi-Precision-Tower-5810>
 <20251107222830.oPfVHd-_@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107222830.oPfVHd-_@linutronix.de>
X-ClientProxiedBy: SJ0PR03CA0138.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::23) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|GV4PR04MB11944:EE_
X-MS-Office365-Filtering-Correlation-Id: dfc4419e-0689-4c92-d56c-08de207ab669
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ssmEv9VXeerukq+Os/0kfHnZRsVtcAAen8f0ZrrL+SffXxeJOwBMO23xKieG?=
 =?us-ascii?Q?+BbyNdP8Kp3cGX45uYzgQmt0XnJ7Pv0tzET9K+CZjaK/PJDg4t18eF/I3Rh1?=
 =?us-ascii?Q?wtK/O/7lgm7o5ONb/axI6tHbcOVlS4LBOq2CRHLHyAHgnY2whcEaAWjPiwz2?=
 =?us-ascii?Q?REuMFovI5esxkCFC426/GJn+LsdomQIoghe3iFAXXQrhMss3c2sJjKmKSpPj?=
 =?us-ascii?Q?T7rMY2YLVHVxje8SjX5AHgqf1FL/zKcfAnCuGCjdLlvzROrJ7aQI6pwjwIWr?=
 =?us-ascii?Q?shEH55r0fb0iyrdfpGIJ2HmwpqKbAFSPCKVd9B6GmtiZLmQJd4g+9Z/r1xmt?=
 =?us-ascii?Q?rxWubp2u/b340AydhYHe5VXzIa5N2KWxg+5EZGHNyKIclJqGK413wb6gorPe?=
 =?us-ascii?Q?XixBbGfnfROeQHWTat+torm/5nZwKRB7dK96VNWGc79bAXDo0vV/dBKpGn7t?=
 =?us-ascii?Q?blWd6OWp74YMYSgxA4Xv3+LSsxejSaKwHJ1uy5kEdmxpHru83taYTpUEmonI?=
 =?us-ascii?Q?iTc5LUS+UvtTS2QYPkPNWA7WIyyrdXCoeBVcSfRh/ruuH0Ncs2GP4KiZsFbY?=
 =?us-ascii?Q?Chj+kZdpW0MwtmgokeKTJxppZLzUL2tq4F6kqABWE4NRMXri0/CIjJsNx6Qv?=
 =?us-ascii?Q?RqY8gUyNYUy5jVG86v2WjiEma03XmdIFo9EWaIKOiqG49KglT5//e4STrcbj?=
 =?us-ascii?Q?dIayhqsusfZo1i+0OlbVrRUVNCGWTUdm8hYQ5bx5VvtChzC9i1ink7Syb/IT?=
 =?us-ascii?Q?uO6EXR3uRcNqTy1Y/ZwyyVMP/fZMA76TQA3x2CynJR10/U28oEGBZUSe9Usj?=
 =?us-ascii?Q?5G9IAaznF/mSO4F81+FzKpBmBir4QC4N1OwMqChrm5gGSDudEVLkRCuCgwTE?=
 =?us-ascii?Q?e4PT5t2eQXWfgxE3j9w44uBHoyUkzBcruezaz2+/UDnOlw8Uz1VvRfYONFi1?=
 =?us-ascii?Q?QWsqSo/IqIMFJ7LPG4HZzJUMewop3ZpKOTJwL3a0qPdyw423mJ3qgSJyEkEf?=
 =?us-ascii?Q?NngBr5MkCznJJmVcEYVo6ZkMmJbAZwj0/GhB5K/61JdkoR2WL80ulM4guQh3?=
 =?us-ascii?Q?gaq2CyLO7J7/RAYfvPFf0AtTj4QkYgLKzI36VGn6pgxQ6Y2IwYFct1xmP+xW?=
 =?us-ascii?Q?n71d0MWsbPexY7fdkCebnmaEkVNgXwAYMIOqrZrQQ3EqgZMoj7rd076pHWsk?=
 =?us-ascii?Q?tF063nuwifLQutymY72OdN8qfaRUxfvZKBgyW7Tx4Y50KChFLp13madjt4yj?=
 =?us-ascii?Q?hIzmD5AATLM6RumxgEa22vcsqr1mlRFPft50WI+1WUM9GeFeDI2wcJ9an0wU?=
 =?us-ascii?Q?kUkj4JNRQWyRb3ZuFWGn7ElIw5+CCnL85c1NZLCbG29pGm+VAq0EQG6IehbG?=
 =?us-ascii?Q?KdBmEcxWBtopWMjEVZ1GXQkp3hA9QuPRPaz2BAQFpjD1H2lA2tTQPPxXrxeC?=
 =?us-ascii?Q?82W1NwiOIgRLjE5kIYvL+6KB7WXjOFNygJZZC0Ja9+ZavdysrpXIJDOvGf6R?=
 =?us-ascii?Q?TESE8BCQQldeeBCazbV3Wmtke6RCcquGvmYo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8pBdeWUS8Arrllr9DUby6eScnfjg1nyacUX4AZigzWk2s93ARQVNPTqxkkAd?=
 =?us-ascii?Q?YJYgSg4iiavrQVzc6pUjQC1AxWdbnj1K5IS6wTWibDGMMv993NH+G5Rnx08c?=
 =?us-ascii?Q?fAiy4F7T36a1heMFecZmsvZvYWoLzMEdSNegU4u4D63Lm6G15ie2J3U44I9G?=
 =?us-ascii?Q?tGgl4hvaeu8K7/B1tVqcbRsSj8+/t4DRTE1SAzCHpLo9QuspwIbqkN4Ew6sK?=
 =?us-ascii?Q?4uyiLfJ7YR6J7KN54cNcpuV6FHBXTW11+6Zg+zeo+H0xx/l/nUNsG7rHhvvE?=
 =?us-ascii?Q?3FtGr4c6IrZ+EaV8st/OHtWnrXqYYldAEXrZt/jWEaI0XVzVzBOoBder6MpH?=
 =?us-ascii?Q?UJhfHNTKQ/7x7+Q/L4uHVo+rgPpAEisJ2ttiFomQ5DvBSguLbs/jr5c/X2U8?=
 =?us-ascii?Q?oSzJDMKFqpNpXnrxCgzN9DBk5dIIQ8sX9eHDwwJ9fMhHEOuewCxF/kkts0Kv?=
 =?us-ascii?Q?9Vya/dXhgyS3g0DySr/gHSUa4Fe2SLWNZwr48anhEsInhcKHQbsJ26mkLBgN?=
 =?us-ascii?Q?0pBM22Mf6dRbXe74fFZXFzbmUP45tQCwBrXMPY9EpVTynDOHuyp7ZulVkvN1?=
 =?us-ascii?Q?THYLtFeOentYgYdTMx6fWtQ7Ho2CMCHkBpIDIkT6rKC7dinX58/hhxZMaYuF?=
 =?us-ascii?Q?j7m/xzKS3fANEMyAOav6uFb1cRdq+nL8rLuaFUulwky5qfedYI+GxXDTG3lj?=
 =?us-ascii?Q?phxdwSZuBpcJq/Io78XlLO0sWIBjmZPXNx8vYReQCPd+4zcbs8QPpIkiJ9oG?=
 =?us-ascii?Q?dU9OjIG+xnstlY87Y/+Z5FQsBaUA0xXPjwhcb2lLIZJb+0S7JLI/fWtkFqWp?=
 =?us-ascii?Q?WwkWT1UNH1w8h3xw5PFMYZ+Cy/2ab6pfhCsDvXIz5Yq4zhd0qXXdOI4s2qjY?=
 =?us-ascii?Q?NnibMSAc9/Rf2+Alxk/8KNOtUd1Wzk/IObmAOP1vaK/ZHNmIBoh/fjk2QI2T?=
 =?us-ascii?Q?vo03bfjqKVRZ9T/uJ029Vk8ybAJGtugDbCEyBwna4h/fDMXE0p7Y/Essqyct?=
 =?us-ascii?Q?y0OpKdwKvw1QHcTQjt/xhu1dj0yXMIH4XTw8qCJ8QEn8fxotwCGnUj/H0S/U?=
 =?us-ascii?Q?czi3bOqcPm4x6NV70gFuZqnkDT9MW6z/6k73sWEeNm27xMgoOEvYRVh+nc/I?=
 =?us-ascii?Q?A77mOVv8lkLNDKHa122oSJjrXuKJixT0xFCItG3ukUVDhy8U4c5XrqwnU8FD?=
 =?us-ascii?Q?Omde1TGBL++EQOgAoN7ztq0EtwSzNFMr72fh1O6CTe40LzksYsd0eozHYrjB?=
 =?us-ascii?Q?K4tUGGo+MzG/suzX/pRoiaSCLR9nYmXruviSJ04/GIlfz4hgNivwYxieNrz+?=
 =?us-ascii?Q?IcD18DLv2fQZOiFEG6GkYj9/AbDp/PZg4b16HLUUWlW9tb5WXCHmhE4rugFY?=
 =?us-ascii?Q?MKbUB2H38BP7Khuz8UpSEVnNeGAF62oG4BIVfZouEUx/X85LRdZGm61G987A?=
 =?us-ascii?Q?KfaF59ppD4wpgHyoXi01FQJUm32pQ6IBms1LBTeurculwUbtRfdainC4ORiL?=
 =?us-ascii?Q?vqqBAtB1MZg7UG6C71bXjWezmfN+rLiFQWxito69ICMSVXXP9t59hnqps51p?=
 =?us-ascii?Q?XMB+mLwO/sv5xoLWYyM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfc4419e-0689-4c92-d56c-08de207ab669
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 17:00:55.3913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iI4Z4hrycPkC1Lytm9t2PTNTUCO0UcHRur4BWrD4nN/VSqG8YFT62MF/hHQpAspiAofyiJovT9IE+v/EW0HoQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11944

On Fri, Nov 07, 2025 at 11:28:30PM +0100, Sebastian Andrzej Siewior wrote:
> On 2025-11-07 16:00:06 [-0500], Frank Li wrote:
> > > diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> > > index d946db75df70..519b98c37ac7 100644
> > > --- a/drivers/i3c/master.c
> > > +++ b/drivers/i3c/master.c
> > > @@ -2925,7 +2925,7 @@ int i3c_master_register(struct i3c_master_controller *master,
> > >  	if (ret)
> > >  		goto err_put_dev;
> > >
> > > -	master->wq = alloc_workqueue("%s", 0, 0, dev_name(parent));
> > > +	master->wq = alloc_workqueue("%s", WQ_PERCPU, 0, dev_name(parent));
> >
> > Maybe off topic, I think it is not neccesary to create wq for IBI at all.
> > it can directly use system_bh_wq, or other wq.
>
> Do you really meant system_bh_wq or would system_unbound_wq do the job?
> The _bh_ one would imply softirq usage, I don't think you want that.

My major means is that not neccessary to alloc a work queue for IBI. Use
one of system predefined should be enough. system_unbound_wq is good
candidate.

Your change is also good, let's wait for more reviewer's comments.

Frank

>
> > Frank
>
> Sebastian

