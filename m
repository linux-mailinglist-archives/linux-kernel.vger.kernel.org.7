Return-Path: <linux-kernel+bounces-786880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63608B36D66
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 17:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F19FE46781F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 15:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C32A255E40;
	Tue, 26 Aug 2025 15:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="s5ZCYwlO"
Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2121.outbound.protection.outlook.com [40.107.115.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01F21DF75A
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 15:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.115.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756220890; cv=fail; b=fVg+rIjrEibzq/TU8dkpOC9xceYp0rwYn5H9FvnYvMJQVpqJ7qmTQHULQgnRyc3l0rUPQZQ0Qah4b24SMFcdnEuVwWYzbw3q1aJug5d3sN6bCu7ZwUVybykBuZggnmMMMsVkEAJC4sZTRbp/t8aRIEiltmClS82EJESS1I8yQCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756220890; c=relaxed/simple;
	bh=18maqgy90LxfRCYoiu8T7AWt6h01d7ERFGf/eLNusss=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gpVIIJqzks5ZfBl6lr9EIQs7mzd+rU4MtmGhoPgPOyfe5Okf4heciT8ascHPqvlTbnu4M9gTvmJ8U91GoTWH+XpG88dfTxRSxvMLq24z920xuyE4O3Xof/cuo3s0ZwsCBP37nFJ/rxNzAzDcdJ5bIlbGxuOk5m6tYmmbqfmYkKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=s5ZCYwlO; arc=fail smtp.client-ip=40.107.115.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o5Y/lD+f3iiVsfCM+8yeYVjbRHrZWnlGRgnJNCiH0KUG5IxoCpESNmp6f9Ujud38lhuCdZOeuaJHWwNVrpGhm7XmWgwy8clqpejelsPjkH2gSy7mUgi1nusz9w4XFA5Pi86a3oTRiGJK1tlW0jqQyaQSJEc6zFjNAb2SOUqAY0SbYY7RYTRdpUGXebLGkAEfBYPKy7hTVt9SK6qYo34uxxkzY78y7nQMMi/ZWK91kfhaijokMH1GPXMIy6WplLr0GCLvTOIsWRAnLpkAtc57eO/khGksUfJcrOetrURka4nAiMUYIlEsCHx7x6xM3JzWzNg0hziTd6X7EoBDiRoAfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gqGz1PjvgUDmGMt37JUSsuM34LBNK5VQUSYGQL5R2v8=;
 b=Infb6ezjT+2Ite4Qpm8QdcLFPrCjCtB0a1vW13FrEbS3rbXqfJbsxKeJhOjbkLtoQ4vGJujxOyThZRirgasoORIKp7/ebFD/IIyvqmDTFpDTah4u6zyoGJmyXwl8cTcMGUdBKbTOXZ8OMQmQBN46WLh25B7qaQ37Rw91tErKR/ArjWJpgYIobYVlHhRSOR/OAvR9ixL9UFpiIDHUcLTg18NOvcy09wxfQQgTPf0wHE4RGOsJjLdDMxJk+f0nYsTwfPuEE+uA966kWuNF6cDctZmRJWf6yF0CRBgDyWDKk8AUCzsv2EK4pdP5BH35tGCpaArlxV7AjTIkv23Gr/iP5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gqGz1PjvgUDmGMt37JUSsuM34LBNK5VQUSYGQL5R2v8=;
 b=s5ZCYwlOQHNDrYmcjmrCz5Y0HYsN6ffWTHnzK6tBziIy7mnUxuHq7KIK0CS5XfxPSKtePVvvatnQPyqS+B9aBSLQGL1N+w03rOddM8wEe7f4/l3XrqCQ4RBc1KYCbkVrX3M44qnwyLdZ9wWjaJXhRmIuiyYt6qSyWnQzUebmZlVxR28I44TuNhhvjwcyTIdbOBVRnA2D+eX4wRI6uqwqoRXCly40DN5N6+lr2k7IKILjJFWEEbGTRpxidyMTtru5/GgSv+kAghWf8FRVC4NY8dtkk1PPHwS7tycllpnHakQRQ1IGikU9i8IwWz475SgS2Xj36LwDPhqsiCuur/OCvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQXPR01MB5518.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:2c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 15:08:04 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9052.021; Tue, 26 Aug 2025
 15:08:04 +0000
Message-ID: <86b2fc16-16af-44d8-87f2-4b6c14713474@efficios.com>
Date: Tue, 26 Aug 2025 11:08:02 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V2 24/37] rseq: Seperate the signal delivery path
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
 <20250823161654.805274429@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250823161654.805274429@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0202.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::24) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQXPR01MB5518:EE_
