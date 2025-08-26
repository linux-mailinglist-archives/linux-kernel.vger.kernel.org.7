Return-Path: <linux-kernel+bounces-786795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E71B36A3D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 16:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FBEE581E64
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 14:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9E535208B;
	Tue, 26 Aug 2025 14:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="SMoh/1y/"
Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2104.outbound.protection.outlook.com [40.107.115.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD3D352084
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 14:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.115.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756218208; cv=fail; b=pKvtVZmiaxZXB9O4Vfh9mcGt0MkLP0ihDTnPTyinesflkknoxpq3JMVi2wtUpqnu1nh/rQTmuEwF0ppbOrgim8S4FHdT4Z08ixQ1xAt/wa41D8msi+G9HnzuuYgUdIjbrs8a/XxQV/5P+alWHdRSFbbs4ABFfZGPTVJlIAck+GI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756218208; c=relaxed/simple;
	bh=WexRTH1zX66sYHc9rYs1SUVCBpJxZ+pq6p/+9nUjWm0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H9B0JNJOLTnEb4VoyRMpO22PMBWMjdkx416Y3trBCj6h7cYF68m2HCB4/RY2KgkMqBr3Gi+rzPu8uzS/eD8IqRITkq2X1boQwsqNw9P/kQ1fgbyF5Qx1W47SGu6C1LUKcrrtJgdYxdr8Slj6OSb1PMR7IYXECSB2aztnuXNgcXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=SMoh/1y/; arc=fail smtp.client-ip=40.107.115.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KJ5hfeNWzBuiFdzM5gT/9q6xKY6l+Hto7Jnn8XQonWAXkLYNwXF6YZD9uy9se4E45xqhIxpCuh8oyozRzPT2tdYwK+yrzEWoyIu7BVDv8ehlOJB0QGkFe87u0MSIVnEVGcbovdUoNaAluBcnQ5VXHxXsqEdFP1Q9bSSjXM4tAYwlRrjP9XjUjolsRacpJNc+aWnOMWqg7UGf7XaTb21UGAWzuNrwS5te4w06Km45R7/h2SBvkMqN/Om0mubgft0K+7rx1LJkHLFWLCI4KV+U75cboS0Lr8Vzq/PFxo4feTS+me0IcS5X2/UPLlRD6igePGLZFbcc5yBlKwiulFLLbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u0fuxnZKfYv/tLRS2gKcwm5gl76kwfYlfvTLAwVaTjw=;
 b=iDaugCxE6n0/oLwj84sMY2aRQsPvhMOuKT/XB0OCa76Z1GxkNIFJBgoicUUdeb5Xf8WxCkZneQLCAjFym8UC6YCtuDUdu2yIM4spts0PaQ7E5z+OClbeTtkwiM4d47ELwzoah/z+m73FjTF6osdrS6ALWwarYlYLmTB5bjZLblzae7oVHE2oUYkknzarZGhCv2qnc/exBvmpu8Dp6mIE3GNbrGNBWfVLfj9EwQGNu46Z9hHAl7YI2Rc/UdxIHw3c/++ZFaTma0o+xf2qAIRs4GeeUY8Ez1vmDmjCb2RT8lQm/tjVWASpVqJ8bQ4Z2cXjQFKzg9+pJBu2Rfy/BkrgzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u0fuxnZKfYv/tLRS2gKcwm5gl76kwfYlfvTLAwVaTjw=;
 b=SMoh/1y/Bqy3hDpfmqHFvW0CL3+X1jwNnQpYjUMGVMK14dleioc8nZHINOlif1sruzUPd+NdlxF3AlhsL8k2TEd7VT/hW4Gj2yQeIZ3B+LLNGfUxRV+k7/S/2F2BcgzYWropRctX7qIjKfFFz89nS5Q8FTZpRIbsp5XnSlRxQRsIp925mniUPw3JefEspEJq+GVdXJEZFTmDadxLtiRaVaiassFPEMGx6EfkpkGPqg0iXjRpI4qw5ajcIlk1OaYpYbVYRh0TJ3juvYWJhi2O6FcIJmhwKhV23+4xBwIciPKTBHwEHlb01kXlQCQWpc1oXCTTbinSgEGvWo+bGzdPHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT1PPF63C40F8D3.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b08::543) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 14:23:23 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9052.021; Tue, 26 Aug 2025
 14:23:23 +0000
