Return-Path: <linux-kernel+bounces-865116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD53BFC498
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2940B5E825F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86FBE34A3AA;
	Wed, 22 Oct 2025 13:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="ADNwEmfO";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="ipM6MiVH"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B2F347BD4;
	Wed, 22 Oct 2025 13:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761140400; cv=fail; b=tL6vrTqDFOfT8pttR+mZSDsjrKpUIypY8y2nmRxogHYo02Pd5Q851id7/PI0qQbNrtCGLUt46Z6FPOPJJBdJZiYjzqr63Neea0pJfl+ut7Wa4Gsvtjn/pQlfGS7g+6H0m4Rta3kK2sGblAhElQ/BJRMuH77b4D1Rz2rAXJsTH8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761140400; c=relaxed/simple;
	bh=t30BYAtdH46QAgD28rvZtFsG2wT4MdLu0uGqK9DdCag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sdfDI7I6p/RiJcAUbcGHjyRYp6htzF6QC69TYwMuuGSaZgThYHBBGHVsM67vo27KoL9xSS0BQgXQmaSqD/yC0Pv1SPTPxBz5/fOvyKTA15Ua0Kk+BW9J0OeTd3hU2hwXk/Ht3J+2q9EcIn8ImVWgt6svlkQK+2YidnHe0tUzOPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=ADNwEmfO; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=ipM6MiVH; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59M3iZuo3659667;
	Wed, 22 Oct 2025 08:39:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=O1HVVDlUxLFStcyvLl/ndK44DE0fiJgeLjZvMrrGncY=; b=
	ADNwEmfOQ25YyX+e4Bb0Y6P2SIkrL6YJ8ipJZ548+lt4x89zQP3NLlPv+38D/++h
	NDBXXXovUE/Mxpen7q5YQHcp3aP5mvNN6zNWRqS38G6ueYTTo4tZWfuw7UiAP10T
	NDFsIerzYXiVI5DXdNAPSdS/7HM6EevM1wGeg1oMfyrQPwlr+28aVZh8zky3GyWV
	/AVMj08vIMuriIm814cF3EyLWegY2ZmQ9dwzb74ZRjV5NI7ZZrBK6jv1Yo02ok7p
	3IeY+xbNcCKa9DlYCEbJWT73PxF6K6tJMba4e+A5pz529UiONk+ymlbLziy6uC8U
	Sf/KwNDDl2NT3P9f9XV7ww==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11022096.outbound.protection.outlook.com [52.101.48.96])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 49xqmqrjq3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 08:39:41 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bHDhPMIpB69wn75qDYnuiiy+qnxVLcBnRTLW4dJz9ev1kMTCvv5Kxy/Fs/LnE+1TgAZMAe3QVxsGuDNNO1TcdT3X3JSM5epm4vpSa3kh40WdTGPk6vRarK3ip6Rqg+agITKzD2GFyL1KzaB/gRaiIPRjlJByXsnHY3qPMCZDTY0OLMJxhHVR+oR8V9MD0avHmlcXCGCrScaDh0LoVFhXS5D/ZmWVpDomAqMm5B7BcGQgUTji0yUqxQKaFyhdDeM423OEZ+vfl5rVHateJd1o20K6kJaFnK0jG2Mu7pj8t02QwtTXKrTmOp8YpwcZcfq/z+OW3ccoqvIJUhLAVgOSLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O1HVVDlUxLFStcyvLl/ndK44DE0fiJgeLjZvMrrGncY=;
 b=MOCFnxy4DY1vDgo69Yfk1ZzJoNIUMyoqPRLXlnZusrZ5Kw0/oj6E86n+990Ag4FPHRLYfBiihYR7vKmlIgElvkH6C3/z1dqgGvHbwtV41IT+8YWPdpwvUfNJOMp8oOlObJSS/JyLmrsR1Z5HsC4pqOoJ0QVrknNOi4YfjXSFyh65abgMZeB1rCT2WVoyBv0NX+RXxOgoNJ+daS1ml9Pwt20dliWI5RNJotXa49WBFZ7sXe8f04NzcLnUDFMqoSGBMeyIf2adYSALgvPKuqsSL1PHJv+FqPiQ1/PqrEMfiahB4l9P1DuH6ZcTAJQeGv6GrLR5VC79bRAZjIrPD7lFZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O1HVVDlUxLFStcyvLl/ndK44DE0fiJgeLjZvMrrGncY=;
 b=ipM6MiVHCcXUND6+2Covf5JFrNeGWacz5WG7JFCZU/0PcPzXgY//uE3AjKeeTfzoS6F73cX+28A1KzoJvdYL1rr1Jgkh4Ksac8ziLjT0RP9T47YxnQp+81SeZEv8lP1F0sOimpmvDgRMB94m84+o4wYwzgG8z721inrNbN0MfWE=
