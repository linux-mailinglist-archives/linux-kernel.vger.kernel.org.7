Return-Path: <linux-kernel+bounces-808294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DA2B4FDA9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEE355E0CCA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2775934164C;
	Tue,  9 Sep 2025 13:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="GamlUgeT"
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020135.outbound.protection.outlook.com [52.101.189.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD792206BB
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 13:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757425119; cv=fail; b=V5OkJ6FUSqb2fKw+7lSTiWHJhhm6kwiZ7AtLwKvRRMT9did6dymefWA+sbfptSD7sh+Pp2J9X6+1Q+5GsD5Xj1Zh7ANYAJSdWJTdFh60rsK7nExSQ5qfcSl9eqHGNtja39JormtpBq+YqC6/w0wLHsd2xXRv3rG3M88xdS97IHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757425119; c=relaxed/simple;
	bh=GbSEsJdkNtJbWEZ8+11V0nnY7GQcRJ/brG8DGjQ2/uA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=soW1f85KszFVVE8Zt7p5MNeGqcGEieGBr2+rRRzXYBYL387g3w+7Kfol0+GSpBMAW2qb3KvXqt2kzD60x0sP0AdB1zHyBNwqwugM7d7VfyNucrEGNRQL6Qbh2kfrgbWWNYa9AUqqEwUA9426c/rSSxyv4obh68xZGh3xBkHokvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=GamlUgeT; arc=fail smtp.client-ip=52.101.189.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gc1/RTtHSpOAUQnueT482n+Q8eBC7AmnQlJQLmyEb/2CLY6YMuj6xIDxf7iOsvQ/fL4t9Mg8hT5sM2siWL+vJ121i6rPwyYmw8yHBohGso0zUHUTG//CkN8YGJcgymW4ujXsq1QrP+OtYKg+eGUz4LLiNmYYDkRV3sVIYdkCKAbvDSmVjgg0zuurPQmz6xiJNvPjcspwaFAWrEpPB+WX8e8uqB0UQ5W5Olw+MYbJKSm8iEvllxf/ep+tyx4qqnx1h8QNcfCKOYXr6Qcgux5r8h7F2VFo2PlLQRssWBzk+eP5PC4+i4Bp8RHWezI8x848yXXrfyaAWd/FxuMANeyBLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fEBJtFYwwVmNg15Rqh3TQimUobotsQB/RrblcjXOLRU=;
 b=NI1A+UJ62nqe4C9/vnrjebbgY6nGYGbf1tvOZ+v6R5xmMszT8LxOf8w2w5qLszFD0IVWH6rDhhdhSuJjej1n1HTJ3JZzWq3V7KWNGqRRcecIDFV8WvO2RCASfKj6iXhvJei1qls6Rz4vpr85wX4iLTSuLt1TGzLcVDhcZjayaEYG/yFrpI9s0qHyohSMBzUxTVF1Ty75Gt1GFBWz9vKy3Z1VyIWA2LbQWO4IQXYpOlUqlLu7enT9UvAXZ5JYend1i1pwoOum/EGSqKBU4BPNdEy2IfPvxCRb87SGBMIb1KuRu/AmIbil0/DFe1nbIBAHmjNghT7gm3o7nsAYr7Iynw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fEBJtFYwwVmNg15Rqh3TQimUobotsQB/RrblcjXOLRU=;
 b=GamlUgeTEfDUWwHFI8OiBXJVUkj1Njqz/LDS79KtDvOIQFrO9n4A0zNUT+hQR0Q1hJQjcraGXAkbylsN1ZYsFhAz2ziqfhDaggrMHrYwhCg5VLoOtKhCzIz07Vrk2aeJxKn0LSPn2fd6FiD/UtTmkmYZ/M3SLOeKiQoXqZ8v+XSjZhlBweEV/DR30ObSHdmzQOYFeA/9uqSHPwaTm5Bxr1eITPJxqMyW0AOJzYcUnB6tFuJETpIHhqrNftIGnPJgbWrpr6IfZRyqjXTRwIO07fPPtthPNIBNJLQT5JF5zOB7XY6Vazoq8JelYk5Ngkwzf84FjUbaru/F0QSi6ZKAxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by QB1PPF4C719E46A.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c08::23a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Tue, 9 Sep
 2025 13:38:30 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 13:38:30 +0000
Message-ID: <45ce1b35-76ee-41b8-9fd2-b3b0d8126bf1@efficios.com>
Date: Tue, 9 Sep 2025 09:38:29 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V4 12/36] entry: Inline
 irqentry_enter/exit_from/to_user_mode()
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
 <20250908212926.033244852@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250908212926.033244852@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0159.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::32) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|QB1PPF4C719E46A:EE_
