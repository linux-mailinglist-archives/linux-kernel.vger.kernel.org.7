Return-Path: <linux-kernel+bounces-800096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59712B4335E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C3593AB46A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 07:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91E0288524;
	Thu,  4 Sep 2025 07:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OdyoCaTm"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013000.outbound.protection.outlook.com [40.107.162.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C92B288514;
	Thu,  4 Sep 2025 07:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756969616; cv=fail; b=DxHW+JnQHxcb2B4pUVRiiLtm4tVz0gLm6JMvb2onc1UsFaWfIEi3VmLYHEyZG5lSphXJOuWJperpx2ZrHnqP9TklJ4IfVuWVpysXLIUL2dmbfhUFb265fWan8PLkOAAJyCyT1r1Zfvbr/lsWmpJIPrKpFKpnPj7PVfBnFwoRJP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756969616; c=relaxed/simple;
	bh=SKQm2UcH+pv89CtRoA/ZEMP5gz4q3tKDUHJxgIUmecw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GJJrQ9UUB7VI1qPd92T1fUHc6an9F6RpVGvz3Z4vi204hvvE839UhjaGWfx5kRlnL0Ardr1TWcgJKKqM7p3fGYs9AeRuIVq0N2zUBwaF/URRV//EixOTVv4B3W8150fsk8NhNIF4IsjHxJ1vxfb8DkIYGiQwpZHNZ3sJDmi06Nw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OdyoCaTm; arc=fail smtp.client-ip=40.107.162.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qZ6hQRwMj6/1oaW7D52Q5fLKte+L7LVQmVOrXhfpf+dQaxEmkyaqwLzz24QY/D8o/JnXRBx5D2+KMMxD+ChP+3jQPJcg/5EsZpzGYFSH98p3qWlxR1JApJIqCP+U7m+hBOsXlUzovp2z6csauwls3+8CIyJAcmCaurzr0IpF6qoqR5OUbe4P6tgHacR1YE3V7KJtVrHgnBvOdHzFI3ydIDwzAwwXYkF3vZgJyWI2PVZsA05sU+xM1VcHswyph2Ln1EJKKZUb85HbPZnzAUGHM2Mkn3disl4Lzto6juBlS3JhCx1fqb0kJDhcS6n/rHilMDQp1aW89AcrzcXuTKs/aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QJJk8waZAGUmtpJCix864mNIrqWzOzu0644eEgIapGU=;
 b=lv57H4QU3OMFwU8JCtp6qLEFUYMXoBq/g+lByRoZHNSvTdRSOU0AJpXJEKuCUopfH2ZqoxF1h9wXnYHVvtyEbQQMAPBn0C3FOCz5uM9fjnnK01lB0V9zSWiDjFCcQpP80Xws8OY24K0ge/rcFmBJ4gj0piGCljwXB2+z4rj8Ql9m5a11gPS2OMfnp5br/cg6nyHQTpLkvxxwt9mTqgYf1pcwxT85DCk0U7Uuu80G45jTW2wtcgG2qwt+kkl+1bfIBgnozNuaR8U7TJefAmkhzLaZ2Z/eVu6qL25Kr2zchTY67QO0mcXZ9hV+mYGtg60iHbAEpgO6L2cJ7rPwoDnd2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJJk8waZAGUmtpJCix864mNIrqWzOzu0644eEgIapGU=;
 b=OdyoCaTm1hmqzMpbfFiqFhAwiHS+EltkvX3SMfxhnkkSAnbDT7bjg2F8kfGmaW2iP4xrGOolf9hD21oJdLCxsYYSB3b+JYtqdzankWhB3src/DaNBoTCYpCOSWX0MkDpiFfbEOiCAT7gM+yr8PS/MDs9zXICa7Ai+slfoqU0TkYRwxNx4UiYF+0L7gY1h6X4864QLEdUTUADR7O1693TQjhl1RWQuF6edgeotSw1d2Vsky2xurFZinSmmBoBx4hwR2jgMnsAH3Gn1q24jznyz+1JSzuJf73VsQ81o89Hi7M2fOAuvm9GC2uQOBK4PbN5dFQ1AdXdyB7PaO3fXGPKzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by DB8PR04MB7002.eurprd04.prod.outlook.com (2603:10a6:10:119::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Thu, 4 Sep
 2025 07:06:48 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b%6]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 07:06:48 +0000
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: andrzej.hajda@intel.com,
	neil.armstrong@linaro.org,
	rfoss@kernel.org,
	Laurent.pinchart@ideasonboard.com,
	jonas@kwiboo.se,
	jernej.skrabec@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	lumag@kernel.org,
	dianders@chromium.org,
	cristian.ciocaltea@collabora.com,
	luca.ceresoli@bootlin.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	victor.liu@nxp.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	p.zabel@pengutronix.de,
	devicetree@vger.kernel.org,
	l.stach@pengutronix.de,
	shengjiu.wang@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH v6 2/7] ALSA: Add definitions for the bits in IEC958 subframe
