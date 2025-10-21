Return-Path: <linux-kernel+bounces-862675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B2BBF5E2E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33A02401015
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3997C32D7FF;
	Tue, 21 Oct 2025 10:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="JdibM4eZ";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="D7ZKzrs2"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31AE32B996;
	Tue, 21 Oct 2025 10:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761043837; cv=fail; b=WQ9RmTZfw1Yh7yVYXfwt6Ri7rU3AbmEA4O0IxSBRAGMYs2VwM/NHuhpeWHWYt7YwLs2y8sPb7Zkkd3PsrkJkZGflLtLqhqAT4TfwSHKg+iwF4KuAiISMDM+Yj9Q/8RTub93xzPjJ5A+VWA+h6FjLdVSYZcmK5xbaGORfjZ4RQ40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761043837; c=relaxed/simple;
	bh=37q0JKpe2Mp0YgPPauiFM104kzzC7XRXuOaUpd0wYF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PRij3gVXEd7szyagaVsDFzIzklf2zR+8iNJRG0Mwr/0So8RGzlBnFigPSdef1qQMRYtF6piSchkmKIIIa+5V0+6tfM86LgtJJOhOACIUrQFxARxD0z4IKnniGRrEDfHYsZTsANOAO1zhMcL2r2nyIu83EUO2WG9yBVEemexFc+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=JdibM4eZ; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=D7ZKzrs2; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59KNfWTY1890847;
	Tue, 21 Oct 2025 05:50:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=5hR3KxRU+QBSaVTOizQdCCRhJEsaXyEtCKttqx10ozs=; b=
	JdibM4eZmlSknS5qFr4EmVQ3tgJU4XbgRTgTGkiFvhX/1hrrRfgzxUEjPb+DilCe
	YARNhAtaDaNiHeSl8rtqp3jbuGSnzLGhyXZl3z/OKRpBDdG8tZ92O/2wgXy2CEZv
	6RvbsGQbfLUQEXAoPE55y3z/RpGMHBqshAjRfp8FjT7/uPMcqvsMa0o/x6iDaxkP
	KtF17gCuG1n75t+VMSD8/hXLzdhTYumYVzz4eoaPIXA/yE3Cs2idyUjfIEDoiN0K
	71SFX+wt6t0wKRTc7Cpp52vfKk70aKcvDKt+Sz3Jv2+lB9ZySh62bEWLVdF47FeX
	dnqU0KXTe/NsURA+VlvgPQ==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11023087.outbound.protection.outlook.com [40.107.201.87])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 49v7aj3eg2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 21 Oct 2025 05:50:31 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PVwI2ZftsBdVhfvWMrYPZqspDDC99/IlATFG6gtIKcUKia2IB8FmnC5IvvQME4Yb+oQLgTz3xKKSrBUnnLiWDRmtvkQtriDt6vFwSechl1mMK8NX5h3pj8WYtm82rZp9sZvzRAc+hPn2UeRQxGoxxtbEGLeMFEXDTfpSnNrFmyy8nqwbjaA/tEigVB9EZ415o1JNOH0zCXH0LncMv01AJbLSwMjLEHFhDPbAg2JlaeodleQfsV5oDsMMLi6tAhDooIOkLQl69PUhjsCh3B8JD87dda+4WSYWQ0INYisvLTXcY2E2eQbbltihoC0JTqJY2eaNiThDzV0SXvdU4LAxxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5hR3KxRU+QBSaVTOizQdCCRhJEsaXyEtCKttqx10ozs=;
 b=RaNp2u0L3cLmr4gBk+RohOJqtWqH6xGkwE8BmC3KUeBn3Qsx67DyPJR3VsUO78WxLWOpKEYXV7ALhD2aCpmZVtz6mxwgtVcSAjeB48Ex5Z+Yv/VMyaXYvKtDTm/8Uz6Xn3d7WQp+G9U5lz9HjRncdpM6qMljUJLAJNME9W0hJ5fLGpWaGkTPGbDyWu9Rb6WkFvTTD/AZsErZB/Zi+EOR/HUrfmfTaGOMHLqmKyVZJDAWhAbcBdmMsb6ZGJWec80jHk/89v8FZRmpR0XcuKv36ku4OlewCEwnD5tXiDfM8QlN8/EIPMj97U3zb8qlZ58fd48GZJemTfXYsDVZlrQ+HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5hR3KxRU+QBSaVTOizQdCCRhJEsaXyEtCKttqx10ozs=;
 b=D7ZKzrs2nleo1HcGJJyfMXQ6KmZGwvjIDglJfOx07j4ojlyCHy5NnL3kfZov00xLxkto5YiAS8jHVIz5xu6VJWeYJucvm637GU+l8bbK8jVGY14w/TO5T2C45Tha2ZQA0Hc2XDsz3084KnRuGsaqO4aFBUQEcWDzixf7IUmC71g=
