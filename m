Return-Path: <linux-kernel+bounces-888642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7ABC3B790
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 14:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4664A502BDC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 13:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15E9226541;
	Thu,  6 Nov 2025 13:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IESVYPaq"
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazhn15010018.outbound.protection.outlook.com [52.102.128.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F314E3321B9;
	Thu,  6 Nov 2025 13:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.102.128.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762436858; cv=fail; b=FTgorfYoooRcEkoEkJ9qqZQ0Uhfb/nAKOZjXhuS4ZA6uBU3rAeon5rBCWa11G3ttLrpI5u/HKKQSQoA7WQepVCDL2gmbgBVtPDi0bVYVgzpPiwuWvtsn+e/4pde4TIjT+9UO4hOSluzV9i8uOeKGOSe4SKDM5omzvAXPWLUUrqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762436858; c=relaxed/simple;
	bh=edyKTNo6LdBH8aX0gpXwILlM7nEA+lvqqMqlvAHp4P0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mV9lvvJjjvRlA8Nnt4WieR6ECvytAyyQjmaoLM4Y2+/QvFfP/P4V66eqCvJhvQEq6W6ytZ1zvrGaBGBu3a6zz/vObwWmC19BQiHl1pHuaMJKiNvV0JBiN5KxlRD4Dhlq3czF1CQqB0YSKPQCYddVMNMue5bfFye/eWZtAZNDSKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=IESVYPaq; arc=fail smtp.client-ip=52.102.128.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nI9/g68Lx3Pehq5q12DpzIa6gmpb5uQea9UQrmEEtDoNhcwYGnNA1xX+/K65OSRjaRn+fQCOh0oXkDGN2jPNxxvq51cYH9WVSzwfB3wkHjtdtziXDKwVeQKMhsXt/Ox0EOvOA8jFStUL51f5GvduYUgLtXV7GL+rbwNjL8asCGavO+Y4h2Aj4Wug9tM29APSXJAxOXh91Pg22KzdSewcT+DoHZrshlxYNkekhy9GOuZJotaXcp6zkfrC7m3jBuz8VP/VZswZ4JNSX6roZG9ZqRjR4rIY2pGkb0YPfsSzVo9hOlwR+RW4Chf4UjgUc0xelAMQk/nbx0Qy9AACC1Q1wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wwlKsDXAyd4qlaamF8RAvN3x3zyji7/h09GYHZOJ980=;
 b=dP8RfvDPHIKIokSxXgKBZ16xvLHqMCYk/7iD33Pc54kItS0npAIMoUputdIiWNFLaQapD1OIaob0J3Tg92cv6N8tMaNYEjWs2vxwYpm5Eknqzz3uWisIkdZdRSaxWfC9Kiyd79I4FaEDAHiZ9ATOTxbg+EOzTDkul7smokJqEpVFi0QPhnFVl1xI+zomoONuEWBeCWvJfGEAOT6rvNG0cVKD+DAAstcQaO9rJ70waIljjBTm7+SF8UwyCx9JEQK0wuM1hbeKxh/19QV7SXKJcJLFB7VbI/d11OUoYp2Tb0uNnBZK2RxeMApjbYdSM0j595KyFZOHC3QOVrcSBBCN0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wwlKsDXAyd4qlaamF8RAvN3x3zyji7/h09GYHZOJ980=;
 b=IESVYPaqNqHAju4ewz0ToE9lyQJhfjpw95AqHCBseYKWRBEchnqHWXaV0/oeIPzch0gF7odJHO+B0K9X0RxQbwE3lzuj3tf9paLy4N/JdagM5F70Df50B4Pakz8YKTNML5371xuFG38ukQtowmQRNZX07w5dJtuhkr0Jxyx6uN4=
Received: from CH5P222CA0004.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::8)
 by DS0PR10MB6872.namprd10.prod.outlook.com (2603:10b6:8:131::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Thu, 6 Nov
 2025 13:47:34 +0000
Received: from CH2PEPF0000009B.namprd02.prod.outlook.com
 (2603:10b6:610:1ee:cafe::60) by CH5P222CA0004.outlook.office365.com
 (2603:10b6:610:1ee::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.12 via Frontend Transport; Thu,
 6 Nov 2025 13:47:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CH2PEPF0000009B.mail.protection.outlook.com (10.167.244.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 6 Nov 2025 13:47:33 +0000
Received: from DFLE215.ent.ti.com (10.64.6.73) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 07:47:29 -0600
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 07:47:29 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 6 Nov 2025 07:47:29 -0600
Received: from a0512632.dhcp.ti.com (a0512632.dhcp.ti.com [172.24.233.20])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A6DkqDc1301720;
	Thu, 6 Nov 2025 07:47:23 -0600
From: Swamil Jain <s-jain1@ti.com>
To: <jyri.sarha@iki.fi>, <tomi.valkeinen@ideasonboard.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>, <nm@ti.com>,
	<vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <lee@kernel.org>,
	<louis.chauvet@bootlin.com>, <aradhya.bhatia@linux.dev>
CC: <devarsht@ti.com>, <praneeth@ti.com>, <h-shenoy@ti.com>,
	<dri-devel@lists.freedesktop.org>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 5/5] drm/tidss: Fix sampling edge configuration
Date: Thu, 6 Nov 2025 19:16:52 +0530
Message-ID: <20251106134652.883148-6-s-jain1@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251106134652.883148-1-s-jain1@ti.com>
References: <20251106134652.883148-1-s-jain1@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009B:EE_|DS0PR10MB6872:EE_
X-MS-Office365-Filtering-Correlation-Id: 81430622-eb84-4c26-0451-08de1d3b0979
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|34020700016|1800799024|376014|82310400026|921020|12100799066;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j/weblWjRoAT7rTtS8dkb1XYoK5qab4WjCYrXMfoefRvIZ0yEVs2k28XXGlb?=
 =?us-ascii?Q?yd4RsIwaYZYfq7LDm64r0TXwpznxjpYs9umyEYZm1gKOvMWaDr8HDuFAtZPS?=
 =?us-ascii?Q?xYdJHH1kL3a614Sy7fFoJfEQrv0NrEuzklVRX3HMtb7KGViQBWgGw2zx44Lz?=
 =?us-ascii?Q?jIUNLCvG77d8ExbJUtuWwEcF1W2YzAyKMZHYnexZt87XAUo7NPA956ptMWQ5?=
 =?us-ascii?Q?mVDpNR+6kOjnc1uYl+36FT2S+stwSNBXH9HPKYySgqDtTb2eac6OH4SgSpGu?=
 =?us-ascii?Q?i9AV2JcCsF3M/xUwJaO4bLFzCydNsYdVxkYtlKdNo0OQlBKhg8byTITF/Z1h?=
 =?us-ascii?Q?h0AMd5tDVIIAjELS0jm4BKB8SPEAEPvknODx2oeEDDq0CInYuzXfF4m6V9dW?=
 =?us-ascii?Q?va3TdQDIwfvetNv5OA9i+sLSMfLsc238enX4DiUlfCdJWqLS188Jla3tBGpL?=
 =?us-ascii?Q?DOEaXFdGosQrnA3biVY82uCPlixGY4rELzA9qnFz45PRSxjcpkopwrt18EDf?=
 =?us-ascii?Q?LPt0T9Q3fijBB6mhU1G3q0vSQ/UKlhubJNKUzYrY2qeXT3da1YbWyO1iha9c?=
 =?us-ascii?Q?6yzlSrtnxo5uOGUVeNY4ZlfwX4iFpZcqE8RwbhseqzsEC804l+Zk04MnQThT?=
 =?us-ascii?Q?3ew18Gb2rFcclsx1pNFv0HsobU3LFGyaRjTEMP6qiCSYJsp3bMlg95wSWjxP?=
 =?us-ascii?Q?1Qo86zSl9LfhL2h2B9FVSbiapjfJDIZzlkjSBYuwGUhZZxCXD2q7Yn/OfOP+?=
 =?us-ascii?Q?XnP2JqHxIwUR8I1q5tnK1D5Jrmhw5ops/JYI2fDhLVIiHfk70xjnS3RZCEeP?=
 =?us-ascii?Q?rMPGASEyBN+CvpG7dgoe3EFgiVNps8w+LxRr6cW0x9vjfdmmEtQwNHZMHTPo?=
 =?us-ascii?Q?a0Obh/7DCFb7tNMLsYXese4VDB3Q9UdCxDoUxPcJ9JLsbU+IgIy/Wk62dvFh?=
 =?us-ascii?Q?OfFQPul5XEf+dBj7euTSh/PuepQqlXB1B4G/xSzhxwskRFMsq+wFYuaEIcUi?=
 =?us-ascii?Q?/LpirS6fdw+eXM/j49vWHVKaFTXKJSNmynyxeWJQ0ugCk8WJqTd2vuAz81ZE?=
 =?us-ascii?Q?SGu3uzXOGbMrFJvp8ZgdbPeHzYi0Wd7WofuPIrpk9OdnFPC42GA0ZshsN8Qa?=
 =?us-ascii?Q?2berh9dBzRaXhDFeRP4HqTwOBpltFsbCo5jddalEChzKyRRZlh6OSgX3jQNB?=
 =?us-ascii?Q?agBIZXiAjRZkB77/j7Xh8GYG5Gi/ImcRc74HGGwurM7P7rrc9rYjYoW8MS2i?=
 =?us-ascii?Q?k15AmRWusB+xeO6fgH/fiHvQ6tANM0KCu3QYQ80FXFLOED3ZPIfhbnInip+y?=
 =?us-ascii?Q?wM5NsK2JBX4S/uSIx1LToY9NYLgf8s3+P/9ur29jz2lSalfjdERMcuBUCXHT?=
 =?us-ascii?Q?kVGZsKAchebmz1hsDTV8wuY8m+O8tgiVLYAUU3jNShsJP2mT5XfqPEbpxkgW?=
 =?us-ascii?Q?abaGJk51Vjr5bYl9cCK9GFNgX205ZN8dz0jIdHlIkhxmnLeexRXBlC6ZAyL9?=
 =?us-ascii?Q?FBg1TtFhvJnQH3GoZYcjElm1kdy02Pc7n0xKlQ782+Sm/HSPoNkbRPuvsj4f?=
 =?us-ascii?Q?MgUyg/paS0hYZzAdfFJ2OL7kmUHE9CL/mSn0/uBB?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(34020700016)(1800799024)(376014)(82310400026)(921020)(12100799066);DIR:OUT;SFP:1501;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 13:47:33.1349
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81430622-eb84-4c26-0451-08de1d3b0979
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6872

From: Louis Chauvet <louis.chauvet@bootlin.com>

As stated in the AM62x Technical Reference Manual (SPRUIV7B)[1], the data
sampling edge needs to be configured in two distinct registers: one in the
TIDSS IP and another in the memory-mapped control register modules. Since
the latter is not within the same address range, a phandle to a syscon
device is used to access the regmap.

Configure the CTRL_MMR register, as mentioned in the Technical Reference
Manual to fix sampling edge.

[1]: https://www.ti.com/lit/ug/spruiv7b/spruiv7b.pdf

Fixes: ad2ac9dc9426 ("drm/tidss: Add support for AM625 DSS")
Fixes: 5cc5ea7b6d7b ("drm/tidss: Add support for AM62A7 DSS")
Cc: stable@vger.kernel.org
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Swamil Jain <s-jain1@ti.com>
---
 drivers/gpu/drm/tidss/tidss_dispc.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
index d8e1a1bcd660..d09eecb72dc0 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -500,6 +500,7 @@ struct dispc_device {
 	const struct dispc_features *feat;
 
 	struct clk *fclk;
+	struct regmap *clk_ctrl;
 
 	bool is_enabled;
 
@@ -1234,6 +1235,11 @@ void dispc_vp_prepare(struct dispc_device *dispc, u32 hw_videoport,
 				  mode->crtc_hdisplay - 1) |
 		       FIELD_PREP(DISPC_VP_SIZE_SCREEN_VDISPLAY_MASK,
 				  mode->crtc_vdisplay - 1));
+
+	if (dispc->clk_ctrl) {
+		regmap_update_bits(dispc->clk_ctrl, 0, 0x100, ipc ? 0x100 : 0x000);
+		regmap_update_bits(dispc->clk_ctrl, 0, 0x200, rf ? 0x200 : 0x000);
+	}
 }
 
 void dispc_vp_enable(struct dispc_device *dispc, u32 hw_videoport)
@@ -3003,6 +3009,14 @@ int dispc_init(struct tidss_device *tidss)
 
 	dispc_init_errata(dispc);
 
+	dispc->clk_ctrl = syscon_regmap_lookup_by_phandle_optional(tidss->dev->of_node,
+								   "ti,clk-ctrl");
+	if (IS_ERR(dispc->clk_ctrl)) {
+		r = dev_err_probe(dispc->dev, PTR_ERR(dispc->clk_ctrl),
+				  "DISPC: syscon_regmap_lookup_by_phandle failed.\n");
+		return r;
+	}
+
 	dispc->fourccs = devm_kcalloc(dev, ARRAY_SIZE(dispc_color_formats),
 				      sizeof(*dispc->fourccs), GFP_KERNEL);
 	if (!dispc->fourccs)

