Return-Path: <linux-kernel+bounces-856021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5AEBE2E34
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 12:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C2EA34EAAF0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 10:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB478320CB9;
	Thu, 16 Oct 2025 10:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="aQHy1J1H";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="o1w2w3td"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCAC31A061;
	Thu, 16 Oct 2025 10:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760611381; cv=fail; b=X7rBtl6F8Vm46ivVogO+vt9Fdfqd8f41eB//NPJnlcrz9ZfWANd4OFiDXQFljrkS/77PTJ17w1j8HYQQZVloNCxME6lUVZ4jJn9drJ+BNuqcYyVdluFjDbntgc2WrC4D0qQvE96oPwME8zckT8Hju2OrImlxk0Peu5Ry/HXh8M4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760611381; c=relaxed/simple;
	bh=hoLtWMQdm/5RP3W/qFhF5fpqd9K4KxyrQ6MunaitaBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uGXmyJ9eQ3cwHdkfmDbmX8rUHTcOPVdP/ibuXMutic6sdikKiwlZHtUyXiG13P8kf+/tg0JQP5kabYkOdc5YGcSHvRhpw28i+xG4hI2lYEnTYVD+fyYC361jnBAPzE1PBJTMA/rbqEqYqE/CEt6XfjQudNe7xL21kemRTfvcnlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=aQHy1J1H; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=o1w2w3td; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59G8fDdE2477160;
	Thu, 16 Oct 2025 05:42:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=yLw1YDXsv4VlmjiWJqqG2pI5bwANWIKfg3OJ8PPMYDg=; b=
	aQHy1J1Hk0zh/ja9pctyrJ0YsYAEjZytsxXJR7NjVqsdNwsnFmD873PEQoHo4qOC
	QEtwnR29+2n59SxQ5Slbkhz/Ngv0zVpCRm4aYQhOQUF/Ipv0zBPDxfq3kiTjjTi7
	ivD81KPtqs4vtlVjWIpCUPgyCJQZuc72L9fBiK5NbPyxZGWtgBlijBuct6l4uPkh
	1lnBGs1VFROsX/GOk6KIUA+39rg/eBkh2tj2wREU8NDsxGYAZ0utjXefV+noPB92
	MlGrHQ3ZPDMF4n2gUkKsRzHMOvctzMyOp/CBcszfYidEOpcojMB6L7vCUdOU13B3
	gcAo9TOy0Ed0+/ACYDr3Pw==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11021140.outbound.protection.outlook.com [40.93.194.140])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 49t9mhhpx5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 05:42:53 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZxAKi+0uA+j6fKcUpShfZgJXnIpbV6NqIKV+MkvgrKKD75Irj5eCa9/lkuUI1HMaJUKp6qJrOmRCzLfPR1bRll77rmOQeF60lmiaVbKbFkiYfxJ03Z3K2BxkwePV5rEPXt6OTmkFbVWkGK6F+fgtoDn+Ko1d9+UyTdFOl5adfnJgyjoWTI4ftt45mNk8JIAQCPPIYa7QaffmSCQLal1DcGArJA2RCv6Aqc+Tqhqw6BiCfqx3ziPZ/VSHKoiiYh2N6OrxaR/FaZCD0wvWnKJKKEslg5SeYY/1Edtw9h7lFY8an/koPKiW6PU8ZY4udFU2Ph4MKh377FVMxW+bvs7e6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yLw1YDXsv4VlmjiWJqqG2pI5bwANWIKfg3OJ8PPMYDg=;
 b=HwDY6+Ouxp3GsK02e89EsST6YvKTsaRC96+KdF/oHsADaz/ANTZFThLc29whCGt27DcIKLOEt1cneVPojQSV7+sKuMPTiVwWHnodcuvr/zuq+T/WvVO/oTVWQOwbbxaNwCKAwYAlg/Hc6u9eiUdPAyiFeXAOQ+C72dcFl/WfsL/Tu036x3yVCMcXFb8lAYMsH7K1RfMAAadbbFC31kY+2MeSGGx7+O/4PEDr/6rtdcdH310zwKy/M/Y8RxRdklX96pzjZjKT2UtmAz507YRWNwKTtkRTEQE+Qs4j9GxSNMF1cM9h01uqw0P2+3Qi3OI2jUgKZjU6w1l9EuzVhn7Leg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yLw1YDXsv4VlmjiWJqqG2pI5bwANWIKfg3OJ8PPMYDg=;
 b=o1w2w3tdkfVQeN+5EFBDGwbxpnHUzXAUh+GqvjRFx1tYMHz8L6W8cqq4RZrD2FkKhWCjrvlPZ3WR0nAQF9Z/G6n/UEzcH0UNJHxXg8yODNsBWSrunztZyk5X+BrZ6jYztPnm1NeOwglW0Ao0p8ZUodT08D+0UZpJeGkVm/gU7N4=
