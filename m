Return-Path: <linux-kernel+bounces-834503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 775EDBA4D58
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 20:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09E5E16AEE8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 18:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860BD30F7F3;
	Fri, 26 Sep 2025 18:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dsdtBdV7"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012044.outbound.protection.outlook.com [52.101.66.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BAB30CD97
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 18:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758909940; cv=fail; b=cci1bJFiGD5OKwMMH60TPkpMaY17ywl6Frj0zKIhu2refRI3mYgCAQ+LCjOJ7gdh76cp7bKHbW7PinPz3+NDhZS50QXQ4zLX1niYEVW8EZ1KnByT52r8ggpNBCZUsrY7EbDgAEO3k62APSEoLEQaF2AjPHsCqcPH2FUQ8YGFVZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758909940; c=relaxed/simple;
	bh=aVZpzmuTlIONZrxshMCFbM3155oA6KCT6McQrfwESbk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MLZtIOEycO8Vk+oFNZUedocJR3iw1nkz4XFJKKKbFWWAtu0Ej7mzYkrBRI487qHwf5LtIb6D0K89SlWxdeS9iqw3m1ijLBXfhYbUROjdnI8OyUjiY7op5LKshZc/YF519kpV+J7mtnhKJNXjb2rHDvpPAL8Sm785RqeoQCosA7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dsdtBdV7; arc=fail smtp.client-ip=52.101.66.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fDfCNtD1tIO6TO352F+eSpNVPBNmgBMnzsbgwApPqXUruf/UN1n25dkTLxg9lf+zWHqB5su2/dr+nYJMyDcJ8UwR4CaREvZvfIV89SwGG+QC+C3vL+F9BkpVv6A7j43BBvelxv16CyUqPiMXAIKhXWRPx7jLIM/QBVwrue76DYpYqu2zOMpZfV50ZdrYC7m76k3APTPN72K2aDrlnvEO95BboQ+lhdE+GHjBhsGF4Z6VgxpgtqP4XB+GE1v8QkDHDBRArEjjD3fChbd4506ruzn5XlzI5IWl2SYgz09Q6fc+O/59wKbHUVnL955fhMuee8sUxadf3IgtO5HN9KV3Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6S9F0DNEmhQ6GwoZSiLbBSbSByNFayiFDZXI3SkhMbA=;
 b=OO+fAGr312caM30Rk7SUS4155QZlqNtw5ZWovtw1UY0myc56w6YXta8TKqZvoAXjwqfaN70i+VbVhOi1JAfGHmQUJObNoa3QhnVKhFZvb8ks2Sg70YQEBFfxSx1cXcjKTPrviwicTOhTPWFjh4IqcezrYU4SuUVMQp8N5Y0sIMaTcpXaCBLP//hgmYCnbTdVE1YcbJNZRqynf1a+I50OdJO0qe5fACwd8VK0jtaVOblw7vMZlm7l96jHh1wHZRVe5p2fz4OhMDGExA6gyGd4sEBK73Z6gKt1ouGlNR45plMLmi2zb9Ujj8Z9OjJiSpuuFP1zTmI7UqTQfwu5W8w0aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6S9F0DNEmhQ6GwoZSiLbBSbSByNFayiFDZXI3SkhMbA=;
 b=dsdtBdV7qx3usWux7/o1FaOG2iDRmQde17+J+llJQAu26x8Hmc0f9OQxjmVwABYm8kG8Ms8IacQFMRBYbP0gACtG4ECIIaHC788wgT/IVxXmSU2mEwyjZZYeqr6SnaioCdqsBr4cobTY8lBKOovpUcX17UxdHCyOFVfryb0zgCrX9aAWI8loSoh3cml8rvrMIWqz7WKWkPWi+8YXsgfytvp0iLu3oIs+xHe7ISPSFNpEJToVRhS6oQ6lu3lvFQ+bSn/He+cFV1Z6LCurhf6RCuSwUZ0GsLeSO//aj9QGRfgt9RYgXV5UHnCT/djEx33ySJb/hrSaKmx37Ym76qd3pg==
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
Subject: [PATCH v3 phy 07/17] phy: lynx-28g: refactor lane->interface to lane->mode
Date: Fri, 26 Sep 2025 21:04:55 +0300
Message-Id: <20250926180505.760089-8-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: efd74319-6bd0-4741-5f9e-08ddfd2745c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wUU5i0lELqb+OtIxU/VdEOp/x2NA/rWJwDguixE4+yT0dHRIgEmSEzSjXjBL?=
 =?us-ascii?Q?NRmqcI8Mnum0AwqW20YgEfiU1sKn1TwNO0jDFAOP3WLrWUpP/96mjB4SD70y?=
 =?us-ascii?Q?HarcNP1pm4VNaghhsOxmi90ObpSiKRskkyBLlgHO0J568hhVE8RqVTuPwOGB?=
 =?us-ascii?Q?KZ6vNRZdqutPj3ejA0OAf5xf8FMt1anoIK+zGagB2GtCxviwNtqvFKCAOhLR?=
 =?us-ascii?Q?8BL9CJUIuMdPtceX+LuJU2dyQctL4om/Qf0V7BrCEaD0nU94VtzNtmgEs8Hm?=
 =?us-ascii?Q?gSIu2Dtl7uQ069ZL6rw7UFCTRPI7Ko4V4rHjO1ipUL6glCWJvaYsbzb8Tf+D?=
 =?us-ascii?Q?9X07HthFvvKr/5DiAl0BPw5NAxdJKJDAzhdkmNdMr6Z3QTFmF2m1U7dbPuEx?=
 =?us-ascii?Q?xlNn2S9U+Uh3vw5vtdo8cON1En2NGRqUW4LyAkJSQ0YBBFWvfv3jT4bY5NRe?=
 =?us-ascii?Q?j97XE1teQYPZJsPhN+F3A4Qt1K9G4djnOYvhlZSXQEWMm8yQxQy2Qs0Zl6mF?=
 =?us-ascii?Q?Cwp1YuKfTQAuc1g+wV/sAfwRaJr2IWLPRLGbz+w5UW6zsXmB1wEGCmjnCYJx?=
 =?us-ascii?Q?2FNrkynM81+rlsv6Qc6UcI3NJdMlW0pkx70pKhlRN1tdWYXUvCK8g7VwOT49?=
 =?us-ascii?Q?41CxB29Rp+u9pXkjlRMw3sLNiqZgceP/g7vJmejHPyvGSs8ADpbrBO7rcITR?=
 =?us-ascii?Q?zRXVkKWnTX9snkmzkuNFrvt9sby0P8P+njfkgXbeHZSfzhmkNFUvQQwGix73?=
 =?us-ascii?Q?d7ahY1AQsk3lZF27oIjl1nRVR+qnDgvdzRXLCM74lE4qi0p7tg/5qc4Vzq7v?=
 =?us-ascii?Q?D1EK2cowibxu8aTAHHz4weXQUnt4U8Jk177gNYbBKC1Hxg10DHd37xqm6jS1?=
 =?us-ascii?Q?lCV3WVk6i6ROrtXgfkVIbnVsql94So+UQdTy8wSrG3xakB359VESNdr9dhP8?=
 =?us-ascii?Q?lMxneMhuHoGTof57y0s4iFQvk7K1cDZW8ZZo1j6A9mnQit8skIIppOQDLtTR?=
 =?us-ascii?Q?8nbXffWieQU2Gd7rkWD0tmdxzA7tzAXqhYm75Rib60z1nTBWECp2GnEDIGl2?=
 =?us-ascii?Q?r5VgPYztH+PYBKl4hETP/Cu8T7SduoLSlJDIaQxZyU1I3UoEW2TMJ3W74t2T?=
 =?us-ascii?Q?V13G4pm4RpRn0pJewbeKYBPg+KFFQxcSp8PYJxUn82K+ZNI+Uf5F8yWb+H1u?=
 =?us-ascii?Q?7/splerrA5KVNNr0mb6B3MK6zaaQJa4bP2u3dbcGPaskNFAyYiN4E1KAvddq?=
 =?us-ascii?Q?fKQHGvmzT1cY4s3URUt3+tMvIKf13rN6feJNVKhDGWKKBM4heQydmOK0Qi+W?=
 =?us-ascii?Q?NwCtylfgDfMCE0cjShu7sJ24FUuSYzZB7I14dvsf1w9he8l7OMv0JUcHf+Y3?=
 =?us-ascii?Q?NRm9x4GooUo8jhD3JKCExJKlEvdDCr1NXfzp8DaoqezJX1d2DPM4FWS1N8N5?=
 =?us-ascii?Q?ovT8sH50jcB+/S5cVKgWd7SGtKzluR7t7ZvIwSEqQ/eOK2XJZSkAGhcw89IS?=
 =?us-ascii?Q?1yxDnz/egMYqplcmneaHVPdTXntIJcBxz4U0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AkXei15+kGWacSWh0k8UsKqfV0Pk/8Pxc/RBrR7/GoeelPU5GKPpveqP2cVW?=
 =?us-ascii?Q?qwTFNY+/LdvG1F9hD/xY8x5qkg3UcpJ3pHoZygWKUNg4NQQ5ApIkrGXSzv28?=
 =?us-ascii?Q?YUfpPUMKDAIazTpXTLJ9VHP5YI8lgJjGbIfwb8aPwKdydCnbYYpNpI4ip5Hj?=
 =?us-ascii?Q?60ReZdaphBI8MLSATgySc2aqp1arpovBEgZ8NtoTpACLogV5kh9Rq1N9UyP6?=
 =?us-ascii?Q?kxYpoU64j0uk4szJUL2wvWWqk523ge4RopHahqEnhDBnuQhqXu+lBhEIkzUx?=
 =?us-ascii?Q?ch4lTav0spDztL1aUf+/QNV4Ux6ALpd1zj6DP+Z2I4CTURxbsy3Wkdy3D9ST?=
 =?us-ascii?Q?NFcq05alU8DTn4BVbbc2Oq3oCZek3EHcXxNkJwBIXb0mRhuJqiXyX+oFQaHr?=
 =?us-ascii?Q?QvJJYYa0tWogSSCXpe42SCFT8/KNFTD8spvQjuF9YBJsbacl1CCt2k7WArEA?=
 =?us-ascii?Q?jMxLmQYNzcnLrY70oB4+i+RSrmL1k+oiv08PztT/XQCuYm7POtUwIlhY1XjT?=
 =?us-ascii?Q?SCAlyjSN/87UvruEzDDobqHYMIk9xEAhCMT8Ain2ooC6gxYXhEq1jB0WyW9v?=
 =?us-ascii?Q?UH2YBacFwEqA8zeJoSiyGeTKU0kyyjwh5ypkWg/KwO0cDW5xObvw1cY086uQ?=
 =?us-ascii?Q?EjDyrxdronDOipdVlb4nnxjU0tfy0iEn4ylUbKs+KW6avgDFYZdrvK7s02ja?=
 =?us-ascii?Q?R9hkl/+1u7SbK7MER0wPg9pfYE5xAj1QsPUgzIpBFmePRV2FSNgWolmQ+H0W?=
 =?us-ascii?Q?tbSbZIIGbM2Ikl73tFe9icFrDVM1ran0qJRk0gbJ8Rgyt4doU/zfMXfIo0P0?=
 =?us-ascii?Q?Y3vVSL3v26q/QzRr1RhPZfoZtRN4/5Uzg7dosnZPyjFTLS9o/lpn+2LZSr65?=
 =?us-ascii?Q?nnjGt5l499YTDwJk82zOxb9nKku9rqui4FbQJRcA97by6roflsxnaeZC8gSk?=
 =?us-ascii?Q?LIeg5BuFGPRdsNSIv3eAY4nX9PUjpyDqc9AxoLmZJAzNpjkmxiiEz3wL8uXI?=
 =?us-ascii?Q?lgJ4ZUgVYfDWmVkLhJycif0wHcXfzqkDwWbqi5dNHX8ipH2k04s3gllA4SxA?=
 =?us-ascii?Q?GfCa1ypP6OLir1U5Gpc9I4iuMZ4kDTPW+WVrk3nkzpHfxmabMceQOg1Cru0y?=
 =?us-ascii?Q?ejcQJn9mnEb/0wYDfIS05s3UEX4FgNCuax5dENW+5XMtYdE6G1K0JbBhnXPE?=
 =?us-ascii?Q?Botu4V/A5jO7nxKW4mS+eHKtKeVdy9gOhVXgS4NXzKhCru3YMOQ16n5X5gIm?=
 =?us-ascii?Q?l8C80zoYeZpCcoyoxJRXZUMh/E/vecxwz+hPWAOO6bfJB8JjVT8c9zKo8eXw?=
 =?us-ascii?Q?IOjYBWu6uEoxqlMA605nal+0r4SY0XfxPHzS/sU47+GWz1PtkdRb+j+yrnOp?=
 =?us-ascii?Q?uU0mtTAblmgSDgq9b7N8ERB6Mjz21H2dchY7RA4SKAuJozGZvmgEgdEn/AdJ?=
 =?us-ascii?Q?0odnLqzbIMKr+r5HPgyIcRoegSuKK/jrBqR/AofrxTyHwMgVKDSdVGfQrBXX?=
 =?us-ascii?Q?xc2nsAeqKUNg8vl80EGKlfRrqZRcFiOHJ6FwwCbE8qlKIhkvi+cQcRk9Jfac?=
 =?us-ascii?Q?nG3QKY99gyl0a69t6aJZ3rr0S6lu2USQw8xfReDj3UvBw+CwhTMmZxTZv1p5?=
 =?us-ascii?Q?7Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efd74319-6bd0-4741-5f9e-08ddfd2745c4
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 18:05:27.4911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ioMgZPmjp0cIhap+YXPybKZUaTK9YygJKP0tB8G7ppVSjdk2MhDmuH0Tj9+tKu8UtfYU1NqH/UfKvIFXsA4kUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7878

