Return-Path: <linux-kernel+bounces-785449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6545AB34AD0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 21:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 248F4201664
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 19:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080C121FF25;
	Mon, 25 Aug 2025 19:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Pj5nA0GY"
Received: from CAN01-YQB-obe.outbound.protection.outlook.com (mail-yqbcan01on2104.outbound.protection.outlook.com [40.107.116.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFD1CA5A
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 19:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.116.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756149375; cv=fail; b=FxREMQwazQrUPHtcurKr4TyU5V2waZPbjp51J8O7uxXDro9/DvPq3fcHMsnwba7fkiGPGbWtz0dKJKA/XLrbe3meIaplfR60TzsMqQyy2v0b0JI6tdHfRQnrDdt2AHEcgHghA4uKa2C5VXLUiZfjq0rGIp4Rwow8feJIDjmNTLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756149375; c=relaxed/simple;
	bh=apW0zKIxx0AnfkXNKJ8pb2ZhbEdIGPsSxUecMMyuldI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BN3bGZUMwfvsMC2WZmudyLKUTL5YEa/aOW6jWRphZ0GNolBadLRu59lT4/2KmfQ7rlQer7imrQQLGfJuFJk8Macw7hvlS6QUiCvmK0EMtZCTAGFUQX/GIQGzfi5ZKhmxizfLWOylvCb+q5wJDitQ2zZ2AgixeS1UzLldRYuRA74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=Pj5nA0GY; arc=fail smtp.client-ip=40.107.116.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FYKof2HyMWmBA1RIxqYJWiF7L+b11xbdFLOxt1rIMGC86yD5CtfwsgDi7mDnViInUp7a4751pRHnAdD2oPDtkuZN0deX0o/l4Xhvq0EHrU2Jq4FW9b3UqChPTvgbHf/fSv07CDw0Od200iJfCgg7Kmv2mRoxDyRHT/tPRU+q9ssAl+n4relgp3nnfY6gkacl6D1JfIYdTtPpEDEmpIWJWlQncbihPdfpaQD2P5Wdbxn3V1Bp5Wo1kyrG11zXBWiXsTzDy74PbqjpAQTZdHHDxEwmMnL+FtQq0hoa1cr8JuExVuRtalgzewRgAYBk4gUs0P5tlC/Ko4j0FnaGxlTR6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o7yz0zZJBqy6r9SNiX0bzLaQK/NqfEBCUeO4FyS8Cpc=;
 b=iKdDj+UBmpatSx0hnsgze1/AxQQy9/bh3pW6/2UA5tnCAjAurI4aLRmwDQRDkr+0+1U3ldi6HdPllssTQnUHf5F2lmsnpITQXPFa0jMr45BGlGeEiOgccQCSIj7gEAIxpJYB5PcNZW5pnGjLjq/oq7J9ffFTYPQ4AFn4W52YxrPGWty2WbQwZLGV8Xfhm1l7qDjPo7auvPWOkpQ1cuw1oGRdgPNGrw0jdJk9wssacp299f1OqpPNnVUwvxtQ5U/S0JiGMWD7HFbPDJkfyVIEVi+QViQ4ipcHwedBdqTxX0FuL05tY6gnTG/4t2MYU5JW00UE+c4gN9eCKMU1Aoht2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o7yz0zZJBqy6r9SNiX0bzLaQK/NqfEBCUeO4FyS8Cpc=;
 b=Pj5nA0GYnPKAhQj4m+y6PfCcy8sq1px+bGKe29tP6Jay+X4gIfrO8Quhp694YWZixjc6hBgEZVNtBqhmxJ0g3QzvSsf5dY6T498bvuQLA8pdEbx7fH90Z5c7IqdcQvj2xetBP12jQUEs6ne12yY9Xd6KCxIe3jNt2rhthDfLly1qSVQ9szN7pxBLwPAZBUUI5R0hto959Hb04cPat/XgwUyq0YVdvmBbzdtpXDIQEjT3Abt6gghQEkXKV7ey7K6mGc7EAa/k5JH5HedbY1UwAB8Axc6ovJp6/n0uiqoWFLNVgdqSn5u87CBFye3unDM5kUSruyZ7xD80izyX7uYIUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT4PR01MB9589.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:e0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Mon, 25 Aug
 2025 19:16:08 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9052.021; Mon, 25 Aug 2025
 19:16:08 +0000
Message-ID: <c1eaedb5-0d38-4b32-be27-b0e91bb24752@efficios.com>
Date: Mon, 25 Aug 2025 15:16:06 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V2 19/37] rseq: Provide and use rseq_update_user_cs()
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
 <20250823161654.485063556@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250823161654.485063556@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0128.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::26) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT4PR01MB9589:EE_
