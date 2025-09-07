Return-Path: <linux-kernel+bounces-804874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2AE6B48133
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 01:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B14717D33C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 23:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3848120E00B;
	Sun,  7 Sep 2025 23:18:12 +0000 (UTC)
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021123.outbound.protection.outlook.com [52.101.95.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E044E139D1B
	for <linux-kernel@vger.kernel.org>; Sun,  7 Sep 2025 23:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757287091; cv=fail; b=WUE1psTFbfEPKz/xD+haheV5mcFxuncwGkHbXtlH2jkH349L1dBWuC5qTDmAQQa6mm3VfCyiwew1eI1D6I30r8o/OXnk7ex3I61RFFChhFYhIcW4rTfd+L2jEM6HSb7yu4NnaM8wfAtaE23Z7TQKUuO5iDyg9BYjgATsnR/Ntqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757287091; c=relaxed/simple;
	bh=H2uZ+gSNUrwVDLJMDLCVbaap/3HzkOkA6GMmBVwKDkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=K7cjBKKSM7fhqHhKSdeODyDKJjS9M+re4OnZrtkhpiEKsAaRQfQkhk3Ndvfo/UyYN6F1jQnkF1nxXta9s4h0pADGzttgAKBlJaDYuDu/AJDesLHr7eMNugaeOrvL/ozvnHF+iSk/dM3WqRgwRorbgMefy7xc3R69qnMbaZL4ZGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SP1nBD4IKdcTSbuIETIGwStUPYuPTI7wPUx0b4CaYvL/Af5nR9d/QajgtdYu04+ihjJf6PrpbrvMOarPQK53W1wko3BmvwrudUFela5YxgSYJ0KqUPrz5aXA/RW6N6g9A97dbw6tUas+qX6Hrgx954yPaVdAmr7xwLqm7z5krXC1IRBZGUABzeS0mj8A7hn8WbCq34P9NOJhdSpWS3ogGbN1QoCOfTPeLFXsQTtSFB2BhFYTaNId8ARWFd6nZVkUorCekoLMSFPa/1/NRuubWxhZqNdMNYhgZosHI6HcHF/H42f/AJSvBFx/J5ZzKtU7LOnULEwZ5l2iqT5IMWwLWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VxprkbULVzSBqTslgn8txyPe3AOovvjvh5qH9g9sRkY=;
 b=LRUZLQ6o1LMd7SCCa5TO3B0AwM8KK2ce0aIZ0wy8ERT2QGWqzay6tUxfc/pDR1X0qxTOQFHGX8SPO0zeZDRFb70JjZOuuDYfTnRb+gslh7jwQx/878nUMVkZyKW5GT5bqr6BtT101ucRyrx5Y8fNCVBidD+riYrqPbmnLc1DdrdIR5/OSWLg5fi4wWrGkRnDa8BF9YA5LD02zQ49UCKmxD+ytGQ1wREx4prNnNcC9MJAhCQtGBoR1XjqBLXd5EkjU5PKS7T5uCTOl73hFPTQKK0LSI5BVQIEcn0vygtKWOl0Z9eX8lCRImeiZ6loUu2NlAQbwPRilV9hdektn10JKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO3P123MB3401.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:bc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Sun, 7 Sep
 2025 23:18:06 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::5352:7866:8b0f:21f6]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::5352:7866:8b0f:21f6%5]) with mapi id 15.20.9094.017; Sun, 7 Sep 2025
 23:18:06 +0000
Date: Sun, 7 Sep 2025 19:18:01 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Mel Gorman <mgorman@techsingularity.net>, 
	Peter Zijlstra <peterz@infradead.org>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, hpa@zytor.com, oleg@redhat.com, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	linux-kernel@vger.kernel.org, atomlin@atomlin.com
Subject: [RFC] sched: idle: Proposal to remove idle=poll
Message-ID: <jv5aqz342nsq5s2ducloqcwt55naxl3iafdaz33ynp3yzea2pc@kycn6jegsf2w>
References: <20250621235745.3994-1-atomlin@atomlin.com>
 <20250623102334.GP1613200@noisy.programming.kicks-ass.net>
 <7n6zmi3aaxrwfpvkzbugt3e3274zw3qb2kci4yyq2q6gojb3ku@zh3g4rvnyqzi>
 <hpyrujaoqd3qpd46ttrzpcj4hsbxeubfk55zw2k4tvezljxbvq@jeadvbhwdirf>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <hpyrujaoqd3qpd46ttrzpcj4hsbxeubfk55zw2k4tvezljxbvq@jeadvbhwdirf>
X-ClientProxiedBy: BN0PR04CA0205.namprd04.prod.outlook.com
 (2603:10b6:408:e9::30) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO3P123MB3401:EE_
X-MS-Office365-Filtering-Correlation-Id: 39f092d9-89fc-41a6-5575-08ddee64ccc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|3613699012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dlRReFUxS2FZeHFPTHdOZ0QyZTBjcmpZODUvMkZyOGRudS9keWhxSE9tc29F?=
 =?utf-8?B?NXk1K2lyeFpmdTJiUVVGMWp2SzF1aitaeXM1UzdJbm9XajJHUUZGb3hlQU92?=
 =?utf-8?B?WXhHZ3g4WVY1cTk4amFGYU1EQnZudng0TmJNYU1vYnpUcmxuaWkvdkhFVFp1?=
 =?utf-8?B?MnUzalYrUHRmQjFpc3dwNW94Sm5EMTRTTGdSUWtsRHR1dWpzQm5IbStVNDJ0?=
 =?utf-8?B?Q0s0K1dpcDlNVmxFK252MUxMYjVSZHF5NFlod1VUNllBaGU5REpZWUdCUkhQ?=
 =?utf-8?B?Y2x0dkxRZkZnaTh1S3hkaHFrWnZ4OXg3VFQ2cGZibkM2TEl2YzMvaFhMcHJs?=
 =?utf-8?B?UG03RS9GV0tQSk1oV2Z5bmlaOENNWDQyb3RhVjB0SWEvbWloVmViekN0TWVT?=
 =?utf-8?B?S2FKQURVRW1hZS9PdUhtd0l5a1Ruamx3Q1kyaGFXcW02MnJhSDdYSWIyQURa?=
 =?utf-8?B?RTQzdU5EUUUrWUFKQmh2THgxcXNyYW5oUUt1ZWl5TWhjd0FjOUNxQ00xeEh1?=
 =?utf-8?B?blJ4OGovOS9ma21sUUJWQjM2VWlaZVdWSHM4MlNpSXJFNW5ObXJCa2tmOG5F?=
 =?utf-8?B?RmVQUDhIQlpoRExYdVFTMkRzdDB6blJWMHVvTUpnblNheWZLWlkyeVhFWno1?=
 =?utf-8?B?QS83a0l5Zm13OG5hU216OTF4aUF6TWJzTjQzOHpJbEZnM0VXbVlCWk94M1ZO?=
 =?utf-8?B?SWxOV1BaSk1JOXdKQ3BNQmF1SElXSWxkZ1FKbGNzYkZ0eDVJTWdKRHZpNUNH?=
 =?utf-8?B?OTJCbjU0WXQzSE9TMlZlb3VzSlZsUEJEY2xxYXNadUJPOU9GV3AvclNGdjBz?=
 =?utf-8?B?TFFEV2ZCUWJ6K0JTTmp6bWFoKy9tbHFhYjQ4Q3RyOG93VXNnZnVaMzFGS0Va?=
 =?utf-8?B?US9xZ2plUjNKdGM1cENiTHlNVlF5SnUrRXc1c21iVGFIUG5Xbk5JZEVBUzZa?=
 =?utf-8?B?S0lGcFViQWdLYzQvVG1vWHdiLzNxTWVhL0ZiMGhFdFVBWEQrWjNXcEs5NGls?=
 =?utf-8?B?SVdtZUR4VnpQU3JrMXJsVUxiVDFNVkxFY1hVZTZFaEZwaWxHRlpoajREL0JI?=
 =?utf-8?B?N3FTekt6SUpXdUJETzRVamxTRTFRVGdONlBXcnpuT0Y0dHp4TzNha3dPMjFI?=
 =?utf-8?B?OHVDQW53REYzazNPSk9KL24xWitKTUVad3BQWHNDblpqVFRrbzVCZUtuUkJu?=
 =?utf-8?B?emJIT2ZTd2JyZ3RDajZqZ1h4NWFDcW5leTV5and3TDVJUElWVnhRQVQ2eUZI?=
 =?utf-8?B?UU5ScTU2YW44dWhoMVlMQzZyZURDWllKYS9EL2dNRUVHRERtVm9YczdJbXM3?=
 =?utf-8?B?T0R2NHAzeGN0bEJJdTdTc3lGcDhuMDV5WS9wOTU2TzlMMUlhNDlhUTk2cXRZ?=
 =?utf-8?B?UW9uOGp2TlUxaUZ0M3duNDQ5U0xMMldXZHpoZ3pnYmdYUGFiZUtuK3BoZEpW?=
 =?utf-8?B?MElkYk9PZ3R5elBEQkVnNXpmY21GRHFZU2cvT2kxYkduMEZjNlNlUUJIQTh0?=
 =?utf-8?B?Y3d4OGUxdzhqZXgySnJJeFVCM0hPaklaK25BTG5PakdCZkxBVEFodXQva1dI?=
 =?utf-8?B?QW94eXMyR203Nmxtcm5HZ0hxQSt5aXhDeEFKZmxybC9pazl4UG0rdnpkOEJn?=
 =?utf-8?B?MDl4TFYyV0QyclJCSFpyMGRXeUlRUUVmU0pEWlBGSXNraFYyTEJDUjlWY2Fk?=
 =?utf-8?B?a0ppVWtDU21uNHc5b2NwRmxDMWFScXRrWlA5OWhWUlpaUVZPNGdYMnRIQmVw?=
 =?utf-8?B?M3RrcmNvZkVLYmVySi92NHMwanA3VkR0TnZGVlVhU0J4bmtMVjVZM0dIRzVa?=
 =?utf-8?B?bm1xYzNEVVBhcnJ1TThvZFlQbzdmc1kzTkc2Nm9yaThoNmRjRUJlUkUvMHp6?=
 =?utf-8?B?YWt4UFlBQ1RxOUFid2ZmbGh1MEhlRDA0dUY1N1g0MlNBMXBBekMzbCtPMnRV?=
 =?utf-8?B?WjlKc0pVcUpDZTkzMnhLQlNOTVNESzQ2bTl1cjdGREJIcmtqU3NwR0syd1lK?=
 =?utf-8?B?SXM4U3hVa0hnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(3613699012);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M1NNVDV4Z043Ykwva2J6eTByaVVsajVLdytJRjlNSEppTjFTcjMzb2prL0J1?=
 =?utf-8?B?TXROWExPRy9xdTc5Vk00SkFtMDZJMEl4YXk5Y0NQMU5VR1RyNWIxZlFZMmo5?=
 =?utf-8?B?c3RkTkpiaGdQMVZDMWowY1F4U1JFQjVWMVFoWFJiV0VzUzA4YlpOME1rQzUz?=
 =?utf-8?B?a2xTeGxaUnRiWUJLRTRtQVoyLzdMVlNuanphMnA3VVlveWhJcTc3akRReldX?=
 =?utf-8?B?SkZDcVgrbjFTaXJJZjZQeElqWGpLZDdPWTM5L290SVJjeEN3aDAva0ZjYW4w?=
 =?utf-8?B?VmlqNnRzNHp3VDVzbjJ5ci9ySTNKMlZ3RGxPZWpIT1c1TG9GTGJJaFZEY0dq?=
 =?utf-8?B?MUx0dysyTzE4NVpVcUJQclFCWUt1a1FDU2dRVW5PQ0dlaEs1Z2tBT04yMGY5?=
 =?utf-8?B?M1ZrQ0pKK3IzNHdHNDB0UU04YVlPbFVEaXNGNXNMdEpIZVV6dmxZYk1sSThj?=
 =?utf-8?B?WTVQZzQvN24reCtNa0FzZWlWeGY5ZnA0MmI0TnZpeThnQXI4bFlnNXljdlBV?=
 =?utf-8?B?QmFFbUZZcmFCMzNSNWxMSjNyRmtWdmhvZjlEMXlHOHRKMXREek9DVzJKTzdU?=
 =?utf-8?B?SHlnUHJ3THRmV0hmazk3N0FaUGIydjNmeE1UUlh4bThLU3NvR0ExbVNzckkv?=
 =?utf-8?B?czNjSFhxeHVGQUVVOTg5cy9mQ3B0Sm9rVzF2aFJ1c1BaWDdWUnBsbmVTUHVP?=
 =?utf-8?B?Q0todDZaa01xSXBEcEJQdFYvbHJvSmtZbFp2TU9NM2pGdm1FWnlXcnBKazJ2?=
 =?utf-8?B?aENMUWhmTERnZVpCS0lER3Z3Z0ZIUDRic21JWUtFVXhjVFRjdU8yRzBCL2F5?=
 =?utf-8?B?S2w4d1lVcHBnbldMTUMvb1J6RkJ0Z0oyR0tmNUZjaWZIbmtPaEUxcDRSVWF4?=
 =?utf-8?B?Mkp3eVdWSWR4cmRIK2FXZS9OeDdRT2hUMm43aWxTcGZHWWk5SDlHcGV6cFY5?=
 =?utf-8?B?NG5SeUR0SDJQMGo1N3ZQNkhpbEpRMFFlNElicC9HMEppK08vRUs0RHA5V0lP?=
 =?utf-8?B?RW9vNmtFNXZhK3FEdHRNTTBkeHBZV0tWUnFCN0s5YnExOHNwb0ZHRkVDTXR4?=
 =?utf-8?B?QUlqR1Vac294U3ozWDY1bGtVSmJaQzlhbXhZUitOeld1WEU0WmptRHlabG1u?=
 =?utf-8?B?YzFjb1NUQ2p1cTBoVFUrUTJYc0dVQ1l6ZjRtZDZRTGpLUlp6ZE1rSXAvTjI5?=
 =?utf-8?B?emFqTkFvQ1Zob1l5cmtoMlJFU3R5dTlGMFhKWjFWL3lLOVBWanZ3ZTJmUGFi?=
 =?utf-8?B?eS9iYVFub2NBaC9DTTY5RlYyT2NTd2dtZ0VUS1JsRHV2cWE3akYxWGoyYUoy?=
 =?utf-8?B?UjZvbXhtUk8yU2p5VW94Kzd0RTNCR2RiYTI5dlhmYzFKNjVVLzFFQ0ttVWMx?=
 =?utf-8?B?TmFiOVpoSjhXWG1zc0hISE1kUy93NnJhd2dOV2FEKzBreld5YTN0Y3NVaFl1?=
 =?utf-8?B?ZGVUOHp0cEZTU0JpeWdFYmUrRURXZUwwOFkreVpRM2ZyU0xua2kraXF4bDQ2?=
 =?utf-8?B?Vml0a1Zrb3daUHhnOE1sZ0hJUjg1NFJ1K1RJR0V5R3QrSTR2Vld2WWtwK1ZT?=
 =?utf-8?B?R0RzWXZtYlY4Qyt0bDd6bXlja2pPNXpzOWs3SlQwemJYUWVjM1NhTVZUenF0?=
 =?utf-8?B?Q00rVm5sbDZMZGhiZUEwUXZxVDZHd3h6Mmw3d2dqdFFaQzlzMmZUWE1YWlVJ?=
 =?utf-8?B?WG8yekdwa3BRdC9pZEhJRzhWcW5qS1ZBVmVKZFhKUHZxWU1TZzJTYWx2MUNs?=
 =?utf-8?B?ZTNLa1hWajlGRzhKUy9OMXZLOVY0NDlzUEJpQTIva3hUdkNheU1yWnBhZWwx?=
 =?utf-8?B?QS91Wnh1L0ZhQjA1WGNoTzlRN0Qza1cwc2hXMEkvMFBZOXg2ci8xTDM0MlY4?=
 =?utf-8?B?OTltOWNnOGd5QTVDa2hvV242OVVBUW9ra2M5Q2hHNTFwNk1hL0FJbmpRaTNR?=
 =?utf-8?B?UEl0dHBMZ1Z2YlRhaDlybGZaR2hHb3BPdVlhQ2Z0T3FjMmtyZEYwNzJRdFc1?=
 =?utf-8?B?UVZ6TkxDOW9mUTBvVnJzVnZVdEU1QUc3a3RBQ1NQd0RtZmpmQy9xSVJyMDJX?=
 =?utf-8?B?c0RORFRIa0pib3Y0WmZGVGNCY2lpbUtjN1A2SklwNEtJcTdHdDF5RWdlRENq?=
 =?utf-8?Q?0HIC8SxukMHB0csSZ/AHEptY4?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39f092d9-89fc-41a6-5575-08ddee64ccc0
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2025 23:18:06.2627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9TJkmWShtb9SU7F5lsTaEqyNW2CwivKXdLsisA8zdY35XJyj4acsM+21CS2xcG5+gnL0PSGM2Jymkd4+n2IeDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO3P123MB3401

On Sun, Aug 31, 2025 at 06:29:18PM -0400, Aaron Tomlin wrote:
> Yes, I can confirm the PM QoS subsystem allows one to set constraints on a
> per-CPU basis or for the entire system. One can specify a maximum allowed
> latency constraint. As per function pm_qos_resume_latency_us_store() a
> value of "n/a" will prevent the specified CPU from entering the shallowest
> CPU idle-state (namely "C1") given its exit latency constraint.
> Indeed using "idle=poll" to prevent a CPU from entering idle C-states is
> problematic given its crude, all-or-nothing approach.
> 
> Thank you for the suggestion.

Mel, Peter,

I wanted to ask given the availability of the PM QoS subsystem on a Linux
kernel that has Kconfig option CONFIG_PM enabled, does this feature make
'idle=poll' redundant? Furthermore, if I understand correctly, for
platforms that require a generic idle polling mechanism
(CONFIG_GENERIC_IDLE_POLL_SETUP) boot-time parameter 'nohlt' can still be
used, no?

I was thinking about submitting a RFC patch to remove idle=poll.


Kind regards,

-- 
Aaron Tomlin

