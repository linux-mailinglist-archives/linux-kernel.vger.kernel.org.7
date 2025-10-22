Return-Path: <linux-kernel+bounces-865125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5C0BFC4A4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 81295508723
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA15F34C141;
	Wed, 22 Oct 2025 13:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="R/o4uybO";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="q4LxzEVX"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC0334B699;
	Wed, 22 Oct 2025 13:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761140410; cv=fail; b=UyXwHeeSeJx0oMNVMktAgGBrX30Z/FCdEsdv4kGTidwXCxXW4n3F1k7QoMuXoGgnOZwayLt2RvPD0skDUnpuX2koV8Kdgnji6+B6Kcxhq6hZCAdWos3hkJXXPeT1YU9nUXxon50X9RRNw76SmP1vHOY2WiRCx3Nqg2Cu9f2PvnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761140410; c=relaxed/simple;
	bh=CdxNX3SzRyaVavRN2C1DHwIaKn6uWghjWdEEW9C86mE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ut3R+qQ2b0UY0R7NXCo4QBq42qfx7W1VKy/SCMyDaFYtbL2dDRaOw4MMS1GQhHp5L4HPRxzMM3RXK7ICuNSrnw+yaByptxD++In0i/knIp3c/7/8w3tF36yIvqeqh6wvgGnLjLWKztuPfJP1z4jKnsbAnv0tDHfYoJUMMD3yASw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=R/o4uybO; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=q4LxzEVX; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59M5Nxp01194606;
	Wed, 22 Oct 2025 08:39:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=+Jg8/DVjuEFoGS+z8QQwazvWpMxbjYdpHzzXwJFNH5g=; b=
	R/o4uybOofD+mPDHmMo4TU1HEhHiBFJENFfODRHiI+bQhy36Lg1vErc9QzpjeUTp
	StQ6wp3wgIM306Jxvvey5sBPHPGlnwd3dFL3n7WiYoB2dz+b4kuVLWQpFcwFA0BM
	AtNAwESfZCMx4H5MPF87gB65UqQAGw9egMDYVjpNDWmO3kNMhMxWPzAZtj28XKha
	DL4WcbMJGOAYXx732fuftY2YQSbUcNjK4UTTrN35LX5NjBQ8BSCFOTcD5WaRVETg
	ILyMbWbkKAI8523LwU/K21HpC0TOogvRGIe3nYegOeN89OtNZrnpy639KpFS/8If
	iJmClOxcqjcApSpaMfFZpw==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11021097.outbound.protection.outlook.com [40.93.194.97])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 49xs380gdd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 08:39:39 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GX0z0deq0Z4pp3h9BZhRN8larR275LCQBaU3567QhIX8OtANn8Rp9jG3YW7Ylf+FDj2N+H/mNlXPoC1R8LSGoRtPz1IgGB0IKHetPBoRNvBQjjJXrp9d2w2TkpOAjG5uby+voa7EdGWvg4r8WNUD/lnlLo2dBjbWj6Qr8MsOfVJV/QjO0dBfcg7Sr+1/jr+OemDZ7YozPdIu3FlE3lJFTTkv0rygAEdj4rV2iiBCW1Jp0wJ86orqzld7miUXMUoAfVR/0BivcD3qhKuK/4PH3X4v2PiD2433exCCaeA4wYQBW9M3NR5zsXbGU8+OaCYjcQBto5aT/OBpCry21AAHAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Jg8/DVjuEFoGS+z8QQwazvWpMxbjYdpHzzXwJFNH5g=;
 b=WzQTcTzuevhJYFqE655BytiRpqytRINmDjt6uTf1iaHGzBTxO8nCd67FcTYAzdKsszBCKPyH2eRGgNNHZa6yqskwqbe71uCQC5yZvJU0efumBBm8UoVOXsHJ3U2Wf2BcA7FxI3iJT5p+vODRCqD3qCTV/HTAGbRcfJtnPMPImoVAcl1kbReO3rwx/AeTxeCOC+v5Jn9lf7o57lSHTkiZrVzbiswFkWDbfOCPCXUomPhW3lL0qREoRT5lddY0VANWhg1L1WtFDq4pbVRQlqpjJYsJULJhih1mGDs8OYPXvKAhtz6s7AUEcuHGYuY1DyhHMNMWmZKS1C/xCMpHBbiQbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Jg8/DVjuEFoGS+z8QQwazvWpMxbjYdpHzzXwJFNH5g=;
 b=q4LxzEVX7mjPRXagYc7KPl534FmIav6SfV+CA3rZociIPFBRUAFoWkCgpOMx3oNCvqE2wgOcKiX9zlbK6u5pixhkEX/RbmJF9syYKWvzgDTdIoRLC8Rk02nr3hQ/xo6LphdhLetdBxWxWMAEK7Aazg8dEg5pdXhPjkKMUhFVVcU=
