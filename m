Return-Path: <linux-kernel+bounces-856639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B36BE4AC2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 789401A6472E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9B6334364;
	Thu, 16 Oct 2025 16:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="EYOWIyvP";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="Sxtpj4L8"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27752E2DF2;
	Thu, 16 Oct 2025 16:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760633356; cv=fail; b=CHwRlImVL8N7fvOollB4FhPBxjtsk4LiTNTGG/J62InI+65uq5h+MRn/gZ9popuXlsRo8+9+A6WXGhLvByIR80EQ3xUth7X0TkBRCFuSptY+9rCtde/1XPstuBaS/5mDRrKHxnZLf54OaRkxRh5ZbVAf79z6mgod0uV8I1fVeP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760633356; c=relaxed/simple;
	bh=qpZ11ZsPuca9SLm3L2HdGfh1b1tguGRQKklgVg0+Gik=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IighOGg8zzg2Jk09nDbQAkKmG9wpybpt+6iNZOXvI+kVvN7lPV/6O5FSXWGtv546cXPLPlOVXWoAEWcT8P+TahoqRfa6QFuMjD1ccI0Cj2uIhI69CM8m1SdGcfgAa+NYhCm/xYbFOVesfSX10x4lpWYRyWMRa+ZKlKRz2F1rWps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=EYOWIyvP; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=Sxtpj4L8; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59GDSw9t4017610;
	Thu, 16 Oct 2025 11:49:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=1R4LYlN6buXarmQz
	FtlK0xq5Vq7lY2q9cUW0/WrK7Uo=; b=EYOWIyvPtcA+tyGRcyWAo7AuxifnAaYg
	rkonl4zGiRwMGw3fDuNuD/Ku4XsZT9//0bIAAr6PkkUSBZvFHBEpITICBIAzH30U
	UolxhGB7I0Ab581Zc1Ijl+MydEQ8kh2nlxBIllUD+X7mVairHEmDF7643yJ+5XdU
	CLgqlVcFmEKP7BP9Kcpne+7jRzjWn1ps8E0cUV7GjtmF/NivYzbf6VokvsWUFKOl
	hV/APxYr7ZvHhHI+aFkz5+fYzvilfNFAszi0CI93932hH0QSATIVAa2SX8qNGHNS
	EsQxwtOaACcXtFsRuV2DZpuQGoL3+SzlR0R9eBYY917UPzMWS5h0fA==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11021140.outbound.protection.outlook.com [52.101.52.140])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 49u1mngajv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 11:49:04 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=meHHAb9TOsceyEjbnJ/CpUe4BgQIBxrfnEYPrKjho8/uGZoD38T/qUrqSCidqKcS+AVjmu+dmB0/8wb1EpIkKDL2/dRqXOORxMYawx1T0mZgGd4ZpKEk94cOSX0bSxPEERLjpBqezAax5BPvYOdfjUDSKR7ds4sIGFAOn5tnjO+skrk+zn8qq2FFhrS0RcEzc4U1tBxpj0XK+N0r84VgR7r85phgVDGhmbTUWs2JaBMK6rqx5NiGVNK95T2hyPEVL484hFw4XrzYgyoBc7I8U/TsoQW0hxRIaT4i4PNL6A4afYcVMj6nevi0vX4Qeop8wVDoqWs/3wBFfQws/TPW8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1R4LYlN6buXarmQzFtlK0xq5Vq7lY2q9cUW0/WrK7Uo=;
 b=DbuQTI/nci0+ZSDMDr4Ua4xQzrPoSoPTs130GGYkjcDlibZajWTA1oDliAtcskEUw6wL1u2IRX3ERwImrQJOJV4z79KXNh7Px+q1uYR91UavR4hvHUnHBhZLyQhAz0pX78QL8rIMVio6oAk3R5tnzraMC2arb7fZIAlOAtpqrEn38vzKc28jmKwPXPFMxaejvATMF4hQD/WvAch/xrSA9ZKRp6fgTHGyceZyUUiKgwtYjcMnVAI6nfUibAjE1Udw44CkHHGI3bfjHR32eXV0Ko/fKfkmtBzXodvsluInWwhnsYDsJKb1PSYDzeK1c3EHjnbSV8AQOk1bcdFqnEhI4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1R4LYlN6buXarmQzFtlK0xq5Vq7lY2q9cUW0/WrK7Uo=;
 b=Sxtpj4L8t2D+A3AcT0qgaAvNoYsZK+dtiQ0nwZzgEwfVyXQBHOJ7UELJW3LTOlJvNTIRi8jExVrLpw7Pdn20u4TaRqfkhpn6ZfWnU2SRVA9sjcSVKjsWADw/fSMI6Hbazmf75YoAe00LzQ+GstuVOW2DWltkt6h/sL6v7jat2WQ=
