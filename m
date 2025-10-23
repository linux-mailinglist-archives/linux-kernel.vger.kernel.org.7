Return-Path: <linux-kernel+bounces-866561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 30134C00174
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1484135924E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D01C3043CB;
	Thu, 23 Oct 2025 09:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="pB50RHvc";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="AjmGXgso"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E822FB622;
	Thu, 23 Oct 2025 09:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761210247; cv=fail; b=YtBTfR9zFc/SvuB+u0fcKhI5gj4fXWJ0IUgnibythDJbTdoQM+Pm3aDSjD6Uf+FYc4sbU8zaOQLIRJKqj4e6LkoqMyDSr2JdHlGNE5jw6vOxt35ljVa7m8YG32PckpXgUrkPSOoown6ZOSanGcMBGtyawTWDxRbORRgmM/YXqow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761210247; c=relaxed/simple;
	bh=c6oZztRV/ouxVVJ5p4HMHuBxUfwDNZv9lPTx2Vg0KDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hQhfG1E+ELHIDdnRBFEPihNfyHm324S9B1mwpztuxafqx+xwfTvPTAtsAIO41i6fnMv6ESeA65x43Y2ojHApAtm3pIFWM1BIb4yFKQyy8tCoT/iv+U6DUsO5q+8qFxKaN+7jHo5kHIz0B34T4kCYIUr6F+GXUeYv/grQXp/nSK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=pB50RHvc; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=AjmGXgso; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59MJkocN3660629;
	Thu, 23 Oct 2025 04:03:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=INVzgODpWXczVd9phGl9o4BZULYn4eqBexLI5Yjfxrs=; b=
	pB50RHvcGOhpOwf86hhmev0fBYlkkd7mBsE1fzFMKNQnQ8egLJApSvP6s7T21Gy1
	9st7AXbv+53kbOWR8Az707zgxKQYT0SGdmiHZPSR4Kjn7cyRwRnTy8DHBzOxdocS
	XHJMzkWB0MGt0p+uWVCuK/5nFGcC/1MhAwc1GH6BA3blIpXm9kz+OttUXnwKsgnS
	6/pwmfYYuBStFG4m0pjYUV6iPJXRDHIA8ncWeOJRQIVIghuYHiTWguHPhGzVQF7o
	cpUW6UHguTU2VTvIvmQ/7rwx+xjFY7t2yBoj7efw3VAFJIuK6wd5dX8Bv40YAmoX
	VSncs2tG8MaaqKehly18jQ==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11022109.outbound.protection.outlook.com [40.107.209.109])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 49xqmqsx3u-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 23 Oct 2025 04:03:40 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MnHzPLURIxTGFDe+l+NUC+LX2LPD/TtAD9j232QEHt7kT2Go3ruEMlk23EuLgj7ErGimsOD9ohBYT6aSyTU2yuwp0OWJnDdfpHleDPbOLErS19VL7CV8k7HmbKFe9AF3ol6Uez7gKYd9hf4aEE5pLr/UY6seMQUOQN0shIxNdI4oF18g+YHxXOVAnU33tEhBQ0fho/HyVWJD6uKQTUjw9laMYiXh2rwoV4r/PvstFeQepch5fa6Tlx4LXUXzxTLBd3cJcp207DlPflECrB3JpNSusb95dl9N73EV3QU9/vyodJE9RH9XIKDSlDWvSOhwB+Bs1yxvNpfgs6pJmpdkeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=INVzgODpWXczVd9phGl9o4BZULYn4eqBexLI5Yjfxrs=;
 b=nPSwof2AZrGG//Jae4Afkr4E54gfFHoZyDLXyCeRPHJRvylQzBdH8t5rJtAppHLu6E7r3X1xOnfkZfqi3hcLACukJsMiZjahVSotewCfetLx9fN16ek+n6IOBpSZ/dYKojgtm7TMWalQABTvLSouauVzTWpXB6W9FtGAzvU4MX4IxqOYwwKDyqjr30VWNy3Lg7qclfIOTXLfRgr6/Zku7P5f2gAaGW+yJSJNhAgxUQp7iqbPcYq+yTdY+Sl/fdkJ/iU2FqIqxFnUcDkKRE8NB/IkVj7UQWERtWBxxXh8Q31KCABX6mjCeanFT7nQm1GeGEzhmP5+1LKoBG8eCdNXgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=INVzgODpWXczVd9phGl9o4BZULYn4eqBexLI5Yjfxrs=;
 b=AjmGXgsoueIs4OWN6wZH58Spd1ba1nklB0HfsGhImtnZCHyZh41gx3KfiqaaNY+0NU7i6SwW9Jq9FmQKeL3oqkXfLyHjuF9ikvn3qBnjUBolxGxvtrH2TKWIoAC+r4ReX3niXdFQu/oDxwpMY04AVV21cM4EG9+4t42/++XHKrA=
