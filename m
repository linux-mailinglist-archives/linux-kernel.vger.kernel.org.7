Return-Path: <linux-kernel+bounces-753519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCDBB18418
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 16:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DCC4586E53
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 14:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1390626A095;
	Fri,  1 Aug 2025 14:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="h/64m/fR"
Received: from SY2PR01CU004.outbound.protection.outlook.com (mail-australiaeastazolkn19011037.outbound.protection.outlook.com [52.103.72.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C5A1E50E
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 14:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754059336; cv=fail; b=YlqPMQc6P/Bp1QaXMs2x6LsJ3R3smu9kzb+4fFBhJC1isDocAc7nxIC02i/5Thx5LfKKIiVYJXN/xLWg+UsV3G2X32W6vA9fB5zYq3NXM1nl8tQyqpNyZjWWDQqlkqZrywsrom+ldiY6ayNZks3W40byFkZi0V3Qmo2QULfdBOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754059336; c=relaxed/simple;
	bh=DbrJmQjSfZlhNvKXrQzPLMBcZhobbeuhcLg640xUlzk=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LUcNS8sI4F/ss5uIcmd10Z83eU+vJtQpgo0iLhbKcxmEZxHwvkw168xRDijh0YfTDjGcQu5LRjCukJ7RtRn81xvynD3sV8B+usjozDCikRwgbaicMITAZ/KpGorJ0DBaVqudVa2ddS25KD6hQ4bo3qIHpFGSlZIeFTS9jynTQgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=h/64m/fR; arc=fail smtp.client-ip=52.103.72.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ETKN2hGLGLkk6C2/nJIYSV+OK7IOj28U0ZMix1TIvEn+vLR4qQBZBxwgcO+D1wZth9epl/r6AxCKaLct27hrGYWin1dih0qQFP7Dznby9WmgQFowv0YxVTZ1+4FpsPiTvHE83oLJaR79ThLoBWjlpFIcTgWm3GSkxs37k1OXq1c3A8eMBzqzife3eAtWim9oAXRIEm/cuVnej9WYqXd+XLXRV6JT6MeDs24is1TNpusSRUsixiGLWwXwyvsooOFmNMIwuQIz2sMYsv5ZkbGDeyIJ21bpoA7DrifwRLWU0G+N7aaYOSrf8339z60qYcS768kdYc7HCqWZZweA28oI9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JdOrYhqv9upeqLc8m4Cd9DwmbTECwPXwki0FV/fYjOk=;
 b=uWe69QiDJefE4KOo6oPchmiq39XAJV57fBkwrFcn9cXcrFB6wksXh04myuTOJaCBopPTMSgdPta+13mAEz3vW71KQU+c34uZd5iF1KMHkNX998jvnYhpu0mQE3CTLLI81zenhZ5339C9S+eiS5gxjVVCDtXDZRF8wtYama5EdpF7ljgRGdARUcPSvdGGJrsCe8/628JXd+uKAOuaz0cCcMszKGVwLIN8VUFeHeJTrNkdXeALA8PNFPTNkgrQl0j0+RR8Iu+RjJ5hstJa3aJiWFAxv0toh1y0MYQc7R6FL2im677dV/py587ZmMAzWpWW2jIHKS1MTM7YwqSQw4GghQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JdOrYhqv9upeqLc8m4Cd9DwmbTECwPXwki0FV/fYjOk=;
 b=h/64m/fRA/7kqVJw7H9NHgtrzhEB5bZPlGAICeSswhO/WJ1zuWr/h8ClkNw9hIqp94X9AD3fN9qJ6yO0iyHyLDlftVpHHHb4FCqzwwwvh07aYmiZ/fIX3wQf89rSUFKvyZHVZJIlQm6c4aFKriD/tYQxGoaJW3NSKAykFIseId0Y+UiBJW5S19BMeDwzVoS6Ag05dPggzaxdWdJz49caV4BCZ1Q+4BvgN7G77UT6+sc+FjY+cmNZ7xw2y+VOSDuK3x2jmF4v/LVNaFdf7sieOyOwGbyqA0tpP8ayNBBQS5DbhTRhpb/LDvRe/kOc1L6cNYpy+ah2A0M1siRHq1HoBg==
Received: from MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:ff::9) by
 SY4P282MB1724.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:c9::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.17; Fri, 1 Aug 2025 14:42:11 +0000
Received: from MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM
 ([fe80::6174:52de:9210:9165]) by MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM
 ([fe80::6174:52de:9210:9165%4]) with mapi id 15.20.8989.017; Fri, 1 Aug 2025
 14:42:10 +0000
Message-ID:
 <MEYP282MB231286A088AE3BB50B468713C626A@MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM>
Date: Fri, 1 Aug 2025 22:42:03 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: Linux Device Performance Analyses - Where are my cylces?
To: Lucas Tanure <tanure@linux.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 kernelnewbies@kernelnewbies.org
References: <6dec5463-3ef5-4085-ad4f-6c2792f85ace@linux.com>
Content-Language: en-US
From: Levi Zim <rsworktech@outlook.com>
In-Reply-To: <6dec5463-3ef5-4085-ad4f-6c2792f85ace@linux.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0123.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::11) To MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:ff::9)
X-Microsoft-Original-Message-ID:
 <4bf111e0-12c0-4606-a4a5-0fef6ee03f84@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2312:EE_|SY4P282MB1724:EE_
