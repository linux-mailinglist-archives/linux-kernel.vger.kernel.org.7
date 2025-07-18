Return-Path: <linux-kernel+bounces-736812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0CBB0A379
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 13:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F0547B9FC1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 11:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D902D979D;
	Fri, 18 Jul 2025 11:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fdyaruFF"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2048.outbound.protection.outlook.com [40.107.212.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B05F29993E;
	Fri, 18 Jul 2025 11:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752839421; cv=fail; b=X7HRqgIfUfcRQWeQygDcWFc+2dj+mCErGN0wLGG4/W9Q3XdJFyneCT37G3UCR8Zy+n4oBfQs1D4lLzFXd9Fd6GX6OoKuO/ANyA9/pwM6CJzzujq8A4YWkf+10lo/MK7qAzSUweYpOJ64uFB7j9HS+YYXeMP3CCmtsCEyh2Q5gNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752839421; c=relaxed/simple;
	bh=vxYMMKjJC+D+27A0KhfLdlsKGFJDWUoq3H7lz7K4Nxc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sSCJroyGai9sRd0WCNhBrBoPzAyVksX0dlkKv0tF9KDX3fFp6ySRTM/IdqzsDSqPfbZeJ8isH0cb0+8V0UTmAm930xPPg8RnKa9XCJPBejNwt9Xwc28mudNvvRZ2poVEZt+V17+cwrDLkDjDkmSC72oOrzCzso7IxiFxhfKKfn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fdyaruFF; arc=fail smtp.client-ip=40.107.212.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SX4hKqHUh5RIR1OSSKS4gSwbS3CbJlRy5ami+ESarPv80rbl+OlxMUrjW5OU+UGxqgxjS47pVbfbb4LPk3hIaOduCNPvR6AZMJbuo9qMyiQg8E3pfrjl/zC7kcgPKHzMcAhCf1Linjfcd0QAVPpha1e8/u1M57l9lSbqlP0pfBrX6T9PWKlKEJHlXCwTE7YflBK9+4bYuanLTVM2zr+EbSaGB0OC8Ti0JuM3W8+CkC8cokk4O8VGdc7kDuWKgyCjrx0H3QiBjGpQIfsiLUo8qhWDdlBa5qyIk+ykKG8v7x3PE2qP0FWKheBdj+Gfle9klJFWHEqxHSHz+uT+m0yCdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WgSmQyWgPhUykhvt5z+/AAOL+315BCTCTp6p+lq1WgE=;
 b=yznWA/T/a6Op1NgsFYQcqk3B9s3PLORAziiHs7/UyLf8qMSeAsZHWnuqf/BJnnxD7gTEBGmaIbMWO9bazQtgv2sEtg9HM8JPKTTiETT3Nn+yh2SVqqQOJiMumzQMyEfbzewLYYAuS6VgPRz7iC7sPflpEHSxpOdwWQx9TVP5ZcaWmJE1WaVhpAEpiaN5rJHYlA5jk+8rwfJeiRqmDWZFdFiCxUWb6Ez0X18Ouv7v/D0MAnIC1G9GUqUnxxeOKipeCCNyqKqRfx7F3Mj+/y83QkH7obF79Pjq77R7T5IKBJ4jLtXQVvv2yfVVclzjAHjX9viCjgNmFG/IYWb6zG7zDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WgSmQyWgPhUykhvt5z+/AAOL+315BCTCTp6p+lq1WgE=;
 b=fdyaruFFvhAwfWFufMihfEBzxYVw85wfui8nYIct6TVZr/Q92+YE9XNDXJ5lCLENqfwSFcwXbyzYqgrNLfBHd89PUUtzgwgWbIf2QyZ4u9I1E0zTduJ5lQQYqltc+HGTBFp/MyCdYwrK8Y2uZpshbWGUndsfo5hoDEnoi5zCMEY=
