Return-Path: <linux-kernel+bounces-874120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E12C6C158DA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1C0B189DD9D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681A433DEFF;
	Tue, 28 Oct 2025 15:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="PvpKA4+4"
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020103.outbound.protection.outlook.com [52.101.191.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4458195FE8
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761666035; cv=fail; b=URL/15in7zvB1rcSZfln239es2UVhRjqhWUiIinTiZyoRat160chUaBP2JkPa+MyaQ66plHAvKW676QbN9zh9fofB1XuFgJ4DW0Vskb3xRFQ/BwB942K1MagMio04Bxw/9WQK3xTW5kwKkYqfym2ABYcpunnRxgv/Utf86f+Hr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761666035; c=relaxed/simple;
	bh=WBQvNGTD9AlgafohLK8iqCtUxi+de6+b3f7W3q0pwlg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GD3YfmTKncjdet0tOf5JVMNfdYxNG0Wcj4WjFstFZuq7AuBt6Sv5awzBIZuzRJPWGncUCUUbAcEw9JzPwB6xj6OhY/0l76Ehbgmtn6hTZIE3HddEnvZb78LF+ly2Q6w59Q1Ao+73Ov5UDvATzTYguFxMFP45XsjwQ6P6pdjxJyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=PvpKA4+4; arc=fail smtp.client-ip=52.101.191.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IdL1yRFkoXcB3tYemwhxTZCLljx+Nd6GLvxcPig0LB05RC+FOSBlTjabESBB3pIgN8DnZxg3qSmgS5JoTCPSp0ZVP7SH2WYUixSY6xhwHMVS2v37LUtnuvL7b+3j6FYVieze8r+w/IWbeTNLMyEYU1ZJ9kz45AJTiPHYN5MiWoHKtoFptBjdG0ZQ3Frp+3DsYrXY18zzRFlZAh2tNrJvkwSTkpyXvYC9MgGGB9m08SWaSUn3I05gb9fGcgR9UoId8JVCiyFO2xeeAqdptmz2sOJktjXDeDujDezCa/DYoZaf87njPvzDOqnwLg22I5G4zbWmqG5rUXX+eolwsrLsRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bAbviNVSkjrjU5eQgxzekGfav+E2MetaY5N19VSfqGY=;
 b=H7XyEQTgejUEgxNcZF8nfyDsd47XyEw3cWnbzVFfOTJm29oYOtjF2tAFjTFAm9FOGiLLlejNG/ioHLw9zucK2CbKzZWFBqPXgzD9eVBYnUeTM+7bOizhCvQ9B44FwOMw8BdjhTKLScuZw9w+OIlRwmpv1vjUvrUQ2Jamvsx0Sv5FEVxLawVMAbDxnYyv2mCxhfBeqYjbPbafjDR9VrmOVEeDebgtwiuDH4Xi+mUQJ4Sm5+9BNX+RvYVojlo0OmzEvlQ5nj8bgNhemesOhW8p0mZJ/XOoMVz+G3RlaGvTuUsLhmlGV2B6hJPjKgrClSUeM4aoYV7w8V/8wOHnRzmsEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bAbviNVSkjrjU5eQgxzekGfav+E2MetaY5N19VSfqGY=;
 b=PvpKA4+4OlGFIcZVR4jAwQ6NhLMT+25aikb/dj6k2PlyXXe7PImkmkvGXgQOGtR4ZTIk/m7CaK00KAlvtSb9j9MRf0ewYjeIaMaJ3I3nJaE4Z00SpbAA52w9YG5D/QjfS3LA9xUaDgwBixRzyuQ8echXMc/UrVOxCjlecnSrQ+yxoxHxAI4Hc2qfiYLhpXDVmNwSra09vH3OOcUa+1nr8TlNLhnv2/jBuJFMPhvXHXBlrUlZ8ESvhq1ONkkLHmxSzBjhApWnke8XGnbNy8wHsP5DDAGCla8yQqnfGIlasvaiizEUjn9WtVD/6YI1wUnrZWiVd6moMjpUQQLDdH2aKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB8693.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:b5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Tue, 28 Oct
 2025 15:40:29 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%2]) with mapi id 15.20.9275.013; Tue, 28 Oct 2025
 15:40:29 +0000
Message-ID: <630304ec-f24f-4452-a804-463197d2b936@efficios.com>
Date: Tue, 28 Oct 2025 11:40:28 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V6 19/31] rseq: Provide and use rseq_update_user_cs()
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Michael Jeanson <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>,
 Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, x86@kernel.org, Sean Christopherson
 <seanjc@google.com>, Wei Liu <wei.liu@kernel.org>
