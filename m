Return-Path: <linux-kernel+bounces-737431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B19B0AC7A
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 01:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 556E7173EBB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 23:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A30422759D;
	Fri, 18 Jul 2025 23:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aYmXWN2x"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2057.outbound.protection.outlook.com [40.107.100.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2887D098;
	Fri, 18 Jul 2025 23:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752880310; cv=fail; b=sZYqzL57BE2vGagissYELgNFnWaemzrxIbZl/SQbPN+lrgztNFuqw2O3CZEQyOVydaMbDRz8UMsRZFyTl6zlF+f3oj/h2Auze6uItwOfQ/h7u1V3w5SY6b1Ie/90x+1SEOGP7ITeh//OB8i9cTzE5xKps12TBoOO81QaaNCEkwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752880310; c=relaxed/simple;
	bh=2yiI+7ooimU147w9cAmr0Sib5apGa8HNVVZgG7a/byU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZQKH2V//IExRplnriv8QXPYPiZZmrOpPtQ9bQgLzIsfEy2x1d+ZuEipnBnpV5ybkldBxw4fCA2877iyMo1sViNTUSu66GdY0NOJZQ9R4Q2FnVqb8wtJ/yD2kKtiwplOHVFlEWvM4jPNDg927DPNhzM9wpUcfCKNXiAmVDWvlbnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aYmXWN2x; arc=fail smtp.client-ip=40.107.100.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PJjjBHtlDbNW8+1gaZNcghmTjB8B7R8qsfk5m4dcIERbjvVBiciniQCj6MJlabrD4/GgTBanVVVHz3e1JXR1rPA4X7VroZgmPMzKgk78MLJy3IQSV9urXgMMw+qaRReoeS8gxbGGtZc8FCyB6ryOQrv7FBedBbUGieAwUYAiIL5UOSIPh2yr8DI8v4xrbueKj8UkcabIn6LWN6Vo1XKZcQkBBJ3fKC86Nhiwm9AJ2wudhcr0CdlbnBtUisSn8RZqmGKafkrhggtpcber9DSPC7SQtmEGLNpc7QS6tGtjR72QAl9HmP9r8IP7fEOJI3anPHE/+cOmiXSMqGO8jHKllw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E3ATMC2qdaMcHIBiexPD9N/1El1J6XW53EiLP/4k2l0=;
 b=tjVwpkw8rKWnhPEVtGv1KBP8gjxr63nt8xKZxzmhbwu8R0qvk5dUjyurWSic8gh3e5g6vtO2R4Qs0jF12PYmL01+girllAm9apmipXb5/O6bBlv2Ecetw6iniAZKeZc6d2+xAdWPqQFoVtrLmvbEg7XGAGrKTI0XhXT+8pzJVVFbo1MBjM8DlLU4Lqo3S9JIrVX3W89uwNjcLlsuLbUBAbw/BQpQ0xnNiXrwurC8Y8tNwyNBQpLTWRHijCSAdR5rbM2KdgP6iTmxvYDWgRZ1IcEK9LwsTS+B6C4Q9bYb00olTSZrWH2N/QcyUHE2fSIKAZnvWS/uPBwDjKEM0hHPJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E3ATMC2qdaMcHIBiexPD9N/1El1J6XW53EiLP/4k2l0=;
 b=aYmXWN2xzc+Hyi2dOtGXDzaG915RIbGk6c4RmM1by8VtA6ricXm5eyme5AmgtxzM4tqbcsgBnSEXDlFqW/ukewbJKaoEb0u4AbIEtWZz5CwV4Vd1OW7KY3YnoRZ43E15uyFONpZ1Q2Towbr+dzkVtutNKebEsgpLgoGldlWpp7SVJkHJQiJYFMliNPeEYpDYdXmpQNY1krQr4t/efXox1lgIT7toflovhJ5dK4MDOhi+3UZ1a4TIEB17Uif+lY3pO1kQsyGqL8aTy5SMHA2/BvQU3i8YML9uSHg8yTHJspZDjAZwSLBSvfTNnf90HAG2oxbn32Wi5n1dyi1h1evi0w==