Received: from BYAPR04CA0025.namprd04.prod.outlook.com (2603:10b6:a03:40::38)
 by IA1PR19MB7943.namprd19.prod.outlook.com (2603:10b6:208:44e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 10:42:47 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:a03:40:cafe::b) by BYAPR04CA0025.outlook.office365.com
 (2603:10b6:a03:40::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.11 via Frontend Transport; Thu,
 16 Oct 2025 10:42:47 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Thu, 16 Oct 2025 10:42:46 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 029DF406565;
	Thu, 16 Oct 2025 10:42:43 +0000 (UTC)
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id E3C4C822540;
	Thu, 16 Oct 2025 10:42:42 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: broonie@kernel.org, tiwai@suse.com
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: [PATCH 08/11] ASoC: cs-amp-lib: Add function to write calibration to EFI
Date: Thu, 16 Oct 2025 11:42:39 +0100
Message-ID: <20251016104242.157325-9-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251016104242.157325-1-rf@opensource.cirrus.com>
References: <20251016104242.157325-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|IA1PR19MB7943:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: fa202a7b-f570-4bc1-f930-08de0ca0beaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4ldPyEbkJgddKkaLm9gmTegZcyGe5hl7t+lK07aafEVgoyHyww4lCoSY7evA?=
 =?us-ascii?Q?+ZDWcBRumUatBBD7r2kMOaRhTPejtr0vT4G6s8tKdqUqnPiqMathpR7lbm6A?=
 =?us-ascii?Q?G0BtYRw5D0XXtzCEs2BekPAxdR5V39GrZGkSP4hAO7mEVsfPDKmcbfV3RhKG?=
 =?us-ascii?Q?14BDqTTX5iEiTpb2g+E6rDQb5NSUyEdSi5tmrSx5nNFSFkIjfezqy/ugO5LV?=
 =?us-ascii?Q?x/wjYf3zqlAbvfxmbOn94WrNorDlwqWyiwP2BescC13XQTGLLAmmWNbT2k3+?=
 =?us-ascii?Q?FnPv3k4rZoAynm8nws27E43ioQ6M52RjseVC7AfmC+zqYie8U7mmLSeOFyO+?=
 =?us-ascii?Q?i7qsE3RivumIepsJ7LTu5ttRkzNuBycoJ822fmScWi09/ThIj+icv+kZpZSS?=
 =?us-ascii?Q?Kif7G1heccu8tX17omlw6FXwFUKU5XIDIO9qDkg006eyE1M2AVAhbEH+OO1F?=
 =?us-ascii?Q?f2EJZaHP7uH5e7lDImZi3H4wEl3WyUl+xe6EvBrd7HoaxvnpEH/OCwCelC/Q?=
 =?us-ascii?Q?NClP7BV1sR57KsBM+hOwjmOYdE3OpqNGckLVQuiqfUeoocaceuLZQFiBG6o1?=
 =?us-ascii?Q?08UUpawyrTYyODs1XBgegyfBBk2SMd85gltJQsbWM+8Qi8yy8MxRdL0XQ/8g?=
 =?us-ascii?Q?F7MULudCzgaUVPsa+isalP/dgUS+Wsu+VAkY3RrBwxn34FgzaHYQiHKtJi9s?=
 =?us-ascii?Q?j/3p0rqlp0CZf1o+iouw2GnsPUAbOlq7lWGHio/vtBDD7o3DOoOhDbGBIEMS?=
 =?us-ascii?Q?Qi2/59JwcV9hCNp9Wjr/dWdh4Ahk1rijdxz1yndRJhKcziy115w7/EOhRROt?=
 =?us-ascii?Q?gjcbeLx0InLwyg8TUl4Uc8mN1LaRQYf6ZPKY0BkBICuV6RuDi5DbWWRQTMkT?=
 =?us-ascii?Q?FyFXmtPbasyQLB5Gi7TfFqR3mpk8sUKuhD7H7re1hDixaGDme4wmGaKaTY9R?=
 =?us-ascii?Q?x5Bp8oveTBE953ZAKsKR7glIi/g1AgbHKUps7Cm2XyoQ6fQ1VXRZotETDtAG?=
 =?us-ascii?Q?XXYaDWb2IUTQL31L9Ieypnr+APEhgosYjruuYa9v0LwSm5sSsxvzwNpxehq7?=
 =?us-ascii?Q?9DeB48w/RPSFFHF5rFYJm2tQQtbGC97mL8BZ399uZZqrrieWiM452hpqefc0?=
 =?us-ascii?Q?I03yaohbYwp3lYnVmASWI1uFCa5yt5WzobYu5pIcCleILwHdXM+SCyMcDMeZ?=
 =?us-ascii?Q?q41905ZabU2SON/so0jEQ7tL+6fDSWCgsY69aUCPRCgyxl7Z2UHTesFB14qz?=
 =?us-ascii?Q?iciKIeLjia0L44MRZDEH49Q5HPv71gbshTsIQjukxnPLvZcpBAsPbgwKgIPn?=
 =?us-ascii?Q?LY3ue8kQeAyNnkPRmnw4dNCSdsWUUTMxxtqK+TG1igfIHXni1Bn6doC3rMeV?=
 =?us-ascii?Q?N5tWGLOSDB+4T6bp15SgKx5HVS5KXT+liZ3vdjK6I9X0wYizT9xOVCqeBP+S?=
 =?us-ascii?Q?Y9l2T5VcSn4gQ17TqLawDmUr72OxAl/SR3cmM2xI+AV40h6/Lq5bHyh4kfbK?=
 =?us-ascii?Q?NpFXT5qWwWeyx/8AiK5kchPISkkoiwt7rWkBOoKzRjzMdeIB0lP6jGBI3pvR?=
 =?us-ascii?Q?Gb8DZ8wa3/Bg+dISeMQ=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 10:42:46.3192
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa202a7b-f570-4bc1-f930-08de0ca0beaa
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR19MB7943
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDA4MCBTYWx0ZWRfX4xzAMnNPejgS
 k1LtmQChU0QmZFGXGyfHYBzpcA3GN41WVvLKlYFL5TVnWuLJ905WcD3VMsLalONI5Mrs06UBgJI
 BKtdR28c7BaWYleHMa12Vn1dIf6BiGXT3YVhmWYRSBU/O9/JP2JW6lNIXYnIGuTksCTVesx/ehy
 D2LDCAuvCVKLHyW4C9JhUZbl80hgqRT7viG0W5LeoejQN4eufMCTvlbD4hTW4D+yI/4pp244kK0
 S2XuT1fcNjMIORjadPzY5Hd2OfwMgUZznotuFgw9FyA4fHj1aHRmcSM8sdbMCEcExR5CpOaGAH7
 NdAVDm2IrApOVId9OC52o2OgJVPCJVjKfLFCUNQIgm9xWVqPAEL7o0dzlQqDpI5TY4ssszvVqUj
 Bdjk53r3BxbOqIhhuqDGbuCLMWCClA==
X-Proofpoint-ORIG-GUID: LUUApHcDhFMx-cbLy1ldcA9d5UY27VhV
X-Authority-Analysis: v=2.4 cv=OJIqHCaB c=1 sm=1 tr=0 ts=68f0cc2d cx=c_pps
 a=9413hkbT0mE/MGYjVs5kYg==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=FQZJoZY4ZGadDpnfufEA:9
X-Proofpoint-GUID: LUUApHcDhFMx-cbLy1ldcA9d5UY27VhV
X-Proofpoint-Spam-Reason: safe

Add cs_amp_set_efi_calibration_data() to write an amp calibration
blob to EFI calibration variable.

The EFI variable will be updated or created as necessary.

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
  pre-allocated the EFI variable as zero-filled

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 include/sound/cs-amp-lib.h    |   2 +
 sound/soc/codecs/cs-amp-lib.c | 190 +++++++++++++++++++++++++++++++++-
 2 files changed, 188 insertions(+), 4 deletions(-)

diff --git a/include/sound/cs-amp-lib.h b/include/sound/cs-amp-lib.h
index 09c54b1bbe6c..4c8b84ee087e 100644
--- a/include/sound/cs-amp-lib.h
+++ b/include/sound/cs-amp-lib.h
@@ -55,6 +55,8 @@ int cs_amp_write_ambient_temp(struct cs_dsp *dsp,
 			      u32 temp);
 int cs_amp_get_efi_calibration_data(struct device *dev, u64 target_uid, int amp_index,
 				    struct cirrus_amp_cal_data *out_data);
+int cs_amp_set_efi_calibration_data(struct device *dev, int amp_index, int num_amps,
+				    const struct cirrus_amp_cal_data *in_data);
 int cs_amp_get_vendor_spkid(struct device *dev);
 
 static inline u64 cs_amp_cal_target_u64(const struct cirrus_amp_cal_data *data)
diff --git a/sound/soc/codecs/cs-amp-lib.c b/sound/soc/codecs/cs-amp-lib.c
index 2630ea6a8f3a..3f352ecad3e0 100644
--- a/sound/soc/codecs/cs-amp-lib.c
+++ b/sound/soc/codecs/cs-amp-lib.c
@@ -12,6 +12,7 @@
 #include <linux/firmware/cirrus/cs_dsp.h>
 #include <linux/math64.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/overflow.h>
 #include <linux/slab.h>
 #include <linux/timekeeping.h>
@@ -48,9 +49,16 @@ static const struct cs_amp_lib_cal_efivar {
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
@@ -262,6 +270,20 @@ static efi_status_t cs_amp_get_efi_variable(efi_char16_t *name,
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
@@ -271,6 +293,7 @@ static int cs_amp_convert_efi_status(efi_status_t status)
 		return -ENOENT;
 	case EFI_BUFFER_TOO_SMALL:
 		return -EFBIG;
+	case EFI_WRITE_PROTECTED:
 	case EFI_UNSUPPORTED:
 	case EFI_ACCESS_DENIED:
 	case EFI_SECURITY_VIOLATION:
@@ -280,7 +303,10 @@ static int cs_amp_convert_efi_status(efi_status_t status)
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
@@ -292,7 +318,7 @@ static struct cirrus_amp_efi_data *cs_amp_get_cal_efi_buffer(struct device *dev)
 	for (i = 0; i < ARRAY_SIZE(cs_amp_lib_cal_efivars); i++) {
 		status = cs_amp_get_efi_variable(cs_amp_lib_cal_efivars[i].name,
 						 cs_amp_lib_cal_efivars[i].guid,
-						 NULL, &data_size, NULL);
+						 attr, &data_size, NULL);
 		if (status == EFI_BUFFER_TOO_SMALL)
 			break;
 	}
@@ -300,6 +326,12 @@ static struct cirrus_amp_efi_data *cs_amp_get_cal_efi_buffer(struct device *dev)
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
@@ -312,7 +344,7 @@ static struct cirrus_amp_efi_data *cs_amp_get_cal_efi_buffer(struct device *dev)
 
 	status = cs_amp_get_efi_variable(cs_amp_lib_cal_efivars[i].name,
 					 cs_amp_lib_cal_efivars[i].guid,
-					 NULL, &data_size, data);
+					 attr, &data_size, data);
 	if (status != EFI_SUCCESS) {
 		ret = -EINVAL;
 		goto err;
@@ -328,6 +360,10 @@ static struct cirrus_amp_efi_data *cs_amp_get_cal_efi_buffer(struct device *dev)
 		goto err;
 	}
 
+	/* This could be zero-filled space pre-allocated by the BIOS */
+	if (efi_data->size == 0)
+		efi_data->size = data_size;
+
 	return efi_data;
 
 err:
@@ -337,6 +373,20 @@ static struct cirrus_amp_efi_data *cs_amp_get_cal_efi_buffer(struct device *dev)
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
@@ -344,7 +394,7 @@ static int _cs_amp_get_efi_calibration_data(struct device *dev, u64 target_uid,
 	struct cirrus_amp_cal_data *cal = NULL;
 	int i, ret;
 
-	efi_data = cs_amp_get_cal_efi_buffer(dev);
+	efi_data = cs_amp_get_cal_efi_buffer(dev, NULL, NULL, NULL);
 	if (IS_ERR(efi_data))
 		return PTR_ERR(efi_data);
 
@@ -396,6 +446,98 @@ static int _cs_amp_get_efi_calibration_data(struct device *dev, u64 target_uid,
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
@@ -442,6 +584,46 @@ int cs_amp_get_efi_calibration_data(struct device *dev, u64 target_uid, int amp_
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


