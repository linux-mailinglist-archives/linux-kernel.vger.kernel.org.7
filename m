Return-Path: <linux-kernel+bounces-723985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21766AFED40
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 17:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C72DC645F17
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1B22E8888;
	Wed,  9 Jul 2025 15:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="x5X5zIAr"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2090.outbound.protection.outlook.com [40.107.22.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95362E7199;
	Wed,  9 Jul 2025 15:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752073824; cv=fail; b=FDc2NrSuANHlqHG3z6aL5X1fdKuZgdQZqp5vU4DMOe79AyQ1D5Ox2/aCYL/J8S5/9iTFOVp7fN5K/uoGxfkbHP53qxceMCA58dsSwRwGbR/03RhX1JN6Uqyw6Uo7RX/X/UVt7wXlBTxbIVpEqhCncHttG0yiFlcJBhCAdgV3VAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752073824; c=relaxed/simple;
	bh=xvFgcsblfwZrK2OJMULGfnPOMzkcw37uPzbWoI1y/Ys=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GDFAmeaOd0s9sqJ89C0vj7IwuP4gjD4DsGMCZevKrH8Qba7lp+4StfCRwo5nVOE5x0M7Uw5cXbL4tT21ms3axHGWUFJLXI4PjkG69Dl1baI6HwbBmRXK1KRrjHKiu0tz6fcMNXxzm87Hi3sEAASLphQRKKz2V/Vek1Zq3ld10jM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.fr; spf=pass smtp.mailfrom=phytec.fr; dkim=pass (1024-bit key) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b=x5X5zIAr; arc=fail smtp.client-ip=40.107.22.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P2t+DylmqhPIT0vHb6S8so7VmjW1Tv8SABKM+MVZWxWHwkWV5/PXRpkeOpiNfuLVzbFc7meNhJOf+8xDvC2tdQIYWW5FzFJKwc4rRxdSNLErc1Qa8hvupMqBU8dPABoEuNQE8nQdtIS2SMgh3Ea6GUnFMExPcdJndsu45fsQ9sDMl8cAkFoUR9Oq5ihIA8h9Ku/t9i83GzBk1+F+y2r3PdSpm/W7VukPzDcxISKPebKbo3ba0QpIVCS8NZO4RUWZOPWwm1tj4F2pG33mE58QV2oej/VbCL97fhlGNtMwyWKLfiTxESCgrgKPMwV0iePcM0HeBYPx52JAteeLsJYy1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eCpGj14y8qnWzSxrj6VdBuo5/QZItUYGIcekqKER1Go=;
 b=JEuCAh6FKjK0JziOtwvmEMZYu7EN+Q5cwxuh98xq+2s7HS294Jlfxh3aDtgUOrHV0J2isFYgU0Q03ugnicIeCdVT9ZgYK1G+Gkn0HJ01suzwEm0GTTQvpYE7kDXeDrGsnAqQjdRvTy4TBsZA9WC26NI05BemdJUP3ShOSiBxvmE2XyyE9TF2NPppazfLS5FQWpiBoMTEytZ2DrT2kQUi3IcIhPOU5Q6VcQ7xDbDdfzhf4D344tWzB83a5e54LXe/HPTPTe8jkzXoYnXKe/PAgmhE3hQ4dy+VGhpwQUloUpTVuek2A0pT9IcRT4MCrGw5yLsNVU4L1agfSMyDGYByZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 91.26.50.189) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=phytec.fr;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.fr; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eCpGj14y8qnWzSxrj6VdBuo5/QZItUYGIcekqKER1Go=;
 b=x5X5zIArL6N6rr1rKL6ljed8AD+3uWmJjkp4ZmdwkTrRNCXe59rdHIorE2SDcIe5Zlau9k1TwW6DIrfNPzD1A/gc/W8ML+5+gfouqPLbj8ZTcalycwNa5nl0zAyzalzjikapkkoZS1KnUqomt3W1DVWYL7wdvCWdqOSPuEehVH8=
Received: from DB7PR02CA0018.eurprd02.prod.outlook.com (2603:10a6:10:52::31)
 by AM9P195MB0870.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:1f5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Wed, 9 Jul
 2025 15:10:17 +0000
