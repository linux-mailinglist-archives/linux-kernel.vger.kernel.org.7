Return-Path: <linux-kernel+bounces-808504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3C6B500A4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 17:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 520913B72A6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4875C34F497;
	Tue,  9 Sep 2025 15:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="AvNRfk2R"
Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021074.outbound.protection.outlook.com [40.107.192.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD35A4A07
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 15:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757430337; cv=fail; b=dLCzn6YjlaplsPwZJEXKTCtkKafzd/hf4dpvY2fEJSqhb2/FlPDbtDaPpGGuy9insxwLbyrtY3TaIEyaTiXuRgZAzlCOt3EuGRkpZiCTwSwIDoQW0+6S70S1RjHBIRpjp1jIRq4ZJIMFVzB80tM+3b1sWkO9whUV8GYEKiLPTeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757430337; c=relaxed/simple;
	bh=3ALq+p3HMMekYOqgz9uAT2E8LJpxhpcdd6jx+0tSHPQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s9zezH2wqBpW2a+JHgK/kbae6Ik6XhWALxmBi9DXTd2zdOGmInU/wlYsElNMBiqMywaHM8U4U5LWjx0X/oWQRWsUyZEsHadrQaB3u9F+hXXxBLp/yAJbIULUSzb0+plKBoCasNZCUjnvBnLO6LSjIvKAlxgSyXK61vkaI8+PRQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=AvNRfk2R; arc=fail smtp.client-ip=40.107.192.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E64/gL43yZE5qsrbH8MDCGN71a2hkNwmLC3RMydhhcvlEa4QRdE+FxDHk/9ogTOTA969vkesABoLMFpbLvlwyWeIoLyxWrEclydFn6pWFDckmLbCDGcYKRYgGlCxTbR7hZiasli268OwKeAPR4MMWSTnhuHM0YKiHCTrdJb/Sx5blNnv9SBTje2BUcYp/s9S5tsPCAPSF3bakp9K1qDfK7glViV3IKEHPMegkpMqMzEeY0crKzSwonBg7QSVrV3S9mJW6jC5vs7CLTaUdRuOQ7yd4RWtyulbNlKN9ZsV6OilRHGRcC6pdhh5ShDuZNapvrm7JpTIunJYUCoDvomfdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BtW8BXVNihmNB8T3KBy5xbDtOhsjeyXoH69VgWlikC8=;
 b=fqzlb6DhFAwNEetRZXrtYEPcn7yPw1mLpm4CvmlYW95zBn+l9fl7ReI7u1vfhWeeSBPNbkg7/zJUuCnYgLPNa4KLAN5Gxh6oDn891bhm8teDumV1zFH5+RY0G3pPwuZSgux6wjbpdBIe5gGkOjLFQDfR/JZil4ebPrtR0uWLci618YOy5kkGQ/S7UKwwblMuP5jqCXQjSUV0uflC8jSUkIgDKAuPIzVEmhKnWUmzcuGlgysWsaPHrWkyUH6O/aLySN9MCfvBkYC+oukA/D1KvuCXcWptoJN01zL67M680b3KVBuVdWFYnubTyvbVwE0LKjLbix8cCS+htkvkN5vFFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BtW8BXVNihmNB8T3KBy5xbDtOhsjeyXoH69VgWlikC8=;
 b=AvNRfk2Rqj07BvFuKvdF/6PskRcf7y7gILesBiUjx3VfwId9yHsW2u6bNVcMF0BWcmHm/jffH4d2uZXyyeybeQCzDEn04vj+fceBLZaoL2UmnR1x1fo9E2pcocZO5TAv5/0uTN2EF7+4eVnjBuyv1YxZsmbxOmryeRBUPSpvTve5Uz0NY4Xnvma6kt9EQMGExad3TbyujXnv3V65aAA2ByvMY9n18AzswQR7Uqqm0IfBtPf6DvZk95PHn9KmfPy8I6JYZaYJKwhRR8Z6thvc/lJlGmdPKALrq18deaCVkCopgBwEEyFRmto+lx+QblQzmei0QPBB3td9COsNpHyriw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT5PR01MB11213.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:134::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 15:05:31 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 15:05:31 +0000
Message-ID: <5611c8e6-c363-4695-b572-d80e95d1f65d@efficios.com>
Date: Tue, 9 Sep 2025 11:05:30 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V4 15/36] rseq: Record interrupt from user space
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Michael Jeanson <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>,
 Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
 <seanjc@google.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, x86@kernel.org,
 Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>
References: <20250908212737.353775467@linutronix.de>
 <20250908212926.225746125@linutronix.de>
 <5911c934-db16-433b-a1b8-c5367e420248@efficios.com> <87ecsfvhf0.ffs@tglx>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <87ecsfvhf0.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0172.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8b::10) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT5PR01MB11213:EE_
