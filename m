Return-Path: <linux-kernel+bounces-850030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92838BD1A91
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 08:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A7F63A6CE9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 06:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297B52E3391;
	Mon, 13 Oct 2025 06:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b="cuQYVO+b"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020089.outbound.protection.outlook.com [52.101.69.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAC32BE7BB;
	Mon, 13 Oct 2025 06:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760336727; cv=fail; b=I5TbzpR8vdaZjd6DoEpilKYdOT5rBxl4rsWJf8/s/Q5LpjsbEX1D9KAYGyNrNWFPKYJRiqhPxom4nmGB4amH8/JcUCRLaQRs6gklua49GkBuYm15cp3Esv6k4fTC43M7AS7g1kpyII9qZG8vzW4iolw4d4aJPswg0KBiFUW9E7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760336727; c=relaxed/simple;
	bh=A/DK5DiPOBBXuUihywt0JPYfJFruXz4HseHB/jqp47w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=LnjhL4rvHcoDYRuq+L+jJMqDM9tjSG5lfpevJ3sHKY+3d6PoOPxL+51y1FkHvVyrls16mKV/iuB9AR1zUxOQzxPX9R2e7oncuPwMBO2LK12qeDjgKkF5DGVgay8Kuz8xNOetzjDr1HeWu+fcai8OlzHCSYS0WXBj1d+X+0JgQQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b=cuQYVO+b; arc=fail smtp.client-ip=52.101.69.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qvKESfcU8Siijnop9XFH0M31EqNc70vQVWB0prrvKXJvGApii+vhcRkgUORfMoP9ZfEbzFC4DqMTGEg7bUwJ3nTQLDQ7xBy/UUQ1Fs0gMQ9mGKSO3keG7LnUDLFOAlTaYoOUcTo+fAv7G06kVnYf0lakBoAA7ddKdQoxzg0ng3EboxjqIB2WfEEptK8Of6f5G1RbVEGTcvRNyCA8TCqCAxQRiGH7/O2bye3EVs4G3VXpdVghkmfFFUMm9Vqmyq6ZVtiD/BYFnaQAWpoKHcj9VlEkyrKZXoNW4tDRezcyPr5+nuK+mlzvG47qyO/pGnS7qZAudXs6/1GCJdtiJB6Vmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bVt9p5zRmT0sR8u7UrXiVUSdmnRGwtKjF6aC3ZZLpUw=;
 b=VNMVM3fqkIUBOx8S7SAkdQeQEbfEjXnZTgwf3oBkz6wrS5QmZ4ibcT+hyykx0ut5sdzdWKgSP1obQnMzxtQbE4ltUHP6xISOJqftpUi8n5Zt/jRc4st7sRumeTlotud8Poovyzu4Cxnpvu2Hlf8FlllFbV2whfZJNgBDxPN6B4V1939tdq6L6ZF+qncd2t1tqdvx5GKlT3jcioJuccfAKLvrg2/QYzkbu8mFdGCRFNJmEsB0m2qVvEzl69smPL8mwfp8st1XTJwyFjNdsEXSAwycDdCARO6ASGyYJqflPd+2qjFva+J9Qmv28KU+CnWx3JyG7gmpAjGEmhK+pehXlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bVt9p5zRmT0sR8u7UrXiVUSdmnRGwtKjF6aC3ZZLpUw=;
 b=cuQYVO+bRMI/qZiwLyCxcYMJ4ZxwoydrNvGad+qrp9TaLWTuC3zflCpmeqXBiE9srADGojaANuVM60k+xQxai1x+6lXAehFCcrEpQSX2BlxohKAhvMgbE/hkfOiDfbVq70+0UhuRNAZXibeaCoPMC1Z7zEIKR8nu3z1JE5JxMNMMZKlF2fe+kiEefDCZjrNGq5jOz3dfTcdPMzmIKv5QRqTSSJdSF9mduFJU8WRYBYtZp9BDnjWuBUIXO2Ta9lOBI9FgZZbhmpWreW6fPYAxu8uI8gqfTTZQ5XJItLY/00IbSvheGTsESuJ/U5O53SLRFYwC36zKbUOxbhwbEWw0Zw==
Received: from DB9PR06CA0012.eurprd06.prod.outlook.com (2603:10a6:10:1db::17)
 by PR3P195MB0928.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:a6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 06:25:22 +0000
Received: from DU2PEPF00028CFF.eurprd03.prod.outlook.com
 (2603:10a6:10:1db:cafe::52) by DB9PR06CA0012.outlook.office365.com
 (2603:10a6:10:1db::17) with Microsoft SMTP Server (version=TLS1_3,
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
 15.20.9228.7 via Frontend Transport; Mon, 13 Oct 2025 06:25:21 +0000
Received: from llp-moog.phytec.de (172.25.32.44) by Postix.phytec.de
 (172.25.0.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Oct
 2025 08:25:20 +0200
From: Yannic Moog <y.moog@phytec.de>
Date: Mon, 13 Oct 2025 08:25:07 +0200
Subject: [PATCH v5 2/4] arm64: dts: imx8mp pollux: add display overlays
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251013-imx8mp-pollux-display-overlays-v5-2-fb1df187e5a5@phytec.de>
References: <20251013-imx8mp-pollux-display-overlays-v5-0-fb1df187e5a5@phytec.de>
In-Reply-To: <20251013-imx8mp-pollux-display-overlays-v5-0-fb1df187e5a5@phytec.de>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <imx@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<upstream@lists.phytec.de>, Teresa Remmet <t.remmet@phytec.de>, Peng Fan
	<peng.fan@nxp.com>, Yannic Moog <y.moog@phytec.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760336720; l=7344;
 i=y.moog@phytec.de; s=20250509; h=from:subject:message-id;
 bh=A/DK5DiPOBBXuUihywt0JPYfJFruXz4HseHB/jqp47w=;
 b=vS2nXYZVQHl4I0Jc0i4ivRT5j3tz4uLYr5irAMwyMOoqZNHoZzWBMFhs8M0YAC4Z2LWOdhxzy
 vE57HGIbdJQB5q5mn99TisDVzVzePHv/qvj92qPoM1YcSarLTiGe88h
X-Developer-Key: i=y.moog@phytec.de; a=ed25519;
 pk=rpKoEJ4E7nD9qsrU/rfKVwMTWNWYaTBylZuJUXUiFr8=
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028CFF:EE_|PR3P195MB0928:EE_
X-MS-Office365-Filtering-Correlation-Id: f4819f53-b4c8-44b1-4332-08de0a2149bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OXB5Y25NS2orTXRReDBvdndWeVR0UUlvQ0RMOUIrMVRuUUZIcWJ4a2V1SDQ4?=
 =?utf-8?B?RHNQaDZCem1tcUxSeEdTQVJFS1dxOTUvUWFZUHJtUFVKTFhRd3dzYjNiWmZh?=
 =?utf-8?B?bU9BdmZIM3dobTkxbmpXVG5YZy9pcTRwRzRPbE9RTTZJbk51VysvQnB2czU4?=
 =?utf-8?B?Y21kVVUwbS94Wng1SG9BazU1N1ZPQjUrUVJKTXQrUEVlSStlTWJJM0loRStY?=
 =?utf-8?B?NklCM3pFdlBJTW1zVzloVTkvZGtNSzlFanFTK0ZVZEczeXQ2SVpFN1UrcHdw?=
 =?utf-8?B?OFJOS2RIcERIMXV5NTZGS1FGbnY4YWx4MzVTQmtKV3RGNFJleWtKcWF3ZlVL?=
 =?utf-8?B?WkxCWDZ6Y1VVNHpXRGxScGVyNnF3SjQyYXhVa3lQUitZUGwrZXM1Q0RHVy8w?=
 =?utf-8?B?QVpFZHFYYmFNZFlzcWRpdWNlWjZhYTIrWWx2V09HNXZ4RWljWHpxelJLMkp1?=
 =?utf-8?B?dFhwKzg5elRnSWl0RVlsWnRBY09Ud2oyTzJkQXI2dDhHdjRTb1F5NTVNMjFo?=
 =?utf-8?B?d1dHZmNucHVOMHJRYW8zeWozQUpadmhPeVhnUmZ6L3BUUnJmUmFiQ3RERnNF?=
 =?utf-8?B?K3Rxd1JidWZoaWtJM1FuaHlRRVdLc1FKVnZyR1oxTjlsWjFmdmZMdzQ5Ry9N?=
 =?utf-8?B?NG1NUWNxei9UWWVNVzJ2Y1pDMXV0VkpwQ0ZHcTFVLzV4WURFcUdBNjBwaWV6?=
 =?utf-8?B?bVo5em52cFRsTjRPR3lsVG1CNUk2SE1wSXJyODlvbk5vbFJnOTNnMEhaV2xN?=
 =?utf-8?B?REVrRFF0R0U3cmxUV3dQUWh6M2JqQUJGMHh1Z1VBa2V3Q0tGNDhDOEJxTHI1?=
 =?utf-8?B?blJ3UzE1YUl1TVFJd1hyUm91OXNxVU0va2JVNzhrMDNacjJFVWFxRFpqQ3ZU?=
 =?utf-8?B?UnJNa3hqRE9pTXA2WlYrV0NyZWNpQ056Zm1RS0xiTDFyVlIxaHpIUjkwdnBN?=
 =?utf-8?B?SmFldUVhK1NjRHhQMURpUWx4Nk4ydE9ZVjBVT2RUOUFJd1dIa2NacVpyQVV5?=
 =?utf-8?B?ek1XWlJycWR2WjloaEtmWk5Ca0pGK296STJPTVlSeEQxdVRpYjR3TFRXTzdn?=
 =?utf-8?B?VG1EV2psTUFtT0VTYlcwaVJYNFV2Q3UvYUt5bkNzT0ZyeGFKakV4MmUvU0Rz?=
 =?utf-8?B?Vk1UWnlvSWRUN0IvcTVucHgxYjJPSm5OcStiNTlmdlNVd2FuN2NMcEVWTm93?=
 =?utf-8?B?UTAyTFlHaS81NFZISk5DaHIwV21acUIvM2pRTG85TEFQZjhZQ0I2TlBJbEFa?=
 =?utf-8?B?SzZ4b2dvSGhkYnBqZVZleHpEVWM3cWF3anY3cHN3QlVCWDNaMDBwMkc3VnhD?=
 =?utf-8?B?azFtN21tdkNkc2srdGFTbENydVFKS1M3VklCY3BFbDYvb0owOWtsUnVmOVMy?=
 =?utf-8?B?TGJyQWY1QVZFcGdIc1NJOEZySE5TSUhKS2Zmd21TZitjT2ovY1FzTzRocTdx?=
 =?utf-8?B?NEIxTHBzeTJRbm9aUnlQVmpiVnM2MzIvWXNoN0pzRWc4SkhxNDdOK2RjN1RY?=
 =?utf-8?B?STBQRTVoWFhpVVJwcGo3UDJXVVp1b0d0L3k2Y0pNQWVPTDQ5ZzhRZUdETWp1?=
 =?utf-8?B?Y1JMc1BYVFppYnVSVUhrVWlHZVVEOFBrZTdUeXJVdGJKNllBWmh0MGtmc1Bz?=
 =?utf-8?B?eXord0dDbmNYeWVnRTNwMGlpL3FHRllLVEZmdmsrTFkwd203SDZ2M0Y1RUVm?=
 =?utf-8?B?b3hKMzZEWFpUSERiSUY3VG1TNWlNTHc2ejVrckFaaG5DRUwvVFpQbnZYTmEx?=
 =?utf-8?B?OFNSdjRYZHlwWmVqenlUd2p4NlhxMm5QOUZRdXlSS2FtZFJSQlNtUzUvUDMw?=
 =?utf-8?B?VVkza0JIT2dKRWx4cmtSZHlJQlFvQ2tmTnNhay8vazE3RXVwVzZkSnFNQm5m?=
 =?utf-8?B?TUpiV0JxU0lVdVNsQzBWUTU2YXlNMEpaNUpDT3Fieks4YlliajF2aFpzTHlT?=
 =?utf-8?B?c0xFVGNPc2tIY3FSV0UwUU1lYW80am94WHFTSElnd0pDTU9mOVIvcDIzdUZx?=
 =?utf-8?B?QXpNMVNpdjFibUluREFHQ1FsL1N1STlqK3NuQ3JGSkJsZjh3RVZMQ1FDRmdk?=
 =?utf-8?B?L0poVkY3Qkxia2IwVUhDQ1EwRzQ1Q0taSDMxTmRyT290REJ2VjlQc1k5TzRa?=
 =?utf-8?Q?XX8E=3D?=
X-Forefront-Antispam-Report:
	CIP:91.26.50.189;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:Postix.phytec.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 06:25:21.9936
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4819f53-b4c8-44b1-4332-08de0a2149bf
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29;Ip=[91.26.50.189];Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028CFF.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P195MB0928

imx8mp-phyboard-pollux had a display baked into its board dts file.
However this approach does not truly discribe the hardware and is not
suitable when using different displays.
Move display specific description into an overlay and add the successor
display for the phyboard-pollux as an additional overlay.

Reviewed-by: Teresa Remmet <t.remmet@phytec.de>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 arch/arm64/boot/dts/freescale/Makefile             |  6 +++
 .../imx8mp-phyboard-pollux-etml1010g3dra.dtso      | 44 +++++++++++++++++++
 .../imx8mp-phyboard-pollux-ph128800t006.dtso       | 45 ++++++++++++++++++++
 .../dts/freescale/imx8mp-phyboard-pollux-rdk.dts   | 49 +++++-----------------
 4 files changed, 105 insertions(+), 39 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 23535ed47631ca8f9db65bec5c07b6a7a7e36525..805ab9e5942bc9e2b9776e92412f56e969b6b39a 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -218,7 +218,13 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mp-navqp.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-nitrogen-enc-carrier-board.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-nitrogen-smarc-universal-board.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-rdk.dtb
+imx8mp-phyboard-pollux-etml1010g3dra-dtbs += imx8mp-phyboard-pollux-rdk.dtb \
+	imx8mp-phyboard-pollux-etml1010g3dra.dtbo
+imx8mp-phyboard-pollux-ph128800t006-dtbs += imx8mp-phyboard-pollux-rdk.dtb \
+	imx8mp-phyboard-pollux-ph128800t006.dtbo
 imx8mp-phyboard-pollux-rdk-no-eth-dtbs += imx8mp-phyboard-pollux-rdk.dtb imx8mp-phycore-no-eth.dtbo
+dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-etml1010g3dra.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-ph128800t006.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-rdk-no-eth.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-skov-basic.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-skov-revb-hdmi.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-etml1010g3dra.dtso b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-etml1010g3dra.dtso
new file mode 100644
index 0000000000000000000000000000000000000000..7a7f27d6bb1be6364cbab5d2fe45a365c7680fa8
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-etml1010g3dra.dtso
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (C) 2025 PHYTEC Messtechnik GmbH
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/clock/imx8mp-clock.h>
+
+/dts-v1/;
+/plugin/;
+
+&backlight_lvds1 {
+	brightness-levels = <0 8 16 32 64 128 255>;
+	default-brightness-level = <8>;
+	enable-gpios = <&gpio2 20 GPIO_ACTIVE_LOW>;
+	num-interpolated-steps = <2>;
+	pwms = <&pwm3 0 50000 0>;
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
+&panel_lvds1 {
+	compatible = "edt,etml1010g3dra";
+	status = "okay";
+};
+
+&pwm3 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-ph128800t006.dtso b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-ph128800t006.dtso
new file mode 100644
index 0000000000000000000000000000000000000000..a39f83bf820490cf946849413cc968f9b0a86c96
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-ph128800t006.dtso
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (C) 2025 PHYTEC Messtechnik GmbH
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/clock/imx8mp-clock.h>
+
+/dts-v1/;
+/plugin/;
+
+&backlight_lvds1 {
+	brightness-levels = <0 8 16 32 64 128 255>;
+	default-brightness-level = <8>;
+	enable-gpios = <&gpio2 20 GPIO_ACTIVE_LOW>;
+	num-interpolated-steps = <2>;
+	pwms = <&pwm3 0 66667 0>;
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
+	 * 66.5 * 7 = 465.5 MHz so the LDB serializer and LCDIFv3 scanout
+	 * engine can reach accurate pixel clock of exactly 66.5 MHz.
+	 */
+	assigned-clock-rates = <0>, <465500000>;
+	status = "okay";
+};
+
+
+&panel_lvds1 {
+	compatible = "powertip,ph128800t006-zhc01";
+	status = "okay";
+};
+
+&pwm3 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
index e97d1d7c629b7fc4b52931868e35cb2d98434513..9687b4ded8f4c98fe68bcbeedcb5ea03434e27a3 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
@@ -7,7 +7,6 @@
 
 #include <dt-bindings/phy/phy-imx8-pcie.h>
 #include <dt-bindings/leds/leds-pca9532.h>
-#include <dt-bindings/pwm/pwm.h>
 #include <dt-bindings/thermal/thermal.h>
 #include "imx8mp-phycore-som.dtsi"
 
@@ -20,16 +19,12 @@ chosen {
 		stdout-path = &uart1;
 	};
 
-	backlight_lvds: backlight {
+	backlight_lvds1: backlight1 {
 		compatible = "pwm-backlight";
-		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_lvds1>;
-		brightness-levels = <0 4 8 16 32 64 128 255>;
-		default-brightness-level = <11>;
-		enable-gpios = <&gpio2 20 GPIO_ACTIVE_LOW>;
-		num-interpolated-steps = <2>;
+		pinctrl-names = "default";
 		power-supply = <&reg_lvds1_reg_en>;
-		pwms = <&pwm3 0 50000 0>;
+		status = "disabled";
 	};
 
 	fan0: fan {
@@ -42,10 +37,11 @@ fan0: fan {
 		#cooling-cells = <2>;
 	};
 
-	panel1_lvds: panel-lvds {
-		compatible = "edt,etml1010g3dra";
-		backlight = <&backlight_lvds>;
+	panel_lvds1: panel-lvds1 {
+		/* compatible panel in overlay */
+		backlight = <&backlight_lvds1>;
 		power-supply = <&reg_vcc_3v3_sw>;
+		status = "disabled";
 
 		port {
 			panel1_in: endpoint {
@@ -231,32 +227,8 @@ led-3 {
 	};
 };
 
-&lcdif2 {
-	status = "okay";
-};
-
-&lvds_bridge {
-	status = "okay";
-
-	ports {
-		port@2 {
-			ldb_lvds_ch1: endpoint {
-				remote-endpoint = <&panel1_in>;
-			};
-		};
-	};
-};
-
-&media_blk_ctrl {
-	/*
-	 * The LVDS panel on this device uses 72.4 MHz pixel clock,
-	 * set IMX8MP_VIDEO_PLL1 to 72.4 * 7 = 506.8 MHz so the LDB
-	 * serializer and LCDIFv3 scanout engine can reach accurate
-	 * pixel clock of exactly 72.4 MHz.
-	 */
-	assigned-clock-rates = <500000000>, <200000000>,
-			       <0>, <0>, <500000000>,
-			       <506800000>;
+&ldb_lvds_ch1 {
+	remote-endpoint = <&panel1_in>;
 };
 
 &snvs_pwrkey {
@@ -281,9 +253,8 @@ &pcie {
 };
 
 &pwm3 {
-	status = "okay";
-	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm3>;
+	pinctrl-names = "default";
 };
 
 &rv3028 {

-- 
2.43.0


