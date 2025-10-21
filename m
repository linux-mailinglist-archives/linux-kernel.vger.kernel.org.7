Return-Path: <linux-kernel+bounces-862678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 077A8BF5E40
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BCD018C44B6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21A932E754;
	Tue, 21 Oct 2025 10:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="S/7f1kTG";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="H4KIl4kh"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FFF32C950;
	Tue, 21 Oct 2025 10:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761043840; cv=fail; b=W492z52d44ms9xDtLkBj4v1N7w/KhH5/zEpNMnNhjtDymD0YzbghJng3w0Jok4kDip7sPzfVDqVuFiRA0OUr4xpDb2fzB6ri/AUeywZzHhW2d+V4SzsvnvZPNXHSUpSTXr123L70P7zkD9sDuOWRQJ5xL2cGQusq2fddJHQ76LE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761043840; c=relaxed/simple;
	bh=xLtGK1ivnuGtGJMqjkyMmtih5PihEDtqHLoxtEbWDlk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cP2BnLqDf3mPSfiv3VCU7tPJQDK5Sv5HcDyEQxLA2HNFull5jRpO0xVNvygWYR2cqi7ymILr4y8UinyjVBp3hh1RQOnkdXfrZaVry5dwdBazcnM4eXJUi9oaEKsBZREIgdTKdCX4gi9yTBlSLJUkcFTyL2sBP1XmykXZQS68qOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=S/7f1kTG; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=H4KIl4kh; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59L4jHCu952328;
	Tue, 21 Oct 2025 05:50:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=Ofqk3bxwqLVED1T0uwjL73JBlUwVV1bngeH9WqD8nro=; b=
	S/7f1kTGNEyNbpth6Y1aQB9EsQHJit/40JExM5QkVaXc8q0qM5SFjIrNE/Otkrzk
	1FjB4isCficQiAp2vcah+JLU6rMzkakTYPEQM3QG0HZp/SWodyw+oESMinwPnIwu
	nluoPh7HbpI28N5FSrzMNBVN79GTTyhrsvk56nv/7waMyskMLzTinU20dmIPWXvu
	yXJcknH9uFWAvyg+xOinhR/z17kkoUMNMzzgoxwLiSioegw3aMiSbIJI/8hYhxJk
	fNI7NOnhE0GP26AxF1jBARP7NlTy1IeexKWx6kETNCxAoKpbIYPGERW1Gc2TcoaN
	Jvt5T2npktro7UylhlCedA==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11021085.outbound.protection.outlook.com [52.101.57.85])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 49wnc4sdqm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 21 Oct 2025 05:50:32 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UrCL7NVnzZmfOJd6vfJMclKyW3Lfko5W07ZCiMLPO9UHF3mqarspfMmU+v+mOQj7i45jmIrrlBTDmb7UYblmh5Fuis4+XiatjSJka0tEyy0/BTGs8k/tPfV1HkZIhQlGTUtPXGeAot9SHcT/LU7sBIXzOtEcT3mENqPxNG2tDM6OHZjXwj2kEA+46zrBXIRq4/1M9fRYgIRz47IMY4D2IBgK+GnEHHKFXlSy5QGxPUzCnWYFLYvsGIue8lIMuVVgs+CPNvBmgABxZHyw18Y+A7pgHWibahG5Y5VDfro+qCE0sbrlewCFV0VYZJXbisq6kxxV6/ichVMgoss89yx+sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ofqk3bxwqLVED1T0uwjL73JBlUwVV1bngeH9WqD8nro=;
 b=exw658PVtbeEzSTK6H2Rk4vnaLyffnWcUjvKRzXudWjgknNGz1UGPjKhF3vnBOME8SUJkkGE5I//yIS8yoVptVCdzf/KgV1ZV7WgUlLNmMWvjpM22L4hgaPaBVlEr+CU7K0y+upoTfyBjLLq9xkRH0UARCNjOtkMiQF1d8JlWPqiyvJ4+scbkAN9pKqU5hNrZ3u1XK/0B6AmZwHGpG5YsICfqlDpfAQnnE6JRUjcMvigWiH1L6f59nfStcN4i5efAFNAAl2oY7c5YNg3R/ZB+RVcKptSkjciSObPafAzg/+3BB2/K/rrb4MVXBgNZ39zqmuqyDMWLBnnta+Japbmyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ofqk3bxwqLVED1T0uwjL73JBlUwVV1bngeH9WqD8nro=;
 b=H4KIl4khD+uRvQ5WVUUJhwqLg8PDnBfv6pQGTFmnfId/ED5vwqZYNz2c9sIXUC4TrMqklTv6FrbMLIqt+IfisOqRQNg1mbRQzQlQPVp1rl3Hibr5qYjlYF3M45ASJfqwxLbNG488bTeYvWHzY3ibdCHXqWzH3cS+88oCDCBiZB8=
