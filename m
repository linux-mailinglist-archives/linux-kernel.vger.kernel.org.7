Return-Path: <linux-kernel+bounces-855948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 442EABE2A69
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 12:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A7A23504A7E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 10:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA31333312;
	Thu, 16 Oct 2025 09:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="HJGoA27e";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="cKhw9hrE"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21FD340DB8;
	Thu, 16 Oct 2025 09:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608440; cv=fail; b=kVCXQ9uEz6HmIvfBMSQf8+EV+dxh+zh/A2+h+jad4BgMTpiScemLfv51VQz/lvFlIqrhU9l33Sg8Mc4FnRuff2/pgFR/80rO9++WWP4Lx6OWFosXAbmU9rBIdCjc6VuG+WyIpdonm4BoJiFLKO5sM1aTgdzjn2K0RcFi2fxXuj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608440; c=relaxed/simple;
	bh=BqT4glDVMYzPRjNL7mM+3YiqOFGvlQd0gcy5xs2Id9E=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=rD7jsrWO/ni9Mzyz1HqKNyCwsRnDWsBrCBUQNqxqqI75uwr6RP466Z2Eb66Cu4tg9vWUc0cEPS0h0Jiiqxve27CYc98UcsTKorQgfyrBCnWnUBvEAfQYkXfCdEdNHDmh0N8HL4bchopkosYW2XMEkBa0W9P4BulFIg6BsP4C+88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=HJGoA27e; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=cKhw9hrE; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59FMZLWX298642;
	Thu, 16 Oct 2025 04:53:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=i+epsWD0Q+k5EygW/IfZVp9oGPgWtM5NEeWn/ilAHAk=; b=
	HJGoA27ex6UwjgHB1EFLo9HosGtCRmCYJZlBoGBSVtFgePU1h6QmyeBs77dJyQsr
	im/DVoe+cfJiouq2bVt0IOA8hjZrFrUPOqetzDYZcHL+QegGbWmmCv+gqc4y9K9O
	d1HGrBbQaMqTIua/HRAzVL5kLaDZmLdd8+t7hPDqan8Pkww8mQUQCGLvnVrawCqB
	vQuASwkpcTZGBizojPQCj/jVmcxytvGoX2J0XFyn7l5IMvKpUS6/pbUM4ANTHKSK
	uZD2g9aQVpcCn7bQoCWG7BPPqY4EvOU1q0ou2mgjoAj0Ly1Ir6ZsVkVf4Vm/gccI
	6zF41v2PefjWVAHBU7MtMA==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11022079.outbound.protection.outlook.com [40.93.195.79])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 49t9mhhn7m-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 04:53:43 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dhalN8++z6Q2Byj0Q4kqUyLNrDjrmiw6VxSqzdqA1YYdWORWREV8JoPRhhAu+VeppnrpyNeCuoyWlWSE59mYfrSFhjCqxe6dQJOd2Q9HscV3htbAyx54+y7WBtzDC4Sc5OqEpAArnEUr5/jm2xwcIwDnvgNGEq4PrxiV0BkKdRyQmhe8USCD728JJgnJWYFEje5FTMOu5ySkprI6ODcP+x11DealO+XuGb+DjMzs0NNcH0g8GSx4QI7bpmdSzVzGKqxIIyo5M2A4S4rXGXpq+c6x1vCCaUfDpE/RV0Mcm3sZ2AShkt4nm4MngOrBlX8EJusvR38ch1xGss3/Y8egXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i+epsWD0Q+k5EygW/IfZVp9oGPgWtM5NEeWn/ilAHAk=;
 b=OuwTGyNXCzNWc99tQKs6iMrV9IRndKMF4wD7jqV5nAc4Z5i20t2jXAyfxaslb/aZ+U2K/3EI3m+DdLhmWxMdXBhiW+qVbH5WihfwpM+lFMBYFefDAcLeFPAevltF6PeihzEdIXzKVfRlBvypK3EqdrC/K+kPUX1nCj6rM8wa0MMYXW0wYc2xp88lAN+4tQcT0jbgvTtsZyt/voyVTfH3zBGcyFmEvPLJ7s7WEqYXTRLes6fN9fPp/m1FzxcCj7YVdOH8eHiLB+1/FxtxCUlClyATfdvIlyqc6FKech9l5LdOwMRhuVo38m4JJVQ/j6n2G0t+61/0a6YfHH4SLi3pGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+epsWD0Q+k5EygW/IfZVp9oGPgWtM5NEeWn/ilAHAk=;
 b=cKhw9hrE8916SP70F4JQ62QnkRfDpzFd3G9TlteGTvwvun3zFyxvvYhNZ4Mus8cYmKAwqapYxup9uG4Hn+AINGOQ4nDPy/ZzOzGHm+TXuYzvp5wZnIDJvS8CvQf/qfskq4Md8nGP14bASq/kvSf65JO4SsCAB83xE0zruY0dSmU=
