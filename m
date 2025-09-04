Return-Path: <linux-kernel+bounces-801184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7E1B440E9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81C691CC1767
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30D030C341;
	Thu,  4 Sep 2025 15:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eHuQI3e3"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010029.outbound.protection.outlook.com [52.101.69.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7358A305043;
	Thu,  4 Sep 2025 15:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757000674; cv=fail; b=MuiVZfzlj+FIWpeNclDLwHMRptX7Ky3R2Vea0ipQGVhB/hJU1U7iHUC6KantwZIbchAFnvXb2mp47ZfRCqkDesrdWS9KITvW8Q0zfuuHIxr/Sk54Lnk4Pcr+LC4lkbSv2dCerOEvmJVb7L3Re59cGgXnzWvM/w8s16pgZ9jZR7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757000674; c=relaxed/simple;
	bh=jrY27lCa7sn90Fug8n24nUsXmxNhxTUTvGlYz9gL01I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XoTIOnipSFUd4+9m/k7Kumld9xEzww2bVYRwEMSwSPF6rNuniYwrGd+BRgQieEmNlgDqp0a29KZm3b7fZykpG5PkUlLeC+pXTEZRh3nuLrs6SRbl1MkLPYXQJRDDhaGUT4JRqMDO+GKb1czo1RhriuJBh2EgK3FbjzwoCnydYL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eHuQI3e3; arc=fail smtp.client-ip=52.101.69.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pCCBkVGEM2eo8tfX81qIy5sH4+te9Bm3kkvuTKmgeM83C4kyoCVh1N1YHhTmnKNNMegvS9v4l5qJC8XN4j702fI9HVa5nlHv46axvIzvbdKALyY6i3t70NrRjneJNvFaxeT+c56LhpfeX6KtZsi108sqKjyXyQvFHa1oqUR3qHM1GViCpylg8+b8apGL9xzFMepRE0mnfZ81JjcQoqDVpXYz78ImKkF9qeKxVSm/GWFIRWICwcgY0i/dR/crYU0bXPdhqIMXIkXivtcbTbgyecEUlbV7GeCPAIDYDnIOKMPSqwhr+QDLzmT/M/6Ux1YUOJM2uCs4+9dfabQfO5GuwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ppAZdp29gZVkknv1UXKdQqu23MjdDUU/KjjVKIZpC0k=;
 b=OJWCwSABjhb4EAm3eR3sd6LB09lR8EKmCROEh7UmBYyp5gS5alGIKDQc/3fMvfAXvcjWPaI3e6Yqm7wNX18Qu2PM4lA9MBdvTNPn/2VwR+Pm0uuApmYmW2pqknVaLKDobUv6nPcMSS9NsDUlHTa+3HXkIUZ3/qXynouCN3KxNu4cpUub06OzlGaChYCTIlqL1IogRZNCt3bouCex8RBAce//pWv+rCCWML7aEJAbbGWR4irWiqMtUsb32NAqHzJhL9ej0tFbJIlBcv47upQKkqa9tkMFp8Pg9qC750To9dB+C1vKE78HHEJq3XLisWc8ejyW+vLnSbZAalUmrVTlFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ppAZdp29gZVkknv1UXKdQqu23MjdDUU/KjjVKIZpC0k=;
 b=eHuQI3e3vyGsUXwcBIoy6qhMw2zUg8Z/PaW7W6KmK0HXbS4jLfttwSrO/10tpL7YLODSd21w9zqy9rbo1UiVwPhG5rmMQvhcO7ZdV3o7BjGad1HkePNO+rIw0gHY7Do+Qv/n4f3Ishfud8wlYP7v/11Wv5Ug7RzO5ekyBhBDYlWdnaz+rmMmAKgKYK0CCdNTmM7IPBOwwYttELbdtiHh7SJbQ0BJiG4v6xJOmnFX7BVYw0esgJPA6Tj126CgaNVcyTYSfezXr9CHjaTqbvRFdUyShbaRmCFl9hjsGgtMNyi/8gXyoPqndP89Cer4ImNjzs/6DYvZUcWjowUHaL1jWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AM9PR04MB7635.eurprd04.prod.outlook.com (2603:10a6:20b:285::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Thu, 4 Sep
 2025 15:44:20 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 15:44:20 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org
Subject: [PATCH phy 13/14] dt-bindings: phy: lynx-28g: add compatible strings per SerDes and instantiation
Date: Thu,  4 Sep 2025 18:44:01 +0300
Message-Id: <20250904154402.300032-14-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250904154402.300032-1-vladimir.oltean@nxp.com>
References: <20250904154402.300032-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0060.eurprd03.prod.outlook.com (2603:10a6:208::37)
 To AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AM9PR04MB7635:EE_
X-MS-Office365-Filtering-Correlation-Id: dc563813-4168-44eb-4a1f-08ddebc9e9db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|19092799006|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3IEHzqhU9oALOylZz6J0whzet7VZp6ggVSedhxe3FGcxHSwBWWK0AU09gx33?=
 =?us-ascii?Q?dhAxliP3nUr985oUYSCaFvWapeyiSmr+6O7mmorM7dbW1uyS6A9sVi3KGzBM?=
 =?us-ascii?Q?oVvAuM03JK6Wtc5gbOSdrBVRNAixTHFhyPaKzqP+kAF09LseW8NWCwHuR5eX?=
 =?us-ascii?Q?qurga2qDHY7qvnsSKhSdkhZd1WkLmUvwu0wdtM1dM6UO05EkTv4JS4No7je1?=
 =?us-ascii?Q?iby5oVKfn6h8sTI6DNJbdg1Dc4KjxJCyAP3sQt4RrZtIFpqgVm8Xtk7i1jPU?=
 =?us-ascii?Q?SpGP31+nIJlWa/aaledpSYj8+u7HVXU/TQim8jyk6oQOD+C89mg6HbO+/GY9?=
 =?us-ascii?Q?f44+4plP9ZbK9PF5MQRh8HRpsJ2NvKSKhUpNmwyHtfYX0WOHPR5U8aO5rh0S?=
 =?us-ascii?Q?FUkE1bHZV3ZPBrGnpjKBd4eqjmQ8H5rflPxd6w5DdGvWkScQg8lbRfCi8l2s?=
 =?us-ascii?Q?EVnGZ8xSrc1Yc3oRohWcIee/jAD9PtEqzEWniJYjBVmoMDc7ZnnUvbW9HWVJ?=
 =?us-ascii?Q?99qed6Qu2nVt2d0DJsAlcXDLHuEbbsHRDvfldKzfTGwEuPguH9X6oa0zypEz?=
 =?us-ascii?Q?F5YzxHE2fZlz23G0TNhwVOUNY7tvuJlOU+i1zq5PjJdt1LazZzZ8tUR4/Ppp?=
 =?us-ascii?Q?X7oXvuSyKriuxzbMhB/HwW3RmyECn0vBD7334WlxyuIIDkO2Cu+QFJxxU2PB?=
 =?us-ascii?Q?MOXV7wblblmzXhsT6mqh5A0lALT1sA1nuoT7alnmbvv6X4OUJcwh0Ny6DnvF?=
 =?us-ascii?Q?QLfWwSJT+Sn6EYXl7Qu2wQb6PX9+74pbRN8GB7mpcUkocwlKQ7f0lfIF43So?=
 =?us-ascii?Q?np1q604KMKe2VTnGUUPqAtNNy9zgo1u4EdpJxomIALAVtxrFzjlHKOK6g88L?=
 =?us-ascii?Q?Qw8RCei0USMDYlGP4iquDyI+ShiMIfotUgMZdAuskN74MsTX1SqTUgWOKjMs?=
 =?us-ascii?Q?w+ud0mnqfzovFo2uYRXhxDMQvJj7Ul8O76EqKZN1o9T9kVUZdP97uS0V00sX?=
 =?us-ascii?Q?eh1z8hW2I+WXTbOGXiwh4CyINj+61tXAX6CkoNmRSDCvDNblbLBpGTfjBvcQ?=
 =?us-ascii?Q?4/3rm+E2KzzHKXV1AjnrwNgdXhXvlmp8E7fVZeF554PO7wAdHADCtkUOoZZD?=
 =?us-ascii?Q?ifWbBZffnPkq1DLwlBhN7NZdnPjOhd44qIqhcFlMuf7/lg1LmTzagT8VYKVb?=
 =?us-ascii?Q?VySEALuxEZASPuW7e70KRCD/GJd1fvxn/LoNQuZsSPq6pvv0KWZxUy7kHB8Q?=
 =?us-ascii?Q?38rbzo5taDCUbujcpkqaB8CC7Z0u8JUMt1ge5yct0oUcCg7RVzNt10c2Y2Gu?=
 =?us-ascii?Q?27CwHKGAqM7TT79IPauBBtkAyqlytIBLq78pucIOsgN82eGwurCV4I1OVQ2q?=
 =?us-ascii?Q?ej9OwX1exC13rEOCU1hfdGZZDnpyOFClZwCVtkkz3kpfskaRbatr56oKf5in?=
 =?us-ascii?Q?yBZ766KUANevwIEl4q+VMglH48vFPKIGZHAbxSEbMASuJPzY/sdidg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(19092799006)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WprIWGnMEHezQBNtfGp2jfKvPdNDOW0nkWmzUulhdB27d6awRG4cUnX3AALr?=
 =?us-ascii?Q?k1WKhNJGcrzwPzTs9jhM8tM2lD7jlnjdmzjwDI/BpWeCn/TYvIDe2UGM6ze/?=
 =?us-ascii?Q?YxVUGRP4stlVdWrl3Wd8npFgmfzEhhzuZ5LeJ+wMpH7ETToSFM9VVSdRPGFa?=
 =?us-ascii?Q?3+sr4SRDBp8g6lK1YD+JdjH6mwtCQMWyB3R54T1zKhplsuYNu5i81XsVmQG6?=
 =?us-ascii?Q?hgvFzCkRidP9yRan2aaTO83l4xI7T2mFvMxk5p1FK8TjEN4NGhTuJFyS9/mY?=
 =?us-ascii?Q?X70XgQn3byGl6TLdMELb9bjHoZloa59C1v/PG9P8kLpSPxgr3vLyHBjd7STA?=
 =?us-ascii?Q?ASscQcN/tEQkIeyjZQVNWYj7j0VQrvLwlg3TkfBaN8tVtoTkj/ojeB+XEQvM?=
 =?us-ascii?Q?YQjQoRIq9vuSxBxGT7F93nc9uLSpCHqWP7sWLXKwN/kO0ut/xr23Sj7bsn8d?=
 =?us-ascii?Q?07+MVYosaRHzN6loWPkFVZqLdvwhtAE447MNgoYkKj/KYmvoJj9uICyNy7x/?=
 =?us-ascii?Q?bkakWpOftd32grzCF7elyIa1XpfV8f22adiQMZsI/OIs0csvXJkWU1OAsGcS?=
 =?us-ascii?Q?tNX4l1Nx4EZZFlLYDQlpXPWcCvfySNW/d6312u9hHwE+HXy/alOzCcxffYl5?=
 =?us-ascii?Q?xYkA3kkdjvl0FGFU70NyzQqtRpTFMx7ZDmlagNjTmpO2f1tEHViiFTXuG90a?=
 =?us-ascii?Q?rbEQAfpXIG2MTN2Kl3TtUauS3mXOaTiAxkt6IVPLlj0PrXKyVG1bPeWzgA3N?=
 =?us-ascii?Q?pC6L2btqKQ9ivnZQHf/40jVINZmxBqpOwD7r/PFF4ctPgR9TfwxqwPMZYJl8?=
 =?us-ascii?Q?erFmOyqhTnwfysazut1i6WczvEPD91CCgvNAxJE2ztngi5qAz5vSZt5Sq8N1?=
 =?us-ascii?Q?0Xfs7yLrk6CMInDZkrf6+JkEEvfvTvg+KsBdHvpmEoSK1+bq1ENBoJP+Cb6j?=
 =?us-ascii?Q?34pq6UcMvYEiSaGQ5xkHCNyfj9btgepTaRUWXlwWwA3ThCfGmzM1X2S/qXPk?=
 =?us-ascii?Q?sVVhg+QFd3DijCBCiZiDkXAvtDclpxBurZOpm9DpvloheXjTIbeOjxBaLf9L?=
 =?us-ascii?Q?I+TzqK1FAFFOqoumMO9CHsQZoAgyDdkI7rb4+VeSvukNZmJ0Wjr+UBgpn5FA?=
 =?us-ascii?Q?Ic2tpF5NAngstUBsNyDpSMPYH/6U1kzG39Xaf23YV3DsJ7rvKgWDHr3k1kMA?=
 =?us-ascii?Q?GUyOSMSbQE1xnHGqfsWClQcllu9MW3yfZvy5Uqcd7EM+yWBPmVnQ9LCG2qOq?=
 =?us-ascii?Q?rtcDBCJ8QcZ+wqI4AdlMTAaJBj8Q7cs2K0XDHvEUGgnNEZlKV9XlH2xpV4E+?=
 =?us-ascii?Q?BSxE3ynz2o1S11WoEdXBJYQORJT+SjFA0sJpwcYyPR7LyF3DrpNmmDrniACa?=
 =?us-ascii?Q?b+kJS8+CNp76f7/KepiS4MNlyhi2YJSTIDNjDk1TNNeRlIMX+cof7k+ndZce?=
 =?us-ascii?Q?qYBECjaXfbMkYDxKb2CA959TF2AanF0uTNspVzX/tYIdlR8TMh+iAK2Saakw?=
 =?us-ascii?Q?56/ukNJJ8iL2tiqCfskECeImioAHbKt8zjjqjEWP+kMrg4SLYI9Z730TI0Qv?=
 =?us-ascii?Q?xu+K41rlqRnKVBDEYcIAj5Vrc/NGBAp0UP/ZP1AACFtj7rnrx3UFaTt72R26?=
 =?us-ascii?Q?pQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc563813-4168-44eb-4a1f-08ddebc9e9db
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 15:44:20.2107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KPkQX3AI/oQywx2tRi/Ej67w+5CSMZTGm0iwiR9aQnfzwlLnBVVWh+scWxA3vbR5jEjMn6p1yMo0U4Mb+YPjMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7635

Going by the generic "fsl,lynx-28g" compatible string and expecting all
SerDes instantiations on all SoCs to use it was a mistake.

They all share the same register map, sure, but the number of protocol
converters and lanes which are instantiated differs in a way that isn't
detectable by software. So distinguish them by compatible strings.
At the same time, keep "fsl,lynx-28g" as backup.

Cc: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 .../devicetree/bindings/phy/fsl,lynx-28g.yaml     | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/fsl,lynx-28g.yaml b/Documentation/devicetree/bindings/phy/fsl,lynx-28g.yaml
index ff9f9ca0f19c..55d773c8d0e4 100644
--- a/Documentation/devicetree/bindings/phy/fsl,lynx-28g.yaml
+++ b/Documentation/devicetree/bindings/phy/fsl,lynx-28g.yaml
@@ -11,8 +11,17 @@ maintainers:
 
 properties:
   compatible:
-    enum:
-      - fsl,lynx-28g
+    oneOf:
+      - items:
+          - const: fsl,lynx-28g
+      - items:
+          - enum:
+              - fsl,lx2160a-serdes1
+              - fsl,lx2160a-serdes2
+              - fsl,lx2160a-serdes3
+              - fsl,lx2162a-serdes1
+              - fsl,lx2162a-serdes2
+          - const: fsl,lynx-28g
 
   reg:
     maxItems: 1
@@ -33,7 +42,7 @@ examples:
       #address-cells = <2>;
       #size-cells = <2>;
       serdes_1: phy@1ea0000 {
-        compatible = "fsl,lynx-28g";
+        compatible = "fsl,lx2160a-serdes1", "fsl,lynx-28g";
         reg = <0x0 0x1ea0000 0x0 0x1e30>;
         #phy-cells = <1>;
       };
-- 
2.34.1