X-MS-Office365-Filtering-Correlation-Id: 94870af4-f4f9-4b7f-f84f-08dde40bd822
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U25ZQWljL2YxaTI2KzZFbnVZMnpMR2VhakEyRVVwb0JiMUtrbkNwM0VGN0tu?=
 =?utf-8?B?QjJHZ3JXQUkvaWIyVk5RV05hQVFGNzh3WS9sVkEva1VLcUF2STBsNmpGMVg3?=
 =?utf-8?B?THhRc1p2T0VqMzNieFhZcTRmcmU4bEkxV0JyY01MQldWdk9jMjFCMFlJc3hG?=
 =?utf-8?B?TFhQZjFGclg4cnE5WlNZL291V3FweTdJSlZXVGNxSS92ODZQY1VlNjZpU3dT?=
 =?utf-8?B?Rjd5eUJTQ2srZ2FlWlhvaVRRUUhMb0ZiYURsRlZSZWhhbUs4L0xyTnNRQWRK?=
 =?utf-8?B?bkU0THdUc0RHUVkzdmFwMHNsRUtRUzdDdk80YkIvZlFjT2oyUG9xK3JHLzFY?=
 =?utf-8?B?NWtoK29QRnVvN1NSb25uVVBuZkxLbW83c0lkMGtweDQ5eWFTOHRQNkxrbmpE?=
 =?utf-8?B?ZU41a2lPa2h6NFQrNnhpU2RZZ0dPSVorR1FTUTBBOUtmZ1MxanJlTTJYbTQv?=
 =?utf-8?B?a0tFWkc0c1hzZlk4M2JlenRIL1hMRFlrK09QZ3dnaG5PRVFra0RiNGRzVFNR?=
 =?utf-8?B?RWY1eFFNbm9kQXcxbklRNFh2VkdJbmkvVElXQ1hzS3F1WHZTclFxeTlRdERy?=
 =?utf-8?B?MnlndjAyS2FrQThYa3FtelM3OXB6S0o2T0JJWGcyTW1CbEh5YWYvc3IvK09k?=
 =?utf-8?B?Q3ZOTEE0cVNwcHFEdERYRmtCeWJTOVlvNUxxU1ZybXkwaXJ1dE1GK3lVQTQ0?=
 =?utf-8?B?Rm9iaWtMVnBFOGRHbU02MGtTczk1RmE4QWlHSjhGV2JXcjdpU3Rhay9jQzhZ?=
 =?utf-8?B?dWo1MWhROE5tNDZDUmxLcFJ5K1FCRGZQYzFuNEc2WDBHeG1VTk9xSW0wTkl1?=
 =?utf-8?B?bEwxZ1RMMHJwcnhQWlVpNE55alVIaGdkbWN2Snp5WFNjOW1NQXoyanp0YzlV?=
 =?utf-8?B?b0J4cGd5V0t0d0tjcTFzU2J0YmZFL0YzM2hTbzNGUGdaN3ZXcXdmTzJMS3ZU?=
 =?utf-8?B?WmxBMXNZNUsyNW9rZzdkM2VhSjNaY0szV00wejZWb3RNWVgvWFJlcFp5aGdQ?=
 =?utf-8?B?Q1R4M0xxWG1SRU81bmVEenR2Q3BZTVRjNzdtaFdXenltcW5MSUR6djNLakIv?=
 =?utf-8?B?WlZTaVg0bWtRT09OWlVua2kxSjhqbkFHRVJWMzJOaDE1cm1sVUNLYzlxMFdL?=
 =?utf-8?B?TFl3QzJscWdFQWppVzdFQTRwRmg5RWdyYktSc09TdDNsZkVlYk1HVjZpZ2RS?=
 =?utf-8?B?Mm9nbmp6dVRPNmFCVXJaaUk0azZHZExrdVhlckRWS3ZUaFI5QlNBa1JUSm5F?=
 =?utf-8?B?aWIvUklXb3dnTDV6aHhkbnlLUFdtWkZTS2hMNjdyNVdDNUE3Znc5K05KWXFU?=
 =?utf-8?B?enJuZ0MySTI4UEhNNEYxYnk0bEZLMElLZW1NcFFScFBzSnhuS2w4dThva3Rj?=
 =?utf-8?B?amcxc3FYbW95UWQ5OEpWa0xiRTI5MEp5cTJ6T0FtNVo0QjYxaWpFV0xSUVJs?=
 =?utf-8?B?QityNVljRDI2TmVtekRxVEVrOEk5T3M3b3FLdW15eFBxRVRRakVrUEZ0K2tX?=
 =?utf-8?B?b0t3MHdiUjRMZWhyZHBzWTZUNHV0SFRmUW40VGdxVFdnQUtDVWNzVlR4Ui9m?=
 =?utf-8?B?WUJ6a29RRi9VWEpnMldFR2JraW1xTW1Fb0NyZkZhdmpyWXpyMUd0VkZZemli?=
 =?utf-8?B?bVpndmk4bVFRVVZQb2NmM3Y3LzVRN3VyMEsrbkJkMzc5YktpZUZlSzNrejBW?=
 =?utf-8?B?ZENOZ1BIVmM3RzBKUjNVTGpUb2k4dVBnVmhTNlZxcXFPek1yd1dJME5ibzF4?=
 =?utf-8?B?R2c0K1ZlMHBxZFZraTJ2U29uTzhjWHRhelE0Q0JBUWpZczdITS9DNkxjUHRS?=
 =?utf-8?Q?KrTdVf6C+Fz7KXRMvpIYFP49Z8U0t3iQsTbzc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QUdSYjhSMGNNSy9nbW01cXZRUFlMVlBlVDhqdXRiVFFRdmhRZVdRMGhBblRs?=
 =?utf-8?B?ZGRVR0NubkZIOFZNd3l2UVJOTlhQcEliZzlxajEzMGdGL3h4eGRnUnZkQjUr?=
 =?utf-8?B?RVhXVVlYcmZwWDU1eWhuZHgxNUlSTTJHOGZOMjgyT21mVDVzNldoSnRxNkFJ?=
 =?utf-8?B?SGZNNzRqWG9kQW51MElnSVNSVFdvQjNkUXVjTnlTbUJDYTZlQ2MyZ3lnUTV1?=
 =?utf-8?B?Zi9jOXVuUlZyNjNuRVp4V2hlbFEvZGZuNnJQVFVJLzhjQndOZTZoZ2R3RGdC?=
 =?utf-8?B?U3FLVWtVd3NTeVRnRUViU3E2NUl0eUswR01nd2J0d1VmcitNN1B3czZhOUZo?=
 =?utf-8?B?UUhwS0duTGhXak1YR1J0WTZBbEpSNXpaNUIzM1JJMDFJV1dxWUt2NkFVdmEz?=
 =?utf-8?B?YTg0SnJZQk93K3JaOWY1a09rcjB0c01vamtaYld1bGVCSG1ESXAzUmU2WHd0?=
 =?utf-8?B?bHVvbmRoV1hGbWIrWGhsaWFrNVpURUxVR29DTlZIYjh4ei9raUtYSEhJaE56?=
 =?utf-8?B?S0ZuZFBJbStDQ2xxK0toaE1rZkQrcjlrMlZqNWUyTERsRDJXY25mRlF6QmF1?=
 =?utf-8?B?ZUN6ZEdlb2x3QTQxVUcyS0VwZWZCcXNlL3lGQW95VldYQno5dlQ2Wm9weWMw?=
 =?utf-8?B?S1RWRjYvVDg0NkQ0M1VlMmZ6bnFjcExuckpGZWlxRzZQeFUzTlJYU2xEZmhL?=
 =?utf-8?B?NDQ0L3ViQXE2NllxZE1kYUxGMnA4RXpUVnlkOGhMMFIwd3lBM0tZNFk1cTBr?=
 =?utf-8?B?M3gvSjN3bjRtZ3BCTmhWVlRSNHovbkcrVXFXdW5XTWlldGJud2VieXZCRWlS?=
 =?utf-8?B?Z1VnQlBCbjU2WlB5VTREZnRrZ2pQY3dmcVhDS1lPTnlUSE9TZStEYXJwczBX?=
 =?utf-8?B?NllveE1XVUNJZEN6ckdTSWRoTS9tR2RpdlpRU1dWbVRvalk4TVRyWDNJZ1Uy?=
 =?utf-8?B?TVlqL1JiTTd6Q0RxUWJRVVFXcE8xRis2bWhjSWMzYXpRK3FDSjFuYmM2eHdi?=
 =?utf-8?B?UmFrOEhQL0duTFlRMHJPUXU1RGRFZ2MzQ2xCWFpheUltNnBoMEFocWQvOHZI?=
 =?utf-8?B?WjB4YlBqWjlZSFVPanl5ZXdOdHpwK0diMlNEQm1NMkZYbHRaMVdSYjZPZXUw?=
 =?utf-8?B?UWsrWWllQXBUVWhIdE9FYTl6cjRWeFAzUFJxYjA4UjI5V0JlOUllZ3Njakww?=
 =?utf-8?B?YWdkNmFlU0NxN1hwcnV2L2l1T0dhcDBNYkFYeHZiZHIxMnlLYUNqRjlEbmtJ?=
 =?utf-8?B?a3g2R3pYSVVDdWlNUWkrWnFYZDVWUks3NktOSnFDcmdyZnRGdklFY0dXd1g1?=
 =?utf-8?B?M3ZqTzZUaDBEUjA2R09GMlRndW1xdm5TUXZSZW5XZW5XSk9ZVW1zOU5SYTRw?=
 =?utf-8?B?cWxMY3plaXdtV0JlT1lHcFhGQU95ZmltTlFIT2ZLQXBwK3QvS0RGdHFLSm9w?=
 =?utf-8?B?djFVTUcycGZTMExnL2ZXLzU4aHo2Nk4zcXN2NXc5SExsS0k4QlVmZmtQZ08x?=
 =?utf-8?B?OWkrQUlFcG51L1lod3daSm82aWNqYkVkODViWHVEUVpKbmN1QnpMcEF1Vm1z?=
 =?utf-8?B?c3ozK09OdE15emxmeXpveUpmSWlQa2RXMmM3ZTl0ak14NUtubDZoTFo5NDBX?=
 =?utf-8?B?MzVVRjlrMFF2R01DRU9zMjhqUUQzS04rU3M0ZHlCOFVkQTdSVmxCL1lJdjNK?=
 =?utf-8?B?U0dua0RwU1YyL1ZQNWpWTEM4d3BtRVNLZWVSQjY5QWJsUEUxQzNFaHBndHBU?=
 =?utf-8?B?SjRQNXhMdEluUGgrWVE2dkNuSlJoaUtMZkdOcTY0YXRaTHlSSk04TjBFK3Rq?=
 =?utf-8?B?aytQbzZMVGxKVmNiQmp6ajFPamxnWTNzdENjdFgzVmdMcnJzOE93V2VYV2d0?=
 =?utf-8?B?bTNBVm14MlVXU3RQakdPN3hLZmdOVVc0dEIybVF2Z3RpeFVVZkFoTzY2VFlG?=
 =?utf-8?B?K0dWM0FpaGx0SWdidk0zMUtVbUZ5UUFxSWlhRnBIUWMvUDRHb0pEWnEzeC9G?=
 =?utf-8?B?NUV6UXdkaXZDNCt1TEtxbHhOTkQvaHhIcXZTdUgzSmFhNUt5TFdqVEp0ajAv?=
 =?utf-8?B?WEdSWTUrQUg3ZlJzRDBRaExFMnFISXBPNmZXM2IvSG82aGUzbEpieDdMZk5w?=
 =?utf-8?B?cnBMWWoyclEwV2RPV0w5MUlsa0tCTGlEalptQ2FDUGJGcnV1ZG04VFJRZ3RC?=
 =?utf-8?Q?2F5asCSdUZAbxq2Hl+bztG4=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94870af4-f4f9-4b7f-f84f-08dde40bd822
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 19:16:08.0474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qPuRGn25I85ekYSw2jjgYoiKPJIjdscGwNaVtmHrwb8BLr3toOE8bZaEQh4gtu4g3Pe2Ns1Bxg5nCaFVwC+Qy7YKmfU3ioqCAjKnIqARmq8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT4PR01MB9589

