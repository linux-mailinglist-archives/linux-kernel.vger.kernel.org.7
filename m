Return-Path: <linux-kernel+bounces-785320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F915B34905
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 19:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34D675E8062
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 17:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98839305E0D;
	Mon, 25 Aug 2025 17:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="n2Biw9Ck"
Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2090.outbound.protection.outlook.com [40.107.115.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B919301033
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 17:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.115.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756143375; cv=fail; b=UIMo0BgjVSuYr6Pig+Ee1FnzIT0XWMcDQMVjUvFzCXD/VxOi68MdiGSGEQBdXujmY/shKN4KK1I6Uob91CXxf10iFxYKxUBey3ovWrWN/qA3Y7omjgt2E9tpLW260sKqKQ3szNRcjStZMxVP/r7jtQq3rAqExwp52hY74B6ebug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756143375; c=relaxed/simple;
	bh=KzYh+HscPdNDxWOxscZaI0RADW0m8H/mkK8DAIXHgj8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mG9JgNEgRhYm28STU0UBxJKnlTjg9f3aNKyl58PwE44lKu+huO0NY5Qhqk9UEzXa/Ot2zsum0U+Xu6eoFiPa56+mgcEENIi8gJwGRBFoodN9Xtpkas1XQmIKra3YQOXwGOheup9T+VnM8ZtkzutfuBwGegoT+UGMw9ZHFOaNO1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=n2Biw9Ck; arc=fail smtp.client-ip=40.107.115.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UpY1TGWgUeibw4GKRSPaktWpz1x9mEQuWbF3EnVPWGZog+I+nk6vglwE/BaeyxZ50/dRBGGdW1yaS7Go7b/cYxNpwAWOFpsL9L9bzSP+ik/W862LE+bcQ7snZ0K4XzR0UKhqTSfWYwKIJDZpkYmDY3xwIzGxOlAlQE/ncYEW5AxQFi1WZBWICYUVshwNNMsLg6HimhSqIOmmqFHKXd+K4fAD0MDv+nY1waIWT5sUJMI0OYJmveR+DZKAvR3e1mopgW8G5MNPgy4kCpoevSdEuF5GLrB9+rv05qOMBqan/XSiZ74jzWdesqQSHcTlv1LWUqiBmwPWzIXlbz2T61FGJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ge0ojBPv0Uldovp75ZOCHo03SCrzVVzWK42K1bAIEDw=;
 b=bXO1xTNpSFmY0JEEBPWgK/7MzlPySPHNRaTbAldTMEEGCPV/OooEflzniQ2YRvfch2+Gnp43h/9G4MasWkydyE36WWgBgxO0OQj1+YE8FPA247hJreoAlermp+g26PXSUQjv4BuAuBaGFFYoVDHbWk360H68yu7U9nGV53ontvCDur06pFxZ1Bm5xsdyirDRhXd+IV9B7oZejwYBxzxy6px6wek8IOujpDSq2fEgqKoCGURJY9gfN9HAfHQkElRgsspS4GWQ9Qkun+qASfKORZhT34EKMB0tDpIJr7yspy/4Al9NwMh/jhcXHyPtMXs9gXCO4WvLy2afzb9yrcITQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ge0ojBPv0Uldovp75ZOCHo03SCrzVVzWK42K1bAIEDw=;
 b=n2Biw9Ck55ioXe83NyATLtmX+5Y6ODPa2yZNiuMjxZ4+LZKKgf+/bm9EyMYdjWYjuCFxYyeL3P0ZcbquSMVzqucoditAIH/OThTiJF5AP3ysRxGJxfNBzdvj8gCxj5J75kfd9keBRjWhJo+kPjlYHyB8jclGBErPhTsGUDrJEn2OyiPZ3yrF8KRGPWZDmqdc9tzzNdzPiwykYY+DPMm7gyJhX8fDeKrjifY6V42UUcPG49VRJNGYrRmGvkp2L/iMBb7wJ7MrDmG343QlhYQqjZNuY6t7e7/CCB8saP9HDU7vcvUqzY0DrMh/mt0jRSQkUIfei4tuW0j8mm/gR+FDbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR0101MB9725.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:80::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Mon, 25 Aug
 2025 17:36:06 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9052.021; Mon, 25 Aug 2025
 17:36:05 +0000
Message-ID: <9aa047e6-cea5-4f84-b763-36d8d5ad4731@efficios.com>
Date: Mon, 25 Aug 2025 13:36:03 -0400
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
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>
References: <20250823161326.635281786@linutronix.de>
 <20250823161653.644902433@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250823161653.644902433@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0053.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::25) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR0101MB9725:EE_
