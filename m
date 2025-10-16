Return-Path: <linux-kernel+bounces-855861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 053ECBE2855
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 11:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F9B948267B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 09:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE30631AF30;
	Thu, 16 Oct 2025 09:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="SPVFLj4W";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="wq2FT0La"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CD5319875;
	Thu, 16 Oct 2025 09:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608299; cv=fail; b=oe2bJOI2fzDpc/TPNsA+a8eMeRLt8cP7GCdtUfpiL5o1cbwcEp8p2I6euJamXDj8qw71dTMHwYV/xiDADZZIpdHYhLDASC3k9YfaWoDTa7Z15AT8/tNFxxbyNGU+784rWNBeCv2qVkrnVIBuHQCVLNdYOS5+aEbGtdUgXzqD7V0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608299; c=relaxed/simple;
	bh=paRS1iPtTebKE7Yr10XlLhkl6Iu4E/Ax1fIpP+N+sjw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DTRVHTZBi4qkCFU6WlTIf02DZ2TvM9qiakPxLI7Y5srYYRv+IHPXBBKVBG2kT97sGajEUid4dLF49NORf02N9Zos+/TVPIMs/vmrKGhctc1YFIG80XIkFGBFfIksShID0pLvag3Mfujn3rO0B92SJO2E4KQ3W58j0RfPF9f2V0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=SPVFLj4W; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=wq2FT0La; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59G8fDZG2477160;
	Thu, 16 Oct 2025 04:51:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=+waaRa7bBZFzb5p4
	hb+mxaMIxMNJhC7YjaizblBK3B8=; b=SPVFLj4WzHuufC77m76do2+3Jv+y3VSj
	mJRIrEF2eSpPSCeHrXvNj364yLvj3RNCbAGHDTSFGwISFL4p8v1njtyKPAWRPf/a
	sJGzbgXKfOqB4rKKeLMLDU911PWbyeIfstlnNUH4nU6GQPjuK8MjJV/oNvy3ApbI
	3arfXJbNJ3uWjJ+x0a6S/pk39P3qUXus32HBbDu2GppOnQAGWTkkDC/Q92QYWZ15
	o+UyGf53I+R6nj7SPE4efJAH4mcP6UacnOcit6qsWR/SPcGBj2QotNnHL4yx3hTB
	ohY4ePzWf6dSTdp86YhMVUd7Nnsv9HpGwqir/xN3xWqMN8Hq8Ur03A==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11022129.outbound.protection.outlook.com [40.107.209.129])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 49t9mhhn4h-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 04:51:24 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tpaEdZezkApuW08ZQ0KP/Eb4Mf9rPbO6UDyR9uMzArCIKiw58iHD0IfcfNAea4gw02C1QWtP2P3NJftNF9Q81Yu5J3RvRqUmyhDv/a6nNiqa4YivsM84wRyH8c9rm+MZkbnDlcp74HY7bB6nDmw0Nlw+0p0wtiGVbSmSlAUOeKAoeIznVnPVGvdd8N+NjqZv47FPERarI2aa5AFIJeV1p5JQze4jcJSSyx9LZTyUWaQMglvLG8l7QyRqdjT1+Mu/XdoW17cpBk+F5Kzeii8VJg5wnstAsbk9kzOdA2lxmgK/GGqRyIcrk8ZCZVMeq1ZbtAntad1T3XSoKG5FKVEgQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+waaRa7bBZFzb5p4hb+mxaMIxMNJhC7YjaizblBK3B8=;
 b=Sx5Dy9P+GpnTuXlLc1cJBYfBUdZN5Lduw1GWlXFf+/hJMQk9/rOdQi77qAzP1xwC9/36lHktfP8YdjD72G/1QsBDgsugilk9Q7buVvMw+pa06EyQqyI9WG9jJuEC47YkjxPqu0TYnj65/2faBR59LLx1KOjnP+AExuNCXD8eNm9zSqiT+4BkZLahEl/5D07o1+UXDqrTgeY3HQVJad6a5BvqzLV8vPiXfCxpmW3g/aYwLsFGM8X7V9cuK3hLh+5CpDo15XWSUXclFlL32Rm/BZUKDbhkzZjhQOyzVxTJPntuGW/MK7bscs3xOO+Mv3nbRf+ASRYt2y4oDwDFLuT8Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+waaRa7bBZFzb5p4hb+mxaMIxMNJhC7YjaizblBK3B8=;
 b=wq2FT0LacoAABa5EWhmY6qYiR/sbXTMwZZLfklBHEWib1//mD9Ov3iXeAS5ax73NkPUyoPPIvkNmb25BeU5hn6yXf8eZpu7Uc51nsxF/TewpqGeSRmOxtzsmNq3fZGNwDP3npqqmFx0N/UrIz6uK3zZWlrNt46ToSNQHw7e8K18=
