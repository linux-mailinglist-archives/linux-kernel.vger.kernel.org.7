Return-Path: <linux-kernel+bounces-885151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC7BC321FD
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 17:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25F973B2DAB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 16:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31932877FC;
	Tue,  4 Nov 2025 16:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YE896BRH"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010001.outbound.protection.outlook.com [52.101.69.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619B531B132;
	Tue,  4 Nov 2025 16:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762274711; cv=fail; b=R1zSZmGJ6mTvLdqOL4QV0hF4hhb16HDKlsFlD6IN4jR8R6VueZxgF0TPoxB2tkv0OPoC+7oW6buQsiWmABV0HDD0JzLBPflxul+o+OF2JqJtPRyWMnd9a0bk5uHu7bL8p5OC1m4t4Ebl6QkZ/9wX7hvuOz90CmUjQm2KnNrJTEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762274711; c=relaxed/simple;
	bh=NnbjHYOWmLBGcYfESUGFhM92NS4bje5D2JkKXO9BRPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DpZQGyaEgm7ifXqEpqd7RFcSOm/4kU6ur+tyBMnAc+5n5E8uq/amVNRd8LVAdOBpcJmUUEOshslfCEyz4AmoLSPEkaesc4feyQxBN7LxJp46TsvWFO9XxblJPsDTJINN8pyPIXDFe1/re5tmV5ToN6D4jl7i0qoLIvfltaYCRik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YE896BRH; arc=fail smtp.client-ip=52.101.69.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O3GXEZgTWotnrWy+yfsG5GoUT6aTO/FfHAf888VQGKZBLKrrC68LlXKHTk9r/yjjQCzwc9S8al92VANd3smYGoD/MEjTVAsD5My/hZl1/ImBii/GQ2W7CFZXCl03qSyloX8UAUPF5UVgeSv5IfQJIF1Z5cWKpIONEOu+2iDTzJ9W9/5p3k5RfTk59alm1q1N1DOaUkYrTN2FfAu67aPjfhuOzPLrKIJbNYq6W4iAAaHKx0DOAcHSve6FQKHmBqVzRIMHMXI9qXxVFYZ5R+9LrIf/fU4F4czzNN3NK9TNgISc2VEx0A1n32SJO2be7/yEE9YT1FRY3d4ZoMqGtiPYPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rW1GJi4aiIJpoXQbsiWj9rd0ncGdhqLn9jjFI472UaY=;
 b=bBgPssDKQ/3Es/Ss0ZeIRf548bhNaR3bxRpJckgd4heDuCMvUXnVMVUvFEne5lcumSZQn2mop4JmdlBYbeA9rvVepwLD/Jyi4bmGhFWxpIcE74r/zvm7EJmAowmzOVHTVWCc9X8A7ZQmUoQY+emNcKxo2Hw8B78nDHZUzftw7m6J4EfQp7DWEeX2KU5UFJ5IkzKIrlUOgqq8omBMsxRabtarD5/uxND5QTi7fBkrvokZXu4hL5D77hJ3UmrKvn3kIRv+n/cqOiBkodZuYSNko8GsecQzHyoQrGidzpr+whw7DLuArSOkFWFQiDHF4A3XXAN7hiyRhjgPOvg3DFHNgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rW1GJi4aiIJpoXQbsiWj9rd0ncGdhqLn9jjFI472UaY=;
 b=YE896BRHwTIhJxqhf+7VMIvx5QAcw7HVnQPSwA0ovWv86qAEz1L+s0AZEz5f3n0xY7LMu1xQeo9s9BgwPJ+f7av10/GKWhYwsb3/dFWR1A7JdQ9oG3qmVk0JP67m5qM9Y4wI03q0zCYXiVkRGmpJjDa/gROq0N0kLzf8FZici0QTWiiFeywykO3fsdO3ajTHWxweTucpU+xzijMwnHhzmc8YgxXvktwi00Shd1TwvXHwa1ONldOvrZOshaNkDGRZVJFkPVCnTvs4dbBeRk7oj3EdWn+KRyLauEMfIeNdVhC+2ZZPcOKE5VU6oogkKKhIqHpuXET0Q9RZtuGAc1Wo4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AM0PR04MB7188.eurprd04.prod.outlook.com (2603:10a6:208:192::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 4 Nov
 2025 16:45:05 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9298.006; Tue, 4 Nov 2025
 16:45:04 +0000
Date: Tue, 4 Nov 2025 11:44:54 -0500
From: Frank Li <Frank.li@nxp.com>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Abel Vesa <abelvesa@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>, linux-clk@vger.kernel.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v4 5/8] reset: imx8mp-audiomix: Switch to using regmap API
Message-ID: <aQothuvsclJoP74u@lizhi-Precision-Tower-5810>
References: <20251104120301.913-1-laurentiumihalcea111@gmail.com>
 <20251104120301.913-6-laurentiumihalcea111@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104120301.913-6-laurentiumihalcea111@gmail.com>