References: <20251027084220.785525188@linutronix.de>
 <20251027084307.151465632@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20251027084307.151465632@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0323.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::29) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB8693:EE_
X-MS-Office365-Filtering-Correlation-Id: db22b590-a0b1-4625-75d2-08de1638528a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RWhKUTNrMm5lV08rYzNpRjBBQ3ZEL1FLM2VoeURCbUZRTU02TTc1a1VMSWFo?=
 =?utf-8?B?WU5jUWZWdEsyYktRd0tUNjZlY0VWWXluM1VHa2czeWZhN3VsRloyZS94TWt1?=
 =?utf-8?B?Wk5KZkQwMDFicS9uUnBNbEY0akJSYmlnOUxXd2ZpRTZTNEQ0QXhKekpGTXRr?=
 =?utf-8?B?OFFsUUZFQ1hMK0dNejZwWG43MmpvMWdSMmpUVkpqSnNOdFZJWks2RTV6S2hE?=
 =?utf-8?B?aUVoL0MzNVRGL1o3enYxcUM1cVZLNlZuZ3hvYXBvNm96ZnhoOGpLQmdwQkJi?=
 =?utf-8?B?dWYwWDFkVnM1WmVORmk1bnFDQW1hVHIzWFNreUcyckppSDEvam03clJTa2FQ?=
 =?utf-8?B?VHBxTkRTVzErN3JKVTROZmhZbzNIYVd3NVdqclQ3cXh3SUlxVjAzWVI2bXRP?=
 =?utf-8?B?OTQyQjVmL00xdUNheEJXMXphRytLTUdHSE94T1prTnZCMlZmY3J4RFhMazl2?=
 =?utf-8?B?S0tUVlhkZkN4bUozenBTMGcxOTBRMldFcWhtT3pOMVZDdER1M1FmZWozSUE3?=
 =?utf-8?B?cVFQekxIYWZvNjROWG5Zb2xweFdrc0JWeHlsN09scXV2S1BTWGtZSEtid0Qw?=
 =?utf-8?B?c1V3cE1VOGUyNEFSZmpkUHdGa3A0cmNGU0dHanV0QldWWlRoTTc2RjhaOEp1?=
 =?utf-8?B?endEdGhQWjdMa0YyL0VhUHA4OFViM2tEcWRUcDRzWFpEWmN2STd3Rm94bldn?=
 =?utf-8?B?dEtoNTdDTjkxUTNYbkxTa0RacTIvTTVkSldpR3hsNEN2WUxhS2VFRWVlSU9E?=
 =?utf-8?B?SExnaFYzcFhxSCtneXNmc0p0NlhETlErUWxMRWw5WUVzTFBIK2QrWlg0bGNZ?=
 =?utf-8?B?anVUTEJsTjVUcjVOMUFUOGx1NTJvY2UzSXpBN3ZpMFV2WWowbHV4a0tVdzNE?=
 =?utf-8?B?OTBFNDJBYkoxcWpkbWhiMkFIVnRrQWxaemxqSS9jaXBGeE9Tb3FheEk1VjNw?=
 =?utf-8?B?Zm9vZFlmRy9KbnJFNjIva3ZaeU4yWkVWOVU4ZUFaeGRIN3ZmRHlZS2NNL2pS?=
 =?utf-8?B?QUIxdXovcGpWa0RTOE1IWGRtV2NVRjhHcE11L2ZxODE3MEU4L3JLY0ZOZ0NN?=
 =?utf-8?B?V0p1Z1B5Tk1UY0czMUlLZWlnaXpTdlJnbGpvTDBXQVVFSmMvdmoxZzhCdFFn?=
 =?utf-8?B?bHRsMFBsNjlkSkJTaklwc1A0U0JQdlBPZEZtYUdMUzg5QitkVVpia29KMjBQ?=
 =?utf-8?B?TWdJMmZZSFJJVEkzbTdzVlhMRTE2MVlOVWtZWHpHZG5MZ242d3VjY1ZvSkdR?=
 =?utf-8?B?blRYVm9lS2hSKzVBUk9UL2g4K1VPUVlURzBKWUNDekxzbHZsZDBFRVlkbThB?=
 =?utf-8?B?Nmw1aFRNV25ycmNlU1kwVk1SWWFQQVhROXZGdUV6MWhjMUdvQ21wckdOZmlY?=
 =?utf-8?B?amcrWXdiR1MxdksrcUFJSjNCclJXSG1vOVpxeERkWmY2WktQVjZmOWgwUUVt?=
 =?utf-8?B?QmlLc0NzaVBwdlVYTVpQbmk1dWd2WEVtcWZ1elVaOVNvcEpiOXRTNjVZZzJR?=
 =?utf-8?B?dUZEenRDa1dFM1hraW4rMjNueWJFRmpVWitiRmhESWRMYSs5TDVjSWRpUXln?=
 =?utf-8?B?NU5HSFZ5VFptQlA5S0FhRC9lM09sbHpsOFBLVVJFYmhkbWN2NWM4bTF5MTJh?=
 =?utf-8?B?b2FkaWd5ZWYzb3JWN2gzRHRRQnJ5eUppS2tQR0xFdEFmcVBKUTU0MDZ6UFZl?=
 =?utf-8?B?T0lJcGZkMlZqekVjUkMyL0RNaDl1Tm16dzA0djVrUTZKQldWK1pwOS9qT1FH?=
 =?utf-8?B?TWdYV1FVTUhlQy9jbW1iWUF2MkViRFVZcWc3elhTSmxvUThTWDVXcXJoUkJY?=
 =?utf-8?B?dHZOdk1ReWVBSkdoL2N5MTZSSVhvY2xvZUU0cFpkMXFVS1k1NnY0RXNHZ0w4?=
 =?utf-8?B?aDVjU01LU2hCWlhrZ0ZKc0xHZXdXV0tXbnVUUkhjVE5wOFE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TStKeTQ4ZExCdmgzY2IwbzBQMmhxdFNVcWZhdk1qQ0crN0NKdEx6c0pkS1pO?=
 =?utf-8?B?NS83cjRDNmxjMWdjWWJaQmF0QXNNSzZ4Q2V2cXE1bFlEMnRaM1ZYRFBIOHMx?=
 =?utf-8?B?Nyt0U1NvTXY4bUpnNGRnT2FOZWZVRFJVMnV2TERGUUZiM0xURlVvNGgwMHlz?=
 =?utf-8?B?dGlvL2MwRG9ZZ0t4UXNJU0RlT0dKU0V3UnVlMy9KSy9rN0xJLzBUcmNuMXli?=
 =?utf-8?B?MjJOYjVvekxEbEF5VWNrYS9QeHFiZ2tjbjhqUklENkFMRkdXZ1hhNU9ncThW?=
 =?utf-8?B?aTJnenhZQ0VDN1pNeWFMV2tkVmQxN2lZWmNTVlNScWZ1dTBEK3ZBQWxPS0dI?=
 =?utf-8?B?ZjM4bG1qNTlObkxIeDFXdWVvc2djd3Jsb3dFR3BETFp1YzIvZzdKZkV1VUNn?=
 =?utf-8?B?MVpaWFFQYjVoRndUTEdQdWNSa2JXTHdpckpOU28yV2dxK2M1YVFjbngxYzIw?=
 =?utf-8?B?K1NtQ0pLcjZaYXd6bUtpUnQ1OEFWUzF3Slc1TVBjTjE3Vk05QjhINHVLWTYr?=
 =?utf-8?B?S2I5bHIxYktOSStmTGpYMHFBUHhia252UHp0OEpDd3h2Q3RkWlA1N040cGhz?=
 =?utf-8?B?VU41QkRWZmhlR2tTVGJoYmVQWk5JT2Q0OTYxUzd2SWVJQ3dMY2s0eWpEK0Rx?=
 =?utf-8?B?Y29SVnNkeDh0ekE1bDVBK3pndGprbHE3a2tlNzMyWkJJYWhLdUpuUU9iYm5y?=
 =?utf-8?B?WkhpNjZHN09sWEhLaStJYStYd1NpTENEVmtaN2JKdThmdFBYM29EQTdUanhk?=
 =?utf-8?B?WmxaaWI4dys2UENBVmdxMEZWM09nMlMxZ2F0QzlzMHJ5TVNBNEFuZUIwbTJ4?=
 =?utf-8?B?VUx1VTRGaDIrd0ZzT2owNUZzMllzamo0ZlZHdHc1RGwzUzVXdVZ4Qk9RTWFy?=
 =?utf-8?B?YkNSc3ZsbW4vNDdoODdsZ2RTdFdoelhoRnZCbnVFeFdtRUYwdW42bHI5bkJY?=
 =?utf-8?B?YXA4UGRKbDRuTXdhQW93ZWRxdjNYTmpBTGZqOTNIQkI0MGU3VndQY3czNDRH?=
 =?utf-8?B?VWx0VXIrdUdyUGJIZTBFZmZGQXhxQm1RNWIyZzlsZUJDbWtNaW5XeGlwSCth?=
 =?utf-8?B?REM1VGxXeHlNYmJkTDVlVW5oNHAyQncwVGhNMGFFZkIyNWgxRy9MNUxBS2Yv?=
 =?utf-8?B?WWVwdmhCZ2t6b2JiNVB4czYwZlFYMytQRXNXK0d3S3ZHQnhRcXYyS2t4ZW1z?=
 =?utf-8?B?NTFCS1RVUE44d2h0UjlzOXVsTGF1K2U4eUl2bTh6MnhVWC9OM2ZWU2l4OTZy?=
 =?utf-8?B?NElrK0YraU4vc2ovVWpBOTFTampocUFOaE9XMC9kNjVHdlluUm9TTDM5Z3Rx?=
 =?utf-8?B?OUVBbHBaa0dkNXN1QkFQY0xTaVJkY0dMc0Z6TkNQdWc1Y2VaK0c2MlVrN3ZF?=
 =?utf-8?B?UFBEZE5uWW5XTzJlRGdOVFZCeHI0clFxZXByVkszbDJsQlZHU2J0UjlJRmhP?=
 =?utf-8?B?QUxBWjdkcXlrUjhtWW0xYW84YkYyUWlraTJYME8xaDZ6OWkvWlNzRzczMmd4?=
 =?utf-8?B?aDQ1YzBvV2xVb1RhbjYxK0h4Y1VPWTJGZURqcFZ5ZVBtMHpTL0g4RlpteU5x?=
 =?utf-8?B?MDZVa0MxcGtrZWw2d1F0dk9OcXEyQTFwRmFnMlVZSDgxaVgyeFlZODcwS2Fx?=
 =?utf-8?B?eCtZSkRPU2owVDlZRUlSelV5Y3pReUUwYUREV3d6WGNmTXh4d1dXUzI2Y2JJ?=
 =?utf-8?B?VzlwMGpzNDluOW1TSHNoa0tsY21BTVQ4R0M2UTR6bU9jb0NFUGxhSStERkp5?=
 =?utf-8?B?a2RvdW5NZGRUM3FWbUZYQkxYcGlGSDF6WjF3U1I5RSs5YTBRSHErUS9lTW1M?=
 =?utf-8?B?cU54Qnp3aEtKOEIwUzZ5cjdtQm5NRjRXTUVHRWNjbXVuUTBZdjJVbEJhS2lP?=
 =?utf-8?B?UkEyeXlkbUNaZGg1V0RRU1ZYRGorUm1FWTBCWkQ5akdrUnAwdlRTRFgyN1dW?=
 =?utf-8?B?UlVDSUlETmozdU9RSVV0RENPcStyMkEzMUxpbE5hK2J3OVZZbFZidGN4b28y?=
 =?utf-8?B?Wk12ZjZWaWRGYm4xSmlrazIvSzI2MXViMXR2Z00wL0c0Y3F3alN6ZldhQ3d3?=
 =?utf-8?B?U20xYjNpWkV1b0V2d3ZzQWpVazJHOStRd2N2VFZjL1MyWldVeEhuQXliaWJl?=
 =?utf-8?B?NzNnRmczTEhVZEVvWlpwRjRsZEk0RjZKWk5DaVI5Mm5lSWJ3YmJ2T0ZsOW1N?=
 =?utf-8?Q?sDPyjH4J6/G0XJVWo9A3P4o=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db22b590-a0b1-4625-75d2-08de1638528a
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 15:40:29.5225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jepxzewncV7p1JB1JMHcX2S150BXlokKUy6sYdwZcnfZsagbc21i2qUP1baIE39YsXK9y3dYtn42v96glihscPHzVuHuOtACTjJRzSgFsEw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB8693

On 2025-10-27 04:44, Thomas Gleixner wrote:
[...]
>   
> +/*
> + * Check whether there is a valid critical section and whether the
> + * instruction pointer in @regs is inside the critical section.
> + *
> + *  - If the critical section is invalid, terminate the task.
> + *
> + *  - If valid and the instruction pointer is inside, set it to the abort IP

nit: "...to the abort IP."

Other than that:

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

