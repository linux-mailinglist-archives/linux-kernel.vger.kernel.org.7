Return-Path: <linux-kernel+bounces-739475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E8AB0C6BD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 16:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96B931891FA0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 14:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BF52DECB1;
	Mon, 21 Jul 2025 14:45:14 +0000 (UTC)
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023115.outbound.protection.outlook.com [52.101.127.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B722DBF40;
	Mon, 21 Jul 2025 14:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753109113; cv=fail; b=d9aoN4zqiPQf1cWI8/7LVPIX0MIk++IDVcA2vjo9tbkbQQ5Runk9jkBjguCJCamZctbAnP3fS4A4bioq3NQTcal0KmIsdjWsasZT+8M/ViFqnVJ3HCReiPWr8Sqn23y88e8fWotKBLluVs8S3tWBmnuk264KijxKAFYtPmuvkjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753109113; c=relaxed/simple;
	bh=9kqRDfQTvm8v79//pI8ME5RfK7afM3tdJ1SanzknU0A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NzjRsBc3GQEJEQcpzIrZP/PQKbuFv+737onJr1lB+o4T7MiXQCu60fYcPWu2qIiA9F2vlotsVyr3mcSi5ediGzpG+GxzaAREST3GB/KAzmnHvkxrQ0AMQIQ++FoUeEUZHeFWebl6DGZLrOCMWiaFt/fpS+K6swl8/q2ZZSIFSHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.127.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gCZl5omrGVwkLQ2PpYnK1eJpSWcv//tWYXn7e27bvYRHBxNj8aS/wty7JDi5vf1rB0U8EOwFx/LAidxOXXVwBb7pfyK9BFDKRKJt+Nc+dLsxJ4uXH6XNJhGgZ25D4ewLneKczIAOSxOAWAj54mCKVNTjELu5OPZpxyjPLgFyL8062rJNneiPZKyumBu8IskY1ZQf2FQ1XfYW/IXET8D0jJ/pqIK0kpq8Lpd4NqYheBgvIRvXfb+1DrwfAfV3sqAdf7UjlSyl6oYhLeoOFoINycsRQhWgk/jvWUoIHOv89ZfWkyECfIV9xSfhhhZEc8ZdZ/2nlCeHNFf8sRPcX2/Qxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2xFO6SIchqCsiBZdpX9CLplf8tgp4KWzTEWUWlN78n4=;
 b=wtGxpY6Fk8MAOPWSXlasL7BhQCd4F6sxW3Jb4dwbKa1wlpbXu/3vHZeZbREvwza59Cn5nXIvbRR91nXuPqGJ4umvQ6G7SqibsEJzhE0unB5Vab+6DALrKCrFGaZYJQfEuuO30O3ynBbXvJu6cEXZYCT35YivNgBe5j+IV2M2g8iykHf92kAdUai/vwXIA2YKVnS4WDqamwjyz+7hW+aFcb59sRELoWe7LDPR9YQ+QLtW2XenlYC4e40JVUkoFYgIqOcoz+/JO6hHmtF/qlLizYOpfjvMin5m22IxCc6tKemyDcdZ3vAwLN14tiPQ+ydU6w9VxtkxiE1hUr46c86NiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SG2PR01CA0109.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::13) by SG2PR06MB5156.apcprd06.prod.outlook.com
 (2603:1096:4:1cf::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 14:45:07 +0000
Received: from SG1PEPF000082E6.apcprd02.prod.outlook.com
 (2603:1096:4:40:cafe::73) by SG2PR01CA0109.outlook.office365.com
 (2603:1096:4:40::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Mon,
 21 Jul 2025 14:45:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG1PEPF000082E6.mail.protection.outlook.com (10.167.240.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.20 via Frontend Transport; Mon, 21 Jul 2025 14:45:06 +0000
Received: from localhost.localdomain (unknown [172.16.64.25])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 6F9FA4160509;
	Mon, 21 Jul 2025 22:45:00 +0800 (CST)
From: Peter Chen <peter.chen@cixtech.com>
To: soc@lists.linux.dev,
	robh@kernel.org,
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
Subject: [PATCH v11 1/9] dt-bindings: vendor-prefixes: Add CIX Technology Group Co., Ltd.
Date: Mon, 21 Jul 2025 22:44:52 +0800
Message-Id: <20250721144500.302202-2-peter.chen@cixtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250721144500.302202-1-peter.chen@cixtech.com>
References: <20250721144500.302202-1-peter.chen@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E6:EE_|SG2PR06MB5156:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2c4e1d52-74b4-4555-9d17-08ddc8652f28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/MDGdxhxGss3whpKxUDccKB4acCjnp3L5OuY1K+9adMZ4EKFQaeU8lTcMa2c?=
 =?us-ascii?Q?4FL8iuLbtfoJihtq8yqg4oD12vuWHm06jiG8O9FW56Tozh+GmR+Khsk3YW1T?=
 =?us-ascii?Q?zScz2/zZnSSmYcniv3cLCICrMVTursbE3I9WEkOp2KdXLkXTlx2T1saOpC4V?=
 =?us-ascii?Q?TJDsfj3QnH6kS9fheqwEGV6INVIBIQrGzZV7Vu5QJczWxtrFhuFVMKyzcTPF?=
 =?us-ascii?Q?72B4aZxD/Pv5v6N5QGcNg0M06UVdjqzZFXhbCybydG6IxA5fppTvlLKetola?=
 =?us-ascii?Q?npAOkB+JIBcdY6bEkmdyOxVuEgFJDZ9evH+rmHtVB+3OuUC3Sch306dKsQgG?=
 =?us-ascii?Q?xhom74lZklug6jTbn7ZdHQWgZ2J9+hOSk1N9l4qceBob15yUJvX7amyY5N+V?=
 =?us-ascii?Q?SvWHVSvANo/MYz9r7HMxQm4+VayZaNTeUCrnYwOaGo0bL/PViTQ725zSUV1n?=
 =?us-ascii?Q?wvxbyWVLj6mB7i/2qBG64Cv+VQ5R/EK8ZJXrG8kQA6hndBgqAXMiah3GIflV?=
 =?us-ascii?Q?zuue2vDYvk8HdCZLBY0HcxNQ1FhJ1JYNdbNCzZ6E2O12+j2WmgDLvVB/NklN?=
 =?us-ascii?Q?dkExAQksQtuLUDB7loz+6AL4Qtze/TwjK4ps5g4Y8rbXtiF4CJg4MzndYXyE?=
 =?us-ascii?Q?QeHkSjZtNGEOtnoIcUzM7wYJQUk3yDZi8vCzm/TCinKXIgAbJL7g8tkpp+W+?=
 =?us-ascii?Q?SyrPSOoMPBxPpdDtCftCKXUta5PAwvJTLEQGmmQdkYphBdU30x2Y/KN3A4CS?=
 =?us-ascii?Q?98+eG2rVm5gl2yYccZgoOUEt2xj1FsWZTQ5+DDFFzv5Oo/6FTONhO8iZQOcO?=
 =?us-ascii?Q?q6gryO5bFNn7tuL9XNVCOEkIo8RGodabngmj08y4nzg5Q/gbuY8Q23St2hez?=
 =?us-ascii?Q?38TL6NA+r3Tg4rbE/xKQTEaYV+19Zm7T3rYDgQmChpJbUEWF21p8OjPHexes?=
 =?us-ascii?Q?yZHDTkMYxfQAHABjuZJNNgHCHCt0BKo+xFgc0sqjDS/XJDXoN56IubcsKD11?=
 =?us-ascii?Q?zO98Wxm504xdTTiLwfs1xfCEeBdco2JaD4wGEOvJmttuDThNKeUKp48akz5A?=
 =?us-ascii?Q?cKfqJsrn84scT4iFexkOkFu9J012KujsI1Ck3QAzO4nnPpqhPrlA3GTAdky2?=
 =?us-ascii?Q?9RUzUmGBsy39xYW5P1tlskhZr4+/N0rbXVAIdqutgvHMiPN6GchCLRFhMXW5?=
 =?us-ascii?Q?zEVolViWqFPorZsjYwrTqKUKZEQo3Och4SKzfsq7Ebda6A6xPRmED7Cohk12?=
 =?us-ascii?Q?9SKH3z5aMtuAMeI5FyNkxR7lKONfMjXL8N/eN5U6x8vMRhiew2pmbFH8SPkJ?=
 =?us-ascii?Q?5Z2Y1pki3ZqAeih1F5dNH35wpKiPd48OGtxik67Is3M5uBXvzquHRVYNj2Gp?=
 =?us-ascii?Q?rOJzOU22meo32aERouWublq3JIUZ4/YO7tA3EvbHFrEQk3hVMEhLuUdMBus2?=
 =?us-ascii?Q?JzDHtk722i8meNCus/cF8w5LmLzoRJ7Ts8jNmsLkeG6sF9fsXMv+/A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 14:45:06.3278
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c4e1d52-74b4-4555-9d17-08ddc8652f28
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E6.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5156

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


