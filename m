Return-Path: <linux-kernel+bounces-814425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF8AB553F8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 17:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E42D91D64C1C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1FC315790;
	Fri, 12 Sep 2025 15:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="DteBoSUU"
Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021127.outbound.protection.outlook.com [40.107.192.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05273148BA
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 15:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757691856; cv=fail; b=qIB1LsICC8uMFWcP9EWDhrVXeYECzMlf6Ja0MN8hVcPDipPM2HQ2njr09dEtf2amh5Pkmmz8QLIUbaoYhpT1861KoRewhFxHKznNm/ZcUr5SHZU/hlGK2zEI2tIdK9WfWZEdvSirz6cT+v/3AHohP02yibtP3iU2IhFuwXGkbQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757691856; c=relaxed/simple;
	bh=dQenczGV1Qn+6mJwkmEOCbgNfh1Es0fmqIL1vEVnIGM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OfdBZMpMkkxAYxPdMQZ/xDSxQZ5fmk4MTlPVljBVUOFT9CPKyhVM2SWQNeZ8tsJxPFnZxMVB9NOBGym/Cp3/OkFLGzHLJ7sM4W2SsachpBnWE9r+Z1DX2NowQl+Xy3TvUqQgRC1qOnEbPYXGWhyVh6BHi0MWhcs8vwAdpl2DT98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=DteBoSUU; arc=fail smtp.client-ip=40.107.192.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iZ9a4TA0fDPNiAdwUY2PENI70X2a/fxcJAHuRB14Ijk3vSlxotV+rj3whgjPIDDY3WZizGb9A4FE0CuC/kMZhkHkQEc6rTra4JCSaB+nn95zK0QHTXWlqj3O9zZMXZ3MigVLrq1owxLVzFUrj7D+3Nvj8KbcAI8NQFNwjXeEW6NSzfNne2t6t5mx6pFKZGNaM1Mzy8e0N+f7yEN2nzxGnSgCyuv5pG+DP4Eveo11yzGqZQxn9OcujAVQYras0ZGnEdx5DFuPOIYSM9ZOsDXMzDxk/RqzmI+XfggTji/Y+F3JxURoaKx3mSRFHOeJW6USexwC8/7LoxNjA2AZzwCoPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yyMLPrSiHhcZEDplXFfMMYk+mWCvwSltsKmRs7+jWk8=;
 b=HHs/NXL2QuAN6F0laCHQSH3KGkyV4O203Psjx9tWmmdDvFhXQzPfr6jgW0evnCY9bLlWFykHxSudNb4jMq7P36PTkq8LB6gPuD96/mUADbGNLCOZDkSnYDVX97k9jxCEmOuFSqxMgUYYfod+NkcG1S2YkEp0VlnU/s/NMzDV9ltcqQYDr5NkUXyDfUav1QD7sLOHiQXwU8vxIukwxxo6K8kPL4WDs+1QttnhQZMxV5lRh6ypKKKwarhgoA7KxmaWgKo1WGlNgBVM6o1oIzIZJda+6NaDQ4Jc5eA/z8i0LifHz518cdmbwq7l6+fAS4yk+bEV4bgoWqzFwI5jGMn3PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yyMLPrSiHhcZEDplXFfMMYk+mWCvwSltsKmRs7+jWk8=;
 b=DteBoSUUYUHyCCezboTxGsec6THMPCHPC3+Us6aHF54pCnXf0Hjx8RGkxHYHQy8r9TbnZMAbbT9XxDa1daZWLs//7lVS1l0Skzxc0svAVq+XYePdc4yztzocWaskNQKgBQj1+qvKFqsxp84ZMoSB1/P5dlP8CANfYh6MfFdlo2sDqaqq4f16BA55xUc8e1ZxGuIZ7oSNo2asqMr5H5ocqxd2E+nmlGEmlh2hOj8o0YgqQH1gQW8egcKSQB1MDuhTXyvzr5LpfjjMLvBT6bUQvCj8+l89FG9GXzFo4DVuVEsGIpkgFPBCgfLWsJ4vdfUaCmBuweBTvjpEhvwbz0WoRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:a0::18)
 by YQBPR0101MB6539.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:4a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.18; Fri, 12 Sep
 2025 15:44:08 +0000
Received: from YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5ebf:cd84:eeab:fe31]) by YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5ebf:cd84:eeab:fe31%4]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 15:44:08 +0000
Message-ID: <9abc6246-2a90-44ea-b9ed-dd2d3c5440dc@efficios.com>
Date: Fri, 12 Sep 2025 11:44:05 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V4 28/36] rseq: Switch to fast path processing on exit to
 user
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
 <20250908212927.058801648@linutronix.de>
 <84d9beb2-85e7-4fc0-b403-0514bd87ae8b@efficios.com> <87v7lpq6l7.ffs@tglx>
 <cda37321-691d-47db-8b71-7a79dedb4bb6@efficios.com> <87frcrrbrx.ffs@tglx>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <87frcrrbrx.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0146.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::19) To YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:a0::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT3PR01MB9171:EE_|YQBPR0101MB6539:EE_
