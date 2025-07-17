Return-Path: <linux-kernel+bounces-734798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB820B08678
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 09:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D13A7A3767
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 07:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C495A221554;
	Thu, 17 Jul 2025 07:22:20 +0000 (UTC)
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022100.outbound.protection.outlook.com [40.107.75.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6715D21CC5A;
	Thu, 17 Jul 2025 07:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752736940; cv=fail; b=DS1lQ5NddTKZ39lCt+ACO14aPCb1M8ilkUJVk5gBY4f5cc/7+H2wSwPquFx4sZlEeKBHjz21Bu8hNlzTdX9ZA2vFg/s69eM+L5aODITrWSOdQLbOPbJ+bcSYtJ0YhP5pU4Mg+TYnn/QZ3weiYXx2YIsG8MMxBGEQTS8vx3XSSeY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752736940; c=relaxed/simple;
	bh=9kqRDfQTvm8v79//pI8ME5RfK7afM3tdJ1SanzknU0A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ULnyKAuv7+tz0BjEcowmIxHdVanSomRzMztj9B6hfHTZBrBHnkcz3y1lkrENKRY30xzEP8p6oBHZhdEzpugnDoBL8XBPf3mGvNfnAoZkJO6GfR4a9anmnNObhrVSMACsKPiFuSGh51A3166zkm5cje3BmXLTaMYa2o9xRDrrV1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.75.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GkzcMujg8Nd/R1q6bay+QPEVNJzKcJQ7Wh19EZbD+A+TXGLtIVC+myXdfuBEX8235S2vdzzZ1ZOaS2vpaSr6lOgGnoqCPwouwVaBMeEBqzZ3sPExv4S7vMTO6GydZ/sBQGprL11sLC6MylryAGN4D8lwFb1IfgwlGnNkB6us+sPWxZwAk1gvzWw7OReGB4on1uYeHzWldjqLy3Jfj6LUedFPd/5RvT13riU+KhcRnY99iN4YcrBFiqCefwXi7gwu5/Un8FXGEVFLOIC2K1cCE8i95x6sSHiRDlCmGLDl8HkZxAcY+WEgey/FQJvDqPESuB5YKJ3vH/n77cPu44LQMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2xFO6SIchqCsiBZdpX9CLplf8tgp4KWzTEWUWlN78n4=;
 b=DgJFcsuo5TwAIlklvFM5rOqfn077szSbPyPCHR6sYnBhMJ8U2ec9IDF83MnYXzMSDRhoWzCTwO7ELhzNfomf7Oh5FjSwTUVfRKjgaOCLpdV/YLnqaHxpDIqJU4uAEpODLUZC8kNOYepNUUDaXo+N2qx3kCD3wexpxaEt/lMFgLqXaFVec6PKznM33ug4ou0NDfyD6CrHGZIJ/w/8iXXIJwyOeQxMQNxzRzZuecewdMkIhhFh6fymlF67mIOaisf+CrjcKIFekO16MCGTkjsVOI18IIc+otF3gp61Ea67GyhKC6wUzmZcT8PlzUhaRmd1Lnt1GfCc6wlyaWpVLSCsUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SG2PR02CA0132.apcprd02.prod.outlook.com (2603:1096:4:188::15)
 by KU2PPF58AD76D06.apcprd06.prod.outlook.com (2603:1096:d18::498) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 07:22:11 +0000
Received: from SG1PEPF000082E2.apcprd02.prod.outlook.com
 (2603:1096:4:188:cafe::c4) by SG2PR02CA0132.outlook.office365.com
 (2603:1096:4:188::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.21 via Frontend Transport; Thu,
 17 Jul 2025 07:22:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG1PEPF000082E2.mail.protection.outlook.com (10.167.240.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.21 via Frontend Transport; Thu, 17 Jul 2025 07:22:10 +0000
Received: from localhost.localdomain (unknown [172.16.64.25])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id A76B841604E7;
	Thu, 17 Jul 2025 15:22:09 +0800 (CST)
From: Peter Chen <peter.chen@cixtech.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	arnd@arndb.de,
	jassisinghbrar@gmail.com
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cix-kernel-upstream@cixtech.com,
	maz@kernel.org,
	sudeep.holla@arm.com,
	kajetan.puchalski@arm.com,
	eballetb@redhat.com,
	Peter Chen <peter.chen@cixtech.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Fugang Duan <fugang.duan@cixtech.com>
Subject: [PATCH v10 1/9] dt-bindings: vendor-prefixes: Add CIX Technology Group Co., Ltd.
Date: Thu, 17 Jul 2025 15:22:01 +0800
Message-Id: <20250717072209.176807-2-peter.chen@cixtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250717072209.176807-1-peter.chen@cixtech.com>
References: <20250717072209.176807-1-peter.chen@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E2:EE_|KU2PPF58AD76D06:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d99b4f01-408b-4f96-5b6a-08ddc502a50e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+f73e/LYC7npIeQwM2b60UXkrguRv5kmI9x/virt9Mg0cz+4NMervE+eSlZu?=
 =?us-ascii?Q?7k+4ZP3W9Mvf0E34bLTcHnxOdxRY7xm6A8LfMau/+y5e39AGwcRp1vAja6cf?=
 =?us-ascii?Q?GrOqVwZnGHocSLxSSUaFEsrCHkEt4V0zWJTBdq/rmkB9PV6M1UP6I++BHA7M?=
 =?us-ascii?Q?ev2ct5BqvAf2OtVMtdUzFTuVuwOvVcphbyuLLecktXsOy3VITyE3V34Yi5/1?=
 =?us-ascii?Q?H3t2P6s2/HG47CKMs+sMxNvUNZbIOlWFfLv3a5SRP2SSSt/7j+XoEcYx5oy5?=
 =?us-ascii?Q?W8N2Sr5fa8Gs9kYe2qBa8dmQDhuzRHHhZLhaSJ9xaQ8vAXCIYfDopW2htqsN?=
 =?us-ascii?Q?OyZNKei2Q3Kv3/LgeItKXfwZ+40P+RlYTxNax8wQLR870hbzQh3HDIdI1489?=
 =?us-ascii?Q?Mb9fBtGLohq0tZllxg068MzC13hPqpLPrh8zMo5Dhjkm7JpbIzxXZLhg3IHe?=
 =?us-ascii?Q?aG0+iWrBUsL4zELb4axaZ7yEjk7v2juWLfleSWkSimEfQT4I+r5Tc7jdA1rM?=
 =?us-ascii?Q?B/3eOdVnyzMY8cswq2ibRfjVafbJAhqyrQLOcJP5aNdnZFzAmKEjAgOxggeu?=
 =?us-ascii?Q?930bMcMKLwE6lQXnLnyAJC9BNMjTwhvJAmnkeHN+PzFvhNt+RHamEZOAdPGm?=
 =?us-ascii?Q?FK8I02ObLT90679DJoAlyjDJj/tBeQdCJlTjWZBMGjjsmLP2qVrS9pfFVeuK?=
 =?us-ascii?Q?6OZUOGq0w2zb8Hf2IAugZM+JGBV7DwPxcXsUjOjWl9fxXR4oYDRi/6GPR9vE?=
 =?us-ascii?Q?NkUQlTNB7VS3DEntg9KrVye6Oy5FSegIcbVga+VmOlnxOBvLcSjI/Qv87CuR?=
 =?us-ascii?Q?Qg5oQw04G7r72XkqJtOwSP4wx/iPPDwrwjlcKe9GVv6t9Bm/xGgddRa/cqF0?=
 =?us-ascii?Q?C9rmJQBBMeDkFm46azREJMZBoBbJpDL6uGI284RNW0oxp00Vo2gy9UnAA9JF?=
 =?us-ascii?Q?q8wL+cZIftzQOLQH4qUnpY1Su8gr2rdqT+utpF0WJJQqWDACWc89i2NRzdmh?=
 =?us-ascii?Q?gLAmXocrkAjMb9EsjjgAWX3Dxg4XsiR1l/KaRGeszKMGiu3jdlHF2FzE8myY?=
 =?us-ascii?Q?kuc1syd2UBHKjb0cJ2abLqD8BvAB55/r9EbQtgGz0kolKlyzeiQ1BsEZCj8+?=
 =?us-ascii?Q?ddhiyry9ZYsYc/Q2yfp+RMdmUopq8G04+YZtfB1lM6DQ1XU8fZDfunOGWOOq?=
 =?us-ascii?Q?kNYsASIAalL7rrURz6jS2O7Pf/6IA7bRuB/C4/q4s/jnL9BeeyOPRVtTBnFq?=
 =?us-ascii?Q?y0YZKVllx1n82WgZvvaQ34VXW6PzEO6aW3jOrTw0dYLkg2ao0Rea+CuMW3fn?=
 =?us-ascii?Q?qTdSgIOOdpQsLmNvrOuP9ZWehemk+5McqK6cpVzV1yw+d6WteHovEFYs05+Z?=
 =?us-ascii?Q?Ya6lU9zk55B4azwI1mSh0t5+KhcMydbAQbWpMbRGwUOaf1F8o7OSRNN1YYb7?=
 =?us-ascii?Q?Veso1eAZ+78gbKbYHGNEYOd7Yde3V/vUciPc/+B2/tzdID/aQJ5CTQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 07:22:10.4248
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d99b4f01-408b-4f96-5b6a-08ddc502a50e
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E2.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU2PPF58AD76D06

CIX Technology Group Co., Ltd. is a high performance Arm SoC design
company. Link: https://www.cixtech.com/.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Fugang Duan <fugang.duan@cixtech.com>
Signed-off-by: Peter Chen <peter.chen@cixtech.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 5d2a7a8d3ac6..f258c1f53b3c 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -306,6 +306,8 @@ patternProperties:
     description: Cirrus Logic, Inc.
   "^cisco,.*":
     description: Cisco Systems, Inc.
+  "^cix,.*":
+    description: CIX Technology Group Co., Ltd.
   "^clockwork,.*":
     description: Clockwork Tech LLC
   "^cloos,.*":
-- 
2.25.1


