Return-Path: <linux-kernel+bounces-828969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1457B95F25
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 15:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33CD348387E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 13:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC28A324B36;
	Tue, 23 Sep 2025 13:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b="K1XuejZc"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020133.outbound.protection.outlook.com [52.101.84.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C84330FC3D;
	Tue, 23 Sep 2025 13:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758632968; cv=fail; b=V34PGnn+7aloUsTolnVGXxaFhuFcPL0XoG6rxBZ1tiWcZsQ7yjBUN4aK2MpRGLpe9AMNeMer7rEAP7H8DrufII8/OF2A1f9sbIlsAvoGk8wlnsoxd864IEPLHQVLBoywKO2X2r6ZEfw84C1955TW37eGUSqW/FmGpXpWtQ39yFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758632968; c=relaxed/simple;
	bh=UoF64wzFr4OEgMlSkrgbRNIGvqSWM6AZiYv24tB/Y5M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q2tWqTDYOYT6T/i7qDk3x43HEPyjO0lZtBe08j3+wy4V+JtYP6xwSAh3Jlhs3m8uLoho/bqUGn4lvJU4es9TRhI1iH+JSXMlz+Lu6ulqlxw2vCaQZlDAW7ndYOBKBJoj4Ww/h/ChoG8o//TxOL0PyzBFN93+Xh8XeRlK1FWPGZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b=K1XuejZc; arc=fail smtp.client-ip=52.101.84.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=htx1UMS47rRckcPwJrJptir+3uYW1JxLVesLeDALwvVShFjeR4CWcqdbi0d5N5MWNcMQA+sF2G40wmkJYPB49NoCxLMMNTl/Y7I7Ps9n8K+tI2jhdExockWKbrNy3nDeplje2eCVLp6ykJFTrnvfuN/Jgnsqqj0cfxFjWfwdhYv/4jMiHFWzZuq49xV3UA4lFQBOfDoi6uzFFRfYbGRbT5SXOkyb7R4Z4Fn/iqR8jRi6/7qn0jyJgLDhzIfum1pzZ94PEXkx3fotUKrCDa2jEEhCMliIL3UrVpsnynIe2A34uyWMs1cKDikI638n8GyF+k31yckIPwFHq9tDr2Wefg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U7JQEniHWNT+x93uSxXrGwu2CE14CqgGzYmtYLrCSyw=;
 b=DcVv342R3ohKjh4bj+TbJk79O6U2Dslz+oUf0KKR2qLKqZ4oNYYl3K0jnuyQmUiI8I7AyOPeyrcX8Or5TlD+Psy4t3mArprnq7BBiwCBCdqI1GqNwlUq9pPoKQ2l/Ewim8saJ6OE6D1XRjeoL+INSQ7qNpgUPPotUUNSKQN9RnR+HbM9tzPR5C5ftR/uUlrIteUgCLOkvAp72ctkpayMw9O+JDW1DE4epdpshp55ShN8cbMb0g7NOEfsSzgx9R9Gs5cpLmJoZrU8q+IkRj1b7FweMlO+RHKK0oa28JAM/9OusYgbQCjuj6m3QIQmeSMX1CcgPESPe/obc4PRqvwtxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=ti.com smtp.mailfrom=phytec.de; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine header.from=phytec.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7JQEniHWNT+x93uSxXrGwu2CE14CqgGzYmtYLrCSyw=;
 b=K1XuejZcUueReG00RgcGeuVFDMtlL1seVgxAa6JVjHi/OBedb3iJpkPxKXPUYTzrwK+hjnAznQHC9bYodpsUQLbQdyDdGYpvDpJYGoItDN7VCGVgX7JN75pt6dCTbJyegCFIvGiHJDb2TUENJqqGo9K2rwi0bDkAtl4l6jo5u+Dzff4HAqItxHL0XTvc9KkrvRhlfIJOQXOT+g1DKC7KOvGDzo4P4XCFJ2B3dCxc9gePilSfeF2aSJckP1ETCXsu4OCGx5c6uminAWVe9CYXKnx/cAE8m01OKk83mwiI5TN/2HLBPTRikn0nRz/iTfyusPkB1xvAyMDAUMle09ZU4g==
Received: from DUZPR01CA0114.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::13) by PR3P195MB0636.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:102:31::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 13:09:22 +0000
Received: from DB1PEPF000509EC.eurprd03.prod.outlook.com
 (2603:10a6:10:4bb:cafe::3c) by DUZPR01CA0114.outlook.office365.com
 (2603:10a6:10:4bb::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Tue,
 23 Sep 2025 13:09:36 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 DB1PEPF000509EC.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 13:09:21 +0000
Received: from ls-radium.phytec (172.25.39.17) by Postix.phytec.de
 (172.25.0.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 23 Sep
 2025 15:09:18 +0200
From: Daniel Schultz <d.schultz@phytec.de>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <upstream@lists.phytec.de>, Daniel Schultz <d.schultz@phytec.de>
Subject: [PATCH 2/2] arm64: dts: ti: k3-am62a-wakeup: Enable cpsw_mac_syscon in U-Boot
Date: Tue, 23 Sep 2025 06:09:01 -0700
Message-ID: <20250923130901.4110013-2-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250923130901.4110013-1-d.schultz@phytec.de>
References: <20250923130901.4110013-1-d.schultz@phytec.de>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509EC:EE_|PR3P195MB0636:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e49017e-49ea-4bf8-8a14-08ddfaa26956
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?62Mlb6SwOtn/gWURM+SoUjx0Pb0pigKrq1JPQ1NEq6LVF/WAf7Q+PH6fqnni?=
 =?us-ascii?Q?RefXpm2mS6IRCZW/Cab0s8Y9B3HkQuaXmQdd6jRP1mab0qMN6oke2DPMTCjU?=
 =?us-ascii?Q?YAvdJ3PJei6PMvqxWayRINVj2lb5VfM7yV7ml40Yf8O/62FHqcRz8quL2anX?=
 =?us-ascii?Q?M5xWnoYN1K+lzWdqC4l+Ve/wxG0Rjmx68YBKjCkpXV1vPgvQK903s+8UUEl6?=
 =?us-ascii?Q?sIUzLkHafpsaIusSTFqgLcm3lCPU4+hXVRYFeXiJTch7BOl0bZP23piVFsGl?=
 =?us-ascii?Q?Bka3RAWdytrHyOqJrMpViEud6Qnhs6QRUKxadudGFFRrzIQagirH81eA+x26?=
 =?us-ascii?Q?vsKnbplUlZLX9bl24DN765qs/BXc4qz7ee0/LUDcH4+YI1NV1aus9QYQQsV4?=
 =?us-ascii?Q?NSHw3JAwPyNfPZuxjpFegRNUol+lgmAqI1znIzFbcbi6ON0AuNA1ykzH0cR4?=
 =?us-ascii?Q?cAIaUWfyp7KEBLDgA7VGUY8xcKmbR4kRLGk4N+fTTf0UCldUCVM8FRAmezRj?=
 =?us-ascii?Q?LXTlTYnqssTQMy6atGfyPXfQ1Ul5hQpPjfs0vr8+PqS5ydNb7WLwG6SX/VAR?=
 =?us-ascii?Q?r4m8Spcj5YKnSb+oyoe6ONJjVPPKZVTbJbz5mNxtTHazJr/4S/DGs5+pVyxl?=
 =?us-ascii?Q?ss3A2BekMXO5ZVO3/dz3h96B3I4zXTVn2Gwta70ue8bNISLI+Pekvt9aksM9?=
 =?us-ascii?Q?JOw8iISfWfj0yFUSuNAYwVgYjD90e9DghZLVrIo6Rs1z2TrjIb8eSgweuxi1?=
 =?us-ascii?Q?lyU27yDmK4tSZl3DXNbwsaR1CodMj2u1oG6tg6Jsispxy2VrcIZx3YQgPHiB?=
 =?us-ascii?Q?y2fQpbyiICj228tariBdu910jBjFPOEnoRI8oBB0UwiZqGzHIdoXIAHRu73a?=
 =?us-ascii?Q?vC8sLbdC4p6QTEiHLwlDIY9knpZY28ktunCbmfEYD4qtRkESC3ak5qN3zyNU?=
 =?us-ascii?Q?EndaKQQeLA2Z+9VevZeb2F2lHX4OB4iOfbJe4t3NJuD14gafEqzqkww2X71d?=
 =?us-ascii?Q?BHAY2iv8wd9toSJ/EOO1HIFhuxzuMEnPMVDTruhtzqe0k0C50d5/VP2o3w/4?=
 =?us-ascii?Q?iTetXkP2nwLtbyFVNETd5kvnyE0QNzR3fKU2wQT4oLVuTmqiRg0skHkPuZxt?=
 =?us-ascii?Q?U6i5Oc9Z2JJddD8kPqE5GNhWB2MxOWyFmofNLMXMZ8DTHezgpi0rbRsxXqj+?=
 =?us-ascii?Q?p3ORTd1WpKp6mOu0lfWeCQMUzMY7yde7A6MSYqsQdkk2qdV0M3Y8nGOARzsB?=
 =?us-ascii?Q?b93O/tQSFJik8do/qSN2KyjqWndMfiwmyWpOYpziGRsoN5cs8nol8/a2MeY6?=
 =?us-ascii?Q?GOxtpxrtqq/SqLXxZXoK6fZgWEuBbjmZ7LsQ7s4VSRdLaVlzC8+mtWWVZiDA?=
 =?us-ascii?Q?HtYSn2qFgxPZs6Bh8KMjH2pF1WPWf88w911W4zvkZV6HATsoa5Cfh6r6KPO/?=
 =?us-ascii?Q?z9+jxgoeoEOLmOuumdtSDmB4zeRTm9Ob0DDsIuqRFZgDW70Gi8bCkdeWlBPk?=
 =?us-ascii?Q?FoNvgAvRJ8SiqwLUF4FdKzqnh7Mw6D4a7Lhu?=
X-Forefront-Antispam-Report:
	CIP:91.26.50.189;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:Postix.phytec.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 13:09:21.4696
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e49017e-49ea-4bf8-8a14-08ddfaa26956
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29;Ip=[91.26.50.189];Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509EC.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P195MB0636

Add the "bootph-all" property to cpsw_mac_syscon.

This fuse region contains the internal MAC address. Without this
syscon node enabled, this interface will get a random MAC during
network boot. This is problematic because the AM62Ax network
boot is using BOOTP protocol for some binaries and this protocol
does not support dynamic lease expiration. Therefore, the DHCP
server can run out of free IP addresses.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi
index 9ef1c829a9df..f29279d1e4a9 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi
@@ -28,6 +28,7 @@ opp_efuse_table: syscon@18 {
 		cpsw_mac_syscon: ethernet-mac-syscon@200 {
 			compatible = "ti,am62p-cpsw-mac-efuse", "syscon";
 			reg = <0x200 0x8>;
+			bootph-all;
 		};
 
 		usb0_phy_ctrl: syscon@4008 {
-- 
2.25.1


