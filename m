Return-Path: <linux-kernel+bounces-829587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E399B97646
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 21:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 432994E28BA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 19:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C15730B515;
	Tue, 23 Sep 2025 19:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="J23yWzm5"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013067.outbound.protection.outlook.com [52.101.83.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AFE30506F
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 19:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758656730; cv=fail; b=PatIrkmpjM/FjZg4EKHJMLCw8uiKHJUeuImqsSj2MoSvdCSasUtiUNoI3eWu8JYXOpWwiRYV4UhavO3F3ypDC7OwGT73Xvn5no7NkGT5yt3nAhXt6EA+iJyJImWq1qIJaA6FwF0bzzNzvTuirkcMyPcrmNeYOQIJLs4jHeQT6rI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758656730; c=relaxed/simple;
	bh=SJWXNxAYna6dSV+8NuGdsj9t+ZDn7AV9orB0DPbqf98=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P5ypay3gCJOnMU+/49LbHB+ycywX06H5PWDsmQc5TJc2ndFxLUO7DrwHiLzOmcoTDcVSwYk/yv0xLOC6qJtZFxv6prCzxEjvdsliVb84wUXBk5MdGAUVaZ5jpDXpLMnN9PLgi5mhR+snEGIk2mhSj4sMVlv1gpamj5duLKifuF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=J23yWzm5; arc=fail smtp.client-ip=52.101.83.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qRiCwylzwkngUko9OKFk2iHjtldvRrrN6nTu0Qsan+uUGT7iTTLFoXYuENLyjD/MzsfR6BvAVCUlaAqgPwq7w3ZU76b5wQrMKDlGXyKs1aBf3w3kiMMoWvZBQslPdGpsQL03OqgcdV2T2qgvSm9aXhbfmobtASVMSo9+zv0e2igZN16qshnfvIrykVWi+bGTizrfMNYjNgK35ogg7QvrHCdUS9N1qGijbyGAADMAKXXIMGI+OXqjofdknEpOtvK1iOh+CW+YopIapI53tHhxBRUw51v/2n78uleNuO/29JIvoQJDzMbo12C1YwgeR/QT4YRDvDXcks6oboqPTXOC7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rnQdx5n07Pkzk6JYlW+jnbzE4IShmUoMr2fjX6dhXzY=;
 b=wA6WEu9M5CIb17oTJR0XAjgGQhP9+fqhsW4t+4T8yGwU+FRDjTuGRF3IBbN+Vul8ZyKKC6qVnJ18kRxsP23nU4Nd9Wu/fw+hjWpU4jCSYNOdNzraV/3x4hTES/rmpx8Beh4AOP6wCHoTViz8BVcHg7uEk7O/dYATgwrhljH2UdgNiVXo0I27+W5KVT9K9gN4LbqC2r5DpTeWSqReqjS9sdFCuY26XL6pv9ZNuSg2860wHlq2bs9HceGJ04EZrEdrXWrg5rDJb7ZwBlXtZEWpeOzUA85kFyfs2D3xIKgRMBrRgT8BM8jMZq/kLQdaetUWRRFwpWZ6qW/LoPpaP49Fdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rnQdx5n07Pkzk6JYlW+jnbzE4IShmUoMr2fjX6dhXzY=;
 b=J23yWzm5IKE9z9XjQStEPKQgIaGrMu6Fr9K1sai6r/6t8/3Z4B662WZpAEMdAWu0tGhspB4Sl1JDvfei546x3Hb+KjfMDZL4QByf90tH0vhBwFxPd8xveIl5Chnm7uFH0MW9Ir5sqmOb2vEnriTs37PnXJbGU37OihGdfDjwsmQpzeNg8cwrqMGbPBGnTC9smJKbEr9n2yaLZweFqtOysGOzujdnuBeG54LQU27qw9cVu1M7bz8G8iRgO4a+DNOheOFhxqRHDeQaPF2LtJOQsTMDbc6QM28Mts9tOORjiGh3dlebJk2DzEyv86t3TvPTatFseB+wP0rzjog5o54euQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DBAPR04MB7352.eurprd04.prod.outlook.com (2603:10a6:10:1a8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.8; Tue, 23 Sep
 2025 19:45:15 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 19:45:15 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Josua Mayer <josua@solid-run.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 phy 09/16] phy: lynx-28g: configure more equalization params for 1GbE and 10GbE
Date: Tue, 23 Sep 2025 22:44:38 +0300
Message-Id: <20250923194445.454442-10-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250923194445.454442-1-vladimir.oltean@nxp.com>
References: <20250923194445.454442-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P189CA0028.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::33) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DBAPR04MB7352:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a92792d-8526-4393-2648-08ddfad9b72b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uz21OxmVRfP4QGa8UnVXvxJUiZBjee7Iqj32hTzaeA2ODvkpF3iCVXwVOgaw?=
 =?us-ascii?Q?f2SE3x1AMsidArqzsjqFdpEVwKGWBvu9XWRhKW5riBzUE7aTJH26EEYdz2w4?=
 =?us-ascii?Q?a8Xs5VEOww+NnmRAOc9gfP6hPidDig2fjvyX/FYxTfyuUpu++12EjdOJAeSe?=
 =?us-ascii?Q?mBCtd6Tgav2GxdGeT7K+jCfKJaJf1+W2frp8VOZvvyAFsobyjofx+9baduyd?=
 =?us-ascii?Q?BNR0kewPU3ul0E2DBRfJzbW48idK6mRbX9eCxllb0JczMdSUTyoLPcZr6rbX?=
 =?us-ascii?Q?EUFXvdYIflQRAV7IgByd0VJ4RkLNzu1HX98/o8eTwj0JquGpjAyEYhCMOkcX?=
 =?us-ascii?Q?ION6A0KJYScE/gzjCn8BjdwCSdxSveeaYK5RnbNe+3QYGWaHCb+SHBDU9Srs?=
 =?us-ascii?Q?Ak1r0xHczpnXOJyfYHgIbH1JNpxaAaw8PrUyF9Rylp2JY0QDFnwJmr3f+mvy?=
 =?us-ascii?Q?SOvKOBzbvzhYHwvmGxPTmtrtBFnBdilN6PJ5qdVYBBTrtISXnFs/SGcZQ3jm?=
 =?us-ascii?Q?eTFdhBTTLjvtl3L3QBOtOPIC0h8iIHWRITsSWlsf4Gd6EMORaQzJ3GEuUnLP?=
 =?us-ascii?Q?e1QE7+gazKbBgc9SzuxB7i6NMPZ8hHnrnhnEXEwx2S4m5Vh6y2igNrc4NJIv?=
 =?us-ascii?Q?oW4+r45iy7TUyVtwQhDOF+7RRs4hR+EoA3wQCcYVct0QXpykebZhADPdFmGl?=
 =?us-ascii?Q?ugkDTv/i74jYs/QWi+ooeX0Uy9ZhRTMV64pp+peFdtfuuTZVUCkrAebSlzG+?=
 =?us-ascii?Q?YoFOuWM/IhzfvjKL41xt2EY/MCC4yVCpgWQYfkoAKypy2fyIYcgwBBPz/wAy?=
 =?us-ascii?Q?VYEzvMqofwr4W2S2Hx/MaxzJxtE5jSDnOIo94vp4TMDCesF4P+cX9kMoWWs1?=
 =?us-ascii?Q?hI4Yl4Su7rPOKmCdjZ1YOS1UrIwNfYzymWrGwBEzzrvpTtaJbhqWXLvYRpLy?=
 =?us-ascii?Q?ns8scqUFzex5CjiVYE2JNSmnuWiGEBTN6/R73O/JFHoVgXl+CBX0e+y18xSz?=
 =?us-ascii?Q?U3iJF82ZJMckIjiMKYPzBPboFayMbtB/H88Co3vcGP7dxqVxvG6ibpNtU/qy?=
 =?us-ascii?Q?wkxV9kTHZEzpbPDaxAnj/8Ucl3pmSXK5rKyQE2wlAwiUWWTew8aP5wz/Orcw?=
 =?us-ascii?Q?Q/CaBROLH3Q9da3fjZ7BxLJWq43UXgdFLFjAT2ZkxZ+iSNpd36nmvrJi8NTa?=
 =?us-ascii?Q?ZZ9LG8aWZZ/j6R4e7u05XUevCIOqqEVbMwvcRcX+hOITInsxZg130qoQC6kz?=
 =?us-ascii?Q?dXZuYl1GPTIUpxbfk6Wnha2JMZQ11Mr80lmsSzpK9PPAVbqYd0ubU+iLBRmQ?=
 =?us-ascii?Q?+bA/9hUCgr9wOFnPQDl12r3UYVlzmbo5FmeiZl02advUSBfk6VCatljIuWO3?=
 =?us-ascii?Q?ePZ0Bxc11/zIjtdiBwW3Cu3bXXWkx+I6P9O+sHRaWrSCSjBvQ5yffa7IK2ml?=
 =?us-ascii?Q?r2XX2sRb0m07QToWTR4sKDZZkOGcePTZ5HMjsI3LDGwuUIOO3FmKEw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YFVX46ogbb6CtfsSZyqxo2rRokcvhNq6ID3hzQ2WRp6lFoDbaiPYd6AJFliy?=
 =?us-ascii?Q?+Q0VbXxoDC07llv4d4QpIVwJ1FkLakrqf9i4pkQzFqCNbUSTRnls2CcLQSjS?=
 =?us-ascii?Q?1eXYBoXuj66fUlOiwItlgUKFxkuYkLS3Py7iz0leHn2qM291Ra/fqkNs+gFM?=
 =?us-ascii?Q?Gj97cWqx5YunvLiPA0JN69dvgV5Dz+nSZq+uUhYADLWF1OMMemUIQkCaNm1N?=
 =?us-ascii?Q?Rp3MvRyCOTRtnaiPXEcr1Y03mtAtA6ymHU2ne1xCJwXCpxKuCu9nOE2uaOFf?=
 =?us-ascii?Q?Lz0wRTlOLZVkXTBAmzwyP1q6i7zfCKqoZtb3UPLaLTE+8nm0HxQa6iROldM1?=
 =?us-ascii?Q?rSJr9bTIA85eitU3Sa9tP5p+5Rn4EoOqzJ0FvArjClIiFEHyfl5g4yYi8Srf?=
 =?us-ascii?Q?BcXM/6IQCorw01sIUx6npWYtYIPaJquESdK+okV9UAl6w/GzlV6fIbfd/rI3?=
 =?us-ascii?Q?Md+8cwM/KmyaHN846IWiewdoDPOkE4zA/Q5OgoEJI1XlXR7n13kufVbiC6Kj?=
 =?us-ascii?Q?hMn4lQXOL1CLZsKZnOndFrPGHEy5fnyGEoj0q45x/bvIfRP1NQwDef2yj9vs?=
 =?us-ascii?Q?0U46uWxFrFgnD+aRc+Hv8YYKnmOLCxeEC2OgUtMwZA71XF54e8xmRGz7ys4l?=
 =?us-ascii?Q?YmB75U4C/ZvPFe1In/c4n3AQ6HZdJV4wzl5JDi3SzsKjvTbWsCA7V7U3rcQN?=
 =?us-ascii?Q?6BVldZv9BpVpmo191RUfnoeoAfxc3uIo3j2119XzxyqupP2btQpxZ73AEnLH?=
 =?us-ascii?Q?+n5Ol9SXQld17FQP0zCK5vljk4GT7gW2eQBi7uWsfC143N5CSsuFFHlBRCvZ?=
 =?us-ascii?Q?x2xC/ekBnqmkznjSBe1wdBGQJWuHMgy/Y/IXQ+Sf8P+1DpmJWYyIKGWmfA4C?=
 =?us-ascii?Q?sdFxzukdDK9vPihJ5wSnCXSOHWUtdNud1ea09Le48En2NTCG3JtGCaa+HreQ?=
 =?us-ascii?Q?hsCGWQeNo7nsvySuFUfES4NZgsPFlvitmP1XLgANNqGrTDG4bjsNhaAHZMmA?=
 =?us-ascii?Q?8WTyTf2zyVYAQxs07s8rtsQgRuvAzwnxlFwn4Nb9/ILDe/bOyIotHDXA7cV6?=
 =?us-ascii?Q?G2Sy2w4w4MBjRYAcNSzQuDUyje+q3NanpPxCmjIvNWSN4QFzFq3ggBBiaEmW?=
 =?us-ascii?Q?TL0mTKjn0guPgCQ+2drfijl9U6Hd4eHIKs0waTRvPDZyqOlOZeCo0qCnRJ8Q?=
 =?us-ascii?Q?/7dywXV7fo5dsIiODpWopTAAlXzu1YoBlz34ro4eaHFg/aeqbOO7OktM5OOp?=
 =?us-ascii?Q?snAGP09Zx2hpN+rwQh/uvYLOgtX1V+G8lyfcnJGs83s+IDT5Qlgi8pgDh0NX?=
 =?us-ascii?Q?URkVa8ZD+D5UfSlZC0pXbb+EcGsFCdSkbsxbolEJWmkFsFaxTTGTFpvZuGdf?=
 =?us-ascii?Q?YBZ5Vnnl/QkGyMunYScUWbbPMkn0A6TB7IJ49NBReavp4zNhJ+Nra42OgaJM?=
 =?us-ascii?Q?jVczlVfynwG2ELjwqwoOeXTj5aoisBBOE86Ioa7D37OHb23DoyUsTQ+BmxAh?=
 =?us-ascii?Q?2pURYyZKgB/WiSU/7ryC+Zw3vZwG42Az8iH5BOC7+gCpPEm5n+Qg+OIKaxnB?=
 =?us-ascii?Q?fYJsRbg9K8z5vzCGUzM7lPFI8GcllvudsUJJTBMGmbyWjA+1SxpRBm+gxPBE?=
 =?us-ascii?Q?Ow=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a92792d-8526-4393-2648-08ddfad9b72b
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 19:45:14.5835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Tmg62kf/eOogKgWPe2lFuaMy8BlPq6tblvNgUwOeYmOWP2RoH2irAFhRAfZ9RVCdnAHowcwVPmOkairtE5+cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7352

