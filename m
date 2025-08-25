Return-Path: <linux-kernel+bounces-785382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8185B349DB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 20:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC3D8189EC68
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 18:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE2725949A;
	Mon, 25 Aug 2025 18:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="NGIwgKcs"
Received: from CAN01-YQB-obe.outbound.protection.outlook.com (mail-yqbcan01on2130.outbound.protection.outlook.com [40.107.116.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0D12FD7D7
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 18:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.116.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756145504; cv=fail; b=CqKTCwDvM2RrNrMn8wS3M54NiK/FrDelBUAKk5QGEWuZH5sGtImLE+JSkLAYeVXkpqrkSLgev6WnBJXTEPEubqwixQMIPttv8cB4Pz6btxGD8LeD5hU3Zmy9grXVx2C1AGmEOFeArbRok1IHkr4VOUZH7sHRqXyKOXs3dBv6bOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756145504; c=relaxed/simple;
	bh=WF2ahvMKvcOI+4OVWB+9updMll2BNZ2o/dvLTI0tQqk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Vb7p+SBXBjvxFsMHo5msbyqzFy18GjimAYtAjPYOQHJ+ZN/fELDl8xeqYrpkQFrpPEttrngmmKGcOfhxoqBqsNbunwRhEgjQoEAUKU+RrZjEtIJtca/EP9ANbtdmBrEXfF/xE/RWL0G/3RjyJEEoAcs2wwH6yQbzxD8cEHc4Hk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=NGIwgKcs; arc=fail smtp.client-ip=40.107.116.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bc5M1d67XIWRuYG6cn77FODHetO2MfXCo4UcLNmgpLUzD1EYp1PuaUSNxiMT/ciEZ//PUNDvIybE7Yjp1EEMy1fRz+AqvV0mQghO2G7ONje9ruvmkLhlwLOuWW+WZruZQbHbR7XIRI/x8ZGaSg++oxAfc+cUWXrOpKhj6cdToP3o1jdCYoO9UjFrr2ycvbWpFiH+Ahn58KEBUJ+FhMVaD8oR83N75X4lYaRK/hortbdSKiQye0DkPA1RI++ItK45cDgH6+tGM3acNmG4ckvozDt2isIVBsQsL2CEhkvSVSXC2C/ZA8c1hYbCp3dvsQZvDHwu/YP3DbqYfDYl9TwOYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xvz+iYoAXmvJf8uCm5qDVjZOriCyK/nG9dFiHL+hHmA=;
 b=qbKYDJEt933thw/kvqMSr9nC/GlamZ3/ehK47uau4UaotQvKQKaMEBrEVBDBThSDnnQmzmBfnDrTnvmclRg09RDVDS3JH9qBi8FghyuPRvZ0o6Sij+UM30MWo1gL+K+T/hTZnqgi6fuKGnJAUUoDQcn7D4gs8MvAkDdT8tu/fYR8Ygd6Xbnd/F23AV04hO5ZYkM2K/Gw08ad6sePx14CoXFZZMXkWegqzy03RYPUp1GSFdvZhnIZJ6DVZggkm1iWXhghOZDpAsx6tKjof3/YvDyGZ9piKg92/Ht6aaf5YoXuBI5RxIzHZaywmSmp7VvXCkjRXoqfmxShsSRY8DTwpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xvz+iYoAXmvJf8uCm5qDVjZOriCyK/nG9dFiHL+hHmA=;
 b=NGIwgKcsYTnd8vuz2hOy0jk7hq0EA6Nzt679NXywkdLv/RO1bquywqqmBjDp/K8amUace0WK9pWVuNt1yFk/tvieoq/xBsjr7DKioiUiDunuEgICF6R4TdtKUXMFgrEpCZ0xjFlY5pOM985rAv1tbbBRrTgwbXBDm9P4Zo14DY+YQZxtuZU9jA9SFzqTv5wXqSysIPkN5e8Kthyh2xo/vv4uI9DLINDGITjNUaxjh4/WshWgnhEDofUZD0yyp3ErjOBupv1SBfDzNJkAYmxtbQiaFBcNWppTGtznRt0oYGEG5kUcTzxdpf63NobQacxooE66AW086JBSOjEX/jRGRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB6405.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:70::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Mon, 25 Aug
 2025 18:11:39 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9052.021; Mon, 25 Aug 2025
 18:11:38 +0000
Message-ID: <9a94b9d4-708c-476a-bf7d-7deb1c14f1ac@efficios.com>
Date: Mon, 25 Aug 2025 14:11:37 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V2 09/37] rseq: Introduce struct rseq_event
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
 <20250823161653.843757955@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250823161653.843757955@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0129.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::20) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB6405:EE_
