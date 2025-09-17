Return-Path: <linux-kernel+bounces-821043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E53B8036B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E5FE189EE83
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2532B2FBDFA;
	Wed, 17 Sep 2025 14:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="l0pY/vAM"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010055.outbound.protection.outlook.com [52.101.69.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3904A2F7479;
	Wed, 17 Sep 2025 14:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758120280; cv=fail; b=E8wCOqkpj1h5/apiJzAz+6BsfTYL2dFK1iSctetk5hddtfp4I1vKFDRJ9wt7FCeKS9bve9lS1qHA3b4jSSl4SvQxRLxA4bjKaN0ip5+Y7Nvy5HvEZ+N1WB9pPEsmUQKOVq4H21/b7eIa/J2IUqyTQWR9pHBFPZWro1ypg0aJa5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758120280; c=relaxed/simple;
	bh=hYN9Q2s62fgxHGfUJV8zSo3F+EZDNdKJH/nmCx3iP28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rBDJUly1u3fMG89xydvZJMgyZrijlaSAsfL0H7j1ABpl3DZsbZY9SQzeslcRoWipmU2jfJPpnm1qDUSzPxAJz7fK+mIoeaSoy6w7sieZ1MgPFyb6fSTkOkU0Dc6ljQFz+8SaCyI99Rsb0HW0PD1aXdaXqTOMFWuN3jWfuEORWxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=l0pY/vAM; arc=fail smtp.client-ip=52.101.69.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mI6ZFFmLE4etXFIf3NEeDXjSRNeBUTN6b3QtcCDTigd1WHk9b2uc6kwW0H392ba2iXlDk4rvKdPoTeOmgr2LUE3s+GLtjuIFiHT5oTevd9mjrslu4Q7wFR7BQcumWfxYUCcw0oTI9CtXciK/F35z6QQP38h93rhTcY2YaoXLFj1zRu9hk0bvEN9/rG1ohRTAiJiy99wkLBTKnnFyLbql8FWarSzEA78orXr+Ef74U4daANOQ4zzZThn3uwSc2D864fVMwmkU8xi6mvWz9jqeCMh6NVE42Q75Z7Ra1OjO0PpiGqkVph+WFfdhftSNREAhVsRidOBSOtQP8ZTiVMEc5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zpq/ddmYXKIWjy3959yyawbAs0oGUjNe5Fqu0QYNsjc=;
 b=ud64NcV2YAj6XGEcQDe/u3mi4umWwYqGYSAj5m3CsQI6Ok1Woj7ESi7KQtl/zFquNnCmP2/Vllfv1NwU7zM59eZvjfDHyfQcEH8YSBsFthUyykfy3UKlAO5qY5aSRSTw69JrLJz3C4nI5fU8Ww6B4X7mpNlLlNpPFbIEn10/mIKUs33yQVkoLgimgROJXWlZAOvgsJmFGFgNHNIMuZyMt9HcQReSd1b9JoAIAbsi2NQHALSztiRVzC0AOYzrbp+vExGRtlq/oudgZ/DUxkmTv/eeIsv0j0+VdmoB1Y29GXGiq8XL9NmolURTT0plBropz4BIeTjxSUGYbG70Fi8heA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zpq/ddmYXKIWjy3959yyawbAs0oGUjNe5Fqu0QYNsjc=;
 b=l0pY/vAMNqoqKLL+vAM/LMpzhZe0IK93/0XOZn2SqVTesoSU25jERgsm5NxwcTmcvXoTuz7qwHuCKHT7ZxbQvPcN+3hUArj8gxuzMwJfz3lt9+yT1QIZ2x2aapFU1KsGZkFaERU1BxWudNAov/QeSUAnWKiMn5TwzV2Q6NC3+4aZ4uUw9oj1D8owP6lsHSeu3K4kPARX5FchID6guROsnnPH9cMSWOwiih2cHlFdRunb63oRhxXfO03ZtmQpOQs+85MQXxX8smPgAtd8eyzolrGVFCLFFRZFN+lmD/xs5q2sOVgVXgGFFXs8B/mNADi+VKF+gAPUSnu7DHU9vdbXuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AS8PR04MB9175.eurprd04.prod.outlook.com (2603:10a6:20b:44a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.12; Wed, 17 Sep
 2025 14:44:35 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9137.012; Wed, 17 Sep 2025
 14:44:35 +0000
Date: Wed, 17 Sep 2025 10:44:26 -0400
From: Frank Li <Frank.li@nxp.com>
To: Haibo Chen <haibo.chen@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Michael Walle <michael@walle.cc>, Peng Fan <peng.fan@nxp.com>,
	Marco Felsch <m.felsch@pengutronix.de>, Han Xu <han.xu@nxp.com>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] arm64: dts: correct the flexspi compatible string
 to match with yaml
Message-ID: <aMrJSkVYSH1BO5zf@lizhi-Precision-Tower-5810>
References: <20250917-flexspi-dts-v2-0-7e2a95e3cf4d@nxp.com>
 <20250917-flexspi-dts-v2-1-7e2a95e3cf4d@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917-flexspi-dts-v2-1-7e2a95e3cf4d@nxp.com>
X-ClientProxiedBy: SJ0PR03CA0139.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::24) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AS8PR04MB9175:EE_
X-MS-Office365-Filtering-Correlation-Id: bcbf1eaf-e6c7-41e6-4f51-08ddf5f8b863
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2kNWDNho+bo9eCOZEJd+nIDDTE8Kx7gHz0K5tZ5msy2i4lZMm6wkpYhFfOuC?=
 =?us-ascii?Q?WqxsuUXBB7ee3y9nUpkWKrKnkKhm3JJ1nGlzrcZs3rLTME69nb4H6mtvVTat?=
 =?us-ascii?Q?OWPa6LmJztONa/HDnZ8vZPiR2RXb1rC69iQwaZ/4FOioEPdDK6e8Q0tHn/w+?=
 =?us-ascii?Q?UdwglfZ4jQQi9+/t/dysvy9B2IiYMNNMM6V1buwMUGPmXqd9ADTrRcAil4Bv?=
 =?us-ascii?Q?MQf3i17auk9dARwxTgjL/6ebak+TfFYF7EEogQ1Z+PqpyXAKA8vwtdpEfUAC?=
 =?us-ascii?Q?tnncdvkbe3bd82goMPd2tOnTHgSb1DDLtJ6OChP60VPPOXpFGwMb5/BskGwL?=
 =?us-ascii?Q?nWbymtOLD8j0zG6xjA4NGsSshz/rdveCe/rCMEmTo2rYNR555RAQw/u+DQFm?=
 =?us-ascii?Q?ZZAfDY+1fUMhrulDweZttp9Wrcbu1YMiTU74hqcCD+BI9Gf/yJqnfOFETZ4S?=
 =?us-ascii?Q?+xmPdttV8alyLwR/qJb67nPwcYcrDbYCDPQ7XKjwpGjgMWH6FQpmgdnu3gVq?=
 =?us-ascii?Q?tpbV1Gkn4lObTpX6Ch7ONwQC+KbrKD4pPZO/HOmvK8/93EH8KN9F/NujtB8u?=
 =?us-ascii?Q?Ags+OAlMkGwcLwzYLH5UFUOV4vcO4TPMIGsm7dGWE/fQOC/uMemBl6Fk0Uxs?=
 =?us-ascii?Q?6QKwywiDzkZ435vOFlRnQfbCPHdZdUa4oMRv3v05YoL6SUihTrDa0KOmkzSv?=
 =?us-ascii?Q?XamnIrqAAWcxHPQ5jB2pPSsrMm1dQHLzFLPN+fFh1I9lQMH88LSzcBCDwPmD?=
 =?us-ascii?Q?0NwI8NM9lpBms41Mp0Kydglqm/7fHFczn5dU8tCnoiNlqdVk3Md3b/RpL7tm?=
 =?us-ascii?Q?BhSbSbq46TXduQdop1k3sWUFHOD+20HG5qgZrY9kk0dMRgbUsxDfHbh3NKNO?=
 =?us-ascii?Q?oLDOMVB2IrZ5D24yv9Ej60dIcQnl5dmQ9l/1yt0ttCzuBQHlDl9yKOpL/Mn/?=
 =?us-ascii?Q?/qOWrtZgKNHJT1NqRFHCBmvTg7VYgibUKKJFDra8u1eZAUpwTppqtoM5GNKf?=
 =?us-ascii?Q?8aBPdwdOchwwi8057WS8Z2gtM1DSsa/8h5KSg+R92dJrdmP+a9mlEUwG1vFc?=
 =?us-ascii?Q?gkj7eGflhCoWD87SoKic+3jDU8K4duyOS8Xh+OB3p72s29XxJ5wnsPNL+O0J?=
 =?us-ascii?Q?rgapMQb+MWTiZoFoTv6gjB9ArZWdxU3gjpWZeC2m9DUF2Mjgvt1TgCekdug5?=
 =?us-ascii?Q?w1exx7UKXiV/vLHffrVV9Czm2gkdLzx8HorTYQ+6Urb88AcG1IPrR3KYASuo?=
 =?us-ascii?Q?G+nIf/F4TSfwrOnSitIII0FNryLtQIwXFLpRgF23KpPrpS9xGPtAN5gJPKtb?=
 =?us-ascii?Q?8v4v4mSLrVLe5hWDk4OMYJ+Y9brRBSp0IpGt1tt30/LApzFcU+ymDt5PXVDE?=
 =?us-ascii?Q?qcBMVxHjnJp6Tdx8bufq4bbv9+gMcDmFpTKReOfBtf9k9p2+PRDyXNgRQV8r?=
 =?us-ascii?Q?f/HGmMyCZMH352xZGV+5mbtXR8u0HNoT2iJL15q4+tXWVnqqbFD22g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9jFNB9YhbKayP62IGEI76vxZAN67Q3p1RaitZFzB9HvWogsDXgBuWTiSWbOq?=
 =?us-ascii?Q?qb58upEM4Rl3IZL/jyyvJfBNn+SwJIBvSqsrFOzTqCFpxuZy2h2rEGvdYZ3k?=
 =?us-ascii?Q?DFdtibJN2/9Y344ZCaUOWQvVBlV0hKJjFewzvx3xkW3ECg0t/0J+QJQQ06ix?=
 =?us-ascii?Q?cD5Bx1+YFbXXVPvyzqnQ6vrb2cKsAbIwEAw8jCQDptm/FPxmchME2kwA+SH4?=
 =?us-ascii?Q?4ZizO1te5MHLZMUwYv0tRDTCE2yMUUdTjiFkJjDtbsM54fwCZM6xhuRolqkw?=
 =?us-ascii?Q?BcCxDHt2fzoHe+Xj/xRVHPAdVRMlcSNVhxmTjybL2z7t88MzmfH/6ohU45qO?=
 =?us-ascii?Q?WqyDKbr8sPChMChIA68ffTJF58CR8/i+RDAxLlYuNScR+XQaGbjEbE/l6rMp?=
 =?us-ascii?Q?7dOQXLsUmfOPtg0E5BdGCTMtqAYxX5zs1ESQW/jr66EhziHne4W1oeQOmYNb?=
 =?us-ascii?Q?g71JYTWYbuS7Giclzmwp2PWrbLVhK3ZM/UU80NYGcmTkon8FhWqADLCfHM/T?=
 =?us-ascii?Q?f6jihtNNs3y8TqC0Lk4om6qorapRzC7H/nrkXWVOIWY2qTi+dhqG8jz9jbIx?=
 =?us-ascii?Q?kWnyIZrUqHYB0EbDK5f219/1i4PuIXP8Vdq1CTAWx/dLVX4sW+yz+3lmckRa?=
 =?us-ascii?Q?MQZbQlzgw8azD09NOT7XUaFZgkneOgyLvFFdVj+iw66ja0Pic4BJ2Kd90F28?=
 =?us-ascii?Q?HH2suCSxG1enizAkefOr6bnlGrfDCCKpLPCMlyUn6UOY/gyuPN10afvgBdbC?=
 =?us-ascii?Q?hnere98QSSP+n2GFcHMeIjxDcKuGKPcVx7e7PdWh/tpkIkK8TqNDfH2SqgLa?=
 =?us-ascii?Q?9dBNsKy3kKAw/O1F805PbexvU7iH/TWiJFWOJUxF8q2xanCjp7suUpjGD8hv?=
 =?us-ascii?Q?rx0HXnL56AEpn7GzFRtdugGkJK57quHcWSRlgIpYftx++yOKlrIpwcvlTCd8?=
 =?us-ascii?Q?qMvpPcAg7EQEKifOFLpIy7YVwH3W9KCNauEyWG8j3Nx+lUYSGGT0gkWTKUwG?=
 =?us-ascii?Q?h0Cur30rRRwl9PKBqq1w/80D3UNGLQZU7jb71iQ6rtsuHGwbeN5cAGrRsxet?=
 =?us-ascii?Q?yvAlQHqsv7suejxQUQdSwRisW+MV2B6/jgDkX2+kJm1lg2l12RK2lEyHRfyP?=
 =?us-ascii?Q?klkodCUK9W1g9K84fujoL0ftTWCnv83VTWbWKrUYXqTXoKp7AGWbV7NZPxve?=
 =?us-ascii?Q?EbGFNYTKZyJkA2jxt6QdG6SJbK5qnte+RaVqpff2oxcomrMPFWshquCVBFJ3?=
 =?us-ascii?Q?DvaesU8vXacrXpiLLNGMqQfJnq9x09BfRqMAD5NlRR5eoZE07hCkJ4rp3yZm?=
 =?us-ascii?Q?6aipoPir7TkEeFrSqV66kN987r8EZI7SjWuwfA49KT+lLKvi21E7XY4QfqN4?=
 =?us-ascii?Q?tsmkiN/24noPjSAXn7ySFLg38oHq2W4Ix/9LPim4kcks4TKOrXAJhVjiyhml?=
 =?us-ascii?Q?SKmhutqn7kwn4nfhsoJrGJi9nmF7J9W4XNMUycaTW1/V6owLXApT1OycZxwx?=
 =?us-ascii?Q?9FGwFN50i6jYkF7n7+RDQ4qof2o8W0wjVI6JPsxhLL3wiPFcpKWHHPepR71p?=
 =?us-ascii?Q?p1+YDOatMFOFD2ENJUbXnj9mEcjqZBXxCM0Vmusw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcbf1eaf-e6c7-41e6-4f51-08ddf5f8b863
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 14:44:35.1612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eceGPHhF6bBAtOm+TFH9KfuGNHzOxpJUw3JKXZmprD0T3tfGgChacSc2+VO/2ySVd6Npg1I/575QThde4JPs0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9175

