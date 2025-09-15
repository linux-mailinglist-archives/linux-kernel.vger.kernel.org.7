Return-Path: <linux-kernel+bounces-816858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58197B5797C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD2231884EBA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894633043C1;
	Mon, 15 Sep 2025 11:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b="PQkyJG20"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2119.outbound.protection.outlook.com [40.107.22.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141B33002CC;
	Mon, 15 Sep 2025 11:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757937360; cv=fail; b=jaM4WNKtfhvmHM8OTHuUHTsXisrym4EnJIe5qR8eTXB9+Gl2eI7oOJCwz3NXTajngCNqBj2UnNuvzkHluBJpR4CMctM0u+autP1VNxYfFiXkAQO8joYQ+/O0ZEGJ7UsRDJmT4Wac12Y0VHJLGtoXc8/nI2H9r+efW92nmtjf9H0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757937360; c=relaxed/simple;
	bh=IdQkDLBiqr/vl0tfbYHauLFRT+C4rYCuK62ID4e5KXU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=t1T53TiqKFen1c7z4z2ziBzfl0HOAxOwZw+u/fKNoIbv0plF/JEwVNLe30qxs9X0kNAfXxDMggfZXNatgj1rxlzdlN3kSvUBRLB6lZy78/4ddhZkIw8x3a5N79A3ev1ncvp9W+dyASlQvKU5P6aIDwu0On1c8DipD+MHNYVf53A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b=PQkyJG20; arc=fail smtp.client-ip=40.107.22.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uW3rDceoyUcrKdCZgUNVJU6FxnOVC4bC/Qn8ts4eShvAAztSkeG7yoG5rzVXkGGamlkcVaD5nkNTORS15RdMpHPJBnceR8ODvrR97clBsO2oR3I9jSrbzkQwUJLZ8n7p9AH2XUkWWuvkziaUrHuBNLkvy0gcsECqxrG5BYm6AzXjYwqdD2yjQZdaZLTY9O7lIltbbF7wttjw6vtFKouUmp7heqaM3q8Vav0hvhtT7xT4tazqv/kmyCiu97YiQYCukDNsAmuI/yJcRiFVgY8rPl/+7RuBkbe03SOjxoTAYOl5XV03wbHdASNLBERWKB7fDy4TIgLjX5asNI6MO5p5+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G4sN3l2bkOBuCSk2zk75OyC4mrF5nvBpvKkaG/JnECQ=;
 b=W6VzvXcBhoGX4at2ctqLu5NFwm6jkuM9zqTyEJdfvrUkKm2oWMO9sEniacYmfFAUC/2nfDtFVedlBDf1DkxYT4EjN8rfmAqf05B02IYsFlW19MIC2vLpVWQ4OR7PbJEFJZxKNo75zv1Pf/HjJJONATZYznSYmu6qDLPOBA2vb1mNEeUcr5h5M14MXi08qnp6q9q7eEuCWMVe1V4GxTTeJOn74cxVleXIkq6cX9r9sPj8z/O5dBH7wvT8Yt1yK0A9Yx2zJ5cy3vdrapFPHuzpoCp5FpqhGuIabBXDeZNJkzn/xZBFEq+C9GekOIIVUj3oJAbz56ZtHxihVBEMqsAJbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4sN3l2bkOBuCSk2zk75OyC4mrF5nvBpvKkaG/JnECQ=;
 b=PQkyJG20IRs5i1pQwPgRIvcu6BFTNUv3xORusaUKfT2PekV8gNPXuukv8zHXQWLmnFwBn0P+aiRi/UNP71TWfVuzTbOCm4ZlSCCj4hED+Nwn7GvF7JIhSzTWrYik7g5oKjQ0rwIRux7WQ3jgl7jsh2x1ZuHYSJoCYbEQ1+T1QoK/G1LXnRQpzFypMc5QP6z3NYz6XhAvXNOfnCwojsYm+p6PNM/3LCBFAqetnca2bXrF+O8GnI4djnxBiLUETXyC3wfodg0liri+FeB4meIkkhCF3XBaEFSrUAaZmVfnDnofj8C4GZyy43YQb4TFsBGD92cN1E1TrmpxDipFzMTKHA==
Received: from AM0PR10CA0092.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::45)
 by AS8P195MB1190.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:3cd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Mon, 15 Sep
 2025 11:55:53 +0000
