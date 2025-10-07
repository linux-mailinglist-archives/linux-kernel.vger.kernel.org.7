Return-Path: <linux-kernel+bounces-844108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 51FD4BC104A
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 12:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 102974F45C6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 10:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF0C2248A8;
	Tue,  7 Oct 2025 10:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="h/zjztJg";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="QJumhsIQ"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382F134BA20;
	Tue,  7 Oct 2025 10:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759833046; cv=fail; b=Y9wf7wj+HJxxXdmxL8dE+rJDXDTvb4a0mNpxgkkbJdR0by767+9xDOJR1AlnwpbzazO3/PYuGcL8CZhlkXSjEFkOZ9I/BmjpTQb9p8U2WwttSbZXi6SBvmay3OSBIq3Hcj7D7aQdagPa08iWBzBfEpIVFEh7AsmdGluRSFMGIug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759833046; c=relaxed/simple;
	bh=gDpZzDSNYYeshmdmq37iMwtA4ZSpZrrHuKX/EfZUUFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZfLgcUinTmi+zJcZQF4qYlMD+5SB4WcXkCiazMIeZasVMwIWsNwhCDN0meOmHq8TSuV/F7ULG5FIdA+UVrVDLHub8+xXcVh8TAyKbK5I7WvKLshJvur5ksGTZSfzS+taJ2o/bS97SAbo5t7tyI2of9bh1NKTb1YLTi9YSUzsg1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=h/zjztJg; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=QJumhsIQ; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5976jNxF1871314;
	Tue, 7 Oct 2025 05:30:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=cjWWOAUs/juNBKJMec
	Xj28LgkbOVd6ozOlSI2ySKaLs=; b=h/zjztJg61A3a7bnewveny1QefoXPd5okS
	r3It/VWpVisuV8m1AVj9sLLcgtEasQPn+KAASzCJ2zxdaNb+vFXbeo1VDcTZqqIG
	oK5Nraek1FInewkKYUY83zIE/+m3X2JXyL0BFHNP/zrhM0hVdDZlDnagvH3qBRPh
	bx8pkWS3BjeaF/+7fcAdeDNgSSYx4ywT1EqgwciKxPIQxUfyJjuJErGhYK14ZEHd
	EEbz2kn1MolVfmDPock2xlbU0169UIP/yFe4yP3TiyiVooWs5CnlQCa0YkNKatti
	ftxtNelOUOtsDKoJCUSF0dqsTlc9qxDgwH7BnCpwhWHACKhIRulg==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11020081.outbound.protection.outlook.com [52.101.46.81])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 49k00ejtq2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 07 Oct 2025 05:30:23 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DOs4RJ4MJvMrYUAzkStyWrOB2xNQC4XHglKRa+NjmR6JW3qEP0a3f9lOoMOg0hXqHP3185DMH3l8WXk1Cyx4+nAFwGMtMYzPg767qLwDnNEbS7gFSmXzqWjLg7wnAb2iNTPlcpRfhFdXA0MsajbOo543pQxb7PCuowLt5Sn32g8QJPrBGVf3Dw0zCHaNv0PgKvbtu1uTGxasi1nsbxiP5Ek/tLDTnzq4dOgMXPd4GIPdX55eubsprgTztHbG/go5YUnu+HUf9pWi8cYKsaP9abnqS64jwPruH77koc9w1HeWtEIcnJtFB3YxrUReUMswkd6LG4+b+FQj1e9RoA1yMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cjWWOAUs/juNBKJMecXj28LgkbOVd6ozOlSI2ySKaLs=;
 b=eE6LkyjF4XNx+CNds/L0JgHuyHukMHQNhrz6qEvWy0Dd4/VavpupYhpKrDKAdm5fjYa/HAlTS0QccSo+0T4wP81cdnVq0/jxyUxihz55gO7O/N1OPfNQRQ9dcAuKgXhZ4KKmodl3Usgk5N3xuVTh8UvkC2t1YYNg8ATNP2vlKIAItuCNbGGqzpiEnr4SLWa+5fwm+PyBwfRBm3PEJffGiXrsAUuFT/9yu+rY02zUjAkFbPpP/z1Fok++3uWIi1WnJ3YT3SvyjRGWlYWbAedrOS13jwfIUPAl8g8nwRY92X8b2vtqhkeZv9JdvgwNleAxlBZrhLF+UCzhVyhKaPIQcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=gmail.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cjWWOAUs/juNBKJMecXj28LgkbOVd6ozOlSI2ySKaLs=;
 b=QJumhsIQilkNZR/9yaS3iP9E6EA2NbsOKm/NSECAp+F1eSimfWbsROgH0Y7PRJxzA8qkta9fRBdOiaTIi2949LcO93CTrpTm3NBprLss0qQWXEnLyq/lbHBWmo9ksFXdI1c1sYRhCq6o2LI7l6u+2+v1xpOHIz49TptEYVx/jOw=
