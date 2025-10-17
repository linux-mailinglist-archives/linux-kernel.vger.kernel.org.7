Return-Path: <linux-kernel+bounces-858478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F6FBEAEA0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 18:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E54475A1FEF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B950129B239;
	Fri, 17 Oct 2025 16:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="hfDeCTT4";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="WJVxlZNW"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E902BE7C0;
	Fri, 17 Oct 2025 16:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760719624; cv=fail; b=TvpOAcYP9ys/3CODQFwPCBPmMEDJ9PNPJSLHZ4p7eBcPhLP4WHjY8KWL0SbQC+noNl8X0fDB+BlsLa2GKBi2hMUy0nFQPl53dv/jodLWxF0KdtJ8HvFV8irL4Fxawh5EbXxE4eiryA4hyy2UOOouIPiAK8ZZtN0XTcWFulLrEKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760719624; c=relaxed/simple;
	bh=IMQbdiDAMWGH6yqvZlc3nkhgj4JaHTlz69zBsfelpsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=paetqtjQs5yIvc/uJxsP8Ek78s0eQ9s8YS3LrV1hKUGD0hL+yu5smeB623WrFrcvDP1PbFkg6P8ZTrr9aSKKaLpzT+x4nNS+AB8STkf9fZVYqMl/MtVAAcBka2S0+SGGvagHciokurqnw8dpjM+wnM0uk8F9FE6yU0R6uIqYtzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=hfDeCTT4; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=WJVxlZNW; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59H0Ya4i4020959;
	Fri, 17 Oct 2025 11:46:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=fqf3VS0BZGu51pdKSS
	tfavCj73PE96ANJDaWf2S8pxc=; b=hfDeCTT4JbDGDcCWEDKeN8PvuPUdrtYLoi
	XVjddQfGj09fw294nefQONdW08i9/ZEHt3X5HugcJVlnRa6lcFRbHJxPmKff45l5
	kC0CoMhDRHeR5nWnQVJriserPPWMmBXxyeHmeolCTWa3lLD5UEEQrPTpIIfDsJzJ
	qDIeGsc6m+CDQVTkk50q5Cx7haPi276+pppJsdCylI+sClxWi1IoeL2sCRWVMoal
	ni+uJDF6N4LU9vYFsMJVZG/JkViKXjCvFEg183ejyec5oBsLXn8e9YYbzMQP9Wot
	8gQPDwIw9d+Hkkf+eVspnU+Bhr1cyia5MKwYONk2Xoj9ROTxwB1A==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11023117.outbound.protection.outlook.com [40.93.201.117])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 49ubc98xj2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 17 Oct 2025 11:46:53 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ozH6VVMNVLQFQzAsUC3C3KbXpOD7S0yquNEJxpnvwUEVZhoc+JoP9Xnkunu0TT5YD0rQzIE7kt9RsusIG5GbGWPaKIOmAwzuRY2Ydd1Msz/eUlRz8HdfDZY1pyU89iWUOmFXmVDiZJlyzjd+MN3M8WmfgyjdDFpgu0xQlZrDWX9KZITi8AyRoQ48gnr86w1ktS/CYHhvb1utQlmJ9G+ZtCqW8YpKM9RGdax2i1vPkRC1xHDz+A0BaCrttX++AR9OnAy1zZt23tINQrTHT4QM+ERVDQPopk0S6xfM7QV3l19KAOtVI3rJ3UFl2qMMZy48YNPJiWm+mLyE9O3Agi/Cog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fqf3VS0BZGu51pdKSStfavCj73PE96ANJDaWf2S8pxc=;
 b=Awu1vJYwQxtG4tVQ0T7v9+kYK4uEUxg6pjjR/WG6CxRhkIrUr3iiKl+Penhb4khoxISdv47bKNo6QshmMAET27v6UbdOmeR2C+FQdO7jmjk9L7hxwaVWUF94u+X1FHMRT3BLucbonq0VmJZ9/zmMF7mY2IwtOrgQOBGLsSUH3TFAq1uJrdPldCaTiCZZ42lbhmwJGIi+rqs1Ji9zWMt7Zy7o30dgEGQ4jhMKhIKx2EkOMSpXBuopEOaKgTIwQAvrNSnu9nMNTWp001tCyvxuD4dpUpoifR6pGjkH/iqlH3ZxxI8X205WwJdbeVICaUCquOetnQ0EhSjnDQ52+2Gipg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fqf3VS0BZGu51pdKSStfavCj73PE96ANJDaWf2S8pxc=;
 b=WJVxlZNWQ483hB+TqcSdJRhxjEGRkMe7xG5U0lbrzmsLgnxbomiJOokCfTMzwe7nPCzF5Cdxt7aNW5gaIj5vpPa7+/seEgT+oSfqxAxkKxF1mnRZ4wAJLFg07VddkXZOCkZ6V0g0qbCZeKUo99Who9o7xc4ddp5fPbYKs+M/zTg=
