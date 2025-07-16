Return-Path: <linux-kernel+bounces-732919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 854FFB06DB0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 08:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDC481C21A80
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 06:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5EB2E8DEE;
	Wed, 16 Jul 2025 06:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LPznFnYH"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013037.outbound.protection.outlook.com [40.107.162.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92B58634A;
	Wed, 16 Jul 2025 06:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752646300; cv=fail; b=F6+mWjU9MA9G1sKF8rzqWFQ6uN+JWLPNKJEZQnznMpv9jejwIVDGVXA5J2A53mg72Vy5BekghqeuXCezTh7bOd7tPA9TcjF5YKcVIwNomdYPTfzf+xRd7PLOL8fIZqTdFllgP7bBLws7xok8CBMCWvPpvA2Dy78IAQPBQcFiDEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752646300; c=relaxed/simple;
	bh=faDR3ovRSeAlN3RoQityFgeEA7CzNxk/3lu9gT5B+Wg=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=j95dX2Q5hyIU7ah74sKhGox9HtqBdjsmlK/x+AvUHtxl43C4xKuHivwQTwUAo7Mz010mWGbz+RAIHGNiWs8/3x4ZbLKUHliikRkrt58zYMpoH1yftQVt8SooR0VrwXUaH4zpjDkGur/MqGrnTsUG0mKI4DgK2lyZltApzSlMNeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LPznFnYH; arc=fail smtp.client-ip=40.107.162.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X81Gfjt3JtNEVWB7gA8sQ/8zAqlsXCogOQRNgnVd1qM4vhmk18Cc6DgwEBOkrwCmfFgyjkCLjySsi2cNfYDdOXH8h0WevnLf50wE53kkFAoQiGDnkmSUZrN16dX6DD0H2hfZLuvdCRX1/YnihaaBDlWiJzxLYsg9UEKyKrLX8xWsjhds6x5RfB/2lH7/2JD8Sv7AzNzJ1AclDcgfI7OfwNetCeUrzJkUQThO7VmuI+TUe7Uz5ToDiTl5y851OBbfafspjn7TMWXemSqCuOnGJsi16hZOQXhpycX6dppjuFd1CAoTqNUgW5U6TtZNRueBevwf+eEIFHjeSYIgOxUELA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=to5RvcyFwR/MGzI1XSZQq01guvLpNy3Rz0ToSTeBf4Q=;
 b=DC5iMPru6vockwV4F3aSwGAB32HCyMV9NT18eOP/ahDLSY9Vt5snZVRgLPTniIq/IjmuctVRFFnTiCTEw5B8ZdNtdhTxiJ4eRy7R+kT4gQ2cPoB93s80fe6WhOlklT3PJryHmcvFdVSO7rzdb9zRrTWTEJI+UEi09y3+WuFqsA36WkhW8SWjmxVpikjaKWiIKVJv2WFALRcH4qnEAJK0++2Dpe3s6h3gI+rm6hpokUpppTha0WbEmT0aRsu0WjgzaTZLmHxnH5r6EiDuvVDiFCsw2NCMAVq0kfxPm+DFACRRi3O3/NidZzRV3g2sSadMpKxIdN3nfHjsWKIbdJAvjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=to5RvcyFwR/MGzI1XSZQq01guvLpNy3Rz0ToSTeBf4Q=;
 b=LPznFnYH4CUD7hqqF989FB7AVoEQr8VSpto705LW0tdXHgWTVqdGQlfzze/OHLXMWaxVY2JFUMHDMOe3d/J+MykDNIALTSpo4WsQvkMD45VwYDnMNXmFW5Ilru0KikZ0yjGOgHSG0xPATTON0UScV2qq6V+TCcXaAkwcrSmYSJqBo/Jc99ZXTCb+AWgzGaZuAZgDuq3/eF7d4uSr7A38UPKqKKPCuxE5MbnfCKooHftt98uOrgUMoimPp5jy4AmM2xCCd+5QQ9Z+ZszQvh+OsyyiEQ2q9XkLmX5pxqDsOuBhRbZIE0mQEPlv6/EM7eriGaxorGg+H6wPioK2jRX5EQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by VI0PR04MB10102.eurprd04.prod.outlook.com (2603:10a6:800:249::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Wed, 16 Jul
 2025 06:11:35 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891%5]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 06:11:35 +0000
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	shengjiu.wang@gmail.com
Subject: [PATCH 0/3] arm64: dts: imx8m: support more sample rates
Date: Wed, 16 Jul 2025 14:11:11 +0800
Message-Id: <20250716061114.2405272-1-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0031.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::18) To AM0PR04MB7044.eurprd04.prod.outlook.com
 (2603:10a6:208:191::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB7044:EE_|VI0PR04MB10102:EE_
X-MS-Office365-Filtering-Correlation-Id: 30e2fe95-7035-4d4b-24fb-08ddc42f9dc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|52116014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Baa1rkPse2tBF+VOBWOoTYXbRrfxSDJ5wrR1jUZsiP4EGwh/Bxz2N6iHq25G?=
 =?us-ascii?Q?BVwRwoiSPby3LxppjlA5pIL8aTxH1ADx8ErPxr0HqXHEG6XqrdvTvicTIJLh?=
 =?us-ascii?Q?i3WP7k8oSXd3Y6KHeYH2VxsjK7DB5y0JSk50IhQoy1x79iosIFgAE45qc9lV?=
 =?us-ascii?Q?LmvqJeYKgVx8jmD0scu+GgDA99LItEJuNlU3qMeWhLM6fAxKcDcP1SvsoJ0V?=
 =?us-ascii?Q?k/kIiLeZ6893rA1uxxb10xU81PBlZhWUHsbby+LNf1P1NyOc/N4MBdjRxw4/?=
 =?us-ascii?Q?WrsVob8MJtnVH2ZeEflLyZc5D5AIBPcaLDKomXJR42d4VCGdrfGju89bSIOI?=
 =?us-ascii?Q?/pS2Wz7lZIvBMmBe5yJYTYk+WSJ6NuepmoYdEUqxTmZZetLANxMhWYYLLcm5?=
 =?us-ascii?Q?Sq9S07aYsaYWhZtccSZqz1bdQTiSDMjiRtgvL7g9jk96U6IKgdN+NcR0X1+U?=
 =?us-ascii?Q?3uiqlIkx81rZb3NqmRahjCLHoO+EFml2BCf4jW4v4wqsOD5ggrpPTQQqRrj3?=
 =?us-ascii?Q?HdEOxMXLI7xAetkI5TCX5EjS10zXY8oO6Yb5K6yAOQW5DsSHAuAZh9ccYWK4?=
 =?us-ascii?Q?RFrGDymuFuGR8Gbf8eTfcTkrq7lEliDB7iWKDCy6tfVCcxDx9OU3FKwNiIlI?=
 =?us-ascii?Q?YOKfRhS69Z4crTo1G3FCRu71RFY7uCK4oxKRIiCB2zKArF14jx57aax2n5Sk?=
 =?us-ascii?Q?0hLEUGvBbr8KBTcvQ3LHOqWLNEHigu/YF8vLd75ds5NgM9S8By7UIG1Yw/1e?=
 =?us-ascii?Q?09E4xSil8JymGGTuyJtoiLKfeNSSgptvOXcPynE/682roFtVin0o2tItGNA9?=
 =?us-ascii?Q?4NvOgZN6lVTUGtbVMlrK/g9V57qy/AKGFdg6GHvU44SdO+LiEUujRK/VKcA1?=
 =?us-ascii?Q?n/eD2f1sXU8FU6zI0MT9yvEoKRtn5APfjAD23yOCUmxr4HPrmyVHzaP18EjT?=
 =?us-ascii?Q?4/L+ww1dxzuv/8Ye/ZHNDwSZXYCvwX0xO/7Z/RsJ/XtTtir/lbdc/kfKG+EE?=
 =?us-ascii?Q?vMvr07/VE9T6Xx4AjjEYjnTfbqitV1Fk8gCTDRdQLEwJsKhrm1rQlPfiZ8gY?=
 =?us-ascii?Q?ZSZHUvNQHamBulBf3IG6svaok5zpR3WikB2w1YWQNybhnwjPNsdXpeapMtcz?=
 =?us-ascii?Q?j90+Jmk5b5MV7tXmi+3MMNCbI24erPOnhVzuWKborX1bk655fbRcAjso5Prg?=
 =?us-ascii?Q?7J1FgK3H3Y1G3XmaR3H++d1u6hiU+nQhngqrYLC98V9YnWIEhaq5+F26bOfs?=
 =?us-ascii?Q?yKPlY6X+prrdGKPI1eNQcFW+O0rjgmd2oiZ0W7wNAEdnYIdqFIcYgFsysVg9?=
 =?us-ascii?Q?30GVLbJ5DME5DciQ3SQGLFbLHXL6Awz4rT/RUemZ8QRgl8q99ZA11GSYNmVP?=
 =?us-ascii?Q?VBjltvWMEyoVBqU4EwM6diTOEH70g+ABSCXYckbpzyws3pTv5C6cpGwLhiA9?=
 =?us-ascii?Q?/KWgDujopR76DdfMhezgxGP0KWR2usm9RaYSLh61Z5M22svh/8eTi1YOZ63w?=
 =?us-ascii?Q?34lgn+oZIg5COdA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(52116014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JcxVnWCVYPgGXkL7KSfg41K+5kqob3fC6fkyJUYInGj9ynoLGXy/17K0lSEU?=
 =?us-ascii?Q?8PmC/mRBJDQh4YUqbxunMJfI3Q9Xlcdn5SZTCgu0Yhh1jM8uSXGeYO2HQKWr?=
 =?us-ascii?Q?J7SJo6Z4T9xsfNHPAfCnKYv9tLqCI/deaMICkXCLtbh8CmWBXoYy6g8SQZWT?=
 =?us-ascii?Q?+4JI97FRXyY4XJ5gGRovS0GhNRUFBZV+/dYAAUKyov0G9KQRjEnd1IY0TAS9?=
 =?us-ascii?Q?ueTUP5B133cD5QwEu+BzpN8/D8vLvYZLkNh7+D2KLznBvWR4Ruo/C1Q9Vozx?=
 =?us-ascii?Q?qEYJaDykY9nasjK0+ZqDVljWw900otJYb02/PKuEtpPowmBGmIRA/bUHBx2Q?=
 =?us-ascii?Q?YhmVx7uF8v1kw+9G7DwMkIUk1ClsvJwygdSedZEkA0alnVGugUm2Zs3Djjmo?=
 =?us-ascii?Q?/FmsORmLi97nyPaEFFoabYZe1g8Ye94SVapCyjUbRJvQOnjCd3cNuJjCb9O2?=
 =?us-ascii?Q?MUMq1pzIv44ToyGMQtRnf2Wv31GWoQWwUmXI4SRd9MBqnxt4IVebmze66JcB?=
 =?us-ascii?Q?W0WoJbkCPww/9mPj2SeR5FP678kslTiUi54kdpy4MQsuxT9mJGHTN6lCPMqR?=
 =?us-ascii?Q?ETHYb3r4yRcd/e00VvQfl6cJMSPteBxsdQX5NsFZNHge3F8I0f1sYwjTHFZ7?=
 =?us-ascii?Q?q/0SvmJL9qy/wyac4bdkCH+VwGrgkgvmF56/vuG6yrV+TzgLFcpczX7Q3pmm?=
 =?us-ascii?Q?+TN5RD1yRd2Nsqwa8i2wBXIW/ckMUwD3CB9yQXMgSOhVx3CWEGYWi9zXTO2o?=
 =?us-ascii?Q?lpqr0JSrIeSvK3M3FOXd6KAEJ2WBsTv0jAnfWsKi8vZRUa0cCdTNE0hMC9OA?=
 =?us-ascii?Q?NFdINKSFR8SG22jrsXYMGAwxPFW60ogXfUlQD/EUEzUXUENDA5QW4eM08UtB?=
 =?us-ascii?Q?VRk0MmySc7kGCs9sKDEMDZ7D7dMvJpmIZPYA4KYm7crI6Gi2XjbuoSlOKC+0?=
 =?us-ascii?Q?yvoz4wCnykl+aJYAZnjGgXyyfCFv87WhJrPTRoZlRyLD6gYIUD8R97DL306p?=
 =?us-ascii?Q?pEXWJsociXTJAyIzGsLC9nA+LLD+mgTDOZ27fYTzaiW1zkCFZ3u/VWHJXNgq?=
 =?us-ascii?Q?t1O5vqoWvG+Fm60Ua51tpoastK8i/qJAbIda5Zu5b+10UKP2BA72NeF61V47?=
 =?us-ascii?Q?UOyNnBQ+W0pUYsYv5ATM6pJdiJ5b0e03IvYoQK97LsyDofnDLTdDfvNSe0HM?=
 =?us-ascii?Q?tvBtXdq/3BY3/TR9LmMzD/CvMeYeQH4WPnv1WIYr5IMd2JsZ3NSRF6rJ2Wmv?=
 =?us-ascii?Q?hwA8vmI3VOBMu60dJjMbYeVXMBsBhNrUGgexxCy3Ifyfo7zEsPX94NEDwoyq?=
 =?us-ascii?Q?qwmSQ8zqOQh0PYsGoMtx3H/+ZzG6IborqEgmUOe+d6KHigA5kYGErwuCHL0l?=
 =?us-ascii?Q?NTKlg8orBkuNo9oBrZyGyVAptWAUuu7Eqv50Vgmls44vRcha/cA/OzK8RJmo?=
 =?us-ascii?Q?PXVKKVi51TWNuWPHk8Ss3V+S5Sy5mpIRQ2mYfLLK/VOVk1swywqlMXQ84IJu?=
 =?us-ascii?Q?DtRQIb65VExqyq7tpN/bTDaRumkGp7tpQ13p0STdYBysGHBqOs81ycrbIO8G?=
 =?us-ascii?Q?QLBfT3qoJvQnwhk+CpG2gTTknljO1hFM4enY7X9h?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30e2fe95-7035-4d4b-24fb-08ddc42f9dc6
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 06:11:34.9172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: op12LNp6o44ia1rdP/+87q/9vn6p+KE60ROjKfr1LbaYoer24DWCRvU/+MY3WaC/YXy3AafwEOEst0AtgDpK8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10102

The wm8524 codec is connected to the SAI interface. There are two audio
plls on i.MX8MQ, i.MX8MM, i.MX8MN, one pll can be the clock source of
44kHz series rates, another pll can be clock source of 48kHz series rates.

Shengjiu Wang (3):
  arm64: dts: imx8mm-evk: support more sample rates for wm8524 card
  arm64: dts: imx8mq-evk: support more sample rates for wm8524 card
  arm64: dts: imx8mn-evk: support more sample rates for wm8524 card

 arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi | 17 +++++++++++++----
 arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi |  5 +++++
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts  |  8 +++++++-
 3 files changed, 25 insertions(+), 5 deletions(-)

-- 
2.34.1


