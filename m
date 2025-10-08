Return-Path: <linux-kernel+bounces-845803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A09DABC621C
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 19:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6DF814E3CA9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 17:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B357128DF33;
	Wed,  8 Oct 2025 17:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="jpAScBBX";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="kNAIf0p8"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0890B1F462D;
	Wed,  8 Oct 2025 17:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759943807; cv=fail; b=LiqFfw6Jyrj9Zxz2Q8QQHlmsnSmv7yOu0asEQAfa/33IxNudvxb8gp6xgfrviW5onGHc+lS+nMc5lvzgbSj7o5/fIhXpKXIZp3WUMnFpkVOXtfHK3kFbzDygTvhWIQHoXcmXUR+Qgc2FettRUasv/80ZZArVKcEVfckJJ3X9E+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759943807; c=relaxed/simple;
	bh=OPqQ1N59aPzZVHJ0P7qjmnB5y17zn4v1xNJwrh4SqXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IEX9Pm+rnwRCREGcI7esvguQtU8f/aMvpCm73Mnm2rcej5iRUKatI6pjaA1hAZeU5LDCoHPWq3JfL5p1OFs5GUYAVc0YIn42nN7p+05M5Ozf1uWSff+LydqJ+pzllppbB2HWGXbYKXKOHbBsoiIkBUNW3l/tiDJGED9g9ROHbKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=jpAScBBX; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=kNAIf0p8; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5984jLQS393775;
	Wed, 8 Oct 2025 12:16:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=SYjsUyDeR/t+y6Xd3K
	z/LonWYJjpFSdzFzgHfDsjNks=; b=jpAScBBXXP8b8YPmQxMd+SZpZ+IYz83NMg
	dB/ZIkKwue3v67re2jXL8izfGTTfHeGiobDCe4tUiBclZa31b+PRDek9cwLm5uaQ
	UGWr7oSZbDfGPmpQBIyViwJuAnm6iUCrZUwVr0lDil9Aq0689/9kbl3P0iSSLoUI
	2KIxOiaDKlHmUF5baHlsXGmfJYTX6LUK+fiNzmNTSj4/aRh4kFkLmBUe1wVdh6hl
	NdHn2bNndMTOAdEFc+CsEF8cxvvI7QDf3AXQsioSj59h0WLlCMwQuoPPPpFzOUoR
	yEHBA+TWX0VQ/aijTr/qefL3U/i9EDQNjmci2scarNGcfxIXXGIg==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11023077.outbound.protection.outlook.com [40.93.201.77])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 49k00emske-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 08 Oct 2025 12:16:27 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hGcBuSERjJ3x5slf2rkZ2Ahu626lwTD+rUWxh+xtcVVbpqcziBC8VZV/NT2VuyfSbdjp1CeF6Jg7BelmQNJERFsHb2U2QHBGFYyoCn2Iz8LA7QF4jVTf+cwvazA/AM4c2d2ryb6+kSeflPdBWBXtPIerXC/tEkXm62RHpIMrnDGvpX9dYunH6vzByYW1uoVHz9cDJD+e2y4iqDaE65szhpmAKH+fD5Qt4ENktCgpYuisP3hQXdOw+yeXrXIMxaUr4Zvv+rLdylHztDbxkgIX38Tmv0KZFPd7ortSMo4hPXGp3UOKz7Yy1cQlvTuBh7UzwoTd59UkD4/gtFiXCEYKMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SYjsUyDeR/t+y6Xd3Kz/LonWYJjpFSdzFzgHfDsjNks=;
 b=lpinnD+nAr2uS8piMc6/9NDJLrrRThpk4BqnotipebhW1Uci6LqYkZ8ly8RiUPgwZKhNWOZaiGDQR9GYQRPCKKrKm4EOD0dx7jqmo3SGcynLb3TLZkGd7XbQviQxqnS1Gxns/vfIw68CLR+AlW2U6ZWpU/GlRi7ObfpK0qVTNG3TecIrLvz4nhGE4f8MI0tT3aRBNCXz9aAzRZymSyllSKODinSZw7ywmMh0J61+c9sC5z8SRu43Hu/qpZ7PbL+SEgN3Sj95PCHVmfLoM0ubz4m1aawTdwAg+1kvu+URPvXRiS7+aQqcUF//KAbgATCqLNSfPGiNekOxF1nU2WtbzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=gmail.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYjsUyDeR/t+y6Xd3Kz/LonWYJjpFSdzFzgHfDsjNks=;
 b=kNAIf0p8oXX4vxUIKNjmklKfrW+sF2dQAtgmJ9jGLpP4WGTljw0Sbdul0JdAOJUt+FAI9e2Llv4kWSMSaKxYB7SRGtFjUXry+4kSqnpziG8TR9sw1ZbyIFfRX2XAI6pxq9m5hrykBXO3j369af6hCsc5LYTvf0lFLdLk96e+ue0=
