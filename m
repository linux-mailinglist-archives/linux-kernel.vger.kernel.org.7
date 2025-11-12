Return-Path: <linux-kernel+bounces-897152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 610FFC52261
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63D1A18949FF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76DB3191A0;
	Wed, 12 Nov 2025 11:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Mtj9IqT1"
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011067.outbound.protection.outlook.com [52.101.52.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99247314D3F;
	Wed, 12 Nov 2025 11:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762948567; cv=fail; b=Cgq1IgkIdzgWlgQK58oSk5b70bDrQaOeyqvuHXd+vkeFKJSlv2b2X6gatZIphcs3/td++L9hitUoTyh73cHhAKH+pmsmhfjvg5h7HstkZLk7pfH6jcBjJLlarsh1kArzI5IAfiFugsR8yWJOSCCGNhQYnV28fqk0BW4B+nh6dLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762948567; c=relaxed/simple;
	bh=GaMayB9Q7P+eWjE7u0Jets/oRFIfDP+5W4Lm7CD3Icc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u1kZyjrY6gR6laODs3G1rIANrrS1kS2+JZaJJvZG2ml0/7Gu7aoW6jEiBuV8+egUYErMhQ0RPI6dCwFA1pEUvj8jwMU4fmJ5PKYzT8q8X683NteRZxsMYvRagrvmXXDKFapsrDfIAmV57pXBHN+q+SXNUHX9fxx4LC8oOW942WM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Mtj9IqT1; arc=fail smtp.client-ip=52.101.52.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YgDvsvObaHAPtQgCEF68LhpZZmUJORGnrAh/h7pB+hiV61xm+ZyMv2DN0kleS3LHjfKBAMgzqFKcDMPUMP5BkpH6K8YlryFt68ZJgQrgC01nSmPGidRM3hh3GXeI2lYmU/KBpiIkPwTBRNbpDgytmXePSPxVPt2eNtmT6O7Nb6793W1wFaONGXF24uvGnLmFC+YhGOXBz2pzYZiz9J20twNpxUVTXvK8dJmXRQl9+P+E8v1l3butfWmjRuPGJIBNfyuUkxENA6VXmGjBx3pszoFm9NoIiC+k1hQzhxp50ePfN6zilLjBK4vN3bcXoBT6GZSINBlaF+bG166T3i+TKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/1b7A9lgPdoFojmvPnEeM2DqW5VVrnLGRw4SBzF5ks4=;
 b=U+7/4dm/qCxoXGpkrS95+Z0wa8B6m2ZlVzSsDY7lfQnrn1XD2uMXDFUYJw7rZxH37dCD9kD+2DKDtxLXpTZB2AFJV0jkBUMuD996ScKrTR0resd+QvzYaahEohyhM8838xtqUm9jSYPkso+oK0dqDfiH7/kAJQ5jvPnuo85SzW8Nrr3frx+yVS5WfvlSADBxs9zDDfoLLJZl8w93GGou34jAiC2z7h0RUJKc9BV3bBoQWJxs0BOlXBgfUPK7KMz6TDnM96a0sF8ppskavorneLxTvdfpksvV7cnusaLUeDw8hAHcaRkcJfAWkrHP1vzYlxqbmsLN89HtOFdq0tMlsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/1b7A9lgPdoFojmvPnEeM2DqW5VVrnLGRw4SBzF5ks4=;
 b=Mtj9IqT1lPWP6EiQaylKvD1PDIYC4mIf+xufg+xmbFMqPdDCoTwfJZCauGrn+y8eF8fHiVbBIUp2rRbXVPNYrssz+iBOLv9TB6QN1xk4aP0f/tsDtAdGOjuRsjcaN/64u4f8tw81xl02jLAg6MdsNF8cx7Rbo3OOSTsAqfJce20=
Received: from BYAPR06CA0002.namprd06.prod.outlook.com (2603:10b6:a03:d4::15)
 by DM3PPFA35BF3976.namprd10.prod.outlook.com (2603:10b6:f:fc00::c3c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 11:56:02 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:a03:d4:cafe::53) by BYAPR06CA0002.outlook.office365.com
 (2603:10b6:a03:d4::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Wed,
 12 Nov 2025 11:56:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 11:56:00 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 05:55:53 -0600
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 05:55:53 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 12 Nov 2025 05:55:53 -0600
Received: from ws.dhcp.ti.com (ws.dhcp.ti.com [172.24.233.149])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5ACBsxbv2638977;
	Wed, 12 Nov 2025 05:55:47 -0600
From: Rishikesh Donadkar <r-donadkar@ti.com>
To: <jai.luthra@linux.dev>, <laurent.pinchart@ideasonboard.com>,
	<mripard@kernel.org>
CC: <r-donadkar@ti.com>, <y-abhilashchandra@ti.com>, <devarsht@ti.com>,
	<s-jain1@ti.com>, <vigneshr@ti.com>, <mchehab@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <p.zabel@pengutronix.de>, <conor+dt@kernel.org>,
	<sakari.ailus@linux.intel.com>, <hverkuil-cisco@xs4all.nl>,
	<tomi.valkeinen@ideasonboard.com>, <jai.luthra@ideasonboard.com>,
	<changhuang.liang@starfivetech.com>, <jack.zhu@starfivetech.com>,
	<sjoerd@collabora.com>, <dan.carpenter@linaro.org>,
	<hverkuil+cisco@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v8 07/18] media: cadence: csi2rx: Move to .enable/disable_streams API
Date: Wed, 12 Nov 2025 17:24:48 +0530
Message-ID: <20251112115459.2479225-8-r-donadkar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251112115459.2479225-1-r-donadkar@ti.com>
References: <20251112115459.2479225-1-r-donadkar@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|DM3PPFA35BF3976:EE_
X-MS-Office365-Filtering-Correlation-Id: 95a6aa94-32a0-4421-4dd2-08de21e27293
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fmG0IFdHsRGNzElosIlZYyrhJ8iz+z49Hv1SyMSs/vBhTc3pkjSOhk6I8WFa?=
 =?us-ascii?Q?NZwvz6cVQlVMIWcDqjk7l34G5ExiEoAnPb9nB1NK0BMsc32L7KZwFcChQ9/I?=
 =?us-ascii?Q?bmCzn9SW7zB8Gty3W5ZKqWpgE1kzgW7kuNNl6G31vHswDWD4TTP/HnZyG27S?=
 =?us-ascii?Q?IjRuwHfWyL3kE0D9ynplHxrAm8pXsBQTQeHPhU/rWzPm4HDcFiXRgYrGpmfs?=
 =?us-ascii?Q?/1F12AiNKY2rqSwOQjwrzhkiTgSHPmLbrczKkaNffVHE5SyxXYRcJdzF1Yfm?=
 =?us-ascii?Q?vnQ+kGbCoV9Ock7LF0UHitmb0tlliTBXNQ2CIPNx2ac9qEFzhr2E9cY2Kebu?=
 =?us-ascii?Q?SJFfcPPruzRnc+GOhGV7i8VLzBv14zD78hxOfRh10WH98S0764N2iu20QwCC?=
 =?us-ascii?Q?u3SwnSAqgD0zlbBZDwX9oJFRLCAgHRKdoJeNOU+vE4AZfwlfsX/n6bYhAdE+?=
 =?us-ascii?Q?Bd0oDzG3Z2zJKpG21iKMTexP2BSXhDsLqei8b5eVe2bX4ZTOSUgvlMsBQzfb?=
 =?us-ascii?Q?mvO1FZXzYNC0Zmy7nbwEgSPgDjumglHDDrIW5KlWyuYuxCVvaBg7chNGBa4m?=
 =?us-ascii?Q?xWYEYYyfyXFUvsrzDsAnvb7HOXtdk9JRdJj5QBIMSPQFB9sIDcUqCSz1NR0C?=
 =?us-ascii?Q?ew1r4O0Hks09/86p/DexEeneQxA+STv/MfHjC7i/B+uw5jz6Od0UipfpcUW0?=
 =?us-ascii?Q?VFTCHiIRYQsHUOkejkMksZZztk2pr0CZvLWXoKkxNFJlg3NJjqLoNLTjT+xB?=
 =?us-ascii?Q?5o0eizJa+S13+APNbV/4ZVwMsErtNOFPiQh7nsNpe95CB5SyNiqliHXZJLJo?=
 =?us-ascii?Q?uO2d5LVT2lG0RRR2p/cESgs0tvjqUc92ccImozb1WFzaWNcnOTdcMTRfItrE?=
 =?us-ascii?Q?sEM5HaSguwmZfRyO+ueiizVv9Ks2h1ol5M+/pJYaTq7ghYs1cDr5jfC7c+LJ?=
 =?us-ascii?Q?0rfJCVte6fTWD5Eq5XyTKgJ2uMXq2LQcg2+mssjCEvw+hRe6rkb1rW38IDWZ?=
 =?us-ascii?Q?YXVpj9hyCiAGhmtF6W0rF0Of+vcys2e+RIb2lSeeWdFpCSj53nrkTVYVg4Gr?=
 =?us-ascii?Q?bnBbvsl2VEqmx0ubjWqa0AMtsNn4JQnO8G+Wk1m/xprBNH4MF9+7aoGEjgE1?=
 =?us-ascii?Q?STO5qdBZGQFY6yaaxCBipxXyWp1fDxMl6hnzL7FS2Vq7ehKzfYuQHdWt0qwz?=
 =?us-ascii?Q?7y4ososm9cf3+sMf95oDGJ3OsPRPbSBmhwkA+Z8dJk9m1sDjwqp3C2cg41Fe?=
 =?us-ascii?Q?g+jU2GVL7lqb2uAoIg2g+0spzMxdQEfmMDti/h52tzesy+rm6lueiNAKUN0i?=
 =?us-ascii?Q?RThjBo7PIT7mKSWhjlR40bjrXIeaSTJ3u1lXibCRGrHUCfx8ZDAYZfO9KzFP?=
 =?us-ascii?Q?4cIA8xxoMx91U6JaehjzHfORjvnpzVDbyLg81O1qEfmg0SJ5HNOGrRdnQNLx?=
 =?us-ascii?Q?ASKhDj6KGNekaFPoDqxB+JtHoYK2DHvF93J3nN3E1PnSTnCne4gUI+2VISsw?=
 =?us-ascii?Q?RalxSryYCw/hAwwHefOqJl+lmW9cogUVmei1UT5gUuXmc42O2Igzux1PnNlP?=
 =?us-ascii?Q?3MBLOcVp6K9vZrrOUPQ=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 11:56:00.0387
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95a6aa94-32a0-4421-4dd2-08de21e27293
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFA35BF3976

The enable_streams() API in v4l2 supports passing a bitmask to enable
each pad/stream combination individually on any media subdev. Use this
API instead of  s_stream() API.

Implement the enable_stream and disable_stream hooks in place of the
stream-unaware s_stream hook.

Remove the lock that was used to serialize stream starts/stops which
is not required anymore since the v4l2-core serializes the
enable/disable_streams() calls for the subdev.

Signed-off-by: Rishikesh Donadkar <r-donadkar@ti.com>
---
 drivers/media/platform/cadence/cdns-csi2rx.c | 108 +++++++++----------
 1 file changed, 54 insertions(+), 54 deletions(-)

diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
index 8c19f125da3e5..34da81893308b 100644
--- a/drivers/media/platform/cadence/cdns-csi2rx.c
+++ b/drivers/media/platform/cadence/cdns-csi2rx.c
@@ -125,12 +125,6 @@ struct csi2rx_priv {
 	unsigned int			count;
 	int				error_irq;
 
-	/*
-	 * Used to prevent race conditions between multiple,
-	 * concurrent calls to start and stop.
-	 */
-	struct mutex			lock;
-
 	void __iomem			*base;
 	struct clk			*sys_clk;
 	struct clk			*p_clk;
@@ -268,20 +262,21 @@ static int csi2rx_configure_ext_dphy(struct csi2rx_priv *csi2rx)
 		&csi2rx->source_subdev->entity.pads[csi2rx->source_pad];
 	union phy_configure_opts opts = { };
 	struct phy_configure_opts_mipi_dphy *cfg = &opts.mipi_dphy;
-	struct v4l2_subdev_format sd_fmt = {
-		.which	= V4L2_SUBDEV_FORMAT_ACTIVE,
-		.pad	= CSI2RX_PAD_SINK,
-	};
+	struct v4l2_subdev_state *state;
+	struct v4l2_mbus_framefmt *framefmt;
 	const struct csi2rx_fmt *fmt;
 	s64 link_freq;
 	int ret;
 
-	ret = v4l2_subdev_call_state_active(&csi2rx->subdev, pad, get_fmt,
-					    &sd_fmt);
-	if (ret < 0)
-		return ret;
+	state = v4l2_subdev_get_locked_active_state(&csi2rx->subdev);
 
-	fmt = csi2rx_get_fmt_by_code(sd_fmt.format.code);
+	framefmt = v4l2_subdev_state_get_format(state, CSI2RX_PAD_SINK, 0);
+	if (!framefmt) {
+		dev_err(csi2rx->dev, "Did not find active sink format\n");
+		return -EINVAL;
+	}
+
+	fmt = csi2rx_get_fmt_by_code(framefmt->code);
 
 	link_freq = v4l2_get_link_freq(src_pad,
 				       fmt->bpp, 2 * csi2rx->num_lanes);
@@ -401,16 +396,10 @@ static int csi2rx_start(struct csi2rx_priv *csi2rx)
 
 	reset_control_deassert(csi2rx->sys_rst);
 
-	ret = v4l2_subdev_call(csi2rx->source_subdev, video, s_stream, true);
-	if (ret)
-		goto err_disable_sysclk;
-
 	clk_disable_unprepare(csi2rx->p_clk);
 
 	return 0;
 
-err_disable_sysclk:
-	clk_disable_unprepare(csi2rx->sys_clk);
 err_disable_pixclk:
 	for (; i > 0; i--) {
 		reset_control_assert(csi2rx->pixel_rst[i - 1]);
@@ -459,9 +448,6 @@ static void csi2rx_stop(struct csi2rx_priv *csi2rx)
 	reset_control_assert(csi2rx->p_rst);
 	clk_disable_unprepare(csi2rx->p_clk);
 
-	if (v4l2_subdev_call(csi2rx->source_subdev, video, s_stream, false))
-		dev_warn(csi2rx->dev, "Couldn't disable our subdev\n");
-
 	if (csi2rx->dphy) {
 		writel(0, csi2rx->base + CSI2RX_DPHY_LANE_CTRL_REG);
 
@@ -485,38 +471,56 @@ static int csi2rx_log_status(struct v4l2_subdev *sd)
 	return 0;
 }
 
-static int csi2rx_s_stream(struct v4l2_subdev *subdev, int enable)
+static int csi2rx_enable_streams(struct v4l2_subdev *subdev,
+				 struct v4l2_subdev_state *state, u32 pad,
+				 u64 streams_mask)
 {
 	struct csi2rx_priv *csi2rx = v4l2_subdev_to_csi2rx(subdev);
-	int ret = 0;
-
-	mutex_lock(&csi2rx->lock);
-
-	if (enable) {
-		/*
-		 * If we're not the first users, there's no need to
-		 * enable the whole controller.
-		 */
-		if (!csi2rx->count) {
-			ret = csi2rx_start(csi2rx);
-			if (ret)
-				goto out;
-		}
+	int ret;
 
-		csi2rx->count++;
-	} else {
-		csi2rx->count--;
+	/*
+	 * If we're not the first users, there's no need to
+	 * enable the whole controller.
+	 */
+	if (!csi2rx->count) {
+		ret = csi2rx_start(csi2rx);
+		if (ret)
+			return ret;
+	}
 
-		/*
-		 * Let the last user turn off the lights.
-		 */
+	/* Start streaming on the source */
+	ret = v4l2_subdev_enable_streams(csi2rx->source_subdev, csi2rx->source_pad,
+					 BIT(0));
+	if (ret) {
+		dev_err(csi2rx->dev,
+			"Failed to start streams %d on subdev\n", 0);
 		if (!csi2rx->count)
 			csi2rx_stop(csi2rx);
+		return ret;
 	}
 
-out:
-	mutex_unlock(&csi2rx->lock);
-	return ret;
+	csi2rx->count++;
+	return 0;
+}
+
+static int csi2rx_disable_streams(struct v4l2_subdev *subdev,
+				  struct v4l2_subdev_state *state, u32 pad,
+				  u64 streams_mask)
+{
+	struct csi2rx_priv *csi2rx = v4l2_subdev_to_csi2rx(subdev);
+
+	if (v4l2_subdev_disable_streams(csi2rx->source_subdev,
+					csi2rx->source_pad, BIT(0))) {
+		dev_err(csi2rx->dev, "Couldn't disable our subdev\n");
+	}
+
+	csi2rx->count--;
+
+	/* Let the last user turn off the lights. */
+	if (!csi2rx->count)
+		csi2rx_stop(csi2rx);
+
+	return 0;
 }
 
 static int csi2rx_enum_mbus_code(struct v4l2_subdev *subdev,
@@ -611,10 +615,8 @@ static const struct v4l2_subdev_pad_ops csi2rx_pad_ops = {
 	.enum_mbus_code	= csi2rx_enum_mbus_code,
 	.get_fmt	= v4l2_subdev_get_fmt,
 	.set_fmt	= csi2rx_set_fmt,
-};
-
-static const struct v4l2_subdev_video_ops csi2rx_video_ops = {
-	.s_stream	= csi2rx_s_stream,
+	.enable_streams         = csi2rx_enable_streams,
+	.disable_streams        = csi2rx_disable_streams,
 };
 
 static const struct v4l2_subdev_core_ops csi2rx_core_ops = {
@@ -623,7 +625,6 @@ static const struct v4l2_subdev_core_ops csi2rx_core_ops = {
 
 static const struct v4l2_subdev_ops csi2rx_subdev_ops = {
 	.core		= &csi2rx_core_ops,
-	.video		= &csi2rx_video_ops,
 	.pad		= &csi2rx_pad_ops,
 };
 
@@ -829,7 +830,6 @@ static int csi2rx_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	platform_set_drvdata(pdev, csi2rx);
 	csi2rx->dev = &pdev->dev;
-	mutex_init(&csi2rx->lock);
 
 	ret = csi2rx_get_resources(csi2rx, pdev);
 	if (ret)
-- 
2.34.1


