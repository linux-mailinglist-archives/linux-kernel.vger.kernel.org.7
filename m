Return-Path: <linux-kernel+bounces-798517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C026CB41F1E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A6DF7ACFC2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659D53009DF;
	Wed,  3 Sep 2025 12:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="qIXoPSGc"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011060.outbound.protection.outlook.com [52.101.65.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F793002C6;
	Wed,  3 Sep 2025 12:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756902862; cv=fail; b=X+FIP02B1b0GYWUNMRGq09x0eZuD+0OfL+0R7n3csmplilPxSM9i+sBfU+qXh7Cw96KGPzthUQ+vtX7f1u9QeG+WA1txsj8cYmHIpOHs6WRsxdSt4Oi+k3qJT1RsLimKuBDtoQ0BEu1wvsIh0CdLKP+ZQvc5z9E0YKOpU8zzGLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756902862; c=relaxed/simple;
	bh=/bXQIfbcSZ83Dh7dAf2+mrw2OBVgHHCQSb00htHTyZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XoGNrdCoLbrE+De3ygLJ2bWHLUV49w3G9aaTcxu43D4zysDfDFGmVUsmkNyWipUNSSRAYW9dpuuhD7ow1WuVbRCLSfyIk/Aynsc1hwXK/iyNzlUvwVNTbhF1v+y3QL5aHhU9TF1PrEtE/q3T6mf/PFOU4nY3PFcY58or9psmN+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=qIXoPSGc; arc=fail smtp.client-ip=52.101.65.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w25c27zN8MH/DvCSws6tL5+WW80NxqjXKXxRfQkG5wbwI8Jrn9C/G5k/ziQCxIaF8O4cGvO1N8l2y08WDX/mfKBYXxDisgFRmNJQRIm2uQdpWiKBKsyL5ziArR6gVcN/GukHeCPwi/ajaTO/JhtBcW2e48vApLjwv4D18hQXrvOYIt97S1ryqTU/msmPEgSpw0sdoaQGjReONJRwZLXh1EUlyX8fbLksSyN3XyhyOAauReMWbCaHCSFA1PPyFwpFrm44OWYJRRYvDy1qj2reFaNdeHaXEVgPDq50Bc5iGxGBBSQ+Hu/UEDWjUJ82XUBWnAWOqW1x0uTRwSXUqSkzig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aBcQZkZP3ZSJeXLm7DZuf+5QVEXu+I/XZtZSUW9EIv4=;
 b=pjoL+BI9zRjCOnLhlw9MRSehSY5IiwiStu5IkvpK8pOAP2v9DYhXeuccHfhByLgt8RmgN8kspXgRSXhmjWeTkv6FPJVkKqDYa5sA+mwgWjK9ELcRYUKDhQSq1Q2TA67HOYyFMculf9QSKlv4St1u0MSGD+qJuDTmoCR1wVAf1qGBbRX54B9mv373bQq+4bcguFCnIcVR4GN6kcesOjM2JdSSEon6Snc4PGUhCM+g7B7Y7/2T4UwDSmzG+Wm8R2S/D4liLlE7N1hYzFA9z+OYiWXvPK67ens8P6i2yFVCE48FrOiT2ExEF1pbK4VXmsZOo5Hw4JyVaRzt/3p7ZNhgRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aBcQZkZP3ZSJeXLm7DZuf+5QVEXu+I/XZtZSUW9EIv4=;
 b=qIXoPSGcxTuc+0BQaSa82WYOAFAMe5YqnA98NPUr0ccCBn9gpjKHKljUPRrsZL/msc7CKlPp5bC6AZPNMDaplPirFD2D8yqXgVcfSURwVVKG+tPJCS6Ht8bUsaDgkiexURjWiOLbT7JsBJ1f3mN7p1EAdzoorv68T/0gtTBP20HQUZ0WHPjW+dlRKJXVvpJZFX8g5Y+InW6SR/z0QeeOHvtlRKPfrAJcUimoDQ/HHVyt5jXwEcBtg5qZZT92qUuIzt6vCFhZYgin0JFXMdB+RVGbxzktOChlt5xXd4Grup8d/shIwYNLn2ONUabKcKQZQBCGZpAOkyIzaYonwd5BAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com (2603:10a6:150:26::19)
 by DB9PR04MB8233.eurprd04.prod.outlook.com (2603:10a6:10:24b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 12:34:16 +0000
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::b1f6:475e:de5d:8442]) by GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::b1f6:475e:de5d:8442%5]) with mapi id 15.20.9094.015; Wed, 3 Sep 2025
 12:34:16 +0000
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: imx@lists.linux.dev,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Frank Li <frank.li@nxp.com>,
	Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 7/9] arm64: dts: imx943: Add display pipeline nodes
