Return-Path: <linux-kernel+bounces-723992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3226AFED57
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 17:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EEAA1C83254
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072342EA148;
	Wed,  9 Jul 2025 15:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="zWYZLf8q"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2118.outbound.protection.outlook.com [40.107.22.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53472E5B1B;
	Wed,  9 Jul 2025 15:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752073829; cv=fail; b=pSpha6VA+h/P0qFb0HDAkwEuh7KuOqPtCWp+8ONjGvpUHMmvPCETMCN26D46sjzfSOPoSdZzfJH0w/EoMBtEa4eKxXmIjchUKF5ALdD3BMG3hsP9ibX+XFe9sgPucTvrSTqvutzutwEUGUGacpVStxscQZfFj3AKWx/4f66TmWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752073829; c=relaxed/simple;
	bh=PQOr43K7iSmJMsTvhwWkwh/vkcVbm5vllrCge5FK5Ws=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pKvhApfo7B1VsremCPKKX5I7i2sNIGnXxgtohcanZdNfuekdU32ghuBSkXwU1DfRfqIB7R5cBHKprT7Zfaj7Fw3iyWdLIEkiI5OpmL/RDat1kG4l/fD/rHLsvi2EzkGSQktZjl58wRy/2nmugM87aDWENA7zhBIs+djPHBLGuHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.fr; spf=pass smtp.mailfrom=phytec.fr; dkim=pass (1024-bit key) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b=zWYZLf8q; arc=fail smtp.client-ip=40.107.22.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bcNbfPVn8SMB7UjHG/qVk8wY0n1VUxn9wP/MA5RpLGxYjUxypW2SE1FFccbaVsgH8Ua3A8I1+IqjhbLpLm6HEVdAij/BQ+x0fSi4p9df88DIhs1+0C2ox2SqxHkMNAOajFNh1MXeCnNpqYfij4eztzz7fKxk4VYsTtO9HkQGUVUBMdcWnAX34TsaaHOiHHyQYnU/e/JlaRaplG97qNuZ0pP2y7m/bAX6BmVMiw1F1qQwva/LscQAyeG+2OOxGYSnxNqrWHWlds2owASqlrSgG1bXaWiIvBJLtiFlMpx9eE7xJY5niAGeuccJSAEGzsVqppNCGawFpmSipj+RYHWw5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lpfOP6nVzFQd8td4sEBfBVUt3CSkiSnlTBSJ6IZIjG8=;
 b=NcTrihkWZtQhYbmVGEp+l+fP2PTj4eX1hBW/wdWH2Etyssx1FrJTPzjscNFB6Cgp3yhZE7OhxC3Pywgh6UOWmOBX1jyCx1MmpdInGIpczlqgdcrIlYH47lRwVEEsGFhZ7S9vXHqnb2td0glO8igzj8KKxnQpZ3Ur5sO/yfpqtl6rgA4AIShavDc6X6LhpD5wjU1vv1OMdVLJtB9eP/SlgoWxayyA53J/yogtDxyXT86ma3Vju+8eGMcT9G0+OkYJkpAUJgzpl2eXk4n6MVnXGA1QYxvK/KHbIB2IfQ64k0oTd8a5xCtmZdRH3bCHqMHS6CsXdR5nm0ATjg7o7VXXNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 91.26.50.189) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=phytec.fr;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.fr; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lpfOP6nVzFQd8td4sEBfBVUt3CSkiSnlTBSJ6IZIjG8=;
 b=zWYZLf8qCdJN63Q6OEml2c8urOTX5mVChBiQEUya3cStBC/b7Tf7WDVnoZ+3PMa2sKU9HoETwSCMl9RqKwSFdh+djggiAjtIwo0ebtECrcLulEJuqhfxgO6v9HNFVZl5gUVGPYZMJBlxwuecQIeOVlCWTvJps0L/w78e2yOMHrc=
Received: from DB7PR02CA0007.eurprd02.prod.outlook.com (2603:10a6:10:52::20)
 by DB8P195MB0535.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:158::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Wed, 9 Jul
 2025 15:10:21 +0000
