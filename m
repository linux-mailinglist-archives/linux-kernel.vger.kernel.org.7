Return-Path: <linux-kernel+bounces-898847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B158C5623C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 09:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 274FA3A9E57
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 08:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8F6330B36;
	Thu, 13 Nov 2025 07:59:45 +0000 (UTC)
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022074.outbound.protection.outlook.com [52.101.126.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9665832862B;
	Thu, 13 Nov 2025 07:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763020784; cv=fail; b=cC8rRQDl2RgqtpXz+Dz5hPczYF1JDinLJX/jhQRgzanxb3GaeYXJEbynoKYdXPVgc/AM0771NURf4MHYm4zgFVW0kw0wJsSnRieORdh4E5TDlwB/PE6xavEGaLZQDQqI+MJ17cGPIB/1+XpCO0dp+z8WSBG6ocPxumTh2LuBHzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763020784; c=relaxed/simple;
	bh=FCrShrwNhP5tRTQNiSeIEy/YmrWHY2FIIyUHb4TKU+A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ljpMwYeGjRmbFIx3guRzjlXT7gaNfQwL9PSRN6KOu/wPkGBhKfsxh6nOsXc3Rivl92BQMo7Atwokze8+vUJQ7jDi4aA2klYQEdCXtKxbVHdREn/ZolfvB12aCtM8XrjwEWV2odrmgs0HdhgN3vPY3XNogrjmLBH5XlZ1TNdLgsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.126.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RlOF4BccdkE2XVkkm5F523QzBRZeA2h+sVsCMMXl7b/OQxFAUh/MpKREjmMqZmpuwg3J4eQD9tdjJ2bLLGrIgQc+tFU/QZaFDs0XRWfdTFDoUuX99CU5/m12oHeFTEe/J8G/qxJhzcUpEZXXKBgQyn3uyDsh78U8V+x1/s0C9/mYr9zfAje1rOzBt2dsi/4G4mci8RZVvaU3pflwtIhtPZ31CgT/UmkDPqp2WQWR1cfGZ/PN/RaGueAC2ZHwNjPr2asHs0F3VWGqZj7bzVENRUuEzSwUcW7l7TAuuEdCqQ24LIrC4oLI9CiymFKYS4QqUCxgk/abzwwhgkU+6hUUbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+vIfdixy2mEppP9s7tsnkQBX0I9FJCj8Kyo9jbPtlGE=;
 b=iTRV3cfW1zetKtVDzaiHIRZBz08VqXT7riCzbgBR8efLZAZDyQ+S92/nNVUHVr+ME7Z9S0018e1zamMCsfj3KKsfCO+knX/Ww3a0ITMKdcPPXZErgYLeuQpOrV4AtJgu9w4WW6iCgKVbPKShXD7vWtTEWRlJVqyaVlnYlJk0l3GjhykYbzfM9rG2ZtIGVqpBlTUU0CG3ftGkj2fKoe//mvcjiXwMRkMQ6kvLNlt79+AEdwI9dafL09mhXYGcrjedXJbCJZFSiHSp7o37+Z7FDZ07/MJorZwr/pcDDVwWMlTGtFDR2J3POzmP2DmDmcAjcODrdAFqLmuqj/F2aVicWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cixtech.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from PS2PR03CA0023.apcprd03.prod.outlook.com (2603:1096:300:5b::35)
 by SI2PR06MB4993.apcprd06.prod.outlook.com (2603:1096:4:1a0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 07:59:38 +0000
Received: from TY2PEPF0000AB8A.apcprd03.prod.outlook.com
 (2603:1096:300:5b:cafe::32) by PS2PR03CA0023.outlook.office365.com
 (2603:1096:300:5b::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.6 via Frontend Transport; Thu,
 13 Nov 2025 07:59:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB8A.mail.protection.outlook.com (10.167.253.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 07:59:37 +0000
Received: from localhost.localdomain (unknown [172.16.64.196])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 9061741C0141;
	Thu, 13 Nov 2025 15:59:35 +0800 (CST)
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
Subject: [PATCH v2 0/3] Add support for Cix Sky1 resets
Date: Thu, 13 Nov 2025 15:59:32 +0800
Message-ID: <20251113075935.774359-1-gary.yang@cixtech.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB8A:EE_|SI2PR06MB4993:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 04c77e1d-5aaf-4542-fe9c-08de228a974e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6Hn+HdJ7N4KrB406yzoeGCogvNh58Mj//ihtcnbFiNYYKCl/paz8WDwCO8Be?=
 =?us-ascii?Q?v+G5X3B1dgxS7EgYxhB8knZFRhpeCiVypZObuNt56fRxCeIxP6zRN/hnKmZK?=
 =?us-ascii?Q?+zN3jEjyAOsgTTQKEdbewXITIQ/LMs27QI9oAKeiu3GejM89V3zLLzl9NMfO?=
 =?us-ascii?Q?J7v1gyTK6UyW9VKgZc+YPuvEIn705Kf/CNR5DxgsEIcR/iYDpqba825S7faL?=
 =?us-ascii?Q?DIpTq7KeTt1KdRGgHOjLjSCg7yy297Hro+5c89jpmM55+FsZDvFWfvVo2ePW?=
 =?us-ascii?Q?7mcpaKe+7qPxTNQsFg2X5Z0yqY5Fjh27sNpugqI2FaS0Q/xuxbjIDY6lYjRH?=
 =?us-ascii?Q?VvoWlS517sKpd3OMaw64SBYbNTg28G7MpdE/X8B4xszRMyIEYfJZ41XhBU5q?=
 =?us-ascii?Q?HfROkaRUb6o6IJaoIgwW4enG3kCMr8J+8WFyD8Il00mEN3AdD1ABx3vjrIbp?=
 =?us-ascii?Q?RvPBw4iQOhAF1GmiQ1vCB9hlnbGm5POAwhLxc02aXh1jl4oqBCruZ3XKECMU?=
 =?us-ascii?Q?7E3W+spiMW8sotAWwAP1S4cC7iPeoWkN4/YAJnFIAMQD53HGzuTr4teb48tp?=
 =?us-ascii?Q?nTFPiHIKpow6of/NgE8E0pEeJlOv2h7Phmn6ZNY0zb83rUOy9uDq4e4C9juA?=
 =?us-ascii?Q?aZ2oAYP5/OVeo82bA0t5gWW9yxJVlhcc7WsxPoGjrfMf4LTL1j7s93N/zj1k?=
 =?us-ascii?Q?DD0uvJJzM9IM2fdHG4i2g1R0yzX+DOljzx3gjAcH+Fr6XLTk02+EVvz2ksge?=
 =?us-ascii?Q?FtoAckKWhWCX7M+Mw9ojmAQqc6QnqSrtmYCanvGAU6kyPYuwhc8B0gSkjdHQ?=
 =?us-ascii?Q?Nch2GhxiAEQ41zEJCFnwx5iZEEmBr7NllVGeaafsCegzsYtJ3Fg0COkuFnGl?=
 =?us-ascii?Q?L5l8IJpGv/OYGdRgmhNJs/y/hyLo/SyOnfQWlr3xm+3F0vbu06TP1REJehyh?=
 =?us-ascii?Q?YlRhJKSOxhAxzYuWYzOZ7gC92Ow6LlMExy98O8km5U6iq31NGqj78QOc72Pt?=
 =?us-ascii?Q?ygZX8ZDdpDVyJ9PKsocpzhZBINycwQimr7P8Ueswg08Nnjlgq5jqNYipRa4c?=
 =?us-ascii?Q?CBthYuAjTSOPGUHd2bNqX3q58XAcxg+u/i6xEdHExLkFRS61jEQzN/lx16Ym?=
 =?us-ascii?Q?yt3AjA3RU/RE6fuyloiGUxu3TvTY6Pic0sWV1VaU+5EDGsiX5HzLgzQop4AY?=
 =?us-ascii?Q?bECbqErDr4a7Dtf4cSEGm0+cffQ165q6/cUfGb64P0p4gMI8YrxFXM9XMl5G?=
 =?us-ascii?Q?eEjWA/Bc8Ok89+mR41gW4ZbWeXSlagyjFzDWsdm3PsGXOv8gF2ik1ndITzIZ?=
 =?us-ascii?Q?91eJl/xeTJjydJWvAllTqmqQYrgFmWgZe4Wv/2Ltki+Degg5On8j4pyrVJbt?=
 =?us-ascii?Q?ggaUMR+wgkN2z4YDf9EWMPtFDfS4HKFasVc0XuvOQKxfjBUbITJFC4kKiX4y?=
 =?us-ascii?Q?TqNlekDQydAJSuMDnNC4Td3udRXjyQmLZhVOc/w5nVfPZRi6xp1mkdRAtiPV?=
 =?us-ascii?Q?ETA2KBxNio+/gcOyPCyrFQy8B24qUemXnVW5qHiqFZDWcX3D+Hyoy7XwJ/4S?=
 =?us-ascii?Q?D17oPa8XPBdvxPX0/dY=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 07:59:37.0026
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04c77e1d-5aaf-4542-fe9c-08de228a974e
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	TY2PEPF0000AB8A.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4993

Patch 1: Add yaml file for Cix Sky1 resets
Patch 2: Add driver codes for Cix Sky1 resets
Patch 3: Add dts nodes for Cix Sky1 resets

v2 changes:
- Pass dts build check with below commands:
make O=$OUTKNL dt_binding_check
make O=$OUTKNL dt_binding_check DT_SCHEMA_FILES=cix,sky1-rst.yaml
scripts/checkpatch.pl 000*.patch
make O=$OUTKNL CHECK_DTBS=y W=1 cix/sky1-orion-o6.dtb
- fix dt-bindings style
- refine reset driver

Gary Yang (3):
  dt-bindings: reset: add sky1 reset controller
  reset: cix: add support for cix sky1 resets
  arm64: dts: cix: add support for cix sky1 resets

 .../bindings/reset/cix,sky1-rst.yaml          |  48 +++
 arch/arm64/boot/dts/cix/sky1.dtsi             |  12 +
 drivers/reset/Kconfig                         |   7 +
 drivers/reset/Makefile                        |   1 +
 drivers/reset/reset-sky1.c                    | 381 ++++++++++++++++++
 include/dt-bindings/reset/cix,sky1-rst-fch.h  |  42 ++
 include/dt-bindings/reset/cix,sky1-rst.h      | 164 ++++++++
 7 files changed, 655 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/cix,sky1-rst.yaml
 create mode 100644 drivers/reset/reset-sky1.c
 create mode 100644 include/dt-bindings/reset/cix,sky1-rst-fch.h
 create mode 100644 include/dt-bindings/reset/cix,sky1-rst.h

-- 
2.49.0


