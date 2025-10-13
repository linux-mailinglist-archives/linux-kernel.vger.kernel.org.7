Return-Path: <linux-kernel+bounces-850029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A338ABD1A7C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 08:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 28247348234
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 06:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA382E2F0D;
	Mon, 13 Oct 2025 06:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b="tPwroO/c"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020098.outbound.protection.outlook.com [52.101.84.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFC72D6E58;
	Mon, 13 Oct 2025 06:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760336727; cv=fail; b=d/fV+5dDB6aXnljpOOP1kBeqaqo4YwGuKL+dih9w5hiEPdaeUaziVeUoP0X05qZqmhf0onjmPWUitSr5p8JGStgifnMxMoxFoUC4iLah7O2rHXkhdttvFnOM0se81Y3+RqBFt5B0egnjKM91P+cNETXztHMCLw7bgQqE1skru30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760336727; c=relaxed/simple;
	bh=YI1bJ3pSiBaOhKbbbAPOtPIW3lExEaL3zjzmOlbzi5E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=GA+xXD46+wl/pLMCdBm0Ha5oNXqYp+Io6249aRN6n0EaTOZUgvrcjYa1Ci+eXcTlV7nzy649YFQThZ0hT2o5Q68NDG4+b5ELHd5O0CWZlUZP3DQXqnj2b5ZtaxVpuw4pnLXNFaAEsOD4CArgCH9moJeM01NyBee7nCwEhC0QGOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b=tPwroO/c; arc=fail smtp.client-ip=52.101.84.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AUgjfSFUE3jkYulZ/S6/VZblW9gd5W04FXQ+UkYgn85C8L4VSaN3WaR4Usg5/F20EJ2TTbNaQzXOJdx4z8ammhtKhUEoVMazTjPuf/wUrDu8qSXxWnTDV18x1oniuuiXWbDQe6WHyeAtNBYnr0CdTpjRuFWCw5wn+1sHQMr2zHbgXmzsLDSGvoJHQPII3WuCaGZ+uoETTRy0aRjL7sNnsH9grLTJi11XuDd2XgLwgdn4bj323hF7EbHnzGcaIs3f6abbzM26sAIiXdk+PzWSAZK2hDrGkp0Y3cdGg1oydFv/mZSCCQqb20vFZkFdxSYat/w7eRqV3OiMcxuiI69XvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pyZkqBN1QzLHr1/3yPhRuKf2KVlglDttpZXi9XI8a+A=;
 b=njcEbTZ6SJHt2Fv+D0pKhQBjsoSXoRNWZrInUPW0ka8e+v4I0+cJUu7oAmAZoP6XszPDsuU9r9c7/ALUJhFgLVHWQenqYlIIJtwqP96UhHYPvg91jguYfbm8CEwsLXFIGupmp4q4J6+OOF2lyzJV+hxNRs2/qz5vEHjOnagSj3Ff7S4IiLCFcip/toNxGAWqJkxA251M5JtcLNJ2WDJyl8R3g5HKMUJ/yDSez+u6xr8L1yLdSd8nnaoU5814zoLQjSvEMXeCUbTCyBLfes0bHPaQfsuFPQIPolSvL0ktK37IvbUjYhaVdffSFivREZTAoaXaZ9GNspIyGE2p/eDnxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pyZkqBN1QzLHr1/3yPhRuKf2KVlglDttpZXi9XI8a+A=;
 b=tPwroO/c3PYqEx0mlIci/QZFoNpsOiBrQaItbjWT2nO6uO2VAnUfeLdJ9GTzl/dikrtykxm0Hec3Yli+bEL3rJYTFe+p3LWtcax7K4gxiyp+y48Q9XbgWLqkfWPqeV0N0hWommAd0Bf185tgx78m0zYqwcFWeqJCN5bP36MJX7mo05Yr8b95QScPdVbRYHqzZSTybM6bow4FZ/pLg9sy6sfVE9lrWen+bx9w+fYgkWZl4UYRIVDwQO/KsJrOIpGT0iGh8pxIiiWZhvzf6QmB+uJRoXn2SoHe/AFe3Myi4TQ9Aq5QhzBUmCxvXTUcca25hJe+V5d1pSx3TZShAGCnUg==
Received: from DB9PR06CA0002.eurprd06.prod.outlook.com (2603:10a6:10:1db::7)
 by AS4P195MB1670.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:511::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 06:25:22 +0000
Received: from DU2PEPF00028CFF.eurprd03.prod.outlook.com
 (2603:10a6:10:1db:cafe::19) by DB9PR06CA0002.outlook.office365.com
 (2603:10a6:10:1db::7) with Microsoft SMTP Server (version=TLS1_3,
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
Date: Mon, 13 Oct 2025 08:25:08 +0200
Subject: [PATCH v5 3/4] arm64: dts: imx8mp pollux: add expansion board
 overlay
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251013-imx8mp-pollux-display-overlays-v5-3-fb1df187e5a5@phytec.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760336720; l=8001;
 i=y.moog@phytec.de; s=20250509; h=from:subject:message-id;
 bh=YI1bJ3pSiBaOhKbbbAPOtPIW3lExEaL3zjzmOlbzi5E=;
 b=uKuhDukL7HrF6gqqys1qp5ALtjKCQKfGgtbznrmUywc2CISbJCEEns29qKV02/BxndII0pwxM
 SLBT8YN85KmBf568aGLpFnEDfG/lwCN0WIHSDCGNe9ReVmVrJSNBW9x
X-Developer-Key: i=y.moog@phytec.de; a=ed25519;
 pk=rpKoEJ4E7nD9qsrU/rfKVwMTWNWYaTBylZuJUXUiFr8=
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028CFF:EE_|AS4P195MB1670:EE_
X-MS-Office365-Filtering-Correlation-Id: 77d0fc3d-0330-4d5c-ca93-08de0a2149f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M1NkanpHczF2UHNUT0phK01oNnBRSUQ3QWwzZFpxd1AraWJxR0d6NmVVRTVa?=
 =?utf-8?B?Qk01aVZpUS8zYWhNZkZxL255d0tMbEZiNi8xbStrWXc4ODdWQThoS0MwVUY4?=
 =?utf-8?B?U1dVTjgyZ28vMExXZ2h6cXZiaEFGY0NSWEFZTm1Hc0VRQWo1Wmp4OHVlSDJH?=
 =?utf-8?B?RklRTTZiVFNLS1FnblhwZmVMa2hKeEZWM3QrdnBUUkhnM1F6NlJZTnBpdTI4?=
 =?utf-8?B?cWh2Qi80TTUwUExtbDRlanFSR09Od2FVWlZLdFIzc3haRE1YMDhaWE1Hdi9O?=
 =?utf-8?B?bE9YSDdYb0trRlpqWGJSOEowK05iZmNzeTZWYzYxWjUwcTNORmtGVFNjV3lV?=
 =?utf-8?B?NExvSzRMV3Fza1hmNGdyT2QydUtuZEtLV1ZWTmM1clQ2bmNNMkxJeUp5T0pR?=
 =?utf-8?B?SjVFb1k5MTh3cWEraDMwTnoyU1FaelRodFRpeFN0WmlGcDhCM09BM3dWVkRC?=
 =?utf-8?B?TVBlRUdTSU1ITHFEQWtRUlczakltVnBQTC9aVVNVdjhEVVcvaGZyYk5HLys0?=
 =?utf-8?B?SUxGbkVSbEZOUk94M0d5MHg1am5IK3IvUU1yZzV2cU5KbnhGeTd5aWo4NG1q?=
 =?utf-8?B?NGFVdXZ5c3p4T2xVRHlaSVljYzA3K1FVeEoxZ0xEazY1anZ3aTRob3l2L0lW?=
 =?utf-8?B?dXVWUk9RN3BiTTNJYkhrZkNEZzV0MVpNVUxuMmJQNEZ2UDFHVUxkQ1ZvOHdY?=
 =?utf-8?B?YjEySUlTOUdiUWI2bFFjaEorLzJmRGRzaVFjc21ScjJiWmNEL3hLdVd4Ymxi?=
 =?utf-8?B?SUhlZnE5cyttNWV5RjRnQWRPdTgyK0o3aElFMGREVEd3czh3TkpkQktLWDB2?=
 =?utf-8?B?NjBtSWtkT25JVmJMamNBdjhtWDNKNUlud2lVM1EwcGVFb2p4NGFKbkJsbXVI?=
 =?utf-8?B?VE83MVI2VlpVanNycHdaTWRDTnB2THFHc1VJcTFoU01iNmVlWTRJbnRTdDlN?=
 =?utf-8?B?TE5na2NKeXBMNzZmVVNkNi9DTmpJdGZOMjhEQzNtSzh1YWxlMlhKdUQrYnN3?=
 =?utf-8?B?R1VGNm1VV3Q3RStOWmtoTURBNjFlSUFGV3hnRWgwVWtuaFRPZkp0c2tUZkNS?=
 =?utf-8?B?WjJmdHoyQ2xia3ptY2REM1VteGhSemNYWHFnSkRhbDkydFpBUEdpdE1XaFNu?=
 =?utf-8?B?WXhvdDJrT3hwbkRzQ2NnNzZKYWI4LzlUNHp4RFhnNDBFeW0zQ0w5ZTV3VXN1?=
 =?utf-8?B?cm16SWE0cEV6T2JaY0hpM3UrWGJUMFdMWGlXVjA1bGhjMWE4VUZSaDJvbWZw?=
 =?utf-8?B?QjM5bEttUTF2RFFzWFlZK1VIaDJxOFN2VDdrVmkxM3BEdXZHTmwwbCtZSHA5?=
 =?utf-8?B?T0o1RXNQQVBTWFRLL2hSN012YTVLSmx5VFRyUXBJWkFlMVBXOXRPMHoxNzZT?=
 =?utf-8?B?QWVlWHhVYVJJa25RUjZMVmlVYUw3azJnWWNUZEhqNmQ1VFpDWk1aL3ZuQ3Vu?=
 =?utf-8?B?THo0S2ZTTjFOeVFwOWJsRmZBRHduSDJnK1VibituRHo0VnBrS1lWZEhFL1RU?=
 =?utf-8?B?cU0ycE0wcDlWdnpIL1MzbFZRTXNBaEMwaEZSdE1VNWFBem54V2hWTldEZ2hD?=
 =?utf-8?B?UVgrTURMZ1QyOXpzaHVQWlFJaXdvOXRMTGNpRWpjckV6Y2FJR09lL2pKVFBL?=
 =?utf-8?B?M1hpUjlpeFlPZG1lTVVzeDBGNitjbVNMVFFUUThqMEhHbWVlL09kVVN2VG4z?=
 =?utf-8?B?WU9xNU5Ock5Cc2VUY3FoTmIwOGNtQ1BqYzVDK093N0crczJ3bWg3dUIzNmNh?=
 =?utf-8?B?T1VRYkpXem1ROTZZdWlkYjdobUxRRkdMNkJpSXA1VDhGTmpVN3hCWUhwUndz?=
 =?utf-8?B?SVhnWUtHUFhFcSt1elpCY0tjUVZHWk9LcjN4M29iZzIxVHVPR3gzZkZUNmxj?=
 =?utf-8?B?YVZKdWtKVmRpS05FbUNiUWZwUjBpRDZiSmxtRkJTQXkvcVFOdFRhaEpJMmVl?=
 =?utf-8?B?cEhqYUVLTE1Qakd5N2tzbHFFcFdlbWRxc0dKbDVWRGVZVzNNd0tpR3JHdS9W?=
 =?utf-8?B?QVhZL1lheVlMSElBcDdXUUROYkNsdXFNMHdvSkd4TStwaTQ5NlE4V0tkbk9Y?=
 =?utf-8?B?VTFQZnBYTHcwWERIdnRTdUY3RnJWRTY3U3VlMEE2Ymt0M3k4ejQ1NCtGZGI2?=
 =?utf-8?Q?8yn0=3D?=
X-Forefront-Antispam-Report:
	CIP:91.26.50.189;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:Postix.phytec.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 06:25:22.3383
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77d0fc3d-0330-4d5c-ca93-08de0a2149f3
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29;Ip=[91.26.50.189];Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028CFF.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P195MB1670

An expansion board (PEB-AV-10) may be connected to the
imx8mp-phyboard-pollux. Its main purpose is to provide multimedia
interfaces, featuring a 3.5mm headphone jack, a USB-A port and LVDS as
well as backlight connectors.
Introduce the expansion board as dtsi, as it may be used standalone as
an expansion board, as well as in combination with display panels. These
display panels will include the dtsi.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 arch/arm64/boot/dts/freescale/Makefile             |   3 +
 .../imx8mp-phyboard-pollux-peb-av-10.dtsi          | 196 +++++++++++++++++++++
 .../imx8mp-phyboard-pollux-peb-av-10.dtso          |   9 +
 3 files changed, 208 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 805ab9e5942bc9e2b9776e92412f56e969b6b39a..9c121041128972d2239e2cc74df98b0bf7de1ac2 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -220,10 +220,13 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mp-nitrogen-smarc-universal-board.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-rdk.dtb
 imx8mp-phyboard-pollux-etml1010g3dra-dtbs += imx8mp-phyboard-pollux-rdk.dtb \
 	imx8mp-phyboard-pollux-etml1010g3dra.dtbo
+imx8mp-phyboard-pollux-peb-av-10-dtbs += imx8mp-phyboard-pollux-rdk.dtb \
+	imx8mp-phyboard-pollux-peb-av-10.dtbo
 imx8mp-phyboard-pollux-ph128800t006-dtbs += imx8mp-phyboard-pollux-rdk.dtb \
 	imx8mp-phyboard-pollux-ph128800t006.dtbo
 imx8mp-phyboard-pollux-rdk-no-eth-dtbs += imx8mp-phyboard-pollux-rdk.dtb imx8mp-phycore-no-eth.dtbo
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-etml1010g3dra.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-peb-av-10.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-ph128800t006.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-rdk-no-eth.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-skov-basic.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-av-10.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-av-10.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..35090d5f9f927acfb9bf93bab6a179e6fcd08209
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-av-10.dtsi
@@ -0,0 +1,196 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (C) 2025 PHYTEC Messtechnik GmbH
+ */
+
+#include <dt-bindings/clock/imx8mp-clock.h>
+#include <dt-bindings/gpio/gpio.h>
+#include "imx8mp-pinfunc.h"
+
+&{/} {
+	backlight_lvds0: backlight0 {
+		compatible = "pwm-backlight";
+		pinctrl-0 = <&pinctrl_lvds0>;
+		pinctrl-names = "default";
+		power-supply = <&reg_vcc_12v>;
+		status = "disabled";
+	};
+
+	panel_lvds0: panel-lvds0 {
+		backlight = <&backlight_lvds0>;
+		power-supply = <&reg_vcc_3v3_sw>;
+		status = "disabled";
+
+		port {
+			panel0_in: endpoint {
+				remote-endpoint = <&ldb_lvds_ch0>;
+			};
+		};
+	};
+
+	reg_vcc_12v: regulator-12v {
+		compatible = "regulator-fixed";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-max-microvolt = <12000000>;
+		regulator-min-microvolt = <12000000>;
+		regulator-name = "VCC_12V";
+	};
+
+	reg_vcc_1v8_audio: regulator-1v8 {
+		compatible = "regulator-fixed";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-max-microvolt = <1800000>;
+		regulator-min-microvolt = <1800000>;
+		regulator-name = "VCC_1V8_Audio";
+	};
+
+	reg_vcc_3v3_analog: regulator-3v3 {
+		compatible = "regulator-fixed";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "VCC_3V3_Analog";
+	};
+
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "snd-peb-av-10";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,bitclock-master = <&dailink_master>;
+		simple-audio-card,frame-master = <&dailink_master>;
+		simple-audio-card,mclk-fs = <32>;
+		simple-audio-card,widgets =
+			"Line", "Line In",
+			"Speaker", "Speaker",
+			"Microphone", "Microphone Jack",
+			"Headphone", "Headphone Jack";
+		simple-audio-card,routing =
+			"Speaker", "SPOP",
+			"Speaker", "SPOM",
+			"Headphone Jack", "HPLOUT",
+			"Headphone Jack", "HPROUT",
+			"LINE1L", "Line In",
+			"LINE1R", "Line In",
+			"MIC3R", "Microphone Jack",
+			"Microphone Jack", "Mic Bias";
+
+		simple-audio-card,cpu {
+			sound-dai = <&sai2>;
+		};
+
+		dailink_master: simple-audio-card,codec {
+			sound-dai = <&codec>;
+			clocks = <&clk IMX8MP_CLK_SAI2>;
+		};
+	};
+};
+
+&i2c4 {
+	clock-frequency = <400000>;
+	pinctrl-0 = <&pinctrl_i2c4>;
+	pinctrl-1 = <&pinctrl_i2c4_gpio>;
+	pinctrl-names = "default", "gpio";
+	scl-gpios = <&gpio5 20 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio5 21 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	status = "okay";
+
+	codec: codec@18 {
+		compatible = "ti,tlv320aic3007";
+		reg = <0x18>;
+		pinctrl-0 = <&pinctrl_tlv320>;
+		pinctrl-names = "default";
+		#sound-dai-cells = <0>;
+		reset-gpios = <&gpio4 28 GPIO_ACTIVE_LOW>;
+		ai3x-gpio-func = <0xd 0x0>;
+		ai3x-micbias-vg = <2>;
+		AVDD-supply = <&reg_vcc_3v3_analog>;
+		DRVDD-supply = <&reg_vcc_3v3_analog>;
+		DVDD-supply = <&reg_vcc_1v8_audio>;
+		IOVDD-supply = <&reg_vcc_3v3_sw>;
+	};
+
+	eeprom@57 {
+		compatible = "atmel,24c32";
+		reg = <0x57>;
+		pagesize = <32>;
+		vcc-supply = <&reg_vcc_3v3_sw>;
+	};
+};
+
+&ldb_lvds_ch0 {
+	remote-endpoint = <&panel0_in>;
+};
+
+&pwm4 {
+	pinctrl-0 = <&pinctrl_pwm4>;
+	pinctrl-names = "default";
+};
+
+&sai2 {
+	pinctrl-0 = <&pinctrl_sai2>;
+	pinctrl-names = "default";
+	assigned-clocks = <&clk IMX8MP_CLK_SAI2>;
+	assigned-clock-parents = <&clk IMX8MP_AUDIO_PLL1_OUT>;
+	assigned-clock-rates = <12288000>;
+	clocks = <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_SAI2_IPG>,
+		 <&clk IMX8MP_CLK_DUMMY>,
+		 <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_SAI2_MCLK1>,
+		 <&clk IMX8MP_CLK_DUMMY>,
+		 <&clk IMX8MP_CLK_DUMMY>,
+		 <&clk IMX8MP_AUDIO_PLL1_OUT>,
+		 <&clk IMX8MP_AUDIO_PLL2_OUT>;
+	clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3", "pll8k",
+		      "pll11k";
+	#sound-dai-cells = <0>;
+	fsl,sai-mclk-direction-output;
+	fsl,sai-synchronous-rx;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_i2c4: i2c4grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C4_SCL__I2C4_SCL		0x400001c2
+			MX8MP_IOMUXC_I2C4_SDA__I2C4_SDA		0x400001c2
+		>;
+	};
+
+	pinctrl_i2c4_gpio: i2c4gpiogrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C4_SCL__GPIO5_IO20	0x1e2
+			MX8MP_IOMUXC_I2C4_SDA__GPIO5_IO21	0x1e2
+		>;
+	};
+
+	pinctrl_lvds0: lvds0grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI3_TXD__GPIO5_IO01	0x12
+		>;
+	};
+
+	pinctrl_pwm4: pwm4grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI3_MCLK__PWM4_OUT	0x12
+		>;
+	};
+
+	pinctrl_sai2: sai2grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI2_MCLK__AUDIOMIX_SAI2_MCLK	0xd6
+			MX8MP_IOMUXC_SAI2_RXFS__AUDIOMIX_SAI2_RX_SYNC	0xd6
+			MX8MP_IOMUXC_SAI2_TXC__AUDIOMIX_SAI2_TX_BCLK	0xd6
+			MX8MP_IOMUXC_SAI2_TXD0__AUDIOMIX_SAI2_TX_DATA00	0xd6
+			MX8MP_IOMUXC_SAI2_RXD0__AUDIOMIX_SAI2_RX_DATA00 0xd6
+		>;
+	};
+
+	pinctrl_tlv320: tlv320grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI3_RXFS__GPIO4_IO28	0x16
+			MX8MP_IOMUXC_SAI2_RXC__GPIO4_IO22	0x16
+		>;
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-av-10.dtso b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-av-10.dtso
new file mode 100644
index 0000000000000000000000000000000000000000..95078618ee095af5c8b09f62945c125e69990baf
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-av-10.dtso
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (C) 2025 PHYTEC Messtechnik GmbH
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include "imx8mp-phyboard-pollux-peb-av-10.dtsi"

-- 
2.43.0


