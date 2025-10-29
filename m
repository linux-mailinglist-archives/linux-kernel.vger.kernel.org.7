Return-Path: <linux-kernel+bounces-876527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBF2C1BD2A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D06766E14F9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4897C330D51;
	Wed, 29 Oct 2025 15:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="H092L/Bh"
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020123.outbound.protection.outlook.com [52.101.191.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF9B33F6
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 15:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761751916; cv=fail; b=BjqHSlI8+nYChvogxx/qNSJfpVdVqJ4AV0qdx8C1xpmZWvbgxvhQ8FP+xxVLdM6Sh+0wjwqDfiK8fpc2SGhXWtXkV/Jkm+fwUurglkUVB8IKJcAt7P1JXGOLGYzqqel2kOdy0QLLyKwIIZCAFA0Zv1J+9ChMFlJ4ReWvcsn/E0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761751916; c=relaxed/simple;
	bh=ikQgZxewM42sPkNBSHevH9E1JM9Tm0LrHKSbRRPJx20=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bRLGZqYrX5lajbtT+W24+Kwkn3o1FTqxr+FUMnOf7U4CvHFoprC+u3ONXb7k53VXkt0JSzMeNPul4OpSE2qkSZjG/bA9gmWyYmUSO48w8IyW/tTZlNvgrIGYyO+XPyoFP0v1M2jE3ZvyMx37UXZEwgOtEymGoeEtqKl3W5nvEGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=H092L/Bh; arc=fail smtp.client-ip=52.101.191.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NxP/0YV7M9bBF8e+rs3qTwu7ITRMWfl/uh9QQxcQw4KgJO0fsKZLkpgfwxiLf9fl4O+E1burUTfLZ3fFPvY/Y1DUVn4Q+8LTBxcj4HZYK1vt4Gse/0vbEWDFzgHXFdr+BtUS+eyENmbBOXXntPv4SS1aMmhDxzs/h1FkHdZzm8KasbNPXP7Zp2/AI2vAqZp38NtTbP3iiHWdgw3udi17409/dstxeiB8A8mTE0fNOR4xUVXj86uj/Uuce/NQfAtHxOOfapeQ3SfHyKsYjs99Zbn22O3Q2Ixqw4X4sU5Gcfx56fQ6Jt2KhhVhapk1OzlRboOKI+y2yQn04ACF60baPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oqpW4KY49tfzK40ktN04dmwcjkBoRY3fptUaTnbEqV4=;
 b=GBYoPUCJviexFI4/yeJ/x9NC3kSIIl3X3EUPHkx8opacpf4xtvOyal9BZKK1GqxanASYgqjbbOCdZUGB9OsDQOMVvY89FEAvawXOGUbFbFFzRRJkxygH1klW+AJwqcltxjHBH8x+a2AfSnumq8S14Ui6XqY4iTu0ucrEe8agoiVRYvqCTi2UuzZNyydxG7k7OEX+E+IG5kCYJ9f2kEx+BDT3mVaxILIkS09TOIaX6iLnIFIh9sDz54LDVe0ZDIZY+8ftY0Tq4+O+sa7Z0PllhU1375i2MzdntQ7VFOzBqSBHq1tXWQ+Kb5acMWvm3hhq8ghjvwsAGiMS3bvZeuKeBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oqpW4KY49tfzK40ktN04dmwcjkBoRY3fptUaTnbEqV4=;
 b=H092L/BhEZbGgZegCP4AcqHCGVFDYXt7bFf2rzz7bgaXe/b4rxmHpT0i3hcyW0/u6OzuE/1pK5UjV+hwiQlCSIh+OlgJDNaSfi9oJLjjnsiXH2zf/yRhhzpl/Yc5pHSTnZ0IsW2jH2IE1HQw1Q9Nrew1Fue/jy9BrCT/IYA1B/fiyzEzmk+I/UzzpCjUb693M0T7pL4yjw8KmVLviE/IRvaNaXzi5WrkTjoByHg/06r6wqsxXB3QxkneyXKToH3D9u/V8P6YWUncKsajjwiMOBreDz2AS0oByKYJNihNsl6lYHR085FUjoWXg3fwLaWIwzl8qfOhd+6AWCfGtnt4ew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQXPR01MB5498.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:2c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 15:31:46 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%2]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 15:31:46 +0000
