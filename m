Return-Path: <linux-kernel+bounces-843920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 003B4BC094B
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 10:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EE67188D8B8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 08:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36BC289811;
	Tue,  7 Oct 2025 08:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b="CvZP7vtJ"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020115.outbound.protection.outlook.com [52.101.69.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F102287511;
	Tue,  7 Oct 2025 08:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759824834; cv=fail; b=CWF4zTManiEsI9Z1tFljMA2Q0iRiBMHl/CSLLLZ4JARf+Rr6YspY8wEmqI0SuNjI9HDbh64jUnXwbLOhYDxIzDwne9TOY+I9HJxBkLPgx6ld3zc6PvSXO/d4UpPyHW/xnZvDKwQCkSkeykV4bwEgMw9CNvjd1Xkn/I2kjxkJmp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759824834; c=relaxed/simple;
	bh=+z+w9Rp+47fJHmfAXZ5WNj3C56STob9pJIZ+ObUMNj4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ObJZ6qqf2/Ceb536wQ/M00X/KEaxNJgX3iVO7za3dbnkQJwkPXiyovAIlacSM91zq5btw2JeAK2cEV3XMe+fsOuJWOK3faFoWGaQ66pELYYCiO+Or0zCujVd0jzPg1GMyMZrU73tEjiOr5WOztZE91ryRo6AMD5EkeMmJnM1Xh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b=CvZP7vtJ; arc=fail smtp.client-ip=52.101.69.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oinvkH6mfEvfc3gNUFlOna+qiMzbz7sTSM7OpbM7RF0R0OtTWFuCCeerEv7pPCnCTpBMrGw5NPDgJWgCuFNKx8TrJw8xmWEX0yXu4PrCsrnqkzEEFO4nBQPYk1MxF2qwyxnQs+kxBa14JGCPWxr8HK66IDK0eSP4kOuRLl/bpVRY6ek0buVwZ6J6oFkGCiHfST/PfeMUQhsYmOmSvuAh7tG3tSPVbZ/hXtRtZe8P7WKddKAPvV7Ti89jLQ7u6/ygpEB8kAoTeUaMmDm131KtjeHlSF0GQdAyNjaDiik5u7SSThSNJh33lxrwhUi/9LjL9gyUEemQMh7jw/xD62HGaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l7og2TIVM8xsI+BEFP8hU8tshMfhlJ8sZvnaZUG659g=;
 b=wBx5qLVGOZYl2cMI/ZZ+hENBN4V+E3l7aRuAfUt8zZ5HFiojzK7pWsOs/tyu74MltKWJIr7aqHQ7/ZSdfgpHsKxPRbogQzEknscpJ3crRd3ozjA8beU7GhsKy+SDrVEYPsuEq4HyUPQoHDeSdTmXIeLAFr9dSexjicnHOZsfsZHFB4ELnzqPy4B5/a/IwhP4DLNSyThLV9TRDHZ1ETCnlNgFpSTPA6b3xD7L9uoCGaLyCT8TBbmooMFwuCik2iKqVTctY4ckd/6xG5SisKZMz1MM5+34ztPYoG1QfpJYx0yhbTZps0xw5V2NTQfieDh+Iqm5Y036c+lXrzWLLMR1zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=kernel.org smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l7og2TIVM8xsI+BEFP8hU8tshMfhlJ8sZvnaZUG659g=;
 b=CvZP7vtJVZ0RnFidKrvn3VXQWrrfQqHYXhbVnuR2TCzmwHcjwOgOeXLPOGNDxvypE2MrcIaIEX1za7C7IIfVUjCEosnAmlVRF37BJV/hluBQqXlAT3N7OXhbT9aDZ8W4xFM2rVOMXOQmA/i0hZr1MbWNwOS1CE4w6loATfzWExBT1+2gwp4zfZQlH1Wkc1huwdSMZFYzrnbmU8WDuJRHMe7o2iKVl220/i7BWyquhQd5QpGQDFr0o6Tt7Txt5fWeYoUTos6CLbCQiKUt9TwzhFviAGpkXw65NHg1esWZ9kZ6Yz2fYTnt8MSLIYBcJrfi7+byQOuaVwkzc0Y6Ev32NA==
Received: from DUZP191CA0014.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4f9::18)
 by GVX0PFFB9359B62.EURP195.PROD.OUTLOOK.COM (2603:10a6:158:401::7e9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Tue, 7 Oct
 2025 08:13:43 +0000
Received: from DB1PEPF000509EE.eurprd03.prod.outlook.com
 (2603:10a6:10:4f9:cafe::64) by DUZP191CA0014.outlook.office365.com
 (2603:10a6:10:4f9::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Tue,
 7 Oct 2025 08:13:33 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 DB1PEPF000509EE.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Tue, 7 Oct 2025 08:13:43 +0000
Received: from llp-moog.phytec.de (172.25.32.44) by Postix.phytec.de
 (172.25.0.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 7 Oct
 2025 10:13:41 +0200
From: Yannic Moog <y.moog@phytec.de>
Date: Tue, 7 Oct 2025 10:13:29 +0200
Subject: [PATCH v4 3/4] arm64: dts: imx8mp pollux: add expansion board
 overlay
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251007-imx8mp-pollux-display-overlays-v4-3-778c61a4495c@phytec.de>
References: <20251007-imx8mp-pollux-display-overlays-v4-0-778c61a4495c@phytec.de>
In-Reply-To: <20251007-imx8mp-pollux-display-overlays-v4-0-778c61a4495c@phytec.de>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <imx@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<upstream@lists.phytec.de>, Yannic Moog <y.moog@phytec.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759824821; l=8006;
 i=y.moog@phytec.de; s=20250509; h=from:subject:message-id;
 bh=+z+w9Rp+47fJHmfAXZ5WNj3C56STob9pJIZ+ObUMNj4=;
 b=wFyJP5Jw2TGDh5nLbA6O0v9qwmt+9LRLvStgU6UeIFca1xu+ICp5MCSEU9hXqzGQybmGSxjE3
 ZbqfYlgRlnAB7feTT/D3NEH37/DzChOSNW+i8rnLGmqCCFwOQOc1irW
X-Developer-Key: i=y.moog@phytec.de; a=ed25519;
 pk=rpKoEJ4E7nD9qsrU/rfKVwMTWNWYaTBylZuJUXUiFr8=
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509EE:EE_|GVX0PFFB9359B62:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b8a86d6-2959-4897-ab23-08de05796e7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U245MnY4VmlhenZ2a3REMGFRQlhUVk0zcVkzYlJacmkrS1FldXlaeVZDNDJZ?=
 =?utf-8?B?eVNCbXRFUVN5TXRyWnNyaVltaUw3eGEydWdteUwvWHptNnZPdTB0NktvZHVL?=
 =?utf-8?B?TkxmRmVyZ2hiYk15bFJ4VEEzTnZxa3habGpaVlc4TlRNcjFwTkFwSU5aMitQ?=
 =?utf-8?B?TWdUN25qM3dxOFlGZis2MGxidEJCTGp1MkJ1NmhXdnhzTTVIZlorOXhjeklP?=
 =?utf-8?B?YzdQRUVjTFNVTm9hNUpXakNqM01vSFgvQUUrbnNDTEpOek1qNUJ6UDhUR2M5?=
 =?utf-8?B?TGRtZGgvb2JnRjVkOWlVN0h0V1pETHI5M1piaTNHSWRZRWRyTGtxRWFzYVpC?=
 =?utf-8?B?dHoxMmxmbllYL2lLQ1dHam16MFJYSkxpTmhuc3Z2UHYyVEd3VUd3a1U1djVh?=
 =?utf-8?B?K2FGejlVby9ua0FkUGRBZzlubERRbTgwUEJWVnhpY0hqQzZOdC80azVZSDFJ?=
 =?utf-8?B?VXkyUUl0NmluMTlOeWZobGRidk0weHkzNXhEcnY1OU9zc20rL2ZtbVdnWllL?=
 =?utf-8?B?Y0FydkMrMUszWXRhdHNPUXdOQldUa1cwSXBwaTc5TUEvTGdCbFYvcUdmR3lN?=
 =?utf-8?B?TWhnSzliNmpOeGNTOWE5bHVMZW5ucHV6bEVKbXJqdXlUZURJcE56Z2Z4cnVs?=
 =?utf-8?B?U0wyVXRVN2RDZ3lpOXd3R3FZZVR0TU9BSUJzWFpucXFpSi9oakw3ZzE3akVH?=
 =?utf-8?B?UzdvRHJwMU5ZUkpUdFVSTm5NZ2JxcncrK3ZFV2wyZUxOSzlvSmtTbnhTYzdM?=
 =?utf-8?B?UytMNjFEbWV2WDBVSDM5NW9MVmRYZ3BtcVloL1cwcG0wVS9EVEFxQWNCenpQ?=
 =?utf-8?B?YTgrMlJrSTduMXREbE83cGJTRkEvOE9sU1M0cnIvTEgrMzdHRll4Mld3Mkph?=
 =?utf-8?B?K0RQQjZnZ0hHMFVMdU5TUEY4TGFuS3p6VE00OWlPZm1zOEZNQWN2Yk05bHZS?=
 =?utf-8?B?R0p2M204RXJmdEpkOGFOMjZ0Vnk1TlduN2FKMkhvb3pZRWdOWjhMVlJZSHkw?=
 =?utf-8?B?VERMeDJZQk1RNHBYSTJ5cFVkVEIwbEJZLzhReUF2U0RKOFpLRFRxdFA3T2pz?=
 =?utf-8?B?c0FVTktVSWRLbjB3cFA2cVM3alB0VDBxaFZkajczK2lCL1cvMDUzcWhnY29D?=
 =?utf-8?B?M3QyYVEvTUlEMEhnUUtHeHZlV0ttYU4ySDlPeGxoRzlMdUh1R0gyWm5ISlls?=
 =?utf-8?B?RUlSaEkxVTdTeDU1MEo5U29yeWlRWXZaOG1zK2kwai90aHZYd0hwM1g1aEEr?=
 =?utf-8?B?elpoT3k1U1hhek9RRXpocEZxVzN2bytLRXZxNlIweEduMXpoZmlsd0Jrbkt6?=
 =?utf-8?B?V28rcFA0UUR6QThoZXFYVTlXd1ZnVUIzTGc2cU1vS2VXcGNuQ2hMalRYOVRJ?=
 =?utf-8?B?NWxNUThmNmxvckQ0NWp5YU9qQ1FzOVdRSit4WVVkUTI0Szdzb1VlQ1lyS005?=
 =?utf-8?B?VW9YTGExMFIxbzBQWTBTZm5lbmRIRVVPczJ4MUlYY1lJRDJTVk9EVG9RUmlj?=
 =?utf-8?B?YXFaNjJPaDNmcmNvQll1OHVWdFRmVkJRSmFpWjdQcEo0c3BXZDR3bHZPSi92?=
 =?utf-8?B?MWlOY29rQ1NaU0Y1MHJCaktEbUE2NGZoWU9JcDlaVXZIaDdiUlZjWTRjbnNi?=
 =?utf-8?B?dlh6ZmZickpVeDg1aTZrWW9VMzNTUmhWS2p3dUVUbG1LZEFTd3g5OGpFTGht?=
 =?utf-8?B?ZEJqeEJFVHFBQkU3UzFsL0JzUlpldUVWQUxySlA4b0UwS3JRUW52ZU1hQ3dp?=
 =?utf-8?B?bDVOb2tIY2xqUlk4UndOOEljdWptNW5nK3FuQWtXalNVbjFxL2NKL0hLUm52?=
 =?utf-8?B?aUdvTENIWDF1aDd3MWN1V2J1eS9rTVM4SEhkKzNZT2NzMTFLK0phZzYxV3d4?=
 =?utf-8?B?ekFVUGwxZ1luNDFOY0cwYUsxdFRTQnJEeGRnNGZQU0FHNEtkZ1k0YUthK2Z3?=
 =?utf-8?B?cnh0WXFmU2pEMG02QVh2dVErMmpZRk5TcXo4WkRPVDZiM05IRkhwTVBiZUN4?=
 =?utf-8?B?QmY1eG84UDQ4ODFzMURsdmVxdFdQMDlBajR4Zzc0Sm5aeTBMRHNiUUx4OUth?=
 =?utf-8?B?WjlNU1B0Z0t2ellpcUtxS0Zvd3BvY1haeFI2YzgyTXdsN3IyTi9MK2dNQU9K?=
 =?utf-8?Q?ZVFA=3D?=
X-Forefront-Antispam-Report:
	CIP:91.26.50.189;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:Postix.phytec.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 08:13:43.5447
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b8a86d6-2959-4897-ab23-08de05796e7e
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29;Ip=[91.26.50.189];Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509EE.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVX0PFFB9359B62

An expansion board (PEB-AV-10) may be connected to the
imx8mp-phyboard-pollux. Its main purpose is to provide multimedia
interfaces, featuring a 3.5mm headphone jack, a USB-A port and LVDS as
well as backlight connectors.
Introduce the expansion board as dtsi, as it may be used standalone as
an expansion board, as well as in combination with display panels. These
display panels will include the dtsi.

Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 arch/arm64/boot/dts/freescale/Makefile             |   3 +
 .../imx8mp-phyboard-pollux-peb-av-10.dtsi          | 198 +++++++++++++++++++++
 .../imx8mp-phyboard-pollux-peb-av-10.dtso          |   9 +
 3 files changed, 210 insertions(+)

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
index 0000000000000000000000000000000000000000..bb740f845855ac06307de2c3835ebb5a03d40fa2
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-av-10.dtsi
@@ -0,0 +1,198 @@
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
+	#address-cells = <1>;
+	#size-cells = <0>;
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


