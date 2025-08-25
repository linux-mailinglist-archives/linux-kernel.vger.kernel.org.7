Return-Path: <linux-kernel+bounces-785393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D44B34A07
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 20:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75F0A17A2A2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 18:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B77630EF91;
	Mon, 25 Aug 2025 18:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="ROevsfTL"
Received: from CAN01-YQB-obe.outbound.protection.outlook.com (mail-yqbcan01on2107.outbound.protection.outlook.com [40.107.116.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AA230E0F5
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 18:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.116.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756145699; cv=fail; b=TUTuu95wdHNCwUcOggCYXhqF0oVQuJ17wU7JL4zdRFEOCfP3RFARzLyw/k8vtdILD0zDckDTZBRWNji74muvEhMhrJ6jaeZ4ecjHUeEhZr/uekECmyTya4EKJAsaiyhDDbt/dashBnVBETvBmvB4ynD3fJ0eGGwpkYYUUdoIqTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756145699; c=relaxed/simple;
	bh=6Qs18RFYY7FEJqqfwNYDHiI0ux5OxgY4EEOtXIvnEkc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZFWTpSnwosZI9csJXqjQvTdO+P1U2RzARCcZ6wDXtzNN29g2asBS/uIMry7IguKU5P+rzQKgQXV1eEO/oveoZFL3QgM40wQ5Ndkof1GbBI65PwNZvVpv01Hj2+T28A9yrIGlFcNhaOZ5v2c8IMdxczXjnGNHU5wQqU0Kbh0Dmfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=ROevsfTL; arc=fail smtp.client-ip=40.107.116.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SL6pR4k16DWzYzuYtrocoyRzW+HenHjCNORg5RMsAmIEXqNMfa9DeGHWqryMdHiAoaEyTRaq3A+354fpX34k8n5X6wRuotVO68BP/MEKVVunEmOCt+XmTrTIoFCx055mGja7DxEeCUee7GQpR85xlV8K24KrzhO0G5VN+oijyIdrwdpDw0PjwAibSQwmNcgfDOgp0rxMcsFBJUNrE7FG9MbwiiNKZ4zWdGDAwFaFo4sL7Zd8UEeo0wjzF1ZQEtsZlVbZCKMZ2RtZ8LVVurUPWgKTTPKc1avxQrYPL0z+sChmgjvcmOn6Fgl3ckxYuuA5AqDp6nThveUl3lF4LwfPRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zaZ8aaBRDq/e5KvifEYfA4SZKzIXHCpWaoVw2/efsPY=;
 b=vnQvswY+UQmtHcJ1Otapk87asfmstulQXT5geJ0t1TxQ6L0y1tAYN0fxv+C7Piv6rdr1la/KT7rPK4W7Qvw17r825wwiUtwcp9v2frpaQtKEUa6V5ty639O5HDDAamiCDUsQFwMM7ehbCWhsWkF+hxjr3SPWyXY4IiA1mQBqeEJD3zgQKLsdtLOfKt50XLTk1yordp0pP0ugo9EFoxTqr2eGZUHz7kKSM4gJUj3AKEqiPpTruUU3++t+4jQLGojqF4MNaZLRyOAyB6Bw6uSAQqEqK9oUfJLKPJqVViTcvIlwDyTABNrwK1ND2cxiyBumifQRkfTLk+oV8PFKPlPbkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zaZ8aaBRDq/e5KvifEYfA4SZKzIXHCpWaoVw2/efsPY=;
 b=ROevsfTLrmgpgvG4rWq8w7rW1FKqqLL9tDuVK1owhHJmloHUaDP9fDA0L+WU9HNxc5XWCsKwy2u+GLLl7tZv/5rhXGKM0bwqcleIn/jWfBqj8Hv2kYhgOpADU1NZxgcueaVGi7OB7qpGObwy6zSvrPmdiSxPjMRBmBRhBVM1XVqlOeJKZN9T4MiJfXHJfISQqKmkTtWLZThV2LD/YbZ0ZemKB6rWvLbJTtsqfIl7vJCkQ5/5+TMtJbW5AlDgtiXFhu2g316jT46Mm0fUGS3GlXU3Gw5PceZmVbSMLBeVudgzd6mVek98t5Vl7qdOY4SQWueix6n2k83w7AKuzYvIGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB10805.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:f4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 25 Aug
 2025 18:14:50 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9052.021; Mon, 25 Aug 2025
 18:14:50 +0000
Message-ID: <53fe897d-030e-416d-822a-020bd82cc882@efficios.com>
Date: Mon, 25 Aug 2025 14:14:49 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V2 13/37] sched: Move MM CID related functions to sched.h
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
 <20250823161654.102905434@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250823161654.102905434@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0135.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::8) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB10805:EE_
