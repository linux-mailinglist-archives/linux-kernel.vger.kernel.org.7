Return-Path: <linux-kernel+bounces-843921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4982BC094C
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 10:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B720189E525
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 08:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6312C2882CC;
	Tue,  7 Oct 2025 08:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b="XeUz4hDQ"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021117.outbound.protection.outlook.com [52.101.70.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E15288502;
	Tue,  7 Oct 2025 08:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759824834; cv=fail; b=PPIf+RSsb0jeWnKGLHpeC1qeIRaRN0M/NtSfdNdhNreSolRXnY2kFn0T7a8EslBLGCqx1f9i50rNWH2T3OZchPEtxMu33pA2PXvryyUoVYFBJ1bwsIqFCn5kyYEW9ZsEWUM5q9f9yjhK+k0MrJPLtcZLctey2fKtiLWtPJES8tw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759824834; c=relaxed/simple;
	bh=yAHRAlAqwAa/BcxoeIVv7f+o17tQ8p7QM3sCKCCsERQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=X5pfSylItK8f8vTjh/GUZZYxn15OF9XmDN77u3us0gBzLHznBJv6xsiJHy1dQOLdpMGjM9fdA8pEsgnIF+H/xhgpi2vbJ6Eu64NxPuMswBIGswZXFynGsb3AciTLolDe+NhVhk5gHsy/YG4sCHCtD9mlFDVdM5GXA9UtyHBVb4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b=XeUz4hDQ; arc=fail smtp.client-ip=52.101.70.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ur/kS1Gkn0PC4F3uZlIPnkxndtlqCqaW8Oy86Ge8iPUemChYa+/Kww81zXQpnUxZuLlTc+OAKk4fbRDlGg1hiA61IBsw/Mv1aavmYvIgHiWoPribFyk95batLtAmnTPLpaxM2FZ2yOhMPfQuAX4k1jXx9FgdhsFgsldQwNtxtPlyQS1fNX+u/Hz1rA4C+v7DQHaeyizVZYB0fg44xLNS/IyT74ZKTWsMCR4dFwLYSM9w/rZa19uEFePD4H55weEuYa9Rg/srS4560N7mn7YO1zBuMLIzuuzoDbbYIqNBCM0rR/m0FUcYtpzGe87LtIdIftCrzBmgmylZjd8SJxDJ7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kp9eJB0+d9QaZeCDUOdEbN0NpND4aJHkvZW89a5Lkoc=;
 b=uzjqXR4KCeEw2/87G7IZSHaZOkZODQLYHXshKfXxsNApCgAbHOiAjLmO624lrSuVn7j60kel7geg1d5qoauSvNOg7RhEC1x12jQyThjQob78JKn7vs5G48OHO32IzIMng/qeNsyv432kLfZmAP5DwFtS4RIWFHVnEL/jLXzFhZuCnk6IjZQ0pbnzFQhfOsVvFBNQ6C2phOxOYo4Y5z0G3lZWYSsb3WIihZsqcTvs8M3RX7QWq6lW1rYUGUiaQJfqhK5Vc124Qj69XKFP1RVRVcYDP5GrODhz/wquCFN8fVfx/ZRYVXnqmqQfTJhZkCELtTE1mMgksfobJGb7pbW6mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=kernel.org smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kp9eJB0+d9QaZeCDUOdEbN0NpND4aJHkvZW89a5Lkoc=;
 b=XeUz4hDQldB+dTr6xdARG4unaiVhOWWnrBdx66BWWi6em2MXDHpoGB4hZf/Xv2XdrrYyzs0aIPAjVTo3KedAIaRk7Fz2SdQQZrE3PV3xJshY5hju17TfTZ9x4DU4gOWOUq5tg6UwltJgUzHfiR07G9uq6hSTkge+Es+68sIihDN5Qe9jCiXQe6sNPvKc/LJAHE609NaKD3bQ/RYjocotcUd7/Z6U/L7CK9/c1oOHV0vcqxEr9T4SGC5HFTgMcOqnM/B8HmzWFazhIo5+Zdm5I524yR9HjshF8ctLOvXT+3O9HNhwp8jNJysBStDiMlY9m08VLQpzS5MFs3VJpi5bDw==
Received: from DUZP191CA0008.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4f9::20)
 by AS8P195MB1928.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:541::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 08:13:43 +0000
