Return-Path: <linux-kernel+bounces-801362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC84B44433
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 19:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A72E16A88C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2BB304972;
	Thu,  4 Sep 2025 17:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Dv9WGyl5"
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022089.outbound.protection.outlook.com [40.107.193.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE991FDE01
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 17:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757006405; cv=fail; b=oft3V+Lu8q+raTOKDoU1Zo92MhMCYVJBY8TPM1/Wm1LUgMaM7R27ompPtwZY32baqB3PAuZ2tCH0Eg6swIIau2yQMJbudqu+r7Ydwr64UEolc3FjjGCmdQQtDM10OrtFyUTFCe6ofC+fqgkGM9+D0TJ1xK9HBsYH6g81Ff22wqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757006405; c=relaxed/simple;
	bh=tzA+utLLKkmFkl0FTYW5tUN9hnFO4BrrJXXomoZXNmM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lzRNNaP+hs10EJYTubPCpa3hlPUkstgN58KxoeUo9IdZ1+/WHLmr97d0p64bqjA6tjfhSAn/eJ2x/UMF9ppkT9SxT6Y7CKIpO9Xy2D6CDki8evX2Kqb3g6KGpyV8JixJ0iWLNufuwRlSsNnhvQDLg3cxlgZpMSMV1XHOXt0jVGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=Dv9WGyl5; arc=fail smtp.client-ip=40.107.193.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HxJD3W3ZXC+qf8CAbTGr/iGl6USMZk1SC6NxT0WBVYuEz1mVFLfY2Wj7mSBUMeNKkvT50MWvR6ODsMrqdR5e/1OFunjjPJFZIZdttbBQo6gd2GLJktwxjof0xj2fNDJNv9wi2+IKb9xCS4j+l6PDYsvfVOPj4r8jc+PTdcaviDXtnHLQTFJNEXl+JzjccwmkW3zjWRzDeS/qeCc+B+zKizzom9p0Y5psvrkb3NfA84w9EFYwFENza2cYLWSgZbPWM/7Aq3kCGixZNad8l3qvxZ96Nqfobz0pSljy556YdbUBfB0UB6Oqjq/Qjri65GmuQ0t4Usm/NY2p2iyOdMxWJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vPFF+Z4a1kOVnmUFWxFtTTkQbkuAq0XcKf5R4/7NTPg=;
 b=brjyCR76HoTeUUxxzVwnSUbBMNlLQi30G8XTZHauGIm6C4AKJWveFVTUG+aFideKyNrkNvMFAPkfUKkEpHYo2tQbUN0R/Eg90PR7x1IN7kTffgTbLVI/WPj1JoZ35/OWa27PmVYkuJR6I16Aknr+8SJFi36jfrzu/ayWl2VcLVMwEbrm6tU9lvPZjzVFZwugPgHU7t+WvAVvgqNsG87zt5CmLwKIKLdqI4OgQSGQy46K8EZsde7FHJAAzzaQjy5jCxJrxz5JHLx1ZmItTwbRiCo98w+vUK9akEInlj21YpSaAwh+e6kE/iPy8Y7TNg6NKcIP144Y+JqeNLug/6a2hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vPFF+Z4a1kOVnmUFWxFtTTkQbkuAq0XcKf5R4/7NTPg=;
 b=Dv9WGyl53hip86GVh130BX8D+9j+2ynWPMdp/uOa1tXa0nmhMKFndqkyLCkzvWp8CHel53JZy8gftMh9U8kTfrDyS2PqS4oEhH/vv6HD70x8vxAZf+Z1HjvJt35AaforPRHHCIkRdSTOR3l2MRwvaU+2wmjMko6var6lB4LfrvjEikDYaIkuLhhKi6hdA8vXFQPYpfxVI0cgMqg1Adfu27smzBGy0Waza2u9ZI4IfGVVxvE4Z76JU5PGY3qtI0uc/XkhHs5r3IVlWPP6Em7ikmfIkjsS+4drMv6StJwCCn/nM/5meG4zbSNHPPeHKL8LZ3tZeVP56/VHDKkKlxd0SQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR0101MB9232.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:60::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Thu, 4 Sep
 2025 17:19:58 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 17:19:58 +0000
Message-ID: <5d2ae241-a6ab-4cc4-b369-18860bdceb3c@efficios.com>
Date: Thu, 4 Sep 2025 13:19:54 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V2 06/37] rseq: Simplify the event notification
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
 <seanjc@google.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, x86@kernel.org,
 Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>
