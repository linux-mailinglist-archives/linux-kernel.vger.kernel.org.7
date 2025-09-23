Return-Path: <linux-kernel+bounces-829583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A3EB97640
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 21:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D8B3322253
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 19:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5869630596B;
	Tue, 23 Sep 2025 19:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FfZRil3a"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013067.outbound.protection.outlook.com [52.101.83.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC0F2FF658
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 19:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758656727; cv=fail; b=tESeaVjn248nttoRhJVzQGWWhgxHs8lpa8VPv94zfkLDOkA6recJdb1MngBKdTYE96rUTo71RPSN0F+67ZIHP0BJgKwFmkm4Sb7yNtM++tciC6pi5Nwz8ybyBYcSojQgpH567M7s8hDCZdzN5/z3sS/ghA51UgDoYihb4lJQVA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758656727; c=relaxed/simple;
	bh=IaXsgxwV/gQqC30NXXopkVnWEjsTurhExYlx53xx7Ec=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d69fR0tvwf5uAj3GLQG+iSbxINUfQBvsj21DQdKijWTS8Y/1U40wu3IoLxXagTndCARVgphbM+/9nR+rbBLYeKlb1z160p0bgWfscGZpjPW2PKOX1u5QgIbRLG/GIzm/X0Y5CdAsv2xGOnU89vvyMVMQqFuGCcWbY0tm7gtrt8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FfZRil3a; arc=fail smtp.client-ip=52.101.83.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QsVBbbtE3sJceCXBppSNzde8gol40kGER7UvGnn/mEry8sT7ft6imhocH2i009diyUccmeTAAW/HePGrNtOx2NBRtSEVSAdw2hDIm5F4xpXADUTOlW8TL0KAt70AdqGTI2KJ98Cm7kcElD3KI7dqlVubCH0jTC3HR6EqeIo/Vh56kfJ1CnizpisDuK4NcUqgfRrZer/VK1XpFUOY6f9z4zx7NWOy95T1J4Fmf62dV1stuesWRpiCcjWhj1EJVuN1xuuljHzof4qUWGKg7yjjoQZOeS4HpwNPPE1sfBgzulSR4v+eGT3sfT2C/ijWZzvj/V34RAOEeBY5l9v9noS+sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cnhT1H1Bk1LHSdq1BvsVd/43N0zMKc3Phsm9aZmWrOA=;
 b=wwgS9ADF8blWMrAkA1bcGDPMniDijz9UWmdRDJV4j4LXiJdyDbchpbdc0YDYQKK0Z6Mv/Rq/7W0MZMqTKM9PVL8jq03TLey5rMAAh+Iu2iEnibNmnQMSFATBK3dNzoNuTJmRgFnbxjZIf0NvlZ+EhW4t6HeE0x1zwyv039p/5VFRUwXYpgX7c0ACSsL+9uoVZiPTAoM0L5gRoNNS+7VRHcDTWL7yjb2tmTlr3ryw2XzjcTm2JsC7YF4d7/qrSf4kOjXxIWlH8/dn24xevY7Y3Wg34tyHoOI+9Vc2PQR2KpR3Cr8Dk5iDTKXPNocTqP15ODKW9WxiUsRHnhd37iALcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cnhT1H1Bk1LHSdq1BvsVd/43N0zMKc3Phsm9aZmWrOA=;
 b=FfZRil3ajHvGFSqt+4pQ5JrQngv5rEQF51lhvLy/ODDxrx27Zg9j/bX606hEU/yt8sNH+oHYrRT6g2idcGjplQjH3/WTErsqgkTRhDGAujW9b5pu/SJpjXcElpikFTjnKe0uDfKywJ12orb0AtsUA+5bz3RGLeqnPa7eostFqIJW3Ba+x48sXKUkLAqIO9kl0gvMHsuYBHuSlr7x6+UYPkgKE8hKw0UgB9dcv/APKowPTKegi7NhcZdVuNIMeE+QtCkHiuBRaHgwe7mhev7PCCO/PVb8CCS7KbCT2LkzCZ/q4f0eOV2XGRUStIT2yri4xgrlb698aK1Y1Emr792slg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DBAPR04MB7352.eurprd04.prod.outlook.com (2603:10a6:10:1a8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.8; Tue, 23 Sep
 2025 19:45:15 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 19:45:15 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Josua Mayer <josua@solid-run.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 phy 07/16] phy: lynx-28g: refactor lane->interface to lane->mode
