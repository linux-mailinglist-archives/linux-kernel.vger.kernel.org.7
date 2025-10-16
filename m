Return-Path: <linux-kernel+bounces-856018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 033DABE2E25
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 12:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CB514246EA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 10:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8AB319879;
	Thu, 16 Oct 2025 10:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="g6cU36o1";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="xKW7YxAp"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724E9328613;
	Thu, 16 Oct 2025 10:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760611377; cv=fail; b=V2/lKDkFXiZ59NbFKs7+ZPrNLUCNI2+gcPjVLs5zqNOoEjofYXZ92yQu/kp59+WXSQSh1BvcQ9LxHPPzlhU5omOD2n7/H3Cyjgd1l//fGaq2D/5YaLa2b3c8Gemg7W2g3DDDpSsTzlmHfjZMYyrrsSNpdhtqU/75eOnwmMKPNt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760611377; c=relaxed/simple;
	bh=h+yuoSLb/4Npj6Ip0+ySsiDdjRsYailZPVotrd8JeKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hTuL4o7AHMcV8k2XuRJXO28x5D78WPzj6LJZmhb0850R3xWmRfCSkoOcrVbYLf53t+vuFEk43PBsmS42UrsP3Mgkybqcscj4PoufipXvwtcsPDOJND7/QKjmFLuAsEoR9tnDqNK9r3hW4Urg5Z1zq759tJ3Hui1Vl/qXJlJzk0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=g6cU36o1; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=xKW7YxAp; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59FMZLZr298642;
	Thu, 16 Oct 2025 05:42:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=Xnbntad9ZR0FIrRG75/FBjqDE1iTZuCeewzJLjhw4qw=; b=
	g6cU36o1U6Kp/BYarXyoPWwG+ubIc9LOIzopa22W2sxLjYQ+Uw2PG9V5Bh3xZmF4
	c70Muryl7YW4zfjFxXlPysrEWM68eT6AHYSdWY5chIb5q+99+CXlMLl9Bav4nXPs
	/nZTORC9uwm8GuwfyRc1wrMydwUfLRTPTewuNwvuiyE5jrqe90nI0cgY1PclT13M
	jPWy5pfez0XoDhqi8CdNUhnGHD4OQKw2V9oeAsmDdPHhBQ4gGXTq8Y2o6NpWy9jb
	4ImUgtsmeZeBC92yJyHlughbKcqYP7y1fUXW0N+B0HmxnB8dxlbJvK05sX8DB0cC
	xMl9/nuLrunhErG8WKg2cg==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11021141.outbound.protection.outlook.com [52.101.62.141])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 49t9mhhpx2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 05:42:51 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IG0wRw5Nx0eoUbDV1PvEOtkghiPw2Qtal3TdNJAif8kIv3jD2N1dE9ihCYGh3A/EqMBc8/653eQRgC3OFvGVJUOIv2D1IWRPnJGV57hKYFcRIQ1DfiwzUOoscPP2iqy7osZQkuxyd+qbOCaxYEgl/yEhi0x2jNYqLceiZfSlu8CFEw+YCK46Ge3T4JIgC/InU+JjaRmipvFcnDokAxrFyL4hgBukR8FuSZsd3PVbhDNgiKJR0cqVK6H+5/iJJ09KEa53FKBs1vGWGeWjrJp1dp1Bh0ZJ6hnkVMa0624vzfi6YRAyQpPY0CzG/aHWJgDVClLH/iKPLJ9E2QtqUWGHpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xnbntad9ZR0FIrRG75/FBjqDE1iTZuCeewzJLjhw4qw=;
 b=ve0l3dOWa8oHXvQzaZWXdBqpDJshG+l8j+947s2d4k606e37dPoKXQkoWz3L/Ik/74bPTZ9U+e9i2KdK//7tR+EYm5y15Q3T0we0I6AsYbbKah9+CSCdSzAEnO5CRKY2pskisXcwt/v87M5IZ24sD8cXcF6lhozF1J99EEnHqj1EhLrEZd3KLb32HdG0AGBp+7MmAPOYDPJ0TMpxqABdLeAtwanQoNJNDZOO/Ku6d1Ef/zam2VsZdTvySb8rW38XjrENsumfFULb5ayXAZ29AQrRV9GnxbTo3XqLTi0U5xRz/hvSQjf/qkBAW9Ndsjl5eZVK/i7W1rnrVxPeMoEDCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xnbntad9ZR0FIrRG75/FBjqDE1iTZuCeewzJLjhw4qw=;
 b=xKW7YxApJnW6xLiYT5sussYDgj6JLCPVRyyKKa6+pPuerR3mJlB8CxWm/SeOj/uYX5ZW7vWRvfbLhnkc92SfE8KJdTCmDy66pXOlf4VYKvQ71s2i/sif3/2gQ3Fzb4WtzC2RsjZr9Wy6o8jQ1mlf4XvRtkGnWyuT37+BC8NoZ40=
