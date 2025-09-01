Return-Path: <linux-kernel+bounces-794784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E012B3E72C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 16:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1648920706F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D166341AB7;
	Mon,  1 Sep 2025 14:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="NhnVjUiY";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="hDrjEa6E"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C93B340D9A;
	Mon,  1 Sep 2025 14:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756736951; cv=fail; b=NXeKGYp+o+IvK71WnT3vSaCQQWb+4eoJEC6gqG/NbO9yos2MmAY5UjLCsozZPeX+3u/180ljNEm3cjdbd5ePXE1RGkAiVz53jPM4X7LJMO6d/NDvDTPb2orR+HxhK+5SFAIV9NGy7X/qlGLqiK0Ee6VuKaRXl0/XcVNC6hgi2hU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756736951; c=relaxed/simple;
	bh=uMbsSW71fLZFC0qeeHEkUMxCHQL/zIyzIC/XvFiNZEE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FcBPNmuO6fyiidKUGWlE5EU8S/vqt8NxuQGAI1Wj8QM9GNsJZjbHtov6AYjPEwoY0XOiF9+CQAnW80kNWR0y3Bh52K45IAADvp2sNM+C+hlSI34KSJfRtTqactHVm6gDAXTatdKsauZMfRgVCR4Wy0rKmGliZY8eKgObPXvV7ko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=NhnVjUiY; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=hDrjEa6E; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 581DU9HP2258375;
	Mon, 1 Sep 2025 09:28:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=uMbsSW71fLZFC0qeeHEkUMxCHQL/zIyzIC/XvFiNZEE=; b=
	NhnVjUiYo9RFHBd/2vc2gwaaxlXmmWBteSIkpgJkgxr/UIi1Gct7Ul8uy1F1+2P3
	fFv8nS4ZmuQLXbCZ2asaIV5x8m2NTXN1DRqmgg+s77MZjLu8yfK568dDWKcKv8SJ
	l1oHtSZ3yP7r+WCQ28jCoTFm+ETOyHyjP7zgrmG8cmwMbOn4/DaoKjK04iMT6Ipt
	Hoolk8PlApp46M0a4jemONm7GIUy3QykvJwe1i9HuPq3Wzy/h0FTHp3kBKrgjFqu
	KECdGxL591Pw3/ZVgPjrQj4kbyrADwy/AqtuHZ8MUbLr6zeSPBugjJu9Y7y/Ncmz
	q1FUq8+Bxk3UsOGGkl6nRA==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11hn2233.outbound.protection.outlook.com [52.100.171.233])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 48wce2822x-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 01 Sep 2025 09:28:54 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uj7OhTfiPJXo4P65jQKJPl6NjplcYXWGGPUn5RVRe43GSEPoQtWjAwak8iPzedH2n4kZRH+phyuajaD6bQ1NyUiR4O76jHbsXIHl3/+Q0lhtf9KiMCftvr/My7iobAcTd/855uSj2prj+tirE2gT14d4wkChs27FaXwejAWTtZTFD4eKlvmhFkmNjrNYSULnsUqykmpQZtJWIT2HGqxXaA3+3GBUlKiBV8zssIE66tYnXGluYgdUk/waPffbqiXHnq5CUc4deFLvecTwJ3+muOyWzA0QcfVw5CDmml4QJwQhr4TXUhFqwrZZRBYwoQ6COPNRgIP7TraUoLdmYGW1YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uMbsSW71fLZFC0qeeHEkUMxCHQL/zIyzIC/XvFiNZEE=;
 b=iqSXwXnHlpGeEYdOr60h456IeSD+STRTFZR1/HprOQo/1F35EZw/ZuTBoTGF9GIjygsoAmDc/KzOcf1jCCbz/p1JazeIDIbWkcStatu+WNHVp98habQrWuqmFYft7xo4bejWLnZDEHNIs/Yujo/CntQqPVxYEXjARue5we2r5qkSMLHRsfjY8oO6UIZxQxNSk8UGze/imkSFpi7tceVjVlHMfHF07CyVXoKQGqpEbz23VMpgRpa8lBQmtJVFBZ7HqF7Nx6nPreDRx5m39rArICMisBd3Cfi97rbCURQfqQwmdrz+9apaSzIj+lJuTHsXYVWxuNvS4NYyDQKMhxWBvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uMbsSW71fLZFC0qeeHEkUMxCHQL/zIyzIC/XvFiNZEE=;
 b=hDrjEa6EMTGawb7xKyudUpJBtkErWKuLj4miuaX1fhFuVtS84PZtfNf+htWlBI/mWuQ0yMwA2Xf8KV1q2xRUa0936f9UOJrfHsCPb+46KAIT9lJg+aMF1czC9nOnFjS1d2sLIpMzniDPdIMzDpDVI5AFthFdriYjv85w0dJytFg=
