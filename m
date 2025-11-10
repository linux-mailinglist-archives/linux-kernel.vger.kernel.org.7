Return-Path: <linux-kernel+bounces-892691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F07AC45A00
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A0EA24EA544
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76FA303A38;
	Mon, 10 Nov 2025 09:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GdSJ+fu/"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013006.outbound.protection.outlook.com [52.101.83.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD94C3016FC
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 09:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762766598; cv=fail; b=NYaz/hWxY4357QTuINcKNFrC0baV03TcSlJNBJsmu2ytwK3MpbHxmC6oNSS4OD+qgCfLtUSr+m73oWiluxOg1wwAnEb2ZuSz1fmMRqbFLrA9w2M7vkmyjHgz6eeug493T4kQpubAcBETIYn83p85TvXE27wlqRVQScENpOZAP5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762766598; c=relaxed/simple;
	bh=moryKMI3owJqrmqUCNhgUAJIVjwfG+kMoOsWPvcRL98=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qgGsScP4dSBWNz+SMcqP3OjscWKpo1Y9NTEj/UBFq8fMIBMtmW9MnopJPzoITJ2gbtHXsl2r386yEP84vNKjCoWAGyiCC0nUgBahlNG0xlOYTLCi5Mt9emxYEKAJkyOAqoka4lr/H9EFekx+5609GRbNDTMQlL+mq79UHhF4ldY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GdSJ+fu/; arc=fail smtp.client-ip=52.101.83.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GMCdmXcmN2SDeQ9P9wb5RKCYDsoOTnOjjcQ7Q6oKdtnwDXaPAvwGNhO9fM1Jshr8cok2jtTK0rUtLtoimI9Aq+xxzsq2Nm+BS1mreAJ77nG5HWRU2iCo4h7s4BdDhMtxpLuarcX1FRZm1c0B2xIzVw0VdLVeo49KnwsjSrvSCyVMVzu1VkdOKGWJxwmebYBg8z8UjA5h74v7jxoy4P6PocLDcAqTPGqFe7ZMQVdZLD3a6sX1QyKq6NIZmFp3GIylicJ9jBNxAa5LoVrpc64S+A+3Jai0zN2DymzSHSn0YGp6VVg2iZVrw1P//WpyvSSexpznQV7Vuodm/qx+oiGIiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cZnyYra4tAKa1KXYu3Js0VKL6TOb8QIOu8s7+qHvfAk=;
 b=LvNzMiwNTk8QIAvuY1CEYQd4MO5Edxc1T88+uaMGWT1CTCGSS+1YF/X4wORhamOIt7O//sRJOU52Qfr4XvQwALh8nwromUXXYEu0aVo7m8AfO1pnBE9NcIku+j1/wspeiY7eggMyC+v3PD3RkpiQQtK3Et08i43txF4gW8RZw7HxCVEAyUTpLG66tgzh7VI0y8CVaXTxIt/4DxQy01hIh3PNUVL84MlGm+zXErYz0nC5qJ++XPDbdhqESs+MgJnt7a/g3LM8zfJ4FEZdINcUBY+e1UggMiaoU+1rQMHSAO5XqOqKJ6JrdV3ey3PFoWNlP4XXODU5u9F6CzmHQalNjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cZnyYra4tAKa1KXYu3Js0VKL6TOb8QIOu8s7+qHvfAk=;
 b=GdSJ+fu/cKzel2y/LuMb3VKUtWxxrL8bpdzRy3OgHeiHyd4C8sSjJJu533QKKgLpjb9PpK/h0DQ4SaWfFX5KtvBVtwwroz8WobmT27wVEl7NSdsV9xH/N3ELWDvEsHbdEPFcYlHS/7UsCNM69u407W+rpC969wqEUuv9yMLSmtQVhPDBNwKKz62NgEyXHw9CXSg1XxGnG4w8y361so0rT6eSltXKas9R6LtTA5yjJ9E2bab0V53HRXEbm7/Sc+PyviofWdepEx4qs9HKUzFaj+pJgoGN1rVkoTNPrW+yKJxrl/8ikUTEu1MksltUoPBfXujToiHuHWLRgjVfvyW+eA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PA1PR04MB10468.eurprd04.prod.outlook.com (2603:10a6:102:448::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 09:23:05 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9298.010; Mon, 10 Nov 2025
 09:23:05 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Josua Mayer <josua@solid-run.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 phy 10/16] phy: lynx-28g: refactor lane->interface to lane->mode
