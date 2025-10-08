Return-Path: <linux-kernel+bounces-845948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56144BC68E7
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 22:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39C12189F77A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 20:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B4C2BE05E;
	Wed,  8 Oct 2025 20:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="hkXWGqd+";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="gFxZJqfu"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C306277CBC;
	Wed,  8 Oct 2025 20:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759954720; cv=fail; b=HJlhoZE2Wz2yuoMr8vIorv5dnaFodXNnyMNx4KCcAQH+y9RC3mqrkHH0d/Oti5ORaxvt19OAa2Hn8PjTuJ64f7k6FAzX/B74x+axW3UZpD7GI+NyhUirK9et3QNGIgaSnGu0hVoa4SIu95oHdJ5A2opcZ4UQtG54iy+csUEP5Co=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759954720; c=relaxed/simple;
	bh=sV7IF+Rumqm8Jk52XmQiFLNahiwmCJLyaXfWKkJLCkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A96df13ATqSDn1WqMOW12+Koh/ehJ32a9PETDYsGCtsXlDLfv7A+psI3gvFL5vbWv7yEHubTfxK9JxyQVbjHOvaY/CglF3aqfr/b9WL2qjye8QDq006AxvCAKnJavQMnBFL5UUCdB8vG7394MbqlUncMa5CkZztsCjiBizjIxm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=hkXWGqd+; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=gFxZJqfu; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 598JMiKA1855009;
	Wed, 8 Oct 2025 15:18:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=WO+ePohSrKI0d6jq7vz/OLdE811ChE96OLr3wJ7PD20=; b=
	hkXWGqd+bNfrBqD5x4LFhaW/U785HQBAhBhPbTm02XMhDY7d+wtBR9gDtHDs9coR
	s8lDILV/Irv9oXeyiTzPPb6+gnxo/cpl2H6T7ovPGHVWo1HoMe400MtgJG+f/0SW
	1ocxc8fPIoByCL+tt/DEZhV1l6iUJGWt5ySCukJYwy8jm4DlRsim7pahum4BAQOK
	Wp6bL0SrNjKVIuL7fzB8hUDnAl+OHXojD72e8SoW2gdFjPDmjXEE6yZsIvRcV5s2
	HKuIjDaH0/kB5wlCsC6F7Xgprt/w4g3sF/yqAkNhACit6Qcfna5fOySZg5n/uCk/
	bfuKXBNK7rdGEPy191SiJA==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11020113.outbound.protection.outlook.com [40.93.198.113])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 49nx2e81nt-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 08 Oct 2025 15:18:31 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MumGX7X9p4hj8XVEgXSZHLSUHytrwr3IXhwt8l+pCeAFjEP7eXcps78dlJRTycRuD496/i0bEyU46jkU9rq9F2fzzcexFYPmiy5UFqHKBBCDFs6FKdH3Ktjw03SrLSa2lS0T4ufSTMv1W5BDy1YHYZ4NPIOJwWMBU93d7M+2zJVq4s0Jl333VniBZbuIrhbaDNXlQd81kAI9QteiMTMMOddFo0W/XcweCJc1qjkS5aSHyhraa0xEpe0YG3uv8qauZeLCrWbQX9P9LRSQUv3QxKXAuuHczoxIzFthLb6gRMi/2afs5c5nagNSnhRfk6aL1smycK2kouWzVBNXPLMmKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WO+ePohSrKI0d6jq7vz/OLdE811ChE96OLr3wJ7PD20=;
 b=v8/ziUOiSMsaM8EShVmCwXQFb61OupeoxxuG84o5DYOakjpaCSMIpPgWcrEuLBwmm+iSWW+zQo6PtFyt2yy/7gYW2+O/ShhqGKPShiMBgoSuu5Rx4/Qey2vkH/s9BXBzljHMFCDI1DfeINUxasMdX3uSxdxsjPqSz8tjaHDKcC/4bOhGXVeJ396mm0A4byrht7oEner9wNzYlkwCYcBZHabqsuyw/kq+VofK/uCE3kPeUL6DR+XKEhFF/pwS+Mk0e4ZrfIg7ul/iB+aa4+Tp90JOzBrwqtN2X8imGygRPVgHknYiQLmDGhldaUkI6cIdnlVjNbaEbKl5/rXerzY4cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=gmail.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WO+ePohSrKI0d6jq7vz/OLdE811ChE96OLr3wJ7PD20=;
 b=gFxZJqfuZHJke5OrQuSqv11FDsapRJMhFvL8XhDv1DOXlXI4CDBMuwo6fY/N0CMthAoaal2N7+h6QRxbB/c/48QEkGSBuUG8SwRmiJ14V0vQuVU/W9Mbn/kBY7u2tyqX2Bkb/g/xjXMFcjidzmM+/iaMTcbgjLCd99tZYg0n3A8=
