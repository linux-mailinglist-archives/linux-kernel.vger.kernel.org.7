Return-Path: <linux-kernel+bounces-787146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A9CB371F6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 20:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D62203A2E58
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 18:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E276534F48B;
	Tue, 26 Aug 2025 18:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="tQL87x0K"
Received: from CAN01-YQB-obe.outbound.protection.outlook.com (mail-yqbcan01on2135.outbound.protection.outlook.com [40.107.116.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0EC19DF66
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 18:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.116.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756231832; cv=fail; b=YQcYE86i4I2OyJnycbKxXIJZrkpWtc4KtbxwCfIUBnDDWDGz53WNgujBwa0Cq71GLvzARutMw2Pw5E6iGzK/gVJBxFO7Hsh5U+cYjitZe9RhIf67f8E1VxaKZ1gy8TyHzF9c3+XSp+VxzyIfbEaO49kDsAJak+EPnIGClu+aVeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756231832; c=relaxed/simple;
	bh=m1/bvlSARPjndXWDLFpVlf3ByY7P5D4t86GPzZ7pTzY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S6kaEUF58p4bfUnzKmPSo3A3wc7ANU5l0p3CMM8EKNd07/h57XjHbAm8ztoJ6ieY356t04/gOn67o4+puZM+d8aOTMxwrwdZrGRqcYUlBA4A1vyPMZ/O7afnfSkzLV9wQRdlQsl1cScpQaPzIJKPRKj7ij0ghvGRsax4tDrpjgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=tQL87x0K; arc=fail smtp.client-ip=40.107.116.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OAsqzYO41XBxPeBSWrHOPceXrn9mOVph778Mdsc8uXsQG5hrJrCnqLhi/6OzNW75bx3yW354OELJdxp//bwS8QFlyCATeD6JQhqD1FCUyM5XUAatU7750UubZ+RkhMA03vC5hIswPkSGLeXTAMTVrckucCoWEEOY2nw/sNF+6vO4X2T762AQpr/d6tMIkzoSOKoyj/UNUCS1kMVmaz7KGAxjrxCgn3c7/OyVRi3ojiulHOhn7cPx3LUF9sn471lOBNUuFHlkv4CZkpIB4qNfFlSupSW7u0dE/itCiey2rpmMW3oJa1IEGK4wqWD7Dro+Kb9O6kETUIy+U86fZiH3kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=exMnlQLpdD+yjLbov5H04WdhiDHJ/bvWjkVIptk3Fbs=;
 b=qlbZ9h/gq3WR4BPhziwK0NLJzaALHqD4FAvd6T9QWPJC909qI4aQM0jnYDeuLAf2lOSuzN0XEoD14VV3B041wEOe115x6ZgTAP6e3oBX/J+wBy0i28kPzes7vkx6Sz+RHSkeYeiHcpuGVfFAiHuEbvaCOVqEL/t0JaXBad7dVVSepX0S5V9FKLAKozqFgo7LlPgLqhwKAlE72HBUvsXCtioOaHlRfKH2NOeSteE3t/RhTIRcoLRvfiGv6ATD6eP0bo3zmdjPn4ZfSiHPX65RPCe8qcEQTuAG+Q0l0DdyVRuAcU7dCYeZ7jyUIZt3XmqZ2FloHqYe5C9INppAM8iV7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=exMnlQLpdD+yjLbov5H04WdhiDHJ/bvWjkVIptk3Fbs=;
 b=tQL87x0KTIEjATiM93diXXoket29Zc82Tuzklz/xWnRdHYwXb78BkwURF6+oyGnPNgejKvx7OdW/AfJCYfEeMDyuZkLrWQGFBeykts1gzh7cKE/zrdXAWhfcctQvQXI4REZ1qS+vW+bnTMIaI5HXWPz8etEXM8e7bYGWMNjX1gPSUi2zwer0b1Ky5hPUrRPYew1n70grHHE0Uh+LjMbZ1avNKLWl1ZWkINzsWVF0/RGXTogVcwIwf25mbycnBkmPXz6hlTKiyy/l0r1sAO0A+1qHBrdtDpgfCKcWZOUU4HKWjHpcyEpI7k7JNWCD9PV0/FKpnusWF6YUlRdzNXwKoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT1PPF51DB93001.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b08::538) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Tue, 26 Aug
 2025 18:10:26 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9052.021; Tue, 26 Aug 2025
 18:10:26 +0000
Message-ID: <7fddf82f-e85e-42c5-90f3-9cfca4d8756a@efficios.com>
Date: Tue, 26 Aug 2025 14:10:25 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] sched: Compact RSEQ concurrency IDs in batches
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
 Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.org>
