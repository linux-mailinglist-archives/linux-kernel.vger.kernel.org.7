Return-Path: <linux-kernel+bounces-816861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85BBCB57984
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EFBF2022FB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A052304BBE;
	Mon, 15 Sep 2025 11:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b="CvZqDiMN"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2126.outbound.protection.outlook.com [40.107.247.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9A723C50C;
	Mon, 15 Sep 2025 11:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757937361; cv=fail; b=KTWRr0T1w5crr+ag+5e3woy6ioZNQkH3BnCLzJyqyGYuALtJ+OCx1prdwRA5cXNbgiRScviucpI+7IzGuT4I2YlUqtyxdv+s0i59vvB/YMsMlgZ5o16PfUmuSphXihiVUWOwtjnk4+g1ZHHLck8SKITxlzm4ME5qOAsVgKYa9IA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757937361; c=relaxed/simple;
	bh=P1405x8tYw0A65gSZzVwOfbtJmasx3MxJJ3DooivyN0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=khDA3VrlAZlBvPNAfJHjdvSTOaOxsAE5KMmi/6KLJGzYWS9c0z89tFeRpZcDmJOLpGZb9K5lipyQ28g3EEjno7Ntqrm6bhjZ5IKSwIzq/jHPsyzNWVAT7lCwR5vG67fvIgnQVefLQWtlpjL3x7aPmGZGwsLVszX3a1iH3IHRZL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b=CvZqDiMN; arc=fail smtp.client-ip=40.107.247.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VY+uvUNN3+SgKAxaqq/1j+z0iWCqd87DkxwbqVvrXPj4sIdO2FL7nll4/NRlyPpxmfzvW7CbdOx9uK3hjzYAX64gtoDO+3NF5HPWk5O0c9kY9kRcux42eW8+ohOcUpn/+OSEPTj6p4DmmzmTIeAIiFP2FqcFB0IVKP8psPUrfPsGqeyXG03DH3LJtPibq9SPCLXXl4zwtOb00THmKhDC3KegDwNGeX7306o0asjGebx+v3yBNXf0YLGqsfsIHck6a4Kg+4T1o9u/UekR5B9vWevSbGRz8OLoRbRDV2bhh9Xs63q/DYR1wcMEHWWoq6mANvCftD/ks/lTON3RMxrOIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M1sfjlXde8tylAVQ+1DFMHKpjhvIldq5uO6sh3x0SYs=;
 b=lCQzT2L2Jf6MJdbacXa+EISPfHIbGh4SsyocRfjAnFeZ/1Joh9bxgi1FYkiO4qUoMybzgrXs07VtgXXMRajb/ZGPfocgcDStIB6nFSnki8iGxirPEw5apefF48Xz/m7jkcz51rY7o8w+4DJZvd40SRs3xd7uv4w8WnAxrrSSqJVlGo0RTX6YrG2I045J7Y8lU6j9FPu2a0debgxzqiwXQsBexcpULWJkf5X3oKsSwYxkRJT7JmW+sxX5XVwBt/C4CM47GLi89ZWplvTGPuPb7y+FXXuMKrjSqX0hvUjsTLOTWXyVqQfLA0qufMaY7IL/XGhzEK2/1X2jMdV3rPOkdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M1sfjlXde8tylAVQ+1DFMHKpjhvIldq5uO6sh3x0SYs=;
 b=CvZqDiMNsW7KmB0wL+s4ykKw1DE8NMg9ikcRFWwQnFAWArUb9ZVtJ83p6Fx5SbyO1WG8GM8x/TxgDkrWEOet/xNyRS7bP5Z7kKnq6pJhJxMYCc8K3O2xkkH+Q50Yv8PKTGsJwMGdF6wX0iblGaTDeRrHLkSLZkphDeKYrMTqvuGuF20RVDSC1yw4Y3zKXodZTPSVXXtMdf2gTX85xABpDeW1Sh+/kIFpnB9aGai38hHQQh4CByGHXAiRxlwTo129e8Poi5S1GXatJrgbP8S4Zm88N62jYVinWTDAFf4ju0Che52n9hDfShml5E5iAzbS3FD1VZ06IhsKrKVQ5qScDA==
Received: from AM0PR10CA0078.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::31)
 by PR3P195MB0490.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:26::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Mon, 15 Sep
 2025 11:55:53 +0000
