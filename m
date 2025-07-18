Return-Path: <linux-kernel+bounces-736787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D372AB0A1E0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 13:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 918093B3D0E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 11:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D222D876A;
	Fri, 18 Jul 2025 11:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wusU9Oe2"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFD72D77F0;
	Fri, 18 Jul 2025 11:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752837871; cv=fail; b=oTrMc/skPd5Eze374+eb8AXOByq7TZ/w+ijKCsws7Eo9Fh+M3NwitT2sb7nfK1GhI3w2LffEFOmHve3sGK/wveeIEyZonWrODPBZXxThzHD3/eeQxe1DGFrxDlfR966/iCAd7rnjxqTINPpuezrnB+Evsv5bOGxhVJIFZCZqxmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752837871; c=relaxed/simple;
	bh=tcqZav8s2lrCjMN5groouZ/gXf15w9BB89+28GGlRj8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TOTqSnGBCqYYG80mJa9Z36J/Xnnx0SiMVlYyKqgJr+2IUrxB5qNv6k0r2d59/ki5l782l0iNj9fHInBPHW9hjlKZBdWWtNf9pjB5uGi9YxmUsd8qoSgWrBOHPRPLaE+JeQzDEb/mRxxrLAYKwX7ZWWNSekAtY4DrhBG3cQqj4X4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wusU9Oe2; arc=fail smtp.client-ip=40.107.243.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R+JMqgXn5dllUlmwvbfQ5nzvAqDHC/fRYEPos9TyTen6X07eIAjZGn4M2kDeP0UGFqXwxkyimv7iqorzbSp+PG/JRLxqIe2qpVbVKf45GMAQN0/NNdAOtUVPuRhfpmBPcL3zIj2AAYYMO5fzAFReKDorMROrJHlYpEKOkTUXujmrzIBwZyG7m1ATUhr7Yjn8J9FlkAyjwSw5kzfjDUoRfwi6GkJ5cVQNcbuJRg905TRnVqLQIpHE/nK/22s5ZBL6Rz5/Yrqmq6h4yO23p7kpdkOUqX4YRzNKrnjCDbo5OhnGY21JZOECW1ABjQnXrl+H9/0HHZ3HOEhvTo6kNYPEqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XOgCMEoCJzELv83glUnmlOCcrr6VlVVYipxh4L0NKE4=;
 b=x25/W6mWabjfE0aqfUUZ+ctRllIiw/djD0SNyGtRY/uM84jXM01nxs6TZYVnJK1OEmeR5W02GqywBQdp7CYEI+PvAgnfggD0XgUlNjgrFjxT2n7NeXsft1gB3KzWOXCkTpYsKGAd+g9cwzuvz33mfbZfFC+oujdCeG6Rd4YrEK2sspt4o3SfmamkmP/h6E6JZpy7l4nNYh5n3njethm4t0INnLUocPZJ2ufJMRMbIFpXg/jQn2+WKc3DuTJoDbKlWcFteLJ4DM4FILpezXczZ1nAaZurATeI/E9N/3rJcey/OkX1pRHT2pGtFyw2JRaiAnvIamdlhgjSR4Ke16L87g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XOgCMEoCJzELv83glUnmlOCcrr6VlVVYipxh4L0NKE4=;
 b=wusU9Oe2eeTlYZ68D3NyYcaphcCjBkHFTEDugyqmZAMj2bp+uRCInidzgtUXDFw/6pZ35VMQ1PPsg1/5h3doSmUU18pxZGzoSk7ZWK4hO/YXA3XO+sOfS0MXP5XeKuHx3QWLGzIZwVHSLM/q9LcTwcJyGDiKBgr6qXYkk33tjoc=
Received: from SA9PR13CA0034.namprd13.prod.outlook.com (2603:10b6:806:22::9)
 by DM6PR12MB4058.namprd12.prod.outlook.com (2603:10b6:5:21d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Fri, 18 Jul
 2025 11:24:26 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:22:cafe::84) by SA9PR13CA0034.outlook.office365.com
 (2603:10b6:806:22::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.17 via Frontend Transport; Fri,
 18 Jul 2025 11:24:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8943.21 via Frontend Transport; Fri, 18 Jul 2025 11:24:26 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 18 Jul
 2025 06:24:19 -0500
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 18 Jul 2025 06:24:19 -0500
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, "open list:OPEN FIRMWARE
 AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "moderated
 list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 1/3] dt-bindings: soc: xilinx: Add support for K24, KR260 and KD240 CCs