X-ClientProxiedBy: SJ0PR03CA0369.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::14) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AM0PR04MB7188:EE_
X-MS-Office365-Filtering-Correlation-Id: 44a74ffb-8c17-4ff0-af99-08de1bc18160
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OvW+PNPKxvJi0rijlQa5Pio9Zkx/ysO18LZKSbZzUoo5yeZUrxPez9VTlo0z?=
 =?us-ascii?Q?cjbfAWClyEw9J8D+HADULhnyh6U9z0+/3dAQ2T//kmsYIN/tecfo6TsedXzN?=
 =?us-ascii?Q?JarlVVzmtbrQjP+clI5tVdT/2LE9L/EKR/y9LT0Q8qJg089y2Q5p++qnAVML?=
 =?us-ascii?Q?o9btuRmIivm6g5oMgwW9VoD7As9qVwhZ2uJfmQZC3TNr1wihuYW8c0QH0CAm?=
 =?us-ascii?Q?F/rg0yrsc4dZGyJImU1xF9J1GhkMwLeEgKnaVe/CqRGqloFL3S07skvNmhor?=
 =?us-ascii?Q?Oq9clL7E5Z3Hptt6+jsVbvUUBvjq5pr0r/cbjSgAP8hm3FLSQg00Gf8qzLO7?=
 =?us-ascii?Q?LIORIIY4gKcwAWxSNE20E6PA16GMIW/vHD6XjAHD33hF4ln2igeUSkyPFbpf?=
 =?us-ascii?Q?n6SK/UOjmw4DPulOoxqmI/DrRBjgsyEJImyBd3pZT+oivBlDVEJrsZq15DUF?=
 =?us-ascii?Q?cJbNH3kzJuM4/NRJZSlnyzMaG3KIlSnx8+0A2sa23CWhNLqqyNpTkxM3KXL0?=
 =?us-ascii?Q?bAYZMrTP3gb7yHY0E70o1q9qYF27ppkBeXtBXdWwZc7iHzNuKpRBFo7a86LJ?=
 =?us-ascii?Q?X28V7Jod/75mVWkkyKLDf4nU41FpzOgooyljQSWCm5e9jR9/+yef2LnaaFUf?=
 =?us-ascii?Q?9Bnu4HyyB6hC+s0R0Ugh1pTdErRgU4xcyKv60nhpr51Bk4DLwcxUhokiIkAV?=
 =?us-ascii?Q?xKk/5dJQxW7sXEVnqryYd7dZ5zfCNfeh2s32KfG9m1BELo0g3OoqdgL55jgk?=
 =?us-ascii?Q?uLJyrgN0LVwGyg1NC94ZRDVNBixEIp1AMkU6KjoKETaVRjQXxvNW88dUfs2+?=
 =?us-ascii?Q?CFeqc4G4dOxGE/F1ZAudRNOnZPcgpIdNMhb7ycag4eP6MBGBTcQAN04yuK2u?=
 =?us-ascii?Q?ClCAUJJnM0CmcddpCIh4MKAQZnxZQZklCLe93RrqBURV/xowFaq+DTK87q4+?=
 =?us-ascii?Q?ephwJjWy6y7M3uN0rsIB5aRJD7/EgQydQ6lqsWKvc35PK1WHOBm+lRcsWpPr?=
 =?us-ascii?Q?C/iusF5TYxqkWIJdRiyS9IoS1ftcXtrzHMzgLkgVXXXTyP+fUXwv7YvYiNqB?=
 =?us-ascii?Q?0ovOUPtMVOb1r03106XCckUd0PgqxNiPDQkZyMXpcW1vGPujo0ivgte0iA5j?=
 =?us-ascii?Q?gn9R3JgpGQqRRBNNqLnH4evLsDLgVVVwlZ/OokOh5V+Apl9BcF+91KdgvCn4?=
 =?us-ascii?Q?GxTYsokz+k1nWadW4uqlGpGKimcwJwnBbCa1njrLcAXv7D3uzCd/9zUqrrWo?=
 =?us-ascii?Q?0zpn9V80tCgGQkb+VyJoFTaFKLHYCwx+LHHdDhmvzHLafYczkhqdOBXTKegG?=
 =?us-ascii?Q?G9Sc94Zl+O1R1EE8hVpeKMnFjKk7g5gjjAURASq2UCBMNXyyaEGSwON92nzQ?=
 =?us-ascii?Q?n532lXdlDwZXFCK78lQFs8MN2qdEDrTwvvBhCb+Z36O5CnuIfy/2yEubAJ41?=
 =?us-ascii?Q?+mGjVPUqx4xf4ykqHQMPccQGgsM6HNNeiLfAxYONBU4ia0eLpKjRKxhOpKA9?=
 =?us-ascii?Q?BoYuOVlrwAbc0H3Rzn8o7D0882EtN3Uypmwq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bU4Fko63VGep5PFcluBwDnFavSq91WOMauSCG8CW9/B5Q7S3VJev5AOh9Zqz?=
 =?us-ascii?Q?jJsiNzcyhwuUD7SlT1z1h08+C2V5OrsFerMI+rICuOK35B2jG/dl4TIRpvAW?=
 =?us-ascii?Q?tFh+NNFX44vSrSo1al6NE+6fsr6UrvhV196VAu3PZKX+fc0lZL4WCq9ruvao?=
 =?us-ascii?Q?aSlfOpCbrWPFeFvDAP2aDePzKku7Hg0mvjqltL4BiY43mBKNyB+S523aqSvw?=
 =?us-ascii?Q?CWnBgJ7X9gXl54SplsbJp5rkxOffNDr5y1gKB55YWg9VZUYrhb6kcEYTDHBg?=
 =?us-ascii?Q?pVC+UNarGpKDPf21qqKcrWwm0kWEIqOTjc5erYscpDzUnvKCN/OdFuqMBEUs?=
 =?us-ascii?Q?4I+GwoNPJBBGd9mlyMxVK8gEEJ9dUcwERGj8EYpUaOGiBZlRjjE1X7j7wjXi?=
 =?us-ascii?Q?VsjP7yZz1mox/ViT+6aIju0LgA14XYH5Ggktisb4KsbJHX1ZntuiOcH6DIj/?=
 =?us-ascii?Q?3inIyPzxEoYMqyGNqLdSUlsF9f9BscgUUJpQWgHrW/vcHHLf2iq+nXnhwh22?=
 =?us-ascii?Q?JG0DMyh37u/GowV4w6FgfP66pjYcAHhySfGBDGaENSkdlNCvnl8Utb44a4Fg?=
 =?us-ascii?Q?N519r9BirhBaL75jNBJMGKLtHub6J+J05Kc2We/R6nP+MZFpqf7Fi/iYDrze?=
 =?us-ascii?Q?Pyiqwefjq1/XXb9pZTS9upIpd9HC9lnzT4RLbUm5YDALcn318uDcK7bHl0YX?=
 =?us-ascii?Q?fiHPmgfP+vvqESmfsNj1GGjeANz/THWSBdKXoirmIOq4KQ9SQCVxDvtnjjFv?=
 =?us-ascii?Q?kIdqK/9oS+zoBWn0s6nnV4GVs1GKP9e9W1wgo3dyOpUWY4NDus5GV4X4ZQK1?=
 =?us-ascii?Q?g+Pn/bB3ty+SGXpjgIudKiQDxCP2nEPCWiIfGEoMALRhFZdxjZQgE5Y7MDfG?=
 =?us-ascii?Q?auyMNNppbmkPSiTNKjg65MXPGoy3SrAklXTetV37CaDMP8TmsTFWwoAxWQY8?=
 =?us-ascii?Q?PBj744H6XC0jOePqczoXil3zNDvwwcViDmfR5YUfEWdcBXEA5W9J3JbJC/3k?=
 =?us-ascii?Q?NEoz8+o/1XDj+UQqUFGqAZHJmXd8DIrf03bScgZIrkKUtaGNM+swborJCFp5?=
 =?us-ascii?Q?MkCFVFzFg2eyvhbMOXXn/F1L1gTEyNsdAFctpTvviYP9Lu8hOI379KvAsWvn?=
 =?us-ascii?Q?HynxlnybUd4wNGujrfzwW7rKWMFZBhMtW90bxnq+0IWkdNiPjVNJnYyUGXQm?=
 =?us-ascii?Q?hm7JWB4+b8xf35mTGnI9qO6zzaZ1Kqn//KccOCvCvyF9C1BhzUeziXVH4bBO?=
 =?us-ascii?Q?p9G+CP8eysm33VjMBsjSDe56cIlRomPy/ajcpIc0b0AzWUfsykGPuA/AAGOr?=
 =?us-ascii?Q?TekdO+rflh0VlK/dum1D2QWI/7xv2bLZxGaY82zsrJjcLFrHYoqxsGbwAYln?=
 =?us-ascii?Q?PKL8v6qIGJmdJWhjZEZB0E+whqgpycO8M2WtzdGeR0OSGC1BPzP0CABl862W?=
 =?us-ascii?Q?6Ni1vU7FwsfCw6RcBlog9Mimu3jfVRZXj6Hi0QBciVSZSu7L+RVOeQGMFITN?=
 =?us-ascii?Q?MU3q+ix3SkiP8bUmjtPmlkcpnwLgr6IFOyRQ58wh7+vh5qrDgOw8RUzfUzAX?=
 =?us-ascii?Q?w5bZCL8a//kXS7CRZ1mxJb7ZL2uYJTUU+8XvCPgR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44a74ffb-8c17-4ff0-af99-08de1bc18160
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 16:45:04.7894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1P685YVkDmlSOg/eDeW4OT04A7T3sfjlpKxO/Wv1PkXxOZe87K8fyijAlKbmmJ7/rSj9lD7/4FzBXDFGZF4pAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7188

