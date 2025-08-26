Return-Path: <linux-kernel+bounces-786931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F446B36EF8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 17:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99CA04660AE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 15:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D536335AAAB;
	Tue, 26 Aug 2025 15:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="lMBE0I+x"
Received: from CAN01-YQB-obe.outbound.protection.outlook.com (mail-yqbcan01on2119.outbound.protection.outlook.com [40.107.116.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFE830ACE4
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 15:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.116.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756223150; cv=fail; b=DnQk6Wbh0CV2kX20NVGqrNTtGQlnqFhzezevYiSiFXFeK7+TJiQ2EnJ1UIi/FBi7hvpTCYf3IlFys7jN8ezZRDqbXhyvP3xnyZ80CsFafl187qqth5O0uKJxQEfRXe69tcs42R2asEixZ7pk5FMSQdc02y9Y+NKY/7Pq4Cvdnb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756223150; c=relaxed/simple;
	bh=z+i/C0+hFL4liL0l1Eprt8rX4D1ziyArzwV2A9QsPhU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KbQQjarLHqOg8sg8o8OzlFJ5ZR1M9sqNNvSnYDhEBvsH9bIMR0ZI4iFTECFdJjcmcTD8TVGp3dy6Av2sQjwy2bvaEf8Q7saUb+38s2Qx95QAcLaaNgV3ctvpP3JvYAf+/Z2v9cAEsz96FiDhPbx4Fp9YsEVBmlWHbFwkTXRlgTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=lMBE0I+x; arc=fail smtp.client-ip=40.107.116.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dj8hyuvkYdj83PGTh7qJ3unlwJu/g51R0v554ft8vdjldIzXpNc2Jqq+b9Y9czGrX7qycaERMZY9zLj39glcoHP2CilBRcgKDIqSdlrIV3gdsryaJUrhMUWV0+T/eA5xxZ4I0Y1Xextqvp0OBZCJ0IDdCc5T98RJyU+ad9K+0o2PRafkPkHFQMxQNVF1WY4kd6iQyIGVsUxRHNDZ9NWONB9mcC7xKaXMjAHb83clT2lfKq7nZERPtbGGlbTgDpoEWORBJbhNOMB8ctn7V9kiOxuXa0/W4wKQlozJFabMHn+N/Y2kEjBSfdFiyTV4NO5AsYs512j00/LLbh2s6MEhSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yXUXLndiwmZVOJrrKuS+1djDVc/pauMPW1eKkxiKwlw=;
 b=uIfGjjK9cdI01LshQ8/1hze0g/c0D82eWJE93YmPvOSrgy79nekFN4t0t1wClGEVB4gKSYZEbA18iz8iQ7pqF8mw9s6FAcQJuHQdeBsUMSnx40iiGgLTlexuPpUfLOv/cN/UR11hFfOra6HQJPpl3cS/KWcWc4ev+GhQfEsWFHkI6dE8p/p0s1u3oVHkf+1tKaDpb1Jh8ba4ZEhwZJGDO3ZoReU+IYkOS+stWe0P35THngTLTjQ83sFZR2mSFOBY+PkxG/+K9TnEcD6L4uL2x5cdoeWhYUv74SoreUaXh+TQc/0D7cDuRVP6MuUAvMZGAYUxeak/+z+dTqxTVmC2zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yXUXLndiwmZVOJrrKuS+1djDVc/pauMPW1eKkxiKwlw=;
 b=lMBE0I+xLjAxIRVQbncoEcuk7wPCcc/YXQjE0tse2QDECySTHTTl9jJp69f7AVQpPr8h6zDifSYDU46ZzV3aHur9Ntt2zESSMbg24bA/OOTINoR1fkUM20GXBZY1eg1MSfGg3B1/iiO6FhTrHq+FNvDfogqIzHz7m12phZzB+Fac/1dif8JzGmE2RxsWrVkSMqdhGEapUvEcHH/bkIfrmUOmcJ/M97+LOcn7zRfn/C1Ud0du/dcGgZN+ZFdCbjpPxSK6UwoRJxEgXGt8mbVPf2S28o9tsLJnbM0Yh5t0kwH3Ryu9+VsNp8rMT7Cf7AqYEBAkVFZW02Ygi+asfZGf5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR0101MB9758.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:81::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Tue, 26 Aug
 2025 15:45:44 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9052.021; Tue, 26 Aug 2025
 15:45:44 +0000
Message-ID: <fe00b744-eef0-4c5c-902b-a3e2bbd7a8bd@efficios.com>
Date: Tue, 26 Aug 2025 11:45:42 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V2 30/37] rseq: Split up rseq_exit_to_user_mode()
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
 <20250823161655.191313426@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250823161655.191313426@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0106.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:83::18) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR0101MB9758:EE_