Received: from BN0PR04CA0131.namprd04.prod.outlook.com (2603:10b6:408:ed::16)
 by DS3PR19MB9606.namprd19.prod.outlook.com (2603:10b6:8:2e0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 10:30:13 +0000
Received: from BN3PEPF0000B071.namprd04.prod.outlook.com
 (2603:10b6:408:ed:cafe::9d) by BN0PR04CA0131.outlook.office365.com
 (2603:10b6:408:ed::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Tue,
 7 Oct 2025 10:30:13 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BN3PEPF0000B071.mail.protection.outlook.com (10.167.243.116) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9
 via Frontend Transport; Tue, 7 Oct 2025 10:30:11 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 861C0406540;
	Tue,  7 Oct 2025 10:30:10 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 72308820249;
	Tue,  7 Oct 2025 10:30:10 +0000 (UTC)
Date: Tue, 7 Oct 2025 11:30:09 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Brian Sune <briansune@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sound/soc/codecs/wm8978: add missing BCLK divider setup
Message-ID: <aOTrsYllMst3oR03@opensource.cirrus.com>
References: <20251003091304.3686-1-briansune@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003091304.3686-1-briansune@gmail.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B071:EE_|DS3PR19MB9606:EE_
X-MS-Office365-Filtering-Correlation-Id: f57aebbb-3185-4f9b-33a0-08de058c7ef6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|61400799027|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8ncw0BSlw86or7FVVRSURzbityxwXW8LhmUeYKkYoAPnqnYBRQLLACfPY81F?=
 =?us-ascii?Q?VS63V0CizQwMtdYD99B2pBGPJ0BNDDNyCJBLtPyQr8aIS7Ck4NgytDS5zI7V?=
 =?us-ascii?Q?V1L82hgUwfUcV6GE59sRuqOcbEH5ADGRP+VoXAOfgoK68NkDrYEy4c4soGDk?=
 =?us-ascii?Q?snARwBKUBLMvJffVJnMNtIn9lYM8+AiwbbN8hySH0+ybsLyQHO6XL6FheMfM?=
 =?us-ascii?Q?6BagSysVqzJT72J53EJEXQHxFZnDJh7z+NhNtRQlDSZnqq9mim9pMaq8VYAT?=
 =?us-ascii?Q?6g/ULj5mHBBM4IYtLDAKrSUBsOH8beVPT18a8nCKBUGic0gNcOlLBUzVLPMH?=
 =?us-ascii?Q?eeW4Oek/GNCkLLn4X4i6RcvXO8PvmNDdHT5YgEdvY6PVkXD7r3DPjKCPpitR?=
 =?us-ascii?Q?weGSdUVEHsfUsutdKpOdVu4+J9OLXigaeGTxn/dysjJwu6h7zL9FHYgXSFPG?=
 =?us-ascii?Q?HcoyyMTU2vHdFOeBZxrgMJDCjIxprwUNNmJfgLX0Ns93HqVXQ7D78rG8Wh7W?=
 =?us-ascii?Q?hNSJXxspepKjMnarEEjT8gEgYeP3EMxsGW4eMjqPoSLdAJ3bEaZPq4ehNVBJ?=
 =?us-ascii?Q?RdVrZiq12y6s9yoPrk8YX7LwP8qz2dHm7JE9NuVt3NZP90Ey3iuCfuGefwGZ?=
 =?us-ascii?Q?KVKyM89LdvIAk+/6Zj94uCBYXhQPc99PtmGbJVRYbskZEZVyqo4ndx/eS6VS?=
 =?us-ascii?Q?s8DGa3zPO6ojwrgIo0Z1wOG5OqCWImwsx55ZWPD5pXPNMPKLd0gGr67PkcHd?=
 =?us-ascii?Q?ptmO+rDgx4amh+lq0KEp142JsNU2hTW3S+nxVLGK9GWebEu+jlRWOlPjc521?=
 =?us-ascii?Q?QBOKjzIm180m7fK990MT3yD5m4vcG3gNC2rLZl86pIAtEd225CEIJV+VoWUC?=
 =?us-ascii?Q?hZg8UeSzOmSWF2KoOpeI9ihLy7uxuwEt8mxHz3UlmmVS2XBDTdZUvhB1+5Is?=
 =?us-ascii?Q?LpEIdeuTG/Pz2E1s9SdMyR1yTgy1WXVbBp4xIrtUqZDFoPKGG3aHhUvjTnOC?=
 =?us-ascii?Q?jPbjYAgpV/ySsySBQDipJL/C+KKi3oNBG0IpRVwK3IFVfsbuSCZR7iZk0ZEo?=
 =?us-ascii?Q?6Uv8D3ju8nGuhbxBFHlFsCLEw8r2RKku44eUsZBIb9ZmjN/hQODlvRiJaHCz?=
 =?us-ascii?Q?TJU+eYGyhxM6YYtPhQarGi64Ajocg3ph7kjHEcmFePBsr/m5sW23iD9soHXK?=
 =?us-ascii?Q?usZFFSebxvJITUQ0vT1KERWhSDWpUU1lKZz4wBqGnx2IMJRq/7Fxk9eX1h3a?=
 =?us-ascii?Q?1AWDPjC+BwuOerf15L5rn63LBM8tvQKhMyNeibJkWSNpKedWhww77SMom5js?=
 =?us-ascii?Q?toTdieSlPMCOiIJHMFm7uSgpvXGWdpHXOC+TYVMFAtIsLenQm6M8V5bp4gbH?=
 =?us-ascii?Q?4tDqyG4Oo2fjiRDQsireE5CK0P9zZVb2FO8yI6E8/uNKa9I+H/yTGBb0En53?=
 =?us-ascii?Q?PakOjalKrvuIqij1AZf+EFqAO74NzZPCYAESWwz4XrvwVW8TvVqNA3l8tZuT?=
 =?us-ascii?Q?Nm6xWaoHZPzT4wuGOH4Y/+CyNTP7yYxPIYYi+tHsglT38743Xec8mT2PRSiG?=
 =?us-ascii?Q?Yn1cux/un8aYsXQJdbg=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(61400799027)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 10:30:11.4679
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f57aebbb-3185-4f9b-33a0-08de058c7ef6
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN3PEPF0000B071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR19MB9606
X-Proofpoint-ORIG-GUID: 9Q1_pkKdBLeEN02tHl6k7q70YzAmdZoR
X-Proofpoint-GUID: 9Q1_pkKdBLeEN02tHl6k7q70YzAmdZoR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA3MDA4NCBTYWx0ZWRfX8ugjeRNvz1Ki
 W8aAW5LPFtGqWGWBLozy5XfLd3lG1FYvp9YFLtlnU4heVRrnJ+4ySj7Gk8NpPb6oTq4H/E+AaUa
 71ow66JZr5qENrc/Dy2mx9kobmD9dqIPx2rw+kCZjIUoDSwLs2kReY5jNZugYWLi5YSgnJR/dA9
 gkWb6stzVN8WvPXX7aPMSAXhr9Yku7zjhpn5YFlbo0dRtX3zt86BrjO8VCDfN7XGPc7sd9qBLMu
 G5w/IID120OQhHqHibLoiNPT1Gn3DhNMK3ktPJpSE3Q0+GXhd5b9T+NoDy/MDOu9bpa8YgjEpM1
 MPbFoRkgliQclPO2LOsfaEa/VvS6T3XGQhRnLv+Df8zFmWntAmaIGUDDxD1JkN4g+1J7OUDqCzh
 uMQwpX5iPZZQhyTvLAzYgsOCYZ7QVg==
X-Authority-Analysis: v=2.4 cv=Y7r1cxeN c=1 sm=1 tr=0 ts=68e4ebbf cx=c_pps
 a=Sq8Pev+jtt5PqluhJgCvtQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=RWc_ulEos4gA:10 a=pGLkceISAAAA:8
 a=DlnTYHBiCWOZy6rnKKsA:9 a=CjuIK1q_8ugA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Reason: safe

On Fri, Oct 03, 2025 at 05:13:04PM +0800, Brian Sune wrote:

Patch title should be tweaked to match the other patches to this
driver:

ASoC: wm8978: ...

> The original WM8978 codec driver did not set the BCLK (bit clock)
> divider, which can cause audio clocks to be incorrect or unstable
> depending on the sample rate and word length.

This isn't totally accurate, the driver expects it will be set
through the set_clkdiv callback. Which one could probably argue
is a bit of a more legacy approach, but probably worth calling
that out here.

> This patch adds proper calculation and configuration of the BCLK
> divider based on the sample rate and word width, ensuring the
> codec generates the correct bit clock for all supported rates.
> 
> Signed-off-by: Brian Sune <briansune@gmail.com>
> ---
>  sound/soc/codecs/wm8978.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/sound/soc/codecs/wm8978.c b/sound/soc/codecs/wm8978.c
> index 8c45ba6fc4c3..2109c84f33df 100644
> --- a/sound/soc/codecs/wm8978.c
> +++ b/sound/soc/codecs/wm8978.c
> @@ -717,6 +717,11 @@ static int wm8978_hw_params(struct snd_pcm_substream *substream,
>  			    struct snd_pcm_hw_params *params,
>  			    struct snd_soc_dai *dai)
>  {
> +	unsigned int bclk, bclkdiv = 0, min_diff = UINT_MAX;
> +	unsigned int target_bclk = params_rate(params) * params_width(params) * 2;

Probably better to use snd_soc_params_to_bclk or similar helper.

> +	/* WM8978 supports divisors */
> +	static const int bclk_divs[] = {1, 2, 4, 8, 16, 32};
> +
>  	struct snd_soc_component *component = dai->component;
>  	struct wm8978_priv *wm8978 = snd_soc_component_get_drvdata(component);
>  	/* Word length mask = 0x60 */
> @@ -820,6 +825,21 @@ static int wm8978_hw_params(struct snd_pcm_substream *substream,
>  	/* MCLK divisor mask = 0xe0 */
>  	snd_soc_component_update_bits(component, WM8978_CLOCKING, 0xe0, best << 5);
>  
> +	for (i = 0; i < ARRAY_SIZE(bclk_divs); i++) {
> +		bclk = wm8978->f_256fs / bclk_divs[i];
> +		if (abs(bclk - target_bclk) < min_diff) {
> +			min_diff = abs(bclk - target_bclk);
> +			bclkdiv = i;
> +		}
> +	}
> +
> +	dev_dbg(component->dev, "%s: fs=%u width=%u -> target BCLK=%u, using div #%u\n",
> +		__func__, params_rate(params), params_width(params), target_bclk,
> +		bclk_divs[bclkdiv]);
> +
> +	/* BCLKDIV divisor mask = 0x1c */
> +	snd_soc_component_update_bits(component, WM8978_CLOCKING, 0x1c, bclkdiv << 2);

We should probably add something to handle the interaction with
set_clkdiv and skip this if a fixed divider has been set. Well
either that or remove the set_clkdiv option, although that is a
little braver.

Thanks,
Charles

