Return-Path: <linux-kernel+bounces-809376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9919B50CC3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 06:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B3217B698E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 04:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E769B288C38;
	Wed, 10 Sep 2025 04:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hJ7LJpBT"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2072.outbound.protection.outlook.com [40.107.100.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B9D25C6E2;
	Wed, 10 Sep 2025 04:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757477893; cv=fail; b=Xq3Ut5PoVNSkMeThJqB1TBfM5e7dxdF5BKxIqAB2dPIFjFTGTbfDKzrD+c8ZMwlxWVViAzZ5YlVjUzTh55JY8xAJaFnzY1CtWEHggSSoznv+W9WObPcngGg8gJMgicfaMtnbLIZyvGn26ahYG+28tr/qSAVvzvvWxVAKt/QYwQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757477893; c=relaxed/simple;
	bh=TMohRoDmwbqPBABQd4XQanG7m0fGKiUaPlpUzzYlsTI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N1uo/fvebhwpF1Sf0vAzSnE6lhzXF4X8KMF9pyvVc9g9TJXe6PW8M6aVhV9sWvpopgsUlCcsn99GYk/B4Ny810fLnBXvBVG/UjfdjsY5E3ZjDI0TQ0mfiyRw0Nue3vPUiM6kKZk6I1UHGQiKMXxW3vYVgbc776s3rDzoTxasX+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hJ7LJpBT; arc=fail smtp.client-ip=40.107.100.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sQ+o92ge21F5z/HzV6pO2vZQuR1SUb5bNEJ0BGB9SfBQApsf39BJTteZoz9TihceSsU6t4BlClEDkXiQMZsWVzaY5boq7oSu7e2HbODwJiJtOX37KporKQMpW//g550g2hCDNM6fILhAWOEkCXFmpchfsjezwXvHcSiQTBeInT8Fn4IIIkGaiVZTJ39U4cGkhgIpe29lp1lq0Scm59PdloI0H8kwXGXUxfXALUhFmecWHm0Uw3XhJWiGTqIHai1pu25utr9tbjEexLpws/Ce3VMUtLweyl27oXvzUz/3ATu1NtdocjehVAXOzkxvh8O1MYjN3sKCSiKrhnM5ER/nog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sO9hxbyZhHDdinaF6r2kJd79GHsslS2ciL9LKu4zkpY=;
 b=Q5dT2xkZVxCI09o5FlDyCPT5yHeK5jBvy8Mk0JbP0MJp+sj4QFdiKSlUtcsmLerFBQCLRzYxvZTR7qAPG89r06F27O1iNu2b/f+ND90slHW008K9O1eaP+PjZlI2hobVIFu7w4fZjQb2y3coW45oFEDGQvoooRq+xL65/00CBLZNxgC+a0va9RkNmEJ+8aNpy9skdl8kPlFlnAaL5GTuHKhA6oIF8bIg+i8tXn+3DdFltHTfFv+jKzcJeBHope3SoYUSwKiBUVFCHoA1fumVUaGObDM6FI4jWADr7yNFJVolRq1r8OXYbyynW7d4rLEgdqJmfFPUzPnbah0jKGXSZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sO9hxbyZhHDdinaF6r2kJd79GHsslS2ciL9LKu4zkpY=;
 b=hJ7LJpBTXtZwzisNC86wWIZ2saK2Mr49Lm4WGUGh8oH1TqR0zofKR6V2gz2NfiOUTENlgbdZOnEYhfgnoEMcK0RfM0cWkDmzLgkwimjmVuqH2DJ+xIuKyVpwIgU2+xQ98WKVcqL04FuLbEpPzzqNlVLSZOggaDarzvKqmm0QXtlMbdmEJhggp6nYnPr/TcQcR4MD43XOaDot0hf1hllBzzr2xbfTUZsVEpzU+uuVpblK16snPxyNO6eeRwBgJOgXpwpblVFwZ/voDQPt13Hvyx0+nX5vfdrc0edZlapJX/2p79CM2OAR0dzh57VPZvNBQHXXOkBpf5881AvZGmQtRQ==