On Wed, Sep 17, 2025 at 04:42:27PM +0800, Haibo Chen wrote:
> According to Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml,
> imx93/imx95 should use it's own compatible string and fallback
> compatible with imx8mm.
>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  arch/arm64/boot/dts/freescale/imx91_93_common.dtsi | 2 +-
>  arch/arm64/boot/dts/freescale/imx95.dtsi           | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx91_93_common.dtsi b/arch/arm64/boot/dts/freescale/imx91_93_common.dtsi
> index 52da571f26c4e8a2703e4476b5541fa7aca52f10..7958cef353766a430df5e626ff2403dc05a974b1 100644
> --- a/arch/arm64/boot/dts/freescale/imx91_93_common.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx91_93_common.dtsi
> @@ -706,7 +706,7 @@ flexcan2: can@425b0000 {
>  			};
>
>  			flexspi1: spi@425e0000 {
> -				compatible = "nxp,imx8mm-fspi";
> +				compatible = "nxp,imx93-fspi", "nxp,imx8mm-fspi";
>  				reg = <0x425e0000 0x10000>, <0x28000000 0x10000000>;
>  				reg-names = "fspi_base", "fspi_mmap";
>  				#address-cells = <1>;
> diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
> index 1292677cbe4eb8c5f3ec2874a17ad6efd0111192..a0ff7002be9fa0529ba5712df4c056c56f0e3242 100644
> --- a/arch/arm64/boot/dts/freescale/imx95.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
> @@ -945,7 +945,7 @@ flexcan3: can@42600000 {
>  			};
>
>  			flexspi1: spi@425e0000 {
> -				compatible = "nxp,imx8mm-fspi";
> +				compatible = "nxp,imx95-fspi", "nxp,imx8mm-fspi";
>  				reg = <0x425e0000 0x10000>, <0x28000000 0x8000000>;
>  				reg-names = "fspi_base", "fspi_mmap";
>  				#address-cells = <1>;
>
> --
> 2.34.1
>

