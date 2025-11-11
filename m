Return-Path: <linux-kernel+bounces-895734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA99C4ECA3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3361218994CE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 15:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13034359FB8;
	Tue, 11 Nov 2025 15:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3SjAmKk1"
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012041.outbound.protection.outlook.com [52.101.53.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCAA303C8D
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 15:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762874997; cv=fail; b=eeZ48pbu+GpLYfi/IYfJSKVIPCEbnDKL2ATIg2BJ9thcQcY0f5ibUlQQMiBxbD++MqfeTTRGJPZzeDNLROuWF7pQurlOTKd+rqi1AaLrFBn1ykJkw+ho3J+EyRbP80QvN+2wmplWs7gdaPe+YNJ2p4beK9uqndjwPwR9cG7GPgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762874997; c=relaxed/simple;
	bh=tOotngn4fignWqptGrNeXGvThR/Re2oigrxNrwFogLU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ezUCejT0paoWFIv8Vesp0vNTWw+s3bA3X0Rw3lR4Z7z2sytGeCfLOJlYee4+Y3J7rCKN5bj54xDEdlMmGmyDcQwj9BMhTXhPGCtwgSiXDS8/UQu9bw6AqEiMnx2ktxKLL1deRzoUI7ghApHFMQqiBR5aVobP1z6NvwGg91AeJqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3SjAmKk1; arc=fail smtp.client-ip=52.101.53.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ImTD1PtD42jJlswmH1VNhnPewvpy2o49hGqM5TJOJv3OFzhL6kxUmZSBJOLJ9Sfs5zpmVq8YppYvE4DoxQAipFjoypUC7bgaeJPm0DMXtDfFlqvRSF/a625iA3/QxzHCmRvuD2LsdHDFi5ZUCGpHflk5CMVyRInNmUNWkr2atJ6DrxEU4IOrC79kTFNKgfzUWONIvdxQALk2zllCa6hJxTjSq4WV9bcABJnx7aN93phu5qpTa+YKn9kcRDI3qvvEQKrYkT8VvA8W+J0ZewqkO2g/1+UE9SzppMt7D71p9vf4uJCdRLzTG42wYNyeMDvdfaBgm1hdBh+tbMuhaQKdVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iv2z5VpIjxKYpAYioKRb35KNj2EnDvsJuqVw8R2YaZU=;
 b=KxWhGb8GSS7bktk7f1wLn/7WYyp88+bKPXYFWEveh83mcIybRxgwSnrTvSZwSdFMJejzIjoDSpu4U1gfpDd9QEEIHaepFn+Iqi//Huqb59o9D491TOtGGcToLOC9Q8SXdN0p40lAZMQbQSR2McdCSPNIBfWOyew9gMS+bekaDoS7AbixmuMrCxZSrPUGIDwOXJdDhSUgvKhaEKAg67JeGbGgZM2qrj1uqItiNT1tBp1s7N3xpiy4zkbmPcUDFshQm366QyXlXsry+0CFhK5Gf0f9Whl2hFGnNRgXY0Y2gzpwnZfY4mqynAV/hPkom2BGXOUCFE8rRngrHyaUFw+Ywg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iv2z5VpIjxKYpAYioKRb35KNj2EnDvsJuqVw8R2YaZU=;
 b=3SjAmKk1IqqsHFVSRm7Y3NHCq07OSNvqH0QhzTSss22NtLnhTx6hT4JfgXvq/Kp8TW0Bx1+c6uozGlYHuU/JzrHYerOah+6Y3QupkOAhxE1w9YMApH4RYBjUN9wyLTgLVVfhFv/BbHurAAAP/n8+qRY+85t3pXa2xaBG7sDN1yM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by SA3PR12MB9107.namprd12.prod.outlook.com
 (2603:10b6:806:381::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Tue, 11 Nov
 2025 15:29:51 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::8d61:56ca:a8ea:b2eb]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::8d61:56ca:a8ea:b2eb%8]) with mapi id 15.20.9320.013; Tue, 11 Nov 2025
 15:29:51 +0000
