Return-Path: <linux-kernel+bounces-756152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B758B1B096
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 11:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A69A93BDC83
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 09:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D682586C2;
	Tue,  5 Aug 2025 09:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b="AY1TJv4P"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2136.outbound.protection.outlook.com [40.107.241.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477541BD9D0;
	Tue,  5 Aug 2025 09:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754384443; cv=fail; b=tsJJvaGLHMwgqCYhCKihSBEVsB0rd69e31wWvZTz4dEKGdltxbF36/YIo6bFuFUcPxn6Nfa0OdutTal16UnWF6Y+Xv9vkbmPv863rr/kNIWACSURyfCfLhiQWjYr9TdSWyg8vEeLz4F1mlW7U6Zpn+cJkp/qOtoGtSEJf6V/e9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754384443; c=relaxed/simple;
	bh=Zr581+lTKPTqIO60GkmJLD9jydx45uxhWT7p+OZLs8Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WBwM0xteAd/hqJtrcZUGU1ITXGFT9/n9rdYuhClPmk/PdhrTbp19Mb6LBLtR+axa6h+NDwLdlmNVX9jhf2hZFg9yG61LCMYPIgYGQ08PCKyaRZzyz2lTNG9R8ekTZ3w0N33LZup8XpazJPKx0hywShAkHa9PHaeP88xvNn//L6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b=AY1TJv4P; arc=fail smtp.client-ip=40.107.241.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e8+HyTd3I/k7KV7CJIw8cQVpbNg3FxhUTLHDgLc1FPu0/7uvb/7+liYpNIjaKTyV/K/ykbCMZ2O/raSTrKk9mAYdODIlrvpgBDbKQxpzA+yox4BgYXcTzR561TOy2vM39IUva2DvkIVNQVlkpUFiM1wElbuaSOyYjFfwGsPkeMypVDHGOl2LtBEMgHLK3LIhRlQokk/26tgOFyNWK/rB+c2VQ3Z9K24MAgoQr57dnz8PbPjTiO3OgEmdKVDVyU7H/bPCnvHBkzvUqZkunW2Y2Q8ihlht5knQni+yy3pZO05caoi4eJ3PitEwZ8CLFyVB4ko5jY2TjkrqBCHW4TGgqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XsbbhY0O+SUEUcKMvq8evyOiowKd+kjZi0OfQ+Da9js=;
 b=yUX6w2fx3ZDtehOL+8a3xgA+YxKYIt5mcFULNAkiuLF7NU4HeY7H3pJ6Mrw9TBStWjSrnVmd9e2cHJ14T1HwXfiRbJeR8tcveNRVwpd0sp+6CMj3sTsFgiCg9PwvzlB/NJk7gM0vYQ4hK8bnFJ7ThHE9MHB8tvj9FAYSDGFGgP/KmUR3Q+1Y4/XSOVPqeVA6ON4B0mHRGPkin5PYNNxkhBJELRB23Y6zzCn+ShPCIlkvhMgcb/RXPOa5rg6zLiAfRe6inza5AG1Y98eEeTaNyOR1jbnyFH4+Y9CuSV6xmgOr1VNsvLJcIhbOdrHpNaYkzAgu8E/8qe+WWfPNGr9yTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=ti.com smtp.mailfrom=phytec.de; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine header.from=phytec.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XsbbhY0O+SUEUcKMvq8evyOiowKd+kjZi0OfQ+Da9js=;
 b=AY1TJv4PmMLxmF7Q/2HYDKaIftPzu3lqdqG6KZ/EQXNlD2uCXsI12myWau7oUe8okE9AciCKMr0CKYUi1QnOibHtb6Mnb0v7P/EKByOnLVHfOmHBsagz6s6YdKiLntHxNkxOq3yjHrsDIDkMwh54t+k39D61Es4qCkMZw1dZcXGFzzR+YbuAqS9oFSAcgEAPRaPqxSt/vpX7XYE3PFSynzwjLxEGzf91YAjQIZ5pKf6FyBa7kPpD5Irt0b+Xjof1r9Ex3zM1YMJMArmpHzzXNjpCZSy7G7QNA64/AWkp8/cW+AmVdPUp6h1TcWI7sjJO4m0fY/LoqMaviSwe4Q2t8Q==
Received: from AS4P191CA0041.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:657::14)
 by DU2P195MB2422.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:49d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Tue, 5 Aug
 2025 09:00:31 +0000
