Return-Path: <linux-kernel+bounces-744031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 614B4B10719
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2043567905
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F07257AFB;
	Thu, 24 Jul 2025 09:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Z1feI7lA"
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013065.outbound.protection.outlook.com [52.101.127.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F913246766
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 09:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753350982; cv=fail; b=ulT6COPNUrFYbkf/9UU2HJL/AT7gyktQqPRHRIkkgpX1415vOxvWm43GAIosbgUsGCKdrz9G9m54ecHz+CdOEYKhIvzhHNq3rJ4PFyGfEYUD6jbnUh24m0STc1G8DFHstf8AkFuVQSoJ8MseZugA7EmAWvYHggFkV29ih5JB0ZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753350982; c=relaxed/simple;
	bh=gt/jPYb80z2JJlyCiYeByt63IaBuaO8rUC3w98k+KXo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hjwRFU0Q4o4eTxr+zAWT0v+BpHU7ED7bbqWwZe3YQOeeDSPwBxYkkaXe8wvpchaPCb6+NJpD5c898AouaOGC0m0Vpix8spjl72QKGvwQYiY+pHDbkZiqsAXQ1uKYxmEjZ4eUi4kEcxiJpc2InfWMXCWx+9SI2AMFg7TnvAUABiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Z1feI7lA; arc=fail smtp.client-ip=52.101.127.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XLm/+/GObZdgCXrndUnsjaTu+VJxNvX+A0x393rAoc6jna9aZfEiaAp4IEz4VJh7uiqS4CmNBOk5x9NUqsPbfHqlnIdyBdEWqrgqVN4bxMzW+pJImzJQzg0H9gXChKJc4zUeB9+VADzvQTEG9OB3AiUlKfncHpvky6jSqaHADHUagoq1f8apzmH2A0mTbj5wYZeVMuWthdJUJdV1I8rbJ6NSdEPPsYZsmvdWKlZZ90X4tirkuC/0nA3OcxCdf89WYYowixU9qPm3ZqmJJQxb30XR92FwGdXFHOv82AZxlsh92QDFVVLiyGAWFZp9J8fVQ3TM8OSHR4fpX1s6/CnNvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dSqix/EBeMqcOniiLlVJdlAAuHnyRWFc0N3mEyuiY+E=;
 b=dRCtlRDk2K5aeAlP6J+8585p5G74uichD3elaLg0QXo9dS2arhQfI9bpR7unHtVq7LN3BFKP9E4zHnuAau3ZOS1GYHhp3liCSha2ffrIqDFHW7Jipr3cpLrFDBnuUy6eHu4ngmyQpTpgJIg8py2iT3pApHGXNF63Z9X4+CkZ35jptmfuGIWPqWKEXOKb2Kv8oiXQGNmMscnTcFwMtfbB40hNqJNpoKbuEwkSLyeVtgC41Q2qcy1L5TCj4+1lhn9EnsFsXGUaUsHmYjzS4DmI/mVmWyhflW4G6TztWezghCKTutlhlEFVAyT2JwF81JLCrEDqmQbxLHUZJBXH/gIt9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSqix/EBeMqcOniiLlVJdlAAuHnyRWFc0N3mEyuiY+E=;
 b=Z1feI7lAGZ8WKEFXM11xXn5hm54w8tbneXNj6BJd6C/W3ZzTKsk4IXJsMuA0ksu4XfQJxEGCAobEBJFK9eyK7u/g+D029WbVJR8zJo5xqovGkGctimPPeqzFLSQZDBTOahEwqxgghNw0jk/9oRo4R8Y6A9GPI7y1Z/284rBVxGE6XXnHeQx4Zk6d2T0rCX8td/J/n1ikwj0l+y5eN9EuoDdM8GeLEu/E2Ek/5ofAfqxnJGs+i/zBIVuY/K7dKzzNypYDTdk4vqw59O/rkfYkdyX/OFYK0JmGTuUVupGIBoYCpj16+HABDR4O/GJExFUXxJXnVWakMJ0eylmE6XP+Zg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by TYZPR06MB6770.apcprd06.prod.outlook.com (2603:1096:400:45e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Thu, 24 Jul
 2025 09:56:16 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f%4]) with mapi id 15.20.8943.029; Thu, 24 Jul 2025
 09:56:16 +0000