X-MS-Office365-Filtering-Correlation-Id: f426d323-ae88-4e4e-acec-08dde4b25b37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eE81Y29UbVp4OStLZE9Sa3hTVSt3R0FvaitkcWUyT2ZFTXAra3k2ZDk4WEg5?=
 =?utf-8?B?YkRnRGkvb1FhSVV0YTVtdElTWmU0Z0ZMR1drVTE5cVQwdkhZdE5nUVpHWThy?=
 =?utf-8?B?WCtXRTFFZ0NJZEJ3OXUrSmRYRVM0T25ZcjR4NjZPbDgwb1dKT1BudUVTTlBn?=
 =?utf-8?B?dlVlRWpaRFdSWG5nYWsxZEdGMEZXSzl1a0loWkc2SkxHSnRSQzR3ZHMwWStD?=
 =?utf-8?B?VGMrUXRuazVYQm9tMXJabDkwUHBWSWZUeHJ5aHZNTnlZdlpLa1pzMGp0OU1v?=
 =?utf-8?B?ekkzRlFqeVlyd1VTeHljMng3RUtBUW9iMEdsdGFyOHJjZHU3aEtQNjRFaElD?=
 =?utf-8?B?MTAyY3BDbnVMVWFJbVdaSldZR3M1NDUxQlFLZUszdzR1TCtVdU51WllsOGw0?=
 =?utf-8?B?MXpiTlFPSmM4eFp0a1laNWxpRC9aQkRyYmREcUJwWVhtMFdibm1WbGRkalp3?=
 =?utf-8?B?bDQ5QzBEMlRpdXMyaXFkanRoMHIyZWtweURzb1BFT3RqRXNnTEIzNG1LOUJ2?=
 =?utf-8?B?T1pHdTBRUW1TYUVHd21RNDVyVjVCMS92dmxFQ1pIcXd2RStCUnAvN25FbTFm?=
 =?utf-8?B?dW9pWWFMY2hYcjhQTk54ZDdsdyt0Qk5KN3VUdE5oRVNsNVFvdmdNZ2krcCtv?=
 =?utf-8?B?eG1yakN2SVh1dTcraGVVMlFma1A5cjZwaTVrUFJ3SDAzQWxhTFoxbGFUNGF2?=
 =?utf-8?B?MVFuWGMvUlNGTDhUekxSVTZFc3RPNGFKNHBSN1VNL2RCL0pUdTZYc0ZWZDM3?=
 =?utf-8?B?Ynk1M000Y0FpbzBkb20xa3lqalQzQ29qSlNDQzUvWWtBL0hiQmI0TGsvWWhB?=
 =?utf-8?B?N1AydWVnZS85VFhhMXNSWXVLalFRZGZUbENiYlByWVlidDFoMUtkYys3d282?=
 =?utf-8?B?Mzhwb0Z6bFBPQWlqK1JOUWI4MzhOcWxTV1pOZWM2eEh2QmoreW9NZ0M4emhv?=
 =?utf-8?B?aklCMFU0REJoaUo0bXFkMFEwQkpTUStpd3NFTGtKNlovcmg0b3JFWEI0RWpu?=
 =?utf-8?B?TzI3VDZ3d0p3ZVVVbU8zOFJWZmJ2Si9pa25Mcm5GaGJBcFVlaExXWlFONm1h?=
 =?utf-8?B?VmR1WmNJS2RSNDg1ckt0b2NRcU5JRDZMMWN4UVN1ek93bldOWElnWjZsQnJl?=
 =?utf-8?B?b24vNnRkRC9BMDBja2NyOXpwdFFGVktLL08rRTNXSENiOHF2enREY1daS0sz?=
 =?utf-8?B?QkMwS0QrV0ZlcEdTS2xEWi9TMXlUODB6bTVMWTFaR0F6czlVU2x0OG96WmVl?=
 =?utf-8?B?Wk9ObmtHQlorWHFadXJZaW1tNWNSTkx1YTdEem1lMENBU01FVzBNd3JsdGFk?=
 =?utf-8?B?T1JtS3FpKytYcFpiUHdWZUpsN08yckJ3a1prVmhvREwxeWNrZ01nYVRnblBs?=
 =?utf-8?B?aysvV2k2c1JHMm9NVmlSbnRMSXZWKzF4dVNOL3piR0pYdXVRejJ5YXBBTzc3?=
 =?utf-8?B?M2JNMW5hZS9yd2dtQWsvcHdPZGFiTWg3KzhNaFhNWUk3ZjArSnpwNWppbTEv?=
 =?utf-8?B?enJ3THRhQUh4QzZjOXZ4VnE1R0FDNXJwUEtMWjlrcjFnVEdwb3BPR3d6Mjd1?=
 =?utf-8?B?Ymo1emUwY25ZWmMwNnB5S1Y3Z2xVZ3JncC9yTWpGcFdjUVZWditPd053Q2VC?=
 =?utf-8?B?dmc5NWpIUTk0TkRrUlFrRjdTMitocUoyT0FNaXJrT3g4S2hoRmxid3BEQ2k1?=
 =?utf-8?B?RFVIMVBKVWVQQVlhbFNwdkZzWk9jN0hUQ1BTdXFSYTd6MUxucitzTWFFRzRi?=
 =?utf-8?B?WWpteHArZ01mRlVOMlgzcFBXcFRmWWxZTEhtS05qeDNBSzhEaUFha2lFK0tx?=
 =?utf-8?Q?lwlLZomuTirN5w/iLZEDLHFK7tPZe3hlFe+7c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q3RtT0dSTFUxMFlyQlkxT2hmaks3YzJPMzBYVjZWYThFODN4aUxyeEVMbmRH?=
 =?utf-8?B?b1JkSk4vbTlyRjFqRVhUMGRBRXcrZ3FlcHprVVJzaEN2cTArbWtqQld1ZkFF?=
 =?utf-8?B?bGNTSXpmK0ovMlFxamJWeURUdm1meTVmU3BBK1RNdklXTWZuQ2NpT3cvVVVI?=
 =?utf-8?B?MkdZMVdhWG90czRMUjFkeHZxbFUxdE43QTVleWJHUTJNSjhtMHNSeVdGcGVT?=
 =?utf-8?B?VStUNEFZcTRiT29jUUNENk9tS3NuVW1uOVRYcDVDaldLN3oycHRhQm1HWTRp?=
 =?utf-8?B?dXEyVDFtWE1HZjBMVkZ2clRMWncwUk5CSXc5NUxvc2dBV21VMGZkd09nVVBI?=
 =?utf-8?B?WTJtM21BdGJvdG16aC9CMnFZVXZxRWFjT1FUOVZGQUFnS1RqcmZBYmV6clNK?=
 =?utf-8?B?ZkE4U2tNeGRCKy8zWXNpbzlwYWhTQ2FLUDkwMlhXTElvbWhrOXg3Tm0rYWFl?=
 =?utf-8?B?ZzEzMnRFV2p4WnQ5MlFsNnpwYmp6WnI4anhwTG82bFFSTlA1WTNEeC96eUZ0?=
 =?utf-8?B?eVZVTTR0cjVXbk5PUkpVUnlwZkVkSzUzejB3ZjhFMDNVR1NFYXk1c1FDKzd3?=
 =?utf-8?B?VGRZZEVNSU45TEVoZ25sT1AxdHlmNmZjNnVLaVp4T0ZoZGx5WjQwUmZ5c2Jv?=
 =?utf-8?B?NFI1MHk5WlgzS0NKMHB4YTFqYTdzc3hrbDNJbnQxSGUrZjBleDNWSlhVR0ZS?=
 =?utf-8?B?cWJCOXBjVDVJWWJJaEZ6WkpIdEdNWjRCL2xiK0dhU3dNd2tHSURJUTcxV1pX?=
 =?utf-8?B?RndiaXMxeEFDRDFRQjhaUWFJVGxIU3FnbExHSTVLYm9CTlJjUGFMUHBNelBq?=
 =?utf-8?B?YmI0Um1QWVJlRUVBMytRTEwyRmd5YWpXSG96eFdXM0tjWGpwUXA2MHRuMnRJ?=
 =?utf-8?B?QkxLdHFtMlh0dnZPZG5ORTBobXIyU3FkYlk4ZjdpaXg5TEU2c2VhWjJhSmlX?=
 =?utf-8?B?VkJidXROZGZENUIzamdBaDhzRlZja0hWNmNQd05icW92Nm1KUUtOYUlOTWNT?=
 =?utf-8?B?RmpRUXdpZFNTekJjb3l0cXJFa1NaK2NFQWhLejFIMHZiUHZOeHY0eUdHTmlr?=
 =?utf-8?B?YVJ2M3lPK2FxblNtNktUZXQ2NkVHbjRNNVB2aUNoTDd6QStFMEk1WGt6ZTgr?=
 =?utf-8?B?eWZqdGphRk03OTd4U0pXcVZhZFVUanZOY3hXVFI5bnZ2NVI0VzNaTUYzRjdF?=
 =?utf-8?B?K1NFa29UTzRHYnRDWXFJUEJwUytxbGhLMXVrRmN3aXY3dmVQNXBPbkJKdmJU?=
 =?utf-8?B?Tkt0VXo0ekZHME5rTngyd0VpYXlocWJvcEpwMlNETjVDdGRmS040VDhLUW5z?=
 =?utf-8?B?bnFEM3Q1Y1htbHVwTmcvNjdDS2YyeVIvMG42eUI3L0NQODFzdmdjTXFyT3JL?=
 =?utf-8?B?djY4dTZoN09yY2FDK25QQ01OVEE0N0gyZzl6bkxRcitHR2pHVlkycHp6a29P?=
 =?utf-8?B?V053bWlyN0VZRSt5Qks5WnVDTDFkYXJ2a1BnSnBsWE9IMlFwVE5lTzc0Mlo3?=
 =?utf-8?B?c2ZLK0lFVFlkaEh4dkJxc2prb0g2T3pBUmhHdVpPYkJwK3U0azBZbldpZEtz?=
 =?utf-8?B?UEZrQXRObWhETVRiMU5MelJub2dPbU15Y1pWdU10UXNBYkdEUDR3TmVLSU0y?=
 =?utf-8?B?NVBsTkJzVll0QStmeGRPWGFXRkhFUUh5c1FvSTkrWXRQM2dlNG1aN2lMYjFR?=
 =?utf-8?B?RFdLckxrVkd2OGtQc3NUcTdYSnpUMzdiN2lVV1RrMUhkVU1oY085Y0xaK1pT?=
 =?utf-8?B?SytEVE1CNXU0R2NOVWVOZW9QdE0zYUpmNzJ1ckREeXBaN1BwRkJ0WHVYTkpl?=
 =?utf-8?B?YmJZV1EwUnA1VGtTeGdkQ3VNNmZhMU1pREsyR1R3Z1pnL0hHQk1lKzExdzgw?=
 =?utf-8?B?MUtzVFMwL0dlUXc1UkU3SnpET054ak9sS2QvMTBpY3FldjBuM2NKTXlPMmpV?=
 =?utf-8?B?NXNrU2pua0J3T3I5VzJJSW93Szc5eW5CYmUvM1NjRkkwQXYycGhsTWtpMUR2?=
 =?utf-8?B?bllOTGZQTXdhS2hKcnArb1VBeTh2a2krU3FuRHlId1RUdzFGUmFTZFNWNW9L?=
 =?utf-8?B?ZlEzbmF6OTBuNjNSanp6dzRJeFZoayttSndjMVV2TGxJd1RrSm1WZXFGVk1J?=
 =?utf-8?B?clI1UkpOODZPeXdQT045UHd4YlNNODNRdVRrYm5wb1BKQnRkbTMvcG9PcHhm?=
 =?utf-8?Q?wYQqWGvBvaij+5IldXKewII=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f426d323-ae88-4e4e-acec-08dde4b25b37
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 15:08:04.3462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KoReKxB3W5cixlLkvCY0vM+5uZii+Z7kZv5MrRNOXlV4BRt0NkitSrqIwSy4VCl22cQLT3uugaOagtjrDfy/h2zFl36ORzH3lzMBLqp2YZE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB5518

