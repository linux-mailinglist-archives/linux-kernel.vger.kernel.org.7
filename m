Return-Path: <linux-kernel+bounces-892686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB0AC459D0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF4403ABEE4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0484301480;
	Mon, 10 Nov 2025 09:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RqbCwPBt"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013002.outbound.protection.outlook.com [40.107.159.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED4F301001
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 09:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762766592; cv=fail; b=Kah50RFA3735EdAfF1lNTiGawc3rkycbTh9IoZKmhlM0A4oFK/szjP/GJ/ECBd8XkjjHlb6YL/x/3l6DVK56EVnV1hwKtJmUjsARN0noGi4eHDi+04ArR0TCkHYEDt/9k4BWAEep7TfLMhum+jK7/1wrLQhn1B2rhz0AnvRrEdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762766592; c=relaxed/simple;
	bh=rHDZECrUIEuFjLry9YEcz32ndcWWd5LVIaOrOQdmN68=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TIF8oMUmVreShTmThsxZuhjOChguhGpduxaR2r8+i7yQ187XYxG5t7db255Am0aWv8VCZzHRho+IfokV9EbhP7OUO9e5swiA3w1nkhFZQaDPYN5vG0F47AR4tb2VoGPuOCLsxyhFvM1eRdeP818S645mx+mMhpwioRJnu57KO4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RqbCwPBt; arc=fail smtp.client-ip=40.107.159.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gmSknKr/4HD5Pln4dVTpA5afrf83OQIIAYVDvx9b4sqN3OeG+tVWm3QLudupB8CXZjlvuWBNI/dzkZ3IeUVqJyJAtIGC+vLWoccshybrNpRb0dD9W/bHJa/stIRilRa1QuqvmQzLqAAWqVb/p77q7tNe0QzPYFLPonbrNRdCWuKEgk441b7GdZTBmrY62L02arCcHXmL4gTxTSXxHOoHQzW2H4Talf5OfnPRkRTEtVE+M+9OCCsDyKjoX3nahgUoSwEE4LRHZeIB4wN9c3tc0kSmXIGiGPs5ajg14RsvzR9pOGW9yzzVJYJIwYXD/ugv6gEYkpZncgI1DySgMiEdjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NGjqiyGCOVa9I1+qK3Yhyc6X3lBUl+qW05Y2gaXYZ4I=;
 b=KZxWqoAp3OgLLA7uyZrlb3lpIPDV4wlXVOQGKBIf6OBXtf7UlQmuFRx15MzUHMiHzrfDk6aYyVssbn2H8jadoJ41GQzxar7HVqwvJbBZrCIY0+Ktpta+vtw6Nawx/v4pwrRYjzTz5ug8AG3MAUws7Hb2AEObL0hBNbnk06aF3MiIcrN/lx0D9x1LmofUuU1uZ2lhupAS7dalFZ+7D3WFuXd/VPr4Q/da27DwdlencOJIkeBXg6iarjD1XWmyy2jnwZ1d4HUnE5CayGu3ktesCOYqnoHT2elohTow3IfdNtSIRQyvelMEQjR+vayKNNBN0g/IQRhh990Nd08b+lwoZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NGjqiyGCOVa9I1+qK3Yhyc6X3lBUl+qW05Y2gaXYZ4I=;
 b=RqbCwPBtxwUO2Cy7PSY7VLvi4nDZkuDs1ac1CfhfZ+n+0NadKeOnPdDaBGfXJsNrRg3SX5jtyn5bu4xl9u2vbp0JszAKLKZFMp4bJiD5U1N3wiZkz4mrGwTOHDzk8RpzcAKqexGI/Vpa/yqCW/+waCNpmsTTXnMKbAwLNyHs80+c5IYZmsd8IbV7R7JcywDe4A7AYiIEJIFrsSmDS0poxfopWGKZTvbqYcwF82c1hUpdTMIRbMYagkRTMnQuF7uaCbKc2TISJJfktVonuPZCzcG0EGP87AhMM02W8r5hz0YjQJPcQW/pfTSs6NGD6VWibO3PbDEXXdOY6CDckRquZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PA1PR04MB10468.eurprd04.prod.outlook.com (2603:10a6:102:448::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 09:23:02 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9298.010; Mon, 10 Nov 2025
 09:23:02 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Josua Mayer <josua@solid-run.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 phy 07/16] phy: lynx-28g: convert iowrite32() calls with magic values to macros