Received: from DM6PR07CA0104.namprd07.prod.outlook.com (2603:10b6:5:330::30)
 by DM4PR19MB6317.namprd19.prod.outlook.com (2603:10b6:8:a8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Thu, 16 Oct
 2025 16:49:00 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:5:330:cafe::58) by DM6PR07CA0104.outlook.office365.com
 (2603:10b6:5:330::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.13 via Frontend Transport; Thu,
 16 Oct 2025 16:49:00 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Thu, 16 Oct 2025 16:48:59 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 8378640654B;
	Thu, 16 Oct 2025 16:48:58 +0000 (UTC)
Received: from lonswws03.ad.cirrus.com (lonswws03.ad.cirrus.com [198.90.188.34])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 21EDD820249;
	Thu, 16 Oct 2025 16:48:58 +0000 (UTC)
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
Subject: [PATCH v2 00/11] Add support for Cirrus Logic CS530x DAC and CODEC variants.
Date: Thu, 16 Oct 2025 17:48:18 +0100
Message-ID: <20251016164847.138826-1-vitalyr@opensource.cirrus.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|DM4PR19MB6317:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e3c10487-ded9-489f-7c72-08de0cd3e7e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|61400799027|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Tt3GfWwqnJhUduRVF8Edmim50Fjo5uyak8u6XpO0DUcK/FPCm3/QvPflpb9O?=
 =?us-ascii?Q?s6I03yHt6bpJ4vOHTw8ES4SBlfaIQuwJUNGK5y6Tu0Ef2QyqJa8GaUQW2Sys?=
 =?us-ascii?Q?O2r18lp6LGCC+ThToYZ/6okEm2g+GJ8O12V1B5lxZzYi3Jt6Rnz7cQJsqgFK?=
 =?us-ascii?Q?YATXEitH9spD0TPhaaydNz/Yl8y12no0Xgl1T4ORJt0ioVa/bT/Qa7yk6tKu?=
 =?us-ascii?Q?MPC1ORgP8X67ctriuNeboDiV/ePYJm22dCFD9EYuiQD2h12PhwpUAT2/jPah?=
 =?us-ascii?Q?WDdNx3AZz3tQ0290TZMC468knOevkS6H1XLUBnSPbV7j60ULct+LH3WJXUIE?=
 =?us-ascii?Q?ETUi+JRyj+QVty9G6UWaTCurcrQJ8Z6yAGOeGDFZtnKw5gRxWJJMCdC83lLu?=
 =?us-ascii?Q?yQEBsaCnWtTrrW7wW/hGA3sZtyk938HNyKM7MIFHNcs6q+J6v3YV+KyQJ6Lp?=
 =?us-ascii?Q?btfEbTeVKBTgbUAvXwtCdzhz52F0h+CbRornKA49CFWFHpIY9Dg+cCCg6lG5?=
 =?us-ascii?Q?rn4a0vI8ooPopAl+uEzaGzC9Jov0BYfS8WynP0mBQ83GcQ7d95tqVayvuq9u?=
 =?us-ascii?Q?JMIDl5t1669w15mvh7Wxh72EsV1d32E5HfAUEEbR2wOyFfm71tBdxNeW2nEX?=
 =?us-ascii?Q?VaqWDVhgj1+PXn92Ew2C2k/FzPp2Edhtzy9WkBvJDQR2DHR/5kz4KpMq7Xea?=
 =?us-ascii?Q?da+eZOnWQtePY1P/vye4UBd50XVb8ypbuzj0h31l66UTzMhzHaGPGBY5a1Hq?=
 =?us-ascii?Q?9baRtKw+zHFvZR/DhZ4CUAzL98YdnBlfH25FYKbXJoShuKF5Udy6RgvgcVz1?=
 =?us-ascii?Q?N320DgJtQ06a1d+YJcsLvYtWfs8v3y7uMGTNR4OayX8Nk8t4warmERticvhF?=
 =?us-ascii?Q?jeSU6ze6VODOoeQCa7lpjRys7XlfPSnOtldIJogYhL8smN8Y2HOVL3znPKEs?=
 =?us-ascii?Q?M4XfscIScFIdR8fjX+Y8nc8dOXGVwOH0WeVl9RZFJFNXuojJVXshX6v2rnmT?=
 =?us-ascii?Q?nMf+aakQQcem5/+g0teG2aSc3J9R5thE7qrodCBvZs1ze5jk7HdTyFQ0h7+b?=
 =?us-ascii?Q?sE7f9JGOyuIArLck/fdXNRXOG4aerfNMVhZNCaErHHy+2yvY+UiZyviZMc8A?=
 =?us-ascii?Q?7IBncZJ32IEAOf5ego7uyXeSgBFOyZYVShSTyWmxHbokvq0MoAIUjzv1xwfk?=
 =?us-ascii?Q?7SUCdpC5z4nTbEslvT4zFs/YmQ88cPR+akoOlk1YoVY0qVaS/pByjmG5lj09?=
 =?us-ascii?Q?TeRScz9xIZzE1PhmVE6Gr2xfsQLkG/IvImKQu0NUkaUkW7+UF0xD4vPZZwBv?=
 =?us-ascii?Q?dRslFtHOoFlGSDjEaO8CNj3TmOxeJXpDlOH6CyzswpIKo0qsnJ3viU9FPGvc?=
 =?us-ascii?Q?Pk9hCaBn0rsDORJYXUvAMIdyH+lqajPxBCCMAL14MWMBZOI5wPZuRuTKXWcK?=
 =?us-ascii?Q?+kjSnvlrrFcESmvhljpPwKXfnLh4enkTfyzn/K8TbEogsOgJsjx/Zyus/W2z?=
 =?us-ascii?Q?JDcv1+UMvztqA60sh8kUTwudnkdWiGXuHGxBWWmSSsLUS9HeyQU2bCXIf9dN?=
 =?us-ascii?Q?A6LVDaYsmOkwDBbM5D8=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(61400799027)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 16:48:59.8775
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3c10487-ded9-489f-7c72-08de0cd3e7e6
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR19MB6317
X-Authority-Analysis: v=2.4 cv=POACOPqC c=1 sm=1 tr=0 ts=68f12200 cx=c_pps
 a=gYwftH0Zntp9Uye4m1fzyA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=hDw_Ibh-1Z5AH1WijLsA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: HZvP7VwOXYDLXTfnCwolICVC5m4goTIJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDEyMSBTYWx0ZWRfXxbBIOnqL0fTz
 Vk4GRy+lHRThHgTk+aLjmpZ129InMtEE0mcRsIgBoLa+dCHVBy/YXCjVjTL0BJRfWMixTHv2O9l
 o5ct6y5wDxG3qJu7PC4EuD6wQrn66KRT+af5XR4IwYqKI77UIePgMD8k2g/CxXbUIM77EC6Q8LR
 fBIU3w3kzC4LaKzcz/tWt71VgouKXBSESQSLaxdNDfrFGYpEIxVs1NQ55L4FsKUYo0o4OEe/0U+
 R9KB2voUARz/yf6+hm8UTSOXL36bNADvJKc0cQ0vfsfT17rnsZtiWbVaBrc7QJoQoH+g0IbQZud
 qnlQvyaPD9uJGkuIx7IiMdbpKW5uZ11Ltt3aNAOwOhV9Q76jQPSP6QRpwKqhET0q9r7xSY5xbXh
 n6px44AoWl5PScBG5wNnKIaJw59IoA==
X-Proofpoint-GUID: HZvP7VwOXYDLXTfnCwolICVC5m4goTIJ
X-Proofpoint-Spam-Reason: safe

This patch series introduces DAC, CODEC, and SPI control bus support
for Cirrus Logic CS530x variants, along with general code cleanup
and resolution of checkpatch.pl warnings.

Simon Trimmer (4):
  ASoC: cs530x: Correct log message with expected variable
  ASoC: cs530x: Add CODEC and DAC support
  ASoC: cs530x: Check the DEVID matches the devtype
  ASoC: cs530x: Rename i2c related structures

Vitaly Rodionov (7):
  ASoC: cs530x: Update the copyright headers
  ASoC: cs530x: Sort #include directives and tydy up whitespaces
  ASoC: cs530x: Remove unused struct members and constants
  ASoC: cs530x: Correct constant naming
  ASoC: cs530x: Correct MCLK reference frequency values
  ASoC: cs530x: Add SPI bus support for cs530x parts
  dt-bindings: sound: cirrus: cs530x: Add additional cs530x family
    variants

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