On 2025-08-23 12:40, Thomas Gleixner wrote:

Patch title "rseq: Separate the signal delivery path"

(Seperate -> Separate)

> Completely seperate the signal delivery path from the notify handler as

seperate -> separate

> they have different semantics versus the event handling.
> 
> The signal delivery only needs to ensure that the interrupted user context
> was not in a critical section or the section is aborted before it switches
> to the signal frame context. The signal frame context does not have the
> original instruction pointer anymore, so that can't be handled on exit to
> user space.
> 
> No point in updating the CPU/CID ids as they might change again before the
> task returns to user space for real.
> 
> The fast path optimization, which checks for the 'entry from user via
> interrupt' condition is only available for architectures which use the
> generic entry code.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   include/linux/rseq.h       |   21 ++++++++++++++++-----
>   include/linux/rseq_entry.h |   29 +++++++++++++++++++++++++++++
>   kernel/rseq.c              |   30 ++++++++++++++++++++++--------
>   3 files changed, 67 insertions(+), 13 deletions(-)
> 
> --- a/include/linux/rseq.h
> +++ b/include/linux/rseq.h
> @@ -5,22 +5,33 @@
>   #ifdef CONFIG_RSEQ
>   #include <linux/sched.h>
>   
> -void __rseq_handle_notify_resume(struct ksignal *sig, struct pt_regs *regs);
> +void __rseq_handle_notify_resume(struct pt_regs *regs);
>   
>   static inline void rseq_handle_notify_resume(struct pt_regs *regs)
>   {
>   	if (current->rseq_event.has_rseq)
> -		__rseq_handle_notify_resume(NULL, regs);
> +		__rseq_handle_notify_resume(regs);
>   }
>   
> +void __rseq_signal_deliver(int sig, struct pt_regs *regs);
> +
> +/*
> + * Invoked from signal delivery to fixup based on the register context before
> + * switching to the signal delivery context.
> + */
>   static inline void rseq_signal_deliver(struct ksignal *ksig, struct pt_regs *regs)
>   {
> -	if (current->rseq_event.has_rseq) {
> -		current->rseq_event.sched_switch = true;
> -		__rseq_handle_notify_resume(ksig, regs);
> +	if (IS_ENABLED(CONFIG_GENERIC_IRQ_ENTRY)) {
> +		/* '&' is intentional to spare one conditional branch */
> +		if (current->rseq_event.has_rseq & current->rseq_event.user_irq)
> +			__rseq_signal_deliver(ksig->sig, regs);
> +	} else {
> +		if (current->rseq_event.has_rseq)
> +			__rseq_signal_deliver(ksig->sig, regs);
>   	}
>   }
>   
> +/* Raised from context switch and exevce to force evaluation on exit to user */

Missing punctuation at the end of comment.

>   static inline void rseq_sched_switch_event(struct task_struct *t)
>   {
>   	if (t->rseq_event.has_rseq) {
> --- a/include/linux/rseq_entry.h
> +++ b/include/linux/rseq_entry.h
> @@ -364,6 +364,35 @@ bool rseq_set_uids_get_csaddr(struct tas
>   	return false;
>   }
>   
> +/*
> + * Update user space with new IDs and conditionally check whether the task
> + * is in a critical section.
> + */
> +static rseq_inline bool rseq_update_usr(struct task_struct *t, struct pt_regs *regs,
> +					struct rseq_ids *ids, u32 node_id)

This patch introduces rseq_update_usr with no caller. Those come in
follow up patches. It would be good to say it up front in the commit
message if this is indeed the intended sequence of changes.

Thanks,

Mathieu


> +{
> +	u64 csaddr;
> +
> +	if (!rseq_set_uids_get_csaddr(t, ids, node_id, &csaddr))
> +		return false;
> +
> +	/*
> +	 * On architectures which utilize the generic entry code this
> +	 * allows to skip the critical section when the entry was not from
> +	 * a user space interrupt, unless debug mode is enabled.
> +	 */
> +	if (IS_ENABLED(CONFIG_GENERIC_IRQ_ENTRY)) {
> +		if (!static_branch_unlikely(&rseq_debug_enabled)) {
> +			if (likely(!t->rseq_event.user_irq))
> +				return true;
> +		}
> +	}
> +	if (likely(!csaddr))
> +		return true;
> +	/* Sigh, this really needs to do work */
> +	return rseq_update_user_cs(t, regs, csaddr);
> +}
> +
>   static __always_inline void rseq_exit_to_user_mode(void)
>   {
>   	struct rseq_event *ev = &current->rseq_event;
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -247,13 +247,12 @@ static bool rseq_handle_cs(struct task_s
>    * respect to other threads scheduled on the same CPU, and with respect
>    * to signal handlers.
>    */
> -void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
> +void __rseq_handle_notify_resume(struct pt_regs *regs)
>   {
>   	struct task_struct *t = current;
>   	struct rseq_ids ids;
>   	u32 node_id;
>   	bool event;
> -	int sig;
>   
>   	/*
>   	 * If invoked from hypervisors before entering the guest via
> @@ -272,10 +271,7 @@ void __rseq_handle_notify_resume(struct
>   	if (unlikely(t->flags & PF_EXITING))
>   		return;
>   
> -	if (ksig)
> -		rseq_stat_inc(rseq_stats.signal);
> -	else
> -		rseq_stat_inc(rseq_stats.slowpath);
> +	rseq_stat_inc(rseq_stats.slowpath);
>   
>   	/*
>   	 * Read and clear the event pending bit first. If the task
> @@ -314,8 +310,26 @@ void __rseq_handle_notify_resume(struct
>   	return;
>   
>   error:
> -	sig = ksig ? ksig->sig : 0;
> -	force_sigsegv(sig);
> +	force_sig(SIGSEGV);
> +}
> +
> +void __rseq_signal_deliver(int sig, struct pt_regs *regs)
> +{
> +	rseq_stat_inc(rseq_stats.signal);
> +	/*
> +	 * Don't update IDs, they are handled on exit to user if
> +	 * necessary. The important thing is to abort a critical section of
> +	 * the interrupted context as after this point the instruction
> +	 * pointer in @regs points to the signal handler.
> +	 */
> +	if (unlikely(!rseq_handle_cs(current, regs))) {
> +		/*
> +		 * Clear the errors just in case this might survive
> +		 * magically, but leave the rest intact.
> +		 */
> +		current->rseq_event.error = 0;
> +		force_sigsegv(sig);
> +	}
>   }
>   
>   void __rseq_debug_syscall_return(struct pt_regs *regs)
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

