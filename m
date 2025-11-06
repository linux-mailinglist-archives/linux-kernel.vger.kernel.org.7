Return-Path: <linux-kernel+bounces-888303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 16143C3A75F
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 12:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7D6274E44E7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 11:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C684F30C60B;
	Thu,  6 Nov 2025 11:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="BjstqxWF";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="jXJkZyvN"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB2F278779;
	Thu,  6 Nov 2025 11:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762427035; cv=fail; b=oEemMe9K7uB6NfiSlmi46hUgpYm4OCF7itVXqz5ZOCfKb2iMUX5bfeD72jzwkADRoHvRbD5PvZ/q9XnqOs45V10nsZtUzW/hjOQsTDeCTy3yHcwPxiZh0ZBtG3HayF5dH7694DTn6C2PFDlFK0NlQL8bPZqvOViszC2KI2r3/Tw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762427035; c=relaxed/simple;
	bh=mj/H+r3UQzevmQ4x/IK19VZRhqiI/PUuUJEuZaFscds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LKsMyyy0TW4//tS//tnM09pNow1FUIG82b8OHuXU8EJgb+MPr2Usu5tTpa3bqF/hE2EZG4EJLH9CBlrdpi4U5F1phogRRMbVKjQc8pu30txrX9+JNCPzL7diPbq8PSDP23OupNnJzMMc9lV0j2PmDEWTNmdfbhU1nUvXJfnWHUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=BjstqxWF; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=jXJkZyvN; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A65vGfA219643;
	Thu, 6 Nov 2025 05:03:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=7/PhMm0OhBbd21SMP8
	NtMTs2pUbfpt8oUgaHE2Q9lvA=; b=BjstqxWF9LmP5P421MAgdlrMQhoUqRX76P
	k+HJWhlzOB9cfJrvT3g39VUj2sbWgNBcxRNG1pAr2r4XtsQajlxOm4sG/fWFl/p3
	iWT/FUWrFYZ13tFghMCIzR2gsjto72a9CeddgRrDDq6iGHJxJkKyMcydoAaCkKCR
	TN5RjVdVMO7l43BlabTHYm2u9UaSMIlRslZwwU2qlXS0tUdZPfONoRbSI8pNs5yS
	PbK5m02GNiX8BIZAAY/9/gGjy6xOVhf00mJwuZ4x0DbKqhF38cEtZYsm+4aUpj+n
	YyQagEjbJf/viNi9CqVmCEz06kUoqSjWFTRKyPPlyU3txSmJqCng==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11022074.outbound.protection.outlook.com [52.101.48.74])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4a7bwx3a37-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 06 Nov 2025 05:03:37 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=okH/t7Gus2G3cnjzLP4zMMQRxNMwLshKXnep0Afnf+i09RpfA/VKtLKS2olRHXvQuyQEwkkGnsExdTzqMTfPqaW/Tf0caMMUNoZaFKWhmi4Vetae9ur1Zwkowta4DKurd1KUE7lIWmpSUhE4rcgh+ei8Px7GNq7iB8B2eKEOzNNCh6dzyRcwjV4VLjv5YEi+j8M1XA+igHj+GpUr4i1dpBXLgLvwaRc09BEXDyI9JZtOq9n7RF8UrPOUIv8DRMl3nPagH7tt7L8gdOnOkR2rQs8dmM9xdutnbh/TzeFm4WJQNcVV+AnHdGuF19R396W7DO8btkaBNoLmqxrK+Sz52Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7/PhMm0OhBbd21SMP8NtMTs2pUbfpt8oUgaHE2Q9lvA=;
 b=gErSA3nK1KlykHOS7gkjyftMqEgyz5/tII64FH0Zd8HkzU+w6XnMGq6/ubhUZQjISYd5ly+5P7S9NFNuuQ5jSrDHlxfRXj3l6fyByY78TWGjmjtvTJEmCAFPqUIojWxmel+nRaty2oOl9p6BdF2qcjTpiEkyQSFYbYd5DQI5ck9WCg/SxRWdj9nCOyVIXmjclpcxA+G38mhEyM1ED64RukHFzAOxPmjGulEmKyf58sic0GkcBX1lEPPYg7povVtS1yCRw9MkCHGm8mZUP3eiiu2BqVV+/63ra1rlO5cexlxX7VWYdpBHvOQ3y1+PgWLDY4NjWuuPZAou1i2Xoxv7xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7/PhMm0OhBbd21SMP8NtMTs2pUbfpt8oUgaHE2Q9lvA=;
 b=jXJkZyvNBuJzR5W4/tItw3pBb2D6HNdNfjjeglgVqBtodZAMsl0XpH+H8RkjOi4MwzLf8kXWVb2x4vvy7zSEo/NcVMsVnemGwrJDQzIdFWlWfgDfTYHUO/r9gOCBJbW8aSOceUM174Dm39TxSRCs4t2kkBbh58hgRUTClkOTAKU=
