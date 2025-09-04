Return-Path: <linux-kernel+bounces-801177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3E7B440E2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B939486383
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493CC28314E;
	Thu,  4 Sep 2025 15:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="foolRdgx"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010029.outbound.protection.outlook.com [52.101.69.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23A62D8376
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 15:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757000667; cv=fail; b=dT+x/SSHNGAR/QQ2ZCM6/82tFZI1PJ+T1FO9U9d8P4BLWMzSI9L1JVJ5yjjU9cbQ7DcwqUIZbR2yhJedeouLe8zkrohEAXtcs+9RIpcl97plKQObR74xDaYSi6HUENt89R3vWlXlfX+O2d2hbmwL8+9O5PgPd5srPCDGkCuAzTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757000667; c=relaxed/simple;
	bh=5/YFjjG/hT9unLfrFDa8PJmwoYRXXCtthSGTUvZvLlg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KmzMDPkIzNe6n5rqzlgJW7aRoiR5QIROwMozJhsipUZOn9pCBYSZnrE4zSdq6pwyo5x1bxEAn63R5tRSpl1ZlN7k1IXWloTwjVcyYUr18ol0pSB6vlSAR+EdKaQux3l7dB4CJ3YzWtJvHimbiGyDpAk083Vy70xno0jRWDnyBY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=foolRdgx; arc=fail smtp.client-ip=52.101.69.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wj2UgV4pcY68Owc5fRcBoX/148oEGxiB9sAbUKFbw2I78ZykqBHdo9+G/PBAaMWiJLh2eSxfxSw+9Ew5wc3cWLKhEpWZb1KV4jX4y2tyY3QUeuCyA6ZTlbeNryX8DZ+PEoXB4t2hMfSJi9XBb9vPScezByWqEx4e9HwHAwK44Tq/XpmLIJJDtgiJcEuUUsQhCCwhMkaFcTVGrrD79hAUCx1r0EIgWciuRQff2sXljGaZb9bSZw5vBstDQP2IqSPFuqvrTBAozQkTY/i5duquUvpGoPR2XAES2dCx/Kv10lCt9l/ML7klmkjFq+gHMg/JAfkYll2qK+2X9XICdcyG1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mG1/QsVBBnBaC2QSAl0e9zdUCzedoYY6sAynMn4Su+k=;
 b=fc0jAYAx15zkNtl+FlE9njlvIb1bfh9XWog4aPwqV1DwBfWrDBJGtSPMNhI1PmljQ2f/dSvT/RkVW2pPit5MUAV+S8HS64yNU01DjECQx+AshMRASseu+BvMH7gWYdgvf2fHsNoAJ2AxIHuSGvyBvpAV9JExIBd5Is2xhBAqOOit65OSwHcD4ncn9tIeabDD+wUgKTsqM/ktdt0eN+u5gu65YgfYmpjovPuDT4SOz8PvBPbNqPrv4hlvP7bMk0PxEp+kMpx8F4l1mIeHGhFrk5bOz+wmSVvnv7ByDcgHMLm/dV0IwiEuWXd1zKX4QEG90kTuu06/FmA6Nu391yx+wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mG1/QsVBBnBaC2QSAl0e9zdUCzedoYY6sAynMn4Su+k=;
 b=foolRdgxFkeX0enb3t7EATwM3rpg5pdg3zo54jxPvTcE/sKB4vDdO2PlSoXCBDGCJybI8Slunmfl2wTAvXdP+C9s6hWhdCRoVVummR4T96BvMO/sWTSlkIgmvUquo/fRjNienI9Ej9b6/S51HsXGnTdISJ8OyKXmSLK6b1Ez5Nzm6O6aRaIfPtIz5+HD2n7nDRDur1tXix2F2nXPdIMkWJuZRC7V2mt9gBINggAXkh/rRh9DOh9+F1zUdmOWhoreIEHtTSMQitDoE5ryUQVZLPpdOLLYxtXnyPbvylqNOv7tM3PJtPKvfgcmRN+uZFgehqms3wm8I4x5bRFMUuQeMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AM9PR04MB7635.eurprd04.prod.outlook.com (2603:10a6:20b:285::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Thu, 4 Sep
 2025 15:44:19 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 15:44:19 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH phy 08/14] phy: lynx-28g: distinguish between 10GBASE-R and USXGMII
Date: Thu,  4 Sep 2025 18:43:56 +0300
Message-Id: <20250904154402.300032-9-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 79d25347-e9d4-43fb-7a82-08ddebc9e7e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|19092799006|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EuS2NmkuXf+pwxEP+5pGMB7h05jrJq1Xi9Dt3uVrvIa1vh8/wZudRnVdc2Tm?=
 =?us-ascii?Q?jSPCAnHqp75gkEJXEdjjpBcMg7Fqo5RWDxULLobKfkI369WsjvYoBZHRqeAW?=
 =?us-ascii?Q?7PpDlM5hL1LgrXnIVJr5k5ZwZRAyWWRSAze159HxAz14T5PH6j6R/epIk9tm?=
 =?us-ascii?Q?ta9UfeMmtYAq172Y7Y+6cvZH8QO1aUxaxhPObqBhyLm4Aa87DyZCiNSflmrB?=
 =?us-ascii?Q?lDQ/eoyS2aJqe6wuYlj2eTjJ/SZ4zw2GQtka8tRZ6OEr4knlcB/LYXTnz8PP?=
 =?us-ascii?Q?LbKhj8Fz/EXpDWdWcsgulRrIlbSxEblHaPm2eQwT4iaMcdtxUXtXZZiP/piX?=
 =?us-ascii?Q?3BD9Jb4c69XAH2LnUM5peaAqifB+gjDZt/Osk+QB2+YE0MOGgZVFSa3EFvN0?=
 =?us-ascii?Q?wOhHB75bnZ0eSjjZte3F/kVW7JDCAXjSouRxoMlY3vu4Ul2Ky6AiY8zT59AC?=
 =?us-ascii?Q?Lil2eJ04Q8PC355vjniSfoXjtxfZMafFaHfpdZ7VAH1AeRLCKd/BaHJ6xfuo?=
 =?us-ascii?Q?ism3GCvALpmruLRUxeAKG2dKytQ/8V0IpngS2M5qQqqxGOJgiS48jfUiciYv?=
 =?us-ascii?Q?Vhxulq0diH7UFtlybewnMz3vRc9NsAmCU8AFAYkscMhjgaMCU7iu9u2LCxPb?=
 =?us-ascii?Q?lVRWUX/zICWCNatZEiwkcIkZuq2l9bDxMo7N3Tg9U48pPSMa4uUYz4VlhDEH?=
 =?us-ascii?Q?swDm+Ku3hCTELjKylvOuisWMG6pwkZSGCngxRBAteiaW+PlvYUlKLz02W3Jn?=
 =?us-ascii?Q?uu4La8P0HC0QzDpBpYG6RLvxKe9xmzsgIbDFIR2VJtnC/JRZW9rLRFvAr/xB?=
 =?us-ascii?Q?tdS2WWgxnZIigF/B4L6bs1OWvsyp/XElxJn+ZAqjn1FqtWinO2nR3OYzQziO?=
 =?us-ascii?Q?D6HbHZgqCuK39an7r17ZjBQrGEB4MyJsj9McH6qsBUde+RzycZMG22N3J0P4?=
 =?us-ascii?Q?Rs8QNc+0zI1nEB9cyU6GaNm8EpbGtTnYWs8QkSIAajRRPAQZS8pfbXtObQsr?=
 =?us-ascii?Q?SVmfIsw3/7z5Yy/bAv+hkAAf8U4a0LBY2SnoJ43TZDD54yP/xZBwgPNAEj9Z?=
 =?us-ascii?Q?89//ZOgkXqQBKAxQdEo6OFv/k3NzH5pHoMOkL0+XnATjG6W9nBoDpDRUXTWB?=
 =?us-ascii?Q?3wdpqSp7mPkUB0urFLPk/u6iqanZAJUwCn5jVBbxwr4f4zgeOTSAqiI0eU1G?=
 =?us-ascii?Q?2M/ROWvVYtAViutw/jGDjncNurIWeWa2QjGU7gR7WmRAG4BVabGzrM44kE/D?=
 =?us-ascii?Q?ifLKppCp1oFtR19mProL1bMK7B3TZsd804Nce+M5cvPmdJgzHrcJw2rycC2i?=
 =?us-ascii?Q?dES7I0Gfgn2PJ1/KOrGUGhmIqR2caDLyK4u17hsWqrhxQPuNVHIAFbwHMozk?=
 =?us-ascii?Q?mPiTqOyEpv59Hl2ZVs6QNMReC7OVQNM8FTWNvZgjigMPwuNPOTP0iVVboD9q?=
 =?us-ascii?Q?931h7QOf+k2DP35WXfkmPPV4xjOo2NhcYUmI8v/HRxzhqeaU6+GZqQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(19092799006)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aRAl1LwwZUV95/PYYyT5Bi8YI54DOtz58teuqNpMD3Z/3q5UoAF7csgL1d0j?=
 =?us-ascii?Q?9MRzTXDKrnz8ZxAM+VcP4MM7HvxbJXh8I4RP6haO0SxsvlJvOY9VANhiTVdS?=
 =?us-ascii?Q?E24tmECDKO63Fni634LzFlekt+jO8GVq/kBfE8klo4snMZfzQtMGx3cp8fHP?=
 =?us-ascii?Q?Fqd54tXYvB/kJLXB3wdkScMiHT/GcnfYbh6/17WE5qJqFBxvuGSbIS6OTL6j?=
 =?us-ascii?Q?RIJ5bnMu0MQCMQL2toseMUf1x5ICoLl/3mpfIylMgRUVhLRkZfL5eps8feF1?=
 =?us-ascii?Q?/jHcgYYxXmVOGRO3dbaCYFiGsu2y4slusUX9u3DdgtSPO5niLHRAq+aefgUZ?=
 =?us-ascii?Q?lAjEWewXIFjo2aR3lWmfjbnoWEC6bJWmgsXhOJEBjrbEDCg7hZFiYKZTGxnN?=
 =?us-ascii?Q?yv3v5sviFQAocLLYdxJ6ZgMG2DZrOXToHw4+hx9quLMdmrzSaejcxjx8uv+S?=
 =?us-ascii?Q?gwrKUS7HEgzoWWztCu1IdFuqNoiSLlsuEw12Z7m0sRtNk0oBcUpK5eYkgsXZ?=
 =?us-ascii?Q?ES234JD7e/WQxMBl+UIL2Syb6pv99fCqEbBXstSlBMIKgx9YyzJcmcNEruGg?=
 =?us-ascii?Q?Jo35O0IhhGRqwQN2etym9URwY11Dyzrfj1EVwrXpWjs9u70jgXIVrICRBFMN?=
 =?us-ascii?Q?zS6h9xTwJDK2PYeYdu8sxCjPMQ+yiLmGVpftgEmJk+Rs3IinfL++W/aa7OgQ?=
 =?us-ascii?Q?cdSKX9UCrYTpDnszI14OoleqjGoBU6eOVOo/HrJ8BU5GCeWv+SMiMOrCe550?=
 =?us-ascii?Q?AbUOnFVTLCnh357xjpxEIlcYunMWN+7B22f2qOO7yR/7vQFotnr7i2QBHQqq?=
 =?us-ascii?Q?5BbTQkbC/nlKP5gk8IWZUdqQK7ydhLjDqrdaShRnoA6iPFz4CX7W0CZgooAa?=
 =?us-ascii?Q?oRJXfym1t8nN4FpwU++gI88FGEDNbRceLJCKQ7p3sNc5jfLzKH2o2pQUqu5U?=
 =?us-ascii?Q?WsxFZ7o1JHbPlVxViPbFJs0jgUFcckHl1437zep5OURyxvj2xdQUXBGzj6ys?=
 =?us-ascii?Q?k4BMGQifAHX3eShR+wmOZ6JvAvY6cwK1qNnivZb2rSqnK2ss/n9W4FIZBlDv?=
 =?us-ascii?Q?RyiQlIwtcnjpbmmWEkmAg6kxpJ2TqOFIW1jzrKbQx6Zz46GSu6Zuh1iaQg4j?=
 =?us-ascii?Q?F9SOcgiJVsk6oksF8DTZLhF+HfH3iaBd/2oYQF2zXrQMnEkmMqiYgdRDHoun?=
 =?us-ascii?Q?yvx2g31UldQAj0zm17RuYV2wX3zAcwt7klubvZSrzlgErEMQKnrG5nvN+/1F?=
 =?us-ascii?Q?coB0oblrfERCbVLFit3XABwBJ/Twm95TazzOo9Qy7FEOX+9UmrvrRkSvGgv4?=
 =?us-ascii?Q?KrDlGFmGCiizsT+G0GYg++wlY894wfUr+U4CUKrg29QxwvC1sQ+OWbmSWYKe?=
 =?us-ascii?Q?8/KhbNqUS3+C9LOZYxwlBVHvOpdJqnwCDirZmSMNw+WHLxtOevt6tDkDVDJ+?=
 =?us-ascii?Q?hQ5QfzFFEjS99fWz7FOvsD+imjmURdpUZDOqjOssbfTZioxakOHxpO3g90+B?=
 =?us-ascii?Q?rmuvtsrD9TbgspVD2+pwwPQbuyIBY9lR0eqN2aAyjcucS0MW8yG4KCGHx3ke?=
 =?us-ascii?Q?bw5XXwShvwFhPEXAHZVJ/AHBTEsTOwptiDEXjJnlHnqPahmb4MAwp2+US358?=
 =?us-ascii?Q?Nw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79d25347-e9d4-43fb-7a82-08ddebc9e7e8
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 15:44:16.9514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iSqlihkncNJ6n9Si6VCZVGz/SkcVwtwmiGAaSCbnzSdBQVKRO6Vvn+5eKqCYKfAx6kX4zoN6rbEeVoyd2wGdCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7635

The driver does not handle well protocol switching to or from USXGMII,
because it conflates it with 10GBase-R.

In the expected USXGMII use case, that isn't a problem, because SerDes
protocol switching performed by the lynx-28g driver is not necessary,
because USXGMII natively supports multiple speeds, as opposed to SFP
modules using 1000Base-X or 10GBase-R which require switching between
the 2.

That being said, let's be explicit, and in case someone requests a
protocol change which involves USXGMII, let's do the right thing.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/phy/freescale/phy-fsl-lynx-28g.c | 87 ++++++++++++++++++++----
 1 file changed, 74 insertions(+), 13 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-lynx-28g.c b/drivers/phy/freescale/phy-fsl-lynx-28g.c
index 5f1af4fdcb49..49e9ea82106f 100644
--- a/drivers/phy/freescale/phy-fsl-lynx-28g.c
+++ b/drivers/phy/freescale/phy-fsl-lynx-28g.c
@@ -247,7 +247,8 @@ enum lynx_28g_proto_sel {
 enum lynx_lane_mode {
 	LANE_MODE_UNKNOWN,
 	LANE_MODE_1000BASEX_SGMII,
-	LANE_MODE_10GBASER_USXGMII,
+	LANE_MODE_10GBASER,
+	LANE_MODE_USXGMII,
 	LANE_MODE_MAX,
 };
 
@@ -317,7 +318,35 @@ static const struct lynx_28g_proto_conf lynx_28g_proto_conf[LANE_MODE_MAX] = {
 		.smp_autoz_d1r = 0,
 		.smp_autoz_eg1r = 0,
 	},
-	[LANE_MODE_10GBASER_USXGMII] = {
+	[LANE_MODE_USXGMII] = {
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
+	[LANE_MODE_10GBASER] = {
 		.proto_sel = LNaGCR0_PROTO_SEL_XFI,
 		.if_width = LNaGCR0_IF_WIDTH_20_BIT,
 		.teq_type = EQ_TYPE_2TAP,
@@ -414,8 +443,10 @@ static const char *lynx_lane_mode_str(enum lynx_lane_mode lane_mode)
 	switch (lane_mode) {
 	case LANE_MODE_1000BASEX_SGMII:
 		return "1000Base-X/SGMII";
-	case LANE_MODE_10GBASER_USXGMII:
-		return "10GBase-R/USXGMII";
+	case LANE_MODE_10GBASER:
+		return "10GBase-R";
+	case LANE_MODE_USXGMII:
+		return "USXGMII";
 	default:
 		return "unknown";
 	}
@@ -428,8 +459,9 @@ static enum lynx_lane_mode phy_interface_to_lane_mode(phy_interface_t intf)
 	case PHY_INTERFACE_MODE_1000BASEX:
 		return LANE_MODE_1000BASEX_SGMII;
 	case PHY_INTERFACE_MODE_10GBASER:
+		return LANE_MODE_10GBASER;
 	case PHY_INTERFACE_MODE_USXGMII:
-		return LANE_MODE_10GBASER_USXGMII;
+		return LANE_MODE_USXGMII;
 	default:
 		return LANE_MODE_UNKNOWN;
 	}
@@ -497,7 +529,8 @@ static void lynx_28g_lane_set_nrate(struct lynx_28g_lane *lane,
 		break;
 	case PLLnCR1_FRATE_10G_20GVCO:
 		switch (lane_mode) {
-		case LANE_MODE_10GBASER_USXGMII:
+		case LANE_MODE_10GBASER:
+		case LANE_MODE_USXGMII:
 			lynx_28g_lane_rmw(lane, LNaTGCR0,
 					  FIELD_PREP(LNaTGCR0_N_RATE, LNaTGCR0_N_RATE_FULL),
 					  LNaTGCR0_N_RATE);
@@ -595,7 +628,8 @@ static int lynx_28g_get_pccr(enum lynx_lane_mode lane_mode, int lane,
 		pccr->width = 4;
 		pccr->shift = SGMII_CFG(lane);
 		break;
-	case LANE_MODE_10GBASER_USXGMII:
+	case LANE_MODE_USXGMII:
+	case LANE_MODE_10GBASER:
 		pccr->offset = PCCC;
 		pccr->width = 4;
 		pccr->shift = SXGMII_CFG(lane);
@@ -612,13 +646,32 @@ static int lynx_28g_get_pcvt_offset(int lane, enum lynx_lane_mode lane_mode)
 	switch (lane_mode) {
 	case LANE_MODE_1000BASEX_SGMII:
 		return SGMIIaCR0(lane);
-	case LANE_MODE_10GBASER_USXGMII:
+	case LANE_MODE_USXGMII:
+	case LANE_MODE_10GBASER:
 		return SXGMIIaCR0(lane);
 	default:
 		return -EOPNOTSUPP;
 	}
 }
 
+static int lynx_pccr_read(struct lynx_28g_lane *lane, enum lynx_lane_mode mode,
+			  u32 *val)
+{
+	struct lynx_28g_priv *priv = lane->priv;
+	struct lynx_pccr pccr;
+	u32 tmp;
+	int err;
+
+	err = lynx_28g_get_pccr(mode, lane->id, &pccr);
+	if (err)
+		return err;
+
+	tmp = lynx_28g_read(priv, pccr.offset);
+	*val = (tmp >> pccr.shift) & GENMASK(pccr.width - 1, 0);
+
+	return 0;
+}
+
 static int lynx_pccr_write(struct lynx_28g_lane *lane,
 			   enum lynx_lane_mode lane_mode, u32 val)
 {
@@ -828,8 +881,11 @@ static int lynx_28g_lane_enable_pcvt(struct lynx_28g_lane *lane,
 	case LANE_MODE_1000BASEX_SGMII:
 		val |= PCC8_SGMIIa_CFG;
 		break;
-	case LANE_MODE_10GBASER_USXGMII:
-		val |= PCCC_SXGMIIn_CFG | PCCC_SXGMIIn_XFI;
+	case LANE_MODE_10GBASER:
+		val |= PCCC_SXGMIIn_XFI;
+		fallthrough;
+	case LANE_MODE_USXGMII:
+		val |= PCCC_SXGMIIn_CFG;
 		break;
 	default:
 		break;
@@ -954,7 +1010,8 @@ static void lynx_28g_pll_read_configuration(struct lynx_28g_priv *priv)
 			break;
 		case PLLnCR1_FRATE_10G_20GVCO:
 			/* 10.3125GHz clock net */
-			__set_bit(LANE_MODE_10GBASER_USXGMII, pll->supported);
+			__set_bit(LANE_MODE_10GBASER, pll->supported);
+			__set_bit(LANE_MODE_USXGMII, pll->supported);
 			break;
 		default:
 			/* 6GHz, 12.890625GHz, 8GHz */
@@ -999,7 +1056,7 @@ static void lynx_28g_cdr_lock_check(struct work_struct *work)
 
 static void lynx_28g_lane_read_configuration(struct lynx_28g_lane *lane)
 {
-	u32 pss, protocol;
+	u32 pccr, pss, protocol;
 
 	pss = lynx_28g_lane_read(lane, LNaPSS);
 	protocol = FIELD_GET(LNaPSS_TYPE, pss);
@@ -1008,7 +1065,11 @@ static void lynx_28g_lane_read_configuration(struct lynx_28g_lane *lane)
 		lane->mode = LANE_MODE_1000BASEX_SGMII;
 		break;
 	case LNaPSS_TYPE_XFI:
-		lane->mode = LANE_MODE_10GBASER_USXGMII;
+		lynx_pccr_read(lane, LANE_MODE_10GBASER, &pccr);
+		if (pccr & PCCC_SXGMIIn_XFI)
+			lane->mode = LANE_MODE_10GBASER;
+		else
+			lane->mode = LANE_MODE_USXGMII;
 		break;
 	default:
 		lane->mode = LANE_MODE_UNKNOWN;
-- 
2.34.1


