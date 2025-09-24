Return-Path: <linux-kernel+bounces-829973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 793D9B98591
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 08:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4E441B21C18
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 06:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB8524A044;
	Wed, 24 Sep 2025 06:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="eOOc3ukm"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021132.outbound.protection.outlook.com [40.107.130.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE87242917;
	Wed, 24 Sep 2025 06:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758693927; cv=fail; b=RuGC9Czk111XqpVdVCQQjOEwnHIZxVY0bmMPshdhKlDjlFuKrXuzavvEO2j0VJnbgKNmB1LfFyglw84yHweMTKlk6v3aGSnijPuuv8Apfo/d1cERWQ1IN/M9ZpGWzEfH4md0Ud8FxlGyXDYYnSZlLri6NunP+KVb1iUE7Fg3UEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758693927; c=relaxed/simple;
	bh=OoQ3csBB6xjShjZPGMpNFKOEx6q+wvw+nYgflOkmC74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CSlOXefJbjjOUDexECXLi27IR1zp/kMbnzjFJJ7jtBn9ZGrqTRYP929bYHv3e+Ak8Fs4nAyzBrSMmItFz061AYS084OR+25YC8FGKcVIrm0Ep2b6f/H0tZ98EoVnM3NdHZ9MCyI0q7H1F/BDUBKb1C0MKNHgzLyREfT2G4IdxCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=eOOc3ukm; arc=fail smtp.client-ip=40.107.130.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yz+/8m0INH/xRVgv97RFDVegxpWh2r6nizoiRglgmQsQv8yrZE/N/7axL5ngio93mA9l5ULbCFZlfyGr6tL5/f1j82kVSMo2gEGcbrKo+UFaQP5xch1tzTOxMNr9lJdwbLEtgJPwUzw3xkc6f2gedbJj5KWLkxBbA5WrhTtxaqII7QbYDnVgUfPBPkJOJe3pzJ9A09ZQhvWVOv+Mg4xdOtGKESZ4XsGFiQg+jvvsERqwdfKkRgB/sCvnMf30yO+7Rzwb2/NAIZ1PLwtXBPUaqT/Y/hwyCLfbuuzQDIRrXyWim2HIgsz+USTqo+Yn424mThnyXM1/GVuf2A5QLtXAjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kqR/XJ98yGum2ArAaN3+VoXCWUs/xAepGHGALVdXHwk=;
 b=eLM2IT0DCzz1BYs+2vzTVEAdXPVY5Ha/pEmbJW6ycuBzMx9sRtymKOHhbvR8c8r+PuNxa3Bo+JOeWEbR4x40wczH2/y2CvGqGdIlCAwbu1eOe7/aZarJo0XwW5TixtdT/KEwFuwK4qKfymtBAHqsnfFZpJFWHRHXc4zqX7oVJGGHGk8CNS58xmLDWRBckioe0rFLpXxWPbl+cYo4mJQ/VaPLymZppd+fLBBlFa5scsHdg7VmhxUGrAyP6fvam2ZqJfSVv3QnMCzIbtyYvjuQkwRT85v5SiogeNwV7NDrhqVCuNWXvt36uMfL2KvNFyYczxp1A7wpofH+JgrqEH2Ipg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kqR/XJ98yGum2ArAaN3+VoXCWUs/xAepGHGALVdXHwk=;
 b=eOOc3ukmSqNaA0apPX1hojYDtgENBg1Gx3SpJBEMxsFgLdp9OkmJSmNQxWAlXV1R8uKwI+cp48AG7urBoP+C98HDhUNqpqsycoQLLD3GjcskECV8WZfGURxYq0Dz/CItEas/xYVsJhnoVf//uRs18r8GXjaUSgUM5z0kg8RQOVc2OMHz0KwlioKN+gYKtbaIGYplGPOPxnQYH9NpX4w7EYPWOHNf6ZLrmCr3ucSxfJCVwcnE25FnpCxl8Xil55fmJLWu4k4r5Bum53Uj15cWQtWsbnY1e8YstFfL0XmJM4D5XG+fasdhN8atCodFfcRAYAAqH+NsSIVwWuSiE/R8/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PA4PR08MB6080.eurprd08.prod.outlook.com (2603:10a6:102:ec::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 06:05:21 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 06:05:21 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Felix Fietkau <nbd@nbd.name>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
	Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH 2/2] clk: en7523: Add reset-controller support for EN7523 SoC
