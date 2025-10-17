Return-Path: <linux-kernel+bounces-858417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92080BEA9E0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 18:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA83B1A67959
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBD62E8B80;
	Fri, 17 Oct 2025 16:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="iKEKjpeB";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="xmdlhpyY"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32732D0C8C;
	Fri, 17 Oct 2025 16:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760717792; cv=fail; b=cQQmw0xOfeQGLO2tk3+eS71c9ssAyzatlGpXhAKNCrY7zNTRvMo4TKs+Pn6rIW/N8SCeiilK36pHQ4wmpuarD7vCot2Jg0weTNTeFnhKLi247KTAnVINACQTjZRx54A3+UuDzVaH40cOSRd8CSOUREwHdVmWurNe80EZLxR3haQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760717792; c=relaxed/simple;
	bh=fAp2fZGOFIcWotggI6glpgRDQn7ScdIobNXEWmBC3qo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XYPi+BRb03CPewu4KA1NZdXXbwDYJO4dn2BPRiu6N3oVFV9kdHvEH7C4jPLt5mpK7bF3aIP5h2u6Zq2MHJk4PM9eJmhwEk/dkd5JD1bewt4zFAuYtP9Mk8VpemvHVmnnQZy8hhhyxrh7VfggvrbJdkKg6eDgzh2V52rRg8WQW6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=iKEKjpeB; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=xmdlhpyY; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59H7kLPd4017610;
	Fri, 17 Oct 2025 11:16:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=nChfaE62jBhoNSnt
	R41SaGQxXHq1YUpaCWcvEVUZHwU=; b=iKEKjpeBXl2J0E+1WfPiXv3fVQy90qMB
	ZRT3LPs19GouDAeoWrqg694zvdvnAHMhSojGy2RCz3oOswspY4oejXIIyp+TqD/Q
	oZmlbD78FPfUgfjtvHDZdBx2i2NgnwalqA2f40ST8iLLr8SysaKYnWadGe1XQSCy
	TUcqw9kBTBnxcJ+Co5SiKyPBJaFKfO6u25Wj+2E/v8Fz2x0Zt/vZcCmi8AS5LE32
	MyBkAjEWvwMqq9Bg+BB9vDYJXof4LgXMU7aVcPwxbm3DlM/5f5E2PJfhrNEKpfWS
	epgsl/thAGWl2XRujh4L6WRg22InSsFMKel9CT0A3cnamQQqiw/Urg==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11020128.outbound.protection.outlook.com [52.101.56.128])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 49u1mnhsbg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 17 Oct 2025 11:16:01 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DF/7mQP0d01C0Apzn5+YhWQNinQY3vreWh2/aOJR5luMdu4ZFIVYJX2J38y+SxA9X106VVEZnnpET+sbO7qToJIqqMJaBZPjbeUj9q50DYR/31TNrTApsp+SAZdE1kkUlR5mQ7f+6EUMJ/0O5rfR2ib8FA2Lw8WBm0f2PBTCsfxqrqORmt6pmvXKvgjKvwatGh1QnycEo83b0Y4diN8NvqWhtsvA/TAre728npdvuvZovucd/Z0s+ynqGHU9oPHM0Yt3qw4QmU19xS1AkKZ0Nct2xcH3+QATb14ABp/74I+fAJgseQ9zUjDa9kt17JKzDwKlbkExkH2o3EL6vaU1TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nChfaE62jBhoNSntR41SaGQxXHq1YUpaCWcvEVUZHwU=;
 b=LcESAGbkvLtxPyiONcPOkcwSpcLkhEW3WyDFOT5WrmdEHf3QBP8qbAF1u2hVpP1aPSloRwzgINtvpaqoLB+jt3qvIMnQOnbYUMOUrb9TvW6s5Zqq3Zr9swMr6xTsgO4MKx9GvrQZFLJfjQrBxAXUmIoy1JlZuJk5CUh8RkSKA6QAN1vwLegaKRK0qSoJrqiqIRi42FlGsmLzdPnpLZEGQvFPLQBx9fjbBMSCnvPeVcd0kYNz3eS1bF91JCDS64HgQeatMa8l+3Y9o9RKGXAs/nSrca0f63xqOnYFkBB2VsWo8f0xdhuFHmvGG1ggfYEotHpqULo0ukuBUNjnIKu1hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nChfaE62jBhoNSntR41SaGQxXHq1YUpaCWcvEVUZHwU=;
 b=xmdlhpyYzcI9PEdzA5WxNE9MiAALbMjF3kqHHr0GIcb4HfFtTmGR6lsUYFR0/lsorhC2dmbixbzoKxx9Uj24rxZudlyD6WeT1HhaKPvQZMBaOd+m0NnLA+8LI0G0YqFrLI+y+6UP0+JhKtGK4fY02jQ3GVx+ydVABBVN4tiWLjM=