Received: from BYAPR03CA0016.namprd03.prod.outlook.com (2603:10b6:a02:a8::29)
 by LV2PR19MB5813.namprd19.prod.outlook.com (2603:10b6:408:176::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 13:39:37 +0000
Received: from SJ1PEPF00001CDC.namprd05.prod.outlook.com
 (2603:10b6:a02:a8:cafe::ab) by BYAPR03CA0016.outlook.office365.com
 (2603:10b6:a02:a8::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Wed,
 22 Oct 2025 13:39:37 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SJ1PEPF00001CDC.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7
 via Frontend Transport; Wed, 22 Oct 2025 13:39:36 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 80DE5406547;
	Wed, 22 Oct 2025 13:39:34 +0000 (UTC)
Received: from lonswws03.ad.cirrus.com (lonswws03.ad.cirrus.com [198.90.188.34])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 1AD91820244;
	Wed, 22 Oct 2025 13:39:34 +0000 (UTC)
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
Subject: [PATCH v5 07/12] ASoC: cs530x: Rename bitfield to reflect common use for ADC and DAC
Date: Wed, 22 Oct 2025 14:38:48 +0100
Message-ID: <20251022133914.160905-8-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251022133914.160905-1-vitalyr@opensource.cirrus.com>
References: <20251022133914.160905-1-vitalyr@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDC:EE_|LV2PR19MB5813:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9cababee-b1a6-4e92-c5a5-08de11707143
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|61400799027|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KAxhpaVi1A280mNoeh1xIU+No/3SrRWQc2OFJb/RHpK+S/IBa7fibit8zYPg?=
 =?us-ascii?Q?VYtTMHgrk2DJZV9GO8sMtR3so95KqKZeYqL2qqVLiOXFBVVOd3iul6T2mTxL?=
 =?us-ascii?Q?G18APcBwRw5p7/0p4bNI3OSaJKGED1w0ej3Rjf9tqXvksGzTOQzI+el5w27h?=
 =?us-ascii?Q?sxGwlottoo6GUGsCs/l+DopOokmh+rbQrAaXzD6ZTuET1B+OdyqUxGX+1EJH?=
 =?us-ascii?Q?BgNEOJQCDalmtHoVqzMy2sKK4TO2DOoj4pOHKgyxibERIpz1t86cq68FoJrq?=
 =?us-ascii?Q?CxG3/mRbI5y99C2/fX6FgwhQBnxz43nefUaXURsmtoL9A64jriOiTJ32f83W?=
 =?us-ascii?Q?cRHlXTVdB3MvoDvWncizZ0Q3o7QKoWuKH36/IAjiTvACYAFnbh6nO/IT5fSb?=
 =?us-ascii?Q?Yexl2W+SH9fogVTbDK+OUTokeYJ+WduvkHnCTQC11Yca+bETZhwftP0KQ8r9?=
 =?us-ascii?Q?o3qrYTpzmZCqhVzLWO0VuG6lE7fwwqi2JEfGGKcstcusgYjLybehp8eGIfJm?=
 =?us-ascii?Q?iH/ZBVv2Gp4TQa2FDpFdd7xKsphsfqYsHaIWL6M5GzZ1H7eXLgPxWBEfHhZJ?=
 =?us-ascii?Q?MBlDa4IP7YLYq514iM+VvR1wGRIbz7QHvzzFsv1UTzkOegNa1YsBNjVCyrHQ?=
 =?us-ascii?Q?IrreqO+7G8aw+yId+jnlMg8kWQ9R/AmRkJi3QMdQFZQMVHjnhDsMiSPAcmRv?=
 =?us-ascii?Q?1j830ruWHAA4M9yQlpGRKqgQLH1BPZOxaYD1r13f0M8imIt8ZrfNR6qlVlH6?=
 =?us-ascii?Q?cDJnn53JBv70dGZoTSxsnSHozILPjAi+Rp7Hr9f98pPZsw6lcSUV13Rgloyj?=
 =?us-ascii?Q?weCBOe2qeG2vCPfDrPnAa4SR8/GV3J1f3ohGkTadYLeRSZ3lwIXW51aGAOpE?=
 =?us-ascii?Q?bvuPF+xwUkWsmNyR7Fkbe02gMUrb5gFMLlwrBL1DMMlfOgHXjs65W2rnMXfQ?=
 =?us-ascii?Q?l0BFEDRJo5YxE6dvCkm4SkJK0Cs4E3ZZwiTTvj1jwh4mOCpqLrBY8tqJFW/H?=
 =?us-ascii?Q?RH9QdVbpUB+S4OPqcDGQVnJ9ROStV1bVSXqQkh/W73GghwNiAG86SF0Sd1qK?=
 =?us-ascii?Q?LM8rKQrlaDU9m7NiCaXFXcU1mnTghX2TUuM8d0BcaX7O0eCY1gNtJLFXOF0b?=
 =?us-ascii?Q?+zbdxwgv4Z0yNc7IwADALJ0J7Apg4bPtEgg103A3kQ69Si+OuzUWc04JihJt?=
 =?us-ascii?Q?gKtE66L9bqezuInKGIcEBr6itWyx2DSpWQwIQ0cRQKUaXdrxj877wpl255zn?=
 =?us-ascii?Q?HkyCUrNQE3JC+XY9eaFfubtKYuwaq8axBxe95QYR0DZb8lC1OlRRF71YnYAW?=
 =?us-ascii?Q?oZefYEhzcR2uGh+dBvWhi8BfkhkDCFJLfbmwazB5klyWQJDEaK9UrtJdkMnh?=
 =?us-ascii?Q?iJJX5uY1mJwXdxol0eCaX3rhFdOh14tUfwdFU7yk6bGjIHlze3smnPlmozoA?=
 =?us-ascii?Q?poRCyEJEKe+Fxe+sBznUcrMFommF40etcZ0r93kGHExsNBWab2a+ImiqrUUL?=
 =?us-ascii?Q?9q9xMiieUDgu5xvuIUpUv4bz3wxAY3ERoC0JLpa7W/MvTSCljD5VAr2LDtvb?=
 =?us-ascii?Q?TbBKthGTLifpOhjFwDw=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(61400799027)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 13:39:36.4119
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cababee-b1a6-4e92-c5a5-08de11707143
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ1PEPF00001CDC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR19MB5813
X-Authority-Analysis: v=2.4 cv=G6gR0tk5 c=1 sm=1 tr=0 ts=68f8de9d cx=c_pps
 a=9i+TsZ0Ui2ufk0A0iTQi3Q==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=8pIFU9epQc3EzPgbZ4kA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: BBAKjYizbkqSFvO1Lh405aQavRkUHmQQ
X-Proofpoint-GUID: BBAKjYizbkqSFvO1Lh405aQavRkUHmQQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDExMiBTYWx0ZWRfXw0Juf8TF105g
 sf5rwGZEiGgm/Nft0EggeoAwOQHWxFzcYTbFTt1Kuum9Zadi1GmPV3cSazi0PohzRppYZXvyVlS
 73NuMnAnDB/Rx+R4QB8sYAJWZT0ubAcLrNX86Nl7ir9gC9Cfh89dZtjlhWbdmTOq1gqwMjThB3R
 8KJ2qCkDAuEnTtZy6Jdcjt0cfpTnjWOiXgvtcK6KkF38B4f8QJR2Pm/dvn3L/F09EoWEuUqc/A3
 bOASy54F4u1ROQnQiMkMbny3UUluGe4/IrxfUWVLSTgpQ23N1GL2ekqMFzv1CESBKB4k2QGksIY
 GdirQ+WIQ4xyfCVHZfe6HXfnED/IEePBgXcIULZbiZ9eLawJFktDiMCfyryKF9VhY5GSrj99Kua
 getz3BosBihAdN76tziFDq42vMZclQ==
X-Proofpoint-Spam-Reason: safe

Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/soc/codecs/cs530x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs530x.c b/sound/soc/codecs/cs530x.c
index 4b0bf1c3b985..193d7af5cfd5 100644
--- a/sound/soc/codecs/cs530x.c
+++ b/sound/soc/codecs/cs530x.c
@@ -141,8 +141,8 @@ static int cs530x_put_volsw_vu(struct snd_kcontrol *kcontrol,
 	if (ret)
 		goto volsw_err;
 
-	/* Write IN_VU bit for the volume change to take effect */
-	regmap_write(regmap, CS530X_IN_VOL_CTRL5, CS530X_IN_VU);
+	/* Write INOUT_VU bit for the volume change to take effect */
+	regmap_write(regmap, CS530X_IN_VOL_CTRL5, CS530X_INOUT_VU);
 
 volsw_err:
 	snd_soc_dapm_mutex_unlock(dapm);
-- 
2.43.0


