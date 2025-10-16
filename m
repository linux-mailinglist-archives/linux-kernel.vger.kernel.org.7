Return-Path: <linux-kernel+bounces-856027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E97BE2F76
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 12:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 51FDA545908
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 10:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD4A32C30D;
	Thu, 16 Oct 2025 10:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="p6CZ844q";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="Z7vUtFPp"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7413002D6;
	Thu, 16 Oct 2025 10:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760611389; cv=fail; b=swNcy8YrLhQ/WrhSETZIcvUcptPTN+qHHzs5l11T8NdfB55XKG5Xgcr6RzXxfrc/qL01jAIr/BVd4oiRh5kHWvovPB5t5i4Q9L1Qr2rS/JVBeqp+cfYey3FFNXTidz3NQF6iEhuWgw0lnT9C0+kP95zN2GPunBXb+MhcAh+HkGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760611389; c=relaxed/simple;
	bh=oLwQWGfCLXmS+vWfQ64mWrRjgyLiJXzUGfjdppst9ag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sxR0XVHfn6WaYE2+QnP1OjlP4HW4DBeMx27HbBHTaIHbUh27U7utcDrqcsVWtJa5OmN7N0i0/KtYldcHOSTslrkPpM2mpxtYiEX/XDCmqIsFc45LtdT3ZWjWxj/V/jgKd8SFcthr5cRrtW8z9zvDG5w716+8cPrGW+8/NzsDJsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=p6CZ844q; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=Z7vUtFPp; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59FLY4Gf1728970;
	Thu, 16 Oct 2025 05:42:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=GU5tH7J/4KN3ZlxgA1lCJ7G5tuj/QsuCYXyJGz20a8E=; b=
	p6CZ844qG1oRj2xaeWWm+YeZz/mS+4tkfNIXlR1Roi5g9gNPn5SOFS97BmAVw24C
	j/Pq0iggrNv/e/+Mko/S4mFbImPq06KvWI19QPq3KgeLG+kQZ/WAlbIccKKdHCb9
	UndEUfYTVYGaZ+r1rmurJu6p45ehfkNZoY+XHPFad8+LBzWsbrr26krQncnwjQl0
	xLMMKk+KU0iD1sS6cwnyxuYgaCNeiZYPaYsa/+r1JAjRPMLgYiJ8RRQlr1OSuiZ/
	5WA6awLKXziYpKzt7hGUO0MJ5kIuQttP+2SzNV2nR5gpM0PQC9j1Z8sITPJQ5Pjj
	rJNg3A6J4kPJ43VVO2es9g==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11021125.outbound.protection.outlook.com [52.101.62.125])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 49sdb448a5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 05:42:51 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FYpVtEryaLTzbopSZVwp+YT0XSZBTMaCa9mrz3xOjl1HMmCzhPHZF1F9HdHAizvFUh8Th+kXRjb24Uv9rAYEUnktRagH29HwGaGuUtQLkqM4LS8roA9XJ82T+ee+L5Ov8o//MbLp/JQqy96A+Ey8GUFweFxo0CG2AKVjsaVN58N3LnFaJtFVkY+TOojNJcjRKVjWU9VM5rxU3t76v2++vetr7wB6fmrVancEFSbCU+euZ9o4qjDdUdvI42iQmNsuxsoTTMe1j7h1ToMrked+02jOUnU4QW8cwrrlB4rRzyaBxbrpvz+MnEVgISvEMxhz3IfcTafmWuNIo6jnaW51dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GU5tH7J/4KN3ZlxgA1lCJ7G5tuj/QsuCYXyJGz20a8E=;
 b=sbiHMsFH4PaEFOfYljxlf1zAq0442URMAnC2VgNWJL1oda+Rx9+vBckNV+ZGDHcsx0bSMGdsHzOW3K4i2+0aNkKLK8qg9oJ1GdZ5GyV0/tzAONcvrJYebovvtc+y5nReP1ZiZVA4SLmnJ4O9ZO5U9i7frbeKeazH7sJvWKUqYo0ZALZOxaASD3rORVDVSnuuhNuGAo3kZqs7rzHWv1m0e6s86ojZjNBxUFc4bGiIAw1I9azkiIDMLxaRpUHZ/HMVOkqJstG5tp+pPqJleSd5m6M8rSxWSp0O7uPuy8gHzNGrYvnpbnb8Y00zI7Y39CO/4L5AdwdX547DchKWE4lv7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GU5tH7J/4KN3ZlxgA1lCJ7G5tuj/QsuCYXyJGz20a8E=;
 b=Z7vUtFPpbN0o9aPbYNUBJLADo+HIv8txXXhOLzt2TbYxS2L/KK0CPEaDSVhYgZV0EpBJ/WW6xBkJAynnZ9w426ynZIhOQgWqStJV8dXSpeYew0xXA5HHDDg4ZkTBDkJEhdaO/rZSmlV1prLvOvlUTyue8oj+zRJl6KX5peJjMg0=
