Return-Path: <linux-kernel+bounces-834502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 030BEBA4D4F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 20:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C4EE1BC2204
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 18:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4790F30F554;
	Fri, 26 Sep 2025 18:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="A5M69VJZ"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012003.outbound.protection.outlook.com [52.101.66.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733AD30CB5B
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 18:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758909940; cv=fail; b=YbDYNA5EOAvIpBqn8k+sV2YzwOKKh0rW9MwqeqOUCxdc8Z+4KptFM5ivRwpbraOm9yRJaNgsXUNKBK7M5yo8ndMh2hg16HgpISQKhBRPF3O028gzqhq5PvdqFE1IOjI6KqbJYNZ7HSmGrqF3LnGjvcWjW/HCO6Ydcd/iR0a9UUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758909940; c=relaxed/simple;
	bh=8ODCgpnHJOIS5kL7IBGfYYTItNfBITg9l1ng4K8fH9c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j99Axn2gEksmYOGMQWu82guQG0mn6Nn2q4258qmnzNjKkZ+nZ9GWMoy78tll9DkcpLzQsgLi0eBx79+RpJTAr+Jtfkfwt3RhtFD4ECD71al70lZopEzO4/fIRNjY+ltnK9gZ8sGLaMvZmDDzRfZ7GdQj+iRjh7jRebItebL40s8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=A5M69VJZ; arc=fail smtp.client-ip=52.101.66.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vQj43UbXF8zoExuK0bXAaCX9Ml6D3zawGUEZ4HWxYRhgWTLI+G7kqpdM0tATEIvScDrd+yyMjMo6Y37O0boChhWdSYMRRO9RR3p0Gty7SFZX1BKJlpGGwBDV8KEt2E2m5/RhDiGYnsIduf8+puKYiwr1vxqqnW0SAzp8XCnQGsJsz8LXNxp+P3Qamlk15ZnBqK4b9KaO+JdbyFQbcMqkGnpoyKyH2/0bMnkSHa/ECl8EWe6FW5MaMV4GRVrDVgDevYZcsYJG+Eth0gXKNlAu7e1hkYZRdNba/I2RkqW03XkcHChcVL5rh7ximwTBT8Rf7Efso873+jeWPWSQC01XPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wdEmmFGcmfvSgPn00b35ktSyf9KrHqzr2xLeK9W/TGc=;
 b=roRi1LO7SacQNb9F3OQMZByynqAUqYWlSPWXFRjTrVTAbNYBsS8qQMjxro74ixO4X17WBo2kuRij/8MWcOsQRVmmC4eQj+lobPeDLaR2/N+54rsF9dOUjOgTbe3vV8M6Y/G3bNQef2vtfvLJxDUI/racw3pPAlpSqq30BiaCQdXlyO36HJg/x1tapwGUqWhMKgBmE5z6wth2KTHmKZzJrT+/BG2QebrFymJqtWSDudHkWY4eal6o6nVXfNeb5ncCimxTSVc49cqyxbOnjPcOjl3YWE8v5VwSUx41y3xreDo8B+MPbTmNNmF1xfm3D3742OcfhVq9XqaonW+hn5X9fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wdEmmFGcmfvSgPn00b35ktSyf9KrHqzr2xLeK9W/TGc=;
 b=A5M69VJZ9sCzV1j2k1La9Rw8DHLFJfbWL86Sw52BTgv+oNi0Ako4g5mUFwh1873LDInkup02EOPbW4JxMRpaHU0L8SztVWDbc2aH9LkZpOeEkZqaWCt2GBRzbiViy1QPNJB72xCkGpkRGoEZCGHgcj3UIYie/X19/QdLWEsLz0PRS05DTMlgfS45F50HOsamA1vbT3nRCBmkI8hKBgs3Sk+9gwW1Uo1BWOJvUlQHLjoMGgRwckIruSpYvnssOHii0wh79m/7bBqyMe7XLVkvgSnXiqV6ApSJfTya6a2eZOQm+8zAk01Mba8r39V9EhKBz1oBwcfWi2d/az+PmuZcSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS8PR04MB7878.eurprd04.prod.outlook.com (2603:10a6:20b:2af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Fri, 26 Sep
 2025 18:05:27 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9160.010; Fri, 26 Sep 2025
 18:05:27 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Josua Mayer <josua@solid-run.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 phy 06/17] phy: lynx-28g: make lynx_28g_set_lane_mode() more systematic
Date: Fri, 26 Sep 2025 21:04:54 +0300
Message-Id: <20250926180505.760089-7-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250926180505.760089-1-vladimir.oltean@nxp.com>
References: <20250926180505.760089-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P250CA0008.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5df::9) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS8PR04MB7878:EE_
X-MS-Office365-Filtering-Correlation-Id: bda48315-a63d-4c03-7ffc-08ddfd274548
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vPXGqLCRMnZLnSbmRMm6TUip/b0mkVba8ffloypjHFeqG25DOvuR0+Mxse18?=
 =?us-ascii?Q?6pmqgZvvk0mnnr3u0h4W8sSLHIRqkxz/oItrpPP15lcKX6aBCiz6Eoo6WHsz?=
 =?us-ascii?Q?25k1SJoFcgaZ1uMeLasTeoUVrKZewSMWMEb154MynLydwLuw3qiuz253msYD?=
 =?us-ascii?Q?K2DiInEyRuFHvdIEl3R4S/HdWZ92kbBpxVRVhIUYeManukd/jQuqr9Yo4u4V?=
 =?us-ascii?Q?Y2+TiTBl9JfF8/qmVNr7Or44X0R98rz3HRbUoqdsJRDSzvIFf/3whZAJQpJo?=
 =?us-ascii?Q?5qYScj4bWxHgOoEYc0eI3s/D7AW9khTqmC9rU/9PLwEH638/m7iAgqZeqdE7?=
 =?us-ascii?Q?zjAlBQLv6QBxNiyoZcbycxNTMLc6iYHF3SsWpigsafr1cLeDR1s7X5fjLpg0?=
 =?us-ascii?Q?iPLjm4fNQZmWmMolFqupjRSxYYcYLDQ2vzZA71fuo8CmL2BoO4K5Qi2M5ai6?=
 =?us-ascii?Q?J4T89/V55zcEF5WjkMq2HWDGgMc6Rpi4fHzKNCVBPasTyXyEydBlPsc/7NG+?=
 =?us-ascii?Q?gtK2CyPIkYU8LnvL3JTGOCiRo33GiX15n/+BU3RbOlfhjdFnGr5R/CAqq6qA?=
 =?us-ascii?Q?DI0YlcFR86S1Rvn672QXnNH9VfVU/OIGnUVh2seX1/34YcRx6Ssjc1TxEJFj?=
 =?us-ascii?Q?sgrWILWUtVAqgWX2FTywqz41xMIhjfiz3KLMWJtU4RerHynQlGRoTZFVPtV7?=
 =?us-ascii?Q?q2FDCq1H3dRQqQymLFBGvZKSa8yDBeJAUB75HxK8EC0yiVmQsqX6cOXv1YFp?=
 =?us-ascii?Q?jygypvZkl2ZjspE4e1morlu4ArzPgHs8Pxp51sIMW4y1moCrI7PtbQG8j0Rz?=
 =?us-ascii?Q?rJsEVj0QJd2O3Try4yzbHl/l969NGbhGkYbrvBNBbu5aC1yo+R4/j7nQU/1P?=
 =?us-ascii?Q?uJ8zy8XAtEv3NTEOVyhui1NOgDVVkdNfWs3+3ifwFicPRIZrhYAeu484RSPu?=
 =?us-ascii?Q?kuniNw2sjzieoNtsimNvXjXbS8BDV3nbKoUhFkdxNsJ5JtgN+GBXhojB8LS6?=
 =?us-ascii?Q?JqCFa0MhQq6tIk1Qj3SqOdKvDuqW2YlnrCWr0o3BjJBScjzTQ4oi509HzV2y?=
 =?us-ascii?Q?vL2wVdALbKgW9bCAfdmC6vFjcCkhQ+4fb3AZSWODr1CPIe1celAqqaVIoGHZ?=
 =?us-ascii?Q?PWDOxyWnnY5CQwX9EQ/4APub7Ia7/SDNqfX7x6r9i7Et82Xlvmut9d3I/Vek?=
 =?us-ascii?Q?RX9qUIlTTy10buyvEydZoBszgW6y6SgC/BKi5v3K8V3FIbpUwQ+j5b1ah+BK?=
 =?us-ascii?Q?4RHL5EoTw4E9lQgi0aBru6l5gv/xn/NcgMydOTtqjLKOwda4uyAAiv1jxUvG?=
 =?us-ascii?Q?Y5y5HmNnljFzz0ASXObtki0fL8EJ1hyrlArxBmiH8twEtc0PsTKCl9k9XtAA?=
 =?us-ascii?Q?hitPITE4St1AnMYp8qf1avpYWt0guoOYNI+rJUVVrMof48HSPrGoL9KyrQRh?=
 =?us-ascii?Q?8I8NrU4D1BdxbTMJrEN5GsS4veUo8AqCwErAXIPctDdFQ1SCQdEeE+QMqoTL?=
 =?us-ascii?Q?im3OVpQUDYy34J1TB/bvalSD5/bEJJ8GzBVj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mYRQgw6sKCa965Z//vgNmVvplTcvzFtrkhfipzEL4WwwJXtGqkxr6Byv1MdC?=
 =?us-ascii?Q?T3YMWjV+sT5hhpgTsTtlW91kfhKcZ+jEWdLYec2sB/VORByo21ax1DwezHMJ?=
 =?us-ascii?Q?P6X5pj6WmYSGtNGxrrEjEkXlhVX79VnGcXiXC/864piPLT2GmPfv+FRc0BJz?=
 =?us-ascii?Q?yzr1ghEFW4rSy1w6bH0sYKvZQr2XtPdRcvZ/q+KR1cTJLUtPhgBJ/gHvZVmK?=
 =?us-ascii?Q?EYql5fezKtwnYgZ6H6GvVrufKfhZzT+281JWRInIQdq1FAYKcJbjbjTnKg0u?=
 =?us-ascii?Q?pcMDEaDMORKD2GBeecFX6L8WYwAd3E9UdAfWG/fjZs0Yyq8Awa8bb/c3Heb+?=
 =?us-ascii?Q?RPoSMISSuPW6opZmxtxZBzmi1PsZTQx1LVFQxvoXZKzCxlzsRC5Qxb0JJddy?=
 =?us-ascii?Q?7148kiOwLZ8Ks11QRNTCHlIUfNSWQwwc+IYb66Ciri973G8g2VCqjDYqD1Ol?=
 =?us-ascii?Q?zrSANVyyah2jooR/Gf8kIjzWB/t0Kt48o4P3xKXeOs/F03lhnkZpKQhwMHJ/?=
 =?us-ascii?Q?EHGPXFtEEem66l99tb0ONWxvPQGNlDcrwp6j91v9MGBpQwKCr4NAuEPeBsCo?=
 =?us-ascii?Q?fz5M4HmCC4HnNLM3Yc7aIBEhiAm0kny7iX08NKpBZjz4nY4Mgu/4TEQQhwyt?=
 =?us-ascii?Q?1oJGSP3VzTekBk+i+kUqn48Cgxw1ZaJ36tpW9PpJGd2vwX+/tAFegHl4Syi4?=
 =?us-ascii?Q?nA320lcQOhUXfYSOWAx5heghaV1b0oOtgWS08RsmKSh/OEaamL85k/4Md6Mz?=
 =?us-ascii?Q?ZgxEHTEiASLu24DOE9T0LkjSX7WxgN9dv7UF1fbBXMXedLEx9JOHdC8Wkf+b?=
 =?us-ascii?Q?iX4be7uZbTZ6Bz+lMSEh4FRbrC/9mkIfbH+nhioc36umBzw2YY49HYZyxpsN?=
 =?us-ascii?Q?jmq5eX3ccX+UovWqmbyT0tL1Au2aMVK5WaqMiZv5b9Dky7nrHr75fgDZdsEg?=
 =?us-ascii?Q?703lB5oWfNg1lMCXY+jKZRFvp9ZBofs1wISRAq5bllPCSy2CMVQi4k/LXWNI?=
 =?us-ascii?Q?drd8Ry378a7orx8xb2E1XmdlZOwNRZzd6rGJuHx7MY8lAZR1yiYz3OCxWh1q?=
 =?us-ascii?Q?/doOaGNyw2QS1tmTGccjpIpv7Yr/LCXM3wmTzNv3wmYKb7q7ZUDN4T6XEpQH?=
 =?us-ascii?Q?RpocjMRX6OV3TYQYpisdsWiz31vJflqso5aETMiotmMTmh5at7nx4m1Rtr3L?=
 =?us-ascii?Q?o36ikqaiC43J5EPGMClv8yBkj64kqNEpo9FPMG3kGuiQ4f9+9FGjhxKo7PBS?=
 =?us-ascii?Q?+Vx964Cp/44w1sKSU+Qc/TFo7C7HQnEK4awwJJLngFF8ZWxB/HN9ZU9v2Ukg?=
 =?us-ascii?Q?Zi/T2q0oJOy6UftlpOYDudvF9fg6pj2HVy4Hk5m4KVMGKuMoOWJUrHQbP8Ip?=
 =?us-ascii?Q?VuEr10TMzT49SV2/tOTkiuLGU1H+kGujDja9IW2CvONpMJ9QaExxWbVtSlk+?=
 =?us-ascii?Q?iYqRuBdi+cwWGuP2XFHz7MF3RD/6DrUu25G0dyqpTotvZZRFUEbiv0Imwlzb?=
 =?us-ascii?Q?H1meMKm8vToiLEaJSatru0FdJM9s8EtiRR0hr/HK8cbf0/gbWTWNWl7kW4i1?=
 =?us-ascii?Q?w62FD1Y8GwQBJ5BDbAvUzVlk+guBw8e0NHWWZO9izvYVgbLv+/wzVpeoq91F?=
 =?us-ascii?Q?nw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bda48315-a63d-4c03-7ffc-08ddfd274548
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 18:05:26.7304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SCwgcK+2iam5GGUX4gEh3ww/D1JHQskqKCvb4X8K/4FBlFaKQqjhyeH5FYbocpySbQv/RIH1U/yfQCI5j4UBRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7878

