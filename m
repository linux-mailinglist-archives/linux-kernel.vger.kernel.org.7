Return-Path: <linux-kernel+bounces-744830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE6FB11159
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 21:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0F0F5A74F1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 19:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CB3221F32;
	Thu, 24 Jul 2025 19:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nq/wIuWB"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010004.outbound.protection.outlook.com [52.101.69.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D423C19D093;
	Thu, 24 Jul 2025 19:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753383842; cv=fail; b=oD494aowmP9dHMc8mkEyo7pD0N8x89oboBlkMahNNuefz9qCWVMTVHtxDZpPcXnAukNM+T7y9S9Noxac9l+IaICXcPWtJpp98fbBuvgDElFOFm5tfHfKUcF1s0Q/iLmlTLV2UlyOgoydb6IReJallCSDNkUeLcDrNfQyyaiIiac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753383842; c=relaxed/simple;
	bh=WqWBGJnU6uXIwXEKmKST0AZyXf4eakqcSzBZDyGIRu8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Uq/gW/9yAynxywBpvQTWu00QQd8m7Z3lG328jo1BhSX7X6+3dzErUVPwYHgtru2XNbFbpeWLqiCIYggpD4obOx8cZ/3Hccc6sH5B6xtB66ZSWrpLcQGB4S/aMbG7WEFrBSkvg+c/R2gQw277hcq05ky/BH8zYf6K+o7jt/iQWyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nq/wIuWB; arc=fail smtp.client-ip=52.101.69.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rsN9NK9A5ysB4DKjVfQO2MhpDGGBKGE9rjCQVOcSJvLxu1UnY6vRAbrSZ5RftjmG4u6k9jb7yqZI6FZgCi44r9XFPuBxhvlRxMI2WY4oR8wYRrVGMwBBvFXz1W6kPtRhilopVuA9DRtldbirCGSKjf+aG/wUKtkkUhliDqdwvfV7sQsWyki8YfXo9raParaKjRhyg41+PgBjOIN0gcqyOqGoC76ZErUnBl6QXaaHP6wEzi9bUfpscywqHnGl3pVqxFsagfFLVV43zTGg8JJjFk5+us5fq83vRN4lza2/41qr1QZf91aKLswXu7BtDEsv+5WiiPKVY99A5kpIp5Up6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ElEXyeZhH95ofqP659NccKyIj1raktMWByUByPIolr0=;
 b=wtLNwIz5rltOtiuMUyt23MSBaq5g6medVDwCXQ47af6oZNV083UUZi429MXySui3GFqs8TXwH5p73TkP7kPRAVhcINxBvCNexYpc2MW4c7+ILgiWfdqnw8tfNcyjjzKYxCc/yQgIHKlO0sdxh10f/aowzmXl5lOlsfbBU3CKjqhwAk7y2413E7/KII01iMEm6rt9xXzuC8JCoVxuPiT9V6FsnS2A86qb+MuwD0P/nmx5fomX0pC91h2xl27qBC1j2YIzxYuxRMmqIHwk76reoVjMGw+kllfyoZkuqDE6jCtyUuzkgIRIk/g8xy21sky7KvJZSG4wbb73wYj9rd4KcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ElEXyeZhH95ofqP659NccKyIj1raktMWByUByPIolr0=;
 b=nq/wIuWBY4Uwxdjh5zCXpfPlxnhkjRoWse2mqpFQXMUVB5hSoKVIHMiRlxjTeKeFFCrS9bRsQBJqGm46Eb/Mo3jxOl/+GYF0KfESHIviY2SRXinJwoYIBULDEmzcryBfhvDaV57ipXtxo8lNNqMqjlQprrUsRhCcDgVJDPcOQMaau/MrE73jLI0PnsaehuLYyCpbXn9ZruQCdinOZt5+3QulfBFA1GXTmB7VeFO/IjS/bb3ymhiQxB+3An8O1XCdahWnb0iyUBx5fpdPkd0IO/innO4wiqOTgqnxQ4HzcowR2X85SuZWmq6xV5geIIOwiiibHLxiySE4Ez60yfNNgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8271.eurprd04.prod.outlook.com (2603:10a6:102:1ca::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Thu, 24 Jul
 2025 19:03:55 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8943.029; Thu, 24 Jul 2025
 19:03:55 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [RESEND v2 1/1] dt-bindings: fsl: convert fsl,vf610-mscm-ir.txt to yaml format
Date: Thu, 24 Jul 2025 15:03:41 -0400
Message-Id: <20250724190342.1321632-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR10CA0017.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d8::7) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8271:EE_
X-MS-Office365-Filtering-Correlation-Id: dccea088-7f69-49be-fda6-08ddcae4d5e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zZxQUTMB9s+vuKs/p0BA6qaZCK5mj5jaS9zEFg2aQ4i5s6lspGc+Fm3Tg7CW?=
 =?us-ascii?Q?Bs3VyMMmyCptraTwzUPnMN/g9JkWdOMAEoaqul+YsEWU5QO3PPJDodfDUC/B?=
 =?us-ascii?Q?cql6u58GidRFmM3aGpOheeQcE8JHDjbhh8uql0QLKHT8yGtYUf4NPNEVGNqs?=
 =?us-ascii?Q?lNU6rjc8unTB0RyMIeqY4seMkAc/M98wNEfDmvd499kTBL2PPj3qs2U6Vc5X?=
 =?us-ascii?Q?2CXon6Q80TNKON8d+3Li6PRNCLP/8VD3/uK9RGl36ERhdB6HlOuBpnqYc4mu?=
 =?us-ascii?Q?dvresavHGxH88f6wHgDehHh1iUpbUYM3eKD2syodSxrHaSkKYRGrZETZPKYc?=
 =?us-ascii?Q?r8wVktcN2fVta8oAOekki2lHzWfMmUaZ1HFZQ/TDZQozRg3L5SUWqDWHKDTt?=
 =?us-ascii?Q?TSHSpM9XtekCFrRtZdfAgfMQfOilXgRGXfEAepEahGsZQfR7sV+fBST5MEsT?=
 =?us-ascii?Q?rkFWM7k5Dni01dfdkXTsxq9amGzY9Y1xvK3S0stxU1f9n2vo7l8I/x6mZf44?=
 =?us-ascii?Q?jS5FOoba6n7O7TN7Ir4N0xpuPhxuE4Mw27ThCNi5kVeOuCrOcSnkTza4KVkE?=
 =?us-ascii?Q?Ejpft8KUD514UlKHX0TiYDQpWj3fI6rE2BJFgEpdG1eeQvKUKNFkzKwrspgr?=
 =?us-ascii?Q?6KtGV6pRvIoURZ40y8Nu0MLsSirVe+UNHK19Ijd0K7RnuGAsK+5it7jSWJXH?=
 =?us-ascii?Q?VwJ3Mv1WsSHvEE93gr/3y2CM4ae2RIdtYSxStMicMrWg9kZ9fTNnig84c8EZ?=
 =?us-ascii?Q?X9ndU5f01xFqbxRROAfu4aqwPJ+CCaRFDTsvjFV66TZ2DWPua7A9PFXtuLgc?=
 =?us-ascii?Q?rLGtAmh/+Svsm32Hh10548yfa/KWgnNNZaYHFXjS6kthrgpDRo0WxE+Ur7hg?=
 =?us-ascii?Q?FL3nKsGc2Mho8hgLwXtAOelPEt2tIEUq+uSD8sjyem+jv7NfVMTjyMTPKEJk?=
 =?us-ascii?Q?FnV4RUSrYhIZsvJIqEzgppJIoip8Imw+rR1mNVul+0Xdb/qHPLr4GMEl74Ye?=
 =?us-ascii?Q?oYY/xsuuFYG+RzOTqp0eQaPR3Zthcy4Qepur8igmSIJcjdRWOTQDxP2wROwk?=
 =?us-ascii?Q?fLsfFngDGLp5BysCCyqqKhfpJKVuTNlqYOULGY+41DAScKF91a6LPbCWWR5e?=
 =?us-ascii?Q?xqZwpXsSXSKUo9wPxK6SmcPu6PDBCgcuNeVPSSPusgx2IkBsIHoctCmEDfZL?=
 =?us-ascii?Q?Xvtgu6y7efX7pcFZO2DTW9B6rniPlPZq4OBV+od88aQecAMQkA4qYoMl+kXt?=
 =?us-ascii?Q?9J7FoUu90XqRSfB60/6JqN66jiRYXbwT+UTZsNMRagVpr2OUllxvnfNWs83Q?=
 =?us-ascii?Q?atoThhe3X3VVVI5yGTZJCGEcg17t+jRmzA9+Us1nywSiD38/Tb5GUQ+6f3Z4?=
 =?us-ascii?Q?yySaIg6KTTeVQPYqwMYrF8YMJgczkfPqlfmTkcvYBS1KsCpMIguNuHTXx8T1?=
 =?us-ascii?Q?Yx61KlGO48M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(19092799006)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q4ajoLDySefLFg0dG6qpfxcfUq11+y9M5f2LEfDNj7nYoMhkT3CmleHmHywT?=
 =?us-ascii?Q?unRP+1XFx53msIBSonKIeJcLAOZXHaXaIVVJp2nvAtp7QNQhrH+e7Yh9+i1m?=
 =?us-ascii?Q?EYkRDrHawisk4DjynpVgFwXs7jbdwps0v2BdwXhvoWfWRJHVC8xKZGgbzCxZ?=
 =?us-ascii?Q?DPZewWqISTBlDwxEsvBhD+9HVM7si5aN+sLrJKv7hLiaOQRRY0hnU2GzmW+6?=
 =?us-ascii?Q?XfYHb2v26FNvOaan1OzUKKS+YKzguqqo0uMgM/gYKpQUjncSM2oZ57rIUo1q?=
 =?us-ascii?Q?w2w1/ZxJ/3HqbJ21eaR3ArxTruBFtRTIDsIM+hauc6z//fXAFMh+jAu9ZizB?=
 =?us-ascii?Q?ZoBEOhPJBH79CJsfQTRRh+izdWSzbTH8SEts3SWnwM7x2aBlhAiRFyQ0wjwt?=
 =?us-ascii?Q?6tBzToalfX2yb6J0yvxlpj4K24fQr42uMAQOptRy1+bJSOCuhNTje/yWog3y?=
 =?us-ascii?Q?QawTiqrfSyLn9ituUyLseTMddTuL1jwJM+4JSO94Q4xiWMlkrU99buaOsr7L?=
 =?us-ascii?Q?seNcGQHflG5h3CZDtHGhQ6eWb10NuLFxOQxw0bqCFawq5LMCg3y7PwjUNm5r?=
 =?us-ascii?Q?IKmbRYHyjryRg3PGoUuKNlKXlhkiLXP4QydcrgFtKgtcDLzXf3mG0ubLg8sM?=
 =?us-ascii?Q?iYT6lELjaG+dA66NF5WB7DlQrVmO8dklb1uNqDPQM4CIwSWoaW/wAckGQbJP?=
 =?us-ascii?Q?sWxPUVcT8DBFJneXzqlICf1VGQ4Sn1TeuRHkq0TIxAXEKMWoqrJAnkOhsS8Q?=
 =?us-ascii?Q?NjgvibU1Ox6nVVLsJ2t3R8sSdaQl6ThH75vK4pkymJZeYGNO94Y7o/K2JwJq?=
 =?us-ascii?Q?WKFCIMjloKOlyn1O57itkDPj/06BU86Dz1+MhfO0qra4El2tpdBE6vW2bPMx?=
 =?us-ascii?Q?aHxpBFu3oJCFiqAyLOD1xZsVBcd8lY5qTvz3tW3CHmnnHKEi/adiVFUqZjbc?=
 =?us-ascii?Q?HIfnZNmMrF5G2ZxjCHon9SZRgLefdYcW8Jf6jLMgqV58b1cYdJ9+yHQFpff+?=
 =?us-ascii?Q?Ndk+Dy8NsApIK2e/P3z6fdmsSI1h5zVpTuK6qMYOYvQwzebDg47V83p6GFtX?=
 =?us-ascii?Q?BvO0d6eNaGbYgKjGsRK9MX1L6+fBo//IsSh0aQAPtjwQ6KPBjaiV2nQhw8+q?=
 =?us-ascii?Q?fDcfs3uW6QKpxv3atzgbgNJO5RgKtfJAxy72yK6GTVl5zadPjcfGju6yxAAw?=
 =?us-ascii?Q?ZL86a0/gSm5OoUDte/C4tmPVYxXg1Sprw0Ch252cv0JyR08PszM7dneEyur4?=
 =?us-ascii?Q?Hvkd7Vi2pYbWfptSNXyw5scmuvM4zgm7bqHdRFOm6cIjYlXjMQ57eTHatHL4?=
 =?us-ascii?Q?8RQIdjk3WUAJsYTLuCuK0HBPFQD8RWhZP+DHApRIf+lW3wKhvKS8MWfiJbGy?=
 =?us-ascii?Q?TgT/mkT0Uf5ZcSLDktiTKxiNnPRKIhQafdSHb9U05aaDPkgnTtXtEzaUcNfo?=
 =?us-ascii?Q?4hiiHPYGN4ThBLvP//OSC/wWOB700qMwvoacBtShCDJaGEM/V5ejDlGxFzDa?=
 =?us-ascii?Q?Md6eaPbVZYjf7RowBpHbJU+BIj9I+rbR14KJ6MVZ8/0iR2o57Fx5KJ/44+Df?=
 =?us-ascii?Q?sEInTHXg7NkmEaxqCVc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dccea088-7f69-49be-fda6-08ddcae4d5e7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 19:03:54.9976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tE9Fd3/qmV9+ypGVdtnBQ9s6i/hXIl4gc1kXgr7IsYMD7mjjzlT3pHah+jeqZTQH6Rr28WPh4A+2axWDu1hMIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8271

