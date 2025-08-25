Return-Path: <linux-kernel+bounces-785117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76827B3462E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 17:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D272E7A7B69
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 15:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F642FDC5A;
	Mon, 25 Aug 2025 15:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="l2ybN6/r"
Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2137.outbound.protection.outlook.com [40.107.115.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FF9221F32
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 15:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.115.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756136685; cv=fail; b=oCMhebheicA2AEmhe2usuMwW2HKKNsgU7Kn+AWnZTUNk1mHPdVqjKqgRFsGpYo/rDOhDjq4C5gvy82CKyDe6A6zslVzkta4gRo4IGTxNgI2nk6WVhv8RVIKSpcLoDODklL/J0lPVlE8zOO9mjZREu4gc4e9D3rTzsLfOtg9yWAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756136685; c=relaxed/simple;
	bh=bqa6RA0Ejzm28mytr7tkX+Y1ZmMIlq9pJjZpaS+/aa0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ev+uA5oIhuF10MDbEzuKzSkx1MQu34Uy3LX8S31ypOvheiUaikbgUnVU/J7ABZG9YZBTiXxKsROcOvKO5uUQqDJesvHE/qtHHBabDk+F5suewnJ8PlSyDSW9GkSyYl+1Kgu0x39Oefsq+jZN7lqpFfN1pW7XxTefcpMyicEmnTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=l2ybN6/r; arc=fail smtp.client-ip=40.107.115.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kzl5z9bOJTR/0d+9Ue8rQwbZX9zwhbiLK9cS/ShRn9Zv4jGbA5YKRkyXApKM9Bwlx52CRLibHgKoP8hdTjbKzDQb8/J/gFkCLYG/UyeTXq5Dm8wncrAG70uULBjkU6Mi92bKvxbfK0y8cGC5+XLxZPzD+teE7JfYENBQ2kKA6Ib9wNNIVZxBWW/KLpIVsB4xYuEeuhzvtI9F3z8F3NbxKmk8QmLvjUE2WXApwYG5hmVeMl/SEXMQO8N1ZK8FLmwYDbaRd8HNn3EldqDeGAC0/lo7wl8Qj5FwAyO6YsyVOlzS5Jmtk5Tfu+IXNtRIwUi9PzINF1dnPOfp6EYN76HN8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gMAebEL79C+6Sb+6RMQO06qqCBJRgQHjISIeCJXFaPA=;
 b=v/ue0eD4MGmgCQM00UP4rYCnyJNMm5+sQOCoQCDpmhyVjTgqFMBAmzyqRLzhdhh9CwMtM4yDCjZSIWp+GuOhB/os+A9WsBAqJnuFZ1r0qRpeRp/0yCUE9543txz81oBlpqlAabvO192Q+5nmnSQ0kDlA01VQFG5dY6Bncz9djbdTtc2b0TqwWIWJbDs3xDy5BV4N2H8Iyw/CFHLZU3Nz2mWXCkqZUcsYPHL7J1Pk7m4Pk0WgPvwo5Wi+rakwWBzeGSKt1f8dz8MPcw/GIlpKRbGksvf28JLbhmex4TKZWSIUXCwesk84f6Ak7xBJQ7eGY8tEFV1dekFttoz2x3MQpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gMAebEL79C+6Sb+6RMQO06qqCBJRgQHjISIeCJXFaPA=;
 b=l2ybN6/rPIr2/lfdNC4HdWnYdSXNkPxrHTt0et95mU8HT57th+yvuzXbvPn8v55DP3z9O0yOFZlHSI2wExTYz6XynXe+RpDhE8c/kNmaNM8WYD/RVvdjvTasKh2RjXGmd55PXR+rd89GNcxomHXXli/ExsNcnxtKU+zUFccad+/g7OemWYk3OtTupPmLQvBgIUu5lff96zROdePN+M7KZN477MYKweqpGK6SJbHYDIDfJ28GPk7DxadtnlV2iEDQQYLQ2ZekUS4uwqjjk+dSdKA/arjZ3fF8uQSSODLm6RuROSV7ljg6pmuRzah5n8j6DkztFvYFoKrPm2KiT83tWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB11272.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:143::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 25 Aug
 2025 15:44:39 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9052.021; Mon, 25 Aug 2025
 15:44:39 +0000
Message-ID: <bb93b82d-d125-46c4-bac4-dafe4d9fc146@efficios.com>
Date: Mon, 25 Aug 2025 11:44:38 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V2 05/37] rseq: Simplify registration
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
 <20250823161653.580926530@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250823161653.580926530@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXPR0101CA0060.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::37) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB11272:EE_
