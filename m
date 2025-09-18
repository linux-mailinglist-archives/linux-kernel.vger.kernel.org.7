Return-Path: <linux-kernel+bounces-822308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F6DB83815
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A07B2A025E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 08:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965D62F1FFA;
	Thu, 18 Sep 2025 08:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="YnJrbWI3"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013031.outbound.protection.outlook.com [52.101.83.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5B123D7C2;
	Thu, 18 Sep 2025 08:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758183756; cv=fail; b=AmhXns8CKoNLecawr4yl8Bki/IM28VpKPpF5wVoJQCVBwedG+VUEIyyskQ+OYZrptVaDRHlfUKnLWL+ar2E4xEAr2b94xLDd6YAiaHirNTadGdgw3jHRIx6fIvPpvzdtLZFRAShCOi69MAXoX57/sPI3tjnO8q8yVisRQAzCAPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758183756; c=relaxed/simple;
	bh=ONbBm+c364sghvjXPv5HdjIj2oKRHD+R+kaHoOus8I4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DpMVMt6awFNZDfO+DZyLlo5Y0RuJMc840ojYngG6vBc1v75DWtqpoFmRAm0hO4rGkPzbPWVKiyOd5zJdtUREx1xFk3Z0jWnELEAPDgvLJtaKuq1KhptXQ7qgZ38MBdznYvokF8rSJ68Hg68f1U87vBm9qQQENTkcKNQIaA10ia4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=YnJrbWI3; arc=fail smtp.client-ip=52.101.83.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wRMfd0sJjTfx/iYEBUAZt1DVPTpFu+A/Ce+DFWppmrDcQD7V6SpR1eCPe1YI3SFdPaToah6Y2DK+WGzAdskaJON4liyG/4B2fYvUQ+mMD0IaCa7CcuV1dRRLEQIR9Z9lkOpqsVPz1YkinoDlzzoyEuVsTTGsxZTFiy5+22uQ8qcLVCp7lcOQca+4GigpqhQe0HPqHqJ6XKeB2B6eqgSbg7QNVAVH+9fyvf9GhcXn7hXhLpkbNbwb6Sh3Xtk51djholdq8wgZTBYfGjzMxqAlnBbrrD25wMECtyhxeraUeqcWJbicQMNc8X2ZGAMZMBxtt12B/xmdy154uhElahey5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ONbBm+c364sghvjXPv5HdjIj2oKRHD+R+kaHoOus8I4=;
 b=apQwDZaSmEs1Et/+guK+1q3udUmjbcV84TLumVpdmJxMCMiqo/sbdujEVNsbsVixjhuj/yTU+L8JsLhJ6FFvvqkHp86p4iu7Tjo01ne/qsXcwtK8oJkEXU9l8HPzVsy+aHZEM/g07tCpj3t24BG+MPDjyoBsPymM9YDAkcPkAjL/MY2siUj9JuWCKoXIb4uWKCI7/gdOqew7L5HFU+4GM9Im5QXPFNGIbB4mFr0+tV2GWQ7qXi0hUzMWCL2U7c/qZ6LHrsNL5TFDvcrKuU8xQ3JP8wbFGwc6LfwNmdSWmidyYbfVmHD+YM2l6FDOuXsjmzHsUXzrHwDQMXLxdngAzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ONbBm+c364sghvjXPv5HdjIj2oKRHD+R+kaHoOus8I4=;
 b=YnJrbWI3oXC5nsRMV0fOWTBF9p1BpJysdauLoC09RLyL9of9PCsnsV44K6dhr+OfWmuIt49rv+KfbajBoZVmgpOlwYHY+GlL2nY2Rdqlvpjh46yTqP3XTA3xl/fQ9owMKB9e1DcDqyXrpgfeUqCv90ppkADVGk8icH2V4EhrwPjwVHCm+TDPnuQfenAPdHm+q2Ia72u9UUsCPZaj+HMEGsTPde5s8W5wMahIcR6dUzV+71akN98cWITdhAZBiWkeV9S3TV1qD1KT9VL/o4j8WjFVtE+aOhtovaAz4U1bbfGckvQ3Sc0vzBZK8sH3TWEFhjKtcvi2IZps+ITjLFs8QQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB7869.eurprd04.prod.outlook.com (2603:10a6:102:c4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Thu, 18 Sep
 2025 08:22:29 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 08:22:29 +0000
Date: Thu, 18 Sep 2025 17:34:02 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tim Harvey <tharvey@gateworks.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] arm64: dts: imx8m{m,n,p}-venice: disable unused clk
 output for TI PHY
Message-ID: <20250918093402.GA9196@nxa18884-linux.ap.freescale.net>
References: <20250916153216.1042625-1-tharvey@gateworks.com>
 <20250916153216.1042625-3-tharvey@gateworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916153216.1042625-3-tharvey@gateworks.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR01CA0007.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::11) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA4PR04MB7869:EE_
