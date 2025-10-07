Return-Path: <linux-kernel+bounces-844433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15271BC1E8D
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 17:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 712D43B84D4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 15:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD612E5438;
	Tue,  7 Oct 2025 15:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="FYQxQvUc";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="CD/C7mdF"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C6F2E2DFB;
	Tue,  7 Oct 2025 15:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759850498; cv=fail; b=YDfXBUSF/gRnhSDwhY9Wmi0DgbTvCkrCP1AWS29HLVlvixcbaPXYDRznCno2NjMszNan9FX8oLBhkgQCZ4TaR2ZBW/iCmrm6tM2a7D8P25DTiWpiosNhceKjt1iNpyDdWWRb9RgacdhRVitfsVgwCJHWLw64E84/Dw++ybzWDLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759850498; c=relaxed/simple;
	bh=wF9qKwjmplH8n5xY//pYJSLzWAjJ9KwDc3HdOGWH6Fk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i7gmQTSBwoYCtKP14E9JySq5CgI745SOOfw6O6SANwO15pcduDbLnuu2AvHEGLygaHH9PvW7ec68gsOA/r0V5PSabiIxXYV+eaEHso9X7SV08mOhNZnu4TC08EoyOv04aqQQ5Cy9SbQi4aCG9x8u9lLr2AoXDIzUKJ4x7XqjVlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=FYQxQvUc; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=CD/C7mdF; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5970WL1a1263520;
	Tue, 7 Oct 2025 10:21:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=V5owGoxy7snWcrmWr/
	vWZc1MPXsW3ecZYn4DIx5ZyuU=; b=FYQxQvUcPiHdyegHxvcsLK7iAoYSxgjNEd
	7OPcO9FP/sUK1rDhnlOeOkqCsvbHBEBXCrJRWHInvG8vzGvGvwnZpT6yJOhF1egk
	SgLd9mic+sCf0dNiosvEWfXDFwZdyAJLB9mguB1C0kiRWqVtuzxEbpFVtz7OKddV
	shRarPcx6QCiPMiYVhNgvOzp/bI+Ynjel+D048XzLDcSfhFuypTlBhAb6RaRZCgS
	LIB5FAiuGByVv9KnyFNHrk/rCmVkm2TVPyGuM0u8f++QLAY+unMwNf8DZxKKqZoz
	yC715sHhYpbeSS0O9Pp5XjA32G8PHxp6O+IFcLFudWKxVLf41UPg==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11021093.outbound.protection.outlook.com [40.93.194.93])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 49k00ek9de-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 07 Oct 2025 10:21:28 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rs4Cw0jlxrKE5d6MvXJ6qP/w/ct/GonG/4bP2MxK5nAd2uok9eHCo0rWqJjSvQTGFi6wsEWb8tID6eE35GQwx9X9+k4RocggXhHZeXhHUqbu7b7eGmYEZKw6DNSAVRKX1i/BbmFZA9aXY2KocbkDCO9i4DtdVqj2hXlgHnEOhsQple4BzhjRB7xffc7D1M4ESUlwROqxKzflcSh5/rnyUC+aA4P2TTDZ9vYaX66vltG8xSeQpUbS0qcuw+7ebyzwAr2y6IEwsKtxi7w/XUG1IdeLqBTHNZ2O/wlrU+GMfXKN9w5SwTw9MiH2JqpTAG6dPTIAeDswm7/rGjauFQr9KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V5owGoxy7snWcrmWr/vWZc1MPXsW3ecZYn4DIx5ZyuU=;
 b=pZ4E2lWizMUTtD07G8iELKq115emun0VNLsmQp5cy4rYO6OwwVq9IyWe497wksH7IkrJY2u7qnLvB+M0VNAL8tjBwi2cKbR+m3r6rCpDjBw422KSDc94QcY9jCcnAl9JImACvJv6WJmYAmU+w1VGzXM+s6znx7Gom06C3kmLB3rh4ejGjL5oXjF84RwG6IXD8+D1M1SP8DMqDGFy7lNodJwJgItWI4n+7rMVMbR7Rvay1JxcdoR2nfLawbDDTXLOi1PDEwx7qq0r+F4K5TfQtK9vij6ye+OUqw8nUhNoecQlFbGHTKbaXPhI4AxhtOHBZKUqMQHRTTCgQPef1vAlWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=gmail.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5owGoxy7snWcrmWr/vWZc1MPXsW3ecZYn4DIx5ZyuU=;
 b=CD/C7mdFTiaxzFA12A1QlyH06qz8TRQwlC4gx9NA9ug4IK8a88TeR3EyTmZJTr7LQHXUXjYERNAh2pvXqZxkI2DyQhFrCeQk5cXX3/bTQ3gfX40sd7Z0LL3BaH0rpqoKZEUy6Zz6h2SYz+Bp8aFyKrusmuKw1mz8H6rF8ZfCzjw=
