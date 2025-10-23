Return-Path: <linux-kernel+bounces-866559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25990C0017D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A2B11A07EB1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA09D2FE59A;
	Thu, 23 Oct 2025 09:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="BsWsaDs9";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="GpQa+TMq"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7B02FC877;
	Thu, 23 Oct 2025 09:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761210246; cv=fail; b=iUZjpNjGX+QDIxeZKYE3tPiyOzXY/cRc+D565VSwbToR0Uirroo8bcmq9jqGv8VnLm+TgIfTaDUgGbNOacpC5BfLNEdGA8uSYbCfsbXONxwKWhn9lrvPb2oTaTEiw9sSQEekIOhaLtExR+mRaKFiLgPCTdirnzgfhzeYYoIEOVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761210246; c=relaxed/simple;
	bh=CdxNX3SzRyaVavRN2C1DHwIaKn6uWghjWdEEW9C86mE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mM1wNLVcxZZ62ieo3T0nKJWTAW6VcdICCttcCtcTfdUPlcRD3f3Tp3Sa6zXUxStmt56/jwK4kiMBg1L1vw26tDmVGS02VzHAaE8OxNHSXHAR/5t3tUd9PzFbkJGNP64s9SlokUZ9RkmOxQJ7+Sly4z311wUj8WK7eBELDvcfykw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=BsWsaDs9; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=GpQa+TMq; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59MJfFdQ3659668;
	Thu, 23 Oct 2025 04:03:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=+Jg8/DVjuEFoGS+z8QQwazvWpMxbjYdpHzzXwJFNH5g=; b=
	BsWsaDs9R5SYrn53J/s7gTqsOQZ1oAgFg5myrzT//Cii10Lw7SoDUWs1z/vsEiCC
	qTrGwWtVO0JQd81F1ER0P5aL43WiYADo5BydDI9+k1r+3rZLHzoAaih66T1hHrL2
	Qqm/uCpAn2KnSk+PFACY2BPSriMEJiVP/793D/AE7m1z/P8AD9MAU68hGJmsxVMc
	LztmZY5AWOOuItGlTHbOK2sf/M89dgPjSEN+cLZosQsIed+tmZsg6WILbuyjHNTM
	ItpZLd7YzfP6kAwB2b/Z6usLcqcfBFzWEuva+V0e3pJl5mSbr3Gla+rn6SDNJkkF
	kJ6mWPpxnC7J2BN5GM1PIQ==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11023132.outbound.protection.outlook.com [40.93.196.132])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 49xqmqsx46-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 23 Oct 2025 04:03:46 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YNRbw5zQIpcHawLt2IlRG8xmyVXwD3LTSbq+IWqeMCez9PdvugIuU5dd3odRi3pIECMXRBRCTWzMJpLgCRhucI4uHSWrmYehmCyoif4E7Ba9sz22u8hH1ftiihVEcDQbXI/lazcb5mvKwtCH5KAgw2R8SVaR7u1Baw4kgXzeLc9wa7jcKliayTQT7FUvwdgvFUrO6ldsnQ0CCDtxrvj2z1jH84gREXFzuwmiqCCvny8MCjhJC3pA5MVR7AYlpLcCdnfeDvrXI8INRRLtUqPS0pG90IV/wz5cof4M3wbdlWnPUKVKLJrrEOUFhiFa3tDOLBHNzhlj9ZliWi4QPCAx9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Jg8/DVjuEFoGS+z8QQwazvWpMxbjYdpHzzXwJFNH5g=;
 b=Uts2PdgQf63hRox01NVUl3LOkPS9Fsb6HoA1k4TCJiXBoLQjXg9mLAQuj1XdYAdjeoxSmuHKlNTPgOAgWGJ5FAjGmDxCbWYXK1/rwQjcR2yc44ggYi/61mZC9+7wcwtMhMwYmoio7LP/CXYAxFzHKCLtGdlLLW0kqdyHDKUp8zT9j85utvLSLjkPJbNmolUipgjkynGAKWiahsrd+zNKXKpHRPkp/+Zf/asixfOHr7I5UlKES43ix3Jl4c+XJWn2D/qaoZRpV9z7uc6voK+/vwbHlQDWLlGQA0k2AF1Y8r/C8gxUXFcl9LbNJ2+wFum4IVwMXRYg9QpyDKDWLLUSsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Jg8/DVjuEFoGS+z8QQwazvWpMxbjYdpHzzXwJFNH5g=;
 b=GpQa+TMq5wxhujFiMEN6Po/ADrqs89jOtNVD3ZFrz80c6Y0HdAB5vdvCwp+oCn6U+UvNvjQIXpi0OsdviXEP4YJKDHonsOvCdjblYa9JSp1GhIaMYW6PaOw7gIqc6OTHEHrusPVK/Kb0LybEIxA3NzGNd6U7OFjEli5c8fptCNs=
Received: from BYAPR02CA0049.namprd02.prod.outlook.com (2603:10b6:a03:54::26)
 by DS0PR19MB7743.namprd19.prod.outlook.com (2603:10b6:8:122::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 09:03:42 +0000
Received: from CO1PEPF000075EE.namprd03.prod.outlook.com
 (2603:10b6:a03:54:cafe::2c) by BYAPR02CA0049.outlook.office365.com
 (2603:10b6:a03:54::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.13 via Frontend Transport; Thu,
 23 Oct 2025 09:03:42 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CO1PEPF000075EE.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7
 via Frontend Transport; Thu, 23 Oct 2025 09:03:40 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id BC7DC406556;
	Thu, 23 Oct 2025 09:03:38 +0000 (UTC)
Received: from lonswws03.ad.cirrus.com (lonswws03.ad.cirrus.com [198.90.188.34])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 62037822540;
	Thu, 23 Oct 2025 09:03:38 +0000 (UTC)
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
Subject: [PATCH v6 05/12] ASoC: dt-bindings: sound: cirrus: cs530x: Add cs530x
Date: Thu, 23 Oct 2025 10:03:13 +0100
Message-ID: <20251023090327.58275-6-vitalyr@opensource.cirrus.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EE:EE_|DS0PR19MB7743:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 93cf79b9-5cd3-4459-bc90-08de12130fc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|61400799027;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e4oct+Nja6O0/+6tmLpbwlWT/MI71tJu414GCSgpH8ezVhvTk3s511o1wdXk?=
 =?us-ascii?Q?Zf4tEgGJ43oXppzL5O1KZIrnIQqtp/uJ/ABdl94cTKh8/1sk3zbxipW82qpx?=
 =?us-ascii?Q?n4K8ajb9jeLX1DaDfVUbx/fvLTD/y9n80Nx951v/iAiH8OqWr2EB7sg0l8Q3?=
 =?us-ascii?Q?SG7r1ZrzeNCyiLhZJBGGtzF60ieOBHtF/uWy7j0COLCG2MMX9MGLy/SDXWdn?=
 =?us-ascii?Q?MptlbLRN1jJ+aBJs+cO5wCZ89timtZHluE6YczJtdIs7C1zvxlexnZP8r552?=
 =?us-ascii?Q?bxguNZSz/kNhSv44zr0Isc3IBr5jGGtaA1B8SKXPD7mKJj242S0dzK9Y+hSy?=
 =?us-ascii?Q?Vb5xT1KNLvpPc9shIzQ2XQuLuCMlOYPtbtIk6+gWgXutHxEk2rI+xTCodj0u?=
 =?us-ascii?Q?xOF5tLqrhjTjWK8Yr4VJ/3oCrjQ0cPN81012cjtxggButPBq5Ys8mIOtu0VC?=
 =?us-ascii?Q?ovrAFJeWg9KtOms5MT5O19T6vmoyCBhprLNUvWcropDIvRxX3II41d7PyjI5?=
 =?us-ascii?Q?5JXWJQdjGwPRQx7k7j38Qog8bTDAalIxKMZDe9fCX0oJmdx3oVonfbo3Sl/D?=
 =?us-ascii?Q?sRh4wvKgp/bT6kdgKLTTiEfYZDMO4C3MI4ZZzAs3xyQ92WyXLUwybdv+l+UA?=
 =?us-ascii?Q?Nxf8O8rTppfD+OX0dZZUgPnfRfU3xINseKkUHmhDXHMhIjTP+QV8R68aKNUK?=
 =?us-ascii?Q?dS6MnASIDnH5ksYPA7wS/Mosw2LLQAI7lDD5z8g11LquyWZTIi/VNu2OTWci?=
 =?us-ascii?Q?TRx4NN+VAGaWjRo3e+D1ZszxvkotbJ/613sybIDug4vQsOlwikDfZxBl/zj3?=
 =?us-ascii?Q?/oWolXj4sJh/xGvkp81W26T6xFksYLTaNzw+sdihAocygta1B68MEPKBOyQj?=
 =?us-ascii?Q?uwNlW/4AdEgHsoK91vH23GamyZNTBVwhO3bPRA+r6x4LDDAsdjnFBnA7S9DT?=
 =?us-ascii?Q?eBMmYP3MzCLguYRo8JmhNilKVwlubt5+/3RBZskptpkG/xtSXq/O82V88mnx?=
 =?us-ascii?Q?o2csqtA3SNAMNQ+QLqgfemA2lW6n5qexCLYLMGC/G6E3tuybgZ82LcdngeGf?=
 =?us-ascii?Q?bxNCGgLKKKWtdfzMKEBKqMwzRpD0wMG51rb2s2HPO+DlQvynnECz0c+1BGRC?=
 =?us-ascii?Q?hzHxvMDwn29eRrnMA+HAN0jECZth1Z9feIuk5LHATCC4g4PZ0CpDXv4954l3?=
 =?us-ascii?Q?+nhGzCMvTchob+wnaL1sQGD0ker9BmXO5JJVZYqWriUPmwhA7OotMV1RJkvp?=
 =?us-ascii?Q?CGhCjMJYwRpPlJ22K1fR+v+h9wPZPz8Nxf0p8tCFKM7f9IeY2B4WB6bPv+vD?=
 =?us-ascii?Q?Zj4X74BK946o8XIyl1i850dvxOa16Z2o052KqHG8xcei5v5jwoLFgqs2gjdZ?=
 =?us-ascii?Q?Xki+B4zI4uNKZRKlbwQPTDl2KPA0oH1tZuExvBnGZzUMJlHPqpn1vOMr0pCz?=
 =?us-ascii?Q?R1wHGr2GmUov4yjjLHVcBTtecO+umhn5lWc2DwTOE7yDtTvPaWmnQ8oTeCrF?=
 =?us-ascii?Q?OqBKPkE0ddSeo7oIEcHqL8DquseGk+J47RZwtoFLJmmcd2VkP+HAsLgGacVO?=
 =?us-ascii?Q?vj3b3UTW/Q5rLNMab8w=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(61400799027);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 09:03:40.8005
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93cf79b9-5cd3-4459-bc90-08de12130fc2
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CO1PEPF000075EE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR19MB7743
X-Authority-Analysis: v=2.4 cv=G6gR0tk5 c=1 sm=1 tr=0 ts=68f9ef72 cx=c_pps
 a=LH/tFbq2k+kQ3xVriB62Mw==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=_i-agLmN6pKht6g0Ao8A:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: xx3tbw5QMjJ83DvffhefYKZaDp1Mbfo0
X-Proofpoint-GUID: xx3tbw5QMjJ83DvffhefYKZaDp1Mbfo0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIzMDA4MCBTYWx0ZWRfX56c/pEQbhDFN
 PcLXG/3RNElOjxvGrbmbpmAB/g2H3ot7oCTaIE8XTS6ZXXDgDF/RzJGMgH/ddT7eBMG05yJzz/m
 ZaDhL26aZR7YQs9PEu0tyCIyf2Sp1gwZjfw3/LgxFvDqT7VJ6l7vSq644Zl8btcn8FAvBC7rTV5
 wHF/JssqnxCzXw8gVbEW3CtolgTp7MQSGFfyEn4UyOs7Yylk9+L8C1zauDRpwZpnz6lcPYdi2J+
 RRLLNFTcj5HiJ0f1hm1BeEGwr6K2tuxq43xxAIo4K0DAQCM6Mvp8Hvx6hpvpKyvkBDyFiEMyxVf
 NRCpBXthIY2TQAf5hVdTiM9qSagCBBzxR7uMZylccNmB07K3KXw9tPKrLZpejMb1URZL2MoXH34
 ZmGhElJCbRg5qHGdS5o5llJtgmzBjw==
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


