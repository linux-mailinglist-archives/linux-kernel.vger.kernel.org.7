Return-Path: <linux-kernel+bounces-889378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D648C3D6D3
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 21:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B96F3A7B1B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 20:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903992FBE1C;
	Thu,  6 Nov 2025 20:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Rd8GwUNy"
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020076.outbound.protection.outlook.com [52.101.61.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B9A2F6922
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 20:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762462316; cv=fail; b=On7xAImtEFPuEt+K7rcstlsWNQzJelH9TdCIxSlNKOngLxctz1ykPhlYRcnMR0yoJJrRYqmbPhXxvD0VUGe+Vav5kcZfGBQCza6isDccuZ5eOt5laWZqWtAQVNmrvEcyJNEMNf8O5NEENSGugLc6PwUVeIKmKL8rjDZb+Pyl1lQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762462316; c=relaxed/simple;
	bh=P1H+JA/me3FGKuVH8Emuc/utbRUkOw4wMXhixFLPBCQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=smJIHcDDiBHbOqyxDTK9W8Ttg9iBSvqS351nLdPqwqeu01m2iplUhIKzUe0z90WU7c5UFu9WPYXYSKY0zHZnL4mHhAD4esQ/ZtVVkb3K7+A3YshLF4ltg43YR0GPhCasYJfP/AIBbvG1vj45NSeNL7Af7T9wOUEJuULG9wK+t8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Rd8GwUNy; arc=fail smtp.client-ip=52.101.61.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IuPU7DwHyQ9QP6hYwBTyB2NEmLN7g9OVGreL1CmHyW6tDwDouOuSQ6LJGHvJGTC5bFjIV6jnh6bjMx73DK8bnlvS1OJddB+9mXSjhvy3QIM/KMSBMu+cy52UJFrqEIoctuze1gnJfV+5ZhLvs+ZOesGmNxTzrmgAk1stOU2XHJiq3MxC9lp66jVa2cFdzRYlkkRa8uEdX89v85Pkqk2OrZ0XYbuqMCYqzAeiFYNHAHtVs4nBqV/fU5wukgyxTKTrEr9+3fANdjr1sNDTBNq+ns0jbsVnTW3bDImWGudx3RMkfoHG48ckhorAOJDSb2EZHI/nZliwBD2UQHtGoJdr7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oLY2avlyxH7guThMmbG4rVsEvhrpd+PEQQ96nYHsNmo=;
 b=JDNsrvyLSPMrBiMeudD1q84oQgopOnP0R30HFuyUw+EWLfkNFPl40tV/eNZ4reXy9GUbB4Y7XOz/HWZc1ZBph17h7ehSSbcbqrYENr3IiMOZ+nIH9deVUIqJiUqUOkyM/pGppd1uuy0gn0cyxzbtC+mnoYOdXcfbwyjCxkmL2+c7eI/iMcyDlc46Aq/ADG07E94zTpUh42Y8Ef4gM/F6uq59akB3g7EClvt3eLjPURyeJeSpDIBMXp20ffDAHVgxoaoZgVHH38i+w6lRfdJAA84nAeCZF9RxfYfiZ15bEBRt42bK+HWRwu9grPabKbSsisEKRQyGTiqWifXPufG7Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLY2avlyxH7guThMmbG4rVsEvhrpd+PEQQ96nYHsNmo=;
 b=Rd8GwUNyBA8NtaTw8xx8fUktVLYYzeiN4FGokdMei6/t13gl+X8D5lJXyw1dvJq3py4UPK+sIKyjVqyZgs+upt5ObOo9kdYQBcp5Dn22PkBUxBdUFsq9P5xQ92+SGC9XX446LncOMX+8egxC7wSTZWyStbvT4S000o19KDbIQSM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 DM8PR01MB7126.prod.exchangelabs.com (2603:10b6:8:4::11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.12; Thu, 6 Nov 2025 20:51:51 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%3]) with mapi id 15.20.9298.010; Thu, 6 Nov 2025
 20:51:45 +0000
