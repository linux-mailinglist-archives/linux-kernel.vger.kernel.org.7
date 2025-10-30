Return-Path: <linux-kernel+bounces-878468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C01C20B18
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FF79427777
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E63A27BF93;
	Thu, 30 Oct 2025 14:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="APncuDNe"
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020132.outbound.protection.outlook.com [52.101.191.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFFB25A2A2
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 14:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761835565; cv=fail; b=uqgOn21vTI/pTRj1P+zv1yTi3z+hrvsEpvyaUGozLPNJz2BAw+5ChWh9qsjUAqOUAaNkAB6kwFay8j8hwVRDZIm7DNzZd9Gg17AVmGhFYu5m2frznG9kARbFNhNZ/8npM+5P0yhAV1Us40V1yCjNJstxMlDIUc/Nkxk3FBNkc7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761835565; c=relaxed/simple;
	bh=IbJRMUSOecipdqhj74roczGr1GeIi7IG/4Ug+Q3EVAo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZtIRNZEN/y/bqw6uZMHRk6rgbXxUqT4ewRAyMM/gdu269w/95Gm0Y0oP91ssJb8mOdpglsnlDVlAKyXWGgvXlVhuhQgkqxgJPY0dic4lBw6v3vN8A1xUA/gQmGDScpJrbp1rhZ0OUcSYOHtmB/rWB4pACKLDbSNp5amfG+pgqTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=APncuDNe; arc=fail smtp.client-ip=52.101.191.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sJui4mQKZQgGOoYFobi69sWkOmqj2PO4PMJfSYQkUIk4cdRKTGXUy5VT/uP1QwOPKpz8UHnrPClaidd56dllHyrfmyd4L2Gy7cZ+148fpPLkdz01HCe3M2ES9KzNxzz6F4/HoH347KtiwZ7K9uqW9U2tfiIZvHLx+EKh+Zxsn+n9I6ovmePx72katB3OkfLNVikBclB4H6tObBPO79wmy8fkajGxCAcv82fGrqVFIsVEnuwtapZqLwlp+CRXAaBOTGm/piUdtnO4Rd85lV3HAR2X/Zoca0ov9iIAuMnmU2vTR66g4ApsmCwKsB37TW7v18I5fxZnSKxEV5ysrEQz8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xdff9DbbNEHy9ybTCbEvZGuQHesOAqx/tINZm0/EfMk=;
 b=DNBrnTZfhRIomfhejLctDzXG68GvRkhYU/xMcEk7T7W37uVNxVsrjazqrC0AlT4octPvg3sTasmz4uav/nxIST4E0v32gdSRmvL4SQyyrgzDkgtUf3GLOZAW7YnZfMXyCyRNWgndW46XdWY1hUzYxnAlBMEyMxa/W3AtbEpKcDLz0C5zrvbGB9exZu6XUWsXqcnUSfu7z04r2a1c4kv7t0Z9oWkkRuaK5QJ9RageTKthwjIrFHbZJ6fGMVr7tFHWmhFbg241owCOT3LDhanvvftUZZz98a2KfWascXty6Gyb7hrBo6cmKMNQ1tSJJpS7g/TaHU0tDPjgt/4kVuJMVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xdff9DbbNEHy9ybTCbEvZGuQHesOAqx/tINZm0/EfMk=;
 b=APncuDNehkUmYvvwUReLc7aAKLTWjK7cB3GD1Y/mfgR3dR1XQkrX5os5kVQ6bfB4+0cwNG1MW3Ph9zGhgGJrsAZMoIcVvp8u43s4N4qeHS0vzsqYaRBsHg1VHmCtKtVUTsHyamP9e6j0IQ7yy0FUHVoTRaYixo+2JbqKn0UfRtIXpLX/hmw8L0V11Gh0Yz6MUMSoM50/ES04n2KfyKXXQoq37BBMdTGrlz3eD5kW36Sz54qhGFE6CbpWckvGcX8cPy8Og4toV6YaAPy9ILVQqUFPfXUpnkz0q69dyR9JygH3HUWJqVyKCfXTXbwI68baTIXvSpPJyxODdIQLo0Zyyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by QB1PPF8D13D38F0.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c08::25f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 14:45:58 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%2]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 14:45:57 +0000
