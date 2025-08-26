Return-Path: <linux-kernel+bounces-786927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08414B36DFA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 17:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0524364F85
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 15:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979CB42AA5;
	Tue, 26 Aug 2025 15:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="VZw167KJ"
Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2096.outbound.protection.outlook.com [40.107.115.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AE526E71C
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 15:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.115.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222826; cv=fail; b=Vav5UUzImg7FWLJN10b6c1O9Vo4m1QYC97H9hLPmkBkwbzZEnZtPfLUThNH0UDs8uizPUlP3zgmOWehaD3zktkHzhVTbl0pRxeIFZg+cBsohGKwQi0Q7KuJCeDRlTJuftSNf1f1KHXf2HkfSUNixFRIjtyckJmcmRINjEN+qS2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222826; c=relaxed/simple;
	bh=zP952dD3WIeLCgRrKNbLQ7P8SZ/FHkxNoo4NzE/PwCw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BH6lrUT69sLtLzPu9WjykPNbclvQhunDC18o/Ks1vZLyRJifGgk/zmu/ZsXkF5aSVV/rUPaN8VY+0NBofkzxd5Pr+m+K3K15AL2J12OxEYkg4bRI630kLpdL3bIKEjR4l8+LL5r1YGe9jaavkyC2nxPxg9Mvn4cWmRts8n0kXUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=VZw167KJ; arc=fail smtp.client-ip=40.107.115.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jl/T2MOGDhkfvPztb2wwzIwkNHIipH9XRxvHpAHIQ8o8Xq+PHdCut9In//J0dL+mDA4v+g37nuqZXnHSRXC/ZjGD7u0IUlNo1GwYcZAuiQfrM1gELFlXI8KVxZwad4BohhRPPbC4xf92kNNXvil2McKCKb66AvQQyNxbzyzSAD5t4/c/33DjpremK1XL6TCFWYz+ar5uuO3UhXWOc7zdMFQaKNGWzY0Qz7Dcq/CCTVyvVIeYBcL08Ve6retxTkYVajEy4RG16xKtD9oqhz6DgCRgSwupBe7hE97NBxBd2dqAKGZ8BGZArxikYgcuRSvX9IyMiB14z9se0OokkOqdAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=azoHh0XIjb7AEnqprB2OgF1nGy28FYK1v5w63y4rK6A=;
 b=VNwJYNiVek0QW7breXJqAGj/cuakzPrQmmWEIWoeJBDX+qp9kwuF+GCiPNWHy3edUkmyB3SAcWlRzNIVmU6WE4nXJ+n+IuLMsXcm7P03AANLUojNSiWCgkYbhD3R00u0FrDKBatKHJMQFiuahc4QDcb/JqbOJOXRtD9wshmK7ySQqbt+wQS1zrzEc6YW+/dz9Bw+dqnK5CH45DDi6K2iXLVTvI8Q6loxJS4uRMZGBfHwafkvnnt8m9P4LvKVNhAOOYDupZbXY12/NPbTuptllPiJ0JP65WO5NCp7xDDgsMiTwTs8t8T9HXIMENNmzjv7qekhUi3OKNXTmN1/JtSQiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=azoHh0XIjb7AEnqprB2OgF1nGy28FYK1v5w63y4rK6A=;
 b=VZw167KJiebDS+Up9d8OAC6LS2h2AiMt8Ghct0PmsZALWgeYwxI6tqDgHxyUUp9GBQsNY5YAv+jfmANcEGSOLN/JL0JRxP7cv7bJFNMV+HiNJ2NKjj/+OLs2LzxqvJAGVJosBq1F3iNKAaRecQoIG8ZXZpUQycuzoezUdN5+OFEUMcs6vbGrfnKL91BDVxfILf7ht1q/v6cseSs4UMZVnr92X0X/UZQ6WuCgRoDb6xc5ul7XH6Rs3wgqH9L/oeU9xPTlxnhKvJ4HrekoQlJkoLuNxuN3esMoSEPWAKpeZl7cNPzMZgGFlodugkTYDHUnWJ8uBax27ANC/E3l3/OUAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT1PR01MB8876.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:cb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Tue, 26 Aug
 2025 15:40:20 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9052.021; Tue, 26 Aug 2025
 15:40:20 +0000
Message-ID: <bf216d3c-9d9a-45e4-b7a6-64c0c3cbe6ed@efficios.com>
Date: Tue, 26 Aug 2025 11:40:18 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V2 28/37] rseq: Switch to fast path processing on exit to
 user
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
 <20250823161655.063205235@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250823161655.063205235@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0126.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::29) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT1PR01MB8876:EE_
X-MS-Office365-Filtering-Correlation-Id: dbd00b48-0731-43a2-35fa-08dde4b6dd59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a1YvRXpwSzIrN0U2VlZPTlcvajNVVHNXSFlabnNFbEhIY094V2FEanRJL1pS?=
 =?utf-8?B?UDNrVzZqZDRCbjEzWEFVS1V2djFLK2dsQTN4ckpVRHo2Q3E4RzBwSmVmdktL?=
 =?utf-8?B?eFBwM2Y2SkdMd3pxeVJsSW5iSWg5VDNKb3RBbWFwVUFVem1qcTZBSURzbWRD?=
 =?utf-8?B?SzVwR1NrQ3FzWnE1NnJPcE0wN2NPakIzMFU2UFJ4Tkp3Nzhoc05BdG1mdFYx?=
 =?utf-8?B?blBMOTUraS9iTUIwb3N4SWJVV0t3OFZSbVFkK0NuUmtsWTUzQ2FrSXVCL29E?=
 =?utf-8?B?N1NqOXJzN0Y5UUhjcGN6Sm5FYUV2K1VVOTdSNHFLNVJpbEZ6ak5SODdBRzZY?=
 =?utf-8?B?SUc4YUhhVldEMnlTUWQzVzBWRU9kSTNtcE04WjlMS0hKTElsai9tNzlJMktm?=
 =?utf-8?B?TGRvSGdSVGpSZUFaY3oxK3dmcFRUcVJiQW1VaWF0TG5VQ3lxT3pBc3ZKTzhX?=
 =?utf-8?B?cTQrRis4ZmxNMWZ0R0ZiV3Q0N2F0UW9WaWFRQXU5YmpHRDJ1K1NNR2Znb0tZ?=
 =?utf-8?B?T3hOaWZ4b2NYbXkyVFd4Y25CL2xvcVRsdlBYdE9OcG1FdDB5NmhDVktQVDRV?=
 =?utf-8?B?UUxwK2o0UlZsMTVjNWF6SU41Q0VqRHBCaEFheHQ4R09Ia3hjZm84UDVWdmlN?=
 =?utf-8?B?Rmt3bWFsSXhieXFvWklLbHMzSS90UHNkM1phUXh3YmNsck51c1NuZVROTksz?=
 =?utf-8?B?eXdSRGVoTVE0ZFBvcThYUDIvaXNMQ3I4b3Q4bmVmUlR3ZjI1QTdrNG04aXpM?=
 =?utf-8?B?WGw3RGVtMStpTGlGVHBTTXczZC84eDdTenJadXFCT3Vjb1VTMzhrcnEveWVp?=
 =?utf-8?B?SkFtMWw0bEdyMjEvL0YrNm1SNG92azFJY00rT0dIQVVQNk84Z0p6M0VFbzRW?=
 =?utf-8?B?YjY4UmVlaUxGZG9HS0RuVldjbEpwbjExU2tIU0VlSTJHN3BXL1NaVTlhZUgw?=
 =?utf-8?B?eGs4N1ZSZ2drdXdDYzFORVdmdW8zOGZWTCsyaXpCWmNzbXVNTTNsQzlSREU3?=
 =?utf-8?B?dUNqaG5UZisvbWI3U0hYbnFRcnlCV3BiQXBDRUZ1bXA2L0s5ZEdHT0pkd0Jn?=
 =?utf-8?B?ZGV6YTUxMUJ6VWJiemgwellmdjlaSVQrcTl2d1dWRDh3OTA3NDRDNjdFcnRv?=
 =?utf-8?B?L2xFRWlnSCtCTXdYVmY2Ukl6N2g5OXY1bEh2eWNsbnlOekxFK05mdTMyMkhT?=
 =?utf-8?B?QjQwcEpNWTBhMWozMjQ3SHJpL3NuL05ldG9uU0Q1ZVZQSzNqNVBQYWo0TFZW?=
 =?utf-8?B?RCtEQksvaHdOdHlpemdGaTN4dnF2MFRXRWRwa2U1QVJYY2owYVlVakF5SjRj?=
 =?utf-8?B?dDkvUCtCVmdqRVBCK0YxRGtBMXB4T2ErTWg4LzR0SjNjSVJ0VTVpT0pEL1V3?=
 =?utf-8?B?aEpkbFpXWjY5RllyRldDWjd6bWNEdmpBbUgra2V5d0grZ1M4UVhxbFR4TWI2?=
 =?utf-8?B?aTQ0SUwwNzBDZlVFQkxJazBqbXF3ZnVLcHBhL2pGM0RuK2szcFN6RGt1ZEpX?=
 =?utf-8?B?N05NSmFJejBZWEJYenhkM3NHSHdHNGV1VGtPeVRoT1l2RkQ5RERvSTdOb3My?=
 =?utf-8?B?bGpSR0QvdmdtMGNZOG96TmdlaU5tOXRLOHNEektKY2s0clI0ZUVRc0pIbTZX?=
 =?utf-8?B?cWV6VjE4QUphUk83VlhBVW52R0NUSUhnQU1oRkRNUXRmaGtMSjRQYXhhamFE?=
 =?utf-8?B?ZFI3ckdmTmplUklETG0zY3dwamFWK3NJUlJmN1Vzdno0RVpoVzB3ODAwdnNn?=
 =?utf-8?B?MU1kTFVJVXlrNkVzb24yK1BQTzEwM2V2dUI3QXFrVnJsNHM2aGF5QmdNWE1X?=
 =?utf-8?Q?lKnb9zIMhK9/+e3GJDIuddaQaqF8qQpT74VAA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VnRXK1NFdFArR2FwZ1YyVUZVamV5NSt0c255eUxnUzl2N25uRDZybHpqMmF5?=
 =?utf-8?B?aTVVbzB2dHArT2JNeXJpcGg3WlIxRVA4aHpBaDU1RjhzM05ObVRXNlpML0ZU?=
 =?utf-8?B?N1FTTWlQMzUvWHQ5R2FBeHkvMmJYQS9JSWVzOVU1YlhKWllDSldwZVNxYVN6?=
 =?utf-8?B?aVNPZXI0YWJXNnJ4R1dVNXBsMTVMVWlBcmxpNEdUQnF0WEw5eUI5WXA2ampW?=
 =?utf-8?B?S2dGSk4vV2M0dCs2USt6eHZLamJ3bnRQQzlhaUx4a2lnZnpxWE5Va0NUcGUw?=
 =?utf-8?B?Nmx2L1gvZHR2WXJnQjNVcHp5TnZyaThqL0toaEkycHlISUl0eGxreXZ3OWov?=
 =?utf-8?B?QU5kYUtXbnNTdFhReW9pKzlMeUQwR3dDZUQ2SmxZeFAxSXdKSUN1K254dnBC?=
 =?utf-8?B?WVNPZTJDRGZkQzF4djdrcWh6ZHdWQi9KMCtIT3d5RmpVZ3V5dHhtTWhQY1dh?=
 =?utf-8?B?YTdYRnFzbDVwYlRLUHVvdHB1REVCT2N6VHVMQkVTdFFFWS91QzdSSGZyaG9M?=
 =?utf-8?B?ZEtOTm9NcytRZlFCUHdxT3psWHBDUVhKL0pIdS9BYzhPWFM5ekZkK0Q5YkZo?=
 =?utf-8?B?dWJPSFp4YkNGKzQ5VlBzVlc5YjZTM2dOOWkvc3c2QjRwMkFwUDVmQTZoK2ds?=
 =?utf-8?B?aDB3VzhsQnpkUzh6bDhCYUJWQXdJQzVTWDZjR0xxN0MvNmtuaEZ0d0YybmNi?=
 =?utf-8?B?dWRoeDNhcy85SndkeWNKY3d2M3dUSllvZEhhSjIvOVVCdk1nQ0E1L2o1ekJ3?=
 =?utf-8?B?bThnd0QxODBISzBXYUJqcmZSYXFKY0VJYWVWazArR1JVUEpTeTY4MUtETThy?=
 =?utf-8?B?eFRIQmwzd1hOaWk2ZjRFK3FPdXRvTndHUmhRUXJxVmFhWjZvMWJlbjlaenJK?=
 =?utf-8?B?U0syaXltby92UkxrS2V6NVdJRitOVHNQVmNDelVDVXdraXRabnhEWjQzaUFk?=
 =?utf-8?B?RmVPTjhWWE4xWUFhWFJodzdaVUp1VHNoUGk0c2JLbTZDbUZXMDdpZzExZzlE?=
 =?utf-8?B?MDJTTXF3b2ZhMDY5NTcxczNjV2EvYjROZTJqN0tjSGN3WnRlVHhab0ozOWVO?=
 =?utf-8?B?cExnTW5ScHQ2VDhrd2RBMUZiME5YZDR0VkQ2OWJZZWJ4bUZTeTFMK0VHUHp2?=
 =?utf-8?B?S25OVEVBRER6OWNtZmVKelNvejNsTWpoUFh5eG9FQlRLTWhOaVFldjdOOW9U?=
 =?utf-8?B?YXJUK2JsQzV3eDVjWU1ldGpReVVjeVBjNS9OdU1zUTZkVmFBUFRKQXlTb2NL?=
 =?utf-8?B?SmYxV2RuYWdVVnNhZHpTK0NNRkNXTGpIVTNRYjMzYnZKSkRrTGUvZnRjbUhs?=
 =?utf-8?B?NDhKRi9PQWRYTEdrcTJScE5xaTZmRHg3cXU2M1YyazJCc0pmOCtJMEQ5L2d1?=
 =?utf-8?B?NktmUVAwQmtGTlhBRFV0NEIyVlN0UkJaa0l6RVpsamVqdDZEd0IrU1Q2YXhZ?=
 =?utf-8?B?SjQ0UUFwbDFGTnp4U08zbEZHRjRyRCtoWkZkQlpsOXp2b0pFUisrOXRQLzAr?=
 =?utf-8?B?ZERjYTFqaStOUi9mcmRIU2UzSGFybzMwTWdQcTJhRmFLNmhsR0VsQVhIejVV?=
 =?utf-8?B?OUl4c0s2UFdEMjRjK0FBK1JOM1lyTHF6S2ZTOXpwVFVObG5LQjN6bWJrcjVl?=
 =?utf-8?B?SXlHcloxMy9RcVZqQS9OZFI1SmdRTXhYZHZ6MkFGZWZSOTJ2QnN3VWpXaU1R?=
 =?utf-8?B?Zkc2MU1wL1VxbDZ3ZTRrWU9UTjNwWXN6L1NhNXo1SFc4Y1QwaUcvMFgvS1hj?=
 =?utf-8?B?ZVlrYUw0Ymt4ZUpQQWk4eFdnSWtDQ3BpWGdWL1AraWp0QXhkUmthNENKeGJv?=
 =?utf-8?B?YktQUDhkVlJyQlhxUnZrN2hLVXNoNkdkb2hQMzlFWm4yL09hNU9HdXhtZFJl?=
 =?utf-8?B?eFE2TVNpMEVkQ2cyNitWYVBMT01CTXJwUmtLYWE2K09jdHBja0lYMlJOTnVG?=
 =?utf-8?B?K3E0TEE3bUdmVXN0Y2taWnd0TmxUaW8xSFRFRmlab3ZFUFFsSnRhVjkydTYx?=
 =?utf-8?B?Q1ZmSnRTVW1FR1pMWU9DSnE2dWlwSVh4Tk5TNzZhaDh5bzg2VGRudUVONUdl?=
 =?utf-8?B?M3VJRDhGbm52dTVKbTQ3SUVDUFZtN2xONTFnT3dmYkJvWFN0VzQzQkdQOGFt?=
 =?utf-8?B?YzZFSHlBTXFCWnNXaHlwVHFSVjlrb25VRHRIVGxJcjhueU9NREJiaVJOZTZH?=
 =?utf-8?Q?DqhgMfd2lXRKetISegwT06I=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbd00b48-0731-43a2-35fa-08dde4b6dd59
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 15:40:20.7576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Th5QthF6BOS/c6lWJAcY9qcMH05+VS47d4p/q+KB/CB1kYr0LyY9AEBfc085lOILG3KkSqGNLgVd/ux/5ataicF/2dHW2eswdC/Er1QDsNs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB8876

