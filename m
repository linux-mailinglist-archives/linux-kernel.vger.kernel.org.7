Return-Path: <linux-kernel+bounces-861156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 73417BF1ED0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7196E4F4927
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AAD7228C99;
	Mon, 20 Oct 2025 14:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="V2aSwxu5"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011022.outbound.protection.outlook.com [40.107.130.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EC519C553;
	Mon, 20 Oct 2025 14:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760971937; cv=fail; b=t1/wH2VvhahQ2fCCbMjMVztLbNEuxSmkK5cfa4/D6/lqAqSdVGNvkoHBHSXZZEbQ9anb4O37o1h0PSt/PBTDounO3I5D0Q1NMATX1pr/etTd5EA1/q3Ce8HSN31atW/JmPzq3YCtpQ2/dMY7IyQ1PFBmoz2o91N1/tM+dkKhekg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760971937; c=relaxed/simple;
	bh=Vgix66KUXhNWki+GWa20aakNBc2htuIsKq8oCIukj3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZDC8T2udLiFk1SqrAKoZFu/73UzNb4DTz0doMPXibHJlgccZg2aBuV/wEXgpwUu7HMJHkid+BUTwQodbdpleCcUgOgX7FoR8jkveS1RAAzXqtb3+UgRq12YEX5pxqXGvxmS7R5j2GOZGI9CBHxhMLAwxcCc4psN0vESTAT3LFvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=V2aSwxu5; arc=fail smtp.client-ip=40.107.130.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xdSsoaXwDPNyNq5cblAgDG5xxK8YYbDKgo/uQDNlATtCgzoK8P+1eDuChKdHhQDCjevGPQDJKzEtbLO1rcb2uNcgdeqYKpZ38QJXPXQjDBfoQhXBN/iiXsYqV2cGMsO2r3WbHVRUAAixEDXyE+OLS7o+3Oc8rZqomPrukRRj2vDM6f944vetZGyiLjYiP0Fm8xm3jKnxPXke2GsQ1LFrgBsMKuuH67x+nl8NLDmKr9ZJGDkMQyM1NgrftBzUKbgOmiloeT4ffZrJ2l60c5E+wREGe9vfNU5uJNsJxKCXLDP/7TZtYz8YqSxv8manJtslFRStj00SXWnFAz9iXqS0+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nK5uje/qGCsMrFwcX/2QlqH595IrFQNjCmvoZu027hI=;
 b=xTaZNMHz8NA1Hg0BfeBVfn3iWGKWo96/yvLyHRFj896BJ2tNu6TFH16VPWYXzuwm4FjSO7rjDQxIm3MBgSV8UnLr0rMAG5/BdXOgT4KAOkXYspIBeED79w5cYjCTsjFIEv3nuRuAG0RsCNYDeOLw93Q6UYycW2SYVedS+v0o7pby5Ca87X+gLNwE39uYh3a96AdDiPM3b7fypYr2Ykg1FP6YLKOqHQTGohkm5NsFk9H+fieQ6s2eItobB5PONgYS/6HEWsNI38W09Z9M+uDly2UN67s37i0NwivMOKHo1dI6WZ6Dfzg1bZZtomVvWhjaugLZJcz3a20gH3fRHEcTAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nK5uje/qGCsMrFwcX/2QlqH595IrFQNjCmvoZu027hI=;
 b=V2aSwxu51Ix4CgoT1Np1Usj9mkQLJIBBqjiyH63Hyu0suXVe1iLkwGAfPg/GDAcn+O4pJyqxW6LVZEbCmhrd+kJsRbi3JGKz7vWqPLSJj6DaMcFfiTZ9+Wjj5srNmmC5rwSIHO7TbybI3iXscaeSlJ2i6y/E/o2RjV3a6zUz6/MAVoOV6A3OcKHAHK3wl4TZCj+A8OdL70CSyLsOLVamqlcdm/W9ASHxMLXvPUgaESz2WuBslFEoNdSI3kWNUV9azppXgqVXpsG6/gy0vifLEBn7JK3oY2O7sZSkIg7vUPXPf4caz38k9JirxThYEU99ANkWsQp+awTs2Ftr1VSdMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by PA4PR04MB7519.eurprd04.prod.outlook.com (2603:10a6:102:f3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 14:52:11 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9228.014; Mon, 20 Oct 2025
 14:52:11 +0000
Date: Mon, 20 Oct 2025 10:52:00 -0400
From: Frank Li <Frank.li@nxp.com>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>, linux-clk@vger.kernel.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v2 6/8] reset: imx8mp-audiomix: Extend the driver usage
Message-ID: <aPZMkFRyOObj5lMo@lizhi-Precision-Tower-5810>
References: <20251017112025.11997-1-laurentiumihalcea111@gmail.com>
 <20251017112025.11997-7-laurentiumihalcea111@gmail.com>
 <aPJZCv+iG6cuxsj4@lizhi-Precision-Tower-5810>
 <1bd36f10-aeb7-47d0-bc9a-e2078d5aeb86@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1bd36f10-aeb7-47d0-bc9a-e2078d5aeb86@gmail.com>
X-ClientProxiedBy: SJ0PR03CA0371.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::16) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|PA4PR04MB7519:EE_
X-MS-Office365-Filtering-Correlation-Id: 755215df-dd0a-444a-2882-08de0fe83fd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iadB87BssVofNANb9qr6rZi1+SnYaTtI1Zn2L14XefIXTvQ8aEAEGlZdd6sz?=
 =?us-ascii?Q?/LP0qwxYrswiAtSIHdWG9mpc9xaNZTC3rleDBBsPQ5doo+NBvHSYfnWKG9sI?=
 =?us-ascii?Q?wWnmMPdLRd31/c0zrrEKm1vfgcy4bTS4x+BDUSk26KDdBtt5BD2JKKfaIqMI?=
 =?us-ascii?Q?Or9Wk0ssQsVs7aH96IWSazVcUxaLzeYCiaXMsy538m0D4xUBll9R4SXjYBCF?=
 =?us-ascii?Q?ixilW21bupPFbfgwVEsFq3LV05s9pVSMokFiuZOZ/kJh53AgKffTvjp5Mivu?=
 =?us-ascii?Q?tXqtBTDGE/OHvoVMjGiPqntpIHD3Ex2UEOKpBrpxa+KchReAenyoYDVk6xqR?=
 =?us-ascii?Q?85rScvmNG/6iIfqegTkaB82AnYhPG1ltJGLlIgGHfyR6dLHwKI+ytx33dV0+?=
 =?us-ascii?Q?i9dhVUPuEAucEUljeakW9RbokjXfXaTThctYcqx6toOsvlZUTYg0PoXZXQgb?=
 =?us-ascii?Q?YiBWWxJpRhNWzUm6BgU6B0NxZTOUlnCQlit0X1DGXTXdUXGY9oASv+yOb3r1?=
 =?us-ascii?Q?rrMrCqxhbZbbbs+qDWMMg63Osq4IS6TiYdZUiH+8tI2WhTdaul69KlJIfyfn?=
 =?us-ascii?Q?ymHzBKLN1ntrwTiBaIzHj9So9VMvK7I/UJ0xpItvKz9lmEIGCFuGXfQksyKP?=
 =?us-ascii?Q?g2z6hf2FfEMR8TLgTdz1cInsBQelx5hvZ/zANc+HP6aSPvXDDXn/SKNeKMMI?=
 =?us-ascii?Q?0qMoA6++zxt4vV2KaNqtok8HeLTRr0/SH2/Y6ud/Gd2R7VxXIu8/dcyBOdxc?=
 =?us-ascii?Q?5yICS/wC7jumKK8Smqx53qr8jHzc24BDuEoJ08smfauZua3qOp2p+WxTUJ88?=
 =?us-ascii?Q?o32z4WiWa8gxW69Q7njFJdLSgrAPBph9Knk1K13g3FMPiOZprHY/rWo8UuyZ?=
 =?us-ascii?Q?fGEdY5rO/jFAb6qUdGVRV+GvzYwceEKVm3PihGBEn5ESXyp7gYN1rrrleTKG?=
 =?us-ascii?Q?/ki3zth5amWvOGwipc8BY6p0+kcwZLKjE2MkQRl5TPgaiJICu+Jv0Pd8bsmh?=
 =?us-ascii?Q?DqgGxlmLWwWHKDcepEJNXbdKdDOFCUoVxwloVI2VF4iC2jmjaWpyPEfHVTqr?=
 =?us-ascii?Q?mywSR840k59GBPfw7wY2d0me482PNGIvgISSn5kHoIuzSS1zBE0f4XoOaQv0?=
 =?us-ascii?Q?udI7OVxKVYumcrQSGcHxYMYcSxnOY91SiZaw48+ijJW/T9NZavEmd63fCg4/?=
 =?us-ascii?Q?xnDsBPF5fxmPR3bwqstp+213oQiyLMHNinFeCgISS7O7YLWAZD0uscXBbkU7?=
 =?us-ascii?Q?YvnBkZXYDcHEHmvcOsSfaFMXcPatxeSt/SBwErotUhHUYeRTuWAedJpwGs7G?=
 =?us-ascii?Q?FLH8VBBcP6mcQ780Z32RaIU+XodLTUdQfglbd0MYb5AB8+ebPx0VhqMyZefP?=
 =?us-ascii?Q?aithagMn7biyoW93B7g1rcLOhVeo0wHbpTHtzsO0f2ecEkGtu9UsdcQ9LQNv?=
 =?us-ascii?Q?0++Rf0W4NZ+BXPX1Z1DVKGHXGuU4WKKOiueDw1i9w8pRnSwqXB2aOy0IVktY?=
 =?us-ascii?Q?m6MFt8/tKAHSi+hegu7FGOHrU/R7ZdrISDca?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oSdtlh9Tx394xDe5LC48DqszjmQec9kYhvCpo/Mg2ypNqTypAJab3+WNoaJE?=
 =?us-ascii?Q?u6ajexhhMJkuibWohFJGDGbyoFQl06FrQOihT74c7KnI+T2OJZml+FGJ2x38?=
 =?us-ascii?Q?ntlz7YDDIwojOgG8eGGE+pDEwniEQE5XzO5iRrf5ap21IFF9cpRGn7Sq8/mz?=
 =?us-ascii?Q?Zs8vAhpdgcBHHrOac3DjRjTaCpKB3CDSXFqMcQsLcq7UB+bzGkYRy8rcFq7r?=
 =?us-ascii?Q?aNxrhmkrOLgQC8Yz/eWLwzPRZxKocPyXCTndhwFrraT2fRn/LTyqEz8WQttl?=
 =?us-ascii?Q?5zS+vaVAhDXxKG+YxlNwVjANkpEWtkeh/mmuLIN5e38K577Vu03Qz6RsAl0t?=
 =?us-ascii?Q?QplUA+PqQxs0pmMayw6JP+ZRXnaBVEEZ96qMxe1gokgQ/ndbfsAlHDuH1BAw?=
 =?us-ascii?Q?FKyDgTU0PLkb0YVkC/coYwS23wTzVt3t+iHT+8ApBNpQsm8LSHzqwblAh6y/?=
 =?us-ascii?Q?oYxGMi6Bum+yYxJzkH3VHdKqhkdKemI3tpuAQC9+fzdgNFMGHu+XkrqURwlz?=
 =?us-ascii?Q?OXdtjuYYJHikufNrLikG6MOyQdibmfP8/fD1c9qytGYYqCmQlKVH9JWU4gx4?=
 =?us-ascii?Q?NzxAqSNvtg67qu9zAUCcHS1Xfpapi1M5Ziv2pXahy+4NWZIfTaCKqLzJH6nT?=
 =?us-ascii?Q?HQ2Krageyhp23iVwicX7St0rv3IXPdJfFz+piEvyQ8PFnOh/8ewUVBukx0t/?=
 =?us-ascii?Q?002T1O27bp4DgQOa6xrSQXzZWhOh6PBGRNbfFIptT4lqppcpkDWnSvn6AWZB?=
 =?us-ascii?Q?uYet9XH5O9kqwxjgclivevxUq1K12gJL49oHSs4fCeAHkRPZGGPSQHqHbtzS?=
 =?us-ascii?Q?Aewn1UN7wRq7JAbHBQJ9FoMfNPp3ENML+IBHhUu3boiLLuG1ug63MzeIHyqJ?=
 =?us-ascii?Q?RoSBkzfs0+YNENmbiUvXPwexRoEB7yTkEQD7c6K6i0AHErkxvOXI0YiJh7dT?=
 =?us-ascii?Q?bM6ex5MjC5JNiCwZxOGtVTI7q94cUESoBqyx4TREU//r3x0XcERpqf8mWDi8?=
 =?us-ascii?Q?Or6mfmZE0RKr6yanjEvxSj08Bx8PL5S1Icj3MoJpxqSBWDzENKMeRGwopnay?=
 =?us-ascii?Q?OocYe7CBzLecSXOFbU4rImdZ/WUPlzY/2dMyMJ7ng1ypDrGvLnmeKA2QGhUO?=
 =?us-ascii?Q?D0wKRXWB5e3BDAjOqIiwN4VSEDJZllFs3piRaA2FGxdX78tPqvbdH1S2UXjo?=
 =?us-ascii?Q?b6ND9ewEVoaH777CXKPoogpnMCUoqyLXZcgjQSsFcmASZcKBsIWRc6igrS5I?=
 =?us-ascii?Q?FFXwJ2ZhDxr8jIjBN57xsZIY/Ygdr3eqBCVAGTq/ZDNKKmNk2xPvWXPga5By?=
 =?us-ascii?Q?cuuMAcyYyIobypUm2+MQpJXsfMRPWzKq/5rHmdhC9ALiYdQpooaYvIPoAb+7?=
 =?us-ascii?Q?4WXcjoFd+xT10WC7kJj5LYVgsFH1rVSU/enaBMa8LU0kLtZllqJFYhAtNMvW?=
 =?us-ascii?Q?gP/QBTff31kf/+7p8Lvl3ElB9K8TvzUmOH+h579t5hqPDGWL/T5eznQqtMK/?=
 =?us-ascii?Q?MilhCfcHMiYbSFFAEMT5ffrgCVEpnE/YhUw5+xX9BZe0lvZLTqq/Skvg382P?=
 =?us-ascii?Q?wqkuBxAtncisaOd9i0nzWZ+eyLoSuKp/rH1wGbhI?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 755215df-dd0a-444a-2882-08de0fe83fd6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 14:52:11.4068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: swE2kvMWjcJrHPcp1xpczUxeITe/pJcgPM/iU209ypfjx7sLmX7RTCRI6zOoI45IPyIkWomKP9BKqGzqz/j5ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7519