Received: from BN0PR08CA0029.namprd08.prod.outlook.com (2603:10b6:408:142::15)
 by CH2PR12MB9541.namprd12.prod.outlook.com (2603:10b6:610:27e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Fri, 18 Jul
 2025 11:50:16 +0000
Received: from BN2PEPF0000449E.namprd02.prod.outlook.com
 (2603:10b6:408:142:cafe::d5) by BN0PR08CA0029.outlook.office365.com
 (2603:10b6:408:142::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.21 via Frontend Transport; Fri,
 18 Jul 2025 11:50:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF0000449E.mail.protection.outlook.com (10.167.243.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8943.21 via Frontend Transport; Fri, 18 Jul 2025 11:50:15 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 18 Jul
 2025 06:50:15 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 18 Jul
 2025 06:50:14 -0500
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 18 Jul 2025 06:50:13 -0500
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, "open list:OPEN FIRMWARE
 AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "moderated
 list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] arm64: zynqmp: Enable PSCI 1.0
Date: Fri, 18 Jul 2025 13:50:10 +0200
Message-ID: <32be8050838512d4340486227c32f38298ddde57.1752839409.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=722; i=michal.simek@amd.com; h=from:subject:message-id; bh=vxYMMKjJC+D+27A0KhfLdlsKGFJDWUoq3H7lz7K4Nxc=; b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRUmXwuiJze8SEmL+xOlGpziLo/76m/Qd9U2V6rGy2Ls lBXY/XvKGVhEONgkBVTZJnOpOOw5tu1pWLLI/Nh5rAygQxh4OIUgIlYrGJkuPk8o+h2SPLMNN+q ZK+NnefkPL9b7umSqHhh8nLO0WVn/zAyzLvqubHoelrbS+fdK5v+7DxYtvX12qXaf/KyUuYWBSz awg8A
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449E:EE_|CH2PR12MB9541:EE_
X-MS-Office365-Filtering-Correlation-Id: 13b58935-a670-48cf-93db-08ddc5f1431a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3wcXaDiRoSFevuINhFVRNFZ+pNVfmIK8Y6o+2/sBo66bvZLmclxSlfaORfhl?=
 =?us-ascii?Q?qdkrDKfLVqEWfl/cxJvlUlx3BK/RTmOx8OH+LuhXLdo+keJaS2Coj1SeJKXM?=
 =?us-ascii?Q?YL8rS/lUWfelwJb1YHqLOoBSfTEP4taL6sWJW7AuZwQDOG96T7/U0iZXgM+i?=
 =?us-ascii?Q?y6na01llEJqtKMMkeW7Ai+qZI3qkIMV8xFP+CyDfIpX5ZRJTEWth0SOQuMJU?=
 =?us-ascii?Q?LdZ2r2ILOYuldTNbMyPRMKUxnMjaYS06djmf/J4vfnNOitftK6eN1IRUckn7?=
 =?us-ascii?Q?Vubrmu3hj/FcQ/2HQz3l1L3qKNZxlfITlRN9GdsgzluWjDqh3+oQ0PWL1gyQ?=
 =?us-ascii?Q?b/oWkYGVWF7kKYUrXRMZ0fgcXKH8559AbQ9FS2G7Ci6ZEdQLoVQy+zkRl2eR?=
 =?us-ascii?Q?3AduNeJcZtExWMnCYcUrKL63Q9Epb9HIu9aXiqvkMbqfFgIfHQrB5n4M+gIQ?=
 =?us-ascii?Q?Cv4jDEyFhYUoEFMe2VMMYzlUYAA/7KV3X26V2JF9cyqMPdl9u/Ep84idbf77?=
 =?us-ascii?Q?oyOcgBAjzkh+Ll09Gqt1Ui5QXnsNMF7TPa1ZHom60RgQgCn2BteS9LK50sas?=
 =?us-ascii?Q?7FqEevyE14VPaChbFPngsFySuBH7iCoGEJ4SfbISDpflbrh7QgBI7JKcymXF?=
 =?us-ascii?Q?aPBfF0lF2v1wqLHHT2aP4wYId2PqylhxqmYJVbIeeqQQLIPkckHC930Rhkwi?=
 =?us-ascii?Q?kHKPs9WIkzg6p3s0An6Q8HRdA5/oGoKdD44rItIt96CmULpXsPxyRVEkcbYJ?=
 =?us-ascii?Q?Vh0ijKrV4BdxfFleAwGhHgg0bLdFSo4zOxk7iYA7PQg1YDRRWRdLcvAw9MgK?=
 =?us-ascii?Q?eF+IOlDAyxYJYj2eIgIGw39ZMdAhBIK6YBMYQA/C4IRn+EE4y5PFN17KkkjS?=
 =?us-ascii?Q?iQh9MjYKjRPEgWxE/S/3Y/EgJqdgYvoxAm1j+iN1LmXGjiu64oR5gQyUfmMr?=
 =?us-ascii?Q?t6vaF44GTwsu9G24Ezmzu9bokqBMyrXKZP9tyZN43ZbWIAajY130bfoJxe9U?=
 =?us-ascii?Q?IHVjgoTeR8bC3y3fEOjI0RjSbdUrJ7Hqz6NE0r3Gd378GkXelHL+2bVrY5qE?=
 =?us-ascii?Q?0hXEoNqXexuFOrw4ft+tgB+T6kYFqQfY3IAa1Ygx2qzMelBDvkAONJVL2jzH?=
 =?us-ascii?Q?6r/II4uTh1bC8azwuJ3yrQfiovzhQoV/DoE96p/binqcL5hq3/PsMVxTwpN5?=
 =?us-ascii?Q?/m6lYCg+5suNKdheA7au6mYiztDe60h8XvrUk/p8hXBKrnrUihrBQb0CzELf?=
 =?us-ascii?Q?uPC89QSOlrnZqGFSCOEBJhC5NJIlwUwtmIq3AaljEuKxEVTVvPWvoFXgGilm?=
 =?us-ascii?Q?E3UXRrJcubeIa7rBfCmqXG+9RrTakXeFU+kpDm5fcnLpU7FImMZP8iLPAYEp?=
 =?us-ascii?Q?5EHX00pzrvFUix1qmeA6qvtSKd8GrzyQsyzn2CZuXIW178srm53wWQHb6k/r?=
 =?us-ascii?Q?27jZVmoOuV6hLUumuLrgp1gjkATCX5OAg+zR2bt6UZSrvIQ3MMkNvgSjUV/Y?=
 =?us-ascii?Q?Z8vxEWTgGWS9VeYLxphAjt3s7xdxOuKrXez2?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 11:50:15.9656
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13b58935-a670-48cf-93db-08ddc5f1431a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9541

TF-A is using PSCI 1.0 version for quite a long time but it was never
reflected in DT.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index b20a560741e5..5f26649c9e11 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -187,7 +187,7 @@ pmu {
 	};
 
 	psci {
-		compatible = "arm,psci-0.2";
+		compatible = "arm,psci-1.0", "arm,psci-0.2";
 		method = "smc";
 	};
 
-- 
2.43.0

base-commit: eed5dcc142db02f5c07b96b50eb72796b9d0dbc1
branch: zynqmp/dt2