From: Ioana Ciornei <ioana.ciornei@nxp.com>

While adding support for 25GbE, it was noticed that the RCCR0 and TTLCR0
registers have different values for this protocol than the 10GbE and
1GbE modes.

Expand the lynx_28g_proto_conf[] array with the expected values for the
currently supported protocols. These were dumped from a live system, and
are the out-of-reset values. It will ensure that the lane is configured
with these values when transitioning from 25GbE back into one of these
modes.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2: none

 drivers/phy/freescale/phy-fsl-lynx-28g.c | 37 ++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/phy/freescale/phy-fsl-lynx-28g.c b/drivers/phy/freescale/phy-fsl-lynx-28g.c
index d27a46cdd86b..1c126276394c 100644
--- a/drivers/phy/freescale/phy-fsl-lynx-28g.c
+++ b/drivers/phy/freescale/phy-fsl-lynx-28g.c
@@ -166,6 +166,18 @@
 #define LNaRECR4_EQ_BIN_DATA			GENMASK(8, 0) /* bit 9 is reserved */
 #define LNaRECR4_EQ_BIN_DATA_SGN		BIT(8)
 
+#define LNaRCCR0(lane)				(0x800 + (lane) * 0x100 + 0x68)
+#define LNaRCCR0_CAL_EN				BIT(31)
+#define LNaRCCR0_MEAS_EN			BIT(30)
+#define LNaRCCR0_CAL_BIN_SEL			BIT(28)
+#define LNaRCCR0_CAL_DC3_DIS			BIT(27)
+#define LNaRCCR0_CAL_DC2_DIS			BIT(26)
+#define LNaRCCR0_CAL_DC1_DIS			BIT(25)
+#define LNaRCCR0_CAL_DC0_DIS			BIT(24)
+#define LNaRCCR0_CAL_AC3_OV_EN			BIT(15)
+#define LNaRCCR0_CAL_AC3_OV			GENMASK(11, 8)
+#define LNaRCCR0_CAL_AC2_OV_EN			BIT(7)
+
 #define LNaRSCCR0(lane)				(0x800 + (lane) * 0x100 + 0x74)
 #define LNaRSCCR0_SMP_OFF_EN			BIT(31)
 #define LNaRSCCR0_SMP_OFF_OV_EN			BIT(30)