Date: Wed,  3 Sep 2025 15:33:25 +0300
Message-Id: <20250903123332.2569241-8-laurentiu.palcu@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250903123332.2569241-1-laurentiu.palcu@oss.nxp.com>
References: <20250903123332.2569241-1-laurentiu.palcu@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0229.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::7) To GV1PR04MB9135.eurprd04.prod.outlook.com
 (2603:10a6:150:26::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9135:EE_|DB9PR04MB8233:EE_
X-MS-Office365-Filtering-Correlation-Id: 785eefa3-41db-4935-afc6-08ddeae631cf
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|19092799006|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bdAj9het0i5R1SA4WJ2TDh7bGSG+a4ltCQ/wC58J5od0jjINmj3G3OhK6uUF?=
 =?us-ascii?Q?AQjidyQLoaLLqM8Hx2CefEA0N9oLJ8BZT919e6VNlyd2+PkXEBxVQIh9cBA3?=
 =?us-ascii?Q?OoKtPaSeJoknOL/4t9mflSaYUFgZLb+UP9Tn1Ynuyxe8nqHuRjNcwmppBJ3R?=
 =?us-ascii?Q?8WHuSeAP13eb4S2l/6jHLsuhHIbJbr3rLJOsR/RMufZta76r/t21asIHyJMo?=
 =?us-ascii?Q?6ExYoohCjLSShnXlMq5bMjYj9Cx78EE4RWg00hFsZfO/65hBGbtEcsnsugL4?=
 =?us-ascii?Q?uV9cwBMjo+phUrkAlu+dmw1q/yMl+XSJstrp74NJD4NleSnBuR0qvW97rKLx?=
 =?us-ascii?Q?Lo7KTCRSgyo/EgxDD66ngSoUT2cXoKekAGAa42l/fEsnq8KH+uP9I8axFyiM?=
 =?us-ascii?Q?i8tIa0KNLhKPvCHZXwlG4Mtk9s6uSnJclXxjr4Ptp2Umdb45XKTeF2pHk1e9?=
 =?us-ascii?Q?thBcw3FppWbGHjKeSCZWIIv/J4oKXsKcNPrhGI9E2QIGN5wYm8XNOitkSrnf?=
 =?us-ascii?Q?2ANafFQ9n7NptB3VjVWp8KeMynI9H3DsSDDCuujF4A5ejsBrT89Q8HA965rw?=
 =?us-ascii?Q?1X155qfTJGbLLIZSRd5l6E883K5qab9HdmYwK5Y1PNEotchoV2UkI0cjOeYK?=
 =?us-ascii?Q?sjXlUAcr5Bbzjea7z0O8hJ4is1qZtrfCYBeHsh+RgEnpOY5lmuTNhWVfo3o6?=
 =?us-ascii?Q?BSacxojFoZ0k74T171oNsIyg52HZuIbXaz5nYsm2dBz6EmMmvDwmfOw3jpLh?=
 =?us-ascii?Q?ch/z4ARGbjsnUF9a/b3mQ8uf19K6IgroyJAnYO6TwIFeomRoE2OhK+tmwBZ8?=
 =?us-ascii?Q?IN4w7uaUjEodUON8ziDvylaHpL+SHSQL5KdwPIFUCxW9g8qfce19PzBIvQoG?=
 =?us-ascii?Q?BDCuIkiBUV2oo0Cm4aHJkAej1pBWS85818uq+RSa611lo/cbrbo7rAfX3zA7?=
 =?us-ascii?Q?6eLJyH089U19knl84qxZhZDiG7nHB22/EK9vddF1Cnzc1hA2zmFYGfepVtY7?=
 =?us-ascii?Q?Vngy4ndhzOW3joIVGBU22V13MTQpJLojVupuGCcFOIRXeupzanrN/u+vtZ0O?=
 =?us-ascii?Q?ySo2Oj4mRSClf/zKyqGAmTRimJkiFDcJx41Q+wXnzJ9eu20AFuEYvy/r1DYL?=
 =?us-ascii?Q?cb5niXoa4oudSn84qIndbBvDDgvgMUhBu3c3dR166tQePzwtsAYnwft8NXWs?=
 =?us-ascii?Q?x798YyYruCvSZDTemZLXlMTZ1Q0tfUb6oxW1yoCjQhwgCjpmHEBOnTjBOTlC?=
 =?us-ascii?Q?4s72Jb3fxyPcmLpnCFBQ5fU/zh0xa0Gf8zJQBZt09S6Hx2aw8ha2h3MvNlef?=
 =?us-ascii?Q?u7gFtYPhwznhDCLSA/FlFrxZeqDyyrBFl9SSmqzQrUcA1TCyZqzsHZhQYGYK?=
 =?us-ascii?Q?/Yz1Hln6SKTC0nKTAxA7F7o5iL3uL6xr2JwwRKmfuqNuCqicrqSQR7mumNyw?=
 =?us-ascii?Q?p4yB41OCw3k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9135.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(19092799006)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E8RJtkI9YuJjn+gdapyqA/jtBj8Y88+rIDrpFsfvxop0VK4DtL1+MCSHxKvy?=
 =?us-ascii?Q?cBxqRoHuEmlnZ3T91Qyj0kGWC72hGTV7oh3rwLYTP3cOfocS89dVRO1Wx/Kk?=
 =?us-ascii?Q?vd9fyUFzMgnl13JpR/iazeNibsTsFEjcDenS0pSOlrccRjOHA9oTQCUDu5U+?=
 =?us-ascii?Q?MHKLfDmvxRHapdq/ZurZ79JGUOih/OWddVNUuu44HIEb9E+WigjGxyxkwFUB?=
 =?us-ascii?Q?Hd5npXoMEkqRPwJZGCzLUNzBJrDFNHD61BsEqN33qBD4ZiH5tCuRLh9wPULn?=
 =?us-ascii?Q?aAs8h8PakqX9SGdFd/dkkdF+xdH6F+0URqJ4uEk78kyvVVHd43DuEur6IUQU?=
 =?us-ascii?Q?XZA8Il46zUsoMrJsSIJKuMYQ1MGnW9yUvyMNik765S8ucWF4qVurJcE6wO+2?=
 =?us-ascii?Q?Putu2rHE8pK6ur41qnHe8/aehem6KHHVa1XnfAIIh23+P8rJMWtnlZJkvhKT?=
 =?us-ascii?Q?9hNisv3iNcOJORwOd1jONydSIpm8jCYmyhL9uy3+VyXFZsrppa66DRM9Vhw9?=
 =?us-ascii?Q?WOJ4cL/xRiu8q+2NQcEuPC4BXUlUBDjyI/Lt1Sbcbbxxx74pzC37SZF9kCpF?=
 =?us-ascii?Q?Dqi1FsrP2tUWSXkh5KG2Vn7b8ef8Qrd0fuxZyRXUXfOgTjnZM7Y+eM2YRgji?=
 =?us-ascii?Q?gXvtm2VTZlrJ0Y8voT0CNf/7PdX+JX99wIH27O2KSHmgNW8GFpw+jDMECjtq?=
 =?us-ascii?Q?vv3oydWiBbsNlbBtKJeC6WwA2wQZt7Ujysmno2TF+KFUcSdSI/dSNPOlCvee?=
 =?us-ascii?Q?Wxc81jUXYGdJlFXaNonEjzhN8JaSFr/8YvGRHf6g/EmpoywXEEey9JUAWOaz?=
 =?us-ascii?Q?uVor1BS5+nyRnQgN5jYxo+pLTKeCW5OseIBc62KeZ5qgR/dQnmntbDwHyFbd?=
 =?us-ascii?Q?Br5JTQ677PZNk4zDLGRS3Kg4Km5JPbAbrYYgy2ZFo9/7N6yucZMY9n9lPvg6?=
 =?us-ascii?Q?G+wTd/d9Hcwn79wkUYDMr9aZa4t6+FPwpfk6kJsn3cufpfJ908sEe0rOd2s1?=
 =?us-ascii?Q?RWfQuQ9FAMZuAkn+9teMW/NLvraQ3EvCYVkxb6cnIMwfDHx0H4r2S/yvm5OQ?=
 =?us-ascii?Q?awp7+PPRZX94130o/9NZrzcWOFPH9Vrt55oY0qnNkkh2Nxu8hhWwelMTBfmv?=
 =?us-ascii?Q?JMfiTrEfKg2ThFAGG6zTZkX1TSnrulYawDf8gPi9CDm5cwuPayq9TRmVMsvG?=
 =?us-ascii?Q?FQyOAh5VblCT+n08MsBBftoJmhV4c3rD7bFK3ou8AsFob21aMDjc0YAtmjop?=
 =?us-ascii?Q?vpuz9hFNEfzldspR9lMvJPdQbygp1MgCnTz6zw/5SzvQkYbkVili5gl2NOwT?=
 =?us-ascii?Q?tSq0nE6FVh0SOarCs6PATg/+75hOqAA7YqWazXVPMfT7131Vx/anKA+PvJeH?=
 =?us-ascii?Q?8L89GrzvXVxoS5Wca3Iw92qMsRjUqRuGF3R+FAHRjh1luEY4JYdyT4jTUVRu?=
 =?us-ascii?Q?2VckXNDDkJ+hlcLf/yf7WVWon5mzDwK8B0j3wQYbxXlRejdnysByxAgHYLwx?=
 =?us-ascii?Q?8JehxwXHQLnx6QdUhK4j70VDT9EBUB8dcnmVyHUgBvuQoMrHOM9Ly+FsXr0T?=
 =?us-ascii?Q?V+E60hD4lNR++xXC3S7H8oIbOOqFSiYm9uDUTEGS4ofs1pXDbmm4/hMhzoe4?=
 =?us-ascii?Q?oA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 785eefa3-41db-4935-afc6-08ddeae631cf
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9135.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 12:34:16.1084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tG05M8RMxWsKAeXRYyL50rgW3xtTWHHq8xfCnEqNzonyINsn57Q/jrQAMu1zc3UKPsWIqBuyoKHVG3LZwv75LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8233

Add display controller and LDB support in imx943.

Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
---
 arch/arm64/boot/dts/freescale/imx943.dtsi | 53 ++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx943.dtsi b/arch/arm64/boot/dts/freescale/imx943.dtsi
index 657c81b6016f2..9a91beef54e86 100644
--- a/arch/arm64/boot/dts/freescale/imx943.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx943.dtsi
@@ -148,7 +148,7 @@ l3_cache: l3-cache {
 		};
 	};
 
