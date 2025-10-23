Return-Path: <linux-kernel+bounces-866615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 789DFC003DC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5B5024EFD05
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFBE2FE067;
	Thu, 23 Oct 2025 09:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="ghuYLZfY";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="VZTqbGBQ"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DFE2EFD8F;
	Thu, 23 Oct 2025 09:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761211704; cv=fail; b=LyGKlCLc1uqKkChojdW2qQodqrrMNlKeqJeaeiGTIddC4YSwLG2nWvSCDr+9QSsg2xqNk7fKTj7AH6uUMFIkQCqqPrJtaOXG8cFL8p0EydTNae5TeVU+DA8EQu3SKl/sOIWAV36/crb/VHFbEOCXgG6u+wVUUBGwkM6YmTJWEp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761211704; c=relaxed/simple;
	bh=GQdSaDFT6H7leNNLiZdHZXnPVeHsbiqLu6aR2dighUs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=isq4j/vY+NgBaZnITGQYA7Sb93FMbLXmytkD4XiLS0k2gCDaUCPqE5j/yrMdWHzQlkrRwNrSrWdyObU3Dt1wehHzb5uPc+WFUrRcWKeVgKQ6d9nuS36Exqf3wWmqa/RcZdJGJIaVWl3c83XjKDrRufjyw3TPZ7VCH/TkgpgjxbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=ghuYLZfY; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=VZTqbGBQ; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59MJfFfD3659668;
	Thu, 23 Oct 2025 04:28:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=Ela5opvtkXUyLcTp
	Jd5BdWNr34bbdtiCgdeKvScKbr4=; b=ghuYLZfYp2kVWiVohlTM4a/87jpUq3C9
	zVQOiw5jfn7youNhbVEPUiHhcXJatl8GXJwCndqs9Wjbjc4D+TfwClRwuO8ffKAA
	I4Uz2mcaHpIsLnNaZttU2lqdto0S2BJOjEjN+URTsPjBSjAxic0zg0//G6s8t0sa
	zZrlDSvlXQq0Vjhr9ICEf6YmEEUD6nx3XlZPIH4xA8D3FthTZcvK7ID8nh3/mUge
	fPBnuwqbRdBSCMu3RnYRysR3++tWbq8gsT1h1Z+OhDvffKHDcwkVijQ1eTHmYYmT
	Ny2j2SgfwJDBN0YO+CvkXpwYkKM3heEJ2+mVklMeUzxfqpX69Cx5cw==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11022115.outbound.protection.outlook.com [52.101.53.115])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 49xqmqsy2m-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 23 Oct 2025 04:28:10 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KC0RiHN36wNFjTk5u7I+kGIBUdqhsco6aYcCXbYZpQDj4xDLHnfVndyTJeFuUx+nMylyRZLChSjwJT5/8NXXrSzl/avrkgo/5ju3C24R2m59UBuXc+8MgVA166SYuvTTbKpDq8QI6CR/ifz+pzNdOEjua+Roh0FAnxlVaZwOPtobsKUFCfoy/SCV137rt67IOXYwYu5bmuijC7eApEA6sUsWf9AqbpXtUHVvovQGko23T/k8VwtF0f9qQBobXIw/9CvEONiJbOpUoShhtZEu1o7FXUzXb30oxVrM50xz0sh8Ewj91nOy8hhjFpF8HSVGkyCvd0IW5dOWmE/X47IbFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ela5opvtkXUyLcTpJd5BdWNr34bbdtiCgdeKvScKbr4=;
 b=iBzyismYe10UhC56GuAQNF1yq6VbxtzvMwF7QOVYsKz4H6n87wr78KH99RTe0PQGFrN3ZmexVyw49cZEmY2tQzLcPZ+FyankgOZ9xmAmlD3xjPVFAEu9zAJ7VAysIAF0WFzhKmXdONDtVk2EMz8N2Q+a665YL520+Io5wH2BDE8BPusn/frZrjeyBh95WVkWiyZId/6cmkZUuUJ+GbfqUHeF82OcV1hKMe6cxDKDUsu8uhEqHlCiR6euO9rA5ft8zx6tsGly/iRFROA21ZYhkIjSt6G8OwqVKR9QCFY4BGoD7DMWzoXoTeuCCkQPCFhsm68bvK7UAdsc3+GnBN2v9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=alsa-project.org
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ela5opvtkXUyLcTpJd5BdWNr34bbdtiCgdeKvScKbr4=;
 b=VZTqbGBQgT0V1w6uelgt3ZWRWNr6jJzk6BQXxacNuJnQCbeoBpjRp79hI3d2xsrPWxqSfrfhfpX8OAy2P94q+YQHdU7Ye5Us0VVSsTDtkVTCb2l9ndfO6uyaOy3WYsWXLDN7e/E9VlCubs3t+qDZxrr3FeUGzhIZMW8KOpx/Z2k=