Received: from DSZP220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:5:280::14) by
 IA0PR12MB7698.namprd12.prod.outlook.com (2603:10b6:208:432::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.24; Fri, 18 Jul
 2025 23:11:43 +0000
Received: from DS3PEPF0000C37E.namprd04.prod.outlook.com
 (2603:10b6:5:280:cafe::f4) by DSZP220CA0006.outlook.office365.com
 (2603:10b6:5:280::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.23 via Frontend Transport; Fri,
 18 Jul 2025 23:11:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF0000C37E.mail.protection.outlook.com (10.167.23.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.21 via Frontend Transport; Fri, 18 Jul 2025 23:11:43 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 18 Jul
 2025 16:11:31 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 18 Jul
 2025 16:11:30 -0700
Received: from dondevbox.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Fri, 18 Jul 2025 16:11:30 -0700
From: Donald Shannon <donalds@nvidia.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, "Donald
 Shannon" <donalds@nvidia.com>
Subject: [PATCH v5 0/2] Adding device tree and binding for NVIDIA GB200-UT3.0b
Date: Fri, 18 Jul 2025 16:11:16 -0700
Message-ID: <20250718231118.3330855-1-donalds@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37E:EE_|IA0PR12MB7698:EE_
X-MS-Office365-Filtering-Correlation-Id: 16e527a7-8bb9-4115-1290-08ddc65075f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W68IQpIv9M0D3SO0PGi0CZ0mBOA93TmM6bM5G/dzfJq6xtBF2sV0LjJbs1fw?=
 =?us-ascii?Q?g/Ga/gzuua7TWIAg4RiWAP5/IN7sJ0RMloEpDyJ02BZOF4VcWivgFGhKQO69?=
 =?us-ascii?Q?yHryMqypYkzs0PbxbXG4cSLMqdd1Xd0AM0npbvVOa0C2G6fc5rkBuILPiz16?=
 =?us-ascii?Q?fGIO/0LBwGAgWAYaoFV3uF2hw1Hb+zx36YvSvqdVOHW3dQcSUf/RKG8hrt0m?=
 =?us-ascii?Q?rLdlcOhooo5gPLdQlJvnIdrdKggsspJhqTXAydi83rfTOdbSHn3BxycYDCn7?=
 =?us-ascii?Q?ObzrYzXZ3LOJCMUC0Kqw2DYOLzwXB17QXGMGxJa8/nBEWmeAWWDLsvsAbXp/?=
 =?us-ascii?Q?lYdGbvOcrmutK9MgpGhCWqQXJASjwAaGZJ9TgsAGYrlaaolEqIxyTONwBnIM?=
 =?us-ascii?Q?g2EA3dWDiFpT8CvN6gF7ze9UhFoVAoHoWCXxX5e3gOSszjQVdrDI3s8IhJu8?=
 =?us-ascii?Q?zIqmAp0AUMBNIyXoE1E05YQZ5JnJ4MYiTDURSPD6RXRNq3o+fD5vQAwj94f5?=
 =?us-ascii?Q?u0cYZiuvJu8rQ5fTkjP5vWCMx/lL7FY0/VPojWz1vOQ4bR9GIk+qqUWZGnRB?=
 =?us-ascii?Q?Y+5RUECAeLsK7Q4RnqnifqN3soZ5Lnm/egnEtY3OfSiTgMaAo0BhaYZq5RuC?=
 =?us-ascii?Q?Mj27+vBK/VFZ/MIEwORWWztKfznhTsAyx4uNwmo7w7rR+DFm0rcDCdgt2lFJ?=
 =?us-ascii?Q?DDY+HBe+y2Tmw41SWzFtjDR3pnSsXoZaWufMxf3G9jOoLXzmHktYrH/ntXaz?=
 =?us-ascii?Q?ZS+7ZrQ/StgOM4QXcAlCReh0dGs+agp9vPVHXLVERWRFy8zlR6+OaZhBjaRC?=
 =?us-ascii?Q?dvgnWrUgGSLLUWRjkWZd8HRiiZ601xsOFWGWMxpg1p++vPQTfNMzOa9WIeYF?=
 =?us-ascii?Q?ZBgbjd/NEUW4HS1j3hk6gY2s/TVEGc1B8m/ihX2GJbNKZ3mIfjVCFINBD9R1?=
 =?us-ascii?Q?5uWJGWwMRcH6EAb1WEjirzFImSVo9g/L7NPQrSTmzYzDv5L1YoB+KhZwF16N?=
 =?us-ascii?Q?nxWg95Ru52Dnj9FYZIYRqPzNgLlXtv4HfXlgqg58hHgTCpl6mVDOH/IiQuG9?=
 =?us-ascii?Q?3rFqS1YNNQQeKtTXIRRNttUYWs9DDtIi8e9QbiuLHatpnle+Q4YpfuqLu21s?=
 =?us-ascii?Q?OnTMPlyG7MnmG5ClAQRc68uQP8+eLcCHe+dN6YUXa/9B6nVHGd7BGd9oCDjb?=
 =?us-ascii?Q?Tuv5ZHzmd2Y++fcP/O/dLkaJ/rAVnZLiMgh5cTAud0w6hgTjYqHMm+9yk2XS?=
 =?us-ascii?Q?cHFssOuUrd+bV5Bd3xMzQhpn+P+XV8lFB+TDlfuYnX0bZQJVbiHGMY5x5eNe?=
 =?us-ascii?Q?BacqWpB1qPRMMSQOa1RCxCRbKP0vwUY6605kGXX/a77e1n8UIB8P+k1YogPF?=
 =?us-ascii?Q?wG7fJtVm0YJNE/NJ1holocU1qlCkS6SWfeJnbAMihxQKNz8AKNNxWlvuXHTG?=
 =?us-ascii?Q?wd9DGr/PJYN8CmTSChZspQqZOukB5yh4al7O1TE9Y3QAFfIt65YpyJwlDHhb?=
 =?us-ascii?Q?hZRRlkE7YCSjzn1dxAoSiPz/iPM1D7MfcQUe?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 23:11:43.3487
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16e527a7-8bb9-4115-1290-08ddc65075f3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7698

Patch 1 adds the binding for the NVIDIA GB200-UT3.0b platform.
Patch 2 adds the device tree for the NVIDIA GB200-UT3.0b platform.

This is an Aspeed AST2600 based unit testing platform for GB200.
UT3.0b is different than nvidia-gb200nvl-bmc due to networking topology
differences, additional gpio expanders, and voltage regulator gating
some devices.

Reference to Ast2600 SOC [1].
Reference to Blackwell GB200NVL Platform [2].

Link: https://www.aspeedtech.com/server_ast2600/ [1]
Link: https://nvdam.widen.net/s/wwnsxrhm2w/blackwell-datasheet-3384703 [2]
Signed-off-by: Donald Shannon <donalds@nvidia.com>
---
Changes v1 -> v2:
  - Changed phy-mode to rgmii-id [Lunn]
  - Removed redundant max-speed for mac0 [Lunn]
  - Fixed typo from gb200nvl to gb200 in Makefile
Changes v2 -> v3:
 - Fixed whitespace issues [Krzysztof]
 - Fixed schema validation issues from my end ( there are still issues
 with the aspeed dtsi file that are not related to this new dts)
 [Herring]
 - Reordered to follow style guide [Krzysztof]
 - Removed redundant status okays
 - Changed vcc to vdd for the power gating on the gpio expanders
Changes v3 -> v4:
  - Added changelog [Krzysztof]
  - Added nvidia,gb200-ut30b board binding [Krzysztof]
  - Removed unused imports
  - Reordered a couple other style guide violations
  - Added back in a couple needed "status okay"s
Changes v4 -> v5:
 - Resumed my patch after a pause
 - Don't plan to make this include of nvidia-gb200nvl-bmc due to some
 platform differences
 - Fixed io expanders that weren't gated by the 3.3V standby regulator
 - Fixed incorrect interrupt pin for one IO expander
 - Removed some IO expanders and I2C busses
---

Donald Shannon (2):
  Documentation: devicetree: Add binding for NVIDIA  GB200-UT3.0b
    platform
  ARM: dts: aspeed: Add device tree for Nvidia's GB200  UT3.0b platform
    BMC

 .../bindings/arm/aspeed/aspeed.yaml           |    1 +
 arch/arm/boot/dts/aspeed/Makefile             |    1 +
 .../aspeed/aspeed-bmc-nvidia-gb200-ut30b.dts  | 1027 +++++++++++++++++
 3 files changed, 1029 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dts


base-commit: d086c886ceb9f59dea6c3a9dae7eb89e780a20c9
-- 
2.43.0