Received: from DB1PEPF000509ED.eurprd03.prod.outlook.com
 (2603:10a6:10:52:cafe::c) by DB7PR02CA0018.outlook.office365.com
 (2603:10a6:10:52::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22 via Frontend Transport; Wed,
 9 Jul 2025 15:10:17 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.fr; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.fr;
Received-SPF: Fail (protection.outlook.com: domain of phytec.fr does not
 designate 91.26.50.189 as permitted sender) receiver=protection.outlook.com;
 client-ip=91.26.50.189; helo=Diagnostix.phytec.de;
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB1PEPF000509ED.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Wed, 9 Jul 2025 15:10:17 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 9 Jul
 2025 17:10:13 +0200
Received: from Diagnostix.phytec.de (172.25.0.14) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 9 Jul
 2025 17:10:13 +0200
Received: from idefix.phytec.de (172.25.0.20) by mailrelayint.phytec.de
 (172.25.0.14) with Microsoft SMTP Server id 15.1.2507.57 via Frontend
 Transport; Wed, 9 Jul 2025 17:10:13 +0200
Received: from pc.home ([172.25.39.2])
          by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
          with ESMTP id 2025070917101328-210 ;
          Wed, 9 Jul 2025 17:10:13 +0200 
From: Christophe Parant <c.parant@phytec.fr>
To: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
	<upstream@lists.phytec.de>
Subject: [PATCH v2 04/11] ARM: dts: stm32: Add new pinmux groups for phyboard-sargas and phycore
Date: Wed, 9 Jul 2025 17:10:04 +0200
Message-ID: <20250709151011.366537-5-c.parant@phytec.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709151011.366537-1-c.parant@phytec.fr>
References: <20250709151011.366537-1-c.parant@phytec.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 09.07.2025 17:10:13,
	Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 09.07.2025 17:10:13
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509ED:EE_|AM9P195MB0870:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f21b0ac-5a0d-4983-f351-08ddbefab703
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/KKS9FqSBsUPx4ljmzRpadyyc9GWIIfXCPQcbsG69gW6vlJc/V4B2jV9CwFD?=
 =?us-ascii?Q?m0FIQfC9c8s7lR0luRyt8UbWhadk/7L7Y20uEIp/iBJ/3cUA9OHYkgrd3AHl?=
 =?us-ascii?Q?TWrGttyfQloGCrjBXJ2i85HfUsmDgj1Wp4IPZDWs5wib9MA1K5QLsM0Bc0cw?=
 =?us-ascii?Q?TXO37JmPFrmZaDWg4B4Qijoz0K25HeK00I7lRHmYg4+uC5pVeaVEM4pGcWfy?=
 =?us-ascii?Q?VSV+UsVYFoNTVFGFQEzpE5UIFE21K0CVVFZrvCOVf5PcdtKEceOmLDPdc/Hm?=
 =?us-ascii?Q?GdOvlg4AIg/tFPj3LQ8Gqf8YK/e+/soQp8r5nXe5bSFoyWdTv5+2VKa8dRPY?=
 =?us-ascii?Q?LrtToucSt7rX4T4mcmJhyQ2yCTVwymoALhZeXesOFXr0vNPEkLt8CXVLyD9e?=
 =?us-ascii?Q?FnmpZnY59lS22ayv8IfkwRDmiCcD3V29JbtpTXVqY39r4qlhe5KLIJbCJttx?=
 =?us-ascii?Q?3Mi6f2ArVk9qBoMY3F5HDt8FI0Jvz38qTy9Dyd45rSm22xu9xk00GPNaIpo7?=
 =?us-ascii?Q?YN1ri6tYUOKYHvMiwBIA3FhX1qwUo1gOu2uheu4TrBgsYX1nTtfPISZaB49v?=
 =?us-ascii?Q?HDG/5kAlE8FGe1SACvJ65iqJaRYQ9Ubdbnm4ewcRmquXyjK7QUsfE7D7SVeg?=
 =?us-ascii?Q?snf+ZTzxU8yxWrgjtV/jWo0YPsC+lpoS0oknunERUr52vyXsjYrblqr2R1Oj?=
 =?us-ascii?Q?rbjLqiqB/x7Dmq6ZRVKkqVvdpl2GF9mnE2JQqh4HGufa6mshRwGHEV6W/oi+?=
 =?us-ascii?Q?FbC0/zHX2rlYUApS6ag8UyOfA2BgZE9ksCSoUqyb18D8y4id6hQjFTGjRZLJ?=
 =?us-ascii?Q?gOx+/r6XcHfxmCXvs2URCkayH7qTlFodLJqa5eGKmQQllnXKqLs3HouoAgIH?=
 =?us-ascii?Q?YASxDno4GzdtVfpsIMpbOanALAc1YPQzxKMfyUvUEggGQl6Sf1hOgK+cAB0B?=
 =?us-ascii?Q?kuBC2vUnEHQMmDgEO65BeSzEGKU8SaOeo7bXFdDolTXlpelE3J+pn3ifPIlO?=
 =?us-ascii?Q?CP9PIzAIsJmBBOMQJ4Yf/77LuxRSUCm1Px3foaKi1+/mscrT/aiUhD5dsPWx?=
 =?us-ascii?Q?bxc3zvLSoqAckBoH7HMmbSoSV1Ghv0iZsA0u5CFMdhA3kCQA6veUF0TMqu1y?=
 =?us-ascii?Q?yv6h7pMpUQbR8nVa16xKSDo18V6WMJDaAnWsYgdlTck/5HBf8QxfxOLiyZxy?=
 =?us-ascii?Q?x1S/OjZSnMqf6u0t2EvHC8x98AOknc1FxHVOccGhBfDxUeTVgpDrke4Vz8oK?=
 =?us-ascii?Q?5reDrqpGnVziMdHuG+vI4bURKrD+YW1K3j1HF+WGegbD3Ii0fCp8AozmVRQM?=
 =?us-ascii?Q?HmELaXroNRI0TGLXkSum2dRQW6ySIrhby24IRK9c4e3C9IoxCAonYUwjO+yS?=
 =?us-ascii?Q?IzhdbMsq7FhRgu4wgk205o0CD9/0ASWrYSkcvO7YBtFVB+wwVQSHk+kXWhk+?=
 =?us-ascii?Q?S3tiN/ReHdBzuHWGJbMoPAfha3UlOVnMRb/U2OTQEKhS30coa3DGEfYTulMS?=
 =?us-ascii?Q?KUtfPyJcBoPL/JZq/uD/POXptAjdailnMe0k?=
X-Forefront-Antispam-Report:
	CIP:91.26.50.189;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:Diagnostix.phytec.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: phytec.fr
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 15:10:17.7342
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f21b0ac-5a0d-4983-f351-08ddbefab703
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29;Ip=[91.26.50.189];Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509ED.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P195MB0870

Add add alternate pinmux for following interfaces used on
phyBOARD-Sargas:
- UART4
- LTDC
- DCMI
- TIM5
- SAI2

Fix "ethernet0=5Frgmii=5Fpins=5Fd" pinmux used on phyCORE-STM32MP15x:
ETH=5FRGMII=5FGTX=5FCLK pin was missing.

Signed-off-by: Christophe Parant <c.parant@phytec.fr>
---
 arch/arm/boot/dts/st/stm32mp15-pinctrl.dtsi | 164 ++++++++++++++++++++
 1 file changed, 164 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32mp15-pinctrl.dtsi b/arch/arm/boot/dt=
s/st/stm32mp15-pinctrl.dtsi
index 40605ea85ee1..f242959e8716 100644
--- a/arch/arm/boot/dts/st/stm32mp15-pinctrl.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp15-pinctrl.dtsi
@@ -223,6 +223,45 @@ pins {
 		};
 	};
