Return-Path: <linux-kernel+bounces-786891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CC7B36D7E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 17:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EA4D17E74F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 15:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED85A1EDA09;
	Tue, 26 Aug 2025 15:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="KAh0FH7I"
Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2115.outbound.protection.outlook.com [40.107.115.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C83262FDC
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 15:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.115.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756221176; cv=fail; b=oo4GYI3spAYCHEcsfYIR69+Mj/8diQvRFSJAVc2uN2CfQq82arKLxnAn7ggIF0rp34GP9/TsBjUo8lv2/cnu6J8MPRd6rsI+IVwjXXZSZliVuXrgnnBH6pbfPRtHnEFR5+8kBnmHCGqBrQf4WE7+faLeEb0bReEUjQWDeqmcXdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756221176; c=relaxed/simple;
	bh=w29m1WTxAwCYBUW6ANJHlgc2WvVYKKRyUORW9tQVFjg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=coc1BXAhyQvaoPhvFZthd7UrA68P2SIWx4IUEp4FBIE/XaX8TebI5OScSUIRfrnkMEKkAt/Zv1dJYzIfwqToqOoKCMMaJgmf9cMLD8KjWiPG8HgPd0C3/1FM6mH0+1RI9P6sdlVwIc121r2gQwsdFsQOL3RCZRo2VQy4WK+UkHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=KAh0FH7I; arc=fail smtp.client-ip=40.107.115.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dXlzyJNsPpxwMUTanQuR1uNrQNDcwg6l+FJI0ezo7dUAnmfH6+A4bcNTBjxcdZrHYEg46/t/LrFeU1sEmvN6djyly0eYQa8vyyeMF+8KjQA+dPN7jS8QVEd+Er0JDK97Nciefc5MqGqtuHWnLlEGqsmHKS1fkK0BV+zhYKNMnQT7XTTnl5iE2mxSNxCBnKeZnPsb4WqdH8ptBpzL2K7WKzGJchci8UWuBsopce45l3y0oztEetu81BiMcnZiOZhRtl+7+opiHSD7VsBP1a+p+U1X2VSi4ajTYsx3F6/0l4i+ibYEABgg6VjB5f3WXjhp9JbsvUXgA5nTq5tutlah0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pV+TPI4hhFKsNzoZSaFhdTmkyKkyORQmL92t1LUlPdU=;
 b=qwXZD4RSHOQ4SMGsTnDSnPzp79CniqO6eEibAr0xmZa+VIs1EZpoo2zYdINmg691OK4r3gIjlsyW3mI+tQoQe+JLigOB8uwk6tSs4XZ5ISaYSPa9VBsUHMgaNHmh/cpxAiIkAnwh0U+t5gc/bp5GbVyB0Q7Fic65Q5iToM8uzuL8yR6GRxliTqgHVQDQBGCxk+J++OJoCffu4DcEyjZxoWqHCYeg6b+sP0Yk4WUDQdqO7Q//8NlXNKAnARdjV6YU22HXcvqdogOFWK+U8ZXHHy2spSeX5tDoMdVugtYIZYdfnZTYRrdipxDcmcS2Qc1oCFkQRqw6vDbiioCkNpIxLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pV+TPI4hhFKsNzoZSaFhdTmkyKkyORQmL92t1LUlPdU=;
 b=KAh0FH7I6/jSRe0LuiEDM/PwFEKmYSY4IO6gZemwxhEMmb2IZAGmWC3wY40w6BeoLIeMvjqL7THjpfQnbNf1KGbrOuWemkpEumsSfGFfO/c/lJ6mGN5weSfRy1L4+hAR7Lp/Mq0EY1+d1RmAlHTytoZN2EeqPyibDOhPUCdPMYdunsxpvakm0I8FPBCeFzS83QBxn3bKDn2sFKLJo30P04oZaqwzhBrTJmhzFFZDC/CNe5PZl8utXYxXiFn2WcRKXeJwwaFOC3QNRDQWcQxQU8XvpxxutYmjymKku+ZHDdeTOomgu5ZKfM8i/+GhbryOwfx94qef4NFmuzeBbYA8jA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT4PR01MB9880.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:e2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.22; Tue, 26 Aug
 2025 15:12:50 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9052.021; Tue, 26 Aug 2025
 15:12:50 +0000
Message-ID: <0610d1be-15b4-40a6-8bec-307e62f810bb@efficios.com>
Date: Tue, 26 Aug 2025 11:12:48 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V2 25/37] rseq: Rework the TIF_NOTIFY handler
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
 <20250823161654.869197102@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250823161654.869197102@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0303.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::14) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT4PR01MB9880:EE_