Received: from SJ0PR05CA0095.namprd05.prod.outlook.com (2603:10b6:a03:334::10)
 by SA0PR19MB4349.namprd19.prod.outlook.com (2603:10b6:806:91::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 10:42:47 +0000
Received: from MWH0EPF000971E6.namprd02.prod.outlook.com
 (2603:10b6:a03:334:cafe::5a) by SJ0PR05CA0095.outlook.office365.com
 (2603:10b6:a03:334::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.5 via Frontend Transport; Thu,
 16 Oct 2025 10:42:47 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 MWH0EPF000971E6.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Thu, 16 Oct 2025 10:42:46 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id E751640655D;
	Thu, 16 Oct 2025 10:42:42 +0000 (UTC)
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id C7200822543;
	Thu, 16 Oct 2025 10:42:42 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: broonie@kernel.org, tiwai@suse.com
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: [PATCH 06/11] ASoC: cs-amp-lib-test: Add cases for factory calibration helpers
Date: Thu, 16 Oct 2025 11:42:37 +0100
Message-ID: <20251016104242.157325-7-rf@opensource.cirrus.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E6:EE_|SA0PR19MB4349:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ad3b9c86-fb2c-4b7d-ecdc-08de0ca0bea2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q+iYnqQwTFEl+p3B8ZI2AJi1k/U79sPUTkTPqg+jbOmAv06Yamxgm58tM1Bq?=
 =?us-ascii?Q?+QaX6s6rJh7oG1QWhsJi+BVmywhuhiG2PcgvZhbxrFoTJeugOvSh1QV0sc/G?=
 =?us-ascii?Q?fa3MqmplGQWLv3p0M2iPjJSZFDrfS+lTQgx3UmlKphUFrNTAmJRfvKEDGjjs?=
 =?us-ascii?Q?OMCn1RnERaWbbt9PW5Ifs0cOBqvPNL1vNVviqWhfYGqXr9QmVzkVr6ql55gG?=
 =?us-ascii?Q?9tSr0cs70WQOAmyakrhTWrjtggTr0ljKcXW6uxR4tvOk9Lxf9/U7anXXcuHh?=
 =?us-ascii?Q?KUPmYS7hvJSZYAjH4uDhk8vWWrjD5xoG6L8PGJN4vEak0Q/qjBUqeNGTnyP3?=
 =?us-ascii?Q?jCWaSmqbM8xqe92Yw5c5FkG8BRzv+UrFhpCZ3ozOI7jZSIT6GEd6q8W+CVFD?=
 =?us-ascii?Q?7iqnrOdSqLDn5A4h57hMnwGU7FURG6vAIvULMwLEzf+PWCkZ9nBtXNIh0J1I?=
 =?us-ascii?Q?GvECls9XExJC0ks6GGoWr8tz+YbboYPXmd/kP6X7107kpul1iTjVgUl72PT4?=
 =?us-ascii?Q?vC2Mb0iSI2JyTTuvgn8GXPvimQWVnvnJjmN0hLOd/8ZJ8IS/9NmHTPvR5M/Y?=
 =?us-ascii?Q?A3FF9bRoqQaeMeT7pcGWhwvHfD32Z4fsUzXxVpLnPu2Xb4qZJL33Zw1G0NTP?=
 =?us-ascii?Q?sg2TuYxWCayTi+ncNhKjxWujYBMgKcTUxmm6jWBsBW+s1sLHJvEYwn2CDysO?=
 =?us-ascii?Q?4FsUzYhv8HqOVpx8W6DBSXAVXb95pFqqNFIH93yhjJqL02v52EXmthbuD3j/?=
 =?us-ascii?Q?JgIn0i6lFJ4lTmeSFD3WY2RSq3/lxxicOqELIy3AN2ayi56DShvnZtOmOooV?=
 =?us-ascii?Q?bpAbKM3eHSoceQ1W0oDIGThLxaf0EG+6TEik3a/L7McRSUzGmgwisPJsqDuj?=
 =?us-ascii?Q?X7Vqiu6JsElVAKmnEfs+cJhu94U7ry+rnGr9LtkxaN5UsptCOF8dXe7HoFPg?=
 =?us-ascii?Q?gHb1pGnHvX4SRrSUOJnCsVMmC3vktpoY1Z4ZCkzJepPSBUEOxLeEsyUEW6Wv?=
 =?us-ascii?Q?YXjmhKyx8xYFnCYV5lK+MCbGCEF7HgdeSMb0hXpu0f30jkYzICf7qWgCeA8z?=
 =?us-ascii?Q?T23A/5pjP8R6NRhZ2tMvg2TowtBrgLjkFAkxVdONS6WuLpewl1bw/l8pYVJw?=
 =?us-ascii?Q?hIfQVmuUU5Gg9US5s7/bOqcBkztHF0h+Vf9WfMvE7DVwWLn1Cb2eiuJmlADO?=
 =?us-ascii?Q?1ufiUkY2mG4APOaw1JAb1gHPpKTZg00k9ToqwF6Ye2AMmDUhtLnCKQnW2XQV?=
 =?us-ascii?Q?mJ0b75TD3QoVbYL2PBOQQnIFpysKccQkenuELLY8Ksc+ryh4CQ+nMo/23DBz?=
 =?us-ascii?Q?L+O0bORtNmD/NWDBPm3xePjNxvxe9M7miPZc0DjPSSo6OPpf/ClDO43Uk9q9?=
 =?us-ascii?Q?pZ7IjIebLU3qCEYfDmxno5MBnDF9yKt2rIl+NxkalVCUKeWi9H5HhF1R5U93?=
 =?us-ascii?Q?379W8ZlMnVSynT3AXyT0LPJ+6+aWPDoFzPMUIcEd0YjxE92J1mBSUKzIe6Wb?=
 =?us-ascii?Q?jRwyyJx9x2B8M6tJWTSKpNqru3nwdVGERs02YZBSRz8i7FKX3cflyO9nwC7T?=
 =?us-ascii?Q?yfjK01fGDNNymfV8DxQ=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 10:42:46.2669
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad3b9c86-fb2c-4b7d-ecdc-08de0ca0bea2
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MWH0EPF000971E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR19MB4349
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDA4MCBTYWx0ZWRfXwwRpj4Hzhwm0
 ighzlmxRUJT4Rx7p9ZwhI++MrHr6wlEa6+CzTdo3/n1HzXswcGv0rfPrDZLsmfJdM3ZuPi5I/RT
 w9nNA9MrzK5VJ6tS/tZkjeWYUFegI3XRDvLhBsJLc+XNasihJbNI7sCTjOQ3AnVe2LDmHqd0Nh0
 wlOC2rRCURoUBhqNuVc4MxC0ri1m+sSG3u2n7kzB0OIRoxURbw1HfqjFrUK0pm5Jb66ci+0AHmB
 c82m/9g2+rrDNY0vqCiH+xerm+MzDuo+IEI2faWIMSVIpYw1EzB07kry3BbzjteOb6MXL1vgbqP
 r3756WF7v1j2xlRNAMvm+aFUeB6T7KEUZIJewKEedy1Klj9ZM6QNLd8uhOD/HfJAikzsMjVi4tE
 aXsa0PQqRu79hTIwsIpJtwKMGZxH9A==
X-Proofpoint-GUID: 9W192a3gwiD0HWVCKMGfwaq7K6pj2nok
X-Authority-Analysis: v=2.4 cv=PPICOPqC c=1 sm=1 tr=0 ts=68f0cc2b cx=c_pps
 a=63eZqvGvmDVpXZrU3nJVyw==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=7xSZuedwfSVow7RlVg8A:9
X-Proofpoint-ORIG-GUID: 9W192a3gwiD0HWVCKMGfwaq7K6pj2nok
X-Proofpoint-Spam-Reason: safe

Add test cases for the cs_amp_read_cal_coeffs() and
cs_amp_write_ambient_temp() functions.

In both cases the test is simply to confirm that the correct data
value(s) get passed back to the caller.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 include/sound/cs-amp-lib.h         |  5 +-
 sound/soc/codecs/cs-amp-lib-test.c | 75 +++++++++++++++++++++++++++++-
 sound/soc/codecs/cs-amp-lib.c      |  1 +
 3 files changed, 79 insertions(+), 2 deletions(-)

diff --git a/include/sound/cs-amp-lib.h b/include/sound/cs-amp-lib.h
index e4df0736039a..485daadd13a1 100644
--- a/include/sound/cs-amp-lib.h
+++ b/include/sound/cs-amp-lib.h
@@ -71,8 +71,11 @@ struct cs_amp_test_hooks {
 	int (*write_cal_coeff)(struct cs_dsp *dsp,
 			       const struct cirrus_amp_cal_controls *controls,
 			       const char *ctl_name, u32 val);
-};
 
+	int (*read_cal_coeff)(struct cs_dsp *dsp,
+			      const struct cirrus_amp_cal_controls *controls,
+			      const char *ctl_name, u32 *val);
+};
 extern const struct cs_amp_test_hooks * const cs_amp_test_hooks;
 
 #endif /* CS_AMP_LIB_H */
diff --git a/sound/soc/codecs/cs-amp-lib-test.c b/sound/soc/codecs/cs-amp-lib-test.c
index 3406887cdfa2..b19aaacd7f2b 100644
--- a/sound/soc/codecs/cs-amp-lib-test.c
+++ b/sound/soc/codecs/cs-amp-lib-test.c
@@ -702,6 +702,77 @@ static void cs_amp_lib_test_write_cal_data_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, entry->value, data.calStatus);
 }
 
