Return-Path: <linux-kernel+bounces-879997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3512EC249AC
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D28018985F6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC72E341677;
	Fri, 31 Oct 2025 10:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="ord4Gzof";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="mltF0bAK"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4303D34164A
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761907759; cv=fail; b=TFhqk0IZ5pvf0X6dBbcLtRmVyVqGG0XCSXSpSv25e5qes+89mWuG6paYZV7JSMyU1ttLhNvG98lY9rda6KYTkU2c6qZX9Ea14RK5pJhU8aI56X6oJqQ23sLOG6gQp2vH9zbGp6b72a+6+OmP2KoIPpR2aMHpbgS2cEmzfPUXRN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761907759; c=relaxed/simple;
	bh=wqCfbwnCDZ43TOLeBxlGATJJAZbWtlZpFSmgPCU2gsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z9BHPaLIwSubXm8rSrYxk3mxuWMPxXIrrz1m1inokEUTKs0It+Xi5jCnC2e0pT7OsOkWpD+jbOhKNlUIaayKcxiqmIExRuHQlsnUElRSm5T58YEMgzbTVQuWOWm0NfgKcEmhSx4lhkazOwMmbhQi1Ux/+dp8UPJ+pcRZLNN8pLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=ord4Gzof; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=mltF0bAK; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59UNkhMH1662697;
	Fri, 31 Oct 2025 05:49:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=xTjdryj1eSBJaez0Lx
	Ru3sBxZKkXlGf3lYBHaoZyLaI=; b=ord4GzofD/W/bwJrJA0dTGaFInjL2QPQ0y
	vFsItEJJXb6fVYEL3lRnEjLQaPkKTYLB8ASNl0TWHe21tiusDwQCX8C9tJWoreFW
	FvILaGJ0CaDMpqRkNdmjDXGSX+LrCeZG21EhzSkH8cZx3w5hm+9gJde5EKK2PHTA
	hsvZI8ZXPf9G8WPORe5Ja4/0jkyk5hTILP0XWYZzHHWM9QrMMvgOr1NmxHhIKcSs
	e801JxT7pELn+vHAsJIvcRvFaAv7GRxTIOJRa2UYacNA0y6n9leYtkVyUMF4w2yo
	mwGptXmxPZaEm/MqGCicrV7P3s6JOKIJPl82nx2ca8jXmfXc90jg==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11023112.outbound.protection.outlook.com [40.93.196.112])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4a497vh8g2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 31 Oct 2025 05:49:09 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ydFyvu6WzXBSPVhF1FIjyhLWxgRXhdBUqRkCuKu+STnRGjslcwcpPVt5k6YWgiqtCE/9ikD56TOs0XEgv3P7vNhFa1tmXDW/hQrHSw08uyUsNGL9qR1UbWa9oY/97VsHP/BbFB5epKucC06zdpfudZU/XEmeEXlSjOFbZf7bH1jBDbdbyPMVAl94QyY7eo7S4FvtF3e6LpMrSbWsGGUFFxuFUQY/hXqAGpLxhQcxrtC+ojRrAlerfmsD5ghO2p1csOohDrxkWOiJBEDiiqnmLCPoYYJVScHV8VH19zgDXtofHCWPbEbLKfwmfo4UNSRuXRuHAsy3otuIrj6X3O9Fbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xTjdryj1eSBJaez0LxRu3sBxZKkXlGf3lYBHaoZyLaI=;
 b=WimPNYHxq/AnshUy+eCWk/wspunqJjDSL7yxoyA4Q4O2YzoMSgg//J5RoPW/eFqo53sAhoGXwjmV8AN7v9V7DmonVl8mr1GhE5LGa2Q7ar/pTG433R1MnAeQh72TMter+D+MjDym/Qn85lAqZOx+TLoo1pf02UfwZo4LthXmnaHaQU9r03wQjc1CTIqAYw0cY77+vnJZbJILDCXAePEafHtmlcCPz2BUAU8L5RH4o8B7CGU6+m/5Le41PXJ4ADAi9qHVjx3jZsgtRDQ2wowbWu9r1yqckXehy5j/4riMkBQNTzewoHtAiKjHpEtd5EH4okq1jIOyK6UnRy4+FEkDLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xTjdryj1eSBJaez0LxRu3sBxZKkXlGf3lYBHaoZyLaI=;
 b=mltF0bAKL8R06sXMvApaH1JIpIg1Yk4XzBSlC4TYbc3j2tf3ubXATHHXhQ2FxMoZIdFZa6RLRHpUqneXzgk4PVSKAQr332Ol9ogHR2c97iUwgp2X3cjjZ2WbVaubUlgtXAkgViNJbU64JcRltH4eLVeJmQ1okwC9OeeZhkn+pcI=
