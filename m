Return-Path: <linux-kernel+bounces-724016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA0BAFED9F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 17:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E2365C03D8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7972E6131;
	Wed,  9 Jul 2025 15:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="oBf5Mbsv";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="SzDlRdmB"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BA128135D;
	Wed,  9 Jul 2025 15:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752074464; cv=fail; b=G9cPrTrX3WsSxsVVBja1HMJVxBpBTP7xbTCzzymo5UOms9v7zXncy7GS5cTseYShEM9hI5HsF5a9QeI44Hmg4P/UhijE2OI83sXM/0hC+3ByIFS0+pjcRUQ/CCwoflg/1DOMDzoXybphVgeGSlDhNNyhXeXDYazeou4bpE/hdNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752074464; c=relaxed/simple;
	bh=z7rIs474yVG7aFsTQmWODeSuBGXOQwFSHsks3v7J92k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bmtnfHnC8XaZf5hTbCO3YzUAUjsvI0ZO4FvUPX0nCbqWsshkpxj4OlPrmnaLzupE1xRMc8fjtwnH3QmOYObfmlSFRmb3zIxNjBklRhahbgAuwyGsW+rU4WPyXpgMDhRdPP+/tlXFSohGk7rZ0uYAn1hg6bopHAks6iPhcZajoU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=oBf5Mbsv; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=SzDlRdmB; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569BkxSt000726;
	Wed, 9 Jul 2025 10:20:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=HIKiWRJY/TepQNmcVf
	bLuYDuklnX64Tb5i5uMwglbLs=; b=oBf5MbsvAY4mbPgF2sTLoU11Zen8GRplU6
	ZINlwp+IPDELsjcggp71xrT7lU4uBcjJnFXVDb6ujql2pQL7DDhv1dcPvB8jvT7Q
	65hx2k96mtmJ8jLQ8/y8oQBxRdqkyYV5PQYmM/FJsy3RYo1MV6BZ9KdvAvhqGwVH
	imG++aljwyb2UE2ZArmQUmVjyqVowNIYChonz/0UH3pI4TUMeyGH/5KlNXWQesGC
	Jr/WyYi+99oFMHLGNoPhSR2t0RJ4CkszxhecWmGexki1E6AocwBD77e42qK8ASVD
	Xr/U8+tFz88ZhBlRMmPvzM61SqO7np5d0dVZyJmue5Rax7m5iLlQ==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2100.outbound.protection.outlook.com [40.107.243.100])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 47skytrkse-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Jul 2025 10:20:32 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pUsCgthiJRQ1y42OlpaFjXWiftAuKN+8qK2OMUwf6ERgu+yAZW5cQhCJE5GV3wAf1tjHrtZ4fDL5gToue2fC1T1+H45auuEq9C/OE5+vrbzIXVYHaJ+xC4aGDj1vT40sT+5RhgKsWvho3TOtuudqkxA1KI+qpP5WswR1NnncHh09tTLN770ouyWtZp5aYWDh00PmqFLgyDxHXr2wcmCFhitM1TaQlAUcluNAEExc65eIwZVYnOCoZ+w9Y1HljEr7IGMs/JWU4s4IkvLxKCgE5aLr7BIClKuwFIYcliziPoj6kCY770fywbtyTm33b/bSm9ERFM6KqrWQ4gi3iZebZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HIKiWRJY/TepQNmcVfbLuYDuklnX64Tb5i5uMwglbLs=;
 b=D4zPyrAGbw2I8Q1oO9iMzOUuby2LhmOuap9af9tbQDKJI6O/hIoaCLiZhIjKhGB9ebxqTe0IEKMKfGAU03hwm7/6/TIJdt2DQVijDlboKhpO4nSdpwnjw6R+kr43LT17mttVsiq1lfWPvb6aCk2U+JlBjbfONL2LcUevBE1t2cLmolcyVmVFhH3NXRpf7H8IwVzoi3eEs1cNHeTedJM1JfM2isEVjMMqdvCyCzXgtYr8Aqb0xhmtiY7LKwHg7CfYc0/aCEYQpu/lQxpoLtDuRTEFa09ioD9Ne+goosQl4eBGTonyA3t79C/VPjTk+4lERpek9pKmCupauDu1d/T4gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=arndb.de smtp.mailfrom=opensource.cirrus.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=opensource.cirrus.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HIKiWRJY/TepQNmcVfbLuYDuklnX64Tb5i5uMwglbLs=;
 b=SzDlRdmBlfuNUJn0PszHzNcBOlY/5s4qqOWv4svwIA32sEFDsK0/pHfO10ULMpKv0caJmaFirs4VZzGMszq0cDra0WjQ0UaEogM6IpyNf8+iQPebbb6ryYmRR+bS2RUZ+Hs7qokMpDoKQ8SGZnI5sAbAmf4ZBhKDagaF7z33ToU=