X-MS-Office365-Filtering-Correlation-Id: ee51d963-827f-42c3-bd39-08dde4b79e0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?djFoa2VVT09CMEJ2N2NuVGM2VzZFNVJTVnFOM2h0dDJqeXZLaEY0UndnT2Q0?=
 =?utf-8?B?UEtmN2w4R0duWlpFNFZwVzFoa3BEcExwb2dRc09JVUlhNU95RlhUSk5URkVw?=
 =?utf-8?B?QzU2aE9tbEl0L1pZR0dRK215UU1LMmF4dlE4SWw2MDNHM1ROYUR2N01abmVs?=
 =?utf-8?B?bEMvbGJkQmxSUmZLWi85SFRYcVZmZ2Q1WUlCTEh6WGRjcHBlK0tSb0p4RmQr?=
 =?utf-8?B?S3lLSFZ2UjRMaWdvUGpZU0Nld0VCcml2RmNiS1BKdmpQZkg4ZU1wM2ltS0lQ?=
 =?utf-8?B?cFkzajAxbVhadHVLOXU5L2g0T0RyNkRBYVpiQmJvOTF1VGxRcGlQRnczcE83?=
 =?utf-8?B?eThHeXNRTElsNmZGeXBPZVFwa0VEQ0NDZytma25QMkhEVkVlck9GRllsT3NC?=
 =?utf-8?B?b09ybWNkU25QT0hadDAwZUI0cFplR2MrNWJIWW11TjQ3WVpqOEk3VHJ0QWN0?=
 =?utf-8?B?S0pRTks0ZTFSZ0sxVVFaeXM2REZ4UGdsT3hVZ3VLeWdiTTdzenM5UEFPU0xu?=
 =?utf-8?B?bTRCd0pXM0w3cGFWTk9oeTVYMkNaWDJCcmducjhlS251cGxrL2VWVkEwUDNH?=
 =?utf-8?B?SkJDbWxUOUJPcG5UOG1EN3pJVzYwWGlhelpnc1hxSnBQVmtWMDYydm0wUTBz?=
 =?utf-8?B?blB3eHk3Z3htbDlMU3FIc3Zmc2d1Z1d5a0dpMlZWMFozdlNWQTdvUGQycUdT?=
 =?utf-8?B?ZElqY0ZoQTAxZEZ6M0pmdlRCK0M2WldwcDZzVXpwQ3cxa2tTQmdMK2V4cUxZ?=
 =?utf-8?B?VzlFSUpQL0hXcXNVNERSNUEvTzdoRWd6MytCVytCN3pzUU82UWZ4bW9RNzcr?=
 =?utf-8?B?TjBVcE1hdURMQlRXS1hKWGprcSttN0g0RXZCSHRYZWYvSk1PS0I1SWFvcjdS?=
 =?utf-8?B?d1U0SForMEZXRjFpLzZ3akNCM0tGZXB1NktiNzg2MC9HUzlwWHVsQ011Tkt4?=
 =?utf-8?B?endCb1VYYzNVOEp4T3RtQUVQRmZFY3dmZEZtd0NxN2ZUb2hwcVJRRHpxbHlw?=
 =?utf-8?B?SVYrTnBac3VKOXVpeHcwUGY1bkl4Ylp6c0wxREhTSEM1ZTdrQUo1SS92QzJX?=
 =?utf-8?B?STU1N29VRW1wZHdWVE5rSktWQUlwOTlLYm45TXVOUE5pYll1Mm1LeWROOHFw?=
 =?utf-8?B?c1c0Y3J1VllLeEdJQ2xWN3lwYndYd0J5VjNCZitBWjRTVVpmVTRJZ20yRHh3?=
 =?utf-8?B?UndPZmc4RWhBMWFyWnRSTHBZWDBBU2YySGxYTE04VmJzOGhIL1crWkIrcWNC?=
 =?utf-8?B?YkRYZncvOVVHaUR6WlV3TzV1TTNYZEZ5YUxiWjhhOWNTMkdLdnpzRTU1eGo4?=
 =?utf-8?B?OGxxZkxKTURUQmF3ZjZUVFY0MHpicDZUNVBJbmszMDhqWnVJcXFXd2ZqSklU?=
 =?utf-8?B?Wk9tSnNMRHJ1Z2VlcHdlVTdTcFdSakJvOFpUamtWOVF5Rzh0dUZTcmFTT1pk?=
 =?utf-8?B?V3F3ckFXSWN4UVpZRkpoZ0JKbXl4a0s4RzA2ME9nR2pvMU9lZGMrSUo5VFNY?=
 =?utf-8?B?K095VXhDYXEzYW9TQnFjUmxhSXFKYXFOeXV4YXJxa1hDMTBBZENYaHpTeHpy?=
 =?utf-8?B?QnR0TTU5SUdEOWpxMnlMWVVRaTVpa09xNVJsZEJBVllQR2ROYWpXWHNzQ2RW?=
 =?utf-8?B?a2VpWHkzYkt3emtZRU5JWU81UmJLUE81cDZKNG5MY2xISTFPdDFwMkxPbS8y?=
 =?utf-8?B?Qk8rV2F5bjE0T2FaRXI2YWRDSlo5a1FRQkwzZHA1ckswWnBnR01sc2Y2SjdE?=
 =?utf-8?B?VmVhWE5sSmVsL3QvQ0RjVUVEdDN1ZW80QkxValVJNXovZlYxQ0ROK2x2T0JZ?=
 =?utf-8?Q?tVHFWBIOSy3zReLddbd3f5a5q1a26UciOhqb8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Nzc2U2ljN0ZWaFp6S2hJS2t0QnovNjBlZ21TOHpNbFExRkNPY285c1RTM1pZ?=
 =?utf-8?B?T1lWYmhWckw2eEpTQi8xL1g4VjNoZG5TbVlkS3RFZmJKWnYzaHNiYjBUakpO?=
 =?utf-8?B?WDBlbU9WTmwrS0YzNUpxSzlPL2o0U0Y3TXJSM2lXMFBYK0xUWTZzRzFPd0xa?=
 =?utf-8?B?ZG9ycGRRNGNiZlkvRG1tVjArdXlBbk9TK2hscEZHWXdVRnMvVElOV2xTVjVp?=
 =?utf-8?B?Z00wVDhCQjJ6TUpOYVowQVZGaWg1bGlNVzd0MXpLU21QaEg0cU9oYUZWSkZI?=
 =?utf-8?B?dk9VaUVFM1poRG04NkkySStkejRLQ3hsaDhQSzlSanVkZnRYUG1MVXM2MmdZ?=
 =?utf-8?B?cGIwYmYwQVhCNTFJazUzWFpoSmN2M3NpcEJzWVdvcHZJbnFnMDhjYUJoOW05?=
 =?utf-8?B?dCtYUTYzNEROV0pQczh4aTZtc0RwRnlTRWZBMGxzejU4NnZ5MnBIQXBHZW5h?=
 =?utf-8?B?WUNIeUZjcUI4V0ZKWmtWVmcydHY0ZUljZzJvT3ZPN25sZW82VjB4amlFRmpS?=
 =?utf-8?B?eVdudzAxM2p1eSttZzhEaXpMSWh4SGJabW1jSGx0clVTZ1lnN0JVeUhHMVA2?=
 =?utf-8?B?YTdtU3dLMjgySTNEWXBNZUVDZHNIdllhU2VlOG81VWRNNVNXZWYxemJFNnEw?=
 =?utf-8?B?OFRYdUduOGFNeERmcHIxSEVhWXJVOWFRNjhMVmdMdFU1MWNMS0NjeFBOOTh6?=
 =?utf-8?B?Y3VCUVYyMlpTU1JVNXBkSWV4K3pOTzhxS2VuUTQ0OEV5RElHbHF5dkorQXFu?=
 =?utf-8?B?UTc2Uy9JYmY3cXF2WWg4UTh3OVNVbXhYM0JBWG11U3hFY1huNTc4T3ZyN1FL?=
 =?utf-8?B?SXRodTdUTk16ZzBrUWNvYjk0NVJsd2I5b0xhR1ErdGdmdXVKRGhYdjU1LzFw?=
 =?utf-8?B?TUpSb29PeFJNL3ZyOVBhbXhGUVpLdmdHeHo1YzV5ODBKekdWZDJHdWRRSWt1?=
 =?utf-8?B?dERVQXBuY040QUxRL1hta1pYSGtZNDljVTlvUXo1SE1yZE5NcDhjWEZOdTJS?=
 =?utf-8?B?elFCeDdKcFMrMG1aRTMvM2xqdHUydVB4S05TSUF3b3pmeS9ZRkdnNGZvOUJY?=
 =?utf-8?B?aEVxKzdxdHVSYjF2bjdjU0k2WWtSSXNsbmVWSlE0UVNJR3lrbDQzd1ZIRVVB?=
 =?utf-8?B?L3NrMjVpeklsOC9CWVdLbmZpbW9kbnh0Wkp5aE80WFlXbVhieUJaMXNob3Fm?=
 =?utf-8?B?TDVEVCt5bVNxRjJZaUNZY3VPTTBLSFNjdmtPS0JuMjd6RTU3QmVQQmpTeEZQ?=
 =?utf-8?B?TG5HMDlNczF0ZE9MaXlydmZ6TWlXZmFoS0g5RXpmYjMvWVY1ZjBhWDBGa1J3?=
 =?utf-8?B?UVpCNEt5OWkwN0dDQTFWMkFVSnlNNnI5R3NnWjRDa3FFUng4WXZVMU0yV3pw?=
 =?utf-8?B?dC9uOHdldVFCb0xNdlpaV2d2c214YzIwaVpjMmN6Y25kT0N6SHhDYXRwbC9C?=
 =?utf-8?B?ekhwbTl4djdCVStiWHRpRm1oYmpLNi9NNmxlWVJMVkladDBwdTJndlFQY1NC?=
 =?utf-8?B?dU9RUVdIMDh6QlJCSmd1R1BVNitpR1lwOXc4MzI0ZDVoVzdJcFZDbXo4dUZP?=
 =?utf-8?B?Q2xvVDJsdVU3Yy9FYUd3QUcrZU9INzgxV1M2THhZcXl2MTRSbTJGRjk4TWNa?=
 =?utf-8?B?bnlYZFMxZWNSck5KM3pjZ1pVSmpuamZ0Q3RoOGpGNVZGRWZZak1YQlVVSXl6?=
 =?utf-8?B?V3FUWVA0Ymp6MTdwUFByWDIxWG1waFF5aWpabUVEcVdFd1hKZVNtbnpsQ1JB?=
 =?utf-8?B?dkZxd2Qrc0QwSk13WWNmVVN3SDFZem10dUJHcExtSHlzdWQxb2RZTkV2TGdZ?=
 =?utf-8?B?REFpRjlIV095T1FnUEV3ZUJpdkw0QzVoUFc2aDliMnR0dHdzUVJWMS9OeWtS?=
 =?utf-8?B?UnRSMkVjQ1VHOGdTQm1ETnF0dDFFTndNeE81b2ZrTTFjTWZtZFR3WTRTYVVL?=
 =?utf-8?B?dFdVS1VoVE8waXNCU3FDcVhmeTJiY0U4eDBlSGQxRzNWdVcwMFJsdVZLcFlh?=
 =?utf-8?B?VGgxYjhZb3YwazF3QW5SOE9STDV1T3BvSFZsR294RENXOUxRQTBRWVdiK1F3?=
 =?utf-8?B?bWtiQUMwNHRCQVFTdDRBR0RZWkNBcm95VDJFVHBPNUMwVmtPdnFzUWNGWlVK?=
 =?utf-8?B?eWp2QVFtYjhLcW5VQVJqdDhQZUN6Sk5PVTJQTHM0MHNSR1dkU3hyL0p2ajhr?=
 =?utf-8?Q?udhtgDuXCJeABgwu9QotEN8=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee51d963-827f-42c3-bd39-08dde4b79e0e
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 15:45:44.0122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qLHXX4b+E+80/BdOB8FZCAsDsd+VwWGktB0Ay3DBRAcHpGgHBz39UrepWphTcI928AF0hHIcRpA58JR7nJIj5zsOT2ASjntdStA325iCPFo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB9758