Message-ID: <10484264-e863-46e9-9797-d2d76a531557@vivo.com>
Date: Thu, 24 Jul 2025 17:56:09 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/9] introduce PGTY_mgt_entry page_type
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, Rik van Riel <riel@surriel.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>,
 Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Zi Yan <ziy@nvidia.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Christian Brauner <brauner@kernel.org>, Usama Arif <usamaarif642@gmail.com>,
 Yu Zhao <yuzhao@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250724084441.380404-1-link@vivo.com>
 <86516155-f2d9-4e8d-9d27-bdcb59e2d129@redhat.com>
 <cc560d48-884d-4c8f-9fb0-565d74ad769a@vivo.com>
 <e9bb93a6-1e95-40e5-ad10-a60d80735432@redhat.com>
 <6d14e212-418e-4734-b256-b75c6fade25c@redhat.com>
 <23b986e2-80d6-432f-8188-7a11d6915c9f@redhat.com>
 <cd253bcb-3ffa-4871-ae11-59d158fafada@vivo.com>
 <f21b75f9-0650-44c2-bf47-516390364a8b@lucifer.local>
From: Huan Yang <link@vivo.com>
In-Reply-To: <f21b75f9-0650-44c2-bf47-516390364a8b@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::14) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|TYZPR06MB6770:EE_
X-MS-Office365-Filtering-Correlation-Id: 371a3114-ee80-411c-bba1-08ddca9854c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZHlKRGU4Y2d1bkNHT2c1Qkhqcjl1azcwMEZzK1JPcDdMblVUYXNyTHlsbGdO?=
 =?utf-8?B?czRrUHFMSW9oYVpsYmJrV2FEZytxZWdraCs5a0tOU0s2QzhXaUgvYndyNXU0?=
 =?utf-8?B?WEhKMnpxcC96SnRWQkk1Y0FQNEduTTEyOGFiOVNiNjBSN3pGR2RNWkttWkww?=
 =?utf-8?B?NTR1OEhpOWFDTUNZQ0Y1allSckptM0FsNDJQU2dxYlZzbnRQRm44UHp5ZlpC?=
 =?utf-8?B?YnRoc215M2hTdldOK2RVbFhlVjhQS0hGbW1aVEZKZEZOTHZrMGpJOUY2NGJE?=
 =?utf-8?B?WWI3S3dwOTEyekpxSHdZc0Nlc09vU2VqcysrKytxZ0k0TmRHSHdObjh4eFg1?=
 =?utf-8?B?ckxpTGs4VlBrY1NMZlhWWDRscFBFZFRkMUw5OFJnMHNjbUpIMzRqbGdWZUI2?=
 =?utf-8?B?NGROdkptUUExRjVaZ3R3dDEvNC96d2RtK2pHZEt0bk85WTJUNnErYzJMcHlH?=
 =?utf-8?B?T2prZTAzNVcvS1p6ZUQydWh6WW9VT0dyTFVPZkNiSHFBQ0gyRlltYmpnc3FM?=
 =?utf-8?B?bm9CZG55WHJIMFVnS0pLOWF3UzVibzBUOFdva1hLY3Z2WXFZRjBiYTZKaUE1?=
 =?utf-8?B?MHFoaDNNQ3ptdzlRSFJVdFVOT1hsSXBORjZacFh1Z0xkUVo1RlF0bDU3Z01R?=
 =?utf-8?B?NzhxWUZXMnBkbEJ3MWVxNENjajNFNG9iNUpuQ041RzZmRndTalZiYWRTNE14?=
 =?utf-8?B?cVcvVHFrTFJ2aUx5YUlVaDVkSnBCeXdYbHRLMzVweE9QcG56WnFIc2hhd0Jh?=
 =?utf-8?B?TFVycHl0MTBXUG5VU1hiMHA5aVExWVhaR2Z3N3hyMWJqOUhSdjNKTTIyWVZn?=
 =?utf-8?B?SmVROGRzQzhCWlY1VHE5c0pWdVdPS2oxblRkcnJQbXF4eHNON1V2ZDlCcXFG?=
 =?utf-8?B?YzlMb2l4SnhoYm1nUm5KOUo5dEt5cGFYendVa2JVQnkxWWNWT3ZDZGJ6SklI?=
 =?utf-8?B?bm1GZkVpU1RiK1NvSXNTSHVvNG9wTG5vNEw4UnN3RXpTSXQ3ZjF0TWFlTUNs?=
 =?utf-8?B?RGZGL1kyREJIenBCWUVXcUFrcit0Q016VTNZU3pXS092NTJOMWlaTnA5RW1Q?=
 =?utf-8?B?Smh0NzdqQys0Um5HV2NFQmV2RXZheEZ0SW5mRUthSEZJUGxpcktoWHlIRXhw?=
 =?utf-8?B?dWRNbG5yYzVtR2ovRWg5ZDNQeWg2SHZucE5WU3dDTzRWUTFSRm0yNXBJcE5z?=
 =?utf-8?B?UlBZK0hCb3lqaytTNjNuaFFUZnVVVVQvTkQrYU5FclR2WFlEaDhOUXJ2VGs0?=
 =?utf-8?B?bSsrV2JlZml5eWl2MGpUclZQTGdRRHV3am1DRngzWWIvUTFHWFlkSHh0TjNq?=
 =?utf-8?B?aW8vb1BWdTBwck9hb3U1Z3duUFpndnQvN1N5MlMrd3BCbWw0OEdNdEt6bE9F?=
 =?utf-8?B?eEIrdElsSm1Fb0xFWEZFOUdEQ2Jyei9EcnVHREIwUTd2T3lqYUF1RUFUSUpQ?=
 =?utf-8?B?RzZpeFV5c3llekdNUFlCRmUvMkN0ZlovYkhtV2tDTkhDczB4MkVQR1FEc0sr?=
 =?utf-8?B?RmxpUFdxdUEwa0xtZGF0ZHRkRWhiV1FTTXIzcXdKR0RqZHE5b3dTdE11amN6?=
 =?utf-8?B?QWhjeVQyak5CMnNKeW5ISHhPbUxHZjQ1SnpVcC8zZzRiNGtuSWQ1TE5oTmdE?=
 =?utf-8?B?WFlLTDdHL085bnozUnNiU2ZtTjFqMjl6dlJraGN1SUtQTFBZd0kySE1pQ2Vz?=
 =?utf-8?B?L3k5aTBNZi9ZRzEwUTFDOVk4bFhMdnFMYkd6R3ZQRFhRamNBRG80OXNHM3A3?=
 =?utf-8?B?MmZHcjlZdDlTTklXWEFEbkFVMHpkM2R4VFB2dUxMMWFDbWt1bXEvbG51elhn?=
 =?utf-8?B?VmlhRmRqck02c0RSdURWUkU3dXVNK2EweC9sY2FWY00wd2V5QTZTckIrQ0M4?=
 =?utf-8?B?SFJkL0ZaUlFqZSt1MWlmZzMyYmMxelQ1YjdYM1BiT0VFNk00WVlJV0xkWnIv?=
 =?utf-8?B?dXJXQUxrWWRtU1VoY2Z1NHNYL2pwK2NicTN5cVl6VlpYT3B4d1Fqd3BuN0sx?=
 =?utf-8?Q?nqbwNrrE4JZ3jf1kj+CVxLHdPLCgcA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aTJ6bUE5djhPMHQ3ektDQlN6cGVkbUN4UEk4bEhnNVJocWxZTWRVeHBWVHp4?=
 =?utf-8?B?RnNNaVllV2dxSHNTZitoSHI2ZHVqWk5pZjdkVTViUGREY2F4VU81OEtXYzhU?=
 =?utf-8?B?Zm44QWw1RlVBYzIvTGxzWE9veXpQVUNkY1Y3cStBbCtDMFdCczljclBiZXJY?=
 =?utf-8?B?dlNnekFjQ1FKaHF2VFNBc2ZZUmp2UWxPNDZISllVbGxYL0FUUm53dUc0VXZM?=
 =?utf-8?B?OHlyUWsrVHVyRHZLTDFNc1I5TXgwTEk2dUw3SG1rTzlEbnBjbHdTRG5RdFhv?=
 =?utf-8?B?TTFDQlVQU3NZa3BkUnZRN2JwQmRVUmpnYTJIdnlVMm1RWUdPckhyclRYT1M2?=
 =?utf-8?B?V3BWdjZldmEvbGE3VGZqQysyaGJlNHVVTUpCRkkyU0ZsNG43UStlY0hMek9w?=
 =?utf-8?B?MjQ4a2dRczFSR3BLNnoyajM2bDFqWnYyMjFlajVDc2l1azBGQjVQdXVpcGJ4?=
 =?utf-8?B?TlFwbzR4VHg2V24rU3hiL2N0R3AwUFpobjBmNEhUZ240d3Foc0hXSWIwM3U2?=
 =?utf-8?B?NTM4ZDRUSCtTcmR0R1UwV0pJMkowemNTZ0x4U0FJZzZPWlVDQ3lUVG5CUGhz?=
 =?utf-8?B?Mk9BZ29BcllodzRRaFcwZEdONkY0MGJMemhGYzByNXFtY21kTlNDVGowTEpv?=
 =?utf-8?B?eGd2M29Jc1BKR2FrSm5tcnhNT1c5VlNreVlFSGc3UFhEeGo1QzRINXFQcmZU?=
 =?utf-8?B?UExzenRhWlBFWkJoaUZpNWl6TnVpWnp4U0FqUjNtc1Ntc1ozbzE2UXA5STMw?=
 =?utf-8?B?YTAxUTdSWWlVWGVZRHgrV3Z5RWVKZkwzTW82ZmxhakFLd3pIMzVNZHRPcGJY?=
 =?utf-8?B?NTU1N1NvK3JqejVFY2NMQVpKN2hGZVpYVkYzNUh2SGpmeURKU1dPK1A3dnk1?=
 =?utf-8?B?eHVGRWxmKzVicUNWNVhVTmZGUGgrdkhYRE9YTTdzWmJETDZKQ1hNUjBSM2dT?=
 =?utf-8?B?bXJ6VUNmeTBFS1drdmlPdTJENEFJV0E4aEJ5QWthNXAyTHNZY3phOGFuOXEx?=
 =?utf-8?B?TmJmWnBkMFRUZzVwcG9kTmUrT2ptcGcrM2hoWG1HNzRkUjBVazZHK0s3K2tG?=
 =?utf-8?B?bmRnVDBON25ULzJaZlFzaEpSQkwwUk5KVkEwWUJmUWpTWElBVXlPajNZWXNq?=
 =?utf-8?B?MWFNYklkbHlFd1ZnUk9xc2ZlQVgzVjJndjVvSjY2T3IvR3J6NzRBd25qRVQy?=
 =?utf-8?B?YnZOV0pBejkrS0oyQlMxbEd6SEExWUhtUFh6dklrUXBYZThKZXJ0RElvZjNO?=
 =?utf-8?B?N3JYR2g2UExiVzUzSjI0WUdEOVZxcS94dlJWdXU0MngxRXZWdXg5TEtiMVhG?=
 =?utf-8?B?aStCRkMvR2lvL0s2bUI2dDAxTUdDekwrdDZsb2JyKzRpNG9BUlJnOHh1bExp?=
 =?utf-8?B?Zzc1czVYaTdIRHRmM0ZPbmhMWWVuQ2dkNytyQ3FJZnpYcjhMSVh3RGlManJM?=
 =?utf-8?B?dlRoRTFrQ1RrV2Q1ai9CaWJMaGlUK3FWRVpIK0tYN05QcTVVSmxmNjBTQ2pq?=
 =?utf-8?B?TGE1NnZ4RjBwNEN3dDJuTFpRczZhbWZPVFdHQ2NQVFk2VE1VRFhiTms1cjNq?=
 =?utf-8?B?YzdkWEs0K1pYMzh4bkZrb2h5M2RlOW1TOEdMR1pQcnRQTjZaWlgvYTROTHho?=
 =?utf-8?B?M1dZZ3dpdXJGNG53aXlOQS9qa0RTdDE4KzdxQy92dG1neHJjSkxSV2c5c2ZW?=
 =?utf-8?B?MWdSOTBWMU42Y3VzN3ZBMHg0QzJBY0ZKQkpVUVIzYkc4SnNRVzNKSElWL09W?=
 =?utf-8?B?QVVZZDVPdlpBbHIvVHFNNnhCRitqL0QvakNUbUwvSXc5RkkwQTZENXpYT094?=
 =?utf-8?B?ZHZHOEEyKzZqQVU3T2ZGNVpPUk1vQ21kRVBGcnlmWE9GQjNvU01TaEVBbElX?=
 =?utf-8?B?MW1ISVYxczBUQzh0Z3VPZ205bzMxWWJJTUN4amwwUHV2NVE4M2h4OFZuM1I0?=
 =?utf-8?B?aWpnQTJVbXVxbk92cUpnNVdLZG53S3VaSzB3ZjdXU1E2UjJxNVpjbUFvR0Fu?=
 =?utf-8?B?UUR2SDVYRUxZUDdVcXZ3RlJyVGhNdFZsaTdhZDFDakZCblhvb1c3ZEVROUEx?=
 =?utf-8?B?dm91bHk0cjZsdTVGWEo2MmdmOVJBT3BmMDBJbzRRcUNVUzB3OWEyWnRFOU16?=
 =?utf-8?Q?YR8mV8YJVyAKtoqdRJmlB+6U1?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 371a3114-ee80-411c-bba1-08ddca9854c5
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 09:56:16.4374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pqH+seDY5GGS4oRLBReSKG2ATVyfrzVIE1awRR9Ay9HBFZD5mJL/QMyOhddrjoU/IqfWp3Ybwp5DcaSxABjMnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6770