X-MS-Office365-Filtering-Correlation-Id: 69754009-60a2-4936-71fe-08ddf21335b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QzlKNmpWVnhlRnczVFdqQ09NTmx2Z3N0SnNJeUpBTnBBOEVTaHRtbkt3N2Rz?=
 =?utf-8?B?WVZtOEsrVysrMEFWMW9YWDNMeEhIRFVRdkxPQTdhU3FKRmtsa0F3ZW1BNzVl?=
 =?utf-8?B?ZHJOVms4eksyK0dhOCszekErdWtaZmRkWnhiRUE0VmlMajMybDhjMnJMc1Rq?=
 =?utf-8?B?TnQ2bG5TcytUenVPWGdpU21XdEJURWRra1hjTndjV0ZNQks3czh0VFF3SkdJ?=
 =?utf-8?B?Tk9oWENLd0NhdyszcmJ3NWFLMG1tVTM0SEdtaUNYR2U2RWk5aEpLeDhkNEtl?=
 =?utf-8?B?RCtFd1h6SklDKzlGd2hRR3luRjAvZ05rS2crbG5ZZUpYT25XTHgrM2c4bjQ0?=
 =?utf-8?B?d21vcDZqOHNBRTFDdlBnOEtBMWo3S2N4VEU3QW5vbm9WUWpFZU9pZ3lobTR3?=
 =?utf-8?B?OFFQc3loL1JwUzNzQ0UwNFlqT0F2ZTBIbHI3N1lqV1gwY1V2N3F2Tkt0R1Q3?=
 =?utf-8?B?bnNZT3RndmNJaUY5cE9TUnRQNTBrWWFKa3N6MUxxaTlHQURqSFUvTXFzU3VM?=
 =?utf-8?B?b0RiN0R3dFMzRWRVclk3UUloY2dlcVlIUnhXVWVXc21EYTcrL0NlZ25maXBw?=
 =?utf-8?B?dHp3TzRDM1FZNFE5ZlBEK3dHVk9NRGRRM3c4NXJRcU1MN2l2QW41cU1PQkFq?=
 =?utf-8?B?eVdNcENFZVEwT1M1NmRTT2R3eS9UY084ZkRWTHY3QW1xRTR4TkhVcitLem5l?=
 =?utf-8?B?Tm1sV09MS3N5Q1p6SUcyaEQzSnVvTHltSm82ODNZa05MSkR6dnFiZ3lBS1Rz?=
 =?utf-8?B?NUhkUVhGdTR5MjdJK2MybmRXRyt4K1ZPbGhsTXdPRjJSQnhUNTNsRWtlSHdT?=
 =?utf-8?B?ZnBzaVNKZFoyc0hjMUJ1WmVad1lkcFRPVGhRdnA2T1FsempPUkhMMmVuRzVp?=
 =?utf-8?B?ZDU2NzNCdDFKUkttRThZcjg5azloLzc4WGo1amNFSk5rNU1kVVVGWm9wTTVG?=
 =?utf-8?B?YVBNNGdidnJ5dHg0dHVoYzh4WGRERXgxU0pIL3NUQWFyQjQ4WEExbXo5WE1Z?=
 =?utf-8?B?REVkNGZJVVJRNW92Y2VSWXU4VDNJeHNza05Zak0wMzNpZ2piUG5lQ04yRU9L?=
 =?utf-8?B?OFZFSkZPTjVScThFKytwcktIeU5lV2EvS29DWE8vcS9QOEJRZWdmL2FlUkFI?=
 =?utf-8?B?c0kzeUVKb0p1aUgwRCs3cXFVWnVTUmdvNURNb3ExS0lIYzZyOW9WSFJsTmlF?=
 =?utf-8?B?d3lBSm1XTTYxb2I5bFY5M0pJV3doQTlESXIwWnNnQ2RJVEhMSTJDRnVmZ1FM?=
 =?utf-8?B?TVhEV2htQXRCak9RYm9ZYkZoNCtiMVJuaXpnamd4Q3hSc2dTU29xYWhKNjB5?=
 =?utf-8?B?Z0hBM3pqRG5vQms2ZWZwR1RCVFE1OXRzOVFMTVp2NnBBS1JTM1BjOGk2alBa?=
 =?utf-8?B?K01mUXVXcUZFN2FZRDVkbitZRmdxU3pWZy9ZTThtTGN2MjFLYW5oeThNVTEw?=
 =?utf-8?B?S3NRN1c2SFY1cmZZTkVuRjc5NFJzbE81UzhwMHgwNWNHNTRjQkw1UVJmTWZQ?=
 =?utf-8?B?bGphY2FQdEs2T1hpaUE3ZDQ2OSs0YjBJNFlIamthdXZOUU1DY1dkWFZMYlBQ?=
 =?utf-8?B?ODdveFN2dk9VSXZxOUs3TFEvcEU2cE1qdGRIVE9zS0VvcTdwUk9NQW5lcHB5?=
 =?utf-8?B?c1ZQWngvY01GazRucHlrd0lMK1RlMkRGRmJyVU5kQzFEQjYwVGQrRitweU1q?=
 =?utf-8?B?cHlDdDVlR2tsZEo1MUp1N3g2QUJYK3BZbEh4b3ZWTHRhV3JpR2dYWkxhN3Ns?=
 =?utf-8?B?bU9EQ1RYemV1b2xXNFphYW1vMWYySUpWWllYcFlVUlJ2QmkwbVBKRUNMdEJm?=
 =?utf-8?Q?EQ3qpRWOOKzVXiaQT0vnapzTf4YdKo1dFNfuU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TmVYY2xKOXVkRy9WSVA5d0Z5Y0dLMG1yWkVZWnZSbFZSR0pDRTFxVGlqWDNP?=
 =?utf-8?B?T2thK2xyWTZuU2N5Sy90dDE4czhsZlJIeTZ1M3A2VnVkSmdDM3lDeXY5blhz?=
 =?utf-8?B?aWFQRlRhczBEYklPb2FrYWZWbEp6QmptV0I0anpOSk9jL1F3ai92akF5YWxJ?=
 =?utf-8?B?Q1VRYVI0UW1sVFBRS1phaUFVWTVPZmFKNVcrVXZ3YXRWS2hsZ0VoT0E4NkVv?=
 =?utf-8?B?OVMrS2oxb3JzNnFYdFZUOUpzWmNXQVpaME1ZK24rSU5zcXZLeUtLSTduajgy?=
 =?utf-8?B?clROUmhWTVkyckNETW9rTUIxd3pXQUJmL0lKUkNEUXNTOEZSOWlpSXdsSEEy?=
 =?utf-8?B?Ly9qdGVGNm9KTnYvdjhGVTdBeCtrNHpPbGdtUDl1bDE3SSsrMDFKM2NFOU9I?=
 =?utf-8?B?NkUwYWVZMzRic3FldlFiajBZZTFLajg0bjRTSTNsMUd4QUtkeFdzTktESWlH?=
 =?utf-8?B?bjd0Y3R4ekVOZHl6QzM0SzF4S0tLamo4b0N0QUJGYmdZRmpIUlEzRzJ2VExB?=
 =?utf-8?B?VDkzd3NmdVUwVWl0K2lGZEdySkRIYTladkZrbk9ocGlKMVd6dldENExzRTBK?=
 =?utf-8?B?R09RdG1leXU2NXVDTkZMbWJ5bnFtN3ppTnUzeXRnODJhZzhDaUF4am5GOE82?=
 =?utf-8?B?ajFGR2MyRW55dkFuY3ZqZmIrMW15M0V0aWdNQ2FZN2NZUldHVXIzSjFaM2dN?=
 =?utf-8?B?Sit0cmZwU0FMMVVEc2RTcDR5OHkrd3NQN3NWVFQxT0ZJN3ZHWmdLN2hrK0xl?=
 =?utf-8?B?YVM3QVEzb2tBek5BNmIxb3dRc0pSV0dqNGlJeFBZOFpmMS9seVR4Tkcwd2dn?=
 =?utf-8?B?cmUxak9WV0NnNUl2aEhsTUczQmZIUnhRcWRpaTB1WHlLNkR1SlN2TFhHd1hQ?=
 =?utf-8?B?Qm1GeDc3c08rZXk2c0tTWldZQlhSdXZKeVA0WTBmYzlDY0lRdCtDdG9ySGRv?=
 =?utf-8?B?aXQrNUlGOE5tUE1DVzNnZHhRMlNEbmRxVGxnWHducVRKejB0SkhDZndnbVp0?=
 =?utf-8?B?amlENm83cE91eVZlNjBrcTNTbVY4UEF4V3hxMmpOWjh1OGMwcTRKbnVOeXBl?=
 =?utf-8?B?OURLcDdpMWRIczRZZjB4YWJFZi9RWGFZOEpuNWdWeEd6azNBMlluZ0VWYUkv?=
 =?utf-8?B?M3ZJZURSREh0QUhWZ0F1L0JrSXpaRnYwTWFieUVxck1SakJlUEFrSlZJanZ4?=
 =?utf-8?B?ellDQmlleDAyODhJQmp4eEVpTUd4UnFGVlZDZ2FaTUNpakhYampOcHhqMmJ1?=
 =?utf-8?B?dVRWUTlhZW9WODdkYm1ibFJsb1ZwODJ2MlM1Y09JQjNLbkFiVm5EZjdtQXl4?=
 =?utf-8?B?RTVZK1BGRE1rYStIeGVZZFMyOWI2czhpMnY3eExSYnAxTTBHbkJPajlJUzhw?=
 =?utf-8?B?MEpXaWN6ckl3aU9xUnRIeGFwOXIzcGpNRFRSTG5vanhldk1wU01la3NzSDMv?=
 =?utf-8?B?azRsK21IV2t3S0ZxUnhPV2FDeWRpd3VEZjhOOXBrdm5rNHhBM3BZMWlTSjBK?=
 =?utf-8?B?aGlWbVF6TDhmSnFmaGkzb2VmVkRUYWYxODNselgxaEZXQWp4MjB0RUtJOXB1?=
 =?utf-8?B?STVUVzZnbDh5YWN5LzhYQVp0V2NRYURQTmpnaU15WGNPU0dBdFg4NEttNlZU?=
 =?utf-8?B?WExLU1pLMmJnaXd6dE5CeE5CZnV1S000anhLekEzTWdFVWg0TkpxYjVqMGxY?=
 =?utf-8?B?dnhyYktNNVFCcHBNWm1pQjl4L2NwL0NNQTVnVWd4OHlsd0NaSmFldStxNlVH?=
 =?utf-8?B?M3FqMTRMTVJFczg0UldkbFVZR3ZFcGVHVmZqNTAyMkZpWEpXaE90Y0JyY01x?=
 =?utf-8?B?TkZ6QXRxRXRPMTVEbElxQ2Judy9HWitHS0VuenJmZlg5OHpLemhub0JJN0dV?=
 =?utf-8?B?UmJyUFJBOGluQldKaS9SclNjTEE0NjVwT3NvMUErUDFyOG1xSFhSSFpCN0Er?=
 =?utf-8?B?b2h5RHp6SC8wRG5ZcHQ5aGtXbkF1T3RUUHlSOVpWQ2xsUEJJc1VYV2tiY2Vm?=
 =?utf-8?B?NUZpcUtrdFVYL2wxOTBMQ3BTd24xNlNmOHlveFRVVWhsMDFvSENxN0JCL2N4?=
 =?utf-8?B?ejRJS0FhN3ZiZjArUUJvOGNyQ21XeG5lVG1CYWYxOXZYSXp4c0psbzBHVjdM?=
 =?utf-8?B?V1IvYnRPTXZlcmh4TFJkbE9lN3dZUHByVTY0Sm9NM2lXdHpFVWpUVmlHVm56?=
 =?utf-8?Q?YTHhyhCKGyl4MGRyEs6K5Sc=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69754009-60a2-4936-71fe-08ddf21335b7
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 15:44:07.8355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5LwUYKCBximkaZDsLmLAiDMmXPF0Rbdskl267Umq0BO0Ot1AI/B5gLahJyJxK2v+6RQrL0444IMDh2ZRba6+7sHoRnu2J1xIAUGOJvYpzkg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB6539