References: <20250716160603.138385-6-gmonaco@redhat.com>
 <20250716160603.138385-9-gmonaco@redhat.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250716160603.138385-9-gmonaco@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQ1P288CA0006.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9e::16) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT1PPF51DB93001:EE_
X-MS-Office365-Filtering-Correlation-Id: 51d37c24-0918-4fbe-1a2e-08dde4cbd516
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ckR6eFA1U25xbVZSMmlnQUxoQTdkcElRM0VVZFpRZWdIRGoxOEhqdzNGMmly?=
 =?utf-8?B?NmZBcmIvaTA0akRQenZ6NUdWQi9MTHdGRERpQ012Vk9SU2RDb0xGL1lnajRh?=
 =?utf-8?B?YU9yM0s2Skc4czRPZzlyMm5MejNYNkxYdXQzTEloN2I1SExFYTBJL2ZqdE8v?=
 =?utf-8?B?Ti96cVFhUWpjd2VneE0rRmhDT3FIa2UrWnNBUnBmb21XaFhaWFY4SVp6SHBx?=
 =?utf-8?B?K0RIZWpHRUhXVmpKeUU1NmtmWW9VTXQycW04N3hBZ0J0cVVMVmtmVmFCb1U5?=
 =?utf-8?B?WWN5cFk1MWdyNTJSUXpOcjVkMXpuYnJDSU0xZVI3Mkc1U2pqMVJiY0l4UlFo?=
 =?utf-8?B?UWpnQnA3eW9nYTZ0aWg0TzluajkzKzZQUjFkZnVncHJZQ2cwN0t2NmxHVlRO?=
 =?utf-8?B?a1I3b29wdWRsTmUvZjNsOURhZldRUHFCRFJhM0FpNWlreFJXVFJMMGhJVzhQ?=
 =?utf-8?B?VGkwdzlvRHhDdjdLc09hTE5IYVRlVGRoQTNhUGVuNmlaTHczTGtsU0lqOVc1?=
 =?utf-8?B?c0RwTWtDWVZDZXZGWENZbHpudUM1UW4rQ2RIL0duSWhhejFWdVY5WXMzZjVp?=
 =?utf-8?B?ZkdGN0FTenV2MXFnUkdhekxZTisyT0xMVDA0R1hkS1k4SXJzTS9OYkJ4V2Ew?=
 =?utf-8?B?NmhhWFVGMWpvRnprbGFQamRoQXhwS0hTdWw1dmZtcjhSVnhxNXhnQ2VxOXhw?=
 =?utf-8?B?czBkd3pZcnJQUElESHhwY05VT1dyUUtyWUlvOGJvZkhUVk9JdmZpdEw1dUNr?=
 =?utf-8?B?QnhYUGY4aVBxTXN4RXFWbUEwSG4rWHk0NHNMdlRINXAwVFpYTzNKL0JPVC8z?=
 =?utf-8?B?RHhZS0kwUmRMQkhFU2ZuYlpmZklzYlJvdmdGRzZISys4dkxPQ3l0UjMrRDRC?=
 =?utf-8?B?cHBWR1VzVHhWcmJURDlzeDIzK211MVRldGJCQVpVd0NEZ3FhM0cxdFpwSEdr?=
 =?utf-8?B?bERFZ0NSTm5PaXNubnllRllEblNWVDN3ZWRpR1J1aXA4NWxTTGJkOUxWdXFj?=
 =?utf-8?B?anlaUjNxMWR2M2xmdFZ4OTVzdjNYNi9RZHlhUFBsTzV5c2JqZS9wUlJLdTNj?=
 =?utf-8?B?VENTVTBiLzFzNndOT1RBMVp2RTl5cm5lcStBek52aVlpTDhXeWtYWk1Ga244?=
 =?utf-8?B?WDV1R3VHZ0lNNE1xck5pRXBZcm9hcStjRTVqa2JnVGtaRFRURlQxMjhSb1lk?=
 =?utf-8?B?UVVTMG9ENDViUTE5a05vYjRnOGNCeXAzOXdhTzhVcmpPYkUxZjk4MW43dkEv?=
 =?utf-8?B?RTY0bXBlQW5hUXZOaGZaR3Q4ZHF2TmF3M1dGU3BBSncwVTVkVEJhN2o1ZG1I?=
 =?utf-8?B?WDFFbkRxUTZKUXk2andsRkNwMDBYaFpCdzlzVUxrUmJnVm5FZEY2MnhTbjNR?=
 =?utf-8?B?K0c2U081SlhlOEpWQ1RObk1TZ0lhZGw2Q085Z2tHUkVMTXYxeFp5a1lPRGls?=
 =?utf-8?B?eC9JTFpaV0FWQnJJcTV0Z0s3NmZaMEZvNFNMb0dmT2IxZEFpN3JZSzgxckdY?=
 =?utf-8?B?dVRwN3ByNmtZVVNPZ1hyMDVtL3NYK3QvbEFiODYwUDVDZFlhWmxHTEhhNDRn?=
 =?utf-8?B?Q3F2Wjd1aDAzdjZnOFhnYlk3SWJjeWlnMWxVRUcwVnZ6TWk5eFF0aXVHQlpJ?=
 =?utf-8?B?bEJxTTA0OXI0M3I3aGJNLzZEY05PbzZ1VkpyK0x3ekJ2Mm13YmxyZXBjdEdK?=
 =?utf-8?B?dGMrcTZ0WkRaRVl6bHdsQnhtd2xseFpvRWQ1MTBPR2ZmQnB2QzdVK3NDbHpL?=
 =?utf-8?B?WHdVTlpLZHNCTFFoaGhFUHRkdGdLSG83bkRwTUdUb09FZUlEV2t1bEF2TFI3?=
 =?utf-8?Q?v4O1b+hKdb+IJPEroo/FYZIgFPERQxsG9y92Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MlBvYkIra3dYcjR0djdxanhLQWM2TzlldFEvZWROaFBHVzZ5djdKMkFwQklr?=
 =?utf-8?B?cHF2ejJjRXgwR2FvZE1VbXlHRTQxdkxvUEVnbk9vWE1pQXppcWFjbmFRSVor?=
 =?utf-8?B?K1U3Rko3MTN4SURRQmYwZGd6aFBvdzQ5WGJlWGQwNlNDTVRvRktUaVNxYjNS?=
 =?utf-8?B?OW1RY1lmeHlSU3B4ZEgzSnFQcCtvT0hZdTRGQVVqUGc0ZU54S0hteG9nTzh0?=
 =?utf-8?B?dlYyeVgwNWo3Ynp0bzhENTJEd250dmJqUGhRTXRHWndJN3prVFNhQ0huVVdw?=
 =?utf-8?B?T3BBR2JHcTNVSmc1OGhNcXh6WTNXa1dIVTB5MlRhdm5wU1VENDd2dDdiYTRY?=
 =?utf-8?B?cVozNVRhWGNKcGFld1B6NjJqZlhRU1ZRY1NWYjFUK1BCUnFUeXpiaGl3WkxP?=
 =?utf-8?B?OHcyZ0FFREZoNEhHSWI0dS82YjByL2o1U08vVllVRWdYN3poNGR0bWZxaU9l?=
 =?utf-8?B?bXl0UGZDT2Q1UUxXNUJEdmFFM1dNdHNTaHNtdmFUVVlxZjFkekwweFpubXFN?=
 =?utf-8?B?ZE1pTTg3SXM4andLTGl5OTJxNHN1emxoN210UVlpMjhjazJKV0JJd1hnZS85?=
 =?utf-8?B?bFdwSStpZDR3SVdwL3J3bm5LMDNJMFpIaDVuajV5Q2VGRzg0UTFBMWhXcTg2?=
 =?utf-8?B?Q01ZakNFUGM1ZmJDdUhINFdOVTJ4N3pQVGNVR3RPQWN1OFIxdFY1QWxzUjJm?=
 =?utf-8?B?enVkclNDaEU1VlQ4STJnUm41bmE0d1hMejZOcDNCbmt3dHFrdHZ5OC9jVnpj?=
 =?utf-8?B?YnBaUGl4bkRrdWJzTUlWbFBIUzd0R0ZhZDhsRU01MkNDY0I5UWIwdXhOaTNK?=
 =?utf-8?B?aitmRjBsZ0h4c3puL3llYnNha0xhMTNHV2xNbWVuamcwM3NMUTA3UWs2SE9p?=
 =?utf-8?B?aG9tUVF1eGlnZFVaOG9VbmlOVkNRanYzMkNSblF2MUtPbzNzaU1HSXhTK2VF?=
 =?utf-8?B?N2Y1RXlMU1Jra0w4RGZaRmpRemJwd1QyRXdYV3RRVDRSQ3lPN05HWHpmbGZr?=
 =?utf-8?B?MXZvdVIxNVJ5M2pTRDREZVpmNVhyOVZCTmZISUhXaFdXdkpTd0lwaURLZDBZ?=
 =?utf-8?B?Z2VFU0E5cG5Yd0JOQS9EVERHckQxcTJSREFDR2RjdUtBcHdnNVhNZ3BOZHdk?=
 =?utf-8?B?T3pONTJPVmNOS0FwbjI4TDkyT0ZrNkFobU13NlhLNEd3YU04UDhJTHdjbHZB?=
 =?utf-8?B?OGhsMzdnNnhkZnYrMTVrOXhaSEhqN1oxSkErMlBiUFNKV3pLMlRraWxRQ25V?=
 =?utf-8?B?b3dqQm1pQy8yendUUlRjdnBLV29vcTI3OXpkWm9BcXRBclk5aWgwcmtncHY5?=
 =?utf-8?B?blRwZkVtdWhGRHhKZkxtYnJLMllKeDVCb1JKc0R1dkd1UmFpYm00aVl6WFJL?=
 =?utf-8?B?NVFLZ1g2REEzRUt0ZUczRVhTWTYvZW5yOHorekNTRXpoTVpNR042b21vZldF?=
 =?utf-8?B?eW9TeDEvV1ZYcHdhODJpdWJKUnE4a04rbGIrQ1puY1M0dzFMcDFqWmY5WFFE?=
 =?utf-8?B?cUZORG0zbVMwYUVyMDdpMWV6VzQ1Mm51WHpEWUdHeEtaeVdHQ1lEMDltWksx?=
 =?utf-8?B?Vllwem1QSVE1eElGaGV3S0FsdldQWnlIdFVtUnhHTDhSakhrRDRrOHE2WHhO?=
 =?utf-8?B?aU1XK0twWWk2Z0NyRE9WRUduQnRzVENSTmhjUHcyL1pJaWtCRHhkQTluMjlO?=
 =?utf-8?B?QTU5eDlZLzlRakozcE1tWXlTOVdFeGZTeVlzcU9Ud2dQcTZzeG9vZFl6b253?=
 =?utf-8?B?YmlFV3dwdGJvQ05YMXhqbjlhZ0Zadi9ZMTQ0K3VvNnI4UHc2TndRL0tid1h2?=
 =?utf-8?B?N01LNFdnTlh0d2l0a3BJZ1ZYcm5lS2NxYmp0eGR3SVlkQUhLSEg5TVNIc2dr?=
 =?utf-8?B?ckM3c0NCQ2l1dWlFdHVRaU9DQ253MG50eWpWclI5Y3dqTnZSaVpzY09XR1Aw?=
 =?utf-8?B?SmxRbEhlMSszeXh5VXlvdVpGYVpFdmZDbnVNUE1LS01QaldnTjI5OVg5ZGRH?=
 =?utf-8?B?ZnNqanlSU1JnQ0U0Q3NRdjRHdHByUExGUWQ1TC90MjJxaFcrbW9Cb3ZwZk9x?=
 =?utf-8?B?ekJFZ1QzMU5nYk8ycElDM05EcnA0K0FxYnZhZ3MzRHhFS3RXWE9HVk9Ec2hh?=
 =?utf-8?B?bTZ0TGFMSXRERTFIazVpZUZLRlFUTm8ybnFoRHYxYkE5eTZUVmFSOXZQT3BJ?=
 =?utf-8?Q?luwBs5eys0dQ7KcbrlSH5oE=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51d37c24-0918-4fbe-1a2e-08dde4cbd516
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 18:10:26.2519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zEI/LRfSwMrWZbyQeCSS+hTwTk1zeio3UpWLlSrjvuS4sDd5AhLwoe2YBjH5l7ZgcbOt/HS9htKXIpGNyBnI3eax/GTOOI2y9YRHsJE1o4w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PPF51DB93001

