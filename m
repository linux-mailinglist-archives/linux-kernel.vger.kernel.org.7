Return-Path: <linux-kernel+bounces-844242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E97BC15C7
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 14:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9DB7E4E857F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 12:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED432DC77F;
	Tue,  7 Oct 2025 12:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="o24h6LKg";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="Z8RqtnZp"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB682556E;
	Tue,  7 Oct 2025 12:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759840036; cv=fail; b=qmI4PYLckY8hMo9ZOu3GXfVl5Oi6f9Jg2JvuHXNkKzRYUfJxtd93BA1aA+H6IPfPOZ7nn5FeqwYAi4kT3qPbsjH1hSw+baHDBm0BSMxhZuND2uHDnNbax+VjmBROM1CwAorrAKuQ4v25mEx6Fi20E9RTncFfMSmhnLYEt7DbIsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759840036; c=relaxed/simple;
	bh=t2fmiFZXcUz5iij0pvmgLNxb+vurL9GH/Wg+XMo6RZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cyZsnPZ5iRvkCsdHg9q6agThhs/csG0Uw7qK/6Vj7rH9hSXPaw0LLf2DwP6yLw/SzaLGueS9VGKrC+VApDdu/cPMz56AaVBkD8qa97JO1PCX3CnTxmvRfcpKEQy/GpvL215tZ2M/+TY8uv+gwpfEszxWGdpK0pP855tgGTwi0xQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=o24h6LKg; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=Z8RqtnZp; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5970WLkD1263520;
	Tue, 7 Oct 2025 07:27:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=p4DdLER3OQ6gtDSQwW
	OIgmk6N12BnpxRPMWuNjULkMQ=; b=o24h6LKg9h6cLdk4x56G34EALQi3IlASJD
	wwaXU039SKAoP+gqZmxiCFGXlI1H85lv84L/99ARcUwsqao3ul9UrIU9NObxdNZF
	vURNfyT+NjGCtnTKcliu72LheOb7YdQbsAGidHFxU/qdByM0KKVGy1ZZI32gO+c6
	x0XP0cvw5ARlx6Qa3DC5+KuhLZRiyb7ZZlTfLV7EEsdzlGBnXZL6WE9TdlFOWuED
	0Ym4Op76ZYWyowWf63zl8ONNbI3wjYRCxa4JnHnD9AURIh8Vv+wbhOV6283Xyk+O
	++pGJZOtPv1TV5OaN5FiMHIEbslpY9zb78o0KKxdt+TCf3k7vV9A==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11022103.outbound.protection.outlook.com [40.107.200.103])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 49k00ejxb7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 07 Oct 2025 07:27:05 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qHBS9V6A47RUqf7palTKaw0AT2z27UE76v9B7qGZE2HwwbGCHnjlUcFfG0Xyc73v8/aBcTOFfwAQ7urmArKogHxzWWqfP67/LYYgeRGxtXyt2ylq8U1cAAUyvRY9DSStnwt47qCDBEprNsOszjdREZLD2+xMU7SKB8AgMaHPs2wkDW6qQXFtKcVbRg0MeVplXBgq/+NhZ8lork4Nu3Uh6o0dhEk1SaX/IiBrwRtJgHImcR1WTAYnf9zWIZys8fuBtvO4WZQfP/3FRGL6lV9Hk1akeVc5Hwnp55sBlukLTFAthj18jabtyyKi9U/uCFlKUMObuUZMRnsC+Fjn3gW8WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p4DdLER3OQ6gtDSQwWOIgmk6N12BnpxRPMWuNjULkMQ=;
 b=HjLw8QfjLsMUhrBbrwBQvBmbLlnd1PE9U0lcOXkgB/YmsjIyli5IXmG7ydC79KH96MoY3USASZoQfuEoJi1Lj4RzksazkSx6b1mMnRPwingSM2BoyTFqpb5jnWO7czxPeOELY2doUUS14cSjPri/gMg1cJy5ldULMVqgR3txsmfJAtwDYidnUSulRkn+gjBaHLf/51rS9X27ORYHOAn794QA1dDMZVcHhU/KFJgBqcTQyLy7VPSNXGLZPpOK5cSdmPkNAXr2L2eP/8dSJ7Tgbyzkdy8nxyePCGtzUXE3+a/1iEdjaBiRTOrPOy+0taLe9gWzZdMyuTGzZhQBCbIYbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=gmail.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p4DdLER3OQ6gtDSQwWOIgmk6N12BnpxRPMWuNjULkMQ=;
 b=Z8RqtnZpN2lxYQG59eJ+eY1NqmSYW2Tq/nLZ6RvrF374QPOHFPxsrkTFXyXl9Mg1LUmaEJZ6v0NCodFizT7F/ILE5tbaANGzPRRSoYxgosdBg++CZo8lEw4TCN+meKNwy8SxtH7Th3SazsERTrLfjtHIOcp2DVJuiuJbxgqruvA=
