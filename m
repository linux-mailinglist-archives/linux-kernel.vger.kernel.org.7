Return-Path: <linux-kernel+bounces-824044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF95B87FD5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 08:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B91356063D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 06:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D3029BDAE;
	Fri, 19 Sep 2025 06:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CcDYz/RA"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011023.outbound.protection.outlook.com [40.107.130.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645DD2877C1;
	Fri, 19 Sep 2025 06:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758263142; cv=fail; b=qpuG/B4TklLBgQuVmxGQO9IpbJRBbcXih695OmPY96cZ4f6fCi631jwFGXsf0uO0RkXdXERO2uG/zwK0jZy+1MJmU8kWj3492IsZefSDXt1CDmWNPuWt+SaMGObciKIb4hkmpZDlSwy0XbDc4zKZ9yuJKFxlfJ/YglgFUFWdm1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758263142; c=relaxed/simple;
	bh=PxnljG9UsxLhtx9x1CUMDNGLMZJBGoUjZcEbNt3WfYU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=LH/QMGFHC/q6zQns0QByM9aB8L/wIwvGMtKfsdr3IcwOQsI14YdbfcTUyKZkAPQdMPF6FLM2fV1hgAbPbILLfm3rlj+imRqRBgMwQdWfz6o2dcDUy65o8Q5zrQ2rlMUPRiZpgirLNbJzIBxt4RvYFjG1gjEFIKVm7DA02p6U2RI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CcDYz/RA; arc=fail smtp.client-ip=40.107.130.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LEVG8T/4hs6JcCaxJUq1+1r1Qr3OwXILCDtoO1vjTwvbCIsIY0adLNJDxoY6mzxwmczJmdSXrsESOfP2clfMvtKj/gFWCU72pmP/ICS/HkXZORR8aauuYRjsqeOp8RrzLD6QL4RWMbnGmeNc+T2oulFwYIokzOTqQ1nQ6VdR/sfjtrTv6W+Iae62IX1qb0ShBTSfWlBnQqKwoyN2ryRBeuoA0iDKzjI8yV7SfsfnzaxLb9JsYtbY3jV9mXtFLf4dDkPTlF3j4bhCIL94DkxuTFqdacM4VySp59ZkF2PIT5DQQdTsZFS+/C5kJ7ag76u5g7yc2Mljf/eM2eW5LbT1YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WCtiPRAizwteKPLrtiCImmvhUZ1pljaEC5nBm1a6eEA=;
 b=Wk4QGwhCuY1IAkGJ9rfjRzrjcLwILLJrNyf1Qc7GWOSzJ00eWIndNPjPme4/SFZHKkqlYqS64o2r7KQjTgeIs4vv7J5xrDqtf0YS15cwuw1gjLUcPLww5Rg5f616A4mF4Pvgu+HbYlIuo5GA1SkGGba5Nl2F5qGsuPE64+MsOwKYtlpyhkFiC5355vKu54i1qZFQZ5tQRH6GUJaxAZ1Q0O9oWKBMseMRreGn6H+SYtsNPKS6aZeHUD/KIxcH/44y+l0y84bGijd87ljsZz/3aPjNLrXAB1qtXRJtXh5lfrWYFMllFdnygIb6vxyV/kRlaNqFGxJ8E8rH01+nWsfKww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WCtiPRAizwteKPLrtiCImmvhUZ1pljaEC5nBm1a6eEA=;
 b=CcDYz/RAT9ThwNiXL9MKgnU7tO+8H/cIaMgv7Oj9Ns23z0v+YdDnpXr/debyMlSPanZvXJ8yt/C5187h00i98MJW8rKTOOJbAjajA7RN0nWX4WEBG6dSbJWyj+Aztsrp/x6Br289q7tuHgLxyG/m3/RBs+nz/O14yi6RXDmkddnPRgOZlUUUg9ayl8smcoxB4U31VdXQ2UrwJ2Yyb5/tRoFLdHV3E/X/109CAdIrDyvsGWGa2kafhSp6xi9EKQ4Nfe6rwow/QR109GhnQgzUM58EkHVJ1YYd66YS5s850bc5FuRvPXxd4cyYDh4JE8hSxJITUQWVVenId5zjMBulsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AM9PR04MB7540.eurprd04.prod.outlook.com (2603:10a6:20b:283::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Fri, 19 Sep
 2025 06:25:36 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce%4]) with mapi id 15.20.9137.015; Fri, 19 Sep 2025
 06:25:36 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: gregkh@linuxfoundation.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	jun.li@nxp.com
