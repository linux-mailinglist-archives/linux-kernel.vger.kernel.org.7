Return-Path: <linux-kernel+bounces-895474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A15A7C4E0D3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 14:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CDEF188D937
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 13:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FA8328248;
	Tue, 11 Nov 2025 13:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="kbgBCeNb";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="rMWCpywP"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2EF6A33B;
	Tue, 11 Nov 2025 13:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762866543; cv=fail; b=jDzhQAzE3/TNroEPg8rEBsYN4Be/fcfaZ8cxrkS66xNjjiNbqLCos3HA0i1ze5wMDnw9v2NrS3Q3OLiba2xxojNQU54rGC5QwOxCO+wZp0V0uf1gdQuugCyPkF4AhBfRvfSC1v5OfyEzan0OtjP1m9mSS1YgqnQsRjwDKBn0whg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762866543; c=relaxed/simple;
	bh=rKwFHtJol8fsv0mFCpeWLOn0yWuHHui5f/1roUgVbKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m6+ojHo/SWY8coauKz7y5xOfYe9GA2TrAl1UDhZ5j9nrWfob7jCGYhXABVIznZHFGttJtJplD7EUJnPimSq+JapG/Het6oUGLrpadb/OrJK5bIMFmxWjZwwHV94FWCCJHEcCuULf1l5zy7XWw9UtpSUWRydsE4VQyooEOt6jhWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=kbgBCeNb; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=rMWCpywP; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AB60GPe327118;
	Tue, 11 Nov 2025 07:08:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=t92MGRzXnivmYgWIf53U6z8PW5Hn/502kLL38C5PbyE=; b=
	kbgBCeNb3j9LZH4sKSz99WH1oKQ7Vm+Q6PHQ+kVD4+RqTmpBrDxl5i+y7prF5GQI
	aWGDpq3UfCESYbrh6Eb6a+IGDHML0y35OMv0uWe1IuhdYSs/CcawlmYDPNKjktww
	JjdwprXkaZimLJO7vspQrqwtJA9u8AQ0blEH30WSJO0oOoWWZ/ZPK3EZrq52e8hL
	FOhIYTLMOVDWOP434LmAq/g2ZdI7wPMwzhFBVB810LyU4Fw89QVzmlcJDs/ASug/
	DGPPzX6RQ3Jbqe3UtA9odoLkKh6yAGbrH72OdpIcIgNzGuDirfJc29+tSA+SyYnH
	cyudZGh8toh6N8BxQvFcKA==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11020117.outbound.protection.outlook.com [52.101.46.117])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4abfvksfr9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 11 Nov 2025 07:08:55 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yjTpqjoaYDNEVgFJu5AHoBRGl4mZwsReFvVeoG3Pq5QXpttbCZ048DEKMyuDeN8whbfJz3H+IiWdidijTodKk49FF7r1EMwLri5yoqyUy8wcybAasqBG86l2HyRKA6qPLZuCYYiLvv96iY/6viAfJZsfk3951Wdn/yrUL5AMIYURXOpR58UQ6vE5VgS7McqcH1m2hlpZdzFrIIvA3G6Go10VSwcbXme3PK0ijPAeuWs7c1Phg0JFUNFxhgDexU7pgV0osVg4kG7IlepN9idh1WX/e4SE0lLXpOrZLgCgs8FJABUpnkQAo6CI9JjCBKVaL6K9I5Fn7d4jp203GTUgHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t92MGRzXnivmYgWIf53U6z8PW5Hn/502kLL38C5PbyE=;
 b=aWXbFLXYP94GvOBEWF/O2sK5VN8jT09pB+Us9XvSaleESowA//gU5qOvWxs6G1oQH4SDC0angIXpdKkj2i4YYeeX/89wGUfYaQSwLIbdq9n3/ERV3td+drBCWPVxHB8dki8UE0lh0xMll8ph7PN3jTn7GL/XWfz42IMtRVcTFupbdTDiiUUzvYRbJtWfOVlRELZGk+eGc4JcJUnP76Zn9UuCjaleWlMzG5uJtijgiHzeb6riE3zru0JyOqAbybgnGdkEfLwwpNO3+Bk6BAOWpepiT2IVYLl3fDrVIms/HQtDZ4P9FWG9FOazZOXhhyE8i3IF+NAJ5K6yzhTqwgJIGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t92MGRzXnivmYgWIf53U6z8PW5Hn/502kLL38C5PbyE=;
 b=rMWCpywP42wropCe/Tb2af6RpdUg2TH2/SL9lx/yXbaRmv23Ff8aL1XST6yeTcN2YcI4tl7DAXfEcG71TSkPFUKtULFLwxo1HUI/vUiP3TBhxXa2j+aj5LmIz25JROQI8P23drV6TC8rTedtG6vAsWNSxdsHq/c7vDDrmXQ16eg=
