Return-Path: <linux-kernel+bounces-741720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB403B0E837
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 03:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 804081C84589
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 01:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7357818FDD2;
	Wed, 23 Jul 2025 01:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y2QlOPTh"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AA51853;
	Wed, 23 Jul 2025 01:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753234987; cv=fail; b=dfARyeXkuq3esdhb/1O90WYCn56y6G83H/4eufYiqbn2F6nOBWJQNi3imHlBI8iNcVqRwLHmFA/1bj76T4qjurwZ0I/az3aoKvtRl/xnjXaLTVhbV+EHMNKRGr3wKUUi8liFEXQeMqbeiEDsGYB19YGC++RL+nboG4Onqo4/VH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753234987; c=relaxed/simple;
	bh=BqrNyMm6CHqa6aIM3qw5JTTafiMjITq7U5RavX4hG/Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DGgEnCDZGca21Yd6V6fik+8g6NJMLjvyO2pdiLGJEYd8oFa2gIS/b5jF9BSvp08isICJkIKVNeO1IZkKyRgKXvoNcdpRi1hX1/3LKeml4J1Kyq2Qfxya3oU0VRnboGrYAMYAMNn6CPPl2cva761hIodlc0KacNwEbgkzY0dCWvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y2QlOPTh; arc=fail smtp.client-ip=40.107.236.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XhvPrKv1xzSefYgnVB1mPgTAGCULLVskkEhTTYNGDUDZNWP1STsxcch90Ela6tBL4YxvkJJ4tPJ44t6dzMKGEbHfUp3vqmTlVt2apozKcHrBOZzio5Om2yYHIp//YRw60skK1qaTAdgGL8q/3bNQnXasF+ZoWFB/v/gdfGQUrER9E/X3Ab3+XF/nHxwOpXtGoNy4V1UxpQjRqBn7LdbCves9fdm9fY+KKGm9WDfWGcRyK5I6QTCrMyJyCKTTus5ZP2btVLPIW8gWgf+0U0R/6DMQUw0jnb7ArjEThPop6Dy7UKu7IEzPWp2XU7m0RCPJmdox8v4glfX5Zyh3fuLWMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FfVjNGzvlm3egc816w9x32eNreHp9PYIFit8tk7zBAw=;
 b=OHJ5zOEI6MBpjBewWWG5nJoB3awHuEuuyoavEIs99UuCa4vrZc0aOPT/NTrF0Ud+DiY5sCaNEwhFnINf8/281tYzn7C7aOnYk1nek9Vpk3f5nzK9nogTmjpm8dSV+OQwQK5U1JiXEWIS3XTOw5urXMQG0tplesEdFhqSPjpwkv7iaC0eoPPiwugsJ4mSJ6CIXiBjVmUI+ZfGcsXY+t4K2gfq89hU7Wp9WWC9j2d8meTe/gUIxxiGUdM1Hr45EIQMigUPxTEAI+9sP3vDmiYJXhmCkWmQXo78goodLJFAxZPi3x2Dvnzo2LCjhzg7eLJqcSznRZ+yqzII/xE4pcXSkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FfVjNGzvlm3egc816w9x32eNreHp9PYIFit8tk7zBAw=;
 b=Y2QlOPThE7U0MhpDnNZIhZKxUGfAoHDgjez4ToRKq6gCHkxIcrQVAHYYBC3hkkKzdxRFZOtEEymsaN5y7bZ0/65gry4UQzjS9Tw7e/FzUdmZ9v0gbaf3UDG0k0T8Lr+qP4Ujn3fn96Oq4QJGi+RMOEq1N0sdYxMqec4gttnpR28wOcF1M2r7yqArEac1vyOk/eOVjS4Ik0ADMY0i6fT1UGka/FGC4nkhcc6o10eLC5sTJnCgqMQzqd/ITeCMzBR7EnUV79y0gEsPIWZX/1tri5ENWfSXl+ssIEuu3zn5Iopmj8yEbWOO2n74C9U367zuIgq9vWQyRz6ywAZbbYUU7g==
