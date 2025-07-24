Return-Path: <linux-kernel+bounces-744694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4230EB10FE0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 18:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D309F1CC7BDC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414DA72615;
	Thu, 24 Jul 2025 16:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ch9gimG1"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011023.outbound.protection.outlook.com [52.101.65.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333D92E543E;
	Thu, 24 Jul 2025 16:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753375603; cv=fail; b=jpRKh+avgZImlRXh999IOJ658eCqnvzNEqi4aFj0xwEK9EsuI7e3I3AmTpbamZEm37dGX7vlbDHXGisYBxxPPHjanN7aIC0zEWKr0AU42Pa6CAw/UIlR+N5HRzSEy9AgyrjRNZNM5qQnJYJXNCX8TMCzNhjFXxj6t/G68d3Lu8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753375603; c=relaxed/simple;
	bh=g3MQKkxIgCgHJywu5Pjcpunq0ZdANWBHM/thwC+NCzs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Y47vuAolB12m9vmJUW+y+/5e8pjLNwirKBqUEdSw5Kbcjhg5TOwhWjAi86XOGDd/OV1l0l5PT/25eq7YNSCXYCLkBpngcRI9yKxHPDWxWOeEFNCENLihMABeDMmQtU43Qk4VriHVqJMdRq+Gcu/L5IwwubFafvaUZsKPzH4AlJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ch9gimG1; arc=fail smtp.client-ip=52.101.65.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BJOM3HBu+5D2HsQ0hZSrUDOB4AQgkhTw6eQpIMeRuUxBESFXHjfTqUxENCJipk1S5Q3ZgGPhV+nTXc/d2zIut5RuUg3fLxt8F/EBXip24sCTPh2y3bvJMGhjM3lKWLz9uYNxnuWJJ525LiWYYJ+oSj40PHOq7vxLEtcisPGR4ZHpt9MP7h1x5LrOgV0LjOfzUv2qTSLPE91QN+NmTGGGgxBSN3pw82U05vI19fIcnWS8V6cVRvhr+oMDHyKqfd3y3n94yBuYRQQKEEe2Hw4ueHGdX2LzKgqY6as6v1VCr7mgJdhEx5THczgYAC/qsp3eskP+grNaM/b1kBL+4yJ9wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MuVn7eMBcjLxGug645DFCwocyXHw3L2aItQ9GwZPNnk=;
 b=Y2VntzRG3dGLCz3Mgxc1VR5twJCRO56tt007eyKVS08jZGZhxDESLTG/6zdqK34x4KFVDjBRn28GXf5DYSm5QQkCDMI6R5iFq1/Bwe8gSyPjv8Z1LLSJm6Z/H8Q8n1Exg3Syl+a+7PTrUAy1MsroPkTb67vHioN/2Y+9Mr7ExFBGdxa8clKAmCF0K0A/gdmpny9TsqBB/gmNQoVkpHZX76Mi3ksFKRriE0TqpcUk8rwjic87bBzOt6Yx2g5yk/BudsR+F3IiY4j9LN0nUKinQAQi+qxGGc6VjYCcgrg9AHBtbbEdbpIz9kMhzxtEoNVuQSe3WDyGOwraOmAUQS1LFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MuVn7eMBcjLxGug645DFCwocyXHw3L2aItQ9GwZPNnk=;
 b=Ch9gimG1ixuJjMk/vFXbisbAW7L632bD+DH2cCmts0NuIk4g1f1Ez6pjOQSHcyekWoNHgvuytShprhTy7PXLrfTSt9ewV55hbrxSyOQba7ZC459Ge8sTkXlxJIc/mQ4GCorCnKVFZI8o7CO7jTXzXPpXBBRdrMFaE26sGrOQZEBYeXe9IQxyCTD91I4LqtAMnysDG53IQ+SHuJj8kUkQwXxO3mHNpdM/sE1yhZEpErMaJDn8Do23AXUVGSHtxpTAeJI9afoKjmFIQ2KPLrf2GNOu5hMV8s58p0YCAFAuIcjEapVBUshexdEc/TZ6M5AVQpapkR3rYMp0RW6BrEDRtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB8267.eurprd04.prod.outlook.com (2603:10a6:10:24b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Thu, 24 Jul
 2025 16:46:38 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8943.029; Thu, 24 Jul 2025
 16:46:38 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org (open list:IRQCHIP DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
Cc: imx@lists.linux.dev
Subject: [RESEND 1/1] dt-bindings: interrupt-controller: Add fsl,icoll.yaml
Date: Thu, 24 Jul 2025 12:46:23 -0400
Message-Id: <20250724164624.1271661-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0047.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:658::19) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB8267:EE_
X-MS-Office365-Filtering-Correlation-Id: d31c8dad-5989-48ef-d7f2-08ddcad1a88d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qV2o+IGsRaNEo7u4PlEuC4iVNWfr6BxtNKXtOQwBw/wGKeloGFU0q9WLsGcd?=
 =?us-ascii?Q?LYP2KrPaymCoROflVpIc/5Vxv0J2mnmI008d+mFpXjBTFebmsDArjZuVaN9D?=
 =?us-ascii?Q?Ko4CsqglVn8w7ykToe+2B+gWUvZ9cEIx9uF3EmzpxqzEhSGCIfiWsLIB3es2?=
 =?us-ascii?Q?eu4kj2/5pBOMAMV9dKs1ny9exk5S5H8DmoKsYDGu7U0tR1WfegcjMQVGTZp/?=
 =?us-ascii?Q?DOjNpKXmHGyYMw+LgYZzarztsJt7Cgjmkx7tX4tXHBign1dNLgZRPNHBk+yH?=
 =?us-ascii?Q?zlJ9V2ODZPDxbxQ0UcLveE+El9apMBmbu6qSaRnSquo28YGbZYcyXqD1edev?=
 =?us-ascii?Q?hkf8aKMHKMrwbo4pWO+91VWAsiEkHOtr8mdWEb7MykLuPoSTdcWKdrb6Utjg?=
 =?us-ascii?Q?BJE67ScL1Xadpox7+3W9EUWhfoRPbuGrHUtkFA9vKvR0kyNqqnBaGYNV+ka2?=
 =?us-ascii?Q?xoNew674o+XurC7hkaDHGJB8S170ms1lw7Mx8OcR+Zj3jbbOSfLXq/+SnwEg?=
 =?us-ascii?Q?z+qnSI5eVXfqBolGspZxbq0nSz0Q1/oHDyC70ox5KuuTPY0S2H6jbCEuux4e?=
 =?us-ascii?Q?JxjSi4v2bWWpEKu1xIttA9efDndw5QJfneagwj9t6cpRAzAKTGM0uvjssEvn?=
 =?us-ascii?Q?+8Hxz66tUGymsr4Yo9QUt9/jd4Wqb2ty4wOZRVDwGFITARwVr9ZZPt3ffPjQ?=
 =?us-ascii?Q?DVi+oMo72iC50U2TyoejhXCQlxBGSyRVA5STYkph74ov6F2U3/4vwBbntDeO?=
 =?us-ascii?Q?ysIlBMw5FPYjDrcLGy3t2izJ6MndJeYy3+FwP3uLjInge7Uqkgf0ItB/S3WL?=
 =?us-ascii?Q?nVxqqt+NdIiIMTXv3+V+s02d0afcl3i9vY8uLJu4t58RsIeMbtqWQogSTt+c?=
 =?us-ascii?Q?GVwb2CtZ87+pPKt+YZm34VBw1i7SZKOAhTvTx8HA506Xz1+gC2JFoXYP+0Hp?=
 =?us-ascii?Q?JHed565gr8+ahBfeKEd9d8SelSKp+zth1FQyLUsD3iUh60ZLZxHnpoXETBrx?=
 =?us-ascii?Q?81V3DyCrArBMH5loiHUa7NaH9aSxghvAH2ZV7YJU4XGQu4dcewiLo67QGq6j?=
 =?us-ascii?Q?Sy9d6e7Xn4WzZI07oWow+ExwNp1v2tS7Kvj8h0gRs7inmnU+5E7KfRiYQE7V?=
 =?us-ascii?Q?9weEyBxZG0S93STQhhkj9MKiXsHXvef/3IDM6ByxEYoWsUoXn5ut5YGy+eYW?=
 =?us-ascii?Q?5tI1dY1DLpQ/qZHmndwRWRINmcwTf2dFxhnIOfx71X1LLOYBvpaqHohYsQkT?=
 =?us-ascii?Q?RYpNRxzsPWLJJOJ/XwFbTn6+9k3el+YKy3WfV0amXfFnpy+GB5K9x4LP/4az?=
 =?us-ascii?Q?SZgLNI1qE/FfDaRL4QRJcuT83pg1xjFaV5oCXqRc+27b6QsCSIpw+/ajmxyQ?=
 =?us-ascii?Q?6TOwsNDP8PKzfolEilBIfBXh9qdjOZETkOJ3BA7t20MZX9J/pRlvV5PzZiMO?=
 =?us-ascii?Q?CNb0r+g7fpA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mZYcsITEF5DIKwEMhAcS8knmB+OoDPWHcM4H5tZMcExQCvVJTs+K8nhZG9MY?=
 =?us-ascii?Q?jFSuNsXLRPCxRmw2ODd00Y4xeUlY8i7oo3x2vLIgBUhMOziKuYeRSRlvor20?=
 =?us-ascii?Q?O1W4kCrozxT9dAtba1K4ViiXdtxj64l2PlFzZUUTIVWR5lmEfEd4oiskkHOr?=
 =?us-ascii?Q?4ou94m6JHVSnfyVpk8bp0u7NzNhibJgPXoZ1urbvk6u1x3UD07wcGtuV461u?=
 =?us-ascii?Q?Z2rEsbTsjDqHVPRaBP1sdKKmETw1CsBNwL84HreOTcowRwo+5ySF15xuNoqW?=
 =?us-ascii?Q?z7M7nXmKUYWK5/HtbsDpyWowULsPLP+9nEx4F2id88+r9nWDiWaeOsO9tId4?=
 =?us-ascii?Q?ellHxZk+6RttqA/SVYlI/L87L2Wn8LiSeBjIzt3DmbYSetM7rlafDHWQwPdz?=
 =?us-ascii?Q?BgZen79qZPOB4eugSOJZOzVL1nAL4jJlOPDuucc/RN6qcEJPyAgbXxi8pm2r?=
 =?us-ascii?Q?0FNgp9piQdahWk4SS5AFbyll8kalmm9bhKV2I/EvrNTdtwuKWavSy0qGqS6C?=
 =?us-ascii?Q?7sGV3+ndRRta1wa1vIST5eT/h1RmFHB2DUHDe0QCemyHagdRvCzNHwec22vH?=
 =?us-ascii?Q?q0aPvsCoyCouM5Zam2mdSX3rpG00HqZrNBMxKbYifvcx229QBjnc5RJANWwU?=
 =?us-ascii?Q?uZg96u/N5Pp4NjKOHUEnliSYquvlgN0RAq37Sec0WgKGPM1rKyFmfG0TWaGf?=
 =?us-ascii?Q?2hkXIASc1wXpa8eRR3fClQA2htwLNu7fMM3H9lUEZDKzZXdcLHFy2BG3QTbt?=
 =?us-ascii?Q?3826vU4VevZAXZxzXt2k5HTB6ONomVdpEznmQvVBuNy2OX2134P1V5DGmPb4?=
 =?us-ascii?Q?XbC0j578XxlPnx7H9aXAfMGbgvW22c8z+YLUQtCx+7PHs3USHpHD66GEapnE?=
 =?us-ascii?Q?rLKe+FtAjKEPUR0B+weJN1UiUGeUoCJACp12fmSBg9FBNGp9C/+1GfIJRyJ3?=
 =?us-ascii?Q?aXj58+mx0lcimYOaavTyLowpjZ6I6cYrc/O9hrep9IE6wjEfHVK+3gDUDhGk?=
 =?us-ascii?Q?wyqe2KiXbjnkX15Y+CT8+d/oh938cfLVr8XY5FT+aqGeHjmH1Oyabf2FkCeo?=
 =?us-ascii?Q?LT7ybFqJIfp5SP7T+z3sMzIAQ6VObJJjQScFxrUQHqGCykRYZ3qcdOlQk4fg?=
 =?us-ascii?Q?sWfrIg8eN0vqGCFfGu5NnrN2qkuWyY/E3+kdg9tqXxDrdJ656HrWOiMgHqtC?=
 =?us-ascii?Q?Ik2bhK/xgiSaYfgY+H/gAJBskVrmWMfBC5c1d5kkXhZr9bYzQxEgC3Qih0AA?=
 =?us-ascii?Q?dCwUYn+mHc3rM2lZv+xYPAzuaRKM23P7FZ8I1VUZFK2bWDcnMTkBlGQiXKZS?=
 =?us-ascii?Q?l0YXNHZm1cWeWeAWZ6yAeePmC0nEcwJKKXAhW4P2Evr42NTc+e/K74tCD9vY?=
 =?us-ascii?Q?Czs3WSfhbpAnXkA8D0ge2FSKm8f+Fp1ad1JqJX1FyDgNs5/R8X5w5GQgJusz?=
 =?us-ascii?Q?ozCVc3/ZCW0om8YPysmDJDcKq3CtvZyzUQwICeU4zuKDX8oGAu/bwxSHz8jD?=
 =?us-ascii?Q?aWZXN9slOXU/WJxiqcbn0+eSvEfLZtSmMv3VPvh5VQw+Zead1fPhK7RXE9y0?=
 =?us-ascii?Q?yz4GCWmvme07M3Ixj4A=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d31c8dad-5989-48ef-d7f2-08ddcad1a88d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 16:46:38.4083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zMPVHCbIVh6ottem9U/gE/W0LiaSzdzuqkrNEWM2dHZr3JpRpk1AeMq2G6lf9rhPfwWtO2Pfplx5lMhCOeYwDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8267

Add fsl,icoll.yaml for i.MX23 and i.MX28.

Also add a generic fallback compatible string "fsl,icoll" for legacy
devices, which have existed for over 15 years.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change in v2
- Add conor's review tag
- update commit message for old device.
---
 .../interrupt-controller/fsl,icoll.yaml       | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,icoll.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,icoll.yaml b/Documentation/devicetree/bindings/interrupt-controller/fsl,icoll.yaml
new file mode 100644
index 0000000000000..7b09fd7d588f2
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,icoll.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/fsl,icoll.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale MXS icoll Interrupt controller
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - fsl,imx23-icoll
+              - fsl,imx28-icoll
+          - const: fsl,icoll
+
+  reg:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - interrupt-controller
+  - '#interrupt-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    interrupt-controller@80000000 {
+        compatible = "fsl,imx28-icoll", "fsl,icoll";
+        reg = <0x80000000 0x2000>;
+        interrupt-controller;
+        #interrupt-cells = <1>;
+    };
+
-- 
2.34.1


