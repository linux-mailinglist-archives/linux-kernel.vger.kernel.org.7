Return-Path: <linux-kernel+bounces-863212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26477BF7448
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 749BD1883218
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CCE342C81;
	Tue, 21 Oct 2025 15:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WuMIrXbi"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013021.outbound.protection.outlook.com [52.101.83.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056C3340279;
	Tue, 21 Oct 2025 15:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761059296; cv=fail; b=XiGCTFkOd9viaRmYWB4728iI7btKSw70EFAdnHp4frVnj2XXC+I0E2reijqYRZ1uwyHguuptR+xcSF/KMC8tdc1HJY0xDrPvpaaqqq4UA9iRiSd14vDnhoZcy+aTZenXsZuzmjzQmQkMxQO9JoQKgkFnnC8LaMUK0RJma6KRY4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761059296; c=relaxed/simple;
	bh=GQQsfv57fDbLoUpBZnj3Pgw6HwvBT4nnuPQPPGZjibs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=r9RbGF6M5ZjIQZTegWmngCkkkXCWy+Ic+wlPo+PeG1DBMfTGxj30LFPoV3ZcrTS+9DMTcmM7lqASm5NJcO4oqfA8sMZy4iz1IZYJGbtZsrAX+0OtxsqU25zpRaaY/ZEyQR3aXhUm0bgnPXbpivoPkLbuMJE4Mg8lIpYQu1SnJ4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WuMIrXbi reason="signature verification failed"; arc=fail smtp.client-ip=52.101.83.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OyJpaI3JL0aqtEcMag4Vm9CXR2bvccuehELAldsOi/IQ8DHAgxanhgcJMLp2elxQlqHMbBSeOYWiD6Uyfm0v6l9zflUn501okWoxWWiyMbaksaXVdQDYkbMkX4QNot6Rh5bDHc8QptlRXAD6eofxKz5dJsjFs7mcbUQNJIaR43LIlk2oksQPjasSF6/NUKv+UVHmlBiNhCjO0+11EzzogjW2xWZH9F8YMMIAVaFQr3Fv6rXLFvZGnE1SJtAzEmVlDcrfK+vQWvU7laYO6CFlYoTE2Z/OcLVLofoS/7Z7mGqXrOb/vMpN0oPq2TJZKVQeeTkNN1LPCRg60T9YamQlMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CujnjVsyA7cFJcroU/OmPrwANNRYYaoVFRkJRveBLNY=;
 b=DlDdC1Hg128liOzPgWQdJpl/mcUQ7wa8cG+UeqIH7V6U1F7zScy+K/m9ojV6AfJxAJVzauHXO9h9ZX0CMZKNi0werX3FA/2RL9lRRUTxnTafIaf7mHp7Ii9+in31YMGVEvXbm2cjgouTlQUzPFPOj/W8MLlZD4ofUPK8QwJvJkcT4Euk4PP3ANbMqrTVsLbQ93baSVECEFqhFLKGypxpDpCB6ixiHQCCC98gxVmhMFXj28mnLcUE96/rgzduzx2+BtztGE9+ITqeJTfu+aOoMtmHtMgPfHx1MvnHEWJdE8Zta4XPFznPX4lHEhgnLVkhJOSRpEP388SpyizyrgGbiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CujnjVsyA7cFJcroU/OmPrwANNRYYaoVFRkJRveBLNY=;
 b=WuMIrXbiE6MQIpDYnQruk8YNFUc60/PGFzkKEboPaMVQLXmyFzbZUHCYwCNa5aPMoW61OoQb4duCXTZOph701AUil7jLzLpQGwWo6n8+U3ZQlQJKwqm/495zlbViu2JQuqI2ONW0dRM2T449/KH02CfO7WuKpLcX9ZqwaJgAL994bNJLdpxZj3Vb5L4xY1YLkj2eH/Tk4srWKFd3JBI8CagCBlN+BehcXxFbacrCcW38t9k0zqlRSeC+Fn4sDki38lbThhipaakpZ4/3MC8xkXG94IctXtO4fDS4jIomBNZZ6guNuq+0J4k676aqB14S0h8j3uKdA8elTSq5hMPEhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by DU2PR04MB9211.eurprd04.prod.outlook.com (2603:10a6:10:2fa::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.11; Tue, 21 Oct
 2025 15:06:48 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9253.011; Tue, 21 Oct 2025
 15:06:48 +0000
Date: Tue, 21 Oct 2025 11:06:36 -0400
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
Subject: Re: [PATCH v2 7/8] reset: imx8mp-audiomix: Support i.MX8ULP SIM LPAV
Message-ID: <aPehfKuDCnW5sEcn@lizhi-Precision-Tower-5810>
References: <20251017112025.11997-1-laurentiumihalcea111@gmail.com>
 <20251017112025.11997-8-laurentiumihalcea111@gmail.com>
 <aPJZdAQwdoOP3cqN@lizhi-Precision-Tower-5810>
 <64b28a11-337a-42ba-8765-d94b19070d66@gmail.com>
 <aPZMJb9VwylTIiCM@lizhi-Precision-Tower-5810>
 <f1bbd303-2798-4476-921a-62b45fdb67ea@gmail.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f1bbd303-2798-4476-921a-62b45fdb67ea@gmail.com>
X-ClientProxiedBy: SJ0PR13CA0163.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::18) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|DU2PR04MB9211:EE_
X-MS-Office365-Filtering-Correlation-Id: 7aa0e7f4-bdbc-4047-930b-08de10b374f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?UBdltsgaXAatNOcEIM5+dJntMcoIgb7lmvfzLWUxBemZNjazGZTeBFtLjz?=
 =?iso-8859-1?Q?sBalZqgVRLAMNRGjIqIwqlM7R2bxF1hfuXT9lZRFg61F61H3wyj7gtHH31?=
 =?iso-8859-1?Q?o3vNpTXcP2zraJ1HmGC4RdmS73SgRqYkJQLueXj1Opb4J0i4cwr5aP38MT?=
 =?iso-8859-1?Q?rplbBy2HCRnnbjyRQ02TPFK7j4vQ62pX7qLOM6yA4sfIMYGJ1J5xdp9osG?=
 =?iso-8859-1?Q?gIefO7T+MM4aOI4UL1FjaHAk0sQ33e4P6MScCP02Mv5VirRFO3sjh8tGji?=
 =?iso-8859-1?Q?5Mu5f2owUuj/dbqUziulxqSV8rTCcXGoZaeLEA1QiQM+4STQwbIVB0AlO7?=
 =?iso-8859-1?Q?ukzFUatsIdiwLwr8LXhrXoViRvz2wdOzpW9BZiKrir8Pr1d+dk3oznz4td?=
 =?iso-8859-1?Q?08g5p0ISwZjEtxzCGLsbA/rmakEu2qVG8rXCiSAS4LxoeuLLeH64IWHTjB?=
 =?iso-8859-1?Q?KVTbyO/vGPAT8haHN+u9mEV3D5hqVXWt2E026REiqkIl5CdOfhPvgrG/EN?=
 =?iso-8859-1?Q?aEl3APU+ATG79o7v5k+E8DzTCNMYmXpf2xgvvd9lJfFgb6VysQYg6pToqZ?=
 =?iso-8859-1?Q?FrCuiJv4+/8vukoLYDfeB59ZZmZ4nRrECxrh4WW9xDYxkePVXdK2RI7x3S?=
 =?iso-8859-1?Q?jV6q9KFaDlALbC/OIH+F10ULzaNcv1s0NEfKaY1O3UqXaGOn7DDHMNdADJ?=
 =?iso-8859-1?Q?SvIEizEVlHn2FlelyfydijWCoLXKTn1ssfFHIemDlYGpNGoM31DIt1Mvyg?=
 =?iso-8859-1?Q?U37rawJ3y+1nqZymNakSesW2ZYzZ6iuUmHcN4KvHZlL02TnTKTrhDGVZoq?=
 =?iso-8859-1?Q?9mSy+2iBkyv7+TWTGi+qHrd4uct9kfRObutPkKkzchIfkKXetEpcPxbdL8?=
 =?iso-8859-1?Q?3has+ifZ+sbmvhmGuuLgS7RQIgGH7J6T6iQrkgSIe0dCom7cNguGk1bJkJ?=
 =?iso-8859-1?Q?D8eJ/lQ8cudGzEi2Jp3R42Cil34B/cSeQkz2528gHpuoGKC830PTsf0fQd?=
 =?iso-8859-1?Q?CMQSuqAle2H6WnxBnAFV0kWOpKdT+Vg3+sDsLeKNlrAqktThgvJ0euHJ2u?=
 =?iso-8859-1?Q?mFJi/9fcIUgCM6wzkC7aInc1JjqUX8JJ0/HluYwoFBAfgHQU+kZ8rcanM0?=
 =?iso-8859-1?Q?Vfz09jha23J7L5x7KNVrYGEnDvcCkRklRWNLE/VcMkq6GNh+0d7MEZc0tk?=
 =?iso-8859-1?Q?rCAkyrPhtADPqhWxgbFteIjK6TigN5jbHkqBFudUnou36WCDB+pBonxWhy?=
 =?iso-8859-1?Q?JHyJvphEzyiLZd9TWg5OqILJ2UCTaWNNV0raswDzjto+y71+Cmi5bzJQeT?=
 =?iso-8859-1?Q?KwLrNw+mCu+tmOgcujCJdWEF0nmmPMpfZrgSQYp3REXQamuPp/kqJPeN3K?=
 =?iso-8859-1?Q?c7NKogfzIs37KrV6qjdT6jmPCeYAuMdR821wmJbQ2P5OUQhYctw0cZxV7r?=
 =?iso-8859-1?Q?smDFCFrgl2rieq/l5qScKZudlPgzxE4A+NdqoFyIMWpq5FSuzqpOELXZhB?=
 =?iso-8859-1?Q?ERimLuPhnAvq6PGBaSgRGYbEwoj7iT9FpgIe2fGBzSUePq6mKdWqKHetQR?=
 =?iso-8859-1?Q?xf1GmOB0hnBUEEWMrQKdyaE2H5ga?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?aq9NJNabPJB/t9aDNsCWhw+Zs8pJSd36QT33jcCT1ZOBBQiqrmUWFY8VV4?=
 =?iso-8859-1?Q?iKGVAeU0/p42vsstSD5o89/u/jHAiGDPWaPvibaeGDBxus5ApIZuBs4Jef?=
 =?iso-8859-1?Q?YmHkAvbaGX5esuPJx0iYEAeQ4VLAcL+iZXkY0qIRRJ19KiniMevTiHGy5X?=
 =?iso-8859-1?Q?Cal1Ofp3H/VzAaEqoxzFNYw4mRExf3JAaPOq8wh2Z53MRjV3biJYs2zbSc?=
 =?iso-8859-1?Q?nQFeYa84pwb/GXag++wA4Gz2B1NZK+kKxytfPX1djJPcbWT8H3bEFaYwow?=
 =?iso-8859-1?Q?PpIf736++pq19NeuMIabicnP4FGGalWUngrh0jtsOLITpJeSVUcwtcDjFd?=
 =?iso-8859-1?Q?cUk1KnQwrT7Co3KL0P4XkmvCtUTU/LC3ZcD0XXNndqF49eSKP9yhEBK/H3?=
 =?iso-8859-1?Q?jByHCiXntw2OWS/JqhDKJdYlK/BnT8KY2cNq4D3JUK9rzfWp/plEvje2X4?=
 =?iso-8859-1?Q?PRwJtX+4JWjGq9rotjMMd7iL7ZL3i/ckad2MUDm68IInewAjmgPRTbi4PZ?=
 =?iso-8859-1?Q?FMLf6O66OJ3Wtjjt7VYkEhqV4tYWkA+lK9r0rh2vTKfjWmXdtpASytMjuK?=
 =?iso-8859-1?Q?4rq9l8nfH23Ria3hmaLmsRkhAOzxw4TodPzqPjHwsPCcpGFxIuHMRhTbQt?=
 =?iso-8859-1?Q?/sjEan27RBxK8z8UFxziNMSgSox4AisO3kZ1TQsB2k1JLHVVPrA2Hqi32t?=
 =?iso-8859-1?Q?ZEjjYhrTm+4vhImbjrYZXJJN4wVHGHwNnH4MmtUDQs8m+vkjGw2AO3MpSx?=
 =?iso-8859-1?Q?4Zgnupq8cNVYzvZHDyudfk4Vi0Ibnagubmm3kD4HDwdIn2sw71pMakVr85?=
 =?iso-8859-1?Q?kmzs6eoiexhpdEhSXgBA2NqSZrLDMXs+3ocARgXh7MnMmoQzx9nMk8tKE2?=
 =?iso-8859-1?Q?ENjCzVH2Slc6sDRTjcQ7pu41bctS5tM3SSdqAfhQosdSql9JVUOXFwcaPz?=
 =?iso-8859-1?Q?8pQj85Jqb/ODYoIxYozNzym5/IMq2qVCzCKMpsC5ObKmd0wam9hgkejHmK?=
 =?iso-8859-1?Q?vJTYjDzJqf8claFXmhF1BUkQXKIpXo3mETtzCUM5uXgoOed3A37RaXRkHu?=
 =?iso-8859-1?Q?C5KAZeYr+NGEv0KMlvpCaT5rz2u8jiC0T9s+UqbsjxiUm/KowX3x8+NWfD?=
 =?iso-8859-1?Q?Si3OQpPMflsTNQ+OwHyESn4WG28e828cmbb8CBukcieiqm/YfBOJq1kwaS?=
 =?iso-8859-1?Q?5Q9N0Qsmm2A74o2aIeLHMZVZ2u9oeaXOjRWUntHzKaBvHfc3OiM74cI5vH?=
 =?iso-8859-1?Q?emKaSo7hrt5VMD/4lW+gz6mL4Zl3HJyFpQ1NO0mWoSggS+9Ighqcs7g38c?=
 =?iso-8859-1?Q?KVXHH4sthOYcPFhgswgRXiOG/HAqi3ZWNMuWiQztCyYkIk+ZLF2hBbGjt0?=
 =?iso-8859-1?Q?CGQxfBu9xlXPSSFu9kpVkldPm+VkvmTAtLsVaXn7Yrp48p++kz7GvBs3R5?=
 =?iso-8859-1?Q?apjbWsw1NxBfgCapFrQtsx4lpq+nHhKqn6ZmTwWRIl3nCcyMCS5dfb4rmj?=
 =?iso-8859-1?Q?1RSlPKnA3d3TaU0JxyC0HcEd37KcZh5goC+i0be200dfk9HO4qi/LtxaGZ?=
 =?iso-8859-1?Q?ljaOY7cpjisr5A4t+W/Phc1rtLtEpmvlV+gAypCUlEGOZ4p9eJ1ppk3x6V?=
 =?iso-8859-1?Q?YV2UEk71dYGZ0fRUXqqdxj/c6N1xf70tXe?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aa0e7f4-bdbc-4047-930b-08de10b374f5
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 15:06:48.1983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IDTf3w5KVxdWm3sFy1lLesyeq+7PNppVvWENLRjKO2r5T4Pcr5k67r0uy+igmXPcFNMBbv27xlNOCnf4VORxIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9211