X-MS-Office365-Filtering-Correlation-Id: a7583e5e-ec02-4d71-f259-08ddd10997b2
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|5072599009|8060799015|19110799012|6090799003|8022599003|15080799012|4302099013|3412199025|440099028|10035399007|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YnpKRnV2dGV6VFNXR1JMR3ZVRVBWNmJmOGJSOGZDL0h2c3R0QlRkdmFYWk0r?=
 =?utf-8?B?UkZsc0V0VU5rd05ycnFOekdKNXNFNkI3RVR2VXJjbEdRdWlpc2kxV2htVFhi?=
 =?utf-8?B?RitjNmhxRVIvWDZkUG4yblJFWS9Ic1lzUDArZDVDc0pmR2Evcm5XNkhRQVVV?=
 =?utf-8?B?L0RxbE4wV3RMZzVNcDhSYnBQbkc0YXpGc2pUNG93L05oNTRqVlRtaXhycFgv?=
 =?utf-8?B?QUErQk5RVE4yOWxXazVFSUZ4b05ZcWRVcXBZMzd3VGRVVXptMjR1UXVRYVg2?=
 =?utf-8?B?c3BCa240NG12NFdCUnQ5S1JqQTY5U1VRQ1JtMG1UVXBpeWc5ZVdqZllhYkJW?=
 =?utf-8?B?VldsUHdWbDBGVVY1dFg5UHVtRFBLL0FxT0l6Nk1nY2VkN3FPZVpIRk9LM3lI?=
 =?utf-8?B?cTZCNWFaWXNLV3RCTlVwSXUxNndFYW52RWlXd0p6My9DM3BZb0lwUk9FbGRo?=
 =?utf-8?B?UlRvK1dMaUVmcGN3dDBRdHZVajNsdVI3TzRIcy9qa2lsS2lUUEQ3MFQ5dUk1?=
 =?utf-8?B?eTdUdmdSN1VjbHoxVndvbUlGREQ5SHB4SzlMSmV6Lzk3SFcrWWVtc2pGNDZD?=
 =?utf-8?B?MXpqalNtZFlwdFB1SW40S0VzNFdYU0p6ZlpVSi82MkYwcHNlS0FmdXZXUHJ0?=
 =?utf-8?B?YWdYN1pmOXVucXFLTzJMTHY0STZ6NWV6Kzh6RUtsUDVEMmFKTmNDdjJxa0VQ?=
 =?utf-8?B?VW0wOHJlbjIwMWtPTm9DVDVBYjdZQ2lPZ0J5di9rS21ZaTlENXZNUWhuMHpy?=
 =?utf-8?B?aEEyQk1iSENQY3FyY0pqYUZhaFpUKzRjaFljWFZhZUFMdGtUTE9SN2N5bXh4?=
 =?utf-8?B?OWRjZGR6RWgxWnJIdTNsNnJ4QWdnMCtpc09wYUZvUXF3YncrbnVCWFBDSU5j?=
 =?utf-8?B?S2lrTFcxWGg2SWdJaVllelYzZStRSmJtZGVULzhsUGVzVm00NmVVbHBPazBn?=
 =?utf-8?B?Mk5HV0ZuMDlUTW1SdlBmYjlwcFkvTW5mS0xremJZcTc1MUJvekNwTm1LZG9x?=
 =?utf-8?B?R2xJSWF0d1lqTXhxc2lzMnVJMEpjM242ei9zRHhsMWJFZmkwenRVc3dRbk44?=
 =?utf-8?B?QURFUTR0NUg0R2QyQnVwS2hRYUpiRUtHQ2R0MC8yWitiSVczUlAwZFVoSVR4?=
 =?utf-8?B?OW1yZytRYjE2ZU0vQnhPUWRTRWlzbFVBZlN0NHZxamVYekxlNW9XZFRWaDQ2?=
 =?utf-8?B?Qk5DeGNWM0s1T01zZmJQNUxLY0ZwR0RzL2xGOUxzSEExTk9pTFB5aUxPU2k5?=
 =?utf-8?B?R0lOV1l2L1N5R2dWYmxtcmJFTTJ3TmlMUVB4emxxdnlQSVplZkJCczNsQTlF?=
 =?utf-8?B?cGtCeWV6ckxBbWdWQS9wRkdQNCtYN2VZWmRReGJxeVlPTzlXaDg0NnRJNFNj?=
 =?utf-8?B?SHdNWERqU1RIY3ZPbmdrdExnRDAxemdJbjhXQlZrTm9HYU5qeTQ1dDdBZ2k3?=
 =?utf-8?B?ZGlySU1CVXQyR1o1R1NQdEZIaCs4ekFOZGVzMlgzS3RoenBOUFhwRDlwZnph?=
 =?utf-8?B?c3ZkVnQ4Wnp1ZlpPQXorZVF1NnZMbk9tTy9OWDJZVS9aZ0YycVZZMlpzbTZs?=
 =?utf-8?B?YWxYck4xM29JSVo2M0VIbGM5WnVNbnRIeXFLSy9uTE5zcHpKcXhjbDRMV1NB?=
 =?utf-8?B?S3duTHNDaUpGdXByVXBlVXN2ZEhLUkE9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QkVob1Y2SUFPdEMwYWl6RXlJc2VmczdNT0dWdE5pVWhXekY5Nm9VWG1tRSta?=
 =?utf-8?B?Y3VGMDJSMHNpcEgrZ2ducEVGaHZreEZ2cmlPZHdFUjduMkJES3BpZ09lbUhS?=
 =?utf-8?B?MnVCZGE1dU9JaUdqL2gzSU12SGRVQ1J2U0JOVDQ1MkNEc25KYkZsemFRenF1?=
 =?utf-8?B?ZmpJNUJpUFZ2TmY0aXp1WXZzOGdCMkVMbUUyc2xXZzQxYmVFc20xMFN0V3BV?=
 =?utf-8?B?RjFpa1ZjbG1xY1p5K282Ujh2SXAvUjg3N3ZBeXVLYTdFUTdmeWxxdHMwbDZD?=
 =?utf-8?B?bEY2MUt0ZE9Nc3FyKzZYcmdkQ3BZbW9qemVLb1V3a0VraktaYlltSkN1TEtq?=
 =?utf-8?B?QVJoenhxU09CTmdaQVZzYnF4WlRucjJXTTZ4VjhCamJvcHh0TmlhRlVQMnlG?=
 =?utf-8?B?aVJVUFBDejRVaVBTS2ZzSkU2QmxSNkhxZlI2L3JBeGNhcHk2a1ZIVHhzeDY4?=
 =?utf-8?B?d0sxRjRmd3JsT2lucGhNVzlRb1VTWDZaVDEyWEpUWDU2L1MyTnRYWDFBVmVB?=
 =?utf-8?B?akVZQTh6Qzc4K0xHUEthNkppa24xdEUxUVJRakdlRXhCa29YRVV0dW8xeGsr?=
 =?utf-8?B?dHpPN0txNDRWWTF0ZkVTYVZNYTR5Qmtkcnp6eXhCRU9pc0g4MDg5NE1PVXM1?=
 =?utf-8?B?dWtYd0QyMzFNVjhLNFZNTkdna0o5cSthVEJiTjZKU3A0Nm1Bb2Y3ZHZqeE03?=
 =?utf-8?B?RzMvaEZvczkzaHE1KysyV1RPWDdMRTBlM1FOeElwTjZIaU1PSVNBTjV1YXhV?=
 =?utf-8?B?VW9kaWJvRFNqV1liMTdwb3prRXJ6OVM3QnB0WFpMUVBJQzhodzFtajVWZURr?=
 =?utf-8?B?U0J3ejluZk5WV1V0bXdvc21BekJ0TzlyRkNGRjd6T2F1eWRVVENLRmgwZnEx?=
 =?utf-8?B?RkFaNUd4ejBrb0dJSjAzaXN5N21wWVk4azRFbmhSaytBV09kR0RJZ2YrZHg5?=
 =?utf-8?B?aTIvTlJDUnJXdlI3dE43Zlgwb0JhOE1HNzFrVEl0cWJzRUxkRVMxRjFvWEEw?=
 =?utf-8?B?RW9WM3lSUHRYUG9mRTE4a1k4TGtiMTh0d1JwOVl3N2ZiNFBmNVpMYjBJTG04?=
 =?utf-8?B?aGF6L09saEdDR0hmNXZrMHI1SE1ic3VQTVFxd0VPQmxuOEdQelUwc3FIV2JU?=
 =?utf-8?B?cm0vTmVUbTUwck9zeHF4SlV3Q2puaWlnVFhRaEM3MjhpK0VMUTBzRjZGWVU2?=
 =?utf-8?B?VmVBMEpTS2RFejJHWWVNTUtrSm90cW1QV1BaY1hHaXcwREI3L2hRRWo4SEE2?=
 =?utf-8?B?K244MVZSZzJlR0ZsQkZwN3VEM204N25WcTEvMXdQb09zZGpvK0xCQWxVYUpm?=
 =?utf-8?B?ZWtMdDZjK2RHT1pzbGlzbkVVU0RVWit1bnZaRjlpd2E4WWN5RzY2aTY2U3h1?=
 =?utf-8?B?WUdXeDY1cjArSkd2OVFxOXYvOHJsUHFueURkbWFDZVBCWnVDazBGNis4WjEv?=
 =?utf-8?B?VFNZRHpTeTRidFBrMlRtOVUwLzk4cDZSRlJEWUU1djVGSkFGaU9CdXBkRkZT?=
 =?utf-8?B?cm9TcHVxR2p0dXpScVI5MHlGQTZhSUw5VVZQWi9idExQYTVRNWxna1ZvRzZo?=
 =?utf-8?B?T0FPNTFsZ2x5bEE3SklyYm1PMm02ZzVqNm1qcTdrY0hna2hJY3BPSDM0cUhj?=
 =?utf-8?B?cmdDZnYzVUo2dFFmaGpxUElDVWJBN3dVa2w5SDhRRnVWQUp4SFRremYxSnht?=
 =?utf-8?Q?1R9z2wUHf218G0+nUKSk?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7583e5e-ec02-4d71-f259-08ddd10997b2
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 14:42:10.7878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY4P282MB1724

