Return-Path: <linux-kernel+bounces-807174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE46AB4A139
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 07:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A86B4445813
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 05:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27512F3C30;
	Tue,  9 Sep 2025 05:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="K0Lr2Km5"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2101.outbound.protection.outlook.com [40.107.94.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9071D63F7;
	Tue,  9 Sep 2025 05:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757395596; cv=fail; b=NClvnQMN9AMbhZv+hUBgihFeNYdxmLJNCEyfoEwJIkMyg/8ZNu3+7ip6yuEbXmwobDgQHQUPhosgCcGBL4kS/bx9X9yS9pMq+1QADA4FI51Kpe7y5l1En0dB6qEhdStO69RAK7mhAsLhRR0t3ycehqmAWzXslzdQjXNg7u08UDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757395596; c=relaxed/simple;
	bh=p2GGWXlANdXhcL+FtM8nAE/3kGgflnFoEVggu+Rj8ns=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ra3r1ZWG9zO4BC4g+rbHunvND07KnJqJj/sFxCH/bPpQI0dwEpZ5sRKV6pW2ympDbv42svqaq+mE2F9qODYRDU2qE2a62wli5HwqpQJP1u8hLhmHutiJAhUvzYt4ZgstTxx4slJwwOYjIA6HHnzlIwM3L2snLXHf3f9a68fFaTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=K0Lr2Km5 reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.94.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=anGTU7aCFQbAln3XxL42wYV1m74AZQnDdWBluO+yajaBtyxADw02oZxvD7l+dR7GMSiUyquzp1PgKO2jXOKX32wmq09n6cuo0fENzs6gtBaiW7LkPBhqOJwFG3KkTTXplKy/LOiVepfKWgBi3W3YGCduaEA9w+Hn1VCDkyr6JexqAbrpdqx4o1AAbe/hgxiHjGpu/0C6igE0MBr4BAuF5k7xb/jxiwiSZkdDtkeLGJ796IxkAAGNYW5fUSdqiC108gMhzJeYQCKhttxGawi3Tff7S0u0cLYWXN2VUN++59YOeoMXz25WCeNzcmPNprFRjdLPjxn98PqmcNVq+gPKgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d+vGum7V0Og0IH7RaEsWoemY5haN0Y9h0LacfPqMnqo=;
 b=dQhuG9z9wtP2J3yRdezz9WThovHMm8GMe12mwqGFEUaG/a13V7OfZGVMf5iSt62UombbFAXrxIpw0PITjlKczF9lmotaV9dN9FPzSL4fvU10tHaZN7/saIsiR4V4zjb31ht/00/4m1QBDcvjGHekKQrWtA8S17jVlr8b4VmlPa5bRv3GQDLlXcVQ/TRb4CHsPu8v0FkT+kVrYIgLb8yBk/1TCiBU5GwsBQzptYR1GA2AVpWqDvE16hyXYdAH931zjkXmwMiwWu/QEbP65hM4dvCQUQBypzSgJJbE98itw+EGkDzZgWx9GPC2cg/beE6lnx7hqLMxJs4zT697/3QWFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d+vGum7V0Og0IH7RaEsWoemY5haN0Y9h0LacfPqMnqo=;
 b=K0Lr2Km5vT467AeGmKzCOeAMRauucdhNrczugokJqnaiYemPzqC7yKlraCIg+rFDeLjJBdRQQkc8iWHjzNJ2Kh4g6QsuWiOVnur6Z+QtYaI9ECvfgum1oEkUUzxfEvDe8Xp/FaEtLVkZ6Osuyg+6NVAw35kzwFhRmN3aGiatvhQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 PH0PR01MB6502.prod.exchangelabs.com (2603:10b6:510:18::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Tue, 9 Sep 2025 05:26:31 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050]) by PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050%4]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 05:26:31 +0000
Message-ID: <a18f3b2a-0869-436b-ab20-41a92f1f468a@amperemail.onmicrosoft.com>
Date: Tue, 9 Sep 2025 13:26:10 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/2] arm64: refactor the rodata=xxx
Content-Language: en-GB
To: Anshuman Khandual <anshuman.khandual@arm.com>,
 Huang Shijie <shijie@os.amperecomputing.com>, catalin.marinas@arm.com,
 will@kernel.org