X-MS-Office365-Filtering-Correlation-Id: db74231c-9010-4e43-ce5f-08dde4b305b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cE8zbGRwcEFYbU9WRnVTRHBZdCtXTnBUZWFLQlJCMms4VUlEVFdQQXVFUXpn?=
 =?utf-8?B?YXAxcUVPL1VuU1F0ZVlVbmZuZDFGbzBqT2RGYWRhVkFrTFg2ZFlDd1l0UHdC?=
 =?utf-8?B?S2dnbk1GS0JzOW5lRC9laFBmK2p1NTY3SlFlQ3YwU0FWZ0E4VG5yNldSbEJU?=
 =?utf-8?B?aTk4Y3RwSmdtUmNPYW1uTkJLRThsM1hpUUNBQmJIOXNRTk5HazNqRi85K1NQ?=
 =?utf-8?B?RGV5aUJDelc4c3JmdEFSZHBQY0FlNWhUblhvNW5JZXhjZVpEaXFJYWkySkx4?=
 =?utf-8?B?MnJ2UzNENHd3UTY4YVhhTWVJYzRBczJkNGJZWTlxbXFMcmdFWUhSUDBPVFQ2?=
 =?utf-8?B?WTQyeUpDZjNRTzk2K0FKY0lQRmpqWGI5Zldtc1BCZFhuUlpUSFZpSVhMaXNk?=
 =?utf-8?B?L3Uvd0g2V3Nkd2Zidi9qellRWnRPN3diNE8yWjRaOXN1VEVlRjlROU0zQzZj?=
 =?utf-8?B?dkx3b01EdnJIbzYwZWdkK0FranJMWnJKa3E2Z3kra0p4ZDFZZC9wT0NqTStU?=
 =?utf-8?B?ZzVBRlJrYlhIV3NUYUFJZE9tQXFYNmVqVXB5ZXQxZXp5b1NzSEpGb1ZTYUp6?=
 =?utf-8?B?QWRRZFYzdkwzV1d6Nzlza0VHQ2U5L0w3eHBscU9TQWJob01makZaVFRBT0pp?=
 =?utf-8?B?d0lRaWRsdHR6MmU5VC9Ldm1QTHpNWXh2MVRFOVh5Rm9qK3UvZytac29BOVNL?=
 =?utf-8?B?QmxQdFFSZERIZElzOFp1YWs0VTlHdUhEOEkxaVIyR0VKK0NNOUdsVWxMTTdD?=
 =?utf-8?B?NDFwdzN6VWNGVWc4SlJ2M0pqSzNGMXprN2RaOTREc0dtaFV5ODVyS2hySURh?=
 =?utf-8?B?ZkdYdlhNa1lrVlB0M1piUGR3WGdHMk1FMzZyZzlQeWhWNDFxSmY2QzhGWk5C?=
 =?utf-8?B?REJpZFZWRVdiRDZ5L29NKzUzdW1FM1VkYUNORVk4VXNucCsyNmlMNndHM3RK?=
 =?utf-8?B?VGk2TlRuaVhkQXFLMlNLeUpjb0JvQ29JaFZkS2R3RTB6VlEyUU5Wb2d1dkZV?=
 =?utf-8?B?ajFiOGU5MEpwNUdqbFFGU1VadjhVLzBNTm03QXIrM24yeWYzREdCY0VZZW1H?=
 =?utf-8?B?TTVESWlEYVVZeVpRNG82eTJpNFdXTm1YcWxQU0Q4VGVhWENGU1hEMDVicmQ0?=
 =?utf-8?B?amdjZkRFc3NzRENNUDNQL3RvTCtNa1RkZXcydklFTFA5RzI2V2Z4WTRRSTNv?=
 =?utf-8?B?a1VDQjlIT0FZVEZHdzhQMWFvYzBWWlY3M25iYUFiVy9zcFVHVzVxVEZoZ05V?=
 =?utf-8?B?dnI0aTZXcFhLTlZmWW1iZHVvWkhyNGg0blU2YjA2Y2N6aitnN05uSXBBNmpQ?=
 =?utf-8?B?YmZad1llM3EvaTUwRU5EOWV6S3N3d1pVdGVqOXdjU0pnWWc3MGxWaTNtbXBv?=
 =?utf-8?B?Wk1TTDlWaXNXWTUzcVlRWWFYejFVNkFSa1JzV1U3eE11NCtGY3ZpckQ3ZGNG?=
 =?utf-8?B?U3ZIbXd6Z0dUM3NiUmtuY3IwK3Z2b3pjK2xxWG82QXlNdXVwVXNFUVBpT3FM?=
 =?utf-8?B?WU1WaEI4Mk9UTFc4U25yejJ5d2g2UURDQ1h6Y3RvVWxtc0g4aHpVYkorUVZr?=
 =?utf-8?B?cEEwalRpZ3k1d3pTRWtWWXkwMS9YbVFoMG4vdGI1dDJVUWIwUmRFT216cEV5?=
 =?utf-8?B?RVdRSnJmc2pqbzhRWTdsTHZxS3hvVGJGQlBUOC84eGZaTlpVY09RL0hpOElo?=
 =?utf-8?B?bVlSTEZmZXhSUnhCOWhpR2tyMWQ3MzMzc1Z0R0lxMTVTanE3dldpSFNQdk01?=
 =?utf-8?B?SktLdTJ0TkV0eU5rUVNsaHJnRTRUc05wTkd2RWlsOGhaTWNwdDlGcnRvcU1s?=
 =?utf-8?Q?yeAIZS3E4uT4CzUphSNfwl7aOSnlPywina0RA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RjQvZEk1ODV5SlhsM3JXdkUvdCticXRxalpheTNsR1g3ZnB2V1lQQWp5a1ps?=
 =?utf-8?B?eFg1UFdtUG5BZ3VQdURyZFFaT3RRYTNWbXRoVXdpZFZJYUszeXFaSW5DTm9B?=
 =?utf-8?B?TmdvWXJ6N1RjWjZXN29iMFVZcld6NVl2cXExcTFVTkQ0VEx3UWFiQk9uY1hZ?=
 =?utf-8?B?Ujl4TjkrbHdpR0FnM0RGS1BvVVFYYjd1U0VCZVV3QUw5b0R0YnJtL0VLM2pH?=
 =?utf-8?B?R3R4Uncrb1NBbnFCSGcrTjFIM3JRRS8vaXJrZkdxTTBDYmZQakFxOG5hRDRm?=
 =?utf-8?B?U1lLWFdIU3llb05VNXFyem9UMVBJQngycDlwWGh1Z0VqWjFlZXB0Z3FKa0JV?=
 =?utf-8?B?Z2EzTGFXZ0R5SjhvZ050THVudkp0LzBJc1NXY1dEa0I3djdvSEtJVVYzcmMr?=
 =?utf-8?B?MW5lYytWS2RnNkp2MEJxYXVUdytrVk9WM3RsSkthMVZJRENtTmVFK09adGcy?=
 =?utf-8?B?Sms2WHExVVJlcnNBcDgxc3NMWlB3OFpSelVXbEw0YnZJazdSSVFZR1l3UkQx?=
 =?utf-8?B?bUZFZ0VtS2FkbDhRejZLQ0ZXUFhIK2JJaEtoU1FQd24rWDRqalk4dENQS0R4?=
 =?utf-8?B?VWZwbjhQamVFaE9rSG83ZmFpdnlRb3RDcVYzdFBxdFA2YzdYOGxzUEZpVGhu?=
 =?utf-8?B?VWlJNEhpVGd3M2RWWGRUdDIycGNKU3VJZXJONUZhczZob1BydFMwbnBBWnNL?=
 =?utf-8?B?SGZtVlhxcXhwSDlpaVpuK3lySnBQSUNWaEdhREl0Vm5DLzE1NFA0dGpSOFJ0?=
 =?utf-8?B?MXczUTBPVTdMeGNvS2JJZFFUdTJ0blk5MGZYMHNNcnpPMW5MeTU2WGZkQ3dL?=
 =?utf-8?B?aGg3TVlsQmZQZVB6OGpVYTcyZDV5NmFNM0hkZlEvY2VkZlBEYkt1TUZ4czUr?=
 =?utf-8?B?S3AvcXZ4bmR4WWdSZk9ldlpiRmdBR3NwSlloY3hOSHlqZXc2TDFLUzFoQnhM?=
 =?utf-8?B?UTRIOEtDUjd3Z3JNU3R4aXcrUmZnWnpFN1A4S0M4V3FnTzR3WE8xOTBiMXQz?=
 =?utf-8?B?eDVCdEF2cDN1M29wdHYva1U5S1JFU2JoVE9ZMWpEYm12M2lvSmt1WXVqdG0z?=
 =?utf-8?B?c2IzendLWWMrQTVQRERqd2hXTDdaZ0R3TXE5MURaV01EU0ZlRElxRi9kdlF1?=
 =?utf-8?B?dUF1TDc5WmYxS1JselJNVDIwd040NjY2V0l6TDRBS3l4eGZ1dFhiR3FqUVVF?=
 =?utf-8?B?emdPWFZtWHAxeGFLNzRJWUZGcmpGVVV0WVUxRys4TXJudnJyalp4OHp3d0dq?=
 =?utf-8?B?ZmpuUThHUFBEYW5yTGlxWVJSZTYwMk13Nk96NXdzZGF3T0thQ0dnTEEzVUhk?=
 =?utf-8?B?aXhXakRxNWRGTk1uZ3N6WHA2NnR2c1pxdWoxMHVTMnhCaDduQ2l4cERSeFBN?=
 =?utf-8?B?anRyQlYvZWQza1VtREcrcjJ6MHQzM05TTE5EY1lMKzVITWg2bUNUS2tnUWpQ?=
 =?utf-8?B?KzkrcDYvVHZyNEN5Ym9yTVBTNUdSYk1QT0hJVldoR1ZUWG1BNEUvRERmVW5P?=
 =?utf-8?B?MExac0ZmOSs1TG5HT2hHLzZvcy9RcXNieWR2Q0k2R2pIYjJlb0JUTGpQckRK?=
 =?utf-8?B?cldSRm5MZVdsYlFES3F1ZjErbnBoU0tSQ25SRElCa0s1VUc0SjVDandFTzU3?=
 =?utf-8?B?NURTdmNZMUxHZVIzV0tCQ1Z4WVVmZnZmQmdlV1pFMmZhbkRsNDhrelVzQ2pp?=
 =?utf-8?B?RFhGaE94VjFVcU94cVc0M3dxQjEyWHlIZ0NQdjMrOTZZQ0h5REczWVJRMFYz?=
 =?utf-8?B?VnpOUTNvVTRNYk96bWU3djdiNjlpUkprSzNOT1FwNCtkQjEzWUZ6Mkswa0Vt?=
 =?utf-8?B?N2NDa3IrU0FuM3phRWdDdFJnQTgwRE9EWUQ2aFhqZmZ1STU2VlpVbTYraklr?=
 =?utf-8?B?NWVuUzlBRFY2eklpWWZMdFl6OHc5NzJ0WG9rK0MzaVgxM2xyMm1nN2o2Ry9F?=
 =?utf-8?B?NFNLNzlTMk9Pa3U1OWlLMUNLcWJIUXpmZEo5TVZiMndSRGFuTVRlbmxrSlJn?=
 =?utf-8?B?OEdtTkE4TjZEYVJaOE1DRHMwT3Q3ZzFWTlp0VXduZjhvWDBpRTBIMU1RQnBa?=
 =?utf-8?B?cENVUXFBeHE0dlYwQ2tMN0FCQkVBTzZ3UGRmdVAway9mL21DRFlRck5OK1lN?=
 =?utf-8?B?Snh0YS9EME1ZUzV3ZzN5NjVlQjNBR1FDUTZHWHdzeFlpYzRTNmFxY3pvaFpM?=
 =?utf-8?Q?hvs0XKlj1te4nC3psbUBXq0=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db74231c-9010-4e43-ce5f-08dde4b305b5
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 15:12:50.4819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MZbibv8gIZLoJndmIelnX/J6nZSpEzOeXEhagbuJv1s9FlPE1Xp1JE8AromSk2KbwwjgbVjVY7q/8NR6bGL6W4RdVi3Uqo9VWqa/GxHER7E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT4PR01MB9880

