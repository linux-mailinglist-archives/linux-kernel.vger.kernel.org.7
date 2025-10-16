Return-Path: <linux-kernel+bounces-856642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC655BE4AE0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7812F4865AF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBFD3451C4;
	Thu, 16 Oct 2025 16:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="PztsKFP4";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="o41/oiap"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303D42E1730;
	Thu, 16 Oct 2025 16:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760633358; cv=fail; b=aa0ScVg+kdUkwRvbN0/hH6K3nSSjelbdiL7jicvgU+BDMwHSz2ifYq/5CSq3emkDaDFcBH0W+PNBFpzdO6EsBzUbR72ZjvZ3alfZMB463Q7Xoi2uKOnaDmanM04IeiAybJV32jZV2SCmhSPTnlN/adMuj0UTXLwDeKK1NCezycU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760633358; c=relaxed/simple;
	bh=t0yChBw+oCh2c5xX+LW4uYJw3gRedhE7wMblsIpFS1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nIxsFuEfzVA0MB115TFp9R2+8oxaMFJYHuwQ5ni34phiDHfMgb+XTaZcXOgsVzsTmwNsh5mzIzC/Gzbl7C2pp7FOTnKZHEvny5Nn4cMw6pp1SGgAyw8EoVZLaJlwV/z+b0e5M0+eOT1uaLLWuqaxZxOL9IbgEcneO6NUgCDfMI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=PztsKFP4; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=o41/oiap; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59GDTFSq4017904;
	Thu, 16 Oct 2025 11:49:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=UxCdkfzqSS7eYmcoikNMDmPNss6YD/pi+uPnh77Lw8Q=; b=
	PztsKFP4Ym5yYJWsI28I8M4lDGcT7a/EP7JbzQ5LADG2UFQcvk9zPQlZW1MDO653
	7nAc3ofFUUfIIcfIdG5JFSLmgv+x2P0Wor1ZAOOIKetUPyWv/y2qeuj4f//BlpCP
	ntH9dPdT5Ib+gIZjy3qON9jO/A+yG1oDVRaRyvHFqD7LIyDPJGleNlNfXSpbXxRr
	PlCjQDRkx4jpni57VFn0zl5YVyn3a0N2Dq9IvoAUXNQYeMFIxy5930TKydsqJDIg
	i9CsurGPCI2QwAFa4+cBOKQ2UjRLpTeTQ7vlSsBYJslLvd4LC3ZOqDFeUK2qrleP
	TjLHGTMOwKlx60slj3Bncg==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11023095.outbound.protection.outlook.com [40.93.196.95])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 49u1mngajx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 11:49:05 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M8shlSF0ovdbrhGqvldSffgVAMV2ipC7h9eaAKTNdzrcxQJa2ijnW8+Ls/FS045QHyqDEFxygUKqC8hCn6IFQ1g906qWW3f8HiotPmC6XHHjPER7TLDwCIzkcv0bSaZOU1IZDvLHlOatzBrfXS/E+HyVjNHt8oz1uksex/HfE3aBrZ07CVOD61BGMHn2+qY3lZZ38W2ov8zNXr81BWes74l4zyCBBxNuMcmICMPU/EyyxJaRK/E/K9W/wxD1y/ciMOdL7GNUA+RAaicKhMthqo4nZQRg/V31NMezSCMpN2JR5WTQVI2WxyQvLfIVyYHoipLtkI45Dq0zzzqBpnzYpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UxCdkfzqSS7eYmcoikNMDmPNss6YD/pi+uPnh77Lw8Q=;
 b=tXmlHF3P9PcQ34yIFqeHFoQT0c+E4faHMjQYzGo3QYpn4jTiZD9SC0vYOMU9nA38p5sVWsyAGlAnsfvFzFjPss/OxVbWbfXhprY7lCXimU6CTrn2fDy0q5jR2vJqQfdiWrybFu4O8rqcDYztdZEZGBr9gLcaD7wiybvhEkdtzDUP/CjMPE4sC7CoxqdIXgXpQw5J481NWdnZHM/i9PIhW0fKVtQ29iuBoHVkF4ZEOBGOgP80nlcRdSQZWK0PHXOh+LHeAvYakaxHcaXjrmNZtjOirGE+xgl6r2V9KA//AFIE72quDZUPCN793UmmZANLXarebBxbMHlN/OQtGpQuvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UxCdkfzqSS7eYmcoikNMDmPNss6YD/pi+uPnh77Lw8Q=;
 b=o41/oiap6HExiRriiI4sgqPPt+KprHwnvKx2diVSfNkWfJfdLJEzokKxT+2dWtKM5ObognAjazKGGgyZ6fjKNeWDpPW8nLleDJBaGjpX2u1Rw7qEfX2eORz0a3bMUe1qDXqdDtuCgjjr9l5uHbGR/nUYAvwyT6309HFCVdOgqlI=
