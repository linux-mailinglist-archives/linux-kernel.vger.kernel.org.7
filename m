Return-Path: <linux-kernel+bounces-801568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB9FB446C2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 21:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59F61A4373F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 19:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC4E277035;
	Thu,  4 Sep 2025 19:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Mdu/hWf5"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012040.outbound.protection.outlook.com [52.101.66.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF27277029;
	Thu,  4 Sep 2025 19:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757015638; cv=fail; b=jpeGJ8KUshLrs708DdtAe1CnfrvTMTwSiOUHSYBlTBowwuR5vsFKY4HvC/OsySKqcgqq9CcACtZNd7otOVV02ZARWwWZrqaGmyhxgmh9Y4MbB3kh5NQNqRVGmfmMeBff1HsW1u4Dwxinr4vc5wVxf+0IAjeiTIgAiCgeJQtvkgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757015638; c=relaxed/simple;
	bh=o9tbIOkdglAlC6yQ5Vj4WXUqhL9yEgAqD7Va/qJF0t0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Z6bA45+tSdXFSY56J7m+YIleOn61okX3OifVpd8YNmxZz40/NlYXBWHNjZt1U9qW1YCCqf+K93+tzV1zWdQ8/G8lXePkz+nngpOKK1RaAoSGmVzygukMu16lX2XXYvzHo510vmhkTf9bPXinVg2pXt3ZBlt6Bd7ZQtZ2lXEhElM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Mdu/hWf5; arc=fail smtp.client-ip=52.101.66.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NkWJVXbgn7m/fsjNXk4mHoDaDZR5CtVuKWMDpT9cy6FengGAfoPgXjjZkdxstbDmCsltrm9vPckGH5EOzs7D+dcJTh2El1T6LZ5Uj5lN8UZIOmpRAv7sekVQsAcwEhlia8+Wt7ZYL+wZTG7YnHO6hL14kafgcWF0uFSGIico8gHiWM14qpgNAQDAAwI5AilYDEkKAEdQU3Bh5f6yIcLisKh8cTV6+0ZNKAzmiv5waxb1myhz0xorhKOyx2jqLEBd9dGuHWVbuFVLIO7fNM+ohdb5dYKXVwYmc1XM+UOK55q45wmhDceg2Bcraeqj5qlfU9UpbcQa/Z072UVg32bMwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KApIgwyZSalbaz5qHW6qwohsHdDKOMr/ccTNS8OouNg=;
 b=JQu1EeqJwLGO+XPvbtSkz1Pfw+vxKfUWcPZKm50veSXuEBOEHhv3PMnMFaH1sLGDkbP870hFyqxPH08+h00iaKgRbM9WqO/4r9cHVDgZBTBG6fOt0/AAOe3uPeKpDQ8obrm7F6OztTGjEj6Q/K6h5EdhEMhDVH3xlUNUBsRTZBvMJ9QdBhJw7obVXN9Vw2TKPai5TI88T7iF0tSu0uTtqCIh6iqPlq80K2PA5r+Ix8veE7s4/GpfkkNKz3Whrx7m1gBxLiM0/9R5BaDUWTB/2/fnuTUuGaHjT3XcF82MfWGJvKHV80dPjiMZpnHV6kYYYknmaLPsl2XQ6EK0zuQB0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KApIgwyZSalbaz5qHW6qwohsHdDKOMr/ccTNS8OouNg=;
 b=Mdu/hWf5ytsoBr9mby4D7dSouEhGOS1SJomaqNBDFeScucaIFScLL8GXfF5YtCiqVyQKgOsnoMYyElunCZUCs+VKkw1694QGL11uN4+I7CZx3mM6LNr6UIKZO4oIOA9sprh+yryEa0VkAP/3cUKx/5E1DIH7ElbHy+YrjVgw+7gZqHVzknBodTVaGr4abJP98X7XE70JouVCrYcgGndOjsArocEKyk1DZ5p9l/zHKG8RILki7JzuATvQY3Eb1psVtbXWr6oDvxkl1okArnPNG1jiN0NjS2rVzqIc3QFVjyvJtPrM1faceL2fdIvehqe2lic4XXbfXeBN/s0N2DKexQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DB8PR04MB6860.eurprd04.prod.outlook.com (2603:10a6:10:112::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Thu, 4 Sep
 2025 19:53:53 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%5]) with mapi id 15.20.9094.015; Thu, 4 Sep 2025
 19:53:53 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] bindings: siox: convert eckelmann,siox-gpio.txt to yaml format
