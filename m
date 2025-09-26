Return-Path: <linux-kernel+bounces-834506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CBCBA4D5E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 20:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 813B21607D6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 18:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7228F30FC34;
	Fri, 26 Sep 2025 18:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CREIhezk"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012044.outbound.protection.outlook.com [52.101.66.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54692F83AC
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 18:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758909943; cv=fail; b=qgpcb8obN6X/CYstlIcWLR3iabky6auAtZOVRMVqGigE/rNUx2B0GAhc1OI+yfT5SGoOUCyzZeqCuppFhWDjKBJvLPstWp1uO+Z8JCQ4TSg9PAyWXWfD5D8hgq6NOO6DwllbpfA3ly6JPdm/vkmU9UMZNYMTsX0Qddb4kzrKksc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758909943; c=relaxed/simple;
	bh=JZifajPpMH9avlOnHNXnb2U7SgWk8CCaSk+auczCk+s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J2sydebZSPkYSIuK1Gb4/AXf3zfNTOGHfWGdUt4mFsGPCzV4G6FywVG3nK709/oQYXteqiaGkaBlpDXzuPe/Je95qLQogAdoUxE0VNsHDqDrQ4RSCROkXWJCM8MO7da0dHUVq/n3sFdlqaxqdCa6jl+C2gCQGeSmE27Q1okhIic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CREIhezk; arc=fail smtp.client-ip=52.101.66.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hlKVFJ3YKycT8Yt9mp5rCXeQikN+WAFl9FrOG3QdSEkA4ssio2xqm+6n72EYYVtNMtor38P4uzdId8bTtiEBhdCGqNn+uJpy7SqP8KnE7F/YuK/1NMansh5loc3Qyh6qTmEkX0ie4LqHGfW021vfjO7q7MOvsHyK0DfF+XC2XD+Tt4dQQjnNsf3C7eEQS34NAms7yO3zGF7IhDq5Srv3JOyqqIs1hqKt3z9D6yisH7T/7OXmdUSt2QFtcb6bx7ED80GY2SXj3iT/neuFdQV2O8c6cCMPuEtd2azb3M+e0z22ZEPxlGO2/k+LhU7L7aJnWWwG/b4mnA7YCL6OqzRw9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bhffXJFO3TY2tb5KeymLeyI60sq5XBsmKWi+YWol7p4=;
 b=KHC1RqcZhRwYWb+fZR6dRqfZhoyMJAOmvZ4znvblMh6sDoz+4c59l1bDywBskrfL9+vV9BAz37kOI43CI1b4tnTgu/++SR+1Lo90Yg2vfFyDB+4WYl2yjyq39mxs7Wh/dnntxAy+Vbc/vcmLQx1RlWrAwltE3SiDgSvjJ1uWS10diRCJOQKRZATc+i2Da+qrO2FSscDOHLwgDr0HJ6H7yDiihqZyGYvAR0jlkx2pBW/H/dVapcy/tja8ga6j2dZTh0Uot/5fcJXl1NDe7EhhenaCNDdykVJZBEacU1JJYWsTmZ4eS/yGsvAIP/MLKk/KZhIJSaIHGFF+2x323RKmkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bhffXJFO3TY2tb5KeymLeyI60sq5XBsmKWi+YWol7p4=;
 b=CREIhezksk4TmVkuJsC7dGc8lktv3OKb0gUSY0v7sJdoQU1g/nGOy52eHAWReAZ4NqmBN1GdmlgOh1J7s83ThUWw1RZ5H90dEhilysddu1ujx+cJNOdwgDKLJeat/q0nBvg1bwQXpsr8hy2KQiO1AgJvY2q045HQtwa1ziHsvJjZpGTRsxlC7IYfkauVF3G0h+3cWjX/tn9XN4JS+EloIjCMoPzi+/Z0LdOzLs4SYgUIXbnWZxBQK51qOjI2kmzpg7L/e87Cypr9lgS3WdNW7VaQFyPsqj1YsWDtN8RgRVLYJEZ+doEz3s7xmu7tZD9b1RusihJvUxgQpOnm/BCI8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS8PR04MB7878.eurprd04.prod.outlook.com (2603:10a6:20b:2af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Fri, 26 Sep
 2025 18:05:29 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9160.010; Fri, 26 Sep 2025
 18:05:29 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Josua Mayer <josua@solid-run.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 phy 09/17] phy: lynx-28g: configure more equalization params for 1GbE and 10GbE