X-MS-Office365-Filtering-Correlation-Id: 901dd974-fb32-4511-7c31-08ddefa629e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Sm9hWG96SFFTRU95dnBQWGpoSFovR3dlVTFtZ1JGVHQ4YTFwb25EamJIdXJp?=
 =?utf-8?B?UkRHM2hGa1E2M2dVVmQ2STFDSGxaZGk5cXhOamNmcndjWTNiMkwxQTBsd1Ru?=
 =?utf-8?B?N2tsV2ZSWmtEaERIK1NGVGVOSlkwWG4xSDVrbE1ZRHRjOFA0bWNnMUhQQkda?=
 =?utf-8?B?NElLV1NqU203MXc1djdXaTVpOXFOcitOQjlDd1dZZFRnQ0pLVnB1Q2t6ajVN?=
 =?utf-8?B?ZGRldE9OWlRwOVJoQzdRSUUyeGIxM2ozZlhTRlJ4WUduSXdNSHpPRGhFQlRp?=
 =?utf-8?B?aEVmZDdYbmVPTGRQcEZqK2FkNTFkcTNEU1AwaWNEWE9MNk5vV0ZzdjhQdmdy?=
 =?utf-8?B?cUxuQWhraUhQS2QzUjdReXFscmhlWlVRNmdFVDBjT3Zjb014T3FLc2hwakxo?=
 =?utf-8?B?QmtFV3FOTGY4WlI4TElGQmR1VjFBUGE1UXpkRDMrNlBDeEdUK2l3RTY2MFdM?=
 =?utf-8?B?TUZFeDVvUXRjU3VpV3RGOVZlaFljVVZUbGVYcXZpaVlINmozeWFrNERDclFr?=
 =?utf-8?B?b0Y2N0dMM2dvaFpXQTFwbXJwbG1ORGtER2R3UGR4NXE3S0l2dDh5dDNtVEQ4?=
 =?utf-8?B?Yng2NEh2V1Q3UlhWRWNUVnVab2RaQWlhRmkyQ3h4blhIT3pmZnY4VStZNVY5?=
 =?utf-8?B?YVdJcWFibmVVSGZtZ2FkaFp1N2FBNk9GaU05eEF5d3ZBZ1VWY2RWaTFlaFJJ?=
 =?utf-8?B?VmRKZ2JPRlBXYzFCTmg4enY5a29RRTAyaXpsK1pQVzBpVVdjdTVrUXZOb1Vj?=
 =?utf-8?B?cmxxNUF4aG02UU1xYWMzcnJMdHpvZTRQdy9iUXlkVVNEMlVNZmRQdEMvc2J0?=
 =?utf-8?B?QjNaN3hETTk5SFE4S0RJSkRlV0hUbUNMVEQ1Q3NCb2I1U2Nsb3g2bC9qS3pL?=
 =?utf-8?B?R3B4VUxLMDNKMDFTQVdER2dZR0F0cHN6Q1NHdzNOU0MxS2xIdlIxa1ZDdE00?=
 =?utf-8?B?TDREaTdiQ0l4T0FPakV2Y2dxcEF2V0ZDVGViUGxrLy8wOVUvblJ5SzRQOXY4?=
 =?utf-8?B?NlgzVVBnRHVucVlPcDdwMEE2RUUrUi9xbXJCMm9ja25oOXJjSjVrTTdKT2NR?=
 =?utf-8?B?dkxOY0xIV0E3MW41OVZsditLWGlET0NnSGtrL1ZUSDl5dnBJM3h2amxsTFFM?=
 =?utf-8?B?SWRhbzZTaE4zTjh3Wis2eE5xQmcvYlViK1pERlpMRnhJaHY3Q01NelJPQ2Zt?=
 =?utf-8?B?bjVlQzhTQXBWejdmK1lPREtiNGRZWjVGeis0SHltT3lZb2tycGkzSzNDOVFu?=
 =?utf-8?B?ZFljNVZDZVRrUjRqc2RLZ1FNa3YyMEhoWEQzVDk5REVoVFBrVGt0YVRaT1h0?=
 =?utf-8?B?S2Q3bS9tK01mYS9ieEZiV1dIY2djQXhJdGNRaFFqQzU2dStvekFkcndoZ0Y4?=
 =?utf-8?B?b3JkcG9XYkQzbXhzb3JaeUpPNFZ2b21MbFo1WWlLSFRRbENHZjdBYk5HZUlm?=
 =?utf-8?B?MGF4UC9Jc0tQNmxDT3l3NXpYb241OVRDRVpFYWE2ZHI3cnZUNjIzSGU0WTg3?=
 =?utf-8?B?NnA5SWpSOU4zbnUxekxuc0tKS3RWR3hiUGtKRTBCekV1d3QrcVlnRWIzcnFE?=
 =?utf-8?B?T2l6dWpBVU9ZOXV5TXdQbUlZTEdkSTdVbGxBR2htUVFNVEltaWZSQmVDamRV?=
 =?utf-8?B?RWVOZmZPSFVhcWF0aW1WRHVqeVY1VkQwS1kyeFNKcmpGYlhWZ0R6WkpRbUFR?=
 =?utf-8?B?Nnd1SCszN2dycm9SbW5JamxmbkpPRHFUWW9PWWxOZVRZaXFwRkxWZWJ0TXl2?=
 =?utf-8?B?cEltL0ttMnpuVGdyMkhRamJIT0ZNNy9jRzBxMnZ0YW9Ed2dqeXNvK0I1Smlq?=
 =?utf-8?Q?MyEPMnmL2Uw1X9PEjY6LkB4OcBUN9ZcSlEjaQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UklOc052VVVraTh3NkFyVW53NGtQQ3MvdHdjc1hVb25JSFZUNzRPMHJtdGNp?=
 =?utf-8?B?Zyt0MndOZEtPM3FOVmVpS0FSa0NHU2NkS09UVXRZZnRsSlg5WHJUbm9FNTVk?=
 =?utf-8?B?OTYzRmhKanhhVGZUa1lDVWw0T2JNK2RSMXNFNllPUjJ1RjQxWldYV29CcjBw?=
 =?utf-8?B?Z1ZTclFIemd4ekhCcCs1eWx2cldmNnU4SmI2aHZHSE1rNy8xazNNM29oaEs1?=
 =?utf-8?B?cWU5cmJQa3gwQmdRcWdZUkcxRWpEU2d0RGxyMG9GcmNHUVI4ZExLTzNycHZi?=
 =?utf-8?B?UG5wTlYyeEZrNCtsdm5FZlJkWXhITERacFNiRXQ1UFd3ckdhV2E3bDR6b0Ri?=
 =?utf-8?B?UDhYVEVTNWVCNUFTMkhPNG5WSzkxcEx5WTNxWlVnM2RBd0JwdHZQaTVsdWpq?=
 =?utf-8?B?Nm5Qei8xOVhkb2U5c3hwcVlCT3pmQjZoallwSHFNNkVqNVlwUjllT2pUaFNt?=
 =?utf-8?B?ZFZLRWFCeTRtdkRhWVlCd3o0NGw2QnBlZ2hMU0swUTV0OUYrcldTaDF2NVFq?=
 =?utf-8?B?dkppMkE3TXNWWEp1c0VtcHVYRzVva01wVlNlKzZDalBRdmRrMERhVjY3MzlZ?=
 =?utf-8?B?NzNkRzN1emQwWnBkaSt6R0hPMG1kSjFtT1VlYi9RU29KNFNjWnRpYkxMS29V?=
 =?utf-8?B?N2hNUGZPd3Bta1hGQUY0V2ZNOWxGbUUweFQwV05oWEZFeVlSK3NtVGxORHRJ?=
 =?utf-8?B?T3NrK0I3VzBGVGdGUkhKbWxYVDlXczFvNXNTWWtYcTdCdW5nKzVSMU1PdEhJ?=
 =?utf-8?B?NTEzSDMvTVJ5SS9vZjNJSjFacXBYUXcyc0hVdHlESTIrZTBSYjkzNFBxdUZ1?=
 =?utf-8?B?bWZxS2tWV1hUVjFWWGlockVwKzMyQ01iTU1EWkhMZGVsekdrdUMwVFF0VWlB?=
 =?utf-8?B?Sm9COE5ZUFJYU085SmdOcnJGajd4RjhoYU1nZGY3YTNWenE2T2w0bUJGY29Q?=
 =?utf-8?B?SEVncWlJTmhSS05TdllsQVNMTU9vZHdraktjc0JsNWZiVURHZ2hKdHdwK2xE?=
 =?utf-8?B?MFdCU0hjQi9kK1R0RDdSWDZkdnBJaFo1Yk16eXY5MldEMG1Fa0M4VG5zbDlR?=
 =?utf-8?B?L0x2SVRJdGduQlBwWUhOMlVUbkppRFpkYVRWRWNlRmRjbVhZUXdUd0dCSXNZ?=
 =?utf-8?B?REFMczFFVklzL3lwVllXcHBselNWd1lvQVc3L2NWRzBMWVVkRkhQZDFXNjd0?=
 =?utf-8?B?YjUvN1NPOVEwK0YvNEZQSG1wN3JXMXVDUUxkY2VrRS9MRGM4VS9na3lRNjZG?=
 =?utf-8?B?elZrWTc5L1N5YUJ6TWZVMjhJMis0bXE3MzF1eC9Qak5uUEtGdXhSeGFNb1RX?=
 =?utf-8?B?MEd1ZmlaQmNvSDczQittT0tYQ2xMZW5zd2NGNzc4NHg1NTZBNnRmVkVZRUNH?=
 =?utf-8?B?Q1ByWUYvUzdmeFM0SDh6ZXlBYUx2THg3N3ptQmwyM3ZFSW1PSnU4UXczQ2Y3?=
 =?utf-8?B?TVVFM1BPd3JyTGswZ01QUk9SYkVYcHRTVytKUW5LRUtCZFc1UElMdVRKQ1F6?=
 =?utf-8?B?aXV5OHhVb3dOSmZOS0sxZEFqMGJMRkZKNzVkWnJNUXdPandGUzA5R3psYTJ5?=
 =?utf-8?B?dWV6Yk95aU9kVy90ZE1PanJkbHFLaHFnM3VxdjYrWUkyY3BienZzVnpHVExX?=
 =?utf-8?B?QTVORmYyRUVNSkUwZXdMNFNBaER4c3lBVGJTcXgzem1CTS9yZ29SejNXUGRC?=
 =?utf-8?B?UkFSUUgxc3NMdzFQTmdFOEJWa2pmYkhBTUgyTTBvU1BFcWRJUmV0WWlhaklk?=
 =?utf-8?B?bThsZk5OZ3BuVmRHSnFxcHJtK041Qzg5MzBWc0VrYTVSNmx1WmlBUUJBNWlE?=
 =?utf-8?B?RzB5MGkwekpFcmdKdGNlNEZvWW5Oa250S1V5Q3FTWGRqVHRZTWdLNnZ1em8x?=
 =?utf-8?B?YzFKWGtmYUdSRE1yN2NsQStaVU11Z0ZHblZUWnhyNHF3N2YrYTAxbmpEaUMx?=
 =?utf-8?B?dkJJWnVTbWxMNmJ4QS9BRGFYYUFya05EYnlPU3luVVpFSG5LYU8vbXpwUVFV?=
 =?utf-8?B?RyttWk5uNys5L09Fb2hFL0RJbE1pTDhiQXNGUDBmbnFoekF4Ymp1b3psUnZ2?=
 =?utf-8?B?eHRSc0s1aTZKcVhtVFVwU3ZlN2R2R1E3NllHSkpHaHd1N0FoSHg3T0toMnh1?=
 =?utf-8?B?eFFmVUp2NnRTZnl3T1A3aVlzWU1TTUU3bnNiSlB1eXdTQ1VaVnE5dFQrZmhj?=
 =?utf-8?Q?vPgFuwmL3cnZLdTpO+2FVu8=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 901dd974-fb32-4511-7c31-08ddefa629e8
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 13:38:30.4978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CiZXVea6msM42/grqVSe1E5moe8shxqTPqN/N2BjQdGiB1aE83U1KYDNwN04Dg9NmrQmPRTaXx4dfzTdTCXKqCSmIBU8SBX5hZMuUgKSAKU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: QB1PPF4C719E46A