Date: Tue, 23 Sep 2025 22:44:36 +0300
Message-Id: <20250923194445.454442-8-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250923194445.454442-1-vladimir.oltean@nxp.com>
References: <20250923194445.454442-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P189CA0028.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::33) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DBAPR04MB7352:EE_
X-MS-Office365-Filtering-Correlation-Id: 01de8e6a-ae6d-413b-59b4-08ddfad9b655
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xylL9gPk7wHaLcvP00CNRMQV4mKcT/nzy5w9xSuApanMXk7akp/CBrX7tssV?=
 =?us-ascii?Q?3Scb4EciKHUk+8Cr5q1Ajb50RGB8SfYcqJOr1gTKk5zC9mS5crBFY2nqZGjW?=
 =?us-ascii?Q?lMTZlABGcMeXsVGwLYoYzHmL4ZIPf89JjuDxAMOtbdXvc1FN3+Z3rj9twT9l?=
 =?us-ascii?Q?cHKbaAbY2vWFjIFQ0MBm3nnkw6rQ9Gm8CX/295QDlvmu8apWCB4g/PZRT12E?=
 =?us-ascii?Q?7MsLWzOPsDdN3Ca4sJ0eyNY8s/5pP21N4KXNJUxlNxoMP4glRaTN6iVZhcbK?=
 =?us-ascii?Q?GpznPwCoDRkFpc2XIiPqly2MMc54new/tY8SEE0xuMyKSLl1sg7/U6FeMA0+?=
 =?us-ascii?Q?y+ZHmuUGTkvyzZvHFGGEmi+APt9Lid5btkxQe0Ggqr/Gh0kTw0+xhm3GOghx?=
 =?us-ascii?Q?AchS82v+7ueKZ7pD7v6EENbEpJYXFx5Qx1QkM5MjagAasveVfFVxYxml2dhi?=
 =?us-ascii?Q?vEm9Z5Zpt1xHevUfaIal2MkGNjGRB0RA/eOhNDxeGLa+LMdUAsRe+9bS12Oj?=
 =?us-ascii?Q?H7xH3F1oV45wW8du+86AMHwosKVTvfXDiY2Ji6oPmVatMRgBbSNpSPugZX3i?=
 =?us-ascii?Q?lY8aOsLBv2s904vHOmbO3wG9qUyqX+BSjUXzyotn0DafmD10fRHTKDbrhHQ2?=
 =?us-ascii?Q?JmF5iEs3+I+qpXX8OyujIU8iY9mSfD41+3WPhseAD2goCtUhRz2zEWBL5+r3?=
 =?us-ascii?Q?uOiRX+0Mgt6K4Ee1d0vYCDhYXZeu38typU08B/7O/bytVaIV29TgUqLCbLwf?=
 =?us-ascii?Q?wo/tKK+onmO3NOfbLtCS2sn5S1gw3JJd9DwbsgntHfDJwmlHC3yEY8Vtohzi?=
 =?us-ascii?Q?v9lUofqQ2Z/YU3L4b67k8o0okoBnLRZrKscdQ2TxR+wud9kEvOWTMIuTV2oL?=
 =?us-ascii?Q?Zp27mk3cd4rRptCUua18oA547ktRSr//zHvqqh4gu8X5iOhfKU3NGds4YNJB?=
 =?us-ascii?Q?LXb0c8Ue5bGPLKQa0qRCeFzb2dVuERBuZ2POAGjyH9pGYMCTq1qWN0c9we3o?=
 =?us-ascii?Q?z8kwkCEMTkZkZgtG2PpzFRd/tCzvkP4sN/B/+Lqm83XzdXcqOwwN5qEPoPzT?=
 =?us-ascii?Q?UHV4Lyu4oxuH4ujuwbusJhuqRjIBkpSQUQbIreRu9hsiXKg+Lw/kVMc61I85?=
 =?us-ascii?Q?4w/NzRX6Xf9ejgFyqmji+qsSgETh439iHf3I4Uf9fETlbnn/4OCaUsvKUBNn?=
 =?us-ascii?Q?6+w0RKykV97N+I2zWr6uO47NV1ThU2pMREEz7JsV0c2M89DHcL7b6+kUJWFw?=
 =?us-ascii?Q?pQU7JjRcXArEsI+vl/juGF479//C7n8bG/gZM9wWsHKtUdFLKIbGkUUzTGBA?=
 =?us-ascii?Q?2dyR4fAYTfKimsb4hr3ZZxh43oowdYJhoqZh5rtUJqXylarb6kuJdqGW1KLP?=
 =?us-ascii?Q?b72XsUeg1HxcNNSbG1lzGg0Zqv/wCmccIn+VJFpyIuYEtcjMh5dNEWJ5MIXW?=
 =?us-ascii?Q?hjMmTDjPY1fRT2k4k0M1o6843s/PGLBZWorjTPNQFLhIVJBpFBFbJA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2Wjt/5Z70Jl+mc5ik2CRd7tJA5fmxLLgxj3640Gasq2Ktda+mkDd4eW47ecK?=
 =?us-ascii?Q?NgGmuyVkNRGnDLf/UgJeCasK5RAU/8jq8w+r1js7wOL+l4DcEYeT/bb/YjEp?=
 =?us-ascii?Q?7wpzykSPbdSnGoG542QEeuxQKsHv/avoFjs80Yl8pqounazq9/kk3sKq/JIm?=
 =?us-ascii?Q?bcuu5fPKUqtFs5wqhBv+uWiN8CElZSCoxw4KFnH8ufvtdb3P7uPUPJQspDEA?=
 =?us-ascii?Q?t4cYfi4VM5BS6sjedLtHOPOhSk45cht/2M9CS7psdkrs9e2e6+Cr9Fwl5lmp?=
 =?us-ascii?Q?yVtmiXONj11MvxlXnOyf9rZiWxl1oTpGWOOxVoagvzal9Mz0fhXiY7o2P9vu?=
 =?us-ascii?Q?Pxle6LCnsDqZKo53D2ppHJ6vVhBhdT1+kNzPW3V8pA2UMkpbEcDAF99bPAXY?=
 =?us-ascii?Q?e3I+wqJH8+3VJZ3xa5d8FarZdjCQEoc6vKE/tXwVvTpG8SJAszn9NztKhIYf?=
 =?us-ascii?Q?AbBA6jMwzwjX5ICoyGKZsa/L5uzWXv5yavkzykBknMdrEND6+pLHm7amnQvU?=
 =?us-ascii?Q?XqiKs7JSFA0Rza9ZyPqQLdVlgQJlGRHJLS+eeZHPMIsVXX7IZgEdsTNa4e/H?=
 =?us-ascii?Q?AEv0TDcpU5JUwONIJF3kXjNCtn6PWa0PSQrjjCCW9lnZCyQhyzQOCG0StA/h?=
 =?us-ascii?Q?EZCG4JCydMBB8fLOG9x/wqB6BoqXE//OLQSny0razYxpEBoDYsDSqKyjfv1s?=
 =?us-ascii?Q?VLwTW/dN+UR8p/o/9841/JTyvG5yW3dgOnZiBZo7+R6T8kmQvmApMQpWLx2z?=
 =?us-ascii?Q?nvsx9UMIlTSkPui9+2xcG8PlXSAZgEZBR+Ds+f77LQivh68yZ7PN+X1rPzzx?=
 =?us-ascii?Q?t/v2noYczTWFRrba8p+uAy3/2meSbEERYi3z6nuMJ8N6P0JDQSdSknBjiHep?=
 =?us-ascii?Q?YMcRXryCDPaHwwjdwJL+obNbW0YrNiFUXq0lYpvAlwoGfgLdhZBtrUFv9GJP?=
 =?us-ascii?Q?ZscklMpkQhTBJYkTKVrDGyEGVaufYULkGpdYpk50D4mi/ud84eny32cZcDcs?=
 =?us-ascii?Q?vWCaN+9rR97c0FR0E0hAc3uc3AlcEusNSkGLydqZummTd3nvcKYFgZTLZIGy?=
 =?us-ascii?Q?gcpnbQf/DUrj6htRNfsMfGmVc5X4YFQUEQ0i6Xz+fX9MNJZLYxrpQMjo0WUd?=
 =?us-ascii?Q?yhzTpe4h4EOAOv19oOIfkmHJ38OJgGJpk2VenR2cIlcwJcE7sm2E7z2oWrWk?=
 =?us-ascii?Q?xwdoVP/uo5SF96eJMuxFt90tzU928xG/09mNjQ3DOfk8cGvKX31FLlarUJMm?=
 =?us-ascii?Q?I0ZAaICXG8XLqaKunwanji/UqM+doWJUrM9+p7EZdG3My0gBBqFagU9JfKA9?=
 =?us-ascii?Q?AkXLxFo/N/tIHYBVadzY/IsIDTMEouIvYmxTnpxp5DHu/x/7GLKPfh1y/K+B?=
 =?us-ascii?Q?xCB1H68QiBFmmOPyETlQ2+Ru+pBnZURhHbaR0NkBq9sP3wWpyQhibh2rkiaB?=
 =?us-ascii?Q?tcd6mojO1/cUgCQQ9n6xQtOTNS5D+zdR7jj3u0huQqd07DUoVZduZ6Q+N5Lf?=
 =?us-ascii?Q?u8HsPhB+WckkskKUDvrO9PplBA1PCYaC90xurTIR3/jzipLyryV7bmquRfcf?=
 =?us-ascii?Q?COyiiIdAXtbAml2tR+DTkIjqm8+lfOLvi7ob1VMIytgO0U66ZnKlmS/Fdf0c?=
 =?us-ascii?Q?8w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01de8e6a-ae6d-413b-59b4-08ddfad9b655
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 19:45:13.2225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iXIzsEm1Ok7roXCLn2coQkqfs55/JsjBjmEnB/bH2LsPovezzu7egK2xBkNYTKKq1F0cmKFJzWHiy+e/d7FB1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7352

