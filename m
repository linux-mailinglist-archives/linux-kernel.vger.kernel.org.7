Return-Path: <linux-kernel+bounces-860963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E00BF1789
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 61D254E1D72
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 13:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D8831A7ED;
	Mon, 20 Oct 2025 13:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b="WzrNDvRs"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023122.outbound.protection.outlook.com [40.107.162.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC8C3148B4;
	Mon, 20 Oct 2025 13:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760965900; cv=fail; b=cd2YPJk5W2NoGyGJCLGyfVWP8OGGr9VXFVJUIgYb9OOd5vogbDBwlWJAijW6OGNFR2r7gn7DPPq7dBGOhYLXRg2pst/HzrRtDRsoHDOVYdos9eLBJof+g47EANlHSr/6U7zM1+kL3oILDynWXUCe+iaPcNYUk1t6a5+3ZkbJuIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760965900; c=relaxed/simple;
	bh=2VVONKi+oqMxn91aq94OXjX2d4KiaQlO/y6FmAYYOHU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=iE6wb4xhrRKCi0uLTmlJOFpDwCgaHHN9LID+N68gjHIE93/9gIUlZ+njbLG31bURI4GCUyXp2sq2HyEtPSbwHH9NBklOyzrS72wIJQBPR2x7khc/zsac5/MGBowALng4bsc9quG0HrFkDtdBmW4vuU5nFUcLzenp0SdtmiVDLuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b=WzrNDvRs; arc=fail smtp.client-ip=40.107.162.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QM73N0RhXNMVFTidfPFhiHkHsfnTypmd+a2whHuhKyLKZpg0G8fsTse1oLUHMfj72w3FOrCVTybg0JxapfmowOXoJp9L0QBsGH8UR4XbDXYOGgRE1Uxdgf0WdhYygA4R1OSjniSvPOYPs6CXrQ3I7D/vLnHXIPQ5tkxEhRi/4vJeX8aMa1gNL8OC0SjUXfp5ubsDtZPLwm0rRO8UjA3Ahnt3WzyvFSrHyv176dmTsXNv58vOuE0ns7x/Kf/59WkDh3pSla+iSa+Ed+LSgW/0moBol38+bXcLeoEQTrq0uITjIFoKDOfSkz9VHSjLjQXex/1oFJsclk+OTAl+xpqKGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YIK5SNK5pmqg82a5/YyDMEtxGyc3+yHTt+DwTnUnCH8=;
 b=NJFnMbGWTRiGRQlqrTQV1mHOatpS8p5JoWr6pkYGkGkQCwHYBPVK+swYKQn0gVbNyY/ftid8kf/Gv7x4moU0dyXE/Ofi5qVwF0KS0qI/IY/jkyd7UcPRs8g6o9s2uh3qgnR8UDIIg+cTUQlEKyo84XMwgccRmtQealmKYBM7dsgujHoQW2W4blws+j4LjXULCzW8YW3Da0+HbTZ0BT0QxCOtmEpW6OGzsDiwn4aGlX8v1RCdeJAftKSao7qCNCn6k6OVTutmcbpfbEQcTAcXxC/T4l9SQVo519n7f4tdtkwDI4glKHX7ctL2xApLf/xR/w5wvW+6Hh+7uSK7DNvq/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=kernel.org smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YIK5SNK5pmqg82a5/YyDMEtxGyc3+yHTt+DwTnUnCH8=;
 b=WzrNDvRstbfD97FFHABv0OwzV1jSxgwaIj38FLXMN9IrLnqH6+VKv2yWb2rYGURxWlKhEHSIaXHaLq4U/72rblxoxXeCH74pQp7BTnO+2e+WUc7l6g/DmEEvFdrSDNl62fTQI+GAHb2rGXbR5zd4H+vfjUwl2GAJPFbDlhPMMwESFO5f4H9Cv57uTm8e08WI+kvPNSu+2NJiigeO5GgyFjQPrYIcnK/zduka9guwUn2hyFU41ddgAislfs2p+evK+5olwu2egxf5y4wSbzbtrMdvuagYwDQUqUKVnUqftyAUP5ep+8+rDtKYh5nvJWUifNVPmaiqIrpFB+CNo9Lw3g==
Received: from DU7P195CA0005.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:54d::24)
 by PR3P195MB0864.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:a5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 13:11:33 +0000
