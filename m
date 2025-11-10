Return-Path: <linux-kernel+bounces-892687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A94EC459EE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 738F04EC0EA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8DA3019C0;
	Mon, 10 Nov 2025 09:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Obie9vNI"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013006.outbound.protection.outlook.com [52.101.83.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33255301035
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 09:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762766594; cv=fail; b=pWRrnClNVVkaXVpgf4lzZJcS1wFc5z7YB9N8rwa4Ii6wGq3IXIY8YmvoY1BnlE7WO7A9sc7wdFCLwiUfJ2ATLZeBDUovDxVakpxeYeTU4jjJqGy3berx2E/CCaTQRzSiouwrSKHNk5XQbwH6E4CGNq2MfeTpe5QWigfMCfk+3Bw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762766594; c=relaxed/simple;
	bh=7qpp+KUH3huPtEyXmLQzeoom6JC77+M/qSs1SDTDTBU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I55DjcIW+ixJfmUyYr0m1vpnQ7tSHexLPWDizdo8orNlEtuq3Z4ZgDu08tGxAIXBvZgXsjk3hhqL6s2vbiUGtd1d8wdmqbsZKVYFnqlm2VQjys/0b3q9vZjO0zTi/9/ozWRDFruVVIQTUkYreYZPvXDFh/kl8hDD0cvCu8lIrvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Obie9vNI; arc=fail smtp.client-ip=52.101.83.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dl3H9yMqTeZCyC1oIYYXbWZjom1KLa9WfOjz0Y5r0e+mddHjYpaDGVpGGhgsohSfeMnEnTQhPPFC1s1tMvJpzsb9WDTMs66vPjeSOGYlx3ptQ8LyGrAUBXw4JkgmDjWYEyui5SQs+Q21m+gvtCtqLfzRXXZS/JGanK2DQaavpBr/oDCRxfFCz+5BaLnfaGdrBZhkKEDD9aN+iZb2eq9JSbdps32PDWJ6I4Uwm2B9r1FN+JeGQ+8VdODbHXwq1CsfuD48lZqK0gy1MjxXVvAEAXxqf5BkBebkBr21pOwUeu5fO1XLg71t5SUOcyTfLC8CB3KS0HK57PGCHQsKaicDfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HqtThF9G2iwGhsF3bm35/cFTP49DYkDAe1JKOUCzkPo=;
 b=mfoc5ZDUw7naEaEAzoEfUqxPkshAT3E0psIBJfXS5pOEU9BDTjJ6+PalLfN7vcCPrv1XUL1y5IbJCRazX7q5VLIyvhF1tVMkYcEeL7/u0v6Db4QFjkkNfzqGQ882IGCgTLB34x+oTK+CwprzsIx3Mc+Zh/IzxddaV59zn06QY9g3ecctcX5kKpphRJsriw2e21wbCcpHM+EUdR2nfxQP8tU/gs4h73axO/B5hwdU8EboVZDcyfKXpVRt/ITI2u6SrYTupjZ7AakwDVDDDstAJjY4q+9EJNuKRmefEhTzZTsvZ0kExOT08OSfgBnpSyR2wIAui2INa0mJ2wYF8SJLZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HqtThF9G2iwGhsF3bm35/cFTP49DYkDAe1JKOUCzkPo=;
 b=Obie9vNInkwfGufjmNlPuk9Wp+0gxNTtrjH+aBiqhSbYKYm52d7qZOE2r/9RxYAsCM1RGBWsj4kmt/5fRI7nv35b+BoApcE5gl315W+B7mVYAIAqoMj9a+4in5fcJJKMccqj1poGET64Wk0+PefQjmwwBp4Fv1uCJxBUXqgMpeFL2og/9f7Dm+gehxQd3LFhckqbptl6WvSjLuOmCJQaMF4WVTfjFgDKt1q9HIPd8GN8BJB9zDPjDS7SUMAgatGQhkOBy394pzwg4CrXWDWaSm7oVP+3h8G2AME4x1oJvhdIb97xrsr6oiiCFYe+CyPI7vbsrzBvHzP2jn5TZ/LpTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PA1PR04MB10468.eurprd04.prod.outlook.com (2603:10a6:102:448::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 09:23:03 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9298.010; Mon, 10 Nov 2025
 09:23:03 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Josua Mayer <josua@solid-run.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 phy 08/16] phy: lynx-28g: restructure protocol configuration register accesses