Received: from MN2PR16CA0048.namprd16.prod.outlook.com (2603:10b6:208:234::17)
 by SA3PR19MB9452.namprd19.prod.outlook.com (2603:10b6:806:494::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 16:49:04 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:234:cafe::9) by MN2PR16CA0048.outlook.office365.com
 (2603:10b6:208:234::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.12 via Frontend Transport; Thu,
 16 Oct 2025 16:49:02 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Thu, 16 Oct 2025 16:49:03 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 7732D406552;
	Thu, 16 Oct 2025 16:49:02 +0000 (UTC)
Received: from lonswws03.ad.cirrus.com (lonswws03.ad.cirrus.com [198.90.188.34])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 15483822540;
	Thu, 16 Oct 2025 16:49:02 +0000 (UTC)
From: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To: Mark Brown <broonie@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        devicetree@vger.kernel.org,
        Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Subject: [PATCH v2 10/11] ASoC: cs530x: Add SPI bus support for cs530x parts
Date: Thu, 16 Oct 2025 17:48:28 +0100
Message-ID: <20251016164847.138826-11-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251016164847.138826-1-vitalyr@opensource.cirrus.com>
References: <20251016164847.138826-1-vitalyr@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|SA3PR19MB9452:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 71075967-7263-4e42-ad58-08de0cd3e9e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|61400799027;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OX04VBUZT7/ZdPyeuZgc3yn+C0HPkOlgmWekvFAc7fFKLiGaB00xKgWZXgk+?=
 =?us-ascii?Q?ng8hQwTz7aX7HMKBpY3wWw5zZgEdx4D3L8MtzuQ4j5vAcQk5S27EF1omS84o?=
 =?us-ascii?Q?oTFGdUi2yZqpFmbcbhL08t92RHOwLQDIc323+E9oJ6CtQNBGszu4xZMknwKX?=
 =?us-ascii?Q?4DPdWl10edQX8uyBaXDXYpgcqAZXz9sUsFs40sjKreyu7fBdpbCBFOX5bYLg?=
 =?us-ascii?Q?j/rYj+aZ81x2PdhryJahZWLYh20fbRULNbBVkYpWhbJBdv+dQJeqY/ksVRlB?=
 =?us-ascii?Q?QJkXm0+MVRsVQXMb70uS4UkDlth6F43zJE1BRLueevW0sTS+AFDEj82pi4zb?=
 =?us-ascii?Q?qZ0Curbp8U0fa64Gu9T9oo7fH+XZeja4nUKhvGwmWU0kui1eOcCRYtuyCbOL?=
 =?us-ascii?Q?tUBm0Auov2QwXcaB7+GB5cvHZEavkHymH7wwZpX0xFps7VjTh1dDsZMNaX1Q?=
 =?us-ascii?Q?pHB66BHqgoyb63XMOTxhGd2OaU9M9GwjVdnyzTM99fY9bsbtovW7xk+qVjHq?=
 =?us-ascii?Q?I1nNHetzUnRCePyJxFjTFdJb86pVqz1/iuprXXK5Q0DOppC9HfAFBK78YIuu?=
 =?us-ascii?Q?E+bvsMmSyC7iHQKWer2mOWRN/znN31o+qxn0k5Ypxe3T7tqhidYVFAQNKMPR?=
 =?us-ascii?Q?ZXakVjcAkUzjA9LLUEtKygcspMBK2mAjefxwYsexn7nYkOlPyY1t2uBuTHNT?=
 =?us-ascii?Q?fHRIbPBBSbVvD4Q6x6YYF5PqJ5tnVi/TWoj0nMMy7Pg0jfCnPUgZss6YK+IV?=
 =?us-ascii?Q?aaFzlGKnhRiaBgPq0YQIFS7hDvNmM09wq+7r+o85AZc0u7TyLCTiQY4+S7sm?=
 =?us-ascii?Q?7b/mB4Svq5PMbAmREKbzBlmpGUt7eOy9Khm258HU/HcXUzV0vUyMxh7Rqvfq?=
 =?us-ascii?Q?gktKs7qx8xXiFbEQVTH6aTRgrOQXU6aSgE84vX9471Q2IIeZcTPJDNMdUS+P?=
 =?us-ascii?Q?R9mrb/lk9PyKXg7LhtD6i7KPEoM+q9PRrbm54X0cztl8yOd4cLTacNubgFYP?=
 =?us-ascii?Q?UlNoTK6vcKutRkDzOvec2oTvKPnmtdnC3OMU+P1BEE1vk+S0DiCoTCAZZg9N?=
 =?us-ascii?Q?5HwSXc4wDgEEWz7QqrQaLOqevXf9z7zcVxQ+HOoTtV7+kS7SOKr28GWmlD1G?=
 =?us-ascii?Q?CbOnmTm4QCkk5MXTZSvmxhQuM5SNxkyEXuFlns8HOeG+jt5sunhS0kly0srk?=
 =?us-ascii?Q?O6mH34OCdmGteWdERU0CeOw4LWR0/+bHwuZYYHSpL4dyKTjQlnVVsscMoI/W?=
 =?us-ascii?Q?FQdMRByoAtziHEvClvayLe+JOYMtARiuDPqIipsbJ3kx2W9IbYntjYCpRbjP?=
 =?us-ascii?Q?82mwEQliKQsjQ0TPgzsghidJfjZkapGlUE09qXfRIl2yxf+7nMqgp8OI2xRQ?=
 =?us-ascii?Q?JxOULXwWvZif5BRu5e8LWw02UhSyZUXxb2NRi6JH9/bYfLo3/R5Oz8aLuN4+?=
 =?us-ascii?Q?0GjEmkpa1UyhYoJ6CyBBbcJMeXz/CoFSbuiWR+uV815RdM0NrBiobzvANGaJ?=
 =?us-ascii?Q?fsZfyDV+QQxnLP3YUfeJUWk1ZK64DQeaGeQq8auWANlGtd9dcTBhTCZNdRIC?=
 =?us-ascii?Q?jmTev17WoXnjsGu3aKk=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(61400799027);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 16:49:03.3019
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71075967-7263-4e42-ad58-08de0cd3e9e7
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR19MB9452
X-Authority-Analysis: v=2.4 cv=POACOPqC c=1 sm=1 tr=0 ts=68f12201 cx=c_pps
 a=zeqdZPKWhHZd9PAB2DpU+g==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=0hqhs4pA57X8KY1vVdsA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: MApVg1xcaKwAzVTQAD0SA5Cj9vhRD2mH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDEyMSBTYWx0ZWRfX3gLHQ1Os+VBb
 CAfD9vINjsr6Bk9YvWqGft8hnNjpuOLQEHzcfhgvieyLTotbmPjHNhnpDZld/UkH65+T/KlaSCF
 acKNJow141CllMBhtyra34WV9lCIrLtx4LFq7WOvHKnyXdmShDZmpLTagIUDYyweeC3Z3FFLOJj
 RH5RfhjRCoztyLTHzD36tsfYcG8tW7UgTxRX+EPWTAa/4ARZLogW2NzGc8dhDsGZDbD0CSkk4b2
 4gIWRJgRqCFQMEmLFZ26EgKnteMyeQjfbm3otxDKqgKJ57mEf4DEUTyDKK0fAHbNuMea8tFN56b
 tvmAxE1QvdSXCGSXYzQAR6F/aqfTc/gBD30dJeivKTfdsUZhf60hvVrqbgpHxQ6VvSzrC3XcXav
 SBDzNzzqec9XRuaTq/W4C8p3+c+DLQ==
X-Proofpoint-GUID: MApVg1xcaKwAzVTQAD0SA5Cj9vhRD2mH
X-Proofpoint-Spam-Reason: safe

Cirrus Logic cs530x device family has 2 control buses I2C and SPI.
This patch adds SPI support.

Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/soc/codecs/Kconfig      | 10 ++++
 sound/soc/codecs/Makefile     |  2 +
 sound/soc/codecs/cs530x-spi.c | 92 +++++++++++++++++++++++++++++++++++
 sound/soc/codecs/cs530x.c     | 21 ++++++++
 sound/soc/codecs/cs530x.h     |  1 +
 5 files changed, 126 insertions(+)
 create mode 100644 sound/soc/codecs/cs530x-spi.c

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 160c07699a8b..ef49f71e8b34 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -106,6 +106,7 @@ config SND_SOC_ALL_CODECS
 	imply SND_SOC_CS48L32
 	imply SND_SOC_CS53L30
 	imply SND_SOC_CS530X_I2C
+	imply SND_SOC_CS530X_SPI
 	imply SND_SOC_CX20442
 	imply SND_SOC_CX2072X
 	imply SND_SOC_DA7210
@@ -1082,6 +1083,15 @@ config SND_SOC_CS530X_I2C
 	  Enable support for Cirrus Logic CS530X ADCs
 	  with I2C control.
 
+config SND_SOC_CS530X_SPI
+	tristate "Cirrus Logic CS530x ADCs (SPI)"
+	depends on SPI_MASTER
+	select REGMAP_SPI
+	select SND_SOC_CS530X
+	help
+	  Enable support for Cirrus Logic CS530X ADCs
+	  with SPI control.
+
 config SND_SOC_CX20442
 	tristate
 	depends on TTY
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index bd95a7c911d5..39138d96a720 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -115,6 +115,7 @@ snd-soc-cs48l32-y := cs48l32.o cs48l32-tables.o
 snd-soc-cs53l30-y := cs53l30.o
 snd-soc-cs530x-y := cs530x.o
 snd-soc-cs530x-i2c-y := cs530x-i2c.o
+snd-soc-cs530x-spi-y := cs530x-spi.o
 snd-soc-cx20442-y := cx20442.o
 snd-soc-cx2072x-y := cx2072x.o
 snd-soc-da7210-y := da7210.o
@@ -546,6 +547,7 @@ obj-$(CONFIG_SND_SOC_CS48L32)	+= snd-soc-cs48l32.o
 obj-$(CONFIG_SND_SOC_CS53L30)	+= snd-soc-cs53l30.o
 obj-$(CONFIG_SND_SOC_CS530X)	+= snd-soc-cs530x.o
 obj-$(CONFIG_SND_SOC_CS530X_I2C)	+= snd-soc-cs530x-i2c.o
+obj-$(CONFIG_SND_SOC_CS530X_SPI)	+= snd-soc-cs530x-spi.o
 obj-$(CONFIG_SND_SOC_CX20442)	+= snd-soc-cx20442.o
 obj-$(CONFIG_SND_SOC_CX2072X)	+= snd-soc-cx2072x.o
 obj-$(CONFIG_SND_SOC_DA7210)	+= snd-soc-da7210.o
diff --git a/sound/soc/codecs/cs530x-spi.c b/sound/soc/codecs/cs530x-spi.c
new file mode 100644
index 000000000000..dbf1e7bbec19
--- /dev/null
+++ b/sound/soc/codecs/cs530x-spi.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// CS530x CODEC driver
+//
+// Copyright (C) 2025 Cirrus Logic, Inc. and
+//                    Cirrus Logic International Semiconductor Ltd.
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/spi/spi.h>
+
+#include "cs530x.h"
+
+static const struct of_device_id cs530x_of_match[] = {
+	{
+		.compatible = "cirrus,cs4282",
+		.data = (void *)CS4282,
+	}, {
+		.compatible = "cirrus,cs4302",
+		.data = (void *)CS4302,
+	}, {
+		.compatible = "cirrus,cs4304",
+		.data = (void *)CS4304,
+	}, {
+		.compatible = "cirrus,cs4308",
+		.data = (void *)CS4308,
+	}, {
+		.compatible = "cirrus,cs5302",
+		.data = (void *)CS5302,
+	}, {
+		.compatible = "cirrus,cs5304",
+		.data = (void *)CS5304,
+	}, {
+		.compatible = "cirrus,cs5304",
+		.data = (void *)CS5308,
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, cs530x_of_match);
+
+static const struct spi_device_id cs530x_spi_id[] = {
+	{ "cs4282", CS4282 },
+	{ "cs4302", CS4302 },
+	{ "cs4304", CS4304 },
+	{ "cs4308", CS4308 },
+	{ "cs5302", CS5302 },
+	{ "cs5304", CS5304 },
+	{ "cs5308", CS5308 },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, cs530x_spi_id);
+
+static int cs530x_spi_probe(struct spi_device *spi)
+{
+	struct cs530x_priv *cs530x;
+	struct device *dev = &spi->dev;
+	int ret;
+
+	cs530x = devm_kzalloc(dev, sizeof(struct cs530x_priv), GFP_KERNEL);
+	if (cs530x == NULL)
+		return -ENOMEM;
+
+	spi_set_drvdata(spi, cs530x);
+
+	cs530x->regmap = devm_regmap_init_spi(spi, &cs530x_regmap_spi);
+	if (IS_ERR(cs530x->regmap)) {
+		ret = PTR_ERR(cs530x->regmap);
+		dev_err(dev, "Failed to allocate register map: %d\n", ret);
+		return ret;
+	}
+
+	cs530x->devtype = (unsigned long)spi_get_device_match_data(spi);
+	cs530x->dev = &spi->dev;
+
+	return cs530x_probe(cs530x);
+}
+
+static struct spi_driver cs530x_spi_driver = {
+	.driver = {
+		.name		= "cs530x",
+		.of_match_table = cs530x_of_match,
+	},
+	.id_table	= cs530x_spi_id,
+	.probe		= cs530x_spi_probe,
+};
+
+module_spi_driver(cs530x_spi_driver);
+
+MODULE_DESCRIPTION("SPI CS530X driver");
+MODULE_IMPORT_NS("SND_SOC_CS530X");
+MODULE_AUTHOR("Vitaly Rodionov <vitalyr@opensource.cirrus.com>");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/cs530x.c b/sound/soc/codecs/cs530x.c
index 027d936c0912..6df1b37fc6c4 100644
--- a/sound/soc/codecs/cs530x.c
+++ b/sound/soc/codecs/cs530x.c
@@ -12,6 +12,7 @@
 #include <linux/pm.h>
 #include <linux/property.h>
 #include <linux/slab.h>
+#include <linux/spi/spi.h>
 #include <sound/core.h>
 #include <sound/initval.h>
 #include <sound/pcm.h>
@@ -1142,6 +1143,26 @@ const struct regmap_config cs530x_regmap_i2c = {
 };
 EXPORT_SYMBOL_NS_GPL(cs530x_regmap_i2c, "SND_SOC_CS530X");
 
+const struct regmap_config cs530x_regmap_spi = {
+	.reg_bits = 16,
+	.pad_bits = 16,
+	.val_bits = 16,
+
+	.reg_stride = 2,
+
+	.reg_format_endian = REGMAP_ENDIAN_BIG,
+	.val_format_endian = REGMAP_ENDIAN_BIG,
+
+	.max_register = CS530X_MAX_REGISTER,
+	.writeable_reg = cs530x_writeable_register,
+	.readable_reg = cs530x_readable_register,
+
+	.cache_type = REGCACHE_MAPLE,
+	.reg_defaults = cs530x_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(cs530x_reg_defaults),
+};
+EXPORT_SYMBOL_NS_GPL(cs530x_regmap_spi, "SND_SOC_CS530X");
+
 static int cs530x_check_device_id(struct cs530x_priv *cs530x)
 {
 	struct device *dev = cs530x->dev;
diff --git a/sound/soc/codecs/cs530x.h b/sound/soc/codecs/cs530x.h
index 8675a86d7d95..8af7921b3c3e 100644
--- a/sound/soc/codecs/cs530x.h
+++ b/sound/soc/codecs/cs530x.h
@@ -221,6 +221,7 @@ struct cs530x_priv {
 };
 
 extern const struct regmap_config cs530x_regmap_i2c;
+extern const struct regmap_config cs530x_regmap_spi;
 int cs530x_probe(struct cs530x_priv *cs530x);
 
 #endif
-- 
2.43.0