Received: from BYAPR11CA0092.namprd11.prod.outlook.com (2603:10b6:a03:f4::33)
 by BN5PR19MB8966.namprd19.prod.outlook.com (2603:10b6:408:2ac::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Tue, 21 Oct
 2025 10:50:26 +0000
Received: from SJ1PEPF00002326.namprd03.prod.outlook.com
 (2603:10b6:a03:f4:cafe::a) by BYAPR11CA0092.outlook.office365.com
 (2603:10b6:a03:f4::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.17 via Frontend Transport; Tue,
 21 Oct 2025 10:50:25 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SJ1PEPF00002326.mail.protection.outlook.com (10.167.242.89) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7
 via Frontend Transport; Tue, 21 Oct 2025 10:50:24 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id AFF0F406555;
	Tue, 21 Oct 2025 10:50:22 +0000 (UTC)
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 7521E822543;
	Tue, 21 Oct 2025 10:50:22 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: broonie@kernel.org, tiwai@suse.com
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: [PATCH v2 04/11] ASoC: cs35l56: Create debugfs files for factory calibration
Date: Tue, 21 Oct 2025 11:50:15 +0100
Message-ID: <20251021105022.1013685-5-rf@opensource.cirrus.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002326:EE_|BN5PR19MB8966:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 82a2e39f-1490-4274-3da9-08de108fa3e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f7ofE7OCT2XsVABTnRjEcZYDUwxY85WO0LLHdEOH7f8MJL6kXjYXc9qyxrAq?=
 =?us-ascii?Q?ZGS95m/WoT6u3h/eYiOEsWh4sdx8v9Oz7V1F6HUWvBGg0mZO5/bUJdtwN2qO?=
 =?us-ascii?Q?wYDftLnew5vpjCruy8wOxQiazLkw+e4UaUL/XKhgbvGlYjBVVWNZImH1pNaC?=
 =?us-ascii?Q?tHxgsJhcIsjGraswn7vGhk1X+mjXFHZU5SnvVjaJsyA87UM8Cjq0gsAuY/wc?=
 =?us-ascii?Q?dfNwYZko4xgiZL6gZ31FsXCAB64nuWp3eAh5T3HX33wFDBAqpbPaKyJmIuQv?=
 =?us-ascii?Q?dMu39m41uFZkxjvyDhF+8uHVfHn7YgsTei2wv4lEhhLQRDvEuHd9eQfAXmOj?=
 =?us-ascii?Q?VbrC96t90THmiPSLFoL21HiwsTDeiTnLuV/h/eDZOTG3S4cLAlZ9gu+FJB92?=
 =?us-ascii?Q?4qO6jyJMdI4rxSL1RRzeEgVLxcXPH8zj5pAp/KWRTyw5s5cs6dsAxf7crAuR?=
 =?us-ascii?Q?2R8WQxjwG5zuNnVSr6k40zsVLyPlh1W0Mg9jLvT5ihM9fzeXXoKbvVJBDf03?=
 =?us-ascii?Q?Wj4szZUeyjiJa03HkseLpBfp2R3JfVH0h0YeUGDGTNdV2yvngWE3wXJjz714?=
 =?us-ascii?Q?RQpo5uSfdH6mFQZnk8YIhsctpr//2441YUa4YhbbN4LHHQYEvqjKYXbvd46f?=
 =?us-ascii?Q?j/xjPQUSF2fh0S5ECxTB50nNw47P0dvuUVnWrA+Rg8uHpYSnxmU2wZjgVGWd?=
 =?us-ascii?Q?WeA/cd1/N68Kc5KRF8y7yf6o2qnv8hsdayN/r2Kp7xafoICHvadbit2eVLrp?=
 =?us-ascii?Q?50uxGEvDi5MYqThHge/B8aGYdRo4zU80aURFFCrulwgVrTe+S1djRWSI0KxT?=
 =?us-ascii?Q?sop+W+SEVC7gqn6aSQqMkax4h0tSUbZ4pykxJDwU7LOXCstOhCLq4sPbTI2i?=
 =?us-ascii?Q?x25l66MES2yc1EVmb3jxVmmNAqHWnitg1ZxshOMcWvTeyo0o7Dx7OkPHZMvJ?=
 =?us-ascii?Q?DrGKo+b0tqBmoxpptQZEu/iY9fX98ZZTMLEOk5ppb9D2N+8Ey4JKdmaF1NH1?=
 =?us-ascii?Q?vgynWncJIeJkJqTJ7Wh9NfRKUmAk+FzLuS6POaufGtfx+eDX1pXgLt9Fuv/H?=
 =?us-ascii?Q?QjfamddR6F2vyQJ+jjVWR7R2hmZ85H6hAswyoBig4Q4/257t94PFScm72Zqm?=
 =?us-ascii?Q?/Trkgrw/9MVKkZKBI2MqeFDbBLNW2IfstSQuVoKdrPSK8c++rfDCJnx12Cc9?=
 =?us-ascii?Q?wZvxtR9TbqwWGKt9871v6TnPb5hetnlKhlnxfwHIDGGHwPq+vTEz6grYLNZq?=
 =?us-ascii?Q?TUHdTyk1QeIm73iy4iauQBNQ4ZWsaKvfWl0r/e5Eewj/vl+L8o0Kq50vGkxv?=
 =?us-ascii?Q?5Qg2i1WSq4jcmBHTVj/nLUIwH1oEUHz7NPiuPVwBPnP6cqIKid/S5PbttHcL?=
 =?us-ascii?Q?fABS0IbKtrhyTJZyMy6b3+cqwH+GibK2sbG0TXT5jKeSY2QPDfXYlz2L+uKR?=
 =?us-ascii?Q?l1RQN5cRCB400RFKHpTifjLVTISDJ2bWMWrAKNmkA9I/ha9Crs6SZvhkAU9l?=
 =?us-ascii?Q?EysrR2+SsBj/NlMuaj3VmxwXdiCIlBuzyp4OTSWHqU/ki8wmeMaKDQk2Nc7q?=
 =?us-ascii?Q?L9xp/tPhB7l4sTIPC0A=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 10:50:24.5849
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82a2e39f-1490-4274-3da9-08de108fa3e4
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ1PEPF00002326.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR19MB8966
X-Proofpoint-ORIG-GUID: E7K8ts0c7D8umh3EAo4qIQIMNb3pMx_4
X-Proofpoint-GUID: E7K8ts0c7D8umh3EAo4qIQIMNb3pMx_4
X-Authority-Analysis: v=2.4 cv=bdNmkePB c=1 sm=1 tr=0 ts=68f76577 cx=c_pps
 a=poqohWOkhvWL7PloZTu5+Q==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=FN_7tG6lu9g4JpDWAFIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIxMDA4NSBTYWx0ZWRfX0mf6LwxylrLF
 Lfc0h4wYk34cjKs1F/TD/5fCp2Bqc34xtgJvisa5GmT8sG7SH7OPXIb172IjCGH/i1adYK2rXtF
 pHWA8yCoP8Kygk8pCg8JQQvlkY4Jk52lmNn62eYbkGgW3a7xiTkQK7hUjVKgOP0IxoMbY5HW3Y0
 TEAsj2mv77rNI4+CYjAR0wO1tSy4W0g8bwO8FaA9O386ilO+muLLc0owv2FGLyW7yczUHixcPRy
 OEwHOK2vZtvqRqiDm13UKgOH3XF127blUXlM7naIFDntvNNG57RXHpb9Wv+JUwflNKQjBltHXWm
 xwl7nin7Iu28gA/yf86fWGSvRPg2Y9sb2ZTTWhV1NlzDfsBAZbf1Ye02KuKXvQWpk+2B/kJxYlE
 knO9xEwlUGr1LoZqW1mVMB9HPG3s2A==
X-Proofpoint-Spam-Reason: safe

Create debugfs files that can be used to perform factory calibration.

During manufacture, the production line must perform a factory calibration
of the amps. This patch adds this functionality via debugfs files.

As this is only needed during manufacture, there is no need for this to be
available in a normal system so a Kconfig item has been added to enable
this. The new Kconfig option is inside a sub-menu because items do not
group and indent if the parent is invisible or there are multiple parent
dependencies. Anyway the sub-menu reduces the clutter.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
Changes in V2:
- File callbacks rewritten to be debugfs callbacks instead of
  sysfs callbacks.
- Replace the sysfs file definition and creation with debugfs creation.

 sound/soc/codecs/Kconfig   |  15 ++++
 sound/soc/codecs/cs35l56.c | 159 +++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/cs35l56.h |   6 ++
 3 files changed, 180 insertions(+)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 6bb24325c2d0..1e649da53ed9 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -899,6 +899,21 @@ config SND_SOC_CS35L56_SDW
 config SND_SOC_CS35L56_CAL_DEBUGFS_COMMON
 	bool
 
+menu "CS35L56 driver options"
+	depends on SND_SOC_CS35L56
+
+config SND_SOC_CS35L56_CAL_DEBUGFS
+	bool "CS35L56 create debugfs for factory calibration"
+	default N
+	depends on DEBUG_FS
+	select SND_SOC_CS35L56_CAL_DEBUGFS_COMMON
+	help
+	  Create debugfs entries used during factory-line manufacture
+	  for factory calibration.
+
+	  If unsure select "N".
+endmenu
+
 config SND_SOC_CS40L50
 	tristate "Cirrus Logic CS40L50 CODEC"
 	depends on MFD_CS40L50_CORE
diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index 2c1edbd636ef..091a72325507 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -10,6 +10,7 @@
 #include <linux/completion.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
+#include <linux/device.h>
 #include <linux/err.h>
 #include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
@@ -250,6 +251,8 @@ static const struct snd_soc_dapm_widget cs35l56_dapm_widgets[] = {
 	SND_SOC_DAPM_SIGGEN("VDDBMON ADC"),
 	SND_SOC_DAPM_SIGGEN("VBSTMON ADC"),
 	SND_SOC_DAPM_SIGGEN("TEMPMON ADC"),
+
+	SND_SOC_DAPM_INPUT("Calibrate"),
 };
 
 #define CS35L56_SRC_ROUTE(name) \
@@ -286,6 +289,7 @@ static const struct snd_soc_dapm_route cs35l56_audio_map[] = {
 	{ "DSP1", NULL, "ASP1RX1" },
 	{ "DSP1", NULL, "ASP1RX2" },
 	{ "DSP1", NULL, "SDW1 Playback" },
+	{ "DSP1", NULL, "Calibrate" },
 	{ "AMP", NULL, "DSP1" },
 	{ "SPK", NULL, "AMP" },
 
@@ -874,6 +878,152 @@ static void cs35l56_dsp_work(struct work_struct *work)
 	pm_runtime_put_autosuspend(cs35l56->base.dev);
 }
 
+static struct snd_soc_dapm_context *cs35l56_power_up_for_cal(struct cs35l56_private *cs35l56)
+{
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(cs35l56->component);
+	int ret;
+
+	ret = snd_soc_component_enable_pin(cs35l56->component, "Calibrate");
+	if (ret)
+		return ERR_PTR(ret);
+
+	snd_soc_dapm_sync(dapm);
+
+	return dapm;
+}
+
+static void cs35l56_power_down_after_cal(struct cs35l56_private *cs35l56)
+{
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(cs35l56->component);
+
+	snd_soc_component_disable_pin(cs35l56->component, "Calibrate");
+	snd_soc_dapm_sync(dapm);
+}
+
+static ssize_t cs35l56_debugfs_calibrate_write(struct file *file,
+					       const char __user *from,
+					       size_t count, loff_t *ppos)
+{
+	struct cs35l56_base *cs35l56_base = file->private_data;
+	struct cs35l56_private *cs35l56 = cs35l56_private_from_base(cs35l56_base);
+	struct snd_soc_dapm_context *dapm;
+	ssize_t ret;
+
+	dapm = cs35l56_power_up_for_cal(cs35l56);
+	if (IS_ERR(dapm))
+		return PTR_ERR(dapm);
+
+	snd_soc_dapm_mutex_lock(dapm);
+	ret = cs35l56_calibrate_debugfs_write(&cs35l56->base, from, count, ppos);
+	snd_soc_dapm_mutex_unlock(dapm);
+
+	cs35l56_power_down_after_cal(cs35l56);
+
+	return ret;
+}
+
+static ssize_t cs35l56_debugfs_cal_temperature_write(struct file *file,
+						     const char __user *from,
+						     size_t count, loff_t *ppos)
+{
+	struct cs35l56_base *cs35l56_base = file->private_data;
+	struct cs35l56_private *cs35l56 = cs35l56_private_from_base(cs35l56_base);
+	struct snd_soc_dapm_context *dapm;
+	ssize_t ret;
+
+	dapm = cs35l56_power_up_for_cal(cs35l56);
+	if (IS_ERR(dapm))
+		return PTR_ERR(dapm);
+
+	ret = cs35l56_cal_ambient_debugfs_write(&cs35l56->base, from, count, ppos);
+	cs35l56_power_down_after_cal(cs35l56);
+
+	return ret;
+}
+
+static ssize_t cs35l56_debugfs_cal_data_read(struct file *file,
+					     char __user *to,
+					     size_t count, loff_t *ppos)
+{
+	struct cs35l56_base *cs35l56_base = file->private_data;
+	struct cs35l56_private *cs35l56 = cs35l56_private_from_base(cs35l56_base);
+	struct snd_soc_dapm_context *dapm;
+	ssize_t ret;
+
+	dapm = cs35l56_power_up_for_cal(cs35l56);
+	if (IS_ERR(dapm))
+		return PTR_ERR(dapm);
+
+	ret = cs35l56_cal_data_debugfs_read(&cs35l56->base, to, count, ppos);
+	cs35l56_power_down_after_cal(cs35l56);
+
+	return ret;
+}
+
+static int cs35l56_new_cal_data_apply(struct cs35l56_private *cs35l56)
+{
+	struct snd_soc_dapm_context *dapm;
+	int ret;
+
+	if (!cs35l56->base.cal_data_valid)
+		return -ENXIO;
+
+	if (cs35l56->base.secured)
+		return -EACCES;
+
+	dapm = cs35l56_power_up_for_cal(cs35l56);
+	if (IS_ERR(dapm))
+		return PTR_ERR(dapm);
+
+	snd_soc_dapm_mutex_lock(dapm);
+	ret = cs_amp_write_cal_coeffs(&cs35l56->dsp.cs_dsp,
+				      cs35l56->base.calibration_controls,
+				      &cs35l56->base.cal_data);
+	if (ret == 0)
+		cs35l56_mbox_send(&cs35l56->base, CS35L56_MBOX_CMD_AUDIO_REINIT);
+	else
+		ret = -EIO;
+
+	snd_soc_dapm_mutex_unlock(dapm);
+	cs35l56_power_down_after_cal(cs35l56);
+
+	return ret;
+}
+
+static ssize_t cs35l56_debugfs_cal_data_write(struct file *file,
+					      const char __user *from,
+					      size_t count, loff_t *ppos)
+{
+	struct cs35l56_base *cs35l56_base = file->private_data;
+	struct cs35l56_private *cs35l56 = cs35l56_private_from_base(cs35l56_base);
+	int ret;
+
+	ret = cs35l56_cal_data_debugfs_write(&cs35l56->base, from, count, ppos);
+	if (ret == -ENODATA)
+		return count;	/* Ignore writes of empty cal blobs */
+	else if (ret < 0)
+		return -EIO;
+
+	ret = cs35l56_new_cal_data_apply(cs35l56);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static const struct cs35l56_cal_debugfs_fops cs35l56_cal_debugfs_fops = {
+	.calibrate = {
+		.write = cs35l56_debugfs_calibrate_write,
+	},
+	.cal_temperature = {
+		.write = cs35l56_debugfs_cal_temperature_write,
+	},
+	.cal_data = {
+		.read = cs35l56_debugfs_cal_data_read,
+		.write = cs35l56_debugfs_cal_data_write,
+	},
+};
+
 static int cs35l56_set_fw_suffix(struct cs35l56_private *cs35l56)
 {
 	if (cs35l56->dsp.fwf_suffix)
@@ -971,6 +1121,13 @@ static int cs35l56_component_probe(struct snd_soc_component *component)
 	if (ret)
 		return dev_err_probe(cs35l56->base.dev, ret, "unable to add controls\n");
 
+	ret = snd_soc_component_disable_pin(component, "Calibrate");
+	if (ret)
+		return ret;
+
+	if (IS_ENABLED(CONFIG_SND_SOC_CS35L56_CAL_DEBUGFS))
+		cs35l56_create_cal_debugfs(&cs35l56->base, &cs35l56_cal_debugfs_fops);
+
 	queue_work(cs35l56->dsp_wq, &cs35l56->dsp_work);
 
 	return 0;
@@ -982,6 +1139,8 @@ static void cs35l56_component_remove(struct snd_soc_component *component)
 
 	cancel_work_sync(&cs35l56->dsp_work);
 
+	cs35l56_remove_cal_debugfs(&cs35l56->base);
+
 	if (cs35l56->dsp.cs_dsp.booted)
 		wm_adsp_power_down(&cs35l56->dsp);
 
diff --git a/sound/soc/codecs/cs35l56.h b/sound/soc/codecs/cs35l56.h
index 40a1800a4585..4c59f92f3206 100644
--- a/sound/soc/codecs/cs35l56.h
+++ b/sound/soc/codecs/cs35l56.h
@@ -10,6 +10,7 @@
 #define CS35L56_H
 
 #include <linux/completion.h>
+#include <linux/container_of.h>
 #include <linux/regulator/consumer.h>
 #include <linux/pm_runtime.h>
 #include <linux/workqueue.h>
@@ -54,6 +55,11 @@ struct cs35l56_private {
 	u8 sdw_unique_id;
 };
 
+static inline struct cs35l56_private *cs35l56_private_from_base(struct cs35l56_base *cs35l56_base)
+{
+	return container_of(cs35l56_base, struct cs35l56_private, base);
+}
+
 extern const struct dev_pm_ops cs35l56_pm_ops_i2c_spi;
 
 int cs35l56_system_suspend(struct device *dev);
-- 
2.47.3