On 2025-08-23 12:39, Thomas Gleixner wrote:
> Provide a straight forward implementation to check for and eventually
> clear/fixup critical sections in user space.
> 
> The non-debug version does not any sanity checks and aims for efficiency.

"does not any sanity checks" -> "does no sanity checks"

> 
> The only attack vector, which needs to be reliably prevented is an abort IP
> which is in the kernel address space. That would cause at least x86 to
> return to kernel space via IRET. Instead of a check, just mask the address
> and be done with it.
> 
> The magic signature check along with it's obscure "possible attack" printk

its

> is just voodoo security. If an attacker manages to manipulate the abort_ip
> member in the critical section descriptor, then it can equally manipulate
> any other indirection in the application.

I disagree with this claim. What we are trying to prevent is not an
attacker manipulating an existing rseq_cs descriptor, but rather
crafting its own descriptor and using it to bypass ROP protections.


> If user space truly cares about
> the security of the critical section descriptors, then it should set them
> up once and map the descriptor memory read only.

AFAIR, the attack pattern we are trying to tackle here is:

The attacker has write access to some memory (e.g. stack or heap) and
uses his area to craft a custom rseq_cs descriptor. Using this home-made
descriptor and storing to rseq->rseq_cs, it can set an abort_ip to e.g.
glibc system(3) and easily call any library function through an aborting
rseq critical section, thus bypassing ROP prevention mechanisms.