X-MS-Office365-Filtering-Correlation-Id: 49d63394-143c-4d52-c749-08ddf68c818a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|19092799006|7416014|52116014|376014|1800799024|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?l3ilk0ft0Vr3C10Mg0k2+eRh+P99z8O7IhQm8TP2REAJKPEZeK1XOl7Qvgjj?=
 =?us-ascii?Q?LM9U/iEtHyB9e/m2gF41RKjhxy+FFYtGj537FHhS7gTc5bQSORt2IwW02wmb?=
 =?us-ascii?Q?UkHeZO+KQwrm7Z+JtK2ZoLWdWxMQAcE8y1R7qVQ6nZBmXHHvLu4Ug6lwUPH0?=
 =?us-ascii?Q?ze7R7a/LSUEqd32fQ6m1G6ykMbXK2iH9j0NykkFGbE8X7MStBiBZeiREY05n?=
 =?us-ascii?Q?mX8xVVdvjhtm8Xm+xeHjqS7iWoEGxZKifTlS0YAXa8sGUKor4POgFn8SgOEk?=
 =?us-ascii?Q?l5DO2JWjqzhlBnqun2fBKFrWcU9QiF5SOOTu4psku4W4/pIY17pv3kjrur46?=
 =?us-ascii?Q?V+x/NT4fkSBLDkZkkmvi/mbu1wwldWBSYX2tlbCm+EzCGAIzt8qJ9I2AQnQA?=
 =?us-ascii?Q?9w5boPk53LDQtLwOGAWsDxpH6hmuEnkbtkQo0P/zs8jql8oGlOT1b65Qk7ZB?=
 =?us-ascii?Q?rcoyB05P8L9RdShOzTIDrQgiTMcO4ZRhlStXY5g3c138cBtmxIidEXGL1AfK?=
 =?us-ascii?Q?etbqGZVXR+6NqnHfagG8UHxdkeG4BbBusAoM81iCeCDmhAVNNSXjFuEtF+2o?=
 =?us-ascii?Q?1/xsXy9Z6bDWVTl7/BTPAR+jgabnDZMWLdS8K/MFHy6tSZNrWiEu66a8Zjt0?=
 =?us-ascii?Q?C7ESvekg7wMwFFm9R8Vrv2So8zNn6d4Z8XqWkMv1ihwpZ/sM6qqN4L72DDmO?=
 =?us-ascii?Q?Tg6whevxbubK1+G7Jd4NC/q6tWoMtVV1D0fM49Ioc8xlcamAkOunVHGExGzm?=
 =?us-ascii?Q?Fii9qX1sQDSPt5ce1YXXMcV40OH5dTV1uxLxqa7LF56vBXVN3tQiFmy8YFpL?=
 =?us-ascii?Q?g8jrli3TAwQRJ1aLUeXSFvJgq9X4ml41Y2uFMNN9/w0/qNVtMLXx9qwv+gf7?=
 =?us-ascii?Q?PlPwL0To3JEbH/9blXyy0L4biOqXMshIf/3B1uz13fU1cz98BA3P98mRC8t5?=
 =?us-ascii?Q?l+vfsQvI+k1e0mdSMJto4GnV1NmHZFRWSj0XHr/Av0Gjx2T0sp+jNpl8GUqr?=
 =?us-ascii?Q?DhokweH71IQ7u80wnXR3NFFrhUURBJfKC8SC5V0U8DWw+KHrCJxr7HkbX+1v?=
 =?us-ascii?Q?wKxpPijAfRyiOFNBz4z/VZkDvRkIeepXlDMTvxe9KkKJlTJ/2slyjWYVoaJX?=
 =?us-ascii?Q?DSHbt4m5GBE19vl28Qohk2KFJWHW5UWmnUOIYQRhI2r14fn+pkC2AYfobfQg?=
 =?us-ascii?Q?qeQSGHRn6YVt+H2evnZStVNRAQvyqqgmQALifniCSwJwYNidB1YSx467Qvio?=
 =?us-ascii?Q?FV4p5M7eKNY6Pb46WL1k51MJt3WITjMFEHCE4QfkL0gLeF9sJ9e2TOAiiL+b?=
 =?us-ascii?Q?ocxKVvEJA5QdkRKoy078iSn99mpZCWQZJDLmsg0ZuIaDFw4xYXNM+LXl3zhQ?=
 =?us-ascii?Q?sVGpxWZZeKS+MpDfU+jr9BOqYVTmj/3ZrxAFozoQp8OeUbgX38wi8U1geVGF?=
 =?us-ascii?Q?Ib20zf+PlkwCkaXMePYY9Bvs45kaJ3h2e4Yo6A8KBgXmCURKzCsN3A=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?3h2EgJBsYJ/vZnMfPJD2bWkOWAYk34huolyewLQS7T3sU+7zgqTZrRcVzMez?=
 =?us-ascii?Q?gPx4eYpHyKJP9WVB02hqaj2e5rXuCea5ipn8va0W+tY8iXqhktQq7jegRzfQ?=
 =?us-ascii?Q?Hw4ww3bTs/5bqFCSv39v4cZVX1RSkRpauc+MiQgWxNWj2v4dMZ+bLvgyPSGZ?=
 =?us-ascii?Q?WJsjNR4vsub4QF7hEkq7M4BwQDe6wtv/pmR5MtYIbdBsHQ8YLodm43t5RsVB?=
 =?us-ascii?Q?4jzUTW2rurOA7jJpIWS+JpTcpQtiJf+NlQs4GoLW0nWJKtZyc5B2UAwbKZOd?=
 =?us-ascii?Q?aie8EODwRCe7rgMnMBo4cnBrD7FjWxH2wY1xCvRDrDqFc1j+NpfObaU6scjL?=
 =?us-ascii?Q?t7uubr/vpillSCJsewdcwlb7Rgc+cQIfYRwhISKKHAMKEnexWLkntongXbkd?=
 =?us-ascii?Q?UUfgTzMpeIQ30r0PUR491yPvuYZBGls3rW4ZfQk9GrlcSlj3LtRFhQblNad4?=
 =?us-ascii?Q?K6Vi71PxSeZo4ywzMKYveQU/4ZfU91nJxTTjAl0sNqEJ54fEos7Szf+mpkCG?=
 =?us-ascii?Q?QJPDJp8hUi3Smv2WJhRN6TqqjaQdFzNd8gIqVtOVpgqwEhsduV8AFZ0/rm61?=
 =?us-ascii?Q?XkbGf+fGdxCc9kul7MiWIJitj9INRldF8jBJsghUqT41zQYIe7zvA7lynOXX?=
 =?us-ascii?Q?oDYSA8+LMq7c7JU9W4GEglL4x1bSFOZ2KlV2tVTKcGUA76DKAci/kvbqwgGx?=
 =?us-ascii?Q?01fHndjJrTA+Zjp3bzQnBhfnForOE2tJZ3VnUlvM0gR81SV8C1yUb5WWgw6v?=
 =?us-ascii?Q?BeEX9iCbYl2fQ7TgHQ0yJLvm9UGXa0X6mujRPuOBNG69ODy4qqYl185e7rJF?=
 =?us-ascii?Q?GthQpL3eql7/1izTw1q6yPPXgesN3JgoFxphsUNX8h+fDelhGHt9oqiqvDUU?=
 =?us-ascii?Q?EEQKrM7oUrsyQSkyI29S/shUlBEtTG42B7FM6KPlkRk8rZLnHdrkGVVU/hZC?=
 =?us-ascii?Q?aHD3Ll/nG9xkjYyuoCNiLWfGPDWb7tpfNDp8qlWjt8onxKEFiDKz8l67XHbu?=
 =?us-ascii?Q?6cKonrlUi4ftOHck8ZM2D3WKWJyXA0MokLs6zV2dbfutRHhjw2zvBV1IIqyR?=
 =?us-ascii?Q?li4HdFcnInlhziMheMUvrheKCCMhN/QmgWgz5dkPOmH7zUhk4RGg+vcaOtsr?=
 =?us-ascii?Q?2NgW92mp1KWwLIU5EAyjimU63ufco+GDpbRTyxnjJ55NpGqyPVR3kXeUk2cz?=
 =?us-ascii?Q?IAnhzaIfDaZmcCt00gUumwWGmn+V86lazJKnBcTH2XNkAEY90RRyIjHt4Rfq?=
 =?us-ascii?Q?ShzESacxiU0TH9JGJ3/ggbVtkZ0hjEEovBtM2SoW9aIm8D6fBlqD7GQ63ojR?=
 =?us-ascii?Q?+yAx67r/1GFNPdm06n9V6TLZLLAA0xYPZ/uaVLsGh7W5Mkq32LfNxkP2rlBZ?=
 =?us-ascii?Q?oWnEckUhAKzhsJU5oBxIHCCKCL/WoUejzLtUnRZAO39H3x0OVdBscFevn4/B?=
 =?us-ascii?Q?UnGLAr3VwFqKhDeDh6FBXHDjSC8s4fgHDuM1BTy1nC/8vwMBd3hmFkEr9VDp?=
 =?us-ascii?Q?UDGalfyU2HEV4DRg5lB2iEx7IWCqn1yzwLsY0YFaJR/u4DE2ycN+ucxSSxMq?=
 =?us-ascii?Q?rUtpApMzEfptF9AtxxdEXktWuPgkscViNdzHCsqg?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49d63394-143c-4d52-c749-08ddf68c818a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 08:22:29.2934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LAkslmBUDub1mZKM/HDaMWB/nwY5HA5ysqwaTly66ApEaZ0hpmtt0clg0B+uhZgL2YIHejtqyur2OT1fvwtVfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7869

On Tue, Sep 16, 2025 at 08:32:11AM -0700, Tim Harvey wrote:
>Disable the unused refclk output for the TI DP83867 PHY used on
>Gateworks Venice boards.
>
>Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