Received: from SA9PR13CA0135.namprd13.prod.outlook.com (2603:10b6:806:27::20)
 by BL1PR19MB5961.namprd19.prod.outlook.com (2603:10b6:208:399::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 10:49:05 +0000
Received: from SN1PEPF0002BA4F.namprd03.prod.outlook.com
 (2603:10b6:806:27:cafe::b3) by SA9PR13CA0135.outlook.office365.com
 (2603:10b6:806:27::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Fri,
 31 Oct 2025 10:49:05 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SN1PEPF0002BA4F.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.10
 via Frontend Transport; Fri, 31 Oct 2025 10:49:04 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 24710406541;
	Fri, 31 Oct 2025 10:49:03 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 94967820257;
	Fri, 31 Oct 2025 10:49:01 +0000 (UTC)
Date: Fri, 31 Oct 2025 10:49:00 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Sander Vanheule <sander@svanheule.net>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH v3 2/5] regcache: rbtree: Split ->populate() from ->init()
Message-ID: <aQSUHOdWmtK47UMb@opensource.cirrus.com>
References: <20251031080540.3970776-1-andriy.shevchenko@linux.intel.com>
 <20251031080540.3970776-3-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031080540.3970776-3-andriy.shevchenko@linux.intel.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4F:EE_|BL1PR19MB5961:EE_
X-MS-Office365-Filtering-Correlation-Id: d8fc7b43-ff9f-4552-6b55-08de186b1c7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|61400799027;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uzIPIV37RY3aEWTjXqbBOlK+WIxsk+MdwdNIyXbWUgXzRex/ay87H+RZ9qcj?=
 =?us-ascii?Q?/7rbcEgS8Wdf4i5eRuxNCRIe/rLExlXyBcrr+kgg/6ATd1kHXAsbUJlG5z7K?=
 =?us-ascii?Q?N2fw+2g4O9wN/8KSdEGy+sI8CCeBDJdHvG+3tcQeJCsZtaN3Bu104cywwveS?=
 =?us-ascii?Q?IzdYFycR/dTXCLLf/nFXY5iIJKsi92XTHLbvssp1lF9oxk+NLK//S5bf1Tzr?=
 =?us-ascii?Q?Z3Q/+7qP3jJ20HFTWopNFLLRmzyGMmOF98SK8X5lkFiXSzepBZDCGoTwdca8?=
 =?us-ascii?Q?cfqHiIXhF8aITbpX4bO544+cz92etfR8IzMGx9CIrqgTHjF4j7bhSy5dc4Qo?=
 =?us-ascii?Q?yTQPoTHKK1KYhqt+1MxarCvPmmdlI/GTEOLdXTvcwbyNgRfBAO4gXO99fFYO?=
 =?us-ascii?Q?LLa3e2wbXjzupNdXfcQLdd6VHq4b//g5MBFT9lKbMn+AOvxfKDcygLXtjmkF?=
 =?us-ascii?Q?mzr+PYMIB6HE1xdOl+3Ea3RIq2BXVAaKi0g5IY8Dlh3KRjWE9cUS1oX2NNsl?=
 =?us-ascii?Q?XDtmS2PywGqva/WdEteZBLpBcjWlcV4MlMpsy5+RXvBlqoHLTMqw58W3MNj7?=
 =?us-ascii?Q?oLiYmW03tRoUE3IATg9S61zIwhCD677OqP+3WK9gex45tV3f/+ySee1unKHU?=
 =?us-ascii?Q?6pzF3KY0CEE9Y0I0RB2YyFYJLuIaBfHnXZakWL6sQnpWx+7Qsva8JMfaicbW?=
 =?us-ascii?Q?W7iMCv3yul6HS/Uw2yq2u0xXnlN7Vl3HUSJY0sgLWBUCrKwnMSKpN3Z1MDXF?=
 =?us-ascii?Q?+iet7uWQdHFrctAYaKEaXwO6jdPlLLF5ndkUqLQnANOd+oz6CdO4J9jV8kN2?=
 =?us-ascii?Q?kKFc1R+6htlFJaFye6Gr/C5+5/XTDqDaSkwkTfxuET5s1B2F3llUTYt2iCvJ?=
 =?us-ascii?Q?OECaSsvM3k7VrKVpvxGEK13AoOMO/TEAkT07DKb05scW8BdRpFLF4AoHbPJi?=
 =?us-ascii?Q?hIATLnJpe/HVP/aV/xn3e7N8Xue+W8b9TqZbK6VwbpIbY3w8/EKA96+zU3x+?=
 =?us-ascii?Q?27SB1ptll9sVLxrocL5FT87B8PGS9po7zV8k7YZ3njNDQiWtZam6rHbv0l2E?=
 =?us-ascii?Q?wFOnAZarH4yhQwYLRqkAFsyeiOb4s9ANer40BqK+ij6BxraJVv/2oiYc2SI8?=
 =?us-ascii?Q?Icebc4yoAhHOLdGCwDPvEGL0n2orINY8sp5Futql5DA16iPFGUJWKM5EzFD2?=
 =?us-ascii?Q?QSxXASeTsJrvSLBZh9YeeW6h0yCTnUoXQ974escOHBNCPh5IJXgpsUUqQKXI?=
 =?us-ascii?Q?XEyek68/uMVwhWR2gY+CkVk7IblpYYOU/NHe2TANyz+SPiTAHOEWJ/goyJIZ?=
 =?us-ascii?Q?JG9Ku60FwTqj2ZndDqqNirBZpE5bWwSW/ZrB9+VIVVNuZZoHBktxUimXtBib?=
 =?us-ascii?Q?ua0x/w/p5reqplAr0VtQSlkduCzZlxvjohhs65FuxEDeuzxxZiyp4mbQGAG+?=
 =?us-ascii?Q?K0r81QAT3RRKhrt8t3/muc/0UA8MyzpnEnyML2JUadCNYnlHsLMXnifDmjih?=
 =?us-ascii?Q?sI3O8xoppub4589QHrOCWp9L1U+FfSuasLYFZp6n0b0ExSb/Hrl1vWw0Vxqd?=
 =?us-ascii?Q?Ig6aULr7wyjWPewBqkM=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(61400799027);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 10:49:04.8836
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8fc7b43-ff9f-4552-6b55-08de186b1c7b
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SN1PEPF0002BA4F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR19MB5961
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDA5OCBTYWx0ZWRfX4rsGlVWVu8TW
 WtZFmgGiFf9/JOFyCK2RNVhOJQepzrqvz5gHWEY+o7adRdA0RtvvrmXQSOTaK3HpZKENjY3Svsr
 YXqMwyN2P0G8QToaAqWuog10j2XiTaYlOwq2XO+TkDqeZaw751xS/E7sA8pjobDoSUQqCFItKjN
 mrVfQYbXLRMK4MSwwPFqtAZjyyMahYWQ+iHisgwujiWim9XUWFOl3xCGdSFpuQisZrP5WrIrRsL
 4n5T1as8RB6mNw5QSaGbOruwCFPkaHaWJD2hExezPX0TrPMEgj96R/kXFOUYN8KBRYvz0ampIaD
 lCbHvAA2j/qVfpqXh0h+EWtmHBXyG0XbWn2+DTep4MqFi3taPfxFvw73wZCv/kroDnynncBrHQk
 t0HKb1PcBuEtKRC1T/O0YwnE8SM/eg==
X-Authority-Analysis: v=2.4 cv=Jtr8bc4C c=1 sm=1 tr=0 ts=69049425 cx=c_pps
 a=dWZueVx2hxoXd+HKFvf0WQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=QyXUC8HyAAAA:8 a=w1d2syhTAAAA:8
 a=y0tFvjTcr97v7v2fSIQA:9 a=CjuIK1q_8ugA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: v33LxIGZsnnMheUUYOvWlRZKN1GHxaCh
X-Proofpoint-ORIG-GUID: v33LxIGZsnnMheUUYOvWlRZKN1GHxaCh
X-Proofpoint-Spam-Reason: safe

On Fri, Oct 31, 2025 at 09:03:17AM +0100, Andy Shevchenko wrote:
> Split ->populate() implementation from ->init() code.
> This decoupling will help for the further changes.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles

