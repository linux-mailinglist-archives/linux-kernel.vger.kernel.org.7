Return-Path: <linux-kernel+bounces-802483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 047A2B452BD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C45F45C0009
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEED3112C7;
	Fri,  5 Sep 2025 09:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LCCV0YbE"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2049.outbound.protection.outlook.com [40.107.95.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35F6310762;
	Fri,  5 Sep 2025 09:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757063431; cv=fail; b=WXh3JQqyXFCTkO0ZLlY4Zr3QsgbPZ+eTO1R8RC2/Unr4BfAjKdEf/WWmoLXvpPnC5tNXIkex++yd31E7SF8L6DlcsRwOUQ4Z5pVK5qz+YFLbFLmnNqEpaEDggDmqU74TwgIJ+Zn1FUlAd7EkJWXdosbnuIljgGOVMxA5mMihLQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757063431; c=relaxed/simple;
	bh=N86CgzFGUICeut7z1xZoOwNUY/iYwLPGmZpFmqs78WY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nnqvXLUCfRyjkma0EkxjLDOeqeTXyfK7PwjE50vQv/37/Jf539MmSdw01eQBSbFRTJYgTvTFZT5IF7opHChBQRVAivWmcXQAIl8bSMIqBlY5BukKFzUaDFywuNMOp9DHnmSbu2+kR45K1t+82fpK0TdqWWXcYEmj1h+u5M2xiAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LCCV0YbE; arc=fail smtp.client-ip=40.107.95.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=USc+hw9iwFdPAUIQpGC8qlcAwPP61cZMErgvbr8T5AtcBY2fqcaB/EfmmSAZrGCNtiQL3z/IRlQdhpCWDoupWO8Jd8u7xua5eTCgxbopF8sJ/nGb9M40spR6lsla24iBGH1zeRoDPtbXHsfdP5NrnaUFqF/yFWj2dKB4w6mwRrBLvw5Jk1I3e9QLIuK0DcUaUh4SbvV1D0lx6R+8o296Eqbk/S6w8tR5bYkrK9c/cwrHzWyKNOCyifb2y2TCb8Dpqh3auTuAJJVOhw9cK2fPHQNceAyKsqA873G0+uu9Lt66AT1ANsr+xKs8H+ft1rU5+muQr9/h3EDXug4sZvXAmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rr6avTZaJi4XNZNb8+vSs9XWMD22+YdNNTfK6OlUp7w=;
 b=Eq/DMbqYDDfJeeokDtAPae/PYGA3A3pqx6LyvKTUmhERvJMplrcDC6JBBJER4Yxbl5arvxhlNsM0hTnQapDisndRacJA7jgq0yRZAbLKZJ1ugclFD1zeGUgEmxjvYGcstObchDX47OwhLsqw7X5LGB5XCftEbplMEoIQ/AhYl7PImiyk4KvtM8SPgC5CqsvAnWkruXbqh1H//2gbSTYISqI0dJLUjx7qdxbg029fX5i8Npsh76ri6mpLxcyyE//w35xNxsw81h1Vi6wROWM4wri0BVHUhZqMv/SCUlo4qwR8SY7hn+157n7N7rdBm5VDTiEOeCMig2caKfKBbZ+CAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rr6avTZaJi4XNZNb8+vSs9XWMD22+YdNNTfK6OlUp7w=;
 b=LCCV0YbEQF4s6mZ5tUMjEzW1lk5f9DMCsmPNGpOwK7JyQTtZ1SPCWltRJ6UbC4ulAE6gallBb03+/AbJ3hwWpD6Vegk5gilPWMqkgcnUcF1EYFRrOQflNPn0XG0gFVWU+mKmeTxzhMrMoneQzZUTpmHg3HWOxmImXEE/FF6/hQo=