+static int cs_amp_lib_test_read_cal_coeff(struct cs_dsp *dsp,
+					  const struct cirrus_amp_cal_controls *controls,
+					  const char *ctl_name, u32 *val)
+{
+	struct kunit *test = kunit_get_current_test();
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctl_name);
+	KUNIT_EXPECT_PTR_EQ(test, controls, &cs_amp_lib_test_calibration_controls);
+
+	if (strcmp(ctl_name, controls->ambient) == 0)
+		*val = 19;
+	else if (strcmp(ctl_name, controls->calr) == 0)
+		*val = 1077;
+	else if (strcmp(ctl_name, controls->status) == 0)
+		*val = 2;
+	else
+		kunit_fail_current_test("Bad control '%s'\n", ctl_name);
+
+	return 0;
+}
+
+static void cs_amp_lib_test_read_cal_data_test(struct kunit *test)
+{
+	struct cs_amp_lib_test_priv *priv = test->priv;
+	struct cirrus_amp_cal_data data = { 0 };
+	struct cs_dsp *dsp;
+	int ret;
+
+	dsp = kunit_kzalloc(test, sizeof(*dsp), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dsp);
+	dsp->dev = &priv->amp_dev->dev;
+
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->read_cal_coeff,
+				   cs_amp_lib_test_read_cal_coeff);
+
+	ret = cs_amp_read_cal_coeffs(dsp, &cs_amp_lib_test_calibration_controls, &data);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	KUNIT_EXPECT_EQ(test, 19, data.calAmbient);
+	KUNIT_EXPECT_EQ(test, 1077, data.calR);
+	KUNIT_EXPECT_EQ(test, 2, data.calStatus);
+	KUNIT_EXPECT_NE(test, 0, data.calTime[0] | data.calTime[1]);
+}
+
+static void cs_amp_lib_test_write_ambient_test(struct kunit *test)
+{
+	struct cs_amp_lib_test_priv *priv = test->priv;
+	struct cs_amp_lib_test_ctl_write_entry *entry;
+	struct cs_dsp *dsp;
+	int ret;
+
+	dsp = kunit_kzalloc(test, sizeof(*dsp), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dsp);
+	dsp->dev = &priv->amp_dev->dev;
+
+	/* Redirect calls to write firmware controls */
+	kunit_activate_static_stub(test,
+				   cs_amp_test_hooks->write_cal_coeff,
+				   cs_amp_lib_test_write_cal_coeff);
+
+	ret = cs_amp_write_ambient_temp(dsp, &cs_amp_lib_test_calibration_controls, 18);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	KUNIT_EXPECT_EQ(test, list_count_nodes(&priv->ctl_write_list), 1);
+
+	entry = list_first_entry(&priv->ctl_write_list, typeof(*entry), list);
+	KUNIT_EXPECT_STREQ(test, entry->name, cs_amp_lib_test_calibration_controls.ambient);
+	KUNIT_EXPECT_EQ(test, entry->value, 18);
+}
+
 static void cs_amp_lib_test_spkid_lenovo_not_present(struct kunit *test)
 {
 	struct cs_amp_lib_test_priv *priv = test->priv;
@@ -974,8 +1045,10 @@ static struct kunit_case cs_amp_lib_test_cases[] = {
 			 cs_amp_lib_test_get_cal_gen_params),
 	KUNIT_CASE(cs_amp_lib_test_get_efi_cal_empty_entry_test),
 
-	/* Tests for writing calibration data */
+	/* Tests for writing and reading calibration data */
 	KUNIT_CASE(cs_amp_lib_test_write_cal_data_test),
+	KUNIT_CASE(cs_amp_lib_test_read_cal_data_test),
+	KUNIT_CASE(cs_amp_lib_test_write_ambient_test),
 
 	/* Test cases for speaker ID */
 	KUNIT_CASE(cs_amp_lib_test_spkid_lenovo_not_present),
diff --git a/sound/soc/codecs/cs-amp-lib.c b/sound/soc/codecs/cs-amp-lib.c
index b2509c5c0690..d510e0e065ca 100644
--- a/sound/soc/codecs/cs-amp-lib.c
+++ b/sound/soc/codecs/cs-amp-lib.c
@@ -515,6 +515,7 @@ EXPORT_SYMBOL_NS_GPL(cs_amp_get_vendor_spkid, "SND_SOC_CS_AMP_LIB");
 static const struct cs_amp_test_hooks cs_amp_test_hook_ptrs = {
 	.get_efi_variable = cs_amp_get_efi_variable,
 	.write_cal_coeff = cs_amp_write_cal_coeff,
+	.read_cal_coeff = cs_amp_read_cal_coeff,
 };
 
 const struct cs_amp_test_hooks * const cs_amp_test_hooks =
-- 
2.47.3


