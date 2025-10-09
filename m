Return-Path: <linux-kernel+bounces-847099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B7BBC9DAD
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 17:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 36D2D4FB152
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 15:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94D621FF23;
	Thu,  9 Oct 2025 15:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="b6aWQh0E";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="qGfelXhf"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0432F21B9C5;
	Thu,  9 Oct 2025 15:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760024925; cv=fail; b=aNOIc85/9CsZPk6+eJ8Zno0MbenmI79B7DuzuIy2PqHj0mP3BLIfILSXtwb2YXDwucsYOD18lgZnWmy/lioWFXm2qc4DSvLe3HrhuhZQ2m1tON085tfSyBoIc2FQuL3ahAQSaQjMjRS3Ugj0O4OtQwNOmU3x/zNj4TMJjP24+Ec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760024925; c=relaxed/simple;
	bh=iyPa/k33ZrW3HeYhthgOpFGtO4b8zbm6A57xL8WUskQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HoKUYLIttBWU23jzoPhfJxzm7BGQw852CiV50CIgcAL9O7hFYcRa3fdHzhFcBSuPaJjkhBYerMz4ohxOmHUDDNDxNL8r4WUvB+0ZuAAQVcA4KrUvHLDWhIKAaJ95g6KZ7U48UznbIlSPdLf+Wpdec/e2wfXTXITjKFQdReXZPFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=b6aWQh0E; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=qGfelXhf; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5995QlKc2365794;
	Thu, 9 Oct 2025 10:48:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=Uu609+WNFUC/EiIrNYtQKg1R66DA5kFNhpmk4WQf110=; b=
	b6aWQh0EMDmTtMjdYV0JNZWg/Ip1KaGQbnoFzLulA8dh4X8WMesuaE8KevRH62f3
	4hnn8VZEMRj37b6VBaw0Do9hEmgzt0c5z+oaSHKjcNmoOLOHwil1GGYGc21B81kA
	3FWP+YWcAXL0fs+OOuRafMBnAFtlMCqqJdOHKfmsHLEymOOmPN7Vt/WJa8CtuEaK
	12wirnqzFchJEUR4geEOl+atljuOlpZQx54necAwEXpzn8vI9P3Mt0dIQp+W4/Xa
	tUZw3oN6SJQV2XXH2BKr3oF5DLh/Np8OJOCz5ClUGE19Wohvhuu5OENo5Wdrq2XS
	O4unlkeXJ1Y8W0tK2UW+KA==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11020117.outbound.protection.outlook.com [52.101.46.117])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 49nxqw91cf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 09 Oct 2025 10:48:37 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k2xa7L2nVXVQcThmwMR02oR7el5fKk/L+DAEmvRnYNch2KU+7V7id6sq2+DuuE8C8T507I9+t5qA1vGx1Vu4mjdVZ3oO05g8YX/yf8UEU9fBIuQ2YjmRgUjv3sk17comGHuAQUciK5oBpJDLfdEuKNGNakLHchly4U3/v9llrxLBcDF6dUJrC/RB0G3V9o3MQyIEcfwVpU4L6rZdbV9sWhgqaKdzc0hOEISCOGD1nyxU1Cd+Pg/PGNM+RyO0wIYpcnScCpZzxKgIX655n8yEKuf2P3zkbrZEVgIHdkb3krSuEVsDRIH0YttB5Fd0mwFwbziJJXVXTF5qPJ/VqJPR+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uu609+WNFUC/EiIrNYtQKg1R66DA5kFNhpmk4WQf110=;
 b=BsDr3p9tJNAzkph3MA3SGwb/nYkefjsAn8tO6STY7j++bpkvYcKZCtxowvklAmxbjivl0E8Dvp4q1rMzIcIB3F/A65/tTrRW8Hu5X24bbaU7FNt18W6XUJnr1FmSPbAjP9QipgSLHogRIGNCq9fpTDulEAKN0Y3jlu2XSe0tkZAerkaKAHkgXNQ2mIJB7CdB2ak8wNCVCUuTskz4TiVmjGhs1c1l/baaC+IrIA1hbfQr3mx6pgSH/PgmKgEaCCTWs54D02t2VN5fxMsuH12iSoUFBiGmKHC9WwwFLlby3Dss6eSZIqfK6GvQsomHUIoCF6tV74yNg9Ku2JKiCCnL8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=gmail.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uu609+WNFUC/EiIrNYtQKg1R66DA5kFNhpmk4WQf110=;
 b=qGfelXhf6nM1GjGxMwymsAiKrJNffwxCxAo9+MLG/cO698B9hHUwJa8dfouxPbIbuVmXo0K5Ub6WP/PI/Ny1W6hXb/om2wl+Fsvhm2CHcdPXSJBjyB3n+oFoR97as1gNSzFOryVraAEOue8Piy7yKazRRH9oJ7br+Z98rDHASTw=
