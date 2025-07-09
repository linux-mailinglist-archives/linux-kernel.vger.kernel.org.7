Return-Path: <linux-kernel+bounces-723989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94589AFED65
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 17:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BD204A1B3C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC812E92C3;
	Wed,  9 Jul 2025 15:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="VGod9Eqv"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2118.outbound.protection.outlook.com [40.107.20.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA632E7F00;
	Wed,  9 Jul 2025 15:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752073826; cv=fail; b=bF4FaIC4KzgZVEHsf4wUPnt4e3L6VGFmBI0xXO/HK/xzGkIdKcbo5z1QBUS92F15rOYHHdPtwvMkQat9kczMaQm1FTeBQMmd+6HlCZ6TGYjxCgsHEtHVXELlJeiwGKhzeMBJU1El+RG0ZwkKdDlpmDyrJT0+to+XGcNLJ1VJzdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752073826; c=relaxed/simple;
	bh=KYfd9NeM0NnbJufuXmV40N3UnLHSjZSOWynwDe5TiT0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ITLn50UW/mtcbzFB636BFpe/uUFbQbFjs2Or+MixHFrBWgsZ0iMDaGXig7Wl/M/SP8Z+v1nmiuZlYhzVts/1gyOSNbe4+JKtJMJD9mL5Yb/NYsusr8LP/koY6dndcVNdT7NwHtfVRXarlFLGc2COuXO2uWQCHcvPNAZVFg4w+tg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.fr; spf=pass smtp.mailfrom=phytec.fr; dkim=pass (1024-bit key) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b=VGod9Eqv; arc=fail smtp.client-ip=40.107.20.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pAeee3TD/CmiGhXwdsO+6iM+AhDnaPsZZUm0bsGwIriaOnXS8jfebjjhTy7t03kNkCwTXOo6fbJ805awH5CiVfsqsH6bHNqcLsEQ6JhuY9YZFKsJIZDD6TJcMplPdVwAR9W4TSHEbkwDh/2Vt88fRc0oo15VebcXJVqHfnAJ0jomTnmFxeRtqqZA5WBvOvgQ9FFJa7a+GWH9eJVlUWZV7WwLo88s59FUWbalH4GZiKejn+YzvVFwJslXBbn7X6vsJPOxefgkJ4YywlGhiC/NywhHE/WiGxXgWBL9n1H3fQegGYV0Kj2j6DSQx1fKzpSpTBc1Rrl/DKhdCFdhK0fP1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GlkBo13gAAMFxY69YUO/r2kEBTxBz8AgO2heyKDlsH0=;
 b=amv3G1COANIHk3Ngg/9/wm87QkMRkSljui7wqaaPYj5UvjyxH86HqBQ3zAVN8OrQhpyVrTKJosPzrFNrv9sMg8Nr3nR9Lf4GekScdsLvYQ9qaRBWQ4gpi+0353UriiGnmJTdjAJ3pvWqxM6fjWH8Yafx4Kz5Ah9tJN3ddXrYuWcaKrJT6M1gIWLra2zTE80ljtaGL40zMaW9fBFvN3WQT3x5eZ9YR3At0NpNiCpGu3RM/hsv2AT3RZGkxhnsL1VrHjfK/VZMut5KUlj1quPe40H+Ej3pzUj1bjVd6YHOZRAnrzA0f/rtRv/KOFnNuIkDFRRysaIgbG3F+QEmBNnP3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 91.26.50.189) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=phytec.fr;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.fr; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GlkBo13gAAMFxY69YUO/r2kEBTxBz8AgO2heyKDlsH0=;
 b=VGod9EqvkGgdqZBwGGO8vs0VcXTkD+kQtt7EnfPmVEuv2XPd4OZJDNwUns5uiA43zy6w6loAwWJs2kG5+Ogr8TXXzBwtxsr0DAOhMEWikpdnukvCEfRPjZXhiYTIfy4S3bObRd9EbqMvQ6cS4I/m5LoPI7VYIQ4CdX/CYBX15+Y=