Received: from DM5PR08CA0038.namprd08.prod.outlook.com (2603:10b6:4:60::27) by
 LV0PR19MB9400.namprd19.prod.outlook.com (2603:10b6:408:324::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Wed, 8 Oct
 2025 17:16:24 +0000
Received: from DS3PEPF000099D8.namprd04.prod.outlook.com
 (2603:10b6:4:60:cafe::92) by DM5PR08CA0038.outlook.office365.com
 (2603:10b6:4:60::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Wed,
 8 Oct 2025 17:16:24 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 DS3PEPF000099D8.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9 via
 Frontend Transport; Wed, 8 Oct 2025 17:16:23 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 1743E406540;
	Wed,  8 Oct 2025 17:16:22 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 03042820244;
	Wed,  8 Oct 2025 17:16:22 +0000 (UTC)
Date: Wed, 8 Oct 2025 18:16:20 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Brian Sune <briansune@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] ASoC: wm8978: add missing BCLK divider setup
Message-ID: <aOacZAiWxG9XfWLS@opensource.cirrus.com>
References: <20251008162719.1829-1-briansune@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008162719.1829-1-briansune@gmail.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D8:EE_|LV0PR19MB9400:EE_
X-MS-Office365-Filtering-Correlation-Id: 87ca084a-8351-4053-0d01-08de068e6845
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|30052699003|61400799027|82310400026|36860700013|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KREAFfojHC9Q84TpSP/4BrfeB+5SxYl0ztBsE4GlW4w5Fy+AwMisRyCB7htW?=
 =?us-ascii?Q?9vX6WW4f1fQhGObNcCuaHCczMIgPOMsNgCG1tBtrPQ5IhbNkXY6iwsy/bWaC?=
 =?us-ascii?Q?A9Z3gi1rZskIfxdmx7iWP1jcZe9zQq3umcsSYnIMsHRMKIhdIHSBQOZVwYsH?=
 =?us-ascii?Q?VTZozfWpm2XF7OXF45Rb/yPg2j/wAkp20bB//h1KRsTJoPdZmFEHIbhD4Hfn?=
 =?us-ascii?Q?KUdEFjJgbreEPeqK9cEFvuHCkHe4WS/YuVIsje8zag3yA0ZyXAAvJCKU8Vez?=
 =?us-ascii?Q?yCKWQm2asC3KEfCwA5JL11JVqy30z4Xbp4HLsllwmX7zPY/spTILwav5NJF1?=
 =?us-ascii?Q?KG7H1//QR9M78cZJ6+QluvRgtSfpo6qFuKWlJ3HP+dmKdmD7h8c94T6fi6r+?=
 =?us-ascii?Q?+KOUI9Un4+lVryIQqGcQLdHUouKA/nG2HIA74wShF6u7PDU2MMixSaFA9S//?=
 =?us-ascii?Q?B7Qyv5IV3gQkqTp3yfRTUdZtVWkZ71r3fEMX0tgIOEIQcvMBrenM4q0BT8tg?=
 =?us-ascii?Q?gDyxJ6nEmAANP+nm04mQ1wHdqCQaG4lcQHu+wh8DwE2B7aIMGVEz6s2VuWAj?=
 =?us-ascii?Q?00X1Qc0vXQ6ivfkSJ+jh/UUt3S6gaE41BZAlcEVpQ/SneZ0AyWVkpOfDXKDt?=
 =?us-ascii?Q?eIA71cw/FhAxJO0p7RpBkeOVknidJNvlZ5Hmla8ye0nigRIyPeJlcSBFr2zw?=
 =?us-ascii?Q?TBygGTHOuB1PXv9Bpq9A48ZmmXsQ8yy3eIu1pLFO6/eWrVIiIIzoklTXMVct?=
 =?us-ascii?Q?waT1rxmRJcogvEcOeHBhn/GzMWN8n9ZsQQ5NJmv4qcqu8leoz+ZDe1vpLmKs?=
 =?us-ascii?Q?v/Zgb8YLwDcVymLuUqdnVtlI0ymjzFmf57LdlKqIC4FiyTruPF/gdLqhYQne?=
 =?us-ascii?Q?2P14WGS1BiYVBL/UcYa6SJd/bXbkzDWOnXXVL/9UxOduXVq0w2T0MegwEaJN?=
 =?us-ascii?Q?IxaBFDwOvEbQssMJIZQ2sPEZdBFBXenFVpofxB88/+QwXdrQRA49K10S8Tt9?=
 =?us-ascii?Q?d1CIazc4v9DFTygbeBmO7Y0DMXEQyw2MvRUC8M2MWi1hsKFFkO3JVrN3wYun?=
 =?us-ascii?Q?a39XbkDlh3/+tN3ualpJfSFLJTcrk1Inu5ex+DcU+lkM2lJqAZL4vXF4dQ32?=
 =?us-ascii?Q?CtKn80q4gDP7DlpPbbAKvvNFNUXydz1r66h8xwPnbLF6PHR+6TvxHpgRy0gG?=
 =?us-ascii?Q?KLUy6dFm6Fd/X1Py19dEadYRMAteIf9Ekyv9waNMrAX/HnpS9EKY8FYxX/Fs?=
 =?us-ascii?Q?/xHZ1M1X5gg/d2upELe+n5wpc8gGa9r5BGyt2YGMJvmjqju28vbFe59G/T4K?=
 =?us-ascii?Q?cwQBi6I9X5UtPNhYQw7OokaPQ1+SxPOjheTIkP1lk/qbL8UuM/J4dWRf0XI4?=
 =?us-ascii?Q?q7c0F9H4HiG/ZV915EdimvOyCvMeief3HnK6Iz5/UpTnqtU6oFNJ9p/tO1Ez?=
 =?us-ascii?Q?6NkD8eCr4elYaV+ETt45t2t/AMxodTuSqa1VAUvyPkhXeeQwXRSwQcR7Z8fF?=
 =?us-ascii?Q?GbUxXP7Nct2xTk+BOupl5W9xkD6Mq+h3/Gi9xCAb7FaaZ8k5IjSlY4Y2b0Cm?=
 =?us-ascii?Q?3svxL931SADL8rdkfw4=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(30052699003)(61400799027)(82310400026)(36860700013)(376014)(13003099007);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 17:16:23.5158
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87ca084a-8351-4053-0d01-08de068e6845
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DS3PEPF000099D8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR19MB9400
X-Proofpoint-ORIG-GUID: 0u6yBrvqLlyPylEcRsnAwvi3cdT_TeNY
X-Proofpoint-GUID: 0u6yBrvqLlyPylEcRsnAwvi3cdT_TeNY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX7laBHfK9I6N3
 XwrvQFKvwvVDiq24N0+veEOw78b5cfjEKp5blxaIEWg+VVigN8F7+/d9ma78pF6fFqYPc1MiDLg
 twO4YhqxespX2SDThkYiU91cFXpU5SjCPbCrDw94AlOn7AJaEQk3rKnK1uES4ZCFACxTFdAvuXA
 BJbt2OQpoLk70pP+ewU7s7MC1wJ+sOjAUFWe+nDGbspESO6CRGYf+jLlE5jeH9t+I5jkDypsxM0
 GD6c7Nar2mxG1Yemc4qFnBhjzaKsW+YjMR/XhgpTrT8yh3j4MIeDMla1sOrwiZgQTfiVWwkxnJN
 yjORgfs0ZooL2F0pbH7f8HXdXOiOI9fTqpNfVWaJ3q6VasWbSmyqXGVWWSXm8zTwNHiqRABK8R6
 xhLEdVm0V0ITRxhsYrTInIiwHFktzw==
X-Authority-Analysis: v=2.4 cv=Y7r1cxeN c=1 sm=1 tr=0 ts=68e69c6b cx=c_pps
 a=YgmEgYFPUO0vKsAsXG+6iA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=8AirrxEcAAAA:8 a=H92uEcXbIQSujEtmmCMA:9 a=CjuIK1q_8ugA:10
 a=ST-jHhOKWsTCqRlWije3:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Reason: safe

On Thu, Oct 09, 2025 at 12:27:19AM +0800, Brian Sune wrote:
> Apart from this core patch, due to request from Mark Brown and
> Charles Keepax. Overclock BCLK setup is applied, and dropped the
> possible lowest error BCLK result. On top of the overclocking,
> warning message is given to user as a reminding.
> This patch author do not agree with this design nor
> concept from first place!

Please read section 6.2 of the I2S specification[1], particularly
the last sentence before the note.

But if you are so concerned about the bclk being wrong, just
change your patch to only accept an exact bclk match? I am fine
with that, it's still an improvement on the current driver and
someone else can add the inexact matches later if they need them.

> +		for (i = 0; i < ARRAY_SIZE(bclk_divs); i++) {
> +			bclk = wm8978->f_256fs / bclk_divs[i];
> +
> +			if (bclk < target_bclk) {
> +				if (min_diff != 0)
> +					dev_warn(component->dev,
> +						 "Auto BCLK cannot fit, BCLK using: #%u\n",
> +						 wm8978->f_256fs / bclk_divs[bclkdiv]);
> +				break;
> +			}
> +
> +			if (abs(bclk - target_bclk) < min_diff) {
> +				min_diff = abs(bclk - target_bclk);
> +				bclkdiv = i;
> +			}

What you missing here is that your bclk_divs are sorted so all
this min_diff is wasted effort. Each time you move to a higher
divider there are only two options:

1) You are closer to the target bclk than last time.
2) You are under the target bclk and the system won't work.

So the last value that gives a bclk above the target is the
min_diff by definition.

Thanks,
Charles

[1] https://www.nxp.com/docs/en/user-manual/UM11732.pdf