X-MS-Office365-Filtering-Correlation-Id: 17d37660-6878-46c6-3513-08dde4034848
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cXh6MGtkcHpYVGJnM3QzNWJONGpsTzZMNVQxclFMNm1SbFJ2dy9INGlOUVpM?=
 =?utf-8?B?ZWFtQXNPbFE1RWlXTW9KMUp4MDNVaTdPQTNBaHhjbUh0TDR0UURMZDE0RTBi?=
 =?utf-8?B?TllGa1BXK1dnRWFRcXEycEhLbFVYYlo2bmNOdHU0Y1Z6bkVxWlZweWxUZ05O?=
 =?utf-8?B?NDkyT3Yyb3ZSeDFkdGdvV0p2eHBoQTFIOXVSbzg1Y2hrdEdpV0RHRWVjVDRI?=
 =?utf-8?B?Nk5OYmJTYmc4N1VMQ0wya25wUUZaamZ4bmZFVmVEYmQzbVpubTJKR2d3UkFt?=
 =?utf-8?B?Ti90ekhLUkx5VHdhQVR2OVZiVkxDVnh0Q2Mvb2g5N1Yza2ltMWQ1OWFSSHJN?=
 =?utf-8?B?T0M4ZGFjdDF6YWpzR2RFUS9uai9XN0pHc2VvbURHa056Rm02OTBMN2dDRVh1?=
 =?utf-8?B?UGpPUmxSa2ZlZCtxcHpyc2xCQS8zM1pyNTllK2dKUmxvLy9qaEw4VDFpV2ZP?=
 =?utf-8?B?TVdXQ0lGV0F0bzlwT2pMd2dzZ3RaUUg2U2VuWXFwTytrVHFFQ0Mya1FsZTJL?=
 =?utf-8?B?SUNVUHFWbCtYRE1oQk14ZjFkbnhucHhQSHhkYnJrWHQ0RXFpMjVvWUZJSFJ1?=
 =?utf-8?B?OTVsOHZjaExwcytnYjlHM0orbXZENXhuU3JZR3U1ajY2WmNaWTNPZzNseFBw?=
 =?utf-8?B?a2xMYU9ETEtCSEp1aTMyelhJRXUvdSs5NlNIRWNaNnc5S1FaSytJbGloWWFu?=
 =?utf-8?B?MkZjWlcrM2l4dUdSOXhHU0tYYVZmSXpjMVg0djVzZ1Y3RG01ZkxhV1VxNEJU?=
 =?utf-8?B?NW8ydndoQ3FacSs5SGNqWURXY1BHQVdERllwV0VmVm95SVpvQXk0Z3ZiZEdp?=
 =?utf-8?B?ZDBWb0Q2b3dYM29VVkxaZjYwd215Q0xrTTlsR3ROSC9HUDNSS0J1UDlTRHNF?=
 =?utf-8?B?bkk1YW1CWDhONStuNkJPMVB1RXYzYlZzTHZ5SkJIRjByaXV4endvTlhCVHdB?=
 =?utf-8?B?NXhmdVBtV1ZPZ3RxSm9yRFRER1ppcGhQUytBc0FrUjRaM0NFMWJjaHRQQWNa?=
 =?utf-8?B?MkNnV0xxV01jNTQrU2lpaUtYM3NUY1p2ZEM0WFdkOVZOalp3YUI5RFlib3N1?=
 =?utf-8?B?YUVEK0VseENkRWxuSThzdjBZUWdQN2E3LzlQa1IwdTVkSmJDOUJnOWNNS2VP?=
 =?utf-8?B?NFF4VDdpdVRvM3ZBYnZCK0ZQUjlRMFNzQXdBYzRkL2ZsZWZ0MUVyVFJudmly?=
 =?utf-8?B?bGxoejVLUi9oVU13MnI4aWpKVlpacHpNVjdzZWpHRlk0ZFhSNTdjMUNNM0wv?=
 =?utf-8?B?Mm1tcnBLTW8rV2JlQ2R1ejVEV1lNK1QwNGxhNUdmU3hNaVhlUjg5SWtnZnlG?=
 =?utf-8?B?NWRxcXcvclQyb05LRG1MMENqbmRYWm9CVWQyNThuR3JMWHR1RjNJUDEzcFly?=
 =?utf-8?B?VHd3TTBjekV4Uk5uczU0cE9jTFU0UDVzWExUdVhNNHlWR1gwU0JHT3MxRDQz?=
 =?utf-8?B?NkF3bnBlT2MzTlBtVEE1dHR0ODBMeFJMMGdPeGVVWEJZNVc3cy9xNUZldFJB?=
 =?utf-8?B?QWN3NXhma1pZb2JsSWVGMDV5N3RONFlGWk9DSGhKbVlpZSsyZGYvQ21wWG53?=
 =?utf-8?B?MXoxK0dqM1BkeklMRUgwb1NjRTErUXBHQWt4ZWc1bU5BY1dUTGRvOGVKbzR0?=
 =?utf-8?B?Wm5IRStiRWlxQ2J0cmkyRytSb3RQcFcvbHZHZ05ZY2U5YjBtcjdqZzdHN3g2?=
 =?utf-8?B?Y0ZIMUwxRCtqQzVkNEtpazE0NFJwNFZOc0sxWnhQZkNlVlZSVVZjT043OFlB?=
 =?utf-8?B?SUcxbmhjK0pqeVBUVnRIZ0VySVMvUGFRSUV4SWdtWnN3QXd0Z1Q2VkZUYVFk?=
 =?utf-8?Q?0+SWqtBD1Et6N8JWWnoqxUjdCi5YkTLzRCA6A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ekR4OXFLRXJmS0tRMjhyVHVkSDVtb3JTYlhPSzRHaUU5WllHd1JUMTlaQWpU?=
 =?utf-8?B?QUhUYkRJSDJ3VC9mdnJnU0ZsYzhBaGFwZG9PZ0JlZ1ZyMG14ZnN6RGNvVUtq?=
 =?utf-8?B?OXFFMGlKMUlsTjFWY2NmRXh4eTN3bWYrOFdVMmU3dnZ1ZnQ2SC9mNGw5V1NG?=
 =?utf-8?B?VUlvUkFLUkM0R0tTenA0VkplbmpMMzBhL3Y1M1NPUzRBOUlXaW4xVityWDli?=
 =?utf-8?B?bDZobVVIMDIrMGZCK3RPM3FQdkQ0R0pIU0NVcFhtMjVFZ2NzRkpMNXZtN1lE?=
 =?utf-8?B?OU10b2pGNmJCcFM5WVJESXJZYVgzNnNKSFZ6M2FyaVliV3hoSFBxNENGdmFZ?=
 =?utf-8?B?WFlqaFA5V3haWldUQWJ0ZEJPWGNsVW8zMDAvOGlrRmI1am5Lb2FkOGNCTzhH?=
 =?utf-8?B?NERRNHFYSXFUVG45Y01IQys2bU1yOEtwczJKUDVTRjllVE5PSGhxNlBUdCt5?=
 =?utf-8?B?MTA0ZW1NSkJza0VCVzdyY2NVVlBSZFRqWS9BeHIwM09tdXJ0RGdWRGtXQnF3?=
 =?utf-8?B?MmlYNzFtd2FFNU5IbDUzSzFCYXh5VWVrTFQ2aEdRSmptRTRWNlBXcW1scDBI?=
 =?utf-8?B?MDQ2UU1VWW9RVE55K0gzMkllNUtWN3NwN3g5Qm1IeGF2T0NuUGh1K2UyTThK?=
 =?utf-8?B?S25jLzBoNmFsbDBjR3Z5SmRqSUZqeHd4S0xpK0xYUnR1ZTBoY0lvU3drdk83?=
 =?utf-8?B?YnlRbGJxOXIwckZtWnZpNFgrQlBIVi9zTFJsWFk1aExqajNySmdPQjRwY1BT?=
 =?utf-8?B?MFFOTmZwc3FUS3ZrVXE2ekQvdGpDWFN6QUtuQ3NlSXBNaytjMUFjZ3Z6dkpp?=
 =?utf-8?B?U3BHTGMxdnR5UE9pYzQ3T0dPVXdjaXh3SHlMTU9XN1pBeVVndEMwYUdqcndw?=
 =?utf-8?B?ekd0Rm8raURPVG1EUlRiaXFrZUhXcXpDN1duZWJpSmNDeG5SQ1ZUZERETTcv?=
 =?utf-8?B?TXNURUp4ODFteFl2dGRKSzVuYWpOeXFvWjFQMnIwaVVwaEZzdDhYL1RCVHJZ?=
 =?utf-8?B?VFdLOE5hWENkaGI1U1BEeHQ4bmovZEcxMld5SGxBcDIweDJHZ1BsdklZaXhT?=
 =?utf-8?B?VXYvRDg1TnJ5OXBmVVpnRW44dnQrRzZJUXJ2dmlING5RWGhmZmhTRWcrbmFL?=
 =?utf-8?B?SXg1T0YrcVZDRHA1S1Z2QkZlcWN6N2NXZXRIdVk5VlZ2V0xhLzFLMlphTkE0?=
 =?utf-8?B?dlVsV2lORlRrSzBSNDQrbjJGWFlUaGU0VHgvamRDajdjOFloOFlFTGxac0tx?=
 =?utf-8?B?ZlRoRFN3cHpXei9QN1pYVGNheWxKTkExTWNudFRYQmt5MVk2NkcvTmhTRWE1?=
 =?utf-8?B?U21xK3VoeUx5OU9pWHM4UDNjTXRiYkpVaW5ibldIblVic3BheHRIVmx4Nzkv?=
 =?utf-8?B?b21tK2VJS2Q4eGNlcjQ0ampiRHYxTmJONXNnUWl0czdHN0JveGhVNzQ1REg2?=
 =?utf-8?B?Ynk1NmVTQURIYkt6dEtxb1U4T3FEbE1uNzVXeEFrYjRPTjJXVHpYN3ovZHFa?=
 =?utf-8?B?amZkVWpFcXFRbFVHUDNzNTFCenB4QVBRVWlNVS83TWlOSnpTTHJGeDh2M3Jl?=
 =?utf-8?B?cmJIMU1KN1dQZHdsTWdReE5nTVJlSVNtU2hKekV0VlQxYWdaSzVybHQxcFAy?=
 =?utf-8?B?M1JTYmhPb2ZBRVZQRWk5cnBmdk0wemtUanNGS01iTWc1d3JIL1lGT3hWTFdH?=
 =?utf-8?B?bzJtZk44aWx5YlRuS0RCYURGVTl1bC9UUndxSDI3U0JIV0tmRzluNlBOUzA5?=
 =?utf-8?B?RlZqRFRKUUJabitXaWFpK2FmcEpjV01SU2twdGttcjhtVGpPeWI0eTVQMXZk?=
 =?utf-8?B?YU9GOEFzZC9VTGdybHNnM2YzTVdCODg3K3NMd3g4Z016SmwxS2Zka1JsaDJn?=
 =?utf-8?B?M0xEV2p5N0ZXOE52TGttYmxlcGYyYUVBaHBhcnQ4R2dOR1BWVDB2M2R5V3FY?=
 =?utf-8?B?QmE2bGtMSCtEWWdoeGxtNGoySnh0R2VSbzVOOEZScXJnQVYyVHU3akoyWnRm?=
 =?utf-8?B?b3hDazNlbU5CYnIxcDNDN0VGWTVOWDkyWENCR1NoNDBTL21LY1ZSNUlHNElw?=
 =?utf-8?B?bEVkbEFIY2tsVkRXZGtqVkxxMzJJd0hBTlZRVG1lcUpINjBBc0Z4QUliRGtN?=
 =?utf-8?B?N2FZbmNyb0ZiU091eFdJbGtZNnBSNzJDQXNRUkloUjg1eWJvcWpKRmZWYkxQ?=
 =?utf-8?Q?iUijp3XI3Zi2lGtXjZp55UE=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17d37660-6878-46c6-3513-08dde4034848
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 18:14:50.7449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jClQd4Ict30gvKOen9cL0hDkQf/t4yWMtmjuXo/bOFy67nxhobh2JtXhY2s8GwD3W4h7zk87bxxJ//ejElEBGxHz4Ij+RJ3CCEgmK5zF6ys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB10805

