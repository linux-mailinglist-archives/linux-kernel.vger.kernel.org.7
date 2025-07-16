Return-Path: <linux-kernel+bounces-733954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DFAB07B2B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 18:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C62843B99D2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 16:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9CC2F533F;
	Wed, 16 Jul 2025 16:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="EQmw5zwm"
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE660EC2
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 16:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752683298; cv=fail; b=EVzKQiIjGs+67L+L1BhZxMJClEzAsRe/kJa8V0EBYa75cVmS4FMtRvpv8cXbcArHje6RSSEO/vPwpq16/4cn19S+G1QVnsWermGJGRMwWw4G7lUA33NJr78Vawkw/jgO7FVvLs0QmzKNz5KKVSN1fQDXA+Aj+dOjB9LNCYxkUTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752683298; c=relaxed/simple;
	bh=dnA7sszdQdK0JpshHFHaaWzzKE+mx7AGClutRV3NLOI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cyWytme3zEEnfBtRgW56nl+r/S4kVXIb3yD6uzK4OXVl10wPfGfo/SAJLwTwNLGwO2gC6JqyKPqHyoYnYeYdPAlICPGqphgtcKeUAoq1L7oqkNvMjYUd77S3kYEg3Ww/OMDF4A0knHRArnW9p/eYEV9ZNmLH4pOfdXjcQtW/EFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=EQmw5zwm; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GE5Bid019320;
	Wed, 16 Jul 2025 09:27:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=a8nlC7jPbwR7vv1jz2yM8BkDjVc7OyteJuDhJYz0Nck=; b=EQmw5zwmyOU9
	cOlGMxZA6b/lhsa7xlFJk00fM0s1V/Sad3OdNhiGk8T/nL9XukUt8kiJ1Gfa5xW6
	CBhPz9y0vC2sefIbw4xJcqTz12/3nWf6A5fN6LFRxNp9b8cOIdkRdlvR4othE8sz
	BJCScNV/p/aiE2P/voiWQHzaeK7kyN+ys0xAlocnO2O+c0ve+ItmcBOFFAQxsKfM
	PX1RyOkMgyU+yHg8veEVG9QvTCpDqCcwjaqhNT8c25uUc53VN4jjFl/QFP9Ih2yn
	XC6M6Z/xx22uRMTnC+1G+fBdOgx40Rm9/FUqSk8hVTC4xItvFoqY6kfGN8gLwpaM
	bgiwnFLxTQ==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 47x349mgpt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Jul 2025 09:27:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mxYOJUwIP9MYUPpIjpEufeYAyu9NBUA+tVQ0VNH3P/svOyp1SgDQMs0oCzg4S6ZbZ3ADTSIEL+ZjriZzmz+vgMC+eU7wfhzgItGVBnLwjeJ28ooz1NCKUDeydH5/fQMvP6rsh72bj1kF1jJMQDZZldBRPSlJNtJ7B4ThxGCuhZCHj+kSN2z1aa5Y+XuGVuv04vhbU5uwVxDuCRlpFxOQy5sppmqdW1lRSAKnQOihiXFZvJ59VTnqvtsto9zR91nz0ez4Olk5OcPqr1zVAlj51DjkSxJFOsQmyzR2rQwu7XwlEaEM2+0IlWxgqImDDF0K2oq9ZUemwxL/vStcDQti2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a8nlC7jPbwR7vv1jz2yM8BkDjVc7OyteJuDhJYz0Nck=;
 b=wkmq7c+njBERYki4j67zKhilm9sotKeOoCGx9cdcVjxrQEcVePsYpXQI+H7WNS8un6GE0lG9Yaty8CXqaDeKHoEH/kb/QUCyxq40DbItE3NSFIn3UC9NQd8I3OOn4ClZePHcY5dqyILZWNj/rwA9y5ECkkxwSUHnpvmxi/ZwFzCk1iTq5YEmQT/E12PkRqO/N+QM5opgcTjG3tb5ran1V1URWJNtof6mgq3Z0upd1FcCn0shW2e81PDcSCcI1DJzo8AhKsczvclOP7JtvOzf8bvNgr1+Omu6skdzhJz5Nx2LE8HgxR+Y4r7kmUxT8QHaPGADR4celSBYqJYU7w5gsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV3PR15MB6455.namprd15.prod.outlook.com (2603:10b6:408:1ad::10)
 by BL1PR15MB5314.namprd15.prod.outlook.com (2603:10b6:208:385::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Wed, 16 Jul
 2025 16:27:57 +0000
Received: from LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::2f8a:961:d95c:3b35]) by LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::2f8a:961:d95c:3b35%7]) with mapi id 15.20.8922.025; Wed, 16 Jul 2025
 16:27:57 +0000