Requiring the signature prior to the abort ip target prevents using rseq
to bypass ROP prevention, because those ROP gadget targets don't have
the signature.

> There is no justification
> for voodoo security in the kernel fast path to encourage user space to be
> careless under a completely non-sensical "security" claim.
> 
> If the section descriptors are invalid then the resulting misbehaviour of
> the user space application is not the kernels problem.
> 
> The kernel provides a run-time switchable debug slow path, which implements
> the full zoo of checks (except the silly attack message) including
> termination of the task when one of the gazillion conditions is not met.
> 
> Replace the zoo in rseq.c with it and invoke it from the TIF_NOTIFY_RESUME
> handler. Move the reminders into the CONFIG_DEBUG_RSEQ section, which will
> be replaced and removed in a subsequent step.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   include/linux/rseq_entry.h |  194 ++++++++++++++++++++++++++++++++++++
>   include/linux/rseq_types.h |   11 +-
>   kernel/rseq.c              |  238 +++++++++++++--------------------------------
>   3 files changed, 273 insertions(+), 170 deletions(-)
> 
> --- a/include/linux/rseq_entry.h
> +++ b/include/linux/rseq_entry.h
> @@ -36,6 +36,7 @@ DECLARE_PER_CPU(struct rseq_stats, rseq_
>   #ifdef CONFIG_RSEQ
>   #include <linux/jump_label.h>
>   #include <linux/rseq.h>
> +#include <linux/uaccess.h>
>   
>   #include <linux/tracepoint-defs.h>
>   
> @@ -69,12 +70,205 @@ static inline void rseq_trace_ip_fixup(u
>   
>   DECLARE_STATIC_KEY_MAYBE(CONFIG_RSEQ_DEBUG_DEFAULT_ENABLE, rseq_debug_enabled);
>   
> +#ifdef RSEQ_BUILD_SLOW_PATH
> +#define rseq_inline
> +#else
> +#define rseq_inline __always_inline
> +#endif
> +
> +bool rseq_debug_update_user_cs(struct task_struct *t, struct pt_regs *regs, unsigned long csaddr);
> +
>   static __always_inline void rseq_note_user_irq_entry(void)
>   {
>   	if (IS_ENABLED(CONFIG_GENERIC_IRQ_ENTRY))
>   		current->rseq_event.user_irq = true;
>   }
>   
> +/*
> + * Check whether there is a valid critical section and whether the
> + * instruction pointer in @regs is inside the critical section.
> + *
> + *  - If the critical section is invalid, terminate the task.
> + *
> + *  - If valid and the instruction pointer is inside, set it to the abort IP
> + *
> + *  - If valid and the instruction pointer is outside, clear the critical
> + *    section address.
> + *
> + * Returns true, if the section was valid and either fixup or clear was
> + * done, false otherwise.
> + *
> + * In the failure case task::rseq_event::fatal is set when a invalid
> + * section was found. It's clear when the failure was an unresolved page
> + * fault.
> + *
> + * If inlined into the exit to user path with interrupts disabled, the
> + * caller has to protect against page faults with pagefault_disable().
> + *
> + * In preemptible task context this would be counterproductive as the page
> + * faults could not be fully resolved. As a consequence unresolved page
> + * faults in task context are fatal too.
> + */
> +
> +#ifdef RSEQ_BUILD_SLOW_PATH
> +/*
> + * The debug version is put out of line, but kept here so the code stays
> + * together.
> + *
> + * @csaddr has already been checked by the caller to be in user space
> + */
> +bool rseq_debug_update_user_cs(struct task_struct *t, struct pt_regs *regs, unsigned long csaddr)
> +{
> +	struct rseq_cs __user *ucs = (struct rseq_cs __user *)(unsigned long)csaddr;
> +	u64 start_ip, abort_ip, offset, cs_end, head, tasksize = TASK_SIZE;
> +	unsigned long ip = instruction_pointer(regs);
> +	u64 __user *uc_head = (u64 __user *) ucs;
> +	u32 usig, __user *uc_sig;
> +
> +	if (!user_rw_masked_begin(ucs))
> +		return false;
> +
> +	/*
> +	 * Evaluate the user pile and exit if one of the conditions is not
> +	 * fulfilled.
> +	 */
> +	unsafe_get_user(start_ip, &ucs->start_ip, fail);
> +	if (unlikely(start_ip >= tasksize))
> +		goto die;
> +	/* If outside, just clear the critical section. */
> +	if (ip < start_ip)
> +		goto clear;
> +
> +	unsafe_get_user(offset, &ucs->post_commit_offset, fail);
> +	cs_end = start_ip + offset;
> +	/* Check for overflow and wraparound */
> +	if (unlikely(cs_end >= tasksize || cs_end < start_ip))
> +		goto die;
> +
> +	/* If not inside, clear it. */
> +	if (ip >= cs_end)
> +		goto clear;
> +
> +	unsafe_get_user(abort_ip, &ucs->abort_ip, fail);
> +	/* Ensure it's "valid" */
> +	if (unlikely(abort_ip >= tasksize || abort_ip < sizeof(*uc_sig)))
> +		goto die;
> +	/* Validate that the abort IP is not in the critical section */
> +	if (unlikely(abort_ip - start_ip < offset))
> +		goto die;
> +
> +	/*
> +	 * Check version and flags for 0. No point in emitting deprecated
> +	 * warnings before dying. That could be done in the slow path
> +	 * eventually, but *shrug*.
> +	 */
> +	unsafe_get_user(head, uc_head, fail);
> +	if (unlikely(head))
> +		goto die;
> +
> +	/* abort_ip - 4 is >= 0. See abort_ip check above */
> +	uc_sig = (u32 __user *)(unsigned long)(abort_ip - sizeof(*uc_sig));
> +	unsafe_get_user(usig, uc_sig, fail);
> +	if (unlikely(usig != t->rseq_sig))
> +		goto die;
> +
> +	/* rseq_event.user_irq is only valid if CONFIG_GENERIC_IRQ_ENTRY=y */
> +	if (IS_ENABLED(CONFIG_GENERIC_IRQ_ENTRY)) {
> +		/* If not in interrupt from user context, let it die */
> +		if (unlikely(!t->rseq_event.user_irq))
> +			goto die;
> +	}
> +
> +	unsafe_put_user(0ULL, &t->rseq->rseq_cs, fail);
> +	user_access_end();
> +
> +	instruction_pointer_set(regs, (unsigned long)abort_ip);
> +
> +	rseq_stat_inc(rseq_stats.fixup);
> +	rseq_trace_ip_fixup(ip, start_ip, offset, abort_ip);
> +	return true;
> +clear:
> +	unsafe_put_user(0ULL, &t->rseq->rseq_cs, fail);
> +	user_access_end();
> +	rseq_stat_inc(rseq_stats.clear);
> +	return true;
> +die:
> +	t->rseq_event.fatal = true;
> +fail:
> +	user_access_end();
> +	return false;
> +}
> +#endif /* RSEQ_BUILD_SLOW_PATH */
> +
> +/*
> + * This only ensures that abort_ip is in the user address space by masking it.
> + * No other sanity checks are done here, that's what the debug code is for.

I wonder if we should consider adding a runtime config knob, perhaps
a kernel boot argument, a sysctl, or a per-process prctl, to allow
enforcing rseq ROP protection in security-focused use-cases ?

Thanks,

Mathieu

> + */
> +static rseq_inline bool
> +rseq_update_user_cs(struct task_struct *t, struct pt_regs *regs, unsigned long csaddr)
> +{
> +	struct rseq_cs __user *ucs = (struct rseq_cs __user *)(unsigned long)csaddr;
> +	unsigned long ip = instruction_pointer(regs);
> +	u64 start_ip, abort_ip, offset;
> +
> +	rseq_stat_inc(rseq_stats.cs);
> +
> +	if (unlikely(csaddr >= TASK_SIZE)) {
> +		t->rseq_event.fatal = true;
> +		return false;
> +	}
> +
> +	if (static_branch_unlikely(&rseq_debug_enabled))
> +		return rseq_debug_update_user_cs(t, regs, csaddr);
> +
> +	if (!user_rw_masked_begin(ucs))
> +		return false;
> +
> +	unsafe_get_user(start_ip, &ucs->start_ip, fail);
> +	unsafe_get_user(offset, &ucs->post_commit_offset, fail);
> +	unsafe_get_user(abort_ip, &ucs->abort_ip, fail);
> +
> +	/*
> +	 * No sanity checks. If user space screwed it up, it can
> +	 * keep the pieces. That's what debug code is for.
> +	 *
> +	 * If outside, just clear the critical section.
> +	 */
> +	if (ip - start_ip >= offset)
> +		goto clear;
> +
> +	/*
> +	 * Force it to be in user space as x86 IRET would happily return to
> +	 * the kernel. Can't use TASK_SIZE as a mask because that's not
> +	 * necessarily a power of two. Just make sure it's in the user
> +	 * address space. Let the pagefault handler sort it out.
> +	 *
> +	 * Use LONG_MAX and not LLONG_MAX to keep it correct for 32 and 64
> +	 * bit architectures.
> +	 */
> +	abort_ip &= (u64)LONG_MAX;
> +
> +	/* Invalidate the critical section */
> +	unsafe_put_user(0ULL, &t->rseq->rseq_cs, fail);
> +	user_access_end();
> +
> +	/* Update the instruction pointer */
> +	instruction_pointer_set(regs, (unsigned long)abort_ip);
> +
> +	rseq_stat_inc(rseq_stats.fixup);
> +	rseq_trace_ip_fixup(ip, start_ip, offset, abort_ip);
> +	return true;
> +clear:
> +	unsafe_put_user(0ULL, &t->rseq->rseq_cs, fail);
> +	user_access_end();
> +	rseq_stat_inc(rseq_stats.clear);
> +	return true;
> +
> +fail:
> +	user_access_end();
> +	return false;
> +}
> +
>   static __always_inline void rseq_exit_to_user_mode(void)
>   {
>   	struct rseq_event *ev = &current->rseq_event;
> --- a/include/linux/rseq_types.h
> +++ b/include/linux/rseq_types.h
> @@ -11,10 +11,12 @@
>    * @sched_switch:	True if the task was scheduled out
>    * @user_irq:		True on interrupt entry from user mode
>    * @has_rseq:		True if the task has a rseq pointer installed
> + * @error:		Compound error code for the slow path to analyze
> + * @fatal:		User space data corrupted or invalid
>    */
>   struct rseq_event {
>   	union {
> -		u32				all;
> +		u64				all;
>   		struct {
>   			union {
>   				u16		events;
> @@ -25,6 +27,13 @@ struct rseq_event {
>   			};
>   
>   			u8			has_rseq;
> +			u8			__pad;
> +			union {
> +				u16		error;
> +				struct {
> +					u8	fatal;
> +				};
> +			};
>   		};
>   	};
>   };
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -382,175 +382,15 @@ static int rseq_reset_rseq_cpu_node_id(s
>   	return -EFAULT;
>   }
>   
> -/*
> - * Get the user-space pointer value stored in the 'rseq_cs' field.
> - */
> -static int rseq_get_rseq_cs_ptr_val(struct rseq __user *rseq, u64 *rseq_cs)
> -{
> -	if (!rseq_cs)
> -		return -EFAULT;
> -
> -#ifdef CONFIG_64BIT
> -	if (get_user(*rseq_cs, &rseq->rseq_cs))
> -		return -EFAULT;
> -#else
> -	if (copy_from_user(rseq_cs, &rseq->rseq_cs, sizeof(*rseq_cs)))
> -		return -EFAULT;
> -#endif
> -
> -	return 0;
> -}
> -
> -/*
> - * If the rseq_cs field of 'struct rseq' contains a valid pointer to
> - * user-space, copy 'struct rseq_cs' from user-space and validate its fields.
> - */
> -static int rseq_get_rseq_cs(struct task_struct *t, struct rseq_cs *rseq_cs)
> -{
> -	struct rseq_cs __user *urseq_cs;
> -	u64 ptr;
> -	u32 __user *usig;
> -	u32 sig;
> -	int ret;
> -
> -	ret = rseq_get_rseq_cs_ptr_val(t->rseq, &ptr);
> -	if (ret)
> -		return ret;
> -
> -	/* If the rseq_cs pointer is NULL, return a cleared struct rseq_cs. */
> -	if (!ptr) {
> -		memset(rseq_cs, 0, sizeof(*rseq_cs));
> -		return 0;
> -	}
> -	/* Check that the pointer value fits in the user-space process space. */
> -	if (ptr >= TASK_SIZE)
> -		return -EINVAL;
> -	urseq_cs = (struct rseq_cs __user *)(unsigned long)ptr;
> -	if (copy_from_user(rseq_cs, urseq_cs, sizeof(*rseq_cs)))
> -		return -EFAULT;
> -
> -	if (rseq_cs->start_ip >= TASK_SIZE ||
> -	    rseq_cs->start_ip + rseq_cs->post_commit_offset >= TASK_SIZE ||
> -	    rseq_cs->abort_ip >= TASK_SIZE ||
> -	    rseq_cs->version > 0)
> -		return -EINVAL;
> -	/* Check for overflow. */
> -	if (rseq_cs->start_ip + rseq_cs->post_commit_offset < rseq_cs->start_ip)
> -		return -EINVAL;
> -	/* Ensure that abort_ip is not in the critical section. */
> -	if (rseq_cs->abort_ip - rseq_cs->start_ip < rseq_cs->post_commit_offset)
> -		return -EINVAL;
> -
> -	usig = (u32 __user *)(unsigned long)(rseq_cs->abort_ip - sizeof(u32));
> -	ret = get_user(sig, usig);
> -	if (ret)
> -		return ret;
> -
> -	if (current->rseq_sig != sig) {
> -		printk_ratelimited(KERN_WARNING
> -			"Possible attack attempt. Unexpected rseq signature 0x%x, expecting 0x%x (pid=%d, addr=%p).\n",
> -			sig, current->rseq_sig, current->pid, usig);
> -		return -EINVAL;
> -	}
> -	return 0;
> -}
> -
> -static bool rseq_warn_flags(const char *str, u32 flags)
> +static bool rseq_handle_cs(struct task_struct *t, struct pt_regs *regs)
>   {
> -	u32 test_flags;
> +	u64 csaddr;
>   
> -	if (!flags)
> +	if (get_user_masked_u64(&csaddr, &t->rseq->rseq_cs))
>   		return false;
> -	test_flags = flags & RSEQ_CS_NO_RESTART_FLAGS;
> -	if (test_flags)
> -		pr_warn_once("Deprecated flags (%u) in %s ABI structure", test_flags, str);
> -	test_flags = flags & ~RSEQ_CS_NO_RESTART_FLAGS;
> -	if (test_flags)
> -		pr_warn_once("Unknown flags (%u) in %s ABI structure", test_flags, str);
> -	return true;
> -}
> -
> -static int rseq_check_flags(struct task_struct *t, u32 cs_flags)
> -{
> -	u32 flags;
> -	int ret;
> -
> -	if (rseq_warn_flags("rseq_cs", cs_flags))
> -		return -EINVAL;
> -
> -	/* Get thread flags. */
> -	ret = get_user(flags, &t->rseq->flags);
> -	if (ret)
> -		return ret;
> -
> -	if (rseq_warn_flags("rseq", flags))
> -		return -EINVAL;
> -	return 0;
> -}
> -
> -static int clear_rseq_cs(struct rseq __user *rseq)
> -{
> -	/*
> -	 * The rseq_cs field is set to NULL on preemption or signal
> -	 * delivery on top of rseq assembly block, as well as on top
> -	 * of code outside of the rseq assembly block. This performs
> -	 * a lazy clear of the rseq_cs field.
> -	 *
> -	 * Set rseq_cs to NULL.
> -	 */
> -#ifdef CONFIG_64BIT
> -	return put_user(0UL, &rseq->rseq_cs);
> -#else
> -	if (clear_user(&rseq->rseq_cs, sizeof(rseq->rseq_cs)))
> -		return -EFAULT;
> -	return 0;
> -#endif
> -}
> -
> -/*
> - * Unsigned comparison will be true when ip >= start_ip, and when
> - * ip < start_ip + post_commit_offset.
> - */
> -static bool in_rseq_cs(unsigned long ip, struct rseq_cs *rseq_cs)
> -{
> -	return ip - rseq_cs->start_ip < rseq_cs->post_commit_offset;
> -}
> -
> -static int rseq_ip_fixup(struct pt_regs *regs, bool abort)
> -{
> -	unsigned long ip = instruction_pointer(regs);
> -	struct task_struct *t = current;
> -	struct rseq_cs rseq_cs;
> -	int ret;
> -
> -	rseq_stat_inc(rseq_stats.cs);
> -
> -	ret = rseq_get_rseq_cs(t, &rseq_cs);
> -	if (ret)
> -		return ret;
> -
> -	/*
> -	 * Handle potentially not being within a critical section.
> -	 * If not nested over a rseq critical section, restart is useless.
> -	 * Clear the rseq_cs pointer and return.
> -	 */
> -	if (!in_rseq_cs(ip, &rseq_cs)) {
> -		rseq_stat_inc(rseq_stats.clear);
> -		return clear_rseq_cs(t->rseq);
> -	}
> -	ret = rseq_check_flags(t, rseq_cs.flags);
> -	if (ret < 0)
> -		return ret;
> -	if (!abort)
> -		return 0;
> -	ret = clear_rseq_cs(t->rseq);
> -	if (ret)
> -		return ret;
> -	rseq_stat_inc(rseq_stats.fixup);
> -	trace_rseq_ip_fixup(ip, rseq_cs.start_ip, rseq_cs.post_commit_offset,
> -			    rseq_cs.abort_ip);
> -	instruction_pointer_set(regs, (unsigned long)rseq_cs.abort_ip);
> -	return 0;
> +	if (likely(!csaddr))
> +		return true;
> +	return rseq_update_user_cs(t, regs, csaddr);
>   }
>   
>   /*
> @@ -567,8 +407,8 @@ static int rseq_ip_fixup(struct pt_regs
>   void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
>   {
>   	struct task_struct *t = current;
> -	int ret, sig;
>   	bool event;
> +	int sig;
>   
>   	/*
>   	 * If invoked from hypervisors before entering the guest via
> @@ -618,8 +458,7 @@ void __rseq_handle_notify_resume(struct
>   	if (!IS_ENABLED(CONFIG_DEBUG_RSEQ) && !event)
>   		return;
>   
> -	ret = rseq_ip_fixup(regs, event);
> -	if (unlikely(ret < 0))
> +	if (!rseq_handle_cs(t, regs))
>   		goto error;
>   
>   	if (unlikely(rseq_update_cpu_node_id(t)))
> @@ -632,6 +471,67 @@ void __rseq_handle_notify_resume(struct
>   }
>   
>   #ifdef CONFIG_DEBUG_RSEQ
> +/*
> + * Unsigned comparison will be true when ip >= start_ip, and when
> + * ip < start_ip + post_commit_offset.
> + */
> +static bool in_rseq_cs(unsigned long ip, struct rseq_cs *rseq_cs)
> +{
> +	return ip - rseq_cs->start_ip < rseq_cs->post_commit_offset;
> +}
> +
> +/*
> + * If the rseq_cs field of 'struct rseq' contains a valid pointer to
> + * user-space, copy 'struct rseq_cs' from user-space and validate its fields.
> + */
> +static int rseq_get_rseq_cs(struct task_struct *t, struct rseq_cs *rseq_cs)
> +{
> +	struct rseq_cs __user *urseq_cs;
> +	u64 ptr;
> +	u32 __user *usig;
> +	u32 sig;
> +	int ret;
> +
> +	if (get_user_masked_u64(&ptr, &t->rseq->rseq_cs))
> +		return -EFAULT;
> +
> +	/* If the rseq_cs pointer is NULL, return a cleared struct rseq_cs. */
> +	if (!ptr) {
> +		memset(rseq_cs, 0, sizeof(*rseq_cs));
> +		return 0;
> +	}
> +	/* Check that the pointer value fits in the user-space process space. */
> +	if (ptr >= TASK_SIZE)
> +		return -EINVAL;
> +	urseq_cs = (struct rseq_cs __user *)(unsigned long)ptr;
> +	if (copy_from_user(rseq_cs, urseq_cs, sizeof(*rseq_cs)))
> +		return -EFAULT;
> +
> +	if (rseq_cs->start_ip >= TASK_SIZE ||
> +	    rseq_cs->start_ip + rseq_cs->post_commit_offset >= TASK_SIZE ||
> +	    rseq_cs->abort_ip >= TASK_SIZE ||
> +	    rseq_cs->version > 0)
> +		return -EINVAL;
> +	/* Check for overflow. */
> +	if (rseq_cs->start_ip + rseq_cs->post_commit_offset < rseq_cs->start_ip)
> +		return -EINVAL;
> +	/* Ensure that abort_ip is not in the critical section. */
> +	if (rseq_cs->abort_ip - rseq_cs->start_ip < rseq_cs->post_commit_offset)
> +		return -EINVAL;
> +
> +	usig = (u32 __user *)(unsigned long)(rseq_cs->abort_ip - sizeof(u32));
> +	ret = get_user(sig, usig);
> +	if (ret)
> +		return ret;
> +
> +	if (current->rseq_sig != sig) {
> +		printk_ratelimited(KERN_WARNING
> +			"Possible attack attempt. Unexpected rseq signature 0x%x, expecting 0x%x (pid=%d, addr=%p).\n",
> +			sig, current->rseq_sig, current->pid, usig);
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
>   
>   /*
>    * Terminate the process if a syscall is issued within a restartable
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