Received: from MW4PR03CA0340.namprd03.prod.outlook.com (2603:10b6:303:dc::15)
 by SA3PR19MB7301.namprd19.prod.outlook.com (2603:10b6:806:316::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 10:42:45 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:303:dc:cafe::7a) by MW4PR03CA0340.outlook.office365.com
 (2603:10b6:303:dc::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.11 via Frontend Transport; Thu,
 16 Oct 2025 10:42:45 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Thu, 16 Oct 2025 10:42:44 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id CD309406552;
	Thu, 16 Oct 2025 10:42:42 +0000 (UTC)
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id AD397822541;
	Thu, 16 Oct 2025 10:42:42 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: broonie@kernel.org, tiwai@suse.com
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: [PATCH 02/11] ASoC: cs-amp-lib: Add helpers for factory calibration
Date: Thu, 16 Oct 2025 11:42:33 +0100
Message-ID: <20251016104242.157325-3-rf@opensource.cirrus.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|SA3PR19MB7301:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7e37ebc7-7a49-483c-c69f-08de0ca0bd5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?azAXU72VZXx6fNIQe1gp1BSE+FYvaUJOXm3L79YmVMbRGRAAaagGrNhnInoQ?=
 =?us-ascii?Q?dcX0wt0StJW2z7KXoUUXbwiIYCioFVbx/9FFFzXBzgZ8peFyf80LTWiPFGsd?=
 =?us-ascii?Q?MMVggzNAGQrKIEOBraD1NYRK5PXFkaAZernS3E9z6zurTwpnvBXRGNSpzboj?=
 =?us-ascii?Q?akSR4HRa7+HvoRGM4RR1hmQIZDXpgqqq+VYTZaJcu3ew5KB/mSlP3B/vlyxM?=
 =?us-ascii?Q?Q5Or42ZlelNDY4zmaf1m6AsiC282yrCBiYgLR1Ful2PRSobDY5EFpnhONVhg?=
 =?us-ascii?Q?BTwL+FBTuj2pJaK068SxQ7IR/7h//Q1xPZ/tKzbpDGUEUUJP841wJXzkAZaH?=
 =?us-ascii?Q?y2NlGaaM7Y1F9gMUztQCbZF3dVcsFGQqtQN7Xo/yPJgYX2pce2hqzNKcBIQl?=
 =?us-ascii?Q?7bz27VWTOpeuR0ivSoCbo/UYCvMT2yZHbafTQqhmrhk1bcglWLpGOzKHyEmL?=
 =?us-ascii?Q?WTUlFRKD+FJEPAklcEBolEVP62zXKQQ06EVXXstZcnCf8YdOfu3tUu2GvxMe?=
 =?us-ascii?Q?Q4qUUhNRyYQVyEieaHscK9W7cLFSbk8iVqR5hVMl5J1O6oJNxu1M85iDUvhh?=
 =?us-ascii?Q?ThsvDYG//Vx5KUKUSx6JXBtb7HCyHp7AuoeOJt3TsALL73iMK1l/Bn8CC288?=
 =?us-ascii?Q?al4gtV0/dKaWz6b5qdNOzl5yUPxQdwxMggNd8cYZtjoPQLRKaESSBU246/cp?=
 =?us-ascii?Q?syU+V4Fq7fcGIrdDGwTQHZyDyxAVjg6n10FRPtvd7KmhaLd+8j2LzG3Ne3LS?=
 =?us-ascii?Q?8HZeVRTmurGhXMfkZW/oIosIB74kz6JLRaJVvgpsRXM1i6yAqqPdY4O4/HwR?=
 =?us-ascii?Q?aKwIM+u7Yk81jajkktU57j4o1pzuyanNmQrDJqWeALy2+F9+t6Ib8DJEw9NB?=
 =?us-ascii?Q?bQ9afn8vMDZymM8LUrVIpr4VHTif+FAXuro3KVknDuSoamgl68RZsjRzUQre?=
 =?us-ascii?Q?d1+3mk8kK2TfJba8LDnHBRwJEHnzjdcNL7kqjB8tq5CXTlavIlABYExrIUh3?=
 =?us-ascii?Q?0S2ErpHrKtJnWG4GXlEWPfnmHzbYhyp9PIX/diEgcGp0FMyg5yWztzOIgudo?=
 =?us-ascii?Q?wrCXdXsezj8XD0B/8u7amZ8G/+gPskERbK3zCDpbYyOp6xHhWm/kuVlj49XC?=
 =?us-ascii?Q?BYSOiWqrQsaZm2pqolIOfnPqtQgYwaooj/cKsU4kmy++IZmFb9aPRHenNKkM?=
 =?us-ascii?Q?AzqgnaoDikDTi1B7kLvUTaGn3Lw6pCjqn1SlzuECDHlVJq7gchAXJr7tzRpw?=
 =?us-ascii?Q?KFKMFwEKjvZcAvX4xPQ77khaazBc0oabjOyvqcc0/1E6AS8PnJgEoS3mPNnB?=
 =?us-ascii?Q?cJ3ujMKrlBAKYxJvrA1crsdN89LAho/0WOb+0nI+AEcDf5BLb34I8qZ7+5IO?=
 =?us-ascii?Q?btUSJVfJsUM7DHGFYbRQALdy2J1h16PpxXkRwlDoD4k0zWCpDv5ayclWzb8v?=
 =?us-ascii?Q?XEnXKBLMk4ksF3hYJpLczuEaBGYFCA7I1ENtU51RbBanDGSdZxEk2D5dGVqd?=
 =?us-ascii?Q?YdLnhSMdNDzxWttGwgxdtyYMol62BvmryupM/0GhQhFuNjo0DK5bXSXxOM78?=
 =?us-ascii?Q?i6BEM2M3LgfzjUoosCo=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 10:42:44.1159
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e37ebc7-7a49-483c-c69f-08de0ca0bd5b
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR19MB7301
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDA4MCBTYWx0ZWRfX9YEJBUW7nMvt
 LATYsp+2ME1V0iE/r2gyuIydUvHQarj13uqT+UYGC03R/myGWrZ9EktYEN/JHYuZs+l4tAhWLjz
 BnO+uxZoApHN5b87GZ1E20dskwXUkK2wpwL0seTAMrZpYyZL3TLHDugSczweOZoQ3kFDUqHLu5V
 d0zl7btt6x+uN/G88Qo8kIlNhE+cJxhKwZit5QSbZ8oBTqPDwJWIoAU4nvrRIuJDAvvwuNL12+j
 QfNO1fhL49NLHra8qwHNXRuXv8k/gET0z7MeiXPKPbVmLCFejuq8S8R5u2EZs5vL/vpWWw23fW6
 ja3Q/rocfJK+F2h2YO/2gNQfhSYh2oR4akugkqRuovsVne9rdCHkJ7HecdPxkq5ELTCeY/SpUbc
 INzRZdT9qdSYno3D5H4RMuECgqTikA==
X-Proofpoint-ORIG-GUID: Kdt0-2KI4k6C9RlIy_AoF34nFK-S-kO4
X-Authority-Analysis: v=2.4 cv=OJIqHCaB c=1 sm=1 tr=0 ts=68f0cc2b cx=c_pps
 a=YwNxXrBOkeX2Yvw65jHa0Q==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=_YETvGvGxytoiswIzucA:9
X-Proofpoint-GUID: Kdt0-2KI4k6C9RlIy_AoF34nFK-S-kO4
X-Proofpoint-Spam-Reason: safe

Add two helper functions for performing factory calibration.

cs_amp_read_cal_coeffs() reads the results of a calibration into a
struct cirrus_amp_cal_data. The calTime member is also filled in with
the current time (which is defined to be in Windows format).

cs_amp_write_ambient_temp() writes a given temperature value to the
firmware control for ambient temperature.

The cs_amp_cal_target_u64() has been moved into the header file so
that it can be used by the calling code and by KUnit tests.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 include/sound/cs-amp-lib.h    |  11 +++
 sound/soc/codecs/cs-amp-lib.c | 122 ++++++++++++++++++++++++++++++++--
 2 files changed, 128 insertions(+), 5 deletions(-)

diff --git a/include/sound/cs-amp-lib.h b/include/sound/cs-amp-lib.h
index 43a87a39110c..e4df0736039a 100644
--- a/include/sound/cs-amp-lib.h
+++ b/include/sound/cs-amp-lib.h
@@ -47,10 +47,21 @@ struct cirrus_amp_cal_controls {
 int cs_amp_write_cal_coeffs(struct cs_dsp *dsp,
 			    const struct cirrus_amp_cal_controls *controls,
 			    const struct cirrus_amp_cal_data *data);
+int cs_amp_read_cal_coeffs(struct cs_dsp *dsp,
+			   const struct cirrus_amp_cal_controls *controls,
+			   struct cirrus_amp_cal_data *data);
+int cs_amp_write_ambient_temp(struct cs_dsp *dsp,
+			      const struct cirrus_amp_cal_controls *controls,
+			      u32 temp);
 int cs_amp_get_efi_calibration_data(struct device *dev, u64 target_uid, int amp_index,
 				    struct cirrus_amp_cal_data *out_data);
 int cs_amp_get_vendor_spkid(struct device *dev);
 
+static inline u64 cs_amp_cal_target_u64(const struct cirrus_amp_cal_data *data)
+{
+	return ((u64)data->calTarget[1] << 32) | data->calTarget[0];
+}
+
 struct cs_amp_test_hooks {
 	efi_status_t (*get_efi_variable)(efi_char16_t *name,
 					 efi_guid_t *guid,
diff --git a/sound/soc/codecs/cs-amp-lib.c b/sound/soc/codecs/cs-amp-lib.c
index 8434d5196107..b2509c5c0690 100644
--- a/sound/soc/codecs/cs-amp-lib.c
+++ b/sound/soc/codecs/cs-amp-lib.c
@@ -10,9 +10,11 @@
 #include <linux/dev_printk.h>
 #include <linux/efi.h>
 #include <linux/firmware/cirrus/cs_dsp.h>
+#include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/overflow.h>
 #include <linux/slab.h>
+#include <linux/timekeeping.h>
 #include <linux/types.h>
 #include <sound/cs-amp-lib.h>
 
@@ -46,6 +48,16 @@ static const struct cs_amp_lib_cal_efivar {
 	},
 };
 
+/* Offset from Unix time to Windows time (100ns since 1 Jan 1601) */
+#define UNIX_TIME_TO_WINDOWS_TIME_OFFSET	116444736000000000ULL
+
+static u64 cs_amp_time_now_in_windows_time(void)
+{
+	u64 time_in_100ns = div_u64(ktime_get_real_ns(), 100);
+
+	return time_in_100ns + UNIX_TIME_TO_WINDOWS_TIME_OFFSET;
+}
+
 static int cs_amp_write_cal_coeff(struct cs_dsp *dsp,
 				  const struct cirrus_amp_cal_controls *controls,
 				  const char *ctl_name, u32 val)
@@ -73,6 +85,34 @@ static int cs_amp_write_cal_coeff(struct cs_dsp *dsp,
 	return -ENODEV;
 }
 
+static int cs_amp_read_cal_coeff(struct cs_dsp *dsp,
+				 const struct cirrus_amp_cal_controls *controls,
+				 const char *ctl_name, u32 *val)
+{
+	struct cs_dsp_coeff_ctl *cs_ctl;
+	__be32 beval;
+	int ret;
+
+	KUNIT_STATIC_STUB_REDIRECT(cs_amp_read_cal_coeff, dsp, controls, ctl_name, val);
+
+	if (!IS_REACHABLE(CONFIG_FW_CS_DSP))
+		return -ENODEV;
+
+	scoped_guard(mutex, &dsp->pwr_lock) {
+		cs_ctl = cs_dsp_get_ctl(dsp, ctl_name, controls->mem_region, controls->alg_id);
+		ret = cs_dsp_coeff_read_ctrl(cs_ctl, 0, &beval, sizeof(beval));
+	}
+
+	if (ret < 0) {
+		dev_err(dsp->dev, "Failed to write to '%s': %d\n", ctl_name, ret);
+		return ret;
+	}
+
+	*val = be32_to_cpu(beval);
+
+	return 0;
+}
+
 static int _cs_amp_write_cal_coeffs(struct cs_dsp *dsp,
 				    const struct cirrus_amp_cal_controls *controls,
 				    const struct cirrus_amp_cal_data *data)
@@ -106,6 +146,45 @@ static int _cs_amp_write_cal_coeffs(struct cs_dsp *dsp,
 	return 0;
 }
 
+static int _cs_amp_read_cal_coeffs(struct cs_dsp *dsp,
+				    const struct cirrus_amp_cal_controls *controls,
+				    struct cirrus_amp_cal_data *data)
+{
+	u64 time;
+	u32 val;
+	int ret;
+
+	if (list_empty(&dsp->ctl_list)) {
+		dev_info(dsp->dev, "Calibration disabled due to missing firmware controls\n");
+		return -ENOENT;
+	}
+
+	ret = cs_amp_read_cal_coeff(dsp, controls, controls->ambient, &val);
+	if (ret)
+		return ret;
+
+	data->calAmbient = (s8)val;
+
+	ret = cs_amp_read_cal_coeff(dsp, controls, controls->calr, &val);
+	if (ret)
+		return ret;
+
+	data->calR = (u16)val;
+
+	ret = cs_amp_read_cal_coeff(dsp, controls, controls->status, &val);
+	if (ret)
+		return ret;
+
+	data->calStatus = (u8)val;
+
+	/* Fill in timestamp */
+	time = cs_amp_time_now_in_windows_time();
+	data->calTime[0] = (u32)time;
+	data->calTime[1] = (u32)(time >> 32);
+
+	return 0;
+}
+
 /**
  * cs_amp_write_cal_coeffs - Write calibration data to firmware controls.
  * @dsp:	Pointer to struct cs_dsp.
@@ -125,6 +204,44 @@ int cs_amp_write_cal_coeffs(struct cs_dsp *dsp,
 }
 EXPORT_SYMBOL_NS_GPL(cs_amp_write_cal_coeffs, "SND_SOC_CS_AMP_LIB");
 
+/**
+ * cs_amp_read_cal_coeffs - Read calibration data from firmware controls.
+ * @dsp:	Pointer to struct cs_dsp.
+ * @controls:	Pointer to definition of firmware controls to be read.
+ * @data:	Pointer to calibration data where results will be written.
+ *
+ * Returns: 0 on success, else negative error value.
+ */
+int cs_amp_read_cal_coeffs(struct cs_dsp *dsp,
+			   const struct cirrus_amp_cal_controls *controls,
+			   struct cirrus_amp_cal_data *data)
+{
+	if (IS_REACHABLE(CONFIG_FW_CS_DSP) || IS_ENABLED(CONFIG_SND_SOC_CS_AMP_LIB_TEST))
+		return _cs_amp_read_cal_coeffs(dsp, controls, data);
+	else
+		return -ENODEV;
+}
+EXPORT_SYMBOL_NS_GPL(cs_amp_read_cal_coeffs, "SND_SOC_CS_AMP_LIB");
+
+/**
+ * cs_amp_write_ambient_temp - write value to calibration ambient temperature
+ * @dsp:	Pointer to struct cs_dsp.
+ * @controls:	Pointer to definition of firmware controls to be read.
+ * @temp:	Temperature in degrees celcius.
+ *
+ * Returns: 0 on success, else negative error value.
+ */
+int cs_amp_write_ambient_temp(struct cs_dsp *dsp,
+			      const struct cirrus_amp_cal_controls *controls,
+			      u32 temp)
+{
+	if (IS_REACHABLE(CONFIG_FW_CS_DSP) || IS_ENABLED(CONFIG_SND_SOC_CS_AMP_LIB_TEST))
+		return cs_amp_write_cal_coeff(dsp, controls, controls->ambient, temp);
+	else
+		return -ENODEV;
+}
+EXPORT_SYMBOL_NS_GPL(cs_amp_write_ambient_temp, "SND_SOC_CS_AMP_LIB");
+
 static efi_status_t cs_amp_get_efi_variable(efi_char16_t *name,
 					    efi_guid_t *guid,
 					    unsigned long *size,
@@ -215,11 +332,6 @@ static struct cirrus_amp_efi_data *cs_amp_get_cal_efi_buffer(struct device *dev)
 	return ERR_PTR(ret);
 }
 
-static u64 cs_amp_cal_target_u64(const struct cirrus_amp_cal_data *data)
-{
-	return ((u64)data->calTarget[1] << 32) | data->calTarget[0];
-}
-
 static int _cs_amp_get_efi_calibration_data(struct device *dev, u64 target_uid, int amp_index,
 					    struct cirrus_amp_cal_data *out_data)
 {
-- 
2.47.3


