Return-Path: <linux-kernel+bounces-776142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DF2B2C912
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 18:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BBAF5E2313
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 16:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B95E2BE634;
	Tue, 19 Aug 2025 16:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="LhcppzNQ";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="WIRJvAnl"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6DB286897;
	Tue, 19 Aug 2025 16:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755619554; cv=fail; b=Jwx7t8SKq4s2IBZxosyeuvfnUcw23vFPCKELroipGgf48DMRd231t9Duln7eIPFPXzQSOJrAIQmSHKNSzcDvZ08TZczm8dvNqV9HtqVcRID244SYkcS1iwuMZB8uD1Qj7kAWjNYHn6X+k4FRYvt4No1ancYjWmWjseunpgL8RGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755619554; c=relaxed/simple;
	bh=eFA+it69royD5SV8yGq14RjbuAyk3V8M2k8MfUrx4Hs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=orCh7cFMxKPqib1RQ2G8Enlckwv6jxIsnOYjV4YeQXq/e4k7vsuwT3wOMOLZjVii2Of1vj+PrUljcIr10lEJZetdov4yosZNLf5yQU0RyfRs4G5jNvvakenBAd2K3Xxjcu/aK50o/+EkNOePqzuF7T2mHKhYjx6GBoaa69J09hs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=LhcppzNQ; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=WIRJvAnl; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 57IMpaYm2032571;
	Tue, 19 Aug 2025 11:05:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=PjyWP0EbvrFnU0FG
	MJDyiYU60hrqDYnlNWqq1cEYCRU=; b=LhcppzNQp3W5zXwbC/9RbzeqmezCE32x
	wNQ1ivhczHpXMnjwAz8bLvj/7iwp+/7yGw03sGwKjbMNpPSpaKxEbwpyjXR0Zz9i
	WqcLRZuabZXBGoE1kRtM6MKYoQU9i6ZvOwg5kkYqjGGxUZtlIzbsBjSFSXpiA2hi
	35mqmovGYVUAMX8zKedH9Sh9TYSF9wTG7FnoW/bkOVQRV8M3xCj+6xebEL2VDbSH
	25JNmvsd0qStbtWg/NbGdQNu7swtXwWroGI2M3DSvxd+2Dq/zdRZH7fpxDvbTMP+
	LmAk7yhZN75kIbTDZ3OgYRzPJS8R1XopjEtYBWBOiY/uXV5vh5dsQw==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2092.outbound.protection.outlook.com [40.107.93.92])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 48mdbc99jp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 19 Aug 2025 11:05:33 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XUkzvdMhcmERXk9SzPsfh8NzZOpjEgS5k4EEcml/TIBIeFTiyFPipBIPNGHMaOyEt6wo8UkOXpa7IP/W8bwBuRqU0qFyXGq4GMR1QZTo4IIjtWJ1LkyQvgIj9Yr+TUjOEU34pbEiXHASxa/PY9oWlEB+0uh3Oyw7yg8N6mb3ftREXBPGc3kQYkRKj6VP+8QoGK7l+PmNFMFPKlfT/7XnvsoPNuhiY60oNqhQhWzsCpV0RaF732j0KtI+TPFToOIjD8+ABUQwxfXKEOxlGp9x1Huf4aDiRUZq1uWjD3m9mD1+gFF5kjqhp6kA6Ni8VmAeY3g/JHX7iMW6PBVDUndIEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PjyWP0EbvrFnU0FGMJDyiYU60hrqDYnlNWqq1cEYCRU=;
 b=uZP3LXLN+MK+7JzemPFHt0Yp9e8pRkSsVPcEZs/BX1KpKsh98dx2JzmiN7BnO63nXmLlSAzJEaqtEakSZwCUx2FVcRfntqK0fodJPQMEnCHtci1e0bTEzrAIv6+HG5nu5lq9HVtbO1LW1i4bw4Etc0EZztfSXxeoYwhhG3ohhZTc3AfQ900laaIQHL8Iy/R+Y80fLqh9R5rPBi5ZjRkPb1mjz78OZKL21kJ5IBVeJ9BJDf9zahtxh0L7KtNDbDHVLj+L3vdgoubrSEDHFetnPevREywR1F8nsmu2TGtYOx7iippcOcmcOpbvCJIGEoaQDxyE2i3SrNJcU6vsewhCAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=alsa-project.org
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PjyWP0EbvrFnU0FGMJDyiYU60hrqDYnlNWqq1cEYCRU=;
 b=WIRJvAnlAFNGdbqYqNLcXANsgCmZyDyn1ziT1jM8+iWl4xI+7CwxDAsvGn9VzrK2mB6WYyDqiVRqV7+Xmk5fxBruPSOO0U/IPxGHZzeGNseqsh+u6/TrBlrwo9wmsqRL0OCKSkHgbBXCKVWk2TZdJYu8dx8m/9El9QWKWd80gTw=