Lynx 28G is a multi-protocol SerDes - it handles serial Ethernet, PCIe,
SATA.

The driver should not use the phylib-specific phy_interface_t as an
internal data representation, but something specific to its internal
capabilities, and only convert to phy_interface_t when PHY_MODE_ETHERNET
is selected and used.

Otherwise it has no way of representing the non-Ethernet lanes (which
was not a short-term goal when the driver was introduced, and is not a
goal per se right now either, but should nonetheless be possible).

Prefer the "enum lynx_lane_mode" name over "lynx_28g_lane_mode", in
preparation of future Lynx 10G SerDes support. This SerDes is part of
the same IP family and has similar capabilities, and will reuse some
code, hence the common data type.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v2->v3:
- fix lynx_28g_set_mode() by using lane_mode instead of submode
- save lane_mode to local variable in lynx_28g_set_mode()
v1->v2: none

 drivers/phy/freescale/phy-fsl-lynx-28g.c | 208 ++++++++++++-----------
 1 file changed, 106 insertions(+), 102 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-lynx-28g.c b/drivers/phy/freescale/phy-fsl-lynx-28g.c
index 65eb00938b72..7ef81f26bee8 100644
--- a/drivers/phy/freescale/phy-fsl-lynx-28g.c
+++ b/drivers/phy/freescale/phy-fsl-lynx-28g.c
@@ -243,6 +243,13 @@ enum lynx_28g_proto_sel {
 	PROTO_SEL_25G_50G_100G = 0x1a,
 };
 