Date: Fri, 18 Jul 2025 13:24:06 +0200
Message-ID: <8ff66d0dc4e0de6f239c25d43a2a96b4224305e8.1752837842.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1752837842.git.michal.simek@amd.com>
References: <cover.1752837842.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3826; i=michal.simek@amd.com; h=from:subject:message-id; bh=tcqZav8s2lrCjMN5groouZ/gXf15w9BB89+28GGlRj8=; b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRU6V2/faF92453E3fVvH0jvM5wse0065NllrKfOxI+L pzu2aG1rqOUhUGMg0FWTJFlOpOOw5pv15aKLY/Mh5nDygQyhIGLUwAmojydkWG69xWnZxcr7hxY si8vsnyWwXkfzqeO0VK6dzs1drzbFpPC8M+i4bDo//IjV9/Msf/a1XgtTV/nYIGJkquQ+OHjukJ zs7gB
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|DM6PR12MB4058:EE_
X-MS-Office365-Filtering-Correlation-Id: 98471440-b93d-4968-8cb3-08ddc5eda794
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pdAbRluWvi42m+pCQytH5bEkS9NGNiIvnajnn4ioNd/8g8qFtKb2g6xwo1wq?=
 =?us-ascii?Q?vt0aR+ayByp6g9DFeSNl6St6KH7PpuKzIAaiNYfghm/p1ehhjvJS1O76PyN8?=
 =?us-ascii?Q?Xq8tnH3U0TJWYEY5I+jWpBMTagG/WNTVKa8EM7kI26OUfF5DR9qbTWxOrdht?=
 =?us-ascii?Q?YakiLwDncKKTnIFXQMd6JJaM4fs4BFXwYGQdcfpvwuuj2kY7k+XRda2AXWLN?=
 =?us-ascii?Q?XnlJmUpDcSwlsiVBQzm0v9vaCgHP9xM4yVdMkyWMkf6uINDYUBVdlsSB8G6g?=
 =?us-ascii?Q?AT0v5l3+HL9KlYCUt0ofn8BKPMUSMpQnwvZi0KQdjp+uL7LcEY+BzbQflstS?=
 =?us-ascii?Q?mTifdZeYWiflcWxhrLzg7QBAfVd2eogqOXqgxkX48VqxnfSP6SqjvrKxdjNy?=
 =?us-ascii?Q?pWsiI55bL8ycFdP7NRHhtfx/e0wWlTFvGS3DSQd805QYZlqpphGKf1258keg?=
 =?us-ascii?Q?VebwIuWxRNjbAtbP3rFQfD5oewREycdw4wBXkDEY29oNr7Zh+H5+HNasfF8K?=
 =?us-ascii?Q?ZOcd53437c6KtddDxwLQqKfXmSwG44HVnJw4RJEq7Kra5eQW4QvIsAl89yY6?=
 =?us-ascii?Q?N8FTlFgnLfGGtAPOvGZNP38R08bql/mHb2FvRfUkQsvG4gclbntDAZkaBVEY?=
 =?us-ascii?Q?nxZfqYzRd/AS7JMxQ1ULOyZFeoAeGbIybANbFRBNbaTM94FGVu7mGbB4mOzo?=
 =?us-ascii?Q?6S7GDVNi6/YPYLhlPskAKQTKx1/KAnt9WYlD95mU+LDDqhyEtkm07VisBJXE?=
 =?us-ascii?Q?suI5lYgUzC8/QHV+68cPGDcdKzBouJkJA4c2o9NSAicj8IggL6EVsAC4FENd?=
 =?us-ascii?Q?aWFIWkSqLppkY4hNpbNQ6Rnxizx75CAbzCl+Ei7kJqDMscPwy0zxiw63vGh1?=
 =?us-ascii?Q?ZXKOy7y60D8F6ZkBXsu/ON3n0JUoeleqzGOtC/8LeOK88NeL489d+x13YF/W?=
 =?us-ascii?Q?pJNNQHxnKXw8at7i5Lc/UkWJKEFfISeUyV8G6cdduqs9AXILGe2IBUxQn9yM?=
 =?us-ascii?Q?qf6K5YgwuBMUBsxZ1hwwvQINYmWZ+as67jrzuNaG0T3oWTsK1vtwmhyz3lK+?=
 =?us-ascii?Q?azWm3ovvDBwoeZ0cHHbJ3t74fTSopBw+g+gYuE73oWLGm/68kIpzGoqjTgt7?=
 =?us-ascii?Q?O+q7kFTyRrWsfgsMsBoGCLVfCkyg6Qjt4jsVBrX+M5QIzJssJpKVRr2CmF9J?=
 =?us-ascii?Q?6ip15HzjaghDEbL2Mr7jgEiQ2KUukTYptsXNZaZOSQXVkTe45anRcpc6c0dn?=
 =?us-ascii?Q?hcBrv3183iIuKzZIlwDfEqGbOORVGwNlDgblM4up+6cKsMmnIk82iYptGSr8?=
 =?us-ascii?Q?JbfZBw38RZJm2ZDTyJu27CaMPp0ccYgJBUrQLE2fY4ONoj5qz2CrKkel04UH?=
 =?us-ascii?Q?2ylurdCEuBJvk0quxL3R4UcAUfTXij8aeySFcrZSqvPawgvlWP3lVbD+4EJy?=
 =?us-ascii?Q?voMjnQsr+Ep53C8vUZX8CrfwTIpB77duAwX1EoR4dMmqZ6CLt7J3LPpsslL3?=
 =?us-ascii?Q?FBA0SlzNWcDb2Ow+CpGHB8sG/7IMtTnSj4Aw?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 11:24:26.5282
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98471440-b93d-4968-8cb3-08ddc5eda794
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4058

