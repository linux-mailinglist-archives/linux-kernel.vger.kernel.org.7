Return-Path: <linux-kernel+bounces-788866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4DCFB38B52
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 23:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B905A1897A23
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 21:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B2530C634;
	Wed, 27 Aug 2025 21:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gQakyR29"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011002.outbound.protection.outlook.com [52.101.65.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4498D280A5F;
	Wed, 27 Aug 2025 21:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756329908; cv=fail; b=qwDmOIOAqmiTJSqcfGxHZgw+K7Xl31bTw3UHaCeFstnIjESCOfwv6rfeVgh9Rgwl+E0ppnjD+nkL10oNdDzAg2DLJgWAfBDrcdxMS7Eadq3wSfVgnmAerEAaV9YsO/2+2bUEP3f+eaYJZXjAvJRgNRtqBr0h1jXLkr8Byw9jZ6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756329908; c=relaxed/simple;
	bh=1crHFseDNn5M3xhqdAXmzfCqhOxhV5hiLNm+TJLQlNE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=mqi1F4pshpnsypsi5QOTwj4RP5hextPNQq0y7ZtsWbj1UcJ/ToA/m3sEx70/nxOg87O47/Rx8NdJ3y68F0z8F+XHrCf6DT+XVdjBZ5Raf8Hjh2Q7yGCJB/B4I4+YH4SQywaJZ4zMVm47XFXSdvxnghz/7AJc84ggxXxT90nMqIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gQakyR29; arc=fail smtp.client-ip=52.101.65.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kEh9JJKsbo19186sAKoo4/XT6uSZE4u39Bc9foyy50uMjMjt0uqpa8tfrDLFgfr40+GwoDdceDi/4fqFCC+gGN2UzjYPvbvBg2zDzuh/z2Z/RYntuoVeBY/ZF2x34wOADJdzI8QJmyTaQMizYHNNz11WaHSKJYAEH/BDv9oAxQi0lcTm8Jn9ZuDu44rhNKrTRKlqQmqmudo+A59ecZq/6dIKYxbvkgaiqUYu1PXj1ro5E6eHYf05k33oNg0ihKUzxrm7pkLIXh95Myx8MikvrcoyMOdOt4FpqX1gpr9GG3vEd9a6FiTncnIH31t9gHyYVae3SsEkwquBO1h6KmQIfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M8ehvwIvODCd9Q6ADCnPYxbUZm4GJ66FuV4mvvRZBLA=;
 b=qDhfb6niXkAx1Fc+JFiOsqa2QQtwS6Hl9br75B1BlWzhxftLAeWq5/BcDNggDfv8639APisx+EA7jRPCI2Dcss91pusftr08RYKOkMz5Rlt43zclIWdA+s9FRSOQhOgCNsH/avo9kjl6PuZQZunpoiNujxFTLIVkGvvxhU2ovkpVqA/z14yts1ndZVBAUIGLZhhOA+1z+aM1kGght5ADAH3uetKqzC2UbHg+1hul6oQ6gptiqFUhrMt2karX72Z5DNKlwk2jFkTWkKNRrrjFFJaIATXPFy3lVirzDToE7o9jrejSfiZn8dKHTgzyRx7ajULj1viJauBrf0HhOPcoeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M8ehvwIvODCd9Q6ADCnPYxbUZm4GJ66FuV4mvvRZBLA=;
 b=gQakyR29Q2r4297T0GxnEiqSjnhm0IvskddTZUVc2qDx/1ZPl9J45klB41Dt/oQqQ0eHpIXvsOmRgV8/KG4w9imVegT+FAIMa4+rRY7TEWF9/OkwxKg98c4ba2g8SoYq0dirN9TTLQZRCEzAMIOEyiZjKrCbKRiJI1V+jjgmX1LiEjaVB2VzjVnKqH6VEUMGRhGT7X7/8Mcf/I6nk729rdl3jobBrKJT6fKIN3bNeQWWbg49eA8EsvjU5CfAPklJlrEdtcJ4kr4Mik+b1sVic+b0fkk/AOzNB6oFYUiy80ovAdf4vP4O7j2DKgJnXzkqvySfiMtzGgFVWjSMznfCKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by PAXPR04MB9470.eurprd04.prod.outlook.com (2603:10a6:102:2b3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.11; Wed, 27 Aug
 2025 21:25:01 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%5]) with mapi id 15.20.9073.009; Wed, 27 Aug 2025
 21:25:01 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"A.s. Dong" <aisheng.dong@nxp.com>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	imx@lists.linux.dev (open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] dt-bindings: fsl: fsl,imx7ulp-smc1: Allow clocks and clock-names