Date: Thu,  4 Sep 2025 15:53:35 -0400
Message-Id: <20250904195338.530618-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0006.namprd07.prod.outlook.com
 (2603:10b6:a03:505::18) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DB8PR04MB6860:EE_
X-MS-Office365-Filtering-Correlation-Id: 3645d8e9-f136-45ce-ac64-08ddebecc6aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GjLl8X70OHuXcvrt2QJk48bHR1HdEXHELBxVB6xRorkftWqx6ORcPWdrF7GM?=
 =?us-ascii?Q?PHiYrX6x6PS9Xwoyzrhtoke+grHjl5tAehgypmLv3ngCunpR2bY2QNkdbnvQ?=
 =?us-ascii?Q?c5FNIKJm1LFQONm0Evznc3pJOQC6aEeKf1AdDwe3r9JekjSaEC0XQonSliKo?=
 =?us-ascii?Q?LiYoZB2nL7WkukFcUlJvkJ5vpDFFHH3mD8qJknEBhvtfZYpTel1o8AFzVWpG?=
 =?us-ascii?Q?I96Xq2SJlpuG8xOJOgIP6UN4sqIZF4Yv4wqzysd/rhIDy2t2pUox7mL33/+N?=
 =?us-ascii?Q?ot1EDdyMcoTxP4EomaDipB0ZYg3WdG0Dy4AHNk6X6sIfIDitsKlg/hesufju?=
 =?us-ascii?Q?5ZB4HOWEzl8p3zjtB1yAV54oZWCDnJW+GxQ4cjikQcm+xZN+MbBk1KV8ulFi?=
 =?us-ascii?Q?Bne/AikOt2kqlphTZ2Y9uW0d2jvbp66tRJLYk9iBYb/ISZqOmxdNPlrOBjDM?=
 =?us-ascii?Q?fA6ZRkOy/o2FOe3Z8wAkPZvfrr+ueyQC6RD8tJ98oduo/pt3UcKXeGc0EfvA?=
 =?us-ascii?Q?GymP4mJ4LsjlTB7Gzw691Kt1Bk0hiiZ1bWiefTsJjrowb+ts0SeitVFEn8qF?=
 =?us-ascii?Q?w7E1oESEt4SymYZ1Px8lqWra3bvvDK0PzIMpKalH+itjYPBT1uCo6k1EzTfO?=
 =?us-ascii?Q?yq3+QSgNWSX5ZUiM7RaQKwvXiAXYdOHoMFGNS/lCAwOXaTuUkrrcMsEMzZS3?=
 =?us-ascii?Q?Rb180YBxTuV0DgWbjPAJLnKgjPKRVoLHWp1Ta836M0vuxrXkw9+FQam3fHC7?=
 =?us-ascii?Q?f2kdIduXkK0yC167nHk6tfLK/bB0IGY6G8bqojFmWPofRSkx0r6jrvXx4Rgy?=
 =?us-ascii?Q?5zZtRaRrSOydSF0/hGh0I5MFkzR++F7vu5t7fZP0l9UYA452n5orc1denKgX?=
 =?us-ascii?Q?VwEPHxYK0kwB2EYpbTboNVlxgVyw7+bP3RPDISiKXe0WgIroRKHxJc42/T9c?=
 =?us-ascii?Q?34fEdTI6IVHEu5DiCWs2Df+vBFWTKeSgPSe2B1X0AgZDiP9a5O+xXQKc4Lj9?=
 =?us-ascii?Q?JyVJtBHnkZAvRmUSj8fcj2RKkGVUiWBRMMxRoLFkcWyECT+9Gs6EmAKJVqSi?=
 =?us-ascii?Q?wQZBzq+t/YgaxBZGnmnCYkDmBwfTcnOJJAd1INzmEx8lNlDhLobZATOI8ptT?=
 =?us-ascii?Q?kZxFgS0p/kj9KeDiBPGOQnlYr45IdnotwUGuQcBKXBBlQOyLgUBZ1IY8fmqx?=
 =?us-ascii?Q?RMziszw/3BJt1xjaKNDkeJpKttaye63sguR0SXm706ofhYYvekEOcIry/MhR?=
 =?us-ascii?Q?FvR8nquVTdu/eJbNP0zI/jvxcA+nU3qwaQ46JVL90ZSeh/r9t1NJ38mU/kZ1?=
 =?us-ascii?Q?vyyYVwcaLl189Ck5fBP254z7wgzTvegrTpJ8AltM/iwn4Kv62I+LpyDPiUV1?=
 =?us-ascii?Q?PyEwP34j79UYEZmegFlclqegL4AnJk9OwIxqLtsMf6V9Sl/jBH0QyjYqpo3g?=
 =?us-ascii?Q?vCxmWgxYvOLXcm+Fjd2OXZaP33ECDVr1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TobqjvkfBt8EQmLwdWOuv8S2CwPyUc9feWkQ0QVLD+EfGq3iZJhD2Y2Ovxll?=
 =?us-ascii?Q?tOrxJgn7Un4JCIEUcwlw309E5/PD08iXu5Y/8SZeGWZKOQ3NEIiL+tu7rlu7?=
 =?us-ascii?Q?Tu5PnX1YsS0wKfk4DoVkCCsO6C1MtZHvEa9vqyZvuHqZZrZN0w2l2oy55OS9?=
 =?us-ascii?Q?U7Mi1vAWS/8ok6aZpB82p6nwYuIpSZakNe4++k8pma/Pr4F8QagkQnDmnhUZ?=
 =?us-ascii?Q?2ntHfFopA4isUWqxBlFnfRvFMOuNqW9eizm9+6c+t93/sncLeYaRl6lQz/r8?=
 =?us-ascii?Q?eQibM9FDMYxTfcIVKrfDNEwlZW/r17zUbA+/gnlyP/3qBjTRNjCCp75I+T/d?=
 =?us-ascii?Q?Mvgt2esXWyw1uBVDEWPQJVKg10PhW2xmdX9MfIqmut9TW/OVazQaHMu8rsqJ?=
 =?us-ascii?Q?vSza+9dArqZP0fBnkEWXGyPrgbb5Z+YA6dXiLFrBpojSnk6DLo/FXmmd4U2X?=
 =?us-ascii?Q?3TjkIRRuJHly2GM2nkc+/UDg7erquN7mG9pfGEx48spBCmm+CBLBNz9fp04p?=
 =?us-ascii?Q?R7R/V2dH/J0O0Q1kXIs8bi3PWX/tURc8s6IudGybC3KEiKVYKxmby/+MejlQ?=
 =?us-ascii?Q?mI7/WBPGLSzp9bxPAa6bbm5QnuXeiUErhfrmMryKGpY53Zmd04962sLHRXe/?=
 =?us-ascii?Q?rJGxScoQpKX0y7HaydIB6FE5ZByHrDZOZV0yk/8Kdagw8PvjPbxBea7YXiLX?=
 =?us-ascii?Q?E4DlfDryYkxEZjbFqfg9LYPcZ4rn1xCrvgtI3Y6D21zzcIGuWOOvksflZE9Q?=
 =?us-ascii?Q?dwlk/9uG1P2VPTe5BMWWXdzNPOMhHoZDfhTJpGjzDq02FNgewaSZ3KHDQrI0?=
 =?us-ascii?Q?827d9k/gxwl3D4wGT81tlnNUNYS+uPCJBWZ6334Lp1yNllJ0qEWoCdvp1VKr?=
 =?us-ascii?Q?TBh9wEdTZRyilUCJVeVclAP+z7L3fiFSlMRZk7rteR/W/sn1B5ilT71DloKy?=
 =?us-ascii?Q?0+QgksZRcCzqOOIMxBq3fxA1Rk04unpCNWjO/C43RkYVvmTurXe+IyMYKJ7s?=
 =?us-ascii?Q?e1ybJjx+4vlEmbqX+Ze9p8ZBjOXzDrlRz5J9NbDJJYybkdWllmS8Y9lTIUm2?=
 =?us-ascii?Q?KhmUeuUKVOChBqvRUQjpby/uBmIY/MO3jx4xpxfeRkAO9S0+xFS7tet7FfcG?=
 =?us-ascii?Q?QFiOvU5MPW/6oQOSxipskHHNRl1Fx9FF3fDKhsb04KbADY1ePueD/AXKnDTl?=
 =?us-ascii?Q?l6d/KYZNKpLuL9/tEuldLgmhuNuhDXos0kqG/CTI/9eSJTj4+XBMWSbhRPJk?=
 =?us-ascii?Q?Ts4mBnAfiN8tLijZxRGQW6SwSLNzejCHN7zBPegZwral78ATd2TGd34n30K3?=
 =?us-ascii?Q?ijOOD74V6X9leToLAlsgfkox14N7mdUFE5x1HmkU/Mc61qm5K6uCa2nhx+KV?=
 =?us-ascii?Q?TC2UPujXkjGP7ySLWDkTRUtd653sqRiu+gSA0mG0Q7OuHYTUG0p9GxAp3QtU?=
 =?us-ascii?Q?HCi8i/EeRFLgtae0PTjD0G7Z0Y9bItwqlxnJPbk/EZHEGRI+yFpI64Nb2jFJ?=
 =?us-ascii?Q?ghXGSA/VswePEfTHB8SbcE/NWqJMvh+2IzNJxJx0CMp6vm847cC9/yjjGOFy?=
 =?us-ascii?Q?Mq7xCyyG1KiQpESebinnErN2aqoeccRZy5LGFymN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3645d8e9-f136-45ce-ac64-08ddebecc6aa
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 19:53:53.6967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vVLsHT2shKAI+6YrMFJYYvIarTrmyR2V0F+e3phGGfq1VdGCOqJO/j7jaQvy7M1VQ5D2yVbLtc1neyamf+PKSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6860

