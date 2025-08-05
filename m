Return-Path: <linux-kernel+bounces-756153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 709A8B1B097
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 11:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C8A63BE049
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 09:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18121258CF0;
	Tue,  5 Aug 2025 09:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b="AuRxc6zn"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2106.outbound.protection.outlook.com [40.107.20.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8A61D63DF;
	Tue,  5 Aug 2025 09:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754384443; cv=fail; b=S+ygu1VaqyKYJ2qeIvJCsEojhlDCbwa6vfXACpIinWAZgOPbdlGN2SA1ZdBj/0mQSKiKeCQ5xtqozPfzZhuVDwLj5kCPEcVh6blKcFw4GfX2ZMLsnJ+XKHA7jPEjIPsp6EVeKqoxe8urx+1FpOHv0y9g27wlQ7NDwe0hyWu6Iys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754384443; c=relaxed/simple;
	bh=Zr581+lTKPTqIO60GkmJLD9jydx45uxhWT7p+OZLs8Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=doB4fNn1ME6R1IblP8KaIv9K78bXELnrh5ZsAPWLBvGxSMSLe01y1ufJuMrGHeciBrhMZpf5CiSgoDSV7wYMnEjV1AqsUwtGoPdseuyTe7mdbE/7DUJtcHZIZHESilIoHdzq5md6GRzeXB8IoC7VSJsfEzKDE1CQNpcwcrucnqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b=AuRxc6zn; arc=fail smtp.client-ip=40.107.20.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VE1PaYJLnDuvWcKhbLoQUJacEZsME50JSBwgV2kGmadgkdWriliQ7e3pXkF0SjS+2rTSFlwN1PdHYByPNhBt5oBY9GLzsz6TX9oUQnxACrWa4+2AXqDwKd1CkHkqXb5ak0V3PJ6MpZ3wgJu34kTtt4t0xwOBqqry7DAT7kKwthgRYlPLp0tz9Z5w93Ka3vpfBV8nvbNNkg2cNUao6ravm/GfD3IDQoBGJn8J2Xc7TSbaGtmqTTrov+G5qECOd7QKfrt8xAB4n6FSoCmUDvSQGJX5qznUc7HC52jh+nTLSJ3Q63v3ngaBCLuHgwuEf3nHY9xuopUATTgWxunOs8bwvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XsbbhY0O+SUEUcKMvq8evyOiowKd+kjZi0OfQ+Da9js=;
 b=vpuGytD8S2cq0NKqX3XDkDJnXGa7KKVZTqtboQlLg0/jg4/0863+LA+ONLJwIznIDJ044sxM/tlI46mIn8nF/iD7CeRGwnsNO2n63h/tgGZpnSCAY77VTQSdE9OTXnVLraVjfzmLbjFUUHa5EBmHIe/pVB4rN1locrKiD4KISTL1RUqiMFL7zZjaIjEqGGMukIUd2vfxyuG9+axbbkyJg8FHreNzlYN09DICFWGiYZ4B6IrkZHeK9hlZMnERvoF3IgjlTsXKO6dao9b6hSEG521pWaxE6e0J0zu6bkJT8GXLh7tKjX9YwR33yOmcp60nQIDeIglztH+3QAPTAfUkWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=ti.com smtp.mailfrom=phytec.de; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine header.from=phytec.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XsbbhY0O+SUEUcKMvq8evyOiowKd+kjZi0OfQ+Da9js=;
 b=AuRxc6znRuLqYHmG8RWeechDsjAzSI3cwArksr6B8kPDpbHQkM23VQJvq1Z/3amJ7tHfzW10NiTjw7qkKCI7AAcmNGmDg+Q0pTu4dMD8AER13pTAKwV3GmfTEixHQQLL1Rr80w4rKJWNiycWJNFxRqqAXdqjXAvlaaaldQO2W8ZHLMuQoWRsdHunW3X+mcRyn6QBQSJjwSVEBjEG80HRslH+EUOh4ikUqLucJHe79K+uAb1anbFrGbCuX/DWgCWve3/F2F0rSGPK0HyH3fLmXMvdabKa6h7vuSgt1L+F25mQoj7i0+WaRNFvzGJmSYuf5aYbohXUXDEeIE+sJLsktw==
Received: from AS4P191CA0036.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:657::18)
 by GVXP195MB2502.EURP195.PROD.OUTLOOK.COM (2603:10a6:150:1b6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Tue, 5 Aug
 2025 09:00:32 +0000
Received: from AMS1EPF0000003F.eurprd04.prod.outlook.com
 (2603:10a6:20b:657:cafe::9a) by AS4P191CA0036.outlook.office365.com
 (2603:10a6:20b:657::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.21 via Frontend Transport; Tue,
 5 Aug 2025 09:00:32 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AMS1EPF0000003F.mail.protection.outlook.com (10.167.16.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Tue, 5 Aug 2025 09:00:31 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Tue, 5 Aug
 2025 11:00:29 +0200
Received: from phytec.de (172.25.0.51) by Florix.phytec.de (172.25.0.13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Tue, 5 Aug
 2025 11:00:29 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <upstream@lists.phytec.de>
Subject: [PATCH] arm64: dts: ti: k3-am62a-phycore-som: Add 1.4GHz opp entry
Date: Tue, 5 Aug 2025 11:00:21 +0200
Message-ID: <20250805090021.1407753-2-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250805090021.1407753-1-w.egorov@phytec.de>
References: <20250805090021.1407753-1-w.egorov@phytec.de>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF0000003F:EE_|GVXP195MB2502:EE_
X-MS-Office365-Filtering-Correlation-Id: 87efe482-6a17-4bc3-bfa5-08ddd3fe8868
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fA0GOdKfAeQmRGtov7kfQFQ6NSvMgLwUS9MFgXMXzy6afmIRWucNZWQaaA/9?=
 =?us-ascii?Q?+uVamPPsR0QVaFgUBKbupDMKVDXb4k1HeLwM08XBv3hxZPPMQuRYmQRq8nZw?=
 =?us-ascii?Q?OPxtQy1qW+LbW70/AZszMEW0SyLNpYyzrudi/0lDlxU871b5QirVtCpt4qdG?=
 =?us-ascii?Q?5thTnXZGDHtdU6/CeYETAjt/CMIrGt7DKBGp2JOSy9/47TLH8B6h7yXhFgLC?=
 =?us-ascii?Q?/RwX0T0Aa6tVaiLYhbjwuxP6k0YAfMRR2VnkMuCXW0YIIZkXmUWygYSCeZ6B?=
 =?us-ascii?Q?zOIf1FesAeZAqeHi56TzK69NzCliptkhGB0ODEXVq1I+iiR2j+8i8BaWktSh?=
 =?us-ascii?Q?unYkswaqI+X3RzVtT+PTJREw6Z2sJeQlkWO9WDSq6fEaav8w4tAXvrHDYVco?=
 =?us-ascii?Q?xIwmB1kok+FnOdzeAFZ2do1/5uRm5OzFA3EkSvPwonRp7X+Wep8N/Yg3e6+z?=
 =?us-ascii?Q?tx/Jl7QacuSMAZc60qxJigwCZ1qf4o/jDgLByncB4Y9Hpb2Dtf08kzMUHdU8?=
 =?us-ascii?Q?AiyxVBVGbnLajPDFRK0s/Pw53NI60XlCxIo8AULh/+wVVY4cM5dHnnCKULIm?=
 =?us-ascii?Q?7B4oq0i2cTF42Cq0XsT27+m14O1OOQ4y3i6b5pYo5udOZyVk+h4Jf2aY9YMT?=
 =?us-ascii?Q?eLOU1m+MPVym4+GjLXdJ30OKhU7CVmsnDzNHrB+2awnzYVd8QVcKhUb2v/2N?=
 =?us-ascii?Q?T++FPIQFtWcUyCA1W1f+uYZAHNKuavMcetDjnM4zTuoY0g6IMZV2QsrsiqZe?=
 =?us-ascii?Q?o18IQnGjDcbcv0Mme9+b2oGrGqgsPg2Nad+selFWAujz7tqHYri4xIheRmNP?=
 =?us-ascii?Q?nzeg5U2UCM/V7aTvU1oV29ilJozwMBHEQMJdHM2Pk83TjfCCPG/3PpD5UDk8?=
 =?us-ascii?Q?hGgNn/xvGot1oBGQd4WlxizvtfyZ2ZfkMYtghN5At1CzaGSRl8AbuIDoHr3V?=
 =?us-ascii?Q?LbHIqQzYqvbVlwjdMubZJ3b87/bIJ7YYSGzdU6QlIBxfhce6hvLiru3wuVtF?=
 =?us-ascii?Q?C/yxT7B5hYgokNStlvcdleZj+Jkk6+ZcVEMXpCXG9BoMkeDtt9TaZF7Qr9gU?=
 =?us-ascii?Q?YIEHLIot35xObObDcZxlz1Jn+IoVg345CycT6geQOnl78jyeUfvAgyviPR6z?=
 =?us-ascii?Q?73tpl73x7nKSfucajtq3a9G57IGQzAJEII1NVECmHI+TdET0UyT0aF8fKbj4?=
 =?us-ascii?Q?eV01tpqsc2RKSqACdRYtl0QyctZb3K1uD9tAZKjWGYIco564Rj+pKwW3SJTN?=
 =?us-ascii?Q?QLb+sH9nFfy8XGAxsv+zCOFBZUDhxd9b0Xey8ludd7nxV1aOXLdUXWTI+Kvi?=
 =?us-ascii?Q?Z31nEcF9qszgHtlGWD7BTUrsiX7Kc1IbkSKbduWBOC+dL9HfAQxqoAgMUIf9?=
 =?us-ascii?Q?BT5Dbw9r00ioc+mm6UoD0bt06iJzgVaUOhz4yKKuwM7alUG/Ih9om2FB7z/b?=
 =?us-ascii?Q?b9fQP3rJlxFkDJSvLWifwz0zidvMimFPRB+/YZXXxlLFGE4SRdR/hSqTbHGC?=
 =?us-ascii?Q?ysl2d+FKtJKH9UU9WyRELoKeqa8jk9IppftO?=
X-Forefront-Antispam-Report:
	CIP:91.26.50.189;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:Diagnostix.phytec.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 09:00:31.5883
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87efe482-6a17-4bc3-bfa5-08ddd3fe8868
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29;Ip=[91.26.50.189];Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000003F.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP195MB2502

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


