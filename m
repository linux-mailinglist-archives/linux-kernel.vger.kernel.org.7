Return-Path: <linux-kernel+bounces-867319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA01C023F5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 17:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D7F43AD0EF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489561ACEDF;
	Thu, 23 Oct 2025 15:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="fsFHcWfw";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="Q7mEOAEG"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D0C24A046
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 15:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761234585; cv=fail; b=F6c1cNK5uzS/66oTjxqOThvyUGljwqCM41TCcokOikbBMIR/cbkuo0QejUgZqJ8fPZqeFL5jas/BYZkUUtFjmL+h89xeoTjQoYpwbLUc/syF5bV1oTxNiQirnv+jcJap+E9dkb+ItNLoMIxMramEZe486YvKkQ0qR9gxeq8nyXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761234585; c=relaxed/simple;
	bh=11It8BgFnEx9YFTbVcu0IeG+k0+qx2i+EC+dVcJYeMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n9PfmuIABWPOBseVE6MpdDlECrQsoqW0ZcU1Xmys+DmRiAGSwxUL9mb15LYOtvPXSqm2QYKymcRSrD14V7NUG2DbsRa9l1JGxtVxJFq/lYQGJq0BPWQw1X/2NVStIf3D4AKu1BpvkxC8/FMjQqcIZ2zG18dqYdLDfWJLk+lYHB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=fsFHcWfw; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=Q7mEOAEG; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59N3tFkm3459041;
	Thu, 23 Oct 2025 10:49:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=7C6BReVylQ9/h0LtgbuOirvobKnI7Sss6TuzimHw0fY=; b=
	fsFHcWfw4pw1FuZP8lF9+3/td9LXJ+bRYIpT60IKJwz5ibIAr+mQclstX/r3ErHN
	LolI83jqfRWlwV+ksucIT3d7S2I0K+LKJThacVA6S9THLAOCy9zR8wkMCpWK7LRl
	6IunrYDED/XTuatl6Y1wwkSEtoNasyRpQhXjLZ6ZI6H/E1DYGmBzr7UXZkURE9EO
	I+Sx7jMksV2Y0t4ly08dGBrYSPPGel5h33uNGwKeCQ2bMVlxZw3rye0+CAA2L79f
	WrDF/9RKdZ6po+t9fQJJqzpd6xBfZDltxPYVOBcYE9CAEWc88dgLQTnC0bqf/jaJ
	FJf8inK17jJHuoVD7WV9tw==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11022093.outbound.protection.outlook.com [52.101.43.93])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 49xs382dxk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 23 Oct 2025 10:49:11 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hKrvBl9YwbSyMW7Q87wXNbiDRV9bOyEb6dx5THnoR4rYjB/+5V/sikkIObLnQdPNc9eEfsDiy+nlpfGyNL70bSBAWYOwq+tKNmbBXCFJWbYoskbujEs1v/lcgPTm7TZUIxKWI4tKLmfw+Id3JwOV4kkNbuUJuseq6Q7rLnko9U+ijNhcBbZ3hRC/8JUgLDYmi8NPbX6cRXCj0b/MkL7707VOabBKDl/i1pNa2EMEChi0nkF0nqAq1i/qabfHmn3cYBzed2GZIpJyOOGiYxoGUSHPWPNGzNBC9r9rxE/E2OoiWhP1y5qw31r+aiwaXJQvt9yanBZC27Si/VS7Jem52A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7C6BReVylQ9/h0LtgbuOirvobKnI7Sss6TuzimHw0fY=;
 b=uA4iX8R7g0Qs5qGclxyj0k1+7fgM+DkHl5K4lzuuuSPpehU+fMnTN4fjOdvB7ELOnZJoRH6MnUSO5YsUQ5eSy6HMefBH/iZKUBIL/XUM0/QdII/8ex09GEY21YwZNW7VjrKD8YOjMYKUjFLIsUUp95phc097Kw2CLT6h0ytSWh7Dbwo50vyKkmlll0DjDO5lebFTGLQkB846cYXnCN4W2c/cp5J1W1RfguDx+qnFBJI8Ryd+k/2mIH8vOQLCQyEeAZO3rU8A+/FcPO6sO9E518iPvw5XHh/GuTmBFRSDavQs+9CxynP5oxjmZsB4gGECPAd3+ht80Zh5Vh8QRceNVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=infradead.org
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7C6BReVylQ9/h0LtgbuOirvobKnI7Sss6TuzimHw0fY=;
 b=Q7mEOAEGo5Z912ojuEnsnkaxn4HEiLZZNpBNBghVsF8QIIPQTNEOSYEN5w+cvSdME9EN+xy0BEjj305KzlKbtLGeqsQ5yn7COd8dVZ49kVA8zwx3kssFBHDbX68qKww6izPypjCqDTV3kglvuTS/wgoECj1cHI1rYBOlHoD4uHM=