+enum lynx_lane_mode {
+	LANE_MODE_UNKNOWN,
+	LANE_MODE_1000BASEX_SGMII,
+	LANE_MODE_10GBASER_USXGMII,
+	LANE_MODE_MAX,
+};
+
 struct lynx_28g_proto_conf {
 	/* LNaGCR0 */
 	int proto_sel;
@@ -280,8 +287,8 @@ struct lynx_28g_proto_conf {
 	int smp_autoz_eg1r;
 };
 
-static const struct lynx_28g_proto_conf lynx_28g_proto_conf[PHY_INTERFACE_MODE_MAX] = {
-	[PHY_INTERFACE_MODE_SGMII] = {
+static const struct lynx_28g_proto_conf lynx_28g_proto_conf[LANE_MODE_MAX] = {
+	[LANE_MODE_1000BASEX_SGMII] = {
 		.proto_sel = LNaGCR0_PROTO_SEL_SGMII,
 		.if_width = LNaGCR0_IF_WIDTH_10_BIT,
 		.teq_type = EQ_TYPE_NO_EQ,
@@ -309,35 +316,7 @@ static const struct lynx_28g_proto_conf lynx_28g_proto_conf[PHY_INTERFACE_MODE_M
 		.smp_autoz_d1r = 0,
 		.smp_autoz_eg1r = 0,
 	},
-	[PHY_INTERFACE_MODE_1000BASEX] = {
-		.proto_sel = LNaGCR0_PROTO_SEL_SGMII,
-		.if_width = LNaGCR0_IF_WIDTH_10_BIT,
-		.teq_type = EQ_TYPE_NO_EQ,
-		.sgn_preq = 1,
-		.ratio_preq = 0,
-		.sgn_post1q = 1,
-		.ratio_post1q = 0,
-		.amp_red = 6,
-		.adpt_eq = 48,
-		.enter_idle_flt_sel = 4,
-		.exit_idle_flt_sel = 3,
-		.data_lost_th_sel = 1,
-		.gk2ovd = 0x1f,
-		.gk3ovd = 0,
-		.gk4ovd = 0,
-		.gk2ovd_en = 1,
-		.gk3ovd_en = 1,
-		.gk4ovd_en = 0,
-		.eq_offset_ovd = 0x1f,
-		.eq_offset_ovd_en = 0,
-		.eq_offset_rng_dbl = 0,
-		.eq_blw_sel = 0,
-		.eq_boost = 0,
-		.spare_in = 0,
-		.smp_autoz_d1r = 0,
-		.smp_autoz_eg1r = 0,
-	},
-	[PHY_INTERFACE_MODE_10GBASER] = {
+	[LANE_MODE_10GBASER_USXGMII] = {
 		.proto_sel = LNaGCR0_PROTO_SEL_XFI,
 		.if_width = LNaGCR0_IF_WIDTH_20_BIT,
 		.teq_type = EQ_TYPE_2TAP,
@@ -379,7 +358,7 @@ struct lynx_28g_pll {
 	struct lynx_28g_priv *priv;
 	u32 rstctl, cr0, cr1;
 	int id;
-	DECLARE_PHY_INTERFACE_MASK(supported);
+	DECLARE_BITMAP(supported, LANE_MODE_MAX);
 };
 
 struct lynx_28g_lane {
@@ -388,7 +367,7 @@ struct lynx_28g_lane {
 	bool powered_up;
 	bool init;
 	unsigned int id;
-	phy_interface_t interface;
+	enum lynx_lane_mode mode;
 };
 
 struct lynx_28g_priv {
@@ -429,7 +408,34 @@ static void lynx_28g_rmw(struct lynx_28g_priv *priv, unsigned long off,
 #define lynx_28g_pll_read(pll, reg)			\
 	ioread32((pll)->priv->base + reg((pll)->id))
 
-static bool lynx_28g_supports_interface(struct lynx_28g_priv *priv, int intf)
+static const char *lynx_lane_mode_str(enum lynx_lane_mode lane_mode)
+{
+	switch (lane_mode) {
+	case LANE_MODE_1000BASEX_SGMII:
+		return "1000Base-X/SGMII";
+	case LANE_MODE_10GBASER_USXGMII:
+		return "10GBase-R/USXGMII";
+	default:
+		return "unknown";
+	}
+}
+
+static enum lynx_lane_mode phy_interface_to_lane_mode(phy_interface_t intf)
+{
+	switch (intf) {
+	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_1000BASEX:
+		return LANE_MODE_1000BASEX_SGMII;
+	case PHY_INTERFACE_MODE_10GBASER:
+	case PHY_INTERFACE_MODE_USXGMII:
+		return LANE_MODE_10GBASER_USXGMII;
+	default:
+		return LANE_MODE_UNKNOWN;
+	}
+}
+
+static bool lynx_28g_supports_lane_mode(struct lynx_28g_priv *priv,
+					enum lynx_lane_mode mode)
 {
 	int i;
 
@@ -437,7 +443,7 @@ static bool lynx_28g_supports_interface(struct lynx_28g_priv *priv, int intf)
 		if (PLLnRSTCTL_DIS(priv->pll[i].rstctl))
 			continue;
 
-		if (test_bit(intf, priv->pll[i].supported))
+		if (test_bit(mode, priv->pll[i].supported))
 			return true;
 	}
 
@@ -445,7 +451,7 @@ static bool lynx_28g_supports_interface(struct lynx_28g_priv *priv, int intf)
 }
 
 static struct lynx_28g_pll *lynx_28g_pll_get(struct lynx_28g_priv *priv,
-					     phy_interface_t intf)
+					     enum lynx_lane_mode mode)
 {
 	struct lynx_28g_pll *pll;
 	int i;
@@ -456,27 +462,27 @@ static struct lynx_28g_pll *lynx_28g_pll_get(struct lynx_28g_priv *priv,
 		if (PLLnRSTCTL_DIS(pll->rstctl))
 			continue;
 
-		if (test_bit(intf, pll->supported))
+		if (test_bit(mode, pll->supported))
 			return pll;
 	}
 
 	/* no pll supports requested mode, either caller forgot to check
 	 * lynx_28g_supports_lane_mode, or this is a bug.
 	 */
-	dev_WARN_ONCE(priv->dev, 1, "no pll for interface %s\n", phy_modes(intf));
+	dev_WARN_ONCE(priv->dev, 1, "no pll for lane mode %s\n",
+		      lynx_lane_mode_str(mode));
 	return NULL;
 }
 
 static void lynx_28g_lane_set_nrate(struct lynx_28g_lane *lane,
 				    struct lynx_28g_pll *pll,
-				    phy_interface_t intf)
+				    enum lynx_lane_mode lane_mode)
 {
 	switch (FIELD_GET(PLLnCR1_FRATE_SEL, pll->cr1)) {
 	case PLLnCR1_FRATE_5G_10GVCO:
 	case PLLnCR1_FRATE_5G_25GVCO:
-		switch (intf) {
-		case PHY_INTERFACE_MODE_SGMII:
-		case PHY_INTERFACE_MODE_1000BASEX:
+		switch (lane_mode) {
+		case LANE_MODE_1000BASEX_SGMII:
 			lynx_28g_lane_rmw(lane, LNaTGCR0,
 					  FIELD_PREP(LNaTGCR0_N_RATE, LNaTGCR0_N_RATE_QUARTER),
 					  LNaTGCR0_N_RATE);
@@ -489,9 +495,8 @@ static void lynx_28g_lane_set_nrate(struct lynx_28g_lane *lane,
 		}
 		break;
 	case PLLnCR1_FRATE_10G_20GVCO:
-		switch (intf) {
-		case PHY_INTERFACE_MODE_10GBASER:
-		case PHY_INTERFACE_MODE_USXGMII:
+		switch (lane_mode) {
+		case LANE_MODE_10GBASER_USXGMII:
 			lynx_28g_lane_rmw(lane, LNaTGCR0,
 					  FIELD_PREP(LNaTGCR0_N_RATE, LNaTGCR0_N_RATE_FULL),
 					  LNaTGCR0_N_RATE);
@@ -580,17 +585,16 @@ static int lynx_28g_power_on(struct phy *phy)
 	return 0;
 }
 
-static int lynx_28g_get_pccr(phy_interface_t interface, int lane,
+static int lynx_28g_get_pccr(enum lynx_lane_mode lane_mode, int lane,
 			     struct lynx_pccr *pccr)
 {
-	switch (interface) {
-	case PHY_INTERFACE_MODE_SGMII:
-	case PHY_INTERFACE_MODE_1000BASEX:
+	switch (lane_mode) {
+	case LANE_MODE_1000BASEX_SGMII:
 		pccr->offset = PCC8;
 		pccr->width = 4;
 		pccr->shift = SGMII_CFG(lane);
 		break;
-	case PHY_INTERFACE_MODE_10GBASER:
+	case LANE_MODE_10GBASER_USXGMII:
 		pccr->offset = PCCC;
 		pccr->width = 4;
 		pccr->shift = SXGMII_CFG(lane);
@@ -602,13 +606,12 @@ static int lynx_28g_get_pccr(phy_interface_t interface, int lane,
 	return 0;
 }
 
-static int lynx_28g_get_pcvt_offset(int lane, phy_interface_t interface)
+static int lynx_28g_get_pcvt_offset(int lane, enum lynx_lane_mode lane_mode)
 {
-	switch (interface) {
-	case PHY_INTERFACE_MODE_SGMII:
-	case PHY_INTERFACE_MODE_1000BASEX:
+	switch (lane_mode) {
+	case LANE_MODE_1000BASEX_SGMII:
 		return SGMIIaCR0(lane);
-	case PHY_INTERFACE_MODE_10GBASER:
+	case LANE_MODE_10GBASER_USXGMII:
 		return SXGMIIaCR0(lane);
 	default:
 		return -EOPNOTSUPP;
@@ -616,14 +619,14 @@ static int lynx_28g_get_pcvt_offset(int lane, phy_interface_t interface)
 }
 
 static int lynx_pccr_write(struct lynx_28g_lane *lane,
-			   phy_interface_t interface, u32 val)
+			   enum lynx_lane_mode lane_mode, u32 val)
 {
 	struct lynx_28g_priv *priv = lane->priv;
 	struct lynx_pccr pccr;
 	u32 old, tmp, mask;
 	int err;
 
-	err = lynx_28g_get_pccr(interface, lane->id, &pccr);
+	err = lynx_28g_get_pccr(lane_mode, lane->id, &pccr);
 	if (err)
 		return err;
 
@@ -638,13 +641,13 @@ static int lynx_pccr_write(struct lynx_28g_lane *lane,
 	return 0;
 }
 
-static int lynx_pcvt_read(struct lynx_28g_lane *lane, phy_interface_t interface,
-			  int cr, u32 *val)
+static int lynx_pcvt_read(struct lynx_28g_lane *lane,
+			  enum lynx_lane_mode lane_mode, int cr, u32 *val)
 {
 	struct lynx_28g_priv *priv = lane->priv;
 	int offset;
 
-	offset = lynx_28g_get_pcvt_offset(lane->id, interface);
+	offset = lynx_28g_get_pcvt_offset(lane->id, lane_mode);
 	if (offset < 0)
 		return offset;
 
@@ -653,13 +656,13 @@ static int lynx_pcvt_read(struct lynx_28g_lane *lane, phy_interface_t interface,
 	return 0;
 }
 
-static int lynx_pcvt_write(struct lynx_28g_lane *lane, phy_interface_t interface,
-			   int cr, u32 val)
+static int lynx_pcvt_write(struct lynx_28g_lane *lane,
+			   enum lynx_lane_mode lane_mode, int cr, u32 val)
 {
 	struct lynx_28g_priv *priv = lane->priv;
 	int offset;
 
-	offset = lynx_28g_get_pcvt_offset(lane->id, interface);
+	offset = lynx_28g_get_pcvt_offset(lane->id, lane_mode);
 	if (offset < 0)
 		return offset;
 
@@ -668,43 +671,44 @@ static int lynx_pcvt_write(struct lynx_28g_lane *lane, phy_interface_t interface
 	return 0;
 }
 
-static int lynx_pcvt_rmw(struct lynx_28g_lane *lane, phy_interface_t interface,
+static int lynx_pcvt_rmw(struct lynx_28g_lane *lane,
+			 enum lynx_lane_mode lane_mode,
 			 int cr, u32 val, u32 mask)
 {
 	int err;
 	u32 tmp;
 
-	err = lynx_pcvt_read(lane, interface, cr, &tmp);
+	err = lynx_pcvt_read(lane, lane_mode, cr, &tmp);
 	if (err)
 		return err;
 
 	tmp &= ~mask;
 	tmp |= val;
 
-	return lynx_pcvt_write(lane, interface, cr, tmp);
+	return lynx_pcvt_write(lane, lane_mode, cr, tmp);
 }
 
 static void lynx_28g_lane_remap_pll(struct lynx_28g_lane *lane,
-				    phy_interface_t interface)
+				    enum lynx_lane_mode lane_mode)
 {
 	struct lynx_28g_priv *priv = lane->priv;
 	struct lynx_28g_pll *pll;
 
 	/* Switch to the PLL that works with this interface type */
-	pll = lynx_28g_pll_get(priv, interface);
+	pll = lynx_28g_pll_get(priv, lane_mode);
 	if (unlikely(pll == NULL))
 		return;
 
 	lynx_28g_lane_set_pll(lane, pll);
 
 	/* Choose the portion of clock net to be used on this lane */
-	lynx_28g_lane_set_nrate(lane, pll, interface);
+	lynx_28g_lane_set_nrate(lane, pll, lane_mode);
 }
 
 static void lynx_28g_lane_change_proto_conf(struct lynx_28g_lane *lane,
-					    phy_interface_t interface)
+					    enum lynx_lane_mode lane_mode)
 {
-	const struct lynx_28g_proto_conf *conf = &lynx_28g_proto_conf[interface];
+	const struct lynx_28g_proto_conf *conf = &lynx_28g_proto_conf[lane_mode];
 
 	lynx_28g_lane_rmw(lane, LNaGCR0,
 			  FIELD_PREP(LNaGCR0_PROTO_SEL, conf->proto_sel) |
@@ -775,21 +779,20 @@ static void lynx_28g_lane_change_proto_conf(struct lynx_28g_lane *lane,
 }
 
 static int lynx_28g_lane_disable_pcvt(struct lynx_28g_lane *lane,
-				      phy_interface_t interface)
+				      enum lynx_lane_mode lane_mode)
 {
 	struct lynx_28g_priv *priv = lane->priv;
 	int err;
 
 	spin_lock(&priv->pcc_lock);
 
-	err = lynx_pccr_write(lane, interface, 0);
+	err = lynx_pccr_write(lane, lane_mode, 0);
 	if (err)
 		goto out;
 
-	switch (interface) {
-	case PHY_INTERFACE_MODE_SGMII:
-	case PHY_INTERFACE_MODE_1000BASEX:
-		err = lynx_pcvt_rmw(lane, interface, CR(1), 0,
+	switch (lane_mode) {
+	case LANE_MODE_1000BASEX_SGMII:
+		err = lynx_pcvt_rmw(lane, lane_mode, CR(1), 0,
 				    SGMIIaCR1_SGPCS_EN);
 		break;
 	default:
@@ -803,7 +806,7 @@ static int lynx_28g_lane_disable_pcvt(struct lynx_28g_lane *lane,
 }
 
 static int lynx_28g_lane_enable_pcvt(struct lynx_28g_lane *lane,
-				     phy_interface_t interface)
+				     enum lynx_lane_mode lane_mode)
 {
 	struct lynx_28g_priv *priv = lane->priv;
 	u32 val;
@@ -811,10 +814,9 @@ static int lynx_28g_lane_enable_pcvt(struct lynx_28g_lane *lane,
 
 	spin_lock(&priv->pcc_lock);
 
-	switch (interface) {
-	case PHY_INTERFACE_MODE_SGMII:
-	case PHY_INTERFACE_MODE_1000BASEX:
-		err = lynx_pcvt_rmw(lane, interface, CR(1), SGMIIaCR1_SGPCS_EN,
+	switch (lane_mode) {
+	case LANE_MODE_1000BASEX_SGMII:
+		err = lynx_pcvt_rmw(lane, lane_mode, CR(1), SGMIIaCR1_SGPCS_EN,
 				    SGMIIaCR1_SGPCS_EN);
 		break;
 	default:
@@ -823,19 +825,18 @@ static int lynx_28g_lane_enable_pcvt(struct lynx_28g_lane *lane,
 
 	val = 0;
 
-	switch (interface) {
-	case PHY_INTERFACE_MODE_SGMII:
-	case PHY_INTERFACE_MODE_1000BASEX:
+	switch (lane_mode) {
+	case LANE_MODE_1000BASEX_SGMII:
 		val |= PCC8_SGMIIa_CFG;
 		break;
-	case PHY_INTERFACE_MODE_10GBASER:
+	case LANE_MODE_10GBASER_USXGMII:
 		val |= PCCC_SXGMIIn_CFG | PCCC_SXGMIIn_XFI;
 		break;
 	default:
 		break;
 	}
 
-	err = lynx_pccr_write(lane, interface, val);
+	err = lynx_pccr_write(lane, lane_mode, val);
 
 	spin_unlock(&priv->pcc_lock);
 
@@ -847,18 +848,20 @@ static int lynx_28g_set_mode(struct phy *phy, enum phy_mode mode, int submode)
 	struct lynx_28g_lane *lane = phy_get_drvdata(phy);
 	struct lynx_28g_priv *priv = lane->priv;
 	int powered_up = lane->powered_up;
+	enum lynx_lane_mode lane_mode;
 	int err = 0;
 
 	if (mode != PHY_MODE_ETHERNET)
 		return -EOPNOTSUPP;
 
-	if (lane->interface == PHY_INTERFACE_MODE_NA)
+	if (lane->mode == LANE_MODE_UNKNOWN)
 		return -EOPNOTSUPP;
 
-	if (!lynx_28g_supports_interface(priv, submode))
+	lane_mode = phy_interface_to_lane_mode(submode);
+	if (!lynx_28g_supports_lane_mode(priv, lane_mode))
 		return -EOPNOTSUPP;
 
-	if (submode == lane->interface)
+	if (lane_mode == lane->mode)
 		return 0;
 
 	/* If the lane is powered up, put the lane into the halt state while
@@ -867,15 +870,15 @@ static int lynx_28g_set_mode(struct phy *phy, enum phy_mode mode, int submode)
 	if (powered_up)
 		lynx_28g_power_off(phy);
 
-	err = lynx_28g_lane_disable_pcvt(lane, lane->interface);
+	err = lynx_28g_lane_disable_pcvt(lane, lane->mode);
 	if (err)
 		goto out;
 
-	lynx_28g_lane_change_proto_conf(lane, submode);
-	lynx_28g_lane_remap_pll(lane, submode);
-	WARN_ON(lynx_28g_lane_enable_pcvt(lane, submode));
+	lynx_28g_lane_change_proto_conf(lane, lane_mode);
+	lynx_28g_lane_remap_pll(lane, lane_mode);
+	WARN_ON(lynx_28g_lane_enable_pcvt(lane, lane_mode));
 
-	lane->interface = submode;
+	lane->mode = lane_mode;
 
 out:
 	if (powered_up)
@@ -889,11 +892,13 @@ static int lynx_28g_validate(struct phy *phy, enum phy_mode mode, int submode,
 {
 	struct lynx_28g_lane *lane = phy_get_drvdata(phy);
 	struct lynx_28g_priv *priv = lane->priv;
+	enum lynx_lane_mode lane_mode;
 
 	if (mode != PHY_MODE_ETHERNET)
 		return -EOPNOTSUPP;
 
-	if (!lynx_28g_supports_interface(priv, submode))
+	lane_mode = phy_interface_to_lane_mode(submode);
+	if (!lynx_28g_supports_lane_mode(priv, lane_mode))
 		return -EOPNOTSUPP;
 
 	return 0;
@@ -946,12 +951,11 @@ static void lynx_28g_pll_read_configuration(struct lynx_28g_priv *priv)
 		case PLLnCR1_FRATE_5G_10GVCO:
 		case PLLnCR1_FRATE_5G_25GVCO:
 			/* 5GHz clock net */
-			__set_bit(PHY_INTERFACE_MODE_1000BASEX, pll->supported);
-			__set_bit(PHY_INTERFACE_MODE_SGMII, pll->supported);
+			__set_bit(LANE_MODE_1000BASEX_SGMII, pll->supported);
 			break;
 		case PLLnCR1_FRATE_10G_20GVCO:
 			/* 10.3125GHz clock net */
-			__set_bit(PHY_INTERFACE_MODE_10GBASER, pll->supported);
+			__set_bit(LANE_MODE_10GBASER_USXGMII, pll->supported);
 			break;
 		default:
 			/* 6GHz, 12.890625GHz, 8GHz */
@@ -1002,13 +1006,13 @@ static void lynx_28g_lane_read_configuration(struct lynx_28g_lane *lane)
 	protocol = FIELD_GET(LNaPSS_TYPE, pss);
 	switch (protocol) {
 	case LNaPSS_TYPE_SGMII:
-		lane->interface = PHY_INTERFACE_MODE_SGMII;
+		lane->mode = LANE_MODE_1000BASEX_SGMII;
 		break;
 	case LNaPSS_TYPE_XFI:
-		lane->interface = PHY_INTERFACE_MODE_10GBASER;
+		lane->mode = LANE_MODE_10GBASER_USXGMII;
 		break;
 	default:
-		lane->interface = PHY_INTERFACE_MODE_NA;
+		lane->mode = LANE_MODE_UNKNOWN;
 	}
 }
 
-- 
2.34.1


