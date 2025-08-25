Return-Path: <linux-kernel+bounces-785384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D88EB349E0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 20:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 787BB7A3CC8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 18:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A41A3093A6;
	Mon, 25 Aug 2025 18:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="agYATYuI"
Received: from CAN01-YQB-obe.outbound.protection.outlook.com (mail-yqbcan01on2125.outbound.protection.outlook.com [40.107.116.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E1A19D081
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 18:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.116.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756145599; cv=fail; b=IIWdCgP7lDjjEWkpZuHkIKeLsIZCkO9OiFabeSH3lfgbynSkxFUE1fAFYQohBANVGtuJsF/931dDS//0exG7l3qIoCtasSs1tpTUob4VAhxwNH/xTKntPetlRNjjllSYBQ5ikbQuUgrIGNSjH3sHOy3At3NqPS+3Ssh/55R/rdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756145599; c=relaxed/simple;
	bh=wAlBhiF7Bx16iOKp5oEwGlVCy/KHzYJVt0nAsHRZE4E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oE36XScXflUGeNIO3PhwYwurIglyHT8+WQFDzxJOfc3SDwtNwBPPuteWyHHDvH2/ikQS3ACdNwNaoTIAUWb/lwBIq+enzQX/Kz2GaA7txzmBYImuq7G6jOd99Fmcw6LHO87niQFPLmwE/S/+nKER8u7kAbh4Y1d1cVGdA4uQx2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=agYATYuI; arc=fail smtp.client-ip=40.107.116.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WJyOCFqQ36HzaHdMxTpZEx2G6QmRQvMO/99ebDEdncj3sg8LZkQ+3IKxMKy3z65A7Fj+OfjEJz4aq/4oRvQ1d7w0m7k8Ya6RfZ3vXoIYvLxarMUpBLuX1T7O/VVD1K7RXYe/3BtL/4anQhplu/FB6Ebn0si18P/ry6LQZC8W8IcI6xq7dzhJbJrhhWQb8r6kRp0s6vemYg+eFUyIZckQU08gHv/FsQDA9EqRSyl12TyqR6S5WDsCf3b+p+vbjT0AQxYpYqtlwTHgShHfXZOhH8yj4sHZDJQr7exmS+N6UlBhrOqjAWWxn9p0sy724EvTtIS2JrvHbj3TQgvoVzrkoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lnu5GNgv/tHmTm/elLOVwbuu0GukqINoNw2GZ2K1xBA=;
 b=VpUiiJLetbKey192I2IeCRZpnHdPnVnwnDhLQkn5kav5ua09/24/rwNFAPr9RKcK3+hghsJjprERvnBdlO9tWTG8qSEATYKT0jF5V0gmJ7iufx/0EQFDimNJysnTWpUnlXYWJm5HUU0K8XR5SPvipD0rvz+chKumM3fuME1Ft4NjHzczGncbc7wWX2i6KfjF32R/PIKfm7S4DRxKR0qQ/pTDTcdk5B0Bwz1ZOrAYJgeDId5eem0xCVlWtsL9KlK/zF0urUm73/+nE58D8vt/KbbV+JXe8X3DSaPeYG53sqQu8dZyq28ecIZNfhBxGO97Ioyry4WQx5orhWJbtaC+FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lnu5GNgv/tHmTm/elLOVwbuu0GukqINoNw2GZ2K1xBA=;
 b=agYATYuIanz/0GgEk5T1UOmyIQ7BBakvsgAaIm4tpN5/IOZ219TChVY1e1tWWQEvkzepSztJI3RQ5S+D3Yh01bFiG949oEu8ZuWTJ/kapmV/PkYPAUZZqwXINsPnbvOfUSTuyX6UMb9L1XEvxf3q5uUgssL0aTCEoSLf16KkxarY2P3dmR+pWtnqSSnDWtph0joSB4Hm8qXgp0GvoXLiMQiXeMsmDEFhN14Kd+llMfZqsJHhO/eqDYlkOnGUNY/wVWJ+7JunWf7dKbn3/wqdYhDAOj8+KCG6j0CxMgNl1JstKqvx8byq4tNeG+MtYcri9iSPemafMjKXdtIhRtgQxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB5370.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:62::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.22; Mon, 25 Aug
 2025 18:13:08 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9052.021; Mon, 25 Aug 2025
 18:13:08 +0000
Message-ID: <f9209b7a-b882-416f-b04f-9991b02496e2@efficios.com>
Date: Mon, 25 Aug 2025 14:13:06 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V2 10/37] entry: Cleanup header
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
 <20250823161653.907872775@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250823161653.907872775@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0144.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::22) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB5370:EE_
