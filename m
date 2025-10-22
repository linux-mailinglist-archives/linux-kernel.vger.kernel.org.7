Return-Path: <linux-kernel+bounces-865486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61344BFD446
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 18:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7344518839E6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2FEC27A448;
	Wed, 22 Oct 2025 16:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VD9OAhqt"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013016.outbound.protection.outlook.com [52.101.72.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD71D1F5851;
	Wed, 22 Oct 2025 16:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761149805; cv=fail; b=bfzh/Ym9yWwsTzj9wuhW1HyHi1cKHmnDgnU1f9FoB8yI+HtwIE5QTO+p/e/gIUInIhCVMwfOyjbOeVhXD30OW5v/CCfbgNiWMkksCqp5oGdnMrtVxruRr2a8PBPawLnAap9wKwsSX3FyonKt0hFYCJH86Y51dOGU1j7K7ShfDnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761149805; c=relaxed/simple;
	bh=7xpSQz3FOZbTQZtBeV+BkxO6s+VD1IfdXjhxkCNbeQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mgtbOdFQa6+/6eoEXf/srExQ+ZJHmf0huJ6u07HfoP8mX3cQ/QUJZYlIjkTM2Sx7G/CC/irieAp2xUdR9J3RpntGaJQX1Udw8B9UmAeH2ld4ezQVf0jrzy7X/vMFy+837kLanuAe2qqSfkpmtsBekVB7gyJuUEo9StPn0XEepS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VD9OAhqt; arc=fail smtp.client-ip=52.101.72.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uT+mSMEC5apJkipylODFuP5Szff9JkpBLwCZXZHRdHY0TtEa7Op3318dc4kJiCklnI0+Q9w/kifWN8ZlpwFmxOCSeBDbRYahsVjCqpLLZZ6myO5XUcXvSnQ+pQcZKHDqOTM7+33+kac8plCh6pU7Mf29p2D0q7yPhEr91T2cyZOlcwxLM3tFpmNzVT2ZxtuqfP18B3L599doGiMSzgaga8oQR90azk8tM889Yvgp69TATpHjxTGPn+ZPeDsLMzOuofyh7Y9ptkEWb7SZgYhuFiMHWoHyp63bqwHbdCtAzpf1DfT/3uj9BIW3QA9f0BoZeYDGq88V7nMCy7/687AQ6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mfQqVCG12lBJlXYf9B66eJPuYwDEyTjrGd2+YlGQqO0=;
 b=NhL+0QiTy4OEm2UbLuZOvcGNFKN73bR5XWjbkf1cUgxEeSxGFNrWMhS2qej6ccLZ8IMM4JoYmj848BgxhggU2lMbvAzASlacTFnDOaNS1Zl7iRwVSX7SUyAh/WGAZhOX73TOgqwmKOt74gaGUUXDm95XBWJM7ambIiGhRTSIXC321o5iXerGSi2Nf0rP6WOGAp/Y1Z3yDn2T8pkPl36nb1A6yJu4WvQ9j3YRg83oQ4ST4kZiyd5o+aDT+6uNsMIl0FqFYqE/A5eClZ9w9UwBOopCqsmupMFWd9jnLORK2Z31HajojapIbWG7OAPTDTCs4o47AGfAPK1HFsWNRsZMeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mfQqVCG12lBJlXYf9B66eJPuYwDEyTjrGd2+YlGQqO0=;
 b=VD9OAhqth0RyWF6aJ+BoYeFPOSQIxsO4RMKf2hn4KrY4BpAqgbKndn+1V8VxWSGyC9HBSHKkS1UQuH5WHflW2kE4GIy3mK/pqlbIpRsp6kBff47Zg1NuFV6b1wLZ/H18oipFfr5ZsNQMWn9AKoQrLRInohejvvSo5DRIf24a4v4z9G66q1yOIN5w1UdDyOEqGmet2S0tYnSrmlO2VJazZU1Res5ZjwZi+X8b1hbmyblB9gOmENyVTE2TsYmh5LW1YX9APUa6mKOxG9vi7HRd7X5D855cHuWMOnTfNqksThPDGMqe/Tdz664y3a3k/JhA4Kx7WPQDs7crMwA8YzfvwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by DU2PR04MB9130.eurprd04.prod.outlook.com (2603:10a6:10:2f5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 16:16:33 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 16:16:33 +0000
Date: Wed, 22 Oct 2025 12:16:22 -0400
From: Frank Li <Frank.li@nxp.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>,
	Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
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
Subject: Re: [PATCH v2 2/8] dt-bindings: clock: document 8ULP's SIM LPAV
Message-ID: <aPkDVqRGBG9ILnQ9@lizhi-Precision-Tower-5810>
References: <20251017112025.11997-1-laurentiumihalcea111@gmail.com>
 <20251017112025.11997-3-laurentiumihalcea111@gmail.com>
 <20251022140841.GB11174@nxa18884-linux.ap.freescale.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022140841.GB11174@nxa18884-linux.ap.freescale.net>
X-ClientProxiedBy: BYAPR21CA0007.namprd21.prod.outlook.com
 (2603:10b6:a03:114::17) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|DU2PR04MB9130:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e7bc176-213e-45f4-dbb6-08de11865de4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|366016|52116014|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JWOjBVHZTvl2iZ3oKmI48R/hXLHxNjHaxjWnSRzE0VSRbvtImJENdd29MaXi?=
 =?us-ascii?Q?oKjRfLTcGTYBzSwz9gnV34934Hn+vlj6RosI7oFN0FLKt6ePS0zeU0lJxKu0?=
 =?us-ascii?Q?A8thc+MmLBUXg1jE7XewSQHRVVaNBV31bif/7MB94uRaIiWR596CUejWi3LR?=
 =?us-ascii?Q?Edho/JFqSVKWqRtIpyjEw4tB1eWp3PkvIwiBiniVPpDtxqNceb5bm+8az+Cg?=
 =?us-ascii?Q?72mc0Gt3uRbe8SEvHa3iCjh83y91inhOZhJARu2jn27yaF/JZUWaPJajV0Lh?=
 =?us-ascii?Q?tK0r/B7ItOXZSEboNMdDTiRt9JA1AQNroUU98+vXxQrQa+9Lm6xqY4PNTf6F?=
 =?us-ascii?Q?NxmXMbuSNRokZdSfBfSlqvttFjBzLfbQ3sEhulKaKUPh+3ErN7pFYrQRkiWv?=
 =?us-ascii?Q?pjWIMv3n/IzzLG7TE8y5ZXS0jI5a1gjCZyPwZxCYMJHRYJa5jaK8CxbdOp0k?=
 =?us-ascii?Q?bD1+bXgFd6O/tQOUYcv/N5fAIus+pDwAuHP5wpv+MFlqWyDV7M1W3X0ZS04G?=
 =?us-ascii?Q?gfYhIp5+97/edDa3AdhfhxPmnKrwEezw9j/VrAHoLekfEEQ0gXgBNDpuxR6h?=
 =?us-ascii?Q?/C+w5KhTeA34UZQvGE1ljFiyn3sLZPJRq7Jf5HH+TchtJBQ4VWwCp8DLUzpb?=
 =?us-ascii?Q?B3KeFnYdPlnwwTLx9Mgpohi27VovL2U1i0lXwCIApJ4NV/IF7isI8Q5KStpa?=
 =?us-ascii?Q?B6jKPgz7RSZxhcMTRZOG4Z1pNGgsRlXGQOUstevIWw18TNRsAAUSWPqRc48u?=
 =?us-ascii?Q?uKhGhqiX+NBhnye5yuer8xHVd8cCAagmSG1iy9vQ+9tYCA+3WZiNZJuDgAgA?=
 =?us-ascii?Q?USUbkARxEXYqKK+fSTNSXvfGfsw4BOq6YMgHfcwao7U7tFQoCgsfs33iXAVU?=
 =?us-ascii?Q?IugVnqscxTpSuRjn4x0WAiwloTE5+4lIxenKx2G7z9j/Xi4nIn4MwZFhfIwM?=
 =?us-ascii?Q?ZlV9n7Q13WgXsyZj2HlbLDs8Go+wGSrz2SXj5/5JObXxJqdBekq8qrasE5RG?=
 =?us-ascii?Q?J1I10spc7x1GxQ5o68l7UAhp+OK3Q+zEsG7d9h7O15vWA0Htu7aM8WDevIW3?=
 =?us-ascii?Q?5oII+3XL1O4BXQu55hdOuT8ISiXydHRmEWWrkUlQnH6EzIH24LjklHlCRfyT?=
 =?us-ascii?Q?SSjA5b+WXZvg4cv91Vc9tSw8EN6ObsADTD7uZr2pqgqJTcQXl5S7OKjXkSDT?=
 =?us-ascii?Q?kjCkLiuDZ4YVvpz2sxHjq1tn/9oOjdPgwy5m6JseZMKP3Lsx2Lh4KyXfNI7N?=
 =?us-ascii?Q?tm2UbPBbbUbgT0ZBV04OD4RDRJk8gVQ67ePsCAOXI86pbcRIFndGBtX3VxSN?=
 =?us-ascii?Q?SUM/1EwzhZVfSulUNaBT0nxbM4i/EPxODmuDI3q1ddKN20JVPDzvNSJqMlPO?=
 =?us-ascii?Q?HqiaAaNbH+Ay5S8OtOKdSBPvgbYj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(366016)(52116014)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vVIxT1kjgjpWCW9AoD5niUM+KNefbqBpulFnuOLHuQKoJgRHD7UZDUPDFJcn?=
 =?us-ascii?Q?XRcfLY7EvtS4eenmTzY5eotQjatdX9zmhkbXeZwd+n7CKj/cEjbLcT6jI81A?=
 =?us-ascii?Q?hv25tfOvV23qyxPA5uQSYYL7VCn1BiXfSujDv4qrfpoyHg8ZzC0d4MbnJOHr?=
 =?us-ascii?Q?bmlMauiJlkt6DiPwWPTJFqDocbqeyd+at4dhNWrJ/pKaPEgRjd2+tHUebKnk?=
 =?us-ascii?Q?N5/nelV7o29WqpcraK9y8iqWeevQxcvSyZcNXRGATT5jEaJaDmdiAN8+Ia0V?=
 =?us-ascii?Q?RNLl13TeN6Q9QpjjibJ7ZyGAtiI7+kAeeoz+IOURmJD9HqM7KbixU8WRxgoY?=
 =?us-ascii?Q?ntUeW7XZT1UXYPjMkQhLUrX75hwjMV0SWVT7RZSb6oDn/vG+gOh//avr5gxT?=
 =?us-ascii?Q?tcolA3QLISd7DDDNH68u8ZgUIeq4AAfNINaf+cWhzDoV5m6I/9GwrjbmIpNX?=
 =?us-ascii?Q?hV36aF7jEjETy5ij80c2moihb5azL7ZpAf265O8UFukPndCTKN6ijn2nXrRn?=
 =?us-ascii?Q?85978HvA4IsuSsHjNyOrV4/18VKy85wyhlo/LJBPYtfypn2Jha9uGzHYppRZ?=
 =?us-ascii?Q?lnBPVBv5r1Q/Gix4sD5YdVfV1lNwJVjO2C92eirUgUxet3htOusEa3UeuszB?=
 =?us-ascii?Q?M0QRZoReMyH1vVvhbe2IM+8tkqKjhpNGPBbGAKY+ZVLish8wRj1uqtu8rN/Y?=
 =?us-ascii?Q?KNQv9w4VfjWGGT6PM/kZZavnSSWuHhFAOlFiwdW1eKU8qGIrI1AYLm/ocbmE?=
 =?us-ascii?Q?cqbIXuNIlZ3O5f4P9QmmmElDohqoD71900i4S+T0BuYDN/AydeWqSkgUyRnd?=
 =?us-ascii?Q?akdIE6bMN8L1IXUTa8oyZid5XC2vWq6T5gcw4R/XSto+W3upGYIJvKQ8eNxe?=
 =?us-ascii?Q?cJG9zqjKgvFcywaJMj7vCvdJ789ZjAot98xRsZQljDDUZu6EhUxNVtIrphIK?=
 =?us-ascii?Q?skfA2lwiaMh7Lv+sddbo85BIA2s1VVI+RgwTATl10N7+2X+DfiUlPi8hpoLL?=
 =?us-ascii?Q?c/AhjQlNoSE0zqNytErGqKYZcHlDSre1zPFX525VvsC8K35/ukBqbQukp/x+?=
 =?us-ascii?Q?6/UXUh4J3R9qrhVjawsLzyLFSzLl3ca/IZ1hQ2w1M7nH4HXBcfqxFuKIkq1q?=
 =?us-ascii?Q?Gy3T8wU/OAFZA/SaNhOd/klzVXARG2HxISHv92Z+bjWpLqV22Q+GvaguvXJ2?=
 =?us-ascii?Q?4YeH7LmDtR4AxqJH+YPKd0C9Oo3hIH1D3KM4Nm9rvRnYX+LA4tHLFe10dUGX?=
 =?us-ascii?Q?SFdooOGL7HJ2JEeynsLdUZfl++LxCiWB9HZvnhHx5qA2wO/NpNH61lv/mdMF?=
 =?us-ascii?Q?WMnos67WrE4rYzoEhETSpgxE1v4lOoew9eR2EkD9J68xxf33DeFsbAg0juT9?=
 =?us-ascii?Q?1P8RHvkQzKB7fj2AEFOkjGdCuksFNdXzTsk6wFn8ANEc7mfEWf4USmvbaaON?=
 =?us-ascii?Q?fTyaZSmY2cn0EDU3AoLOPms8Ocn87/DOgYQMYCcc+rAsVHoJLS5Q9J76KyLE?=
 =?us-ascii?Q?pS/Mbf5Q6JhmZvpJnOJmgHyfit5w/Cv8nktl2ZXkJHt0tL2ZNiAdSsS6mPTn?=
 =?us-ascii?Q?E2yH0khchQ8wRRS/vQPuKEz4VIwUlXRs+yIq9oEJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e7bc176-213e-45f4-dbb6-08de11865de4
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 16:16:33.6045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VbRgrkdUiVMAnPt0HmmKRG03smQqKyqk+Vplo4cx81IguMFLHuTmuCMRMW/nrn52EO6ds5rlWWbredMIyJZGIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9130

On Wed, Oct 22, 2025 at 10:08:41PM +0800, Peng Fan wrote:
> Hi Laurentiu,
>
> On Fri, Oct 17, 2025 at 04:20:19AM -0700, Laurentiu Mihalcea wrote:
> >From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> >
> >Add documentation for i.MX8ULP's SIM LPAV module.
> >
> >Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> >---
> >+description:
> >+  The i.MX8ULP LPAV subsystem contains a block control module known as
> >+  SIM LPAV, which offers functionalities such as clock gating or reset
> >+  line assertion/de-assertion.
> >+
> >+properties:
> >+  compatible:
> >+    const: fsl,imx8ulp-sim-lpav
>
> This block also contains QoS registers, General purpose registers, HIFI

Qos should go though interconnect interface.

'#interconnect-cells' = <n>;

Frank

> general purpose registers, and others.
>
> I am not sure whether need to add a syscon fallback here. dt maintainer may
> help comment.
>
> Regards,
> Peng

