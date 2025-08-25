Return-Path: <linux-kernel+bounces-785348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F4BB34964
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 19:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8C165E6153
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 17:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27FC3054EE;
	Mon, 25 Aug 2025 17:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="tDMVb/aG"
Received: from CAN01-YQB-obe.outbound.protection.outlook.com (mail-yqbcan01on2108.outbound.protection.outlook.com [40.107.116.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B473074AA
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 17:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.116.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756144466; cv=fail; b=b6toze6BkHWtkIliZQW5io9nLjXulRtmLLSj8dUwFP2mXRZl3VfG4VtmIeB0NEAscqX3E6N3UCWDliBSIG+1CvmoyFTOGbJjxO6Pq5VAlPgnnSkArUJRq1XDrLQpgLbhc56Ueus4nkiTZWNFYSYI9g5xFBak2v6mefSDBea/XPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756144466; c=relaxed/simple;
	bh=LXfqPoLXyko3HLbPIRTO6//UR8bUd8/aZ/CRRzwE6cc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L2s+QzWGfxTbw02GY3lBjvVSQOa6AdSOI5Py0j8Y6WNqyYvsVQP6XNNs513yvOuYuE+RjAJmA4Sk6Uu3blJhgcHzn5WP8ClUtYmOoZeg3aGAHXvytkzijG1+eWvQNYpK92k9P1uxIPWSaNRQhMPZAFtO+VXYv86eh9XWRjTBvMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=tDMVb/aG; arc=fail smtp.client-ip=40.107.116.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A4abzPpYcaRTXtulXhFXfyT6kDFOhgD5JqMQDSe9KaJQOexCuTGoAc2mF9SsYzw9OwGpd6ZKn7o7oeoDzcBDFiVgIgAH4JI+E2qxwoNbBNXydBTnW3EYFsaoYT5/R2ox96dOH9NmpmQgNVRdkFTle4jMm+9xuDDjUM2FV9GRMCkWDMbVGtQDwZZf4bvNUYJweiWuLBkXzsEqrrxDzeylf9bWOxJ6mGKoIJuAa25vKxnZFpnv6hr+PfSVMe7AfAOW4A+y4MHy4RMr7k2tBVSa8ofUINts+B1Z+K2RG3R5p1b/VHOY3VLvotZPqow7kG3jpHWgNocZ1fBk6MukPu60Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zUvAzUZLg4k/FPTnmHlgUOHLZcEQgIw8AjZRlIzeAA0=;
 b=Tq4woQpjJ52MOZbDW/QElJq0yh72djCBPo0EhYmh7ZWrcJ0WgHNntK/Vwyqt+nvNDRB3M6t61DmTXuLz1nhJmVrd9WsWAPp5gIWElK3KDjCEn0ufsWjL89F7Aa/jDvwMItR/ZDcazOyBFhmNXbXDBhlFntnDTha7EfRJbAl+dlZX2FPT6K/8DTP0TS7i6cct5c1rqPBpQ+xIqAtHJHfM8KA8HdLnKaVZlGyw94bDj5K1x/0CGoWHaqZHbS2kA9aoaLZTJ0ihDcLdeAj+DM6w0cOLIFGSobv7M3RxgNgr2NAJI+prWSATpmzVoCEP6OWw8ON9GMAwxJnJFptabYmIzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zUvAzUZLg4k/FPTnmHlgUOHLZcEQgIw8AjZRlIzeAA0=;
 b=tDMVb/aGmU225jKbTVYpE512pHCCXIc64NF7bXk4EJzOgUSpMNXEOJkak30jiAxgTwL2Tei8SgcqO2EaKN4eHXlg0ywdyL7xftk3FuptEmMAxmo4vLAtH/kgXnS0GohzgcNAhy1nlg2qVzcukEn9x0octi2kPqtqteZCTn39fRJx/D3UTGpKpwUZ9a4xw1qgNPOfqxOzXV39l1l1Y0iJceO+8C9B4oT0wQ38+FjYMhUlBd1vkMOKLExIc5ZucFMSdeb1TBRp2SQpnigAVCx7CCq7SY8qPIme1+BbwiHk1BcubROn/CCbMtl4j2GtnqtrgI/dY3cy9v+SYxB5CpJAuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB5331.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:63::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 25 Aug
 2025 17:54:21 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9052.021; Mon, 25 Aug 2025
 17:54:21 +0000
Message-ID: <d8c69b7a-43ca-41b7-af8a-6eb1772c55a4@efficios.com>
Date: Mon, 25 Aug 2025 13:54:19 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V2 07/37] rseq, virt: Retrigger RSEQ after vcpu_run()
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 x86@kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>
References: <20250823161326.635281786@linutronix.de>
 <20250823161653.711118277@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250823161653.711118277@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8b::21) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB5331:EE_
