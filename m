Return-Path: <linux-kernel+bounces-788862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58945B38B3C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 23:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 135225E5E16
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 21:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487B230C60D;
	Wed, 27 Aug 2025 21:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PFrxDqXQ"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011021.outbound.protection.outlook.com [40.107.130.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208F730C37E;
	Wed, 27 Aug 2025 21:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756328976; cv=fail; b=inFZ9oFGcw3khsYtH6g3ttuF5WwsiYGs0DMawk+VA01KfgUdr7qktjVa0BScjW1ah0tzvx3zJxPSQTy0Zl7o27eanwpySw8jL0YcqUHSThgAAvZ8sYMRNkjzsG6e2NIKfKr5wjZ5YpamL/TzD5SFSsF9CEqCYwt4LPW193N8bXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756328976; c=relaxed/simple;
	bh=KyAO7xqC4zF7D1lx0Ego/T2Dq6mQVsqQurB4bwgw7AI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=JEcaNoD6Pfww7Ip+J2voN9FWSl//TrJ/arhdW/ksNA4HXrphFOR/bMW3npQLqsyQAz8AsvXurpYoopbxjJTjAIyxksrwd++l7xKQ+ZspjH7n7KedQMxpBIbRbJhtDWQKdHvztgw6GaGaxRJPl6oGfJgnNMHomAbv1Th1x/sTQ2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PFrxDqXQ; arc=fail smtp.client-ip=40.107.130.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OvNey+u4KLZLpmJ9aK/5Ad+wOjPuu+2qAHTtyNr1Gvt6egjwgtkSDc1v3ZUomnMiGDvTswWp5O6jdcPun6YuItfIfWU4rRC+iDgHitKw3lk0HmQ/gIAd22hcb2/zWPvGI/dQDgj67XQrwo0ynGn+wZMj1P9F53DvS9V0w8pnWIhF2LZzIp2SEZ1j5w1vqqnLfz1f63pwOU5Gxgo6Fwxtn+/anvfmHnSCDCI+PNI08AzCPop3baRXmvgh1xOeIUjmkkcwDFvEWUg0ZnBULGBJ7ArG1t2j0h2F++jT5NyL6tIhIuO4Tmw4UwnzKD3kXgcPKTytaD3gAGmiPpwjiarVzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lYQfL1axI6d/vtavviIHn4pdmJHXzMFrK43/UNEeBx8=;
 b=nrI6Fyzz/h45FqhSjYXxQJiJYyHaaD8Wex2z1EnhvPhGmUwA6lOantGCY1GI2vDHqowelRmDb8jRIVa9rtpioy9FOZkfaPIG7CIU4KqzBdjRPv/EnG1Tjid317DqNr/Vbn3HBrJaMMBcWOYvBkEr4cP5Udp1keHc07xU6EYLamzwkqIVvw7WI14ULGCZuJnrHpi/bmYuQVPjTBd4zJVgU5leXGLLdPwFZwZMbE9w+kNUCLPl/nMcZbu6X73IuhiMXtgttWQOmoOxGnnv3NtrJxZwvf2xjm5B5bnFuuuBvDLP6lvm9laV90XtgzefCl2aP4vDc2gJU+4SviFvz6XKDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lYQfL1axI6d/vtavviIHn4pdmJHXzMFrK43/UNEeBx8=;
 b=PFrxDqXQOZ7XBaGeRtWHYZQ8vJZXhTNiLbFAZPYoCBgOI+FAJG7OuGOh4GeKdXBcSux3FhSkcPZPrn8YRCLiU9u4xd2ZBD11FQnHu+Aewu6427mUGQVjy0TW6+ftyLH/qYOwh7DKijQv0746/PAMG/3S5uHK150+1QCWk6dkbr1J7BVAz1A+EhJ8aPkR369BiuS4bmC0qcgL1PKpPz4ustQiLoDVeyb6FLzYTMcv5eLOyJEDPK0UuIqNdiE1aefNxkBVPI7Bwan42B+mY8cKo/M71tocm86XKyawBDV30ypC87LXKi1kfX/n9xibitBjdS8pWCskQ/q3mDfYFzGDyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by VE1PR04MB7232.eurprd04.prod.outlook.com (2603:10a6:800:1af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.15; Wed, 27 Aug
 2025 21:09:29 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%5]) with mapi id 15.20.9073.009; Wed, 27 Aug 2025
 21:09:28 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Danila Tikhonov <danila@jiaxyga.com>,
	Igor Belwon <igor.belwon@mentallysanemainliners.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] dt-bindings: arm: cpus: Allow fsl,soc-operating-points for i.MX6