On 2025-09-12 10:22, Thomas Gleixner wrote:
> On Thu, Sep 11 2025 at 16:00, Mathieu Desnoyers wrote:
>> On 2025-09-11 12:47, Thomas Gleixner wrote:
>>> The only cases where this is not true, are when there is no capacity to
>>> do so or on UP or the parent was affine to a single CPU, which is what
>>> the child inherits.
>>
>> Wrong. See above.
> 
> Huch? You just confirmed what I was saying. It's not true for
> overcommit, i.e. there is no capacity to do place it on a different CPU
> right away.

I agree considering that being "in no capacity to do so" includes
the fact that no other CPU are immediately available to run it.
I misunderstood this as being a longer-term configuration constraint
rather than a transient thing.

> 
>>> the fault will happen in the fast path first, which means the exit code
>>> has to go another round through the work loop instead of forcing the
>>> fault right away on the first exit in the slowpath, where it can be
>>> actually resolved.
>>
>> I think you misunderstood my improvement suggestion: I do _not_
>> recommend that we pointlessly take the fast-path on fork, but rather
>> than we keep the cached cpu_cid value (from the parent) around to check
>> whether we actually need to store to userspace and take a page fault.
>> Based on this, we can choose whether we use the fast-path or go directly
>> to the slow-path.
> 
> That's not that trivial because you need extra an extra decision in the
> scheduler to take the slowpath based on information whether that's the
> first schedule and change after fork so the scheduler can set either
> TIF_RSEQ or NOTIFY along with the slowpath flag.
> 
> But that's just not worth it. So forcing the slowpath after fork seemed
> to be a sensible thing to do.

I agree that it may not be worth the complexity.

> 
> Anyway, I just took the numbers for a make -j128 build on a 64CPU
> systems again with the force removed. I have to correct my claim about
> vast majority for that case, but 69% of forked childs which fault in the
> TLS/RSEQ page before exit or exec is definitely not a small number.
> 
> The pattern, which brought me to actually force the slowpath
> unconditionally was:
> 
>    child()
>    ...
>    return to user:
> 
>      fast_path -> faults
>      slow_path -> faults and handles the fault
>      fast_path    (usually a NOOP, but not necessarily)
>      done
> 
> Though I'm not insisting on keeping the fork force slowpath mechanics.

I'm OK forcing the slowpath on return to user from fork, but the
comments justifying why we do this should be worded in more nuanced
terms with regards to the ratio of expected faults on fork and
variability with workloads.

That opens the door to further improvements in the future based on
additional metrics.

> 
> As we might eventually agree on, it depends on the workload and the
> state of the system, so the milage may vary pretty much.

Yes. I'm OK with just altering the comments and commit message
to a wording that is less absolute about the optimization choices
made here.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