Date: Mon, 10 Nov 2025 11:22:35 +0200
Message-Id: <20251110092241.1306838-11-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110092241.1306838-1-vladimir.oltean@nxp.com>
References: <20251110092241.1306838-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0026.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::31) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PA1PR04MB10468:EE_
X-MS-Office365-Filtering-Correlation-Id: 3420ba75-3d02-40b6-2001-08de203ac10d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vUggjXDq3z/cFwCQCP4WSDoPXWCcqXHFqJcEMVO3z0Kgu7UyKM37f4MxK/M6?=
 =?us-ascii?Q?dEBuWS7lftL8i8fY8G3hGqL1AsmeFavipa7qXxwgjt86qEtuwypOlUsYz+1U?=
 =?us-ascii?Q?geZK9jn4fyAoQvmn+1oAQqt1kCcWcnUzjVLxzUhZllVWXeXVb29XjKqwcZOH?=
 =?us-ascii?Q?WQLPm+lXZHwWQzydecDcCZL45KzwJW/mUS+RP/X/vpFZUUIWO7T/L9vHkIAk?=
 =?us-ascii?Q?ZC3aD1AkRFkkO8fYLmmJ56jBahb8WsVqrqQhT0GwxhRsEBj2/egLlsIjHDve?=
 =?us-ascii?Q?rqJgfNgECat1+QRj3C1exzE79IZDgE5tm7TGpxWW1BDZSrKzfmBXM2gaQkkj?=
 =?us-ascii?Q?2GfYqrZ7m46JeoZTIGT9Z9DSfBD8QaA1LdAKcoBK+SYcJvRySgmTtStzYfEF?=
 =?us-ascii?Q?t7gLMcr6cYoNYPOK9tG24F5RvEPS9qZYlvXoSAKJq1RzmbfyCxE3gL54h/f/?=
 =?us-ascii?Q?2zweflLsZOONEEmrJDHfDo6Kz9jgHWWGebBRWM7jDO8Ctow64xNfKEyKPlWw?=
 =?us-ascii?Q?vbMRcPeiW8tHyC6mGfoBsyxL0f3qn6bdJT1XqOSiZWdoP/P7fryPGfCI55XW?=
 =?us-ascii?Q?6BVD83SNfzsZnXVfHFtuQH5913EyWxhQlSVHY7iSzGyMzaTDFLoLxKMevK/i?=
 =?us-ascii?Q?zkFVZgL+EriavNRE0M20//0GbnLyS4F9Ej08bo9gnCIilcvrlNA0Sn5Iiqq1?=
 =?us-ascii?Q?kd3ABc5TZ5AO9SRLWE6AFhX6IOzeaFKCmGPWZeTodnPTXjJAYi3NP+J5xirG?=
 =?us-ascii?Q?oEOVCY943pbMCF7ns3bli9HeftCJJLkZgzLf+gXtAd2KLGpEygt4I0YOy/Ux?=
 =?us-ascii?Q?OZZSqs2R7KMookLZia3oIfa1DjPrzOr3xsfinY7UAjyL3/ehMIoOEQUiQ5mV?=
 =?us-ascii?Q?cucA7o66PXlhXsnyoFMj6xij4cREoJ89kCP3csXbCHA/V7pTTfVaxQVWlszF?=
 =?us-ascii?Q?x2KGKfY7Z8Tywh2J9P0Ml8Jx5GWWAEmzUuqrspB+70209itGFRZSvaHAkFIE?=
 =?us-ascii?Q?eD6dXdgtS3y5yONqTf2vote8yilRzeFLjkUFqeJXH5sbCPK7OTOir2da/cY8?=
 =?us-ascii?Q?24qiZm4n9wS1lmn3jpJmU9WWqBGTq7LtjrPIVfj/fJeYGmsjYBu9ZnTetJW/?=
 =?us-ascii?Q?UJThMpHpCA15tbs5ITPVfT9V2yLFJzfuPc0uMOt19hiBihu0KjN5xrB3DpsB?=
 =?us-ascii?Q?SBCynTBZRXF6BMEgnbw0m5Y0IOrY2fOC35kdDA8OBiWvrtcDylVIUnQG3Lco?=
 =?us-ascii?Q?SksuV0Bd/kCFpOMUJflrR90aUEOCuolXzSlDNeO/GVH2NAKHK7iaw7JXbrwA?=
 =?us-ascii?Q?t3mni0wLg0AeGAnF6MqvFCeGfZ/1T/CJLbiRkpyiPZOzuK3nLd2PQFHo1ZGX?=
 =?us-ascii?Q?EfYWMfyDzBkvoORvvfcHPZ/AsWqjg3KSLclPlZ6axFyPIzQYmvt2HhCy4D7I?=
 =?us-ascii?Q?96tdsxausAFZYqkIeTpbWc3uASDSCVMpVKYIvUN2zhH8KEBwUE84zVLxRGFX?=
 =?us-ascii?Q?iM6b10uRDI7Fot8Ni5yff5ExGc3+1JBp8FkU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EU889stoUHHIJ+wsxM/wA/cQXq01Su4GNdKEcFDKNPE38suF+NFzGXQiOO2p?=
 =?us-ascii?Q?bjoX5p2s2RYNIRD29QDQq/cduksT4uiW7/wIPgMYietPWgJbX6RV+aRlx1hJ?=
 =?us-ascii?Q?O+3/T1JcvW9G5BtQ4UDcqD0+zg5NziqwfpK2pnD4tmQapjpzb+EZ4dkN+YJS?=
 =?us-ascii?Q?lwD2v/7BOQ97sPI6PeQ7WEB1AuIk+2FNDVGUKY66yC0i9o0TaXzz9s95wvAn?=
 =?us-ascii?Q?6UXhS/C8kiSBdIW0HQE2YpHN8w9llHNEtY21uzOP1wmUydAmJulaGVmwl0K4?=
 =?us-ascii?Q?rD8CR0FfIHsVMwgs670Pj2A2pB6mYGI6MQ3MKtNkLlvPUi9enVP5Nyrf6o1v?=
 =?us-ascii?Q?OQ6LnFo5ioUKCOgOloqFYQEwq8SCOShPP113ifQ+zpKTA3tD8QwN7e28LgWm?=
 =?us-ascii?Q?Ps7IXUart+TM+sRk9aehFxwisCq4FQNYqLQ7avi7enKTPq0+Y5cQCLqZUNhV?=
 =?us-ascii?Q?crguCEULCHtRQmUpq3J/dF4ec4eUlAY6sIRnbxyLdCxKHXyKxJlkRcdETTeh?=
 =?us-ascii?Q?yXp6UW+b05QKJSKQZJK2zgTCZvS/8Na8xrbQbzSMgQIwXPYVOpFpGAyf1Iq7?=
 =?us-ascii?Q?UTqf51Fo6J4KYziUY+92SjkVDFtmKA3Cw1h59A/INWVTOFMAqbtdpBjDnKnP?=
 =?us-ascii?Q?24YYTT3ji5UZ7fIADig0wdM82rlzmsh/CspjwrwuM9mMFFDB/GmePkfYlDWD?=
 =?us-ascii?Q?PY/HQC78MVC/7CVZDUwBYfVgXHcPaezuMaqqIAMD17/FYbeTAxGg5yJy9tkF?=
 =?us-ascii?Q?+LBHjLJ7jUPulNrmEWuMR5nbwinyRb/j5puT81ZOQTfkknRZyN7UbgvtKW1r?=
 =?us-ascii?Q?tUK3fzGXqopohJ8qdkZ2D/dv3W1BrOhQgHjtmDtKvc2gBMMH1vD5LBAKl+YO?=
 =?us-ascii?Q?9onbFpQStvWXerFnCFEJvDeBc8KGyQSNpMVXLlQuijEA5I70Gky1TOChG/44?=
 =?us-ascii?Q?3lxMINOTLaraN2zX1c0fpNnkLd6O2gHEaLcRaZZaUv9DQkbEAhA+LT8zfrSz?=
 =?us-ascii?Q?dDc3XinDSnl0weaohKIX43hnpB7eeOuR2xPJF0a2DqB9fJ8g8RmLLMhZXDQ2?=
 =?us-ascii?Q?LNU6L/g9TgHsUjB6yRKIR8CJWn0TjNM021kCeZjbr7j70ubde5IeGrbJ8ACD?=
 =?us-ascii?Q?FaWrAruwWrj3OB9Ju0l8oFroa0+cU1QlPmmqFn7dfbCokqD3tGEXsk78OvMG?=
 =?us-ascii?Q?gmHarT7kAwzMTN8L8J0XxG86bEbR7qm3CEhitVf/XoeYqCKTYWPayP+BQ8rK?=
 =?us-ascii?Q?kP3+1cNd3SUmL3PVw4LEjPr3yIT5K9MX2vPBmm9c7dLCy3DyJYdULH5O211P?=
 =?us-ascii?Q?hfpNUJhPSCa54oZUGClhq4msxfKj+1hOeLXboLovA3Z/bAbFe3PMXvZn0pIg?=
 =?us-ascii?Q?4Szyx3N9Me0AURuBSLUrm23+K32k8vA8mohIkVMdx88adLdygnIdYbbZbD47?=
 =?us-ascii?Q?6P5vucuGkIbaSIroxKbVtcMqL35eAbS4PfNZV9K53w2yOCa5NB0394wjabzG?=
 =?us-ascii?Q?Xd8CPGUmgH2xyi7KXj1yPX8qL9vhqR//KgLs0KXtrjkx6+CjRJA09y1mQ/Xw?=
 =?us-ascii?Q?TbtI6Ys2sYQ7MWSb49V8bNoUTPAmJjedkcPQoaJV0VXmQXYHTcMIgn2W937g?=
 =?us-ascii?Q?Vw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3420ba75-3d02-40b6-2001-08de203ac10d
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 09:23:05.4691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ks2U12+VQe0HpQymeihnUHtDllh/MFdF3LL7Qzsc1jY/CDh+Y6zUJDmpJIG1ggWUi9WX5nUVX3DtAV4kUbNDXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10468

