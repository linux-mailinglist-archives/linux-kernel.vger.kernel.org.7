Return-Path: <linux-kernel+bounces-803382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26AD8B45E6F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 18:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E2757A1BB7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 16:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2510D306B3A;
	Fri,  5 Sep 2025 16:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hlVFtopx"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013040.outbound.protection.outlook.com [52.101.72.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBCF306B09;
	Fri,  5 Sep 2025 16:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757090538; cv=fail; b=bb69VHMHGWWRBgWY5AeMAizrKFDF8avZ58tVqOclnkRDlOnCdDuse14zk76D1g/sjikPfq0sOKo26FV7navsXsDXXbmLOLJhKOGNcKt7aod/OukAoL0OWuDCv8Ux9aQKtqS9565wFAhRXwKprTXe8hiEqKIu3BRQi56JK2Ugu70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757090538; c=relaxed/simple;
	bh=LvYMdmCglCnTLKmLPkHUKDtX8sr8e12eqpnI8ZTj/rU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=E9tce4tYIfXGxu6uQn2DPkQTVOQy6ir34V3sMPr4CAone4AkS44fxijr2LQDfCNJuWuAHeKBQqbpPipa5bdsVrmcdgf8/jpyBTVquwbDnr13uobyI6m6Q0J6p6wQnlODoD0qX8AjJ43S1ayPSdmrKY4MIDE9qGUJREQ/DgbGYMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hlVFtopx; arc=fail smtp.client-ip=52.101.72.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MBpzCverDDluSSffJo4QyQdQjS88K5veVF/TmDmqlGEJ/cU26ZCFgmYiciFDjryZ4ve40J8ZXV7YrcXXmZlptzplzRb1OwcsSXRurks6s47oIL2ymKzkf9LX8KLdIvcTNy0vpFkhiNO6I5yfUT7lo9NJn/YGMd/mVL+YrpQQGDc8QsXXD3UNQXErukLA+V4Z3ssGmJWu3uykGZp3IxjLg5pkXgrbGHmuYvVySlVQ3mX57idbvmWpIBBT11xftpUsjaRU1bFQFVNOwaRIRLK+YquKN/B8lMl35o9PJ+kbUFUf5B7jfuTxwPZQA3y8B17yZD9Y1QeZetLvai75dFK46w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rG8XLrTlw8fPKUeRB0QFbMhQri0TFa7zbJQFeovgMuQ=;
 b=K2FHieXvdfOa3q7oHUzPa2+w8f6kMsqEFIs0h2uP3hqDRToLGCbI2YBV7CAIjPNHIDrNDWWbSecwf8A14AEkNQkmrRNaQAUfij3PAGsWLCEVeeBP3ySwV5xbcjvFMNX/IJWctWV2NwHRR8Lfv46UeqfzqFoeHMbBzkOu0jBOuQatP5bvOIR+flDcPFda1J0ITf/XZN/FOqcnw/YwPwrSI7cAVFUWIV5U8eTrziOyURlfQbhmRKSx/sI25hR98yKAtAf3lMWAruCbIARLcJcXrCftGjU8m21NnxuBt9RxNtniiG6Y3ebaT33W9rRrkENQAa5GxcFomGugtxfM6IDnfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rG8XLrTlw8fPKUeRB0QFbMhQri0TFa7zbJQFeovgMuQ=;
 b=hlVFtopxiVrfgTZ+mI7WhRm0J4p7f8B31S7aNDWsu/C3NIVua+FIzJwsrI2yShAhGPSRnWtBYem8UXtLpvTWhTuOC/NmmU+b6TdnBj3H0spwktCkerG917HbvFuGuyUYBFxfSzGW8Bs70ABqJZSceaJuweB3UikoVZU4D13MM6bDV5vg7laLgWqbfD6kw4ZFpXsxb+8j4qi10EI5Tum7ooAsDv07LnPcS8L0PLj0gG0SHZPMefczuGptNZJBX64D0qG7zP7L3QSkuqnW1vrxP2kaC/MeCj0GMuWJytXfpgmFwfcVRdv/NU1dNX9YHThhfl4YcClLWdyH1LRi0tMM2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by PAWPR04MB9861.eurprd04.prod.outlook.com (2603:10a6:102:381::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Fri, 5 Sep
 2025 16:42:12 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%5]) with mapi id 15.20.9094.015; Fri, 5 Sep 2025
 16:42:12 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH v2 1/1] bindings: siox: convert eckelmann,siox-gpio.txt to yaml format
