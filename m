Return-Path: <linux-kernel+bounces-841702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDC2BB804C
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 22:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27BF13C8415
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 20:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DA61D5CD4;
	Fri,  3 Oct 2025 20:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iK/cEZmV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nGtPKWcH"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06B079CF
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 20:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759521731; cv=fail; b=SOH8SFQKITA4xHBjxNt2I/VTxyq7X6l+BYspBpitU2jWltejhPy9qOyzM0Uv1u7dWE0dfFLXxFYhdysC8NdW4sZWeDNRQMkMLhVDKp5fe5/57pU3rtJw+Na4TQehVuELNJJOPP5A3kg0cFmdaC5KQEw+OY/WLpWQFUji2wlYP4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759521731; c=relaxed/simple;
	bh=Jfp1ejl4rTuCP5Q0q842G6b2826foPZlSw6QdDDGv2o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f2dSo4De13CqrEEewiSbhoWejm2AnlnNasl0XPEakqqwG9Z1MOhlEnFkalyRdUZI4F91ujYNC2y9yZadADMk9la7/gI+biQvUPK+MEqR7yEHQH1ztOr2952duN3tvv2saS+49BqjLz6rv84/xtcdGtbsb+UBXGZOvoYkQV1VlKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iK/cEZmV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nGtPKWcH; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 593HTXrb012856;
	Fri, 3 Oct 2025 19:56:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=v2fJHGtg/MuRdMRq6R7jjbnR4PTU1frjBaI8oqfY/Tg=; b=
	iK/cEZmVZbtb5oADMFu00Gpy22p9IL1MFoJ165jHpuJoCndCCOHTfzU98F/dHCWY
	Vn0QA41BnWGZYBWMNpaJ5shVHBzgdcI0M5iQdXrkc1rqnqFUbkVzQphbCqnLc3Sn
	Dmugq4v7yLzt8FAZeBn4kTNUi7hBmhFMpXEYJfsE2pp2bywL5njWl7ZzLqv0AZKP
	JElLkKy2OqwQCaxKJ5AOUwiWNE+eZGDS/K4MRimBriAV3VTlWkjadcS6XFptaVnZ
	Igde18OvLYo+KNFwD6TXkWvVWbOuNigEpjqH6tZr7IGI7vM0Cx+DmQE94G1q2Ucl
	QDl7o83RPQhrNvB7ssJiJg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49jjx8r7rt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 Oct 2025 19:56:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 593JFf7k008848;
	Fri, 3 Oct 2025 19:56:22 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013057.outbound.protection.outlook.com [40.107.201.57])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49hw1ye822-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 Oct 2025 19:56:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DExhL3HUeCxd2Py8mZSgKUFMej1NHiul8UyDqAthYPYqjY2q/jdKZ9xrN7NiOC1oUW4GEZ+Y2G/LHB/2DeNDiWGpYg0pWIb69NVkqst8ua0hlRpUDcOiXrFAH4oD0VKTFzxmeGFKMvmzpL7jaKR+19iP1I+x9Q2ZTQcYZRg0BO0gpJyb50ytt+KRWfOPuGbLy+UhACBC1mpKu/8qCECYa+SUZeNducBbBzjP+hypMzGs4pimdTjnAyTAiODpAiGc/tfDrB32vsutv4JoBtYmM7I2BAPAAVV7GgF3LveVuWnD7XKRBsFBP0dix2qDj85hyi0xHfXJ1uhnfCoFLveXAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v2fJHGtg/MuRdMRq6R7jjbnR4PTU1frjBaI8oqfY/Tg=;
 b=Ajf+vT+I2Jnq8l+ZjSlFDSiY7g9TvFbHY/o43BZTgEN4koAOfY2vYGpU41nbixsiz/NxwX1w8pHk85g+B8OxJW2krUtrEQ4i0V4DxAT6lpI4cLr9VHX5LXIFPrAqLLHGSr7gsj/nM2+6O/qAkT0902qiw2/gBfx1G7zwGKoRBnCBrWiNpo9Msr/yfnKQPzxHlnV4/HMwubqUohEyVzPHMkizLE15y0UeLHApI7SlSFMB0Pw0T10bsZgFW8g/hUrkvRPUv1cFY8FCiOfgRv8I4YSa2h9vh6jHeb/DKCDw/10S00XoUYrMcd+G0tAXeQ4lSre2M5JHXL+TGgHV5aBClw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v2fJHGtg/MuRdMRq6R7jjbnR4PTU1frjBaI8oqfY/Tg=;
 b=nGtPKWcHHTmt2LC7werhr0ENXMM35uct5r2kUdBTOIDt5gVKw5Tz/4WaKFfElsLplT9qEU66OfVzol8RSqkjB50iRPVTVamN77d/p2Etv1MG+u5YEvDxbklb6t5ElNiSmNs9gxioiTBOiPJ/D7JOZWp+Gb3wZlsngSsf9D2gaNM=
