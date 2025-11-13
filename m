Return-Path: <linux-kernel+bounces-899222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1FCC571E7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 12:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 65E184E1574
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 11:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D6633971D;
	Thu, 13 Nov 2025 11:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MSnQK54w"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010062.outbound.protection.outlook.com [52.101.84.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1713385AA;
	Thu, 13 Nov 2025 11:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763032451; cv=fail; b=BUUgcLrAvCF+g5i1q0YTfSNJYnJvRvHHHW9fLm3/bA75gUJRKpmoRQBAtfZr3r4MCsRbp/S5mOrumle3O8Z1T3sOwCHkmUK5qR0i9l9sf263O6zakyy61VKMgk0KweT7vnlHL+mF4mtMkMKHG0p4Q8LciT54bIztEDShOrL1CnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763032451; c=relaxed/simple;
	bh=fG66ZqAWHzbqlMBm47PCxt4z3DwT9a7u3xNy/R0cAiQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=CRKX0Qbjbzs3ba99KteX3jYBQq3F070w6c/AYdzsg6IvbO3Vs/lZvXVXYUJo4F1xZDX/ZlsbCmzRmB0D9+6Krl/jQE1TOeOsfyB/4TVoD1s1YJBgXX1Sd8RAGl8u1XX2rbKVEpjV5WjwSNPd70hE+3FTvQvBubKObp6mcILlj8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MSnQK54w; arc=fail smtp.client-ip=52.101.84.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=va36n8R5MGj+f0y49gfAoGwtmf9eNyepS6SnthYRlbaUGF15O0PcF2P01A1clXaIIHbJymcw7sJqfIxZGdmwmkac3AfFRp97fRM0wqxUx/ZG74meff2J3iRmf+asjyYdrSTcImPECaA3Hy2VTxXBSy7YHYFu8jeziiy5o/DWYS50/SOxa1hMSZ/kSEwdnFYuZUXXZIOFn0A5uZ2Z0wwd8ndNyL0JXadQGJ/n2AcJrtrhbLamoDn4PXge6Yy0BueCmQ2rBTRKg9WdBHZLjoWu/+t262PCKMSSMgUMtIVM+CRMsUehUxzGRs7OzVa3q977cKz3qN8UcxL3gs0NHklw/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NOGtHeV/XIznJClnBPJyTKkum40plAFpbiIX/+fF19c=;
 b=Yp9CacuZNpvhKdfXyPJRuf5S6DcJPygJj9SnVnG3b8R4dvf9/U6oAmu5bDI/DiUh54lQBjtNdvUdTs+yIn9DU3qVKVhAYbWp0upTayeDGwLULURW0QpjqE1oiTYkMVZ8atrccLuf7TzRCgavopKMjz0F4AgTaGA5jyMzDAvR7cNv87KsB7PUvZek7BSPIn4IKMrFC0zYQCoJSXqvkqWxnttPlBLpfl6sc1FRQsaCkEDVza1WEAug+3lb2UhnxkMJlM5Fvnqn1dxbGi1+jL+S/skqRzS508FUCorwtGV8kgN2EHqIBYYgQeNoorS9OHOoRpncF+BPsj9I0zndCjxkCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NOGtHeV/XIznJClnBPJyTKkum40plAFpbiIX/+fF19c=;
 b=MSnQK54wRGv/yflSLjQ4/lEVAus8mUbVjvs2BUrdpPL7Qkyph0r6SFwQ+E+APoES+9hnPo+7P1NeEoLUyqSe3rOpngQ7UftJtRx0VN5jyo/SR6zx3tND19YFzQNJloV85UAcd8bDYkx9fysoJ4pbz8ZDMU52RHbFaCA+0I2HTvc85Evs05RGlFDiTT0v5c46DG1R6LUGTwaBECCEThM32aQW+pQgZuaRFuKIFkUJn18aZM0Z8jLTps7faojx+EYp70JyOUQlNVzVQQ5Cy+63A/35XUDUge3mEZqNnZWtU3BRLJ8YyYu017Bi1wXz1VA0mnYxFZkjFt3FL8x1IGyixA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8825.eurprd04.prod.outlook.com (2603:10a6:20b:408::7)
 by AS4PR04MB9364.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Thu, 13 Nov
 2025 11:14:03 +0000
