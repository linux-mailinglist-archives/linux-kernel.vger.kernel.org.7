Return-Path: <linux-kernel+bounces-853621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1183BDC20C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 04:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4AAD3A3AF2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 02:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4836B3090E2;
	Wed, 15 Oct 2025 02:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="g+ray6yr"
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012071.outbound.protection.outlook.com [52.101.53.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B725E1917FB;
	Wed, 15 Oct 2025 02:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760494487; cv=fail; b=dGCAo2F8ff0gG4Czi8JtotH9rajtjF6CcF4em/RRpJHMgpTwMad5TSYi6z4Bo07ErlKMieKSDhJgFfEMpAkYwBkfOTtSr6pQjXyiCz1o2PVqzQqraushaJvVucLa0pCe2SXj3DjtXJXSZ+KWj3vg9pzV0AdbTmX+Om/KLDA65EE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760494487; c=relaxed/simple;
	bh=9iHjo4WwfdYSAVMSLHm37w+DnEUEBQNkPXggXlNRLAs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=KF1FkRv1ZOYI9fA/627t3Yb3RXUSpSbnjzOeLxbMWjVYCBztXxRqsbbYTL35/sjEZ0L73vuO9kwk/gsVZpGsKccY6aw+/K7YrFvuWSCI3LyhA9Jzl5NACs1hTsUyMwZkhr/h9oS0HzRdI8fVzkCM58MORckIOdvTCP3ZkRyOIfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=g+ray6yr; arc=fail smtp.client-ip=52.101.53.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U62Khr9fjaZDCR8DW1TebXTTVgE/vjijKZ/Wg40PhxrXsApez5tWEpBsoCyFRYdfvhvNYSdigSW1Tg4RDrMpDU3PD0ga3GsXJ2Vwv4VbwnPCbz+0tq3aaNxXXPhh7QP/e9dUjDSRDEqeuJCNFd9ARFxqHJnpwBQEV+VQTNyYdCL/Mq0ujqShi+jVB4miN2142JXByrXSPdCTCQIXdo7sCiiQEer7or0Nyvb6rV4vExAIMrWXYDkKRmWbNdmECnaqDgifHK5ENw9djYDszoHpKTSB0ffImn/ZOPFWEAwHBMzXVU+kNTardtXAh83Tw0lHdOc7MZ/ky2BCqfRTgrIC2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EtiDW3Q15+GecmGn1WDhvgSE/+hgxLFW7+pNCecfS+c=;
 b=k6aYlU0ujE5SG8C8in+0CXoBgXkDLBg/eCD1nFS2JcKLkftrMh/Mvp1L7+xv9M734v4niK9Ns3hCvZD6vVy3tQKX3lGHkr+/yFGjcuyLBDw62VXNb2snhOPIM8PPLzu6RAMGhAffvIVimsdQzW1o1mc3QeqFWFlFzn7G5H2IwKXJlAatPRIsZmp5K9RWxn3+jmF3GtfQQdJuuqFWA+Q2xwug4f07aSH5i8zhq6TAl1eXeRz+kzeAFf/ztfq8bRH8t+QSM2NqPzfDXXDiROu1Be55UDSlTS5IL5sTkdohmZHGjxBp9o4iWkB9XcIH//hQvnnIpPyo9jilnpZx7ppclg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EtiDW3Q15+GecmGn1WDhvgSE/+hgxLFW7+pNCecfS+c=;
 b=g+ray6yr4F8AgtIo5DuAwem/cIxLVACpp2KrSsmamYrMqGza3XtNmlG2E7K4crZATzgNf426jauYVNZvoEMhapVDnnjshaoZc8Cpy5OW0n8u9M/XazWQgMg2M21247NQFNaMJ1kRkUZA7QzHXICEDVXFbck8WL2f2EDOnjh/armnoZ4XXpMoVSpzMtnUp3Rd52n6nIGkh2k7ntj4ziCmqP7zY7GemjWsQmzbBjcoYMW2b64pfSX9DuMCwCstWVDrt9Stadui+ekb8jn2RdaSXCRSYfKMGaOyZQX2SnxZAlo0mvVCXlhq7t1uNiqN+JmBg5C+qIJlamxlw1L/fVrh/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM8PR03MB6230.namprd03.prod.outlook.com (2603:10b6:8:3c::13) by
 BY1PR03MB7876.namprd03.prod.outlook.com (2603:10b6:a03:5b7::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.13; Wed, 15 Oct 2025 02:14:42 +0000
Received: from DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::abad:9d80:7a13:9542]) by DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::abad:9d80:7a13:9542%3]) with mapi id 15.20.9203.009; Wed, 15 Oct 2025
 02:14:41 +0000
