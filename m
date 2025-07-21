Return-Path: <linux-kernel+bounces-739476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C826B0C6BF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 16:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E03017DD48
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 14:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73EDB2DECDE;
	Mon, 21 Jul 2025 14:45:15 +0000 (UTC)
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023075.outbound.protection.outlook.com [52.101.127.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E084912CD88;
	Mon, 21 Jul 2025 14:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753109114; cv=fail; b=MqbBe6Pnvtfnh8PH+y+38k8jsJN8MmUpsOOijuo1oeA5fQR6qVnYIQn/hcUNRxopeOeTrcHfovnqtKO8E9RDjj7hufkahH6wG+BR7HUcdhH1a7JbP8/ZT5nZMPKShWp3IpKaedLjA6qw1tFwtP/dv8/ajbgb19PSx4o5ANbg6h0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753109114; c=relaxed/simple;
	bh=UgkB2Sxv2dsLYpGtAl+6smuWsAG8v2mbeDQqd+FEv5g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UxAavy/jQmjF/K0obig9ZXpnk4Vz6IAIqdWzk3vJk2aXjsQSwkfr0eNQWubUqhDSpk+hLm1L9rzsdDqp4yFP/NuHEjsYb+5FP0xEhul+Cv4Hh1sr/V+cJi/2Z7nvjKQDwkJQMw+MJWcw50suXYAsaSDoNB0HTUuo6y5RLtzxhzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.127.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wucNP63WTjfYFMyb6B2/bZh3Aain5kbxTcqVVRtmP0w+sHKN1xhVqx4HcXJC7omw99XBqi8BZnL7AQqd1r6BzoZWxm/rGsZWBgOz+68wRrCuYI0GR0BzzpYJUl+Y3AA2R6lhV1TDbtxFFwQFvDQH4oM05BJr69ZJ347l3xF9O1OOrsI3isxxvFpcVg6ouVf1nnkds3GOcnWv3rlD2vR5pU6e8/7NPpap4zLjwedpoWWuoY3o/1clpEFWkhAjS8ymIXKa/Oh7iodEorM7Ng7oDMTDCXcocC56FY8t0kmQWgR1KFi8+ShrTfZhpYfGokzbzAs54CSuzJgsgXIOrgMVWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6HSPnFyNF0e12CZ8RP3toYIZDO1PR9IFpUTBypYhYBs=;
 b=jrwbaaqhd+1YSeFdvygJ+4G70AdNhQnVaMjQ70AMtGZgtcw1kT6jvktfy8JwnelX7H3NKjF3rIXV5qA4cyGsiyR0ZyG0o3XQLrIf114auzd/RPa9cPO2569n0fvnQKyfYffwk+V3b0O73SVX1+YYYWDXag9dYQHTLn8uHqEpCFjQ/quWK4cOuwwnE0NIeg3xbKm9O4NbZg8FU/m9SXf4LcFDPTQdZi8HLYKMBhh2WUoTqmaejdC12Se7rqKUGQuFeAB7KUKmd7zCCJ8rl+rpl+iMEEfzMfMWbVB+i1u5HHsrSDOptbiER3IKve/4qizPT3EfF9tsLRdBWMbv23Zvrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI2PR01CA0042.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::23) by JH0PR06MB6704.apcprd06.prod.outlook.com
 (2603:1096:990:37::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.28; Mon, 21 Jul
 2025 14:45:07 +0000
Received: from SG2PEPF000B66CA.apcprd03.prod.outlook.com
 (2603:1096:4:193:cafe::2e) by SI2PR01CA0042.outlook.office365.com
 (2603:1096:4:193::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.23 via Frontend Transport; Mon,
 21 Jul 2025 14:44:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66CA.mail.protection.outlook.com (10.167.240.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.20 via Frontend Transport; Mon, 21 Jul 2025 14:45:06 +0000
Received: from localhost.localdomain (unknown [172.16.64.25])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 91126416050D;
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
	Fugang Duan <fugang.duan@cixtech.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Peter Chen <peter.chen@cixtech.com>
Subject: [PATCH v11 3/9] arm64: Kconfig: add ARCH_CIX for cix silicons
Date: Mon, 21 Jul 2025 22:44:54 +0800
Message-Id: <20250721144500.302202-4-peter.chen@cixtech.com>
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
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CA:EE_|JH0PR06MB6704:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1c0f9c63-8896-4824-f93a-08ddc8652f32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cKBKS6JK8psW/W5zBDxyHGY0eDT+DwkB4GnUH4AtTDUctffb+QVtex2H2/QF?=
 =?us-ascii?Q?MuuLZbN4zwoOq3hyloTztc0eTanrAFhF8qzLZ35TIc83aCzKQ+F4z5NH7fn1?=
 =?us-ascii?Q?qayXO2j6Ug48sy+jOa48z/IF7u7EF7BTPqS8UCNx08hfTc9gujgjfwqh7R0I?=
 =?us-ascii?Q?pAdrZcWSlkRuiIiFPrZyMdgHFF6yJlACYmmdI8RR5HFW8/m5vVcwvkri+cbD?=
 =?us-ascii?Q?JyeDg/auewTGo/1AQkdg0HodaK54v5WQY64bzRyfaCXbxuypgLfmT/De+Y4B?=
 =?us-ascii?Q?7+w1QXIa3W2My2no9RlWTYb+ykYIF8PoCiR+fUsZRly2GiSK6UrI6XO5Zhxz?=
 =?us-ascii?Q?aG5Z21huR5SObxMRHD1TqPBFjuF2zD1kLGbWaHWK4b1HX+wLgHOAUzLAzQvm?=
 =?us-ascii?Q?ZGm8FDWoNGZF02OyKanyBhTVMBw0CZmQzDRCN0JGrcPE4qHWcQ2HEVrlAyDG?=
 =?us-ascii?Q?h/8FnJmpGpZTW9cRg88TQ7YsAylhe+NYuvQstvwU1UReW5jSXSCW+WzSU8Hd?=
 =?us-ascii?Q?bax8KRErZjKLqbMN2rM1y8tUHZTNGonWcVpDroI1374uCN2cAYnEoeI0DIE0?=
 =?us-ascii?Q?TJIB7fcElo1TD3xdHrvKNNgWU3vZ9/CL1mvBEU1vHgcHNNDa5MTRPDodIlGK?=
 =?us-ascii?Q?rrtGDmVp7t+efn1ScZgHu++kyQ2+kzHg1RGueeXFy4vnSgCGA0WyzMuFQQxd?=
 =?us-ascii?Q?gne84mfzGouA7tmb8Iz2jh+XFA8+gnlXU0Bj5tVwp60GClCYrdKVtcpTzUj1?=
 =?us-ascii?Q?N0pn+oCqo1QV7c5o1uQW/g+GfI6bTtkP40aS4Zp1BiPyUD3yVSBdcXdg4MEU?=
 =?us-ascii?Q?u4Ak2X5dHt0YS0DmEz9aZqMTRDRKgrAb3Q1IL5Ww8q9YCQpm7tZSGRxPTbD5?=
 =?us-ascii?Q?W5JwIQCqjjJtjdbyBamTxGvm9JhlPOWGxVkrEfJbAjvzjKNA+OOJeMpNUVW7?=
 =?us-ascii?Q?+v95tx+TTleUhyhQPxMwC7/Q4TpxWI0jCfESpnMD53e+zT9JNmksDSDhq69P?=
 =?us-ascii?Q?bG4pfs4VMTrUM1urX3f56GrsruNw/J6gbEYgHOoYZhOAufLHTmZH4AfFiE16?=
 =?us-ascii?Q?fYJM/t6n9mRVNW0N005QKS1bLVPtVl7sTgTYJlJl4XsF36G2jqXhTVcIf7kN?=
 =?us-ascii?Q?WIBke8fncUA82hRtbIBj3wkmYDQzcBtwOyIYQii2vNHYZOFkV+EXmpFhSOtF?=
 =?us-ascii?Q?HrG0FsvhtdBX3Azc3PgFBQ/YYtskzRy1kNFrvlFIibLJp1YECP7gU+flJeti?=
 =?us-ascii?Q?P4oMKAjAxCAgtwyGaqUJZj62oYBI7WPvNrWvhaViX9Ub2uoqFUutNMyMHvTq?=
 =?us-ascii?Q?lU1Wek0vcDK6Yy4NjVGS1X2KnVKhaYterH2d3mk0LB/DOd0PlurUUFEv60s6?=
 =?us-ascii?Q?AIKVa+n8/cn6hJv3M58wuvjDftutkfOWC1/Qjaa02Q20lFyCW5TsriG8M5X/?=
 =?us-ascii?Q?Mh8WmnJVDAf6GZ8f6js/RaoH2IIUJ2pdfEuNsyD8qMZMjj9fxfxLwtLvD2Te?=
 =?us-ascii?Q?JhkN2e9ItLzgSGSAgJrhFGt1ulf7gAg6m+y0?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 14:45:06.3895
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c0f9c63-8896-4824-f93a-08ddc8652f32
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CA.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6704

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


