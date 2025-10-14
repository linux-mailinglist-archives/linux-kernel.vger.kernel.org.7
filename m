Return-Path: <linux-kernel+bounces-851715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 010AEBD71F5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 04:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A20D9420FE2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 02:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C0F278761;
	Tue, 14 Oct 2025 02:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="os69mXOf"
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012000.outbound.protection.outlook.com [52.101.53.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF5D1A3165;
	Tue, 14 Oct 2025 02:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760410100; cv=fail; b=kBhIIu0UUTIJgZPmEJurO0d7gUYvEoWd2g3Pk6rjV9IXmo03xxxcAssPvHxMrW+pbXd/5u27XAd5TW+KLPJlNI9PB/NuhvS+vywh/PHS/4qK9atbjQKo82tP4jDTmL+A3nAEuR1dlO7CWseII5vo1Sw/8FjbDO4MYu4ZSbJ2roA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760410100; c=relaxed/simple;
	bh=5+svwH3DC9FBcxlgnIUqvHmSzDe2+7nIC9iWUpMN2q0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=tuITVQxYgBA45BBs4bCf3XT1NWd6ngH7pvRMpF8vELIL+ZnuAfA14r3dvEbhfYe1MD0p7Zf6h1miGrHTet+d/9Fs8HYAZU2zNc04SQvmdZb+T+Rav2zYtqi3KI2Ykb1hIlos7J/tcvOsF8hz3OPh928FwMKR9/MTjudH9qZF09c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=os69mXOf; arc=fail smtp.client-ip=52.101.53.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PwgN27cWP6+jVhu/xYa3qJ1WVaL0otBE8qI3EdRB29d3Oc45UBjnGx8k4/D5noJQPa7aSQ7CjGnZuWLtw5XTMUgXkfldbcyayyvY3oWwt/lonOPj0cYY7Be02lP9uw+TpKr40owhDZoJC7sGbVV32Ah3mPzRZBvT53tRv9H7s7n/oOJyQx8X1U+8Q4fAd5lGL8xq05FoLmVx4A85hmWAtvZUERDVsYW5mljI6qgpPVHQrc0dN16c9EhIuhGS6fgqh0udKPUyb2SS2IcN7RtNBTkSbFXymAgkH53u2zS32QWlYxkxdPKTGj5rWxBMMJgJczNvbs3c/pRSOe4mQlLDfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lcc0G8ZkK9nO2tBv9V3NZLgEko7pTlyhJ2+4m3HwzFw=;
 b=Sqc1kL3Hg8r7IgyARI4YFpzqtK8Dpq7J/6eAVvgJ1eRlfpyzUgaLKc2WGthqL031scbEtJnkxgb/BrBAckinHFcGOYQyuirtvxKiUoI0tcOfpYY22+f9UnXvtyFYv1drdTStRFwu3jbgIJi44XqSvxRFj6EQLd5Kjy0Cr7pmogztfmujp+eg3sPcDOQGdHwQlIacJF/wqFnmc9UQhOJ/AuUXlwWTfq6TCC30KD6Axg5CuPslvGDbZgWNzMmzmQUMe1Md2p6Xpz3yBxIUyWPLFoWYfTEjQN0vGM9uYcLtfHHk5Ccei3IzIGTlY4qzbZVEmVRZFRah5bNzok3lzZ08AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lcc0G8ZkK9nO2tBv9V3NZLgEko7pTlyhJ2+4m3HwzFw=;
 b=os69mXOfFZVsD0SbEoOoZm48ZO5viRbJeVN/n2/MxSFqIpce80YXC0pPWm2IkWs6mVmacyZL/N3wfrWWWZVqdUSrbgnL97LT7dZN8nJmuhSLyOrZSi8zb4XJUJ9LuNxDGCfe5IhY1ROmy28/O4L19kiazCG9SQ5Fldkw7Hifo6ArbTjgStxgRhdUBxtIwW5zdkCddVxdliXHUZ7PaaSGHZkwm3gLBksc0yUK07BOFBRa46VmODdWOb0cuNqtnmc9MKrCCfEjzTRlplgJl9D7gD/jfHOcDb5p+rzlmguWs1fGdNveFws1ENhI/VgwIkEOt0y6+aRHlQrcLKXtIVpveA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA3PR03MB7187.namprd03.prod.outlook.com (2603:10b6:806:2f6::11)
 by SJ0PR03MB6645.namprd03.prod.outlook.com (2603:10b6:a03:387::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Tue, 14 Oct
 2025 02:48:14 +0000
Received: from SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::3145:43b1:92d7:f7a4]) by SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::3145:43b1:92d7:f7a4%7]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 02:48:14 +0000
From: Boon Khai Ng <boon.khai.ng@altera.com>
To: Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-drivers-review <linux-drivers-review@altera.com>
Cc: Boon Khai Ng <boon.khai.ng@altera.com>
Subject: [PATCH v1] arm64: dts: agilex5: Add GMAC0 node for NAND daughter card
Date: Tue, 14 Oct 2025 10:48:05 +0800
Message-Id: <20251014024805.25579-1-boon.khai.ng@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0057.namprd07.prod.outlook.com
 (2603:10b6:a03:60::34) To SA3PR03MB7187.namprd03.prod.outlook.com
 (2603:10b6:806:2f6::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR03MB7187:EE_|SJ0PR03MB6645:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f87b92e-18bd-4470-3d59-08de0acc1f09
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cgIDSRNOegKpLkcVA4D5e0v2zpBEWxcZ2uACuAqq2nWnZzL59U502Ag9eg0f?=
 =?us-ascii?Q?fFJ0YLjYQfF6IQNks+ajywSFGJ5MyAFCUDcek7Q2lDtUon3H4MWEn71N8XsO?=
 =?us-ascii?Q?DyVGodebDIxhfhEzXNfiD5DSpOQEnZ+qJtp50rbsCHGhvuOGgcjG856sp9H9?=
 =?us-ascii?Q?l7lVb0AC6f/9ZXmHlsrCFUnAeHw9gqmec9HSCMFs5uHxs+bJb6rRrg5McIIf?=
 =?us-ascii?Q?vjz6DY6mjYmFilrrvtV1NrhyNEputpA+F9unCVQ28NiugzPJzCeSNfJ8jSbR?=
 =?us-ascii?Q?7k/dC/pOcPEbgXVPwbsBj0bTtdqo7jTIWda6kE6YYMwoWFf7/RPtnfAK7TLg?=
 =?us-ascii?Q?FcGqeyQQrz9kSi01SpuROMx0eaPQa8E6AvqymI6yFrR9/K+ov6MQuZv0EiNV?=
 =?us-ascii?Q?6XyjkuyguuhNwCE389UpF5jmuStmHqXFtypEDs3+I17uMEc6lT3CGAdvMXL4?=
 =?us-ascii?Q?Be14ojB1727lPXCr/bJMYr9re89jOnK2J/EzRdWvJHBByc9k1Bgl+mKxccho?=
 =?us-ascii?Q?1FoQcUiAr7+I++DWjpic4svGfTjvruFMzk2gBBUSEb4yKxetP9zpN1Djs9QW?=
 =?us-ascii?Q?rD2L8sU/O7VX66tJ93d03aQRZrdTbXu8DOHSRxB5i4vq2jCqerSfrpc1t632?=
 =?us-ascii?Q?cfs92peqOhO+pFRTZMY3JkJkg+awXACHIS1WnFhXf/yZnzxWNcnj0i5ruun7?=
 =?us-ascii?Q?nWsHQ+M9r6qgVN5zJHIAaupHd5L+2HXmSw83cLrelL6VfLa17JB4XMD7nRTD?=
 =?us-ascii?Q?duhXVUvMQPYkMKOMv3IfItJKn1RmLKytRuBU4y85TAyy/1bljCdLSjqLzCEH?=
 =?us-ascii?Q?poxgK8EFaI292rZovhEjKeY5at95LbR6R+hqhZmkB5OjIxssrSJ/pbX3XGHs?=
 =?us-ascii?Q?0dct4EBvpffrauKkNx+Z1p2QBzomSERiIDizydXxJFjwz0vbZzcD8kvMEskm?=
 =?us-ascii?Q?qjkahI/GNhtxLciCbB1zbUjFWwV1GyJF35wACoQYzuuh8++Rho06Wk5l0Jin?=
 =?us-ascii?Q?ECorvO/1FZcJWaARfWk2bBYvsoyZICE5FyPJO4xArmBqTDHW2zd8OXHGm+Pj?=
 =?us-ascii?Q?oSFTKmZMv1jp4zhdDhvFUg+Fa4gGxzh+tfvBFlMUYIMSg+FiKsaQbRqBeEK3?=
 =?us-ascii?Q?OFNbE8toEIP9sgxXZsWu8OAq8oDN9hm4sUWBGRlKpqqUrTzuW9U0VeyGPHt+?=
 =?us-ascii?Q?B8Rcvu5RrkjXvrVYlYcQqYC7ZSiG8ukW6/c7zmc/aSCsoS2RqonkOdmRuIuP?=
 =?us-ascii?Q?BocJMq+7bLraJUoYBomJ/8WqxS5fWWGJaf6ClIFkTtEwCzk0OBOxUt6cjr8Y?=
 =?us-ascii?Q?Z/OfEx/jPpDSccXrdmz88e2yoFhGrKnOJ0e5kQhgz1RcdGR25oP3uxvzOsAy?=
 =?us-ascii?Q?tJwpuRd9Ej+JTq+G0RwZlo/thjcdxRNXsGdUvVMJHW0q2gFbP9nE4kx//mB2?=
 =?us-ascii?Q?vJUAJ/lk9sjq7RPdIoOPqRMCosYo+aSo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR03MB7187.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cRsspBcI1Meieg1IHZCliEAbikLWsnVw6OK+MUcXzZ3KUxwaFbY4SqeN5KLQ?=
 =?us-ascii?Q?uW4lAOB1ulLjawVURXjz9aqtqiPzRPQ48yh04VmwpKKAkcJzR2/bLEG8MOX7?=
 =?us-ascii?Q?TuljmtcAivkPVYj5BN1jmp2SPDOb2bC9TmMtxSgxJtYcKn05mX2cO+6wO17w?=
 =?us-ascii?Q?kWyC0EXju/62PrYH8zlhpF8qWgXt3nnJf+LlQzPcqyatp7qaBiP9TrQV3eFL?=
 =?us-ascii?Q?UE0OaGzD7uIJ+ulg13VsqU7V/PvywoYrnidX4UL2Uuw5Sqwwa/P7IwoOFdAq?=
 =?us-ascii?Q?P/A7nSLYDtWjUhqqvHADpRpQQbkLige3FOYb0ohSyQ6afRz2O8BVlatzBvuO?=
 =?us-ascii?Q?2AvVTO+eoCEfj8nM8L1hHYo6KaUfZAUFqj9DIpbtUnuDHy0RzNkgYSDTyyKx?=
 =?us-ascii?Q?FYNw+s7PHMQK1GysI2XvqH604hdvbnWxfx0IMWeCcWlMQQKU/8i7pAA6bXmx?=
 =?us-ascii?Q?nOo0ovvFlCr9pl44bxTRXtKpOJnOkJOdULm3xlR2zz14JQDnFVJU1QfEYigi?=
 =?us-ascii?Q?aq288PRPDqUF2I+Pk/lkJ4i4d+aTT0CEvGiIpjB2vbS6WA+JZ+gV3MviDT5g?=
 =?us-ascii?Q?Q/Yg5r9KkJG68IlHMiDUbnQc4bZ6O2cONcLN4ScV+4IDFFghwXRtkYjQPANA?=
 =?us-ascii?Q?IPgvMgw6u/UaLiHgCI0FGi+eCiz8VG83SChIs1VRojPx7Qa6tRNtZ/bNukNK?=
 =?us-ascii?Q?L4TIeIF5FQkMFGquZOWYNqr6yMvM+tuG157s9svkBXl65D908P+XN02wa33T?=
 =?us-ascii?Q?h44UYhvbz6DVxiAMlk0JdudM5eVDRB9eUcacvrmVLjs4skws4jvLhBt54CyW?=
 =?us-ascii?Q?2L24XB+Y8Tv2zkFzXZNU8SB7nczJ1L3ABACdnoYB90PRq/KKDgyzcTNs3k9I?=
 =?us-ascii?Q?KFkiegxDINKrthhYKBF1Ua1PsxCCu8cTvndwm4pFaikWiQ5BRSbtk1rnil4L?=
 =?us-ascii?Q?rL6j3WhhxAtX58yKVzsu9uSfh2sX5I6ub4YJVuYoIW/YWyhrv8DppPfR/X1Z?=
 =?us-ascii?Q?TX4NnPGWySFFsHtyskurCaP849zaT16eRukh6HPQC3eUzFEmy3ZkL/VZe6IB?=
 =?us-ascii?Q?4ESOV083E/sNBlVNwxT+kEQl5EW6y88pM3Il7IZSGFfQcKXQYeRij8e3CtvN?=
 =?us-ascii?Q?xJE3CO/38PbzzLBpd5dD3mXF+kNXPX+O+MJ04jsVxeZ7FJoLfs4D9CgWjQcg?=
 =?us-ascii?Q?3Wa6xPyvhy6dJxHVJfLuQQ6La5oblpH89MIJgiDZMrObG7vjHmlb/cXsi1sw?=
 =?us-ascii?Q?mdZyoNFjPtMIPf7X8urmjgSrzUzfPb5/IPUa1Vi+TAc/D+5LRYtFG5JdCpuJ?=
 =?us-ascii?Q?Zj7OLPvC0z/XCmC0MV4DooQOgOUGmpF+i5XBMZKJPZ9u4k4WCkWRqJIs9CTX?=
 =?us-ascii?Q?5+gqwbwvgujsW248pPwe0/U1L/NdPST3+x8whDEZDXMi2PRAfrTAudFl8owh?=
 =?us-ascii?Q?HSLb69emkCA0SCASfl8Q05t1z1FObfK93P3jIw6/CsIAH4NKJ3T50/0KdvZo?=
 =?us-ascii?Q?o0sljbmfsRTnhkdFA9dsvr5V6MfRMKSkTZSDZ10BuTGs9ZkVhIUgJgvhiKFj?=
 =?us-ascii?Q?1ueMMDogZN+6/zgtZINHHFqu8Vl9Uh9ZpXhCS5F+?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f87b92e-18bd-4470-3d59-08de0acc1f09
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB7187.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 02:48:14.6336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FODkMYL0CxmksDTQ1ayT5PSSsVWkMngKaUWgU08Y9hY2GabdzmYloL2QLljnODtRH7wB12Lgyl2ecmi2KQhV2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6645

Enable the GMAC0 node for the Agilex5 device when using the NAND
daughter card.

Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
---
 .../dts/intel/socfpga_agilex5_socdk_nand.dts   | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk_nand.dts b/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk_nand.dts
index 38a582ef86b4..ec4541d44c9b 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk_nand.dts
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk_nand.dts
@@ -10,6 +10,7 @@ / {
 
 	aliases {
 		serial0 = &uart0;
+		ethernet0 = &gmac0;
 	};
 
 	chosen {
@@ -36,6 +37,23 @@ memory@80000000 {
 	};
 };
 
+&gmac0 {
+	status = "okay";
+	phy-mode = "rgmii-id";
+	phy-handle = <&emac0_phy0>;
+	max-frame-size = <9000>;
+
+	mdio0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,dwmac-mdio";
+
+		emac0_phy0: ethernet-phy@0 {
+			reg = <0>;
+		};
+	};
+};
+
 &gpio0 {
 	status = "okay";
 };
-- 
2.35.3