Received: from BLAPR03CA0174.namprd03.prod.outlook.com (2603:10b6:208:32f::11)
 by LV8PR19MB8653.namprd19.prod.outlook.com (2603:10b6:408:25d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 20:18:22 +0000
Received: from MN1PEPF0000ECDB.namprd02.prod.outlook.com
 (2603:10b6:208:32f:cafe::37) by BLAPR03CA0174.outlook.office365.com
 (2603:10b6:208:32f::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9 via Frontend Transport; Wed, 8
 Oct 2025 20:18:13 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 MN1PEPF0000ECDB.mail.protection.outlook.com (10.167.242.139) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9
 via Frontend Transport; Wed, 8 Oct 2025 20:18:20 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id A884A406540;
	Wed,  8 Oct 2025 20:18:19 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 9471D820244;
	Wed,  8 Oct 2025 20:18:19 +0000 (UTC)
Date: Wed, 8 Oct 2025 21:18:18 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Sune Brian <briansune@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] ASoC: wm8978: add missing BCLK divider setup
Message-ID: <aObHCq6JAHbtTJZ8@opensource.cirrus.com>
References: <20251008162719.1829-1-briansune@gmail.com>
 <aOacZAiWxG9XfWLS@opensource.cirrus.com>
 <CAN7C2SCDNz5TB3deVziuNNYFnPV_hmrsPL1k-j5Dsj58wvC2rw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN7C2SCDNz5TB3deVziuNNYFnPV_hmrsPL1k-j5Dsj58wvC2rw@mail.gmail.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDB:EE_|LV8PR19MB8653:EE_
X-MS-Office365-Filtering-Correlation-Id: b3f8e032-09d9-46b3-0ef0-08de06a7d382
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|61400799027|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OG9LUjhJY05HSVhwOXdHUGhFemIwaHBJNzlLUGFERU5MOWc1OE5pTXQzclhH?=
 =?utf-8?B?MG44ZDMwaGtDOFl1OWhYVzRicGZJdEZEZXVjMmxRZ2t4NitDdGkvRHhOUFNk?=
 =?utf-8?B?ekczTzRVY3hCZFdrdFcwUkFnZ2g4K2lMMm1weFRtWlFZck9rcTdyZXFlS08x?=
 =?utf-8?B?RWlvTVVjNkdJL05MMTM4d2w2UGZtSWhaSjhtR05PQXhaZHNBSGRFVjh3SzMx?=
 =?utf-8?B?OEtTcHlWeVpXNDgxT2JOUFVCQ2hkQm90R1VIbTc4dVNrbGFBK3BtT2hXQlBL?=
 =?utf-8?B?eTVTSERIMitKWmg4U2NLcnpjNmVtOEtvOEdKaTAzZXlCYWZDc0FjZmd5NVlF?=
 =?utf-8?B?UEVYeWxud25yVkw5UmdaTUU1THV5TmxibHJHc0hjV1JDb1hlMG1zeS9hUFp5?=
 =?utf-8?B?c0xKUlRTR2haQXd2M0hrVEllWVZNdTVpVjJKRnFwVGJYVjd4TGtDRXYvRkpp?=
 =?utf-8?B?SzcxNG4wQVo5cG1RVzJWNno5N1hjdnV0YllHMjEvdVUyZ3VpbUJJQjhyem1i?=
 =?utf-8?B?bk5TT3ZDMkJOa1RLNFlsaWUxZElpSGs3UENEN0NjbHFLUGhCVjBmNGZ3Nm54?=
 =?utf-8?B?Skl5cjRXSW44djh2VWk3Tjd2WUltRGxMc21kTjJ5dmxSTGtvb0llbGNDWW1n?=
 =?utf-8?B?NlF5OEVhQ1l0Wlg3TlM1K2JsbHAyOHhNOFIzYjc2SFN2SG5zSFBnVlpuSTgw?=
 =?utf-8?B?cnA3T1RNUjJ0MHFTbTB3Q2FMZnVmVk0rYVg4SGNNc0pQcG5VMHR2dTZhMTVP?=
 =?utf-8?B?ZTFkWlpPYSthbUZHTVZ4ZTZDd1Izc3VkckZob0lyUzBNUGFxZlZvd012dHg0?=
 =?utf-8?B?dTcrOVNqYTF3alNCREt4RGRFY0Njbk9UZXBhTmhUeFNMNmtKcVAvVzJoTG4r?=
 =?utf-8?B?NlluMGtkbUhiY1B0bFNXQ0puOUNVV2hrcFU3VEpkeXdNWGhUY3ljY0l0aEpp?=
 =?utf-8?B?a0tLR2NCVmtGR1ZleGhDRTdQUE9DVnJDRldxV0twUTYzdU5FK3c5czdnRVR1?=
 =?utf-8?B?ZVU2K2o0Y3NySzgyeVN2U0NlYUo4TXFsYnpsS2RvWG8vNDhVZVVqdHIzc2JT?=
 =?utf-8?B?WHFJWFl0emhBL1V4SzdzUkh6d2oyU0RGVk9WYUVZUkM0anJ5RWhLVDlYTWxi?=
 =?utf-8?B?Mm5CQ3lLV3h0TkZ4R0tkdjVjVXhYQ0RIY3RBWHBxaHJRUHp5Q3J3SU1mOFdz?=
 =?utf-8?B?aG5HZ0ZrU2RuYjVQbk5MS3Fua1M4Y2R2RkUvVDcvaGtIcWlYOWp0bTY1dWkv?=
 =?utf-8?B?T0F3dkg4Qk5seGNjc25aZkhOaEVpTm5EMXppckFkQWpneDN4d042RjVFWHVv?=
 =?utf-8?B?TFNta0ExN3hlMmZkM3lRQW9YZnhlNkkyS2VXSzVTblVDdHk2M2F1eWs4KytX?=
 =?utf-8?B?SUh1OVArNGg1M0xrSUEyQlY4Qkdic1lDMzZpWXkwbm5JaDNUYWx6MEQ5S3gw?=
 =?utf-8?B?Ry9zeEVoMkNRL2Y5N0NTNEhtRktlRzVzMWNvUUt0SldQb3ZrNmlHc2RZaVU1?=
 =?utf-8?B?WVNCT0hibnF5UytKRTMzWWhBdlZMSVpHaXFacHRnd0U0M0ZKWEFUc2E1YVM5?=
 =?utf-8?B?WXRHQ1RuYnlqNjNBQjF0cFRMdktNVmpENlBCa1N4WXlOVEtjMDhNTFcwQkpG?=
 =?utf-8?B?cUlUdW1NOTU4dU1mU2grRkE4QjkxNjZaMjh2SndMN2VhajlpbGFjcjRCblli?=
 =?utf-8?B?MEVVTnJBUnozK0Zjd21ZM3dGVklpNXVjN0ExemZBUFhGeHpPRDBRaklwNlRW?=
 =?utf-8?B?R0czcTlKcHhCMGpGU2dWRE1DYS8vK1VaM25yOWdnbW5ZdzB3SFd3Y25mVmhw?=
 =?utf-8?B?eUZCT2NabUZEMVo2SHVpMldLMVAvekFNY005TUVYTUloZkFhM0VaUlRMNm1y?=
 =?utf-8?B?ZmJFaUhQZDVZMkd3S2hnU2hDY29FL0xVSGFVVUJyM0xpUGtCL2tpbUo2UFdx?=
 =?utf-8?B?K1UrdnUrM0JzWkJsb1BlelY1cjhXa29kN2YwcWxoVm1aeXpkQytPVHJjVHlt?=
 =?utf-8?B?VXVoYjBtMDJuMnpIZGg3ZmZ4MXU1cGpKY1JoQ0N6T0xYNGViS3ZUaHcyMEdE?=
 =?utf-8?B?dm1GalpUZEVRU3dtdWNKR05HL1pURXlBbk1sZEJ1Z0xuMHpxaGhUQzlGYmxj?=
 =?utf-8?Q?ohvE=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700013)(376014)(61400799027)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 20:18:20.8588
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3f8e032-09d9-46b3-0ef0-08de06a7d382
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MN1PEPF0000ECDB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR19MB8653
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDE0MSBTYWx0ZWRfX+OLQA2su13+6
 4dqV4zf2Ohc/01aDf+3I7fuN9lT5BpOxkD9FX3eAEA7F1koCsF4Zl+QfUYNE7Xk1UDJI6MkFKUF
 Fr5rgWnIhkpl6c0yr7bk98aioKIjvdZy3QnX9Oa9TALuukFyWGT8Gg7AP5CzKZLmDL++cK+2ybb
 iaGPocFMfal/hEdj9+KaRW5BIrzBI5IOjKHm0Mtrb2kDKUgDGrJhqLe+cazpQcVbjADmcWfY4/N
 yirlIRM/Tirwtnxz+GUea8kBVpzmoYfz3fMA8kg/9ssfMreuyDOpSaKXPkqWQ0vuKrRkuV9bwmT
 +V3jI8bTnrIH7j6PnEUTiQ1U6LlzvelSAmsnrOCNRBw/LvQEP0MpHClDQUQVZO/ExxxwJd+Mjma
 7IGN2xlf/HWUQSMvX19o7nFlBDjD+Q==
