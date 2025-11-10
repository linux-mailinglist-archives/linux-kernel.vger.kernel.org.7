Return-Path: <linux-kernel+bounces-892329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2304C44DE6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 04:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0D453A6737
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 03:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9710728F948;
	Mon, 10 Nov 2025 03:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="SAOYPIwC"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020140.outbound.protection.outlook.com [52.101.69.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E282428CF66;
	Mon, 10 Nov 2025 03:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762747029; cv=fail; b=qpVGFEu6Ru8z8mCaSj2KxSch6rmEyYc1tb92+827mLLlSdJThJ7U3hm3kAQ3q7xWuDd2jSYnCG7PSyrNFCjdZDgmTzP3F44p0EBtMgB8ry8AI7OeXt+RVdQflCYTrdIUSQELsxj4fpHWrbA7n5c3qFAcHwCsfYXb7xviT9XSMmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762747029; c=relaxed/simple;
	bh=nUB4bvJpvUiBGFHmdSkVfuUCru7TZvZ/ogpOd4BP/rc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XhyaWyUtZSdcIYKSVzi37SpTELCzUlAG8knQ7Q4haBmYb2KM8ukZDVPmy0D8xZk4gEFgv0Y9svatnqobuKyRmDLZq6WwTKNm0nJZs3coksrkmcDCIkMWXsi4z3RLJWh1Ug4vcRJdU+xGKQVF4JKw9BeXXqXXeFEvYyP2ZqbUoio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=SAOYPIwC; arc=fail smtp.client-ip=52.101.69.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BHO4Uyy0efwG2TxMtYAn4LLCfWwyTf77TWHuNuexcWACB87yqR8IKwCIOBFwmJbK0zZZ+tEgmwpE7S/VBxql9f4GYr0l5ie/k3HtoPhXeB1O01L23L+/yWfrChKUgLYmnEMjlzWVQF1q1Om23Tfopx0HA6FGE03YV6AKQaSRxUDqJuTzDIsKUSHmtAbDQyMtY+s97upP0u25PgADkaMLBLgXF5uZWlwmTJPX8Ec2hPRXeeRxgBWGi6UK4vx4Xst9hmId+6rQKcmCYR3MIpLH8YfXy6VPsHvg8JeI2ZTHmx9k7vZc22OzECESdVONZUcjMZj6KBwELq4rPcnZbs+G/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mWSaJ/J7/NhXRxmf6iuMtujSLfqOvakh+QOEwHSOP4A=;
 b=JU3VJ2ORsIMcQOIx9wOAl5Dq+0c+jPpyFHb1PcrypdAkQxxMUptqJf7Nz3/UcXeYLHnXtqVjwMX47fh44YkOWnlwo0+xSSsqcbrXbzFilJuCRPKpwb8G0ojmjmwdI54QMlIe2/KfjvNMd/x2kqIopctRqoOr5Ph3rtSoB9U217bjaunJFZK1uC4fJNKeVEAlxeGSAfUrEej6JFkqMI8VvwO4nOuxncnK/n2HBO0pxNwTgPhUKEFNz4xEtOlIORmJHy8ES2+CqMwiQYPfONY4jr9rZuhUzcJxcfw+iZPWGf0fKQvrRgS7qRV3h3o8Xh7FHvrSrZ/GQmne7DpW/odV/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mWSaJ/J7/NhXRxmf6iuMtujSLfqOvakh+QOEwHSOP4A=;
 b=SAOYPIwCpUSn7cyZ0lIbpGUlbp7sqZaDQd1SrMeVH+mzVEm/CrgMjnpJJ09l1zDqGpzSGD/mLEKNP1NGfJgsLGye5OPzcKaK3n6XUEtDw+35Qb13kvfbK1FJapYN4wQsa4wprBmcbqHM5qaPq/7ZcePurnqGAhsbflN5gRj6FiFq6fLWDendW8Tdf0CIlBlcTXao2iKnGd6ySxpWYI3yJr4Au2jPef4i3Bx9MRrocidxB2g1/mIPD0ZCsYuo/XHwU47fQcNgopILTKEcQubWK3QV/ZZ6Rtb9C9ZaptM1CAtsqLgesAzaQTuKu30Ji5IbjjShaWiZMgos4YeIP9hfnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAWPR08MB10946.eurprd08.prod.outlook.com (2603:10a6:102:46d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 03:57:01 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 03:57:01 +0000
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
Subject: [PATCH RESEND v3 3/3] ARM: dts: airoha: update EN7523 dtsi to support resets
Date: Mon, 10 Nov 2025 06:56:45 +0300
Message-ID: <20251110035645.892431-4-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251110035645.892431-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251110035645.892431-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0483.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::20) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAWPR08MB10946:EE_
X-MS-Office365-Filtering-Correlation-Id: 4301eb55-d03e-49da-9339-08de200d3425
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?44NMjJUHoLVVKMTMEieoVPX2vPEt0AZbXRRr9Vm0bc7EPlQk9VIX+uJ1VLSK?=
 =?us-ascii?Q?+6qL2s9cDqjJhAuLSV3ZBnkKVzsuunacmK0jFr4+bH5UykHch0uziw+LthZi?=
 =?us-ascii?Q?zCxI7GUeguolTxeyWb1eVB1mkL/RD7NSLP0i9j50PwQmv1jGW39xropK3WEl?=
 =?us-ascii?Q?5+5+Y/bz38+fR13Xe1ui3kWxcfgP/Ptyg39DEenUdxhpf2gU0wkyqXq6t2Qv?=
 =?us-ascii?Q?RnJrYSl8kM/hw4ivF1WyGR72U2owie0gYKt5H9Br7IhkzlvTL6VRM3X31aT+?=
 =?us-ascii?Q?1adJLc8Q+TGYkHzBNpymoVBv15dFK9Zuz11VPxFFHRvQPg/ePAQkuG2ODHKR?=
 =?us-ascii?Q?s/Hr1lK/YyqS5qw2jAh3jgMo+apLZZD4GEmBZz4brZrzIm8YLsDXGelSnkB1?=
 =?us-ascii?Q?yWNoOS0q99TB9ZfP1simQPrU0eZT+m0d6p8K7KPhvNdjyPKGG8umBJhJsuVC?=
 =?us-ascii?Q?+SeZxACoCIke7OlQIrle09IRz+I4p5XRgUZJ/Lz/r+XzI625ZAwLOOe+Ov5s?=
 =?us-ascii?Q?0uTs58wIFgVWo7J+65LtxDqkHFWDeP+JM1wQcBOylYtgRAz7zYUFN1ZnxR+T?=
 =?us-ascii?Q?xZjf3CJnkQLuAA8jjUyM85P69Q1U8BF5RWQf9k5MI35sMCnKP9NQK+fLjmzQ?=
 =?us-ascii?Q?hc6b8fILEiNNhbL897SGDDlDVkNnu8bKMGPJ89Zu44iiw2ft8/xj/Nsbgc7x?=
 =?us-ascii?Q?Ts/dgXlS5+Hz+15xP2cqCAfFcGfei4yh9riUr0oeMaksLRCMvufXTqLHXwKC?=
 =?us-ascii?Q?lp6ZiMhyz7e7c0349otapo7bKzmxFv16GoPXZH9QJ6Ybdp7gFH7ll7Zr+qtS?=
 =?us-ascii?Q?v5FMxAhHPV5kbyQ2Uhz1lZoP9GlqtMVhMLFIoBwKPLMeKEdXjSRcHWEPyDe7?=
 =?us-ascii?Q?HkqMnN4guuF7v9uL934VNbQDObvECIRmGYuwuGRp2esjBgCyMcFpmdCJQ07j?=
 =?us-ascii?Q?BejAHj1D9AfrhysuUlaVZVAM+c8E3vHeYmU0URlgHlA+itBQYp0CI6GW1HrO?=
 =?us-ascii?Q?dH1BP3u3RsR8PHVN+HxBnEdii4AeViDy80zXpU98U0jAKuIPp0R9St8VoRgm?=
 =?us-ascii?Q?bhqegf1yodYFjo6dGKM7n6yTtKnh6pY0tSG9Fp5V4GO2fNce/Gk1oypMCKUF?=
 =?us-ascii?Q?6pB89G8LNMLHAeJ3YRVuCy44QPrEdpj9+wSK091QadxjufNivNQ3RLl5ucnJ?=
 =?us-ascii?Q?Ftosen9PL+eq+ozo7NqRg56kM5ksfnELrgD6q07UcmCPwVJNWg7HauHUovFQ?=
 =?us-ascii?Q?2TXYEouctlvattoSwbe68OE0c5Mtg2uUG3IACFFNx/O129wTMEK4en3EbRm1?=
 =?us-ascii?Q?qTM5LU1pJpix1BlBwdgo/JPmxbHwMNwDADOKrfl3fwd8MiM8g6e2FZUcQLVb?=
 =?us-ascii?Q?oEgTMgepwBMoi1Dcgv8o13+blq71/DihAcntW2uj+t+NiSX47HrIqqwZvhZo?=
 =?us-ascii?Q?VQvxnjt0UwzHYX6fW8IfbmGV2lMnBDHvyT5dlzZO7c0zV0HZkcMwevvQRibt?=
 =?us-ascii?Q?XeEhHLkHXMLgui2Exrhluu50ILcpZ9E+8nGAUNwRZMniCUQsz1b/e0z0TQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JT//0AE37MR0qvjD6SiLUltkP9V/jq3qRz5NN2mdh3KN7jTfxWQ6/IxqQFhJ?=
 =?us-ascii?Q?OzPhDcFv5TUAK5izqqH2lTtuiv9JwaMBVaQCB88KpputbXhg3GVfdQVRWM7T?=
 =?us-ascii?Q?iG2io6YICN+vwx4pn1vobatSpFvFxm3QYuiq8n4vWgJbiH9uN95vXSp1+JBm?=
 =?us-ascii?Q?TfrTckbwRuLoTpvHH2awuG+3WBusMvOC21Fq9tcioauY75TtU2mO5bQXED4Z?=
 =?us-ascii?Q?w7rRzYUEufVExoqgHqsZYyS6ZbTigRr19T/83UmpCl8Nl7MgDEG3P+GsZSt5?=
 =?us-ascii?Q?KP8g6A2acUtp3HzCQzXJSlK+H69UAdJ6uqjICj56Y4iAilGv/f8Nnlyd13+D?=
 =?us-ascii?Q?6AIYQV7WmBwa60hRum0LVBjIvirFxF2PnVZHfrUmC3ALS49s4r0bC8NWKyaS?=
 =?us-ascii?Q?/fxfhBVYOOJQ+fQYyU2VdMpkl+ffSRR/xFtwe1i5LQOMJPuGKVZUqSegnFJ0?=
 =?us-ascii?Q?Ih3PHY2UY4O4eKIABvC1WJERmBrb2UMg7HMhqgty14v1/760i7A1GRflt8i4?=
 =?us-ascii?Q?UIEjRhPcTmwMWONmeGr9h8ZesSvOnDSNAK7/45jb39sWfA6T2ktz+3B0bQxA?=
 =?us-ascii?Q?YJtqD/HXJkqKUK9Erodf69wOis1N5O5u+Z5692GtSTlDPORxFGW5S4ay9Ltr?=
 =?us-ascii?Q?BpqcoqNBupwaDsJH8CBKIXygW7aWDh+joWOb9XemAOJoMPRHkr3Sp9RMwymw?=
 =?us-ascii?Q?Co1WSZ7IvnnQe1dzmsjeeULToFiX2bDPx76/BG02xkrjTfcQrvoHX/fckmrP?=
 =?us-ascii?Q?NIcIBoR59bn+OGV6OWYZy/mF1aKl75hn3HQPUQ6/BIiXvO0T1K84BxJgIXW2?=
 =?us-ascii?Q?c0ClBxPW0ouVyQ0/kFCatBlH5EMcWAls7bZuw1ocmvj8D4vqFq1eFBf2vO82?=
 =?us-ascii?Q?+CA2cFyDEdwuKrNSIdWxuyfp4GfCb6/Tu9E5C5XVn17z41EK7u0O8uEcRgwF?=
 =?us-ascii?Q?BvHWhO+zd7ckhHVJoWcpRwHvKkUio1nwYoXBBndlgQ3vY+dgBSpPJDVXpTBJ?=
 =?us-ascii?Q?vUQAcB1KXRX6igH5MvtwQs/DLQ2cEXIlWsNcX288TuoffWLw/rsBmMhYtCru?=
 =?us-ascii?Q?1h6ngPZHydACs0s3XNUg82zXVrLK7xgYPopJa3xnGpkd89bH2lvYUfBAQ7Ub?=
 =?us-ascii?Q?D68f7Rqf6zjrpilHpmJN5KaERHG7EnfSbghBSpJQHKBRghrPB1n/RZZPO9L6?=
 =?us-ascii?Q?ekeCY3ZCnREkThiD6auCC49jtvy9RZ3SMjDFlNFrPfSyF042OwqM0PB5kzFV?=
 =?us-ascii?Q?+l1KVuk6LMTo9IZF/LPTH0+hcHV3o+CdnNljDohb7T/Sh1u7ffRCFZV0H7ti?=
 =?us-ascii?Q?aA/FKlJBO2MiGh7iEjs2oavSDUfTEXcTtjPDivYsTQ4yy8aeffoqVSpr11II?=
 =?us-ascii?Q?g58t3nWo6ul4FfcL73/4XoMdJgrYlCpmRb/myYChv8JMjWBZ+goL2GOuRfAz?=
 =?us-ascii?Q?lTcoZkL1uG3UoD+VffvWU+UwtzCPyoaVfZR+Tzc6iaRJ2RAvJv/FVGO1vjyt?=
 =?us-ascii?Q?I0L0uc0Mr5SrsP7lHzXl0f7aymbEw6xVQrHc1MXpRBvsMj+LTuyeGH5o2MKN?=
 =?us-ascii?Q?+1+H/FFFNTs1MBfM1bmwBne8rDZAs6l4yhQIPsoVHFQ/cvS1gpxAtcROCG5f?=
 =?us-ascii?Q?iQ=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 4301eb55-d03e-49da-9339-08de200d3425
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 03:57:01.7283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2oA8hHC74qPhZLuk0ER228IknfU2xg/8/caSoXr6IwtiefB/FeDsbKu8S7xeResZ3ody68kINWpKhdwaKbt87Jdl8wYkQTrmSAHsJNkww+U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB10946

This patch updates EN7523 dtsi to reflect the reset-controller
support for EN7523 SoC.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm/boot/dts/airoha/en7523.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/airoha/en7523.dtsi b/arch/arm/boot/dts/airoha/en7523.dtsi
index b523a868c4ad..231638b25c5b 100644
--- a/arch/arm/boot/dts/airoha/en7523.dtsi
+++ b/arch/arm/boot/dts/airoha/en7523.dtsi
@@ -4,6 +4,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/clock/en7523-clk.h>
+#include <dt-bindings/reset/airoha,en7523-reset.h>
 
 / {
 	interrupt-parent = <&gic>;
@@ -91,6 +92,7 @@ scu: system-controller@1fa20000 {
 		reg = <0x1fa20000 0x400>,
 		      <0x1fb00000 0x1000>;
 		#clock-cells = <1>;
+		#reset-cells = <1>;
 	};
 
 	gic: interrupt-controller@9000000 {
-- 
2.51.0


