Return-Path: <linux-kernel+bounces-844218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE14DBC152D
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 14:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 894BB3C68A8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 12:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3486D2DF130;
	Tue,  7 Oct 2025 12:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="BUOjRIXR";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="VslyByuM"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515922DF153;
	Tue,  7 Oct 2025 12:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759839106; cv=fail; b=ZwgRP7Wqh3irHknHQuqf2lenTKFPbCS9whEu+qH1P0ZPXrWv1+8lJ67PqQ141+V9HL+4f0DKQD2ygf07qsxXKgc7nbu9+JnDmjsQM4BJQF6KdefddGb4WViZ7kK+BKjqeNeDtXOlBrergmf+yAh7bzzRGJpY39r3EbSMUCjvbGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759839106; c=relaxed/simple;
	bh=CXc4Aqw2yz53lhuTjxZQFB+B1cZESgC01mZB9R4KXWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RfwiHoLV6gjpPmaueHioKCmlYpcLpzBUYFucPwaZE2W8tGcWq++83+bEi8AbwHIcUSncgJD12oDOPSgzB1TJRP2/jxrujFHofbqg89SjZpk2JBHebK5eY3ONsJenAQ3s0S/rtBnqswFmCP2mMeY5xw9tkDeFM+hZIFGrFFKZRrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=BUOjRIXR; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=VslyByuM; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5975PAVK1436714;
	Tue, 7 Oct 2025 07:11:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=P5hsjB9D+NSjOxgu2N2rzQkgiZoOJLgYnt2kl+p97TQ=; b=
	BUOjRIXRNgGwmJV5lgel2sSTqp6hoCRQ7TLoNb3GZ40R7lMgAPSUypHHU987SRoV
	pOPNSEe2lidh/EbAPuLMhOjD3MUszO0ey8ozISZZitLOfBxFLsFwVad1C/fzs8BL
	XTmnuLfx+Q71Y9LZ0Z89kXqQPo2z6P6QhgJz1AZ6mE/O6S9TRNGu/AWZxB3IYOJg
	o0DR5FzAOUXB3HkgIt6NylMNQa72KotEtU8bqmYD+az3pNBJ4Aakgz+7mKBXiW4b
	I4e84E+EtwCG3GdPtZRiPkSYjxAC041FgSbsPdHwZU+cCM/h0xsMdmkLqtRBPR4C
	xvrC5Lhzp+6ISzBviXPk0Q==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11020091.outbound.protection.outlook.com [52.101.46.91])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 49ktb7a10b-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 07 Oct 2025 07:11:30 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KcieEgqnqpueMO5ITykPsED1sJAJ9dbaOkSTYq1lDnAMw/yQlqtSZDftrRAkZ9AwGAZk7hLgXUWEBXj9Vkcrslu4b+/7OGIlLhf+bvtLq/gb9f4wlbwWy70itj6GI9KivJMNrUUt1/ePvbgt7gLfBtVEUZJv7jEVh6eTnwhjTptM0g1ZLHmYV0bSc9XUA9gnuf4aUkpU8xQjIZqjn+e/456pnYVnpc6sXGJu+aLyMnr8CqmjWLN9ijEqDWXjGFB8NRueBd3odf/uBCn3ihB5KtsxuIVx+72MCUF7HMGmTIe6QxVr7aGBlA9Occ5THVRebqRn1Rrl0BgEGU07z1IByA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P5hsjB9D+NSjOxgu2N2rzQkgiZoOJLgYnt2kl+p97TQ=;
 b=SaSOldUQIuIaOQQKVclBLteXOBboLDCbfdVVfsu7fhLnCW3noqCiHWFjbS5maNcSo2WhjtimOon5KL6TWY6pQKaS5WE5jpqFUmrsgMxqAZ0vNZq0COapUoxCXEGUKAiNFsurXXkaO/Psent4A2sf+88jt0tIMvGamIB+qPZEVlcRO/5trqnogyFxdH0y43tTrk2eywAKwyfUsTR/q6uN/gfZwK3lEbQ94O7ub6h/Fk75f8TaqC1zJDLsvKr/qmYm68zrSWBlNf0jfJS6FYf+2+HU/If/Ngv7uajrUQ9LrIUIRIUsZzinDuHAU29tQmScJgZfs/92A0gxobNc8SGl6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=gmail.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5hsjB9D+NSjOxgu2N2rzQkgiZoOJLgYnt2kl+p97TQ=;
 b=VslyByuM2k65srcq34FguIqWJRtngT0gBuJJY93kh8OPk69VQ5WO/pAshJI0/+lfP6zkXgVE6d3a/jLEmUOrlXSbdRC7/yUOYwCIZWo0xXFfdina8HjPr4kyMLJthAf6tNELXLS1EosU+vhMGTB6Ypou3VZr2vIKEX5HgiGd6eI=