The current approach of transitioning from one SerDes protocol to
another in lynx_28g_set_lane_mode() is too poetic.

Because the driver only supports 1GbE and 10GbE, it only modifies those
registers which it knows are different between these two modes. However,
that is hardly extensible for 25GbE, 40GbE, backplane modes, etc.

We need something more systematic to make sure that all lane and
protocol converter registers are written to consistent values, no matter
what was the source lane mode.

For that, we need to introduce tables with register field values, for
each supported lane mode.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v2->v3: none
v1->v2: fix LNaGCR0_PROTO_SEL | LNaGCR0_IF_WIDTH access by using
        FIELD_PREP()

 drivers/phy/freescale/phy-fsl-lynx-28g.c | 659 +++++++++++++++++------
 1 file changed, 496 insertions(+), 163 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-lynx-28g.c b/drivers/phy/freescale/phy-fsl-lynx-28g.c
index 41a346ac38e2..65eb00938b72 100644
--- a/drivers/phy/freescale/phy-fsl-lynx-28g.c
+++ b/drivers/phy/freescale/phy-fsl-lynx-28g.c
@@ -12,32 +12,32 @@
 #define LYNX_28G_NUM_LANE			8
 #define LYNX_28G_NUM_PLL			2
 
-#define LNa_PCC_OFFSET(lane)			(4 * (LYNX_28G_NUM_LANE - (lane->id) - 1))
-
-/* General registers per SerDes block */
+/* SoC IP wrapper for protocol converters */
 #define PCC8					0x10a0