Convert fsl,vf610-mscm-ir.txt to yaml format.

Additional changes:
- remove label at example dts.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
V2 resend, add Krzysztof Kozlowski's review by.

Change from v1 to v2
- move under interrupt-controller
---
 .../arm/freescale/fsl,vf610-mscm-ir.txt       | 30 ---------
 .../fsl,vf610-mscm-ir.yaml                    | 63 +++++++++++++++++++
 2 files changed, 63 insertions(+), 30 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,vf610-mscm-ir.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,vf610-mscm-ir.yaml

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,vf610-mscm-ir.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,vf610-mscm-ir.txt
deleted file mode 100644
index 6dd6f399236d5..0000000000000
--- a/Documentation/devicetree/bindings/arm/freescale/fsl,vf610-mscm-ir.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-Freescale Vybrid Miscellaneous System Control - Interrupt Router
-
-The MSCM IP contains multiple sub modules, this binding describes the second
-block of registers which control the interrupt router. The interrupt router
-allows to configure the recipient of each peripheral interrupt. Furthermore
-it controls the directed processor interrupts. The module is available in all
-Vybrid SoC's but is only really useful in dual core configurations (VF6xx
-which comes with a Cortex-A5/Cortex-M4 combination).
-
-Required properties:
-- compatible:		"fsl,vf610-mscm-ir"
-- reg:			the register range of the MSCM Interrupt Router
-- fsl,cpucfg:		The handle to the MSCM CPU configuration node, required
-			to get the current CPU ID
-- interrupt-controller:	Identifies the node as an interrupt controller
-- #interrupt-cells:	Two cells, interrupt number and cells.
-			The hardware interrupt number according to interrupt
-			assignment of the interrupt router is required.
-			Flags get passed only when using GIC as parent. Flags
-			encoding as documented by the GIC bindings.
-
-Example:
-	mscm_ir: interrupt-controller@40001800 {
-		compatible = "fsl,vf610-mscm-ir";
-		reg = <0x40001800 0x400>;
-		fsl,cpucfg = <&mscm_cpucfg>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-		interrupt-parent = <&intc>;
-	}
diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,vf610-mscm-ir.yaml b/Documentation/devicetree/bindings/interrupt-controller/fsl,vf610-mscm-ir.yaml
new file mode 100644
index 0000000000000..fdc254f8d013c
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,vf610-mscm-ir.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/fsl,vf610-mscm-ir.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale Vybrid Miscellaneous System Control - Interrupt Router
+
+description:
+  The MSCM IP contains multiple sub modules, this binding describes the second
+  block of registers which control the interrupt router. The interrupt router
+  allows to configure the recipient of each peripheral interrupt. Furthermore
+  it controls the directed processor interrupts. The module is available in all
+  Vybrid SoC's but is only really useful in dual core configurations (VF6xx
+  which comes with a Cortex-A5/Cortex-M4 combination).
+
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>
+
+properties:
+  compatible:
+    const: fsl,vf610-mscm-ir
+
+  reg:
+    maxItems: 1
+
+  fsl,cpucfg:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      The handle to the MSCM CPU configuration node, required
+      to get the current CPU ID
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 2
+    description:
+      Two cells, interrupt number and cells.
+      The hardware interrupt number according to interrupt
+      assignment of the interrupt router is required.
+      Flags get passed only when using GIC as parent. Flags
+      encoding as documented by the GIC bindings.
+
+required:
+  - compatible
+  - reg
+  - fsl,cpucfg
+  - interrupt-controller
+  - '#interrupt-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    interrupt-controller@40001800 {
+        compatible = "fsl,vf610-mscm-ir";
+        reg = <0x40001800 0x400>;
+        fsl,cpucfg = <&mscm_cpucfg>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+        interrupt-parent = <&intc>;
+    };
-- 
2.34.1


