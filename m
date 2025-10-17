Return-Path: <linux-kernel+bounces-858227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D262CBE957B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 438E9188B7DB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 14:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8659223EA9E;
	Fri, 17 Oct 2025 14:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TVtlxrNF"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010050.outbound.protection.outlook.com [52.101.69.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B025337113;
	Fri, 17 Oct 2025 14:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760712577; cv=fail; b=R+urROFAdTsUXgUhPxZx7G8CDPT7wQCINPPuhZMzUKUbKsOycqS7Kl8NLkI8LZiooBhdbHqTNN6nnLZriO6zA2LzXhFaOjTTXbjuP+aSnmMdwbb+lJqjXWfajVuDFJAVdvVzgDWDlDu2ei5Gea6keCQj2b9oOT13f4s5z0bD3pw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760712577; c=relaxed/simple;
	bh=TPyusrtjjSwJayslQ8pPwOf0drhfURWe1fDWug1SJps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=u66tPEuCqbaO1IV6WzIHF9EYN/0XgCR8SXnu+0OyQ1Jyp5VwySBVX90++TNd0hUSRC/4lmkEpIVtT6ERcxhpUM2Z3yEqXpd8v5BEL6JFy5hUADLW+aQhajmeC4ihrnKm4FQxmCKk4uovwvnOMrxArzxIB3AuT1rJPTkQzu3sj54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TVtlxrNF; arc=fail smtp.client-ip=52.101.69.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c2aLolyO8AvxQTPsgZlaA3P4Ky7nTN007qzKtGmxSzEdlxOh6b6YUvS4Bmht8DqSneAR4qI1l8KhwJ1GR9rDjFyCNIYlMZ9CcGL/9FW+JfpdcmnmGAe57EoD8Scprxm/VDHOAhZH04jMHUXJUlXNDWvgvR9H2lDVG1IoxNes7sF5jpQupyQQftqJ6PTnLBySoUMard1f4G4TkKz1jajbUQtycC3KJE9lIAFmeTJjYtSCzQzOnKzm29rznbGEfwb0UTycl6EuX2DfgzJfKkuvxaWRs1/oRHSD/6Njspb+WBjZcYaTnm1V7qvE065PFycLL1dTQytHdLve3GMRpWvnrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LjW5USsLfItaiLR5omtm9ygxYixxcT11tsGX/OJNZko=;
 b=qULnbSEeB8o1uCm7GEZt8Yelwh8KAVLprMwoXwEGDvfqKD1gGkZuY0QgShnNeE6J3mU/8zNRRlTPX9wySTTswe6Ce+bVXBpyuVYHaWEnEOJ4ytKd7iOJseofSPTRMVyMt79qMM0IOV07ooD/RJO/p0bl/jltdJgp+FehvqsWIBAXmUeqaM+W/RSNMtg6+o1ml+2+w0qI3v70lqgBhEURjJp0i7xQkq47+D5IUXJdUsAXyS54r5tNGzyAADeFsFgh4DW5wssndlB0pZXnLUHyEdbcX/+WytFZDAGtyWojU8GrtSMyOFS6+4T69TzF7EY8U5k9slzMNT7fudSpAfzjiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LjW5USsLfItaiLR5omtm9ygxYixxcT11tsGX/OJNZko=;
 b=TVtlxrNFvq5ZdgQcYvpu4UiesxMFB8BUfmwGUlaYkbNSB+E+ZQImPQxBzJEjhcoh4RNxUhjZzubmzYReD8DLeAVlV6bAlhHNouj38XLt2jkdv6N8sV63soBWNhPFb+AexnKG6nf2Fu4MnuR2G8+VeI7tzwH29Oj6axVPVKR3sgWEOKO93Iyi1Wf0UcxkvWO/BlPVbVMcN5o89PHwLY/SsEyOYbPyBF9Te8+txTFY2adIJfZEsmfw2TfJ9rcK4llGLCStnIj/m3JFgPZsZ6aSOHVxE1T7s44stRxVASRDw29yNAjf2jY51R4bZdem5YERo1R1DEIx0hYg7P94K8bIew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by GV2PR04MB11397.eurprd04.prod.outlook.com (2603:10a6:150:2af::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 14:49:31 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9228.010; Fri, 17 Oct 2025
 14:49:31 +0000
Date: Fri, 17 Oct 2025 10:49:24 -0400
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
Subject: Re: [PATCH v2 5/8] reset: imx8mp-audiomix: Switch to using regmap API
Message-ID: <aPJXdPVrofYGQgIP@lizhi-Precision-Tower-5810>
References: <20251017112025.11997-1-laurentiumihalcea111@gmail.com>
 <20251017112025.11997-6-laurentiumihalcea111@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017112025.11997-6-laurentiumihalcea111@gmail.com>
X-ClientProxiedBy: CH0PR04CA0065.namprd04.prod.outlook.com
 (2603:10b6:610:74::10) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|GV2PR04MB11397:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c77a381-0ffd-489b-ccdf-08de0d8c6148
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|52116014|376014|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pVFvpWIgoVJdl/DxwAoRexnNNoPHDMTWsQESFh6EJEwmnOgVH15Vy9KkRxQB?=
 =?us-ascii?Q?sLJyW5Z+YdHsYXTSK66Bj81cvBuQEdB81rrrITES3TYZUWJVsN0n+Au0WP9P?=
 =?us-ascii?Q?4TTDF6ILhsyrBhPsh8DPLn2jqF4q7qWfQqqyeR+AEf/tED/iJvYB3c3B9YbC?=
 =?us-ascii?Q?oYiKiZm8daace61SwD9D/+a5FGegqaI8SIkWDLIJeLdExtMb3AfjR0E1Y95j?=
 =?us-ascii?Q?oXTZBIdsUzRq3vddqNmWZ6yBlrg1XJBO8qAp/XuzKbV8sc8RbqbFXxBYvsSz?=
 =?us-ascii?Q?egF5Wyq7bIFAECnOPO8bBNgCo67NkJF7o+eKeXBiRKrdP7uX6mrqKhJ1fZ8Z?=
 =?us-ascii?Q?ORdTZrW5YxiqvlzbqDlunaf86WtioysXKiuvGwLsKZcSRf4DoesBnkygwx1P?=
 =?us-ascii?Q?Qpdc2ldwR5YEq72CtIUmehKo7/jo65yWzfcfqle25Nv877BWQIi8lYFA9NrZ?=
 =?us-ascii?Q?ztMH23LVzt6gLBaXkgVeBIqZJThastkBs5wNM5socA/o0cDMb9pdXDbEhw+l?=
 =?us-ascii?Q?0FBugHRiT3eWxaw1GRsTz395TQH1uzTFN7Z4Uo26vqT/P92h5rvUKCvFonRX?=
 =?us-ascii?Q?iLyi7ji66Wmi0oIErC0LbVx+NImrITxgdOup7zbO36osvYg64X4LJSryq0dQ?=
 =?us-ascii?Q?vw/ilNvDtdMtMyYZuBc0YMr6pWXbNfLUL23YOH1s4P/MbR9H6v7SebXFYOl+?=
 =?us-ascii?Q?fzvDlRLvJyX1wm1wXkpgZUzIIAYOIx29bxSrlKlDviyBxqU93Ui7CUbLsnkv?=
 =?us-ascii?Q?JucQ7BcTAhw0/flssO7VktqP0ehG9b5AsuVv3+FTvn+BQGcXvRh2JK4gihp/?=
 =?us-ascii?Q?aPtf443HuoVQnJCbKKNDwtxIWccLI/PeY1ij+9EU3L3Or9/yyYYCAUTgMKDu?=
 =?us-ascii?Q?3GO/LyzADowJIneTstGN1hcDDD17nkPyPkDZJD2nLapOD+Vx1f3eWoG/z3fh?=
 =?us-ascii?Q?VacaoyAK63Kx/QfxoK2RDlz1Q3ODH+eXEvYYN3T+c9RpXSGgwlSZGTDMoBZT?=
 =?us-ascii?Q?KufrRQwVjrmI0wRfX60qOxVf1rXpaetC5eSqtl6ITTNouli/mneRIE5yC9zE?=
 =?us-ascii?Q?QXjnbP78BKDoK3V/dVQhJi449qYvNx+sfchweqEBYEG+48RhMx9w0tk0Ym3e?=
 =?us-ascii?Q?Fnegjf9m3zqu1HmHE24w4lPspRg35D2eVJpmP+y2o+xTm1QR0Jc2KaD/IeXg?=
 =?us-ascii?Q?uKz52rphggyd4bxUZRT8l+UPiP13zMM4wfswW1GECIkFUkE5hQf5QBjpZe2U?=
 =?us-ascii?Q?HeGK0y6yu5iXr1n4CgaQ8+bAYy1WF5Obd9Ndkh4xll8YSb+WFl/F1A9cY6bu?=
 =?us-ascii?Q?uRw8wCM/A8EfWmaBHOMdp3I6duPbM4D2QaQsNWgWniRnTCb55POZ3DEoeKDR?=
 =?us-ascii?Q?prPvwzVa9E3jy3O8p+/Fg58WUy/BEdIDOMLyG4uNS0p0xPdccYpuLXaaKNXt?=
 =?us-ascii?Q?JjstLMKXx2IfCEc9NBIhM0gq88U14rdvihZ62atO4OMy/tg0yq7RabNsFgYp?=
 =?us-ascii?Q?IAesbJXoz+Ma85ETYztlUz4OZxdmdJvFM2Lm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(52116014)(376014)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZKBq5tDpQ94pf7G0vNekfs0yvvs/xXTYpJRLKo8E/IgTeUwBCdfqGLpVdhrA?=
 =?us-ascii?Q?MDfN3v8yoPwUHnZHBo+9rS9+Gdj+lGNIlOI4CXo50aIpjtRCPBXZb+F86QR0?=
 =?us-ascii?Q?+d1ZvHbPyI0LF2V0NIEx26NVHkRi3vI3POGJ4duKSto2JNqVN8AcJXxQfDmB?=
 =?us-ascii?Q?4/5LVqAKCNWPG6PfeffD4+BfEBGKJydCKfRIe5Zu8xnWVDhvpqzmlK3yxFR9?=
 =?us-ascii?Q?+JHUC77e8Wk8m8B3DNv8aiEnPxGe1moP28lXJnvAYQKHC2r+ZdjYPwQYBJy6?=
 =?us-ascii?Q?DXZGH/MU5WDEAjbRLo5TaHTc02TQYiDn1gaWOIlwb3asYkao2QLSppbsilPx?=
 =?us-ascii?Q?B7r66f4YqYHooZXo7AgSwNsd/Paa+va+atN8Xu8SqsKfdC/3d12vIlwCHZzC?=
 =?us-ascii?Q?94R2n72Z86SZRfUjHOYUwRbk2IIzS5Di5rc+JriqLoDi/fuI6L1Vf2u3Jaih?=
 =?us-ascii?Q?raGdCeQVgv+oTlBQ0JyvKw+Z5XbbObdTgBX9fHj9ScM0TebXwE1Ly6xVFG8n?=
 =?us-ascii?Q?VaqvWw/DAs4spbSfkrot8e2GyvbxPfZJPh/nQpSneO2K5dZYVj5DMoYFePgz?=
 =?us-ascii?Q?bEiVeTf7iv1l3CBcWCBtjUnwKjtL0iIcDdX8+7FXygpkOeagsPpyAQWVhSg2?=
 =?us-ascii?Q?jAm3aE0fkEcos04omMTJST9KR8aYKzJrH6EMnjC5qUPi7N4yT0TginC0tGiM?=
 =?us-ascii?Q?MtbgEzbYGoVf+TZNFdNqfNtnvUxizngb4Y47D2intUGyBgUt2rATOZWBBtS0?=
 =?us-ascii?Q?Mq2yH496/Bs3Auy8gceM9g4UehHV20Q276yphshJLT5D5VmFi4JyqYTJn31H?=
 =?us-ascii?Q?/c+Cne14yg3L/TaNlhSLlA/5tp+L0HeIWyOSyVOu5NHFKbXoeWKRsqb47eEa?=
 =?us-ascii?Q?DzlzagpF3hbZBS03h6xoNsVKF5+qK5Q5Bca9VZ0npwWvui/oclPi1X2BXK0K?=
 =?us-ascii?Q?Fe7FaC+yiBcpfPcedUKciEX4gfbnG5//SrFQIChsE6dO7VJf44Rqg0443JbR?=
 =?us-ascii?Q?lDMhCgEzO8mGysipNTG8mkgvcP2ZIbeUgRxnLVEcvdhGA3xgRtsdlJhwmOb0?=
 =?us-ascii?Q?2pQ1vHy9qA8VVCBwL76aNvyQXJCdSudi6DTDYYG2PTqGEhQ4+tb6a1HdYy9M?=
 =?us-ascii?Q?G/bmVomcHU9nyk7iPHs+KBFmNVucpbuCuxDQd5eGPGkXthXN7pdQZV40p4JE?=
 =?us-ascii?Q?3blzv0DFgnhIvC6vWG1TYAey0amzg2lP2ixSqBdtIkRV5xRmZdzHR5kGg/Gk?=
 =?us-ascii?Q?/srZA1m/8ghRQL0YEvL6GYlCFlqVeG11pdcX1cmwAoE2z89RfACT07P5Yaqb?=
 =?us-ascii?Q?Gw3Qz2Qfep6subi5uDIm9LOANk/j3qKwE6aLlg0G4KUb6H5BvOBSrdiv+2mT?=
 =?us-ascii?Q?kv/lTGbeZbnCVLoGLWerr5w5EnXp/hSplxbKYYxUz7c+S2FAVF9wnpGUSmh9?=
 =?us-ascii?Q?E784ZYhl40K1LbEkjUuET+Lz3RL+ilSOmXFQdYbiefz/mBEqpsL3GCVKeRBX?=
 =?us-ascii?Q?k1iwUCuB87SfISRDubW7huHAOIryOW7wAYh/eW8PZAhQ14mXaD2sKF1R3VeR?=
 =?us-ascii?Q?XHO6MqWp0kcIwGP5DGs=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c77a381-0ffd-489b-ccdf-08de0d8c6148
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 14:49:31.3829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rAxHzgJqjkKBnIvFU3rTe7byfON1gaOadxkoAiHex3FuKSKjWF9+NHoWrakmM5BM8rKl6Ru7P9p4h7T6Izw5hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11397

On Fri, Oct 17, 2025 at 04:20:22AM -0700, Laurentiu Mihalcea wrote:
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>
> As far as the Linux kernel is concerned, block devices such as i.MX8MP's
> AUDIOMIX block control or i.MX8ULP's SIM LPAV can simultaneously act as
> clock controllers, reset controllers or mux controllers. Since these IPs
> offer different functionalities through different subsystem APIs, it's
> important to make sure that the register R-M-W cycles are performed under
> the same lock across all subsystem APIs. This will ensure that registers
> will not end up with the wrong values because of race conditions (e.g.
> clock consumer tries to update block control register A, while, at the
> same time, reset consumer tries to update the same block control register).
>
> However, the aforementioned race conditions will only impact block control
> IPs which use the same register for multiple functionalities. For example,
> i.MX8MP's AUDIOMIX block control IP provides clock gating functionalities
> and reset control functionalities through different registers. This is why
> the current approach (i.e. clock control and reset control work using
> different locks) has worked well so far.
>
> Since we want to extend this driver to be usable for i.MX8ULP's SIM LPAV
> block control IP, we need to make sure that clock control, reset control,
> and mux control APIs use the same lock since all of these functionalities
> are performed using the SYSCTRL0 register.
>
> To do so, we need to switch to the regmap API and, if possible, use the
> parent device's regmap, which, in the case of i.MX8ULP, will be the clock
> controller. This way, we can make sure that the clock gates and the reset
> controller will use the same lock to perform the register R-M-W cycles.
>
> This change will also work fine for cases where we don't really need to
> share the lock across multiple APIs (e.g. i.MX8MP's AUDIOMIX block
> control) since regmap will take care of the locking we were previously
> explicitly performing in the driver.
>
> The transition to the regmap API also involves some cleanup. Specifically,
> we can make use of devres to unmap the device's memory and get rid of the
> memory mapping-related error paths and the remove() function altogether.
>
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> ---
>  drivers/reset/reset-imx8mp-audiomix.c | 95 +++++++++++++++++----------
>  1 file changed, 61 insertions(+), 34 deletions(-)
>
> diff --git a/drivers/reset/reset-imx8mp-audiomix.c b/drivers/reset/reset-imx8mp-audiomix.c
> index e9643365a62c..c74ce6e04177 100644
> --- a/drivers/reset/reset-imx8mp-audiomix.c
> +++ b/drivers/reset/reset-imx8mp-audiomix.c
> @@ -11,6 +11,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> +#include <linux/regmap.h>
>  #include <linux/reset-controller.h>
>
>  #define IMX8MP_AUDIOMIX_EARC_RESET_OFFSET	0x200
> @@ -19,6 +20,7 @@
>  struct imx8mp_reset_map {
>  	unsigned int offset;
>  	unsigned int mask;
> +	unsigned int shift;
>  	bool active_low;
>  };
>
> @@ -26,24 +28,27 @@ static const struct imx8mp_reset_map reset_map[] = {
>  	[IMX8MP_AUDIOMIX_EARC_RESET] = {
>  		.offset	= IMX8MP_AUDIOMIX_EARC_RESET_OFFSET,
>  		.mask = BIT(0),
> +		.shift = 0,
>  		.active_low = true,
>  	},
>  	[IMX8MP_AUDIOMIX_EARC_PHY_RESET] = {
>  		.offset	= IMX8MP_AUDIOMIX_EARC_RESET_OFFSET,
>  		.mask = BIT(1),
> +		.shift = 1,
>  		.active_low = true,
>  	},
>  	[IMX8MP_AUDIOMIX_DSP_RUNSTALL] = {
>  		.offset	= IMX8MP_AUDIOMIX_DSP_RUNSTALL_OFFSET,
>  		.mask = BIT(5),
> +		.shift = 5,

why need shift?  you can use ffs(mask) to get shift.

>  		.active_low = false,
>  	},
>  };
>
>  struct imx8mp_audiomix_reset {
>  	struct reset_controller_dev rcdev;
> -	spinlock_t lock; /* protect register read-modify-write cycle */
>  	void __iomem *base;
> +	struct regmap *regmap;
>  };
>
>  static struct imx8mp_audiomix_reset *to_imx8mp_audiomix_reset(struct reset_controller_dev *rcdev)
> @@ -55,26 +60,15 @@ static int imx8mp_audiomix_update(struct reset_controller_dev *rcdev,
>  				  unsigned long id, bool assert)
>  {
>  	struct imx8mp_audiomix_reset *priv = to_imx8mp_audiomix_reset(rcdev);
> -	void __iomem *reg_addr = priv->base;
> -	unsigned int mask, offset, active_low;
> -	unsigned long reg, flags;
> +	unsigned int mask, offset, active_low, shift, val;
>
>  	mask = reset_map[id].mask;
>  	offset = reset_map[id].offset;
>  	active_low = reset_map[id].active_low;
> +	shift = reset_map[id].shift;
> +	val = (active_low ^ assert) << shift;
>
> -	spin_lock_irqsave(&priv->lock, flags);
> -
> -	reg = readl(reg_addr + offset);
> -	if (active_low ^ assert)
> -		reg |= mask;
> -	else
> -		reg &= ~mask;
> -	writel(reg, reg_addr + offset);
> -
> -	spin_unlock_irqrestore(&priv->lock, flags);
> -
> -	return 0;
> +	return regmap_update_bits(priv->regmap, offset, mask, val);
>  }
>
>  static int imx8mp_audiomix_reset_assert(struct reset_controller_dev *rcdev,
> @@ -94,6 +88,50 @@ static const struct reset_control_ops imx8mp_audiomix_reset_ops = {
>  	.deassert = imx8mp_audiomix_reset_deassert,
>  };
>
> +static const struct regmap_config regmap_config = {
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +};
> +
> +/* assumption: registered only if not using parent regmap */
> +static void imx8mp_audiomix_reset_iounmap(void *data)
> +{
> +	struct imx8mp_audiomix_reset *priv = dev_get_drvdata(data);
> +
> +	iounmap(priv->base);
> +}
> +
> +/* assumption: dev_set_drvdata() is called before this */
> +static int imx8mp_audiomix_reset_get_regmap(struct device *dev)
> +{
> +	struct imx8mp_audiomix_reset *priv;
> +	int ret;
> +
> +	priv = dev_get_drvdata(dev);
> +
> +	/* try to use the parent's regmap */
> +	priv->regmap = dev_get_regmap(dev->parent, NULL);
> +	if (priv->regmap)
> +		return 0;
> +
> +	/* ... if that's not possible then initialize the regmap right now */
> +	priv->base = of_iomap(dev->parent->of_node, 0);
> +	if (!priv->base)
> +		return dev_err_probe(dev, -ENOMEM, "failed to iomap address space\n");
> +
> +	ret = devm_add_action_or_reset(dev, imx8mp_audiomix_reset_iounmap, dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to register action\n");
> +
> +	priv->regmap = devm_regmap_init_mmio(dev, priv->base, &regmap_config);
> +	if (IS_ERR(priv->regmap))
> +		return dev_err_probe(dev, PTR_ERR(priv->regmap),
> +				     "failed to initialize regmap\n");
> +
> +	return 0;
> +}
> +
>  static int imx8mp_audiomix_reset_probe(struct auxiliary_device *adev,
>  				       const struct auxiliary_device_id *id)
>  {
> @@ -105,36 +143,26 @@ static int imx8mp_audiomix_reset_probe(struct auxiliary_device *adev,
>  	if (!priv)
>  		return -ENOMEM;
>
> -	spin_lock_init(&priv->lock);
> -
>  	priv->rcdev.owner     = THIS_MODULE;
>  	priv->rcdev.nr_resets = ARRAY_SIZE(reset_map);
>  	priv->rcdev.ops       = &imx8mp_audiomix_reset_ops;
>  	priv->rcdev.of_node   = dev->parent->of_node;
>  	priv->rcdev.dev	      = dev;
>  	priv->rcdev.of_reset_n_cells = 1;
> -	priv->base            = of_iomap(dev->parent->of_node, 0);
> -	if (!priv->base)
> -		return -ENOMEM;
>
> +	/* keep before call to imx8mp_audiomix_reset_init_regmap() */
>  	dev_set_drvdata(dev, priv);
>
> +	ret = imx8mp_audiomix_reset_get_regmap(dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to get regmap\n");
> +
>  	ret = devm_reset_controller_register(dev, &priv->rcdev);
>  	if (ret)
> -		goto out_unmap;
> +		return dev_err_probe(dev, ret,
> +				     "failed to register reset controller\n");
>
>  	return 0;
> -
> -out_unmap:
> -	iounmap(priv->base);
> -	return ret;
> -}
> -
> -static void imx8mp_audiomix_reset_remove(struct auxiliary_device *adev)
> -{
> -	struct imx8mp_audiomix_reset *priv = dev_get_drvdata(&adev->dev);
> -
> -	iounmap(priv->base);
>  }
>
>  static const struct auxiliary_device_id imx8mp_audiomix_reset_ids[] = {
> @@ -147,7 +175,6 @@ MODULE_DEVICE_TABLE(auxiliary, imx8mp_audiomix_reset_ids);
>
>  static struct auxiliary_driver imx8mp_audiomix_reset_driver = {
>  	.probe		= imx8mp_audiomix_reset_probe,
> -	.remove		= imx8mp_audiomix_reset_remove,

cleanup imx8mp_audiomix_reset_remove need seperate patch.

Frank

>  	.id_table	= imx8mp_audiomix_reset_ids,
>  };
>
> --
> 2.43.0
>

