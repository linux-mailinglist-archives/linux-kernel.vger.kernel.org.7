Return-Path: <linux-kernel+bounces-723993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AD1AFED70
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 17:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 996D77BBD0D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E00A2EA462;
	Wed,  9 Jul 2025 15:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="oEOJ+mn3"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2097.outbound.protection.outlook.com [40.107.103.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC00A2E9735;
	Wed,  9 Jul 2025 15:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752073831; cv=fail; b=d7qDubeumLsVNeps6QAGqdNh1IKoHAnuzAPgdckyASTMuhCUKYpaagG+L1S7VfA+xap4rsRjrDQ0MCS/OSCjyJlrFNmEt2HXYtxKFkLIaxrNqjSzjKUdIpGfuhY+RIt1zUcb1CLLFkKYuBrQAarL6aYd+0F59XQXiBubqlHCnQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752073831; c=relaxed/simple;
	bh=qdEoF6sTPO3+ZvEHc2FeRqPfmIYQLAJKPy5sAQUAQ8E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FtCrrbDoZ76X2Sg18cfxSiPTmFwOKmqnwxe96X+W94OIyLsLTeQkc1+y6s11+ukGPMPo9OeMj9EBIcS6nicSvvqASvIepjWrSz0cFcX+B2RQks2CnGcyuPwlBOeVg7kSa/KfHx/oRnvqe19hctCe1NGV+nfUIN2S47rQz4T7bzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.fr; spf=pass smtp.mailfrom=phytec.fr; dkim=pass (1024-bit key) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b=oEOJ+mn3; arc=fail smtp.client-ip=40.107.103.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ihu6WlxZUK1RwtoTuj+caM7us4hmENeYsfZXYy0GYoEbnbBcL6ziURfGH3YXR+N83ijyGhNuh4YokJYAKazfAfgMQ2Y9vmF6Wyri1wtmQ8jxPtACi3jzHkEOwmRAsvQjvJYKirL+72cy47oty19WWFSL9WQ2j+gP/rXW46dXBtUrV6Fy0l7Q7kykaCIdmF+W4d+00qfZ4NJPmieWjndEERHupHY3cEen1Jy+D/JJe59pmFygwacsUo6SoTwsoX+b207Q9E9I2SYJe7lTMCsvbMaRLsD2wjNUX36jpy2KV+iOB6iWW9mLxlXBvaFh0cLHbBNoTwk6EtrF5QE29zBj3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kla48VDQaXoq44k8Gp1jJDMLbDayWVkeuVZylDDSmFI=;
 b=bOMYFAh03yXtXDZGdYce3jI641rnBa4h7W21bI2mTgKd1s6zK8eHQoZvfmeNb0pxgU1ZaPT4AeUm2kEVM99CmPerEsOBS1zhsMvR4wVoAtlBHbUkX4U60ULgnSK5yFzqNJvi7UWYfqQq8l4ted5FqbObdG0niF4nDGtz2t/ZRHA+xGiS1fR2ZVWqpYCYI+oM7gG2BGmAuWy8PFROwWHveqTZQ2Sm/GvwnifXEPr3q19Yme3ZcTCJgcWaJgsJNQJF7Dq+XDcYPa85elDKBwdEQyzIR2g62ZFf3ny4dJl+D6CXWRsmeMEq5N5M8Dc9w18RhcuOzHipk63S2oU0VqFNqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 91.26.50.189) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=phytec.fr;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.fr; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kla48VDQaXoq44k8Gp1jJDMLbDayWVkeuVZylDDSmFI=;
 b=oEOJ+mn3XJBJ6ExY6cyw1wwTZ//Nyx1DOY+3jbzNgLea6OUTfQnbyW5aUuY20XUInetDKaGeVfT7k9cjAAUyJsa6F5q0s+QfMYpOjMGFeDJaUpelN868UC79e8+AFM5s/6wu0PnD4Fk27UXc9EC9jP20yBzabfu/LShDcCXDBDg=
Received: from DB7PR02CA0005.eurprd02.prod.outlook.com (2603:10a6:10:52::18)
 by DU0P195MB1592.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:34f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Wed, 9 Jul
 2025 15:10:24 +0000