Message-ID: <7fce52b9-5c4e-4214-afe2-c1607285aa27@os.amperecomputing.com>
Date: Thu, 6 Nov 2025 12:51:41 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arm64: mm: Tidy up force_pte_mapping()
To: Ryan Roberts <ryan.roberts@arm.com>, catalin.marinas@arm.com,
 will@kernel.org, david@redhat.com, ardb@kernel.org, dev.jain@arm.com,
 scott@os.amperecomputing.com, cl@gentwo.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 David Hildenbrand <david@kernel.org>
References: <20251106160945.3182799-1-ryan.roberts@arm.com>
 <20251106160945.3182799-4-ryan.roberts@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <20251106160945.3182799-4-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::6) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|DM8PR01MB7126:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a8a63eb-537f-45cc-3076-08de1d764c02
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WGtIRVBtMUsrRFZiOGovUVVtWUZCbmJ4L0lyMktQb2tiSDE2SnRyNXhQUTEv?=
 =?utf-8?B?anhUUTgvVzhnUXZ5QnV3S3lmMWROdmFoUVVpRXFBNHhsZ0lVd01VTHNFYWFK?=
 =?utf-8?B?Z1o1ZG5KUzhFdkQzZDFFNkpBK0ZUNzNXakF3Z1dvYTFmVzJHWFhMemd6eWs0?=
 =?utf-8?B?eVE0c2lFUG83SWlzalhNWm83U2E0dERJbHhPOStwZytsSE9WamdoWjc3L2Yy?=
 =?utf-8?B?bDFtUGZRbk5tT0UzMW5vdDlWV3RTOVVuNnNQNzFDbU8wS1FSeDZiYk9rOHRJ?=
 =?utf-8?B?RXJNeVphRzZ5bEllZlpyc1ZibVNYZkxGQ2pwK2dRMGRZcUFaVFBlOFVPMnB6?=
 =?utf-8?B?SXNYOHFkOFNpQVpiZEh6NFBQdTBZeGNJbHA1SW1YanMzUWJja1hMdGxOSlBR?=
 =?utf-8?B?WkpZZlBNMUdjZU5SV1FKdWd3NEh5QlJobzVnbTIzUndubktsL2JWeTNYalFa?=
 =?utf-8?B?eHBoVDhTaW5YYzZ0aU90alhvUGxGcEprSjAvMU1mQmFCbVVZRER2NGsxbjNV?=
 =?utf-8?B?WVFacGZqellGYVVMcHQ5c1IwTSs5SkU3K252RnZ6QTFpazlqME5NNUJjT0Ir?=
 =?utf-8?B?ckZLVndqQ0JUbThxSjhtNUNKMzdmaW5VMmllV0F3TmRGcHBQdFV4WDZsMUVX?=
 =?utf-8?B?Zy9LaEFGUmlnNkNYNUEwYmM1cFV2cTdaTFhEZ2QzeGFPYk1hcm52MHBML0R0?=
 =?utf-8?B?bmpvallTVHRGWUV5cFVRYkRVYTFDdzU4K2hocG5yTGRJYWFFMm5OMWlIeEhw?=
 =?utf-8?B?N1ZhOFdlNFAvNGMrd3JKWXYyUE8wa2JyOHpYRWFrZkxUREdZZkZ5bUZ2Y0sx?=
 =?utf-8?B?MGxrWW5JQTBqSDFySFhaYUMwTWhiMTJWUUJOYXROUzdjWHRhNUtVdzRJVTd5?=
 =?utf-8?B?U1Mxd3JpRVVXL2RmV3VaLzFuSWlPajhibGptaUgyazNhdGVSZ2drZnRYdGRU?=
 =?utf-8?B?TDhVTjdwMWl6VnRHci9wWEYxK0ZGTkFmQ3ZQR29Gc0FBUldtR0ZZTDMxZDB1?=
 =?utf-8?B?THNaSVBtV3FpZGVCYmZRVWxXSHYrWTZFZi9MejNPUFhSWit6MzdNSUxFQjRU?=
 =?utf-8?B?bjRqajh2SDFwWkpuVCt3MjMrYURyR0k0MGptb1JrU3ZZbzlQTk5DSEJnaHFo?=
 =?utf-8?B?c1didkRTdE12M0ZzK3hkWU1ZbEFoeDF1V1oxTGQ5b2dhMktMYi83czZab29o?=
 =?utf-8?B?bDJQWTJINXEwMTBRN0dmOU1hVGFNekg0ZXA0N1JBZG5icVdkaVVsWHdxVTJD?=
 =?utf-8?B?aU04alordU1paCt1UWdhYmgwWktlUmRhQmNoaXJZT0NuTDZwcE9FcklrMVYw?=
 =?utf-8?B?RDUxK0ROcXlxOTM4OE44UHRia09WUmJRSTJRMzNCKzV1RlZ1bGVEZHozemIr?=
 =?utf-8?B?K3UwVEZ5ZU1OZENVNWM5WmZLK0VEZG9aZml6UHhRRmpUSTBESEhXVTFnTEtk?=
 =?utf-8?B?cjIvMStDeUUyVzFralVFTzJFcWY4cjgyT0lxM1d5T29HNEtqWFlkMk5HTGJy?=
 =?utf-8?B?anNZRDBwU0RDcWltNFBhWUdIdTE0STR4NlFPeEVIUzNNL0h2dm96ZWtMMDFq?=
 =?utf-8?B?NEo4L1N5eWc0NzR4NnZTQkNYeFZPc3l2Y3RRK1NLVjFwNFVnRUdCcitkc2hV?=
 =?utf-8?B?MFRVUW9NTmg4dExydXY4c0xWYU5hN3IrY3FuTi9oVHRvUEM1NERoUlQ2L09r?=
 =?utf-8?B?cHdPRkdpWTNRNDRvdHExOGpIZURJY2o4OWl6MUZjMXlxNkhOZkJOZkZLVW52?=
 =?utf-8?B?dWN6NHQzOUNpWi8wdS82OTR6c3pCVWt1cTFQM21CZjNMdjJ4OTM4aUFFWVZ1?=
 =?utf-8?B?WTJxZDkyMHVHQWFLYlpGdVJLUXZNSWpoVCtwZXlEdHl6SEgxbnBnQVpKeGVm?=
 =?utf-8?B?MVFYNDJGUG94c0F3NHcwWVBiYmNISTRJL2FaRmRvdXNNNy8weUtZL1Bxcm9G?=
 =?utf-8?Q?6uXkQhjQaXznw3pfuj3R/vIfChauPNOE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bWVOY0pUMXJJYVQ0aktHZVNGdDNlOFhtQ1ViZW9DQkpmUUh4bGZKK1MyR0FU?=
 =?utf-8?B?ZG1rdERkZmFOdXJybnFQUDBneWtyYUd2L0huZ0NZdjdqUTNXYlRRSkcyRHJM?=
 =?utf-8?B?bDVsM1ZNWDJiZ1cwNm5scEFrMTRUOHkzZGQwVWVNUHdIMVZOdkg0RC9OMk5Q?=
 =?utf-8?B?YUczRkM0bm5XVEhsRXkzeHFpaVdRNlBQMmtJdm9XZFBXM2FYdVdKTmxjZXVp?=
 =?utf-8?B?TFdldnZXTDlnTFhnT1RFM2VvYi9XQmMzQk5vRk1ZcFVNYUVCTmova2xOWmh1?=
 =?utf-8?B?dStUNklWekNIUU1Ea1pNTnYweHRQTG1FNXJXZzJtOTQ0aDdDYjF1cUpRTTYv?=
 =?utf-8?B?L0w0VXA5OXE4cGVLOWphdFBlNVBxa0ttK0lyaFNXdTVUVHRLUGZlYUx6UGpz?=
 =?utf-8?B?czZDOEpaZm93VHk4NGozN2QwRmdRU3MwWkNRQTBiOCsxbHEzYjEyNm9BRm5X?=
 =?utf-8?B?bFAzaUVIZENYRkZ2VVBKTjlVczJldHJYZjBZTUhFVHVGYjdXRmVOcy85aEZI?=
 =?utf-8?B?eGw2KzUwTnpzaS85TmFlb0VCREdqWU83eXBQeVFYU0dJTUpad09ncEQ3RGFM?=
 =?utf-8?B?V1l1SXhhVHdsUkJteVdDSXNTeGpRZWExbXdZcHhWMFZMQ0VMbWw4YmRPaDhM?=
 =?utf-8?B?VmNzMmY5L1p3ZzlJMGJsSE52S3ZVcEhIZDhpeHBhUnZQZklUYUFsNm0yeWRk?=
 =?utf-8?B?MkM3U2tqdldPNlJHeGRubEFqbnhUS3gyN0lRd0NYanpoRWJzcklTUlFVZmdC?=
 =?utf-8?B?c3Avb0NnYjBCUmhZamNkazN6SjB2dUpRNjRERnNaVW9pRWtMbFQxRmRxK21Z?=
 =?utf-8?B?Z0Vidm5rVFBvZTdFSTVUV0ZDRGVieHdLVWREc3NjWmZOL1NsV1ZjQktpcWRW?=
 =?utf-8?B?eTJRWFNJM0lTMThOUjBaWmk0amF3bkphRDJud1lSSy9ucEZJMVpmZTZGWWUv?=
 =?utf-8?B?ZzRLZEZJa3doTU5lU0EwZ2lkbUpqTWkvQ1R1bXBTN3pRbmdIL0dPQWc4WkRG?=
 =?utf-8?B?OVRES1N2T1V2blBtUERYWURUaW1xa3F0K04vSjRhbEp5a3NhMDZNOE5LRjVN?=
 =?utf-8?B?ZCs5TkNKNG04R2htajVXVjZGVEZNdGkrY2h3MkF5T1VvZXpUbWVwUE9SSEdE?=
 =?utf-8?B?RlJQa1RzcmErZXp0dGFiSUlYS29VU2NoM3MyYitGM20rU1hxQWpwSEk0UjlF?=
 =?utf-8?B?Uy9CYVB5K0xhL1Z1NVVZS1M2U3hPVS9CYkRxTGc4WHRvc25nNW03ZE1lRVpv?=
 =?utf-8?B?RHduY1BTWFNCUUxUdFFSNzUyekdBZWdqTERFTkRIdmRxbjAvalRqaWV4Y2dp?=
 =?utf-8?B?dlNUa3VCQ0dBKzZOTEdTS2tFVUdkNCtaQlR5Mk44K1JPVUhyVEtBWlFPQlRP?=
 =?utf-8?B?RTdjU2lSc2doWXhrbGxCcC9YREJQYXdQQlJIbTBPLzRtcUVJcDZoTkJBcHNT?=
 =?utf-8?B?WCt0SmZvaWk5K1hGVzVEOHRMN2E1OFdhelpXTXBwWGxRQ2RRaXBQTXlGOUJp?=
 =?utf-8?B?RFlsMUhPQWVmMXNJbG9EK0dsY3JMMnpDS01rSVJWUTlKV2tzU3N6Wkt2T2d1?=
 =?utf-8?B?d0Rlcnh0YVN4NXRmR3hwTE9jLzZWTW9CZU4zV3pNalNiL25GdktEdUViY1Zu?=
 =?utf-8?B?RnVHRitGMEphdFBqV084NnhSb25kYTAvOGFuVElKSnFqWXF5MUd4QUJSbHY3?=
 =?utf-8?B?cXFMbjZ5dVlYOUI2L0R5MGtmYVlQTklYREtScXlNODEvQ1V2SnF5d0pmdHMz?=
 =?utf-8?B?S2dtQ3RGWXF4RUlIbC9mNWZnbFF0NG8rODkzc3FGUmdkQUJGZCs5aTc5R1l3?=
 =?utf-8?B?cWg0QjEzT21lNFFvZUR3NVpmMlk1RFgzUStiUWVSZlpKbnV4QVBMM2RsNjlz?=
 =?utf-8?B?cXhaeXFWbG03NmlYZFZZTFh4eVFNN01rQlJibWhUYWFtZzVZYTVHeVludHVm?=
 =?utf-8?B?b09mVXRzK2l5dGd0QVBlSnBrL1BSd2VLWDMvNFpFWkpjOUE2YXljQWhzbmZ1?=
 =?utf-8?B?RzBhVU12S3k2NHBEeGxFdzZEWEduekQyTXVyVGZkL1pxZGxwSzRYalhMV3Ji?=
 =?utf-8?B?WjNTZ1BqSENlUlBWNUtuMnNuL2o1cEtsdnNIZDl3d1lXYWhVL0RDaTFod3BL?=
 =?utf-8?B?WitycnRkcnJkeXU5d2pLVEE1Um5iRU5YdmxsbXVKNHl6ZUp1NE40L08zUFhX?=
 =?utf-8?Q?aalkLjdhZY/jjcUcll3QmLM=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a8a63eb-537f-45cc-3076-08de1d764c02
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 20:51:45.4246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E2mJDGH7vlOSSkGASGGGG3gzJGxB3pqOkNWx9JdPc0WV5GnyjchK8SrrEF6G1IY9fUk3d/8PTtNmjzlJ4p3BVTyMvkT2FCI5GdwtmAnxPP4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR01MB7126