Message-ID: <4cb4a688-7c81-4d52-ad38-9d93cbfec1ef@efficios.com>
Date: Tue, 26 Aug 2025 10:23:21 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V2 21/37] rseq: Make exit debugging static branch based
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
 <20250823161654.612526581@linutronix.de>
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20250823161654.612526581@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0280.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::29) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT1PPF63C40F8D3:EE_
X-MS-Office365-Filtering-Correlation-Id: 54eca9ea-988c-43cf-ab1f-08dde4ac1d0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UGlDcy9YUUd4VE5nVTZnbUJaUGVSdXVCZnlQZGI0eVhxZnUrZGZmR3FDaHdV?=
 =?utf-8?B?QVJHcWNJYzJ2RUxLSFlEaEVtMTM2T2FqZjJzRGQ1cWNnNHFLY0FxVFQ2ZGtW?=
 =?utf-8?B?djU5VWlBb0thY2l1VGVrWW5ONTh2S3VWWlJ4UzBid3VNQURUMVdZUkQ1VlZF?=
 =?utf-8?B?TzMxZzJ2dWgxREQ5YnlGK2JJZmpac1JyS1NrdU83eWpLNW82dm5lckhxclhH?=
 =?utf-8?B?ZHAyd0FpK3RVWHNXMjhjdmVqT0VSck5KV3VQQUJTUHJmOEMyVjF6blV3RExM?=
 =?utf-8?B?a2RqVXB2M3kvVDYyMkpNbE1ieWVIRXJxQTlmZGlmMmRleHZYWTQ2S0dOTW5X?=
 =?utf-8?B?b1F6WjdjZU1jeU5tamZZTUtRU2NTajFwOXFyUm9OSU93UitueXRSa24wTDNM?=
 =?utf-8?B?YmFvb1UyU3BMRENyZ0w5eUk0dWNHNHA3UXMvbXFXaURYOGR0NjRFZFRCY2tL?=
 =?utf-8?B?dHdMd3laT0oxdFRzR3FxeWF6ZUI1QVZIL2RWcFRSaFRTL2YvaGtSNXhiSlN4?=
 =?utf-8?B?bDIwL3YzanBUM0dhT3hWZGNVSkI5OU9jMGhrT0I1QW5zK0NFNll4T2YwOFdU?=
 =?utf-8?B?RXZVVlJ5ZG81N2FRMGdZR0tGR25MNDcvYVN6TUJOUDNYY1Jna2xtM3pnMDhp?=
 =?utf-8?B?b3MyQWU0dmd2ODJoK0V2R0FhbGFuUUlSaHAzRmZXZUMxeG5SUFpoaEhPOHVV?=
 =?utf-8?B?ZUpYZEF6Z1FENWRXclNJcnozNWpCd0g0WTJleUFlRTF6N0NaZzludlVzM0xS?=
 =?utf-8?B?R0p4YnE2c2E1QllScU5mZFd6SEJQZ0Jjd2t2OG5XdUxRSVoyUytnWVdHZDV1?=
 =?utf-8?B?QjIrT0M2VURFUWcrYjBLMVFNMjNsZitIY0Z6MHZKL1d2aDFmWUxWS3cwOWRl?=
 =?utf-8?B?cExzclJRcjE3VlNURXVoalVWb0h4M3pZNCtQVzRLNEV5QWtzMlBIVjRwamcy?=
 =?utf-8?B?ejdUUkN6ZWFRNnpEL0dhWWRDZWxySjY3aGJnT0NFdU1vWlJCdDhYTlVDMXhY?=
 =?utf-8?B?TnFlQVdMeThxRHBQZ2hsMlFjcHcxZm1MQ3dPc1dwdkJ5RUxZc3VMRzZpbmZW?=
 =?utf-8?B?YUc1U251eDZSZGsrREYycXVGM3JmT0VuK2hqYThvQ3k1K3kyMm1hZjYzcHRN?=
 =?utf-8?B?aVFwTmIvbm1ZL2xxSVZXU2cvcVoydmdwMU5XR2h2TFZSRmdUdHJkdm1yUSsw?=
 =?utf-8?B?WU9aUEFaRFlNY25vRXlxUitpdmpCYlBMQnNJY29RRUdzQXdRZkNoQlkwcUFs?=
 =?utf-8?B?dFF5ODFkRktFK3NJakxrUFBVZ1VRUGJjQkQxK2ZoTnpwTmRKQjFuZW0rTUla?=
 =?utf-8?B?eGRtRGVUSjliVzNWMktHWDhpSlFXRE9kbVRCNlVWVDh5L0VqNXlFczdRRDRp?=
 =?utf-8?B?M0NBcG4rckU4b1dlbXhCVUFwdlBYNnp5M1BTRGp4cDgvVkNkVWkrZE9kd3Jv?=
 =?utf-8?B?M1N5cThMazhtOEc2WS9zY0JDMFNPVHhra3dnaXR0ZnBPa3JyZkZPVDI0MTJR?=
 =?utf-8?B?R1Z4WXVkMTRBQ0hXSmNJSnhxWEU4dFRtbUdFdUp5YnlHUHNOSDh1bm1xT2dK?=
 =?utf-8?B?MHkzZHNwWjkra0lYN1FqWDBMSmVNdlk0dnVpenU0TVdyTGlkeEN0MzQ0ZFUz?=
 =?utf-8?B?OXRpZGYxSTE1Zm42VmkxR2V2ZEx1TjlkR2FiYVExZVZHTDI5WkF3aEZYRGhn?=
 =?utf-8?B?L080K09iR3FaR1k3TnBaMjNVMHgrTEZ0RzR1d1gvL3N4ZTZ1dGNjYzRYajBT?=
 =?utf-8?B?TThaZnhXdFMwNThMbnQzYTNrakV6R2pOY3ZVdUIyb0wrTy9HQ1dic0FXREph?=
 =?utf-8?Q?iSWF9uONhp8HvHCUHD3viH7OIynAUionNUjUw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TDVIaXJtRWVQS3RUTG4xMVhFdmY5dGRZN1VEQ2FwRU1Xc1AvaGtObFFGNTVE?=
 =?utf-8?B?WThYYXFFdzM3RzJLMUsxMFg3Ry94Qnd3VUdJVnQzN0ZwaVdRdmorRStoa0E0?=
 =?utf-8?B?YUlsbklUQ0gyYXY0N3hLOVd5Y01YYTRJdGVaNmdyK2JzcDFVVFhOUEZsM1Zn?=
 =?utf-8?B?OE9idmJIZmhTWTlDR0ZxdkhJbXg2TllZQlBSd2hTSWprZFVBeU05VzRNaTZQ?=
 =?utf-8?B?bUxqWVZWdWxOczJhMjNleVRGck43K25ETHpZZUdUZHBTM3JoOEg3cEFqS0J0?=
 =?utf-8?B?M2p2N3hDcG1QR0NtNU4wQU15aFRsWkhhRExPcVRyRmoreW9yRXN5ZUI3U1ZM?=
 =?utf-8?B?ZjlIaVNhUUN2WjI4c202MlFESVk4bnFxS3FtQ2xFbGRPM1QwZ0x3M3dyVUo1?=
 =?utf-8?B?QmNqWlpsMkc3NXN6THBQNks4cjFsTEJ5ZWwwZ0I3TVdyQjFCeDFtbmlSTzZ4?=
 =?utf-8?B?TnJPUGorWkl4Y04xTDNGRjMrN0J4MWRGa2tPcFNHQkttU2Zyd2cvbWFkQUR3?=
 =?utf-8?B?dnpWUVNiV09WVXZsaGlLVXZ4d21aNEdMWFl0b3d2cGN3RU90L05Ca2MrckQv?=
 =?utf-8?B?WE9WMnJzZnhNeWJLREh2enh6dDZQSzkrY0lzN251VmFDYkdweWhvOGlXRGlY?=
 =?utf-8?B?TXo2aWk2TVd3aVFUbGZGdGpEQ0MvVy9XRFIzWDBXODFZVFpYVHN5eXNSMmUx?=
 =?utf-8?B?eWpzNURzbkNDalNqd3pZSDluUEI2SDA4dHYrdmp1cE80MTVhZmJqcWpETFY1?=
 =?utf-8?B?dVFJVnoyMFBmNitGa3BtdVBrdVEyY3J0aWtKalZhZy9nSmlrR3lKbWRkQ3ZD?=
 =?utf-8?B?a3hBUVh3QmFCQk1tMjdGNVFxd3RmVmF1M3FJdXVzNmgzSkhidXpoSytaRXVr?=
 =?utf-8?B?YWN2NDJEaVJmcVV3WWZtQ1dzeUdPcWxNUzFmMXZTRmJGOTA1b3JnU0YxRlF5?=
 =?utf-8?B?aDlUbFdwVHhtSWFGakJvaXJ6cVBDRDdlMTd5Wm03Q0JRVmpyaUtzTGhYVnJE?=
 =?utf-8?B?QW5jWFhwMHQyOWJBd2lldU5KSEhiVzMreWo4N3NCM3pLY01NVTlzTVh0TG5O?=
 =?utf-8?B?VnFMOXo4RXVPbjRUdFdyUnk2S240NmhHbzJvS01LY1hQYVhEb1BrbDJaVXlK?=
 =?utf-8?B?QnIwT2U1Umo5Q0pTQ0JNSjB4bEFYSUxPbzVnekRiTitFTUhlZmdReHlWTkVE?=
 =?utf-8?B?eUFZY0M5MjVXSThVbDVEdGRRY2pMZlFreThOTEhZVExiVTZFcnlSeUY4dFNw?=
 =?utf-8?B?Qk14M0l4K3kvQlNKTVZDbHJFSm44UDJvWXRhWkpySnVwTnRFZnQ5SDcvRS9r?=
 =?utf-8?B?K2Q0dFBZNUZqd3F5cGRrOS9NVHVYeTAwcmFQWDRWQTA5RmhtUlVqWUlVREdk?=
 =?utf-8?B?em90OWM4aTUrbmErYkpRRWdSWHN6ZThNY1I0R3hYMkVPSEJVS2x3T3RBc2s3?=
 =?utf-8?B?b1RkVGlDVUVVVjh3MmdSSklMeHU1dDRhMXB4OVNOd2NLTzc3M0twbzJpOFJW?=
 =?utf-8?B?cjJxMjYvcmJxWlZ6NHZNOVk1SisxWmgxZHVUcExpWENES2pGeVF2NTlDai9v?=
 =?utf-8?B?c08xVEo2Y1RGSUQvSVNqVFRwZ0VwMFE0NlhJODNyOUMvWFZVTEp3ejg0bnpB?=
 =?utf-8?B?QzlncFl6L29XTHltbzJIclcvZG1YRStKVGl5N0dvQkQwaGxUYUFyb01seWQz?=
 =?utf-8?B?T3hqUm1rdlJFdkhZV3lVTmdNQjRkSFMrbUJHNURKcjFPcFQ5c0VYdHJqVjd3?=
 =?utf-8?B?V0xmN1g0bGxtTS9vRzFpZjVTNWNKWHQ0ZVB4WXk5enNxSzRXV2lwZEpnY2Nq?=
 =?utf-8?B?NzAxTEx4aHF0QW1FM2tPQk5xTVhhWXBsQWpGeGw3ZS85SXFKNVJlRTNrUjlR?=
 =?utf-8?B?QXBiZ2Jac1c4MnZXMVNXemlsQmJMaXkvNXdYR1ZlYTZFdlFRbkp3UlIvTENT?=
 =?utf-8?B?SkZCZ2R6bzl3QllBNHd4V0t1ekdLOTF2bHJ1dE1UdU1GS3U2WkdGaEJBTk5U?=
 =?utf-8?B?d0RodmE4RVFvbDNLVVZ6Um5HQnQ4ZURlbDdHN0IvN0hiK05KMVNJdDNSVU5V?=
 =?utf-8?B?ZTNEU3lIQ0grUC9SU1RFVHBGRHAvcXozbDU4RVZXR1BXRmNVUlZpTElqM0t5?=
 =?utf-8?B?OXFtelVtWnVJVE9zT3BFaEVJTU42Mi96L2plb3BsbHJ4dVVWYnNjbm1EWThx?=
 =?utf-8?Q?sgqaXB7QcX+tff2tjgzbJR8=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54eca9ea-988c-43cf-ab1f-08dde4ac1d0c
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 14:23:23.1068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ehy3rGq9aberQvsshReLDazxb+gCWCnzZUKnpkZwlKT5df4E8dth/ykkGj3MeyR5Q7s48IbhN4VDnPk20yGlBOlKSpJfwnrL0ugA8YVJsDQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PPF63C40F8D3

On 2025-08-23 12:39, Thomas Gleixner wrote:
> Disconnect it from the config switch and use the static debug branch. This
> is a temporary measure for validating the rework. At the end this check
> needs to be hidden behind lockdep as it has nothing to do with the other
> debug infrastructure, which mainly aids user space debugging by enabling a
> zoo of checks which terminate misbehaving tasks instead of letting them
> keep the hard to diagnose pieces.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> ---
>   include/linux/rseq_entry.h |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/include/linux/rseq_entry.h
> +++ b/include/linux/rseq_entry.h
> @@ -275,7 +275,7 @@ static __always_inline void rseq_exit_to
>   
>   	rseq_stat_inc(rseq_stats.exit);
>   
> -	if (IS_ENABLED(CONFIG_DEBUG_RSEQ))
> +	if (static_branch_unlikely(&rseq_debug_enabled))
>   		WARN_ON_ONCE(ev->sched_switch);
>   
>   	/*
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