Date: Mon, 10 Nov 2025 11:22:33 +0200
Message-Id: <20251110092241.1306838-9-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110092241.1306838-1-vladimir.oltean@nxp.com>
References: <20251110092241.1306838-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0026.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::31) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PA1PR04MB10468:EE_
X-MS-Office365-Filtering-Correlation-Id: bda334e7-1578-44b1-693d-08de203abfe7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vdPJfScyBOd0oKw4WFgtbvYp0663K/Fbp3t1qFLhbRx1tSewqkASarUyvu4D?=
 =?us-ascii?Q?jSX/dCikV3uD1Ga+ca+EnlEX39PQj5wuv5Yf3M8FUFehwQWPNJisW6MSwFNI?=
 =?us-ascii?Q?t4v8Sklbv6xrFZYJsASwHUKRpxWZwSy6G1e3Gf5NrGeTUDt91QP7bTnr7NzK?=
 =?us-ascii?Q?9BgC16H1J3bvqchh4pTApnTtIvq8GFTRr5t3zyQTY7oUPTKToD+Nv+JwvtaL?=
 =?us-ascii?Q?J1qEV4JYsoxfyvVSifKBe75raRKj5KgVLmEoMXs1AREwCEjy9MiKCNiU8wSZ?=
 =?us-ascii?Q?6ib7ABdSB5IYj/5c1/wsjLqeh1e2M1uZj66kSUg0FIsfGHAAyVlAks2sqcn3?=
 =?us-ascii?Q?H/7K5L01Fx1hyilOfDiuiuopn9IRr1yw+m8ytszXmmvCSivQliLToj/DOB4L?=
 =?us-ascii?Q?n9bwEHrk8XsT2rRTEi7zHPjJjRGMOlChl/T0+/ALYMxQURdagqBgLdpKP81g?=
 =?us-ascii?Q?Scdul0JiDTVhORxvesddCztFczhgowFWNjICiz7KKMCT9TF1K3JUbZp7FJbM?=
 =?us-ascii?Q?4TRaROk9R1p6fCGhVMMrGSvrAxDXzZ6mNP+wZvjEvR+tYckQv2pVtjusN/+4?=
 =?us-ascii?Q?dKfK6YDfkLam6Vzt0jH+A6IhRO9rGi7qxdWA6tI7ywdSq2Ek0gibosRS3Z9M?=
 =?us-ascii?Q?KQtldq8cDYxHHyw/a3YsJ7Q6n7/v7P2g2fAqvwEOIgdEu3HLV3hOiVZo2qoT?=
 =?us-ascii?Q?dnljQFmTdRukiTP+uYZrhhL4/qGOz4iXlYjiHkRmEkByy0sAvK7wrjyl2Xik?=
 =?us-ascii?Q?iM8yFKzdr0mHGp/jXwLTr46DGrAIZa+xchHbaA82M0omrbrs4Psy5k0URYw7?=
 =?us-ascii?Q?iq/+dRkpQ2iqBoVM2zBRzBlnxzc5YdDYbf+ov12QWRl3U3BChwiwaOm24pwk?=
 =?us-ascii?Q?NLr+5rFB8UezFCB0rdwGuCMZQq8OoVZkOqvoAUTLD7WR0sJFqx6iqSQua7p1?=
 =?us-ascii?Q?yahdknA04WKIqfSx6UyKwJvmLTfW5wj3xyRS20ZDrtjftPdRy8UUVTvxHuGn?=
 =?us-ascii?Q?1tUGT3PklN4uif5EMBdbpD+PHoMbnvAkKNMgdpN/N3uTY6eRdp/1wgMmLqu9?=
 =?us-ascii?Q?BBBt0Aq+tTmHinhps1kRI/Zin/JIFTdL2VEIaOml5/j9LgeJxljr/sL9owHW?=
 =?us-ascii?Q?BzFs71f9pruRpz8TXwHPhO6P1aftvAqal3hZYt1p6oIXaZI14RE64JW7bLUW?=
 =?us-ascii?Q?3XItelvDGEkdFTj897XzgwHwa6fG4VkTzRH8O3YQ+SBejHRjC/wVP6RotEWt?=
 =?us-ascii?Q?hhkmV0Dnq24m9iJ6WVug+jiSHfkm1kFQA2nZQTjysGyHZ1NC4+giCP6p+07e?=
 =?us-ascii?Q?QWYT3N/GLpWJMp6/Vx2WNIPG2P0V69wfpbI1Nhe8fKj56xId15DKzvM+Pv7E?=
 =?us-ascii?Q?zaPURWkbeT21aIUzxmJXNQEcybHnDs6fyoBmj6XGFph2wzMRUTcQP5DS4GYK?=
 =?us-ascii?Q?jc3hswrwM7oP8ViRdj7ukjanqurUC9ZkmsyhcmjfNvjchHQ2ButRldAgyWoD?=
 =?us-ascii?Q?q55WLFa9TNGBmX7/qmuWcxPBNOI021WINpX4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+L0XLVx9eV7Flrdot9lsiSJ4PFNt3pAw2/uMK3yeFz91cNe1hLUVjaPRhkDH?=
 =?us-ascii?Q?zsf3sW+eW+FVjHeYnaB1tbmy6KSYEWithYDiRU1FbaP9GtQNfnORs0/Xxumr?=
 =?us-ascii?Q?BYiBDzkQBfQElH1WU1/8OghjKLwor0S/d0LacpToJSgPxFWbl7PNZJdlqK6R?=
 =?us-ascii?Q?rd46RfB/6oIMeFdK8PXFowtuA1K08eTZUBzHJdzINNANnxH83OTt59qn1BLQ?=
 =?us-ascii?Q?zMXvi/URDdKsAVxswx+aglGwitrFVPpXt/yOCI44X3yfr2D0t3pi+Cmz1da9?=
 =?us-ascii?Q?42wEGYfXIHx07S+MVzx/l3N5sleWWgQJ6veaQdSWquY0kH7jLhmHuHHyDI2c?=
 =?us-ascii?Q?an+R0M4CjsmvFUUjh44XQSF8FSxS6PuVxiOjweABlBng+z56w0u7MCOCHMXD?=
 =?us-ascii?Q?ebtxuY7TFJeuqaHvsnW/yH7RMsFx7bsQKajJsrPZBmCa9SZ30fDD2VT7f4Uk?=
 =?us-ascii?Q?dq22rUnoLuuxyP7QDnwleHS+Bw2WnPookkeHpRD56BClj/n4tRPiWN1NvTMF?=
 =?us-ascii?Q?SJcIoBUG7MaRpuIk0xu+hyWhI3Rxz957N4dtI2TFOX1vzPmdJTGfvaN0pcLe?=
 =?us-ascii?Q?l0vXTHt83ZWquy4P4Pj7Bxy6fA4CT8EXsXM10COmDHN1jbJN1YbsOzrcVDz2?=
 =?us-ascii?Q?dMEIbYFZRnRQAoM1eAbUocBX/68KrNKFqVg/eV9ovMWelaZ0cj5wibwMafB8?=
 =?us-ascii?Q?SlCT3O+FXHKZqm1wKUUUnSPT8vDUjmvhqNtB3rho4FItjfEL6W1B5dUU+vmB?=
 =?us-ascii?Q?PRs9cx7wjVHDSJ8jPk//+C581IFTbA7hIf8ObiktHgKy0G0sa0H/fE8uSOt7?=
 =?us-ascii?Q?jp/BZWAlhpreAwvuFc2fkP/O/un/rvmFcBIC3VzF4sAQRsJvta9d7hH/WpoX?=
 =?us-ascii?Q?nsXRDqV35D9P9Bcr0LJCCxilFo6IncVWHQ1KM6KS+vyie0LbAk3vo9WXvJ0D?=
 =?us-ascii?Q?Yixl8UEXpkHUX+RgXsJNthTyYuk//J70szuzXZY6wsfa6xNhn2YFSQ9NBAD+?=
 =?us-ascii?Q?yp4inharobIR6odX+t1iPmXXWHsOUBg9xmZdMT0PuNWBfKMldQvCZC7MuWGe?=
 =?us-ascii?Q?givYDEjej9zVkyXQWCYY8s/chKekifq78ZIDcVaP1iYoy3njJm0pwGxbL8XL?=
 =?us-ascii?Q?xoVEkB+RCjrWihudvQC1H3oljnwhIGKaviu3EEHZtl+k8z+4u/b0QlYX5mqw?=
 =?us-ascii?Q?7I0V6fh4g3sqJzOJLV4iWdzkm8IWZfFHI+Hq0UAKzrWKAWb7YTUv0mf+76vJ?=
 =?us-ascii?Q?2ODc5HW/yB7bj7ztOxvqj5a6eHTHWqrF3snJuhFZgv4TeXfec4CDYQZcwR6+?=
 =?us-ascii?Q?La94GZpLmQNPrPIv+1E/jdzTNQkjZ13MavIHqvVaFQnp2+pHOZXvS2rUYi3W?=
 =?us-ascii?Q?CfDlbrAbfJpdj3SJnJPlsaijIOL2y1xA0M4mZfwH5ZR9BcNBURo/9me2yflz?=
 =?us-ascii?Q?XzS1hiJ9dogrUp4GAvA5pvf5GlhT0ngQeIZ5kQFVlFs6kR/T52pREi7vRl4x?=
 =?us-ascii?Q?X9fS93XHZNprPCllCl/ioHHB64llnkYhJj4f1NSqgNf6GP8bhlM1fY1UwukF?=
 =?us-ascii?Q?S/iA3aSVtmI8r05vCm2gKOhjWNyD4KTY10OHdJPx9CFNr37Zl0Nq3Bi/jRVr?=
 =?us-ascii?Q?tw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bda334e7-1578-44b1-693d-08de203abfe7
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 09:23:03.4925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1txtGN5wLsGyvOBXQ3I5QWmNTIsE+qVsDJi8iguQY5LzSDnl/2/jwkNKZWBRuey9vuv7etO77YaqWaoij1/WDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10468

