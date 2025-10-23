Return-Path: <linux-kernel+bounces-866554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4A2C00147
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 390474F1908
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1CD2FB0A6;
	Thu, 23 Oct 2025 09:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="XW2YjFE9";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="cAmLGsMl"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD5C2EC0B1;
	Thu, 23 Oct 2025 09:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761210239; cv=fail; b=AISV0K6mkuvGJEfhWy85YuLfw2rOefuB/FVYgFoHZoiXTv9TzldO1QP72cb8jcgmItnoe56T2/kB2bpiSrgJidSPuFj4p3Na3s0oioqqVa0zRFP97vlWa+BZeyI+LBN8dwb/zypHPAqgTVY3FkGkiq7EhXiHD4IrjBpC78lOue4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761210239; c=relaxed/simple;
	bh=R6rtoMh98YnD/3TdP3eIig4lWEf/i49D1tnG/RZ9KdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BUIxND0nFb9DOR0ONnTacW9B5UiHuSMw4s3cJNCLWwu/UnYTbSNCVeyINhnR73SbwYFurR6azAA9ivQmdBsiPpXGwsvA3uxsUz+dTrbkAH/9q/V/gowen3qjQczOIQZ45wwin8ucIakQSXqaPmdyv3fGKu6B04LAqQ/mo+qdg8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=XW2YjFE9; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=cAmLGsMl; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59N3xgFf3465752;
	Thu, 23 Oct 2025 04:03:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=/Bt0Y3qHg9HEsnqY
	PQnT/fXw1TLAoQR8GuhiLo4gEQM=; b=XW2YjFE9Rml1WGDuUoOJ5zG/ukTzhFhz
	4BFe8VEHovv510Nwt7BXIDJnLFwTGSYSJsACWvB3n4umpITQNel4GOtvUjCs6B6E
	gEE4v5cdDRLmyX8hy1JkU7/yLTq/WEDcyhNbSTm5XXhcQC+lbtqr2lwi9IdKaPHE
	H5GpWGJeS0DjSUNMWQJaQ7Vw7N0/4xvMa8v6tbQayVfG7/yRP5q3p+XBsbhn1DoF
	uCzacfbeNDzvqYgmfAWjdTiNb2s6IAIFiRFCYfj9YviE49oucw/c4CV/WyZNh6dy
	OTTjlZ7/ZoajWBMi0dTEkRy6xPi3sj6h+oAlr4K0mJpu4Lm0k2MWQg==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11020105.outbound.protection.outlook.com [52.101.85.105])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 49xs381v5w-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 23 Oct 2025 04:03:42 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sQzOuNAAIA1f47xkId29lMrp8Uc06V45KS4M2bXAfeuzycfhO/Nd6WAEm4sIRUGeUUX6yry2m/uZch7MzkMOIpXbw89/TsStAbMkrxUapAljKpY7NyIOUZWYYKVSfBmWdvZDkOqdwN98ecQRhJZLltG2Uzd55b5EGRERkhhCLjdJyk2vswBtYYlGRVFo5DFCQxrT8iwLEPhtKabsbPXweAS214wfMkyuVskOycOfAifdhcT6jHJMKTMI1xj8XzS5VYCk89hKhjHt01Rgk0tj5ooFXWBeWI+WftUQyscPbTd/4p01bWxcbMH14SjDo7r3+YQjhwiFIM0LUyIhTfKCww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Bt0Y3qHg9HEsnqYPQnT/fXw1TLAoQR8GuhiLo4gEQM=;
 b=vZWUpELUsSxMtY+fsNSCx2iBLC2U5G72IIpPpNfK9oFxlZ8W3naKcLg0txMHDUUvSuBPSRzxmydG4L+vcGXJc9V5jvAqF5u200HeovQ54PvZxZ9k0tdUoXSXu+/GAv76Cqwq0r6f55nffz0xinn4s6aE0grLL145TVjnH1gXUAtR/0OduxYVa3krpl08oVy39mm7CnsT5XRxdoNdoYSFqKK+H76SwyksvvzfyvFZw6/+e2uIV+3/X5boK++gbkZrnJTThZ3Odb3lLWGt/UmmlaE7a4r455npf/SZ/GSt6ph6j/6yyYHw6ngHcxh39AjcHQz2PlyHF0upKGwZUV6Mfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Bt0Y3qHg9HEsnqYPQnT/fXw1TLAoQR8GuhiLo4gEQM=;
 b=cAmLGsMlvJAfG2dEyAKoyggm4KpbmlNQLOBtcKIyRY4Gb8ljUTD//E++pm6FQI9WFT7plPdVDE9mKoqDrkFgfGWEMrUn9bjBzzRqMQtxX9yAsFcupzDjylHq6AxkluYdqim1Cqtd1XQeEJaLjpJRbow5vyx8p8YdiOhtDr3HBEs=