Received: from AM4PEPF00025F9B.EURPRD83.prod.outlook.com
 (2603:10a6:208:15:cafe::a7) by AM0PR10CA0092.outlook.office365.com
 (2603:10a6:208:15::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.21 via Frontend Transport; Mon,
 15 Sep 2025 11:55:56 +0000
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
Date: Mon, 15 Sep 2025 13:54:37 +0200
Subject: [PATCH 3/3] arm64: dts: imx8mp pollux: add displays for expansion
 board
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250915-imx8mp-pollux-display-overlays-v1-3-59508d578f0f@phytec.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757937351; l=5282;
 i=y.moog@phytec.de; s=20250509; h=from:subject:message-id;
 bh=IdQkDLBiqr/vl0tfbYHauLFRT+C4rYCuK62ID4e5KXU=;
 b=Oy4bHwHn5E4IbjNdXRFVNiMZu51EgI4si7jtcFjmBcH/VVqGikQ7nGNOGkxg12bZyp99Qj7Il
 Y1O53uJCe8UDULETyNclpjPepCB7LMszM209Xj37YxRRypTkxeDeTGb
X-Developer-Key: i=y.moog@phytec.de; a=ed25519;
 pk=rpKoEJ4E7nD9qsrU/rfKVwMTWNWYaTBylZuJUXUiFr8=
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F9B:EE_|AS8P195MB1190:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e9ec700-cf8e-4032-02b9-08ddf44ed2ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c1JuSUkzZDlFdzI5ZDNSZndZRzZ3YkJTRWFxaElsOW42RkNGeE52dHJzWG8z?=
 =?utf-8?B?TlZqNFpOQUp0ZFVNM29BY2xidUZYNW9zR29OdVgvcFVTTGd5SnRRMkE4bHEy?=
 =?utf-8?B?UGdSRHhWb1hwODh4KytZaFlsM0JJakdSZ2FEa1g5bFhqdFRqNUhEbUQyMElv?=
 =?utf-8?B?R2hHUDNaT0dYamd6TUZIUWRKVi9CQlo3Q3RPYUJRbzVVaW1kcXErdFR4cnIx?=
 =?utf-8?B?YlZ2T2Ixa1Y1eVpMd09DbEJUWVFOOUNrMEliK0NGY3ljMElPMVpZVUJwMjhR?=
 =?utf-8?B?UDdrTlhxbDQ0THRsSkNvKzdxTUFIMmo4MnhINFdHRSt6WWF5U0tCT1ExWlA5?=
 =?utf-8?B?bGtydk1TdXU5R3V3TC9zQWg3VmJ6K3hIYkljZ1oxRmduYVJpRU8vTG41SUJ1?=
 =?utf-8?B?eU1PeldnQTBtTHJJS25GckdZUFhoSHFXbFV0OFE2ZnNMclQ4RC9vTFh0VGZ3?=
 =?utf-8?B?dk9IU29lZnhxalB6Q0hKQkI2c0FiTmJaOW5CSjYxNHUyMC9hNjZDb0M4bk9Z?=
 =?utf-8?B?QnNRN2RvWkN4UURVeWVuL2ZUN1BleEd1L1ViTTRkNEJwZ0ZXZzRGQUdoNGsz?=
 =?utf-8?B?SXkvdlRZRW1OTFJabDIyUzNTUU9hblF5Vk1TWEl5Wk9vSjZIaUdZRWhURVl2?=
 =?utf-8?B?WVNCYXhXK21LNEdvSFg5VG9MY2RVWVhGeFFSbWVleUpwKzlLQ1ZUZmVNY2xK?=
 =?utf-8?B?S2FSd2RqNnpDRUo0K3RMSElNc1VFK0lBYmRRUDZ4azZGTDJxa3U0amZ1OWlU?=
 =?utf-8?B?TVRYcXlvdnExZ0ZnaTA5ZTcxeHJGMlFYWmExTG0zZmhaaG1mcW0xN0hRZkw2?=
 =?utf-8?B?VkNvcTNWRkIvcjJyRnExNnJsN3lPSW5ISkRzY2RkejZLcXRjMm0zNlVCZW1v?=
 =?utf-8?B?VGlISmdpWGxhMjUwakQwNVNrdTNlbjlWMTFhUmNBTnZMc1E0NnY4cFRkKzQw?=
 =?utf-8?B?VzRPSGRoNlRyWkRYaDhpSlV4NDRWYk94cUdxcFF4aU5YZnpIS00wVVRLMUlk?=
 =?utf-8?B?VmQ5aWcrMXcrcFIvOFV5VkhOQk9JY1N4Q3dzVUd5NXBBOVpPSER4TVcvOHJK?=
 =?utf-8?B?SkVBay9EYitReU9VT2I0U2lhN3A0RHU5Z2FTZ0M2a3JISjVFNGJxRitsekFB?=
 =?utf-8?B?U3g3eW5mU3poNExaQXoxc3RuSVFlMVI0Qk5CQyszeUQ0WUplS2dmTGY4czR3?=
 =?utf-8?B?cXd1NksreXQrZHVVN2pZL1ZmYk8rWXgzRjhpNUozM2JKUm9oVVpoNnBrQ0Zu?=
 =?utf-8?B?YTRoRk9oa0JHZ29KNS9FbWFiWXU5T3JsYzZrUVJ2dVQrUGRPeVpwL2NDenNq?=
 =?utf-8?B?a0gxVEZHMnlLenNhRUJNbVVQekcvYm9JY2F1enlsNjNWTy9tY2dLUFVpZmRF?=
 =?utf-8?B?aDJWRWluVzAzclF1ekxHeDQxVlN0cXpyQUxFL01GZkxKbUlzclRQbEk2TkJO?=
 =?utf-8?B?NGdldnVqZGJVSHU2bWthcDNqR3BHb21JbFNYbjV0czJUMk9QYWxWQitKcFZ4?=
 =?utf-8?B?S2VkVTBHd3RTYTRyWG5TWnFxTldWdjNyUWRHY1h2U1J6OENBcXlianBzSFJ0?=
 =?utf-8?B?elN4eVVReGoyZzdTTUp4ckViWmo0UFFqMTg2T3M3bFZ6Vll4ZnRGSjZzYjFX?=
 =?utf-8?B?RTNNQ2h2MTdZR0UzY2N0ME53VFBDK09YZG00dC9xYWhpcnEyVUVWNU5hcmh5?=
 =?utf-8?B?OVROQm0wSkd0anZhL0o0RVREZlJhR3gwQzh5V0tEYkpBYk8wL01uU0lNTzJW?=
 =?utf-8?B?SmFvWHpBRG1oUGY4S3BlcVJmcmxTSXU3eG1idzByU2t1WHFCcEFVTXlveVRl?=
 =?utf-8?B?OS9UYWRmQWRnNGREWGNQZW9GMkhvcGJsRkdSaW8xRDZ6Zm9lYTRzbXo1VEZY?=
 =?utf-8?B?ZmlQVnIxaTlCa1pnVFVlNm1lU0ZZTGplcS9KekVUT3l6K1g3MVhFUExzNGo4?=
 =?utf-8?B?ejIxd1RSaUoycnI4NFl2elRwM203Wm1XUjFQVmhHMS8xOG1DeGZrL3FOT2xG?=
 =?utf-8?B?SUlySnROM3JWS0ZON29meVR1S25HUE8yVzR5b0V5YlNJTndIK1hhSTdJNmNz?=
 =?utf-8?Q?aJRA00?=
X-Forefront-Antispam-Report:
	CIP:91.26.50.189;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:Diagnostix.phytec.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 11:55:53.6058
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e9ec700-cf8e-4032-02b9-08ddf44ed2ba
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29;Ip=[91.26.50.189];Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00025F9B.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P195MB1190

The same displays that can be connected directly to the
imx8mp-phyboard-pollux can also be connected to the expansion board
PEB-AV-10. For displays connected to the expansion board, a second LVDS
channel of the i.MX 8M Plus SoC is used and only a single display
connected to the SoC LVDS display bridge at a given time is supported.

Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 arch/arm64/boot/dts/freescale/Makefile             |  6 +++
 ...mp-phyboard-pollux-peb-av-10-etml1010g3dra.dtso | 45 ++++++++++++++++++++++
 ...8mp-phyboard-pollux-peb-av-10-ph128800t006.dtso | 45 ++++++++++++++++++++++
 3 files changed, 96 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 9c121041128972d2239e2cc74df98b0bf7de1ac2..e4b097446440f41785dd1a0e5d354796e800ee76 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -222,11 +222,17 @@ imx8mp-phyboard-pollux-etml1010g3dra-dtbs += imx8mp-phyboard-pollux-rdk.dtb \
 	imx8mp-phyboard-pollux-etml1010g3dra.dtbo
 imx8mp-phyboard-pollux-peb-av-10-dtbs += imx8mp-phyboard-pollux-rdk.dtb \
 	imx8mp-phyboard-pollux-peb-av-10.dtbo
+imx8mp-phyboard-pollux-peb-av-10-etml1010g3dra-dtbs += imx8mp-phyboard-pollux-rdk.dtb \
+	imx8mp-phyboard-pollux-peb-av-10-etml1010g3dra.dtbo
+imx8mp-phyboard-pollux-peb-av-10-ph128800t006-dtbs += imx8mp-phyboard-pollux-rdk.dtb \
+	imx8mp-phyboard-pollux-peb-av-10-ph128800t006.dtbo
 imx8mp-phyboard-pollux-ph128800t006-dtbs += imx8mp-phyboard-pollux-rdk.dtb \
 	imx8mp-phyboard-pollux-ph128800t006.dtbo
 imx8mp-phyboard-pollux-rdk-no-eth-dtbs += imx8mp-phyboard-pollux-rdk.dtb imx8mp-phycore-no-eth.dtbo
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-etml1010g3dra.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-peb-av-10.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-peb-av-10-etml1010g3dra.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-peb-av-10-ph128800t006.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-ph128800t006.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-rdk-no-eth.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-skov-basic.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-av-10-etml1010g3dra.dtso b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-av-10-etml1010g3dra.dtso
new file mode 100644
index 0000000000000000000000000000000000000000..7845a7e2c22f5f136562922052f23684b3b991e0
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-av-10-etml1010g3dra.dtso
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
+/*
+ * Copyright (C) 2025 PHYTEC Messtechnik GmbH
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/clock/imx8mp-clock.h>
+#include "imx8mp-phyboard-pollux-peb-av-10.dtsi"
+
+&backlight_lvds0 {
+	brightness-levels = <0 8 16 32 64 128 255>;
+	default-brightness-level = <8>;
+	enable-gpios = <&gpio5 1 GPIO_ACTIVE_HIGH>;
+	num-interpolated-steps = <2>;
+	pwms = <&pwm4 0 50000 0>;
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
+&panel_lvds0 {
+	compatible = "edt,etml1010g3dra";
+	status = "okay";
+};
+
+&pwm4 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-av-10-ph128800t006.dtso b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-av-10-ph128800t006.dtso
new file mode 100644
index 0000000000000000000000000000000000000000..4a4ac61c0f83e01411b8421edd6614ebda7057fd
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-av-10-ph128800t006.dtso
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
+/*
+ * Copyright (C) 2025 PHYTEC Messtechnik GmbH
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/clock/imx8mp-clock.h>
+#include "imx8mp-phyboard-pollux-peb-av-10.dtsi"
+
+&backlight_lvds0 {
+	brightness-levels = <0 8 16 32 64 128 255>;
+	default-brightness-level = <8>;
+	enable-gpios = <&gpio5 1 GPIO_ACTIVE_HIGH>;
+	num-interpolated-steps = <2>;
+	pwms = <&pwm4 0 66667 0>;
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
+	 * The LVDS panel uses 66.5 MHz pixel clock, set IMX8MP_VIDEO_PLL1 to
+	 * 66.5 * 7 = 465.5 MHz so the LDB serializer and LCDIFv3 scanout
+	 * engine can reach accurate pixel clock of exactly 66.5 MHz.
+	 */
+	assigned-clock-rates = <0>, <465500000>;
+	status = "okay";
+};
+
+&panel_lvds0 {
+	compatible = "powertip,ph128800t006-zhc01";
+	status = "okay";
+};
+
+&pwm4 {
+	status = "okay";
+};

-- 
2.43.0


