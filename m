Return-Path: <linux-kernel+bounces-860964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED2ABF1786
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A99C440466D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 13:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262F031AF0E;
	Mon, 20 Oct 2025 13:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b="NsqFoiuu"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021099.outbound.protection.outlook.com [52.101.70.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD233148B5;
	Mon, 20 Oct 2025 13:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760965901; cv=fail; b=A6+G3Ej9oPcz63Dy4pcWXCInLhzhwgI5iSE+sfRJLA5HFEO+vaUweIAdHwypio568uWWlho1pGRQPVoe5WYqpqFNkJ7bN5Jvse3Ayg6xmyDwXg2x9fBOVnWxjsa1GYBq2a8tU2HMXcCh5KcLl5e9bPkm6sRRHW05X+A0i30H7fc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760965901; c=relaxed/simple;
	bh=Xm4x5btw+pAogTVeQGgVqVdhR5OEC+iuKrmEKBMdTg8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Q55LbCQ9RmrmnhwN1rqWzldhUqmGui/A3yvEUBP6BiY3z/tJszRRlWuUe/dtY/4u6tO9UcwpFZ0i9qnPIixCj8tVWSlCIg+24WDjNmD/VF3Hn82mqoh4joIXx4L5EfZAxHHD4hwbhFzsp4omtzHX+noeMDvMsPg+KuvmReya+dQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b=NsqFoiuu; arc=fail smtp.client-ip=52.101.70.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FRpozgVfY9YiRztxU+GzrEdIQKsXKyXL6QGuQS39ZY66h3+5kfzxagKm9G0m0SsAc/OSD762TVENocwL7i0zlKIJB86LGjf3TT1EjapKF8XWCIAxutPvUnvCDjFxjRSi3dByJzIEq6t+TiiqHEYXxQwFsu1JI3G1SuivdrFaWZ8/qY/kT0O1/IpTCA3gznEXcmF0wuRKyERjaSS5EavJypP/cYaKkK0lE2iP7XbLcP16bYISSh67wmBlM56bVY14htE1jJQ55czwAiIzNfHiM0kxC5lhBIbEf2FLrOJ4JN2EKPD77cHHeqf8IYJi3ktb88/hRLbUL1cwzl1uPmd8Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rkl/sx9UDdlsDu9oBGwsgYB4eki5KjLa48T1Phi2lzs=;
 b=SVOFGdAXOPwE6SlXIN8qFW/dgT3IRH4OHctWW2q+8AmkeIl/qK9L3gj5FsOBykC5fUe3bblyERWwHAStsoY+3qnxS7zZlZn1mmDFha+QGrgRvPzKYAsPCq/tDup1lA635+/5KEQK3oIgY+xL/gXVrg9QABS6BoW2fRd9vSIpaHWVjrp+JFd1PW9zQfMDWgjlunEnSWgT17BDR4voCQdvD6mwBfqtJI10bKtfdngti2OUgUz6PP4YODt0GVJGVrSlXnP2PKpAjH5GtqyUBRgPm9f0wEWp6Efg2fniYvZmFG1LCJDVkICOqsm1cyLpJFDhAWLyK9jeGjjQNI6fjlWMPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=kernel.org smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rkl/sx9UDdlsDu9oBGwsgYB4eki5KjLa48T1Phi2lzs=;
 b=NsqFoiuu7e2H6rRzCrYdmFFWlyqmRNQpj+xLFHdFttzrYnsCUgs7MvUMisKdEeWSYvEz02QP/SqONfDfq+3Ub8YgIXqPngefDx8DB9GT3nYnJoWAG1YzlLnJS2rNJRcFO/rtTHEkhH94ujRSVUB0YLV3j7TaXeVGVWg2jG8M5q/X2blACk2iRGzxSTAKRuL8FcGhvoAMtC7cvC9HyC3bBA8ln7ATbPK+0AMZ59FmBvtd07dwSBStF82XM/9ZUNrxq+JaXUVttl3Ty9WejsiBGMSxXXa2HuGQfxtPJjViNai2j8E8mPRMp2aRLQQHZTUHjbYwhBSNvcGNeuD58b38qw==
Received: from DU7P195CA0030.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:54d::17)
 by DB4P195MB2692.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:5e3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 13:11:34 +0000