Date: Mon, 10 Nov 2025 11:22:32 +0200
Message-Id: <20251110092241.1306838-8-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8cc4a35b-0afe-4eb5-d2f6-08de203abf2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E/OX3QGp63iEpeJ7+dGm7FlLFaUGOeGl9UYhzLo7M0/tRIM4EX04R1XZEayx?=
 =?us-ascii?Q?NSzzic/5VYtvEJR/gm/k9bsAVlVDB1RdJ3qK03fiJXsPUEMJnBdtWTCeNGUM?=
 =?us-ascii?Q?683flm0HA+fZASwZTqv7sEnO2H13oOnDuEQPf9eHyoykHEMSBamyQF72YFNR?=
 =?us-ascii?Q?H3nV4Tw1irC0YxqAfSF44jeGFU3GxLCcOLyn5gd3P26bdYEjVRy4R7kW0vza?=
 =?us-ascii?Q?VeZuGe50O8VvGF6Q8+vjvtAjPaPOWKh17JtyJkpDTDrvo1y7Qyt9rmoziqGQ?=
 =?us-ascii?Q?+uhAMW6FdmK9TyAx8kbM76gCG1k6ak7tE4EJcd+wBDudHsIw7M6Ngl1L8iL6?=
 =?us-ascii?Q?G1R5tptWUGM9HT60II37BYnE1CtikC0rQXJodkszg7wTjpCA0W5CPe/OuBJR?=
 =?us-ascii?Q?EXgeGpO1qt58Y2TQPwLOweXiR2evpyUgLXayHkkNYj0X7jpNYk2I8NJR6u8U?=
 =?us-ascii?Q?LQYknscHC29lAtRW5Judwdmtpyxow7hzn5r4T79J1nwxTvjhRhmfoQSQjh/D?=
 =?us-ascii?Q?ZLJRZpgUNLbmZmOuuLYc6O+pRXUl6soPnkHeeM+tXrB3mt0SuADozWTdXyNf?=
 =?us-ascii?Q?BvydGvTKvIM4IjTwCw6v7xgpk9Ed3v6z+2tGadHIHjuN2E7ra+ONUMdXKbdH?=
 =?us-ascii?Q?i/ZuXSMQMb6OLSmm1I7jdgY027UbqZE2qCa4Y2nXO9fhYg1DYj/6B6yPEusJ?=
 =?us-ascii?Q?O1MI8+lU/GonyGrFkN8QuophUCk4UvyDVptLPI/NbTnDJPk7oAk4bGYvhE1i?=
 =?us-ascii?Q?ByS2MPluVoW5vJqq9yTgj56iDDnfuIJwjSTUnXsrYc5nnZ1LJbYkCRak5LxS?=
 =?us-ascii?Q?xvR5KMlWb4+S4VTDq4svK18rGiSXxQsnHQfJ80/fJAR5w1sa2eSvRdorRrNO?=
 =?us-ascii?Q?ulaB+JGkAMHUaOtkBfzGX/Aoe5GkGQwL+5aZIBgRJA6ffzk0wUOmoX97ge9y?=
 =?us-ascii?Q?DD7SytjM+AE019AW8mShc1rce7xr5MVipWOa1Tm7JXgrS1dz4pJTCHYfRwnE?=
 =?us-ascii?Q?u8MCUAMiRTBFvLLlVKJEJA8iS0DQU3qYRHs6I3wPj/UhzruLoHEVDzkZP9kN?=
 =?us-ascii?Q?dFplPlRt8xnwDpp9aIRI6N3rwcNAhG8Du1LqKhJMPDn3QpF3i56RWAjid44n?=
 =?us-ascii?Q?MAFLHtbEwN4a/OeTysFDVq9nHPqOS6H1h8DgWRS5/mtHf6SsqMm1Xxdx+Y1d?=
 =?us-ascii?Q?Mm8aflX9gmeESGVXUB41WFd/oKxExWbzZbq7zJefOOR+kYma1LdhMNqQ1Euq?=
 =?us-ascii?Q?OdhlJaaTmxmLmpH7NNVJNcS+Q5jrUszYyWx2fMeLzLVIvqQPtXBOkFgHNyW2?=
 =?us-ascii?Q?avRtRgP3i3TUNwqoPHUYqfPaloBNhx2BeSuI6XaBksXNBX1fTAZ+Jc+Dg6Z4?=
 =?us-ascii?Q?p7ssNQsRXevkwApykTE1O3o/OBvCn6sdzR2cMgnC6RJpwgahrR1U6cH7Hldi?=
 =?us-ascii?Q?tolKv1yig7dpQtczCIJzLFfEZ1GPQqCFmueFDUcVD0O8rnfCXw9CJGegnkWP?=
 =?us-ascii?Q?DTHRfC4ztZrTLI49enNw95wZRjuQx2YCvD/e?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nLayOEs3wATeWo9CZC5qAnyC0relh77yBtA+v1BDL0UUVPl3Z6Nezt0dIz/Z?=
 =?us-ascii?Q?LvkzvLiPhR4IBTq7Fx73gyP8t7Gmbl7XSkUMwzuvxmPwOM4I6vnZXyshDQhB?=
 =?us-ascii?Q?Ly6nEmIslePCJZ35rfbr3wwW9mRDO6MdwFWyhsr/P3l9pHpb3K42JKY2cJOm?=
 =?us-ascii?Q?zEiWiExuPOBRcYqNDi8Kcg4qcg9BRnVx0T7s/XNiuXxhcHwqQHvYs5U+5QKg?=
 =?us-ascii?Q?4QyAVpwDwnX+jCZGSpNKZ36njtn/5eZPB1N6qk/KxleUkYV7bV6Y3jC9e+X0?=
 =?us-ascii?Q?8vA8ozm9cEUNFgGghdn4cV1gdc1O7+awaUO7FVRcImAeBx1tt6goWUV16fde?=
 =?us-ascii?Q?GBbsvAyzOh5V3TynQmxGPbGEjvACwFa9ettvzwqPE7niaKzm3L4GBswuN9Tk?=
 =?us-ascii?Q?zy4r7EqvISBf1hqrbtBbbH8lMUej4VkbgK6ZtvEnnXFxxMn+zuhi8QQveXvO?=
 =?us-ascii?Q?UGeFdylMP7Qn4aY6PVSmVGq5JEM8D/yDwuceeipabIHcsrGvpX/ZhWUs2mi8?=
 =?us-ascii?Q?VH81nmEMv/4GRUrwLFFEirqmRQwxs4YXOcGrh3YYGjU94s9aRDfsQbhFj1+m?=
 =?us-ascii?Q?o4IBwC0C6ehooMps+3R3DHxKsJ65XirnU1aWxePtvDDgVMjX8DIgP4ex4+Se?=
 =?us-ascii?Q?ilsblrtsZBIQ+80r9+pp/8iuXTI/UweYqsijI9krRgeR/jIAV3AqLcVxOD8I?=
 =?us-ascii?Q?L4AKTTll1xu1syl1ipGGIsMIHLROtkzhLoYACIbVbs9Olm1BkgjaP3h/vy1h?=
 =?us-ascii?Q?21OYnq+8nz1F0WWgA7RmoBVIzzvW9np6WdAkip1HalXAtLo8iAbu0lixtvw5?=
 =?us-ascii?Q?XgXIdORmtCmmEqYAlHFMBPUAZw2TChSTR3k/yDPqRLsHRsLekGkEPDHneSrI?=
 =?us-ascii?Q?P8ry4/AAcYQtDC9zfR8ProdX372SQrJ+A6jKfsotqlUvJbboZTVk+fCRMa0s?=
 =?us-ascii?Q?yBJsvEw9y33vQFJtRon2PWD2Uw6gV9wJ7O3wZALZ1xSSUJ04WU03eC62Cfs8?=
 =?us-ascii?Q?VBxIcC9d97AQBgw9J4gNZMdR2bezRHpinB8oloYy6REr+JhrFdzXHONtg/HI?=
 =?us-ascii?Q?8YCa0HJeVSr/UIpU7FrOT7anatIU734RIheAs4SIyqQakEUhk2fI/gB8c3ek?=
 =?us-ascii?Q?LkI2DRtsypTyj51BKN6oUvtPPzqV97u5l9i4m9m5aqvzl7oeuFqqwYoggLHL?=
 =?us-ascii?Q?cmy/blENW8tu5YP2gGdghRJRLnDKdxizgFBKQrVQR/FXHSOToePjpPsaLrL3?=
 =?us-ascii?Q?MDE12Z/d9ZiqLivC1CBfpIQTWJLcqF7PrMkegGCNbFi2MaGUnI8oTbWmPpq7?=
 =?us-ascii?Q?o1j+w3lwNd8baStgIXAt/lyAU6GnuzLnQ+yz+g9LYlngSpp7/bVvrKd8iyIP?=
 =?us-ascii?Q?WShBoOuTS8HSEsJ0b0W3kX2XA8cEAF7WibJdIS6/Ea4Ay4K4Btrlsz7PPPW/?=
 =?us-ascii?Q?vV/dELkL6RMSG1yKf0AuQL5c3e9npYKFlzx+Ygcrc2gtOQ8s4ixg6zyRBAMY?=
 =?us-ascii?Q?q3FUHciJXYjX38WW9StV9FGPekxB4iIwZjCPYuLE2azi6lwjCTk5z77Snfxj?=
 =?us-ascii?Q?SHUKVX0oBsUxQW0uSxwZVNH+OUHEZB41Ufm/XYfVutcO4pbvWiGi0dv0zvYz?=
 =?us-ascii?Q?DQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cc4a35b-0afe-4eb5-d2f6-08de203abf2e
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 09:23:02.2976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 64nXJziTOdns7Vv4jNQborhfmGElq5Rnfb1Iudai1dm8WV/8h8D9nxFvZIgaj7wLcb20CayhgyJriaDpzBZKJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10468