Hi Lucas,

On 8/1/25 5:34 PM, Lucas Tanure wrote:
> Hey there,
>
> I'm a kernel developer working on an Android device with a 5.10 
> kernel. I'm trying to improve performance, and to do that, I need to 
> figure out exactly where the CPU is spending its time.
>
> Our vendor provides a generic Android BSP, so the system is likely 
> running many unnecessary processes for things like GPS and phone calls 
> that my device doesn't even need. Since I don't have a good handle on 
> all these processes, I want to create a detailed breakdown of all the 
> tasks, workqueues, IRQs, kernel threads, softIRQs, and tasklets 
> running and measure the CPU time each one is using.
>
> To do this, I've been using kernel traces with the following events:
>
> task:task_newtask sched:sched_process_fork
> sched:sched_process_exec sched:sched_process_exit sched:sched_switch 
> irq:irq_handler_entry irq:irq_handler_exit irq:softirq_entry 
> irq:softirq_exit workqueue:workqueue_execute_start 
> workqueue:workqueue_execute_end syscalls:sys_enter_execve 
> syscalls:sys_exit_execve syscalls:sys_enter_execveat 
> syscalls:sys_exit_execveat
>
> However, the trace logs don't provide the full picture. For example, 
> when a new process is executed, the logs don't specify the script 
> being run. The sched_switch event tells me which PID is being 
> executed, but multiple processes can originate from the same binary, 
> so it's hard to distinguish them.
>
> To solve this, I've developed a patch for the do_execveat_common 
> function to log all new processes along with their full command lines. 
> I plan to use this patch with a Python script to parse the logs and 
> generate a report on CPU usage.
>
> My main questions are:
>
> - Is my patch correct? When I log the new process, do current->pid and 
> argv refer to the same new process?
Although I am not an experienced kernel developer, the patch LGTM, but 
it comes with a caveat that joining the args with whitespace makes it 
impossible to tell whether a whitespace comes from the arg itself or 
serves as a delimiter for the argument. It is fine for identifying the 
process but can cause problems for debugging.
> - It feels like logging new processes with their command lines is a 
> fundamental requirement for this kind of analysis. Am I missing a 
> better or more standard way of doing this?