Eliminate the need to calculate a lane_offset manually, and generate
some macros which access the protocol converter corresponding to the
correct lane in the PCC* registers.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v4: none

 drivers/phy/freescale/phy-fsl-lynx-28g.c | 55 ++++++++++++++----------
 1 file changed, 33 insertions(+), 22 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-lynx-28g.c b/drivers/phy/freescale/phy-fsl-lynx-28g.c
index 3b19b7d22b6a..bf06ce42e291 100644
--- a/drivers/phy/freescale/phy-fsl-lynx-28g.c
+++ b/drivers/phy/freescale/phy-fsl-lynx-28g.c
@@ -12,17 +12,32 @@
 #define LYNX_28G_NUM_LANE			8
 #define LYNX_28G_NUM_PLL			2
 
+#define LNa_PCC_OFFSET(lane)			(4 * (LYNX_28G_NUM_LANE - (lane->id) - 1))
+
 /* General registers per SerDes block */
 #define PCC8					0x10a0
-#define PCC8_SGMII				0x1
-#define PCC8_SGMII_DIS				0x0
+#define PCC8_SGMIInCFG(lane, x)			(((x) & GENMASK(2, 0)) << LNa_PCC_OFFSET(lane))
+#define PCC8_SGMIInCFG_EN(lane)			PCC8_SGMIInCFG(lane, 1)
+#define PCC8_SGMIInCFG_MSK(lane)		PCC8_SGMIInCFG(lane, GENMASK(2, 0))
+#define PCC8_SGMIIn_KX(lane, x)			((((x) << 3) & BIT(3)) << LNa_PCC_OFFSET(lane))
+#define PCC8_SGMIIn_KX_MSK(lane)		PCC8_SGMIIn_KX(lane, 1)
+#define PCC8_MSK(lane)				PCC8_SGMIInCFG_MSK(lane) | \
+						PCC8_SGMIIn_KX_MSK(lane)
 
 #define PCCC					0x10b0
