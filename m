Return-Path: <linux-kernel+bounces-812180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD1EB53423
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 15:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A90515A3E96
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 13:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21AC341674;
	Thu, 11 Sep 2025 13:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="VejwXp2V"
Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021076.outbound.protection.outlook.com [40.107.192.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD003314B7
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 13:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757598066; cv=fail; b=gSEdKk7jLlWfwU4BVP9HkxdshWOm1dPU+FJL0tkwtc7LAc26+XMoxMXmxdY+qsYRptNFdm48pi/OLTAmKs6CBp031LDfU7QQZN5wMYh+C7BFHyQ+aB4KjbJ2h6X1gbQKXxaR1jYSHg+r6jNmwZxgVLZlpprq1MEZkUQ8Rs5VOhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757598066; c=relaxed/simple;
	bh=Owv+Hhl6H+haJDAWRYMFjv9nxqfFVG4u0n06/9sWWP8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tmobB+H4YaqFQtZvzCB/AxK8vbUMsCVv02ECjVprYFJfvyX7K32YJDNIPQrishdf2Ay/QtXCSSVl7U7J+GvERV52kxejnaSm/uNr4Binney6AG8yCgwJ9nRGVJIVPaPYhEkkxD7ker37TKMfhrsl1WEaqNypnOwBhtRfjxGDpWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=VejwXp2V; arc=fail smtp.client-ip=40.107.192.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EFqo8g6cqm+4j6VEC94SzYWLnjPZc+IHBePLepOPOYqxd8gOyFBp1QPWo0BzGGAe0TVt1/XHTRd1fgcSfA3xnL7eeDy1eqww2CfcgUMCrvruL9Jusp0BbcyfJsylULDP4bTRJJ+jeDTUH00DDXgcdB7c0nTfbnU6Di36ITNG8yxJDtzIy+1JShBggcxQQI8QbHoF4Xy73wZusxHsni/QyZiPB9nypq/muiV23SIQaAEqlAKcnrKc68dqLxvx95QDm83q/PPuM6ede+8EjX9nCuqNbjaXrgiC5yrs+Ih8OQS6nSJ9oVxn7q873xnK0Q0wzDXd9AFgMpZO3QLAG3rBQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pkbv9bGwV7oOQiQzHqhmMWNpnITTzvGqtT+9M/12zOY=;
 b=YbqSym5CsB7swUuvrLeRktil1v8o6C/WWgEfPGPML7MKBwoU5lmPQH8fxYpW4g545NtyYGJuOTQ+wru3V08mZI+qCcENm7qwL2CW65Mskycc2FVzjNzaI9ZJCCxzQd3j/0TBxjPEZwf75Lf/1LTnRFm3A1s0UmmG2uJ0HHuWmqLSyitK5mlPkHodXNGNnp81Yx1pNr4xnb8Ag4AHa+o8Ysa9hNg5NR8X/YAXZZqPbL6x7o7sL9BZCzgTAQqNEExMKWRK5X0kLJ2rnglDN0Def10u+/1CdtCSsQiIlNXZEFRcrAwm975yAtB6rVp0iNzuhqAwEMB79CJqzszty9kFYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pkbv9bGwV7oOQiQzHqhmMWNpnITTzvGqtT+9M/12zOY=;
 b=VejwXp2VI1NL5TlszViU09RDFKaE82EXaGgmYZf3NcXx7qjCI4Ce/iKHa5Bsc7EMLj4tsT/NsL4ud/pdEXxnM89QsyfCgeexD+2p9w5S1LHgXQmKdoaE2E6qArovucx70zAicdgY4rmKyiCf2DkVXB+kYx8eHAfRzPY6MQBQDZV7uvKdo1xeyChG4BcSyT42PnFEgPUHgnXTNrhg+kUhCDP6tU3ZqC5qRbdgs470NYlx9aVlPJwcbEPgPccwCzNlQeU7bXuUhspN6qimVKyzs6g7pTffMNePtQfSWsnq/KZDDywraxmrjT2erLvufloXHFkYhvIHLJkKf15O858Tuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT1PR01MB8171.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:c2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 13:40:59 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 13:40:58 +0000
Message-ID: <a5b70b86-ce87-435e-9ba5-407ea98e8c8b@efficios.com>
Date: Thu, 11 Sep 2025 09:40:57 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V4 23/36] rseq: Provide and use rseq_set_ids()
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Michael Jeanson <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>,
 Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
 <seanjc@google.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, x86@kernel.org,
 Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>
References: <20250908212737.353775467@linutronix.de>
 <20250908212926.738408636@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250908212926.738408636@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0123.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::28) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT1PR01MB8171:EE_
