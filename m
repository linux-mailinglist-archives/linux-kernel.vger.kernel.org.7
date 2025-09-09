Return-Path: <linux-kernel+bounces-808006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD67BB4AC0B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D06A21B24593
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C3A322554;
	Tue,  9 Sep 2025 11:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="nEHM6SEQ";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="VH2NN3ll"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B22D31B832;
	Tue,  9 Sep 2025 11:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757417454; cv=fail; b=HI+uFy0BeihilpxRBRQ28mct6psUYnhz6/vga15STDN2o9nOQUS1gJxRdyHNBfid23KS5mNanhxtrgjgZl8Aqqdj74PB79Mkard9ArydZyD3ScvfMnDX4YDtPILULo6volv6qQoDosfowS+/Bw9PdLrQeB6kGknD6XEklG+s9NE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757417454; c=relaxed/simple;
	bh=Fk/a1g+io6oCMJJhpgA9T5RQsVgVkoIlfN9T5kxfpP4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FSAMlocNSkrgqrz2GLk1b5EiwNiNCwIHIq5LqgKsC2/+VeN6vi2JCex+S3enhrmTmz+yyhsD+RqmfRBY2muwc8wR/298VPLLLI4JRyNSSCg6K3dmDN8qUyM0S8/y0jp9ejTBXbVqAp0AnS9f3wxkLCkFadMu1iWcyKV7KLCX1tw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=nEHM6SEQ; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=VH2NN3ll; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 588KT8Pg3358403;
	Tue, 9 Sep 2025 06:30:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=APpcDRBfdcj4G2DWvBwtmFIgJYnpYz7AKZvkufUY1mI=; b=
	nEHM6SEQJgLzLXwoCBWWJCgNqaLnLE81wQboXkII0pUzIoORSRlHNIQlhI1Bm1xs
	/625zy6ci9MM+eGs9CbW6aWTyn9gw5cDM0QNjyt+VRoENyacmqoymzkpNTGqk9rP
	m5i2CEMukwwMmNmyRVyO9Ms7KJ0cLu3b3/YCHIezqDlcKqp088LbCMsQCKJq2L0d
	muZ+zZLfm/TtkKdci3jDWuIjDP84WvH/Yab9JoRygeY+VX9LBHOAVCXhE6d9AjzO
	k+mG+odde3v8ZrgX92mtZpt3g1l3uW8ntTOa7jfISMvMe8/cxAd678rsRkhLBx4A
	rfjbNDMri/hqF9dq0m2epA==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2110.outbound.protection.outlook.com [40.107.93.110])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 491upq9k40-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 06:30:47 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m611tdOZSI1Lh1k0iEFP4K6tflASz6C+gRbrJpA1ypw64LjEO+W0Zvm4rh8z53OAx4W6qH+ZF7oHT45mwLOeMPBS2n8IpdGaEnkVXg/8OsjCiApA4qKIKSS1A2It9CNZVPbKbLewGHjQ86aaqQHdVNzZnuSQ/J2Fk2fP58wnDTuGeuYJ5SuINeSMrVFeesVrYSRthGNmxksTxcLc5rmUQT6WQY5yvXFcD/ZJy4e3hUAMTAC5BYRrZNkt+s0rLi8gz3JAvXHv+Livpos4KWS/8R2n8Ig5I9faoWxQLQBZwPt2H9/pGhWYWPl4ul474hVqhmdTnTAx7lBUTiYlXeecuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=APpcDRBfdcj4G2DWvBwtmFIgJYnpYz7AKZvkufUY1mI=;
 b=GAveiGIaFEsmyF5ue8vADrzSES4gPgo5Og39nmraSxeiX6PUQuCo/wNcuWxFOfrj3ptY4hNaP6UqH1GtvnrUd3OYEUYQmncjX7uhdDW0J5P3K8iTtVvbRntrp3Bx2MAV7lA5Jnvetprs9WSAWRMjGiGxPoGK6BBTnW+4vSZIeGqGBo5npuzJ+LXB9nIjFTM7Y6g9vM0Dx34sYrLBMzLIMa4u8menWbdqk3Oi5zdgoK3C34Ta8cnVSTAwgwujIkTWTImUtdILq8NRUrvftUxJGWjYitKifced51CVhuG43lm5Fk8FM5A4sXA/ZvkHe+AFaMipq9lMlqtE0R1nqYKK3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=APpcDRBfdcj4G2DWvBwtmFIgJYnpYz7AKZvkufUY1mI=;
 b=VH2NN3llD2zuWP3z/9wZTg2HB3SHHJ+hpXxu1yBZ1Jk7xWhJugC82HZwTEvTQQj7m8RM7R5XM883eYTryN0cRCPLayC93rXA3yviAWb6TuRhH0swRA6GO5lD9K5fxWmyrgmAX0NeMrlELA5XnVh7YCNwdXGnCviUtlroVG9r16Q=