Cc: patches@amperecomputing.com, cl@linux.com,
 Shubhang@os.amperecomputing.com, corbet@lwn.net, paulmck@kernel.org,
 akpm@linux-foundation.org, rostedt@goodmis.org, Neeraj.Upadhyay@amd.com,
 bp@alien8.de, ardb@kernel.org, suzuki.poulose@arm.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, rdunlap@infradead.org
References: <20250909033236.4099-1-shijie@os.amperecomputing.com>
 <20250909033236.4099-2-shijie@os.amperecomputing.com>
 <bc0ae013-2314-4513-a759-cbf2b922aa6a@arm.com>
From: Shijie Huang <shijie@amperemail.onmicrosoft.com>
In-Reply-To: <bc0ae013-2314-4513-a759-cbf2b922aa6a@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:196::12) To PH0PR01MB7975.prod.exchangelabs.com
 (2603:10b6:510:26d::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|PH0PR01MB6502:EE_
X-MS-Office365-Filtering-Correlation-Id: d5302aa7-520b-42d0-5ad8-08ddef616f3b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YjVoaWJWNnNHeUJTOHVHdlE2WGlCMTl2ZFlUMGpvN2tCZ1drNExvQzJNTkhE?=
 =?utf-8?B?SXYrR1ZEU05iTXdEZjJVL1JUTjNSemNhclM5NVFrSmp6V2xubmRJVExJbXJG?=
 =?utf-8?B?c2hnQkRYUzVPS2oyL0dhcHlUT0FjNFdPbzdvMGVGbjB2SXVVNFBxYmFIRW1v?=
 =?utf-8?B?QkhyR3ZtRXdoRlppTW1rcFkvMWVPUGZpTW15TmRUeTZPa3IxK2EvUmpmbGZY?=
 =?utf-8?B?dVd5RGtUVlAwM2V0Y3EvQjd1TjJGakc0WVM3WVh5ZTBGWGY1ZjhYcWhjcDNv?=
 =?utf-8?B?TVBCaWF0TGw5N1Q2bkQxNXMwd0Y4M0tuYndVbEduU25XLy9xUWF6aU5XZ3FV?=
 =?utf-8?B?U25PRDhqNzJqOEdVbUtmeVFWa0FHempFZm0wUEcwMnJpUG5TM2ErM2R6WU9K?=
 =?utf-8?B?NnJ5MlkrYWdUeXp0dGtvaUQwdzYxbXJDWDQrakIwdlY1NEN0VXFKRXNyYmRP?=
 =?utf-8?B?bmhjVUpQczU5TmhHdDEyQlJkZXY4am5kaUJMd0RjUkNId2FXa1E1VUQ5SEhO?=
 =?utf-8?B?SUQvSGNJWE1EMW9VWDFKZEhnTXNncFRJL2x4bC9FZ3M5WW91MFRBMHpWaDRn?=
 =?utf-8?B?aDJnM2VqRkZCcXYwTUo0YURmejd0NXA2RWtMek9XeU5EQmlyYkpXRTJzNU5E?=
 =?utf-8?B?dG9UY0pQZE9SeGhrbW1LaUpIY1B3d2dBRWNJcGNNTVpqUnpLVnZiUG1WNC93?=
 =?utf-8?B?N0tidTZ2cStWQWVDMzhIVGE0TExGOGhTekZMUUFLTGdVanM0dDYyeUtZL2Rz?=
 =?utf-8?B?Q3Y3MjIrZ2RTT2NuWHE4RWxjOGFYVzRYMEZjZ0NoQWp6VnNuY3c3azlIS1Mw?=
 =?utf-8?B?MW9EMHlhbEttMDU5TTc0cjZHN3lYQ0FoSlZNVjNtYTBvOGI4NEJaVnJmbVRW?=
 =?utf-8?B?YWJ4aXk0YVMwdzFXYUhYYU1XZzY3Tzg0cnY4aFluZkNRcm1tZGlOczQyWmQ5?=
 =?utf-8?B?UXFuTGRXYnJyUGlMNVdISjVaYnJlR0doSWpzOCtBTDZiZmVacnR3djdFbm1P?=
 =?utf-8?B?WEM3K2hQRmp0amRQYVovWEtWa0VjcjRLT0t6bVFYRkdRTXBnV0IzUW5keGo1?=
 =?utf-8?B?N3VHb212aWl1cDRZckt2MiswRVQ1SUM3T3hpQ1FwZ2JMaGkrQ3dXOFdYc01V?=
 =?utf-8?B?WmNRWWlGOUJicUNkVGpFT2lZMGtrR1daNVZPa21JVWxXRGhnMGRqTVErQXpu?=
 =?utf-8?B?QWF4dzhhdEo4bzBWL0hPUXU3cFNkVUo4WXhNdmwrNlVpT2g1aXdQd0FhUExt?=
 =?utf-8?B?akZKd0lSaG9UdkUzK08rczdsUjZrRkVwb2xQWkxJTytUMEhsK1Y1aldwWDJL?=
 =?utf-8?B?Sk9ob2xybWNHU0ZzNVZiNlVvYWlKb242amtXd0hZUXJack9UeWJaTzJmeXYv?=
 =?utf-8?B?OTRNSE1vY0VZVmlOVVNTSUgySC82aWl2N3YxcVE1d1lBakVrUG9ZamxkdHZW?=
 =?utf-8?B?ck5Kb1JjQkJpN3pIUUEwMVpEU21vZ2RaQUJkWVp2bnBLUzVudU94NCtLeW5Q?=
 =?utf-8?B?TGNjZWVYb3QxYm8xZ1VXSkdNTUVOMVEzN1dBbWtLQWxPREpGdTFCL1JrYVl0?=
 =?utf-8?B?d3hkMXZZZHo3THJLUEdIQStDUXAzRFcwcFA5NG91OERTZ1laL055cm12Qkh5?=
 =?utf-8?B?UWM3cFZLTmlRMkdyVVpmU3lsYmg2VUVzc1R3cnYxeFduL0NIbWZOM1ovcXY0?=
 =?utf-8?B?YjduY0xQN2NaeFkra3haVUFOZG1IS3ZWZmFVOGcrYm5abExXWnpOZkZacG9M?=
 =?utf-8?B?TmJDSWNmMG1JVDlJSW11YkR2N2kwWWQweDVYcmVpUTFLb040SytMWjNTcDhH?=
 =?utf-8?B?eU9RM1RDbUpZT256YXo1bmlmTEpSTm1ya0FvR0dpMXpkblpQUlFERzMyMGVa?=
 =?utf-8?B?bzZXSjh3UmFTREdTdXdTOFJVbVhjbkhGeEtJV3phTU9YTHJoU2VFTUpBUVpa?=
 =?utf-8?Q?U+SpAyGitts=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TlN4dmkwa1hURTFTWWVBYzZieVpWeWM1d0tRK0hkVW1jeW5HeS8wREd3Vktr?=
 =?utf-8?B?LzlRcTB1U1NRNGtLZmhQa04wM28rRS9rby9kb3Yvd2d4akhXTEN0a25wZDBB?=
 =?utf-8?B?ZE14TmFySVNPL2paTFJxWW5sSlc3Mi8xMW43b2ltZExsVm8zdVMwWU80OXZF?=
 =?utf-8?B?YnROS3YvVldEcS9iMWRaRzRobGNScUt5TTNrVFltbGFsd096ajQ4KzVvMFFY?=
 =?utf-8?B?c25XYkY3ZnpkaDJZWkNjcmFqaGFEUEVtVEVmSCt0Z1M1OXlOSndxREgrN0lY?=
 =?utf-8?B?bERtcXFSa0NyMElTNm5adWNJOTVIVzMySUtBbHh4RzM3eEdNODJUbkRYK1JV?=
 =?utf-8?B?UENSTmUxMW9NUzBMN1IxMnpiMitGZFJ0NmFnM2x2c1Fnd3p2YmhIWTg3eG1k?=
 =?utf-8?B?SkNyMksvZmJkc3pQVmdYUFcwSGh4Njd6S2o5ZjF1c01palFvVTVJWFRLQlBZ?=
 =?utf-8?B?RE9lRlVjQmk0MWR0RmxTdS9US0hnVFZ1N2lHMWVhQmVsUks2TFBvVHRIcUcw?=
 =?utf-8?B?OVNVUko0NlVXWkQ4VzlpSnFTN1FFVVN3S0JUa1lPLzVqUUlzKyt2Yy9jN0J6?=
 =?utf-8?B?MVJXRk1aUVNRWGFlcy8xTmJQSDNwQ0ZYVGYvbW92cm1jSzhDMU1TMWFiUnNX?=
 =?utf-8?B?UnNyaG5BKzNLeGxjUzhON3dtNTdZbWtQd1lnTW9jQ1NCUUE2M0FTUytuQmFT?=
 =?utf-8?B?TDV5ZTc0MnBVQVc3c0U0UmdaYTdRL24vd0tETHQ0MXREYVlzTG5YdUEyQmR0?=
 =?utf-8?B?TitJRGdJVEdaekN2NXlyNWpZVzdSTlJrSmY2TDlwektRR1hKYW82NFQ1OWtV?=
 =?utf-8?B?TlR6RFZadzRDNURqMXlrTWh5WlF5MzN5eUpIbVZGazBZYWxYOFhtdTl6aThh?=
 =?utf-8?B?YmhuQzZnbDlYdldnTzJsSk04QUkxOTE4aytBZnQwNVJZdi81V3pPQXQ4S1pP?=
 =?utf-8?B?eVNJeTI2Qmp5MitKSzQyS1NNY3U2L3Q3S0RvWW9pbVVLc1NyWG51M2RUV21y?=
 =?utf-8?B?U0huT1doSHJZeXRxZVBHdSt5bnY1ME5WbHBYczI3MFpZdE5VSmZqRS92N2NV?=
 =?utf-8?B?RmJoSkZaNmcySUFhcDZyRUZ5QnFQWEpNQ2gxdjJSN1JJUkZnYXpFV21sVUtz?=
 =?utf-8?B?UmdRYzBsWk5HNGVleDZoNm9ldEk3TnUxbjRoZWpkelFsOWN6dnAxVUNSV2RT?=
 =?utf-8?B?cFhjZ3hUSGlqZXZMQzM5eTBDbzBTd21TQ2s5dXVIN2E5SjdDR293MGNISjY1?=
 =?utf-8?B?d0I4MlJ1NDNZTS9yOTV5ZXZab29QRG5LMzBudkdkeGtFOGQ3RWtGdTRvUnlX?=
 =?utf-8?B?ZE1vMEFPT3RaVTJSWWRSZ3cwbFlDZzFVN0VkL1lLTER6Y0JzdnQrRHNyMUN4?=
 =?utf-8?B?VnM2bkl5cmlvZ25aSmI0RnkwVlpaaDBJRDZ1UHhSNU5aZktWU2NoekJrdSts?=
 =?utf-8?B?bE52RjV5NzZNQTBSWU5IYmRtUkpodTFGV3FMQ0M4K0w4dWcxNk1ISVVDdGdq?=
 =?utf-8?B?V2M0b3NiYnZOUmJBYjh0WVlPb2pXNFlUM3hTczU0RGhwZXN6UXcxWXBhN3hY?=
 =?utf-8?B?dFQ0WURYcXQ3a2VTcHlGaHRUTUpsNG00eFJRMlEyL0UwUWV1NUFhK2o5L3NR?=
 =?utf-8?B?dDNzMTJOR0E1cDdJYVBSckF2RWlGSE1FMDIxWDdBeVl4TjQ0YmJreU9KVldM?=
 =?utf-8?B?dTVKRExOUS9TL0tCVkl2bUNzaXYvUlJyWEYwSmxLRWhFcXh5MGh2TEpFY3Vt?=
 =?utf-8?B?MlZPM3NRRE1Ld3lxS1M0ZytMZ0xJRGZDMVJsV0E4Slh1TTk3cnFmNFNrTzY5?=
 =?utf-8?B?VklTM2RodjVIUmsyRC9ud2tseTJta0pWRzZ0b3F2UUR2bjZlRUNTNEh5dWNE?=
 =?utf-8?B?dVNzUFhjRDdzQjNCUlNYc3dkUU1vbEowZEJOeTJ0NFVHVGVSQXFDVUtXNHZF?=
 =?utf-8?B?c09WaHYySE9zbzZyRkVwMjJTeFgwMTZzN1VYQlZNb3JxbXBxS3BhRkYrc0Jh?=
 =?utf-8?B?VUdwWUZ1NFJoUWRaT2FCK0VaMVp0aFduYm1nS0l0cEllMWU1Z1dGYStiTUwz?=
 =?utf-8?B?cWFkajNtYjlkMko5K2pxaWQzTytPMDFqWkhzOVhRNFQxblF2ZHZ6SENQZ29v?=
 =?utf-8?B?SlJoUzZNcllsVlJzVXdxZ2tYZFFFZ1FZUjFXVlVxOTNZdkhQL3Evb2FLTHd0?=
 =?utf-8?Q?UBF+UHoJkQHKbgf9TbKtddQ=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5302aa7-520b-42d0-5ad8-08ddef616f3b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 05:26:31.6654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3sH0DywsMRnl8HdgLHKBq4i3rBZuZeF99w85txnNVq5jcqGF/k9rZKM0qYG/3pMjQBYFesSWJ0oHYh2PehXMdlqs8LXLCfn0pJXUxVWaoIT1dRj35PwK5Eg2pC1j/cW2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6502


On 09/09/2025 12:29, Anshuman Khandual wrote:
> On 09/09/25 9:02 AM, Huang Shijie wrote:
>> As per admin guide documentation, "rodata=on" should be the default on
>> platforms. Documentation/admin-guide/kernel-parameters.txt describes
>> these options as
>>
>>     rodata=         [KNL,EARLY]
>>             on      Mark read-only kernel memory as read-only (default).
>>             off     Leave read-only kernel memory writable for debugging.
>>             full    Mark read-only kernel memory and aliases as read-only
>>                     [arm64]
>>
>> But on arm64 platform, RODATA_FULL_DEFAULT_ENABLED is enabled by default,
>> so "rodata=full" is the default instead.
>>
>> This patch implements the following changes:
>>   - Make "rodata=on" behaviour same as the original "rodata=full".
>>     This keeps align with the x86.
>>   - Make "rodata=noalias" (new) behaviour same as the original "rodata=on"
>>   - Drop the original "rodata=full"
>>
>> After this patch, the "rodata=on" will be the default on arm64 platform
>> as well.
>>
>> Different rodata options may have different performance, so record more
>> detail information here:
>>
>>   rodata=on (default)
>>      This applies read-only attributes to VM areas and to the linear
>>      alias of the backing pages as well. This prevents code or read-
>>      only data from being modified (inadvertently or intentionally),
>>      via another mapping for the same memory page.
>>
>>      But this might cause linear map region to be mapped down to base
>>      pages, which may adversely affect performance in some cases.
>>
>>   rodata=off
>>      This provides more block mappings and contiguous hints for linear
>>      map region which would minimize TLB footprint. This also leaves
>>      read-only kernel memory writable for debugging.
>>
>>   rodata=noalias
>>      This provides more block mappings and contiguous hints for linear
>>      map region which would minimize TLB footprint. This leaves the linear
>>      alias of read-only mappings in the vmalloc space writeable, making
> 						typo     ^^^^^^^^
What's the typo? It seems "writeable" is okay.
>>      them susceptible to inadvertent modification by software.
>>
>> Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
>> ---
>>   Documentation/admin-guide/kernel-parameters.txt | 5 +++--
>>   arch/arm64/include/asm/setup.h                  | 4 ++--
>>   2 files changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index db84a629f7b1..138e0db5af64 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -6418,8 +6418,9 @@
>>   	rodata=		[KNL,EARLY]
>>   		on	Mark read-only kernel memory as read-only (default).
>>   		off	Leave read-only kernel memory writable for debugging.
>> -		full	Mark read-only kernel memory and aliases as read-only
>> -		        [arm64]
>> +		noalias	Mark read-only kernel memory as read-only but retain
>> +			writable aliases in the direct map for regions outside
>> +			of the kernel image. [arm64]
> Should not the arm64 specific performance implications be mentioned
> in the above documentation update as well ? But in case this appears
> too much platform specific - probably do consider adding them above
> or inside arch_parse_debug_rodata() as an in-code documentation.

Will had already suggested do not add them for the 
arch_parse_debug_rodata():

https://lists.infradead.org/pipermail/linux-arm-kernel/2025-September/1060135.html



Thanks

Huang Shijie