Message-ID: <7e264e18-23f4-4566-86f2-f0600a243227@amd.com>
Date: Tue, 11 Nov 2025 09:29:49 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] x86/resctrl: Add io_alloc_min_cbm_all interface for
 CBM reset
To: Aaron Tomlin <atomlin@atomlin.com>, "Luck, Tony" <tony.luck@intel.com>
Cc: "Chatre, Reinette" <reinette.chatre@intel.com>,
 "Dave.Martin@arm.com" <Dave.Martin@arm.com>,
 "james.morse@arm.com" <james.morse@arm.com>,
 "babu.moger@amd.com" <babu.moger@amd.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20251107012401.224515-2-atomlin@atomlin.com>
 <2a0b270a-e398-4d88-aa10-421f2769a759@amd.com>
 <53iuqiul6uo7zj6sfckm2h465cjusaxvpxrtdmnbmhvbzuqiq6@7ogm3zqddzjd>
 <fa2c3cbc-2af6-4d98-bd70-8ab49cb0d83e@amd.com>
 <4whfbgq336xfuov4i4nwwrn35ywwlwizuvpdlstmdqzkhvwrq6@eits26xbwyz6>
 <bcc8e6d2-8e91-4e91-9dab-f1c00f99c408@amd.com>
 <knqdzael7yihvznsdzijztawviex2n3i5pqbzslmk3rolnacrh@h3cwjthvyeuz>
 <SJ1PR11MB6083F15A9FCB09AEC3A46827FCCFA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <937022c8-82cb-4f4c-a2a3-ceaf99580cc6@intel.com>
 <SJ1PR11MB60833A27A1B8057CDDFB1B2BFCCFA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <w6thhucyyfnveawixyub2yugsb3s2goiocqtene7s56csrgtfz@x4zll7p6tyla>