Cc: linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: usb: dwc3-imx8mp: dma-range is required only for imx8mp
Date: Fri, 19 Sep 2025 14:25:34 +0800
Message-Id: <20250919062534.2443959-1-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::8)
 To DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|AM9PR04MB7540:EE_
X-MS-Office365-Filtering-Correlation-Id: ed01b9b9-c1de-43c5-9370-08ddf74557ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZdR0XKPbusVOnoAClsIk1I1KQPy77LDqu3HmbJ6RznDZlEG7VAv8emZ4mv+a?=
 =?us-ascii?Q?sfBB+tOcP/rbfT7W3Ar+PLIH9s0ccoG7i5tfsL0luNAzn+Zd/W9dbgW9iUhe?=
 =?us-ascii?Q?TK45ZErIYoAP5RfY/bTrrRnFM1FurNauHQwFKgmhos8b/yb1cUJ0ESjnto0f?=
 =?us-ascii?Q?AHfmi6g4Lkw+rMTK3ec4Mwxt+4lNGA1Jm5jIiQMXmuWnQZ6mPfBkkQKXJw5v?=
 =?us-ascii?Q?zdb6wIRlg6tvU+hWEsqCgncLi4mhmuPORctaB97ogLp5wxu/1YDP+w3CTENu?=
 =?us-ascii?Q?GIeY0ghA4xorjKcZfaSI3GdH2KPw3boIWbE6rt4g80NBwkNDDAKqm/ZDXDHH?=
 =?us-ascii?Q?nvpL6CMLE8g9BjlmwfGvl3mZL86Mj7mSjlle9BiSo6h5Lua1nQsuKiBKEROg?=
 =?us-ascii?Q?ftAxQ4KzRhTwG4g52OIoy/DlfD56Stwmu+ZivoE6E0ij5ajzJFN0nQeHHO10?=
 =?us-ascii?Q?tckmUbjZl3bO/Ch98bYk95rH9JZ9gkhmUoosL1M36aUzdD2Ec0ztiLwHyK2C?=
 =?us-ascii?Q?/HC36cM/Ec4xIXCK9ITiETegHAiZ4uK+wLejS+foAESRoMQIJioGLxfIE2Pu?=
 =?us-ascii?Q?6MIno9Jfuww57Qq+GtixBZbV7naA3x2jfFWS02EtsNNt4XaenRXyc3xN8NFJ?=
 =?us-ascii?Q?6cvu3ha8+5hFFKeLYj7CqUSLQzsqIMWPYOyvM9K7C+p4ks/Z8dP/PmEKoZDN?=
 =?us-ascii?Q?I3h+XP5Y7i9WvWUVCrxGa0utln8iVeq6WBb5eaoGsfZb7q9+bKZncTG/VUA4?=
 =?us-ascii?Q?j1nH0Yj3Xsc7Hz7Tw/VzpSv38EP46mQEvSUXDK75ZrZfh6SUsfYTfBMcjmbC?=
 =?us-ascii?Q?diym8ULQNUTDFEGl6QBDJnowQLrJrKYmmr7TRgCkiLi9ujQ6PHpq4Y53LlzI?=
 =?us-ascii?Q?kbesv6n/6GodVqXhpRBN0eGtZEmdMPdrMpmrDTHJoZ3irAuJbuzDRAXgWS0g?=
 =?us-ascii?Q?J2rqwuQJy+ukI4RFq0q9q+ttCbcRpmoCHWwlFUWyU5z+LKQNq4yLZwzyzFPQ?=
 =?us-ascii?Q?90WIPMwJtFBVMwqtQZvOsVdNcp9vzhpGtL4qVd4V6H/okcyQYr4uMbIb7Ylz?=
 =?us-ascii?Q?qLS+UcYVnNdu0NGjmN/5BCzLhHY0/xtL4UdDkCpWikK2T+B9eyom8+ekXKSS?=
 =?us-ascii?Q?w0SmCiMCG6ZO0oxVLoXcv+v690LH0E3VBBJIcKqzU4m40vgb0nwy84AA05dJ?=
 =?us-ascii?Q?7J5CgB+udA4B6M1zQVky6gx31ise03UR90UlkZEciIq5VRdgfk73bTioW4MU?=
 =?us-ascii?Q?srOSrhgtEQlTBU2iDxg6zvMVHpKBGSLBIMIqaZZzOmXtRNOPP0IWBv0Eccp4?=
 =?us-ascii?Q?IcVpYB6Wkr79lLilIkaKAPsiKbdpMimXCAKN6sasLGhGAleghaUAY/+UjJyq?=
 =?us-ascii?Q?uLP6npBUvweKZWs6ZYOLWzmYpbvVG3qGzZLD4S6d4AAVZkojxt/g8QYPWTcj?=
 =?us-ascii?Q?JSztcbsR7uavRuOLWQC/uW0jgTv1TZRXTn7ifziODZ6HX7dEuGYSww=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ykiam4cTO+osrzCZbDZIHtJGATZNGlFvWBGJe5hbpAVcbsjohsVb/diwdEHV?=
 =?us-ascii?Q?GHIKK52zb4CBp3zpfxTsR6haH+zsInbWq+5ynhwJyb45hhVgkkmDhEdFEwXA?=
 =?us-ascii?Q?d0KTWAY96wWTuccP6bK0EZpnXeDG7KR0x5b/9ju9JdNCBomL5/Me3GGIIzaO?=
 =?us-ascii?Q?KTpFPR5GhEFFrKS94Su8w3GHCRBZV/s6Vi9iCvne7bym1LJCNqv2Dx30+5AF?=
 =?us-ascii?Q?5aDHsCLlxmfEG6Y1IIqC5GIUqZxJ/fPccVvzfuSL2HGe2vd4M6lLh0HQbnU5?=
 =?us-ascii?Q?6x5KrH2bBCe47G9B6PGBqT2pcVX2li22Uml1W1eUZVsbzzY/SrKhRfNx32A/?=
 =?us-ascii?Q?vvqM+kAplHzTIgze/bpPtGy2v4XTWdA0M1UwR6rASGRaVd6Zx5pkaZI/TYQV?=
 =?us-ascii?Q?kdD9/y3LRj18FiK3vdiZijtXUCvrCKSUg9uD4pXGUjvcs8UA/Gx/AxjRU7V1?=
 =?us-ascii?Q?XoLO9/j9bG8jZ9hjIm8i9LMFQ913MdLsTCj3MvP+rwRvAMgA16M0gs9j50iM?=
 =?us-ascii?Q?sp97143Q9QB1kBvu3kS2SyGegEbGtBf43pROu7P/Br+VTk/nF9KAzrxL6MU6?=
 =?us-ascii?Q?BmtUnN55JF7BBuS60/0SLKMDUN6CufBR7SGL9WkIl3JTe6hn8PJkWBCcSYym?=
 =?us-ascii?Q?lG6xFF+kHG+n8Z48wSvpL4bwIrwvsiykedjX2emDQ6OW5Yux26EU0Vy/fIn+?=
 =?us-ascii?Q?95Adqbw7ccBFUNt/7Mk8bEqfyd4TadUuRr+Ex5ZKPHEKV0+I3d2CyIHeJOiG?=
 =?us-ascii?Q?o2cQ/qTijl1XoqOvILuaTMG7X24JW9ONL9C9vZ5X20yDZbPU3B1n1K3F9U4u?=
 =?us-ascii?Q?z9Lqqbmc44fJI7ns6AGR+SK24oxlYi8ij89YR/DlDlADbzxjl6hqwGXk2Bra?=
 =?us-ascii?Q?BTAoHQxy8AesIhcYtth/nxtc/4n/JwV5M7o6GnErs5yD1/BhkzB5mcjWvP2m?=
 =?us-ascii?Q?a8A/E3TOvTATMDFZ6wW+RMBQoGukm7p0whzeCtoCgRzbCoEWV8CinwR7klQU?=
 =?us-ascii?Q?TeEWBY7NK8+nwGjywqTLFSiDvU0DwSkV1DQPl9PbeNEiCWyTfIl8nYKVs9wV?=
 =?us-ascii?Q?Ba/7v3XvixobrrMaeqAsg5DgKxYhtGvlJMDGu1vS7Rtwdeic65zPz7nBAI9P?=
 =?us-ascii?Q?Yvi/atovSFhk1LuXLCQFCrGSli+sUaAKKZvyH7foSTYBQYqC2zGJooQcF70p?=
 =?us-ascii?Q?ru4lHnJ0WznWn5trB3LHCicssB/X+dtbZ54hsP1yPxnHyKHe62JqJPwCnjGm?=
 =?us-ascii?Q?wgGCUYGgUHOaIDMK8xUnQUtHlWIwK6Le5bQtU3QtAVq6o/u04B3cVmOPi8vX?=
 =?us-ascii?Q?UJZORs6pxwiskdJeG0od6l5VL9Pcu6BgpLuRI9vu1jVrsQJn5fzx7nEgadBv?=
 =?us-ascii?Q?lN0KIKQS4f4I/9ojzLuSnq7Jcl3HzzkmLJ8a9hsZ3MdaaDogVpRUL3CeJ0bG?=
 =?us-ascii?Q?d6hDaO/z28w9GcfCr1qsxCKO9g+Iwz3y22BXCbiOUr/FwcatMwV1o/c3ZSh8?=
 =?us-ascii?Q?v6vWkKK5c/XOprlhILo4OVqYXo1/8xvDWCzKQiQl3R2P0MP1xJwtz/LOPK/P?=
 =?us-ascii?Q?8NeiPP/CGekUntrdQRlY8rW3PAP+zcnrW3Ov9XzX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed01b9b9-c1de-43c5-9370-08ddf74557ce
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 06:25:35.8512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zIPBl/H3IrJ/DmqgAFxPHhfnUZDWzBdKwrMwz9/FhiTqX3a6cOSS0WJbIaVI/Yf9u8hOAJ0eUsWNuN0+3B6aYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7540

Only i.MX8MP need dma-range property to let USB controller work properly.
Remove dma-range from required list and add limitation for imx8mp.

Fixes: d2a704e29711 ("dt-bindings: usb: dwc3-imx8mp: add imx8mp dwc3 glue bindings")
Reviewed-by: Jun Li <jun.li@nxp.com>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
---
 .../devicetree/bindings/usb/fsl,imx8mp-dwc3.yaml       | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/fsl,imx8mp-dwc3.yaml b/Documentation/devicetree/bindings/usb/fsl,imx8mp-dwc3.yaml
index baf130669c38..73e7a60a0060 100644
--- a/Documentation/devicetree/bindings/usb/fsl,imx8mp-dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/fsl,imx8mp-dwc3.yaml
@@ -89,13 +89,21 @@ required:
   - reg
   - "#address-cells"
   - "#size-cells"
-  - dma-ranges
   - ranges
   - clocks
   - clock-names
   - interrupts
   - power-domains
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          const: fsl,imx8mp-dwc3
+    then:
+      required:
+        - dma-ranges
+
 additionalProperties: false
 
 examples:
-- 
2.34.1