On Mon, Oct 20, 2025 at 07:06:55AM -0700, Laurentiu Mihalcea wrote:
>
> On 10/17/2025 7:56 AM, Frank Li wrote:
> > On Fri, Oct 17, 2025 at 04:20:23AM -0700, Laurentiu Mihalcea wrote:
> >> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> >>
> >> Some NXP SoCs integrate one or more, per-subsystem, block control IPs,
> >> which allow users to control the assertion and de-assertion of the
> >> reset lines tied to some peripherals present in said subsystems. Some
> >> examples of such SoCs include i.MX8MP with AUDIOMIX block control and
> >> i.MX8ULP with SIM LPAV.
> >>
> >> Some of the aformentioned block control IPs exhibit a common pattern with
> >> respect to the assertion and de-assertion of the reset lines. Namely, the
> >> user is able to control the state of the reset line by toggling a bit from
> >> one of the IP's registers.
> >>
> >> Linux can take advantage of this pattern and, instead of having one driver
> >> for each block control IP, a single, more generic driver could be used.
> >>
> >> To allow this to happen, the previous approach, in which a single reset
> >> map is used, is replaced by a per-driver approach, in which each auxiliary
> >> device driver holds a reference to a certain reset map.
> > Can you shorter your commit message?, basically, you just add
> > imx8mp_reset_info for difference auxiliary_device_id.
> >
> >> Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
> >> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> >> ---
> >>  drivers/reset/reset-imx8mp-audiomix.c | 18 ++++++++++++++++--
> >>  1 file changed, 16 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/reset/reset-imx8mp-audiomix.c b/drivers/reset/reset-imx8mp-audiomix.c
> >> index c74ce6e04177..c370913107f5 100644
> >> --- a/drivers/reset/reset-imx8mp-audiomix.c
> >> +++ b/drivers/reset/reset-imx8mp-audiomix.c
> >> @@ -24,7 +24,12 @@ struct imx8mp_reset_map {
> >>  	bool active_low;
> >>  };
> >>
> >> -static const struct imx8mp_reset_map reset_map[] = {
> >> +struct imx8mp_reset_info {
> >> +	const struct imx8mp_reset_map *map;
> >> +	int num_lines;
> >> +};
> >> +
> >> +static const struct imx8mp_reset_map imx8mp_reset_map[] = {
> >>  	[IMX8MP_AUDIOMIX_EARC_RESET] = {
> >>  		.offset	= IMX8MP_AUDIOMIX_EARC_RESET_OFFSET,
> >>  		.mask = BIT(0),
> >> @@ -45,10 +50,16 @@ static const struct imx8mp_reset_map reset_map[] = {
> >>  	},
> >>  };
> >>
> >> +static const struct imx8mp_reset_info imx8mp_reset_info = {
> >> +	.map = imx8mp_reset_map,
> >> +	.num_lines = ARRAY_SIZE(imx8mp_reset_map),
> >> +};
> >> +
> >>  struct imx8mp_audiomix_reset {
> >>  	struct reset_controller_dev rcdev;
> >>  	void __iomem *base;
> >>  	struct regmap *regmap;
> >> +	const struct imx8mp_reset_info *rinfo;
> >>  };
> >>
> >>  static struct imx8mp_audiomix_reset *to_imx8mp_audiomix_reset(struct reset_controller_dev *rcdev)
> >> @@ -60,6 +71,7 @@ static int imx8mp_audiomix_update(struct reset_controller_dev *rcdev,
> >>  				  unsigned long id, bool assert)
> >>  {
> >>  	struct imx8mp_audiomix_reset *priv = to_imx8mp_audiomix_reset(rcdev);
> >> +	const struct imx8mp_reset_map *reset_map = priv->rinfo->map;
> >>  	unsigned int mask, offset, active_low, shift, val;
> >>
> >>  	mask = reset_map[id].mask;
> >> @@ -144,7 +156,8 @@ static int imx8mp_audiomix_reset_probe(struct auxiliary_device *adev,
> >>  		return -ENOMEM;
> >>
> >>  	priv->rcdev.owner     = THIS_MODULE;
> >> -	priv->rcdev.nr_resets = ARRAY_SIZE(reset_map);
> >> +	priv->rinfo           = (const struct imx8mp_reset_info *)id->driver_data;
> > needn't force convert from void*
>
>
> not a void *, "id->driver_data" is kernel_ulong_t

why not use void *?

Frank
>
>
> >
> > Frank
> >
> >> +	priv->rcdev.nr_resets = priv->rinfo->num_lines;
> >>  	priv->rcdev.ops       = &imx8mp_audiomix_reset_ops;
> >>  	priv->rcdev.of_node   = dev->parent->of_node;
> >>  	priv->rcdev.dev	      = dev;
> >> @@ -168,6 +181,7 @@ static int imx8mp_audiomix_reset_probe(struct auxiliary_device *adev,
> >>  static const struct auxiliary_device_id imx8mp_audiomix_reset_ids[] = {
> >>  	{
> >>  		.name = "clk_imx8mp_audiomix.reset",
> >> +		.driver_data = (kernel_ulong_t)&imx8mp_reset_info,
> >>  	},
> >>  	{ }
> >>  };
> >> --
> >> 2.43.0
> >>