Received: from BN9PR03CA0365.namprd03.prod.outlook.com (2603:10b6:408:f7::10)
 by DS7PR19MB5781.namprd19.prod.outlook.com (2603:10b6:8:75::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 09:53:38 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:408:f7:cafe::aa) by BN9PR03CA0365.outlook.office365.com
 (2603:10b6:408:f7::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.10 via Frontend Transport; Thu,
 16 Oct 2025 09:53:38 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Thu, 16 Oct 2025 09:53:37 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 16452406547;
	Thu, 16 Oct 2025 09:53:37 +0000 (UTC)
Received: from [198.90.208.24] (ediswws06.ad.cirrus.com [198.90.208.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 04A4F820249;
	Thu, 16 Oct 2025 09:53:37 +0000 (UTC)
Message-ID: <8089a74f-7fe5-4d25-8684-31ff4cade868@opensource.cirrus.com>
Date: Thu, 16 Oct 2025 10:53:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: cs-amp-lib-test: Fix missing include of
 kunit/test-bug.h
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: broonie@kernel.org
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
References: <20251016095116.93260-1-rf@opensource.cirrus.com>
Content-Language: en-GB
In-Reply-To: <20251016095116.93260-1-rf@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|DS7PR19MB5781:EE_
X-MS-Office365-Filtering-Correlation-Id: 95653b7f-4e83-4411-42ae-08de0c99e131
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|61400799027|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ak5KSzJLTDhaM1hwTjl1aU9KTUQ2ajlxSnJiM0tjT1BSWEhVTmRmckVtWmt5?=
 =?utf-8?B?QVlYY203QnJYbG1wY1ZrbWYzRS92d2JqNTNoK0RHdkZCWUtZS21oWnh6N1I5?=
 =?utf-8?B?cmh4S1MyL1dxNUprNWc3NzRQbUU2MVVlUUxleUNXWkN6NCsvMWkyVHphY1p1?=
 =?utf-8?B?bDFhS2NGeHdkM0NVZTJFcVdTMGdVUlpFcHRxb2tqTFA2Y0ZFRlVCQjF5akRZ?=
 =?utf-8?B?VXZLRERHSENRVndycVJtanpzR3hkbHd6bmUxZXJabGppNGVoSnh4SEhqSWxF?=
 =?utf-8?B?SjhIUUQzdi9GMWNydVlxVS9pc0ZSL0dlSXg5b0s5OVN0WlRGS0ZJbWpTaGFN?=
 =?utf-8?B?cWNsQlZOcWI3ZVBOeHdLVmNjQjdld25IemgyY1Y4UEJVa1NkQm1jclRNRExx?=
 =?utf-8?B?MHFUNWpNOWR5am1kQzFXRVgyZ2ZZN0xFSitYY1VITW5QaUo3S3prVFhXNTZ5?=
 =?utf-8?B?L3g0RVFPMjRSQXczaE9PVjNNZE5tU2M3T0c0WWc2TlNwTGx3MTRyR1ZiRGV1?=
 =?utf-8?B?RGhjVFRBSVZocE5UMnpHWkMvRTlwMWdIaGRwdWg5SW1adW9CNmFPOGtjVlFW?=
 =?utf-8?B?MkNuMnIvQnl2b3VLTjN3aGhCQkdhWXpVY0s4WXlGNUVSOEc4SjMxUjlHdDFy?=
 =?utf-8?B?QUxrNnhvSmFtVVhJU2lqMTA1ajZMNUNxcG1lMVUwZTdHNS82bUNmWVhlWW5o?=
 =?utf-8?B?d0FFa1A0M0RxS0g3SWxOWDF4eSt5a0FHT09lT0tpMGFGMTFSTncxakpPZmRE?=
 =?utf-8?B?OVE0cXUxOWFOdjhpbFlXcU00RStoNC9RUE1WZGtBd2RUY3ErVnIrYTg1ZzVh?=
 =?utf-8?B?M1dTWm5MM0xzQ2VmUkk4MmYzcHZpTjhyZDdjcGwzdXpDWnF6VWxWMzV4WGJr?=
 =?utf-8?B?WUZXa1VxRmx2Y2RaRUt6K0lIOHJiTTdpM3hwWWMxZE5SakpSUm9ZaTNYWnBh?=
 =?utf-8?B?eVNmdTdQMVplelNtMGZFQ1EvMHY2NU5JR2owSGFRdXJWQVR3WUhDV0ExeVpJ?=
 =?utf-8?B?aExsVHRHZUQ1NlJMWFdhZnJORURkY0ZBVHlNa2VTcWk0ZDFXR3BzOGQ5Nkk1?=
 =?utf-8?B?ZHk1eGVBa3ZFdnJqVE1EbHQ4WUUyenNlZTdkbVV3WVdhOWM4dDY1ZFhJWm1H?=
 =?utf-8?B?UWhlU2Q3aVdQTWo4bzVud09xdU9DK29CSEZJQ0VXWmVwY3BNczlEMmovbDBh?=
 =?utf-8?B?enROT1ZsMnVpTmVxLzNlVFkxcElOQTg0NmpWTldXR1Y1c0k5OGllL2pDQS8z?=
 =?utf-8?B?aCtqV0VJMGlSMnhRYTFJdTcxTC96NGdsNVR5NWdlUnR0cEFhazMwQTUzdlA3?=
 =?utf-8?B?QVdaQkJScURlbU1jUHhEYmpmMDh4TE92MkxHMEwzYU1RYUhvWk5zejhIY2NK?=
 =?utf-8?B?a3I1THc1RVVQWVR5L2krd0hGanI5NUNFcFpqdmpraU1mQVNEaWgwekdtVHdU?=
 =?utf-8?B?U21Bd3k3T0s5UWwrRTJ5R29TQjQ1bUVlSzJmejFHZGJsRDhkNVVLaCtJMzBJ?=
 =?utf-8?B?bS9rekpZMzZVcVk5Zm1tdmdhOXhGYVJJQ2hTYitjY1dqWjBrYXFVT2JuZXRD?=
 =?utf-8?B?Q0RBeDNtSEFWdjhPbmRkNUdSNWJEWG9qOUVmUGhLSnphdTRSWEJFSjI4Skpo?=
 =?utf-8?B?M3ZSMWZWMnNtZm9qVndPdXBleEhwaHRCd0VlZVBiSVh5ZE1VMjNLTCs1a0g4?=
 =?utf-8?B?TmsxK3JzN1VoZmVjQlVSZEdsUVpXRVRwb05uNFd0SjdKbkJUS3BoRmUzSkF1?=
 =?utf-8?B?U0lhTTc2bkZjbUt4WlU0M1VuVUFYQ3RiSnNtYjhjb2V6U3VtZUdzRGdpOXVI?=
 =?utf-8?B?STgwQ01BZXgvL3pBSUhnak1qZDBUeno4VG1LTlh0dHZCS3dtbjM4VWpPUy9F?=
 =?utf-8?B?cTFINktGU2o0MmlBL3pITStSUkZnK3pZZHoxeUwxODZtZTNka1o2b3pmS3Va?=
 =?utf-8?B?UVZiUkFCQVBuYlk2eUNEUHdCVDBtdnJHOU0ra1F0VWVvcGQrS3lrRllTejJV?=
 =?utf-8?B?R3BaaGkvTEtvUDFUVHdQL0dMSGMxdVFmZTdIYmpqT1krTk1jSWx0eXR3VTh3?=
 =?utf-8?B?bzNmc2RtV0RoNVFjeVhQSDRCZ09JVitzMi9oam9nUG1yL3hQS1BOTWROcWFh?=
 =?utf-8?Q?64xM=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(61400799027)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 09:53:37.8752
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95653b7f-4e83-4411-42ae-08de0c99e131
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR19MB5781
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDA3NSBTYWx0ZWRfX44O2g6euAl1b
 9RT76NikcithSWr2lDlj/Lk22lA3WYR/KyTQA2PMjRP9KIXa83Q3ZsqQTolDqowDFwXZYc33U3g
 AJ3FYoL7O0hmLNnIlClJuOWj5nlWAGrbxZDox2SoCCxAYSx24KlZvdQzbUHwJ2eXy/XmpbBtyn2
 NlluYcDz83otyYfyIukcN3vrTGCpeEJjXhwx2e70KQLP97k60nb6Gj6gxRr1H0f3lRJU7kQ4nXG
 mUwhwZQdwSJsRY0kfdnag+ysKzjcuOC3dRT0KXDga7m50dDP5f6TvgdkEnfGUTTDBJBbLMeYTBc
 eXo1nMYNGpRyFpFivFqc3R6mj+zm7TC9XSd5fYUg8QyDIEjl1oSdYMcBbVFXdNQwIwZSH2UCFII
 D/AyViZxIxDCeiwsTQZKL5AVWWcwUw==
X-Proofpoint-ORIG-GUID: m-__luuAA4iOv6ieWjQM1LialRouMLDr
X-Authority-Analysis: v=2.4 cv=OJIqHCaB c=1 sm=1 tr=0 ts=68f0c0a7 cx=c_pps
 a=ON2AtRasCbt5Ww1V1qMYlA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=MiCUlokt4N07U9LgpHkA:9
 a=QEXdDO2ut3YA:10 a=QYH75iMubAgA:10
X-Proofpoint-GUID: m-__luuAA4iOv6ieWjQM1LialRouMLDr
X-Proofpoint-Spam-Reason: safe

On 16/10/2025 10:51 am, Richard Fitzgerald wrote:
> cs-amp-lib-test uses functions from kunit/test-bug.h but wasn't
> including it.
> 
> This error was found by smatch.
> 
> Fixes: 177862317a98 ("ASoC: cs-amp-lib: Add KUnit test for calibration helpers")
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---
Ignore this duplicate email. It got sent twice. Sorry about that.