On 2025-08-23 12:39, Thomas Gleixner wrote:
> There is nothing mm specific in that and including mm.h can cause header
> recursion hell.

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   include/linux/mm.h    |   25 -------------------------
>   include/linux/sched.h |   26 ++++++++++++++++++++++++++
>   2 files changed, 26 insertions(+), 25 deletions(-)
> 
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2310,31 +2310,6 @@ struct zap_details {
>   /* Set in unmap_vmas() to indicate a final unmap call.  Only used by hugetlb */
>   #define  ZAP_FLAG_UNMAP              ((__force zap_flags_t) BIT(1))
>   
> -#ifdef CONFIG_SCHED_MM_CID
> -void sched_mm_cid_before_execve(struct task_struct *t);
> -void sched_mm_cid_after_execve(struct task_struct *t);
> -void sched_mm_cid_fork(struct task_struct *t);
> -void sched_mm_cid_exit_signals(struct task_struct *t);
> -static inline int task_mm_cid(struct task_struct *t)
> -{
> -	return t->mm_cid;
> -}
> -#else
> -static inline void sched_mm_cid_before_execve(struct task_struct *t) { }
> -static inline void sched_mm_cid_after_execve(struct task_struct *t) { }
> -static inline void sched_mm_cid_fork(struct task_struct *t) { }
> -static inline void sched_mm_cid_exit_signals(struct task_struct *t) { }
> -static inline int task_mm_cid(struct task_struct *t)
> -{
> -	/*
> -	 * Use the processor id as a fall-back when the mm cid feature is
> -	 * disabled. This provides functional per-cpu data structure accesses
> -	 * in user-space, althrough it won't provide the memory usage benefits.
> -	 */
> -	return raw_smp_processor_id();
> -}
> -#endif
> -
>   #ifdef CONFIG_MMU
>   extern bool can_do_mlock(void);
>   #else
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -2309,4 +2309,30 @@ static __always_inline void alloc_tag_re
>   #define alloc_tag_restore(_tag, _old)		do {} while (0)
>   #endif
>   
> +/* Avoids recursive inclusion hell */
> +#ifdef CONFIG_SCHED_MM_CID
> +void sched_mm_cid_before_execve(struct task_struct *t);
> +void sched_mm_cid_after_execve(struct task_struct *t);
> +void sched_mm_cid_fork(struct task_struct *t);
> +void sched_mm_cid_exit_signals(struct task_struct *t);
> +static inline int task_mm_cid(struct task_struct *t)
> +{
> +	return t->mm_cid;
> +}
> +#else
> +static inline void sched_mm_cid_before_execve(struct task_struct *t) { }
> +static inline void sched_mm_cid_after_execve(struct task_struct *t) { }
> +static inline void sched_mm_cid_fork(struct task_struct *t) { }
> +static inline void sched_mm_cid_exit_signals(struct task_struct *t) { }
> +static inline int task_mm_cid(struct task_struct *t)
> +{
> +	/*
> +	 * Use the processor id as a fall-back when the mm cid feature is
> +	 * disabled. This provides functional per-cpu data structure accesses
> +	 * in user-space, althrough it won't provide the memory usage benefits.
> +	 */
> +	return task_cpu(t);
> +}
> +#endif
> +
>   #endif
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

