Return-Path: <linux-kernel+bounces-720991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D787EAFC308
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 08:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08C713A9369
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 06:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F112248BA;
	Tue,  8 Jul 2025 06:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5HUE4fwQ"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA1E22331C
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 06:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751957047; cv=fail; b=AAwSYb2DI4HYZ5+ckNpTxoQY0lh8waNDzlkeORv0hTGCGK1ww9UwevAEtL5JwGJBZ0BGTux6HywUv+6nxA86FPwih8glGk6jI4pofDsmRvEtyR7OkgXBEoMdV6liMK/3mx8OQfpEoWrn+KxPfJV+PhE2tzzc3eooqS+5l3zShvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751957047; c=relaxed/simple;
	bh=UdhmQ1YqzHQ85mnDV5TVWP9rlk0YYzxoSsDnWWg2bRE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YswjVQVMlR337sLPB0Ht0aM9DQwU34oPx6OESHF0eepzzYD6M+v6+CEHj8ZkTmknYHsaAa/mf+vHvKbGoKtcmXZgXaeCgSUKOfXBKlk3C82aIAQgu0CBRo4hHxptjDOtEMTv7Hkei3bObzt2raAxjTUZvyndQITBC1luevabNPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5HUE4fwQ; arc=fail smtp.client-ip=40.107.94.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AVv7efkmKrY1CTLRV7lzW8L6nh6J6DncIuDv38wa0KevqONICFE++qQ5Yup4520w3dv8J9MBWbYr8BWblofovt4MjP24bSLdQKgiCNebPE7b41Pq9kvzjEINifzhch2KffOKlsZSC80A3d9r64G3aTCkGxwU8oAOdbVn6BNO+DHZUnv2GSz9ClEno4wc6a52onejg13B33j3tsCoXjI+DX9GI0oSIfUpTgOzIcHVXO0zCleH5H083AZVxydnXL5vLZ9rnz74h6FEQNECbWEqcx5L/+DmPR48kuwWKwjrk5sX8kmK55pIAItbDa6l6UgwMTza1oE9fYIrYDbbXz/eNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ppLF+wibVHXTWSlJqFWGCxzXhaiPDOVYk8WCxe0uUkU=;
 b=LxFC3C/b4/I6bSQ/WLzujHh7frcuoQBLoHbo16fxSQcMwa9L9PpFmrrkuv/d0FVtGGvaxTGZP+elHIBq9pMo626l3ll87cYH9ZJuewwo3Vg2C8TB5fabXtnrXN6iImlFzjm29jifkL7gekULPXoGO5K/J3XBFWHpb7sXq9De8P+HfY444Sl/Oh/nRx5VQWZwHCH4aE30sqmvRhWAz3iKXjBL9w+vJxYJIamTBcfhJdk/HMLFb2EGxRzI2TerT4htKRUb/wVFtnB+WD48uY0cq3NkqbK4+4VWkFe2d+NTXjiFqNagch14/sgCwKhHg4YcCD8/oBGvPTBg/fi8gCFTJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ppLF+wibVHXTWSlJqFWGCxzXhaiPDOVYk8WCxe0uUkU=;
 b=5HUE4fwQoZM69fKwIhgwqVzCoVX1NDTIpxkKs1nXhW8Haj1N+sXxpiYDYmyvUBnxfwp/HFOwa5Uuqk7qnfOzPBti2wjWNqEGJzOZYkYpVHPL9qumagDttnunvh32aBZawr3q9nMsVjO0oxFD7Pk4JuHXZEbCQJ8fkH/tBwviBrQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8658.namprd12.prod.outlook.com (2603:10b6:610:175::8)
 by IA1PR12MB6234.namprd12.prod.outlook.com (2603:10b6:208:3e6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Tue, 8 Jul
 2025 06:44:01 +0000
Received: from CH3PR12MB8658.namprd12.prod.outlook.com
 ([fe80::d5cc:cc84:5e00:2f42]) by CH3PR12MB8658.namprd12.prod.outlook.com
 ([fe80::d5cc:cc84:5e00:2f42%4]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 06:44:01 +0000
Message-ID: <c4b23568-8513-4bb8-b278-e4bbb8e4424e@amd.com>
Date: Tue, 8 Jul 2025 12:13:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND][PATCH v18 3/8] locking/mutex: Add p->blocked_on wrappers
 for correctness checks
To: John Stultz <jstultz@google.com>, LKML <linux-kernel@vger.kernel.org>
Cc: Valentin Schneider <valentin.schneider@arm.com>,
 Connor O'Brien <connoro@google.com>, Joel Fernandes <joelagnelf@nvidia.com>,
 Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Valentin Schneider <vschneid@redhat.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>,
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
 Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Metin Kaya <Metin.Kaya@arm.com>, Xuewen Yan <xuewen.yan94@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Suleiman Souhlal <suleiman@google.com>, kuyo chang
 <kuyo.chang@mediatek.com>, hupu <hupu.gm@gmail.com>, kernel-team@android.com
References: <20250707204409.1028494-1-jstultz@google.com>
 <20250707204409.1028494-4-jstultz@google.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250707204409.1028494-4-jstultz@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0071.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::18) To CH3PR12MB8658.namprd12.prod.outlook.com
 (2603:10b6:610:175::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8658:EE_|IA1PR12MB6234:EE_
X-MS-Office365-Filtering-Correlation-Id: 19666626-5479-4bc4-c03c-08ddbdead255
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N3Y1aERhQWJrNEl5UUkxbVJWbzRpKzhKMVIrOGJuTEpieVV0UlB0Ti93dGpM?=
 =?utf-8?B?eDdXVHZ2UXVzOGVLaUlBbUd3czZuUW9hdWkxVG0zbVBmcjJzWmtEKzJjeU53?=
 =?utf-8?B?cWxYcWI0WWpnS3NRUThyNGRMZmlJbEhzRTNTQVhvNGpOVER6VXhpZzR0ZEg1?=
 =?utf-8?B?NUdaSXNGeVFpcTErVUFlWTJCd212T3VKR1dFVXNuSG8wOEJDcWw0amJsdVhV?=
 =?utf-8?B?TGRrcVJUYStSQXZoTXgwVzhINm45VWNrOHRGOVg2OXc3VFhjdzRWRkw2djgx?=
 =?utf-8?B?OHllUlJjeEF0OUl4VkYzZFIwUmtRUm9YbnE5bFhNemcvNU1zdVo1UTl6bi9F?=
 =?utf-8?B?cEhiQlBJODdFYnYrQ3JKc0gza2pTbURVbWwzcHJxdUtFNm9tYlJrSWJocnBZ?=
 =?utf-8?B?ZHhJN20yaUhDODFaSUxZY201dit3SlNNRm5McVpIcm0wc204MmFwbE9Kdzhu?=
 =?utf-8?B?RWZtVHA1cldWU1ZCSVhrcjJzd1oxT282WGJKZTFQWFdMTG9nZFliblg2TFda?=
 =?utf-8?B?RG16QklNWC9kUmNDZC9adldndEE1Ukt3cENUdlBXeThSakNwd2FBaDJrVnQz?=
 =?utf-8?B?bndkSXdJS1pCenpnUGNaMFp4d3NRQ1loUjd2eHk0MUFRbVFhUS9JTTgvMGtT?=
 =?utf-8?B?NVZjLzAranRHOWw0aUlyOS8vc2ZXRVBiaHFZam9lNEFKeWdIcGVneDVoZ3BZ?=
 =?utf-8?B?WVM4eDRNZHNWMDY0Q0NQQ3lSMEVFT2RKeXEzQ0szUU9hdTdXQUdQd1JHK25V?=
 =?utf-8?B?L0JlRVhLUkRMTkl6cTl0UUtDZW1zVE5YWGR5ZzBrVHdETzhQRUdkdUhidUhP?=
 =?utf-8?B?cjFidmVrNTU3cVN0L1M2NEhYR2hPQTJDdUYrUStSQVVyaDFUTlV4aS9leGlj?=
 =?utf-8?B?cFZIakYyTTZMRjdGZTM1MlJTYjBjZjk1ajFJQ1FGVzM3M0IvN3JXdW9OYlR0?=
 =?utf-8?B?bXdnalpkN0J2ZS96alo5NHVrT2R2dnlOaUVpL2NOZnB5MjJ5ZHBOMXZQMHp5?=
 =?utf-8?B?UkNJWFN3b0Z1OVRlL0t2SGhPQmpxUjdKcW1uc0RNQTh2cWNPeHpRWjlnVXZV?=
 =?utf-8?B?N3o3U05sYkIya0VzWWwrb0dJajhqWXRMZnRtYlRZeW00SjE1VERiRThJb0hi?=
 =?utf-8?B?ZGZ2UWoyaSs3OEM0SVNOdDJoNEx3T0txclFYYjlReThpMllzc2M5LzFNa0wr?=
 =?utf-8?B?U0ExaDh2bmFNbE0yU29NNzJMc05kRjJiN1NrZHZkZVBMLzM5em5MR0lhSGFR?=
 =?utf-8?B?dmFXSm5UT09QQWhkaWlmdWIwV0QvcHRwa3VjUFcvN3FXK1JzZ0hzQ2FNem5S?=
 =?utf-8?B?OWxZZktITHFjVktWTnNaenQ4b2phczJKMG9HeTNQalhpTTlxaGsxQTNyRUht?=
 =?utf-8?B?V29YZzErNHQwWHpUMjFJbGcvYWpsSm1oVml1N3Mza1FIQjF1eXM1ckJKVEh6?=
 =?utf-8?B?Yk8ySVRha0x1eVlQQjdBVVlOTktUb2k5ZzQrZDFVQXpDTnNOQmZlVnZYMElh?=
 =?utf-8?B?MkRpTTRha3JaWWphRXgzbENvayt5aktuWDBud1FNNmNiM0VidnovWVhnd3lr?=
 =?utf-8?B?em1YbVR3ajhndU1VUWVZakovMXJQN05HbmtmSzRnR254Z3dEZzFZeTZvNUhk?=
 =?utf-8?B?SkdBRzV2c0tYVFJBSnZ2Y014ZVlHQWxHQnE0WFhCNmllRjBpRk5Ha1F5Kzgw?=
 =?utf-8?B?UXhxalQzNDFFYWNnbEkybGY0N0pIeUtBTzhGNUZoek53b2JOekc2SVRMbXVX?=
 =?utf-8?B?ZVpzVis0dERGS3Jta0xZdm9SUlp0cnZWT25JYTBqYSs5Tll4SEY2SGtaREUv?=
 =?utf-8?B?QmxnWGhCQWJNcERjNGFQOFlEMDNFaS80ZGZQSFhhUGhJWXlYdGI1REErS2dl?=
 =?utf-8?B?WkU4R1JaRzNQbkRVNnFJb095ZTUzWTJJdWRxS1FyR2ErQjFaYmtSLzVZVEw5?=
 =?utf-8?Q?PyyXs7NgZXs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8658.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?by9ybmFrWW1WQXhCMnAzTXpSUjExR1pTUzQxLy9OTUMyVE10UVpEOXVPcHVk?=
 =?utf-8?B?eWQybngxb0tON3JVUnd3MWNqYm5hRHRPMDBDMHhtUzFMbzJqTi93enEzNGVy?=
 =?utf-8?B?RytrRk1CVG5JcU8rS2VNZHJLUFNXWjZSMWZSakpRbTZxN3hHU0w5STdUaktK?=
 =?utf-8?B?MEpXQ3NoblZQWE5ldFFBT25JZ0xhcEMvVm5yby9PVTNxN2IvSzMvbG5senF5?=
 =?utf-8?B?amo3OGNpVEtjNTc4cUM5aEMvSGFXSldlNGFGdzlDa3phcUVTZFplOFN2TU4v?=
 =?utf-8?B?Z2ZnRSs5clkyVmd2b0RtVTR0UmZEbVZWUUh3MGdNT3RDNitXNzFPN1UzRFhS?=
 =?utf-8?B?cklRTnppelBCRE1GdUt2Zlk5M3RzczVqY2VLckxBQi94eHc5RFNJTkJiaXlL?=
 =?utf-8?B?dDc2WHBwQVBqNXl1MFlDTHpYdEhKdEU0aHNsV1duRmtkMWc5ZE4xTWwrSDBu?=
 =?utf-8?B?Vzk4N1lHYkpVNTd0OTI5T29vN1N4VlNsN0hVTGozY2psZm0rQ01WK1p5azhP?=
 =?utf-8?B?Y0I4cW1nNnhuMktwUDV4YnV3RGFtUnhvQlZ6TG5jOWlqSnI5SGduaXUzc1Rw?=
 =?utf-8?B?bCs2bjRDNHFpOWQzWis1R0VYS0tmN2daMDRFSFB6cmNmaW4yUFk2cFNDQVN4?=
 =?utf-8?B?RFUyWDFvTlN5T3c3cEpBQmVpRi9aZVY0eHpXbXgrd3Y0azgrZ0lpTDZVSTZL?=
 =?utf-8?B?YXAwTDdJd2pIWFpzeXVtcWxmUEtWanhrTmt4VUN6ZmV2djNWUXhPOFJYcmdn?=
 =?utf-8?B?V0ttcVpSTUJGSzBWTzlybXNaMkREUUF0NGp1RGU1U3hnelRLU0VaMnJ0OTZn?=
 =?utf-8?B?aU1ZRW5SZlFDZWdtWU9tK25pcWlYMm9WY1k4TjRxMFIraXA0VnRsUGNad21S?=
 =?utf-8?B?VW5HYkRiRDZ6TUhDaFQ1c0xIeU9FeEpGajZBVWxkOGovUVJ6VG5tTTM3WWNX?=
 =?utf-8?B?eWtGcnQyWE40T0xaVmNCSmk3M0ZaVDg5cG14WGsrK29SdkUrZ3hhcUdrQUFE?=
 =?utf-8?B?V083R1JpV285emw0M2MxaEJmdmxHUmRwNnl6aURsckhvYi9xWjNBMGJTVkRV?=
 =?utf-8?B?dGlpeC9UQmVUNldvSmlzdVBlNk81Y2lEdHNEMWFmZUJ2M0dWMWhpY2p5QTdO?=
 =?utf-8?B?azIrWVlURGJ3a3JSMWcraFE0Y3lIYTVlSE1aMVh2bWtjbTUzajFqQnloMzM1?=
 =?utf-8?B?NEFIL2MwWjkxc2VRbjlHUnliNi9QNmtVdjd6MkZ4SEdadURSN3ExU0prS1l5?=
 =?utf-8?B?OEdoR3VIMTRGMzFrbWdjWU1JWHFPbXlvRzN4U28vNU0rWlVEaDhEdnAzUVNF?=
 =?utf-8?B?SFZBNzgzR3FLSG55ODhFN2ZXMmp1NjBXVkhqV3JVajhrN2RyVUtQY0dIUlps?=
 =?utf-8?B?blh3ZzBPZy9UdjUyMG9wN0Zid1F0NUpNRHhGZlZmMUNDR3FZM3h5a3hrQmRr?=
 =?utf-8?B?b1BZdWc3bE5sWVBJYVJSVVl2d3VSN2kzUHN1SnAzc0wyOWEvUytncURvbGFn?=
 =?utf-8?B?bXBJWG9CTW1hZjVVdG4zbnpkbmFVbUE1U0o5d0ZsYnJCY2NmK21WYjdMc2FR?=
 =?utf-8?B?TUcyN0JnbUVRdGhpa2U0QkJNMFcrZ3Rqb3FPUFZKNGNLSTFOQ05CbzZUeWN0?=
 =?utf-8?B?U2NxN21TL1dIS2xEei9vNVF1bHA5QWVrWDVmbmZqaFNkQ3pQb3cvUzRLNksx?=
 =?utf-8?B?UnhXUkkzdW9rN0ZkUWg2MzA1QUR6KzJhYWxwT1owZGV0RDIwRzVqa2w1Rksy?=
 =?utf-8?B?eHErcUJjU3JHSDFkWVR6ekZDenZCdWhJd29xYWZoemxPVlN1QnlKMkhLTVRY?=
 =?utf-8?B?Vm9BVnhvZURxV2dNcmtPQ1Rsc0U0UWJuMEg0R3BSMTM5L20yeXM0TCs2bFE1?=
 =?utf-8?B?VXhzZ25CZHpWcG9oamtoTGdMNWpLSVQ5RUxjUkZFY3ZJYUNvc1hVYzFscVNv?=
 =?utf-8?B?UEV0WHI1OUlHUFh6WHFnWG9LcEhUTFJYbm1GL2s5VkJqQzFEOERUb1Fqd2Ix?=
 =?utf-8?B?TDNOSE0zLzRYYm9FQnVnZUFQbkxqVzNrTi9sZEswZ0xsWFRMM1BlRFZHbC9i?=
 =?utf-8?B?cTVPbU0vZ1BXUEdMZ2FOZWc1c05hekRjZWQ0M2daNDdOaE1laHdFYnBmVDVL?=
 =?utf-8?Q?6Q3HnLuYQEvwWzu/50T1QOMvH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19666626-5479-4bc4-c03c-08ddbdead255
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8658.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 06:44:00.9772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 51YMUHhSiFuNDSPS/1muhMNs6QXKUjxcwr3Q9ESrRAaU/C0tUSzb6NO61wHw0jbbyh1RVYoxDiuvnZeWs4VSUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6234

Hello John,

On 7/8/2025 2:13 AM, John Stultz wrote:
> @@ -2177,6 +2178,57 @@ extern int __cond_resched_rwlock_write(rwlock_t *lock);
>  	__cond_resched_rwlock_write(lock);					\
>  })
>  
> +static inline void __set_task_blocked_on(struct task_struct *p, struct mutex *m)
> +{
> +	WARN_ON_ONCE(!m);
> +	/* The task should only be setting itself as blocked */
> +	WARN_ON_ONCE(p != current);
> +	/* Currently we serialize blocked_on under the mutex::wait_lock */
> +	lockdep_assert_held_once(&m->wait_lock);

Sorry I didn't catch this earlier but building this with PREEMPT_RT fails
with the following error:

    ./include/linux/sched.h: In function ‘__set_task_blocked_on’:
    ./include/linux/sched.h:2187:36: error: ‘struct mutex’ has no member named ‘wait_lock’
     2187 |         lockdep_assert_held_once(&m->wait_lock);


Putting all these helpers behind a "#ifdef CONFIG_PREEMPT_RT" will then
lead to the this error:

    kernel/locking/ww_mutex.h:292:17: error: implicit declaration of function ‘__clear_task_blocked_on’ [-Werror=implicit-function-declaration]
      292 |                 __clear_task_blocked_on(waiter->task, lock);


Putting the "__clear_task_blocked_on()" calls in kernel/locking/ww_mutex.h
behind "#ifndef WW_RT" (which should start from Patch 2 since MUTEX and
MUTEX_WAITER for ww_mutex will resolve to rt_mutex and rt_mutex_waiter in
presence of WW_RT) solves all build issues with PREEMPT_RT. I'll let others
comment on the correctness tho :)


