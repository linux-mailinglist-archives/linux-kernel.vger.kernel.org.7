Return-Path: <linux-kernel+bounces-734793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30908B0866F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 09:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01D7517EF14
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 07:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F374921D3F0;
	Thu, 17 Jul 2025 07:22:18 +0000 (UTC)
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022100.outbound.protection.outlook.com [40.107.75.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D402163B2;
	Thu, 17 Jul 2025 07:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752736938; cv=fail; b=SYxnd07ouhmawAMTeaFY03XuyL3jqMHVHUBLzg9F3+6By4E2LLkOuxZ40aAru3KxwAl5J1ZFejoKCIMxJSCicQuKSIEEYWfadck6CtGcu58/6xcZpoPKU2htkFH1ppKGAb9kmXzqX9hUcN9bycY1DW5ZXaOfXjPTnolpSZib4Qk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752736938; c=relaxed/simple;
	bh=UgkB2Sxv2dsLYpGtAl+6smuWsAG8v2mbeDQqd+FEv5g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XXS7Xb8ehxNNDailDRNWPdj2TT/Cah93oyiNmpSP6x1ahGtLO7g8sEcpwb3XzmoNt0G6sVukJk6gWqYSqg7Pze3KC/cyU++NvpiCn4WaRt/q7TqgUrY4Dy5Lf4smUmLoK3z0ypK1sug0+PLgGS407EU9wHkbA9qNgtYVgAF0KWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.75.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bP9DI7udDsB3ebtLbB/M9/l+my9+GrhCclO0tPUxvfmAKO7pQCqSi7l0/JgMzUlf1qyQi9G/DFGRq40gN6uDjR28p8PXf3ryu97MnQue+R0lWzSwhI+UhcV2D78mK/sB/xdfxCKF8/EyTmEIf5+qdnZWw7IpxzJIPhQb6o+SQwvP/vYsOSQsYre1XJI8Rp4cKom7BbfWmBPIYvDucb/WkEUBujXY5chLKsvQGs/ARyolXYUTePMCdv3vxoHDbOn/SBHQUxu3yCmyAG1jrChxinbhLJHZDRNQ3mciqxE2BtOifP2VbxxbVg3aWfvIid+sCE6VLQHq1+wCtYQmyAq8jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6HSPnFyNF0e12CZ8RP3toYIZDO1PR9IFpUTBypYhYBs=;
 b=k9gH+n8r/8qi3BWpB/Ft4sSw+y/prfF7OcNGEhsfSsbvjD1jAMDwQ3WKpWIepVABNdSdXnX5MyMsWyAvrwBCJruX50aKWvEyH/Ohz5CQCm76PTDec4++AfRWI6m1xsXpugBG46KHNIOosaomJ+UNX4LNin3IE1R+2Xg0wDkCFLfoxcIuDarBegH7ohu5c+BFTKLwltARE11CEApW/0fVWipZv9/wIU/GSPKk/OEmyRtksDKYWZGXEPd7B3EMGwsWop7T8MfuF02ETddGyEv94fRhdJlH9UdCjxGnslUvdo4V4PYJvy1bts576FaD31N22rx6BZk/d948CKoTK1aUIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SG2P153CA0002.APCP153.PROD.OUTLOOK.COM (2603:1096::12) by
 KU2PPF58AD76D06.apcprd06.prod.outlook.com (2603:1096:d18::498) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.39; Thu, 17 Jul 2025 07:22:10 +0000
Received: from SG1PEPF000082E6.apcprd02.prod.outlook.com
 (2603:1096::cafe:0:0:88) by SG2P153CA0002.outlook.office365.com
 (2603:1096::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.15 via Frontend Transport; Thu,
 17 Jul 2025 07:22:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG1PEPF000082E6.mail.protection.outlook.com (10.167.240.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.21 via Frontend Transport; Thu, 17 Jul 2025 07:22:10 +0000
Received: from localhost.localdomain (unknown [172.16.64.25])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id C8A9941604F7;
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
	Fugang Duan <fugang.duan@cixtech.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Peter Chen <peter.chen@cixtech.com>
Subject: [PATCH v10 3/9] arm64: Kconfig: add ARCH_CIX for cix silicons
Date: Thu, 17 Jul 2025 15:22:03 +0800
Message-Id: <20250717072209.176807-4-peter.chen@cixtech.com>
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
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E6:EE_|KU2PPF58AD76D06:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ebc28134-bc6e-4828-8291-08ddc502a504
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ORMuzLkNchQ5Ttvl5IU+V7eWRMZrN1EEdUkxvNuSobgWsYKQo+eZ727Ckp9j?=
 =?us-ascii?Q?yZi89eDZGf3MvEdT6FYPdsAFXTTKLAmFfAuBPNYTumjUV4amhtPiecCZ1ch5?=
 =?us-ascii?Q?ELI4hH7NGjjuHYrRmF2NoKPrfMVV+y7YKPOP2jlMXS5nJ7QueokCxOhVZ8xP?=
 =?us-ascii?Q?6El6aamqPRfV8q6WL8jI1OpV6wTucRzPZ3eXLVGfmaQur7PI+LRfCZulp4ys?=
 =?us-ascii?Q?xZb1cIwutn7+ApRCKXn/92neaeY3TEeE89eLCnZo0D9KG1x2kwnP2DRDnkq7?=
 =?us-ascii?Q?swDg1vDGD670kfqRTllgnhVYvnt4UBvs+85UMbJ9UwRvRfY2o6fPUvwbV7ro?=
 =?us-ascii?Q?og82joLbSpOPKfuIgh2Czzwg+c1c+jt9IilHCNkVkBQqrBnf2LNeoGd9xKx6?=
 =?us-ascii?Q?kYspBSQrpAG9V6Mfn7uH8H2HbuE3oukQV5yHxSOsR34b0pFHuGuOUQdT7jEs?=
 =?us-ascii?Q?UG93xHIGJtzDyJEEG7bSojCH8RwXQtJhvdM4XlxBQhV624/qowm/8MdDVtYe?=
 =?us-ascii?Q?m2THmObplmTe5IHmleYERmI7/Hm2mb21Skn8Dk7bQtrEBJleLeyh9DjUxd+F?=
 =?us-ascii?Q?bIbz/dM3LDjLgNFa42qYLYt4REJxiQWIBWAuHBK6XekoJ0qMT0Hu8VrDfZx2?=
 =?us-ascii?Q?a0SPlGxxMvHPSqtDTfj2lwsIsb7l7n2xJMu7NAE6kQ9NvgK/1xFkm/elZH5G?=
 =?us-ascii?Q?OrenwLzQiHk8+HyVLOUoRZ8Gq34SjQevQ6520urYkBQy+WLu1cS4IWfg2m3c?=
 =?us-ascii?Q?cl974Pjdfv7VvSnMHKmWQjovxxhPyGUfuHW+V+Cz4kvsVywXReyzfekiPB6k?=
 =?us-ascii?Q?0ihnmbCdnvrORWfxtinltcJv796mEIqMbq5m3+yzaV4bp8bzcPYQnzA2ZHkF?=
 =?us-ascii?Q?ZmgJ3Mkq/jIWpDG80xuTyprq0R/+BIkPPV6wNymn+20h51lwA3l/I6AijoC5?=
 =?us-ascii?Q?iHtK4Ob2SbcA9UfwdKQQxDDF6s1vkebasg4VqNJhkjlwkYwGkyC+CF3Yzg6P?=
 =?us-ascii?Q?B4QJQssbOD+MJb1Uj765m0Xa4qP5rPlHmNOWSm0Z5NweENOiRYPMt49/ngxF?=
 =?us-ascii?Q?OUT/KD4763UN1EmEk4LpqruYaGfoOGy7vu56CTHM4QIFujOCOECbFgxZglzN?=
 =?us-ascii?Q?2Sq5uV8MUNDDO0soXA4Xkx5x7fidQ1uf4eWUU74JyLLWfDvIyXiYgfnt4pBg?=
 =?us-ascii?Q?ktRd/aQDvQrjVMAsRo3MkrnP0nmeUAfBgGLK3M/wims3fltK7ULzlemLPDHZ?=
 =?us-ascii?Q?vMNkZ4vcnWBtlPN2rxAPbYhqQlQF8PKEMxkvevkPxllFDgNzFM3rqcXDHqow?=
 =?us-ascii?Q?N36t/Kt7z2oy+iUj7KAZ7zQSUmCEGcNaxPaiY1MKn1kQ8vkoZOKOMdDpkttV?=
 =?us-ascii?Q?gCZD7hiWXNrC/evElKCUW6NKMMh3szG+r242/tWeyTAN2aCu0qvktlQ1pcUj?=
 =?us-ascii?Q?zpI32gZowWm8Yx/eFnbo6c3M1Khx+h1LrDoOjZQ02I3oVMDjLlmEk+ts8Q4D?=
 =?us-ascii?Q?d5fm3c+9cqROuCEYBDTAI/gubGQpyJxoH0/A?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 07:22:10.3928
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebc28134-bc6e-4828-8291-08ddc502a504
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E6.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU2PPF58AD76D06

From: Fugang Duan <fugang.duan@cixtech.com>

Add ARCH_CIX for CIX SoC series support.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Fugang Duan <fugang.duan@cixtech.com>
Signed-off-by: Peter Chen <peter.chen@cixtech.com>
---
 arch/arm64/Kconfig.platforms | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index a541bb029aa4..5eda66aea359 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -106,6 +106,12 @@ config ARCH_BLAIZE
 	help
 	  This enables support for the Blaize SoC family
 
+config ARCH_CIX
+	bool "Cixtech SoC family"
+	help
+	  This enables support for the Cixtech SoC family,
+	  like P1(sky1).
+
 config ARCH_EXYNOS
 	bool "Samsung Exynos SoC family"
 	select COMMON_CLK_SAMSUNG
-- 
2.25.1