Received: from DU6PEPF0000A7E2.eurprd02.prod.outlook.com
 (2603:10a6:10:54d:cafe::3) by DU7P195CA0030.outlook.office365.com
 (2603:10a6:10:54d::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.16 via Frontend Transport; Mon,
 20 Oct 2025 13:11:33 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 DU6PEPF0000A7E2.mail.protection.outlook.com (10.167.8.42) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Mon, 20 Oct 2025 13:11:33 +0000
Received: from [127.0.1.1] (172.25.39.168) by Postix.phytec.de (172.25.0.11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Mon, 20 Oct
 2025 15:11:32 +0200
From: Yannic Moog <y.moog@phytec.de>
Date: Mon, 20 Oct 2025 15:11:24 +0200
Subject: [PATCH 3/4] arm64: dts: imx8mp-phyboard-pollux: Enable i2c3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251020-imx8mp-dts-additions-v1-3-ea9ac5652b8b@phytec.de>
References: <20251020-imx8mp-dts-additions-v1-0-ea9ac5652b8b@phytec.de>
In-Reply-To: <20251020-imx8mp-dts-additions-v1-0-ea9ac5652b8b@phytec.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, "Sascha
 Hauer" <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
CC: <upstream@lists.phytec.de>, <devicetree@vger.kernel.org>,
	<imx@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Stefan Riedmueller <s.riedmueller@phytec.de>,
	Teresa Remmet <t.remmet@phytec.de>, Yannic Moog <y.moog@phytec.de>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7E2:EE_|DB4P195MB2692:EE_
X-MS-Office365-Filtering-Correlation-Id: bdcbdfec-0ea6-4eeb-7dd4-08de0fda316b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cnc5cHhnV1NLS29pZXNFWk8yY3JwRkE5bFJQZ0tRWE9Xc0ZOZGhPTWdWbzZY?=
 =?utf-8?B?amNXTjFQSEhQRHNFZXo3anhVVlBYVWpHVHFGTHI2ZTEwS1lWNWJlYlVRK3Ns?=
 =?utf-8?B?RVNLR3NnS3UwQ3V5SHo5V3Vtd3JXRTJ4UmpNaDA2b2ZSWEN2Nnp0TUFXcTIw?=
 =?utf-8?B?dm1yZmRPWlVXVkF6aW5EVHNhQWs2NmVGbGFHQys2bEwyTVYvU3JpS1BzdjFE?=
 =?utf-8?B?dnhwaFgvN1d1WVpnNFRkYTNkRmFIRnZNRUdycXBQeFhxSmxjRkJsb2NMWVdq?=
 =?utf-8?B?NzVQakZzOE8xT2ZNZFZaaktXWHAzVkpwdzlkWjhEbFVUbGlRRDZHUFFIRWpr?=
 =?utf-8?B?d0lERS95R2Jpai94TDJmQjBjdGpEeXlVdjdCeXZHbnNEejd3L0VMc3h4VWps?=
 =?utf-8?B?dXF4TVEram1LUjhoVkJIRjlFQmRyUnZWRGJMNnRsS1FnTmZ2cTc3SGRVYWZk?=
 =?utf-8?B?RnZMR2tBWmFZTk14ZnpmdlNUT2pPT3l3NTBKdi8xMkZ4cHN4UEZyNmNTbjQ4?=
 =?utf-8?B?Qm9UR21tdlU1SzdlYjU2UFdoTHJZU1I1SVFwY3RzSG5lbE1VNUVQTW8vdTdm?=
 =?utf-8?B?ZmdzTFlLWnZmaGFTdTIxTW9aVk5wOXY5ZThwSE9NYTg1d3B1Vi9oWVVGMm94?=
 =?utf-8?B?eGNtVmt2SU5hOWVGd2VNTUJneFMvN0xFM2ErNUZhSG5RVkJVQ1dyeHJ5d0RC?=
 =?utf-8?B?TjlZWk1sSjZpbkMxM0tWdHRrZytHdWxyMXRJOU5kSC9RM1pNZ2dVKythOFpq?=
 =?utf-8?B?UUlOYXR5WmovT2d2REhlTVBjc3VoM1lmN1VoclBBU2hNcVlkcDM2RzR6QTJk?=
 =?utf-8?B?VEFFUnNtT2ExUVI5emJtd200Sno0cmdBOVlVZjJFRWtNS2t2NmtWYkxMSmZq?=
 =?utf-8?B?NFZyN0J6K05ob3hKWUJLOGN0SFlsVVZpUE9uaVNUS1ZkZ1p4RU8zcHdEVXRi?=
 =?utf-8?B?TFQ5ZjE5a3RkUDgwMGpRWnhZcmpYR1JLMUtGY3NyV040Qkc1R0hRVVZuN1pZ?=
 =?utf-8?B?VnFtVGw1UDh1L01WRktGNDZWSFI1ejNGbFBVRWpCZnd1aysyc1Zoc1BtQ2Z4?=
 =?utf-8?B?Mk1md0Z2aWFMRXRXTGI4WUdJdVF2elVHU21lWHd1U1gzNDFuV2t3K2VONXhv?=
 =?utf-8?B?eGltcTA1eWJmazZSZjVDV3hhWngyQWgyN055U0dNbG9DK0pCdkR6TlZVQ2ts?=
 =?utf-8?B?N01IUjZxQ05rQ1ZHUXJ0UEhJUVJIZ0JKMWtmU1pyRHovYnpSN3F5M3dwVDJk?=
 =?utf-8?B?ZlE3WkY4V1lyaVFMblNDNkFSaFQwZGFDamRsM1FKcUxiSG5Bd0cwYU9SbjJJ?=
 =?utf-8?B?K0ZWQTVYVlNBRXg2UGNpcmJ5NzJsdlk5OUw1ei84Yk1GUnExWVRCdEh3d2hN?=
 =?utf-8?B?em45VHRWM3I4TWxpaVRBbE9XMVB6M1JvTkNpZE5YSVNHaWhBRVhOcG10cWFN?=
 =?utf-8?B?ZlNSRkI1MC9JNE1OU1BJNlk3ZFdkcGlTUnN1QlZoNjlTL0pFZ2NUc0pHVzBp?=
 =?utf-8?B?R1RMSnI3L0lqVUg5Z2lQbUtBS1U2UVI3S29LU1h2ZUUrT1U2OUhOSVVRaE9F?=
 =?utf-8?B?MmNFLzUwbEtOWTliOGExTEx0UXRsajFqU2RRNnV0VUhXbE93dmdzWkp3RkJY?=
 =?utf-8?B?WUFQMU5RV0ZqdjdESDR6Yk1wOGxOcDdJNm5LNFVjNWZhbHk0dnM4R2xKa2wz?=
 =?utf-8?B?ZFA4Z0g2aXdnMWZCZ3RKR0NWMGpteVJzWnppOE1Lc2U5VnRWVmNwSWpBSEpC?=
 =?utf-8?B?SS91WkFNQldiYUkyNW9YNkxOS0xIV01nNlpReE4vbm5KeUZzZS92cTNzcmd5?=
 =?utf-8?B?S3k2YmZpd2hYTVRIa1hoQXQzRXJONE5zcGdwVk5STE5BZ0kxcGt0MElyaTFT?=
 =?utf-8?B?VUZoWDlXYjUwSVNCVk00TWVLOVJlMGFKVkZUWUFrSk40TklHQnBzV1V3RUF2?=
 =?utf-8?B?d1pJVGtvNkcwS3diQzJYVG8xNU1DamFUOG9taVU5RzVMMEtTK2FuMVN4QXR5?=
 =?utf-8?B?Q1p0QTJTdktWM0hjUnU2ZXRVQWs3a2VNVjhOOFpEWFRCais1YWhZWnJ1WnlT?=
 =?utf-8?B?YWE1aWlSdWMxOG42NmtLVU9mSjN4M0FWcVl0MzFXc05YOXM4eS9zWTRtSW5G?=
 =?utf-8?Q?vH7w=3D?=
X-Forefront-Antispam-Report:
	CIP:91.26.50.189;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:Postix.phytec.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(82310400026)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 13:11:33.8911
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdcbdfec-0ea6-4eeb-7dd4-08de0fda316b
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29;Ip=[91.26.50.189];Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E2.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4P195MB2692

From: Stefan Riedmueller <s.riedmueller@phytec.de>

On the phyBOARD-Pollux the i2c3 node is used on the CSI1 interface to
connect to imaging sensors. Thus define it so it can be easily enabled if
required.

Signed-off-by: Stefan Riedmueller <s.riedmueller@phytec.de>
Signed-off-by: Teresa Remmet <t.remmet@phytec.de>
Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 .../dts/freescale/imx8mp-phyboard-pollux-rdk.dts   | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
index 6203e39bc01be476f16f5ac80b6365bce150ae37..7d34b820e3213a3832c5be47444d4e9c636a6202 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
@@ -228,6 +228,15 @@ led-3 {
 	};
 };
 
+&i2c3 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	pinctrl-1 = <&pinctrl_i2c3_gpio>;
+	sda-gpios = <&gpio5 18 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	scl-gpios = <&gpio5 19 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+};
+
 &ldb_lvds_ch1 {
 	remote-endpoint = <&panel1_in>;
 };
@@ -442,6 +451,20 @@ MX8MP_IOMUXC_I2C2_SDA__GPIO5_IO17	0x1e2
 		>;
 	};
 
+	pinctrl_i2c3: i2c3grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C3_SCL__I2C3_SCL		0x400001c2
+			MX8MP_IOMUXC_I2C3_SDA__I2C3_SDA		0x400001c2
+		>;
+	};
+
+	pinctrl_i2c3_gpio: i2c3gpiogrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C3_SCL__GPIO5_IO18	0x1e2
+			MX8MP_IOMUXC_I2C3_SDA__GPIO5_IO19	0x1e2
+		>;
+	};
+
 	pinctrl_lvds1: lvds1grp {
 		fsl,pins = <
 			MX8MP_IOMUXC_SD2_WP__GPIO2_IO20		0x12

-- 
2.51.0