X-MS-Office365-Filtering-Correlation-Id: ef92d9d4-9597-4c54-fd7d-08dde3ee4d65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y3UybXkyNEo2VDBGUG1JdnFWQ3NReGF3eEpYN1l1UXZTazVkc0ZiMWZ2RFU2?=
 =?utf-8?B?Wk5sN3o5TnYwbDE4YjF0bGVoVWRJOG56Y1BQUWhCMmtzMWYzcFgzWlhsTXRo?=
 =?utf-8?B?dkFLR0cwTUJLcHVxb0FFbHg4dGNPNUNlUXYvWFNSZC9VeXhhTHcvNm1aSmg2?=
 =?utf-8?B?aHhFRy9OdHhyUjAzYXlWQThzUC84ak5MTE4zVnVSUWh4SWYyUmVFQjhOMTFI?=
 =?utf-8?B?bnpuT1BjU0pOTVZVRGpuWnU2YWtEbDhKYVlncHNZeGF6NXFObE5KTUNTYXNR?=
 =?utf-8?B?NHNSeVFHYUgrYnlhREVwUnlVcm8yQStCL25qT1hIOXlUaXNkdnFMTFBJenFI?=
 =?utf-8?B?amN0NlJVT011UE9ia0wxaDVoQTlURXNhRDA3TkJEUjBxd2NnRUQ0ZW1zSEt1?=
 =?utf-8?B?QWlibGdGVDV0Z3AveTcxTlpWb2N1M01DYkpoeVNvcmpsNUxqZzFTekhTdFBZ?=
 =?utf-8?B?RWxuS0M0OHptenNRY1g2R2J1ZUgvTFVheXFwYTMvcWpYaXd2OHlLeGM2TlFs?=
 =?utf-8?B?eDU0azdueVh2bE0xcHZOcUhVbXNUTG1DRmZCUzhkamQ1THVjNmdFRm56RldV?=
 =?utf-8?B?eE1ERVRLaHEyVm41T1kzUFdSdkloNitudEV0ekFhdXNnU1g4b2xXMUZmSHRU?=
 =?utf-8?B?cFlQTVdjazVyd2p1YjJyVGMyNHBGQWwwRFhSY2FUcDNRai93SjFZNzFYWkM4?=
 =?utf-8?B?YnhHb3lWM2VJQUZ6SHlpd2puTjJFU1VlWmNhMDBiakc2SUdVVzNVeGtQMHoy?=
 =?utf-8?B?RmlLd242TTdOZU1MZ3M1NHdMVnd6OG81UjRXMUdXMnhJNzFYcjIvNlRhZlBO?=
 =?utf-8?B?NkhZalJ3YXFBcTRudHMweUM2eXhUSWZ3cUNadnBDYUl2Q0lXK1JuZ2ZnL2RI?=
 =?utf-8?B?eisvTVJ1d0R6dTZhM0ZGaGg4a0hBZkE3YTU4RTFIdjA2VVlDU0ozRk1FUUtQ?=
 =?utf-8?B?bXB5bHFjYUhySWlheHkzVmFOQnZnMDJ5ZEs2RnR3anZGcVVjVUFwYWRYajk2?=
 =?utf-8?B?RGQ1RFBXN2ZQREtsajlrcWl1ZWR3S0ZBd3gxU3dNeXRtZkdsazNwZ1pHU0xE?=
 =?utf-8?B?cHI2U3dYNlRTa242VXJQWmRObm1LMjZxSU41Vnp5RzhmaXhpbVJsWjh0czly?=
 =?utf-8?B?WWhua3QxSlk3TitXTDFvcDk1WXZ1RDR3ODA5cTZBcFBBQ3NvUjl4RStxamNi?=
 =?utf-8?B?VXl3WnBqTlp4eng3RnJpUTBrZjU1enhKQ2FHM3dlSzNwOWhXNFZUanVBTXdU?=
 =?utf-8?B?dUE0VU1oeDIvL1p3YzJDaERuckJvUzF6UWU4SjFMMDlITXNMdjBxZzJjWCtr?=
 =?utf-8?B?KzB6Ykp3cUpBWVcyeURHWW5pd0VXMXR6SjczRjU4NUhyYnlmS0twVlFEWlVj?=
 =?utf-8?B?bWdWSlRnNUVLc2lLaFlPa2dMcUJlQ2pVcldBTFpCR05pZG15UjNDTW95WG9J?=
 =?utf-8?B?RjJ3Rm0xUm4rL21EdG45Uzc2Zm1uRDFlbllYU2EwMGhqeFBWUjNSYllwcXNp?=
 =?utf-8?B?ZHUwS3daVHowSm1LRkRONGp1VGlBQ0E1RjI4NUdXOGtCVGhreXBjSCtreGJ0?=
 =?utf-8?B?VHZmMDdQSHBCMVAwalFtNy9aYXFHaE42Z1llcnhYb1JyUXJKd3NDU01aQ3VY?=
 =?utf-8?B?Q0MySlRQeXY2aUMrTTY3NHNtdkFTQjJmOHg5aUhIQ1FNeDJ1ellCZ2d5OEp3?=
 =?utf-8?B?TXZSbWsyRmxFS3EwbFJhVWRwU0tjalprT1RvL2NNU0UyVGNDcm1YR0JnYmRl?=
 =?utf-8?B?ZUhYWVIvOXNLSWpaZ2JLeVVMQjNQTXpBblBVRGt1czBRS1FVa2NCcjB5K1FI?=
 =?utf-8?Q?dY9StX4yCMoY+pzlN6vWNAlbcN6UK7VomLNjw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MCtZNU01Wit1MmFHZ2RRYWJvWlE2KzNhODhqMmVsamxwaWFiWVl4NlJvaWhG?=
 =?utf-8?B?RDhoM2dvVTBZL2JaMjJlOEU3d2EzeGFTTGFLMXhkb3hkNCtXK3IxTnpsR1ps?=
 =?utf-8?B?YVpUTFlHa05LdGlDYjl2aUZ1cHphWlBEUmRWMXE5d3NNUEloaC8yNU1udXNo?=
 =?utf-8?B?QnJUQ1ltMlNlMTZ4Nno1VjlNL2orYmQ3Qk5TWjJ4eEoyK2tWS1lIc3hEVVls?=
 =?utf-8?B?cjdRTS9sNHZLak16NUZiQkhvaGxyMDNITU1tTktRNTZ3TXY0djd1OVg5dExM?=
 =?utf-8?B?N0dDSVpuL2lOakFFL3lOS3JHQ3d5TGpQckVoTDExTW0rK1dpL25ERlpBdzh0?=
 =?utf-8?B?Zmkzb3p1RG5ML2M3YzJ5aE81aVRDWkdiWmFGM28rc2dMV0dvOTJaV2pVNDlk?=
 =?utf-8?B?ZEFzZmFxeEZzQVhVOFB2UjJCekQ5dTA1elJIZWJ4bDhiNnpFa2JrMUdwSjhy?=
 =?utf-8?B?d0VPUXF0aVhFb2Q2VkFRZFdpMFl5c0lHVnQ4bG0vR1VzTWZQaktYNVJLSGdu?=
 =?utf-8?B?bjBSRmwzL1BZelA2YTlKeTFTeVpnOXZhQXhFbkF0cGtNendxdjFicENWNkk3?=
 =?utf-8?B?ZVNMS3QvVWhjRXBESHNYL0QwTmhzckc0M2VudDgzaGlBRHpWR1JHZGZtc0E5?=
 =?utf-8?B?UlV5NEtMb00yVENadUsydnQ4SXNmcUNqWTZ1UFZoa2l2cHE5cGVPRW1yV3ZC?=
 =?utf-8?B?RmEzTFFzNzdmanRLaVB0em1EMFpLV2RjaHlyb2prZTg2cXdCeEVrbkFseUpn?=
 =?utf-8?B?ZVYzeTZCMm8xc2t1UjVmclVkOUJUWjY2NnpnTTJvbjlQbFF4OHVNRzNmZ3FE?=
 =?utf-8?B?WVArNFNyb2J3RThXelNpSGhRTUt0TVd2QUFUYldyejlZdTErSHVCRDJhcS9C?=
 =?utf-8?B?SnljRm1HcVhVdVV1dXpTZ1Q0MzRLTThDTTR5RnpYdXJ4K0dmQ3U5R0NLWExB?=
 =?utf-8?B?bHVuNlphazBMSGFqSUxmck9nYkdOa2RHcTJCdFdVM21vVTBlNVU0TTczd3Rl?=
 =?utf-8?B?VXpNeGNML1ZKYlUwTVJ1YWw2NW0wM2xxa09Vd3QxempuTnFEOG9HQkpUSVk3?=
 =?utf-8?B?dk9RR1RVb1ZmUG15eStHZVVpRmhLaWhzK0dudUhZWnVsaXpVUFQxdmp1b3dD?=
 =?utf-8?B?TXNWR2lBTVhZZWs1R3c5cEZhTDFrVW1Zek5LYU5xdUJhWEMrdkNzdDB6amh6?=
 =?utf-8?B?THJuN2pSWmY0M01jeTBGdXh2WEJxQWdHTDBNeHJ0bERNQ1lidngwTjRicHZP?=
 =?utf-8?B?TkZHdGRDQm5QOGpSczRhSDVpZ0xrTGFmeGx1WkpuaUVSYlFMQ1JvaWxlajRz?=
 =?utf-8?B?TkNXQWJPaktSRUp6MzFONURHdHRFYnRUY2I1S3RJaGR2NmNXdXR6cFdHSWpi?=
 =?utf-8?B?anpSL2FjY1Jnc01oZ2VXNVdHTlFVeUJmKzd6YlpWakdIWjNsTUtBb25yUk8r?=
 =?utf-8?B?NmYwQ0RUS2tOc2lRbHFHbXh0Z3dkUThRc0pHYTMwYWZQU1JVTTVsb2I5VDNn?=
 =?utf-8?B?YkxEV0tBckJNaVZuVFVwYkQ0YW9PN21teGU5bWMzSXYzRWF5dnRrdEdxUEFw?=
 =?utf-8?B?SWRUYUtXZTVsWlQ0VXlXWFhDU2pZQ2U1YjBzRHJCY3pac056b3UyS1JacGRX?=
 =?utf-8?B?NnBZd3E1NVFYL0R5bW9JZTczZ0ZTWWhSKzZKUHdVTnNCTDBGVTFEYXJETnAw?=
 =?utf-8?B?TmpvbWYwT3VjVWxJREFBR2pPU0grQnkxd3pqZjBoVldwdElVNmlqbUtjVDd3?=
 =?utf-8?B?ZDZqTGQwZjVmRml5ZHJnY0hnWnFtMWNOQUtPTVZGcnBWdVVjM0dyT3JsQnlD?=
 =?utf-8?B?ek5kZE50bTYzNlM5VStwbUxZR1B4Z3o3b0pQOXEyUnoxR3Y4TTd0aUpFdzR3?=
 =?utf-8?B?bmYxMVk0dW1uNlBNYkhMTEcxYUVuVUxIL3N0K1NhbzN4N3B6SXVKa1UyaEJP?=
 =?utf-8?B?a2phSHk3c0FGbWxpTmJBVENyd3RSK3dNUlRIdmNtQlhkeld0NVMzWW9nRmhv?=
 =?utf-8?B?ZUVOYkEwd1hUK0YyYzNWUnBCOVcvczFZeEtndHFZQmhjdjFGWnpQSG9QUENt?=
 =?utf-8?B?MDhYbGZ1dms3dVBsaERlWWxFSWRybkVRVzZVQkNiSmJNYm9jYm9pQnVRUnN4?=
 =?utf-8?B?ajl5VFQ1dXg2YlhuL0dORzQ5NE9ZaDlsNGs4OFFydXdsZzI1cExaRWM0ZDli?=
 =?utf-8?Q?VdBJAbD/oH8b8atRpjRkM90=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef92d9d4-9597-4c54-fd7d-08dde3ee4d65
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 15:44:39.7951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KNVySCsCbb8vH3fTEJCEISD2R96VeB6F87II4CCkR7Zlc51SrGsoftrLqY16ILW5m1eU0KbGKAn/BqsRzqUtqdjGSkTFO/qAxQf0hUNKkz4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB11272

