Return-Path: <linux-kernel+bounces-880801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4B6C26987
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 19:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BAE73AE5A4
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 18:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D9B2E7BAA;
	Fri, 31 Oct 2025 18:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="k1NuI2f3"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013038.outbound.protection.outlook.com [52.101.83.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516141A0BD6;
	Fri, 31 Oct 2025 18:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761935712; cv=fail; b=L8ahW9IufOPGwF4A7CONYpCDcmY7nCRnOX78kotLpbpNVsNXMtTXxPEeu9YF8z0MwoUrAZwIiDSDUmVzjETXrDT5WMZ7W2h/O7mRxC/u5OEQYAhy9CFZDaS/7j6TLuFWIA7Tlq5oHmzCv6VOkRTC6CypRazDHPGGzkkT8NguLoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761935712; c=relaxed/simple;
	bh=YMhowBbsofw+xYo7+XAxUbKAGKCkxZWV3G3QnzHWX5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=atp4Po+YNMBVDYZPXBHLHOS/vcrCiLLROPx81I6KF2uwRvcqSZho82+QukO4SNT8i1KdeLkwkTLwoiy8YS1uJDrFp7m15mVIKy+34+czJg24HdlGJfBy8ZxxbIEQJe8kJSylaG6NNZHX92R9iGXB3UjyMr2/UqLSzDEM5ky3njw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=k1NuI2f3; arc=fail smtp.client-ip=52.101.83.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=omOV4Z5779OHty8BAs4fVMxVT1B5n0Ffm4yBRJ6BAMJ+EDpBoVsN9PCC/gbRyvFaswby6mR9cYyCRvgBdi0xzWIch9Fny8KKHlhtAb8txxPjmoiZiJwNIn/9VrVudbJwytkGvwQVE44b34zAhpXXzglVm/uw7n8zLlbIslsnGfntiJk3tpmbzFwsvUNtMmAJ6fviR6xwO6o1ytLo9hZE3nzq2jEIFc5lf+V/Ykgajglag5gsi7ksgPdarpn8FounRfMBlVgPfqh8aAain9mKSpSt262h4yKENQ6ci+R+rRLE8nczi0nym97NRmaVGNWvuZ/FX2o1l86FP1YWArWLsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dOlxr34Ubng/oUYUrIrUhTHZ4dTxyx/7Qrcxy9GRYok=;
 b=TGuVlividWm4uZyI20DLsW7IG1s/A5nff/L5Ksbz8w6sYtYzUbmiAIJtEQYtyvjBkqeN4z+Ky5gRHTl9s4jAXXoSYV5y2ihjr8ekIwSf8eOGbrwyv/cCoT9iKXDs8HR1ppcQx75QJBL+leEtAE1XVxEMXnu8ulYCv90iPQ40cnKjfQv2uqOeRG01CAgUWux/5G60VHlyn8iMYVlC34G2Z+JCkS5hvhI7PTlIXhQq7curFNDpp6V3IWCZ8mSsYHnETDUVDA7d4L0ImWFtOLpe5iiiVbu9dgFy3ogQqlcR4aburGGI7UMl0Czrec+BZc/RDH/JA0cZAJgKBajbsnfC4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dOlxr34Ubng/oUYUrIrUhTHZ4dTxyx/7Qrcxy9GRYok=;
 b=k1NuI2f316VbNtymDGCJoiBzR4xtw+DEJEy2jiRTjuc0f3t9LaD7AKxNfYfxxkPHqHUXLqia3NZAu9OqzIEGjwX7bOFK0F73bbppum/Od3wmrqyqhJDowvxD4+f5xjrMsdFVTs6qvER6qTSw+DJ94mgtwShtk3/xt2butqG6KQFtRhQVxAus2+SCcIDvOe0WfYz6B8HsYjob54aCOvbelfCjiR4LkY1ggFded5000nQAmac2EhidJs9u25wMhEwuhC8NJL3qDXkGvhS23gqr+staisjONpKjhgXc0qxAK4LAyykZ/anU9GisxXjuSRctNm0hikPAynLwp6hOgkdCJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AM7PR04MB7158.eurprd04.prod.outlook.com (2603:10a6:20b:120::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Fri, 31 Oct
 2025 18:35:01 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9275.011; Fri, 31 Oct 2025
 18:35:01 +0000
Date: Fri, 31 Oct 2025 14:34:52 -0400
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
Subject: Re: [PATCH v3 5/8] reset: imx8mp-audiomix: Switch to using regmap API
Message-ID: <aQUBTLPwLe71lrhb@lizhi-Precision-Tower-5810>
References: <20251029135229.890-1-laurentiumihalcea111@gmail.com>
 <20251029135229.890-6-laurentiumihalcea111@gmail.com>
 <aQJCtZjAGiQdzfDz@lizhi-Precision-Tower-5810>
 <c8fdbb57-d152-4c85-be06-cfbc7e0b1550@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8fdbb57-d152-4c85-be06-cfbc7e0b1550@gmail.com>
X-ClientProxiedBy: PH8P220CA0036.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:348::16) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AM7PR04MB7158:EE_
X-MS-Office365-Filtering-Correlation-Id: 116c20c8-cc3e-4056-c75d-08de18ac334c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gAzeMU4bhaYVOYyP1bHkjwl/CeTszb1gTwwZBeQvN8Z0OMKfRBBkFuHQQrW4?=
 =?us-ascii?Q?Wq6SnrYD2oxY3XN6r+tN84X0sIMqEh8EX69XterAHabf/uIxyoRk05vPll6+?=
 =?us-ascii?Q?ry4R7lnTCTLKcHw2TPH7vrxS8xhVUnjWHj0+n8WvGj0OUbtkwblAOmfNbvvf?=
 =?us-ascii?Q?lDyNinXLEooq5Chd1z8haeXuxNCHG8din6ocGL3ZCZs8vW7u0vEzNpGT9q//?=
 =?us-ascii?Q?GN7OXXvaDTVG94VNTZmHREGO+0CqJehiG9fw4K2w8OFFcif1m9zUKY9qIb3Q?=
 =?us-ascii?Q?/QTCwO7q5l6Pyo9TvkF7ZHFo+FWgJUo/pGxzF0AjZtN1nYN9orKWOhEtko5v?=
 =?us-ascii?Q?qiudclgdxVLaiJ8fWIG4tkEemotZ304TVTC7kdHQESfNo67VTcThdQJR7JgM?=
 =?us-ascii?Q?1n/B8Po9s09diChPR178aCRfXQrqxbPxmGWc6UZxOONrVTYSI/hTSWKtpzIc?=
 =?us-ascii?Q?yisIGQvN091j7BZrHYvwFbEb64AGMOnAxwHshQ0++VCLFi/Tp33QxeJJWJAY?=
 =?us-ascii?Q?Ik+TGL98uzShx2Xu0qgUZQLXXuogGHQSvkvTdVNTEkh0jU25AXEFZfqu9akb?=
 =?us-ascii?Q?A7elpZjX4KxC0I1x6tBSG7Ml0So/n3uFaENpuevMk4Ek0PV+ix8ed/jfNkZj?=
 =?us-ascii?Q?lBeHVKs+WETz9MK+Db5H7kt0sBqh2jpAF5abX6sBnEGmPw4reVEe3quIvbbQ?=
 =?us-ascii?Q?jEbof9V2KNCm8CkE8SvQgLTJ/KuworZJa1Rsg5oqhOmBhpMObrMVYuqAnkPl?=
 =?us-ascii?Q?4MeiDLXemYQxrxUjD0bpYnxODaoNtCrIHXy5rlt6m+CUEI8cm0aJ2F2DhGZ9?=
 =?us-ascii?Q?9hoWFAV/j0LjxAJ2qi3zSo7VQEmsFWBjXQWtt/uTb/1IF/HgEk82gxW31TuC?=
 =?us-ascii?Q?rqWHkjw+5ZbC+y9a4yVJlIHZb3qCIzb+Ms8D2blJGnNiSCGDESUZf2r5n044?=
 =?us-ascii?Q?KlFHry6FZ0H4Kh5irwfW73juP+93PcdeGf6Z6AI79r7oqehzDBxPdDKJAvOn?=
 =?us-ascii?Q?E49K2Hix2nG0WKwASMqG4+dkyyflDNR5dqclIiBrx2mzq677cPSGipJPuDOi?=
 =?us-ascii?Q?dxPwVm379Utv4utgVnhNWuxlvVufAAy5Vsv6VnVmVKi1xIcUsULQHowS5AzP?=
 =?us-ascii?Q?Pvn2d709fn7cgve0rSaDFBELnCcHpEdOy8gSyoaaYdE78CNcycU47064MN+2?=
 =?us-ascii?Q?BnTt+twPpzixtBxW4DuxTqIBYcQrwto5emeywW72ZZ909X8+vczkkL39VDp2?=
 =?us-ascii?Q?QPUK/8yOiSKR5fnEoBqBvNaQ9TGa6KySO859jTN26bOv5ci5etUbZ5W1dIKl?=
 =?us-ascii?Q?7CvB1tgCXYwxC+rlFf6IcnuvUABB8UuGMnb9yT+jhdzuO5KCI1RI3pc6kM6F?=
 =?us-ascii?Q?8Asy8Xi2nklzMHIoT2PbBb56KEpQZAacZMCx8O7SeqnMMVDuTf2VO3M/R5ek?=
 =?us-ascii?Q?v22xrqLQPin6JNPnNJv1TzDQCCkn+i0eDChAwOm6wpm5Q3PvA22yc/CBI+M7?=
 =?us-ascii?Q?DaiXkGpqRglLStZnX/aKCopdPub5u8ff8NUf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(19092799006)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pf86PaG/8Y5r8CQ740NtP/AsvVNd9uk0WnvuCBBMU8wORTAU6SptIhw5S8t1?=
 =?us-ascii?Q?G6XAo9EuvBkfV9h/7AYISnToskd6v/NBhw3YqlehmbUielR0XdNL9dSm/GJT?=
 =?us-ascii?Q?citAHbuDFuA8J5yvJLkkA5NpKxtGeWMTi42xscb0W0b78zxwwsROHcnF7adO?=
 =?us-ascii?Q?0YuKUm/xzUYKG15DEUFPAbCgOdepuy6udw/JyCiKo/7xQ0Zl74OIMfeaVu/s?=
 =?us-ascii?Q?5A1AagbZh04bGfIuw0lOtdKpZtsxWbacE8aqAr81xkjxWdAr6zgvfjrMLLd9?=
 =?us-ascii?Q?NFFqMnHGUGRk6hQQFLRaP2Id4yJFjknnypYUl8QN6Z2wMfz29dO3ZwfyTDgQ?=
 =?us-ascii?Q?ArQuUgepZa8vwwjkcLGMcwBSqZbkbFeVzgb063KLqQQp49mhKqV3wRoZI4Ah?=
 =?us-ascii?Q?hIboKZafAqjp2kVLs483YbwSpAFZJqzeCZ2GrO81D9vzEmzCmYigR1DtkPi1?=
 =?us-ascii?Q?RJMMkiZHq76qPaedHOo++3MfycAGecOliJbMLX3OGBDFkpXi30gv/zztLK0l?=
 =?us-ascii?Q?GbalbtX3e73TFRxbgluvbCWFydT8y51qJ68T6mAZQZjTiZni/Ui9x0n+Zbxw?=
 =?us-ascii?Q?J5uj16at0hJZ6If7QtN/yrLvrVX3WPPThcnpfk3brzM3nxy/1eMIVZow39vJ?=
 =?us-ascii?Q?IERs6scZ6HsEAxMtf/7gxXEvYYPD5jZvV6qNcCrJJOVpfco/lTMvCE3PtoHy?=
 =?us-ascii?Q?f0zIM96uCScNpqNJ6EcmSRvmMlbJBtmkI9tohJWuzw0y6/4DUMVKbzjl4/0q?=
 =?us-ascii?Q?rJ6tVMNf2oSjF4cWvdO9MDaeWuoDzLHzW8OkFNKBX/YWDBWuMPXXZGiuH/wd?=
 =?us-ascii?Q?RluzRHWBmMZ7zfsSAwAkLWxaBHl8B84KOKdJk1GaHwYrMx0Tg+gZda9f9FiL?=
 =?us-ascii?Q?AWU5k3418glhv+OYnXeNictKUub725of8NJfU9zAFrZnHoKwlXaMzaY+HXVl?=
 =?us-ascii?Q?w8WuLvEF1yKn5R8VeZyTW4snSxc9OUInkzMaWg3rAiVCrg+UHOMcWuJSw5Su?=
 =?us-ascii?Q?ga7gCwrb+yz8opEZOKSTTgVXziuzlTVBhuX1TvRDatnHcht8ZL+4Y9kcnBZj?=
 =?us-ascii?Q?r54d75cVU0FT0vHPD7AsMz/JYJ5fltoVibXOmqao7SxoRBGBUvbrHFkl1/+L?=
 =?us-ascii?Q?eK5wLnFPh1CcG19Eb/jZPJ7vg/m1RbaVtK+yGCRJV5IOIFhXXEY4MlKuCGr6?=
 =?us-ascii?Q?UWAXQRdPRPjKAab0YQFV6V1eI14OY6ihYHiihW9yI3tfo08bNImngIV/3IGu?=
 =?us-ascii?Q?WEmAcB5t2SJ4SGZA8ugAedAIwGvswtpoWvJet+EO4ixlur1mvT07Z9TxzpzR?=
 =?us-ascii?Q?Nisy9z9Ge0BDRUDwQVkZdYJt1HxihjfVY8FNV7FMEDb6ZRFXEbqSLyww4Hp4?=
 =?us-ascii?Q?69q5rsXdIqSH1uOmgs1jJgyPJ+rpBsCzJfN48QfiZ4c2PUKNDX1BTyooCDED?=
 =?us-ascii?Q?5jw0iYVV6oNZNBCA85tTqfF+d6umYg3KyPV3Z2o+9QxpII/hJD8djwN7FScw?=
 =?us-ascii?Q?eRFoIWthNZifGilFVJsW2ikICKA9/+RrjFg9CMkAAQsf5/gBekAj8NcT/wDk?=
 =?us-ascii?Q?GARmJEkZ1Wv8YMRtsNqSM8Cj+5QVJOoRwr2RNxHG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 116c20c8-cc3e-4056-c75d-08de18ac334c
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 18:35:01.0093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aZS+wq55LqEMmjo15yybq6Nw8YCw5052EDpKk/2xUSxis8VKF2W9hxqYFt9h+WU24BH7US5D8o/3NEJ4H9wmpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7158

On Wed, Oct 29, 2025 at 10:51:17PM +0200, Laurentiu Mihalcea wrote:
>
> On 10/29/2025 6:37 PM, Frank Li wrote:
> > On Wed, Oct 29, 2025 at 06:52:26AM -0700, Laurentiu Mihalcea wrote:
> >> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> >>
> >> As far as the Linux kernel is concerned, block devices such as i.MX8MP's
> >> AUDIOMIX block control or i.MX8ULP's SIM LPAV can simultaneously act as
> >> clock controllers, reset controllers or mux controllers. Since these IPs
> >> offer different functionalities through different subsystem APIs, it's
> >> important to make sure that the register R-M-W cycles are performed under
> >> the same lock across all subsystem APIs. This will ensure that registers
> >> will not end up with the wrong values because of race conditions (e.g.
> >> clock consumer tries to update block control register A, while, at the
> >> same time, reset consumer tries to update the same block control register).
> >>
> >> However, the aforementioned race conditions will only impact block control
> >> IPs which use the same register for multiple functionalities. For example,
> >> i.MX8MP's AUDIOMIX block control IP provides clock gating functionalities
> >> and reset control functionalities through different registers. This is why
> >> the current approach (i.e. clock control and reset control work using
> >> different locks) has worked well so far.
> >>
> >> Since we want to extend this driver to be usable for i.MX8ULP's SIM LPAV
> >> block control IP, we need to make sure that clock control, reset control,
> >> and mux control APIs use the same lock since all of these functionalities
> >> are performed using the SYSCTRL0 register.
> >>
> >> To do so, we need to switch to the regmap API and, if possible, use the
> >> parent device's regmap, which, in the case of i.MX8ULP, will be the clock
> >> controller. This way, we can make sure that the clock gates and the reset
> >> controller will use the same lock to perform the register R-M-W cycles.
> >>
> >> This change will also work fine for cases where we don't really need to
> >> share the lock across multiple APIs (e.g. i.MX8MP's AUDIOMIX block
> >> control) since regmap will take care of the locking we were previously
> >> explicitly performing in the driver.
> >>
> >> The transition to the regmap API also involves some cleanup. Specifically,
> >> we can make use of devres to unmap the device's memory and get rid of the
> >> memory mapping-related error paths and the remove() function altogether.
> > Can you simpifly commit message? The key points are 1: lock, 2: nice API.
> > like regmap_update_bits().
> >
> > Switch to using the regmap API to simplify register access. The regmap
> > infrastructure provides synchronized register access and richer helpers
> > such as regmap_update_bits().
>
>
> this change isn't about simplifying the register access, nor is it about synchronizing
>
> the register access. Previous version was already doing that.
>
>
> the key takeaway here is we want to have the SAME lock used across different APIs.
>
> regmap is a way to do that.

This sentense already be enough descript current situation, you write 6 big
paragaph.

Frank

>
>
> >
> >> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> >> ---
> >>  drivers/reset/reset-imx8mp-audiomix.c | 91 +++++++++++++++++----------
> >>  1 file changed, 57 insertions(+), 34 deletions(-)
> >>
> >> diff --git a/drivers/reset/reset-imx8mp-audiomix.c b/drivers/reset/reset-imx8mp-audiomix.c
> >> index e9643365a62c..3f6d11270918 100644
> >> --- a/drivers/reset/reset-imx8mp-audiomix.c
> >> +++ b/drivers/reset/reset-imx8mp-audiomix.c
> >> @@ -11,6 +11,7 @@
> >>  #include <linux/module.h>
> >>  #include <linux/of.h>
> >>  #include <linux/of_address.h>
> >> +#include <linux/regmap.h>
> >>  #include <linux/reset-controller.h>
> >>
> >>  #define IMX8MP_AUDIOMIX_EARC_RESET_OFFSET	0x200
> >> @@ -42,8 +43,8 @@ static const struct imx8mp_reset_map reset_map[] = {
> >>
> >>  struct imx8mp_audiomix_reset {
> >>  	struct reset_controller_dev rcdev;
> >> -	spinlock_t lock; /* protect register read-modify-write cycle */
> >>  	void __iomem *base;
> >> +	struct regmap *regmap;
> >>  };
> >>
> >>  static struct imx8mp_audiomix_reset *to_imx8mp_audiomix_reset(struct reset_controller_dev *rcdev)
> >> @@ -55,26 +56,15 @@ static int imx8mp_audiomix_update(struct reset_controller_dev *rcdev,
> >>  				  unsigned long id, bool assert)
> >>  {
> >>  	struct imx8mp_audiomix_reset *priv = to_imx8mp_audiomix_reset(rcdev);
> >> -	void __iomem *reg_addr = priv->base;
> >> -	unsigned int mask, offset, active_low;
> >> -	unsigned long reg, flags;
> >> +	unsigned int mask, offset, active_low, shift, val;
> >>
> >>  	mask = reset_map[id].mask;
> >>  	offset = reset_map[id].offset;
> >>  	active_low = reset_map[id].active_low;
> >> +	shift = ffs(mask) - 1;
> >> +	val = (active_low ^ assert) << shift;
> >>
> >> -	spin_lock_irqsave(&priv->lock, flags);
> >> -
> >> -	reg = readl(reg_addr + offset);
> >> -	if (active_low ^ assert)
> >> -		reg |= mask;
> >> -	else
> >> -		reg &= ~mask;
> >> -	writel(reg, reg_addr + offset);
> >> -
> >> -	spin_unlock_irqrestore(&priv->lock, flags);
> >> -
> >> -	return 0;
> >> +	return regmap_update_bits(priv->regmap, offset, mask, val);
> >>  }
> >>
> >>  static int imx8mp_audiomix_reset_assert(struct reset_controller_dev *rcdev,
> >> @@ -94,6 +84,50 @@ static const struct reset_control_ops imx8mp_audiomix_reset_ops = {
> >>  	.deassert = imx8mp_audiomix_reset_deassert,
> >>  };
> >>
> >> +static const struct regmap_config regmap_config = {
> >> +	.reg_bits = 32,
> >> +	.val_bits = 32,
> >> +	.reg_stride = 4,
> >> +};
> >> +
> >> +/* assumption: registered only if not using parent regmap */
> >> +static void imx8mp_audiomix_reset_iounmap(void *data)
> >> +{
> >> +	struct imx8mp_audiomix_reset *priv = dev_get_drvdata(data);
> >> +
> >> +	iounmap(priv->base);
> >> +}
> >> +
> >> +/* assumption: dev_set_drvdata() is called before this */
> >> +static int imx8mp_audiomix_reset_get_regmap(struct device *dev)
> >> +{
> >> +	struct imx8mp_audiomix_reset *priv;
> >> +	int ret;
> >> +
> >> +	priv = dev_get_drvdata(dev);
> >> +
> >> +	/* try to use the parent's regmap */
> >> +	priv->regmap = dev_get_regmap(dev->parent, NULL);
> >> +	if (priv->regmap)
> >> +		return 0;
> >> +
> >> +	/* ... if that's not possible then initialize the regmap right now */
> >> +	priv->base = of_iomap(dev->parent->of_node, 0);
> > Not sure why need map parent devices's ioresource here. You'd better use
> > regmap_attach_dev() at parent devices, so dev_get_regmap() will get it.
>
>
> why would we want to force the parent device to use regmap if it doesn't need to?
>
>
> >
> > Frank
> >
> >> +	if (!priv->base)
> >> +		return dev_err_probe(dev, -ENOMEM, "failed to iomap address space\n");
> >> +
> >> +	ret = devm_add_action_or_reset(dev, imx8mp_audiomix_reset_iounmap, dev);
> >> +	if (ret)
> >> +		return dev_err_probe(dev, ret, "failed to register action\n");
> >> +
> >> +	priv->regmap = devm_regmap_init_mmio(dev, priv->base, &regmap_config);
> >> +	if (IS_ERR(priv->regmap))
> >> +		return dev_err_probe(dev, PTR_ERR(priv->regmap),
> >> +				     "failed to initialize regmap\n");
> >> +
> >> +	return 0;
> >> +}
> >> +
> >>  static int imx8mp_audiomix_reset_probe(struct auxiliary_device *adev,
> >>  				       const struct auxiliary_device_id *id)
> >>  {
> >> @@ -105,36 +139,26 @@ static int imx8mp_audiomix_reset_probe(struct auxiliary_device *adev,
> >>  	if (!priv)
> >>  		return -ENOMEM;
> >>
> >> -	spin_lock_init(&priv->lock);
> >> -
> >>  	priv->rcdev.owner     = THIS_MODULE;
> >>  	priv->rcdev.nr_resets = ARRAY_SIZE(reset_map);
> >>  	priv->rcdev.ops       = &imx8mp_audiomix_reset_ops;
> >>  	priv->rcdev.of_node   = dev->parent->of_node;
> >>  	priv->rcdev.dev	      = dev;
> >>  	priv->rcdev.of_reset_n_cells = 1;
> >> -	priv->base            = of_iomap(dev->parent->of_node, 0);
> >> -	if (!priv->base)
> >> -		return -ENOMEM;
> >>
> >> +	/* keep before call to imx8mp_audiomix_reset_init_regmap() */
> >>  	dev_set_drvdata(dev, priv);
> >>
> >> +	ret = imx8mp_audiomix_reset_get_regmap(dev);
> >> +	if (ret)
> >> +		return dev_err_probe(dev, ret, "failed to get regmap\n");
> >> +
> >>  	ret = devm_reset_controller_register(dev, &priv->rcdev);
> >>  	if (ret)
> >> -		goto out_unmap;
> >> +		return dev_err_probe(dev, ret,
> >> +				     "failed to register reset controller\n");
> >>
> >>  	return 0;
> >> -
> >> -out_unmap:
> >> -	iounmap(priv->base);
> >> -	return ret;
> >> -}
> >> -
> >> -static void imx8mp_audiomix_reset_remove(struct auxiliary_device *adev)
> >> -{
> >> -	struct imx8mp_audiomix_reset *priv = dev_get_drvdata(&adev->dev);
> >> -
> >> -	iounmap(priv->base);
> >>  }
> >>
> >>  static const struct auxiliary_device_id imx8mp_audiomix_reset_ids[] = {
> >> @@ -147,7 +171,6 @@ MODULE_DEVICE_TABLE(auxiliary, imx8mp_audiomix_reset_ids);
> >>
> >>  static struct auxiliary_driver imx8mp_audiomix_reset_driver = {
> >>  	.probe		= imx8mp_audiomix_reset_probe,
> >> -	.remove		= imx8mp_audiomix_reset_remove,
> >>  	.id_table	= imx8mp_audiomix_reset_ids,
> >>  };
> >>
> >> --
> >> 2.43.0
> >>