On Tue, Nov 04, 2025 at 04:02:58AM -0800, Laurentiu Mihalcea wrote:
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>
> Switch to using the regmap API to allow performing register operations
> under the same lock. This is needed for cases such as i.MX8ULP's SIM LPAV
> where clock gating, reset control and MUX-ing is performed via the same
> register (i.e. SYSCTRL0) and different subsystem APIs.
>
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> ---
>  drivers/reset/reset-imx8mp-audiomix.c | 93 +++++++++++++++++----------
>  1 file changed, 58 insertions(+), 35 deletions(-)
>
> diff --git a/drivers/reset/reset-imx8mp-audiomix.c b/drivers/reset/reset-imx8mp-audiomix.c
> index e9643365a62c..18a7f68aa59f 100644
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
> @@ -42,8 +43,7 @@ static const struct imx8mp_reset_map reset_map[] = {
>
>  struct imx8mp_audiomix_reset {
>  	struct reset_controller_dev rcdev;
> -	spinlock_t lock; /* protect register read-modify-write cycle */
> -	void __iomem *base;
> +	struct regmap *regmap;
>  };
>
>  static struct imx8mp_audiomix_reset *to_imx8mp_audiomix_reset(struct reset_controller_dev *rcdev)
> @@ -55,26 +55,15 @@ static int imx8mp_audiomix_update(struct reset_controller_dev *rcdev,
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
> +	shift = ffs(mask) - 1;
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
> @@ -94,6 +83,52 @@ static const struct reset_control_ops imx8mp_audiomix_reset_ops = {
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
> +	void __iomem *base = (void __iomem *)data;
> +
> +	iounmap(base);
> +}
> +
> +static int imx8mp_audiomix_reset_get_regmap(struct imx8mp_audiomix_reset *priv)
> +{
> +	void __iomem *base;
> +	struct device *dev;
> +	int ret;
> +
> +	dev = priv->rcdev.dev;
> +
> +	/* try to use the parent's regmap */
> +	priv->regmap = dev_get_regmap(dev->parent, NULL);
> +	if (priv->regmap)
> +		return 0;
> +
> +	/* ... if that's not possible then initialize the regmap right now */
> +	base = of_iomap(dev->parent->of_node, 0);
> +	if (!base)
> +		return dev_err_probe(dev, -ENOMEM, "failed to iomap address space\n");
> +
> +	ret = devm_add_action_or_reset(dev,
> +				       imx8mp_audiomix_reset_iounmap,
> +				       (void __force *)base);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to register action\n");
> +
> +	priv->regmap = devm_regmap_init_mmio(dev, base, &regmap_config);
> +	if (IS_ERR(priv->regmap))
> +		return dev_err_probe(dev, PTR_ERR(priv->regmap),
> +				     "failed to initialize regmap\n");

Does anyone still base?  Supposed aux device probed by parent devices,
if all parent already switch to regmap, you can remove this part.

Frank

> +
> +	return 0;
> +}
> +
>  static int imx8mp_audiomix_reset_probe(struct auxiliary_device *adev,
>  				       const struct auxiliary_device_id *id)
>  {
> @@ -105,36 +140,25 @@ static int imx8mp_audiomix_reset_probe(struct auxiliary_device *adev,
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
>  	dev_set_drvdata(dev, priv);
>
> +	ret = imx8mp_audiomix_reset_get_regmap(priv);
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
> @@ -147,7 +171,6 @@ MODULE_DEVICE_TABLE(auxiliary, imx8mp_audiomix_reset_ids);
>
>  static struct auxiliary_driver imx8mp_audiomix_reset_driver = {
>  	.probe		= imx8mp_audiomix_reset_probe,
> -	.remove		= imx8mp_audiomix_reset_remove,
>  	.id_table	= imx8mp_audiomix_reset_ids,
>  };
>
> --
> 2.43.0
>

