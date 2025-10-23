Return-Path: <linux-kernel+bounces-866557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DC35DC0015C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C03F44F5520
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E4A2FD68F;
	Thu, 23 Oct 2025 09:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="O5u56vMl";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="Ot129ThW"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22342FB988;
	Thu, 23 Oct 2025 09:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761210243; cv=fail; b=UuZL4gRPDKUreClpkpyE/GExArwZEEFx+/0wi8Z9HPFXKcrS7XMtCn6ioDH1nzxryGo3imgIjpwqNSyVz9C/M1W3UrQaEqfU68p71rxNLihsxIdE/gWGvhbOcEKZXbUSKT1S/221ADI/2l0mcukHJDDVCOpD3z4CyVwczc/R3Qw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761210243; c=relaxed/simple;
	bh=FtSScyf5EgRqOIRZI2mS9zLUdoOtK7gx5EQh8QgWEq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rVVy2OlBZ99JB56AEC+BDBey/PT7Pp7gvnSWsIa/cygqifm/McqRmaIpiIRlEK9WMJhhtVNikAl8L2kuoAzBKw6rsD0coo2iKQkoqjDwcDUWQcUSRJqtP15XioudhTA4p47VQd4CX5Xwgzq54fd6hHcjY7pIfFk24PeKH6uJ0yw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=O5u56vMl; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=Ot129ThW; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59MJpHgh3660649;
	Thu, 23 Oct 2025 04:03:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=9v899Q3ovyP7EllcrgOk31MF/ab8qDRP7T5pmF6KYj4=; b=
	O5u56vMl8e538nLtD3ThKQn7gtHiG+N3CVcTqdtmNOwirST2+i2eiXvVJjx+BTCU
	9cZh4NE0Uodh/wEFUlqtnZQUK2FBEJ+RxKT25ofcLcDW5YbxLCHSRbScWwXEiDyK
	yuazoDtIGcjSNqPXmI/W8QKo6P9NviukHRr7qduPlPZCk2yz0t+g16hnzmGb9/j6
	jUdSONFVJ7fbhMwdWD0+ko+MwaJzHi2wjT3a/qCkIsWDqXr3a1RvJ5AwUmPNjrq9
	jeETXhPDbDzxS5VI9vXI5XSOAFs27TgaAzdwCJGOjPnZeHptg4bxf3p7mzxbXuvt
	wHxHMUPuJEdnWDRO+FDwNw==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11023132.outbound.protection.outlook.com [40.107.201.132])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 49xqmqsx44-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 23 Oct 2025 04:03:44 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=liPuvshL9NQriYqXkVsIFId893gbSgt4P4drxKSEIhhLykCsgMX/7hRrAWmcLcwz46TMb57HtRebO0ihKSb7pXs/iq1N4aUbRxCRPuc+31tBYK7pFtpbAX2mzmiMSYrPouFgo9acwEsia92Rm4akEywW1Bw4EBmrBTUEleaniYrMHb+ECXO+pc8RuNqWYG1NfEb6MjqVGeWjBbHKE6tmWeyFSpkc6Js90Ei8Zsh/KMpBsw/WRxkihYr+tEMZhod4nDR/dpjrSyRn4cp1LNCJWft+Sti7a0zFkoTgxOiWkAhc0MsqIYI3JGnzlh/sooC3MKDSYbS1dC7HiLpAtiV9BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9v899Q3ovyP7EllcrgOk31MF/ab8qDRP7T5pmF6KYj4=;
 b=VbQC/xoxrHtDwNyJOV9PvYS09YyWZi6xwuZ4MHjtSiT/SsmZFjFQL5enRZjgvcE2oRLFg3Wf77ob3p/FM34oIXxyWIXq0NADUEmbsnJ+Aj2Is3gta4n8zeVn3cg3bGE9tVVagpOYzn+FKbqqATe7OEBuFOqAp180tAuy1Z+9iWQAJDh2PcB3h/KAqXL2RXJmizKqQfHDlJnFAVUFe4T5MV2MplBPP6DorGQ5FvhmSfao6yhiSgSlupcAi1yNz5rbLA4VVF86/D8D2RP6ItgyNW3nJ9ePe6p6kpwBNrV+3HyHYCE/C18GUWUs0eO153f5uFswg/YftKQFoeMYW9wx0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9v899Q3ovyP7EllcrgOk31MF/ab8qDRP7T5pmF6KYj4=;
 b=Ot129ThWjvOZYI1utwSFDiIWzJ89vhHNn2YQZZtbJNw9CDLyjSzbmbrNlN+8I4CzpeaDjZ+BEe82ow4HUMvD0y35hzxdMTDv0WIUbg9Zty7FJqDkHjBOSiNdQG616j99JAGsQB0RNFMDG4/ybplPzPj4mKfSr/Ni4gf+TD84J10=