Received: from BL1PR13CA0213.namprd13.prod.outlook.com (2603:10b6:208:2bf::8)
 by LV3PR19MB8704.namprd19.prod.outlook.com (2603:10b6:408:26f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 11:03:33 +0000
Received: from BL02EPF0002992E.namprd02.prod.outlook.com
 (2603:10b6:208:2bf:cafe::83) by BL1PR13CA0213.outlook.office365.com
 (2603:10b6:208:2bf::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.6 via Frontend Transport; Thu, 6
 Nov 2025 11:03:29 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BL02EPF0002992E.mail.protection.outlook.com (10.167.249.59) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.6
 via Frontend Transport; Thu, 6 Nov 2025 11:03:33 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id F1AD4406543;
	Thu,  6 Nov 2025 11:03:31 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id CED82820257;
	Thu,  6 Nov 2025 11:03:31 +0000 (UTC)
Date: Thu, 6 Nov 2025 11:03:30 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Haotian Zhang <vulab@iscas.ac.cn>
Cc: david.rhodes@cirrus.com, rf@opensource.cirrus.com, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        linux-sound@vger.kernel.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: cs4271: Fix regulator leak on probe failure
Message-ID: <aQyAgjn2+WOwOwLf@opensource.cirrus.com>
References: <20251105062246.1955-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105062246.1955-1-vulab@iscas.ac.cn>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992E:EE_|LV3PR19MB8704:EE_
X-MS-Office365-Filtering-Correlation-Id: 868c26d8-7b36-48ee-89e2-08de1d242072
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iNWLeDvD6qwpzIns4ptpXfryJvbSV8TqylEpDCFV7xsESZtLF4B9jO+MJJD4?=
 =?us-ascii?Q?kym+5DMGieOZRhRQhnlO1G2NqCEvphJS/mCbne87XVop92yvCiMS0k4QsTze?=
 =?us-ascii?Q?ETO2Dsia6bas4c5m8Et6YJgPmXYXR98+ZY3rHL0F6I42zcaf6+iHk/GTO0/X?=
 =?us-ascii?Q?NTVfw7etsjidhEOwyImbV7WK9MAzShcPLzwf/HOytI0/DxC/Ot3B+K0K8c/D?=
 =?us-ascii?Q?3hsKYVvP16be582lpn3KzN8Aj9+8apvnJf9AUdlvZoWmwXuWLSIto1uQncyS?=
 =?us-ascii?Q?/qZIH5qV4H2XSdo+jH7IEExqacGhoKuYiIArDwB4DzLbLsfWbvx/tyvuqAJ+?=
 =?us-ascii?Q?KNO8ULgri8jTfzRhu8tGKjCRIAOgDAUXdP5k2kW47KkhGsce53BIlJZ1hDV9?=
 =?us-ascii?Q?WY493f4IOwuw5lH+i80IygYKh/p+MjHJBJmUtIDoVs60oMls2/1Fxvj++gS6?=
 =?us-ascii?Q?2+udjTXI3tJwekoReZuJyhzLNYYvSZv2vrm+wKJttgKZnrNjZ3f8dnPG1KAF?=
 =?us-ascii?Q?JppRC73DhJ36uY1tv4e8+m72SqlZ6matWGrEdsOkqj2LeAiP+It6RnXoG3qY?=
 =?us-ascii?Q?lR29wzynrB/RggQKa6wZgsvDvMh6WCZp76Pr30BMqfoBlrkjLVR1Jyl6jWeC?=
 =?us-ascii?Q?jMAQavKMvAe3CsX2SezKsMZayN21EtEgW+6U6+BV8jZicbyWZn6uA6TfhuSg?=
 =?us-ascii?Q?xO4DM2jB7OgcqFhiLSRrdXLkWhaRpMk3iKEH0eCo1zsEBCmKMPsLhW9xr75Q?=
 =?us-ascii?Q?YAwEDER+cB6E7j758eV/VZo+ey/Hp2w6h/9fVvtTwtRS7nSFBpBRsu2TSlQA?=
 =?us-ascii?Q?F4gstBsLIrJFHxaGKakpY3XFBBieCgAI15+oYrL8tc5ygpq0x1nZua7qp27t?=
 =?us-ascii?Q?ZkBDuWkg87UX7VlQcQacI7DGlKvRONgWFEpEX81bBnkgGlCf/P2flSu3+tJc?=
 =?us-ascii?Q?VMt+l2FjQdFUdmPLK4CAmwY8uVwzzmsffy5OQj59xLGqFjmdcc0VPsbxvH8l?=
 =?us-ascii?Q?lHi59zR4qn3EvebIS5K2pQRYTLYRLiHtZiSLv0GJDcyjjBiJF01i21M8MK1F?=
 =?us-ascii?Q?+YeomvkL3kralkL+hxU/sfHNEIrLvHe08PLdbgqXCcouoJUS5MGtPHlKIrKd?=
 =?us-ascii?Q?aZddMLqrDEaY5tRNEn81qQ5Jjej3jdohZFWoOZkZlnX3Ty/1OQrMRqwmk3yS?=
 =?us-ascii?Q?Ao33u8AxaWuV9DF1qwCYPhBQERoIIN3MdN/w77PZxSXfIWenxm9asidfwyA0?=
 =?us-ascii?Q?tRbin+tzwN7QnBrjC0SXD4y/QxQIJa6ZSD/lwKGXoYOidnKwQheE0JdmCrHj?=
 =?us-ascii?Q?pTpmo0BRSDpPOo7asolqUp0DnlWz9khUYFp/iQy28tMVrHqnXEytP2h3MYe1?=
 =?us-ascii?Q?Rs4lvHJQt0wmMCE3+d1oPSrp5QNo3ZQvijry5CMACSoXilegVVJXwrTL4eAj?=
 =?us-ascii?Q?kH6ebKahchlU8QCTohjMR/+GEKIV0CQ3P+d4DqXB7pCE8CsdK+OR+dDzN1S7?=
 =?us-ascii?Q?5JuhVLERAw91exxlCoW+DEZe2ombafZS2vg4to6jxTYvgRuxRSwLmPFz3i0K?=
 =?us-ascii?Q?R7tCOLOq/zE337b2mQc=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 11:03:33.1489
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 868c26d8-7b36-48ee-89e2-08de1d242072
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BL02EPF0002992E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR19MB8704
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDA4NyBTYWx0ZWRfX4ouFIwgWqj4S
 i/aETPt9tCjX05NEuoMNOeR0u31IulfxC+VL7fQt5NzkUSPwndcZO0r6bY+tF7VKUyRxyshWP6M
 mrewIxbl1fsYQDcOEXF2UoaiDMAKiJOxSwmLDvx2u9clehKpdhkC6smR3svwY5/uhpSnFuWtgX8
 /Io1GcFuDLemd7G6ln5dlflNRdIKMlzFWbtsyclcUcg/i42a+dl6nT4ajqVOrhVn2IOj7d1t4Hu
 +ReA89NdYo8YAU4HiuL7+O09WM+lNnwOq3hEZS3yaOV/ADNaoCqnlxsv2MKMOE7XlxfEHBoEt7N
 fK1zqMC5mzSQQo9z6/za+6USvXOinAe+YXPGXVpi6MWCR1q2TiDhcwKRAlK64fnvBhSkXDn3SEx
 7Tnx74PwdxjmuX1jrgp4CgWlJABWMA==
X-Proofpoint-ORIG-GUID: hg6yslFQgc1Gr1h9ota14Kz5S474dN17
X-Proofpoint-GUID: hg6yslFQgc1Gr1h9ota14Kz5S474dN17
X-Authority-Analysis: v=2.4 cv=FpcIPmrq c=1 sm=1 tr=0 ts=690c8089 cx=c_pps
 a=HCvUzjoPJca0/5O0yIdMFA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=j9h2Lbvu1IvFkVh_mDkA:9
 a=CjuIK1q_8ugA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Reason: safe

On Wed, Nov 05, 2025 at 02:22:46PM +0800, Haotian Zhang wrote:
> The probe function enables regulators at the beginning
> but fails to disable them in its error handling path.
> If any operation after enabling the regulators fails,
> the probe will exit with an error, leaving the regulators
> permanently enabled, which could lead to a resource leak.
> 
> Add a proper error handling path to call regulator_bulk_disable()
> before returning an error.
> 
> Fixes: 9a397f473657 ("ASoC: cs4271: add regulator consumer support")
> Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles

