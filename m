Return-Path: <linux-kernel+bounces-808003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 187B8B4AC08
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF62B7ABB3B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E76322524;
	Tue,  9 Sep 2025 11:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="hoJn6sIU";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="DWY8YXge"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE42424E4B4;
	Tue,  9 Sep 2025 11:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757417451; cv=fail; b=JBDmr9JzHmou8gqPtARLM57fhh0cerzALEFzhkfX2Sc7dGyt8utzcFynJK4EnruRVvcFa15QroNtctjIMImRj+95lDrTyQaTKYQw8bmhMwnIElal3xsvpaYLA2kVyZqbdxEhh7GMj3q9T77ynCeCtWNvjJGZ5uxnjdawxl7+4sA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757417451; c=relaxed/simple;
	bh=UX2a9626cbBsUaao3klneHiVeMOb1jq7djsonZqHt0k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DP5hRuAoK/IeS0RQ9i9rcKRvv2DCJ6u4IAE0rM7a3XNTBe2LxT8YbaTdi+hBHGUxihF/E42zS6s+wn1nX+qDNIfKOFbIMXXCG90Jqdq3KDi8cTd6Qqpv5KA1xEZ3uBWPWOU49HrHby0Gyb0/8AP6IIIb1kQt7+hHv0nG1B5sGmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=hoJn6sIU; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=DWY8YXge; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 588KSv8x1252531;
	Tue, 9 Sep 2025 06:30:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=p9kWuGXgOe4/EMRnrtltyKIXbwz9XbTjY/k/R5C8HvE=; b=
	hoJn6sIUMep4lfzo7gqLS+7oSEeMYcpZ6Kr/bHUy8N7gSdRCL8BAxP6WVFkA8lmI
	ldadcfKixDeJ4PCZ4oL4Xc/pZn7ieU/Et8RRtav0WoF9F/eET6ttrodDLw3BRmNk
	CoODBjlLt4eQxOEYMReFCfXPFk0xcjlXZZWqjmn5eGLk8Bj66wEYlAQcfBjkkzRs
	v1OBYe6wqvolcN5bg8xPcFFN1LCyqsbW8ScJGkF/JgdKrQhiHcjT/6/BH+XnSgf4
	0kmPsgAqGxZ3vBEGui1PoYwJ9iAZC3cVPPlG70ULEA3iOkoo87a6cG36yfTYgNs3
	/x0LNPSys28znHiwqQ/DfA==
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04on2133.outbound.protection.outlook.com [40.107.101.133])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 49227r91wp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 06:30:47 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n2Qz71yneg9S4Fo12NyWQRgnrbEn/74Fvhoyb1bjZTUSia+G5YqD4KO5a64lYzobV27tbLIYCR2cAn9yk1ZfIO7++0+ZfAoFuKhlsM/GufSeZrLYBAk+pqORfmto9DVCyJ32GMEVVgCC0H8Pql1RYlVtVDoIYc7783TeExLOMMmVrhNNbwtRjN14H+dvatW47Ea1UcgqzRl+KlKZZ/7Ft04pbyzRWWQZ/J0Vew4t+S62aOo9zTMG9ydlWRdmFbpZIOs5fksNobWJAC0+iex+5eTg+jxSC/Sqi/OXGR9mbpFyxi2C1f+uhDpUCI4+Av6juAl5i+NTtmIg6931z6O6hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p9kWuGXgOe4/EMRnrtltyKIXbwz9XbTjY/k/R5C8HvE=;
 b=W8TPj2iu1FXlw798LXmhaGouto1ezTOlzzITHDR6B6+xXzxUX7pqWu2Hmm+bZGkKJNDQv7sJhaIIaU5EB4VJIJs4sjm1h3Csf9GKp6NzuKHpvHuzErjquxiWH7lAoz18vnVKAuhWLPrmeCr2d7YEeR76uvqZKWwP2qm7LYZQe3HyMfhZ2HkLhZoCo0gbxB0Ktc7tjwBB5jZV0HK8BQl6HzzZZU1mWtVWol2ov4Clr4syuv86zOAn8h0NR2HAJs7pAAPSSQBtz692MWbeceOudNM2LOEStQCD8vHGF+buZg3QAHmgvMGvfWbyuPk/ZypyDrcxV+cPv5Jlrir3fvofUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9kWuGXgOe4/EMRnrtltyKIXbwz9XbTjY/k/R5C8HvE=;
 b=DWY8YXgebZUsCpJLpOh+uvGfowaIs+j1Xa6zuAREM109kcBrPxya7pTs8e6rV9WUazF5Mny1y9ltgKQwKkeUdmKXjWKB8VxEdhks94Zt8765egyBTk8yugjznfZ97MID/tdBne09fK6M+FI1sjDfwe1Z+OHLrwS0mCtd2NQdOyE=