The driver will need to become more careful with the values it writes to
the TX and RX equalization registers. As a preliminary step, convert the
magic numbers to macros defining the register field meanings.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v2->v4: none
v1->v2: remove duplicate LNaRSCCR0_SMP_AUTOZ_D1F definition

 drivers/phy/freescale/phy-fsl-lynx-28g.c | 102 ++++++++++++++++++++---
 1 file changed, 90 insertions(+), 12 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-lynx-28g.c b/drivers/phy/freescale/phy-fsl-lynx-28g.c
index 4c699829026c..3b19b7d22b6a 100644
--- a/drivers/phy/freescale/phy-fsl-lynx-28g.c
+++ b/drivers/phy/freescale/phy-fsl-lynx-28g.c
@@ -70,6 +70,12 @@
 #define LNaTGCR0_N_RATE_QUARTER			0x2
 
 #define LNaTECR0(lane)				(0x800 + (lane) * 0x100 + 0x30)
+#define LNaTECR0_EQ_TYPE			GENMASK(30, 28)
+#define LNaTECR0_EQ_SGN_PREQ			BIT(23)
+#define LNaTECR0_EQ_PREQ			GENMASK(19, 16)
+#define LNaTECR0_EQ_SGN_POST1Q			BIT(15)
+#define LNaTECR0_EQ_POST1Q			GENMASK(12, 8)
+#define LNaTECR0_EQ_AMP_RED			GENMASK(5, 0)
 
 /* Lane a Rx Reset Control Register */
 #define LNaRRSTCTL(lane)			(0x800 + (lane) * 0x100 + 0x40)
