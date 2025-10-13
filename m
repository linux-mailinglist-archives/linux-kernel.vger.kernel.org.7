Return-Path: <linux-kernel+bounces-850032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5D7BD1AAF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 08:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5E24D4EF012
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 06:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969062E6CCC;
	Mon, 13 Oct 2025 06:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b="GkNR7fxD"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023142.outbound.protection.outlook.com [40.107.159.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243862E2F13;
	Mon, 13 Oct 2025 06:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760336731; cv=fail; b=f8uPuiE0aDNIcEKVjp/UtVUOXqGhhrb98MqAS3MCp6kwxmUqR6SM55w+5QRp/qeAAtMpLUozrIGKsYqLXpl2l5Y1bMpi0tb6CdVEQwwGKyGcZ/hWmrvXqkQbyVNAo25CUCR4wc4Qbx5gx/dmAQ+fceIUjrOnIx/X/Tjs037F5F4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760336731; c=relaxed/simple;
	bh=x++DNtZF/1iLiSvVP9a9NPYM5180NY0EiUvCzVS68as=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=p+2hl5j3iyY/idGZgrHZw/tv38PBi8xjJMs3Yd/Gew2QSV4V/f4OIrIs9ejW0M5zFa8z2l/D17/N36ZIcyLkXFskunyGm6Kh90oVUc4/aWl7wEgOEqMlbOgrasVREEPnIg8kpXvbJ1zNp05A0ocUuRZD1IKnS6NvcjBzo/32FHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b=GkNR7fxD; arc=fail smtp.client-ip=40.107.159.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rplH9/TGwhQ3aTiGk4seGYZ1BKx819CUpyWsLHfSe7kAyZ77jZ3AvAIXavkhzBwIgP45xyxOGtKOHPx9Fc0YklTx6ehatDeaoTZloFF5io/RJ5k0O9zfm/dLKwfsqC1nPHPiEEb76XhNajn0kqUDOVAlHZO8X8tF0IKE9xKhDOIQvseKqGPkY21W7ij4XxbNzF4Xk+jyarO+fW3NWLu28tlZZ/TZcN9B6fNsMUysnW2OdXTDxiLXn7YlZnwD7Hniu+jw1iIGHY1uyMUjsSG8jmhPtClH/iDCCrPiyXOBkQUDffwotShvmxYU7MjMVMnA2krn9NA4Hl9CFyTY1rNixg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bX2aDp/1YwBr06HSDsl5janIxUeeWSN/bNMqRhHLb9A=;
 b=gRaVO5/AWdtS+n3h/4UbRs2vUnAypiXUPBJEaegv9VhiqgDt+NpL8k/mop5D4fykCQyjKYpVg+rQrFjUxRwzIjF1oOjJSQ/bFRNxl3gNvmjk7MkHMe4R+lfxSm+0pDKonH4GlGe9GbFhjGpAMt4JhYqucHYg0Fof1C9cRiyybQGcYO8UsK3dsCk1VH4QMjkMGTDZg41Y9e0fzmTJYEuwSFehvUdtrqhbdDYfi6dIwmtTFGecINn73/gyY4innkoLxfdaAMB2oIyY99gFNH4YtD0XDTJ5IW00IWpb5eF6aDYb+IgV4JOa6pw1UdLnVpCCVwpRdHig1WolFHAkljTvDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bX2aDp/1YwBr06HSDsl5janIxUeeWSN/bNMqRhHLb9A=;
 b=GkNR7fxDpFuNgC+qxyzoEUDNhLPqK+tEyJTEe4X6/PwMjSdo/IOeok22FduQZt1rb0+1AOJcF3xuFs5r2GcE6X34cVReBda5j/P7PnEuotwc1d6OEq4iBrnzgzJvCmwUgEPlsmTx2zlZNH43TEvDqyBxvW0+oxy7N3P7DJvMdCXjpxJw/yfGMD3WdMJf1TYookGI4KY7rwv0rPETpsZmQtjElJ5UwG4Qn+6qMNPKSjYkDVPJY5y06/ECuV3d95uDrJLkgLAnzpI/Ss6gjf7JFIgSV9fuK/dKQSDQX18O8b7+1u3t6lStJ6xUeusI/MsAPwwYcYndQ05520FQMh8wYg==
Received: from DB9PR06CA0009.eurprd06.prod.outlook.com (2603:10a6:10:1db::14)
 by VI0P195MB2737.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:2c2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.11; Mon, 13 Oct
 2025 06:25:23 +0000
Received: from DU2PEPF00028CFF.eurprd03.prod.outlook.com
 (2603:10a6:10:1db:cafe::1d) by DB9PR06CA0009.outlook.office365.com
 (2603:10a6:10:1db::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.12 via Frontend Transport; Mon,
 13 Oct 2025 06:25:22 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 DU2PEPF00028CFF.mail.protection.outlook.com (10.167.242.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Mon, 13 Oct 2025 06:25:22 +0000
Received: from llp-moog.phytec.de (172.25.32.44) by Postix.phytec.de
 (172.25.0.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Oct
 2025 08:25:20 +0200
From: Yannic Moog <y.moog@phytec.de>
Date: Mon, 13 Oct 2025 08:25:09 +0200
Subject: [PATCH v5 4/4] arm64: dts: imx8mp pollux: add displays for
 expansion board
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251013-imx8mp-pollux-display-overlays-v5-4-fb1df187e5a5@phytec.de>
References: <20251013-imx8mp-pollux-display-overlays-v5-0-fb1df187e5a5@phytec.de>
In-Reply-To: <20251013-imx8mp-pollux-display-overlays-v5-0-fb1df187e5a5@phytec.de>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <imx@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<upstream@lists.phytec.de>, Peng Fan <peng.fan@nxp.com>, Yannic Moog
	<y.moog@phytec.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760336720; l=5320;
 i=y.moog@phytec.de; s=20250509; h=from:subject:message-id;
 bh=x++DNtZF/1iLiSvVP9a9NPYM5180NY0EiUvCzVS68as=;
 b=rXX0alu5K2xPMzmPdV0hvPSQhAKGR7Omn0bAoz2cOg2/zPAse7M0Sb2w5bBxLy7h86UJchGFd
 3wetpPJdubUCwbnpZfr8fRVq9fv9QaFCTs8vNAzHNfm0ZRtujhReWiU
X-Developer-Key: i=y.moog@phytec.de; a=ed25519;
 pk=rpKoEJ4E7nD9qsrU/rfKVwMTWNWYaTBylZuJUXUiFr8=
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028CFF:EE_|VI0P195MB2737:EE_
X-MS-Office365-Filtering-Correlation-Id: 795d1298-5edb-4327-7a4c-08de0a214a43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RzhDVzhxN3Z0RE45UzQvOGxuL3pnTVhCT2lXaGFySjVlRU5NZXZOR0lLOHFO?=
 =?utf-8?B?MWIyRTl1RjhWYkxpaytEYmw5S1N3M21qOFZpMEFsaEdvOUVvcWJLMGsveTl1?=
 =?utf-8?B?WlpsQ3pRN01xUWhLbnB3ZXVCcGRUcVViVnJXdFhrc205eXdIOWozTEcxL1kz?=
 =?utf-8?B?SnlheGpNSVB3cytqZmJjRmlMVlpySUNHSUJ6SXdCREtzQ3JFdWQvY1orSzBI?=
 =?utf-8?B?L29CTFNxbU9NUDlia2hjWUhYRFcxZ0RVem9CdmFlRTB4R0xvSW8xRnFyVmgv?=
 =?utf-8?B?YjRvSVBiKytUaVpncWwrUzRGVy93OVRPQXcxdmYySWZiSVQ1M3J2MFByRmNl?=
 =?utf-8?B?eXZuMFNqNDBBVmRyMzVSTDlMOGQ4cEtkdTlwVDlPbE1wSG80OUJNcGtpS1Zx?=
 =?utf-8?B?cVpwaWhTc1UvdmR6d2MzMG5qYVVsU3VDa3hORGFndmc5Z0Uwc3pRSkdyRDcx?=
 =?utf-8?B?NVo4ZVFkc1o1L1U3VHJaZ0NranlMNDlvUUgxbzZWNUxodXBjeEZMYll5OWFn?=
 =?utf-8?B?NXlodHBlcGFOc3RMRS9ISHhoOWVUQUszd1JtWHRrZ1pmdER0VnpacVdGbTRO?=
 =?utf-8?B?OHF5ZWhEQ1lTNHBEZzRsOVlHSDlwdUFEc3BrbVVoVFZZREVJSnBTU3pBNlB6?=
 =?utf-8?B?RUpDVUg2YUZHZXJjbkV4TkpYU2ljaFNpTFA4dEFJTnJNdTUzeDRRSk9udWgr?=
 =?utf-8?B?bDFxK0ppSlp2SW81ZDJOektmMGhKZGZmVGhOWjBrck5DaS9HMWtiaUdCOEhF?=
 =?utf-8?B?dzRaNUxlVndlUWVDRDBDODNDK0lnbmZiTCtRejZpR1ZjRThyckZHczJkWFRi?=
 =?utf-8?B?Mk1HMTNRby9rYlZkSEswbHJ5VHkxRy9XSGNvbVJCNnBmbXJjSDlvTm80RmU0?=
 =?utf-8?B?bS93TkJxcFloMmpyTFdPd0IxUVVMeWVVL3VSSlJsRTYzNXpMU21JS3NVOTVW?=
 =?utf-8?B?TVYzL2o3RytTZEVRK0h2S0RTakpnR2xGanV3bld4THprUmVJc0svYlc5NGR4?=
 =?utf-8?B?TmFVak9YSFpza2JJU0VJaFRaRTRudFpKR0NzeFBDUWJOOW1ieW8wRDJ5dGVU?=
 =?utf-8?B?dFNiNFloQ09DcXkyalIwRGpNck4rZnhWU3BsVkp0VldEQzdxWjF6NnV4RW9E?=
 =?utf-8?B?SnBYb2VJMHpDL2d0a3ZCdmU3QnZnczJENFQvYmRobDBqaUV6dWtZcmwvemYx?=
 =?utf-8?B?b0NvRUFtUTF3TWJ1Y3ZIT2FzYlpWQ3NHMUl6bHQwQjNXTVAwdzhIWW8zN0ZD?=
 =?utf-8?B?eTBSdXVybWdROEVTN0NNbndaMzBBN3ZPNDhJaDNEQTJUKzZqRGVkTnNZbWlW?=
 =?utf-8?B?YWdTYWExaWJ2Z1Y2ellEdlZ6c0dSbHk1amFlUFFiakh3enBRTXpQS3RkY3BR?=
 =?utf-8?B?N2EyQkRMNUh5ZnVJNzZFNThzU0NpMUxoL1pndHlKQkhhVU16SExwbUdEZHZl?=
 =?utf-8?B?U2hWY3hXendpNjNNMFJ5U1Fua1ZmT0VXQjQ0bzZYSW80NlVudlVvR0xSOGVL?=
 =?utf-8?B?NitRbitDTmtVVFI5dmNPQ3VrdGVnOGZ0MWdEOVN6VTQ1N2lFaU5xUHZLNTV3?=
 =?utf-8?B?WHNsNnJCdml6UE04N2tnLzFnQ3JyTG5TNkV6L3JoQks5R0hmOFQxdEl2WjY4?=
 =?utf-8?B?Y0pULzdsd0ZFTkdUcGFxejFHdzZpMXNZRjQzM1pKY2xONlNyNzlFblJzbHFT?=
 =?utf-8?B?NEdKVkpHODZwY3A4TlgxY1gyVFFPMEw0aWkreUZETHlSOWwxY0ZRV3oxdVRu?=
 =?utf-8?B?S2lmMEF3cGVvWmU3SGlmWlRnZmVSRVhwbjdTWFNsR3R5TStvV0QzTzJYUDNP?=
 =?utf-8?B?OGtHalZQbGZFVTQyaFdidGQ3M25jazM1eTcyZmtFNXRXSEdMK3V0enA4bVFk?=
 =?utf-8?B?TFRmck82ZDVmNmVpQ0krbCtBdGFtV0l5WTdGcnBUc3Z6Z0xlVWZRUHcyL21U?=
 =?utf-8?B?bHU0NThraURPTFI3d0x2MlY1eXdQZ3FXbjN0WEd3RzJhV2hyYkNBY0xpTW5I?=
 =?utf-8?B?MHdnMW9kU3MxUjhuWTRYY2FCa0x1ZTNKVDJzZkJVa3duaXdjKzV0c0dyaXk5?=
 =?utf-8?B?Mng5SVAzVlN0ZHc0VGdHaVZFdmZQRjNwcE9UYUNxbTlkemdTZTBjVU1FRmVy?=
 =?utf-8?Q?G52I=3D?=
X-Forefront-Antispam-Report:
	CIP:91.26.50.189;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:Postix.phytec.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 06:25:22.8555
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 795d1298-5edb-4327-7a4c-08de0a214a43
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29;Ip=[91.26.50.189];Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028CFF.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0P195MB2737

The same displays that can be connected directly to the
imx8mp-phyboard-pollux can also be connected to the expansion board
PEB-AV-10. For displays connected to the expansion board, a second LVDS
channel of the i.MX 8M Plus SoC is used and only a single display
connected to the SoC LVDS display bridge at a given time is supported.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 arch/arm64/boot/dts/freescale/Makefile             |  6 +++
 ...mp-phyboard-pollux-peb-av-10-etml1010g3dra.dtso | 45 ++++++++++++++++++++++
 ...8mp-phyboard-pollux-peb-av-10-ph128800t006.dtso | 45 ++++++++++++++++++++++
 3 files changed, 96 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 9c121041128972d2239e2cc74df98b0bf7de1ac2..e4b097446440f41785dd1a0e5d354796e800ee76 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -222,11 +222,17 @@ imx8mp-phyboard-pollux-etml1010g3dra-dtbs += imx8mp-phyboard-pollux-rdk.dtb \
 	imx8mp-phyboard-pollux-etml1010g3dra.dtbo
 imx8mp-phyboard-pollux-peb-av-10-dtbs += imx8mp-phyboard-pollux-rdk.dtb \
 	imx8mp-phyboard-pollux-peb-av-10.dtbo
+imx8mp-phyboard-pollux-peb-av-10-etml1010g3dra-dtbs += imx8mp-phyboard-pollux-rdk.dtb \
+	imx8mp-phyboard-pollux-peb-av-10-etml1010g3dra.dtbo
+imx8mp-phyboard-pollux-peb-av-10-ph128800t006-dtbs += imx8mp-phyboard-pollux-rdk.dtb \
+	imx8mp-phyboard-pollux-peb-av-10-ph128800t006.dtbo
 imx8mp-phyboard-pollux-ph128800t006-dtbs += imx8mp-phyboard-pollux-rdk.dtb \
 	imx8mp-phyboard-pollux-ph128800t006.dtbo
 imx8mp-phyboard-pollux-rdk-no-eth-dtbs += imx8mp-phyboard-pollux-rdk.dtb imx8mp-phycore-no-eth.dtbo
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-etml1010g3dra.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-peb-av-10.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-peb-av-10-etml1010g3dra.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-peb-av-10-ph128800t006.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-ph128800t006.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-rdk-no-eth.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-skov-basic.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-av-10-etml1010g3dra.dtso b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-av-10-etml1010g3dra.dtso
new file mode 100644
index 0000000000000000000000000000000000000000..aceb5b6056ef1298ad9e105e673c7ab403411ab0
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-av-10-etml1010g3dra.dtso
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (C) 2025 PHYTEC Messtechnik GmbH
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/clock/imx8mp-clock.h>
+#include "imx8mp-phyboard-pollux-peb-av-10.dtsi"
+
+&backlight_lvds0 {
+	brightness-levels = <0 8 16 32 64 128 255>;
+	default-brightness-level = <8>;
+	enable-gpios = <&gpio5 1 GPIO_ACTIVE_HIGH>;
+	num-interpolated-steps = <2>;
+	pwms = <&pwm4 0 50000 0>;
+	status = "okay";
+};
+
+&lcdif2 {
+	status = "okay";
+};
+
+&lvds_bridge {
+	assigned-clocks = <&clk IMX8MP_CLK_MEDIA_LDB>, <&clk IMX8MP_VIDEO_PLL1>;
+	assigned-clock-parents = <&clk IMX8MP_VIDEO_PLL1_OUT>;
+	/*
+	 * The LVDS panel uses 72.4 MHz pixel clock, set IMX8MP_VIDEO_PLL1 to
+	 * 72.4 * 7 = 506.8 MHz so the LDB serializer and LCDIFv3 scanout
+	 * engine can reach accurate pixel clock of exactly 72.4 MHz.
+	 */
+	assigned-clock-rates = <0>, <506800000>;
+	status = "okay";
+};
+
+&panel_lvds0 {
+	compatible = "edt,etml1010g3dra";
+	status = "okay";
+};
+
+&pwm4 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-av-10-ph128800t006.dtso b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-av-10-ph128800t006.dtso
new file mode 100644
index 0000000000000000000000000000000000000000..559286f384be452f1c953689e03249fbea24fac5
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-av-10-ph128800t006.dtso
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (C) 2025 PHYTEC Messtechnik GmbH
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/clock/imx8mp-clock.h>
+#include "imx8mp-phyboard-pollux-peb-av-10.dtsi"
+
+&backlight_lvds0 {
+	brightness-levels = <0 8 16 32 64 128 255>;
+	default-brightness-level = <8>;
+	enable-gpios = <&gpio5 1 GPIO_ACTIVE_HIGH>;
+	num-interpolated-steps = <2>;
+	pwms = <&pwm4 0 66667 0>;
+	status = "okay";
+};
+
+&lcdif2 {
+	status = "okay";
+};
+
+&lvds_bridge {
+	assigned-clocks = <&clk IMX8MP_CLK_MEDIA_LDB>, <&clk IMX8MP_VIDEO_PLL1>;
+	assigned-clock-parents = <&clk IMX8MP_VIDEO_PLL1_OUT>;
+	/*
+	 * The LVDS panel uses 66.5 MHz pixel clock, set IMX8MP_VIDEO_PLL1 to
+	 * 66.5 * 7 = 465.5 MHz so the LDB serializer and LCDIFv3 scanout
+	 * engine can reach accurate pixel clock of exactly 66.5 MHz.
+	 */
+	assigned-clock-rates = <0>, <465500000>;
+	status = "okay";
+};
+
+&panel_lvds0 {
+	compatible = "powertip,ph128800t006-zhc01";
+	status = "okay";
+};
+
+&pwm4 {
+	status = "okay";
+};

-- 
2.43.0