Received: from DS7PR05CA0076.namprd05.prod.outlook.com (2603:10b6:8:57::13) by
 DM6PR19MB3788.namprd19.prod.outlook.com (2603:10b6:5:248::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.13; Thu, 23 Oct 2025 09:03:38 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:8:57:cafe::37) by DS7PR05CA0076.outlook.office365.com
 (2603:10b6:8:57::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Thu,
 23 Oct 2025 09:03:36 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7
 via Frontend Transport; Thu, 23 Oct 2025 09:03:38 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 381E540654B;
	Thu, 23 Oct 2025 09:03:37 +0000 (UTC)
Received: from lonswws03.ad.cirrus.com (lonswws03.ad.cirrus.com [198.90.188.34])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id C5193822540;
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
Subject: [PATCH v6 01/12] ASoC: cs530x: Update the copyright headers
Date: Thu, 23 Oct 2025 10:03:09 +0100
Message-ID: <20251023090327.58275-2-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251023090327.58275-1-vitalyr@opensource.cirrus.com>
References: <20251023090327.58275-1-vitalyr@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|DM6PR19MB3788:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2a94e30c-9031-4451-95e1-08de12130e37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|61400799027|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K8Y0yXxzTnIhGgWQ+6JkqVKnBnNpa60lviPYz8wXXlueeW54gJTwrn1QD/gL?=
 =?us-ascii?Q?R/rJBuIP+1QKvQxHPIWrbf/ybbl2AUU6TTR48W2fSiUNZeVlP95kSUheJ/06?=
 =?us-ascii?Q?wQhJuAkg+fXWxo7PrDsNkWmOlpyFL550qg2UMRUhf/idRtLvo3woL5WyZ5Ts?=
 =?us-ascii?Q?D0TYxjscWQWWr9rfT44QKdGv6O9w9EM2USR3fYEfMYtGA9eB8YitzuzR5Hlr?=
 =?us-ascii?Q?PAwsD0kIOUZS1E99rJfPeiJkPNvAlQWpVCwnyocLrBbt5r54TIebjg7YmCgv?=
 =?us-ascii?Q?IcbgZAfqRSQdLJbFDbBOoeINVPR4QpqB3XBjhMSjTMmyeFtYYKWTizO1Gc3X?=
 =?us-ascii?Q?O5iF1YgOP+OPQGxsY2WZHlp/ZR4OMJ8pC+GzcyZVFHeLuxIVGv6VyMjTXe71?=
 =?us-ascii?Q?2Ci0zfVeCYZURzNiln0The+aKUPUAndQub/DI0OXn7k8MZseIF8cESQ8ugND?=
 =?us-ascii?Q?4Z8xXVD0yzvawa1OvoY8plVHoBJG8VqsnNoBF6q9lz6DOE9iEkwGfsxwWS6Q?=
 =?us-ascii?Q?afCyPZQzYmxfg1WFSnV941Wj8pLcPewqFaQFoSo/FllDoB5b/Fi1QCP0U8xL?=
 =?us-ascii?Q?uoHOr8St+RE1NbXq8z+FiW27yNDZV6WV0K3UzRRsWmjQ/+nFsE09B1VeX6aF?=
 =?us-ascii?Q?6gNO2u8xCa6crCxEImKo3zYdPx1ooj9v4iyhDOYH0GvpdlmrbInB0ypNdNex?=
 =?us-ascii?Q?7h8QdNnoYj9fTjoMlUNK2BD6eAfUvi1/A5oN0NaU0hbCAo4pmsl5XJF/gqEk?=
 =?us-ascii?Q?CIo79xOEWNCzpt/Ew019aU96/mfFCBGcwHXVPVXSTxPrpuSIF+E+ixWnG6Gn?=
 =?us-ascii?Q?OOws70qnZJWRtY6CnrZyDEPaRQ28aC7/18uFZwsCs8HcB+gZ/qdPrKnzC/TE?=
 =?us-ascii?Q?V6yZ1thCCC3bWkc4NmnPAXnXCtB1pH3AQSDs2N74OU1f6BmEa6Jy1rtGUdca?=
 =?us-ascii?Q?0osuXVp5aqNlCFHi5+QCw0+nan+7QPr0Tix3Gr05uptE6aM3XSSi+U3iklbV?=
 =?us-ascii?Q?rt6PJdpmp9DpROhkaH0vDi1T5dkh4cN0uu99hcrtXitJX63QE77HczLN/fmS?=
 =?us-ascii?Q?xY3eHBzXZUKw0CRYAVwnrbuBnR/xPT81891/aHMrwxKt1UW9cl4vUfjf2Pq7?=
 =?us-ascii?Q?zEMNZz3wkyUpEPQN63W4SH9pD3vD19jWafohrvZMGGTj1jzxt01Itac93LsZ?=
 =?us-ascii?Q?AZg3+e3hs35dihPxChxNHC/X40T5FqdFi8hQQ86zvZVRbvtufIkaPCsKQ3GM?=
 =?us-ascii?Q?hURSyrsoQN0Fd88oqz72u3wbRf1aOb90Q3u3F8oov0JN/AB1hd7VhtWkaxO4?=
 =?us-ascii?Q?Lq/KgsilIxRvi3ov6jdCppxES/DTCX5MXSZbqENsg3W/ASjQgveQU9z1uZJr?=
 =?us-ascii?Q?xvi8HNNDhJtAte0ethF8/RMpsxMRA0oBvbyigxNAzDEFqbZEJxpsSsiou5C+?=
 =?us-ascii?Q?h3yx5hQV9g8nk3Xo0zL3iEZoA30baS18PbCgWo3N14qNQxsxBhu5fo9IMm3s?=
 =?us-ascii?Q?2Capma53z9ElVR/6RWF4Ny8GQK2jjBNIwXPxcpNRqiTTlXh5uwLpz2/4CET/?=
 =?us-ascii?Q?NOlPZQ3rM7NitvzjCqM=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(61400799027)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 09:03:38.2728
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a94e30c-9031-4451-95e1-08de12130e37
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB3788
X-Authority-Analysis: v=2.4 cv=G6gR0tk5 c=1 sm=1 tr=0 ts=68f9ef6c cx=c_pps
 a=EbZLtURYOTQ0fwzjyAv4Ug==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=SQtk40xCRQeN874b5x4A:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: h_tY0hQMXFY-r4ozjq1NamQaNRDZldqJ
X-Proofpoint-GUID: h_tY0hQMXFY-r4ozjq1NamQaNRDZldqJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIzMDA4MCBTYWx0ZWRfX0yfWX5X9efLQ
 cia397z8BhIrZd0F9QlIPkKQa8VzOSDFOnG7c/rnNIaPdV/xHDu8u9sSV9Iwxg4DdVXQoKyN9xf
 evW/gXltM2h7H4erRYZt/XBSbeHMI7gamLRrr7P6R9x8+ZwIAy0UToTSbVPP63JwBC1pmvJOYs1
 PA9VwyaomAF/W5/Kssi8Z7VBZ0zkVNfUCWsRKxEHyBSDJSrqU3AUCKqWtRBVETsMJ2mIFKUkaTb
 VOaXr+zak+hIFWCEpqPQow4eYhP0oFKH6F+xcJ5+q/jzPLZYRWRBY9znP/raTKVlnZGI4Gu9ngj
 Qf5NX214MiTpWIFDROdQ1WUaIpQoWX/P/Dnuprnjn+EbOGF9D9qZru8UaXruAhS/RfV+pu05/V3
 sezi6yPv5vDFq2l/smuS7lUd6BUsaQ==
X-Proofpoint-Spam-Reason: safe

Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/soc/codecs/cs530x-i2c.c | 4 ++--
 sound/soc/codecs/cs530x.c     | 4 ++--
 sound/soc/codecs/cs530x.h     | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/cs530x-i2c.c b/sound/soc/codecs/cs530x-i2c.c
index 22b1a4d6b61c..be80dcad3647 100644
--- a/sound/soc/codecs/cs530x-i2c.c
+++ b/sound/soc/codecs/cs530x-i2c.c
@@ -2,8 +2,8 @@
 //
 // CS530x CODEC driver
 //
-// Copyright (C) 2024 Cirrus Logic, Inc. and
-//                    Cirrus Logic International Semiconductor Ltd.
+// Copyright (C) 2024-2025 Cirrus Logic, Inc. and
+//                         Cirrus Logic International Semiconductor Ltd.
 
 #include <linux/device.h>
 #include <linux/module.h>
diff --git a/sound/soc/codecs/cs530x.c b/sound/soc/codecs/cs530x.c
index 0dbc5fb92290..88084e7d6447 100644
--- a/sound/soc/codecs/cs530x.c
+++ b/sound/soc/codecs/cs530x.c
@@ -2,8 +2,8 @@
 //
 // CS530x CODEC driver
 //
-// Copyright (C) 2024 Cirrus Logic, Inc. and
-//                    Cirrus Logic International Semiconductor Ltd.
+// Copyright (C) 2024-2025 Cirrus Logic, Inc. and
+//                         Cirrus Logic International Semiconductor Ltd.
 
 #include <sound/core.h>
 #include <linux/delay.h>
diff --git a/sound/soc/codecs/cs530x.h b/sound/soc/codecs/cs530x.h
index f473e33eb835..b325847036e9 100644
--- a/sound/soc/codecs/cs530x.h
+++ b/sound/soc/codecs/cs530x.h
@@ -2,7 +2,7 @@
 /*
  * CS530x CODEC driver internal data
  *
- * Copyright (C) 2023-2024 Cirrus Logic, Inc. and
+ * Copyright (C) 2023-2025 Cirrus Logic, Inc. and
  *                         Cirrus Logic International Semiconductor Ltd.
  */
 
-- 
2.43.0


