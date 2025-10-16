Return-Path: <linux-kernel+bounces-855846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B748ABE2744
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 11:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F59D1A626F6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 09:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898C83191BD;
	Thu, 16 Oct 2025 09:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xg/ImedU"
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010017.outbound.protection.outlook.com [52.101.193.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1777131815D
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 09:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760607627; cv=fail; b=WghbRemHrItgsHbGlHX67gaD2DfyriGYzZwpXs75zpqoUb/tnoe96XrnR6miXvSEbKkBUJewYUaLD+bxbDfLhDuj8iTOSiwjSLf1ahhrKZKs4npVOC8lOb2Lv/KgkADd/XYFUzEKmLHxQ6H2/dXYaQn5aTdQWx0UMYjCYUuvRak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760607627; c=relaxed/simple;
	bh=ZzBOLPY1A533JJaE1UgFBP/MYEo4kFGRU+ZCDkU/J/o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Lx/QY/hcxSzICAmy52NcwlKxpsUBTE9j+EhG3XIyGg8DsEofgncDkk4lyOZ3nj+MkIbvdqjyW7mO47MFu3/IY/tdD2QgiD/4YUrpxxBgwkn6hYLUR6yDcmGlsVbwIgYBNECkrt8Pd/Kg8IwzvxliIyWGzUYvWKZ+IUxkfawb3aA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xg/ImedU; arc=fail smtp.client-ip=52.101.193.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YYtc8kQRtiDqhDHwMEBT2t0MrqGKmB3pjlMoWaKOK6Gr5qfc/1NqoEuk1Requ8C7G/NnYyLCWl4IAm0hCqmY3jKpnVFgp66+46I+oM799aqrn5SdRhJlp1LKwwtXJQzjaUGYMg9tRGL5Iurk0yl20gVCWSLsKj4/jmJwh7rChVtVUCfM/TjEVhGtfqmGK6pVokJZPWDJ+xSt0o9OoMJ39b0AQPQ6aVtcFsfQer+KqCoAWpQyKjori9kSP6XHDKGdu5P46FuZz2oadJDsNKAkj+xA7jQMfis5g+s+B7kkrgpgzRbbDzf8A7Il41NVt1NAvDPe49qnTYJPGpIsdUbfAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZzBOLPY1A533JJaE1UgFBP/MYEo4kFGRU+ZCDkU/J/o=;
 b=CGeO7N3Wf8bIhVoaMVVRLyZqFetkvMipmvxu8qlQhr4zOySspZhJqtUL4a160mSRf8Vc1JGRtpCzqG+QW5vJI1dpFGZcTT3CvcL4knoMNnPzK5umiZr9STsJe8YfcslElpzOXubxvepv2NVyV6IQ2smpOcX0RWuJH6cuWqFx7SfKe7+U1Wynf1RImgWVQinzlZUpW13PYmBSJmbusCB0mbeFjsjbkxCras/tfNNbLtvUeNlLMBHsi2QGRPx4g2EMIDOQ5yjFYIarfBze7GNAhyQlDv06xQMFCaO/jeaYZVG+8ebsjOPZ4F+6EdT+r4YJJuvNO/flwOEH5wURwrV5xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZzBOLPY1A533JJaE1UgFBP/MYEo4kFGRU+ZCDkU/J/o=;
 b=xg/ImedURXs1qx9cX2tKDyhQQ/1xkmMvS6Wrgb65q9gJfRnQvyrcuKcDpeIMDHDYc/9ndNN9BuXwly5XPq3ewzA6cYsMxmjpkUrhFRL5UCX5S1SmwttzWhSbVpAoZhYbt0fbpMI9VMnmJEokYAOX8HejUAUtH6nt787eDn5x4mc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB8301.namprd12.prod.outlook.com (2603:10b6:208:40b::13)
 by SJ2PR12MB9238.namprd12.prod.outlook.com (2603:10b6:a03:55d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Thu, 16 Oct
 2025 09:40:22 +0000
Received: from IA0PR12MB8301.namprd12.prod.outlook.com
 ([fe80::e929:57f5:f4db:5823]) by IA0PR12MB8301.namprd12.prod.outlook.com
 ([fe80::e929:57f5:f4db:5823%4]) with mapi id 15.20.9228.011; Thu, 16 Oct 2025
 09:40:22 +0000
Message-ID: <fd0a07ce-523d-4755-8caf-4fe48ba954ba@amd.com>
Date: Thu, 16 Oct 2025 15:10:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V3 5/9] mm: add support for copy offload for folio Migration
To: Jonathan Cameron <jonathan.cameron@huawei.com>, lorenzo.stoakes@oracle.com
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com,
 willy@infradead.org, matthew.brost@intel.com, joshua.hahnjy@gmail.com,
 rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net,
 ying.huang@linux.alibaba.com, apopple@nvidia.com, Liam.Howlett@oracle.com,
 vbabka@suse.cz, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 vkoul@kernel.org, lucas.demarchi@intel.com, rdunlap@infradead.org,
 jgg@ziepe.ca, kuba@kernel.org, justonli@chromium.org, ivecera@redhat.com,
 dave.jiang@intel.com, dan.j.williams@intel.com, rientjes@google.com,
 Raghavendra.KodsaraThimmappa@amd.com, bharata@amd.com,
 alirad.malek@zptcorp.com, yiannis@zptcorp.com, weixugc@google.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20250923174752.35701-1-shivankg@amd.com>
 <20250923174752.35701-6-shivankg@amd.com>
 <20251002121009.00005899@huawei.com>
Content-Language: en-US
From: "Garg, Shivank" <shivankg@amd.com>
In-Reply-To: <20251002121009.00005899@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0089.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:268::14) To IA0PR12MB8301.namprd12.prod.outlook.com
 (2603:10b6:208:40b::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8301:EE_|SJ2PR12MB9238:EE_
X-MS-Office365-Filtering-Correlation-Id: ba8ed84c-bb58-450a-d4fe-08de0c98068b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TEgxc2VSQ0J6U0tDZmY2VTc1UENYWWNVek1TeGRrUFZwWVlPdHlBUDJOc2N1?=
 =?utf-8?B?R21SemdFcnNXcFViQUFteVFQUVhKaWp1Zk1LN3FHQkptS1ROYUtqRVlFY3B5?=
 =?utf-8?B?UHNRWU1yVGNKaE1WakVTZkxIUEx3NndzSm11MXFDMzRGVk1FVTFwbExzSS92?=
 =?utf-8?B?dkYrNFRlVk96MHY3aWwrMWMvQXhEbmo1Yy9tVTFreUp0TTAvekl5blZLZjhW?=
 =?utf-8?B?WC9DVTY3UkMwZEE5N3JEQmcvd2lJeFRIbVM0VDZtRnJtS3N4WmdjWllaWEd5?=
 =?utf-8?B?QkVNRjNmaHMwYW04Kzl6SkxUbDRDclBZd2xFeGJNVE9IZHozUERnRFdOZFpU?=
 =?utf-8?B?dE9UcEM4Q2NwTFRxRkM0ZlhodUZGUWZrcTN1dXdiRG5FMlMwcmZvN3l4a2Fo?=
 =?utf-8?B?VWRNam0ramN6RDdvZE9pcm5Nd1hUYUZrTDM1eGx0NyswLzhzVnFta1ZBVEQx?=
 =?utf-8?B?amRCdmRka3JnTVU0bzR5QS9xMmtXTys0SG1LdVJCcFRVNTBzalVFL3pGMks5?=
 =?utf-8?B?dGxNTjNkMFVYNUpyWmlSaGRZQk9NK1h0azJPTXBsZERLYmJlV05WRzNZWWhy?=
 =?utf-8?B?ZkgrNm95b3hoc0hwbnBNRXNDYjluQ1h4d21zN3M4d2JjOGJIeDlJNVNiQzhz?=
 =?utf-8?B?UTd6UGNsajU5NmlTTHlZbEVFWnFJOWs2RmVEM2V4Rndlc2dNc1hQRlFKZERa?=
 =?utf-8?B?TnVWY25oVkNYU3lQRVI4KzYrbCtISmdWWmM4d1ZCS2xZbncwYUFqT0pmNHZz?=
 =?utf-8?B?b1Q3Slp2bm1md3ZPSUVRc3Z3dWMxMzRTTUF6NHZ5UEY3ZE9wWkVObEhTeUNo?=
 =?utf-8?B?Zms5OWNMbDczVHMyOHVmL1BEa1ljL0J0bHpOOTY2TFB1Ulc5YmJxdWhHbUhh?=
 =?utf-8?B?czNia3lSS09tcnJML2RxNTF5Nm8zQUF3MFVhbjdscEhUa29zWFZVQVcveHN3?=
 =?utf-8?B?aFFqUjhmaW56SEplblhzQkZacHVrUWVwd2ZpREVIYkRpbVBGa3NNSnBNTDBD?=
 =?utf-8?B?SmIzUjg3TDNqMll2ekNFaTJFc2ZkejJ5eDlSQlFaYzRZS010YUZkZDJ3bHNl?=
 =?utf-8?B?RFpFYmsxaUJFVnNJdE1KNTJYREFhQmdhRlRKOE5SSTFnWWVYOEpuMkVjL2NO?=
 =?utf-8?B?NlNTcnJ6d0hJZSszMFRRRjhNd2NkdUR4anNIT0xZMzJPejJrWW91S0R1NVFt?=
 =?utf-8?B?V1NIYzJlSlNmRUx3SzBIdWdxblVzRnZmQ3JVdngwV2VDKzB6dkFFRkRmNmN5?=
 =?utf-8?B?aldhOEhVU1J5MXVJbXpmRlhHRWFXcWJZQ0J6VzBTV1MreGNPY2hnUGNQYTNI?=
 =?utf-8?B?Uk5pU1dOeHRRMThmKzJCMXA3N2pITENTbXFHLzZTb0xoY1ZJY21EbmVTeldQ?=
 =?utf-8?B?N1dNSnNWUXNQM2Q4SzViYU9DbTA3Z2N1RWV5MWpYWnlYMzVWSEk1NXhwUUFo?=
 =?utf-8?B?ZmQ0eTZDYTdxcE1qRE5zU3FKR3pZcDdmZnl1cUlXRGxOLzNkalkxdFdLa2Jx?=
 =?utf-8?B?NkszaldtUTBCL1FMZU56WEg2MWo3VER3NjdEQUwwUTlXdkQ5SnhBbVVvUUpx?=
 =?utf-8?B?MktQZzZKQlNtOUFXaDlIcjhiak5adkJrUHRYWTdjaHB6dUdLWVlWVnhPRS9W?=
 =?utf-8?B?UG5rdWxFYk5zalBJa0pzMEttblZFZGNPbDVaWWlIWGp1ODJDbFE4TnV5SXZo?=
 =?utf-8?B?V2VvZkpSSGhHM2lGVGpWT2xQTGRLY1NpeEx6MmgxeG50TkpFOEFNdFFKN3BH?=
 =?utf-8?B?MFI0Q095dlpJS0o0RTFiVHNpc3JTUFJtSXJXTkpSRVdEOEFYVUhiSHpERlRr?=
 =?utf-8?B?NS9PVG9KVmNQYzVNU0oyOHRESE1sSWY0RFMxVnBSUEdZYThtMjdwUUo0d3I5?=
 =?utf-8?B?TDgrQUdYOUc4dFEvcXFkZnNIL2UyamJCVHlYcUdOZUxZcGUwWjM4UWJDYlNa?=
 =?utf-8?Q?J3j/mBu2MznV9wXjr/nBxJuJQgg+9czV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8301.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ODRrMWFHbDh1Ymx2SS9zSmNOYm1CYm5TbVQvdjhrWUVwaVpwK0pYNW5GejZM?=
 =?utf-8?B?czhsRTF4dWt1R1prSnkrN1NsOWdOM0F1dTZ2bHloK1Rab2pnNWpweTFaM3Jh?=
 =?utf-8?B?UWFtMDBjNFc2eEQ5UUowc1FTT0xlRFRjSG9Wc1E1dW1HdEFLTnYxT3ZBNVFS?=
 =?utf-8?B?SThKc05wN2JvM1J3dGpaamxZanVyZFU0SExVTE8rbkZTT2RXb24zT1prcUZl?=
 =?utf-8?B?QnBsOVJOK0lNWDJ5cElOZWZydnAweVBpM1RyMmZOdFV3RmQ3cW9iaDNXRmta?=
 =?utf-8?B?RlNMc2JSU1I4amtZbG9hT3RjS2owWEFjdEE3UGVLT3A2Ym5tZGZLaHdTUmhh?=
 =?utf-8?B?ZkVDRmVUWDRvdGpoVFBRdU5sKzVudUVWaXNPaHN1Y25JYTNrd21tMEZITmZ6?=
 =?utf-8?B?L3AwQmZjYjdydzZyUWxDNHY0b2o0OEthcXlRSVFDSCtMSnlzNUoySjJiNHly?=
 =?utf-8?B?N3FFeDFOYUJURThCNFd1bzFlcm83RHdpMEJiTkd2T252Wk9qSmVUZXdRWXVB?=
 =?utf-8?B?a29kMTRiQVVZbTkySXRsQjVsK0Z1UVpsaDN5cUg5YVBVL1BsS05ySnN2aDRn?=
 =?utf-8?B?cTJueStkTUNFNmVjemZldFhNbkNnMmYvcHlWWjg3dExHd0hHSGhpWHJWQnJN?=
 =?utf-8?B?NFNWOTRuNmp0Qkpuam1WUGNtYzNnemZ2S3M1N1pFYW9TbTc4dktyT1pDaWxG?=
 =?utf-8?B?VmJKUkhLYXFTOXhBcFVMWmlhSnF0SW4vTEFMQ1dibmlQc05lNUpGYUlPeUg1?=
 =?utf-8?B?MVlRNXJxTUttc0o0cmpvOExna3lSZ0xDaGhqeFN3S25jYy92T25Rdm5ZcXNv?=
 =?utf-8?B?YkxId0pnWnc3UUtMSlFWQlNaZ2ZDbUtQNmVXTjdZOCtIREdCL3hlS1FiY3Zk?=
 =?utf-8?B?ajZ6SFpQb2dwV3pTK1pTK0V4VS9WTjhncm5wU3BQZ081QUptNzVBV29vYzl2?=
 =?utf-8?B?ZjV3cW41ZDAxcHhNU0FsdmJpUzJEeGxacWRVaUdIOFpWUjJQZFY5TnFTUTZz?=
 =?utf-8?B?eTQ1WVhXM2d1Y0d0RTZ6eTh3N2VsMnltZmxIaXlxMHNIamRmdllSQ1JaN0N0?=
 =?utf-8?B?S21lci9NYThGRUZUMUt1WU4wb3pUQ3pZODV0WVhSMS9TZHpHd0JXRG1oNlQ2?=
 =?utf-8?B?OVBMaHh6RDRzQ055MzdpR2NxWGloZ3EyR2xBTG1mK3k5N2lQNTlCbUluMlpl?=
 =?utf-8?B?dWRFL3FUcDJ1TUJGNmhBczZMaUhJMkxzTmtRenNqWUhzQmkzMHg2Y0UrMHdh?=
 =?utf-8?B?YTlXcHQ4d2dIMk01RFc5bi9lK2lrZXdvOC93Y2lWVTRpOGNYU2tMakRkZFlp?=
 =?utf-8?B?c3V1VlJZR1ZObVNvZThjUXV2dE5VR3VYQmg2YmcxY3hSRHRGWUNBNUxPY2d5?=
 =?utf-8?B?blNIdWVweFJWOWZiWEtVL20zZHdXZmZNVGlHZnVGZEg3ZGhBZ3hGa20xWTZw?=
 =?utf-8?B?SUtieXBZTzFZMFNyUlgrZTVMUFNXN3dYa1FWd3o4amdpNEg0c0hXeFNuWDNm?=
 =?utf-8?B?OWk2L09hSjNZbzBqMjlISGJndGRMb2lUTDZ3TFhhM3kyYjI4UEVFZnZLMlVE?=
 =?utf-8?B?M1lXbDByenNwTHR2eDdLbzRXbi82cVU3MEhWeERPdSs3a1RWRzJxcWR5blkx?=
 =?utf-8?B?WE4waU03RFZLVnlVOXY5VHFDbXF3TC9RbzRiKzhVZUtIK2VBRmUzRVFaWFRD?=
 =?utf-8?B?bDE0WFFJRFROQWJqTVpkUXo0b1BPL2hZb09VZUF6VkphT1pKQUpXTWtnWFVo?=
 =?utf-8?B?eEZvWVR2Q25mSmNlcXVRam1TTm9RVE8ya0hvRWZjV2s1cXlmOWpLRnh6eFcr?=
 =?utf-8?B?dUxvdzBFdnJGb3o0WmdSNEp4cEh0WGRRRjJhejdEQVQva3MvdmJVaVBQRmFT?=
 =?utf-8?B?aGhjc2Z5NFByL1UrUnJmQXE5UGlKRzYwTmFnelpJWk8vMFJvSGpXdGN1emR1?=
 =?utf-8?B?aWhTRy9PUmpOOGpHR0Jsc211UHFsVUJlM2xuVHA2SzRzMEwxaFROTmM0Q1BK?=
 =?utf-8?B?Wk42RVRyQ2xJeGNUWWhidVRpQm1FS1dETktXcjFnZmVHenNBRXQ5bDhsTVVm?=
 =?utf-8?B?aDdNN0htRzhpcXJtWG9aZ0pUNVVNQlVtMFE1UExMeHRYakRRbHYxay9vbnRL?=
 =?utf-8?Q?+lqY7yEEAu6voYKNC/YPOigAJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba8ed84c-bb58-450a-d4fe-08de0c98068b
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8301.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 09:40:22.2586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wFXcfI4kGQ6xK7KTL62YJic2yiji35OxzKCWEKFD0qKArmihA5FnkUz5176aZ2r/luxM3sQlUtamdq5xzyYhZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9238



On 10/2/2025 4:40 PM, Jonathan Cameron wrote:
> Ultimately feels like more complexity will be needed to deal with
> multiple providers of copying facilities being available, but I guess
> this works for now.

I agree. The current design is simple to keep the implementation clean and focused.

Depending on usecases, if there is need to support multiple concurrent migrators,
we will need to revisit this design and implement a more dynamic selection mechanism.

