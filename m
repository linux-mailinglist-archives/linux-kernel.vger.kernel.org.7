Return-Path: <linux-kernel+bounces-800271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD156B4359A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 10:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 095523BDCD7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 08:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2252C11D5;
	Thu,  4 Sep 2025 08:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="eL5LB/dN"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012020.outbound.protection.outlook.com [52.101.66.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA362C0F8F;
	Thu,  4 Sep 2025 08:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756974212; cv=fail; b=GhPe45JWNhrqjiAmtNjbH3C88/zfewcLRvOWjmDny5VSCLVePcPggT/7Hh9yCYWiYz1x/EMuIHLHXFHwF+GBYGiTIQNGJ0gUx3Zqyv2QtnKxD1Bm4aUh9fdWcGBMHwpbh5KsU5DjlkPDNfV8EY8QpYMyMj8RKDfE26k0aB1GTs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756974212; c=relaxed/simple;
	bh=Blea4dqpLCZHqNTKCOTsB1QIlV4e+SS+HcbwIhUajFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TaIIzJtu2L6kWvhfXWGq/4qrOqFT1NOzF7I5crOrJGG9UL23slDuem0MnOEf1dCpVYtGDmlBOCmW/WaGpZpXwEdCfQSRny15V2uE7iXLJn9MJh5nmMuvFCXxHLsNa/esNPLr5ihe5HZct9VdfRl992WpKxx7vFboR3NRTxGM6aU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=eL5LB/dN; arc=fail smtp.client-ip=52.101.66.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KBIcP1jD4HiuZ4In6lEKr7yMzi8ajiszjauCE3DjX80cKxStspeKNSzfGHWalE56m1mkBENzo/At6dfwapUHEKt9sULTgazmDTwF82LnIdPml3+pKewnfi8bKJduhFSea9QV/sMwE3yjfK+k9f8nh+QhZIJLZN6ZR2X0riYPXebICiEgoltc5O+lhrpuEKZZZ4bS9tTjvvSLsLXj6+9sxPX0qj8KBziLGCVurhGwVfCJQZ5VfxwrLz9qL/G90ds/T10yf4aKiuYMHlbB8tuzUHIj5ljKQwP+QCPzv/wPOXLTrxBR9OQoncP0RKMlAPvip3FLzEyjxib0XPwiI3SsXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T3SuEUpERPydWI11TVKLInISXxidPYxjDuYEUTach4c=;
 b=pIxULP/ejL1BMmCqhixzLAFau+QMw10A5x7bEW/eJ/ZWOxHfsVJm7BHz2dc9jWS+4z4CGT8ys0VPROWChgNQyzKkaKeAHMH7ycmlWZisdv+UnnCKcpV3CNzJBPSWqWSfIvFQyxwFwGWkvXxTXmVdICJaJDzVBn24fcJ0swB5gfHi4yJPn+ahnBirwQ/2SNML0hhcCoZuSTNpTlrDqHvwzGMY1dCaR4Gb4h7dAnBqUy7mHxLM5zuSNcVeU7JORyV9axxp0fyX+lyP3hmE4KRPjYqAjGMi+cfW2h8/aLcsof9tQowH0u8+9IgEKoCAX2bO2alvEpp3FCokFw8ZATd9Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T3SuEUpERPydWI11TVKLInISXxidPYxjDuYEUTach4c=;
 b=eL5LB/dNw9Iy/MGCoh5m9gmnhmzRRoInJUbqv7VIpQ5jOCrs0mcg8cPQT8RFoHqSgZNbR75FcocG1AJdopwCqv635FPXrhpk1vpksdMT4YR1atX0pJxLhP/GvXk7g4oSJAP7z+S95xEY3aodKUnhxObj7ChLLmoB+f4IuQqg5S5ZG4E7x3DKG+QdTAH97Cv5zdBJroSNCN5rsOcI3m5vD6juDuPsYiIo1p8saNhH6t2y5kKaH0lwL0b8KOJX9iiKzB3UUO69uy/hBFdlzOhuA55t0EvTu9dpwLGNABkLY35ZoYisokk6KxWHdiG73sEzeFOLJz5e+ygpi4w4XcgWUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB9391.eurprd04.prod.outlook.com (2603:10a6:102:2aa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Thu, 4 Sep
 2025 08:23:26 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 08:23:26 +0000
Date: Thu, 4 Sep 2025 17:34:42 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Abel Vesa <abelvesa@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	E Shattow <e@freeshell.de>
Subject: Re: [PATCH v1] dts: arm64: freescale: move imx9*-clock.h
 imx9*-power.h into dt-bindings
Message-ID: <20250904093442.GA13411@nxa18884-linux.ap.freescale.net>
References: <20250831200516.522179-1-e@freeshell.de>
 <20250901032203.GA393@nxa18884-linux.ap.freescale.net>
 <3a165d77-3e36-4c0d-a193-aa9b27e0d523@mailbox.org>
 <05f7d69a-9c05-4b47-ab04-594c37e975eb@kernel.org>
 <51daddc4-1b86-4688-98cb-ef0f041d4126@mailbox.org>
 <8920d24b-e796-4b02-b43b-8a5deed3e8fb@kernel.org>
 <be2fc937-b7a6-49a7-b57d-6e3f16f4ccc3@mailbox.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be2fc937-b7a6-49a7-b57d-6e3f16f4ccc3@mailbox.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2P153CA0004.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::23) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA4PR04MB9391:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dcd8e82-bd52-4f5b-fc12-08ddeb8c523b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xXTUuW5Pw3urREA2XDHXOJa3moTMz7CYp4eeUmC4tGU9KXPwkFFiZmKi9pgI?=
 =?us-ascii?Q?ua7qbSzpbwE4dXymQuduQpVIfUNtQ+3bRSAn17cyU08FXc36HLMzkNxLPWx3?=
 =?us-ascii?Q?lIEJQmPFpOjwbLd3bPOx3AXEGP042IWkd7zKCAYZ9G8UNLUwr16MwIRbWe5c?=
 =?us-ascii?Q?ql90hv+oOH5B3mz9T4vtY9zOt2rrcevf+m6USgio/HYJP3uYVsTcvGvl1INz?=
 =?us-ascii?Q?tkXZNyRC4a2mUMeAgux5RjuoIF8Bk8kSqhxqOWu/7NDjwX+v+0yCPxj5te7q?=
 =?us-ascii?Q?2ObPbfnjDVZXSefCUAMnm3L/1bVJ8knTvr+w/EnoYk4VGROwZkzVW14knfvu?=
 =?us-ascii?Q?7OpYqImXKdyPQEHXtuJQPCA4AujaSAp+25iU7IXR9SX+FkHm38J+Bf2DIYlu?=
 =?us-ascii?Q?+RnRMYuu2Qk7L5B7a4v0W77IJPTPGCCT2QgegZ40fHSdKJkYlF5Nur4MaE1u?=
 =?us-ascii?Q?8Ikm6qAu+JIy77i3sL73DotC5IlREDdfrc/XM12SQNY+GTWuLadZdOeM3+WI?=
 =?us-ascii?Q?yI5njZauraS9vEdcA51sSYP7jozKTKuP7vyhjMTLIjOQgGRgC9NeLxcMmCw/?=
 =?us-ascii?Q?DGI4eeDgV61A2H3M3Je6CsVTkJ4HJwJcJpWguzNbUK/X16tryBd3iMLRoHPh?=
 =?us-ascii?Q?9i+0RinwdIA4G1C1TFOd835ai9S20VBj1h7CVc84cFCdbaU4jhJ/JyHNRQWE?=
 =?us-ascii?Q?Of48G2J5u4QcNQZlVQsJ9aIfGyN5Tz/5fUY8Fw062LGHK6ajGGnJ1X2Fyph0?=
 =?us-ascii?Q?wBraECxJ0Fl1FlTAV9+tSCPVX5x5ueVIrBEQ1p07kXTmeNJObUtkqkOIXxqe?=
 =?us-ascii?Q?4tpIBnhkjf0ipo/s0hfQ0rKW4S5gP5FD9oNAXs9DsZ7829F0v9yOYx6LjMHT?=
 =?us-ascii?Q?v5YuGs4GvUz5tCusx4YIELUeLTZlx7mb8RBN0LlwwD1vj9M6WCsnjcxZaELA?=
 =?us-ascii?Q?RDQML6A6oPy7lrKYbkiPuKsraZ+5d5+Ar25fJp92VDiCsF/qy8rw/dqSRjp9?=
 =?us-ascii?Q?PRhEx6tP/0pJ6oPRss0B3bdh9XOKMAuNXEP+axwgFlPmyQ8ulvBl6zBtzZEG?=
 =?us-ascii?Q?FZKqQRT+2czzoY9S/CO/sWujPvimW1GbKBNuty413jJpr27jsXiZ3ynlGTdr?=
 =?us-ascii?Q?rovNFtOYnqf1DeAym1hFbEKlJQS0OY57B3urVYRKf0ZOxRpTmvgj9EaeedB0?=
 =?us-ascii?Q?mtkeUux7iL+kkJGcOEwYn2pQgtoKlkIReEYrD7myQDyRHAMT1DEdWuRbq4vv?=
 =?us-ascii?Q?pDxVDrpcoSRoSpRfJJSVTs9SNUq5RtGrP2vW3hjfs9VuWqCC8gPrx+4ECj7Z?=
 =?us-ascii?Q?NTcV9Yj6M4hlwZdRyKUQwx8PFas0L2eyruHJLeEHRgcX01FM0aupiIvdjIQW?=
 =?us-ascii?Q?aPYibP+Yarymd3Dn3cU5iDzrWGRD09MT0bSDFtTOpEjtxjPNZMkdYxnIaeOo?=
 =?us-ascii?Q?bNvEtVGUHn7pBE+3lPNeGY1dgGrg4sNlGT682ptRKCcKfHpi2aLhCg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aYLqJJX5YwR7lfFSdjjTgGvi3cfLfL6llC6tK23hxkszdLQjB+CdmOh0/1YN?=
 =?us-ascii?Q?qbcy7ra1Sp9S0TlqpeOAYrWQSX4o9dMFGNA9OG0YmYacKsWbE0pAL54kazFm?=
 =?us-ascii?Q?EadQpoVJUY7gUNSOUATyyTzwZeVEmKs41GhWZZgfQuA4kufIKsxSVkI8i4ZT?=
 =?us-ascii?Q?NwEjI8tDn2vt57671rq7Ciihx0cFERvzrBHNiujbryM3VJ+5zFTJ+EQdQCKi?=
 =?us-ascii?Q?JJKmJ+dO4laqDu/Vefupqt2d42U+sfQtlagDReb4REob1lqzZZeHVKkijI57?=
 =?us-ascii?Q?I76tbkpu4XNT15G0/APl+KVHA8JP0QKsvht3dlGaumY8UgW6nse5X1cZKo35?=
 =?us-ascii?Q?tEzK70Xl1GzBS08TKXUjhxfCEd9dyVbl2z/67h/rCRC4V6yC631s3Gi/10dO?=
 =?us-ascii?Q?qEqA+jdRO/0Ja4XbotAH7uZOXZ1olTi9FsZtmgmA2hoQWf++dqyti8pHxvUq?=
 =?us-ascii?Q?vpaxHhDiN5aaFSDaS4vZWFiJqfmcC85KRxnsnxrtga5yZJ8p8wL9NhTgg2vy?=
 =?us-ascii?Q?ntBSWBcuJfsq24QIhn4vvwYpI8l2AsBlkIROtxLQMDLNqE/szEEiuVPSE0bJ?=
 =?us-ascii?Q?Bb+uF/nYFCaAyKxoF7+Ulrw8Su4fcQHFCfGzi9GdHMGt3ao9++mHsuSXx/A8?=
 =?us-ascii?Q?oB8naI9PJmrxzcnROz4yVj6VcL6O+CWD2ENckJe4XSyVM0MbTAlhK50jkZWP?=
 =?us-ascii?Q?eO8YvST3xpZcHeilrBR6dazQcluZktMW/lyFb6IpGj36MzxNAcAqK1Py00Dc?=
 =?us-ascii?Q?mDXVeYJUvMtdYE07sIxcfUOMAVlT9qJsRFyU1u8sI7n8Vv7IG20Wq05nIE0l?=
 =?us-ascii?Q?AUlE2J9fN2emtzGZxQUeYwbPx015VsXGatzFd7n2ExJYn/hnXktAk3AmAoqx?=
 =?us-ascii?Q?PDvTEgmXmBWBrHTXADfwVzmoFoOCO23igfB7eWFJZ9gEudp6PhUm+20mPNMQ?=
 =?us-ascii?Q?/VHrzvEpbFB91rBKlNv7BEz/p/0ikt9YeIeEwJdL9pKaQpB4Wa/O70gU3/Bm?=
 =?us-ascii?Q?WPG4Pr+d+e0kLuQNussyORt07rkZm9nvutpiqgQ/U6CZZTMwN8XbLzcI2ETT?=
 =?us-ascii?Q?vcLQ7BniRrGGw+NnggONQLt9DS6a1Q+cpwP8Qj8PuWh1hFhQ5f2jqfT7Q7WN?=
 =?us-ascii?Q?sKbIkGhSb5RdJZTJIauX8MNeh5aN+GyH0dX2uoyMPxBwdm0bJtzlNnLLXyPV?=
 =?us-ascii?Q?ljWAW2ytlawp5LTFCawd0wQsS6vnuN8msa1PzK0GM4d4IaH8Ppoyb9iAMN1o?=
 =?us-ascii?Q?MdKVrPmy/YAul6ZAtxyd6GJ6nMwFQtQKVkQ0Adt4wLaz9qHee3pXzpFny5Aa?=
 =?us-ascii?Q?5r59QvNh0tIJveD/73v+CoBdht4zKORQoejrJTINexmT+XjKuchIpjQ2U1SQ?=
 =?us-ascii?Q?RsVnKvjm7m39TGwMGLd/XT3iqmSqRv7nGV7xHpY56uI7Atc5PPiAN1Q+igWQ?=
 =?us-ascii?Q?2A3yqjdFJSTynPPgHsxanrgSoLvje3hMO/b3XmMUaVW/SPVImfVcmhXcBkQY?=
 =?us-ascii?Q?NQOLkQyrAXCpTGxh0dw+4IV42SCFYKwk9MAH21+WrgDK2Bym4kvdtwGOJheE?=
 =?us-ascii?Q?ktGUEnufmyoGFMU2KGtvHRQ/FYprH0YCF0on8Edp?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dcd8e82-bd52-4f5b-fc12-08ddeb8c523b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 08:23:26.7663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EwkFdKr1/n4igPr37AGre5xM6I/4WtGQteHZWWNUkrjYNpmdYQmXRqhOR71botc0aIlNMt8xVmlX4uA0CcIV9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9391

On Tue, Sep 02, 2025 at 01:32:38AM +0200, Marek Vasut wrote:
[snip]
> Instead of playing this "I found this code somewhere, so I can do
>> whatever the same" answer the first implied question - why these are
>> bindings? Provide arguments what do they bind.
>
>I am not sure how to answer this, but what I can write is, that if I scramble
>these IDs in either the DT or the firmware (which provides the SCMI clock
>service), then the system cannot work. I am not sure if this is the answer
>you are looking for.

Marek,
  Some U-Boot code indeed directly use the IDs to configure the clock without
  relying on any drivers. Since the SCMI IDs could not be moved to dt-bindings,
  the possible method to do in U-Boot is to duplicate a copy of the file,
  and highlight this files should be aligned with the ones under
  dts/upstream/src/arm64/freescale/imx95-*.h.

Regards
Peng