Date: Wed, 24 Sep 2025 09:05:09 +0300
Message-ID: <20250924060509.1889131-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924060509.1889131-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250924060509.1889131-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0154.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::9) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PA4PR08MB6080:EE_
X-MS-Office365-Filtering-Correlation-Id: ac20890a-dcb0-4e5e-4f0e-08ddfb3057d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iRu8K+SVRIQPmj4pvdpL6nad6TXnWglmymiOezXngdSyyvkLgH8FoCQateHK?=
 =?us-ascii?Q?ucO+zchJ/bi5L+8yjqVcOB5/RwXqfLoBzp5LIRf2KIujDqYirZbNdZ8bVwT0?=
 =?us-ascii?Q?2ZS7vkIVVRedeM0SVcHGDHZ1+2vySwTGW7xWEwu98EcEVnE7nz/OtVKythH+?=
 =?us-ascii?Q?GIat9GK1KSdDUoWT/ZmbE6v/GWMppgbkXNm/bhL8hCtfcM4DKlMMT+fsJcUX?=
 =?us-ascii?Q?aK4W2Nd49nHC+JVvJknAsyeSeM8Xis8ubfzoCkGIE0zJbAt5zyGTS1Kl+e1R?=
 =?us-ascii?Q?rTxJLuhJO2NfRx2AxwEFYP976BM9THtlQwBpo+0DyCGBpSPqOdS0VgKjKZcl?=
 =?us-ascii?Q?y9n1EDKlBmd0aowQMHRV3lcuknxZ8sXG/nOCGjH2pyxrSRSZqKdwpnRaa+lD?=
 =?us-ascii?Q?9g3TeMpMaNdb4JmRVhrdy/A9CWJhi11a7nW7nBpufWGJKAsEQAg1HjpwVZN9?=
 =?us-ascii?Q?TMrtagDSBEX89Dzc+gRkPwIIqfWgu9Kq6+yGD7W8UqMf6+ufkq23VwcxRE2Z?=
 =?us-ascii?Q?cjFVoJWrERnwduCMmpVas1+b55vzhaVzUwhZQXIVTjKGSQNoFwz3MU7Y1WYf?=
 =?us-ascii?Q?KneFJFNWldLozTsyeoyLL/gS4X2u9fddJWLFkVHp6shbln0WrcfnG385+CO4?=
 =?us-ascii?Q?7vsKXrpVvrDaEs895iTHbjt5uBLm+o8ABwvdKxmFvv6l54U1K9qj5FP7pxTV?=
 =?us-ascii?Q?qG++8Qt2/+zzl7bSegS/2peNyixBP1fgZ7nir041Iz4JyLNTfY+rjRN8UtVw?=
 =?us-ascii?Q?IW+3dKvJk9QRdng6+icj06ep1KriQkHRnnL/lde0sv5KiMOMcRkDapqz7g2l?=
 =?us-ascii?Q?QDNo2qvXI1DDFY34pAuSS6gGbu8C40oX6ADuahYSBdznCsupdhSWE/lxIE9O?=
 =?us-ascii?Q?lCv8RXF5YhEOuoVR75L2x8EzBxKr/vJOcPgpFCtYUbRB/QADB7Y6AnjdGMci?=
 =?us-ascii?Q?FF604aqw1XLx7ZK796Y+eMghhlmL0/7bP+A/AvT/WjhlFXGBGSFYcg9ndyoC?=
 =?us-ascii?Q?Bv4ikPT+s15JJ5nXss0NI3k2Ddxx6qZ6cQIgzzlBvul8gEWXL8Gu9woDLfqw?=
 =?us-ascii?Q?tnyDBnudmAj4q+Wl3EFrsaPZr6Cr7ZJbfdO6pwJf1bmU/ic1wPpl8kaGzEMT?=
 =?us-ascii?Q?xH5/d2Yw1m/btENTiibnpAKJ1HWXDB3FV1hTmYstuSsB7aJuP841DO7V33Py?=
 =?us-ascii?Q?Qox5Z5AxTcCQUV006UbCDeRPYj6uNhhoqiJu6e1zrqDfQxgTl9yHyP+duOs5?=
 =?us-ascii?Q?O+gG1/642R/a8TMHTwTieCQTX9w+TYyQwxaovX1X1mgf0sUTJ86di9W9zYbR?=
 =?us-ascii?Q?F8IC7VJ5JEgCQUWZBUS7S7JeJIt8q8YQwWL7YzOyldgkVn1L44TFUL2cnRZk?=
 =?us-ascii?Q?CrLL65PHF2ugFLOWCqdPaE7S2bwxJsqHcSRX+wBQazkvbaf9pPiU1p87zdYO?=
 =?us-ascii?Q?MWLj83VIcb8lSN8irkZlwxJrlg1c1WHqdrhVC77C7wxRkZzkWXvO4uK1ElPE?=
 =?us-ascii?Q?wITnIjDXX/0/vDU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z407WwiWHqD3ZS3X1VWgD9DkX8JozLmVEnuO2UG4DbFUYXuZiGbAzKb1y8TN?=
 =?us-ascii?Q?OCp6jN58I+f3ZKUVNrOu2FocSGyH6nNZ7J39PsQ6DnaupAWvnj/YEIlswI7j?=
 =?us-ascii?Q?Q3mOp4NubkGQfPy0hcjw+MunoIUmjwc9XJ02uevJpCrHTlw/4XLGd2Fv9+fX?=
 =?us-ascii?Q?sA0267Fwt3XC2UbbhqNkp5eM4y0ZGo23VjpQPGaMvY2TLuLj+r0h5IxEnbHX?=
 =?us-ascii?Q?vfKVFAUxhmVcKQl5HTflLNNrjsnTNq3RyiaXyVBxZnuVLIXl8WgzlCJ/9CjW?=
 =?us-ascii?Q?O1medIaJygjRjRjyDNWOTctQuQiC1sGm8bHBWnUTtuetIuf8OWOEC1RM2HWC?=
 =?us-ascii?Q?+fCxSzLUO1BziDHurCVySAUAeLhiNyHcl0Cr22wW2Z5fuMV5T48QKTMbd4ST?=
 =?us-ascii?Q?71+Ew+WYuNVdMTsVb+xd/5Ju3b7KCSuKQwDPPdHhdokJC0u0hgsnPOkEWkiQ?=
 =?us-ascii?Q?2V7lF66eqp+3lBe2ukeX7uUj2OaTYx2KE5r5GlNf1GBg9S4Hg+XRsb7i45HX?=
 =?us-ascii?Q?uyUq179WKvIR+AtPXwfZpuqLt4ZWhxpwh4Onz8sK2HJBKgOqD8fnEHxX3H0P?=
 =?us-ascii?Q?tkfSA9QfLbDiwTQLjXa4ab1sbg4Rw60AyyMlZU87gbCNFE6mwsjMq0r52Yed?=
 =?us-ascii?Q?TAO1EzJjdjqJ2norx4FMBx74yc2+aPyavTHJvENP6MyuPhS3raqro7VhYjGS?=
 =?us-ascii?Q?3QeMy8hu2kjQdPD10pM3+pxQt9cwrbuRp5/wbuf2Zi93TkRJmLBbI2WEXfi6?=
 =?us-ascii?Q?rjx4PMK2it/xWZprxsv2hbJP6BkZn6a36n/LKicUvF8kw13fmQtvO6T5C2aW?=
 =?us-ascii?Q?S1P4Sh0W8g2+HUys2QTQPjxmET5UhsPcXXeZ7MyKzoxVqztWa91hdEN8ke/0?=
 =?us-ascii?Q?1o3kFjM4Yn4PAjjUzACMM3+ZL8YGHw5Mv1CZMHi1M01l20zUEpEKSjXQKUXM?=
 =?us-ascii?Q?/TjWFeO/jhvV294iUxbC6mulb4UBLtWwVqQLu9+EaGUXSgrtib7MqF1+BSaM?=
 =?us-ascii?Q?mGewXRbxHGf7LengDvg5pMGA9oPtmAWz44Fa9Fm0rVF4gYVGGI8xLCZGPehK?=
 =?us-ascii?Q?MeuQAVc6yMEj/n4H0kp0/z1d/LlE18imC/lbcu/MWfJ83hZ36AFSlqSMCQ0t?=
 =?us-ascii?Q?WBGz/aVK548nxTWf+/W6p9EoRoEUg5gkx7oI2UmItATQvLwtcuFRsEDwe/QN?=
 =?us-ascii?Q?lZUOrOLoTn8aU+yaiw7wR8ugzsfqaBNjmm1+sCi5CPJF0L8rutmzm0MQVNGg?=
 =?us-ascii?Q?2bvNA5iNsVpteoO6ifBwGobttb5NEEsM5Q6jRsOdZFya5L/vRSA6FIAD6RHN?=
 =?us-ascii?Q?8MlbYacs7hbS+GY55alkKuxpSyZ2rZuxD8hH+ociev2mV01vDEdA2CwWpsvG?=
 =?us-ascii?Q?OIirCHgkc8NMeAkJXy7BBCbae7FsbG3E5c/IEjgETuzgi2qjAdN/m+U65vLy?=
 =?us-ascii?Q?amT00rtKkZ9i0clpVJu2P4P7OC0Z+NKbAMkWvbEuXvYHpCkxa34OUcC2jnzi?=
 =?us-ascii?Q?PY48d6ncKIPdsRTN+mqAQOCH8lLnTtsaUHpRznkkFa1r5kmE9nb+RYC8pv97?=
 =?us-ascii?Q?Nh1xwkNqM0XNMS43Kq6tUC2GkkmGBBRx1pOc+gS1Vyy/iIG9/mgD/NLDN+5H?=
 =?us-ascii?Q?X9Sq+3HINmOGfxCXbVITVws=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: ac20890a-dcb0-4e5e-4f0e-08ddfb3057d6
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 06:05:20.9926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZJTKB2etEnUU7ecsDQZ4Jc5ToBqVljveaEU/59qBXeLuFX/lTG2RwzfQYyp6CDAbuVS8aGFHs0f01oG/PwEWN0gvyqLiWE2bqBGwv9OpTIU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6080

