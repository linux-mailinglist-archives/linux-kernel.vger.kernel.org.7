Return-Path: <linux-kernel+bounces-830453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99254B99B24
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 13:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D72987A3F30
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 11:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA10D2FFDC0;
	Wed, 24 Sep 2025 11:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cQgcxZkO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fdGiQ3YE"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5914C2E54DB
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 11:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758715078; cv=fail; b=X490NxIfvCDkm26NouRJok67BOXw2bnpfmRlQul5THZAPNRDAtZusw7yWuDSDOXif/1J30fscqD0N8wyVcHwwBL/U29Gbfh27r7jrpwe6NAJJTmRI0QitN7HoCLkR3qYia03i3UbmIj9oUHzLMcGOJqFHEU0NBxR9aqpgGJH+iE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758715078; c=relaxed/simple;
	bh=Dfp8Mf5tZq/ftNgzzrhbsh204/AMNMeKQi4j8B3DSDQ=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cmCchSqjD7Mj/KX0wHOsXDygoSvwPWux1ZDiphMHj5+mSzhIlOOsECO7Ecjw1clNJdu2anQZU5l0M1+FYKm0wnfEWhnu6d3E0OlRlzCaFQ6iBzSxN78JrqO8HFWu8BZHN31e/DscFScSipbZzVw28zA1sxnvWog9Wte7ZGIQmgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cQgcxZkO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fdGiQ3YE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58O9MsJh004333;
	Wed, 24 Sep 2025 11:57:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=reE3LoYpUoqhXQFs3fASObplMg/iluH0g1IB2HiQFY4=; b=
	cQgcxZkOC+xCkgdeiOhANwkTSGCfKf2jxWpS13NvaNgLMHE5aezltX+1zIp1AHbZ
	aM2Y9cHZ7EU/rGWgVZd5ODUThJGoiaQxtpmdp80b+aspJzqwhs5Qskgnm2ez2b3l
	KXr2Kcyv9j6jpWZ4AXDi21TD0E+GHYorJvfqsll3uBESBl9idMHbnFxocgWmWESx
	67WTBaLUir+tJM9zZib5pucTdFtVqyOCrNHZHTxmT/0Nr2NNnz3/i/aq0TweT/ZJ
	oseBe+yk9rLi2twt7JeUUTGLibuu7rq3enmKoqS1j70cHslK6vCcYZiBptWe9lU5
	NyamPTigi0Nmtp6UQ88Y5Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 499mad7kwm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Sep 2025 11:57:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58O9cFVV000545;
	Wed, 24 Sep 2025 11:57:40 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010057.outbound.protection.outlook.com [52.101.85.57])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 499jq9j1xw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Sep 2025 11:57:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n3Lpogd3X0ZICW0OyN80ijsmIQy2h3BSuNKB/1OfTRp7bhk/2HjxabMSZ7bOHSsduOzcsUBHf68ttvQsBAPjKyX+nQ6qLYacRQ0MD0o/44cE1bwC2SNZhn8L7e4SnNgqMv9gSBN9dSuZznDIOKDM5yORUbJDhhJVq58rOc33m5Jm+fJUP73yqpIF6oIG/w55eeFbiJN+Pcw1KhsYBYX6XNUFBKHi5YcU3RUaYHJpwKKzUFm+TXlKEm/IArpg5pksVMgu8DnLpTlyIlvAb/6ZBfBwJ70b5pD3W3w7zBfLPBoqHZ8q6Cb2veCiI/sAix0PEH/V5TChBNmkxtUEsYUVJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=reE3LoYpUoqhXQFs3fASObplMg/iluH0g1IB2HiQFY4=;
 b=hGieAKHj71CLY1WeGhXcpVmoMeIojUyjQPoM5nXJ78yjvM4r6WjBSqf9rl03CwCh3fPbVxMEj7lvPHyTKBR1Q07utWrsDjbIF+Xsi8IrpbYzARA6/06r9yRzecC4PTaMqTLjgDL/GWdDNHxo6n/AEBqIWyb+/lVqL88FDJb7xu3/tMP1bgTTw/3nWXfH1BBhe9jcpHwt2JvetULwn4AxbxDRX28nuDUXtpfuaIKORlY147c9uGePt39TTrAuKQCKY70DHn3erBUj/0xubR+v5tC2AdQWBd7aV16/Qq6dIXCyyeEYXYCAIDA6QXRz2B7DQd8wHomAMCli5IeBHaOQjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=reE3LoYpUoqhXQFs3fASObplMg/iluH0g1IB2HiQFY4=;
 b=fdGiQ3YEgqO+wATNaJNfgcyC7YyPQ8s8GDSwbP6Vy2rrgBKeKp/c/UrOCroMpaqEhI/kcWGiixxQPlHH7BBYbFTT61klRRht0amL2Qh5/RTjjWK2LsZUtksEf9UAQ2us0VPfKVK5OiIPE7dMVST62aRp2oqomOnkGZaoIFmUUPE=