-#define PCCC_10GBASER				0x9
-#define PCCC_USXGMII				0x1
-#define PCCC_SXGMII_DIS				0x0
-
-#define LNa_PCC_OFFSET(lane)			(4 * (LYNX_28G_NUM_LANE - (lane->id) - 1))
+#define PCCC_SXGMIInCFG(lane, x)		(((x) & GENMASK(2, 0)) << LNa_PCC_OFFSET(lane))
+#define PCCC_SXGMIInCFG_EN(lane)		PCCC_SXGMIInCFG(lane, 1)
+#define PCCC_SXGMIInCFG_MSK(lane)		PCCC_SXGMIInCFG(lane, GENMASK(2, 0))
+#define PCCC_SXGMIInCFG_XFI(lane, x)		((((x) << 3) & BIT(3)) << LNa_PCC_OFFSET(lane))
+#define PCCC_SXGMIInCFG_XFI_MSK(lane)		PCCC_SXGMIInCFG_XFI(lane, 1)
+#define PCCC_MSK(lane)				PCCC_SXGMIInCFG_MSK(lane) | \
+						PCCC_SXGMIInCFG_XFI_MSK(lane)
+
+#define PCCD					0x10b4
+#define PCCD_E25GnCFG(lane, x)			(((x) & GENMASK(2, 0)) << LNa_PCCD_OFFSET(lane))
+#define PCCD_E25GnCFG_EN(lane)			PCCD_E25GnCFG(lane, 1)
+#define PCCD_E25GnCFG_MSK(lane)			PCCD_E25GnCFG(lane, GENMASK(2, 0))
+#define PCCD_MSK(lane)				PCCD_E25GnCFG_MSK(lane)
 
 /* Per PLL registers */
 #define PLLnRSTCTL(pll)				(0x400 + (pll) * 0x100 + 0x0)