Received: from BN9PR03CA0915.namprd03.prod.outlook.com (2603:10b6:408:107::20)
 by BL1PR19MB5673.namprd19.prod.outlook.com (2603:10b6:208:384::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Mon, 1 Sep
 2025 14:28:50 +0000
Received: from BN3PEPF0000B069.namprd21.prod.outlook.com
 (2603:10b6:408:107:cafe::a7) by BN9PR03CA0915.outlook.office365.com
 (2603:10b6:408:107::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.27 via Frontend Transport; Mon,
 1 Sep 2025 14:28:50 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BN3PEPF0000B069.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.0
 via Frontend Transport; Mon, 1 Sep 2025 14:28:49 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id D9823406543;
	Mon,  1 Sep 2025 14:28:48 +0000 (UTC)
Received: from ediswws03.ad.cirrus.com (ediswws03.ad.cirrus.com [198.90.208.11])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id C63CE820247;
	Mon,  1 Sep 2025 14:28:48 +0000 (UTC)
Message-ID: <3643b07326567604a6ba5b59ece84903dffcd3e5.camel@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: SDCA: Add quirk for incorrect function types for
 3 systems
From: Maciej Strozek <mstrozek@opensource.cirrus.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Mark Brown <broonie@kernel.org>,
        Charles Keepax	
 <ckeepax@opensource.cirrus.com>,
        Bard Liao
 <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart
 <pierre-louis.bossart@linux.dev>,
        Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        linux-sound@vger.kernel.org, patches@opensource.cirrus.com
Date: Mon, 01 Sep 2025 14:28:48 +0000
In-Reply-To: <87tt1m5kvl.wl-tiwai@suse.de>
References: <20250901075755.2070983-1-mstrozek@opensource.cirrus.com>
	 <87tt1m5kvl.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B069:EE_|BL1PR19MB5673:EE_
X-MS-Office365-Filtering-Correlation-Id: 6237334d-7798-4e4f-d0fe-08dde963de7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|82310400026|376014|36860700013|34020700016|13003099007|12100799063;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TVVjSkpaR0FaRHNPU0ZjQTloTjRaTUs3UlRKYitTRHFYQWRXTkdPdENkQzFm?=
 =?utf-8?B?WVFFMEczODRidWdZWC9TMlo0NUNjMXBBU01FcmROUThUbGt4dFVKZkxreHFs?=
 =?utf-8?B?ZUhWOE8vOFpReVFQTjlkY0dseVdwTHNpVUFYRTZWVmdqR3NjNldjQ1VrK0pB?=
 =?utf-8?B?NTJHbjZZS1I0bjM5WDBXdWM2NkcvcjEvZWV0T0tVZ0ZZU1RHS290N01VSkFp?=
 =?utf-8?B?dTNIM2x2YXRucCs3OWM2eVJ1K2l6UmtTbDNkSjNaRGJzeGtqUXAxZFBWbDUw?=
 =?utf-8?B?RWxYcURoamtaeXh2cFlXblR5OVJqYzBYWlZFYWNyVkJpSmpaT0FxY1BvNHEr?=
 =?utf-8?B?Snk4Ni9BMnRnbmszdllIR0ZsZk5yZnlIeldXd1pzWGw1N1R4c0VDVFdBTWZH?=
 =?utf-8?B?VjJoWWtVWkp6R1VnOWE3dEVISjJ0ZVl6S1NselNpUGZ1aWdEbkdLNkRTV1dR?=
 =?utf-8?B?THNvRlBLRzdPRFl4VU5teUZKTlU4STVYVUMxNEZyZGxub2VRamE4bWFyNk9s?=
 =?utf-8?B?a2tBTWdMOVRzcnBXTUk4Z1NKeFFSQUt3S0NPUU5naXY5RVk4Mm9BL1FLV083?=
 =?utf-8?B?UURUVXZ2LzA5UlJ5bVQvaU5MUmljS1dvOWJVRStVS2xhYUhPMlNzdXhBQWJE?=
 =?utf-8?B?QU53aU5lRnRuMWVUM25sd1B5TnVPbm1FSU9NbUFYMHFUQ3dNQjFDYUJ2Smdo?=
 =?utf-8?B?NWIzSlltajBNdkJkRHNuVnZTdVNXVnFZWnRjaUFpWWFkck96THVTb3EySmhs?=
 =?utf-8?B?c1RWekZpQ0NIQ2JuYlU4TkxSSWFqdi8wNGxwSDBPdzJjcEF1VmlNcytQTjRj?=
 =?utf-8?B?R1BqZ3JrSExXVmR1OG0rRC9lOGpEcUs5Y1VGV05EV0hISFpNejJIR0VoQ2NC?=
 =?utf-8?B?aldjSjB6SXM5OHcyTnZwWHQveEU5L3BtZ1htRnJYOGh1YUtZOG9ENEJCOTlm?=
 =?utf-8?B?Lysva0xaWXJXSW81RVBjVDhUaUh1cHlOS2FYcy9jbzlMdjJDYjFWTEE3UGRB?=
 =?utf-8?B?Z3ZPSllobjZZQXBJNTN6MEJiVEhCb3R1QnhYQlhpVm5hRkUyRjJxQ0xGaG0y?=
 =?utf-8?B?bTdFa1M4OERkbWV2UG44RHp6NE5yMXByRHRoT3MySkQ2bE5STE9QS3dIcGVL?=
 =?utf-8?B?SXlESGlFOXlBUGM4L2tjWEVBeExPVXVMeXV4Y0xsdnIyeXI2MmZnMlphQUFl?=
 =?utf-8?B?cGs2NmEyM2pFYVdhdkllTWxwNHR1VVJBU1FWbnA1RmlUVUxtM2thSzRwendN?=
 =?utf-8?B?MUwzTDJCd3lLaFpTQWRDSk12Vk9UOWhwa2swN3pvTXRSVks3YzhaS3VXZGph?=
 =?utf-8?B?MVFQM0p1Y2NxVDlGWXp2OXpTV3ZPamdxUnFCV3VrOHhKU1VnMzZuNFIyeDRE?=
 =?utf-8?B?OGttU2JEdFA5SWpCbjVmbjZaVFpkblZROUFhRVdkNk9FUkdPN0lJMUpKbW9O?=
 =?utf-8?B?SzlxUS81TFpYRm5zQmo0dXFZM3Nyd3dHeWVxMTE1Zk9UV1V3RzVzcFBUOU4y?=
 =?utf-8?B?d2JpcEptK29aWWpjdldZS3pTcE81NTdRZGFWSkpHelNBSERZMnVKK0Ftd000?=
 =?utf-8?B?bnNGbHdlYjZOWCtJT1I0NDA0NjJHb2lKdCtkUW9zUXNuL2dUV3dFaDd4bDhK?=
 =?utf-8?B?TzBLNWs5U1RuQnVvMWhSV2svNXpoRkxvQXI0dEpIY0JwYkt3Z29EOWk1Qk4r?=
 =?utf-8?B?L0tjMmJNTGYvWS9xN05hWEEzVGFGN24xSXRrb1hYZDlYTkFreWJEN1h3WlRP?=
 =?utf-8?B?VTRQYlZhWlFaUVozNDNSa2RyY0FoOUlQWFBZem1OWjg4aUpGT2J2N3d1dTFk?=
 =?utf-8?B?TXNwVXBobG9ZTDQraWFRWCt0dnRKejFLM05NMURrc0JiZnZQblpBdEpiL3ZF?=
 =?utf-8?B?YkJXdG4rN2ZOWm85QkJERExFV0xvSndVTzBvVjhGemhmVHgwbC83d2l1MzYv?=
 =?utf-8?B?U3A1SFczUGFlUzhhM3FPaTNVWldMdWV3MFVKME9pVGxnOVB3dDRjVE55VEp0?=
 =?utf-8?B?MVZMUENtZUZCKzhKTGpjZHlSRjNOZjh6SGhFYUpoM1IzcFZYNUk4RGd0T0pR?=
 =?utf-8?Q?ygxxjK?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(82310400026)(376014)(36860700013)(34020700016)(13003099007)(12100799063);DIR:OUT;SFP:1501;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 14:28:49.7887
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6237334d-7798-4e4f-d0fe-08dde963de7a
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN3PEPF0000B069.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR19MB5673
X-Proofpoint-ORIG-GUID: AQODEoG37MwyjSefoui1tJimbIDF-YyS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAxMDE1MiBTYWx0ZWRfX1KtAUMPKIKdm
 sa/eXYm3nh3CWaXgeXncPgjK+tfwixKy5SAsv5npr+c6GCw83QVC3g5ATjDho9oBW9WhUSdt2xn
 1r+OQNb5gZbYMb6avb5g3suMPNLmoXtlP4PzDlTjCNdSio3DRIUnZegIFXsy9u5+waci3Oq7oyW
 26X7/3fy1JoDvqVDZh0D1fBKo4rsGdix0qPutofBA0OGzxJeUEPgoIa80jTHAoSkgUmCB0iMqou
 ZC1dNabh35VMcvpSwg3aop1Z9k/eajUocrzHQ1aelMkFLigKI3XTusBELdv82aoARY4NoT7T31t
 7ZJDJ9tu+armeMprSlvxZ9+qRU0ApeC9zUnaEANOvcVU3CMAQ+dMeuHE5kkxAU=
X-Authority-Analysis: v=2.4 cv=EvfSrTcA c=1 sm=1 tr=0 ts=68b5ada6 cx=c_pps
 a=7SohSp5xHxyTAXdpnyxtrQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=NEAV23lmAAAA:8 a=w1d2syhTAAAA:8 a=VwQbUJbxAAAA:8 a=GeY5Qraa08SNP0xblocA:9
 a=QEXdDO2ut3YA:10 a=jZz-an6Pvt0H8_Yc_ROU:22
X-Proofpoint-GUID: AQODEoG37MwyjSefoui1tJimbIDF-YyS
X-Proofpoint-Spam-Reason: safe

W=C2=A0dniu pon, 01.09.2025 o=C2=A0godzinie 16=E2=88=B605=E2=80=89+0200, u=
=C5=BCytkownik Takashi Iwai
napisa=C5=82:
> On Mon, 01 Sep 2025 09:57:46 +0200,
> Maciej Strozek wrote:
> >=20
> > Certain systems have CS42L43 DisCo that claims to conform to
> > version 0.6.28
> > but uses the function types from the 1.0 spec. Add a quirk as a
> > workaround.
> >=20
> > Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>
>=20
> It's a fix for the report below, right?
> =C2=A0 https://github.com/thesofproject/linux/issues/5515
> Then please put it to Link tag.=C2=A0 Also at best give Fixes tag if you
> can give some hint for the stable backports.
>=20
That's correct, will put the Link in v2, thanks.
Not sure however if Fixes tag is appropriate (not fixing a bug in a
kernel commit but in the ACPI after all) - maybe a=C2=A0"Cc:
stable@vger.kernel.org" is going to be enough?


>=20
> thanks,
>=20
> Takashi

--=20
Regards,
Maciej

