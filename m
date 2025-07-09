Return-Path: <linux-kernel+bounces-723988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2F1AFED45
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 17:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E32C5474AB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4CD2E8E1F;
	Wed,  9 Jul 2025 15:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="fHiaGe6e"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2135.outbound.protection.outlook.com [40.107.22.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC672E7BB1;
	Wed,  9 Jul 2025 15:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752073826; cv=fail; b=B3j3M0BoXJoHVLKnNVB5jYoDgWqs/rIA3x5gYpwnqUOoPWJYQ8sP5xo+Hi+izilGo6MncxgfxdQ+A8N/rEBazIxztbYy4MjUduWn0w6rXycIpDX9qPdlw68PS/EBQQTx9HNBCoRtpGP2f1m2buCsZH+q6xqFipuAkD4ak+4yvjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752073826; c=relaxed/simple;
	bh=Jje1HGvqkXSE2GFUrgAg7ou5ZSmtZhO6jLJq0RwIjRw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oZZ/573yiLKTp+KPyBlKobsEMGw2sRlgGep6Vbhzx24tLd/se33fPIKyCK4Evwnnzm/YP3+1kB54QG0uUBhyfXZb8QnxNP1U60Kig0Mx7cPTCLs0qRR80ARvBdzlp5A1IP9C0kwpWZPxN110yff+YSdZAH1qw6Fe7Chlq8RBKbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.fr; spf=pass smtp.mailfrom=phytec.fr; dkim=pass (1024-bit key) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b=fHiaGe6e; arc=fail smtp.client-ip=40.107.22.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oJ0k3tiupjzcTrwhiEvWS7vaD3BkK7B251KVya0nzE4vvjEk3Vbt19CSKYjjGfZu/JSr1y9XBJ+7czrJlx2NRpB1TIaFBATZnnBRFjo5pgK3HvKsrQOp7BE3V4jYYTKjnrqrEnE6SGLSNVsqgsBeWY6Y6lQsEMP+Htix/VIippJKrmXhjeAGYK3oDS4ubDB04xnlDX1FOHp7K4WsIpOs02fEzAnxUwpVONAKYxFgDhXkO/e5qmppNEYumNaClhMb16EpUVC1NvkcNBzvmxM/tG+BVv6ji8RdUZAzajbWrHGLjZkxO13Hicun5AYC/EqQ9FNkRJT5qTKluJ3+taylJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/GQP4wRF0C9Ayuoe88iWNVNtaLSpaAhjrkZfGNetWnY=;
 b=KHTWO7xVYa1tyJZwNqUvnl+qWU1wfGmypSI57cLgXab5tOq7OOFlTwbBMOWvvvtniK4wqcLAE92HODN+z1E6/EgUmi2E41wjdcwaUkXLDIHhVuxN+l7Lot6N03E2WA01cjcgl7kHpbPtVfdgwG5ss58GPDGYxUuGapUTNYqmpg/INhMTOyN+MiE0QI5NhmHMJZlZMdnm6zkLRiNEPD+iZDFicwT6NVhLLWqzkKdJAhc185YxWKnVhuKAHoGo0pVAPxHJkRzFgTMwPH1c2KYnBrweDWcXFnDMBbiFAhmmD0D0Qkf7Jx5QNyXAhZQvs7PpA6I9wzxUY4YVSTO9NsmXEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 91.26.50.189) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=phytec.fr;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.fr; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/GQP4wRF0C9Ayuoe88iWNVNtaLSpaAhjrkZfGNetWnY=;
 b=fHiaGe6eEEmN/TChnsze4ikIn0duMe50J7caNQx8JHE2ztpNFmPMfpj+VUjamfVN/qjy8Tg6PtT7PxLz3hj77509FDWAzuTdFNLERPPZk2F1Ig5p1ChBG794yez5GpxkoUVA+Xi5fovF9kEdXi/a5ydTD0y3Tls9iF4/SP94We0=
Received: from DB7PR02CA0003.eurprd02.prod.outlook.com (2603:10a6:10:52::16)
 by DBAP195MB1018.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:1c7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Wed, 9 Jul
 2025 15:10:19 +0000