Received: from BN0PR02CA0025.namprd02.prod.outlook.com (2603:10b6:408:e4::30)
 by EA3PR19MB9472.namprd19.prod.outlook.com (2603:10b6:303:2b6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Fri, 17 Oct
 2025 16:46:51 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:408:e4:cafe::22) by BN0PR02CA0025.outlook.office365.com
 (2603:10b6:408:e4::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.13 via Frontend Transport; Fri,
 17 Oct 2025 16:46:50 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7
 via Frontend Transport; Fri, 17 Oct 2025 16:46:49 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 9417F40654B;
	Fri, 17 Oct 2025 16:46:48 +0000 (UTC)
Received: from lonswws03.ad.cirrus.com (lonswws03.ad.cirrus.com [198.90.188.34])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 3F6A9820249;
	Fri, 17 Oct 2025 16:46:48 +0000 (UTC)
Date: Fri, 17 Oct 2025 17:46:46 +0100
From: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To: Mark Brown <broonie@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 06/11] ASoC: dt-bindings: sound: cirrus: cs530x: Add
 cs530x variants
Message-ID: <aPJy9k8w1rgVRGsp@lonswws03.ad.cirrus.com>
References: <20251017161543.214235-1-vitalyr@opensource.cirrus.com>
 <20251017161543.214235-7-vitalyr@opensource.cirrus.com>
 <d51da899-cd16-4d5d-a754-e6fecbdab2e8@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d51da899-cd16-4d5d-a754-e6fecbdab2e8@sirena.org.uk>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|EA3PR19MB9472:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dc71e02-573f-41f4-50e1-08de0d9cc4c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|36860700013|376014|61400799027;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RgIzkSc9JaSvbAYBiI6PrYGbgWyDIYuLSGsjJkOgSZ25xgs2MYtVao+yeH53?=
 =?us-ascii?Q?3n7eA67cefKEMuBtj+Ume6YOzdkqZZBOMNUkRTXxqNwu3Jfh7jXFi0o7dk4y?=
 =?us-ascii?Q?yKjNjCXnV6Y1Y/FK0eLYZh77IPo22g0XwsbbvB+kYUEZAlIELWbQcoqYnnCO?=
 =?us-ascii?Q?fBC4YKi8GUa+MMzf+9YAA+oUFqyBwmj29Lnh3Cpjo0BfxE7v9LJbUmlBa9Wi?=
 =?us-ascii?Q?HQMqGU0PwMGBXQdqAjDz94+yGDXJ3UJNlAhd1rCyg22xp2Ft/W0KOKrqATPa?=
 =?us-ascii?Q?GrdJneWsJcA5XW8uc0SuL0koV4e58lThnbxtT1agiY9WjWOApcvodOJdyeXI?=
 =?us-ascii?Q?RjKW3Q4kQRm2wWwbMgDoqXjp2jK5NnLLy4erN0kLmC80jeu/s3iNXdYF/yGq?=
 =?us-ascii?Q?bHs+avqRv8+fcR7TCk3ycpu5qLS32DVuTazI+2jx6dNZMqcCqKDHkK5ucYkT?=
 =?us-ascii?Q?VNchP7mHYBbPONnZ/IRzkbWO3RZ9rUXoj147NwFKkKq5vRyl9ofcWn+qNIh5?=
 =?us-ascii?Q?qvnM93kKMaKTMqJA8pB68TfhJLoDSX8cRt2z4kJJ377f9xFmydEGvuwBsyfK?=
 =?us-ascii?Q?sV6rcpY+Yo9OfLhaGbzJGGv3b6WrvQh6jD2/njpWMYqMXrejpZj8L2pbspYn?=
 =?us-ascii?Q?91KWA4uar6+0As+JGsupz2vvHzZst+7Dkzknr6Xre8Spxr5Ug0rMrNDkolRd?=
 =?us-ascii?Q?x1xN1oJXYLWXKGx5umYY8Y/rCay17DE0YDFJ9DKb0Z3r/r3a8HMF956ksGtL?=
 =?us-ascii?Q?A4xZkzeLyu4IvdHijtdkvfnlM3nFICv3YtNe/xGsZ/2FVnZgFL4Go8pTBIy5?=
 =?us-ascii?Q?eyPh1AIdn9WHqGzkSa1V8FX5LLiHiGs0QVqTtA5MhbpvRgiQuXqdGplLfV8d?=
 =?us-ascii?Q?7SeSvGEcAURgKyEC02fFs6RjE5z0TeRMuf1zec/YbNSfnpAPYGohAlq3/BSB?=
 =?us-ascii?Q?1rT2sLXI11X+u/fpO86qXesY72zeNjfDPPjSZlFas+aYmjp2AV/Kxlibc3N3?=
 =?us-ascii?Q?naHJwOSkioo/M/sJPZFMjwpTUsfmdTdE+hr954UU+0cQCW3DqgDHsZxGmZOY?=
 =?us-ascii?Q?C+6qIK7Vsp88dknopI1Kn4z2fyddyO+eXZAY8Vlnjz1TbGzTdqjdd7iW9+ct?=
 =?us-ascii?Q?RKObdO/KXZgEgvyAREiPIiT1LWHNnntawJexXcF6bqMbPHsn0rvBU2wb0wFz?=
 =?us-ascii?Q?T1dFJ6qvi9KlMfpJKTN2N+t2SQ8mJEBKRwgBvu9OuGVKvvbjjYMeeUKpbxCX?=
 =?us-ascii?Q?7Sprt5d0UiL40dMiiUlXX0RTGaSORwKOnoneu+dqQCEKrzfGXHxPKzdSM/iY?=
 =?us-ascii?Q?FhX9uPN+lxmt2e8PnL36WcvwUuS0pIeHOuN5gtRTyEyqiT+GStOTM94K4lh0?=
 =?us-ascii?Q?LprPCRFK8U4dpzPsCbHvcFey+3pcLVKYd6NZqJReTTSVTRRqAmMCdomwVUc9?=
 =?us-ascii?Q?9MndinDun+OE6orbLzR+xS6OKsD/PZXvCF2aE9lK249lgfPVV+xJIvuQ59Nx?=
 =?us-ascii?Q?nLVYfjQx2xzUh8UV6lWHcFSNobacWNwmFBThl3cEfSqDBYxop3kUudTzXMo6?=
 =?us-ascii?Q?x396dQBpWQXwdqwHVwk=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(36860700013)(376014)(61400799027);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 16:46:49.8438
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dc71e02-573f-41f4-50e1-08de0d9cc4c6
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EA3PR19MB9472
X-Proofpoint-ORIG-GUID: j3PgLlqCb2OB3WUIORn-vM3NnrmP6-bj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE3MDEyNCBTYWx0ZWRfXyPSR49xFxljU
 EEhb9+2fAjqwJSwMN8xUEYhx4Z/u8JGW1knPfDFm4HP1o1dUeOdcOwrlcPMqGPqQa63GCuzo7Fj
 IGrAVIVFgC3JfDfr0k3gJI8Z2lwbmF5TZpyIzVk3azHknituU6ZIy692mX9/6amY4/ywbOm3tx/
 nkKoCnWRDLl6pxqW6BCRW56mEy0UU93jF06y8Sqrx2Z2fjVx5qOEYiXN4C/sFSMlbv9BvW657Oq
 CUSQehABCfD5IZHRPvUWWmjyxJIBUIlQc2n+u7YRSCD13oHs7gvYN4x/TXbJM3YONWsMvWGH4Xq
 YN7NhexSP3wJikHkcKISEJwz7J4iPBdIg/adbNWZVxoxu9kC9MMuK1q067ghY8L3Z2rEfKpnrF2
 QlbyBt5Cgs21xZHTTiFbxvp/go9N/g==