Received: from PH8PR02CA0042.namprd02.prod.outlook.com (2603:10b6:510:2da::31)
 by PH7PR19MB7777.namprd19.prod.outlook.com (2603:10b6:510:24c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 09:03:39 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:510:2da:cafe::48) by PH8PR02CA0042.outlook.office365.com
 (2603:10b6:510:2da::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Thu,
 23 Oct 2025 09:03:39 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7
 via Frontend Transport; Thu, 23 Oct 2025 09:03:38 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id CEBE8406547;
	Thu, 23 Oct 2025 09:03:36 +0000 (UTC)
Received: from lonswws03.ad.cirrus.com (lonswws03.ad.cirrus.com [198.90.188.34])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 68F56820244;
	Thu, 23 Oct 2025 09:03:36 +0000 (UTC)
From: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To: Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        devicetree@vger.kernel.org,
        Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Subject: [PATCH v6 00/12] Add support for Cirrus Logic CS530x DAC and CODEC variants.
Date: Thu, 23 Oct 2025 10:03:08 +0100
Message-ID: <20251023090327.58275-1-vitalyr@opensource.cirrus.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|PH7PR19MB7777:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b3fefa1a-4852-4dbd-178e-08de12130e25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|61400799027|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BKbhsI45dSmVwnAymo3pIQJJ0h4KehIVqBOw/QBUmNhX3tmAZKTLWtyyklCO?=
 =?us-ascii?Q?VyPEi6I7K/j6nwLkP95uxPzuxExJ+tE/ceYOwD6i0Z+tUiSNCSCHCEu3+NhT?=
 =?us-ascii?Q?QHp6Y3jK5KEhy1XEiiHWyvcpRg6Rt/wpyXCTKXetjLNZHK0USrRaTRNZb4X6?=
 =?us-ascii?Q?CiE7s8ZrOphjeCiVPDekX57V0xV3TZsS/BeHDosz968d3/opg3dLU9acn2DO?=
 =?us-ascii?Q?C7xzIJDN/6StCLEv0LZuHOP2H3T3rWwbtnr3JOT3mbcdN+g150CfwNIDed+T?=
 =?us-ascii?Q?jUVxdNpqZZvQXBCBAtNn8TwvNQC4Q5VIaYNRM5a9xvchDjRg3b8yF5Kvjs9f?=
 =?us-ascii?Q?ejdTp7ilzp/f9Jtd+rEgCVDNjFZMc0dsL0i+7f7oqd+Qo2fxKB12H29bfDs9?=
 =?us-ascii?Q?I8uFrO9xSKOyxX87zAqYtYwEELLx5rTd1CYCpdZRcTtVIMXy82NmLd4Q+HLu?=
 =?us-ascii?Q?XFbcmc+PVacR88FY8j2kuQA04itqRLKuSAJlaqgZmYKM2TxiyKAIAC00Xtf9?=
 =?us-ascii?Q?oTSjZi6Hh3Uc5CAdE4zK09YVCPowSeUygAntHufnKAB2eoNp+TuQ2QMmI2CB?=
 =?us-ascii?Q?InIEBwnThcDnhiOA/sbA0FyJ/J76Icby3StBEi0xJsfU3YOoD9izTRYrojXy?=
 =?us-ascii?Q?swiR8CPyAkDM6j4+ffCwyH+3zOt8iiF/POK9lzfVa2V34OGn43UmJ4eaoIlR?=
 =?us-ascii?Q?GtDkhRircYKencjUhSFn/AnMSDwzw75MUfDGItPXmrkkBn9z/5p245wnFpkG?=
 =?us-ascii?Q?SpJBCbNghLrJepGp9EOXr996tNx/Bkd53Phxm3zQ/Y234MjXg/AsTNH1CGqe?=
 =?us-ascii?Q?GlJSyD6IKWpXHy6UHq3y0tAA9wC3gV7AzA9GNj21k1qFbvL1OQUqOFzH3LA2?=
 =?us-ascii?Q?suEUvtcYy5d3DwIoOIVJUicfusiggS5jf56qZ5uwTrncuVaA9bsPg7fyJoWl?=
 =?us-ascii?Q?ZplzIA+LUAtAcE/jBYYELk2bERMnqvYlJHUWy9lgnWFEn14CwSa+MgSTmD5T?=
 =?us-ascii?Q?v/YHAsX6T075A9jC0E4YpqWoa8urG5FWhWuhPUA5toKyLptRPO+O6fqGJBMI?=
 =?us-ascii?Q?91Q0K2RvH2/IJX+oxsVCO0gxymBt3NxvGJ1v/tNESbcdScMj+x4UL0aEm/6S?=
 =?us-ascii?Q?N3K8WtQXBDbbSJLCuiuJJ7W7fg0uqiudOLKBiSPGzJ20cYwS5A6+j7Mxt5fr?=
 =?us-ascii?Q?Eo9Iwpja6TmpNtFmCydGPs6PMkmN6qIBMRxHyBigA4WaQA8y06sotn91q8dx?=
 =?us-ascii?Q?IQC6kwQG6vP8DKQQz2L5VtVqx6W2MqmeQHrWXWswZr7nbMpBAJTc1Iccdn+M?=
 =?us-ascii?Q?Xg57PfASrlCto1zvKpZINJMtWF62flTh6Fc5Zbrd9PFyG1ebYRik2gs0KOyp?=
 =?us-ascii?Q?Gp/18kMV6cx68KFrfeplv9wLLs2iWmKyAKsDmF5YnonMFdfh239TGhq8FpgC?=
 =?us-ascii?Q?IdVLQF17vIcsp5VlK7/6iKQ7g6l7Y6ppJ7+A8f/jEZLdohLdji07jL4EhKlG?=
 =?us-ascii?Q?51kVzLAk2MhaRjAe11D5zoZp/k5lXeM7AKHkNy3dhDrgIshpgPZVDfGNt8wx?=
 =?us-ascii?Q?/eECa7YVUebcyRQBS1w=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(61400799027)(7416014)(376014)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 09:03:38.1214
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3fefa1a-4852-4dbd-178e-08de12130e25
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR19MB7777
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIzMDA4MCBTYWx0ZWRfX8R0VsnN+6nhG
 H+tpXQSTDC78Spq9z/s6ZBAef/kylZIF07GrAkWHPPuLWhEAcegCCPy1wHHL2O3kFxj07s0Fhpj
 jPKdwh0/cKuftCFZU4z09I/YdPYfcObdfRemoN+er+dnecWl0mU/1Z1nIrYwCaY2pX5nFt+/JbA
 /+9ES+IedMHq8D3r71bfDWnsTyoUOWDq3/fK8a2TNTFLKW01OfVnfLejhACy+31TZsy8BeQMbO5
 w0iQECZ9mPKe315413ZlIr1X3DfhSrvA4TtvKxjkyORrupaPP3xpuct716IfByUlMHW+xgBsXVK
 5o5GbvAeeh9QotWkHp0NrO6o3s0UuyYI0wV5LpttQ30SbiTTw/5ZWCBqzuJyfNeddIpG/LdtKDx
 BxEohSVumwvi+CI/sc/DLkbFeIIUXw==
X-Authority-Analysis: v=2.4 cv=W4g1lBWk c=1 sm=1 tr=0 ts=68f9ef6e cx=c_pps
 a=KI7s4FTSNOfRXFB7i9gQ4A==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=nSrgrBoJmcfvFJefXvAA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: i9JE4yYD-r9j5VXdT-xLStdXhwiWqRkC
X-Proofpoint-ORIG-GUID: i9JE4yYD-r9j5VXdT-xLStdXhwiWqRkC
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

Changes since v4:
- Sorted dt-binding properties list
- Re-worked removal of unused defenitions and structures
- Move renaming of CS530X_IN_VU to CS530X_INOUT_VU into separate patch
- Added dt-bindings SPI propery patch

Changes since v5:
- Corrected the DT-binding patch to include SPI support
and revised the commit message.

Simon Trimmer (3):
  ASoC: cs530x: Add CODEC and DAC support
  ASoC: cs530x: Check the DEVID matches the devtype
  ASoC: cs530x: Rename i2c related structures

Vitaly Rodionov (9):
  ASoC: cs530x: Update the copyright headers
  ASoC: cs530x: Sort #include directives and tydy up whitespaces
  ASoC: cs530x: Remove unused struct members and constants
  ASoC: cs530x: Correct constant naming
  ASoC: dt-bindings: sound: cirrus: cs530x: Add cs530x
  ASoC: cs530x: Rename bitfield to reflect common use for ADC and DAC
  ASoC: cs530x: Correct MCLK reference frequency values
  ASoC: dt-bindings: sound: cirrus: cs530x: Add SPI bus support
  ASoC: cs530x: Add SPI bus support for cs530x parts

 .../bindings/sound/cirrus,cs530x.yaml         |   8 +
 sound/soc/codecs/Kconfig                      |  10 +
 sound/soc/codecs/Makefile                     |   2 +
 sound/soc/codecs/cs530x-i2c.c                 |  24 +-
 sound/soc/codecs/cs530x-spi.c                 |  92 ++++
 sound/soc/codecs/cs530x.c                     | 516 +++++++++++++++---
 sound/soc/codecs/cs530x.h                     |  90 ++-
 7 files changed, 636 insertions(+), 106 deletions(-)
 create mode 100644 sound/soc/codecs/cs530x-spi.c

-- 
2.43.0


