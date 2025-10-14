Return-Path: <linux-kernel+bounces-851603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF69BD6DF9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 02:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5FE5C4F6A2B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 00:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D924C35979;
	Tue, 14 Oct 2025 00:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b="pu86x6Ah"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023076.outbound.protection.outlook.com [52.101.83.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FE0FBF0;
	Tue, 14 Oct 2025 00:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760401420; cv=fail; b=AD3SmS5OZyF2N2HBY0Tz63IrYkchgVmzn+RdNGy//yHWw9Xbq/d1c2igW/tvsydTAtnceLle3r//qD2NNYYriEpnvcvEB5C2PKpZkI6TSVEgmHj9rB5HWWoDW58ysziKlpFN+AHleaYd/uDdleOOB1dGTW/neANbaMRLlK4VxvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760401420; c=relaxed/simple;
	bh=uufJydP3mcLhLzAw2htYtnZtiBaBVntUam1eY4FwKZs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WYUL/yXrWBl6R32GfKeDyEK+tKFxsoGHiU18LxBIZ+f3G9xOToa+NDmAzAHDX/46WYAXqRcIiEImebnzsq5T2AAC3W2LoeKCjCG8+lR3mWU9Y2MjA+Kh6x/FZLrOZKiKj4J6NwTVCxXb0Tk9iz1UWWtdTyK2HIIj5pv9yf9lysg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b=pu86x6Ah; arc=fail smtp.client-ip=52.101.83.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TjmW25r5juOuDFN9PS1iFTFPJ04eAc7o5a6tt+eEHYyWVNeEhsZEhrwEASrXpg36R5bs52VMGqHIPckJLZd9lWgTsbhZL+EO5mEnEjViX4uYid6zddKawxSNJTnaN4m2BWBD9WwRFWLZfX0QPe+6fnCATC7zjz1AUvc5TVDB3nns+6cq90fEQr/NIVWJ/AUZdKpCPSAuSzbPcYeukOsN3wnbuN6UMp+OzAnbI5nd/M9rG+2VKyCLNOaOJsXssUAwZn0CW2N+CJe4kiFy3FqUgHXPdaGawLl5K+UnqPnX8srdgB6T4U/JKFM74uAhxv4ZwGDVcnmPliI5CNBDgB6Tzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Po+sPg3iRBdm/xK4kD4qr72SMpV78K/Gr58Q9zZ4UE=;
 b=Qsu6F8kH/FD1wHZ6hg3bPH1DFx/XPKNcO+FtimajTBx4DrxidKZRaT6wuT+ArH14HuZ3tzLLOZ1LHtYl4ao5x8azP1PK+ZZ3+K+490nzEccnahHG1wzEji8sUcKs/rIxDRFfwYGyT4XrJASj2P46XofiSVMz9XyPTuNBOkJT2jU87jzLUMOK9G4oIf8LDnHLdR7gLL05xTF/8/OTRTwA2CCffw0nzOq4EVn6J7IIMuMyXf1ZxYL1Hw897K1gAfA4EE3sSkYGn2SbG6aX5auuIC2sOK/KG92eynOQxTWisRtsTA/S2xlI0DVN9Yn1buYM8dvGOAAuRVX6uq1+cY7n+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=ti.com smtp.mailfrom=phytec.de; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine header.from=phytec.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Po+sPg3iRBdm/xK4kD4qr72SMpV78K/Gr58Q9zZ4UE=;
 b=pu86x6Ah+QQQcifxypCgMxZmCAOIsNfw08s8U2ql0XOp5CKKh8SfCsoA2bI0a18+A20JJGV8rri+IH4pgHNAG5XTvnYi+Tg2Czw95NgwtD5wPp3j0+ZJK15sSjrmpRiNe2eKIGHB6tGDxjWT6baptaHLiy6uVh2PWbCgkMO06nbThzMnBCn5g1C1NBC6uLPtnbEPIAJVgqoMK3sPnVzQIte9p9ENVvl3htL8BTbbVopqUT1djqmdVXvlKEFM60d3c7EyUyNNucOja/tnoH5CE+Me595CdeZRiW32oxQlSN91DP6bGJegw/H1vHKr7iWw77HHe11xNThmlEaEmu/bpw==
Received: from DB8PR04CA0026.eurprd04.prod.outlook.com (2603:10a6:10:110::36)
 by PAXP195MB1167.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:19a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 00:23:31 +0000
Received: from DB5PEPF00014B9D.eurprd02.prod.outlook.com
 (2603:10a6:10:110:cafe::d4) by DB8PR04CA0026.outlook.office365.com
 (2603:10a6:10:110::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.12 via Frontend Transport; Tue,
 14 Oct 2025 00:23:31 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 DB5PEPF00014B9D.mail.protection.outlook.com (10.167.8.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Tue, 14 Oct 2025 00:23:30 +0000
Received: from lws-haller-privat.attlocal.net (172.25.39.212) by
 Postix.phytec.de (172.25.0.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Oct
 2025 02:23:27 +0200
From: Dominik Haller <d.haller@phytec.de>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, "Tero
 Kristo" <kristo@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <upstream@lists.phytec.de>, Dominik Haller <d.haller@phytec.de>,
	<linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] arm64: dts: ti: k3-am68-phycore-som: Add pmic label
Date: Mon, 13 Oct 2025 17:22:40 -0700
Message-ID: <20251014002240.85045-1-d.haller@phytec.de>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B9D:EE_|PAXP195MB1167:EE_
X-MS-Office365-Filtering-Correlation-Id: 2478cdbb-d526-4647-d6d4-08de0ab7e6ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Thqw6ZV4XQxhh7CXebNVjDCSt04zcjWwMx6/TJnwTGBrgLvvQzMRefzihta9?=
 =?us-ascii?Q?DV6K+Tm3gMdO7OmaV0CYfYcRCRadEwylzBk82ou51bGECkMrWmDXTNgo9dpQ?=
 =?us-ascii?Q?TSSyo0ryTl8lTyZmaSWfkKyl35ItFiDiu97J8lkkLYMJIMR8Dy1G7rqXIDUg?=
 =?us-ascii?Q?2H4EzjJFRlFE+iTrkeUE9ZfJm9OeJB+Id1ALz+nj8touVvXQP3Nr6RSPHmuL?=
 =?us-ascii?Q?Wl7KVeWvltqhAxfmKxivpdyJ1XJvRrYiupF/hNdL/VkJPDFW0gLalR+cy1/a?=
 =?us-ascii?Q?SdT1mZQHbrVDDJXMgGjGrmC6DcPpYhJYVL6+E+K+m0XkTLtqsWerxD1vUbNQ?=
 =?us-ascii?Q?HVRgrU+LHJc+vvbOZgKEjwcTEF5FYUadqvjOAz11SxrfkZKyYmIgwpj5tCqN?=
 =?us-ascii?Q?fKnWOGFwVuVNy/9/aXHcPPHo6NV9NuhWSvOP2Hug4EQGK2/Y4IjkvFhxfE0Z?=
 =?us-ascii?Q?IcEvMXgftpKUuEGZNShER+5HXQNpmwkxTRSr1XiOlrA8ou+Su9R9avhHLnBP?=
 =?us-ascii?Q?wKzGWVg8jlxvuzLTRXIGpnGdBEAxo8Rsi6KrufypeJfLXMtyR+9Q+8jznRnW?=
 =?us-ascii?Q?QL1eEC1toecfmY0hFrCSK3JP4/nbt4IuVwUBFRvnfNz7/tSWIEaoQn+jU0c9?=
 =?us-ascii?Q?rwjWE1Qg6U8QstLfgW+XzM4Csg0dH2cbGryO3pU5XU0XoX+xKUdBtsRgQQjN?=
 =?us-ascii?Q?LshufxkbydMi+A6WdccL5lDNTQZ9JnMExBdQkHOgnV6R4ia0T1GPotn94X+Z?=
 =?us-ascii?Q?YBh435dknk7I39IsR46nzH+/9SkekrZwu8RVqEtlag8M3YD2rI7iwHJGXlIO?=
 =?us-ascii?Q?dj3I/1hEPQuANzsxtTXdFZAIfgQJymFr0n3XOELE6yvuf2dIdNrTJbAkwWIs?=
 =?us-ascii?Q?AA7IjCWy4jyR9ujrcrNv6oCV/jRbKgqgGlqrd5D7xmsZY57636B2XGV6nD+D?=
 =?us-ascii?Q?CG2WoQzH31apGtltaaxT2PyvMNugd0EDgqUll0vbEUA/zVNdgf45B22lG/VH?=
 =?us-ascii?Q?ddYBCTwQi9vUb9nFTrqoi8314+YJNhDXXsziNtSQIWa/Zbn1Ful+6A78i7BY?=
 =?us-ascii?Q?ac/E7A/cK2FDLKhWDKOw3RqU31nddfCetA4Ix55uehgGUMrepN+Q/wxKiz32?=
 =?us-ascii?Q?lBdVVellqHhrSfximW/QX7jmAqQ4sXu40Krx8/OW8RH0wpxataxjGb0BnkxX?=
 =?us-ascii?Q?QX1jBwkFuPwo/YDl7Kc/gaN7kcRNb/EBIEo8gm9cE0gP4w7G22T6xmnjEuHa?=
 =?us-ascii?Q?UkyCUXah5sk+YigyZADf6iazZ4n0mW//Kj/mTri0T706vC6u1eD79hfyYOcY?=
 =?us-ascii?Q?RUPJPOeLdEVU0OW+JOEB7XZM1WizPBh0C4BqtbhRsIDpD8OM/WZaW9UICwoC?=
 =?us-ascii?Q?rPNNK0yXdRw//nLlAv58VUVFluZqDapqR5KqNg+Q8L7oLcpTjr3Pq2XJDhwn?=
 =?us-ascii?Q?otVp/x4b5q0uq2SufvmL4VJOh3bOOLnmmBLcpHHjht4bVD3Og/GbxTaL6EP/?=
 =?us-ascii?Q?cPNNUHXnlQXSW9jBP49hniuMFyxl51CJc///ZR3muP2HG8XLCJEPAVMuAkT+?=
 =?us-ascii?Q?yyY003BJX1Gmi/EN3FM=3D?=
X-Forefront-Antispam-Report:
	CIP:91.26.50.189;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:Postix.phytec.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 00:23:30.2145
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2478cdbb-d526-4647-d6d4-08de0ab7e6ee
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29;Ip=[91.26.50.189];Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B9D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP195MB1167

Add a label to the pmic node which is necessary to configure the pmic
esm in the spl devicetree.

Signed-off-by: Dominik Haller <d.haller@phytec.de>
---
 arch/arm64/boot/dts/ti/k3-am68-phycore-som.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am68-phycore-som.dtsi b/arch/arm64/boot/dts/ti/k3-am68-phycore-som.dtsi
index adef02bd8040..10a7eddcae4d 100644
--- a/arch/arm64/boot/dts/ti/k3-am68-phycore-som.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am68-phycore-som.dtsi
@@ -258,7 +258,7 @@ vdd_cpu_avs: regulator@40 {
 		bootph-pre-ram;
 	};
 
-	pmic@48 {
+	pmic: pmic@48 {
 		compatible = "ti,tps6594-q1";
 		reg = <0x48>;
 		system-power-controller;
-- 
2.43.0


