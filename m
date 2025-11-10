Return-Path: <linux-kernel+bounces-893483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FD1C47932
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C222422A27
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A58523F26A;
	Mon, 10 Nov 2025 15:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bx2F7F1E"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012050.outbound.protection.outlook.com [52.101.66.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEAA1A7AE3;
	Mon, 10 Nov 2025 15:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762788051; cv=fail; b=XkwvAc3wf8UZ+G+mFhNSVv/af6LJ3u7REMS/6uQST+CHkU6jti66ojoNLvHu/EipjYpSDv911nJrJb39OwPue2UUr943xzbMZ970cvikCtSmTuKZ2wULrse+0neOgElKZcIVNVxYH7iPUd9SIfe7yxRjTMSOFO54v83+kJl40R4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762788051; c=relaxed/simple;
	bh=OuBG5a10cyH6U5g/1E5URY8FiTsBrrUx/j1HDqfNl+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rIIHE994MzxCJv6EjbWcZJfDlip2rFWSJswgucKWYYhrIUpFeGqlFgbWv8ZwfXP6t6i+gBDvFGtUifpHtY9qLkoCI689Twh/lPMqPach3m7Yz6aDfntc64wZj9JvD1rgWpJM5c1vIXrW5OJIZf1dxNHhC0A2Bmnq69436PkZuyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bx2F7F1E; arc=fail smtp.client-ip=52.101.66.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yZO1z7vTONVgnqThhN4yKGCho+w0ou+hU51Alpdz3T4XpvXy/UNxcj6AG6isQKACBwJXvLUEa3sGxFezx9pQ1jDU0KreaOPPTwNW3V7lVK9g1kfLjiovE/sJFmtUChkn9dcE2Hed3SHmdfawh3tPC4e6wfjZ8MpxvoAtKVBGeUfF2TT3wT1Uao6UM1qufm1Lw3/AP8ioOYk8CxjFmyGthILcUqGYqoONzeiYWL3s61VPjzM9XCY8Z+MPEyFrIO18ggYpWav/TetV+5myFQxSZ8MTbj2BLCYnOOaWH/HX/rC8IHiZfC3Uvie7Fc6JE9qCjrIgwHOM0kHMcgc1qmGQMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gktokGfPSdCx8RXBySqdYXI/qYTIT7QbDMCrz63DdLI=;
 b=bRFGQ1IKkuLBH76+O50Utf3tMxwT/0aPD3algJiIcYNhYK9Ey/FwCuBuaZ89rbf+utbQeNy/QYlPbdhcG0xILqCIAqgA7ekh+ksTMmIKJ5X8l9zmtBfp1+zMB4g6c5Y9ReQz6Y29qVqjjmL+yX6QxO7nGr3S2A82LGd0uN+Q71X8LjlCbTujNRZDEf8mpgXvyflzyZjnWjFyfrDoouXdKCuTErW7D5ZkatF2HwtULLDEyRZREpX7pLb8agiqQO8rINY0nkRqvEFoZtNEmuBnyr2RICJy1uI+1IU0elUl5tTewU4DzvkvsS/5tPnbTqb8SdI+el3+NgGEY3s9qmUd5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gktokGfPSdCx8RXBySqdYXI/qYTIT7QbDMCrz63DdLI=;
 b=bx2F7F1EzItpUJ4yEw2LqL9PGs/TtG6J+iZPLkQ5ZBQjCmq0KUlccYS3RcnTGP+5rFuJdoz3f20W09pmys0hInaXMCj2eP/ygqZbAAtps4boZNuibJPn+qMi5odpJFldOjMrqMFsqDYa6kJJO7n/TZXENmtDngmU4DHum2X++K3HW16V+mXXnxMPEQhNS8v9n2Ie3EmVo4/MxNCqEOPRyAbtVjQCaq8lAJ9tFl5QTvbEQelUWw3Nk9GA4IBplL2aOeB3fAbkXpyDXzmue/zznSK4Xig19CWMtYe9RPi09I6KnAcdpBlYIRrVqrgVNTU7HWeL+QhPGPd8wtUyGD1H6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AS1PR04MB9502.eurprd04.prod.outlook.com (2603:10a6:20b:4d0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 15:20:45 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 15:20:45 +0000
Date: Mon, 10 Nov 2025 10:20:35 -0500
From: Frank Li <Frank.li@nxp.com>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Steve Longerbeam <slongerbeam@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, imx@lists.linux.dev,
	linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] media: staging: media: imx6-mipi-csi2: use
 devm_clk_bulk_get_all() to fetch clocks
