Return-Path: <linux-kernel+bounces-895619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B9873C4E82F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 15:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B4CD04F18BE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 14:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1BC92DC791;
	Tue, 11 Nov 2025 14:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b="NwQSVguS"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021141.outbound.protection.outlook.com [52.101.65.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF77C2D8DDA;
	Tue, 11 Nov 2025 14:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762871671; cv=fail; b=GZ1QLgPPCzr4dcJ6p9EO/w/Grq8lmpVx5bU6uSwtHnu5TTSzbTyk3dO+MVOv8d08W3edVFWu9nq/hhkQK/btum2tQf0blCtYlnWKaLt65F/eB2jmDAlL3pZsEOr3gYZI1DAVB5/YZJaHAPSfuAfsbaZFOKd3Y2AqkRSQJ9BjKJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762871671; c=relaxed/simple;
	bh=oVf+UnYXn2q/3HQPPqcVzOwhoOhoD+yp2n9skDh8IOk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JXufd4F/L2PowYZtW1rlsnAjBkaOjJ8IIkC6jmkiu9jGPbEdHpFTVoGATzt0ZEeKI5ogHSoa2xf8BxPLKjaMm1fGdNSo/ecMAa3BWxs4fD+oPzG9EkMbh4saY6uKaYAoJXysJZofMuOcJCUxKMOzIajIIRCeyQ4RXgRMofNJ9hk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b=NwQSVguS; arc=fail smtp.client-ip=52.101.65.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dW7vVka0Ys/2AMXtEgm2FL8XLzNdeGRDPG1wibDU+EI2PXNAg+gtBMrX3jDQJVDwKYSQxadOgle2cr9YmRbOo87pBirYebITeNXJvQtJlAc25I0TmZGR+zS1VPFti+ETqRIUMHUAKt4XuLiKbDLnbiv18GCXkWEpv4K3tOZwaFjyXJx+6BOQuZoANrOu4bgA/WXdOA8a7HSUxFMC+SbX6ju+c0iMyDLZZFEbw3LuAr8DVGz5zTsyM77d19SqMaDNtagsAve41sClypB6Y6d/wWPvucR9xzkpohNlPzRqxjqmnsueLEMiaBvSsOvN64wWcNXXcAunUuBB7zZ8AjuDxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D9PvuG8wQq+wwgY2Z6CKpr9vIJIsacXAL3vmiUmjcIw=;
 b=py8HHHFFLmEYqw3At1ntpVAs8FEeN2Cm6SMZKsO4BR+RuAAL8DwcqrhFjxDORA3hG83FA2YgVmhou25CPmTsPYFqSZNKAF8IGWrp/QaUjp5N03z34M5TgxV71jRj1EFFekWK3pqKSmyzvVHqDD8TjO8AAy40g+8E9punBlOiPjtMyNc1JJW/YoT3BNQ7ZLrFZ3viYmyfILU7Oq32a0uAdvFyEdgxV2XwO/Kw12uNIwM5WM14k+ou+v4/HEAHLrOZn1+1FQt12kpXs4c3FsXmtPkGEhQIDc7g+TakaVgtcFmLvgbT+3njHbPmXFSQwrY1ERWloZqZPqJJbiT+MQh/8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=kernel.org smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9PvuG8wQq+wwgY2Z6CKpr9vIJIsacXAL3vmiUmjcIw=;
 b=NwQSVguSpGEmbg86g7/mQuxq7MnyiNPZrWKmM23iyp943I8BQx4C9xsyH1M8JICqmOXZzxS5hkIpS6fLJ7ut4jXP/d4DTlWtRdrp9lIcBsUuqlW+SISaytDmupp9GfLTajmcBAMR9fxe+inUHNcWhbjN3kKZFh80copInJ26IoJThTFWcAHkx+n3BrO3hxnCXloiH9R1ryzAeRLG3fIt2gJ2EcxBQegCHyS5+r1S400xc/iLmV2iG/xcn0mKoJJdN7Ew2hM3oe+6HUX1avsVmXJDuF/s9/cExl0GuBn9snKAmfJ97jmFJJYAQFXuvxTGJtkLWg1gNRd/KxzlGT49gg==
Received: from AM0PR02CA0139.eurprd02.prod.outlook.com (2603:10a6:20b:28d::6)
 by PA1PPF497BDD234.EURP195.PROD.OUTLOOK.COM (2603:10a6:108:1::1cf) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 14:34:23 +0000
Received: from AMS0EPF000001B7.eurprd05.prod.outlook.com
 (2603:10a6:20b:28d:cafe::e5) by AM0PR02CA0139.outlook.office365.com
 (2603:10a6:20b:28d::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Tue,
 11 Nov 2025 14:34:23 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 AMS0EPF000001B7.mail.protection.outlook.com (10.167.16.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Tue, 11 Nov 2025 14:34:22 +0000
Received: from llp-varakala.phytec.de (172.25.32.223) by Postix.phytec.de
 (172.25.0.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 11 Nov
 2025 15:34:22 +0100
From: Yashwanth Varakala <y.varakala@phytec.de>
To: <shawnguo@kernel.org>, <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
	<festevam@gmail.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <imx@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<upstream@lists.phytec.de>, <peng.fan@nxp.com>, <y.varakala@phytec.de>
Subject: [PATCH 0/2] Add and Update display overlays for libra
Date: Tue, 11 Nov 2025 15:34:05 +0100
Message-ID: <20251111143407.24657-1-y.varakala@phytec.de>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001B7:EE_|PA1PPF497BDD234:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f9706dc-46c1-410c-4add-08de212f683f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SlMr+d3bEvlr9D4rb4uejMz/A5xLaFl7b/cFtYLaZfVT/n1c28rrWt9yl1f8?=
 =?us-ascii?Q?K7AzPtQDQZyroGug61g17AjxqpHSTZhzOsG3g3KK4gt+G+ZbCPAb/Xu987Xo?=
 =?us-ascii?Q?ELwU7PM6O1DH/T9+bfNH6MuVvp+bA5bTU/3FAaBgKhwb4i/hBJZBNV5R2Exf?=
 =?us-ascii?Q?cEX11maSAkIvrsIaYCF4kNVh0WJAR4YUaD+7aW2DQbKYPAwEtujP4B8qrHGj?=
 =?us-ascii?Q?fnLpmQk4Ii92pH4SoX3DskljCpm9MVApHfG6i5NZbm73ZkXNJR8ARztjbobv?=
 =?us-ascii?Q?Ff3qC2MgkVtFdYg1gi/Z7cYs0UL/8scxYye+FPZOxsYkT8CtkKbAUnj4toTe?=
 =?us-ascii?Q?pYh4t2GU9FWVm7xtMQIUFopCWyRKhONs0zIoBmW2Ml6ZI3J9zlTxjKDE4lxX?=
 =?us-ascii?Q?imjxbusS4hEG+DPEJCNSsL1qeleKpzVyBacrtRkjWclEpfLv3JJC0hXtBvgg?=
 =?us-ascii?Q?hf3aXLq0XqXxnRMh0d4XT5WVzd3k97p0dbYC4T2Os74KaVsW+FChkjRhBZB1?=
 =?us-ascii?Q?8PNGvjhxT72P2MVu213/9kZwr0RMwOC/JbypYKdLPlqVLnzqJ7v0WFtimzJs?=
 =?us-ascii?Q?vUhwj2ruMM4xRFUu2zsWyHXQvruAnJVnR700A9KBWoGJu8OxTJpx+ynLzqK+?=
 =?us-ascii?Q?cP/MOjH5cdVgj1V4DuQywBQrXE9ScHXtmkRGMvit0kd3x9XhAImrsTnH08ip?=
 =?us-ascii?Q?h4aMwy8iNp5D2CaH0HYMdrj+sj7VUd77MdY00utIoML6Y/AnGeItjOcMkS2G?=
 =?us-ascii?Q?herjSvuH2/zoLcnua6rNnBDkhMmQZdqgj3FvjcP3koYO1mIHdWI0KqcBuPCl?=
 =?us-ascii?Q?IvWHIHTOX8TfmhPlHd5gcd2HgoNQr2iGCxA/UQlAZjtnlJ42KZBx07bog3bY?=
 =?us-ascii?Q?p62rR6LFsxs20/wOctpjL+ZjEH8pO078VFgIMelQQdO2ic5+NTzChFzfje3E?=
 =?us-ascii?Q?GPgWVgig2k92ufnqy1at7BOAlSZWzMkPN0oJFsoupCkXCHwPG77akRA1UacG?=
 =?us-ascii?Q?5kCKp7t+BuK9pjQhNfPNErjLamO13wowIUNrDVqxaK5pLAErvM0K2ces39LZ?=
 =?us-ascii?Q?hAmvqkLdia764kBw/43grTWF863r7SZf0NsIGVvVfV1Ky8Yk1LLZ8ra47hso?=
 =?us-ascii?Q?5RpqHeZVLOIi5e22JxfXPF2ldGr5aRu2zqFvn5OLhjOz0x5EJepGSi0n2OmP?=
 =?us-ascii?Q?TLcovd2V5jJCfEgeZuhp+0k+QD2A3DodMMvoP/Oi7lRtTmJ9g9noCzygDIiG?=
 =?us-ascii?Q?LOkRQV/nTWeDPbSmX8WeI66IHzDWSo4i9m56xnRP3Rmfl5MAKNOdgZKCU8H+?=
 =?us-ascii?Q?ocX/HcndzY9fXmxlqhsUgGzmC8oNPa/ctthzMxo9IXr5X9t0zR6NqMAQ2V3D?=
 =?us-ascii?Q?XST1kzUsxIVZyCSD3ii2i5x5ibrN+fupw4aIYPJB5l/W/Rt1LCA+lhU1iKMe?=
 =?us-ascii?Q?r/xKj7rKezRQ0A+EYEh0pgBC6UN+SDRAHM20/Tcwig3AEyZ/XLaSgE0Vc2mL?=
 =?us-ascii?Q?79fHcwZwtgDJcT1AH38xkkrhrtwyTgloQLOb2gcklbLK783yKZpYlDKj9jJF?=
 =?us-ascii?Q?Z5wVI9sdC//5+upRBNc=3D?=
X-Forefront-Antispam-Report:
	CIP:91.26.50.189;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:Postix.phytec.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 14:34:22.8915
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f9706dc-46c1-410c-4add-08de212f683f
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29;Ip=[91.26.50.189];Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B7.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PPF497BDD234

Add ph128800t006-zhc01 multimedia dispaly overlay for the onboard imx8mp
libra. Update panel node naming style in etml1010g3dra onboard dispaly
overlay.

Also add the PEB-AV-10 expansion board overlay that can support audio
without the display.

Update panel and backlight node naming style of the i.MX8MP Libra RDK
devicetree.

Yashwanth Varakala (2):
  arm64: dts: imx8mp libra: add and update display overlays
  arm64: dts: imx8mp libra: add peb-av-10 expansion board overlay

 arch/arm64/boot/dts/freescale/Makefile        |  11 +-
 ...8mp-libra-rdk-fpsc-lvds-etml1010g3dra.dtso |   2 +-
 .../imx8mp-libra-rdk-fpsc-lvds-peb-av-10.dtsi | 196 ++++++++++++++++++
 .../imx8mp-libra-rdk-fpsc-lvds-peb-av-10.dtso |   9 +
 ...ibra-rdk-fpsc-lvds-ph128800t006-zhc01.dtso |  44 ++++
 .../dts/freescale/imx8mp-libra-rdk-fpsc.dts   |   4 +-
 6 files changed, 261 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-libra-rdk-fpsc-lvds-peb-av-10.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-libra-rdk-fpsc-lvds-peb-av-10.dtso
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-libra-rdk-fpsc-lvds-ph128800t006-zhc01.dtso

--
2.34.1