Lynx 28G is a multi-protocol SerDes - it handles serial Ethernet, PCIe,
SATA.

The driver should not use the phylib-specific phy_interface_t as an
internal data representation, but something specific to its internal
capabilities, and only convert to phy_interface_t when PHY_MODE_ETHERNET
is selected and used.

Otherwise it has no way of representing the non-Ethernet lanes (which
was not a short-term goal when the driver was introduced, and is not a
goal per se right now either, but should nonetheless be possible).

Prefer the "enum lynx_lane_mode" name over "lynx_28g_lane_mode", in
preparation of future Lynx 10G SerDes support. This SerDes is part of
the same IP family and has similar capabilities, and will reuse some
code, hence the common data type.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v3->v4: none
v2->v3:
- fix lynx_28g_set_mode() by using lane_mode instead of submode
- save lane_mode to local variable in lynx_28g_set_mode()
v1->v2: none

 drivers/phy/freescale/phy-fsl-lynx-28g.c | 208 ++++++++++++-----------
 1 file changed, 106 insertions(+), 102 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-lynx-28g.c b/drivers/phy/freescale/phy-fsl-lynx-28g.c
index 83d9cbae251b..2b5dbc0361a1 100644
--- a/drivers/phy/freescale/phy-fsl-lynx-28g.c
+++ b/drivers/phy/freescale/phy-fsl-lynx-28g.c
@@ -243,6 +243,13 @@ enum lynx_28g_proto_sel {
 	PROTO_SEL_25G_50G_100G = 0x1a,
 };
 
