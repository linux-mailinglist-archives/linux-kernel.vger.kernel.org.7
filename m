Return-Path: <linux-kernel+bounces-856019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA7BBE2DF8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 12:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58BD81A635A5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 10:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B4131A554;
	Thu, 16 Oct 2025 10:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="IvEHojv5";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="z1HlE9b/"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F84299A81;
	Thu, 16 Oct 2025 10:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760611377; cv=fail; b=nr8vh7aX+59BG4bfQTi8lLO6wwdanX3B92UPuv/T1cmrVqoFTtf2KRk1wgrL5LvkfMLBsM5ztlsIrgUXv9sjOjfiNJzbnJX3IWGjwXKQzB8Gl5dDVmYcj3xgK/hiJnOzo6ZMSPdZ0KkrhH7ZO9GMjjZhReKNA7vxBt4oE/iu75E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760611377; c=relaxed/simple;
	bh=EhhVUJvM+hFWbHiAu0ArIVFzvM6wszKHbocZYNdwRMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=maobrGHTU72fCQOdLDuMLpJ1gm+dXWlQ5ZzHJ9XDSaPLlsPHZwxobSgxFdigRQj9VG4ORkp7Y3vVjCGhn0BLdSx/PwASdNHj4yJ96SLEWLReLVDP3ieiUIO3Yy90FZ6OLb9Yp1QWrfFmYO3+GbUQUSndOfkrU/QhZ+J0wyy2bo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=IvEHojv5; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=z1HlE9b/; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59G8fDdD2477160;
	Thu, 16 Oct 2025 05:42:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=mrfh3MlKc8P3eMenEOCLL5AQM+xNt8AaEnwlp/iQqZQ=; b=
	IvEHojv50wZ+KpGH0AHeKA5y5cxT5uwgWfvttUDhRpH4ifLKP6OpFssh6UyrmtIe
	tPbFHzWWulm/AcSnG0SUErHBTSIB9NjqQCYQrnEg1GstKtddQqxFbRKDeFFtX5EK
	OLjTggrJI4kFiEs1IsrFUeK8ZUi3qAObFSMzy8LEFhjepZyp2Np3x0PESRNOZlrd
	8JLWSZOo2DkYJMirBM+kMCpntWO6MAnJMiqL8tEX4J8SqY0PZDfHaYkDbEJbFfLe
	vpNc/xeEDcL/cymCARPKugtmSQs2UCqtgbAZwVb9VWBR10vjJMbJV99Mj/eiip+v
	1XV+NjKBrOZCPLDUO2F9aw==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11020073.outbound.protection.outlook.com [52.101.201.73])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 49t9mhhpx4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 05:42:52 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sbcoJ2AlcnlM0Q7jpKL8lOcqBHQVy3TvdqO6a1GN0ltqdrGjKUUuPVmG20ePD3Kgnf+MFN2SEIVk02NTtsMWZMYIPEWjcnUOiSzATUBjdgZQtMKdsGm+6nsWXDTKICH2Sf1u9e8FZiEEzYnvfW/+eMx8fF7/bXgS6ynjhKwCMERTPMFAVNljF3D2zXfb82CK4v/IP9O9ANHsb5wPNbcmoD/HfDJNz5zfPRT4SR0kDAEj4v8BsjE1ce0C6LUxdW4oZDo2n9CMHGQ4vPL0es182h4/oikQ1zpVUIKqFakG9mSq2T7jVDhqQUpunAC4hyOSx1O43U4HC2BOUJJ9+t9KkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mrfh3MlKc8P3eMenEOCLL5AQM+xNt8AaEnwlp/iQqZQ=;
 b=aqlCpjfodj0wnbMa/RPx51+VxYypHxbaGWx8pbKtsFvjLUfe3CUUhvyxD8jjBEypbNLzYxO0QNHpWit+GMfjhA1kFBaqf0XVNAJp1Ss3CxYXYcI220cxX/uS28zrBk2oH52pjG2/hUKFInHFzzvxWyh7vLAxcLg6IjPfMj98T4SvXz7LTpSePFs3SbjQoVFEo3YTRZCCxe73GMeqvU3MWS3yWsPFGI6jK6D6kS1HaxIlkgvoO2GCMs2VqhBcNSVPMnlQU4wMli5TTDvZPV/9hSz3euU8l0qunTjqLOi9GLbzrAa7AihswZ5xWPmcWHgiTKDtPSFawURvTwA30Ne6hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mrfh3MlKc8P3eMenEOCLL5AQM+xNt8AaEnwlp/iQqZQ=;
 b=z1HlE9b/bEVxtkMlhURNLIztO9GbwS6hdawKScR/W4XvCgmxwb7UCDjmPDRTo/belGtVKlZkq/4d8Cr40o+vB1JGI2WXsXfxmRai9lixHWks5ZfkKzuhKJinIB+/TuvklAQ1Go6sDWm7OJAE9i6n7qKbUx3QaJP99rrRCShvGXc=
