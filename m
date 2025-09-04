Return-Path: <linux-kernel+bounces-801183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1304AB440E6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2762A4606A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18F530102F;
	Thu,  4 Sep 2025 15:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="W3K8fbVl"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013019.outbound.protection.outlook.com [40.107.159.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86AE2D59EF
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 15:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757000672; cv=fail; b=OskTpdDpERojOBG/ZlJMsbWJqkVtLWnjGS0GwhCaAkniy3gGV1W6oetUfbJuWCm5HX6TK7PuJKkdhR1uV4hgzwo3nsHenzFB1PvVkPSpqm2wo9e51HQ5E7EtGkF2TUI+H2rqIeWKms+CTGAxgbxctcEV/WK1zTQa0nYXN+6lU3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757000672; c=relaxed/simple;
	bh=jjfz+BNIPoLVk/vfHrDyJrJ7BVXnzeyC1+uH+VyhUgk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XgXCFq6Qe8dQ2wSe1BorOpgo9sFaZjjxeojoebgLIWwkcyeII8FCdIeVFkBG/9177qMKPNG9TNG4i+y9Ch2M+Tt5REEynQf0wBzvaLtg5r3zQm+i5IIbvzVGrJG6+jFdMQLPD8B5ZP0i6cmXC2Tu+LlUu7OhOApuYdy6eTua8UM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=W3K8fbVl; arc=fail smtp.client-ip=40.107.159.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oyoJbRHRL42msJivCy6xGy36AZquE3HAs3pPhcts8kseSvBS0ld/Ex7hYFmo5JzfGIfQpE14eFY94Q0Kl+Co1/ULBcV8nOMVF+uM28rhM9pOJX6n/Zwhn5B1JefLO3/WmBE2sz2MOUmhqRNkDMlgqmr4JuKCVUss2lt4+KL+v+qV1jTIuxnDdXfwzg/tU6TuQUWNq8JB1HT5JW7vPFqTsDKLp8xgh31DSbNtz1mwFom4xrhGLCq6ArLE/rlsPrLPvSE6eimueBP56kPilIW2OVAlnjPP2YL4eK5kfZ2vFHEjVyfsxiWH9jIRaQN1G2m6hzv2Qp3iSZ5ep39czyKg7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IUvic0CFY+j3/6MtAM6wKOtwTDCwMqKJ/jcmNzV6FIU=;
 b=DkqPLjo3XfxxFp4+tVXmq/35cRKaYg11V+uGxdBTI4YPpcy+jQ2dpWiBhtr8r6W0xYkL1qiWcYIbFBD/d/Mi0Nns1U+lQZggvrRU7qObDbn+F+vu95uDv+z5lfO2UmQE5l648ektnoC/bdy0cUtzwXzVKpwHK+c8HAqPd7SSokW51xLaMoUvcDt3v7s3GYVJvgbjbQuCItNlN1E8k9/x4DN9JuIn4SNYBuPJoBFHwKA38KpO1PDU8Ww7mvYVTBnduRZnmyJXZQap5t2qqjA6opHtCZ0m2IR42gHD4JpojNOUipRDv6jGjFb0DydFWb+ST9R987TizSgQYA1afH13tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IUvic0CFY+j3/6MtAM6wKOtwTDCwMqKJ/jcmNzV6FIU=;
 b=W3K8fbVl+60hAHQGzbd54GI+x/fJAAEd5/VKITiegEIFiavmjuwPGItoDCLIrhNY8xZa8xM4gZPW54NsxE5VqvessvZIfFoLVSiQS8qLYBxlkD2HzbPGkCVa6mLHUjVen52CyXjU0a9kXg5wDTbr6mfxo9iUw+EW/NIz+oDcpFhekRu8l8o74/1WSBOEYUZ/LblhShw22Uw+PW/tHZj3QPJaEgq6j7hlrC8BuxLnpKFWc/LH8HcI9uTfV6jTk+ibouSQ/r2aWRhartrqB8h7O6Wc2teghVgnphHKIHi1dCvRceKw6FJMJzQd/jaTj3EJ9dixtIl2sREnt0si8ciHLg==
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
Subject: [PATCH phy 12/14] phy: lynx-28g: implement phy_exit() operation
Date: Thu,  4 Sep 2025 18:44:00 +0300
Message-Id: <20250904154402.300032-13-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2e752604-0b6a-4b3b-5853-08ddebc9e955
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|19092799006|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Dg5W22bHcMxP3faaaI1hz4F26xq39T3MzncfNw+JK22vJk+GL4Pp48IuI61L?=
 =?us-ascii?Q?7d3MTib/orUGnUIo9VXvabiEa4Fr+QecTQtpsbU+9mPeWtcbw96CR0h90Xa/?=
 =?us-ascii?Q?UOov1WPX4UrZaPzrERcmfdYb5hpIRKL2kVHZp+xwIGokIi07GOudORPrPqY+?=
 =?us-ascii?Q?6ttpEJDMyNfO22O+1/NlsGaCt9uZ/xRfzdhWNhUQ3/96BtmfEj36eLJxnuBG?=
 =?us-ascii?Q?GSAdnoI1BAmqfNuLP2r91YHkz1sNdjngxLu0PnQQuwep0A+upuIG1RQMvzET?=
 =?us-ascii?Q?05mrlLJIcRBDPM3b8p0snaq7FHPr28PCWKvEEkyMDg2UR3j5NBB5Lg0tvyZU?=
 =?us-ascii?Q?PSfFhztnmyiE7Ey6pZPzoUG8VOur5y5cnNW+5+hOwolmn+vv/+RXpKBR1a1r?=
 =?us-ascii?Q?yczKtwfBPXQ0HcgfQleo1TNQN3AD896dcQO0OHHT/eRuNMpqA9pQRqw1Mhmc?=
 =?us-ascii?Q?AT6QPPll0RkkybBXRHJw3yVKi4hnG/UsT1IEujCIfYEMBdUaQRjppEF6M8TE?=
 =?us-ascii?Q?l8tscWj7qxC8Op2FuZQ+25rKphU9Xiux8tICZByZSqCKvEOyl7AjJuz+ALZk?=
 =?us-ascii?Q?g8uHXwZbki4k2cRAzF1L98FalqRq2Vrt1dsu+8NlrL/9kv1hHdIWC7JO5Iyt?=
 =?us-ascii?Q?2nEh/AXTsifCdEokoZWX8jpQMiQht6F85YrNtuDrPGfp3cQ+wt1ck/oBgBgn?=
 =?us-ascii?Q?iD2yMhzIHOqffQGVoR79G2mRVWuNTQVR4zjIe4aQrdFr5FNVtMa4iRrl5NkR?=
 =?us-ascii?Q?K6bgiqbptukiClTP4thjjGEN5x4D5cnHg5USnl1QcRGojZT2ZDobO5/FsJM6?=
 =?us-ascii?Q?fIHPRtL0jLYl2AWcEMRSZwY1jJCGXxS7OC0rCYNvG56E9o5vBlBswsyw3pyJ?=
 =?us-ascii?Q?Hh28BlS4OH/iDqyVfpFvk4/fYcVsvMpR5k0k/U/C++sk+zc7xg52EWb17urr?=
 =?us-ascii?Q?jOE1/SsyntMU+ytotqixDaAm9au8hTavTcZ6UGF3kP+wVMO4BIj/GVILSlQc?=
 =?us-ascii?Q?ReOf2aiOKcZPqujcgRxWR3ojab6PYvFSF8V+qVM1mCgp8+MljefFCNpey6T+?=
 =?us-ascii?Q?7+KAdu3ulplBzJastoVGyD5bs0JGJfttknUKKH2aht0V5DeL6hbLKNyyN1FA?=
 =?us-ascii?Q?ZNu2TpMB1aoc+B39QDAJslea/XEwo00x1oRi6tjqp6Zk22+zUHLKSm9qSVng?=
 =?us-ascii?Q?R2qfIy6bbYPGPGSFUEZDs0TUy+wxu0DUtC70wXNpsPlYRwQY0TYxzMXBfrjw?=
 =?us-ascii?Q?26uCnCx6gUYLWIMiFbfa2hC7HftSG8PoX2KxXbZIFbWnoKhHkGJ2uT4y5GHf?=
 =?us-ascii?Q?VRGYjJR93C6IE68BQssemjMw31UpPgtVG7FFuIgQF42WKT9LEc5R44gmmpBC?=
 =?us-ascii?Q?cbfrJ1SAr1ehsGDBwAnMf/UcekeUf+cTUEhV3hPIeQCIltUGx8ynjvScjft/?=
 =?us-ascii?Q?NMFqwVfqejBUCeYWjmJkuAN33FmtuH9YpjTlRzwjewpPMG0XDZK++Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(19092799006)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wmk1d1GcC58SQiJfFrA2Pa1VUvc/k4nfpUu5H0TGLoQFUWa3DADXeDcEipkh?=
 =?us-ascii?Q?cniW8zgo1bPRfyVz9Ptp2vozL+NOEPphGmcWXBz38kbb0wR9KcTubKRQ2CX+?=
 =?us-ascii?Q?eBcXb4+Kp0uP7YCw7ZAJO71el+kKdkeZdLrNN9UKT9kPg/P5Ac3dbfd/Rkfe?=
 =?us-ascii?Q?3yqdcOoFyv4X3MO5lIH6LiQU5N8kCsPjiW0S5d1/unVvqPEt1XpWSpBComIN?=
 =?us-ascii?Q?K+cxVzY0I4RaIZKI16sSQeRsVhkKm5r0agELcmaNuSvpTNItM2j238Lgzw5Y?=
 =?us-ascii?Q?UeT+YTLXxIuahp4R/KakFUPr+tMjngNRJDNNjCI+g/X1s4k11h3oNzTRIjss?=
 =?us-ascii?Q?dudiOG0X4IqgmQz3u9Z+ZAbVbv0tKc31oaNeC0u7j+gqXuiPrjr76DO/o1AY?=
 =?us-ascii?Q?uOo2hxacRX2b7WFMV1IixQniiWIw678H3U1PhdldJYtJRfd9888COW4YbiWy?=
 =?us-ascii?Q?JKTI8MzZZNpgT3zyTlVEYJDYB6mA9clhQHL+BJlmETsfyHsU/P2E+qpfNmas?=
 =?us-ascii?Q?/sjuxyerdxiKZBhOx1Hoo2uBatwgfgk88Vy6jk+pigsFys30CCGLjvzntRx/?=
 =?us-ascii?Q?0hIOHxd2LyPOACHzMwARBQxEV6AdWV+1Mv8O8BCzvthfwNH+xXRZhN+gdXZ7?=
 =?us-ascii?Q?9AsZGyPHdzCSQFl05qvuPvqMZjZNsHvgPQ49zAjfaPQlCVBZKLO+q+0wqAlK?=
 =?us-ascii?Q?m1aOob+18dmIQYXwiUI1GqH3KX139RnKueSwXkzqbvjK+Ewt4Q1rFK66nPdm?=
 =?us-ascii?Q?T5vd2sM6x/CZ/p9gMZxLw4UJr+RalkeML+cVCWkiHTJXVCQHZtsnHLKWP9bL?=
 =?us-ascii?Q?nNsVxDShrJdf2zyOHIF2T1oOxUQsz50VDzp97MsU6Z4mQy57Uc2N9aqqJSn/?=
 =?us-ascii?Q?7SHrkn1SncnDqkIiYIM+GVV7uthzqYeuRqCk8pGCUoP2SRNrqZt4o1C2CBoN?=
 =?us-ascii?Q?V/3tcLVn4G2a3DWgwgN/5csqArhOZfCigIro61ZF0zdte3zFuq4DjtQagdWE?=
 =?us-ascii?Q?mSfAynf3U9zSLLW+GYg5F8VV+FFlm7G4Pu6l6UL20TyLd6GTTsSgJZncpV02?=
 =?us-ascii?Q?HR4+DJJIAvd9cS/4lVZIoz4rP6l3jqu5/8To/slH676C6FnPorxEVviNpEpG?=
 =?us-ascii?Q?G0mymbcrVVOaJ2HOR93Vv+ev3tTlosK5b8B3mr1HsdTrYcqFTCcNUHkXTYwM?=
 =?us-ascii?Q?uKkD5Nlpef6gDTO2/7FUj5slOwy8YQLN8SJcaj0nV85JLOoJyhDRf/T42HrI?=
 =?us-ascii?Q?+xlsT7JG7UexX+80ryYJHIz/ChHfp+HhgRahJdkre4wajUwKIS6SNz3DNg8f?=
 =?us-ascii?Q?zx3fZE23z+UTbP44ZAB8Wx3sMuBdGSb5/O9rkzjhy6LjKpl4Jd/RV5I3PJe8?=
 =?us-ascii?Q?+fO87140zKHQ51jUBZ81sBBRYJ2iVUeMwjuwQ9RuaC+NpDaRC2veF1Ynl3PW?=
 =?us-ascii?Q?CWEwnZL5Bv+JlO/Xhpvw/zAXxNuQIb8uiZHLzvzT/TQJO4S8ClkT6GVYxsfo?=
 =?us-ascii?Q?VEi3IQInQV+fZ0EikEGy4iQkTiG1W8O7r1SJN1L2Gujdmt09/T6URuiW97kS?=
 =?us-ascii?Q?Ru8S852bA4oIVIi0iARmGBO8jBrI0jcXOTea4dp5es1McHCPwykZ7lD4RkoB?=
 =?us-ascii?Q?iA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e752604-0b6a-4b3b-5853-08ddebc9e955
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 15:44:19.3536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ge5sLE4uW+WkZ9MMDSkXCqfuFKcQG4uOa74BHaMjNdh5iv5tb0rsjXifdOlOt8ShLX1YtJEe1/wS4N4++VLHrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7635

Managed lanes are supposed to have power management through
phy_power_on() and phy_power_off().

Unmanaged lanes are supposed to be always powered on, because they might
have a consumer which doesn't use this SerDes driver, and we don't want
to break it.

A lane is initially unmanaged, and becomes managed when phy_init() is
called on it.

It is normal for consumer drivers to call both phy_init() and
phy_exit(), in a balanced way. This ensures the phy->init_count from the
phy core is brought back to zero, for example during -EPROBE_DEFER in
the consumer, the lane temporarily becomes unmanaged and then managed
again.

Given the above requirement for consumers, it also imposes a requirement
for the SerDes driver to implement the exit() operation. Otherwise, a
balanced set of phy_init() and phy_exit() calls from the consumer will
effectively result in multiple lynx_28g_init() calls as seen by the
SerDes and nothing else. That actually doesn't work - the driver can't
power down a SerDes lane which is actually powered down, so such a call
sequence would hang the kernel.

No consumer driver currently uses phy_exit(), so the above problem does
not yet trigger, but in preparation for its introduction, it is
necessary to add lynx_28g_exit() as the mirror of lynx_28g_init().

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/phy/freescale/phy-fsl-lynx-28g.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/phy/freescale/phy-fsl-lynx-28g.c b/drivers/phy/freescale/phy-fsl-lynx-28g.c
index 5055ddba0363..91a3b3928ab4 100644
--- a/drivers/phy/freescale/phy-fsl-lynx-28g.c
+++ b/drivers/phy/freescale/phy-fsl-lynx-28g.c
@@ -1129,8 +1129,24 @@ static int lynx_28g_init(struct phy *phy)
 	return 0;
 }
 
+static int lynx_28g_exit(struct phy *phy)
+{
+	struct lynx_28g_lane *lane = phy_get_drvdata(phy);
+
+	/* The lane returns to the state where it isn't managed by the
+	 * consumer, so we must treat is as if it isn't initialized, and always
+	 * powered on.
+	 */
+	lane->init = false;
+	lane->powered_up = false;
+	lynx_28g_power_on(phy);
+
+	return 0;
+}
+
 static const struct phy_ops lynx_28g_ops = {
 	.init		= lynx_28g_init,
+	.exit		= lynx_28g_exit,
 	.power_on	= lynx_28g_power_on,
 	.power_off	= lynx_28g_power_off,
 	.set_mode	= lynx_28g_set_mode,
-- 
2.34.1