X-MS-Office365-Filtering-Correlation-Id: b424d052-76c2-469c-401a-08dde4006b65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q2Yxdi9EaTVIZTFCLzNQMW9jMUVkdE1BUlVsNzVoRmcwekNidmpyNFIzZUR3?=
 =?utf-8?B?cjhpQVN0M1VteGVDZXdMVTdWQjZUN2tFaXRMZkFjYVNNTHB3UE1jaDBQeHR6?=
 =?utf-8?B?THdpa2dIdncyV0hqazE0VktTNGIxNVdFMzNZb0hFOU9vVXkyS0Zza2RJdm1k?=
 =?utf-8?B?c0lMVjZXem5nTGo2dkEyeStsbW1PdmlLWUlPbDF3bFltQzRldGhNQ1J5WmNt?=
 =?utf-8?B?REtTb0MrNGlGNGZFNHU5OUNKTTl1YXd2NTllWkV2N1FSSElIMjYxc3UvSm1i?=
 =?utf-8?B?blQvMkt1aXArM2s4cVJ1bGVvekFZVlFBa0pKY1pDa0RDc3hXMDA2cmM4RWU1?=
 =?utf-8?B?ODNHZm5KMUJpbzlPdktvMTBDTTJldC9YUGdJUFQzempGblJJbXRlcnM1Z3VM?=
 =?utf-8?B?U0p3T2VXL0V2MmMvWjJhZnNPcHNqOVUxTDN1SXh4cFJyRGhaU3crNTRpeGlV?=
 =?utf-8?B?M0t5UjZHWTRRTHdNQitLanVPd2lZM05FekFHUWY1L0NqemVISWdPNWE1TTFa?=
 =?utf-8?B?NWFOUUdyQytWbnpGb0VmWEJvalBTK3dlYWNlMUNlQ1Fmd2lCUnFKT2pKeEVw?=
 =?utf-8?B?SndGVm56S0xSL3ZzTmdSTDZsL3VmdGkzN01aS2RXNm5rdFRWTUY5eld6ZWtE?=
 =?utf-8?B?elVKNE9WWTZnSDBhQUpadXhpRTZMMjhLVEJWMmZTcVNsbEZJSEJxRVVPWlRY?=
 =?utf-8?B?aWtkbmdBb3BsWnZUbnBBaEVWMlN1UTYxUEYyaytuTEYrdWIreGJvamtuY2N0?=
 =?utf-8?B?SjIyejhIWklRd0JkWmI3Z28wb2s0WW9XVjVoTGpYbDZrR1ZtUnkrVWNUQmpX?=
 =?utf-8?B?UHNqL0xWNzQ5VVNidlNqcHBBem9pYWZwb0ZCeGpqci9OV2I4OUdBSTVRWXpr?=
 =?utf-8?B?NU5lM1RBY09rS1lvMERnV0FyNlNMNFJiNUR6cCtUeVZpS1JuQTlnbC8rWVBH?=
 =?utf-8?B?RmdMa2Z4ejg5RVlNMWVLUWRiWUUyZlF3TzFNYU1UOVNYNVRsRFVtMWRqR1lZ?=
 =?utf-8?B?SVFtVGQ1aU5mMmtZUWVKRUV0MXFQQWtVdTQzNURqUEE3OWtYbzZ0b1RXWE5S?=
 =?utf-8?B?aU1mM25nbDRIaktwbUhkNW9vTFh2aHBYek5XNEtNdGhnVGVveHpSR2NXdlNW?=
 =?utf-8?B?YzgvRHgwM3EwajN1bkczblBTdDhKZVJJOGgxVFNWek9TR1htV0xKbFFpeW1j?=
 =?utf-8?B?VE9oMHlFajRxSUJuejJBUjZaclpJRGxXR1NxeXo4NjRBaXVCWEczVGJCUkZu?=
 =?utf-8?B?c3d6c0h5QjduTTZsbVBuUnB6dEVEYnNwVXVtMGp2NnVrY3RTSHk0alg1ajNm?=
 =?utf-8?B?ME02eDBVRGF3ZCtEQnlQZllxVVZWRGZZZFQ0WjloZzNMSkxoOUtSbzduTlZB?=
 =?utf-8?B?M0FpdjhoeitmcXlqdEQ4aXJCWlVxUHhORW1BeHFJcG16VFdlNEdQbXBvVnZZ?=
 =?utf-8?B?anliTm9QYTJ0WDZvUWZtSTlmdWM5T2g2Z3pPTjJzSU9USmN5SWZiMitXWlBK?=
 =?utf-8?B?bnk4R1RpaGhNQTJuNEkvVk9uY2w1UFh0SHZkM2RZcHRic3duL2QyMkJrWEk3?=
 =?utf-8?B?dk0yUzlQeGVzdzNhL2J0R0YyQmhxS2F1RjE2VEZBRFhSbVJyS21xQnZsUXU5?=
 =?utf-8?B?R2NKL2JrQk5jT2RoVTdYemdoTmpPTExkN3pNQkpoYnQwbnQvT2t3UWhxSWor?=
 =?utf-8?B?dThVa3BLWjc2VEtZOFI2bDcyS3ljQVk5RGltaWwxNlpCZThoamtJbHl2TSs0?=
 =?utf-8?B?RFlERTZTU3NGbEdrelc1azFyTjNkZG1aTVg4aHpPZHBKWEZHYkNUME1yRmMz?=
 =?utf-8?Q?AZx0TNpxHRgr/iJuJvQK1StLHZmHTmrsyhduc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDlzdHVtSFRtcXRLQUU1eHlsTUYrRUZZWTBybE9vdCtscXY0S21PVFRsL0pI?=
 =?utf-8?B?bWxGMWRhNC9iMVRuSGhqRTdMY29BV3FYc2R2S2RCNGZ0N0s4bGNPVGM0bElw?=
 =?utf-8?B?RmJaSS9taHRCYVN0WFpzdmxIdEtVanBJa1JuQ0ZCOWJHbnQwTFlXRHhnUmxR?=
 =?utf-8?B?SHJNcldYd1JnWS9QZnpxZnZDZFdRQ21UVFZmTG5ITmE4QnZlVGRPZnFQRkFF?=
 =?utf-8?B?QWRjb3hLNzExalJjZ0FTb3BLeGo4Qnd2SmxPVU95cXl5MW5HYlo0TnJ1NVUw?=
 =?utf-8?B?VHphbWI5bEFEWDlvc0ZveGZaT2VGeitpSko3cXRPRlhSVm1TbSs4VW5QdTVl?=
 =?utf-8?B?R0hnUkRLQURYSkRrVWFOVmx0UUNUT1VhazVOOThRTE54REJuNCtCZHI1dUdV?=
 =?utf-8?B?ZUI3UCtWNzJKc0xoYm5SVkJKVjJ1aDhTSEdHMnFmbldreGJDM3l0WXFFV1Er?=
 =?utf-8?B?OTk5Z1VnUkNSQmNxM2hsZ1FZM2VUdStjaGdDd28rYkh1T1BNby9xcWxjNEM3?=
 =?utf-8?B?THpJdTl6TGtrWXUzY1JLUXlKQ2FTQ3hiek9MY3N5YzNRbUZ2MU9IUS9USEdQ?=
 =?utf-8?B?dlBmN09Nd3JjVkJhRmhSTG1JV3lNNG1wZHZKcSs2c253QkJCNUlIVnVpdlVJ?=
 =?utf-8?B?RXRiY2tIQ2FzOUFOTXBPT1BiK0xDcExHWHlFcXJHb2phR0tWSHIrRXZoMDhu?=
 =?utf-8?B?bitENTR5eWUzbFlQcGZxek5VY0Y5dGcxZkZoN2tmMFpVbk9NWGdyakN2Z0Fl?=
 =?utf-8?B?VXFCckFOZ0NZMmRaWnR4R0NsalhkTk1LbXNReGxNblVDYnJjek9VYmwwb0Z3?=
 =?utf-8?B?a29tK2pWMDdkZkhJT2xvNTNuK1BaVE41RzhDTjVpRG1kQUxld2haMTNVUGcz?=
 =?utf-8?B?YlVYQ28zNWtpSU1NS2hCYmdwQUdjMUR1N3dUTDZtOFBpYWN6L2dtczRHdFBL?=
 =?utf-8?B?NW9JK0FFekl5NlF5OHpWY3A5bnc0UlpsMElPQWtianplU2N5T1NSQ2ttemIr?=
 =?utf-8?B?aVFyS2NKWTM2T0hqaWtBT3dJSEZQUDFmcnN5QitJaXhFek5xekhjQTJTL09O?=
 =?utf-8?B?ZzlpVjJtQ3lhNVZsR2VpWVk5blNOclFsdlhIYkJ1YThlV2tGUTVvaHVzWWI0?=
 =?utf-8?B?MzBLU0dQbXFkeTJaWnlIM0MvQlpYVlloRHA1UFFhOUFLWW02V0t5di9iZ0dH?=
 =?utf-8?B?c1JEYWc3b2Jnb2NwQnhtNVFxeWx3bWduMVNaNzhlVGh0Q0h0UHIyK3RueTVP?=
 =?utf-8?B?ZWRRT2YrNDM5UHZvcVowZVVsVnVKMVFPVmpWTUlMajN5bHVHSi8yMkVtdUdL?=
 =?utf-8?B?NW5ENHlJcUVjKzRmdWhqWWxIUUphRGMrRVdMTDdlVzE3Zkd2WXBxb2hnVmtC?=
 =?utf-8?B?Zy9xS2ZodzNaSHkybFcrelZCbFV1d2tUeTJBS2xoeTNWTk5MVGdKS2ZMYnB4?=
 =?utf-8?B?YWE0WnQ1enE2emlLY0c3SGhBbG1qOXBVVXVUNytscmJ0Yi9pNGhPVnQrbGd0?=
 =?utf-8?B?M2dqSWpVNy8rcXZsckVmcmxBSTZEd2VGZTFOanBGZGd3OXc5cmVFRGpmK2pZ?=
 =?utf-8?B?d2dVdVpUN3U4aXZUaTdFeUl2bTZsa3p3QnkvZWZldk16NzhwUW5RYnhwcUpx?=
 =?utf-8?B?MHZiU0luN2d3SlNGOTFabzBDTHFLaE1VZmFLWUI2OU5leEEvS2ZuUDJQRjVz?=
 =?utf-8?B?YjZ0ZE9tRXE5TnR2ZDh5Zmx4WjBXcklKd1lEdHVKR2tCTkJtMno3Z1MxNTVJ?=
 =?utf-8?B?Q0NLbmtMWmZRR3hDY1MvMFhjZ3ovRytFQ1drdGhGWHpsbnN6dFhwRTlQN1RW?=
 =?utf-8?B?M3VpQkJiZVdHMk1GZFNTM2lkaGFCQXJseno5dThnV0RUTVRFeTlHTHU4S3Zm?=
 =?utf-8?B?NERlNS9NL1QvVExMQTZORmJ5RU16aDhpdEE5SncwRFpONUFYWStVNWRUT1la?=
 =?utf-8?B?UjZPVk04d2VCN1BTU1RDMkpXVE05K21GQjdZUnJPdjBqU1h4WVRiS3pWVEdH?=
 =?utf-8?B?czhYdGoyYkxVaTlsY0dSUnM5QTJxamZGL1J0Q2F4emNtSU95djh1dDkyc3d1?=
 =?utf-8?B?OGNSN1R0cHNST3ZPOWpyaUg1UmM4cHFGcmtXZ2F3blBIZmRiMjRnQTd3dnYr?=
 =?utf-8?B?RzROZXVZWmFmaUNjL1pPTitCL3owbjFNemxpdjFabHNYYmFreDFPWWNpSVp1?=
 =?utf-8?Q?odf1j+Nxzr/DGvmk9U3FDdI=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b424d052-76c2-469c-401a-08dde4006b65
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 17:54:21.0565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YjARYoX8WTGfe3PkdpbSByvtYP7f39H7v8m0JsopPz1sQloWJoCpymEORqYC0TimOdpDL3VVWABS7FSA1GZzIM8Gb8/vpBfo4TbfI6Q/Lrw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB5331