X-MS-Office365-Filtering-Correlation-Id: a4d0d566-aabb-4325-d4e4-08ddf138d70d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WU56Y09MeWlxZTJwdEFHY0pRcWgvSGdLK3EvbFBBRFFkcWt5TWhhYTdZeVR2?=
 =?utf-8?B?L2hGWjJkOG9sdDhFcnY5ZGIraG5GRzFiTmVGcXo4eXcvNThHc3pneU1zT09X?=
 =?utf-8?B?U2xGZEpwcFVGREVMdEdwaTh0K1UxQ0U1UFpSRzBRYVorbTZXNGtwVXJZaUxr?=
 =?utf-8?B?Yk93THVqSTNsblp6YS9HU1FobksvbGw3SGhjd3RTSWZHYjhiVXQwNkxxdVF6?=
 =?utf-8?B?WXF1M1RqKzBrdzVYT1B4anlqSk9VQ1dydWVTNnJBZlFybkNPT1pUS3lMRyt4?=
 =?utf-8?B?S1BPQ3huQys5Ry8yeHF3THJSZnVhbmFxZnNkQ2w3NENoNEx5enJrdWRoN01Q?=
 =?utf-8?B?OW1oUk1NeXBvbkppYUU3WlIrN2NlaldJYVZvTHJUQ0l0bkJ1SDdCeXM2NGti?=
 =?utf-8?B?RUhjblA3TDNjV3lvNkJYV2kvNFhuSDhxQlVXU1VNRXd1cFYwc0Q4SnliU0Fr?=
 =?utf-8?B?dGlsQmEzdHNUMW5XVWszWTJ5OHRubVNPV05UQUY1RXJyYzdodVFZOVkrNFFI?=
 =?utf-8?B?SEN4VmErYUdKc1g0VE5ZV0ZicVd3M1pyd0xPbWFHUS85WnoxZ1pWUU9PMGV1?=
 =?utf-8?B?QS83aHdFR3BvTk5RVTlVd05DdndZYlQ5MTJKT3g3WW01aEhGcUVYb0NvdmpJ?=
 =?utf-8?B?TExNSjVXQ1ZIQXVQNDFOVVh3UU81QWdsQjQrVE1IK0IxNy9KdkhUcURyd0Rl?=
 =?utf-8?B?bkpCMWpIL0xPUDVPbllPeDNiRDkzWURpMlE1YkdqaUlhbTVXSHgvditkMVkr?=
 =?utf-8?B?cEFxdnZqTEdjbTUzL0tsOTNOMTBJbzJNYVhsN2RxaXhsaW9UUGFsU3RDNG1K?=
 =?utf-8?B?YXBqRy93em9wc0IwQ1lRZlZpMUVyYzhvN3diZGZMZzhVVTl1VHBYc0ZiK1Az?=
 =?utf-8?B?Y1lkYUtHa3VUWERaWC9pcEJrVzkxZEVzczJzVk55M2N3dldsblEwTVRHMmdR?=
 =?utf-8?B?Rmp3T3F4UXl3ejhqR2R6REVvRTFHcXFCalNBZjJ4Y3FqblA3YVpxZi9UTGlk?=
 =?utf-8?B?SkZJL1FhMWxVUnZYUVBsQkthYVhoeDIzbVlESmh5T1prc3dERExlbGFKSkhX?=
 =?utf-8?B?YXJQcUx3dXNDd3FTWTl0NnVQb1V3TjhlRVVZbHl6dHFFRWE1YWh1R2M5WFVK?=
 =?utf-8?B?OUtyZUVaalIxNW1QWWpvQ3VIcys1VWU5enhaTWw3dEJjZmlEallqQUtPMjhw?=
 =?utf-8?B?RnNsRnBRQVhxTUNxR0JlSUl0R0wyTldHSExtWktzNnpnY0tCeFkvMENMQnFi?=
 =?utf-8?B?akxMUGhxZ1hRbE9JSm5SYVovQWs2ZStzcWdoamEwayt2Z3ZvcklNQmFIcm50?=
 =?utf-8?B?YkI5VVpBMWdEMmlGRndzMG0zNE5tR2NiNlptVS9lVDRYRzhidzc0Vm5Vc0tS?=
 =?utf-8?B?MUI4OXZWcy9qdDRHSWJvQ3dGZmljeHd6VDdLUWFJcm9VeURGT2NhbHJaeEw1?=
 =?utf-8?B?ZnkwQTZxanF1OEJJcG1ERlkvWEprbzVMb05MbnFuR2l5TVM0RTVMVTlDdjZH?=
 =?utf-8?B?Y1J1blc5bkh5UVdqd0xHTHJBZXY4V2pwZWNxVVY2YUhENEx3dGg2eW1QWjJz?=
 =?utf-8?B?REE5bG42Q0UwMlc0dHZ2dEJMdFZTUjVabHhUZUgwMWhKbGdRNXdhQk1MSW5w?=
 =?utf-8?B?bmhzVzFiSndnWEZ5MlZQcW9GRVoweGdqLzNlWFh2YkJsTitpdUhRU2kvMGdI?=
 =?utf-8?B?VDRFWHhBR0hkS1BtUDh5eXlmMkd1aWZTT2RzcGQ1a1VPOW92bXJvd0dzVmhs?=
 =?utf-8?B?Z2RoRG1DV0YvUUlnSTQxcXR5YTIzT1JETjJRNEZETDNMTjZiZjdYcGMvRjBM?=
 =?utf-8?Q?a1RRoaC1rji38z+ZQdW/XFJbOlWc3M+sNjAPw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QnQ0Zk81YjR5eTNJMVl4RG0zYnJBVWM5QmRGUG1oTFg4SWl0ZTJ3TzY3RHFr?=
 =?utf-8?B?S3MvdU1mdWlralRxcTFBQ3lIQUtscGh6cDk3alQ4TEZYS3BHU3hVQXVBU1la?=
 =?utf-8?B?bnpEaCtrbENiU2J5T3liM0o5MHRxWlpqSnJENlNYT1RmdWZ5dWlhQnl0NWFS?=
 =?utf-8?B?bVVETkN0MHRTV1dPQkhiR000TWk2cnBtMVdiZVFQQS9YcTFIejVERHNRUU9r?=
 =?utf-8?B?c21RdU9tQ1kvcitKdjlkak9NTHkvR1Fwc05aNURYUEppWmVVUTJKUlZkWTJR?=
 =?utf-8?B?YndUbjVETkdaUzNnb3ZTeFp3b2dJa0NralhTelF5Ly9HTlNacFppWTVadFBR?=
 =?utf-8?B?Z3dJczF4UnVQSFNjZGp4WEVNbmlVekRPS2pjT1F4S2g4ZGRKUkVQdjN6MCs1?=
 =?utf-8?B?MEo3M1JSUVVOaWpId2NKQ2FlOWZ4VEY1dWVqYTdSbDI4RDVnTmlCSWdwRW5Z?=
 =?utf-8?B?WVljVjRSUWoyOURqNVJZNHBiNWc3NzhKclRWd1JvN3FzYWFzREFVOFg1TlJ0?=
 =?utf-8?B?U1Q2M2hyQWdqS0QvTHJaMFFLeWJYbWJpSlVicTBaZ3pQNlAvSFRrZWFPTnlr?=
 =?utf-8?B?d0VGdGg5dFFUL0FSOGhCTXhlOFhKZDlXYXhiZ0tma08yUllXbGRiM24wVjcw?=
 =?utf-8?B?TVNHU0JaTUN5ekwvMXhDa0NIaytmdzF6Y2YxMU5mN3lHZkw5ckI0VXlrMUxv?=
 =?utf-8?B?YVVNdWJQV3pBaERsdXRsUmpjcHVzeUlSZys2L2ZLcEVJY1hNMXo5aHhBTjg0?=
 =?utf-8?B?SjYwczZlT0lhMnNRejJZancvNnRjbFJHSWZCNHRIcmxCbkZzT2ZEMEdqRE5y?=
 =?utf-8?B?L1VLVDVTczZTWEE1MkQvbjlQNG56dEQrRm5tSGhKTVpBYXRhR0haeGRYeGMx?=
 =?utf-8?B?M1hIK1ZCNHRUTlhZRzNuVkxQR3BhUlAwSG5IdEtLbTNMcXlhTGNqeGJrM2ZI?=
 =?utf-8?B?SENyVnFRUU1KQUZscnFheG5CeEQ4MDBUeFkvZU0zV21lRHByZENVWVM0SS9w?=
 =?utf-8?B?OThqcnRoQ1B6alEzNm94UXhKd1Z0aFB5YmdxbFpkQlpDcUpCUHBHTjZVYXkv?=
 =?utf-8?B?QWxrVi9mWitUQ05nL0RNN3MwM2srUi80SnlEQVNOeStoTzRjN0cyNWhnTC95?=
 =?utf-8?B?SGcxZXg5ZWQySVRGSGJCemtjQXlXRDRXUzAvdGRGNWk2MDRQc3VESnJncVJH?=
 =?utf-8?B?RW9BS0ZzTE5zR1huRUY4ZUhrS1BnT3dYTXBEeW5JYTNzdFEvcEZkM3pZQ21q?=
 =?utf-8?B?RVZwdC92VTBWM3ArT01BS2JKT0lkc3dkYWZhRFJKcTZ6UU56TmE5Wmh5RkVB?=
 =?utf-8?B?dDRhR3JoNEpFRE9zeXk2eVFDUjdtTzZVS2pRSHBIcTdMM0xuRHlFR1QxTmVu?=
 =?utf-8?B?Zk1acFVvS1RjMlNMN2RiQmdtbHVIZ2d3K2M2d2lINHh6MVpIZDJpYVcyaVo0?=
 =?utf-8?B?Qi91SEdGS3R0QnhvSUhCamJvejJsQ2xZM0piWWd4OHQ5V3AxdGcvYkJCdjBn?=
 =?utf-8?B?dmhlSmJ6Z0FsWjN0T0UzV1RMbFhEOGl0SWQrTWhNRUE4dXUxeW01aktadnU5?=
 =?utf-8?B?ZjdzaU1TT3U5U3ZJVUxnMUk3WDFONzY2MkdyZlh6UFYzcDhWaEVxY21FN3Y5?=
 =?utf-8?B?SHJJTlJ3TU5wVlQwbGtRdlNZVVFLTVZETUs2MTR4cHhaYU1PbG9LMjZNOVJL?=
 =?utf-8?B?bnoyai8wdjJHdHlyNlkzVHZGTmFrbS9DU1hyb1U2bVRvQ0NQRTFEOWdWdElT?=
 =?utf-8?B?b0Y3RWwxQ244Y0RUd0ZoTjlZLytiZldicGxuMHNxc256R0dRdTVyaEJTdXV5?=
 =?utf-8?B?aC9PYS82VXZST0UvWm4zWG1YdXhOd1ViNGxxKytILytyWUxkdDV6WlVscE5D?=
 =?utf-8?B?czlpTkRyMmswVVJyeTNJbFdydHZhQ2Y4aHRBVFFwdmZQSjRPUXRtMWdjUm5y?=
 =?utf-8?B?cHFuUUJsb0txNW9uY3ByV1orR1REdnRqTmkyTThIdjV3Slpqc29OV1JZKzl6?=
 =?utf-8?B?N2xRK2pxOHMvdVVySmRDcjNDMVdSZmdCaVo1OHJhc1R6b1g1VnI0VDJYZGV0?=
 =?utf-8?B?amZoOHlkU0IyWUh6eGRkT2JmRUdWMVR5KzBJRzhsZXJGYnIzZXVza3lxTkxF?=
 =?utf-8?B?WDNHT0xweGFhOFBCemttUXRKQ09PTVlXOTZzMlRDWGVQQVpIdnpzSEljZjgx?=
 =?utf-8?Q?amRD9keHNU9MmBerkfnU4xg=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4d0d566-aabb-4325-d4e4-08ddf138d70d
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 13:40:58.6630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MaaC43PT1tclzX3+yjgJ2M3N2Pz3QhydXWGuNzXUk833oHh0qzJVdesWu701mHRl+ETswq7/M+rF7Eu/no19dnjCb1wAgWfevDErFaJYxEU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB8171