-#define PCC8_SGMIInCFG(lane, x)			(((x) & GENMASK(2, 0)) << LNa_PCC_OFFSET(lane))
-#define PCC8_SGMIInCFG_EN(lane)			PCC8_SGMIInCFG(lane, 1)
-#define PCC8_SGMIInCFG_MSK(lane)		PCC8_SGMIInCFG(lane, GENMASK(2, 0))
-#define PCC8_SGMIIn_KX(lane, x)			((((x) << 3) & BIT(3)) << LNa_PCC_OFFSET(lane))
-#define PCC8_SGMIIn_KX_MSK(lane)		PCC8_SGMIIn_KX(lane, 1)
-#define PCC8_MSK(lane)				PCC8_SGMIInCFG_MSK(lane) | \
-						PCC8_SGMIIn_KX_MSK(lane)
+#define PCC8_SGMIIa_KX				BIT(3)
+#define PCC8_SGMIIa_CFG				BIT(0)
 
 #define PCCC					0x10b0
-#define PCCC_SXGMIInCFG(lane, x)		(((x) & GENMASK(2, 0)) << LNa_PCC_OFFSET(lane))
-#define PCCC_SXGMIInCFG_EN(lane)		PCCC_SXGMIInCFG(lane, 1)
-#define PCCC_SXGMIInCFG_MSK(lane)		PCCC_SXGMIInCFG(lane, GENMASK(2, 0))
-#define PCCC_SXGMIInCFG_XFI(lane, x)		((((x) << 3) & BIT(3)) << LNa_PCC_OFFSET(lane))
-#define PCCC_SXGMIInCFG_XFI_MSK(lane)		PCCC_SXGMIInCFG_XFI(lane, 1)
-#define PCCC_MSK(lane)				PCCC_SXGMIInCFG_MSK(lane) | \
-						PCCC_SXGMIInCFG_XFI_MSK(lane)
+#define PCCC_SXGMIIn_XFI			BIT(3)
+#define PCCC_SXGMIIn_CFG			BIT(0)
 
 #define PCCD					0x10b4
-#define PCCD_E25GnCFG(lane, x)			(((x) & GENMASK(2, 0)) << LNa_PCCD_OFFSET(lane))
-#define PCCD_E25GnCFG_EN(lane)			PCCD_E25GnCFG(lane, 1)
-#define PCCD_E25GnCFG_MSK(lane)			PCCD_E25GnCFG(lane, GENMASK(2, 0))
-#define PCCD_MSK(lane)				PCCD_E25GnCFG_MSK(lane)
+#define PCCD_E25Gn_CFG				BIT(0)
+
+#define PCCE					0x10b8
+#define PCCE_E40Gn_LRV				BIT(3)
+#define PCCE_E40Gn_CFG				BIT(0)
+#define PCCE_E50Gn_LRV				BIT(3)
+#define PCCE_E50GnCFG				BIT(0)
+#define PCCE_E100Gn_LRV				BIT(3)
+#define PCCE_E100Gn_CFG				BIT(0)
+
+#define SGMII_CFG(id)				(28 - (id) * 4) /* Offset into PCC8 */
+#define SXGMII_CFG(id)				(28 - (id) * 4) /* Offset into PCCC */
+#define E25G_CFG(id)				(28 - (id) * 4) /* Offset into PCCD */
+#define E40G_CFG(id)				(28 - (id) * 4) /* Offset into PCCE */
+#define E50G_CFG(id)				(20 - (id) * 4) /* Offset into PCCE */
+#define E100G_CFG(id)				(12 - (id) * 4) /* Offset into PCCE */
 
 /* Per PLL registers */
 #define PLLnRSTCTL(pll)				(0x400 + (pll) * 0x100 + 0x0)