@@ -89,12 +95,56 @@
 #define LNaRGCR0_N_RATE_QUARTER			0x2
 
 #define LNaRGCR1(lane)				(0x800 + (lane) * 0x100 + 0x48)
+#define LNaRGCR1_RX_ORD_ELECIDLE		BIT(31)
+#define LNaRGCR1_DATA_LOST_FLT			BIT(30)
+#define LNaRGCR1_DATA_LOST			BIT(29)
+#define LNaRGCR1_IDLE_CONFIG			BIT(28)
+#define LNaRGCR1_ENTER_IDLE_FLT_SEL		GENMASK(26, 24)
+#define LNaRGCR1_EXIT_IDLE_FLT_SEL		GENMASK(22, 20)
+#define LNaRGCR1_DATA_LOST_TH_SEL		GENMASK(18, 16)
+#define LNaRGCR1_EXT_REC_CLK_SEL		GENMASK(10, 8)
+#define LNaRGCR1_WAKE_TX_DIS			BIT(5)
+#define LNaRGCR1_PHY_RDY			BIT(4)
+#define LNaRGCR1_CHANGE_RX_CLK			BIT(3)
+#define LNaRGCR1_PWR_MGT			GENMASK(2, 0)
 
 #define LNaRECR0(lane)				(0x800 + (lane) * 0x100 + 0x50)
