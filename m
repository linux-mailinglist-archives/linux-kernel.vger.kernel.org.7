Return-Path: <linux-kernel+bounces-880004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D676C249E8
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 932BB3508DC
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA6E341644;
	Fri, 31 Oct 2025 10:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="jSjmTgCe";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="juk56J0o"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8015C2874E9
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761907913; cv=fail; b=r2hNW07Thz23GGlDVE4QYHjoNYvpHZ1xwUlUVEqFZfj0Mef5EyKmv6JBSeMpJns6StlbfcTh/DmvNqi1ijfS1VuzPA113L/EsT0Y0r2O7GXnSHWwAfdjCdkKKWl0q2HkEm2BnS+lpXPjV3v5U/JPsar2fduTaUuu6aj9neOFyfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761907913; c=relaxed/simple;
	bh=jUW7KHZrh3mN/vqnAyNeIUFyeFuAjc1bWgLXiY3KXCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P2rpmbNED623DYqczv8R1XmS1asLX07eEpalIPFI9dCQE5saL6dZmuY+iQuqJ2P8+hM8XdEWcyya99TrAWvVFn+bs66Aw82ZDi6cH9qcId0OM7tOS53497oY298oE0G1PTkjrwaCVjgwRckPi9cc/bf95vuoiCBo0Py+uROfzL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=jSjmTgCe; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=juk56J0o; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59V8TItJ661612;
	Fri, 31 Oct 2025 05:51:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=FHgNE2XalRpB7kHSMP
	BezFer03FEez3jKqYvEybgpio=; b=jSjmTgCebHlm3xCrwt8w/DtPLrtsELWECe
	+/+l0f7oxEpb7Lu5Tu2apoxbkhcGCC4dzAgK0jVvFVwuvRJiJS83W16b0wA3tywz
	fmI2P6EvfePNHCPUROBoaUAYci4/pELb8S0mbUyJhjPXdzt+6TP5EUbeWM0wOQCj
	veV1zLbFjHYh8TSvf+oDirBXLN8CtBoiPfnNOaGxMs2p5VGdWswTAr8o/kQmO1Ji
	Q8MvZNn2ynprF5FpJkcYpbQ/k027SykR4Lq8sQbTOoGp7KOxveJq/5nzNHS4mCCd
	wY1yNkUQWH7U4sRzEWdD7Jkxjr9kzEXkvtU8iRa2sy+3tda58jdw==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11020123.outbound.protection.outlook.com [40.93.198.123])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4a497vh8j9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 31 Oct 2025 05:51:44 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d8zx2J1UCnLzqAoetYm6gepndfhOrNIcVVoMVTEzqV4V6zpjMTB8E7r8lmhPr6wDvhSdsFvpeKADufKFrnwB2G7T7acBsMI73+DomdFwPJDW1ZahpO7hbYHMvQWvC3Vo/THWGWMrq6WLMQZvM2dQisiTb2NDl4p8J2hq2yJe8BLGCRaS56VtXyl++rgdopSMbsglEoE6bkaT0nIPjp/tEBZHpbUs9gzDunqX7SJ2brf6c8VOwwj78KGmXNg/dxYdZacFCZflI47/ul5aY6nnkn0184gIiMg28loL3FKOsm0einByuheTHHTRJB9kVrfZotyaEBZv8LJAdHjp5U18nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FHgNE2XalRpB7kHSMPBezFer03FEez3jKqYvEybgpio=;
 b=WkEKpIKYnSIn19h/edY94uA1GFzPNi4L8gAnqDfEdINUAsk8gI8Yw2S8HrrGbqp2J82HX4TYLRhpBuP2TSkX9VInq8hR0Pf/8KQQFD3fJpnBeZp3Bl0WOqVjqJbDC/Q54afE7tTW2T+jvtBFmOl+zxU1uPyqhS74jpPmeCIn7SjGirocPkRhxRCyDb24UhQr+NC1h2jLomFanmmdflh3jPqsGh1cIVRuZQTKKL6rv10jRizIDFuy8JWHGF9UfgTpXSukOqnlk8fL0snnCyuMNpTE8gG48dEQ0wxZ+D0LBvvmyrzLKnqDE8fj9TFAXydVQbE8ibSNPig4AToYdFwbrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FHgNE2XalRpB7kHSMPBezFer03FEez3jKqYvEybgpio=;
 b=juk56J0oGOcfyBcrxnhbBnzS/LrtOshHKo377l913/QC9B7gwJSzHuVce0UqsZGJDrkygjvfdvNzP8KhhCViFcSw6Wy1Qt+3PZ4pV+z3Hfiyg387ewmWIpyuOzYfHTrntZvL0EFfDOHDxbiT4a9ynZfI7uZxMD+rVYtLWHQGM+0=
