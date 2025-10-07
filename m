Return-Path: <linux-kernel+bounces-843918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE750BC0943
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 10:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74933189E55A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 08:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1747287504;
	Tue,  7 Oct 2025 08:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b="bzKaE9Ib"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020080.outbound.protection.outlook.com [52.101.69.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40722868B5;
	Tue,  7 Oct 2025 08:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759824830; cv=fail; b=uCR/+XRN5MEZCj1QFFlYyxn+uZi8xrG6AJNd460ojQ5rQqinipvDlN0IuHSx3DLyeE/nhnG1efjXjteMQwOk0hfdtwxvTPvZ8cyIhhlAWdi1GZC+O5FJhQCkbSVB6gRjDzoE2enNGijxACzpVe2sFq5agovo8JVfvy0zUdGkyfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759824830; c=relaxed/simple;
	bh=rhMV2KgVlJjD5KAK+8F8Ikv+b35NbLBJoXjtzno9KZk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=YG3jWdKu3zkyr/WdVYSFRlKFuH9v4IqIXKYWLApMgQ9v82mCdjMwE7BwJPOibT0zkTS22qwBMrKCwo1ybccefSLiU+fneXL1pD6obRqtn8ujFI+Zv4HTu/WejlX3jEndrAK5JXMLpUVI5CO51oXsdNupRNb54jKP6EUurE2dDek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b=bzKaE9Ib; arc=fail smtp.client-ip=52.101.69.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ilAhYdEqP78oV5pUv6PJI+6F1s9Elw/k+68Qj3WzK5TeUX4IQ5/V+EkjnrKqWPdP+Fsmvx90vCHWIWcvqlyJNXI85l4JbBA3BhKN3MdTtncH/XNlqn8UPeG5AWiU1waCC8KNK2Qwn9KS0Kg8qrNvCbxmFKyAavl61s30uORGI8+5VO3VpAo5CklcM1jXPA7TdyoQrBsLA+RdiZWCpFE2Y5c5h8yb5GnHDIkhRMfNKfPw5do61Qn5egD8DhYndelVT+lDbUE3EEq6LhiBTTHlBfoh23iv6c2zO00Yqdu90qT0jh1DysXPMg+5TgtZYmnm++RWhFt9nF84JmC5NeQroQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NZyl4A8u3YBjE5e4J7julb34OpKK+lodG5Rqgoxgr6w=;
 b=eyXet4BdIlrGeYYK4Ysj/7zYd1xbCEH+kVZICiOTnLmMc2frxTcfdm5nURwqa4YJxsFpCmzPnSofZUl7f2hCzhAy3spozTRa8tvvn8AMJnkah15nIipIrp0f7TjcaFUZFyWnPEKYC4csS1kqVTFFuhsPalxT0vXjXyxHJYCnG7FQo0B3gcf8edcjGU6BG5zin0E9zcR82lgDW3BcnsgLJSxYmVWY+CBLrEIrCloslWTOM0fAbOIMBldnWAd+P4h69glNI6EqpTzA+92m+bgX2z4HL6aUiO2MNEuUMtijm6vO3dfVw5lV5EL3RigMPQpPbQzR7zD5jBXY4dNktVyZ3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=kernel.org smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZyl4A8u3YBjE5e4J7julb34OpKK+lodG5Rqgoxgr6w=;
 b=bzKaE9Ib3Vrb1bj45eIqzG40MCnw1JahiaSisAggpF3AIRowCyAbsSpPWKOVc2VyUYxhyuTKheNAYTj3CWmmbipe8qo12jiIlGvPvmOMYyc04VxUVxiSWnmyv2pILA29Pe+6EL0mypi74rV/kz0w/snBnbE+hDIGJY0QNLJ33vAFopiaiKef7PAdfYIvJJKsB65NiDJaw1mxATBrc/vo+MsCJelnEuspnj2nLB244BYulRGuhR7bWs5VNNa28vZtZD5mNVAILGwit5efx1zd1EYaMN8HlSztxUDrrsxSeDccA/DzMNMnzJiEhxyYNKlSl5FgHjelwFLG31Pq4K/LpA==
Received: from DUZP191CA0008.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4f9::20)
 by AS8P195MB1821.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:52d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 08:13:42 +0000
