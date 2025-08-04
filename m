Return-Path: <linux-kernel+bounces-755017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D48B1A014
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 12:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B8DF18901D1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 10:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F30E255F52;
	Mon,  4 Aug 2025 10:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b="n3VGFg6u"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2133.outbound.protection.outlook.com [40.107.20.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EB6253B5C;
	Mon,  4 Aug 2025 10:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754304907; cv=fail; b=nTizchWIYhh4STxzAM3x/7vxDDv2UDbLRfV9AaWGtmnlVO5/ssY+wHp9Vl+Jj0CSHTNPgPV9l96bwOrBvYVjZ1+DgwjT58nfsmtQ7ilMeOiLTZ7KwPwUvMUxiTQ+y4FprxENweQoooHjI4wFWeatEPDBXvnPb0tvCv7mcKA2C9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754304907; c=relaxed/simple;
	bh=wQdX+o1mxRdt0Inft8SYgqDekvygqIgZ6I1KYbdYx3Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n9zb8Gedg6wWnCIQB61NZ55W8AsWRiLuVH4kP0uaOQoS4HTwF2QkNeCjVSZ8212xLlHVgVJSKveV+qN7nu45HwqwBAUQfk0mVH0z0X5nGrUfKIj8aYanXHtn/UuaW9TelxpEk3Dkh2VaQATSkwlkeqKWYrUtoZPNaXk+zRSH9t0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b=n3VGFg6u; arc=fail smtp.client-ip=40.107.20.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T2mx01KxlLL8KxlhWQIuE6VmdMMZzdzB81K0lYSERv9Lv8nh493voi14k6OZ451nOPtgoPxI+O8cEavj0ZqLMWzU5y8ZFp06fDZCFIv9Ld+jb1/aXcScyMdCXXkSC1vDzMRUSfkOq112nbzYL/BagvgogDzBzJtjegV15MixKaVt+HYyMqnmbeztalbC+UB9+PNdS/eTQagSaAsMUB5sU+n5p8UtGAEuDQt5YjgS8WbOpwh4cfDHNjGMUD/sQGViEHtmty1DXcUOyJsK6K75W4O61gDY08rlRMexuDYOU73gQn2VcR6QzqAnuJZRM6a/gV5jF7BMapn4gnuQ2xfx7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jmqe/ZBEBlrP1T1bepn+6W97vg9czKOMLOLDcitW/Fc=;
 b=iBAP6Uw932UZkCDFrzRj0Hqmku05a7pqHrGBceL8OUR7EUwISa67DVRVeBjLMnMUPcO2yEVDwfkjkMS5YlJcjI2rNPl1XL2Lh+bPNQbYNTNqFZpVB+lXc602kYqB5IYY4xUlKW2DCTawh41oaovV0UIK5m3SMZQNG8qhySXlv9zgKGskY75H0Un5UP6WmNQNIkHP18zj93H6I+UyWxlsOmdb+e6uQmK0p6T48O2+acPhC/eALjQWSQBip0KX7ksb9yEz9/RrEG6DLjw4q5vyn1ILbgl1grg7pH3Yb41NbePtno5W1O59vnFje/DUNSJWIvimlHfxuxP3izO66RfNVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=ti.com smtp.mailfrom=phytec.de; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine header.from=phytec.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jmqe/ZBEBlrP1T1bepn+6W97vg9czKOMLOLDcitW/Fc=;
 b=n3VGFg6uYXtFEhxh1/KU//xqskR62Yz4Ksp/0Pmg0RI3cb+j63NU4N40j+seeAFE1SRd5JPA3UwLvpOQNPDX18Wi/43142eZ0Oc3vLffizBC9hNai4LSNT/Gx2hpwVvxYGxthp2I6nVRYwRQ0HFTFYP2so4RgTbBA2Y18eQaEyY//H4LrFLZuVSd8BLjALoA17ND26jsuM7Ho1jler1aEUUgWTtWbAvjesu0+DYHomKPo27SQR+UL4x2nSKOzSF5vkQi9B27Nq2QSXzU4ar8m9v13P4QromYMqJw9e5IttWiDgMTPHtIOEwfLCzM5wNlAiilssU6l+/mag7dw4VIvw==
Received: from AM0PR02CA0156.eurprd02.prod.outlook.com (2603:10a6:20b:28d::23)
 by PR3P195MB0713.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:32::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 10:54:59 +0000
Received: from AM3PEPF0000A78D.eurprd04.prod.outlook.com
 (2603:10a6:20b:28d:cafe::5e) by AM0PR02CA0156.outlook.office365.com
 (2603:10a6:20b:28d::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.20 via Frontend Transport; Mon,
 4 Aug 2025 10:54:59 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM3PEPF0000A78D.mail.protection.outlook.com (10.167.16.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Mon, 4 Aug 2025 10:54:58 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Mon, 4 Aug
 2025 12:54:57 +0200
Received: from phytec.de (172.25.0.51) by Florix.phytec.de (172.25.0.13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Mon, 4 Aug
 2025 12:54:57 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <obh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <upstream@lists.phytec.de>
Subject: [PATCH] arm64: dts: ti: k3-am642-phyboard-electra: Add ti,pa-stats property
Date: Mon, 4 Aug 2025 12:54:50 +0200
Message-ID: <20250804105450.2322647-1-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A78D:EE_|PR3P195MB0713:EE_
X-MS-Office365-Filtering-Correlation-Id: 142400f5-0165-43f7-73c7-08ddd3455a78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rGT3A+KcKY/9zC6sz8zJlQ9nfmAhDiUiPCq2irx8R00kKThgXyfXt1D/oP9K?=
 =?us-ascii?Q?Id++C/sO56pS8sKQuoVzfWT3TxQNsozo8epI5WeVfuelHlScXUeIcVL5nrEA?=
 =?us-ascii?Q?9uT69MEOmpgx/a68mMhv2Kjrq/kePpbKMx9ZtMwyQ0NCoIMf3YRUkmF06Xow?=
 =?us-ascii?Q?L7rctow0A/7U97pXNo4ceHCZNniQve08EpXSBmcMtNQMvPB/rC/Vh/Lo4ZUu?=
 =?us-ascii?Q?RK6Ttm1kerze+dAe4t90ZVWujbQttRwrq+b52/N2VCqQYAQfirLjm0Inv28v?=
 =?us-ascii?Q?4mtI47U25QYsSebch1EgmoAHnbHVumLVRp4VHEaA2NxrD8Xos5kCkuqkXFhD?=
 =?us-ascii?Q?1pi+38np/7tyli+ZnVR/s93jfoqFZ5KWZcu0yeg7BKlnC71AwqHKGAB4xhhJ?=
 =?us-ascii?Q?1ez/Q5iWm2WiWrarueadgoRlJYtooHucdBehyJbrduT+yxgXL+1JE6ZEN3fI?=
 =?us-ascii?Q?/qcnEEcWz4Rn+pwo9nFoynaSwxEXFpunZSnDIrCgu1aYnazJYBLxTm2FnUu+?=
 =?us-ascii?Q?Eo78bYujZfZPc+U+GvoBMbKSxxTsuJbzsLRyOUyJnoT+XjXjWMbLEHCD26yf?=
 =?us-ascii?Q?eVOyBX4DI0b0STdz8BZ1MnnIDiqwHYZwmBR5qoclfAH446SifmePG2Dxo2Kk?=
 =?us-ascii?Q?ZdfgvnL5mAZ+OTLsAFLAy6YKpgZ+XxTLoLMDD9UVDm9KZUaeF4MtzAih6Zt3?=
 =?us-ascii?Q?QGaUMcl0RmqDvoojNthkQjXtAH5czCONrFBgpCI/y0onwfL/gtShyLJShCdi?=
 =?us-ascii?Q?EQIwjv0UeIeF7DMcBvAVu0dVZOma3EaaAK1bx2Tvyz8+7hCbXG9t3VASEVgW?=
 =?us-ascii?Q?tM36gvqReqbV8SAAjOCJkt8nd5ENdaZ/A+JTKmZTmm/BO8/M+uNCvxew+PNc?=
 =?us-ascii?Q?eEpGpdXWjw05rQfw4/UD1jxpXmwYrwfNuSUIVtTUgIkLYeM9vISTevugmNVR?=
 =?us-ascii?Q?mOB37EXEM/lnHUyZ+m/6kI9Zx9M9XWEGB0Y2TD5Vdh18vNlcn+Tk1yWK7pw6?=
 =?us-ascii?Q?DLjpofOq8Z2Ifcx5wODe5Pw2vr+NJVk5L76FSM92kVo17JB1if9XA0wcD/3k?=
 =?us-ascii?Q?LEWZE/R0kEjIo7grc3+wSTsQ1mz3ZDrzUGCLBImbGlWp7r36Xjbhu8VICY94?=
 =?us-ascii?Q?YChyiRxKLEb+TsOg6nidJ/315adKp/ZCZ+lnrbqnFwoNyPTlxnZO3h0jv80L?=
 =?us-ascii?Q?ypWUSUpz+NakbZ7YT3myWhVCZW7NN8IHtWGyIQ/Qs4CSZmiPKzP/O/x/9e8k?=
 =?us-ascii?Q?eKo+XTRuvFrXTefEDRIDeSuFfIGfyQpciTYeSsrj/Ajgf14ow5IDOA/cVcv5?=
 =?us-ascii?Q?h/WraSfBo8JUItS8WXsr5KD8+SLkwyyqm1jxKsU74uefni5Ym21fRunID4mC?=
 =?us-ascii?Q?8j6bNMAyo+gSovOTjWLq/3AvzvGlcczUGvQ+DX77PYc1/QKF853mJgEmi9SH?=
 =?us-ascii?Q?4BTFdTDnNnXpMq/2NLm7s/LpP+WoFeGznbB08ekUiyXG51X3kbPKe6nYLW3C?=
 =?us-ascii?Q?YZxNzhaAxPTMu3yuEs3XHRucvhVekd2ZR5P/?=
X-Forefront-Antispam-Report:
	CIP:91.26.50.189;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:Diagnostix.phytec.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 10:54:58.0094
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 142400f5-0165-43f7-73c7-08ddd3455a78
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29;Ip=[91.26.50.189];Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A78D.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P195MB0713

Add ti,pa-stats phandles. This is a phandle to PA_STATS syscon regmap
and will be used to dump IET related statistics for ICSSG Driver.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
index 129524eb5b91..e4afa8c0a8ca 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
@@ -100,6 +100,7 @@ ethernet {
 		ti,mii-g-rt = <&icssg0_mii_g_rt>;
 		ti,mii-rt = <&icssg0_mii_rt>;
 		ti,iep = <&icssg0_iep0>, <&icssg0_iep1>;
+		ti,pa-stats = <&icssg0_pa_stats>;
 
 		ethernet-ports {
 			#address-cells = <1>;
-- 
2.48.1