Received: from BN9PR03CA0856.namprd03.prod.outlook.com (2603:10b6:408:13d::21)
 by CH2PR19MB8896.namprd19.prod.outlook.com (2603:10b6:610:284::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 15:49:08 +0000
Received: from BN3PEPF0000B070.namprd21.prod.outlook.com
 (2603:10b6:408:13d:cafe::eb) by BN9PR03CA0856.outlook.office365.com
 (2603:10b6:408:13d::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.17 via Frontend Transport; Thu,
 23 Oct 2025 15:49:08 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BN3PEPF0000B070.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.0
 via Frontend Transport; Thu, 23 Oct 2025 15:49:07 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id F3DA8406552;
	Thu, 23 Oct 2025 15:49:05 +0000 (UTC)
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id E51F5822540;
	Thu, 23 Oct 2025 15:49:05 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: tglx@linutronix.de
Cc: peterz@infradead.org, broonie@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] genirq/chip: Add buslock back in to irq_set_handler()
Date: Thu, 23 Oct 2025 16:48:59 +0100
Message-ID: <20251023154901.1333755-2-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251023154901.1333755-1-ckeepax@opensource.cirrus.com>
References: <20251023154901.1333755-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B070:EE_|CH2PR19MB8896:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8f4eb92d-7230-42ef-b7e3-08de124bb35e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|61400799027;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UExLGo0zXHnR2cbzfnU6RkrQlSVOSheOX3c1fXjwNpIzRhD4JgS/g0GdPQ8d?=
 =?us-ascii?Q?FH0xUYCrhA8Z5k8N6OdbOf5tk8IZYPkox7gOLxXuyHOXnBfEonmZag/jeaPP?=
 =?us-ascii?Q?rW6Wfq/EGFy/uPL5zBfmA2ELfKSjgFEMnimXBRGuCD1PY2EKrOl/F8yMAvc4?=
 =?us-ascii?Q?Gh0Ck3nh28hqNvfEulZOXDZE7e+Rv+is9uS3kHC4Tw3i+ORMeMVR2UbkNFj+?=
 =?us-ascii?Q?Qp3G+4KSF780qadrzW5cf9K6Rv1RZHw5YmPaN65JqTEuw8hbuCFrYW5zfNBg?=
 =?us-ascii?Q?mJiYzyDPTDk9709OYf9F+RpEfXCZ5NYApAM7tONFnJQlGG9xqgLAqdBECt0l?=
 =?us-ascii?Q?uQNZy/9js0Ii6GjfkOfojVj2jynqmLVcjqR8veLWDAfdmUPXbgc3UIn9nCS/?=
 =?us-ascii?Q?zxnIkq4yNNlW1xJdCy1JcSnJrUsPc9Vsf1YWe7xt8BRSPsObYBpt3FGV/3v3?=
 =?us-ascii?Q?h3CTtKGad9uiWeHz9UrqWoMhzp1oBuSIXm5EwMs1I8COr0Tkcxvk0WXopVcf?=
 =?us-ascii?Q?DAsrQ1pJz6GvF7FioSDGyGKhv35ywWpFlvIe0npGaV20y2itJPJM3Qeu1BCU?=
 =?us-ascii?Q?qJ9lDliqRbiSTJ0Fn42moC8bTUq/6vGRXBEb1FKa85JEHuNiYdZX7XbZbi7b?=
 =?us-ascii?Q?9TbudWEWn3mFSGpHzXNxtZGIBC6WMZPRz/L3ReES9O2np9s/4Hp5Ay818Q1a?=
 =?us-ascii?Q?qqR5TGOdkgt19nY2V+EQkuYKCOZxN+Q04vErwwNrDnyAirDJsFW+CIQ624QI?=
 =?us-ascii?Q?6rx1+yEzuIZqT46WXC9gGGOkX9Gcu3E0iuq+WUcF+KfuZT1v8RXy/1uBgX+k?=
 =?us-ascii?Q?Ba3v4jz/z6tF+YgK/DnJ22wztZaCHkEZuCTY+Kd3PRFT1uxcscwdhv8ZrVTW?=
 =?us-ascii?Q?xA2I4jyUspuAmoVSMYPx7x7qHFRSZZuYy9+iExtkLNwvzOM0Ok91+3zP/mX7?=
 =?us-ascii?Q?oKvb+u00owdt7Snk8hBiEESSMON2mK112zfVnUhHeoCl8Bg6JZewEiM4yHup?=
 =?us-ascii?Q?y7nAn7hJLUVaKAeWaX9uEAkcNixSzJ227wef/Ksm246KDALkwaai/si2csZs?=
 =?us-ascii?Q?Mg9mu+lShIlh6K1apVaU12+9bq8re4ASVy+dZ5vt5MTsT5z4ekXacsfxaUKt?=
 =?us-ascii?Q?bHlnQ9i/VoBRF3PNLHg++04UvXbOlm6khjteJtdNVizBP6Fg6k/1hkGEjEfO?=
 =?us-ascii?Q?7kjwhM1nx0F/YtlNbbskBwxF7nFhL4X4X2wqZOvBs+td0Ve7zhksPArf2s5j?=
 =?us-ascii?Q?wBZcYED8a7QMQ33MQb9g+RREJhXlRlCSN1aU2qEMWaBm5G/gh5MsQMKOHG0L?=
 =?us-ascii?Q?iDANQBdjTs8WKMPWXA6h8wGFzP4peDicDDaXP9PPtsPR2AWzA9gWUnZ4B9qY?=
 =?us-ascii?Q?RwRewhLsxAIRV3LdnmUZbiqVSNx23PTORDR3Hb3FBF9/KbWrmJA0Wxa0ufnL?=
 =?us-ascii?Q?oAc/BN0xO6OSabejrxDzfQ5T0WTy2+xgAlb5QSfAJ1bBPRJkJGenmy2oURp0?=
 =?us-ascii?Q?1FhzsuRFORkEVpiCZL6TA0FMBw6TkTBJibsH73dR2kPOKam/pb7g+c1/P6KR?=
 =?us-ascii?Q?5tXpDdeJm2B+FYv1PA8=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(61400799027);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 15:49:07.2225
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f4eb92d-7230-42ef-b7e3-08de124bb35e
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN3PEPF0000B070.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR19MB8896
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIzMDE0NCBTYWx0ZWRfX5CPoM+Z//Pax
 8eQ3l6UTMNr5Q2iZaDN8eOBAzwK9JxgeTPAQ0rp0OK9fZIt6rmsPu3RTP25CR1ANJJ6U2KM8EpF
 m2z2CKNV88Gi4hYGcSaXErMEPn4dtemQq/axuX1cHgVRl59xsp+PsEOEHMa2qsRVRaZolOd4fZF
 3v4LJEKnprHfrQlJgtL7oMAJ/qK4uWvqS67eE3Sy3OU/OpnTviikdKCXVpNyh1Vo2O70EPwA0oo
 +FtBNU6+QMaCiqIsuzc3ua1wKnyim/uFN9f2LOq5FBdo1SCHKksI68I2nfy/Ix+2ZWvUhvDaz1i
 UpPdUbFke4LzRDQdpPCvCHsslivyviHRXmqC3XFjbHObXQMBjq0Vi9lmvnPDfYrYOznj4Wcpb6L
 QlG6cOpleZXgRdvGEGULuCQPTSWt2g==
X-Authority-Analysis: v=2.4 cv=W4g1lBWk c=1 sm=1 tr=0 ts=68fa4e77 cx=c_pps
 a=+CKpLqsC5QamL8vULJ+FWg==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=QDk8zecZgZoI6ZYqeuUA:9
X-Proofpoint-GUID: PkpaV-FNmC1YnBnTyKegvOaqVyoONyj7
X-Proofpoint-ORIG-GUID: PkpaV-FNmC1YnBnTyKegvOaqVyoONyj7
X-Proofpoint-Spam-Reason: safe

The locking was changed from a buslock to a plain lock, but the patch
description states there was no functional change. Assuming this was
accidental so reverting to using the buslock.

Fixes: 5cd05f3e2315 ("genirq/chip: Rework irq_set_handler() variants")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 kernel/irq/chip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 3ffa0d80ddd19..d1917b28761a3 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -1030,7 +1030,7 @@ __irq_do_set_handler(struct irq_desc *desc, irq_flow_handler_t handle,
 void __irq_set_handler(unsigned int irq, irq_flow_handler_t handle, int is_chained,
 		       const char *name)
 {
-	scoped_irqdesc_get_and_lock(irq, 0)
+	scoped_irqdesc_get_and_buslock(irq, 0)
 		__irq_do_set_handler(scoped_irqdesc, handle, is_chained, name);
 }
 EXPORT_SYMBOL_GPL(__irq_set_handler);
-- 
2.47.3