Message-ID: <1fc220af-3f9d-416f-b2f4-a50281cd5f4a@efficios.com>
Date: Wed, 29 Oct 2025 11:31:44 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V3 02/20] sched/mmcid: Use proper data structures
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Gabriele Monaco <gmonaco@redhat.com>, Michael Jeanson
 <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Florian Weimer <fweimer@redhat.com>, Tim Chen <tim.c.chen@intel.com>,
 Yury Norov <yury.norov@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>
References: <20251029123717.886619142@linutronix.de>
 <20251029124515.403226292@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20251029124515.403226292@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0116.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::6) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQXPR01MB5498:EE_
X-MS-Office365-Filtering-Correlation-Id: a05b2ffb-0c4f-44c2-77d0-08de170044b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZDg5Wmp2OGF0M0hjTGhuZHhTZFIxVkQxcllmT29zakwrSXBZbzF3WDkyYzND?=
 =?utf-8?B?TVBIckZxdGVMc1QyMk1CeUVuYXVMVjJOaXdZZmZlNEd1ODBjaDBPbE1oR1d1?=
 =?utf-8?B?UEVzelhCbXdFdlZSUTZ0aXNueEdkcFF3UXNFMHdFcWdtZEZaTGgyMDlvR05j?=
 =?utf-8?B?S05XdzFIdHZEcE1razBwdUdxNnIyZFVOY0lrelJzTENQVzRzY0RjM0VOV2g0?=
 =?utf-8?B?ejB1clRBR3JNeXlJb01LWHZSUmxPNkZBeVlSWDdFR2FJUHFwaTlKSHV3RG5U?=
 =?utf-8?B?V3E0enpCbmNtVGRTczZIczlSMzZndDN0My9PYkVienRFYlY2UEdGbytZdDFW?=
 =?utf-8?B?Sys5S0lyWHQ3MUVFcW43KzkvdWsrbHdHTUxrK1pnTXBrRXRtOXB2K2hVN3ow?=
 =?utf-8?B?OU9zcEk2dTF1TnRlRlc4eWZLeWZPWXhuSkJCUHFMVWxiSXY2SWwrU0xYcVZo?=
 =?utf-8?B?M1RTY01QUmFWandjM3FUL3ludXZqMzgwY0VDZ3ZsUkFXWnlUVWZHZVFLck1I?=
 =?utf-8?B?Z0hPSWVLTDB4TEdBbXF6NzQ2NEl3cFR0NnVPcHU2UW5WVjV5ei9NbnhER2dO?=
 =?utf-8?B?UElKMGNJTEc5TUJLUGErc1VDbE11b090SzBJOXRIQjc0bzJ3dkJBOGs1OEsz?=
 =?utf-8?B?SlFmTmZaODlMa3IzanEzeWdqN3RWWW1QSTdSMDRwbFFTdXAxbTZaak01UzVn?=
 =?utf-8?B?Y3NkN1ZzVFJFTmVyYmc2QXljTUZodU9LM1lqL094dmZOeU42QUxBNWk3Wk84?=
 =?utf-8?B?WkJSK1NoNGpuUytCQkhTVDc3L2NaVWYwODVUNXNDa1ZhNHZuTXdqY1pYSWdW?=
 =?utf-8?B?RktnT3ZqcjBUR0tZOWgxdWF2a2U3ME9SYm5LelRaWk5Lb2NqRnNWbEg4cFJo?=
 =?utf-8?B?SEwzZlNsZlZjNWhQOGFXRW1oQnBMZElBNnlzeUtUU3l1K1g4MGppODlubi8r?=
 =?utf-8?B?SG9QdUJaYkpkOWZhM3lSRU40ZlhrOVpZViszcnVMMUVuSFBNTU5NWk5iVk5a?=
 =?utf-8?B?bmxwSGpEeVhIbWVVVFA1ZzJvV1pyWFczeGo1MFM5cGgvSzdsUHlrckxhcWo2?=
 =?utf-8?B?cnFCblZSQ01zZXRNOW93RlU0REZSa1J1ZkpOS1U3VkNrRmo2bVk4cW5MZSs2?=
 =?utf-8?B?UVhLZW9IakFYaitjSENyTGUzK3hxd0R1MDY1UTFPM25lcVZrRVdnTXI2RHNX?=
 =?utf-8?B?YWRMQUdwTjBrZWRVS3BncThjVjRhRithU2J2UzBQUjA0NVBXMzBtaDgwMXU2?=
 =?utf-8?B?Z1M1L0ttZ1psWVU3ckhycHZRUjNEZDhLQ2tsTksyUURSZHJadWVFTjZFM1U0?=
 =?utf-8?B?bHk5SHFTdmx0cUF4OUZHVzN2d2ZLSktib0lxUytGVm5scXRjcStHUVpYdWNR?=
 =?utf-8?B?NDFrR1Vqd1E3U2ZsUW91Sk0wRU5PYzRqZWRQRVlBME9GZjNETStyMDdnQU4z?=
 =?utf-8?B?NmV6MjdsMDh4R2dnV1NqOXpOYXRFNGtuVU1Ldmk0NnJtckVFRzFqWCtYT0to?=
 =?utf-8?B?dDBOVmV1dGJuZENlR1RIY2w2NDB4cmRtZ1hYMFpWdXVzUWd5aU1TamU3aUxq?=
 =?utf-8?B?Y3dKc2h2Z2hlK3NCQkFRdnBlUzVXSEVrRDhsRml6Nmgwck9scFVnMHltdzFv?=
 =?utf-8?B?RHViTzVvVkQ1azI5dWJUVFZEZDdKKzN5d2puaE9ZVU0wNWtScnRTcnZNVlBh?=
 =?utf-8?B?TDYxN01FNUJBbzdaWWpRamxncWJPZTJOL21kZldLeUxhOUQ4dEZHcnFDOUNG?=
 =?utf-8?B?TEoyQkJ6bUxRK1NvV0dCdDFZWCtBa1g2SkJYSG55Ri9DMXJGOHhEZ2FrR2Vk?=
 =?utf-8?B?QzllcTQyN0JjLzIrUFR2dHBBOGRVZ2ZFUWY5ZHJzQnlXT05vczM0Sld4QmQ2?=
 =?utf-8?B?VnZNbTI4L1VqdTV1bTdrdVkwUHNIL1FPN3NMVCtSZndzeEE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MGE1Q2UySUpMcXZCRld4M2FSYlIyd29wc21UODhrWElDc2dJZFJ4MG9pelJ6?=
 =?utf-8?B?S00vZkNVWFpJM1RtNndTQXB2WmtZcTlRVE9wOWpOcU9aTjlYRGo1SFNLMVZ4?=
 =?utf-8?B?VXJEYmJqdlg0ZHMvWVdzNlpFOVpoMGZlUG5LYXVvRVc3YU55NFlxOXZHc1Y1?=
 =?utf-8?B?SWU0WGoxb3AwRkVUZmdpaFZPTndQdE9OSzNjejdsazhMV2Z6RmhFUmJSTzNl?=
 =?utf-8?B?R00xeHBabHB4R2grK1FHNVltTEZJWjFtZWlvcExKUGJFK20zOTlCSHNybHhq?=
 =?utf-8?B?UFlJOEdrQkJpOWd2MTE1MnRGa0tucmptNzRUMzA1bkQ3bHJlY2d1cGFwRFdq?=
 =?utf-8?B?Q3pSejJnbWFsZDFUNkhsRnZ5Y21WQU1DNjV4alhiWG1FdlVCVW9ES0p5d29y?=
 =?utf-8?B?MzlqcjNhYmU0MFAySnIraTUxR0g3RENWeGpxK3hLVzRNanEvYnBoK0RVOHBI?=
 =?utf-8?B?Y3NFaXVLdmFqeUdmeWt2eFhTWWhiOXBVc2FjQ3Z4VzE5VjR0c2xnbUZQSkgy?=
 =?utf-8?B?VFR4S1ZTRFFhRmZTdko2SGFDbnhpcmw2bzk5a21icndLRVhpTmphV1NNTGJ6?=
 =?utf-8?B?OGxVdGpNMXdJMllkMGppaWFhZEkvUDBsZUtMTzlXMUhvTzNvYlp3aVUrMHow?=
 =?utf-8?B?Q3dnK0hEa0MxMU5DY1llaEgrbmlxMDBaeFhsTU03V2FpQjdTNDd6SGt2cUgv?=
 =?utf-8?B?VHVabDZFRWNuM1U0MnZycStERlNpcGtCVHRjWGtsRzI5aFQ1YWhWSTBLWVBT?=
 =?utf-8?B?V3o5YnZ6aU1WNE1PZ3Ivc3BXY2FGYU02bE9sN09JeW1KNTY2WHVEb3NOUmJE?=
 =?utf-8?B?eGZyNnpNZzVyNVRRZ2VUM1dTeUs5MGJGQVVqejNORVlEamIydHJwZnpUUk5W?=
 =?utf-8?B?Zk1TREhGT0ovSnB5MWxDd3NMdVArcjZMc0hhdXQvQ0RXZjRtZ1lNK0IxYlM4?=
 =?utf-8?B?OGg4M04yTk9zYUN6bi9RK1BvOUJVN0dycVloN3NuMlB3OUpzMUZnNHpXbjNS?=
 =?utf-8?B?SjJ2cE4yVUhKamxraDFLdkpkeC84alZXK2dYK1VLbVA2SHFZQUd0NGk0bEdG?=
 =?utf-8?B?Y2NRdmZSanA3R3JFZlpqZFAyMXFLdFcyY0tML2RKYmNxSXFPR24rdTBXaVRF?=
 =?utf-8?B?aFJVQmxXL1RwSVRXOGZpdjMvRjBOOEdXMVB3SzZaVDlGcGJ6aUdTaVdNdElL?=
 =?utf-8?B?a1lnYi91TFVsM05qRzFTSENXL1BMZXdHTG1iQ0dHaWdJdlJZMmVxaFE4UUNP?=
 =?utf-8?B?VXdIVHRPQ21oWmRNQng0WEREVmJOOTRYUHVTUUszNDlXeWhjS2hDSGwwVTZn?=
 =?utf-8?B?MzVhR3psYXA4cGJPOWJpbk84U2VJaE9FRnhBbE5LZGJFNHNlaVhQZ0UrOVZR?=
 =?utf-8?B?U1BrVWM2T080eGZYaGNDaU54ejVaNERocnVsZStDNzBVSmQxeGIzdXR0Rkdx?=
 =?utf-8?B?UmlwSklTem1kZjZjWUZKclNUdTFPY1ZSWXJJNGpUVDh6SDBpSTBPbThIYlJq?=
 =?utf-8?B?VG51RjJhamRxZ3VRRUZBdkt0Zmd0SUR5NTE2cDFzb1ZHNmN0TFBDQndxS3hE?=
 =?utf-8?B?bGxGUzNrRUhtMzB5eDRVT2NvTS9mUFpkN0NqQUt3T2w5a1JvTnNuMWN4dU9s?=
 =?utf-8?B?TndvaTVzNzJIMFVoeThRUnQxWmwyRDdESXFQOTNnaW1CeTVxamRic2doazdz?=
 =?utf-8?B?cnFYdEVpWUlOdlE4TXREMjBGdjk1cXZ6Wmg2SEJWQXhWd1RDMk82SjhNMjhE?=
 =?utf-8?B?a2dSYytWSzlEVGdiU2tjeGZRSWFDOUMyZmFGMTNyZ2Nyb0VxOHBSN1VMWjhq?=
 =?utf-8?B?ck1xMnJ0aEhoanpVaXI4UjMvQUFCZ05BNFFZUVZsN0xwb2Y3UWo1aHRyejJD?=
 =?utf-8?B?L0xzbWZBRkRoeWpMVXVGRHdlWEJaNnlPSGdBOG5OS0l1R0N0WFlUb2dXYW9O?=
 =?utf-8?B?OSt4cjQybVluQ3JCOG8rTm12cWlPT3Zqa3ZNK2dNdVVINENSWStxd0l4LzFa?=
 =?utf-8?B?TStSSDZXUXk3Y2FXN3MvR2dSaER4NFVzc1Fud0RscDB3a3pnTEhjYldhbnFm?=
 =?utf-8?B?dkpQSCt6bkFIa2R0TlZ0QWdyYTNyZlZtT01pKzhWYXowTms5VjY4SVdkZGxK?=
 =?utf-8?B?amdZUGkrcjdPSEFTVEROMFlBR1BkYmNrMzlZaTNQZ200ZDREbzQwMGp3M0kv?=
 =?utf-8?Q?op6GYYb0H87KiFSS9qAikMQ=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a05b2ffb-0c4f-44c2-77d0-08de170044b4
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 15:31:45.8299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5CggWyO4numJYr4EiyLp4KFqBoizGjpXVwgfUlWOwt2WbgtTka7FYpVXOIPYCrlBQz0Xb+t+gY5z0aoApKJE/ejaWtX4G87midm0kWzggVw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB5498

On 2025-10-29 09:08, Thomas Gleixner wrote:
> Having a lot of CID functionality specific members in struct task_struct
> and struct mm_struct is not really making the code easier to read.
> 
> Encapsulate the CID specific parts in data structures and keep them
> seperate from the stuff they are embedded in.

seperate -> separate

Other than this nit:

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