On 2025-08-23 12:40, Thomas Gleixner wrote:
> Replace the whole logic with the new implementation, which is shared with
> signal delivery and the upcoming exit fast path.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   kernel/rseq.c |   78 +++++++++++++++++++++++++---------------------------------
>   1 file changed, 34 insertions(+), 44 deletions(-)
> 
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -82,12 +82,6 @@
>   #define CREATE_TRACE_POINTS
>   #include <trace/events/rseq.h>
>   
> -#ifdef CONFIG_MEMBARRIER
> -# define RSEQ_EVENT_GUARD	irq
> -#else
> -# define RSEQ_EVENT_GUARD	preempt
> -#endif
> -
>   DEFINE_STATIC_KEY_MAYBE(CONFIG_RSEQ_DEBUG_DEFAULT_ENABLE, rseq_debug_enabled);
>   
>   static inline void rseq_control_debug(bool on)
> @@ -236,38 +230,15 @@ static bool rseq_handle_cs(struct task_s
>   	return rseq_update_user_cs(t, regs, csaddr);
>   }
>   
> -/*
> - * This resume handler must always be executed between any of:
> - * - preemption,
> - * - signal delivery,
> - * and return to user-space.
> - *
> - * This is how we can ensure that the entire rseq critical section
> - * will issue the commit instruction only if executed atomically with
> - * respect to other threads scheduled on the same CPU, and with respect
> - * to signal handlers.
> - */
> -void __rseq_handle_notify_resume(struct pt_regs *regs)
> +static void rseq_slowpath_update_usr(struct pt_regs *regs)
>   {
> +	/* Preserve rseq state and user_irq state for exit to user */
> +	const struct rseq_event evt_mask = { .has_rseq = true, .user_irq = true, };
>   	struct task_struct *t = current;
>   	struct rseq_ids ids;
>   	u32 node_id;
>   	bool event;
>   
> -	/*
> -	 * If invoked from hypervisors before entering the guest via
> -	 * resume_user_mode_work(), then @regs is a NULL pointer.
> -	 *
> -	 * resume_user_mode_work() clears TIF_NOTIFY_RESUME and re-raises
> -	 * it before returning from the ioctl() to user space when
> -	 * rseq_event.sched_switch is set.
> -	 *
> -	 * So it's safe to ignore here instead of pointlessly updating it
> -	 * in the vcpu_run() loop.
> -	 */
> -	if (!regs)
> -		return;
> -
>   	if (unlikely(t->flags & PF_EXITING))
>   		return;
>   
> @@ -291,26 +262,45 @@ void __rseq_handle_notify_resume(struct
>   	 * with the result handed in to allow the detection of
>   	 * inconsistencies.
>   	 */
> -	scoped_guard(RSEQ_EVENT_GUARD) {
> -		event = t->rseq_event.sched_switch;
> -		t->rseq_event.sched_switch = false;
> +	scoped_guard(irq) {
>   		ids.cpu_id = task_cpu(t);
>   		ids.mm_cid = task_mm_cid(t);
> +		event = t->rseq_event.sched_switch;
> +		t->rseq_event.all &= evt_mask.all;
>   	}
>   
> -	if (!IS_ENABLED(CONFIG_DEBUG_RSEQ) && !event)
> +	if (!event)
>   		return;
>   
> -	if (!rseq_handle_cs(t, regs))
> -		goto error;
> -
>   	node_id = cpu_to_node(ids.cpu_id);
> -	if (!rseq_set_uids(t, &ids, node_id))
> -		goto error;
> -	return;
>   
> -error:
> -	force_sig(SIGSEGV);
> +	if (unlikely(!rseq_update_usr(t, regs, &ids, node_id))) {
> +		/*
> +		 * Clear the errors just in case this might survive magically, but
> +		 * leave the rest intact.
> +		 */
> +		t->rseq_event.error = 0;
> +		force_sig(SIGSEGV);
> +	}
> +}
> +
> +void __rseq_handle_notify_resume(struct pt_regs *regs)
> +{
> +	/*
> +	 * If invoked from hypervisors before entering the guest via
> +	 * resume_user_mode_work(), then @regs is a NULL pointer.
> +	 *
> +	 * resume_user_mode_work() clears TIF_NOTIFY_RESUME and re-raises
> +	 * it before returning from the ioctl() to user space when
> +	 * rseq_event.sched_switch is set.
> +	 *
> +	 * So it's safe to ignore here instead of pointlessly updating it
> +	 * in the vcpu_run() loop.

I don't think any virt user should expect the userspace fields to be
updated on the host process while running in guest mode, but it's good
to clarify that we intend to change this user-visible behavior within
this series, to spare any unwelcome surprise.

Other than that:

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Thanks,

Mathieu

> +	 */
> +	if (!regs)
> +		return;
> +
> +	rseq_slowpath_update_usr(regs);
>   }
>   
>   void __rseq_signal_deliver(int sig, struct pt_regs *regs)
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