Received: from AM4PEPF00025F9B.EURPRD83.prod.outlook.com
 (2603:10a6:208:15:cafe::18) by AM0PR10CA0078.outlook.office365.com
 (2603:10a6:208:15::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.21 via Frontend Transport; Mon,
 15 Sep 2025 11:55:52 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM4PEPF00025F9B.mail.protection.outlook.com (10.167.16.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9160.0 via Frontend Transport; Mon, 15 Sep 2025 11:55:53 +0000
Received: from Postix.phytec.de (172.25.0.11) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58; Mon, 15 Sep
 2025 13:55:52 +0200
Received: from llp-moog.phytec.de (172.25.32.51) by Postix.phytec.de
 (172.25.0.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 15 Sep
 2025 13:55:52 +0200
From: Yannic Moog <y.moog@phytec.de>
Date: Mon, 15 Sep 2025 13:54:36 +0200
Subject: [PATCH 2/3] arm64: dts: imx8mp pollux: add expansion board overlay
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250915-imx8mp-pollux-display-overlays-v1-2-59508d578f0f@phytec.de>
References: <20250915-imx8mp-pollux-display-overlays-v1-0-59508d578f0f@phytec.de>
In-Reply-To: <20250915-imx8mp-pollux-display-overlays-v1-0-59508d578f0f@phytec.de>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <imx@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<upstream@lists.phytec.de>, Yannic Moog <y.moog@phytec.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757937351; l=7789;
 i=y.moog@phytec.de; s=20250509; h=from:subject:message-id;
 bh=P1405x8tYw0A65gSZzVwOfbtJmasx3MxJJ3DooivyN0=;
 b=mUyYll2vh3FrcYWunj8P1VKqh9tuEqLLlE2TEiy7/wtKLoDZNtlfZRKqhshzxuZsw995ektPs
 2QQmAAiu9RLBABMsuDKq9Wnwsdr17JBLZhmbGIqHHM57ym5lyjtjcyH
X-Developer-Key: i=y.moog@phytec.de; a=ed25519;
 pk=rpKoEJ4E7nD9qsrU/rfKVwMTWNWYaTBylZuJUXUiFr8=
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F9B:EE_|PR3P195MB0490:EE_
X-MS-Office365-Filtering-Correlation-Id: e750c415-e229-46ad-9624-08ddf44ed28c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?emNqVlJIWGM1cEN6ekNrZGR4ck9EMU1LSWw4eWpBN2VXVFp5MVo1aVVCelVn?=
 =?utf-8?B?MGQ5WHhJMDArdENwemtXbzJta2crZld0N1d5VkRCMml4Vm8vbDJub01kS2Ja?=
 =?utf-8?B?WDkwL0ZnbTYrNGszSjUzOWZNaWRDQWdIdlRWbjRpSHZHSUg4NDk2eDZQZFhE?=
 =?utf-8?B?S2VxZGpnajltazcwSWJ0dVRVc2NZeXhWVUI1SWxOUkJKcmEvc25CSHN3NFRQ?=
 =?utf-8?B?Q2JMM2swUXpkRmQvUXFIbjJuWUVTRTQxRzVqNDIrK054T1BuV0lIeFJ1NVE5?=
 =?utf-8?B?NTlORUc0SVYzV016M3hSWnJMRTRla0R1dzJQQ2lOVWh0QmpOV3BBcXY2Wko0?=
 =?utf-8?B?QjNtZ0dNNjdOeW1xckpoY0VSc1dSZ1VjUUkwNVNVMzFSYUlqZ2NDUVYwKzI2?=
 =?utf-8?B?WW9BUnRzeW1rTlJ2K0N5YVZlMDBvdVhUUDdwaXlOcWhwaUVoVWRvVmVZVThQ?=
 =?utf-8?B?aXBWa0VIdFA2cnV0M0FZQXlaZDJTajJhazhnOVRITjBKRmxRUjZvUjZnTnJK?=
 =?utf-8?B?NzdjVlNXeVE4b2dpOE8yYjVydklycGhsdDRYS2F3b0xDZFNBWWRQVVFPVVFr?=
 =?utf-8?B?MFV4VVZTNjVoZHNZSkEzaE1jdnlmZnNORi9mQ3JJQnBkeFhKcmlRUHRmMmd0?=
 =?utf-8?B?UGVLcnBDWTdIU3BrN09kUnZtYyt5eXVuZ29hY0pQN3lzazMvajNEWnlVVmIr?=
 =?utf-8?B?YnNIQ2ZyOHYxSFVMMU1zSEdVbWRvQjgrdG1ZWld4VXBRMWJPVE1jK0dxcEdu?=
 =?utf-8?B?TGt1bGRsbWNTM1BPK0t1elVUYzR6ZWxIVE9xL0NBR2E5YXdqSjBRN09McjJ6?=
 =?utf-8?B?VXltMGoyQ0U2MTFPcWNhekxST1hWYmdyWlBmdDRtcXY5UXRQV0R0QkpSUGNQ?=
 =?utf-8?B?SnBnY3pENmxIVzRaYzVFdkpCZmMrTmFIQ1lFd3dKdEFjeHNEZUNzMTBDRklI?=
 =?utf-8?B?MEhTZnFxVzRSb2xXSmJvL09pd1A2aHRpOUVwaFp3NlBQV3RKcVdLUDUwWkE3?=
 =?utf-8?B?VmFCQ2hpMHJQT3Z6WFdmanJmQVYyU1pHZ080OFAvUXduOWlFbTlZRWx6WjUr?=
 =?utf-8?B?WmpMUjkzSTNEUlhNclVaRTluOHJRbjR1dXNyUmxQMXZIYXNPTlVUdERCU1o2?=
 =?utf-8?B?Vi81enJQUllBQUREVkFwWFJiVHJzdm1CUUw2N1FnL3lqU05Dcm0yL0Y4VCs0?=
 =?utf-8?B?cGR4RTd0d2Y4a2I5U1kydnloa2JJdC9NOVcwNC84dXgyWk1oYWxXSWl4Z0tj?=
 =?utf-8?B?bzZQbDUrcXp6cExiYUFXaVRkenBZVlNaU0RUWjdDYTlZWkhZZE9sdHQ1Z1c2?=
 =?utf-8?B?bm5MS0JKTXR4S1ljcC82QWErNi9WYjl0ejJ5akdueUQ0bGlvYTFMOG5OYnlP?=
 =?utf-8?B?LzRuOEU2VTRncDZaVndzTEx3YWx1b3lHNzcvOFJzeHBXV0w5T3FBcHloWjd3?=
 =?utf-8?B?enozdndWSlV1UUZrMWFyVE5YMDZMaGJXT3N1T2YyQkkyK2EwdS84S2ZTQXRC?=
 =?utf-8?B?dlFxTlJOWnJsdmM1MUNIN212c2RJSXlqZFZTU1dyU2ZqZlVIVzV1anBraWl2?=
 =?utf-8?B?RVFJL25sNjlab1FsVlFSSmRod2l2QU9HTHBqV0oxczVvNXBSV1lYL2ZnVGFV?=
 =?utf-8?B?QWlOS1Q0c3NJbHJhSWJ4YU1TazNBR0dKUlgzcVU3cEIwNk9Jd0ErYW5aYVY4?=
 =?utf-8?B?Yk9ua3RJN3hIRy9zanQ3eC9rUnBFNVpnNStaUDFHcWJla1ZsbFVScUlNMlFk?=
 =?utf-8?B?clNaSmU1TlJyL2NhM1FCOHp0bXNTNVEya0VuOURweWVnbUhGYXpLUUxMeG9O?=
 =?utf-8?B?THl6UEVySjgvY2VsZ0JRdE1qY2JteWNpOGpIQjFoL2x0aWptYStmUndHelI2?=
 =?utf-8?B?N3VIcGw3NmxQQWx0VU1DL3RISWRSODhXNUZEdWdkNmZBQkhIQm9UNjVGWlRl?=
 =?utf-8?B?UlVVOG5SYTZVT1BVanpYMitZQUNvQkVqNGVIelRxWWVBUXBVZUNWZzllQXBu?=
 =?utf-8?B?S2dBV0dMYXdhRUcwdVBDWDVsKzlSTXM2L1F3Q3F3WHVXUG5PaUhwR1pRMkxl?=
 =?utf-8?Q?3Yvo7U?=
X-Forefront-Antispam-Report:
	CIP:91.26.50.189;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:Diagnostix.phytec.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 11:55:53.3072
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e750c415-e229-46ad-9624-08ddf44ed28c
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29;Ip=[91.26.50.189];Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00025F9B.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P195MB0490

An expansion board (PEB-AV-10) may be connected to the
imx8mp-phyboard-pollux. Its main purpose is to provide multimedia
interfaces, featuring a 3.5mm headphone jack, a USB-A port and LVDS as
well as backlight connectors.

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
index 0000000000000000000000000000000000000000..d5dcb91b2a9c41bcfa3288923d8458cf593aa4b3
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-av-10.dtsi
@@ -0,0 +1,198 @@
+// SPDX-License-Identifier: GPL-2.0
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
index 0000000000000000000000000000000000000000..27289b68dc46676d870535511f06b805df59dfa1
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-av-10.dtso
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
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


