Return-Path: <linux-kernel+bounces-823963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 874A3B87D2F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 05:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20A091C87F53
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 03:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE79524339D;
	Fri, 19 Sep 2025 03:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="tNw1DPqr"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011007.outbound.protection.outlook.com [40.107.130.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2226678F54;
	Fri, 19 Sep 2025 03:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758252910; cv=fail; b=Iy7hrafBDYae9EeB6W4Pjuxu52D/hbLJtkS1HTElOf3ZVGGqRl0/8k/vC55xkLS05gUM4bplxOAkzIVeYPwn9FAlg2cXdMAgNtdKK3qnM1UabA2GXonATJ8IOvCXW6e+dU3lOxLDH2Pi7FqPNKoiYiFnGC0RK1FAXjTXkjn20Vc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758252910; c=relaxed/simple;
	bh=vaM9lx78voQVfY3cw3gZFLT8TFrYSNi19aRuxuKnKHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CdYD/55lnF2iO6j5Ek3RbbrsrFT3GJ0ko2XhNb4STmiWpWVXW5MMYMXGHHnlsR3gjpWm5NNvA+Qf61uFvf6neftHTjhqZ+inF7q0WNn5XvUtfJzboo3yWpTXcXRNhWv+dhLh9Qu+N0daQYBymnayO3x1ueD2rNOiPQjolQ3MJ+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=tNw1DPqr; arc=fail smtp.client-ip=40.107.130.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YNwEu82b3M3t8MzsrSD7IGd5reDZ6ATCVJOgZ2vewdkmglxLyxOFita7kz9uQe7AeGOVolVvslGFSxYNn9W2sRH3XsBQvIDt3vSLdRmsWsL0gNvG+qULEr2CpLpQ6kpRXznxvkpknKi2nIIU9DDjkZitAKvPm7n9Nh4MwpZBepm76rpjVK7O2OshvOkCuHy2UDQQtuiQ+iOjSPk8b+y98A0rE3Fq7Z4Fi9xBk9FHhG/CUBR1bBRq0UfN7huhpangQWRkGFPS/VmwPR4dxi6x2CG6bA7hy7q8h+4s0RHV/5ChzOu3yd9UuN0mJ7sc7y+aCCD7lQdp7vzig0RMbp/+oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vaM9lx78voQVfY3cw3gZFLT8TFrYSNi19aRuxuKnKHA=;
 b=n6RjpQpEKWI0Yll6EFGzP4x7vIxRpnaxMPu34Fqig/awHwiMI44mB1o3Pv+qfmgLGISzUlVqes8tP6UMM5teV91jMaqerYyGJ/YpM87QY5j5fRzShznlUbd/etgXgVdXuuYSaCEMBYnjMrutF/O04QLU0nibuTVXyyBJ0AT4PnUBwORKJbSfMHS4g+nsSBA6A5ufGotIfUDBJfagemH8NkUpC3CbM3ZjJZ2bXrazaIYT+mZAADJ6jXzcKkpxG1bQggMZQzk1kheEyGFuN8435bFfewAPVsIa1YBMtUVsVzYnsL9FkZZsW6qffPCDElPdxAgz1w4fhMxpfy/2ndiL3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vaM9lx78voQVfY3cw3gZFLT8TFrYSNi19aRuxuKnKHA=;
 b=tNw1DPqrNhFqs13cWjqPp/U4HLtbkG3JGqnQeaABR4OPYTGMUChhUF69kFpIkYOn5JBmblZKLH8k6HANZ3q0zCrSBElycEtN2kUKteo35d4S6TDDGUbwpJMdLpanrpoEYu7uJPo1utsO8TvjvPT5npuwViEFfdgaTkBFpghzjy8JhxG141DH2fmbjpVdlby3+uXqn5DpUJ+oFdNGNJUTYFvTmZrR653oBUq5DHK6J/kyZ3NiDTc7Qjgr7b5nZCsIZuK+56BqUVmJ8G+/u/9ym7DreAFw+dLw+uVgAzodLTJdnk0ydOLNwfMFc710019Ms+X4O8qO8T4tDBlWIwai0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM7PR04MB6872.eurprd04.prod.outlook.com (2603:10a6:20b:106::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Fri, 19 Sep
 2025 03:35:05 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9137.015; Fri, 19 Sep 2025
 03:35:05 +0000
Date: Fri, 19 Sep 2025 12:46:44 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tim Harvey <tharvey@gateworks.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/7] arm64: dts: imx8mm-venice-gw700x: reduce RGMII
 CLK drive strength
Message-ID: <20250919044644.GH9196@nxa18884-linux.ap.freescale.net>
References: <20250918154451.2531802-1-tharvey@gateworks.com>
 <20250918154451.2531802-5-tharvey@gateworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918154451.2531802-5-tharvey@gateworks.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:3:18::19) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM7PR04MB6872:EE_