Received: from CH2PR08CA0005.namprd08.prod.outlook.com (2603:10b6:610:5a::15)
 by PH7PR19MB6613.namprd19.prod.outlook.com (2603:10b6:510:1b0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 16:05:28 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:5a:cafe::c7) by CH2PR08CA0005.outlook.office365.com
 (2603:10b6:610:5a::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.20 via Frontend Transport; Tue,
 19 Aug 2025 16:05:27 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.8
 via Frontend Transport; Tue, 19 Aug 2025 16:05:26 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 76DE6406547;
	Tue, 19 Aug 2025 16:05:25 +0000 (UTC)
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 5D730820249;
	Tue, 19 Aug 2025 16:05:25 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: broonie@kernel.org, peter.ujfalusi@linux.intel.com,
        yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com,
        kai.vehmanen@linux.intel.com
Cc: sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: [PATCH] ASoC: SOF: ipc4-pcm: Fix incorrect comparison with number of tdm_slots
Date: Tue, 19 Aug 2025 17:05:25 +0100
Message-Id: <20250819160525.423416-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|PH7PR19MB6613:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 225990bb-c734-4ad3-4df9-08dddf3a3636
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|61400799027|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xN7NmRZcUspysO/MzXvrY02K41YHk7kZOVF4snlJ20o7PCwizScHv/msQy3U?=
 =?us-ascii?Q?JX3LKYqPFswY6Bo8SzAQSRdeQNK5bOIlwoL+hMJN1wv49uqj600EXDd8bZo4?=
 =?us-ascii?Q?eZKMANlxn2DcezhPrFruPnR5+MPXAZTFyqnPZTQoOyo5H9CAbRgRdyWDsmrd?=
 =?us-ascii?Q?8z8Np1QziO7HtAZsI7DotqO1NU1JsJnVnMJIDHAXxK+EyS600XcodMzP2bEQ?=
 =?us-ascii?Q?ZOTIdxc5QZ1+icTW7ynaOxWnm1iBgnkVSPI8Nwr+nOiRSE7ZljZU4Ts4Ti9c?=
 =?us-ascii?Q?xkKBbUPe0Y6aegyn5C/NJAuwAzEu0JrPd6k8lHnDvrc4ZDN4Saw5v+xCmx2t?=
 =?us-ascii?Q?LQ+MAWv7AqnyfjJpZs7i45Wnt6U3KbqS49XyvkRFg7Yl/UlpxcuWZTLqCt1J?=
 =?us-ascii?Q?jIPaCCSO/5zjE4KCMFfTsS3IneIIJ4+kjFwMVQfdG2s3ot5w/2qV4zwJzjiw?=
 =?us-ascii?Q?P1nIgu64BBGzL5C4ZXUSnxP/yr742q3oQ/ma58dYrJz6Z07J87XgSPL8t5xz?=
 =?us-ascii?Q?7ONTlw5XOBqBEdNURSF6HZAYLB7U2B9GUPBEeRZXuxk0PqWc6ifOoh0HIhAQ?=
 =?us-ascii?Q?b372XV3N8OqHv2PQxsQ872djfrJ6DOficWr2X0GSS0vSt1OT7uRvKiSxlFyO?=
 =?us-ascii?Q?PWmXYgf8QmYlQOhbC3Qp4QcVpIJfnchVIMwaPl89zxU/gFZza3AlF/JYvpXH?=
 =?us-ascii?Q?ysBqQ9QhFeg0qXoNk4TFqsKtbISPGooH1Js/t/udtQsTvsQsqpSBFZ9P1xz6?=
 =?us-ascii?Q?S82k8n3/pyBLhha+zmVFp5t7DTvPeiovneYa7bQZHQOfv+BlHSoBoaPQdbee?=
 =?us-ascii?Q?C7EksT5LxoutmLRqS8uXljjJp6i7y1wM2+PCyXBUd9Ub2fqUB1usKen46uRu?=
 =?us-ascii?Q?+Jvh32H9oDKujGYl9hVaiA9O6KKzFeDwB3rSkt2eEQZJ5X7IbNQmq3acptFd?=
 =?us-ascii?Q?DViTWGmSQ/xpUChEW39PY8yVQdKoMAtwU56IWp8alLHhq6+vjMxgHyNGQ0Vu?=
 =?us-ascii?Q?kgj7Crw3M1DVRtSmIjE2eCk7Eh2xiES3yZ5n8HOJUIC33iE8FWnHFxm5M2l+?=
 =?us-ascii?Q?IONbB0ZwTOMVVFk+Tk93d6zqtd+WxvBS62rQOQrB7BKhpEdU6l05zKWWAQh3?=
 =?us-ascii?Q?OqVf5OyEd3cH5lb8qWcdqVjP1BKV/rR5rcHkTVGkQ9dObG00pKjq7K9DKjy2?=
 =?us-ascii?Q?zaAJ45OZouYFsodN8+JOwhTd8ULfjumvBoZ5JFZY3EuPWcQbDjqGEejr10CN?=
 =?us-ascii?Q?U6u+Mfz24D/tlp0JdibW8Bz0u4aps072Rgi0eIDKXX/AdoFNo4+w9ZJ/wDFi?=
 =?us-ascii?Q?5hi06EKfgEVmhBHSGXYl0IGPsELVRVc7I9M42YngPYuIBBx3oNGfaW+astPr?=
 =?us-ascii?Q?/8esuqJfaHWmsh3HyWN6wOHTR8z2Q3tnPomhvtqFABovNjSKAv/ErxjvJi+0?=
 =?us-ascii?Q?Lp9DXPT+KulC8+dhvFSTUKCEgdw17MfC0/TqlQR6szj5kNvbYR2Mt4QmOQEa?=
 =?us-ascii?Q?WdrTm6mv/sNF1d14Tv5BqAkdPT1o694NLpNu?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(61400799027)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 16:05:26.4730
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 225990bb-c734-4ad3-4df9-08dddf3a3636
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR19MB6613
X-Authority-Analysis: v=2.4 cv=SPFCVPvH c=1 sm=1 tr=0 ts=68a4a0cd cx=c_pps
 a=r7KzSfrYGOUIMoyRl8H3Xw==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=2OwXVqhp2XgA:10 a=s63m1ICgrNkA:10
 a=RWc_ulEos4gA:10 a=w1d2syhTAAAA:8 a=hhZaFHulF5nJkzhaXGgA:9
X-Proofpoint-GUID: gNpYfgrNB5lztOvfqcEZhtwzj7MCeeSP
X-Proofpoint-ORIG-GUID: gNpYfgrNB5lztOvfqcEZhtwzj7MCeeSP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE0OSBTYWx0ZWRfX8HMlwWzp3Tgr
 fsU0EDpXF83jjL6z1wVEXW7GKqG0Q/evHGATfvDesm8ztwbBPB+mL6zdQpHaHr7yiPzznFDQOeA
 Xt9aSBnKhe5Ozmx6yxc2juzt7LRp0ZmXqghEd74y/cTxiK37uW7POZaxQgnI/facO4OFBpYmw8L
 m6jb1sNagMmzUJ3LVa6e18EvSm0l3zUTI2TBabkDl2YYA5zewThRF56QUrP257NY4uaOgV+NHGb
 vsitZjpDPY8Qiy1k/e6JHPlu5AuywxPVEBAukIuI/GGSaiIPWiCQJlsGY1cEtlcGRhnJm8TS4sJ
 Xjy1l9dHdBuoanqzK7KTSDplapehRd8IthpYAYZwE7LVk0Yf8x7vLp1KU29k2Y=
X-Proofpoint-Spam-Reason: safe

In ipc4_ssp_dai_config_pcm_params_match() when comparing params_channels()
against hw_config->tdm_slots the comparison should be a <= not a ==.

The number of TDM slots must be enough for the number of required channels.
But it can be greater. There are various reason why a I2S/TDM link has more
TDM slots than a particular audio stream needs.

The original comparison would fail on systems that had more TDM slots.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: 8a07944a77e9 ("ASoC: SOF: ipc4-pcm: Look for best matching hw_config for SSP")
---
 sound/soc/sof/ipc4-pcm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/ipc4-pcm.c b/sound/soc/sof/ipc4-pcm.c
index 374dc10d10fd..86f7377fb92f 100644
--- a/sound/soc/sof/ipc4-pcm.c
+++ b/sound/soc/sof/ipc4-pcm.c
@@ -639,14 +639,14 @@ static int ipc4_ssp_dai_config_pcm_params_match(struct snd_sof_dev *sdev,
 
 		if (params_rate(params) == le32_to_cpu(hw_config->fsync_rate) &&
 		    params_width(params) == le32_to_cpu(hw_config->tdm_slot_width) &&
-		    params_channels(params) == le32_to_cpu(hw_config->tdm_slots)) {
+		    params_channels(params) <= le32_to_cpu(hw_config->tdm_slots)) {
 			current_config = le32_to_cpu(hw_config->id);
 			partial_match = false;
 			/* best match found */
 			break;
 		} else if (current_config < 0 &&
 			   params_rate(params) == le32_to_cpu(hw_config->fsync_rate) &&
-			   params_channels(params) == le32_to_cpu(hw_config->tdm_slots)) {
+			   params_channels(params) <= le32_to_cpu(hw_config->tdm_slots)) {
 			current_config = le32_to_cpu(hw_config->id);
 			partial_match = true;
 			/* keep looking for better match */
-- 
2.39.5


