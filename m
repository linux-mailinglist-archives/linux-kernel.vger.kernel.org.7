Return-Path: <linux-kernel+bounces-830369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BF5B997DF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 179E74C3C3B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F066C2E1749;
	Wed, 24 Sep 2025 10:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="ElmHeCmh"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021085.outbound.protection.outlook.com [52.101.65.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E70F2E1F16;
	Wed, 24 Sep 2025 10:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758710961; cv=fail; b=aEHK/rF/Di+yiopmDoZ0MtO9G95AD79kPZaNqfepRwDmw2thmATUu9qE/IRnZQ8EdCJPdP4ocLU6DI+pdbzHMwxGtVYmWtoNRZNVlZevNrr2ZyXTZrQYpsQsXLHSoD7DuKMAoKMA5ag+TUIWqad/e/jgwF4PQqSmcsYPPHyak4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758710961; c=relaxed/simple;
	bh=8ACmMiCVANJYH1yxqYOQBBcnNZAZyobHws3h+TqSvEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CjWkCgqSV8Y8FrEcxcA8bY6iKB1bYRnNd7uciZzfGhNWEbd2ozmyCfW8uYhC4X7rLi9pjOxfzFLq8t/fkm8cISXnxeYjjbFVFB+wiQPQ/ZDk6pZhZGL6Qd19+MhUb9Fwk0wQ3gpFcQ9qxJKAKHxpBdLzdjOjVdRLAGx7+wcxZ9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=ElmHeCmh; arc=fail smtp.client-ip=52.101.65.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hmPNoQ5awj9aL8PUT/dbc9IQy4NoevfuIldF3qB7KxNNnwPqEEyCemp5F8Bub+UWBzx4BPEFCa5xd4ZymGdIUx+0BPxDcVMbSuCUvmPNYUszOu4CxgsIEaUpvsACi83WQsKCotTYWYytp3wlV5rLXV6cqTlf8zgZJrQ+LbYU55qroS2kveEM9yS3jj17QYbhD7yNpfV7/c1K1dQm9IhnGdPPXs9t+94SW1hQZxa5scHZ2u1HqbI+HN+kn5tj5rFT5wUtHEwOTe/TXQN3n/V4bgNE62fKzJejBSYUajycM6uVcQRx+Nl1veb6qCbjmX0wZp2xkJg9syQ4VzBOFF/FCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o9Gch6omiWO3A08BFZ6zYYOikqsDOljdI8CDFQzYHoU=;
 b=FSNpK5BI1rsIC5N3gafG2cnsq85WdSx52shjY75Arvuwa7oqBZtq/suVNJzGc0AtZHM5+48OWAFYSf1UFowMrzaxhIcuYMYjWi4ZvW4hoZkiCGGo0DI9i8QzxMyO/rI+u3VKMn8WGuTXLWS9U4qkiXn2/kulneiLATrqrKp79Z14wloFq281a1VyeGRGd48QT+Oj8poj3zchKuhwTC2oRcrdcjnvSXoWj7fIrei0ppwPp/ZK0ERalJwsHj70ez725kN2caafi0eQXWInIFy70y3PRjoHLSn/LSqONhS5RRDOKiub6x/NlJwFxv2c8oEaApkFWZgumAPZE3zZ+V9aGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9Gch6omiWO3A08BFZ6zYYOikqsDOljdI8CDFQzYHoU=;
 b=ElmHeCmhuaOb1u1golJofdoGiQ+aTCHxu3rpc+Et3rBxIKeJplgERSxl2cZa/13jQj8FgWV9NdBvlzZtHjHYfcscq8dQtwH3XI2pf9ic0u++1eeZmUb1kR9U1iSTIGtmkVbiJ06GHGzwxdjiZmzKYhtsmxagrcFkeWVjj1LUDy3QwKC21HMaaXEtqYo0ivikBCA9Q5ur76a4jk0A+SVShzbTOBpn9+gZOYyF0/GO2TzeA/ZpP20i+BmKbjJlU18xUDKzxkQH77Pkx+Mss4SplXRkoekapu/OS/1BwLgYsfJPT3JbMiXYrSST9VVNnrqFBAPUAJPCzCgA/PbIMVt1qg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS2PR08MB10010.eurprd08.prod.outlook.com (2603:10a6:20b:64a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Wed, 24 Sep
 2025 10:49:03 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 10:49:03 +0000
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
Subject: [PATCH v3 3/3] ARM: dts: airoha: update EN7523 dtsi to support resets
Date: Wed, 24 Sep 2025 13:48:50 +0300
Message-ID: <20250924104850.1930254-4-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924104850.1930254-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250924094112.1918444-1-mikhail.kshevetskiy@iopsys.eu>
 <20250924104850.1930254-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0003.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::28) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS2PR08MB10010:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e891678-234f-4f36-be2e-08ddfb57f9e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pwrVSZle3RDqhll8azLKqqsEHKMRZ6ER0M5mY2yAI7MKFzKk4z+2/FQYHzbo?=
 =?us-ascii?Q?MWCqg7OxUauzSbFkof+ftgp0cdX3Cd4CAS81rAUVRNebAIT847lHPauY/qDT?=
 =?us-ascii?Q?p6kV8GGOKLlvvud4V3/farGHXLuVue/7ykiqUo9WiMJ8C4imx+pXINBHK3Ap?=
 =?us-ascii?Q?wsRB/evPp9Z6/ettwaeF+E/hWqvTupysa7DZR8Krf/mndVOjSiHo93ZE1MRu?=
 =?us-ascii?Q?5ITC4a6DFysdVQdh1x3bG/VVnYhF8UpiFJuI3VU8iGzY93OkBtQGcVu7wv3x?=
 =?us-ascii?Q?OwI1DoALb2+OlMBV4vgXvXFmEPplVykzc+n3D8HAE5YXtyteUwBF16gbVu/G?=
 =?us-ascii?Q?rllMD0dmrYQ/usHuoUI1wngwn+QN9BeLpOAtrwYDYV/VS5mLrLScm9S9qeso?=
 =?us-ascii?Q?4ohtwpJhvM/qHkq7dGzSOw209/ut4MeOyoNcPrtdBRDP7ZPNncIGOhVhhCdt?=
 =?us-ascii?Q?o1ieUV3FtE+se1REtFUCM0ASnBfWpeus7SXjVgmbDnO92VxPcaMSPa8ekdY8?=
 =?us-ascii?Q?jvgY/8YZwBTlhd0oX1TItp50JnNJxX+QIqbsmQTFKPNYQSjz6NOt9jt27CgW?=
 =?us-ascii?Q?fPXpZiuK/dK1RxGHmPi7acAlH2LBrw/ZXccVBpV6u2eNibUOYFAwK6b+w55P?=
 =?us-ascii?Q?Cmt7uCZsWY/ruhouLIFzc/kptLADVceWcCMd4/MD7RmW4gOykBszMkDcUvLa?=
 =?us-ascii?Q?MZ4eXvfsaWJ4ALXEqxXLYGSSnX1G5GkFE2e6VItFsQ9Q5pVYlP1Gm4qOg1oY?=
 =?us-ascii?Q?em9vnZqORxQbQcmKU1JULQ1vxRiP59awhNAFlmshUb+kNlg4kSOVTJ3sBUkH?=
 =?us-ascii?Q?43AsZs6C7be8RQEV0CF1GEPpA8X38ZgNRrwKnk90h+xq1qL3iDXzeVjQ1CPc?=
 =?us-ascii?Q?PNJMag52vl9Ze4IdOG1GBNMLJuYOsjjOLJrdvYj/4oCyHXiaGnUOmrJl2SQc?=
 =?us-ascii?Q?4kM0zYpO6043+MexTdIWIyv1D5AYdlJ8e47alhu2NVhE033A0OHmuaTrspEz?=
 =?us-ascii?Q?9kT7j8hABZFPRYRAdHHEYJR1KApXLAdVBcjEOO3F2LATtBpwteWwVSv+1Bo0?=
 =?us-ascii?Q?qyrCoY0+NlKghGXqqjX4cx9EKT0B9bBs5r1U76SPb7gjwbfTFPvO4MiIakx0?=
 =?us-ascii?Q?u9D4+bGTeX5rc4kwjQ5ciTQ2thZRpj4D4HIvY8IvZPLJdS4296wdTWku0d2y?=
 =?us-ascii?Q?oLimVx1UG9bmlog+mDoC5Ey+nmFyde1crOIXe0rpfJhgp5WwsZEox+hbb3Gb?=
 =?us-ascii?Q?bUoEg8eklMmIcZsOOKxC2iAreplr2alvTGkpdtA+1Aq/FzEPISfIwq0uL24a?=
 =?us-ascii?Q?C9+nkvu3tmpxmBH9l9EN7gnvCXmD2fsfcVl2nFkbcg0QD9AwOBSOBsUlKjHw?=
 =?us-ascii?Q?7zVinUqb81nsK5Rn+hazwGwU9lFRpRUHcfTLSgLqOHIdwy7CwJ2HLVle4PeK?=
 =?us-ascii?Q?vC01p4XTJoTqLPcDsrZo/0vGsK9oGx8MihejCOk975rxWVrGKyldG99DT8S6?=
 =?us-ascii?Q?+YYbIbmMgfkBRbU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n9LqI5m6Vc3n+DTKMzryE3DZeKF4GZ31GuuB0DkgjZrV1vo0DlVYuE/n4/YI?=
 =?us-ascii?Q?khVMxloZ6vNy+Rh4NPvjYUp65RUMskhmOGMP1yRNkQRNdP1TsBFQNxYUSKcf?=
 =?us-ascii?Q?pGJS9sBYK8rlp/GCtSMm8oq25QGYS2sOICBysrz1ICg6GvvJ51nzRT1zJQXG?=
 =?us-ascii?Q?6CNhR3Nm6z69KsJd+sGPjWdt9WOpEq3DKs2J6XPH6xJcxftGiQngWFUBMoi8?=
 =?us-ascii?Q?OE6f3sonmyJtrwdWoOsCAYfRCPRtVyz6YffkM7z5BQd27uwis3Xo3oDLtttz?=
 =?us-ascii?Q?31/Ke3/s9kUhemw7zW0OrVofuV73JU9ZD4foKfBJGGawYiT2QfH5Otq4PK1a?=
 =?us-ascii?Q?TDdaMgBpCk2mAXOsLDmUJse8/soVXb9PKpted+KUFlEMfEwJsAT3+QJPJZeo?=
 =?us-ascii?Q?99PRr+1xSN/3FJUEKzB4WmtGrqtxdZobsFMDUHVk/CThQ9rSmieGU6G3PVWB?=
 =?us-ascii?Q?ILprXoZM15XOZJ105jHhtT6QFrDAhL0JP+8FsOe3+wcikSYja54KycEW2THU?=
 =?us-ascii?Q?BhQbdKzZXsCI/Fe0xo6UXJSZEvjJFETozfltBU9nO55YFw3kiRX8jW+ttVcD?=
 =?us-ascii?Q?RTDrT774YUji69j59eUdPlShEGswXT3mScOlaItv2ocbRYjLa/KOrdOH4m7f?=
 =?us-ascii?Q?U4ns+C8fQHIqJmwGeP4Ls5EaxVDoH77BdJf/SA4WvBdHqVRUyldudPF556bT?=
 =?us-ascii?Q?DTQy4VqIRo1+dSSxR/cU61JGOt+xXQYYJiuRkkr3Q9tsX87gk/kVhuPhf4aU?=
 =?us-ascii?Q?SiM+LOUDhKpqwrafqWtLjFR82PpLBIQNPHSXaJaYoqtaOe0xyqx1ohgUMnif?=
 =?us-ascii?Q?ZZtpuDqgJXLDKQWy98ECx51sKlJaV3nwOJ9Eq5EsRtmOTdpdeAt+tQBcLJKq?=
 =?us-ascii?Q?h2Go4IpCckLCTM4+t4N/s1a88NVoMiyNDq+31SVWy4W+e3605ZVg7OkQcylv?=
 =?us-ascii?Q?KdCsOThCuBQD1awVbCDoP5oW7NdiIVvMRENeAojKRtvehYIzQbmstCC1/zpf?=
 =?us-ascii?Q?9O8Z0+PAMxvtqwYHXTZPSIcZkF//LHIllJrQmt09AMoPOz10FuR5swOZ3agY?=
 =?us-ascii?Q?k+9E+4jD/rxSSk0ASdq55xJxSPqlKhmw9orZglSw/XDv2I0begIE9qAnIAPv?=
 =?us-ascii?Q?jq7c+Hs1pJA/JOBRz6MXGVigT/JfMwvn5zz4GE3/1887hCpQVP9ErjWk3oNk?=
 =?us-ascii?Q?CBgxbokAfVpd4hFUsnAgYXSxKoPwjsh9kLozAv6J1uuWskdJ9mpg2D6xS81q?=
 =?us-ascii?Q?FZZ4mOSOyIrIiGMje2sZD7DY7IoIkNI7LJhe6O9g64qPUrpV0Tlh1Ix5obdw?=
 =?us-ascii?Q?HH8rwK0/IkwpG1vDcLsM9IW0VbkeB1b5qoENj8OOQ1msWjeQ5tmPMf5LgZdg?=
 =?us-ascii?Q?azzcOWJqq3+0X+GwysoTN5uz/+YeEAM8JUgTTU36+bnA/DFDu2+jooZOBw4N?=
 =?us-ascii?Q?ONCplorIsEJwyB5+OrPCK9bFPqvT3SqrExyPe8UrGiqglZ06xZtmKZ4ELfYM?=
 =?us-ascii?Q?ZiNvA1M7cPytfFkcZf60vhRmEjZTtPeJRj3p9qWIGMkOK+gxuvsMlY0te8hd?=
 =?us-ascii?Q?Uy5Gd2gi2ruK2pFVUGfyNEkI6d5mBS+rmbzdG5rVCGfnwp1qDOwdZJS+v4jC?=
 =?us-ascii?Q?XLTz5BNMje35lbRzlbduUPY=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e891678-234f-4f36-be2e-08ddfb57f9e6
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 10:49:03.1928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3JlD5rJrdCkZoeXcljwMMZnL8xbddV9YMcUOIFjjn8PGvPxjUxRLfMVdNAzIRMU0DePr/U+4nGgnPPswUXO0gQQK6QbT9dBEJxiz1qCYigw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10010

This patch updates EN7523 dtsi to reflect the reset-controller
support for EN7523 SoC.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
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