@@ -92,6 +92,10 @@
 #define LNaTECR0_EQ_POST1Q			GENMASK(12, 8)
 #define LNaTECR0_EQ_AMP_RED			GENMASK(5, 0)
 
+#define LNaTECR1(lane)				(0x800 + (lane) * 0x100 + 0x34)
+#define LNaTECR1_EQ_ADPT_EQ_DRVR_DIS		BIT(31)
+#define LNaTECR1_EQ_ADPT_EQ			GENMASK(29, 24)
+
 /* Lane a Rx Reset Control Register */
 #define LNaRRSTCTL(lane)			(0x800 + (lane) * 0x100 + 0x40)
 #define LNaRRSTCTL_HLT_REQ			BIT(27)
@@ -147,6 +151,21 @@
 #define LNaRECR2_EQ_BIN_DATA_AVG_TC		GENMASK(5, 4)
 #define LNaRECR2_SPARE_IN			GENMASK(1, 0)
 
+#define LNaRECR3(lane)				(0x800 + (lane) * 0x100 + 0x5c)
+#define LNaRECR3_EQ_SNAP_START			BIT(31)
+#define LNaRECR3_EQ_SNAP_DONE			BIT(30)
+#define LNaRECR3_EQ_GAINK2_HF_STAT		GENMASK(28, 24)
+#define LNaRECR3_EQ_GAINK3_MF_STAT		GENMASK(20, 16)
+#define LNaRECR3_SPARE_OUT			GENMASK(13, 12)
+#define LNaRECR3_EQ_GAINK4_LF_STAT		GENMASK(4, 0)
+
+#define LNaRECR4(lane)				(0x800 + (lane) * 0x100 + 0x60)
+#define LNaRECR4_BLW_STAT			GENMASK(28, 24)
+#define LNaRECR4_EQ_OFFSET_STAT			GENMASK(21, 16)
+#define LNaRECR4_EQ_BIN_DATA_SEL		GENMASK(15, 12)
+#define LNaRECR4_EQ_BIN_DATA			GENMASK(8, 0) /* bit 9 is reserved */
+#define LNaRECR4_EQ_BIN_DATA_SGN		BIT(8)
+
 #define LNaRSCCR0(lane)				(0x800 + (lane) * 0x100 + 0x74)
 #define LNaRSCCR0_SMP_OFF_EN			BIT(31)
 #define LNaRSCCR0_SMP_OFF_OV_EN			BIT(30)
@@ -161,20 +180,199 @@
 #define LNaRSCCR0_SMP_AUTOZ_EG1R		GENMASK(5, 4)
 #define LNaRSCCR0_SMP_AUTOZ_EG1F		GENMASK(1, 0)
 
+#define LNaTCSR0(lane)				(0x800 + (lane) * 0x100 + 0xa0)
+#define LNaTCSR0_SD_STAT_OBS_EN			BIT(31)
+#define LNaTCSR0_SD_LPBK_SEL			GENMASK(29, 28)
+
 #define LNaPSS(lane)				(0x1000 + (lane) * 0x4)
 #define LNaPSS_TYPE				GENMASK(30, 24)
-#define LNaPSS_TYPE_SGMII			0x4
-#define LNaPSS_TYPE_XFI				0x28
+#define LNaPSS_TYPE_SGMII			(PROTO_SEL_SGMII_BASEX_KX << 2)
+#define LNaPSS_TYPE_XFI				(PROTO_SEL_XFI_10GBASER_KR_SXGMII << 2)
+#define LNaPSS_TYPE_40G				((PROTO_SEL_XFI_10GBASER_KR_SXGMII << 2) | 3)
+#define LNaPSS_TYPE_25G				(PROTO_SEL_25G_50G_100G << 2)
+#define LNaPSS_TYPE_100G			((PROTO_SEL_25G_50G_100G << 2) | 2)
 
+/* MDEV_PORT is at the same bitfield address for all protocol converters */
+#define MDEV_PORT				GENMASK(31, 27)
+
+#define SGMIIaCR0(lane)				(0x1800 + (lane) * 0x10)
 #define SGMIIaCR1(lane)				(0x1804 + (lane) * 0x10)
 #define SGMIIaCR1_SGPCS_EN			BIT(11)
 
+#define ANLTaCR0(lane)				(0x1a00 + (lane) * 0x10)
+#define ANLTaCR1(lane)				(0x1a04 + (lane) * 0x10)
+
+#define SXGMIIaCR0(lane)			(0x1a80 + (lane) * 0x10)
+#define SXGMIIaCR0_RST				BIT(31)
+#define SXGMIIaCR0_PD				BIT(30)
+
+#define SXGMIIaCR1(lane)			(0x1a84 + (lane) * 0x10)
+
+#define E25GaCR0(lane)				(0x1b00 + (lane) * 0x10)
+#define E25GaCR0_RST				BIT(31)
+#define E25GaCR0_PD				BIT(30)
+
+#define E25GaCR1(lane)				(0x1b04 + (lane) * 0x10)
+
+#define E25GaCR2(lane)				(0x1b08 + (lane) * 0x10)
+#define E25GaCR2_FEC_ENA			BIT(23)
+#define E25GaCR2_FEC_ERR_ENA			BIT(22)
+#define E25GaCR2_FEC91_ENA			BIT(20)
+
+#define E40GaCR0(pcvt)				(0x1b40 + (pcvt) * 0x20)
+#define E40GaCR1(pcvt)				(0x1b44 + (pcvt) * 0x20)
+
+#define E50GaCR1(pcvt)				(0x1b84 + (pcvt) * 0x10)
+
+#define E100GaCR1(pcvt)				(0x1c04 + (pcvt) * 0x20)
+
+#define CR(x)					((x) * 4)
+
 enum lynx_28g_eq_type {
 	EQ_TYPE_NO_EQ = 0,
 	EQ_TYPE_2TAP = 1,
 	EQ_TYPE_3TAP = 2,
 };
 