Received: from DB7PR02CA0023.eurprd02.prod.outlook.com (2603:10a6:10:52::36)
 by PA3P195MB2815.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:4d8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Wed, 9 Jul
 2025 15:10:20 +0000
Received: from DB1PEPF000509ED.eurprd03.prod.outlook.com
 (2603:10a6:10:52:cafe::a9) by DB7PR02CA0023.outlook.office365.com
 (2603:10a6:10:52::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22 via Frontend Transport; Wed,
 9 Jul 2025 15:10:20 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.fr; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.fr;
Received-SPF: Fail (protection.outlook.com: domain of phytec.fr does not
 designate 91.26.50.189 as permitted sender) receiver=protection.outlook.com;
 client-ip=91.26.50.189; helo=Diagnostix.phytec.de;
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB1PEPF000509ED.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Wed, 9 Jul 2025 15:10:20 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 9 Jul
 2025 17:10:15 +0200
Received: from Diagnostix.phytec.de (172.25.0.14) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 9 Jul
 2025 17:10:15 +0200
Received: from idefix.phytec.de (172.25.0.20) by mailrelayint.phytec.de
 (172.25.0.14) with Microsoft SMTP Server id 15.1.2507.57 via Frontend
 Transport; Wed, 9 Jul 2025 17:10:15 +0200
Received: from pc.home ([172.25.39.2])
          by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
          with ESMTP id 2025070917101476-213 ;
          Wed, 9 Jul 2025 17:10:14 +0200 
From: Christophe Parant <c.parant@phytec.fr>
To: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
	<upstream@lists.phytec.de>
Subject: [PATCH v2 07/11] ARM: dts: stm32: phycore-stm32mp15: Add dummy memory-node
Date: Wed, 9 Jul 2025 17:10:07 +0200
Message-ID: <20250709151011.366537-8-c.parant@phytec.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709151011.366537-1-c.parant@phytec.fr>
References: <20250709151011.366537-1-c.parant@phytec.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 09.07.2025 17:10:15,
	Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 09.07.2025 17:10:15
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509ED:EE_|PA3P195MB2815:EE_
X-MS-Office365-Filtering-Correlation-Id: 862a1b3c-dc57-4d42-1a88-08ddbefab89d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/PW7/bUIHs0EVuFds6jt4eNVjsJg4KGieNzPgEWbq40eB7JKx5UJJxWNI5xo?=
 =?us-ascii?Q?B2shIIcMnnpDBt6OaYCAAw+EKLPQiudOO7UKnE11cGYqNZXmcVPvHl3429lI?=
 =?us-ascii?Q?auNFDtrvXe/4da4Edck1RIpujAs/yo5GgWCmmGxEYJmQ02WsZhjKmfHohg8k?=
 =?us-ascii?Q?caKW934p902QiBYIeGH/oKbk9zb1aGO+AFL+gaG1TfwK9R2SRYljqacAHp8W?=
 =?us-ascii?Q?9c+pEV0NQliShlxu0nccLMid7vngUsoYlCE5sEZAEcu4B1Nzqno/VLIaP1t/?=
 =?us-ascii?Q?IFpWnzryZkLsYP2QPzEw07aBSAA+v/AZezBLFDf7UolzX9A101gdpr0LhIIG?=
 =?us-ascii?Q?El1tl+wi2KdFx5tON+QJ5qAnTfSRUrHHRAQUaQHIeEOQG2FZZXE21uPPutaD?=
 =?us-ascii?Q?gZ/L7UEoJWJzZG3uTePcXC5MbAlObDddMfB3gf9ZLLICurRtGByaYHWwnyx6?=
 =?us-ascii?Q?JhHVXpQFY9ERPzqHKS80Bc0sJ7WuEHZNu+DFa1S89L7imHrIgKtKqbtweLzy?=
 =?us-ascii?Q?X6pPjugI99I7RWT3Kxxhmr55rmGGT5m26c/q5/qdOt9resVXBGtdeT3udFqw?=
 =?us-ascii?Q?gT1PIklgzRHKvjROeHBcx8K0yviLyDR6o5Zzz/WRZrYteFUGumOKQhWnxswu?=
 =?us-ascii?Q?2ZL2V+kIlDyRNc+i5BKCWljaeoAQi3cQf7SknzSDyH458zS+xP5P4jx5J89/?=
 =?us-ascii?Q?3wlVGuN7ieANlUZpZnPb2be/RHDU5yXH5qwy0uYC0Qv86Do+GjMjgSvzs6e9?=
 =?us-ascii?Q?QiuYzwMBdOGIViZtf61jgkSHCzAmWC2Uj51xZsZQqtkiUrQXQ8Wc1OXYS88x?=
 =?us-ascii?Q?eISGGin844knXBWPWpIb5mB1yH4l5/ryD1pLJYl+8Qx0hC7iVTl5rZWHYovk?=
 =?us-ascii?Q?MQ1BQ0rwYf3HQmkeAw7StBpzV+R56MTVhhvliSkndQ0FCCPH/QPUQcGAX0z2?=
 =?us-ascii?Q?eriFDTHY+gfbxXRy82RxRcCkZCvbP4XqFSyatBbN7R2sPPW2XzFLMWsChvvk?=
 =?us-ascii?Q?eIo1Eb+SM9QdyfOAO5waimfS6rPWMnso08S6xdCFhqgOd6p4AT5ffApEFFTh?=
 =?us-ascii?Q?GMH1KQ888boSIA+1w3l/ewoOx4GwG3x0+sWP/cgKS9cro4Wpw2ao6vVLHobK?=
 =?us-ascii?Q?jmKfNXDTmeSBOf+gHlP0xVyNNPSrDeFW4mf9jCDUJ6XXJ1pTYxjBqolLTO1P?=
 =?us-ascii?Q?qrCcprMdtrktJbQF3PNCpC6LWSKOAu2PETyXinH0RrM020mi0TOYC3KIoBcj?=
 =?us-ascii?Q?jorHWpPwI6NDmXE1wNOpmJGjHvxP3Rl+8L+JJTGsHreHIzU8cUQbwqSK3uz0?=
 =?us-ascii?Q?VB1BOcnld5wYdNxMC5tACUAShbaz4z3T7LPdAK7IL9Mw+BfrH2eg22lFlqI4?=
 =?us-ascii?Q?QqGKOzWdTzLFcaFszdIN56G2ge8sGvHk+WCpJz8LhaBzX3b6IJDfvu7RWk7W?=
 =?us-ascii?Q?oITGl0LziVvq+GyKrrM3b7Gd5eYnqZbVRzWC8iTUtbPT2bHUVCZsASuUhCaL?=
 =?us-ascii?Q?XczxFY9Zsb5C0tV9crX3OwtMO7zIGEzUrR63?=
X-Forefront-Antispam-Report:
	CIP:91.26.50.189;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:Diagnostix.phytec.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: phytec.fr
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 15:10:20.4160
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 862a1b3c-dc57-4d42-1a88-08ddbefab89d
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29;Ip=[91.26.50.189];Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509ED.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3P195MB2815

"memory" node is not necessary as the bootloader is taking care of
passing the correct DDR size.
However keep a dummy memory node with the minimum DDR size (512MB) with
comment explaining that.

Signed-off-by: Christophe Parant <c.parant@phytec.fr>
---
 arch/arm/boot/dts/st/stm32mp15xx-phycore-som.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32mp15xx-phycore-som.dtsi b/arch/arm/b=
oot/dts/st/stm32mp15xx-phycore-som.dtsi
index 72926c3de52c..ce859b94ae26 100644
--- a/arch/arm/boot/dts/st/stm32mp15xx-phycore-som.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp15xx-phycore-som.dtsi
@@ -22,6 +22,15 @@ aliases {
 		rtc1 =3D &rtc;
 	};
=20
+	/*
+	 * Set the minimum memory size here and
+	 * let the bootloader set the real size.
+	 */
+	memory@c0000000 {
+		device=5Ftype =3D "memory";
+		reg =3D <0xc0000000 0x20000000>;
+	};
+
 	reserved-memory {
 		#address-cells =3D <1>;
 		#size-cells =3D <1>;
--=20
2.34.1