X-MS-Office365-Filtering-Correlation-Id: 002bb60f-192d-4ded-fd4f-08dde3fdde3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MFFLRGR2eThjY0VPVXRzTmlPVU9NdkFrZDVqbVp6MmJWMlhDZENqNG1YR3RD?=
 =?utf-8?B?SHJaTFZUcjJGeTNoR0V0ckl6MmVtL1hQTHVjM3I0ZHdVekRCc0JGblB4S01E?=
 =?utf-8?B?MVFmbjBGZXJvcDFYVkxaOGk1N0NKWUY5b1MrZ3hNdzFsWndHeTdIMk1oUll3?=
 =?utf-8?B?dGV6TEpjNFQ1Wi9pbWY5Zk5WUlowSFQ5OHI5eWVwVHdzdVY3ZzJoUWZxWmZt?=
 =?utf-8?B?R0RZbE1ITWNMME54QnNtQWNaMEtObzVWK092dFBQT0ZDQ3hGcVM1aTJLTDRF?=
 =?utf-8?B?aEJ1WFNxb1ZObnpHQXBGMzJCNlB0bG5YU2VuVEVBbWU1RUd5OTVCYkM1dVVh?=
 =?utf-8?B?MmRIQk11TWE0bTc0Z0FWNXpUd2M0THduaWdsSWo0OURQUWUxVjQrK2hBOW1T?=
 =?utf-8?B?c3VhbmU0YlZCTGc5ZGZXNU9EWEg0SDF4Tzk3dGlGV3BkeEE2c3BQL25ENDhk?=
 =?utf-8?B?bGpWd2k0RXRjZDRiZ29ZRWZVVnVrdTV5R3ZoWlpDRTFNQ3hza1RxVi9uSzNL?=
 =?utf-8?B?Qy9vWmY3RldrTkFnN3FMQ1AyWkVHZDdsVVV5MWlVbEkyOG1pRE93a3hTVmhU?=
 =?utf-8?B?Y2taZmpBMHVXa0pQS0lGdUJ5R1ZiYjRFckFvcitQOGRYRkcvRE5IWjdYcVJi?=
 =?utf-8?B?NXZZUzB2REViUGhaSGk4SklLSWRWQzY4RE55TFV2MGtPOGNkd1UzMGdWOGxa?=
 =?utf-8?B?OWFkM0VWTER0YktHWWliVFlyb3Y4SUdzODcwZDNQSU5hTGlFT2FFenpUbWF1?=
 =?utf-8?B?KzZObE1TTHcxMTBVbkhsOS9tK3hGT09MSUJUdysxN3kzUXlCTG50Uks0ejZX?=
 =?utf-8?B?WTErNkROWlcrTmZ3OVNtY2lXc0U5Qm9QeWtqWC9xRW5YRGlDQnhnYWQ3eWJh?=
 =?utf-8?B?OTNtZFBmd3VoRjYvSU5qdjdQcThGcC9TK2ZZbDRDaFNzRWpwNndvZ2lnQ2ZD?=
 =?utf-8?B?OUFvRUFmSnRHaTAybnNCeDErcHhBUTlCbU1DdG5Jc3NINWRGSG9tSXJveHpC?=
 =?utf-8?B?U2RUNlEyUnp3Z0FqZjZJYVNvYkdPZVAvVXAwN2ZRZVZxQnBZN0MyTE1maGpo?=
 =?utf-8?B?NDhBRkNRZmVPYjNUTVdTaVJhemJvU2pZT2k3a05CUmJTY3lMb1VnUVFwTld0?=
 =?utf-8?B?bm9MZCtWTHluRExWMk9XT1Vuem9BUWxJQWl6TGhpYURaYTUzT0UvSDdtODJ2?=
 =?utf-8?B?ak1JTUxPaXRpbm1IZ3lEZHVmRlFLMnNvWWx1UXlHbksyRzRDcis3WWozZXNq?=
 =?utf-8?B?ZDlZV0pMNU83emR2RUQ0YmVURHJVNEpyMEw0MXVFYW1EUENScE9SRnBRZ3VF?=
 =?utf-8?B?eE9sMlc3bldmUituTUZCZkVuMVI5VE1MQW8wVHZ2MGNESlJKQms4TUtUbmFv?=
 =?utf-8?B?aXRkRi9FSmRFUzNkOG50UUhKMGNvMW4rZURKZUxsSHVQWGxQdS8vU05zU09x?=
 =?utf-8?B?UTlCaUcrRDdOS3dXRVZhYkN5SEtCTE1ZRC96UVZNMEFoRXF2c1UyMWQ4S1py?=
 =?utf-8?B?RUpZeUlLaFdYaHljT1Jvc0JnYml3SkdybGlMU2d0UDJCTG5abjE0VTV4MnBQ?=
 =?utf-8?B?WGpBK2prc2FuTHV3cDF4a2UybWtzVTFSa1IyUUFTdXR0TFo2Q0UwVGl1MWln?=
 =?utf-8?B?SEtySDdrUVRmR1h1TGNrOHBnOCs4WmQ1dzJkRXhiK1JDM2JKK0ZjcjlSaWp2?=
 =?utf-8?B?VmhUaTRxWW9LZTltdXdpVkxnRDZ1dVdJV3B0eitsMkh5cjFUSGR1dWpzcUlZ?=
 =?utf-8?B?YXFMK2I1U3BrbWYvQzVRQVBOVEZMeHNrN21SYnU4c2FlbVFKTllvMTdVTlBa?=
 =?utf-8?Q?VXhjCZfxqeP9hKwX+t4D2v8Qy/qHb98rRVGNs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V3craHV0Nzh5cXlTVHdoZzZMYll0Nm8yOTlQditKZGFkaTFvNzZxN3BCWkNC?=
 =?utf-8?B?b3FBdzVmQ0UrejZBSTdoWmVpTWQyeVNBY2RuSDQzSkxCYzBvM1pXZ0hQK3hU?=
 =?utf-8?B?UHJaRDQ5a3p2RzFrNlg1Vk5VUXZTdmh0ZkhUMENsT1Jlb3VXTDJlU1lGTUUx?=
 =?utf-8?B?ZzFPSlZrUW9wcWpQWmRhcHQzMHRmUngxWXowaUVTcTg5OFVmMUJpaGswMUNC?=
 =?utf-8?B?bkxBSUJlNHU1WlBJamYzVWNxa1dJZGx0K2NGUXpFenJ4cGs3clFEeCtEdG0x?=
 =?utf-8?B?WlByTTNGOWpYakxnOUp6a1F0cVJ1ZVlWVUE0dVFpbC9VdnJYL3BFWFI4RTdX?=
 =?utf-8?B?eUlqd0dCU1JwUG8yYlZHSEhVM203ZTNvNHlvY3p6VC9mdEJGSlJiUXpOeGNS?=
 =?utf-8?B?K3ZIczROQ1ptSmdpUVB0OVhHSGxoTE10Q0c0MnMwdGtWN2xWZzNjKzYrWEZK?=
 =?utf-8?B?b0dmRitwNERXS3QyRU9CclJMYXVTNXo4SDd1V25CR0s4cUZpajRJZER4eGFi?=
 =?utf-8?B?Y1BSdEtKakVLbGZRc3E1NmdjRkc5U29DOEdvVmE1SDVQeFlYT0trSWRxeU9z?=
 =?utf-8?B?NERyM1FjVWY1N1lOeFN1SmZPWjFBcTdDTUVRa2kzcWpqZXlPZ2RoMnVEamsr?=
 =?utf-8?B?V052RTVHZjhNMkgxMVZEU2RwdkxCcEJvU29ENkdZcWsrQWczcGdVTGNOV3Jh?=
 =?utf-8?B?aHRtbVhKMlJjM3BaVDIzdm5veG9pbGh3U09TYU1ua3NhRXNabXBlYVZtKzFM?=
 =?utf-8?B?ZnNpZXFSZGlmS1ZlOTJrS05aWkg2TkpiREN6NnVwUjd2Z3hhd1VHTTVtMFln?=
 =?utf-8?B?c2tMVWUwSFc1WkZXWi8yU3htSWIwSU1ZNTI0eXhwTDlMWmZKWEVTOVhIUzFy?=
 =?utf-8?B?ZzVHV3Q5NnAwV09qdUt5UHE5RkZUOTI1bERNYldjSFZZbGtNVElZdFJEMHJP?=
 =?utf-8?B?QUMwcHJOL2dKeFIyajlTdGtqYlNJS3lqbzFJL3FaZG1BY20rUmI2d09JKzdG?=
 =?utf-8?B?ZjZpZ3NyaGVicENZUk5WRkFWVXY4VXJmb2RuS1poTTNlckhJQ0k2WU9MRUFJ?=
 =?utf-8?B?elZERGptWHJhNU1ydkZRTm5xT29IWmFDSDVTZkdCWlN3ckVJMkE4ZjhqM1R4?=
 =?utf-8?B?ZmtPa1VhL2tkQS9BczZnS1VmK3RIVGQxSTg0T2c5Vk95MXdMNlZBeTFqZy84?=
 =?utf-8?B?dXJPMlJHZndrb3FmNlAzVTM4Q05MZEhsWUp3Z0dqYWUxM3RRbHJGNnhOejlQ?=
 =?utf-8?B?ck5ZbEk0cXZzaVByYlpNQzQwWTJ3Qi8xdG9POFdkYktlSi9aM2FtRkM5MFpU?=
 =?utf-8?B?ZVFTUmhoU1FVbmtRVlhweVdhc0NBWE5vTENqTWFUYzBxSVp5ejFrZHdzcWRY?=
 =?utf-8?B?ZzE2THMrbnJmWHJWRjltamtwdXNrTk1JMmowVU9PUGtPY2tJZGFHWktOQ05W?=
 =?utf-8?B?VVA1ZG5wZEJiL1JQbjZwNUJSWERrY3lrY0ZsL2g0VlhqVzVaTk5rOHNBSkVO?=
 =?utf-8?B?UFJtTDVnQklYY3g4NU1xL2MrSGVVWmZqcFo1SzlNeW9mVnJnUGpGa01QYWJi?=
 =?utf-8?B?dlcrYytOZy9hNEQ3dElDZG9RRlFKTjk3L2VrbklDTndCajZUWmJteGFrQTlz?=
 =?utf-8?B?aUlVb015Z0thMlkzWXFGOUdXQjRMVjFKVHN4K3YxWmVNUVBFQXlrbitGT3JM?=
 =?utf-8?B?aXJjczNRUEZDVHJoYzBISVprbTgrUGVvaEk2cHNRMTkyWlE5cEdpYWdXYjZZ?=
 =?utf-8?B?aGlRUy9rWHhPN0pTNnZRdXMxVEVIOEwxWEVUM08vcnQzM1RxZ3BoQ0lSSDYx?=
 =?utf-8?B?Y1RDbnVRMnFKdFFtYkJyYUhSdnRKT3pDSEt0YzMxY2hnYWRTeFNKUndaMlNB?=
 =?utf-8?B?RUt0OHh3QkxGSTlaMEZFYVNmT2hiLzg2NzVtZEYzRmh2VnFqWFJUSHJhVjNP?=
 =?utf-8?B?ZDZXR3d4SUVCTUh4VDJMamVhWG9QaDltbW1sTy9ZTGtwbUlvZTNjYTRnaEtI?=
 =?utf-8?B?b0hNTU92NjNNU0NpM3QzTkpEVEduODlRcXB0RURpTFpIZW93N0dZWmN5dEk4?=
 =?utf-8?B?NlZ4QzB2OXkyM05sdi9jRS9ITENxczNta0N3WXNGSGM5Mi9HM042U2hLM09u?=
 =?utf-8?B?UTRUODhsVHEzS2swMU1RMjFRWUQxMW1uSDlHZzlOTDZtTHdGVi9MWWZpb2JR?=
 =?utf-8?Q?cbbW/yMxEpya9ifs4O2KSWU=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 002bb60f-192d-4ded-fd4f-08dde3fdde3c
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 17:36:05.5564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: unD0iFvnbwPVy/fO9sNbQZubRw1SA0twRg39eB+qGjy5Kt6C2KwI4SSClxVyy/PncTDuHb16z5BBYNlm3b+Ax/QRDlumcJD1/3lHkgYh+uY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB9725