X-MS-Office365-Filtering-Correlation-Id: c194ac27-902a-4e68-0087-08ddefb251cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UjdmcU1lcUxSZHZTN2h3Yk9HSDI1MW0rZjhPelMyZW1YRTgxTUR3MlpKeDNB?=
 =?utf-8?B?VWhiTyt6V01pMGpBeDZBVzVxT1Uva3p6MFphWUlPVFplUVZzams3K3cxeWVR?=
 =?utf-8?B?K1hKejBtS01weSswck5ZSDZjSmRjVWQvRjd4NXZLbHFEVkdMUlphTDlMYThT?=
 =?utf-8?B?VGJXcm4xcWpjdExvdEQrUWo5b0I0TEpZd0FHS1gxazVaMm9MQlFZU214Z1ZJ?=
 =?utf-8?B?bWVSYWgvMWVkNTZaSHN1MzkvcVlqODZmR2pDWXZLT2NEOWRQZytjL1lnV2JG?=
 =?utf-8?B?ZXB1aDRiRnRSMlVBMmY2M1FGU2lhdUtVWG4rOXJvaFRNNUxicjg0b2JIZFhs?=
 =?utf-8?B?bnBkb0hsdk9xYnFvMmJBMlNYOWlkQ0QvVTc0c3lFWERmMHZUcEtEL1FEaTFL?=
 =?utf-8?B?NkphRUZnQjkxM2FyRjRWS2NlbllQa1JjVjR3R05USVB2VnR1ZXk2TGhkYi9t?=
 =?utf-8?B?T1BvZDdXNzFvUVk0SHFTNWw1Rnh1NFM1RjJkRUxEVi90cVcrTnhhbU1yT2tE?=
 =?utf-8?B?NWUxMVFhcjZMaHVibyt0bW9zaXIvNExxcXV3UExHQlhyZmtmcC9RdkYzRHpl?=
 =?utf-8?B?MktucSs1RFFsKytGR29QOGJkKzIxcEFHUlNIQnVuVFAwWkNyb2dBNEZEUzJt?=
 =?utf-8?B?SCtCeDNGOUFRK1R2RndId3hBMWhVZDduUC9JcGxwTUErYmZXZUlPOTRYdjZv?=
 =?utf-8?B?eitOc1NUTms4L2hybXowY0ZDajRtZmxpSGw1VUcydE9OTDJHMXRkTFRpYTdC?=
 =?utf-8?B?KzB3blJqSnNNVXN4MEtsYXJoU1RKWFN6RDFMNUVmNmxlNm1lOVhKTDRrb0hZ?=
 =?utf-8?B?WUppRjdCK1c0RTJBVUNPK21vQjVybnlEc29RM0N1cWhLVmFzbm9VdmZsVVRL?=
 =?utf-8?B?bDNVZm84OUkwOXgwZVhqczl5Y2dFUTliekJhUUx2eVNmRTB6MHRZemhLTGpt?=
 =?utf-8?B?RU9JNVJwOFpCaVgrT0grM3BqUDE3bG1jV2JGVUlsTUdKdklZU3FvVCt0Znk3?=
 =?utf-8?B?YzhnNm9mUllva2s1Y2w5Q215Qy9ZamxCUjJHc1Q3VjhGRXZIbUhsTExzSDRS?=
 =?utf-8?B?SUhzSjBkbGRsN3FlTTdNc2YwU29vWldJSEdzZ050dHFEaWFZVjlqa2lBNHZS?=
 =?utf-8?B?K2ZQTUpDWkkzUTE5OXoyZXRwejJSQWlaMStydktCYVM0ZzgzVU9ZVWFDQllv?=
 =?utf-8?B?YmRUaUR3Z3BwNURNeXJadCtVRDVzRytNM1JuMUtKNUpvZDhXb2h4R0pHWkpP?=
 =?utf-8?B?OUYvR01oZ2orcDR6dUFVMjhPd1N5TzAxQVFNbk5VcDFPaEErOFIwM1JYSCt0?=
 =?utf-8?B?V2lHbVhSYi9jYVBVTnU2NlhTTUxmSm5DRjNRQUdOSWdaMk9CWjR6dFdhTEVG?=
 =?utf-8?B?UXJPRjg4UzlMLzRIK1p6U3YzSHRQRW9sRHlUVUhqckZPWGlibE1Uc2ErVW5y?=
 =?utf-8?B?TXJiWHBwZksxYnUzZ004VWNaTjFyYnFMdXgzUmhWdzF0QWRZTll1OTNEaS9Q?=
 =?utf-8?B?U0t4ZzFsT1dyWFpvTlpmajBieW9ERDI4Znp0R1gzVEdSN2tSWkpQVzhzcnZv?=
 =?utf-8?B?YWIxdkpROHlETEh4MGVZU0NNd3hlaUhreTdxTWVSVzVlcThSRGpDRk5YK0Vx?=
 =?utf-8?B?Qm9iSEgxbkJQdE5jNjYwakp5aElVa2F4QTVIRXYwMGt2RzlSNTVKUXpuY3dm?=
 =?utf-8?B?NDlIeG9xTVR2bk0vdDBMempYbVcxQkdmTFVHTnFCK09BN0ExOWlROGExMDFB?=
 =?utf-8?B?SXFUSHRtNm5GZEYvVnlMUzFDRUhQaWplM3ZlcGt6NzNFUlVQaVpqU3FzdkF4?=
 =?utf-8?Q?quNTbx8RmetEPmlj3seBC2i9Vtx7eJDaR1lnE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VXprUENTOTVaRytvc1JSNVpLS0tnZ3JZRVRaa3hNY09oc2RPUlBUdFMxYmNW?=
 =?utf-8?B?Mi9YaDN0SFlyOENhS2p2ZmhoTGZJTzdaOFRkRFhIQTQyS1FrbmJCTmgyWnRC?=
 =?utf-8?B?Q3R5NE13cjh3RFJDd1hQeXowdnBncGlHbVBZNzUzYzVCYUR0RjFIWFhpb2Vk?=
 =?utf-8?B?VHQyZVllb1pBSWVFeGFValc4TmlRS1B3akRWVWtmNmg5dWZhcmVJeTZ6NnZ6?=
 =?utf-8?B?eDdrNlF0cDhadG9RZ1BPdEhrWWE4SGpTZkFVQkg5RjlRbVNwMzFrNXJEKzVY?=
 =?utf-8?B?UkR1RGowNnYzNHFBeEtpKzhYNkJ2a1RZSHFzd2xIemZoenVJOVNxZlZnalFo?=
 =?utf-8?B?TVNXSVM4ckpWZ25Qb09VL21XNFVoRXhrRzVZR2xBamdCd1poYTZwMTJaTmFm?=
 =?utf-8?B?UGo3ZEIxaXQ1eitxTTZ0WXZadlZ0OE9JRWFIMVpJbFNjZHUrUnUyaHZGY2do?=
 =?utf-8?B?VTBTNysxYm5YMkdHMVAya0JJU0xWYVlmbitVbm5uM3o5MHBZdXd6SFdIN1R5?=
 =?utf-8?B?NUxKSUFZWW9hYm5tZTltbkhJWG9QMTc0WEVpWWlLWWt0T3BzZjI5bk1qUWtq?=
 =?utf-8?B?SndBUU1NcG5ZWFFSNjY3OXduNDdHaWFIc0JyUy9PZlJzanZkS0svSkZaV0xx?=
 =?utf-8?B?empRNjFVLzhYM2lxOFVuT0VEY0tPc0xWR0FkRlNSM0IxWGovenVoelZYbXpJ?=
 =?utf-8?B?UzVWZEdNUjJybm9nMTJqRHFtZ2lQYXh0aFFqaTIwOFc1a1hZTkl4aUZtaGFy?=
 =?utf-8?B?UWlVcVFRR1FYMmFoeW5oUzZXNUFOUUt6a0FDQ0RVVDBPbnlTSERDNzVOSjBk?=
 =?utf-8?B?aGxnLzZKZERtU3RYZEpMVE5IYWM0c3c5UnRicEo0MGlMcFJ3N3FTVXFnSG1M?=
 =?utf-8?B?bFUrbkVlQ1pJRlFnSHFpZW56alpsR2xjODZjSzZYZXA4VnNIZWZQMmJ0VlBn?=
 =?utf-8?B?UnhJRnZJdlRNSjI0YU9qc05QU0R6Z0dncWQzdTNNaXJZVitMV1BPQWJWLzlv?=
 =?utf-8?B?KzdlanhDWkN5YkhlL3FqSzA0bllXVTNoVlo4SEliRlZCRUVnd2tCV0VRRStI?=
 =?utf-8?B?NzNvYUN4dHoxWVp5dDBjWHJuK3JaaGRzWGlqV2RRbE1JUFY1S2ZVeU4vdi9M?=
 =?utf-8?B?UzFEbi9TWG9TMWROOGcwRHVhZFpEdjZFSkhVdDZLWmZKOFJZSGRQcmR3T294?=
 =?utf-8?B?UHpVSjlFVDhWWjNXZGJLK3UvUkhhSUZjVDJRQ1hDZmpDZHZudFRJUXJCZ2hV?=
 =?utf-8?B?T2NoK0Vpc0JIZndBMFRjQktnVlFaWlZTOVRESkNiME5UcjlmbnlzQ3hKTU1k?=
 =?utf-8?B?M2syUjZkM3FpemVLQ1RtcnAxQU1zb2FaYko0QW5zSHplTUd4NTZCK3FWK0l2?=
 =?utf-8?B?NnRnWUs5N3dmVHpzNlEvQVBSdGxlMFNTTHZ0dnhGekR2UzlMbDVUMnRHc2RQ?=
 =?utf-8?B?azNkY1RlaGt6UE5QNkNKNXpGMlpMTXhnUklkZnY4ejNPNUc2NGUwY2FRYjBC?=
 =?utf-8?B?UlFxQjdzUHBVaElPVzR0Nlo1ZHBPdDUvTlc2Vm0zbG5XUUw3Tm5SZ1BjQzJX?=
 =?utf-8?B?SHpRcmVSL0U5cHVIeDFBSkxCQVNHN0REaVJyMXlKV3RkaEY5Tzd3T1Jwd1pH?=
 =?utf-8?B?SkRUbEtwZFlIa2dLYTVSKzVENm1GQVVQRDlhZ1grUEJxQ3ZzZGtUckZsMXFz?=
 =?utf-8?B?akVLb3hHcUFhd1czT3V0bEkxNGNuOGFmTytnY1p1Q0FiTitPWlpRNmhIMmxJ?=
 =?utf-8?B?NFJydC9Fd3I2clJlYUtkdGRYbkNjR3hsQkJWSUJZWVpVdW9uRkNvU0owazZN?=
 =?utf-8?B?WTVxRFRLRnNzSG10RHpQMUw5dnc1Uy85VkpLUzJoeit6L3dBYkc3QkV0a1dn?=
 =?utf-8?B?RHpjcG1kckdBWk1EUDhjWkw1bnRZRHdRUnRCd0NhT09TK25pdVJscjdBSzJ4?=
 =?utf-8?B?R25HdzZ2elVwUTNwandYZXlCOFhxVjBYNzRweGo3SXk2aGQrNFBPR3V1VDNi?=
 =?utf-8?B?aUt4R2tUV29qYWp2eUNCaU56czJYZVZCY2pNdFBkTytLOCtLTUYvMWNhalBx?=
 =?utf-8?B?V3ozSUk3YUQ0YTBKU1VxTHMzc0ROd1JTNTdsVG1GYjk5Q3g4Zkw2NDlxNHVx?=
 =?utf-8?B?N2dPTzQrSy8vcEJXZFgwWERzRUtxV0d0SWt5dnN4aHlDWmcyTFRBa2NiUGQr?=
 =?utf-8?Q?/jsKcEI8bM39FLETy8hY0FM=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c194ac27-902a-4e68-0087-08ddefb251cf
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 15:05:31.3555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C+k0iV94FZrlGZ80GS3X2bVCRcRQq7bZ6ActsA6TDGQcMhntACPjLKLYCnHb6NsgwmF9FuP/+vQcGY2InHj/Z+AB48CgO4jR281FkDboRp8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT5PR01MB11213

