Return-Path: <linux-kernel+bounces-897147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECEBC5228B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 59C774EF470
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F8C314D33;
	Wed, 12 Nov 2025 11:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Kcl3THpO"
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011037.outbound.protection.outlook.com [40.107.208.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53DD35CBAE;
	Wed, 12 Nov 2025 11:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762948534; cv=fail; b=A+RB3hvi8pkS7eLT1dDACW6miXQNYRSmiI1zBHbyldzS9i8bwQqTMnSVnFpC5Yh1XExN8sOD4tX9Rgt3DMuU9JNNKL5byQfrPVtc5RO5I4QMdY/hixBZ//wS4gocH0ZCtA4u0uI+KMG4qdsiB6aDP87VR47gfLmspT5IfoLM3f8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762948534; c=relaxed/simple;
	bh=s1Z6i8nmkzcw+5uOaYPg9pWYsuDmjnhT7v4WJaHkyLk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LrjGLpd21chXD9nLBezy2xJ0ZbiL+z+LNXzj2fnyVm+ts+QvQFI8QGBKuMpmhsuq9EaTR52Zy5BQJJ2ma6ySZg7Ps+XYlwsw8ikayo9RiAu3krIDS9trH45qOvvFfG183HN0Fy+uKcyqXG4NokxRfVCetO5Vta2+ZwdF2TYLeuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Kcl3THpO; arc=fail smtp.client-ip=40.107.208.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uDU0GnhVlEXlPJBBG0sQDNQkaLuMEvYYf+MscxJvfHrK+A6ch23Ns6HpG9ECtPHhZPhxKV7mX4aVx5CYYNhDJcbtRgYmW7ndba5SwznqyxmHyUaMJ2chlvtDvqtooisqJ9TwD+bVRbJ7JEONMbAwM1PLS2E6O9jQgGzluEuQwBpOJTxdTpMmcmUoQqw55DH9amIk5MCkJKzLaKW0yxJgYOlF56UFFcLLYZ2pjy2qpYIpGBE/D5OfDkUl6mVhlWufp3o4wYdyiZ30SvkfI4w/dnNbV/g1RWNNZug022oHfizid9YDsOCachx6b5jD8Ry3bt99LVIseZPtvoMxcdlUSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKOGeTrdANEFIeSncdxz10Hh/ukJDG922e6712afheg=;
 b=ijsTz5j38i3ryV5+h5/CZy0MEGsAfSbSsGHs1IW5TAfgmaQTsP3Jn+4mDns69r6eNr45uJ31/IazKuuYjIsV52hINOlhZTT4oC7RPP2z3Sp+sOSstBFB27TVt49mU0sWqhDKRMe07DeZDAg8ac5pw5ke/MClUkCJ3Bpw32dqs3A4+zQ3uAFqL42bEFYUqOUvGZbsDmsGP0qQ6VScS8izUn2TF2Ogwm/rC8fNINKFtM+tmOAqcTvmB/v1ZA2ip1upom+hqvRexQJVakfIJjAZ9EUvTGXrUHMrcZzrBzIU3lhiS8E9lwDg/VivVYj6RHjDUoB0OwKhguaE/3Ba3pwxfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKOGeTrdANEFIeSncdxz10Hh/ukJDG922e6712afheg=;
 b=Kcl3THpOGRJYqO62n0m/TTR9KklGYN9O2oxa+6JsNh2qzZmCEeYYXYDk001Xi+fJJW+DgDNkH6VphPctuSz/g1nj127QJT0XEM2zbmycWiWDgI3SRuceS00lP1OK7SXBqfi1pR36GDSpYJMO8YkgyTpnxQk0t4E8SlBiSgNJC70=
Received: from BYAPR06CA0024.namprd06.prod.outlook.com (2603:10b6:a03:d4::37)
 by MN6PR10MB7492.namprd10.prod.outlook.com (2603:10b6:208:471::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 11:55:28 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:a03:d4:cafe::3f) by BYAPR06CA0024.outlook.office365.com
 (2603:10b6:a03:d4::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Wed,
 12 Nov 2025 11:55:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 11:55:26 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 05:55:20 -0600
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 05:55:20 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 12 Nov 2025 05:55:20 -0600
Received: from ws.dhcp.ti.com (ws.dhcp.ti.com [172.24.233.149])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5ACBsxbq2638977;
	Wed, 12 Nov 2025 05:55:13 -0600
From: Rishikesh Donadkar <r-donadkar@ti.com>
To: <jai.luthra@linux.dev>, <laurent.pinchart@ideasonboard.com>,
	<mripard@kernel.org>
CC: <r-donadkar@ti.com>, <y-abhilashchandra@ti.com>, <devarsht@ti.com>,
	<s-jain1@ti.com>, <vigneshr@ti.com>, <mchehab@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <p.zabel@pengutronix.de>, <conor+dt@kernel.org>,
	<sakari.ailus@linux.intel.com>, <hverkuil-cisco@xs4all.nl>,
	<tomi.valkeinen@ideasonboard.com>, <jai.luthra@ideasonboard.com>,
	<changhuang.liang@starfivetech.com>, <jack.zhu@starfivetech.com>,
	<sjoerd@collabora.com>, <dan.carpenter@linaro.org>,
	<hverkuil+cisco@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v8 02/18] dt-bindings: media: ti,j721e-csi2rx-shim: Support 32 dma chans
Date: Wed, 12 Nov 2025 17:24:43 +0530
Message-ID: <20251112115459.2479225-3-r-donadkar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251112115459.2479225-1-r-donadkar@ti.com>
References: <20251112115459.2479225-1-r-donadkar@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|MN6PR10MB7492:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f234954-2c3f-42e1-f0d0-08de21e25e82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?737KeBih89l6iv37r1D8rHDUm9NkPzMGw9nXdXRpopghXG8KUPx/9X/VqHTO?=
 =?us-ascii?Q?JjDuuYz3g09b5hsE9yeM2m3YYahoQVQNe72p/9r+lZxjcXojzdizqwq68gfz?=
 =?us-ascii?Q?adY+pvhdk4KzZeWXiEuZV2dummZIYgyImtF50AXcm3dIUVW1U79kMsuTzv0E?=
 =?us-ascii?Q?3c31vgYB+q42r1NDHRDCNgnHHgDdx7Qe3RqkjEjNOgAMWxgIRdf7PcMfzjF3?=
 =?us-ascii?Q?asnRztlsiiw46W9kzppmEqn+Uinuh+xulbYwNpletpNIxheogw4knZE/s1i4?=
 =?us-ascii?Q?ifHSVZNdIM4mHM5BtjH2evMWt2RJYPSKqMp1Fda+XE8wwdpfw6WH7gxf2z7S?=
 =?us-ascii?Q?c+4RmURm9YJIznbloV1Aa45dboHZLNkKB/WZu8hmdO3o/t2SXCxEtJHGKZcF?=
 =?us-ascii?Q?KNSsN6Vc2DewGqeJtFzdynWJmicAIbAGmOAHkBZpRC/eKOJdk/ihsRKsdfFb?=
 =?us-ascii?Q?KhjlvvKcU0YdA/9fqR3fB0cxyIWmG/ibIn+kbsVeb++qYbSCYikzhY0jMaFK?=
 =?us-ascii?Q?MDRFHY64FsSKUkZPyNadXb5NDNy8mGM7zhMbF+1qAciMlqCS3h/j1mf2gyi9?=
 =?us-ascii?Q?LkFkAahCs3N5l6w1QRArpryonBL5wx9VeSHz0/WSMCXl4AyAUbFEKwsqil7b?=
 =?us-ascii?Q?oUB12wT+E3yO5eu7N3tX7R8P/Q8SF65csdcwvuJG64ZTJ0thAtJwouqtxmR7?=
 =?us-ascii?Q?2j5nMA1ttDJ7ViJpa99YRKyN71x4uHaqjKZJpdtlfxSHvq/p+UJk+vDdWq8Y?=
 =?us-ascii?Q?5FkHHM7X18p/0m7oTvQ0/hJrq6FPyVr09EqBQa/nuM6csfc1mNUgsuFacnla?=
 =?us-ascii?Q?jpxt5ya4nPtTtlVCC7Z+watkrnC7OFzjfENfad4/LKEJeRyeqrrodlkskXOL?=
 =?us-ascii?Q?UpzNz7pgCQK+arlPm7ZGqX2IBB/kGw1RLxxRpKsgBXmd+3KUpIEhXeUlAMuO?=
 =?us-ascii?Q?eASQdb+6N0Mn7QIwH66srd4JHXlzCoHUZOQQH2/Sl4HIyBKJLBXmDHDICUzj?=
 =?us-ascii?Q?ZR2oe975CsYf2kO0Mgjv6EI7EHscTlTl+jWuL0E+iC2BPz/7BXYNQepWm/+b?=
 =?us-ascii?Q?Mjvx4Oi6WY8MT3mYuID8QaGkROwLM7Y4Ac1kmM5HlHnDWD+jxWgvyNOCssiN?=
 =?us-ascii?Q?UVJq6z4eSyDGW1IJWyb0+cP3RGQ3RxhWY/PP0As8Bgp4MtzkTuiwkNDSC1oj?=
 =?us-ascii?Q?zasxN+O7wKvmFG2tozth03/1VBgb/TgdDCyLN1rXdLTfrkj/RYh8uoBDZaI6?=
 =?us-ascii?Q?k3hIIfvGIoWXgRTGIjOY3lgTqPzaJx/YK2jIPGmEPIRIgfLEnxJfqWe0iOsZ?=
 =?us-ascii?Q?uJiszukcg3dycwaVXt4yfRefXH8PH3D/oWM2a4MpJmmXV+I0H+y2UnosFNLb?=
 =?us-ascii?Q?BnDfkelP9PGaTjdbbH3yYSD1luIdCe3BS31rSvYlZ6lRUCDqEIgCOKdvYdII?=
 =?us-ascii?Q?oeaZD839Om4+s8Cgz28wd/5/YlhQNTmrKKe05GP1NxZBC6b4tXd3Hb3lULpd?=
 =?us-ascii?Q?fW2AsncVtk874gAbRJO5og6iXt+xW0WJ9rAcu7WK94ajQ6L2c0Rs4WnmY2qg?=
 =?us-ascii?Q?GJlheXEJMdA7fvT+mV0=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 11:55:26.4139
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f234954-2c3f-42e1-f0d0-08de21e25e82
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7492

From: Jai Luthra <j-luthra@ti.com>

The CSI2RX SHIM IP can support 32x DMA channels. These can be used to
split incoming "streams" of data on the CSI-RX port, distinguished by
MIPI Virtual Channel (or Data Type), into different locations in memory.

Actual number of DMA channels allocated to CSI-RX is dependent on the
usecase, and can be modified using the K3 Resource Partitioning tool [1].
So set the minimum channels as 1 and maximum as 32.

Link: https://software-dl.ti.com/processor-sdk-linux/esd/AM62X/10_00_07_04/exports/docs/linux/How_to_Guides/Host/K3_Resource_Partitioning_Tool.html [1]
Link: https://www.ti.com/lit/pdf/spruiv7
Signed-off-by: Jai Luthra <j-luthra@ti.com>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>
Signed-off-by: Rishikesh Donadkar <r-donadkar@ti.com>
---
 .../bindings/media/ti,j721e-csi2rx-shim.yaml  | 39 +++++++++++++++++--
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/ti,j721e-csi2rx-shim.yaml b/Documentation/devicetree/bindings/media/ti,j721e-csi2rx-shim.yaml
index b9f033f2f3ce4..bf62998b0445a 100644
--- a/Documentation/devicetree/bindings/media/ti,j721e-csi2rx-shim.yaml
+++ b/Documentation/devicetree/bindings/media/ti,j721e-csi2rx-shim.yaml
@@ -20,11 +20,44 @@ properties:
     const: ti,j721e-csi2rx-shim
 
   dmas:
-    maxItems: 1
+    minItems: 1
+    maxItems: 32
 
   dma-names:
+    minItems: 1
     items:
       - const: rx0
+      - const: rx1
+      - const: rx2
+      - const: rx3
+      - const: rx4
+      - const: rx5
+      - const: rx6
+      - const: rx7
+      - const: rx8
+      - const: rx9
+      - const: rx10
+      - const: rx11
+      - const: rx12
+      - const: rx13
+      - const: rx14
+      - const: rx15
+      - const: rx16
+      - const: rx17
+      - const: rx18
+      - const: rx19
+      - const: rx20
+      - const: rx21
+      - const: rx22
+      - const: rx23
+      - const: rx24
+      - const: rx25
+      - const: rx26
+      - const: rx27
+      - const: rx28
+      - const: rx29
+      - const: rx30
+      - const: rx31
 
   reg:
     maxItems: 1
@@ -62,8 +95,8 @@ examples:
 
     ti_csi2rx0: ticsi2rx@4500000 {
         compatible = "ti,j721e-csi2rx-shim";
-        dmas = <&main_udmap 0x4940>;
-        dma-names = "rx0";
+        dmas = <&main_udmap 0x4940>, <&main_udmap 0x4941>;
+        dma-names = "rx0", "rx1";
         reg = <0x4500000 0x1000>;
         power-domains = <&k3_pds 26 TI_SCI_PD_EXCLUSIVE>;
         #address-cells = <1>;
-- 
2.34.1


