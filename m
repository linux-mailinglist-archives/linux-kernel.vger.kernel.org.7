Return-Path: <linux-kernel+bounces-874780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7B4C17124
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 22:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22A5A1A63C4F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509592DF13E;
	Tue, 28 Oct 2025 21:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VzfrmXEx"
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010070.outbound.protection.outlook.com [52.101.56.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7FE25A34F;
	Tue, 28 Oct 2025 21:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761687464; cv=fail; b=p+BcJ46QSeW21fGF6t8wPRvV4pnrvNS9PLnLC0ytCeEIkA0bW22kHVNnSNk5LaM5d8kiZiIXmdfX7+CmvX+dRvPEILrutQXB7OOFugYD92vdna0wgTPkPjjIBbwyuFR9iTa/lCVYSlG67pFNDsH9HGz+9GEpVtmFVR9E1J9Aajw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761687464; c=relaxed/simple;
	bh=CuQEG4d9uG/Glq5HVTottATlgTgv8LgTerK6Pfm874I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wsrxr6oBuPt0bxzwOOlhF12/M3rCzOv3+AX+1b8lSEcFa8uzNwC82KDcR1rvWE0TlKA/OLK+PzW7zWN0PtAHG1ogAt9BxgnpVSATM2uiA+USCz0hLwkvVtgy3292FLFW5g6te1qnJQKIHFRP1MMkMxFDcMBSfXHG3KerfklCZ5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=VzfrmXEx; arc=fail smtp.client-ip=52.101.56.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OtLHbhD8htVF8G8rRwPyR51570m3/PsVRGT8QscdhdFFz56ikhpebUrFERttHSpZsaGz64tPvNi7DwFUNQRscY71eHVXDELimx6ZA7DxUmCG0FAzBsg+y3ufQVWASzD9c7G5oTDrhJVDlcsMBP7PeNZj8TUaNMBMHRTYDlHEGrQ1lwvCfu6f+AuCkBssoW2tvSw2IcCXPsNSh1DxUnboFhU1pwdvp7lyFkOHaaTxPdF3D3BS6xShqemRg0szvW0tKGUlSDUPlDxKAZQJ7P/RPAbLVuAYUmQbfoLVMCO6mlrIYZK3RihHhhPNheqsxvuLiZ/nCKwvWNYwRrBS/Ta8Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i9HVhnpGR04YIFKkFQpDaoXZsZzBX/bD4krjJmUhGsw=;
 b=HWhE7aR6HdogLohaVoKKiUTs/4pEdQP7H2l7m1c1JHY8Hp/z7BNLcCCx/K2gKNdEJtgP9due+HBc6q0MFSn3Tn6UouyIpm3fz4E6/OubX6DpVc9ZOvVuyYbW7a0RtQwqyahUsxwzhZBtpJXHzRFFarZ3a4GGX+lc57uOfXvtxFedGsNytgNUbRDzblnfBiOCgnIgsjZqr4xNBdPf2zK8sT45ic1kVMeLk+mXG6E/T9BgDZWtvN+KyqJuKSzOcWZQYBVnYQkZVfgbF6DJU1OgdYQiJs+VdeZufnY1KDse+HoPsw748CVjBuBEljNZxMbCvBpJ1PvZqr7cWvvr1WCjwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i9HVhnpGR04YIFKkFQpDaoXZsZzBX/bD4krjJmUhGsw=;
 b=VzfrmXExvllhjtym4EcBr/eegxq8LtG17Z4avObO0jWVkzVXFY/XAlXMS95CX7SBEpSymWYw9GN93Aitb+yJB7syRs5bJJgYmLyVVmgRCdtHsPjqAlVB6Y8uH1ON3z49Xf3hSGnjOUKv4iNFosmOsWrl+ChTKoIs29wvJUPjvsE=
Received: from CH5P223CA0003.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::19)
 by MW5PR10MB5805.namprd10.prod.outlook.com (2603:10b6:303:192::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 21:37:39 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:610:1f3:cafe::ef) by CH5P223CA0003.outlook.office365.com
 (2603:10b6:610:1f3::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.12 via Frontend Transport; Tue,
 28 Oct 2025 21:37:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Tue, 28 Oct 2025 21:37:36 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Oct
 2025 16:37:25 -0500
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Oct
 2025 16:37:25 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 28 Oct 2025 16:37:25 -0500
Received: from localhost (ula0502350.dhcp.ti.com [172.24.233.249])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59SLbNva2969774;
	Tue, 28 Oct 2025 16:37:24 -0500
From: Paresh Bhagat <p-bhagat@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <praneeth@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<khasim@ti.com>, <v-singh1@ti.com>, <afd@ti.com>, <bb@ti.com>,
	<s-ramamoorthy@ti.com>
Subject: [PATCH v2 1/2] arm64: dts: ti: k3-am62d2-evm: Fix PMIC padconfig
Date: Wed, 29 Oct 2025 03:06:44 +0530
Message-ID: <20251028213645.437957-2-p-bhagat@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251028213645.437957-1-p-bhagat@ti.com>
References: <20251028213645.437957-1-p-bhagat@ti.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|MW5PR10MB5805:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fa8f46d-e338-4eef-aa62-08de166a362e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|34020700016|34070700014|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CEj6Uzl3Bf8D3HI6rvmobw10rI/C8bx9yYo1UTJWCVu8bnufgE39AQAg3bUV?=
 =?us-ascii?Q?zOuc90cWJSteJc7EB6GuolwmSheSDp4GdTqaw0Ivf1vXLxzszpP68kkVBc+x?=
 =?us-ascii?Q?64dcNS5OJtdeKdyDw+NatiNqmVbkeutpDky0aU01dxkEKtJNmdqKuyisXvau?=
 =?us-ascii?Q?8SFKKTpO75bflOWdoscI+49Ebx44QaRh5Gv3XSw9vNtaSecYrke/5Xh0/qYB?=
 =?us-ascii?Q?1CTd9IQgZwq9FOQzn8KdMp98g8H+kUmxZbrReaK7MZp4IsDzMVEL11SHAJpa?=
 =?us-ascii?Q?9FwVZnhgd6TthgVHpbC8v8YBqrOeoibmAufmgVxL2JhNMef2Zu9iYho1yP59?=
 =?us-ascii?Q?09AMITPoAVwvdQdYWeCIE74wLhHr4s8hXlLvalJak8KHoSPZQil1mXB5LQE+?=
 =?us-ascii?Q?EgwAAPUY+LZw2/6VcsNoyEEithU5pB5iwA9WRtRgKvsB82i0CZCykMYJrhvB?=
 =?us-ascii?Q?Z5yPFdJrLyBZVuGv+SeWcofkpU1ZiAEdgmezP57sZjEKmVn9TrnJkEKnkXMy?=
 =?us-ascii?Q?gxG8n71olCxHllakMri6SUGJTCBYcoDqu+q+865rooeJoEmCRD+AV3U42HFF?=
 =?us-ascii?Q?PUaleGzgRgCzElry+by5kTpKmEjpiBMQVfgtIbF92lrES68SP6MHp+IeGkh+?=
 =?us-ascii?Q?rmGY3EA8HGlFcmwlNpI0oW6yuZ+pHUS4LTmFydm4pkTWy76mUtIf9YqyltF6?=
 =?us-ascii?Q?J2hktgcUVz8kBvauHZNkqP0MBl/ZlliMnAm6a2wk3gndhuSHy+Gb23Yf0bxv?=
 =?us-ascii?Q?L7GV3094YKAGG+mxlK5QHgx1dm+k8kNFORcYIEwi4p7cxEZL/yoVUNzjMoG4?=
 =?us-ascii?Q?LsSqjongEs/CnszfnYWHhwCEKFN9rN7an2/EgTKTJOUtMnteDsMdpXsOJ+We?=
 =?us-ascii?Q?XGh/Al/Erh0Y2IH7mklWFVoR/7gTPxAgXVOpgh2aMhPUeJIZsdXZHeQx5jTd?=
 =?us-ascii?Q?NGb96vNJXcvfxtkG6zuucAH46Yvh6lmDKiB/abe3w/D4YqqsVVbwtWCSExU+?=
 =?us-ascii?Q?rGiCLWvEI2DD8jOoTPekI0rjetA3vzDs5RtTcOmaFgOV+229fZsKE6LZRF/F?=
 =?us-ascii?Q?7dgKuAL/iTQWo88m16LO20r/vNVccjDRX+kkjiyUbSXv9IwQlke+ficFKaNY?=
 =?us-ascii?Q?xmBsag1NNa9catmyoK0FCv+0mVGPMFJmDUEyzS1OMWyegLB+5pawRw3CI7BZ?=
 =?us-ascii?Q?Tb7ljGCq01m+c5FPw4Jyl9xsu1X53dqezr6L6adx9EheWsc4Lk/EWguGHBHm?=
 =?us-ascii?Q?GEQTCAOizxIsln3kAWNOfon51KpPcrMsPxETkAB9Map6Ce4v575B9gc94Ki4?=
 =?us-ascii?Q?40bwkF0U5mvTlv/ejkSUn4XLE2w0Ta7Mf39deLCgNuHNdvJIozQaBmVFCmrc?=
 =?us-ascii?Q?CRt07bXLW4ay4CFnwUrTDig4fUCuQT0NIwa7T/27G4XYUiQnGXwP1qlqAakC?=
 =?us-ascii?Q?ZaLG1R5ejsCpkrdDTrIBCh+KkuuNWKQa1/M7OQOaV/xTFamOug0WFr4j5l4t?=
 =?us-ascii?Q?emAJ1ejGbGYKuUM=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(34020700016)(34070700014)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 21:37:36.3902
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fa8f46d-e338-4eef-aa62-08de166a362e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5805

Fix the PMIC padconfig for AM62D. PMIC's INT pin is connected to the
SoC's EXTINTn input.

Reference Docs
Datasheet - https://www.ti.com/lit/ug/sprujd4/sprujd4.pdf
Schematics - https://www.ti.com/lit/zip/sprcal5

Fixes: 1544bca2f188e ("arm64: dts: ti: Add support for AM62D2-EVM")
Cc: stable@vger.kernel.org
Signed-off-by: Paresh Bhagat <p-bhagat@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62d2-evm.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62d2-evm.dts b/arch/arm64/boot/dts/ti/k3-am62d2-evm.dts
index d202484eec3f..9a74df221f2a 100644
--- a/arch/arm64/boot/dts/ti/k3-am62d2-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62d2-evm.dts
@@ -201,7 +201,7 @@ &mcu_pmx0 {
 
 	pmic_irq_pins_default: pmic-irq-default-pins {
 		pinctrl-single,pins = <
-			AM62DX_MCU_IOPAD(0x000, PIN_INPUT, 7) /* (E11) MCU_GPIO0_0 */
+			AM62DX_IOPAD(0x01f4, PIN_INPUT, 7) /* (F17) EXTINTn.GPIO1_31 */
 		>;
 	};
 
-- 
2.34.1