X-Proofpoint-ORIG-GUID: pKM9DGGeEUVzxOEHpFOXLPtL6JZTe7hy
X-Proofpoint-GUID: pKM9DGGeEUVzxOEHpFOXLPtL6JZTe7hy
X-Authority-Analysis: v=2.4 cv=McNhep/f c=1 sm=1 tr=0 ts=68e6c717 cx=c_pps
 a=H30LXO4bGSsCHJ4yv39IxA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=RWc_ulEos4gA:10 a=w1d2syhTAAAA:8
 a=kWJrM743YIWaU0uNr3sA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Reason: safe

On Thu, Oct 09, 2025 at 02:27:19AM +0800, Sune Brian wrote:
> Charles Keepax <ckeepax@opensource.cirrus.com> 於 2025年10月9日 週四 上午1:16寫道：
> Document had read and indeed it mentioned it will be ignored.
> I apologized on my strong words about IIS standard about extra bit clocks.
> However, it just mentioned if there are additional bit happens will be ignored.
> It never said this is a way to relay between MCLK LRCLK and BCLK.
> As such I am still don't convinced this is a proper way to reach the
> targeted S.R.
> And my stand of MCLK <-> BCLK <-> LRCLK relationship still holds strong.

Ah, I see what you are getting at. Yes if the LRCLK is generated
from the BCLK then the LRCLK would stretch/squash to always
provide enough bandwidth.

However, I believe most of the Wolfson parts from this era
generate the LRCLK from the internal SYSCLK directly. By the
looks of the datasheet on this part there is a fixed 256 divide
from SYSCLK to the LRCLK.

That said though, this part does somewhat pre-date me so I could
be wrong. If you have hardware and an oscilloscope this should
be pretty simple to verify in practice?

> No matter how you do it, it will only result in a close result but not
> match result.
> Doing faster BCLK but unnecessary just make setup/slack timing issues.
> Any specifications on how much you can overrun from first place?
> Which make zero sense and reason to do so from first place.

There are generally two reasons to run a faster than needed BCLK:

1) Because you can't generate the actual BCLK.
2) Because you are TDMing multiple devices onto the bus. ie.
   something else is using those extra bits.

> If BCLK is slow then the final S.R. is slowed this is what it is.
> Same as BCLK is fast then S.R. is fasted as it is.
> As for this patch do the current version introduce any error or bug.
> If not then I will stop the patching.
> Leave it to other to patch the approximated BCLK.

That is absolutely your choice. The patch should I think work
now, but could still use a little tidy up to remove the unneeded
code and big warning for something that isn't an issue.

Thanks,
Charles