-	clock-ldb-pll-div7 {
+	clock_ldb_pll_div7: clock-ldb-pll-div7 {
 		compatible = "fixed-factor-clock";
 		#clock-cells = <0>;
 		clocks = <&scmi_clk IMX94_CLK_LDBPLL>;
@@ -174,9 +174,60 @@ dispmix_csr: syscon@4b010000 {
 		lvds_csr: syscon@4b0c0000 {
 			compatible = "nxp,imx94-lvds-csr", "syscon";
 			reg = <0x0 0x4b0c0000 0x0 0x10000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
 			clocks = <&scmi_clk IMX94_CLK_DISPAPB>;
 			#clock-cells = <1>;
 			power-domains = <&scmi_devpd IMX94_PD_DISPLAY>;
+
+			ldb: ldb@4 {
+				compatible = "fsl,imx94-ldb";
+				reg = <0x4 0x4>, <0x8 0x4>;
+				reg-names = "ldb", "lvds";
+				clocks = <&lvds_csr IMX94_CLK_DISPMIX_LVDS_CLK_GATE>;
+				clock-names = "ldb";
+				status = "disabled";
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+
+						lvds_in: endpoint {
+							remote-endpoint = <&dcif_out>;
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+					};
+				};
+			};
+		};
+
+		dcif: display-controller@4b120000 {
+			compatible = "nxp,imx94-dcif";
+			reg = <0x0 0x4b120000 0x0 0x300000>;
+			interrupts = <GIC_SPI 377 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 378 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 379 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "common", "bg_layer", "fg_layer";
+			clocks = <&scmi_clk IMX94_CLK_DISPAPB>,
+				 <&scmi_clk IMX94_CLK_DISPAXI>,
+				 <&dispmix_csr IMX94_CLK_DISPMIX_CLK_SEL>;
+			clock-names = "apb", "axi", "pix";
+			assigned-clocks = <&dispmix_csr IMX94_CLK_DISPMIX_CLK_SEL>;
+			assigned-clock-parents = <&clock_ldb_pll_div7>;
+			power-domains = <&scmi_devpd IMX94_PD_DISPLAY>;
+			status = "disabled";
+
+			port {
+				dcif_out: endpoint {
+					remote-endpoint = <&lvds_in>;
+				};
+			};
 		};
 	};
 };
-- 
2.49.0