Message-ID: <7693dedb-0185-4344-b46b-87dbf69e7ac4@meta.com>
Date: Wed, 16 Jul 2025 12:27:36 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/12] sched/psi: Optimize psi_group_change()
 cpu_clock() usage
To: Peter Zijlstra <peterz@infradead.org>,
        Beata Michalska <beata.michalska@arm.com>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>
References: <20250702114924.091581796@infradead.org>
 <20250702121158.350561696@infradead.org>
 <0d86c527-27a7-44d5-9ddc-f9a153f67b4d@meta.com> <aHdMTdPeQ1F6f-x9@arm.com>
 <20250716104050.GR1613200@noisy.programming.kicks-ass.net>
From: Chris Mason <clm@meta.com>
Content-Language: en-US
In-Reply-To: <20250716104050.GR1613200@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0P223CA0005.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:52b::22) To LV3PR15MB6455.namprd15.prod.outlook.com
 (2603:10b6:408:1ad::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR15MB6455:EE_|BL1PR15MB5314:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f507f49-67f6-404c-8ef3-08ddc485b8f2
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M3I4MTBLR2NGWWZjcHdVeWtwMWNvNlJQN0FIVzJXODQ4V3hxUHZoVXpVcmVp?=
 =?utf-8?B?Z3d4ekZQTlNYcGpsVkRzeUlvcEFZN0VIeklXa21lM3dnN1dDc3dabE5MSStL?=
 =?utf-8?B?RXlCRFVxWUwwRytBNWFGNzRaT2lWaHI2VlBzb0dIcm1JSkFROUZJTVJsemJj?=
 =?utf-8?B?NDNiVDkrOFNoYWxlYTJSR0ZwcUt5TU1raGtHYTBRRGRNUTc2TDB1bkhSSmc1?=
 =?utf-8?B?N3QvY3hJV2NKSjBjZ0IyMnpQNmFyY0lLalJQdlYxbGl2c01NZmo5T2ZaSXR1?=
 =?utf-8?B?RGd5WlkxVkdCSForaFFaeTR4K202ZGlaaEQ5S2JSSG1VQVVhZjl2QnR2T1VT?=
 =?utf-8?B?RXJYaFFNMHh3Mzg1alJTLzY4cVBTUlBIVFNNcnBNNnBUam40ano0ekgvZ1F6?=
 =?utf-8?B?VTRLd1E5OUUyMW1rSnlwL1oyQ1NWcERSeW94T0tnYlExazh5NzJhUFpOT1pG?=
 =?utf-8?B?N3p0NEMrM1lDczFCdHowYW5sT0Rab3V6ZW5ZeFJsUjFwV3ZTcStMVjlSUGpU?=
 =?utf-8?B?R1JjbmtMWWc0N2ZLYmhoa1Uzcnd2SzNLVGxWMDIyN0FJWGdsMGYwcjc2aVJQ?=
 =?utf-8?B?b3B4bGlmV3lBWU5mRGFlZS9oN2hCYy9QL2tIZDkxanAxZEs1bGdBMFF6VzRw?=
 =?utf-8?B?em1xaEVxSm41R0MrbklqMzR4M0FyU3JFUmtEZzRwM1RMUzZsMEpBSDdjcVNo?=
 =?utf-8?B?b1FOMUIzOG9vdkxqeHA3VWFESURubm04LzhzU01KME1Qa1RzN0FwL3RjNEhI?=
 =?utf-8?B?L0RpWEFGdWxFdGRoQUV3bXJ3N0xGRzM3WFlkTnkwQW5Fd1IwT1VGUUpJdnhh?=
 =?utf-8?B?QVN2MFgwdTcrZG9Ya09OVFJ2VEVMQXNWNW90K2x6d0pmWW5pdWtiRVhtQ1VG?=
 =?utf-8?B?bFZ4dU1odUFsTTBsQWV6Y1IwMCtLazBEcUpDeTRTOW4rZ0ZzYTVDRk9TaEJG?=
 =?utf-8?B?bS9XRUVwMm5DNGFjUndIOXVvU2htR2w5MkFLTWM1ZUJlV0pReGlpNkdUem9y?=
 =?utf-8?B?aUZsQ0phSHJxSXIyMjlyc3k5ZXdyWDBGdmxYMEhPUTR3bVoxajRjVDFXNUVJ?=
 =?utf-8?B?U2ZadHA2aGpNc1pVR3BiNDVJSTNqS3NKUDVWU2FHNzM0RkQ2TkEveHd5amxZ?=
 =?utf-8?B?ajRYZVFkSWFVeGF6dFdtVEgvWEZPdWZtbFhyMWxwWmZZOHJKU0lVZnVrODRi?=
 =?utf-8?B?UlFhclZCaGEybUFpUDVadjZYbFJXT1JGd1JpblZiOFNySkp1V01UME1VZC9O?=
 =?utf-8?B?ejhIdFVDYWJOWHFmT3lKcjFYcFNGdk1pb2g0Ym85TDhRSlZlS2ZQUCtvN1dO?=
 =?utf-8?B?STFOVnM3STNQczZ6SlFRbHJWWkR0eDhWTzIyZzk4Yys5d3RXZDl0TFUraStt?=
 =?utf-8?B?R01BK1FKWTBETnUzeVZMcWh0cnpYYkNLQTViVXZRaWEwWU1RRE5ZTE5OZWc2?=
 =?utf-8?B?QkRDS0dvdFZadHhNQWEvRnVoZmhjdDAyZERWQlBsTmgwSzR1TVNvNTBaQUxw?=
 =?utf-8?B?MUU1WW95ZWFQYzUrYVdrUnBkWTBEWG5mM21tOFJJWTd1V0VXbWpFeDNEVGFW?=
 =?utf-8?B?cURGdnhjZEMwTnYwN0JmMGdYNUtWMVp5NUdsZzhXZ1IxM2g5T0VWNXVyWnZh?=
 =?utf-8?B?WEJhZzhrOG9YSEo0S0lveW8xTkcrSHNIMG91VS9PSVlwZHhsbjNhVHAzbXk4?=
 =?utf-8?B?NnY2WDFPdlpVZmM2bXVqUGZmZlJUMVVqWFovWGh0OStSVUNmUFBXRWh0ZXZP?=
 =?utf-8?B?N1M3OC9TWVNCdmhBMnViUWNLaE5OZlRLSHUyWU5tSjZYM1MzMTZDc1hlVU84?=
 =?utf-8?B?ajZyTlh1TmdiUTVSOWZSZXp0MEh5b3FDZ0Q1dFRySHVtc0NSR3Y3Rkdjd0ZS?=
 =?utf-8?B?enc3Q2hIQzFCeFMvYURqSklOMFZYclAxSWdXQTFSN0UxdkVzOHByK1lYV254?=
 =?utf-8?Q?t8gr0ykqvlE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR15MB6455.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGRTQ1FOaDFMSkJLam13UFBBK2E0YkRhNDRSUENOVnRxVGdFMS9jamVDenpx?=
 =?utf-8?B?N01MRk9Sa1hEMnBmaEVucmdIMVgvQ0pvRERIL2lqZ1E3ZFpoVkNsY2tYNDM0?=
 =?utf-8?B?alBqNDVOeUFwdmZzTlJVWnZiOCt3aWd5UDI2NTdlendTckVLREsyTU5sYitU?=
 =?utf-8?B?a005R0J5d200aDYzZnRrNU5JVWQ3ZTZxUXVCQ05jbEtvNTgzOXlBWWpqaWxZ?=
 =?utf-8?B?cmpnQndhV2ErdWJaRnBDZjdVdjEza01qdmUrUmVrK0lnaHVwVytMTWprK2g2?=
 =?utf-8?B?MEwwZExjUGtNaVVtaUV1RDArdW1QWURrZlpXaW9HT0krQ3h6Z0x4amtISWlT?=
 =?utf-8?B?WlBHcHFOc05MLzJOTkhDWW5NSExKU2pqY0VrY0RERlV0TjYrVWRqQ0p6OVFF?=
 =?utf-8?B?dEhHM1lUWklhdlJ5ZlBkOGl6QnFvOFFMNmRZSHZWNFduR2ptdmJPcU51TTRO?=
 =?utf-8?B?MGxrazV6WjlXOVFlc2VtSlhDL00zanBJcG9sOGUrbHp1UWtUQmlyV0lRWGJG?=
 =?utf-8?B?QUI1d3Y5SHQva2pIM1VKWm1SR0xObkVYQVowSkxIVkxNeTF0TjFrMFBpZGtX?=
 =?utf-8?B?ekJNbmdBaFVhZldzRE03dlVFZkNEM2JJWE03Vy9pRXh3eVBMSll4NVU2Umd4?=
 =?utf-8?B?UjJNK2Q2MVE1d1lRdXlMT0pGREZZVUg4Rkp5TkM3MmJwbGRyM2k0UE05VS9C?=
 =?utf-8?B?dGRkaWZ1U1ViMy9FMjRjQVdJbk9VU1Z6UzhPSThwT3lHM3c5MzBreWdHNVpi?=
 =?utf-8?B?V0Rmb3E1czZQc293cFV3RUdkRFRKdHMzUHhrU2JVdmg4NVkxNytXMzYyQndD?=
 =?utf-8?B?R0FjWWZSYzR0SXBqUHo5R1lmeWx3NHJPRG9GUGlaR0N0OUFrcm9CT0Z5VHAv?=
 =?utf-8?B?V3c3OWZQWnNXeDZnSmZOL3VQV3V3aE0rRm10WDRzSkFsOG9KRjVSWGVVL2RO?=
 =?utf-8?B?V2VXYnFjaFFkeHdnejdrSVEwTzE0MFU4eUI3NjdYVjFsZW1wRDJIVkN6TlA2?=
 =?utf-8?B?ZFhjdzY2Q2tXN1lQNlBwNUkwTVlvQ0pLNTRtcFhldVhjbHlVK2R5SXFlL1FP?=
 =?utf-8?B?TE5IOE5JSHZ0cU5xdGdUUWkwcTRya0NDeFQ5c3RkbGcvZUI2dEF1c2lXZzF2?=
 =?utf-8?B?SHZxazlXVEZLUGswWWpSS21ibjNUckVJaTFVam9JY2lOc3pYcEcrMnl1UDBv?=
 =?utf-8?B?UmgweEtZRmkzeEVzU0VTcS9RLzl4aTcvWHhXalpkdnBzZlowZUZOdXA1bUF4?=
 =?utf-8?B?ZVVJdlgyMmNQSFI4WTRhemcrblZKV2dJZ3VjUitZRk8vRVhTSWRTWW0wR0do?=
 =?utf-8?B?MVRCUVYweE84ZisveWt5MFR3NHJvMG5PRFBoUHk5QnRYQnJKVzZPenA5QWxq?=
 =?utf-8?B?bzE3c0pOOW8xQ1B4ZDRSSlR4TGhTLzFxNkYyMG4xbitGVm9aTncrMlM0bG1V?=
 =?utf-8?B?SXFNWjZBVlFDZkY3NUtnR3E5NmxwMkFtQlViSkVPOWhHa0xmWEowTnRNME9n?=
 =?utf-8?B?VGhQN1B0VCttTExHZ0trS2hvV3p1djRZSUxlL3loZ1Q0c2hOZkN3SzhJb1g0?=
 =?utf-8?B?dStCNDNaOXIwb29wN1gveXFZNzVBeVBJTmN0V05acFZvcTEyWUpkMXN3YytO?=
 =?utf-8?B?Z2NRT01xb1o2RC9VNkhMb2lQVnl0cGN0bkZaOVV3d3NmT1hEZjhjYnBnYUxi?=
 =?utf-8?B?emhndStoRk40eDM1MmhKRXBSRjZlWXM2aWlIVW82K0d3TDBMaW9YdGZsTkQr?=
 =?utf-8?B?N2ZFZ3p4K1lTeGl3aVh4ZkF5a3pYNkZjK0Y5eE9HVGtlUXhna09vdlhQU3pj?=
 =?utf-8?B?cmNLb0M0eTBEZ0d0T1dLd1JmQkc1QTRSL0krTTBteFU5a1haZXV0VEtMLzdD?=
 =?utf-8?B?UkRFb3VtZTZEcDJMUUN2QVRvNlJXYUU2OWhSQ2MyVWFTalRuMzN0ZG5yVHdK?=
 =?utf-8?B?OFJxbTVQazRxaGVaZks1c3NBd215T3lwaXc0VjBhYWVza0VUcFRCZ2d2ck1V?=
 =?utf-8?B?Q1BLcTJtVzk0aDZoaUFwUnR3K1RvNDBEamh4enVISGdoRkhxdXBWeEVpTDRS?=
 =?utf-8?B?dDA2c3MydElZeURZMDBPZ3Vmd29MU05ybVRkUXlqQ2hKQXpYaUR3R3FEMzg0?=
 =?utf-8?Q?UFc0=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f507f49-67f6-404c-8ef3-08ddc485b8f2
X-MS-Exchange-CrossTenant-AuthSource: LV3PR15MB6455.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 16:27:57.1084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5gEV4NC0ms52LgDMfpSY9UZv64eBxSixU84zXlAXwbpFGfcpmSrOaTzA3ciae/53
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR15MB5314
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDE0OCBTYWx0ZWRfX9PTAKsgxl4w2 jK+bC4tw+4QStYU8hVChFy2GqJ2pyJHITXWBN/RlOmEVTBZWXCT56UM7CXjHUV6Y4fqT1/j/7nB R4du7Hh0+L3Vp2+3vFCTImnQfqNpuRIadoorJ5UEgQUS4fQNq00r0RQmorOk6MHKwmfqGAXDqwU
 MdO9uEU38x16H2xuuB1heR/n6Ypx1F1Lpgi5Dx7noxPhzRSCQD0Hs2WY6OIXkWAgx11YH7oQ7jz BKw8UOUw0tYkviOc2FLvsIXmyyyKyGT9C9EKMzW0KuQAz1rBaZLLBU9lC4Y/9rB2b/kWtL5gkwM cWBjfygPnWh9WZbO4CQ1Di3SogZXY6WbtlLmUqBz6BapSPGZEWFxDq01qMmlXpvlGlguON4DbU6
 4DChkNfoo2z5PtZRdOWMdbsEvUGB39Hf/kW9fzEN+w8ylWGjaHURJmOmsc7QWdbyyadiw2JU
X-Authority-Analysis: v=2.4 cv=K+YiHzWI c=1 sm=1 tr=0 ts=6877d30f cx=c_pps a=n4RqILhGRq/0WckfvtHWag==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=bfjC5ffAdZk8xKmhwxgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: mZ2D3zNhMRtvGR7pl2pxIp43IgxtffiZ
X-Proofpoint-GUID: mZ2D3zNhMRtvGR7pl2pxIp43IgxtffiZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_02,2025-07-16_02,2025-03-28_01

On 7/16/25 6:40 AM, Peter Zijlstra wrote:
> On Wed, Jul 16, 2025 at 08:53:01AM +0200, Beata Michalska wrote:
>> Wouldn't it be enough to use SEQCNT_ZERO? Those are static per-cpu ones.
> 
> Yeah, I suppose that should work. The below builds, but I've not yet
> observed the issue myself.

[ ... ]

>  
> -static DEFINE_PER_CPU(seqcount_t, psi_seq);
> +static DEFINE_PER_CPU(seqcount_t, psi_seq) = SEQCNT_ZERO(psi_seq);

As expected, this also works.  Thanks everyone.

-chris