On Tue, Oct 21, 2025 at 06:16:41AM -0700, Laurentiu Mihalcea wrote:
>
> On 10/20/2025 7:50 AM, Frank Li wrote:
> > On Mon, Oct 20, 2025 at 07:29:28AM -0700, Laurentiu Mihalcea wrote:
> >> On 10/17/2025 7:57 AM, Frank Li wrote:
> >>> On Fri, Oct 17, 2025 at 04:20:24AM -0700, Laurentiu Mihalcea wrote:
> >>>> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> >>>>
> >>>> Support i.MX8ULP's SIM LPAV by adding its reset map definition.
> >>>>
> >>>> Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
> >>>> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> >>>> ---
> >>>>  drivers/reset/reset-imx8mp-audiomix.c | 51 +++++++++++++++++++++++++++
> >>>>  1 file changed, 51 insertions(+)
> >>>>
> >>>> diff --git a/drivers/reset/reset-imx8mp-audiomix.c b/drivers/reset/reset-imx8mp-audiomix.c
> >>>> index c370913107f5..b333d7c1442a 100644
> >>>> --- a/drivers/reset/reset-imx8mp-audiomix.c
> >>>> +++ b/drivers/reset/reset-imx8mp-audiomix.c
> >>>> @@ -3,6 +3,7 @@
> >>>>   * Copyright 2024 NXP
> >>>>   */
> >>>>
> >>>> +#include <dt-bindings/reset/fsl,imx8ulp-sim-lpav.h>
> >>>>  #include <dt-bindings/reset/imx8mp-reset-audiomix.h>
> >>>>
> >>>>  #include <linux/auxiliary_bus.h>
> >>>> @@ -17,6 +18,8 @@
> >>>>  #define IMX8MP_AUDIOMIX_EARC_RESET_OFFSET	0x200
> >>>>  #define IMX8MP_AUDIOMIX_DSP_RUNSTALL_OFFSET	0x108
> >>>>
> >>>> +#define IMX8ULP_SIM_LPAV_SYSCTRL0_OFFSET	0x8
> >>>> +
> >>>>  struct imx8mp_reset_map {
> >>>>  	unsigned int offset;
> >>>>  	unsigned int mask;
> >>>> @@ -55,6 +58,50 @@ static const struct imx8mp_reset_info imx8mp_reset_info = {
> >>>>  	.num_lines = ARRAY_SIZE(imx8mp_reset_map),
> >>>>  };
> >>>>
> >>>> +static const struct imx8mp_reset_map imx8ulp_reset_map[] = {
> >>>> +	[IMX8ULP_SIM_LPAV_HIFI4_DSP_DBG_RST] = {
> >>>> +		.offset = IMX8ULP_SIM_LPAV_SYSCTRL0_OFFSET,
> >>>> +		.mask = BIT(25),
> >>> Register defination still perfer use macro. If not, let me know.
> >> I see no value in adding defines for the masks (see patch 4 commit message)
> >>
> >> in this particular scenario.
> >>
> >>
> >> Is the assignment of the "mask" field for the "struct imx8mp_reset_map" item found
> >>
> >> at index  IMX8ULP_SIM_LPAV_HIFI4_DSP_DBG_RST not enough to deduce that the
> >>
> >> constant we're using is the mask for the DSP_DBG_RST bit?
> > This bit is NOT software choose bit, which must be align hardware spec.
> > Define macro help map name to spec and easy to look for spec by use macro.
>
>
> yeah, we already have the DT binding macros for that which perfectly match the name
>
> of the corresponding bit in the SYSCTRL0 register. I don't see how adding 6 more macros
>
> with the SAME name as the DT binding macros and the "_MASK" suffix would help you in
>
> this regard?

Okay, make sense.

Frank
>
>
> >
> > There are over thousand result to seach bit 25.
> >
> > eventhough search SYSCTRL0, may have many SYSCTRL0 in RM.
> >
> > Frank
> >>
> >>> Frank
> >>>> +		.shift = 25,
> >>>> +		.active_low = false,
> >>>> +	},
> >>>> +	[IMX8ULP_SIM_LPAV_HIFI4_DSP_RST] = {
> >>>> +		.offset = IMX8ULP_SIM_LPAV_SYSCTRL0_OFFSET,
> >>>> +		.mask = BIT(16),
> >>>> +		.shift = 16,
> >>>> +		.active_low = false,
> >>>> +	},
> >>>> +	[IMX8ULP_SIM_LPAV_HIFI4_DSP_STALL] = {
> >>>> +		.offset = IMX8ULP_SIM_LPAV_SYSCTRL0_OFFSET,
> >>>> +		.mask = BIT(13),
> >>>> +		.shift = 13,
> >>>> +		.active_low = false,
> >>>> +	},
> >>>> +	[IMX8ULP_SIM_LPAV_DSI_RST_BYTE_N] = {
> >>>> +		.offset = IMX8ULP_SIM_LPAV_SYSCTRL0_OFFSET,
> >>>> +		.mask = BIT(5),
> >>>> +		.shift = 5,
> >>>> +		.active_low = true,
> >>>> +	},
> >>>> +	[IMX8ULP_SIM_LPAV_DSI_RST_ESC_N] = {
> >>>> +		.offset = IMX8ULP_SIM_LPAV_SYSCTRL0_OFFSET,
> >>>> +		.mask = BIT(4),
> >>>> +		.shift = 4,
> >>>> +		.active_low = true,
> >>>> +	},
> >>>> +	[IMX8ULP_SIM_LPAV_DSI_RST_DPI_N] = {
> >>>> +		.offset = IMX8ULP_SIM_LPAV_SYSCTRL0_OFFSET,
> >>>> +		.mask = BIT(3),
> >>>> +		.shift = 3,
> >>>> +		.active_low = true,
> >>>> +	},
> >>>> +};
> >>>> +
> >>>> +static const struct imx8mp_reset_info imx8ulp_reset_info = {
> >>>> +	.map = imx8ulp_reset_map,
> >>>> +	.num_lines = ARRAY_SIZE(imx8ulp_reset_map),
> >>>> +};
> >>>> +
> >>>>  struct imx8mp_audiomix_reset {
> >>>>  	struct reset_controller_dev rcdev;
> >>>>  	void __iomem *base;
> >>>> @@ -183,6 +230,10 @@ static const struct auxiliary_device_id imx8mp_audiomix_reset_ids[] = {
> >>>>  		.name = "clk_imx8mp_audiomix.reset",
> >>>>  		.driver_data = (kernel_ulong_t)&imx8mp_reset_info,
> >>>>  	},
> >>>> +	{
> >>>> +		.name = "clk_imx8ulp_sim_lpav.reset",
> >>>> +		.driver_data = (kernel_ulong_t)&imx8ulp_reset_info,
> >>>> +	},
> >>>>  	{ }
> >>>>  };
> >>>>  MODULE_DEVICE_TABLE(auxiliary, imx8mp_audiomix_reset_ids);
> >>>> --
> >>>> 2.43.0
> >>>>

