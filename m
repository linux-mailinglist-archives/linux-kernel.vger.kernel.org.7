Return-Path: <linux-kernel+bounces-858418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B40BEA9E6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 18:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B6B91A676D9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040D12E8B91;
	Fri, 17 Oct 2025 16:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="d1lLoh62";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="MngsgfqH"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CB52DAFCA;
	Fri, 17 Oct 2025 16:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760717792; cv=fail; b=GMLnpt8FJ5bUKGqcIwbHF/tyHypOBlyS9ecWlBQCJkif4Lv1uQNFJTb37RlYh0AuXXahXfW6d9mqbXHpgo8sBXBJjdvq1OFqkwHLBAYlRS1VQydfAslI6zeS945W7b0W6KZP/h/VGnV4I8q8hIiiYg/2NX4U3FNCn9WP+mi0Upg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760717792; c=relaxed/simple;
	bh=t0yChBw+oCh2c5xX+LW4uYJw3gRedhE7wMblsIpFS1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dBXfOvY/NDWDhQmAarhOAA/V3Xd5OPB33RbaEJ5gaGMULkBqYnqM7KVXuVl/mfE1BVL40MbOPMi5qFYZE7eKDfcXIsluwbSdkHcBHB+kc83WpYkFLym0/OjTGHldceYYGAHzKFV+LdGRphRtMlWrFYfTUOAeuJW8XPBYTUHxtGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=d1lLoh62; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=MngsgfqH; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59H4oTaK1356329;
	Fri, 17 Oct 2025 11:16:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=UxCdkfzqSS7eYmcoikNMDmPNss6YD/pi+uPnh77Lw8Q=; b=
	d1lLoh62GXb1lbqsb5fAMqm1NcwAuKv+JZWHqswnBnELCvOwi6xhK+SlRbqe8nmu
	8QRv1Xc+cGHxxrYu2QWA58QKyb2tI6n/0gvj1N8pnBI7FfzIFCFEFmAld9xkJXdN
	Tt3YY7bi4QcTLFXZAbDqAmdBz0YEBG0mNnIIloT+5BUG4c/PoCc00LzO5MaHHP7p
	o/p6F4FYJUbKZct/yfvY15jywTShZiaLPbi9oqIhhoQcgmZW0HWvldIUc+1i0JRi
	tH3WstcplvY6kKy+HX+K+Cmf2YWWBMlru858blWYqyMSD+n9ay3Qfv0T7NdyIri4
	hRkhdH3vz2yzhSuQqp9pzQ==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11021120.outbound.protection.outlook.com [40.93.194.120])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 49u1mnhsbv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 17 Oct 2025 11:16:07 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BKBlJC5Bx8i//T454kKW5IAFsLbaMIWbwI7PmxhGajQ45Drxos/f0cKmbKWhb4A0JdYt/TkuRPTqqVeloglIBjtRqyU1qRWEldBU+ALqbsbZPEIBfL9jjVCMI+5TsiHA3A3m8fYaK6PhGg+wOavBFgG0qwOkFHKvmYqBm1IVaKh4QoWSmiVa4DoETry9cytybJyk+Xbvqhh6hK0qebUWta03FLx13tuZkBfocV5wi/Daxktm1FGEvp9ewKUyqu3w+YbqPjBpUD56NKeuLOZJlt1MEeb554ypJ9fCvAGI4j62YUB3z1RUT5P8bI5+Abnh3WACWLwRJtn3Afz03790UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UxCdkfzqSS7eYmcoikNMDmPNss6YD/pi+uPnh77Lw8Q=;
 b=WCYYSq1s4F2nY5FOo2SRcSfxFeznbtz/QO/LoTg83OzlYEZbdb7pZQyRJOyfMFX+rvVaq/98Z+dRWDI5fSEZHhW6vQekIJ7cQyQiZpaHUh8+mk3jrqaBxS5Ga000l1cDuFD6sQwBoy2yy9LD6w/p3mqFvexE+7PxxDYeob2IPGV1y+SFYMIHSjtNQw+0Je1TT/mzV+qtGhOz5Qhek9t+ZLc7/mHvebgvTFeZ6FsEslz9vMHpo+yFANu6M8e2TszVhi/tBFS+pwozp3Ss8pyE0RxPTUiz6AbZNuTlgxoi8KjhYHAz1BPSIG2er+UIUPRKVqTt1boE0gwF57OpizPXDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UxCdkfzqSS7eYmcoikNMDmPNss6YD/pi+uPnh77Lw8Q=;
 b=MngsgfqH0E7wJ9VY5QbHCFkRi5jfZqt2qlBBs9LyJCCq9YFdL4wo7h43aG29w71l2coA3fgqjsLBzHElcNZ9LwPjZDI4RyxA25YJAxbRdx4RX6v5u2FlVDF1ybH0jZvxQDIge+QiH90PGZbdShAw3Qcz8XVV1L98Z/1K6ip3kyc=