Received: from PH8PR02CA0050.namprd02.prod.outlook.com (2603:10b6:510:2da::19)
 by CO1PR19MB4840.namprd19.prod.outlook.com (2603:10b6:303:f6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 09:03:42 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:510:2da:cafe::30) by PH8PR02CA0050.outlook.office365.com
 (2603:10b6:510:2da::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Thu,
 23 Oct 2025 09:03:41 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7
 via Frontend Transport; Thu, 23 Oct 2025 09:03:41 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 0DCCE406547;
	Thu, 23 Oct 2025 09:03:40 +0000 (UTC)
Received: from lonswws03.ad.cirrus.com (lonswws03.ad.cirrus.com [198.90.188.34])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id A4ED6820244;
	Thu, 23 Oct 2025 09:03:39 +0000 (UTC)
From: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To: Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        devicetree@vger.kernel.org,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Subject: [PATCH v6 08/12] ASoC: cs530x: Check the DEVID matches the devtype
Date: Thu, 23 Oct 2025 10:03:16 +0100
Message-ID: <20251023090327.58275-9-vitalyr@opensource.cirrus.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|CO1PR19MB4840:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 358f6a5c-49e5-4460-4c2b-08de12131003
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nfSQ6eOF77Q9+7Yuk4JW3PHYf9iEdc0xA6TutJfBtJnz7iXnp0q9LQ/T5D65?=
 =?us-ascii?Q?lQTrk8HemaE801+iDzQiMcHYOHuIIO159NqQn0IHDbKn/BdsrCsf3qoI5fh3?=
 =?us-ascii?Q?x9xfjzQsUSUj4zPDXI3Ug9OfLIK9UeavhdzShMcDenuKpSptzzHLw/+2EYnC?=
 =?us-ascii?Q?AzhiJ5D6R5fMYxlqcZ7k4Sf69SXTrO2Dha+mDrA4rS0VpzJTAH07bDG8uODL?=
 =?us-ascii?Q?Kf1+ZiVzMtbwIEpTKTff+ruP63H5NjbE99BkDmB7K+yS0QUyEmqoCrgl9ZH0?=
 =?us-ascii?Q?O4OAxLqs5uYXtoiKj5/jhmUMjMQ9cD61+moAiRxBkUI6FPdr5+f3S98GFuNe?=
 =?us-ascii?Q?elwVPpT39SDne0xOg+aEr5lCNvhbScmYIwVmxCku1+Occ4hxpxcFCreKr733?=
 =?us-ascii?Q?PLPWWIQf9hYD7iJyHm/xoRyYbMM+t7ImE6Vvb7+pG7DzXKvJhhSPQ38PqqOC?=
 =?us-ascii?Q?IWaYO0zJ8Sd4yQvkhBratydMyCfbpg0+Lm0FJeQNOEUgsntGC3S1j1v3TeDf?=
 =?us-ascii?Q?OFJSifsCPktZQmcZP/MQJqJ4ZnthKO/dR5ridm1cBpyoBKeWWy+Br93/MZoV?=
 =?us-ascii?Q?FrDJBOscbsc+PKV/JCLG40IMnEq0Ik9KEPm/QnStcZCDmssPP2MHYYErB8bi?=
 =?us-ascii?Q?NuBJYacFa3oI1SO1BRhdvNsNHM8z1m/us6H4pXxstzpSW/O0wHf2mK/GnsJ7?=
 =?us-ascii?Q?eWtWI/kJds6WzEGiilbuv56qsvmBinhHU5/zctyL4OehpnCrtmP1Su3otIe1?=
 =?us-ascii?Q?STlT1ot+BH9v4Y+9lzVF5bVw5nnmk9rpidcvXMsr9dRiygskkHh0LPgyMEk2?=
 =?us-ascii?Q?jSw4OMsv3rbua8ocaOdE41r9quxreNs4lxNdcCdMQLkuZNUsJfGnpHp5Q9m/?=
 =?us-ascii?Q?7j9ZMpsUVR0vz26y+eb9Up67KNsrZtyERTyAZNN5jnlFm9ioL/QC5URC2AQP?=
 =?us-ascii?Q?QoAxii6W0fJNDJuTveDrSl/0qGznI0bSQ+Oyp8UwovdqOmua8hVFE9FdCCr2?=
 =?us-ascii?Q?VysQfYjN2cMSf2x6XqxUVo+Tt5akdLu45oUx7sJFnB3X1UvSibnrRyIyOgmz?=
 =?us-ascii?Q?f1fragecZ9KJ8i95htqQEUvkb3S9/9/Fd7EbFSRSveOyHo9jBOuSHYuM/G2a?=
 =?us-ascii?Q?3YF71s1eprw5+f7svlHyJzcRYyVCf/FlcfdE6NHuDz4se8PQulqJU7WJSeMN?=
 =?us-ascii?Q?qKJwVvwrELW1NflQbWVHIjJ2F3zvIzraOFX2QMNPFbDmfg++6wJfIMWPkJqb?=
 =?us-ascii?Q?EhkIpe3NDoPmeToQfCgfGDDfOFBU/ma8BqpEk+WSLiB5Z7ldDmbIAnZHRWL6?=
 =?us-ascii?Q?/84MA/CJmykFTzy5qiznAgupMfzax32gUtyc0650nju3PDHJLeaGhi/ZS6sT?=
 =?us-ascii?Q?FcD7x/iTvVO/IrX9IQI5amrk/V7Zr3JVEVv3EKpmaRNCddCECR9Y4/iGmv9v?=
 =?us-ascii?Q?/SG4KH7IrHm3xtifgTXxVJ0H2450lh19qmtD99sTCnH10eRBQtIxJRlVQNpn?=
 =?us-ascii?Q?1R7seOBw7kJlm735wmgu4Ioz8mO7PHBiorxsI+Tz20EpX2jgvBtwNIzTRRHA?=
 =?us-ascii?Q?p5xR5fx+HrVJ2eCRYXw=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 09:03:41.2549
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 358f6a5c-49e5-4460-4c2b-08de12131003
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR19MB4840
X-Authority-Analysis: v=2.4 cv=G6gR0tk5 c=1 sm=1 tr=0 ts=68f9ef70 cx=c_pps
 a=QUIaisbnC9uoo+9AoKvuvw==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=Ueq04TJKjEWbJfMvJoAA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: ZBzs99_A8Kd_fr5z8D2cbM2yU0HHbxnQ
X-Proofpoint-GUID: ZBzs99_A8Kd_fr5z8D2cbM2yU0HHbxnQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIzMDA4MCBTYWx0ZWRfX4/uX3G/uuKbO
 2cFT2fuSDLbmRhiFbD6SCU1NzXyz99SNHhKRyLSw4ohQC8w3h13cUOyJ58di2MLHxfR/lte+L2R
 Zdz1eBk7d+Ji1FIM6W0kNte+9SRWrah9+wk5q4iGDgrLPNYXsm4pjbEDAbVzwHfgNMmLSd1Sumf
 o9LiCWI6NBycs0KZsP3QKtgUR+lRLUQhG693vuXhpCPvA3rxbr0aeLLPZlnljSHUh418KGUaXto
 TvK61nqE5XrugecGIJEGd5sOO6ogeIEeBUDAkvGH/I7j2qBxk10vXILO5M0ixJji2oL8qCOmpCg
 oHUCLTHWer/8Kjv7W1NN5PiCLmcFoqLMwPw2FucpBgGvgGFZsH50YVJgjKDoyJ1ibGmqdaKz7Qi
 LcxwtOi2z+TapqpaxhEvsClsrwJ+ow==
X-Proofpoint-Spam-Reason: safe

From: Simon Trimmer <simont@opensource.cirrus.com>

If the read device ID is not the expected devtype derived from the
compatible device match then fail the probe as other configuration
details may be incorrect.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/soc/codecs/cs530x.c |  6 ++++++
 sound/soc/codecs/cs530x.h | 14 +++++++-------
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/cs530x.c b/sound/soc/codecs/cs530x.c
index 193d7af5cfd5..7dd9e5d19336 100644
--- a/sound/soc/codecs/cs530x.c
+++ b/sound/soc/codecs/cs530x.c
@@ -1181,6 +1181,12 @@ static int cs530x_check_device_id(struct cs530x_priv *cs530x)
 				     dev_id);
 	}
 