Date: Fri,  5 Sep 2025 12:41:57 -0400
Message-Id: <20250905164200.599448-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0263.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::28) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|PAWPR04MB9861:EE_
X-MS-Office365-Filtering-Correlation-Id: c117d4f4-4288-491a-54ea-08ddec9b29e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?256OhCfD/VlWcd7k8XZoi0fwc4zJE42LrtfkHA5QYQNSv8jebCpYX029MqUe?=
 =?us-ascii?Q?XO2osQDW6GXHrcXP+j3QyYNapD0R6ba47gIYDgUG6geiKHf2qqjJCorvvOhm?=
 =?us-ascii?Q?jV/Qm3UbDqPyi3PmeliSwGApnyP/EmY9hAmUsoq8XT5gJZx+o+61dXcTNRBv?=
 =?us-ascii?Q?x6JRT4TneiZEdsrxVxYYUYroX+L3JaaumZVy6qlk2J3x4/5r2EBTvMl75aI5?=
 =?us-ascii?Q?YCohHQjffFwY1FSFF5JcxipzWcF48VYUuf+3AcIG9myb8uVBnT/nim+PNECe?=
 =?us-ascii?Q?5dcdnxwvF9Ncj2ykII/HhsfMDC9hK31qj/Xb3SPaYD19izCYhv3gsuadwVBa?=
 =?us-ascii?Q?sxN5e2F3qTfPPB86TYLjYS33fVUbnGu7uOD3QU6UU0sP0Q5E7VcMVtbss77p?=
 =?us-ascii?Q?yqCaR5O+zwQwr3jlniKR7is18gXLJrUBpPPKaJjO0N0BCWT8202OEspxnIZj?=
 =?us-ascii?Q?SPuG6c/6babj/prEC3Lnwc4TSGD0fhOQRWyUStLBQ1ApWfNLtp1Xp9QcKz/h?=
 =?us-ascii?Q?d4VcVjR92ELMM7MpuNUcBlafd0UTXEUT513+OY59rbp90LTfMuKEwV1lacNt?=
 =?us-ascii?Q?/o9fRIwEYZbfo0L1HN3eAWb9OQR22YUT3VhQSUFIxjlbYJzaMZaVjV89A9PO?=
 =?us-ascii?Q?jrx8i7XMU5FXcUAW7Tb/dyijWTdXa+uc7sugPSdanTqVGKJ1S6EbeMU8QocE?=
 =?us-ascii?Q?d1Aa3UVl4gDGl37C0KflTQ+scXl8l42w2F6P7McI+dJNSyRHwAd2JZHsH4ok?=
 =?us-ascii?Q?vsGDCb9B2Me7jUXHflujrKfnSHBmNTrZhVraQZi//Tw4QJ3qaXHnOnVWeSR8?=
 =?us-ascii?Q?Dg2QXTKmCIC4qWfygrMiTq+pb9uOoqsEhXnTRD3MgYhfF1juELBimTfGy2QR?=
 =?us-ascii?Q?swOUKdN8ibi7uw9bAs2yiv3r+Y8Iw8q4+gB3dPMDHpmrVJ18L1Ph6xLW6sWZ?=
 =?us-ascii?Q?hoCDWNmwkTc2onEg4s7Qc/iJqF7SN3a03YfXGPe5P2h6aiMHsO+FwXF75r0N?=
 =?us-ascii?Q?RmL2RtCd2SN7CsJMjeNZQX6XmGwVB4PyoPK/UOe9GSCaEz/6qjxvNaMRutYt?=
 =?us-ascii?Q?gEsEi/z3dhV+tXwqzZaH2Zb3pRDOvOeWDhjv28iouor8/+GsaFn6Gew0yx/o?=
 =?us-ascii?Q?KyMOE5Xhcrwv2OWV+1ZZFjlLfcn8bTdED7nanR6FRN52irWuuWUps9AI1P91?=
 =?us-ascii?Q?Twr8+DxqkHjyawRA0Q11VGqVKxE+sZI+Z4uYnfgdfkBcAuhdo6N/0EF4g4BU?=
 =?us-ascii?Q?UT+T4ksyBXzEYKLHbvAJlpwwUEHdevuzc2uqqDEKTcrdROzfk0T2fhVD14oM?=
 =?us-ascii?Q?Ta0SNRaRe5C61vseN5Ny0ULtv5ZjdxpHKWtklyF5V7srWhV0QYOX6kPJvdq1?=
 =?us-ascii?Q?T7QsS7p9V+gSDd4TdrfqE4vegMTII9bZa1gK/0knpY3XUSWi54kz43Q9cBgP?=
 =?us-ascii?Q?mq8QIW9fscu9AOpcDx79Ny4EMwKFPfWn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tLSEEXlPYfvmlSofDX7vLNy7t+OlOIoBvLdt6A9x2wZPRSVAj6yD0Ucj8h2L?=
 =?us-ascii?Q?KntHRwiTU02Gd1x3h9dtlFjT8BCaeP8Fv0lz7mq2piSQqBtfWYTIbn/9hRNi?=
 =?us-ascii?Q?qBkK2UBXO7hVegH4okOxreoaYlBFDA97wk8ZApTjcGssgcU69zYz0Swto3lC?=
 =?us-ascii?Q?azMKImMO6ty0NHaFYYHR8QA5T7Bda7DiVCCJ0m2GInRueZsM1YIeoOl/0EMV?=
 =?us-ascii?Q?hvk6N8FCGP0cGX/ILG6Ceccb/7uqy87JtNqP2gptcan+VxKtH6j8KvNDjiBm?=
 =?us-ascii?Q?LVZLOGZgWx+enPEtAlE5NUfnBsqs/10++cVUcNG5VqJ9AXfuDphAJJ21e1tv?=
 =?us-ascii?Q?VyFJmx3AK/Giy6uvJF/fpkeSJ/qRHfoCqra9WMdnfP0JPCiCeUd7yrjeUSK8?=
 =?us-ascii?Q?uuKRmP8Ojk5OgXtkaZQbCeAF6wJyYXt+lyvOo8UKUs4aecz50F0TESGeVn6t?=
 =?us-ascii?Q?2vmjeGCRGGmn0SH/BmrQ09AASqw+uRFEPzx/Xeyd6jjmNyaf1D92jiuDfkYE?=
 =?us-ascii?Q?ot7MeACjR++etH4rukUyiOpfSg+FEmEcCHuoi1V3uAFm5C3QwrW2ycyq0fii?=
 =?us-ascii?Q?SMYVfptZXkEQX0Gs4wG1fHxU7+U5Y+bEnpKynPvbnh4wXhgxsCthw8TQQfpS?=
 =?us-ascii?Q?7q6eK7bax/5Yq6RhJwZgm2pmCBcwRGhP8RK7RE0rMbJOc1lt3lYvE0VY8S82?=
 =?us-ascii?Q?1NXBxV0cScXGEGUBqS5sE+fkGhme4zZEuv+2tG+BSO9SWrNL+K8Ys8kcoldR?=
 =?us-ascii?Q?lb5mZgAQRTxkEREjtad250IWZ3nVw1DZKj6nDTybXsuYEyb4XUR6hbIv2bT2?=
 =?us-ascii?Q?r0JPh28JMZVZneIczM9FkKmKuLpz01jIGvsWdjATU2OqpWxgkt61EhPmKZO+?=
 =?us-ascii?Q?s7FEkZrJwzIwKqKqN9Kr9rC+6EwnqxMmMw//YjMA8A642zVfZbqBS6PrDi3Z?=
 =?us-ascii?Q?ggI1mKWdd1L/FCFnveK6qsjK0MQntSJVNDpjPiAXVJq6fws1Drcy1knPcDVM?=
 =?us-ascii?Q?BY9qNF+BwEGg3BQXRIghjuTwx+Hx4BJ7EWnqKn5NsBBLBj7SycnBySVKdeRT?=
 =?us-ascii?Q?f8fmOQa7HzJ7jqtuHNDVbFRKlFut14PhWXjW+ZYCpLc9m8REsOtHuHP0OXfb?=
 =?us-ascii?Q?nQFUcWW7qn8+D423Nyp4bVzMiQ/OB0bCXVDGKNILP4JN69PZeRccuKvQNOgj?=
 =?us-ascii?Q?Ywwjdh3+3qFvMwlbKfVTVPTeEgjKdV4CVMj0t1fnySSOw9zedplpQ4o1EvRA?=
 =?us-ascii?Q?2tgJEeQKjPOBPi1NrYeu8BFihi0kpaeuF1oAclTi/09gZXV+mxZgB1TZwqyc?=
 =?us-ascii?Q?6ycT380hy8ncMa8XNx6RBAtHreFJRXAXymlVLKDHOMRuSxYqEqOVrfwXNyi2?=
 =?us-ascii?Q?uK0gM0Xa6Az9vIDm2bEoHT7UmLKKUjHX4Luz0UU1SOcMweaI/us0WvWFYzQA?=
 =?us-ascii?Q?vUjaVbH55TCeyVNDCPWby1gCo3CJkyEGY3SjihdGPvQHavHgmquakK7Pc977?=
 =?us-ascii?Q?AdS/nz2L4JtMHyqHqFMDGGuo5bWPlgk+G7eHNnf2WRkK5UaEXEBhL4TsMjqN?=
 =?us-ascii?Q?Ye/H3gK0UgIHKT+MTdzr+UpUV0jSRMTjit9yH2Ex?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c117d4f4-4288-491a-54ea-08ddec9b29e9
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 16:42:12.6444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oiE+quIcVBoZQ1gVAwRR3huLdWvnYz4D7Fu5ucsBjT9FHoh023Y5/WmCKqh6sH9Qryn2eDqY+GFilyl7r2FgBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9861

Convert eckelmann,siox-gpio.txt to yaml format.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v2
- add missed additionalProperties: false
---
 .../bindings/siox/eckelmann,siox-gpio.txt     | 19 --------
 .../bindings/siox/eckelmann,siox-gpio.yaml    | 48 +++++++++++++++++++
 2 files changed, 48 insertions(+), 19 deletions(-)
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
index 0000000000000..2ff204109b930
--- /dev/null
+++ b/Documentation/devicetree/bindings/siox/eckelmann,siox-gpio.yaml
@@ -0,0 +1,48 @@
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
+additionalProperties: false
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