Received: from DU6PEPF0000A7E2.eurprd02.prod.outlook.com
 (2603:10a6:10:54d:cafe::60) by DU7P195CA0005.outlook.office365.com
 (2603:10a6:10:54d::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.17 via Frontend Transport; Mon,
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
Date: Mon, 20 Oct 2025 15:11:23 +0200
Subject: [PATCH 2/4] arm64: dts: imx8mp-phycore-som: add spi-nor supply vcc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251020-imx8mp-dts-additions-v1-2-ea9ac5652b8b@phytec.de>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7E2:EE_|PR3P195MB0864:EE_
X-MS-Office365-Filtering-Correlation-Id: feafe587-aee4-4e80-9b74-08de0fda313e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T3NjcHR2OURHK3hIMTQ4V3dBdmFxQS8wL2JzbjRXeDFwWUd0clNBVVJoc3Zk?=
 =?utf-8?B?M1JMRUFoWTArUVR4KzhoZ2VQS1gzZGJLY3hRdlRrSnRFVmtUYlRvYmgybk8z?=
 =?utf-8?B?MGJNb2RESFlxVk5JWmtrNjNIUVdPR0QxUFRlMzlocEY1Z05nL3ZRSzI2VWpP?=
 =?utf-8?B?SnJGT0k1UkJWTmtnZ2RyTGVGUkpqZzBoKzBNYU5reCtzSE9oS0QrbTB5UE1h?=
 =?utf-8?B?ZGR3anRJOWk5Q0FhcTNINjZ4Y2xCdVY2VFkwQkN3cW9Pa0ptcFF3YnhJb21k?=
 =?utf-8?B?dFlhenNLajdERjRVUmhleS85M2x0c1RHb3VIbmxHZzFmSG5RbmhvZkg2T09O?=
 =?utf-8?B?TmRUK2lzcGlJdHFsVGIvUHRkazRUTkwrWGpraUhZUEQwZXgwcWk2VkVZK1lI?=
 =?utf-8?B?VUR3cnI5a0pJbjhKZzROVWRrWTIwNzQ1cTF2Z3NHSk9FS2ZYUFBjdUlqYTZ2?=
 =?utf-8?B?b0VnVjJZVHJlMnNjTWFOR2ErRFRXMUxwRjYvcUErUVREUzRhU3pvdU9pZ0RT?=
 =?utf-8?B?am4yVTdCcFJIeURRZ1V5bjE4RUlvYXFwZkdxYW9FK2VEQWRwR29OeHFkSmY0?=
 =?utf-8?B?TjBLOCs0UWI2VjBEbTN4a2owaUFyMU1Ldi9IbXMxcDlpa2srQStxSVF5N2g3?=
 =?utf-8?B?Sml4Z045ZHg1SjhFMm5NdkxmSms3OUlnbWptdGo1Tm1COW44ZjFNRXd6eVh3?=
 =?utf-8?B?NW9CanF5VjlFMzJyandzVEVGZ1IzOG8yenVNMVY2V1cwcW5iS0R4ZzViYmpN?=
 =?utf-8?B?NWthZTZzSHdzWmtNVCtPQTVqc255SXZoRnZEUUpuR3RDOWV3bytTMm1iZ0Nh?=
 =?utf-8?B?R0RwQ09Fc25Ja0hUL2hqdWl1RDdzdXQya1ZBN0IrTloyR0xLaCtTTFJuSlg1?=
 =?utf-8?B?ZExPR1RyV1N4dk43am9GeW01cG80NWY3aGN6b0xVbThURFpqcEs4Mm1Ib2xw?=
 =?utf-8?B?NlFYeTErYTRLMzRqK1Y3aWVHSk9HcE1ETE80RWFiamhIQVQ1ZEUvZjZqc2N6?=
 =?utf-8?B?cXVEVHZvQVMvSEY3TzJIaWJVMU5sQ1FsS3pkejBoV0ZNTnhmTGpoNmxoQlBq?=
 =?utf-8?B?MWFBOEZiaWpyYVhQa2xVOFExUVJqbk9PUEd3dXZZcDZ1WHJTUUk5TnFiRjhn?=
 =?utf-8?B?anRqRUJkWElzVnVDbXV1eGwrZkZhaWx5elBoSkl2c2xBV2FNS0RPU3NLTXZW?=
 =?utf-8?B?WXNpNTRxVWpYSE5tTm1xeU11R2dCSTNHRlFwVWI3cERWNXQ5eGNMYUdPVjJY?=
 =?utf-8?B?N21XQ0VlK1p0NExqYXI0cmVmVlEyM05DRUxZcXhNWnR4OXJpbDlabm1YVlIx?=
 =?utf-8?B?MmtKb0xacmJJZ2hjY0pIQXZ6azNDT0RVcXdFOXBmNkVaaldsdUJ1a1lKazMv?=
 =?utf-8?B?TmhRUlhuVDZZRDg1T0dXWFVLWVlDSityOFJLdmhJRFhaa1ZBOXZDYnJWZjNa?=
 =?utf-8?B?YkM1ZVBmUGR1MzdZVWszNW1ucG5LU0pEeURlSDVNTmpuY0tXUFhmWi9tRFM4?=
 =?utf-8?B?NHpqdDVmTXVFWnJ1eWlvRENBTTc4MWFZeXpJOXltQVdHMXZ0ckFtbGxMZ3dh?=
 =?utf-8?B?cWdrTkZpZThGK3NLM0YrbDhyTE9YRjBjUGtLVXFjTGRoL1U0M1lLa2JqTXo2?=
 =?utf-8?B?dklZbVZvLzViSXhRNnRQSWpzMFV3TE1tdWp6bFR4dXVld3lGUVdnUmQ1YVRl?=
 =?utf-8?B?VVp0SVZFYXBjQUc5MDFtWlNNUWdPaThtZ0g4VTJJOXNWOWJ6U0dZQ0g5d3Fk?=
 =?utf-8?B?cS9kVUVMUm9TR1pnc1I5Yzk4Tm1mRkxwWmZxNEtVVUlicGE4UWF5SnNtOVYv?=
 =?utf-8?B?eWZ2WGdSczVFTVhwcnMzTlIrdndFa0s3SE5KMkFQalBtc2k0ZUZUaDgxVGR4?=
 =?utf-8?B?cm9wMExibUJGZDNGN1B3ZHBDWTNxbjlIWjBMdG55NHNDMXorS0lMRXcvd214?=
 =?utf-8?B?Nktnd1NIb1ZIdWs4VXQrVzQvc1lkSVp6MGR1TjBsbE1uMUxySGZxQmk0WlZB?=
 =?utf-8?B?bzFUVTJJSGxYZ2owczZLdG94dGpBdVpWSXVsQkZ6RmRVUU41ZWxGbXBsREtk?=
 =?utf-8?B?MXNPcDdMb0xyTVdhaDlxaytFc0c2bFpnT2ZyYVgyZzllOENrN0Z6czNGeUZu?=
 =?utf-8?Q?r9co=3D?=
X-Forefront-Antispam-Report:
	CIP:91.26.50.189;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:Postix.phytec.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 13:11:33.5963
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: feafe587-aee4-4e80-9b74-08de0fda313e
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29;Ip=[91.26.50.189];Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E2.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P195MB0864

The spi flash on the SoM is missing its vcc supply definition. Add
missing regulator which supplies the flash with 1.8V.

Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 arch/arm64/boot/dts/freescale/imx8mp-phycore-som.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-phycore-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-phycore-som.dtsi
index 88831c0fbb7be3db18910385e4e15691b1c74ef2..d370e2a3a00c5e3e91a606ac0fbed30cf5e6f9b2 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-phycore-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-phycore-som.dtsi
@@ -28,6 +28,15 @@ reg_vdd_io: regulator-vdd-io {
 		regulator-min-microvolt = <3300000>;
 		regulator-name = "VDD_IO";
 	};
+
+	reg_vdd_1v8: regulator-vdd-1v8 {
+		compatible = "regulator-fixed";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-max-microvolt = <1800000>;
+		regulator-min-microvolt = <1800000>;
+		regulator-name = "VDD_1V8";
+	};
 };
 
 &A53_0 {
@@ -83,6 +92,7 @@ som_flash: flash@0 {
 		spi-max-frequency = <80000000>;
 		spi-rx-bus-width = <4>;
 		spi-tx-bus-width = <1>;
+		vcc-supply = <&reg_vdd_1v8>;
 	};
 };
 

-- 
2.51.0