X-MS-Office365-Filtering-Correlation-Id: 52219a19-30de-42de-7e6a-08dde4030b59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?blhKbkIwRE1nRUNzVTVoMXFDVHJqeWdNVlMwMEFCTURkLzZWckxOd0dUVlIr?=
 =?utf-8?B?RHU2VSt1MHJGL2Q2SFdUY0NtT0hUSmF2c0VSVTZxS0NXaUhKa3BvaEJkaXZ6?=
 =?utf-8?B?dlpwSU85K3JFbTJjRkp5UHMxZlVIZVVKNVZ2YUhVVDRsL0gwN0g4eit5VkZ1?=
 =?utf-8?B?dEdZaGkyT2hmVnQ5bVk3RlFTQlVUMmVwMSttMzRUOU1EU3UrRFhRbnZ0eVB5?=
 =?utf-8?B?Q1J2VTFpRVRlZkRxZHpqdTMyQTUwZ0hkSmRZZnZGYzdKRm41dm9PUDBGTCty?=
 =?utf-8?B?endBS3JoQ0dQeTcrQ2E5N1JVSFdRa2RkbmZNZzVaeEJEemxBaHJ2dUkwends?=
 =?utf-8?B?ZjByT3dxc1RxQkxJTTUvTTZtSVNxSlV4RGJGdG80Ny9hWlB6QXFmSk1LT1Zt?=
 =?utf-8?B?UFZxaXBSMzRIendWYmtSUWJHT1VJb1JDUjZFTUE3YXBzTlNMOHZrRW95VGVP?=
 =?utf-8?B?WVZKN0hMSUxMWjRjWlRSWVNjbFhhT2ZoM0lQbWZUZ1g0UVAxblZPbWNiL2RP?=
 =?utf-8?B?bWIzYTRrK0I0MklhaHlndlliMklDK2c3WnhqMnMrb2hYM2k2Zkh2Yk1NZmgw?=
 =?utf-8?B?bzRwcWU0MFJFaUxxSmI5YlIxQktpbmRBeDdtY1E1ckRMSzh6aHRMazV4SG51?=
 =?utf-8?B?YlZXY0hFMmQ4eUxmR0NiNWVRWTNOMmdlRHBtK05rREZubkk5Tk91dnUrQmov?=
 =?utf-8?B?TGc1M0hSRFhBZm16T1BQWktpMnF3ZlAzWnN1RkhnUktWSG5YMWVxS0VubjFM?=
 =?utf-8?B?YXgwVTBCWHRsK0lOdFhmRnNOYk1XUm5RQjIvQWZjVlhsVXhsQWtsUmcvMWw2?=
 =?utf-8?B?cEZYanZVcDlVQVlIWDQ1cG9PUmxzREMrazNQanh4alJoSUx4RXdpREwxV2JB?=
 =?utf-8?B?dlE1NWlLcGdqUGFRNUJIeXZkYm4zQnZUeGduRXJ4cnoyeldxdXBuNWtUc045?=
 =?utf-8?B?V252cmNUVTFJcEdEVVlJTHRiVjZTTUhKeUNqajd5Y3hkTWIzZ2RvL1lQQ1hx?=
 =?utf-8?B?STVobnY0TVRmTjIraHBQSnJSSnhWOVdkQ2x4NUhvbG9jeTM4SUdkZWtkNFZJ?=
 =?utf-8?B?ckU2dVNuUjA5T1dlU1F6OTJ5NENsVnd6OFVpL2tiZE9jQUVOcytJWnhUQ0tW?=
 =?utf-8?B?YUNQcHFBRmtlRmhERlB6YW1mcEJ5cW5DcWN1SVJseU5vd0NDejNDbTh1di9C?=
 =?utf-8?B?bUc5NkJFUnp6N2dQSEFKV0JlTEdVRGxndnlaYmhpaENwZmpJNWluTVgwVTc2?=
 =?utf-8?B?YldldXU1ZXVkdjBXbk9SNVRWTVl0MlUvZUNJTndMVVZOVEVXbkZyYW1odFdP?=
 =?utf-8?B?bjlvM2MzaU5KQ0VFbXQ0Snc4RkRYSm1WQ2tVU0xwUTNZc0JaQ3FSTmx4QlU0?=
 =?utf-8?B?cjcrN3RwR1FJS3Q0RHI1KzhYNDBNZ3M1SmFVcTUvTlMxL05KeHJOV1g3Tk1U?=
 =?utf-8?B?bW9vSTU0TktHeFFZMGxxdUtxZlFTMm9JNDhEYzdlZnU4Zm9BTG5KWGgxSjJ5?=
 =?utf-8?B?L3BKSWRFOWFLUmM2L3ZOUDBaNzFHMUhZeVg0Y3lST2tkdG9XRlhsUnVyKzFB?=
 =?utf-8?B?ekVmN1FPeXZuNGdVV1NGQXFzNGdaZTRTUWdVNi9UNSt6UWF4OEJQVWo0MTg3?=
 =?utf-8?B?cHNvN21RdW0xN1k2aXZDdlJsdlh5WEJTK1dZNXZXME52YWZLS1g3NnNUK3g1?=
 =?utf-8?B?ZEQwV2dVR2p0S0RNTG5HR2QzdFMrQ1AyQ3BuUjkzOVU0Z21YNnZFTEZwVmpt?=
 =?utf-8?B?Wlc1VUV3VVR1MTlEblFndnV0RHRYampQNm1zMFlnYXI5K0tPWkpBYWJvNWs2?=
 =?utf-8?Q?K9HeiskMHFp5mL8IKV5GaWIXM+jZT7ZQ2o2/A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bkRVZG91TzJ2V3BGRlhiVVhJdnR4TjBVa0lycG90Zjd1bEh6WHNRUzk3K25o?=
 =?utf-8?B?TjNqbE81c2FFQmJZOUw0T3NlWnJYbmZLSnRMeVp5TzJOYStKQTF1UzhBdzJz?=
 =?utf-8?B?cnlCUURwb2Q4YjBKYXBNV2kvM1JEc3ZCdGFaSmJrL3VMUWYrbFZWeldwcDlj?=
 =?utf-8?B?bkxsVE9xcXU3SjZ0cERwdG9JdVluTExIdXhIZ0NsR0x3ZlZSMnppUVE3TkhB?=
 =?utf-8?B?a0l2UXRCMFBGVGZoVEZGYnJwYkFKQ0M1T011NVFJZ1NUNUpTckt0bDhUYW1I?=
 =?utf-8?B?UWYwZ216c0lCVlZqZDJGYm52TFE5RFo4dTlrUjltWEV0SnVHbFhvMnFSN1Nz?=
 =?utf-8?B?bjlqVGZDRUNrRmVTajVWclhVNlFTcnFHUVNwMkRmQUk0M0Q3UjVXRVFYdWhl?=
 =?utf-8?B?MmVhOUs3OHZucGhPR1FvSkpmUTlZK3ZlSjFEQWI5SWdzUjdQdE5lOTBiWlJ6?=
 =?utf-8?B?emFCaXJRanV5bzR3K0xFM3VUMjc3SHJFL2w5OUlsaVNsZVdqZ2d4VTRjV2NO?=
 =?utf-8?B?VHRBci9WWVlmZldhTlpNeWg5VUlrWTFPL0pmRS92QzkvQmxERVo3elVGdUJs?=
 =?utf-8?B?RCtyanRaZjM2MTZ4VEhieXFqOTAra3QwRzRra1VvbWY5K0dYUStCQlJveUFL?=
 =?utf-8?B?czkvclVuYTdTRzlQODQwYVdoaWMyYXY1NTlDR0c3cFNnS3c1Wit6UlBObSt1?=
 =?utf-8?B?b3VYYk9YTWM4YUl0bHUwdU9yb3NmdlJnMkJiekYxTkxkTUszcXErOE9DaVdr?=
 =?utf-8?B?K2YwaDNaSUIrNHFDSnh0VXU4SHpaRnM3cGM4NUE2Sm5zbWI2Y3lydGlpbFhs?=
 =?utf-8?B?TmR4N1lEbGp2L3dHRjZleGF4bjNWZWVnVWxRTGR6TGZrUmtWSXl5Ymk2d3R2?=
 =?utf-8?B?NGR0M2pqaGNRMlppRGVpUVFqN3YrakNXRUMzZFdOWkZWaEtiQWQxaE9neXNl?=
 =?utf-8?B?cTUwakhCR3RwaEpwV3U0OGlFT2dndFd3NDQ4QXUwU3drWGdsUjZzcDZ1Szcz?=
 =?utf-8?B?L3lnTVJHeXpqbDlTQ001UG5KblV3Y0lEZTJ0aklXbmRha2ZubXBYaVI0cGdN?=
 =?utf-8?B?Z3JRdG9ueEwyV3pVMjIwOGxHcFd2bnhNQmhnYk5Tb0xwa1RScHcwWlZWQ3pO?=
 =?utf-8?B?WTAwY0xSRS9Nb2MrbjBZWFpNeGw0UFhqNjcrUzdrdnRkOUJranZ3cEhQaUta?=
 =?utf-8?B?UVpITmNyWWs0cm1HVFRMQ0VIaFFwckVvR00yYURFUWpTVndZQUFLUHRHSnFU?=
 =?utf-8?B?SE93SG9vZVJFekRhTkJDSUlucDVSdnhhTjRjcFJJMGU3MFhIOXRmS21xMUxt?=
 =?utf-8?B?bk5nbXdCMVJsazNQSUcrUUIyUEF6VUFHRS8yNG5wL055NjFFUkVXb1pUT3lD?=
 =?utf-8?B?eUUrbGFIaU9zZ3d5RXBtUFVTS2FaWHdOcDZLVjFpYW82SFBNMnAwVWdNVkoy?=
 =?utf-8?B?cnRNbkIrc1dGbVpKZmRyd3lVOVI4QThwTTlRaTAzZ2QzNkhOSTlPUEJEaVV3?=
 =?utf-8?B?Z2pXUllxcmF5Q0lFdkZ3eWxheTlkOVhlc1hZbWhkTmo1elpUTDg0cnlkSWdD?=
 =?utf-8?B?WFoxRUt2empMaEVZWlpxcXFHcVpycG8yWWdQME5WTy9wN3I5dFJuYUpZQ1Bi?=
 =?utf-8?B?UWZjOFZtR28zM3htKy9sVm1rSkRkOXhFRSs1MjkrbGVZMldnUzNMWCtjNndv?=
 =?utf-8?B?SGlZMnkyTFg3cWFQM3lFWFNKaEovSHQzclJPb0x6ejZDaW9aUVZ1NzFxa3c0?=
 =?utf-8?B?OHBESXMzVkFiMHhMa3ZDRDArT1NFRzl2aFI1dkNyRmlxcnpUazk0c0pZSFB5?=
 =?utf-8?B?UWRKeko1cDZwWnkzZ052L0twdEc0b3J6T1N2ZFpxWm03T1lldkp2eUc5WGgz?=
 =?utf-8?B?aHdmOWRJaDVVc1FFNkliWERUYmZyUnAyUWJaQjFlRkNiVDBxWXErMU5YS3hX?=
 =?utf-8?B?RThONmkvWGZyRFlTOXNmU1o2Zi9lc0VDV0REM0oyMnRMd01hUkR4eWVlUGpI?=
 =?utf-8?B?d3JqMWVqTmMycTJTNUVMcG5PUDZlbXMya3JaL0N1S1JFS3hCMVh5aHdzRS9T?=
 =?utf-8?B?M3Mxdmx6SEZVWC9iQjV0Tm1ZRHM0ekhWNlhieXljZnVXVnROS0V2eHpFSDVZ?=
 =?utf-8?B?LzNLS0dMKzlkR2VGMmVBTmc5ZjJlc0Z5RnBPZUpmS3pNNkNMQXJ0TmVVOXlU?=
 =?utf-8?Q?HrvMSjjknZ3UCWaGbcionA0=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52219a19-30de-42de-7e6a-08dde4030b59
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 18:13:08.4475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wDHTf/tfXla9vhjq1/XSRpjdZE5bCVi8Get6r5wLkOfYdMiKR8eWvkQslbCJYSBwe9tLQxYilcdOPDFp0Rrpp8F1WAQb1r0EXw3X2W8j9rQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB5370