Date: Wed, 27 Aug 2025 17:09:11 -0400
Message-Id: <20250827210912.92029-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:a03:254::28) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|VE1PR04MB7232:EE_
X-MS-Office365-Filtering-Correlation-Id: 5037c706-3254-48a2-3dbb-08dde5ae0296
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|376014|1800799024|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UDeuKD5H35F+2rOzNzv+tcXGoJStXzqjQGIB41VealZBOYM0NKwzfSPCWrx+?=
 =?us-ascii?Q?LAysUDBVoDnMTJYREZQzaXNavn5OA/3ZIn6LkRDLlXnkToOtCbCHQ8J/GrS8?=
 =?us-ascii?Q?Wr8iryjkPKHAXHnYpqzRh8zzrvWX29e+CYe2CqIHarmv3ksPjXekxS8vNdp2?=
 =?us-ascii?Q?AOhDk+noN8Ts2SE8/8VxNyJf4QTefVC9+NHqXqgzSY7kti/UFGdaeQuXUXVG?=
 =?us-ascii?Q?QlXosNvsLMU65IwMvq+uH0P4oX9YZL0cKGrp3mmQ5o69964X1EkT1Uw4T7oY?=
 =?us-ascii?Q?K5UGaE3VcWJQkDsuwwY433zYKLXjfa70UhYyksthqThFkQwxOVgotVX9Lp8Z?=
 =?us-ascii?Q?jIcTTPHqdDUOzOx4Sq95xylAjucbERsvzg4KZLNB2o3lm7ALhti7BVGNI+zS?=
 =?us-ascii?Q?toeBCGzD7s4r6YnNtmOUNBMCC3E+eeMPM8emHJNsUwnhmt/JZbdwz+uQcdls?=
 =?us-ascii?Q?qsd70YOn1bba46qP+mZ1LSTNn6GpqZW9F38EEzs9EoOESLXMZtUh9waleDve?=
 =?us-ascii?Q?eDqFGED7pjwyH8dLF5fEvsbbyx4JFj99XbyL7zG9G5BFCH3vi1bEeLhaQkI3?=
 =?us-ascii?Q?QKuOCNsWwJ4a+ualhMVIchxumXgXxixJ7rsQvCRy9Amh92CTZZkBlJFZSPl7?=
 =?us-ascii?Q?RrJO5Srdt5evAnCDBj331oyJgrXRfYdlLYzs3OKgozEAXCaR6SlBofRMOe7D?=
 =?us-ascii?Q?GNSvwuK3OwWfT2i46aEnE9tt6ODVV77tJohyNNyFca9b5CWYW3cbgUGXvCeS?=
 =?us-ascii?Q?HnMDhpdNaLYgpu/Es/whOmF5pGPCAIQXN7+6i6TEWPgmyc+j6szv5WpeSa9Y?=
 =?us-ascii?Q?Deluw6oWPw7E1m5r0d4S1G16QNtj2y+dLiM4JVxLOxrCDiOu12NczpC5M/Dv?=
 =?us-ascii?Q?CwbBWv89NdpF/quU66NLjlsUviZwKGJ/Cki0AgrL6TjEkZ+VQX/Bif/6Ncdq?=
 =?us-ascii?Q?Rk05zEzXlI051cWwwO8frfWsqjk1EhBxqlxtjZpO5f5y6bvfVmiv5DJ5sVmE?=
 =?us-ascii?Q?PRr6GetANgCQtdGdXiLXTdjWlfqPWF3Eavfw0tAnU2ix/YnzDv+gsdqVXRMg?=
 =?us-ascii?Q?ogGPfkwe1PgXYhJQx1h+4qFE8STVjt+gyShtkVPhvhrIVjewovGBca4MftEw?=
 =?us-ascii?Q?I2q78tyLyfOEb2kXDZkwIC/oZfHZwsFkA4Ze+25wsNhPLzgg3q+tIBceA7NB?=
 =?us-ascii?Q?UPpUtXg4ht21XLvJna7m9WhuZJw8YPSYxnWs3CWqJTWT6RuyF049J3QaC8KG?=
 =?us-ascii?Q?gbA4/fcwjyIEsqkMQSm9P1SXwvg3yEo6FnEEXLvbko+Lgl6669QTg6qufWjY?=
 =?us-ascii?Q?L2r3L81e4wlyKOw15byNJ4a2f1CA5BQhRhzq4GjtxoW099lZzerEfWymsXWg?=
 =?us-ascii?Q?3oveuQRHHCMPoGyXuCWFxSXyensr6OYalAlsykLGOf5zHgzH6lrSeD6Ek1q2?=
 =?us-ascii?Q?OKzjmz4x/gpOkkcPcDP3JFFZ4B5vtWIX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NPCBSfpm627Q70SKql5zgpShr/9ynG+qEWIgTmBqWD4q3Gll1nljSwxfrA/Z?=
 =?us-ascii?Q?Qdzw4jZ93cAO8lIREKgoWRZsyvPcHHHemxNfz0QnOcU6PnFLl1GiBNpH3jk+?=
 =?us-ascii?Q?QNOlJIpTFKFfexmkeSJNa2U+H1XWdccug/TswK5Mi69TeOUSNBmHeba+Zr7w?=
 =?us-ascii?Q?R/HQuMp3tFGIFdiwivbuQiqvM7Bkhc2Z2cefwtxkxiU/RteLBjS31X88Q8yt?=
 =?us-ascii?Q?uAwFkk5Djy/IJRPnXBoGJNZ3+MkpwAz5mURgbIkkGdYSo55tI7A8HqlMcwT8?=
 =?us-ascii?Q?t3jBkp9+YkEgQRBp2TAnbA6pAadxnMtSz57bbm1/2rz42lDhzhN7O+QN+Oxg?=
 =?us-ascii?Q?Dippm1JHb/LI3fODHYg0XrU4Hqsz2XdzcP1fbM7VEQHVDydDDhfhXRAY8Cig?=
 =?us-ascii?Q?qOpIA475pUrwNE2MsIjIqpbkHNERa+bnt0QzLdScnLKlNIxaqaZOruaJnHkF?=
 =?us-ascii?Q?W7bQB5jpOKqYQLUz8HdHvh/DBL1u4rNpdJbj4/Rcp0o3AQqbcvPqDn3hRvIQ?=
 =?us-ascii?Q?GXFNg5C84xcCL96gmECV3hSLpXfcAiPxq9Ab/XYI7FHEXrGtdwmOrAR7Dx03?=
 =?us-ascii?Q?6LUKqLCewqaLchUR2B3mOVxEG73txNve0hYzDhhqGcIDsidP6NQu+M+uGtx4?=
 =?us-ascii?Q?iPXepASPRpe7g1YrSj7/VPEaR1TkahPcmadoBTdF7BTYMP/hrjY8yKLWiNY4?=
 =?us-ascii?Q?Upu/JAZ6QRjFATgCFqUKL0WAl/ad+sa0NLUc9Yxt07O6Bh8e9e+lY2U1nypf?=
 =?us-ascii?Q?N/DyHRqDb95O1GhSQsAAjaRxCLYvWxTE5VOSkI4Co/pflLyY10pWSlk0Vhmi?=
 =?us-ascii?Q?XmXN7rHxuHkQLXgDs4cfkRUpeE02TiY/y0Y3mY3v/oB/FCuTTGCmHC14oua3?=
 =?us-ascii?Q?rrkOJsurpBsgPqDqyWhPmE9adFL2GSGRcPKqpUMjqF8SbhioSIraNwO31rOD?=
 =?us-ascii?Q?wXnX157/nt+wyTvA+D8hTQyKkp6TTLMciToPrJke2hUFQAHz4/wCEzpQ5OJ+?=
 =?us-ascii?Q?L0LfNUUxdm3/yjqyky0dpFNpJ+GWwkFyiHJh2TjelzRRc1w/wn3jvD64HOg3?=
 =?us-ascii?Q?5fw9x8ORCpUqp8q20UTtkVTcq2bvRqQ1I2EiPtLJPBWs+prVHkz5wtx6j9fu?=
 =?us-ascii?Q?KBybqo11Bxgkv+eZQhacOTBINDg1d9z1OMFKeWS+RbgD98k+pwshbO+NDOxh?=
 =?us-ascii?Q?5onaidqj4AfM9o4b0gdFqk/hsO2ddbqkIV96nKpAWirEICZfzDFt/JCNdbrn?=
 =?us-ascii?Q?j24kzrKWDlfYMTzt6xb3ZfRzKtC5RFoswoVJRNg0/mhmQA40sULzvbn7WZxN?=
 =?us-ascii?Q?QQa8LsMZRBZzzNcK21qF9E69iXNEnsxz048k5GY8lSvBvuQ7rRDs/hrub6wh?=
 =?us-ascii?Q?WeJv5um7NUXz5t4Ugn/Xg0rTWA/u0r7MdWfBDNcHhgY71jOseiIpDfVAPTV9?=
 =?us-ascii?Q?mICo4+JcRnatLkKwqYcfISkTVbDPMNiwqlT8xtdfJZj0679VeFe3W5k8iu5R?=
 =?us-ascii?Q?6A2T9f6alpYQTAwZHeIcBkggONZIh5avBRO1NaTkMd1qZrQeb82t35CBJNJS?=
 =?us-ascii?Q?DF9ufpxIYjapmNCU3lb2E8HSvG0O0U2rRT3z0vj9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5037c706-3254-48a2-3dbb-08dde5ae0296
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 21:09:28.9032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8JsHrue2Jr6cVs8W3l1lImUdRwCpODWo5xVGEh/Kv41V+zz5WjNkqoyeXnlSxWCs+GVVduwO4dQQxuO6wd/ZPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7232