Received: from PH7P220CA0091.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::10)
 by CH9PR19MB9516.namprd19.prod.outlook.com (2603:10b6:610:2dc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 10:51:39 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:510:32d:cafe::a0) by PH7P220CA0091.outlook.office365.com
 (2603:10b6:510:32d::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Fri,
 31 Oct 2025 10:51:38 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.10
 via Frontend Transport; Fri, 31 Oct 2025 10:51:38 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id CA3B6406541;
	Fri, 31 Oct 2025 10:51:36 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 35B7D820257;
	Fri, 31 Oct 2025 10:51:35 +0000 (UTC)
Date: Fri, 31 Oct 2025 10:51:34 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Sander Vanheule <sander@svanheule.net>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH v3 3/5] regcache: flat: Remove unneeded check and error
 message for -ENOMEM
Message-ID: <aQSUtutUXeTu/1u9@opensource.cirrus.com>
References: <20251031080540.3970776-1-andriy.shevchenko@linux.intel.com>
 <20251031080540.3970776-4-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031080540.3970776-4-andriy.shevchenko@linux.intel.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|CH9PR19MB9516:EE_
X-MS-Office365-Filtering-Correlation-Id: 4351c1a5-e97b-45e9-8b09-08de186b77ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WjdIXVPbjbx+BC1DkC+ZWAlD6e2orOSQU8alweSmpfPC+InaE+I7XCRyp4Kx?=
 =?us-ascii?Q?FtHbacaH7txVwLNkKkM2F467tZO7uqO99gBaL4qcGEMJf8hBD5Xn7WSGrkJc?=
 =?us-ascii?Q?vLTKZDMPNZqA+AQfz9+Uzoq1fc/B6lihnw2yI2w43wR0UX6AlEfPf/7gI+Hq?=
 =?us-ascii?Q?CjX88BTBPr+chhjkY7/lgRJxS/rabOd9ho1mbh5z/mEfQchEG6O8bwGT69BS?=
 =?us-ascii?Q?++GIp20GTVWxMpm0s0WaWMc17r1k1JYzP8nXs1tzC3sgo5THd9ydf9KWLmL6?=
 =?us-ascii?Q?fZUsOKBelA1E8Jd2zk/o9GlqXzyDXB/tWI32FOuqIjwCsqGdQu9bmHsrWKsw?=
 =?us-ascii?Q?H3miFRZqUywYS/nEje/TV08o7+MTiZ5RjmBis/BNTju7YqFDOygzGpOd06Yg?=
 =?us-ascii?Q?H3isR46sKz5Z1OY8B2dlhPFO041a2uNaWb84KLppAWR+/d5vJ+J5JQxPno7p?=
 =?us-ascii?Q?NYIb22WvMQqoDi1/fgFDFK/j3wm644gxWk3tCffAYnoWU4nV/XaEU749cQ2/?=
 =?us-ascii?Q?DmETiBmHDgLuSyT0hLIeuVD9dhF1nAuXH+OKM9mPuNv6kdAKEme0IfOOZay0?=
 =?us-ascii?Q?VKvCwHAbQ8N1BD5CQx/ISdl8rvlJ9HyD4HMwLSuBphvt0oxpojTrjWou54LI?=
 =?us-ascii?Q?SBBE+bfAuKg+9CpSlTJtmeozeMb1Qt9+mPCIHNZHD94PCk2fNV08jQH/JrfO?=
 =?us-ascii?Q?xiRcUfTnIm4uzt1ZKDDIoCZ4JU9JkuGHp9OJVJzbhKruq2rpe4uLZU1IoFnw?=
 =?us-ascii?Q?p9IwoOGhNtUeh4/ZexkmJXAZJ98011JCp4vmVOGKXueGywQWRkvs6dFfP2t+?=
 =?us-ascii?Q?dcS2KldOECxfSASggaOPagObNfbqs1jJD8/fLDYJD3xSb75xTfJLIRtW/l0/?=
 =?us-ascii?Q?Utl5nIuMPqFbeZVlvyU8IKlLwuf6e9zaqUJSXnC/5TZQJDE/bXnaaZa7ygGs?=
 =?us-ascii?Q?obDdXlOyD/B6t/FrhqESnQrKVXJtdp0pEnB1R7IksSwtgQm9yhgPYQzvZNpA?=
 =?us-ascii?Q?Ghmbykn5IJktAABH/W8dwX3x6BDe7yG05zHHy++jb3MnuBWndiv1uFc+Kji3?=
 =?us-ascii?Q?v0TsgBrjUrTk1jK3KHi2vw/HxjEE67sVBCSCZCO4oZhxRe0xGHNsR481lyBF?=
 =?us-ascii?Q?QmYXg7Asn3ItHwWTjlgPmXsARK92XkkIopyD7m6We2V086ESdRhEOlb/eh5w?=
 =?us-ascii?Q?ADfnjhyma6AG0vbBYOQFpphpzTfuhA4logf0DUosZ8/KXUUfIE5u6ePsR0M5?=
 =?us-ascii?Q?MObt4vqgInESswmbgC2z3aXSxDGjALdLzGYYhBcwISVdihY6owZOwZ7Qe1QH?=
 =?us-ascii?Q?XnisD+2jeF/6+9STkDHjt3dLuPs5b1wR2nWeVIq9+fCzkGQo91irG9kHdmBb?=
 =?us-ascii?Q?pylqyzHaS0NUC+RpSe99V4pQsZqzKLOktfSTF4AIMAP384FjYiXKpPdlRKuu?=
 =?us-ascii?Q?CIhSS2ySxSKGOx0BGRAUJl+iFBa7h6FdHDxXyCiV+PLnzIwWDDvxEMDLmNBk?=
 =?us-ascii?Q?b/1N1Z3whxIFC6ncQSesmIDJTIVV+ThboIPeYjLz+0nhB6XgpCVqe3KIrfKy?=
 =?us-ascii?Q?aAlQSEjs+oHIZfo+bnY=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 10:51:38.2926
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4351c1a5-e97b-45e9-8b09-08de186b77ee
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH9PR19MB9516
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDA5OCBTYWx0ZWRfX2ohlu8PXSdga
 Trryo8gwVuVntBtl+XmsFa0akN6ENNDE4VUalL9vZNLI7ZiB84g/i2INVIePtwwHHB1OSJf00Mo
 ataE21gy3WNMNuxSdVejgPNEpDrvAnKeUFbLUoJ5vTL6zxAbd9IFCOZ9c3EP4zIcgR3uGUq47SS
 Wa6YLB0X2MKeFPjylJV6qT3uh1SY5toYD0mDbkzL/XN9X31ia5vBAdEyT16Az/2GrXg4j1YRPU/
 iiBooLAb7b1s4w6dp727kpu7eX825YNF6eipYl+rODCObBLS8HpebweburTXFbjxcplKE2YPOeM
 1knEf29ds2muT9/N+JR4CgP2HTgMZ5SZKOQsxXGzaVg7KfrGPlJTLFVC+UEx0HAqvTZ2vbQ13LL
 1vKZ7Y91N47GS2M9jl/CLTKwcNZBDg==
X-Authority-Analysis: v=2.4 cv=Jtr8bc4C c=1 sm=1 tr=0 ts=690494c0 cx=c_pps
 a=mLoR1drGahLtw5ViIJY7rA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jU52IrjdAAAA:8 a=QyXUC8HyAAAA:8 a=w1d2syhTAAAA:8
 a=3YQewCVk5U1Mw4_MAzQA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
 a=udjdHy_fWrGJRxLc5KTh:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: pLf6ExBzjJWblsN2Y5XygCKLaWFQ5YTW
X-Proofpoint-ORIG-GUID: pLf6ExBzjJWblsN2Y5XygCKLaWFQ5YTW
X-Proofpoint-Spam-Reason: safe

On Fri, Oct 31, 2025 at 09:03:18AM +0100, Andy Shevchenko wrote:
> There is a convention in the kernel to avoid error messages
> in the cases of -ENOMEM errors. Besides that, the idea behind
> using struct_size() and other macros from overflow.h is
> to saturate the size that the following allocation call will
> definitely fail, hence the check and the error messaging added
> in regcache_flat_init() are redundant. Remove them.
> 
> Acked-by: Sander Vanheule <sander@svanheule.net>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles

