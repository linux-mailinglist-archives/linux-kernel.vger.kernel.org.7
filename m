Return-Path: <linux-kernel+bounces-875078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA56C1829E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 04:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D09F64EAC7E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 03:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0C429BDA5;
	Wed, 29 Oct 2025 03:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GmwvlsWq"
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012021.outbound.protection.outlook.com [40.93.195.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1AE238C3A;
	Wed, 29 Oct 2025 03:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761708144; cv=fail; b=fbI6kRMtcJRNzb6xlNzmh744QzyirH+ywvI4nMUn9cDQYlidTwzokIARROAbnnC6h4NiAZo/rhlTKaTh7i6GlJ/nGTPPX7o1Rx9zwNhkiJm42W2tI19lx5L7yIpGt3KksatlJ6niQJJXxwJ63xnguxjdNw8xpQZ4p0mJ19WVa70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761708144; c=relaxed/simple;
	bh=/EDM4yiC82BSAeD06UfjmHEGW6PDcttncOH9/ywdMCo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s9Gx39p9FWYhVN1shG3L55Pqp9bo0+bGusvYhcvut7zdyilyUn9yVil3OEj9ZWPX/gcHA4QATwmh3D0cEARtnK2brH7VPFqZV+iVTwFugVJa6q2q6Y0XCe7cZAAyy4dv/FC5p+4hp03u3T5ygPi0M43J2dquew3Sdn9L7gX2luY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GmwvlsWq; arc=fail smtp.client-ip=40.93.195.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EoPVgJO66sPmEfImFEq5TAzFBdOuvqfBTXtJPtq8blV69/NG3rjWkpG9PL7hz2RHnrMbeZ/dXpwY7S74O683GNffBmIxkd5YD4g2yRtLQTIyrUZFZopgxiM9/6vLu87TUzyj48kiMfFglMzGbPCUyFx4yKcnJThbLWfB9N4OfJDVaWaAw3pm4Gu7X6sWw87UOwgbTlb1k0Pw/S8QYvI6eViStVEOfCVuuPu6txiZSqbtB6VTBILtxmrKXMAptLlrh6Gp3f3aaXVV82/CeLBzv8Ymcu1marKTPoDxzKpq7zA8u0QV4kY0BeY6YkVsTHJRo/U8D2xFXfCtt8apVWPAwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qu6VmrqWmosA9zugNYnFMbUbxzHsij8zlrPGdc6XS94=;
 b=L+RujOPJP+7S6zURinqsMMaE+SxteKvOpbyEG70V8rCjAwfKZpLCkBVIbqF7/VACxb59qE1FeNSYGHte+Z9uPkh3p4n27n2fKkE/3j32pZPC46eYrLaYJ8uNKpFumABKYTuZoP82fKpsYgY9pnkBSMwqf/FXHl+ShO8NlVHKim7y59qalLq/D0OCTyS5fRF0SM3Fi7Y6Ko/MIN0UgcK8p9NFlCe1eBnhLFC7q87CX9PMOK+3RtcVtpATX/qbeIFHtwpagnQom19sQxtW3Rehsjv78ee0G56guGMHrQrXv6S1sWWbm69jQgdP5922Pp11fFzq/E0h/uFUyapZAmSE1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qu6VmrqWmosA9zugNYnFMbUbxzHsij8zlrPGdc6XS94=;
 b=GmwvlsWqO5rbxZwgE7E2X/QwzYP4NrD+Z5rRbtmC2VQ8U75+8VTZq7DmVxjtPbElcQbtBtcYaPHmtkLqCvrBcKOKC+C8+2He2mt2wyiE4jbu0spiSS8lYGZWt4hXKs9AOTeI0FXM6ODR+ZcdQN45E8gvs4k3ZbOYMnL2vUMSxzM=
Received: from BY5PR17CA0011.namprd17.prod.outlook.com (2603:10b6:a03:1b8::24)
 by MW6PR10MB7688.namprd10.prod.outlook.com (2603:10b6:303:246::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 29 Oct
 2025 03:22:18 +0000
Received: from SJ5PEPF000001D7.namprd05.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::90) by BY5PR17CA0011.outlook.office365.com
 (2603:10b6:a03:1b8::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Wed,
 29 Oct 2025 03:22:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ5PEPF000001D7.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 03:22:16 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Oct
 2025 22:22:05 -0500
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Oct
 2025 22:22:04 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 28 Oct 2025 22:22:04 -0500
Received: from localhost (ula0502350.dhcp.ti.com [172.24.233.249])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59T3M3ev3352138;
	Tue, 28 Oct 2025 22:22:04 -0500
From: Paresh Bhagat <p-bhagat@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <praneeth@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<khasim@ti.com>, <v-singh1@ti.com>, <afd@ti.com>, <bb@ti.com>, <s-k6@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-am62d2-evm: Remove unused ospi0 chip select pins
Date: Wed, 29 Oct 2025 08:51:44 +0530
Message-ID: <20251029032144.502603-1-p-bhagat@ti.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D7:EE_|MW6PR10MB7688:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ce35674-7ca8-40f1-73ac-08de169a5cc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013|34020700016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oxZt184DPxYzh3vqJj+yPG3wosCEvXKb8m90fB3rkfBGu0dUnWY9e+m14BKd?=
 =?us-ascii?Q?x8vTH7RslxmhHpJ07iX1LQdnf9m1oSqm7tjpawySfBkuphebF+wgN871vw4O?=
 =?us-ascii?Q?hJ3MU6ZAcGmkaMuffqvdJgzrVhuYIxP6+7hU+GKpTgxJUAADi1nZoDm/AFpA?=
 =?us-ascii?Q?aaYoIA7SI2mgopL3cDBiq02BktB286P4m3oxarQtUGFNvfO+20cm3fwplaCD?=
 =?us-ascii?Q?SCmX11kMORsTl712IBt7MTradIzUs8UB1KD6X6h8jkENrY9WUZLGi4U6LBhu?=
 =?us-ascii?Q?FhQKZcp+aMFO0sE/l4E1Yj5FvURkaeMvEMy9yRcHYbxJ0QCrPuNZqTIbua2x?=
 =?us-ascii?Q?KHT2Z2bmchhiKXaYi/U+yhccDfked2BEipvjQMY2QWROskKGywbypNajIZk2?=
 =?us-ascii?Q?LXCRjqYGJQFIgYfoFib+1uS8mJSY3r1tqo92YuuTsVN7pNsFb+t8hPDw9Y0T?=
 =?us-ascii?Q?c+YUQTqfvF/xBKGlX26A/yQx8P7UobMFRPVC65Yzw7lpZsYtbSm9+h+2CAit?=
 =?us-ascii?Q?md1LdtmMe9XYZTIKD+OX1wlzVDso2qcbel8FI6sWHXpcl6Xm3Ke9pZMKnv95?=
 =?us-ascii?Q?oCWv+Lwq+4Gz1/b1JBNNChs6w580KuYAkhh87cFWMbbGWH92NvTn1S8zDKv7?=
 =?us-ascii?Q?tOjOhn0bjdsQUEv0DeUvwk/wvdxcnL/XzAFgzUdRdhLAoq4/GeMo5d4CPeEw?=
 =?us-ascii?Q?6OwGE9qQ4NrOE1ZbgVPDpxnQHQ6IXYLj7Wyn0gDEpWcqUMTX/LOiLUoxtNUC?=
 =?us-ascii?Q?cxTUqiHaNj9z731bBJD2Q55zyv0c6iPHJK4ObUv7ipADUPLeWS89byKdAJU0?=
 =?us-ascii?Q?4PwvfGOchuBWQATvwFacKDRjuzf66xP3dQ8uFkLyx7K9xElIGzwsH/Czw82W?=
 =?us-ascii?Q?5FwgZ5PZ8ag+/KhAGWfNJRIVftDDgeEJSUZHPoJ5yXcL4DR9PTOTA24ZTPUn?=
 =?us-ascii?Q?NbbJYvTqx2KW3mrtGBm74ntaeuWSvKfMrxX+qxfbwi3dIb6kj3qw+NjEZgd3?=
 =?us-ascii?Q?UVaxJ3zgo/4ek4rP7gZJjGkmFuqSSblRVMVD8N5iynvXCJ78+PPW89fJZzyC?=
 =?us-ascii?Q?iJ+9bKzrWC8b8Ku2fVXj16/FuTJRTUo7lnSCl9z9FDPtMezYKC7N2d6pMV1V?=
 =?us-ascii?Q?ucF8aXicvQQ1yC25laqTVPrjce5ykxN/CzfE6MPRBWukipt9Qnr3uGMQ7W8R?=
 =?us-ascii?Q?6nfv1wTHvtg2ca3E64oQOyHJ9QsKWoWbnMWrpUpRRWdCSJ64s90sx5w7NWZP?=
 =?us-ascii?Q?qmKh1krOU9cQA0braYf4eRewtngN9USQqkwQeihf65IxQCCxXleSz225++pN?=
 =?us-ascii?Q?tjA7hhXtvuaojlETisxj1wo6/omgIQCOa3MfE6z6xSiG3wpPymXFJZLvIpC+?=
 =?us-ascii?Q?gUqBCEOq40g5KAqA0yrEwtETcHOGxBubKasGwTJugq4Gl92ufjhly1wQPVQC?=
 =?us-ascii?Q?i4cwWJAFJQmilnEDkgyGxbpkhDQbdNn/6mcZfbr1q26wvu/1B71m79W3Yetu?=
 =?us-ascii?Q?iavHg+i5cHavtwE=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013)(34020700016);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 03:22:16.8980
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ce35674-7ca8-40f1-73ac-08de169a5cc0
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7688

Since only a single flash device is connected to ospi0 retain only the
OSPI0_CSn0 pin configuration and remove the unused CSn1-CSn3 pins from
the default pinctrl. This simplifies the ospi0 pin configuration without
affecting functionality.

Signed-off-by: Paresh Bhagat <p-bhagat@ti.com>
---
Boot logs
https://gist.github.com/paresh-bhagat12/ac3b7e8a39f6f35004d9c51c6384f0c4

Datasheet - https://www.ti.com/lit/ug/sprujd4/sprujd4.pdf
Schematics - https://www.ti.com/lit/zip/sprcal5

 arch/arm64/boot/dts/ti/k3-am62d2-evm.dts | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62d2-evm.dts b/arch/arm64/boot/dts/ti/k3-am62d2-evm.dts
index 83af889e790a..bb5af52ae8b7 100644
--- a/arch/arm64/boot/dts/ti/k3-am62d2-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62d2-evm.dts
@@ -355,9 +355,6 @@ ospi0_pins_default: ospi0-default-pins {
 		pinctrl-single,pins = <
 			AM62DX_IOPAD(0x0000, PIN_OUTPUT, 0) /* (L22) OSPI0_CLK */
 			AM62DX_IOPAD(0x002c, PIN_OUTPUT, 0) /* (H21) OSPI0_CSn0 */
-			AM62DX_IOPAD(0x0030, PIN_OUTPUT, 0) /* (G19) OSPI0_CSn1 */
-			AM62DX_IOPAD(0x0034, PIN_OUTPUT, 0) /* (K20) OSPI0_CSn2 */
-			AM62DX_IOPAD(0x0038, PIN_OUTPUT, 0) /* (G20) OSPI0_CSn3 */
 			AM62DX_IOPAD(0x000c, PIN_INPUT, 0) /* (J21) OSPI0_D0 */
 			AM62DX_IOPAD(0x0010, PIN_INPUT, 0) /* (J18) OSPI0_D1 */
 			AM62DX_IOPAD(0x0014, PIN_INPUT, 0) /* (J19) OSPI0_D2 */
-- 
2.34.1