On 2025-09-08 17:32, Thomas Gleixner wrote:
> Provide a new and straight forward implementation to set the IDs (CPU ID,
> Node ID and MM CID), which can be later inlined into the fast path.
> 
> It does all operations in one user_rw_masked_begin() section and retrieves
> also the critical section member (rseq::cs_rseq) from user space to avoid
> another user..begin/end() pair. This is in preparation for optimizing the
> fast path to avoid extra work when not required.
> 
> Use it to replace the whole related zoo in rseq.c
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> V3: Fixed the node ID comparison in the debug path - Mathieu
> ---
>   fs/binfmt_elf.c            |    2
>   include/linux/rseq_entry.h |  101 +++++++++++++++++++++
>   include/linux/sched.h      |   10 --
>   kernel/rseq.c              |  208 ++++++---------------------------------------
>   4 files changed, 134 insertions(+), 187 deletions(-)
> 
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -46,7 +46,7 @@
>   #include <linux/cred.h>
>   #include <linux/dax.h>
>   #include <linux/uaccess.h>
> -#include <linux/rseq.h>
> +#include <uapi/linux/rseq.h>
>   #include <asm/param.h>
>   #include <asm/page.h>
>   
> --- a/include/linux/rseq_entry.h
> +++ b/include/linux/rseq_entry.h
> @@ -38,6 +38,8 @@ DECLARE_PER_CPU(struct rseq_stats, rseq_
>   #include <linux/rseq.h>
>   #include <linux/uaccess.h>
>   
> +#include <uapi/linux/rseq.h>
> +
>   #include <linux/tracepoint-defs.h>
>   
>   #ifdef CONFIG_TRACEPOINTS
> @@ -75,6 +77,7 @@ DECLARE_STATIC_KEY_MAYBE(CONFIG_RSEQ_DEB
>   #endif
>   
>   bool rseq_debug_update_user_cs(struct task_struct *t, struct pt_regs *regs, unsigned long csaddr);
> +bool rseq_debug_validate_ids(struct task_struct *t);
>   
>   static __always_inline void rseq_note_user_irq_entry(void)
>   {
> @@ -196,6 +199,50 @@ bool rseq_debug_update_user_cs(struct ta
>   	user_access_end();
>   	return false;
>   }
> +
> +/*
> + * On debug kernels validate that user space did not mess with it if
> + * DEBUG_RSEQ is enabled, but don't on the first exit to user space. In
> + * that case cpu_cid is ~0. See fork/execve.
> + */
> +bool rseq_debug_validate_ids(struct task_struct *t)
> +{
> +	struct rseq __user *rseq = t->rseq.usrptr;

Why not check on NULL rseq user pointer rather than skip using
the ~0ULL cpu_cid ?

> +	u32 cpu_id, uval, node_id;
> +
> +	if (t->rseq.ids.cpu_cid == ~0)

Here we are using ~0 and where cpu_cid is set in rseq_set() ~0ULL is
used. Now I understand that because of sign-extend and type promotion
this happens to provide all bits set on a 64-bit, but can we please just
pick one, e.g. ~0ULL ?

Also why does rseq_fork() set it to ~0ULL rather than keep the value
from the parent when forking a new process ?

Whatever was present in the parent process in the rseq area should
still be in the child, including the rseq registration.

Or am missing something ?

> +		return true;
> +
> +	/*
> +	 * Look it up outside of the user access section as cpu_to_node()
> +	 * can end up in debug code.
> +	 */
> +	node_id = cpu_to_node(t->rseq.ids.cpu_id);
> +
> +	if (!user_read_masked_begin(rseq))
> +		return false;
> +
> +	unsafe_get_user(cpu_id, &rseq->cpu_id_start, efault);
> +	if (cpu_id != t->rseq.ids.cpu_id)
> +		goto die;
> +	unsafe_get_user(uval, &rseq->cpu_id, efault);
> +	if (uval != cpu_id)
> +		goto die;
> +	unsafe_get_user(uval, &rseq->node_id, efault);
> +	if (uval != node_id)
> +		goto die;
> +	unsafe_get_user(uval, &rseq->mm_cid, efault);
> +	if (uval != t->rseq.ids.mm_cid)
> +		goto die;
> +	user_access_end();
> +	return true;
> +die:
> +	t->rseq.event.fatal = true;
> +efault:
> +	user_access_end();
> +	return false;
> +}
> +
>   #endif /* RSEQ_BUILD_SLOW_PATH */
>   
>   /*
> @@ -281,6 +328,60 @@ rseq_update_user_cs(struct task_struct *
>   	user_access_end();
>   	return false;
>   }
> +
> +/*
> + * Updates CPU ID, Node ID and MM CID and reads the critical section
> + * address, when @csaddr != NULL. This allows to put the ID update and the
> + * read under the same uaccess region to spare a seperate begin/end.

separate

> + *
> + * As this is either invoked from a C wrapper with @csaddr = NULL or from
> + * the fast path code with a valid pointer, a clever compiler should be
> + * able to optimize the read out. Spares a duplicate implementation.
> + *
> + * Returns true, if the operation was successful, false otherwise.
> + *
> + * In the failure case task::rseq_event::fatal is set when invalid data
> + * was found on debug kernels. It's clear when the failure was an unresolved page
> + * fault.
> + *
> + * If inlined into the exit to user path with interrupts disabled, the
> + * caller has to protect against page faults with pagefault_disable().
> + *
> + * In preemptible task context this would be counterproductive as the page
> + * faults could not be fully resolved. As a consequence unresolved page
> + * faults in task context are fatal too.
> + */
> +static rseq_inline
> +bool rseq_set_ids_get_csaddr(struct task_struct *t, struct rseq_ids *ids,
> +			     u32 node_id, u64 *csaddr)
> +{
> +	struct rseq __user *rseq = t->rseq.usrptr;
> +
> +	if (static_branch_unlikely(&rseq_debug_enabled)) {
> +		if (!rseq_debug_validate_ids(t))
> +			return false;
> +	}
> +
> +	if (!user_rw_masked_begin(rseq))
> +		return false;
> +
> +	unsafe_put_user(ids->cpu_id, &rseq->cpu_id_start, efault);
> +	unsafe_put_user(ids->cpu_id, &rseq->cpu_id, efault);
> +	unsafe_put_user(node_id, &rseq->node_id, efault);
> +	unsafe_put_user(ids->mm_cid, &rseq->mm_cid, efault);
> +	if (csaddr)
> +		unsafe_get_user(*csaddr, &rseq->rseq_cs, efault);
> +	user_access_end();
> +
> +	/* Cache the new values */
> +	t->rseq.ids.cpu_cid = ids->cpu_cid;
> +	rseq_stat_inc(rseq_stats.ids);
> +	rseq_trace_update(t, ids);
> +	return true;
> +efault:
> +	user_access_end();
> +	return false;
> +}
>   
>   static __always_inline void rseq_exit_to_user_mode(void)
>   {
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -42,7 +42,6 @@
>   #include <linux/posix-timers_types.h>
>   #include <linux/restart_block.h>
>   #include <linux/rseq_types.h>
> -#include <uapi/linux/rseq.h>
>   #include <linux/seqlock_types.h>
>   #include <linux/kcsan.h>
>   #include <linux/rv.h>
> @@ -1402,15 +1401,6 @@ struct task_struct {
>   #endif /* CONFIG_NUMA_BALANCING */
>   
>   	struct rseq_data		rseq;
> -#ifdef CONFIG_DEBUG_RSEQ
> -	/*
> -	 * This is a place holder to save a copy of the rseq fields for
> -	 * validation of read-only fields. The struct rseq has a
> -	 * variable-length array at the end, so it cannot be used
> -	 * directly. Reserve a size large enough for the known fields.
> -	 */
> -	char				rseq_fields[sizeof(struct rseq)];
> -#endif
>   
>   #ifdef CONFIG_SCHED_MM_CID
>   	int				mm_cid;		/* Current cid in mm */
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -88,13 +88,6 @@
>   # define RSEQ_EVENT_GUARD	preempt
>   #endif
>   
> -/* The original rseq structure size (including padding) is 32 bytes. */
> -#define ORIG_RSEQ_SIZE		32
> -
> -#define RSEQ_CS_NO_RESTART_FLAGS (RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT | \
> -				  RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL | \
> -				  RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE)
> -
>   DEFINE_STATIC_KEY_MAYBE(CONFIG_RSEQ_DEBUG_DEFAULT_ENABLE, rseq_debug_enabled);
>   
>   static inline void rseq_control_debug(bool on)
> @@ -227,159 +220,9 @@ static int __init rseq_debugfs_init(void
>   __initcall(rseq_debugfs_init);
>   #endif /* CONFIG_DEBUG_FS */
>   
> -#ifdef CONFIG_DEBUG_RSEQ
> -static struct rseq *rseq_kernel_fields(struct task_struct *t)
> -{
> -	return (struct rseq *) t->rseq_fields;
> -}
> -
> -static int rseq_validate_ro_fields(struct task_struct *t)
> -{
> -	static DEFINE_RATELIMIT_STATE(_rs,
> -				      DEFAULT_RATELIMIT_INTERVAL,
> -				      DEFAULT_RATELIMIT_BURST);
> -	u32 cpu_id_start, cpu_id, node_id, mm_cid;
> -	struct rseq __user *rseq = t->rseq.usrptr;
> -
> -	/*
> -	 * Validate fields which are required to be read-only by
> -	 * user-space.
> -	 */
> -	if (!user_read_access_begin(rseq, t->rseq.len))
> -		goto efault;
> -	unsafe_get_user(cpu_id_start, &rseq->cpu_id_start, efault_end);
> -	unsafe_get_user(cpu_id, &rseq->cpu_id, efault_end);
> -	unsafe_get_user(node_id, &rseq->node_id, efault_end);
> -	unsafe_get_user(mm_cid, &rseq->mm_cid, efault_end);
> -	user_read_access_end();
> -
> -	if ((cpu_id_start != rseq_kernel_fields(t)->cpu_id_start ||
> -	    cpu_id != rseq_kernel_fields(t)->cpu_id ||
> -	    node_id != rseq_kernel_fields(t)->node_id ||
> -	    mm_cid != rseq_kernel_fields(t)->mm_cid) && __ratelimit(&_rs)) {
> -
> -		pr_warn("Detected rseq corruption for pid: %d, name: %s\n"
> -			"\tcpu_id_start: %u ?= %u\n"
> -			"\tcpu_id:       %u ?= %u\n"
> -			"\tnode_id:      %u ?= %u\n"
> -			"\tmm_cid:       %u ?= %u\n",
> -			t->pid, t->comm,
> -			cpu_id_start, rseq_kernel_fields(t)->cpu_id_start,
> -			cpu_id, rseq_kernel_fields(t)->cpu_id,
> -			node_id, rseq_kernel_fields(t)->node_id,
> -			mm_cid, rseq_kernel_fields(t)->mm_cid);
> -	}
> -
> -	/* For now, only print a console warning on mismatch. */
> -	return 0;
> -
> -efault_end:
> -	user_read_access_end();
> -efault:
> -	return -EFAULT;
> -}
> -
> -/*
> - * Update an rseq field and its in-kernel copy in lock-step to keep a coherent
> - * state.
> - */
> -#define rseq_unsafe_put_user(t, value, field, error_label)			\
> -	do {									\
> -		unsafe_put_user(value, &t->rseq.usrptr->field, error_label);	\
> -		rseq_kernel_fields(t)->field = value;				\
> -	} while (0)
> -
> -#else
> -static int rseq_validate_ro_fields(struct task_struct *t)
> -{
> -	return 0;
> -}
> -
> -#define rseq_unsafe_put_user(t, value, field, error_label)		\
> -	unsafe_put_user(value, &t->rseq.usrptr->field, error_label)
> -#endif
> -
> -static int rseq_update_cpu_node_id(struct task_struct *t)
> -{
> -	struct rseq __user *rseq = t->rseq.usrptr;
> -	u32 cpu_id = raw_smp_processor_id();
> -	u32 node_id = cpu_to_node(cpu_id);
> -	u32 mm_cid = task_mm_cid(t);
> -
> -	rseq_stat_inc(rseq_stats.ids);
> -
> -	/* Validate read-only rseq fields on debug kernels */
> -	if (rseq_validate_ro_fields(t))
> -		goto efault;
> -	WARN_ON_ONCE((int) mm_cid < 0);
> -
> -	if (!user_write_access_begin(rseq, t->rseq.len))
> -		goto efault;
> -
> -	rseq_unsafe_put_user(t, cpu_id, cpu_id_start, efault_end);
> -	rseq_unsafe_put_user(t, cpu_id, cpu_id, efault_end);
> -	rseq_unsafe_put_user(t, node_id, node_id, efault_end);
> -	rseq_unsafe_put_user(t, mm_cid, mm_cid, efault_end);
> -
> -	/* Cache the user space values */
> -	t->rseq.ids.cpu_id = cpu_id;
> -	t->rseq.ids.mm_cid = mm_cid;
> -
> -	/*
> -	 * Additional feature fields added after ORIG_RSEQ_SIZE
> -	 * need to be conditionally updated only if
> -	 * t->rseq_len != ORIG_RSEQ_SIZE.
> -	 */
> -	user_write_access_end();
> -	trace_rseq_update(t);
> -	return 0;
> -
> -efault_end:
> -	user_write_access_end();
> -efault:
> -	return -EFAULT;
> -}
> -
> -static int rseq_reset_rseq_cpu_node_id(struct task_struct *t)
> +static bool rseq_set_ids(struct task_struct *t, struct rseq_ids *ids, u32 node_id)
>   {
> -	struct rseq __user *rseq = t->rseq.usrptr;
> -	u32 cpu_id_start = 0, cpu_id = RSEQ_CPU_ID_UNINITIALIZED, node_id = 0,
> -	    mm_cid = 0;
> -
> -	/*
> -	 * Validate read-only rseq fields.
> -	 */
> -	if (rseq_validate_ro_fields(t))
> -		goto efault;
> -
> -	if (!user_write_access_begin(rseq, t->rseq.len))
> -		goto efault;
> -
> -	/*
> -	 * Reset all fields to their initial state.
> -	 *
> -	 * All fields have an initial state of 0 except cpu_id which is set to
> -	 * RSEQ_CPU_ID_UNINITIALIZED, so that any user coming in after
> -	 * unregistration can figure out that rseq needs to be registered
> -	 * again.
> -	 */
> -	rseq_unsafe_put_user(t, cpu_id_start, cpu_id_start, efault_end);
> -	rseq_unsafe_put_user(t, cpu_id, cpu_id, efault_end);
> -	rseq_unsafe_put_user(t, node_id, node_id, efault_end);
> -	rseq_unsafe_put_user(t, mm_cid, mm_cid, efault_end);
> -
> -	/*
> -	 * Additional feature fields added after ORIG_RSEQ_SIZE
> -	 * need to be conditionally reset only if
> -	 * t->rseq_len != ORIG_RSEQ_SIZE.
> -	 */
> -	user_write_access_end();
> -	return 0;
> -
> -efault_end:
> -	user_write_access_end();
> -efault:
> -	return -EFAULT;
> +	return rseq_set_ids_get_csaddr(t, ids, node_id, NULL);
>   }
>   
>   static bool rseq_handle_cs(struct task_struct *t, struct pt_regs *regs)
> @@ -407,6 +250,8 @@ static bool rseq_handle_cs(struct task_s
>   void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
>   {
>   	struct task_struct *t = current;
> +	struct rseq_ids ids;
> +	u32 node_id;
>   	bool event;
>   	int sig;
>   
> @@ -453,6 +298,8 @@ void __rseq_handle_notify_resume(struct
>   	scoped_guard(RSEQ_EVENT_GUARD) {
>   		event = t->rseq.event.sched_switch;
>   		t->rseq.event.sched_switch = false;
> +		ids.cpu_id = task_cpu(t);
> +		ids.mm_cid = task_mm_cid(t);
>   	}
>   
>   	if (!IS_ENABLED(CONFIG_DEBUG_RSEQ) && !event)
> @@ -461,7 +308,8 @@ void __rseq_handle_notify_resume(struct
>   	if (!rseq_handle_cs(t, regs))
>   		goto error;
>   
> -	if (unlikely(rseq_update_cpu_node_id(t)))
> +	node_id = cpu_to_node(ids.cpu_id);
> +	if (!rseq_set_ids(t, &ids, node_id))
>   		goto error;
>   	return;
>   
> @@ -502,13 +350,33 @@ void rseq_syscall(struct pt_regs *regs)
>   }
>   #endif
>   
> +static bool rseq_reset_ids(void)
> +{
> +	struct rseq_ids ids = {
> +		.cpu_id		= RSEQ_CPU_ID_UNINITIALIZED,
> +		.mm_cid		= 0,
> +	};
> +
> +	/*
> +	 * If this fails, terminate it because this leaves the kernel in
> +	 * stupid state as exit to user space will try to fixup the ids
> +	 * again.
> +	 */
> +	if (rseq_set_ids(current, &ids, 0))
> +		return true;
> +
> +	force_sig(SIGSEGV);
> +	return false;
> +}
> +
> +/* The original rseq structure size (including padding) is 32 bytes. */
> +#define ORIG_RSEQ_SIZE		32
> +
>   /*
>    * sys_rseq - setup restartable sequences for caller thread.
>    */
>   SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len, int, flags, u32, sig)
>   {
> -	int ret;
> -
>   	if (flags & RSEQ_FLAG_UNREGISTER) {
>   		if (flags & ~RSEQ_FLAG_UNREGISTER)
>   			return -EINVAL;
> @@ -519,9 +387,8 @@ SYSCALL_DEFINE4(rseq, struct rseq __user
>   			return -EINVAL;
>   		if (current->rseq.sig != sig)
>   			return -EPERM;
> -		ret = rseq_reset_rseq_cpu_node_id(current);
> -		if (ret)
> -			return ret;
> +		if (!rseq_reset_ids())
> +			return -EFAULT;

AFAIU, this is only done to have the debug checks, stats, and
tracing side-effects, because the content of cpu_cid will be set
to ~0ULL by the following rseq_reset, am I correct ?

It's kind of weird to do some reset work to have it immediately
overwritten.

>   		rseq_reset(current);
>   		return 0;
>   	}
> @@ -571,17 +438,6 @@ SYSCALL_DEFINE4(rseq, struct rseq __user
>   	if (put_user_masked_u64(0UL, &rseq->rseq_cs))
>   		return -EFAULT;
>   
> -#ifdef CONFIG_DEBUG_RSEQ
> -	/*
> -	 * Initialize the in-kernel rseq fields copy for validation of
> -	 * read-only fields.
> -	 */
> -	if (get_user(rseq_kernel_fields(current)->cpu_id_start, &rseq->cpu_id_start) ||
> -	    get_user(rseq_kernel_fields(current)->cpu_id, &rseq->cpu_id) ||
> -	    get_user(rseq_kernel_fields(current)->node_id, &rseq->node_id) ||
> -	    get_user(rseq_kernel_fields(current)->mm_cid, &rseq->mm_cid))
> -		return -EFAULT;
> -#endif

OK I think I get why you are using cpu_cid != ~0ULL rather than the rseq
user pointer in the debug code. After rseq registration, now that you
remove those get_user, the kernel vs userspace fields are out of sync,
so you need a way to figure this out on return to userspace from
sys_rseq register.

Thanks,

Mathieu

>   	/*
>   	 * Activate the registration by setting the rseq area address, length
>   	 * and signature in the task struct.
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