Received: from AMS1EPF0000003F.eurprd04.prod.outlook.com
 (2603:10a6:20b:657:cafe::25) by AS4P191CA0041.outlook.office365.com
 (2603:10a6:20b:657::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.21 via Frontend Transport; Tue,
 5 Aug 2025 09:00:31 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AMS1EPF0000003F.mail.protection.outlook.com (10.167.16.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Tue, 5 Aug 2025 09:00:30 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Tue, 5 Aug
 2025 11:00:29 +0200
Received: from phytec.de (172.25.0.51) by Florix.phytec.de (172.25.0.13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Tue, 5 Aug
 2025 11:00:28 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <upstream@lists.phytec.de>
Subject: [PATCH] arm64: dts: ti: k3-am62a-phycore-som: Add 1.4GHz opp entry
Date: Tue, 5 Aug 2025 11:00:20 +0200
Message-ID: <20250805090021.1407753-1-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF0000003F:EE_|DU2P195MB2422:EE_
X-MS-Office365-Filtering-Correlation-Id: e53bddf1-e754-4cd0-3e19-08ddd3fe875d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IxYlTKY54GkBW1PUVI4Ctp8pJMa9nVBHr7YMirxacuktB4IfMpU0075cuI6y?=
 =?us-ascii?Q?oLe0QCrRziYayFssaUy7LPXK4wqfFqlq+hjjeGCoR2IgyH/4bFIYAkEFGi/p?=
 =?us-ascii?Q?OmvRDKH7vkkan+DmZrBTc/TEOp6WLXG2kKCJezrkLBBB7tvdsYB8/4zyEzlH?=
 =?us-ascii?Q?ILLRIAxeEN4WFaoToNnPDMgezR6PxMPeQJbeTvkbe3ClQN5xr+D5V5vXUgSm?=
 =?us-ascii?Q?sNLks50Pv3KSQpsL+rOXXn2fZh/zIiWYyIzDiVidLrh8OvETy5bVADAMR8GT?=
 =?us-ascii?Q?04jgCfLvvtXUQDEOoEoUqjjeyPMRKEkBpAscrQ3n7xVJ8b9vpn+/mm1KYxPb?=
 =?us-ascii?Q?S+kFwoW3omRpZKjYsd2iXdDWzzXE8Kvq9V7YOXk02JgqJn5YPoGjjydFvO7f?=
 =?us-ascii?Q?Z6xKMBBJjOoROgPyVDkRjcim6vYd5EuabYaRqaNZVIToT0mYionO6pCxaRmh?=
 =?us-ascii?Q?NeGC8T6oR3NcVjszctc5ZOZj6KqmP3XPLA+9ENRaEDrLSk27iNk5WnFQl8Qy?=
 =?us-ascii?Q?nTiv9QQJwDE87qmXozthOMS6D2bp6PDg3i3xazVFC5qZt8iMMmmNOOgElNLH?=
 =?us-ascii?Q?X4hGIjZvV2YQb816XkoXhofa+4FLE2/M9eZX0MyuPljCgLMVfGlaV/z+NhD5?=
 =?us-ascii?Q?mkLsstNjKU9fs86B9nqEE/CArKZ8CXq28e71KgLYrIx4gShXiRAaEUI0lGut?=
 =?us-ascii?Q?R6gItX5FAYOr8ldA0tNxc3U4Sugeif3mSeTmai3eqb4rf7V/IVJTTGuS4qlz?=
 =?us-ascii?Q?FWujVpXsFI8mRjr4+o9+Tc9L+IcsFYR4WstBL3bFHEDOiEEa6UXSMr6TLZYi?=
 =?us-ascii?Q?iCW/VTvHg0qookFJMHwk7Aq8mEOeRzZWV4NKEvmCxmq/Z3nYl9+JpWz1EM6i?=
 =?us-ascii?Q?8l/9LDg++ub1ruZjBCQJS8Ua7Zgw9gNQ9CSFKwuR+xbnDNnd8s5277Oa4J4x?=
 =?us-ascii?Q?Cs6TKl+9lcb2qgAisQzDQ31IQvR6Qc8mQB5Ur7NeqAsz4myZBADz/yM4H+kw?=
 =?us-ascii?Q?MIB/oH3paVhRSHbmnSYCHgNSjg8gf+oLNDdOYaVCzO0WWdCjteljthAjChyZ?=
 =?us-ascii?Q?zSfHNa3iZpwdRaGzIAwob7Pt0Fm9qKG0JWTT1xgwfODVcI+pvKuXMgi1fkND?=
 =?us-ascii?Q?6LEIqGh0YqRcSOkaIAEBCDXjqIEZvAjo7fiNyM9ms5jvNvOiiUGzEekAPBLU?=
 =?us-ascii?Q?dasT66qZfLEOWyhFy4r4ZFOayRLPOu38X+ZlgqMdV+ZukctN06HqmUpTLt6C?=
 =?us-ascii?Q?+B1WEjsr8BM8U3eXXVorg2f8iXdk255rsahFOiwReqGaIVKS6oS3BLI/cEtK?=
 =?us-ascii?Q?IfBt+QBuhOlVbqmD+OCZLPolAN7qqdje3S6rOm/8WZrouSbgYbS0MWS9W7Iz?=
 =?us-ascii?Q?ciZ3UqqgH0XLltN7IeSPW4tyYK85qNEmQRA8MHcnHZBZsMka9Xb4tOXz9vBH?=
 =?us-ascii?Q?0FkE/BwuJpPFZF5MAhMlX8x9ximoiVQIguXx427+wYWmSRl7NiaBS3C0ZrZn?=
 =?us-ascii?Q?DjeuVvzzZuKdK0H+aIo01KmoCNLYiaMcfEP+?=
X-Forefront-Antispam-Report:
	CIP:91.26.50.189;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:Diagnostix.phytec.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(13003099007);DIR:OUT;SFP:1102;
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 09:00:30.1819
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e53bddf1-e754-4cd0-3e19-08ddd3fe875d
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29;Ip=[91.26.50.189];Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000003F.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2P195MB2422

The phyCORE-AM62Ax is capable of supplying 0v85 to the VDD_CORE
which allows the Cortex-A53s to operate at 1.4GHz according to chapter
7.5 of the SoC's data sheet[0]. Append the 1.4Ghz entry to the OPP table
to enable this OPP

[0] https://www.ti.com/lit/ds/symlink/am62a3.pdf

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 arch/arm64/boot/dts/ti/k3-am62a-phycore-som.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a-phycore-som.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-phycore-som.dtsi
index 5dc5d2cb20cc..207ca00630d1 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-phycore-som.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-phycore-som.dtsi
@@ -200,6 +200,15 @@ AM62AX_IOPAD(0x1f4, PIN_INPUT, 0) /* (D16) EXTINTn */
 	};
 };
 
+&a53_opp_table {
+	/* Requires VDD_CORE at 0v85 */
+	opp-1400000000 {
+		opp-hz = /bits/ 64 <1400000000>;
+		opp-supported-hw = <0x01 0x0004>;
+		clock-latency-ns = <6000000>;
+	};
+};
+
 &c7x_0 {
 	mboxes = <&mailbox0_cluster1 &mbox_c7x_0>;
 	memory-region = <&c7x_0_dma_memory_region>,
-- 
2.48.1