Received: from BN0PR03CA0052.namprd03.prod.outlook.com (2603:10b6:408:e7::27)
 by SA0PR19MB4507.namprd19.prod.outlook.com (2603:10b6:806:c0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Thu, 9 Oct
 2025 15:48:35 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:408:e7:cafe::63) by BN0PR03CA0052.outlook.office365.com
 (2603:10b6:408:e7::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Thu,
 9 Oct 2025 15:48:35 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9
 via Frontend Transport; Thu, 9 Oct 2025 15:48:34 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 1A1C4406540;
	Thu,  9 Oct 2025 15:48:33 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 062B0820244;
	Thu,  9 Oct 2025 15:48:33 +0000 (UTC)
Date: Thu, 9 Oct 2025 16:48:31 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Sune Brian <briansune@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] ASoC: wm8978: add missing BCLK divider setup
Message-ID: <aOfZT5cFKAI+I9g9@opensource.cirrus.com>
References: <20251008205207.1781-1-briansune@gmail.com>
 <aOd9yUj9H4L4fbtc@opensource.cirrus.com>
 <CAN7C2SBd8tDXG8OkjRt0sDw1OmtrLgtuStEfr=f=JHZMRvjq9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN7C2SBd8tDXG8OkjRt0sDw1OmtrLgtuStEfr=f=JHZMRvjq9w@mail.gmail.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|SA0PR19MB4507:EE_