Received: from DM6PR18CA0026.namprd18.prod.outlook.com (2603:10b6:5:15b::39)
 by CH3PR19MB8128.namprd19.prod.outlook.com (2603:10b6:610:17f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 12:26:56 +0000
Received: from DS2PEPF00003439.namprd02.prod.outlook.com
 (2603:10b6:5:15b:cafe::b1) by DM6PR18CA0026.outlook.office365.com
 (2603:10b6:5:15b::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Tue,
 7 Oct 2025 12:26:56 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 DS2PEPF00003439.mail.protection.outlook.com (10.167.18.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9
 via Frontend Transport; Tue, 7 Oct 2025 12:26:55 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id F3C94406540;
	Tue,  7 Oct 2025 12:26:53 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id D9593820244;
	Tue,  7 Oct 2025 12:26:53 +0000 (UTC)
Date: Tue, 7 Oct 2025 13:26:52 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Mark Brown <broonie@kernel.org>
Cc: Sune Brian <briansune@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sound/soc/codecs/wm8978: add missing BCLK divider setup
Message-ID: <aOUHDJW5aJzD7Ku7@opensource.cirrus.com>
References: <20251003091304.3686-1-briansune@gmail.com>
 <aOTrsYllMst3oR03@opensource.cirrus.com>
 <CAN7C2SB5Re35yGYsqr14hGXde3nTKLX2Aa3ZbuJ9xuT0m07uxg@mail.gmail.com>
 <aOUDbF/i4+9PXc1j@opensource.cirrus.com>
 <e507ace6-90af-4763-a1e9-08e02f9e63f1@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e507ace6-90af-4763-a1e9-08e02f9e63f1@sirena.org.uk>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003439:EE_|CH3PR19MB8128:EE_
X-MS-Office365-Filtering-Correlation-Id: 989e6446-a312-4fcc-dec5-08de059ccd87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|61400799027|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QyjG2WdBJfJb4VekzAKO6xsKYMpcoXJWKZRq9qd3kgg78TRW2yJ0TfFau5bV?=
 =?us-ascii?Q?g945yRLohxaLo4YR/ekvBW/iIP1SPmlDbsIj3OLH2pUC1upRXox6ifnKBQaH?=
 =?us-ascii?Q?b8fjtt76cMspEDQ2ZzR3qwQZtktySMWXxelqHF9gBCw9PVRIJQgpF375yUpf?=
 =?us-ascii?Q?AQDMg3/OsjdFRs6cnNkOxP4A3EfD6I2AMrsAPNUIUAa1BLYqaQPUhJZswsi3?=
 =?us-ascii?Q?y+m+uN72en//mSyqsggGzvPPleJz65fwTzxXS4evQhuzI/2khewOYCXHbJIg?=
 =?us-ascii?Q?egqOnlQMIwV/2blL4Yi5fjLYAjP4qKw6H5gEJRDcDlXTD0KLxQvCZB14WSQU?=
 =?us-ascii?Q?my9XbT/ARa14X5ZmL77tudir59NtYETo8WO7hrec06NWqoXt3eEgOURW1Fm+?=
 =?us-ascii?Q?xkV4Wd0rcwuop5bYlm83k3y6BsxK3+CgovGAhw1PDW2/j/1tBYO3BI7QZIs6?=
 =?us-ascii?Q?qxWUSyRGHuFW0W7v9A+78gjS1//pXaoAnr/8cxGZmQPSXWyz/e/L4chWdeZ0?=
 =?us-ascii?Q?V74z/hhF6jUM0gwXUFOelPezpaWQJrPOHvY5tqwvmbQkIn42fTUKz+3pzpHn?=
 =?us-ascii?Q?WMn/hsFSW3uhfBOVHIVMbOICL3zYWE0zw6pQGVirl4yI/+09YXx/lYTkl1jW?=
 =?us-ascii?Q?BB0Vj2dMYASPGBtCOT+D3PGuRAkjOnV1z2RrIx31H8qqpX35rlGYsXywXUsY?=
 =?us-ascii?Q?gtEjVreq+CFAA0SXuB8es9FeNUlI6LL1l775HYCinbcbrNsu1D9OTVPP98/n?=
 =?us-ascii?Q?aahKuQWhuOll8myYDVGx/5qzUTXgvlphw1blkBF1OaosLniZu7lYYlhn7Hrx?=
 =?us-ascii?Q?VhPs5e8RF2LP8FSUk0MD2Ii+6KtuL3WnMrvO51ZmUGhsVXznmEuOzUgVdrTi?=
 =?us-ascii?Q?W5uylT02ZBcKVgYM1emHzptPtfTbWOH3yBCXhtz+cbKnYzOaGkg4xoF31Ws7?=
 =?us-ascii?Q?Uz7Q7Oh75IPaeGoT5yyj1vVikdtlKyOSKxfKGWDK49p3zwEHn4GVuGUrcenP?=
 =?us-ascii?Q?TPBHHeF/Y/D4QdfOsDzjcNrFrE7bZd33JOu8zfCmk6AgK6s0waSGZWYGFT/S?=
 =?us-ascii?Q?2X2nsescIb8ygCcktpT5tYVm94/5vsatcZ7OnvtiJKXDF0n723ea60146N24?=
 =?us-ascii?Q?Uhm0mKhA8qePAAkqywzQSRl8AMa8K3EZnQXug652zrcZ01nVn0vVVxx50CZz?=
 =?us-ascii?Q?KE3Q0tivX/8/jOBbBxlVV5Jog4rQc6PCNlhzD4t8oc+cB8I+VXUjIknkYS6w?=
 =?us-ascii?Q?dNhrTIAkJFqq+Iu11vaRFyev1d1nGl/Koq+eM467kxvz/NcmEU6C24vLSfmZ?=
 =?us-ascii?Q?//dwhanOCV036jf3rSemJUs3u3KU/BHvwCu3rbPQcuemdr85LkXaVgsxriln?=
 =?us-ascii?Q?Vywi2T6lP8A/7qzGIntees99H+OOqMvt2wCHqGRH07YP4oXvjj1uYYIbxuz7?=
 =?us-ascii?Q?2ZMG1GY8d5p9x+9TyHJEsFh6rr/ibJCJsbuBwS/klyIaqL0ho52mU6m/kCJa?=
 =?us-ascii?Q?L8K7J5Lt1N41839IxPlYkn2XTRfRSalnxUm/AJQSalomwzwBtQCH46bIrt3i?=
 =?us-ascii?Q?PMM7WQ0lGe+HhB8W5j4=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(61400799027)(376014)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 12:26:55.1644
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 989e6446-a312-4fcc-dec5-08de059ccd87
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DS2PEPF00003439.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR19MB8128
X-Proofpoint-ORIG-GUID: sIb6Ry98dlCoHFq-hcYx0i96KOeOlly_
X-Proofpoint-GUID: sIb6Ry98dlCoHFq-hcYx0i96KOeOlly_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA3MDA5OSBTYWx0ZWRfX1UxrKLuG454/
 IRBWE5LVuzA8L/96PMqP4QwvcErjuk4ZB448GwkbTYRNeoXot0y/TtcIDo259W3m1O7/sjYPior
 Ev4Ryv7dpxPS0xvaSeYRKMlNaEJWbgpwwQhV/e1CdxFX9EraNiH+9JL6s6ql1Yyazk8lUN9ro5x
 gXNzPqE1vQMsqo0+Mr+myZ76LR5dNUM5aa2GxpQpLLpxTONYDAL/rr4Q4YZC9NVRaJnzo13yh8j
 g8JRwU96TKyqzhw2KhIi9F+miAM5/nJeyHsx45wOS4vq68CsDMrVCfWikVi5wF0E0ZISAQBKoo9
 OwU4Kw3A+dCznhafHYf7w5j++krUJ+Lnh3VCYXqaqTvHpd7Pso99ixZU4eE0ZH2ekxzDuI7NHgb
 xej5C4zJqrsWIdWYMg7Z7MM1AdsEAQ==
X-Authority-Analysis: v=2.4 cv=Y7r1cxeN c=1 sm=1 tr=0 ts=68e50719 cx=c_pps
 a=K7AEBdpZSLD1v8U6HgG+qg==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=SFdRu_vXI01d3eSsnywA:9 a=CjuIK1q_8ugA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Reason: safe

On Tue, Oct 07, 2025 at 01:18:02PM +0100, Mark Brown wrote:
> On Tue, Oct 07, 2025 at 01:11:24PM +0100, Charles Keepax wrote:
> 
> > Its not missing its right there. That said your way is probably
> > slightly more standard these days, but we should take care of the
> > interaction between the two.
> 
> Where we've had users using the manual divider configuration that we
> cared about in the past we've suppressed automatic configuration if
> manual configuration has ever been done by the machine driver.

I don't see any current users for the manual divider configuration
at least in mainline, so we could probably just drop the manual
stuff. I don't think I have a strong opinion between that
and blocking the automatic configuration if it was previously
set manually, but we should do one of them to keep things clear.

Thanks,
Charles