On 2025-08-23 12:39, Thomas Gleixner wrote:
> Hypervisors invoke resume_user_mode_work() before entering the guest, which
> clears TIF_NOTIFY_RESUME. The @regs argument is NULL as there is no user
> space context available to them, so the rseq notify handler skips
> inspecting the critical section, but updates the CPU/MM CID values
> unconditionally so that the eventual pending rseq event is not lost on the
> way to user space.
> 
> This is a pointless exercise as the task might be rescheduled before
> actually returning to user space and it creates unnecessary work in the
> vcpu_run() loops.

One question here: AFAIU, this removes the updates to the cpu_id_start,
cpu_id, mm_cid, and node_id fields on exit to virt usermode. This means
that while the virt guest is running in usermode, the host hypervisor
process has stale rseq fields, until it eventually returns to the
hypervisor's host userspace (from ioctl).

Considering the rseq uapi documentation, this should not matter.
Each of those fields have this statement:

"This field should only be read by the thread which registered this data
structure."

I can however think of use-cases for reading the rseq fields from other
hypervisor threads to figure out information about thread placement.
Doing so would however go against the documented uapi.

I'd rather ask whether anyone is misusing this uapi in that way before
going ahead with the change, just to prevent surprises.

I'm OK with the re-trigger of rseq, as it does indeed appear to fix
an issue, but I'm concerned about the ABI impact of skipping the
rseq_update_cpu_node_id() on return to virt userspace.