On 2025-08-23 12:39, Thomas Gleixner wrote:
> Since commit 0190e4198e47 ("rseq: Deprecate RSEQ_CS_FLAG_NO_RESTART_ON_*
> flags") the bits in task::rseq_event_mask are meaningless and just extra
> work in terms of setting them individually.
> 
> Aside of that the only relevant point where an event has to be raised is
> context switch. Neither the CPU nor MM CID can change without going through
> a context switch.

Note: we may want to include the numa node id field as well in this
list of fields.

> 
> Collapse them all into a single boolean which simplifies the code a lot and
> remove the pointless invocations which have been sprinkled all over the
> place for no value.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> ---
> V2: Reduce it to the sched switch event.
> ---
>   fs/exec.c                 |    2 -
>   include/linux/rseq.h      |   66 +++++++++-------------------------------------
>   include/linux/sched.h     |   10 +++---
>   include/uapi/linux/rseq.h |   21 ++++----------
>   kernel/rseq.c             |   28 +++++++++++--------
>   kernel/sched/core.c       |    5 ---
>   kernel/sched/membarrier.c |    8 ++---
>   7 files changed, 48 insertions(+), 92 deletions(-)
> ---
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1775,7 +1775,7 @@ static int bprm_execve(struct linux_binp
>   		force_fatal_sig(SIGSEGV);
>   
>   	sched_mm_cid_after_execve(current);
> -	rseq_set_notify_resume(current);
> +	rseq_sched_switch_event(current);
>   	current->in_execve = 0;
>   
>   	return retval;
> --- a/include/linux/rseq.h
> +++ b/include/linux/rseq.h
> @@ -3,38 +3,8 @@
>   #define _LINUX_RSEQ_H
>   
>   #ifdef CONFIG_RSEQ
> -
> -#include <linux/preempt.h>
>   #include <linux/sched.h>
>   
> -#ifdef CONFIG_MEMBARRIER
> -# define RSEQ_EVENT_GUARD	irq
> -#else
> -# define RSEQ_EVENT_GUARD	preempt
> -#endif
> -
> -/*
> - * Map the event mask on the user-space ABI enum rseq_cs_flags
> - * for direct mask checks.
> - */
> -enum rseq_event_mask_bits {
> -	RSEQ_EVENT_PREEMPT_BIT	= RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT_BIT,
> -	RSEQ_EVENT_SIGNAL_BIT	= RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL_BIT,
> -	RSEQ_EVENT_MIGRATE_BIT	= RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE_BIT,
> -};
> -
> -enum rseq_event_mask {
> -	RSEQ_EVENT_PREEMPT	= (1U << RSEQ_EVENT_PREEMPT_BIT),
> -	RSEQ_EVENT_SIGNAL	= (1U << RSEQ_EVENT_SIGNAL_BIT),
> -	RSEQ_EVENT_MIGRATE	= (1U << RSEQ_EVENT_MIGRATE_BIT),
> -};
> -
> -static inline void rseq_set_notify_resume(struct task_struct *t)
> -{
> -	if (t->rseq)
> -		set_tsk_thread_flag(t, TIF_NOTIFY_RESUME);
> -}
> -
>   void __rseq_handle_notify_resume(struct ksignal *sig, struct pt_regs *regs);
>   
>   static inline void rseq_handle_notify_resume(struct pt_regs *regs)
> @@ -43,35 +13,27 @@ static inline void rseq_handle_notify_re
>   		__rseq_handle_notify_resume(NULL, regs);
>   }
>   
> -static inline void rseq_signal_deliver(struct ksignal *ksig,
> -				       struct pt_regs *regs)
> +static inline void rseq_signal_deliver(struct ksignal *ksig, struct pt_regs *regs)
>   {
>   	if (current->rseq) {
> -		scoped_guard(RSEQ_EVENT_GUARD)
> -			__set_bit(RSEQ_EVENT_SIGNAL_BIT, &current->rseq_event_mask);
> +		current->rseq_event_pending = true;
>   		__rseq_handle_notify_resume(ksig, regs);
>   	}
>   }
>   
> -/* rseq_preempt() requires preemption to be disabled. */
> -static inline void rseq_preempt(struct task_struct *t)
> +static inline void rseq_sched_switch_event(struct task_struct *t)
>   {
> -	__set_bit(RSEQ_EVENT_PREEMPT_BIT, &t->rseq_event_mask);
> -	rseq_set_notify_resume(t);
> -}
> -
> -/* rseq_migrate() requires preemption to be disabled. */
> -static inline void rseq_migrate(struct task_struct *t)
> -{
> -	__set_bit(RSEQ_EVENT_MIGRATE_BIT, &t->rseq_event_mask);
> -	rseq_set_notify_resume(t);
> +	if (t->rseq) {
> +		t->rseq_event_pending = true;
> +		set_tsk_thread_flag(t, TIF_NOTIFY_RESUME);
> +	}
>   }
>   
>   static __always_inline void rseq_exit_to_user_mode(void)
>   {
>   	if (IS_ENABLED(CONFIG_DEBUG_RSEQ)) {
> -		if (WARN_ON_ONCE(current->rseq && current->rseq_event_mask))
> -			current->rseq_event_mask = 0;
> +		if (WARN_ON_ONCE(current->rseq && current->rseq_event_pending))
> +			current->rseq_event_pending = false;
>   	}
>   }
>   
> @@ -85,12 +47,12 @@ static inline void rseq_fork(struct task
>   		t->rseq = NULL;
>   		t->rseq_len = 0;
>   		t->rseq_sig = 0;
> -		t->rseq_event_mask = 0;
> +		t->rseq_event_pending = false;
>   	} else {
>   		t->rseq = current->rseq;
>   		t->rseq_len = current->rseq_len;
>   		t->rseq_sig = current->rseq_sig;
> -		t->rseq_event_mask = current->rseq_event_mask;
> +		t->rseq_event_pending = current->rseq_event_pending;
>   	}
>   }
>   
> @@ -99,15 +61,13 @@ static inline void rseq_execve(struct ta
>   	t->rseq = NULL;
>   	t->rseq_len = 0;
>   	t->rseq_sig = 0;
> -	t->rseq_event_mask = 0;
> +	t->rseq_event_pending = false;
>   }
>   
>   #else /* CONFIG_RSEQ */
> -static inline void rseq_set_notify_resume(struct task_struct *t) { }
>   static inline void rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs) { }
>   static inline void rseq_signal_deliver(struct ksignal *ksig, struct pt_regs *regs) { }
> -static inline void rseq_preempt(struct task_struct *t) { }
> -static inline void rseq_migrate(struct task_struct *t) { }
> +static inline void rseq_sched_switch_event(struct task_struct *t) { }
>   static inline void rseq_fork(struct task_struct *t, unsigned long clone_flags) { }
>   static inline void rseq_execve(struct task_struct *t) { }
>   static inline void rseq_exit_to_user_mode(void) { }
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1401,14 +1401,14 @@ struct task_struct {
>   #endif /* CONFIG_NUMA_BALANCING */
>   
>   #ifdef CONFIG_RSEQ
> -	struct rseq __user *rseq;
> -	u32 rseq_len;
> -	u32 rseq_sig;
> +	struct rseq __user		*rseq;
> +	u32				rseq_len;
> +	u32				rseq_sig;
>   	/*
> -	 * RmW on rseq_event_mask must be performed atomically
> +	 * RmW on rseq_event_pending must be performed atomically
>   	 * with respect to preemption.
>   	 */
> -	unsigned long rseq_event_mask;
> +	bool				rseq_event_pending;

AFAIU, this rseq_event_pending field is now concurrently set from:

- rseq_signal_deliver (without any preempt nor irqoff guard)
- rseq_sched_switch_event (with preemption disabled)

Is it safe to concurrently store to a "bool" field within a structure
without any protection against concurrent stores ? Typically I've used
an integer field just to be on the safe side in that kind of situation.

AFAIR, a bool type needs to be at least 1 byte. Do all architectures
supported by Linux have a single byte store instruction, or can we end
up incorrectly storing to other nearby fields ? (for instance, DEC
Alpha ?)

>   # ifdef CONFIG_DEBUG_RSEQ
>   	/*
>   	 * This is a place holder to save a copy of the rseq fields for
> --- a/include/uapi/linux/rseq.h
> +++ b/include/uapi/linux/rseq.h
> @@ -114,20 +114,13 @@ struct rseq {
>   	/*
>   	 * Restartable sequences flags field.
>   	 *
> -	 * This field should only be updated by the thread which
> -	 * registered this data structure. Read by the kernel.
> -	 * Mainly used for single-stepping through rseq critical sections
> -	 * with debuggers.
> -	 *
> -	 * - RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT
> -	 *     Inhibit instruction sequence block restart on preemption
> -	 *     for this thread.
> -	 * - RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL
> -	 *     Inhibit instruction sequence block restart on signal
> -	 *     delivery for this thread.
> -	 * - RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE
> -	 *     Inhibit instruction sequence block restart on migration for
> -	 *     this thread.
> +	 * This field was initialy intended to allow event masking for for

initially

for for -> for

> +	 * single-stepping through rseq critical sections with debuggers.
> +	 * The kernel does not support this anymore and the relevant bits
> +	 * are checked for being always false:
> +	 *	- RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT
> +	 *	- RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL
> +	 *	- RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE
>   	 */
>   	__u32 flags;
>   
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -78,6 +78,12 @@
>   #define CREATE_TRACE_POINTS
>   #include <trace/events/rseq.h>
>   
> +#ifdef CONFIG_MEMBARRIER
> +# define RSEQ_EVENT_GUARD	irq
> +#else
> +# define RSEQ_EVENT_GUARD	preempt
> +#endif
> +
>   /* The original rseq structure size (including padding) is 32 bytes. */
>   #define ORIG_RSEQ_SIZE		32
>   
> @@ -430,11 +436,11 @@ void __rseq_handle_notify_resume(struct
>   	 */
>   	if (regs) {
>   		/*
> -		 * Read and clear the event mask first. If the task was not
> -		 * preempted or migrated or a signal is on the way, there
> -		 * is no point in doing any of the heavy lifting here on
> -		 * production kernels. In that case TIF_NOTIFY_RESUME was
> -		 * raised by some other functionality.
> +		 * Read and clear the event pending bit first. If the task
> +		 * was not preempted or migrated or a signal is on the way,
> +		 * there is no point in doing any of the heavy lifting here
> +		 * on production kernels. In that case TIF_NOTIFY_RESUME
> +		 * was raised by some other functionality.
>   		 *
>   		 * This is correct because the read/clear operation is
>   		 * guarded against scheduler preemption, which makes it CPU
> @@ -447,15 +453,15 @@ void __rseq_handle_notify_resume(struct
>   		 * with the result handed in to allow the detection of
>   		 * inconsistencies.
>   		 */
> -		u32 event_mask;
> +		bool event;
>   
>   		scoped_guard(RSEQ_EVENT_GUARD) {
> -			event_mask = t->rseq_event_mask;
> -			t->rseq_event_mask = 0;
> +			event = t->rseq_event_pending;
> +			t->rseq_event_pending = false;
>   		}
>   
> -		if (IS_ENABLED(CONFIG_DEBUG_RSEQ) || event_mask) {
> -			ret = rseq_ip_fixup(regs, !!event_mask);
> +		if (IS_ENABLED(CONFIG_DEBUG_RSEQ) || event) {
> +			ret = rseq_ip_fixup(regs, event);
>   			if (unlikely(ret < 0))
>   				goto error;
>   		}
> @@ -584,7 +590,7 @@ SYSCALL_DEFINE4(rseq, struct rseq __user
>   	 * registered, ensure the cpu_id_start and cpu_id fields
>   	 * are updated before returning to user-space.
>   	 */
> -	rseq_set_notify_resume(current);
> +	rseq_sched_switch_event(current);
>   
>   	return 0;
>   }
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3364,7 +3364,6 @@ void set_task_cpu(struct task_struct *p,
>   		if (p->sched_class->migrate_task_rq)
>   			p->sched_class->migrate_task_rq(p, new_cpu);
>   		p->se.nr_migrations++;
> -		rseq_migrate(p);

OK yes, all rseq_migrate can go away because it requires a preemption,
and those are combined into the same state.

Thanks,

Mathieu

>   		sched_mm_cid_migrate_from(p);
>   		perf_event_task_migrate(p);
>   	}
> @@ -4795,7 +4794,6 @@ int sched_cgroup_fork(struct task_struct
>   		p->sched_task_group = tg;
>   	}
>   #endif
> -	rseq_migrate(p);
>   	/*
>   	 * We're setting the CPU for the first time, we don't migrate,
>   	 * so use __set_task_cpu().
> @@ -4859,7 +4857,6 @@ void wake_up_new_task(struct task_struct
>   	 * as we're not fully set-up yet.
>   	 */
>   	p->recent_used_cpu = task_cpu(p);
> -	rseq_migrate(p);
>   	__set_task_cpu(p, select_task_rq(p, task_cpu(p), &wake_flags));
>   	rq = __task_rq_lock(p, &rf);
>   	update_rq_clock(rq);
> @@ -5153,7 +5150,7 @@ prepare_task_switch(struct rq *rq, struc
>   	kcov_prepare_switch(prev);
>   	sched_info_switch(rq, prev, next);
>   	perf_event_task_sched_out(prev, next);
> -	rseq_preempt(prev);
> +	rseq_sched_switch_event(prev);
>   	fire_sched_out_preempt_notifiers(prev, next);
>   	kmap_local_sched_out();
>   	prepare_task(next);
> --- a/kernel/sched/membarrier.c
> +++ b/kernel/sched/membarrier.c
> @@ -199,7 +199,7 @@ static void ipi_rseq(void *info)
>   	 * is negligible.
>   	 */
>   	smp_mb();
> -	rseq_preempt(current);
> +	rseq_sched_switch_event(current);
>   }
>   
>   static void ipi_sync_rq_state(void *info)
> @@ -407,9 +407,9 @@ static int membarrier_private_expedited(
>   		 * membarrier, we will end up with some thread in the mm
>   		 * running without a core sync.
>   		 *
> -		 * For RSEQ, don't rseq_preempt() the caller.  User code
> -		 * is not supposed to issue syscalls at all from inside an
> -		 * rseq critical section.
> +		 * For RSEQ, don't invoke rseq_sched_switch_event() on the
> +		 * caller.  User code is not supposed to issue syscalls at
> +		 * all from inside an rseq critical section.
>   		 */
>   		if (flags != MEMBARRIER_FLAG_SYNC_CORE) {
>   			preempt_disable();
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