References: <20250823161326.635281786@linutronix.de>
 <20250823161653.644902433@linutronix.de>
 <9aa047e6-cea5-4f84-b763-36d8d5ad4731@efficios.com> <87plc90y9h.ffs@tglx>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <87plc90y9h.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQ1P288CA0015.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9e::13) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR0101MB9232:EE_
X-MS-Office365-Filtering-Correlation-Id: b7297f58-6082-4f03-325b-08ddebd745fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MjREcS9seHlFVUx1RVJKSHRFZ3RBK3VnQ3l1MUFIdURGVFBWTkU4cVhJVzEw?=
 =?utf-8?B?WmNaTytrL0Z0SjhSbmY0bjE5TlpkOFBsODJWZ1FMdTg2VjF4OFNZRjdqa2s5?=
 =?utf-8?B?Z096VjFMMjI5bk9ScnBseUZtTTZwZnRCYk9ZaThMdE90V0NjaDcxWGl1ZitB?=
 =?utf-8?B?Z1g0TDVyNXY5S2JkYll6WEpRK2x4a2ZNNHpweVJwM2Q1c0dpaGgyWEZHamM0?=
 =?utf-8?B?Y3huNlZZM0FUT1ROZndWQWN3anpDMnMzbS9tamNYdzdUWmJOWDMyU3plUjlQ?=
 =?utf-8?B?QTQrMFB1ZnIwUFR2cDdXTEtteDIyampVb0x4L1psWk90WkROUFg0bW1FY1Zz?=
 =?utf-8?B?SktmYjdjTTE3VTdJclpucmR3SnNwQi9VQkpDZ2hKWHhZYjM3eEpBR2pMTXpw?=
 =?utf-8?B?cHd4Z3NFRUMwZFB5eTFJU2ZZcnhjWllDeDRLd1BGY0V1K0tXWnpSQWFyRkNh?=
 =?utf-8?B?K1ltTEFBZ0pKb2tMbHloY1AzQktMNzh0NDZxcEsyTmNyNFVjLzYxZmtXc2ll?=
 =?utf-8?B?Qm5KSlpZblplNWxlQXZtSGcvbjRidDlGOEUyNEMxY3lmZWFlZXRjbWF5cHlV?=
 =?utf-8?B?Q2c3eExzSituUm01V3QrQW90OHBTT3RROGhKeTB4TENSelNNMEI5dXl5TGpK?=
 =?utf-8?B?TmNjK1p6QnlPbDFFSEJkcE1ZSlJPU1Mzcyt5OXQ4MUgyTktBeVc3azRZcC9w?=
 =?utf-8?B?MWlLZm9lOVRzMGdhTDZTVHpXc3NMQkdIQnhEYjlTQUVDYzdzb3U3V2Y0M3Zq?=
 =?utf-8?B?cGZBRXFoUzEvRXdLUVNNdURtNVdVRUlYR05IQWU2cGRNOHZwMWxjazhPaVd5?=
 =?utf-8?B?cHY5S3dHaGlTZERKRnNWRXJQeDUzdzJIbGJPNFdJTmFBUGk0RjNsU3hOU1J0?=
 =?utf-8?B?WWp4TmlnVHZZZGVNWjdkWDE2alhBd3lWMnJubitVU2t1aG9sM1cvZk4wS3FE?=
 =?utf-8?B?M2hLZ0l4S1VJWllxdC8zZUR4eWk4anBhTWI1SzNIS3dxTEozbFNhdzdYUmRO?=
 =?utf-8?B?a2VEY05ESm5ETWxvbzVMc3FlNytId2htSnF1cEhKSGg2Z0tVMXFWTzBVTnFv?=
 =?utf-8?B?R0d5QmhLVXlkL2lUVUhjaHFpcUpDVk5wb09TNDZtQmpEWWQ4SE90aU9FOURY?=
 =?utf-8?B?aFhhOGttcWZYeThyVTdNK2FrUStYTldXaXZwaVd6bzBSVkNSQSs3NmFQbVNr?=
 =?utf-8?B?OE04Zjh4ZURXRmEva1h0QW9GcE5sbjZ1SUZ6WlhabTByQS8rZURaelk0Z2pE?=
 =?utf-8?B?bmpRTEc0NVU2NlpheGpKUE8zcjc0VlJaeWFodUdTTWVDZUEyOWZET0pvRjR5?=
 =?utf-8?B?RUZwazUxcFkvSzJDUEhiSExlZ2JvaWxwR2Jla0w4ZTh3djhtaTVQSUo4WTV2?=
 =?utf-8?B?K3hENFUyK21jOVNZNU5TMHNiNk5hcS90L294NU5SVlRHaWprMUwwZFRoNElr?=
 =?utf-8?B?RWRNazBnQ3dlQW5JS3ZydmhTR1VFdUxqcWFoQktpamZsM0x2VTdRWmZBU0ZH?=
 =?utf-8?B?L0NhbmhUSVA4aTlXZFJaQnY0bEZObXVCVllnWSs0RzNSeE9OdFV3NEMrOVY4?=
 =?utf-8?B?TEtJTmUwN09rUm0xV0NPSTFlcXFvVTNJMU5BbU83Y3ZvdW10NS9vNGdsaFdE?=
 =?utf-8?B?L0lWSEZOZXd3VmlFMGJVZVB6djBsaThoMG8rRXZuTGpuR3RNbHVqcUdTL0FQ?=
 =?utf-8?B?ank4NVpjYi9uTEJaa0ZMTFo1RExYQVdGbm1CY1RUNEdlYXZuakFvMnVZS1BT?=
 =?utf-8?B?a1Z2elJYUmlJQ0JxQTZvdUVmQW1KMk4zM0pmYjBrVGtmbmVPUGRSVyt1UHg2?=
 =?utf-8?Q?ZVKY2iocAyJGlf87u06wAxHOeqOia5ojLoRlI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NzgvY09LWnRMaDVNM3hYN2d4ZzUzU1MvSjAvNDNlNWpLempKZHJkSU5qNGR2?=
 =?utf-8?B?R1oreHVxUHZiRGF5Q3BXSGIyOHRhMU5uekhjV2hpLyt6N3B5N1FuK1BsNVpX?=
 =?utf-8?B?ejVqR08waFIvdmluZFZHK3NCRkZOdWIrRHN0MWpnWllRMVRFdmVzaXl1N0xs?=
 =?utf-8?B?Z1g3b3NHQzFFSnBsdTBSWXNZakxrL0ZWeUQyaXRSQ3FWRVBjZzdIVnJBRjVa?=
 =?utf-8?B?NnlHV3lLekpZcm9EZVk0TnQ0V1E1L3ZpbERBN0RTNDU5Ujd3azM2NUZNZENN?=
 =?utf-8?B?d1hmSWlhRXlGSERGaGRKMFV6a2NYbnQ4cWN6dVlCNkNFdlhhc1AyWFNMYmJR?=
 =?utf-8?B?MmNOai9Xd0M2eDBKNkhBOTU4U1lYT1FmVStiemFyK2taVFV2RFMvZkZ2bE9Y?=
 =?utf-8?B?enp1T0NkUE9NRWh5VHdmS200cjlZTGE3SXpodVBDcFZzOVBNdk1RRGZTbzNJ?=
 =?utf-8?B?NVl1WWJoT3o1Z1NaZnVnU1VTU29IUWFaNkJvU3RxdG03bVg2QWJxcFFHWFB1?=
 =?utf-8?B?ODlsemp1S3FpTDJtTjFrK0NRaWd1NE1mSHpES2lYWUZmb3JYQ0hkNmVnS2c0?=
 =?utf-8?B?a0U1TlRvRU5JOXhMODBBYjJhWUY0U21LSE5hVmJ6R21PS2xZcnQ0K2gveHlD?=
 =?utf-8?B?Q2UwbzJHYThsZHRVZzVSLzk3ZW1KQ1psSFJ3SVpuMGp1RE5RZjNUTXg0ZVhL?=
 =?utf-8?B?NklobkJUYy9FdVNkdVZpUk01MGVhUHRNenlpNnhUSERVRkthRlhZQmVsckl1?=
 =?utf-8?B?MGNJa285Q08zQ2VmOWRZK2hJZ2xIRkVLVTdzZ00zS1ZZWmFhSStaSURUajNC?=
 =?utf-8?B?czV6YkUrckhPbFViVTRtaHBxMVdpK2VPSDlMbU0vVk1ZRHJPMVlMbHM5dDFH?=
 =?utf-8?B?TnA2U3VXNEd2a3lnM1pPU2ZvbElxOGFJbGxBbTlOWmZKdWhXUlVuWnJld0FJ?=
 =?utf-8?B?U1FiWnhzN0l4U01OdStETXA5VGVmbFJkUlVQb1JsQkxSdE9wNmpiaGs0MjFw?=
 =?utf-8?B?bWRFbktFR1FPQzRkdVlDRnN1OUxWQThGOEw5S0ZFMlFSYlZISVQyOUFhWkp5?=
 =?utf-8?B?UldlMVRvcTZZdmFFWTBVdVhiOVlGQ28yNXM4Nlh4NENrSC80M1E5SStrbzZO?=
 =?utf-8?B?QmNHMlkvOS9CalRPeVhPK2hOYW9JTWdacEd1MDRWUjE1amRsbEtodUVUTVg3?=
 =?utf-8?B?TWJpeXlid2lOc3Y5c1hDVUpVNWN0eDJtZlJLZ3lYazZ1bzlZOEVRVWRJYTVx?=
 =?utf-8?B?TEhNQkNXdzl1UkhPOGFJa0pqcUozcFVRUTIrendhYlNuSUZTa3VDaEZwdzdu?=
 =?utf-8?B?L3pzazhQUEdmVFdHQStQMHMrR3FHQmdQdHdZcEd2QjIwWVhyR1A2R2xpN3pZ?=
 =?utf-8?B?OTVGWXJSS3QrRW9ycGxyczBndFhmdlF4Z1pvZXBsYlpMTlhMZDQrMjUxa1F5?=
 =?utf-8?B?ejJtbG9hWndOMHAzeGttUnhXcGxqRUJOUEdKOVJXS0d2WTJhRG1yNkRTRTRP?=
 =?utf-8?B?ZlRFaVpHL2NtS25iOXdXYU02TDQydUVhblNwNlJWc3MrQkNlL2Q3TkNBZEwz?=
 =?utf-8?B?NlFxTVRXR3UrdmpzZVR2L3NFbWt6ZlRTb0xKV3RjWkpTSDFmclVURWhQaG5Y?=
 =?utf-8?B?NDlMd0wwbVd5M0tpd3ZmZFg0RUo3em1od2VCMWswT3ptYkJxdXVrREdEUmJH?=
 =?utf-8?B?Qkx1ZERYVVp5RWpxenBpWFptSDFXWlM4OHpKdFBET1NKV2lpOHZDMk9PQzVz?=
 =?utf-8?B?WThiY2ZIUVQyUzdDZDJER2xzSXlzRXhjdks0bkRWVGU4R0VOYzhiNDc0RUVi?=
 =?utf-8?B?S1k1M0VjOU95bkpyakFyZ1N0d3JPeUtySkNLNTVWTUp6OXdUTEFtQnBNbmU2?=
 =?utf-8?B?WGxwVlR2UlVWdDlyMDFqcHdEbFAxdy8xTFdMMlpFRjQ3SUd3emNEUkFlQ2dj?=
 =?utf-8?B?a1F0SWxkcnFUMWZEZHpnbkZZNnBiTGgxc3N1Tmh3dnBNSEREekZmTWJ3eFBn?=
 =?utf-8?B?ZTRubHRyUm1ZN0prZDJsa3FKanEyd1Vna3NNWDZmNEJ1UW1LWER3SEtOZjN0?=
 =?utf-8?B?UHhvZmxock51NlVjSG1JWlUxU2orREVsUlhQbXRPTzZTSWRyWnliQXBUUHEv?=
 =?utf-8?B?eVEwdFQ0WU5zeHBDcGFraHl3WW5ZRVJNYng3RDRzSGxyMUlwbCtsMEVQYTBX?=
 =?utf-8?B?M1dpb2c2WEhjd29FWlRrdS9lenJIbURaWkNzZ254Y3NyTHJQOWd2a1Rydzl4?=
 =?utf-8?B?VUxBVEtGNVVFRFAydklEdnZwaW1nPT0=?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7297f58-6082-4f03-325b-08ddebd745fa
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 17:19:58.2458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eB4XJOc5ZC2gOjqMqAfpPdAsWCtf3ovXSwNQ7Q9rXvSIkKj1zDTYaznaW7rB7wg/cez/mLuLREQcwoknG33Up+jDa7RczmLr5xLvbzOdMwc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB9232