The old i.MX6 (over 10 years) chip use fsl,soc-operating-points to get
SoC's voltage and frequency information when cpu change frequency.

Set fsl,soc-operating-points deprecated.

Allow soc-supply property and set it deprecated.

Fix bunch of CHECK_DTBS warnings:
  arch/arm/boot/dts/nxp/imx/imx6ul-prti6g.dtb: cpu@0 (arm,cortex-a7): Unevaluated properties are not allowed ('fsl,soc-operating-points', 'soc-supply' were unexpected)
	from schema $id: http://devicetree.org/schemas/arm/cpus.yaml#

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/arm/cpus.yaml | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
index 7d61de0c15ac3..867e2b4673d00 100644
--- a/Documentation/devicetree/bindings/arm/cpus.yaml
+++ b/Documentation/devicetree/bindings/arm/cpus.yaml
@@ -361,6 +361,19 @@ properties:
       A72 CPUs support Error Detection And Correction (EDAC) on their L1 and
       L2 caches. This flag marks this function as usable.

+  fsl,soc-operating-points:
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
+    description: FSL i.MX6 Soc operation-points when change cpu frequency
+    deprecated: true
+    items:
+      items:
+        - description: Frequency in kHz
+        - description: Voltage for OPP in uV
+
+  soc-supply:
+    description: Only for i.MX6/7 Soc.
+    deprecated: true
+
   qcom,saw:
     $ref: /schemas/types.yaml#/definitions/phandle
     description:
--
2.34.1