Received: from AM9PR04MB8825.eurprd04.prod.outlook.com
 ([fe80::67fa:3e46:acd8:78d0]) by AM9PR04MB8825.eurprd04.prod.outlook.com
 ([fe80::67fa:3e46:acd8:78d0%3]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 11:14:03 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	Frank.Li@nxp.com,
	jun.li@nxp.com
Cc: devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: imx8qm-mek: fix mux-controller select/enable-gpios polarity
Date: Thu, 13 Nov 2025 19:14:44 +0800
Message-Id: <20251113111444.888985-1-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:4:194::18) To AM9PR04MB8825.eurprd04.prod.outlook.com
 (2603:10a6:20b:408::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8825:EE_|AS4PR04MB9364:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e83ec15-dfe3-4743-9c32-08de22a5c088
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|19092799006|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HLKaMJhvDmzNIswCXg7Abcm1URPFBKf2pZO6xu9ibDN6+x6VnCNzu2WGeEoO?=
 =?us-ascii?Q?Bs2wxsigI0ECVmusfg5ebeeC9oQZIjpMKZaisE+6sCiawYE4zajZqZ1Xm3+D?=
 =?us-ascii?Q?d2gYedrAxVsfv0t2EaQift8WHShxSsAe0F6vc0av/NPeOF3GOUeLd1R/pd7N?=
 =?us-ascii?Q?VGNMJEgcwvdO8oAGqHGKLmo+RbtfWCED2uo5JFqQvqqpH8zdE/mUtbZ9aBLL?=
 =?us-ascii?Q?VJd5dQehjV33rQ/ppfMpcR0HQOibgPnJXibxPoBT4pO8lvXigcAztsDfh3ut?=
 =?us-ascii?Q?RuO+E9qvhrGOWa1k3RgIrr4mRuGlRwkwN0HaQkpdQgJsVVMatqkFyHs6rlyf?=
 =?us-ascii?Q?iZTZ3yrLb3fbMF1FPB3AyOZikEOdjfjRT5g9r64l0dJT+Zvo3/pn5ffvyXZu?=
 =?us-ascii?Q?1BabnhQAWodM1gKlROhKpFwbkX4PeMvdV41SnO++d9Vx3gARjMhF6jyKiTg3?=
 =?us-ascii?Q?EA+uFkGZ5dcFIrWRBmaCd2UuUP8sAcF7QWZW1UZJFz1ecD6nzVaqAh84FCsf?=
 =?us-ascii?Q?mMKvRJLmtPfhCTKNo77UYPy7eEiIRP9zvoIa7Zsyimu/nPzm3L6gSCo+b/rR?=
 =?us-ascii?Q?T/YF8W8+OTzjSz79xvbJzvF27lp/SsJhkETxQEpycjbQRhORbFe8dhfWdPuu?=
 =?us-ascii?Q?96WqHrfvOUDK77s8kTTJ18nG7A4U/vyGRZjP4oG2CQDzSLfFd33UO+8Bq63e?=
 =?us-ascii?Q?C/JfIQe6SvvsPPPo5guE8kn0n+H99r3K0lIIn3M8VwyAKOnMO8oi43ADhwe+?=
 =?us-ascii?Q?vaKzfI4kHvQvyxSxtzPAGmtGr1fqT304kQoXbcbztUE/2FtjSDIgrsz+QgMe?=
 =?us-ascii?Q?RNcL91j1CsWFf9GpZM05uRrlU9AY9AZQETk+Q2ARje4eofqXqWQZTa62ARH8?=
 =?us-ascii?Q?3Y4IkqmfjTRP2AUW57PosJfPPhhwXzgywdTtCuDfhU+9KoKBWPd7x5t8J80L?=
 =?us-ascii?Q?RrUmr4dxrU51c/ra+aMQ26Jb7Bs5vMd2Bq8MXyiKE+MkA8rqY0OCnDh8Ijqq?=
 =?us-ascii?Q?uu0A45W7dZ0QxituN4ZEZ3OR1nxqfXYiJ/2xco/jaVbWNX6SdGi3gPTO/JSh?=
 =?us-ascii?Q?3ucPRlErQbVW6WhCqUU1LuA0zYopJ0GNDDbwRefWzi1cq3lQpMaKw5/SXidj?=
 =?us-ascii?Q?BbJfM00Z7f59j5DylrLjZY0bRC60v0VJBoGihRSUIJrMDvbmge1/RSEUYG1g?=
 =?us-ascii?Q?XOqPWO7xri+HlrnJs+Pan7qufRgwNc4tr6Q6+3hwRKY9ARnvLscKzn3wDwo3?=
 =?us-ascii?Q?IgZo2VDPc3JLkAHVMZ4fMo3XPzpIaLU1SaHqsYMStHPWLArB1vjfCTqvMbZy?=
 =?us-ascii?Q?BZoaGfPEDb0i71Gh1suv4fkDsvXBTznB4hbu3B09l3ivGXY8ce9W0Wg0IwGz?=
 =?us-ascii?Q?25oU3ulCZliLcC/4/ZoW1zM6fgcO+8Hotz3hoBDpzC6hMjxnkDzAC3CHyyUk?=
 =?us-ascii?Q?Eu+/3nyrGwWHv5UyN2vZM3hBQfbf7FupkRkO9/p//iNSSOFbIbTuOalVgmct?=
 =?us-ascii?Q?xQcU79lKL9LyjMBOC48fa22RpQ591VToGt7j?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8825.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(19092799006)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z/n2c0zOQIbSANVhFh0n9fyhq6EdxBKnXBlOPL8DsL/UF5I9WNzv7X5efYBR?=
 =?us-ascii?Q?ue0/ezaC1A4PJY2zr6nZXW9yDq5uajj5RBmMW9FXQWUOunTEGKHZHchZ6k2r?=
 =?us-ascii?Q?nSvROnSXVkasnpLZc30GOIJc1Uqtb8ukQz2K5LDvQZcgkU5n/l3R/qhX+4Qj?=
 =?us-ascii?Q?d2Gas5RP1o9wcpcGTEG3ZDNG2Sh77MLJL99EJ502M4RQ1QZLQLqQ6W7fC2IH?=
 =?us-ascii?Q?Wdgm0yTKNCbuSrhui/88j1bD/9ZRPMP7dJ5X5VmkA15nhEZTFuNyI7HCSpkP?=
 =?us-ascii?Q?sAeh+H+rHrKP53Wvi2przMpmcCtqILZaWBSS+sQI4hjmIahHvYMf65lVROMk?=
 =?us-ascii?Q?0BGla7CD6dj8z8RfQPhbA3IbiNW3zzpmgRU9x0CKWkH8i/zC25znMfVjImBp?=
 =?us-ascii?Q?X83R/1Uu3+FtUBvHIqgGSeK4Ycm3ilemFEFy1j4N0pBlLK16nVhVz9H9/44E?=
 =?us-ascii?Q?/TLuWa1r2cEXSz1KvlnJj3+8gbZ05/KG/b3q51KYOxVO0EdihpXuClUz+9g7?=
 =?us-ascii?Q?JqrZIK7UuSEc2vkDZpg5zwqs2JRkqoyxc6YBvg8V6HpedHUIal1ageZcTRYr?=
 =?us-ascii?Q?iHbaMG6Xx//xDTCKtQ4FvKzeByhf4tdgcVPFpLScsybzf5ceGh8XO4y9AETR?=
 =?us-ascii?Q?6JCc8BjPPMZr8iY3Y/p7PMtCoyvOXMrVxoi9PTJYAlZgIzc15I0K+YfYIqgu?=
 =?us-ascii?Q?3g+NI5QmgTCamh8zZbJMC0EIsWDHyxTnzc2YLx7ZNrRv0zDxqeulN/iTJ7q4?=
 =?us-ascii?Q?hh0KnZjiT7AONOiN2UPOHMfkKxk0HUR/45KMJDjpPweznn2k6auL31b5q/Br?=
 =?us-ascii?Q?LVpoJ7BAnS9//5S9YoiLo4+J29mmOnKPhE8fcFrtAirBj/f2wv4bImD+PhdH?=
 =?us-ascii?Q?TyPCBqaAjcWZ77ffiz7GMMHnR+3cDA30eVg8K1QKrgIRecXo/MhY1vCgMs6/?=
 =?us-ascii?Q?MJzJjhXeXyHsWRyNWnuTVxzXZVz6poPAPoNWxYdO6RitlldEYq7VQ47EnBeL?=
 =?us-ascii?Q?TFoG8NUX4d2lnjsdMYmVMPepwQ3Mf/EndLGbnbPa0iyNGd+rBb6YqWv3tkCo?=
 =?us-ascii?Q?QYknb1mH7X7X0++1diUmYA9osrLvIebdySVutTouyRfnCYYsB8a4bfdPExq3?=
 =?us-ascii?Q?Tn0sHKvVnw+pAKKmCADIWpXSr3lpFm+aP6onawToOj2Z7229JtZZEjeMm2ob?=
 =?us-ascii?Q?ThzB6zzCrTTPeBfRybMe3DxacCJtYJhtiYfVz1CX9NjPanCEMta8QoghwFO9?=
 =?us-ascii?Q?X4FLkDB5616K0dHEus2JYOvGIB1A65CqbRpacFPNl8dxE/A6/smtyiVzrI0G?=
 =?us-ascii?Q?rfWELytXoDxPbcSdxq/7bhxP4hC9nx9k+3pzOfSvQQcjGPE4nSlbIBBBGhak?=
 =?us-ascii?Q?wkHckO8eEk/bOZ8ij6ApKdyHx6kIcooZhqH9wploLW64VG53GIJzFuX37mVi?=
 =?us-ascii?Q?DTj0V73odldA70G2dYTRYROS5ZS1dVTAOR+/D5E+oBGbhl8p2U6tDUuouAmR?=
 =?us-ascii?Q?xTcvgFAJhkiNumtljVW4ldpXd3vjhYTSgC366z8p8BuPFYnysb8kuVUy34hA?=
 =?us-ascii?Q?1RrXMWeHeqe05qxtFOq8dqNtE8R+UjQ8PKzgY3bx?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e83ec15-dfe3-4743-9c32-08de22a5c088
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8825.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 11:14:03.2071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jl+LU7ZwytuqUw+IucmgnA1Seky1Wpd/261ztpHgPP/cof8bzE0KZreVNEBHIsiwsn2zSTf7aeg5HO+hiV74cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9364

According to the board design, set SEL to high means flipped
connection (TX2/RX2). And the TCPM will output logical 1 if it needs
flipped connection. So switch to active high for select-gpios.
The EN pin on mux chip is low active, so switch to active low for
enable-gpios too.

Fixes: b237975b2cd5 ("arm64: dts: imx8qm-mek: add usb 3.0 and related type C nodes")
Cc: stable@vger.kernel.org
Reviewed-by: Jun Li <jun.li@nxp.com>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index 202d5c67ac40..9c0b6b8d6459 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -217,8 +217,8 @@ mux-controller {
 		compatible = "nxp,cbdtu02043", "gpio-sbu-mux";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_typec_mux>;
-		select-gpios = <&lsio_gpio4 6 GPIO_ACTIVE_LOW>;
-		enable-gpios = <&lsio_gpio4 19 GPIO_ACTIVE_HIGH>;
+		select-gpios = <&lsio_gpio4 6 GPIO_ACTIVE_HIGH>;
+		enable-gpios = <&lsio_gpio4 19 GPIO_ACTIVE_LOW>;
 		orientation-switch;
 
 		port {
-- 
2.34.1


