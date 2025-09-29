Return-Path: <linux-kernel+bounces-836073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0CDBA8BB2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDF5C7B73AA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2EE25EF81;
	Mon, 29 Sep 2025 09:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="nHIUlAHC"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013062.outbound.protection.outlook.com [52.101.83.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B61E1DFD8B
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759138541; cv=fail; b=GgTeYKJX2Tr8PB2frGAOd8653XVLX0/57mslCapg2u4Z63xYHx1UI8IK47s6O1ZmvqvzxqrLY5e32EmT5YXdtJYompYHUMEkGJGv9F7vLBERKxAb200rGKdcI2Yqtv54HRxhrxaFTtG7FZqOfNp3Slfm2JWFECeAwrH1Q2tbqoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759138541; c=relaxed/simple;
	bh=KAsdQ30U7UlBYHNCXBDFfYjLVOpQXKdEbXylncUjBmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ta5EG11QpjYxkFj+GXHxBbS8GgeATUkUaiTnz7NnEznwDjVe40+n7cLOy6TmYVbmCx3Uf2HtTzrOFv4CrD2TwrQViYyed2DLv9qsIuYS/zmMwlmVxCNZGxmT1lR1xbO6krkerPp9hpTQSNE4tsNj/rcCvBKvbVnXaAfKbYhXhXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=nHIUlAHC; arc=fail smtp.client-ip=52.101.83.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VVKWIg+a1Ty9kGTa8VV6F2pG5gEqvukIm/o2rWei5MljZM0OnfunQGnuMzNeiOgff/x/z500VSh1isQwOL64LS4EP7HBB4YVZd4MXnW6GeRlKTfNxflfbXK3fdpkVu0EXZOaH1Tr9Jtwrv8adcJrpAzxDz4SpjK3fc8OtKb3N8TSNUXFMxPHm7tA189Zhi3lmjixL2bGOqEj7+dfCcpJHd9gn5ghyCs7JQH3XJ9nRtVMR12YD8JpnMEV+2T3IWqwRBUhHr0FQtL3q61HyzY0RTe2I+b+J9jJHSa6+b5naNz8qfEIrCrDWuyYr6vTpbGIqub2bR0PIU2e0+2QmXO5Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KAsdQ30U7UlBYHNCXBDFfYjLVOpQXKdEbXylncUjBmc=;
 b=kaMkPBIvIdij+om232XcrcOOOMub44Ph8rFHTb3yUqAfHaQgMWJH3htLGE9xZeRy1mrO2dGUzAte8WF51SpxxbXeympf/atuyFKqazbEJ0gZ+W3LhjcNy42Dh5uYqBBETEcGWAJ0pUeZKUMC8m2NE2ZVTZJdrfHx0Xo8utjFC2VvRDSUqtyY+1FvKM8HmaW3YXVJy2u4+WP+jr76wgnTKsxvMrTRRvI5esjVXupQhqp34rbYBZl/WTfsFkzVBKtANfXtN80AZUK4u+rxp/Hj8Z5jzmdzAOhB0PrkTjNRlCJT0KKABQFboZAdT56QNbGqJ7LqQ/7k5/CgtxEKeahWvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KAsdQ30U7UlBYHNCXBDFfYjLVOpQXKdEbXylncUjBmc=;
 b=nHIUlAHCKqDq0jw6CRCb4cMpv2DIzY4hQkq5DldOq0ZYaB7V1OkbIr7ww+j7lRLzhevWGwHARkpw/kqV2IlTEHKUdjS6KjQyenCSldk3LMhDyb4j4T3lG9IPkdtwvZd5G/4GssDhWHO7ffmsroXNz6/xBXCjtdD+2bYm7NX6IHLneAt6kQCE3vGmuDtTPHMRQPmFj3/GgjnQ6BFIlSr2Zi3tXnNwaZ0OHoIvqdRYFjTgoSBWcRRsS5tDk6TrvnDFSEmkNrg7Kdz6WxngBav098iG8cM0YF11wPczt61wNPu6focdFGASb9Od3okdoo/bitPWMadjAfs8I0TkUzqNdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB8311.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 09:35:34 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9160.015; Mon, 29 Sep 2025
 09:35:33 +0000
Date: Mon, 29 Sep 2025 18:47:30 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Harini T <harini.t@amd.com>
Cc: jassisinghbrar@gmail.com, michal.simek@amd.com, peng.fan@nxp.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	git@amd.com
Subject: Re: [PATCH V2 3/4] mailbox: zynqmp-ipi: Fix out-of-bounds access in
 mailbox cleanup loop
Message-ID: <20250929104730.GC15568@nxa18884-linux.ap.freescale.net>
References: <20250929073723.139130-1-harini.t@amd.com>
 <20250929073723.139130-4-harini.t@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929073723.139130-4-harini.t@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR04CA0204.apcprd04.prod.outlook.com
 (2603:1096:4:187::16) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB8311:EE_
X-MS-Office365-Filtering-Correlation-Id: 27fa9bd2-9c66-478a-626a-08ddff3b89d9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|52116014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jgMolGBCXJLhm1bhEVVUSYTej3ySAyQc+7y33U5eJcX3RaQ27XkA9ID+QaLa?=
 =?us-ascii?Q?pXcqhSsrZ8Jfl00M71bPp7nXYVkCcOrGauAYp+HE4DBu9Azuuh2CkRNsZRn3?=
 =?us-ascii?Q?MtEg40Ev50QvsQFd4KsMXTH73Seaq+9j6w3FzQGIltkLo5aD816fqhepPYqW?=
 =?us-ascii?Q?Pe7JK5IBZgoKwUl7LnsROd5wrQ8lW+7e5902a05+1noIxF3IVUAJ8gHLAFgU?=
 =?us-ascii?Q?g/ZKsLvKzb3O7bCmWe+GDcmevu+CckWvJBKGWJ3ELMHMDXGF2TD74GMfvpvW?=
 =?us-ascii?Q?Pn4+MGQByYpkumzsoRjJdOa9SlZXPeJP8XAngZkIpiPWY52GQ7apMBAhEumu?=
 =?us-ascii?Q?OycBLXCthFGJjxDSzzWotjn+bRO44lp6NMHXS8spGeTQWrhtBebn9+4xAEi/?=
 =?us-ascii?Q?Mj7fnawM6PWTo06RG1nHM5YyQ/adrropzt06ccfjbItZF9AbsXibJD4H2JW9?=
 =?us-ascii?Q?gHG6FtIarpB3D0JVLyc9FLzqj5FxM0xXJovMOh4he1ba3xKKLzALkMB4z6hs?=
 =?us-ascii?Q?bwuyG7BS7JYoUl9E6+hxrNMmTciqdtyqAtKbi/UurDLpaguYtJKq+418fQcF?=
 =?us-ascii?Q?riAkcYRSiO69W7UzMigES8wq9ahXnYTJ35rpFUk35N/q0cFY1MM6gpINs74S?=
 =?us-ascii?Q?VV+2T+bcFm1bsTKGifrrATNm+7rFvpjYDLWt1j0ZAMvUhPjTRYSs1EznLROq?=
 =?us-ascii?Q?A0sAMhjF8HZgXGFMQDjB9f3yzVLKMzjhAVpw3qlIsR3qYpLKwpSYVoPvoiBa?=
 =?us-ascii?Q?+bEaTuRCz56maXTcTMdDLvAqQy8rJybcH9LyOA3NqlMmwoWnHBjjjhylLGMM?=
 =?us-ascii?Q?iCDUqdbGKZMcNjIHeOHsAnZYX5iNsXDXX9Aj1JYnb3FHfPFysIv1jDCOFlSW?=
 =?us-ascii?Q?MajBj+wHdL9Nb1/K7NHh+dfr3jOxdaMTt6+pqtOelHXVPy6lQ1tuzK6NCam2?=
 =?us-ascii?Q?Xrg5Vqt9TxbWt5pJOp3fSMmVBeIC21fPYRxFnAyzBWpM5oVcifbkfYBUVQDh?=
 =?us-ascii?Q?nmfLN5tyR+HvNLY+qZa0BzuN9GPnTk6nM/F54VSgbayPUYabUt8q/ZMqaLnm?=
 =?us-ascii?Q?/Q5H8ZRAP3S8d9goawasfLO/x3XyluCCkmI7/BKsDegC6lP3th3ZkNX6aST5?=
 =?us-ascii?Q?EJUwz0l7dgcF2fvlOx3PxBDJbdEDd+uipdvUkQRAYHk3E54NHqL0xN3w2R9/?=
 =?us-ascii?Q?jFbc8romp6vWiXAgKDn7sTKXneAxgkkUfQXVVRZKk++WvlBMyaHQCLfE3bB/?=
 =?us-ascii?Q?wiUqocQb+EACVuTB4wDFt1i9vtRMBCHf/7D0XB5hcRJl03WyH1PcjsLpTtt/?=
 =?us-ascii?Q?H84hSL2LwlK98jf54dYL+seYOUmAMKpc1QRB2T6RP8AIn1M6GRx29Dumn2IK?=
 =?us-ascii?Q?JXOGslGspceGUJk4BB9wxH4K2qy3qTPY0tbGYVpHe0unkDQCTdRZFp9TzWjD?=
 =?us-ascii?Q?Ojo7tu39EROgsDeFpBzHy7M1XPTRvYcboOJHB0SPRvdpmRybN+XOjR+F9mrb?=
 =?us-ascii?Q?uLe+mKevYc/j/DOX5fw1BWfF+Tt8zbmGX+4L?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(52116014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sGYCjlgu/nKikb5L4/9P1XHkQEhWQmN4NuFLQB+EkLCVMpYr1SIpYiuph/O0?=
 =?us-ascii?Q?pKmgkSdAIP2dYOYqadIaVwS1dB1NsbtxRjdOVaYhNLriAzAeLYjDX54C5sJf?=
 =?us-ascii?Q?k/+L2Lq/mdQP6mgyay7j8kBPxuBwVHfzhD11TYt5c8IhePWGjV2KsjqdK3eR?=
 =?us-ascii?Q?AhMjo2R8J8P70PN84t4ZiftnoILJaLySGibg+ddILDM6QQuN8NfSuR0dqeVp?=
 =?us-ascii?Q?qYFcyRs8H4wNB2UKxQmq4cvtJXxTuGcxlB9WtK/5uN0FRGKkJZF7hAwpX1SR?=
 =?us-ascii?Q?mp5qIDeS8nOiTfTIXgR8nBV4Vjoe60Mlxel90T6ci4jwkJpZ5TUd/Gf/TLuT?=
 =?us-ascii?Q?3+VTzbqWKY9w0nqC59UaH2UhZyd2VCTbrs7a7gpLjjEfmAibccY+7uJavbFn?=
 =?us-ascii?Q?wSSzIg1cSgSe3SOSB3QobhDG93dxDHRbkauDVY+fnXAFGHdIRpCy20AYwVEw?=
 =?us-ascii?Q?z8pt3sQne54DnKHRcTCZP24LRndNCZ/Cjz7WgAnh3opY1LkfBzQLhsbNGdmu?=
 =?us-ascii?Q?5hlkzsoYx5ljo3yr5Ppz4TfGMreE4e2eXhwtwuMan+sfMeI5lTcLiNBpCxad?=
 =?us-ascii?Q?OP6ROW+y6nhWkIFa4+3rkU9f5gKsb+dXghn+6m3NnbIdqFcyAGnB+a2xR31+?=
 =?us-ascii?Q?0hKPvkXqGOO6wVe9O7mFKwYm0ce68ad0y1P7X1fGe0QdxeRToXczwAYqUhIG?=
 =?us-ascii?Q?uYXuFvNldYeJmr8O9j4GL+P4YC7r6IJGLveULJnhuYV6DFT2qqbb2GZvLmT5?=
 =?us-ascii?Q?YHXuKkeLZqTxVgrduwdhYKZ1uiL623vr8o78nfMQHODkLXzB08Snw7J/0fju?=
 =?us-ascii?Q?gX2xqKEN/p7RJ1uERfAUsvhiifGpu+JbAfv1bDujHoNkVVCDKA6QWrWAG/ru?=
 =?us-ascii?Q?gpcvqwFqCUHtjTfDbTX97mzWJknGfO4qNOwC0JAquo/c+lJTt+o4X5hUyQdN?=
 =?us-ascii?Q?9g3i1Ibj9mtdVcd59fNSMLWTAcJ8Oi1dsGqckTBtL+ErldZVMW1cZm3OJC0j?=
 =?us-ascii?Q?HNNoTxpzxbPwSIVzDBHadsqDc/PESbASV7oI4+TTZlGMhVl+efDszMUe7dx+?=
 =?us-ascii?Q?KEBtWpdjx1voOEnIN1qN2lUxqqGTlmCCaWMa3ebLJimjqAanosGzAgkvScJW?=
 =?us-ascii?Q?19DAFaXkrrG1PolHLGtbtyeCogs9pjNHfyhsaXa+m5EIkx55dIKOKbCFL0Db?=
 =?us-ascii?Q?oQywMPmCbMmujne0Y0Cxo4x3d2zD/o0AquWeLorKSIlf8piRSwo2q/Rm/PUP?=
 =?us-ascii?Q?y88tqOG0ppqczOo8iUdbeZPH/m/qyKy5mikRKTOQxqzjmasg4c7ymgxzIYgS?=
 =?us-ascii?Q?0S3pT5asJX9gpa+63yOpnsz88qSVCV/6HBosJYdSykrMdy8ZLCV/2G7HzFsY?=
 =?us-ascii?Q?l/K55AtIXEEqw1mR4Ykbt/0hpZwbE+2rlcdemtfwQOQht4RRNy+haMxU36iI?=
 =?us-ascii?Q?FwLizie5jWqZLIAHEKWSbyIQsCrnf5emm44pHq//QUWBKyUa6DakedTcE6zm?=
 =?us-ascii?Q?VIFC3pJhjVuPrAVBAYAaVYE53umTDNVNy8bhUah+9cXXBpmW4LNhk0R55rC3?=
 =?us-ascii?Q?hZgRHmzTT+eadpFMEe89z75c9r76SJ1iLBfm9yYo?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27fa9bd2-9c66-478a-626a-08ddff3b89d9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 09:35:33.9233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9TUMjc9OWDgqI4k9o2a0QnHZ79CckRQVaqZ2ItIVRcW/8goFPzqyWJ/xkFKceyV4cNCHyans89p9HZnZ3xG4pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8311

On Mon, Sep 29, 2025 at 01:07:22PM +0530, Harini T wrote:
>The cleanup loop was starting at the wrong array index, causing
>out-of-bounds access.
>Start the loop at the correct index for zero-indexed arrays to prevent
>accessing memory beyond the allocated array bounds.
>
>Fixes: 4981b82ba2ff ("mailbox: ZynqMP IPI mailbox controller")
>Signed-off-by: Harini T <harini.t@amd.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

