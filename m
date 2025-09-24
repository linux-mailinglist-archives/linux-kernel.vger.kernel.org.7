Return-Path: <linux-kernel+bounces-830685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CAA2B9A4BF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 16:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C68474A1FC4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA46309EF0;
	Wed, 24 Sep 2025 14:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b="Pya9pkes"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023111.outbound.protection.outlook.com [52.101.72.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B70307AC5;
	Wed, 24 Sep 2025 14:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758724776; cv=fail; b=hOgZ+H70ot1omTcel0fC+ONQ/CuOUNcpyrm+i+ZvO0NRdu4QBJT8tqvGY2hEGgRe8Vg7wR17alIA20bn8pUm4C8ThGX+fPEDx6cqcx2tC7K3ZVPQv0vwNaYSpz9RttRb/vye8ZrMAoeHf4m3rPBDoU0yIMjflQPQL9r1eLu9Qg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758724776; c=relaxed/simple;
	bh=F7qJigDfB1c65gJMfu7ALAMf5A0f8eBNjCwElbOx+bI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r3KyG60+viHn+O2fgbjlOmntUKO+zzR/MW+KFnt5l8sMuATCxlCD8PS9prcEsBiJhP1Ew8ikYAdELsn3JxD4jRHOCbNq2/J1RA6hz1Vxr5AEPA6ZPLA0emCz1AWj7t5DtnwWYu15grxIy+vMsXBGHWZyjPi8YkSB4ZZXG3xC1MU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b=Pya9pkes; arc=fail smtp.client-ip=52.101.72.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HaFdOo5bse2pLxJPr5yGRB3RVFT7+v/c2ulfAmoafBF1Os/GjdknHsbM3/36qLTXR4msaw4RZcmu+rypGM6pPJ+4iTqLWwP22wl8ow2AEl7dfHr72CeHvvSxJ0Q5uQrSKW79Sh8x4KuvW9nwGouOt0oTNVLHh9rwq2NRvEB390cfOycBVvwLTpi5Hlr9DNByUdxttJlwg4OMN2Xri3iUWrHKnKhegMwNL9xwSfvvwJSudsjYNCy1Z61ClJ1TKPjcDYd3mwyR3vV+122Vj5KDUPbhIw530goem134/6/kggvTjwohaCEM4IAyiySnLxyeSpd1w1/KubqK+SNunD4/xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sMwDNDQccov9ePh20hmK0eImsq+z2gk5UTJS15+5le0=;
 b=y5qJRLHvwbA3tmBRG2XC7Rnpt979Fir3h1JE4pg4xJQ9I6nPMto2uL4Tl9/x5s8CKzjACAz0KJeXnRNqip/i5nxOM+KYykUkKNcYbHAzmzMOtJ+WyVjgVPVixGvQ1MZkaVkJrpSOR/0jHg9J4tT/yLAZK68FzaW3/s7lzoA+CTg7jTarcO6GlpWG3e8dSnKubGgXuVCgor7qGJDtFjDOWnMfylOHhKl7F3V8T22qOUroVH88TeNUdEMAYWsn/eBUzB3tsDS5D0AbQIADBqk/YrGKzZpl5BMoFAF62+Lk4nRELEgUCU8AbDxOEzQdZfvNcnSFHjyQBqddeEsEnf5p7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=ti.com smtp.mailfrom=phytec.de; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine header.from=phytec.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sMwDNDQccov9ePh20hmK0eImsq+z2gk5UTJS15+5le0=;
 b=Pya9pkes87mZYNlLwkmTl9tZ4Z+8fXZCMYAf3V9869s7z43tmHxp4HqEuR/j5wl60piCv0fEiqBDOudB9MmsafQqk+naVEbGL54gf3hf8DZKppjEDGdoS3ALfivgMAav6pgFbCZdBCoXTW/f6007379Mf1AAC9oXYKmMo3SFejkDGWV6A+vrGeK+Lz6x/gEdEe0fTTtDFyNBN2vam5HorAqTjQFKgc29i65Y5d2I3/bbrYARUd5kiTEXsbAeGEGERSCJdO8M6l9mIplOAFfKvh5r8+VNNZQeUOGvZ0wVQx2XSRlziKeKUzhanjIhRjgs5BWdL0Dtf4mGn1hqKQmgaA==
Received: from CWLP123CA0083.GBRP123.PROD.OUTLOOK.COM (2603:10a6:401:5b::23)
 by DU0P195MB2146.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:408::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Wed, 24 Sep
 2025 14:39:28 +0000
Received: from AM4PEPF00027A5E.eurprd04.prod.outlook.com
 (2603:10a6:401:5b:cafe::1c) by CWLP123CA0083.outlook.office365.com
 (2603:10a6:401:5b::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.21 via Frontend Transport; Wed,
 24 Sep 2025 14:39:28 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 AM4PEPF00027A5E.mail.protection.outlook.com (10.167.16.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Wed, 24 Sep 2025 14:39:28 +0000
Received: from phytec.de (172.25.0.51) by Postix.phytec.de (172.25.0.11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 24 Sep
 2025 16:39:26 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <aradhya.bhatia@linux.dev>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <upstream@lists.phytec.de>
Subject: [PATCH 2/3] arm64: dts: ti: k3-am625: Add OLDI support
Date: Wed, 24 Sep 2025 16:39:15 +0200
Message-ID: <20250924143916.2023919-2-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250924143916.2023919-1-w.egorov@phytec.de>
References: <20250924143916.2023919-1-w.egorov@phytec.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A5E:EE_|DU0P195MB2146:EE_
X-MS-Office365-Filtering-Correlation-Id: d206da9e-5f67-48b8-2c2b-08ddfb782a48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZK4TtSLwviku7nPsI2bBGEobzFh0ZD9ENc0/yRy/GNIU7AzK7kPISLJLRuPl?=
 =?us-ascii?Q?sBTpCiGgjssfyYiqYdYs7zBJkobPn1apTW01yvQ+n3v5vpUGaNXVZ/LSqjow?=
 =?us-ascii?Q?20abdNo6rb35Di0L67Ip4zeCsNjU14PnxUPS9oDdKYkLoxLGMq0Gpez//iqE?=
 =?us-ascii?Q?xWnh9SgD7WIbHi+Y9iyIbRQ8E0vcUiscWxksmRGKvIYqv0uSq66ZPycFr/Yo?=
 =?us-ascii?Q?2XsKDJfMM8rTgpwyhBkerUxvg8c4lH7HZcOHa7d92zBf8w4V2vp5iuwl//mY?=
 =?us-ascii?Q?u6ppQvfPRL2g24K/gWbyuXz1IUextXau3MIr3RsO5KsBvTlQH3hpBNP1espw?=
 =?us-ascii?Q?CZSjhiRaFYVKUTe1A6DhzeIimpCFhZTdHvpFSBpCxRmkTbdgqvFbySUicDwJ?=
 =?us-ascii?Q?Gb16gbt7Y9/Cmb14yzFUqahPrK4segI92A2da8SXvSKbaNC3rM9ERoGWZLda?=
 =?us-ascii?Q?kMglqjUGLetW0oMvxOl9t1jF97D8HxKC+0jmtnvPl360QEabbzc5xJCkiBEu?=
 =?us-ascii?Q?RUDNeCQ+Eq/OXPqYPwR/Xny/d1pkcrpgCvlwJ29T8bRV25jJpOIf3axJP638?=
 =?us-ascii?Q?OOzJVgeU6tX2CgII/GWVf2KXHnyWpndnH7ltI1OTxKJVtgTMSqRCxxj0M3F0?=
 =?us-ascii?Q?TaiP3x8W1mknQm6e/9tFGR7N+MwO8jDe+2hEgzQdt86s8O4K2JB08yOGeGR9?=
 =?us-ascii?Q?vYihLCGXXy6gTtySDxdR2Tqeh6reckM59BgAdoW40uhevIWOhxsRuT07Mo5a?=
 =?us-ascii?Q?icJDRbfxJNADmXdFrEq+pIa9KB/6e0AeO2ZA8oEEUjLWG3Kjgt3HFJb1y1dW?=
 =?us-ascii?Q?2fC/IDbdx2zrshy84o+MjBm4ZqPVVUU1PcN1lO2pQkIlhUOII5fuEuGk/VJt?=
 =?us-ascii?Q?BKBwB0xYpXdnEMudx8NnTgGGM2lw/0bFZRJRiaKtz52i158zrbi6bZOh3CnI?=
 =?us-ascii?Q?4UPSoROb+4qfDOp9szxbOctTYG+OE5Jvz+a0BlKd6pYphh+nqNsqHZjPbS+8?=
 =?us-ascii?Q?NRIA7J+PGbeIhkd9ONQEyzAlUIHfaHsnppKm5nJwQ1v3ULz/+oJSAsnuhRQJ?=
 =?us-ascii?Q?EJ9YQlbEedUJsPwxm7tI+uIth9FfqRBuAZifQEFRBVtV4fDmQsmmcvgx5m3a?=
 =?us-ascii?Q?DRMuMC7UjqmnfDgm6hVFYGTX7v2rO9Q5ctISODhtYq06RMhBdBhKty7lbWeG?=
 =?us-ascii?Q?Tmn+5Z4x5C0lVtqVc4sPwZH/LTw1j3fo47+w0B8Zv/2daE8yV3XHJteXXJRH?=
 =?us-ascii?Q?VMR51D4UsXybF1dSrCGWJ1VbhlGP3QzfIx9r8Dtsdne12vqTjjentUCvn7sh?=
 =?us-ascii?Q?4at8P368N0PwzDnTCT/HRPBGfP+L7Ru/S8rRLzQQJJW/KzC4h/VM07ajVufy?=
 =?us-ascii?Q?FVyJA83vZw8KYBPVtDOmd3NeTM5MmoD0nfydNz6tuQ3qUmv1PTI9dcm7PWpK?=
 =?us-ascii?Q?R/GL6py5NhzbOyKH1k97Us8rEz7ZGBy80XkPchXw9SIYb/q9B8+nnGJ0wfNn?=
 =?us-ascii?Q?X2y3Nw6ATIgs95T8RPGG1/Fp8J8faRizpifm?=
X-Forefront-Antispam-Report:
	CIP:91.26.50.189;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:Postix.phytec.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 14:39:28.0095
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d206da9e-5f67-48b8-2c2b-08ddfb782a48
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29;Ip=[91.26.50.189];Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A5E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P195MB2146

From: Aradhya Bhatia <a-bhatia1@ti.com>

The AM625 SoC has 2 OLDI TXes under the DSS. Add their support.

Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
Signed-off-by: Swamil Jain <s-jain1@ti.com>
Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 32 ++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index ffa485545a5f..fbb49d9c70af 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -793,6 +793,38 @@ dss: dss@30200000 {
 		interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
 		status = "disabled";
 
+		oldi-transmitters {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			oldi0: oldi@0 {
+				reg = <0>;
+				clocks = <&k3_clks 186 0>;
+				clock-names = "serial";
+				ti,oldi-io-ctrl = <&dss_oldi_io_ctrl>;
+				status = "disabled";
+
+				oldi0_ports: ports {
+				};
+			};
+
+			/*
+			 * OLDI1 in AM625 SoC can only act as a secondary OLDI, if
+			 * required, hence the clock and io-ctrl properties are not
+			 * required at the moment.
+			 */
+			oldi1: oldi@1 {
+				reg = <1>;
+				clocks = <&k3_clks 186 0>;
+				clock-names = "serial";
+				ti,oldi-io-ctrl = <&dss_oldi_io_ctrl>;
+				status = "disabled";
+
+				oldi1_ports: ports {
+				};
+			};
+		};
+
 		dss_ports: ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.48.1