=20
+	/omit-if-no-ref/
+	dcmi=5Fpins=5Fd: dcmi-3 {
+		pins {
+			pinmux =3D <STM32=5FPINMUX('H', 8,  AF13)>,/* DCMI=5FHSYNC */
+				 <STM32=5FPINMUX('B', 7,  AF13)>,/* DCMI=5FVSYNC */
+				 <STM32=5FPINMUX('A', 6,  AF13)>,/* DCMI=5FPIXCLK */
+				 <STM32=5FPINMUX('H', 9,  AF13)>,/* DCMI=5FD0 */
+				 <STM32=5FPINMUX('C', 7,  AF13)>,/* DCMI=5FD1 */
+				 <STM32=5FPINMUX('E', 0,  AF13)>,/* DCMI=5FD2 */
+				 <STM32=5FPINMUX('E', 1,  AF13)>,/* DCMI=5FD3 */
+				 <STM32=5FPINMUX('H', 14, AF13)>,/* DCMI=5FD4 */
+				 <STM32=5FPINMUX('I', 4,  AF13)>,/* DCMI=5FD5 */
+				 <STM32=5FPINMUX('E', 5,  AF13)>,/* DCMI=5FD6 */
+				 <STM32=5FPINMUX('I', 7,  AF13)>,/* DCMI=5FD7 */
+				 <STM32=5FPINMUX('I', 1,  AF13)>,/* DCMI=5FD8 */
+				 <STM32=5FPINMUX('H', 7,  AF13)>;/* DCMI=5FD9 */
+			bias-disable;
+		};
+	};
+
+	/omit-if-no-ref/
+	dcmi=5Fsleep=5Fpins=5Fd: dcmi-sleep-3 {
+		pins {
+			pinmux =3D <STM32=5FPINMUX('H', 8,  ANALOG)>,/* DCMI=5FHSYNC */
+				 <STM32=5FPINMUX('B', 7,  ANALOG)>,/* DCMI=5FVSYNC */
+				 <STM32=5FPINMUX('A', 6,  ANALOG)>,/* DCMI=5FPIXCLK */
+				 <STM32=5FPINMUX('H', 9,  ANALOG)>,/* DCMI=5FD0 */
+				 <STM32=5FPINMUX('C', 7,  ANALOG)>,/* DCMI=5FD1 */
+				 <STM32=5FPINMUX('E', 0,  ANALOG)>,/* DCMI=5FD2 */
+				 <STM32=5FPINMUX('E', 1,  ANALOG)>,/* DCMI=5FD3 */
+				 <STM32=5FPINMUX('H', 14, ANALOG)>,/* DCMI=5FD4 */
+				 <STM32=5FPINMUX('I', 4,  ANALOG)>,/* DCMI=5FD5 */
+				 <STM32=5FPINMUX('E', 5,  ANALOG)>,/* DCMI=5FD6 */
+				 <STM32=5FPINMUX('I', 7,  ANALOG)>,/* DCMI=5FD7 */
+				 <STM32=5FPINMUX('I', 1,  ANALOG)>,/* DCMI=5FD8 */
+				 <STM32=5FPINMUX('H', 7,  ANALOG)>;/* DCMI=5FD9 */
+		};
+	};
+
 	/omit-if-no-ref/
 	ethernet0=5Frgmii=5Fpins=5Fa: rgmii-0 {
 		pins1 {
@@ -386,6 +425,7 @@ pins1 {
 	ethernet0=5Frgmii=5Fpins=5Fd: rgmii-3 {
 		pins1 {
 			pinmux =3D <STM32=5FPINMUX('G', 5, AF11)>, /* ETH=5FRGMII=5FCLK125 */
+				 <STM32=5FPINMUX('G', 4, AF11)>, /* ETH=5FRGMII=5FGTX=5FCLK */
 				 <STM32=5FPINMUX('G', 13, AF11)>,	/* ETH=5FRGMII=5FTXD0 */
 				 <STM32=5FPINMUX('G', 14, AF11)>,	/* ETH=5FRGMII=5FTXD1 */
 				 <STM32=5FPINMUX('C', 2, AF11)>, /* ETH=5FRGMII=5FTXD2 */
@@ -1304,6 +1344,65 @@ pins {
 		};
 	};
=20
+	/omit-if-no-ref/
+	ltdc=5Fpins=5Ff: ltdc-5 {
+		pins {
+			pinmux =3D <STM32=5FPINMUX('G', 7,  AF14)>, /* LCD=5FCLK */
+				 <STM32=5FPINMUX('I', 10, AF14)>, /* LCD=5FHSYNC */
+				 <STM32=5FPINMUX('I', 9,  AF14)>, /* LCD=5FVSYNC */
+				 <STM32=5FPINMUX('E', 13, AF14)>, /* LCD=5FDE */
+				 <STM32=5FPINMUX('C', 10, AF14)>, /* LCD=5FR2 */
+				 <STM32=5FPINMUX('B', 0,   AF9)>, /* LCD=5FR3 */
+				 <STM32=5FPINMUX('H', 10, AF14)>, /* LCD=5FR4 */
+				 <STM32=5FPINMUX('H', 11, AF14)>, /* LCD=5FR5 */
+				 <STM32=5FPINMUX('H', 12, AF14)>, /* LCD=5FR6 */
+				 <STM32=5FPINMUX('E', 15, AF14)>, /* LCD=5FR7 */
+				 <STM32=5FPINMUX('H', 13, AF14)>, /* LCD=5FG2 */
+				 <STM32=5FPINMUX('E', 11, AF14)>, /* LCD=5FG3 */
+				 <STM32=5FPINMUX('H', 15, AF14)>, /* LCD=5FG4 */
+				 <STM32=5FPINMUX('H', 4,   AF9)>, /* LCD=5FG5 */
+				 <STM32=5FPINMUX('I', 11,  AF9)>, /* LCD=5FG6 */
+				 <STM32=5FPINMUX('I', 2,  AF14)>, /* LCD=5FG7 */
+				 <STM32=5FPINMUX('G', 10, AF14)>, /* LCD=5FB2 */
+				 <STM32=5FPINMUX('G', 11, AF14)>, /* LCD=5FB3 */
+				 <STM32=5FPINMUX('E', 12, AF14)>, /* LCD=5FB4 */
+				 <STM32=5FPINMUX('I', 5,  AF14)>, /* LCD=5FB5 */
+				 <STM32=5FPINMUX('B', 8,  AF14)>, /* LCD=5FB6 */
+				 <STM32=5FPINMUX('D', 8,  AF14)>; /* LCD=5FB7 */
+			bias-disable;
+			drive-push-pull;
+			slew-rate =3D <1>;
+		};
+	};
+
+	/omit-if-no-ref/
+	ltdc=5Fsleep=5Fpins=5Ff: ltdc-sleep-5 {
+		pins {
+			pinmux =3D <STM32=5FPINMUX('G', 7,  ANALOG)>, /* LCD=5FCLK */
+				 <STM32=5FPINMUX('I', 10, ANALOG)>, /* LCD=5FHSYNC */
+				 <STM32=5FPINMUX('I', 9,  ANALOG)>, /* LCD=5FVSYNC */
+				 <STM32=5FPINMUX('E', 13, ANALOG)>, /* LCD=5FDE */
+				 <STM32=5FPINMUX('C', 10, ANALOG)>, /* LCD=5FR2 */
+				 <STM32=5FPINMUX('B', 0,  ANALOG)>, /* LCD=5FR3 */
+				 <STM32=5FPINMUX('H', 10, ANALOG)>, /* LCD=5FR4 */
+				 <STM32=5FPINMUX('H', 11, ANALOG)>, /* LCD=5FR5 */
+				 <STM32=5FPINMUX('H', 12, ANALOG)>, /* LCD=5FR6 */
+				 <STM32=5FPINMUX('E', 15, ANALOG)>, /* LCD=5FR7 */
+				 <STM32=5FPINMUX('H', 13, ANALOG)>, /* LCD=5FG2 */
+				 <STM32=5FPINMUX('E', 11, ANALOG)>, /* LCD=5FG3 */
+				 <STM32=5FPINMUX('H', 15, ANALOG)>, /* LCD=5FG4 */
+				 <STM32=5FPINMUX('H', 4,  ANALOG)>, /* LCD=5FG5 */
+				 <STM32=5FPINMUX('I', 11, ANALOG)>, /* LCD=5FG6 */
+				 <STM32=5FPINMUX('I', 2,  ANALOG)>, /* LCD=5FG7 */
+				 <STM32=5FPINMUX('G', 10, ANALOG)>, /* LCD=5FB2 */
+				 <STM32=5FPINMUX('G', 11, ANALOG)>, /* LCD=5FB3 */
+				 <STM32=5FPINMUX('E', 12, ANALOG)>, /* LCD=5FB4 */
+				 <STM32=5FPINMUX('I', 5,  ANALOG)>, /* LCD=5FB5 */
+				 <STM32=5FPINMUX('B', 8,  ANALOG)>, /* LCD=5FB6 */
+				 <STM32=5FPINMUX('D', 8,  ANALOG)>; /* LCD=5FB7 */
+		};
+	};
+
 	/omit-if-no-ref/
 	mco1=5Fpins=5Fa: mco1-0 {
 		pins {
@@ -1644,6 +1743,23 @@ pins {
 		};
 	};
=20
+	/omit-if-no-ref/
+	pwm5=5Fpins=5Fc: pwm5-2 {
+		pins {
+			pinmux =3D <STM32=5FPINMUX('I', 0, AF2)>; /* TIM5=5FCH4 */
+			bias-pull-down;
+			drive-push-pull;
+			slew-rate =3D <0>;
+		};
+	};
+
+	/omit-if-no-ref/
+	pwm5=5Fsleep=5Fpins=5Fc: pwm5-sleep-2 {
+		pins {
+			pinmux =3D <STM32=5FPINMUX('I', 0, ANALOG)>; /* TIM5=5FCH4 */
+		};
+	};
+
 	/omit-if-no-ref/
 	pwm8=5Fpins=5Fa: pwm8-0 {
 		pins {
@@ -1869,6 +1985,21 @@ pins {
 		};
 	};
=20
+	/omit-if-no-ref/
+	sai2a=5Fpins=5Fd: sai2a-3 {
+		pins {
+			pinmux =3D <STM32=5FPINMUX('I', 6, AF10)>; /* SAI2=5FSD=5FA */
+			bias-disable;
+		};
+	};
+
+	/omit-if-no-ref/
+	sai2a=5Fsleep=5Fpins=5Fd: sai2a-3 {
+		pins {
+			pinmux =3D <STM32=5FPINMUX('I', 6, ANALOG)>; /* SAI2=5FSD=5FA */
+		};
+	};
+
 	/omit-if-no-ref/
 	sai2b=5Fpins=5Fa: sai2b-0 {
 		pins1 {
@@ -2856,6 +2987,39 @@ pins {
 		};
 	};
=20
+	/omit-if-no-ref/
+	uart4=5Fpins=5Ff: uart4-5 {
+		pins1 {
+			pinmux =3D <STM32=5FPINMUX('B', 9, AF8)>; /* UART4=5FTX */
+			bias-disable;
+			drive-push-pull;
+			slew-rate =3D <0>;
+		};
+		pins2 {
+			pinmux =3D <STM32=5FPINMUX('B', 2, AF8)>; /* UART4=5FRX */
+			bias-disable;
+		};
+	};
+
+	/omit-if-no-ref/
+	uart4=5Fidle=5Fpins=5Ff: uart4-idle-5 {
+		pins1 {
+			pinmux =3D <STM32=5FPINMUX('B', 9, ANALOG)>; /* UART4=5FTX */
+		};
+		pins2 {
+			pinmux =3D <STM32=5FPINMUX('B', 2, AF8)>; /* UART4=5FRX */
+			bias-disable;
+		};
+	};
+
+	/omit-if-no-ref/
+	uart4=5Fsleep=5Fpins=5Ff: uart4-sleep-5 {
+		pins {
+			pinmux =3D <STM32=5FPINMUX('B', 9, ANALOG)>, /* UART4=5FTX */
+				 <STM32=5FPINMUX('B', 2, ANALOG)>; /* UART4=5FRX */
+		};
+	};
+
 	/omit-if-no-ref/
 	uart5=5Fpins=5Fa: uart5-0 {
 		pins1 {
--=20
2.34.1


