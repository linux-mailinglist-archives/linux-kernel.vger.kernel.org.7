Return-Path: <linux-kernel+bounces-757917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9430EB1C849
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 17:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07BBA3A9853
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 15:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA54290BB0;
	Wed,  6 Aug 2025 15:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="MBD0MqkP"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013040.outbound.protection.outlook.com [52.101.72.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93A2298994;
	Wed,  6 Aug 2025 15:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754492761; cv=fail; b=jJREB1ra6eJlQyk8WgSjPsCDgPfTpx6E3UhOXb/hyV+blIaLjI4V3GUPyUfpoiAMD5F9ZTDHFHY4cW0hU8DjlNpM9sqZQqaQIRGPe3hkFNI/oxx2M2W99jM7H333efyoXnjcY7OStzQfb3XZhF+TITUDckwYzIGLxmXaTXLj010=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754492761; c=relaxed/simple;
	bh=ii4eO4DNuzlmZuID98aszSjdv7XkrdwQU9qlj3GRxPE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X8xKE394+9kSHaw7wE1ibqXFkJMzblDTy/+QjlU9OuYVUTsKK3h6xTXuKSnY0Tj/qkHugsD+1NKB97SziA+2MFPsWsZDWYVFWpjw8iJzGF15ay97keOfFBxmklXstPrIHBpaazNilRUSVpHACLdg4p+zpkws5dxLlmcNCcnwlvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=MBD0MqkP; arc=fail smtp.client-ip=52.101.72.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NUCt2msLmz5WE43cClnAyeZ+vpqEFkui98JZvfaDSuBI+HKDZVkdvgyH3yzNMsYln+WADi6gV6FTb3LlCtgL8HfzUDJY/umXXWhbeNnGBqePOlTc9Ddxt2Ec3/zHE0qHSHm+Mx9p6KKQiea5BD7BUFqv0J27zhrCPlnCt92F/X7fLRRrGjUf45zB9vgdHd4x6dLKe3Nogb3KQ/cpHoHbzQoZXbAPpHJ27r2GI0aSJ3vmabR5JHcq/E4SMrTqHPPcFrAu9iND1frkyQbokOLC7MLM0wslAsZkPnA1xV2n9Q9ezRf0qNhELrPDIw10O7sc+XztlXlNzT1JpEJWf2RqCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uxpWLA3vL2C0KV/UrdyNh23C+//YAbbhAstcFDQEL4o=;
 b=kflaTogxJPT802yT0Qvld0TgpybbDYz7jxaYHdEtZ2rxb/FUeNGE/kA0n8gfuHSH0tW3GayNxzGlKw/+faLICIK+l8sbFO8fcGyaqPg0HIso/3ioITz8pprbPhIdtRraEXx2NJl6kMVzkEVivPu2JdpMwdcvArfAXUod6sEHJfQykbYZ00T4zyEZjABQQc0+T3CFeOr6CA6pJZmZruPcnVYZpzje+GyNqgkxEqok6UKqwEZH/+mU/Vjbv2gx34O+U3EnWrYWUzcWzjnQm5dCrmvaJzPIu0kLaekZJbeOTQQsVr/u1qpPThCeeGTutPqpuXtAwglplnrBbGgs3wQW4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uxpWLA3vL2C0KV/UrdyNh23C+//YAbbhAstcFDQEL4o=;
 b=MBD0MqkPp9T2PzDrrmOou0wJRa7bGvqq6vdZVuCtNL4535mmMZST4Y/759WT7e43FggptIkklY3b2tuKdY3/R3GfFs/3lS6hP/Ty0tdX/Z8+OanPeEZ43DV5HSFCdt1MdP8E5URgkbbTS4vmJaYwvYiVhz6TvfGAEyoBWu6Gd+Na/5r010H98bftFDoPxOb7UtuLNnOHufAWPYcES5S5BNjAsHHNPjOpLb7HW0CIFuk9T1/X0ne6/B1ZjDPM43GTTqVfeuALxQ6L7dMp41Wq0Ei7tvfLQ11X9ix8rDmPKiCxt+1bghAKoyujkXLzs8bPe9X4T7h2As1gH6AaUkBvDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com (2603:10a6:150:26::19)
 by AS1PR04MB9429.eurprd04.prod.outlook.com (2603:10a6:20b:4db::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Wed, 6 Aug
 2025 15:05:55 +0000
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::b1f6:475e:de5d:8442]) by GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::b1f6:475e:de5d:8442%5]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 15:05:55 +0000
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: imx@lists.linux.dev,
	Abel Vesa <abelvesa@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Frank Li <frank.li@nxp.com>,
	Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/9] dt-bindings: clock: nxp,imx95-blk-ctl: Add optional ldb property
