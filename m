Return-Path: <linux-kernel+bounces-856023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A24CABE2F2E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 12:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92DD83E625B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 10:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70BFC327797;
	Thu, 16 Oct 2025 10:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="IBMgYr5b";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="tT8kWRXz"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C4731D376;
	Thu, 16 Oct 2025 10:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760611384; cv=fail; b=XLtjBwZnZ+HSdBrVTDDeHIjA9+SVHFuwje/+IevAz8xPDFqoMBXABG68TCmTfxZrI78ExLAN/f5WZdnxki1caGYo8xo4BfpvlX6uFNGTFE+4Vkyu+SRHIXSYWqw1AFjTbocC2zCwcIPUshmcovhDeWbXkNCdEirKib55v/KkSPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760611384; c=relaxed/simple;
	bh=iTlyfBeBKkWEIgGGChA87p9CXvrzoxRyD49JEfEP6RE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tWxfO3yR+9FIRgL+X45++nc0rlbNjVgMrNrHPMpedp+XsQR+XfT7ZqzQdkIvIQkTyfhpDBTrFGp1yJ5GTSFjQkxsEkuK9DCfzgYeHqxybAend4jRXA08v+D9/RxthoKzB85FInQmVomfkUHvN7S/I9M1epbqX9AhYd8DDhu+kLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=IBMgYr5b; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=tT8kWRXz; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59FN6m5C298627;
	Thu, 16 Oct 2025 05:42:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=ZlpCYxheRBHBsiHQt7cb5QKkPd4eQ8HeF6vgbA9IN/8=; b=
	IBMgYr5bX7kukhJfmFeQ0f1HrwKZQW6qT0DKQSz5ojLMWB5FKNlXl3HYjXtNccjn
	bOuWTQoL0kzDF1ReXtxMIPX3I33OFsBiCodAXwlaqvscWneKLKxsuftFzK8EWmwT
	qa+fu22L3T7HTkg1j1vLZv3Qh2AWZE4alhBPaKICn16wopPGyARz44Q7BUKYcp+z
	8x/rVMhlnNn4dafKVYLWByPmcQ4H5+89yLjC5tARRPodWC9/Yj/ObugIU/8Jzaj9
	dxKskyHZ5OI9iuu7u0/0xtQKVPsMDsuuazJsQJElSXpqPvECD7jA8muLT3JvY710
	DRUBb/+zN14ubN+C19l2HA==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11020128.outbound.protection.outlook.com [52.101.85.128])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 49t9mhhpx3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 05:42:51 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lHq6Z3Y8hRNMuy4c8KDUJijf0bZ51w3q+LIcfq8wcl9bIaP/g8IvRaPGexX858WiLBnnsHnZggqubN6UKfpdLCvIAF4lUddUH+0g9DXsGES/E95tGgWQZTkhs0VEmufbwHfIBYXr1OrhnLwjyR8l04bRfVOShhZCOPQpR9Y14nF1K+FGzzk67+5Ivs7GN0RSgkAAd7+QrJsQi49lI+JScoR2kbMYI2hI6f0goLpNPG7MGazLsnHYVl/0hi9cQI4zVvR4h2+XwXh1cv4K+S7H5sbaXKu45x97OL5s5L/hg+WDitcFo2iWU9z38YbRGxQbiiKckL0fP/kz5g8sZPdg8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZlpCYxheRBHBsiHQt7cb5QKkPd4eQ8HeF6vgbA9IN/8=;
 b=XnQ3lsPqNs88VDwH/SV7Sy2Q3zZCQhY8bMfeKE9PFiVqqYdaGxliQNk8I487PskrSvPDhKy8fNahvkcSQMbQpxIroUxzFYCX554NsPn/qyq1m5Xa5EcsaFNOqjcjSIO4aCzi2Oo92jz+umMFGhsPy0a1WVhWi6jUv7v87+rfEb3vO68VwM1chYsORvhpc9mHwiDEdwb1JCJTTM4OGlt1GkUnzZhPI2wVsAstl8IYdFR1r7vhq2dfoLy8QtnQy7GLoUaR2lP4ex9xtklkPEx8cMbeksgZVgMyZJuhVbmNVByn2IKMdGl1+gDnb7UGvsYKoPYe4waa+/kINws7LfMIvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZlpCYxheRBHBsiHQt7cb5QKkPd4eQ8HeF6vgbA9IN/8=;
 b=tT8kWRXzjAR3FzKynITa/NmlecwsmBpUnVQji+8RxhDfucHn+mTBXUx9ElEkGXPB5PBwkt4dTHnN4I9M+Uho2qxtsElJRP5OFHyfWZSeURQIKj5MV6xc95mtwnV+uNLm7bjKGFe/rE1n2tb2eYpFfK01tvA4gohtIb3NE1riAbQ=
