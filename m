Return-Path: <linux-kernel+bounces-833597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2D2BA261F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 06:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA3417B817E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 04:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624E826CE37;
	Fri, 26 Sep 2025 04:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="uS65ja+S"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011032.outbound.protection.outlook.com [52.101.65.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D60F149E17;
	Fri, 26 Sep 2025 04:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758860568; cv=fail; b=L69O84HXYh65OhFUAnY1nsZrePN/78alL1ZcdYY5vpRaAZpbr7uYnlmFCwrOIzC2kMR4PXTWWJrItGR1UQhoGt0Qz3leFOrS3LgE/SHfd6Pydyqm6+f3rPQbnjleDDa7BbCohsR7owpnRqjONY7Rz1qpl7Mncm1f/Gl2O+khdD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758860568; c=relaxed/simple;
	bh=3YF7z8tHgFxJaD/GCi2peNt0onbSQJsjLvqCEK+YftM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Wrk8qCCoKlaDW6jdPJu8KPLLJOID15tMg+lAjbefwoO8l366IFxk4vdKvSB4L7MLlxI8DLABTG1BG1x4D8d7B14fSU+zdlkbyrEXQXViOcwDKrZRPKL7R8q+XR4BKo57Zr/2L0p4aAPBF6WYUsNUFddBC9Bpxi+UTtN2NC+zCTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=uS65ja+S; arc=fail smtp.client-ip=52.101.65.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m/K+xz2c5Q1dZRPe0JQrh10ZwWBHWE/q38eKePozelnNtcexu9d+yWf6hSCLEwALZ1siihFEISyWvDsfM1QSLQ/VgPpBZ9PY+lqQbezDawaunzN0ihAH3SRv9tbgylFo7RREXXrfP5F87Td3uVQIQmDTHXCF0b1AipHPsSzeCNSDyTj/wxVc9wO4Z9InpiYg83keFK5USuo6KE94yxUNhmIelVrXixnW5e7fX+Pr9AqTUtqSUlflweCuMx67qqbROb0QiFktfC+Won/2qapvQEBUNCIIX6LVr6bUIOj9lImYIY5b6rAK0gM7VwB+IiKC2gMXA/llzDvXzcTjmykWcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Cbn63gOwlXWgP7oGIFmdOYGLkSFddkf+C78s8kL/XM=;
 b=qljcydQqH5j37GK4CnDiXS9Tl15Apli3/LPxt7B2vScOz9kfZK+uN0c4Wq//KfEgbXnjfl0MJZlVq8+cD8It3vO6sHfq4twcVY19PpkgcL9Jpy2Z/++W5TmZzq8Wc+o1s9OofvRDuHRhEYtlbAFxwgziJG2I7iJqeZUDew0iQle+bhslL8CVYQCO4qTHHNmeulawDoS7EP2vB8/o402/nXabOuX+oCRfJX1tCVFZ2H/ItVR1iPTupU41KW7tAUnBMUkdKx3nggItMiFSrkb1I0qMmN/2/3Sr3l+Hbz1N7DJoXqh/YXN1zbPA+fgcaRlEfaANddafZjFkOgzMva4jFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Cbn63gOwlXWgP7oGIFmdOYGLkSFddkf+C78s8kL/XM=;
 b=uS65ja+SyCCO71i2bmXrmYsLaVi99O+LOzVA5xDezY56LwSFKJMfntU0ZkHa5tx6iQooroWSwEKFwYO0oJgnnxwaeGVqeMgdleisxU5GYgwSmE702hhi5CHsWWD/I1yXEDi06QYsHnNBGtOEwD3D/ZbOpNeqvIRyMPgP7N8v5MBWj45HAHhbBz1dOb0fJciJNJjcjGYNy400gc1LuG6x+0bWIfMVUN4uk1Se/34vhUU5G1+yrtHUNxId1BpcZcyZczYN889LF+1isWhlqQxfTAYJR4FeAjDiajWZUz5JiMIEkfN6FYcE8Vaypfs7qUAxVvyvCVLP8UUX0WBX7C4CrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA1PR04MB10118.eurprd04.prod.outlook.com (2603:10a6:102:45b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Fri, 26 Sep
 2025 04:22:42 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9160.010; Fri, 26 Sep 2025
 04:22:42 +0000
Date: Fri, 26 Sep 2025 13:34:32 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/11] ARM: dts: imx6: trivial change to clean up some
 DTB warnings.
Message-ID: <20250926053432.GB8204@nxa18884-linux.ap.freescale.net>
References: <20250925-imx6_dts_cleanup-v1-0-748380dd0d22@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925-imx6_dts_cleanup-v1-0-748380dd0d22@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR06CA0192.apcprd06.prod.outlook.com (2603:1096:4:1::24)
 To PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA1PR04MB10118:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a592700-d8b4-48c8-462a-08ddfcb455a6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?70yjzUacMrl7nCis8lvF9QGT7rcRaVNGbAP4jo7kuL0LJOmAG5TYrJysbse0?=
 =?us-ascii?Q?osWoy12MuXlQYF5hGGFCQpQM7c6Pbtn8jO0B9Sn9WUL/m5uf0xvFAmtTXyFG?=
 =?us-ascii?Q?TI+KFUtwroYrGSS4KdVFVEmNh5NNDJbq1dmb2RRSV3Zvp7SqNpLm0/D9gAvh?=
 =?us-ascii?Q?v6yYEwb51Br8nXNY9H3ZcKFids+gz6yfAI9YkydDrf9+fyeg2M8v8fIkDwKj?=
 =?us-ascii?Q?9k4KB3wWJ8qMlu6y57MU2oh3HgM6pf0BAE/tFMlLr5YOpPhOhnMc0rUILKdQ?=
 =?us-ascii?Q?7/yP9HPSHWzI67izWLjyzYeBAJvwYmsrwRZ9DZ+Fdrmh2Cx3gc52IfnfBv1w?=
 =?us-ascii?Q?CyLIeRJjsVs6stHCoL+lrjY2IKx1Z7GFOtk7umKkeeb708BWGljbC9hSZmqs?=
 =?us-ascii?Q?8WXJtisH8LBmlKfMg1usKmY7rgoccfM/Fh4wE9zbdgUom6b+TxQ9aZXCgnxB?=
 =?us-ascii?Q?Ka1DXYzgP4jouqCQ8oNE1srA93xrGzjzwpwgTzjrn/g5uwxfAf1N/0jCGjpT?=
 =?us-ascii?Q?JunLqRDIRCpjLnjA2eanSZOn6BxBXkOUgMnzsTMFZ5IkX14bNm8weiZM0BS6?=
 =?us-ascii?Q?+k8tCtdrFxs3SCDbaTqmqFXwWBDme8raSiHFHFrN7ipEboy5upgDx4VfhuI7?=
 =?us-ascii?Q?7ZmpIY/e9LxlAJMq2mDYglpCQvf6z1iNVjs6VtPk+8AlAkqQfLKIKd7YgCau?=
 =?us-ascii?Q?ecmrbL+a7zbdec0btz9pUToqmEqh0s1wc1d8aN2579vCMkwYRLJcZrBValod?=
 =?us-ascii?Q?aSgJ4LXEcqLyJgOachws3hGeR8UGRb9We5zMP1tYDGMSE1fSEHq05gilJAeK?=
 =?us-ascii?Q?pGD4/EkReGaccd0IUSE05z04mGhhM4MEFoI4inL5nWeUjhnpWyhBugAGeNvK?=
 =?us-ascii?Q?vMtv3QAill0koGSj/MCa2rd4RuaXiaxnubsNX0nP7KjXLkjucdk7IWzBXoEa?=
 =?us-ascii?Q?zj/NUD9YxaYSVwmmKFTMdm2KtdUigfSRHisf/Ozaa1TdPdvFoYYupOtOZ2BH?=
 =?us-ascii?Q?VzzZ/0CqALv01pNrDqgG4gG8aRrg4idRfpJdcu859eItA/hRS7JCnQlAXCOp?=
 =?us-ascii?Q?qlhSH5pVp+hCytdTnIz4CBCuYasI1AvYg1BN07unwNOE9q4ySQANAvM9k5uN?=
 =?us-ascii?Q?qZqF/DzyzOkZZ/y09DdscZpMvNAl2LSoV1jfw1tsQTF6v97RopwAY5vmNhas?=
 =?us-ascii?Q?pYxEDcqijDGlwSt6kz+NXzbcYzYnXBs0edgIF0lM8ruO/rVOo0NTwl0xRROI?=
 =?us-ascii?Q?e2Ed9zeoJkt7XaLiim9RiqWo3sM5QJzFjI8VA2fUfbe3N1aCkUlArVED1VY1?=
 =?us-ascii?Q?v7zf/5MeRCVh3eMzUvza27sNs8lWh6BonwYNECOS+oXhzIEFGCJVeRBOCVZ/?=
 =?us-ascii?Q?w/9RxKKopzanEseH1/tF+CFYD7WBvdoh04VGqczM+4a4SDnQ/JpLpmzQLkHv?=
 =?us-ascii?Q?gEvSAQ8oAdWzAxIHuAeZ3V9F7PDpQ8dyZ63XgKu9HC/JseP0/PvEUQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FrX/8jwvW8eL+LCIh94YvHUTbMqEiNAf2PHlDOrI86yC//m5Q1doDu5fiEcb?=
 =?us-ascii?Q?4AS6lUiZVkr4l1sPag8/dhEzSsRzVunN6nSWdjKmFfP2Qgo89iQ5fYPTc5B5?=
 =?us-ascii?Q?33kyuDAMR/zJNQVpQl9ReKhM42AzAuZ5euYgxE5UWLJdC/I+jLnX3goDunA3?=
 =?us-ascii?Q?Rp8nLkZA096UN2GqdDLCuYDjVEMEzmGm18pwA1qS2A9nQB1A5h0gakC96/Gb?=
 =?us-ascii?Q?pvjzukXyNWq5gjEnVKLOQFyYbZip/m3unyaLEAemM4cV0UeALHgTcJl6FKLv?=
 =?us-ascii?Q?oOkifo02rKy6UGHyvGdDkqRiS+K40K+Cu4wWwYAEEDH8DtetVBNNp9WhkBVa?=
 =?us-ascii?Q?TwnhOnOoDTHMr9Kt9rQGryAc1GWKKT3PpCGl1LDRqhtbanTFEmPaGl1o1FyT?=
 =?us-ascii?Q?a4Zq9LlHRXnf2K+BlQV3VSSIOzhdM9RM25BoM0v2cy07yxcWZ8PjAIqUcFnF?=
 =?us-ascii?Q?ER50V7TX1L2CGl14E0/SZSbKSoykgBGbjMpGE+L/Z0ybzqI/lQYOn+KsuSh8?=
 =?us-ascii?Q?wrX85ai6bfK/IidRVya7KBbRoj3QhZdHUQsFwiajhqYIv5WcLwy+DqDDz3jd?=
 =?us-ascii?Q?PSbHPsBFIWu/2AJ5quUU5h4zcDB+6FDKvO+EilV0N3ulL72V5Eho7XR1cnV3?=
 =?us-ascii?Q?acZODevMACIe8WkrbkvSRObDz2oUwv1Ej6CTC2AatGVxTdaWOSGpUWqzrFvt?=
 =?us-ascii?Q?sjq52qRlnY1fEQ8mxUAt9baNAw31SqOxAFN+e4xHFOH8BvFtIFXHOkn1s6/e?=
 =?us-ascii?Q?gNCPh/vhfBx5a59kC3L26rdpDfeZmh1W5XzH7Zlit/Zukws0k/ISNWYpq0Xa?=
 =?us-ascii?Q?FAYlSb2xdQpbaN9N4uzAdzkxTlyxemd9VrRD6d7mUVkr77qhIDh97RoRXm6M?=
 =?us-ascii?Q?gWkwAnPsjymRfMOEmpAaw6hY7I4xL1Bq2FOHnfBVOzd/xfhDyeZlyOYqpYsD?=
 =?us-ascii?Q?loS/tgUv/UvJ4601xMNvObTeni+IEgR1RIttZ5OOeVz7hq1E0BVM8hg5t9FJ?=
 =?us-ascii?Q?ZOFKNQnrL2cu2VXuz/64BdTCXK/jXg8gtrtzRhEj7+E0ZNXBAg4ftfDslKbZ?=
 =?us-ascii?Q?j817Y9Grpjl1im7BM+HUmXUfg/XEemnYhL5ZWWg++aKi2SrdmSCegDfc/PDs?=
 =?us-ascii?Q?OYz8jGcb5wxxwzEyCM99krXrnJlOOGjUsmQFj/GG+ao9eSjGhAOkVe/heUnW?=
 =?us-ascii?Q?v9Agukb3kvHHIGxJB6D3Ks+6nT5V6oOcsJEPpa5n0ogb6LI9cea8yAgTwiGP?=
 =?us-ascii?Q?k0ch4T676frnLIgzh+lJta4mSJiG3tJLWLb4bYEloNZgBLcJZeo7JWyUSMci?=
 =?us-ascii?Q?Rox2f14n+4WRfkROQI7U600Yp0d7lzw7Xo6lQ+4U1gzyPdsYRKeO47kf+7lo?=
 =?us-ascii?Q?ZCl66OOp2sWLPFXy0+VfJqDm5xL5qESfsjTgfpcG0q4104wjcJeWuxi52jfm?=
 =?us-ascii?Q?0Ypqt8pI1ddIGQJOmaawtdc14YtwxcqPv6PAkKHnkR/i67uh4Oa8cQqQo6Rr?=
 =?us-ascii?Q?/RUGkkasVI2YSxwoVApyX1I4wB1gRNxQV/uuxEGzwVjg2gX+O+hawycrTsYB?=
 =?us-ascii?Q?wWGdh933a5BubA/mPRVe/yKNJQNSYDvAZ99NWQkA?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a592700-d8b4-48c8-462a-08ddfcb455a6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 04:22:42.3152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O8I2UoPd6oZAy5Eb95FELNRUblduFj9+s6bWYuE72cZHhI++U2wL+jZ+u9yscidxb0oB7dO9yolaTtx15YTVdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10118

On Thu, Sep 25, 2025 at 05:13:44PM -0400, Frank Li wrote:
>Trivial change to clean up some DTB warnings.
>
>Signed-off-by: Frank Li <Frank.Li@nxp.com>
>---
>Frank Li (11):
>      ARM: dts: imx6: rename stmpgpio to gpio
>      ARM: dts: imx6: rename touch-thermal0 to touch-0-thermal
>      ARM: dts: imx6: rename m95m02 to eeprom
>      ARM: dts: imx6qdl-ts4900: rename ngpio to ngpios
>      ARM: dts: imx6: remove gpio suffix for regulator
>      ARM: dts: imx6: change voltage-divider's io-channel-cells to 1
>      ARM: dts: imx6: remove pinctrl-name if pinctrl-0 doesn't exist
>      ARM: dts: imx6-tbs2910: rename ir_recv to ir
>      ARM: dts: imx6q-utilite-pro: add missing required property for pci
>      ARM: dts: imx6ull-phytec-tauri: remove extra space before jedec,spi-nor
>      ARM: dts: imx6qdl-nitrogen6_max: rename i2c<n>mux to i2c
>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