On 2025-08-23 12:39, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Cleanup the include ordering, kernel-doc and other trivialities before
> making further changes.

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> 
> ---
>   include/linux/entry-common.h     |    8 ++++----
>   include/linux/irq-entry-common.h |    2 ++
>   2 files changed, 6 insertions(+), 4 deletions(-)
> ---
> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h
> @@ -3,11 +3,11 @@
>   #define __LINUX_ENTRYCOMMON_H
>   
>   #include <linux/irq-entry-common.h>
> +#include <linux/livepatch.h>
>   #include <linux/ptrace.h>
> +#include <linux/resume_user_mode.h>
>   #include <linux/seccomp.h>
>   #include <linux/sched.h>
> -#include <linux/livepatch.h>
> -#include <linux/resume_user_mode.h>
>   
>   #include <asm/entry-common.h>
>   #include <asm/syscall.h>
> @@ -37,6 +37,7 @@
>   				 SYSCALL_WORK_SYSCALL_AUDIT |		\
>   				 SYSCALL_WORK_SYSCALL_USER_DISPATCH |	\
>   				 ARCH_SYSCALL_WORK_ENTER)
> +
>   #define SYSCALL_WORK_EXIT	(SYSCALL_WORK_SYSCALL_TRACEPOINT |	\
>   				 SYSCALL_WORK_SYSCALL_TRACE |		\
>   				 SYSCALL_WORK_SYSCALL_AUDIT |		\
> @@ -61,8 +62,7 @@
>    */
>   void syscall_enter_from_user_mode_prepare(struct pt_regs *regs);
>   
> -long syscall_trace_enter(struct pt_regs *regs, long syscall,
> -			 unsigned long work);
> +long syscall_trace_enter(struct pt_regs *regs, long syscall, unsigned long work);
>   
>   /**
>    * syscall_enter_from_user_mode_work - Check and handle work before invoking
> --- a/include/linux/irq-entry-common.h
> +++ b/include/linux/irq-entry-common.h
> @@ -68,6 +68,7 @@ static __always_inline bool arch_in_rcu_
>   
>   /**
>    * enter_from_user_mode - Establish state when coming from user mode
> + * @regs:	Pointer to currents pt_regs
>    *
>    * Syscall/interrupt entry disables interrupts, but user mode is traced as
>    * interrupts enabled. Also with NO_HZ_FULL RCU might be idle.
> @@ -357,6 +358,7 @@ irqentry_state_t noinstr irqentry_enter(
>    * Conditional reschedule with additional sanity checks.
>    */
>   void raw_irqentry_exit_cond_resched(void);
> +
>   #ifdef CONFIG_PREEMPT_DYNAMIC
>   #if defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
>   #define irqentry_exit_cond_resched_dynamic_enabled	raw_irqentry_exit_cond_resched
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