Thoughts ?

Thanks,

Mathieu

> 
> It's way more efficient to ignore that invocation based on @regs == NULL
> and let the hypervisors re-raise TIF_NOTIFY_RESUME after returning from the
> vcpu_run() loop before returning from the ioctl().
> 
> This ensures that a pending RSEQ update is not lost and the IDs are updated
> before returning to user space.
> 
> Once the RSEQ handling is decoupled from TIF_NOTIFY_RESUME, this turns into
> a NOOP.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Cc: Dexuan Cui <decui@microsoft.com>
> ---
>   drivers/hv/mshv_root_main.c |    2 +
>   include/linux/rseq.h        |   17 +++++++++
>   kernel/rseq.c               |   76 +++++++++++++++++++++++---------------------
>   virt/kvm/kvm_main.c         |    3 +
>   4 files changed, 62 insertions(+), 36 deletions(-)
> 
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -585,6 +585,8 @@ static long mshv_run_vp_with_root_schedu
>   		}
>   	} while (!vp->run.flags.intercept_suspend);
>   
> +	rseq_virt_userspace_exit();
> +
>   	return ret;
>   }
>   
> --- a/include/linux/rseq.h
> +++ b/include/linux/rseq.h
> @@ -38,6 +38,22 @@ static __always_inline void rseq_exit_to
>   }
>   
>   /*
> + * KVM/HYPERV invoke resume_user_mode_work() before entering guest mode,
> + * which clears TIF_NOTIFY_RESUME. To avoid updating user space RSEQ in
> + * that case just to do it eventually again before returning to user space,
> + * the entry resume_user_mode_work() invocation is ignored as the register
> + * argument is NULL.
> + *
> + * After returning from guest mode, they have to invoke this function to
> + * re-raise TIF_NOTIFY_RESUME if necessary.
> + */
> +static inline void rseq_virt_userspace_exit(void)
> +{
> +	if (current->rseq_event_pending)
> +		set_tsk_thread_flag(current, TIF_NOTIFY_RESUME);
> +}
> +
> +/*
>    * If parent process has a registered restartable sequences area, the
>    * child inherits. Unregister rseq for a clone with CLONE_VM set.
>    */
> @@ -68,6 +84,7 @@ static inline void rseq_execve(struct ta
>   static inline void rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs) { }
>   static inline void rseq_signal_deliver(struct ksignal *ksig, struct pt_regs *regs) { }
>   static inline void rseq_sched_switch_event(struct task_struct *t) { }
> +static inline void rseq_virt_userspace_exit(void) { }
>   static inline void rseq_fork(struct task_struct *t, unsigned long clone_flags) { }
>   static inline void rseq_execve(struct task_struct *t) { }
>   static inline void rseq_exit_to_user_mode(void) { }
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -422,50 +422,54 @@ void __rseq_handle_notify_resume(struct
>   {
>   	struct task_struct *t = current;
>   	int ret, sig;
> +	bool event;
> +
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
> +	 */
> +	if (!regs)
> +		return;
>   
>   	if (unlikely(t->flags & PF_EXITING))
>   		return;
>   
>   	/*
> -	 * If invoked from hypervisors or IO-URING, then @regs is a NULL
> -	 * pointer, so fixup cannot be done. If the syscall which led to
> -	 * this invocation was invoked inside a critical section, then it
> -	 * will either end up in this code again or a possible violation of
> -	 * a syscall inside a critical region can only be detected by the
> -	 * debug code in rseq_syscall() in a debug enabled kernel.
> +	 * Read and clear the event pending bit first. If the task
> +	 * was not preempted or migrated or a signal is on the way,
> +	 * there is no point in doing any of the heavy lifting here
> +	 * on production kernels. In that case TIF_NOTIFY_RESUME
> +	 * was raised by some other functionality.
> +	 *
> +	 * This is correct because the read/clear operation is
> +	 * guarded against scheduler preemption, which makes it CPU
> +	 * local atomic. If the task is preempted right after
> +	 * re-enabling preemption then TIF_NOTIFY_RESUME is set
> +	 * again and this function is invoked another time _before_
> +	 * the task is able to return to user mode.
> +	 *
> +	 * On a debug kernel, invoke the fixup code unconditionally
> +	 * with the result handed in to allow the detection of
> +	 * inconsistencies.
>   	 */
> -	if (regs) {
> -		/*
> -		 * Read and clear the event pending bit first. If the task
> -		 * was not preempted or migrated or a signal is on the way,
> -		 * there is no point in doing any of the heavy lifting here
> -		 * on production kernels. In that case TIF_NOTIFY_RESUME
> -		 * was raised by some other functionality.
> -		 *
> -		 * This is correct because the read/clear operation is
> -		 * guarded against scheduler preemption, which makes it CPU
> -		 * local atomic. If the task is preempted right after
> -		 * re-enabling preemption then TIF_NOTIFY_RESUME is set
> -		 * again and this function is invoked another time _before_
> -		 * the task is able to return to user mode.
> -		 *
> -		 * On a debug kernel, invoke the fixup code unconditionally
> -		 * with the result handed in to allow the detection of
> -		 * inconsistencies.
> -		 */
> -		bool event;
> -
> -		scoped_guard(RSEQ_EVENT_GUARD) {
> -			event = t->rseq_event_pending;
> -			t->rseq_event_pending = false;
> -		}
> +	scoped_guard(RSEQ_EVENT_GUARD) {
> +		event = t->rseq_event_pending;
> +		t->rseq_event_pending = false;
> +	}
>   
> -		if (IS_ENABLED(CONFIG_DEBUG_RSEQ) || event) {
> -			ret = rseq_ip_fixup(regs, event);
> -			if (unlikely(ret < 0))
> -				goto error;
> -		}
> +	if (IS_ENABLED(CONFIG_DEBUG_RSEQ) || event) {
> +		ret = rseq_ip_fixup(regs, event);
> +		if (unlikely(ret < 0))
> +			goto error;
>   	}
> +
>   	if (unlikely(rseq_update_cpu_node_id(t)))
>   		goto error;
>   	return;
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -49,6 +49,7 @@
>   #include <linux/lockdep.h>
>   #include <linux/kthread.h>
>   #include <linux/suspend.h>
> +#include <linux/rseq.h>
>   
>   #include <asm/processor.h>
>   #include <asm/ioctl.h>
> @@ -4466,6 +4467,8 @@ static long kvm_vcpu_ioctl(struct file *
>   		r = kvm_arch_vcpu_ioctl_run(vcpu);
>   		vcpu->wants_to_run = false;
>   
> +		rseq_virt_userspace_exit();
> +
>   		trace_kvm_userspace_exit(vcpu->run->exit_reason, r);
>   		break;
>   	}
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