Received: from PH7PR10MB6988.namprd10.prod.outlook.com (2603:10b6:510:27d::5)
 by DM6PR10MB4170.namprd10.prod.outlook.com (2603:10b6:5:213::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.16; Fri, 3 Oct
 2025 19:56:14 +0000
Received: from PH7PR10MB6988.namprd10.prod.outlook.com
 ([fe80::3432:737c:a431:7edf]) by PH7PR10MB6988.namprd10.prod.outlook.com
 ([fe80::3432:737c:a431:7edf%7]) with mapi id 15.20.9182.017; Fri, 3 Oct 2025
 19:56:14 +0000
Message-ID: <684e74b2-802b-4f3a-895c-d3465bf9d19f@oracle.com>
Date: Fri, 3 Oct 2025 15:56:11 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : [PATCH] sched: cgroup: Move task_can_attach() to
 cpuset.c
To: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>,
        Andrea Righi <righi.andrea@gmail.com>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
References: <20251003121421.0cf4372d@gandalf.local.home>
Content-Language: en-US, en-AG
From: Joseph Salisbury <joseph.salisbury@oracle.com>
In-Reply-To: <20251003121421.0cf4372d@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR02CA0023.namprd02.prod.outlook.com
 (2603:10b6:208:fc::36) To PH7PR10MB6988.namprd10.prod.outlook.com
 (2603:10b6:510:27d::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR10MB6988:EE_|DM6PR10MB4170:EE_
X-MS-Office365-Filtering-Correlation-Id: 9aa316ab-3699-4093-6755-08de02b6e888
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c1NTYjRReE1pTksvQWpzTm5RbllhRUlxVUpqM3lFY2VvM2xOQnN1cHErd3JG?=
 =?utf-8?B?M1lUdDhMK3B5UTNQYjVxVnhMU3VoenE3QjNDb3h0R2YxQTZLWXhiQnpOTXRv?=
 =?utf-8?B?NWRYOXFZQzFHaTJQZkovMEhScVN1T2lpL1F4M2x2empScktKdjAxWXRVUkZj?=
 =?utf-8?B?S1VxOUdzdXJoM3IvN3N2bEJKdWpJVUI0dVU0SmJ5WkVxR1VNbGJGUW9Dc2xr?=
 =?utf-8?B?TE83L2pQTjY0bnp3YTZtYi9lVG8rUHVFWGxERjhKaElMaUF5RHlQK21WdmRT?=
 =?utf-8?B?ZkdwWUpuYWxsczdUUG0rSnE5Mmx0QzFSNTlYNC9tdzJWaEw4UWZFYmQ3UWIw?=
 =?utf-8?B?WVRRaUhWdWFGR0JtZ1hoRENJbks0TStmdVhJUXVIQlhobG5iRVc0RmNnRUdy?=
 =?utf-8?B?d1dIUXdmeVB1TmdBZC9aeVpqY2w2NWlVc0hsUmJwNFhMVGpFRnRBeDZrMGp3?=
 =?utf-8?B?c2k3ZHpvV1dGb1JCOVBhMXliL0trblRZb1U5UWEzMWpxdzkxcFlkb0hRT2FV?=
 =?utf-8?B?UDRkNHV5ZnJEZDA4UUs1Q2xWTEhLLzZIdFM3VElISGVBcHh1TnRvTzdZckxU?=
 =?utf-8?B?RDIwendtOWZaVG1pUTlGcmFQY0lLQnFpMzZSTGh1bTdDNTRHQzV6TW95MkpR?=
 =?utf-8?B?TTZIVUJMQ2tCWnVKU1FxK01taXJYN2RFS2FEcmRTbXBjUEJJcHVxNlQvMGJz?=
 =?utf-8?B?cThRSTBrWkhGeTVPR21nYTloR2g3MTBMWkhiQmd2Z2QxODRhd1BDL25CaDVC?=
 =?utf-8?B?YUxKeDcrMVE2R1h0TXQ2emxCQVlUQ3NnR2pIQzdOQ3Erai95TXhwQ1FnUHhI?=
 =?utf-8?B?ZUszNnBZNDJhamhTVkFwa2JEalA5MjFKcmdNU1I5enVQM2xuT3pkYXJEQzBX?=
 =?utf-8?B?NUJzaUdiRmwwdG9seWgvaWFpL1hhZUlFMmoxSTljYWJLbCt0Qk9NYnJaNEc2?=
 =?utf-8?B?TXg5VzlEUGdmUDA2VW5ybU5wWW42Wlo0Und3U1k1b1UyNjRJbEZmcTNUK2ZP?=
 =?utf-8?B?YUJ2cVVoY2RSRTQxWXF6d2RvZHQyVnlaTDJ1bExDSWkxLzAxdHlVRGdTMk1H?=
 =?utf-8?B?RnJNbVVUUDEydER5Z1hnZXY0SEFUV1M1STNYMDhpMUNoa3hYbTdaYWpMelNx?=
 =?utf-8?B?YlhvRXFoZWx4eDBFY3p3MGx2QUtQY094WXIyNHM0WUpzSzE3dGErOWI1cDhW?=
 =?utf-8?B?c0JoajNORWlkSE85Vk1HMi8wMXhGMU5UWUlOVXlobERSZFVyTjRGbE4rdlNs?=
 =?utf-8?B?SkhBZnFsYU82ak1lN3VtMUh6bktuMlBSaUNLQUE5UVAwRTNkem1vMWJFN0xD?=
 =?utf-8?B?Mk10a0JYKzhJOUxmL2JSWTQxYlFXNDkzMWdNUXZBb0VSaHd1VDNkQ0xTT3NY?=
 =?utf-8?B?Ym9wL3RWN2NqYU1pRWpmMzc3SEQzb0R1MkNJZ1ZnRzA5T0tXWHQ3N095Sjlh?=
 =?utf-8?B?cnAyRnlXZ1hLK2xvL25ZWlMrdzZLN1BORjY3TnJkamRuUHpNVmlrUStRakxv?=
 =?utf-8?B?N1dwUmJsQ1hxb25oL3VMRTJrK2pDT3NoNG1jOG9sbnIrbnJ1bEFuQnZ4Wmx4?=
 =?utf-8?B?eHRVV096MitkbjhBd1BmU0cvandzY0xwcHJEN0dRL2ZXY1VvaU9jY090R1B2?=
 =?utf-8?B?eWh2NTRxRG9uQUF5WG1MMzZVVTRwd3REQmNEN01zbks5ZjFkZFY5OFNIRXNs?=
 =?utf-8?B?V1pCSVhrYUZ4dm56NXJYaW5kTE91MUl3UmlZZjVmSFBYa053K3ZwNHhCTHVP?=
 =?utf-8?B?cTlLVlZCVUkwNFFMMEFDQW9MOWpaWHZ1K2N5NS8xaWpPOFF4WEx2U0JPdFFT?=
 =?utf-8?B?dllyWVowNUFlendwekc4VXYrWFozZDc5RkUzME1nNWhlZ1BzbzhpUDhNYmxR?=
 =?utf-8?B?dFNJVjVwK3NITzBRRXpGd3ZJeXFiMFBMK2tTWnJTL1RWNkF4Nys0RzZFQTZy?=
 =?utf-8?Q?0KwRGdCByRfhjzfuI2pINAwsv/S/mnpr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR10MB6988.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MUpQdjVwaW4yUXBMLzluWlF1OURsY1hxOEIvQnlIMlpRb3FHWW9yNUJkRlgx?=
 =?utf-8?B?UEtIKytvMStYSUxzWjltNUplNnA0RjlWT21ZTGoxVmlUZHZEbnNUL0VMdmR4?=
 =?utf-8?B?UmQ5dWpFcm9Ud05TSW9jUnNpV0F6ME1IM2hXK0QvdklZUlNKMDZOK25NMGhl?=
 =?utf-8?B?b0prVmUvR29oSEtSa2xOSnFHU3k3ejZSYzAxeExaSmxLbzJlWHBZNCtudzEw?=
 =?utf-8?B?U3Q0bzExWjRwRmR5bC9wZXMvZk11N2Y4RG1nTkFaTGtZa0dFcmNpbGpsajhi?=
 =?utf-8?B?Snd4MGE1Q0tGd1BQcnlzcVBRdm1uVk40YW55aTJEK2NqMTZtbjkzLzZnVHVu?=
 =?utf-8?B?aitqWTdOWnVicmYxaTlIWTJzQ0huVDN4dUZvYWw2TEwySTBkSlBrR3JmYzFG?=
 =?utf-8?B?ZGtCSDlSdERjR1JZT2xuOUhVMUZCWnkyNVlSUkRCTzdvT1RSYmFYdFduck9j?=
 =?utf-8?B?emNaM0dCV29mMmtFQWN2d1Q4TGNleHpmUitIK1d5ZFRXTTNYS2VjVDJmNGxx?=
 =?utf-8?B?Y3krVlN5YStwUmNoVFptc3NiUk9Ca2dRWnF3ckxIQXAvK1A5UkZNY3E3NEFO?=
 =?utf-8?B?MXJ3Z09rby9qRVIxOU9mdzU1YUFjKzIrQy83VkNiZG5GQWlQVlg2dW41Wko2?=
 =?utf-8?B?ajNYWGFGbFZYMTQybCsway9wSysyMTZZT2VoOVZ4Z2F6QzNkTjZyR0VMZ21x?=
 =?utf-8?B?bjdSRk9lK2hMVG1KVWM3d0E5bWw2MW9OeTZkSHZmQ0JkS2hqWExGNFpGV3gr?=
 =?utf-8?B?WG5HQ01PRTRzd1NObGFJN3lMNy9TVVVxQkJGa0VYb0piODNaQkpWZ2FZdjRQ?=
 =?utf-8?B?dHBFY29lYVpjRlUza2kzZFVIa1hvVTMxK1dDQnpBZFRlSTRoMERSeHIzcWls?=
 =?utf-8?B?MEtjTjE3QzErbndIMlhuaFk3dTE0RWh3bHR2dWE1bjg0dDJLWnFaeGRONUNS?=
 =?utf-8?B?RFkzOXQ3OUpucys2KzduNjMrd0Yvd1VQNTdyUy9uZkY1eWFMR2JEczhNdWht?=
 =?utf-8?B?ekROTDQxdGVvRDhzR3ZlTHFMeWlFdVU5TkFqaEhSaWdrVEdLVnVGUUxWeWM5?=
 =?utf-8?B?MHlzRjlXMkEwaTlXcjZvaUR4Z3ZpSHpCSXR1cWhJN3V0bDBhMWtFZkpaMmRB?=
 =?utf-8?B?bDRXb1YzNXFMZWl2OWVhMXpYYjZwZXJOMzdJSmd2Mjh5dGNJVGM4cmFhSFZo?=
 =?utf-8?B?c1JYNEYvRmUzTDYvd3Z4enozYWliRGJxSWcvMGp4SnMvT0dRMDFoSkdLRmE2?=
 =?utf-8?B?czZ2VGtla3FHczRDWWZ5bU1WaWNERGhITlR3ekFVSTZabSszaytOZ3MyY094?=
 =?utf-8?B?MExFREVJbnVIRWNyalpyKzZjVUx5NUoyeE9rRG5oMjhDRjR0eXRJZytaMWNx?=
 =?utf-8?B?ZHoxVVZsbFJSYmNsR1RNbERPcVR4dm9DdmxnWm9PRnc0dWIzS3lYaTh1aHJF?=
 =?utf-8?B?UktLZEcyY3RYdTFIQmlDUGJtbkxPeEIxUzZCZndVUlZqNzhyUzJmaTlEOXFC?=
 =?utf-8?B?T3Y3UHJPVGtYUXJxaGNkcWt5eUU2V20vZzllaVhJMXhkQmdwd2pFdjRsZUZG?=
 =?utf-8?B?c1RBTDYwcDRIckpXc3VlNVo5bGdGRUFYc0dKNDg3dmZ6QjZuMDQ3cjRpL1F2?=
 =?utf-8?B?a0wwWG9JK3ZJaWVNTTB6UWpxN2puQ3NncW9WSmJlME85MFRHTlpmalNxZWtm?=
 =?utf-8?B?VTBZWGsreithc1JOaVNFVEpBOXFGRXNGNzI0REZ1SEFRejFRZzlxb1BYeDRp?=
 =?utf-8?B?ZDd1aFM5cmJGbmpWdVdvSThnK1BIS2VYeWNMRmh0STIyMVJWdEI1WVgwY3JS?=
 =?utf-8?B?YmZyOENmSjBCUnVRMW1ibGRLOHhYVEQwSjVQRi9hNlNNSjgxZE1HbStZUmRp?=
 =?utf-8?B?Wnd0N2xuZU8xYk1lSEZYM2l3Y1NmOGxxaUlXUUx6eW1PUVlDNlZMeXkyUjJ4?=
 =?utf-8?B?OGVrLzAxNEJKckIxUDNvb2crWU40UnpTNjNjblNZdzUvdUFJYzN5ZVE5R3Nx?=
 =?utf-8?B?eDdzT0VQd0U1OUNIU1l2cnE3VS80eHREcFBPdnBTZDNTc3k0QURsZlAvS285?=
 =?utf-8?B?RExXTCtoL2lzZWtHZWVnaEpRd0ZhWWYwU09MM2RCQWwvL1U1NkhiV2dwT1ZS?=
 =?utf-8?B?bFJhTXBQMDNRci9mS0I0YWpVQWx5TUN2RjdJeE92NklJRTkzdVJSK1dlOC92?=
 =?utf-8?B?bnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6W3XQlyRPo8ERXwNw3bK6KN/QIZXthV+42kDTk284GpD1ED/hrj3JRYX2j0OTOVi3ImR8bwbdSUS4Zu8cRiYf1sC0h8XfFAKkETzN+k+z0/9AV0+PFJURhBkbM7Y+9EM+SBXR4Bo1HMfcqMov1XEkaQQTxMwenrh58cfOESh1DiPkBni4YAKbVFrlgrPqNysaY3NXRYfufxUPotLfDIxNSy3Wti0wWsTIERf3HnA1Luv+Z4X2EeCgJtHw0Sa9mnE1/aJlyLPJ/bsSmbdtv8mrmOCTEdq6RCsJ89Vl48pPTJ644/jBMKOumWVkzzxgC8yH6vIwGxBSJgOozCSb/KScOTWWYIhO+gkTvhUrmql3vSljZyBBYDt6l+wNiWC9kC8Og5kE9KyPMD5+OO84t+aAYhAGBrpVvHuLZijoA4dDpUvT+45UCkrR9AWXJ1hHwi2j5nquaPrjsCVW8PHB48KuRu0uZzm4+NTTcgKtfJGTzvrve852URE2ERyw75rRcMmp4ZQwy6BySWUYJ/kEnQgua/6UCuEKVh+JOII2eRQstJoVb+kWkv2tjF/x72B+kubkSkSUgqi2SXfucUjW8jj9wHnlUIpdLZQ0JsQgo52avU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aa316ab-3699-4093-6755-08de02b6e888
X-MS-Exchange-CrossTenant-AuthSource: PH7PR10MB6988.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 19:56:14.4766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pGhHwn2BrYoG1vjJJQjgnxq6A0XEZrVeeqfMURmZlUP01mKmSiQ8LSNhF8r8BlBctqMEeaQGz3bNPI260PAqex2fH/mlR24cvcyTMwou6Pg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4170
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-03_06,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2510030165
X-Proofpoint-GUID: 9rKsKj-j3rpJTDZ2SeOVGqP6uztUN5Kl
X-Proofpoint-ORIG-GUID: 9rKsKj-j3rpJTDZ2SeOVGqP6uztUN5Kl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDAzMDE0NCBTYWx0ZWRfX/gTdPzY6VJDv
 vIg220aDHLedsGt1kBySC7wLDSzFJdCbredFLWgfRzv6lIpRd+/2qp2NffS0h6cgGwYNf9XmdB8
 yBnOfyfJ0oSYTYMjo4zLlWBqPA0lSnuQVMYzP5EDUDtEYJye5drlthiaudo3IAGjFpeud2QMC+k
 p7gHBITineO5zqFODQcO0Rz1rxPxDuMT/wt0DrOTfVIHCbpOuHiFAE4iLEJ0C69+reyNpzF9F9/
 EajHCY4mZXpo0twJE+1Op5kl9CreSeJEkilErXT7yku5aUfeTTsrJrj7N0j4yAD9nkNgf2S8wJa
 VondZmAKefnEni3I8Cd8nrUfA7TYpmfmQoeoqslb+fqR0LAXyenPaaoEEvtTLSyMDjAH3VrMYTh
 wNj52HOyIBRBXiS1ZZQpEHTTcxyPng==
X-Authority-Analysis: v=2.4 cv=W9s1lBWk c=1 sm=1 tr=0 ts=68e02a67 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=meVymXHHAAAA:8 a=yPCof4ZbAAAA:8
 a=iUrc2F9UO6oVIpOQADAA:9 a=QEXdDO2ut3YA:10 a=2JgSa4NbpEOStq-L5dxp:22
 a=cPQSjfK2_nFv0Q5t_7PE:22



On 10/3/25 12:14, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
>
> At our monthly stable meeting, we were talking about documenting non
> static functions and randomly picked a function to look at. That was
> task_can_attach(). It was then noticed that it's only used by
> cgroup/cpuset.c and nothing else. It's a simple function that doesn't
> reference anything unique to sched/core.c, hence there's no reason that
> function should be there.
>
> Move it to cgroup/cpuset.c as that's the only place it is used. Also make
> it a static inline as it is so small.
>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>   include/linux/sched.h  |  1 -
>   kernel/cgroup/cpuset.c | 19 +++++++++++++++++++
>   kernel/sched/core.c    | 19 -------------------
>   3 files changed, 19 insertions(+), 20 deletions(-)
>
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index e4ce0a76831e..4ee4fa973eda 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1849,7 +1849,6 @@ current_restore_flags(unsigned long orig_flags, unsigned long flags)
>   }
>   
>   extern int cpuset_cpumask_can_shrink(const struct cpumask *cur, const struct cpumask *trial);
> -extern int task_can_attach(struct task_struct *p);
>   extern int dl_bw_alloc(int cpu, u64 dl_bw);
>   extern void dl_bw_free(int cpu, u64 dl_bw);
>   
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 27adb04df675..21fe872803e8 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -3009,6 +3009,25 @@ static void reset_migrate_dl_data(struct cpuset *cs)
>   	cs->sum_migrate_dl_bw = 0;
>   }
>   
> +static inline int task_can_attach(struct task_struct *p)
> +{
> +	int ret = 0;
> +
> +	/*
> +	 * Kthreads which disallow setaffinity shouldn't be moved
> +	 * to a new cpuset; we don't want to change their CPU
> +	 * affinity and isolating such threads by their set of
> +	 * allowed nodes is unnecessary.  Thus, cpusets are not
> +	 * applicable for such threads.  This prevents checking for
> +	 * success of set_cpus_allowed_ptr() on all attached tasks
> +	 * before cpus_mask may be changed.
> +	 */
> +	if (p->flags & PF_NO_SETAFFINITY)
> +		ret = -EINVAL;
> +
> +	return ret;
> +}
> +
>   /* Called by cgroups to determine if a cpuset is usable; cpuset_mutex held */
>   static int cpuset_can_attach(struct cgroup_taskset *tset)
>   {
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index ccba6fc3c3fe..a195c4b25475 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -8070,25 +8070,6 @@ int cpuset_cpumask_can_shrink(const struct cpumask *cur,
>   	return ret;
>   }
>   
> -int task_can_attach(struct task_struct *p)
> -{
> -	int ret = 0;
> -
> -	/*
> -	 * Kthreads which disallow setaffinity shouldn't be moved
> -	 * to a new cpuset; we don't want to change their CPU
> -	 * affinity and isolating such threads by their set of
> -	 * allowed nodes is unnecessary.  Thus, cpusets are not
> -	 * applicable for such threads.  This prevents checking for
> -	 * success of set_cpus_allowed_ptr() on all attached tasks
> -	 * before cpus_mask may be changed.
> -	 */
> -	if (p->flags & PF_NO_SETAFFINITY)
> -		ret = -EINVAL;
> -
> -	return ret;
> -}
> -
>   bool sched_smp_initialized __read_mostly;
>   
>   #ifdef CONFIG_NUMA_BALANCING
Nice beneficial refactoring!

Reviewed-by: Joseph Salisbury <joseph.salisbury@oracle.com>