Received: from DS7PR03CA0232.namprd03.prod.outlook.com (2603:10b6:5:3ba::27)
 by DS7PR19MB5782.namprd19.prod.outlook.com (2603:10b6:8:77::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Fri, 17 Oct
 2025 16:15:55 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:5:3ba:cafe::ce) by DS7PR03CA0232.outlook.office365.com
 (2603:10b6:5:3ba::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.13 via Frontend Transport; Fri,
 17 Oct 2025 16:15:55 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7
 via Frontend Transport; Fri, 17 Oct 2025 16:15:54 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 96308406547;
	Fri, 17 Oct 2025 16:15:53 +0000 (UTC)
Received: from lonswws03.ad.cirrus.com (lonswws03.ad.cirrus.com [198.90.188.34])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 35E42820249;
	Fri, 17 Oct 2025 16:15:53 +0000 (UTC)
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
Subject: [PATCH v4 00/11] Add support for Cirrus Logic CS530x DAC and CODEC variants.
Date: Fri, 17 Oct 2025 17:15:27 +0100
Message-ID: <20251017161543.214235-1-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|DS7PR19MB5782:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 312ec00d-8ebd-47df-8772-08de0d98732c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QYCQ8KXrCPPlA6b/qGF7YW2DF5T97w9EHsXIMqNtlJtzOAXLX3q2FWpONw3O?=
 =?us-ascii?Q?MMc3QFHpacZeOrhkHmTQs3NZMzIUQmnrtmFOPsbhcE+Hw3ONYxndqDbOr4mx?=
 =?us-ascii?Q?VKN5pL7uekBaPCc/eXpy3qBzJvI6Afh0elktHYcwm6IIjtx+lmTUQOPYPd4r?=
 =?us-ascii?Q?sw+Pzr0keiqji0kwakf1o1oju12l67iVS/3aKG2147pTc+pHTm8l2rUz1gkO?=
 =?us-ascii?Q?oxG597FITdMqrK0bGHigKFaYw4165Ke9e/1XWwrgYnnEZQ9RT+mNNFswKmoe?=
 =?us-ascii?Q?JMKET9u04grRtTT/0CaFO1PV37HiCG5SqDvhzorbtUyE/RPRjlT2SzlAC9Dx?=
 =?us-ascii?Q?puBm/4XH2GCHP+92DJNaLG8E4V1ebUbZvoObMZOVseEaeAxP7frpyBgWGBOl?=
 =?us-ascii?Q?mud/ibzyreR6C22RNF/iJz4o7DY3Myo0ExATDNGsUDCBk5wfXqjDKQ7unA/1?=
 =?us-ascii?Q?uruT//L+blTWv50aVyGvqCer99vvY0Ct+0QPWKsFR8QrZpc+NniaFFsIjla3?=
 =?us-ascii?Q?sWJq3VE6WZWjq0wgell1MXcbuUz4NZN4Td5m+eC9aZmqkkgALUqoAA/SYVQg?=
 =?us-ascii?Q?zGub5DA5GZXRAxZGaDeJLQ4VQXNrHe/zfkKnJoQwF8edAnqv5Pqc2gJmtjPF?=
 =?us-ascii?Q?mkI369LS6PRPb5xzWGFk0bqC92GhIp4ikAfBT4wHUC404UtUjROd11sqv20s?=
 =?us-ascii?Q?TB/Rm9T/5g1lPiDhqOyHV4rGBsFGAzEF9riIwsLIbPT2z0gNl59aS2bMIPBn?=
 =?us-ascii?Q?hGq4iEZk4VPJpmzM3Qw+eD2oFKIyBpuf5PbsqpZGcQYjgOE4atpu5W58QBdO?=
 =?us-ascii?Q?Bu0tYDtGvILJuIGJWqxFHhT4KjCkRk93qnFKfkpux8QSEXhOuE9Oi7DOcqnP?=
 =?us-ascii?Q?gf5iooA4oySNADTfPs/FPTBuY/h91P075/mjdUlt7t/JBX33R9ieYbeKPkca?=
 =?us-ascii?Q?zi/nMRwSHXlnGEK1n+nworcYCs3VHuwlBoJZKMIVV1CrIjeONB6fcUfjASZB?=
 =?us-ascii?Q?Aw38ArWV8tkF8pVLeMv2KKsnLyIyba3f06rk/bAhi7iuLjqu5iLbBMIAyoK5?=
 =?us-ascii?Q?/DCHu5VZh7h9dJTKQv4roysu48fUfkgrYcBuMONxmScJfuAGe7O5/Yg/pkdz?=
 =?us-ascii?Q?dHGnq1uXgsxEwmhGuxwiCRrRO4QXDZB8dfVvUHivcIVaxH8lfzCKWqhwl77a?=
 =?us-ascii?Q?HgW8SbC7Oyhmltnlx+YvqOKTEc9zufV211RU9Pe57HmZ6Zx740EMHsxm34h9?=
 =?us-ascii?Q?+QmAHWPOq12F+cyI73LFF+K2EWRvnkKE1yqYq0Qlolp3xt8svMGtPIj83mvM?=
 =?us-ascii?Q?+y7352y8/pdLHe5lToVFCQt/wcitzhzp8b2fRMjCQQ0rb+yuVLaMuIhv8Mqr?=
 =?us-ascii?Q?nKORw42BuKo7OtI6bXMt0utyONXZNFb2WjCR/uARXC7izmT3KvEXXIH1ymNr?=
 =?us-ascii?Q?tqmEW52bN3j5s/e6rXhtosw7CsaxZH/bWnVGCMz6BOWmJl2syM/TdO95z3WR?=
 =?us-ascii?Q?X5Y96y1xrkU0Xx3NM0UnleTfyicAM+bH6rZGzdVLOWDCa21jSGlhU2ShKXY3?=
 =?us-ascii?Q?FsH21WE9K3Ht2q3dB9g=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 16:15:54.8985
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 312ec00d-8ebd-47df-8772-08de0d98732c
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR19MB5782
X-Authority-Analysis: v=2.4 cv=POACOPqC c=1 sm=1 tr=0 ts=68f26bc1 cx=c_pps
 a=4P4HcNC5cxRy117rOhkqbw==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=hDw_Ibh-1Z5AH1WijLsA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: jfibBhV5y3Zb6Xw9F9GB-gjUP4vBUS79
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE3MDEyMCBTYWx0ZWRfX51bPMIS/CBoP
 3Wph1Y5Cl+5bqiXXVPnKPTEfx7ZTvf4lZHPtrwTYmUaqoRAqh97PJziuAvzsZ9TWL09jW1DNUjA
 CGRhrG2//fBSKzxXl6RjJvB9DVYRqWtTlSYlBi/OIVrZG+CE8uQWXd75Q7LF++etxcDaye/AGYH
 w9+Q5baY8t5DeulrmJW2HdkjK5aqrWsC51v5IoRrlyvBZ1814Iuzhsd983dgW5Qw6EKhmq1fx/W
 5x9TXmVP8UdYZH+Q9uJo0o28txL+Lh9H1suEJCz64BTIe3iScmdCHK8uGgBLKo06zhO0NPab7Lm
 Xxwa50fpp+rMsE4VTJx695SDSy7V9y96nLTE1dNphbd5qfzp/QEbCzovaDuvu/hd+xd6N1ySjhy
 dCE0mA0891giYsLPN9gErz/p7NsowQ==
X-Proofpoint-GUID: jfibBhV5y3Zb6Xw9F9GB-gjUP4vBUS79
X-Proofpoint-Spam-Reason: safe

This patch series introduces DAC, CODEC, and SPI control bus support
for Cirrus Logic CS530x variants, along with general code cleanup
and resolution of checkpatch.pl warnings.

Changes since v1,v2,v3:

- Signed off all patches
- Splitted "tidy up" pach in 3 separate simple patches
- Fixed commit subject to much preferred subject prefix for binding patches.
- Moved dt-bindings related patch down the chain
- Added all relevant maintainers to CC list

Simon Trimmer (4):
  ASoC: cs530x: Correct log message with expected variable
  ASoC: cs530x: Add CODEC and DAC support
  ASoC: cs530x: Check the DEVID matches the devtype
  ASoC: cs530x: Rename i2c related structures

Vitaly Rodionov (7):
  ASoC: cs530x: Update the copyright headers
  ASoC: cs530x: Sort #include directives and tidy up whitespaces
  ASoC: cs530x: Remove unused struct members and constants
  ASoC: cs530x: Correct constant naming
  ASoC: dt-bindings: sound: cirrus: cs530x: Add cs530x variants
  ASoC: cs530x: Correct MCLK reference frequency values
  ASoC: cs530x: Add SPI bus support for cs530x parts

 .../bindings/sound/cirrus,cs530x.yaml         |   4 +
 sound/soc/codecs/Kconfig                      |  10 +
 sound/soc/codecs/Makefile                     |   2 +
 sound/soc/codecs/cs530x-i2c.c                 |  24 +-
 sound/soc/codecs/cs530x-spi.c                 |  92 ++++
 sound/soc/codecs/cs530x.c                     | 516 +++++++++++++++---
 sound/soc/codecs/cs530x.h                     | 120 ++--
 7 files changed, 634 insertions(+), 134 deletions(-)
 create mode 100644 sound/soc/codecs/cs530x-spi.c

-- 
2.43.0


