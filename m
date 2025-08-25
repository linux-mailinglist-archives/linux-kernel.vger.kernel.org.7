Return-Path: <linux-kernel+bounces-785110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 339E2B34613
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 17:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C23B2A3631
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 15:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1528C2FF153;
	Mon, 25 Aug 2025 15:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="DyZAUsG0"
Received: from CAN01-YQB-obe.outbound.protection.outlook.com (mail-yqbcan01on2110.outbound.protection.outlook.com [40.107.116.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316CE2FE05B
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 15:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.116.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756136494; cv=fail; b=K8WiOTRagHTDCIAmUjzGrOdLi9nu1mBeiZBTudRvFHlKNb/tHX3hFKs5FCzbPWTz7d66tSlUSNs/Wf2DuQdKC3NpVwM9mWBvRuOCgRivOh5G9NxkXJ0OASXltbD+AS0vsg6rTrzcFp7aMLfQU+nckn6BXNqJi8sAGhAG+TENFVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756136494; c=relaxed/simple;
	bh=VRT++e8m4BGvPhnjDJys4D9iOng+hSUsIuo09PuYnD4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kEr5n7aA9P5+R+MxAwl2znuDq8tcTylNPGA3g8CgxLZnEUdTWFlBCveUk04VYhSDpxl2WzHEAb+EPWjR2W5s2bwMmzyolqCU9mUH3nmi18UeAeYhV2o2fB0dxu1oL+TJOWHd8ANRGF49jKkvBcnsvgLysM48E5hdAXKcbveiPaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=DyZAUsG0; arc=fail smtp.client-ip=40.107.116.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZcJ8TZiYiGlc8N2ljBihTHM9jyXidk732MMkTCB3keqhgSDcp8QfF6PMLEUSqDEUX6/NtwKEg4qom5NPBjHvMMrxzuenwMG64A06wIQh+iqc6UDQy/2Vzik5BDjjjbtuW0sZnM2CiN0lOkMJnrQDOHwdvqTcwedSWehoE8Qtqh0O3guYdDPTak9IzAYzM2T3YLNz3hiyfksSmPNTiGVW+U32t0W9iWQstEw66vY7f1mwbCQlVq4WNbTh7trYtS2P+KjvOv9aNtOem/1SYvg1xOh7eJSCQKOfFiRvY2e7mbLOHzrZLwUn7CKYbtW2SC7OOYPrljpal1/EnwbD23aRnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lAokbx7zljhKWl7TE+I2l3lV/9Iytomg5OzaNh1hHkg=;
 b=objhP2pgcDW0Ye6hOC1T4wm7jEj6+sfQgB6bIas7GUkumXzFM3DBffYRIw+xTM1PV1Izm3d/Fl9WXp+fpFEbQW2GxSFsS6S5SHlrPNB8rFWVDsfZp9M4TE1XMLIJYKI6KP+G+ZnLdn9+0rn4DTlG4QNhaSFetLK8AL3HObirUzrxSgTmGPeEnaspiczHSMYuAVEz69YDn2K0tQlsb4LRTVhXtLmYP5jnpm0RUbUuAzBazGjgI1aubqfxqcnsPKqbOcl5ru+0mhMtGAElbKx4K6+Thxikd7LpgLto5O+QLsJ44jyYbFS0yzjz0G5w6yjAedezrqzeQDZ+as6ofjY13Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lAokbx7zljhKWl7TE+I2l3lV/9Iytomg5OzaNh1hHkg=;
 b=DyZAUsG0DsBzZ/T2MtcOpf/ZphoFp+Z+EDAxqpQbGYzs59xW5n/rxrZYUugAmtC1troiR9DgivsFIGGt6IH0dN78my0uf3sGgNAqQnmusbi/m9u3t2Vc4RFvFHQfDSTfjA8bjH5osoH8XSpw1JmPd11C3e1L2IXBT6jIa2SmOA6RFiEMhcjLk9ozbmLKvOPIGRATLIMSfbss0XcKm0jfqrnkaD53k+ElT0C6srbeDJpvdLbYHpmZiIIs8JFHXn7chiam1IMawYQcx9TLdnW7tHO8jgM9kpAYueEoPdI0Bev2nIn9ABuEbN1fPsMSz5q84N2U/PVzRMZl2QEGHikd5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR0101MB5767.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:32::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 25 Aug
 2025 15:41:31 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9052.021; Mon, 25 Aug 2025
 15:41:30 +0000
Message-ID: <a700356f-9e51-4889-bc21-8fde13f5e1a2@efficios.com>
Date: Mon, 25 Aug 2025 11:41:28 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V2 03/37] resq: Move algorithm comment to top
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
 <seanjc@google.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, x86@kernel.org,
 Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>
References: <20250823161326.635281786@linutronix.de>
 <20250823161653.452303254@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250823161653.452303254@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0111.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::14) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR0101MB5767:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b7e059a-dff7-465a-099d-08dde3eddc55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aERaTUNISGJUeS9WcG95SzJHVW9sUStmWGdhOEYzUHRpZ1JBaXdobG5BQ2No?=
 =?utf-8?B?SDdmOUkwWjYxTDBLMWhQUk5iME9SRWgxalhtend5NTdwNWxnWCtjc3p5SFNl?=
 =?utf-8?B?MHZacXRKaTBuZFk4a2JGT2t3amxrQWVWQ1Awc3hjUjhsTGlTaE1jK1pqZm5P?=
 =?utf-8?B?TUhtbUV5aG5sWmdnRTArcEpxd05HWVdON2JvYWlBL3diVTB3TjMxRVFpWnly?=
 =?utf-8?B?Ums3YVcwS2dXWUgxMXJwMm1GNlpnZ0c1UHZDUlY5MFRLVElTY0JmMXJjYTdx?=
 =?utf-8?B?Z0RkcGVkS2RVK0p3eG9mQkRTUnd6bmJKYmNBeTYxNyt4Tk5TaE5xUncvdkxF?=
 =?utf-8?B?WHlLYnEzSDFzUUZVTVNCc0gzNXlwSDB5eVd5SzNvYUpzcFFZRTNBZlZHdUhN?=
 =?utf-8?B?SFc1NTA3TFdmTWg0RHd0VkZObS9iR3lPK0hscnVPdzhROXBKYkNITHNyQWRq?=
 =?utf-8?B?V2hWUnpHcHdNZ2dhazFIVWxZVXZTZ29US1JCYkVaMm5LTFJML3dnMUx4cjRZ?=
 =?utf-8?B?Q0NrcGEvd25rWWRlZE1PM2h3Yzd4NzNxMVpocTlobkpsNHBPaWhObXZsdDRl?=
 =?utf-8?B?Z0xRU3J0L1JjVWxZN3NKNnM0NmZlbGF0bEJZS0pSNVl0ZnBJSTBvbzVsWmNG?=
 =?utf-8?B?Y1REalBMVU11bFdNSFcrSG9aU1hlaHNNcE0vcS9ibVd1QmcrWEFmMUFHOU9S?=
 =?utf-8?B?K09ycWlKSXVkbDZpR2o3b2laUWZFZVdySzdTeXd4NS93MlJGWk0yYm5qVkJq?=
 =?utf-8?B?T3h2SlZnaW9Td2pDcko2b0tRSUh5bmthQzVKSkpiVzVNVDRYUFp2K001VkNo?=
 =?utf-8?B?TEM3T1U4VmMrMEpESnNsM3JDWThhLzhMWjdYTmloT2t4U1B2K25iSlJhb1hP?=
 =?utf-8?B?d3ZVcEdmK1ZWM0xUQWhMUG5KZUFVQXhROG9ydi8rNitjNW5TM2MwSkZPTjdT?=
 =?utf-8?B?MmZwWXVrSW5BaW5uT3hyQ1BDYW42Y2dkcDhCc2VTaS9FWFEyVFpHNDdHZ1Fj?=
 =?utf-8?B?UGRhaitBU1ZrZWJEWGZEVm9kWDJIZUw1ZGRHOHlnTXJGK1kxaXlUbmphQkln?=
 =?utf-8?B?eFJBcnFpeGFlWVBkTk9IVjdNK0NtS3laWGVjUFQyR3hiMlIwdUgvbVFhODhH?=
 =?utf-8?B?UlpKUUtHNzhueHFjcDlPODRmcTRnZ1BkSmt6SmdZUHprVm1ubVc5czk4eW45?=
 =?utf-8?B?M1ZZY0k3VUx2cUpaS2dmWlRoQzhwTldFckRyUDN1dTVyQUMrdFZNNHNmUnJL?=
 =?utf-8?B?UGpXUGdPaTl2ZEs5UStkS1hLN1NiTzk4d3h5dVdRWEJWbTAzV3JIMzY3NE5r?=
 =?utf-8?B?ZkJoS2hwSmViNllLbGl4RFpXQ3BJL0s0cUV4V04zN2JNVWdFV1RuVm9hZVBh?=
 =?utf-8?B?aExQNnhnYUR0THlTZFBZRzd3bFZhRW14SXRLTEVMcW1obCtFTDhKekR0emNh?=
 =?utf-8?B?VlcwVnRlTkJDY0xiNHFKRFhLS0NQRXJFRE5TNUozQWJyTG01SUZDMi95K24z?=
 =?utf-8?B?TzVOYzIrWGpZU2RkMU1NT0N0cVM1T3psazJ0aHFNaXNoTEFHUTV2SFJkVFNV?=
 =?utf-8?B?SWRmTS9FdDVmcTlqRUhnVVhRNGlzS2YrUmdGNGJIM3FLcjdaVUcySjc5S0dl?=
 =?utf-8?B?aER4Z0VGL1RnVG54dTRPM25veFJGZmdLU0FPaW16VUhnNW1tSDMrYzF0LzhM?=
 =?utf-8?B?ZUtSNy9JYkVteElNVGliY0NDWU1yRlVCc2hNdk83a01VOWx5ZmNVdEU3VWpi?=
 =?utf-8?B?am4wVTUzNHpvNTRVYi9ldmVCcjRQbUJyQnJjSlNWWkZQdHpQbGEzaTIyWExy?=
 =?utf-8?Q?/AP5yBO62zmlAVMYKBrGSJnbFsOrFTnKSWuM0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y1dmWS9MSkxVN2x0Nk9BS2N4YXBYZDA3d2NTZ0VUcGFhY1VEbFVqbkNpNXFa?=
 =?utf-8?B?TnB3dW5IRnpYRU0yY01IZnMxcGxzOHUyVXgwRWE1WHhMN3BISFlxNU9ScWdW?=
 =?utf-8?B?cHI3R0ZxNHBkRFBsWFlmKzc4Ynd3T2pxK0c0dVYzOWZlU281MkN1U2hSS2dq?=
 =?utf-8?B?VU9WQjBON0g1QWl3TjZqblBBUWxxMlNsaFRYbjNReVBYQWZQUmFsS09pa3R5?=
 =?utf-8?B?ajlBZWVST0FzLzU1MGFGcjRWQWozdU1jS2kvT1d5RWszZ2hvbm5LZitXTmpP?=
 =?utf-8?B?eTlNY1kyN1BrbFhjdURoWFJnc1J0MlM0dVp4eU9rTWFDbXEyMEJ4cURrYlll?=
 =?utf-8?B?bkVZNllpd08zUzRpeWR5M01aNVViQ0xNcDFiZGpFUFpzYk9pRTFBOWJCYzJw?=
 =?utf-8?B?MytqK205RzdoMk5ZbVFMdS9TZ0hpWUErNDByeWdtM0VVU2FtNEkyaHkyc01Z?=
 =?utf-8?B?M2ltcFVaRHBTZDZDUDQ4WXdMR2tHckZLVytyTWJRTFFDRGo5Zk5nMEtuckgw?=
 =?utf-8?B?UjdLNCsyQ2Y3ZnV6eGZDVDFpMDBMdWZtRURLdzBvNHJtQkdGakpBdkNPTncx?=
 =?utf-8?B?UXlYaU54ajNCemlkbEVyUEZwWWd2NUZ3SFlMN09LMzAzMERSNk0xT05yem9N?=
 =?utf-8?B?Rjl0cGllSFhwc2g4dXpmZUhJcE9SQkhNUUZaeGxBUVJ1ejFoNEVJQVFVMGZC?=
 =?utf-8?B?TmFaTzZScFhsQ0tDcVFnd3pWbWZyUVZ6TFBOcVpBaGEweHgyZmZXcjI2WlpL?=
 =?utf-8?B?MTN3dzhsSVhFRExnSEVMRGZxdGRnWW9UT0Z2clFsTVgvKzU5dHYzUVlTd3Jz?=
 =?utf-8?B?ZDdTWG1DY2VQWXAvd0JyR0hWRGVyM1krdnBScTNHQnQxVjR2YXYxMEJJMnlS?=
 =?utf-8?B?U2lVVGtrWWJzSDdHZ3o2Tk9sQkE1dVpZZkl6ZFI0MVl4NzZEcmxjVW9sSEpF?=
 =?utf-8?B?R3p1aXc4WG5YZys5ek1GR2h1TUJ0NTQ0cEcvc1dVTEV5M3NZVUh0VXNmZ01Z?=
 =?utf-8?B?TmF3Vkp6K3RlTVB5VEhCU01HdFh5ZllvblExdG80ZEZmSkY5cmkvelV2TWI3?=
 =?utf-8?B?cGVCSzFnVHp1cVM4a3MrSndkZGJ1OVFRcTdwMXVJZlFzaGhQbHZsaEVja0FH?=
 =?utf-8?B?VUhzekJsUmVHMmp0MzhWREVxZHFjU3JnMVgrTXh4dk5MT3laV09xdGRna0lD?=
 =?utf-8?B?QWZPemtyelZjSCtiT1pqQmJnL2MyVWJuVEM4eVIzSHc5amg5QUI3L215MEMy?=
 =?utf-8?B?SncxS2lZaE5hcEhMZzlrQng4NTJiWUdGNkZVSFpmL0xncVlkWm42emJQZExp?=
 =?utf-8?B?Zk5oV0tNYUgvblZHOVMvMFlFbU1KNW1qdXBYSElBbStkN1ZPWmR1UEI4eDNr?=
 =?utf-8?B?WEhVQk9GSnJSUXgvdEUxandTSjFnWWZQRmx2VDQvUlMyend6K3g1ZGFjaVl5?=
 =?utf-8?B?Qy9uaHNJaDFtSUNjK2EvWEhYTGlhN1RsTGVxMC9rOHozbFBKQ0VYcGF0NzFL?=
 =?utf-8?B?RHAwaERzdFBycmZtVHhpNXppQS9RNm5sUUtkRUVxTWZyRUp6RWZqdlFyTEdW?=
 =?utf-8?B?NGRzQWsyeWV0d3BtYjNnWDVLZE5oSmQxZTRWKzd3U21CWkdoYjdMSnpwY05p?=
 =?utf-8?B?b3E2WXI0NmswaGpoT25GckVPc3IvdzVtcytUWTJjdmhNUlMrTXhCb2Z3V2Ex?=
 =?utf-8?B?K1J4bGF4bUtFcjUxRVhOL3d4dXdaUjVzQTlrTzEvUWJlZ01EYi9rM0o4S0or?=
 =?utf-8?B?UTdtbUFFUC9nOHRpNVdsTFBTeGxGeUlEY0ViUXlKb1h5aEZGOGNFdTQzZWpt?=
 =?utf-8?B?MFB5ZUI1OXJEenk5d200VWRUSUdzUS9HdFZuMDB3NUZKV3lmWi9LaE9LYlQv?=
 =?utf-8?B?N1RuRUpHa3NuWmhUOGY0N1ZGc09UOWhqMWFUR0IyTmhXY3Q3NWczVXBuVWNG?=
 =?utf-8?B?M0tsSUdwR2NrQmRGSVdzbGVFMkdYamYxLzdTTmVvV3lWa2x6Nk9kNWNiL3h3?=
 =?utf-8?B?QlE3Y3EvTERMK3BXNk52Vy8yRDRFbFJUMWNjbDlkTllBNjJReEVNWHlSZk04?=
 =?utf-8?B?UmZjNEgwVEJuN3lPQmsvMVdwRUVJd3dWUFU1VW04UnJKRlVZbzdUcmhrU2gz?=
 =?utf-8?B?cGtjak5PNEdETFVJMjFqOE9KLzhXeWNyNERXTU5LNjgyaGk5bngrN3F6RDdr?=
 =?utf-8?Q?4X8bOv1XrKhbWCXOZBHf2Ac=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b7e059a-dff7-465a-099d-08dde3eddc55
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 15:41:30.1073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ts4Ovg3VvESW4brYoVd83I1WaSSMwyNnz767dmNz9G7k89doQno9jdtWVkapOU9Qc+27/DE/02oYXhSzfcw5GQmEvhs7qjlNCTYefICFZto=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB5767

On 2025-08-23 12:39, Thomas Gleixner wrote:
> Move the comment which documents the RSEQ algorithm to the top of the file,
> so it does not create horrible diffs later when the actual implementation
> is fed into the mincer.

Typo in the subject:

resq -> rseq

> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Other than this nit:

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> ---
>   kernel/rseq.c |  119 ++++++++++++++++++++++++++++------------------------------
>   1 file changed, 59 insertions(+), 60 deletions(-)
> 
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -8,6 +8,65 @@
>    * Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>    */
>   
> +/*
> + * Restartable sequences are a lightweight interface that allows
> + * user-level code to be executed atomically relative to scheduler
> + * preemption and signal delivery. Typically used for implementing
> + * per-cpu operations.
> + *
> + * It allows user-space to perform update operations on per-cpu data
> + * without requiring heavy-weight atomic operations.
> + *
> + * Detailed algorithm of rseq user-space assembly sequences:
> + *
> + *                     init(rseq_cs)
> + *                     cpu = TLS->rseq::cpu_id_start
> + *   [1]               TLS->rseq::rseq_cs = rseq_cs
> + *   [start_ip]        ----------------------------
> + *   [2]               if (cpu != TLS->rseq::cpu_id)
> + *                             goto abort_ip;
> + *   [3]               <last_instruction_in_cs>
> + *   [post_commit_ip]  ----------------------------
> + *
> + *   The address of jump target abort_ip must be outside the critical
> + *   region, i.e.:
> + *
> + *     [abort_ip] < [start_ip]  || [abort_ip] >= [post_commit_ip]
> + *
> + *   Steps [2]-[3] (inclusive) need to be a sequence of instructions in
> + *   userspace that can handle being interrupted between any of those
> + *   instructions, and then resumed to the abort_ip.
> + *
> + *   1.  Userspace stores the address of the struct rseq_cs assembly
> + *       block descriptor into the rseq_cs field of the registered
> + *       struct rseq TLS area. This update is performed through a single
> + *       store within the inline assembly instruction sequence.
> + *       [start_ip]
> + *
> + *   2.  Userspace tests to check whether the current cpu_id field match
> + *       the cpu number loaded before start_ip, branching to abort_ip
> + *       in case of a mismatch.
> + *
> + *       If the sequence is preempted or interrupted by a signal
> + *       at or after start_ip and before post_commit_ip, then the kernel
> + *       clears TLS->__rseq_abi::rseq_cs, and sets the user-space return
> + *       ip to abort_ip before returning to user-space, so the preempted
> + *       execution resumes at abort_ip.
> + *
> + *   3.  Userspace critical section final instruction before
> + *       post_commit_ip is the commit. The critical section is
> + *       self-terminating.
> + *       [post_commit_ip]
> + *
> + *   4.  <success>
> + *
> + *   On failure at [2], or if interrupted by preempt or signal delivery
> + *   between [1] and [3]:
> + *
> + *       [abort_ip]
> + *   F1. <failure>
> + */
> +
>   #include <linux/sched.h>
>   #include <linux/uaccess.h>
>   #include <linux/syscalls.h>
> @@ -98,66 +157,6 @@ static int rseq_validate_ro_fields(struc
>   	unsafe_put_user(value, &t->rseq->field, error_label)
>   #endif
>   
> -/*
> - *
> - * Restartable sequences are a lightweight interface that allows
> - * user-level code to be executed atomically relative to scheduler
> - * preemption and signal delivery. Typically used for implementing
> - * per-cpu operations.
> - *
> - * It allows user-space to perform update operations on per-cpu data
> - * without requiring heavy-weight atomic operations.
> - *
> - * Detailed algorithm of rseq user-space assembly sequences:
> - *
> - *                     init(rseq_cs)
> - *                     cpu = TLS->rseq::cpu_id_start
> - *   [1]               TLS->rseq::rseq_cs = rseq_cs
> - *   [start_ip]        ----------------------------
> - *   [2]               if (cpu != TLS->rseq::cpu_id)
> - *                             goto abort_ip;
> - *   [3]               <last_instruction_in_cs>
> - *   [post_commit_ip]  ----------------------------
> - *
> - *   The address of jump target abort_ip must be outside the critical
> - *   region, i.e.:
> - *
> - *     [abort_ip] < [start_ip]  || [abort_ip] >= [post_commit_ip]
> - *
> - *   Steps [2]-[3] (inclusive) need to be a sequence of instructions in
> - *   userspace that can handle being interrupted between any of those
> - *   instructions, and then resumed to the abort_ip.
> - *
> - *   1.  Userspace stores the address of the struct rseq_cs assembly
> - *       block descriptor into the rseq_cs field of the registered
> - *       struct rseq TLS area. This update is performed through a single
> - *       store within the inline assembly instruction sequence.
> - *       [start_ip]
> - *
> - *   2.  Userspace tests to check whether the current cpu_id field match
> - *       the cpu number loaded before start_ip, branching to abort_ip
> - *       in case of a mismatch.
> - *
> - *       If the sequence is preempted or interrupted by a signal
> - *       at or after start_ip and before post_commit_ip, then the kernel
> - *       clears TLS->__rseq_abi::rseq_cs, and sets the user-space return
> - *       ip to abort_ip before returning to user-space, so the preempted
> - *       execution resumes at abort_ip.
> - *
> - *   3.  Userspace critical section final instruction before
> - *       post_commit_ip is the commit. The critical section is
> - *       self-terminating.
> - *       [post_commit_ip]
> - *
> - *   4.  <success>
> - *
> - *   On failure at [2], or if interrupted by preempt or signal delivery
> - *   between [1] and [3]:
> - *
> - *       [abort_ip]
> - *   F1. <failure>
> - */
> -
>   static int rseq_update_cpu_node_id(struct task_struct *t)
>   {
>   	struct rseq __user *rseq = t->rseq;
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