Received: from MW4PR03CA0078.namprd03.prod.outlook.com (2603:10b6:303:b6::23)
 by SN7PR19MB7041.namprd19.prod.outlook.com (2603:10b6:806:2a8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Thu, 16 Oct
 2025 10:42:49 +0000
Received: from MWH0EPF000971E4.namprd02.prod.outlook.com
 (2603:10b6:303:b6:cafe::52) by MW4PR03CA0078.outlook.office365.com
 (2603:10b6:303:b6::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.12 via Frontend Transport; Thu,
 16 Oct 2025 10:42:48 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 MWH0EPF000971E4.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Thu, 16 Oct 2025 10:42:46 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 1F6A4406579;
	Thu, 16 Oct 2025 10:42:43 +0000 (UTC)
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 0A05D822540;
	Thu, 16 Oct 2025 10:42:43 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: broonie@kernel.org, tiwai@suse.com
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: [PATCH 11/11] ASoC: cs-amp-lib-test: Add test cases for cs_amp_set_efi_calibration_data()
Date: Thu, 16 Oct 2025 11:42:42 +0100
Message-ID: <20251016104242.157325-12-rf@opensource.cirrus.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E4:EE_|SN7PR19MB7041:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: af00d366-4937-461f-c63f-08de0ca0bf06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|61400799027;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1wTnSh+qt+kF0ManJlj+FhMTLahuG/bFT4DSfxug5gyA8GQTC/dFX9TkdJir?=
 =?us-ascii?Q?TK5lU8ncluniqH4brPsZNMew9v5gI1pua8nuaVhLBTYv+41AhCKEjS5VXIxc?=
 =?us-ascii?Q?pD+iGz9ExKl2P0oMlnFDagtmjOIEk4QQRBikxDiEDMWEO1Dm4B90/9u1si4X?=
 =?us-ascii?Q?J1mUkl4clkg82zsLK8HU/6tpQB6JcrhNzSo7o813sW2eyQSTfcco48x08Z8p?=
 =?us-ascii?Q?iToih2pvIU1MzF/4rT1bXfBEFhNHba2Pn7kbShbF3+7FKg4Xz+HSbKZCCRbK?=
 =?us-ascii?Q?zQM0VZor9snm2jAOXsC2kA+85dwiUCrLoUZ9+UwUam43x11VNZzpOP+hK38Q?=
 =?us-ascii?Q?5u4IwUL8JOMMBXeXComXKyahUJS1XHLKBQRNqW8EoAJvQ23Spchrh6a8fK/c?=
 =?us-ascii?Q?M6j56RxLgZ5x6ZRtUNoZ/2z5pdexOjQpJ/7N9EPuIUl7JUj2APST/X80kQJa?=
 =?us-ascii?Q?jHfnUTT59YsfKI0U8Djye1f3QqYhUYJE8p3UxOMxAmcEy4SDncSijX3IZ9RL?=
 =?us-ascii?Q?A5xKh0dMhnVy5rUbQsTGmJHsygt07Djlflwa4cr71I84JpKLde6unjlSTVfF?=
 =?us-ascii?Q?/bXjvZaryG/gH9MLpjaUm0SLuWxxiGVwTxZR9oRo5N/oMzZBgyu9oZhlY5x1?=
 =?us-ascii?Q?+qKjLNjlWfV5xhuhZ6Yo+ffSui7p63AuIWjVesXleYWYdTAbN3J9/kIWAzRQ?=
 =?us-ascii?Q?fM8owm/5k0ls+GjNKRs2hQCmDGWo3tQfI//+8jZFKLpi4x/F7FVmSFJ11Wtz?=
 =?us-ascii?Q?z8ddwAcAE0NO3o8lUlcEUiWfxrWKTnFYoaLsOmAkZTuUNK2l9F9QJ/L04eJY?=
 =?us-ascii?Q?eXtu0ery6tfLxVo3Iy83rofflM8FTUCjpDq7pOxO+8CNsRnQuKXQntcZzV74?=
 =?us-ascii?Q?4sbb/Y3QHQ7+JSedScZqyKvE357MMFwWMwiFKF5fc4sbEbCFRoouyA4k+81Q?=
 =?us-ascii?Q?bCuOn/NtffW07ZY/VdhMQF5GizUsP76AiTUmuv4429PWqQFu8izgUf6yW3Qs?=
 =?us-ascii?Q?Dou6V25sjZ3y7w6S/Cp7fG7iVwqrZXs3ZUKEnjtvsUiC+JrtIytPtHHqrYtQ?=
 =?us-ascii?Q?sa4rC3x/LLOs1qmLrUTun6S5Y5oBFYnkYCHivcxX56w72XPob6VbWfGZTAI3?=
 =?us-ascii?Q?qOXusF+YetAkP13le/yBGnolyNhUAoRmI0vLfi66aL3zwGWDcF9iHDW+c4AD?=
 =?us-ascii?Q?UpBzxIRf1I7G1hmP7wCYoPqRLtAGSy6R51Qs11VM1byMiUrIWXrJZ0RuIgfO?=
 =?us-ascii?Q?21gpxVUgB9FU5qNtZZaiJK5qNy18nxLZV++bcaIOxwldMDC2FFRflr3XXueW?=
 =?us-ascii?Q?RiacHQw5sOGlPyxoOszAFDRQw1laTAAdQ1Mu5XwdeB0fdl2Hnqn+QzjvOQjT?=
 =?us-ascii?Q?pW23XcpyU0Nz1xQDkn8slJZ/lzWqlyywL+3qtYqK7PFZTBP021IHQswAFX4O?=
 =?us-ascii?Q?KIX3rQfaeXJxSraTvhRxnAI79onqTLm+KICmInK8smQ7+fp4gGiXV+KjIWxK?=
 =?us-ascii?Q?HUDt+NS4/oUU2nEU3VfrFGH8jnx6KDvFMRiSzgey+92xPQsm1CkszR33enzM?=
 =?us-ascii?Q?39O8CskH/fxKTVxH6vg=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(61400799027);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 10:42:46.9106
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af00d366-4937-461f-c63f-08de0ca0bf06
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MWH0EPF000971E4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR19MB7041
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDA4MCBTYWx0ZWRfX+INo7OdaN2JR
 m9Jt13FaQW/G0htQi/G7hHYXNByZ7upTcARH0VEv6JpmCJphoOAAMPYCoeZS4oK7SP71+TNlskR
 iN92RbEe4jdkXnQWmcjfc7Das+mEJ16xYDWzJlTHJeBYvIDAIpcXLrFIOM3xyjKxACiXbGj40gV
 SOdChi4mRUTQJUTVDHC7BGKMpbM9PwAHjp5PfukEBIOcuReSbj10bz5nfvefXGQEJ3T3kZhL+8K
 LS8DQSqnMCS5uzkmWT3GiZvKre2AFKrH+35MzIdcRn48jPWQ3u4XGcuAYEc730Wnm6aKj/spgMh
 mWtn8ieHwwXK9ciU9KbYisEhfKjTIrUhQpuotYz6nzvfeSQBQlMFA3mZevtPvBzGOgU08jiuJOp
 k8PjuCHdsS2n3T4a1HpQfIH5qaNkOw==
X-Proofpoint-ORIG-GUID: cC16SFYIWUMdcIQkoFDPPgV9W7JwqJHO
X-Authority-Analysis: v=2.4 cv=OJIqHCaB c=1 sm=1 tr=0 ts=68f0cc2b cx=c_pps
 a=rJ76FBf8UdibaoD+N2q2jg==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=RWc_ulEos4gA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=w1d2syhTAAAA:8 a=ulGInPhhc-9duvULAZUA:9
X-Proofpoint-GUID: cC16SFYIWUMdcIQkoFDPPgV9W7JwqJHO
X-Proofpoint-Spam-Reason: safe

Add a set of test cases for cs_amp_set_efi_calibration_data().

Broadly there are two type of behavior being tested:

How the EFI is updated:
- Create a new EFI
- Overwrite part of existing content
- Overwrite part of zero-filled preallocated content
- Grow the file to append new content

And how the location within the content is chosen:
- Overwrite a specific array entry
- Overwrite an entry with the same calTarget (silicon ID)
- Overwrite a free entry
- Append after existing data

Plus some cases for error conditions.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 include/sound/cs-amp-lib.h         |    5 +
 sound/soc/codecs/cs-amp-lib-test.c | 1399 +++++++++++++++++++++++++++-
 sound/soc/codecs/cs-amp-lib.c      |    1 +
 3 files changed, 1397 insertions(+), 8 deletions(-)

diff --git a/include/sound/cs-amp-lib.h b/include/sound/cs-amp-lib.h
index 4c8b84ee087e..8eee4ce9eefe 100644
--- a/include/sound/cs-amp-lib.h
+++ b/include/sound/cs-amp-lib.h
@@ -70,6 +70,11 @@ struct cs_amp_test_hooks {
 					 u32 *returned_attr,
 					 unsigned long *size,
 					 void *buf);
+	efi_status_t (*set_efi_variable)(efi_char16_t *name,
+					 efi_guid_t *guid,
+					 u32 attr,
+					 unsigned long size,
+					 void *buf);
 
 	int (*write_cal_coeff)(struct cs_dsp *dsp,
 			       const struct cirrus_amp_cal_controls *controls,
diff --git a/sound/soc/codecs/cs-amp-lib-test.c b/sound/soc/codecs/cs-amp-lib-test.c
index d3419f48297e..7fa6aabc746a 100644
--- a/sound/soc/codecs/cs-amp-lib-test.c
+++ b/sound/soc/codecs/cs-amp-lib-test.c
@@ -20,6 +20,10 @@
 #include <linux/random.h>
 #include <sound/cs-amp-lib.h>
 
+#define CIRRUS_LOGIC_CALIBRATION_EFI_NAME L"CirrusSmartAmpCalibrationData"
+#define CIRRUS_LOGIC_CALIBRATION_EFI_GUID \
+	EFI_GUID(0x02f9af02, 0x7734, 0x4233, 0xb4, 0x3d, 0x93, 0xfe, 0x5a, 0xa3, 0x5d, 0xb3)
+
 #define LENOVO_SPEAKER_ID_EFI_NAME L"SdwSpeaker"
 #define LENOVO_SPEAKER_ID_EFI_GUID \
 	EFI_GUID(0x48df970e, 0xe27f, 0x460a, 0xb5, 0x86, 0x77, 0x19, 0x80, 0x1d, 0x92, 0x82)
@@ -28,6 +32,10 @@
 #define HP_SPEAKER_ID_EFI_GUID \
 	EFI_GUID(0xc49593a4, 0xd099, 0x419b, 0xa2, 0xc3, 0x67, 0xe9, 0x80, 0xe6, 0x1d, 0x1e)
 
+#define HP_CALIBRATION_EFI_NAME L"SmartAmpCalibrationData"
+#define HP_CALIBRATION_EFI_GUID \
+	EFI_GUID(0x53559579, 0x8753, 0x4f5c, 0x91, 0x30, 0xe8, 0x2a, 0xcf, 0xb8, 0xd8, 0x93)
+
 KUNIT_DEFINE_ACTION_WRAPPER(faux_device_destroy_wrapper, faux_device_destroy,
 			    struct faux_device *)
 
@@ -36,6 +44,7 @@ struct cs_amp_lib_test_priv {
 
 	struct cirrus_amp_efi_data *cal_blob;
 	struct list_head ctl_write_list;
+	u32 efi_attr;
 };
 
 struct cs_amp_lib_test_ctl_write_entry {
@@ -49,6 +58,20 @@ struct cs_amp_lib_test_param {
 	int amp_index;
 };
 
+static struct cirrus_amp_efi_data *cs_amp_lib_test_cal_blob_dup(struct kunit *test)
+{
+	struct cs_amp_lib_test_priv *priv = test->priv;
+	struct cirrus_amp_efi_data *temp;
+
+	KUNIT_ASSERT_EQ(test, struct_size(priv->cal_blob, data, priv->cal_blob->count),
+			priv->cal_blob->size);
+	temp = kunit_kmalloc(test, priv->cal_blob->size, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, temp);
+	memcpy(temp, priv->cal_blob, priv->cal_blob->size);
+
+	return temp;
+}
+
 static void cs_amp_lib_test_init_dummy_cal_blob(struct kunit *test, int num_amps)
 {
 	struct cs_amp_lib_test_priv *priv = test->priv;
@@ -69,9 +92,15 @@ static void cs_amp_lib_test_init_dummy_cal_blob(struct kunit *test, int num_amps
 	for (i = 0; i < num_amps; i++)
 		priv->cal_blob->data[i].calTime[0] |= 1;
 
-	/* Ensure that all UIDs are non-zero and unique. */
-	for (i = 0; i < num_amps; i++)
+	/*
+	 * Ensure that all UIDs are non-zero and unique.
+	 * Make both words non-zero and not equal values, so that
+	 * tests can verify that both words were checked or changed.
+	 */
+	for (i = 0; i < num_amps; i++) {
 		*(u8 *)&priv->cal_blob->data[i].calTarget[0] = i + 1;
+		*(u8 *)&priv->cal_blob->data[i].calTarget[1] = i;
+	}
 }
 
 static u64 cs_amp_lib_test_get_target_uid(struct kunit *test)
@@ -199,9 +228,8 @@ static efi_status_t cs_amp_lib_test_get_efi_variable(efi_char16_t *name,
 						     unsigned long *size,
 						     void *buf)
 {
-	static const efi_char16_t expected_name[] = L"CirrusSmartAmpCalibrationData";
-	static const efi_guid_t expected_guid =
-		EFI_GUID(0x02f9af02, 0x7734, 0x4233, 0xb4, 0x3d, 0x93, 0xfe, 0x5a, 0xa3, 0x5d, 0xb3);
+	static const efi_char16_t expected_name[] = CIRRUS_LOGIC_CALIBRATION_EFI_NAME;
+	static const efi_guid_t expected_guid = CIRRUS_LOGIC_CALIBRATION_EFI_GUID;
 	struct kunit *test = kunit_get_current_test();
 	struct cs_amp_lib_test_priv *priv = test->priv;
 
@@ -223,9 +251,56 @@ static efi_status_t cs_amp_lib_test_get_efi_variable(efi_char16_t *name,
 	memcpy(buf, priv->cal_blob, priv->cal_blob->size);
 
 	if (returned_attr) {
-		*returned_attr = EFI_VARIABLE_NON_VOLATILE |
-				 EFI_VARIABLE_BOOTSERVICE_ACCESS |
-				 EFI_VARIABLE_RUNTIME_ACCESS;
+		if (priv->efi_attr)
+			*returned_attr = priv->efi_attr;
+		else
+			*returned_attr = EFI_VARIABLE_NON_VOLATILE |
+					 EFI_VARIABLE_BOOTSERVICE_ACCESS |
+					 EFI_VARIABLE_RUNTIME_ACCESS;
+	}
+
+	return EFI_SUCCESS;
+}
+
+#define CS_AMP_LIB_ZERO_FILLED_BLOB_SIZE \
+	struct_size_t(struct cirrus_amp_efi_data, data, 8)
+
+/* Redirected get_efi_variable to simulate reading a prealloced zero-filled blob */
+static efi_status_t cs_amp_lib_test_get_efi_variable_all_zeros(efi_char16_t *name,
+							       efi_guid_t *guid,
+							       u32 *returned_attr,
+							       unsigned long *size,
+							       void *buf)
+{
+	static const efi_char16_t expected_name[] = CIRRUS_LOGIC_CALIBRATION_EFI_NAME;
+	static const efi_guid_t expected_guid = CIRRUS_LOGIC_CALIBRATION_EFI_GUID;
+	struct kunit *test = kunit_get_current_test();
+	struct cs_amp_lib_test_priv *priv = test->priv;
+
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, name);
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, guid);
+
+	if (memcmp(name, expected_name, sizeof(expected_name)) ||
+	    efi_guidcmp(*guid, expected_guid))
+		return -EFI_NOT_FOUND;
+
+	if (!buf) {
+		*size = CS_AMP_LIB_ZERO_FILLED_BLOB_SIZE;
+		return EFI_BUFFER_TOO_SMALL;
+	}
+
+	KUNIT_ASSERT_EQ(test, *size, struct_size(priv->cal_blob, data, 8));
+	priv->cal_blob = kunit_kzalloc(test, CS_AMP_LIB_ZERO_FILLED_BLOB_SIZE, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, priv->cal_blob);
+	memset(buf, 0, CS_AMP_LIB_ZERO_FILLED_BLOB_SIZE);
+
+	if (returned_attr) {
+		if (priv->efi_attr)
+			*returned_attr = priv->efi_attr;
+		else
+			*returned_attr = EFI_VARIABLE_NON_VOLATILE |
+					 EFI_VARIABLE_BOOTSERVICE_ACCESS |
+					 EFI_VARIABLE_RUNTIME_ACCESS;
 	}
 
 	return EFI_SUCCESS;
@@ -790,6 +865,1292 @@ static void cs_amp_lib_test_write_ambient_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, entry->value, 18);
 }
 
+static efi_status_t cs_amp_lib_test_set_efi_variable(efi_char16_t *name,
+						     efi_guid_t *guid,
+						     u32 attr,
+						     unsigned long size,
+						     void *buf)
+{
+	static const efi_char16_t expected_name[] = CIRRUS_LOGIC_CALIBRATION_EFI_NAME;
+	static const efi_guid_t expected_guid = CIRRUS_LOGIC_CALIBRATION_EFI_GUID;
+	struct kunit *test = kunit_get_current_test();
+	struct cs_amp_lib_test_priv *priv = test->priv;
+
+	KUNIT_ASSERT_NOT_NULL(test, name);
+	KUNIT_ASSERT_NOT_NULL(test, guid);
+
+	if (memcmp(name, expected_name, sizeof(expected_name)) ||
+	    efi_guidcmp(*guid, expected_guid))
+		return -EFI_NOT_FOUND;
+
+	KUNIT_ASSERT_NOT_NULL(test, buf);
+	KUNIT_ASSERT_NE(test, 0, size);
+
+	kunit_kfree(test, priv->cal_blob);
+	priv->cal_blob = kunit_kmalloc(test, size, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, priv->cal_blob);
+	memcpy(priv->cal_blob, buf, size);
+	priv->efi_attr = attr;
+
+	return EFI_SUCCESS;
+}
+
+static efi_status_t cs_amp_lib_test_set_efi_variable_denied(efi_char16_t *name,
+							    efi_guid_t *guid,
+							    u32 attr,
+							    unsigned long size,
+							    void *buf)
+{
+	return EFI_WRITE_PROTECTED;
+}
+
+#define CS_AMP_CAL_DEFAULT_EFI_ATTR			\
+		(EFI_VARIABLE_NON_VOLATILE |		\
+		 EFI_VARIABLE_BOOTSERVICE_ACCESS |	\
+		 EFI_VARIABLE_RUNTIME_ACCESS)
+
+static void cs_amp_lib_test_create_new_cal_efi(struct kunit *test)
+{
+	struct cs_amp_lib_test_priv *priv = test->priv;
+	struct device *dev = &priv->amp_dev->dev;
+	struct cirrus_amp_cal_data data;
+	int i;
+
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->get_efi_variable,
+				   cs_amp_lib_test_get_efi_variable_none);
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->set_efi_variable,
+				   cs_amp_lib_test_set_efi_variable);
+
+	/* For unspecified number of amps */
+	get_random_bytes(&data, sizeof(data));
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, -1, -1, &data));
+	KUNIT_EXPECT_EQ(test, CS_AMP_CAL_DEFAULT_EFI_ATTR, priv->efi_attr);
+	KUNIT_EXPECT_GE(test, priv->cal_blob->count, 1);
+	KUNIT_EXPECT_LE(test, priv->cal_blob->count, 8);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, priv->cal_blob->count),
+			priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[0], sizeof(data));
+	for (i = 1; i < priv->cal_blob->count; i++)
+		KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[i], sizeof(data)));
+
+	/* For 2 amps */
+	priv->cal_blob = NULL;
+	get_random_bytes(&data, sizeof(data));
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, -1, 2, &data));
+	KUNIT_EXPECT_EQ(test, CS_AMP_CAL_DEFAULT_EFI_ATTR, priv->efi_attr);
+	KUNIT_EXPECT_EQ(test, 2, priv->cal_blob->count);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 2), priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[1], sizeof(data)));
+
+	/* For 4 amps */
+	priv->cal_blob = NULL;
+	get_random_bytes(&data, sizeof(data));
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, -1, 4, &data));
+	KUNIT_EXPECT_EQ(test, 4, priv->cal_blob->count);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 4), priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[1], sizeof(data)));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[2], sizeof(data)));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[3], sizeof(data)));
+
+	/* For 6 amps */
+	priv->cal_blob = NULL;
+	get_random_bytes(&data, sizeof(data));
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, -1, 6, &data));
+	KUNIT_EXPECT_EQ(test, 6, priv->cal_blob->count);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 6), priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[1], sizeof(data)));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[2], sizeof(data)));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[3], sizeof(data)));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[4], sizeof(data)));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[5], sizeof(data)));
+}
+
+static void cs_amp_lib_test_create_new_cal_efi_indexed(struct kunit *test)
+{
+	struct cs_amp_lib_test_priv *priv = test->priv;
+	struct device *dev = &priv->amp_dev->dev;
+	struct cirrus_amp_cal_data data;
+
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->get_efi_variable,
+				   cs_amp_lib_test_get_efi_variable_none);
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->set_efi_variable,
+				   cs_amp_lib_test_set_efi_variable);
+
+	/* In slot 0 */
+	priv->cal_blob = NULL;
+	get_random_bytes(&data, sizeof(data));
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, 0, 6, &data));
+	KUNIT_EXPECT_EQ(test, 6, priv->cal_blob->count);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 6), priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[1], sizeof(data)));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[2], sizeof(data)));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[3], sizeof(data)));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[4], sizeof(data)));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[5], sizeof(data)));
+
+	/* In slot 1 */
+	priv->cal_blob = NULL;
+	get_random_bytes(&data, sizeof(data));
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, 1, 6, &data));
+	KUNIT_EXPECT_EQ(test, 6, priv->cal_blob->count);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 6), priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[1], sizeof(data));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[0], sizeof(data)));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[2], sizeof(data)));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[3], sizeof(data)));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[4], sizeof(data)));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[5], sizeof(data)));
+
+	/* In slot 5 */
+	priv->cal_blob = NULL;
+	get_random_bytes(&data, sizeof(data));
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, 5, 6, &data));
+	KUNIT_EXPECT_EQ(test, 6, priv->cal_blob->count);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 6), priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[5], sizeof(data));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[0], sizeof(data)));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[1], sizeof(data)));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[2], sizeof(data)));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[3], sizeof(data)));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[4], sizeof(data)));
+}
+
+static void cs_amp_lib_test_create_new_cal_efi_indexed_no_max(struct kunit *test)
+{
+	struct cs_amp_lib_test_priv *priv = test->priv;
+	struct device *dev = &priv->amp_dev->dev;
+	struct cirrus_amp_cal_data data;
+	int i;
+
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->get_efi_variable,
+				   cs_amp_lib_test_get_efi_variable_none);
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->set_efi_variable,
+				   cs_amp_lib_test_set_efi_variable);
+
+	/* In slot 0 with unspecified number of amps */
+	priv->cal_blob = NULL;
+	get_random_bytes(&data, sizeof(data));
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, 0, -1, &data));
+	KUNIT_EXPECT_GE(test, priv->cal_blob->count, 1);
+	KUNIT_EXPECT_LE(test, priv->cal_blob->count, 8);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, priv->cal_blob->count),
+			priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[0], sizeof(data));
+	for (i = 1; i < priv->cal_blob->count; i++)
+		KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[i], sizeof(data)));
+
+	/* In slot 1 with unspecified number of amps  */
+	priv->cal_blob = NULL;
+	get_random_bytes(&data, sizeof(data));
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, 1, -1, &data));
+	KUNIT_EXPECT_GE(test, priv->cal_blob->count, 2);
+	KUNIT_EXPECT_LE(test, priv->cal_blob->count, 8);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, priv->cal_blob->count),
+			priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[1], sizeof(data));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[0], sizeof(data)));
+	for (i = 2; i < priv->cal_blob->count; i++)
+		KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[i], sizeof(data)));
+
+	/* In slot 5 with unspecified number of amps  */
+	priv->cal_blob = NULL;
+	get_random_bytes(&data, sizeof(data));
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, 5, -1, &data));
+	KUNIT_EXPECT_GE(test, priv->cal_blob->count, 6);
+	KUNIT_EXPECT_LE(test, priv->cal_blob->count, 8);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, priv->cal_blob->count),
+			priv->cal_blob->size);
+	for (i = 0; (i < 5) && (i < priv->cal_blob->count); i++)
+		KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[i], sizeof(data)));
+
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[5], sizeof(data));
+	for (i = 6; i < priv->cal_blob->count; i++)
+		KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[i], sizeof(data)));
+}
+
+static void cs_amp_lib_test_grow_append_cal_efi(struct kunit *test)
+{
+	struct cs_amp_lib_test_priv *priv = test->priv;
+	struct device *dev = &priv->amp_dev->dev;
+	const struct cirrus_amp_efi_data *original_blob;
+	struct cirrus_amp_cal_data data;
+
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->get_efi_variable,
+				   cs_amp_lib_test_get_efi_variable);
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->set_efi_variable,
+				   cs_amp_lib_test_set_efi_variable);
+
+	/* Initially 1 used entry grown to 2 entries */
+	cs_amp_lib_test_init_dummy_cal_blob(test, 1);
+	KUNIT_ASSERT_EQ(test, 1, priv->cal_blob->count);
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	data.calTarget[0] = 0xaaaaaaaa; /* won't match */
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, -1, 2, &data));
+	KUNIT_EXPECT_EQ(test, CS_AMP_CAL_DEFAULT_EFI_ATTR, priv->efi_attr);
+	KUNIT_EXPECT_EQ(test, 2, priv->cal_blob->count);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 2), priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[0], &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[1], sizeof(data));
+
+	/* Initially 1 entry grown to 4 entries */
+	priv->cal_blob = NULL;
+	cs_amp_lib_test_init_dummy_cal_blob(test, 1);
+	KUNIT_ASSERT_EQ(test, 1, priv->cal_blob->count);
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	data.calTarget[0] = 0xaaaaaaaa; /* won't match */
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, -1, 4, &data));
+	KUNIT_EXPECT_EQ(test, 4, priv->cal_blob->count);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 4), priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[0], &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[1], sizeof(data));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[2], sizeof(data)));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[3], sizeof(data)));
+
+	/* Initially 2 entries grown to 4 entries */
+	priv->cal_blob = NULL;
+	cs_amp_lib_test_init_dummy_cal_blob(test, 2);
+	KUNIT_ASSERT_EQ(test, 2, priv->cal_blob->count);
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	data.calTarget[0] = 0xaaaaaaaa; /* won't match */
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, -1, 4, &data));
+	KUNIT_EXPECT_EQ(test, 4, priv->cal_blob->count);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 4), priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[0], &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[1], &priv->cal_blob->data[1], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[2], sizeof(data));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[3], sizeof(data)));
+
+	/* Initially 1 entry grown to 6 entries */
+	priv->cal_blob = NULL;
+	cs_amp_lib_test_init_dummy_cal_blob(test, 1);
+	KUNIT_ASSERT_EQ(test, 1, priv->cal_blob->count);
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	data.calTarget[0] = 0xaaaaaaaa; /* won't match */
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, -1, 6, &data));
+	KUNIT_EXPECT_EQ(test, 6, priv->cal_blob->count);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 6), priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[0], &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[1], sizeof(data));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[2], sizeof(data)));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[3], sizeof(data)));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[4], sizeof(data)));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[5], sizeof(data)));
+
+	/* Initially 4 entries grown to 6 entries */
+	priv->cal_blob = NULL;
+	cs_amp_lib_test_init_dummy_cal_blob(test, 4);
+	KUNIT_ASSERT_EQ(test, 4, priv->cal_blob->count);
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	data.calTarget[0] = 0xaaaaaaaa; /* won't match */
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, -1, 6, &data));
+	KUNIT_EXPECT_EQ(test, 6, priv->cal_blob->count);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 6), priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[0], &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[1], &priv->cal_blob->data[1], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[2], &priv->cal_blob->data[2], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[3], &priv->cal_blob->data[3], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[4], sizeof(data));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[5], sizeof(data)));
+}
+
+static void cs_amp_lib_test_grow_append_cal_efi_indexed(struct kunit *test)
+{
+	struct cs_amp_lib_test_priv *priv = test->priv;
+	struct device *dev = &priv->amp_dev->dev;
+	const struct cirrus_amp_efi_data *original_blob;
+	struct cirrus_amp_cal_data data;
+
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->get_efi_variable,
+				   cs_amp_lib_test_get_efi_variable);
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->set_efi_variable,
+				   cs_amp_lib_test_set_efi_variable);
+
+	/* Initially 1 entry grown to 2 entries using slot 1 */
+	priv->cal_blob = NULL;
+	cs_amp_lib_test_init_dummy_cal_blob(test, 1);
+	KUNIT_ASSERT_EQ(test, 1, priv->cal_blob->count);
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	data.calTarget[0] = 0xaaaaaaaa; /* won't match */
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, 1, 2, &data));
+	KUNIT_EXPECT_EQ(test, 2, priv->cal_blob->count);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 2), priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[0], &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[1], sizeof(data));
+
+	/* Initially 1 entry grown to 6 entries using slot 1 */
+	priv->cal_blob = NULL;
+	cs_amp_lib_test_init_dummy_cal_blob(test, 1);
+	KUNIT_ASSERT_EQ(test, 1, priv->cal_blob->count);
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	data.calTarget[0] = 0xaaaaaaaa; /* won't match */
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, 1, 6, &data));
+	KUNIT_EXPECT_EQ(test, 6, priv->cal_blob->count);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 6), priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[0], &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[1], sizeof(data));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[2], sizeof(data)));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[3], sizeof(data)));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[4], sizeof(data)));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[5], sizeof(data)));
+
+	/* Initially 2 entries grown to 6 entries using slot 2 */
+	priv->cal_blob = NULL;
+	cs_amp_lib_test_init_dummy_cal_blob(test, 2);
+	KUNIT_ASSERT_EQ(test, 2, priv->cal_blob->count);
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	data.calTarget[0] = 0xaaaaaaaa; /* won't match */
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, 2, 6, &data));
+	KUNIT_EXPECT_EQ(test, 6, priv->cal_blob->count);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 6), priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[0], &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[1], &priv->cal_blob->data[1], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[2], sizeof(data));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[3], sizeof(data)));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[4], sizeof(data)));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[5], sizeof(data)));
+
+	/* Initially 2 entries grown to 6 entries using slot 4 */
+	kunit_kfree(test, original_blob);
+	kunit_kfree(test, priv->cal_blob);
+	priv->cal_blob = NULL;
+	cs_amp_lib_test_init_dummy_cal_blob(test, 2);
+	KUNIT_ASSERT_EQ(test, 2, priv->cal_blob->count);
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	data.calTarget[0] = 0xaaaaaaaa; /* won't match */
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, 4, 6, &data));
+	KUNIT_EXPECT_EQ(test, 6, priv->cal_blob->count);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 6), priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[0], &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[1], &priv->cal_blob->data[1], sizeof(data));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[2], sizeof(data)));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[3], sizeof(data)));
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[4], sizeof(data));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[5], sizeof(data)));
+}
+
+static void cs_amp_lib_test_cal_efi_all_zeros_add_first(struct kunit *test)
+{
+	struct cs_amp_lib_test_priv *priv = test->priv;
+	struct device *dev = &priv->amp_dev->dev;
+	struct cirrus_amp_cal_data data;
+	int i;
+
+	/* Simulate a BIOS reserving EFI space that is entirely zero-filled. */
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->get_efi_variable,
+				   cs_amp_lib_test_get_efi_variable_all_zeros);
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->set_efi_variable,
+				   cs_amp_lib_test_set_efi_variable);
+
+	/*
+	 * Add an entry. The header should be filled in to match the
+	 * original EFI variable size.
+	 */
+	get_random_bytes(&data, sizeof(data));
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, -1, -1, &data));
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 8), priv->cal_blob->size);
+	KUNIT_EXPECT_EQ(test, 8, priv->cal_blob->count);
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[0], sizeof(data));
+	for (i = 1; i < priv->cal_blob->count; i++) {
+		KUNIT_EXPECT_EQ(test, 0, priv->cal_blob->data[i].calTime[0]);
+		KUNIT_EXPECT_EQ(test, 0, priv->cal_blob->data[i].calTime[1]);
+	}
+}
+
+static void cs_amp_lib_test_cal_efi_all_zeros_add_first_no_shrink(struct kunit *test)
+{
+	struct cs_amp_lib_test_priv *priv = test->priv;
+	struct device *dev = &priv->amp_dev->dev;
+	struct cirrus_amp_cal_data data;
+	int i;
+
+	/* Simulate a BIOS reserving EFI space that is entirely zero-filled. */
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->get_efi_variable,
+				   cs_amp_lib_test_get_efi_variable_all_zeros);
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->set_efi_variable,
+				   cs_amp_lib_test_set_efi_variable);
+
+	/*
+	 * Add an entry. The header should be filled in to match the
+	 * original EFI variable size. A number of amps less than the
+	 * available preallocated space does not shrink the EFI variable.
+	 */
+	get_random_bytes(&data, sizeof(data));
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, -1, 4, &data));
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 8), priv->cal_blob->size);
+	KUNIT_EXPECT_EQ(test, 8, priv->cal_blob->count);
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[0], sizeof(data));
+	for (i = 1; i < priv->cal_blob->count; i++) {
+		KUNIT_EXPECT_EQ(test, 0, priv->cal_blob->data[i].calTime[0]);
+		KUNIT_EXPECT_EQ(test, 0, priv->cal_blob->data[i].calTime[1]);
+	}
+}
+
+static void cs_amp_lib_test_cal_efi_all_zeros_add_first_indexed(struct kunit *test)
+{
+	struct cs_amp_lib_test_priv *priv = test->priv;
+	struct device *dev = &priv->amp_dev->dev;
+	struct cirrus_amp_cal_data data;
+	int i;
+
+	/* Simulate a BIOS reserving EFI space that is entirely zero-filled. */
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->get_efi_variable,
+				   cs_amp_lib_test_get_efi_variable_all_zeros);
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->set_efi_variable,
+				   cs_amp_lib_test_set_efi_variable);
+
+	/*
+	 * Write entry to slot 2. The header should be filled in to match
+	 * the original EFI variable size.
+	 */
+	get_random_bytes(&data, sizeof(data));
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, 2, -1, &data));
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 8), priv->cal_blob->size);
+	KUNIT_EXPECT_EQ(test, 8, priv->cal_blob->count);
+	KUNIT_EXPECT_EQ(test, 0, priv->cal_blob->data[0].calTime[0]);
+	KUNIT_EXPECT_EQ(test, 0, priv->cal_blob->data[0].calTime[1]);
+	KUNIT_EXPECT_EQ(test, 0, priv->cal_blob->data[1].calTime[0]);
+	KUNIT_EXPECT_EQ(test, 0, priv->cal_blob->data[1].calTime[1]);
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[2], sizeof(data));
+	for (i = 3; i < priv->cal_blob->count; i++) {
+		KUNIT_EXPECT_EQ(test, 0, priv->cal_blob->data[i].calTime[0]);
+		KUNIT_EXPECT_EQ(test, 0, priv->cal_blob->data[i].calTime[1]);
+	}
+}
+
+static void cs_amp_lib_test_cal_efi_all_zeros_add_first_indexed_no_shrink(struct kunit *test)
+{
+	struct cs_amp_lib_test_priv *priv = test->priv;
+	struct device *dev = &priv->amp_dev->dev;
+	struct cirrus_amp_cal_data data;
+	int i;
+
+	/* Simulate a BIOS reserving EFI space that is entirely zero-filled. */
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->get_efi_variable,
+				   cs_amp_lib_test_get_efi_variable_all_zeros);
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->set_efi_variable,
+				   cs_amp_lib_test_set_efi_variable);
+
+	/*
+	 * Write entry to slot 2. The header should be filled in to match
+	 * the original EFI variable size. A number of amps less than the
+	 * available preallocated space does not shrink the EFI variable.
+	 */
+	get_random_bytes(&data, sizeof(data));
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, 2, 4, &data));
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 8), priv->cal_blob->size);
+	KUNIT_EXPECT_EQ(test, 8, priv->cal_blob->count);
+	KUNIT_EXPECT_EQ(test, 0, priv->cal_blob->data[0].calTime[0]);
+	KUNIT_EXPECT_EQ(test, 0, priv->cal_blob->data[0].calTime[1]);
+	KUNIT_EXPECT_EQ(test, 0, priv->cal_blob->data[1].calTime[0]);
+	KUNIT_EXPECT_EQ(test, 0, priv->cal_blob->data[1].calTime[1]);
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[2], sizeof(data));
+	for (i = 3; i < priv->cal_blob->count; i++) {
+		KUNIT_EXPECT_EQ(test, 0, priv->cal_blob->data[i].calTime[0]);
+		KUNIT_EXPECT_EQ(test, 0, priv->cal_blob->data[i].calTime[1]);
+	}
+}
+
+static void cs_amp_lib_test_grow_append_cal_efi_indexed_no_max(struct kunit *test)
+{
+	struct cs_amp_lib_test_priv *priv = test->priv;
+	struct device *dev = &priv->amp_dev->dev;
+	const struct cirrus_amp_efi_data *original_blob;
+	struct cirrus_amp_cal_data data;
+	int i;
+
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->get_efi_variable,
+				   cs_amp_lib_test_get_efi_variable);
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->set_efi_variable,
+				   cs_amp_lib_test_set_efi_variable);
+
+	/* Initially 1 entry adding slot 1 */
+	cs_amp_lib_test_init_dummy_cal_blob(test, 1);
+	KUNIT_ASSERT_EQ(test, 1, priv->cal_blob->count);
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	data.calTarget[0] = 0xaaaaaaaa; /* won't match */
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, 1, -1, &data));
+	KUNIT_EXPECT_GE(test, priv->cal_blob->count, 2);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, priv->cal_blob->count),
+			priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[0], &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[1], sizeof(data));
+	for (i = 2; i < priv->cal_blob->count; i++)
+		KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[i], sizeof(data)));
+
+	/* Initially 1 entry adding slot 3 */
+	cs_amp_lib_test_init_dummy_cal_blob(test, 1);
+	KUNIT_ASSERT_EQ(test, 1, priv->cal_blob->count);
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	data.calTarget[0] = 0xaaaaaaaa; /* won't match */
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, 3, -1, &data));
+	KUNIT_EXPECT_GE(test, priv->cal_blob->count, 4);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, priv->cal_blob->count),
+			priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[0], &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[1], sizeof(data)));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[2], sizeof(data)));
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[3], sizeof(data));
+	for (i = 4; i < priv->cal_blob->count; i++)
+		KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[i], sizeof(data)));
+
+	/* Initially 2 entries adding slot 3 */
+	priv->cal_blob = NULL;
+	cs_amp_lib_test_init_dummy_cal_blob(test, 2);
+	KUNIT_ASSERT_EQ(test, 2, priv->cal_blob->count);
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	data.calTarget[0] = 0xaaaaaaaa; /* won't match */
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, 3, -1, &data));
+	KUNIT_EXPECT_GE(test, priv->cal_blob->count, 1);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, priv->cal_blob->count),
+			priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[0], &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[1], &priv->cal_blob->data[1], sizeof(data));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[2], sizeof(data)));
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[3], sizeof(data));
+	for (i = 4; i < priv->cal_blob->count; i++)
+		KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[i], sizeof(data)));
+
+	/* Initially 4 entries adding slot 4 */
+	priv->cal_blob = NULL;
+	cs_amp_lib_test_init_dummy_cal_blob(test, 4);
+	KUNIT_ASSERT_EQ(test, 4, priv->cal_blob->count);
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	data.calTarget[0] = 0xaaaaaaaa; /* won't match */
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, 4, -1, &data));
+	KUNIT_EXPECT_GE(test, priv->cal_blob->count, 1);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, priv->cal_blob->count),
+			priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[0], &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[1], &priv->cal_blob->data[1], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[2], &priv->cal_blob->data[2], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[3], &priv->cal_blob->data[3], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[4], sizeof(data));
+	for (i = 5; i < priv->cal_blob->count; i++)
+		KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[i], sizeof(data)));
+
+	/* Initially 4 entries adding slot 6 */
+	priv->cal_blob = NULL;
+	cs_amp_lib_test_init_dummy_cal_blob(test, 4);
+	KUNIT_ASSERT_EQ(test, 4, priv->cal_blob->count);
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	data.calTarget[0] = 0xaaaaaaaa; /* won't match */
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, 6, -1, &data));
+	KUNIT_EXPECT_GE(test, priv->cal_blob->count, 1);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, priv->cal_blob->count),
+			priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[0], &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[1], &priv->cal_blob->data[1], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[2], &priv->cal_blob->data[2], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[3], &priv->cal_blob->data[3], sizeof(data));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[4], sizeof(data)));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[5], sizeof(data)));
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[6], sizeof(data));
+	for (i = 7; i < priv->cal_blob->count; i++)
+		KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[i], sizeof(data)));
+}
+
+static void cs_amp_lib_test_grow_cal_efi_replace_indexed(struct kunit *test)
+{
+	struct cs_amp_lib_test_priv *priv = test->priv;
+	struct device *dev = &priv->amp_dev->dev;
+	const struct cirrus_amp_efi_data *original_blob;
+	struct cirrus_amp_cal_data data;
+
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->get_efi_variable,
+				   cs_amp_lib_test_get_efi_variable);
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->set_efi_variable,
+				   cs_amp_lib_test_set_efi_variable);
+
+	/* Initially 1 entry grown to 2 entries overwriting slot 0 */
+	cs_amp_lib_test_init_dummy_cal_blob(test, 1);
+	KUNIT_ASSERT_EQ(test, 1, priv->cal_blob->count);
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	data.calTarget[0] = 0xaaaaaaaa; /* won't match */
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, 0, 2, &data));
+	KUNIT_EXPECT_EQ(test, 2, priv->cal_blob->count);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 2), priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[1], sizeof(data)));
+
+	/* Initially 2 entries grown to 4 entries overwriting slot 1 */
+	priv->cal_blob = NULL;
+	cs_amp_lib_test_init_dummy_cal_blob(test, 2);
+	KUNIT_ASSERT_EQ(test, 2, priv->cal_blob->count);
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	data.calTarget[0] = 0xaaaaaaaa; /* won't match */
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, 1, 4, &data));
+	KUNIT_EXPECT_EQ(test, 4, priv->cal_blob->count);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 4), priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[0], &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[1], sizeof(data));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[2], sizeof(data)));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[3], sizeof(data)));
+
+	/* Initially 4 entries grown to 6 entries overwriting slot 1 */
+	priv->cal_blob = NULL;
+	cs_amp_lib_test_init_dummy_cal_blob(test, 4);
+	KUNIT_ASSERT_EQ(test, 4, priv->cal_blob->count);
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	data.calTarget[0] = 0xaaaaaaaa; /* won't match */
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, 1, 6, &data));
+	KUNIT_EXPECT_EQ(test, 6, priv->cal_blob->count);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 6), priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[0], &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[1], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[2], &priv->cal_blob->data[2], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[3], &priv->cal_blob->data[3], sizeof(data));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[4], sizeof(data)));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[5], sizeof(data)));
+
+	/* Initially 4 entries grown to 6 entries overwriting slot 3 */
+	priv->cal_blob = NULL;
+	cs_amp_lib_test_init_dummy_cal_blob(test, 4);
+	KUNIT_ASSERT_EQ(test, 4, priv->cal_blob->count);
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	data.calTarget[0] = 0xaaaaaaaa; /* won't match */
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, 3, 6, &data));
+	KUNIT_EXPECT_EQ(test, 6, priv->cal_blob->count);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 6), priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[0], &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[1], &priv->cal_blob->data[1], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[2], &priv->cal_blob->data[2], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[3], sizeof(data));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[4], sizeof(data)));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[5], sizeof(data)));
+
+	/* Initially 6 entries grown to 8 entries overwriting slot 4 */
+	priv->cal_blob = NULL;
+	cs_amp_lib_test_init_dummy_cal_blob(test, 6);
+	KUNIT_ASSERT_EQ(test, 6, priv->cal_blob->count);
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	data.calTarget[0] = 0xaaaaaaaa; /* won't match */
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, 4, 8, &data));
+	KUNIT_EXPECT_EQ(test, 8, priv->cal_blob->count);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 8), priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[0], &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[1], &priv->cal_blob->data[1], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[2], &priv->cal_blob->data[2], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[3], &priv->cal_blob->data[3], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[4], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[5], &priv->cal_blob->data[5], sizeof(data));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[6], sizeof(data)));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[7], sizeof(data)));
+}
+
+static void cs_amp_lib_test_grow_cal_efi_replace_by_uid(struct kunit *test)
+{
+	struct cs_amp_lib_test_priv *priv = test->priv;
+	struct device *dev = &priv->amp_dev->dev;
+	const struct cirrus_amp_efi_data *original_blob;
+	struct cirrus_amp_cal_data data;
+
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->get_efi_variable,
+				   cs_amp_lib_test_get_efi_variable);
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->set_efi_variable,
+				   cs_amp_lib_test_set_efi_variable);
+
+	/* Initially 1 entry grown to 2 entries overwriting slot 0 */
+	cs_amp_lib_test_init_dummy_cal_blob(test, 1);
+	KUNIT_ASSERT_EQ(test, 1, priv->cal_blob->count);
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	memcpy(data.calTarget, priv->cal_blob->data[0].calTarget, sizeof(data.calTarget));
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, -1, 2, &data));
+	KUNIT_EXPECT_EQ(test, 2, priv->cal_blob->count);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 2), priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[1], sizeof(data)));
+
+	/* Initially 2 entries grown to 4 entries overwriting slot 1 */
+	priv->cal_blob = NULL;
+	cs_amp_lib_test_init_dummy_cal_blob(test, 2);
+	KUNIT_ASSERT_EQ(test, 2, priv->cal_blob->count);
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	memcpy(data.calTarget, priv->cal_blob->data[1].calTarget, sizeof(data.calTarget));
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, -1, 4, &data));
+	KUNIT_EXPECT_EQ(test, 4, priv->cal_blob->count);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 4), priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[0], &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[1], sizeof(data));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[2], sizeof(data)));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[3], sizeof(data)));
+
+	/* Initially 4 entries grown to 6 entries overwriting slot 1 */
+	priv->cal_blob = NULL;
+	cs_amp_lib_test_init_dummy_cal_blob(test, 4);
+	KUNIT_ASSERT_EQ(test, 4, priv->cal_blob->count);
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	memcpy(data.calTarget, priv->cal_blob->data[1].calTarget, sizeof(data.calTarget));
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, -1, 6, &data));
+	KUNIT_EXPECT_EQ(test, 6, priv->cal_blob->count);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 6), priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[0], &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[1], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[2], &priv->cal_blob->data[2], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[3], &priv->cal_blob->data[3], sizeof(data));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[4], sizeof(data)));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[5], sizeof(data)));
+
+	/* Initially 4 entries grown to 6 entries overwriting slot 3 */
+	priv->cal_blob = NULL;
+	cs_amp_lib_test_init_dummy_cal_blob(test, 4);
+	KUNIT_ASSERT_EQ(test, 4, priv->cal_blob->count);
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	memcpy(data.calTarget, priv->cal_blob->data[3].calTarget, sizeof(data.calTarget));
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, -1, 6, &data));
+	KUNIT_EXPECT_EQ(test, 6, priv->cal_blob->count);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 6), priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[0], &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[1], &priv->cal_blob->data[1], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[2], &priv->cal_blob->data[2], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[3], sizeof(data));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[4], sizeof(data)));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[5], sizeof(data)));
+
+	/* Initially 6 entries grown to 8 entries overwriting slot 4 */
+	priv->cal_blob = NULL;
+	cs_amp_lib_test_init_dummy_cal_blob(test, 6);
+	KUNIT_ASSERT_EQ(test, 6, priv->cal_blob->count);
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	memcpy(data.calTarget, priv->cal_blob->data[4].calTarget, sizeof(data.calTarget));
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, -1, 8, &data));
+	KUNIT_EXPECT_EQ(test, 8, priv->cal_blob->count);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 8), priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[0], &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[1], &priv->cal_blob->data[1], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[2], &priv->cal_blob->data[2], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[3], &priv->cal_blob->data[3], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[4], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[5], &priv->cal_blob->data[5], sizeof(data));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[6], sizeof(data)));
+	KUNIT_EXPECT_TRUE(test, mem_is_zero(&priv->cal_blob->data[7], sizeof(data)));
+}
+
+static void cs_amp_lib_test_cal_efi_replace_by_uid(struct kunit *test)
+{
+	struct cs_amp_lib_test_priv *priv = test->priv;
+	struct device *dev = &priv->amp_dev->dev;
+	const struct cirrus_amp_efi_data *original_blob;
+	struct cirrus_amp_cal_data data;
+
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->get_efi_variable,
+				   cs_amp_lib_test_get_efi_variable);
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->set_efi_variable,
+				   cs_amp_lib_test_set_efi_variable);
+
+	cs_amp_lib_test_init_dummy_cal_blob(test, 6);
+	KUNIT_ASSERT_EQ(test, 6, priv->cal_blob->count);
+
+	/* Replace entry matching slot 0 */
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	memcpy(data.calTarget, priv->cal_blob->data[0].calTarget, sizeof(data.calTarget));
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, -1, -1, &data));
+	KUNIT_EXPECT_EQ(test, 6, priv->cal_blob->count);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 6), priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[1], &priv->cal_blob->data[1], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[2], &priv->cal_blob->data[2], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[3], &priv->cal_blob->data[3], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[4], &priv->cal_blob->data[4], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[5], &priv->cal_blob->data[5], sizeof(data));
+
+	/* Replace entry matching slot 4 */
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	memcpy(data.calTarget, priv->cal_blob->data[4].calTarget, sizeof(data.calTarget));
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, -1, -1, &data));
+	KUNIT_EXPECT_EQ(test, 6, priv->cal_blob->count);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 6), priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[0], &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[1], &priv->cal_blob->data[1], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[2], &priv->cal_blob->data[2], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[3], &priv->cal_blob->data[3], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[4], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[5], &priv->cal_blob->data[5], sizeof(data));
+
+	/* Replace entry matching slot 3 */
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	memcpy(data.calTarget, priv->cal_blob->data[3].calTarget, sizeof(data.calTarget));
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, -1, -1, &data));
+	KUNIT_EXPECT_EQ(test, 6, priv->cal_blob->count);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 6), priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[0], &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[1], &priv->cal_blob->data[1], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[2], &priv->cal_blob->data[2], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[3], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[4], &priv->cal_blob->data[4], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[5], &priv->cal_blob->data[5], sizeof(data));
+
+	/* Replace entry matching slot 5 */
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	memcpy(data.calTarget, priv->cal_blob->data[5].calTarget, sizeof(data.calTarget));
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, -1, -1, &data));
+	KUNIT_EXPECT_EQ(test, 6, priv->cal_blob->count);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 6), priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[0], &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[1], &priv->cal_blob->data[1], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[2], &priv->cal_blob->data[2], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[3], &priv->cal_blob->data[3], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[4], &priv->cal_blob->data[4], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[5], sizeof(data));
+}
+
+static void cs_amp_lib_test_cal_efi_replace_by_index(struct kunit *test)
+{
+	struct cs_amp_lib_test_priv *priv = test->priv;
+	struct device *dev = &priv->amp_dev->dev;
+	const struct cirrus_amp_efi_data *original_blob;
+	struct cirrus_amp_cal_data data;
+
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->get_efi_variable,
+				   cs_amp_lib_test_get_efi_variable);
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->set_efi_variable,
+				   cs_amp_lib_test_set_efi_variable);
+
+	cs_amp_lib_test_init_dummy_cal_blob(test, 6);
+	KUNIT_ASSERT_EQ(test, 6, priv->cal_blob->count);
+
+	/*
+	 * Replace entry matching slot 0.
+	 * data.calTarget is deliberately set different to current calTarget
+	 * of the slot to check that the index forces that slot to be used.
+	 */
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	data.calTarget[0] = ~priv->cal_blob->data[0].calTarget[0];
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, 0, -1, &data));
+	KUNIT_EXPECT_EQ(test, 6, priv->cal_blob->count);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 6), priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[1], &priv->cal_blob->data[1], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[2], &priv->cal_blob->data[2], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[3], &priv->cal_blob->data[3], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[4], &priv->cal_blob->data[4], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[5], &priv->cal_blob->data[5], sizeof(data));
+
+	/* Replace entry matching slot 4 */
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	data.calTarget[0] = ~priv->cal_blob->data[4].calTarget[0];
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, 4, -1, &data));
+	KUNIT_EXPECT_EQ(test, 6, priv->cal_blob->count);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 6), priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[0], &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[1], &priv->cal_blob->data[1], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[2], &priv->cal_blob->data[2], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[3], &priv->cal_blob->data[3], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[4], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[5], &priv->cal_blob->data[5], sizeof(data));
+
+	/* Replace entry matching slot 3 */
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	data.calTarget[0] = ~priv->cal_blob->data[3].calTarget[0];
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, 3, -1, &data));
+	KUNIT_EXPECT_EQ(test, 6, priv->cal_blob->count);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 6), priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[0], &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[1], &priv->cal_blob->data[1], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[2], &priv->cal_blob->data[2], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[3], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[4], &priv->cal_blob->data[4], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[5], &priv->cal_blob->data[5], sizeof(data));
+
+	/* Replace entry matching slot 5 */
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	data.calTarget[0] = ~priv->cal_blob->data[5].calTarget[0];
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, 5, -1, &data));
+	KUNIT_EXPECT_EQ(test, 6, priv->cal_blob->count);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 6), priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[0], &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[1], &priv->cal_blob->data[1], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[2], &priv->cal_blob->data[2], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[3], &priv->cal_blob->data[3], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[4], &priv->cal_blob->data[4], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[5], sizeof(data));
+}
+
+static void cs_amp_lib_test_cal_efi_deduplicate(struct kunit *test)
+{
+	struct cs_amp_lib_test_priv *priv = test->priv;
+	struct device *dev = &priv->amp_dev->dev;
+	const struct cirrus_amp_efi_data *original_blob;
+	struct cirrus_amp_cal_data data;
+	int i;
+
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->get_efi_variable,
+				   cs_amp_lib_test_get_efi_variable);
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->set_efi_variable,
+				   cs_amp_lib_test_set_efi_variable);
+
+	/*
+	 * Replace entry matching slot 0.
+	 * An active entry in slot 1 for the same UID should be marked empty.
+	 * Other entries are unaltered.
+	 */
+	cs_amp_lib_test_init_dummy_cal_blob(test, 4);
+	KUNIT_ASSERT_EQ(test, 4, priv->cal_blob->count);
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	memcpy(data.calTarget, priv->cal_blob->data[1].calTarget, sizeof(data.calTarget));
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, 0, -1, &data));
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_EQ(test, 0, priv->cal_blob->data[1].calTime[0]);
+	KUNIT_EXPECT_EQ(test, 0, priv->cal_blob->data[1].calTime[1]);
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[2], &priv->cal_blob->data[2], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[3], &priv->cal_blob->data[3], sizeof(data));
+
+	/*
+	 * Replace entry matching slot 1.
+	 * An active entry in slot 0 for the same UID should be marked empty.
+	 * Other entries are unaltered.
+	 */
+	priv->cal_blob = NULL;
+	cs_amp_lib_test_init_dummy_cal_blob(test, 4);
+	KUNIT_ASSERT_EQ(test, 4, priv->cal_blob->count);
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	memcpy(data.calTarget, priv->cal_blob->data[0].calTarget, sizeof(data.calTarget));
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, 1, -1, &data));
+	KUNIT_EXPECT_EQ(test, 0, priv->cal_blob->data[0].calTime[0]);
+	KUNIT_EXPECT_EQ(test, 0, priv->cal_blob->data[0].calTime[1]);
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[1], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[2], &priv->cal_blob->data[2], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[3], &priv->cal_blob->data[3], sizeof(data));
+
+	/*
+	 * Replace entry matching slot 1.
+	 * An active entry in slot 3 for the same UID should be marked empty.
+	 * Other entries are unaltered.
+	 */
+	priv->cal_blob = NULL;
+	cs_amp_lib_test_init_dummy_cal_blob(test, 4);
+	KUNIT_ASSERT_EQ(test, 4, priv->cal_blob->count);
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	memcpy(data.calTarget, priv->cal_blob->data[3].calTarget, sizeof(data.calTarget));
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, 1, -1, &data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[0], &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[1], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[2], &priv->cal_blob->data[2], sizeof(data));
+	KUNIT_EXPECT_EQ(test, 0, priv->cal_blob->data[3].calTime[0]);
+	KUNIT_EXPECT_EQ(test, 0, priv->cal_blob->data[3].calTime[1]);
+
+	/*
+	 * Worst case, all entries have the same UID
+	 */
+	priv->cal_blob = NULL;
+	cs_amp_lib_test_init_dummy_cal_blob(test, 4);
+	KUNIT_ASSERT_EQ(test, 4, priv->cal_blob->count);
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	for (i = 0; i < priv->cal_blob->count; i++) {
+		priv->cal_blob->data[i].calTarget[0] = 0xe5e5e5e5;
+		priv->cal_blob->data[i].calTarget[1] = 0xa7a7a7a7;
+	}
+	memcpy(data.calTarget, priv->cal_blob->data[2].calTarget, sizeof(data.calTarget));
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, 2, -1, &data));
+	KUNIT_EXPECT_EQ(test, 0, priv->cal_blob->data[0].calTime[0]);
+	KUNIT_EXPECT_EQ(test, 0, priv->cal_blob->data[0].calTime[1]);
+	KUNIT_EXPECT_EQ(test, 0, priv->cal_blob->data[1].calTime[0]);
+	KUNIT_EXPECT_EQ(test, 0, priv->cal_blob->data[1].calTime[1]);
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[2], sizeof(data));
+	KUNIT_EXPECT_EQ(test, 0, priv->cal_blob->data[3].calTime[0]);
+	KUNIT_EXPECT_EQ(test, 0, priv->cal_blob->data[3].calTime[1]);
+}
+
+static void cs_amp_lib_test_cal_efi_find_free(struct kunit *test)
+{
+	struct cs_amp_lib_test_priv *priv = test->priv;
+	struct device *dev = &priv->amp_dev->dev;
+	const struct cirrus_amp_efi_data *original_blob;
+	struct cirrus_amp_cal_data data;
+
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->get_efi_variable,
+				   cs_amp_lib_test_get_efi_variable);
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->set_efi_variable,
+				   cs_amp_lib_test_set_efi_variable);
+
+	cs_amp_lib_test_init_dummy_cal_blob(test, 6);
+	KUNIT_ASSERT_EQ(test, 6, priv->cal_blob->count);
+
+	/*
+	 * Slot 0 is empty.
+	 * data.calTarget is set to a value that won't match any existing entry.
+	 */
+	memset(&priv->cal_blob->data[0].calTime, 0, sizeof(priv->cal_blob->data[0].calTime));
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	data.calTarget[0] = 0xaaaaaaaa;
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, -1, -1, &data));
+	KUNIT_EXPECT_EQ(test, 6, priv->cal_blob->count);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 6), priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[1], &priv->cal_blob->data[1], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[2], &priv->cal_blob->data[2], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[3], &priv->cal_blob->data[3], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[4], &priv->cal_blob->data[4], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[5], &priv->cal_blob->data[5], sizeof(data));
+
+	/* Slot 4 is empty */
+	memset(&priv->cal_blob->data[4].calTime, 0, sizeof(priv->cal_blob->data[4].calTime));
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	data.calTarget[0] = 0xaaaaaaaa;
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, -1, -1, &data));
+	KUNIT_EXPECT_EQ(test, 6, priv->cal_blob->count);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 6), priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[0], &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[1], &priv->cal_blob->data[1], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[2], &priv->cal_blob->data[2], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[3], &priv->cal_blob->data[3], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[4], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[5], &priv->cal_blob->data[5], sizeof(data));
+
+	/* Slot 3 is empty */
+	memset(&priv->cal_blob->data[3].calTime, 0, sizeof(priv->cal_blob->data[3].calTime));
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	data.calTarget[0] = 0xaaaaaaaa;
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, -1, -1, &data));
+	KUNIT_EXPECT_EQ(test, 6, priv->cal_blob->count);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 6), priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[0], &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[1], &priv->cal_blob->data[1], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[2], &priv->cal_blob->data[2], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[3], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[4], &priv->cal_blob->data[4], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[5], &priv->cal_blob->data[5], sizeof(data));
+
+	/* Replace entry matching slot 5 */
+	memset(&priv->cal_blob->data[5].calTime, 0, sizeof(priv->cal_blob->data[5].calTime));
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	data.calTarget[0] = 0xaaaaaaaa;
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, -1, -1, &data));
+	KUNIT_EXPECT_EQ(test, 6, priv->cal_blob->count);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 6), priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[0], &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[1], &priv->cal_blob->data[1], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[2], &priv->cal_blob->data[2], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[3], &priv->cal_blob->data[3], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[4], &priv->cal_blob->data[4], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[5], sizeof(data));
+}
+
+static void cs_amp_lib_test_cal_efi_bad_cal_target(struct kunit *test)
+{
+	struct cs_amp_lib_test_priv *priv = test->priv;
+	struct device *dev = &priv->amp_dev->dev;
+	struct cirrus_amp_cal_data data;
+
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->get_efi_variable,
+				   cs_amp_lib_test_get_efi_variable);
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->set_efi_variable,
+				   cs_amp_lib_test_set_efi_variable);
+
+	cs_amp_lib_test_init_dummy_cal_blob(test, 4);
+
+	/* Zero calTarget is illegal */
+	get_random_bytes(&data, sizeof(data));
+	memset(data.calTarget, 0, sizeof(data.calTarget));
+	KUNIT_EXPECT_LT(test, cs_amp_set_efi_calibration_data(dev, -1, -1, &data), 0);
+	KUNIT_EXPECT_LT(test, cs_amp_set_efi_calibration_data(dev, 0, -1, &data), 0);
+	KUNIT_EXPECT_LT(test, cs_amp_set_efi_calibration_data(dev, 0, 2, &data), 0);
+}
+
+static void cs_amp_lib_test_cal_efi_write_denied(struct kunit *test)
+{
+	struct cs_amp_lib_test_priv *priv = test->priv;
+	struct device *dev = &priv->amp_dev->dev;
+	const struct cirrus_amp_efi_data *original_blob;
+	struct cirrus_amp_cal_data data;
+
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->get_efi_variable,
+				   cs_amp_lib_test_get_efi_variable);
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->set_efi_variable,
+				   cs_amp_lib_test_set_efi_variable_denied);
+
+	cs_amp_lib_test_init_dummy_cal_blob(test, 4);
+	KUNIT_ASSERT_EQ(test, 4, priv->cal_blob->count);
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+
+	/* Unspecified slot */
+	KUNIT_EXPECT_LT(test, cs_amp_set_efi_calibration_data(dev, -1, -1, &data), 0);
+	KUNIT_EXPECT_MEMEQ(test, original_blob, priv->cal_blob, original_blob->size);
+
+	/* Unspecified slot with size */
+	KUNIT_EXPECT_LT(test, cs_amp_set_efi_calibration_data(dev, -1, 6, &data), 0);
+	KUNIT_EXPECT_MEMEQ(test, original_blob, priv->cal_blob, original_blob->size);
+
+	/* Specified slot */
+	KUNIT_EXPECT_LT(test, cs_amp_set_efi_calibration_data(dev, 1, -1, &data), 0);
+	KUNIT_EXPECT_MEMEQ(test, original_blob, priv->cal_blob, original_blob->size);
+
+	/* Specified slot with size */
+	KUNIT_EXPECT_LT(test, cs_amp_set_efi_calibration_data(dev, 1, 6, &data), 0);
+	KUNIT_EXPECT_MEMEQ(test, original_blob, priv->cal_blob, original_blob->size);
+}
+
+static void cs_amp_lib_test_cal_efi_attr_preserved(struct kunit *test)
+{
+	struct cs_amp_lib_test_priv *priv = test->priv;
+	struct device *dev = &priv->amp_dev->dev;
+	struct cirrus_amp_cal_data data;
+
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->get_efi_variable,
+				   cs_amp_lib_test_get_efi_variable);
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->set_efi_variable,
+				   cs_amp_lib_test_set_efi_variable);
+
+	cs_amp_lib_test_init_dummy_cal_blob(test, 6);
+	KUNIT_ASSERT_EQ(test, 6, priv->cal_blob->count);
+	memset(&priv->cal_blob->data[0], 0, sizeof(priv->cal_blob->data[0]));
+	get_random_bytes(&data, sizeof(data));
+
+	/* Set a non-standard attr to return from get_efi_variable() */
+	priv->efi_attr = EFI_VARIABLE_HARDWARE_ERROR_RECORD;
+
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, -1, -1, &data));
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_EQ(test, priv->efi_attr, EFI_VARIABLE_HARDWARE_ERROR_RECORD);
+}
+
+static efi_status_t cs_amp_lib_test_set_hp_efi_cal_variable(efi_char16_t *name,
+							    efi_guid_t *guid,
+							    u32 attr,
+							    unsigned long size,
+							    void *buf)
+{
+	static const efi_char16_t expected_name[] = HP_CALIBRATION_EFI_NAME;
+	static const efi_guid_t expected_guid = HP_CALIBRATION_EFI_GUID;
+	struct kunit *test = kunit_get_current_test();
+	struct cs_amp_lib_test_priv *priv = test->priv;
+
+	KUNIT_ASSERT_NOT_NULL(test, name);
+	KUNIT_ASSERT_NOT_NULL(test, guid);
+
+	if (memcmp(name, expected_name, sizeof(expected_name)) ||
+	    efi_guidcmp(*guid, expected_guid))
+		return -EFI_ACCESS_DENIED;
+
+	KUNIT_ASSERT_NOT_NULL(test, buf);
+	KUNIT_ASSERT_NE(test, 0, size);
+
+	kunit_kfree(test, priv->cal_blob);
+	priv->cal_blob = kunit_kmalloc(test, size, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, priv->cal_blob);
+	memcpy(priv->cal_blob, buf, size);
+	priv->efi_attr = attr;
+
+	return EFI_SUCCESS;
+}
+
+/*
+ * If the HP EFI exists it should be the one that is updated.
+ */
+static void cs_amp_lib_test_cal_efi_update_hp(struct kunit *test)
+{
+	struct cs_amp_lib_test_priv *priv = test->priv;
+	struct device *dev = &priv->amp_dev->dev;
+	const struct cirrus_amp_efi_data *original_blob;
+	struct cirrus_amp_cal_data data;
+
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->get_efi_variable,
+				   cs_amp_lib_test_get_hp_cal_efi_variable);
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->set_efi_variable,
+				   cs_amp_lib_test_set_hp_efi_cal_variable);
+
+	cs_amp_lib_test_init_dummy_cal_blob(test, 6);
+	KUNIT_ASSERT_EQ(test, 6, priv->cal_blob->count);
+
+	/* Replace entry matching slot 4 */
+	original_blob = cs_amp_lib_test_cal_blob_dup(test);
+	get_random_bytes(&data, sizeof(data));
+	data.calTarget[0] = ~priv->cal_blob->data[4].calTarget[0];
+	KUNIT_EXPECT_EQ(test, 0, cs_amp_set_efi_calibration_data(dev, 4, -1, &data));
+	KUNIT_EXPECT_EQ(test, 6, priv->cal_blob->count);
+	KUNIT_EXPECT_EQ(test, struct_size(priv->cal_blob, data, 6), priv->cal_blob->size);
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[0], &priv->cal_blob->data[0], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[1], &priv->cal_blob->data[1], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[2], &priv->cal_blob->data[2], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[3], &priv->cal_blob->data[3], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &data, &priv->cal_blob->data[4], sizeof(data));
+	KUNIT_EXPECT_MEMEQ(test, &original_blob->data[5], &priv->cal_blob->data[5], sizeof(data));
+}
+
 static void cs_amp_lib_test_spkid_lenovo_not_present(struct kunit *test)
 {
 	struct cs_amp_lib_test_priv *priv = test->priv;
@@ -1073,6 +2434,28 @@ static struct kunit_case cs_amp_lib_test_cases[] = {
 	KUNIT_CASE(cs_amp_lib_test_read_cal_data_test),
 	KUNIT_CASE(cs_amp_lib_test_write_ambient_test),
 
+	/* Test cases for writing cal data to UEFI */
+	KUNIT_CASE(cs_amp_lib_test_create_new_cal_efi),
+	KUNIT_CASE(cs_amp_lib_test_create_new_cal_efi_indexed),
+	KUNIT_CASE(cs_amp_lib_test_create_new_cal_efi_indexed_no_max),
+	KUNIT_CASE(cs_amp_lib_test_cal_efi_all_zeros_add_first),
+	KUNIT_CASE(cs_amp_lib_test_cal_efi_all_zeros_add_first_no_shrink),
+	KUNIT_CASE(cs_amp_lib_test_cal_efi_all_zeros_add_first_indexed),
+	KUNIT_CASE(cs_amp_lib_test_cal_efi_all_zeros_add_first_indexed_no_shrink),
+	KUNIT_CASE(cs_amp_lib_test_grow_append_cal_efi),
+	KUNIT_CASE(cs_amp_lib_test_grow_append_cal_efi_indexed),
+	KUNIT_CASE(cs_amp_lib_test_grow_append_cal_efi_indexed_no_max),
+	KUNIT_CASE(cs_amp_lib_test_grow_cal_efi_replace_indexed),
+	KUNIT_CASE(cs_amp_lib_test_grow_cal_efi_replace_by_uid),
+	KUNIT_CASE(cs_amp_lib_test_cal_efi_replace_by_uid),
+	KUNIT_CASE(cs_amp_lib_test_cal_efi_replace_by_index),
+	KUNIT_CASE(cs_amp_lib_test_cal_efi_deduplicate),
+	KUNIT_CASE(cs_amp_lib_test_cal_efi_find_free),
+	KUNIT_CASE(cs_amp_lib_test_cal_efi_bad_cal_target),
+	KUNIT_CASE(cs_amp_lib_test_cal_efi_write_denied),
+	KUNIT_CASE(cs_amp_lib_test_cal_efi_attr_preserved),
+	KUNIT_CASE(cs_amp_lib_test_cal_efi_update_hp),
+
 	/* Test cases for speaker ID */
 	KUNIT_CASE(cs_amp_lib_test_spkid_lenovo_not_present),
 	KUNIT_CASE(cs_amp_lib_test_spkid_lenovo_d0),
diff --git a/sound/soc/codecs/cs-amp-lib.c b/sound/soc/codecs/cs-amp-lib.c
index 3f352ecad3e0..1c53328d7165 100644
--- a/sound/soc/codecs/cs-amp-lib.c
+++ b/sound/soc/codecs/cs-amp-lib.c
@@ -701,6 +701,7 @@ EXPORT_SYMBOL_NS_GPL(cs_amp_get_vendor_spkid, "SND_SOC_CS_AMP_LIB");
 
 static const struct cs_amp_test_hooks cs_amp_test_hook_ptrs = {
 	.get_efi_variable = cs_amp_get_efi_variable,
+	.set_efi_variable = cs_amp_set_efi_variable,
 	.write_cal_coeff = cs_amp_write_cal_coeff,
 	.read_cal_coeff = cs_amp_read_cal_coeff,
 };
-- 
2.47.3


