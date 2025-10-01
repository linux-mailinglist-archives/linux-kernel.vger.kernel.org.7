Return-Path: <linux-kernel+bounces-838888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD1CBB05D2
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 14:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B76AB1927377
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 12:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A50B2EAB64;
	Wed,  1 Oct 2025 12:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b="fD2vlGNJ"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020081.outbound.protection.outlook.com [52.101.84.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05A81C862C;
	Wed,  1 Oct 2025 12:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759322056; cv=fail; b=pvzWNMhZSFlLcUGI/37qo3ROuPOGVVUzFfUjcKnN7YyZrEMHXNiDbIQhTptlf8mJ7ZytTH5q66+bW/ZTRUPY7VatxS1n8yzaIhM3X4lHN56PMeKyv12liK99yzksjTFsb3nl1xsiaAaQbj6Dx9MnAke85YlaNH/OzRTiDUSNPrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759322056; c=relaxed/simple;
	bh=+z+w9Rp+47fJHmfAXZ5WNj3C56STob9pJIZ+ObUMNj4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=XmpKfzG7xrxQsPRYpVdshZm1cUq4csVJVW/CYYXRC0KTYu9xaP84SVeYvq1ttcHY4JuofHAC5a5NplYTaLG+SWhDSev3MbUHEAE2XTXWTLbvlHjcCJi5AdPPCuet0Bhu5kiNweQGydBaNFzxt9YsaT7eEmJffysOhTrGAM6a4LQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b=fD2vlGNJ; arc=fail smtp.client-ip=52.101.84.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HptBy9XE1sPPxTVILPoEK7cgQ4XwNoTNhIHkjFqgyT3eNcpq/yjTQ5SuM64NYOSWMc5GOcw05i3NNpSvUfj8F7zGuUgW+XxMWQwRSKu37v55MmrpaA4uqFzqAhFKOMRZ8pSj3Tpl0+iXgiQzlFgbxCYchuvw4JlELHrLTFvRVv9gGBQrCKXIX50zvkmD1+V3tZLiCveFX4Ee3XcS1U71YzczWv2NrC8Cvnw5aoKJiUp9wR4kaQiMzgtsZiQGoOIuR+RFAB9STeflpUZvYuu/xwA5OQb2MmF+NagOyeGYGWcd4H8vT78YMnHb1kk7+5H81JCbMzasTWiErknFGoG4Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l7og2TIVM8xsI+BEFP8hU8tshMfhlJ8sZvnaZUG659g=;
 b=aqeDrjmbFkZlji6/2f5KH4agvX9UFi5rMYo9w/gQj8IggQKx/sTfpkD92RfUGPgTs+4c1dZQF9JLYADIR8gIRW3BHmXyinkEwPr3pD52xOVkRAkhjk4S5GSw9AX3UpXsZ9PJpp5k2hZhQlwjvgr97e5CKeCtOj9fNKT0qqOy3OswLKNWjAS62kPIlRgjC2cuW7XRkJOOeKu0RMsMBoIsHqmOJSURPM43NdzHz5To7dL30/2yNmBf7konxtvektcOEAQJL4rj1ORhwVe7AhxrvBm7CAcTO25BWQn6o9D/e2xbWdZNQVV1ACxQiF+3E3E3mdWcIVhELub4O5ZsI9ZqgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l7og2TIVM8xsI+BEFP8hU8tshMfhlJ8sZvnaZUG659g=;
 b=fD2vlGNJiHsc+pkKf/2fjrds/7DWgdHlf0IjOCuX3ysaifpVtFouX4OvdNqlN6CecT0e70Iv9EXQmBtYOjwVzVSD5qjRzGncYN3WYxYnj/wrjv5QBKg60+usDrv5er8/ytItYY9pfKz9nGagjFT1bCOZc7EpzQyaLHE64dAysrgzHxuj2IcFsirKv+3W/hKMBsjmdjjhOQ33x1sZxQxcEHY+phhU9ukJaY6WkZbxpA+SDyJEEX3AyJ7SbUel18yPuWi+/dSC5ySVgB+r8afi5V1JhtHBkMG9gkHvz7dHGf+bMJ71cXmSJp1WkbMR6UyEMXPZGp7THeNPLIWbmfBnhQ==
Received: from AM0PR03CA0006.eurprd03.prod.outlook.com (2603:10a6:208:14::19)
 by FRWP195MB2915.EURP195.PROD.OUTLOOK.COM (2603:10a6:d10:188::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 1 Oct
 2025 12:34:08 +0000
Received: from AM3PEPF00009BA1.eurprd04.prod.outlook.com
 (2603:10a6:208:14:cafe::18) by AM0PR03CA0006.outlook.office365.com
 (2603:10a6:208:14::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.14 via Frontend Transport; Wed,
 1 Oct 2025 12:34:08 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 AM3PEPF00009BA1.mail.protection.outlook.com (10.167.16.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Wed, 1 Oct 2025 12:34:08 +0000
Received: from llp-moog.phytec.de (172.25.32.44) by Postix.phytec.de
 (172.25.0.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 1 Oct
 2025 14:34:07 +0200
From: Yannic Moog <y.moog@phytec.de>
Date: Wed, 1 Oct 2025 14:33:53 +0200
Subject: [PATCH v3 3/4] arm64: dts: imx8mp pollux: add expansion board
 overlay
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251001-imx8mp-pollux-display-overlays-v3-3-87f843f6bed6@phytec.de>
References: <20251001-imx8mp-pollux-display-overlays-v3-0-87f843f6bed6@phytec.de>
In-Reply-To: <20251001-imx8mp-pollux-display-overlays-v3-0-87f843f6bed6@phytec.de>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <imx@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<upstream@lists.phytec.de>, Yannic Moog <y.moog@phytec.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759322046; l=8006;
 i=y.moog@phytec.de; s=20250509; h=from:subject:message-id;
 bh=+z+w9Rp+47fJHmfAXZ5WNj3C56STob9pJIZ+ObUMNj4=;
 b=P69sXEzPuaNl8vtDdrAtaiZjSQVCO3dwqCb4HAYAaYRUN1IckAbEW7b19vu1CAPgNJJ0dmSM9
 NpsPz8EQsqvBYLdPQN5GinXPtFsvlNWb90uuYZIe6XfoBpwzrRWDkMg
X-Developer-Key: i=y.moog@phytec.de; a=ed25519;
 pk=rpKoEJ4E7nD9qsrU/rfKVwMTWNWYaTBylZuJUXUiFr8=
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009BA1:EE_|FRWP195MB2915:EE_
X-MS-Office365-Filtering-Correlation-Id: a9c4e4da-6cb6-44bb-0679-08de00e6d143
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q3NIUFpIWTZjdjcycThEa1ZST1FrdDh1VmthaklzY2xvdHRvaFZXYzhjQVR5?=
 =?utf-8?B?S1RFWlQwMHNJNW1jb1FrOWRTSExUN0FhUlhsRmpCcVB4ekFVNmlkRDVyZG52?=
 =?utf-8?B?WWIzUEN3MjAreXNrclNFRGFUWERzaDhNWFBRaHMvMmRCdEttZ2JxTGFVU3NF?=
 =?utf-8?B?NUF0dSs2Uk85bHlHZEJMNzI4ZUtHbTFHaklMbjQzREIvemcyUG1hcmtBVjlM?=
 =?utf-8?B?cFpkNkUxZ28vVkJZTnFFblUvcHlLTkhaNkJFZWlkMW43UmdyWExkLzNOY0pO?=
 =?utf-8?B?R21jK2dkZXJLRitnSlk2QmlMdWo5cFJScHpVU0NrNWVCN0JsMTRFQWhVYkx1?=
 =?utf-8?B?eTFJeFFMRlRtT0srSVo4ZTluVUZ0V3pSTG5KMU5XZDdxaW9hbUI4SThJODlQ?=
 =?utf-8?B?VG9YcEhmYjhLZlR0MzJrOHBwUmlHMUVudEp6eWZVY015bjBOam5FbmlIOGpv?=
 =?utf-8?B?RUI1S2htaXFUYXJGU1ZtK25KTERSWm1BREpWc1BBOWJPWWJzL0RRYW45eG5j?=
 =?utf-8?B?T1djSkdveW1LK29DZDZkVjB5R1pUdmFMeERwSDFlMG9FWFhLbkV2TnQvS1Jn?=
 =?utf-8?B?OGN5UXJmVkVwWExIUzZOR3JLQnNKWThLbmExTTkxQldobU5aVGhiTlA4LzBE?=
 =?utf-8?B?eHBCV0xkYURTVjF2MWplUmNSSHpkVWQ0ZDZGSzdhTW1WcmlTK1l2VzdoOWZB?=
 =?utf-8?B?VTNvcEpqbW1sbVVSb2xzQWlzaldWQnQ0aEMvZ2RnKzNzc1kvei8vekNEMGcv?=
 =?utf-8?B?aXphbFBzNi83V0Q1QXV5UWY4cGQrWVoyWDN6a3EwMjlMZ044OElWbitzSmVU?=
 =?utf-8?B?S3hOcXRXTFZpNXBmU3BOUG1PNU9KeUgvUzF6b3ArSVNXWWRQakd5M24za0FM?=
 =?utf-8?B?dndEdHZpRjlyK0lXUWlmYmtlMUUranVYbTY4S2Z1YlhkYlh4SWhpS092Mkcr?=
 =?utf-8?B?ZSthSW9aTnJaRndqL2FYdlhHZzZmMlpqSWs2YnA4Qm5sQ1VYNGFRK0pWSThH?=
 =?utf-8?B?WVlLd0RzUWVXSStYTnh1a21KZTRkTWIrSzdyV01rUmNHV1RaSkttalMwU3Q1?=
 =?utf-8?B?MmlucTNmMGQyMER0aWQxUUJWeVE0dWNMZUNtNEZYREsvZ1duMCtKaWNjUG9m?=
 =?utf-8?B?bGEwd3pGVUVibkkzaUJTL3RkREk1VVd5cGhCenZaYmNMRmNuU0Vja1NMTXdK?=
 =?utf-8?B?VFY0MXF6czVwbE4xc1RMZEp3S0ZCcGsxcmNwdDRwYVNWV2ZPbk9tNFdyOWhp?=
 =?utf-8?B?eUtSKytTVmJsSHh5SEErcnNjOENhQXR4Y1dmaVFJaDhpOTFQS3kvZlE5WTVp?=
 =?utf-8?B?Ni9tOU5QcCsxOTlTN3RjUXdKQUMzeitramRGMi9ZeTAzeUFhTVV3ckEySi9w?=
 =?utf-8?B?UUJZSDh0NEV6V3N6QVVTSEpBS2tRd2toOUhybmpRd1BIZEExY3A3NnYyMGpy?=
 =?utf-8?B?YUswUWc1djhPME40MWRsZWdobTA5d2dlVklIaTl2OTBPM3E0blo0c1lCMzZ3?=
 =?utf-8?B?bEh0VSs3aXRrbU9WcUFqMmZXY1BHcG94WUlZNmNHQW4xeUJaYWpYTkZYa3ZJ?=
 =?utf-8?B?RGJDcjlWeDdjZnFRMVFHMDZqTjF3ak96NjN0NCtjNVB3NXo0QlVlc08yZndY?=
 =?utf-8?B?VzhJb1RQSGN1Y2ZOSGgrTXFTdTRDVjYwdW5weDNReEFRVTk3VTlOS3g1MHZC?=
 =?utf-8?B?ZkhxOWt2Mzl6enV4ZkVLTVdIcWhXU25XdFhrMWFMeHYzN3IvYTJkUjY0T1Z4?=
 =?utf-8?B?TE1pUnRLYnpYaFhwcE8vRWh2a2lnclJHaE96K0thNlN1UWVYZmFIWWdmdWVJ?=
 =?utf-8?B?M3ZTVW1YWW10SGRUQVd0R3FMWWxQTnA0b2Q5aENnUysybmU1S045NFZZeWRv?=
 =?utf-8?B?Zi9ZM2JYY3RGQ2p6SlNDZHdqNHFEUjVvL1NKZk9oeDhXZU9TVU84emNXajZT?=
 =?utf-8?B?b1MyWWxoUmxUckNBTmtTREMxNWJud3BPSENEcWJwMENHaXF4Uk90YlJ1bXpp?=
 =?utf-8?B?SW9SRDh0ek1RZTBNRytoSzVVcGFuMHA3bkNSSHdOd3F0Y0QvWVRCeDk0ZXM2?=
 =?utf-8?B?NHNkNXVlVEVZVGU1S3JzUUl3bmJrd1M2SUFEcEtaVVNNQnVIMkxWYlRRRXVO?=
 =?utf-8?Q?CRbw=3D?=
X-Forefront-Antispam-Report:
	CIP:91.26.50.189;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:Postix.phytec.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 12:34:08.5508
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9c4e4da-6cb6-44bb-0679-08de00e6d143
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29;Ip=[91.26.50.189];Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009BA1.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWP195MB2915

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


