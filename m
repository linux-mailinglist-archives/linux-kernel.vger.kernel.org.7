Return-Path: <linux-kernel+bounces-750397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56919B15AD3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F51416C5C0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 08:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B553264638;
	Wed, 30 Jul 2025 08:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="PNbOek0q";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="mTyJ+ue8"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42431F4E59;
	Wed, 30 Jul 2025 08:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753864977; cv=fail; b=PwGDho9I1BBUn8SLk91vGJ/qlWu02i+aRgTa0AezgjTEw9QHFzMxFtEpzzg6ocAyyao8e+S9CFKeu9hs286FgTalTvhCJhWM4aBz0OjFeM/Xkad3Xzb3YMiTfzuKPywITZWSuc+rbMZUZ6Er3tQu8fxBQCO9ebXfb6rOVSOrZd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753864977; c=relaxed/simple;
	bh=YbOwj57Hl6G8COuAF7bz8LFe8qTf+DZ6WsEL4Jj+XKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pyFZlZtihcT4MQu6sU2QipqUIajhX/GcWl3l9h48SFv2KuDbbwrKqWcN86V/PByhg4eHlW9vI1EJVWe4MxExG+lwd9v+Ow8aDZk2U90vJL/0l+J+4G0RTe/e7mfMwIfo2OGtwExln0S9Jt7PLuOzEiLFnhEpQvrrR9H9GideO7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=PNbOek0q; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=mTyJ+ue8; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56U6vtq9001460;
	Wed, 30 Jul 2025 03:21:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=Ha22pap/Tn63iHA+c1
	qMcKFm0IHtzVxY7kos1QadDgY=; b=PNbOek0qgUQ8SOeqS/fOOmqws7spywtl2R
	XgByfGDe+ZwwdG95Qp58wtiHDhOPo6kATd3CeTyOgaVmpa9FsWLnO1wjlGIBbwvU
	+kRO6Xtbfg9zv1PB/w0BTh9trP0LA54TXVVkB8HDai9KZI+6dV/mQ1oUh6uU6O3Y
	cQ2dvNo0TQmD5nWROfRVq5BmIa2RHIgQbDlR41nqUVnsd3D+z2jKZ2U9XhMheRrz
	5zgKfrmRiMzyX+LtsOBMb4rA6djWyGMwXQY11fWBk9mbcmZVu2Z1DHUGzuoX9GBT
	En7NLH3qYZm3zuzNlHfkaieCxFI/U8Eo+Nf+YOQQzMK17GRisW+A==
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02on2135.outbound.protection.outlook.com [40.107.212.135])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 484uefvvhh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Jul 2025 03:21:55 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qulcMaqWA4hOU8LIMWvxUvD93GwBZeKxTFfo7OwIkhcqvTS8TbkIYD0xWvUo2T9mOw9MMvHcs+hYz9btoVTvlGiANmTszgoN5oOvcy/vcvMls5YUA3FbW6/Uv8vJjIZ+4QJaaJN5DoXRFE0iUkJb4TJrcZbmQvjpD/2xVtQP8Pt0czJaNSClyETGj+prs0dWGBBqL96o8V5qU5smxuPCFBPSLSD+P5LPT2N5+TT+quDXO9RPjIW3XlD8LDoNFsIPwpP9jcN3zaO2OTA1MyvPPkGglbUJEZkPB04f0eou2DPjf/PBX+xR3/lNUC7zo81upt2iaCF5sO4ZrA0EzP+chg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ha22pap/Tn63iHA+c1qMcKFm0IHtzVxY7kos1QadDgY=;
 b=V2OF+M+yUs8jBYRQ2tV1EJ0Dwz5BzCi57LKq5CtD9aWFfGu6X8rkSJRPIjufF+0cVpsisnusr5uOnUaMZOj4ERoAG+yh6fMl1Udy08Zx0PEaT7Urvs8MsUCmwQ7/8u6ZcgcCwiLghyGK/ml73GxVUK/EC6jeZG2vsOMhRU72KOVMyQcG9HSt0P0E703mzBqdJ+qYBbL2Rjnr3/vSvOVlEodBPBKB2TRhq+gHMQfPWoZN6X3PIZUrs+C06lEqsZJiPjc9e79sPL8IMhshrKXdqbrv5PKr5NNAqPDzPIWfVJZgVbiEtSWThbTVGVxB+qw0AEzWEKxfrR7ychkCny+9RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ha22pap/Tn63iHA+c1qMcKFm0IHtzVxY7kos1QadDgY=;
 b=mTyJ+ue8ek6A/2QXt8JCHBGRgLgbk0Ba8A68LtW88I+OD6zjgHFfI7f7bsYf2jb4BGq1IeTuw/2b3Z3caBhcomf4Xr3bXLPTsMlShgzm6xjD1btz894b248ZmRInBvDEBFGZOCMWgC6hMN4XF5bjhgGmhyiPgMTC9vhIQXCvljs=