On 2025-08-23 12:40, Thomas Gleixner wrote:
> Now that all bits and pieces are in place, hook the RSEQ handling fast path
> function into exit_to_user_mode_prepare() after the TIF work bits have been
> handled. If case of fast path failure, TIF_NOTIFY_RESUME has been raised
> and the caller needs to take another turn through the TIF handling slow
> path.
> 
> This only works for architectures, which use the generic entry code.
> Architectures, who still have their own incomplete hacks are not supported
> and won't be.
> 
> This results in the following improvements:
> 
>    Kernel build	       Before		  After		      Reduction
> 		
>    exit to user         80692981		  80514451
>    signal checks:          32581		       121	       99%
>    slowpath runs:        1201408   1.49%	       198 0.00%      100%
>    fastpath runs:           	  	    675941 0.84%       N/A
>    id updates:           1233989   1.53%	     50541 0.06%       96%
>    cs checks:            1125366   1.39%	         0 0.00%      100%
>      cs cleared:         1125366      100%	 0            100%
>      cs fixup:                 0        0%	 0
> 
>    RSEQ selftests      Before		  After		      Reduction
> 
>    exit to user:       386281778		  387373750
>    signal checks:       35661203		          0           100%
>    slowpath runs:      140542396 36.38%	        100  0.00%    100%
>    fastpath runs:           	  	    9509789  2.51%     N/A
>    id updates:         176203599 45.62%	    9087994  2.35%     95%
>    cs checks:          175587856 45.46%	    4728394  1.22%     98%
>      cs cleared:       172359544   98.16%    1319307   27.90%   99%
>      cs fixup:           3228312    1.84%    3409087   72.10%
> 
> The 'cs cleared' and 'cs fixup' percentanges are not relative to the exit
> to user invocations, they are relative to the actual 'cs check'
> invocations.
> 
> While some of this could have been avoided in the original code, like the
> obvious clearing of CS when it's already clear, the main problem of going
> through TIF_NOTIFY_RESUME cannot be solved. In some workloads the RSEQ
> notify handler is invoked more than once before going out to user
> space. Doing this once when everything has stabilized is the only solution
> to avoid this.
> 
> The initial attempt to completely decouple it from the TIF work turned out
> to be suboptimal for workloads, which do a lot of quick and short system
> calls. Even if the fast path decision is only 4 instructions (including a
> conditional branch), this adds up quickly and becomes measurable when the
> rate for actually having to handle rseq is in the low single digit
> percentage range of user/kernel transitions.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> ---
>   include/linux/irq-entry-common.h |    7 ++-----
>   include/linux/resume_user_mode.h |    2 +-
>   include/linux/rseq.h             |   24 ++++++++++++++++++------
>   include/linux/rseq_entry.h       |    2 +-
>   init/Kconfig                     |    2 +-
>   kernel/entry/common.c            |   17 ++++++++++++++---
>   kernel/rseq.c                    |    8 ++++++--
>   7 files changed, 43 insertions(+), 19 deletions(-)
> 
> --- a/include/linux/irq-entry-common.h
> +++ b/include/linux/irq-entry-common.h
> @@ -197,11 +197,8 @@ static __always_inline void arch_exit_to
>    */
>   void arch_do_signal_or_restart(struct pt_regs *regs);
>   
> -/**
> - * exit_to_user_mode_loop - do any pending work before leaving to user space
> - */
> -unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
> -				     unsigned long ti_work);
> +/* Handle pending TIF work */
> +unsigned long exit_to_user_mode_loop(struct pt_regs *regs, unsigned long ti_work);
>   
>   /**
>    * exit_to_user_mode_prepare - call exit_to_user_mode_loop() if required
> --- a/include/linux/resume_user_mode.h
> +++ b/include/linux/resume_user_mode.h
> @@ -59,7 +59,7 @@ static inline void resume_user_mode_work
>   	mem_cgroup_handle_over_high(GFP_KERNEL);
>   	blkcg_maybe_throttle_current();
>   
> -	rseq_handle_notify_resume(regs);
> +	rseq_handle_slowpath(regs);
>   }
>   
>   #endif /* LINUX_RESUME_USER_MODE_H */
> --- a/include/linux/rseq.h
> +++ b/include/linux/rseq.h
> @@ -5,13 +5,19 @@
>   #ifdef CONFIG_RSEQ
>   #include <linux/sched.h>
>   
> -void __rseq_handle_notify_resume(struct pt_regs *regs);
> +void __rseq_handle_slowpath(struct pt_regs *regs);
>   
> -static inline void rseq_handle_notify_resume(struct pt_regs *regs)
> +/* Invoked from resume_user_mode_work() */
> +static inline void rseq_handle_slowpath(struct pt_regs *regs)
>   {
> -	/* '&' is intentional to spare one conditional branch */
> -	if (current->rseq_event.sched_switch & current->rseq_event.has_rseq)
> -		__rseq_handle_notify_resume(regs);
> +	if (IS_ENABLED(CONFIG_GENERIC_ENTRY)) {
> +		if (current->rseq_event.slowpath)
> +			__rseq_handle_slowpath(regs);
> +	} else {
> +		/* '&' is intentional to spare one conditional branch */
> +		if (current->rseq_event.sched_switch & current->rseq_event.has_rseq)
> +			__rseq_handle_slowpath(regs);
> +	}
>   }
>   
>   void __rseq_signal_deliver(int sig, struct pt_regs *regs);
> @@ -138,6 +144,12 @@ static inline void rseq_fork(struct task
>   		t->rseq_sig = current->rseq_sig;
>   		t->rseq_ids.cpu_cid = ~0ULL;
>   		t->rseq_event = current->rseq_event;
> +		/*
> +		 * If it has rseq, force it into the slow path right away
> +		 * because it is guaranteed to fault.
> +		 */
> +		if (t->rseq_event.has_rseq)
> +			t->rseq_event.slowpath = true;
>   	}
>   }
>   
> @@ -151,7 +163,7 @@ static inline void rseq_execve(struct ta
>   }
>   
>   #else /* CONFIG_RSEQ */
> -static inline void rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs) { }
> +static inline void rseq_handle_slowpath(struct pt_regs *regs) { }
>   static inline void rseq_signal_deliver(struct ksignal *ksig, struct pt_regs *regs) { }
>   static inline void rseq_sched_switch_event(struct task_struct *t) { }
>   static inline void rseq_sched_set_task_cpu(struct task_struct *t, unsigned int cpu) { }
> --- a/include/linux/rseq_entry.h
> +++ b/include/linux/rseq_entry.h
> @@ -433,7 +433,7 @@ static rseq_inline bool rseq_update_usr(
>    * tells the caller to loop back into exit_to_user_mode_loop(). The rseq
>    * slow path there will handle the fail.
>    */
> -static __always_inline bool rseq_exit_to_user_mode_restart(struct pt_regs *regs)
> +static __always_inline bool __rseq_exit_to_user_mode_restart(struct pt_regs *regs)
>   {
>   	struct task_struct *t = current;
>   
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1911,7 +1911,7 @@ config RSEQ_DEBUG_DEFAULT_ENABLE
>   config DEBUG_RSEQ
>   	default n
>   	bool "Enable debugging of rseq() system call" if EXPERT
> -	depends on RSEQ && DEBUG_KERNEL
> +	depends on RSEQ && DEBUG_KERNEL && !GENERIC_ENTRY
>   	select RSEQ_DEBUG_DEFAULT_ENABLE
>   	help
>   	  Enable extra debugging checks for the rseq system call.
> --- a/kernel/entry/common.c
> +++ b/kernel/entry/common.c
> @@ -23,8 +23,7 @@ void __weak arch_do_signal_or_restart(st
>   	 * Before returning to user space ensure that all pending work
>   	 * items have been completed.
>   	 */
> -	while (ti_work & EXIT_TO_USER_MODE_WORK) {
> -
> +	do {
>   		local_irq_enable_exit_to_user(ti_work);
>   
>   		if (ti_work & (_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY))
> @@ -56,7 +55,19 @@ void __weak arch_do_signal_or_restart(st
>   		tick_nohz_user_enter_prepare();
>   
>   		ti_work = read_thread_flags();
> -	}
> +
> +		/*
> +		 * This returns the unmodified ti_work, when ti_work is not
> +		 * empty. In that case it waits for the next round to avoid
> +		 * multiple updates in case of rescheduling.
> +		 *
> +		 * When it handles rseq it returns either with empty work
> +		 * on success or with TIF_NOTIFY_RESUME set on failure to
> +		 * kick the handling into the slow path.
> +		 */
> +		ti_work = rseq_exit_to_user_mode_work(regs, ti_work, EXIT_TO_USER_MODE_WORK);
> +
> +	} while (ti_work & EXIT_TO_USER_MODE_WORK);
>   
>   	/* Return the latest work state for arch_exit_to_user_mode() */
>   	return ti_work;
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -234,7 +234,11 @@ static bool rseq_handle_cs(struct task_s
>   
>   static void rseq_slowpath_update_usr(struct pt_regs *regs)
>   {
> -	/* Preserve rseq state and user_irq state for exit to user */
> +	/*
> +	 * Preserve rseq state and user_irq state. The generic entry code
> +	 * clears user_irq on the way out, the non-generic entry
> +	 * architectures are not having user_irq.
> +	 */
>   	const struct rseq_event evt_mask = { .has_rseq = true, .user_irq = true, };
>   	struct task_struct *t = current;
>   	struct rseq_ids ids;
> @@ -286,7 +290,7 @@ static void rseq_slowpath_update_usr(str
>   	}
>   }
>   
> -void __rseq_handle_notify_resume(struct pt_regs *regs)
> +void __rseq_handle_slowpath(struct pt_regs *regs)
>   {
>   	/*
>   	 * If invoked from hypervisors before entering the guest via
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