On 2025-08-23 12:40, Thomas Gleixner wrote:
> Seperate the interrupt and syscall exit handling. Syscall exit does not

Separate

> require to clear the user_irq bit as it can't be set. On interrupt exit it
> can be set when the interrupt did not result in a scheduling event and
> therefore the return path did not invoke the TIF work handling, which would
> have cleared it.
> 
> The debug check for the event state is also not really required even when
> debug mode is enabled via the static key. Debug mode is largely aiding user
> space by enabling a larger amount of validation checks, which cause a
> segfault when a malformed critical section is detected. In production mode
> the critical section handling takes the content mostly as is and lets user
> space keep the pieces when it screwed up.
> 
> On kernel changes in that area the state check is useful, but that can be
> done when lockdep is enabled, which is anyway a required test scenario for
> fundamental changes.

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   include/linux/irq-entry-common.h |    4 ++--
>   include/linux/rseq_entry.h       |   21 +++++++++++++++++----
>   2 files changed, 19 insertions(+), 6 deletions(-)
> 
> --- a/include/linux/irq-entry-common.h
> +++ b/include/linux/irq-entry-common.h
> @@ -247,7 +247,7 @@ static __always_inline void __exit_to_us
>   static __always_inline void syscall_exit_to_user_mode_prepare(struct pt_regs *regs)
>   {
>   	__exit_to_user_mode_prepare(regs);
> -	rseq_exit_to_user_mode();
> +	rseq_syscall_exit_to_user_mode();
>   	__exit_to_user_mode_validate();
>   }
>   
> @@ -261,7 +261,7 @@ static __always_inline void syscall_exit
>   static __always_inline void irqentry_exit_to_user_mode_prepare(struct pt_regs *regs)
>   {
>   	__exit_to_user_mode_prepare(regs);
> -	rseq_exit_to_user_mode();
> +	rseq_irqentry_exit_to_user_mode();
>   	__exit_to_user_mode_validate();
>   }
>   
> --- a/include/linux/rseq_entry.h
> +++ b/include/linux/rseq_entry.h
> @@ -519,19 +519,31 @@ rseq_exit_to_user_mode_work(struct pt_re
>   
>   #endif /* !CONFIG_GENERIC_ENTRY */
>   
> -static __always_inline void rseq_exit_to_user_mode(void)
> +static __always_inline void rseq_syscall_exit_to_user_mode(void)
>   {
>   	struct rseq_event *ev = &current->rseq_event;
>   
>   	rseq_stat_inc(rseq_stats.exit);
>   
> -	if (static_branch_unlikely(&rseq_debug_enabled))
> +	/* Needed to remove the store for the !lockdep case */
> +	if (IS_ENABLED(CONFIG_LOCKDEP)) {
>   		WARN_ON_ONCE(ev->sched_switch);
> +		ev->events = 0;
> +	}
> +}
> +
> +static __always_inline void rseq_irqentry_exit_to_user_mode(void)
> +{
> +	struct rseq_event *ev = &current->rseq_event;
> +
> +	rseq_stat_inc(rseq_stats.exit);
> +
> +	lockdep_assert_once(!ev->sched_switch);
>   
>   	/*
>   	 * Ensure that event (especially user_irq) is cleared when the
>   	 * interrupt did not result in a schedule and therefore the
> -	 * rseq processing did not clear it.
> +	 * rseq processing could not clear it.
>   	 */
>   	ev->events = 0;
>   }
> @@ -551,7 +563,8 @@ static inline unsigned long rseq_exit_to
>   	return ti_work;
>   }
>   static inline void rseq_note_user_irq_entry(void) { }
> -static inline void rseq_exit_to_user_mode(void) { }
> +static inline void rseq_syscall_exit_to_user_mode(void) { }
> +static inline void rseq_irqentry_exit_to_user_mode(void) { }
>   static inline void rseq_debug_syscall_return(struct pt_regs *regs) { }
>   #endif /* !CONFIG_RSEQ */
>   
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