在 2025/7/24 17:45, Lorenzo Stoakes 写道:
> On Thu, Jul 24, 2025 at 05:36:27PM +0800, Huan Yang wrote:
>> 在 2025/7/24 17:32, David Hildenbrand 写道:
>>> On 24.07.25 11:20, David Hildenbrand wrote:
>>>> On 24.07.25 11:12, David Hildenbrand wrote:
>>>>> On 24.07.25 11:09, Huan Yang wrote:
>>>>>> 在 2025/7/24 16:59, David Hildenbrand 写道:
>>>>>>> On 24.07.25 10:44, Huan Yang wrote:
>>>>>>>> Summary
>>>>>>>> ==
>>>>>>>> This patchset reuses page_type to store migrate
>>>>>>>> entry count during the
>>>>>>>> period from migrate entry setup to removal, enabling accelerated VMA
>>>>>>>> traversal when removing migrate entries, following a similar
>>>>>>>> principle to
>>>>>>>> early termination when folio is unmapped in try_to_migrate.
>>>>>>> I absolutely detest (ab)using page types for that, so no from my side
>>>>>>> unless I am missing something important.
>>>>>>>
>>>>>>>> In my self-constructed test scenario, the migration
>>>>>>>> time can be reduced
>>>>>>> How relevant is that in practice?
>>>>>> IMO, any folio mapped < nr vma in mapping(anon_vma, addresss_space),
>>>>>> will benefit from this.
>>>>>>
>>>>>> So, all pages that have been COW-ed by child processes can be skipped.
>>>>> For small anon folios, you could use the anon-exclusive marker
>>>>> to derive
>>>>> "there can only be a single mapping".
>>>>>
>>>>> It's stored alongside the migration entry.
>>>>>
>>>>> So once you restored that single migration entry, you can just stop the
>>>>> walk.
>>>> Essentially, something (untested) like this:
>>>>
>>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>>> index 425401b2d4e14..aa5bf96b1daee 100644
>>>> --- a/mm/migrate.c
>>>> +++ b/mm/migrate.c
>>>> @@ -421,6 +421,15 @@ static bool remove_migration_pte(struct folio
>>>> *folio,
>>>>                       /* No need to invalidate - it was non-present
>>>> before */
>>>>                    update_mmu_cache(vma, pvmw.address, pvmw.pte);
>>>> +
>>>> +               /*
>>>> +                * If the small anon folio is exclusive, here can be
>>>> exactly one
>>>> +                * page mapping -- the one we just restored.
>>>> +                */
>>>> +               if (!folio_test_large(folio) && (rmap_flags &
>>>> RMAP_EXCLUSIVE)) {
>>>> +                       page_vma_mapped_walk_done(&pvmw);
>>>> +                       break;
>>>> +               }
>>>>            }
>>>>               return true;
>>> Probably that won't really help I assume, because __folio_set_anon()
>>> will move the new anon folio under vma->anon_vma, not
>>> vma->anon_vma->root.
>>>
>>> So I assume you mean that we had a COW-shared folio now mapped only into
>>> some VMAs (some mappings in other processes removed due to CoW or
>>> similar).
>>>
>>> In that case aborting early can help.
>>>
>>> Not in all cases though, just imagine that the very last VMA we're
>>> iterating maps the page. You have to iterate through all of them either
>>> way ... no way around that, really.
>> Indeed, whether we can exit the loop early depends on the position of the
>> terminating VMA in the tree.
>>
>> I think a better approach would be to remove the fully COW-ed VMAs and their
>> associated AVCs from the anon_vma's tree.
>>
>> I've been researching this aspect, but haven't made any progress yet.(I have
>> some ideas, but the specific implementation is still challenging.)
>>
> Please leave this alone, I'm in the midst of trying to make fundamental changes
> to the anon rmap logic and it's really very subtle and indeed challenging (as
> you've seen).
OK, but I still try to research it, not only for upstream or something.
>
> Since I intend to change the whole mechanism around this, efforts to adjust the
> existing behaviour are going to strictly conflict with that.
>
> We are 'lazy' in actually properly accounting for fully CoW'd VMAs and so can
> only know 'maybe' if it has, I mean as from above you've noticed.
>
> The CoW hierarchy also makes life challenging, see vma_had_uncowed_parents() for
> an example of the subtlty.
>
> Having looked at anon rmap in detail, I have come to think the only sensible way
> forward is something fairly bold.

Woo, that's really interesting. I'm looking forward to this.

Thanks.


>
> Thanks!
>