Received: from BLAP220CA0017.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::22)
 by MN2PR19MB3887.namprd19.prod.outlook.com (2603:10b6:208:1ee::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 11:30:44 +0000
Received: from BL02EPF0002992B.namprd02.prod.outlook.com
 (2603:10b6:208:32c:cafe::45) by BLAP220CA0017.outlook.office365.com
 (2603:10b6:208:32c::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Tue,
 9 Sep 2025 11:30:44 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BL02EPF0002992B.mail.protection.outlook.com (10.167.249.56) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.13
 via Frontend Transport; Tue, 9 Sep 2025 11:30:44 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 52EDA406558;
	Tue,  9 Sep 2025 11:30:40 +0000 (UTC)
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 4326982026B;
	Tue,  9 Sep 2025 11:30:40 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: broonie@kernel.org
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: [PATCH v2 6/6] ASoC: cs-amp-lib-test: Add test for getting cal data from HP EFI
Date: Tue,  9 Sep 2025 12:30:39 +0100
Message-Id: <20250909113039.922065-7-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250909113039.922065-1-rf@opensource.cirrus.com>
References: <20250909113039.922065-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992B:EE_|MN2PR19MB3887:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d98fa935-f938-427d-6c04-08ddef945091
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|61400799027|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fL4gp5hcJU0lLDYtc3ZPfi/X0KeNkqhIgEdnFEVLCYv3T4XScar2dJ45MZye?=
 =?us-ascii?Q?l1s7R+vDA0KdFTPOjumCyr+hcckRYgxPA9QL+8DFcisNVjpMOADFq+Lldegn?=
 =?us-ascii?Q?M1DVU5/Qt5+6vqBOTZ3dZSj+Ivwc1iOtxottTAQfZSr+optUxvXgfgyYdm3P?=
 =?us-ascii?Q?VyYmY9RHDXyC2Y9d8EyUR3A9l6yT9BuGb4Q++DK8rR7Zxrtm+ud0htzhqquY?=
 =?us-ascii?Q?VqReDbUs5Q0YLI1R9Zr3Q6mGfmKApKjZBDOlXTGoUyPXHLo9JGp2UdnSl88J?=
 =?us-ascii?Q?995sS50iBPgKJLSdrgpDp1Qh+oqkiQC4XZU2maqKuigXS+KEbMV/p3HYOm7B?=
 =?us-ascii?Q?5HYZimgzJslPDSRn5CwReAmnKgInXNo0OocG56tFo4kn8GOvnyeuTg1c9WGa?=
 =?us-ascii?Q?FxwtC4g08NG5GonT6JulZoaWa+6Ztd8FlZQy4VBnZabjvL1KnFVtZQbHh1ap?=
 =?us-ascii?Q?g1bxNQWIFDFvbqV3lDIk8cp+7uSovmfUUcZj0481HRLHQ2/CGIb2NzeNtrrE?=
 =?us-ascii?Q?/EPIW8V0U7M2OEMzz3EYurAVNALA71d9ik4IInaU30Get0DNtq/Jd3mkB6eB?=
 =?us-ascii?Q?DFa9/iIZv48+rNrBN16Hzn7W4JJS0NnkkE7CuPi+1UaPk1t47+c0+F1QpC4h?=
 =?us-ascii?Q?VsXvwIr6TKoab7qJ4aXEwhyjFkAE8biiHp/H0MMhywNGnrOkEau2ds+WnW7y?=
 =?us-ascii?Q?zk62mpHitWDK7NwMh7IzdSB6SM9IkpK8sWVqnCkvbAZ3uQ91JZZ1+czM78kD?=
 =?us-ascii?Q?STRVSFIs/DobOfHL7h0PEt2fG0BZLOuQze3MLjAkoIUqztqxTeDXQe8KDAeG?=
 =?us-ascii?Q?B2i2OxDipv37aZ4fn4Fg1Yzbgk5g2WwLqVkNewzIzljRKir7LK+1Cf4JVJcu?=
 =?us-ascii?Q?qLC8gKshrlyYCEa/EHERgtZDH1GQqsPyxzQIbZEF4MtzstRu5ADWVL9v538C?=
 =?us-ascii?Q?FP2D80yqwJAeTt/MTrCbP2SSbQcCE0N++29vgPR4R8GO4U9KM/AqVgJ41hUG?=
 =?us-ascii?Q?POlsSgHFMtfq4crKJ9I0nHPpbN+xK4StOIDJVyMQilNmo6u6FVk+7yt/inIS?=
 =?us-ascii?Q?Y+61KT4JTInnc46lxbD0t2cKAIYFBNnCFTZTlmBMtPQZAAtLkcS0coeEzc9u?=
 =?us-ascii?Q?HzaVpORXGbs49g+EywZGNsKtJn699PmMcu8tDXAdbTnD0vi6lh3K/RMd1zeP?=
 =?us-ascii?Q?7Hvhg//bocrPvV/0ghiwz7tVgO+pXaQ1UBTjW3BqBMDL68nwLeIcGkf84yw1?=
 =?us-ascii?Q?gX82movnLKawvelaXVk1I8YnAhRE+kKIY4L0V7uFOYvTECYycGrVZDmfGX4d?=
 =?us-ascii?Q?IbI5BLCtsrQZAFKMXcDHM7qA1leFoTcjbn4CcO/REAqFW9MJDYSoVqN4PICE?=
 =?us-ascii?Q?IX7T81BK8X9+9nenU0WWWb415hJA/ojuQthCZI6+GJ3DnidjAy5WhT5dIYLx?=
 =?us-ascii?Q?rE9EK9+16yT2OIkrwm/RtacrZmQJ8DdecmPVruMVpnmZwNJdu22c8onQmV8K?=
 =?us-ascii?Q?li2wGcdOQ8PvWAdqB4CTHZW87ptgEcqMDDQw?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(61400799027)(82310400026)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 11:30:44.0250
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d98fa935-f938-427d-6c04-08ddef945091
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BL02EPF0002992B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR19MB3887
X-Authority-Analysis: v=2.4 cv=f+FIBPyM c=1 sm=1 tr=0 ts=68c00fe7 cx=c_pps
 a=dwieEWGYNhQf9SbSAXxshQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10 a=w1d2syhTAAAA:8
 a=erahUydJdZyVaCJA8SoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA5MDExNCBTYWx0ZWRfX+w9qDb42MFR4
 zQ31mRNp5qPMNMluLklddfjo2Z/27azXES/rZg7kqbwUX9dYTCQ4BwBt6UZroy7QoYc1T580v7N
 Jb8OSNshzKF4z+KmS4hGITzVYAffr5Y56nPXSpyUQptFHwIdTnai548xLnC+VN3QrXsDcHRBpXn
 h6aWJLEn0emgwowwnQMDj2p105Yi9dnCOPexs/JW9FH5DmCgFHbevE19X7GXJshqFX0IcvtFKdv
 i/1KnOz9xOn9vidK48sAKxt/UCiy3cGCyPmDCqKNwJb4Hn++gakDLPBaGDNeiG5DPDCU5E1GJhd
 krBeP+ilN73VBCSliLfKY8ViVTo9k+VPtJqeQGzimhxuS3qk8Fi+mx33yQIp28=
X-Proofpoint-GUID: wOLYlauBfIUQInqtCGnPe_RKN2ZxB7yx
X-Proofpoint-ORIG-GUID: wOLYlauBfIUQInqtCGnPe_RKN2ZxB7yx
X-Proofpoint-Spam-Reason: safe

Add a test case that cs_amp_get_efi_calibration_data() returns data
when it is in the HP-specific EFI variable.

This uses redirected implementation of cs_amp_get_efi_variable() that
only returns data if the passes name and GUID match the HP EFI variable.
A simple test case installs this function hook and then checks that
calibration data is returned.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
Change in v2:
Removed unused target_uid variable and code that set it in
cs_amp_lib_test_get_hp_efi_cal().

 sound/soc/codecs/cs-amp-lib-test.c | 51 ++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/sound/soc/codecs/cs-amp-lib-test.c b/sound/soc/codecs/cs-amp-lib-test.c
index c090498cbf78..2fde84309338 100644
--- a/sound/soc/codecs/cs-amp-lib-test.c
+++ b/sound/soc/codecs/cs-amp-lib-test.c
@@ -220,6 +220,56 @@ static efi_status_t cs_amp_lib_test_get_efi_variable(efi_char16_t *name,
 	return EFI_SUCCESS;
 }
 
+static efi_status_t cs_amp_lib_test_get_hp_cal_efi_variable(efi_char16_t *name,
+							    efi_guid_t *guid,
+							    unsigned long *size,
+							    void *buf)
+{
+	static const efi_char16_t expected_name[] = L"SmartAmpCalibrationData";
+	static const efi_guid_t expected_guid =
+		EFI_GUID(0x53559579, 0x8753, 0x4f5c, 0x91, 0x30, 0xe8, 0x2a, 0xcf, 0xb8, 0xd8, 0x93);
+	struct kunit *test = kunit_get_current_test();
+	struct cs_amp_lib_test_priv *priv = test->priv;
+
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, name);
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, guid);
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, size);
+
+	if (memcmp(name, expected_name, sizeof(expected_name)) ||
+	    efi_guidcmp(*guid, expected_guid))
+		return -EFI_NOT_FOUND;
+
+	if (!buf) {
+		*size = priv->cal_blob->size;
+		return EFI_BUFFER_TOO_SMALL;
+	}
+
+	KUNIT_ASSERT_GE_MSG(test, ksize(buf), priv->cal_blob->size, "Buffer to small");
+
+	memcpy(buf, priv->cal_blob, priv->cal_blob->size);
+
+	return EFI_SUCCESS;
+}
+
+/* Get cal data block from HP variable. */
+static void cs_amp_lib_test_get_hp_efi_cal(struct kunit *test)
+{
+	struct cs_amp_lib_test_priv *priv = test->priv;
+	struct cirrus_amp_cal_data result_data;
+	int ret;
+
+	cs_amp_lib_test_init_dummy_cal_blob(test, 2);
+
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->get_efi_variable,
+				   cs_amp_lib_test_get_hp_cal_efi_variable);
+
+	ret = cs_amp_get_efi_calibration_data(&priv->amp_dev->dev, 0, 0, &result_data);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	KUNIT_EXPECT_MEMEQ(test, &result_data, &priv->cal_blob->data[0], sizeof(result_data));
+}
+
 /* Get cal data block for a given amp, matched by target UID. */
 static void cs_amp_lib_test_get_efi_cal_by_uid_test(struct kunit *test)
 {
@@ -910,6 +960,7 @@ static struct kunit_case cs_amp_lib_test_cases[] = {
 	KUNIT_CASE(cs_amp_lib_test_get_efi_cal_no_uid_index_not_found_test),
 	KUNIT_CASE(cs_amp_lib_test_get_efi_cal_no_uid_no_index_test),
 	KUNIT_CASE(cs_amp_lib_test_get_efi_cal_zero_not_matched_test),
+	KUNIT_CASE(cs_amp_lib_test_get_hp_efi_cal),
 	KUNIT_CASE_PARAM(cs_amp_lib_test_get_efi_cal_by_uid_test,
 			 cs_amp_lib_test_get_cal_gen_params),
 	KUNIT_CASE_PARAM(cs_amp_lib_test_get_efi_cal_by_index_unchecked_test,
-- 
2.39.5


