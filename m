Return-Path: <linux-kernel+bounces-860961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC0FBF177D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5AA6E4E94B4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 13:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D483191CE;
	Mon, 20 Oct 2025 13:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b="CLOQ2qoZ"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021073.outbound.protection.outlook.com [52.101.70.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D960311978;
	Mon, 20 Oct 2025 13:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760965899; cv=fail; b=UNkQccpmu1gtaO1Fd130PFVfTgTcjqLuQGCntmSMwifbIf4c5OwsywiW6HGTfEhaLeBtq82Sv41WyYmwRZVMdWauQ6e83HRyUpmLJCI3m5CLXGrjzAm/qD9MbFAS9f9mljeqpTt5Q0V1eU8C44/pjdJSj9yC8w75AOl9Le5drdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760965899; c=relaxed/simple;
	bh=9XqSiKbruS6ItsgyPJqAQqvSdvyJCxM1ZCLT7f7w9+E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=PoL+NA+ukx2mayBm22c/KKjsu1fpwHjzUZFfVXjjwJWxcQYJNhMHvvf80g9f0KCdxk3yxdyxmL1j57ZXYqD03hM7cbI3+kXUl689Y31a5/rd2LxfEo/BM5nrfCEKlx9CrlB/a3RknDP7qhNHAY26/XKyTCa7tLNwY0gFIk5bjpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b=CLOQ2qoZ; arc=fail smtp.client-ip=52.101.70.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XFeD5hMYXGOSEC6h1S2zJA+jJMA88qPy+w36V4zMZjzyzyCjOuipooTBQmRSUlZ0FtgJwmV0HvDcU2fYzzfeJ6cOuHS/8y5w3h5usKJbP6LJMmJum+NorL8Pn5o20sDCiRRwwD/s+jhzWv3hLJ0wMMorIbcTz0Q1Z99aZiZj9G3pbCW1nubL9whjiGbwQ4O8BQSuNPq0c0/kp9gGELKu3kK0pE2s3FlfsRS0OGaHzuD26sUvH7SZhiPg5T9Um5/6LpridkH218VhodnBbCpnIqdad7ycX5I/1ubgcZodMrLvXncEX5sttzBgHWALmPtkkdStkjiOlTxO8AwF43xqvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZzIv53uFX9w3r3xFoUbAMajfZpay/tyFOsuhNSaoHAo=;
 b=KnXFMcA5NcAUJVCDFYq/q6C108WX7VXk0iep7dpaIneE8c55BKGa0atdscMIBgnwWxr2D585oHMP9RJoiEN1WZFbiCr2fWv+e6QmtSftXugX7yYocYVoLx+n0X6BePHK7WKEnHV08XAHfRyiKm6I9FSxL9U/LvHoMdawGB8auabv77chbj87gj1uiJL3IYaEz+X2BgyAt381Jy4H/tNX6fRw2kmWGfGCB6m0krbKBFedCrRcLIdIYmQPc6ITs5TLWQxHZ9mV38MIr/AQzDCOwMiVM3xpuqyqGSxUjHctaVWeRoKgyjbKDTaBVXgctTYgzhpF6cOjjjgx0Or/07xuzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=kernel.org smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZzIv53uFX9w3r3xFoUbAMajfZpay/tyFOsuhNSaoHAo=;
 b=CLOQ2qoZqyyLH3ojv3wHtn8mz8dRmMtKpsP4zRjCFKEZz1LEcW2TdDKsQIel2oaIOmKZMmm38H7E/oxbfCBypYkRLpa2nczsCm2vKnZT1EX1bpa2IUw4QrVMPy7D2xCbfNiRpH4JmwrVnehL9wTP42mzytM0ZDaVJ9vorZDHXcr6f1u9jH5w22mOtziR8cJxefO07FI/E2BExJOZLa8GbDtcmd5sdwDV2+cNAIP10c+ZS1M5JdBLodgZzcXyh3MJxMcYt2XTrBW33qwJQWMlvPvddDE63vTJ/1uW27CgDvtW79xCd+Vm5Dn7SK+bkvaWICIKiq2o4963GAiQCFu1dQ==
Received: from DU7P195CA0029.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:54d::12)
 by VI6PPF45FC790DD.EURP195.PROD.OUTLOOK.COM (2603:10a6:808:1::10d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.15; Mon, 20 Oct
 2025 13:11:33 +0000
Received: from DU6PEPF0000A7E2.eurprd02.prod.outlook.com
 (2603:10a6:10:54d:cafe::e3) by DU7P195CA0029.outlook.office365.com
 (2603:10a6:10:54d::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.15 via Frontend Transport; Mon,
 20 Oct 2025 13:11:32 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 DU6PEPF0000A7E2.mail.protection.outlook.com (10.167.8.42) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Mon, 20 Oct 2025 13:11:32 +0000
Received: from [127.0.1.1] (172.25.39.168) by Postix.phytec.de (172.25.0.11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Mon, 20 Oct
 2025 15:11:31 +0200
From: Yannic Moog <y.moog@phytec.de>
Date: Mon, 20 Oct 2025 15:11:22 +0200
Subject: [PATCH 1/4] arm64: dts: imx8mp-phyboard-pollux: add fan-supply
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251020-imx8mp-dts-additions-v1-1-ea9ac5652b8b@phytec.de>
References: <20251020-imx8mp-dts-additions-v1-0-ea9ac5652b8b@phytec.de>
In-Reply-To: <20251020-imx8mp-dts-additions-v1-0-ea9ac5652b8b@phytec.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, "Sascha
 Hauer" <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
CC: <upstream@lists.phytec.de>, <devicetree@vger.kernel.org>,
	<imx@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Yannic Moog <y.moog@phytec.de>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7E2:EE_|VI6PPF45FC790DD:EE_
X-MS-Office365-Filtering-Correlation-Id: ad27e637-4535-4cfb-111d-08de0fda30ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Sk8rcmh2elNUcFIzelNqTVhzeWZUWHZkUE5BRm9zT3hYL3IwVXlkYnBZNGR2?=
 =?utf-8?B?MHZmR3hncngwSS9IRkVTOFViRnJVZHVYaEtzdzVZT1ZYaHJXRVVabzF0TjhN?=
 =?utf-8?B?WTVZN3VYRXp3dnlUNCszK0prdzFTRlRaNTRCbVdZOWlCa1JIS1dBUVJIODZ5?=
 =?utf-8?B?TG80dkNFaHdINVIvY3BESkk0RVc4SGRIYnE2dm0rUi9iT0VmV0NJTUVEekZu?=
 =?utf-8?B?QVFzN283alk5aEtNR3c3bVYzdTJJd2ZmTXlJZHM1MFMwOUplK0R2NEZPMDFI?=
 =?utf-8?B?YzVRWXd1WklUcFRvTmlHUDRGQ3crRjBkVHorWGJJN2xDQXN6Kzk2U2ZUOWhB?=
 =?utf-8?B?cnJIUDNlNmszNWhYZXlDdVprVWRubUlBTS93WGx5KzFSRHZ6TUUrcjNpemFk?=
 =?utf-8?B?K3lPRjV6SFFYaEhjMkdHa053LzdtZTVUdEw0MUZ3RXMrNFVHdjM1MHVkSmlW?=
 =?utf-8?B?a3dzUGZaWnExYTZlaHgxNFRPV3hyWjZ0TnpzY1Y0NEFVWHYvdlJaQU5pU0tV?=
 =?utf-8?B?Mlk1Nmt4TnR0VTJnb2F1emZ1MFI1Q1orOGRld0puekp1N2M5ZndEQS9Bd2V0?=
 =?utf-8?B?MENjOVE5MkxTSCt3aVdCeXUxczdLZU1sanZoYVZjU2s0aFpHeVV5UjZvTzdo?=
 =?utf-8?B?UENXQ3JTS0V5akNEZmlvTXAyYkQvUEdieFZaZmFNRlZvelh4L29CRlArQVhT?=
 =?utf-8?B?U3VJT0h5T1B4di9acWR1d0FXeFpUOUxjUVlFTU1RMXBoVFNpNEtMRCtDdWNE?=
 =?utf-8?B?ekNkdUpjQURJYWo3SitMaEFKek0rYS8yV0lxR2Z6aHh3THhIblhScDFHOVlR?=
 =?utf-8?B?bzdaVjl2R1dhQWNPdnJMUTZTb2JNUXlWdzRQSlpsT3ZPL3ZWZ3RrR1VLWllH?=
 =?utf-8?B?S0tDVEtrN1UvaitUY2JDRkpvZ3NjbEtISVRkYW1JUnl4YnVxcnVQRjNXdkh2?=
 =?utf-8?B?OGN3ci9NZXJtNVJoWXRnd0cxaTU1WFVUZ3lNMEdDWTRNM2Vtekk2V0Z4OEZZ?=
 =?utf-8?B?SjRVa2w3OXpLVUFsdjJJN1MvWFJQWXM0UUgzVGFRUWNyTWRKL1hSc0lmaEhx?=
 =?utf-8?B?WEppcWtYTVUyV1ZESDhJUWFmVVB6N1RWR2c1bTA0L2prVUp0enMwWHRTbDly?=
 =?utf-8?B?T01hck1uNzdaWkxxYUJadXpHMHR1dWlxVHQ5R3dia2FKdWtZZStzbHZLdy9S?=
 =?utf-8?B?ZDhuMk8wV2VjNlltTE9IVk9MYVY2VFNrZXJueW1wZHRxeTdISmY1VExTdVBZ?=
 =?utf-8?B?Y3lvVU8zL3B1N3djVUlRMUh5eHNFdythb0N3UElwZDJ3TVZpdUZEUERhK0Yw?=
 =?utf-8?B?bWtRN2RjMGNVNURQZG96N0xZWE5aOS9QVFRQUlNibUlUbDFZdkd0UzMyekxI?=
 =?utf-8?B?bkRRaFhidTVBYzBWSDY3N0pDNGNpWUVSQTB6SkZrbFRYeVY5NFhVZ2JHK1Jy?=
 =?utf-8?B?UzdkekhFVXRTQkdOUG1meklDa0EwVDdFN010OGQzQU1yMTRtbGozc3V5eEJO?=
 =?utf-8?B?N0d4VkRMSEJXSFQvanRQSE5OUlFJQmtVV1hGYU5OK0RpSFNHZGpLdlNiNUlD?=
 =?utf-8?B?V3FJVC9UaUpJRmtscWdvSVJPZitHUTVYZS9waHkrem1PTGtEL2NxUVhXQzZq?=
 =?utf-8?B?YitueVA5cTd4YlNyblZGU1RMQ1lqVlozWUcyK293VEZCRFJwUzhSWnhlNzBG?=
 =?utf-8?B?RjhTcE1HNDJFdktkNzc0c2FrMWIzVjhEcVBRUWdJai9kc0cvWVQzclRGb2lR?=
 =?utf-8?B?K2Raa3F2cTJ0ZzlXMjQ5dWJNeW9pZXhmYXVRMkVsMG4zVEQxZ0ttK1FGajhW?=
 =?utf-8?B?M2ljbXNqTXN5Z1U3ZmFGbGVOdHNjWUNkQlk1NVN0bmJGSDVmSVpPYkhrZWM1?=
 =?utf-8?B?bUNIbXcrODRIUUwzd0Z5V2xSZ3NCeklrVUJKSENjMGY0ZGFNMG5xcEFFaE1U?=
 =?utf-8?B?UEhFRXUvdWNvaWM4R2VxcS9CV2FrWkZCbjVMOHlCRlpKQ0ZQc0poalU1R1Jj?=
 =?utf-8?B?a1VOeWVweVpMN3pUeENKTndsMDVDK2JIM1J1d1pKTi94dXNValROd0g1MjA3?=
 =?utf-8?B?RjhsQkpIQ0RJTnJNa1FiQlpiVEExK0I2Yi8zcnBmK04rSkRRZ29TVUR0VWhS?=
 =?utf-8?Q?GMiA=3D?=
X-Forefront-Antispam-Report:
	CIP:91.26.50.189;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:Postix.phytec.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(82310400026)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 13:11:32.8308
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad27e637-4535-4cfb-111d-08de0fda30ca
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29;Ip=[91.26.50.189];Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E2.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI6PPF45FC790DD

Add 5v regulator to gpio fan node.

Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
index 9687b4ded8f4c98fe68bcbeedcb5ea03434e27a3..6203e39bc01be476f16f5ac80b6365bce150ae37 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
@@ -31,6 +31,7 @@ fan0: fan {
 		compatible = "gpio-fan";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_fan>;
+		fan-supply = <&reg_vcc_5v_sw>;
 		gpio-fan,speed-map = <0     0
 				      13000 1>;
 		gpios = <&gpio5 4 GPIO_ACTIVE_HIGH>;

-- 
2.51.0