Received: from SN7P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::15)
 by IA3PR19MB8544.namprd19.prod.outlook.com (2603:10b6:208:518::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Tue, 21 Oct
 2025 10:50:27 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:806:123:cafe::8f) by SN7P220CA0010.outlook.office365.com
 (2603:10b6:806:123::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.17 via Frontend Transport; Tue,
 21 Oct 2025 10:50:27 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7
 via Frontend Transport; Tue, 21 Oct 2025 10:50:26 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id BABE2406565;
	Tue, 21 Oct 2025 10:50:22 +0000 (UTC)
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 857F4822547;
	Tue, 21 Oct 2025 10:50:22 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: broonie@kernel.org, tiwai@suse.com
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: [PATCH v2 08/11] ASoC: cs-amp-lib: Add function to write calibration to UEFI
Date: Tue, 21 Oct 2025 11:50:19 +0100
Message-ID: <20251021105022.1013685-9-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251021105022.1013685-1-rf@opensource.cirrus.com>
References: <20251021105022.1013685-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|IA3PR19MB8544:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f494abb9-c768-4758-0100-08de108fa507
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|61400799027|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ozft1th67Ctv5JhAZfHsGhBQpO4FNKBRlzdVm0pwKjVgv5U+5XsFZ+bQaqne?=
 =?us-ascii?Q?EyekFeEryA8qHtp0Ltze3AwZfeHt5WPH/hkutOPkIEPzMNKRG47ZDMJVYu+g?=
 =?us-ascii?Q?LevHxO+lIEhKJRRflKr0v52C4M3FptLlZhF1tLfaCy8RjUlXZn0O9rsfZLUa?=
 =?us-ascii?Q?y+8LewB2avM+f92HufyFy4bgy7ziEJzMf76tS9SsG91NtWum1hJW8wlW8Zjp?=
 =?us-ascii?Q?QJWrpk+OnFd+InoTKD6crkx/JDWsV8/kYYiFkhExrjq75cRb3YEwYEh0DGn1?=
 =?us-ascii?Q?gAR0TZrInRbgJLa/mpy1TyGCrW2vGFivgzFnLSUK4HvcTNAU0Jm18AgNUXps?=
 =?us-ascii?Q?AajszYR0VBXi7i8NGPzI6ueM97qsm6y+2+p5+qTZNpMIfGIn5nVLjGE9pyu0?=
 =?us-ascii?Q?ahgICtSW6Nq5r+iSzTJMo4rvgDckI5sCVXOsbLJ9onUQ1pZgslHG9atStI5A?=
 =?us-ascii?Q?ve60rbIkUE+EqLYpoUk0rif1zb/Qi0UtHs1sIc8QF5tW60/F3Tc2PF866/mB?=
 =?us-ascii?Q?s/03iEci1DDRUzq5EARPqJjm9tXOO2dBWqlClj4TTw5W43xArJV8HievM0o5?=
 =?us-ascii?Q?paFOAerrUrRknixhzVfkF2IuK7mM4QtmWTft6gMyxVlchObqUKBdGDJ55ZrQ?=
 =?us-ascii?Q?ay8yJ59mbOYhTA8o3CGXSYZaKDxh3osJ0HRhdNXUntt4ESwiNsBeiEmEhnfk?=
 =?us-ascii?Q?BnH4rZefAvGFFcssqopo91u17qxIFbuWwCxZ2szk6+dZIt5tv1qCqjboMMdG?=
 =?us-ascii?Q?hDQMzdKKWBV9ZY6MtS7s8/5m634yqZPszW4glsY5S+a0QZ7l9X3NnEgK9pLS?=
 =?us-ascii?Q?HOFFvYw4Q48TmIMoEbFuD5hzFzZ0uGGBpMxA50943kCmQIj5TRLVWCfFtmSH?=
 =?us-ascii?Q?mDoi3QrL/ZO+vAlnKv+oVxB3coALvv3IbWahh6us+Qf6EIH/wW+MRIzMRP9v?=
 =?us-ascii?Q?xDYXP7kohcII7FBvcbVNxpAA0nscW5ILExsBMPEucfj0+467STlcX1wtxdsg?=
 =?us-ascii?Q?4ExQybTeteZQ8q89f2p0hD/uFAeL6ZcrX7EYQcidLMMIcmaZA+MV7w53Azql?=
 =?us-ascii?Q?JOxY1vB3BWluYrlApvjhCqyLP8zpHzc+jFNGPn2g7gQC3lkcqKIr3MyM2iCG?=
 =?us-ascii?Q?QNnQMlSjmFh+RAp1qJUcmhqfgQi0uqty8ASpblmQKvlLjLs1x2EihnqlLmbQ?=
 =?us-ascii?Q?bVI3+ma97FEyAaTQMA1QAOk9Agz55jwujzJdfooHm3pL2GfXrELTIvQB6X1H?=
 =?us-ascii?Q?kgmIjpOTxd9kRJJhio+rN6kcu8erlhbV9HCkzkvsg7thAD2yAdKsoqRf4dVI?=
 =?us-ascii?Q?ADpG4/dFlwUZoIrV6malL8bCBJzJx+OiN1wyVwINTbU8dc9K+RkDO1AgcCnp?=
 =?us-ascii?Q?/KMip2pD8ioTsKjL1KrCEX5aUPjhIGYQ1TRlXXkIULNWlB6IcZPButjUJACO?=
 =?us-ascii?Q?6jypSBT9ntQdb2/VN8tigCpyG5F+WjxkoFHvHWj4CKkszknyRnCHbsJLrDdO?=
 =?us-ascii?Q?lHtXsRtmp51f/MK+DRBlaioKAppI0hwShoHfAGuHVoidaCUNcy9ZvLL1G0RZ?=
 =?us-ascii?Q?z5RCENK2B8Ma+Cu9yX4=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(61400799027)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 10:50:26.5541
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f494abb9-c768-4758-0100-08de108fa507
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR19MB8544
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIxMDA4NSBTYWx0ZWRfX2xZdb4bPesFY
 bVLP1L4Ej9uJgEysGAJ7pfBbrwv/m6A+69ZUbyuHUX/KOF5xEEH5uyn1ilZjjF2EUK8tB9u8Ukv
 jECwna3unszm6YGpSacmTx2SKX8W5LOY/17B44vhVJBAs5YmoSIv2isJqrtYZvSvkCSGfoAw85M
 jHaiGAkxYlkB4eYNs4Ep0XU2MBTmGPwWxcOrtqJ2DZYI1vOgVOjIsOE+Aj7t+IczI6u5PHE2p4A
 6TPWEmSrWcsKElmG6btq5aJzvdw7Fs3NxWXLWN1H4TnXUMbq5iGyXL1vaGTie7cmQmS9H0cdCAM
 x7X//Z+pDrLgvATOGtRGOEIQPHj9a1GHEPXzmQh7ASEvAons8QYeM1LpP9VgG6nRITIpJ/CstnO
 j4GoZBbPCWERdVezIq6Z2siIcwMXBw==
X-Proofpoint-GUID: VI9FZ8GXaNK3YlXyO4fx5aOc3jgPbog-
X-Proofpoint-ORIG-GUID: VI9FZ8GXaNK3YlXyO4fx5aOc3jgPbog-
X-Authority-Analysis: v=2.4 cv=bf1mkePB c=1 sm=1 tr=0 ts=68f76578 cx=c_pps
 a=SDOlI5lSWczX7ANjW/fhbQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=Rj8EF44HmWohM5JNfgoA:9
X-Proofpoint-Spam-Reason: safe

Add cs_amp_set_efi_calibration_data() to write an amp calibration
blob to UEFI calibration variable.

The UEFI variable will be updated or created as necessary.

- If a Vendor-specific variable exists it will be updated,
  else if the Cirrus variable exists it will be update
  else the Cirrus variable will be created.

Some collateral changes are required:

- cs_amp_convert_efi_status() now specifically handles
  EFI_WRITE_PROTECTED error.

- cs_amp_get_cal_efi_buffer() can optionally return the name,
  guid and attr of the variable it found.

- cs_amp_get_cal_efi_buffer() will update the 'size' field of
  the returned data blob if it is zero. The BIOS could have
  pre-allocated the UEFI variable as zero-filled

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
No changes since V1.

 include/sound/cs-amp-lib.h    |   2 +
 sound/soc/codecs/cs-amp-lib.c | 190 +++++++++++++++++++++++++++++++++-
 2 files changed, 188 insertions(+), 4 deletions(-)

diff --git a/include/sound/cs-amp-lib.h b/include/sound/cs-amp-lib.h
index 2e5616a5e1f7..240bc53a9307 100644
--- a/include/sound/cs-amp-lib.h
+++ b/include/sound/cs-amp-lib.h
@@ -55,6 +55,8 @@ int cs_amp_write_ambient_temp(struct cs_dsp *dsp,
 			      u32 temp);
 int cs_amp_get_efi_calibration_data(struct device *dev, u64 target_uid, int amp_index,
 				    struct cirrus_amp_cal_data *out_data);
+int cs_amp_set_efi_calibration_data(struct device *dev, int amp_index, int num_amps,
+				    const struct cirrus_amp_cal_data *in_data);
 int cs_amp_get_vendor_spkid(struct device *dev);
 struct dentry *cs_amp_create_debugfs(struct device *dev);
 
diff --git a/sound/soc/codecs/cs-amp-lib.c b/sound/soc/codecs/cs-amp-lib.c
index c5791cbeb5b8..7038574e3f4b 100644
--- a/sound/soc/codecs/cs-amp-lib.c
+++ b/sound/soc/codecs/cs-amp-lib.c
@@ -13,6 +13,7 @@
 #include <linux/firmware/cirrus/cs_dsp.h>
 #include <linux/math64.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/overflow.h>
 #include <linux/slab.h>
 #include <linux/timekeeping.h>
@@ -49,9 +50,16 @@ static const struct cs_amp_lib_cal_efivar {
 	},
 };
 