+enum lynx_28g_proto_sel {
+	PROTO_SEL_PCIE = 0,
+	PROTO_SEL_SGMII_BASEX_KX = 1,
+	PROTO_SEL_SATA = 2,
+	PROTO_SEL_XAUI = 4,
+	PROTO_SEL_XFI_10GBASER_KR_SXGMII = 0xa,
+	PROTO_SEL_25G_50G_100G = 0x1a,
+};
+
+struct lynx_28g_proto_conf {
+	/* LNaGCR0 */
+	int proto_sel;
+	int if_width;
+	/* LNaTECR0 */
+	int teq_type;
+	int sgn_preq;
+	int ratio_preq;
+	int sgn_post1q;
+	int ratio_post1q;
+	int amp_red;
+	/* LNaTECR1 */
+	int adpt_eq;
+	/* LNaRGCR1 */
+	int enter_idle_flt_sel;
+	int exit_idle_flt_sel;
+	int data_lost_th_sel;
+	/* LNaRECR0 */
+	int gk2ovd;
+	int gk3ovd;
+	int gk4ovd;
+	int gk2ovd_en;
+	int gk3ovd_en;
+	int gk4ovd_en;
+	/* LNaRECR1 ? */
+	int eq_offset_ovd;
+	int eq_offset_ovd_en;
+	/* LNaRECR2 */
+	int eq_offset_rng_dbl;
+	int eq_blw_sel;
+	int eq_boost;
+	int spare_in;
+	/* LNaRSCCR0 */
+	int smp_autoz_d1r;
+	int smp_autoz_eg1r;
+};
+
+static const struct lynx_28g_proto_conf lynx_28g_proto_conf[PHY_INTERFACE_MODE_MAX] = {
+	[PHY_INTERFACE_MODE_SGMII] = {
+		.proto_sel = LNaGCR0_PROTO_SEL_SGMII,
+		.if_width = LNaGCR0_IF_WIDTH_10_BIT,
+		.teq_type = EQ_TYPE_NO_EQ,
+		.sgn_preq = 1,
+		.ratio_preq = 0,
+		.sgn_post1q = 1,
+		.ratio_post1q = 0,
+		.amp_red = 6,
+		.adpt_eq = 48,
+		.enter_idle_flt_sel = 4,
+		.exit_idle_flt_sel = 3,
+		.data_lost_th_sel = 1,
+		.gk2ovd = 0x1f,
+		.gk3ovd = 0,
+		.gk4ovd = 0,
+		.gk2ovd_en = 1,
+		.gk3ovd_en = 1,
+		.gk4ovd_en = 0,
+		.eq_offset_ovd = 0x1f,
+		.eq_offset_ovd_en = 0,
+		.eq_offset_rng_dbl = 0,
+		.eq_blw_sel = 0,
+		.eq_boost = 0,
+		.spare_in = 0,
+		.smp_autoz_d1r = 0,
+		.smp_autoz_eg1r = 0,
+	},
+	[PHY_INTERFACE_MODE_1000BASEX] = {
+		.proto_sel = LNaGCR0_PROTO_SEL_SGMII,
+		.if_width = LNaGCR0_IF_WIDTH_10_BIT,
+		.teq_type = EQ_TYPE_NO_EQ,
+		.sgn_preq = 1,
+		.ratio_preq = 0,
+		.sgn_post1q = 1,
+		.ratio_post1q = 0,
+		.amp_red = 6,
+		.adpt_eq = 48,
+		.enter_idle_flt_sel = 4,
+		.exit_idle_flt_sel = 3,
+		.data_lost_th_sel = 1,
+		.gk2ovd = 0x1f,
+		.gk3ovd = 0,
+		.gk4ovd = 0,
+		.gk2ovd_en = 1,
+		.gk3ovd_en = 1,
+		.gk4ovd_en = 0,
+		.eq_offset_ovd = 0x1f,
+		.eq_offset_ovd_en = 0,
+		.eq_offset_rng_dbl = 0,
+		.eq_blw_sel = 0,
+		.eq_boost = 0,
+		.spare_in = 0,
+		.smp_autoz_d1r = 0,
+		.smp_autoz_eg1r = 0,
+	},
+	[PHY_INTERFACE_MODE_10GBASER] = {
+		.proto_sel = LNaGCR0_PROTO_SEL_XFI,
+		.if_width = LNaGCR0_IF_WIDTH_20_BIT,
+		.teq_type = EQ_TYPE_2TAP,
+		.sgn_preq = 1,
+		.ratio_preq = 0,
+		.sgn_post1q = 1,
+		.ratio_post1q = 3,
+		.amp_red = 7,
+		.adpt_eq = 48,
+		.enter_idle_flt_sel = 0,
+		.exit_idle_flt_sel = 0,
+		.data_lost_th_sel = 0,
+		.gk2ovd = 0,
+		.gk3ovd = 0,
+		.gk4ovd = 0,
+		.gk2ovd_en = 0,
+		.gk3ovd_en = 0,
+		.gk4ovd_en = 0,
+		.eq_offset_ovd = 0x1f,
+		.eq_offset_ovd_en = 0,
+		.eq_offset_rng_dbl = 1,
+		.eq_blw_sel = 1,
+		.eq_boost = 0,
+		.spare_in = 0,
+		.smp_autoz_d1r = 2,
+		.smp_autoz_eg1r = 0,
+	},
+};
+
+struct lynx_pccr {
+	int offset;
+	int width;
+	int shift;
+};
+
 struct lynx_28g_priv;
 
 struct lynx_28g_pll {
@@ -218,6 +416,10 @@ static void lynx_28g_rmw(struct lynx_28g_priv *priv, unsigned long off,
 	iowrite32(tmp, reg);
 }
 
+#define lynx_28g_read(priv, off) \
+	ioread32((priv)->base + (off))
+#define lynx_28g_write(priv, off, val) \
+	iowrite32(val, (priv)->base + (off))
 #define lynx_28g_lane_rmw(lane, reg, val, mask)	\
 	lynx_28g_rmw((lane)->priv, reg(lane->id), val, mask)
 #define lynx_28g_lane_read(lane, reg)			\
@@ -326,130 +528,6 @@ static void lynx_28g_lane_set_pll(struct lynx_28g_lane *lane,
 	}
 }
 
