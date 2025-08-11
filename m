Return-Path: <linux-kernel+bounces-761701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64EABB1FD84
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 03:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61FA31756B0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 01:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF56323FC42;
	Mon, 11 Aug 2025 01:37:50 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADC235971
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 01:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754876270; cv=fail; b=nqXTNLrB8zYXvsG6gjbWac+BMVw/all0IseB+OXbSKGRcz0gzq5IrM/VFZj/QMblZUTTtKdyR+IRiglwkuMZl+AreFK7fGwKBhqjriU8Z/50mGOPvjWcFSU6amFw367s456pXrmYA/lupYMO2AirppjAtEZz7UlzEMNNE98n75g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754876270; c=relaxed/simple;
	bh=4PXZEnpPuqoh/YHSLC4qEPkRdkb9mJzEo3kSKb+D+ew=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MhM6bKr9/MT/4qWa85BZHGYYSHEd68CB3j5oA9Qxfskv5lxNVHrB3W2W3aP006sAZ6G+AzQ7D+O6stR4m/Ad0w3+FsvEldIXZYONaEdh73nBKqFkZHJxMtxpAHAe+U4j0sR1B1+7oyA4dAsaNAsfkE0c3f6cwldj7dnrjeY0Y/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.8/8.18.1.8) with ESMTP id 57B1GJkk1777086;
	Sun, 10 Aug 2025 18:37:42 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 48e5uhrvfy-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 10 Aug 2025 18:37:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=je3UHooqNawtvomJzYcAIhWGIsPKTYo11iLR/aMTjL1VWww9o1W4J9wXxnOleU47FRHv5yCuiN8dlBZrN3YjZ1+vYc1HGeBv04TJf6Bk6IewiCmSBnT1y1fqYsO9ZNR7LSe7u4AJmCG0ubIuyj8vzw2FMJQprhwOHN1GEorV5rIoeVGRC4EMEjfj8FD/LT1fas++E2oJsghlV74VErP4EAiwZXguDd0w0wXopTEyFnZA9whAnZ22SDoE9CbT7yiMRVaOILA7QBW2M7RfgFu2BAAknrCTJEVt1H7kc4HIBTL8cIDNlFngMKmsPq4iwTIjJKuqSfm4R7EuUGjN/C1Atw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f4+PQMDOQZHuRF5aAl1wSyc4pYrBDCb+NYByO2wkJ3k=;
 b=xl1xrRBEuP1ZcDswY7348xi5PFLVMmC3kraRW2E2RKl4p4wkX51NAiY+3Hcp0AvGFZaAY1zHjUzfdls6ok+tAI+/So3G7I09mEugAKRJJ/72AKxnoSeM32X1ZsGYtY6t2OzKdcFr1vZbrkPP45hBmca8NXG25tztz+AW/0ZekbiSlVYdNXs+u2nEncLmn6Jy9UVHK4dWsjojy+br+8B2B7Pn8YF/FiyqQ/OedRJIpaifXOHNyUHVwGCTI4nvlGM/sG6dTOfifAAZ9N2JNUu7tysN1Z+yFrrrmsVLWJuomGBpOR/Gvc4xK09o6Ut/UPEa+Gt80pW1hLsyoqsOXAMGVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH3PR11MB7297.namprd11.prod.outlook.com (2603:10b6:610:140::19)
 by LV3PR11MB8602.namprd11.prod.outlook.com (2603:10b6:408:1b3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Mon, 11 Aug
 2025 01:37:38 +0000
Received: from CH3PR11MB7297.namprd11.prod.outlook.com
 ([fe80::9196:38bd:6b0:2d0b]) by CH3PR11MB7297.namprd11.prod.outlook.com
 ([fe80::9196:38bd:6b0:2d0b%4]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 01:37:38 +0000
Message-ID: <33e72aba-d8ca-4a9c-b761-f83a41f8fab0@windriver.com>
Date: Mon, 11 Aug 2025 09:37:07 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] tools/build: Let link command read option from file
To: Ian Rogers <irogers@google.com>
Cc: namhyung@kernel.org, charlie@rivosinc.com, james.clark@linaro.org,
        linux-kernel@vger.kernel.org
References: <20250722061335.285249-1-changqing.li@windriver.com>
 <20250722061335.285249-2-changqing.li@windriver.com>
 <CAP-5=fWE4y=t0EF0zwnYyyacncFH0xpwJQGAWW3T2Ruu=STotA@mail.gmail.com>
Content-Language: en-US
From: Changqing Li <changqing.li@windriver.com>
In-Reply-To: <CAP-5=fWE4y=t0EF0zwnYyyacncFH0xpwJQGAWW3T2Ruu=STotA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY2PR06CA0001.apcprd06.prod.outlook.com
 (2603:1096:404:42::13) To DS0PR11MB7312.namprd11.prod.outlook.com
 (2603:10b6:8:11f::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB7297:EE_|LV3PR11MB8602:EE_
X-MS-Office365-Filtering-Correlation-Id: 25983d2c-ee5d-409a-d8d7-08ddd8779bb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a3MvZlMyQ0o5bjFHUXBkQ2dOZUJsVXVmMWR1SWJkbmQxaFF2dEE1V1RUV1JQ?=
 =?utf-8?B?b2FGZXNLUXB4RW04emJBZ2QrRHhVaFFzTWI2YXMzN2xPSVduREtPYWFhME5F?=
 =?utf-8?B?cVMyc2QzcTlhU1doMGxJZXhGUE1TTjNmTnhVYnVualc2NWhGdzhLRStGWno1?=
 =?utf-8?B?NHh4QXZqdzFCdE5kZ2VYUWs2dG1BYWZ1SStYaTlWSTlzMUJlRit5cmp6dHFr?=
 =?utf-8?B?ekJ3VjBORllBRG9lQ0w5bm8xNG9CK29JR1pYcUpQQlZacWxJejFDWHlyMnBk?=
 =?utf-8?B?TStJbFJmakNPOE9CZGUyTGFtSEJsZkVoQjZFSUwydStJQ2JlOUtkMGxsdVFz?=
 =?utf-8?B?ak55bmhFTkNDVThzVmlLUVZFMXhGZG95ck10S1lab0RFQThHenJTOER3c3Bw?=
 =?utf-8?B?Y1MvTnM1bnNlYS9qZXVzbTNmOEtaaWZ6S0s0VitJNXh1WTFnYXJ0eGMxTitL?=
 =?utf-8?B?VjRsU3lXU3RLS2ticVMzSjQ1YUNLem5vNXBVQXc3M2p3ZFlITHh0RUZWNkxO?=
 =?utf-8?B?NDhOdDJwWVZ0aWdEWkVnTVRsYk5uenppZHJmQ3NHZ0NvM0xDbjBnY2o4Yktm?=
 =?utf-8?B?eEVpUEVhVDh3Zk5ZemkwOENCN01SZTZrZmgxakdSRW1mYmxkVkFIZDZjNmEv?=
 =?utf-8?B?UkFOVDFHRGVueU8yeXJ1ZmRVYy9aQ1RCR1BxZjBXM0VWN3J2dHB6R1pRWWpi?=
 =?utf-8?B?bEo0MnRlb3E4ZGhzQnI1NXJvRFowcW5FUkQxK1FlREY0TTJNZkxmbjJ1TjdE?=
 =?utf-8?B?TFFJbWVFQkRFUjVFY2p0c1BWcktENFlHZ2hnSFkyUUlIWDdpTjRMTEFjVTBY?=
 =?utf-8?B?RTMycmtYajYzVng1RkV0QXV0M2Z3ZVIzeUswWmprcCtlWnhEVUtnR2FYTFZ0?=
 =?utf-8?B?R0lNbEhaMmZNS1FpU1RHZGRlZWhLTVk2OHJ1RE83bmNTZTlka1ArQUtIamx2?=
 =?utf-8?B?MTF2MmtpbGhFVXYvbW9tS1M2Y2pnSkRCaTFxRzNIK0VJZ0kyRkFoYk9Xa0Mv?=
 =?utf-8?B?ckpDUzE3TC9pSHFXRmJGSGwzNDlQZXlzVDFVUlkwNVg1NGpoejdLb2gyZDRl?=
 =?utf-8?B?VGMydmZZcGcwRVRCZGs4T01jVzJnMDB5WFBYLzhUVWkwOVZQQzlRbzdQYWV4?=
 =?utf-8?B?YmU1TDdJdU5tRlhpOUs5cUpWUmxDRHNjUk8xblhYVmhLdWJ0UW1pL3Yxa0p4?=
 =?utf-8?B?MTA2MEVRVnd3K3pxQ0J1eFVjT2YvWm1HQXdCWjJCS0YyNUhJa3QzN24vRkN3?=
 =?utf-8?B?akZIWVZ5RCtnNWxqdzVlTjkxSDMzdFB0NUc1dFJHSy84NGlYdldySE5OaG5T?=
 =?utf-8?B?WmZUNFUzRUtXbUxrT3YveDh4VTFNbFhiZW01WWppMzdaY21lTFBxaHBxb1F3?=
 =?utf-8?B?QnVMcUs1OVBrNUdmay9ubnhwTDhzRnovZjRBZDY5NWlwR3hjZkdSM1BXdjYv?=
 =?utf-8?B?NXJjZWdRSUZsS0trYkNaMGhZbUpURjdxak1PdndlNTk2TTJNeWRBUXgxSEc4?=
 =?utf-8?B?UlpZMnFlN1VYT2RIQjF3dVJWWHBwa2JRYjQ4Tlc5Rnp0TkR6Um5RVzlLdmMx?=
 =?utf-8?B?eWl3SjVqUnJYTnRqdFdkWDlsdllnNk45QXFBUnR4aG1xOXFHTkpoMDlrOU9l?=
 =?utf-8?B?RVg3amlOWTVzdVhGSEtadmRsM2UrRnNrNk1vMUtVVHQ3WWZBY1FBUG1xM0x2?=
 =?utf-8?B?UElpRDlNMVlDbURjT1lORVRkRGRtZ1R4K2pyazlnT0ppcHRuOFRsUWVodGY2?=
 =?utf-8?B?QXlKTFpTV1dZZHZYZ1R5ZlVNRUxQMjFGR3JZbjN2STF2S3lRT2ZYUFRnaXRW?=
 =?utf-8?B?TGtpZEYzZWFrdnFySEp3alFKRy9ia2QvQzNmZlBtK2l3OVc4VVlxLyszUjBU?=
 =?utf-8?Q?s91Ld5kbQ8w16?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB7297.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c2lpL1JpT0hFTzdUNWhrUXU0Z1VDalFGZXZVTkVhTFFVdUVwZzA0VkMydTVp?=
 =?utf-8?B?a2RjUi9pTStualZoa0laYjV2L0M2eG5wOXAxQU5IN1N5Vzc0S04ybjkzMmg0?=
 =?utf-8?B?azNOOE5FSm5zM0hVLzVhQTJJN1dZVGxtRzZkclBoN25FQnB4WHl3WXFIN1NY?=
 =?utf-8?B?bDFrV0tQMW5ia3lENXVxRVUvUmhXZjJaVXhPdHlJQVhCN3p5VzhSMC95d0V5?=
 =?utf-8?B?RzNmWmRHK0ZnNmRtZEFrd3orcXRkVTBEMFBic0gxY3gwcDJjcFNWd3MvNEpC?=
 =?utf-8?B?ZDZ4b1cyWE91U2p2eGFQNnF3RUFlUGRHYmV6bkZLY1JIQm5TY0xmVUpweFQz?=
 =?utf-8?B?Qjl2SFIrSEYway8yaHcwampOb1Y0MHl0QmtkZ3JKaDJvUU9uWllNaTlWN1dG?=
 =?utf-8?B?WUVHS0RoWENoMG1ja2pLM20xdkt0MUx2Y2s2Qk5VQjNtMEZOKzZVMkJNMDBa?=
 =?utf-8?B?T2VYNXRlME11MWNQUEM0TllQY2RxOHhhL3RNaUdjTk55Z0lDNnhCQ3RpaTRo?=
 =?utf-8?B?SFFBUVMwSjJoQVV3K3pOWnVVTmN5L0k2b21DUnZraG0wMUR3MnpaOUZqMFN3?=
 =?utf-8?B?dXAxSHlVcnZCUlNxb295SC9uMjQxU25wVklVVXRIVkQwOVhTNnNDU2lvdE5W?=
 =?utf-8?B?QXdjd2s2QTQvRXlEL0piaE1vdU13TjZQUUc5ZlJlcWVzUVB4dXdqbllFbXBH?=
 =?utf-8?B?cEtjMXFmRlVFbTVhYTY2MDFRVkRqNy9WT2dqelhDRnZFazZLRFBQVTRTeDZr?=
 =?utf-8?B?cnAwcDNKZWlxMElHTmlyRHdqT3Y0d1hKdXRpNmZjbVpGdEdqVXlUS1hobm5W?=
 =?utf-8?B?VlBySEhubVZXYzd2VjgwcXprZTUweEJxZ1VEQ1M5S1l3S1c3WHc3NmcxVjZr?=
 =?utf-8?B?OGFiWGw2RmRQYVl4OHZLSmoweWRUNkk1ZkVLRjB1MnkwaTZyYVhwOW5jTU9J?=
 =?utf-8?B?eFFBNjZFZHJqSnhQak04WW5YSHN5K2xEd1Z2MzJKS2ZIOUpHSVJ1TU9ObTFv?=
 =?utf-8?B?c1dKdlNwWk5FMkNRQ2ZrQmk3WmJFYzVIc0ZYZGZZNkg4c0RPZjNDMGhRT1Uw?=
 =?utf-8?B?d1JqMUVOZmFabW1DRDFKTmhKVHU3TzBYVHhmUzVHOEY0Ynk1aENMV3EzTllI?=
 =?utf-8?B?Zmw3UG5tQUF0TnJCKzZaK3Nkck9USlRHVGs1b2NhQ2d6NE5VSWwyWUtlMXRx?=
 =?utf-8?B?K3lQalJGUzRNYVZDVDVkSDJhd1hDS2QwbjdKNFp5SmVyQ3N2TUlJL0tMSjVl?=
 =?utf-8?B?UUdQS0xDRW1zTXRLRElvQ0ZPQXROTXJkTWN4M2VCN0RtK3Q1OTkzSmZRd3Ny?=
 =?utf-8?B?OUloTUErelhsSmJKRTJZL05FZm5BZmNIYkQzWW1ZUEloalc3V0ZsOXdOVUFP?=
 =?utf-8?B?clNoSG1ldnBoVU9vRE5nOEFCQUk4SVBURmtReEVoUnpod3JONkQwNDk2RS9I?=
 =?utf-8?B?di9jZ2V4MTVReVNMUEhXWDBaVkZ0cVhKZUFzTDNDZnBmSWp2cVRZRllSVHFv?=
 =?utf-8?B?eGhtemVUWkQzaUh2VTdTT1BxT1FwbDVJK2pYekxqVlh2U2doT0JhbTRqVDcv?=
 =?utf-8?B?T0tDUWRYUExSOXliaWFtQ0VTcnZ4TUtqdE9WM1VFZ3d5ZHpGRlR4RVBFemlG?=
 =?utf-8?B?aXJlZXVPK3g1bjNOK0V1MEZtYUF3SThMNjU3K2tMNW9PZEJ0RzJYL21VWjBF?=
 =?utf-8?B?cmtIUUJJSFk1c0F1TVd5bkVjYWM0eGs4ODIwelRyV05sVjlsZnQybnUvbWFk?=
 =?utf-8?B?Ymlma3A2N1dXdlFxa1FiOHNPak9GbmxLdmIzNldoVll2MDVlMWdmWFc3SXp6?=
 =?utf-8?B?K2JxZUhXb3Rha2pKLzJvVE1nZEFqaUZ6RVBWaFM0dU9JK0FuN1p5TkUxMk8y?=
 =?utf-8?B?M29zWnJSejRvdktQNVdVZ0JtOHk0b29nSDhteTN6dUNuL0dZRHBJakRnYkJL?=
 =?utf-8?B?WThITDNKQkJ1MEJPZGlmVWwzK2JYbCszbXV6Smw0REQxN0V5RGUxL2UvajVS?=
 =?utf-8?B?S28rMGc2Q0ZwNjFpbjhwQXlvQ09YL0pGK1Q0aWNmSndCS09rM3ZNM0xDcVhM?=
 =?utf-8?B?d21rWDhhMHNNbWpUVzVxMm9xS29rN1FhL0hzNDFXZURaa3V0Z2xyV09hRktT?=
 =?utf-8?B?NkRWMEJWNUVkbUZwM1hMK3ZHNW1RS3lIUkMySUR2MmZETGcranh2MTdwc1Ny?=
 =?utf-8?B?b1E9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25983d2c-ee5d-409a-d8d7-08ddd8779bb5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7312.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 01:37:38.4249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n7n5B1ldn1tbNZo7dEbMSvyYdBHwBachUij4AiIhjZganTQySTvMKAhoyObJiHXUWNbrLwevaFxTUAJHnXDJVRxqEYU5v5xzY0PSLbHIjwk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8602
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDAwOSBTYWx0ZWRfX1hQfVjDcJff6
 o3Lejrk+mkjxS9eGG/dff/guN3WqmaRm70c1/F1IfGXc1/jhAmAi2VKVPx/cfDHe+faETy9Re4G
 qI6HmGd2Z039/21jc+Kjjaux8aVaAA0xnkwr46hVjayQK2MkYcu0Oysez31n1C+jMVHMDXQ/82y
 3udcK92CIzQNp4YzSSwcNdpiouiMaH9JiHWcrV4S9QQUGCqxY+xToEXBDcU0VOy5QyT6jGM2Z8X
 3wssCzjul3scPeY37BGnuGT7MxVN4yKDqnfu7pooSBD1dyN2cagL5qFzaD+b+Nh2gEwulI0/4c9
 RFZ3jzySMMirKuhdwdXj70XE8rNzHkWn90dlzSuOhc2ElH3qrEjUyTa5Kr+fU8=
X-Proofpoint-GUID: sHEJvUOG_Gt7SV6BrZqSvD1uouEGmEhk
X-Proofpoint-ORIG-GUID: sHEJvUOG_Gt7SV6BrZqSvD1uouEGmEhk
X-Authority-Analysis: v=2.4 cv=cZzSrmDM c=1 sm=1 tr=0 ts=68994966 cx=c_pps
 a=XXikXukjthQYDL6FPtOYxQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8
 a=t7CeM3EgAAAA:8 a=2Oz5GyJsTUbV16BMiZYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-10_06,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2507300000 definitions=firstrun


On 7/22/25 23:43, Ian Rogers wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> On Mon, Jul 21, 2025 at 11:13 PM <changqing.li@windriver.com> wrote:
>> From: Changqing Li <changqing.li@windriver.com>
>>
>> ld_multi will link multiple objects, when there are many objects, and
>> O=[absolute_path] is set, and the absolute_path is relatively long. It
>> is possile that this line "$(call if_changed,$(host)ld_multi)" will
>> report error:
>> "make[4]: /bin/sh: Argument list too long"
>>
>> So make the ld command read option from file to fix above error. In
>> order to convenient debug, write the file content in dot-target.cmd
>> as comments.
>>
>> Signed-off-by: Changqing Li <changqing.li@windriver.com>
> Hi Changqing,
>
> I believe your change makes sense. I notice that the regular kernel
> build has had to work around this problem too:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/Makefile.build#n290
> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/Makefile.build#n463
> but in those workarounds the need for an extra .in file isn't
> necessary. Would such a change be possible here and avoid the need for
> cleaning up an extra file?
>
> Thanks,
> Ian

Hi, Ian

Thanks for your help. I have resend a patch as what you suggested, could 
you help to review it?

subject:  "tools/build: make in-target rule robust against too long 
argument error"


Regards

changqing
>> ---
>>   tools/build/Makefile.build | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/build/Makefile.build b/tools/build/Makefile.build
>> index 3584ff308607..e57ce8c34685 100644
>> --- a/tools/build/Makefile.build
>> +++ b/tools/build/Makefile.build
>> @@ -70,11 +70,13 @@ quiet_cmd_gen = GEN     $@
>>   # If there's nothing to link, create empty $@ object.
>>   quiet_cmd_ld_multi = LD      $@
>>         cmd_ld_multi = $(if $(strip $(obj-y)),\
>> -                     $(LD) -r -o $@  $(filter $(obj-y),$^),rm -f $@; $(AR) rcs $@)
>> +                     $(LD) -r -o $@ @$@.in,rm -f $@; $(AR) rcs $@)
>>
>>   quiet_cmd_host_ld_multi = HOSTLD  $@
>>         cmd_host_ld_multi = $(if $(strip $(obj-y)),\
>> -                          $(HOSTLD) -r -o $@  $(filter $(obj-y),$^),rm -f $@; $(HOSTAR) rcs $@)
>> +                          $(HOSTLD) -r -o $@ @$@.in,rm -f $@; $(HOSTAR) rcs $@)
>> +
>> +output_ld_multi_dotin = $(if $(quiet),,@printf "# %s:\n# " $@.in >> $(dot-target).cmd;cat $@.in >> $(dot-target).cmd)
>>
>>   ifneq ($(filter $(obj),$(hostprogs)),)
>>     host = host_
>> @@ -145,7 +147,10 @@ $(sort $(subdir-obj-y)): $(subdir-y) ;
>>
>>   $(in-target): $(obj-y) $(test-y) FORCE
>>          $(call rule_mkdir)
>> +       $(file >$@.in,$(filter $(obj-y),$^))
>>          $(call if_changed,$(host)ld_multi)
>> +       $(if $(strip $(any-prereq) $(arg-check)), $(output_ld_multi_dotin))
>> +       @rm $@.in
>>
>>   __build: $(in-target)
>>          @:
>> --
>> 2.34.1
>>

