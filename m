Return-Path: <linux-kernel+bounces-774260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08068B2B085
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 20:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E76A356793C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 18:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA3923D298;
	Mon, 18 Aug 2025 18:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nKORofwm"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013013.outbound.protection.outlook.com [40.107.162.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC03194A60;
	Mon, 18 Aug 2025 18:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755542087; cv=fail; b=k2X9ZWjM+cI+1q2ZzvHQZaEHTM81xxb+O02dsTTAc9jrA4I/DWVRYNcg+2XUtvrmDEkaeunoi+fu/fZwJmvA5busqk7ppuC1aSp1UEfxgnfdGUs5QrT/5FhSp+oWO20bmPleTrqJJKH45ovBhiN+UXRXDu7WhkrS7tojkLkFfwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755542087; c=relaxed/simple;
	bh=lEBol8710ZpJ0f3abJodCXrszpzTDj2GhCmSvoWwtQQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=N3VrKcRxbcXAzjrATR6Z9d2tTmwdLia2Hmabrlw0Yn7YrpxYUy+Je7/hEYKCtwwy/uK/krAI8a7tqAwJwFeybn1GIVJ67mEUDoBosignoqTlj1l1edQxzsdqXe3xEfRvDsVvlNNhd5icKdTqa94pjBoKi4cWGFsAxnQ+NKYANH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nKORofwm; arc=fail smtp.client-ip=40.107.162.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JXydZ70rBK1enD4JZ1iK5UFI3FJGm3wT54AxDnAQKudk1X5bEf9q7oqWkzB0RerYTmU+5hiifNiRE8Ov5hj1ABT8pxORYJvVquY2+FC6JH5s/zDYOb2UayVPGiDcwZie4BVmcjH0KWBZ40l/9RlwyYEuDvt3CuBc3HIRZFltbP2IT0/n7wJXPf/XA3Fid3VQbvbukeSfKRaIkOAJedzVEh1Kf5q/nMMWfjBjCYVdVdtI9L4rF/N7ykBgZF7/ZcN0hEMTb+wg043vF4+PfJ4c39DZp6V6C/gOheNhiQ4wSauJ4MRkQjl4+ETSZWsK4zhvP6EJss3nsodqCYNUGPn2VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u4xYxJkiCehEqp1gBa0wDge8tbaG6db973aIhfqFxgg=;
 b=ZvxtzpO6H0ZPGyDGhvbhjnB1N+5p+hMADUe/2O/1vsm7OjRg6I++ErK6+1/h65vYL19BRkSvpFfnCkDUyNrMw6nV3BcOlypcGdTSNwn6g5tGPF3cY44CLuU/M/oMCFWTYZ6vqUtDfHLnXFlvz/KgpFtyVw4LbUIh6enHIr+bfFb5ZG2vQsrFgKT2LdiTk1q3PeuPSuGl60Z4P/yVGBPn9biHmOCfx4vkp9EYfBduZJUH88S8PIbC5m7iPCtF2ov1Fenhmu35VKFfPt2sT390/JRp/Z+BrW4iWihJHuSAn/TWlkumpwkg9tUY5V8Y8XD5D1M6CCBrCZ0sCBElXtxHyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u4xYxJkiCehEqp1gBa0wDge8tbaG6db973aIhfqFxgg=;
 b=nKORofwm9y/6da3LLNs+Ip5UTAuB7tBYtG6djFXDKDUjM8A4njtcG0YaD+ooQ/Vdw1dAWZ+/GjKZ1ibGXq535+gG7itLJxiSiNrHxyka8/xlRjg/ScLXCk6Y1QLD1M8PZS0lN2EpU5BEbIXLXabW8RHOlIUql2xmAyWiGkrDEEi4YMjISSLooS1MnmN6tKOZI+KuEV7sf4WRcG/WuyjSus+nAAV7E3ApThaLuqBH4QvWN83pGQxw+ysmDuEitNZGxQJ7CDfiHHqzXBR4Z1Gz4Cx6sydV8nfjN9A5S5YSuG0YYTTIY2ma+uYCErbWRLMvNXwlNGMp3Hafe2MvOqj+1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB9246.eurprd04.prod.outlook.com (2603:10a6:102:2a1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Mon, 18 Aug
 2025 18:34:43 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9052.011; Mon, 18 Aug 2025
 18:34:42 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linuxppc-dev@lists.ozlabs.org (open list:FREESCALE SOC DRIVERS),
	linux-arm-kernel@lists.infradead.org (moderated list:FREESCALE SOC DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [RESEND v2 1/1] dt-bindings: soc: add vf610 reboot syscon controller
Date: Mon, 18 Aug 2025 14:34:26 -0400
Message-Id: <20250818183427.3601986-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0023.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::36) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB9246:EE_
X-MS-Office365-Filtering-Correlation-Id: 04ac6495-74cc-483d-95df-08ddde85e5b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uwQ8IzHzGPSuB48knX1DKiYXvd0UJUKGsmbq0qeE4kZ7ZI9ZljO2jUwzq9iz?=
 =?us-ascii?Q?n3JhCMBfvy0+PvPstCh5dMvM860j2dY3/DujYBfhC18oeiojBISCO5dNus3y?=
 =?us-ascii?Q?8YX0OmWvvRLVt9AzJcltxwM8AIEIU144ARSl/minNa+dfFOfMr5w9pT0gmbi?=
 =?us-ascii?Q?AmwlU5IXZBNL4uqGrEtsdUHjMlNlo3nXQWSBvXmpZXMUiGDhGuZNc5SP0kwz?=
 =?us-ascii?Q?Hucol+MmHOgxylUMtXXi3Uxagq1e1rJemOxkfu0qgW/d0Ujm9RNkJJ2nej8M?=
 =?us-ascii?Q?yxQPQWhzHx4WNQZZ8srYGU3E9eYqZOPEMBfEYg6QgH7WxO/8sOhi6NzGHvpN?=
 =?us-ascii?Q?KgEbVab4GaFLn54CbO8zEsvh2uNju2e9P0fFPzkGAOiBsm86Kq8mbK0uvnxs?=
 =?us-ascii?Q?3Or/KtzlCLOCWsvxRwvbj3R8SXdL3+OS9KPQYHMv3IH5tMH7pu2B72VHxhjc?=
 =?us-ascii?Q?voW5L69Z1mJjczUwOi5cmt+x2YEwx4DRLvPsC92/WTYNydP5TVuwb6OIfrTb?=
 =?us-ascii?Q?jjgekYCNn4WYEHd42qhlJXI5PMKP+chscUfnQ0UXDkr2S32lfmt12u6n2yEj?=
 =?us-ascii?Q?zWSuKnBqVwDw9TAaeirscVbAGypx8Ls9dQm//dMq2qb9pJycaC7iheYZlE5J?=
 =?us-ascii?Q?p7IVkXE2wGryRJdJu2N1h8gLQdrbJLkUAHtRs1C5kkQJ0hwFCOraVYc+9OP5?=
 =?us-ascii?Q?69ojbiGS8qWxtO5wMfHi1zple9Ush+OuMLqq1bFSedmIZZMTRhTFdvzlCFYr?=
 =?us-ascii?Q?OyNJmYB3Wv7wzu/VykjXM2SLlaSIYyDAc33Ua6i5T+/z3c/40nnM7uvUDoNd?=
 =?us-ascii?Q?AtnYz9zsdIYbio4xhCodXfyRsYebYKzV1fMtd7tin9Cp1Zxv7nx5eTRP+sDz?=
 =?us-ascii?Q?DfeNQS8miuVU+pQ+KcPQWiJS9ImO9WopGkBa7im2+AstOekS1fsJ46s6FpS6?=
 =?us-ascii?Q?KwglJb1PeimJD8uzxfpFIEPflkdJTZ/jUPugDZZySCckSyB3j/X8HmSb49UU?=
 =?us-ascii?Q?aKhMlVUYluauF7R6WNQwd3qeyxcWQePrpxSdfE+O9rWVrk4aHDds36epD0oH?=
 =?us-ascii?Q?0L6UIYCBxPaBESl0eQ04s3U1tQ+UUg/dST2h9ol9R32N92wN9Z58M21vcWWN?=
 =?us-ascii?Q?ooXwhh34Hgp2DixZSGH/aQtyTOCBN9LGmlPl7AmBoeOBYKOJGeCLAaQJ3cBc?=
 =?us-ascii?Q?wYoNbC8CP8pwDhnrdtlLL8XP37/lwxeBX661BB7mXoEgOrRPf5RDt1bPXbk5?=
 =?us-ascii?Q?Z2YZSi8C4H1VjuAlTg2nnIy35zOCnVIUK73iMhEb2pOg0ujzPZ0CtUy8Iu4m?=
 =?us-ascii?Q?4evaS1YhwfRAuzh5lmOJoKCg1G7h/SLCjURXVbQqqjVB0LYLol6dvLP6pu3S?=
 =?us-ascii?Q?xbUQeQ6blQ5dAlaO8fTIrdouLnTOUlpwY7xQmpKXRgXk45Ilv9U9yezQj2JS?=
 =?us-ascii?Q?igH6rDtjDpc9rA5s95+iYxlJsi9/5n3f?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(19092799006)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zDRb1KjiLwQH+MVo8yXyqxkRhgU59eI8nU3EgEsONNH/2g/DKRbZYAu0wgmV?=
 =?us-ascii?Q?SsU1fUbnLNO9TX33BSWdvRgErX3cD1RShSDO7aNOWDGhO+/YENID+f94w9Mc?=
 =?us-ascii?Q?HsW+FXT5rxfq3sk3W+IBiZWrqdTSkYmzJP8l+QGc6JEIqP7Di8zygBkILKCB?=
 =?us-ascii?Q?ginKbd5A7eB1UhH29gl+D5SgHmSeRAli0juszGe5R12rjCZ/Se32MR2hC6J+?=
 =?us-ascii?Q?HEuZ5MU/g2Fw+CpmUrWRQAeNwA8kWoWetJibO5egP6liy8K2JeVZUX+WdHXb?=
 =?us-ascii?Q?mW7KJprney4ve3G16BXKBjWLd3MzxJZObDgOYCZgKF4/IpK2JJyTSSWLFHAi?=
 =?us-ascii?Q?Jd9tDljoBt1dvY3kqT3gGoGo7htfQDWBQhrMlJTlCz9ZaW7AZhgGUwhud/XX?=
 =?us-ascii?Q?+2BB3VslRSG8LbVWMdjxwYGR3PPQTl75t+DkRYMYdwrYP58WXhwgbG4KqDuT?=
 =?us-ascii?Q?Ucnsu0YK/OzV+xqModVAz+zW3emK99fdMr4f1LzSTZSwm4elZOiD2hSI4e//?=
 =?us-ascii?Q?Yy4FvddVFmfmkE+dgbEeI4mUpqcZghcZ4qEoOmwLS2y7EgT9aqHFlDm786yQ?=
 =?us-ascii?Q?3w3C2tY+UlwJ1wubmvEIsNxy2RxxvOlfoXtjNqFxCYj/5YjkQvYaOGznXfqF?=
 =?us-ascii?Q?5bPBEO1mbBW65VPmZ+fe6iNswFdmgrt/zu1JIE/wg8CSWtsOBHaAiP+OBfzd?=
 =?us-ascii?Q?Jua8dx1HjNNRyv4bb+EU9Qr0KWFoung20K8jNl6ELfdRd9u9CGZCaTOLwEtg?=
 =?us-ascii?Q?9ZieuAJG8lVUrKiC7mNZv5mU7LvFfcFBjBB68276KWv0f/PIDSZ1slDKYk8N?=
 =?us-ascii?Q?UseaF1tiIpe7uEK+knsR38CF3oN7iSubsreBlm01B1xyBMLg7Jf87rWE8NEd?=
 =?us-ascii?Q?edyl8OoEGPqnbsS2ur+dZSsrg6gEo3Aj0Yf1F0zHSPvLIk6C8soD2sZ/nnAj?=
 =?us-ascii?Q?GbrzXq3zE6kL1H3C6EtRdU3KrztmgNjmNfo00E7AOZtdxdrZxl5VudD5cq4u?=
 =?us-ascii?Q?uLW9CknKzObT4KO0KHNy8wI1KT5u6wPuIGVzLkP2l3SxNZZwZDLPfoaq/i90?=
 =?us-ascii?Q?Ftvhkan5pDix+mcLU6hjkdZAS7tmIsdySslu1SEQbdjcqkI5KxfgZLjntJ4i?=
 =?us-ascii?Q?rb9lnlVgIYmdePHOd6HsyfZ41td3NtNp/Kwc7tNV2pLoiBbrsogzP5W1Uk8q?=
 =?us-ascii?Q?GlfSy1HZAOI1qhZu8RFblZyFLItl8gNhMLkKe2YUmCg0rCmOS8e/ncSBeSC+?=
 =?us-ascii?Q?rrlTfLFWFDjqKNIuvnaFEYjch3GDbEeeOw8G3pt/X8YCjVDUY8ZN/IQ97CSK?=
 =?us-ascii?Q?wxThF0uYVJQQUL+8kSkS+aR/iriNlpgx02g9Uil6Zw+OmvVlqVF0WliplAke?=
 =?us-ascii?Q?D234f/SkZ0stdGMMBPtnyHx8gjMP8uXMfZpf/RnQqqd0Jih/GSnq6912/8wt?=
 =?us-ascii?Q?ZKpitw/w6PVPiRPydjoe0Hrcob4bdndnk3Ne0jFHvc9PwTcUZqUv9/3bFXKN?=
 =?us-ascii?Q?SAnY4YDld52Xl8hfWEQ+tGweHv8sMPhvuH8YFM20Rq/6phHoF+uVUqIF/iOj?=
 =?us-ascii?Q?zM4uT0kqQO7SphhbvnuxtoVHUTrpL2lN9+Ym9xNL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04ac6495-74cc-483d-95df-08ddde85e5b0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 18:34:42.7972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r2b6UsS0SWVvCL4YZcYNB2CKmdRkpZPmLf+Im4mPOBPddMh+ArQPKKXl1q6HqDO/Jj0xCF4YVv0DFJ1XtOJ9MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9246

Add vf610 reboot controller, which used to reboot whole system. Fix below
CHECK_DTB warnings:

arch/arm/boot/dts/nxp/vf/vf610-bk4.dtb: /soc/bus@40000000/src@4006e000:
    failed to match any schema with compatible: ['fsl,vf610-src', 'syscon']

IC reference manual call it as system reset controller(SRC), but it is not
module as linux reset controller, which used to reset individual device.
SRC work as reboot controller, which reboot whole system. It provides a
syscon interface to syscon-reboot.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change in v2
- change description to avoid confuse about reset controller.
- it is legacy device, more than 10 year. So try keep existed dts as it.
---
 .../bindings/soc/fsl/fsl,vf610-src.yaml       | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/fsl/fsl,vf610-src.yaml

diff --git a/Documentation/devicetree/bindings/soc/fsl/fsl,vf610-src.yaml b/Documentation/devicetree/bindings/soc/fsl/fsl,vf610-src.yaml
new file mode 100644
index 0000000000000..cb8aa510a21f7
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/fsl/fsl,vf610-src.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas//soc/fsl/fsl,vf610-src.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale vf610 System Reset Controller (SRC)
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>
+
+description: |
+  IC reference manual call it as SRC, but it is not module as linux reset
+  controller, which used to reset individual device. SRC work as reboot
+  controller, which reboot whole system. It provide a syscon interface to
+  syscon-reboot.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - fsl,vf610-src
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    syscon@4006e000 {
+        compatible = "fsl,vf610-src", "syscon";
+        reg = <0x4006e000 0x1000>;
+        interrupts = <96 IRQ_TYPE_LEVEL_HIGH>;
+    };
+
-- 
2.34.1