Lynx 28G is a multi-protocol SerDes - it handles serial Ethernet, PCIe,
SATA.

The driver should not use the phylib-specific phy_interface_t as an
internal data representation, but something specific to its internal
capabilities, and only convert to phy_interface_t when PHY_MODE_ETHERNET
is selected and used.

Otherwise it has no way of representing the non-Ethernet lanes (which
was not a short-term goal when the driver was introduced, and is not a
goal per se right now either, but should nonetheless be possible).

Prefer the "enum lynx_lane_mode" name over "lynx_28g_lane_mode", in
preparation of future Lynx 10G SerDes support. This SerDes is part of
the same IP family and has similar capabilities, and will reuse some
code, hence the common data type.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2: none

 drivers/phy/freescale/phy-fsl-lynx-28g.c | 202 ++++++++++++-----------
 1 file changed, 103 insertions(+), 99 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-lynx-28g.c b/drivers/phy/freescale/phy-fsl-lynx-28g.c
index 65eb00938b72..083c287c54c5 100644
--- a/drivers/phy/freescale/phy-fsl-lynx-28g.c
+++ b/drivers/phy/freescale/phy-fsl-lynx-28g.c
@@ -243,6 +243,13 @@ enum lynx_28g_proto_sel {
 	PROTO_SEL_25G_50G_100G = 0x1a,
 };
 