Received: from MW4PR03CA0117.namprd03.prod.outlook.com (2603:10b6:303:b7::32)
 by LV8PR19MB8598.namprd19.prod.outlook.com (2603:10b6:408:264::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Thu, 23 Oct
 2025 09:28:04 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:303:b7:cafe::5d) by MW4PR03CA0117.outlook.office365.com
 (2603:10b6:303:b7::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Thu,
 23 Oct 2025 09:28:01 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7
 via Frontend Transport; Thu, 23 Oct 2025 09:28:03 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 883A740654B;
	Thu, 23 Oct 2025 09:28:01 +0000 (UTC)
Received: from upx-mtl-008.ad.cirrus.com (upx-mtl-008.ad.cirrus.com [198.90.251.5])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 63CDB820244;
	Thu, 23 Oct 2025 09:28:01 +0000 (UTC)
From: Maciej Strozek <mstrozek@opensource.cirrus.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maciej Strozek <mstrozek@opensource.cirrus.com>
Subject: [PATCH] ALSA: sound: Increase max size of components field
Date: Thu, 23 Oct 2025 10:27:41 +0100
Message-ID: <20251023092754.84095-1-mstrozek@opensource.cirrus.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|LV8PR19MB8598:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c5dc4ae8-497e-42a7-45de-08de1216774e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|61400799027|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xbeN+Nf+tTT8B6ksAjxDniQsigzlTjhMkwM2F62MQuzuwQLvkMr8fVjJ6G1X?=
 =?us-ascii?Q?m00RnTvF76g1aee1FxCN3u436xp7SkhaatGy6b6e7dH5XrfxH7mSAQ4nYACD?=
 =?us-ascii?Q?FjFXaDTalK5zYBj2Z/szKOycTSjfcP/YiSSoOWU9TWvcwf7mKbRIQuspuikK?=
 =?us-ascii?Q?D73EoQFEXt/rAclyk9D/DFSK4zpVDhvC+NQs8EU66N86WyWT2gUql0VE16GD?=
 =?us-ascii?Q?DSV8qXF97jlxu2n9UAZRuleP8O+lo/A/BZnQ8zthkbJnNnfcsODg8xJ154HR?=
 =?us-ascii?Q?yYOdTW7u6ypAOmnNcy+nBqZHN+pLJfn1xfZbgbPyB9cpcnvhhjiSyaCnz0zZ?=
 =?us-ascii?Q?i5MLE8nEbqN/H0aGJVu8LWTqW4zNQs7rFSzoONEeWW4blBXXRoxrl8q7E8pk?=
 =?us-ascii?Q?pZOBc8txxe5k+fvfRb752FmLGgF43tPRexwiRfIN59Lm+Len5QdrhczC3bfe?=
 =?us-ascii?Q?rm7ayqg47bWAXuXDhbOStGUA2NZmaMzld9NdK5p6xNorDCeR/tTv59XyHcPA?=
 =?us-ascii?Q?VIwtIqw8ZhAZ7Fbpj64EG47gyfPp25/7RiRaTDY18jQcLvSH7umetfjER4G2?=
 =?us-ascii?Q?9MPIhmb8w3GEfkZBeyMnC1GAbOHXcUxL6SNXGORRehmIL9oLYzGWdJlfRY4n?=
 =?us-ascii?Q?rNT5kkO1WtsPjQj2JGXXBTC+dZP2HeJPdf8oQvoyi5ZYgEqY6oTsbkRvt5pm?=
 =?us-ascii?Q?9VAj8+paPBRhc0Ge54SxJUcSlibhaVzvDWdIgdluLvxrQPu64GHPr8pwg8fd?=
 =?us-ascii?Q?XjFlSgadIrsC26N69l4eaz62fZekQ+znRCgi1OrfGFAd9y9pFwgz7Jy5gBkR?=
 =?us-ascii?Q?/DxmjpqwZ+geaCPYMarTMAIEzI1ydE/y1CqdoSEJ8dUnFtt5DvZyxaDf0LHP?=
 =?us-ascii?Q?ixi3l9AbheOmc+y95iaYTLv7C82xavN9WeqOwfaUtC4Jg2yTtwgYZMErQooz?=
 =?us-ascii?Q?BaW4cuqb5mUypb7dJKNqXlFcJWR6FKNe2Y5az0HBeNSE+P48Rp7dduEtgRmu?=
 =?us-ascii?Q?CZ0rwcn0HkXkUmCbCuM93MmuPfnrYcgPzGLY5o6PBliTuLdH7Z4qvwKqF3nN?=
 =?us-ascii?Q?j81aJWiDxzP/8ds6xk4QBplv+0QREtkbTB94NosxnXcORL7AVk8DKJYICJZ8?=
 =?us-ascii?Q?Zzu+P+32TmSua0oT4xQtMpaBYlW0l5dtCpfh412s4LROW4MxGv+r2awafkJd?=
 =?us-ascii?Q?/2e9ohmEqB4RcpjquXFOZdSwo3Bt7ZM8GvCrOz8mmx3TylPb/CnBE45XTZSc?=
 =?us-ascii?Q?3m3SJ28GLfAXA8Wa1lKADVtKSAP88hWirIiPmOhwX8rTAVOd+oV1E2kf+9+P?=
 =?us-ascii?Q?pj8nPnoSu7Fofj97RBGly9gBNydl8bFuKyR3ofaFZQOIHJc15uc+dkYoIRqi?=
 =?us-ascii?Q?pjINzVdHW5XhHvyWVIGBOc/K8Ir9eBsfACY+FyLW/GhEGfZhklcsA8/7ovTa?=
 =?us-ascii?Q?HHqV9PvDYnd2oax3anqvM3EckLIVwHzfQiltTrXjjvaszgubQKIHyC+thS8C?=
 =?us-ascii?Q?pq5ItzY6riFvq18O1h0P2hAjUgw51qscI9yC9J2bTo1xqtaBXeMEjsbQSA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(61400799027)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 09:28:03.0042
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5dc4ae8-497e-42a7-45de-08de1216774e
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR19MB8598
X-Authority-Analysis: v=2.4 cv=G6gR0tk5 c=1 sm=1 tr=0 ts=68f9f52a cx=c_pps
 a=eiJXeYcBrKiqJN7PW0oR8A==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=1GJU7IM4rHDAiQO2ZLEA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: A1HQrKTQ0zA6ortkWuE1zggKJ-z5Sotu
X-Proofpoint-GUID: A1HQrKTQ0zA6ortkWuE1zggKJ-z5Sotu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIzMDA4NCBTYWx0ZWRfXxbUpOlUlULUt
 fRkTQOQMPzj7Ttw0+gAkLLS8ETyyydQZci7Y4gwMwJnqWJMjiXP3aaHv3wHrQDbddc9Z/r6AEIQ
 jLyu/58yBdV2XSeOgb1v/6QyktO1qXJk88Ym6S4MfmJgs/f2bwc/rBfR1eloDw42DJqBUoG8fQm
 hpvXzILA+RgtXnaNZiQ/77xxDeYwNrznkgeS7mUhsB/t5Q6a+L3ywyHRskuhjg7bihVoXQvcKEO
 1Hc/VPwRSsKoyS72JjNf/7/1fSdj3anhgRhzBJGuYv+T8mChk1vGIu+thN3DHlijHmRy3ATIk7J
 WawxMMizRlX4jEXaAeqWUBEuJc9bqCLTfe9vm7bykydpSKElPqMgPiSdoXGD7KaKTKdhB+XoLo+
 +j2er9ucivi26ywwpREpL/jGaRCLRg==
X-Proofpoint-Spam-Reason: safe

The components field of snd_card can run out of space in new systems which
use many audio devices, hence increase its size to 256 bytes.

Along with this change, bump the CTL protocol version to 2.0.10

Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>
---
 include/sound/core.h        | 2 +-
 include/uapi/sound/asound.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/sound/core.h b/include/sound/core.h
index 64327e971122..0eb2e3ee0dd5 100644
--- a/include/sound/core.h
+++ b/include/sound/core.h
@@ -87,7 +87,7 @@ struct snd_card {
 	char longname[80];		/* name of this soundcard */
 	char irq_descr[32];		/* Interrupt description */
 	char mixername[80];		/* mixer name */
-	char components[128];		/* card components delimited with
+	char components[256];		/* card components delimited with
 								space */
 	struct module *module;		/* top-level module */

diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index 5a049eeaecce..c302698fb685 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -1058,7 +1058,7 @@ struct snd_timer_tread {
  *                                                                          *
  ****************************************************************************/

-#define SNDRV_CTL_VERSION		SNDRV_PROTOCOL_VERSION(2, 0, 9)
+#define SNDRV_CTL_VERSION		SNDRV_PROTOCOL_VERSION(2, 0, 10)

 struct snd_ctl_card_info {
 	int card;			/* card number */
@@ -1069,7 +1069,7 @@ struct snd_ctl_card_info {
 	unsigned char longname[80];	/* name + info text about soundcard */
 	unsigned char reserved_[16];	/* reserved for future (was ID of mixer) */
 	unsigned char mixername[80];	/* visual mixer identification */
-	unsigned char components[128];	/* card components / fine identification, delimited with one space (AC97 etc..) */
+	unsigned char components[256];	/* card components / fine identification, delimited with one space (AC97 etc..) */
 };

 typedef int __bitwise snd_ctl_elem_type_t;
--
2.48.1