Received: from SN4PR10MB5622.namprd10.prod.outlook.com (2603:10b6:806:209::18)
 by DS7PR10MB7278.namprd10.prod.outlook.com (2603:10b6:8:d8::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.20; Wed, 24 Sep 2025 11:57:37 +0000
Received: from SN4PR10MB5622.namprd10.prod.outlook.com
 ([fe80::6bce:37ef:d1de:d084]) by SN4PR10MB5622.namprd10.prod.outlook.com
 ([fe80::6bce:37ef:d1de:d084%4]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 11:57:37 +0000
Message-ID: <5ffadb49-57ea-49e8-892a-5adf17ba3a2c@oracle.com>
Date: Wed, 24 Sep 2025 13:57:34 +0200
User-Agent: Mozilla Thunderbird
Cc: alexandre.chartre@oracle.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, jpoimboe@kernel.org
Subject: Re: [RFC PATCH v2 00/17] objtool: Function validation tracing
To: Peter Zijlstra <peterz@infradead.org>
References: <20250619145659.1377970-1-alexandre.chartre@oracle.com>
 <20250924073649.GT4067720@noisy.programming.kicks-ass.net>
 <20250924074206.GW4068168@noisy.programming.kicks-ass.net>
 <20250924100847.GY4068168@noisy.programming.kicks-ass.net>
 <20250924101038.GZ4068168@noisy.programming.kicks-ass.net>
 <90abf24a-326a-4215-8e13-2e1a2e3194ea@oracle.com>
 <20250924105813.GI3419281@noisy.programming.kicks-ass.net>
 <20250924114545.GI1386988@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Alexandre Chartre <alexandre.chartre@oracle.com>
Autocrypt: addr=alexandre.chartre@oracle.com; keydata=
 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
 swLliy6PdpST
In-Reply-To: <20250924114545.GI1386988@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0143.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::17) To SN4PR10MB5622.namprd10.prod.outlook.com
 (2603:10b6:806:209::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR10MB5622:EE_|DS7PR10MB7278:EE_
X-MS-Office365-Filtering-Correlation-Id: b3afe579-5f01-4bfb-2f54-08ddfb618e2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bjNjSXo1UEJSL0dHQjE3aXBpYktSNXJzQzhkekRXWG52ZXJ0YVRyMGtlbmNC?=
 =?utf-8?B?eVk3OTgzK3hNdEhsc2FvWWl6N0FRNk5tV2ovL1krbCs3ai9aVDhBVFk4STVo?=
 =?utf-8?B?bkNIaE4wNFBMVVJGMDVZYW9FY0cvenh4eXBuSlVaMmJTM2UxdkdsUVNFQkNZ?=
 =?utf-8?B?UmNGWVlwSTZaYnNXSWhaUUE3VkpuS1VwUGhuWGZqTFIzU2ROdkp0OW4yTFRw?=
 =?utf-8?B?WTc0bWdiRDltZ0NVQmdwOWRjaldMZW10U2tjTzdBMzRmc0pVZW5tRHBxL29S?=
 =?utf-8?B?aXlxR2dQZ3owTnIzbU5pNVYzbmhDelhJVG5xV3RuQUpCdjlLQkI2Q3R2WEli?=
 =?utf-8?B?RFdUT0FNV2w3eFBYY0tUMGJwTlcrY1ZodTRMRzJCdzMrUVBYZjZJZUtYRVRW?=
 =?utf-8?B?WWd2S2Exc05zWVR4UDVIMWpEakNqWGdxMGIwN3ZxcnNQSE9hRWpXSkZEWDBj?=
 =?utf-8?B?Zm9Ga3pENm10T3ZOUTVBZ3BjWGE4eVh3bk1FcCtOcjVrMFhPQzVOd21SR2ht?=
 =?utf-8?B?RExPTUZOY1REbHllcWJWOVg1aW1uSVdrSVJURnZMQXhEdDFpb1ZHSTlnaUhL?=
 =?utf-8?B?M0k5YU9xMmZac3haWFo2Mzl2UFl5ZmdFcDBuTmM2TjRHVm1JNElxbWtqOGd3?=
 =?utf-8?B?Y2RDa1JpcEcwVzd3aEZXOWNNWDh5YmlPdERXa3lNUGo2UnN3MmhQdC92cXBH?=
 =?utf-8?B?R2UvTjdicjlPNXZWSjdTV0N3OGVlbjJITEJ4VEM2Qm9obmtqNnY1VW04VnVV?=
 =?utf-8?B?bDFjZitkZUwwdy9CVlFTNUpFN004Yjk1WmZUay9WL3VRKzM3Q2I0ZVZpNDVH?=
 =?utf-8?B?Yk1EMFZLVDdQVVVOai9qNHdkaTlabmNTdEUrVDhNako1Z2hyUTBtZkdTWE9h?=
 =?utf-8?B?TVlmbmJGWUFnTkNtN3plMnk1YTl4QW9MUjJ5QXRyYWwzNlF2QzN1VTF1M3VQ?=
 =?utf-8?B?YmUwWlVmZ2FlaDZyMk82bi9GbjZRUklCanlVRzljY3ZSb2FuUkVXQk9HUVZz?=
 =?utf-8?B?YzkycjE3NkZhdjFBbDR4c2JTTWVhc25IOEZKLzVuVU4rOUpLeFlZcFNCeFU4?=
 =?utf-8?B?WVpXcDE1Nkt0Q2ZYTml0b3Y5NHEzZUM2TXRYb04yUU1JL3llL3VReE1XaWg4?=
 =?utf-8?B?aVVrWU1BNFhrTkxiUHkwSGJ3Qk1SYTNqamdPR09HWUYxU001cUZjRy9laE9L?=
 =?utf-8?B?VVJFc3N0MjBpUGsxOFU0UXVRWHBlekVld2hEOWMxamRxMHJ2MmpFNUpJMkVJ?=
 =?utf-8?B?VkRlbWo0Q0x5NHFrK0s5S21DSGpVd1FvVGR1b0dPUnZOQ0w4MUlpc1ZEb3B3?=
 =?utf-8?B?UnNQUUVSRThLU0o2U0svL2kvMUo4TFRTQXk0SEs5dFRsc2g5K2hjR1JyK3hU?=
 =?utf-8?B?akRFYXc4Qk85TmVCVFR4UHVXY3VEYnlIVUZQM1M0YmgzZXZaeGthKzhDa3Zu?=
 =?utf-8?B?cWdtWTBRYmhXSmM0VlVnVHpGVDA1cW90My9DUjE5R0ovNVZOOXdoUnhDU004?=
 =?utf-8?B?UUE0SU5ydjFYUmRieGxQNUdjazNjd0VQWlNScHEwZ0hjcUdvRlRWYmNWQnli?=
 =?utf-8?B?QmFZdFJEeFVSbkZIdWxseXR2VnJnYUZwVUZ1RlMyeGVmbHJmdS9UN0ZPZXdZ?=
 =?utf-8?B?Z09waTBoM1B6VVU0NXYvemRhaUZtTnFzR2RUcFNoc1ZWUmQ5WHUyaCttSis5?=
 =?utf-8?B?YkdUZENHcHpsWnJsSnkzMW5oeFl1QnhZejgvU200Y0RxeEhITmtIbFZmeFJw?=
 =?utf-8?B?bzE2T1FGbTJuTTE3b3hBNzczeGEwMDIzeU1pOVJEdXIzWlRaMUJyY3V5TW9R?=
 =?utf-8?B?U2pzbXFjb2dic1E0MHNHZVFYZTE0b0dLL0lrOFgzUDVQeFFXNm5VZFRzNVd1?=
 =?utf-8?B?ZkVkWkNxeUNDaUk0bXEva1IrbHZYVjJ6Yk04YXBnRGtjSVE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR10MB5622.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NlhLYlV2cmRPcnEydUZpOUEvMWl3OS9RUENwS2lwVXVnZGlyZ0YzdWxBazcy?=
 =?utf-8?B?cmdWUXo1dUttUFlNanlOV3dyNDZGRnNlUnJndjRIVzFYdW5WcWdrV2VrYzJP?=
 =?utf-8?B?WXpHZGp1c2JaNE5PdHV5SXZnMFZ5dWRRVG5MM21NV05RRFB5T0xHWEVlZTdN?=
 =?utf-8?B?QUs5QlpPTWlkZXVtWnFwVEMwRk5JMjBySFdIUmJWUDIwUTFuK29kU0R0TEpH?=
 =?utf-8?B?YzNhZWlCKzh3Sk9NTVNidUwyNWdmR2FUUkhURXBKZURJTTAyYm9WQVhPR3BN?=
 =?utf-8?B?eEl1OC92cEplWVl1TGVrMGhvMWdPMi9tc2xGRGhWRWM2djhVS2QrdHdybXRZ?=
 =?utf-8?B?QVlmT1VPeVBXbVZBZTc3WVIvQnNHU3QwcktOMU1DVWdVbGlmalhvbVVGMHRa?=
 =?utf-8?B?TVdiY1NZNk1JWVg1YlFibGo3Ynh6ckU4WmZIdGhYVWZwbkt2eWE0VFZQS1lm?=
 =?utf-8?B?eE9LTm9mUWJXbmtwdVhUVnRWOWZEamtGWHJRRG8zY3FzR3doOVBiV2NWOUVv?=
 =?utf-8?B?QkQwRFNnZndBL2swazlmSG5uYjFwUm1HSkNaYWdWWTdZdjRHSzZmL1ZrekdS?=
 =?utf-8?B?bW5TOEU4NlRsZU1reXo1cjlHaGxaeTF2dGlaQ2JDeVRrRjVpczMvNHZXeHFw?=
 =?utf-8?B?VDk5QnJSK0xKaGRubHY3RUh5N3lNRGVvQkNFeUxmc0xOZkg0a1VqOGxocC9n?=
 =?utf-8?B?QW15a2xtOVVqa3ZHWXFBZDVNVy9aTldhMFRVN1YvNjFvQnp1NHoxbkpxU3VM?=
 =?utf-8?B?N0ZzWm9YZFJWQ1gybU1qRkx2NDdPeTBMaXhsVEpBY2t6YnRlSXd4dStLMDBx?=
 =?utf-8?B?K1k2Unl0b1F3eFAwUXFzaEFPdGZlTktWWmFzUkkvUVJHYWsvZFZoelllVi9D?=
 =?utf-8?B?eE9KSWdHNi9abHFHUGJYMElyWFd0WmplMFF1MUpvZHlTNkdnMHJxV2xpaSs5?=
 =?utf-8?B?NElOMXFjaFJqcFV4RXdOdDFWSkxCTnBmUUdLYVd2eE5UeVRoZ1V4WUxrRXRO?=
 =?utf-8?B?QWpvT3FZVFdxaWZYREhrdURoeWN2bjZTU3JRbERFSVpnV0wrODZsWVQ1YVpD?=
 =?utf-8?B?V1IxTHRiYVBzbEFUcERVS1J0MXRhN0V3WldTbWxSZDVSMXJtWFhaYmF3aDJh?=
 =?utf-8?B?R0djTVBaWk5PV0orcnRMQmdqOVVZdyswUUN1OE5BZEp3L1hydVF1NGxSWm4v?=
 =?utf-8?B?c3lqWStZOTZLMkZZY3dDWmNFT01jZzczMVZQN1VkSE5Rb2grblBZV1I3c3g1?=
 =?utf-8?B?b0xlb1FPRWpueGRDMUlrZXFsSW9lakhVcXR2NmQ5eEE5b0FsZGcrZkNrQ0E0?=
 =?utf-8?B?VGRlRzM4NVFQVUpjSWNiRTl1QURwTnlYVnpxNmgybVcrVlNGem1rTmQwaFo5?=
 =?utf-8?B?M2xmempJOFVhVFhBTlpOSVU4TnJZdGJXODhPZXUrb1NyalRPQXJnK0hVb01F?=
 =?utf-8?B?WTY2cWNDVGRPdGlvZDNCTW9ua1Z6OUVGVXpnbWV6TUNtTG1zdVk1ZExUZWhn?=
 =?utf-8?B?ZW91eW1mcVk3aEdHNmtrQmtMa2psQnhnOEI4TGE5ejBZTk9oMGphT0hsT3Vu?=
 =?utf-8?B?SGdQbU9FWnplVnVXV29IVUY2K2Y4L2FYK1Rxc05YRDVZOHVqc3dmakhrbHdP?=
 =?utf-8?B?M0J2L2doWERuUnVySGh3eHY1VkJpUHdDS1JKNWNuU3NaaVZRZVFiYWY1aVNX?=
 =?utf-8?B?K2VscWtQWWNOQVZNTHBHdzFqeEtWeE9GTCs3Tm9FOERrM3VBVDMwc2RhQTk5?=
 =?utf-8?B?a0NuQ2M5TEJrN3pCOXkvaDQ3S2NRNlZ0S0g5cG9rZFcvS0orL1hXSXNwTlp2?=
 =?utf-8?B?NXVjanFuc0RXT3FDMjVBMndXOEVpL1g5MGl1MllTbzBhUmdiQzdKdFpJQnNQ?=
 =?utf-8?B?L29WZ21YSllPZ3VQcmdvQ3p1Z2RkWm1OU29uL0o0dEhjQ05uVDlRTUtrUktv?=
 =?utf-8?B?SlprZDFycFJrTXd1Q0lCa0RPVGxxSUpWZUpFeVhURjNVb2xEZ2J0SGNkMHQy?=
 =?utf-8?B?Smg0Wll1RTZQRGt0dTdJK3RyRE9sdnY4dzdRMEF2UWMxSHBYQlp4Tk1hRkdm?=
 =?utf-8?B?MUtqMjNhVno1WjhCZVJGd3JNb1lUZllJVHZ4b2lYR2xLQzZSRkFySFRmc05P?=
 =?utf-8?B?dWxUeHJNbk16VFJycytmQ3J4UER6WU1hTjV1UWdxTGIxUk5nYUlUUXF5TE40?=
 =?utf-8?B?VkpYSEhWcVozZjBWbHlIVGZOR2dXNGpacmZLeThJekVsVmVOcTlpQytQZDh3?=
 =?utf-8?Q?5h/eMZxuIG0qNzqdhFVXx1eFRRslmuy8QP2ntpFy4U=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pNvhOTqJcU1Pc+HXWQ7m2kXBbT14hneJMqQ6hhZnCu1m1eQZS0E0aEDpKIm0ZNSuRIKqeytZzaN2CpZz5sqh5F4/nuNqAhAQIy6cFc5rE9HTfu3MJ3pew/49RQgKLXPVtFmWT853p2M1LkjkWqyDCAI1PgHkn0Yje+3PjMN+YwpPhXBECxOZ/XcUtA3nQXo2tRgaU3WN3Re5XPuvzsV6AWKm6poNfIap/iuQDd8UdaCPQGCqd2LXQy32vwyIN0n0S+OKZNB8xXVMEBcgbARPECCx0YeszU8MAQwI4/l5h7slYqLLSBPbs2mOFK3PiTpc+T68XeIpSauRNiTk9WgHuBbZoLeMR3BpNPDrE6Yg2aBGABXc1tVpJEDxA+lzye6juvz0NbMS04CeUnBCEKD45UoMjX6LPyMTeL7CD1Z+6INy8EiAfVyCQCe7tdCKYSUFqNecsmHQM/uH+j5bZmZR2kmkvFwEqbk79sEe+gGMpGbmsuD7+mGZO2/a403SUu8BvhQiQt2SjeI4Ea/swe5ytw2aElWJz1zZoh7ST6NLzyvrW6h2mvfS9wTaZqOA7EKu5yfqUzXvovDU4BbJHdx+hyxGEC0XqZ8P9LPJ47lAzkI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3afe579-5f01-4bfb-2f54-08ddfb618e2a
X-MS-Exchange-CrossTenant-AuthSource: SN4PR10MB5622.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 11:57:37.4306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GmmC0pRKinKBaW59LwcVBQppHNgeW9iHkObQkeZEbWsjlt1wEpYIYW8u9rFXF6WhTPvGX2eCByu7XgOKQwPQsdUceSTbgTqHKc0+3apuPl4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7278
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_03,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 phishscore=0 spamscore=0 suspectscore=0 mlxscore=0 mlxlogscore=937
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509240102
X-Proofpoint-ORIG-GUID: V2QfVz3kKGdKfaUi27SiDgaZDg4Y7cQW
X-Proofpoint-GUID: V2QfVz3kKGdKfaUi27SiDgaZDg4Y7cQW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyOSBTYWx0ZWRfX1eaj8V98tnbV
 B10e5haqEzjN5bG8km9kuCk7fWR9GgT0u3U3qnKxhj/N+Rfk3wF9cfvxRzznvhdpJKyF91weDOE
 pYUcvy+A5td+yeHzE13SsVna6DIaAmE4++cPip4r/Q1961bctCXWijv4/oirESgGKZT1wis/ysm
 b3N8xyPdOJ9dV3TGnamxrJOWoa4mSdCL9fOch+x0em2jlcBPOcbV0o0xCjacTt9y8kinHeK4s7n
 ym8xzfSg/d1KQgjwM3ZYtJASnbiEYMXwtogD4sB0J+frwnZqXFCnB2jl5fWWfds7N49U/NuemuH
 VC4v5SLfJ69IBSoGTfqzABAeB5SlmVB31dMtvXEMS3Gx1YFGcy2C3fFFjh1qtkEl+EK0kv5r6Jp
 MtGADUSSeM9jCERWf9xYml1/XYQ99w==
X-Authority-Analysis: v=2.4 cv=Vfv3PEp9 c=1 sm=1 tr=0 ts=68d3dcb5 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=ne-WPo9khOEIYAx7N1sA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12085



On 9/24/25 13:45, Peter Zijlstra wrote:
> On Wed, Sep 24, 2025 at 12:58:13PM +0200, Peter Zijlstra wrote:
>> On Wed, Sep 24, 2025 at 12:52:35PM +0200, Alexandre Chartre wrote:
>>>
>>> On 9/24/25 12:10, Peter Zijlstra wrote:
>>>> On Wed, Sep 24, 2025 at 12:08:47PM +0200, Peter Zijlstra wrote:
>>>>> On Wed, Sep 24, 2025 at 09:42:06AM +0200, Peter Zijlstra wrote:
>>>>>
>>>>>>>>     d051:  perf_get_x86_pmu_capability+0x51    | xchg   %ax,%ax
>>>>>
>>>>> That libopcode is 'funny', isn't that typically spelled "nop" ?
>>>>
>>>> Ooh, I see, it is "osp nop" and yeah binutils also seems to do that as
>>>> "xchg %ax,%ax".
>>>
>>> Yes, "xchg %ax,%ax" is NOP2 (opcodes: 0x66 0x90), "nop" is NOP1 (0x90).
>>>
>>> That's one more improvement we can do: identify NOP instructions and
>>> display them as NOP<n>
>>
>> Right, I have just the function for that. Let me do a patch for you.
> 
> Bah, I'm having trouble with the makefiles, but we sorta already detect
> nops, and the below should sorta work. I'll improve decode.c a bit.
> 
> --- a/tools/objtool/disas.c
> +++ b/tools/objtool/disas.c
> @@ -273,6 +273,9 @@ static size_t disas_insn(struct disas_co
>   	dctx->insn = insn;
>   	dctx->result[0] = '\0';
>   
> +	if (insn->type == INSN_NOP)
> +		return snprintf(dctx->result, DISAS_RESULT_SIZE, "NOP%d", insn->len);
> +
>   	/*
>   	 * Set the disassembler buffer to read data from the section
>   	 * containing the instruction to disassemble.

Cool, an easy change :) Thanks.

alex.