Received: from DB1PEPF000509EE.eurprd03.prod.outlook.com
 (2603:10a6:10:4f9:cafe::df) by DUZP191CA0008.outlook.office365.com
 (2603:10a6:10:4f9::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Tue,
 7 Oct 2025 08:13:42 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 DB1PEPF000509EE.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Tue, 7 Oct 2025 08:13:42 +0000
Received: from llp-moog.phytec.de (172.25.32.44) by Postix.phytec.de
 (172.25.0.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 7 Oct
 2025 10:13:41 +0200
From: Yannic Moog <y.moog@phytec.de>
Date: Tue, 7 Oct 2025 10:13:27 +0200
Subject: [PATCH v4 1/4] arm64: dts: im8mp-phy{board,core}: update license
 and copyright
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251007-imx8mp-pollux-display-overlays-v4-1-778c61a4495c@phytec.de>
References: <20251007-imx8mp-pollux-display-overlays-v4-0-778c61a4495c@phytec.de>
In-Reply-To: <20251007-imx8mp-pollux-display-overlays-v4-0-778c61a4495c@phytec.de>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <imx@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<upstream@lists.phytec.de>, Yannic Moog <y.moog@phytec.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759824821; l=1744;
 i=y.moog@phytec.de; s=20250509; h=from:subject:message-id;
 bh=rhMV2KgVlJjD5KAK+8F8Ikv+b35NbLBJoXjtzno9KZk=;
 b=CDC62f3Tv9Y9lCsxhraYlNQ4+ewDfdQWiCpcJKAx4L/V4j57a50KTsQkgB9mFlhPoTxEN28+I
 /9V7OC6UlS4C4mvtB5GqrfN2gXho7t7TRdHu6Dcd8q0qj25/tr9i05t
X-Developer-Key: i=y.moog@phytec.de; a=ed25519;
 pk=rpKoEJ4E7nD9qsrU/rfKVwMTWNWYaTBylZuJUXUiFr8=
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509EE:EE_|AS8P195MB1821:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b4f82fb-8155-42fd-5a4d-08de05796df2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SVJGUCtKMDY1ZWQ0R0xteGYvSHBtaGN6bG9ZYkVDMlZDdkY2WVBkYlY0cHdh?=
 =?utf-8?B?anZJUHNIOFNsRkRjK1VCRFlWQWxTcW9qcUl0ajAvTVUvVjBxN1dXa0k3T3Ni?=
 =?utf-8?B?TGVCN01XSGZvdlNhaUtBd093cVhaTzRHQUd6K3RRYVh2bEczbDIwR1BNNjZV?=
 =?utf-8?B?M2tDT0lRV2VYRjNqSkM0NlpwZ0QvMTdpY0ZUOWFVYlhWSXZ6QUxaL3FtNzMr?=
 =?utf-8?B?UUx5WWRXUzAxNlZjT3Jnb200SExNNWM2SWN4dEJlZnhrYUk3TEJ0NUlwRnB4?=
 =?utf-8?B?ak00YU0xVUVpOG5sWVdCMGRBZk1wcThCNjNKZXpoL1ZvZmo3OTdDSTNDOWxD?=
 =?utf-8?B?U01GYWJFRDJtVDcvVXRJWVFIK1Q3ODUzL1FHam44ZmMwM1MxbWhBSG51TEFq?=
 =?utf-8?B?QmJIcVd5eURYcWVIT1pITGV4SjhGajZmRTgvdEVFRzBSWnRvcUF3UlF6K3pn?=
 =?utf-8?B?blZCU0Nta1JDL3JsRGlnclNsQndpNXhjNGZlT3B5bkIvMHlQdDhlTzRsLzZ3?=
 =?utf-8?B?M0xmaWxRM3hsQkVZM0ZyTjVMZWprdWNrVFZRTG91bkxrRlZNWkNrMExRdmVp?=
 =?utf-8?B?dXhmWW1Eck9tLzVMMWNpUUt2SUZMT1N2WU14SWFPN09CclBZaThGVFNxYUxz?=
 =?utf-8?B?U0wrTWpRdnhoSU9PZ3pYM2NHd3FHK1ZVdzdHcjh5R3I4Smtra3RrM1VKMWk2?=
 =?utf-8?B?bWtXTHdCTUxiRDZKMlpmMEdGcTRDc0NOb2dEQndBMjVsSUNMakNMdnJDNVRU?=
 =?utf-8?B?VGdGcXE2NzR1NEpVeFNLZ1k1NDBrQ3QwdHdVY2pSUVJCL3NicUwzL1gzYk1X?=
 =?utf-8?B?SlROSURmYkpLOVBVdllVTjJVZWVxUWlyNktObmpRUGZBbUZrdU15QmI2Ym9p?=
 =?utf-8?B?MTJRQkFON2Z3emNNYUN5UlVsbVc5Z3JWblJKV21FT0hUTzUxSHlqaE52OEdq?=
 =?utf-8?B?YlphaEJVai9DREtwNkhNeHhBSGRSTmhWM0FaYklPL2taSWh0WW1HVTVaUXNn?=
 =?utf-8?B?c1dGU3ZwRnJ3TEtCVjdQT05WbFlXOWhCWEtQeWFLa2o4V01DdGRuYlBWK05B?=
 =?utf-8?B?ajZlQnEvRlNYUzcwZXg5b2U0aVdPL1ZMOTQzRWUrZzdLeXl4UXE1ME1YSzdW?=
 =?utf-8?B?L1V4bEk1YUpNZVNtR2Q4RE8rY2k1ZDZhV2NVNDZPZFU2WFZ2dis0d2RSQTlh?=
 =?utf-8?B?TlliOTV6eStBMW9pQzJpandiUXBaaFgrTHc4MkI0S29udnlGOHJOcGpFdVc2?=
 =?utf-8?B?Q3hwNHhwY1FUMjBQdzBTZlhEREx1VFBNVWoxWEJlOXcwUTIrN1ZHWG1SK2lm?=
 =?utf-8?B?RU0zMUx0aDlHWkNha0pVMlczY1Y2SVBYNEZSMmkrVXBiOThBaW90am1EcURz?=
 =?utf-8?B?Z2FHSkZQVldIUitHb1JVN2JObEVhdUFEMjJQaFA4UUptRExmQlVBOTNpMzUv?=
 =?utf-8?B?eEQvcHcvdTQwOUFwVFZDUW14UElWcmcxcnVVWjZRdnRYTmtOcWpxK0FTaVJM?=
 =?utf-8?B?TEl2VjJwSzA3VG1lRlQwNVJsYjI2NTUrQ3c5Y0RmcENNWVhIRkhMOVplMWt2?=
 =?utf-8?B?RmVPR0Jnd0JoU1VjbmdXa1hTOUtxT3RmRHVnVDl3aStPazhCbHpORncrbmcy?=
 =?utf-8?B?K2tMamFvc1pSMkVtRDYrc0QvVThjK3N1eXRNUzd0VS9lT3k5ZUtZb3Q4VEhs?=
 =?utf-8?B?NE9ZYzBzaGRhcFhoQk1ydnplcVhBczhEblc0V042Tkw5MUVLeTNPa1Bra2s2?=
 =?utf-8?B?RzRua3ExNWYwTmxmY0c2SDVCS2NiT1dseEd0dGtNeHltV3NwaXBFMlk4dVJk?=
 =?utf-8?B?RFVaaU1LTFJIOFZvL0d3SU1TSU5nZEhNMjZKVERhSTFYMlVNVHFpRG0rVkh4?=
 =?utf-8?B?VU9MTDVYZWFRb0ZXcHVPRXlSYWlFdUNHalcxUG5GenRPem5JTlVOSEtnVXJM?=
 =?utf-8?B?STdoMzR1amNEMDJMZWp3L2lMd0lXMDJseFZRQlJWT25RYnlxSEIxdXcrRXgr?=
 =?utf-8?B?Z0J1cVRGbFQvM2xmUEZ0aW9KZTc5L0JlNHhhRTlzdjYyMllNZEFHOElEeWFi?=
 =?utf-8?B?V0ErU0xDOTA0WktZaGE3M3NBTmtmUFQ5eDIwdUJ5eU12NEFaNS85YnJYMm01?=
 =?utf-8?Q?H7L8=3D?=
X-Forefront-Antispam-Report:
	CIP:91.26.50.189;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:Postix.phytec.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(7416014)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 08:13:42.6251
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b4f82fb-8155-42fd-5a4d-08de05796df2
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29;Ip=[91.26.50.189];Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509EE.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P195MB1821

Update Copyright year and change license from GPL-2.0 to
GPL-2.0-or-later OR MIT. Use syntax as defined in the SPDX standard.
Also remove individual authorship.

Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts | 5 ++---
 arch/arm64/boot/dts/freescale/imx8mp-phycore-som.dtsi        | 5 ++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
index 436152308642270c320e3ae3b21b9e46b923c043..46930e31119adb82eadeb5ae5bb564060d6fd5b4 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
@@ -1,7 +1,6 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
- * Copyright (C) 2020 PHYTEC Messtechnik GmbH
- * Author: Teresa Remmet <t.remmet@phytec.de>
+ * Copyright (C) 2020-2025 PHYTEC Messtechnik GmbH
  */
 
 /dts-v1/;
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-phycore-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-phycore-som.dtsi
index 04f724c6ec210bc2f382e6b9e2b13fe85d3926de..144e00e117905684156e621381aecd5f0e008b50 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-phycore-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-phycore-som.dtsi
@@ -1,7 +1,6 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
- * Copyright (C) 2020 PHYTEC Messtechnik GmbH
- * Author: Teresa Remmet <t.remmet@phytec.de>
+ * Copyright (C) 2020-2025 PHYTEC Messtechnik GmbH
  */
 
 #include <dt-bindings/net/ti-dp83867.h>

-- 
2.43.0