Received: from PH8PR15CA0011.namprd15.prod.outlook.com (2603:10b6:510:2d2::28)
 by DS0PR19MB8751.namprd19.prod.outlook.com (2603:10b6:8:1f2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 13:08:53 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:510:2d2:cafe::67) by PH8PR15CA0011.outlook.office365.com
 (2603:10b6:510:2d2::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Tue,
 11 Nov 2025 13:09:00 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.13
 via Frontend Transport; Tue, 11 Nov 2025 13:08:52 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 2266A406552;
	Tue, 11 Nov 2025 13:08:51 +0000 (UTC)
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 0C02982026C;
	Tue, 11 Nov 2025 13:08:51 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: broonie@kernel.org
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: [PATCH 2/2] ASoC: cs35l56: Allow restoring factory calibration through ALSA control
Date: Tue, 11 Nov 2025 13:08:50 +0000
Message-ID: <20251111130850.513969-3-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251111130850.513969-1-rf@opensource.cirrus.com>
References: <20251111130850.513969-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|DS0PR19MB8751:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 024cc419-5708-4bca-9d02-08de2123765e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|61400799027|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VcQ6JGvtzPW6NY07MTMRHMaFpQ7zz/4tGMg3KnIzDceNMk0RBhxYsSOgKYnv?=
 =?us-ascii?Q?GJQztf67XWEUzlpQuF9KVBGq1E5ty3nnrcgvlbBaqxbBgoE7hv5emVvJlzIu?=
 =?us-ascii?Q?Q1oETlz98JtM9s+e0p5rnQgnoyxehzUbioE5BDRuxPtA6VXF1BANjIVVhJJS?=
 =?us-ascii?Q?wx8b/ZkkS6Nz9EFWBBzB5nJVZVK9Y6Jj5LoILAp2Riv8KTWBZ1bioTT0CP/K?=
 =?us-ascii?Q?VrZH0IvoGzdVMmI7fuCimhTQqrqV7HXnEy6JKNEMUtUzo5/4vXB0O1c9yC8o?=
 =?us-ascii?Q?xKADJHKLVXCz/eQ4+kj0FJCi2gJEZEkHLGhEmwcgvSxTgTqmkphr506jiU9k?=
 =?us-ascii?Q?+u2UAWf15ronsg6jl2NkspuyopeKKgUBd76rX5COPYqUPjNqywC/+n/qNJUw?=
 =?us-ascii?Q?xxqnYIUe130aTbsSwrMrbddmgwPvDrs73Q0uJcikfbLcSXS81rtQuvTvdcRZ?=
 =?us-ascii?Q?tLQxwZ8rWQYE67edgXnwhtMVOZqcWkRBA9a+NfQzilZewXH1M3QEcNYiuJk9?=
 =?us-ascii?Q?p+hAzY6RRXnQQOny7UnzqAmBN55rNCxGzWlsVl79WepsVlnteiO9NQvI2Sjb?=
 =?us-ascii?Q?D6pFvvxDc12LgAoVyCTInNVlD6Lw5PLYvER8AYSY2rS30osHXcW7yUunhreQ?=
 =?us-ascii?Q?JPakVsnNPb9sZzWWxGHWvLl+xUcpuiFQxLPpWYfcRwOLiRjLAZbymWesznGg?=
 =?us-ascii?Q?D1mtz1AAV7yUxtOWmgtsn2T3esaWr/JPuSYQffVI4hjtIoIDS/rou0G6ubbN?=
 =?us-ascii?Q?obzUr07jrQl7VZnIyVJuEH8LDBzTrzKgltvMTFNk7/QdgQycCQ8xjrpUMDM0?=
 =?us-ascii?Q?aGT41wXFUFOSbitxn02tCFjb7k9gbDjWjpr18S0je+u4++xJUeD0NyIRxS5q?=
 =?us-ascii?Q?z4FalVrQr5+XEc0HET9G3W3bXY0Wzm8lNTQbHcteJLjkdPGQ5N0MpTQeZ9N3?=
 =?us-ascii?Q?MuqIXC4q0VZymGuIDj3NJNwxWIsbeym3pw8c8AiPbgj6kGZXOGGnIFyrg+FF?=
 =?us-ascii?Q?FKMX5wmgQZMdxGeu2rOMdk2AZoMz2s57JD2qvOw37nPQepUqRJfUSCd/mPj4?=
 =?us-ascii?Q?RWDlgPxoG59hpsOYoPfOgfeDv6JVZMwmGEeZPuoL6rgdvNQr0bGDXBgO3ifW?=
 =?us-ascii?Q?59CyH1zDZOBtTVv+MiNkXu7O0oFGgF8E09J+VUTyVxM2GbyBUzLcybqpClvm?=
 =?us-ascii?Q?HZ3x+atN3al7wu6h5nw/I5GQULR6/cC6cQWdN9I/9Vy0rNcLiT+jHD3QAjPo?=
 =?us-ascii?Q?7q1tyn0rKP7DdTImCPadTZwFyx1HajuW9LkUQ/K5zMlJQmQb4gvo39Tzyzpd?=
 =?us-ascii?Q?D7rzlDz9dxAWbVv7uWYvrveBkg+V5fuP4Vp7b2EZbLZAdDPRsY++86xkPWO5?=
 =?us-ascii?Q?aqBVXh1kcik/YVj0mIanYMBWqgrLUz1RTesaE6j/6z/d5eJlLO6oIgi1Oq/Y?=
 =?us-ascii?Q?ZAN11REwdjvuIs/9wsl0VTC8/K0fXGFFBqMEkztyXgY1cRDENAQpIZWNKgqi?=
 =?us-ascii?Q?b6/X2KL1GGvMXXy7iLPJOLDS/ygy9TdEQH1VzhCpZrFIjuY2g92x1INEy8Yp?=
 =?us-ascii?Q?Iu/BTXLlQO26p6A2QH0=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(61400799027)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 13:08:52.3669
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 024cc419-5708-4bca-9d02-08de2123765e
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR19MB8751
X-Proofpoint-GUID: U3MO3z3xJMHm_XfycvbtgwJirumHncBv
X-Authority-Analysis: v=2.4 cv=e5MLiKp/ c=1 sm=1 tr=0 ts=69133567 cx=c_pps
 a=RrdOQlmmxp+bQeXV/0G7LQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=1U5iUAIXTzSLSh6816gA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDEwNSBTYWx0ZWRfX9uhcM3yMePHL
 K01FoV7wUKn39/wCNAxlAR8BcYUDHt2PN+xcDS2K4gu/450VS3BMerBfKSlFDJLTi17hvFc7GzY
 mKKSf+JEO146zA8wpnvY9ibhkq0/fPXGgJI08dVe1rGUC5zldfuAcm3nK4SfhAq3Zx47Yw2W+rR
 +zlXL7IudfwhgQ14G/xOAnwSP6XyK6YGiIlNw9EPuC89O724V6P4nEHcNiScfO1rJEyuEDrrtSl
 9XAruMv1OI3YivYAnpXrZtkpqSidEAvYXFpbac5tXQ0SXOxCGfpmkOFM2cH6cyn3nggbd98liJO
 GWZNvEKwe/3PYDPZS5b0vWgib8kNAp2IL3yozXs8i3wyBw/Tpkwb7chk6PzUme5i1wf9KuOXzWD
 ybqHlrlHCSgZMPC3fKwhwuAOL0smxg==
X-Proofpoint-ORIG-GUID: U3MO3z3xJMHm_XfycvbtgwJirumHncBv
X-Proofpoint-Spam-Reason: safe

Add an ALSA control (CAL_DATA) that can be used to restore amp calibration,
instead of using debugfs. A readback control (CAL_DATA_RB) is also added
for factory testing.

On ChromeOS the process that restores amp calibration from NVRAM has
limited permissions and cannot access debugfs. It requires an ALSA control
that it can write the calibration blob into. ChromeOS also restricts access
to ALSA controls, which avoids the risk of accidental or malicious
overwriting of good calibration data with bad data. As this control is not
needed for normal Linux-based distros it is a Kconfig option.

A separate control, CAL_DATA_RB, provides a readback of the current
calibration data, which could be either from a write to CAL_DATA or the
result of factory production-line calibration.

The write and read are intentionally separate controls to defeat "dumb"
save-and-restore tools like alsa-restore that assume it is safe to save
all control values and write them back in any order at some undefined
future time. Such behavior carries the risk of restoring stale or bad data
over the top of good data.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 include/sound/cs35l56.h           |  2 +
 sound/soc/codecs/Kconfig          | 14 +++++++
 sound/soc/codecs/cs35l56-shared.c |  5 ++-
 sound/soc/codecs/cs35l56.c        | 67 +++++++++++++++++++++++++++++++
 4 files changed, 86 insertions(+), 2 deletions(-)

diff --git a/include/sound/cs35l56.h b/include/sound/cs35l56.h
index bd13958bf19d..883f6a7e50aa 100644
--- a/include/sound/cs35l56.h
+++ b/include/sound/cs35l56.h
@@ -388,6 +388,8 @@ int cs35l56_runtime_suspend_common(struct cs35l56_base *cs35l56_base);
 int cs35l56_runtime_resume_common(struct cs35l56_base *cs35l56_base, bool is_soundwire);
 void cs35l56_init_cs_dsp(struct cs35l56_base *cs35l56_base, struct cs_dsp *cs_dsp);
 int cs35l56_get_calibration(struct cs35l56_base *cs35l56_base);
+int cs35l56_stash_calibration(struct cs35l56_base *cs35l56_base,
+			      const struct cirrus_amp_cal_data *data);
 ssize_t cs35l56_calibrate_debugfs_write(struct cs35l56_base *cs35l56_base,
 					const char __user *from, size_t count,
 					loff_t *ppos);
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 6da2fff9323c..433af9bc7564 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -912,6 +912,20 @@ config SND_SOC_CS35L56_CAL_DEBUGFS
 	  Create debugfs entries used during factory-line manufacture
 	  for factory calibration.
 
+	  If unsure select "N".
+
+config SND_SOC_CS35L56_CAL_SET_CTRL
+	bool "CS35L56 ALSA control to restore factory calibration"
+	default N
+	select SND_SOC_CS35L56_CAL_SYSFS_COMMON
+	help
+	  Allow restoring factory calibration data through an ALSA
+	  control. This is only needed on platforms without UEFI or
+	  some other method of non-volatile storage that the driver
+	  can access directly.
+
+	  On most platforms this is not needed.
+
 	  If unsure select "N".
 endmenu
 
diff --git a/sound/soc/codecs/cs35l56-shared.c b/sound/soc/codecs/cs35l56-shared.c
index 4fba4127c40c..7424e1353062 100644
--- a/sound/soc/codecs/cs35l56-shared.c
+++ b/sound/soc/codecs/cs35l56-shared.c
@@ -962,8 +962,8 @@ int cs35l56_get_calibration(struct cs35l56_base *cs35l56_base)
 }
 EXPORT_SYMBOL_NS_GPL(cs35l56_get_calibration, "SND_SOC_CS35L56_SHARED");
 