On 2025-08-23 12:39, Thomas Gleixner wrote:
> There is no point to read the critical section element in the newly
> registered user space RSEQ struct first in order to clear it.
> 
> Just clear it and be done with it.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> ---
>   kernel/rseq.c |   10 +++-------
>   1 file changed, 3 insertions(+), 7 deletions(-)
> 
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -492,11 +492,9 @@ void rseq_syscall(struct pt_regs *regs)
>   /*
>    * sys_rseq - setup restartable sequences for caller thread.
>    */
> -SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
> -		int, flags, u32, sig)
> +SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len, int, flags, u32, sig)
>   {
>   	int ret;
> -	u64 rseq_cs;
>   
>   	if (flags & RSEQ_FLAG_UNREGISTER) {
>   		if (flags & ~RSEQ_FLAG_UNREGISTER)
> @@ -557,11 +555,9 @@ SYSCALL_DEFINE4(rseq, struct rseq __user
>   	 * avoid a potential segfault on return to user-space. The proper thing
>   	 * to do would have been to fail the registration but this would break
>   	 * older libcs that reuse the rseq area for new threads without
> -	 * clearing the fields.
> +	 * clearing the fields. Don't bother reading it, just reset it.
>   	 */
> -	if (rseq_get_rseq_cs_ptr_val(rseq, &rseq_cs))
> -	        return -EFAULT;
> -	if (rseq_cs && clear_rseq_cs(rseq))
> +	if (put_user_masked_u64(0UL, &rseq->rseq_cs))
>   		return -EFAULT;
>   
>   #ifdef CONFIG_DEBUG_RSEQ
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