+#define CS_AMP_CAL_DEFAULT_EFI_ATTR			\
+		(EFI_VARIABLE_NON_VOLATILE |		\
+		 EFI_VARIABLE_BOOTSERVICE_ACCESS |	\
+		 EFI_VARIABLE_RUNTIME_ACCESS)
+
 /* Offset from Unix time to Windows time (100ns since 1 Jan 1601) */
 #define UNIX_TIME_TO_WINDOWS_TIME_OFFSET	116444736000000000ULL
 
+static DEFINE_MUTEX(cs_amp_efi_cal_write_lock);
+
 static u64 cs_amp_time_now_in_windows_time(void)
 {
 	u64 time_in_100ns = div_u64(ktime_get_real_ns(), 100);
@@ -263,6 +271,20 @@ static efi_status_t cs_amp_get_efi_variable(efi_char16_t *name,
 	return EFI_NOT_FOUND;
 }
 
+static efi_status_t cs_amp_set_efi_variable(efi_char16_t *name,
+					    efi_guid_t *guid,
+					    u32 attr,
+					    unsigned long size,
+					    void *buf)
+{
+	KUNIT_STATIC_STUB_REDIRECT(cs_amp_set_efi_variable, name, guid, attr, size, buf);
+
+	if (!efi_rt_services_supported(EFI_RT_SUPPORTED_SET_VARIABLE))
+		return EFI_NOT_FOUND;
+
+	return efi.set_variable(name, guid, attr, size, buf);
+}
+
 static int cs_amp_convert_efi_status(efi_status_t status)
 {
 	switch (status) {
@@ -272,6 +294,7 @@ static int cs_amp_convert_efi_status(efi_status_t status)
 		return -ENOENT;
 	case EFI_BUFFER_TOO_SMALL:
 		return -EFBIG;
+	case EFI_WRITE_PROTECTED:
 	case EFI_UNSUPPORTED:
 	case EFI_ACCESS_DENIED:
 	case EFI_SECURITY_VIOLATION:
@@ -281,7 +304,10 @@ static int cs_amp_convert_efi_status(efi_status_t status)
 	}
 }
 
-static struct cirrus_amp_efi_data *cs_amp_get_cal_efi_buffer(struct device *dev)
+static struct cirrus_amp_efi_data *cs_amp_get_cal_efi_buffer(struct device *dev,
+							     efi_char16_t **name,
+							     efi_guid_t **guid,
+							     u32 *attr)
 {
 	struct cirrus_amp_efi_data *efi_data;
 	unsigned long data_size = 0;
@@ -293,7 +319,7 @@ static struct cirrus_amp_efi_data *cs_amp_get_cal_efi_buffer(struct device *dev)
 	for (i = 0; i < ARRAY_SIZE(cs_amp_lib_cal_efivars); i++) {
 		status = cs_amp_get_efi_variable(cs_amp_lib_cal_efivars[i].name,
 						 cs_amp_lib_cal_efivars[i].guid,
-						 NULL, &data_size, NULL);
+						 attr, &data_size, NULL);
 		if (status == EFI_BUFFER_TOO_SMALL)
 			break;
 	}
@@ -301,6 +327,12 @@ static struct cirrus_amp_efi_data *cs_amp_get_cal_efi_buffer(struct device *dev)
 	if (status != EFI_BUFFER_TOO_SMALL)
 		return ERR_PTR(-ENOENT);
 
+	if (name)
+		*name = cs_amp_lib_cal_efivars[i].name;
+
+	if (guid)
+		*guid = cs_amp_lib_cal_efivars[i].guid;
+
 	if (data_size < sizeof(*efi_data)) {
 		dev_err(dev, "EFI cal variable truncated\n");
 		return ERR_PTR(-EOVERFLOW);
@@ -313,7 +345,7 @@ static struct cirrus_amp_efi_data *cs_amp_get_cal_efi_buffer(struct device *dev)
 
 	status = cs_amp_get_efi_variable(cs_amp_lib_cal_efivars[i].name,
 					 cs_amp_lib_cal_efivars[i].guid,
-					 NULL, &data_size, data);
+					 attr, &data_size, data);
 	if (status != EFI_SUCCESS) {
 		ret = -EINVAL;
 		goto err;
@@ -329,6 +361,10 @@ static struct cirrus_amp_efi_data *cs_amp_get_cal_efi_buffer(struct device *dev)
 		goto err;
 	}
 
+	/* This could be zero-filled space pre-allocated by the BIOS */
+	if (efi_data->size == 0)
+		efi_data->size = data_size;
+
 	return efi_data;
 
 err:
@@ -338,6 +374,20 @@ static struct cirrus_amp_efi_data *cs_amp_get_cal_efi_buffer(struct device *dev)
 	return ERR_PTR(ret);
 }
 