X-MS-Office365-Filtering-Correlation-Id: ff4a34dd-95e0-4ee2-333b-08dde402d5f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R2JvUzFrQkVEUUlidjZkT1ovVkV6RUJSWk9YcnM0Qkh1SW85bmJESWYxejNM?=
 =?utf-8?B?UmtzSUROMlM5R2ErYS9BQ0ErVStZV2dSLzJkNGk3OWlSWlByVmR6WVZaQmNE?=
 =?utf-8?B?WXJLeUIxSG1KU2NoZUliVm0vMkMzWERrVmlUeGxGWnZtZGNVL3F6U21VaWZs?=
 =?utf-8?B?QUs2MUJUblFid05aWHVUMi9id25TemR4WWtGeVd1WGRjQUpoNXpZZlFhbVFZ?=
 =?utf-8?B?VnBvUmsrUldaYm1HajdPWHN6aEwxZDd4K1lRMWo2WmJhUFA5WTlMdy9MOStD?=
 =?utf-8?B?enBrRkRvZExFbCtONkFQUmFudksrc1YzUzEzZWVSYm11RjF4QkQzN3ZtbWlU?=
 =?utf-8?B?eGQycWEyTEhLcDFuUmorY2NvTXFZR0V4a3F1S3p6UDBDMmYxd1Y3Wm1OV0pj?=
 =?utf-8?B?SEIrZkN0TFJrejZMeUZUTE5DQ05mZHlSazVxV011SVc4dmYzZ1VpTFluSUZa?=
 =?utf-8?B?Y2VUeUpFYWhVQUZWUFRmb2pObjBOZVNRVlhlVStBeFJ3ekpvcW0wcjV2eDJV?=
 =?utf-8?B?YS9xK0lvZjRWQWZ0VVg2ai9yMVpXRzdWTi9HZTVQVEZIRlgwc1gzQmt0dmxr?=
 =?utf-8?B?SGZzSzBPTlNHZWJ6aFFOTnpFN2FsSU1HR3IwM2h0WFc4RG5LMzhCQURhbUhK?=
 =?utf-8?B?eHY4Wi9IbzdEcnNNeGNiZ0pEM3ppc1I4eXI3NlN3TTlzaHBDQlluWGpuY2RI?=
 =?utf-8?B?bG43Vk1yc1JWQ0tjR2l5am5GK1lORjE0dm9wVExaUFRKaXI2c2d3TUNrWDdD?=
 =?utf-8?B?UzRvem1la09wVnN4UjAvQ01ZelovK2tMUEprRlAyY005SE1vYTlIcVhRQWlT?=
 =?utf-8?B?dS9HNE1OdlVleU00NkQ0RklUTXdFd1lGYy9aaGFxc2poS2E2THg4VmthU0U3?=
 =?utf-8?B?RWFCWTFmdjZMenl4WFY0VWtiNkpVdUNUOGZNU2gyT09XRWlkeG1MRGRGSnJO?=
 =?utf-8?B?WGNiL3haNzNIUTd5bGpVOTZBeGVRZGNHaHJtY25Yc3RyQTVSa1lldmFRMVhw?=
 =?utf-8?B?UW4zNzgzOFRjNlBnNmdialk2T2FtR0NRMi9mRU00cC9UVExldE5iZmdpaWVC?=
 =?utf-8?B?a1VOb2ZQV0h2NTBwb3RpTFFDOElCSTJyQ1ZnZFhTeWJoZFlzMzRHeExSUU9S?=
 =?utf-8?B?a0FXNjlRTzdaNHJpMGVxaURLYlErSHRPYXU4R241cENsaUlHdUMrK21Yb29L?=
 =?utf-8?B?SHB6Vkp4Nk93M0JtMmJIcGUzN1VFcUNvOXloUDlQRmxqQUFPVCtiUysxVlND?=
 =?utf-8?B?NVhPNDV5bld4M09sTDdPdUd1aW1LcU9RQi8rVldJU21ZekM1b0twZ0NzMDl4?=
 =?utf-8?B?VDQ3eklhWWNMd3M3VFFhc1RqWHJVOTZVUzFVSlJyamZtTE5MTzZrUWlEMkgr?=
 =?utf-8?B?dXZMSFZsU0MvNndCK1Z2TTJ4amIxZnJpbFY1OU93S3JQUkFmc1YyWitHOUs1?=
 =?utf-8?B?U25heHlVZnN2M3NuOUNhMW5DTnVBWVgrREpZZklDczRrMFhqWmZFcFhMSVdw?=
 =?utf-8?B?SXJXbkk5a3ZadlRRSnFTL25OTHlBei9SK25SR0tWQmlxc016QWRpcXZXWkJy?=
 =?utf-8?B?VDBzcXhYc1FJdWpnNDdMR081RFRLa0ZhV3loOHRjMXQwcWlzdXA5OWVMZENS?=
 =?utf-8?B?Vi9VTTNyR1g4eW0vR1hNQ0FuTlBESGFoMDVkUmQzK2dwSFF3MmxjVkhqTlJx?=
 =?utf-8?B?MytXOVZNOXBQOFBXYnVHZEI0UkJqT2FzM2FPbHlBWlBOdFhKam5oY1poME13?=
 =?utf-8?B?VmhPQmJSQU5Rb2RhTHlVK0NPcHhhU0RadTBUcUdyUXdpeHFWVFpzOXZsODNq?=
 =?utf-8?Q?t/HVPQ0zmxEQCcB0NlMih8eEk/lsgtuOWfJvE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NEJGeHMyODdtelpVWDZTLzZVdHhlRm1UOXZzNllVbjlha2YvWmxzOHVEcWpQ?=
 =?utf-8?B?cHpSQzgyWnloR0RYbE52UHhHSGRXSjA2SnlzVWtvRWw3dWhPaXltMkxiRXVN?=
 =?utf-8?B?SnVxMzhPbXlWNWJDZXcxVWk0QmdabSthR1dMTktQT1R1U3BqNXgwODRXNmg2?=
 =?utf-8?B?eVozMVJyVzJhQmlrYWtJeTNwcTJZcmFhWExCVzJwUlFna0JlYlJycWRNdjcx?=
 =?utf-8?B?VXU5T09MeDZnQWI4OG1oK3hRN3MzT0pLSU02SGkwcHl3R2JxN2hrOUpRNkZ0?=
 =?utf-8?B?Y2h6dTRSNVd3V2xBRTEwL25qcTJIc0VkWGJlT0gzLzBiOXJvMHpBdzVHT1ZT?=
 =?utf-8?B?ME00Mmo2NGFPSFcrTjh0KytLVU50NDYyOHRCQTU4Lzc2emROM1hvcUd6OGhw?=
 =?utf-8?B?OEY2WXBIUVZ5NVNRRmdHTWhzVlpOT0R5N2xjV3lOSWEyblZMMGpsRENSWTN5?=
 =?utf-8?B?djBnTjVVbjdDZnZJekJJNEJUaVNWc29lZDV2RERHT3BGWmg5SXhVZlhPR3pp?=
 =?utf-8?B?VUdOcG9YeVUwSndXZW1UOUVwSzdxNEcxN2ZGUTViWHI4OVNObWFwcHdteldF?=
 =?utf-8?B?TTB0aU15aGEvcHVXV3JqRG5WK1BROXh3WEFlSGNjZzdPTnQwYnBTdmo3N0dD?=
 =?utf-8?B?ZC85Q3haR3ZIQjJKR0tKT3pHMStKOTg1QVBjMjlGMGxOSHZCNU1NMWdjZENp?=
 =?utf-8?B?dVV2SFNkQ3pnMlBURm1iR1M1SlMxVC9rVXpReVhkSjJkQ1J2Rk5hcC9Hd1pq?=
 =?utf-8?B?VjE5TkszRG83RXFrY29uQXMrZFlnQ2NiVThHMlVXN1o4a2swalNPQ2d4c251?=
 =?utf-8?B?R2hCY08vOUNWbnlPYkU3Z2hIdTh0OEthNENNbUNXQkJyemF5eWZvMitNWE03?=
 =?utf-8?B?enR6cm52Z0NyN3ZDRUlldUFvUTBLK3hBMDQ3K0lNT2ZodnpLdy90QkpLVUx2?=
 =?utf-8?B?UVpzNFJFd2dUbE9rWEdDUHBzZFJFWnR0Y05uR3dPVURSZVVWOXNsOXZVV2l0?=
 =?utf-8?B?amcyTnM5OUMxT1AzOENTYVB3dno4STdFaVFvNnNOK2V6dnl4U2NhcGFIeGhN?=
 =?utf-8?B?cDRxVGM2S2xjNE9UaVNlbEdDTTg5b0ZEYkx6Vk55Z000MGJXczBxaTBpbm9D?=
 =?utf-8?B?VXZLMjgxOXJNRlNPcm4wanFQUnhTMHE4eXNEcU8vSU44NnhKakRRZHZyR2hH?=
 =?utf-8?B?eHRxMlZQOXJkYkpVQjdWeGsxWlB3aFozTkVCTDBCNUFhaWk4QzZSMEw0WFlI?=
 =?utf-8?B?My8yUUNEaTdpNEFnOGRwNlVjQk0vQjRNTXBZSGM3eHZXYTEvK1kwRld6cXVM?=
 =?utf-8?B?K29HWkMyU21JNmNBVStTNDdYU2VhRDVXbnJ3TDdpZ3NLQWNsbUV5U3VQaW4x?=
 =?utf-8?B?c3NEdjltaFN5N0sxWStHeEJiQndLNzVSbHo5TU0yQXlEKzNaUXdMNW03b1NB?=
 =?utf-8?B?a2ZaWDRUN1daRk55eEVOTzZ2ZGVHN1FCcEFmNExrRy9aY29tdzFCVFVFUm9Y?=
 =?utf-8?B?Yit4VFlpT0RDZFFmUFVNc2QyMFdJdDdaOFF1TFAyOUxUeEx3UUl6WW5tdW9h?=
 =?utf-8?B?cWZrVTIzZjlaS0pNdEMvZ0ZSN2dxeWV4ckdPR0swaGtJd2RzazJONkxZNUV1?=
 =?utf-8?B?a0V5NjhNUkIzcVhsa3NLZ0xvTzhJaDNPL0pERHJ5cVBRdkNpY2lmaldKN0Zi?=
 =?utf-8?B?c0hPOGFVcWNkSGNScGx6UnptYS9kcXZhcFJUWXdHaVBqcE9DclJFWXUzUzA4?=
 =?utf-8?B?MzFFUXpFYkVSeFJmUU0zSUY0K3lXdmNJWHg2d1g1c25lOThZUzVIampWam5r?=
 =?utf-8?B?ZXRuNkY2QUptZUFuVjZqa1U0c3hYdElWZmx5S1pFMjl0WXhZeldpZlhJNnpX?=
 =?utf-8?B?TUN6eEdWRUV6VFptQkFtSVJlOC9lKzYrLzc1Q1VVQlJsMkIxUmRtd2JDdDFZ?=
 =?utf-8?B?ZDlmUGFwaktyQjg0eDNYMU84VmozRUg2TmFlSUZnU0tGUzMvdkpQVG9BbzBD?=
 =?utf-8?B?OHl6UlVSdCtWR2phSGo1OFF0Z2dzaTYrSmh4TzZCeVpKY0trcUt3cnhsL3pX?=
 =?utf-8?B?cTNhWXZKSUhSbHlmbXdOblI4S211MGdUWXBEUm5HSXA4Ny9vWWpPcGNCNWtZ?=
 =?utf-8?B?YWtITHJwdzhCcURQN1Ewa2QyRFVmeTAzRW0zNXpHYlh0WWhyL1F6TlFJd1pN?=
 =?utf-8?Q?1G5IhlqzmKjdpoG18OO4N7I=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff4a34dd-95e0-4ee2-333b-08dde402d5f7
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 18:11:38.8596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cl1gtW0aZptxJ22ptnXOaT21Jq28xfKiUSCUm1fD4Esw/X2kQWk0AYwiPyrLX9D/s15GPU25uU58SmDMngl1evR6YPC+TNNQOg+cQTAonLI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB6405

