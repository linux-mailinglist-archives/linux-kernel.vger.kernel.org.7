Return-Path: <linux-kernel+bounces-856015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35657BE2E16
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 12:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E124842465C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 10:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D082FD1CC;
	Thu, 16 Oct 2025 10:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="I3s/MHVL";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="bbEdKqwY"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0ED2E0903;
	Thu, 16 Oct 2025 10:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760611376; cv=fail; b=icigatTMb8QMfmqRQKW1vJCG6XT1zvSkT5V1k1Hzc1PJdME+QHnSqyhKcDqpcjsY9f9kyG2ZTr4meZtKd22uyA8nAuaxWlvZ+0BqN/479MiwxObyE/D/e2wXgtDwUL3ExZad2x+ly9MOYkRe3bVlK76l/yNzPDloTsEXGezZWuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760611376; c=relaxed/simple;
	bh=K/J3XJT94T82s03iJ/QH5gpJFMQXerlCHOxZSOOvAfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S8VDF8KgadtOny0yAPbGyRJZNIiRPvk9JlTMoZIm+nBjIRVGzY2RzRzdBfYs/zNUZruJzeMxCybwoMlYiekDlF3XIJuEk9D6Z4H7CCsgtNme/nF+9YF+ImT+pJitcOtlIXFsfOFgzlg/y7lz2z8llwiqeZHoKAQOFeFjEJ6fbQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=I3s/MHVL; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=bbEdKqwY; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59FMZLZq298642;
	Thu, 16 Oct 2025 05:42:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=EAMpaSaykDg6ZoklSruubmoRVXxchE5oR6kMFo2sseY=; b=
	I3s/MHVLyXv770SApBOvOVxnHpkiecdMkget7uKi2zUPEimDueg7gSasWBkjENVS
	bImGlTu7I43RuP/0pFHTvZKO0c4ojnsFnRXMtFeVGi9e9ZOQqv+kWp3JrAQ+8kA1
	j+5B4lIPr19YYJiy1q0mGf1wUsrSD0pw7J1mzaiR/cwcVGz4z6KuwDiviA20HXQD
	a+AgUYpQVf+dz39eiPE3O2VOipsy4TQZbcnOTt0PCHwdWNqlv3hMEUl7uqnwDwHF
	cWRUb1O2lG4QRCYT8fHnS4+OHNc2X4JuecWQFahONNvRMGRpmY/K+m225yCvqRXc
	fLiSx+DFnTsZUKr6sWPrPA==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11022097.outbound.protection.outlook.com [52.101.43.97])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 49t9mhhpx0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 05:42:50 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H4VNKxwo+i2AgvgQSAxeQW3GblTljD6o0IfW721nfTEW5ROm6tQ1vlcmUrgyEH7jMKyEoL2ZIkWCcJ6t3vWt0BWK52T50sRfhrTaFf4GVO/g3RFvM1U/QNbYQrmUpjNcFKm8j1R2cHORmClQLtmSW9J9+Zr2r4HDorXg+FF0n/OlDv+AY3gzPX/0Tvxnfv8C/0DXe76KJBie2odsjH91DkssHEIXSMoCVKzUlhchSBgNcMmOypIi01cwMbIE111qjsuMFWwsJJXUihFKHg0PjJ8OJpdo6KfAdrEKNy73dCUVqWT6ALmSK15A+IIEPDuA2KbIE2tJZysNKB/5ldvuhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EAMpaSaykDg6ZoklSruubmoRVXxchE5oR6kMFo2sseY=;
 b=CQ9rk8pQovb8/VAYfC60P9D98RCqhZAaMKlVIEQxZKlUf3d+yOQbmVSGiWRsNkrU929Ts4II2UBzps7aAn/f0e5vMOCp/muqy9Ta4YwepykQgYs4tYYEvKtIlMwkOnBwkTxnGrlUFSi6sy6L8TEsKROnsM5Pv4ZZ+SEarryO0i7WpnpH4kefecSGvghn2PgStWseV4q7r3qPjZqRBh56gGuVXNami/F8n1UNrfIQPXMdKHUct5BXViCV8OeH7kPKLoBK8wA8RoriEXcJEWGdmiYMTc1td//VgO7fvEkFY7UMrVasicBs6BpXeRo2RtWsxQ0s0PHaKWVhW+aqa6FutA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EAMpaSaykDg6ZoklSruubmoRVXxchE5oR6kMFo2sseY=;
 b=bbEdKqwYO2ELL4xzs0foRqbvdHU0I/oBp3VFHnE83F0DjA7JFlADwXmxdZvB3hK/NLvgzXlJANX3aa1ddk6uA6cCxnp37RpdujqPFI7hEfQeig3tI3u9JpKPXTbAupDg4dw9+g08WYAHOKs6XsoZji+D7vR3g0Q0WakcgUnmG1Y=
