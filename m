Return-Path: <linux-kernel+bounces-856676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CF3BE4C5B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 19:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BF20035A043
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08179328B50;
	Thu, 16 Oct 2025 16:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Hb26FNG9";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="I+DwwZhj"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D5834F49B;
	Thu, 16 Oct 2025 16:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760633947; cv=fail; b=Ad3dGeEy1fkPBBDGT4LbLqjkq+tOOZ4m+YYg5L7gAyF9L1BL0+dPs46UwKLR/BgTDrqxEtrGVyVdd+Dv7VGXYmzwaJBQzSFHvJDjuzDUMYE/QwgB7sqHRfNXDBv3LAjX0j1oG2jolTsBW5ePYa2ukKKUUhPGdn6G5lOVz7zpUe8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760633947; c=relaxed/simple;
	bh=a0xbbPhJV6WCvc+c2G2xOHWwlKNuPSAr5JUlCNW5Vz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r6YtW9KB4zvlucoF5Gu2g+39cb3bLgqLkiGboWdkvVrvAVgoSiIz/nyIlQBW+wDzUNASpLenn2l2B3ePVOwtk76eRlXK4uYbt6iqty3NlkyPilg8fdi1xQZaFRB5JrjNEDDA2pm0Uv9TOxMaHEdxesQm+AN2CcNVjCrOdYi7nGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Hb26FNG9; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=I+DwwZhj; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59GGUOYk298627;
	Thu, 16 Oct 2025 11:58:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=CDoyyxXqya6DChI8Uu/FCa7bZGLzX4UWT0ihRm0yw2o=; b=
	Hb26FNG929OZ4G3P+Wiq9Cbk6Sa5CtbF/kH4S0XYFCTercDRUOw76rKly75u9lLL
	/+WK9Q1eL7TdNg3gdrMoEkNHXCXd5qKfLBk/hOyWzgq0UtnsfMOgWHSybzGd3XqZ
	QQNoco4dkLYXa9BwWXwKwJ+gom2alhfFKCl4+Lzc0/6lWRDQTLmfmVzFnyrEzSHd
	oj9qhH8SgeDdh4j4FzRdESSSxExCAQw8+iPN/PwK9VJZqMcgtznqdOzjQpLbwl9S
	ETdUd/vkBU+p3iXec4XiufUhBMnL5xCeQACZ8QrwEqCznJu4mZJ9hCwF4KpKND4q
	KZg9iUZnWzW0uXyAv+oIfQ==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11022131.outbound.protection.outlook.com [40.93.195.131])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 49t9mhj9h3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 11:58:54 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cQqSnaRJnD77EV1xKRXreDxAiBKX57aO2jxNYfqGptpttYeE0LoJY2urnmGUY1gL6ietsUBXNhhWcbHaueZNS1jaz/JC67pUJLFd5uEYqFRWxgPcWp3K+FTdK2X7AxEjg317IUC7/o4LSg48+9d9V1Ttw4SvFQEXmAug5ZSDT+loq310BlJDM2IW0ftYDPOjprKGAmk/fy0CqcKGgi6rfKatR58NUP3Lbuf6rLmxaI8sPg7CcwVEqt0yfs9Nf5Mcqj2Q61W8TBTSYOAm+PvDL22Una1w5FVS+G1TD6YbHN5q04E/mjFi4FNRBUxRwOz5EJAuU5TZr1xstmkg4EuE9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CDoyyxXqya6DChI8Uu/FCa7bZGLzX4UWT0ihRm0yw2o=;
 b=Jotk2b6lPwMvzHz/HLriPaOLDZZhdo3cAM13N9H6qZVlLH9bhRcyA1nqjhjgGdulHjq+sFB1WkPqPZYejqQ9aIKx34HdV1zLTnrcDobMe6L2GKhxBzDL8elJEvYPuewPr8SbqGwoBcbr8fq+ENCu6akxRSDGtxp191eecEcJ2T3S7h2Vlyg9W02K6XgBZzfywoc5ZxV6LlFz3kEkXM10TtBk9DUPXYwS2GFFuTIwnNsyVwrcSsU+MqhuQLnOl6uus1FSEu1fhDMd8LbxmkUwrfcB4eC5KxjA3iSGYoiU+oeVrD7HbhSUlwZ2/NDY+vuw5x/Ad7056Zfo5Idpgaeo4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CDoyyxXqya6DChI8Uu/FCa7bZGLzX4UWT0ihRm0yw2o=;
 b=I+DwwZhjLKD581lF+Caej9aP6+UKr4DdPZ9L2lZn9dsaFOBH3Wj1c/uoeKsLbuRLruMfvWzeSCv7XriyTYkOER0K39Rxo/cW70eZGRd4Yf3COP1qfPRLm4m28zww2Nxs2Mf8rHTWg8p6IS/ar2bmtjfbJq6sYTg2vskHVRTtfsQ=