X-MS-Office365-Filtering-Correlation-Id: 6710c346-c4c6-481a-1e4c-08de074b4e18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|61400799027|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NXphU0ZQR0RBWHRkZXNhWmE1YmdKcjhYWXJOKzd0czB1M2N5V2NtNUNqdmRv?=
 =?utf-8?B?NVB2cXRaOGNYdzlnQjczM3hQWW9wVmlydjlETm4yR1lScWM5TmFtR2JFRnpa?=
 =?utf-8?B?YjJhQS9DY1dhZFZxWGJBdWZHOEp3YXBwcGo0TXRIc0hiVTFKdGM5RTIvY1RB?=
 =?utf-8?B?a0lyV0hNQzRVdUphWFh1M2lBdWt3Rk5qYlV2RE9MSytiM3NuUE9aUXNKczk4?=
 =?utf-8?B?cmY5R1FVYkRUckZKSmZTdi91MUtZY2xLcW05QlRQSjBoc3JKV216b2E2WWpV?=
 =?utf-8?B?NDQxUjBrTjdpM1VrTUh0NjB2dlFwd0VHNHVHeXh4SDlsa1J5cTBidU9zdFky?=
 =?utf-8?B?eHZvc3oyVGpsSkJtUFZ2bEc2TjJUVmZKSTdnSnQ2U0xmai9KTFhscS9OOHRn?=
 =?utf-8?B?RHJJcFN2VEdyR3BWNGhHZ2RBa21hdWt5MnEwNzBRbno1ejVJMWFrU2s2N0pV?=
 =?utf-8?B?Z2tKellGdmk1T21qbExVTXZHeS9lWUQvN0ppenlwNnlnTEwwZWEwalc2Yjd4?=
 =?utf-8?B?L2xiZ0w5S1JnTmhRMXdxbjJoNy9sZ29SaVBxNEJ2d3dpY0ptV0xqQ0dzQ2V2?=
 =?utf-8?B?cmhkcHVMelFsckVPMGpHS0pkMGtncExsS1ozbE0wUytac003YmpzNUw2aURM?=
 =?utf-8?B?WFRPK3lIZkdxSlNKb1hObXRxN3lYR0ZZUEtNMWJ6Zk5oSjhhWHlFMi9KRUJy?=
 =?utf-8?B?TFR3U0dsakxnZUE1SGJCcWR3NDIwNHpXTjZkZW95NGxQMDFoeS92R0ltY01r?=
 =?utf-8?B?amRHMFh0dGszT3JIR2JLS2VwTGw2L05pZWk1R2t4bVRTVWJFSnExQ0FwZVRJ?=
 =?utf-8?B?MGJKNXJZaU96akRzaDlUNXdvd1FPSUN6SUc5bFV0NmlFTnA2RmF6Q0o4ZFRu?=
 =?utf-8?B?K0hSNE1XaW9yZEUxUnYySjhBaHlHNjg0T3o5NlJkTUhQVWZmV1R3djlRSWVu?=
 =?utf-8?B?U3pYODQrdnNkRFFHbXR6UGY1L0I2NGtLWVZBa0U2dWxoemNlQ3U2S0xRbm1S?=
 =?utf-8?B?UUdBTWh2RkdNd0c1ZVE5VVZMYitycWFZZkRMR243VGNoS2hqR09Ja3pZMmdH?=
 =?utf-8?B?alEzSzB6N01lK1QvKytXbmxxL1BiRER3bnJGbXFCczN4K05iZ3NkNUVpZFFS?=
 =?utf-8?B?OXlpOUFKWGxjbXhYbFY3T2liU2lZZ2o0d0J1c1FPNjJOV3gvQmRpTjN4blRK?=
 =?utf-8?B?UE1NYjZWMW4rcnJMUVp5VEl0Ryt0NEZ2QjRMSzNuMjlNOHlsV01NM2pvWkhj?=
 =?utf-8?B?TUt1enBmMUtSMUpBejJ0bityeUt3UldPdFh1T0xidlFTV2o5eGVlTU1QVCtr?=
 =?utf-8?B?SDdMaWlhYXdYOEl5S1ZqQ3Ercy9NUHhpZ3VSNE1BRHFaTnFlbEpqK3VyRDMv?=
 =?utf-8?B?RXRRODhhMkVSUHBtNGFld0lSMXlseDR3clRJcFh6TW84cFlCNTdJam44Qkpt?=
 =?utf-8?B?T1d0Z3dZV1RlTmk1ZHpITGpUSGgwcFJMRWVwRkZlRE9UNG1ycS9xTHVMbGFS?=
 =?utf-8?B?YU8yU0h4K2s1OHlndWVKVUlZRVdpSW51WWJNOXArZEJKRUJNZktrWVhsSzRr?=
 =?utf-8?B?S2FGelQzMWdldyt2OXpsNWU4Mkw4azh5aVovRUFrN1FyM1F2TFpFSEtuMmha?=
 =?utf-8?B?RzNkVmI0VWZMZ3lzMXhLNTgyWmorMHVaM0EwNzhVeGVTVFBNS0lSak1GRVVL?=
 =?utf-8?B?U3BWVFRWc242S00wR3ZoVzFHYTdMRE91YkQveG1mb0JWQXBCdWY3MVR5NnN1?=
 =?utf-8?B?OXY1dGF2dG9RVzAxV05vYXhvUVdWRTJ3ODcyZVM0bk1vVXRTK3dBSFMwaERT?=
 =?utf-8?B?RDFJSVVHcmtDKzloQ2IyaVpxenJQaXQrbloyT2RtUTQ1OUtkMUc2NWl4VWZz?=
 =?utf-8?B?SFdFLzQyZmdjNDR1WnpOb3B1QzViWTB0QmZRRlVUaHoxTGd4c25RYkkxdlpV?=
 =?utf-8?B?Q2t4OUZweEs5NitOME15MjhGVGNRQzlFcGVJeE13UkREc1RLT0FvKzhrRmlG?=
 =?utf-8?B?ZjZGblNGdHBicGRDb0R3cERRVlJMb0pCNFR4ekdqRXMzNFFOR293dnB2elpN?=
 =?utf-8?B?ZjV4bFI3bGdQcE9aT1ZBYnIxUzhCRmV6d1Fmc2FLVkQySHZtQzlTVzA4cEFo?=
 =?utf-8?Q?2CRk=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(61400799027)(82310400026)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 15:48:34.5194
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6710c346-c4c6-481a-1e4c-08de074b4e18
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR19MB4507
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA5MDA5NSBTYWx0ZWRfX+04dSMXjW8K/
 MMdH2i5Kbvojr/ka9Jiv2SNY/DpWa2xzAYXvmJ9nRc9LScejlNl/JzGzy//8LYhl1n6S18w6GLC
 3duFHxOnNx8X6a8vIevgfyEbxH90oVUiWHJO/Odx+QAJNcogrD8Tl+UB5Z9U9YJVfx76Pv7Nd3v
 vHKgBX0NcMDRwvY3jViWwezjNYtSljYtSQcGn1rf6IAk07+sELzp4WikiFGJxhzpNPgC28m9U4b
 69bhmSDPdr/6hSY3Sig7Am7++ZXukHK7rmT8ptzF3sQ5Z3QxgkZsTd1u7iZzkimUW1qX2GUNASc
 hihC3ZYZmLVuYVwFtjZY1K6/JTdihwi++WJrXjaQruxUx0vAViVVR7uZmrCy6hFBlB5MjrvPv5F
 gFACQVcxR4FGJIhPvUEM+RoXm2VbeQ==
X-Authority-Analysis: v=2.4 cv=HoR72kTS c=1 sm=1 tr=0 ts=68e7d955 cx=c_pps
 a=RrdOQlmmxp+bQeXV/0G7LQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=w1d2syhTAAAA:8 a=gXCJij4LrfL9Ut-YupoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: liwrGuoJcAFxA0dDynlpCgy6QHKuPzR3
X-Proofpoint-ORIG-GUID: liwrGuoJcAFxA0dDynlpCgy6QHKuPzR3
X-Proofpoint-Spam-Reason: safe

On Thu, Oct 09, 2025 at 11:02:57PM +0800, Sune Brian wrote:
> Charles Keepax <ckeepax@opensource.cirrus.com> 於 2025年10月9日 週四 下午5:18寫道：
> 
> > Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> >
> > Thanks,
> > Charles
> 
> Any documentations are required?
> i.e. .rst file or similar?

No, no need here really. The codec itself doesn't have any docs
at the moment and its too specific for the more general docs. And
besides the change is mostly just bringing things more inline
with other similar devices.

Thanks,
Charles

