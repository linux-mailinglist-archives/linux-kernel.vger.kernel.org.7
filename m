Return-Path: <linux-kernel+bounces-829585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE01B9763D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 21:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69AF832231B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 19:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746AC30AAAF;
	Tue, 23 Sep 2025 19:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="g5K1aYKr"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013012.outbound.protection.outlook.com [52.101.83.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E563074A1
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 19:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758656728; cv=fail; b=t7GEzogkDaRQdtWSiqZBYHlgP5rTqMdsQ07346vgBtYx1QG6/aiZeZRwPjul6+C1CRrU3PorFt7r5QzurChGGXUFPGIlQsELqD91pxIC170nQXvr85Z7Y+Q6EQLNo19q919kcpcneCIQaECC4MuSWEODo8Aoh6T3ri+w1h4dBM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758656728; c=relaxed/simple;
	bh=Yog7sEmZ3ek0zQq82Q9n0z9i8640KCrCDp7aLICey2I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q4dOrMtuiad89+85yyam5/NoK7N/6sP1/Z3i7QvAIAX1RARJgwcUbZSoM7LcFEPagHcfm8e1STYwefbAkm7EF8YzXgWlhmyhnW8jPv3Um3Sb9umoCszpBUBCFW7LScKRh7lyj6AyE4slYRvalEkXEYQjLkht8tP32TPGfKy/8GQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=g5K1aYKr; arc=fail smtp.client-ip=52.101.83.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S4VJptKSFtlLvHCMTrbvrGlq+Te9V7UU7O8O5PZaVerQI1wKvk8PWdyNvAtacHqV/zPAM+jqajJ6fH9vvfIVrrECmpWOHNbOGeHikIFAYSbtMcpcvURhvdjaLpxD4Xe0ZetAOFeepdr2Ei69e92wlpDl+aod8QlO7OwGJosWqlAt54pvjDAAXywAeG359X8lbjLARaWGOqam3phVmFu+fqnkONI5obh00vb+xtaSoH778WirLuAmiXN1jGnWP0gUdzGgLEjAWNHCE1Mwa05zczlOSYynsrrXpbkHZLd8HhEC92GyJINuaJsMhOGGlpkUNNzyHiKCiWaM6uTYKAgoXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CH2GOBkptLNVCVz2LHoWY1iBHgDMnGro8vnmws9GYj4=;
 b=mMHhIQ/Ut/g10WUdWzNtKTE0yQIOiYaPYlWKf7ueh3EueGuatOmzhWnpiygkqK77RbFDYnfcYtSHUda9BpnqzpvgSoqXPqoMNPlsK7mhcNSfZCiVcIugJZpT+zb/wiDv1cbji1S1OTqbkx/1l9qm792pSlfxtEg8tEFQRYZLw2F3xV5DkTncc/biPs0X0pIQ1YnhLQuvehC1I1DzITrryyHXz4DDMDSJLpczhJm6SLXzR6vrLmLoKEm+kEBXzWfK4xHmfcsjDEj3dC0RL2eTcALPGImXIshJBHd8hafe725KcPdAgN/pDrdI7v2iIkL86LMZQlrqcWmDFCR4MFcLwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CH2GOBkptLNVCVz2LHoWY1iBHgDMnGro8vnmws9GYj4=;
 b=g5K1aYKruNi3wjvQdHs6fW8k83xV6ufoc7I46EJBHNxFEMMYX6pvDBpKez7ecgdnyVu7jEdWmNyfFoCPLkaRHyGrpvLpL7/runOXs85b27GjMkgqeWLib8wFWopPGIYA0wPqLrtUIlcvV3WBmMs+HkqKiF5b3IEMT1wvqWgcAiYGSyGbY+yPELQ+RdgR5rba7E+dmBBy1wkdic5Kl4qkquwT9RSh9R9BE5/6g6XSgSTL0LggaJORqnLQFNfn8NBKnmhp5uv1MSyX/sNB+/wZkno6kqwvJcHLe5QlRh0pa5gpMfAEjOjyRj3WlB7EkIrOU1HV4LAfS2TzqY2DyyKDrg==
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
Subject: [PATCH v2 phy 08/16] phy: lynx-28g: distinguish between 10GBASE-R and USXGMII
Date: Tue, 23 Sep 2025 22:44:37 +0300
Message-Id: <20250923194445.454442-9-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8a811841-86f0-4881-d28c-08ddfad9b6c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?V3gk4g98qSh3la1uRy8OcWcMdd6UX3k55wSwH2Y2pWoScfLjf8uEZ/qKMU7i?=
 =?us-ascii?Q?fp5PEnF1TVrq/+syMNetem6OXaiIhyC2KqczoYCi84l01wxGB/XCJWOJ67wA?=
 =?us-ascii?Q?T8MTLIHx/GpnxQUKU3Qr+k7fTTY+sdu6do5784w0rITDFEeTCHeXuy5Ailn6?=
 =?us-ascii?Q?Yl5rHmou9HSJPEdIpi3mQoqPCAUs7Yro5MmzyWnKg8ci20KK9cUw0wuTCO5Q?=
 =?us-ascii?Q?0BCwxpfBsCzgudwy0G0grlOYZ9Vxz9M6bXXDvT5YDQVf3y7SIXC6ML4l9szI?=
 =?us-ascii?Q?0nikTDqrbhkZ2aciIAs4FC5mRbbwnel29mG2iObzvxVDF7+0joVRMvV7tb1b?=
 =?us-ascii?Q?t0OAkX/RQcgtnZ1AQEkzQ8j9caZNSCNMttVVkCKATkzWxdvl8K91Pr/CIyum?=
 =?us-ascii?Q?Jk4GYUxx9NeKvH4qEK7qOpQPjaEFLwumLnjLFtLhmInspDj5XDHzEzk6kwex?=
 =?us-ascii?Q?Ums3mG651NaTJrfMvbrEXUoXQnc9LFfetIH8Ny1W42jMPh9P+AI/+tVCd2xs?=
 =?us-ascii?Q?wixHe2SQgiNzeJhN2vL+d6vhvz7Tuin2m54DwtM5qEeKPI2jQrYo3MPLB8vY?=
 =?us-ascii?Q?4Gd2a9iD5AzUNTq/rurUFlMaIWYvKWgfshYAzF7xerIcwr5dlTbsrhWIqbAr?=
 =?us-ascii?Q?gMMHblyEt0iuJC4BenRNJ65B+Xx9AhYwbdraiVo5dSFhBO8MiVt7a1l9MS+P?=
 =?us-ascii?Q?mbEuJnoBaxnHlHo5V0cUmyeG0gGWHO+5ladFMnHArhwwgBNHt3QO94Quv3P9?=
 =?us-ascii?Q?4Cpz+9jQH5ASsjotckaf3DSK1KxTARcHQlXM09Shm52EW8Rx2mHJ7FDXwBKj?=
 =?us-ascii?Q?G6DJDTfT2dNnNzNcd1iDdrOQjkMWyyJEOv80D0uT8cAMQWNnf8lOpo47yOql?=
 =?us-ascii?Q?NXcicH7TAq9ayq+DLql7bzU37qGJlk7WNoA2MKSjLZzegL1hWDRMAgoinuey?=
 =?us-ascii?Q?/VuT/xwcQoeAZgd+AvaVlBmcOsonKxJLp1n1P7Jcb2/YcZpdIAN8JQiK+8O4?=
 =?us-ascii?Q?fSTvPBPLXQ94AmVlpw6fQ0HX0oXHjWcgQOZ8Cpi1G+BACKwE749Vq5i8bl2v?=
 =?us-ascii?Q?OuWwt2bb7ZWLP1gS7aVez9Y87dhAdHjJethjB517xBjd7wW03d2m7ZLW3Db9?=
 =?us-ascii?Q?Plx+jWUilQkP2ynRIQ4KI9QQgyg34r4cQOJiVGEQBt5/0EyOz4CiOioJyF2E?=
 =?us-ascii?Q?D7UWxQBwHyZjALaw5MWNN53FbMOHse+8EARBeRClF1NMEDOU0AZq3URUtJEJ?=
 =?us-ascii?Q?X1YXNXDLXcFBUu2hDwJLlj8iyxF8CqNbGRlJLPS6n+/F/eQ3PSrUszZubKjR?=
 =?us-ascii?Q?9Q1fDmd3iBhhxJip4Q8d287lsacNDCvq7SFXU2QFrI2G9tlNld2rn/s322LJ?=
 =?us-ascii?Q?lLCuWdc5vbQt+iCR2NietW7au6McSoXn9DuaYWoQTGhwI9UeH59oD4QpZIXp?=
 =?us-ascii?Q?77ZXZ9wUz+MrY+px3TbLlCgGp8Dm7s90a9hPNU+mplt1EKXhi+F6MQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K8gJiec7hHu1aDu6cW03ZpTZGImtplhvqpklCh5LkAxNBp5w2tI8zroPfTds?=
 =?us-ascii?Q?RwjQ0+bRbOX4EW38wd2HAgJuYigJjAXNQKSzLLQ6+Xt8IpxjP0PwuZ6cr2da?=
 =?us-ascii?Q?6mKcfdEU4x47/xIWaaqwI78fFbqW0mi7xtMFZwq8yC9YJgJsl17w64EqHlNS?=
 =?us-ascii?Q?fmjHBjSNDsPW4iXSoUtyIwWxkg6S2fI7C6PQx5I58bE5vowqt1Y0P1kkdMYv?=
 =?us-ascii?Q?IkUz7k1yqCbEuKNG/TepsalMeXhjSc4NjdSpZcHAbgc6glA6QdzZKj+yZfvT?=
 =?us-ascii?Q?292FY7TATTCI6D0bCbG/7DyywuUIuI9QRGDtMhfU7/Sqcs8EgJSOxoOb3hzQ?=
 =?us-ascii?Q?sAdPYLt9LK30JLsl0DuBvBukFz94hWb5C7nFEtWem9EPPU7DWZxC8r8SDGRE?=
 =?us-ascii?Q?HwH6KwY7dTlhsmUbkGwkKh9zE2CYFn06EAIwid0Px4h8pwkU0J1HWtlEyCPN?=
 =?us-ascii?Q?ezYx42kAU2NhtwYoK8ga8kIH9a1lngYEbXagr0VoFBrEyIWIFjmma6U2toLv?=
 =?us-ascii?Q?GQELZi40lzEfAK2OQfjjf/pf959NkwUHSMUVKbnUgo9sqDyNZ289100rfU70?=
 =?us-ascii?Q?Gg2GDo9irRm6Uv+DamHKxFfexHZZtAtRwF9ylqwNkdRCemanYUQ7jslM90SV?=
 =?us-ascii?Q?1cux9V3H7jvz6WuTtRXkCgQv17u2CDczPeObIMwXwCupMNJd7hWCswqn/7Xf?=
 =?us-ascii?Q?+YMapA+iDmDotKvJAm3vPAz7WuCDsKpKVIdQ0ALjg4+XOd2qwJpXw61Pd2Dl?=
 =?us-ascii?Q?VSHfTN7/nE1crL69mbm7KvnTZ+2N3R4TG4EYlxsuslZqnpo6ewaWdnElPOmP?=
 =?us-ascii?Q?ilOexlIO1SpnxV8CKY4msN0JUgoIBFaU9Yiq8clDR5QZVnzjsB1toqu8gaQp?=
 =?us-ascii?Q?V4QoMQ0pEwa1z8V1iK95Xs3MTCQp6UVHTH7q3r1xWKXAk2Y3+txSrbAMrBlm?=
 =?us-ascii?Q?01OELijMMQwe3N/EnNVXPXZOjXCnJvm04gRsATDcWHvjyPEBqdh1VWHbWnUo?=
 =?us-ascii?Q?4iGHCSlyt4tMZBaHbXYjSsRXlngIJQMFL+yO0TVG1grisGCHH9E4iwo+IpwX?=
 =?us-ascii?Q?GqdULEFYCTmIgGpoxkQhDCj4UbXNSO/UgXggTXJPXiLCLECGvMRv6nYiAt8O?=
 =?us-ascii?Q?43OlbxGEXjaDLJ04YR3f0Uzvr5Op9uJhVAqeByx5BZibAgpAaiih31kSIiOm?=
 =?us-ascii?Q?Mh0ErQB5fqV87BLWvBxHsIcr1eG/i31fbXHNi/IjevY2ntngmLANLfVFRMpw?=
 =?us-ascii?Q?FXJ3zKx2PSEG6MZwSptCSUSn2SQyxoMRujurHG3C9LPhkQUL1cGqmvHXFNPM?=
 =?us-ascii?Q?BxaNvKEnsxaq8nkyHvyEfrYqn5M3wzvL7uXmSV4ifOF2y3b89YUN75FpQ64w?=
 =?us-ascii?Q?lCNltmdFTrNkz0xS8eMCVfZcc+uvvzG27ZYEVVUHgrB8wOTvV6STBsszyA78?=
 =?us-ascii?Q?iZtRhUnH48/stEIhJ3m7z8IEsIuIiBdhhlnMQY938lU9ZDHOJnJGwY+70Yrr?=
 =?us-ascii?Q?7FWKU5e537NhtzoxhCbBm90b0RFW4lCUCRZKzcLMcIbq/TpMnjtLPxAkbqy5?=
 =?us-ascii?Q?c613Ml/r9Nyon5vQuIPzcDnEdxBERsprCF2PVvXEf8rRbcqeKEtnLGywe71E?=
 =?us-ascii?Q?AQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a811841-86f0-4881-d28c-08ddfad9b6c0
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 19:45:13.9143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zPSIz+VyF6mf4WotVKP8JOgPL09euQGrX75x5Gbz6ehFJKbW+/cVZTZCdWDjckvYpMTuRn9jeJei2VS6lrN5EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7352

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
v1->v2: none

 drivers/phy/freescale/phy-fsl-lynx-28g.c | 87 ++++++++++++++++++++----
 1 file changed, 74 insertions(+), 13 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-lynx-28g.c b/drivers/phy/freescale/phy-fsl-lynx-28g.c
index 083c287c54c5..d27a46cdd86b 100644
--- a/drivers/phy/freescale/phy-fsl-lynx-28g.c
+++ b/drivers/phy/freescale/phy-fsl-lynx-28g.c
@@ -246,7 +246,8 @@ enum lynx_28g_proto_sel {
 enum lynx_lane_mode {
 	LANE_MODE_UNKNOWN,
 	LANE_MODE_1000BASEX_SGMII,
-	LANE_MODE_10GBASER_USXGMII,
+	LANE_MODE_10GBASER,
+	LANE_MODE_USXGMII,
 	LANE_MODE_MAX,
 };
 
@@ -316,7 +317,35 @@ static const struct lynx_28g_proto_conf lynx_28g_proto_conf[LANE_MODE_MAX] = {
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
@@ -413,8 +442,10 @@ static const char *lynx_lane_mode_str(enum lynx_lane_mode lane_mode)
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
@@ -427,8 +458,9 @@ static enum lynx_lane_mode phy_interface_to_lane_mode(phy_interface_t intf)
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
@@ -496,7 +528,8 @@ static void lynx_28g_lane_set_nrate(struct lynx_28g_lane *lane,
 		break;
 	case PLLnCR1_FRATE_10G_20GVCO:
 		switch (lane_mode) {
-		case LANE_MODE_10GBASER_USXGMII:
+		case LANE_MODE_10GBASER:
+		case LANE_MODE_USXGMII:
 			lynx_28g_lane_rmw(lane, LNaTGCR0,
 					  FIELD_PREP(LNaTGCR0_N_RATE, LNaTGCR0_N_RATE_FULL),
 					  LNaTGCR0_N_RATE);
@@ -594,7 +627,8 @@ static int lynx_28g_get_pccr(enum lynx_lane_mode lane_mode, int lane,
 		pccr->width = 4;
 		pccr->shift = SGMII_CFG(lane);
 		break;
-	case LANE_MODE_10GBASER_USXGMII:
+	case LANE_MODE_USXGMII:
+	case LANE_MODE_10GBASER:
 		pccr->offset = PCCC;
 		pccr->width = 4;
 		pccr->shift = SXGMII_CFG(lane);
@@ -611,13 +645,32 @@ static int lynx_28g_get_pcvt_offset(int lane, enum lynx_lane_mode lane_mode)
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
@@ -829,8 +882,11 @@ static int lynx_28g_lane_enable_pcvt(struct lynx_28g_lane *lane,
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
@@ -955,7 +1011,8 @@ static void lynx_28g_pll_read_configuration(struct lynx_28g_priv *priv)
 			break;
 		case PLLnCR1_FRATE_10G_20GVCO:
 			/* 10.3125GHz clock net */
-			__set_bit(LANE_MODE_10GBASER_USXGMII, pll->supported);
+			__set_bit(LANE_MODE_10GBASER, pll->supported);
+			__set_bit(LANE_MODE_USXGMII, pll->supported);
 			break;
 		default:
 			/* 6GHz, 12.890625GHz, 8GHz */
@@ -1000,7 +1057,7 @@ static void lynx_28g_cdr_lock_check(struct work_struct *work)
 
 static void lynx_28g_lane_read_configuration(struct lynx_28g_lane *lane)
 {
-	u32 pss, protocol;
+	u32 pccr, pss, protocol;
 
 	pss = lynx_28g_lane_read(lane, LNaPSS);
 	protocol = FIELD_GET(LNaPSS_TYPE, pss);
@@ -1009,7 +1066,11 @@ static void lynx_28g_lane_read_configuration(struct lynx_28g_lane *lane)
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