Date: Fri, 26 Sep 2025 21:04:57 +0300
Message-Id: <20250926180505.760089-10-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: bb9d715f-ce25-4add-42aa-08ddfd2746a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FI6DH9WLORvuWUpI/eQqXYuko3kls2xu9Y1w9b58+HbB0bD8B8d26phsgGyf?=
 =?us-ascii?Q?3c8wWvISfHJIEDCD3Ed2/GkNsI9hiVbPQovZX1cJga8075z+I3929UAilJl0?=
 =?us-ascii?Q?EHkhb6MvoIriR0/v5IHsZyL3WsXghWTh/GMJeUxhYuBKpS9mTz0S69zTTiCh?=
 =?us-ascii?Q?XEYyAx6CHwI4jPdc+0NJl9gVODPhsEROzcrJTlwfZuFR2MUK5Euog8g6XpNx?=
 =?us-ascii?Q?ykmKx3mQmndqKOwwbjJT3KGpGho9BCA59rHgoBuZ/RqlpXCCzOHlJo66LaKs?=
 =?us-ascii?Q?HjUiYEKR0LjAhBZF7CkmE+0Gb4dGk3yi6qIOFpAo4flW+FiQ75POtGaPFnHw?=
 =?us-ascii?Q?2cdXAfe1whc+XMLtuVY/3JCF6epdSrMUPn3SlpEKfCw9xtWWGIYJyZ5qQvVt?=
 =?us-ascii?Q?55xd6C8GgEafhQH5UVIqGUame/GuGYPlL3aUmk4oWsXq4ERpsWUfwiP8gPVG?=
 =?us-ascii?Q?L8+CfOZ9MwKjWU9HMXo991ZvJsrxWK6D325SUBG210/LCY6f7FskycIS6/+T?=
 =?us-ascii?Q?girLKpsdFZl9vfKtvCSo5kPoTjpR+Rsi7YeMv8NDOyCcE9Q7xg+xhdXyCUxI?=
 =?us-ascii?Q?c/L23e9p6UhuyL7dhlZ2YMaNJ/XRGlBYhmc9dcJ4TkLn+oUQ55xyCx3/uf7F?=
 =?us-ascii?Q?bWCcunQVB4nqgte32+iZHvCNRHZ8/Yq1qb3rx80QRFPRGoYMD5Oic2eOG/cN?=
 =?us-ascii?Q?xE1u/ZUj9zxTkvS1k1sSSAp8kGvObep0jwaaZtkNnr+Jvfjg+REG9UakpCZh?=
 =?us-ascii?Q?ywlK2p+tgDD3anyPf5TdSIk6Fx/BZhjr2yvnnFWt17ne8bGMT0Zo03Z6lIKg?=
 =?us-ascii?Q?R0qbpyACZscPDz63zlijyJEbT9OfTP30LS8tKX1KY6QYcm5wjZ+ESPXPPrFJ?=
 =?us-ascii?Q?CIkH+BuEMJCG8tuWISyhCUqLdlAd9iCKN+JQdqsArT7+18olEmwSARp92KF1?=
 =?us-ascii?Q?AohZ1qKSZYduxSVsm1lOv+4IAvOA5nt33ZUKDIkO5jPwm6jRb5qf5XQwsIuI?=
 =?us-ascii?Q?+GqeJFYP5kwdl1f3edKZvFURMrn1uNATRtap0ieJ5OB+FW+if3fqu9M+zgBR?=
 =?us-ascii?Q?rtFKfL8KvbNmzcrahtLybGA49TfhfoEBRLxokHzzwOiF0wl625+205lBXcRU?=
 =?us-ascii?Q?E1vS0Ddrga0FKkFj1KmWTl83+OwTPW8rjr1Tq9FnyFm/PLH/tnwnuAxs3mN1?=
 =?us-ascii?Q?0IdHBXXMoQBHCgFd3iNKFHf2tcVccmqSARv+wSeUA0QV8aOVllwXdwAH8qOA?=
 =?us-ascii?Q?HcKDfRbHJ3I5i2sydKab+uA8ol9NJVXfrwxw+0ZdMpOX+Nxda7q2Xw8AuSgx?=
 =?us-ascii?Q?PxkcGapYPTNun0xpvIwjyWoBOAS68xO8WMc4WftrvkjZGmUKXRKPv3IpbIF8?=
 =?us-ascii?Q?wsjGvogGUvHopBmecGvQNZg0SuqcGkulUMg97h0XfL51QcShadhsCzzqw6uH?=
 =?us-ascii?Q?d2JjaWOFt6r3SeP2WfilAXYPkKKENFxbMzVd9gvNJlyTK+kp4nu44oiojrr7?=
 =?us-ascii?Q?wX9xpIGrCyxDfK18zKXKVnKNcqIX4JT3bVKT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LE5xYbOiKmYd+59Fe4YXo8xyY8/f/r/32Az6WBtMxm0JeH6LMh01603Zry/u?=
 =?us-ascii?Q?Ad8B0g0KXyWyxeHHcuenZExEq8M4r0emV23EiltK/GPaO+o0Ky212VFfF6tR?=
 =?us-ascii?Q?OvqtpRmcGCGGsmwG0+K5NyACNDVQbx6c9Z+3Qkkq0OqV5PgmviDDfcergrau?=
 =?us-ascii?Q?b4l0ZH4l5TxpIEm+ZNBJ8EKCxy0IWkyhWrceW8NjK7ibNmNU5jT7N9fholGJ?=
 =?us-ascii?Q?DPq83Qne1BHQKpW/IBTwIzOimWIK/aDKeKIm2ouEW0bLtRVrtQJtuAlZVJbH?=
 =?us-ascii?Q?kvDarOuoPQHedmtCP2KBIS6ZbHzbDw3kUNvJDo+nNyIZ8WYOeI4VUxOt7oT/?=
 =?us-ascii?Q?DpkRqHoFnPAOiMgDKxquWL+1VmMou2Sh+ruZ7p79gHDzHP0Pw/czXtep3UfE?=
 =?us-ascii?Q?SmkD1H87v2ZoapzhzB4Tr3w27U6Z37TPPtkFglJ/SVhJLH5miPth0hwEhKwj?=
 =?us-ascii?Q?ljUefCVqpBKG7o8zTOMmK+g829rf6tZC/F/VYcfQfXNWz0QB3mSjzncXcSAm?=
 =?us-ascii?Q?OtQmdIEUJxlKMdPmuI707JY6Pz0iMe9Bbe8ob26YgrnhvJ2DLphYX0P/gbkJ?=
 =?us-ascii?Q?HeZn4JDkHK8nU14x5gJy6hGBD5g7JRrdoHXbCTine5bahH6/p3N8z+S/GEoX?=
 =?us-ascii?Q?MwJ2UzOgPCg86/pczRUyPDxeWbihILuXpjbVXfO0EI9TaxC7nOnbcYfqxFI0?=
 =?us-ascii?Q?WNLdBaeyWfj8549mYBPSSAc7p2U7mE2524itSwvxLnfgl9YovsjOQZz2/ohr?=
 =?us-ascii?Q?ag/D1C1XvnGdKR4IJUIUE5OJ8fsjLzh/fNeJYSy0NW+MFcZi9kYGjYDhXitf?=
 =?us-ascii?Q?41BJOWKegT3P+adDLNl3w3X38Dj5cQOkC6EedOZbZyMqI73pf8q30xCCgIBa?=
 =?us-ascii?Q?Clmz14ZK7zRDmJFwRXbhJZ4H3smrUgJSVrZciRfErb2uOgtj4LayVHR3vYRx?=
 =?us-ascii?Q?T+4hExdrc0WqnJd8sK3+N3Shg6iSuDVyXanmJ4XrqN852V40ZXU7RuqmJzmz?=
 =?us-ascii?Q?DhfQD6Z9mDFIhx0boFNRqNLv/LWsUPqK/pbdChs38J+MWOANkTdRxJLHoiVV?=
 =?us-ascii?Q?BPhjKuuhlkf6+IpvyZyWIvRtKpkMX9eafAxbCClrIqwkAXN3AeGzqrhtxyDa?=
 =?us-ascii?Q?amSFwvJ3TC6sQrgultPd2QtV/7Zsd7aGXKuEkdHGR5B9yGS8q9N8XQJdnRjF?=
 =?us-ascii?Q?q6Tg8U9P1OG2MhFvkuNHz6q7PlNksyJWDXaXGh1B8kssor5nvkgFrt0arpAe?=
 =?us-ascii?Q?sYTTFVRW8CBsVubqvWOkxdbRIdeXmwqFDHFk/wKQiCe62yMaKH3VGGc2kApr?=
 =?us-ascii?Q?NxCQrCm+uAablHeJUavUMZMIMVzAKEyC//Ys6Or++bmL0Y6T/bj9MCncZxVq?=
 =?us-ascii?Q?xJVzAYiUjJ+GtQb558zUN7d7GS8jdXRQKuAq1EItOhVTj91b9yBqpeB1LJuq?=
 =?us-ascii?Q?W6ZNNXx1fCVgja9HxMZvd+jW0KVEzvwNz7wFVISdP4qUiUrxZTO9PvJiMWHG?=
 =?us-ascii?Q?K2X97AKuzB+ziCbYzpXRNnek0gtDZQStcUjjjvzrUSVcPyFhqEKO+cZF9i97?=
 =?us-ascii?Q?sZfYx4eq6NiMPdXmxQYqHrwDsDEFpi4zOhMhoHR098okSN8Ov8ipqSP2+Ur7?=
 =?us-ascii?Q?dw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb9d715f-ce25-4add-42aa-08ddfd2746a6
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 18:05:29.2416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FI3NN0TR8l0tXMQ7iuQVoJA/6JEWZmEXty29A4MqTrBrNU+yAZVkKtpNGEBte7hn6azKPEindEUiu3V60RfVww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7878

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
v1->v3: none

 drivers/phy/freescale/phy-fsl-lynx-28g.c | 37 ++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/phy/freescale/phy-fsl-lynx-28g.c b/drivers/phy/freescale/phy-fsl-lynx-28g.c
index a8a335680092..eb2353531ef7 100644
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