Date: Wed, 27 Aug 2025 17:24:45 -0400
Message-Id: <20250827212446.94571-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0108.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::23) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|PAXPR04MB9470:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a1ee92e-3d58-4d1b-3a42-08dde5b02e75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|52116014|7416014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ycqyNa+4ZkD7+NX3SpXcrlEcS3wPPfqDmvXHXjqwiN2Y5r7foPvITEP8NvpB?=
 =?us-ascii?Q?8Oiq5BZu/FDce2wRA9UZGdtsQrGggqaAnfn5xzllxCCPPP5u22P8Lu7gQc3j?=
 =?us-ascii?Q?q+ZO2oZftaZAvTXN7AA2UOe3avp5VOmWr5pYEB1PnAaEZDyyrQPqRC+R/fhh?=
 =?us-ascii?Q?GbZ1TZzZKcL72GaAKRKJyIOYPzttoy5wY21WazNHkb6GUKV+1ne1lZvFPYn2?=
 =?us-ascii?Q?OsOmWLNjRwQ4yloF0zklza2sBLGoRwuMPIrx7WztdPFgmw8dlsuzwJK7b6eW?=
 =?us-ascii?Q?D046B6nLblsvtTzUJWkeCoh3hLFhFz2gU8s+VZp9AeDNQPHbsG4cyQAL5oh6?=
 =?us-ascii?Q?pMDuKlSb/LYvkFqO0NU8r6G8axW/JDz07ctevBIG1A1hWGf51C4jvMn6ccd4?=
 =?us-ascii?Q?Ie2XoIfTCPkOde0jOfYcjsYZw7uMFg9DWL0GksvNO33FuZccAFlGO7YnTtyG?=
 =?us-ascii?Q?SfXuc4eFbiz32W/nl9YReFkIKZKhgfXgqrKjjmOyIOVsQzmsimeyysajVIro?=
 =?us-ascii?Q?JJIdKPvGMr5wjn7fzB1+4d5BmldTK/XDzp5rV+JNGo7wOB6etqOT9HfKVNVB?=
 =?us-ascii?Q?sxEuGuZD311M3k5opJVr1zTWuju/c8Bllid86rrm8sto/KMj1nF8pcwEHBUe?=
 =?us-ascii?Q?cCaV4mCWRJub0NvFY4dC4etbRyYjeu9kiShn3Ohwxf0zzSEyzbJdyH6neAli?=
 =?us-ascii?Q?pj6tt6i6dReT59JwHRY9nvoFvQbyU74a4EVc45EN1HORRu0sSY2/6wTIaJAP?=
 =?us-ascii?Q?reTa9kUPJUxj3D+w0GfhM8Is82uRD8SJQvN+Z0dfFUBEjWlQcAzUN/n0tDMQ?=
 =?us-ascii?Q?3J+mgVa409/oRgKsKH8a19lYdBXDvjDErWfwSFdFV8BvhF6CxS5QpIZKOnIt?=
 =?us-ascii?Q?vKa0+brSJ9Ia8CUkYlTueBJplalrn5+haClo54OTVuiKOGN8tQH4d08D7cBX?=
 =?us-ascii?Q?ziWZxvYSOqtIW9/u92sZv1WaK+eoIRH+c8/FU+/kl+dFOc8FaVMjIVs3mnNS?=
 =?us-ascii?Q?Oz4cU03DVhCPMA/J/E4m83fiwkksdS7GiBPjMENelj3KveXurbfxUQ0RlEmB?=
 =?us-ascii?Q?r7RNdKtMW4wfE8FpoLTFwX2+Vhceh8LAODtfgDVv18Vy73zHYmW7SWWN9ubE?=
 =?us-ascii?Q?obnII+cPfE04HxU8YG9eBdo02tDOAj5nwLAgJ0DQX7qUFb8V+lWz0rfMY24L?=
 =?us-ascii?Q?by1OMEXjBCiwYkW34CryMbp7rjjb8edwtBajGIgsJnGwGiNmYeQFxFGK4oNj?=
 =?us-ascii?Q?9yFOkbMZfBPRkWb1qqFMnkGzqgAWebj888QulVYa76vyCAPOJ5VAryv9ohFU?=
 =?us-ascii?Q?RoFSsrW6sJOvfbzBZSSU177RTpnF7VL3ApRL0c+UYTne77gAXWWHKg2Qv3hX?=
 =?us-ascii?Q?40QNhKx0oMlvBOcSAgjtWlMUcH0Dw+h1sb6kFHDfHizmqfQz+5JeFfcmk8Zm?=
 =?us-ascii?Q?+PHcTDD1w36fk0tTb6QWpf9jZdByHZ4J?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(52116014)(7416014)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vDIkK+AOdmUthj9XCe3SzAsGgriLmFY2v0H8lEGzqr+bQ9CDGqjtkhMlotQ0?=
 =?us-ascii?Q?IdUZKqknxmtO+Vm5tk9JaFZ6nuPMO96Sq7T91UzWm8MCV5ahCeam3WZHETD8?=
 =?us-ascii?Q?a5+420mJZXdAO90PH/O7NH17UHFSx8u7qGTzovK0uefoe1pvnBUstgr/niUa?=
 =?us-ascii?Q?L0gQ8YVe3HEqsUrNA+7Gn2Ddhnk3n4+5PDHbsrZgmjqZ++ZGwv/42WSrHOYn?=
 =?us-ascii?Q?ay2ifSbEIeBOzeLxJD2eTQ4w4Yg31C0E7CwDE8jB/+WuRXbs9vRZPxMJrQB2?=
 =?us-ascii?Q?8XrkIlrsooLFl2xXaKzZqdqNrNE7i1fpMVedJ/rUHG+doSW7Y78HJ9sVqGPk?=
 =?us-ascii?Q?WAhx1o4txAdrdE2HqvfxXXnu/sZu8tGIl5Zbd15uEstxOgNuUK4A4m+pFqb1?=
 =?us-ascii?Q?wAsMTBLRk7XjWBDj+4cuQUBvICQmWL/uWVISfggOu/OlXArYcL9CGwds37zc?=
 =?us-ascii?Q?yFUYN2jv6/Zl0ZwF8Y1HmLig0JDYRAcC2eZ3NfVOJJxQN/j4xjIkq0NjcWfE?=
 =?us-ascii?Q?BMA5+/hdphYb4Q6GDCRmtjva9ng3nETXx9QZoCT6CUmSuWPhIllc3yQAvWVJ?=
 =?us-ascii?Q?8LYQ7ubPx6YghdzGP0NTlnFY0VE3LF0KpifH5iFq1+3yCi+Ku2PZFiU2lQkm?=
 =?us-ascii?Q?BKlGWipL+rUn2aAT3nOwyu0mJoDC2+zkztm5NLuqdJUnRAcppwH/bYSymIhX?=
 =?us-ascii?Q?tI2xNiOf9279PngKcctE6tWGuBp0PZhxp45lHHVv99LgrTAvB9bUIv7l19QX?=
 =?us-ascii?Q?zz/57ZpURbW/0nn6Kj+rs1BL6rkp7AMb0hLH5WxX8NL6qOBe0rJIgBjzSQUW?=
 =?us-ascii?Q?uinpIBiZ/UEQ+qk9oMsYiz1tMr8BcTm075tv63Fv4uCaT3W4ezsDmSxK0UzV?=
 =?us-ascii?Q?DhlAu7P+LXGhxdS+gZ1rl0EBOmBVp+8BH4kosT+ZiXpX90Ioo5yGt1f3QD+4?=
 =?us-ascii?Q?nCT3cEq9jHcg/j3BQapKj4naEVFfoHxhC+RSuJW7254BXTT0GlztdaRpPY+K?=
 =?us-ascii?Q?ngFsuHkqqcL3CFqa4JxKVSZXLsOVpsm2Orj/wDnj0VxvKvoIIEsPIhVxafaQ?=
 =?us-ascii?Q?Gh24zSdiA0tcW+xpTtFOb0Tc1xbTtJk4LXdt7lEqF1cWXq2HaA3du6N7ew69?=
 =?us-ascii?Q?vUdVo1IEyWwaDUeCN+kr/NrF154fWUylseIFJk9SE23xkSqNs/xyCJS+7KQc?=
 =?us-ascii?Q?ldUun1anoc2IigdxB5wULp1fWdlezvofqpSWGO8zhxmfuUIup56vCBAwOWqO?=
 =?us-ascii?Q?Ig7VNghWb5VU+UE0ssanP444Lk7Elg+XsPIedKZCGkkPPoyrjpp9GOVFbhUE?=
 =?us-ascii?Q?GEVKUtvEnNsd4U4rJ4N/36yZ+j4ZPB/CKixf5V2BJ77LziNgwPqbgGuVaJ+k?=
 =?us-ascii?Q?38MZyhPnbcBsZiN27IwLjEBlqqqElO0KQhW2Vkfts39RXVj4bx9W3DErI6vh?=
 =?us-ascii?Q?QZSy5wqIumLWDv67SK5rgsd7TkrIyWCpQvK7D+2Lp1+ComKb1qBDq4kRAQYW?=
 =?us-ascii?Q?vI4YnXRORBGpMkxKdOryuMVPJWkqp3U4QSKLbIZe5HHYaSpRGc46kmRIVhAZ?=
 =?us-ascii?Q?qkwuwk/RD0BBiwIn4fEZKRyemuPQQ0oCin1EPsm6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a1ee92e-3d58-4d1b-3a42-08dde5b02e75
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 21:25:01.6590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cJioOgRZ1ELH4zvtlHX0nRO8FsdA0B8dZ0ZobzGaiIRoiTjDZYBxmA3CTH5IFIXHJqqKAhf0P5G0uoRFp3WmYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9470

Allow clocks and clock-names to match existed dts file.

'hsrun_divcore' should be 'hsrun-divcore'. But use '_' to keep old dts back
compatible.

Fix below CHECK_DTBS warnings:
  arch/arm/boot/dts/nxp/imx/imx7ulp-com.dtb: clock-controller@40410000 (fsl,imx7ulp-smc1): '#clock-cells', 'clock-names', 'clocks' do not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/arm/freescale/fsl,imx7ulp-pm.yaml#

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../devicetree/bindings/arm/freescale/fsl,imx7ulp-pm.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,imx7ulp-pm.yaml b/Documentation/devicetree/bindings/arm/freescale/fsl,imx7ulp-pm.yaml
index 3b26040f8f182..9d377e193c123 100644
--- a/Documentation/devicetree/bindings/arm/freescale/fsl,imx7ulp-pm.yaml
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,imx7ulp-pm.yaml
@@ -28,6 +28,14 @@ properties:
   reg:
     maxItems: 1
 
+  clocks:
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: divcore
+      - const: hsrun_divcore
+
 required:
   - compatible
   - reg
-- 
2.34.1