Received: from CH0PR13CA0009.namprd13.prod.outlook.com (2603:10b6:610:b1::14)
 by MW5PR19MB5580.namprd19.prod.outlook.com (2603:10b6:303:1a0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 09:51:18 +0000
Received: from CH3PEPF0000000B.namprd04.prod.outlook.com
 (2603:10b6:610:b1:cafe::83) by CH0PR13CA0009.outlook.office365.com
 (2603:10b6:610:b1::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.5 via Frontend Transport; Thu,
 16 Oct 2025 09:51:18 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CH3PEPF0000000B.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Thu, 16 Oct 2025 09:51:18 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id DB271406547;
	Thu, 16 Oct 2025 09:51:16 +0000 (UTC)
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id B6F61820249;
	Thu, 16 Oct 2025 09:51:16 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: broonie@kernel.org
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: [PATCH] ASoC: cs-amp-lib-test: Fix missing include of kunit/test-bug.h
Date: Thu, 16 Oct 2025 10:51:16 +0100
Message-ID: <20251016095116.93260-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000B:EE_|MW5PR19MB5580:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 75f2919d-48aa-4e19-3317-08de0c998dd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YtBN+HtqZfxeNp2Jm2nTwshlNjMNCa9/D92spPJjBPM/ycl9mKewRom7v5+3?=
 =?us-ascii?Q?rVJUkZjkbH8u7Cm9L6o6G90udc/tZrBA/IpywhkVPq1L6F0G3b5ZwrnLbbNn?=
 =?us-ascii?Q?z1HBCJgvNhiOnhloroLGhBZAp8QfPSXtOo7SJ3oSFSVGdJOX8taX0N4pLdcn?=
 =?us-ascii?Q?W1S55NrGmqWisWsFWciKY4u2v0RpyS+qU1jRcbR4dGRCn/HdJ1JLDSiVfEdP?=
 =?us-ascii?Q?/x5MmegAXEfHi/ofy7mtgMMYtuOlBctsY3tvOKv5NgUrlzT4aLPgUkGR/aBB?=
 =?us-ascii?Q?5T3aGeGpkrNPStq3HqFlr7hDDJQB7v09unNQllsl1yRjhuUVnZ5zqi7w7lze?=
 =?us-ascii?Q?jjTCklc8P448lLdHNAjz+MhV3CXfYQ+XHHpUlSjWD/OlPewxHvv8P4XctWc3?=
 =?us-ascii?Q?qZXqsgoT77MDRc+Fcf1wu/qXvk/ACnRN6+RV1Q+Xl5k0CaxtzWfgGGXHQGaz?=
 =?us-ascii?Q?KXxwLP+5TuNBXZ4O8GfSm6ojlGQG1bYyJ4+pxDlC4wpociArJRE1RhbXhkj7?=
 =?us-ascii?Q?LuLUNLtVULNpNzmIPHTAR6NxUJNHvqFNW5A7sQdAbGy/Ck7jx5lBntNPZzWz?=
 =?us-ascii?Q?oe15F99lfjN+Xd/7jCTdPGjhfOkn7QD7o7PPwg4N7Io/9zWxRnUOD601oAbn?=
 =?us-ascii?Q?yWn4f9/ogjTU3qJTRWEKYjgt890X7QpAmoFfPBIuUxepM8zcJQkhFuk+SjPD?=
 =?us-ascii?Q?kgxqlPooR8aWoOp0Dqs4qg36TB+OL6XkKVQSRHDGqo8m2LYxLbOwBXngCu3x?=
 =?us-ascii?Q?dUrY2N6JpZKMgg9doj9dc8aOAs/JpSrkFPWuu8bVxZFotvLJ+yFxOrfcJY21?=
 =?us-ascii?Q?hZ5MCjhUhdJsEtQMJdWgs+1EwPluadNHg5aBnLgUbK6UaCZWguBO1OPb1mQG?=
 =?us-ascii?Q?w59ef65ee7GohK/mPv+zI5Ahw7NO7bHOG6FSUGJQKS0lIsSJ+XAk6cVzguDB?=
 =?us-ascii?Q?LZzwUkRsWSXcMl217cLqAfBUFjo8HHmeQXKuUwRts/YzQThNnm0uNoh9mqbT?=
 =?us-ascii?Q?LvsEpO5HQAuwX8ZyBRhdmYSzGNY+w3CrZ0ixVCY/T9dgOW++QEC6hKY6qMb2?=
 =?us-ascii?Q?xMMo+Kj+oAgUaom6tQAzvXDceJtlj9bi/i5J3gdKe0HQsyIgb6oD5jQxHrDN?=
 =?us-ascii?Q?ixaIc7HN18c2SaxR46+li0AHFLIbOFYDfOtQYpiNMWwzeP90XN354K2ER0/q?=
 =?us-ascii?Q?BnuigB8dpDNpePZWretrwvbdmLZZhQVL6+5P8s+aPeq/REXbJckrDHLtRQZa?=
 =?us-ascii?Q?1inRgCJca/of8F4Fo66bKM3JT1/ictGIk8VJrgKAyzyh0oMiGlsQBXH9yCF/?=
 =?us-ascii?Q?AHvZ5joUnhOajeLYEbFUTqGg5PBtlsj7jamUob26cm1uqoYSWiO1QoIC4Hj8?=
 =?us-ascii?Q?ZZW7AS+NiPM5OUGM3QfcYzdHXyhXMJRtSdT/DKx57dgj2t0ryT3PmEO8orh0?=
 =?us-ascii?Q?UC5KRwN0lL8FlYLBc9/lc4ytwkW0GzaxVMfoTg/bz0ER+ua24NMg/b/lhyLb?=
 =?us-ascii?Q?HwqTLDTNjlJ+U3Mzyd5N2BlRH2xzgVUi1p47pf9KCFQxfHd4LTShpeutyzFy?=
 =?us-ascii?Q?Q3kTi0a/KVB0Bw2VvEY=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(61400799027)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 09:51:18.0084
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75f2919d-48aa-4e19-3317-08de0c998dd7
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CH3PEPF0000000B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR19MB5580
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDA3NCBTYWx0ZWRfX2JxL8+rPkW6y
 QcDTgqG6wFqGpu808fdmbiuWv5xEUZ+Sg5GVpT/LhOr5slMEHg1p+fxONpn+AihMBZm7sTF1mQy
 8nYwSGyONOugt1RAyuRqojbNoYnF7RN6GsqCvXWTSEaUQCk8J9HtWubtyltDkFo2t1WhyspqnF5
 32TSpLySZFgvGQgXwoXa45SQw55J9IvaWajaVs6YFfhGFkNtzy4lw2ho+Hfn8GARUhjBKS8p3OO
 CBsyanm+KqcUXOZfuwbUFTv786i/vzkH4qXECE4yJOPWaQEFUTBMi/2Vd/sQQuTgLgZvGv71ctS
 DaxBsiBS69EwMZZBxqrIp5euabz2npDC5XXBvi+Ujck4A56dM0SmxkVVyccpDt1v5fNTX8ItcLw
 W5rDLeb4MwXaowuR4SvlaQHjhuTR3w==
X-Proofpoint-ORIG-GUID: 62u_rkHLX88BpbJffUNWYu6Hdow44cfH
X-Authority-Analysis: v=2.4 cv=OJIqHCaB c=1 sm=1 tr=0 ts=68f0c01c cx=c_pps
 a=6Bt0GI45FyvFQl6hnU1EVQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=RWc_ulEos4gA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=w1d2syhTAAAA:8 a=DBs-fRHfoGwBX52xYIkA:9
X-Proofpoint-GUID: 62u_rkHLX88BpbJffUNWYu6Hdow44cfH
X-Proofpoint-Spam-Reason: safe

cs-amp-lib-test uses functions from kunit/test-bug.h but wasn't
including it.

This error was found by smatch.

Fixes: 177862317a98 ("ASoC: cs-amp-lib: Add KUnit test for calibration helpers")
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs-amp-lib-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/cs-amp-lib-test.c b/sound/soc/codecs/cs-amp-lib-test.c
index 2fde84309338..3406887cdfa2 100644
--- a/sound/soc/codecs/cs-amp-lib-test.c
+++ b/sound/soc/codecs/cs-amp-lib-test.c
@@ -7,6 +7,7 @@
 
 #include <kunit/resource.h>
 #include <kunit/test.h>
+#include <kunit/test-bug.h>
 #include <kunit/static_stub.h>
 #include <linux/device/faux.h>
 #include <linux/firmware/cirrus/cs_dsp.h>
-- 
2.47.3