-static void lynx_28g_cleanup_lane(struct lynx_28g_lane *lane)
-{
-	struct lynx_28g_priv *priv = lane->priv;
-
-	/* Cleanup the protocol configuration registers of the current protocol */
-	switch (lane->interface) {
-	case PHY_INTERFACE_MODE_10GBASER:
-		/* Cleanup the protocol configuration registers */
-		lynx_28g_rmw(priv, PCCC, 0, PCCC_MSK(lane));
-		break;
-	case PHY_INTERFACE_MODE_SGMII:
-	case PHY_INTERFACE_MODE_1000BASEX:
-		/* Cleanup the protocol configuration registers */
-		lynx_28g_rmw(priv, PCC8, 0, PCC8_MSK(lane));
-
-		/* Disable the SGMII PCS */
-		lynx_28g_lane_rmw(lane, SGMIIaCR1, 0, SGMIIaCR1_SGPCS_EN);
-
-		break;
-	default:
-		break;
-	}
-}
-
-static void lynx_28g_lane_set_sgmii(struct lynx_28g_lane *lane)
-{
-	struct lynx_28g_priv *priv = lane->priv;
-	struct lynx_28g_pll *pll;
-
-	lynx_28g_cleanup_lane(lane);
-
-	/* Setup the lane to run in SGMII */
-	lynx_28g_rmw(priv, PCC8, PCC8_SGMIInCFG_EN(lane), PCC8_MSK(lane));
-
-	/* Setup the protocol select and SerDes parallel interface width */
-	lynx_28g_lane_rmw(lane, LNaGCR0,
-			  FIELD_PREP(LNaGCR0_PROTO_SEL, LNaGCR0_PROTO_SEL_SGMII) |
-			  FIELD_PREP(LNaGCR0_IF_WIDTH, LNaGCR0_IF_WIDTH_10_BIT),
-			  LNaGCR0_PROTO_SEL | LNaGCR0_IF_WIDTH);
-
-	/* Find the PLL that works with this interface type */
-	pll = lynx_28g_pll_get(priv, PHY_INTERFACE_MODE_SGMII);
-	if (unlikely(pll == NULL))
-		return;
-
-	/* Switch to the PLL that works with this interface type */
-	lynx_28g_lane_set_pll(lane, pll);
-
-	/* Choose the portion of clock net to be used on this lane */
-	lynx_28g_lane_set_nrate(lane, pll, PHY_INTERFACE_MODE_SGMII);
-
-	/* Enable the SGMII PCS */
-	lynx_28g_lane_rmw(lane, SGMIIaCR1, SGMIIaCR1_SGPCS_EN,
-			  SGMIIaCR1_SGPCS_EN);
-
-	/* Configure the appropriate equalization parameters for the protocol */
-	lynx_28g_lane_write(lane, LNaTECR0,
-			    LNaTECR0_EQ_SGN_PREQ | LNaTECR0_EQ_SGN_POST1Q |
-			    FIELD_PREP(LNaTECR0_EQ_AMP_RED, 6));
-	lynx_28g_lane_write(lane, LNaRGCR1,
-			    FIELD_PREP(LNaRGCR1_ENTER_IDLE_FLT_SEL, 4) |
-			    FIELD_PREP(LNaRGCR1_EXIT_IDLE_FLT_SEL, 3) |
-			    LNaRGCR1_DATA_LOST_FLT);
-	lynx_28g_lane_write(lane, LNaRECR0,
-			    LNaRECR0_EQ_GAINK2_HF_OV_EN |
-			    FIELD_PREP(LNaRECR0_EQ_GAINK2_HF_OV, 31) |
-			    LNaRECR0_EQ_GAINK3_MF_OV_EN |
-			    FIELD_PREP(LNaRECR0_EQ_GAINK3_MF_OV, 0));
-	lynx_28g_lane_write(lane, LNaRECR1,
-			    FIELD_PREP(LNaRECR1_EQ_OFFSET_OV, 31));
-	lynx_28g_lane_write(lane, LNaRECR2, 0);
-	lynx_28g_lane_write(lane, LNaRSCCR0, 0);
-}
-
-static void lynx_28g_lane_set_10gbaser(struct lynx_28g_lane *lane)
-{
-	struct lynx_28g_priv *priv = lane->priv;
-	struct lynx_28g_pll *pll;
-
-	lynx_28g_cleanup_lane(lane);
-
-	/* Enable the SXGMII lane */
-	lynx_28g_rmw(priv, PCCC, PCCC_SXGMIInCFG_EN(lane) |
-		     PCCC_SXGMIInCFG_XFI(lane, 1), PCCC_MSK(lane));
-
-	/* Setup the protocol select and SerDes parallel interface width */
-	lynx_28g_lane_rmw(lane, LNaGCR0,
-			  FIELD_PREP(LNaGCR0_PROTO_SEL, LNaGCR0_PROTO_SEL_XFI) |
-			  FIELD_PREP(LNaGCR0_IF_WIDTH, LNaGCR0_IF_WIDTH_20_BIT),
-			  LNaGCR0_PROTO_SEL | LNaGCR0_IF_WIDTH);
-
-	/* Find the PLL that works with this interface type */
-	pll = lynx_28g_pll_get(priv, PHY_INTERFACE_MODE_10GBASER);
-	if (unlikely(pll == NULL))
-		return;
-
-	/* Switch to the PLL that works with this interface type */
-	lynx_28g_lane_set_pll(lane, pll);
-
-	/* Choose the portion of clock net to be used on this lane */
-	lynx_28g_lane_set_nrate(lane, pll, PHY_INTERFACE_MODE_10GBASER);
-
-	/* Disable the SGMII PCS */
-	lynx_28g_lane_rmw(lane, SGMIIaCR1, 0, SGMIIaCR1_SGPCS_EN);
-
-	/* Configure the appropriate equalization parameters for the protocol */
-	lynx_28g_lane_write(lane, LNaTECR0,
-			    FIELD_PREP(LNaTECR0_EQ_TYPE, EQ_TYPE_2TAP) |
-			    LNaTECR0_EQ_SGN_PREQ |
-			    FIELD_PREP(LNaTECR0_EQ_PREQ, 0) |
-			    LNaTECR0_EQ_SGN_POST1Q |
-			    FIELD_PREP(LNaTECR0_EQ_POST1Q, 3) |
-			    FIELD_PREP(LNaTECR0_EQ_AMP_RED, 7));
-	lynx_28g_lane_write(lane, LNaRGCR1, LNaRGCR1_IDLE_CONFIG);
-	lynx_28g_lane_write(lane, LNaRECR0, 0);
-	lynx_28g_lane_write(lane, LNaRECR1, FIELD_PREP(LNaRECR1_EQ_OFFSET_OV, 31));
-	lynx_28g_lane_write(lane, LNaRECR2,
-			    LNaRECR2_EQ_OFFSET_RNG_DBL |
-			    FIELD_PREP(LNaRECR2_EQ_BLW_SEL, 1) |
-			    FIELD_PREP(LNaRECR2_EQ_BIN_DATA_AVG_TC, 2));
-	lynx_28g_lane_write(lane, LNaRSCCR0,
-			    FIELD_PREP(LNaRSCCR0_SMP_AUTOZ_D1R, 2));
-}
-
 static int lynx_28g_power_off(struct phy *phy)
 {
 	struct lynx_28g_lane *lane = phy_get_drvdata(phy);
@@ -502,6 +580,268 @@ static int lynx_28g_power_on(struct phy *phy)
 	return 0;
 }
 
