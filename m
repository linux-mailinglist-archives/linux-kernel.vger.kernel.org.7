Return-Path: <linux-kernel+bounces-784167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F11B33774
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 09:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19B3C1887052
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 07:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41DD26FDBF;
	Mon, 25 Aug 2025 07:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ScBS+hvR"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013031.outbound.protection.outlook.com [40.107.162.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88111FF7C7;
	Mon, 25 Aug 2025 07:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756105854; cv=fail; b=Cz85/P/JxolrzWDldgJ1iEMjh6zGE+8M0eEdhurIgmFDQd8YaQFMt4UKtwKAUAqKpwX1Yw6Q0/qwjGCYCSvdhoiDMs3+TXeg7E1VejGuWuZWicxs7NTVjoA1aJnmHUc5LWM8vKFpQfA8e4bVZBI2VHRaVruuZDqeoIu8OL5kKQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756105854; c=relaxed/simple;
	bh=YzbfEo9/6gEWRbcah+ubZmCiuaF4ZkxUjrQvuUOroDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RsA/v7zqLRieUvPd5GSqncD509jDTSdMsGGsAAYQcRBAT/HYnxR1EvtGB1sgsz2Ht31YNGNTbvt5XRP6ar2EaitJDJ9iqrYWPcMXAlhtmevpL6P8iVTPxbUej9b5teLnZxdJgMM0i0YbwClCJphl2DvW+aCbvtcCqVxvHpDnEaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ScBS+hvR; arc=fail smtp.client-ip=40.107.162.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YkKp4DdoU6EHSMB4QuvQ7rXATCvZl3NfL/Bm1StJNUyHEpqZTstfjgs3a6ipxdYelBmvUC3lrFcUzEPppZWSIoM7FSJSo5UWTnCx1hdRxq0qZaT0woaOTC9jHmHTacFxuqK+p0Gp0Ay6yLbLD4TRjLKwMDO+uNICUYwir3sOr1xXkzO1wkXW8z+nC3bOiMrnpfuopVPG5bjkSgFWpxvqQsJw6k1B6S26o2RtdOy//h7rsj79ieu48bO2JNtXBGx99SgRVLrbLJSft0V8AfN4eZmzQ1TyW6yfUUcQpr8YZIcdmz69aOtXYuvP2wI8HaWPS4qcZCMMhXVqlbg3iv1jZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YzbfEo9/6gEWRbcah+ubZmCiuaF4ZkxUjrQvuUOroDs=;
 b=OlKyX4UrNO2WCLER8YGpPSNjtZMB70kUSezM9Jafgr/siWCQOaqUNAunrFkCuDVlIFgKD8179KtkK/GEZB+ukaCSW4hHwT0mmPi0OO95angWqOUy64cbZM0D+lqfEzn5RuF7xT0PZgEz3fRz31+4eA9emJPu8lD5nYhiIfFZ22RpOX9G5tegWE/Wqj+8babDp167WbjFX1zU0Qo93oPwWI+CSGbo2iOrjXMo+vbjHsN+AmDHlNDrmPRXMitJO8bAepl5slEkekjVY0bD9ONo4Gk26lMBjzuuZdO8csmryOU36ma1AFgSkNQC9vqLFYZmfXJZwGA1JT83GpwXX1Qzfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YzbfEo9/6gEWRbcah+ubZmCiuaF4ZkxUjrQvuUOroDs=;
 b=ScBS+hvRhyUf3aTK5hW+SkopXQS+ptsh+yXMZMomXm2MYJlwH0IO0lfoTi3Jo50NhanoxKuyvFN5CJKJcihDDUXwpd60yvmYHDqDc5w5ML2mDMObEyXHjDr/GTHX32syTlEge5FS/XKCanlc7kBHsWrNSfblJxToldZ8T6Geu1ancAUn4RdZf6PsuHD6jICd1g3N4EhMzS9XMPUJIZpbrLvkxamtT6eGPglkAM/wkSp6zbArSKG3sdhFD6tJVlJ2dLhHIWimoy/naaNzXh59z6+KYVSliVCFL5ZBu+zuAXvhTe21JqH2BJxi6HL9wpcFAbUU5uoWkkDVmHR0KnsBuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAWPR04MB9741.eurprd04.prod.outlook.com (2603:10a6:102:37e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.11; Mon, 25 Aug
 2025 07:10:47 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9073.009; Mon, 25 Aug 2025
 07:10:47 +0000
Date: Mon, 25 Aug 2025 16:21:54 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, Shawn Guo <shawnguo@kernel.org>
Cc: mathieu.poirier@linaro.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"open list:SYSTEM CONTROL MANAGEMENT INTERFACE (SCMI) i.MX..." <arm-scmi@vger.kernel.org>,
	"open list:SYSTEM CONTROL MANAGEMENT INTERFACE (SCMI) i.MX..." <imx@lists.linux.dev>,
	"moderated list:SYSTEM CONTROL MANAGEMENT INTERFACE (SCMI) i.MX..." <linux-arm-kernel@lists.infradead.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Alexander Stein <alexander.stein@ew.tq-group.com>
Subject: Re: [PATCH V2 RESEND] dt-bindings: firmware: imx95-scmi: Allow
 linux,code for protocol@81
Message-ID: <20250825082154.GA26152@nxa18884-linux.ap.freescale.net>
References: <20250718094723.3680482-1-peng.fan@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718094723.3680482-1-peng.fan@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2P153CA0019.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::10) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAWPR04MB9741:EE_
X-MS-Office365-Filtering-Correlation-Id: b41a868a-7ccf-4e29-0ba4-08dde3a683ed
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|7416014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UFyrUCZPX0AQ62XL4ov86JklXG7V56R1BBmljPqWqbU+MqZWbX+5pbB/kqcy?=
 =?us-ascii?Q?erj4n+ex2KOnoTycEWz0a4U8jtRVAJbTIOt2dSdM/q6uOeVrV4vRes+RA0Iu?=
 =?us-ascii?Q?iCr934rl6ojtY4mb73dwqZ/3iP8BBj33PcE8xasIXTqzVf1uQu5gbmFur2B3?=
 =?us-ascii?Q?owNZBsgYPeKPSLZgEDCH+EgS/a8Ts0z9alwtve9WGMumccwyqMaAMp03ABPL?=
 =?us-ascii?Q?UxWs7sBBZfO3YJx7qJRgk4rXHKH9f28jJXpB5KGpeEOZiwXO5BNlnn5jR7Yf?=
 =?us-ascii?Q?GUC33HAzoJ+pz106C73XCS/9SgwiDTPH99duO6qaBsLQMyVjmfGMuy4RNCwa?=
 =?us-ascii?Q?zvKRWZ5ppWbF6h3ct8oU5uIqlZ8wjDsbQ4C2O3e5QjuOBEgsUlK3z/jtnxkO?=
 =?us-ascii?Q?swBHtZ1b193YqY+69+u1eMb7R11JR8sdfZ8ao0hUKt3dLEIxCwyMbV+2Z6CM?=
 =?us-ascii?Q?JNd9rEXbDXA858ou1JYnHDqXYksGE8MF278KiP/okCpUn7ZOyYXa3yBUKmiM?=
 =?us-ascii?Q?6uDaYdCDuMOa0bcVY349ZNR4dlFq5MHFBM7th2pByPdd5RXex7KWlo2eyKer?=
 =?us-ascii?Q?sM5O1IeuL3Q4UtnYd2XpRxiS+JM6bGozq4sX1aG5bADLEu3WZS33/dOXsaFh?=
 =?us-ascii?Q?ISmaRRX4QtiLBfWZYz4Aypm7oeNI1XidGaANagqHUILBtWrVPL2LbK/tQfbx?=
 =?us-ascii?Q?7XHwL+NZ/XPunr2t4pYdXdMCl8Ybx1khQ6llt7KrZImy5Nd21dMwfydIvaft?=
 =?us-ascii?Q?8EIx0oFAI80S8kAd7a20uQVLYaSL06LD9VTQKFKJgfdjzUy5zQYW6IeU32/5?=
 =?us-ascii?Q?7A6RiIPme18gMJgeT3vKTqozEB97qNVGm3Yy79pOKTrzfqXQFOzAURtrSQSH?=
 =?us-ascii?Q?iGbvRn+ETJ2fTd/0YNXSEWXb9VRmVPM4ovtXuJd9EeCrWWuVM3UEYdkkxVnL?=
 =?us-ascii?Q?enDOk0sWQan7IHSOwH/38zqQEtmmAeODgMoJ0050farpn34Xk8kwbDJF3Af5?=
 =?us-ascii?Q?TOF9U7aQXP8mLLotNiW9k1qkPtEcN899+7Yw64Sa1nMj/BGlZU+R8R5qMcVF?=
 =?us-ascii?Q?tQfAT8dArJNtTq1Yvxz20pkDfcuuk95RyDUDtSRb/atd87AzgZR5UlRdoFHh?=
 =?us-ascii?Q?LYHN16vjsxi3rvpCwkXiNkA0gd6A7jIL44rNz2dGAG6pPmZUSbr3N1JfxUpc?=
 =?us-ascii?Q?k2NNxqgYHskj5Cfs8f/yENT+4P9Mdu035wW1fvVGobc4mA2/c+3zOFTJAK+1?=
 =?us-ascii?Q?8SzMpx8sFPsOWR7Mxw+ICBojgk8ZDTPtt+1vzcA0CTD84r9kE+9SpP2MQJLc?=
 =?us-ascii?Q?wx3BWHVzr2BM6/Cs7HaqzeVVFge18CkOUlx4Qs/MMFVDf4vnW5O4+8Pq9hb8?=
 =?us-ascii?Q?+3Wg/10WuOMSnKKfptTL0bSU8THWcNYb3OVVfZoioIfujjbNZ9n0ekLnTHfw?=
 =?us-ascii?Q?soufvvXQD6UD6JViqBotHtP1sy0TzyjxhCq9K7t8gXfFaMYTlUgRjQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(7416014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?11xZ6fC+HMjs24RZSLlvC8j3vi2/k3Eaf7NqlEwevZwchOoOJMFseIgrDtKZ?=
 =?us-ascii?Q?/mpMk/yYpnZDsPc0JR/fOpbbkyBlke3SzhU3D/c339kf1SAQNUkI7ugyOmGQ?=
 =?us-ascii?Q?I6b2X7wjRSZ5A+3IdbiKxrf5dV1N48UvMAjboreORylaRf2427BfbizFKIZ1?=
 =?us-ascii?Q?pjMmYLCHKstFqkxIYPXnkstGxAi64h1XslcCuahZ44ZBCT85gnzaKEDmJZno?=
 =?us-ascii?Q?LKpKKPWXaPg64PcrHhkVj8ECQsQjHxpZsd5Vn9leD9oUTccEQ4zYpoJ8pSUy?=
 =?us-ascii?Q?L8FWp8GUi4MQ8HBDgpSKJrJCyfnEjUCQyfWCNJMVPPYPNjHroDYcqGTgPX3k?=
 =?us-ascii?Q?DErL+dd0taHj8++3vCchsCRdRH5ZWYA//ghhTRszqZpqjbJ3CGu5a3iMXXCE?=
 =?us-ascii?Q?8arJD0A3Yj0LxgjgvLdNUxeWXQ6AIOjnbRRt7eldnFgbQ6295mDDxy9IzSjn?=
 =?us-ascii?Q?Sz3qP8uwnHC6LMdnV3qBGKCLUz9l/k0VB1h4dca43VNfk/FEAXcfJcydAT75?=
 =?us-ascii?Q?Z9OzrIm2F8MS5QKTZTAEHnRCS3xiEK9CRvios9G6eEPGvrOwgQTsgASt5xQ/?=
 =?us-ascii?Q?NQ2JeXfWB+C4Jvny1XOEfDFtKCN0ROtzaAgnV415iOhHq/Hx0jmAW7oIEesv?=
 =?us-ascii?Q?I4ZPeh05PrZ8GIv2sc0h2xsQkd2E8khBsuEWjg3KHzxtM6E4sGa/5/JeMFO0?=
 =?us-ascii?Q?Z3eNHR9l7VAb/HVhpdlIAsBI3tu1pTB3AUDRIxwOsvKtm15Maqkn8GjAcryb?=
 =?us-ascii?Q?6uPi6J5UnGcVvG78GkkDYQgE45SyuO15kNiRYM6fgIO4YqEvAgIIKG3mCUw2?=
 =?us-ascii?Q?icB5oxgATzZuRDdHMN4yazlDOHdFS9ZLXLjecbYeLjRiQIWjtidgJmaJGm00?=
 =?us-ascii?Q?HJgFDvqy3vZDRHvMNnrJWKdk0zB9r+hNf8OPQiMgdfLwGXg5Y+iBkiUtRBeW?=
 =?us-ascii?Q?+2fYplD/ZbxeDv9FXJmS2JB2aXMWbO6JsdELTGbI/bkO1OtNevzclBPocWBa?=
 =?us-ascii?Q?yHDKjaymFDKoUf5Kx3q/cQrVCu8nbwsFsCy3od3YVf9oGAXKWlxEKElQ7u+F?=
 =?us-ascii?Q?O50/LZj6GAGHzJn688U5bab68iwDmEmlx9aFIT5IdmN2I8y7axXvw9CGGvWH?=
 =?us-ascii?Q?CrEmKVh+ydvDIzS1Q4RlLvUiHBVYHCnVgtPxBVwmDkLKzpro0dEZ2q2wXUKF?=
 =?us-ascii?Q?rk3KLEM4/5SO1rioKoIvnKbNnPFcXkhLa/e1q6iaggF8U9VvC2mnnlS/DT/K?=
 =?us-ascii?Q?Yr4gh3uy1TSuDP5oDi7d9bZza6pJw4QnwGeeUL+6H5+0dF7sQdPXrI1Czdys?=
 =?us-ascii?Q?CA1sn5tAA4XXjfatC4/S7/dpRQDMYwHc1bUEW9KBhHNtNdnFYU2R6khJp+D6?=
 =?us-ascii?Q?f8fmjw+2HQvUlUd6TIoU8Oi2BNYN87VZePC16DEmC/R+Utjj5Pc0/zBqaJce?=
 =?us-ascii?Q?eENY0RwBUmJ19Qbw6vaeJmPiqNkYp4RPEoa342p8DAy6A3vACMQcSpUsigWZ?=
 =?us-ascii?Q?twTQdPFdYxZWxrh3C3SneCYpdqciWMn1CyNR9sOvKHyeJsoH7/O935eiAjTl?=
 =?us-ascii?Q?z4hCbh4t5SM0iT+3tMRbJi7G5sON4bIhF9Abwg5Y?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b41a868a-7ccf-4e29-0ba4-08dde3a683ed
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 07:10:47.7626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GT2mShTjQqWuDYO5ajInPbMBYTSzjy8+w9sWWcaboymRFhhg0HO3auriI4rLB2ADKEl4M+Tdtf7kyjuAx83IMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9741

Hi Sudeep, Shawn

On Fri, Jul 18, 2025 at 05:47:22PM +0800, Peng Fan wrote:
>From: Alexander Stein <alexander.stein@ew.tq-group.com>
>
>BBM protocol supports a single power button, supported by driver
>imx-sm-bbm-key.c. By default this is KEY_POWER, but can also be overwritten
>using linux,code. Add a reference to this schema and add linux,code as a
>supported property.
>
>Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
>Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
>Signed-off-by: Peng Fan <peng.fan@nxp.com>
>---

Not sure which tree this patch should be landed in. But would you please
pick it up?

Thanks,
Peng