Introduce reset API support to EN7523 clock driver. EN7523 uses the
same reset logic as EN7581, so just reuse existing code. The patch
renames:
 * en7581_rst_ofs to en75xx_rst_ofs,
 * en7581_reset_register() to en75xx_reset_register()
because they are not en7581 specific.

This patch also updates en7523 dtsi file to add required '#reset-cells'
property to the System Control Unit node.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 arch/arm/boot/dts/airoha/en7523.dtsi |  1 +
 drivers/clk/clk-en7523.c             | 72 ++++++++++++++++++++++++----
 2 files changed, 64 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/airoha/en7523.dtsi b/arch/arm/boot/dts/airoha/en7523.dtsi
index b523a868c4ad..7d60a4f2e650 100644
--- a/arch/arm/boot/dts/airoha/en7523.dtsi
+++ b/arch/arm/boot/dts/airoha/en7523.dtsi
@@ -91,6 +91,7 @@ scu: system-controller@1fa20000 {
 		reg = <0x1fa20000 0x400>,
 		      <0x1fb00000 0x1000>;
 		#clock-cells = <1>;
+		#reset-cells = <1>;
 	};
 
 	gic: interrupt-controller@9000000 {
diff --git a/drivers/clk/clk-en7523.c b/drivers/clk/clk-en7523.c
index 15bbdeb60b8e..f276937181b9 100644
--- a/drivers/clk/clk-en7523.c
+++ b/drivers/clk/clk-en7523.c
@@ -9,6 +9,7 @@
 #include <linux/regmap.h>
 #include <linux/reset-controller.h>
 #include <dt-bindings/clock/en7523-clk.h>
+#include <dt-bindings/reset/airoha,en7523-reset.h>
 #include <dt-bindings/reset/airoha,en7581-reset.h>
 
 #define RST_NR_PER_BANK			32
@@ -294,11 +295,58 @@ static const struct en_clk_desc en7581_base_clks[] = {
 	}
 };
 