Received: from MN2PR03CA0024.namprd03.prod.outlook.com (2603:10b6:208:23a::29)
 by IA3PR19MB8705.namprd19.prod.outlook.com (2603:10b6:208:528::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 10:42:46 +0000
Received: from MN1PEPF0000F0E1.namprd04.prod.outlook.com
 (2603:10b6:208:23a:cafe::73) by MN2PR03CA0024.outlook.office365.com
 (2603:10b6:208:23a::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.12 via Frontend Transport; Thu,
 16 Oct 2025 10:42:46 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 MN1PEPF0000F0E1.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Thu, 16 Oct 2025 10:42:45 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 120D8406569;
	Thu, 16 Oct 2025 10:42:43 +0000 (UTC)
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id EA8AC822541;
	Thu, 16 Oct 2025 10:42:42 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: broonie@kernel.org, tiwai@suse.com
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: [PATCH 09/11] ASoC: cs35l56: Add calibration command to store into UEFI
Date: Thu, 16 Oct 2025 11:42:40 +0100
Message-ID: <20251016104242.157325-10-rf@opensource.cirrus.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E1:EE_|IA3PR19MB8705:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b20c1af0-724e-47d7-7127-08de0ca0be57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YH5KLe3g2KlqzhPXdncdwKgHRqa4ZH52jZa8kdsRJgMd98iKkwcxvxfWo3BH?=
 =?us-ascii?Q?k+8sdnn1r+BczExQM0YKSRxTAmoq0DnAFUkIeyaoBgceQjvIJ3g1SZS6u/ci?=
 =?us-ascii?Q?Zxedh+lh9aYebDB/C72pm3NGtU8jLZL25ad135xBgx6dcSrxFYZIP2TatUCm?=
 =?us-ascii?Q?UoL3WSGgGgnt86xQsL/Qgz8B+eLvbRlqgFvvgTOJS3zHQbWqcrVvUYLwzURb?=
 =?us-ascii?Q?49NNf9/OYG0jXa3Z7YMI6ZDR/5W0LRksxx0vCjjDeCjCpVVR/JZ7Ct1MSwKg?=
 =?us-ascii?Q?NqIvf39UFp5/Gk5o2ejkjUAiOIt1mZTh4VT60VvHEfscyyRMr+bz1hY00N8w?=
 =?us-ascii?Q?mcYIBThGctUlcKBpyUPv/pQyLDDkIsquPsFjn8QWj958uid4xKLZd4/dH6lB?=
 =?us-ascii?Q?e3YCXyiYq4wZHLetw64S3xc1mApHfXk9uR00TDgFnOo/FPClsP4hCuRGImxR?=
 =?us-ascii?Q?CLkYz8wBbhaOHHJ2WKF53TLi9Y1QN/43/sMBE9/XjAGtllCz2WQGn72Yv32f?=
 =?us-ascii?Q?osxxlAoItwUpKHyu3w2dP7vy0ESHzvJC4DyrhrV074TATAFYYKni6SQePonT?=
 =?us-ascii?Q?yp4yCCT0ACMdcKUB89BnvBEiun5wzK/6vuxNQz9vINpf4BYUQuXa5TIV7PEK?=
 =?us-ascii?Q?eQR9m7HvACDUi7Q1LXBOYnF6q/mQISfvSJQlmG3rbahAOdFssn2Xlor2rsIf?=
 =?us-ascii?Q?/xDeDCUr/X0NOK8wiaPURN0qeKT+SGmUSq4E6kn1x0GQN5c8vQ5qWPfpyIjt?=
 =?us-ascii?Q?5+jykh6MUNFVzJ+hPRpRm9qHxoGA9TR6ebaz2RPbLBuAy8hybfy3778KliNM?=
 =?us-ascii?Q?SudkJXTWmEWho7lNjqH/Ck1Iuntqj5Pzmd2enhIm9cATxok31KnKqUqL5HFK?=
 =?us-ascii?Q?To7ekdq6Ji7t4n4oQIz5+YwY8t0YGshGaUuCm/2NfdnQigz3fIUzo0fcWeXL?=
 =?us-ascii?Q?KudnpTAFamw9MkOb83KU2HRoSUeMVFw+YCP34u8ERFqtPtsgpzjk4+SCFsP7?=
 =?us-ascii?Q?3xVwlB839Wbst69yV/3bv4HAuCv2Ew6BHN6PuMRuJtbFKkQflkIpc60+HyGX?=
 =?us-ascii?Q?Pwr6AnUFWqH6IGAfEF4g76YHiwJ8aqiUkRt/VOjNvx27I1m1yJlAt+Z133zp?=
 =?us-ascii?Q?24DWU5OPJjkq0ayqCsnRpapndOQOvYE5AvwndfkeACOSOxaKfcA9VAFApo1u?=
 =?us-ascii?Q?uKEGTtIkR3qoXZhkFHWf3Msv+a1kkF7JesXht74nce3E5L7FmqSGDLWggEjh?=
 =?us-ascii?Q?fupvKRvudtO2KLJ/NfXj1uffRsUEcOaWSCuU9RZ9oPtTJxGZAeqlzYLQCW1r?=
 =?us-ascii?Q?8AMhjcKZJu9SBzX955aJh60o8Es2nxwdZwNIxJONqVNAjAIWWQBkgZQKThEe?=
 =?us-ascii?Q?sV4b28NwcCuKw0EjkRUB7Dh8IP0+NUiV2UHN70wYIhCF1cJCYg2+kLU7RD8n?=
 =?us-ascii?Q?ZE1YDrv6Oz2rgXZxbZ2ipzgRL6ScsWVSsFazuruIy/5sLkgZ9QE1hS7EN8RM?=
 =?us-ascii?Q?jnay8p8eTsr5jx1pxrL/tPa7qObc0eFUrvT3v3viMv8jdpG/z7Hw1oj1CYyj?=
 =?us-ascii?Q?kBjR+x3BOlDlJU5c61M=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 10:42:45.8816
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b20c1af0-724e-47d7-7127-08de0ca0be57
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MN1PEPF0000F0E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR19MB8705
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDA4MCBTYWx0ZWRfX2cu++q75kYe7
 USwKopgWI1l9i8kOUg/PRiIo9W+PtXynBeOn9oTiXx90wAttwVa37c+fDy9LkAO//KLK6jVq89r
 Z4+3lqbGCR6IoAVYSZ1X6O85BXFBRDBr+qR68yzd6mSga5GwtrmT05yQH3835XZH2EiXwjLaexq
 XYmBGExuJsdaj36MYLiahRclirHhfoPZXnIz2yUWoG6uPPuyVCQuL8CF3CdaAGcKHEBL2H2el5C
 jnengM/NGluAf5vxZ0QXU7Rs0341aupBXeR0blz5Qyx1WjhbgaFvV/nxySRmDDMpHfZTvbgr9wE
 K92ShA5ywDAY8L9LEDXiqWJXT83zm0VDyDwCBE+RmAulADH120507CftJ/W8U3NFIfCdUrLHE6a
 eug2p9/D3L92Q8S03WuFC/g9XKb2gA==
X-Proofpoint-ORIG-GUID: h5lDUkZ61hF24To5Qi2j-ZJRn8E2OFJo
X-Authority-Analysis: v=2.4 cv=OJIqHCaB c=1 sm=1 tr=0 ts=68f0cc2a cx=c_pps
 a=V6sUqnxsgDMRanywjcdTsw==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=8cExK4-QNj-zMObyTR0A:9
X-Proofpoint-GUID: h5lDUkZ61hF24To5Qi2j-ZJRn8E2OFJo
X-Proofpoint-Spam-Reason: safe

Add a new command 'store_uefi' to the calibrate sysfs file.
Writing this command will call cs_amp_set_efi_calibration_data()
to save the new data into an EFI variable. This is intended to
be used after a successful factory calibration to save the data
into EFI.

On systems without EFI it will return an error.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 include/sound/cs35l56.h           |  1 +
 sound/soc/codecs/cs35l56-shared.c | 19 +++++++++++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/include/sound/cs35l56.h b/include/sound/cs35l56.h
index 4ed738615021..b3770285261c 100644
--- a/include/sound/cs35l56.h
+++ b/include/sound/cs35l56.h
@@ -314,6 +314,7 @@ struct cs35l56_base {
 	bool can_hibernate;
 	bool cal_data_valid;
 	s8 cal_index;
+	u8 num_amps;
 	struct cirrus_amp_cal_data cal_data;
 	struct gpio_desc *reset_gpio;
 	struct cs35l56_spi_payload *spi_payload_buf;
diff --git a/sound/soc/codecs/cs35l56-shared.c b/sound/soc/codecs/cs35l56-shared.c
index dc6e49e3421a..27fb2f9b83c5 100644
--- a/sound/soc/codecs/cs35l56-shared.c
+++ b/sound/soc/codecs/cs35l56-shared.c
@@ -1101,8 +1101,8 @@ static int cs35l56_perform_calibration(struct cs35l56_base *cs35l56_base)
 ssize_t cs35l56_calibrate_sysfs_store(struct cs35l56_base *cs35l56_base,
 				      const char *buf, size_t count)
 {
-	static const char * const options[] = { "factory" };
-	int ret;
+	static const char * const options[] = { "factory", "store_uefi" };
+	int num_amps, ret;
 
 	if (!IS_ENABLED(CONFIG_SND_SOC_CS35L56_CAL_SYSFS_COMMON))
 		return -ENXIO;
@@ -1113,6 +1113,21 @@ ssize_t cs35l56_calibrate_sysfs_store(struct cs35l56_base *cs35l56_base,
 		if (ret < 0)
 			return ret;
 		break;
+	case 1:
+		if (!cs35l56_base->cal_data_valid)
+			return -ENODATA;
+
+		num_amps = cs35l56_base->num_amps;
+		if (num_amps == 0)
+			num_amps = -1;
+
+		ret = cs_amp_set_efi_calibration_data(cs35l56_base->dev,
+						      cs35l56_base->cal_index,
+						      num_amps,
+						      &cs35l56_base->cal_data);
+		if (ret < 0)
+			return ret;
+		break;
 	default:
 		return -ENXIO;
 	}
-- 
2.47.3