Content-Language: en-US
From: Babu Moger <bmoger@amd.com>
In-Reply-To: <w6thhucyyfnveawixyub2yugsb3s2goiocqtene7s56csrgtfz@x4zll7p6tyla>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0170.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::26) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|SA3PR12MB9107:EE_
X-MS-Office365-Filtering-Correlation-Id: aaf66122-917c-4344-a3ba-08de21372839
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UEZWb01xbVVaVUFEUTUxWVpqZzVDSTlTUUhBZVJOWGhjSFpyRkw0UWV3K2ZL?=
 =?utf-8?B?b1NHVnhoMkJyemsyYkxzMmI3WXoyT3doaW9LenMxTVhBb0NyWU5GNWk0SEx5?=
 =?utf-8?B?R3FCekFhNUFkdWdUdisvWm1rbm84L0VZNXVjbVJ1Qzl1QzBNU1FJd0NadXhz?=
 =?utf-8?B?ZnEvVVRHL05MN0F1SEgya1E2dmRiWGlRbUM1dUV3NFhlRU1kSDRWQ0QrNGVI?=
 =?utf-8?B?ZjFMTUZ5QjlBbzJCSlRIeW42eXZFOEFoYW5hdUgxaVdDY3g3MTEycGZZOTVs?=
 =?utf-8?B?MzNxa0xRTFRQT05OQzBmeW9jZDYrK2hKc3pYQTdSL1drVzNwbG1Hd2xKY2xn?=
 =?utf-8?B?WDh3dnkzWVZjZnl1ZTVqaGF2SlozclREM2ErWWpMT0xVNjVleHQ2bUhQaEpM?=
 =?utf-8?B?alpBbnZHdVVUNUVESnBTWjNVVXNmUTlrK0lpTWlDQ3RSTkxNYWRpTXlpVWty?=
 =?utf-8?B?R1B1UVhqWkhOQ3hjeFo2UTlrNldjUWZaRFdjOHA5Z3dwRTZnci81RzJncmxo?=
 =?utf-8?B?MXNYWnlVMWFIWXpTOXJmYTVXM2JZNGRVK0F4ZWljUnNiWkhjQW5FSWRHd2Vr?=
 =?utf-8?B?Uk11WmRlei83d2NnMGorRVZSVDdzWXJ5Q3ZtZldadlR4L0lyMGs2SGhQVWlh?=
 =?utf-8?B?ZU1DZWRSTThwZmxxaGYyYzdPWnl5TnlwbWNSclNmbVZXVGhnMWR6VXl1MXNy?=
 =?utf-8?B?andBb01ZNC9OaVhRajdzc3BFLzhFQzd2Sjc1RzhTUllLbjl2L1Vab3RyK1pW?=
 =?utf-8?B?Q0lGRytlRzJFNy9oWm80ZC90UlpyZ29KbStIUlBrcHpZMGRYVThiSUEwemc4?=
 =?utf-8?B?aHZiZWZXT21RUDdMQS9Qakd0RkgyNCtJOU82czVvTVl4S29ZMDJJRjZPUWEr?=
 =?utf-8?B?VzMzbTI2ZnpRS2RHQU1WZis3R3JFTmpYdmpsNVk2SzNLSjNLMTViVFhqRDhr?=
 =?utf-8?B?TFQ0T1NWbm9RWFBYejFWbUJoU1l6Yk14eG9INmdyRFF6ODU0MUwybjIzejFa?=
 =?utf-8?B?eXIzU3Fla3FqNnRrODB5dGdkMEFVMkM2YzBNTUQ2NkpZb0NXbUMySzBBSXBT?=
 =?utf-8?B?K2R5TmFxNXBWajIrWlVqSG9tL3ZBM05RZmh4KzVuOTVTM1cxdk5RNEdFM0NS?=
 =?utf-8?B?Wkt2T2NyM0ZaUSs1V09CS0o2U1lLb0NPdjZISE1XcklucTUrWjcwOU9qMHZy?=
 =?utf-8?B?bTJrVC8yTXUrWm1TMTZ4VTJ4V1hpL3ZQaWFJQi92Z0Yvb2pLSFV1T094U2VN?=
 =?utf-8?B?M2F2d2FTWkt1dThFTkFTL0lQN3pyeVc0d0EwcEY3WVRISk1TVzQ1VnNEcEQr?=
 =?utf-8?B?ZEllZUc2cEdRdlpoUkFjWFpWVWRDTlRJSHZYd09yVitNSG1WWjZZNU5HVjVQ?=
 =?utf-8?B?RHBad3JQbW9SVjlMS24rdis4UDN4K2JWcjVNVFB0R0pGcDdWUFhRbGRNejY5?=
 =?utf-8?B?bnZLWE1QQTFSYjF3QmRIQjZNWWFUMnNQMFFlSTJzQm1qbkx5SzNTbTZxeUN2?=
 =?utf-8?B?MjhJWFpTYmpQNExPN3RLUHdObXN3QnpkL3FEbVp0MEx1Vmp6dUkybVBQaUtV?=
 =?utf-8?B?S1cwakVjQ0hLeWcvZmU1SnBCeGI0K2NsMUtVUkFreGM3MUpsT00vRDJucDNz?=
 =?utf-8?B?RHBybVFEazBXdnpXbm1zVlJtQVV1d2RCSW1NMllHYml5QTdyMzRIWUcraUlq?=
 =?utf-8?B?RUtIT0pSMXpJNStXUFF5TWc0WXR6QXdtZWpHVHJWM2FiSk4zb3V0bkxsNUlN?=
 =?utf-8?B?M0lzYzcxYnNYMXpvK2lZWEcrRzFoVmUrbG1pK2dvRWxYem1RNzhyUnNHYzM2?=
 =?utf-8?B?ZUlnRmV2cDZWNWJLQUZ0Wms3NmlSb3ROa05HOSttazE2Y21FRXFvSnVJL2hB?=
 =?utf-8?B?WFM2dm56ckNqOXBFanlWZXByOWpuVXIvWFROWHdXM0FqQjh6ZkxSSTZrNnBh?=
 =?utf-8?Q?S+m9AJtt09NzJ55DIxX1Ika2AdWhSLL5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L0tQK1pzamNBMlhDYjMvcjBpNHc3Wmt1aTVOUHVRc3NZckh6ZE9oakhoejlT?=
 =?utf-8?B?ZlF6Um9UOVRpRDl2YUdtUWVqV0I3cm04VGlVL2dEeUF4SkpBQ0Rza2xtRTJI?=
 =?utf-8?B?SWpvVTlkOS8zMGkvNDNqTVFrZzY4THNmTFRVb1JYcm9vRGx2czN5djNQSHhM?=
 =?utf-8?B?dUJ3ZlJ2OUxuRjlKQ0dnanpYRHBGNW9nc0lJanBZcU9EVkREejUxbzluMlFN?=
 =?utf-8?B?bzBIT25zNm9nNFNGQmxxTlFOSkpUV3c2Nm1PRkIxNmg3aWVXZVlibkhqRzlJ?=
 =?utf-8?B?VS9kUFpvenNJbm4zb2RlYzdlQ0hvMFFQQUJWbHBvU29GbVh6N3hLVjcvN1FG?=
 =?utf-8?B?bWpxTldoMjdPS0RXTjNtaktQbXBZQWU0dVRUS0REZUZlSjlZREZ3SEplalhK?=
 =?utf-8?B?YWFMNzhobi9qNGh1YlNCTUFzUzRUS0N3WFZBN3FVZnFTeUVJODZUMGR3NGlQ?=
 =?utf-8?B?SGNJL3ZmYmVHcWVvT1MxUzBibSt4M0tkdkxyTWFWZlB2SWRWK3NsR1JFN2gx?=
 =?utf-8?B?SU0rdFhkN3NSL2IrdW5VZXZBWEZRZ3J1NmtJWlo5ejA3dW5KZkMyKzJ0aDU4?=
 =?utf-8?B?NFdvK3dUSFE4NmVDd0YxVEs4SGUxN3NySWFFTUhsUml6V1JsYTlmUXc0b3M2?=
 =?utf-8?B?eVdKYUJaSmNWbi9Ic2Ura0NlRCtGclRPaWh3S2x5eEVKK2RCMGdoUjhITVF0?=
 =?utf-8?B?WUtUbFh5a2FxTUlJbENWanNsekN3SnFNUXN2bCtwUVZBaEc4d2s5RW0wVnRD?=
 =?utf-8?B?UVFqbit0aEpFRjJBZEhWaW5rM0FKaVNSYjRPUHhmSEVWdWRvc0lrWUZuVEpx?=
 =?utf-8?B?cUIycXhULzFMMk9zQXYrTlVvTHYxZEJnL2x2dlV0dVIrUFEzNGJvQ3RkVjVZ?=
 =?utf-8?B?amIvMU54OVNyaDVsVjNoaWNmZlpRUDIxOHhLdm9qVHNNWnZlZHQ1NGFRb2VC?=
 =?utf-8?B?RTBBZnJpRjh3Znp0c3JGbUZURHIrai9MOFdRU2tKYldGZlJnM1dJM2kvNkNh?=
 =?utf-8?B?WmtCT04xamxjQUpWc2ZKWkxrVThHQ1dnemZhUis5VjRPNkhYU3BZbzBHWFd3?=
 =?utf-8?B?K1VidTAvYTdXY3RMNHZ0ZVp3bjRENkdLQVBENFFna2diYXF3MVVvTHlYNDhO?=
 =?utf-8?B?NS80NmtaczBiU2Rsdm5MYnF3bnlGTW5mRDY2djltSVJHU01VT05ka2F6KzVC?=
 =?utf-8?B?Z2lzVnhwTXJmTWlvQzdlUTNRVWdCalVWa0lHS0ZtVm5mSFlBRksyZEgrWGFu?=
 =?utf-8?B?MGg1U0lheVc2NkJjeVR1eEpZV2FaZ3VRQVkxb2pKbDVVTk5ZZW5vcE8vVkQv?=
 =?utf-8?B?ZHc4R3NFZVJ1ODg5ZXpiUWs5aHIvWXFvVk5pYzFZRzBhVUNOYTNZcHVvYlNs?=
 =?utf-8?B?ZHV3SERzaXpTTG8xR1ZiM3JXV1RNSEQxajhDRTNTbWtsU28zaU5WSGlnYXZ5?=
 =?utf-8?B?dHhjRFRnZStnVVc4ZW5XYXZNNGUyM2pVWXUzVS9NNS9IQTZvNzZEOEZyZW94?=
 =?utf-8?B?MGhSRTZqOHpvUzlVdmhDeWd2Z1BCcFFibSthNGZZUFFMMER5bUNzb2FVT1ZT?=
 =?utf-8?B?WU9MbTh5ZnFWTHhCcUxXOEpnVW45NXNoUVBBdlRGSnJSWmIrS2xBYTBicTNw?=
 =?utf-8?B?UG9oL2pkeUZiMHM4dzJRR3hsNWJHenVUd0wxUFJKeUhPOFh2Rnp4ZmV4aEl0?=
 =?utf-8?B?Ukk4Mm92NHBUc1dxRXBGZys3NkFQa0VoVzY5UU01NDRMNG9oRWU3anl2bEVB?=
 =?utf-8?B?VjNna3NoeVlwWkFGZTQxYU5WNElHOWhPcnYvZzlQR20zT1V2WTY5dFErdGNy?=
 =?utf-8?B?K1dlYStoNUZHcjBSMnJydVEycTBVMmxHOWVxOW8wZjNaT042WEY3WVR0SDk0?=
 =?utf-8?B?ZTV6N3RjbzI0cWxMN1g5QmJ0RGlTako3Qkx3bWRFd3laelMwOXhxMWtyQitl?=
 =?utf-8?B?M01vLytITTZSQkJoK3I5Qm9kaHZXTGN1TWxqalRzNWxNcnZRK1FPdGk5OEYz?=
 =?utf-8?B?YU9WOXNsN0V0NnJZSVJqRlVjOVJIMUM0bVU4SExyS3dZaXM4cDQ0ZDFITHFx?=
 =?utf-8?B?UVhkZ1BMeUZidlFoVTBRS3VISG1nTG9UcWdDRU5yd1FTaWxXbEF2K1Vycmx6?=
 =?utf-8?Q?C9yg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaf66122-917c-4344-a3ba-08de21372839
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 15:29:51.6706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3u5Kf1kbCqDdIUV54Z1FX5/lka1ZXNadTPwZirpIZ0yHrFfw1tlPC0Vu9BgTTOU3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9107