On 2025-08-23 12:39, Thomas Gleixner wrote:
> In preparation for a major rewrite of this code, provide a data structure
> for event management.
> 
> Put the sched_switch event and a indicator for RSEQ on a task into it as a
> start. That uses a union, which allows to mask and clear the whole lot
> efficiently.
> 
> The indicators are explicitely not a bit field. Bit fields generate abysmal

explicitly

> code.
> 
> The boolean members are defined as u8 as that actually guarantees that it
> fits. There seem to be strange architecture ABIs which need more than 8bits
> for a boolean.
> 
> The has_rseq member is redudandant vs. task::rseq, but it turns out that

redundant

> boolean operations and quick checks on the union generate better code than
> fiddling with seperate entities and data types.

separate

> 
> This struct will be extended over time to carry more information.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   include/linux/rseq.h       |   23 ++++++++++++-----------
>   include/linux/rseq_types.h |   30 ++++++++++++++++++++++++++++++
>   include/linux/sched.h      |    7 ++-----
>   kernel/rseq.c              |    6 ++++--
>   4 files changed, 48 insertions(+), 18 deletions(-)
> 
> --- a/include/linux/rseq.h
> +++ b/include/linux/rseq.h
> @@ -9,22 +9,22 @@ void __rseq_handle_notify_resume(struct
>   
>   static inline void rseq_handle_notify_resume(struct pt_regs *regs)
>   {
> -	if (current->rseq)
> +	if (current->rseq_event.has_rseq)
>   		__rseq_handle_notify_resume(NULL, regs);
>   }
>   
>   static inline void rseq_signal_deliver(struct ksignal *ksig, struct pt_regs *regs)
>   {
> -	if (current->rseq) {
> -		current->rseq_event_pending = true;
> +	if (current->rseq_event.has_rseq) {
> +		current->rseq_event.sched_switch = true;
>   		__rseq_handle_notify_resume(ksig, regs);
>   	}
>   }
>   
>   static inline void rseq_sched_switch_event(struct task_struct *t)
>   {
> -	if (t->rseq) {
> -		t->rseq_event_pending = true;
> +	if (t->rseq_event.has_rseq) {
> +		t->rseq_event.sched_switch = true;
>   		set_tsk_thread_flag(t, TIF_NOTIFY_RESUME);
>   	}
>   }
> @@ -32,8 +32,9 @@ static inline void rseq_sched_switch_eve
>   static __always_inline void rseq_exit_to_user_mode(void)
>   {
>   	if (IS_ENABLED(CONFIG_DEBUG_RSEQ)) {
> -		if (WARN_ON_ONCE(current->rseq && current->rseq_event_pending))
> -			current->rseq_event_pending = false;
> +		if (WARN_ON_ONCE(current->rseq_event.has_rseq &&
> +				 current->rseq_event.events))
> +			current->rseq_event.events = 0;
>   	}
>   }
>   
> @@ -49,7 +50,7 @@ static __always_inline void rseq_exit_to
>    */
>   static inline void rseq_virt_userspace_exit(void)
>   {
> -	if (current->rseq_event_pending)
> +	if (current->rseq_event.sched_switch)
>   		set_tsk_thread_flag(current, TIF_NOTIFY_RESUME);
>   }
>   
> @@ -63,12 +64,12 @@ static inline void rseq_fork(struct task
>   		t->rseq = NULL;
>   		t->rseq_len = 0;
>   		t->rseq_sig = 0;
> -		t->rseq_event_pending = false;
> +		t->rseq_event.all = 0;
>   	} else {
>   		t->rseq = current->rseq;
>   		t->rseq_len = current->rseq_len;
>   		t->rseq_sig = current->rseq_sig;
> -		t->rseq_event_pending = current->rseq_event_pending;
> +		t->rseq_event = current->rseq_event;
>   	}
>   }
>   
> @@ -77,7 +78,7 @@ static inline void rseq_execve(struct ta
>   	t->rseq = NULL;
>   	t->rseq_len = 0;
>   	t->rseq_sig = 0;
> -	t->rseq_event_pending = false;
> +	t->rseq_event.all = 0;
>   }
>   
>   #else /* CONFIG_RSEQ */
> --- /dev/null
> +++ b/include/linux/rseq_types.h
> @@ -0,0 +1,30 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_RSEQ_TYPES_H
> +#define _LINUX_RSEQ_TYPES_H
> +
> +#include <linux/types.h>
> +
> +/*
> + * struct rseq_event - Storage for rseq related event management
> + * @all:		Compound to initialize and clear the data efficiently
> + * @events:		Compund to access events with a single load/store

Compound

> + * @sched_switch:	True if the task was scheduled out
> + * @has_rseq:		True if the task has a rseq pointer installed
> + */
> +struct rseq_event {
> +	union {
> +		u32				all;
> +		struct {
> +			union {
> +				u16		events;
> +				struct {
> +					u8	sched_switch;
> +				};

Is alpha still supported, or can we assume bytewise loads/stores ?

Are those events meant to each consume 1 byte (which limits us to 2
events for a 2-byte "events"/4-byte "all"), or is the plan to update
them with bitwise or/~ and ?

Thanks,

Mathieu

> +			};
> +
> +			u8			has_rseq;
> +		};
> +	};
> +};
> +
> +#endif
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -41,6 +41,7 @@
>   #include <linux/task_io_accounting.h>
>   #include <linux/posix-timers_types.h>
>   #include <linux/restart_block.h>
> +#include <linux/rseq_types.h>
>   #include <uapi/linux/rseq.h>
>   #include <linux/seqlock_types.h>
>   #include <linux/kcsan.h>
> @@ -1404,11 +1405,7 @@ struct task_struct {
>   	struct rseq __user		*rseq;
>   	u32				rseq_len;
>   	u32				rseq_sig;
> -	/*
> -	 * RmW on rseq_event_pending must be performed atomically
> -	 * with respect to preemption.
> -	 */
> -	bool				rseq_event_pending;
> +	struct rseq_event		rseq_event;
>   # ifdef CONFIG_DEBUG_RSEQ
>   	/*
>   	 * This is a place holder to save a copy of the rseq fields for
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -460,8 +460,8 @@ void __rseq_handle_notify_resume(struct
>   	 * inconsistencies.
>   	 */
>   	scoped_guard(RSEQ_EVENT_GUARD) {
> -		event = t->rseq_event_pending;
> -		t->rseq_event_pending = false;
> +		event = t->rseq_event.sched_switch;
> +		t->rseq_event.sched_switch = false;
>   	}
>   
>   	if (!IS_ENABLED(CONFIG_DEBUG_RSEQ) && !event)
> @@ -523,6 +523,7 @@ SYSCALL_DEFINE4(rseq, struct rseq __user
>   		current->rseq = NULL;
>   		current->rseq_sig = 0;
>   		current->rseq_len = 0;
> +		current->rseq_event.all = 0;
>   		return 0;
>   	}
>   
> @@ -595,6 +596,7 @@ SYSCALL_DEFINE4(rseq, struct rseq __user
>   	 * registered, ensure the cpu_id_start and cpu_id fields
>   	 * are updated before returning to user-space.
>   	 */
> +	current->rseq_event.has_rseq = true;
>   	rseq_sched_switch_event(current);
>   
>   	return 0;
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