Received: from BL0PR0102CA0059.prod.exchangelabs.com (2603:10b6:208:25::36) by
 SA1PR12MB6995.namprd12.prod.outlook.com (2603:10b6:806:24e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Fri, 5 Sep
 2025 09:10:25 +0000
Received: from BL6PEPF0002256F.namprd02.prod.outlook.com
 (2603:10b6:208:25:cafe::b7) by BL0PR0102CA0059.outlook.office365.com
 (2603:10b6:208:25::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.18 via Frontend Transport; Fri,
 5 Sep 2025 09:11:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0002256F.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Fri, 5 Sep 2025 09:10:25 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 5 Sep
 2025 04:10:06 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Fri, 5 Sep
 2025 02:10:05 -0700
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 5 Sep 2025 04:10:03 -0500
From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To: <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <git@amd.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
	<sboyd@kernel.org>, Michal Simek <michal.simek@amd.com>, Shubhrajyoti Datta
	<shubhrajyoti.datta@amd.com>
Subject: [PATCH] clk: clocking-wizard: Fix output clock register offset for Versal platforms
Date: Fri, 5 Sep 2025 14:40:02 +0530
Message-ID: <20250905091002.28203-1-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256F:EE_|SA1PR12MB6995:EE_
X-MS-Office365-Filtering-Correlation-Id: ba96f505-bc65-407a-1a99-08ddec5c0ce3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4rGQhUNefH9UnL5rETDfHsH/BIEPyXAKtWza9xtD0SFwYxu36lbS045gSPSG?=
 =?us-ascii?Q?Bp3YMQBWwbvwQrGb2FSiH2TNniLG+FjDID4xb/Fd8McJ6QKEUl9ei9Li+Cqx?=
 =?us-ascii?Q?JaFzGcxDLuATfp8rISW7BlxIPNvajR3ctNtfA5r+N3zLFZ+/bcVsCoWiO0zW?=
 =?us-ascii?Q?cfWp7Yadcx/PLiD1lIjdTv06L3g693ibn/Rxg+QznJE/YDPz/CHn/VaQcsI9?=
 =?us-ascii?Q?CArcFsvLmvZITJkoDL4pCSIz9UXiado4LlAQ9FlmKafUj2v543Z55Etu96Ep?=
 =?us-ascii?Q?R3FA/eqboeLAu1uhabIj0eA42f5eAAZo9suK9fK7cqylzBgbSN9CcDXr8+EE?=
 =?us-ascii?Q?+CzyXnsBa2ZbmipP2d00xC8K6NCaMJ8v99eRY6juQjGZuxhT3QWADyuSMlwl?=
 =?us-ascii?Q?HL+vLPaiVYsIixyj/6JdY4OGp99y0ZAoWUW9WVkPmXkWYFRHW/IHi3HhYc8h?=
 =?us-ascii?Q?/r+DAFkPRW4jTRXfM7FKaKLSem82vJc0Vl3yMgM3i63dZZnVjmSqzZ1iuukM?=
 =?us-ascii?Q?V8Pnp/CO2TrucTxhIBqyyru9ICA25eruvdvz3lsz7ePxlWl0NDHsiji4U/69?=
 =?us-ascii?Q?+2e2mkDUDZoElj9oiU4pbQvMF+r/hDrELrbiQvcbnnL31GWnOKueoh2rWa5b?=
 =?us-ascii?Q?qd7gREgcwSPnMZnv/9PuNH3deAwEhxRMxZ0jcFjQrUPo+7RhSd71DQpekumD?=
 =?us-ascii?Q?V1ezP7M+PT5S+/599fb7XBa2iD1txEwA2UBnBbBU4gGvZ8hGmgL4Ysf8wk+b?=
 =?us-ascii?Q?eO+Q7ObDh4Zej2skW+3tEIecZjAJMfRg1SUn5cjs5KN83aSVv/5WKtfK7In2?=
 =?us-ascii?Q?S+5sBZ0FEjNA1BwsNXjkARnEl8uex4azx9+2rnz2Y11EJfC9KJeC2vh36DFO?=
 =?us-ascii?Q?9QqWSCZXIT4V0Q22DlLBmYdH7fz0o9vwcCgNvHciZziGuIDjbbF/S41XolDB?=
 =?us-ascii?Q?1jjOsR7G65QJQ84Sda/QZwZth3vvNNt8VYl65ubYamBAH6R8xMqMltt1X6Dq?=
 =?us-ascii?Q?VOoxXYPE4d1Y/rM6Q1t5N5Mb3JkW26pazAHXJFP277pgDMR/uen4snN2agJj?=
 =?us-ascii?Q?YEE1RvXFvO8GKfgm4no1u4jCyu6+XVLaAkChbmq+4WiXJ9MPgqELxAgOUd87?=
 =?us-ascii?Q?rGadagmrhjA42rwHxwN3WbhRJQHopp2aT0Arq0kzRMm+jtBXgEy6Adnzqe/u?=
 =?us-ascii?Q?wOLS4QLRAKoXpHHGb32PUSldDZ/ZPTVJb6IHiTzHpybexcy/GjLOXSyV/5us?=
 =?us-ascii?Q?iN2qIKoOnxFiJV6lHX8wgsoXXtJF7BTmjMQOKBz4NTM4jvlsbp376ICtI/sx?=
 =?us-ascii?Q?rwncV+g37pHshuELr6XWO5NvAXZ1MjYWQaIz5OHHS/wvRLsrxlSO+V20beAA?=
 =?us-ascii?Q?bSgjJ0Q7ncq9sjpCxT+gbL+IyZHXLMk4i36pl3XF02Cn14bHOOEmw6rGeNfN?=
 =?us-ascii?Q?L2mUNPchKRqLANkIy3zyeposk7E/9n6+PqHWALKG1vTKPWF1dctJ48YOJR+A?=
 =?us-ascii?Q?4FN7Gy/bJozp046cGr5OungsN79XV2mqv2Wo?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 09:10:25.3400
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba96f505-bc65-407a-1a99-08ddec5c0ce3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0002256F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6995

The output clock register offset used in clk_wzrd_register_output_clocks
was incorrectly referencing 0x3C instead of 0x38, which caused
misconfiguration of output dividers on Versal platforms.

Correcting the off-by-one error ensures proper configuration of output
clocks.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
---

 drivers/clk/xilinx/clk-xlnx-clock-wizard.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/xilinx/clk-xlnx-clock-wizard.c b/drivers/clk/xilinx/clk-xlnx-clock-wizard.c
index 8abf12f88eb2..4f8ed6d1e5fd 100644
--- a/drivers/clk/xilinx/clk-xlnx-clock-wizard.c
+++ b/drivers/clk/xilinx/clk-xlnx-clock-wizard.c
@@ -1138,7 +1138,7 @@ static int clk_wzrd_register_output_clocks(struct device *dev, int nr_outputs)
 						(dev,
 						 clkout_name, clk_name, 0,
 						 clk_wzrd->base,
-						 (WZRD_CLK_CFG_REG(is_versal, 3) + i * 8),
+						 (WZRD_CLK_CFG_REG(is_versal, 2) + i * 8),
 						 WZRD_CLKOUT_DIVIDE_SHIFT,
 						 WZRD_CLKOUT_DIVIDE_WIDTH,
 						 CLK_DIVIDER_ONE_BASED |
-- 
2.17.1