Received: from PH8PR22CA0011.namprd22.prod.outlook.com (2603:10b6:510:2d1::22)
 by SJ0PR19MB6897.namprd19.prod.outlook.com (2603:10b6:a03:4ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 16:58:51 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:510:2d1:cafe::ee) by PH8PR22CA0011.outlook.office365.com
 (2603:10b6:510:2d1::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.12 via Frontend Transport; Thu,
 16 Oct 2025 16:58:50 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Thu, 16 Oct 2025 16:58:50 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 627BB40655D;
	Thu, 16 Oct 2025 16:58:47 +0000 (UTC)
Received: from lonswws03.ad.cirrus.com (lonswws03.ad.cirrus.com [198.90.188.34])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 07929820244;
	Thu, 16 Oct 2025 16:58:47 +0000 (UTC)
From: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To: Mark Brown <broonie@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        devicetree@vger.kernel.org,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Subject: [PATCH v3 07/11] ASoC: cs530x: Check the DEVID matches the devtype
Date: Thu, 16 Oct 2025 17:58:18 +0100
Message-ID: <20251016165835.143832-8-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251016165835.143832-1-vitalyr@opensource.cirrus.com>
References: <20251016165835.143832-1-vitalyr@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|SJ0PR19MB6897:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 87c08ed4-a304-40ab-8675-08de0cd547d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|82310400026|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L1vj//6BfDLeLXPCmh5WJ5I4BGI8vBRCGTMNa0Pto0zgnH0CrI2fj4PtA0e0?=
 =?us-ascii?Q?/jzk7P1qkCgNHC11mI3Hjp+i7woXcIvBpNkbtDvQsA2EhbYyE52kBhHVBXzF?=
 =?us-ascii?Q?3C156dhp8iK4JT9KJRntsp8O80Wqwg0ye1xOXi2vIAUputc4ypbHw+EdgDQu?=
 =?us-ascii?Q?lz3Kic3GXJmBPpdQh3dJm+p3gjd0VxJk3XuKiUjX2JmQeCIGRZ6dDxiutd9N?=
 =?us-ascii?Q?U2MXfPxPN/mqdlvJJ6z9E8+eOWXzPvydViOz7+ykd/tqMy4KtiolgBho9/Xi?=
 =?us-ascii?Q?wQULzNNcvV169YEYnJYP0WGNHP5+7MG+ivop8hJAIZejInMqL6iDFKTxNlhE?=
 =?us-ascii?Q?M9R5xCVEU0kGgqxv4/1dKD2B9lSWYEtjgHgRR4DEryFjyWRMMKV/gHtjJdAH?=
 =?us-ascii?Q?XHv3odApkXqoT6u5nxVY7wnhdRLDKBH9Og0o7iA0CE0vs2wNMiutcTzdWNHt?=
 =?us-ascii?Q?Zlz9wTH9zvOabB9bOYrgm7fzp83MZ0hJswEz1V5pSC9bDZ6MHGGjQuDIudkY?=
 =?us-ascii?Q?Z+3h8Iw+jX+n7eHQXDnWTOBkhEqbCcZTESODrh89Etve5QgyKTjnQYCdrGwg?=
 =?us-ascii?Q?UoQJch+x6GG1PoEpvPfaKUmjdpU/r5G7v5WgFQNa/JAEKkwbMymICUDGf+sE?=
 =?us-ascii?Q?0mOUx5L2WpiXjSrnqH5CKPoxXgMTTQMF17t62FXmRQxPHCg1X2y2AlYypcZy?=
 =?us-ascii?Q?2LrW3T/YWVJIaYLk83+3UUbcDurl7ZxDxjko+ClhFSJXCKwYk570MuZ7EjdY?=
 =?us-ascii?Q?WVx1rNTB824hrJvIzXb+OeqalRd5aTNKMN7qsD8tPIJD9+yo+yAP7qBcZcoA?=
 =?us-ascii?Q?xp3KTdqBjCy5ZSPPvBIOR1FKYgm2kXD5GF7GEzwrt9FsTrt61Rp9M1YVugou?=
 =?us-ascii?Q?Vt28/3qbUNzKEH81Q+TsThrC4N+G5gr7afjzuPCP8hqqI9RlHmdV5rocHW+d?=
 =?us-ascii?Q?WYeJFCnF8tn8ZiOxaLlmXGJS8ki3zBO0J1AG0SPwQt4U/cLPvGsH/38qx0xW?=
 =?us-ascii?Q?J5mbaAiCducgCBspz+NNgNidJwxjZAEfAEt1pAns5vq/mJg2qrCGOQ/q94jo?=
 =?us-ascii?Q?gOc9kNLV05S25izvwll+T1dF4FN5PHNV/2Sh8I/llOSusS5j42kkiQawidDm?=
 =?us-ascii?Q?aUU2pdKHFA+zJhD5x3eK08qnFqbf/SCjWNcoOxbBJnGhwE2UWCSABxr60K5m?=
 =?us-ascii?Q?ECNVG1SEinA+SRrcmZnlhwThO3hUGs0p4ExNplLrg22NTP+KVWRQaPrX6NJW?=
 =?us-ascii?Q?tk9zkDp8PkKRxODrQd4kMA7685kkTP2hrFheQwcILYm/ssoswsUELZOoC5D5?=
 =?us-ascii?Q?V3aLqJMexoJ1RkDo4z8xXfz1M2JRBiihaO8pwT1GUnldFA18ZVj2w8eCaxyz?=
 =?us-ascii?Q?RJlSWySKLUyYce1pqm8oeciieW8mERP1t9z3gwREBo9CNiRSvRn0aro/ta9Z?=
 =?us-ascii?Q?PgYcxWtjqTUYAtPIbHFxf4vgcURbmmXgef4vM+Hrxc8ZXxfmLfJM0+G0LowP?=
 =?us-ascii?Q?3tQ0cF5w/WRuGoqFMGGikeWGVVqvQQY4WIbKrPRrWIqN0bwiSLCAbxEz9X1I?=
 =?us-ascii?Q?L+T8L1/jTiuH6kAPLP8=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(82310400026)(376014)(7416014)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 16:58:50.2948
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87c08ed4-a304-40ab-8675-08de0cd547d1
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR19MB6897
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDEyMyBTYWx0ZWRfXxLXriP6Vkh5u
 VRuO9QMgDWTgJS6q13X0EbDWGp4x8OG8QdOweI0sQstdll43WpbIPyZq+mIpUDD8c7nkulol771
 3MpHUrnBvv1ZD90Zpce6XWpkcihuNukY4mTStyawc1Krq7MykOGmFTS5OwRexZimaozfHQmYFWA
 4XUZXv4ctsOxFn9K14NT5ncKylfvqipHwWWRAQJYCce/of/NCjVBk339g5ZQtihIIuN2XhVX+6K
 pXyFfMj+OoENr8Lhm238jU9lzpR71fI0APo78hYL44H4H3QZQ8Gn2jKmKYRB60SVm3WfcHFeFMq
 Vgzp8Ycnjh8epklFDUMYLquBv/17oIXj4wbBfg8j0A+e4PtEMsq+CM5AfuzWU8BmhkMUoR50TqB
 JPG2d3V3jtgslQCRj3iID8B2DAFjpA==
X-Proofpoint-ORIG-GUID: LTSGLWgC-fpmYiQ5LuXtuzkjlIU5EQaP
X-Authority-Analysis: v=2.4 cv=OJIqHCaB c=1 sm=1 tr=0 ts=68f1244e cx=c_pps
 a=WkVbEPlz7sSPDy0d+2zJ8Q==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=Ueq04TJKjEWbJfMvJoAA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: LTSGLWgC-fpmYiQ5LuXtuzkjlIU5EQaP
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
index 25dbf401b15d..cdd050c0fa2b 100644
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
index c10a6766cc7a..758d9b1eb39d 100644
--- a/sound/soc/codecs/cs530x.h
+++ b/sound/soc/codecs/cs530x.h
@@ -185,13 +185,13 @@
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