Received: from MW4PR03CA0274.namprd03.prod.outlook.com (2603:10b6:303:b5::9)
 by PH7PR19MB6506.namprd19.prod.outlook.com (2603:10b6:510:1fa::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Thu, 16 Oct
 2025 10:42:47 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:303:b5:cafe::13) by MW4PR03CA0274.outlook.office365.com
 (2603:10b6:303:b5::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.11 via Frontend Transport; Thu,
 16 Oct 2025 10:42:47 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Thu, 16 Oct 2025 10:42:46 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 1620A406578;
	Thu, 16 Oct 2025 10:42:43 +0000 (UTC)
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 05154820249;
	Thu, 16 Oct 2025 10:42:43 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: broonie@kernel.org, tiwai@suse.com
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: [PATCH 10/11] ALSA: hda/cs35l56: Set cal_index to the amp index
Date: Thu, 16 Oct 2025 11:42:41 +0100
Message-ID: <20251016104242.157325-11-rf@opensource.cirrus.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|PH7PR19MB6506:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e894d21d-be29-4ce1-f235-08de0ca0bf0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|61400799027;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5vSP0s9huQ4xIbJ8QxVpLK2lpgsIq3pUrLWvuBqCi/ZCEVjZTqnlgmoXz6Dy?=
 =?us-ascii?Q?yHYBnj+zHviddAHy/z01f7WnyAcHcvN48Xu8QnejMv6+Ast7Ik4IZzH7rFH8?=
 =?us-ascii?Q?qs4xgMJYQZchXg/1dA8qyqMQonH6TWTKE1zgid+8VOQ4o17LzZPBmz8uK9Tz?=
 =?us-ascii?Q?Xlw/D+wnW3WM/snnoPnap5gRYcr92bN+iljelqoJR4I7b3tPbTtz6JuFigQc?=
 =?us-ascii?Q?jkHkc9Fe026LaR764UYU+2Dcygor2Pz1xPnTYkMCkCFOyVsKkuVdFHYBFuKS?=
 =?us-ascii?Q?BA0zNMfUk0OjE54OBip1k01W92jh2YeI6whlRiHmpViQPrjO5z4sAdwrcp56?=
 =?us-ascii?Q?/99qGiNWfGrCbR2AcgzrzRsWBSNtZjXKOSaalj9Ckf86aAcLpVlXdfDAPoWu?=
 =?us-ascii?Q?aoA5vkdtZtJ1mSULfAAfkqYgCN2h08sWfLQa7KtnNZhIKm+/cbXJuRnYVxuq?=
 =?us-ascii?Q?QhUOkR2RBhjNssGsTXXcER/YPMZjhyg62diGKD4RfZVE0zczm/s77S+fDGV6?=
 =?us-ascii?Q?/YiJwYCh6XOrA/H9PKZ88AYQgyIw+BcUQb3yNtHt0aAj88dSiYZiPesKi22N?=
 =?us-ascii?Q?5MF7tD9pY0S7b/XYA4VkMhYOeEULh/iWC7jM1Sv40R7KzU/cRnrcKHAy1aCB?=
 =?us-ascii?Q?IlmnrlDuzxXP+aZkIwgm9vCHWyPH0L4XlkUrmV83GdMpb2sYmbkLsRnp4PgY?=
 =?us-ascii?Q?Y9c8fTVSU3fnJxiVRa6PPkiEywOgzNp3wFxp4HEGba8Usgm2Vi8/6iwdw6Y6?=
 =?us-ascii?Q?gsam5WBjJyfRQp4/zIJZjz6E1kMo+BTXlLdT7RNo4yvLK1pjSYpkf5bIF2W5?=
 =?us-ascii?Q?37ezMR4qTxvqGesQblff6fRfRoJFqACbBw1Th02b5G+AAXf+nZyRJTPCXt9O?=
 =?us-ascii?Q?qt2aBGJgvkueyIAocbil0iaD5a6trT4rXr5+uLHZ6f2BZHMrNXyho/VSTf6a?=
 =?us-ascii?Q?YR5rDYjTmtoEJrslkr5BJyPdNYxSNoswy9H4bgh2QAHpcx5YlVBHfjq1G2BT?=
 =?us-ascii?Q?uxlcvYFyQpdF07l1a4UXnbDtvVgaHUxgDqptHhHsh92ZJ4aHArVkPq5TbIA4?=
 =?us-ascii?Q?Hc3iJ7TFmPoA6/W2k2m572WDPxpj3ffC0oM9VJqVcO3plysf9acjSeglQ+CJ?=
 =?us-ascii?Q?MdFXZq5DWMtwI94eFHEwBRJy6yHhJ8vVig/NM7gen3qkExjEDmx1nQu798gP?=
 =?us-ascii?Q?DlyI829ZnzM79oX2HkoXy1tWtARsZYPiNRMMIfL6P3cVL06pXF1x0I6Uhy/R?=
 =?us-ascii?Q?5uSs1CAc5QmqaE/qXlFAiuUBsrcz9SkxzQ2e8gDaPniym0blSTm3QyJIowyQ?=
 =?us-ascii?Q?2RcZE84ErlT0LqgRTAHQyvBfMk163duXNfYHKrjdLszYDXJV9pdo0BkIGKCU?=
 =?us-ascii?Q?uC+XkR6nc6Cl2Z+wGHyKNBU+/IiTb+mndF+rLnGGaxlLz98NpaK3Jw8CZ94n?=
 =?us-ascii?Q?TpVdR/rQfWswNwZAUBQBGn0c+oZx0kJbZOjih+WG7x4wK9NRuWARjBVp+eDt?=
 =?us-ascii?Q?wTmlpPkw6yH90XXXOxdajxN3wRZV1by1l/S46n+siwxARRcGdkQAyt3+BOge?=
 =?us-ascii?Q?2Y79VEsJWvqoyYCPs5E=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(61400799027);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 10:42:46.9375
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e894d21d-be29-4ce1-f235-08de0ca0bf0a
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR19MB6506
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDA4MCBTYWx0ZWRfX3SUOJ6fVZonr
 eO4sTnsKQjgelZ6PgOrygXMzemexBxapVNDClGzIdRXAunrsRP/ChecImJCH2y6Q9IIwpYWbJM2
 nH9iTWJ6/HkquRFsp1+HeONMMUapfrU0Uq6ilkDUMv53lchl3X7iOn67aAeT/1ScpC5LmM4qTTZ
 HHotB/8/RCx3c25wAQGe22uvFtvDod2s3oM/4hjmKKIcqCZx0mUGHbTOwFoFr3srD7Mm2QQW8/z
 lhkum2/G68yIgeU0Js7VTRHiDR4I+rvrqZWoM9MVpwKXil/F4Fh28BlH148oGvmjraXjCkIyyrd
 VGNZwzShiOoaVtWalSZyfccXtrtwh74sj0MBXzLExM5U2w2+AW4vsACkdO9VvKeF3j0rwfiLZME
 huIeuAqxdKHQUKhtDWgROLPGNotx9g==
X-Proofpoint-ORIG-GUID: dZXpJeGJgUuVFgwUrynO4_fN8YQc2Cac
X-Authority-Analysis: v=2.4 cv=OJIqHCaB c=1 sm=1 tr=0 ts=68f0cc2c cx=c_pps
 a=kTz8n/oXhugbiFfz+wFpMQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=rJdgk25NQal2zjiPUrkA:9
X-Proofpoint-GUID: dZXpJeGJgUuVFgwUrynO4_fN8YQc2Cac
X-Proofpoint-Spam-Reason: safe

Set cs35l56_base->cal_index to the (zero-based) amp index derived
from cirrus,dev-index property.

This is so that factory calibration data will be written to the EFI
array in the slot equal to the amp index, for compatibility with the
Windows driver.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/hda/codecs/side-codecs/cs35l56_hda.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/hda/codecs/side-codecs/cs35l56_hda.c b/sound/hda/codecs/side-codecs/cs35l56_hda.c
index 4a1bd934887a..19baa8be310d 100644
--- a/sound/hda/codecs/side-codecs/cs35l56_hda.c
+++ b/sound/hda/codecs/side-codecs/cs35l56_hda.c
@@ -1179,7 +1179,7 @@ int cs35l56_hda_common_probe(struct cs35l56_hda *cs35l56, int hid, int id)
 	}
 
 	cs35l56->base.type = hid & 0xff;
-	cs35l56->base.cal_index = -1;
+	cs35l56->base.cal_index = cs35l56->index;
 
 	cs35l56_init_cs_dsp(&cs35l56->base, &cs35l56->cs_dsp);
 	cs35l56->cs_dsp.client_ops = &cs35l56_hda_client_ops;
-- 
2.47.3