@@ -314,20 +329,21 @@ static void lynx_28g_lane_set_pll(struct lynx_28g_lane *lane,
 static void lynx_28g_cleanup_lane(struct lynx_28g_lane *lane)
 {
 	struct lynx_28g_priv *priv = lane->priv;
-	u32 lane_offset = LNa_PCC_OFFSET(lane);
 
 	/* Cleanup the protocol configuration registers of the current protocol */
 	switch (lane->interface) {
 	case PHY_INTERFACE_MODE_10GBASER:
-		lynx_28g_rmw(priv, PCCC,
-			     PCCC_SXGMII_DIS << lane_offset,
-			     GENMASK(3, 0) << lane_offset);
+		/* Cleanup the protocol configuration registers */
+		lynx_28g_rmw(priv, PCCC, 0, PCCC_MSK(lane));
 		break;
 	case PHY_INTERFACE_MODE_SGMII:
 	case PHY_INTERFACE_MODE_1000BASEX:
-		lynx_28g_rmw(priv, PCC8,
-			     PCC8_SGMII_DIS << lane_offset,
-			     GENMASK(3, 0) << lane_offset);
+		/* Cleanup the protocol configuration registers */
+		lynx_28g_rmw(priv, PCC8, 0, PCC8_MSK(lane));
+
+		/* Disable the SGMII PCS */
+		lynx_28g_lane_rmw(lane, SGMIIaCR1, 0, SGMIIaCR1_SGPCS_EN);
+
 		break;
 	default:
 		break;
@@ -336,16 +352,13 @@ static void lynx_28g_cleanup_lane(struct lynx_28g_lane *lane)
 
 static void lynx_28g_lane_set_sgmii(struct lynx_28g_lane *lane)
 {
-	u32 lane_offset = LNa_PCC_OFFSET(lane);
 	struct lynx_28g_priv *priv = lane->priv;
 	struct lynx_28g_pll *pll;
 
 	lynx_28g_cleanup_lane(lane);
 
 	/* Setup the lane to run in SGMII */
-	lynx_28g_rmw(priv, PCC8,
-		     PCC8_SGMII << lane_offset,
-		     GENMASK(3, 0) << lane_offset);
+	lynx_28g_rmw(priv, PCC8, PCC8_SGMIInCFG_EN(lane), PCC8_MSK(lane));
 
 	/* Setup the protocol select and SerDes parallel interface width */
 	lynx_28g_lane_rmw(lane, LNaGCR0,
@@ -390,15 +403,13 @@ static void lynx_28g_lane_set_sgmii(struct lynx_28g_lane *lane)
 static void lynx_28g_lane_set_10gbaser(struct lynx_28g_lane *lane)
 {
 	struct lynx_28g_priv *priv = lane->priv;
-	u32 lane_offset = LNa_PCC_OFFSET(lane);
 	struct lynx_28g_pll *pll;
 
 	lynx_28g_cleanup_lane(lane);
 
 	/* Enable the SXGMII lane */
-	lynx_28g_rmw(priv, PCCC,
-		     PCCC_10GBASER << lane_offset,
-		     GENMASK(3, 0) << lane_offset);
+	lynx_28g_rmw(priv, PCCC, PCCC_SXGMIInCFG_EN(lane) |
+		     PCCC_SXGMIInCFG_XFI(lane, 1), PCCC_MSK(lane));
 
 	/* Setup the protocol select and SerDes parallel interface width */
 	lynx_28g_lane_rmw(lane, LNaGCR0,
-- 
2.34.1