Received: from DB1PEPF000509ED.eurprd03.prod.outlook.com
 (2603:10a6:10:52:cafe::f0) by DB7PR02CA0003.outlook.office365.com
 (2603:10a6:10:52::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22 via Frontend Transport; Wed,
 9 Jul 2025 15:10:19 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.fr; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.fr;
Received-SPF: Fail (protection.outlook.com: domain of phytec.fr does not
 designate 91.26.50.189 as permitted sender) receiver=protection.outlook.com;
 client-ip=91.26.50.189; helo=Diagnostix.phytec.de;
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB1PEPF000509ED.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Wed, 9 Jul 2025 15:10:19 +0000
Received: from Diagnostix.phytec.de (172.25.0.14) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 9 Jul
 2025 17:10:14 +0200
Received: from idefix.phytec.de (172.25.0.20) by mailrelayint.phytec.de
 (172.25.0.14) with Microsoft SMTP Server id 15.1.2507.57 via Frontend
 Transport; Wed, 9 Jul 2025 17:10:14 +0200
Received: from pc.home ([172.25.39.2])
          by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
          with ESMTP id 2025070917101412-212 ;
          Wed, 9 Jul 2025 17:10:14 +0200 
From: Christophe Parant <c.parant@phytec.fr>
To: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
	<upstream@lists.phytec.de>
Subject: [PATCH v2 06/11] ARM: dts: stm32: phycore-stm32mp15: qspi: Fix memory map and pinctrl
Date: Wed, 9 Jul 2025 17:10:06 +0200
Message-ID: <20250709151011.366537-7-c.parant@phytec.fr>
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
 09.07.2025 17:10:14,
	Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 09.07.2025 17:10:14
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509ED:EE_|DBAP195MB1018:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ee9cb31-08c2-45ac-3281-08ddbefab7e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r35Cni6xYYgYUrIvGFw9fokWLaBa5otAbB0ElL06Casu8nFqOOEpcqmpkFOT?=
 =?us-ascii?Q?juvPojExM4XPBXce2tkPSnSgzc9DSLfZfFTamnCgjnOZ7C9xPnGos+ZM2PA4?=
 =?us-ascii?Q?yP4y5i6OS2iNP6ldvRPo4NhhPPfUo+j6GRi7xCuXHGRqzYTCWIYBd1zm6ui6?=
 =?us-ascii?Q?l8uRQg84SIWEgmfpCix3qe5xGJjLS92HPDm1F3TmUgdFap+GX7jmfMgbLSAi?=
 =?us-ascii?Q?YznBnkVA5DCdWp71OdfZIRUEQ7DsQ5pjPY/wH9Qrla3mqMzrhKrZgjGIeWta?=
 =?us-ascii?Q?y74qkV0cObCGhpc5SMe+GLHp3aATTe1xlsWqRNinrnLcxuAdPZ7/tuGHuAHk?=
 =?us-ascii?Q?YdcYKTSjrByfboF+v+IUPcsbmof74z/6+URdOW1GsuC/WgDb/t1+KhEeqYKV?=
 =?us-ascii?Q?tOWDrKKkYtdA/g2KeREiVv4JI9h9HM2gxsHXHRD4NP3ntM0VEobKY9Ht//LT?=
 =?us-ascii?Q?eN3ux/YaGGTa97rB5RWA8gIL1IHfMjG+5qrw5+GoUdDZwGtcjavIYvQCYpmH?=
 =?us-ascii?Q?rRmCgfA/V0sls4DSHT5cjOvn+7qkSCqHrHMIJSsKhz1AXKyEqbYqofyuwEdE?=
 =?us-ascii?Q?JQtx3JceHzw9R6tj0ID6WiAKqJ+tKIZGufTiYkiymxegSnFaEAgfUd0SChzN?=
 =?us-ascii?Q?A9VHNF4Slddh7mZ+2xH8aw7C4R/QlrYycCkaNpJzhUJAC/lTicMcBPTh+8K+?=
 =?us-ascii?Q?4C2bOv9WLQmkf6wXnIJHtqs9PQC7TKGtG0OFg0eFcQoy+kOBH3ELzBGkEeWq?=
 =?us-ascii?Q?okfLPvzMd+Oxv3dLIYa8Mit4GXSquWgv+JXR/9koB9FuolLdklqUAVX/Ofvv?=
 =?us-ascii?Q?kwfmF9eLDw9sexFTrRPL8+asBBi1KT9U6baHMSkObL7Oiw63NuGMu95jtmf7?=
 =?us-ascii?Q?HGlYZMJCcBv2em0U7xtFZyMIuzLp7N/GuNyUIHjr2uIfNOMFtfnzHKDMXAKz?=
 =?us-ascii?Q?lZaOKITu6L/L+1Ts5Q6bvmtjhZFHw4Un/TCsqkyWaVzGeTFB9Tmf1jCoUWAJ?=
 =?us-ascii?Q?I3M1WeObgFlQ6OMLWGc/Q1v/Lzv0aW1MUOEc1vINT4Q+1NlW+t/xHbp7Klj5?=
 =?us-ascii?Q?KhJf1+9lCOlZhklJMpLE45LNaRZFlGJXNj83eKoIS2/xH4/Hokfxeb6ZDRzM?=
 =?us-ascii?Q?61JiYQ+1+GjrxIYvk1GpvJFNcbJtvKNZKk49ozcLMI2QlxHXVshFL1lz4B/D?=
 =?us-ascii?Q?ZPKunwW6a0NsoNKxfioZ+siOQXMAQusLNs/fbRfzqsqsZMl5LNCDqeGEnKAn?=
 =?us-ascii?Q?GPfOm9b71x08M1lZoVpNCTVxHVz7xVtPSOdPMMLjqU9rhoj6XvIm342oLN+J?=
 =?us-ascii?Q?0u8PX2g7xqhFxjoo8QEt/wLfHLbg6SEQDlAzdsqimK4KXFUhi7rwyu79s4fD?=
 =?us-ascii?Q?GsvJ+UkONnOALiIG9Yn66uzqPypzsDrKxqU0mdddz5IWi19UuAX2c5yvgrBK?=
 =?us-ascii?Q?tSWQCbiayMihFoGoCMUcK/8v/gx8g8gJktaxiP4PHhzBnv8MU53o012dY4wo?=
 =?us-ascii?Q?mXOJjuU5Y5v7yMMC2lPs3NVN9b3ZAfKmu4Gn?=
X-Forefront-Antispam-Report:
	CIP:91.26.50.189;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:Diagnostix.phytec.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: phytec.fr
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 15:10:19.2371
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ee9cb31-08c2-45ac-3281-08ddbefab7e9
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29;Ip=[91.26.50.189];Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509ED.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAP195MB1018

- Add missing chip select pin group in pinctrl.
- Overwrite the memory map to the Flash device size (16MB) is necessary
to avoid waste of virtual memory that will not be used.
Without this modification, qspi probe fails because of ioremap error.

Signed-off-by: Christophe Parant <c.parant@phytec.fr>
---
 arch/arm/boot/dts/st/stm32mp15xx-phycore-som.dtsi | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/st/stm32mp15xx-phycore-som.dtsi b/arch/arm/b=
oot/dts/st/stm32mp15xx-phycore-som.dtsi
index 660cdc260963..72926c3de52c 100644
--- a/arch/arm/boot/dts/st/stm32mp15xx-phycore-som.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp15xx-phycore-som.dtsi
@@ -290,8 +290,14 @@ &pwr=5Fregulators {
=20
 &qspi {
 	pinctrl-names =3D "default", "sleep";
-	pinctrl-0 =3D <&qspi=5Fclk=5Fpins=5Fa &qspi=5Fbk1=5Fpins=5Fa>;
-	pinctrl-1 =3D <&qspi=5Fclk=5Fsleep=5Fpins=5Fa &qspi=5Fbk1=5Fsleep=5Fpins=
=5Fa>;
+	pinctrl-0 =3D <&qspi=5Fclk=5Fpins=5Fa
+		     &qspi=5Fbk1=5Fpins=5Fa
+		     &qspi=5Fcs1=5Fpins=5Fa>;
+	pinctrl-1 =3D <&qspi=5Fclk=5Fsleep=5Fpins=5Fa
+		     &qspi=5Fbk1=5Fsleep=5Fpins=5Fa
+		     &qspi=5Fcs1=5Fsleep=5Fpins=5Fa>;
+	reg =3D <0x58003000 0x1000>,
+	      <0x70000000 0x1000000>;
 	status =3D "okay";
=20
 	flash0: flash@0 {
--=20
2.34.1