Date: Wed,  6 Aug 2025 18:05:13 +0300
Message-Id: <20250806150521.2174797-7-laurentiu.palcu@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250806150521.2174797-1-laurentiu.palcu@oss.nxp.com>
References: <20250806150521.2174797-1-laurentiu.palcu@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR07CA0001.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::14) To GV1PR04MB9135.eurprd04.prod.outlook.com
 (2603:10a6:150:26::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9135:EE_|AS1PR04MB9429:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ed2a59c-cf45-4d28-86b5-08ddd4fabded
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BtY1l0WdbFCZXrJ7UePqlMl3AH9C3+xjhfra7QyJwsch4TWnaqN/EO40c2wK?=
 =?us-ascii?Q?uMotH+WlV/OvGwEE6otvwS1i8Qa52nkBpfTP5cvmcP2AL66dZJtVjy5Bg4CR?=
 =?us-ascii?Q?yIlQ82gDxijfGwQaJoBE66WzLfbwdKlVP1yuf6Z3QbLGewz3Cz7BfiDSJp5Y?=
 =?us-ascii?Q?w+W7aI4MMFvC+D0NXaHEdKznkkm+SJD775+CfF7lVv1qdOdQ58fecT4uzSe/?=
 =?us-ascii?Q?ffUpTcMpbkZLoFThyUW8XPioFxaO1H28GWEh3xGNW/KTOX/7cHdGrWGIyHKJ?=
 =?us-ascii?Q?kEKZl/cKajAS4go4SsA0vIA8/a9rzlsr6XWcOHbVchLt2hNEGc7vz4rU3+Fs?=
 =?us-ascii?Q?5u4IJEU5ocoCklHXdXe0dgFI/dS9JGvmEzyseBZ/sKzU2lxRsbrcvZtzeqLr?=
 =?us-ascii?Q?arkySqiecErqJasCEMB1MvfBDRLLOX0Z7dxKFbt1IlVYi39mQtGZUU0dYP0i?=
 =?us-ascii?Q?ODCQXQqYHd9+cm/EBhhkNSYiOB+L4cRGCQQKVVV8FvkGq8c0c1LrRXoRpMH7?=
 =?us-ascii?Q?Mi2tsaSTYmKgQ4BOxtMnk0agw9csNbMciGSis3seeO2BuOtUgvvs1i5cn2RE?=
 =?us-ascii?Q?3WpnTmZcBUqQ6ECW1WL+oY+cA4oz2McNTZcUzlxqginglBRlIMYLmhUKxmHi?=
 =?us-ascii?Q?svQMa97DPAAwkXZL9GRMrDKJWW8Q3RB4J+jtT2iFxjXgxYJDTDgJzkbz6Wj2?=
 =?us-ascii?Q?i8OYZd7EIss7jvHGyADdcrWDD/crB78K8altQ/KK/idvw4Cm1iK+jSjnYE3P?=
 =?us-ascii?Q?OyXVLMI56/szEwmNKk+xLX49R96T/McgZFh+W3Jm8+4IsSAW3bl+4UTwV+Lw?=
 =?us-ascii?Q?YOfdBfBoPQedyVVineouGuF9vh1lW/JDkoPyalpKIsTBLA1tLwZPdhbRNiF9?=
 =?us-ascii?Q?0XriXtZCoiYV3Ny7ku5AibH2iWz1EqMwqE/ylH7YdDUkIMd1AR10xNFRumxi?=
 =?us-ascii?Q?F8zAsXAIsa1cFHq3e6QSQnOfkoYhHdPObtWkPuByLN30/iS+oX5X2HVFvapB?=
 =?us-ascii?Q?el26xT7YYLRcDnMnYiqDNmyuFZ79T+C7eDTZNtI338IAN0f3V8IZaTW6SvW6?=
 =?us-ascii?Q?Cd99fG7fWKGDrXHq1GKqh3mmqLELT4ObUge90wTPpxI4RzaIF/Hv2p+7UGz8?=
 =?us-ascii?Q?AKEm3fg1LhMkUYiGmoC4W1Atj9MJ1ww32vSbUM/q+6ooxVTtyH13YKF+Sz5a?=
 =?us-ascii?Q?VARVNSAopJu7d/MdDOxr3Q/6216Yvhc7BaNV3gbDg/DiCiKPeT9iEKq61Jrh?=
 =?us-ascii?Q?vEn2U++87djN8gBTjLenM2tz9Q2Qm6vPPDeuWiorgeugM6qqKyNWh+uQTNNC?=
 =?us-ascii?Q?An87YPOmpD9+wUNY7Qv9fGLnU7jntbhHc02J8foLuMKps8TO0l/5DlwsFSqX?=
 =?us-ascii?Q?hcDesxxDPcxkIAHUquD2qR45hBjskEn/XZSXik9FFXL+lhD4H0cdDiMxr3PF?=
 =?us-ascii?Q?IxifvFqqHRU5Tk1k/1NMp2fbtJhEYXO9Z6Clk5yC3H939DcyXFYnWg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9135.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qGG7bwq5f+V/qwbsOvi8czrgCwdD9aXomoRnHwyXzNUu++qNIPnprgr7y1cc?=
 =?us-ascii?Q?L9wLqb82NakTf7ulk1NlxCrSH6kC+wfzg6wDeI564TgsaR4JAzB1VYpYs5zM?=
 =?us-ascii?Q?IBWdrSKLC6obRCBOE3y02KXKfHByKZTS0B0mRLj3aWRvM/O5K3stLex14JRw?=
 =?us-ascii?Q?xVOEVfKvAvFR67PRgm0uPvmxLbxELjp2sNEosDrh005vfi3cmzBOmb2yKONU?=
 =?us-ascii?Q?9KyRbo/MVPdufyxgo5Uz/f0fd4hm5gQzxZX89aZRpa3f0DMjwNtF5lldEhaQ?=
 =?us-ascii?Q?31X+PauFFNng2YbKmjAiAQeUWIv2IsDaD9exC99KRXRu2s8uJfw+OvY+VbWO?=
 =?us-ascii?Q?1F/6QsACrP/Cb483JCwroWYbAZ144/0/KvdKrnkDfFCIdj+YMfEZH/dCw7bc?=
 =?us-ascii?Q?RJT75QgXlxoe83fmyEmrMqOltOijVBtvK14YC6T5j76BnRNgtv+dqZbxCXEi?=
 =?us-ascii?Q?+m3dLkEcVZtLE/IlolqHVG5gYYag9TDr1MlgWnZtY7y9FdIq3w7+wMhU48r8?=
 =?us-ascii?Q?xEeoayXnGh0GXvZuAfi+Y1LsLs/2npBmhwUSkIgkZfpwooOxcvstz6T3kGCW?=
 =?us-ascii?Q?pwC9E/7gzsiowNeNsct7pmtpc3cqKOzUhao1qfbjNrSKH8d80RbfYBTshEcD?=
 =?us-ascii?Q?bwd0+6rpishy+87hwgBXTFyYIigtlhpjKaXrq+OzIDRAddh4SMNxIZGr2ag4?=
 =?us-ascii?Q?8+2ZLPltA6BG/F+Pt2oAN2wMuI1XwlCUrK0+0VIauXj9MQjHFZEnQaNxKWe0?=
 =?us-ascii?Q?EarmsnN9rYWyIdKesivHIalSCKwAYuypK1HgtJmoQSk2SaHwRfVvOzQ0wOgR?=
 =?us-ascii?Q?CitAK5BqK9B8oJm09CuGw9wCv0bMG52esBcskxO/eMv8bWKWkfAocs7xTL/y?=
 =?us-ascii?Q?vlbM/pl5h5pz8npHPzxrj9fjJgf3xDzhOeH51iiOhC1VGhDOf4XjlpLUI8nc?=
 =?us-ascii?Q?0Ul9bmrqSDV6/PXp4uOaAuAm8n9uATZJT6meSMIY6UGPGnXc+TbwOUry8l4l?=
 =?us-ascii?Q?egVal9lW/8LB1/Ytx8DRuBtwhHSgl2aX6Kpoyt/919fSLMfakEWHI+plctP8?=
 =?us-ascii?Q?iruRSnjTRvS6WA4V0++NlPmxBnrkhIarFuGdILeLwtAjEKrBD7ibirSjpJqc?=
 =?us-ascii?Q?4l30wP3edlMpq8kQGM/6m8xj0rCoMT8qferAf1EadcjrpkPfPLCnMpuNK5Wd?=
 =?us-ascii?Q?HFB1oiuDWmt2UwR254TBlbsk1sMuExnE4AuY78J3DmJQ2tm4w8bcI//Jnriz?=
 =?us-ascii?Q?nSRM+0u55v5syNMeMhc5prFoo3aT3Volrx7eu7UyxINTMcDzF6oJbjDwQ/Zw?=
 =?us-ascii?Q?hnqgaQlqezn4c5Y+aMXH7UcC31j4xiEGk/j/Iv5pg3TO+IL2JnaA6gj7vyhD?=
 =?us-ascii?Q?12GExulHvfZw2qjvURtUHN8/NQKNM1r1j+QbIinRBg/uCuZTAbbPek5Q/QPW?=
 =?us-ascii?Q?8DmQgmfloigzWKpEh10VtWsL6b9RuRcePEuYY3rFAM8+fsLWdU0eK02/WKMX?=
 =?us-ascii?Q?t5OyUQXTsitpV15gkl1ntt0C3VSxaEoYbiNvE3q4o2eAHSg013c1U2LUbrsV?=
 =?us-ascii?Q?T0Wov8MLlrBhGuxXbCz82KGlU8bmCmx7En5y2cSgZOGGxinBDniftBAfmBuG?=
 =?us-ascii?Q?5A=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ed2a59c-cf45-4d28-86b5-08ddd4fabded
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9135.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 15:05:55.1938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bwVhSwQrtf74jd2B0AJghcZVNuurqGhDB5tBz2HLKS5djYPYk8iSCVh+5dAE900oRCGdXVU8CPmCVxK/RKzLRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9429

Since the BLK CTL registers, like the LVDS CSR, can be used to control the
LVDS Display Bridge controllers, add optional 'ldb' property to handle
these use cases.

Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
---
 .../devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml         | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml b/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
index 27403b4c52d62..836004de4460f 100644
--- a/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
+++ b/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
@@ -39,6 +39,11 @@ properties:
       ID in its "clocks" phandle cell. See
       include/dt-bindings/clock/nxp,imx95-clock.h
 
+patternProperties:
+  "^ldb@[0-9a-f]+$":
+    type: object
+    $ref: /schemas/display/bridge/fsl,ldb.yaml#
+
 required:
   - compatible
   - reg
-- 
2.49.0