X-MS-Office365-Filtering-Correlation-Id: a6669033-a950-4d15-e62d-08ddf72d85e7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|19092799006|52116014|376014|1800799024|7416014|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?gu+LeGyM1ljGldC2uQnS2pwW6+Y5al+subnpSDTiu+G21aSxViKZUuVKQjJY?=
 =?us-ascii?Q?IeNxgpZDwdhSpD1D4d5BAxAoz0BYpG6c1fknrrj4jZhYHaB8o5IaO1hNoJgI?=
 =?us-ascii?Q?93rlB6dA7qF/Cr5I2dx0dvRdUnftaGyhWaEsjVLViyyDPqy5ehHFFa9tqi38?=
 =?us-ascii?Q?jiVy7XGr9WDP5bXkNF7l/+vf/D7/siFhYFNbkUxk6Jto4XrHkGNfKaUeRLCk?=
 =?us-ascii?Q?+y8r+UNPPtaJmoQkHsHuqtJI+tmqr80VN5JnHLpouTb7peAuHfMb13M9p6LV?=
 =?us-ascii?Q?Q8NZ5yNJFSL5mkop/QwRUEBPVyuouwa23x8BUyksy9nrASjxD2dHRBWMoTRu?=
 =?us-ascii?Q?zFUNJJMTJMCmjf9LP2jPLLNqw9wz+NYbjn1icT5rl92bC2N1YY/6Q8yQqnoL?=
 =?us-ascii?Q?A2n+0aUN8eteXWd5yVW8NWWfzufubINhWsT8qCCS2xhwwMnfX3q+CaL1yljl?=
 =?us-ascii?Q?cUggww/VF1HhECHoSEq9QEEC49ZbCnhX2+0dx9V68GbBFFUM92HZr1fuxBk0?=
 =?us-ascii?Q?Ur5ts1b9/89GiiG1bKZTh9dvdPIn4HfZODKHHevBpZ4POwxCru4KaHw2eSAh?=
 =?us-ascii?Q?Q4g3bxvh/C0Z9IJbbgFp5IaV36xXlj/5nPj7N3VEfhKObXJZQ+KM1XCapMGR?=
 =?us-ascii?Q?Whi2ae3Jv634ndZTtBGSmXBXkuyhND0BKvp6k4dbFOSDdG+TDoisCOerT7to?=
 =?us-ascii?Q?4UGogH0EWfPDLTkPhOpJL1jWcVKgD6MhTelOTBkBJAT+jgJDVAL8apUSibLZ?=
 =?us-ascii?Q?QZUfkQ2Jv8YYW5TaLodcXR0U1W2CJh0z/dK5y8TpFL8EFNlQsV5Mj/YgKxur?=
 =?us-ascii?Q?fgk/zqw3uyT8hsBqxuOCCA4k+n03iitevmKwTYHAIZ2Z2J5BDIEZg3415kKx?=
 =?us-ascii?Q?o2adoqy8kw+OOTVoLuXWJ8BunE4P3FwfvF+ks3YS3QBYzWzGz48Pq2tw0p18?=
 =?us-ascii?Q?6QsQ5/1UaX0+X0I53+trM7KDem3phC0gL7XkjqoPTTDfESXydT1SmnxX8WHP?=
 =?us-ascii?Q?39MZnxqamZKVzfpwycNNetWB7jt4xx7s33huGf52GplvK7d/2fERjSMbnEb+?=
 =?us-ascii?Q?PMuVlsMr27/1YAklqjW0cYJzcec5VqInW7AasPp9CvY+D3Y+f7SOUUNx7JPl?=
 =?us-ascii?Q?LdU+JudYMxGjHh/bfUqFzTLrSWkKxbqnxnMPVl1Iux6NiVd1se/DfI48APqE?=
 =?us-ascii?Q?qfldO84DbaFWhcVhEq7l4mR6A58RkUZ7uSpGTVvGdvvLRTpTc/KUl9/Qm3Er?=
 =?us-ascii?Q?SZOu7g+xrnZMAAEtHYvd3lw0W8E99BkspQTw+R1DabsjlRSKHhwFn4riFypY?=
 =?us-ascii?Q?fslfFhLg83TtzNr/YrHhXd8h7YlvP0JBSzyZoHK4sPpWgQ3rddSO83qPjeFf?=
 =?us-ascii?Q?L8QZQrmCgNsKA2NVk1VdjuVq/6gk92OiMkM9CVIA0mLR1CAV5I5h5FoeKc7f?=
 =?us-ascii?Q?DgKJnfpcBadMZrvnBuuFGWDgmNLZmcvxb31h/AMjF62uO4V8SF4Yrg=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(1800799024)(7416014)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?p4Ppwrd8b+4sgUwCKAQdGGbCLV05GqfBCMWqkhMxxIlIbZKVuS4KsOXmraDf?=
 =?us-ascii?Q?4WiK1KYuOixQSIWYw1+OXELME1xB0yV5SDCJlXAuayj5bMr8qTPd53Fevnes?=
 =?us-ascii?Q?o+DfSs3+ZiYZ/mv8NVNSnV2BdEn1Mh0blshoDmsIxXRkHps1AZ1VGWVMdpNV?=
 =?us-ascii?Q?IcedExozCqU93aCU+h8JUDFZBNehx1PkmjWgUqQUTY5RnF+SkJSKnx3GOTtW?=
 =?us-ascii?Q?PDAQpsSm/RAT38VPI3xy7WpROgx5P5nEFpQP65S9BOAyOpd0DfYnhxLwwiYf?=
 =?us-ascii?Q?o+kP3qTDLySWzSULL0P+vpB5riajq3zcUoh7tsijVV8ihBYsuHbglPLSS+Y6?=
 =?us-ascii?Q?izjy1tzh3nyoHj4bmkqFrAzQdSb2S4gjZnZ67b2SV9gK+ZxVtbC1yLOOkZTh?=
 =?us-ascii?Q?KISRopHGzrq5mY4R+mf+U0q5otVZWLVZzJ9CLMCG7xK769t4pYjKOnUn9vu5?=
 =?us-ascii?Q?olHHe/RAqpon3urZOfByq1JnK/x3UrlIoOLiebwuq59duzYOfOIk8OLExzaa?=
 =?us-ascii?Q?SVtsY50SL+NNjrFp4Bk9ifnpWLDbnSEUrC7OmmfJ2H2HSDGbST2SiKWB4bsA?=
 =?us-ascii?Q?Hc+lprLF213TPvAEGw+AEOsopLLcwPIDYmi3hhtvR22R9dPv+rIiTXgrpWcg?=
 =?us-ascii?Q?CzvCk/R00YO1gbRcWTkRiqDz3hph/XS1quXC0CeV3PVQ7wnC6pz0a10vNp/O?=
 =?us-ascii?Q?FPaRJCH3oU1vNA8XaQI81KzDCf2lsOSFxjyh0Gdyp0F5JqSd+o55DlrEXwQa?=
 =?us-ascii?Q?xj8woSJ/VvjpM/PbsXNYBOeB8ZKLUMYe8/HvapN38gXeQn0yb7X0mq0aIPjg?=
 =?us-ascii?Q?W5l/NeRWtQ6rUqfESGpQeVdeD/a0q+QUPYErd7/cXd0Ggpj/gJUM6RScC2Ts?=
 =?us-ascii?Q?+y2ZUAECtYxb9+69Xr634LobwpcN/dXfsM9K/CwlF4lKPfG5qy3Cp7VmKUfo?=
 =?us-ascii?Q?lE6GaKtHM3aG04l4DhTB18OzbPVgNm5rxvv9qNiL1eL3G6pNa4yhHFDehRUB?=
 =?us-ascii?Q?WQ1AN9BeiFtfvIKECLxSAsI06L9P43sCOEONKKRfTogxJz8w/b9olt3mrKfg?=
 =?us-ascii?Q?sp3eqRi1HRI3UZr5A/SAgOlPA1uEppYh4bDKma/1YPW8fPWiEHendTvCR8Fg?=
 =?us-ascii?Q?BhRaZk5CXPwTCcrjNJu63nr3E4gv2svKLTM63OR0SAOH2LPrliyN3G/MzH7g?=
 =?us-ascii?Q?XEhj5mH92l/Xi4wcb03KLkbNZxMs5bn/RiCx6EANsS6ri2YZmfS/Fi2LcrOW?=
 =?us-ascii?Q?EBQ9XyHhfYcFizC4fmlS9dLSmXoDkN0+32CFXuJs3xdGZEYxunSKx7cTC/l2?=
 =?us-ascii?Q?EPcGEtX/ljxa8nG4SZkExDXcLC8iTqF6HbiqmJXo2l9fMUnQ6CZ8G4m9H/+s?=
 =?us-ascii?Q?VsyPiIkZd7LtEkZweeduFUk959gQwTkPSiX9cPCcg3Q/GFmhl65/5Dw5Udsz?=
 =?us-ascii?Q?siBX3iMneWYFMZusOfz+cjLfcEG4JNO+z78rke9JFcEHIRCWA58HdzQA2FbM?=
 =?us-ascii?Q?h0UVzsUBLWcWwUyvhw2JjsYsXuqbps49DkxAZgoNk9p2sOq4B/BKKOIWkTJz?=
 =?us-ascii?Q?M2+Kl9ebwKnReikX8q3Co7nOuAzTLo59GmjGw/F0?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6669033-a950-4d15-e62d-08ddf72d85e7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 03:35:05.0097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AjTzpz5tNzGi4JtQJmWpLmjEwCbd+v+ZIMNacjhl9W/sPOmimBDxOwdBCjtStr/eSCGpchhaOKC8sH1x/k1I+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6872

On Thu, Sep 18, 2025 at 08:44:48AM -0700, Tim Harvey wrote:
>The i.MX8M Mini FEC RGMII tracelength is less than 1in and does not
>require a x6 drive strength. Reduce the CLK drive strength to x1 for
>lower emissions. Additionally since TXC is not a high frequency clock,
>use slow slew rate (FSEL=0) for lower emmissions and improved signal
>quality.
>
>Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

