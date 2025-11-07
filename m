Return-Path: <linux-kernel+bounces-889736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEB1C3E5D7
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 04:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BDA63ADCD3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 03:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611742E7F21;
	Fri,  7 Nov 2025 03:38:32 +0000 (UTC)
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023099.outbound.protection.outlook.com [40.107.44.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0678E2F25F0;
	Fri,  7 Nov 2025 03:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762486711; cv=fail; b=m7oBMlLLBC1tOLUx7/Whnzp21WpX6IjRyPH0Z2Oi64SsYnuFzhyYz+4FBTqpkSAmf3EaIbBAqdpthGKeglial6WUecNpmy8HG++XjvhozfmBtc3Ythcc/GpggJkrzr0x7mLCM+esx6qGr5G7491jqHHr3f18y3OitoERPIX34YQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762486711; c=relaxed/simple;
	bh=9YKDoeJGESUB1LAwyPctCcLJjasMeGyJu8omLQPvHgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S+nIcqpAU3g/WAEsxBjVe4L3rwNKOzU7rZBqdPSk9SQm7CybFqAoOSJcpxr//4kMLZ2Moe8+kW29DDNZz47spsgJrKtJhq5pUSTpXdCQWEZ42Ivg8ijKxxgQbymVcLTjzAHE95qNElZ78PZ9gejdvBtDMzOnhvM5zQmTVSs/nK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.44.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aYXpUea0WodVjph1hK/kS6G2BpdRt1LNFO6WWwwxpO4mtDc6mN7MR33tVYrWb9KgsexiZ0cLPjZ9UniKZUwhMzp6vC0iNHexzajOXHJHf2ac7dUC+36F90ej6YmRCEZSvv+/nKtxWcrvXo9LCL6Nru1oWVLNVc/HKdfthSYLGrzOXrzoqvuzkR7u9Hk8SfxTLH25sflC4+iXvPnMvdYbvCyZI4glS11MyzwkT+H5IXkydhpbLqJRIpkOnlcsUOCQA2/0afByUbwFX3VM6Vfl9Pc7YHFhjrdMVocBS+9GgkqNnuScBFAkDpDzMDD6yrlnhK9bmGCuh7zS8yctTh1xjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H6W1zY0s7iCzvFP6imKpgX+wFH1Q/bhxWnRHtIu9eKY=;
 b=toCOKwS2xy0w9cUR2Kq1KujufpikTgi2H9SlhlGJPifFUu/2JY4vjAMXNChaRyJZpfmOH/FG0jT/kGO2sE77p6A2mzc9S0Go8wQD9YzkgTX1FjaPNwer+OmbcdOnvsrRGyDzRdXhxzCSLSCOrVJnuUutC86a039Yr2XP7saiaF8mhlKaT4f/6F6UZ+ZCH9nOkvqk6vwc1JjEq8OSJHYdvZ0WvvIsEerFY0Px4nf9lXchcE39UwgVy+QnVZ3Qtrzg/TOlayLIJijiBXw9lJYBKx4d20bpI/Ep4nD53aKutC3KhSoxD6t3RZfPK9Dh2V1dlLx7h5bW+Ken67livhLj4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cixtech.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from TYCPR01CA0209.jpnprd01.prod.outlook.com (2603:1096:405:7a::14)
 by SEZPR06MB6157.apcprd06.prod.outlook.com (2603:1096:101:eb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Fri, 7 Nov
 2025 03:38:21 +0000
Received: from TY2PEPF0000AB83.apcprd03.prod.outlook.com
 (2603:1096:405:7a:cafe::e) by TYCPR01CA0209.outlook.office365.com
 (2603:1096:405:7a::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.12 via Frontend Transport; Fri,
 7 Nov 2025 03:38:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB83.mail.protection.outlook.com (10.167.253.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Fri, 7 Nov 2025 03:38:21 +0000
Received: from localhost.localdomain (unknown [172.16.64.196])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id EC09741604E7;
	Fri,  7 Nov 2025 11:38:19 +0800 (CST)
From: Gary Yang <gary.yang@cixtech.com>
To: p.zabel@pengutronix.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	cix-kernel-upstream@cixtech.com,
	Gary Yang <gary.yang@cixtech.com>
Subject: [PATCH 3/3] dts: reset: add support for cix sky1 resets
Date: Fri,  7 Nov 2025 11:38:19 +0800
Message-ID: <20251107033819.587712-4-gary.yang@cixtech.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251107033819.587712-1-gary.yang@cixtech.com>
References: <20251107033819.587712-1-gary.yang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB83:EE_|SEZPR06MB6157:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6b075572-e815-424d-01f8-08de1daf1958
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GD/QXZ3dIWIljtpsx1F0OdT6qeDJrewayuX6t4xucF2NVooz6ocZ6fBkLQGN?=
 =?us-ascii?Q?RYnvQEPsTtOGuk1Ory3G7Y8EdjVod5kH6rNYO4kddoX18da9P0GPMIIOIzoA?=
 =?us-ascii?Q?ki5J6496NWfNQyc/yw6UcCIgNDJ6IVJwxQiTzvZTU3UnY8R5Uwh8MQQtXrpz?=
 =?us-ascii?Q?bQI+eKf8URB6i+0gNACts7ncFC4BkbQ8YSDBfSkuWeBhaZokDwPtEzecb09D?=
 =?us-ascii?Q?A2R/MRYb9YjSOIAtKfu6E3bUyLXNfN32qNTiUcdheLZyXSju9jLoFF6pnAv9?=
 =?us-ascii?Q?Gy+QHz7vQXEUcYZheq3/eYuehAladngjzBOF7UbQu5RCI7JB3q/EF4LGQ/rr?=
 =?us-ascii?Q?oW8fQkxd2vU9eGxfU/CIlMml94NxO+FZgXQNj8xqg0PqLHbcu8eWG6JgMYwF?=
 =?us-ascii?Q?+B8Vvvi3pZLiCFDl75JZY3jYqqWAFwpdUer0t5rk5Ms0bK+eXZ6JITjIAPW4?=
 =?us-ascii?Q?BdRT8s05BZv00TBblAoy4jBgh3/odUmUoiIEePurF9GLX7wRjyF4JOmJpIgg?=
 =?us-ascii?Q?9CYZ1QkSf3ZVQqdguISMpfjxmWOEX1CJeU0301IKGvxf2gBF4aa/tP9UF6Ra?=
 =?us-ascii?Q?LdLZR1XyqZXRg3Q4Ocnk7m0aT7m4oy8qA10TBNya+ufYJFjERsUE/cFol3aa?=
 =?us-ascii?Q?P+PWrUykrEOGIP66YZbtbPtEzk8KVf7mFXgjDIcN0P8ECJJtXG/hVMWo9nGd?=
 =?us-ascii?Q?0WRYo6qDjITwooFS1pQIMNjO+V9o7MkH2fnErHLKItAGaUHFSdZcqQADH5mZ?=
 =?us-ascii?Q?1N4D/3myId5dYGO0bnFQvZM/3F1Wnjm9LT3iane6zy7BYLMaF/runIPlFM0v?=
 =?us-ascii?Q?FSZSDfl43rOQIsbtEpfsmmM8O0497EQkV0wqQX1C+gDtmqIoLUUH4nVRpIyg?=
 =?us-ascii?Q?wKvjw5yFsQBidol//8rpDjOHJHNwrXKI9k5GxygbB/cmavqnwmfeTqkSzUN1?=
 =?us-ascii?Q?j9vKfiFpl18FckMNmCNOrNbf0564r4oMMhT5m4Ss7puAj2S25houZu4+tDpP?=
 =?us-ascii?Q?c6OC7TehFjgD4ZnYSrnqHcjbGOnyQ+AiFG3lmxgCYoo5CqEkyDspgj3WoGBx?=
 =?us-ascii?Q?jlgVcy40iSE1OEr7jcfNzcBge50KuPkqVv6XnFfR6FzpHxe+L3at8Muv25yf?=
 =?us-ascii?Q?iehZzrNqo1gKszC4ncC7Nr5kSzStkgTSQiwZe3703bFiwJ/ljBfSanFAM10i?=
 =?us-ascii?Q?a7GAgNALLovVB74wJrzDMnUwMBwuqufMr7KktIIr6JApfYjk8xB9bL1SLfNV?=
 =?us-ascii?Q?9eLDz3bL9uwQcj66PfU/UezHC6mKpejgIta6UNzCJDtJoOVzDRgJQ7PjUC4z?=
 =?us-ascii?Q?r1J/bBXNro/A0cOpgpogMeHtHpla+4lMgZzAGZXPE6oD5gXC+wtusxexf3TG?=
 =?us-ascii?Q?IZ3LuiiOIuPuhDDsM1bHDo1gBlFm9pIv1o2rVtTNmAbpJE7p/4H3W1ZASFj7?=
 =?us-ascii?Q?pOcAh0J/SOdTgPTk9osQalGR8+JVhxQdUBV9WLol8hjqcn5JFb8eaehhtP6N?=
 =?us-ascii?Q?tnCBBCfpxWw2lw6gc87YHHmhMDkcCJ1ohfr89ykqVokXX6HDOGMk6ZDsgdgn?=
 =?us-ascii?Q?4W0GMfD2bf1iVeGcrzM=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 03:38:21.2328
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b075572-e815-424d-01f8-08de1daf1958
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	TY2PEPF0000AB83.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6157

There are two reset conctrollers on Cix Sky1 Soc.
One is located in S0 domain, and the other is located
in S5 domain.

Signed-off-by: Gary Yang <gary.yang@cixtech.com>
---
 arch/arm64/boot/dts/cix/sky1.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/cix/sky1.dtsi b/arch/arm64/boot/dts/cix/sky1.dtsi
index d21387224e79..fc68734f37c2 100644
--- a/arch/arm64/boot/dts/cix/sky1.dtsi
+++ b/arch/arm64/boot/dts/cix/sky1.dtsi
@@ -348,6 +348,13 @@ i3c1: i3c@4100000 {
 			status = "disabled";
 		};
 
+		src_fch: reset-controller@4160000 {
+			compatible = "cix,sky1-rst-fch", "syscon";
+			reg = <0x0 0x04160000 0x0 0x90>;
+			#reset-cells = <1>;
+			status = "okay";
+		};
+
 		iomuxc: pinctrl@4170000 {
 			compatible = "cix,sky1-iomuxc";
 			reg = <0x0 0x04170000 0x0 0x1000>;
@@ -568,6 +575,13 @@ ppi_partition1: interrupt-partition-1 {
 			};
 		};
 
+		src: reset-controller@16000000 {
+			compatible = "cix,sky1-rst", "syscon";
+			reg = <0x0 0x16000000 0x0 0x1000>;
+			#reset-cells = <1>;
+			status = "okay";
+		};
+
 		iomuxc_s5: pinctrl@16007000 {
 			compatible = "cix,sky1-iomuxc-s5";
 			reg = <0x0 0x16007000 0x0 0x1000>;
-- 
2.49.0


