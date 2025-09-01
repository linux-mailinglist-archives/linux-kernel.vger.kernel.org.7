Return-Path: <linux-kernel+bounces-793809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD33B3D87F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 07:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A959189612D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 05:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC1C2253FC;
	Mon,  1 Sep 2025 05:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b1YYMbea"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53EA28DC4
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 05:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756703460; cv=fail; b=ltqpL2+j9D5nqILSV/oBli0YAI43+xxW/5ZAX/RrtfTenl7EEthWUzVBPN0DS77Dq7WmDe6rGn7KRaMCMrTv74/zKqej88kE52K7gtYkGLH0oHa1M9ehu3k6drkn/iRcn+jUM3gET9rrlVjZPc8J+1y1dfPFjAqwJO8BMtPRENM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756703460; c=relaxed/simple;
	bh=1XLNJopJ4V3+jpTD0s73zbyFYslbE/cVIHBkZb5OaIM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ck4IQfeCrcMREKoCz2jK0JlJGL0SJt89wx5pW/E0NjwU6AyJXQXR+bxNahl/+sOu28DUT2wcEJRX0SUSjJU8vAjAuR+4rduemUPKdojKrQM9AR/ewVnde+o+qtNSauizKryBbpZiswabgwLc/LE6RrX6PbCMbfAOP59y1IuWvR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b1YYMbea; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756703459; x=1788239459;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1XLNJopJ4V3+jpTD0s73zbyFYslbE/cVIHBkZb5OaIM=;
  b=b1YYMbeajHcTmQpWBl59C1IrdsfqZnEfI0O8I5o8xIMx7iwsViTKldos
   dqgSS3TGGWU425YnBOdoogk0PKrchsWPJ82mirATi4fhwVdNctTh+xZAi
   mvTcJwHpe6GSABEFojez6Jn96KDcr2wXYiyZbX7XTw9uVPJPAJUhAqS3n
   H6ckFo1sGUQaNRwdENB7aTwX+CDGhebok56CtMFD5dETCLoP0dhsnaaOv
   gruvV5L+uEatv0VOseaJoWNk8PUQVvenOtVovtHzW582pUBuE9ZOVCtXu
   T8EwFnMy13yzpJ09ur2s9QRD0lYFjqfyZ1Oh3hSD8T6ny8n4fDMoA3AtN
   w==;
X-CSE-ConnectionGUID: 3n3FEULqT16Epyz1iRl4Bw==
X-CSE-MsgGUID: qxDIXQUNROCVfT0lzqcXPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11539"; a="57919076"
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="57919076"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2025 22:10:32 -0700
X-CSE-ConnectionGUID: 9Xd1HA1KQ2emIwCpayW/uw==
X-CSE-MsgGUID: IzWicsElQoibt2Rl73150Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="170124684"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2025 22:10:32 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 31 Aug 2025 22:10:31 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Sun, 31 Aug 2025 22:10:31 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.88) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 31 Aug 2025 22:10:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YpRlblGJxUzggBOo1bDvShS+v7nAuBnyHlhBrd+1rBBGVUMVpn0I8sMrwTkeMCvnxiVkleElCUkLnMfuWXdZXAGcuM0DNrLpbTB79254vLiiUzjwCP5ATSb0AIsn3xRkJ37Bc8zd32qf9kBcRj8dzgfqdmYBtPpZNnUzDnD5PeFmyCuCdvcK4xisl5lDQCswh6EbUIqY9RWkUOEySbOrK9yXVTrn3evOm2VLnxzEsV7ZsgEnmIPVZ7mstAtX/kalqn/F0lbdt8z+c1G2Ch5DoiATDbKHUHKHS1pnZEdKPYvj9ZX7v7Pk1lYX/yNmgh9lxBP7+16MAVaEad4gxzYhYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iX1yDDPMOa0bflb2mRAsH3evu+ojfMwyAueh7/buZUE=;
 b=XmMlqomu3c88FQndOnRyKC25CCzSD+WYx3HuiQsdc+l59k7dk8ooUaWfSHqR6vjaiTFLj2zDjWpitSurW9GbWRUe9pZuNVDrrBe5BCIo8wEoB8EUIZnLb6fhytorblVACigH4k2lKRpci0h2uwt/49ji+Oua5WhpRILB2q2cdOFmd4waQRkbx6t82idW4sbYOmDXnJeYNkkBFqQS/RKt5tzZzpVzxplzjcBlr0czH6KFdZy908orp+vIjVZiUxTzAcBCl2zsA6BTYbrTjjtTvqqxAa/VeLn8ZgKoJ8S08OfobaQvlCMsN9K/Akl54lrvx1o4QA6zNgQe5fDugf0ifA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 IA1PR11MB8864.namprd11.prod.outlook.com (2603:10b6:208:597::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Mon, 1 Sep
 2025 05:10:28 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%4]) with mapi id 15.20.9052.021; Mon, 1 Sep 2025
 05:10:28 +0000