Received: from PH7PR02CA0009.namprd02.prod.outlook.com (2603:10b6:510:33d::11)
 by SJ0PR19MB5349.namprd19.prod.outlook.com (2603:10b6:a03:3da::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 15:21:19 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:510:33d:cafe::7f) by PH7PR02CA0009.outlook.office365.com
 (2603:10b6:510:33d::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Tue,
 7 Oct 2025 15:21:19 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9
 via Frontend Transport; Tue, 7 Oct 2025 15:21:18 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id EDF95406540;
	Tue,  7 Oct 2025 15:21:16 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id DA913820244;
	Tue,  7 Oct 2025 15:21:16 +0000 (UTC)
Date: Tue, 7 Oct 2025 16:21:15 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Brian Sune <briansune@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ASoC: wm8978: add missing BCLK divider setup
Message-ID: <aOUv69rMkyYFiHae@opensource.cirrus.com>
References: <20251007145028.1845-1-briansune@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007145028.1845-1-briansune@gmail.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|SJ0PR19MB5349:EE_
X-MS-Office365-Filtering-Correlation-Id: eab8dad1-e2ac-4894-351e-08de05b529f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|61400799027|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rW/THjqdrJdXqzFMlFTvMNnxMubmyb1yjXm6PkQbHjA5bO6Yyy64AaV7x/Qs?=
 =?us-ascii?Q?Z/9Jq3ggAAS/EIT/Alpw4JtBhqyj2WVad/ixTuhNzJWFL2lwoc243SEy7Iqs?=
 =?us-ascii?Q?ShEc9JfpiuaSfMKT8BqtlSZ3uA+KmcgpxM4NHoI4L24IX6JCpDE+Bhuz5wMx?=
 =?us-ascii?Q?3e6I077xi7xlEcjP8dZI9iTU6whwS/y+DIcFwA92pvavmGG+u1DyAUWPG+fE?=
 =?us-ascii?Q?sEHCSN3lg3DtxTrTfSazhlFLaf+w1HmH0WqOSvd1FlvbtbOVEEL+mA1p3mnT?=
 =?us-ascii?Q?RVs9kuBSbtb5RmyutHphEDp6FcRNDGmbdZ9LR9ZPnFHYG3cuFOgLZ3781qfW?=
 =?us-ascii?Q?o1y0CoXIkqgx+KQMqmUDt2IKhuxuFqo0S+a5h6OJp9DdBqKOToPXXhN6hO5q?=
 =?us-ascii?Q?Cxy88M0z27SzLRcXZu+KyAKjLeEf7C6+LImp8zbJZdUPp8urcMBzgY7dgtsA?=
 =?us-ascii?Q?4xHcidnvk+one2+Dj4dxaK1ttT8m2zjIrx4lQ7UKJg8ONO1u5FVNbgMT7VAr?=
 =?us-ascii?Q?j2sKBaRW2kPZ4Z7rSMAvZgMs7vyOCfy7YoG1pE03Zlrf5qM3vNcUqdUf1Ize?=
 =?us-ascii?Q?Ca0+Wj2aMCbTWv538LeUzIijSWJWsv2FQwmCu9AfzW0r0Rq1iVt04yS8oxC1?=
 =?us-ascii?Q?pPTPTGUqwF0UD5UUv4vNNFSmObOqIrrn+X9JET7UKs4YQBAUFl/q7CE9hAy2?=
 =?us-ascii?Q?pFSe/jWTM1gR6Di0/tb/I63PKFwh9QOiavB7l000uOy8x+NCVnprhgNSZCwV?=
 =?us-ascii?Q?E6Tmj6hXllLOcp6xmg6x3MXdVaoXg4rZpgf5Rgls2MBAy0Lfjal7rUiarL9G?=
 =?us-ascii?Q?jZnz4Uqz9RuFseqETW7Q2/mMd4fHNwn6Erk9O5P95PpTmBpqi9t+Hl2cN59D?=
 =?us-ascii?Q?BbvuHivJVcAUsS8myciAFwxXto1UAEiazEDKRwlOVhMHu2feoIC44MMyPeX7?=
 =?us-ascii?Q?/k71Sl7j4N+YKZiEnI5+u0C1Qa1e7Kf40cX4VB74bDu51K72IWGlawuaSpZN?=
 =?us-ascii?Q?fFu9uH2dO57yq0xiLrYvABTUVZJHLQdeFmXggvYllgC9QF7B/2+gB7lyUZyb?=
 =?us-ascii?Q?WXe+XacHirlrf1Vjzafopl+Lv3veJaL3mttcXdt5qgAxyqeFFglDdaHGY3CN?=
 =?us-ascii?Q?97RH/JGb68pXQ0P5gI9A7CsRvoLQD6cusOGvEYy2YU0Lj1wGShB5t+x9KYfc?=
 =?us-ascii?Q?BCWDBvGI39GBY85ucWjOdM490GByMnEVrR6+t2jkeF5YsRfMVCNaxyWYyVB2?=
 =?us-ascii?Q?lhWuNTwInlX6OhpTvh7i9czQNR4j2xBROvM/fmA3HtTgDb8r5id952B4wt6n?=
 =?us-ascii?Q?wgYQsWpZh37wIkAkDb+oFsz5FRrFKkxzZ6GCol9foTGtNDFyhNc15E9IAFAN?=
 =?us-ascii?Q?1euII4u64SFy2+JRHW/GVnmLpRgq82CLlrjET/JRTE/I4+kxONqqWWWzv/1W?=
 =?us-ascii?Q?rtdzMf+aNkKlOXDaYRqCHfw6p/vixwJfFRzve//onwTMNfQhPiwf+ATm4iBf?=
 =?us-ascii?Q?nZtR30M2F80epCWVoWHT1KVBwMlGEyqPaAJGALa3OFHcKcPfoCFTH3SIM6aX?=
 =?us-ascii?Q?z2s93hhx7SZdR0c365k=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(61400799027)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 15:21:18.1208
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eab8dad1-e2ac-4894-351e-08de05b529f0
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR19MB5349
X-Proofpoint-ORIG-GUID: KT4QCA6uopuF-Hp5osj24sxIcIWV8fVO
X-Proofpoint-GUID: KT4QCA6uopuF-Hp5osj24sxIcIWV8fVO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA3MDEyMSBTYWx0ZWRfX67M5nNqymxJ0
 g795d77VTjD0imKOQZYLmtOIoWe9IdxUeS6LcRkzV4MWmNgMCooS9drnWVdyCZLGrIuTK0IuXBw
 bbzDcnZiAkpGXQl3bov3Badx237I3Ywi/cF4Z/8knqrAiR7ejJXPUeSqruqdTzLySdIDkAzZVZ5
 c1ybbtj8brRJJRF/dN5LbE+tmQu51H2RLoEv4hjy9fvCzYVEqmWaPhn701BKXRhatM0lVcvPH58
 cl6iTlQDj+mjzFvIcoOvu8KA1f0UVIIfAwmbYaBKe8Q5UgOiNbjZJEQbiPvDfKKN6zIFjAdyL4E
 w9kII9ic6RsXnGOFDMlhWy3in2Fr76RFgMOAIIL+IS/6HHMoDh66up4sftbCHEQZAA/ZbYGDGVd
 gdfffusUf+bWIw6OyB1otc+SZqt7cg==
X-Authority-Analysis: v=2.4 cv=Y7r1cxeN c=1 sm=1 tr=0 ts=68e52ff8 cx=c_pps
 a=G8VycjxW3wO8/D/xgNJDKg==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=RWc_ulEos4gA:10 a=pGLkceISAAAA:8
 a=pdQ65V0D36WqGgu_GI4A:9 a=CjuIK1q_8ugA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Reason: safe

On Tue, Oct 07, 2025 at 10:50:28PM +0800, Brian Sune wrote:
> In previous WM8978 codec driver versions, wm8978_set_dai_clkdiv
> might not have been called for BCLK, leaving the bit clock
> divider unconfigured. This could cause incorrect or unstable audio
> clocks depending on sample rate and word length.
> 
> This patch adds a check in wm8978_hw_params: if the BCLK divider
> has not been set via wm8978_set_dai_clkdiv, it is dynamically
> calculated and configured at runtime.
> 
> This ensures that BCLK is always correctly set, whether the
> machine driver configures it explicitly or not.
> 
> Signed-off-by: Brian Sune <briansune@gmail.com>
> ---
>  sound/soc/codecs/wm8978.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/sound/soc/codecs/wm8978.c b/sound/soc/codecs/wm8978.c
> index 8c45ba6fc4c3..8dfce6ede8cd 100644
> --- a/sound/soc/codecs/wm8978.c
> +++ b/sound/soc/codecs/wm8978.c
> @@ -99,6 +99,7 @@ struct wm8978_priv {
>  	unsigned int f_mclk;
>  	unsigned int f_256fs;
>  	unsigned int f_opclk;
> +	bool bclk_set;
>  	int mclk_idx;
>  	enum wm8978_sysclk_src sysclk;
>  };
> @@ -590,6 +591,7 @@ static int wm8978_set_dai_clkdiv(struct snd_soc_dai *codec_dai,
>  	case WM8978_BCLKDIV:
>  		if (div & ~0x1c)
>  			return -EINVAL;
> +		wm8978->bclk_set = true;
>  		snd_soc_component_update_bits(component, WM8978_CLOCKING, 0x1c, div);
>  		break;
>  	default:
> @@ -717,6 +719,11 @@ static int wm8978_hw_params(struct snd_pcm_substream *substream,
>  			    struct snd_pcm_hw_params *params,
>  			    struct snd_soc_dai *dai)
>  {
> +	unsigned int bclk, bclkdiv = 0, min_diff = UINT_MAX;
> +	unsigned int target_bclk = params_rate(params) * params_width(params) * 2;
> +	/* WM8978 supports divisors */
> +	static const int bclk_divs[] = {1, 2, 4, 8, 16, 32};
> +
>  	struct snd_soc_component *component = dai->component;
>  	struct wm8978_priv *wm8978 = snd_soc_component_get_drvdata(component);
>  	/* Word length mask = 0x60 */
> @@ -820,6 +827,23 @@ static int wm8978_hw_params(struct snd_pcm_substream *substream,
>  	/* MCLK divisor mask = 0xe0 */
>  	snd_soc_component_update_bits(component, WM8978_CLOCKING, 0xe0, best << 5);
>  
> +	if (!wm8978->bclk_set) {

Yeah that looks good.

> +		for (i = 0; i < ARRAY_SIZE(bclk_divs); i++) {
> +			bclk = wm8978->f_256fs / bclk_divs[i];
> +			if (abs(bclk - target_bclk) < min_diff) {
> +				min_diff = abs(bclk - target_bclk);
> +				bclkdiv = i;
> +			}
> +		}

Apologies but just realised there is still one small problem here.
You want to match the closest BCLK that is over your target rate,
if the BCLK is too slow the system won't work. As your bclk_divs
array is sorted I think you can do something like:

	for (i = 0; i < ARRAY_SIZE(bclk_divs); i++) {
		bclk = wm8978->f_256fs / bclk_divs[i];

		if (bclk < target_bclk)
			break;

		bclkdiv = i;
	}

Thanks,
Charles