Received: from SJ0PR13CA0044.namprd13.prod.outlook.com (2603:10b6:a03:2c2::19)
 by BY5PR19MB4727.namprd19.prod.outlook.com (2603:10b6:a03:1d8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 11:30:44 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::3f) by SJ0PR13CA0044.outlook.office365.com
 (2603:10b6:a03:2c2::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.13 via Frontend Transport; Tue,
 9 Sep 2025 11:30:09 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.13
 via Frontend Transport; Tue, 9 Sep 2025 11:30:42 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 371EC406545;
	Tue,  9 Sep 2025 11:30:40 +0000 (UTC)
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 2281782026B;
	Tue,  9 Sep 2025 11:30:40 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: broonie@kernel.org
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: [PATCH v2 2/6] ASoC: cs-amp-lib: Add handling for Lenovo and HP UEFI speaker ID
Date: Tue,  9 Sep 2025 12:30:35 +0100
Message-Id: <20250909113039.922065-3-rf@opensource.cirrus.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|BY5PR19MB4727:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 36877050-2ba8-413d-d2e5-08ddef944f7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|61400799027;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tF1HhKdjlFwd3PxIKjvqESUx9klwLJnx4PKODjvkCldcZ+pzPzH4CgvPoHW3?=
 =?us-ascii?Q?FcM6CekVqCbeUTtzTdfMq7AWp/lBCbNlxEc1dtkD+Rn07iRrj9Fcy8o8mNl1?=
 =?us-ascii?Q?jroGEJUMC6Bp+Q8F+ZDr3ClmOZ7VIlQcEI2fxDHnvSIeagRZD5LrsXclPNuo?=
 =?us-ascii?Q?lN4+EPAANCH50pdPHJZJY6Xb/h+9DcZRGzV7wZDeMXKzV3kg4MYPN8tqpnY8?=
 =?us-ascii?Q?/w4OvyRbWzpXyUOrGhFtlSTDaisSdXK8kdhaycAuw0REQHScGSPawIGNhIKT?=
 =?us-ascii?Q?ubQra8lhypDlrZQ2kFLVgXlRQ0SkVGDBdWB/CC0lJYg2rRokVI83KdQvPln3?=
 =?us-ascii?Q?Jpkr+mdWoKkK8vsHyZc8mSNjUScguAGACLqTOxV/QnqbtPBEPigh0tDJuy+O?=
 =?us-ascii?Q?mgh3ijJX4DG9enPe4bgC7UBlNuDR5VL1lkiwb+32pwHCGj2nABQUddTsLN02?=
 =?us-ascii?Q?mNQkZXqQw6UxzfAqpu+OggmNJTCNypQXVDf15OnkENi5L633LcRBr4huJ293?=
 =?us-ascii?Q?KkDysO0oHoBnLFkztxnkNYaJ3HZViaPwpWFukn45Sge8SmbYbZO81VBH1rEg?=
 =?us-ascii?Q?SomdYvzQownngx/1eZD/dAKNOZmKD4IG9l/arC1nll2ekkeM38SYtGehpd/7?=
 =?us-ascii?Q?Hj3ewIvvXaINzzhJjNMOeTUbHsZ4EjaWH0k5Q0xpwBo3STR15CFZDQdzjcye?=
 =?us-ascii?Q?ih3SsbpQqi/3sS+8MAZq/d+nXsvro1t39RSCS7+O5v8BS1DfB/lFShwvSg4H?=
 =?us-ascii?Q?GdbUgaEwy83sHmGutw9y8anCeQA5HonSOW09CAavEmWSrW/t9DCOE9MntOBm?=
 =?us-ascii?Q?NV0tt4f9n/FzlfZ1eK4jjwDBlxbnzbXpyC5X+TRACIerzgOGfSzHMP4gw84x?=
 =?us-ascii?Q?Epfz65Yjz70C3+Rn2GVMEo9qht/XvANLzTCHujNvlNpe0T+dhnjAUYY8ndQv?=
 =?us-ascii?Q?d2/1s/8RG4/YSHe54lys+vwxc7qwNpaJDElOJf07G3/pff/rgZ9fIeBYfCKp?=
 =?us-ascii?Q?bRMdFY+XvGs1D5CcBcOn8FLeAZuVj9JJYLvPk0flW4IVzOvdE5M/F5FPAiVm?=
 =?us-ascii?Q?wD2/XFLUX5I8hfHSZ4jJdFP+Pr8veGBSdX/2Wej+0fGD88UVWYGnzkFVV24E?=
 =?us-ascii?Q?JboUtVh2BqjFjqv7KC5a61UGdOcm9ircDNH9mYqKOINIJjUciGaOrKDRquXz?=
 =?us-ascii?Q?TksJR+4QEwDoWW1WdtJ6g3vkXx7mZ++EbiIi2VnHE3V1ejoDfaEgfTWzR0HN?=
 =?us-ascii?Q?2Mdnc8KgDJQqonz2dGLnA/rP3EyuksflBxInko6mC6JrBZHb4NYT9iF8mZlr?=
 =?us-ascii?Q?1p0ed7NMXCxUQt3wpnoASZI4ifIVBMqZW9DigPgd9FLPjgNLs7OJbn4RaVYs?=
 =?us-ascii?Q?unMCMXD4sUhnxlxljEHIE8Yw+LyXtji0GqLCDWJIYqJ/vQhhUe93/6EVCbuZ?=
 =?us-ascii?Q?EYB9WlD5SL9eWb46MQJig4fUGYy23tsahJ6tjm7JGfjcu5MPFezHIZVMQh8H?=
 =?us-ascii?Q?N8ndcPrlThZ9VVDy/r6WMoNKOigYfmSUIcex?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(61400799027);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 11:30:42.0863
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36877050-2ba8-413d-d2e5-08ddef944f7c
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR19MB4727
X-Authority-Analysis: v=2.4 cv=DMuP4zNb c=1 sm=1 tr=0 ts=68c00fe7 cx=c_pps
 a=U9uK1XeW/XbPQ+xGwlJMPA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=yJojWOMRYYMA:10 a=RWc_ulEos4gA:10 a=w1d2syhTAAAA:8 a=wKYcr39KdBWZLYmsaBcA:9
X-Proofpoint-GUID: fCzE5SU7C3q6yQfLTIpgvaaz3TF4KNQs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA5MDExNCBTYWx0ZWRfX8+m0+EOwgZj8
 xZFJOZ2Mbhj6EBrT9tOeljRhk0dUCRHm9deZfpZrYN0RW+9LMHBVqNUEOyS0tjMsA0n+HMY6RZR
 +/xAd51KyW4kMG+PTiBrUo3+nKmzxn1ndZFmUhaqTVeP5u5ayuApfOMbmwBwHSU4HX+O7iGrJwZ
 XNkBLMB/GQq77Of4fCIxc4gJAslxxGcqLZCxT0qoKmEjt76xHQ3fKsFHVMRTEHIjVCLX9eZN//Y
 ZNuoiJ+4MeCGSKJhnXxE54XDFAq1pjDFYj5PrOxRs0EXONeRYXtiCAnzoTu2dBi9ZCoLA0DQKPB
 yt5BXNW4/BVcVZsKYkmgX97vXQAjrVWnkwy/9L70BrjZHjIeDrjKz5QrzyZWRE=
X-Proofpoint-ORIG-GUID: fCzE5SU7C3q6yQfLTIpgvaaz3TF4KNQs
X-Proofpoint-Spam-Reason: safe

Add handling of the Lenovo-specific and HP-specific EFI variables for
speaker ID.

Future Lenovo and HP models will not give the codec driver access to the
speaker detect GPIO. Instead, the BIOS will read the GPIO and create an
EFI variable with a value indicating the state of the GPIO.

The Lenovo and HP EFI variables are both defined to have only two valid
values. But the variable name, GUID and values are different.

This adds a new exported function cs_amp_get_vendor_spkid().

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 include/sound/cs-amp-lib.h    |   1 +
 sound/soc/codecs/cs-amp-lib.c | 101 ++++++++++++++++++++++++++++++++++
 2 files changed, 102 insertions(+)

diff --git a/include/sound/cs-amp-lib.h b/include/sound/cs-amp-lib.h
index 5459c221badf..43a87a39110c 100644
--- a/include/sound/cs-amp-lib.h
+++ b/include/sound/cs-amp-lib.h
@@ -49,6 +49,7 @@ int cs_amp_write_cal_coeffs(struct cs_dsp *dsp,
 			    const struct cirrus_amp_cal_data *data);
 int cs_amp_get_efi_calibration_data(struct device *dev, u64 target_uid, int amp_index,
 				    struct cirrus_amp_cal_data *out_data);
+int cs_amp_get_vendor_spkid(struct device *dev);
 
 struct cs_amp_test_hooks {
 	efi_status_t (*get_efi_variable)(efi_char16_t *name,
diff --git a/sound/soc/codecs/cs-amp-lib.c b/sound/soc/codecs/cs-amp-lib.c
index b1530e7c75e8..9b51d056d863 100644
--- a/sound/soc/codecs/cs-amp-lib.c
+++ b/sound/soc/codecs/cs-amp-lib.c
@@ -20,6 +20,14 @@
 #define CIRRUS_LOGIC_CALIBRATION_EFI_GUID \
 	EFI_GUID(0x02f9af02, 0x7734, 0x4233, 0xb4, 0x3d, 0x93, 0xfe, 0x5a, 0xa3, 0x5d, 0xb3)
 
+#define LENOVO_SPEAKER_ID_EFI_NAME L"SdwSpeaker"
+#define LENOVO_SPEAKER_ID_EFI_GUID \
+	EFI_GUID(0x48df970e, 0xe27f, 0x460a, 0xb5, 0x86, 0x77, 0x19, 0x80, 0x1d, 0x92, 0x82)
+
+#define HP_SPEAKER_ID_EFI_NAME L"HPSpeakerID"
+#define HP_SPEAKER_ID_EFI_GUID \
+	EFI_GUID(0xc49593a4, 0xd099, 0x419b, 0xa2, 0xc3, 0x67, 0xe9, 0x80, 0xe6, 0x1d, 0x1e)
+
 static int cs_amp_write_cal_coeff(struct cs_dsp *dsp,
 				  const struct cirrus_amp_cal_controls *controls,
 				  const char *ctl_name, u32 val)
@@ -114,6 +122,24 @@ static efi_status_t cs_amp_get_efi_variable(efi_char16_t *name,
 	return EFI_NOT_FOUND;
 }
 
+static int cs_amp_convert_efi_status(efi_status_t status)
+{
+	switch (status) {
+	case EFI_SUCCESS:
+		return 0;
+	case EFI_NOT_FOUND:
+		return -ENOENT;
+	case EFI_BUFFER_TOO_SMALL:
+		return -EFBIG;
+	case EFI_UNSUPPORTED:
+	case EFI_ACCESS_DENIED:
+	case EFI_SECURITY_VIOLATION:
+		return -EACCES;
+	default:
+		return -EIO;
+	}
+}
+
 static struct cirrus_amp_efi_data *cs_amp_get_cal_efi_buffer(struct device *dev)
 {
 	struct cirrus_amp_efi_data *efi_data;
@@ -276,6 +302,81 @@ int cs_amp_get_efi_calibration_data(struct device *dev, u64 target_uid, int amp_
 }
 EXPORT_SYMBOL_NS_GPL(cs_amp_get_efi_calibration_data, "SND_SOC_CS_AMP_LIB");
 
+struct cs_amp_spkid_efi {
+	efi_char16_t *name;
+	efi_guid_t *guid;
+	u8 values[2];
+};
+
+static int cs_amp_get_efi_byte_spkid(struct device *dev, const struct cs_amp_spkid_efi *info)
+{
+	efi_status_t status;
+	unsigned long size;
+	u8 spkid;
+	int i, ret;
+
+	size = sizeof(spkid);
+	status = cs_amp_get_efi_variable(info->name, info->guid, &size, &spkid);
+	ret = cs_amp_convert_efi_status(status);
+	if (ret < 0)
+		return ret;
+
+	if (size == 0)
+		return -ENOENT;
+
+	for (i = 0; i < ARRAY_SIZE(info->values); i++) {
+		if (info->values[i] == spkid)
+			return i;
+	}
+
+	dev_err(dev, "EFI speaker ID bad value %#x\n", spkid);
+
+	return -EINVAL;
+}
+
+static const struct cs_amp_spkid_efi cs_amp_spkid_byte_types[] = {
+	{
+		.name = LENOVO_SPEAKER_ID_EFI_NAME,
+		.guid = &LENOVO_SPEAKER_ID_EFI_GUID,
+		.values = { 0xd0, 0xd1 },
+	},
+	{
+		.name = HP_SPEAKER_ID_EFI_NAME,
+		.guid = &HP_SPEAKER_ID_EFI_GUID,
+		.values = { 0x30, 0x31 },
+	},
+};
+
+/**
+ * cs_amp_get_vendor_spkid - get a speaker ID from vendor-specific storage
+ * @dev:	pointer to struct device
+ *
+ * Known vendor-specific methods of speaker ID are checked and if one is
+ * found its speaker ID value is returned.
+ *
+ * Return: >=0 is a valid speaker ID. -ENOENT if a vendor-specific method
+ *	   was not found. -EACCES if the vendor-specific storage could not
+ *	   be read. Other error values indicate that the data from the
+ *	   vendor-specific storage was found but could not be understood.
+ */
+int cs_amp_get_vendor_spkid(struct device *dev)
+{
+	int i, ret;
+
+	if (!efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE) &&
+	    !IS_ENABLED(CONFIG_SND_SOC_CS_AMP_LIB_TEST))
+		return -ENOENT;
+
+	for (i = 0; i < ARRAY_SIZE(cs_amp_spkid_byte_types); i++) {
+		ret = cs_amp_get_efi_byte_spkid(dev, &cs_amp_spkid_byte_types[i]);
+		if (ret != -ENOENT)
+			return ret;
+	}
+
+	return -ENOENT;
+}
+EXPORT_SYMBOL_NS_GPL(cs_amp_get_vendor_spkid, "SND_SOC_CS_AMP_LIB");
+
 static const struct cs_amp_test_hooks cs_amp_test_hook_ptrs = {
 	.get_efi_variable = cs_amp_get_efi_variable,
 	.write_cal_coeff = cs_amp_write_cal_coeff,
-- 
2.39.5