+static int cs_amp_set_cal_efi_buffer(struct device *dev,
+				     efi_char16_t *name,
+				     efi_guid_t *guid,
+				     u32 attr,
+				     struct cirrus_amp_efi_data *data)
+{
+	efi_status_t status;
+
+	status = cs_amp_set_efi_variable(name, guid, attr,
+					 struct_size(data, data, data->count), data);
+
+	return cs_amp_convert_efi_status(status);
+}
+
 static int _cs_amp_get_efi_calibration_data(struct device *dev, u64 target_uid, int amp_index,
 					    struct cirrus_amp_cal_data *out_data)
 {
@@ -345,7 +395,7 @@ static int _cs_amp_get_efi_calibration_data(struct device *dev, u64 target_uid,
 	struct cirrus_amp_cal_data *cal = NULL;
 	int i, ret;
 
-	efi_data = cs_amp_get_cal_efi_buffer(dev);
+	efi_data = cs_amp_get_cal_efi_buffer(dev, NULL, NULL, NULL);
 	if (IS_ERR(efi_data))
 		return PTR_ERR(efi_data);
 
@@ -397,6 +447,98 @@ static int _cs_amp_get_efi_calibration_data(struct device *dev, u64 target_uid,
 	return ret;
 }
 
+static int _cs_amp_set_efi_calibration_data(struct device *dev, int amp_index, int num_amps,
+					    const struct cirrus_amp_cal_data *in_data)
+{
+	u64 cal_target = cs_amp_cal_target_u64(in_data);
+	unsigned long num_entries;
+	struct cirrus_amp_efi_data *data __free(kfree) = NULL;
+	efi_char16_t *name = CIRRUS_LOGIC_CALIBRATION_EFI_NAME;
+	efi_guid_t *guid = &CIRRUS_LOGIC_CALIBRATION_EFI_GUID;
+	u32 attr = CS_AMP_CAL_DEFAULT_EFI_ATTR;
+	int i, ret;
+
+	if (cal_target == 0)
+		return -EINVAL;
+
+	data = cs_amp_get_cal_efi_buffer(dev, &name, &guid, &attr);
+	ret = PTR_ERR_OR_ZERO(data);
+	if (ret == -ENOENT) {
+		data = NULL;
+		goto alloc_new;
+	} else if (ret) {
+		return ret;
+	}
+
+	/*
+	 * If the EFI variable is just zero-filled reserved space the count
+	 * must be set.
+	 */
+	if (data->count == 0)
+		data->count = (data->size - sizeof(data)) / sizeof(data->data[0]);
+
+	if (amp_index < 0) {
+		/* Is there already a slot for this target? */
+		for (amp_index = 0; amp_index < data->count; amp_index++) {
+			if (cs_amp_cal_target_u64(&data->data[amp_index]) == cal_target)
+				break;
+		}
+
+		/* Else find an empty slot */
+		if (amp_index >= data->count) {
+			for (amp_index = 0; amp_index < data->count; amp_index++) {
+				if ((data->data[amp_index].calTime[0] == 0) &&
+				    (data->data[amp_index].calTime[1] == 0))
+					break;
+			}
+		}
+	} else {
+		/*
+		 * If the index is forced there could be another active
+		 * slot with the same calTarget. So deduplicate.
+		 */
+		for (i = 0; i < data->count; i++) {
+			if (i == amp_index)
+				continue;
+
+			if ((data->data[i].calTime[0] == 0) && (data->data[i].calTime[1] == 0))
+				continue;
+
+			if (cs_amp_cal_target_u64(&data->data[i]) == cal_target)
+				memset(data->data[i].calTime, 0, sizeof(data->data[i].calTime));
+		}
+	}
+
+alloc_new:
+	if (amp_index < 0)
+		amp_index = 0;
+
+	num_entries = max(num_amps, amp_index + 1);
+	if (!data || (data->count < num_entries)) {
+		struct cirrus_amp_efi_data *old_data __free(kfree) = no_free_ptr(data);
+		unsigned int new_data_size = struct_size(data, data, num_entries);
+
+		data = kzalloc(new_data_size, GFP_KERNEL);
+		if (!data)
+			return -ENOMEM;
+
+		if (old_data)
+			memcpy(data, old_data, struct_size(old_data, data, old_data->count));
+
+		data->count = num_entries;
+		data->size = new_data_size;
+	}
+
+	data->data[amp_index] = *in_data;
+	ret = cs_amp_set_cal_efi_buffer(dev, name, guid, attr, data);
+	if (ret) {
+		dev_err(dev, "Failed writing calibration to EFI: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 /**
  * cs_amp_get_efi_calibration_data - get an entry from calibration data in EFI.
  * @dev:	struct device of the caller.
@@ -443,6 +585,46 @@ int cs_amp_get_efi_calibration_data(struct device *dev, u64 target_uid, int amp_
 }
 EXPORT_SYMBOL_NS_GPL(cs_amp_get_efi_calibration_data, "SND_SOC_CS_AMP_LIB");
 
+/**
+ * cs_amp_set_efi_calibration_data - write a calibration data entry to EFI.
+ * @dev:	struct device of the caller.
+ * @amp_index:	Entry index to use, or -1 to use any available slot.
+ * @num_amps:	Maximum number of amps to reserve slots for, or -1 to ignore.
+ * @in_data:	struct cirrus_amp_cal_data entry to be written to EFI.
+ *
+ * If a Vendor-specific variable exists it will be updated,
+ * else if the Cirrus variable exists it will be updated
+ * else the Cirrus variable will be created.
+ *
+ * If amp_index >= 0 the data will be placed in this entry of the calibration
+ * data array, overwriting what was in that entry. Any other entries with the
+ * same calTarget will be marked empty.
+ *
+ * If amp_index < 0 and in_data->calTarget matches any existing entry, that
+ * entry will be overwritten. Else the first available free entry will be used,
+ * extending the size of the EFI variable if there are no free entries.
+ *
+ * If num_amps > 0 the EFI variable will be sized to contain at least this
+ * many calibration entries, with any new entries marked empty.
+ *
+ * Return: 0 if the write was successful, -EFBIG if space could not be made in
+ *	   the EFI file to add the entry, -EACCES if it was not possible to
+ *	   read or write the EFI variable.
+ */
+int cs_amp_set_efi_calibration_data(struct device *dev, int amp_index, int num_amps,
+				    const struct cirrus_amp_cal_data *in_data)
+{
+	if (IS_ENABLED(CONFIG_EFI) || IS_ENABLED(CONFIG_SND_SOC_CS_AMP_LIB_TEST)) {
+		scoped_guard(mutex, &cs_amp_efi_cal_write_lock) {
+			return _cs_amp_set_efi_calibration_data(dev, amp_index,
+								num_amps, in_data);
+		}
+	}
+
+	return -ENOENT;
+}
+EXPORT_SYMBOL_NS_GPL(cs_amp_set_efi_calibration_data, "SND_SOC_CS_AMP_LIB");
+
 struct cs_amp_spkid_efi {
 	efi_char16_t *name;
 	efi_guid_t *guid;
-- 
2.47.3