Received: from BL1PR13CA0290.namprd13.prod.outlook.com (2603:10b6:208:2bc::25)
 by CH3PR19MB8034.namprd19.prod.outlook.com (2603:10b6:610:175::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 12:11:27 +0000
Received: from BN1PEPF00004682.namprd03.prod.outlook.com
 (2603:10b6:208:2bc:cafe::e4) by BL1PR13CA0290.outlook.office365.com
 (2603:10b6:208:2bc::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9 via Frontend Transport; Tue, 7
 Oct 2025 12:11:05 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BN1PEPF00004682.mail.protection.outlook.com (10.167.243.88) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9
 via Frontend Transport; Tue, 7 Oct 2025 12:11:26 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 8CE2B406540;
	Tue,  7 Oct 2025 12:11:25 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 79A49820244;
	Tue,  7 Oct 2025 12:11:25 +0000 (UTC)
Date: Tue, 7 Oct 2025 13:11:24 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Sune Brian <briansune@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sound/soc/codecs/wm8978: add missing BCLK divider setup
Message-ID: <aOUDbF/i4+9PXc1j@opensource.cirrus.com>
References: <20251003091304.3686-1-briansune@gmail.com>
 <aOTrsYllMst3oR03@opensource.cirrus.com>
 <CAN7C2SB5Re35yGYsqr14hGXde3nTKLX2Aa3ZbuJ9xuT0m07uxg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN7C2SB5Re35yGYsqr14hGXde3nTKLX2Aa3ZbuJ9xuT0m07uxg@mail.gmail.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004682:EE_|CH3PR19MB8034:EE_
X-MS-Office365-Filtering-Correlation-Id: 600f3647-2c0e-4065-447d-08de059aa3ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|61400799027|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Zkl3bXRNRVArRjRSTWowUDY0d3lHNlVYQnNyOFIxOE1qc3krenZqaGttekF5?=
 =?utf-8?B?TVhGZU10VzJSRzVOc3lZbllPOHBQaFZDTGF5SXN4elJMQlJpd1d6OTVNUkxX?=
 =?utf-8?B?dEl0a3VhVms3UjZVL3ZzbHRnUi9LY1lqRzNKa3RYelJWZEMwK3NoVGxxT1RM?=
 =?utf-8?B?eG9TWURMUWp2ajFva0wxYzVHbzA3alRud2dibWpSV0FxazZEZXZrcHFMRHJ3?=
 =?utf-8?B?N0pYUGtUWkcvU1ZPM1pzYThlT3UvMGxKazN3cXArNEpFQXJQTTVqZFF5M2Jw?=
 =?utf-8?B?UThZS2daSjZvZWM3b1ZaU0RYVlJhYnlxelJ3ajl3bWVsOUhCUWkxNGd6WSta?=
 =?utf-8?B?cElZQWZ6UHdLUGdzb3FDcXFxbUNwSUJ2UEw0VHVKTS9zUWYwSm91QUpjOEVL?=
 =?utf-8?B?WFdwRjQ1SzRGODlYdStjek1DRFVTMHlqZXBDLzRwYmxKcUJuMVdqRzZWTzNz?=
 =?utf-8?B?RTJBUlNOaUxoN3pkSDVXT3lNMmVEeHJGS1VFK1hGV0RhcjM3ZzBYNzBQMStK?=
 =?utf-8?B?R1lORTY3OTRnNHZNanoyVnVVb0lna2YvWE9MN3dSRkJRT2xONHJPTG45YXVm?=
 =?utf-8?B?R2VTbnB6NDJvRkNJeGE3Z0RrNmJmRFlNYk1jSXpydk04VXl1NWlXOTVQVXRT?=
 =?utf-8?B?UWQ3ak5SV3BFbzRiMHZXUWQ3TTIvcXMxdkpnYUE4SGRiYk5XVDd2aWUzdlhZ?=
 =?utf-8?B?cWYvaXIzVTg2U1dGY2d4dE1IUjdvNkl6dFpHbmd1UXNHZmkrRnppOGpKZGo3?=
 =?utf-8?B?MVNiN1A0SHpPWWxwSEdwbVRSaDRCTmw0OCtNMFVRQ1pNbGN6M012N0dVSHJH?=
 =?utf-8?B?czM1akJNMzhZVlZIZktla3VOcUNxczZQN20zM0orSmszVmFySXBTaHhQUzQz?=
 =?utf-8?B?eFdtUUoxMElaMTdTM3BUcXIySnJXQXpEeGJnSGpaN1NKd2ZTZWxUQ0pnM0N1?=
 =?utf-8?B?TEtTZGZseDBGbEo3OWc0VGRJT3A3N3JTeUhoZDNqbUZ4R051clQ0anozbTdN?=
 =?utf-8?B?SURUKzJKazhxSFhUSDdkSUFSS2dpSVo5akZIRVlRQ3YyR2tOdmF6MUZVN0RW?=
 =?utf-8?B?T25WU0dTRHU5bkJKQTkxQTNQMUVzZGE5RzQwTXdpMFRrN3QwWDhtcGNDK2U0?=
 =?utf-8?B?d1QvbGZSb0oyRnF1N2dYTm9lT0F3TWtKM3haL1FqTndnZmFsU2pkUjFnSTdu?=
 =?utf-8?B?S01TYUYxN1llaTNETlJVeXI3RWlYSS9wTndycE16SXVqYVE2T3hZT1Z4Q3Bp?=
 =?utf-8?B?dWltUER3VnlxbldrOFB2TUJZc1hNcE5tMVpOQTlNQ1lCeTArdUxneWg0RmFB?=
 =?utf-8?B?RkZQWHhMOUZaK3NHWkkvZXpUeHV0cWxtSDVwTGNOQWlhb2lQUjBpKzZYelhM?=
 =?utf-8?B?Q2MwMm1GNXRHVnFxdE9iNjZpeVN0ZEwrMlNpSmxUSUdiUTY5Yk44NTMvOHZX?=
 =?utf-8?B?MkQydkdMTDhxUUsyNmpRd1ZIVGtoRFRCcUZRWlRBeVV0K1FrbjlkS3QwYVd4?=
 =?utf-8?B?dVlvTkpRaXE3SmsrTCtTUlNBMDA0d09tWWl4cW1mL2QzMm0wN1RQOEdubjE4?=
 =?utf-8?B?M1AveGgzQXliOWYxeVVVRVZwcjVTOVRoTXcwUFh4S2VRc0NVYURmc2Z2V3U3?=
 =?utf-8?B?Y1lDaUhkZG1NV2trcVlLcE9rUXp5Y1dYcVFpM095Qks5MDJ0ZFRKRU9HWkhB?=
 =?utf-8?B?UFZYczFReXJNQ2hpVjNKUEhUUkh0Z2dZL3BsWFR3YlhBN1cvdUpUVUc4MEVS?=
 =?utf-8?B?OVl1QXNwdVgrV2hjbXpheHBSRERLVFBaK2U3MEdHa1diNWVUYitGM1p2V1N0?=
 =?utf-8?B?YVRFbzZWbTQrbU9lOFp6Mm5lNkhlelVvVkthTDJCZk9VaDZqWG9vOTMveXRu?=
 =?utf-8?B?N1N1TytBRHl5Q3VxSTF1SU5VeHhqcVhXTTQ5R1g5UGljMWo0bFUrdVFoSmY3?=
 =?utf-8?B?RHhvL0h0elhUTDAwVHJyZjJMRG9peVF3UkorTTBkTUxhYW1zc2ZQbFhHWjZr?=
 =?utf-8?B?L0NaK2R2ckpKUlhadTVDQWcyQ2o0UEZQck5KRUxPRGs0dEhpSUJBNHV0R2xj?=
 =?utf-8?B?TVlVN1RFVTFNR3VNMEhtaGNGRUlRUmh3amdKcDk3M0wvRUdrVnVBRTIxZnFr?=
 =?utf-8?Q?G+is=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(61400799027)(36860700013)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 12:11:26.4517
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 600f3647-2c0e-4065-447d-08de059aa3ef
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN1PEPF00004682.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR19MB8034
X-Proofpoint-ORIG-GUID: wL0J7trw9ca-R4AfBZwvjIBFQnYrNlQ7
X-Proofpoint-GUID: wL0J7trw9ca-R4AfBZwvjIBFQnYrNlQ7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA3MDA5NyBTYWx0ZWRfX3messJ2xMFI4
 xcb6RJG4e7trTdlrS9Aei3oUQCmtcgUY8BPzNJiFpl4MfO93obycqN3rO45kRUyLMuEwCrAE2ki
 mEF44uHJm7wMA0qfzrUZXl5lNh/x91cculZUgrIcln18+LjEZxeOliQU90t22AxkXAYK4O85+Lb
 FxOMdD02oU2Yrpe/eZxXFulohdysvZ+MLbsIvuZ5GSSnIDFzCTIlWYOZbbBtJU9aONss4hIggKb
 I+Ob0tqAK8J5VvpfWfqsnnuQQpiN1xyC1Xdxqa8A4RsKqKYf4oOieNz1wi1kIKBN9e4b/TKWSv7
 5aJhsBAH1X71ouHZ2orV5Z2VFFUZ4lFreiKNhpelv1FqCtagcsaNYCXJUuoImg97kY/jds+JyU4
 /U6P0bqfiD1vKPM7/HSmddGo2WjZwg==
X-Authority-Analysis: v=2.4 cv=ePceTXp1 c=1 sm=1 tr=0 ts=68e50372 cx=c_pps
 a=5g1Slaqcz6OQozqf5DRlqw==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=w1d2syhTAAAA:8 a=AxrGpO7ZFrR7dZ43Va4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Reason: safe

On Tue, Oct 07, 2025 at 07:22:10PM +0800, Sune Brian wrote:
> Charles Keepax <ckeepax@opensource.cirrus.com> 於 2025年10月7日 週二 下午6:30寫道：
> > On Fri, Oct 03, 2025 at 05:13:04PM +0800, Brian Sune wrote:
> > > The original WM8978 codec driver did not set the BCLK (bit clock)
> > > divider, which can cause audio clocks to be incorrect or unstable
> > > depending on the sample rate and word length.
> >
> > This isn't totally accurate, the driver expects it will be set
> > through the set_clkdiv callback. Which one could probably argue
> > is a bit of a more legacy approach, but probably worth calling
> > that out here.
> 
> According to actual hardware tests and the WM8978 driver study.
> There are no bclk register setup in the entire driver. So I am not sure
> How could this even set through the callback? The IC itself requires
> 2-wires register load and this can't be done via software level.

/*
 * Configure WM8978 clock dividers.
 */
static int wm8978_set_dai_clkdiv(struct snd_soc_dai *codec_dai,
				 int div_id, int div)
{
	struct snd_soc_component *component = codec_dai->component;
	struct wm8978_priv *wm8978 = snd_soc_component_get_drvdata(component);
	int ret = 0;

	switch (div_id) {
	case WM8978_OPCLKRATE:
		...
	case WM8978_BCLKDIV:
		if (div & ~0x1c)
			return -EINVAL;
		snd_soc_component_update_bits(component, WM8978_CLOCKING, 0x1c, div); <<---- HERE
		break;
	default:
		return -EINVAL;
	}

	dev_dbg(component->dev, "%s: ID %d, value %u\n", __func__, div_id, div);

	return ret;
}

Its not missing its right there. That said your way is probably
slightly more standard these days, but we should take care of the
interaction between the two.

Thanks,
Charles