+#define LNaRECR0_EQ_GAINK2_HF_OV_EN		BIT(31)
+#define LNaRECR0_EQ_GAINK2_HF_OV		GENMASK(28, 24)
+#define LNaRECR0_EQ_GAINK3_MF_OV_EN		BIT(23)
+#define LNaRECR0_EQ_GAINK3_MF_OV		GENMASK(20, 16)
+#define LNaRECR0_EQ_GAINK4_LF_OV_EN		BIT(7)
+#define LNaRECR0_EQ_GAINK4_LF_DIS		BIT(6)
+#define LNaRECR0_EQ_GAINK4_LF_OV		GENMASK(4, 0)
+
 #define LNaRECR1(lane)				(0x800 + (lane) * 0x100 + 0x54)
+#define LNaRECR1_EQ_BLW_OV_EN			BIT(31)
+#define LNaRECR1_EQ_BLW_OV			GENMASK(28, 24)
+#define LNaRECR1_EQ_OFFSET_OV_EN		BIT(23)
+#define LNaRECR1_EQ_OFFSET_OV			GENMASK(21, 16)
+
 #define LNaRECR2(lane)				(0x800 + (lane) * 0x100 + 0x58)
+#define LNaRECR2_EQ_OFFSET_RNG_DBL		BIT(31)
+#define LNaRECR2_EQ_BOOST			GENMASK(29, 28)
+#define LNaRECR2_EQ_BLW_SEL			GENMASK(25, 24)
+#define LNaRECR2_EQ_ZERO			GENMASK(17, 16)
+#define LNaRECR2_EQ_IND				GENMASK(13, 12)
+#define LNaRECR2_EQ_BIN_DATA_AVG_TC		GENMASK(5, 4)
+#define LNaRECR2_SPARE_IN			GENMASK(1, 0)
 
 #define LNaRSCCR0(lane)				(0x800 + (lane) * 0x100 + 0x74)
+#define LNaRSCCR0_SMP_OFF_EN			BIT(31)
+#define LNaRSCCR0_SMP_OFF_OV_EN			BIT(30)
+#define LNaRSCCR0_SMP_MAN_OFF_EN		BIT(29)
+#define LNaRSCCR0_SMP_OFF_RNG_OV_EN		BIT(27)
+#define LNaRSCCR0_SMP_OFF_RNG_4X_OV		BIT(25)
+#define LNaRSCCR0_SMP_OFF_RNG_2X_OV		BIT(24)
+#define LNaRSCCR0_SMP_AUTOZ_PD			BIT(23)
+#define LNaRSCCR0_SMP_AUTOZ_CTRL		GENMASK(19, 16)
+#define LNaRSCCR0_SMP_AUTOZ_D1R			GENMASK(13, 12)
+#define LNaRSCCR0_SMP_AUTOZ_D1F			GENMASK(9, 8)
+#define LNaRSCCR0_SMP_AUTOZ_EG1R		GENMASK(5, 4)
+#define LNaRSCCR0_SMP_AUTOZ_EG1F		GENMASK(1, 0)
 
 #define LNaPSS(lane)				(0x1000 + (lane) * 0x4)
 #define LNaPSS_TYPE				GENMASK(30, 24)
@@ -104,6 +154,12 @@
 #define SGMIIaCR1(lane)				(0x1804 + (lane) * 0x10)
 #define SGMIIaCR1_SGPCS_EN			BIT(11)
 
