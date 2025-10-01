Return-Path: <linux-kernel+bounces-838889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3608BBB05D5
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 14:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3971192704B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 12:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09552EB846;
	Wed,  1 Oct 2025 12:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b="NuWN8D8E"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023096.outbound.protection.outlook.com [52.101.83.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56F81D6188;
	Wed,  1 Oct 2025 12:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759322056; cv=fail; b=Mo7Gkk5d/cvy3uSDYjijs0x7hn6iUDi/h4QnGPNHqGsIy6atqZOIQI2PCDqb6tOWYR0Wir4k5OhibrW9MzdA3L0cEm4MgMVvwaRHOjz/Iokg4bHjK/nDpfV6Yl36hpQh8OAIUKPSbT9TmmF258tseJu/YbIKohZ0oHC1z9AhLCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759322056; c=relaxed/simple;
	bh=xZ2fldo5b3h4kduivcks9GO+p1/B5Rsab0pzYzukm3c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=mOGD/4bK/suqVdbxMIQR8KmtL04fJfhAH1YNZU87z1w8zUMQmTuCyoim6eSUxNOOjZZ2Cq95iF1BsQ50RxtfFiFJQd+Bi/w2sycFgdkt5qtcDtb9OOXeY0qbvEGFYSpeCb51+pDPPA4w98uHG0PThDcPKbEhdY+noezP3nfREpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b=NuWN8D8E; arc=fail smtp.client-ip=52.101.83.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OlhQnOYseDaU7c/39p0UxM8SD3UZctL2GSpd4QTlgSGsluvqUDo9hsbr3zUT1kg2xuKel8IrFjjwzy0inwGbYuAqSzW9tWce1pUwleYSubE0yL5wkGhZe+UicFKTmNzMeCFr9AVCnCoINtesREmu7ykPa19YhlPVKpaDc6ApBLDQ+70GofkkigMnByxunGfouOeEnHoDt75hKoMkbGJYBLx1N7pXtOZAIPpmenbBhZenWhpjXrK8eQns1332gC0pxlgpPvLlhcuQO3VdexgL7G/R+lHkk0jA9UWxpHbbvf6LGZ2cObCjIGEBNtVvgvZeGDxh4skUOYQuS2YY8Z/MvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=14JoJCs/qy7niqs42QE07hc6bbi77dYP7/7+PTqtSNc=;
 b=ccgAvHZg6LKl00GtnS+122GYMZUGvvW4jYj/Sjfir4Q/qNQ31ABB/UndgbA5DK2YOjg1bqreyhMDhTS2Gg9E84yaHpUnYWOnDnIBfPJxWBX3iWnvByl1QhICmNjYy8eqMcX9whMsUBvEoYD9c+3ZHaELwp9/xALmjaUvi19ZZoBC2O+ZQ8VWjlxTKbfMK7V6EDh41ni2//m8tsLqAzDsJUrE5lIfh3IEbHn/r74k9PhVHEn2y75uNHV7jEfoiwm71Otom4OsePWQlCJBkIE78hS8ihhBSxuWiwxccA00y/PlcJSML4O7rE7jdwazJAbtC1hSi/1z8+hGPXA4BT6aoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=14JoJCs/qy7niqs42QE07hc6bbi77dYP7/7+PTqtSNc=;
 b=NuWN8D8EmJvbNwwjVMR7ZzjLbOn9aRLobh4AiaIMGrHT2UO2LwAKU3JOHSG3uOCZBmyA7VyGdD4UmedCxcQQaS1c4Q/9rCaFomJhUW7VfJKQRftx1rOPW9LR+Izqw0DYAWJcdbrz3Q5rAfLz1K+7L5Kpm4amx9qQD/TCbWUmYS4YoNeqMtVjN2eDhI1T8lubQVttjXWQouUltXSZiDCuhFXzvRxbSx88iubGGDgBH+ZmdqYUUAHvi2VSCpE38BxtsbSbUVDwUkrNzZIJU+f3sOeZZVSFneenYT/4iBHqvVWkh6IDapKiTw45F0TD2NJj6RJ6kikvzZUN39EpNh00vw==
Received: from AM0PR03CA0026.eurprd03.prod.outlook.com (2603:10a6:208:14::39)
 by AS4P195MB1768.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:51b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Wed, 1 Oct
 2025 12:34:08 +0000
Received: from AM3PEPF00009BA1.eurprd04.prod.outlook.com
 (2603:10a6:208:14:cafe::55) by AM0PR03CA0026.outlook.office365.com
 (2603:10a6:208:14::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.18 via Frontend Transport; Wed,
 1 Oct 2025 12:34:08 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 AM3PEPF00009BA1.mail.protection.outlook.com (10.167.16.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Wed, 1 Oct 2025 12:34:08 +0000
Received: from llp-moog.phytec.de (172.25.32.44) by Postix.phytec.de
 (172.25.0.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 1 Oct
 2025 14:34:07 +0200
From: Yannic Moog <y.moog@phytec.de>
Date: Wed, 1 Oct 2025 14:33:52 +0200
Subject: [PATCH v3 2/4] arm64: dts: imx8mp pollux: add display overlays
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251001-imx8mp-pollux-display-overlays-v3-2-87f843f6bed6@phytec.de>
References: <20251001-imx8mp-pollux-display-overlays-v3-0-87f843f6bed6@phytec.de>
In-Reply-To: <20251001-imx8mp-pollux-display-overlays-v3-0-87f843f6bed6@phytec.de>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <imx@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<upstream@lists.phytec.de>, Teresa Remmet <t.remmet@phytec.de>, Yannic Moog
	<y.moog@phytec.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759322046; l=7302;
 i=y.moog@phytec.de; s=20250509; h=from:subject:message-id;
 bh=xZ2fldo5b3h4kduivcks9GO+p1/B5Rsab0pzYzukm3c=;
 b=xkzRGiOSnTl2E/jg9rFOcsq1A7D1lMA9BEXm9y2yv3kpp6AGkeSHxWriVPicFK6q2r79pQgFZ
 +AFk74uI8gYDzytgjQtZMI+zQIgPZvAbihfGeFfzozyiKF9GHA/hIl3
X-Developer-Key: i=y.moog@phytec.de; a=ed25519;
 pk=rpKoEJ4E7nD9qsrU/rfKVwMTWNWYaTBylZuJUXUiFr8=
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009BA1:EE_|AS4P195MB1768:EE_
X-MS-Office365-Filtering-Correlation-Id: 5be5e5b8-3231-4562-0e59-08de00e6d112
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OE9ybXdFbnc2YlNzMkVmVnBtVkhBcmRQaWJUUUtMVTloQnMrNHpmYS9IeWZP?=
 =?utf-8?B?YnBVL1U5Zy8reVEwNDM4N2k2R0p6Wm9UeTVSQm5qQXJQZnNaT0xrQlVwL1N0?=
 =?utf-8?B?dGNMaFdoRGp3TlVUd21GekpuRGVOR201R0ZxWXlBQWY4TWxYMVhmZ3ZEWWNM?=
 =?utf-8?B?Q3JMNURPdTUvSHhQMDVaSkcvNTlsNFVZUHNDSXVhOWp6djR0K1ZmeWNaUmFJ?=
 =?utf-8?B?TjM5bWJGRDNlalNsZDhPL2pmUEZ1aVBzcXd1cVp2NmNPZDdkdC96eStyb2N3?=
 =?utf-8?B?ZE12eUxlU1UwdlVyWDludWZVdzJKOUpianZjU1pWK2l6bnk5aDUydFVUcUV2?=
 =?utf-8?B?MlFqYkFvU0dXRVZzMEdwL2JIOFYzSi9HemxLa3JVbUJFQWlqd0gwZUExVG40?=
 =?utf-8?B?bHVRaHJWZERTWlVWb1JTRTFlWVg3WjRxd1Q1RmFVdkVxamg2NGVCMnI4TmRN?=
 =?utf-8?B?ZExFUThXSDQxK0tFUHFXMFZWbFk4VUc4eVM3S01LOHNtV0NtNlpnRXFRUThU?=
 =?utf-8?B?MDRHNG1hWTBTbzlqelZCdHQxYUF2WVVJMUtyczlWeWlQTG9UUUs1blU5Vncx?=
 =?utf-8?B?TmhuMU13c284M095bndtUWxwMUlncCtQVUIwWXZvZGlQcVdPNG9seGZTY0Q2?=
 =?utf-8?B?M3V4WGRjTk4zVmlMdVFkeTVWelpDb045Mk1CWFE1Z09VLzFRY1h6OTN5UE40?=
 =?utf-8?B?N25md2dJWVhNelhQd1grWEhMMStmeFI0THlIRXBkSUhla3psbVVYQ3dMamlq?=
 =?utf-8?B?NE5Nc2llUlc0dXIxd2d3ZFpUaEhrSldNNGJWT0dJVTZIeEl2Rlh0bTZucGtx?=
 =?utf-8?B?dzF5dnAzZnY4cE1FeW01YmYyelNKR1BBa0UxQ2hOc21ycEFLZU5hMWFqbzdh?=
 =?utf-8?B?Q1B3ejdSK0xpdUpRQTA5eWdyU25ZRHR3OUhqWlE5Uk8zM2VPLzI1L0o0N1VK?=
 =?utf-8?B?R2o4ZEN3SHNiOGJGL2h0SURZbjREK3loaVJ0ZG92anNFcXdIa1FKV1lIY1Ns?=
 =?utf-8?B?eVdJRkRiT0VsQjJEN0MwaVR3MmJZRkpvdmwzTWZ3SmZCS1RKWkQxbWxJOVpJ?=
 =?utf-8?B?TjB0ZUxNS2NkOWJkNlJBMkx6UjVtOFo1QkdlMXhERWprQzluc3VYV1hxQzhB?=
 =?utf-8?B?Unc4bnl5ci9Yb2s0eEdEUElPRFVMODAvdVF5SG5JcS8ySlB5QmRSeVh0cVNR?=
 =?utf-8?B?aTZJditCaGFpWER4WWRMRFY4U2xYenhtcGE2OFgxM1hlQUVnUWdEVlcxUEc1?=
 =?utf-8?B?QzluSGdnUjlMUHJiRFVhazRRL0VES05KVnkzS29SSXpRblpYaEZMd1hRQm5j?=
 =?utf-8?B?amQxczRVVFdYTjJRUW5kWkNOVldrKzFRWUxSRGw2QTBOZDBhRU5zU2FLUEdW?=
 =?utf-8?B?TC9VbWJHQ2JlY2c2d2JNbUllKzdrZERHWjVRb1dJOUdNU0xuYW9FTE9QVDdZ?=
 =?utf-8?B?bG9iN1JwN0wrNGZpVVFxaEhZSit5aVpHdWhMemhwUWxCQ1l4dnVYSmt6eDNC?=
 =?utf-8?B?aEh6R1RiYWkrTXZCc2Irc1ZtYnI2RS9lcHN6YjlURy84V2pocHhyTTBVTkwz?=
 =?utf-8?B?OGNDdDQzaEpIUXFjMnYvS21uSEdJNEc1RklscnlSTFZUYmJINkU1RnNXaWlw?=
 =?utf-8?B?N1pYNHluUU1RYVNjdUtyTng4WG1zYjVZcWQxT3lYT0hQS09aUGtudll5SXh2?=
 =?utf-8?B?aWM2WmpxQ3VUdGhhL3ZGZmltNXE4eG83RkNqS1dUNmdqUk9xbWUzc1ExQjZZ?=
 =?utf-8?B?OUVPUGlIZGRPTDl3TzdQak92YjFOdmZWbnJoME9Eb1FQUHd4b3lZRmpodHBN?=
 =?utf-8?B?djFqdWZQQ3JWVmQrZnhrNjlZWTJNRkZnbElaSjdUMzdmcldiZzZJYktaL0lz?=
 =?utf-8?B?alhJZ05VWHJMcTdzOXF1ZXF1ei81UWJ5VjczL1MwSG1yYTZiMStTamx3Wlkz?=
 =?utf-8?B?bW9XRzEzeDJJWHA2Q2NiaFVEWmVMZnBWai9XVGNEOXhRT1FPWDQzaDRmZ3BS?=
 =?utf-8?B?bS9EK2JYYS9wUXFTZHYyRHp6UmdFUzVwdEVwV0xnRDF2L3JmOEhIK2xRNGZI?=
 =?utf-8?B?djVjc01hdlYvaFlMRmE5clpCRURQY1hFQi95dnRHVC95N3pMYlBQYUZISXhF?=
 =?utf-8?Q?X0A8=3D?=
X-Forefront-Antispam-Report:
	CIP:91.26.50.189;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:Postix.phytec.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 12:34:08.2838
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5be5e5b8-3231-4562-0e59-08de00e6d112
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29;Ip=[91.26.50.189];Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009BA1.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P195MB1768

imx8mp-phyboard-pollux had a display baked into its board dts file.
However this approach does not truly discribe the hardware and is not
suitable when using different displays.
Move display specific description into an overlay and add the successor
display for the phyboard-pollux as an additional overlay.

Reviewed-by: Teresa Remmet <t.remmet@phytec.de>
Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 arch/arm64/boot/dts/freescale/Makefile             |  6 +++
 .../imx8mp-phyboard-pollux-etml1010g3dra.dtso      | 44 +++++++++++++++++++
 .../imx8mp-phyboard-pollux-ph128800t006.dtso       | 45 ++++++++++++++++++++
 .../dts/freescale/imx8mp-phyboard-pollux-rdk.dts   | 49 +++++-----------------
 4 files changed, 105 insertions(+), 39 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 23535ed47631ca8f9db65bec5c07b6a7a7e36525..805ab9e5942bc9e2b9776e92412f56e969b6b39a 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -218,7 +218,13 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mp-navqp.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-nitrogen-enc-carrier-board.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-nitrogen-smarc-universal-board.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-rdk.dtb
+imx8mp-phyboard-pollux-etml1010g3dra-dtbs += imx8mp-phyboard-pollux-rdk.dtb \
+	imx8mp-phyboard-pollux-etml1010g3dra.dtbo
+imx8mp-phyboard-pollux-ph128800t006-dtbs += imx8mp-phyboard-pollux-rdk.dtb \
+	imx8mp-phyboard-pollux-ph128800t006.dtbo
 imx8mp-phyboard-pollux-rdk-no-eth-dtbs += imx8mp-phyboard-pollux-rdk.dtb imx8mp-phycore-no-eth.dtbo
+dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-etml1010g3dra.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-ph128800t006.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-rdk-no-eth.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-skov-basic.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-skov-revb-hdmi.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-etml1010g3dra.dtso b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-etml1010g3dra.dtso
new file mode 100644
index 0000000000000000000000000000000000000000..7a7f27d6bb1be6364cbab5d2fe45a365c7680fa8
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-etml1010g3dra.dtso
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (C) 2025 PHYTEC Messtechnik GmbH
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/clock/imx8mp-clock.h>
+
+/dts-v1/;
+/plugin/;
+
+&backlight_lvds1 {
+	brightness-levels = <0 8 16 32 64 128 255>;
+	default-brightness-level = <8>;
+	enable-gpios = <&gpio2 20 GPIO_ACTIVE_LOW>;
+	num-interpolated-steps = <2>;
+	pwms = <&pwm3 0 50000 0>;
+	status = "okay";
+};
+
+&lcdif2 {
+	status = "okay";
+};
+
+&lvds_bridge {
+	assigned-clocks = <&clk IMX8MP_CLK_MEDIA_LDB>, <&clk IMX8MP_VIDEO_PLL1>;
+	assigned-clock-parents = <&clk IMX8MP_VIDEO_PLL1_OUT>;
+	/*
+	 * The LVDS panel uses 72.4 MHz pixel clock, set IMX8MP_VIDEO_PLL1 to
+	 * 72.4 * 7 = 506.8 MHz so the LDB serializer and LCDIFv3 scanout
+	 * engine can reach accurate pixel clock of exactly 72.4 MHz.
+	 */
+	assigned-clock-rates = <0>, <506800000>;
+	status = "okay";
+};
+
+&panel_lvds1 {
+	compatible = "edt,etml1010g3dra";
+	status = "okay";
+};
+
+&pwm3 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-ph128800t006.dtso b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-ph128800t006.dtso
new file mode 100644
index 0000000000000000000000000000000000000000..a39f83bf820490cf946849413cc968f9b0a86c96
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-ph128800t006.dtso
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (C) 2025 PHYTEC Messtechnik GmbH
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/clock/imx8mp-clock.h>
+
+/dts-v1/;
+/plugin/;
+
+&backlight_lvds1 {
+	brightness-levels = <0 8 16 32 64 128 255>;
+	default-brightness-level = <8>;
+	enable-gpios = <&gpio2 20 GPIO_ACTIVE_LOW>;
+	num-interpolated-steps = <2>;
+	pwms = <&pwm3 0 66667 0>;
+	status = "okay";
+};
+
+&lcdif2 {
+	status = "okay";
+};
+
+&lvds_bridge {
+	assigned-clocks = <&clk IMX8MP_CLK_MEDIA_LDB>, <&clk IMX8MP_VIDEO_PLL1>;
+	assigned-clock-parents = <&clk IMX8MP_VIDEO_PLL1_OUT>;
+	/*
+	 * The LVDS panel uses 72.4 MHz pixel clock, set IMX8MP_VIDEO_PLL1 to
+	 * 66.5 * 7 = 465.5 MHz so the LDB serializer and LCDIFv3 scanout
+	 * engine can reach accurate pixel clock of exactly 66.5 MHz.
+	 */
+	assigned-clock-rates = <0>, <465500000>;
+	status = "okay";
+};
+
+
+&panel_lvds1 {
+	compatible = "powertip,ph128800t006-zhc01";
+	status = "okay";
+};
+
+&pwm3 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
index 6110c6a484d3f0b427ad372e1bd16063d1ce165f..a12556b7d76c2fcafc7f25e2d50ae2d386ed48d3 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
@@ -8,7 +8,6 @@
 
 #include <dt-bindings/phy/phy-imx8-pcie.h>
 #include <dt-bindings/leds/leds-pca9532.h>
-#include <dt-bindings/pwm/pwm.h>
 #include <dt-bindings/thermal/thermal.h>
 #include "imx8mp-phycore-som.dtsi"
 
@@ -21,16 +20,12 @@ chosen {
 		stdout-path = &uart1;
 	};
 
-	backlight_lvds: backlight {
+	backlight_lvds1: backlight1 {
 		compatible = "pwm-backlight";
-		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_lvds1>;
-		brightness-levels = <0 4 8 16 32 64 128 255>;
-		default-brightness-level = <11>;
-		enable-gpios = <&gpio2 20 GPIO_ACTIVE_LOW>;
-		num-interpolated-steps = <2>;
+		pinctrl-names = "default";
 		power-supply = <&reg_lvds1_reg_en>;
-		pwms = <&pwm3 0 50000 0>;
+		status = "disabled";
 	};
 
 	fan0: fan {
@@ -43,10 +38,11 @@ fan0: fan {
 		#cooling-cells = <2>;
 	};
 
-	panel1_lvds: panel-lvds {
-		compatible = "edt,etml1010g3dra";
-		backlight = <&backlight_lvds>;
+	panel_lvds1: panel-lvds1 {
+		/* compatible panel in overlay */
+		backlight = <&backlight_lvds1>;
 		power-supply = <&reg_vcc_3v3_sw>;
+		status = "disabled";
 
 		port {
 			panel1_in: endpoint {
@@ -232,32 +228,8 @@ led-3 {
 	};
 };
 
-&lcdif2 {
-	status = "okay";
-};
-
-&lvds_bridge {
-	status = "okay";
-
-	ports {
-		port@2 {
-			ldb_lvds_ch1: endpoint {
-				remote-endpoint = <&panel1_in>;
-			};
-		};
-	};
-};
-
-&media_blk_ctrl {
-	/*
-	 * The LVDS panel on this device uses 72.4 MHz pixel clock,
-	 * set IMX8MP_VIDEO_PLL1 to 72.4 * 7 = 506.8 MHz so the LDB
-	 * serializer and LCDIFv3 scanout engine can reach accurate
-	 * pixel clock of exactly 72.4 MHz.
-	 */
-	assigned-clock-rates = <500000000>, <200000000>,
-			       <0>, <0>, <500000000>,
-			       <506800000>;
+&ldb_lvds_ch1 {
+	remote-endpoint = <&panel1_in>;
 };
 
 &snvs_pwrkey {
@@ -282,9 +254,8 @@ &pcie {
 };
 
 &pwm3 {
-	status = "okay";
-	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm3>;
+	pinctrl-names = "default";
 };
 
 &rv3028 {

-- 
2.43.0