Message-ID: <a17428e9-0221-44ff-8a10-6cf93a00c172@intel.com>
Date: Mon, 1 Sep 2025 13:10:19 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] sched/rt: Optimize cpupri_vec layout to mitigate
 cache line contention
To: Pan Deng <pan.deng@intel.com>
CC: <linux-kernel@vger.kernel.org>, <tianyou.li@intel.com>,
	<tim.c.chen@linux.intel.com>, <peterz@infradead.org>, <mingo@kernel.org>,
	Chen Yu <yu.chen.surf@gmail.com>
References: <cover.1751852370.git.pan.deng@intel.com>
 <c3fa01bed2f875293ac65425c75a322e8e70e1d3.1751852370.git.pan.deng@intel.com>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <c3fa01bed2f875293ac65425c75a322e8e70e1d3.1751852370.git.pan.deng@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0129.apcprd02.prod.outlook.com
 (2603:1096:4:188::19) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|IA1PR11MB8864:EE_
X-MS-Office365-Filtering-Correlation-Id: 73c02149-ec1c-4bae-7bd7-08dde915dd87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TldDbTRVVHNOZ3hwQmNUMlhIWGZGaDFkSzBsYy9yaFh2bDFGcGZnR3lFbTZC?=
 =?utf-8?B?V3NoSWZGaHZTaHJqZ3hRbml1MmpQQlYvSGJvb2UxZ3pNcHR4YW5DOGk1MDFH?=
 =?utf-8?B?SmQyVHRITHMzSXc0cThZWWhYcTZZdG9SWCt3OXdKM2Rid1pxdjVJeEFHNGND?=
 =?utf-8?B?TnZYTEFGWGo1djRlcDFhSTR3R3BZMDFRWXAzRldWZk5KcDZuUVNtQzFQVnly?=
 =?utf-8?B?QWxqbTZoZHZEVmF1bENvc1c3OU5XOUNqTkpQeDRGaVFhSW9iYk5YUWsxYmQv?=
 =?utf-8?B?TmxtRjhuQWpBLzBGZjNYVFg2S2xjY0VOYmt1RHZzbXIvbk95VHNad1dNUjhl?=
 =?utf-8?B?U1VQUmhrS3hUY2l5MHlQYWNvVmRlcmU3SXh5Z3VrMlBydDliSnJaQU9PaC9M?=
 =?utf-8?B?elgvazVvbHFkZDUzUWZZU29GMnplWmhyem5vdGhmdXp3OWtwa2doY0ZCYTNY?=
 =?utf-8?B?OVNsbWNianVmYkVVRGhiUnpybDZmUUlmMHZLSGtJaE4vQ05aNC9pR0ExWDlS?=
 =?utf-8?B?YjFhRzgrTGJuclJNMU56ZUZpdGduR2VhQUE4L1BOTWszVlVWajhTbkp0eTdz?=
 =?utf-8?B?NlJGMTc5REMxVzVHay8zOTFtakMzM1NFeDdzRXdKOWY3M1phMG5kWTNkRURy?=
 =?utf-8?B?QnI4enNRTk1qT1hjMFp0NkVMUGI5NGo5UTNwQ3ZkU05FRld2SVFzb3RLZFBw?=
 =?utf-8?B?eU55MEtaY1BlT1NGMzEzKzhtUXhPWkVvcFNzRjlxMHV0cWVtKzU2YXQzblhr?=
 =?utf-8?B?ZlIvSkxqYnlLR3VIbzhZaExjazZkR2hxSzRIM1ZHRjg2YXRQaGkyYnE2VFQ2?=
 =?utf-8?B?c0JrRUs0Ui8rQVJuNlhpR1hHVWNPWFBIRktHQVc4bUNEbHNkVFNzd2V0dUtZ?=
 =?utf-8?B?c3ZvNG90N1hQZEJpWW81ZGdxVHFqaHdoeVhva3BaS3c1amRSajNDWWlEZXQr?=
 =?utf-8?B?eEVpM0RnSVN5bXhiVGI4UEpKUUNRM0lQQUJJT0l5eG0yMUhFa3VmZDUwWGIv?=
 =?utf-8?B?T0plSGVyYllOZnVZWXY1VU5TY3p2UWRldlJnNE9nbVRZVy9DK29MRlZwbHUx?=
 =?utf-8?B?dzJoZVlhdzJwUmQzeFRGZGRKU2dxdnh3bmRQdWxGM1JtaXk4R3NEYkFNOGli?=
 =?utf-8?B?Y3lBbG1RRFFodUdjK1o2Tkd0clQ5amhRK2VUZkZ5enRiZW9mQTNNZkNiYUhH?=
 =?utf-8?B?RVJNc0RSdFB1MDRjcE04MjdBNS9mYlU4Ry8zYlVRZ0VRMDcwT2FCUHRBWVVB?=
 =?utf-8?B?b2Z1bW9wSU1FVmZ2UmJ1dExrQk94czNIMHc1VHo0TGJtSFQzR0JUZkVyR1VJ?=
 =?utf-8?B?cE1kWkdrdExXRmtFaEsxelBEa0N4SFpJYTcxV09MMFVjaEN6SmRDMnVocFIv?=
 =?utf-8?B?Vm5WckoyUUpEUG92VE5PS3hpZTJBVERUM0pjM1ZlZlpVU2VXVXFXZUVJL3NX?=
 =?utf-8?B?MEx4N0xUamFzYklZOWR5a05wNVEzaUZNdFVBVksyUmd0dGdjbktWVnZPNzNq?=
 =?utf-8?B?Vy9MSDlwMkc5N0o4RXMrMnFqL1RJTmFycGFDWXBkOGNyeVloWmloZWZrUERJ?=
 =?utf-8?B?SldmL2MyZzFRaUYzNXlNOFZwZUROK2VWS0VWVE42eUpFblp1WEVSaTBWcnFG?=
 =?utf-8?B?MHNBZXFDaUpBNTE1MFBBNm9zV05CZ0d4NWRYeDVqTjlkaDhSWU9EMndKdXhz?=
 =?utf-8?B?MWYzV09VVzVaMDFubkdJS0MwUnBTRjRmbEJXSlFaM1FuWE9qemdjK3F5YThW?=
 =?utf-8?B?RkdBQ0dvY1h6QnIycStHZnpVcHpWMFk3dDFMbjdOdXJUNWloYng0cUYraG9T?=
 =?utf-8?B?UmI1Q3p1MHJ0a3ZjVm5DM2hvOFI0WFBUYXJsSHZOVHRVeHlvZ2ZBbGs5aTdD?=
 =?utf-8?B?QU9QZXUrR0xSN0FEdGU1Nm9NTWhnRGxWWGJGRVhCRE5Xa2VKK2dYVnRWV3Ar?=
 =?utf-8?Q?/WgRbraPtD8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGs4dmt2UENxc3NaMkE3U3EvRHhuaGMreEFua2VRVlc3a0QwYUhQMzJ5akZW?=
 =?utf-8?B?TEhFWGhydEdEaW5yeTIvSnhHN2ZpMDZPaUZ0SGhtcFliODFpMEIzTUVUK3Vy?=
 =?utf-8?B?Ty9VMUZpU2ZLYkFLc0QvaUxDazZ0elBydFB6SExRcWVZSjY2MGEvVm1ISXAw?=
 =?utf-8?B?VkcwWmMyOWI3SU5aWTFTUk5TTTRqYVRUbmxlbmJwUDVHVHhqSFpUTkU4c0lq?=
 =?utf-8?B?KzdHTEFVTTJ1Zk5UYlRuQnE4cjNLR2hMMk9MZHdQYXBBSGltQ2tmY1g2RHlJ?=
 =?utf-8?B?a2VDbWhqVmRZblVnTWNnNldCa3J6UWVjay9hUXdvNlFSMTZpVEVpZjBORGVV?=
 =?utf-8?B?dHNQYU5QUGl1MnFlR294aWFhaWV3OG9oVE9Ba29RYnJnU3BXWEEvYjJpTTFD?=
 =?utf-8?B?ZnlEVnVXWkJPYjlpdEdwYUVGU1F3MjFKT24xSWIyemk5U1k4NG5Cd1hwZHkx?=
 =?utf-8?B?Z2hXaUY0RXN4WDlqNjB1MDZqUk94SnE2RFduVzR6K1lnaGZWSDVQMHNvMWw1?=
 =?utf-8?B?YmpoQmhEVE83WVE5RkRMRVpXUFliUThlSHJwbWQ1dDMyaVRLYWd5V05raEZT?=
 =?utf-8?B?TVZCaWQwUlp2Q09Ub092ZDZrNE52WU1JRlBLWWNmRys5Nmg0NzRvRGd0OEly?=
 =?utf-8?B?dUhTak5DTlJYSUUwdHZ6OFQ0alFLTXlpQkt3b0lhUmNEcUtrZmpGUkNLWUhK?=
 =?utf-8?B?aVlWVVVEYnZyaWI5NHUrNE8ySURCRHBFMkpZSGRGbjVqZXhOb1U4ZFpISGNi?=
 =?utf-8?B?VkNlWDJTV1FLeDYxeTJ1K2NUT0pYazhqVVZsSmpjZEdmUTVzTXA3YVp5aktH?=
 =?utf-8?B?a2hNYzFjQ1dDWnVEd0dBNGp3dDI5clVGRVVxTUwwTmRvZHIvMUJ4Q2dYdkdj?=
 =?utf-8?B?NHlrUVhoeEg4TW9raEZ3dUdIWERpMlo2ekhuVTNySlc2dnJzRS9DU0NLU1U2?=
 =?utf-8?B?OU9JNjNzc3E1Z0lzemdIWGl2aXlNb2V2LzU0MGJhMmVBdzg1cUVYNDFmRDIw?=
 =?utf-8?B?VkxBY2hqbmRNT2ovazN1cGV3NFh6eVptNjhPalcyR2xjaVJaSzVJYmdkS3Vm?=
 =?utf-8?B?WmJGeUFlVEZZRGpVcFljVklIYmdqUlZydUc3VTZjWmI2UnBncnhLYXRLMHNC?=
 =?utf-8?B?RDhGQ3c4MXorRUI4bGhNTEQvVlNqZ2FSTVFPaTRYWHBzdFlzUWZjcFRUbk5r?=
 =?utf-8?B?RURwWTNCRit5VEtPb3NJUVNjQ0xrZzBNYW5JZjU0SVhvUmJnNG1FQkgyRHFP?=
 =?utf-8?B?V2ppN3ErRmFIcENDQ0V1Ti9iSVdpa3kzdGVNOTdma3NtT0hWTHRqbzJCQSts?=
 =?utf-8?B?dHNrWTBxWXhCalBLM1BBNVh2Sk5RWWkwSmhCTVFDcGIzdW9TQkVzU2dFWjRi?=
 =?utf-8?B?aHVEb01tMW1PdGxVQkFmR3dFTlZJVjJsRTFCKzFoTUV0WUYzSG8rZUxsY3VG?=
 =?utf-8?B?M0NZcGFMeEEyY1hoYmJiNHNxMnVJT04rdTJoRFRSelBlVXZqeTl4L3BoMU45?=
 =?utf-8?B?bHJxdTRtMkR2RTQzcTRpaHlRczc1a3lGNXVQZUZTenVHMkZWVjFvcFB3R0tm?=
 =?utf-8?B?bEkvK2c1YVoxbnVEZFVZTG5PRmJ0UVYxdHkwSjVsVWVWRExKRW0rWlFpQUFn?=
 =?utf-8?B?cW9MUldnZTA5dGhJM2tHRjE2dDZLYkhURjZpUE5rY00xMWlBVDNyZTVuS1Vx?=
 =?utf-8?B?dXY1VXR3a3FnRlArQk5lby9wNlFYWnJCYllrd25LdEtWanZBak5RRUx0Q3Jx?=
 =?utf-8?B?aTZGdnY1NE5uR2xUdkNubXp6OWFramxadnZRV2J4QndMYU9hRC95ZW5YQldE?=
 =?utf-8?B?QzVoRkFFbi9Wb1hLckFMc0szMGdxTTBjWk5zSGNjQ1BQTUN1RVNOT1BwQTVD?=
 =?utf-8?B?Skg1RlIwSXBPWW5INjV0TitVV1U1VVFTRWFOZFRtUXJhSUNPN2pVTFJ6bDFJ?=
 =?utf-8?B?cythKy9YMGUwa0FtTTNxQ0hvcGpEQi81ZFI5SDlndlprcGQ5VkM2OUljSDlY?=
 =?utf-8?B?SjJGM1BWTUMzS2Yzc05NRnZkNytyUWEyaVdnRDZHUUJzdGYzNEduTEl5SVNO?=
 =?utf-8?B?bGpMcjZEaks0ZklBWTJ4dTkrSWJGZUdzaGtsbnA1VEpyOHRDSXp2bEY5VjF0?=
 =?utf-8?Q?QLS9N6xWfeau7nUzNeP+UQFNI?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 73c02149-ec1c-4bae-7bd7-08dde915dd87
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 05:10:28.0891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XxowsnXbiTDsCFQ9ib+ywPbUkwgfxT3qkm63IoNY3qm0Cv5VPTfbqckLp8ovJ7tPKQVdM4UNcUiN8F7xX+++cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8864
X-OriginatorOrg: intel.com

On 7/7/2025 10:35 AM, Pan Deng wrote:
> When running a multi-instance FFmpeg workload on an HCC system, significant
> cache line contention is observed around `cpupri_vec->count` and `mask` in
> struct root_domain.
> 

[it seems that my last reply did not make it to the lkml][snip]

> diff --git a/kernel/sched/cpupri.h b/kernel/sched/cpupri.h
> index d6cba0020064..245b0fa626be 100644
> --- a/kernel/sched/cpupri.h
> +++ b/kernel/sched/cpupri.h
> @@ -9,7 +9,7 @@
>   
>   struct cpupri_vec {
>   	atomic_t		count;
> -	cpumask_var_t		mask;
> +	cpumask_var_t		mask	____cacheline_aligned;

Just curious, since this is to avoid cache contention among CPUs,
is it better to use ____cacheline_aligned_in_smp, so the single
CPU system is not impacted.

thanks,
Chenyu>   };
>   
>   struct cpupri {