Received: from MW4PR04CA0249.namprd04.prod.outlook.com (2603:10b6:303:88::14)
 by SJ0PR19MB4494.namprd19.prod.outlook.com (2603:10b6:a03:281::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 16:16:00 +0000
Received: from CO1PEPF000075F1.namprd03.prod.outlook.com
 (2603:10b6:303:88:cafe::e8) by MW4PR04CA0249.outlook.office365.com
 (2603:10b6:303:88::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.13 via Frontend Transport; Fri,
 17 Oct 2025 16:16:00 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CO1PEPF000075F1.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7
 via Frontend Transport; Fri, 17 Oct 2025 16:15:59 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id EDC66406552;
	Fri, 17 Oct 2025 16:15:57 +0000 (UTC)
Received: from lonswws03.ad.cirrus.com (lonswws03.ad.cirrus.com [198.90.188.34])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 95641822541;
	Fri, 17 Oct 2025 16:15:57 +0000 (UTC)
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
Subject: [PATCH v4 11/11] ASoC: cs530x: Add SPI bus support for cs530x parts
Date: Fri, 17 Oct 2025 17:15:38 +0100
Message-ID: <20251017161543.214235-12-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251017161543.214235-1-vitalyr@opensource.cirrus.com>
References: <20251017161543.214235-1-vitalyr@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F1:EE_|SJ0PR19MB4494:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: da1369fa-4818-4f3e-3cf5-08de0d9875cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|61400799027|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o4i0e59nJ/t6o0z74++0UmOX1oaIIfCQJ2AOrgnircwPyb/xqTE8MM11UxQf?=
 =?us-ascii?Q?xH6nn3GOy2TkIq6cQAVx9QahoXAsUmo0j6mzT9mDlBudeBhnX71lSfsh5Rb+?=
 =?us-ascii?Q?GtxGZ43o4WX8JiCmPTVFso2LyE+DToExCN/NmXjv2jq6vix5dRQE8ylId/q2?=
 =?us-ascii?Q?niJKy3Aap4/IET373vAe7EpO4ng5lPAP+8TDhK/CahqLVuZIqvCS8xfGq0FV?=
 =?us-ascii?Q?SxvsNfCQ7sS09krhT9uXwErBJ2Vg/P8ql80HXvNcYqdKcKIoEZuoEWP18FTL?=
 =?us-ascii?Q?xkHPCvtP1XLA6ogEXnCuq491kClzOZGvHg9odyp3r1d6XYd9cXKpt3Jjj2FP?=
 =?us-ascii?Q?5yhqGyA4Ye5rR+NCPln1C+VOWhy4u+65ZqpIbEzPK6nGTWYfH9p4pK0qC2zI?=
 =?us-ascii?Q?Vl3QnwyOdL3wf+Xxy21RzAb/jvfH1sDvYA9eWYB2CwuQboqYOG88SnPvIy/7?=
 =?us-ascii?Q?xL0t0aBuRr+aaeTYfwQ/dT34XbgStXwK/36mFgHkV7bX48U1lgQ8UMqoQV7Y?=
 =?us-ascii?Q?JWu9LIyGPh37iU6zA06zj02XI2Z6dvlVQJtpuDNjb3KNrq9dI6dUvaGWOppp?=
 =?us-ascii?Q?uKXMF+yz/xWya1V5AKA3Ypes4kRmi3GLXmniGbL5ggtMP/GeuT+znYMUOvFI?=
 =?us-ascii?Q?6KGuQBHgZ+SYIcO8lqZsrTCC0C8Hx6XqrxgaFI1KUW+7o85tRo+5KX77/2Dc?=
 =?us-ascii?Q?bLtGMzxoGbmllEqNIrhQKjZJgQo5IAVQnGj4l6hvwfsn3kQIzFMDx6vISnH+?=
 =?us-ascii?Q?djU06GSdW467NaxI86sykQ/2JqnvQdH+HUgN8u/WEXBqWlAMc3FVxZRQ+DZY?=
 =?us-ascii?Q?LdcovE7FwSRnukr/U+bMjIzrajssIKnNYH64v7C02OdvEX2OkyuyGay3NneN?=
 =?us-ascii?Q?3gjZCpvC3mWudetGp/ZKomXB8inCqDnTO4hvFEZYznUepeufpFznksgN57T8?=
 =?us-ascii?Q?xU1Y+UVIJlTZUED3RMbnIHP9fW3/DyES9T8GQczjDQAGUEqieBEQXTLnEyoE?=
 =?us-ascii?Q?u9ari5rcqLBoZFkt5zGmM997MuNXqCKpOhPDcqn8ijvGCuklH924KOEYTCv+?=
 =?us-ascii?Q?FWrJ9CaLJNwD2XBdkG6QkwTtExNKEX5uPa0ielKMVjccBpIRxvOfedxByZqa?=
 =?us-ascii?Q?qSgYNnAz2RDzzFCqUCoZk5xPzXl+AUA6UniqM05pMSKPbS8/Rn+ZSlVbCeqp?=
 =?us-ascii?Q?kSrFCUrP6WXoyoYf8LbDgN41Ft+a2cg06F8d8fYeK4hZI8qmGB5+UUEsjvYc?=
 =?us-ascii?Q?0DfvzePrmQjhVg2qowzIhHkSeiIKSf/qWo28L4L22EqB64C8XskcNoB1Wh3g?=
 =?us-ascii?Q?v2hFrKt4uMKMn3pxoCXoX1zGDcwF4BoIGfVd8+iDSs4iCIeKmOsf1UhSHgtd?=
 =?us-ascii?Q?eImsBagBdU49lsz/hO/sbrYmhfgH5bhkOrNpkAQR3pcpt7VVIHXsPd/Qnjj7?=
 =?us-ascii?Q?CMPy9viy8bILPs3P0tyJS6sdF4fi2p7flCXy0ViEtVgrosZmmhr7ubBDq76b?=
 =?us-ascii?Q?5pR241LhgvuBmJjwpL5sQuAWbwBfNs6dfzBz5n6HF9ZdTrreS6xS05FpE4YX?=
 =?us-ascii?Q?w8kP+rpPA//30okxfeg=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(61400799027)(7416014)(376014)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 16:15:59.2580
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da1369fa-4818-4f3e-3cf5-08de0d9875cd
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CO1PEPF000075F1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR19MB4494
X-Authority-Analysis: v=2.4 cv=POACOPqC c=1 sm=1 tr=0 ts=68f26bc7 cx=c_pps
 a=8gBNOmLjUAHmmJW2BE7dxQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=0hqhs4pA57X8KY1vVdsA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: fK7yUrwFW2umbh_2EChXHs_m8HKc94oJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE3MDEyMCBTYWx0ZWRfXxQIeSpChW7XT
 xf7iCPGWgB6FAP2CGyJFtz5RSCXX0Heuto2UUcocoUrORTCMQ2mDC2qx7Yy39x6ilYrXc0kFMPh
 pGC3j+9eKYrnEM7h8Jql/Y8H547R0DwL43qdJc4FeYlD8xccbb9m75In/8PljOMUDT5/63+iX3C
 uuyf3dSAtrRdjuAsAHiDRbQYSC3W9CvM+HqzJYvzByzgxCq8zXBnfy8K7zecOkoWKheIvKV428x
 ykMdSr6rgVp/TdlogKW19wY5ihXtV72C2p4gCX4K++XetbjhdA7WzC5iYrGlS3V5lvoF01Qc/PU
 tv2oznWkM2Yq3+QgEn10tkhG0zd/OqMGZnZlfOBM6qz3jTonaA/BD3JHQTOrUYy8wTCK7sGU9dS
 pUOJalJKvi42Fk4dYEDQZ7ogNJ0yNA==
X-Proofpoint-GUID: fK7yUrwFW2umbh_2EChXHs_m8HKc94oJ
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