Received: from MN0PR04CA0002.namprd04.prod.outlook.com (2603:10b6:208:52d::13)
 by DS0PR19MB7197.namprd19.prod.outlook.com (2603:10b6:8:137::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Wed, 9 Jul
 2025 15:20:27 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:208:52d:cafe::21) by MN0PR04CA0002.outlook.office365.com
 (2603:10b6:208:52d::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22 via Frontend Transport; Wed,
 9 Jul 2025 15:20:27 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22
 via Frontend Transport; Wed, 9 Jul 2025 15:20:25 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id D0CE340654E;
	Wed,  9 Jul 2025 15:20:24 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id B7C9282024B;
	Wed,  9 Jul 2025 15:20:24 +0000 (UTC)
Date: Wed, 9 Jul 2025 16:20:23 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>,
        Maciej Strozek <mstrozek@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Shuming Fan <shumingf@realtek.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        linux-sound@vger.kernel.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: SDCA: fix HID dependency
Message-ID: <aG6It2zUxagesGK6@opensource.cirrus.com>
References: <20250708184618.3585473-1-arnd@kernel.org>
 <aG5iwy6j3rR0YdPy@opensource.cirrus.com>
 <f0275a4c-9801-4288-91fd-e28aa4bc5b7e@app.fastmail.com>
 <aG6FFXrfOnBlnn1l@opensource.cirrus.com>
 <0b385401-2291-4cc8-b10c-6e7f449724ec@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b385401-2291-4cc8-b10c-6e7f449724ec@app.fastmail.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|DS0PR19MB7197:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ae93bdf-3b18-4154-7f01-08ddbefc2192
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|61400799027|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SQ4QbSzaBLp4d1lE8aTOBESm1uRrSxKpZEN5gN1+3VgvDucLMRZPnlQNpdQK?=
 =?us-ascii?Q?f+SamDuLOnHVKFc8l9XpAghSb5o/a1zQ+9lk8R4g4b86+wIM8AW1X/GooYxd?=
 =?us-ascii?Q?t40QcHyoSiHZaZxsGtPbuBmUlsJiR5SR2vtsh0+Bs/+rDNih3pe6ogg7KaEV?=
 =?us-ascii?Q?6XR08ZiJZUZ5matSCbDC27nNrCqd8DXuGjNoksGoR93xQbBvkUVzb7L/tIo4?=
 =?us-ascii?Q?mbFqlCAAF8tp3izifVSGTtOkeajnW3+Noy/Y32FiBKcO4xsz5aZKPBz2uhm1?=
 =?us-ascii?Q?3ArqrZxOCkRYQ4tUu7xqFyORpE5D6DbuEF5mFPMegUlc43nWVIe1Z1PykHfR?=
 =?us-ascii?Q?qg2itcCGBsmzt9MYLG4SYazCLgqi7z5PRc42rKcBMQIrAl9qySmZDu8Wl1bf?=
 =?us-ascii?Q?Ige8HNw9l8EEc8MPy6mbpChkwvlSzzZUhtWIpNlUmbTcsU0hjETPcKBQfgcD?=
 =?us-ascii?Q?/uIZi50erqaH5P51zaPiTWo9bStyKKUKssLPo9PXlKKfILfo32S2BL/f9kE0?=
 =?us-ascii?Q?OOiRRVrLuegfWDHViBoqi2hxaTMdRsL2TxatHI541bAcWSnmooj+gLeKf1cx?=
 =?us-ascii?Q?1MriZlRi9k1R1rtzoYpOynvCZA7jXny5WTCYRXt26af5uSv72cbd2/fmv9A5?=
 =?us-ascii?Q?4r7dgK/3B99cZuznAjN3XB/3f0FlpS1CN8PatN/8hwmEAn+jDeTIyLG2aIP4?=
 =?us-ascii?Q?YbL06RXxkOdXpTML3yLs1K4YtcZL0M1y2nMAjkGojwi0y5VaZg82fQcFDm79?=
 =?us-ascii?Q?wMCDNUYo7j4rJ2xg82rDh9nol0xVuw2H2v9kTuVs4ZoQnwLANXy0+cXweAmp?=
 =?us-ascii?Q?QG0+laz+cEv1xUtPBJdRnmxanj3CbAWHDUTjm91DtnMxvfQ6eovOytYSzfxN?=
 =?us-ascii?Q?UDGZ1tWIuiXigaJWOUj8clZxZSzuKBYDnnEbB7IBT1B+npPcOmnW6aSLNw2Q?=
 =?us-ascii?Q?M2uTY6AqvDi9CrScm9BG1rjaOqE2TY+qhjzIQ54KqrYVE+IfLADfEKx5FbM+?=
 =?us-ascii?Q?IWuEa02jFYQp6uiDjKrofsbm6Ej3BGej6s63tHiktjUWNJndgNcjZ7nQ8h4Q?=
 =?us-ascii?Q?lZI6rO+2n6/n+U21apvO6kbW+/0ntx4vEhVoyEjOZ/U75DcuHDbqDuoDvr55?=
 =?us-ascii?Q?HPZECyvxza+nmcF62NmCWNKJeA7dvUBmFWsC8KdI+p1R6/LrNGdAcCxHqYxz?=
 =?us-ascii?Q?ejHP6wr13EhoPLKnd7vdWU665ZCkQwIsiQXiSvIq1mAv7gO8eLBRZpX3iRbz?=
 =?us-ascii?Q?eq7JzrqwThEWwJuPG6DJ4zIAjAOmRrfCFCEMSod2/QqM/4CfdpHsX+XJs85J?=
 =?us-ascii?Q?HpiZTPj6kwZ1d9rspxZwKy2Fcp/i7Z9YL0hpCMfdWbgD4k4h7I3561Fx9WZj?=
 =?us-ascii?Q?mB6L+cReQCGL+jGXmtF0666D+ngi/cHQA/M3dJZpG2m2Fqx+8hom8NSSDy8U?=
 =?us-ascii?Q?mbSweSDcaIiZhfR/goKotDlP2qYb4h1P5M3+0mEiuOu4NNWq3R7luIQStQtB?=
 =?us-ascii?Q?RD+lBFw/ckef+SYRkQnjiHL+eV4r/iGVs/dX?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(61400799027)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 15:20:25.7443
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ae93bdf-3b18-4154-7f01-08ddbefc2192
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR19MB7197
X-Authority-Analysis: v=2.4 cv=BerY0qt2 c=1 sm=1 tr=0 ts=686e88c0 cx=c_pps a=gFXscbeP1qtukfYSu89ywQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10 a=w1d2syhTAAAA:8 a=JYfkgNJqRHL_YLtgBHwA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: j2TXGaujrfvL0LPzM3dttrbFHaYJwGBQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDEzOCBTYWx0ZWRfX8mc6235ckutW 5SulF6/G8IkU099TDzAaQT95YDhMm8R+GU4Jqv09t6x37SLJYhWZ0IvHL1Dp4jsfOh0777OgBRF gTqIZtvoQyp2Fpj6KCNhr0blpPOK4hJWT89c+XIjInkWXMONic+/wP/2R/tM6Kb7CHXQqpHYc3H
 Qq/8oupO1MQGRq0eOcTPaBfxfxfXLT+zJTu2EenbTU6ReB36H5fIBtVdYPlvNr6K+jo5af4on3/ DEI4tw7/SaLrBV05zft/tQUVjpDhvso8BROSUdGeAhOkO+hFgBIy3vkN23w6JaBNazUe5+uhNP4 qRTIatFFgxL5FVoHYqYjtdZWrHvI6CTUz4OkthG/UUjgTvtZjOetNszN75P7HNTXPW9PXtt7m2Q
 5kV8E14ccKD3ymlRwTIc2qFTWiBDbJEocottQG8qEgf+I0AvLHLN0ASOvWlQRCCGkwYtmCqE
X-Proofpoint-GUID: j2TXGaujrfvL0LPzM3dttrbFHaYJwGBQ
X-Proofpoint-Spam-Reason: safe

On Wed, Jul 09, 2025 at 05:13:05PM +0200, Arnd Bergmann wrote:
> On Wed, Jul 9, 2025, at 17:04, Charles Keepax wrote:
> > On Wed, Jul 09, 2025 at 03:36:49PM +0200, Arnd Bergmann wrote:
> >> On Wed, Jul 9, 2025, at 14:38, Charles Keepax wrote:
> >> > On Tue, Jul 08, 2025 at 08:46:06PM +0200, Arnd Bergmann wrote:
> >> It could work, but then the 'depends on HID || !HID' would
> >> need to be under SND_SST_ATOM_HIFI2_PLATFORM_ACPI and anything
> >> else that might select SND_SOC_ACPI_INTEL_MATCH,
> >> SND_SOC_ACPI_INTEL_SDCA_QUIRKS, or SND_SOC_SDCA in the future.
> >
> > Ah yes I forgot things are selected by the Intel stuff, at least
> > the double depends on HID can be changed though? ie.
> >
> > depends on SND_SOC_SDCA
> > depends on HID=y || HID=SND_SOC_SDCA
> 
> Yes, that functionally the same, I wasn't sure which one
> you'd prefer. Let me know if I should send a v2.

Yeah lets do a v2 without the duplicated depends and feel free to
add:

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Also thanks for the patience with my questions. I will have a
look at moving the IRQ bits over to a similar scheme to keep
things consisent and hopefully avoid future issues.

Thanks,
Charles