Received: from DB1PEPF000509EE.eurprd03.prod.outlook.com
 (2603:10a6:10:4f9:cafe::a6) by DUZP191CA0008.outlook.office365.com
 (2603:10a6:10:4f9::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Tue,
 7 Oct 2025 08:13:43 +0000
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
Date: Tue, 7 Oct 2025 10:13:28 +0200
Subject: [PATCH v4 2/4] arm64: dts: imx8mp pollux: add display overlays
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251007-imx8mp-pollux-display-overlays-v4-2-778c61a4495c@phytec.de>
References: <20251007-imx8mp-pollux-display-overlays-v4-0-778c61a4495c@phytec.de>
In-Reply-To: <20251007-imx8mp-pollux-display-overlays-v4-0-778c61a4495c@phytec.de>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <imx@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<upstream@lists.phytec.de>, Teresa Remmet <t.remmet@phytec.de>, Yannic Moog
	<y.moog@phytec.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759824821; l=7302;
 i=y.moog@phytec.de; s=20250509; h=from:subject:message-id;
 bh=yAHRAlAqwAa/BcxoeIVv7f+o17tQ8p7QM3sCKCCsERQ=;
 b=OZXviIWEYiR6tpI7rpb3TFMxaAV3EWX809fcYFl9TMosexpl8sK78IluUAqLr47VP4mlEIC7u
 gCSny/jEdMsB0reFLkFTgZjRMcjBUpoB8bNmvWVGcITX8csTaICksXN
X-Developer-Key: i=y.moog@phytec.de; a=ed25519;
 pk=rpKoEJ4E7nD9qsrU/rfKVwMTWNWYaTBylZuJUXUiFr8=
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509EE:EE_|AS8P195MB1928:EE_
X-MS-Office365-Filtering-Correlation-Id: 52504743-9124-415e-a956-08de05796e34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QU5EbGVZckFsWXRCakFhcEphcXhKckgrRTZCQTRIa1B6WmRZa3d1eDMvK0Nj?=
 =?utf-8?B?MDVzc2FvTnNONFJqT2lSbXA1aTMyS2hLa3hTZUJIOG1KOS9TdjRkQ1NrS3lW?=
 =?utf-8?B?SDI4b1Vvc3JBaW0yakl3bFJGMklpdE9reFU1ME92c2dPeXVqTnIxdkwyYnBR?=
 =?utf-8?B?YVFocmdiQnRzS2dLU05na3lVUk1mOE5ucWRmVUNuaU1haDBsR1VIVG1KWllr?=
 =?utf-8?B?bzNSRzBOeFlxbVpTNXN5Sy9MNCtPNDE2YlRrME5YUE5NUU5IWm0rQXFpcDVt?=
 =?utf-8?B?VjQ1eXlPSjJPRDZES0lOL3FzYW9FRVk4eE1abWxJbStWL0o0b24zR21VWThQ?=
 =?utf-8?B?Y0Z5eFZxcmNTM05tMnBoNVNMOUgvUk1aNTUwZFpKOTFTY21ZRWkrOUQ4c25y?=
 =?utf-8?B?UmxhcFJ3YUFkR2kwYUNiZkxaMWY2OVE1SDZURkxYSEo3aElHVzE2NEh1STZN?=
 =?utf-8?B?dUxLd0tSRXA0UVpDMS9QM0xmdDd0M0FnT0UxU0xROTJiUGRaVW1XWlR5QXAw?=
 =?utf-8?B?a2l3UVFOeHNUb2U5ZXFjLzU4ZWdFQUt6Sm5EU2dYSlU0ZEdiRSt4clpHOEVD?=
 =?utf-8?B?SklQQmcwY01Xa3RtRTd3Vnd3Q3JYUktIKzdnRW1uejhwaGdraUdEMnFuc2xj?=
 =?utf-8?B?Ky9wOUFVOWhpVTF0Y3ZYSXgrMjNhRXBlUFU0cW5YMk5KNjZXaGs3OXUzby9t?=
 =?utf-8?B?ZGJOYjhydzZXRzZSRUpkdDJLeldTaUVkT3lVZ2VwK0E2TlRYTTVJU0Z3TU5M?=
 =?utf-8?B?U2RrWHQwRW9tVE1JNWM5VEVqOWxzVkZ2cmRXdVFmb3ZzTUNsRWFIZFFpd0NO?=
 =?utf-8?B?TEpHNGRJMXJQRlJsd3RGdzBCQm5RU1kxNUp6NGtoZnRZait5SDNvTm9OMW03?=
 =?utf-8?B?bDVQREZLTTE2RmtWRnlVbnkyRkhpQnlubXN1bEMvMVpnWnhnN2w0b3IveXlk?=
 =?utf-8?B?S0NPYnRNdklmczVnN3k0WXBvVkw0aFpjQ2FPeE5wZzVwaUpjdmJ3MjRIZ0VT?=
 =?utf-8?B?RjcvZkd1dytKUVlrN3IrTUNJcTBYaGRLUThqUEwrcWRld0pLRU1VSFM0ZHY1?=
 =?utf-8?B?SUNTdEhMYUVnWEh0cm05am9hMFpJclBvNGpTb0dpd1N5RXB6dDNmUnhySVZW?=
 =?utf-8?B?UktCd2c4YkZpdlVRZUtCVmFlR3dkSjVubWp0N0NvR3g5T3RTK25QVHBJem9z?=
 =?utf-8?B?SEpNMUQvVUxmaHNmd1R4bGdVMlh3M2hZay8xY2I0L3JCSG90NytyQW9mb0tR?=
 =?utf-8?B?OVZXQzAwcXRrbXFUTE9pNU9YZGltK1ZPd3NtZkJrNzhnaXhJYmJlbjVZUXgr?=
 =?utf-8?B?VUU3NWZDM1hYMTdKTXRIUVM0TXF2WExWem16dWVhcXc4c3N5SFI2aXcyeDVn?=
 =?utf-8?B?ajM5YjN2QUhROWFtQzhZRHdYQms2RlJQL2Q4TzlLczFYOGt4Rkw2RTIrLzly?=
 =?utf-8?B?VFJmamhqL1NjbVlGSFhFM0Y0S1YxUnlMM0x3elg0alRLZGplMXl6YVlLWEJE?=
 =?utf-8?B?VWEyN2F3V0pRSkU2OWZIdStTUXlQR2JyeDE1UE0zemF3WEhPMUFIVVByMEZ5?=
 =?utf-8?B?VG5uckxBNm54U1RMakVuYUV4bWZUU0xyeXB6ZHE4QUk3ZlJNMURsRGhVU2hj?=
 =?utf-8?B?Y3EzRkxJN0t3c1FlQ2Z2VTR6cVE3NC8xT3I1bFllZ2FMMks4VEdSaDNBWkxh?=
 =?utf-8?B?azZYSUU2WjZ0S2kwMHZjMFVrcGxTSjZQU3hyNnRtYUdmdEt6ZzNQbHVCNkpo?=
 =?utf-8?B?TERBM2ZSTEJaRjRLQUFPMVFhRGl1L0NQSkZnRjNnWDJoSzQ3VUdSbUFiYkhv?=
 =?utf-8?B?d2VDLzZxenQxUTQrdFBFYTJXZm1jQnMxYXVvVmdSdXFPajY1MkswY2dKcFpj?=
 =?utf-8?B?Yys0TG1tS01HMno4aFgydDcvL08vSmNVQ3NGakpka1pDNTdaS0tTZ0ZFSmY5?=
 =?utf-8?B?ZFhHT21RVGZ1NGZTQkI2aytZQ2d4bUFxcXhNclAreEhqNy9hYm5zeFRYYW1Y?=
 =?utf-8?B?aHJCOWtFanNNM091UUVrbjBLdlNJdS9sakUxVE04R1kwOWRNQTRxNXVxdzdV?=
 =?utf-8?B?cTE3VVJJUU1QSkhrdU9sK1JTRDlWVnIrKzNQdz09?=
X-Forefront-Antispam-Report:
	CIP:91.26.50.189;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:Postix.phytec.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 08:13:43.0547
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52504743-9124-415e-a956-08de05796e34
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29;Ip=[91.26.50.189];Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509EE.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P195MB1928

imx8mp-phyboard-pollux had a display baked into its board dts file.
However this approach does not truly discribe the hardware and is not
suitable when using different displays.
Move display specific description into an overlay and add the successor
display for the phyboard-pollux as an additional overlay.

Reviewed-by: Teresa Remmet <t.remmet@phytec.de>
Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 arch/arm64/boot/dts/freescale/Makefile             |  6 +++
 .../imx8mp-phyboard-pollux-etml1010g3dra.dtso      | 44 +++++++++++++++++++
 .../imx8mp-phyboard-pollux-ph128800t006.dtso       | 45 ++++++++++++++++++++
 .../dts/freescale/imx8mp-phyboard-pollux-rdk.dts   | 49 +++++-----------------
 4 files changed, 105 insertions(+), 39 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 23535ed47631ca8f9db65bec5c07b6a7a7e36525..805ab9e5942bc9e2b9776e92412f56e969b6b39a 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -218,7 +218,13 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mp-navqp.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-nitrogen-enc-carrier-board.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-nitrogen-smarc-universal-board.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-rdk.dtb
+imx8mp-phyboard-pollux-etml1010g3dra-dtbs += imx8mp-phyboard-pollux-rdk.dtb \
+	imx8mp-phyboard-pollux-etml1010g3dra.dtbo
+imx8mp-phyboard-pollux-ph128800t006-dtbs += imx8mp-phyboard-pollux-rdk.dtb \
+	imx8mp-phyboard-pollux-ph128800t006.dtbo
 imx8mp-phyboard-pollux-rdk-no-eth-dtbs += imx8mp-phyboard-pollux-rdk.dtb imx8mp-phycore-no-eth.dtbo
+dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-etml1010g3dra.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-ph128800t006.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-rdk-no-eth.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-skov-basic.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-skov-revb-hdmi.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-etml1010g3dra.dtso b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-etml1010g3dra.dtso
new file mode 100644
index 0000000000000000000000000000000000000000..7a7f27d6bb1be6364cbab5d2fe45a365c7680fa8
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-etml1010g3dra.dtso
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (C) 2025 PHYTEC Messtechnik GmbH
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/clock/imx8mp-clock.h>
+
+/dts-v1/;
+/plugin/;
+
+&backlight_lvds1 {
+	brightness-levels = <0 8 16 32 64 128 255>;
+	default-brightness-level = <8>;
+	enable-gpios = <&gpio2 20 GPIO_ACTIVE_LOW>;
+	num-interpolated-steps = <2>;
+	pwms = <&pwm3 0 50000 0>;
+	status = "okay";
+};
+
+&lcdif2 {
+	status = "okay";
+};
+
+&lvds_bridge {
+	assigned-clocks = <&clk IMX8MP_CLK_MEDIA_LDB>, <&clk IMX8MP_VIDEO_PLL1>;
+	assigned-clock-parents = <&clk IMX8MP_VIDEO_PLL1_OUT>;
+	/*
+	 * The LVDS panel uses 72.4 MHz pixel clock, set IMX8MP_VIDEO_PLL1 to
+	 * 72.4 * 7 = 506.8 MHz so the LDB serializer and LCDIFv3 scanout
+	 * engine can reach accurate pixel clock of exactly 72.4 MHz.
+	 */
+	assigned-clock-rates = <0>, <506800000>;
+	status = "okay";
+};
+
+&panel_lvds1 {
+	compatible = "edt,etml1010g3dra";
+	status = "okay";
+};
+
+&pwm3 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-ph128800t006.dtso b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-ph128800t006.dtso
new file mode 100644
index 0000000000000000000000000000000000000000..a39f83bf820490cf946849413cc968f9b0a86c96
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-ph128800t006.dtso
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (C) 2025 PHYTEC Messtechnik GmbH
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/clock/imx8mp-clock.h>
+
+/dts-v1/;
+/plugin/;
+
+&backlight_lvds1 {
+	brightness-levels = <0 8 16 32 64 128 255>;
+	default-brightness-level = <8>;
+	enable-gpios = <&gpio2 20 GPIO_ACTIVE_LOW>;
+	num-interpolated-steps = <2>;
+	pwms = <&pwm3 0 66667 0>;
+	status = "okay";
+};
+
+&lcdif2 {
+	status = "okay";
+};
+
+&lvds_bridge {
+	assigned-clocks = <&clk IMX8MP_CLK_MEDIA_LDB>, <&clk IMX8MP_VIDEO_PLL1>;
+	assigned-clock-parents = <&clk IMX8MP_VIDEO_PLL1_OUT>;
+	/*
+	 * The LVDS panel uses 72.4 MHz pixel clock, set IMX8MP_VIDEO_PLL1 to
+	 * 66.5 * 7 = 465.5 MHz so the LDB serializer and LCDIFv3 scanout
+	 * engine can reach accurate pixel clock of exactly 66.5 MHz.
+	 */
+	assigned-clock-rates = <0>, <465500000>;
+	status = "okay";
+};
+
+
+&panel_lvds1 {
+	compatible = "powertip,ph128800t006-zhc01";
+	status = "okay";
+};
+
+&pwm3 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
index 46930e31119adb82eadeb5ae5bb564060d6fd5b4..f1a06c43754b682d949ab39badb6a63c643a1de4 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
@@ -7,7 +7,6 @@
 
 #include <dt-bindings/phy/phy-imx8-pcie.h>
 #include <dt-bindings/leds/leds-pca9532.h>
-#include <dt-bindings/pwm/pwm.h>
 #include <dt-bindings/thermal/thermal.h>
 #include "imx8mp-phycore-som.dtsi"
 
@@ -20,16 +19,12 @@ chosen {
 		stdout-path = &uart1;
 	};
 
-	backlight_lvds: backlight {
+	backlight_lvds1: backlight1 {
 		compatible = "pwm-backlight";
-		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_lvds1>;
-		brightness-levels = <0 4 8 16 32 64 128 255>;
-		default-brightness-level = <11>;
-		enable-gpios = <&gpio2 20 GPIO_ACTIVE_LOW>;
-		num-interpolated-steps = <2>;
+		pinctrl-names = "default";
 		power-supply = <&reg_lvds1_reg_en>;
-		pwms = <&pwm3 0 50000 0>;
+		status = "disabled";
 	};
 
 	fan0: fan {
@@ -42,10 +37,11 @@ fan0: fan {
 		#cooling-cells = <2>;
 	};
 
-	panel1_lvds: panel-lvds {
-		compatible = "edt,etml1010g3dra";
-		backlight = <&backlight_lvds>;
+	panel_lvds1: panel-lvds1 {
+		/* compatible panel in overlay */
+		backlight = <&backlight_lvds1>;
 		power-supply = <&reg_vcc_3v3_sw>;
+		status = "disabled";
 
 		port {
 			panel1_in: endpoint {
@@ -231,32 +227,8 @@ led-3 {
 	};
 };
 
-&lcdif2 {
-	status = "okay";
-};
-
-&lvds_bridge {
-	status = "okay";
-
-	ports {
-		port@2 {
-			ldb_lvds_ch1: endpoint {
-				remote-endpoint = <&panel1_in>;
-			};
-		};
-	};
-};
-
-&media_blk_ctrl {
-	/*
-	 * The LVDS panel on this device uses 72.4 MHz pixel clock,
-	 * set IMX8MP_VIDEO_PLL1 to 72.4 * 7 = 506.8 MHz so the LDB
-	 * serializer and LCDIFv3 scanout engine can reach accurate
-	 * pixel clock of exactly 72.4 MHz.
-	 */
-	assigned-clock-rates = <500000000>, <200000000>,
-			       <0>, <0>, <500000000>,
-			       <506800000>;
+&ldb_lvds_ch1 {
+	remote-endpoint = <&panel1_in>;
 };
 
 &snvs_pwrkey {
@@ -281,9 +253,8 @@ &pcie {
 };
 
 &pwm3 {
-	status = "okay";
-	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm3>;
+	pinctrl-names = "default";
 };
 
 &rv3028 {

-- 
2.43.0