Following is the diff I used on top of this series for reference:

(build and boot tested only)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 1d7f625adbb5..d47c9e4edf4f 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2178,6 +2178,8 @@ extern int __cond_resched_rwlock_write(rwlock_t *lock);
 	__cond_resched_rwlock_write(lock);					\
 })
 
+#ifndef CONFIG_PREEMPT_RT
+
 static inline void __set_task_blocked_on(struct task_struct *p, struct mutex *m)
 {
 	WARN_ON_ONCE(!m);
@@ -2229,6 +2231,8 @@ static inline struct mutex *__get_task_blocked_on(struct task_struct *p)
 	return m;
 }
 
+#endif
+
 static __always_inline bool need_resched(void)
 {
 	return unlikely(tif_need_resched());
diff --git a/kernel/locking/ww_mutex.h b/kernel/locking/ww_mutex.h
index 086fd5487ca7..fd67a4a49892 100644
--- a/kernel/locking/ww_mutex.h
+++ b/kernel/locking/ww_mutex.h
@@ -283,13 +283,14 @@ __ww_mutex_die(struct MUTEX *lock, struct MUTEX_WAITER *waiter,
 	if (waiter->ww_ctx->acquired > 0 && __ww_ctx_less(waiter->ww_ctx, ww_ctx)) {
 #ifndef WW_RT
 		debug_mutex_wake_waiter(lock, waiter);
-#endif
+
 		/*
 		 * When waking up the task to die, be sure to clear the
 		 * blocked_on pointer. Otherwise we can see circular
 		 * blocked_on relationships that can't resolve.
 		 */
 		__clear_task_blocked_on(waiter->task, lock);
+#endif
 		wake_q_add(wake_q, waiter->task);
 	}
 
@@ -338,12 +339,14 @@ static bool __ww_mutex_wound(struct MUTEX *lock,
 		 * wakeup pending to re-read the wounded state.
 		 */
 		if (owner != current) {
+#ifndef WW_RT
 			/*
 			 * When waking up the task to wound, be sure to clear the
 			 * blocked_on pointer. Otherwise we can see circular
 			 * blocked_on relationships that can't resolve.
 			 */
 			__clear_task_blocked_on(owner, lock);
+#endif
 			wake_q_add(wake_q, owner);
 		}
 		return true;
---

I'll make sure to give the PREEMPT_RT build a spin next time around.
Sorry for the oversight.

> +	/*
> +	 * Check ensure we don't overwrite existing mutex value
> +	 * with a different mutex. Note, setting it to the same
> +	 * lock repeatedly is ok.
> +	 */
> +	WARN_ON_ONCE(p->blocked_on && p->blocked_on != m);
> +	p->blocked_on = m;
> +}
> +
> +static inline void set_task_blocked_on(struct task_struct *p, struct mutex *m)
> +{
> +	guard(raw_spinlock_irqsave)(&m->wait_lock);
> +	__set_task_blocked_on(p, m);
> +}
> +
> +static inline void __clear_task_blocked_on(struct task_struct *p, struct mutex *m)
> +{
> +	WARN_ON_ONCE(!m);
> +	/* Currently we serialize blocked_on under the mutex::wait_lock */
> +	lockdep_assert_held_once(&m->wait_lock);
> +	/*
> +	 * There may be cases where we re-clear already cleared
> +	 * blocked_on relationships, but make sure we are not
> +	 * clearing the relationship with a different lock.
> +	 */
> +	WARN_ON_ONCE(m && p->blocked_on && p->blocked_on != m);
> +	p->blocked_on = NULL;
> +}
> +
> +static inline void clear_task_blocked_on(struct task_struct *p, struct mutex *m)
> +{
> +	guard(raw_spinlock_irqsave)(&m->wait_lock);
> +	__clear_task_blocked_on(p, m);
> +}
> +
> +static inline struct mutex *__get_task_blocked_on(struct task_struct *p)
> +{
> +	struct mutex *m = p->blocked_on;
> +
> +	if (m)
> +		lockdep_assert_held_once(&m->wait_lock);
> +	return m;
> +}
> +
>  static __always_inline bool need_resched(void)
>  {
>  	return unlikely(tif_need_resched());


-- 
Thanks and Regards,
Prateek