Message-ID: <f2c2c954-0991-4974-9ae5-6cf14314781d@efficios.com>
Date: Thu, 30 Oct 2025 10:45:56 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V3 15/20] sched/mmcid: Introduce per task/CPU ownership
 infrastrcuture
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Gabriele Monaco <gmonaco@redhat.com>, Michael Jeanson
 <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Florian Weimer <fweimer@redhat.com>, Tim Chen <tim.c.chen@intel.com>,
 Yury Norov <yury.norov@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>
References: <20251029123717.886619142@linutronix.de>
 <20251029124516.221091724@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20251029124516.221091724@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0003.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::23) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|QB1PPF8D13D38F0:EE_
X-MS-Office365-Filtering-Correlation-Id: b4652094-abad-4104-c3f0-08de17c30963
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K2RtbHpod1ZESWZ4YXRSSlVCZVV2NTJwT2pGUlp3amp2ejc0MEMwTUw2YXYw?=
 =?utf-8?B?MW1jZExFY2VuK25Sa0pBK0k1TzN1SDBVZGpKOVdkQytPUURhamM1b3h2TEoy?=
 =?utf-8?B?d2xId0gxSHFyVUVBWFhHMEREcDljbFFHVmRkTkc3ZWZxTGRVeXVsbDRDSnND?=
 =?utf-8?B?Z1QxUnpId1BWaVRoQnhnb2plWXQ5S1dQd2hmd2VoL0oxVjJGaXByU3htNkhW?=
 =?utf-8?B?UlB4d3lTUE9qdUwyQVRid1dxQXJvSURIR0NCWjY5V1N3N1c0d1h3VmxuQVMr?=
 =?utf-8?B?Znpld1A2SzJMYVJVcXFyUjJuZE05MGg3WS9zQUdsUlhYTGdaU2oySGZLRTQw?=
 =?utf-8?B?OTQ1QVlmb2ZDWm5DK0ZsZ3A1Z01GNG9hZGhmdkRPREtPbGM4d1dxaEUzdFVk?=
 =?utf-8?B?S2tqb1NVai83TFRnMEJaQmRzT0FFRlplb0lvTm9QdDFoQjFnT0VkY2hMNzNO?=
 =?utf-8?B?KzJjSVNDTkc1M1VIZndVRGcyRkM3NkZyODN3eFZRMjBMcGtTU2xUNlBsRk5x?=
 =?utf-8?B?NU1LKzZRSFZkeks5MEdwOVcyeE9EQnZGSmNMTEhKS1g5Q29kRzFsbVBrakFj?=
 =?utf-8?B?emM1a3VKblcvNCttajAyRW5uTE16WEdHZUFSKzZnY0V2RmxJZSswM2VhdTdz?=
 =?utf-8?B?OXl3Wjk4UXZDZ2xvYjcvQWlZTE83UXhLblJKSkdDWlpnU2U3YnhVQVYxN2xV?=
 =?utf-8?B?bW1jQjlvWS9sRmtsai9MWnZvalAvRmtWRlNraVVPa0Y3SnRSY2lxN08zWXZa?=
 =?utf-8?B?czgrS1ptTjVZb3VKVXVwMFZUcTFQdkJCdFBoaElDRjZVSmZhRU8wbHQzY2ht?=
 =?utf-8?B?Y2JmQkZPRmdadnVDRFdJbVFUaG8vRFFUOXlHaWhtNEdYQ3cxTkZzZmVRS2Vj?=
 =?utf-8?B?TGUvcmgvV0IzRGxHbXV3L1Z0dVM2UWNnSTY5ekc5dnJ6MXpRR3RldXpZd2lK?=
 =?utf-8?B?V1NzejVpL05jOXg2QlZBM1A2SWtvTFE1c3dJckZicFREaERHeGR0TjFYSEZJ?=
 =?utf-8?B?OXFybU8zQ2JXRWZMMjJHc0poS1N6QllEVitZYXh5RmZScWhTQm8vbHdIbGNt?=
 =?utf-8?B?TXlES25LWTd1SG1nOXhIWUFqQkJUdnFLd2FaVlNyVENBQk81bHBOa3NTMW1P?=
 =?utf-8?B?TG5yNmlraDA4amZ2TTZXaW4wdEZvMlhaTEwwMEhFek5YNDlsWUFxMG9SZ3hX?=
 =?utf-8?B?OXdjNjJnZ1Z3Zm9IL0xkUUFSY2hyQ1poUjhYRlpLdmFSMnF3VTFQc1NVU3h5?=
 =?utf-8?B?ZU4vSC9keDFCc1JmRDJmZEsvaHVjVHZnSWJtbXpwaEtsbGhoZjlnS1A5dUdL?=
 =?utf-8?B?dFRhTXAydm9ndUtQOHBsWFl2dTlqQW9PWnFPdnZ1dmVzVWh1cTNUdk9Fbkl5?=
 =?utf-8?B?ZHloMnBuZE9TamxwVHBwY3NNQStITExCcXB2NzVGVWJiR0N3REZucXRpeTNZ?=
 =?utf-8?B?NGp0VERyZHUxUmdwcy8ydXVONkU4YmE1dkZyUUp3Tk4yTU1zSVhZcHRrYVFu?=
 =?utf-8?B?bUFiNktVVUc1UzdKZDFNTU95WkE4U0daN1VIcXJ4NmdZRlF2T1ZDSjB6N05P?=
 =?utf-8?B?OEhDRXl6MmlWbXJNK2szcEg0MUprNlVwSGJFU1B1byt3bUNrcGJ0UmVQMDYr?=
 =?utf-8?B?QUU5aVVuWDVBRnEyMWMyc1RQZlZzVXFFWWhRSTM2cVRUZmpyR0p4ejhOekEy?=
 =?utf-8?B?cmdBeWxibVpYd0VwMnVicW9XSFNCK1I4ejJVT09ZRmdzeUJ0UEhNaGR4MU9y?=
 =?utf-8?B?U1JlbTFiQU5vNGpiaitvWUJ4UDg2MWI4bTNFczZ4U25yNitzbkJBOGlWTmFh?=
 =?utf-8?B?Q3F1eGtEelRFN2IyalFMaXc2WlNseGlvRDFZRFNDZUNVWXhEQjFxWEU1b0V3?=
 =?utf-8?B?dnVmYmRxc1dBYzdQWitDMm4yRkVRa3JZVW1ueGV4L1pSVEE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bVp5V0RSTWZCMk1majd1T3pVTnpGYlZXdXRIUFA2Ym8zSDUwLy9Zd1AwOWV2?=
 =?utf-8?B?MDhUbHdDL2xkaHBSa0dlalB3Z0pSd3pCK3VQR3lady9qZUtQbXJaUnRrQUR6?=
 =?utf-8?B?aFVxN1NxZFpYRlJ0d05QMjRDdUFHK0FhTWppZmE4YS9KUVdaelVsMms0QWpS?=
 =?utf-8?B?UFNzcThtL3VmZVZjVE50RGFRVGx3K3JybzBDNFVkQUlNalQreU10VVRFT3NF?=
 =?utf-8?B?cktMVmFOTG0xMkpqMWZvTXkvalV6ZS9vMHJhRC9tYStjdEY0cThnV2krbnZ4?=
 =?utf-8?B?TXJFajRqbXVqT3UwcjdMWnBsM2M5aW56R3BCKzBCREZrUkhPUlNlOUc5UUVI?=
 =?utf-8?B?ZDVObmdwZDVjT0dSenFFTEZKRHVnZHJBRVlhZ083TGFuMzdTTUxQM01hekYv?=
 =?utf-8?B?Q0J0VjRwdEhLa1BWbDhnQ3ZYV2ZZL2gwS1Fzd2tKSFJxZGcyQTVtcTN2cDVL?=
 =?utf-8?B?KzRXRUxLYjZ1L0tnRzNPZ1VoeU9rOGp3Z3lhRGMxeEpQbXY2VkJRTkptWXg0?=
 =?utf-8?B?NUt3ZXVNUDBLNTFxa2hLRGZqR3BsaWtYWkpjUGp1dkQvcmEzSTZYMkNCNjRp?=
 =?utf-8?B?bnp4Z1pUK0tlajhob3h0Z29zNGs5ZEZJdkJMRFJhNm9JU21DandLcEozSkJD?=
 =?utf-8?B?VkthT2JQQmRRQStUYnpNQ3NmRzdVN2JsNWNHRHpSSHBlTGxObEEyV1V3bi9m?=
 =?utf-8?B?aTdrSmY1YnBVZmVQbGZvNmtwUTJDQUJmc0YyVHJvR2JSeVk0WVBLSEFOOTRG?=
 =?utf-8?B?eGZNU1pLME5Fd2pEbVhyRXAwL3laS1dWcGtyUE1ncnorZzBQMTBtTlJkNFB5?=
 =?utf-8?B?U1lsYUlyVmF2Y2dZVHFoQnEyVnJraFliTlVyOEx4eDJwbmMxUW03YmlXaTZP?=
 =?utf-8?B?ZzZIVHNCZkI2OHloRU1WZDRrTmM5aUtqeEdFdURDRWc4K1RCSTdHOU9HaGVv?=
 =?utf-8?B?cUxsUHBOYkhnTk9Bc3Z1UmNveEJtWWJueVA2Kzk5a1k5SDh0M2paOHQxNVFH?=
 =?utf-8?B?QUZsZ1dkTTNsUUYrWWw2cXJPV3p5UzVFamFSeEhGUmsvTUR5YmROT1NRWWZ5?=
 =?utf-8?B?ZHNiR095aUxYR0hlWEVLVnpjZ3BTM1VlM3NleE1LQVB1Wjg0NW8yZWFiWm9r?=
 =?utf-8?B?UWltYjNqcFNoaUVTY09FN2wwL2ZweWkrZjlzR2h0YUozcWRhY2R0QnZDWHJ4?=
 =?utf-8?B?Q1gzc2tjU2FpTjhlNHFMS1NXMFBycmxZVFJnVmFmekZ1eGpTcXJGUWV3S2pK?=
 =?utf-8?B?bDY4V1Y2M2V4VjJ4cEpSRjhqUjZVUldsa0I0Q1MwZUlDQkIyS3B5cE1hbVJV?=
 =?utf-8?B?Wis5aER1OTBQbThsUS9rY3cwKys5VDRDTnpPM0tPZFp6c1pDRU5FQkw1UXpW?=
 =?utf-8?B?K0Fwd1RUVVJhSGlBMXNiVTdteUJiVk1pclNta2FnbWRIL3k1dHFsVGhSWlVD?=
 =?utf-8?B?T2JQeXZyTGdFNzFudG9qN0RSa2t2ejQ3Yk1GK3VneTIybjFOdmN0QUE5WG8y?=
 =?utf-8?B?SWhiVk5Fdk12YmlSTFU1OHZMem9BSDhBTDI1aks2bE5DSld3T2ZWWVVWVWdR?=
 =?utf-8?B?cUJlNGNsMmN1VHpoM2hjRDlwWEFmTWMzbzFSWWlOMTVOUTQrejV0dktHZzdX?=
 =?utf-8?B?YkI1dGkwL1lVRG9VNVRSN1pzNDlmdGY3NCs0RHdDR0R1SDJtV0VISGhHVUQx?=
 =?utf-8?B?UzFzMkpFRW5HK1FrSDd3VDBYR3lzVzdPTDg5ZWdMRENoNzc5UUhRSlZWeHIx?=
 =?utf-8?B?MEpCelhTSlVEWHJodjd4V3Q0eUlzajNuMCtNNTBXaHRCS0hIRVMyQVFCZkla?=
 =?utf-8?B?VkFOMVowSGVNa1d0ZjRCKy9LaWlzQ2tyblBYcmFUQnppUUNJZHIzR0pxUTkr?=
 =?utf-8?B?czQ2NTJON2ViRUJsTXJJZEVpcG1zeUx3ZEFxMkZBaHI4VFhOZS90OFpNNnRL?=
 =?utf-8?B?QXI5TjdheWZReFdURHJoQk9aZnVYTXMzSG41NUxESDRQV2VpcjJkTnlXbmR1?=
 =?utf-8?B?cE5UdFZpVlRncTlQelZzeHloWjgwUGNvWSs2aCs3SlE1d290WXFsdjQxMlNj?=
 =?utf-8?B?aFVubGgrbGhUOVhDcUZWdE9SVmFIbUZVbGV6YVFyVjUyYmVkMXdPb1IxaFpx?=
 =?utf-8?B?eDRzKzhYQlpuYkdkR0Q2RFZXRmZubVJPRk5VQVQ0Rkc5cWJjT0UwSVJheFRY?=
 =?utf-8?Q?Xy4SqfCJq3M37I8y5ic0nRA=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4652094-abad-4104-c3f0-08de17c30963
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 14:45:57.8240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LEEwJU+eYTHKvSnkRl43/FtFCSyODFZSKzEt/AOpHUs0lZTQs8Xhf3ZDBw7tqDWWO6TUp9ferbQnUAMseGLhwAJmEprtC2CSkKSFTjbZW0A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: QB1PPF8D13D38F0