I think the standard way to do this is using

- strace(strace -Y -f -qqq -s99999 -e trace=execve,execveat <CMD>), 
which is implemented via ptrace and might be hard to use if you want to 
trace all exec events as that would require you to strace all processes.
- execsnoop, which is implemented via eBPF and thus naturally traces all 
exec events. There are multiple implementations of execsnoop, from BCC 
and bpftrace. (And there are other implementations, one from 
brendangregg/perf-tools implemented via ftrace for example)
- tracexec [1] (disclaimer: I am the author),  which has both ptrace and 
eBPF backends united within three consistent user interface(log, TUI and 
JSON export). I think this is so far the most debugging friendly 
solution as it can also capture the (diff of) environment variables, 
inherited file descriptors and output the cmdline as copy'n'paste-able 
shell command. Most eBPF tracing solutions like execsnoop suffer from an 
issue that it silently ignores exec events happening in non-native 
syscall interface(like 32bit exec on x64 systems), which is addressed in 
tracexec. But as the eBPF backend of tracexec is still experimental and 
requires 6.x kernel, it might not suit your need well.

> - I don't want to reinvent the wheel, so if there's a better way to 
> analyze kernel performance on a device, I'd love to hear about it.
>
> After looking into other methods like eBPF and kprobes, I found that 
> this patch is the most straightforward way to get the information I need.
I think eBPF is the most convenient way to go and there are already a 
lot of tools available but as you are already a kernel developer you may 
find patching the kernel more convenient. Hope you find the solution 
that best suit you.

[1]: https://github.com/kxxt/tracexec

Best,
Levi