Date: Thu,  4 Sep 2025 15:05:55 +0800
Message-Id: <20250904070600.1361165-3-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250904070600.1361165-1-shengjiu.wang@nxp.com>
References: <20250904070600.1361165-1-shengjiu.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0016.apcprd04.prod.outlook.com
 (2603:1096:4:197::7) To AM0PR04MB7044.eurprd04.prod.outlook.com
 (2603:10a6:208:191::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB7044:EE_|DB8PR04MB7002:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a22225e-9c23-466a-2890-08ddeb819d55
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|19092799006|7416014|376014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?UYaD0hFTLISZ98Ha+K4Ph7pVpkvKvhSgZKiy8M1tL+k/jYl/Qi0i4tSH6mVm?=
 =?us-ascii?Q?xNjmyL8rSx3pkKYw9hFmKHneuoeTMg3yxyLzoDgejCAmFb2KvNw+bSfgxe07?=
 =?us-ascii?Q?scSaA3C4Wu7Xpl4JhXoZPZBSk8Bm6lXpTypL+IyBgh2gHuIyXEQChpIo8LK3?=
 =?us-ascii?Q?KP6LophOL0jOU8ibiYn/XgZoPL/OOzeBKUT8m548pbXNz9HYrthVfsbzNkFZ?=
 =?us-ascii?Q?rudPzY22F1HewYzsU1DNzLg4ts2mcA4R5w7ErVaoJmdTg2IOc8nBWdGLukSK?=
 =?us-ascii?Q?MWthVs7SwIx6wA8BiA/SIrGa4oMHV06jXKQMxj7bxbo1/pHgZnkgcqeJon4+?=
 =?us-ascii?Q?u4Hkkd+PRTiQfO/3axe9FfjiA3eDbmNi1OqnVEw+cGRpXC6qMCXWZ+0cyZL6?=
 =?us-ascii?Q?mNw3yeI9PGDnR/3fwbAdzc46DdCZ/KnlDmFR8ZenmxBrEGGrFSTSj3MJjfvj?=
 =?us-ascii?Q?8qO0UDfch4+OTG8pQlGb6S0/lpErarOQU2YhC0iuD/eFvXVvnsPjF8NnAIMV?=
 =?us-ascii?Q?nMn1TS+YpV/Rnv/HcNWhBYgk10zX9Cj3P+D4IxeK3Yn9HMLMK5cTFFXFGHwL?=
 =?us-ascii?Q?CQf4LLsV0waAl1IQCOu+FqQU97fncITcgbHhvSBXcdl4upR3jhAS4SqYYkg/?=
 =?us-ascii?Q?GVjbc6B3nw/G97Y5+IfDj27QMUO+Feem01TeGIeJCxJvAvSiUgcCPxdS7yYl?=
 =?us-ascii?Q?My2GcnN0jeIQZof+iJeMcXQdf6ujnJc9NM0uh+BlWhPgGKnwo9gIP9fdR4A6?=
 =?us-ascii?Q?QXAqFbSO9XfgbqoJUfu5U4nGhhhJUd6+AIdxRXscfoxsaKoWw/rzJkdPAqgI?=
 =?us-ascii?Q?SkrSHpbjy3JaDCIRTGphDnHDcaP2rmekwZltKr7HvY6PFFz058u9XuGhW43K?=
 =?us-ascii?Q?fc1roFokh4WbxIQeLNhOtYu3LflsSMZ+09m/iyD4EdjwVZpc+WKFdARncAVE?=
 =?us-ascii?Q?QrqjeeoY0h59eMdVxaDa9/uZUNR8RXiM35iWN/UYVfzxBGQAAXPbcCxxc63G?=
 =?us-ascii?Q?yUEGwDAWxAMdTBbdYRoTBLByzEdxS00m1MqEkqQFuTkGJFio5Jk3xhpf/TlN?=
 =?us-ascii?Q?5zsLqpC8U9c4HYLKKJ5vlE/hQELb6C9ICIZvGexjJwjT0DbWpEVjgCpIfGsc?=
 =?us-ascii?Q?WpemHND5H1rVvXS7qsVBBAAmviT+TU0Nm3hdKhugPWbuFesZ3oAkoWKRIBcn?=
 =?us-ascii?Q?2UnGAtOL3FAmIPkplx94urA/wKU1z/ioYjd8AOu11r4DIPlCIRHkmUU+LUwL?=
 =?us-ascii?Q?Hs5GtmBpw3tUzF+WZVxCfygvvhZnx3z2NsZLHF5Mlj0XdgfDcKdVS2K8Prg9?=
 =?us-ascii?Q?z7vXK7sQ74B48ErPVYJygp2q/7mqKxZu0JzgMz9Esga+Ig0nUT32rhbNLb9A?=
 =?us-ascii?Q?/sJXInhO9FmRfbi7bYOp/ugk6/47oF0zcpcSDzFTi9ozKmtcTCbDdaVIVTez?=
 =?us-ascii?Q?gQhhLb7609gPPvPZIwukP/zDJrYcHQ8BH4Sr/MuNLK+Zmr4Jon37Mey53/fk?=
 =?us-ascii?Q?Ztsnc1GciSjoL3w=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(7416014)(376014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?DUBexxxtpUnGrCuTvjXV2BFAGJlyru4qjyR07t8lWl75XE51KIVDjbxL2u7S?=
 =?us-ascii?Q?+TKyuHgIg0My7L7apWipKG85DdIuf44dLghStl3c2L6thYZax2Gzvrx07Ukv?=
 =?us-ascii?Q?rLUeN0jejKpTB+sb3g5utT9Y1JupGzRbTre8ETBxDMbhOe+wJS+jI4P1tebM?=
 =?us-ascii?Q?ZxBlRQ0AmvA0UXR9rJ5krtdY2uAM1YSz9ex3ObT9V7t1WblGFYXyLgFpso8G?=
 =?us-ascii?Q?YESLnX3GGGgvqKtzhsOqnz1Pb/M4sSfaFjaZa9ISn8JVrw5gwLbQzRJX4n60?=
 =?us-ascii?Q?kq/nfFbkAw7xTygHko+UtZxoipjxqCPAGt1plBV9iLMzMkuDX9d2xmr5fZsf?=
 =?us-ascii?Q?FTJOw6pkW73EXY5RbIhAi5T9vA/eWqGY5cktwyZyJQAUc5lzN92HElsA3JKO?=
 =?us-ascii?Q?mTxQYw9fgx94yRc3iYKPu2og2EMNSAwBuVMni1JdLf5Xqx//l7inFeMzlL86?=
 =?us-ascii?Q?vKimQi5pzxSCyE96QHR+AwGIGkPAFRa7DKSFpvW0Ux4TURPC7AXwoOjkdQpD?=
 =?us-ascii?Q?7xTI8SU8iwn8VKITU66QlrwSd9kmfIdx/3J32WPQmwUsYIDXLXqGzQqzALS7?=
 =?us-ascii?Q?UdIwbrcTqEHi5SLj63SihmfID3O3ddk7kr8YQBhXkRG0bGr7bywhyCintgR3?=
 =?us-ascii?Q?iOeNGqt16sjSnUBEKA6FhqS0NQSwuEEIEitATCLWOBxumyQ8tgKQoMFWkKI/?=
 =?us-ascii?Q?Gz6GgWWdj5V2lLizzxl5stT/2jr6o0zoncfW2yJ8+0hdFpJgtkDtR2h86ibt?=
 =?us-ascii?Q?HTD93uEb8vPbhbdtjnaaA2QiiQnncKWMV+bxrtfRxMBsSNrZ8LJqG165OUx9?=
 =?us-ascii?Q?yi/o4CvUNB36g+gCt2kWcIBNXGsRlxPbTMYsKwCmN3hnOPQYzE1hqyPn/jeH?=
 =?us-ascii?Q?xorkEhOyey8vUh1bUPhcySjOf5EhTE5gHiT8wSnmEmbsL6OmzRNDa19SJq6Q?=
 =?us-ascii?Q?neM4PMGhBpE0HOQjFjTQF4wciC3zMbKmg5MncX5sLMAXSVHrCZmicGYB55R8?=
 =?us-ascii?Q?sBmlJS/tfm5Z8nn1s8Ik9ePfGBW2rYJuPlNn+vrAKZl+df3LpP59SbWkfHLW?=
 =?us-ascii?Q?k/hdb2IK6EY/J3GoLyToIyzPnawvBl3QFA3HKlysSuwFAQ1cjpBrPYOzKD6Q?=
 =?us-ascii?Q?3PBrwR3QT1oiTqTFIx6V2GLEVLIev9Ndr+T+A70PMbyi2/H6kCTB1omWXVTH?=
 =?us-ascii?Q?AP/5X9/JyBOV73y7Q0IifSpVW6OIe1UxkZ2IWhfKGHop1qLkzDYojPPLSs7R?=
 =?us-ascii?Q?f+2XYtS7ru5inFQKjdqQhYHEk+Yk29lMpx4eaQlICNThuC/IflXm7QG5aqQ1?=
 =?us-ascii?Q?7BZRk/g+VbM0d5WsKg4Qnh/2XneMfYxMYuDg7DOEzuqKf+SZw9mfy+EiE8kI?=
 =?us-ascii?Q?AHMhnh3I5SoFD03xMQLCKqWww0N3etRBuvnZAamzkxHfWT/RuTURnIwPwF85?=
 =?us-ascii?Q?zyIWTSexD8xD79lvsZ6XldLh1YSdKcDVExj9hmjaLTBcOyWZpKkgz7G+YKRa?=
 =?us-ascii?Q?cMqdTaRxRkPDiy2bbgbbRjZElHPpYbY8GQxYj4hL7wjZneGAKzHm7GHotYZY?=
 =?us-ascii?Q?z44GzypkrIesrShyMIprXybNb4w9ORB9DxdRLMCN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a22225e-9c23-466a-2890-08ddeb819d55
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 07:06:48.1875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bk/mkQk6Bh0w1VkGwc4Tu3Z7WEVU/qUKf/c52+WYA12QqiUP8zzAmnP8mL/BP7JzhD3iriJ19y22YcU5POnwxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7002

The IEC958 subframe format SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_LE are used
in HDMI and DisplayPort to describe the audio stream, but hardware device
may need to reorder the IEC958 bits for internal transmission, so need
these standard bits definitions for IEC958 subframe format.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Reviewed-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/asoundef.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/sound/asoundef.h b/include/sound/asoundef.h
index 09b2c3dffb30..c4a929d4fd51 100644
--- a/include/sound/asoundef.h
+++ b/include/sound/asoundef.h
@@ -12,6 +12,15 @@
  *        Digital audio interface					    *
  *                                                                          *
  ****************************************************************************/
+/* IEC958 subframe format */
+#define IEC958_SUBFRAME_PREAMBLE_MASK	(0xfU)
+#define IEC958_SUBFRAME_AUXILIARY_MASK	(0xfU << 4)
+#define IEC958_SUBFRAME_SAMPLE_24_MASK	(0xffffffU << 4)
+#define IEC958_SUBFRAME_SAMPLE_20_MASK	(0xfffffU << 8)
+#define IEC958_SUBFRAME_VALIDITY	(0x1U << 28)
+#define IEC958_SUBFRAME_USER_DATA	(0x1U << 29)
+#define IEC958_SUBFRAME_CHANNEL_STATUS	(0x1U << 30)
+#define IEC958_SUBFRAME_PARITY		(0x1U << 31)
 
 /* AES/IEC958 channel status bits */
 #define IEC958_AES0_PROFESSIONAL	(1<<0)	/* 0 = consumer, 1 = professional */
-- 
2.34.1