+static int lynx_28g_get_pccr(phy_interface_t interface, int lane,
+			     struct lynx_pccr *pccr)
+{
+	switch (interface) {
+	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_1000BASEX:
+		pccr->offset = PCC8;
+		pccr->width = 4;
+		pccr->shift = SGMII_CFG(lane);
+		break;
+	case PHY_INTERFACE_MODE_10GBASER:
+		pccr->offset = PCCC;
+		pccr->width = 4;
+		pccr->shift = SXGMII_CFG(lane);
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static int lynx_28g_get_pcvt_offset(int lane, phy_interface_t interface)
+{
+	switch (interface) {
+	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_1000BASEX:
+		return SGMIIaCR0(lane);
+	case PHY_INTERFACE_MODE_10GBASER:
+		return SXGMIIaCR0(lane);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int lynx_pccr_write(struct lynx_28g_lane *lane,
+			   phy_interface_t interface, u32 val)
+{
+	struct lynx_28g_priv *priv = lane->priv;
+	struct lynx_pccr pccr;
+	u32 old, tmp, mask;
+	int err;
+
+	err = lynx_28g_get_pccr(interface, lane->id, &pccr);
+	if (err)
+		return err;
+
+	old = lynx_28g_read(priv, pccr.offset);
+	mask = GENMASK(pccr.width - 1, 0) << pccr.shift;
+	tmp = (old & ~mask) | (val << pccr.shift);
+	lynx_28g_write(priv, pccr.offset, tmp);
+
+	dev_dbg(&lane->phy->dev, "PCCR@0x%x: 0x%x -> 0x%x\n",
+		pccr.offset, old, tmp);
+
+	return 0;
+}
+
+static int lynx_pcvt_read(struct lynx_28g_lane *lane, phy_interface_t interface,
+			  int cr, u32 *val)
+{
+	struct lynx_28g_priv *priv = lane->priv;
+	int offset;
+
+	offset = lynx_28g_get_pcvt_offset(lane->id, interface);
+	if (offset < 0)
+		return offset;
+
+	*val = lynx_28g_read(priv, offset + cr);
+
+	return 0;
+}
+
+static int lynx_pcvt_write(struct lynx_28g_lane *lane, phy_interface_t interface,
+			   int cr, u32 val)
+{
+	struct lynx_28g_priv *priv = lane->priv;
+	int offset;
+
+	offset = lynx_28g_get_pcvt_offset(lane->id, interface);
+	if (offset < 0)
+		return offset;
+
+	lynx_28g_write(priv, offset + cr, val);
+
+	return 0;
+}
+
+static int lynx_pcvt_rmw(struct lynx_28g_lane *lane, phy_interface_t interface,
+			 int cr, u32 val, u32 mask)
+{
+	int err;
+	u32 tmp;
+
+	err = lynx_pcvt_read(lane, interface, cr, &tmp);
+	if (err)
+		return err;
+
+	tmp &= ~mask;
+	tmp |= val;
+
+	return lynx_pcvt_write(lane, interface, cr, tmp);
+}
+
+static void lynx_28g_lane_remap_pll(struct lynx_28g_lane *lane,
+				    phy_interface_t interface)
+{
+	struct lynx_28g_priv *priv = lane->priv;
+	struct lynx_28g_pll *pll;
+
+	/* Switch to the PLL that works with this interface type */
+	pll = lynx_28g_pll_get(priv, interface);
+	if (unlikely(pll == NULL))
+		return;
+
+	lynx_28g_lane_set_pll(lane, pll);
+
+	/* Choose the portion of clock net to be used on this lane */
+	lynx_28g_lane_set_nrate(lane, pll, interface);
+}
+
+static void lynx_28g_lane_change_proto_conf(struct lynx_28g_lane *lane,
+					    phy_interface_t interface)
+{
+	const struct lynx_28g_proto_conf *conf = &lynx_28g_proto_conf[interface];
+
+	lynx_28g_lane_rmw(lane, LNaGCR0,
+			  FIELD_PREP(LNaGCR0_PROTO_SEL, conf->proto_sel) |
+			  FIELD_PREP(LNaGCR0_IF_WIDTH, conf->if_width),
+			  LNaGCR0_PROTO_SEL | LNaGCR0_IF_WIDTH);
+
+	lynx_28g_lane_rmw(lane, LNaTECR0,
+			  FIELD_PREP(LNaTECR0_EQ_TYPE, conf->teq_type) |
+			  FIELD_PREP(LNaTECR0_EQ_SGN_PREQ, conf->sgn_preq) |
+			  FIELD_PREP(LNaTECR0_EQ_PREQ, conf->ratio_preq) |
+			  FIELD_PREP(LNaTECR0_EQ_SGN_POST1Q, conf->sgn_post1q) |
+			  FIELD_PREP(LNaTECR0_EQ_POST1Q, conf->ratio_post1q) |
+			  FIELD_PREP(LNaTECR0_EQ_AMP_RED, conf->amp_red),
+			  LNaTECR0_EQ_TYPE |
+			  LNaTECR0_EQ_SGN_PREQ |
+			  LNaTECR0_EQ_PREQ |
+			  LNaTECR0_EQ_SGN_POST1Q |
+			  LNaTECR0_EQ_POST1Q |
+			  LNaTECR0_EQ_AMP_RED);
+
+	lynx_28g_lane_rmw(lane, LNaTECR1,
+			  FIELD_PREP(LNaTECR1_EQ_ADPT_EQ, conf->adpt_eq),
+			  LNaTECR1_EQ_ADPT_EQ);
+
+	lynx_28g_lane_rmw(lane, LNaRGCR1,
+			  FIELD_PREP(LNaRGCR1_ENTER_IDLE_FLT_SEL, conf->enter_idle_flt_sel) |
+			  FIELD_PREP(LNaRGCR1_EXIT_IDLE_FLT_SEL, conf->exit_idle_flt_sel) |
+			  FIELD_PREP(LNaRGCR1_DATA_LOST_TH_SEL, conf->data_lost_th_sel),
+			  LNaRGCR1_ENTER_IDLE_FLT_SEL |
+			  LNaRGCR1_EXIT_IDLE_FLT_SEL |
+			  LNaRGCR1_DATA_LOST_TH_SEL);
+
+	lynx_28g_lane_rmw(lane, LNaRECR0,
+			  FIELD_PREP(LNaRECR0_EQ_GAINK2_HF_OV_EN, conf->gk2ovd_en) |
+			  FIELD_PREP(LNaRECR0_EQ_GAINK3_MF_OV_EN, conf->gk3ovd_en) |
+			  FIELD_PREP(LNaRECR0_EQ_GAINK4_LF_OV_EN, conf->gk4ovd_en) |
+			  FIELD_PREP(LNaRECR0_EQ_GAINK2_HF_OV, conf->gk2ovd) |
+			  FIELD_PREP(LNaRECR0_EQ_GAINK3_MF_OV, conf->gk3ovd) |
+			  FIELD_PREP(LNaRECR0_EQ_GAINK4_LF_OV, conf->gk4ovd),
+			  LNaRECR0_EQ_GAINK2_HF_OV |
+			  LNaRECR0_EQ_GAINK3_MF_OV |
+			  LNaRECR0_EQ_GAINK4_LF_OV |
+			  LNaRECR0_EQ_GAINK2_HF_OV_EN |
+			  LNaRECR0_EQ_GAINK3_MF_OV_EN |
+			  LNaRECR0_EQ_GAINK4_LF_OV_EN);
+
+	lynx_28g_lane_rmw(lane, LNaRECR1,
+			  FIELD_PREP(LNaRECR1_EQ_OFFSET_OV, conf->eq_offset_ovd) |
+			  FIELD_PREP(LNaRECR1_EQ_OFFSET_OV_EN, conf->eq_offset_ovd_en),
+			  LNaRECR1_EQ_OFFSET_OV |
+			  LNaRECR1_EQ_OFFSET_OV_EN);
+
+	lynx_28g_lane_rmw(lane, LNaRECR2,
+			  FIELD_PREP(LNaRECR2_EQ_OFFSET_RNG_DBL, conf->eq_offset_rng_dbl) |
+			  FIELD_PREP(LNaRECR2_EQ_BLW_SEL, conf->eq_blw_sel) |
+			  FIELD_PREP(LNaRECR2_EQ_BOOST, conf->eq_boost) |
+			  FIELD_PREP(LNaRECR2_SPARE_IN, conf->spare_in),
+			  LNaRECR2_EQ_OFFSET_RNG_DBL |
+			  LNaRECR2_EQ_BLW_SEL |
+			  LNaRECR2_EQ_BOOST |
+			  LNaRECR2_SPARE_IN);
+
+	lynx_28g_lane_rmw(lane, LNaRSCCR0,
+			  FIELD_PREP(LNaRSCCR0_SMP_AUTOZ_D1R, conf->smp_autoz_d1r) |
+			  FIELD_PREP(LNaRSCCR0_SMP_AUTOZ_EG1R, conf->smp_autoz_eg1r),
+			  LNaRSCCR0_SMP_AUTOZ_D1R |
+			  LNaRSCCR0_SMP_AUTOZ_EG1R);
+}
+
+static int lynx_28g_lane_disable_pcvt(struct lynx_28g_lane *lane,
+				      phy_interface_t interface)
+{
+	struct lynx_28g_priv *priv = lane->priv;
+	int err;
+
+	spin_lock(&priv->pcc_lock);
+
+	err = lynx_pccr_write(lane, interface, 0);
+	if (err)
+		goto out;
+
+	switch (interface) {
+	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_1000BASEX:
+		err = lynx_pcvt_rmw(lane, interface, CR(1), 0,
+				    SGMIIaCR1_SGPCS_EN);
+		break;
+	default:
+		err = 0;
+	}
+
+out:
+	spin_unlock(&priv->pcc_lock);
+
+	return err;
+}
+
+static int lynx_28g_lane_enable_pcvt(struct lynx_28g_lane *lane,
+				     phy_interface_t interface)
+{
+	struct lynx_28g_priv *priv = lane->priv;
+	u32 val;
+	int err;
+
+	spin_lock(&priv->pcc_lock);
+
+	switch (interface) {
+	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_1000BASEX:
+		err = lynx_pcvt_rmw(lane, interface, CR(1), SGMIIaCR1_SGPCS_EN,
+				    SGMIIaCR1_SGPCS_EN);
+		break;
+	default:
+		err = 0;
+	}
+
+	val = 0;
+
+	switch (interface) {
+	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_1000BASEX:
+		val |= PCC8_SGMIIa_CFG;
+		break;
+	case PHY_INTERFACE_MODE_10GBASER:
+		val |= PCCC_SXGMIIn_CFG | PCCC_SXGMIIn_XFI;
+		break;
+	default:
+		break;
+	}
+
+	err = lynx_pccr_write(lane, interface, val);
+
+	spin_unlock(&priv->pcc_lock);
+
+	return err;
+}
+
 static int lynx_28g_set_mode(struct phy *phy, enum phy_mode mode, int submode)
 {
 	struct lynx_28g_lane *lane = phy_get_drvdata(phy);
@@ -518,33 +858,26 @@ static int lynx_28g_set_mode(struct phy *phy, enum phy_mode mode, int submode)
 	if (!lynx_28g_supports_interface(priv, submode))
 		return -EOPNOTSUPP;
 
+	if (submode == lane->interface)
+		return 0;
+
 	/* If the lane is powered up, put the lane into the halt state while
 	 * the reconfiguration is being done.
 	 */
 	if (powered_up)
 		lynx_28g_power_off(phy);
 
-	spin_lock(&priv->pcc_lock);
-
-	switch (submode) {
-	case PHY_INTERFACE_MODE_SGMII:
-	case PHY_INTERFACE_MODE_1000BASEX:
-		lynx_28g_lane_set_sgmii(lane);
-		break;
-	case PHY_INTERFACE_MODE_10GBASER:
-		lynx_28g_lane_set_10gbaser(lane);
-		break;
-	default:
-		err = -EOPNOTSUPP;
+	err = lynx_28g_lane_disable_pcvt(lane, lane->interface);
+	if (err)
 		goto out;
-	}
+
+	lynx_28g_lane_change_proto_conf(lane, submode);
+	lynx_28g_lane_remap_pll(lane, submode);
+	WARN_ON(lynx_28g_lane_enable_pcvt(lane, submode));
 
 	lane->interface = submode;
 
 out:
-	spin_unlock(&priv->pcc_lock);
-
-	/* Power up the lane if necessary */
 	if (powered_up)
 		lynx_28g_power_on(phy);
 
-- 
2.34.1