Received: from DB1PEPF000509ED.eurprd03.prod.outlook.com
 (2603:10a6:10:52:cafe::c8) by DB7PR02CA0007.outlook.office365.com
 (2603:10a6:10:52::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.21 via Frontend Transport; Wed,
 9 Jul 2025 15:10:21 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.fr; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.fr;
Received-SPF: Fail (protection.outlook.com: domain of phytec.fr does not
 designate 91.26.50.189 as permitted sender) receiver=protection.outlook.com;
 client-ip=91.26.50.189; helo=Diagnostix.phytec.de;
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB1PEPF000509ED.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Wed, 9 Jul 2025 15:10:21 +0000
Received: from Diagnostix.phytec.de (172.25.0.14) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 9 Jul
 2025 17:10:16 +0200
Received: from idefix.phytec.de (172.25.0.20) by mailrelayint.phytec.de
 (172.25.0.14) with Microsoft SMTP Server id 15.1.2507.57 via Frontend
 Transport; Wed, 9 Jul 2025 17:10:16 +0200
Received: from pc.home ([172.25.39.2])
          by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
          with ESMTP id 2025070917101623-216 ;
          Wed, 9 Jul 2025 17:10:16 +0200 
From: Christophe Parant <c.parant@phytec.fr>
To: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
	<upstream@lists.phytec.de>
Subject: [PATCH v2 10/11] ARM: dts: stm32: phyboard-sargas and phycore: Fix coding style issues
Date: Wed, 9 Jul 2025 17:10:10 +0200
Message-ID: <20250709151011.366537-11-c.parant@phytec.fr>
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
 09.07.2025 17:10:16,
	Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 09.07.2025 17:10:16
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509ED:EE_|DB8P195MB0535:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e1e2e4d-d4f6-4e87-f1c0-08ddbefab944
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R+7AoQGNHyBaoNMtoeMrjstZt6B5szFcS8n8IoC6x4IG8r1rodFCekcUfcxl?=
 =?us-ascii?Q?Yh/s3nm9Zo9cD3Qnh3l56RyQcrBn/4kgf6Zz3k1w9AhtqgtY2ZSRQL5TLra8?=
 =?us-ascii?Q?CDQRr88VBGr4vw5TxHYm+wiXuVXVk1sx/+nVTUZkFdnnODhnaGMmvkR00ctk?=
 =?us-ascii?Q?LZf6KI1j2nnMEM91M7WjOo/bNIgP1mKGX/zhdxxEelrtL4jO2mEZ5ptL8jCj?=
 =?us-ascii?Q?hPwtVi4wDAvTQuHKIFdFQhAwDL/dTf16R51o0J9/ezMkL0qv2mb/8Cc14bsU?=
 =?us-ascii?Q?SOE/6tuakckLo4F6H+6igTg6bg5PF/shVkExY5VISQg76erMKPmGtjARasXL?=
 =?us-ascii?Q?E5SIBa8yxTtWm1PgInvKurrO8sz+aItnjaUAOVfHtzVeUhAP461QdXLtWYy/?=
 =?us-ascii?Q?neAkjUJZkdpeU/r8tnd+PttEbRqtdkFQPVyrRn8W1eTLiWVGuESRGtVb/hWX?=
 =?us-ascii?Q?0c+xqfAbIQTzqWLSUtlIL0Kc3vHQjapSPp3PDuJuV1SL2Temi3pRS5neeE5d?=
 =?us-ascii?Q?OFYHEi4hDKf73MyCZ+lKHP+uNfO+2fyhT1ZXPUsJX/9wNBKTGJwpK6GssStU?=
 =?us-ascii?Q?G6OgjHpfN0h0EB0z4wZsuQ0FHLhQgqjsa8/ONnJuWXVVWuroR8wuK/rrYLOJ?=
 =?us-ascii?Q?MNRGQcR/N3cm71wsj5CTi8wlYRwlY9Qh7m6d6M3XdmGTZrMz6YGcEEMRTTCp?=
 =?us-ascii?Q?Wt+rbfhGPZ4luR/2SB4ypy3TBO3TWeEIyEYdsYvvzvRdG3TrPE1kMRsIV/7S?=
 =?us-ascii?Q?nC+rj7157MJOuzAOOre7/VyrtgSIy9jC1V4Of8m30rvYetojTXObHN0snVmk?=
 =?us-ascii?Q?e6fzJs0W4EozpsJ3Y2+I1AVLPZot4Dzj3cRmt+7eeCvY8J364VJodFYY7gYr?=
 =?us-ascii?Q?FlKtd/p6BBNdnnB/EeiZYW2cLowJDxo7S7CrDhhWrP4eF/SVX1Bw/X/yhAB8?=
 =?us-ascii?Q?/bTWwkQicHhsnh4baY3kxWIGMzTMMLewSG2//mWxS7wXpyerx9xyazMY4O48?=
 =?us-ascii?Q?2g22ufMv5e780Br6MWIxDzrIiM/D5dDDUI1WNwmcFQuISEuMNv4+I0VZ+0ys?=
 =?us-ascii?Q?uyWV1+0UsIQyIGSk/scBDI9x9TA5p5ptvPXuJpICitzRNVPof+6Mf5so10Be?=
 =?us-ascii?Q?wNHCdYL1pDiouUIj6yZ7rK9AH5GhORlCSpy2PX0CalswlKfnV42M63sq1HdQ?=
 =?us-ascii?Q?rtJUOBUZwkPxxyt2rzwEwfqdpXSl5XBbKsOOAv1fmtIniU0QbSUTnkg/E4ie?=
 =?us-ascii?Q?NBFkTUEBDgPKnd2jDGJJwSQ74FKeh/KrcLomjs++MXzYo7JQ83R+W4z8iRYI?=
 =?us-ascii?Q?OE5aBBS80yXYwyTbnz8gE+nK/r4eM5qUnHSfoPVIewmHWviIM23u9IhE294G?=
 =?us-ascii?Q?37mx0r9L4R83VNu6cCAeDEFEqKodI+3m/t+O0HdjYKSt6Lq6JIDHPKahDqA5?=
 =?us-ascii?Q?erH0Z/9TMIoAsRCvCXSERqt1QLd8FM6xjQGs1AJFLfYj2T5JsEth+YWYKUb9?=
 =?us-ascii?Q?736NEaEY7BiML07yJZMchqO80mBdm4BgxWcJ?=
X-Forefront-Antispam-Report:
	CIP:91.26.50.189;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:Diagnostix.phytec.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: phytec.fr
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 15:10:21.5162
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e1e2e4d-d4f6-4e87-f1c0-08ddbefab944
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29;Ip=[91.26.50.189];Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509ED.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P195MB0535

- Remove "stm32-pinfunc.h" include as it is already include in
"stm32mp15-pinctrl.dtsi" file.
- reserved-memory: reorder the memory sections (lower to higher
  addresses).
- Move vendor properties (go last).
- Remove useless compatible values:
  - QSPI flash: remove the winbond compatible. jedec is enought as the
    NOR flahses are detectable.
  - EEPROM: "atmel,24c32" is enought.
- Use uppercase for regulator-name properties.
- In pmic node: use the names from the PHYTEC SoM schematics.
- stmpe811 touch: fix dts schema to comply with st,stmpe.yaml.
- Fix one "multiple blank lines" detected by checkpatch.

Signed-off-by: Christophe Parant <c.parant@phytec.fr>
---
 .../st/stm32mp157c-phyboard-sargas-rdk.dts    |  1 -
 .../dts/st/stm32mp15xx-phyboard-sargas.dtsi   | 13 ++--
 .../boot/dts/st/stm32mp15xx-phycore-som.dtsi  | 64 +++++++++----------
 3 files changed, 36 insertions(+), 42 deletions(-)

diff --git a/arch/arm/boot/dts/st/stm32mp157c-phyboard-sargas-rdk.dts b/arc=
h/arm/boot/dts/st/stm32mp157c-phyboard-sargas-rdk.dts
index c90b12a479c9..c18a37266083 100644
--- a/arch/arm/boot/dts/st/stm32mp157c-phyboard-sargas-rdk.dts
+++ b/arch/arm/boot/dts/st/stm32mp157c-phyboard-sargas-rdk.dts
@@ -6,7 +6,6 @@
=20
 /dts-v1/;
=20
-#include <dt-bindings/pinctrl/stm32-pinfunc.h>
 #include "stm32mp157.dtsi"
 #include "stm32mp15xc.dtsi"
 #include "stm32mp15xx-phycore-som.dtsi"
diff --git a/arch/arm/boot/dts/st/stm32mp15xx-phyboard-sargas.dtsi b/arch/a=
rm/boot/dts/st/stm32mp15xx-phyboard-sargas.dtsi
index 9578e78bcc1d..20684b497c99 100644
--- a/arch/arm/boot/dts/st/stm32mp15xx-phyboard-sargas.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp15xx-phyboard-sargas.dtsi
@@ -5,7 +5,6 @@
  * Author: Dom VOVARD <dom.vovard@linrt.com>.
  */
=20
-
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/leds/common.h>
@@ -101,13 +100,13 @@ touch@44 {
 		interrupt-parent =3D <&gpioi>;
 		vio-supply =3D <&v3v3>;
 		vcc-supply =3D <&v3v3>;
+		st,sample-time =3D <4>;
+		st,mod-12b =3D <1>;
+		st,ref-sel =3D <0>;
+		st,adc-freq =3D <1>;
=20
 		touchscreen {
 			compatible =3D "st,stmpe-ts";
-			st,sample-time =3D <4>;
-			st,mod-12b =3D <1>;
-			st,ref-sel =3D <0>;
-			st,adc-freq =3D <1>;
 			st,ave-ctrl =3D <1>;
 			st,touch-det-delay =3D <2>;
 			st,settling =3D <2>;
@@ -159,10 +158,10 @@ &sai2 {
=20
 &sai2a {
 	dma-names =3D "rx";
-	st,sync =3D <&sai2b 2>;
 	clocks =3D <&rcc SAI2=5FK>, <&sai2b>;
 	clock-names =3D "sai=5Fck", "MCLK";
 	#clock-cells =3D <0>;
+	st,sync =3D <&sai2b 2>;
=20
 	sai2a=5Fport: port {
 		sai2a=5Fendpoint: endpoint {
@@ -195,9 +194,9 @@ &sdmmc1 {
 	pinctrl-2 =3D <&sdmmc1=5Fb4=5Fsleep=5Fpins=5Fb>;
 	cd-gpios =3D <&gpiof 3 GPIO=5FACTIVE=5FLOW>;
 	disable-wp;
-	st,neg-edge;
 	bus-width =3D <4>;
 	vmmc-supply =3D <&v3v3>;
+	st,neg-edge;
 	status =3D "okay";
 };
=20
diff --git a/arch/arm/boot/dts/st/stm32mp15xx-phycore-som.dtsi b/arch/arm/b=
oot/dts/st/stm32mp15xx-phycore-som.dtsi
index 3f60f184978c..0689967b8c56 100644
--- a/arch/arm/boot/dts/st/stm32mp15xx-phycore-som.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp15xx-phycore-som.dtsi
@@ -36,18 +36,6 @@ reserved-memory {
 		#size-cells =3D <1>;
 		ranges;
=20
-		retram: retram@38000000 {
-			compatible =3D "shared-dma-pool";
-			reg =3D <0x38000000 0x10000>;
-			no-map;
-		};
-
-		mcuram: mcuram@30000000 {
-			compatible =3D "shared-dma-pool";
-			reg =3D <0x30000000 0x40000>;
-			no-map;
-		};
-
 		mcuram2: mcuram2@10000000 {
 			compatible =3D "shared-dma-pool";
 			reg =3D <0x10000000 0x40000>;
@@ -71,11 +59,22 @@ vdev0buffer: vdev0buffer@10042000 {
 			reg =3D <0x10042000 0x4000>;
 			no-map;
 		};
+		mcuram: mcuram@30000000 {
+			compatible =3D "shared-dma-pool";
+			reg =3D <0x30000000 0x40000>;
+			no-map;
+		};
+
+		retram: retram@38000000 {
+			compatible =3D "shared-dma-pool";
+			reg =3D <0x38000000 0x10000>;
+			no-map;
+		};
 	};
=20
 	regulator=5Fvin: regulator {
 		compatible =3D "regulator-fixed";
-		regulator-name =3D "vin";
+		regulator-name =3D "VIN";
 		regulator-min-microvolt =3D <5000000>;
 		regulator-max-microvolt =3D <5000000>;
 		regulator-always-on;
@@ -102,11 +101,11 @@ phy0: ethernet-phy@1 {
 			reg =3D <1>;
 			interrupt-parent =3D <&gpiog>;
 			interrupts =3D <12 IRQ=5FTYPE=5FEDGE=5FFALLING>;
+			enet-phy-lane-no-swap;
 			ti,rx-internal-delay =3D <DP83867=5FRGMIIDCTL=5F2=5F00=5FNS>;
 			ti,tx-internal-delay =3D <DP83867=5FRGMIIDCTL=5F2=5F00=5FNS>;
 			ti,fifo-depth =3D <DP83867=5FPHYCR=5FFIFO=5FDEPTH=5F4=5FB=5FNIB>;
 			ti,min-output-impedance;
-			enet-phy-lane-no-swap;
 			ti,clk-output-sel =3D <DP83867=5FCLK=5FO=5FSEL=5FOFF>;
 		};
 	};
@@ -144,7 +143,7 @@ regulators {
 			pwr=5Fsw2-supply =3D <&bst=5Fout>;
=20
 			vddcore: buck1 {
-				regulator-name =3D "vddcore";
+				regulator-name =3D "VDD=5FCORE";
 				regulator-min-microvolt =3D <1200000>;
 				regulator-max-microvolt =3D <1350000>;
 				regulator-always-on;
@@ -152,7 +151,7 @@ vddcore: buck1 {
 			};
=20
 			vdd=5Fddr: buck2 {
-				regulator-name =3D "vdd=5Fddr";
+				regulator-name =3D "VDD=5FDDR";
 				regulator-min-microvolt =3D <1350000>;
 				regulator-max-microvolt =3D <1350000>;
 				regulator-always-on;
@@ -160,7 +159,7 @@ vdd=5Fddr: buck2 {
 			};
=20
 			vdd: buck3 {
-				regulator-name =3D "vdd";
+				regulator-name =3D "VDD";
 				regulator-min-microvolt =3D <3300000>;
 				regulator-max-microvolt =3D <3300000>;
 				regulator-always-on;
@@ -169,7 +168,7 @@ vdd: buck3 {
 			};
=20
 			v3v3: buck4 {
-				regulator-name =3D "v3v3";
+				regulator-name =3D "VDD=5FBUCK4";
 				regulator-min-microvolt =3D <3300000>;
 				regulator-max-microvolt =3D <3300000>;
 				regulator-always-on;
@@ -177,7 +176,7 @@ v3v3: buck4 {
 			};
=20
 			v1v8=5Faudio: ldo1 {
-				regulator-name =3D "v1v8=5Faudio";
+				regulator-name =3D "VDD=5FLDO1";
 				regulator-min-microvolt =3D <1800000>;
 				regulator-max-microvolt =3D <1800000>;
 				regulator-always-on;
@@ -186,7 +185,7 @@ v1v8=5Faudio: ldo1 {
 			};
=20
 			vdd=5Feth=5F2v5: ldo2 {
-				regulator-name =3D "dd=5Feth=5F2v5";
+				regulator-name =3D "VDD=5FETH=5F2V5";
 				regulator-min-microvolt =3D <2500000>;
 				regulator-max-microvolt =3D <2500000>;
 				regulator-always-on;
@@ -195,7 +194,7 @@ vdd=5Feth=5F2v5: ldo2 {
 			};
=20
 			vtt=5Fddr: ldo3 {
-				regulator-name =3D "vtt=5Fddr";
+				regulator-name =3D "VTT=5FDDR";
 				regulator-min-microvolt =3D <500000>;
 				regulator-max-microvolt =3D <750000>;
 				regulator-always-on;
@@ -203,12 +202,12 @@ vtt=5Fddr: ldo3 {
 			};
=20
 			vdd=5Fusb: ldo4 {
-				regulator-name =3D "vdd=5Fusb";
+				regulator-name =3D "VDD=5FUSB";
 				interrupts =3D <IT=5FCURLIM=5FLDO4 0>;
 			};
=20
 			vdda: ldo5 {
-				regulator-name =3D "vdda";
+				regulator-name =3D "VDDA";
 				regulator-min-microvolt =3D <2900000>;
 				regulator-max-microvolt =3D <2900000>;
 				interrupts =3D <IT=5FCURLIM=5FLDO5 0>;
@@ -216,7 +215,7 @@ vdda: ldo5 {
 			};
=20
 			vdd=5Feth=5F1v0: ldo6 {
-				regulator-name =3D "vdd=5Feth=5F1v0";
+				regulator-name =3D "VDD=5FETH=5F1V0";
 				regulator-min-microvolt =3D <1000000>;
 				regulator-max-microvolt =3D <1000000>;
 				regulator-always-on;
@@ -225,23 +224,23 @@ vdd=5Feth=5F1v0: ldo6 {
 			};
=20
 			vref=5Fddr: vref=5Fddr {
-				regulator-name =3D "vref=5Fddr";
+				regulator-name =3D "VDD=5FREFDDR";
 				regulator-always-on;
 			};
=20
 			bst=5Fout: boost {
-				regulator-name =3D "bst=5Fout";
+				regulator-name =3D "BST=5FOUT";
 				interrupts =3D <IT=5FOCP=5FBOOST 0>;
 			};
=20
 			vbus=5Fotg: pwr=5Fsw1 {
-				regulator-name =3D "vbus=5Fotg";
+				regulator-name =3D "VBUS=5FOTG";
 				interrupts =3D <IT=5FOCP=5FOTG 0>;
 				regulator-active-discharge =3D <1>;
 			};
=20
 			vbus=5Fsw: pwr=5Fsw2 {
-				regulator-name =3D "vbus=5Fsw";
+				regulator-name =3D "VBUS=5FSW";
 				interrupts =3D <IT=5FOCP=5FSWOUT 0>;
 				regulator-active-discharge =3D <1>;
 			};
@@ -262,8 +261,7 @@ watchdog {
 	};
=20
 	i2c4=5Feeprom: eeprom@50 {
-		compatible =3D "microchip,24c32",
-			     "atmel,24c32";
+		compatible =3D "atmel,24c32";
 		reg =3D <0x50>;
 		status =3D "disabled";
 	};
@@ -312,13 +310,11 @@ &qspi=5Fbk1=5Fsleep=5Fpins=5Fa
 	status =3D "disabled";
=20
 	flash0: flash@0 {
-		compatible =3D "winbond,w25q128", "jedec,spi-nor";
+		compatible =3D "jedec,spi-nor";
 		reg =3D <0>;
 		spi-rx-bus-width =3D <4>;
 		spi-max-frequency =3D <50000000>;
 		m25p,fast-read;
-		#address-cells =3D <1>;
-		#size-cells =3D <1>;
 	};
 };
=20
@@ -342,10 +338,10 @@ &sdmmc2 {
 	non-removable;
 	no-sd;
 	no-sdio;
-	st,neg-edge;
 	bus-width =3D <8>;
 	vmmc-supply =3D <&v3v3>;
 	vqmmc-supply =3D <&v3v3>;
 	mmc-ddr-3=5F3v;
+	st,neg-edge;
 	status =3D "disabled";
 };
--=20
2.34.1