From: adrianhoyin.ng@altera.com
To: robh@kernel.org,
	dinguyen@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: adrianhoyin.ng@altera.com
Subject: [PATCH 1/2] arm64: dts: socfpga: agilex5: Add L2 and L3 cache
Date: Wed, 15 Oct 2025 10:12:42 +0800
Message-ID: <fd13839ae0d1d67f77b4cce8641bc241005797c2.1760426064.git.adrianhoyin.ng@altera.com>
X-Mailer: git-send-email 2.49.GIT
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KU1PR03CA0043.apcprd03.prod.outlook.com
 (2603:1096:802:19::31) To DM8PR03MB6230.namprd03.prod.outlook.com
 (2603:10b6:8:3c::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR03MB6230:EE_|BY1PR03MB7876:EE_
X-MS-Office365-Filtering-Correlation-Id: 88556279-a56a-48ef-d4a6-08de0b9099c4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y3KZojQ9TbSMywFZMHMCkzKf3fveqnmVW7woiMDEE4vuihbi82opzrVqBy4P?=
 =?us-ascii?Q?oy2LQEKCnPO658EFUTbrxNLQmorKiNbUb4/5Bv+3VLW1DXcS+LxGZMkCRkhv?=
 =?us-ascii?Q?KxI1Nhm8ht+TXXYzPvSz0x81VFenfl7boshB4nT36UQlZE72Fr4eN0Lw7mP4?=
 =?us-ascii?Q?Eid1HVlo7fMOdP6PNQeC/UBVIgBt7nvJEJx+NS3k+eo+x9ZPL0WCehlKXfRd?=
 =?us-ascii?Q?J5fLBFcbB5gBUhieKbsEczgPCt8buSlOZ2s9A8waeSjHhXIRXSSm99aqB6Kk?=
 =?us-ascii?Q?rbtJUna0bhfI+Hy6Re0/QAVhNh+SyL2MFSLQ32bbUOlgcS9e+9t0Ssp/As1Z?=
 =?us-ascii?Q?WcmZOTAczI3/LWoHEkcPuO61fXFCFumuRaKmCFWrpw/SH+YiRyLjib9ePWNm?=
 =?us-ascii?Q?XaLQwT0ZlF09+QmYoQihvFZXHYgQG2uBRjfjvvK7DPixJwJrcPVql0e5C3dH?=
 =?us-ascii?Q?+ETQjU8DO7RJB+YZs+nWocETMTGVGhNjQugNMa0HJz4E0d5E+GV/E4WigJo4?=
 =?us-ascii?Q?sR4b3Q7FGZJYrbd/SeXl9KAHmnk6EWzEF+Q0E6QcrcNpWtG+cqPmVnZPiYVj?=
 =?us-ascii?Q?DHNWQkVM4kaHlsPOJC3aG6HQuuijZmjSiIEbk0r8LYUiu0V9mOqfXbAwzyLq?=
 =?us-ascii?Q?YPPJpuQDRmKgDxN4eP4YkivQfOlJB5H8Gq3/yCN6r81MX8au3jmrD3f7pdMu?=
 =?us-ascii?Q?59GcjRmNwv7ysP4nPkbwEskeGi3W3khx8xwl12h8khta8KRQrdAYjQxfUVol?=
 =?us-ascii?Q?08WqbHm1xz3hQzjSlJV+JVpUNl3YqXOV+YtnyEYLXzS5wdEn6BdUEXTmcxCu?=
 =?us-ascii?Q?3/qXL5txN/2EEMnzkOcuVpoGx8HCHK6aoPvEhwiV7uU6R6rNsCAIepb2NR5I?=
 =?us-ascii?Q?T3lJnK44lj5w/I4OpyBFr+qqcpcaBd+y0ng2Pr+5RSrUxPzVfkDMKuRH/nUJ?=
 =?us-ascii?Q?EY07lpvfaYKnP0clLN5pXgdKPkyhiMwMvSEZ7NvXBW6pJJw7CSDh85YDK1Ia?=
 =?us-ascii?Q?4L3lqEp0DHOrJ6obhiYkQGJvzr4e5v0cPLOzlbCNz7jlC2d7lodn3P0tNbi9?=
 =?us-ascii?Q?CpKSwJp3kknrHGK6ER95riz61r2ma3l2JK4d6db2mr9XnlfBi7kXdU0zv6/t?=
 =?us-ascii?Q?Lo7kozOO1mnmEMuspnQhHU+s2ZynmlTA+anAcAPKsadmtljG4dVFEoCNhBqU?=
 =?us-ascii?Q?sGYbkW/9bx85ybrG7GDVJttOWWLS95jXs7UHheLl/mLFNCJeTNEpulJRVOAW?=
 =?us-ascii?Q?0eZCMj5ZHeUjur1C7HohCrZn5S5jDo+mVzBmRQvAXeReEaRwTM9v9HjquEcT?=
 =?us-ascii?Q?lFp39HpJ6oto/D2Ic/O96j2c7CxT3xO+W5uh/E5Oy6RTtW7Ys16IXv7os+up?=
 =?us-ascii?Q?9VGc+vHDVaGq99An3U5olN2VZjSjpdDyI8oOn/l/+AwsiaLAqaJJ9dRGQkUv?=
 =?us-ascii?Q?eXA0PrF462vCiKw7lwtgyxaLmt6WJF0W?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR03MB6230.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OyqPsfbpOpsDWNEduHRxps+Vxmz8I1g6XxyBNYDmlBQuLLBm5yHdNK9fHXJr?=
 =?us-ascii?Q?XzZNdoQ+TGu3bEw7zw7k/Or75c+2L1fxbeqY8zkgNIx412SfXNRwci7mdcx+?=
 =?us-ascii?Q?Goke4KYjJwVe3DTgtgSpvvMLP5+RJndIjAH+y/BcopqC305YhjgtqRppvQYQ?=
 =?us-ascii?Q?vPFWmKh6C4i29MSwVSZ3uzhh054q5I5nLajNjVChgKAQAmKNidBiLxRskz1X?=
 =?us-ascii?Q?Jxx3UeF5BbkxAQP/9QAbivHK6DLmGcW0WG/dJx2ZXn7dstvvfhwIQsfUFEPr?=
 =?us-ascii?Q?ljpmZzQSsUwQP6o4N0v+ygeRXiKTubOGh2xFbJeXEci+35lyHe6XXDFsNpTR?=
 =?us-ascii?Q?JV7MY98c4UCFDXjKBwsRJhF34pHFo/l+nVvxI+aQJ+BX/+zx8JJ/6t6wStEW?=
 =?us-ascii?Q?Y8k79dywAjIzMPpGBRLBZoBij3XbXSwA6RPdA4TDS0S1SRd5G131nR6RSYp6?=
 =?us-ascii?Q?XbswFR0cuB02NNtpGfhCSGXt+aRXw+sTy2rfDp3V1CDuwu4R0VbwXSwF+7K0?=
 =?us-ascii?Q?4HvdGnbecYfUc03+DlmHHIkMTgMiOInDGeCuCLbiURK+9e3upo4Lmz4zb8a+?=
 =?us-ascii?Q?qZb2l5IuRVQ3sUIy1b08c/NZ1vLzfuDqXH59y0zkLAC/LcYbcbc1LMubJ69n?=
 =?us-ascii?Q?7BvpQzqP9MFZi3FOBYV6L1aEmW9PhqVToFPOy3twoIP44/qRt9pbG00YAFpG?=
 =?us-ascii?Q?k2OmOWGsxhZiIu0jjCHA1FtFSkkwltwjLUMqw2wqDXkY24t9FmFfgEkNVQJj?=
 =?us-ascii?Q?m7iXHsK3MiaCoG13l2+vZTOHGKfPKk9neRxj1xs2ag/bHNYPzeliPrSpV33I?=
 =?us-ascii?Q?Uq4H4fStFC312Cr5kZgmouaECujyOSGhlAklkPkMK8Op6uhyuTs2T3yYTCzz?=
 =?us-ascii?Q?LrZCEWe70W0gSdzKGyOLJYGBLDVwqYDutycgxt6UV2surF71niwFRQe2muMn?=
 =?us-ascii?Q?1E/IDCfopQx65FdVZtvsyk7IcimHjhjyxrramsr9EpvDfLK4xY3LLJA8FVK2?=
 =?us-ascii?Q?Prx5YRy9wOvIRwj57p4AFio24f9gPjnqkD2jtK0ycOzoslGtESQeU/bkPQX5?=
 =?us-ascii?Q?+6Rh++uMcogZd/r7Zk6OFZw4O/2CGgtS6CeSdc9fNj4+oeahGPCUvRTQMTzs?=
 =?us-ascii?Q?Nw+mhBkzmK1EHrSI41XpwXLGTm9SJDn0C5nYmGoTA6l+mvdyE+rjCjCpED6N?=
 =?us-ascii?Q?3KkvY3fEjnjywHYICNN2Oj7aDJibJdDt8bM4WdexNnBYyeyvvHHge4sEkJJQ?=
 =?us-ascii?Q?AJrByDhOSdYcvbCDiZRFmoJuJg8evik0++Cv4WDLfgTJ1xxv7lonp8/7LkiU?=
 =?us-ascii?Q?bKCm7b914jnPQGOqoFzej9mOdo/JHigKS5juA0z92nH5gQLe6iiESK5zgsac?=
 =?us-ascii?Q?ucuubPt86Yy+Unjqb7iyK1zC1jUPyRZDPmN71nFLx29/86Zd36iIzoFW84u6?=
 =?us-ascii?Q?Fws9uHiO+nucTLpofIa+XAQ1RlRTZYigq9Az7zoWdafBr2ZRmY9aokqRTx3d?=
 =?us-ascii?Q?aehzhAyUDoWnjBxj5preHTMftlamFkwoN2c1m+JR2+HH2P/oyoq9asG+Jx4q?=
 =?us-ascii?Q?cmOpBQUe9qNqfAeNw+nAOQ/gCulxN5NWhno0SU0vIhzDchfHV6/9ztR5QCNT?=
 =?us-ascii?Q?kQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88556279-a56a-48ef-d4a6-08de0b9099c4
X-MS-Exchange-CrossTenant-AuthSource: DM8PR03MB6230.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 02:14:41.7889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ar7u/SoWaz9O261r/3TusViS8EYw64WPskx4kQ4F6qD9J/2Dzm6+kryuaCkZt6Yp/zSHyRjSnwp4Jrp0YKO4uFzSu4/zVSHseNffdddDN+M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR03MB7876

From: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>

Add L2 and L3 cache nodes to the device tree to resolve the
"unable to detect cache hierarchy" warning reported by cacheinfo.

Signed-off-by: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
---
 arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
index 04e99cd7e74b..19f55a02bd56 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
@@ -37,6 +37,7 @@ cpu0: cpu@0 {
 			reg = <0x0>;
 			device_type = "cpu";
 			enable-method = "psci";
+			next-level-cache = <&L2>;
 		};
 
 		cpu1: cpu@1 {
@@ -44,6 +45,7 @@ cpu1: cpu@1 {
 			reg = <0x100>;
 			device_type = "cpu";
 			enable-method = "psci";
+			next-level-cache = <&L2>;
 		};
 
 		cpu2: cpu@2 {
@@ -51,6 +53,7 @@ cpu2: cpu@2 {
 			reg = <0x200>;
 			device_type = "cpu";
 			enable-method = "psci";
+			next-level-cache = <&L2>;
 		};
 
 		cpu3: cpu@3 {
@@ -58,7 +61,22 @@ cpu3: cpu@3 {
 			reg = <0x300>;
 			device_type = "cpu";
 			enable-method = "psci";
+			next-level-cache = <&L2>;
 		};
+
+		L2: l2-cache {
+			compatible = "cache";
+			cache-level = <2>;
+			next-level-cache = <&L3>;
+			cache-unified;
+		};
+
+		L3: l3-cache {
+			compatible = "cache";
+			cache-level = <3>;
+			cache-unified;
+		};
+
 	};
 
 	psci {
-- 
2.49.GIT