+enum lynx_lane_mode {
+	LANE_MODE_UNKNOWN,
+	LANE_MODE_1000BASEX_SGMII,
+	LANE_MODE_10GBASER_USXGMII,
+	LANE_MODE_MAX,
+};
+
 struct lynx_28g_proto_conf {
 	/* LNaGCR0 */
 	int proto_sel;
@@ -280,36 +287,8 @@ struct lynx_28g_proto_conf {
 	int smp_autoz_eg1r;
 };
 
-static const struct lynx_28g_proto_conf lynx_28g_proto_conf[PHY_INTERFACE_MODE_MAX] = {
-	[PHY_INTERFACE_MODE_SGMII] = {
-		.proto_sel = LNaGCR0_PROTO_SEL_SGMII,
-		.if_width = LNaGCR0_IF_WIDTH_10_BIT,
-		.teq_type = EQ_TYPE_NO_EQ,
-		.sgn_preq = 1,
-		.ratio_preq = 0,
-		.sgn_post1q = 1,
-		.ratio_post1q = 0,
-		.amp_red = 6,
-		.adpt_eq = 48,
-		.enter_idle_flt_sel = 4,
-		.exit_idle_flt_sel = 3,
-		.data_lost_th_sel = 1,
-		.gk2ovd = 0x1f,
-		.gk3ovd = 0,
-		.gk4ovd = 0,
-		.gk2ovd_en = 1,
-		.gk3ovd_en = 1,
-		.gk4ovd_en = 0,
-		.eq_offset_ovd = 0x1f,
-		.eq_offset_ovd_en = 0,
-		.eq_offset_rng_dbl = 0,
-		.eq_blw_sel = 0,
-		.eq_boost = 0,
-		.spare_in = 0,
-		.smp_autoz_d1r = 0,
-		.smp_autoz_eg1r = 0,
-	},
-	[PHY_INTERFACE_MODE_1000BASEX] = {
+static const struct lynx_28g_proto_conf lynx_28g_proto_conf[LANE_MODE_MAX] = {
+	[LANE_MODE_1000BASEX_SGMII] = {
 		.proto_sel = LNaGCR0_PROTO_SEL_SGMII,
 		.if_width = LNaGCR0_IF_WIDTH_10_BIT,
 		.teq_type = EQ_TYPE_NO_EQ,
@@ -337,7 +316,7 @@ static const struct lynx_28g_proto_conf lynx_28g_proto_conf[PHY_INTERFACE_MODE_M
 		.smp_autoz_d1r = 0,
 		.smp_autoz_eg1r = 0,
 	},
-	[PHY_INTERFACE_MODE_10GBASER] = {
+	[LANE_MODE_10GBASER_USXGMII] = {
 		.proto_sel = LNaGCR0_PROTO_SEL_XFI,
 		.if_width = LNaGCR0_IF_WIDTH_20_BIT,
 		.teq_type = EQ_TYPE_2TAP,
@@ -379,7 +358,7 @@ struct lynx_28g_pll {
 	struct lynx_28g_priv *priv;
 	u32 rstctl, cr0, cr1;
 	int id;
-	DECLARE_PHY_INTERFACE_MASK(supported);
+	DECLARE_BITMAP(supported, LANE_MODE_MAX);
 };
 
 struct lynx_28g_lane {
@@ -388,7 +367,7 @@ struct lynx_28g_lane {
 	bool powered_up;
 	bool init;
 	unsigned int id;
-	phy_interface_t interface;
+	enum lynx_lane_mode mode;
 };
 
 struct lynx_28g_priv {
@@ -429,7 +408,34 @@ static void lynx_28g_rmw(struct lynx_28g_priv *priv, unsigned long off,
 #define lynx_28g_pll_read(pll, reg)			\
 	ioread32((pll)->priv->base + reg((pll)->id))
 
-static bool lynx_28g_supports_interface(struct lynx_28g_priv *priv, int intf)
+static const char *lynx_lane_mode_str(enum lynx_lane_mode lane_mode)
+{
+	switch (lane_mode) {
+	case LANE_MODE_1000BASEX_SGMII:
+		return "1000Base-X/SGMII";
+	case LANE_MODE_10GBASER_USXGMII:
+		return "10GBase-R/USXGMII";
+	default:
+		return "unknown";
+	}
+}
+
+static enum lynx_lane_mode phy_interface_to_lane_mode(phy_interface_t intf)
+{
+	switch (intf) {
+	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_1000BASEX:
+		return LANE_MODE_1000BASEX_SGMII;
+	case PHY_INTERFACE_MODE_10GBASER:
+	case PHY_INTERFACE_MODE_USXGMII:
+		return LANE_MODE_10GBASER_USXGMII;
+	default:
+		return LANE_MODE_UNKNOWN;
+	}
+}
+
+static bool lynx_28g_supports_lane_mode(struct lynx_28g_priv *priv,
+					enum lynx_lane_mode mode)
 {
 	int i;
 
@@ -437,7 +443,7 @@ static bool lynx_28g_supports_interface(struct lynx_28g_priv *priv, int intf)
 		if (PLLnRSTCTL_DIS(priv->pll[i].rstctl))
 			continue;
 
-		if (test_bit(intf, priv->pll[i].supported))
+		if (test_bit(mode, priv->pll[i].supported))
 			return true;
 	}
 
@@ -445,7 +451,7 @@ static bool lynx_28g_supports_interface(struct lynx_28g_priv *priv, int intf)
 }
 
 static struct lynx_28g_pll *lynx_28g_pll_get(struct lynx_28g_priv *priv,
-					     phy_interface_t intf)
+					     enum lynx_lane_mode mode)
 {
 	struct lynx_28g_pll *pll;
 	int i;
@@ -456,27 +462,27 @@ static struct lynx_28g_pll *lynx_28g_pll_get(struct lynx_28g_priv *priv,
 		if (PLLnRSTCTL_DIS(pll->rstctl))
 			continue;
 
-		if (test_bit(intf, pll->supported))
+		if (test_bit(mode, pll->supported))
 			return pll;
 	}
 
 	/* no pll supports requested mode, either caller forgot to check
 	 * lynx_28g_supports_lane_mode, or this is a bug.
 	 */
-	dev_WARN_ONCE(priv->dev, 1, "no pll for interface %s\n", phy_modes(intf));
+	dev_WARN_ONCE(priv->dev, 1, "no pll for lane mode %s\n",
+		      lynx_lane_mode_str(mode));
 	return NULL;
 }
 
 static void lynx_28g_lane_set_nrate(struct lynx_28g_lane *lane,
 				    struct lynx_28g_pll *pll,
-				    phy_interface_t intf)
+				    enum lynx_lane_mode lane_mode)
 {
 	switch (FIELD_GET(PLLnCR1_FRATE_SEL, pll->cr1)) {
 	case PLLnCR1_FRATE_5G_10GVCO:
 	case PLLnCR1_FRATE_5G_25GVCO:
-		switch (intf) {
-		case PHY_INTERFACE_MODE_SGMII:
-		case PHY_INTERFACE_MODE_1000BASEX:
+		switch (lane_mode) {
+		case LANE_MODE_1000BASEX_SGMII:
 			lynx_28g_lane_rmw(lane, LNaTGCR0,
 					  FIELD_PREP(LNaTGCR0_N_RATE, LNaTGCR0_N_RATE_QUARTER),
 					  LNaTGCR0_N_RATE);
@@ -489,9 +495,8 @@ static void lynx_28g_lane_set_nrate(struct lynx_28g_lane *lane,
 		}
 		break;
 	case PLLnCR1_FRATE_10G_20GVCO:
-		switch (intf) {
-		case PHY_INTERFACE_MODE_10GBASER:
-		case PHY_INTERFACE_MODE_USXGMII:
+		switch (lane_mode) {
+		case LANE_MODE_10GBASER_USXGMII:
 			lynx_28g_lane_rmw(lane, LNaTGCR0,
 					  FIELD_PREP(LNaTGCR0_N_RATE, LNaTGCR0_N_RATE_FULL),
 					  LNaTGCR0_N_RATE);
@@ -580,17 +585,16 @@ static int lynx_28g_power_on(struct phy *phy)
 	return 0;
 }
 
-static int lynx_28g_get_pccr(phy_interface_t interface, int lane,
+static int lynx_28g_get_pccr(enum lynx_lane_mode lane_mode, int lane,
 			     struct lynx_pccr *pccr)
 {
-	switch (interface) {
-	case PHY_INTERFACE_MODE_SGMII:
-	case PHY_INTERFACE_MODE_1000BASEX:
+	switch (lane_mode) {
+	case LANE_MODE_1000BASEX_SGMII:
 		pccr->offset = PCC8;
 		pccr->width = 4;
 		pccr->shift = SGMII_CFG(lane);
 		break;
-	case PHY_INTERFACE_MODE_10GBASER:
+	case LANE_MODE_10GBASER_USXGMII:
 		pccr->offset = PCCC;
 		pccr->width = 4;
 		pccr->shift = SXGMII_CFG(lane);
@@ -602,13 +606,12 @@ static int lynx_28g_get_pccr(phy_interface_t interface, int lane,
 	return 0;
 }
 
-static int lynx_28g_get_pcvt_offset(int lane, phy_interface_t interface)
+static int lynx_28g_get_pcvt_offset(int lane, enum lynx_lane_mode lane_mode)
 {
-	switch (interface) {
-	case PHY_INTERFACE_MODE_SGMII:
-	case PHY_INTERFACE_MODE_1000BASEX:
+	switch (lane_mode) {
+	case LANE_MODE_1000BASEX_SGMII:
 		return SGMIIaCR0(lane);
-	case PHY_INTERFACE_MODE_10GBASER:
+	case LANE_MODE_10GBASER_USXGMII:
 		return SXGMIIaCR0(lane);
 	default:
 		return -EOPNOTSUPP;
@@ -616,14 +619,14 @@ static int lynx_28g_get_pcvt_offset(int lane, phy_interface_t interface)
 }
 
 static int lynx_pccr_write(struct lynx_28g_lane *lane,
-			   phy_interface_t interface, u32 val)
+			   enum lynx_lane_mode lane_mode, u32 val)
 {
 	struct lynx_28g_priv *priv = lane->priv;
 	struct lynx_pccr pccr;
 	u32 old, tmp, mask;
 	int err;
 
-	err = lynx_28g_get_pccr(interface, lane->id, &pccr);
+	err = lynx_28g_get_pccr(lane_mode, lane->id, &pccr);
 	if (err)
 		return err;
 
@@ -638,13 +641,13 @@ static int lynx_pccr_write(struct lynx_28g_lane *lane,
 	return 0;
 }
 
-static int lynx_pcvt_read(struct lynx_28g_lane *lane, phy_interface_t interface,
-			  int cr, u32 *val)
+static int lynx_pcvt_read(struct lynx_28g_lane *lane,
+			  enum lynx_lane_mode lane_mode, int cr, u32 *val)
 {
 	struct lynx_28g_priv *priv = lane->priv;
 	int offset;
 
-	offset = lynx_28g_get_pcvt_offset(lane->id, interface);
+	offset = lynx_28g_get_pcvt_offset(lane->id, lane_mode);
 	if (offset < 0)
 		return offset;
 
@@ -653,13 +656,13 @@ static int lynx_pcvt_read(struct lynx_28g_lane *lane, phy_interface_t interface,
 	return 0;
 }
 
-static int lynx_pcvt_write(struct lynx_28g_lane *lane, phy_interface_t interface,
-			   int cr, u32 val)
+static int lynx_pcvt_write(struct lynx_28g_lane *lane,
+			   enum lynx_lane_mode lane_mode, int cr, u32 val)
 {
 	struct lynx_28g_priv *priv = lane->priv;
 	int offset;
 
-	offset = lynx_28g_get_pcvt_offset(lane->id, interface);
+	offset = lynx_28g_get_pcvt_offset(lane->id, lane_mode);
 	if (offset < 0)
 		return offset;
 
@@ -668,43 +671,44 @@ static int lynx_pcvt_write(struct lynx_28g_lane *lane, phy_interface_t interface
 	return 0;
 }
 
-static int lynx_pcvt_rmw(struct lynx_28g_lane *lane, phy_interface_t interface,
+static int lynx_pcvt_rmw(struct lynx_28g_lane *lane,
+			 enum lynx_lane_mode lane_mode,
 			 int cr, u32 val, u32 mask)
 {
 	int err;
 	u32 tmp;
 
-	err = lynx_pcvt_read(lane, interface, cr, &tmp);
+	err = lynx_pcvt_read(lane, lane_mode, cr, &tmp);
 	if (err)
 		return err;
 
 	tmp &= ~mask;
 	tmp |= val;
 
-	return lynx_pcvt_write(lane, interface, cr, tmp);
+	return lynx_pcvt_write(lane, lane_mode, cr, tmp);
 }
 
 static void lynx_28g_lane_remap_pll(struct lynx_28g_lane *lane,
-				    phy_interface_t interface)
+				    enum lynx_lane_mode lane_mode)
 {
 	struct lynx_28g_priv *priv = lane->priv;
 	struct lynx_28g_pll *pll;
 
 	/* Switch to the PLL that works with this interface type */
-	pll = lynx_28g_pll_get(priv, interface);
+	pll = lynx_28g_pll_get(priv, lane_mode);
 	if (unlikely(pll == NULL))
 		return;
 
 	lynx_28g_lane_set_pll(lane, pll);
 
 	/* Choose the portion of clock net to be used on this lane */
-	lynx_28g_lane_set_nrate(lane, pll, interface);
+	lynx_28g_lane_set_nrate(lane, pll, lane_mode);
 }
 
 static void lynx_28g_lane_change_proto_conf(struct lynx_28g_lane *lane,
-					    phy_interface_t interface)
+					    enum lynx_lane_mode lane_mode)
 {
-	const struct lynx_28g_proto_conf *conf = &lynx_28g_proto_conf[interface];
+	const struct lynx_28g_proto_conf *conf = &lynx_28g_proto_conf[lane_mode];
 
 	lynx_28g_lane_rmw(lane, LNaGCR0,
 			  FIELD_PREP(LNaGCR0_PROTO_SEL, conf->proto_sel) |
@@ -775,21 +779,20 @@ static void lynx_28g_lane_change_proto_conf(struct lynx_28g_lane *lane,
 }
 
 static int lynx_28g_lane_disable_pcvt(struct lynx_28g_lane *lane,
-				      phy_interface_t interface)
+				      enum lynx_lane_mode lane_mode)
 {
 	struct lynx_28g_priv *priv = lane->priv;
 	int err;
 
 	spin_lock(&priv->pcc_lock);
 
-	err = lynx_pccr_write(lane, interface, 0);
+	err = lynx_pccr_write(lane, lane_mode, 0);
 	if (err)
 		goto out;
 
-	switch (interface) {
-	case PHY_INTERFACE_MODE_SGMII:
-	case PHY_INTERFACE_MODE_1000BASEX:
-		err = lynx_pcvt_rmw(lane, interface, CR(1), 0,
+	switch (lane_mode) {
+	case LANE_MODE_1000BASEX_SGMII:
+		err = lynx_pcvt_rmw(lane, lane_mode, CR(1), 0,
 				    SGMIIaCR1_SGPCS_EN);
 		break;
 	default:
@@ -803,7 +806,7 @@ static int lynx_28g_lane_disable_pcvt(struct lynx_28g_lane *lane,
 }
 
 static int lynx_28g_lane_enable_pcvt(struct lynx_28g_lane *lane,
-				     phy_interface_t interface)
+				     enum lynx_lane_mode lane_mode)
 {
 	struct lynx_28g_priv *priv = lane->priv;
 	u32 val;
@@ -811,10 +814,9 @@ static int lynx_28g_lane_enable_pcvt(struct lynx_28g_lane *lane,
 
 	spin_lock(&priv->pcc_lock);
 
-	switch (interface) {
-	case PHY_INTERFACE_MODE_SGMII:
-	case PHY_INTERFACE_MODE_1000BASEX:
-		err = lynx_pcvt_rmw(lane, interface, CR(1), SGMIIaCR1_SGPCS_EN,
+	switch (lane_mode) {
+	case LANE_MODE_1000BASEX_SGMII:
+		err = lynx_pcvt_rmw(lane, lane_mode, CR(1), SGMIIaCR1_SGPCS_EN,
 				    SGMIIaCR1_SGPCS_EN);
 		break;
 	default:
@@ -823,19 +825,18 @@ static int lynx_28g_lane_enable_pcvt(struct lynx_28g_lane *lane,
 
 	val = 0;
 
-	switch (interface) {
-	case PHY_INTERFACE_MODE_SGMII:
-	case PHY_INTERFACE_MODE_1000BASEX:
+	switch (lane_mode) {
+	case LANE_MODE_1000BASEX_SGMII:
 		val |= PCC8_SGMIIa_CFG;
 		break;
-	case PHY_INTERFACE_MODE_10GBASER:
+	case LANE_MODE_10GBASER_USXGMII:
 		val |= PCCC_SXGMIIn_CFG | PCCC_SXGMIIn_XFI;
 		break;
 	default:
 		break;
 	}
 
-	err = lynx_pccr_write(lane, interface, val);
+	err = lynx_pccr_write(lane, lane_mode, val);
 
 	spin_unlock(&priv->pcc_lock);
 
@@ -847,18 +848,21 @@ static int lynx_28g_set_mode(struct phy *phy, enum phy_mode mode, int submode)
 	struct lynx_28g_lane *lane = phy_get_drvdata(phy);
 	struct lynx_28g_priv *priv = lane->priv;
 	int powered_up = lane->powered_up;
+	enum lynx_lane_mode lane_mode;
 	int err = 0;
 
 	if (mode != PHY_MODE_ETHERNET)
 		return -EOPNOTSUPP;
 
-	if (lane->interface == PHY_INTERFACE_MODE_NA)
+	if (lane->mode == LANE_MODE_UNKNOWN)
 		return -EOPNOTSUPP;
 
-	if (!lynx_28g_supports_interface(priv, submode))
+	lane_mode = phy_interface_to_lane_mode(submode);
+
+	if (!lynx_28g_supports_lane_mode(priv, lane_mode))
 		return -EOPNOTSUPP;
 
-	if (submode == lane->interface)
+	if (submode == lane->mode)
 		return 0;
 
 	/* If the lane is powered up, put the lane into the halt state while
@@ -867,7 +871,7 @@ static int lynx_28g_set_mode(struct phy *phy, enum phy_mode mode, int submode)
 	if (powered_up)
 		lynx_28g_power_off(phy);
 
-	err = lynx_28g_lane_disable_pcvt(lane, lane->interface);
+	err = lynx_28g_lane_disable_pcvt(lane, lane->mode);
 	if (err)
 		goto out;
 
@@ -875,7 +879,7 @@ static int lynx_28g_set_mode(struct phy *phy, enum phy_mode mode, int submode)
 	lynx_28g_lane_remap_pll(lane, submode);
 	WARN_ON(lynx_28g_lane_enable_pcvt(lane, submode));
 
-	lane->interface = submode;
+	lane->mode = lane_mode;
 
 out:
 	if (powered_up)
@@ -893,7 +897,8 @@ static int lynx_28g_validate(struct phy *phy, enum phy_mode mode, int submode,
 	if (mode != PHY_MODE_ETHERNET)
 		return -EOPNOTSUPP;
 
-	if (!lynx_28g_supports_interface(priv, submode))
+	if (!lynx_28g_supports_lane_mode(priv,
+					 phy_interface_to_lane_mode(submode)))
 		return -EOPNOTSUPP;
 
 	return 0;
@@ -946,12 +951,11 @@ static void lynx_28g_pll_read_configuration(struct lynx_28g_priv *priv)
 		case PLLnCR1_FRATE_5G_10GVCO:
 		case PLLnCR1_FRATE_5G_25GVCO:
 			/* 5GHz clock net */
-			__set_bit(PHY_INTERFACE_MODE_1000BASEX, pll->supported);
-			__set_bit(PHY_INTERFACE_MODE_SGMII, pll->supported);
+			__set_bit(LANE_MODE_1000BASEX_SGMII, pll->supported);
 			break;
 		case PLLnCR1_FRATE_10G_20GVCO:
 			/* 10.3125GHz clock net */
-			__set_bit(PHY_INTERFACE_MODE_10GBASER, pll->supported);
+			__set_bit(LANE_MODE_10GBASER_USXGMII, pll->supported);
 			break;
 		default:
 			/* 6GHz, 12.890625GHz, 8GHz */
@@ -1002,13 +1006,13 @@ static void lynx_28g_lane_read_configuration(struct lynx_28g_lane *lane)
 	protocol = FIELD_GET(LNaPSS_TYPE, pss);
 	switch (protocol) {
 	case LNaPSS_TYPE_SGMII:
-		lane->interface = PHY_INTERFACE_MODE_SGMII;
+		lane->mode = LANE_MODE_1000BASEX_SGMII;
 		break;
 	case LNaPSS_TYPE_XFI:
-		lane->interface = PHY_INTERFACE_MODE_10GBASER;
+		lane->mode = LANE_MODE_10GBASER_USXGMII;
 		break;
 	default:
-		lane->interface = PHY_INTERFACE_MODE_NA;
+		lane->mode = LANE_MODE_UNKNOWN;
 	}
 }
 
-- 
2.34.1