+enum lynx_lane_mode {
+	LANE_MODE_UNKNOWN,
+	LANE_MODE_1000BASEX_SGMII,
+	LANE_MODE_10GBASER_USXGMII,
+	LANE_MODE_MAX,
+};
+
 struct lynx_28g_proto_conf {
 	/* LNaGCR0 */
 	int proto_sel;
@@ -280,8 +287,8 @@ struct lynx_28g_proto_conf {
 	int smp_autoz_eg1r;
 };
 
-static const struct lynx_28g_proto_conf lynx_28g_proto_conf[PHY_INTERFACE_MODE_MAX] = {
-	[PHY_INTERFACE_MODE_SGMII] = {
+static const struct lynx_28g_proto_conf lynx_28g_proto_conf[LANE_MODE_MAX] = {
+	[LANE_MODE_1000BASEX_SGMII] = {
 		.proto_sel = LNaGCR0_PROTO_SEL_SGMII,
 		.if_width = LNaGCR0_IF_WIDTH_10_BIT,
 		.teq_type = EQ_TYPE_NO_EQ,
@@ -309,35 +316,7 @@ static const struct lynx_28g_proto_conf lynx_28g_proto_conf[PHY_INTERFACE_MODE_M
 		.smp_autoz_d1r = 0,
 		.smp_autoz_eg1r = 0,
 	},
-	[PHY_INTERFACE_MODE_1000BASEX] = {
-		.proto_sel = LNaGCR0_PROTO_SEL_SGMII,
-		.if_width = LNaGCR0_IF_WIDTH_10_BIT,
-		.teq_type = EQ_TYPE_NO_EQ,
-		.sgn_preq = 1,
-		.ratio_preq = 0,
-		.sgn_post1q = 1,
-		.ratio_post1q = 0,
-		.amp_red = 6,
-		.adpt_eq = 48,
-		.enter_idle_flt_sel = 4,
-		.exit_idle_flt_sel = 3,
-		.data_lost_th_sel = 1,
-		.gk2ovd = 0x1f,
-		.gk3ovd = 0,
-		.gk4ovd = 0,
-		.gk2ovd_en = 1,
-		.gk3ovd_en = 1,
-		.gk4ovd_en = 0,
-		.eq_offset_ovd = 0x1f,
-		.eq_offset_ovd_en = 0,
-		.eq_offset_rng_dbl = 0,
-		.eq_blw_sel = 0,
-		.eq_boost = 0,
-		.spare_in = 0,
-		.smp_autoz_d1r = 0,
-		.smp_autoz_eg1r = 0,
-	},
-	[PHY_INTERFACE_MODE_10GBASER] = {
+	[LANE_MODE_10GBASER_USXGMII] = {
 		.proto_sel = LNaGCR0_PROTO_SEL_XFI,
 		.if_width = LNaGCR0_IF_WIDTH_20_BIT,
 		.teq_type = EQ_TYPE_2TAP,
@@ -379,7 +358,7 @@ struct lynx_28g_pll {
 	struct lynx_28g_priv *priv;
 	u32 rstctl, cr0, cr1;
 	int id;
-	DECLARE_PHY_INTERFACE_MASK(supported);
+	DECLARE_BITMAP(supported, LANE_MODE_MAX);
 };
 
 struct lynx_28g_lane {
@@ -388,7 +367,7 @@ struct lynx_28g_lane {
 	bool powered_up;
 	bool init;
 	unsigned int id;
-	phy_interface_t interface;
+	enum lynx_lane_mode mode;
 };
 
 struct lynx_28g_priv {
@@ -429,7 +408,34 @@ static void lynx_28g_rmw(struct lynx_28g_priv *priv, unsigned long off,
 #define lynx_28g_pll_read(pll, reg)			\
 	ioread32((pll)->priv->base + reg((pll)->id))
 
-static bool lynx_28g_supports_interface(struct lynx_28g_priv *priv, int intf)
+static const char *lynx_lane_mode_str(enum lynx_lane_mode lane_mode)
+{
+	switch (lane_mode) {
+	case LANE_MODE_1000BASEX_SGMII:
+		return "1000Base-X/SGMII";
+	case LANE_MODE_10GBASER_USXGMII:
+		return "10GBase-R/USXGMII";
+	default:
+		return "unknown";
+	}
+}
+
+static enum lynx_lane_mode phy_interface_to_lane_mode(phy_interface_t intf)
+{
+	switch (intf) {
+	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_1000BASEX:
+		return LANE_MODE_1000BASEX_SGMII;
+	case PHY_INTERFACE_MODE_10GBASER:
+	case PHY_INTERFACE_MODE_USXGMII:
+		return LANE_MODE_10GBASER_USXGMII;
+	default:
+		return LANE_MODE_UNKNOWN;
+	}
+}
+
+static bool lynx_28g_supports_lane_mode(struct lynx_28g_priv *priv,
+					enum lynx_lane_mode mode)
 {
 	int i;
 
@@ -437,7 +443,7 @@ static bool lynx_28g_supports_interface(struct lynx_28g_priv *priv, int intf)
 		if (PLLnRSTCTL_DIS(priv->pll[i].rstctl))
 			continue;
 
-		if (test_bit(intf, priv->pll[i].supported))
+		if (test_bit(mode, priv->pll[i].supported))
 			return true;
 	}
 
@@ -445,7 +451,7 @@ static bool lynx_28g_supports_interface(struct lynx_28g_priv *priv, int intf)
 }
 
 static struct lynx_28g_pll *lynx_28g_pll_get(struct lynx_28g_priv *priv,
-					     phy_interface_t intf)
+					     enum lynx_lane_mode mode)
 {
 	struct lynx_28g_pll *pll;
 	int i;
@@ -456,27 +462,27 @@ static struct lynx_28g_pll *lynx_28g_pll_get(struct lynx_28g_priv *priv,
 		if (PLLnRSTCTL_DIS(pll->rstctl))
 			continue;
 
-		if (test_bit(intf, pll->supported))
+		if (test_bit(mode, pll->supported))
 			return pll;
 	}
 
 	/* no pll supports requested mode, either caller forgot to check
 	 * lynx_28g_supports_lane_mode, or this is a bug.
 	 */
-	dev_WARN_ONCE(priv->dev, 1, "no pll for interface %s\n", phy_modes(intf));
+	dev_WARN_ONCE(priv->dev, 1, "no pll for lane mode %s\n",
+		      lynx_lane_mode_str(mode));
 	return NULL;
 }
 
 static void lynx_28g_lane_set_nrate(struct lynx_28g_lane *lane,
 				    struct lynx_28g_pll *pll,
-				    phy_interface_t intf)
+				    enum lynx_lane_mode lane_mode)
 {
 	switch (FIELD_GET(PLLnCR1_FRATE_SEL, pll->cr1)) {
 	case PLLnCR1_FRATE_5G_10GVCO:
 	case PLLnCR1_FRATE_5G_25GVCO:
-		switch (intf) {
-		case PHY_INTERFACE_MODE_SGMII:
-		case PHY_INTERFACE_MODE_1000BASEX:
+		switch (lane_mode) {
+		case LANE_MODE_1000BASEX_SGMII:
 			lynx_28g_lane_rmw(lane, LNaTGCR0,
 					  FIELD_PREP(LNaTGCR0_N_RATE, LNaTGCR0_N_RATE_QUARTER),
 					  LNaTGCR0_N_RATE);
@@ -489,9 +495,8 @@ static void lynx_28g_lane_set_nrate(struct lynx_28g_lane *lane,
 		}
 		break;
 	case PLLnCR1_FRATE_10G_20GVCO:
-		switch (intf) {
-		case PHY_INTERFACE_MODE_10GBASER:
-		case PHY_INTERFACE_MODE_USXGMII:
+		switch (lane_mode) {
+		case LANE_MODE_10GBASER_USXGMII:
 			lynx_28g_lane_rmw(lane, LNaTGCR0,
 					  FIELD_PREP(LNaTGCR0_N_RATE, LNaTGCR0_N_RATE_FULL),
 					  LNaTGCR0_N_RATE);
@@ -580,17 +585,16 @@ static int lynx_28g_power_on(struct phy *phy)
 	return 0;
 }
 
-static int lynx_28g_get_pccr(phy_interface_t interface, int lane,
+static int lynx_28g_get_pccr(enum lynx_lane_mode lane_mode, int lane,
 			     struct lynx_pccr *pccr)
 {
-	switch (interface) {
-	case PHY_INTERFACE_MODE_SGMII:
-	case PHY_INTERFACE_MODE_1000BASEX:
+	switch (lane_mode) {
+	case LANE_MODE_1000BASEX_SGMII:
 		pccr->offset = PCC8;
 		pccr->width = 4;
 		pccr->shift = SGMII_CFG(lane);
 		break;
-	case PHY_INTERFACE_MODE_10GBASER:
+	case LANE_MODE_10GBASER_USXGMII:
 		pccr->offset = PCCC;
 		pccr->width = 4;
 		pccr->shift = SXGMII_CFG(lane);
@@ -602,13 +606,12 @@ static int lynx_28g_get_pccr(phy_interface_t interface, int lane,
 	return 0;
 }
 
-static int lynx_28g_get_pcvt_offset(int lane, phy_interface_t interface)
+static int lynx_28g_get_pcvt_offset(int lane, enum lynx_lane_mode lane_mode)
 {
-	switch (interface) {
-	case PHY_INTERFACE_MODE_SGMII:
-	case PHY_INTERFACE_MODE_1000BASEX:
+	switch (lane_mode) {
+	case LANE_MODE_1000BASEX_SGMII:
 		return SGMIIaCR0(lane);
-	case PHY_INTERFACE_MODE_10GBASER:
+	case LANE_MODE_10GBASER_USXGMII:
 		return SXGMIIaCR0(lane);
 	default:
 		return -EOPNOTSUPP;
@@ -616,14 +619,14 @@ static int lynx_28g_get_pcvt_offset(int lane, phy_interface_t interface)
 }
 
 static int lynx_pccr_write(struct lynx_28g_lane *lane,
-			   phy_interface_t interface, u32 val)
+			   enum lynx_lane_mode lane_mode, u32 val)
 {
 	struct lynx_28g_priv *priv = lane->priv;
 	struct lynx_pccr pccr;
 	u32 old, tmp, mask;
 	int err;
 
-	err = lynx_28g_get_pccr(interface, lane->id, &pccr);
+	err = lynx_28g_get_pccr(lane_mode, lane->id, &pccr);
 	if (err)
 		return err;
 
@@ -638,13 +641,13 @@ static int lynx_pccr_write(struct lynx_28g_lane *lane,
 	return 0;
 }
 
-static int lynx_pcvt_read(struct lynx_28g_lane *lane, phy_interface_t interface,
-			  int cr, u32 *val)
+static int lynx_pcvt_read(struct lynx_28g_lane *lane,
+			  enum lynx_lane_mode lane_mode, int cr, u32 *val)
 {
 	struct lynx_28g_priv *priv = lane->priv;
 	int offset;
 
-	offset = lynx_28g_get_pcvt_offset(lane->id, interface);
+	offset = lynx_28g_get_pcvt_offset(lane->id, lane_mode);
 	if (offset < 0)
 		return offset;
 
@@ -653,13 +656,13 @@ static int lynx_pcvt_read(struct lynx_28g_lane *lane, phy_interface_t interface,
 	return 0;
 }
 
-static int lynx_pcvt_write(struct lynx_28g_lane *lane, phy_interface_t interface,
-			   int cr, u32 val)
+static int lynx_pcvt_write(struct lynx_28g_lane *lane,
+			   enum lynx_lane_mode lane_mode, int cr, u32 val)
 {
 	struct lynx_28g_priv *priv = lane->priv;
 	int offset;
 
-	offset = lynx_28g_get_pcvt_offset(lane->id, interface);
+	offset = lynx_28g_get_pcvt_offset(lane->id, lane_mode);
 	if (offset < 0)
 		return offset;
 
@@ -668,43 +671,44 @@ static int lynx_pcvt_write(struct lynx_28g_lane *lane, phy_interface_t interface
 	return 0;
 }
 
-static int lynx_pcvt_rmw(struct lynx_28g_lane *lane, phy_interface_t interface,
+static int lynx_pcvt_rmw(struct lynx_28g_lane *lane,
+			 enum lynx_lane_mode lane_mode,
 			 int cr, u32 val, u32 mask)
 {
 	int err;
 	u32 tmp;
 
-	err = lynx_pcvt_read(lane, interface, cr, &tmp);
+	err = lynx_pcvt_read(lane, lane_mode, cr, &tmp);
 	if (err)
 		return err;
 
 	tmp &= ~mask;
 	tmp |= val;
 
-	return lynx_pcvt_write(lane, interface, cr, tmp);
+	return lynx_pcvt_write(lane, lane_mode, cr, tmp);
 }
 
 static void lynx_28g_lane_remap_pll(struct lynx_28g_lane *lane,
-				    phy_interface_t interface)
+				    enum lynx_lane_mode lane_mode)
 {
 	struct lynx_28g_priv *priv = lane->priv;
 	struct lynx_28g_pll *pll;
 
 	/* Switch to the PLL that works with this interface type */
-	pll = lynx_28g_pll_get(priv, interface);
+	pll = lynx_28g_pll_get(priv, lane_mode);
 	if (unlikely(pll == NULL))
 		return;
 
 	lynx_28g_lane_set_pll(lane, pll);
 
 	/* Choose the portion of clock net to be used on this lane */
-	lynx_28g_lane_set_nrate(lane, pll, interface);
+	lynx_28g_lane_set_nrate(lane, pll, lane_mode);
 }
 
 static void lynx_28g_lane_change_proto_conf(struct lynx_28g_lane *lane,
-					    phy_interface_t interface)
+					    enum lynx_lane_mode lane_mode)
 {
-	const struct lynx_28g_proto_conf *conf = &lynx_28g_proto_conf[interface];
+	const struct lynx_28g_proto_conf *conf = &lynx_28g_proto_conf[lane_mode];
 
 	lynx_28g_lane_rmw(lane, LNaGCR0,
 			  FIELD_PREP(LNaGCR0_PROTO_SEL, conf->proto_sel) |
@@ -775,21 +779,20 @@ static void lynx_28g_lane_change_proto_conf(struct lynx_28g_lane *lane,
 }
 
 static int lynx_28g_lane_disable_pcvt(struct lynx_28g_lane *lane,
-				      phy_interface_t interface)
+				      enum lynx_lane_mode lane_mode)
 {
 	struct lynx_28g_priv *priv = lane->priv;
 	int err;
 
 	spin_lock(&priv->pcc_lock);
 
-	err = lynx_pccr_write(lane, interface, 0);
+	err = lynx_pccr_write(lane, lane_mode, 0);
 	if (err)
 		goto out;
 
-	switch (interface) {
-	case PHY_INTERFACE_MODE_SGMII:
-	case PHY_INTERFACE_MODE_1000BASEX:
-		err = lynx_pcvt_rmw(lane, interface, CR(1), 0,
+	switch (lane_mode) {
+	case LANE_MODE_1000BASEX_SGMII:
+		err = lynx_pcvt_rmw(lane, lane_mode, CR(1), 0,
 				    SGMIIaCR1_SGPCS_EN);
 		break;
 	default:
@@ -803,7 +806,7 @@ static int lynx_28g_lane_disable_pcvt(struct lynx_28g_lane *lane,
 }
 
 static int lynx_28g_lane_enable_pcvt(struct lynx_28g_lane *lane,
-				     phy_interface_t interface)
+				     enum lynx_lane_mode lane_mode)
 {
 	struct lynx_28g_priv *priv = lane->priv;
 	u32 val;
@@ -811,10 +814,9 @@ static int lynx_28g_lane_enable_pcvt(struct lynx_28g_lane *lane,
 
 	spin_lock(&priv->pcc_lock);
 
-	switch (interface) {
-	case PHY_INTERFACE_MODE_SGMII:
-	case PHY_INTERFACE_MODE_1000BASEX:
-		err = lynx_pcvt_rmw(lane, interface, CR(1), SGMIIaCR1_SGPCS_EN,
+	switch (lane_mode) {
+	case LANE_MODE_1000BASEX_SGMII:
+		err = lynx_pcvt_rmw(lane, lane_mode, CR(1), SGMIIaCR1_SGPCS_EN,
 				    SGMIIaCR1_SGPCS_EN);
 		break;
 	default:
@@ -823,19 +825,18 @@ static int lynx_28g_lane_enable_pcvt(struct lynx_28g_lane *lane,
 
 	val = 0;
 
-	switch (interface) {
-	case PHY_INTERFACE_MODE_SGMII:
-	case PHY_INTERFACE_MODE_1000BASEX:
+	switch (lane_mode) {
+	case LANE_MODE_1000BASEX_SGMII:
 		val |= PCC8_SGMIIa_CFG;
 		break;
-	case PHY_INTERFACE_MODE_10GBASER:
+	case LANE_MODE_10GBASER_USXGMII:
 		val |= PCCC_SXGMIIn_CFG | PCCC_SXGMIIn_XFI;
 		break;
 	default:
 		break;
 	}
 
-	err = lynx_pccr_write(lane, interface, val);
+	err = lynx_pccr_write(lane, lane_mode, val);
 
 	spin_unlock(&priv->pcc_lock);
 
@@ -847,18 +848,20 @@ static int lynx_28g_set_mode(struct phy *phy, enum phy_mode mode, int submode)
 	struct lynx_28g_lane *lane = phy_get_drvdata(phy);
 	struct lynx_28g_priv *priv = lane->priv;
 	int powered_up = lane->powered_up;
+	enum lynx_lane_mode lane_mode;
 	int err = 0;
 
 	if (mode != PHY_MODE_ETHERNET)
 		return -EOPNOTSUPP;
 
-	if (lane->interface == PHY_INTERFACE_MODE_NA)
+	if (lane->mode == LANE_MODE_UNKNOWN)
 		return -EOPNOTSUPP;
 
-	if (!lynx_28g_supports_interface(priv, submode))
+	lane_mode = phy_interface_to_lane_mode(submode);
+	if (!lynx_28g_supports_lane_mode(priv, lane_mode))
 		return -EOPNOTSUPP;
 
-	if (submode == lane->interface)
+	if (lane_mode == lane->mode)
 		return 0;
 
 	/* If the lane is powered up, put the lane into the halt state while
@@ -867,15 +870,15 @@ static int lynx_28g_set_mode(struct phy *phy, enum phy_mode mode, int submode)
 	if (powered_up)
 		lynx_28g_power_off(phy);
 
-	err = lynx_28g_lane_disable_pcvt(lane, lane->interface);
+	err = lynx_28g_lane_disable_pcvt(lane, lane->mode);
 	if (err)
 		goto out;
 
-	lynx_28g_lane_change_proto_conf(lane, submode);
-	lynx_28g_lane_remap_pll(lane, submode);
-	WARN_ON(lynx_28g_lane_enable_pcvt(lane, submode));
+	lynx_28g_lane_change_proto_conf(lane, lane_mode);
+	lynx_28g_lane_remap_pll(lane, lane_mode);
+	WARN_ON(lynx_28g_lane_enable_pcvt(lane, lane_mode));
 
-	lane->interface = submode;
+	lane->mode = lane_mode;
 
 out:
 	if (powered_up)
@@ -889,11 +892,13 @@ static int lynx_28g_validate(struct phy *phy, enum phy_mode mode, int submode,
 {
 	struct lynx_28g_lane *lane = phy_get_drvdata(phy);
 	struct lynx_28g_priv *priv = lane->priv;
+	enum lynx_lane_mode lane_mode;
 
 	if (mode != PHY_MODE_ETHERNET)
 		return -EOPNOTSUPP;
 
-	if (!lynx_28g_supports_interface(priv, submode))
+	lane_mode = phy_interface_to_lane_mode(submode);
+	if (!lynx_28g_supports_lane_mode(priv, lane_mode))
 		return -EOPNOTSUPP;
 
 	return 0;
@@ -946,12 +951,11 @@ static void lynx_28g_pll_read_configuration(struct lynx_28g_priv *priv)
 		case PLLnCR1_FRATE_5G_10GVCO:
 		case PLLnCR1_FRATE_5G_25GVCO:
 			/* 5GHz clock net */
-			__set_bit(PHY_INTERFACE_MODE_1000BASEX, pll->supported);
-			__set_bit(PHY_INTERFACE_MODE_SGMII, pll->supported);
+			__set_bit(LANE_MODE_1000BASEX_SGMII, pll->supported);
 			break;
 		case PLLnCR1_FRATE_10G_20GVCO:
 			/* 10.3125GHz clock net */
-			__set_bit(PHY_INTERFACE_MODE_10GBASER, pll->supported);
+			__set_bit(LANE_MODE_10GBASER_USXGMII, pll->supported);
 			break;
 		default:
 			/* 6GHz, 12.890625GHz, 8GHz */
@@ -1002,13 +1006,13 @@ static void lynx_28g_lane_read_configuration(struct lynx_28g_lane *lane)
 	protocol = FIELD_GET(LNaPSS_TYPE, pss);
 	switch (protocol) {
 	case LNaPSS_TYPE_SGMII:
-		lane->interface = PHY_INTERFACE_MODE_SGMII;
+		lane->mode = LANE_MODE_1000BASEX_SGMII;
 		break;
 	case LNaPSS_TYPE_XFI:
-		lane->interface = PHY_INTERFACE_MODE_10GBASER;
+		lane->mode = LANE_MODE_10GBASER_USXGMII;
 		break;
 	default:
-		lane->interface = PHY_INTERFACE_MODE_NA;
+		lane->mode = LANE_MODE_UNKNOWN;
 	}
 }
 
-- 
2.34.1