@@ -180,6 +192,15 @@
 #define LNaRSCCR0_SMP_AUTOZ_EG1R		GENMASK(5, 4)
 #define LNaRSCCR0_SMP_AUTOZ_EG1F		GENMASK(1, 0)
 
+#define LNaTTLCR0(lane)				(0x800 + (lane) * 0x100 + 0x80)
+#define LNaTTLCR0_TTL_FLT_SEL			GENMASK(29, 24)
+#define LNaTTLCR0_TTL_SLO_PM_BYP		BIT(22)
+#define LNaTTLCR0_STALL_DET_DIS			BIT(21)
+#define LNaTTLCR0_INACT_MON_DIS			BIT(20)
+#define LNaTTLCR0_CDR_OV			GENMASK(18, 16)
+#define LNaTTLCR0_DATA_IN_SSC			BIT(15)
+#define LNaTTLCR0_CDR_MIN_SMP_ON		GENMASK(1, 0)
+
 #define LNaTCSR0(lane)				(0x800 + (lane) * 0x100 + 0xa0)
 #define LNaTCSR0_SD_STAT_OBS_EN			BIT(31)
 #define LNaTCSR0_SD_LPBK_SEL			GENMASK(29, 28)
@@ -286,6 +307,10 @@ struct lynx_28g_proto_conf {
 	/* LNaRSCCR0 */
 	int smp_autoz_d1r;
 	int smp_autoz_eg1r;
+	/* LNaRCCR0 */
+	int rccr0;
+	/* LNaTTLCR0 */
+	int ttlcr0;
 };
 
 static const struct lynx_28g_proto_conf lynx_28g_proto_conf[LANE_MODE_MAX] = {
@@ -316,6 +341,9 @@ static const struct lynx_28g_proto_conf lynx_28g_proto_conf[LANE_MODE_MAX] = {
 		.spare_in = 0,
 		.smp_autoz_d1r = 0,
 		.smp_autoz_eg1r = 0,
+		.rccr0 = LNaRCCR0_CAL_EN,
+		.ttlcr0 = LNaTTLCR0_TTL_SLO_PM_BYP |
+			  LNaTTLCR0_DATA_IN_SSC,
 	},
 	[LANE_MODE_USXGMII] = {
 		.proto_sel = LNaGCR0_PROTO_SEL_XFI,
@@ -344,6 +372,9 @@ static const struct lynx_28g_proto_conf lynx_28g_proto_conf[LANE_MODE_MAX] = {
 		.spare_in = 0,
 		.smp_autoz_d1r = 2,
 		.smp_autoz_eg1r = 0,
+		.rccr0 = LNaRCCR0_CAL_EN,
+		.ttlcr0 = LNaTTLCR0_TTL_SLO_PM_BYP |
+			  LNaTTLCR0_DATA_IN_SSC,
 	},
 	[LANE_MODE_10GBASER] = {
 		.proto_sel = LNaGCR0_PROTO_SEL_XFI,
@@ -372,6 +403,9 @@ static const struct lynx_28g_proto_conf lynx_28g_proto_conf[LANE_MODE_MAX] = {
 		.spare_in = 0,
 		.smp_autoz_d1r = 2,
 		.smp_autoz_eg1r = 0,
+		.rccr0 = LNaRCCR0_CAL_EN,
+		.ttlcr0 = LNaTTLCR0_TTL_SLO_PM_BYP |
+			  LNaTTLCR0_DATA_IN_SSC,
 	},
 };
 
@@ -829,6 +863,9 @@ static void lynx_28g_lane_change_proto_conf(struct lynx_28g_lane *lane,
 			  FIELD_PREP(LNaRSCCR0_SMP_AUTOZ_EG1R, conf->smp_autoz_eg1r),
 			  LNaRSCCR0_SMP_AUTOZ_D1R |
 			  LNaRSCCR0_SMP_AUTOZ_EG1R);
+
+	lynx_28g_lane_write(lane, LNaRCCR0, conf->rccr0);
+	lynx_28g_lane_write(lane, LNaTTLCR0, conf->ttlcr0);
 }
 
 static int lynx_28g_lane_disable_pcvt(struct lynx_28g_lane *lane,
-- 
2.34.1