X-Proofpoint-GUID: j3PgLlqCb2OB3WUIORn-vM3NnrmP6-bj
X-Authority-Analysis: v=2.4 cv=H7bWAuYi c=1 sm=1 tr=0 ts=68f272fd cx=c_pps
 a=VfhbEJud1fjihyeaxwR2WQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=IDhZabKR4S6ew8z6--4A:9 a=CjuIK1q_8ugA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Reason: safe

On Fri, Oct 17, 2025 at 05:31:14PM +0100, Mark Brown wrote:
> On Fri, Oct 17, 2025 at 05:15:33PM +0100, Vitaly Rodionov wrote:
> 
> > --- a/Documentation/devicetree/bindings/sound/cirrus,cs530x.yaml
> > +++ b/Documentation/devicetree/bindings/sound/cirrus,cs530x.yaml
> > @@ -22,6 +22,10 @@ properties:
> >        - cirrus,cs5302
> >        - cirrus,cs5304
> >        - cirrus,cs5308
> > +      - cirrus,cs4282
> > +      - cirrus,cs4302
> > +      - cirrus,cs4304
> > +      - cirrus,cs4308
> 
> I've not gone back and cheked but I suspect Krzysztof's complaint on
> prior versions that he wasn't happy you weren't addressing was that
> these enumerations should be sorted.

Sorry, it looks like my email clent decided to send HTML somehow.
Yes, I missed the point about sorted listi again. Will address in the next
version.

Thank you