Received: from DB1PEPF000509ED.eurprd03.prod.outlook.com
 (2603:10a6:10:52:cafe::9d) by DB7PR02CA0005.outlook.office365.com
 (2603:10a6:10:52::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22 via Frontend Transport; Wed,
 9 Jul 2025 15:10:24 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.fr; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.fr;
Received-SPF: Fail (protection.outlook.com: domain of phytec.fr does not
 designate 91.26.50.189 as permitted sender) receiver=protection.outlook.com;
 client-ip=91.26.50.189; helo=Diagnostix.phytec.de;
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB1PEPF000509ED.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Wed, 9 Jul 2025 15:10:24 +0000
Received: from Diagnostix.phytec.de (172.25.0.14) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 9 Jul
 2025 17:10:16 +0200
Received: from idefix.phytec.de (172.25.0.20) by mailrelayint.phytec.de
 (172.25.0.14) with Microsoft SMTP Server id 15.1.2507.57 via Frontend
 Transport; Wed, 9 Jul 2025 17:10:16 +0200
Received: from pc.home ([172.25.39.2])
          by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
          with ESMTP id 2025070917101667-217 ;
          Wed, 9 Jul 2025 17:10:16 +0200 
From: Christophe Parant <c.parant@phytec.fr>
To: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
	<upstream@lists.phytec.de>
Subject: [PATCH v2 11/11] ARM: dts: stm32: phyboard-sargas and phycore: Add optional interfaces
Date: Wed, 9 Jul 2025 17:10:11 +0200
Message-ID: <20250709151011.366537-12-c.parant@phytec.fr>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509ED:EE_|DU0P195MB1592:EE_
X-MS-Office365-Filtering-Correlation-Id: b64c8d2f-5e5b-4502-6cae-08ddbefabad1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MlFmiSRXurVL/M3GzaCeTW27nvqeobwz3qelA34kJI/TCc7kSqnq5uqs28fO?=
 =?us-ascii?Q?AF76b2vuGICjKJ9RnsPikt91wC2oyjqDYcWiatyFLKdIM1w0FCn4N1ULRIBv?=
 =?us-ascii?Q?/3O0R5NPxg8awvNYvLcchBK/WfUg8zjlMbuGtg+2LxoK/VxCXKngJ2fYqdRT?=
 =?us-ascii?Q?xCTzb/jxHQev5f7ti+pQfzFbkgHzrCcLyJBuI4UonfwxPFi2dwBv0wZKXSuk?=
 =?us-ascii?Q?RhBXfnIxiIY3InGe0kHclTKuRVuaVV8g1owJgUvmhTEARo0sA6109xtJ4X/I?=
 =?us-ascii?Q?D3tWBVj+5o8K5rVA3HoJvjBOIqFJLD4pMiJ19qIbu3V8Ob7SSZlCZ7cHWmgQ?=
 =?us-ascii?Q?3e0GmajxEQ30WdlsYher1n8AV9HhRmVRkbtY7Cri7n+wLd93/Caf3Y/8C1Cz?=
 =?us-ascii?Q?XE676zTT4puzNF4gxQ5jR41KHzqQUCF8zCWt5ITjEM8IzSLSrLq6sO3eBae7?=
 =?us-ascii?Q?2rijglPGcOrPF3t9exrojJPrrgpCTOU2UAyKeFaGWZyqwYoBGJRq4buaR/42?=
 =?us-ascii?Q?XQo+ONIqKP1JeHT4JmmDDwRhaTPiSvYr3YCSULTQM2/Tg4l4MMnjR0ZMohWt?=
 =?us-ascii?Q?DgY7RIudFChl66BtgqIaN1q3gEu/zT6uDfAOm1TPcb/CIG/nXAgplqnGFzU3?=
 =?us-ascii?Q?PCZachWA1BZwdKOYa6k4ReUK/oxKA1MhibuhzRA3JhRDR5fljr3p9k/FdxDK?=
 =?us-ascii?Q?vhwjGexaQ1TowFPHLIAL86vx9fbkTSUdtnPjN/nnPfr0it8Ol1GmGrVnIDbz?=
 =?us-ascii?Q?pZD9HXcssZfcdrGEctxc72axkO6gzCZlmyryeI/WoGytqDLC/I1YamNCypd8?=
 =?us-ascii?Q?8GZ1FNu7QrbDSvh5IhugLAQBiVn6muRMFXN2Z2BOyjN+fvW0cndQ/wY5hxmb?=
 =?us-ascii?Q?dgrM/by2Tm0K3uuXjHGuLuLRoJxbp2E6lUF+VVbE2mca/qTZwo3t8liKjnXT?=
 =?us-ascii?Q?u78QJChte/AIszf5aPdpI2wNoDFYdjx4f/zFNKR8koo7pZYiqVBAeRuv4+lu?=
 =?us-ascii?Q?yofqymsDYe/Qp3vraCdUw1Daa3k1jGtaMR5202tVJ/iALv8JnN1xvFyrjVba?=
 =?us-ascii?Q?5P8uenisI2KgorxxV1pF18As3hvYaduulDe4YmF8gmmt0PPQBMA4uiH2d6sB?=
 =?us-ascii?Q?qO7mLtXVkBXdMx8D7ab+TyX81KBBclKbU6x7fDvDYjIbJu2yl/4020RSNVJF?=
 =?us-ascii?Q?1qK7TDve/CGPJyqoOn85FM+I5kHoSu8+IKEPBgVXZxxfoLpb1XZmiSLQg2/h?=
 =?us-ascii?Q?JkBaIS+ikML6faLH5NtJ1vi7/nfL+bAAORtSvEYUK/xWxozbTkKeBP3ZU8jt?=
 =?us-ascii?Q?HWhtpVrUFqMDO9GKZS4ri8CgxgF/UfIPz3seDWJ72rMeziUjmFaORsmowqhw?=
 =?us-ascii?Q?fXKyKKXUYLWbrvqpQ+qQTuAbs66LSGOjVyRyyVH70YMWo7xK9H8CdDB1aGyT?=
 =?us-ascii?Q?dTQm0UwSYkeSBunWwRvvZh1X3jffMwSUvK17Cg7EZQfemZv/Y4/zcogOdDs6?=
 =?us-ascii?Q?Z1/Yxa/7VYkUxY25iK6LnK6SIfvLYTcaqwc7?=
X-Forefront-Antispam-Report:
	CIP:91.26.50.189;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:Diagnostix.phytec.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: phytec.fr
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 15:10:24.1154
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b64c8d2f-5e5b-4502-6cae-08ddbefabad1
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29;Ip=[91.26.50.189];Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509ED.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P195MB1592

- stm32mp15xx-phycore-som: add NAND device on FMC interface to support
the SoM version equipped with NAND flash instead of eMMC.

- stm32mp15xx-phyboard-sargas: define pinctrl for PWM5, LTDC and DCMI
interfaces used on phyBOARD-Sargas. Those interfaces are not enabled by
default as PHYTEC displays and PHYTEC cameras are enabled and configured
throught device tree overlays.
PWM5 is used for LCD backlight command.

Signed-off-by: Christophe Parant <c.parant@phytec.fr>
---
 .../dts/st/stm32mp15xx-phyboard-sargas.dtsi   | 23 +++++++++++++++++++
 .../boot/dts/st/stm32mp15xx-phycore-som.dtsi  | 16 +++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32mp15xx-phyboard-sargas.dtsi b/arch/a=
rm/boot/dts/st/stm32mp15xx-phyboard-sargas.dtsi
index 20684b497c99..28a21dec9cd7 100644
--- a/arch/arm/boot/dts/st/stm32mp15xx-phyboard-sargas.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp15xx-phyboard-sargas.dtsi
@@ -260,3 +260,26 @@ &usbphyc=5Fport0 {
 &usbphyc=5Fport1 {
 	phy-supply =3D <&vdd=5Fusb>;
 };
+
+&timers5 {
+	/* spare dmas for other usage */
+	/delete-property/dmas;
+	/delete-property/dma-names;
+	pwm5: pwm {
+		pinctrl-names =3D "default", "sleep";
+		pinctrl-0 =3D <&pwm5=5Fpins=5Fc>;
+		pinctrl-1 =3D <&pwm5=5Fsleep=5Fpins=5Fc>;
+	};
+};
+
+&ltdc {
+	pinctrl-names =3D "default", "sleep";
+	pinctrl-0 =3D <&ltdc=5Fpins=5Ff>;
+	pinctrl-1 =3D <&ltdc=5Fsleep=5Fpins=5Ff>;
+};
+
+&dcmi {
+	pinctrl-names =3D "default", "sleep";
+	pinctrl-0 =3D <&dcmi=5Fpins=5Fd>;
+	pinctrl-1 =3D <&dcmi=5Fsleep=5Fpins=5Fd>;
+};
diff --git a/arch/arm/boot/dts/st/stm32mp15xx-phycore-som.dtsi b/arch/arm/b=
oot/dts/st/stm32mp15xx-phycore-som.dtsi
index 0689967b8c56..23db635c39a1 100644
--- a/arch/arm/boot/dts/st/stm32mp15xx-phycore-som.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp15xx-phycore-som.dtsi
@@ -345,3 +345,19 @@ &sdmmc2 {
 	st,neg-edge;
 	status =3D "disabled";
 };
+
+&fmc {
+	pinctrl-names =3D "default", "sleep";
+	pinctrl-0 =3D <&fmc=5Fpins=5Fa>;
+	pinctrl-1 =3D <&fmc=5Fsleep=5Fpins=5Fa>;
+	status =3D "disabled";
+
+	nand-controller@4,0 {
+		nand0: nand@0 {
+			reg =3D <0>;
+			nand-on-flash-bbt;
+			nand-ecc-strength =3D <4>;
+			nand-ecc-step-size =3D <512>;
+		};
+	};
+};
--=20
2.34.1