Received: from CY8PR19CA0048.namprd19.prod.outlook.com (2603:10b6:930:6::8) by
 SJ0PR12MB7067.namprd12.prod.outlook.com (2603:10b6:a03:4ae::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.30; Wed, 23 Jul 2025 01:43:02 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:930:6:cafe::ca) by CY8PR19CA0048.outlook.office365.com
 (2603:10b6:930:6::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Wed,
 23 Jul 2025 01:43:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.20 via Frontend Transport; Wed, 23 Jul 2025 01:43:01 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 22 Jul
 2025 18:42:41 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 22 Jul
 2025 18:42:40 -0700
Received: from dondevbox.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 22 Jul 2025 18:42:40 -0700
From: Donald Shannon <donalds@nvidia.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, "Donald
 Shannon" <donalds@nvidia.com>
Subject: [PATCH v6 0/2] Adding device tree and binding for NVIDIA GB200-UT3.0b
Date: Tue, 22 Jul 2025 18:42:37 -0700
Message-ID: <20250723014239.22667-1-donalds@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|SJ0PR12MB7067:EE_
X-MS-Office365-Filtering-Correlation-Id: b924ce79-564f-40f2-7967-08ddc98a42ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OpahfUZ8/t0JxzWj7DIrwx9xQxlIKVFcXb8U0yIIsqMO/ePjP/gDKeF9fD9e?=
 =?us-ascii?Q?Ocv0uFBC9uN6ubk5uBsssWnSl+SFHd9spd1uJ6Fu0p3FTOgGljd0JVfHpoZ1?=
 =?us-ascii?Q?vvrfDlQd/d7hFb2xVr3Bs/7OWxxlNafOIjfajCltwq9qusnVa/hOUmsiNML3?=
 =?us-ascii?Q?XLib6DP6nVdG7ur3bSNVgSlb30WOXHN3dxmDw2evU6bWZ4U7hxoVRqSlLHHF?=
 =?us-ascii?Q?KYjiI44f9XhhBRfDtDDEisk++1epbqf0v/e3uV5m5ushqvL/gfv8FI8i445+?=
 =?us-ascii?Q?RPzGA6nk/cWhI4PrJu20QvhKWr05Ds5cDt4sTlxWK50x32Ew7or+Q9JLb1AX?=
 =?us-ascii?Q?RSh9u9fMl6+do0cg1zqEGK3ArVdlpFKJ81Nlr3r2EOZVBABikGAwxYNyBjws?=
 =?us-ascii?Q?cGP0EFkhyFYQKJFoD5xkBN0HSgv9YJ2JFDiE/sy9KYA9A9zLWfpzp5wp7ib6?=
 =?us-ascii?Q?FunCJEO4l7FaNciOuySZRp2KZg9bGkwQH4djiFpkmzqpWQV7mjzYHN6pgZkn?=
 =?us-ascii?Q?Kg7eOpSqr/kbXOXWjzMbd6QgTMbnHLsc553lsmQFYVhSBnd8yYJCd8zU8wIZ?=
 =?us-ascii?Q?ew4o3APo/nX51sygi4XHDD3sy6R7dtchv0hhlEXaaG1Y1pvX+9nsF2UpMbqi?=
 =?us-ascii?Q?prL3l1/olZdRPKz+La2c/ibq/VhnPknB4lJQ7iYz+9aRmS/wY0n3d8R9opbQ?=
 =?us-ascii?Q?Ej6Bgrr3WOkFFS+C4nTDsddrihiDCy7Am+GX1s28EEhalhw4QXSLFLV2JGjj?=
 =?us-ascii?Q?PMArkXTkSi9L7wOZ+NKhZTqEiOwzDPvsEP8Q3Yufa2/sNppfty1auVw1EFmx?=
 =?us-ascii?Q?UdGCVqDNmGJaE6i70cQ02pkK3pH/dA8/by017T+jsQus6OizRvpM31vqE+tv?=
 =?us-ascii?Q?aSJKNM46eV4zGLozxaf7TiOd3jWKSdlzlG1Ad5Osl+AMly7JtNG9qqQpqWcC?=
 =?us-ascii?Q?m3V9XEw3Sc5e9aAByYVaWUzM8I2CSs1HIv4XSOQOn38UbIsqQTJ6ZUd/IzaG?=
 =?us-ascii?Q?MKjSPfoVwapdQAkYCQlmp7jesKELCJBnWV0G1iLKB08UzzTDdRhmCKPGBGw8?=
 =?us-ascii?Q?7FnttWjXYaC0/RZ8SDIUlgaKuneTwjXHI7tXzrfggptuBF8Yxvlk1ScrFIfv?=
 =?us-ascii?Q?Lu+VQOby6eUB2bKb71ifhnUKeNpC++DH3aNLAojz0igxoNpTTqUeNrW5n+zF?=
 =?us-ascii?Q?g72sY3RsAKDhIg3epsEKFX1r8qTM3k5+ToWep5nys71l3z5kuABAeKB0clH0?=
 =?us-ascii?Q?yb7RcG/NA0IflRqoHYrJ7Zp1yfmrVPutffHyL64aq6GKpmLJuuGEOXzFUy5y?=
 =?us-ascii?Q?MaH//eSC2s/FG43VQAu/TLUWvRb5NVyER7erAU+bsGRXEjZLs2WOScVmUlAU?=
 =?us-ascii?Q?ny1r5nrR8MrIGMrO1PK7uJQyH0BgSEkszVf5zK0H0LalxjOAGYdTSW7Az7FE?=
 =?us-ascii?Q?Owtx4qgrabiZaHrhIep3TCx44wgfUxBG1yUeTv6vwl9kYp3c0wjxWzVE6zHf?=
 =?us-ascii?Q?SrtvgQiRH0phr8pgvcSSmLge8vxj8Ilpsr2z?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 01:43:01.7461
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b924ce79-564f-40f2-7967-08ddc98a42ba
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7067

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
Changes v5 -> v6:
 - Fixed subject line
 - Added missing gpio-key compatible type to buttons
---

Donald Shannon (2):
  dt-bindings: arm: aspeed: Add NVIDIA GB200-UT3.0b  board
  ARM: dts: aspeed: Add NVIDIA GB200 UT3.0b board

 .../bindings/arm/aspeed/aspeed.yaml           |    1 +
 arch/arm/boot/dts/aspeed/Makefile             |    1 +
 .../aspeed/aspeed-bmc-nvidia-gb200-ut30b.dts  | 1028 +++++++++++++++++
 3 files changed, 1030 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dts


base-commit: 05adbee3ad528100ab0285c15c91100e19e10138
-- 
2.43.0