On 2025-09-08 17:31, Thomas Gleixner wrote:
> There is no point to have this as a function which just inlines
> enter_from_user_mode(). The function call overhead is larger than the
> function itself.

I'm wondering if there is a reason for making those actual functions and
not inlines.

The functions sit in kernel/entry/common.c, which are built with
specific compiler flags in kernel/entry/Makefile:

# Prevent the noinstr section from being pestered by sanitizer and other 
goodies
# as long as these things cannot be disabled per function.
KASAN_SANITIZE := n
UBSAN_SANITIZE := n
KCOV_INSTRUMENT := n

# Branch profiling isn't noinstr-safe
ccflags-$(CONFIG_TRACE_BRANCH_PROFILING) += -DDISABLE_BRANCH_PROFILING

CFLAGS_REMOVE_common.o   = -fstack-protector -fstack-protector-strong
CFLAGS_common.o         += -fno-stack-protector

So I wonder if we're not breaking something in the area of "noinstr"
tagging by inlining those into their caller ?

Thanks,

Mathieu

> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> 
> ---
>   include/linux/irq-entry-common.h |   13 +++++++++++--
>   kernel/entry/common.c            |   13 -------------
>   2 files changed, 11 insertions(+), 15 deletions(-)
> 
> --- a/include/linux/irq-entry-common.h
> +++ b/include/linux/irq-entry-common.h
> @@ -278,7 +278,10 @@ static __always_inline void exit_to_user
>    *
>    * The function establishes state (lockdep, RCU (context tracking), tracing)
>    */
> -void irqentry_enter_from_user_mode(struct pt_regs *regs);
> +static __always_inline void irqentry_enter_from_user_mode(struct pt_regs *regs)
> +{
> +	enter_from_user_mode(regs);
> +}
>   
>   /**
>    * irqentry_exit_to_user_mode - Interrupt exit work
> @@ -293,7 +296,13 @@ void irqentry_enter_from_user_mode(struc
>    * Interrupt exit is not invoking #1 which is the syscall specific one time
>    * work.
>    */
> -void irqentry_exit_to_user_mode(struct pt_regs *regs);
> +static __always_inline void irqentry_exit_to_user_mode(struct pt_regs *regs)
> +{
> +	instrumentation_begin();
> +	exit_to_user_mode_prepare(regs);
> +	instrumentation_end();
> +	exit_to_user_mode();
> +}
>   
>   #ifndef irqentry_state
>   /**
> --- a/kernel/entry/common.c
> +++ b/kernel/entry/common.c
> @@ -62,19 +62,6 @@ void __weak arch_do_signal_or_restart(st
>   	return ti_work;
>   }
>   
> -noinstr void irqentry_enter_from_user_mode(struct pt_regs *regs)
> -{
> -	enter_from_user_mode(regs);
> -}
> -
> -noinstr void irqentry_exit_to_user_mode(struct pt_regs *regs)
> -{
> -	instrumentation_begin();
> -	exit_to_user_mode_prepare(regs);
> -	instrumentation_end();
> -	exit_to_user_mode();
> -}
> -
>   noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
>   {
>   	irqentry_state_t ret = {
> 
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