Convert eckelmann,siox-gpio.txt to yaml format.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../bindings/siox/eckelmann,siox-gpio.txt     | 19 --------
 .../bindings/siox/eckelmann,siox-gpio.yaml    | 46 +++++++++++++++++++
 2 files changed, 46 insertions(+), 19 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/siox/eckelmann,siox-gpio.txt
 create mode 100644 Documentation/devicetree/bindings/siox/eckelmann,siox-gpio.yaml

diff --git a/Documentation/devicetree/bindings/siox/eckelmann,siox-gpio.txt b/Documentation/devicetree/bindings/siox/eckelmann,siox-gpio.txt
deleted file mode 100644
index 55259cf39c251..0000000000000
--- a/Documentation/devicetree/bindings/siox/eckelmann,siox-gpio.txt
+++ /dev/null
@@ -1,19 +0,0 @@
-Eckelmann SIOX GPIO bus
-
-Required properties:
-- compatible : "eckelmann,siox-gpio"
-- din-gpios, dout-gpios, dclk-gpios, dld-gpios: references gpios for the
-    corresponding bus signals.
-
-Examples:
-
-        siox {
-                compatible = "eckelmann,siox-gpio";
-                pinctrl-names = "default";
-                pinctrl-0 = <&pinctrl_siox>;
-
-                din-gpios = <&gpio6 11 0>;
-                dout-gpios = <&gpio6 8 0>;
-                dclk-gpios = <&gpio6 9 0>;
-                dld-gpios = <&gpio6 10 0>;
-        };
diff --git a/Documentation/devicetree/bindings/siox/eckelmann,siox-gpio.yaml b/Documentation/devicetree/bindings/siox/eckelmann,siox-gpio.yaml
new file mode 100644
index 0000000000000..c4ecd071a08dc
--- /dev/null
+++ b/Documentation/devicetree/bindings/siox/eckelmann,siox-gpio.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/siox/eckelmann,siox-gpio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Eckelmann SIOX GPIO bus
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>
+
+properties:
+  compatible:
+    const: eckelmann,siox-gpio
+
+  din-gpios:
+    maxItems: 1
+
+  dout-gpios:
+    maxItems: 1
+
+  dclk-gpios:
+    maxItems: 1
+
+  dld-gpios:
+    maxItems: 1
+
+required:
+  - compatible
+  - din-gpios
+  - dout-gpios
+  - dclk-gpios
+  - dld-gpios
+
+examples:
+  - |
+    siox {
+        compatible = "eckelmann,siox-gpio";
+        pinctrl-names = "default";
+        pinctrl-0 = <&pinctrl_siox>;
+
+        din-gpios = <&gpio6 11 0>;
+        dout-gpios = <&gpio6 8 0>;
+        dclk-gpios = <&gpio6 9 0>;
+        dld-gpios = <&gpio6 10 0>;
+    };
-- 
2.34.1