Received: from DS7PR03CA0147.namprd03.prod.outlook.com (2603:10b6:5:3b4::32)
 by SJ4PPFFBADB5175.namprd19.prod.outlook.com (2603:10b6:a0f:fc02::a63) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.19; Wed, 30 Jul
 2025 08:21:51 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:5:3b4:cafe::73) by DS7PR03CA0147.outlook.office365.com
 (2603:10b6:5:3b4::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.11 via Frontend Transport; Wed,
 30 Jul 2025 08:21:51 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.10
 via Frontend Transport; Wed, 30 Jul 2025 08:21:50 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id DE5CC406547;
	Wed, 30 Jul 2025 08:21:48 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id C02B3820244;
	Wed, 30 Jul 2025 08:21:48 +0000 (UTC)
Date: Wed, 30 Jul 2025 09:21:43 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        patches@opensource.cirrus.com, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, shengjiu.wang@gmail.com
Subject: Re: [PATCH] ASoC: wm8962: Clear master mode when enter runtime
 suspend
Message-ID: <aInWF7IpHW/M0Sca@opensource.cirrus.com>
References: <20250730064054.3006409-1-shengjiu.wang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730064054.3006409-1-shengjiu.wang@nxp.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|SJ4PPFFBADB5175:EE_
X-MS-Office365-Filtering-Correlation-Id: 3729ee53-9101-4a70-03f7-08ddcf422223
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|61400799027|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ta6e/QNTi57jeEsN1nm6IeFO5SG4N4uUUbAx0PemwwbnM3VKENVd6fQdsaDF?=
 =?us-ascii?Q?ToZqfW4JRhxeEPpwuXyW7w5hlEUL03cfsW2S+Tfg4V/p8EM+wdsSEpLPURKn?=
 =?us-ascii?Q?h2gsnXpqSVSSDJLgExGLlb8Vel+EPH01rzQtHl6lGES8n/GIP7sXCI+dkb7n?=
 =?us-ascii?Q?KOPcOmWVCjnEIwTReDupPXk7uqlr4X+a3UbhBI/nJA5+vtI3VXaNipgG9WpD?=
 =?us-ascii?Q?Vef/TSNTpJyHdOgYM/Y2ZeUrtOVpCApUVP9/SgYf+S65s8K/phChstzHcnV6?=
 =?us-ascii?Q?QFGElbkc295cGYH5pYRcf3heZQoAuGrMLj/8A0PytYpfc7jJkO+y+PJCW7hs?=
 =?us-ascii?Q?lmCf/0DZ0HUALJ9FwqlYMb43mf5nNKrj/pwu7woOLFKrmKaSSaET7pDKVuFE?=
 =?us-ascii?Q?Y1bN20e7GRPMtQUAB6IPwinQVsvHKHTvvxPQp24YpYHsq19fAWxEG62TVzB+?=
 =?us-ascii?Q?aCigQHG92NejsqaJW1kUBeoHoHpHJIbvck8Pr+VMomHgzKweHlSbkAeC70gA?=
 =?us-ascii?Q?ZA+yxEa3IC1qUtq2S4f/BUOrm77FFyyt+Xk+PMCSDRaAHB8vyp6P7TSd3VPJ?=
 =?us-ascii?Q?e0Hq+61jLvX5fN2aUKERWo9jRyHqQOc0W6JPrCHD9WOmH4hecGOu7esynvKc?=
 =?us-ascii?Q?YdZOghV8h2ZhFmI86SBHCOQyQztlGv127ESobsAUza7Wr//SgCesEFpt6pFG?=
 =?us-ascii?Q?0LszYMO02gXE2YRbChH1OBjIkX0ySDqJR3e2uxT4J1WaaL3BUj4Hlc5fR1zy?=
 =?us-ascii?Q?FDB7stRDz6Lh1tkeXoooysWkXc3vH/LsmoLkrIy/n85XQ8U9xcAl4peE6FRK?=
 =?us-ascii?Q?qFvNDyCodtlLkf33V8tJr2OwfDSorH1ws4XQfUCZU3XQaQzg3CzTwXlUWhcu?=
 =?us-ascii?Q?5ORQRy+WPoXnkYMNKFFcUmVg4+TEe/LNL0mIKAZn2PWEeKF+ZkxendyFpNRW?=
 =?us-ascii?Q?OzFPVir0JOjZviXw8TroINcB0QQGB67znqxFBP0I3DYfT+IX/vASvXk1sgNP?=
 =?us-ascii?Q?HDcNUq0s4E6beEKXkjV6ny93X0nYwitbnbiT8s+SJRAf3XCNK51RcFmKDWNQ?=
 =?us-ascii?Q?DUnU3XFAwxvFTpvPqtkG07GnvV/HlkHZI/Rgi2WD4oUstDaeWNvZxNnsAA0F?=
 =?us-ascii?Q?p2DqpwKKnJ9yVZfPVmfMexQd8FNayjAVcZB/kCABUZqAEXLKeUBfVtJFtk0e?=
 =?us-ascii?Q?avkWGgCfym2yAU6H+NUILCuSHUj58qSYRlVEMApKk3v6ytvY/ggy57BUvNUP?=
 =?us-ascii?Q?YCAouuG5oebw6A1+S9rC22gsGofPHx7rechXFAFFgJ/hDoBnhQk4VwQrSwJo?=
 =?us-ascii?Q?ds4gqDUjsceRjGM5+L55CZbVMF3drvEf4wXM/WljxDKMX3Fs9jOKJyu7OGKK?=
 =?us-ascii?Q?i6Y08cddGd0m7ig+yhxGxw8xIbMeigEdy7an4WLdU8WL2GO44en5d+RAzkMD?=
 =?us-ascii?Q?lZjGn1Uq0QuRcoN00KT4kwKa+Ghq88Prnb8JWFD8NjdMY2hfZnUDyqS0gFCY?=
 =?us-ascii?Q?J6Zn7qyABd5IwV6RgeEb0BeAWIWwkDVOu9WR?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(61400799027)(82310400026)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 08:21:50.1165
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3729ee53-9101-4a70-03f7-08ddcf422223
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ4PPFFBADB5175
X-Proofpoint-GUID: NgoqHrMcBeq57gTjW6Huve7d1UpazXZo
X-Proofpoint-ORIG-GUID: NgoqHrMcBeq57gTjW6Huve7d1UpazXZo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI2MDA3MSBTYWx0ZWRfX93HqAR9LxH+s WCKWMtZ/XpbxeL/do70PAmVJweuw5z0cjCkJ4+MdrgIPP/RIT4vuF322HF34BVxsC2/0GiHXLG9 HotkTRJA6CfjSuurSexeEEpy232XcxpSxk3G6woDZVNAt9REXkvD/RZ+Fa6ccMT0avr5VT9Q7YS
 DyEIBCeFJiVDEPYmlWIzNx7vkuZKQFVVCQ/g/pb32H5uayh1SM3XRpIfTInmgk0EItTTZwCZGlt 0DRQ0OYoe2thqMxFy4OJN/4xOMTdRXs1nJPYwMClzdLd3Kvaljrbxaw8jZ3T+o/LMV+81dVPacR cRnLiwMXtY6NN9tvM1keA2WRIkrdYooPBQ27at10oeUS9GwE2RP/kc3lJaTB84MR4A3x5Rpi/n1 OAw9MpXS
X-Authority-Analysis: v=2.4 cv=OdKYDgTY c=1 sm=1 tr=0 ts=6889d623 cx=c_pps a=vW7+hjB9wZphJVnghZzj4g==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10 a=8AirrxEcAAAA:8 a=w1d2syhTAAAA:8 a=LBzfHRTVxICNsKeek3sA:9 a=CjuIK1q_8ugA:10 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Spam-Reason: safe

On Wed, Jul 30, 2025 at 02:40:54PM +0800, Shengjiu Wang wrote:
> The enabled master mode causes power consumption to increase in idle
> state. Clear the MSTR bit in runtime supsend and recover it in runtime
> resume to reduce power.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles

