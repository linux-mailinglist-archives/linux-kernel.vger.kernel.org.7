Return-Path: <linux-kernel+bounces-832162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2984B9E86F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A09B169439
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011E82EA16A;
	Thu, 25 Sep 2025 10:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b="Ftw2T6kh"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020113.outbound.protection.outlook.com [52.101.84.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C4B502BE;
	Thu, 25 Sep 2025 10:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758794453; cv=fail; b=tbYurKeK8Yhf50mpie2t7JPOhhfVXd8LV/F6B+8FLwedqZvQmHzUDpa5NsbEpW9c4xJj+mHaREuh735yx/SWSodncdnITIJ2mdKmXqnKENxwp8fopld+zz7pW3Jps470I/R3PHuBha9P8TeD6d7817Udry+x8CZQnho3V20++Co=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758794453; c=relaxed/simple;
	bh=/8LRvuvWESBCf+Rxvmn20jUyeSMsU3alEgajyWQBXCI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G9v/6hdG6FIqw1KEATumZOohT4n98NxOpPxDQ4CUJ7Eq/Qt2lg7tZa7N3l48LmmitFtDsVi3BVvGfu74UdxAanyRGtr8EN6/gjLxLoiF7pAewXhMlzPOATrbAMKPpHpuqhJbAFkHyVj/4PFfHj5t/BpnCWTrgc1jRtD3ZGRLnZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b=Ftw2T6kh; arc=fail smtp.client-ip=52.101.84.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hxE+Fc/hnc7ioBj4hbfiahQE01t4W75uawFZlsMk7WFuhYxHcCsB0zv5vx7sRvxq7tQkpsfDu9Vd+ITiUMgLNXg0FN4C4yro0tsNP8A/hQ8z5rP1Om5l5A9aPQaHmbT5J3a/wYVL4DyRalBu3jyyUfKWb9xV/AmLJkWp1mbKgvkLWAe0ROcnUUdhXtPmitT54T11ofH4AiHBWYThy3LTDnm+goMfa6DYUonUVEMpeHCfAwfKiUJlv61TZXB7Ycd2hcxx2E77CgShxL+mWKm6sOyGiWR6aP8yi+Ijammq9dGdd4tMZaZ1y20Pi+bucAAz5iHxv61/o2BfdpxQ4fpn0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HeZlF/gOTeCRetsrRlUANmOpsV0fCfSphWIX87QbBiY=;
 b=FcyLX0285ssrqO4VK7X4XpJ+Fls572EgWilzfNcJe5e/uE8gj8fXE/Rq8oelezrWfUtSCZll5RECvCCmtZIcVx7t7A7MGndNBDdbfrcGgUsJ+JtPmKNRQ1akeEAl6JP6EL+1fBo7ukdxPRYx7cNy60hmnughBUEh7X876Tp2lJfKxRA9H/S++oaodg91x5Ojri0Mg71UioLQkEFjFl00mk4cnbCaa2/eRbyoEHpzYyNGYEaES6oSle8z7fTEEX0KAuoE3G41TyGhgizKm+jiZmfNSselTC52EHj4OGIdTzUVOiOzD9p7Y7mqtCwKaie3m9AZC3nssnd8VJcnuyu1Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=ti.com smtp.mailfrom=phytec.de; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine header.from=phytec.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HeZlF/gOTeCRetsrRlUANmOpsV0fCfSphWIX87QbBiY=;
 b=Ftw2T6khLLEGsQhlFni5+HTKCxcqhAQF0itzTXPqlB1V8QwwT/w3/aQabdbqfW6mrW1BONLkY+q/bWjvXybhL2Hj6fy77f8F6u5p47wGJI6RKVUluZGURlDtcHY+qeqboaYRbFDx1KnNo2zcAzkTPNh6Pbq3facxZTHv8jXJ0e/GLFHKtC3J6iIoUasnwJtobItllh1MKTHN8CV3S/2fsJEO84FGB4pY7ECwg8xX2wuMABqXS1q41VIsYR29//p0s53CJY/2BamreOLzmIk4E2DfUL3TMnqoIn7tJm7WlZqKDl7lNk9imT+f0OsAzvp8YfMq72uJK7MNDJrXYiTSww==
Received: from AM0PR01CA0145.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::14) by DB9P195MB2970.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:5f6::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 10:00:47 +0000
Received: from AMS0EPF000001B3.eurprd05.prod.outlook.com
 (2603:10a6:208:aa:cafe::8a) by AM0PR01CA0145.outlook.office365.com
 (2603:10a6:208:aa::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.22 via Frontend Transport; Thu,
 25 Sep 2025 10:00:45 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 AMS0EPF000001B3.mail.protection.outlook.com (10.167.16.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Thu, 25 Sep 2025 10:00:47 +0000
Received: from phytec.de (172.25.0.51) by Postix.phytec.de (172.25.0.11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 25 Sep
 2025 12:00:45 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <aradhya.bhatia@linux.dev>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <upstream@lists.phytec.de>
Subject: [PATCH v2 2/3] arm64: dts: ti: k3-am625: Add OLDI support
Date: Thu, 25 Sep 2025 12:00:37 +0200
Message-ID: <20250925100038.3008298-2-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250925100038.3008298-1-w.egorov@phytec.de>
References: <20250925100038.3008298-1-w.egorov@phytec.de>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001B3:EE_|DB9P195MB2970:EE_
X-MS-Office365-Filtering-Correlation-Id: f5c393d8-5a14-499d-ae8d-08ddfc1a6669
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xHNhyqWzfmxX1bmfEEaaAr33054Afx3HnOfPjpavzVsPuqoOoOJ8nL6NOdup?=
 =?us-ascii?Q?sF2Kdgn67aeg2BWobJKWzWzyTl0jQg2CYOiaKwB7evep31T7eFTqrhDPFYHL?=
 =?us-ascii?Q?AvIiJAUJvo658YBpvkp34KDBq7dbhsvWA5T8lEd/JprAELUanucVWVfFw+sZ?=
 =?us-ascii?Q?ZGFhUJZ8e2N6g7UlAYd0BLQXRp0jKWS2DHU33XAKeU9SJ0R9FI4yvyheVttN?=
 =?us-ascii?Q?AaDPJ4aiDx/KYpkWIdSMZ/SkE8Wur65KJ6Ia0QNsPpfRbciFKMULYUWIgsfT?=
 =?us-ascii?Q?wBFl8Lsoj2mF+b9dQ6nySdr62YyhCxhHkDETi1iJwYLWhxp8lOv/9nOUrEWb?=
 =?us-ascii?Q?gTCLhMMhDUxZ4wF9hXjOVr3xmypmus1XR2n6T1ktIMJexiwYG20aMxUDykPT?=
 =?us-ascii?Q?dYUgh1SGzVjnm/vvsCj51C81i/wIshHrr0v72qi3iBEcMfEZG8W7p3ciRmZe?=
 =?us-ascii?Q?1fTVVIUBzJFD1FgGKNIdHXdw0oMVUNngOnXe7eYz2YbqY7voF0eRZE+j+gvm?=
 =?us-ascii?Q?tcHIAuMK6gyB8IJ9iEjND997cpz8PkpuXsKw8s+8jP4CAf/a1PQDHC00UDQH?=
 =?us-ascii?Q?ihc800SAu5TTZUYTZvLKyiYNIE1FenYRy/Mh3ZePTD7CEiBicJ67tYjVOJsk?=
 =?us-ascii?Q?Z9eyGMNkw2/2s6f+7z+u3laHrhzeN6Part5tAZmAvVklLrv9k/Ze1d4a714m?=
 =?us-ascii?Q?JnPNyKZdiEJz8sHYVnXD3mTd/giz7DsyyhjpITZASy8rCQCl/1K4sc/SoxkH?=
 =?us-ascii?Q?hAuCmOPwd5VPxis1PJ4GH/25mx0wB6r6UlIsiB5/37/YjU58ijAF/iDrIJLH?=
 =?us-ascii?Q?PlxJVLodTNHvGp+TILyjbgubMwmgvUqS6L3vA5rDTwIiQvHf6sizDCn6T7GV?=
 =?us-ascii?Q?H86mmsxVPoKr1vNXtVJBR5U4TueLrr6dFoa+Lczom85G6MYwkaAohI/vFZ7h?=
 =?us-ascii?Q?woDii7VAaPGJDKwqSkase0M+FjHywA3q3L2boujUwIvpaxaCVxtsxvMrf0YK?=
 =?us-ascii?Q?GYttOmsVFfvnsCvYZKXD3bxO23tGuu/vxVysKQK7tNGmEE5KnbOXnS2ed5zf?=
 =?us-ascii?Q?EQDGSC8hf4KOi4teiYBsjxZDl7vX/LlMgzmCZOsU+nCXHEWGOByc6rKf6/uH?=
 =?us-ascii?Q?14GH+J3OM69ITTrtOpdWcjUkzKltVk8gkBSL5OD81z0p+NggNt/29NPZ78qF?=
 =?us-ascii?Q?Z6tG9v6ZdpTcQbvj43hUek9jqHbw52csaGSFcHWNID3co5s82oXyQ38HA7/r?=
 =?us-ascii?Q?lDqbBfcB84rPGOve5lmOXZS4AOz/XAmsuF8ujvRVvtufkWwke+Qpb5a28EMJ?=
 =?us-ascii?Q?pGMYnZcfoZJyliJB+JmxRO3U3Cbu9huNo+xSRSZO+rZileOlEgk3Adv1DPYN?=
 =?us-ascii?Q?QWinnuTmVOlSfETD1LzCp08z4zQ/S61UVX2A2l6X3KGtDYku03yptAJ4rvpT?=
 =?us-ascii?Q?TzfkL3qIDNSWOkjC+y3gyDwpJaGc8FhX/GNUbrAuZgzoEdJdVdWxptUJe0NL?=
 =?us-ascii?Q?kFJa/Khy9pdlyg1O2f8doHD5m+mUs6zAFnD3q+g9/L/YT65IlRMilErGZ1JX?=
 =?us-ascii?Q?uRp76GpBKfSbEmOMZm4=3D?=
X-Forefront-Antispam-Report:
	CIP:91.26.50.189;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:Postix.phytec.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 10:00:47.3597
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5c393d8-5a14-499d-ae8d-08ddfc1a6669
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29;Ip=[91.26.50.189];Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B3.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P195MB2970

From: Aradhya Bhatia <a-bhatia1@ti.com>

The AM625 SoC has 2 OLDI TXes under the DSS. Add their support.

Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
Signed-off-by: Swamil Jain <s-jain1@ti.com>
Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
v1: https://lists.infradead.org/pipermail/linux-arm-kernel/2025-September/1065766.html
v2:
  - Add dummy nodes for ports to fix dt-schema warnings
    'port' is a required property
---
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 52 ++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index ffa485545a5f..9a1dc117d6fb 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -793,6 +793,58 @@ dss: dss@30200000 {
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
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					oldi0_port0: port@0 {
+					    reg = <0>;
+					};
+
+					oldi0_port1: port@1 {
+					    reg = <1>;
+					};
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
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					oldi1_port0: port@0 {
+					    reg = <0>;
+					};
+
+					oldi1_port1: port@1 {
+					    reg = <1>;
+					};
+				};
+			};
+		};
+
 		dss_ports: ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.48.1