-static const u16 en7581_rst_ofs[] = {
+static const u16 en75xx_rst_ofs[] = {
 	REG_RST_CTRL2,
 	REG_RST_CTRL1,
 };
 
+static const u16 en7523_rst_map[] = {
+	/* RST_CTRL2 */
+	[EN7523_XPON_PHY_RST]		= 0,
+	[EN7523_XSI_MAC_RST]		= 7,
+	[EN7523_XSI_PHY_RST]		= 8,
+	[EN7523_NPU_RST]		= 9,
+	[EN7523_I2S_RST]		= 10,
+	[EN7523_TRNG_RST]		= 11,
+	[EN7523_TRNG_MSTART_RST]	= 12,
+	[EN7523_DUAL_HSI0_RST]		= 13,
+	[EN7523_DUAL_HSI1_RST]		= 14,
+	[EN7523_HSI_RST]		= 15,
+	[EN7523_DUAL_HSI0_MAC_RST]	= 16,
+	[EN7523_DUAL_HSI1_MAC_RST]	= 17,
+	[EN7523_HSI_MAC_RST]		= 18,
+	[EN7523_WDMA_RST]		= 19,
+	[EN7523_WOE0_RST]		= 20,
+	[EN7523_WOE1_RST]		= 21,
+	[EN7523_HSDMA_RST]		= 22,
+	[EN7523_I2C2RBUS_RST]		= 23,
+	[EN7523_TDMA_RST]		= 24,
+	/* RST_CTRL1 */
+	[EN7523_PCM1_ZSI_ISI_RST]	= RST_NR_PER_BANK + 0,
+	[EN7523_FE_PDMA_RST]		= RST_NR_PER_BANK + 1,
+	[EN7523_FE_QDMA_RST]		= RST_NR_PER_BANK + 2,
+	[EN7523_PCM_SPIWP_RST]		= RST_NR_PER_BANK + 4,
+	[EN7523_CRYPTO_RST]		= RST_NR_PER_BANK + 6,
+	[EN7523_TIMER_RST]		= RST_NR_PER_BANK + 8,
+	[EN7523_PCM1_RST]		= RST_NR_PER_BANK + 11,
+	[EN7523_UART_RST]		= RST_NR_PER_BANK + 12,
+	[EN7523_GPIO_RST]		= RST_NR_PER_BANK + 13,
+	[EN7523_GDMA_RST]		= RST_NR_PER_BANK + 14,
+	[EN7523_I2C_MASTER_RST]		= RST_NR_PER_BANK + 16,
+	[EN7523_PCM2_ZSI_ISI_RST]	= RST_NR_PER_BANK + 17,
+	[EN7523_SFC_RST]		= RST_NR_PER_BANK + 18,
+	[EN7523_UART2_RST]		= RST_NR_PER_BANK + 19,
+	[EN7523_GDMP_RST]		= RST_NR_PER_BANK + 20,
+	[EN7523_FE_RST]			= RST_NR_PER_BANK + 21,
+	[EN7523_USB_HOST_P0_RST]	= RST_NR_PER_BANK + 22,
+	[EN7523_GSW_RST]		= RST_NR_PER_BANK + 23,
+	[EN7523_SFC2_PCM_RST]		= RST_NR_PER_BANK + 25,
+	[EN7523_PCIE0_RST]		= RST_NR_PER_BANK + 26,
+	[EN7523_PCIE1_RST]		= RST_NR_PER_BANK + 27,
+	[EN7523_PCIE_HB_RST]		= RST_NR_PER_BANK + 29,
+	[EN7523_XPON_MAC_RST]		= RST_NR_PER_BANK + 31,
+};
+
 static const u16 en7581_rst_map[] = {
 	/* RST_CTRL2 */
 	[EN7581_XPON_PHY_RST]		= 0,
@@ -357,6 +405,9 @@ static const u16 en7581_rst_map[] = {
 	[EN7581_XPON_MAC_RST]		= RST_NR_PER_BANK + 31,
 };
 
+static int en75xx_reset_register(struct device *dev, void __iomem *base,
+				 const u16 *rst_map, int nr_resets);
+
 static u32 en7523_get_base_rate(const struct en_clk_desc *desc, u32 val)
 {
 	if (!desc->base_bits)
@@ -552,7 +603,8 @@ static int en7523_clk_hw_init(struct platform_device *pdev,
 
 	en7523_register_clocks(&pdev->dev, clk_data, base, np_base);
 
-	return 0;
+	return en75xx_reset_register(&pdev->dev, np_base, en7523_rst_map,
+				     ARRAY_SIZE(en7523_rst_map));
 }
 
 static void en7581_register_clocks(struct device *dev, struct clk_hw_onecell_data *clk_data,
@@ -646,13 +698,14 @@ static int en7523_reset_xlate(struct reset_controller_dev *rcdev,
 	return rst_data->idx_map[reset_spec->args[0]];
 }
 
-static const struct reset_control_ops en7581_reset_ops = {
+static const struct reset_control_ops en75xx_reset_ops = {
 	.assert = en7523_reset_assert,
 	.deassert = en7523_reset_deassert,
 	.status = en7523_reset_status,
 };
 
-static int en7581_reset_register(struct device *dev, void __iomem *base)
+static int en75xx_reset_register(struct device *dev, void __iomem *base,
+				 const u16 *rst_map, int nr_resets)
 {
 	struct en_rst_data *rst_data;
 
@@ -660,13 +713,13 @@ static int en7581_reset_register(struct device *dev, void __iomem *base)
 	if (!rst_data)
 		return -ENOMEM;
 
-	rst_data->bank_ofs = en7581_rst_ofs;
-	rst_data->idx_map = en7581_rst_map;
+	rst_data->bank_ofs = en75xx_rst_ofs;
+	rst_data->idx_map = rst_map;
 	rst_data->base = base;
 
-	rst_data->rcdev.nr_resets = ARRAY_SIZE(en7581_rst_map);
+	rst_data->rcdev.nr_resets = nr_resets;
 	rst_data->rcdev.of_xlate = en7523_reset_xlate;
-	rst_data->rcdev.ops = &en7581_reset_ops;
+	rst_data->rcdev.ops = &en75xx_reset_ops;
 	rst_data->rcdev.of_node = dev->of_node;
 	rst_data->rcdev.of_reset_n_cells = 1;
 	rst_data->rcdev.owner = THIS_MODULE;
@@ -698,7 +751,8 @@ static int en7581_clk_hw_init(struct platform_device *pdev,
 	val = readl(base + REG_NP_SCU_PCIC);
 	writel(val | 3, base + REG_NP_SCU_PCIC);
 
-	return en7581_reset_register(&pdev->dev, base);
+	return en75xx_reset_register(&pdev->dev, base, en7581_rst_map,
+				     ARRAY_SIZE(en7581_rst_map));
 }
 
 static int en7523_clk_probe(struct platform_device *pdev)
-- 
2.51.0