On 2025-09-09 10:17, Thomas Gleixner wrote:
> On Tue, Sep 09 2025 at 09:53, Mathieu Desnoyers wrote:
>>>    static __always_inline void rseq_exit_to_user_mode(void)
>>>    {
>>> -	if (IS_ENABLED(CONFIG_DEBUG_RSEQ)) {
>>> -		if (WARN_ON_ONCE(current->rseq.event.has_rseq &&
>>> -				 current->rseq.event.events))
>>> -			current->rseq.event.events = 0;
>>> -	}
>>> +	struct rseq_event *ev = &current->rseq.event;
>>> +
>>> +	if (IS_ENABLED(CONFIG_DEBUG_RSEQ))
>>> +		WARN_ON_ONCE(ev->sched_switch);
>>
>> OK. Now I'm confused.
>>
>> It is perfectly legal to issue a system call from userspace as long
>> as it's not from within an rseq critical section.
>>
>> That system call can be scheduled out, and can set the ev->sched_switch.
>>
>> This would cause the rseq_exit_to_user_mode from system call to
>> hit this.
>>
>> What is disallowed is only issuing a system call from a rseq critical
>> section. The other parts of rseq (updates of cpu id and mm cid) still
>> have to happen when returning from a system call.
>>
>> What am I missing ?
> 
> The fact that any setting of ev->sched_switch has to be handled on the
> way out independent of user interrupt or not as MM CID can change
> obviously.
> 
> This is not any different from the state before this patch. Just that it
> now only looks at sched_switch instead of the full event as that might
> contain a set user_irq bit w/o sched_switch being set, no?

OK, so this is called after the events were handled, and this is just
a sanity check.

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> 
> Thanks,
> 
>          tglx
> 
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