The commit 7a4c31ee877a ("arm64: zynqmp: Add support for Xilinx Kria SOM
board") has added support for k26 and kv260 and the commit dbcd27526e6a
("dt-bindings: soc: xilinx: Add support for KV260 CC") has added support
for KV260 and this is follow up patch for adding description for k24 SOM,
KR260 (robotics platform) and KD240 (driver platform).
The bootflow is the same that's why for more information please take a look
at above commits.

The KD240 kit is based on smaller k24 SOM with only 2GB of memory.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 .../bindings/soc/xilinx/xilinx.yaml           | 81 +++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/xilinx/xilinx.yaml b/Documentation/devicetree/bindings/soc/xilinx/xilinx.yaml
index fb5c39c79d28..c9f99e0df2b3 100644
--- a/Documentation/devicetree/bindings/soc/xilinx/xilinx.yaml
+++ b/Documentation/devicetree/bindings/soc/xilinx/xilinx.yaml
@@ -116,6 +116,36 @@ properties:
           - const: xlnx,zynqmp-zcu111
           - const: xlnx,zynqmp
 
+      - description: Xilinx Kria SOMs K24
+        minItems: 3
+        items:
+          enum:
+            - xlnx,zynqmp-sm-k24-rev1
+            - xlnx,zynqmp-sm-k24-revB
+            - xlnx,zynqmp-sm-k24-revA
+            - xlnx,zynqmp-sm-k24
+            - xlnx,zynqmp
+        allOf:
+          - contains:
+              const: xlnx,zynqmp
+          - contains:
+              const: xlnx,zynqmp-sm-k24
+
+      - description: Xilinx Kria SOMs K24 (starter)
+        minItems: 3
+        items:
+          enum:
+            - xlnx,zynqmp-smk-k24-rev1
+            - xlnx,zynqmp-smk-k24-revB
+            - xlnx,zynqmp-smk-k24-revA
+            - xlnx,zynqmp-smk-k24
+            - xlnx,zynqmp
+        allOf:
+          - contains:
+              const: xlnx,zynqmp
+          - contains:
+              const: xlnx,zynqmp-smk-k24
+
       - description: Xilinx Kria SOMs
         minItems: 3
         items:
@@ -148,6 +178,57 @@ properties:
           - contains:
               const: xlnx,zynqmp-smk-k26
 
+      - description: Xilinx Kria SOM KD240 revA/B/1
+        minItems: 3
+        items:
+          enum:
+            - xlnx,zynqmp-sk-kd240-rev1
+            - xlnx,zynqmp-sk-kd240-revB
+            - xlnx,zynqmp-sk-kd240-revA
+            - xlnx,zynqmp-sk-kd240
+            - xlnx,zynqmp
+        allOf:
+          - contains:
+              const: xlnx,zynqmp-sk-kd240-revA
+          - contains:
+              const: xlnx,zynqmp-sk-kd240
+          - contains:
+              const: xlnx,zynqmp
+
+      - description: Xilinx Kria SOM KR260 revA/Y/Z
+        minItems: 3
+        items:
+          enum:
+            - xlnx,zynqmp-sk-kr260-revA
+            - xlnx,zynqmp-sk-kr260-revY
+            - xlnx,zynqmp-sk-kr260-revZ
+            - xlnx,zynqmp-sk-kr260
+            - xlnx,zynqmp
+        allOf:
+          - contains:
+              const: xlnx,zynqmp-sk-kr260-revA
+          - contains:
+              const: xlnx,zynqmp-sk-kr260
+          - contains:
+              const: xlnx,zynqmp
+
+      - description: Xilinx Kria SOM KR260 rev2/1/B
+        minItems: 3
+        items:
+          enum:
+            - xlnx,zynqmp-sk-kr260-rev2
+            - xlnx,zynqmp-sk-kr260-rev1
+            - xlnx,zynqmp-sk-kr260-revB
+            - xlnx,zynqmp-sk-kr260
+            - xlnx,zynqmp
+        allOf:
+          - contains:
+              const: xlnx,zynqmp-sk-kr260-revB
+          - contains:
+              const: xlnx,zynqmp-sk-kr260
+          - contains:
+              const: xlnx,zynqmp
+
       - description: Xilinx Kria SOM KV260 revA/Y/Z
         minItems: 3
         items:
-- 
2.43.0


