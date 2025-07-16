Return-Path: <linux-kernel+bounces-732920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEAABB06DB1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 08:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6A701C21C33
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 06:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1345A2E92B5;
	Wed, 16 Jul 2025 06:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OVd+1PJG"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013037.outbound.protection.outlook.com [40.107.162.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F162E8DF2;
	Wed, 16 Jul 2025 06:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752646303; cv=fail; b=oXcbrz2UbukKscq4trdpIlDEWkvioewH9JNxVt1RUQlTfTiqSDliTy2KkbuZoxs3IMHNoBpi2fvLr9TCSTgeqVQnwKcIyh5oDm4TNmr/mgBOFufAHeTEslTQilJLvXjrRDeZJbCRU8kkDg32go3nt05g+DLl6EPb/brcm6TAUwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752646303; c=relaxed/simple;
	bh=ylIFX1sht8nsE7QvPf5tguVph0w5bIlhYDTW3Sj9Zag=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FykS2xFtkEGGwb2Zywle+yn+43g9Pxx3PZX4gxZQG6DQDgaEJdfQEAszqCHG9J6YtJnCPe2D6KhY8OkUUgijbaNCX3QDsXoxw5yHIEfUwisZ4OB0o9V8fNVkC6SNmHd6G4SwODKrdy6mqdwGR0aYdz3nNpcZOW03Jpv0yBGTHeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OVd+1PJG; arc=fail smtp.client-ip=40.107.162.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sYgLAzgY6fvLxhTndyWfcHh8o8ehiGV/7B/ocDXt+EWhhcONPeR5d4ynyPUzC/Gnku2Ql0edD+YIZiqU0zE7x+2pakGkfGd+Con/B7WuGRBZ5uXLxgeKPDcSeQNf4iqxKBxL+8tJBRYVwE5FglVKKp7Ri+M+8sZFb4bkipMPF8V9oTPY0Cckc15hE1LDuHcwuk4LRQl47ROpa1KUXNTFu140aBjbiqJFch9D7l4SoEZEDp6UBHTHaHscUv7tENFUyrHwFgbWLZDWlVi0iOmXL3T1DhGOxgb5aru0zJMLyKzKWxEuTo4wMd8PcpFUe06zpd8gpuSM0wIpVzSFUs88nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xupCB8CX/FsXMXjDbW//eTLV9YPyw/V3BpkdU+p0dHQ=;
 b=ZAZGHD25gsGDokNnvdNLiiwV68tVZ0VQFqExT63A9+I70SOS18zhHFteRGPdpFKtdB1sEj1o2WwhEJtHJybk9m8Y1vD0bhSXSGH3UsaZdHZWhcsCWoFskdb/FpDFiRCHcdlTmIfCsCZhLdHVKR1ZMNEBDnVvpqUWcyzJH2l+o4IWEaWcxsQe4Q35/CqjoGBx7unHv1P7aAoOTkrPP8zFatMvZKtuauhtXPAL3AU0PW4Z3d1uSTqreVN7VamakMLitoOnW4QB32206u8cLLfoNNbUiRBsWapP8ca9B0nzrE86BS/6KAVFIBsVyCEA6Lo8WGdybgZ/EUfgZwKnE++IcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xupCB8CX/FsXMXjDbW//eTLV9YPyw/V3BpkdU+p0dHQ=;
 b=OVd+1PJGVF5JxQH8uRAWQG9w7k0dH7WWKCvezcUDgzsqZJNAhnZ3XREMVy01DEiw0+nwzoPHPityX1DRhgfTsrqZNsDqtgnrJqofOGvuu6uek30eVsZ0eS/xGQprD1cZe3fwxjJCvhleYjwvqlJxo/C9CsrnpSZYJ4w4TBLyZ+8FkZlkd4u1rnGQksfv/JpAgdmD9lSU8Y0BZe04lBlbE8eGolUVKES9DCWed+FDgiBtE2QbtSfIDhnW9ahpXigiGS8fVVFAmNPTVCv4J74Gpzbd0N8/cIxts9E1iaCQhHVG83mvMamfXH2up8HEQD+ahAfwVRS1ESCJqgI7yaqxhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by VI0PR04MB10102.eurprd04.prod.outlook.com (2603:10a6:800:249::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Wed, 16 Jul
 2025 06:11:39 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891%5]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 06:11:39 +0000
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
Subject: [PATCH 1/3] arm64: dts: imx8mm-evk: support more sample rates for wm8524 card
Date: Wed, 16 Jul 2025 14:11:12 +0800
Message-Id: <20250716061114.2405272-2-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250716061114.2405272-1-shengjiu.wang@nxp.com>
References: <20250716061114.2405272-1-shengjiu.wang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: a1269045-c32a-4a5e-986d-08ddc42fa05d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|52116014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GRd71GU7EJzmVMuQUY/rRSBYuSqU8mXcv/YccEeJcJGawxIos8CPXWVh7/Vd?=
 =?us-ascii?Q?cakG4kNTFvtZF6QcS6eR23WN0kaXuIaikagPuYt5EGGVlRg+9C/DTbGrPk/8?=
 =?us-ascii?Q?WwEGLRexlIwKL9bao10fkicKFmSOBkT9Cd2qw2UdYl0D2HzpgBK0B4yc+a88?=
 =?us-ascii?Q?tTXYG3oDbtsm6P2h7M+sKuLZyPQU2L14ZIB+KERCgRL6SETzU5IktBz5TY1d?=
 =?us-ascii?Q?T21RlL5hh816dxpJDQ9NqP6qWTD7ISD5J/NDgtUpy6Wlv20zwYL21AXTGcwb?=
 =?us-ascii?Q?Fhk2V51b8oUTYbNffY/qwQ9uqklGaghDlZeNUHA2c7EisrxKhy27qmxaMjCH?=
 =?us-ascii?Q?TG4TjbQeYE0zjV+IpBRoIPOSdxh+YDW6cG9gjcum40LCXCEORDqquPmfexXd?=
 =?us-ascii?Q?NICO/l9fkSArE3YHFFCLS7Ph7Qpl4Pb+H2vTyRtuINUJjpz0pva3CRp7f5IK?=
 =?us-ascii?Q?VSSnnCpkiLWxPxn0phG6Yy8Qqt1OniJ5Pf0gBVuyZWcTZh4ATUfSlCRlL5Bf?=
 =?us-ascii?Q?EeFFtRyvlPEfz9ts4oatVALspdQgFjLVjlsF+O1eo7BnaYqZ/eonS9v5fivU?=
 =?us-ascii?Q?dIRCAHb8qeH3PdLC06/zEKuKFXsYA3kOwG6nVjlz5ULlifssUArS2wlGAapI?=
 =?us-ascii?Q?MOvbKn39ORLHoi/8QorfoMT0fGke33mhzJRLn0pgU8umXiLUnT9sF5vlAB9q?=
 =?us-ascii?Q?FF918u5ppwY67bXk2RxohF9XRrX+nckDKOdoX5VT1PeTNuelTmDYGmaNHVBS?=
 =?us-ascii?Q?V5wkQihQ9H1teLEfhxQJEqv4Tno1/PDSgxOUf1pw0HTN4N3ANeZbsNTDJyCV?=
 =?us-ascii?Q?59UUvnVha2SueubVlE06SUKw8Q50kVTAYkJu8xwO81kqWVOw1y4EHWtxFxJT?=
 =?us-ascii?Q?Q0fj5ZMqnozMXnC+2ckeVOFVVQMG/x8O8hyiDnvd2MRfif1Gn7SMpPzOYMzW?=
 =?us-ascii?Q?4rKWKVwroxW47CC4+6R/8MzQj7MkSKuMhq+8PPsoV0mtTNMKU6sbsvfnDMMJ?=
 =?us-ascii?Q?A4vqW98jP+ek37Q3whtyydv93MERIgsxHgDlCdedqf/JqdQqO+kSf7dWtnwj?=
 =?us-ascii?Q?IpgwfkpTm3crrvIhbtSwT1QqFhRHU5ZBLf0lorxPoXn1q2obj7B7qvcSUjSY?=
 =?us-ascii?Q?eSGxmq2VkQge82Klry5kX1v8WSdgBDaKAgDF7PcdCU4pt0M+ep5fHhoFWEDM?=
 =?us-ascii?Q?S2AmRkHH7kFmxhWkRWFzvfn+naqXVBxu1AvFGBPwZymg+QtRx7b5kR5jf2eK?=
 =?us-ascii?Q?vufIPW37gaz6M0C1pd87ZRsAXzOTaJeJH1ByObLN9fkj2K+AWVOCPJymjWa9?=
 =?us-ascii?Q?NvsymLIDT40/gToRYDRoIVIzclrrCGNFNymFR1Nv9ev6MG9MECaaZIgODTfL?=
 =?us-ascii?Q?5fO9uD8+0iKkdkXBFiNxkAyYiTBh6x0RwWK1XXIgU2ZJSxNuIammcOWrh5TD?=
 =?us-ascii?Q?YUKHaZ5uMmeXcmb26u5yEWKz4edJ83nvE4QX19Z0XJ0GWQ40WvIRgO4fimKV?=
 =?us-ascii?Q?pyI+Ql1cm+hZwxA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(52116014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lVTBl8+UVbbQQcoQFz8D66yJ8iHbWYbVDBLqs+Jc+RcbkBLHSzin2HLBOQIZ?=
 =?us-ascii?Q?mMHQZZwsHyrJio2Eg1mhulLy5Iw3EPvRsPZDLbOQSAGgx8f1o1AvyqarF5zb?=
 =?us-ascii?Q?WDNhLSALi0BRKF0aVbCrVgQ/ouwgK88BjMXIeQP/mK8oJWNwLCTP+6cNL8d4?=
 =?us-ascii?Q?MK+3i8FA8feNwoWa5xYYC3VCALjgTAsN/x/cG9xK2OkYsR9tH6y5IX9xC6E9?=
 =?us-ascii?Q?TdqhfECvOPZKecxq3nxq4N8TBpUNh+7vVVx+0nCC5E0TTHKIutZoiOyPM0Rm?=
 =?us-ascii?Q?ajuStspIW/1ozLnKlpCEDR35ssW5nySYyJySSqOUGOvOLTpdE7dpJSoUzFT0?=
 =?us-ascii?Q?ztx5ea+gZosqW4OYwmN9a0c0yqBcXEUMzJIuaP+eJoH8/7jLc/Xv8AYWIVl8?=
 =?us-ascii?Q?F0K0n7RLFTexkJvteTLrJKLKltppl9cKSOebQsriAiNuugv7jKxMIyvQQf61?=
 =?us-ascii?Q?UTMrV68zREXlfwHBZMnbAeoyaExBtkrrlg0Pp2Lv+9g2JW2dv/26vOFXpMEu?=
 =?us-ascii?Q?y3qcBxEgVHwAmY+/sDFlcspN3a9656q9AXJkkGoBY4cAtIeGBsMNPJ01pHa6?=
 =?us-ascii?Q?JpR6noG2KkZuWQ3EDNUW8dD5lXrB+kA18qdhNEEGH1EsTFz4kJJGzAP+AaT8?=
 =?us-ascii?Q?WsaS49l92EXlaE0eI+KaQpCoqzDVqPsoa5+TSv1intg4g1rkJC25IrPqZlEl?=
 =?us-ascii?Q?lZVTqX2KowMauyeqNdk1WV3NBuTh/r02nBDf130VNhYvRqq4YQB5SBbuY7Eg?=
 =?us-ascii?Q?za3LWS4rly93GSTl3gPiGA7rnmF8jBezHUymGtavzXe3EEaJ4eVGNLHHT9Eu?=
 =?us-ascii?Q?lMAhUVKf7c7K0pQAQBqAW3sBltBNImFf3Ni86V3AA2JAcICbb7j01y2rPPoh?=
 =?us-ascii?Q?+3ZuUzz8rvVsD+TJhevNjr0Ly5dCk+TYMXMlYhp7DxEMhWP2114S/qdaSwOA?=
 =?us-ascii?Q?HgCrKtK0YJEFcVbZeMHF571O8XRgMKkMG7Y2Fhm7xxc+Hp8/x9dJHfXqRp+P?=
 =?us-ascii?Q?raFndINfMvS5zBbfPWYhzc+Zjx81Xx7PwoTJpdXCjAgWFeQF74RyqaphrxV4?=
 =?us-ascii?Q?vSmVnYMvS6UcdJDvriGanmucWxGEHBt74LaCnPUEoQpnOU4x9XfQTV7gdkBI?=
 =?us-ascii?Q?DJfBJSFascZXHVc105+gmd7T5+pwCpxirsz4iMuRl8FWjzGCSrPnCkkRJ+Di?=
 =?us-ascii?Q?Cl5LJh2lEW9BGPyZ4L/5szUBvlm5qcjhRaZ2R/2j6N34Ru37d6pgg7YSGvdb?=
 =?us-ascii?Q?eLyt/t9vScHxYDbmchw2K0SLc63q4AKjXS5rdDO9cDtxM2U0MVDaIzhzMhY+?=
 =?us-ascii?Q?e8sI3MU99p3AMZNiK4xFn4VK3c7FgtISdJgFQhXIH/Cu84maguTLWhJhMN0c?=
 =?us-ascii?Q?817JfCgqXeqUs2WIxvJBVGs97u/Oo9TWIjWbSLJArGTPvb9WC05Zsauts1Me?=
 =?us-ascii?Q?UguTfKWtShm+S+mEbXerZUR+EeRpCcOakNrKtcmKJfaaAcKaQi5cvuyO7kMa?=
 =?us-ascii?Q?JDP90njUMeo2jT5BhTm9iMQLvjvPvOHvuZzH4I53JRMeMRxaZFnTtUZd30ca?=
 =?us-ascii?Q?sJ8Po9HgK7GKqEyy3HBfsOubOxa3/qDBy3IqbXLx?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1269045-c32a-4a5e-986d-08ddc42fa05d
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 06:11:39.2066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7OSITWto56i7a9uc6orZ53AqQRr5YTPyaNOJvF3KiwKouS8J42ya2Dr8KSi//I2/DBXtEKcf9ax1j15Hablrdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10102

The wm8524 codec is connected to the SAI interface. There are two audio
plls on i.MX8MM, one pll can be the clock source of 44kHz series rates,
another pll can be clock source of 48kHz series rates.

Add mclk-fs property for the clock ratio, remove 'clocks' property for
codec that doesn't need to handle clock enablement, add
'system-clock-direction-out' for clock is from cpu dai.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
index 622caaa78eaf..ff7ca2075230 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
@@ -147,6 +147,7 @@ sound-wm8524 {
 		simple-audio-card,format = "i2s";
 		simple-audio-card,frame-master = <&cpudai>;
 		simple-audio-card,bitclock-master = <&cpudai>;
+		simple-audio-card,mclk-fs = <256>;
 		simple-audio-card,widgets =
 			"Line", "Left Line Out Jack",
 			"Line", "Right Line Out Jack";
@@ -158,11 +159,11 @@ cpudai: simple-audio-card,cpu {
 			sound-dai = <&sai3>;
 			dai-tdm-slot-num = <2>;
 			dai-tdm-slot-width = <32>;
+			system-clock-direction-out;
 		};
 
 		simple-audio-card,codec {
 			sound-dai = <&wm8524>;
-			clocks = <&clk IMX8MM_CLK_SAI3_ROOT>;
 		};
 	};
 
@@ -570,9 +571,17 @@ &sai2 {
 &sai3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_sai3>;
-	assigned-clocks = <&clk IMX8MM_CLK_SAI3>;
-	assigned-clock-parents = <&clk IMX8MM_AUDIO_PLL1_OUT>;
-	assigned-clock-rates = <24576000>;
+	assigned-clocks = <&clk IMX8MM_AUDIO_PLL1>,
+			  <&clk IMX8MM_AUDIO_PLL2>,
+			  <&clk IMX8MM_CLK_SAI3>;
+	assigned-clock-parents = <0>, <0>, <&clk IMX8MM_AUDIO_PLL1_OUT>;
+	assigned-clock-rates = <393216000>, <361267200>, <24576000>;
+	fsl,sai-mclk-direction-output;
+	clocks = <&clk IMX8MM_CLK_SAI3_IPG>, <&clk IMX8MM_CLK_DUMMY>,
+		<&clk IMX8MM_CLK_SAI3_ROOT>, <&clk IMX8MM_CLK_DUMMY>,
+		<&clk IMX8MM_CLK_DUMMY>, <&clk IMX8MM_AUDIO_PLL1_OUT>,
+		<&clk IMX8MM_AUDIO_PLL2_OUT>;
+	clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3", "pll8k", "pll11k";
 	status = "okay";
 };
 
-- 
2.34.1