Received: from MW2PR2101CA0034.namprd21.prod.outlook.com (2603:10b6:302:1::47)
 by SA1PR12MB9547.namprd12.prod.outlook.com (2603:10b6:806:45a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 04:18:07 +0000
Received: from CO1PEPF000044EF.namprd05.prod.outlook.com
 (2603:10b6:302:1:cafe::d0) by MW2PR2101CA0034.outlook.office365.com
 (2603:10b6:302:1::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.4 via Frontend Transport; Wed,
 10 Sep 2025 04:18:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044EF.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 04:18:07 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 9 Sep
 2025 21:17:38 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 9 Sep
 2025 21:17:38 -0700
Received: from dondevbox.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 9 Sep 2025 21:17:38 -0700
From: Donald Shannon <donalds@nvidia.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<donalds@nvidia.com>
CC: <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<openbmc@lists.ozlabs.org>, <etanous@nvidia.com>
Subject: [PATCH v9 0/2] Adding device tree and binding for NVIDIA GB200-UT3.0b
Date: Tue, 9 Sep 2025 21:17:34 -0700
Message-ID: <20250910041736.245451-1-donalds@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EF:EE_|SA1PR12MB9547:EE_
X-MS-Office365-Filtering-Correlation-Id: 56212dbf-12b7-4406-978b-08ddf0210b68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?supkqL/TkAUD0dwXKgfWS+TNBIDmgZXeAsjvBy7SyxvGxafMaWjO247NzZHA?=
 =?us-ascii?Q?R5k+mU8YvPbLDD3B86g8pUEfUVPlYoWTrqjlcWEJfLi/M74NvjkxMODdVoPU?=
 =?us-ascii?Q?UdajCUjWqhZW73KEayssNxCq7HK0vOh0B/l2G2Nvcrjr/2iCeLd37iu6tpqM?=
 =?us-ascii?Q?JKVOfOdSM9FWslJ2zPMmf1Whbemc+I4U0HI2ZcwBw1hhc4uoWKZGH0C/5sUK?=
 =?us-ascii?Q?ZrTkhvyXhWIKT6An8EwcDalOHtikP6o63i+j1Yu55ZEpe9onfdi6kJaBeG5I?=
 =?us-ascii?Q?PyCIL3Mm0Gp4ORR27az5xIkljTEQOMJDHG9jT2z0qwJ9B01Im/vVa+My954j?=
 =?us-ascii?Q?1OD0D3Os+9Wswdr1+CBHY/pUugZUuU9wjUE0vR88sHgocNsa/+rMG9jhlfWZ?=
 =?us-ascii?Q?2HplCsD8eNZO/sq/vZnoqxA7xeMiOGCf+fp7fZEvPJdq8k4Ki4ytXxV/L2YL?=
 =?us-ascii?Q?xx2wuzCYHPCx3DTiWhyZHiJ/WWrxWuW1+8jyOsBcxcxvqi8aW/ygm76YKLRO?=
 =?us-ascii?Q?ZhXYiLKsapmmDFXGpX3KPZNCvMtKsC7eU2PzHE6K+b3QfqLptajW+06sD9yO?=
 =?us-ascii?Q?MAbCf6gWgzR4dOnDiLN5w6Yld5Gefb9W0rOTos2dPThXMTUakjOyG0fSKiod?=
 =?us-ascii?Q?KeCmLHPNFl/PbTHHzIYOIgPdUo6lVzdrIozjhaug/TZfreT2aALK+vJpz5B6?=
 =?us-ascii?Q?g9x164p1dn1lvKo0oMlQV5c0r+x1XERNcxOWIFIultxc6rvLJPISBV7PWBoK?=
 =?us-ascii?Q?e8lkCe9Xi/7KtjybU9B5OBuJ9ZMt1HyJ1oeE7reabl/93Hkh9O8WE/RvjrAR?=
 =?us-ascii?Q?pjDkSDnIDi9ZLHvfb4y5qcMhjOvF6msufnoN5RyyPWQ8sNdn0PK5P0mcanBy?=
 =?us-ascii?Q?8eiljIu47vRoZnl6rpgTnn0GbdyrUrjXRX10Rv9xiUNNdZf8ENXe9Bdct9W8?=
 =?us-ascii?Q?124Kdix3kG/cR91HkoZQxSodubZTNEiSHhOcPXhtHNP8HYAXrAd5Qd22MPH/?=
 =?us-ascii?Q?0bBfR8xknPZWFD3jQTj0n+zCKHiqLC7WaoJqAvNxJcP6mfjcbsWukU0fHEOT?=
 =?us-ascii?Q?WAkOYUUnp6tMOhORBBQlVnmgQ9aEBD5GwQ3sRdVPyw+RtBiLvzNqJzAZqwc8?=
 =?us-ascii?Q?iYpawV7guUQxMc5lJfLb0y4zNIGpHjn87zmoGnAeyF1rIAFLkcYnBEyQgFkI?=
 =?us-ascii?Q?9jqsHDH3Lv+nnd4g/qZxemQ8hk/gaS5URU53xq3dDIfGZst/YpeqYr00CNNk?=
 =?us-ascii?Q?BPxV2Bz/3YS4WbPquchL/uueQQfxgMnBk8zv2wzQaHDDjN0ZlcYSEz4qD+/d?=
 =?us-ascii?Q?586Yyjhe+DSKb+pW7EkJwB+dVSYOsXlZ/fogB9cxFGcrLMlZd9C5Oyms9K5E?=
 =?us-ascii?Q?HWPFNFfqZlsO5A/ADyUfPt/VuLO1+EADFWxJ+j4+sGNSN1CPaTuGn3Z1y+FT?=
 =?us-ascii?Q?49CN++Tvs7xPJHYyd8quxHnyYiT9PIzXHRCvsPMxkVlG9fKXqttPKuAR5gaQ?=
 =?us-ascii?Q?Lax7qerwoD45sDoeEaY51astw19rSMAU90AgMV1hiqT68v0mrPv9lhEmSw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 04:18:07.0617
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56212dbf-12b7-4406-978b-08ddf0210b68
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9547

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
 - Fixed schema validation issues from my end (there are still issues
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
 - Added Acked-by for Krzysztof
Changes v6 -> v7:
  - Removed Acked-by Krzysztof
Changes v7 -> v8:
  - Added missing linux,code for identify and uid button
  - Added Acked-by for Krzysztof
Changes v8 -> v9:
  - Changed to alphebetical order
  - Added comment that our flash layout is different because of our ROT
  - Removed unused phy-mode property from mac0
  - Removed empty uart_routing
  - Added temp-sensor
---

Donald Shannon (2):
  dt-bindings: arm: aspeed: Add NVIDIA GB200-UT3.0b  board
  ARM: dts: aspeed: Add NVIDIA GB200 UT3.0b board

 .../bindings/arm/aspeed/aspeed.yaml           |    1 +
 arch/arm/boot/dts/aspeed/Makefile             |    1 +
 .../aspeed/aspeed-bmc-nvidia-gb200-ut30b.dts  | 1032 +++++++++++++++++
 3 files changed, 1034 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dts

-- 
2.43.0