On 2025-07-16 12:06, Gabriele Monaco wrote:
> Currently, task_mm_cid_work() is called from resume_user_mode_work().
> This can delay the execution of the corresponding thread for the entire
> duration of the function, negatively affecting the response in case of
> real time tasks.
> In practice, we observe task_mm_cid_work increasing the latency of
> 30-35us on a 128 cores system, this order of magnitude is meaningful
> under PREEMPT_RT.
> 
> Run the task_mm_cid_work in batches of up to CONFIG_RSEQ_CID_SCAN_BATCH
> CPUs, this reduces the duration of the delay for each scan.
> 
> The task_mm_cid_work contains a mechanism to avoid running more
> frequently than every 100ms. Keep this pseudo-periodicity only on
> complete scans.
> This means each call to task_mm_cid_work returns prematurely if the
> period did not elapse and a scan is not ongoing (i.e. the next batch to
> scan is not the first).
> This way full scans are not excessively delayed while still keeping each
> run, and introduced latency, short.

With your test hardware/workload as reference, do you have an idea of
how many CPUs would be needed to require more than 100ms to iterate on
all CPUs with the default scan batch size (8) ?

> 
> Fixes: 223baf9d17f2 ("sched: Fix performance regression introduced by mm_cid")
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> ---
>   include/linux/mm_types.h | 15 +++++++++++++++
>   init/Kconfig             | 12 ++++++++++++
>   kernel/sched/core.c      | 37 ++++++++++++++++++++++++++++++++++---
>   3 files changed, 61 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index e6d6e468e64b4..a822966a584f3 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -995,6 +995,13 @@ struct mm_struct {
>   		 * When the next mm_cid scan is due (in jiffies).
>   		 */
>   		unsigned long mm_cid_next_scan;
> +		/*
> +		 * @mm_cid_scan_batch: Counter for batch used in the next scan.
> +		 *
> +		 * Scan in batches of CONFIG_RSEQ_CID_SCAN_BATCH. This field
> +		 * increments at each scan and reset when all batches are done.
> +		 */
> +		unsigned int mm_cid_scan_batch;
>   		/**
>   		 * @nr_cpus_allowed: Number of CPUs allowed for mm.
>   		 *
> @@ -1385,6 +1392,7 @@ static inline void mm_init_cid(struct mm_struct *mm, struct task_struct *p)
>   	raw_spin_lock_init(&mm->cpus_allowed_lock);
>   	cpumask_copy(mm_cpus_allowed(mm), &p->cpus_mask);
>   	cpumask_clear(mm_cidmask(mm));
> +	mm->mm_cid_scan_batch = 0;
>   }
>   
>   static inline int mm_alloc_cid_noprof(struct mm_struct *mm, struct task_struct *p)
> @@ -1423,8 +1431,15 @@ static inline void mm_set_cpus_allowed(struct mm_struct *mm, const struct cpumas
>   
>   static inline bool mm_cid_needs_scan(struct mm_struct *mm)
>   {
> +	unsigned int next_batch;
> +
>   	if (!mm)
>   		return false;
> +	next_batch = READ_ONCE(mm->mm_cid_scan_batch);
> +	/* Always needs scan unless it's the first batch. */
> +	if (CONFIG_RSEQ_CID_SCAN_BATCH * next_batch < num_possible_cpus() &&
> +	    next_batch)
> +		return true;
>   	return time_after(jiffies, READ_ONCE(mm->mm_cid_next_scan));
>   }
>   #else /* CONFIG_SCHED_MM_CID */
> diff --git a/init/Kconfig b/init/Kconfig
> index 666783eb50abd..98d7f078cd6df 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1860,6 +1860,18 @@ config DEBUG_RSEQ
>   
>   	  If unsure, say N.
>   
> +config RSEQ_CID_SCAN_BATCH
> +	int "Number of CPUs to scan at every mm_cid compaction attempt"
> +	range 1 NR_CPUS
> +	default 8
> +	depends on SCHED_MM_CID
> +	help
> +	  CPUs are scanned pseudo-periodically to compact the CID of each task,
> +	  this operation can take a longer amount of time on systems with many
> +	  CPUs, resulting in higher scheduling latency for the current task.
> +	  A higher value means the CID is compacted faster, but results in
> +	  higher scheduling latency.
> +
>   config CACHESTAT_SYSCALL
>   	bool "Enable cachestat() system call" if EXPERT
>   	default y
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 27b856a1cb0a9..eae4c8faf980b 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -10591,11 +10591,26 @@ static void sched_mm_cid_remote_clear_weight(struct mm_struct *mm, int cpu,
>   
>   void task_mm_cid_work(struct task_struct *t)
>   {
> +	int weight, cpu, from_cpu, this_batch, next_batch, idx;
>   	unsigned long now = jiffies, old_scan, next_scan;
>   	struct cpumask *cidmask;
> -	int weight, cpu;
>   	struct mm_struct *mm = t->mm;
>   
> +	/*
> +	 * This function is called from __rseq_handle_notify_resume, which
> +	 * makes sure t is a user thread and is not exiting.
> +	 */
> +	this_batch = READ_ONCE(mm->mm_cid_scan_batch);
> +	next_batch = this_batch + 1;
> +	from_cpu = cpumask_nth(this_batch * CONFIG_RSEQ_CID_SCAN_BATCH,
> +			       cpu_possible_mask);
> +	if (from_cpu >= nr_cpu_ids) {
> +		from_cpu = 0;
> +		next_batch = 1;
> +	}
> +	/* Delay scan only if we are done with all cpus. */
> +	if (from_cpu != 0)
> +		goto cid_compact;
>   	old_scan = READ_ONCE(mm->mm_cid_next_scan);
>   	next_scan = now + msecs_to_jiffies(MM_CID_SCAN_DELAY);
>   	if (!old_scan) {
> @@ -10611,17 +10626,33 @@ void task_mm_cid_work(struct task_struct *t)
>   		return;
>   	if (!try_cmpxchg(&mm->mm_cid_next_scan, &old_scan, next_scan))
>   		return;
> +
> +cid_compact:
> +	if (!try_cmpxchg(&mm->mm_cid_scan_batch, &this_batch, next_batch))
> +		return;
>   	cidmask = mm_cidmask(mm);
>   	/* Clear cids that were not recently used. */
> -	for_each_possible_cpu(cpu)
> +	idx = 0;
> +	cpu = from_cpu;
> +	for_each_cpu_from(cpu, cpu_possible_mask) {
> +		if (idx == CONFIG_RSEQ_CID_SCAN_BATCH)

could do "if (idx++ == CONFIG_RSEQ_CID_SCAN_BATCH)"

> +			break;
>   		sched_mm_cid_remote_clear_old(mm, cpu);
> +		++idx;

and remove this ^

> +	}
>   	weight = cpumask_weight(cidmask);
>   	/*
>   	 * Clear cids that are greater or equal to the cidmask weight to
>   	 * recompact it.
>   	 */
> -	for_each_possible_cpu(cpu)
> +	idx = 0;
> +	cpu = from_cpu;
> +	for_each_cpu_from(cpu, cpu_possible_mask) {
> +		if (idx == CONFIG_RSEQ_CID_SCAN_BATCH)

Likewise.

> +			break;
>   		sched_mm_cid_remote_clear_weight(mm, cpu, weight);
> +		++idx;

Likewise.

Thanks,

Mathieu

> +	}
>   }
>   
>   void init_sched_mm_cid(struct task_struct *t)


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