On 2025-10-29 09:09, Thomas Gleixner wrote:

Subject typo:

infrastrcuture -> infrastructure

> The MM CID management has two fundamental requirements:
> 
>    1) It has to guarantee that at no given point in time the same CID is
>       used by concurrent tasks in userspace.
> 
>    2) The CID space must not exceed the number of possible CPUs in a
>       system. While most allocators (glibc, tcmalloc, jemalloc) do not
>       care about that, there seems to be at least some LTTng library
>       depending on it.

About (2), it's not at the moment specifically about LTTng. The librseq project
depends on this limit within its per-cpu allocator:

https://git.kernel.org/pub/scm/libs/librseq/librseq.git/tree/src/rseq-mempool.c#n970

librseq is not used by LTTng right now. It is a library that was initially sitting
in the rseq kernel selftests, and I'm planning to eventually remove the code
duplication and have the rseq selftests just depend on librseq.

We are discussing with the BIND9 name server developers and they are interested
to start using the librseq per-cpu allocator within their project as well.

The LTTng userspace tracer will only be able to use the concept of "concurrency ID"
when/if we implement support for a "per-ipc-namespace concurrency id domain". We
basically need to have per-CID indexing of a per-cpu data structure over a shared
memory mapping shared across many processes within a namespace (IPC namespace seems
like a plausible candidate for this). So we'd have two "concurrency id" fields in
struct rseq: mm_cid (per-process CID), and ipc_ns_cid (per-namespace CID).

> milliseconds later when the next task changes it's affinity.

it's -> its

> penalazing everyone else.

penalize

> That allows to check for ownership trivialy and provides a simple check for

trivially

> + * MM_CID_ONCPU bit set. During transitioning from CPU to task ownership

transitioning -> transition

> + * actualy handed over to user space in the RSEQ memory.

actually

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