Hi Everyone,

On 11/10/25 20:44, Aaron Tomlin wrote:
> On Tue, Nov 11, 2025 at 01:40:45AM +0000, Luck, Tony wrote:
>>> Seems like user space has needed information to perform a sane reset?
>> Like this:
>>
>> 1) 	Read info files to figure out what minimum mask is needed for this system
>> 2)	Use Babu's suggested syntax of
>> 		# echo "L3:*={min_mask_from_step_1}" > schemata
>>
>> Rather than Aaron's
>>
>> 	# echo "L3:*=0" > schemata
> Hi Tony,
>
> I am satisfied with either approach.
>
> However, to clarify, the primary function of the "io_alloc_min_cbm_all"
> interface is to efficiently set the lowest architecturally valid CBM across
> all shared L3 domains. This operation relies entirely on
> r->cache.min_cbm_bits. Since this value is guaranteed by the hardware to be
> valid, this approach is robust and will not return an error (e.g., -EINVAL)
> to userspace.
>
>

Here’s my understanding of the discussion from this thread:


We plan to support the following operation:

    #echo "*=value" > /sys/fs/resctrl/info/L3/io_alloc_cbm


Its users responsibility to make sure the value is valid based on

/sys/fs/resctrl/info/L3/min_cbm_bits and /sys/fs/resctrl/info/L3/cbm_mask.


There’s no need for an additional interface like
|/sys/fs/resctrl/info/L3/io_alloc_min_cbm_all|.


Did I miss anything?


Thanks
Babu