+	if (cs530x->devtype != dev_id) {
+		dev_err(dev, "Read device ID 0x%x is not the expected devtype 0x%x\n",
+			dev_id, cs530x->devtype);
+		return -EINVAL;
+	}
+
 	dev_dbg(dev, "Device ID 0x%x Rev ID 0x%x (%d in %d out)\n", dev_id, rev,
 		cs530x->num_adcs, cs530x->num_dacs);
 
diff --git a/sound/soc/codecs/cs530x.h b/sound/soc/codecs/cs530x.h
index 52fb148df36a..d11711715ba8 100644
--- a/sound/soc/codecs/cs530x.h
+++ b/sound/soc/codecs/cs530x.h
@@ -211,13 +211,13 @@
 #define CS530X_NUM_SUPPLIES		2
 
 enum cs530x_type {
-	CS4282,
-	CS4302,
-	CS4304,
-	CS4308,
-	CS5302,
-	CS5304,
-	CS5308,
+	CS4282 = CS530X_2CH_CODEC_DEV_ID,
+	CS4302 = CS530X_2CH_DAC_DEV_ID,
+	CS4304 = CS530X_4CH_DAC_DEV_ID,
+	CS4308 = CS530X_8CH_DAC_DEV_ID,
+	CS5302 = CS530X_2CH_ADC_DEV_ID,
+	CS5304 = CS530X_4CH_ADC_DEV_ID,
+	CS5308 = CS530X_8CH_ADC_DEV_ID,
 };
 
 /* codec private data */
-- 
2.43.0