+enum lynx_28g_eq_type {
+	EQ_TYPE_NO_EQ = 0,
+	EQ_TYPE_2TAP = 1,
+	EQ_TYPE_3TAP = 2,
+};
+
 struct lynx_28g_priv;
 
 struct lynx_28g_pll {
@@ -151,6 +207,8 @@ static void lynx_28g_rmw(struct lynx_28g_priv *priv, unsigned long off,
 	lynx_28g_rmw((lane)->priv, reg(lane->id), val, mask)
 #define lynx_28g_lane_read(lane, reg)			\
 	ioread32((lane)->priv->base + reg((lane)->id))
+#define lynx_28g_lane_write(lane, reg, val)		\
+	iowrite32(val, (lane)->priv->base + reg((lane)->id))
 #define lynx_28g_pll_read(pll, reg)			\
 	ioread32((pll)->priv->base + reg((pll)->id))
 
@@ -311,12 +369,22 @@ static void lynx_28g_lane_set_sgmii(struct lynx_28g_lane *lane)
 			  SGMIIaCR1_SGPCS_EN);
 
 	/* Configure the appropriate equalization parameters for the protocol */
-	iowrite32(0x00808006, priv->base + LNaTECR0(lane->id));
-	iowrite32(0x04310000, priv->base + LNaRGCR1(lane->id));
-	iowrite32(0x9f800000, priv->base + LNaRECR0(lane->id));
-	iowrite32(0x001f0000, priv->base + LNaRECR1(lane->id));
-	iowrite32(0x00000000, priv->base + LNaRECR2(lane->id));
-	iowrite32(0x00000000, priv->base + LNaRSCCR0(lane->id));
+	lynx_28g_lane_write(lane, LNaTECR0,
+			    LNaTECR0_EQ_SGN_PREQ | LNaTECR0_EQ_SGN_POST1Q |
+			    FIELD_PREP(LNaTECR0_EQ_AMP_RED, 6));
+	lynx_28g_lane_write(lane, LNaRGCR1,
+			    FIELD_PREP(LNaRGCR1_ENTER_IDLE_FLT_SEL, 4) |
+			    FIELD_PREP(LNaRGCR1_EXIT_IDLE_FLT_SEL, 3) |
+			    LNaRGCR1_DATA_LOST_FLT);
+	lynx_28g_lane_write(lane, LNaRECR0,
+			    LNaRECR0_EQ_GAINK2_HF_OV_EN |
+			    FIELD_PREP(LNaRECR0_EQ_GAINK2_HF_OV, 31) |
+			    LNaRECR0_EQ_GAINK3_MF_OV_EN |
+			    FIELD_PREP(LNaRECR0_EQ_GAINK3_MF_OV, 0));
+	lynx_28g_lane_write(lane, LNaRECR1,
+			    FIELD_PREP(LNaRECR1_EQ_OFFSET_OV, 31));
+	lynx_28g_lane_write(lane, LNaRECR2, 0);
+	lynx_28g_lane_write(lane, LNaRSCCR0, 0);
 }
 
 static void lynx_28g_lane_set_10gbaser(struct lynx_28g_lane *lane)
@@ -353,12 +421,22 @@ static void lynx_28g_lane_set_10gbaser(struct lynx_28g_lane *lane)
 	lynx_28g_lane_rmw(lane, SGMIIaCR1, 0, SGMIIaCR1_SGPCS_EN);
 
 	/* Configure the appropriate equalization parameters for the protocol */
-	iowrite32(0x10808307, priv->base + LNaTECR0(lane->id));
-	iowrite32(0x10000000, priv->base + LNaRGCR1(lane->id));
-	iowrite32(0x00000000, priv->base + LNaRECR0(lane->id));
-	iowrite32(0x001f0000, priv->base + LNaRECR1(lane->id));
-	iowrite32(0x81000020, priv->base + LNaRECR2(lane->id));
-	iowrite32(0x00002000, priv->base + LNaRSCCR0(lane->id));
+	lynx_28g_lane_write(lane, LNaTECR0,
+			    FIELD_PREP(LNaTECR0_EQ_TYPE, EQ_TYPE_2TAP) |
+			    LNaTECR0_EQ_SGN_PREQ |
+			    FIELD_PREP(LNaTECR0_EQ_PREQ, 0) |
+			    LNaTECR0_EQ_SGN_POST1Q |
+			    FIELD_PREP(LNaTECR0_EQ_POST1Q, 3) |
+			    FIELD_PREP(LNaTECR0_EQ_AMP_RED, 7));
+	lynx_28g_lane_write(lane, LNaRGCR1, LNaRGCR1_IDLE_CONFIG);
+	lynx_28g_lane_write(lane, LNaRECR0, 0);
+	lynx_28g_lane_write(lane, LNaRECR1, FIELD_PREP(LNaRECR1_EQ_OFFSET_OV, 31));
+	lynx_28g_lane_write(lane, LNaRECR2,
+			    LNaRECR2_EQ_OFFSET_RNG_DBL |
+			    FIELD_PREP(LNaRECR2_EQ_BLW_SEL, 1) |
+			    FIELD_PREP(LNaRECR2_EQ_BIN_DATA_AVG_TC, 2));
+	lynx_28g_lane_write(lane, LNaRSCCR0,
+			    FIELD_PREP(LNaRSCCR0_SMP_AUTOZ_D1R, 2));
 }
 
 static int lynx_28g_power_off(struct phy *phy)
-- 
2.34.1