Message-ID: <aRICw0DnuqxaiAVS@lizhi-Precision-Tower-5810>
References: <20251107-stage-csi2-cleanup-v1-0-5d42535243ac@nxp.com>
 <20251107-stage-csi2-cleanup-v1-3-5d42535243ac@nxp.com>
 <0af422ff5881ec875ad7eea272e229ce3426956a.camel@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0af422ff5881ec875ad7eea272e229ce3426956a.camel@pengutronix.de>
X-ClientProxiedBy: PH2PEPF00003848.namprd17.prod.outlook.com
 (2603:10b6:518:1::65) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AS1PR04MB9502:EE_
X-MS-Office365-Filtering-Correlation-Id: 40dada01-6c51-482b-cd2c-08de206cb800
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MmZR9Q3eROQj/SgVy8ASWz8NGQBIPWgZU2IbXzn5wpB7osMTwz76RfDHvmYY?=
 =?us-ascii?Q?SrjDt1dX9GiUf6a9eE7smUBiJfa4SASi/VmnE2tR66NgSPijWQbO6u1yFaHR?=
 =?us-ascii?Q?ySdvmjp5Bhm1EkDXm+TfAS/JenLT+0aWLzV9FW6XzQf3C0Fmg1h4OVaIo36o?=
 =?us-ascii?Q?38fxOBBvL2/BN//qQ/i3Abah6+UMuXXdLtXaTUOb70HmBv1MJZ4cvqaa5Wrt?=
 =?us-ascii?Q?zZ4K468v9/WcvoyE2HCO6wIDSs0xDDOa79GZOQrgM8Rw3Uh2BDxA5sd4z5yB?=
 =?us-ascii?Q?TtBmteKZlBLrvuamfqBC3yDPJwVpJxNLODOWBHb6UBkwplL3wZAqW1bCf631?=
 =?us-ascii?Q?e2ORqryABwyJx5L3GY2faQv9PQUtdpajgwvwtlEEwON/jUyguX6PDNh31xRp?=
 =?us-ascii?Q?lrFxKAm9uWajB4vAsmyX91OzqxXmGoZWVb45ib3ZGYuKaZ8TG5Rd3pm+Mfv2?=
 =?us-ascii?Q?P8ifYEUGvc/ktYeO83RlM1HmT8J7FRB+b6hVxOAlywHCM+nDVkRmfifl5jTx?=
 =?us-ascii?Q?Q/qjHT05qgHRmo2p53madttt9Irbv9oy4vIxwPtpEf8MWKHtxOYOCxFpWdRF?=
 =?us-ascii?Q?/QMbiqQkXggJ5d9MQN7u+9/GUvFpS39VeAfRTJCa2CSQTAuHq3J6ZSvoOWoc?=
 =?us-ascii?Q?r/1Nw9h8U53GtmJ8/FsI4NAPWkuRR+bn6zgBKPLdlPc58cDN4gVl5OtLRrjA?=
 =?us-ascii?Q?FcaYbtmMdZA/9x1HkdwjLmmzsgU+UeUKkA0v4wSNX7UNc7AkFXW799KsngPu?=
 =?us-ascii?Q?4042oU+jnE4LdOvwE3/JGmj4+TP8zhB8ZMVyghTQ/g5FqJB06De7v7UhpCG8?=
 =?us-ascii?Q?XnQyfH1C9unUc/4htgu5sGtTh6QrrkY6FC2z5czIaOKewo1aBGh4/RfIyB46?=
 =?us-ascii?Q?jdWu/pgNQ1EEhqGdEb9MqPpHf9HINeG7e7kzqfGG8Qfqg9ooAS+Gv1qh+Yie?=
 =?us-ascii?Q?LT1+YZUOSaoHKLwYPCdhIEfMQIkRyNlI2ma0tCCX9pv/lushJePv5N/HjtxS?=
 =?us-ascii?Q?XnXV8XEseyPgsWoPp9j75hzyqqmg7/M3t6WT+E/OSHpvwBBPHxiaR6WuhmxD?=
 =?us-ascii?Q?Y1qSw5gP9fXvO4J7BoahwLulK3Sqi9UFuuY8ZUZJeTDllvS/FGaiAwnYEDCO?=
 =?us-ascii?Q?XBnanrvd0v/eusFlsRCx0ZRkPx7CasizdZykHOD0y8OJ8pLdtg6HPij5ecUn?=
 =?us-ascii?Q?U1BTx6PB91HPM3AJWcS3vU2DZLz33a8qLsd5areCoosQnO5mjHrffe2UHkzz?=
 =?us-ascii?Q?zdN9G9TacqDEcK5MLoEENYKCSaGpR2zKeVbibhRrQTC32uJp1ioE/XpLxjNm?=
 =?us-ascii?Q?gaq2zFxYi629lU5fULS2svFC6BidCobT7vm8wgPN23VH+krMmW4Ke2XhtnTK?=
 =?us-ascii?Q?tF3naDSJQ0VhK/kqXylBzkPQ0I+oS849Shm/9y/niW8MTc5R1b8VNEEYJFdn?=
 =?us-ascii?Q?AmVsFRRH2OhxVEIJhfJ0C73L3P3bvwdkQzFp9F+G35YGLcy0ktEJCY7wDZ+l?=
 =?us-ascii?Q?iMQqLLTvNjKcUuKfB0i0ai/tXSVR7pjPI5Pg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RLz/PTsIYYQifBsKePNGXgLuQT1DhPAy84IMsW4SRscrYZtn8ZT4nRjEUugD?=
 =?us-ascii?Q?OJt6+VAC5N9O6+F3NUCB4WXZ4wQE9mTgd+Ei39l8coI8G3kVOiMbeZvRyHuj?=
 =?us-ascii?Q?++eqej1Z2B7qd0HSdsn8iO9Y38KPXy+D3HgWvfqFLMUb7igcDk66p68xcf0E?=
 =?us-ascii?Q?CYQ0Crp19DasxMIVtsb0WTk/daU6nXwjJM/OV0ITBL6elWsvpXO7w8bOFP33?=
 =?us-ascii?Q?Bd+hqgER9Fudj8QDWEXepLc9OhIIqAQ/nd/ykIADmiHXGoD5h9zt6qdfiha4?=
 =?us-ascii?Q?FZg6ZlcLDxES2L8z/JfGdnijYzf5U4UH/wHI6FkcIYd+43uheg5oTXEmaAN5?=
 =?us-ascii?Q?nAzNmM5GETK+LfEKxlpllyn9tvQXujejxpDPoyFmtDI1GMAi7if49dh1Ya8Z?=
 =?us-ascii?Q?t3Ao2hi11mIuAP5bWSxVpfMZ6V5H756WawEcN5VORCt34pbt6TpESkDEIWfb?=
 =?us-ascii?Q?fQrbPx/4fqKjywl3bJZgObvFS+WuV/m83PXG5+z+wPu8LxDrkGmOz6CfJCvA?=
 =?us-ascii?Q?6fTjR5n3o/D1+b0ClYhEmbyC7LPCp40+P6EkrVorGTY0fGFqCCH0DfzyXASh?=
 =?us-ascii?Q?iLKKW0vfq9WeaqITKKwMmlY2ianHpsx/U7/3GHmF2DndZng73FK1f6BCR8B8?=
 =?us-ascii?Q?RK8dVN1XQfuzjF0OW2Kw3OynRwPPnu08jJ1st+xmiR6Z/U081tzDJKZR2FpJ?=
 =?us-ascii?Q?sQJH5PNTXcg898GjylfR5IzoIUwK11hwPhw/PtFow78De6id9WVlhH5zhQ8C?=
 =?us-ascii?Q?Yn82B3KpEiihFId/yGg0nV0IZCzr1sDmuhJ8nZdIvNzYiqLXn2p59Qi9YsnE?=
 =?us-ascii?Q?1KG9w6Y2l8qeVO7eudjX1JN/be1xUr7Qhj08IpZWTBbOBc9vlrkaA7Z5ip87?=
 =?us-ascii?Q?45jBSYvCtA3yajihYEvKZzTSAlXDfH0x9Ss842Y02w35Ax8SEehdMxBlvAjj?=
 =?us-ascii?Q?Gs0FdF+7b4JS1+OdQcZnmb6E/tyEyA+HfFBQ7Ryd6KQSXBXoE0T8snA+eVcU?=
 =?us-ascii?Q?6BEg4So8qwXoCBmHzYLftdy9Ns6nMQTctTdXk3c9koeowsNACFzKLydKokrE?=
 =?us-ascii?Q?QeA+QZ8Z2wkZloHQew/w0IyNU9+YMa3bX/FwcbooPsvoJHmw6MiDs1g9swwo?=
 =?us-ascii?Q?a1hm6hCe6jqWyxAtyH8cC49L9n5K83u7ILWqvZS7ZSbLQXpAcim7OeGjzMwH?=
 =?us-ascii?Q?sps9nzCopsAmC7E8hSIrOD2PqDeaL4lw6nd8IssMhJC3WdwEYhtqLPB/CCer?=
 =?us-ascii?Q?UCwaenv0vvbeZjzfRgv+54Z86nYT0M0FA+doGx5vcw3rMUny9s+wTkO9mfi9?=
 =?us-ascii?Q?YmCTME0TtZcGyG05GUqmuehZZdOvhoospr71g6oBOrOaoSDSNC86pwIFD46Q?=
 =?us-ascii?Q?9PHpYlNbFtxbZSa0IX8kJBFu/ZiGkwtxAhxLtfr4QRc/XoW0reu9ozhjqKp6?=
 =?us-ascii?Q?aM0nzglfEkapFqlHE6PzbQaF75/PO26Kes8nDUtplMnahpnIFTk6HBY3uvfS?=
 =?us-ascii?Q?3CRBdVx1gowmiJfkV+bEvCTG/XLnig0JwtHx8RBZwfuXdpZABMDsYgmH5NAG?=
 =?us-ascii?Q?ipPzcJMT34rqpMii+fNVMVrNzdTNxNxhq255ABrd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40dada01-6c51-482b-cd2c-08de206cb800
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 15:20:45.1919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nMJZTlAfIgyBIXRRxZtFnLZ8hoEbMwjlBj14n+L9ExGUs4bsi3ePxjRx86PB4QNt3E74mN9rrFaz6l0b9KmpuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9502

On Mon, Nov 10, 2025 at 09:22:30AM +0100, Philipp Zabel wrote:
> On Fr, 2025-11-07 at 15:44 -0500, Frank Li wrote:
> > Use devm_clk_bulk_get_all_enabled() helper to simplify clock handling.
> >
> > Defer all clock prepare and enable to csi2_start(), which previous only
> > enable pix clock here.
> >
> > Do that safely because there are not register access before csi2_start().
>
> What about log_status()?

Good capture, It should add clk_get/put in log_status().  Plan to change to
use runtime pm to manage clock later.

Frank
>
> regards
> Philipp