On 2025-09-02 09:39, Thomas Gleixner wrote:
> On Mon, Aug 25 2025 at 13:36, Mathieu Desnoyers wrote:
>> On 2025-08-23 12:39, Thomas Gleixner wrote:
>>> Since commit 0190e4198e47 ("rseq: Deprecate RSEQ_CS_FLAG_NO_RESTART_ON_*
>>> flags") the bits in task::rseq_event_mask are meaningless and just extra
>>> work in terms of setting them individually.
>>>
>>> Aside of that the only relevant point where an event has to be raised is
>>> context switch. Neither the CPU nor MM CID can change without going through
>>> a context switch.
>>
>> Note: we may want to include the numa node id field as well in this
>> list of fields.
> 
> What for? The node to CPU relationship is not magically changing, so you
> can't have a situation where the task stays on the same CPU and suddenly
> runs on a different node.

Good point. For the records, I suspect what I was confused about on the
powerpc side is that PAPR [1] allows the architecture to reconfigure
NUMA node to CPU mapping for virtualization use-cases, but AFAIU when
this happens the kernel will keep its own original mapping after the
CPUs were onlined at least once.

This would explain the purpose of the lparnumascore command that returns
a score estimating how much the kernel view of NUMA node to CPU mappings
differs from the current HW.

So AFAIU, from a kernel perspective, the NUMA node to CPU mapping is
invariant after it's been observed.

Out of curiosity, does the hwloc tool return the kernel's
CPU to node mapping as "logical" listing, and the PAPR CPU to node
mapping (which can change dynamically) as "physical" listing ?

[1] https://github.com/ibm-power-utilities/powerpc-utils

> 
>>> -	unsigned long rseq_event_mask;
>>> +	bool				rseq_event_pending;
>>
>> AFAIU, this rseq_event_pending field is now concurrently set from:
>>
>> - rseq_signal_deliver (without any preempt nor irqoff guard)
>> - rseq_sched_switch_event (with preemption disabled)
>>
>> Is it safe to concurrently store to a "bool" field within a structure
>> without any protection against concurrent stores ? Typically I've used
>> an integer field just to be on the safe side in that kind of situation.
>>
>> AFAIR, a bool type needs to be at least 1 byte. Do all architectures
>> supported by Linux have a single byte store instruction, or can we end
>> up incorrectly storing to other nearby fields ? (for instance, DEC
>> Alpha ?)
> 
> All architectures which support RSEQ do and I really don't care about
> ALPHA, which has other problems than that.

OK.

Thanks!

Mathieu

> 
> Thanks,
> 
>          tglx


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