Received: from BL0PR05CA0024.namprd05.prod.outlook.com (2603:10b6:208:91::34)
 by SJ2PR19MB8498.namprd19.prod.outlook.com (2603:10b6:a03:56a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 13:39:37 +0000
Received: from BN2PEPF00004FBF.namprd04.prod.outlook.com
 (2603:10b6:208:91:cafe::fc) by BL0PR05CA0024.outlook.office365.com
 (2603:10b6:208:91::34) with Microsoft SMTP Server (version=TLS1_3,
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
 BN2PEPF00004FBF.mail.protection.outlook.com (10.167.243.185) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7
 via Frontend Transport; Wed, 22 Oct 2025 13:39:35 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id A6F4E406556;
	Wed, 22 Oct 2025 13:39:33 +0000 (UTC)
Received: from lonswws03.ad.cirrus.com (lonswws03.ad.cirrus.com [198.90.188.34])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 483D7822540;
	Wed, 22 Oct 2025 13:39:33 +0000 (UTC)
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
Subject: [PATCH v5 05/12] ASoC: dt-bindings: sound: cirrus: cs530x: Add cs530x
Date: Wed, 22 Oct 2025 14:38:46 +0100
Message-ID: <20251022133914.160905-6-vitalyr@opensource.cirrus.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBF:EE_|SJ2PR19MB8498:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a858b7fc-32b5-437c-9c07-08de11707074
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|61400799027|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LYNjf31Nw7dmL05IG2PY5aTXHtq+FnzvHUrMDMAsPeafV82tKuUgkssoEEJP?=
 =?us-ascii?Q?fGciCpNFCtR54buoCFJMXONaH3u8qPEj0m0mxh/OhDKuL3x9PmpcwpxKy6P9?=
 =?us-ascii?Q?Gkt14yKVzjH4vnELuyMrvMc/B7Xz3d2MXT8fJ4X/cYrrrOo3/crik6myKWu0?=
 =?us-ascii?Q?tWiE97LwdJldwxg5LjRGKKoKUElcRWZBUh5BJK5QS3MAsJanu/Tl7zbsZfAa?=
 =?us-ascii?Q?PnStUnRefVw8wLqCA0yYFTlnsQDiQJMODcNG1i4yxyCRNrn6b0ZpVNZPnAZB?=
 =?us-ascii?Q?HeA4v0o1wCT2EnDBmG8wYXdos0N8oM0LdBw+165yVFTYyR8f+Tabl2IcMFCH?=
 =?us-ascii?Q?Ot8exEJop257FoNDPU4frf6In+dCe7QbRyGWY2jW28v9kwdXXLSdKdwheZ51?=
 =?us-ascii?Q?Ueh/wWQ80zbGpCHjJTvLmpdOchpwqU3eV0DsujkMxS9LjrjFP7cGGa0fqU2r?=
 =?us-ascii?Q?KTDHTvT2Oigg2tUEZHJv7sOUSn0CxMc+C7M8y/R47lBNEiKQGiTqr3tz/nja?=
 =?us-ascii?Q?ibViRJSCmbImy+IEU4Yg9M5OzlSF2nhCHxZgNkQOknxwua4gh1toRHXq4Ns+?=
 =?us-ascii?Q?JLsBlWi57ALS2PE5UM03LN5NE8RbamCOHEmnAMX4NLM8QltxqrKXvsDslqO5?=
 =?us-ascii?Q?XoEUq+75Bl7Byp/gXycCiVaE9nu3FVlCsVygKqDLeMaME/XxVJKYvfDVJ9jr?=
 =?us-ascii?Q?Nl/gly22OkEDc2tq1BvsMUyaZLCCCiiwwyrpoZe0rGgHO0h/HluYEInTxMBH?=
 =?us-ascii?Q?Z5KOz3RKQiUx7TKpoR6gvAA2wvn0a7CT5dU9gH+gI+A1lr7Y/FJRvligV5PC?=
 =?us-ascii?Q?G3z2WmkLfYr+E6GpBn12cZuiIcYpgCokMjT8QMgJlCk89NsO5+/KiJZQcNBU?=
 =?us-ascii?Q?cJP+mvaPjzp1YwnmOQw01LWnGmfAFPRoKPIuQuPcdJMFZCF+nKXnzn5/2Kud?=
 =?us-ascii?Q?KA9HKHZ4C6jPoFY+TWG+/aWHg95u/8tVDwJDDFVrSWUkg5HbAd/tFfDKqdsO?=
 =?us-ascii?Q?T35eZxtS3kw80vi6KANQwU/UigzvbzXFDYgXbA/7hwp8ct+mZ18WTaj5D9AF?=
 =?us-ascii?Q?aPS5qVI4nh32McBsprlFivC3XHoz+KlbM+dM1erXUj4/rg8FNvfo+QaAYYpN?=
 =?us-ascii?Q?0Ygrhe7G1+f0Adi8KZIL5GUnuPdUyX01fcMPOucknAquUBGOQ9um63qTUAA9?=
 =?us-ascii?Q?WlUFoxM2V4kF4Vay5UP/6qodi/5eoS8Lf+Wcraa4PTtiRJCSjVSMp62p2uT/?=
 =?us-ascii?Q?B/O6fIkFEBl+7/oU2oHttrgrWwe7gCbE3I1E2GXXrXPx26GbvN2ZQkPvNEof?=
 =?us-ascii?Q?Gd5IHf3Ir60XMfuFO8CMntR7BwGGvjBObzPZ4OUi/tJxggFFekBeNBu/R9yw?=
 =?us-ascii?Q?uIADAWSCLaatgXrTpK6jpsf0k12jE5cx+6YrPXYh3ePhfig+Aq/0XdVhG9OF?=
 =?us-ascii?Q?cDxVAbQM+3nLkFK7BZd0RUVk/m3FNS7DroQdsfeYYpVU5g+tmqjDqaoi+dnX?=
 =?us-ascii?Q?GTfY7dgGHjrmD9/P/aUaUr7WqliMMRPZcL01+97QpnX8RHPVsd0FrkC7qVs1?=
 =?us-ascii?Q?06l4+CNU0j0N0GXtDbk=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(61400799027)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 13:39:35.1699
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a858b7fc-32b5-437c-9c07-08de11707074
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN2PEPF00004FBF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR19MB8498
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDExMiBTYWx0ZWRfX9FZe5raYNPDF
 Uji90i/AaOuiWUtUHSqTQnK1yxal4HsowzCd3txr6ldt/hz2ykmVAT0u9UP5Q+oJ+/0NQmporon
 hcuqcVZY1ivkbdEPUyV79P9sDIEHTCgynne+dCm/EB6ES8ic5c/IJcW+Uopmgf+AbpvXglfiVe1
 OLmcX5UmmfvqGGOwaEcjolYbv3xGHsTnnJMgAXAoIIzpUzHzQsomvjKrIxzNVxXU7KBFBC4B+Q8
 goZK/1T69su737TZ6aTnQLZyuao3Kh9CZ7jgEnftOWThbYL0CeunZEZ2XKIQp+CwskAJAOoA1kH
 /sojkjBldljeoFg1zmupNtJt+T92SP2jvU/QuuoMSNbBJ1Zfe7H8vWqSWrkahEkYDdYSJjwjRVJ
 S1QJt0qYJ4W2FqZVmD+4F/3IY/KUQQ==
X-Authority-Analysis: v=2.4 cv=W4g1lBWk c=1 sm=1 tr=0 ts=68f8de9b cx=c_pps
 a=9OPjPng9tO6d8HsITUYRUQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=_i-agLmN6pKht6g0Ao8A:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: VUM6H8cCT7g6Gb0h5J9zx9si-Z3jlSrn
X-Proofpoint-ORIG-GUID: VUM6H8cCT7g6Gb0h5J9zx9si-Z3jlSrn
X-Proofpoint-Spam-Reason: safe

This patch adds additional cs530x family variants.

cirrus,cs4282 - high-performance, 32-bit resolution, stereo CODEC
cirrus,cs4302 - high performance stereo DAC, 2 channels
cirrus,cs4304 - high performance stereo DAC, 4 channels
cirrus,cs4308 - high performance stereo DAC, 8 channels

Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 Documentation/devicetree/bindings/sound/cirrus,cs530x.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/cirrus,cs530x.yaml b/Documentation/devicetree/bindings/sound/cirrus,cs530x.yaml
index 9582eb8eb418..04ed197f91eb 100644
--- a/Documentation/devicetree/bindings/sound/cirrus,cs530x.yaml
+++ b/Documentation/devicetree/bindings/sound/cirrus,cs530x.yaml
@@ -19,6 +19,10 @@ allOf:
 properties:
   compatible:
     enum:
+      - cirrus,cs4282
+      - cirrus,cs4302
+      - cirrus,cs4304
+      - cirrus,cs4308
       - cirrus,cs5302
       - cirrus,cs5304
       - cirrus,cs5308
-- 
2.43.0


