Return-Path: <linux-kernel+bounces-897653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C11BC537E3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AF9B3564970
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC82433D6E7;
	Wed, 12 Nov 2025 15:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xjNFa3k3"
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010004.outbound.protection.outlook.com [52.101.201.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175F032C92A;
	Wed, 12 Nov 2025 15:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762962881; cv=fail; b=mjHJt3T7pWWIYxgm4FrWxy5KuNZH0/yjlpMENNNRelthl+seoZj9FL6PqLeBnSdGlVkdPuadabbrym2rrDD54zdbF37R9xldJ/TnKaj7auIqEHyeQJmQfHftDmFrHOO29mtbq51nL2D7UkStUCYLpaHXZweeuJNS9+PAJW7VNAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762962881; c=relaxed/simple;
	bh=2j4//WPwhUX9t3Knp5ZGzbQZhNr8jJ8u3Wlwtale1yc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VQoj/WEgqd0BtFnYOR3CT4/ktLzpmfS/Bkl2wm6e0qoZiJgAOmHCIfwEaZx4vVocTp7K1E0mfMpfdW5e4c0WKbeBpX5hhir3tXhSTIV/flMXvmNVwd+9Yp9NgRexJG3npBnr5Vcyn8GG7uYzjAv4AGNIL162N/Pk4mSUyXx3R4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xjNFa3k3; arc=fail smtp.client-ip=52.101.201.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jFhiBDAha3o4vAeL4DXbeqNP2IwZqh/wCyxsAUEfE6YaU1VAdB2vQ/NexAc+AYIlqi7GKut+nRZ/kJ84wZrVCnkKK/kBTUKQlU3uoNF3i3AsVc+DYijPD46udbn26FGxtz+f1adY3rFhOH5VVlhcIZgJw+xLazX4IXw8XJZdNDYVHPCvL6ZVBXDy+TXUYgrgP9J1isUFZ4sjogoqAn7oDYqH6JJhO0PyZnQkf5LcEwOd1Ol7rkP3JWHKh1sjixfDWsI714Mtj0OOhzPUrCebn6xHpa6BEOcKdDGlW3M0VYBwIAfwElQ7g5fQtlubfMNJw8EQyyIZ5klkcR3yBR3fMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N6VrpTc1O+P0RJB06V2xQYPFqtLUV/TkuSkmjXF6DkE=;
 b=a9U9v0l2WsQZmQug/JZ1GGGx5Z6Nz4x1i2UpZ9UkkFGVj53HfvnXpXCdu627U39y6MK6woTfdjJQDGNnMtxCRxiXO20Mxi/c0Tsz0e3jfa+vtnBCYSnnMnj6ox2Bzu87PvmNmVbPuyon/4DHx4j/x+y0sg00hvodwkhoCt0+sKjU/wAvoSX2A6VC01Oyl9Ko5Nf+5YGSY85Oi0VV7tlYLoNd/XIqvTGeMZ/PaRMj5bPht1pUAFjRIMgHS0Od00cN98RsD/jfTJ/cH0u7fJCD4LHEFrIJXPPYoGI8AJU0nsZ2CpcalPs3MOO9tCtFeH6HWhT3+cpMy41tcE33jmztiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N6VrpTc1O+P0RJB06V2xQYPFqtLUV/TkuSkmjXF6DkE=;
 b=xjNFa3k37Vzbty4Cb0q/KkOh8lEBbhplf6WewsJ6rq0ZSvnCGG8JDrGQljFTOrvCzt2gyOAGvOoihbpgD+9rm3bYc6x3zaPwrplViXGScT3XJ5M3i04InCr9JOswSeAGKTMlvcXG30hwUoA5CKErkSBt3PJve+UUQpsvEK1uwBI=
Received: from SN7PR18CA0025.namprd18.prod.outlook.com (2603:10b6:806:f3::29)
 by BN3PR12MB9570.namprd12.prod.outlook.com (2603:10b6:408:2ca::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 15:54:37 +0000
Received: from SA2PEPF00003F61.namprd04.prod.outlook.com
 (2603:10b6:806:f3:cafe::b) by SN7PR18CA0025.outlook.office365.com
 (2603:10b6:806:f3::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Wed,
 12 Nov 2025 15:54:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00003F61.mail.protection.outlook.com (10.167.248.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 15:54:36 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 07:54:35 -0800
Received: from xhdradheys41.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 12 Nov 2025 07:54:32 -0800
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <gregkh@linuxfoundation.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <michal.simek@amd.com>
CC: <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<git@amd.com>, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Subject: [PATCH] dt-bindings: usb: dwc3-xilinx: Describe the reset constraint for the versal platform
Date: Wed, 12 Nov 2025 21:24:30 +0530
Message-ID: <20251112155430.1326426-1-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F61:EE_|BN3PR12MB9570:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bb4847c-162b-49a8-1130-08de2203c7e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bYlIh8iZTIAW8sEQg62pqsd4BR8d7r/JpYPglO5Z8a6CjZPFjvnnTSrMiEN5?=
 =?us-ascii?Q?MVgXj3255SJdghA3bGvU0C8RiTDuPiZJ/cOXAF1lNHlGa6Qe+W50IL8H9VhU?=
 =?us-ascii?Q?TftcAUytQqzigBVbHs0mQIEpHnyJLYCFAk7WDfacbAjc++1zpUGdiXWLoOJX?=
 =?us-ascii?Q?Lf9/pR6qVsFOVCwAS2aBoMOZlQeIXPj/A8NJU54rgT0LunX/I4dj4pfv7ll9?=
 =?us-ascii?Q?7+1PIkFaO5q+XL4fCIDgHfk+RKIAHWqRopZ/3VIoS1kFluDfylUNg0MuIRX9?=
 =?us-ascii?Q?NoAt3EsiW1LlD9fCcDjmEshuUL2mMyD7XLKqHMWy0rocKVRWFxnVUQqpFNWs?=
 =?us-ascii?Q?OkzXKhZ8WJr3NNJUEy1PULQS6pWUe3Z0pvauce0A7el5u7DGe3+K1zMfdmZx?=
 =?us-ascii?Q?VBtJx5s6NwJC1jWUm95q/r2s8htV1tt8DEqeHUs+HFRWdMAI9rtcv0mQ8IlO?=
 =?us-ascii?Q?uBStIKpVvFq61Kc/9z4ISJCKhd6p3NSB8qfqd50oNlPIPMcwvg/7K2pWPfp+?=
 =?us-ascii?Q?3ACv13KxMe6clA7d9oBSt2RucSBx58b+u5DalZgmeLCFQLOLxtq4DdPklGxT?=
 =?us-ascii?Q?6/nnP0ToNzBOqLnn2VamKkA2ZpjRqVQWhF5kWKtYTx7Rx2ELLkXRTCb0/f6p?=
 =?us-ascii?Q?okAtrG1xvUULJcENK08PAJMtipqIu3cM/2yt9HtzD9thot4Oeu7N1L9fiDs0?=
 =?us-ascii?Q?zswtPYk7Fs6IyL1yLaiwiXa7G3jNnK2fUfnxnAu/0kmL5SGCwQ4QVCCepXBK?=
 =?us-ascii?Q?T2qwsutLZo9xpJmG7b6Y2nJg5hqa/0K69yCpW/E2RVJMvfkUElYlxQNAfVGN?=
 =?us-ascii?Q?VKRquuDD4dGTSNTxIrclx10qm0Q4wsVPCQ47GCOe/XlmEhtBvjDhYtL4lY1r?=
 =?us-ascii?Q?gfxw8QiwWzpXBT90EOsGEzNh6jYtb4spNSf6alEO7LNUH5jCwwNKrD2NqJvi?=
 =?us-ascii?Q?2K90/M73LPqwi6ZqqWDu4NfsOH2mzJ38geAQ1IcqxcKSnsZ+LPL1YOilkaKD?=
 =?us-ascii?Q?jP0TdGFzyVltSL3E8TjXxY5Q4hQUpfSXfMR11rRbwGiLcsV20pEEerEMeDhy?=
 =?us-ascii?Q?mARgj9rq5dcXq5s8UmRwk7LWlU1/f8biapZTxsRM9Sf5gOPQLlINq/v8r/hf?=
 =?us-ascii?Q?fque5owLPXKk3ZrOgeMXNzFMOc/VqVsiGq1J8dcAQ3oB+MDZwll96jpUPPfR?=
 =?us-ascii?Q?fN5KAmTmgToLxqwt6R5kLWTTvChY6x7s874WA3nfPhrYuk26lkuwsiF00XpH?=
 =?us-ascii?Q?b5w3+BCyFLcUIgBvJw6fVnz2SoSORKHxkk5S6tb8hAQQxa6eKl0gpy1gQtYe?=
 =?us-ascii?Q?RswvtnQgO0J1GJUbU18uRlsN1ineAI4pyzXb1ZaPb4R7K7vjrcvQTkcSQMd7?=
 =?us-ascii?Q?o+DeNdzyj9MdZZWeNrZKvMrxm0Epfw7jfsDTe+OSM9gPWgNFnw9c6To5GGNf?=
 =?us-ascii?Q?eT53DK5uTuStY/HHHVhZWmhtLMfcjbk4C2bH78X20ys/zC5/gtQeEd109j2g?=
 =?us-ascii?Q?szMBpLOjcjcY6SO1GNpzEJfGr+zct46srkY1CorBPDOyG0nzveZeKLPSaDgn?=
 =?us-ascii?Q?yrHCCgUB21MpHj89M3Y=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 15:54:36.6434
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bb4847c-162b-49a8-1130-08de2203c7e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9570

AMD Versal platform USB 2.0 IP controller receives one reset input from
the SoC controlled by the CRL.RST_USB [RESET] register so accordingly
describe reset constraints.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
 .../devicetree/bindings/usb/dwc3-xilinx.yaml  | 43 +++++++++++++++----
 1 file changed, 34 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml b/Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml
index 36f5c644d959..cd0cc9da242f 100644
--- a/Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml
+++ b/Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml
@@ -50,17 +50,22 @@ properties:
     description:
       A list of phandles for resets listed in reset-names.
 
-    items:
-      - description: USB core reset
-      - description: USB hibernation reset
-      - description: USB APB reset
+    oneOf:
+      - items:
+          - description: USB controller reset
+      - items:
+          - description: USB core reset
+          - description: USB hibernation reset
+          - description: USB APB reset
 
   reset-names:
-    items:
-      - const: usb_crst
-      - const: usb_hibrst
-      - const: usb_apbrst
-
+    oneOf:
+      - items:
+          - const: usb_crst
+      - items:
+          - const: usb_crst
+          - const: usb_hibrst
+          - const: usb_apbrst
   phys:
     minItems: 1
     maxItems: 2
@@ -95,6 +100,26 @@ required:
   - resets
   - reset-names
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - xlnx,versal-dwc3
+    then:
+      properties:
+        resets:
+          maxItems: 1
+        reset-names:
+          maxItems: 1
+    else:
+      properties:
+        resets:
+          minItems: 3
+        reset-names:
+          minItems: 3
+
 additionalProperties: false
 
 examples:

base-commit: b179ce312bafcb8c68dc718e015aee79b7939ff0
-- 
2.34.1