-static int cs35l56_stash_calibration(struct cs35l56_base *cs35l56_base,
-				     const struct cirrus_amp_cal_data *data)
+int cs35l56_stash_calibration(struct cs35l56_base *cs35l56_base,
+			      const struct cirrus_amp_cal_data *data)
 {
 
 	/* Ignore if it is empty */
@@ -980,6 +980,7 @@ static int cs35l56_stash_calibration(struct cs35l56_base *cs35l56_base,
 
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(cs35l56_stash_calibration, "SND_SOC_CS35L56_SHARED");
 
 static int cs35l56_perform_calibration(struct cs35l56_base *cs35l56_base)
 {
diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index e1eb7360b058..6feef971024b 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -1040,6 +1040,67 @@ static const struct cs35l56_cal_debugfs_fops cs35l56_cal_debugfs_fops = {
 	},
 };
 
+static int cs35l56_cal_data_rb_ctl_get(struct snd_kcontrol *kcontrol,
+				    struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
+	struct cs35l56_private *cs35l56 = snd_soc_component_get_drvdata(component);
+
+	if (!cs35l56->base.cal_data_valid)
+		return -ENODATA;
+
+	memcpy(ucontrol->value.bytes.data, &cs35l56->base.cal_data,
+	       sizeof(cs35l56->base.cal_data));
+
+	return 0;
+}
+
+static int cs35l56_cal_data_ctl_get(struct snd_kcontrol *kcontrol,
+				    struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
+	struct cs35l56_private *cs35l56 = snd_soc_component_get_drvdata(component);
+
+	/*
+	 * This control is write-only but mixer libraries often try to read
+	 * a control before writing it. So we have to implement read.
+	 * Return zeros so a write of valid data will always be a change
+	 * from its "current value".
+	 */
+	memset(ucontrol->value.bytes.data, 0, sizeof(cs35l56->base.cal_data));
+
+	return 0;
+}
+
+static int cs35l56_cal_data_ctl_set(struct snd_kcontrol *kcontrol,
+				    struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
+	struct cs35l56_private *cs35l56 = snd_soc_component_get_drvdata(component);
+	const struct cirrus_amp_cal_data *cal_data = (const void *)ucontrol->value.bytes.data;
+	int ret;
+
+	if (cs35l56->base.cal_data_valid)
+		return -EACCES;
+
+	ret = cs35l56_stash_calibration(&cs35l56->base, cal_data);
+	if (ret)
+		return ret;
+
+	ret = cs35l56_new_cal_data_apply(cs35l56);
+	if (ret < 0)
+		return ret;
+
+	return 1;
+}
+
+static const struct snd_kcontrol_new cs35l56_cal_data_restore_controls[] = {
+	SND_SOC_BYTES_E("CAL_DATA", 0, sizeof(struct cirrus_amp_cal_data) / sizeof(u32),
+			cs35l56_cal_data_ctl_get, cs35l56_cal_data_ctl_set),
+	SND_SOC_BYTES_E("CAL_DATA_RB", 0, sizeof(struct cirrus_amp_cal_data) / sizeof(u32),
+			cs35l56_cal_data_rb_ctl_get, NULL),
+};
+
 static int cs35l56_set_fw_suffix(struct cs35l56_private *cs35l56)
 {
 	if (cs35l56->dsp.fwf_suffix)
@@ -1134,6 +1195,12 @@ static int cs35l56_component_probe(struct snd_soc_component *component)
 		break;
 	}
 
+	if (!ret && IS_ENABLED(CONFIG_SND_SOC_CS35L56_CAL_SET_CTRL)) {
+		ret = snd_soc_add_component_controls(component,
+						     cs35l56_cal_data_restore_controls,
+						     ARRAY_SIZE(cs35l56_cal_data_restore_controls));
+	}
+
 	if (ret)
 		return dev_err_probe(cs35l56->base.dev, ret, "unable to add controls\n");
 
-- 
2.47.3