On 11/6/25 8:09 AM, Ryan Roberts wrote:
> Tidy up the implementation of force_pte_mapping() to make it easier to
> read and introduce the split_leaf_mapping_possible() helper to reduce
> code duplication in split_kernel_leaf_mapping() and
> arch_kfence_init_pool().
>
> Suggested-by: David Hildenbrand (Red Hat) <david@kernel.org>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

Reviewed-by: Yang Shi <yang@os.amperecomputing.com>

Thanks,
Yang

> ---
>   arch/arm64/mm/mmu.c | 43 +++++++++++++++++++++++--------------------
>   1 file changed, 23 insertions(+), 20 deletions(-)
>
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 652bb8c14035..2ba01dc8ef82 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -710,12 +710,26 @@ static int split_kernel_leaf_mapping_locked(unsigned long addr)
>   
>   static inline bool force_pte_mapping(void)
>   {
> -	bool bbml2 = system_capabilities_finalized() ?
> +	const bool bbml2 = system_capabilities_finalized() ?
>   		system_supports_bbml2_noabort() : cpu_supports_bbml2_noabort();
>   
> -	return (!bbml2 && (rodata_full || arm64_kfence_can_set_direct_map() ||
> -			   is_realm_world())) ||
> -		debug_pagealloc_enabled();
> +	if (debug_pagealloc_enabled())
> +		return true;
> +	if (bbml2)
> +		return false;
> +	return rodata_full || arm64_kfence_can_set_direct_map() || is_realm_world();
> +}
> +
> +static inline bool split_leaf_mapping_possible(void)
> +{
> +	/*
> +	 * !BBML2_NOABORT systems should never run into scenarios where we would
> +	 * have to split. So exit early and let calling code detect it and raise
> +	 * a warning.
> +	 */
> +	if (!system_supports_bbml2_noabort())
> +		return false;
> +	return !force_pte_mapping();
>   }
>   
>   static DEFINE_MUTEX(pgtable_split_lock);
> @@ -725,22 +739,11 @@ int split_kernel_leaf_mapping(unsigned long start, unsigned long end)
>   	int ret;
>   
>   	/*
> -	 * !BBML2_NOABORT systems should not be trying to change permissions on
> -	 * anything that is not pte-mapped in the first place. Just return early
> -	 * and let the permission change code raise a warning if not already
> -	 * pte-mapped.
> -	 */
> -	if (!system_supports_bbml2_noabort())
> -		return 0;
> -
> -	/*
> -	 * If the region is within a pte-mapped area, there is no need to try to
> -	 * split. Additionally, CONFIG_DEBUG_PAGEALLOC and CONFIG_KFENCE may
> -	 * change permissions from atomic context so for those cases (which are
> -	 * always pte-mapped), we must not go any further because taking the
> -	 * mutex below may sleep.
> +	 * Exit early if the region is within a pte-mapped area or if we can't
> +	 * split. For the latter case, the permission change code will raise a
> +	 * warning if not already pte-mapped.
>   	 */
> -	if (force_pte_mapping() || is_kfence_address((void *)start))
> +	if (!split_leaf_mapping_possible() || is_kfence_address((void *)start))
>   		return 0;
>   
>   	/*
> @@ -1039,7 +1042,7 @@ bool arch_kfence_init_pool(void)
>   	int ret;
>   
>   	/* Exit early if we know the linear map is already pte-mapped. */
> -	if (!system_supports_bbml2_noabort() || force_pte_mapping())
> +	if (!split_leaf_mapping_possible())
>   		return true;
>   
>   	/* Kfence pool is already pte-mapped for the early init case. */


